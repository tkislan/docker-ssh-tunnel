#!/bin/sh -ex

if [[ -z "${SERVER_HOST}" ]]; then
  echo "SERVER_HOST environment variable missing"
  exit 1
fi

SERVER_PORT=${SERVER_PORT:-22}
REMOTE_PORT=${REMOTE_PORT:-8080}
HOST=${HOST:-localhost}
HOST_PORT=${HOST_PORT:-8080}

if [ ! -f /root/.ssh/id_rsa ]; then
  /usr/bin/ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
fi

cat /root/.ssh/id_rsa.pub

rm -vf /root/.ssh/known_hosts

# Start SSH connection
exec /usr/bin/ssh -N -o "ExitOnForwardFailure yes" -o "ServerAliveInterval=60" -p "${SERVER_PORT}" -R "${REMOTE_PORT}":"${HOST}":"${HOST_PORT}" tunnel@"${SERVER_HOST}"

FROM nocodb/nocodb

ARG litestream_version="v0.3.9"
ARG litestream_binary_tgz_filename="litestream-${litestream_version}-linux-amd64-static.tar.gz"

RUN wget "https://github.com/benbjohnson/litestream/releases/download/${litestream_version}/${litestream_binary_tgz_filename}"
RUN tar -xvzf "${litestream_binary_tgz_filename}"
RUN rm "litestream-${litestream_version}-linux-amd64-static.tar.gz"

COPY docker_entrypoint /usr/src/app/docker_entrypoint
COPY litestream.yml /etc/litestream.yml

RUN ["chmod", "+x", "/usr/src/app/docker_entrypoint"]

# Frequency that database snapshots are replicated.
ENV DB_SYNC_INTERVAL="1s"

ENTRYPOINT ["/usr/src/app/docker_entrypoint"]
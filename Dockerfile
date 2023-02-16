ARG         base=alpine/git:2.36.3

###

FROM        ${base} as build

ARG         version=
ARG         repo=cli/cli
ARG         arch=amd64

WORKDIR     /usr/local

RUN         apk add --virtual .build-deps \
                tar && \
            wget -O - https://github.com/${repo}/releases/download/v${version}/gh_${version}_linux_${arch}.tar.gz | tar xz --strip-components=1

###

FROM        ${base}

ENTRYPOINT  ["gh"]

COPY        --from=build /usr/local/bin /usr/local/bin
COPY        --from=build /usr/local/bin /usr/local/share

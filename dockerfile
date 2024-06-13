FROM ubuntu

RUN cd /home/ && mkdir actions-runner && cd actions-runner

ARG URL
ARG TOKEN

WORKDIR /home/actions-runner

RUN apt-get update && apt-get install -y curl jq git libicu74 rsync sudo

RUN curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz

RUN tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz

# Switch to non-root user

RUN ./bin/installdependencies.sh

RUN useradd -m actions

USER actions

RUN ./config.sh --url $URL --token $TOKEN

CMD ./run.sh
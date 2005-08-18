Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVHRWFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVHRWFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVHRWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:05:15 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:49839 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932485AbVHRWFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:05:14 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.5 bug? per-socket TCP keepalive settings
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <15927.1124402851.0@highlab.com>
Date: Thu, 18 Aug 2005 16:07:32 -0600
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1E5sXs-00048w-Rv@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15927.1124402851.1@highlab.com>

I'm seeing a problem with TCP keepalive behavior in 2.6.12.5.

Linux provides 3 non-standard TCP socket options for tweaking the
keepalive behavior of individual sockets: TCP_KEEPIDLE, TCP_KEEPCNT,
and TCP_KEEPINTVL.  The values set on a socket with these options should
override the system-wide default.

Depending on how you set these three knobs, it sometimes does the right
thing and sometimes does the wrong thing.

The right thing is to wait IDLE seconds, then send CNT probes INTVL
seconds apart, then reset the TCP connection.

The wrong behavior I'm seeing is the first probe goes out on schedule,
and sometimes a few more probes go out on schedule, but then it stops
sending anything at all.  It doesnt send the last of the probes, and it
doesnt send the reset.  The connection is stuck in the ESTABLISHED state,
according to netstat.

The behavior seems to be the same for sockets established by accepting
an incoming connection and sockets established by connecting to a server
out on the net.

I've attached my test program and the results of some test runs.

For these tests I run my test program, it makes a TCP connection and
sets the keepalive options then calls pause().  Pull the network cable
and watch the packet sniffer.

Let me know if I can do anything to help track this down, though I'm
going to be traveling and will be slow to respond until Monday August 29.


-- 
Sebastian Kuzminsky


------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15927.1124402851.2@highlab.com>
Content-Description: keepalive.c


#include <errno.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/tcp.h>


int main(int argc, char *argv[]) {
    char *hostname = "www.cnn.com";
    char *port = "80";

    int idle = 60;
    int count = 6;
    int interval = 10;

    int sock;

    struct addrinfo hints, *ai0, *ai;

    int opt;
    socklen_t optsize;

    int r;


    for (argc = 1; argv[argc] != NULL; argc ++) {
        if (strcmp(argv[argc], "--idle") == 0) {
            argc ++;
            idle = atoi(argv[argc]);

        } else if (strcmp(argv[argc], "--count") == 0) {
            argc ++;
            count = atoi(argv[argc]);

        } else if (strcmp(argv[argc], "--interval") == 0) {
            argc ++;
            interval = atoi(argv[argc]);

        } else {
            printf("usage: %s [--idle X] [--count X] [--interval X]\n", argv[0]);
            exit(1);
        }
    }
 

    //
    // connect
    //

    memset(&hints, 0, sizeof(hints));
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    if (getaddrinfo(hostname, port, &hints, &ai)) {
        printf("can't find %s: %s", hostname, gai_strerror(r));
        exit(1);
    }

    for (ai0 = ai; ai; ai = ai->ai_next) {
        sock = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
        if (sock < 0) {
            continue;
        }
        if (connect(sock, ai->ai_addr, ai->ai_addrlen) < 0) {
            close(sock);
            sock = -1;
            continue;
        }
        break;
    }

    if (sock < 0) {
        printf("cannot connect to %s:%s\n", hostname, port);
        exit(1);
    }


    // 
    // set the socket options
    //

    opt = 1;
    r = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &opt, sizeof(opt));
    if (r < 0) {
        printf("error enabling keepalive: %s\n", strerror(errno));
    }


    r = setsockopt(sock, ai->ai_protocol, TCP_KEEPIDLE, &idle, sizeof(idle));
    if (r < 0) {
        printf("error setting keepalive idle time to %d: %s\n", idle, strerror(errno));
    }
    opt = -1;
    optsize = sizeof(opt);
    r = getsockopt(sock, ai->ai_protocol, TCP_KEEPIDLE, &opt, &optsize);
    if (r < 0) {
        printf("error getting keepalive idle time: %s\n", strerror(errno));
    } else {
        printf("keepalive idle time: %d\n", opt);
    }


    r = setsockopt(sock, ai->ai_protocol, TCP_KEEPCNT, &count, sizeof(count));
    if (r < 0) {
        printf("error setting keepalive probe count to %d: %s\n", count, strerror(errno));
    }
    opt = -1;
    optsize = sizeof(opt);
    r = getsockopt(sock, ai->ai_protocol, TCP_KEEPCNT, &opt, &optsize);
    if (r < 0) {
        printf("error getting keepalive probe count: %s\n", strerror(errno));
    } else {
        printf("keepalive probe count: %d\n", opt);
    }


    r = setsockopt(sock, ai->ai_protocol, TCP_KEEPINTVL, &interval, sizeof(interval));
    if (r < 0) {
        printf("error setting keepalive probe interval to %d: %s\n", interval, strerror(errno));
    }
    opt = -1;
    optsize = sizeof(opt);
    r = getsockopt(sock, ai->ai_protocol, TCP_KEEPINTVL, &opt, &optsize);
    if (r < 0) {
        printf("error getting keepalive probe interval: %s\n", strerror(errno));
    } else {
        printf("keepalive probe interval: %d\n", opt);
    }


    while (1) {
        pause();
    }

    return 0;
}



------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15927.1124402851.3@highlab.com>
Content-Description: test results



Failure:

    keepalive idle time: 60
    keepalive probe count: 6
    keepalive probe interval: 10

    14:20:29.842918 IP 128.138.158.139.55241 > 128.138.158.131.22: . ack 1 win 1460 <nop,nop,timestamp 18421038 25364172>
    14:20:29.848884 IP 128.138.158.131.22 > 128.138.158.139.55241: P 1:43(42) ack 1 win 5792 <nop,nop,timestamp 25364173 18421038>
    14:20:29.848958 IP 128.138.158.139.55241 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 18421044 25364173>

    [*** pull plug on B ***]

    14:21:29.839127 IP 128.138.158.139.55241 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 18481044 25364173>

    [*** then nothing ***]

    So the first probe goes out fine, then nothing.


Failure: 

    keepalive idle time: 10
    keepalive probe count: 6
    keepalive probe interval: 10

    14:34:58.373950 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 1 win 1460 <nop,nop,timestamp 19289701 25451025>
    14:34:58.379770 IP 128.138.158.131.22 > 128.138.158.139.48848: P 1:43(42) ack 1 win 5792 <nop,nop,timestamp 25451025 19289701>
    14:34:58.379835 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19289707 25451025>

    [*** pull plug on B ***]

    14:35:08.377644 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19299707 25451025>
    14:35:18.376148 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19309707 25451025>
    14:35:28.374607 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19319707 25451025>
    14:35:38.373120 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19329707 25451025>
    14:35:48.371585 IP 128.138.158.139.48848 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19339707 25451025>

    [*** then nothing ***]


Success:

    keepalive idle time: 10
    keepalive probe count: 3
    keepalive probe interval: 5

    14:44:18.536603 IP 128.138.158.139.41102 > 128.138.158.131.22: . ack 1 win 1460 <nop,nop,timestamp 19849949 25507041>
    14:44:18.542476 IP 128.138.158.131.22 > 128.138.158.139.41102: P 1:43(42) ack 1 win 5792 <nop,nop,timestamp 25507041 19849949>
    14:44:18.542537 IP 128.138.158.139.41102 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19849955 25507041>

    [one probe just to see it work]

    14:44:28.540486 IP 128.138.158.139.41102 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19859955 25507041>
    14:44:28.540772 IP 128.138.158.131.22 > 128.138.158.139.41102: . ack 1 win 5792 <nop,nop,timestamp 25508041 19849955>

    [pull the plug on B]

    14:44:38.538944 IP 128.138.158.139.41102 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19869955 25508041>
    14:44:43.538206 IP 128.138.158.139.41102 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19874955 25508041>
    14:44:48.572597 IP 128.138.158.139.41102 > 128.138.158.131.22: . ack 43 win 1460 <nop,nop,timestamp 19879990 25508041>
    14:44:53.572534 IP 128.138.158.139.41102 > 128.138.158.131.22: R 1:1(0) ack 43 win 1460 <nop,nop,timestamp 19884990 25508041>

    Textbook behavior.



------- =_aaaaaaaaaa0--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSLFPDx>; Fri, 6 Dec 2002 10:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSLFPDx>; Fri, 6 Dec 2002 10:03:53 -0500
Received: from [204.178.40.224] ([204.178.40.224]:34952 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261872AbSLFPDv>; Fri, 6 Dec 2002 10:03:51 -0500
Date: Fri, 6 Dec 2002 10:13:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
In-Reply-To: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1021206100055.21648A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Dec 2002, Tomas Szepe wrote about choosing a source ip.
If you are writing the application, it is in fact quite trivial.
I found that, although no networking or 'sockets' programming
books I have read ever bind a client's socket to an address, only
a server's, it can be done as the included code shows. It seems
to work fine (although aparently not well documented). I'm not
sure it's 'legal', but it works on Linux-2.4.18 and SunOS 5.5.1.
It does not work with windsock, but who cares.

#ifdef _MSC_VER
#define WINDOWS
#else
#define LINUX
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <errno.h>
#include <time.h>

#ifdef LINUX
#include <sys/socket.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>
#endif
#ifdef WINDOWS
#include <winsock.h>
#include <io.h>
typedef unsigned long off_t;
#define ENONET 0x100
#define sleep(x) Sleep((x) * 1000L)
#endif

#define FAIL -1
#define ERRORS(s) {  \
    fprintf(stderr, "Error on line %d, file, %s, call %s (%s)\n", \
    __LINE__,__FILE__,(s),strerror(errno)); \
}

int main(int argc, char *argv[]) {
    struct sockaddr_in dst, src;
    struct hostent *hp;
    int s, on;

#ifdef WINDOWS
    WSADATA wsadata;
    (void)WSAStartup(MAKEWORD(2,0), &wsadata);
#endif

    if(argc < 3) {
        printf("Usage:\n %s source destination\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    memset(&src, 0x00, sizeof(src));
    memset(&dst, 0x00, sizeof(dst));
    if((hp = gethostbyname(argv[1])) == NULL)
    {
       errno = ENONET;
       ERRORS("gethostbyname");
    }
    src.sin_addr.s_addr = *((unsigned long *) *hp->h_addr_list);
    src.sin_family = AF_INET;
    if((hp = gethostbyname(argv[2])) == NULL) {
       errno = ENONET;
       ERRORS("gethostbyname");
    }
    dst.sin_addr.s_addr = *((unsigned long *) *hp->h_addr_list);
    dst.sin_family = AF_INET;
    dst.sin_port = htons(IPPORT_TELNET);
    if ((s = socket(AF_INET, SOCK_STREAM, 0)) == FAIL)
        ERRORS("socket");
    on = 1;
    if(setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) == FAIL)
        ERRORS("setsockopt");
    if(bind(s, &src, sizeof(src)) == FAIL)
        ERRORS("bind");
    if((connect(s, (struct sockaddr *) &dst, (int) sizeof(dst))) == FAIL)
        ERRORS("connect");
    fprintf(stdout,"Connected to %s, waiting...", argv[2]);
    fflush(stdout);
    pause();
    (void)close(s);
    return 0;
}


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133007AbRDKVjE>; Wed, 11 Apr 2001 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133006AbRDKViz>; Wed, 11 Apr 2001 17:38:55 -0400
Received: from [216.33.104.134] ([216.33.104.134]:22799 "HELO mail.lig.net")
	by vger.kernel.org with SMTP id <S133007AbRDKVim>;
	Wed, 11 Apr 2001 17:38:42 -0400
Message-ID: <3AD4C6A6.AB6F23F8@lig.net>
Date: Wed, 11 Apr 2001 17:03:34 -0400
From: "Stephen D. Williams" <sdw@lig.net>
Organization: CCI / Insta, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1dp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Antill <james@and.org>
Cc: Michael Lindner <mikel@att.net>, Chris Wedgwood <cw@f00f.org>,
        Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data    
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no>
		<015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net>
		<20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net>
		<3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph>
		<20010121133433.A1112@metastasis.f00f.org> <3A6A558D.5E0CF29E@att.net>
		<3AD1CD13.F1A917FA@lig.net> <nnbsq5opdz.fsf@code.and.org>
		<3AD35119.D1C5E90D@lig.net> <nng0fgmri0.fsf@code.and.org>
Content-Type: multipart/mixed;
 boundary="------------D79222604B0A8D465CA36F69"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D79222604B0A8D465CA36F69
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

James Antill wrote:
...
> >                                                                    The
> > time went from 3.7 to 4.4 seconds per 100000.
> 
>  Ok here's a quick test that I've done. This passes data between 2
> processes. Obviously you can't compare this to your code or Michael's,
> however...

I've attached my version of his code with your suggested change. 
Possibly I didn't do it correctly.

>  The results with USE_DOUBLE_POLL on are...
> 
> % time ./pingpong
> ./pingpong  0.15s user 0.89s system 48% cpu 2.147 total
> % time ./pingpong
> ./pingpong  0.19s user 0.91s system 45% cpu 2.422 total
> % time ./pingpong
> ./pingpong  0.10s user 1.02s system 49% cpu 2.282 total
> 
>  The results with USE_DOUBLE_POLL off are...
> 
> % time ./pingpong
> ./pingpong  0.24s user 1.07s system 50% cpu 2.614 total
...

sdw
-- 
sdw@lig.net  http://sdw.st
Stephen D. Williams
43392 Wayside Cir,Ashburn,VA 20147-4622 703-724-0118W 703-995-0407Fax 
Dec2000
--------------D79222604B0A8D465CA36F69
Content-Type: text/plain; charset=us-ascii;
 name="sockperf.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sockperf.c"


#include <fcntl.h>
#include <memory.h>
#include <netdb.h>
#include <netinet/in.h>
#include <signal.h>
#include <stdio.h>
#include <sys/select.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <varargs.h>
#include <netinet/in.h>
#include <netdb.h>
#include <errno.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <unistd.h>
#include <netinet/tcp.h>


#ifndef INADDR_NONE
#define INADDR_NONE     ~0
#endif

void
errexit(format, va_alist)
char    *format;
va_dcl
{
        va_list args;
        va_start(args);
        vfprintf(stderr, format, args);
        va_end(args);
        exit(1);
}

/*
 * passivesock - allocate & bind a server socket using TCP or UDP
 */

int
passivesock( service, protocol, qlen )
char    *service;       /* service associeted with the desired port     */
char    *protocol;      /* name of protocol to use ("tcp" or "udp")     */
int     qlen;           /* maximum length of the server request queue   */
{
        struct servent *pse;
        struct protoent *ppe;
        struct sockaddr_in sin;
        int     s, type;
        int     one = 1;
        int f=1;

        bzero((char *) & sin, sizeof(sin));
        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = INADDR_ANY;

        /* Map service name to port number */
        if ( pse = getservbyname(service, protocol) )
                sin.sin_port = htons(ntohs((u_short)pse->s_port));
        else if ( (sin.sin_port = htons((u_short)atoi(service))) == 0 )
                errexit("can't get \"%s\" service entry\n", service);

        /* Map protocol name to protocol number */
        if ( (ppe = getprotobyname(protocol)) == 0)
                errexit("can't get \"%s\" protocol entry\n", protocol);

        /* Use protocol to chose a socket type */
        if (strcmp(protocol, "udp") == 0)
                type = SOCK_DGRAM;
        else
                type = SOCK_STREAM;

        /* Allocate a socket */
        s = socket(PF_INET, type, ppe->p_proto);
        if (s < 0 )
                errexit("can't create socket: %s\n", strerror(errno));

        setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
        setsockopt(s, SOL_TCP, TCP_NODELAY, &f, sizeof(f));
        /* Bind the socket */
        if (bind(s, (struct sockaddr *) & sin, sizeof(sin)) < 0)
                errexit("can't bind to %s port: %s\n", service,
                    strerror(errno));
        if (type == SOCK_STREAM && listen(s, qlen) < 0)
                errexit("can't listen on %s port: %s\n", service,
                    strerror(errno));
        return s;
}

int
connectsock(host, service, protocol)
char    *host;
char    *service;
char    *protocol;
{
        struct hostent  *phe;
        struct servent  *pse;
        struct protoent *ppe;
        struct sockaddr_in      sin;
        int     s, type;
        int f=1;

        memset(&sin, 0, sizeof(sin));
        if (pse = getservbyname(service, protocol))
                sin.sin_port = pse->s_port;
        else if ((sin.sin_port = htons((u_short) atoi(service))) == 0) {
                fprintf(stderr, "can't get '%s' service entry\n", service);
                exit(1);
        }
        if (phe = gethostbyname(host)) 
                memcpy((char *) &sin.sin_addr, phe->h_addr, phe->h_length);
        else if ((sin.sin_addr.s_addr = inet_addr(host)) == INADDR_NONE) {
                fprintf(stderr, "can't get '%s' host entry\n", host);
                exit(1);
        }
        /* if (ppe = getprotobyname(protocol)) {
                fprintf(stderr, "can't get '%s' protocol entry\n", protocol);
                exit(1);
        }
        if (strcmp(protocol, "udp") == 0)
                type = SOCK_DGRAM;
        else
                type = SOCK_STREAM;
        */
        sin.sin_family = AF_INET;
        s = socket(AF_INET, SOCK_STREAM, 6);
        setsockopt(s, SOL_TCP, TCP_NODELAY, &f, sizeof(f));
        if (s < 0) {
                perror("can't create socket\n");
                exit(1);
        }
        if (connect(s, (struct sockaddr *) &sin, sizeof(sin)) < 0) {
                perror("can't connect to socket");
                exit(1);
        }
        return s;
}

void
pingpong(int r, int s, int ping)
{
        struct timeval then;
        struct timeval now;
        fd_set fds;
        fd_set readfds;
        int pings = 0;
	struct timeval zerotime;
	int ret;

        FD_ZERO(&fds);
        FD_SET(r, &fds);
        gettimeofday(&then, 0);
        if (ping) {
                send(s, ".", 1, 0);
                pings++;
        }
        readfds = fds;

	zerotime.tv_sec = 0;
	zerotime.tv_usec = 0;

	//	if (!(ret = select( ... , &zerotime)))
	//  ret = select( ... , NULL);
	//        while ((readfds=fds, ret = select(r+1, &readfds, 0, 0, 0)) ) {
	while ((ret = select(r+1, &readfds, 0, 0, &zerotime)) ||
	       (readfds=fds, ret = select(r+1, &readfds, 0, 0, 0)) ) {
	       if (FD_ISSET(r, &readfds)) {
                        char buf[1];
                        int n = read(r, buf, sizeof(buf));
                        if (n <= 0) {
                                break;
                        }
                        else {
                                if (pings++ < 100000) {
                                        send(s, ".", 1, 0);
                                }
                                else {
                                        break;
                                }
                        }
                }
                else {
                        fprintf(stderr, "fd not set!\n");
                }
                readfds = fds;
        }
        gettimeofday(&now, 0);
        fprintf(stderr, "elapsed time for 100000 pingpongs is %g\n", now.tv_sec - then.tv_sec + (now.tv_usec -
then.tv_usec) / 1000000.0);
        fprintf(stderr, "closing %d\n", r);
        close(r);
        fprintf(stderr, "closing %d\n", s);
        close(s);
}

main(argc, argv)
int     argc;
char    **argv;
{
        char    buf[1024];
        int     n;
        int     s;
        int     f;
        if (argc < 3) {
                errexit("usage: %s host port1 port2 [initiate]\n", argv[0]);
        }
        signal(SIGPIPE, SIG_IGN);
        f = passivesock(argv[2], "tcp", 2);
        if (f < 0) {
                errexit("listen failed: %s\n", strerror(errno));
        }
        for ( ; ; ) {
                struct sockaddr_in      fsin;
                int     alen = sizeof(fsin);
                if (argc < 5) {
                        int     r = accept(f, (struct sockaddr *) &fsin, &alen);
                        int     s = connectsock(argv[1], argv[3], "tcp");
                        if (r < 0)
                                errexit("accept failed: %s\n", strerror(errno));
                        if (s < 0)
                                errexit("connect failed: %s\n", strerror(errno));
                        pingpong(r, s, 0);
                }
                else {
                        int     s = connectsock(argv[1], argv[3], "tcp");
                        int     r = accept(f, (struct sockaddr *) &fsin, &alen);
                        if (r < 0)
                                errexit("accept failed: %s\n", strerror(errno));
                        if (s < 0)
                                errexit("connect failed: %s\n", strerror(errno));
                        pingpong(r, s, 1);
                        break;
                }
        }
        return 0;
}

--------------D79222604B0A8D465CA36F69--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136768AbRATHmG>; Sat, 20 Jan 2001 02:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137164AbRATHl4>; Sat, 20 Jan 2001 02:41:56 -0500
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:29433 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S136768AbRATHlk>; Sat, 20 Jan 2001 02:41:40 -0500
Message-ID: <3A694254.B52AE20B@att.net>
Date: Sat, 20 Jan 2001 02:46:28 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data 
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org>
Content-Type: multipart/mixed;
 boundary="------------EF2174A08E061DBE445265D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EF2174A08E061DBE445265D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Chris Wedgwood wrote:
> 
> You can measure this latency; and it's indeed very low (lmbench gives
> 28 usecs on one of my machines).
> 
> If you don't see this I would suspect an application bug -- can you
> use strace or some such and confirm this is not the case?

OK, two new data points (thanks for staying with me here):

1. The problem only occurs when traffic is travelling over DIFFERENT
sockets (i.e. A->B->C->D... or A->B->A but using a separate socket for
traffic in each direction).

2. I wrote a very ugly program (attached) to reproduce the problem. Lest
you think ill of me, most of this isn't actual code I wrote (the actual
program that first reproduced the problem was in C++). Just run

	sockperf localhost 54321 54322
	sockperf localhost 54322 54321 1

to see it in action.

--
Mike Lindner
--------------EF2174A08E061DBE445265D0
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


#ifndef INADDR_NONE
#define INADDR_NONE	~0
#endif

void
errexit(format, va_alist)
char	*format;
va_dcl
{
	va_list	args;
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
char	*service;	/* service associeted with the desired port	*/
char	*protocol;	/* name of protocol to use ("tcp" or "udp")	*/
int	qlen;		/* maximum length of the server request queue	*/
{
	struct servent *pse;
	struct protoent *ppe;
	struct sockaddr_in sin;
	int	s, type;
	int	one = 1;

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
char	*host;
char	*service;
char	*protocol;
{
	struct hostent	*phe;
	struct servent	*pse;
	struct protoent	*ppe;
	struct sockaddr_in	sin;
	int	s, type;

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
	FD_ZERO(&fds);
	FD_SET(r, &fds);
	gettimeofday(&then, 0);
	if (ping) {
		send(s, ".", 1, 0);
		pings++;
	}
	readfds = fds;
	while (select(r+1, &readfds, 0, 0, 0) > 0) {
		if (FD_ISSET(r, &readfds)) {
			char buf[1];
			int n = read(r, buf, sizeof(buf));
			if (n <= 0) {
				break;
			}
			else {
				if (pings++ < 1000) {
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
	fprintf(stderr, "elapsed time for 1000 pingpongs is %g\n", now.tv_sec - then.tv_sec + (now.tv_usec - then.tv_usec) / 1000000.0);
	fprintf(stderr, "closing %d\n", r);
	close(r);
	fprintf(stderr, "closing %d\n", s);
	close(s);
}

main(argc, argv)
int	argc;
char	**argv;
{
	char	buf[1024];
	int	n;
	int	s;
	int	f;
	if (argc < 3) {
		errexit("usage: %s host port1 port2 [initiate]\n", argv[0]);
	}
	signal(SIGPIPE, SIG_IGN);
	f = passivesock(argv[2], "tcp", 2);
	if (f < 0) {
		errexit("listen failed: %s\n", strerror(errno));
	}
	for ( ; ; ) {
		struct sockaddr_in	fsin;
		int	alen = sizeof(fsin);
		if (argc < 5) {
			int	r = accept(f, (struct sockaddr *) &fsin, &alen);
			int	s = connectsock(argv[1], argv[3], "tcp");
			if (r < 0)
				errexit("accept failed: %s\n", strerror(errno));
			if (s < 0)
				errexit("connect failed: %s\n", strerror(errno));
			pingpong(r, s, 0);
		}
		else {
			int	s = connectsock(argv[1], argv[3], "tcp");
			int	r = accept(f, (struct sockaddr *) &fsin, &alen);
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

--------------EF2174A08E061DBE445265D0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132083AbQLNKmF>; Thu, 14 Dec 2000 05:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132128AbQLNKl4>; Thu, 14 Dec 2000 05:41:56 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:11826
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S132083AbQLNKlw>; Thu, 14 Dec 2000 05:41:52 -0500
Date: Thu, 14 Dec 2000 02:10:44 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Lattner <sabre@nondot.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001214021044.C6380@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Lattner <sabre@nondot.org>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Alexander Viro <viro@math.psu.edu>,
	"Mohammad A. Haque" <mhaque@haque.net>,
	Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org,
	orbit-list@gnome.org, korbit-cvs@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0012132025310.24483-100000@www.nondot.org> <E146VE3-00043s-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <E146VE3-00043s-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Alan DID not say this:]
> > There is a large perception of CORBA being slow, but for the most part it
> > is unjustified.  

Really?  I have that same perception but I can't claim that I've measured it.
On the other hand, I have measured the overhead of straight UDP, TCP, and
Sun RPC ping/pong tests and you can find the code for that in any version
of lmbench.  It should be a 5 minute task for someone who groks corba to
do the same thing using the same framework.  If someone wants to do it,
I'll guide them through the lmbench stuff.  It's pretty trivial, start 
with this as a guide:
/*
 * tcp_xact.c - simple TCP transaction latency test
 *
 * Three programs in one -
 *	server usage:	tcp_xact -s
 *	client usage:	tcp_xact hostname
 *	shutdown:	tcp_xact -hostname
 *
 * Copyright (c) 1994 Larry McVoy.  Distributed under the FSF GPL with
 * additional restriction that results may published only if
 * (1) the benchmark is unmodified, and
 * (2) the version in the sccsid below is included in the report.
 * Support for this development by Sun Microsystems is gratefully acknowledged.
 */
char	*id = "$Id$\n";

#include "bench.h"

void	client_main(int ac, char **av);
void	doserver(int sock);
void	doclient(int sock);
void	server_main(int ac, char **av);
void	doserver(int sock);

int
main(int ac, char **av)
{
	if (ac != 2) {
		fprintf(stderr, "Usage: %s -s OR %s [-]serverhost\n",
		    av[0], av[0]);
		exit(1);
	}
	if (!strcmp(av[1], "-s")) {
		if (fork() == 0) {
			server_main(ac, av);
		}
		exit(0);
	} else {
		client_main(ac, av);
	}
	return(0);
}

void
client_main(int ac, char **av)
{
	int     sock;
	char	*server;
	char	buf[100];

	if (ac != 2) {
		fprintf(stderr, "usage: %s host\n", av[0]);
		exit(1);
	}
	server = av[1][0] == '-' ? &av[1][1] : av[1];
	sock = tcp_connect(server, TCP_XACT, SOCKOPT_NONE);

	/*
	 * Stop server code.
	 */
	if (av[1][0] == '-') {
		close(sock);
		exit(0);
	}

	BENCH(doclient(sock), MEDIUM);
	sprintf(buf, "TCP latency using %s", av[1]);
	micro(buf, get_n());
	exit(0);
	/* NOTREACHED */
}

void
doclient(int sock)
{
	char    c;

	write(sock, &c, 1);
	read(sock, &c, 1);
}

void
child()
{
	wait(0);
	signal(SIGCHLD, child);
}

void
server_main(int ac, char **av)
{
	int     newsock, sock;

	if (ac != 2) {
		fprintf(stderr, "usage: %s -s\n", av[0]);
		exit(1);
	}
	GO_AWAY;
	signal(SIGCHLD, child);
	sock = tcp_server(TCP_XACT, SOCKOPT_NONE);
	for (;;) {
		newsock = tcp_accept(sock, SOCKOPT_NONE);
		switch (fork()) {
		    case -1:
			perror("fork");
			break;
		    case 0:
			doserver(newsock);
			exit(0);
		    default:
			close(newsock);
			break;
		}
	}
	/* NOTREACHED */
}

void
doserver(int sock)
{
	char    c;
	int	n = 0;

	while (read(sock, &c, 1) == 1) {
		write(sock, &c, 1);
		n++;
	}

	/*
	 * A connection with no data means shut down.
	 */
	if (n == 0) {
		tcp_done(TCP_XACT);
		kill(getppid(), SIGTERM);
		exit(0);
	}
}
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQL2QHh>; Fri, 29 Dec 2000 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbQL2QH1>; Fri, 29 Dec 2000 11:07:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31552 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129465AbQL2QHO>; Fri, 29 Dec 2000 11:07:14 -0500
Date: Fri, 29 Dec 2000 16:36:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jure Pecar <pegasus@telemach.net>
Cc: linux-kernel@vger.kernel.org, jef@acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229163645.B12791@athlon.random>
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net> <20001229032953.A9810@athlon.random> <3A4C4E16.52AAAFE1@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A4C4E16.52AAAFE1@telemach.net>; from pegasus@telemach.net on Fri, Dec 29, 2000 at 09:40:54AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 09:40:54AM +0100, Jure Pecar wrote:
> problem on a similary configured 2.2.17 with VM-global patch 3. gcc

Good. Can you try to reproduce with 2.2.19pre3? (if you absolutely need raid
0.90 you can try again with 2.2.19pre3aa3 after backing out 04_wake-one-3 that
introduces a deadlocks spotted by Chris and that I'm debugging right now)

> select(7, [5], [6], NULL, {98, 547000}) = 1 (in [5], left {98, 210000})

	num_ready = fdwatch( tmr_mstimeout( &tv ) );
	if ( num_ready < 0 )
	    {
	    if ( errno == EINTR )
		continue;       /* try again */
	    syslog( LOG_ERR, "fdwatch - %m" );
	    exit( 1 );
	    }

> gettimeofday({978078109, 324744}, NULL) = 0

	(void) gettimeofday( &tv, (struct timezone*) 0 );

> accept(5, {sin_family=AF_INET, sin_port=htons(3687),
> sin_addr=inet_addr("62.76.36.242")}, [16]) = 7

httpd_get_conn( httpd_server* hs, int listen_fd, httpd_conn* hc )
[..]
    hc->conn_fd = accept( listen_fd, &sa.sa, &sz );

> fcntl(7, F_SETFD, FD_CLOEXEC)           = 0

    (void) fcntl( hc->conn_fd, F_SETFD, 1 );

> fcntl(7, F_GETFL)                       = 0x2 (flags O_RDWR)

	flags = fcntl( c->hc->conn_fd, F_GETFL, 0 );

> fcntl(7, F_SETFL, O_RDWR|O_NONBLOCK)    = 0

	else if ( fcntl( c->hc->conn_fd, F_SETFL, flags | O_NDELAY ) < 0 )

> brk(0x8078000)                          = 0x8077000
> brk(0x8078000)                          = 0x8077000

for some unknown reason it doesn't notice it has to handle the new connection.

> time([978078109])                       = 978078109
> getpid()                                = 22061
> send(3, "<27>Dec 29 09:21:49 thttpd[22061"..., 69, 0) = 69

    shut_down();
    syslog( LOG_NOTICE, "exiting" );

> munmap(0x125000, 4096)                  = 0
> _exit(1)                                = ?

However according to the latest sources (2.20b) shut_down() should at least
call gettimeofday at once and that's not the case for you:

shut_down( void )
    {
    int cnum;
    struct timeval tv;

#ifdef STATS_TIME
    show_stats( JunkClientData, (struct timeval*) 0 );
#endif /* STATS_TIME */
    (void) gettimeofday( &tv, (struct timezone*) 0 );

So you aren't using thttpd version 2.20b (or it's not the vanilla source).

Well, this would look like an userspace bug, but I understand it's strange that
it works well for three days.... Can you try to upgrade thttpd to the latest
version compiled from vanilla sources?

But regardless of the userspace upgrade, I still recommend to upgrade to
2.2.19pre3 or 2.2.19pre3aa3 minus 04_wake-one-3 (once I'll fix wake-one-3 I'll
release -4 revision and pre3aa4).

Thanks,
Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

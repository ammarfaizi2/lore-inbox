Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130526AbQL2DSA>; Thu, 28 Dec 2000 22:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130524AbQL2DRv>; Thu, 28 Dec 2000 22:17:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25962 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129921AbQL2DRh>; Thu, 28 Dec 2000 22:17:37 -0500
Date: Fri, 29 Dec 2000 03:47:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jure Pecar <pegasus@telemach.net>
Cc: linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229034712.B9810@athlon.random>
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net> <20001229032953.A9810@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001229032953.A9810@athlon.random>; from andrea@suse.de on Fri, Dec 29, 2000 at 03:29:53AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 03:29:53AM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 29, 2000 at 02:32:32AM +0100, Jure Pecar wrote:
> > Hi all,
> > 
> > I'm expiriencing a problem with thttpd web server
> > (www.acme.com/software/thttpd) on recent linux 2.2 kernels with Andrea's

I downloaded the sources right now to see what 'out of memory' means. I assume
you were using version 2.20b.

> out of memory looks an userspace message, so it looks like malloc request was

My guess was right, it's not possible to know where it came from though:

andrea@athlon:~/devel/thttpd-2.20b > grep 'out of' *.c
fdwatch.c:** or 0 if the timeout expired, or -1 on errors.  A timeout of INFTIM
means
libhttpd.c:     syslog( LOG_CRIT, "out of memory" );
libhttpd.c:         syslog( LOG_CRIT, "out of memory" );
libhttpd.c:         syslog( LOG_CRIT, "out of memory" );
libhttpd.c:     syslog( LOG_CRIT, "out of memory" );
libhttpd.c:         syslog( LOG_CRIT, "out of memory" );
libhttpd.c:         syslog( LOG_CRIT, "out of memory" );
libhttpd.c:     syslog( LOG_ERR, "out of memory" );
libhttpd.c:     ** since it's impossible to get out of the tree.  However, we still
libhttpd.c:                     syslog( LOG_ERR, "out of memory" );
libhttpd.c:     syslog( LOG_ERR, "out of memory" );
thttpd.c:       syslog( LOG_CRIT, "out of memory" );
thttpd.c:       syslog( LOG_CRIT, "out of memory" );
thttpd.c:       (void) fprintf( stderr, "%s: out of memory\n", argv0 );
thttpd.c:               syslog( LOG_CRIT, "out of memory" );
thttpd.c:               (void) fprintf( stderr, "out of memory\n" );
thttpd.c:           syslog( LOG_CRIT, "out of memory" );
thttpd.c:           (void) fprintf( stderr, "out of memory\n" );
thttpd.c:               syslog( LOG_CRIT, "out of memory" );
andrea@athlon:~/devel/thttpd-2.20b >

But luckily it always happens after some kind of memory allocation, so it's
going to be the overcommit check of mmap that is complaining as I guessed
(assuming glibc isn't buggy in your system).

I was thinking I have a minor fix (in aa patchkit) that can help if the problem
happens while you are quite near to use all the memory (swap included) and you
have very low level of buffercache and pagecache.  But I don't think you were
near the out of memory condition, right? (can you monitor via `vmstat 1 >log`
to be sure?) It addresses more a correctness issue than a real life problem.
And if it was a real life problem then you can workaround it with `echo 1
>/proc/sys/vm/overcommit_memory' without need to apply the real fix and
recompile the kernel (but again: I don't think this is the problem, setting
overcommit_memory to 1 would probably only temporarly hide the problem, you
would probably get the task killed by the kernel some time later anyways)

BTW, after checking the sources we at least know it wasn't due memory
fragmentation (fork complains with a different message).

Andrea

PS. I'm very suprised thttpd isn't threaded, it should really be threaded at
    least on the x86 family to run fast.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

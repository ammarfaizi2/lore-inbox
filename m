Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVJLVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVJLVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVJLVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:15:59 -0400
Received: from devrace.com ([198.63.210.113]:36624 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964818AbVJLVP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:15:59 -0400
Date: Wed, 12 Oct 2005 23:15:31 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, boi@boi.at,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Message-ID: <20051012211531.GA4068@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>, boi@boi.at,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <434CC144.6000504@boi.at> <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com> <1129127947.8561.44.camel@lade.trondhjem.org> <81b0412b0510120810o6d06a678q1d4a9787687b9bfa@mail.gmail.com> <Pine.LNX.4.61.0510121112060.4302@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510121112060.4302@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson), Wed, Oct 12, 2005 17:20:26 +0200:
> >>>> flock, lockf, fcntl do not return even after the signal SIGALRM  has
> >>>> been raised and the signal handler function has been executed
> >>>> the functions should return with a return value EWOULDBLOCK as described
> >>>> in the man pages
> >>
> >> Works for me on a local filesystem.
> >>
> >> Desktop$ ./gnurr gnarg
> >> locking...
> >> timeout
> >
> > Doesn't look so. I'd expect "flock: EWOULDBLOCK" and "sleeping" after
> > the first timeout.

It's EINTR, btw.

linux-os (Dick Johnson), Wed, Oct 12, 2005 17:20:26 +0200:
> As I told you, you use sigaction(). Also flock() will not block
> unless there is another open on the file. The code will run to
> your blocking read(), wait 10 seconds, get your "timeout" from
> the signal handler, then read() will return with -1 and ERESTARTSYS
> in errno as required.

Ahh yes, of course. signal(2) places a syscall-restarting handler in glibc.
My bad, sorry.

For the last time:

// everything works as expected, flock returns with EINTR in the
// second instance of the program.
#include <unistd.h>
#include <sys/time.h>
#include <sys/file.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>

void alrm(int sig)
{
     write(2, "timeout\n", 8);
}

int main(int argc, char* argv[])
{
     struct itimerval tv = {
         .it_interval = {.tv_sec = 10, .tv_usec = 0},
         .it_value    = {.tv_sec = 10, .tv_usec = 0},
     };
     struct sigaction sa = { .sa_handler = alrm, .sa_flags = 0 };
     sigaction(SIGALRM, &sa, NULL);
     setitimer(ITIMER_REAL, &tv, NULL);
     int fd = open(argv[1], O_RDWR);
     if ( fd < 0 ) {
         perror(argv[1]);
         return 1;
     }
     printf("locking...\n");
     if ( flock(fd, LOCK_EX) < 0 ) {
         perror("flock");
         return 1;
     }
     printf("sleeping...\n");
     int ch;
     while ( read(0, &ch, 1) < 0 && EINTR == errno )
	 ;
     close(fd);
     return 0;
}


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbRGKP6n>; Wed, 11 Jul 2001 11:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbRGKP6d>; Wed, 11 Jul 2001 11:58:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:42314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267341AbRGKP6O>; Wed, 11 Jul 2001 11:58:14 -0400
Date: Wed, 11 Jul 2001 17:58:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <andrewm@uow.edu.au>, Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
Message-ID: <20010711175809.F3496@athlon.random>
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here> <shslmlv62us.fsf@charged.uio.no> <3B4C56F1.3085D698@uow.edu.au> <15180.24844.687421.239488@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15180.24844.687421.239488@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jul 11, 2001 at 04:22:04PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 04:22:04PM +0200, Trond Myklebust wrote:
> >>>>> " " == Andrew Morton <andrewm@uow.edu.au> writes:
> 
>      > Trond Myklebust wrote:
>     >>
>     >> ...  I have the same problem on my setup. To me, it looks like
>     >> the loop in spawn_ksoftirqd() is suffering from some sort of
>     >> atomicity problem.
> 
>      > Does a `set_current_state(TASK_RUNNING);' in spawn_ksoftirqd()
>      > fix it?  If so we have a rogue initcall...
> 
> Nope. The same thing happens as before.
> 
> A couple of debugging statements show that ksoftirqd_CPU0 gets created
> fine, and that ksoftirqd_task(0) is indeed getting set correctly
> before we loop in spawn_ksoftirqd().
> After this the second call to kernel_thread() succeeds, but
> ksoftirqd() itself never gets called before the hang occurs.

ksoftirqd is quite scheduler intensive, and while its startup is
correct (no need of any change there), it tends to trigger scheduler
bugs (one of those bugs was just fixed in pre5). The reason I never seen
the deadlock I also fixed this other scheduler bug in my tree:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre5aa1/00_sched-yield-1

this one I forgot to sumbit but here it is now for easy merging:

--- 2.4.4aa3/kernel/sched.c.~1~	Sun Apr 29 17:37:05 2001
+++ 2.4.4aa3/kernel/sched.c	Tue May  1 16:39:42 2001
@@ -674,8 +674,10 @@
 #endif
 	spin_unlock_irq(&runqueue_lock);
 
-	if (prev == next)
+	if (prev == next) {
+		current->policy &= ~SCHED_YIELD;
 		goto same_process;
+	}
 
 #ifdef CONFIG_SMP
  	/*


Andrea

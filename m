Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbRGKQxT>; Wed, 11 Jul 2001 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbRGKQxK>; Wed, 11 Jul 2001 12:53:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24406 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267351AbRGKQxA>; Wed, 11 Jul 2001 12:53:00 -0400
Date: Wed, 11 Jul 2001 18:53:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <andrewm@uow.edu.au>, Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
Message-ID: <20010711185308.J3496@athlon.random>
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here> <shslmlv62us.fsf@charged.uio.no> <3B4C56F1.3085D698@uow.edu.au> <15180.24844.687421.239488@charged.uio.no> <20010711175809.F3496@athlon.random> <15180.32563.739560.194630@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15180.32563.739560.194630@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jul 11, 2001 at 06:30:43PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 06:30:43PM +0200, Trond Myklebust wrote:
> >>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:
> 
>      > ksoftirqd is quite scheduler intensive, and while its startup
>      > is correct (no need of any change there), it tends to trigger
>      > scheduler bugs (one of those bugs was just fixed in pre5). The
>      > reason I never seen the deadlock I also fixed this other
>      > scheduler bug in my tree:
> 
>      > --- 2.4.4aa3/kernel/sched.c.~1~ Sun Apr 29 17:37:05 2001
>      > +++ 2.4.4aa3/kernel/sched.c Tue May 1 16:39:42 2001
>      > @@ -674,8 +674,10 @@
>      >  #endif
>      >  	spin_unlock_irq(&runqueue_lock);
>  
>      > - if (prev == next)
>      > + if (prev == next) {
>      > + current->policy &= ~SCHED_YIELD;
>      >  		goto same_process;
>      > + }
>  
>      >  #ifdef CONFIG_SMP
>      >   	/*
> 
> I no longer see the hang with this patch, but I'm not sure I
> understand why it works.

I do. It's very subtle and it goes down to the fork and scheduler
details.

> Does the above mean that the hang is occuring because spawn_ksoftirqd
> is yielding back to itself? If so, the semaphore trick seems more

No, that's a generic bug.

> robust, as it causes a proper sleep until it's safe to wake up.

rwsem is definitenly not more robust than the current code, if something
it hides if sched_yield is broken in the scheduler. no need to change
it wasting some static ram for a rwsem for no good reason.

The bug is that sched_yield must always be cleared at the time of a
fork() or the child may never get schedule. Only tasks running in-cpu are
allowed to have SCHED_YIELD set.

Another way to cure the deadlock could be to clear SCHED_YIELD in the child so
then you could even do something as silly as:

	current->policy |= SCHED_YIELD;
	fork()
	schedule()

but the above doesn't make sense so we can optimize away the clear of
SCHED_YIELD of the child in fork. And even if you allow the above you
still need my attached fix for performance reason because if schedule()
returns that's all for the last sched_yield try, the next time we run
schedule without specifying sched_yield we don't want it to be threated
like a sched_yield again (that was the original reason of the patch
infact, I noticed now that the bug had very serious implication with
fork, such implication won't trigger only with ksoftirqd but also with
normal userspace forks, it's only that with ksoftirqd banging of the
scheduler it becomes reproducible).

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291215AbSBGSly>; Thu, 7 Feb 2002 13:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291218AbSBGSlX>; Thu, 7 Feb 2002 13:41:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:26127 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291210AbSBGSk6>;
	Thu, 7 Feb 2002 13:40:58 -0500
Subject: Re: [RFC] New locking primitive for 2.5
From: Robert Love <rml@tech9.net>
To: Martin Wirth <Martin.Wirth@dlr.de>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@transmet.com,
        mingo@elte.hu, nigel@nrg.org
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 13:40:59 -0500
Message-Id: <1013107259.10430.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-07 at 10:38, Martin Wirth wrote:
> This is a request for comment on a new locking primitive
> called a combilock.

Interesting ...

The question I raise is, how many locks do we have where we have a
single resource we lock where in some codepaths the lock is used for
short duration and in other places the lock is long-duration?

It would be useful to identify a few locks where this would benefit and
apply the appropriate combi variant and do some benchmarking.

Some of the talk I've heard has been toward an adaptive lock.  These are
locks like Solaris's that can spin or sleep, usually depending on the
state of the lock's holder.  Another alternative, which I prefer since
it is much less overhead, is a lock that spins-then-sleeps
unconditionally.

> If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> attempt also sleeps i.e. behaves like a semaphore.
> If you gained ownership of the lock, you can switch between spin-mode
> and mutex-(ie.e sleeping) mode by calling:

This can be bad.  What if I grab a spinlock in a codepath where only a
spinlock is appropriate (i.e. somewhere I can't sleep, like an irq
handler) -- and then I sleep?

> Note: For a preemptible kernel this approach could lead to much less
> scheduling ping-pong also for UP if a spinlock is replaced by a
> combilock instead of a semaphore.

Very true ... but only assuming we can find locks where there are
differing profiles of use.

> Open questions:
> 
>   * Does it make sense to also provide irq-save versions of the
>     locking functions? This means you could use the unlock functions
>     from interrupt context. But the main use in this situation is
>     completion handling and there are already (new) completion handlers
>     available. So I don't think this is a must have.

You can't sleep in an interrupt request handler, so this wouldn't make a
lot of sense.

>   * I there any need to provide non exclusive versions of the waiting
>     functions? For real-time applications this would lead to an
>     automatic selection of the highest priority task that's waiting
>     for the lock. But on the other hand it leads to a lot of unnecessary
>     scheduling and I doubt it's really worth it. But maybe there are
>     other good reasons to wakeup all waiters.

Non-exclusive wakeups are common ... see the uses of normal wake_up vs
wake_up_exclusive.

> To really take any benefit from a preemptible kernel a lot of spin locks
> will have to be replaced by mutex locks. The combi-lock approach may
> convince more people who typically fear the higher scheduling pressure
> of sleeping locks to do so, if they can decide on each instance which
> approach (spin of sleep) will be taken.

We shouldn't engage in wholesale changing of spinlocks to semaphores
without a priority-inheritance mechanism.  And _that_ is the bigger
issue ...

	Robert Love


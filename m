Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUK1Pzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUK1Pzh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUK1Pzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:55:37 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:25040 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261501AbUK1PzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:55:17 -0500
Date: Sun, 28 Nov 2004 16:55:13 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041128084250.GC9814@elte.hu>
Message-Id: <Pine.OSF.4.05.10411281630010.23754-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with your analysis: 
There is no need to change the way the mutex is passed to the new task as
the current implementation does give an upper bound. Also it works the
same way on SMP and UP. It also performs better. The situations where the
bound really is 2^N-1, N>2, are very rare if they exist at all.

There is a tiny "however" I want to mention, though. Who will use a Linux
kernel with real-time performance? People who want a RT application and at
the same time want to deploy normal Linux applications. The criteria for
the RT system to work is that even if you put on heavy loads of normal
applications the RT application still schedules fine.
It is very unlikely that anyone will try to calculate wether it schedules
or not. It is much more common that people just test it in the lab and
then thrust that the real-time properties of the the system not to change
when you go into deployment. 

The problem now is that in a test you wont see many lower priority 
threads trying to get a locked region -- as we have seen, it
is hard to make such a test even for an "academic", bad driver. I.e. you
don't see the 2^N-1 behaviour in the test. In deployment, however, you
might in some circumstanses see it and thus degrade the real-time
performance. On the other hand even with a locking depth of 4 we go up to
a factor 15 for the very worst case behaviour. Hopefully,
people leave room enough in real-time application to be able to tolerate
that!

Esben

On Sun, 28 Nov 2004, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > 	task-A		task-B		task-C		task-RT
> > > 	-------------------------------------------------------
> 
> > > 	[ 1 ms ]			.		.
> > > 	UL-1				.		.
> > > 					get-L1		.
> > > 	UL-2						.
> 
> > Now I see it! The reason is that task-C is _given_ the lock by task A.
> > The action of transfering the lock from A to C is done in A's context
> > with RT-prio. 
> 
> correct.
> 
> > My line of thinking was that although task-C is in the wait queue of
> > lock1 it still actively have to go in and _take_ the lock. In that
> > kind of setup task-RT would get i first on UP.
> 
> Trying to exclude all locking activity by 'lesser' tasks (unrelated to
> the higher-prio tasks) while a higher-prio task is running is a quite
> fragile concept i believe, and it's also pointless: just think about
> SMP, or an RT task sleeping for short periods of time for whatever
> reason.
> 
> This effect can be very well avoided by taking both locks, and this also
> better matches the real locking scenarios that happen in the Linux
> kernel.
> 
> > [...] I have a detailed description of such
> > a design below but first I have to point out that the formula for the
> > worst case delay is not
> >  N*(N+1)/2
> > but
> >  2^N-1
> 
> ok.
> 
> > I.e.
> >    N      f(N)
> >    0        0
> >    1        1
> >    2        3
> >    3        7
> >    4       15
> > 
> > My tests doesn't show that - but it requires 2^N tasks to reproduce. I
> > am trying to do that now.
> 
> note that it's (probably worse than-) exponentially more unlikely for a
> test to be able to generate the worst-case.
> 
> > Ok, back to a design making
> >  f(N) = N
> > on UP:
> 
> why? It is quite rare for there to be even 4-deep locking structures in
> the kernel, and even then, it's even rarer that they get accessed in
> such an arbitrary-deep manner. Note that task-B can only steal the lock
> from task-A because the following locking pattern is allowed:
> 
> 	L1,UL1		[X]
> 
> besides:
> 
> 	L1,L2,UL1,UL2	[Y]
> 
> In Linux, if there's 2-deep locking, it is much more common for only [Y]
> to be allowed, for which the formula is still "f(N) = N". Or even if
> both [X] and [Y] is allowed, 3-deep or 4-deep locking with [X] and [Y]
> allowed as well is quite rare. Not only is this rare, it's _even_ rarer
> that no code within that 4-lock-protected region may end up blocking on
> an external interrupt. So what you are trying to solve is a very narrow
> case i believe.
> 
> > When I made the mutex in U9.2-priom I originally made it like that: In
> > mutex_unlock() owner was set to NULL and the first task awaken. But a
> > high priority task could at that point get in and snap the mutex in
> > front of the newly awoken task. That setup would make stuff work
> > better on UP.
> 
> we could try wakeup-retry instead of pass-lock, although pass-lock still
> feels more robust. Relying on UP-starvation to reduce your latencies is
> quite ... fragile.
> 
> Also, pass-lock performs better because the woken up task does not have
> to touch the lock structure anymore, up until it has to release it.
> (which gives the CPU(s) more time to optimize things, especially on
> SMP.) But if you send a separate patch for that alone (to implement the
> 'released' state) then we'll be able to see the costs in isolation.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


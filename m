Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUCROuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUCROuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:50:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7042
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262675AbUCROul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:50:41 -0500
Date: Thu, 18 Mar 2004 15:51:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318145129.GA2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318015004.227fddfb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 01:50:04AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Thu, Mar 18, 2004 at 05:00:01AM +0100, Marinos J. Yannikos wrote:
> > > Hi,
> > > 
> > > we upgraded a few production boxes from 2.4.x to 2.6.4 recently and the 
> > > default .config setting was CONFIG_PREEMPT=y. To get straight to the 
> > > point: according to our measurements, this results in severe performance 
> > > degradation with our typical and some artificial workload. By "severe" I 
> > > mean this:
> > 
> > this is expected (see the below email, I predicted it on Mar 2000),
> 
> Incorrectly.
> 
> > keep preempt turned off always, it's useless.
> 
> Preempt is overrated.  The infrastructure which it has introduced has been
> useful for detecting locking bugs.

yes, I agree preempt is useful to debug SMP systems on UP systems, but
it's debugging feature so it should be disabled on production systems.

> It has been demonstrated that preempt improves the average latency.  But
> not worst-case, because those paths tend to be under spinlock.

Sure, I agree it improves average latency, the problem is that there are
nearly no application that cares about average, what matters is the
worst case latency only.

> > Worst of all we're now taking spinlocks earlier than needed,
> 
> Where?  CPU scheduler?

Everywhere, see the kmaps, we spinlock before instead of spinlock after,
the scheduler, lots of places. I mean, people don't call

	preempt_disable()
	kmap_atomic
	spin_lock

they do:

	spin_lock
	kmap_atomic

so they're effectively optimizing for PREEMPT=y and I don't think this
is optimal for the long term. One can aruge the microscalability
slowdown isn't something to worry about, I certainly don't worry about
it too much either, it's more a bad coding habit to spinlock earlier
than needed to avoid preempt_disable.

> > and the preempt_count stuff isn't optmized away by PREEMPT=n,
> 
> It should be.  If you see somewhere where it isn't, please tell us.

the counter is definitely not optimized away, see:

#define inc_preempt_count() \
do { \
	preempt_count()++; \
} while (0)

#define dec_preempt_count() \
do { \
	preempt_count()--; \
} while (0)

#define preempt_count()	(current_thread_info()->preempt_count)

those are running regardless of PREEMPT=n.

This is debugging code to catch some basic preempt issue with
in_interrupt() and friends even with PREEMPT=n, but it wastes 1
cacheline per-cpu during irq handling.

> We unconditionally bump the preempt_count in kmap_atomic() so that we can
> use atomic kmaps in read() and write().  This is why four concurrent
> write(fd, 1, buf) processes on 4-way is 8x faster than on 2.4 kernels.

sorry, why should the atomic kmaps read the preempt_count? Are those ++
-- useful for anything more than debugging PREEMPT=y on a kernel
compiled with PREEMPT=n? I thought it was just debugging code with
PREEMPT=n.

I know why the atomic kmaps speedup write but I don't see how can
preempt_count help there when PREEMPT=n, the atomic kmaps are purerly
per-cpu and one can't schedule anyways while taking those kmaps (no
matter if inc_preempt_count or not).

> > preempt just wastes cpu with tons of branches in fast paths that should
> > take one cycle instead.
> 
> I don't recall anyone demonstrating even a 1% impact from preemption.  If
> preemption was really causing slowdowns of this magnitude it would of
> course have been noticed.  Something strange has happened here and more
> investigation is needed.

I'm also surprised the slowdown is so huge, maybe he tweaked the
CONFIG_SLAB at the same time of PREEMPT? ;) Anyways there is a slowdown,
and the whole point is that preempt doesn't improve the worst case
latency at all.

> > ...
> > I still think after 4 years that such idea is more appealing then
> > preempt, and numbers start to prove me right.
> 
> The overhead of CONFIG_PREEMPT is quite modest.  Measuring that is simple.

It is quite modest I agree, but there is an overhead and it doesn't
payoff.

BTW, with preempt enabled there is no guarantee that RCU can ever reach
a quiescient point and secondly there is no guarantee that you will ever
be allowed to unplug a CPU hotline since again there's no guarantee to
reach a quiescient point. Think a kernel thread doing for (;;) (i.e.
math computations in background, to avoid starving RCU the kernel thread
will have to add schedule() explicitly no matter if PREEMPT=y or
PREEMPT=n, again invalidating the point of preempt, the rcu tracking for
PREEMT=y is also more expensive).

Note, the work you and the other preempt developers did with preempt was
great, it wouldn't be possible to be certain that it wasn't worthwhile
until we had the thing working and finegrined (i.e. in all in_interrupt
etc..), and now we know it doesn't payoff and in turn I'm going to try
the explicit-preempt that is to explicitly enable preempt in a few
cpu-intensive kernel spots where we don't take locks (i.e. copy-user),
the original suggestion I did 4 years ago, I believe in such places an
explicit-preempt will work best since we've already to check every few
bytes the current->need_resched, so adding a branch there should be very
worthwhile. Doing real preempt like now is overkill instead and should
be avoided IMHO.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUCXRu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUCXRu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:50:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35742
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263795AbUCXRuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:50:50 -0500
Date: Wed, 24 Mar 2004 18:51:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Arjan van de Ven <arjanv@redhat.com>,
       tiwai@suse.de, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324175142.GW2065@dualathlon.random>
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324172657.GA1303@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 09:26:57AM -0800, Paul E. McKenney wrote:
> > > One problem that likely happen here is that under heavy interrupt
> > > load, large number of softirqs still starve out user processes.
> > 
> > Disagree, run 1 callback per tasklet and then you will not measure the
> > cost of this callback compared to the cost of talking to the hardware
> > entering/exiting kernel etc...
> 
> The difficult situation is when the workload generates -lots- of
> RCU callbacks, such as the tiny-files workload that Andrew pointed
> Dipankar at.  In this case, if we rely only on softirq, we are between
> a rock and a hard place.  The rock is that if we run too many
> softirq handlers processing all the RCU callbacks, we will degrade
> realtime response.  The hard place is that if we delay softirq
> processing in order to avoid degrading realtime response, we
> risk having RCU callbacks piling up, exhausting memory.
> 
> This situation is what motivated using a per-CPU kernel daemon to
> handle the "overflow" callbacks that could not handled by softirq
> without degrading realtime response.  Since the kernel daemon is
> preemptible, it can run continuously without degrading realtime
> response -- it will be preempted whenever a realtime task needs
> to run.  Therefore, the kernel-daemon approach permits safely
> processing RCU callbacks up to the full capacity of the CPU.

and it tends to runs the machine OOM if there's a single RT application
generating the dcache load ;).

> My guess is that the small-file creation/deletion workload can
> generate on the order of 100K RCU callbacks per second, and perhaps
> as many as 1M RCU callbacks per second on a fast CPU.  The kernel
> daemon approach should be able to handle this load gracefully.

running 1 callback per softirq (and in turn 10 callbacks per hardware
irq) shouldn't be measurable compared to the cost of the hardware
handling, skb memory allocation, iommu mapping etc... 

why do you care about this specific irq-flood corner case where the load
is lost in the noise and there's no way to make it scheduler-friendy
either since hardware irqs are involved?

the only way to make that workload scheduler friendly, is to bind the
irq of the network card to cpu 1 and to bind the RT app to cpu0, no
other way around it, no matter where you run the rcu callbacks (if in
irq context, or non-irq context).

> Of course, it would be possible to insert preemption points in
> the kernel daemon should we choose to support realtime response
> in absence of CONFIG_PREEMPT.

2.6 support realtime response with PREEMPT=y and =n, infact preempt
doesn't affect the worst case RT latency at all, it can't.

So you shouldn't relay on preempt to avoid explicit schedule points
there.

> That said, it may well be necessary to use IPIs in some cases,
> as rcu-poll does, to accelerate RCU grace periods.  For example,
> if low on memory or if too many callbacks have accumulated.
> If this ends up being necessary, it might get the best of both
> worlds, since one would shorten grace periods only when there
> are already a lot of callbacks, so that the overhead would be
> nicely amortized.  It will be interesting to see how this goes!

I'm not sure in this case if IPI are needed just for offloading the
remaining work to a rearming tasklet.

> > > In my DoS testing setup, I see that limiting RCU softirqs 
> > > and re-arming tasklets has no effect on user process starvation.
> > 
> > in an irq flood load that stalls userspace anyways it's ok to spread the
> > callback load into the irqs, 10 tasklets and in turn 10 callbacks per
> > irqs or so. That load isn't scheduler friendly anyways.
> 
> The goal is to run reasonably, even under this workload, which, as you
> say is not scheduler friendly.  Scheduler hostile, in fact.  ;-)

Indeed it is, and I'm simply expecting not any real difference by
running 10 callbacks per hardware irq, so I find it a non very
interesting workload to choose between a softirq or the kernel thread,
but maybe I'm overlooking something.

> > the one property you need is not to be RT like eventd, to be scheduler
> > friendly, but guaranteed to make progress too and that's what softirqs
> > can give you and that's why I used only softirqs in my rcu_poll
> > patches too ;). 
> 
> The problem is that some of the workloads generate thousands of
> RCU callbacks per grace period.  If we are going to provide
> realtime scheduling latencies in the hundreds of microseconds, we
> probably aren't going to get away with executing all of these
> callbacks in softirq context.

it should, you just need to run 1 callback per re-arming tasklet (then
after the list is empty you stop re-arming), the softirq code will do
the rest for you offloading it immediatly to ksoftirqd after 10
callbacks, and ksoftirqd will reschedule explicitly once every 10
callbacks too. The whole point of ksoftirqd is to make re-arming
tasklets irq-friendy. Though there's a cost in offloading the work to a
daemon, so we must not do it too frequently, so we retry 10 times before
giving up and claiming the tasklet re-entrant.

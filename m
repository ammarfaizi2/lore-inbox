Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUCXR1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUCXR1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:27:07 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:48424 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S263787AbUCXR1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:27:02 -0500
Date: Wed, 24 Mar 2004 09:26:57 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Arjan van de Ven <arjanv@redhat.com>,
       tiwai@suse.de, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324172657.GA1303@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323125044.GL22639@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One problem that likely happen here is that under heavy interrupt
> > load, large number of softirqs still starve out user processes.
> 
> Disagree, run 1 callback per tasklet and then you will not measure the
> cost of this callback compared to the cost of talking to the hardware
> entering/exiting kernel etc...

The difficult situation is when the workload generates -lots- of
RCU callbacks, such as the tiny-files workload that Andrew pointed
Dipankar at.  In this case, if we rely only on softirq, we are between
a rock and a hard place.  The rock is that if we run too many
softirq handlers processing all the RCU callbacks, we will degrade
realtime response.  The hard place is that if we delay softirq
processing in order to avoid degrading realtime response, we
risk having RCU callbacks piling up, exhausting memory.

This situation is what motivated using a per-CPU kernel daemon to
handle the "overflow" callbacks that could not handled by softirq
without degrading realtime response.  Since the kernel daemon is
preemptible, it can run continuously without degrading realtime
response -- it will be preempted whenever a realtime task needs
to run.  Therefore, the kernel-daemon approach permits safely
processing RCU callbacks up to the full capacity of the CPU.
My guess is that the small-file creation/deletion workload can
generate on the order of 100K RCU callbacks per second, and perhaps
as many as 1M RCU callbacks per second on a fast CPU.  The kernel
daemon approach should be able to handle this load gracefully.

Of course, it would be possible to insert preemption points in
the kernel daemon should we choose to support realtime response
in absence of CONFIG_PREEMPT.

That said, it may well be necessary to use IPIs in some cases,
as rcu-poll does, to accelerate RCU grace periods.  For example,
if low on memory or if too many callbacks have accumulated.
If this ends up being necessary, it might get the best of both
worlds, since one would shorten grace periods only when there
are already a lot of callbacks, so that the overhead would be
nicely amortized.  It will be interesting to see how this goes!

> > In my DoS testing setup, I see that limiting RCU softirqs 
> > and re-arming tasklets has no effect on user process starvation.
> 
> in an irq flood load that stalls userspace anyways it's ok to spread the
> callback load into the irqs, 10 tasklets and in turn 10 callbacks per
> irqs or so. That load isn't scheduler friendly anyways.

The goal is to run reasonably, even under this workload, which, as you
say is not scheduler friendly.  Scheduler hostile, in fact.  ;-)

> the one property you need is not to be RT like eventd, to be scheduler
> friendly, but guaranteed to make progress too and that's what softirqs
> can give you and that's why I used only softirqs in my rcu_poll
> patches too ;). 

The problem is that some of the workloads generate thousands of
RCU callbacks per grace period.  If we are going to provide
realtime scheduling latencies in the hundreds of microseconds, we
probably aren't going to get away with executing all of these
callbacks in softirq context.

					Thanx, Paul

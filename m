Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUIOKJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUIOKJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUIOKJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:09:17 -0400
Received: from holomorphy.com ([207.189.100.168]:50330 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264346AbUIOKJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:09:10 -0400
Date: Wed, 15 Sep 2004 03:09:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915100903.GL9106@holomorphy.com>
References: <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au> <20040915061922.GA11683@elte.hu> <4147FC14.2010205@yahoo.com.au> <20040915084355.GA29752@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915084355.GA29752@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:43:55AM +0200, Ingo Molnar wrote:
> the 'final' preemption model [for hard-RT purposes] that i believe will
> make it into the Linux kernel one nice day is total preemptability of
> everything but the core preemption code (i.e. the scheduler and
> interrupt controllers). _That_ might be something that has provable
> latencies. Note that such a 'total preemption' model has prerequisites
> too, like the deterministic execution of hardirqs/softirqs.

I don't see deterministic execution time of hardirqs/softirqs happening
on stock hardware and without serious driver work, and I don't see much
hard RT ever happening on SMP due to lock contention. But maybe that
just means it's difficult.


On Wed, Sep 15, 2004 at 10:43:55AM +0200, Ingo Molnar wrote:
> note that the current lock-break-up activities still make alot of sense
> even under the total-preemption model: it decreases the latency of
> kernel-using hard-RT applications. (raw total preemption only guarantees
> quick scheduling of the hard-RT task - it doesnt guarantee that the task
> can complete any useful kernel/syscall work.)

One reason I'm not complaining is because voluntary switching is
required to reschedule in otherwise non-preemptible critical sections.


On Wed, Sep 15, 2004 at 10:43:55AM +0200, Ingo Molnar wrote:
> since we already see at least 4 different viable preemption models
> placed on different points in the 'latency reliability' spectrum, it
> makes little sense to settle for any of them. So i'm aiming to keep the
> core code flexible to have them all without much fuss, and usage will
> decide which ones are needed. Maybe CONFIG_PREEMPT will merge into
> CONFIG_TOTAL_PREEMPT. Maybe CONFIG_NO_PREEMPT will merge into
> CONFIG_PREEMPT_VOLUNTARY. Maybe CONFIG_PREEMPT_VOLUNTARY will go away
> altogether. We cannot know at this point, it all depends on how usage
> (and consequently, hardware) evolves.

Well, one thing that completely voluntary context switch -based
critical section management tells us that reliance on implicit kernel
preemption doesn't is which codepaths matter: whatever codepaths would
need to be preempted implicitly then explicitly show up as latency
blips on the latency instrumentation radar screen, and by so doing at
least get annotated with "this codepath matters for latency" and
whoever may inadvertently try to extend a nonpreemptible critical
section over the scheduling point will have a big "stop" sign in front
of them.  So, even if CONFIG_PREEMPT is the way and the annotations are
nops there, the annotation of latency-critical scheduling points, even
where they would be preemptible with CONFIG_PREEMPT=y, has value.

And, of course, the preemption reenablement required for voluntary
yielding from non-preemptible critical sections also has a positive
operational effect with CONFIG_PREEMPT=y, so there is nothing in VP
that doesn't also benefit CONFIG_PREEMPT.


-- wli

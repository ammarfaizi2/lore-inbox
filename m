Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUBFXOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUBFXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:14:32 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29919 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265828AbUBFXOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:14:30 -0500
Message-Id: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Fri, 06 Feb 2004 14:42:28 PST."
             <225230000.1076107348@flay> 
Date: Fri, 06 Feb 2004 15:11:39 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    OK, but do you agree that the rate we rebalance things like 2 vs 1 should
    be slower than the rate we rebalance 3 vs 1 ? Fairness is only relevant
    over a long term imbalance anyway, so there should be a big damper on
    "fairness only" rebalances.

I think, given the precision we're granted via SCHED_LOAD_SCALE, in
combination with the new "load average" (cpu_load) code, that we can
achieve what we want.

If cpu0 has 2 runnable tasks and cpu1 has 1 runnable task, won't we see
the "load average" of cpu0 slowly approach 2, but not jump there?

Right now, we round up on all fractions and Martin has proposed a patch
which takes it the other way and rounds down.  What if in marginal
cases like this where this is a small but persistent difference, we
could bump the task to another cpu when it reaches (say) 1.8 or 1.9?
That would keep it there longer for shorter-lived tasks, but for those
long-runners, they'd eventually spread the pain around a little.

And yes, a cpu_load of even 1.0 should *never* get migrated to a cpu
with a load 0.0.  Instead of

    *imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;

how about, for instance,

    if (max_load <= SCHED_LOAD_SCALE)
	*imbalance = 0;
    else
	*imbalance = (*imbalance + (SCHED_LOAD_SCALE / 6) - 1)
	    >> SCHED_LOAD_SHIFT;

The intent is to never move anything if max_load is 1 or less (what
advantage is there?) and to create a slight tendency to round up at
loads greater than that, which would still tend to leave things where
they were until they'd been there a while.  In fact the "bonus"
(SCHED_LOAD_SCALE / 6 - 1) could be another configurable in the scheduling
domain so that at some level you're not interested in fairness and
they just don't bounce at all.

Rick

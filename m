Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266998AbUBFXXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUBFXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:21:17 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:4530 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266988AbUBFXU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:20:58 -0500
Message-ID: <40242152.5030606@cyberone.com.au>
Date: Sat, 07 Feb 2004 10:20:50 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com>
In-Reply-To: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:

>    OK, but do you agree that the rate we rebalance things like 2 vs 1 should
>    be slower than the rate we rebalance 3 vs 1 ? Fairness is only relevant
>    over a long term imbalance anyway, so there should be a big damper on
>    "fairness only" rebalances.
>
>I think, given the precision we're granted via SCHED_LOAD_SCALE, in
>combination with the new "load average" (cpu_load) code, that we can
>achieve what we want.
>
>If cpu0 has 2 runnable tasks and cpu1 has 1 runnable task, won't we see
>the "load average" of cpu0 slowly approach 2, but not jump there?
>
>

Yep

>Right now, we round up on all fractions and Martin has proposed a patch
>which takes it the other way and rounds down.  What if in marginal
>cases like this where this is a small but persistent difference, we
>could bump the task to another cpu when it reaches (say) 1.8 or 1.9?
>That would keep it there longer for shorter-lived tasks, but for those
>long-runners, they'd eventually spread the pain around a little.
>
>And yes, a cpu_load of even 1.0 should *never* get migrated to a cpu
>with a load 0.0.  Instead of
>

This isn't the load though, but imbalance. It has already passed
through our imbalance_pct filter (or we are idle), so we can pretty
safely assume that we want to try to move at least one task.

>
>    *imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
>
>how about, for instance,
>
>    if (max_load <= SCHED_LOAD_SCALE)
>	*imbalance = 0;
>    else
>	*imbalance = (*imbalance + (SCHED_LOAD_SCALE / 6) - 1)
>	    >> SCHED_LOAD_SHIFT;
>
>The intent is to never move anything if max_load is 1 or less (what
>advantage is there?) and to create a slight tendency to round up at
>loads greater than that, which would still tend to leave things where
>they were until they'd been there a while.  In fact the "bonus"
>(SCHED_LOAD_SCALE / 6 - 1) could be another configurable in the scheduling
>domain so that at some level you're not interested in fairness and
>they just don't bounce at all.
>
>

Hopefully just tending to round down more would damp it better.
*imbalance = (*imbalance + SCHED_LOAD_SCALE/2) >> SCHED_LOAD_SHIFT;
Or even remove the addition all together.


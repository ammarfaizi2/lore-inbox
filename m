Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUHQHUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUHQHUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUHQHUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:20:20 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:12690 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S268128AbUHQHUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:20:11 -0400
Subject: Re: 2.6.8.1-mm1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1092722342.3081.68.camel@booger>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	 <1092722342.3081.68.camel@booger>
Content-Type: text/plain
Message-Id: <1092727147.27274.109.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 17:19:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 15:59, Nathan Lynch wrote:
> I can consistently hit this BUG_ON in migration_call's CPU_DEAD handling
> by doing:
> 
> while true ; do
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 1 > /sys/devices/system/cpu/cpu1/online
> done
> 
> and then starting a kernel build.  It seems to take less than 20
> minutes.  I can also recreate it on ppc64, but only with
> CONFIG_PREEMPT=y (I haven't tried without preempt on i386 yet).

Hmm, can you figure out what patch in -mm breaks it?

Looking through 2.6.8.1-mm1, I see this code which doesn't make sense:


	if (likely(cpu == this_cpu)) {
...
	} else {
		runqueue_t *this_rq = cpu_rq(this_cpu);

		/*
		 * Not the local CPU - must adjust timestamp. This should
		 * get optimised away in the !CONFIG_SMP case.
		 */
		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
					+ rq->timestamp_last_tick;
		__activate_task(p, rq);
		if (TASK_PREEMPTS_CURR(p, rq))
			resched_task(rq->curr);

		current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
			PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
		schedstat_inc(rq, wunt_moved);
	}

	if (unlikely(cpu != this_cpu)) {
		task_rq_unlock(rq, &flags);
		rq = task_rq_lock(current, &flags);
	}
	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
	task_rq_unlock(rq, &flags);
}

So, first off, the statements under "if (unlikely(cpu != this_cpu))" can
be folded into the previous block, since that's under the same test. 
Secondly, why is sleep_avg being set twice to the same thing, and why
are we happy to adjust it the first time without holding the rq lock for
current, but the second time we make sure we are holding the rq lock? 
recalc_task_prio seems happy to adjust a tasks ->sleep_avg without
holding any lock at all...

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


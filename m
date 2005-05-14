Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVENLcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVENLcq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 07:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVENLcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 07:32:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34477 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262741AbVENLcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 07:32:41 -0400
Subject: Re: Does smp_reschedule_interrupt really reschedule?
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050514063741.GA12217@elte.hu>
References: <1116008299.4728.19.camel@localhost.localdomain>
	 <20050513182631.GA15916@elte.hu>
	 <1116010280.4728.29.camel@localhost.localdomain>
	 <20050514063741.GA12217@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 14 May 2005 07:32:29 -0400
Message-Id: <1116070349.1604.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 08:37 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > In finish_task_switch, where is need_resched set?
> 
> why should it be set? It's the final portion of a context-switch, not 
> the initiator of a context-switch. need_resched is usually set by the 
> wakeup code, or by the preemption code.
> 

Sorry, I'm still not seeing it. I'll explain my confusion a little more
detailed now.

Lets say we have a SMP machine with two CPUs.  CPU0 has a RT task
running and CPU1 has a non-RT task.   A RT task wakes up on CPU0 that is
higher priority than the current running RT task on CPU0. Lets add that
this newly woken up RT task has set affinity to only run on CPU0.

So in try_to_wake_up...  Lets assume that the wake up happened on CPU1. 

	if (cpu == this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
		goto out_set_cpu;

cpu = the task's cpu = CPU0
this_cpu = CPU1

cpu_isset(this_cpu, p->cpus_allowed) returns false so we goto
out_set_cpu.

out_set_cpu:
	new_cpu = wake_idle(new_cpu, p);   <--- new_cpu would still equal cpu.
	if (new_cpu != cpu) {

	} else {
		/*
		 * If a newly woken up RT task cannot preempt the
		 * current (RT) task then try to find another
		 * CPU it can preempt:
		 */
p can preempt current, so this is also false.
		if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
			smp_send_reschedule_allbutself();
			rt_overload_wakeup++;
		}
	}


Next we activate the newly woken up RT task.

	activate_task(p, rq, cpu == this_cpu);
	if (!sync || cpu != this_cpu) {
		if (TASK_PREEMPTS_CURR(p, rq))
			resched_task(rq->curr);
	}


So now the newly woken up RT task preempts the other RT task on CPU0.

preempt_schedule is called and then schedule. 

Now the booted RT task should now be transferred to CPU1, since it can
run there, and CPU1 doesn't have a RT task running.

In finish_task_switch, we have:

#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
	/*
	 * If we pushed an RT task off the runqueue,
	 * then kick other CPUs, they might run it:
	 */
	if (unlikely(rt_task(current) && prev->array && rt_task(prev))) {
		rt_overload_schedule++;
		smp_send_reschedule_allbutself();
	}
#endif


Here's my question, where does CPU1 get need_resched set?  As discussed
earlier, smp_send_reschedule_allbutself doesn't do it.

Thanks,

-- Steve




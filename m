Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWELFup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWELFup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWELFuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:50:44 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41887 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750929AbWELFuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:50:44 -0400
Date: Fri, 12 May 2006 07:50:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
Message-ID: <20060512055025.GA25824@elte.hu>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> -		if (!cpu_isset(smp_processor_id(), irq_affinity[irq])) {
> -			mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
> -			set_cpus_allowed(current, mask);
> -		}

this is intentional, not a bug. The point of the code above is to ensure 
that every IRQ handler is executed on one CPU. I.e. the irq threads are 
semi-affine - they are strictly affine when executing a handler, but 
they may switch CPUs if the affinity mask points it elsewhere.

but ... we might be able to relax that. Potentially some IRQ handlers 
might assume per-cpu-ness, but that should be uncovered by 
DEBUG_PREEMPT's smp_processor_id() checks.

> +		if(!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
> +			set_cpus_allowed(current, irq_affinity[irq]);

> The patch below appears to correct this issue, however it also
> repeatedly(on different irqs) causes the following BUG:

ah. This actually uncovered a real bug. We were calling __do_softirq() 
with interrupts enabled (and being preemptible) - which is certainly 
bad.

this was hidden before because the smp_processor_id() debugging code 
handles tasks bound to a single CPU as per-cpu-safe.

could you check the (totally untested) patch below and see if that fixes 
things for you? I've also added your affinity change.

	Ingo

Index: linux-rt.q/kernel/irq/manage.c
===================================================================
--- linux-rt.q.orig/kernel/irq/manage.c
+++ linux-rt.q/kernel/irq/manage.c
@@ -717,24 +717,21 @@ static int do_irqd(void * __desc)
 	if (param.sched_priority > 25)
 		curr_irq_prio = param.sched_priority - 1;
 
-//	param.sched_priority = 1;
 	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		do_hardirq(desc);
 		cond_resched_all();
+		local_irq_disable();
 		__do_softirq();
-//		do_softirq_from_hardirq();
 		local_irq_enable();
 #ifdef CONFIG_SMP
 		/*
 		 * Did IRQ affinities change?
 		 */
-		if (!cpu_isset(smp_processor_id(), irq_affinity[irq])) {
-			mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
-			set_cpus_allowed(current, mask);
-		}
+		if (!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
+			set_cpus_allowed(current, irq_affinity[irq]);
 #endif
 		schedule();
 	}

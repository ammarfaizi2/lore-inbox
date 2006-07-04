Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWGDGr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWGDGr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWGDGr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:47:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19081 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750962AbWGDGr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:47:59 -0400
Date: Tue, 4 Jul 2006 08:43:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060704064307.GB2752@elte.hu>
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu> <20060703165750.GB3899@in.ibm.com> <20060704041519.GC16074@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704041519.GC16074@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> > I have been able to reproduce a similar looking oopse with 2.6.16-rt29.
> > 2.6.16-rt20 works fine. I will try to track it down to the exact
> > release as far as I can.
> 
> OK, it looks as if rt20 is fine but rt21 is broken. So something that 
> got in rt21 is causing this oops.

thanks! That really narrows it down.

> Ingo, do you have a suspect ?

I suspect it's the patch below. That patch (from John) relaxes the 
affinities of IRQ threads: if there are /proc/irq/*/smp_affinity entries 
that have multiple bits set an IRQ thread is allowed to jump from one 
CPU to another while it is executing a IRQ-handler. It _should_ be fine 
but i'd not be surprised if that caused breakage ...

if this is the cause of the crash, would be hard for you trying to 
figure out _which_ IRQ thread is so sensitive to affinity?

	Ingo

Index: linux/kernel/irq/manage.c
===================================================================
--- linux.orig/kernel/irq/manage.c
+++ linux/kernel/irq/manage.c
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

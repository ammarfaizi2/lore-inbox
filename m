Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWGDGzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWGDGzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWGDGzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:55:04 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:10982 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751077AbWGDGzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:55:02 -0400
Date: Tue, 4 Jul 2006 08:50:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060704065024.GA5789@elte.hu>
References: <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu> <20060703165750.GB3899@in.ibm.com> <20060704041519.GC16074@in.ibm.com> <20060704064307.GB2752@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704064307.GB2752@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5060]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Ingo, do you have a suspect ?
> 
> I suspect it's the patch below. That patch (from John) relaxes the 
> affinities of IRQ threads: if there are /proc/irq/*/smp_affinity 
> entries that have multiple bits set an IRQ thread is allowed to jump 
> from one CPU to another while it is executing a IRQ-handler. It 
> _should_ be fine but i'd not be surprised if that caused breakage ...

the patch below is against 2.6.17-rt5, does this solve the crashes?

	Ingo

Index: linux-rt.q/kernel/irq/manage.c
===================================================================
--- linux-rt.q.orig/kernel/irq/manage.c
+++ linux-rt.q/kernel/irq/manage.c
@@ -645,17 +645,24 @@ extern asmlinkage void __do_softirq(void
 
 static int curr_irq_prio = 49;
 
-static int do_irqd(void * __desc)
+static void follow_irq_affinity(struct irq_desc *desc)
 {
-	struct sched_param param = { 0, };
-	struct irq_desc *desc = __desc;
 #ifdef CONFIG_SMP
-	int irq = desc - irq_desc;
 	cpumask_t mask;
 
-	mask = cpumask_of_cpu(any_online_cpu(irq_desc[irq].affinity));
+	if (cpus_equal(current->cpus_allowed, desc->affinity))
+		return;
+	mask = cpumask_of_cpu(any_online_cpu(desc->affinity));
 	set_cpus_allowed(current, mask);
 #endif
+}
+
+static int do_irqd(void * __desc)
+{
+	struct sched_param param = { 0, };
+	struct irq_desc *desc = __desc;
+
+	follow_irq_affinity(desc);
 	current->flags |= PF_NOFREEZE | PF_HARDIRQ;
 
 	/*
@@ -674,13 +681,7 @@ static int do_irqd(void * __desc)
 		local_irq_disable();
 		__do_softirq();
 		local_irq_enable();
-#ifdef CONFIG_SMP
-		/*
-		 * Did IRQ affinities change?
-		 */
-		if (!cpus_equal(current->cpus_allowed, irq_desc[irq].affinity))
-			set_cpus_allowed(current, irq_desc[irq].affinity);
-#endif
+		follow_irq_affinity(desc);
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);

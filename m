Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbTGIVFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTGIVFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:05:53 -0400
Received: from palrel13.hp.com ([156.153.255.238]:54485 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266123AbTGIVFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:05:52 -0400
Date: Wed, 9 Jul 2003 14:20:29 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200307092120.h69LKTBH002759@napali.hpl.hp.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: per_cpu fixes
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

Care needs to be taken when taking the address of a CPU-local
variable, because otherwise things may break when comparing addresses
on a platform which uses virtual remapping to implement such
variables.  In particular, it's almost always unsafe to use the
address of a per-CPU variable which contains a "struct list", because
the list-manipulation routines use the list-head address to detect the
end of the list etc.

The patch below makes 2.5.74+ work on ia64 by reverting to the old
definition of this_rq().  Ditto for kernel/timer.c.

	--david

===== kernel/sched.c 1.196 vs edited =====
--- 1.196/kernel/sched.c	Wed Jul  9 11:06:25 2003
+++ edited/kernel/sched.c	Wed Jul  9 14:06:49 2003
@@ -176,7 +176,7 @@
 static DEFINE_PER_CPU(struct runqueue, runqueues);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
-#define this_rq()		(&__get_cpu_var(runqueues))
+#define this_rq()		(&cpu_rq(smp_processor_id())) /* not __get_cpu_var(runqueues)! */
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
===== kernel/timer.c 1.62 vs edited =====
--- 1.62/kernel/timer.c	Wed Jul  9 11:06:25 2003
+++ edited/kernel/timer.c	Wed Jul  9 13:30:31 2003
@@ -160,7 +160,7 @@
  */
 void add_timer(struct timer_list *timer)
 {
-	tvec_base_t *base = &get_cpu_var(tvec_bases);
+	tvec_base_t *base = &per_cpu(tvec_bases, get_cpu());
   	unsigned long flags;
   
   	BUG_ON(timer_pending(timer) || !timer->function);
@@ -171,7 +171,7 @@
 	internal_add_timer(base, timer);
 	timer->base = base;
 	spin_unlock_irqrestore(&base->lock, flags);
-	put_cpu_var(tvec_bases);
+	put_cpu();
 }
 
 /***
@@ -234,7 +234,7 @@
 		return 1;
 
 	spin_lock_irqsave(&timer->lock, flags);
-	new_base = &__get_cpu_var(tvec_bases);
+	new_base = &per_cpu(tvec_bases, smp_processor_id());
 repeat:
 	old_base = timer->base;
 
@@ -792,7 +792,7 @@
  */
 static void run_timer_softirq(struct softirq_action *h)
 {
-	tvec_base_t *base = &__get_cpu_var(tvec_bases);
+	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);

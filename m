Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWDVSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWDVSwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWDVSwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:52:43 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:40626 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750930AbWDVSwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:52:42 -0400
Date: Sat, 22 Apr 2006 08:05:04 -0700
Message-Id: <200604221505.k3MF54Lr021983@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] remove redundent checks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Don't need to check twice .. I also removed an old
printk from schedule() .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/init/main.c
===================================================================
--- linux-2.6.16.orig/init/main.c
+++ linux-2.6.16/init/main.c
@@ -727,7 +727,7 @@ static int init(void * unused)
 		prepare_namespace();
 	}
 #ifdef CONFIG_PREEMPT_RT
-	WARN_ON(irqs_disabled() || irqs_disabled());
+	WARN_ON(irqs_disabled());
 #endif
 
 #define DEBUG_COUNT (defined(CONFIG_DEBUG_RT_MUTEXES) + defined(CONFIG_DEBUG_PREEMPT) + defined(CONFIG_CRITICAL_PREEMPT_TIMING) + defined(CONFIG_CRITICAL_IRQSOFF_TIMING) + defined(CONFIG_LATENCY_TRACE) + defined(CONFIG_DEBUG_SLAB) + defined(CONFIG_DEBUG_PAGEALLOC))
@@ -794,7 +794,7 @@ static int init(void * unused)
 				ramdisk_execute_command);
 	}
 #ifdef CONFIG_PREEMPT_RT
-	WARN_ON(irqs_disabled() || irqs_disabled());
+	WARN_ON(irqs_disabled());
 #endif
 
 	/*
Index: linux-2.6.16/kernel/printk.c
===================================================================
--- linux-2.6.16.orig/kernel/printk.c
+++ linux-2.6.16/kernel/printk.c
@@ -792,7 +792,7 @@ void release_console_sem(void)
 	 * case only.
 	 */
 #ifdef CONFIG_PREEMPT_RT
-	if (!in_atomic() && !irqs_disabled() && !irqs_disabled())
+	if (!in_atomic() && !irqs_disabled())
 #endif
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
Index: linux-2.6.16/kernel/sched.c
===================================================================
--- linux-2.6.16.orig/kernel/sched.c
+++ linux-2.6.16/kernel/sched.c
@@ -3509,12 +3509,10 @@ asmlinkage void __sched schedule(void)
 	/*
 	 * Test if we have interrupts disabled.
 	 */
-	if (unlikely(irqs_disabled() || irqs_disabled())) {
+	if (unlikely(irqs_disabled())) {
 		stop_trace();
-		printk(KERN_ERR "BUG: scheduling with %s irqs disabled: "
-			"%s/0x%08x/%d\n",
-				(irqs_disabled()) ? "" : "raw ", current->comm,
-				preempt_count(), current->pid);
+		printk(KERN_ERR "BUG: scheduling with irqs disabled: "
+			"%s/0x%08x/%d\n", current->comm, preempt_count(), current->pid);
 		print_symbol("caller is %s\n",
 			(long)__builtin_return_address(0));
 		dump_stack();
@@ -3577,7 +3575,7 @@ asmlinkage void __sched preempt_schedule
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..
 	 */
-	if (unlikely(ti->preempt_count || irqs_disabled() || irqs_disabled()))
+	if (unlikely(ti->preempt_count || irqs_disabled()))
 		return;
 
 need_resched:
@@ -6807,7 +6805,7 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if ((in_atomic() || irqs_disabled() || irqs_disabled()) &&
+	if ((in_atomic() || irqs_disabled()) &&
 	    system_state == SYSTEM_RUNNING && !oops_in_progress) {
 		if (debug_direct_keyboard && hardirq_count())
 			return;
Index: linux-2.6.16/lib/smp_processor_id.c
===================================================================
--- linux-2.6.16.orig/lib/smp_processor_id.c
+++ linux-2.6.16/lib/smp_processor_id.c
@@ -16,7 +16,7 @@ unsigned int notrace debug_smp_processor
 	if (likely(preempt_count))
 		goto out;
 
-	if (irqs_disabled() || irqs_disabled())
+	if (irqs_disabled())
 		goto out;
 
 	/*

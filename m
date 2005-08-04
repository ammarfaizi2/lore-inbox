Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVHDUTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVHDUTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVHDUR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:17:56 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:3717 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262663AbVHDUQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:16:47 -0400
Subject: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01]
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 04 Aug 2005 16:16:23 -0400
Message-Id: <1123186583.12009.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

This was my final version of the softlockup patch.  Do you have any
comments on it?  I wasn't sure if you were waiting for any more debate
on this patch or not.

Daniel,

Have any more debate on this patch? :-)

-- Steve


-------- Forwarded Message --------
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Date: 	Wed, 03 Aug 2005 12:44:07 -0400

Ingo,

Doing some more tests on the patch, I found that I don't like the
placement in sched.c of the touch_light_softlockup_watchdog. I figure
that it may be better to put in into __schedule instead.  This really
shows where a task is taken off the run queue.

-- Steve

New patch: I've only tested this with the deadlock modules, and not with
the kjournald case. I'll do that tonight when I'm no longer needing my
computer for other tests.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/kernel/irq/handle.c
===================================================================
--- linux_realtime_ernie/kernel/irq/handle.c	(revision 266)
+++ linux_realtime_ernie/kernel/irq/handle.c	(working copy)
@@ -177,6 +177,14 @@
 	 */
 	local_irq_save(flags);
 #endif
+	/*
+	 * If the task is currently running in user mode, don't 
+	 * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
+	 * configured, this should be optimized out.
+	 */
+	if (user_mode(regs))
+		touch_light_softlockup_watchdog();
+
 	kstat_this_cpu.irqs[irq]++;
 	if (desc->status & IRQ_PER_CPU) {
 		irqreturn_t action_ret;
Index: linux_realtime_ernie/kernel/sched.c
===================================================================
--- linux_realtime_ernie/kernel/sched.c	(revision 266)
+++ linux_realtime_ernie/kernel/sched.c	(working copy)
@@ -3209,6 +3209,7 @@
 		else {
 			if (prev->state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible++;
+			touch_light_softlockup_watchdog();
 			deactivate_task(prev, rq);
 		}
 	}
Index: linux_realtime_ernie/kernel/softlockup.c
===================================================================
--- linux_realtime_ernie/kernel/softlockup.c	(revision 269)
+++ linux_realtime_ernie/kernel/softlockup.c	(working copy)
@@ -3,6 +3,10 @@
  *
  * started by Ingo Molnar, (C) 2005, Red Hat
  *
+ * Steven Rostedt, Kihon Technologies Inc.
+ *   Added light softlockup detection off of what Daniel Walker of
+ *   MontaVista started.
+ *
  * this code detects soft lockups: incidents in where on a CPU
  * the kernel does not reschedule for 10 seconds or more.
  */
@@ -20,9 +24,7 @@
 static DEFINE_PER_CPU(unsigned long, timeout) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, timestamp) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, print_timestamp) = INITIAL_JIFFIES;
-static DEFINE_PER_CPU(struct task_struct *, prev_task);
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
-static DEFINE_PER_CPU(unsigned long, task_counter);
 
 static int did_panic = 0;
 static int softlock_panic(struct notifier_block *this, unsigned long event,
@@ -42,6 +44,11 @@
 	per_cpu(timestamp, raw_smp_processor_id()) = jiffies;
 }
 
+void touch_light_softlockup_watchdog(void)
+{
+	current->softlockup_count = 0;
+}
+
 /*
  * This callback runs from the timer interrupt, and checks
  * whether the watchdog thread has hung or not:
@@ -59,24 +66,20 @@
 		if (!per_cpu(watchdog_task, this_cpu))
 			return;
 
-		if (per_cpu(prev_task, this_cpu) != current || 
-			!rt_task(current)) {
-			per_cpu(prev_task, this_cpu) = current;
-			per_cpu(task_counter, this_cpu) = 0;
-		}
-		else if ((++per_cpu(task_counter, this_cpu) > 10) && printk_ratelimit()) {
-
-			spin_lock(&print_lock);
-			printk(KERN_ERR "BUG: possible soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
-				this_cpu, jiffies, timestamp, timeout);
-			printk("curr=%s:%d\n",current->comm,current->pid);
-			
-			dump_stack();
+		if (current->pid) {
+			if (++current->softlockup_count > 10) {
+				spin_lock(&print_lock);
+				printk(KERN_ERR "BUG: possible soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
+				       this_cpu, jiffies, timestamp, timeout);
+				printk("curr=%s:%d count=%ld\n",current->comm,current->pid,
+				       current->softlockup_count);
+				dump_stack();
 #if defined(__i386__) && defined(CONFIG_SMP)
-			nmi_show_all_regs();
+				nmi_show_all_regs();
 #endif
-			spin_unlock(&print_lock);
-			per_cpu(task_counter, this_cpu) = 0;
+				spin_unlock(&print_lock);
+				touch_light_softlockup_watchdog();
+			}
 		}
 
 		wake_up_process(per_cpu(watchdog_task, this_cpu));
@@ -101,7 +104,6 @@
 		nmi_show_all_regs();
 #endif
 		spin_unlock(&print_lock);
-		per_cpu(task_counter, this_cpu) = 0;
 	}
 }
 
Index: linux_realtime_ernie/include/linux/sched.h
===================================================================
--- linux_realtime_ernie/include/linux/sched.h	(revision 266)
+++ linux_realtime_ernie/include/linux/sched.h	(working copy)
@@ -307,6 +307,7 @@
 extern void softlockup_tick(void);
 extern void spawn_softlockup_task(void);
 extern void touch_softlockup_watchdog(void);
+extern void touch_light_softlockup_watchdog(void);
 #else
 static inline void softlockup_tick(void)
 {
@@ -317,6 +318,9 @@
 static inline void touch_softlockup_watchdog(void)
 {
 }
+static inline void touch_light_softlockup_watchdog(void)
+{
+}
 #endif
 
 /* Attach to any functions which should be ignored in wchan output. */
@@ -898,6 +902,12 @@
 #ifdef CONFIG_DEBUG_PREEMPT
 	int lock_count;
 #endif
+#ifdef CONFIG_DETECT_SOFTLOCKUP
+	unsigned long	softlockup_count; /* Count to keep track how long the
+					   *  thread is in the kernel without
+					   *  sleeping.
+					   */
+#endif
 	/* realtime bits */
 	struct list_head delayed_put;
 	struct plist pi_waiters;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


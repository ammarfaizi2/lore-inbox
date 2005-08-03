Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVHCOuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVHCOuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVHCOuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:50:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:23228 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262297AbVHCOub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:50:31 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 10:50:06 -0400
Message-Id: <1123080606.1590.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here it is. The patch rewriten to use user_mode instead of arch
dependent modifications.  It seems to work just like my previous patch.

On Tue, 2005-08-02 at 19:58 -0700, Daniel Walker wrote:
> 
> I can't speak for everyone else, but I would want to catch both. That
> way we'll know if it's just a whacked out task, or a kernel problem.
> 
> Daniel

Sorry Daniel, this patch still only detects kernel lock ups.  You can
easily modify this (perhaps add another config option) to detect user
mode lockups as well. What you would do is remove the
kernel/irq/handle.c part (ifdef out with a config?), as well as adding
something in schedule that would do a touch_light_softlockup_watchdog if
what was running happens to be the only thing runnable on the CPU.  Or
just test for RT tasks.  But I'm more interrested in debugging kernel
problems, but I do see a benefit of testing RT user tasks, especially if
something gets boosted with a PI leak.

-- Steve

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
@@ -3367,6 +3367,8 @@
 		send_sig(SIGUSR2, current, 1);
 	}
 	do {
+		if (current->state & ~TASK_RUNNING_MUTEX)
+			touch_light_softlockup_watchdog();
 		__schedule();
 	} while (unlikely(test_thread_flag(TIF_NEED_RESCHED) || test_thread_flag(TIF_NEED_RESCHED_DELAYED)));
 	raw_local_irq_enable(); // TODO: do sti; ret
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



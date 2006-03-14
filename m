Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWCNVnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWCNVnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWCNVnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:43:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14238 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932496AbWCNVnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:43:06 -0500
Date: Tue, 14 Mar 2006 22:40:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: rmk+serial@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: soft lockup in serial8250_console_write(?)
Message-ID: <20060314214049.GA29536@elte.hu>
References: <20060314134110.3470fc63.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20060314134110.3470fc63.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Randy.Dunlap <rdunlap@xenotime.net> wrote:

> Hi,
> 
> (x86_64; 2.6.16-rc6; serial console configured but nothing connected 
> to the serial port)
> 
> I'm seeing an occasional soft lockup, maybe in 
> serial8250_console_write(). (drivers/serial/8250.c)
> 
> This function calls wait_for_xmitr() [inline], which in worst case can 
> spin for 1.010 seconds.  Could this be the cause of a soft lockup?

hm, it shouldnt cause that. Could you try the attached patch [which is 
the next-gen softlockup detector], do you get the message even with that 
one applied?

	Ingo


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="softlockup-timer-driven.patch"

below is the latest softdog-rework patch, with all fixes (including 
Nathan's hotplug CPU fix) merged.

--------
this patch makes the softlockup detector purely timer-interrupt driven,
removing softirq-context (timer) dependencies. This means that if the
softlockup watchdog triggers, it has truly observed a longer than 10
seconds scheduling delay of a SCHED_FIFO prio 99 task.

(the patch also turns off the softlockup detector during the initial
bootup phase and does small style fixes)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/sched.h |    4 +--
 kernel/softlockup.c   |   55 ++++++++++++++++++++++++++++----------------------
 kernel/timer.c        |    2 -
 3 files changed, 34 insertions(+), 27 deletions(-)

Index: linux-rt.q/include/linux/sched.h
===================================================================
--- linux-rt.q.orig/include/linux/sched.h
+++ linux-rt.q/include/linux/sched.h
@@ -208,11 +208,11 @@ extern void update_process_times(int use
 extern void scheduler_tick(void);
 
 #ifdef CONFIG_DETECT_SOFTLOCKUP
-extern void softlockup_tick(struct pt_regs *regs);
+extern void softlockup_tick(void);
 extern void spawn_softlockup_task(void);
 extern void touch_softlockup_watchdog(void);
 #else
-static inline void softlockup_tick(struct pt_regs *regs)
+static inline void softlockup_tick(void)
 {
 }
 static inline void spawn_softlockup_task(void)
Index: linux-rt.q/kernel/softlockup.c
===================================================================
--- linux-rt.q.orig/kernel/softlockup.c
+++ linux-rt.q/kernel/softlockup.c
@@ -1,12 +1,11 @@
 /*
  * Detect Soft Lockups
  *
- * started by Ingo Molnar, (C) 2005, Red Hat
+ * started by Ingo Molnar, Copyright (C) 2005, 2006 Red Hat, Inc.
  *
  * this code detects soft lockups: incidents in where on a CPU
  * the kernel does not reschedule for 10 seconds or more.
  */
-
 #include <linux/mm.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
@@ -17,13 +16,14 @@
 
 static DEFINE_SPINLOCK(print_lock);
 
-static DEFINE_PER_CPU(unsigned long, timestamp) = 0;
-static DEFINE_PER_CPU(unsigned long, print_timestamp) = 0;
+static DEFINE_PER_CPU(unsigned long, touch_timestamp);
+static DEFINE_PER_CPU(unsigned long, print_timestamp);
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
 
 static int did_panic = 0;
-static int softlock_panic(struct notifier_block *this, unsigned long event,
-				void *ptr)
+
+static int
+softlock_panic(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	did_panic = 1;
 
@@ -36,7 +36,7 @@ static struct notifier_block panic_block
 
 void touch_softlockup_watchdog(void)
 {
-	per_cpu(timestamp, raw_smp_processor_id()) = jiffies;
+	per_cpu(touch_timestamp, raw_smp_processor_id()) = jiffies;
 }
 EXPORT_SYMBOL(touch_softlockup_watchdog);
 
@@ -44,25 +44,35 @@ EXPORT_SYMBOL(touch_softlockup_watchdog)
  * This callback runs from the timer interrupt, and checks
  * whether the watchdog thread has hung or not:
  */
-void softlockup_tick(struct pt_regs *regs)
+void softlockup_tick(void)
 {
 	int this_cpu = smp_processor_id();
-	unsigned long timestamp = per_cpu(timestamp, this_cpu);
+	unsigned long touch_timestamp = per_cpu(touch_timestamp, this_cpu);
 
-	if (per_cpu(print_timestamp, this_cpu) == timestamp)
+	/* prevent double reports: */
+	if (per_cpu(print_timestamp, this_cpu) == touch_timestamp ||
+		did_panic ||
+			!per_cpu(watchdog_task, this_cpu))
 		return;
 
-	/* Do not cause a second panic when there already was one */
-	if (did_panic)
+	/* do not print during early bootup: */
+	if (unlikely(system_state != SYSTEM_RUNNING)) {
+		touch_softlockup_watchdog();
 		return;
+	}
 
-	if (time_after(jiffies, timestamp + 10*HZ)) {
-		per_cpu(print_timestamp, this_cpu) = timestamp;
+	/* Wake up the high-prio watchdog task every second: */
+	if (time_after(jiffies, touch_timestamp + HZ))
+		wake_up_process(per_cpu(watchdog_task, this_cpu));
+
+	/* Warn about unreasonable 10+ seconds delays: */
+	if (time_after(jiffies, touch_timestamp + 10*HZ)) {
+		per_cpu(print_timestamp, this_cpu) = touch_timestamp;
 
 		spin_lock(&print_lock);
 		printk(KERN_ERR "BUG: soft lockup detected on CPU#%d!\n",
 			this_cpu);
-		show_regs(regs);
+		dump_stack();
 		spin_unlock(&print_lock);
 	}
 }
@@ -77,18 +87,16 @@ static int watchdog(void * __bind_cpu)
 	sched_setscheduler(current, SCHED_FIFO, &param);
 	current->flags |= PF_NOFREEZE;
 
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	/*
-	 * Run briefly once per second - if this gets delayed for
-	 * more than 10 seconds then the debug-printout triggers
-	 * in softlockup_tick():
+	 * Run briefly once per second to reset the softlockup timestamp.
+	 * If this gets delayed for more than 10 seconds then the
+	 * debug-printout triggers in softlockup_tick().
 	 */
 	while (!kthread_should_stop()) {
-		msleep_interruptible(1000);
+		set_current_state(TASK_INTERRUPTIBLE);
 		touch_softlockup_watchdog();
+		schedule();
 	}
-	__set_current_state(TASK_RUNNING);
 
 	return 0;
 }
@@ -110,11 +118,11 @@ cpu_callback(struct notifier_block *nfb,
 			printk("watchdog for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
+  		per_cpu(touch_timestamp, hotcpu) = jiffies;
   		per_cpu(watchdog_task, hotcpu) = p;
 		kthread_bind(p, hotcpu);
  		break;
 	case CPU_ONLINE:
-
 		wake_up_process(per_cpu(watchdog_task, hotcpu));
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
@@ -146,4 +154,3 @@ __init void spawn_softlockup_task(void)
 
 	notifier_chain_register(&panic_notifier_list, &panic_block);
 }
-
Index: linux-rt.q/kernel/timer.c
===================================================================
--- linux-rt.q.orig/kernel/timer.c
+++ linux-rt.q/kernel/timer.c
@@ -914,6 +914,7 @@ static void run_timer_softirq(struct sof
 void run_local_timers(void)
 {
 	raise_softirq(TIMER_SOFTIRQ);
+	softlockup_tick();
 }
 
 /*
@@ -944,7 +945,6 @@ void do_timer(struct pt_regs *regs)
 	/* prevent loading jiffies before storing new jiffies_64 value. */
 	barrier();
 	update_times();
-	softlockup_tick(regs);
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM

--1yeeQ81UyVL57Vl7--

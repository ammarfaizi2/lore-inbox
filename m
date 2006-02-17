Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWBQNJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWBQNJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWBQNJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:09:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:15799 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750716AbWBQNJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:09:42 -0500
Date: Fri, 17 Feb 2006 14:08:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, ce@ruault.com, linux-kernel@vger.kernel.org
Subject: [patch] timer-irq-driven soft-watchdog, cleanups
Message-ID: <20060217130801.GA16115@elte.hu>
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org> <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com> <20060216122045.7a664bc6.akpm@osdl.org> <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com>
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


* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> I'm still not 100% sure if it was false positive - it looked like from 
> the trace but I find it hard to believe that users wouldn't complain 
> about 10sec stalls [ Soft lockup detector claims to trigger if after 
> 10sec it hasn't been touched - is it really working as advertised?  
> How can we verify this? ].

the watchdog is quite simple: it consists of per-CPU SCHED_FIFO prio 99 
[i.e. highest RT priority] threads that do nothing but:

        while (!kthread_should_stop()) {
                msleep_interruptible(1000);
                touch_softlockup_watchdog();
        }

i can think of only one (pretty theoretical) scenario for a false 
positive here: msleep uses timers, which are processed by softirq 
context, which context itself might be delayed. Under extreme load, if 
softirqs get delayed for more than 9 seconds, this _might_ lead to false 
positives. But that i think is highly unlikely in the reported IDE 
cases.

in any case, the patch below gets rid of the softirq involvement, and 
makes the soft-watchdog purely timer-irq driven (and a few minor 
cleanups). Could you try it? I have tested it - it correctly detected a 
11-seconds delay and stayed silent during a 9-seconds delay.

If you still get warnings even with this patch applied, then my very 
strong suspicion is that the 10+ seconds delays in the IDE code are 
real, and not false-positives. If there are such places then the minimum 
we should do is to document them via touch_softlockup_watchdog() ... 
even if you "knew" about such places already.

Andrew, could we try this patch in -mm?

	Ingo

---------------

this patch makes the softlockup detector purely timer-interrupt driven,
removing softirq-context (timer) dependencies. This means that if the
softlockup watchdog triggers, it has truly observed a longer than 10
seconds scheduling delay of a SCHED_FIFO prio 99 task.

(the patch also turns off the softlockup detector during the initial
bootup phase and does small style fixes)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/softlockup.c |   47 +++++++++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

Index: linux/kernel/softlockup.c
===================================================================
--- linux.orig/kernel/softlockup.c
+++ linux/kernel/softlockup.c
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
 
@@ -47,17 +47,20 @@ EXPORT_SYMBOL(touch_softlockup_watchdog)
 void softlockup_tick(struct pt_regs *regs)
 {
 	int this_cpu = smp_processor_id();
-	unsigned long timestamp = per_cpu(timestamp, this_cpu);
-
-	if (per_cpu(print_timestamp, this_cpu) == timestamp)
-		return;
+	unsigned long touch_timestamp = per_cpu(touch_timestamp, this_cpu);
 
-	/* Do not cause a second panic when there already was one */
-	if (did_panic)
+	/* Do not warn during bootup and prevent double reports: */
+	if (system_state != SYSTEM_RUNNING || did_panic ||
+			per_cpu(print_timestamp, this_cpu) == touch_timestamp)
 		return;
 
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
@@ -77,18 +80,16 @@ static int watchdog(void * __bind_cpu)
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
@@ -114,7 +115,6 @@ cpu_callback(struct notifier_block *nfb,
 		kthread_bind(p, hotcpu);
  		break;
 	case CPU_ONLINE:
-
 		wake_up_process(per_cpu(watchdog_task, hotcpu));
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
@@ -146,4 +146,3 @@ __init void spawn_softlockup_task(void)
 
 	notifier_chain_register(&panic_notifier_list, &panic_block);
 }
-

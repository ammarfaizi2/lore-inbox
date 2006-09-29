Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWI3AEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWI3AEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWI3AEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:04:36 -0400
Received: from www.osadl.org ([213.239.205.134]:33940 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422853AbWI3AEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:16 -0400
Message-Id: <20060929234441.113265000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:39 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 20/23] add /proc/sys/kernel/timeout_granularity
Content-Disposition: inline; filename=timer-tick-multiplier.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Introduce timeout granularity: process timer wheel timers every
timeout_granularity jiffies. Defaults to 1 (process timers HZ times
per second - most finegrained).

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 Documentation/kernel-parameters.txt |    6 ++++++
 include/linux/sysctl.h              |    1 +
 include/linux/timer.h               |    1 +
 kernel/sysctl.c                     |   10 ++++++++++
 kernel/timer.c                      |   24 +++++++++++++++++++++---
 5 files changed, 39 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm2/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.18-mm2.orig/Documentation/kernel-parameters.txt	2006-09-30 01:41:09.000000000 +0200
+++ linux-2.6.18-mm2/Documentation/kernel-parameters.txt	2006-09-30 01:41:19.000000000 +0200
@@ -1637,6 +1637,12 @@ and is between 256 and 4096 characters. 
 
 	time		Show timing data prefixed to each printk message line
 
+	timeout_granularity=
+			[KNL]
+			Timeout granularity: process timer wheel timers every
+			timeout_granularity jiffies. Defaults to 1 (process
+			timers HZ times per second - most finegrained).
+
 	clocksource=	[GENERIC_TIME] Override the default clocksource
 			Override the default clocksource and use the clocksource
 			with the name specified.
Index: linux-2.6.18-mm2/include/linux/sysctl.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/sysctl.h	2006-09-30 01:41:09.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/sysctl.h	2006-09-30 01:41:19.000000000 +0200
@@ -153,6 +153,7 @@ enum
 	KERN_MAX_LOCK_DEPTH=74,
 	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
+	KERN_TIMEOUT_GRANULARITY=77, /* int: timeout granularity in jiffies */
 };
 
 
Index: linux-2.6.18-mm2/include/linux/timer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/timer.h	2006-09-30 01:41:16.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/timer.h	2006-09-30 01:41:19.000000000 +0200
@@ -18,6 +18,7 @@ struct timer_list {
 };
 
 extern struct tvec_t_base_s boot_tvec_bases;
+extern unsigned int timeout_granularity;
 
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
Index: linux-2.6.18-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/sysctl.c	2006-09-30 01:41:09.000000000 +0200
+++ linux-2.6.18-mm2/kernel/sysctl.c	2006-09-30 01:41:19.000000000 +0200
@@ -640,6 +640,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_NO_HZ
+	{
+		.ctl_name       = KERN_TIMEOUT_GRANULARITY,
+		.procname       = "timeout_granularity",
+		.data           = &timeout_granularity,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = &proc_dointvec,
+	},
+#endif
 	{
 		.ctl_name	= KERN_PIDMAX,
 		.procname	= "pid_max",
Index: linux-2.6.18-mm2/kernel/timer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/timer.c	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/kernel/timer.c	2006-09-30 01:41:19.000000000 +0200
@@ -66,6 +66,8 @@ typedef struct tvec_root_s {
 	struct list_head vec[TVR_SIZE];
 } tvec_root_t;
 
+unsigned int __read_mostly timeout_granularity = 1;
+
 struct tvec_t_base_s {
 	spinlock_t lock;
 	struct timer_list *running_timer;
@@ -417,7 +419,9 @@ static inline void __run_timers(tvec_bas
 	struct timer_list *timer;
 
 	spin_lock_irq(&base->lock);
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
+
+	while (time_before_eq(base->timer_jiffies, jiffies)) {
+
 		struct list_head work_list;
 		struct list_head *head = &work_list;
  		int index = base->timer_jiffies & TVR_MASK;
@@ -569,7 +573,15 @@ found:
 	 * delayed processing, so make sure we return a value that
 	 * makes sense externally:
 	 */
-	return expires - (now - base->timer_jiffies);
+	expires -= (now - base->timer_jiffies);
+
+	/*
+	 * Round it up per timeout_granularity:
+	 */
+	expires += timeout_granularity - 1;
+	expires -= expires % timeout_granularity;
+
+	return expires;
 }
 
 unsigned long get_next_timer_interrupt(unsigned long now)
@@ -1112,7 +1124,13 @@ static void run_timer_softirq(struct sof
  */
 void run_local_timers(void)
 {
-	raise_softirq(TIMER_SOFTIRQ);
+	tvec_base_t *base = per_cpu(tvec_bases, smp_processor_id());
+	/*
+	 * Only wake up the TIMER_SOFTIRQ every timeout_granularity
+	 * jiffies:
+	 */
+	if (time_before_eq(base->timer_jiffies + timeout_granularity, jiffies))
+		raise_softirq(TIMER_SOFTIRQ);
 	softlockup_tick();
 }
 

--


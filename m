Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164216AbWLHA1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164216AbWLHA1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164217AbWLHA1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:27:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:26790 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164216AbWLHA1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:27:19 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,511,1157353200"; 
   d="scan'208"; a="24568177:sNHT25702146"
Date: Thu, 7 Dec 2006 16:01:05 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add not_critical_when_idle mode for generic timers
Message-ID: <20061207160105.A26061@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce a new mode for timers - not_critical_when_idle mode:
Timers that work normally when system is busy. But, will not cause CPU to
come out of idle (just to service this timer), when CPU is idle. Instead,
this timer will be serviced when CPU eventually wakes up with a subsequent
critical-when-idle timer.

The main advantage of this is to avoid unnecessary timer interrupts when
CPU is idle. If the routine currently called by a timer can wait until next
event without any issues, this new timer can be used to setup timer event
for that routine. This, with dynticks, allows CPUs to be lazy, allowing them
to stay in idle for extended period of time by reducing unnecesary wakeup and
thereby reducing the power consumption.

This patch:
Builds this new timer on top of existing timer infrastructure. It uses
last bit in 'base' pointer of timer_list structure to store this
extra information about timer. __next_timer_interrupt() function
skips over these not_critical_when_idle timers when CPU looks for
next timer event for which it has to wake up.

This is exported by a new interface add_timer_with_hint() and also a new
parameter is added to existing add_timer_on() interface.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/kernel/timer.c
===================================================================
--- linux-2.6.19-rc-mm.orig/kernel/timer.c	2006-12-07 10:58:15.000000000 -0800
+++ linux-2.6.19-rc-mm/kernel/timer.c	2006-12-07 15:34:21.000000000 -0800
@@ -76,7 +76,7 @@
 	tvec_t tv3;
 	tvec_t tv4;
 	tvec_t tv5;
-} ____cacheline_aligned_in_smp;
+} ____cacheline_aligned;
 
 typedef struct tvec_t_base_s tvec_base_t;
 
@@ -327,7 +327,7 @@
 	tvec_base_t *base;
 
 	for (;;) {
-		base = timer->base;
+		base = TBASE_GET_BASE_PTR(timer->base);
 		if (likely(base != NULL)) {
 			spin_lock_irqsave(&base->lock, *flags);
 			if (likely(base == timer->base))
@@ -366,12 +366,15 @@
 		 * the timer is serialized wrt itself.
 		 */
 		if (likely(base->running_timer != timer)) {
+			unsigned long tflag;
+			tflag = TBASE_GET_DELAYED_ON_IDLE(timer->base);
 			/* See the comment in lock_timer_base() */
 			timer->base = NULL;
 			spin_unlock(&base->lock);
 			base = new_base;
 			spin_lock(&base->lock);
-			timer->base = base;
+			timer->base =
+				TBASE_MERGE_DELAYED_ON_IDLE(new_base, tflag);
 		}
 	}
 
@@ -388,10 +391,12 @@
  * add_timer_on - start a timer on a particular CPU
  * @timer: the timer to be added
  * @cpu: the CPU to start it on
+ * @not_critical_when_idle: 1 to indicate timer is not critical and
+ *                          can be delayed when CPU is idle
  *
  * This is not very scalable on SMP. Double adds are not possible.
  */
-void add_timer_on(struct timer_list *timer, int cpu)
+void add_timer_on(struct timer_list *timer, int cpu, int not_critical_when_idle)
 {
 	tvec_base_t *base = per_cpu(tvec_bases, cpu);
   	unsigned long flags;
@@ -399,7 +404,7 @@
 	timer_stats_timer_set_start_info(timer);
   	BUG_ON(timer_pending(timer) || !timer->function);
 	spin_lock_irqsave(&base->lock, flags);
-	timer->base = base;
+	timer->base = TBASE_MERGE_DELAYED_ON_IDLE(base, not_critical_when_idle);
 	internal_add_timer(base, timer);
 	spin_unlock_irqrestore(&base->lock, flags);
 }
@@ -550,7 +555,7 @@
 	 * don't have to detach them individually.
 	 */
 	list_for_each_entry_safe(timer, tmp, &tv_list, entry) {
-		BUG_ON(timer->base != base);
+		BUG_ON(TBASE_GET_BASE_PTR(timer->base) != base);
 		internal_add_timer(base, timer);
 	}
 
@@ -639,6 +644,9 @@
 	j = base->timer_jiffies & TVR_MASK;
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
+			if (TBASE_GET_DELAYED_ON_IDLE(nte->base))
+				continue;
+
 			expires = nte->expires;
 			found = nte;
 			if (j < (base->timer_jiffies & TVR_MASK))
@@ -1622,6 +1630,13 @@
 						cpu_to_node(cpu));
 			if (!base)
 				return -ENOMEM;
+
+			/* Make sure that tvec_base is 2 byte aligned */
+			if (TBASE_GET_DELAYED_ON_IDLE(base)) {
+				WARN_ON(1);
+				kfree(base);
+				return -ENOMEM;
+			}
 			memset(base, 0, sizeof(*base));
 			per_cpu(tvec_bases, cpu) = base;
 		} else {
@@ -1661,9 +1676,11 @@
 	struct timer_list *timer;
 
 	while (!list_empty(head)) {
+		unsigned long tflag;
 		timer = list_entry(head->next, struct timer_list, entry);
+		tflag = TBASE_GET_DELAYED_ON_IDLE(timer->base);
+		timer->base = TBASE_MERGE_DELAYED_ON_IDLE(new_base, tflag);
 		detach_timer(timer, 0);
-		timer->base = new_base;
 		internal_add_timer(new_base, timer);
 	}
 }
Index: linux-2.6.19-rc-mm/include/linux/timer.h
===================================================================
--- linux-2.6.19-rc-mm.orig/include/linux/timer.h	2006-12-07 10:58:15.000000000 -0800
+++ linux-2.6.19-rc-mm/include/linux/timer.h	2006-12-07 11:05:32.000000000 -0800
@@ -8,6 +8,33 @@
 
 struct tvec_t_base_s;
 
+extern struct tvec_t_base_s boot_tvec_bases;
+/*
+ * Note that all tvec_bases is 2 byte aligned and lower bit of
+ * base in timer_list is guaranteed to be zero. Use the LSB for
+ * the new flag to indicate whether it is OK to skip timer callback
+ * when CPU is idle.
+ */
+#define TBASE_FLAG_DELAYED_ON_IDLE		(0x1)
+
+#define TBASE_GET_BASE_PTR(x)						\
+	((struct tvec_t_base_s *)((unsigned long)x &			\
+	                          (~TBASE_FLAG_DELAYED_ON_IDLE)))
+
+#define TBASE_GET_DELAYED_ON_IDLE(x)					\
+	((unsigned long)x & TBASE_FLAG_DELAYED_ON_IDLE)
+
+#define TBASE_SET_DELAYED_ON_IDLE(x)					\
+	((struct tvec_t_base_s *)((unsigned long)x |			\
+	                          TBASE_FLAG_DELAYED_ON_IDLE))
+
+#define TBASE_CLEAR_DELAYED_ON_IDLE(x)					\
+	((struct tvec_t_base_s *)((unsigned long)x &			\
+	                          (~TBASE_FLAG_DELAYED_ON_IDLE)))
+
+#define TBASE_MERGE_DELAYED_ON_IDLE(x,f)				\
+	((f) ? TBASE_SET_DELAYED_ON_IDLE(x) : TBASE_CLEAR_DELAYED_ON_IDLE(x))
+
 struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
@@ -23,7 +50,6 @@
 #endif
 };
 
-extern struct tvec_t_base_s boot_tvec_bases;
 
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
@@ -62,7 +88,8 @@
 	return timer->entry.next != NULL;
 }
 
-extern void add_timer_on(struct timer_list *timer, int cpu);
+extern void add_timer_on(struct timer_list *timer, int cpu,
+                         int not_critical_when_idle);
 extern int del_timer(struct timer_list * timer);
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
@@ -139,6 +166,16 @@
 static inline void add_timer(struct timer_list *timer)
 {
 	BUG_ON(timer_pending(timer));
+	timer->base = TBASE_CLEAR_DELAYED_ON_IDLE(timer->base);
+	__mod_timer(timer, timer->expires);
+}
+
+static inline void add_timer_with_hint(struct timer_list *timer,
+                                       int not_critical_when_idle)
+{
+	BUG_ON(timer_pending(timer));
+	timer->base = TBASE_MERGE_DELAYED_ON_IDLE(timer->base,
+	                                          not_critical_when_idle);
 	__mod_timer(timer, timer->expires);
 }
 
Index: linux-2.6.19-rc-mm/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.19-rc-mm.orig/arch/powerpc/platforms/chrp/setup.c	2006-12-07 10:56:48.000000000 -0800
+++ linux-2.6.19-rc-mm/arch/powerpc/platforms/chrp/setup.c	2006-12-07 10:58:58.000000000 -0800
@@ -565,7 +565,7 @@
 			timer = &per_cpu(heartbeat_timer, cpu);
 			setup_timer(timer, chrp_event_scan, 0);
 			timer->expires = jiffies + offset;
-			add_timer_on(timer, cpu);
+			add_timer_on(timer, cpu, 0);
 			offset += interval;
 		}
 		printk("RTAS Event Scan Rate: %u (%lu jiffies)\n",
Index: linux-2.6.19-rc-mm/kernel/workqueue.c
===================================================================
--- linux-2.6.19-rc-mm.orig/kernel/workqueue.c	2006-12-07 10:58:15.000000000 -0800
+++ linux-2.6.19-rc-mm/kernel/workqueue.c	2006-12-07 15:34:07.000000000 -0800
@@ -189,7 +189,7 @@
 		timer->expires = jiffies + delay;
 		timer->data = (unsigned long)work;
 		timer->function = delayed_work_timer_fn;
-		add_timer_on(timer, cpu);
+		add_timer_on(timer, cpu, 0);
 		ret = 1;
 	}
 	return ret;

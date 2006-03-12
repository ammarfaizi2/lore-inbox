Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWCLKg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWCLKg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCLKg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:36:56 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24550
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751423AbWCLKgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:53 -0500
Message-Id: <20060312080331.390704000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:13 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 1/8] hrtimer optimize softirq runqueues
Content-Disposition: inline; filename=hrtimer-optimize-run-queues.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The hrtimer softirq is called from the timer softirq every tick. 
Retrieve the current time from xtime and wall_to_monotonic instead of
calling base->get_time() for each timer base. Store the time in the
base structure and provide a hook once clock source abstractions are in 
place and to keep the code open for new base clocks.

Based on a patch from: Roman Zippel <zippel@linux-m68k.org>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/hrtimer.h |   20 ++++++++++++--------
 kernel/hrtimer.c        |   28 ++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 10 deletions(-)

Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -123,6 +123,26 @@ void ktime_get_ts(struct timespec *ts)
 EXPORT_SYMBOL_GPL(ktime_get_ts);
 
 /*
+ * Get the coarse grained time at the softirq based on xtime and
+ * wall_to_monotonic.
+ */
+static void hrtimer_get_softirq_time(struct hrtimer_base *base)
+{
+	ktime_t xtim, tomono;
+	unsigned long seq;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		xtim = timespec_to_ktime(xtime);
+		tomono = timespec_to_ktime(wall_to_monotonic);
+
+	} while (read_seqretry(&xtime_lock, seq));
+
+	base[CLOCK_REALTIME].softirq_time = xtim;
+	base[CLOCK_MONOTONIC].softirq_time = ktime_add(xtim, tomono);
+}
+
+/*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
  */
@@ -586,9 +606,11 @@ int hrtimer_get_res(const clockid_t whic
  */
 static inline void run_hrtimer_queue(struct hrtimer_base *base)
 {
-	ktime_t now = base->get_time();
 	struct rb_node *node;
 
+	if (base->get_softirq_time)
+		base->softirq_time = base->get_softirq_time();
+
 	spin_lock_irq(&base->lock);
 
 	while ((node = base->first)) {
@@ -598,7 +620,7 @@ static inline void run_hrtimer_queue(str
 		void *data;
 
 		timer = rb_entry(node, struct hrtimer, node);
-		if (now.tv64 <= timer->expires.tv64)
+		if (base->softirq_time.tv64 <= timer->expires.tv64)
 			break;
 
 		fn = timer->function;
@@ -641,6 +663,8 @@ void hrtimer_run_queues(void)
 	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
 	int i;
 
+	hrtimer_get_softirq_time(base);
+
 	for (i = 0; i < MAX_HRTIMER_BASES; i++)
 		run_hrtimer_queue(&base[i]);
 }
Index: linux-2.6.16-updates/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/hrtimer.h
+++ linux-2.6.16-updates/include/linux/hrtimer.h
@@ -72,14 +72,16 @@ struct hrtimer {
 /**
  * struct hrtimer_base - the timer base for a specific clock
  *
- * @index:	clock type index for per_cpu support when moving a timer
- *		to a base on another cpu.
- * @lock:	lock protecting the base and associated timers
- * @active:	red black tree root node for the active timers
- * @first:	pointer to the timer node which expires first
- * @resolution:	the resolution of the clock, in nanoseconds
- * @get_time:	function to retrieve the current time of the clock
- * @curr_timer:	the timer which is executing a callback right now
+ * @index:		clock type index for per_cpu support when moving a timer
+ *			to a base on another cpu.
+ * @lock:		lock protecting the base and associated timers
+ * @active:		red black tree root node for the active timers
+ * @first:		pointer to the timer node which expires first
+ * @resolution:		the resolution of the clock, in nanoseconds
+ * @get_time:		function to retrieve the current time of the clock
+ * @get_sofirq_time:	function to retrieve the current time from the softirq
+ * @curr_timer:		the timer which is executing a callback right now
+ * @softirq_time:	the time when running the hrtimer queue in the softirq
  */
 struct hrtimer_base {
 	clockid_t		index;
@@ -88,7 +90,9 @@ struct hrtimer_base {
 	struct rb_node		*first;
 	ktime_t			resolution;
 	ktime_t			(*get_time)(void);
+	ktime_t			(*get_softirq_time)(void);
 	struct hrtimer		*curr_timer;
+	ktime_t			softirq_time;
 };
 
 /*

--


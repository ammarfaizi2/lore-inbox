Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVCHHMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVCHHMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVCHGvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:51:19 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:33500
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261796AbVCHGrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:47:39 -0500
Date: Mon, 7 Mar 2005 22:47:27 -0800 (PST)
From: Christoph Lameter <christoph@graphe.net>
To: akpm@osdl.org
cc: roland@redhat.com, shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: [patch] del_timer_sync scalability patch
Message-ID: <Pine.LNX.4.58.0503072244270.20044@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a potential periodic timer is deleted through timer_del_sync, all
cpus are scanned to determine if the timer is running on that cpu. In a
NUMA configuration doing so will cause NUMA interlink traffic which limits
the scalability of timers.

The following patch makes the timer remember where the timer was last
started. It is then possible to only wait for the completion of the timer
on that specific cpu.

Signed-off-by: Shai Fultheim <Shai@Scalex86.org>
Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.11/include/linux/timer.h
===================================================================
--- linux-2.6.11.orig/include/linux/timer.h	2005-03-07 21:42:43.539328640 -0800
+++ linux-2.6.11/include/linux/timer.h	2005-03-07 21:42:50.993195480 -0800
@@ -19,10 +19,19 @@ struct timer_list {
 	unsigned long data;

 	struct tvec_t_base_s *base;
+#ifdef CONFIG_SMP
+	struct tvec_t_base_s *last_running;
+#endif
 };

 #define TIMER_MAGIC	0x4b87ad6e

+#ifdef CONFIG_SMP
+#define TIMER_INIT_LASTRUNNING .last_running = NULL,
+#else
+#define TIMER_INIT_LASTRUNNING
+#endif
+
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
@@ -30,6 +39,7 @@ struct timer_list {
 		.base = NULL,					\
 		.magic = TIMER_MAGIC,				\
 		.lock = SPIN_LOCK_UNLOCKED,			\
+		TIMER_INIT_LASTRUNNING                          \
 	}

 /***
@@ -41,6 +51,9 @@ struct timer_list {
  */
 static inline void init_timer(struct timer_list * timer)
 {
+#ifdef CONFIG_SMP
+	timer->last_running = NULL;
+#endif
 	timer->base = NULL;
 	timer->magic = TIMER_MAGIC;
 	spin_lock_init(&timer->lock);
Index: linux-2.6.11/kernel/timer.c
===================================================================
--- linux-2.6.11.orig/kernel/timer.c	2005-03-07 21:42:43.539328640 -0800
+++ linux-2.6.11/kernel/timer.c	2005-03-07 22:01:27.733425160 -0800
@@ -84,6 +84,14 @@ static inline void set_running_timer(tve
 #endif
 }

+static inline void set_last_running(struct timer_list *timer,
+					tvec_base_t *base)
+{
+#ifdef CONFIG_SMP
+	timer->last_running = base;
+#endif
+}
+
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };

@@ -335,33 +343,41 @@ EXPORT_SYMBOL(del_timer);
  *
  * The function returns whether it has deactivated a pending timer or not.
  *
- * del_timer_sync() is slow and complicated because it copes with timer
- * handlers which re-arm the timer (periodic timers).  If the timer handler
- * is known to not do this (a single shot timer) then use
- * del_singleshot_timer_sync() instead.
+ * del_timer_sync() copes with time handlers which re-arm the timer (periodic
+ * timers).  If the timer handler is known to not do this (a single shot
+ * timer) then use del_singleshot_timer_sync() instead.
  */
 int del_timer_sync(struct timer_list *timer)
 {
 	tvec_base_t *base;
-	int i, ret = 0;
+	int ret = 0;

 	check_timer(timer);

 del_again:
 	ret += del_timer(timer);

-	for_each_online_cpu(i) {
-		base = &per_cpu(tvec_bases, i);
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_check_resched();
-			}
-			break;
+	/* Get where the timer ran last */
+	base = timer->last_running;
+	if (base) {
+		/*
+		 * If the timer is still executing then wait until the
+		 * run is complete.
+		 */
+		while (base->running_timer == timer) {
+			cpu_relax();
+			preempt_check_resched();
 		}
 	}
 	smp_rmb();
-	if (timer_pending(timer))
+	/*
+	 * If the timer is no longer pending and its last run
+	 * was where we checked then the timer
+	 * is truly off. If the timer has been started on some other
+	 * cpu in the meantime (due to a race condition) then
+	 * we need to repeat what we have done.
+	 */
+	if (timer_pending(timer) || timer->last_running != base)
 		goto del_again;

 	return ret;
@@ -464,6 +480,7 @@ repeat:
 			set_running_timer(base, timer);
 			smp_wmb();
 			timer->base = NULL;
+			set_last_running(timer, base);
 			spin_unlock_irq(&base->lock);
 			{
 				u32 preempt_count = preempt_count();

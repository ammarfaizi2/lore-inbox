Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVCOIHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVCOIHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVCOIHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:07:00 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:54802
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262321AbVCOIGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:06:17 -0500
Date: Tue, 15 Mar 2005 00:06:08 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <42343C61.6A1210C0@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503150004190.13281@server.graphe.net>
References: <4231E959.141F7D85@tv-sign.ru> <42343C61.6A1210C0@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about this take on the problem?

When a potential periodic timer is deleted through timer_del_sync, all cpus
are scanned to determine if the timer is running on that cpu. In a NUMA
configuration doing so will cause NUMA interlink traffic which limits the
scalability of timers.

The following patch removes the magic in the timer_list structure (Andrew
suggested that we may not need it anymore) and replaces it with two u8
variables that give us some additional state of the timer

running		-> Set if the timer function is currently executing
shutdown	-> Set if del_timer_sync is running and the timer
		   should not be rescheduled.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.11/include/linux/timer.h
===================================================================
--- linux-2.6.11.orig/include/linux/timer.h	2005-03-14 14:17:51.671533904 -0800
+++ linux-2.6.11/include/linux/timer.h	2005-03-14 14:41:49.640929328 -0800
@@ -13,22 +13,22 @@ struct timer_list {
 	unsigned long expires;

 	spinlock_t lock;
-	unsigned long magic;

 	void (*function)(unsigned long);
 	unsigned long data;

-	struct tvec_t_base_s *base;
+	struct tvec_t_base_s *base;	/* ==NULL if timer not scheduled */
+	u8 running;		/* function is currently executing */
+	u8 shutdown;		/* do not schedule this timer */
 };

-#define TIMER_MAGIC	0x4b87ad6e
-
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
 		.base = NULL,					\
-		.magic = TIMER_MAGIC,				\
+		.running = 0,					\
+		.shutdown = 0,					\
 		.lock = SPIN_LOCK_UNLOCKED,			\
 	}

@@ -42,7 +42,8 @@ struct timer_list {
 static inline void init_timer(struct timer_list * timer)
 {
 	timer->base = NULL;
-	timer->magic = TIMER_MAGIC;
+	timer->running = 0;
+	timer->shutdown = 0;
 	spin_lock_init(&timer->lock);
 }

Index: linux-2.6.11/kernel/timer.c
===================================================================
--- linux-2.6.11.orig/kernel/timer.c	2005-03-14 14:17:51.671533904 -0800
+++ linux-2.6.11/kernel/timer.c	2005-03-14 14:57:24.613791848 -0800
@@ -89,31 +89,6 @@ static inline void set_running_timer(tve
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };

-static void check_timer_failed(struct timer_list *timer)
-{
-	static int whine_count;
-	if (whine_count < 16) {
-		whine_count++;
-		printk("Uninitialised timer!\n");
-		printk("This is just a warning.  Your computer is OK\n");
-		printk("function=0x%p, data=0x%lx\n",
-			timer->function, timer->data);
-		dump_stack();
-	}
-	/*
-	 * Now fix it up
-	 */
-	spin_lock_init(&timer->lock);
-	timer->magic = TIMER_MAGIC;
-}
-
-static inline void check_timer(struct timer_list *timer)
-{
-	if (timer->magic != TIMER_MAGIC)
-		check_timer_failed(timer);
-}
-
-
 static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
 {
 	unsigned long expires = timer->expires;
@@ -164,8 +139,6 @@ int __mod_timer(struct timer_list *timer

 	BUG_ON(!timer->function);

-	check_timer(timer);
-
 	spin_lock_irqsave(&timer->lock, flags);
 	new_base = &__get_cpu_var(tvec_bases);
 repeat:
@@ -208,8 +181,10 @@ repeat:
 		ret = 1;
 	}
 	timer->expires = expires;
-	internal_add_timer(new_base, timer);
-	timer->base = new_base;
+	if (!timer->shutdown) {
+		internal_add_timer(new_base, timer);
+		timer->base = new_base;
+	}

 	if (old_base && (new_base != old_base))
 		spin_unlock(&old_base->lock);
@@ -235,7 +210,8 @@ void add_timer_on(struct timer_list *tim

   	BUG_ON(timer_pending(timer) || !timer->function);

-	check_timer(timer);
+	if (timer->shutdown)
+		return;

 	spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
@@ -267,8 +243,6 @@ int mod_timer(struct timer_list *timer,
 {
 	BUG_ON(!timer->function);

-	check_timer(timer);
-
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -298,8 +272,6 @@ int del_timer(struct timer_list *timer)
 	unsigned long flags;
 	tvec_base_t *base;

-	check_timer(timer);
-
 repeat:
  	base = timer->base;
 	if (!base)
@@ -337,35 +309,40 @@ EXPORT_SYMBOL(del_timer);
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
-	tvec_base_t *base;
-	int i, ret = 0;
+	int ret = 0;

-	check_timer(timer);
+	/* Forbid additional scheduling of this timer */
+	timer->shutdown = 1;

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
-		}
+	/*
+	 * If the timer is still executing then wait until the
+	 * run is complete.
+	 */
+	while (timer->running) {
+			cpu_relax();
+			preempt_check_resched();
 	}
 	smp_rmb();
+	/*
+	 * If the timer is no longer pending then the timer
+	 * is truly off.
+	 * The timer may have been started on some other
+	 * cpu in the meantime (due to a race condition)
+	 */
 	if (timer_pending(timer))
 		goto del_again;

+	/* Reenable timer shutdown */
+	timer->shutdown = 0;
 	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
@@ -380,7 +357,7 @@ EXPORT_SYMBOL(del_timer_sync);
  *
  * Synchronization rules: callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. The caller must not hold locks which wold prevent
+ * interrupt contexts. The caller must not hold locks which would prevent
  * completion of the timer's handler.  Upon exit the timer is not queued and
  * the handler is not running on any CPU.
  *
@@ -464,6 +441,7 @@ repeat:

 			list_del(&timer->entry);
 			set_running_timer(base, timer);
+			timer->running = 1;
 			smp_wmb();
 			timer->base = NULL;
 			spin_unlock_irq(&base->lock);
@@ -476,6 +454,7 @@ repeat:
 				}
 			}
 			spin_lock_irq(&base->lock);
+			timer->running = 0;
 			goto repeat;
 		}
 	}

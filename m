Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTJKQmR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTJKQmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:42:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64642 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263131AbTJKQmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:42:12 -0400
Date: Sat, 11 Oct 2003 18:40:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
In-Reply-To: <Pine.LNX.4.56.0310111713440.8641@earth>
Message-ID: <Pine.LNX.4.56.0310111833550.11661@earth>
References: <3F881B46.6070301@colorfullife.com> <Pine.LNX.4.56.0310111713440.8641@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Oct 2003, Ingo Molnar wrote:

> it would be much cleaner to add another timer->running field, especially
> since this would be the 8th word-sized field in struct timer_list,
> making it a nice round structure size.
> 
> btw., there's a third type of timer race we have. If a timer function is
> delayed by more than 1 timer tick [which could happen under eg. UML],
> then it's possible for the timer function to run on another CPU in
> parallel to the already executing timer function.

i've implemented the timer->running field, and it's quite straightforward
and solves all 3 types of races. It also simplifies del_timer_sync() quite
visibly, and it's probably a fair del_timer_sync() speedup as well. I
tested the attached patch on SMP and UP x86 as well, works fine for me.

the timer->running field is now also used to guarantee serialization of
timer->fn execution of the same timer [race #3]. This is a quite
reasonable thing to expect, and a fair portion of timer users do expect
this.

	Ingo

--- linux/include/linux/timer.h.orig	
+++ linux/include/linux/timer.h	
@@ -18,6 +18,7 @@ struct timer_list {
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+	unsigned long running;
 };
 
 #define TIMER_MAGIC	0x4b87ad6e
@@ -29,6 +30,7 @@ struct timer_list {
 		.base = NULL,					\
 		.magic = TIMER_MAGIC,				\
 		.lock = SPIN_LOCK_UNLOCKED,			\
+		.running = 0,					\
 	}
 
 /***
@@ -42,6 +44,7 @@ static inline void init_timer(struct tim
 {
 	timer->base = NULL;
 	timer->magic = TIMER_MAGIC;
+	timer->running = 0;
 	spin_lock_init(&timer->lock);
 }
 
--- linux/kernel/timer.c.orig	
+++ linux/kernel/timer.c	
@@ -57,7 +57,6 @@ typedef struct tvec_root_s {
 struct tvec_t_base_s {
 	spinlock_t lock;
 	unsigned long timer_jiffies;
-	struct timer_list *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -67,14 +66,6 @@ struct tvec_t_base_s {
 
 typedef struct tvec_t_base_s tvec_base_t;
 
-static inline void set_running_timer(tvec_base_t *base,
-					struct timer_list *timer)
-{
-#ifdef CONFIG_SMP
-	base->running_timer = timer;
-#endif
-}
-
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
@@ -315,35 +306,27 @@ EXPORT_SYMBOL(del_timer);
  * the timer it also makes sure the handler has finished executing on other
  * CPUs.
  *
- * Synchronization rules: callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. Upon exit the timer is not queued and the handler
- * is not running on any CPU.
+ * Synchronization rules: callers must prevent restarting of the timer
+ * (except restarting the timer from the timer function itself), otherwise
+ * this function is meaningless. It must not be called from interrupt
+ * contexts. Upon exit the timer is not queued and the handler is not
+ * running on any CPU.
  *
- * The function returns whether it has deactivated a pending timer or not.
+ * The function returns the number of times it has deactivated a pending
+ * timer.
  */
 int del_timer_sync(struct timer_list *timer)
 {
-	tvec_base_t *base;
-	int i, ret = 0;
+	int ret = 0;
 
 	check_timer(timer);
 
 del_again:
 	ret += del_timer(timer);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-
-		base = &per_cpu(tvec_bases, i);
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_check_resched();
-			}
-			break;
-		}
+	while (unlikely(timer->running)) {
+		cpu_relax();
+		preempt_check_resched();
 	}
 	smp_rmb();
 	if (timer_pending(timer))
@@ -417,16 +400,36 @@ repeat:
  			fn = timer->function;
  			data = timer->data;
 
+#ifdef CONFIG_SMP
+			/*
+			 * If the timer is running on another CPU then
+			 * wait for it - without holding the base lock.
+			 * This is a very rare but possible situation.
+			 *
+			 * Re-start the whole processing after that, the
+			 * timer might have been removed while we dropped
+			 * the lock.
+			 */
+			if (unlikely(timer->running)) {
+				spin_unlock_irq(&base->lock);
+				while (timer->running)
+					cpu_relax();
+				spin_lock_irq(&base->lock);
+				goto repeat;
+			}
+			timer->running = 1;
+#endif
 			list_del(&timer->entry);
 			timer->base = NULL;
-			set_running_timer(base, timer);
 			spin_unlock_irq(&base->lock);
 			fn(data);
 			spin_lock_irq(&base->lock);
+#ifdef CONFIG_SMP
+			timer->running = 0;
+#endif
 			goto repeat;
 		}
 	}
-	set_running_timer(base, NULL);
 	spin_unlock_irq(&base->lock);
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWCXUYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWCXUYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCXUYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:24:38 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58069 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751211AbWCXUYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:24:38 -0500
Message-ID: <442454C7.C7F10D24@tv-sign.ru>
Date: Fri, 24 Mar 2006 23:21:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Jan Beulich <jbeulich@novell.com>
Subject: [PATCH] kill __init_timer_base in favor of boot_tvec_bases
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch
	[PATCH] tvec_bases too large for per-cpu data
	http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a4a6198b80cf82eb8160603c98da218d1bd5e104

introduced "struct tvec_t_base_s boot_tvec_bases" which is visible
at compile time. This means we can kill __init_timer_base and move
timer_base_s's content into tvec_t_base_s.

 include/linux/timer.h |    8 ++--
 kernel/timer.c        |   84 ++++++++++++++++++++------------------------------
 2 files changed, 39 insertions(+), 53 deletions(-)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/include/linux/timer.h~TIMER	2006-03-23 22:48:10.000000000 +0300
+++ MM/include/linux/timer.h	2006-03-25 01:23:14.000000000 +0300
@@ -6,7 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 
-struct timer_base_s;
+struct tvec_t_base_s;
 
 struct timer_list {
 	struct list_head entry;
@@ -15,16 +15,16 @@ struct timer_list {
 	void (*function)(unsigned long);
 	unsigned long data;
 
-	struct timer_base_s *base;
+	struct tvec_t_base_s *base;
 };
 
-extern struct timer_base_s __init_timer_base;
+extern struct tvec_t_base_s boot_tvec_bases;
 
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		.base = &__init_timer_base,			\
+		.base = &boot_tvec_bases,			\
 	}
 
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
--- MM/kernel/timer.c~TIMER	2006-03-23 22:48:10.000000000 +0300
+++ MM/kernel/timer.c	2006-03-25 01:37:29.000000000 +0300
@@ -54,7 +54,6 @@ EXPORT_SYMBOL(jiffies_64);
 /*
  * per-CPU timer vector definitions:
  */
-
 #define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
 #define TVR_BITS (CONFIG_BASE_SMALL ? 6 : 8)
 #define TVN_SIZE (1 << TVN_BITS)
@@ -62,11 +61,6 @@ EXPORT_SYMBOL(jiffies_64);
 #define TVN_MASK (TVN_SIZE - 1)
 #define TVR_MASK (TVR_SIZE - 1)
 
-struct timer_base_s {
-	spinlock_t lock;
-	struct timer_list *running_timer;
-};
-
 typedef struct tvec_s {
 	struct list_head vec[TVN_SIZE];
 } tvec_t;
@@ -76,7 +70,8 @@ typedef struct tvec_root_s {
 } tvec_root_t;
 
 struct tvec_t_base_s {
-	struct timer_base_s t_base;
+	spinlock_t lock;
+	struct timer_list *running_timer;
 	unsigned long timer_jiffies;
 	tvec_root_t tv1;
 	tvec_t tv2;
@@ -87,13 +82,14 @@ struct tvec_t_base_s {
 
 typedef struct tvec_t_base_s tvec_base_t;
 static DEFINE_PER_CPU(tvec_base_t *, tvec_bases);
-static tvec_base_t boot_tvec_bases;
+tvec_base_t boot_tvec_bases;
+EXPORT_SYMBOL(boot_tvec_bases);
 
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
 {
 #ifdef CONFIG_SMP
-	base->t_base.running_timer = timer;
+	base->running_timer = timer;
 #endif
 }
 
@@ -139,15 +135,6 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
-typedef struct timer_base_s timer_base_t;
-/*
- * Used by TIMER_INITIALIZER, we can't use per_cpu(tvec_bases)
- * at compile time, and we need timer->base to lock the timer.
- */
-timer_base_t __init_timer_base
-	____cacheline_aligned_in_smp = { .lock = SPIN_LOCK_UNLOCKED };
-EXPORT_SYMBOL(__init_timer_base);
-
 /***
  * init_timer - initialize a timer.
  * @timer: the timer to be initialized
@@ -158,7 +145,7 @@ EXPORT_SYMBOL(__init_timer_base);
 void fastcall init_timer(struct timer_list *timer)
 {
 	timer->entry.next = NULL;
-	timer->base = &per_cpu(tvec_bases, raw_smp_processor_id())->t_base;
+	timer->base = per_cpu(tvec_bases, raw_smp_processor_id());
 }
 EXPORT_SYMBOL(init_timer);
 
@@ -174,7 +161,7 @@ static inline void detach_timer(struct t
 }
 
 /*
- * We are using hashed locking: holding per_cpu(tvec_bases).t_base.lock
+ * We are using hashed locking: holding per_cpu(tvec_bases).lock
  * means that all timers which are tied to this base via timer->base are
  * locked, and the base itself is locked too.
  *
@@ -185,10 +172,10 @@ static inline void detach_timer(struct t
  * possible to set timer->base = NULL and drop the lock: the timer remains
  * locked.
  */
-static timer_base_t *lock_timer_base(struct timer_list *timer,
+static tvec_base_t *lock_timer_base(struct timer_list *timer,
 					unsigned long *flags)
 {
-	timer_base_t *base;
+	tvec_base_t *base;
 
 	for (;;) {
 		base = timer->base;
@@ -205,8 +192,7 @@ static timer_base_t *lock_timer_base(str
 
 int __mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	timer_base_t *base;
-	tvec_base_t *new_base;
+	tvec_base_t *base, *new_base;
 	unsigned long flags;
 	int ret = 0;
 
@@ -221,7 +207,7 @@ int __mod_timer(struct timer_list *timer
 
 	new_base = __get_cpu_var(tvec_bases);
 
-	if (base != &new_base->t_base) {
+	if (base != new_base) {
 		/*
 		 * We are trying to schedule the timer on the local CPU.
 		 * However we can't change timer's base while it is running,
@@ -231,19 +217,19 @@ int __mod_timer(struct timer_list *timer
 		 */
 		if (unlikely(base->running_timer == timer)) {
 			/* The timer remains on a former base */
-			new_base = container_of(base, tvec_base_t, t_base);
+			new_base = base;
 		} else {
 			/* See the comment in lock_timer_base() */
 			timer->base = NULL;
 			spin_unlock(&base->lock);
-			spin_lock(&new_base->t_base.lock);
-			timer->base = &new_base->t_base;
+			spin_lock(&new_base->lock);
+			timer->base = new_base;
 		}
 	}
 
 	timer->expires = expires;
 	internal_add_timer(new_base, timer);
-	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
+	spin_unlock_irqrestore(&new_base->lock, flags);
 
 	return ret;
 }
@@ -263,10 +249,10 @@ void add_timer_on(struct timer_list *tim
   	unsigned long flags;
 
   	BUG_ON(timer_pending(timer) || !timer->function);
-	spin_lock_irqsave(&base->t_base.lock, flags);
-	timer->base = &base->t_base;
+	spin_lock_irqsave(&base->lock, flags);
+	timer->base = base;
 	internal_add_timer(base, timer);
-	spin_unlock_irqrestore(&base->t_base.lock, flags);
+	spin_unlock_irqrestore(&base->lock, flags);
 }
 
 
@@ -319,7 +305,7 @@ EXPORT_SYMBOL(mod_timer);
  */
 int del_timer(struct timer_list *timer)
 {
-	timer_base_t *base;
+	tvec_base_t *base;
 	unsigned long flags;
 	int ret = 0;
 
@@ -346,7 +332,7 @@ EXPORT_SYMBOL(del_timer);
  */
 int try_to_del_timer_sync(struct timer_list *timer)
 {
-	timer_base_t *base;
+	tvec_base_t *base;
 	unsigned long flags;
 	int ret = -1;
 
@@ -410,7 +396,7 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != &base->t_base);
+		BUG_ON(tmp->base != base);
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}
@@ -432,7 +418,7 @@ static inline void __run_timers(tvec_bas
 {
 	struct timer_list *timer;
 
-	spin_lock_irq(&base->t_base.lock);
+	spin_lock_irq(&base->lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
@@ -458,7 +444,7 @@ static inline void __run_timers(tvec_bas
 
 			set_running_timer(base, timer);
 			detach_timer(timer, 1);
-			spin_unlock_irq(&base->t_base.lock);
+			spin_unlock_irq(&base->lock);
 			{
 				int preempt_count = preempt_count();
 				fn(data);
@@ -471,11 +457,11 @@ static inline void __run_timers(tvec_bas
 					BUG();
 				}
 			}
-			spin_lock_irq(&base->t_base.lock);
+			spin_lock_irq(&base->lock);
 		}
 	}
 	set_running_timer(base, NULL);
-	spin_unlock_irq(&base->t_base.lock);
+	spin_unlock_irq(&base->lock);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -506,7 +492,7 @@ unsigned long next_timer_interrupt(void)
 	hr_expires += jiffies;
 
 	base = __get_cpu_var(tvec_bases);
-	spin_lock(&base->t_base.lock);
+	spin_lock(&base->lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
 	list = NULL;
 
@@ -554,7 +540,7 @@ found:
 				expires = nte->expires;
 		}
 	}
-	spin_unlock(&base->t_base.lock);
+	spin_unlock(&base->lock);
 
 	if (time_before(hr_expires, expires))
 		return hr_expires;
@@ -1530,7 +1516,7 @@ static int __devinit init_timers_cpu(int
 		}
 		per_cpu(tvec_bases, cpu) = base;
 	}
-	spin_lock_init(&base->t_base.lock);
+	spin_lock_init(&base->lock);
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
 		INIT_LIST_HEAD(base->tv4.vec + j);
@@ -1552,7 +1538,7 @@ static void migrate_timer_list(tvec_base
 	while (!list_empty(head)) {
 		timer = list_entry(head->next, struct timer_list, entry);
 		detach_timer(timer, 0);
-		timer->base = &new_base->t_base;
+		timer->base = new_base;
 		internal_add_timer(new_base, timer);
 	}
 }
@@ -1568,11 +1554,11 @@ static void __devinit migrate_timers(int
 	new_base = get_cpu_var(tvec_bases);
 
 	local_irq_disable();
-	spin_lock(&new_base->t_base.lock);
-	spin_lock(&old_base->t_base.lock);
+	spin_lock(&new_base->lock);
+	spin_lock(&old_base->lock);
+
+	BUG_ON(old_base->running_timer);
 
-	if (old_base->t_base.running_timer)
-		BUG();
 	for (i = 0; i < TVR_SIZE; i++)
 		migrate_timer_list(new_base, old_base->tv1.vec + i);
 	for (i = 0; i < TVN_SIZE; i++) {
@@ -1582,8 +1568,8 @@ static void __devinit migrate_timers(int
 		migrate_timer_list(new_base, old_base->tv5.vec + i);
 	}
 
-	spin_unlock(&old_base->t_base.lock);
-	spin_unlock(&new_base->t_base.lock);
+	spin_unlock(&old_base->lock);
+	spin_unlock(&new_base->lock);
 	local_irq_enable();
 	put_cpu_var(tvec_bases);
 }

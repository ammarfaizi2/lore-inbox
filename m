Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVC0ORq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVC0ORq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVC0ORq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:17:46 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:37039 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261667AbVC0OR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:17:26 -0500
Message-ID: <4246C1D5.B3DC347E@tv-sign.ru>
Date: Sun, 27 Mar 2005 18:23:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH rc1-mm3] timers: kill timer_list->lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The timer->lock is needed in __mod_timer() because the freshly
inited timer has base == NULL, so __mod_timer() can't use old_base
for synchronization.

With this patch init_timer() sets ->_base = per_cpu(tvec_bases).
This simplifies the code because we don't need to check that
base != NULL, and slightly speedups __mod_timer(). And reduces
the timer_list's size.

One problem. TIMER_INITIALIZER can't use per_cpu(tvec_bases).
So this patch adds global
	struct {
		spinlock_t lock;
		struct timer_list *running_timer;
	} fake_timer_base;
which is used by TIMER_INITIALIZER.

It is indeed ugly. But this can't have scalability problems.
The global fake_timer_base.lock is used only when __mod_timer()
is called for the first time and the timer was compile time
initialized. After that the timer migrates to the local CPU.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc1-mm3/include/linux/timer.h~	2005-03-27 21:05:51.000000000 +0400
+++ rc1-mm3/include/linux/timer.h	2005-03-27 21:07:29.000000000 +0400
@@ -12,7 +12,6 @@ struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
 
-	spinlock_t lock;
 	unsigned long magic;
 
 	void (*function)(unsigned long);
@@ -25,15 +24,11 @@ struct timer_list {
  * To save space, we play games with the least significant bit
  * of timer_list->_base.
  *
- * If (_base & __TIMER_PENDING), the timer is pending. Implies
- * (_base & ~__TIMER_PENDING) != NULL.
+ * If (_base & __TIMER_PENDING), the timer is pending.
  *
- * (_base & ~__TIMER_PENDING), if != NULL, is the address of the
- * timer's per-cpu tvec_t_base_s where it was last scheduled and
- * where it may still be running.
- *
- * If (_base == NULL), the timer was not scheduled yet or it was
- * cancelled by del_timer_sync(), so it is not running on any CPU.
+ * (_base & ~__TIMER_PENDING) is the address of the timer's
+ * per-cpu tvec_t_base_s where it was last registered and where
+ * it may still be running.
  */
 
 #define	__TIMER_PENDING	1
@@ -45,28 +40,17 @@ static inline int __timer_pending(struct
 
 #define TIMER_MAGIC	0x4b87ad6e
 
+extern struct fake_timer_base fake_timer_base;
+
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		._base = NULL,					\
+		._base = (void*)&fake_timer_base,		\
 		.magic = TIMER_MAGIC,				\
-		.lock = SPIN_LOCK_UNLOCKED,			\
 	}
 
-/***
- * init_timer - initialize a timer.
- * @timer: the timer to be initialized
- *
- * init_timer() must be done to a timer prior calling *any* of the
- * other timer functions.
- */
-static inline void init_timer(struct timer_list * timer)
-{
-	timer->_base = NULL;
-	timer->magic = TIMER_MAGIC;
-	spin_lock_init(&timer->lock);
-}
+void fastcall init_timer(struct timer_list * timer);
 
 /***
  * timer_pending - is a timer pending?
--- rc1-mm3/kernel/timer.c~	2005-03-27 21:06:19.000000000 +0400
+++ rc1-mm3/kernel/timer.c	2005-03-27 21:07:29.000000000 +0400
@@ -68,8 +68,8 @@ typedef struct tvec_root_s {
 
 struct tvec_t_base_s {
 	spinlock_t lock;
-	unsigned long timer_jiffies;
 	struct timer_list *running_timer;
+	unsigned long timer_jiffies;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -78,6 +78,16 @@ struct tvec_t_base_s {
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
+static DEFINE_PER_CPU(tvec_base_t, tvec_bases);
+
+struct fake_timer_base {
+	spinlock_t lock;
+	struct timer_list *running_timer;
+} ____cacheline_aligned_in_smp;
+
+struct fake_timer_base fake_timer_base =
+		{ .lock = SPIN_LOCK_UNLOCKED };
+EXPORT_SYMBOL(fake_timer_base);
 
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
@@ -87,6 +97,28 @@ static inline void set_running_timer(tve
 #endif
 }
 
+/***
+ * init_timer - initialize a timer.
+ * @timer: the timer to be initialized
+ *
+ * init_timer() must be done to a timer prior calling *any* of the
+ * other timer functions.
+ */
+void fastcall init_timer(struct timer_list * timer)
+{
+	BUILD_BUG_ON(
+		offsetof(tvec_base_t, lock) !=
+		offsetof(struct fake_timer_base, lock)
+			||
+		offsetof(tvec_base_t, running_timer) !=
+		offsetof(struct fake_timer_base, running_timer)
+	);
+
+	timer->_base = &per_cpu(tvec_bases, __smp_processor_id());
+	timer->magic = TIMER_MAGIC;
+}
+EXPORT_SYMBOL(init_timer);
+
 static inline void __set_base(struct timer_list *timer,
 				tvec_base_t *base, int pending)
 {
@@ -101,9 +133,6 @@ static inline tvec_base_t *timer_base(st
 	return (tvec_base_t*)((unsigned long)timer->_base & ~__TIMER_PENDING);
 }
 
-/* Fake initialization */
-static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
-
 static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
@@ -118,7 +147,6 @@ static void check_timer_failed(struct ti
 	/*
 	 * Now fix it up
 	 */
-	spin_lock_init(&timer->lock);
 	timer->magic = TIMER_MAGIC;
 }
 
@@ -182,39 +210,33 @@ int __mod_timer(struct timer_list *timer
 	check_timer(timer);
 
 	do {
-		spin_lock_irqsave(&timer->lock, flags);
+		local_irq_save(flags);
 		new_base = &__get_cpu_var(tvec_bases);
 		old_base = timer_base(timer);
 
-		/* Prevent AB-BA deadlocks. */
+		/* Prevent AB-BA deadlocks.
+		 * NOTE: (old_base == new_base) => (new_lock == 0)
+		 */
 		new_lock = old_base < new_base;
 		if (new_lock)
 			spin_lock(&new_base->lock);
+		spin_lock(&old_base->lock);
 
-		/* Note:
-		 *	(old_base == NULL)     => (new_lock == 1)
-		 *	(old_base == new_base) => (new_lock == 0)
-		 */
-		if (old_base) {
-			spin_lock(&old_base->lock);
+		if (timer_base(timer) != old_base)
+			goto unlock;
 
-			if (timer_base(timer) != old_base)
+		if (old_base != new_base) {
+			/* Ensure the timer is serialized. */
+			if (old_base->running_timer == timer)
 				goto unlock;
 
-			if (old_base != new_base) {
-				/* Ensure the timer is serialized. */
-				if (old_base->running_timer == timer)
-					goto unlock;
-
-				if (!new_lock) {
-					spin_lock(&new_base->lock);
-					new_lock = 1;
-				}
+			if (!new_lock) {
+				spin_lock(&new_base->lock);
+				new_lock = 1;
 			}
 		}
 
 		ret = 0;
-		/* We hold timer->lock, no need to check old_base != 0. */
 		if (timer_pending(timer)) {
 			list_del(&timer->entry);
 			ret = 1;
@@ -224,11 +246,9 @@ int __mod_timer(struct timer_list *timer
 		internal_add_timer(new_base, timer);
 		__set_base(timer, new_base, 1);
 unlock:
-		if (old_base)
-			spin_unlock(&old_base->lock);
 		if (new_lock)
 			spin_unlock(&new_base->lock);
-		spin_unlock_irqrestore(&timer->lock, flags);
+		spin_unlock_irqrestore(&old_base->lock, flags);
 	} while (ret == -1);
 
 	return ret;
@@ -355,19 +375,14 @@ EXPORT_SYMBOL(del_timer);
  */
 int del_timer_sync(struct timer_list *timer)
 {
-	int ret;
+	unsigned long flags;
+	tvec_base_t *base;
+	int ret = -1;
 
 	check_timer(timer);
 
-	ret = 0;
-	for (;;) {
-		unsigned long flags;
-		tvec_base_t *base;
-
+	do {
 		base = timer_base(timer);
-		if (!base)
-			return ret;
-
 		spin_lock_irqsave(&base->lock, flags);
 
 		if (base->running_timer == timer)
@@ -376,18 +391,19 @@ int del_timer_sync(struct timer_list *ti
 		if (timer_base(timer) != base)
 			goto unlock;
 
+		ret = 0;
 		if (timer_pending(timer)) {
 			list_del(&timer->entry);
+			__set_base(timer, base, 0);
 			ret = 1;
 		}
-		/* Need to make sure that anybody who sees a NULL base
-		 * also sees the list ops */
-		smp_wmb();
-		timer->_base = NULL;
 unlock:
 		spin_unlock_irqrestore(&base->lock, flags);
-	}
+	} while (ret == -1);
+
+	return ret;
 }
+
 EXPORT_SYMBOL(del_timer_sync);
 
 /***
@@ -1323,22 +1339,16 @@ static void __devinit init_timers_cpu(in
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
+static void migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
 {
 	struct timer_list *timer;
 
 	while (!list_empty(head)) {
 		timer = list_entry(head->next, struct timer_list, entry);
-		/* We're locking backwards from __mod_timer order here,
-		   beware deadlock. */
-		if (!spin_trylock(&timer->lock))
-			return 0;
 		list_del(&timer->entry);
 		internal_add_timer(new_base, timer);
 		__set_base(timer, new_base, 1);
-		spin_unlock(&timer->lock);
 	}
-	return 1;
 }
 
 static void __devinit migrate_timers(int cpu)
@@ -1352,7 +1362,6 @@ static void __devinit migrate_timers(int
 	new_base = &get_cpu_var(tvec_bases);
 
 	local_irq_disable();
-again:
 	/* Prevent deadlocks via ordering by old_base < new_base. */
 	if (old_base < new_base) {
 		spin_lock(&new_base->lock);
@@ -1365,26 +1374,17 @@ again:
 	if (old_base->running_timer)
 		BUG();
 	for (i = 0; i < TVR_SIZE; i++)
-		if (!migrate_timer_list(new_base, old_base->tv1.vec + i))
-			goto unlock_again;
-	for (i = 0; i < TVN_SIZE; i++)
-		if (!migrate_timer_list(new_base, old_base->tv2.vec + i)
-		    || !migrate_timer_list(new_base, old_base->tv3.vec + i)
-		    || !migrate_timer_list(new_base, old_base->tv4.vec + i)
-		    || !migrate_timer_list(new_base, old_base->tv5.vec + i))
-			goto unlock_again;
+		migrate_timer_list(new_base, old_base->tv1.vec + i);
+	for (i = 0; i < TVN_SIZE; i++) {
+		migrate_timer_list(new_base, old_base->tv2.vec + i);
+		migrate_timer_list(new_base, old_base->tv3.vec + i);
+		migrate_timer_list(new_base, old_base->tv4.vec + i);
+		migrate_timer_list(new_base, old_base->tv5.vec + i);
+	}
 	spin_unlock(&old_base->lock);
 	spin_unlock(&new_base->lock);
 	local_irq_enable();
 	put_cpu_var(tvec_bases);
-	return;
-
-unlock_again:
-	/* Avoid deadlock with __mod_timer, by backing off. */
-	spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
-	cpu_relax();
-	goto again;
 }
 #endif /* CONFIG_HOTPLUG_CPU */

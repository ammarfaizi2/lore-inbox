Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVDALw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVDALw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVDALwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:52:55 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:47488 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262718AbVDALvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:51:54 -0500
Message-ID: <424D373F.1BCBF2AC@tv-sign.ru>
Date: Fri, 01 Apr 2005 15:57:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] timers fixes/improvements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces and updates 6 timer patches which are currently
in -mm tree. This version does not play games with __TIMER_PENDING
bit, so incremental patch is not suitable. It is against 2.6.12-rc1.
Please comment. I am sending pseudo code in a separate message for
easier review.


This patch tries to solve following problems:

1. del_timer_sync() is racy. The timer can be fired again after
   del_timer_sync have checked all cpus and before it will recheck
   timer_pending().

2. It has scalability problems. All cpus are scanned to determine
   if the timer is running on that cpu.

   With this patch del_timer_sync is O(1) and no slower than plain
   del_timer(pending_timer), unless it has to actually wait for
   completion of the currently running timer.

   The only restriction is that the recurring timer should not use
   add_timer_on().

3. The timers are not serialized wrt to itself.

   If CPU_0 does mod_timer(jiffies+1) while the timer is currently
   running on CPU 1, it is quite possible that local interrupt on
   CPU_0 will start that timer before it finished on CPU_1.

4. The timers locking is suboptimal. __mod_timer() takes 3 locks
   at once and still requires wmb() in del_timer/run_timers.

   The new implementation takes 2 locks sequentially and does not
   need memory barriers.


Currently ->base != NULL means that the timer is pending. In
that case ->base.lock is used to lock the timer. __mod_timer
also takes timer->lock because ->base can be == NULL.

This patch uses timer->entry.next != NULL as indication that
the timer is pending. So it does __list_del(), entry->next = NULL
instead of list_del() when the timer is deleted.

__run_timers(), del_timer() do not set ->base = NULL anymore, they
only clear pending flag, so that del_timer_sync() can wait while
timer->base->running_timer == timer.

The ->base field is used for hashed locking only. init_timer()
sets ->base = per_cpu(tvec_bases) and it is changed only in
__mod_timer(), when the timer changes CPU. Now the timer always
can be locked through ->base->lock, so timer_list->lock can be
killed and we don't need memory barriers in __run_timers/del_timer.

It is pointless to use ->base directly, it can change at any moment.
This patch adds lock_timer_base() helper, which locks timer's base,
and checks it is still the same. It also checks that ->base != NULL,
see below.

__mod_timer() do not locks both bases at once. It locks timer via
lock_timer_base(), __list_del(timer), sets ->base = NULL temporally,
and unlocks old_base. Now:
	1. This timer can't be seen in __run_timers() via ->entry,
	   it is already removed from list.
	2. Nobody can lock this timer because lock_timer_base()
	   waits for ->base != NULL.
	3. If the timer was pending - it is still pending, so
	   concurrent del_timer() will spin in lock_timer_base().

Then __mod_timer() locks new_base and adds this timer. I hope it
may improve scalability of timers. It also simplifies the code,
because AB-BA deadlock is not possible.

On the other hand, when __run_timers()/migrate_timers() locks
tvec_bases->lock it can safely traverse ->tvX lists, all timers
have valid ->base != NULL and locked.

One problem. TIMER_INITIALIZER can't use per_cpu(tvec_bases). So
this patch adds global
	struct timer_base_s {
		spinlock_t lock;
		struct timer_list *running_timer;
	} __init_timer_base;
which is used by TIMER_INITIALIZER. The corresponding fields in
struct tvec_t_base_s are replaced by struct timer_base_s t_base.

It is indeed ugly. But this can't have scalability problems. The
global __init_timer_base.lock is used only when __mod_timer() is
called for the first time AND the timer was compile time initialized.
After that the timer migrates to the local CPU.

This patch lessens timer.o size even without deleting now unneeded
del_singleshot_timer_sync(). In my opinion it also simplifies the
code.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/include/linux/timer.h~	2004-09-13 09:32:56.000000000 +0400
+++ 2.6.12-rc1/include/linux/timer.h	2005-04-01 00:33:33.000000000 +0400
@@ -6,45 +6,33 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 
-struct tvec_t_base_s;
+struct timer_base_s;
 
 struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
 
-	spinlock_t lock;
 	unsigned long magic;
 
 	void (*function)(unsigned long);
 	unsigned long data;
 
-	struct tvec_t_base_s *base;
+	struct timer_base_s *_base;
 };
 
 #define TIMER_MAGIC	0x4b87ad6e
 
+extern struct timer_base_s __init_timer_base;
+
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		.base = NULL,					\
+		._base = &__init_timer_base,			\
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
-	timer->base = NULL;
-	timer->magic = TIMER_MAGIC;
-	spin_lock_init(&timer->lock);
-}
+void fastcall init_timer(struct timer_list * timer);
 
 /***
  * timer_pending - is a timer pending?
@@ -58,7 +46,7 @@ static inline void init_timer(struct tim
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->base != NULL;
+	return timer->entry.next != NULL;
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
@@ -89,12 +77,12 @@ static inline void add_timer(struct time
 
 #ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list *timer);
-  extern int del_singleshot_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t) del_timer(t)
-# define del_singleshot_timer_sync(t) del_timer(t)
 #endif
 
+#define del_singleshot_timer_sync(t) del_timer_sync(t)
+
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
--- 2.6.12-rc1/kernel/timer.c~	2005-03-19 14:16:53.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-04-01 16:09:56.000000000 +0400
@@ -57,6 +57,11 @@ static void time_interpolator_update(lon
 #define TVN_MASK (TVN_SIZE - 1)
 #define TVR_MASK (TVR_SIZE - 1)
 
+struct timer_base_s {
+	spinlock_t lock;
+	struct timer_list *running_timer;
+};
+
 typedef struct tvec_s {
 	struct list_head vec[TVN_SIZE];
 } tvec_t;
@@ -66,9 +71,8 @@ typedef struct tvec_root_s {
 } tvec_root_t;
 
 struct tvec_t_base_s {
-	spinlock_t lock;
+	struct timer_base_s t_base;
 	unsigned long timer_jiffies;
-	struct timer_list *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -77,18 +81,16 @@ struct tvec_t_base_s {
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
+static DEFINE_PER_CPU(tvec_base_t, tvec_bases);
 
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
 {
 #ifdef CONFIG_SMP
-	base->running_timer = timer;
+	base->t_base.running_timer = timer;
 #endif
 }
 
-/* Fake initialization */
-static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
-
 static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
@@ -103,7 +105,6 @@ static void check_timer_failed(struct ti
 	/*
 	 * Now fix it up
 	 */
-	spin_lock_init(&timer->lock);
 	timer->magic = TIMER_MAGIC;
 }
 
@@ -156,65 +157,96 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
+typedef struct timer_base_s timer_base_t;
+timer_base_t __init_timer_base
+	____cacheline_aligned_in_smp = { .lock = SPIN_LOCK_UNLOCKED };
+EXPORT_SYMBOL(__init_timer_base);
+
+/***
+ * init_timer - initialize a timer.
+ * @timer: the timer to be initialized
+ *
+ * init_timer() must be done to a timer prior calling *any* of the
+ * other timer functions.
+ */
+void fastcall init_timer(struct timer_list *timer)
+{
+	timer->entry.next = NULL;
+	timer->_base = &per_cpu(tvec_bases,
+			__smp_processor_id()).t_base;
+	timer->magic = TIMER_MAGIC;
+}
+EXPORT_SYMBOL(init_timer);
+
+static inline void detach_timer(struct timer_list *timer,
+					int clear_pending)
+{
+	struct list_head *entry = &timer->entry;
+
+	__list_del(entry->prev, entry->next);
+	if (clear_pending)
+		entry->next = NULL;
+	entry->prev = LIST_POISON2;
+}
+
+static timer_base_t *lock_timer_base(struct timer_list *timer,
+					unsigned long *flags)
+{
+	timer_base_t *base;
+
+	for (;;) {
+		base = timer->_base;
+		/* Can be NULL while __mod_timer switches bases */
+		if (likely(base != NULL)) {
+			spin_lock_irqsave(&base->lock, *flags);
+			if (likely(base == timer->_base))
+				return base;
+			spin_unlock_irqrestore(&base->lock, *flags);
+		}
+		cpu_relax();
+	}
+}
+
 int __mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	tvec_base_t *old_base, *new_base;
+	timer_base_t *base;
+	tvec_base_t *new_base;
 	unsigned long flags;
-	int ret = 0;
+	int ret = -1;
 
 	BUG_ON(!timer->function);
-
 	check_timer(timer);
 
-	spin_lock_irqsave(&timer->lock, flags);
-	new_base = &__get_cpu_var(tvec_bases);
-repeat:
-	old_base = timer->base;
+	do {
+		base = lock_timer_base(timer, &flags);
+		new_base = &__get_cpu_var(tvec_bases);
 
-	/*
-	 * Prevent deadlocks via ordering by old_base < new_base.
-	 */
-	if (old_base && (new_base != old_base)) {
-		if (old_base < new_base) {
-			spin_lock(&new_base->lock);
-			spin_lock(&old_base->lock);
-		} else {
-			spin_lock(&old_base->lock);
-			spin_lock(&new_base->lock);
+		/* Ensure the timer is serialized. */
+		if (base != &new_base->t_base
+			&& base->running_timer == timer)
+			goto unlock;
+
+		ret = 0;
+		if (timer_pending(timer)) {
+			detach_timer(timer, 0);
+			ret = 1;
 		}
-		/*
-		 * The timer base might have been cancelled while we were
-		 * trying to take the lock(s):
-		 */
-		if (timer->base != old_base) {
-			spin_unlock(&new_base->lock);
-			spin_unlock(&old_base->lock);
-			goto repeat;
-		}
-	} else {
-		spin_lock(&new_base->lock);
-		if (timer->base != old_base) {
-			spin_unlock(&new_base->lock);
-			goto repeat;
+
+		if (base != &new_base->t_base) {
+			timer->_base = NULL;
+			/* Safe: the timer can't be seen via ->entry,
+			 * and lock_timer_base checks ->_base != 0. */
+			spin_unlock(&base->lock);
+			base = &new_base->t_base;
+			spin_lock(&base->lock);
+			timer->_base = base;
 		}
-	}
 
-	/*
-	 * Delete the previous timeout (if there was any), and install
-	 * the new one:
-	 */
-	if (old_base) {
-		list_del(&timer->entry);
-		ret = 1;
-	}
-	timer->expires = expires;
-	internal_add_timer(new_base, timer);
-	timer->base = new_base;
-
-	if (old_base && (new_base != old_base))
-		spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
-	spin_unlock_irqrestore(&timer->lock, flags);
+		timer->expires = expires;
+		internal_add_timer(new_base, timer);
+unlock:
+		spin_unlock_irqrestore(&base->lock, flags);
+	} while (ret < 0);
 
 	return ret;
 }
@@ -232,15 +264,15 @@ void add_timer_on(struct timer_list *tim
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
   	unsigned long flags;
-  
+
   	BUG_ON(timer_pending(timer) || !timer->function);
 
 	check_timer(timer);
 
-	spin_lock_irqsave(&base->lock, flags);
+	spin_lock_irqsave(&base->t_base.lock, flags);
+	timer->_base = &base->t_base;
 	internal_add_timer(base, timer);
-	timer->base = base;
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock_irqrestore(&base->t_base.lock, flags);
 }
 
 
@@ -295,27 +327,22 @@ EXPORT_SYMBOL(mod_timer);
  */
 int del_timer(struct timer_list *timer)
 {
+	timer_base_t *base;
 	unsigned long flags;
-	tvec_base_t *base;
+	int ret = 0;
 
 	check_timer(timer);
 
-repeat:
- 	base = timer->base;
-	if (!base)
-		return 0;
-	spin_lock_irqsave(&base->lock, flags);
-	if (base != timer->base) {
+	if (timer_pending(timer)) {
+		base = lock_timer_base(timer, &flags);
+		if (timer_pending(timer)) {
+			detach_timer(timer, 1);
+			ret = 1;
+		}
 		spin_unlock_irqrestore(&base->lock, flags);
-		goto repeat;
 	}
-	list_del(&timer->entry);
-	/* Need to make sure that anybody who sees a NULL base also sees the list ops */
-	smp_wmb();
-	timer->base = NULL;
-	spin_unlock_irqrestore(&base->lock, flags);
 
-	return 1;
+	return ret;
 }
 
 EXPORT_SYMBOL(del_timer);
@@ -332,72 +359,39 @@ EXPORT_SYMBOL(del_timer);
  * Synchronization rules: callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts. The caller must not hold locks which would prevent
- * completion of the timer's handler.  Upon exit the timer is not queued and
- * the handler is not running on any CPU.
+ * completion of the timer's handler. The timer's handler must not call
+ * add_timer_on(). Upon exit the timer is not queued and the handler is
+ * not running on any CPU.
  *
  * The function returns whether it has deactivated a pending timer or not.
- *
- * del_timer_sync() is slow and complicated because it copes with timer
- * handlers which re-arm the timer (periodic timers).  If the timer handler
- * is known to not do this (a single shot timer) then use
- * del_singleshot_timer_sync() instead.
  */
 int del_timer_sync(struct timer_list *timer)
 {
-	tvec_base_t *base;
-	int i, ret = 0;
+	timer_base_t *base;
+	unsigned long flags;
+	int ret = -1;
 
 	check_timer(timer);
 
-del_again:
-	ret += del_timer(timer);
+	do {
+		base = lock_timer_base(timer, &flags);
 
-	for_each_online_cpu(i) {
-		base = &per_cpu(tvec_bases, i);
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_check_resched();
-			}
-			break;
+		if (base->running_timer == timer)
+			goto unlock;
+
+		ret = 0;
+		if (timer_pending(timer)) {
+			detach_timer(timer, 1);
+			ret = 1;
 		}
-	}
-	smp_rmb();
-	if (timer_pending(timer))
-		goto del_again;
+unlock:
+		spin_unlock_irqrestore(&base->lock, flags);
+	} while (ret < 0);
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-
-/***
- * del_singleshot_timer_sync - deactivate a non-recursive timer
- * @timer: the timer to be deactivated
- *
- * This function is an optimization of del_timer_sync for the case where the
- * caller can guarantee the timer does not reschedule itself in its timer
- * function.
- *
- * Synchronization rules: callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. The caller must not hold locks which wold prevent
- * completion of the timer's handler.  Upon exit the timer is not queued and
- * the handler is not running on any CPU.
- *
- * The function returns whether it has deactivated a pending timer or not.
- */
-int del_singleshot_timer_sync(struct timer_list *timer)
-{
-	int ret = del_timer(timer);
 
-	if (!ret) {
-		ret = del_timer_sync(timer);
-		BUG_ON(ret);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(del_singleshot_timer_sync);
+EXPORT_SYMBOL(del_timer_sync);
 #endif
 
 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
@@ -415,7 +409,7 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != base);
+		BUG_ON(tmp->_base != &base->t_base);
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}
@@ -437,7 +431,7 @@ static inline void __run_timers(tvec_bas
 {
 	struct timer_list *timer;
 
-	spin_lock_irq(&base->lock);
+	spin_lock_irq(&base->t_base.lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
@@ -462,11 +456,9 @@ repeat:
  			fn = timer->function;
  			data = timer->data;
 
-			list_del(&timer->entry);
 			set_running_timer(base, timer);
-			smp_wmb();
-			timer->base = NULL;
-			spin_unlock_irq(&base->lock);
+			detach_timer(timer, 1);
+			spin_unlock_irq(&base->t_base.lock);
 			{
 				u32 preempt_count = preempt_count();
 				fn(data);
@@ -475,12 +467,12 @@ repeat:
 					BUG();
 				}
 			}
-			spin_lock_irq(&base->lock);
+			spin_lock_irq(&base->t_base.lock);
 			goto repeat;
 		}
 	}
 	set_running_timer(base, NULL);
-	spin_unlock_irq(&base->lock);
+	spin_unlock_irq(&base->t_base.lock);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -1286,9 +1278,9 @@ static void __devinit init_timers_cpu(in
 {
 	int j;
 	tvec_base_t *base;
-       
+
 	base = &per_cpu(tvec_bases, cpu);
-	spin_lock_init(&base->lock);
+	spin_lock_init(&base->t_base.lock);
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
 		INIT_LIST_HEAD(base->tv4.vec + j);
@@ -1302,22 +1294,16 @@ static void __devinit init_timers_cpu(in
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
-		list_del(&timer->entry);
+		detach_timer(timer, 0);
+		timer->_base = &new_base->t_base;
 		internal_add_timer(new_base, timer);
-		timer->base = new_base;
-		spin_unlock(&timer->lock);
 	}
-	return 1;
 }
 
 static void __devinit migrate_timers(int cpu)
@@ -1331,39 +1317,24 @@ static void __devinit migrate_timers(int
 	new_base = &get_cpu_var(tvec_bases);
 
 	local_irq_disable();
-again:
-	/* Prevent deadlocks via ordering by old_base < new_base. */
-	if (old_base < new_base) {
-		spin_lock(&new_base->lock);
-		spin_lock(&old_base->lock);
-	} else {
-		spin_lock(&old_base->lock);
-		spin_lock(&new_base->lock);
-	}
+	spin_lock(&new_base->t_base.lock);
+	spin_lock(&old_base->t_base.lock);
 
-	if (old_base->running_timer)
+	if (old_base->t_base.running_timer)
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
-	spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
+		migrate_timer_list(new_base, old_base->tv1.vec + i);
+	for (i = 0; i < TVN_SIZE; i++) {
+		migrate_timer_list(new_base, old_base->tv2.vec + i);
+		migrate_timer_list(new_base, old_base->tv3.vec + i);
+		migrate_timer_list(new_base, old_base->tv4.vec + i);
+		migrate_timer_list(new_base, old_base->tv5.vec + i);
+	}
+
+	spin_unlock(&old_base->t_base.lock);
+	spin_unlock(&new_base->t_base.lock);
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
 
_

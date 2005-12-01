Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVLAADu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVLAADu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVLAADX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:03:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:7843
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751317AbVK3X62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:28 -0500
Subject: [patch 29/43] Convert ktimeout.c to ktimeout struct and APIs
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:58 +0100
Message-Id: <1133395438.32542.472.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-c-convert.patch)
- convert ktimeout.c to use the new ktimeout structs and APIs

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/ktimeout.c |  360 +++++++++++++++++++++++++++---------------------------
 1 files changed, 180 insertions(+), 180 deletions(-)

Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -5,8 +5,8 @@
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
- *  1997-01-28  Modified by Finn Arne Gangstad to make timers scale better.
- *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
+ *  1997-01-28  Modified by Finn Arne Gangstad to make timeouts scale better.
+ *  2000-10-05  Implemented scalable SMP per-CPU timeout handling.
  *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
  *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
  */
@@ -33,7 +33,7 @@
 #include <asm/io.h>
 
 /*
- * per-CPU timer vector definitions:
+ * per-CPU ktimeout vector definitions:
  */
 
 #define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
@@ -43,9 +43,9 @@
 #define TVN_MASK (TVN_SIZE - 1)
 #define TVR_MASK (TVR_SIZE - 1)
 
-struct timer_base_s {
+struct ktimeout_base_s {
 	spinlock_t lock;
-	struct timer_list *running_timer;
+	struct ktimeout *running_ktimeout;
 };
 
 typedef struct tvec_s {
@@ -57,8 +57,8 @@ typedef struct tvec_root_s {
 } tvec_root_t;
 
 struct tvec_t_base_s {
-	struct timer_base_s t_base;
-	unsigned long timer_jiffies;
+	struct ktimeout_base_s t_base;
+	unsigned long ktimeout_jiffies;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -69,18 +69,18 @@ struct tvec_t_base_s {
 typedef struct tvec_t_base_s tvec_base_t;
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases);
 
-static inline void set_running_timer(tvec_base_t *base,
-					struct timer_list *timer)
+static inline void set_running_ktimeout(tvec_base_t *base,
+					struct ktimeout *ktimeout)
 {
 #ifdef CONFIG_SMP
-	base->t_base.running_timer = timer;
+	base->t_base.running_ktimeout = ktimeout;
 #endif
 }
 
-static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
+static void internal_add_ktimeout(tvec_base_t *base, struct ktimeout *ktimeout)
 {
-	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
+	unsigned long expires = ktimeout->expires;
+	unsigned long idx = expires - base->ktimeout_jiffies;
 	struct list_head *vec;
 
 	if (idx < TVR_SIZE) {
@@ -97,10 +97,10 @@ static void internal_add_timer(tvec_base
 		vec = base->tv4.vec + i;
 	} else if ((signed long) idx < 0) {
 		/*
-		 * Can happen if you add a timer with expires == jiffies,
-		 * or you set a timer to go off in the past
+		 * Can happen if you add a ktimeout with expires == jiffies,
+		 * or you set a ktimeout to go off in the past
 		 */
-		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
+		vec = base->tv1.vec + (base->ktimeout_jiffies & TVR_MASK);
 	} else {
 		int i;
 		/* If the timeout is larger than 0xffffffff on 64-bit
@@ -108,7 +108,7 @@ static void internal_add_timer(tvec_base
 		 */
 		if (idx > 0xffffffffUL) {
 			idx = 0xffffffffUL;
-			expires = idx + base->timer_jiffies;
+			expires = idx + base->ktimeout_jiffies;
 		}
 		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
@@ -116,36 +116,36 @@ static void internal_add_timer(tvec_base
 	/*
 	 * Timers are FIFO:
 	 */
-	list_add_tail(&timer->entry, vec);
+	list_add_tail(&ktimeout->entry, vec);
 }
 
-typedef struct timer_base_s timer_base_t;
+typedef struct ktimeout_base_s ktimeout_base_t;
 /*
  * Used by TIMER_INITIALIZER, we can't use per_cpu(tvec_bases)
- * at compile time, and we need timer->base to lock the timer.
+ * at compile time, and we need ktimeout->base to lock the ktimeout.
  */
-timer_base_t __init_timer_base
+ktimeout_base_t __init_ktimeout_base
 	____cacheline_aligned_in_smp = { .lock = SPIN_LOCK_UNLOCKED };
-EXPORT_SYMBOL(__init_timer_base);
+EXPORT_SYMBOL(__init_ktimeout_base);
 
 /***
- * init_timer - initialize a timer.
- * @timer: the timer to be initialized
+ * init_ktimeout - initialize a ktimeout.
+ * @ktimeout: the ktimeout to be initialized
  *
- * init_timer() must be done to a timer prior calling *any* of the
- * other timer functions.
+ * init_ktimeout() must be done to a ktimeout prior calling *any* of the
+ * other ktimeout functions.
  */
-void fastcall init_timer(struct timer_list *timer)
+void fastcall init_ktimeout(struct ktimeout *ktimeout)
 {
-	timer->entry.next = NULL;
-	timer->base = &per_cpu(tvec_bases, raw_smp_processor_id()).t_base;
+	ktimeout->entry.next = NULL;
+	ktimeout->base = &per_cpu(tvec_bases, raw_smp_processor_id()).t_base;
 }
-EXPORT_SYMBOL(init_timer);
+EXPORT_SYMBOL(init_ktimeout);
 
-static inline void detach_timer(struct timer_list *timer,
+static inline void detach_ktimeout(struct ktimeout *ktimeout,
 					int clear_pending)
 {
-	struct list_head *entry = &timer->entry;
+	struct list_head *entry = &ktimeout->entry;
 
 	__list_del(entry->prev, entry->next);
 	if (clear_pending)
@@ -155,47 +155,47 @@ static inline void detach_timer(struct t
 
 /*
  * We are using hashed locking: holding per_cpu(tvec_bases).t_base.lock
- * means that all timers which are tied to this base via timer->base are
+ * means that all ktimeouts which are tied to this base via ktimeout->base are
  * locked, and the base itself is locked too.
  *
- * So __run_timers/migrate_timers can safely modify all timers which could
+ * So __run_ktimeouts/migrate_ktimeouts can safely modify all ktimeouts which could
  * be found on ->tvX lists.
  *
- * When the timer's base is locked, and the timer removed from list, it is
- * possible to set timer->base = NULL and drop the lock: the timer remains
+ * When the ktimeout's base is locked, and the ktimeout removed from list, it is
+ * possible to set ktimeout->base = NULL and drop the lock: the ktimeout remains
  * locked.
  */
-static timer_base_t *lock_timer_base(struct timer_list *timer,
+static ktimeout_base_t *lock_ktimeout_base(struct ktimeout *ktimeout,
 					unsigned long *flags)
 {
-	timer_base_t *base;
+	ktimeout_base_t *base;
 
 	for (;;) {
-		base = timer->base;
+		base = ktimeout->base;
 		if (likely(base != NULL)) {
 			spin_lock_irqsave(&base->lock, *flags);
-			if (likely(base == timer->base))
+			if (likely(base == ktimeout->base))
 				return base;
-			/* The timer has migrated to another CPU */
+			/* The ktimeout has migrated to another CPU */
 			spin_unlock_irqrestore(&base->lock, *flags);
 		}
 		cpu_relax();
 	}
 }
 
-int __mod_timer(struct timer_list *timer, unsigned long expires)
+int __mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires)
 {
-	timer_base_t *base;
+	ktimeout_base_t *base;
 	tvec_base_t *new_base;
 	unsigned long flags;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	BUG_ON(!ktimeout->function);
 
-	base = lock_timer_base(timer, &flags);
+	base = lock_ktimeout_base(ktimeout, &flags);
 
-	if (timer_pending(timer)) {
-		detach_timer(timer, 0);
+	if (ktimeout_pending(ktimeout)) {
+		detach_ktimeout(ktimeout, 0);
 		ret = 1;
 	}
 
@@ -203,110 +203,110 @@ int __mod_timer(struct timer_list *timer
 
 	if (base != &new_base->t_base) {
 		/*
-		 * We are trying to schedule the timer on the local CPU.
-		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
+		 * We are trying to schedule the ktimeout on the local CPU.
+		 * However we can't change ktimeout's base while it is running,
+		 * otherwise del_ktimeout_sync() can't detect that the ktimeout's
 		 * handler yet has not finished. This also guarantees that
-		 * the timer is serialized wrt itself.
+		 * the ktimeout is serialized wrt itself.
 		 */
-		if (unlikely(base->running_timer == timer)) {
-			/* The timer remains on a former base */
+		if (unlikely(base->running_ktimeout == ktimeout)) {
+			/* The ktimeout remains on a former base */
 			new_base = container_of(base, tvec_base_t, t_base);
 		} else {
-			/* See the comment in lock_timer_base() */
-			timer->base = NULL;
+			/* See the comment in lock_ktimeout_base() */
+			ktimeout->base = NULL;
 			spin_unlock(&base->lock);
 			spin_lock(&new_base->t_base.lock);
-			timer->base = &new_base->t_base;
+			ktimeout->base = &new_base->t_base;
 		}
 	}
 
-	timer->expires = expires;
-	internal_add_timer(new_base, timer);
+	ktimeout->expires = expires;
+	internal_add_ktimeout(new_base, ktimeout);
 	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
 
 	return ret;
 }
 
-EXPORT_SYMBOL(__mod_timer);
+EXPORT_SYMBOL(__mod_ktimeout);
 
 /***
- * add_timer_on - start a timer on a particular CPU
- * @timer: the timer to be added
+ * add_ktimeout_on - start a ktimeout on a particular CPU
+ * @ktimeout: the ktimeout to be added
  * @cpu: the CPU to start it on
  *
  * This is not very scalable on SMP. Double adds are not possible.
  */
-void add_timer_on(struct timer_list *timer, int cpu)
+void add_ktimeout_on(struct ktimeout *ktimeout, int cpu)
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
   	unsigned long flags;
 
-  	BUG_ON(timer_pending(timer) || !timer->function);
+  	BUG_ON(ktimeout_pending(ktimeout) || !ktimeout->function);
 	spin_lock_irqsave(&base->t_base.lock, flags);
-	timer->base = &base->t_base;
-	internal_add_timer(base, timer);
+	ktimeout->base = &base->t_base;
+	internal_add_ktimeout(base, ktimeout);
 	spin_unlock_irqrestore(&base->t_base.lock, flags);
 }
 

 /***
- * mod_timer - modify a timer's timeout
- * @timer: the timer to be modified
+ * mod_ktimeout - modify a ktimeout's timeout
+ * @ktimeout: the ktimeout to be modified
  *
- * mod_timer is a more efficient way to update the expire field of an
- * active timer (if the timer is inactive it will be activated)
+ * mod_ktimeout is a more efficient way to update the expire field of an
+ * active ktimeout (if the ktimeout is inactive it will be activated)
  *
- * mod_timer(timer, expires) is equivalent to:
+ * mod_ktimeout(ktimeout, expires) is equivalent to:
  *
- *     del_timer(timer); timer->expires = expires; add_timer(timer);
+ *     del_ktimeout(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
  *
  * Note that if there are multiple unserialized concurrent users of the
- * same timer, then mod_timer() is the only safe way to modify the timeout,
- * since add_timer() cannot modify an already running timer.
+ * same ktimeout, then mod_ktimeout() is the only safe way to modify the timeout,
+ * since add_ktimeout() cannot modify an already running ktimeout.
  *
- * The function returns whether it has modified a pending timer or not.
- * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
- * active timer returns 1.)
+ * The function returns whether it has modified a pending ktimeout or not.
+ * (ie. mod_ktimeout() of an inactive ktimeout returns 0, mod_ktimeout() of an
+ * active ktimeout returns 1.)
  */
-int mod_timer(struct timer_list *timer, unsigned long expires)
+int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires)
 {
-	BUG_ON(!timer->function);
+	BUG_ON(!ktimeout->function);
 
 	/*
 	 * This is a common optimization triggered by the
-	 * networking code - if the timer is re-modified
+	 * networking code - if the ktimeout is re-modified
 	 * to be the same thing then just return:
 	 */
-	if (timer->expires == expires && timer_pending(timer))
+	if (ktimeout->expires == expires && ktimeout_pending(ktimeout))
 		return 1;
 
-	return __mod_timer(timer, expires);
+	return __mod_ktimeout(ktimeout, expires);
 }
 
-EXPORT_SYMBOL(mod_timer);
+EXPORT_SYMBOL(mod_ktimeout);
 
 /***
- * del_timer - deactive a timer.
- * @timer: the timer to be deactivated
+ * del_ktimeout - deactive a ktimeout.
+ * @ktimeout: the ktimeout to be deactivated
  *
- * del_timer() deactivates a timer - this works on both active and inactive
- * timers.
+ * del_ktimeout() deactivates a ktimeout - this works on both active and inactive
+ * ktimeouts.
  *
- * The function returns whether it has deactivated a pending timer or not.
- * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
- * active timer returns 1.)
+ * The function returns whether it has deactivated a pending ktimeout or not.
+ * (ie. del_ktimeout() of an inactive ktimeout returns 0, del_ktimeout() of an
+ * active ktimeout returns 1.)
  */
-int del_timer(struct timer_list *timer)
+int del_ktimeout(struct ktimeout *ktimeout)
 {
-	timer_base_t *base;
+	ktimeout_base_t *base;
 	unsigned long flags;
 	int ret = 0;
 
-	if (timer_pending(timer)) {
-		base = lock_timer_base(timer, &flags);
-		if (timer_pending(timer)) {
-			detach_timer(timer, 1);
+	if (ktimeout_pending(ktimeout)) {
+		base = lock_ktimeout_base(ktimeout, &flags);
+		if (ktimeout_pending(ktimeout)) {
+			detach_ktimeout(ktimeout, 1);
 			ret = 1;
 		}
 		spin_unlock_irqrestore(&base->lock, flags);
@@ -315,29 +315,29 @@ int del_timer(struct timer_list *timer)
 	return ret;
 }
 
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(del_ktimeout);
 
 #ifdef CONFIG_SMP
 /*
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
+ * This function tries to deactivate a ktimeout. Upon successful (ret >= 0)
+ * exit the ktimeout is not queued and the handler is not running on any CPU.
  *
  * It must not be called from interrupt contexts.
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+int try_to_del_ktimeout_sync(struct ktimeout *ktimeout)
 {
-	timer_base_t *base;
+	ktimeout_base_t *base;
 	unsigned long flags;
 	int ret = -1;
 
-	base = lock_timer_base(timer, &flags);
+	base = lock_ktimeout_base(ktimeout, &flags);
 
-	if (base->running_timer == timer)
+	if (base->running_ktimeout == ktimeout)
 		goto out;
 
 	ret = 0;
-	if (timer_pending(timer)) {
-		detach_timer(timer, 1);
+	if (ktimeout_pending(ktimeout)) {
+		detach_ktimeout(ktimeout, 1);
 		ret = 1;
 	}
 out:
@@ -347,52 +347,52 @@ out:
 }
 
 /***
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
+ * del_ktimeout_sync - deactivate a ktimeout and wait for the handler to finish.
+ * @ktimeout: the ktimeout to be deactivated
  *
- * This function only differs from del_timer() on SMP: besides deactivating
- * the timer it also makes sure the handler has finished executing on other
+ * This function only differs from del_ktimeout() on SMP: besides deactivating
+ * the ktimeout it also makes sure the handler has finished executing on other
  * CPUs.
  *
- * Synchronization rules: callers must prevent restarting of the timer,
+ * Synchronization rules: callers must prevent restarting of the ktimeout,
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts. The caller must not hold locks which would prevent
- * completion of the timer's handler. The timer's handler must not call
- * add_timer_on(). Upon exit the timer is not queued and the handler is
+ * completion of the ktimeout's handler. The ktimeout's handler must not call
+ * add_ktimeout_on(). Upon exit the ktimeout is not queued and the handler is
  * not running on any CPU.
  *
- * The function returns whether it has deactivated a pending timer or not.
+ * The function returns whether it has deactivated a pending ktimeout or not.
  */
-int del_timer_sync(struct timer_list *timer)
+int del_ktimeout_sync(struct ktimeout *ktimeout)
 {
 	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
+		int ret = try_to_del_ktimeout_sync(ktimeout);
 		if (ret >= 0)
 			return ret;
 	}
 }
 
-EXPORT_SYMBOL(del_timer_sync);
+EXPORT_SYMBOL(del_ktimeout_sync);
 #endif
 
 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
 {
-	/* cascade all the timers from tv up one level */
+	/* cascade all the ktimeouts from tv up one level */
 	struct list_head *head, *curr;
 
 	head = tv->vec + index;
 	curr = head->next;
 	/*
-	 * We are removing _all_ timers from the list, so we don't  have to
+	 * We are removing _all_ ktimeouts from the list, so we don't  have to
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
-		struct timer_list *tmp;
+		struct ktimeout *tmp;
 
-		tmp = list_entry(curr, struct timer_list, entry);
+		tmp = list_entry(curr, struct ktimeout, entry);
 		BUG_ON(tmp->base != &base->t_base);
 		curr = curr->next;
-		internal_add_timer(base, tmp);
+		internal_add_ktimeout(base, tmp);
 	}
 	INIT_LIST_HEAD(head);
 
@@ -400,44 +400,44 @@ static int cascade(tvec_base_t *base, tv
 }
 
 /***
- * __run_timers - run all expired timers (if any) on this CPU.
- * @base: the timer vector to be processed.
+ * __run_ktimeouts - run all expired ktimeouts (if any) on this CPU.
+ * @base: the ktimeout vector to be processed.
  *
- * This function cascades all vectors and executes all expired timer
+ * This function cascades all vectors and executes all expired ktimeout
  * vectors.
  */
-#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+#define INDEX(N) (base->ktimeout_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
 
-static inline void __run_timers(tvec_base_t *base)
+static inline void __run_ktimeouts(tvec_base_t *base)
 {
-	struct timer_list *timer;
+	struct ktimeout *ktimeout;
 
 	spin_lock_irq(&base->t_base.lock);
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
+	while (time_after_eq(jiffies, base->ktimeout_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
- 		int index = base->timer_jiffies & TVR_MASK;
+ 		int index = base->ktimeout_jiffies & TVR_MASK;
  
 		/*
-		 * Cascade timers:
+		 * Cascade ktimeouts:
 		 */
 		if (!index &&
 			(!cascade(base, &base->tv2, INDEX(0))) &&
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
+		++base->ktimeout_jiffies; 
 		list_splice_init(base->tv1.vec + index, &work_list);
 		while (!list_empty(head)) {
 			void (*fn)(unsigned long);
 			unsigned long data;
 
-			timer = list_entry(head->next,struct timer_list,entry);
- 			fn = timer->function;
- 			data = timer->data;
+			ktimeout = list_entry(head->next,struct ktimeout,entry);
+ 			fn = ktimeout->function;
+ 			data = ktimeout->data;
 
-			set_running_timer(base, timer);
-			detach_timer(timer, 1);
+			set_running_ktimeout(base, ktimeout);
+			detach_ktimeout(ktimeout, 1);
 			spin_unlock_irq(&base->t_base.lock);
 			{
 				int preempt_count = preempt_count();
@@ -454,41 +454,41 @@ static inline void __run_timers(tvec_bas
 			spin_lock_irq(&base->t_base.lock);
 		}
 	}
-	set_running_timer(base, NULL);
+	set_running_ktimeout(base, NULL);
 	spin_unlock_irq(&base->t_base.lock);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
 /*
- * Find out when the next timer event is due to happen. This
+ * Find out when the next ktimeout event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
  * This functions needs to be called disabled.
  */
-unsigned long next_timer_interrupt(void)
+unsigned long next_ktimeout_interrupt(void)
 {
 	tvec_base_t *base;
 	struct list_head *list;
-	struct timer_list *nte;
+	struct ktimeout *nte;
 	unsigned long expires;
 	tvec_t *varray[4];
 	int i, j;
 
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
-	expires = base->timer_jiffies + (LONG_MAX >> 1);
+	expires = base->ktimeout_jiffies + (LONG_MAX >> 1);
 	list = 0;
 
-	/* Look for timer events in tv1. */
-	j = base->timer_jiffies & TVR_MASK;
+	/* Look for ktimeout events in tv1. */
+	j = base->ktimeout_jiffies & TVR_MASK;
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
 			expires = nte->expires;
-			if (j < (base->timer_jiffies & TVR_MASK))
+			if (j < (base->ktimeout_jiffies & TVR_MASK))
 				list = base->tv2.vec + (INDEX(0));
 			goto found;
 		}
 		j = (j + 1) & TVR_MASK;
-	} while (j != (base->timer_jiffies & TVR_MASK));
+	} while (j != (base->ktimeout_jiffies & TVR_MASK));
 
 	/* Check tv2-tv5. */
 	varray[0] = &base->tv2;
@@ -515,7 +515,7 @@ found:
 		/*
 		 * The search wrapped. We need to look at the next list
 		 * from next tv element that would cascade into tv element
-		 * where we found the timer element.
+		 * where we found the ktimeout element.
 		 */
 		list_for_each_entry(nte, list, entry) {
 			if (time_before(nte->expires, expires))
@@ -528,21 +528,21 @@ found:
 #endif
 
 /*
- * This function runs timers and the timer-tq in bottom half context.
+ * This function runs ktimeouts and the ktimeout-tq in bottom half context.
  */
-static void run_timer_softirq(struct softirq_action *h)
+static void run_ktimeout_softirq(struct softirq_action *h)
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
  	ktimer_run_queues();
-	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
+	if (time_after_eq(jiffies, base->ktimeout_jiffies))
+		__run_ktimeouts(base);
 }
 
 /*
- * Called by the local, per-CPU timer interrupt on SMP.
+ * Called by the local, per-CPU ktimeout interrupt on SMP.
  */
-void run_local_timers(void)
+void run_local_ktimeouts(void)
 {
 	raise_softirq(TIMER_SOFTIRQ);
 }
@@ -567,7 +567,7 @@ static void process_timeout(unsigned lon
  *
  * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
  * delivered to the current task. In this case the remaining time
- * in jiffies will be returned, or 0 if the timer expired in time
+ * in jiffies will be returned, or 0 if the ktimeout expired in time
  *
  * The current task state is guaranteed to be TASK_RUNNING when this
  * routine returns.
@@ -580,7 +580,7 @@ static void process_timeout(unsigned lon
  */
 fastcall signed long __sched schedule_timeout(signed long timeout)
 {
-	struct timer_list timer;
+	struct ktimeout ktimeout;
 	unsigned long expire;
 
 	switch (timeout)
@@ -615,10 +615,10 @@ fastcall signed long __sched schedule_ti
 
 	expire = timeout + jiffies;
 
-	setup_timer(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire);
+	setup_ktimeout(&ktimeout, process_timeout, (unsigned long)current);
+	__mod_ktimeout(&ktimeout, expire);
 	schedule();
-	del_singleshot_timer_sync(&timer);
+	del_singleshot_ktimeout_sync(&ktimeout);
 
 	timeout = expire - jiffies;
 
@@ -674,7 +674,7 @@ unsigned long msleep_interruptible(unsig
 
 EXPORT_SYMBOL(msleep_interruptible);
 
-static void __devinit init_timers_cpu(int cpu)
+static void __devinit init_ktimeouts_cpu(int cpu)
 {
 	int j;
 	tvec_base_t *base;
@@ -690,23 +690,23 @@ static void __devinit init_timers_cpu(in
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
-	base->timer_jiffies = jiffies;
+	base->ktimeout_jiffies = jiffies;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
+static void migrate_ktimeout(tvec_base_t *new_base, struct list_head *head)
 {
-	struct timer_list *timer;
+	struct ktimeout *ktimeout;
 
 	while (!list_empty(head)) {
-		timer = list_entry(head->next, struct timer_list, entry);
-		detach_timer(timer, 0);
-		timer->base = &new_base->t_base;
-		internal_add_timer(new_base, timer);
+		ktimeout = list_entry(head->next, struct ktimeout, entry);
+		detach_ktimeout(ktimeout, 0);
+		ktimeout->base = &new_base->t_base;
+		internal_add_ktimeout(new_base, ktimeout);
 	}
 }
 
-static void __devinit migrate_timers(int cpu)
+static void __devinit migrate_ktimeouts(int cpu)
 {
 	tvec_base_t *old_base;
 	tvec_base_t *new_base;
@@ -720,15 +720,15 @@ static void __devinit migrate_timers(int
 	spin_lock(&new_base->t_base.lock);
 	spin_lock(&old_base->t_base.lock);
 
-	if (old_base->t_base.running_timer)
+	if (old_base->t_base.running_ktimeout)
 		BUG();
 	for (i = 0; i < TVR_SIZE; i++)
-		migrate_timer_list(new_base, old_base->tv1.vec + i);
+		migrate_ktimeout(new_base, old_base->tv1.vec + i);
 	for (i = 0; i < TVN_SIZE; i++) {
-		migrate_timer_list(new_base, old_base->tv2.vec + i);
-		migrate_timer_list(new_base, old_base->tv3.vec + i);
-		migrate_timer_list(new_base, old_base->tv4.vec + i);
-		migrate_timer_list(new_base, old_base->tv5.vec + i);
+		migrate_ktimeout(new_base, old_base->tv2.vec + i);
+		migrate_ktimeout(new_base, old_base->tv3.vec + i);
+		migrate_ktimeout(new_base, old_base->tv4.vec + i);
+		migrate_ktimeout(new_base, old_base->tv5.vec + i);
 	}
 
 	spin_unlock(&old_base->t_base.lock);
@@ -738,17 +738,17 @@ static void __devinit migrate_timers(int
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static int __devinit timer_cpu_notify(struct notifier_block *self, 
+static int __devinit ktimeout_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
 	switch(action) {
 	case CPU_UP_PREPARE:
-		init_timers_cpu(cpu);
+		init_ktimeouts_cpu(cpu);
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
-		migrate_timers(cpu);
+		migrate_ktimeouts(cpu);
 		break;
 #endif
 	default:
@@ -757,15 +757,15 @@ static int __devinit timer_cpu_notify(st
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata timers_nb = {
-	.notifier_call	= timer_cpu_notify,
+static struct notifier_block __devinitdata ktimeouts_nb = {
+	.notifier_call	= ktimeout_cpu_notify,
 };
 

-void __init init_timers(void)
+void __init init_ktimeouts(void)
 {
-	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
+	ktimeout_cpu_notify(&ktimeouts_nb, (unsigned long)CPU_UP_PREPARE,
 				(void *)(long)smp_processor_id());
-	register_cpu_notifier(&timers_nb);
-	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
+	register_cpu_notifier(&ktimeouts_nb);
+	open_softirq(TIMER_SOFTIRQ, run_ktimeout_softirq, NULL);
 }

--


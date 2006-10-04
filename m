Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWJDRmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWJDRmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWJDRlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:41:52 -0400
Received: from www.osadl.org ([213.239.205.134]:21989 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161905AbWJDRh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:58 -0400
Message-Id: <20061004172223.009587000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:40 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 10/22] hrtimers: clean up locking
Content-Disposition: inline; filename=hrtimers-clean-up-locking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Improve kernel/hrtimers.c locking: use a per-CPU base with a lock to control
locking of all clocks belonging to a CPU.  This simplifies code that needs to
lock all clocks at once.  This makes life easier for high-res timers and
dyntick.  No functional change should happen due to this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
 include/linux/hrtimer.h |   43 +++++++----
 kernel/hrtimer.c        |  182 +++++++++++++++++++++++++-----------------------
 2 files changed, 125 insertions(+), 100 deletions(-)

Index: linux-2.6.18-mm3/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hrtimer.h	2006-10-04 18:13:55.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hrtimer.h	2006-10-04 18:13:56.000000000 +0200
@@ -21,6 +21,9 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 
+struct hrtimer_clock_base;
+struct hrtimer_cpu_base;
+
 /*
  * Mode arguments of xxx_hrtimer functions:
  */
@@ -37,8 +40,6 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,	/* Timer must be restarted */
 };
 
-struct hrtimer_base;
-
 /**
  * struct hrtimer - the basic hrtimer structure
  * @node:	red black tree node for time ordered insertion
@@ -51,10 +52,10 @@ struct hrtimer_base;
  * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()
  */
 struct hrtimer {
-	struct rb_node		node;
-	ktime_t			expires;
-	enum hrtimer_restart	(*function)(struct hrtimer *);
-	struct hrtimer_base	*base;
+	struct rb_node			node;
+	ktime_t				expires;
+	enum hrtimer_restart		(*function)(struct hrtimer *);
+	struct hrtimer_clock_base	*base;
 };
 
 /**
@@ -71,29 +72,41 @@ struct hrtimer_sleeper {
 
 /**
  * struct hrtimer_base - the timer base for a specific clock
- * @index:		clock type index for per_cpu support when moving a timer
- *			to a base on another cpu.
- * @lock:		lock protecting the base and associated timers
+ * @index:		clock type index for per_cpu support when moving a
+ *			timer to a base on another cpu.
  * @active:		red black tree root node for the active timers
  * @first:		pointer to the timer node which expires first
  * @resolution:		the resolution of the clock, in nanoseconds
  * @get_time:		function to retrieve the current time of the clock
  * @get_softirq_time:	function to retrieve the current time from the softirq
- * @curr_timer:		the timer which is executing a callback right now
  * @softirq_time:	the time when running the hrtimer queue in the softirq
- * @lock_key:		the lock_class_key for use with lockdep
  */
-struct hrtimer_base {
+struct hrtimer_clock_base {
+	struct hrtimer_cpu_base	*cpu_base;
 	clockid_t		index;
-	spinlock_t		lock;
 	struct rb_root		active;
 	struct rb_node		*first;
 	ktime_t			resolution;
 	ktime_t			(*get_time)(void);
 	ktime_t			(*get_softirq_time)(void);
-	struct hrtimer		*curr_timer;
 	ktime_t			softirq_time;
-	struct lock_class_key lock_key;
+};
+
+#define HRTIMER_MAX_CLOCK_BASES 2
+
+/*
+ * struct hrtimer_cpu_base - the per cpu clock bases
+ * @lock:		lock protecting the base and associated clock bases
+ *			and timers
+ * @lock_key:		the lock_class_key for use with lockdep
+ * @clock_base:		array of clock bases for this cpu
+ * @curr_timer:		the timer which is executing a callback right now
+ */
+struct hrtimer_cpu_base {
+	spinlock_t			lock;
+	struct lock_class_key		lock_key;
+	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	struct hrtimer			*curr_timer;
 };
 
 /*
Index: linux-2.6.18-mm3/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/hrtimer.c	2006-10-04 18:13:55.000000000 +0200
+++ linux-2.6.18-mm3/kernel/hrtimer.c	2006-10-04 18:13:56.000000000 +0200
@@ -1,8 +1,9 @@
 /*
  *  linux/kernel/hrtimer.c
  *
- *  Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
- *  Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
+ *  Copyright(C) 2005-2006, Red Hat, Inc., Ingo Molnar
+ *  Copyright(C) 2006	    Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *
  *  High-resolution kernel timers
  *
@@ -79,21 +80,22 @@ EXPORT_SYMBOL_GPL(ktime_get_real);
  * This ensures that we capture erroneous accesses to these clock ids
  * rather than moving them into the range of valid clock id's.
  */
-
-#define MAX_HRTIMER_BASES 2
-
-static DEFINE_PER_CPU(struct hrtimer_base, hrtimer_bases[MAX_HRTIMER_BASES]) =
+static DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 {
+
+	.clock_base =
 	{
-		.index = CLOCK_REALTIME,
-		.get_time = &ktime_get_real,
-		.resolution = KTIME_REALTIME_RES,
-	},
-	{
-		.index = CLOCK_MONOTONIC,
-		.get_time = &ktime_get,
-		.resolution = KTIME_MONOTONIC_RES,
-	},
+		{
+			.index = CLOCK_REALTIME,
+			.get_time = &ktime_get_real,
+			.resolution = KTIME_REALTIME_RES,
+		},
+		{
+			.index = CLOCK_MONOTONIC,
+			.get_time = &ktime_get,
+			.resolution = KTIME_MONOTONIC_RES,
+		},
+	}
 };
 
 /**
@@ -125,7 +127,7 @@ EXPORT_SYMBOL_GPL(ktime_get_ts);
  * Get the coarse grained time at the softirq based on xtime and
  * wall_to_monotonic.
  */
-static void hrtimer_get_softirq_time(struct hrtimer_base *base)
+static void hrtimer_get_softirq_time(struct hrtimer_cpu_base *base)
 {
 	ktime_t xtim, tomono;
 	unsigned long seq;
@@ -137,8 +139,9 @@ static void hrtimer_get_softirq_time(str
 
 	} while (read_seqretry(&xtime_lock, seq));
 
-	base[CLOCK_REALTIME].softirq_time = xtim;
-	base[CLOCK_MONOTONIC].softirq_time = ktime_add(xtim, tomono);
+	base->clock_base[CLOCK_REALTIME].softirq_time = xtim;
+	base->clock_base[CLOCK_MONOTONIC].softirq_time =
+		ktime_add(xtim, tomono);
 }
 
 /*
@@ -161,19 +164,20 @@ static void hrtimer_get_softirq_time(str
  * possible to set timer->base = NULL and drop the lock: the timer remains
  * locked.
  */
-static struct hrtimer_base *lock_hrtimer_base(const struct hrtimer *timer,
-					      unsigned long *flags)
+static
+struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
+					     unsigned long *flags)
 {
-	struct hrtimer_base *base;
+	struct hrtimer_clock_base *base;
 
 	for (;;) {
 		base = timer->base;
 		if (likely(base != NULL)) {
-			spin_lock_irqsave(&base->lock, *flags);
+			spin_lock_irqsave(&base->cpu_base->lock, *flags);
 			if (likely(base == timer->base))
 				return base;
 			/* The timer has migrated to another CPU: */
-			spin_unlock_irqrestore(&base->lock, *flags);
+			spin_unlock_irqrestore(&base->cpu_base->lock, *flags);
 		}
 		cpu_relax();
 	}
@@ -182,12 +186,14 @@ static struct hrtimer_base *lock_hrtimer
 /*
  * Switch the timer base to the current CPU when possible.
  */
-static inline struct hrtimer_base *
-switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_base *base)
+static inline struct hrtimer_clock_base *
+switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base)
 {
-	struct hrtimer_base *new_base;
+	struct hrtimer_clock_base *new_base;
+	struct hrtimer_cpu_base *new_cpu_base;
 
-	new_base = &__get_cpu_var(hrtimer_bases)[base->index];
+	new_cpu_base = &__get_cpu_var(hrtimer_bases);
+	new_base = &new_cpu_base->clock_base[base->index];
 
 	if (base != new_base) {
 		/*
@@ -199,13 +205,13 @@ switch_hrtimer_base(struct hrtimer *time
 		 * completed. There is no conflict as we hold the lock until
 		 * the timer is enqueued.
 		 */
-		if (unlikely(base->curr_timer == timer))
+		if (unlikely(base->cpu_base->curr_timer == timer))
 			return base;
 
 		/* See the comment in lock_timer_base() */
 		timer->base = NULL;
-		spin_unlock(&base->lock);
-		spin_lock(&new_base->lock);
+		spin_unlock(&base->cpu_base->lock);
+		spin_lock(&new_base->cpu_base->lock);
 		timer->base = new_base;
 	}
 	return new_base;
@@ -215,12 +221,12 @@ switch_hrtimer_base(struct hrtimer *time
 
 #define set_curr_timer(b, t)		do { } while (0)
 
-static inline struct hrtimer_base *
+static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
-	struct hrtimer_base *base = timer->base;
+	struct hrtimer_clock_base *base = timer->base;
 
-	spin_lock_irqsave(&base->lock, *flags);
+	spin_lock_irqsave(&base->cpu_base->lock, *flags);
 
 	return base;
 }
@@ -300,7 +306,7 @@ void hrtimer_notify_resume(void)
 static inline
 void unlock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
-	spin_unlock_irqrestore(&timer->base->lock, *flags);
+	spin_unlock_irqrestore(&timer->base->cpu_base->lock, *flags);
 }
 
 /**
@@ -350,7 +356,8 @@ hrtimer_forward(struct hrtimer *timer, k
  * The timer is inserted in expiry order. Insertion into the
  * red black tree is O(log(n)). Must hold the base lock.
  */
-static void enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+static void enqueue_hrtimer(struct hrtimer *timer,
+			    struct hrtimer_clock_base *base)
 {
 	struct rb_node **link = &base->active.rb_node;
 	struct rb_node *parent = NULL;
@@ -389,7 +396,8 @@ static void enqueue_hrtimer(struct hrtim
  *
  * Caller must hold the base lock.
  */
-static void __remove_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+static void __remove_hrtimer(struct hrtimer *timer,
+			     struct hrtimer_clock_base *base)
 {
 	/*
 	 * Remove the timer from the rbtree and replace the
@@ -405,7 +413,7 @@ static void __remove_hrtimer(struct hrti
  * remove hrtimer, called with base lock held
  */
 static inline int
-remove_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base)
 {
 	if (hrtimer_active(timer)) {
 		__remove_hrtimer(timer, base);
@@ -427,7 +435,7 @@ remove_hrtimer(struct hrtimer *timer, st
 int
 hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode)
 {
-	struct hrtimer_base *base, *new_base;
+	struct hrtimer_clock_base *base, *new_base;
 	unsigned long flags;
 	int ret;
 
@@ -474,13 +482,13 @@ EXPORT_SYMBOL_GPL(hrtimer_start);
  */
 int hrtimer_try_to_cancel(struct hrtimer *timer)
 {
-	struct hrtimer_base *base;
+	struct hrtimer_clock_base *base;
 	unsigned long flags;
 	int ret = -1;
 
 	base = lock_hrtimer_base(timer, &flags);
 
-	if (base->curr_timer != timer)
+	if (base->cpu_base->curr_timer != timer)
 		ret = remove_hrtimer(timer, base);
 
 	unlock_hrtimer_base(timer, &flags);
@@ -516,7 +524,7 @@ EXPORT_SYMBOL_GPL(hrtimer_cancel);
  */
 ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
-	struct hrtimer_base *base;
+	struct hrtimer_clock_base *base;
 	unsigned long flags;
 	ktime_t rem;
 
@@ -537,26 +545,29 @@ EXPORT_SYMBOL_GPL(hrtimer_get_remaining)
  */
 ktime_t hrtimer_get_next_event(void)
 {
-	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
+	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
+	struct hrtimer_clock_base *base = cpu_base->clock_base;
 	ktime_t delta, mindelta = { .tv64 = KTIME_MAX };
 	unsigned long flags;
 	int i;
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++) {
+	spin_lock_irqsave(&cpu_base->lock, flags);
+
+	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++, base++) {
 		struct hrtimer *timer;
 
-		spin_lock_irqsave(&base->lock, flags);
-		if (!base->first) {
-			spin_unlock_irqrestore(&base->lock, flags);
+		if (!base->first)
 			continue;
-		}
+
 		timer = rb_entry(base->first, struct hrtimer, node);
 		delta.tv64 = timer->expires.tv64;
-		spin_unlock_irqrestore(&base->lock, flags);
 		delta = ktime_sub(delta, base->get_time());
 		if (delta.tv64 < mindelta.tv64)
 			mindelta.tv64 = delta.tv64;
 	}
+
+	spin_unlock_irqrestore(&cpu_base->lock, flags);
+
 	if (mindelta.tv64 < 0)
 		mindelta.tv64 = 0;
 	return mindelta;
@@ -572,16 +583,16 @@ ktime_t hrtimer_get_next_event(void)
 void hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 		  enum hrtimer_mode mode)
 {
-	struct hrtimer_base *bases;
+	struct hrtimer_cpu_base *cpu_base;
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
-	bases = __raw_get_cpu_var(hrtimer_bases);
+	cpu_base = &__raw_get_cpu_var(hrtimer_bases);
 
 	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_MODE_ABS)
 		clock_id = CLOCK_MONOTONIC;
 
-	timer->base = &bases[clock_id];
+	timer->base = &cpu_base->clock_base[clock_id];
 	rb_set_parent(&timer->node, &timer->node);
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
@@ -596,10 +607,10 @@ EXPORT_SYMBOL_GPL(hrtimer_init);
  */
 int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp)
 {
-	struct hrtimer_base *bases;
+	struct hrtimer_cpu_base *cpu_base;
 
-	bases = __raw_get_cpu_var(hrtimer_bases);
-	*tp = ktime_to_timespec(bases[which_clock].resolution);
+	cpu_base = &__raw_get_cpu_var(hrtimer_bases);
+	*tp = ktime_to_timespec(cpu_base->clock_base[which_clock].resolution);
 
 	return 0;
 }
@@ -608,9 +619,11 @@ EXPORT_SYMBOL_GPL(hrtimer_get_res);
 /*
  * Expire the per base hrtimer-queue:
  */
-static inline void run_hrtimer_queue(struct hrtimer_base *base)
+static inline void run_hrtimer_queue(struct hrtimer_cpu_base *cpu_base,
+				     int index)
 {
 	struct rb_node *node;
+	struct hrtimer_clock_base *base = &cpu_base->clock_base[index];
 
 	if (!base->first)
 		return;
@@ -618,7 +631,7 @@ static inline void run_hrtimer_queue(str
 	if (base->get_softirq_time)
 		base->softirq_time = base->get_softirq_time();
 
-	spin_lock_irq(&base->lock);
+	spin_lock_irq(&cpu_base->lock);
 
 	while ((node = base->first)) {
 		struct hrtimer *timer;
@@ -630,21 +643,21 @@ static inline void run_hrtimer_queue(str
 			break;
 
 		fn = timer->function;
-		set_curr_timer(base, timer);
+		set_curr_timer(cpu_base, timer);
 		__remove_hrtimer(timer, base);
-		spin_unlock_irq(&base->lock);
+		spin_unlock_irq(&cpu_base->lock);
 
 		restart = fn(timer);
 
-		spin_lock_irq(&base->lock);
+		spin_lock_irq(&cpu_base->lock);
 
 		if (restart != HRTIMER_NORESTART) {
 			BUG_ON(hrtimer_active(timer));
 			enqueue_hrtimer(timer, base);
 		}
 	}
-	set_curr_timer(base, NULL);
-	spin_unlock_irq(&base->lock);
+	set_curr_timer(cpu_base, NULL);
+	spin_unlock_irq(&cpu_base->lock);
 }
 
 /*
@@ -652,13 +665,13 @@ static inline void run_hrtimer_queue(str
  */
 void hrtimer_run_queues(void)
 {
-	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
+	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
 	int i;
 
-	hrtimer_get_softirq_time(base);
+	hrtimer_get_softirq_time(cpu_base);
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++)
-		run_hrtimer_queue(&base[i]);
+	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++)
+		run_hrtimer_queue(cpu_base, i);
 }
 
 /*
@@ -787,19 +800,21 @@ sys_nanosleep(struct timespec __user *rq
  */
 static void __devinit init_hrtimers_cpu(int cpu)
 {
-	struct hrtimer_base *base = per_cpu(hrtimer_bases, cpu);
+	struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
 	int i;
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++) {
-		spin_lock_init(&base->lock);
-		lockdep_set_class(&base->lock, &base->lock_key);
-	}
+	spin_lock_init(&cpu_base->lock);
+	lockdep_set_class(&cpu_base->lock, &cpu_base->lock_key);
+
+	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++)
+		cpu_base->clock_base[i].cpu_base = cpu_base;
+
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void migrate_hrtimer_list(struct hrtimer_base *old_base,
-				struct hrtimer_base *new_base)
+static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
+				struct hrtimer_clock_base *new_base)
 {
 	struct hrtimer *timer;
 	struct rb_node *node;
@@ -814,29 +829,26 @@ static void migrate_hrtimer_list(struct 
 
 static void migrate_hrtimers(int cpu)
 {
-	struct hrtimer_base *old_base, *new_base;
+	struct hrtimer_cpu_base *old_base, *new_base;
 	int i;
 
 	BUG_ON(cpu_online(cpu));
-	old_base = per_cpu(hrtimer_bases, cpu);
-	new_base = get_cpu_var(hrtimer_bases);
+	old_base = &per_cpu(hrtimer_bases, cpu);
+	new_base = &get_cpu_var(hrtimer_bases);
 
 	local_irq_disable();
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
-
-		spin_lock(&new_base->lock);
-		spin_lock(&old_base->lock);
+	spin_lock(&new_base->lock);
+	spin_lock(&old_base->lock);
 
+	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		BUG_ON(old_base->curr_timer);
 
-		migrate_hrtimer_list(old_base, new_base);
-
-		spin_unlock(&old_base->lock);
-		spin_unlock(&new_base->lock);
-		old_base++;
-		new_base++;
+		migrate_hrtimer_list(&old_base->clock_base[i],
+				     &new_base->clock_base[i]);
 	}
+	spin_unlock(&old_base->lock);
+	spin_unlock(&new_base->lock);
 
 	local_irq_enable();
 	put_cpu_var(hrtimer_bases);

--


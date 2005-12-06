Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVLFAkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVLFAkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbVLFAfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:06 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43470
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751547AbVLFAeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:50 -0500
Message-Id: <20051206000154.884060000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:41 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 15/21] hrtimer core code
Content-Disposition: inline; filename=hrtimer-core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- hrtimer subsystem core. It is initialized at bootup and expired by the
  timer interrupt, but is otherwise not utilized by any other subsystem yet.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/hrtimer.h |  130 +++++++++
 include/linux/ktime.h   |   15 +
 init/main.c             |    1 
 kernel/Makefile         |    3 
 kernel/hrtimer.c        |  679 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c          |    1 
 6 files changed, 828 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc5/include/linux/hrtimer.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc5/include/linux/hrtimer.h
@@ -0,0 +1,130 @@
+/*
+ *  include/linux/hrtimer.h
+ *
+ *  hrtimers - High-resolution kernel timers
+ *
+ *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *   Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *
+ *  data type definitions, declarations, prototypes
+ *
+ *  Started by: Thomas Gleixner and Ingo Molnar
+ *
+ *  For licencing details see kernel-base/COPYING
+ */
+#ifndef _LINUX_HRTIMER_H
+#define _LINUX_HRTIMER_H
+
+#include <linux/rbtree.h>
+#include <linux/ktime.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+
+/*
+ * Mode arguments of xxx_hrtimer functions:
+ */
+enum hrtimer_mode {
+	HRTIMER_ABS,	/* Time value is absolute */
+	HRTIMER_REL,	/* Time value is relative to now */
+};
+
+enum hrtimer_restart {
+	HRTIMER_NORESTART,
+	HRTIMER_RESTART,
+};
+
+/*
+ * Timer states:
+ */
+enum hrtimer_state {
+	HRTIMER_INACTIVE,	/* Timer is inactive */
+	HRTIMER_EXPIRED,		/* Timer is expired */
+	HRTIMER_PENDING,		/* Timer is pending */
+};
+
+struct hrtimer_base;
+
+/**
+ * struct hrtimer - the basic hrtimer structure
+ *
+ * @node:	red black tree node for time ordered insertion
+ * @list:	list head for easier access to the time ordered list,
+ *		without walking the red black tree.
+ * @expires:	the absolute expiry time in the hrtimers internal
+ *		representation. The time is related to the clock on
+ *		which the timer is based.
+ * @state:	state of the timer
+ * @function:	timer expiry callback function
+ * @data:	argument for the callback function
+ * @base:	pointer to the timer base (per cpu and per clock)
+ *
+ * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()
+ */
+struct hrtimer {
+	struct rb_node		node;
+	struct list_head	list;
+	ktime_t			expires;
+	enum hrtimer_state	state;
+	int			(*function)(void *);
+	void			*data;
+	struct hrtimer_base	*base;
+};
+
+/**
+ * struct hrtimer_base - the timer base for a specific clock
+ *
+ * @index:	clock type index for per_cpu support when moving a timer
+ *		to a base on another cpu.
+ * @lock:	lock protecting the base and associated timers
+ * @active:	red black tree root node for the active timers
+ * @pending:	list of pending timers for simple time ordered access
+ * @resolution:	the resolution of the clock, in nanoseconds
+ * @get_time:	function to retrieve the current time of the clock
+ * @curr_timer:	the timer which is executing a callback right now
+ */
+struct hrtimer_base {
+	clockid_t		index;
+	spinlock_t		lock;
+	struct rb_root		active;
+	struct list_head	pending;
+	unsigned long		resolution;
+	ktime_t			(*get_time)(void);
+	struct hrtimer		*curr_timer;
+};
+
+/* Exported timer functions: */
+
+/* Initialize timers: */
+extern void hrtimer_init(struct hrtimer *timer, const clockid_t which_clock);
+extern void hrtimer_rebase(struct hrtimer *timer, const clockid_t which_clock);
+
+
+/* Basic timer operations: */
+extern int hrtimer_start(struct hrtimer *timer, ktime_t tim,
+			 const enum hrtimer_mode mode);
+extern int hrtimer_cancel(struct hrtimer *timer);
+extern int hrtimer_try_to_cancel(struct hrtimer *timer);
+
+#define hrtimer_restart(timer) hrtimer_start((timer), (timer)->expires, HRTIMER_ABS)
+
+/* Query timers: */
+extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
+extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
+
+static inline int hrtimer_active(const struct hrtimer *timer)
+{
+	return timer->state == HRTIMER_PENDING;
+}
+
+/* Forward a hrtimer so it expires after now: */
+extern unsigned long hrtimer_forward(struct hrtimer *timer,
+				     const ktime_t interval);
+
+/* Soft interrupt function to run the hrtimer queues: */
+extern void hrtimer_run_queues(void);
+
+/* Bootup initialization: */
+extern void __init hrtimers_init(void);
+
+#endif
Index: linux-2.6.15-rc5/include/linux/ktime.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/ktime.h
+++ linux-2.6.15-rc5/include/linux/ktime.h
@@ -266,4 +266,19 @@ static inline u64 ktime_to_ns(const ktim
 
 #endif
 
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+#define KTIME_REALTIME_RES	(NSEC_PER_SEC/HZ)
+#define KTIME_MONOTONIC_RES	(NSEC_PER_SEC/HZ)
+
+/* Get the monotonic time in timespec format: */
+extern void ktime_get_ts(struct timespec *ts);
+
+/* Get the real (wall-) time in timespec format: */
+#define ktime_get_real_ts(ts)	getnstimeofday(ts)
+
 #endif
Index: linux-2.6.15-rc5/init/main.c
===================================================================
--- linux-2.6.15-rc5.orig/init/main.c
+++ linux-2.6.15-rc5/init/main.c
@@ -487,6 +487,7 @@ asmlinkage void __init start_kernel(void
 	init_IRQ();
 	pidhash_init();
 	init_timers();
+	hrtimers_init();
 	softirq_init();
 	time_init();
 
Index: linux-2.6.15-rc5/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/kernel/Makefile
+++ linux-2.6.15-rc5/kernel/Makefile
@@ -7,7 +7,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
+	    hrtimer.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6.15-rc5/kernel/hrtimer.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc5/kernel/hrtimer.c
@@ -0,0 +1,679 @@
+/*
+ *  linux/kernel/hrtimer.c
+ *
+ *  Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *  Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *
+ *  High-resolution kernel timers
+ *
+ *  In contrast to the low-resolution timeout API implemented in
+ *  kernel/timer.c, hrtimers provide finer resolution and accuracy
+ *  depending on system configuration and capabilities.
+ *
+ *  These timers are currently used for:
+ *   - itimers
+ *   - POSIX timers
+ *   - nanosleep
+ *   - precise in-kernel timing
+ *
+ *  Started by: Thomas Gleixner and Ingo Molnar
+ *
+ *  Credits:
+ *	based on kernel/timer.c
+ *
+ *  For licencing details see kernel-base/COPYING
+ */
+
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/hrtimer.h>
+#include <linux/notifier.h>
+#include <linux/syscalls.h>
+#include <linux/interrupt.h>
+
+#include <asm/uaccess.h>
+
+/**
+ * ktime_get - get the monotonic time in ktime_t format
+ *
+ * returns the time in ktime_t format
+ */
+static ktime_t ktime_get(void)
+{
+	struct timespec now;
+
+	ktime_get_ts(&now);
+
+	return timespec_to_ktime(now);
+}
+
+/**
+ * ktime_get_real - get the real (wall-) time in ktime_t format
+ *
+ * returns the time in ktime_t format
+ */
+static ktime_t ktime_get_real(void)
+{
+	struct timespec now;
+
+	getnstimeofday(&now);
+
+	return timespec_to_ktime(now);
+}
+
+EXPORT_SYMBOL_GPL(ktime_get_real);
+
+/*
+ * The timer bases:
+ */
+
+#define MAX_HRTIMER_BASES 2
+
+static DEFINE_PER_CPU(struct hrtimer_base, hrtimer_bases[MAX_HRTIMER_BASES]) =
+{
+	{
+		.index = CLOCK_REALTIME,
+		.get_time = &ktime_get_real,
+		.resolution = KTIME_REALTIME_RES,
+	},
+	{
+		.index = CLOCK_MONOTONIC,
+		.get_time = &ktime_get,
+		.resolution = KTIME_MONOTONIC_RES,
+	},
+};
+
+/**
+ * ktime_get_ts - get the monotonic clock in timespec format
+ *
+ * @ts:		pointer to timespec variable
+ *
+ * The function calculates the monotonic clock from the realtime
+ * clock and the wall_to_monotonic offset and stores the result
+ * in normalized timespec format in the variable pointed to by ts.
+ */
+void ktime_get_ts(struct timespec *ts)
+{
+	struct timespec tomono;
+	unsigned long seq;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		getnstimeofday(ts);
+		tomono = wall_to_monotonic;
+
+	} while (read_seqretry(&xtime_lock, seq));
+
+	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
+				ts->tv_nsec + tomono.tv_nsec);
+}
+
+/*
+ * Functions and macros which are different for UP/SMP systems are kept in a
+ * single place
+ */
+#ifdef CONFIG_SMP
+
+#define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
+
+/*
+ * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
+ * means that all timers which are tied to this base via timer->base are
+ * locked, and the base itself is locked too.
+ *
+ * So __run_timers/migrate_timers can safely modify all timers which could
+ * be found on the lists/queues.
+ *
+ * When the timer's base is locked, and the timer removed from list, it is
+ * possible to set timer->base = NULL and drop the lock: the timer remains
+ * locked.
+ */
+static struct hrtimer_base *lock_hrtimer_base(const struct hrtimer *timer,
+					      unsigned long *flags)
+{
+	struct hrtimer_base *base;
+
+	for (;;) {
+		base = timer->base;
+		if (likely(base != NULL)) {
+			spin_lock_irqsave(&base->lock, *flags);
+			if (likely(base == timer->base))
+				return base;
+			/* The timer has migrated to another CPU: */
+			spin_unlock_irqrestore(&base->lock, *flags);
+		}
+		cpu_relax();
+	}
+}
+
+/*
+ * Switch the timer base to the current CPU when possible.
+ */
+static inline struct hrtimer_base *
+switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_base *base)
+{
+	struct hrtimer_base *new_base;
+
+	new_base = &__get_cpu_var(hrtimer_bases[base->index]);
+
+	if (base != new_base) {
+		/*
+		 * We are trying to schedule the timer on the local CPU.
+		 * However we can't change timer's base while it is running,
+		 * so we keep it on the same CPU. No hassle vs. reprogramming
+		 * the event source in the high resolution case. The softirq
+		 * code will take care of this when the timer function has
+		 * completed. There is no conflict as we hold the lock until
+		 * the timer is enqueued.
+		 */
+		if (unlikely(base->curr_timer == timer))
+			return base;
+
+		/* See the comment in lock_timer_base() */
+		timer->base = NULL;
+		spin_unlock(&base->lock);
+		spin_lock(&new_base->lock);
+		timer->base = new_base;
+	}
+	return new_base;
+}
+
+#else /* CONFIG_SMP */
+
+#define set_curr_timer(b, t)		do { } while (0)
+
+static inline struct hrtimer_base *
+lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+{
+	struct hrtimer_base *base = timer->base;
+
+	spin_lock_irqsave(&base->lock, *flags);
+
+	return base;
+}
+
+#define switch_hrtimer_base(t, b)	(b)
+
+#endif	/* !CONFIG_SMP */
+
+/*
+ * Functions for the union type storage format of ktime_t which are
+ * too large for inlining:
+ */
+#if BITS_PER_LONG < 64
+# ifndef CONFIG_KTIME_SCALAR
+/**
+ * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
+ *
+ * @kt:		addend
+ * @nsec:	the scalar nsec value to add
+ *
+ * Returns the sum of kt and nsec in ktime_t format
+ */
+ktime_t ktime_add_ns(const ktime_t kt, u64 nsec)
+{
+	ktime_t tmp;
+
+	if (likely(nsec < NSEC_PER_SEC)) {
+		tmp.tv64 = nsec;
+	} else {
+		unsigned long rem = do_div(nsec, NSEC_PER_SEC);
+
+		tmp = ktime_set((long)nsec, rem);
+	}
+
+	return ktime_add(kt, tmp);
+}
+
+#else /* CONFIG_KTIME_SCALAR */
+
+# endif /* !CONFIG_KTIME_SCALAR */
+
+/*
+ * Divide a ktime value by a nanosecond value
+ */
+static unsigned long ktime_divns(const ktime_t kt, nsec_t div)
+{
+	u64 dclc, inc, dns;
+	int sft = 0;
+
+	dclc = dns = ktime_to_ns(kt);
+	inc = div;
+	/* Make sure the divisor is less than 2^32: */
+	while (div >> 32) {
+		sft++;
+		div >>= 1;
+	}
+	dclc >>= sft;
+	do_div(dclc, (unsigned long) div);
+
+	return (unsigned long) dclc;
+}
+
+#else /* BITS_PER_LONG < 64 */
+# define ktime_divns(kt, div)		(unsigned long)((kt).tv64 / (div))
+#endif /* BITS_PER_LONG >= 64 */
+
+/*
+ * Counterpart to lock_timer_base above:
+ */
+static inline
+void unlock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
+{
+	spin_unlock_irqrestore(&timer->base->lock, *flags);
+}
+
+/**
+ * hrtimer_forward - forward the timer expiry
+ *
+ * @timer:	hrtimer to forward
+ * @interval:	the interval to forward
+ *
+ * Forward the timer expiry so it will expire in the future.
+ * The number of overruns is added to the overrun field.
+ */
+unsigned long
+hrtimer_forward(struct hrtimer *timer, const ktime_t interval)
+{
+	unsigned long orun = 1;
+	ktime_t delta, now;
+
+	now = timer->base->get_time();
+
+	delta = ktime_sub(now, timer->expires);
+
+	if (delta.tv64 < 0)
+		return 0;
+
+	if (unlikely(delta.tv64 >= interval.tv64)) {
+		nsec_t incr = ktime_to_ns(interval);
+
+		orun = ktime_divns(delta, incr);
+		timer->expires = ktime_add_ns(timer->expires, incr * orun);
+		if (timer->expires.tv64 > now.tv64)
+			return orun;
+		/*
+		 * This (and the ktime_add() below) is the
+		 * correction for exact:
+		 */
+		orun++;
+	}
+	timer->expires = ktime_add(timer->expires, interval);
+
+	return orun;
+}
+
+/*
+ * enqueue_hrtimer - internal function to (re)start a timer
+ *
+ * The timer is inserted in expiry order. Insertion into the
+ * red black tree is O(log(n)). Must hold the base lock.
+ */
+static void enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+{
+	struct rb_node **link = &base->active.rb_node;
+	struct list_head *prev = &base->pending;
+	struct rb_node *parent = NULL;
+	struct hrtimer *entry;
+
+	/*
+	 * Find the right place in the rbtree:
+	 */
+	while (*link) {
+		parent = *link;
+		entry = rb_entry(parent, struct hrtimer, node);
+		/*
+		 * We dont care about collisions. Nodes with
+		 * the same expiry time stay together.
+		 */
+		if (timer->expires.tv64 < entry->expires.tv64)
+			link = &(*link)->rb_left;
+		else {
+			link = &(*link)->rb_right;
+			prev = &entry->list;
+		}
+	}
+
+	/*
+	 * Insert the timer to the rbtree and to the sorted list:
+	 */
+	rb_link_node(&timer->node, parent, link);
+	rb_insert_color(&timer->node, &base->active);
+	list_add(&timer->list, prev);
+
+	timer->state = HRTIMER_PENDING;
+}
+
+
+/*
+ * __remove_hrtimer - internal function to remove a timer
+ *
+ * Caller must hold the base lock.
+ */
+static void __remove_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+{
+	/*
+	 * Remove the timer from the sorted list and from the rbtree:
+	 */
+	list_del(&timer->list);
+	rb_erase(&timer->node, &base->active);
+}
+
+/*
+ * remove hrtimer, called with base lock held
+ */
+static inline int
+remove_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
+{
+	if (hrtimer_active(timer)) {
+		__remove_hrtimer(timer, base);
+		timer->state = HRTIMER_INACTIVE;
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * hrtimer_start - (re)start an relative timer on the current CPU
+ *
+ * @timer:	the timer to be added
+ * @tim:	expiry time
+ * @mode:	expiry mode: absolute (HRTIMER_ABS) or relative (HRTIMER_REL)
+ *
+ * Returns:
+ *  0 on success
+ *  1 when the timer was active
+ */
+int
+hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode)
+{
+	struct hrtimer_base *base, *new_base;
+	unsigned long flags;
+	int ret;
+
+	base = lock_hrtimer_base(timer, &flags);
+
+	/* Remove an active timer from the queue: */
+	ret = remove_hrtimer(timer, base);
+
+	/* Switch the timer base, if necessary: */
+	new_base = switch_hrtimer_base(timer, base);
+
+	if (mode == HRTIMER_REL)
+		tim = ktime_add(tim, new_base->get_time());
+	timer->expires = tim;
+
+	enqueue_hrtimer(timer, new_base);
+
+	unlock_hrtimer_base(timer, &flags);
+
+	return ret;
+}
+
+/**
+ * hrtimer_try_to_cancel - try to deactivate a timer
+ *
+ * @timer:	hrtimer to stop
+ *
+ * Returns:
+ *  0 when the timer was not active
+ *  1 when the timer was active
+ * -1 when the timer is currently excuting the callback function and
+ *    can not be stopped
+ */
+int hrtimer_try_to_cancel(struct hrtimer *timer)
+{
+	struct hrtimer_base *base;
+	unsigned long flags;
+	int ret = -1;
+
+	base = lock_hrtimer_base(timer, &flags);
+
+	if (base->curr_timer != timer)
+		ret = remove_hrtimer(timer, base);
+
+	unlock_hrtimer_base(timer, &flags);
+
+	return ret;
+
+}
+
+/**
+ * hrtimer_cancel - cancel a timer and wait for the handler to finish.
+ *
+ * @timer:	the timer to be cancelled
+ *
+ * Returns:
+ *  0 when the timer was not active
+ *  1 when the timer was active
+ */
+int hrtimer_cancel(struct hrtimer *timer)
+{
+	for (;;) {
+		int ret = hrtimer_try_to_cancel(timer);
+
+		if (ret >= 0)
+			return ret;
+	}
+}
+
+/**
+ * hrtimer_get_remaining - get remaining time for the timer
+ *
+ * @timer:	the timer to read
+ */
+ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
+{
+	struct hrtimer_base *base;
+	unsigned long flags;
+	ktime_t rem;
+
+	base = lock_hrtimer_base(timer, &flags);
+	rem = ktime_sub(timer->expires, timer->base->get_time());
+	unlock_hrtimer_base(timer, &flags);
+
+	return rem;
+}
+
+/**
+ * hrtimer_rebase - rebase an initialized hrtimer to a different base
+ *
+ * @timer:	the timer to be rebased
+ * @clock_id:	the clock to be used
+ */
+void hrtimer_rebase(struct hrtimer *timer, const clockid_t clock_id)
+{
+	struct hrtimer_base *bases;
+
+	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
+	timer->base = &bases[clock_id];
+}
+
+/**
+ * hrtimer_init - initialize a timer to the given clock
+ *
+ * @timer:	the timer to be initialized
+ * @clock_id:	the clock to be used
+ */
+void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id)
+{
+	memset(timer, 0, sizeof(struct hrtimer));
+	hrtimer_rebase(timer, clock_id);
+}
+
+/**
+ * hrtimer_get_res - get the timer resolution for a clock
+ *
+ * @which_clock: which clock to query
+ * @tp:		 pointer to timespec variable to store the resolution
+ *
+ * Store the resolution of the clock selected by which_clock in the
+ * variable pointed to by tp.
+ */
+int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp)
+{
+	struct hrtimer_base *bases;
+
+	tp->tv_sec = 0;
+	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
+	tp->tv_nsec = bases[which_clock].resolution;
+
+	return 0;
+}
+
+/*
+ * Expire the per base hrtimer-queue:
+ */
+static inline void run_hrtimer_queue(struct hrtimer_base *base)
+{
+	ktime_t now = base->get_time();
+
+	spin_lock_irq(&base->lock);
+
+	while (!list_empty(&base->pending)) {
+		struct hrtimer *timer;
+		int (*fn)(void *);
+		int restart;
+		void *data;
+
+		timer = list_entry(base->pending.next, struct hrtimer, list);
+		if (now.tv64 <= timer->expires.tv64)
+			break;
+
+		fn = timer->function;
+		data = timer->data;
+		set_curr_timer(base, timer);
+		__remove_hrtimer(timer, base);
+		spin_unlock_irq(&base->lock);
+
+		/*
+		 * fn == NULL is special case for the simplest timer
+		 * variant - wake up process and do not restart:
+		 */
+		if (!fn) {
+			wake_up_process(data);
+			restart = HRTIMER_NORESTART;
+		} else
+			restart = fn(data);
+
+		spin_lock_irq(&base->lock);
+
+		if (restart == HRTIMER_RESTART)
+			enqueue_hrtimer(timer, base);
+		else
+			timer->state = HRTIMER_EXPIRED;
+	}
+	set_curr_timer(base, NULL);
+	spin_unlock_irq(&base->lock);
+}
+
+/*
+ * Called from timer softirq every jiffy, expire hrtimers:
+ */
+void hrtimer_run_queues(void)
+{
+	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
+	int i;
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++)
+		run_hrtimer_queue(&base[i]);
+}
+
+/*
+ * Functions related to boot-time initialization:
+ */
+static void __devinit init_hrtimers_cpu(int cpu)
+{
+	struct hrtimer_base *base = per_cpu(hrtimer_bases, cpu);
+	int i;
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+		spin_lock_init(&base->lock);
+		INIT_LIST_HEAD(&base->pending);
+		base++;
+	}
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static void migrate_hrtimer_list(struct hrtimer_base *old_base,
+				struct hrtimer_base *new_base)
+{
+	struct hrtimer *timer;
+	struct rb_node *node;
+
+	while ((node = rb_first(&old_base->active))) {
+		timer = rb_entry(node, struct hrtimer, node);
+		__remove_hrtimer(timer, old_base);
+		timer->base = new_base;
+		enqueue_hrtimer(timer, new_base);
+	}
+}
+
+static void migrate_hrtimers(int cpu)
+{
+	struct hrtimer_base *old_base, *new_base;
+	int i;
+
+	BUG_ON(cpu_online(cpu));
+	old_base = per_cpu(hrtimer_bases, cpu);
+	new_base = get_cpu_var(hrtimer_bases);
+
+	local_irq_disable();
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+
+		spin_lock(&new_base->lock);
+		spin_lock(&old_base->lock);
+
+		BUG_ON(old_base->curr_timer);
+
+		migrate_hrtimer_list(old_base, new_base);
+
+		spin_unlock(&old_base->lock);
+		spin_unlock(&new_base->lock);
+		old_base++;
+		new_base++;
+	}
+
+	local_irq_enable();
+	put_cpu_var(hrtimer_bases);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static int __devinit hrtimer_cpu_notify(struct notifier_block *self,
+					unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+
+	switch (action) {
+
+	case CPU_UP_PREPARE:
+		init_hrtimers_cpu(cpu);
+		break;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		migrate_hrtimers(cpu);
+		break;
+#endif
+
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata hrtimers_nb = {
+	.notifier_call = hrtimer_cpu_notify,
+};
+
+void __init hrtimers_init(void)
+{
+	hrtimer_cpu_notify(&hrtimers_nb, (unsigned long)CPU_UP_PREPARE,
+			  (void *)(long)smp_processor_id());
+	register_cpu_notifier(&hrtimers_nb);
+}
+
Index: linux-2.6.15-rc5/kernel/timer.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/timer.c
+++ linux-2.6.15-rc5/kernel/timer.c
@@ -857,6 +857,7 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
+ 	hrtimer_run_queues();
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVLAAGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVLAAGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVK3X6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:19 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:51618
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751291AbVK3X5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:43 -0500
Subject: [patch 15/43] ktimer core code
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:20 +0100
Message-Id: <1133395401.32542.458.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-core.patch)
- ktimer subsystem core. It is initialized at bootup and expired by the
  timer interrupt, but is otherwise not utilized by any other subsystem yet.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktime.h  |   21 +
 include/linux/ktimer.h |  170 +++++++++
 init/main.c            |    3 
 kernel/Makefile        |    3 
 kernel/ktimer.c        |  905 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c         |    2 
 6 files changed, 1103 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc2-rework/include/linux/ktime.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/ktime.h
+++ linux-2.6.15-rc2-rework/include/linux/ktime.h
@@ -307,4 +307,25 @@ static inline u64 ktime_to_ns(const ktim
 
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
+/* Get the monotonic time in ktime_t format: */
+extern ktime_t ktime_get(void);
+
+/* Get the real (wall-) time in ktime_t format: */
+extern ktime_t ktime_get_real(void);
+
+/* Get the monotonic time in timespec format: */
+extern void ktime_get_ts(struct timespec *ts);
+
+/* Get the real (wall-) time in timespec format: */
+#define ktime_get_real_ts(ts)	getnstimeofday(ts)
+
 #endif
Index: linux-2.6.15-rc2-rework/include/linux/ktimer.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc2-rework/include/linux/ktimer.h
@@ -0,0 +1,170 @@
+/*
+ *  include/linux/ktimer.h
+ *
+ *  ktimers - high-precision kernel timers
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
+#ifndef _LINUX_KTIMER_H
+#define _LINUX_KTIMER_H
+
+#include <linux/rbtree.h>
+#include <linux/ktime.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+
+/*
+ * Mode arguments of xxx_ktimer functions:
+ */
+enum ktimer_rearm {
+	KTIMER_ABS = 1,	/* Time value is absolute */
+	KTIMER_REL,	/* Time value is relative to now */
+	KTIMER_INCR,	/* Time value is relative to previous expiry time */
+	KTIMER_FORWARD,	/* Timer is rearmed with value. Overruns accounted */
+	KTIMER_REARM,	/* Timer is rearmed with interval. Overruns accounted */
+	KTIMER_RESTART,	/* Timer is restarted with the stored expiry value */
+
+	/*
+	 * Expiry must not be checked when the timer is started:
+	 * (can be OR-ed with another above mode flag)
+	 */
+	KTIMER_NOCHECK = 0x10000,
+	/*
+	 * Rounding is required when the time is set up. Thats an
+	 * optimization for relative timers as we read current time
+	 * in the enqueing code so we do not need to read is twice.
+	 */
+	KTIMER_ROUND = 0x20000,
+
+	/* (used internally: no rearming) */
+	KTIMER_NOREARM = 0
+};
+
+/*
+ * Timer states:
+ */
+enum ktimer_state {
+	KTIMER_INACTIVE,	/* Timer is inactive */
+	KTIMER_PENDING,		/* Timer is pending */
+};
+
+struct ktimer_base;
+
+/**
+ * struct ktimer - the basic ktimer structure
+ *
+ * @node:	red black tree node for time ordered insertion
+ * @list:	list head for easier access to the time ordered list,
+ *		without walking the red black tree.
+ * @expires:	the absolute expiry time in the ktimers internal
+ *		representation. The time is related to the clock on
+ *		which the timer is based.
+ * @expired:	the absolute time when the timer expired. Used for
+ *		simplifying return path calculations and for debugging
+ *		purposes.
+ * @interval:	the timer interval for automatic rearming
+ * @overrun:	the number of intervals missed when rearming a timer
+ * @state:	state of the timer
+ * @function:	timer expiry callback function
+ * @data:	argument for the callback function
+ * @base:	pointer to the timer base (per cpu and per clock)
+ *
+ * The ktimer structure must be initialized by init_ktimer_#CLOCKTYPE()
+ */
+struct ktimer {
+	struct rb_node		node;
+	struct list_head	list;
+	ktime_t			expires;
+	ktime_t			expired;
+	ktime_t			interval;
+	int			overrun;
+	enum ktimer_state	state;
+	void			(*function)(void *);
+	void			*data;
+	struct ktimer_base	*base;
+};
+
+/**
+ * struct ktimer_base - the timer base for a specific clock
+ *
+ * @index:	clock type index for per_cpu support when moving a timer
+ *		to a base on another cpu.
+ * @lock:	lock protecting the base and associated timers
+ * @active:	red black tree root node for the active timers
+ * @pending:	list of pending timers for simple time ordered access
+ * @count:	the number of active timers
+ * @resolution:	the resolution of the clock, in nanoseconds
+ * @get_time:	function to retrieve the current time of the clock
+ * @curr_timer:	the timer which is executing a callback right now
+ * @wait:	waitqueue to wait for a currently running timer
+ * @name:	string identifier of the clock
+ */
+struct ktimer_base {
+	clockid_t		index;
+	spinlock_t		lock;
+	struct rb_root		active;
+	struct list_head	pending;
+	int			count;
+	unsigned long		resolution;
+	ktime_t			(*get_time)(void);
+	struct ktimer		*curr_timer;
+	wait_queue_head_t	wait;
+	char			*name;
+};
+
+#define KTIMER_POISON		((void *) 0x00100101)
+
+/* Exported timer functions: */
+
+/* Initialize timers: */
+extern void ktimer_init(struct ktimer *timer);
+extern void ktimer_init_clock(struct ktimer *timer,
+			      const clockid_t which_clock);
+
+/* Basic timer operations: */
+extern int ktimer_start(struct ktimer *timer, const ktime_t *tim,
+			const int mode);
+extern int ktimer_restart(struct ktimer *timer, const ktime_t *tim,
+			  const int mode);
+extern int ktimer_cancel(struct ktimer *timer);
+extern int ktimer_try_to_cancel(struct ktimer *timer);
+
+/* Query timers: */
+extern ktime_t ktimer_get_remtime(const struct ktimer *timer);
+extern ktime_t ktimer_get_expiry(const struct ktimer *timer, ktime_t *now);
+extern int ktimer_get_res(const clockid_t which_clock, struct timespec *tp);
+extern int ktimer_get_res_clock(const clockid_t which_clock,
+				struct timespec *tp);
+
+static inline int ktimer_active(const struct ktimer *timer)
+{
+	return timer->state != KTIMER_INACTIVE;
+}
+
+/* Convert with rounding based on resolution of timer's clock: */
+extern ktime_t ktimer_round_timeval(const struct ktimer *timer,
+				    const struct timeval *tv);
+extern ktime_t ktimer_round_timespec(const struct ktimer *timer,
+				     const struct timespec *ts);
+
+#ifdef CONFIG_SMP
+extern void wait_for_ktimer(const struct ktimer *timer);
+#else
+# define wait_for_ktimer(t)	do { } while (0)
+#endif
+
+/* Soft interrupt function to run the ktimer queues: */
+extern void ktimer_run_queues(void);
+
+/* Bootup initialization: */
+extern void __init ktimers_init(void);
+
+#endif
Index: linux-2.6.15-rc2-rework/init/main.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/init/main.c
+++ linux-2.6.15-rc2-rework/init/main.c
@@ -47,6 +47,8 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/ktimer.h>
+
 #include <net/sock.h>
 
 #include <asm/io.h>
@@ -487,6 +489,7 @@ asmlinkage void __init start_kernel(void
 	init_IRQ();
 	pidhash_init();
 	init_timers();
+	ktimers_init();
 	softirq_init();
 	time_init();
 
Index: linux-2.6.15-rc2-rework/kernel/Makefile
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/Makefile
+++ linux-2.6.15-rc2-rework/kernel/Makefile
@@ -7,7 +7,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
+	    ktimer.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6.15-rc2-rework/kernel/ktimer.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc2-rework/kernel/ktimer.c
@@ -0,0 +1,905 @@
+/*
+ *  linux/kernel/ktimer.c
+ *
+ *  Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *  Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *
+ *  High-precision kernel timers
+ *
+ *  In contrast to the low-resolution timeout API implemented in
+ *  kernel/timer.c, ktimers provide finer resolution and accuracy
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
+#include <linux/ktimer.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/syscalls.h>
+#include <linux/interrupt.h>
+
+#include <asm/uaccess.h>
+
+/*
+ * The timer bases:
+ */
+
+#define MAX_KTIMER_BASES 2
+
+static DEFINE_PER_CPU(struct ktimer_base, ktimer_bases[MAX_KTIMER_BASES]) =
+{
+	{
+		.index = CLOCK_REALTIME,
+		.name = "Realtime",
+		.get_time = &ktime_get_real,
+		.resolution = KTIME_REALTIME_RES,
+	},
+	{
+		.index = CLOCK_MONOTONIC,
+		.name = "Monotonic",
+		.get_time = &ktime_get,
+		.resolution = KTIME_MONOTONIC_RES,
+	},
+};
+
+/**
+ * ktime_get - get the monotonic time in ktime_t format
+ *
+ * returns the time in ktime_t format
+ */
+ktime_t ktime_get(void)
+{
+	struct timespec now;
+
+	ktime_get_ts(&now);
+
+	return timespec_to_ktime(now);
+}
+
+EXPORT_SYMBOL_GPL(ktime_get);
+
+/**
+ * ktime_get_real - get the real (wall-) time in ktime_t format
+ *
+ * returns the time in ktime_t format
+ */
+ktime_t ktime_get_real(void)
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
+#define set_curr_timer(b, t)		(b)->curr_timer = (t)
+#define wake_up_timer_waiters(b)	wake_up(&(b)->wait)
+
+/**
+ * wait_for_ktimer - Wait for a running ktimer
+ *
+ * @timer:	timer to wait for
+ *
+ * The function waits in case the timers callback function is
+ * currently executed on the waitqueue of the timer base. The
+ * waitqueue is woken up after the timer callback function has
+ * finished execution.
+ */
+void wait_for_ktimer(const struct ktimer *timer)
+{
+	struct ktimer_base *base = timer->base;
+
+	if (base)
+		wait_event(base->wait,
+			   base->curr_timer != timer);
+}
+
+/*
+ * We are using hashed locking: holding per_cpu(ktimer_bases)[n].lock
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
+static struct ktimer_base *lock_ktimer_base(const struct ktimer *timer,
+					    unsigned long *flags)
+{
+	struct ktimer_base *base;
+
+	for (;;) {
+		base = timer->base;
+		if (likely(base != NULL)) {
+			spin_lock_irqsave(&base->lock, *flags);
+			if (likely(base == timer->base))
+				return base;
+			/* The timer has migrated to another CPU */
+			spin_unlock_irqrestore(&base->lock, *flags);
+		}
+		cpu_relax();
+	}
+}
+
+/*
+ * Switch the timer base to the current CPU when possible.
+ */
+static inline struct ktimer_base *
+switch_ktimer_base(struct ktimer *timer, struct ktimer_base *base)
+{
+	struct ktimer_base *new_base;
+
+	new_base = &__get_cpu_var(ktimer_bases[base->index]);
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
+/*
+ * Get the timer base unlocked
+ *
+ * Take care of timer->base = NULL in switch_ktimer_base !
+ */
+static inline struct ktimer_base *
+get_ktimer_base_unlocked(const struct ktimer *timer)
+{
+	struct ktimer_base *base;
+
+	while (!(base = timer->base))
+		cpu_relax();
+
+	return base;
+}
+
+#else /* CONFIG_SMP */
+
+#define set_curr_timer(b, t)		do { } while (0)
+#define wake_up_timer_waiters(b)	do { } while (0)
+
+static inline struct ktimer_base *
+lock_ktimer_base(const struct ktimer *timer, unsigned long *flags)
+{
+	struct ktimer_base *base = timer->base;
+
+	spin_lock_irqsave(&base->lock, *flags);
+
+	return base;
+}
+
+#define switch_ktimer_base(t, b)	(b)
+#define get_ktimer_base_unlocked(t)	(t)->base
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
+/**
+ * ktime_modulo - Calculate ktime_t modulo div
+ *
+ * @kt:		dividend
+ * @div:	divisor
+ *
+ * Return ktime_t modulo div.
+ *
+ * div is less than NSEC_PER_SEC and (NSEC_PER_SEC % div) = 0 !
+ */
+#define ktime_modulo(kt, div)		((unsigned long)(kt).tv.nsec % (div))
+
+#else /* CONFIG_KTIME_SCALAR */
+
+static unsigned long ktime_modulo(const ktime_t kt, const unsigned long div)
+{
+	nsec_t nsec = kt.tv64;
+
+	return do_div(nsec, div);
+}
+
+# endif /* !CONFIG_KTIME_SCALAR */
+#else /* BITS_PER_LONG < 64 */
+# define ktime_modulo(kt, div)		(unsigned long)((kt).tv64 % (div))
+#endif /* BITS_PER_LONG >= 64 */
+
+/*
+ * Counterpart to lock_timer_base above.
+ */
+static inline
+void unlock_ktimer_base(const struct ktimer *timer, unsigned long *flags)
+{
+	spin_unlock_irqrestore(&timer->base->lock, *flags);
+}
+
+/**
+ * ktimer_round_timespec - convert timespec to ktime_t with resolution
+ *			     adjustment
+ *
+ * @timer:	ktimer to retrieve the base
+ * @ts:		pointer to the timespec value to be converted
+ *
+ * Returns the resolution adjusted ktime_t representation of the
+ * timespec.
+ *
+ * Note: We can access base without locking here, as ktimers can
+ * migrate between CPUs but can not be moved from one clock source to
+ * another. The clock source binding is set at init_ktimer_XXX time.
+ */
+ktime_t ktimer_round_timespec(const struct ktimer *timer,
+			      const struct timespec *ts)
+{
+	struct ktimer_base *base = get_ktimer_base_unlocked(timer);
+	long rem = ts->tv_nsec % base->resolution;
+	ktime_t t;
+
+	t = ktime_set(ts->tv_sec, ts->tv_nsec);
+
+	/* Check, if the value has to be rounded */
+	if (rem)
+		t = ktime_add_ns(t, base->resolution - rem);
+
+	return t;
+}
+
+/**
+ * ktimer_round_timeval - convert timeval to ktime_t with resolution
+ *			    adjustment
+ *
+ * @timer:	ktimer to retrieve the base
+ * @tv:		pointer to the timeval value to be converted
+ *
+ * Returns the resolution adjusted ktime_t representation of the
+ * timeval.
+ */
+ktime_t ktimer_round_timeval(const struct ktimer *timer,
+			     const struct timeval *tv)
+{
+	struct timespec ts;
+
+	ts.tv_sec = tv->tv_sec;
+	ts.tv_nsec = tv->tv_usec * NSEC_PER_USEC;
+
+	return ktimer_round_timespec(timer, &ts);
+}
+
+/*
+ * enqueue_ktimer - internal function to (re)start a timer
+ *
+ * The timer is inserted in expiry order. Insertion into the
+ * red black tree is O(log(n)). Must hold the base lock.
+ */
+static int enqueue_ktimer(struct ktimer *timer, struct ktimer_base *base,
+			  const ktime_t *tim, const int mode)
+{
+	struct rb_node **link = &base->active.rb_node;
+	struct list_head *prev = &base->pending;
+	struct rb_node *parent = NULL;
+	struct ktimer *entry;
+	ktime_t now;
+
+	/* Get current time */
+	now = base->get_time();
+
+	/*
+	 * Calculate the absolute expiry time based on the
+	 * timer expiry mode:
+	 */
+	switch (mode & ~(KTIMER_NOCHECK | KTIMER_ROUND)) {
+
+	case KTIMER_ABS:
+		timer->expires = *tim;
+		break;
+
+	case KTIMER_REL:
+		timer->expires = ktime_add(now, *tim);
+		break;
+
+	case KTIMER_INCR:
+		timer->expires = ktime_add(timer->expires, *tim);
+		break;
+
+	case KTIMER_FORWARD:
+		while (timer->expires.tv64 <= now.tv64) {
+			timer->expires = ktime_add(timer->expires, *tim);
+			timer->overrun++;
+		}
+		goto nocheck;
+
+	case KTIMER_REARM:
+		while (timer->expires.tv64 <= now.tv64) {
+			timer->expires = ktime_add(timer->expires,
+						   timer->interval);
+			timer->overrun++;
+		}
+		goto nocheck;
+
+	case KTIMER_RESTART:
+		break;
+
+	default:
+		/* illegal mode */
+		BUG();
+	}
+
+	/*
+	 * Rounding is requested for one shot timers and the first
+	 * event of interval timers. It's done here, so we don't
+	 * have to read the current time twice for relative timers.
+	 */
+	if (mode & KTIMER_ROUND) {
+		unsigned long rem;
+
+		rem = ktime_modulo(timer->expires, base->resolution);
+		if (rem)
+			timer->expires = ktime_add_ns(timer->expires,
+						      base->resolution - rem);
+	}
+
+	/* Expiry time in the past: */
+	if (unlikely(timer->expires.tv64 <= now.tv64)) {
+		timer->expired = now;
+		/* The caller takes care of expiry */
+		if (!(mode & KTIMER_NOCHECK))
+			return -1;
+	}
+ nocheck:
+
+	/*
+	 * Find the right place in the rbtree:
+	 */
+	while (*link) {
+		parent = *link;
+		entry = rb_entry(parent, struct ktimer, node);
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
+	timer->state = KTIMER_PENDING;
+	base->count++;
+
+	return 0;
+}
+
+/*
+ * __remove_ktimer - internal function to remove a timer
+ *
+ * The function also allows automatic rearming for interval timers.
+ * Must hold the base lock.
+ */
+static void
+__remove_ktimer(struct ktimer *timer, struct ktimer_base *base,
+		enum ktimer_rearm rearm)
+{
+	/*
+	 * Remove the timer from the sorted list and from the rbtree:
+	 */
+	list_del(&timer->list);
+	rb_erase(&timer->node, &base->active);
+	timer->node.rb_parent = KTIMER_POISON;
+
+	timer->state = KTIMER_INACTIVE;
+	base->count--;
+	BUG_ON(base->count < 0);
+
+	/* Auto rearm the timer ? */
+	if (rearm && (timer->interval.tv64 != 0))
+		enqueue_ktimer(timer, base, NULL, KTIMER_REARM);
+}
+
+/*
+ * remove ktimer, called with base lock held
+ */
+static inline int remove_ktimer(struct ktimer *timer, struct ktimer_base *base)
+{
+	if (ktimer_active(timer)) {
+		__remove_ktimer(timer, base, KTIMER_NOREARM);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Internal function to (re)start a timer.
+ */
+static int internal_restart_ktimer(struct ktimer *timer, const ktime_t *tim,
+				   const int mode)
+{
+	struct ktimer_base *base, *new_base;
+	unsigned long flags;
+	int ret;
+
+	BUG_ON(!timer->function);
+
+	base = lock_ktimer_base(timer, &flags);
+
+	/* Remove an active timer from the queue */
+	ret = remove_ktimer(timer, base);
+
+	/* Switch the timer base, if necessary */
+	new_base = switch_ktimer_base(timer, base);
+
+	/*
+	 * When the new timer setting is already expired,
+	 * let the calling code deal with it.
+	 */
+	if (enqueue_ktimer(timer, new_base, tim, mode))
+		ret = -1;
+
+	unlock_ktimer_base(timer, &flags);
+
+	return ret;
+}
+
+/**
+ * ktimer_start - start a timer on the current CPU
+ *
+ * @timer:	the timer to be added
+ * @tim:	expiry time (optional, if not set in the timer)
+ * @mode:	timer setup mode
+ *
+ * Returns:
+ *  0 on success
+ * -1 when the new time setting is already expired
+ */
+int ktimer_start(struct ktimer *timer, const ktime_t *tim, const int mode)
+{
+	BUG_ON(ktimer_active(timer));
+
+	return internal_restart_ktimer(timer, tim, mode);
+}
+
+EXPORT_SYMBOL_GPL(ktimer_start);
+
+/**
+ * ktimer_restart - modify a running timer
+ *
+ * @timer:	the timer to be modified
+ * @tim:	expiry time (required)
+ * @mode:	timer setup mode
+ *
+ * Returns:
+ *  0 when the timer was not active
+ *  1 when the timer was active
+ * -1 when the new time setting is already expired
+ */
+int ktimer_restart(struct ktimer *timer, const ktime_t *tim, const int mode)
+{
+	BUG_ON(!tim);
+
+	return internal_restart_ktimer(timer, tim, mode);
+}
+
+EXPORT_SYMBOL_GPL(ktimer_restart);
+
+/**
+ * ktimer_try_to_cancel - try to deactivate a timer
+ *
+ * @timer:	ktimer to stop
+ *
+ * Returns:
+ *  0 when the timer was not active
+ *  1 when the timer was active
+ * -1 when the timer is currently excuting the callback function and
+ *    can not be stopped
+ */
+int ktimer_try_to_cancel(struct ktimer *timer)
+{
+	struct ktimer_base *base;
+	unsigned long flags;
+	int ret = -1;
+
+	base = lock_ktimer_base(timer, &flags);
+
+	if (base->curr_timer != timer) {
+		ret = remove_ktimer(timer, base);
+		if (ret)
+			timer->expired = base->get_time();
+	}
+
+	unlock_ktimer_base(timer, &flags);
+
+	return ret;
+
+}
+
+EXPORT_SYMBOL_GPL(ktimer_try_to_cancel);
+
+/**
+ * ktimer_cancel - cancel a timer and wait for the handler to finish.
+ *
+ * @timer:	the timer to be cancelled
+ *
+ * Returns:
+ *  0 when the timer was not active
+ *  1 when the timer was active
+ */
+int ktimer_cancel(struct ktimer *timer)
+{
+	for (;;) {
+		int ret = ktimer_try_to_cancel(timer);
+
+		if (ret >= 0)
+			return ret;
+		wait_for_ktimer(timer);
+	}
+}
+
+EXPORT_SYMBOL_GPL(ktimer_cancel);
+
+/**
+ * ktimer_get_remtime - get remaining time for the timer
+ *
+ * @timer:	the timer to read
+ *
+ * Returns the delta between the expiry time and now, which can be
+ * less than zero.
+ */
+ktime_t ktimer_get_remtime(const struct ktimer *timer)
+{
+	struct ktimer_base *base;
+	unsigned long flags;
+	ktime_t rem;
+
+	base = lock_ktimer_base(timer, &flags);
+	rem = ktime_sub(timer->expires, base->get_time());
+	unlock_ktimer_base(timer, &flags);
+
+	return rem;
+}
+
+/**
+ * ktimer_get_expiry - get expiry time for the timer
+ *
+ * @timer:	the timer to read
+ * @now:	if != NULL then store current base->time into it
+ */
+ktime_t ktimer_get_expiry(const struct ktimer *timer, ktime_t *now)
+{
+	struct ktimer_base *base;
+	unsigned long flags;
+	ktime_t expiry;
+
+	base = lock_ktimer_base(timer, &flags);
+	expiry = timer->expires;
+	if (now)
+		*now = base->get_time();
+	unlock_ktimer_base(timer, &flags);
+
+	return expiry;
+}
+
+/*
+ * Functions related to clock sources
+ */
+
+static inline void ktimer_common_init(struct ktimer *timer)
+{
+	memset(timer, 0, sizeof(struct ktimer));
+	timer->node.rb_parent = KTIMER_POISON;
+}
+
+/**
+ * ktimer_init - initialize a timer to the monotonic clock
+ *
+ * @timer:	the timer to be initialized
+ */
+void ktimer_init(struct ktimer *timer)
+{
+	struct ktimer_base *bases;
+
+	ktimer_common_init(timer);
+	bases = per_cpu(ktimer_bases, raw_smp_processor_id());
+	timer->base = &bases[CLOCK_MONOTONIC];
+}
+
+EXPORT_SYMBOL_GPL(ktimer_init);
+
+/**
+ * ktimer_init_clock - initialize a timer to the given clock
+ *
+ * @timer:	the timer to be initialized
+ * @clock_id:	the clock to be used
+ */
+void ktimer_init_clock(struct ktimer *timer, const clockid_t clock_id)
+{
+	struct ktimer_base *bases;
+
+	ktimer_common_init(timer);
+	bases = per_cpu(ktimer_bases, raw_smp_processor_id());
+	timer->base = &bases[clock_id];
+}
+
+EXPORT_SYMBOL_GPL(ktimer_init_clock);
+
+/**
+ * ktimer_get_res - get the monotonic timer resolution
+ *
+ * @which_clock: unused parameter for compability with the posix timer code
+ * @tp:		 pointer to timespec variable to store the resolution
+ *
+ * Store the resolution of clock monotonic in the variable pointed to
+ * by tp.
+ */
+int ktimer_get_res(const clockid_t which_clock, struct timespec *tp)
+{
+	struct ktimer_base *bases;
+
+	tp->tv_sec = 0;
+	bases = per_cpu(ktimer_bases, raw_smp_processor_id());
+	tp->tv_nsec = bases[CLOCK_MONOTONIC].resolution;
+
+	return 0;
+}
+
+/**
+ * ktimer_get_res_clock - get the timer resolution for a clock
+ *
+ * @which_clock: which clock to query
+ * @tp:		 pointer to timespec variable to store the resolution
+ *
+ * Store the resolution of clock realtime in the variable pointed to
+ * by tp.
+ */
+int ktimer_get_res_clock(const clockid_t which_clock, struct timespec *tp)
+{
+	struct ktimer_base *bases;
+
+	tp->tv_sec = 0;
+	bases = per_cpu(ktimer_bases, raw_smp_processor_id());
+	tp->tv_nsec = bases[which_clock].resolution;
+
+	return 0;
+}
+
+/*
+ * Expire the per base ktimer-queue:
+ */
+static inline void run_ktimer_queue(struct ktimer_base *base)
+{
+	ktime_t now = base->get_time();
+
+	spin_lock_irq(&base->lock);
+
+	while (!list_empty(&base->pending)) {
+		struct ktimer *timer;
+		void (*fn)(void *);
+		void *data;
+
+		timer = list_entry(base->pending.next, struct ktimer, list);
+		if (now.tv64 <= timer->expires.tv64)
+			break;
+
+		timer->expired = now;
+		fn = timer->function;
+		data = timer->data;
+		set_curr_timer(base, timer);
+		__remove_ktimer(timer, base, KTIMER_REARM);
+		spin_unlock_irq(&base->lock);
+
+		fn(data);
+
+		spin_lock_irq(&base->lock);
+		set_curr_timer(base, NULL);
+	}
+	spin_unlock_irq(&base->lock);
+
+	wake_up_timer_waiters(base);
+}
+
+/*
+ * Called from timer softirq every jiffy, expire ktimers:
+ */
+void ktimer_run_queues(void)
+{
+	struct ktimer_base *base = __get_cpu_var(ktimer_bases);
+	int i;
+
+	for (i = 0; i < MAX_KTIMER_BASES; i++)
+		run_ktimer_queue(&base[i]);
+}
+
+/*
+ * Functions related to boot-time initialization:
+ */
+static void __devinit init_ktimers_cpu(int cpu)
+{
+	struct ktimer_base *base = per_cpu(ktimer_bases, cpu);
+	int i;
+
+	for (i = 0; i < MAX_KTIMER_BASES; i++) {
+		spin_lock_init(&base->lock);
+		INIT_LIST_HEAD(&base->pending);
+		init_waitqueue_head(&base->wait);
+		base++;
+	}
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static void migrate_ktimer_list(struct ktimer_base *old_base,
+				struct ktimer_base *new_base)
+{
+	struct ktimer *timer;
+	struct rb_node *node;
+
+	while ((node = rb_first(&old_base->active))) {
+		timer = rb_entry(node, struct ktimer, node);
+		remove_ktimer(timer, old_base);
+		timer->base = new_base;
+		enqueue_ktimer(timer, new_base, NULL, KTIMER_RESTART);
+	}
+}
+
+static void migrate_ktimers(int cpu)
+{
+	struct ktimer_base *old_base, *new_base;
+	int i;
+
+	BUG_ON(cpu_online(cpu));
+	old_base = per_cpu(ktimer_bases, cpu);
+	new_base = get_cpu_var(ktimer_bases);
+
+	local_irq_disable();
+
+	for (i = 0; i < MAX_KTIMER_BASES; i++) {
+
+		spin_lock(&new_base->lock);
+		spin_lock(&old_base->lock);
+
+		BUG_ON(old_base->curr_timer);
+
+		migrate_ktimer_list(old_base, new_base);
+
+		spin_unlock(&old_base->lock);
+		spin_unlock(&new_base->lock);
+		old_base++;
+		new_base++;
+	}
+
+	local_irq_enable();
+	put_cpu_var(ktimer_bases);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static int __devinit ktimer_cpu_notify(struct notifier_block *self,
+				       unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+
+	switch(action) {
+
+	case CPU_UP_PREPARE:
+		init_ktimers_cpu(cpu);
+		break;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		migrate_ktimers(cpu);
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
+static struct notifier_block __devinitdata ktimers_nb = {
+	.notifier_call	= ktimer_cpu_notify,
+};
+
+void __init ktimers_init(void)
+{
+	ktimer_cpu_notify(&ktimers_nb, (unsigned long)CPU_UP_PREPARE,
+			  (void *)(long)smp_processor_id());
+	register_cpu_notifier(&ktimers_nb);
+}
+
Index: linux-2.6.15-rc2-rework/kernel/timer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/timer.c
+++ linux-2.6.15-rc2-rework/kernel/timer.c
@@ -30,6 +30,7 @@
 #include <linux/thread_info.h>
 #include <linux/time.h>
 #include <linux/jiffies.h>
+#include <linux/ktimer.h>
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
@@ -857,6 +858,7 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
+ 	ktimer_run_queues();
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }

--


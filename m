Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWI3AGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWI3AGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWI3AGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:49 -0400
Received: from www.osadl.org ([213.239.205.134]:24724 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422845AbWI3AEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:12 -0400
Message-Id: <20060929234440.521325000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:34 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 15/23] high-res timers: core
Content-Disposition: inline; filename=hrtimer-highres.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

add the core bits of high-res timers support.

the design makes use of the existing hrtimers subsystem which manages a
per-CPU and per-clock tree of timers, and the clockevents framework, which
provides a standard API to request programmable clock events from. The
core code does not have to know about the clock details - it makes use
of clockevents_set_next_event().

the code also provides dyntick functionality: it is implemented via a
per-cpu sched_tick hrtimer that is set to HZ frequency, but which is
reprogrammed to a longer timeout before going idle, and reprogrammed to
HZ again once the CPU goes busy again. (If an non-timer IRQ hits the
idle task then it will process jiffies before calling the IRQ code.)

the impact to non-high-res architectures is intended to be minimal.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/hrtimer.h   |   70 +++++
 include/linux/interrupt.h |    5 
 include/linux/ktime.h     |    3 
 kernel/hrtimer.c          |  576 ++++++++++++++++++++++++++++++++++++++++++++--
 kernel/itimer.c           |    2 
 kernel/posix-timers.c     |    2 
 kernel/time/Kconfig       |   22 +
 kernel/timer.c            |    1 
 8 files changed, 649 insertions(+), 32 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-09-30 01:41:18.000000000 +0200
@@ -17,6 +17,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
+#include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/wait.h>
@@ -34,9 +35,17 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,
 };
 
+enum hrtimer_cb_mode {
+	HRTIMER_CB_SOFTIRQ,
+	HRTIMER_CB_IRQSAFE,
+	HRTIMER_CB_IRQSAFE_NO_RESTART,
+	HRTIMER_CB_IRQSAFE_NO_SOFTIRQ,
+};
+
 #define HRTIMER_INACTIVE	0x00
 #define HRTIMER_ACTIVE		0x01
 #define HRTIMER_CALLBACK	0x02
+#define HRTIMER_PENDING		0x04
 
 struct hrtimer_clock_base;
 
@@ -49,6 +58,10 @@ struct hrtimer_clock_base;
  * @function:	timer expiry callback function
  * @base:	pointer to the timer base (per cpu and per clock)
  *
+ * @mode:	high resolution timer feature to allow executing the
+ *		callback in the hardirq context (wakeups)
+ * @cb_entry:	list head to enqueue an expired timer into the callback list
+ *
  * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()
  */
 struct hrtimer {
@@ -57,6 +70,10 @@ struct hrtimer {
 	int				(*function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
 	unsigned long			state;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	int				cb_mode;
+	struct list_head		cb_entry;
+#endif
 };
 
 /**
@@ -83,6 +100,9 @@ struct hrtimer_cpu_base;
  * @get_time:		function to retrieve the current time of the clock
  * @get_softirq_time:	function to retrieve the current time from the softirq
  * @softirq_time:	the time when running the hrtimer queue in the softirq
+ * @cb_pending:		list of timers where the callback is pending
+ * @offset:		offset of this clock to the monotonic base
+ * @reprogram:		function to reprogram the timer event
  */
 struct hrtimer_clock_base {
 	struct hrtimer_cpu_base	*cpu_base;
@@ -93,6 +113,12 @@ struct hrtimer_clock_base {
 	ktime_t			(*get_time)(void);
 	ktime_t			(*get_softirq_time)(void);
 	ktime_t			softirq_time;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	ktime_t			offset;
+	int			(*reprogram)(struct hrtimer *t,
+					     struct hrtimer_clock_base *b,
+					     ktime_t n);
+#endif
 };
 
 #define HRTIMER_MAX_CLOCK_BASES 2
@@ -108,17 +134,53 @@ struct hrtimer_cpu_base {
 	spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+#ifdef CONFIG_HIGH_RES_TIMERS
+	ktime_t				expires_next;
+	int				hres_active;
+	unsigned long			check_clocks;
+	struct list_head		cb_pending;
+	struct hrtimer			sched_timer;
+	struct pt_regs			*sched_regs;
+	unsigned long			events;
+#endif
 };
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+extern void hrtimer_clock_notify(void);
+extern void clock_was_set(void);
+extern void hrtimer_interrupt(struct pt_regs *regs);
+
+# define hrtimer_cb_get_time(t)	(t)->base->get_time()
+# define hrtimer_hres_active	(__get_cpu_var(hrtimer_bases).hres_active)
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+# define KTIME_HIGH_RES		(ktime_t) { .tv64 = CONFIG_HIGH_RES_RESOLUTION }
+# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
+
+#else
+
+# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
+
 /*
  * clock_was_set() is a NOP for non- high-resolution systems. The
  * time-sorted order guarantees that a timer does not expire early and
  * is expired in the next softirq when the clock was advanced.
  */
-#define clock_was_set()		do { } while (0)
-#define hrtimer_clock_notify()	do { } while (0)
-extern ktime_t ktime_get(void);
-extern ktime_t ktime_get_real(void);
+# define clock_was_set()		do { } while (0)
+# define hrtimer_clock_notify()		do { } while (0)
+
+# define hrtimer_cb_get_time(t)		(t)->base->softirq_time
+# define hrtimer_hres_active		0
+
+#endif
+
+  extern ktime_t ktime_get(void);
+  extern ktime_t ktime_get_real(void);
 
 /* Exported timer functions: */
 
Index: linux-2.6.18-mm2/include/linux/interrupt.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/interrupt.h	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/interrupt.h	2006-09-30 01:41:18.000000000 +0200
@@ -235,7 +235,10 @@ enum
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
 	BLOCK_SOFTIRQ,
-	TASKLET_SOFTIRQ
+	TASKLET_SOFTIRQ,
+#ifdef CONFIG_HIGH_RES_TIMERS
+	HRTIMER_SOFTIRQ,
+#endif
 };
 
 /* softirq mask and active fields moved to irq_cpustat_t in
Index: linux-2.6.18-mm2/include/linux/ktime.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/ktime.h	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/ktime.h	2006-09-30 01:41:18.000000000 +0200
@@ -261,8 +261,7 @@ static inline u64 ktime_to_ns(const ktim
  * idea of the (in)accuracy of timers. Timer values are rounded up to
  * this resolution values.
  */
-#define KTIME_REALTIME_RES	(ktime_t){ .tv64 = TICK_NSEC }
-#define KTIME_MONOTONIC_RES	(ktime_t){ .tv64 = TICK_NSEC }
+#define KTIME_LOW_RES		(ktime_t){ .tv64 = TICK_NSEC }
 
 /* Get the monotonic time in timespec format: */
 extern void ktime_get_ts(struct timespec *ts);
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-09-30 01:41:18.000000000 +0200
@@ -37,7 +37,11 @@
 #include <linux/hrtimer.h>
 #include <linux/notifier.h>
 #include <linux/syscalls.h>
+#include <linux/kallsyms.h>
 #include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/profile.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 
@@ -80,7 +84,7 @@ EXPORT_SYMBOL_GPL(ktime_get_real);
  * This ensures that we capture erroneous accesses to these clock ids
  * rather than moving them into the range of valid clock id's.
  */
-static DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
+DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 {
 
 	.clock_base =
@@ -88,12 +92,12 @@ static DEFINE_PER_CPU(struct hrtimer_cpu
 		{
 			.index = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
-			.resolution = KTIME_REALTIME_RES,
+			.resolution = KTIME_LOW_RES,
 		},
 		{
 			.index = CLOCK_MONOTONIC,
 			.get_time = &ktime_get,
-			.resolution = KTIME_MONOTONIC_RES,
+			.resolution = KTIME_LOW_RES,
 		},
 	}
 };
@@ -227,7 +231,7 @@ lock_hrtimer_base(const struct hrtimer *
 	return base;
 }
 
-#define switch_hrtimer_base(t, b)	(b)
+# define switch_hrtimer_base(t, b)	(b)
 
 #endif	/* !CONFIG_SMP */
 
@@ -258,9 +262,6 @@ ktime_t ktime_add_ns(const ktime_t kt, u
 
 	return ktime_add(kt, tmp);
 }
-
-#else /* CONFIG_KTIME_SCALAR */
-
 # endif /* !CONFIG_KTIME_SCALAR */
 
 /*
@@ -288,11 +289,366 @@ static unsigned long ktime_divns(const k
 # define ktime_divns(kt, div)		(unsigned long)((kt).tv64 / (div))
 #endif /* BITS_PER_LONG >= 64 */
 
+/* High resolution timer related functions */
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+static ktime_t last_jiffies_update;
+
+/*
+ * Reprogramm the event source with checking both queues for the
+ * next event
+ * Called with interrupts disabled and base->lock held
+ */
+static void hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base)
+{
+	int i;
+	struct hrtimer_clock_base *base = cpu_base->clock_base;
+	ktime_t expires;
+
+	cpu_base->expires_next.tv64 = KTIME_MAX;
+
+	for (i = HRTIMER_MAX_CLOCK_BASES; i ; i--, base++) {
+		struct hrtimer *timer;
+
+		if (!base->first)
+			continue;
+		timer = rb_entry(base->first, struct hrtimer, node);
+		expires = ktime_sub(timer->expires, base->offset);
+		if (expires.tv64 < cpu_base->expires_next.tv64)
+			cpu_base->expires_next = expires;
+	}
+
+	if (cpu_base->expires_next.tv64 != KTIME_MAX)
+		clockevents_set_next_event(cpu_base->expires_next, 1);
+}
+
+/*
+ * Shared reprogramming for clock_realtime and clock_monotonic
+ *
+ * When a new expires first timer is enqueued, we have
+ * to check, whether it expires earlier than the timer
+ * for which the hrt time source was armed.
+ *
+ * Called with interrupts disabled and base->cpu_base.lock held
+ */
+static int hrtimer_reprogram(struct hrtimer *timer,
+			     struct hrtimer_clock_base *base)
+{
+	ktime_t *expires_next = &__get_cpu_var(hrtimer_bases).expires_next;
+	ktime_t expires = ktime_sub(timer->expires, base->offset);
+	int res;
+
+	/* Callback running on another CPU ? */
+	if (timer->state & HRTIMER_CALLBACK)
+		return 0;
+
+	if (expires.tv64 >= expires_next->tv64)
+		return 0;
+
+	res = clockevents_set_next_event(expires, 0);
+	if (!res)
+		*expires_next = expires;
+	return res;
+}
+
+
+/*
+ * Retrigger next event is called after clock was set
+ */
+static void retrigger_next_event(void *arg)
+{
+	struct hrtimer_cpu_base *base;
+	struct timespec realtime_offset;
+	unsigned long flags, seq;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		set_normalized_timespec(&realtime_offset,
+					-wall_to_monotonic.tv_sec,
+					-wall_to_monotonic.tv_nsec);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	base = &per_cpu(hrtimer_bases, smp_processor_id());
+
+	/* Adjust CLOCK_REALTIME offset */
+	spin_lock_irqsave(&base->lock, flags);
+	base->clock_base[CLOCK_REALTIME].offset =
+		timespec_to_ktime(realtime_offset);
+
+	hrtimer_force_reprogram(base);
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
+/*
+ * Clock realtime was set
+ *
+ * Change the offset of the realtime clock vs. the monotonic
+ * clock.
+ *
+ * We might have to reprogram the high resolution timer interrupt. On
+ * SMP we call the architecture specific code to retrigger _all_ high
+ * resolution timer interrupts. On UP we just disable interrupts and
+ * call the high resolution interrupt code.
+ */
+void clock_was_set(void)
+{
+	preempt_disable();
+	if (hrtimer_hres_active) {
+		retrigger_next_event(NULL);
+
+		if (smp_call_function(retrigger_next_event, NULL, 1, 1))
+			BUG();
+	}
+	preempt_enable();
+}
+
+/**
+ * hrtimer_clock_notify - A clock source or a clock event has been installed
+ *
+ * Notify the per cpu softirqs to recheck the clock sources and events
+ */
+void hrtimer_clock_notify(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		set_bit(0, &per_cpu(hrtimer_bases, i).check_clocks);
+}
+
+
+static const ktime_t nsec_per_hz = { .tv64 = NSEC_PER_SEC / HZ };
+
+/*
+ * We switched off the global tick source when switching to high resolution
+ * mode. Update jiffies64.
+ *
+ * Must be called with interrupts disabled !
+ *
+ * FIXME: We need a mechanism to assign the update to a CPU. In principle this
+ * is not hard, but when dynamic ticks come into play it starts to be. We don't
+ * want to wake up a complete idle cpu just to update jiffies, so we need
+ * something more intellegent than a mere "do this only on CPUx".
+ */
+static void update_jiffies64(ktime_t now)
+{
+	ktime_t delta;
+
+	write_seqlock(&xtime_lock);
+
+	delta = ktime_sub(now, last_jiffies_update);
+	if (delta.tv64 >= nsec_per_hz.tv64) {
+
+		unsigned long orun = 1;
+
+		delta = ktime_sub(delta, nsec_per_hz);
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						nsec_per_hz);
+
+		/* Slow path for long timeouts */
+		if (unlikely(delta.tv64 >= nsec_per_hz.tv64)) {
+			s64 incr = ktime_to_ns(nsec_per_hz);
+			orun = ktime_divns(delta, incr);
+
+			last_jiffies_update = ktime_add_ns(last_jiffies_update,
+							   incr * orun);
+			jiffies_64 += orun;
+			orun++;
+		}
+		do_timer(orun);
+	}
+	write_sequnlock(&xtime_lock);
+}
+
+/*
+ * We rearm the timer until we get disabled by the idle code
+ */
+static int hrtimer_sched_tick(struct hrtimer *timer)
+{
+	unsigned long flags;
+	struct hrtimer_cpu_base *cpu_base =
+		container_of(timer, struct hrtimer_cpu_base, sched_timer);
+
+	local_irq_save(flags);
+	/*
+	 * Do not call, when we are not in irq context and have
+	 * no valid regs pointer
+	 */
+	if (cpu_base->sched_regs) {
+		update_process_times(user_mode(cpu_base->sched_regs));
+		profile_tick(CPU_PROFILING, cpu_base->sched_regs);
+	}
+
+	hrtimer_forward(timer, hrtimer_cb_get_time(timer), nsec_per_hz);
+	local_irq_restore(flags);
+
+	return HRTIMER_RESTART;
+}
+
+/*
+ * A change in the clock source or clock events was detected.
+ * Check the clock source and the events, whether we can switch to
+ * high resolution mode or not.
+ *
+ * TODO: Handle the removal of clock sources / events
+ */
+static void hrtimer_check_clocks(void)
+{
+	struct hrtimer_cpu_base *base = &__get_cpu_var(hrtimer_bases);
+	unsigned long flags;
+	ktime_t now;
+
+	if (!test_and_clear_bit(0, &base->check_clocks))
+		return;
+
+	if (!timekeeping_is_continuous())
+		return;
+
+	if (!clockevents_next_event_available())
+		return;
+
+	local_irq_save(flags);
+
+	if (base->hres_active) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	now = ktime_get();
+	if (clockevents_init_next_event()) {
+		local_irq_restore(flags);
+		return;
+	}
+	base->hres_active = 1;
+	base->clock_base[CLOCK_REALTIME].resolution = KTIME_HIGH_RES;
+	base->clock_base[CLOCK_MONOTONIC].resolution = KTIME_HIGH_RES;
+
+	/* Did we start the jiffies update yet ? */
+	if (last_jiffies_update.tv64 == 0) {
+		write_seqlock(&xtime_lock);
+		last_jiffies_update = now;
+		write_sequnlock(&xtime_lock);
+	}
+
+	/*
+	 * Emulate tick processing via per-CPU hrtimers:
+	 */
+	hrtimer_init(&base->sched_timer, CLOCK_MONOTONIC, HRTIMER_REL);
+	base->sched_timer.function = hrtimer_sched_tick;
+	base->sched_timer.cb_mode = HRTIMER_CB_IRQSAFE_NO_SOFTIRQ;
+	hrtimer_start(&base->sched_timer, nsec_per_hz, HRTIMER_REL);
+
+	/* "Retrigger" the interrupt to get things going */
+	retrigger_next_event(NULL);
+	local_irq_restore(flags);
+	printk(KERN_INFO "hrtimers: Switched to high resolution mode CPU %d\n",
+	       smp_processor_id());
+}
+
+static inline int hrtimer_cb_pending(const struct hrtimer *timer)
+{
+	return !list_empty(&timer->cb_entry);
+}
+
+static inline void hrtimer_remove_cb_pending(struct hrtimer *timer)
+{
+	list_del_init(&timer->cb_entry);
+}
+
+static inline void hrtimer_add_cb_pending(struct hrtimer *timer,
+					  struct hrtimer_clock_base *base)
+{
+	list_add_tail(&timer->cb_entry, &base->cpu_base->cb_pending);
+	timer->state = HRTIMER_PENDING;
+}
+
+static inline void hrtimer_init_hres(struct hrtimer_cpu_base *base)
+{
+	base->expires_next.tv64 = KTIME_MAX;
+	set_bit(0, &base->check_clocks);
+	base->hres_active = 0;
+	INIT_LIST_HEAD(&base->cb_pending);
+}
+
+static inline void hrtimer_init_timer_hres(struct hrtimer *timer)
+{
+	INIT_LIST_HEAD(&timer->cb_entry);
+}
+
+static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
+					    struct hrtimer_clock_base *base)
+{
+	/*
+	 * When High resolution timers are active try to reprogram. Note, that
+	 * in case the state has HRTIMER_CALLBACK set, no reprogramming and no
+	 * expiry check happens. The timer gets enqueued into the rbtree and
+	 * the reprogramming / expiry check is done in the hrtimer_interrupt or
+	 * in the softirq.
+	 */
+	if (hrtimer_hres_active && hrtimer_reprogram(timer, base)) {
+
+		/* Timer is expired, act upon the callback mode */
+		switch(timer->cb_mode) {
+		case HRTIMER_CB_IRQSAFE_NO_RESTART:
+			/*
+			 * We can call the callback from here. No restart
+			 * happens, so no danger of recursion
+			 */
+			BUG_ON(timer->function(timer) != HRTIMER_NORESTART);
+			return 1;
+		case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
+			/*
+			 * This is solely for the sched tick emulation with
+			 * dynamic tick support to ensure that we do not
+			 * restart the tick right on the edge and end up with
+			 * the tick timer in the softirq ! The calling site
+			 * takes care of this.
+			 */
+			return 1;
+		case HRTIMER_CB_IRQSAFE:
+		case HRTIMER_CB_SOFTIRQ:
+			/*
+			 * Move everything else into the softirq pending list !
+			 */
+			hrtimer_add_cb_pending(timer, base);
+			raise_softirq(HRTIMER_SOFTIRQ);
+			return 1;
+		default:
+			BUG();
+		}
+	}
+	return 0;
+}
+
+static inline void hrtimer_resume_jiffie_update(void)
+{
+	unsigned long flags;
+	ktime_t now = ktime_get();
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	last_jiffies_update = now;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
+#else
+
+# define hrtimer_hres_active		0
+# define hrtimer_check_clocks()		do { } while (0)
+# define hrtimer_enqueue_reprogram(t,b)	0
+# define hrtimer_force_reprogram(b)	do { } while (0)
+# define hrtimer_cb_pending(t)		0
+# define hrtimer_remove_cb_pending(t)	do { } while (0)
+# define hrtimer_init_hres(c)		do { } while (0)
+# define hrtimer_init_timer_hres(t)	do { } while (0)
+# define hrtimer_resume_jiffie_update()	do { } while (0)
+
+#endif /* CONFIG_HIGH_RES_TIMERS */
+
 /*
  * Timekeeping resumed notification
  */
 void hrtimer_notify_resume(void)
 {
+	hrtimer_resume_jiffie_update();
 	clockevents_resume_events();
 	clock_was_set();
 }
@@ -380,13 +736,18 @@ static void enqueue_hrtimer(struct hrtim
 	 * Insert the timer to the rbtree and check whether it
 	 * replaces the first pending timer
 	 */
+	if (!base->first || timer->expires.tv64 <
+	    rb_entry(base->first, struct hrtimer, node)->expires.tv64) {
+
+		if (hrtimer_enqueue_reprogram(timer, base))
+			return;
+
+		base->first = &timer->node;
+	}
+
 	rb_link_node(&timer->node, parent, link);
 	rb_insert_color(&timer->node, &base->active);
 	timer->state |= HRTIMER_ACTIVE;
-
-	if (!base->first || timer->expires.tv64 <
-	    rb_entry(base->first, struct hrtimer, node)->expires.tv64)
-		base->first = &timer->node;
 }
 
 /*
@@ -396,15 +757,23 @@ static void enqueue_hrtimer(struct hrtim
  */
 static void __remove_hrtimer(struct hrtimer *timer,
 			     struct hrtimer_clock_base *base,
-			     unsigned long newstate)
+			     unsigned long newstate, int reprogram)
 {
-	/*
-	 * Remove the timer from the rbtree and replace the
-	 * first entry pointer if necessary.
-	 */
-	if (base->first == &timer->node)
-		base->first = rb_next(&timer->node);
-	rb_erase(&timer->node, &base->active);
+	/* High res. callback list. NOP for !HIGHRES */
+	if (hrtimer_cb_pending(timer))
+		hrtimer_remove_cb_pending(timer);
+	else {
+		/*
+		 * Remove the timer from the rbtree and replace the
+		 * first entry pointer if necessary.
+		 */
+		if (base->first == &timer->node) {
+			base->first = rb_next(&timer->node);
+			if (reprogram && hrtimer_hres_active)
+				hrtimer_force_reprogram(base->cpu_base);
+		}
+		rb_erase(&timer->node, &base->active);
+	}
 	timer->state = newstate;
 }
 
@@ -415,7 +784,11 @@ static inline int
 remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base)
 {
 	if (hrtimer_active(timer)) {
-		__remove_hrtimer(timer, base, HRTIMER_INACTIVE);
+		/*
+		 * Remove the timer and force reprogramming when high
+		 * resolution mode is active
+		 */
+		__remove_hrtimer(timer, base, HRTIMER_INACTIVE, 1);
 		return 1;
 	}
 	return 0;
@@ -550,6 +923,13 @@ ktime_t hrtimer_get_next_event(void)
 	unsigned long flags;
 	int i;
 
+	/*
+	 * In high-res mode we dont need to get the next high-res
+	 * event on a tickless system:
+	 */
+	if (hrtimer_hres_active)
+		return mindelta;
+
 	spin_lock_irqsave(&cpu_base->lock, flags);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++, base++) {
@@ -592,6 +972,7 @@ void hrtimer_init(struct hrtimer *timer,
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &cpu_base->clock_base[clock_id];
+	hrtimer_init_timer_hres(timer);
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
 
@@ -614,6 +995,138 @@ int hrtimer_get_res(const clockid_t whic
 }
 EXPORT_SYMBOL_GPL(hrtimer_get_res);
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+
+/*
+ * High resolution timer interrupt
+ * Called with interrupts disabled
+ */
+void hrtimer_interrupt(struct pt_regs *regs)
+{
+	struct hrtimer_clock_base *base;
+	ktime_t expires_next, now;
+	int i, raise = 0, cpu = smp_processor_id();
+	struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
+
+	BUG_ON(!cpu_base->hres_active);
+
+	/* Store the regs for an possible sched_timer callback */
+	cpu_base->sched_regs = regs;
+	cpu_base->events++;
+
+ retry:
+	now = ktime_get();
+
+	/* Check, if the jiffies need an update */
+	update_jiffies64(now);
+
+	expires_next.tv64 = KTIME_MAX;
+
+	base = cpu_base->clock_base;
+
+	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
+		ktime_t basenow;
+		struct rb_node *node;
+
+		spin_lock(&cpu_base->lock);
+
+		basenow = ktime_add(now, base->offset);
+
+		while ((node = base->first)) {
+			struct hrtimer *timer;
+
+			timer = rb_entry(node, struct hrtimer, node);
+
+			if (basenow.tv64 < timer->expires.tv64) {
+				ktime_t expires;
+
+				expires = ktime_sub(timer->expires,
+						    base->offset);
+				if (expires.tv64 < expires_next.tv64)
+					expires_next = expires;
+				break;
+			}
+
+			/* Move softirq callbacks to the pending list */
+			if (timer->cb_mode == HRTIMER_CB_SOFTIRQ) {
+				__remove_hrtimer(timer, base, HRTIMER_PENDING, 0);
+				hrtimer_add_cb_pending(timer, base);
+				raise = 1;
+				continue;
+			}
+
+			__remove_hrtimer(timer, base, HRTIMER_CALLBACK, 0);
+
+			if (timer->function(timer) != HRTIMER_NORESTART) {
+				BUG_ON(timer->state != HRTIMER_CALLBACK);
+				/*
+				 * state == HRTIMER_CALLBACK prevents
+				 * reprogramming. We do this when we break out
+				 * of the loop !
+				 */
+				enqueue_hrtimer(timer, base);
+			}
+			timer->state &= ~HRTIMER_CALLBACK;
+		}
+		spin_unlock(&cpu_base->lock);
+		base++;
+	}
+
+	cpu_base->expires_next = expires_next;
+
+	/* Reprogramming necessary ? */
+	if (expires_next.tv64 != KTIME_MAX) {
+		if (clockevents_set_next_event(expires_next, 0))
+			goto retry;
+	}
+
+	/* Invalidate regs */
+	cpu_base->sched_regs = NULL;
+
+	/* Raise softirq ? */
+	if (raise)
+		raise_softirq(HRTIMER_SOFTIRQ);
+}
+
+static void run_hrtimer_softirq(struct softirq_action *h)
+{
+	struct hrtimer_cpu_base *cpu_base;
+
+	cpu_base = &per_cpu(hrtimer_bases, smp_processor_id());
+
+	spin_lock_irq(&cpu_base->lock);
+
+	while (!list_empty(&cpu_base->cb_pending)) {
+		struct hrtimer *timer;
+		int (*fn)(struct hrtimer *);
+		int restart;
+
+		timer = list_entry(cpu_base->cb_pending.next,
+				   struct hrtimer, cb_entry);
+
+		fn = timer->function;
+		__remove_hrtimer(timer, timer->base, HRTIMER_CALLBACK, 0);
+		spin_unlock_irq(&cpu_base->lock);
+
+		restart = fn(timer);
+
+		spin_lock_irq(&cpu_base->lock);
+
+		timer->state &= ~HRTIMER_CALLBACK;
+		if (restart == HRTIMER_RESTART) {
+			BUG_ON(hrtimer_active(timer));
+			enqueue_hrtimer(timer, timer->base);
+		} else if (hrtimer_active(timer)) {
+			/* Timer was rearmed on another CPU: */
+			if (timer->base->first == &timer->node)
+				hrtimer_reprogram(timer, timer->base);
+		}
+	}
+	spin_unlock_irq(&cpu_base->lock);
+}
+
+#endif	/* CONFIG_HIGH_RES_TIMERS */
+
 /*
  * Expire the per base hrtimer-queue:
  */
@@ -641,7 +1154,7 @@ static inline void run_hrtimer_queue(str
 			break;
 
 		fn = timer->function;
-		__remove_hrtimer(timer, base, HRTIMER_CALLBACK);
+		__remove_hrtimer(timer, base, HRTIMER_CALLBACK, 0);
 		spin_unlock_irq(&cpu_base->lock);
 
 		restart = fn(timer);
@@ -659,12 +1172,21 @@ static inline void run_hrtimer_queue(str
 
 /*
  * Called from timer softirq every jiffy, expire hrtimers:
+ *
+ * For HRT its the fall back code to run the softirq in the timer
+ * softirq context in case the hrtimer initialization failed or has
+ * not been done yet.
  */
 void hrtimer_run_queues(void)
 {
 	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
 	int i;
 
+	hrtimer_check_clocks();
+
+	if (hrtimer_hres_active)
+		return;
+
 	hrtimer_get_softirq_time(cpu_base);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++)
@@ -691,6 +1213,9 @@ void hrtimer_init_sleeper(struct hrtimer
 {
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = task;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	sl->timer.cb_mode = HRTIMER_CB_IRQSAFE_NO_RESTART;
+#endif
 }
 
 static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
@@ -701,7 +1226,8 @@ static int __sched do_nanosleep(struct h
 		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start(&t->timer, t->timer.expires, mode);
 
-		schedule();
+		if (likely(t->task))
+			schedule();
 
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_ABS;
@@ -806,6 +1332,7 @@ static void __devinit init_hrtimers_cpu(
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++)
 		cpu_base->clock_base[i].cpu_base = cpu_base;
 
+	hrtimer_init_hres(cpu_base);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -819,7 +1346,7 @@ static void migrate_hrtimer_list(struct 
 	while ((node = rb_first(&old_base->active))) {
 		timer = rb_entry(node, struct hrtimer, node);
 		BUG_ON(timer->state & HRTIMER_CALLBACK);
-		__remove_hrtimer(timer, old_base, HRTIMER_INACTIVE);
+		__remove_hrtimer(timer, old_base, HRTIMER_INACTIVE, 0);
 		timer->base = new_base;
 		enqueue_hrtimer(timer, new_base);
 	}
@@ -884,5 +1411,8 @@ void __init hrtimers_init(void)
 	hrtimer_cpu_notify(&hrtimers_nb, (unsigned long)CPU_UP_PREPARE,
 			  (void *)(long)smp_processor_id());
 	register_cpu_notifier(&hrtimers_nb);
+#ifdef CONFIG_HIGH_RES_TIMERS
+	open_softirq(HRTIMER_SOFTIRQ, run_hrtimer_softirq, NULL);
+#endif
 }
 
Index: linux-2.6.18-mm2/kernel/itimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/itimer.c	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/kernel/itimer.c	2006-09-30 01:41:18.000000000 +0200
@@ -136,7 +136,7 @@ int it_real_fn(struct hrtimer *timer)
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
 	if (sig->it_real_incr.tv64 != 0) {
-		hrtimer_forward(timer, timer->base->softirq_time,
+		hrtimer_forward(timer, hrtimer_cb_get_time(timer),
 				sig->it_real_incr);
 		return HRTIMER_RESTART;
 	}
Index: linux-2.6.18-mm2/kernel/posix-timers.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/posix-timers.c	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/kernel/posix-timers.c	2006-09-30 01:41:18.000000000 +0200
@@ -356,7 +356,7 @@ static int posix_timer_fn(struct hrtimer
 		if (timr->it.real.interval.tv64 != 0) {
 			timr->it_overrun +=
 				hrtimer_forward(timer,
-						timer->base->softirq_time,
+						hrtimer_cb_get_time(timer),
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
Index: linux-2.6.18-mm2/kernel/time/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm2/kernel/time/Kconfig	2006-09-30 01:41:18.000000000 +0200
@@ -0,0 +1,22 @@
+#
+# Timer subsystem related configuration options
+#
+config HIGH_RES_TIMERS
+	bool "High Resolution Timer Support"
+	depends on GENERIC_TIME
+	help
+	  This option enables high resolution timer support. If your
+	  hardware is not capable then this option only increases
+	  the size of the kernel image.
+
+config HIGH_RES_RESOLUTION
+	int "High Resolution Timer resolution (nanoseconds)"
+	depends on HIGH_RES_TIMERS
+	default 1000
+	help
+	  This sets the resolution in nanoseconds of the high resolution
+	  timers. Too fine a resolution (small a number) will usually
+	  not be observable due to normal system latencies.  For an
+          800 MHz processor about 10,000 (10 microseconds) is recommended as a
+	  finest resolution.  If you don't need that sort of resolution,
+	  larger values may generate less overhead.
Index: linux-2.6.18-mm2/kernel/timer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/timer.c	2006-09-30 01:41:16.000000000 +0200
+++ linux-2.6.18-mm2/kernel/timer.c	2006-09-30 01:41:18.000000000 +0200
@@ -1022,6 +1022,7 @@ static void update_wall_time(void)
 	if (change_clocksource()) {
 		clock->error = 0;
 		clock->xtime_nsec = 0;
+		hrtimer_clock_notify();
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
 }

--


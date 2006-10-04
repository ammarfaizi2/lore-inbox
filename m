Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161917AbWJDRiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161917AbWJDRiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161919AbWJDRiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:20 -0400
Received: from www.osadl.org ([213.239.205.134]:41189 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161917AbWJDRiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:06 -0400
Message-Id: <20061004172223.921928000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:48 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 18/22] dynticks: core
Content-Disposition: inline; filename=dynticks-core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

dynamic ticks core code.

This is an extension to the per-cpu sched_tick timer of the high resolution
timer functionality.  The sched_tick timer is reprogrammed to a longer timeout
before going idle, when no timer events are due in the next tick.  The
periodic tick is resumed when the CPU leaves the idle state.  If a non-timer
IRQ hits the idle task jiffies are updated from irq_enter before calling the
interrupt code, otherwise the interrupt handler would eventually deal with a
stale jiffy value.

The per-cpu idle statistics information can be used to optimize power
management decisions.

More detailed information is available in Documentation/hrtimer/highres.txt

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
 include/linux/hardirq.h |   12 ++
 include/linux/hrtimer.h |   34 ++++++
 kernel/hrtimer.c        |  261 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/softirq.c        |   14 ++
 kernel/time/Kconfig     |    7 +
 kernel/timer.c          |    2 
 6 files changed, 318 insertions(+), 12 deletions(-)

Index: linux-2.6.18-mm3/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hrtimer.h	2006-10-04 18:13:57.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hrtimer.h	2006-10-04 18:13:58.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 
+struct seq_file;
 struct hrtimer_clock_base;
 struct hrtimer_cpu_base;
 
@@ -180,6 +181,17 @@ struct hrtimer_clock_base {
  *			resolution mode
  * @sched_regs:		Temporary storage for pt_regs for the sched_timer
  *			callback
+ * @nr_events:		Total number of timer interrupt events
+ * @idle_tick:		Store the last idle tick expiry time when the tick
+ *			timer is modified for idle sleeps. This is necessary
+ *			to resume the tick timer operation in the timeline
+ *			when the CPU returns from idle
+ * @tick_stopped:	Indicator that the idle tick has been stopped
+ * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
+ * @idle_calls:		Total number of idle calls
+ * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
+ * @idle_entrytime:	Time when the idle call was entered
+ * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
  */
 struct hrtimer_cpu_base {
 	spinlock_t			lock;
@@ -192,6 +204,16 @@ struct hrtimer_cpu_base {
 	struct list_head		cb_pending;
 	struct hrtimer			sched_timer;
 	struct pt_regs			*sched_regs;
+	unsigned long			nr_events;
+#endif
+#ifdef CONFIG_NO_HZ
+	ktime_t				idle_tick;
+	int				tick_stopped;
+	unsigned long			idle_jiffies;
+	unsigned long			idle_calls;
+	unsigned long			idle_sleeps;
+	ktime_t				idle_entrytime;
+	ktime_t				idle_sleeptime;
 #endif
 };
 
@@ -298,6 +320,18 @@ extern void hrtimer_run_queues(void);
 /* Resume notification */
 void hrtimer_notify_resume(void);
 
+#ifdef CONFIG_NO_HZ
+extern void hrtimer_stop_sched_tick(void);
+extern void hrtimer_restart_sched_tick(void);
+extern void hrtimer_update_jiffies(void);
+extern void show_no_hz_stats(struct seq_file *p);
+#else
+static inline void hrtimer_stop_sched_tick(void) { }
+static inline void hrtimer_restart_sched_tick(void) { }
+static inline void hrtimer_update_jiffies(void) { }
+static inline void show_no_hz_stats(struct seq_file *p) { }
+#endif
+
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
 
Index: linux-2.6.18-mm3/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/hrtimer.c	2006-10-04 18:13:57.000000000 +0200
+++ linux-2.6.18-mm3/kernel/hrtimer.c	2006-10-04 18:13:58.000000000 +0200
@@ -44,6 +44,7 @@
 #include <linux/profile.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/uaccess.h>
 
@@ -476,6 +477,7 @@ static void update_jiffies64(ktime_t now
 {
 	unsigned long seq;
 	ktime_t delta;
+	unsigned long ticks = 0;
 
 	/* Preevaluate to avoid lock contention */
 	do {
@@ -491,7 +493,6 @@ static void update_jiffies64(ktime_t now
 
 	delta = ktime_sub(now, last_jiffies_update);
 	if (delta.tv64 >= nsec_per_hz.tv64) {
-		unsigned long ticks = 1;
 
 		delta = ktime_sub(delta, nsec_per_hz);
 		last_jiffies_update = ktime_add(last_jiffies_update,
@@ -505,13 +506,238 @@ static void update_jiffies64(ktime_t now
 
 			last_jiffies_update = ktime_add_ns(last_jiffies_update,
 							   incr * ticks);
-			ticks++;
 		}
+		ticks++;
 		do_timer(ticks);
 	}
 	write_sequnlock(&xtime_lock);
 }
 
+#ifdef CONFIG_NO_HZ
+/**
+ * hrtimer_update_jiffies - update jiffies when idle was interrupted
+ *
+ * Called from interrupt entry when the CPU was idle
+ *
+ * In case the sched_tick was stopped on this CPU, we have to check if jiffies
+ * must be updated. Otherwise an interrupt handler could use a stale jiffy
+ * value.
+ */
+void hrtimer_update_jiffies(void)
+{
+	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
+	unsigned long flags;
+	ktime_t now;
+
+	if (!cpu_base->tick_stopped || !cpu_base->hres_active)
+		return;
+
+	now = ktime_get();
+
+	local_irq_save(flags);
+	update_jiffies64(now);
+	local_irq_restore(flags);
+}
+
+/**
+ * hrtimer_stop_sched_tick - stop the idle tick from the idle task
+ *
+ * When the next event is more than a tick into the future, stop the idle tick
+ * Called either from the idle loop or from irq_exit() when a idle period was
+ * just interrupted by a interrupt which did not cause a reschedule.
+ */
+void hrtimer_stop_sched_tick(void)
+{
+	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
+	unsigned long seq, last_jiffies, next_jiffies;
+	ktime_t last_update, expires, now;
+	unsigned long delta_jiffies;
+	unsigned long flags;
+
+	if (unlikely(!cpu_base->hres_active))
+		return;
+
+	local_irq_save(flags);
+
+	now = ktime_get();
+	/*
+	 * When called from irq_exit we need to account the idle sleep time
+	 * correctly.
+	 */
+	if (cpu_base->tick_stopped) {
+		ktime_t delta = ktime_sub(now, cpu_base->idle_entrytime);
+
+		cpu_base->idle_sleeptime = ktime_add(cpu_base->idle_sleeptime,
+						     delta);
+	}
+
+	cpu_base->idle_entrytime = now;
+	cpu_base->idle_calls++;
+
+	/* Read jiffies and the time when jiffies were updated last */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		last_update = last_jiffies_update;
+		last_jiffies = jiffies;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	/* Get the next timer wheel timer */
+	next_jiffies = get_next_timer_interrupt(last_jiffies);
+	delta_jiffies = next_jiffies - last_jiffies;
+
+	if ((long)delta_jiffies >= 1) {
+		/*
+		 * hrtimer_stop_sched_tick can be called several times before
+		 * the hrtimer_restart_sched_tick is called. This happens when
+		 * interrupts arrive which do not cause a reschedule. In the
+		 * first call we save the current tick time, so we can restart
+		 * the scheduler tick in hrtimer_restart_sched_tick.
+		 */
+		if (!cpu_base->tick_stopped) {
+			cpu_base->idle_tick = cpu_base->sched_timer.expires;
+			cpu_base->tick_stopped = 1;
+			cpu_base->idle_jiffies = last_jiffies;
+		}
+		/* calculate the expiry time for the next timer wheel timer */
+		expires = ktime_add_ns(last_update,
+				       nsec_per_hz.tv64 * delta_jiffies);
+		hrtimer_start(&cpu_base->sched_timer, expires,
+			      HRTIMER_MODE_ABS);
+		cpu_base->idle_sleeps++;
+	} else {
+		/* Raise the softirq if the timer wheel is behind jiffies */
+		if ((long) delta_jiffies < 0)
+			raise_softirq_irqoff(TIMER_SOFTIRQ);
+	}
+
+	local_irq_restore(flags);
+}
+
+/**
+ * hrtimer_restart_sched_tick - restart the idle tick from the idle task
+ *
+ * Restart the idle tick when the CPU is woken up from idle
+ */
+void hrtimer_restart_sched_tick(void)
+{
+	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
+	unsigned long ticks;
+	ktime_t now, delta;
+
+	if (!cpu_base->hres_active || !cpu_base->tick_stopped)
+		return;
+
+	/* Update jiffies first */
+	now = ktime_get();
+
+	local_irq_disable();
+	update_jiffies64(now);
+
+	/* Account the idle time */
+	delta = ktime_sub(now, cpu_base->idle_entrytime);
+	cpu_base->idle_sleeptime = ktime_add(cpu_base->idle_sleeptime, delta);
+
+	/*
+	 * We stopped the tick in idle. Update process times would miss the
+	 * time we slept as update_process_times does only a 1 tick
+	 * accounting. Enforce that this is accounted to idle !
+	 */
+	ticks = jiffies - cpu_base->idle_jiffies;
+	/*
+	 * We might be one off. Do not randomly account a huge number of ticks!
+	 */
+	if (ticks && ticks < LONG_MAX) {
+		add_preempt_count(HARDIRQ_OFFSET);
+		account_system_time(current, HARDIRQ_OFFSET,
+				    jiffies_to_cputime(ticks));
+		sub_preempt_count(HARDIRQ_OFFSET);
+	}
+
+	/*
+	 * Cancel the scheduled timer and restore the tick
+	 */
+	cpu_base->tick_stopped  = 0;
+	hrtimer_cancel(&cpu_base->sched_timer);
+	cpu_base->sched_timer.expires = cpu_base->idle_tick;
+
+	while (1) {
+		/* Forward the time to expire in the future */
+		hrtimer_forward(&cpu_base->sched_timer, now, nsec_per_hz);
+		hrtimer_start(&cpu_base->sched_timer,
+			      cpu_base->sched_timer.expires, HRTIMER_MODE_ABS);
+
+		/* Check, if the timer was already in the past */
+		if (hrtimer_active(&cpu_base->sched_timer))
+			break;
+		/* Update jiffies and reread time */
+		update_jiffies64(now);
+		now = ktime_get();
+	}
+	local_irq_enable();
+}
+
+/**
+ * show_no_hz_stats - print out the no hz statistics
+ *
+ * The no_hz statistics are appended at the end of /proc/stats
+ *
+ * I: total number of idle calls
+ * S: number of idle calls which stopped the sched tick
+ * T: Summed up sleep time in idle with sched tick stopped (unit is seconds)
+ * A: Average sleep time: T/S (unit is seconds)
+ * E: Total number of timer interrupt events
+ */
+void show_no_hz_stats(struct seq_file *p)
+{
+	unsigned long calls = 0, sleeps = 0, events = 0;
+	struct timeval tsum, tavg;
+	ktime_t totaltime = { .tv64 = 0 };
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct hrtimer_cpu_base *base = &per_cpu(hrtimer_bases, cpu);
+
+		calls += base->idle_calls;
+		sleeps += base->idle_sleeps;
+		totaltime = ktime_add(totaltime, base->idle_sleeptime);
+		events += base->nr_events;
+
+#ifdef CONFIG_SMP
+		tsum = ktime_to_timeval(base->idle_sleeptime);
+		if (base->idle_sleeps) {
+			uint64_t nsec = ktime_to_ns(base->idle_sleeptime);
+
+			do_div(nsec, base->idle_sleeps);
+			tavg = ns_to_timeval(nsec);
+		} else
+			tavg.tv_sec = tavg.tv_usec = 0;
+
+		seq_printf(p, "nohz cpu%d I:%lu S:%lu T:%d.%06d A:%d.%06d E: %lu\n",
+			   cpu, base->idle_calls, base->idle_sleeps,
+			   (int) tsum.tv_sec, (int) tsum.tv_usec,
+			   (int) tavg.tv_sec, (int) tavg.tv_usec,
+			   base->nr_events);
+#endif
+	}
+
+	tsum = ktime_to_timeval(totaltime);
+	if (sleeps) {
+		uint64_t nsec = ktime_to_ns(totaltime);
+
+			do_div(nsec, sleeps);
+			tavg = ns_to_timeval(nsec);
+	} else
+		tavg.tv_sec = tavg.tv_usec = 0;
+
+	seq_printf(p, "nohz total I:%lu S:%lu T:%d.%06d A:%d.%06d E: %lu\n",
+		   calls, sleeps,
+		   (int) tsum.tv_sec, (int) tsum.tv_usec,
+		   (int) tavg.tv_sec, (int) tavg.tv_usec,
+		   events);
+}
+
+#endif
+
 /*
  * We rearm the timer until we get disabled by the idle code
  * Called with interrupts disabled.
@@ -520,12 +746,30 @@ static enum hrtimer_restart hrtimer_sche
 {
 	struct hrtimer_cpu_base *cpu_base =
 		container_of(timer, struct hrtimer_cpu_base, sched_timer);
+	ktime_t now = ktime_get();
+
+	/* Check, if the jiffies need an update */
+	update_jiffies64(now);
 
 	/*
 	 * Do not call, when we are not in irq context and have
 	 * no valid regs pointer
 	 */
 	if (cpu_base->sched_regs) {
+#ifdef CONFIG_NO_HZ
+		/*
+		 * When we are idle and the tick is stopped, we have to touch
+		 * the watchdog as we might not schedule for a really long
+		 * time. This happens on complete idle SMP systems while
+		 * waiting on the login prompt. We also increment the "start of
+		 * idle" jiffy stamp so the idle accounting adjustment we do
+		 * when we go busy again does not account too much ticks.
+		 */
+		if (cpu_base->tick_stopped) {
+			touch_softlockup_watchdog();
+			cpu_base->idle_jiffies++;
+		}
+#endif
 		/*
 		 * update_process_times() might take tasklist_lock, hence
 		 * drop the base lock. sched-tick hrtimers are per-CPU and
@@ -537,7 +781,13 @@ static enum hrtimer_restart hrtimer_sche
 		spin_lock(&cpu_base->lock);
 	}
 
-	hrtimer_forward(timer, hrtimer_cb_get_time(timer), nsec_per_hz);
+#ifdef CONFIG_NO_HZ
+	/* Do not restart, when we are in the idle loop */
+	if (cpu_base->tick_stopped)
+		return HRTIMER_NORESTART;
+#endif
+
+	hrtimer_forward(timer, now, nsec_per_hz);
 
 	return HRTIMER_RESTART;
 }
@@ -1102,13 +1352,10 @@ void hrtimer_interrupt(struct pt_regs *r
 
 	/* Store the regs for an possible sched_timer callback */
 	cpu_base->sched_regs = regs;
+	cpu_base->nr_events++;
 
  retry:
 	now = ktime_get();
-
-	/* Check, if the jiffies need an update */
-	update_jiffies64(now);
-
 	expires_next.tv64 = KTIME_MAX;
 
 	base = cpu_base->clock_base;
Index: linux-2.6.18-mm3/kernel/softirq.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/softirq.c	2006-10-04 18:13:55.000000000 +0200
+++ linux-2.6.18-mm3/kernel/softirq.c	2006-10-04 18:13:58.000000000 +0200
@@ -278,9 +278,11 @@ EXPORT_SYMBOL(do_softirq);
  */
 void irq_enter(void)
 {
-	account_system_vtime(current);
-	add_preempt_count(HARDIRQ_OFFSET);
-	trace_hardirq_enter();
+	__irq_enter();
+#ifdef CONFIG_NO_HZ
+	if (idle_cpu(smp_processor_id()))
+		hrtimer_update_jiffies();
+#endif
 }
 
 #ifdef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -299,6 +301,12 @@ void irq_exit(void)
 	sub_preempt_count(IRQ_EXIT_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
+
+#ifdef CONFIG_NO_HZ
+	/* Make sure that timer wheel updates are propagated */
+	if (!in_interrupt() && idle_cpu(smp_processor_id()) && !need_resched())
+		hrtimer_stop_sched_tick();
+#endif
 	preempt_enable_no_resched();
 }
 
Index: linux-2.6.18-mm3/kernel/time/Kconfig
===================================================================
--- linux-2.6.18-mm3.orig/kernel/time/Kconfig	2006-10-04 18:13:57.000000000 +0200
+++ linux-2.6.18-mm3/kernel/time/Kconfig	2006-10-04 18:13:58.000000000 +0200
@@ -9,3 +9,10 @@ config HIGH_RES_TIMERS
 	  hardware is not capable then this option only increases
 	  the size of the kernel image.
 
+config NO_HZ
+	bool "Tickless System (Dynamic Ticks)"
+	depends on GENERIC_TIME && HIGH_RES_TIMERS
+	help
+	  This option enables a tickless system: timer interrupts will
+	  only trigger on an as-needed basis both when the system is
+	  busy and when the system is idle.
Index: linux-2.6.18-mm3/kernel/timer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/timer.c	2006-10-04 18:13:57.000000000 +0200
+++ linux-2.6.18-mm3/kernel/timer.c	2006-10-04 18:13:58.000000000 +0200
@@ -462,7 +462,7 @@ static inline void __run_timers(tvec_bas
 	spin_unlock_irq(&base->lock);
 }
 
-#ifdef CONFIG_NO_IDLE_HZ
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
Index: linux-2.6.18-mm3/include/linux/hardirq.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hardirq.h	2006-10-04 18:13:55.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hardirq.h	2006-10-04 18:13:58.000000000 +0200
@@ -106,6 +106,16 @@ static inline void account_system_vtime(
  * always balanced, so the interrupted value of ->hardirq_context
  * will always be restored.
  */
+#define __irq_enter()					\
+	do {						\
+		account_system_vtime(current);		\
+		add_preempt_count(HARDIRQ_OFFSET);	\
+		trace_hardirq_enter();			\
+	} while (0)
+
+/*
+ * Enter irq context (on NO_HZ, update jiffies):
+ */
 extern void irq_enter(void);
 
 /*
@@ -123,7 +133,7 @@ extern void irq_enter(void);
  */
 extern void irq_exit(void);
 
-#define nmi_enter()		do { lockdep_off(); irq_enter(); } while (0)
+#define nmi_enter()		do { lockdep_off(); __irq_enter(); } while (0)
 #define nmi_exit()		do { __irq_exit(); lockdep_on(); } while (0)
 
 #endif /* LINUX_HARDIRQ_H */

--


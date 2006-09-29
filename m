Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422839AbWI3AI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbWI3AI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422850AbWI3AGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:45 -0400
Received: from www.osadl.org ([213.239.205.134]:26516 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422846AbWI3AEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:13 -0400
Message-Id: <20060929234440.636609000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:35 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 16/23] dynticks: core
Content-Disposition: inline; filename=hrtimer-no-idle-hz.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

dynticks core code.

Add idling-stats to the cpu base (to be used to optimize power
management decisions), add the scheduler tick and its stop/restart
functions, and the jiffies-update function to be called when an irq
context hits the idle context.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 include/linux/hrtimer.h |   28 +++++++
 kernel/hrtimer.c        |  185 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/softirq.c        |   11 ++
 kernel/time/Kconfig     |    8 ++
 kernel/timer.c          |    2 
 5 files changed, 226 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-09-30 01:41:18.000000000 +0200
@@ -142,6 +142,14 @@ struct hrtimer_cpu_base {
 	struct hrtimer			sched_timer;
 	struct pt_regs			*sched_regs;
 	unsigned long			events;
+#ifdef CONFIG_NO_HZ
+	ktime_t				idle_tick;
+	int				tick_stopped;
+	unsigned long			idle_jiffies;
+	unsigned long			idle_calls;
+	unsigned long			idle_sleeps;
+	unsigned long			idle_sleeptime;
+#endif
 #endif
 };
 
@@ -200,7 +208,7 @@ extern int hrtimer_try_to_cancel(struct 
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
 extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
 
-#ifdef CONFIG_NO_IDLE_HZ
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
 extern ktime_t hrtimer_get_next_event(void);
 #endif
 
@@ -229,6 +237,24 @@ extern void hrtimer_run_queues(void);
 /* Resume notification */
 void hrtimer_notify_resume(void);
 
+#ifdef CONFIG_NO_HZ
+extern void hrtimer_trigger_next_hz_tick(struct tvec_t_base_s *base);
+extern int hrtimer_stop_sched_tick(void);
+extern void hrtimer_restart_sched_tick(void);
+extern void update_jiffies(void);
+struct seq_file;
+extern void show_no_hz_stats(struct seq_file *p);
+#else
+# define hrtimer_trigger_next_hz_tick(base)	do { } while (0)
+static inline int hrtimer_stop_sched_tick(void)
+{
+	return 0;
+}
+# define hrtimer_restart_sched_tick()		do { } while (0)
+# define update_jiffies()			do { } while (0)
+# define show_no_hz_stats(p)			do { } while (0)
+#endif
+
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
 
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-09-30 01:41:18.000000000 +0200
@@ -437,7 +437,6 @@ static void update_jiffies64(ktime_t now
 
 	delta = ktime_sub(now, last_jiffies_update);
 	if (delta.tv64 >= nsec_per_hz.tv64) {
-
 		unsigned long orun = 1;
 
 		delta = ktime_sub(delta, nsec_per_hz);
@@ -451,7 +450,6 @@ static void update_jiffies64(ktime_t now
 
 			last_jiffies_update = ktime_add_ns(last_jiffies_update,
 							   incr * orun);
-			jiffies_64 += orun;
 			orun++;
 		}
 		do_timer(orun);
@@ -459,28 +457,201 @@ static void update_jiffies64(ktime_t now
 	write_sequnlock(&xtime_lock);
 }
 
+#ifdef CONFIG_NO_HZ
+/*
+ * Called from interrupt entry when then CPU was idle
+ */
+void update_jiffies(void)
+{
+	unsigned long flags;
+	ktime_t now;
+
+	if (unlikely(!hrtimer_hres_active))
+		return;
+
+	now = ktime_get();
+
+	local_irq_save(flags);
+	update_jiffies64(now);
+	local_irq_restore(flags);
+}
+
+/*
+ * Called from the idle thread so careful!
+ */
+int hrtimer_stop_sched_tick(void)
+{
+	int cpu = smp_processor_id();
+	struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
+	unsigned long seq, last_jiffies, next_jiffies;
+	ktime_t last_update, expires;
+	unsigned long delta_jiffies;
+	unsigned long flags;
+
+	if (unlikely(!hrtimer_hres_active))
+		return 0;
+
+	local_irq_save(flags);
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		last_update = last_jiffies_update;
+		last_jiffies = jiffies;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	next_jiffies = get_next_timer_interrupt(last_jiffies);
+	delta_jiffies = next_jiffies - last_jiffies;
+
+	cpu_base->idle_calls++;
+
+	if ((long)delta_jiffies >= 1) {
+		/*
+		 * Save the current tick time, so we can restart the
+		 * scheduler tick when we get woken up before the next
+		 * wheel timer expires
+		 */
+		cpu_base->idle_tick = cpu_base->sched_timer.expires;
+		expires = ktime_add_ns(last_update,
+				       nsec_per_hz.tv64 * delta_jiffies);
+		hrtimer_start(&cpu_base->sched_timer, expires, HRTIMER_ABS);
+		cpu_base->idle_sleeps++;
+		cpu_base->idle_jiffies = last_jiffies;
+		cpu_base->tick_stopped = 1;
+	} else {
+		/* Keep the timer alive */
+		if ((long) delta_jiffies < 0)
+			raise_softirq(TIMER_SOFTIRQ);
+	}
+
+	if (local_softirq_pending()) {
+		inc_preempt_count();
+		do_softirq();
+		dec_preempt_count();
+	}
+
+	WARN_ON(!idle_cpu(cpu));
+	/*
+	 * RCU normally depends on the timer IRQ kicking completion
+	 * in every tick. We have to do this here now:
+	 */
+	if (rcu_pending(cpu)) {
+		/*
+		 * We are in quiescent state, so advance callbacks:
+		 */
+		rcu_advance_callbacks(cpu, 1);
+		local_irq_enable();
+		local_bh_disable();
+		rcu_process_callbacks(0);
+		local_bh_enable();
+	}
+
+	local_irq_restore(flags);
+
+	return need_resched();
+}
+
+void hrtimer_restart_sched_tick(void)
+{
+	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
+	unsigned long flags;
+	ktime_t now;
+
+	if (!hrtimer_hres_active || !cpu_base->tick_stopped)
+		return;
+
+	/* Update jiffies first */
+	now = ktime_get();
+
+	local_irq_save(flags);
+	update_jiffies64(now);
+
+	/*
+	 * Update process times would randomly account the time we slept to
+	 * whatever the context of the next sched tick is.  Enforce that this
+	 * is accounted to idle !
+	 */
+	add_preempt_count(HARDIRQ_OFFSET);
+	update_process_times(0);
+	sub_preempt_count(HARDIRQ_OFFSET);
+
+	cpu_base->idle_sleeptime += jiffies - cpu_base->idle_jiffies;
+
+	cpu_base->tick_stopped  = 0;
+	hrtimer_cancel(&cpu_base->sched_timer);
+	cpu_base->sched_timer.expires = cpu_base->idle_tick;
+
+	while (1) {
+		hrtimer_forward(&cpu_base->sched_timer, now, nsec_per_hz);
+		hrtimer_start(&cpu_base->sched_timer,
+			      cpu_base->sched_timer.expires, HRTIMER_ABS);
+		if (hrtimer_active(&cpu_base->sched_timer))
+			break;
+		/* We missed an update */
+		update_jiffies64(now);
+		now = ktime_get();
+	}
+	local_irq_restore(flags);
+}
+
+void show_no_hz_stats(struct seq_file *p)
+{
+	int cpu;
+	unsigned long calls = 0, sleeps = 0, time = 0, events = 0;
+
+	for_each_online_cpu(cpu) {
+		struct hrtimer_cpu_base *base = &per_cpu(hrtimer_bases, cpu);
+
+		calls += base->idle_calls;
+		sleeps += base->idle_sleeps;
+		time += base->idle_sleeptime;
+		events += base->events;
+
+		seq_printf(p, "nohz cpu%d I:%lu S:%lu T:%lu A:%lu E: %lu\n",
+			   cpu, base->idle_calls, base->idle_sleeps,
+			   base->idle_sleeptime, base->idle_sleeps ?
+			   base->idle_sleeptime / sleeps : 0, base->events);
+	}
+#ifdef CONFIG_SMP
+	seq_printf(p, "nohz total I:%lu S:%lu T:%lu A:%lu E:%lu\n",
+		   calls, sleeps, time, sleeps ? time / sleeps : 0, events);
+#endif
+}
+
+#endif
+
+
 /*
  * We rearm the timer until we get disabled by the idle code
+ * Called with interrupts disabled.
  */
 static int hrtimer_sched_tick(struct hrtimer *timer)
 {
-	unsigned long flags;
 	struct hrtimer_cpu_base *cpu_base =
 		container_of(timer, struct hrtimer_cpu_base, sched_timer);
 
-	local_irq_save(flags);
 	/*
 	 * Do not call, when we are not in irq context and have
 	 * no valid regs pointer
 	 */
 	if (cpu_base->sched_regs) {
+		/*
+		 * update_process_times() might take tasklist_lock, hence
+		 * drop the base lock. sched-tick hrtimers are per-CPU and
+		 * never accessible by userspace APIs, so this is safe to do.
+		 */
+		spin_unlock(&cpu_base->lock);
 		update_process_times(user_mode(cpu_base->sched_regs));
 		profile_tick(CPU_PROFILING, cpu_base->sched_regs);
+		spin_lock(&cpu_base->lock);
 	}
 
 	hrtimer_forward(timer, hrtimer_cb_get_time(timer), nsec_per_hz);
-	local_irq_restore(flags);
 
+#ifdef CONFIG_NO_HZ
+	/* Do not restart, when we are in the idle loop */
+	if (cpu_base->tick_stopped)
+		return HRTIMER_NORESTART;
+#endif
 	return HRTIMER_RESTART;
 }
 
@@ -908,7 +1079,7 @@ ktime_t hrtimer_get_remaining(const stru
 }
 EXPORT_SYMBOL_GPL(hrtimer_get_remaining);
 
-#ifdef CONFIG_NO_IDLE_HZ
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
 /**
  * hrtimer_get_next_event - get the time until next expiry event
  *
@@ -923,12 +1094,14 @@ ktime_t hrtimer_get_next_event(void)
 	unsigned long flags;
 	int i;
 
+#ifndef CONFIG_NO_HZ
 	/*
 	 * In high-res mode we dont need to get the next high-res
 	 * event on a tickless system:
 	 */
 	if (hrtimer_hres_active)
 		return mindelta;
+#endif
 
 	spin_lock_irqsave(&cpu_base->lock, flags);
 
Index: linux-2.6.18-mm2/kernel/softirq.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/softirq.c	2006-09-30 01:41:16.000000000 +0200
+++ linux-2.6.18-mm2/kernel/softirq.c	2006-09-30 01:41:18.000000000 +0200
@@ -284,6 +284,11 @@ extern void irq_enter(void)
 	account_system_vtime(current);
 	add_preempt_count(HARDIRQ_OFFSET);
 	trace_hardirq_enter();
+
+#ifdef CONFIG_NO_HZ
+	if (idle_cpu(smp_processor_id()))
+		update_jiffies();
+#endif
 }
 
 /*
@@ -296,6 +301,12 @@ void irq_exit(void)
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
 
Index: linux-2.6.18-mm2/kernel/time/Kconfig
===================================================================
--- linux-2.6.18-mm2.orig/kernel/time/Kconfig	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/kernel/time/Kconfig	2006-09-30 01:41:18.000000000 +0200
@@ -20,3 +20,11 @@ config HIGH_RES_RESOLUTION
           800 MHz processor about 10,000 (10 microseconds) is recommended as a
 	  finest resolution.  If you don't need that sort of resolution,
 	  larger values may generate less overhead.
+
+config NO_HZ
+	bool "Tickless System (Dynamic Ticks)"
+	depends on GENERIC_TIME && HIGH_RES_TIMERS
+	help
+	  This option enables a tickless system: timer interrupts will
+	  only trigger on an as-needed basis both when the system is
+	  busy and when the system is idle.
Index: linux-2.6.18-mm2/kernel/timer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/timer.c	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/kernel/timer.c	2006-09-30 01:41:18.000000000 +0200
@@ -462,7 +462,7 @@ static inline void __run_timers(tvec_bas
 	spin_unlock_irq(&base->lock);
 }
 
-#ifdef CONFIG_NO_IDLE_HZ
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWI3AI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWI3AI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbWI3AGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:55 -0400
Received: from www.osadl.org ([213.239.205.134]:21140 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422829AbWI3AEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:10 -0400
Message-Id: <20060929234440.290256000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:32 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 13/23] clockevents: core
Content-Disposition: inline; filename=clockevents-base.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

We have two types of clock event devices:
- global events (one device per system)
- local events (one device per cpu)

We assign the various time(r) related interrupts to those devices:

- global tick
- profiling (per cpu)
- next timer events (per cpu)

architectures register their clockevent sources, with specific capability
masks set, and the generic high-res-timers code picks the best one,
without the architecture having to worry about that.

here are the capabilities a clockevent driver can register:

 #define CLOCK_CAP_TICK		0x000001
 #define CLOCK_CAP_UPDATE	0x000002
 #define CLOCK_CAP_PROFILE	0x000004
 #define CLOCK_CAP_NEXTEVT	0x000008

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/clockchips.h |  104 ++++++++
 include/linux/hrtimer.h    |    3 
 init/main.c                |    2 
 kernel/hrtimer.c           |    6 
 kernel/time/Makefile       |    2 
 kernel/time/clockevents.c  |  527 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 642 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/include/linux/clockchips.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm2/include/linux/clockchips.h	2006-09-30 01:41:17.000000000 +0200
@@ -0,0 +1,104 @@
+/*  linux/include/linux/clockchips.h
+ *
+ *  This file contains the structure definitions for clockchips.
+ *
+ *  If you are not a clockchip, or the time of day code, you should
+ *  not be including this file!
+ */
+#ifndef _LINUX_CLOCKCHIPS_H
+#define _LINUX_CLOCKCHIPS_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_GENERIC_TIME
+
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+
+/* Clock event mode commands */
+enum {
+	CLOCK_EVT_PERIODIC,
+	CLOCK_EVT_ONESHOT,
+	CLOCK_EVT_SHUTDOWN,
+};
+
+/* Clock event capability flags */
+#define CLOCK_CAP_TICK		0x000001
+#define CLOCK_CAP_UPDATE	0x000002
+#ifndef CONFIG_PROFILE_NMI
+# define CLOCK_CAP_PROFILE	0x000004
+#else
+# define CLOCK_CAP_PROFILE	0x000000
+#endif
+#ifdef CONFIG_HIGH_RES_TIMERS
+# define CLOCK_CAP_NEXTEVT	0x000008
+#else
+# define CLOCK_CAP_NEXTEVT	0x000000
+#endif
+
+#define CLOCK_BASE_CAPS_MASK	(CLOCK_CAP_TICK | CLOCK_CAP_PROFILE | \
+				 CLOCK_CAP_UPDATE)
+#define CLOCK_CAPS_MASK		(CLOCK_BASE_CAPS_MASK | CLOCK_CAP_NEXTEVT)
+
+struct clock_event;
+
+/**
+ * struct clock_event - clock event descriptor
+ *
+ * @name:		ptr to clock event name
+ * @capabilities:	capabilities of the event chip
+ * @max_delta_ns:	maximum delta value in ns
+ * @min_delta_ns:	minimum delta value in ns
+ * @mult:		nanosecond to cycles multiplier
+ * @shift:		nanoseconds to cycles divisor (power of two)
+ * @set_next_event:	set next event
+ * @set_mode:		set mode function
+ * @suspend:		suspend function (optional)
+ * @resume:		resume function (optional)
+ * @evthandler:		Assigned by the framework to be called by the low
+ *			level handler of the event source
+ */
+struct clock_event {
+	const char	*name;
+	unsigned int	capabilities;
+	unsigned long	max_delta_ns;
+	unsigned long	min_delta_ns;
+	unsigned long	mult;
+	int		shift;
+	void		(*set_next_event)(unsigned long evt,
+					  struct clock_event *);
+	void		(*set_mode)(int mode, struct clock_event *);
+	int		(*suspend)(struct clock_event *);
+	int		(*resume)(struct clock_event *);
+	void		(*event_handler)(struct pt_regs *regs);
+};
+
+/*
+ * Calculate a multiplication factor
+ */
+static inline unsigned long div_sc(unsigned long a, unsigned long b,
+				   int shift)
+{
+	uint64_t tmp = ((uint64_t)a) << shift;
+	do_div(tmp, b);
+	return (unsigned long) tmp;
+}
+
+/* Clock event layer functions */
+extern int register_local_clockevent(struct clock_event *);
+extern int register_global_clockevent(struct clock_event *);
+extern unsigned long clockevent_delta2ns(unsigned long latch,
+					 struct clock_event *evt);
+extern void clockevents_init(void);
+
+extern int clockevents_init_next_event(void);
+extern int clockevents_set_next_event(ktime_t expires, int force);
+extern int clockevents_next_event_available(void);
+extern void clockevents_resume_events(void);
+
+#else
+# define clockevents_init()		do { } while(0)
+# define clockevents_resume_events()	do { } while(0)
+#endif
+
+#endif
Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-09-30 01:41:17.000000000 +0200
@@ -116,6 +116,9 @@ struct hrtimer_cpu_base {
  * is expired in the next softirq when the clock was advanced.
  */
 #define clock_was_set()		do { } while (0)
+#define hrtimer_clock_notify()	do { } while (0)
+extern ktime_t ktime_get(void);
+extern ktime_t ktime_get_real(void);
 
 /* Exported timer functions: */
 
Index: linux-2.6.18-mm2/init/main.c
===================================================================
--- linux-2.6.18-mm2.orig/init/main.c	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/init/main.c	2006-09-30 01:41:17.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kallsyms.h>
 #include <linux/writeback.h>
+#include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/efi.h>
@@ -529,6 +530,7 @@ asmlinkage void __init start_kernel(void
 	rcu_init();
 	init_IRQ();
 	pidhash_init();
+	clockevents_init();
 	init_timers();
 	hrtimers_init();
 	softirq_init();
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-09-30 01:41:17.000000000 +0200
@@ -30,6 +30,7 @@
  *  For licencing details see kernel-base/COPYING
  */
 
+#include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
@@ -45,7 +46,7 @@
  *
  * returns the time in ktime_t format
  */
-static ktime_t ktime_get(void)
+ktime_t ktime_get(void)
 {
 	struct timespec now;
 
@@ -59,7 +60,7 @@ static ktime_t ktime_get(void)
  *
  * returns the time in ktime_t format
  */
-static ktime_t ktime_get_real(void)
+ktime_t ktime_get_real(void)
 {
 	struct timespec now;
 
@@ -292,6 +293,7 @@ static unsigned long ktime_divns(const k
  */
 void hrtimer_notify_resume(void)
 {
+	clockevents_resume_events();
 	clock_was_set();
 }
 
Index: linux-2.6.18-mm2/kernel/time/Makefile
===================================================================
--- linux-2.6.18-mm2.orig/kernel/time/Makefile	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/kernel/time/Makefile	2006-09-30 01:41:17.000000000 +0200
@@ -1 +1,3 @@
 obj-y += ntp.o clocksource.o jiffies.o
+
+obj-$(CONFIG_GENERIC_TIME) += clockevents.o
Index: linux-2.6.18-mm2/kernel/time/clockevents.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm2/kernel/time/clockevents.c	2006-09-30 01:41:17.000000000 +0200
@@ -0,0 +1,527 @@
+/*
+ * linux/kernel/time/clockevents.c
+ *
+ * This file contains functions which manage clock event drivers.
+ *
+ * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
+ * Copyright(C) 2005-2006, Red Hat, Inc., Ingo Molnar
+ *
+ * We have two types of clock event devices:
+ * - global events (one device per system)
+ * - local events (one device per cpu)
+ *
+ * We assign the various time(r) related interrupts to those devices
+ *
+ * - global tick
+ * - profiling (per cpu)
+ * - next timer events (per cpu)
+ *
+ * TODO:
+ * - implement variable frequency profiling
+ *
+ * This code is licenced under the GPL version 2. For details see
+ * kernel-base/COPYING.
+ */
+
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/profile.h>
+#include <linux/sysdev.h>
+#include <linux/hrtimer.h>
+
+#define MAX_CLOCK_EVENTS	4
+#define GLOBAL_CLOCK_EVENT	MAX_CLOCK_EVENTS
+
+struct event_descr {
+	struct clock_event *event;
+	unsigned int mode;
+	unsigned int real_caps;
+	struct irqaction action;
+};
+
+struct local_events {
+	int installed;
+	struct event_descr events[MAX_CLOCK_EVENTS];
+	struct clock_event *nextevt;
+};
+
+/* Variables related to the global event source */
+static __read_mostly struct event_descr global_eventsource;
+
+/* Variables related to the per cpu local event sources */
+static DEFINE_PER_CPU(struct local_events, local_eventsources);
+
+/* lock to protect the above */
+static DEFINE_SPINLOCK(events_lock);
+
+/*
+ * Math helper. Convert a latch value to ns
+ */
+unsigned long clockevent_delta2ns(unsigned long latch, struct clock_event *evt)
+{
+	u64 clc = ((u64) latch << evt->shift);
+
+	do_div(clc, evt->mult);
+	if (clc < KTIME_MONOTONIC_RES.tv64)
+		clc = KTIME_MONOTONIC_RES.tv64;
+	if (clc > LONG_MAX)
+		clc = LONG_MAX;
+
+	return (unsigned long) clc;
+}
+
+/*
+ * Bootup and lowres handler: ticks only
+ */
+static void handle_tick(struct pt_regs *regs)
+{
+	write_seqlock(&xtime_lock);
+	do_timer(1);
+	write_sequnlock(&xtime_lock);
+}
+
+/*
+ * Bootup and lowres handler: ticks and update_process_times
+ */
+static void handle_tick_update(struct pt_regs *regs)
+{
+	write_seqlock(&xtime_lock);
+	do_timer(1);
+	write_sequnlock(&xtime_lock);
+
+	update_process_times(user_mode(regs));
+}
+
+/*
+ * Bootup and lowres handler: ticks and profileing
+ */
+static void handle_tick_profile(struct pt_regs *regs)
+{
+	write_seqlock(&xtime_lock);
+	do_timer(1);
+	write_sequnlock(&xtime_lock);
+
+	profile_tick(CPU_PROFILING, regs);
+}
+
+/*
+ * Bootup and lowres handler: ticks, update_process_times and profiling
+ */
+static void handle_tick_update_profile(struct pt_regs *regs)
+{
+	write_seqlock(&xtime_lock);
+	do_timer(1);
+	write_sequnlock(&xtime_lock);
+
+	update_process_times(user_mode(regs));
+	profile_tick(CPU_PROFILING, regs);
+}
+
+/*
+ * Bootup and lowres handler: update_process_times
+ */
+static void handle_update(struct pt_regs *regs)
+{
+	update_process_times(user_mode(regs));
+}
+
+/*
+ * Bootup and lowres handler: update_process_times and profiling
+ */
+static void handle_update_profile(struct pt_regs *regs)
+{
+	update_process_times(user_mode(regs));
+	profile_tick(CPU_PROFILING, regs);
+}
+
+/*
+ * Bootup and lowres handler: profiling
+ */
+static void handle_profile(struct pt_regs *regs)
+{
+	profile_tick(CPU_PROFILING, regs);
+}
+
+/*
+ * Noop handler when we shut down an event source
+ */
+static void handle_noop(struct pt_regs *regs)
+{
+}
+
+/*
+ * Lookup table for bootup and lowres event assignment
+ */
+static void __read_mostly *event_handlers[] = {
+	handle_noop,			/* 0: No capability selected */
+	handle_tick,			/* 1: Tick only	*/
+	handle_update,			/* 2: Update process times */
+	handle_tick_update,		/* 3: Tick + update process times */
+	handle_profile,			/* 4: Profiling int */
+	handle_tick_profile,		/* 5: Tick + Profiling int */
+	handle_update_profile,		/* 6: Update process times +
+					      profiling */
+	handle_tick_update_profile,	/* 7: Tick + update process times +
+					      profiling */
+#ifdef CONFIG_HIGH_RES_TIMERS
+	hrtimer_interrupt,		/* 8: Reprogrammable event source */
+#endif
+};
+
+/*
+ * Start up an event source
+ */
+static void startup_event(struct clock_event *evt, unsigned int caps)
+{
+	int mode;
+
+	if (caps == CLOCK_CAP_NEXTEVT)
+		mode = CLOCK_EVT_ONESHOT;
+	else
+		mode = CLOCK_EVT_PERIODIC;
+
+	evt->set_mode(mode, evt);
+}
+
+/*
+ * Setup an event source. Assign an handler and start it up
+ * When the event source has no own interrupt handler we setup
+ * the interrupt too.
+ */
+static void setup_event(struct event_descr *descr, struct clock_event *evt,
+			unsigned int caps)
+{
+	void *handler = event_handlers[caps];
+
+	/* Set the event handler */
+	evt->event_handler = handler;
+
+	/* Store all relevant information */
+	descr->real_caps = caps;
+
+	startup_event(evt, caps);
+
+	printk(KERN_INFO "Event source %s configured with caps set: "
+	       "%02x\n", evt->name, descr->real_caps);
+}
+
+/**
+ * register_global_clockevent - register the device which generates
+ *			     global clock events
+ *
+ * @evt:	The device which generates global clock events (ticks)
+ *
+ * This can be a device which is only necessary for bootup. On UP systems this
+ * might be the only event source which is used for everything including
+ * high resolution events.
+ *
+ * When a cpu local event source is installed the global event source is
+ * switched off in the high resolution timer / tickless mode.
+ */
+int __init register_global_clockevent(struct clock_event *evt)
+{
+	/* Already installed? */
+	if (global_eventsource.event) {
+		printk(KERN_ERR "Global clock event source already installed: "
+		       "%s. Ignoring new global eventsoruce %s\n",
+		       global_eventsource.event->name,
+		       evt->name);
+		return -EBUSY;
+	}
+
+	/* Preset the handler in any case */
+	evt->event_handler = handle_noop;
+
+	/*
+	 * Check, whether it is a valid global event source
+	 */
+	if (!(evt->capabilities & CLOCK_BASE_CAPS_MASK)) {
+		printk(KERN_ERR "Unsupported event source %s\n", evt->name);
+		return -EINVAL;
+	}
+
+	/* Mask out high resolution capabilities for now */
+	global_eventsource.event = evt;
+	setup_event(&global_eventsource, evt,
+		    evt->capabilities & CLOCK_BASE_CAPS_MASK);
+	return 0;
+}
+
+/*
+ * Mask out the functionality which is covered by the new event source
+ * and assign a new event handler.
+ */
+static void recalc_active_event(struct event_descr *descr,
+				unsigned int newcaps)
+{
+	unsigned int caps;
+
+	if (!descr->real_caps)
+		return;
+
+	/* Mask the overlapping bits */
+	caps = descr->real_caps & ~newcaps;
+
+	/* Assign the new event handler */
+	if (caps) {
+		descr->event->event_handler = event_handlers[caps];
+		printk(KERN_INFO "Event source %s new caps set: %02x\n" ,
+		       descr->event->name, caps);
+	} else {
+		descr->event->event_handler = handle_noop;
+
+		if (descr->event->set_mode)
+			descr->event->set_mode(CLOCK_EVT_SHUTDOWN,
+					       descr->event);
+
+		printk(KERN_INFO "Event source %s disabled\n" ,
+		       descr->event->name);
+	}
+	descr->real_caps = caps;
+}
+
+/*
+ * Recalc the events and reassign the handlers if necessary
+ */
+static int recalc_events(struct local_events *sources, struct clock_event *evt,
+			 unsigned int caps, int new)
+{
+	int i;
+
+	if (new && sources->installed == MAX_CLOCK_EVENTS)
+		return -ENOSPC;
+
+	/*
+	 * If there is no handler and this is not a next-event capable
+	 * event source, refuse to handle it
+	 */
+	if (!evt->capabilities & CLOCK_CAP_NEXTEVT && !event_handlers[caps]) {
+		printk(KERN_ERR "Unsupported event source %s\n", evt->name);
+		return -EINVAL;
+	}
+
+	if (caps && global_eventsource.event && global_eventsource.event != evt)
+		recalc_active_event(&global_eventsource, caps);
+
+	for (i = 0; i < sources->installed; i++) {
+		if (sources->events[i].event != evt)
+			recalc_active_event(&sources->events[i], caps);
+	}
+
+	if (new)
+		sources->events[sources->installed++].event = evt;
+
+	if (caps) {
+		/* Is next_event event source going to be installed? */
+		if (caps & CLOCK_CAP_NEXTEVT)
+			caps = CLOCK_CAP_NEXTEVT;
+
+		setup_event(&sources->events[sources->installed],
+			    evt, caps);
+	} else
+		printk(KERN_INFO "Inactive event source %s registered\n",
+		       evt->name);
+
+	return 0;
+}
+
+/**
+ * register_local_clockevent - Set up a cpu local clock event device
+ *
+ * @evt:	event device to be registered
+ */
+int register_local_clockevent(struct clock_event *evt)
+{
+	struct local_events *sources = &__get_cpu_var(local_eventsources);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&events_lock, flags);
+
+	/* Preset the handler in any case */
+	evt->event_handler = handle_noop;
+
+	/* Recalc event sources and maybe reassign handlers */
+	ret = recalc_events(sources, evt,
+			    evt->capabilities & CLOCK_BASE_CAPS_MASK, 1);
+
+	spin_unlock_irqrestore(&events_lock, flags);
+
+	/*
+	 * Trigger hrtimers, when the event source is next-event
+	 * capable
+	 */
+	if (!ret && (evt->capabilities & CLOCK_CAP_NEXTEVT))
+		hrtimer_clock_notify();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_local_clockevent);
+
+/*
+ * Find a next-event capable event source
+ */
+static int get_next_event_source(void)
+{
+	struct local_events *sources = &__get_cpu_var(local_eventsources);
+	int i;
+
+	for (i = 0; i < sources->installed; i++) {
+		struct clock_event *evt;
+
+		evt = sources->events[i].event;
+		if (evt->capabilities & CLOCK_CAP_NEXTEVT)
+			return i;
+	}
+
+#ifndef CONFIG_SMP
+	if (global_eventsource.event->capabilities & CLOCK_CAP_NEXTEVT)
+		return GLOBAL_CLOCK_EVENT;
+#endif
+	return -ENODEV;
+}
+
+/**
+ * clockevents_next_event_available - Check for a installed next-event source
+ */
+int clockevents_next_event_available(void)
+{
+	unsigned long flags;
+	int idx;
+
+	spin_lock_irqsave(&events_lock, flags);
+	idx = get_next_event_source();
+	spin_unlock_irqrestore(&events_lock, flags);
+
+	return idx < 0 ? 0 : 1;
+}
+
+int clockevents_init_next_event(void)
+{
+	struct local_events *sources = &__get_cpu_var(local_eventsources);
+	struct clock_event *nextevt;
+	unsigned long flags;
+	int idx, ret = -ENODEV;
+
+	if (sources->nextevt)
+		return -EBUSY;
+
+	spin_lock_irqsave(&events_lock, flags);
+
+	idx = get_next_event_source();
+	if (idx < 0)
+		goto out_unlock;
+
+	if (idx == GLOBAL_CLOCK_EVENT)
+		nextevt = global_eventsource.event;
+	else
+		nextevt = sources->events[idx].event;
+
+	ret = recalc_events(sources, nextevt, CLOCK_CAPS_MASK, 0);
+	if (!ret)
+		sources->nextevt = nextevt;
+ out_unlock:
+	spin_unlock_irqrestore(&events_lock, flags);
+
+	return ret;
+}
+
+int clockevents_set_next_event(ktime_t expires, int force)
+{
+	struct local_events *sources = &__get_cpu_var(local_eventsources);
+	int64_t delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
+	struct clock_event *nextevt = sources->nextevt;
+	unsigned long long clc;
+
+	if (delta <= 0 && !force)
+		return -ETIME;
+
+	if (delta > nextevt->max_delta_ns)
+		delta = nextevt->max_delta_ns;
+	if (delta < nextevt->min_delta_ns)
+		delta = nextevt->min_delta_ns;
+
+	clc = delta * nextevt->mult;
+	clc >>= nextevt->shift;
+	nextevt->set_next_event((unsigned long)clc, sources->nextevt);
+
+	return 0;
+}
+
+/*
+ * Resume the cpu local clock events
+ */
+static void clockevents_resume_local_events(void *arg)
+{
+	struct local_events *sources = &__get_cpu_var(local_eventsources);
+	int i;
+
+	for (i = 0; i < sources->installed; i++) {
+		if (sources->events[i].real_caps)
+			startup_event(sources->events[i].event,
+				      sources->events[i].real_caps);
+	}
+}
+
+/*
+ * Called after timekeeping is functional again
+ */
+void clockevents_resume_events(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* Resume global event source */
+	if (global_eventsource.real_caps)
+		startup_event(global_eventsource.event,
+			      global_eventsource.real_caps);
+
+	clockevents_resume_local_events(NULL);
+	local_irq_restore(flags);
+
+	touch_softlockup_watchdog();
+
+	if (smp_call_function(clockevents_resume_local_events, NULL, 1, 1))
+		BUG();
+
+}
+
+/*
+ * Functions related to initialization and hotplug
+ */
+static int clockevents_cpu_notify(struct notifier_block *self,
+				  unsigned long action, void *hcpu)
+{
+	switch(action) {
+	case CPU_UP_PREPARE:
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		/*
+		 * Do something sensible here !
+		 * Disable the cpu local clocksources
+		 */
+		break;
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata clockevents_nb = {
+	.notifier_call	= clockevents_cpu_notify,
+};
+
+void __init clockevents_init(void)
+{
+	clockevents_cpu_notify(&clockevents_nb, (unsigned long)CPU_UP_PREPARE,
+				(void *)(long)smp_processor_id());
+	register_cpu_notifier(&clockevents_nb);
+}

--


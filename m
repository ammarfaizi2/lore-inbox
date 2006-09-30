Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWI3Ikn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWI3Ikn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWI3Ikm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:40:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbWI3Ikb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:40:31 -0400
Date: Sat, 30 Sep 2006 01:39:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 13/23] clockevents: core
Message-Id: <20060930013958.a350b7a1.akpm@osdl.org>
In-Reply-To: <20060929234440.290256000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234440.290256000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:32 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> We have two types of clock event devices:
> - global events (one device per system)
> - local events (one device per cpu)
> 
> We assign the various time(r) related interrupts to those devices:
> 
> - global tick
> - profiling (per cpu)
> - next timer events (per cpu)
> 
> architectures register their clockevent sources, with specific capability
> masks set, and the generic high-res-timers code picks the best one,
> without the architecture having to worry about that.
> 
> here are the capabilities a clockevent driver can register:
> 
>  #define CLOCK_CAP_TICK		0x000001
>  #define CLOCK_CAP_UPDATE	0x000002
>  #define CLOCK_CAP_PROFILE	0x000004
>  #define CLOCK_CAP_NEXTEVT	0x000008

OK..  Perhaps this info is worth promoting to a code comment.

> +++ linux-2.6.18-mm2/include/linux/clockchips.h	2006-09-30 01:41:17.000000000 +0200
> @@ -0,0 +1,104 @@
> +/*  linux/include/linux/clockchips.h
> + *
> + *  This file contains the structure definitions for clockchips.
> + *
> + *  If you are not a clockchip, or the time of day code, you should
> + *  not be including this file!
> + */
> +#ifndef _LINUX_CLOCKCHIPS_H
> +#define _LINUX_CLOCKCHIPS_H
> +
> +#include <linux/config.h>

The build system includes config.h for you.

> +#ifdef CONFIG_GENERIC_TIME
> +
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +
> +/* Clock event mode commands */
> +enum {
> +	CLOCK_EVT_PERIODIC,
> +	CLOCK_EVT_ONESHOT,
> +	CLOCK_EVT_SHUTDOWN,
> +};
> +
> +/* Clock event capability flags */
> +#define CLOCK_CAP_TICK		0x000001
> +#define CLOCK_CAP_UPDATE	0x000002
> +#ifndef CONFIG_PROFILE_NMI
> +# define CLOCK_CAP_PROFILE	0x000004
> +#else
> +# define CLOCK_CAP_PROFILE	0x000000
> +#endif
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +# define CLOCK_CAP_NEXTEVT	0x000008
> +#else
> +# define CLOCK_CAP_NEXTEVT	0x000000
> +#endif

There is no CONFIG_PROFILE_NMI in the kernel nor anywhere else in this
patchset.

> +#define CLOCK_BASE_CAPS_MASK	(CLOCK_CAP_TICK | CLOCK_CAP_PROFILE | \
> +				 CLOCK_CAP_UPDATE)
> +#define CLOCK_CAPS_MASK		(CLOCK_BASE_CAPS_MASK | CLOCK_CAP_NEXTEVT)
> +
> +struct clock_event;
> +
> +/**
> + * struct clock_event - clock event descriptor
> + *
> + * @name:		ptr to clock event name
> + * @capabilities:	capabilities of the event chip
> + * @max_delta_ns:	maximum delta value in ns
> + * @min_delta_ns:	minimum delta value in ns
> + * @mult:		nanosecond to cycles multiplier
> + * @shift:		nanoseconds to cycles divisor (power of two)
> + * @set_next_event:	set next event
> + * @set_mode:		set mode function
> + * @suspend:		suspend function (optional)
> + * @resume:		resume function (optional)
> + * @evthandler:		Assigned by the framework to be called by the low
> + *			level handler of the event source
> + */
> +struct clock_event {
> +	const char	*name;
> +	unsigned int	capabilities;
> +	unsigned long	max_delta_ns;
> +	unsigned long	min_delta_ns;
> +	unsigned long	mult;
> +	int		shift;
> +	void		(*set_next_event)(unsigned long evt,
> +					  struct clock_event *);
> +	void		(*set_mode)(int mode, struct clock_event *);
> +	int		(*suspend)(struct clock_event *);
> +	int		(*resume)(struct clock_event *);
> +	void		(*event_handler)(struct pt_regs *regs);
> +};

hm.  The term "clock_event" implies "something which happens": ie, an
event.

But a `struct clock_event' is, what?  Actually a source of events?

Is this a well-chosen name?

> +/*
> + * Calculate a multiplication factor
> + */
> +static inline unsigned long div_sc(unsigned long a, unsigned long b,
> +				   int shift)
> +{
> +	uint64_t tmp = ((uint64_t)a) << shift;
> +	do_div(tmp, b);
> +	return (unsigned long) tmp;
> +}

What does "div_sc" stand for??

> Index: linux-2.6.18-mm2/kernel/time/Makefile
> ===================================================================
> --- linux-2.6.18-mm2.orig/kernel/time/Makefile	2006-09-30 01:41:11.000000000 +0200
> +++ linux-2.6.18-mm2/kernel/time/Makefile	2006-09-30 01:41:17.000000000 +0200
> @@ -1 +1,3 @@
>  obj-y += ntp.o clocksource.o jiffies.o
> +
> +obj-$(CONFIG_GENERIC_TIME) += clockevents.o
> Index: linux-2.6.18-mm2/kernel/time/clockevents.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18-mm2/kernel/time/clockevents.c	2006-09-30 01:41:17.000000000 +0200
> @@ -0,0 +1,527 @@
> +/*
> + * linux/kernel/time/clockevents.c
> + *
> + * This file contains functions which manage clock event drivers.
> + *
> + * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
> + * Copyright(C) 2005-2006, Red Hat, Inc., Ingo Molnar
> + *
> + * We have two types of clock event devices:
> + * - global events (one device per system)
> + * - local events (one device per cpu)

So perhaps s/clock_event/clock_event_driver/.

Or clock_event_device?

> + * We assign the various time(r) related interrupts to those devices
> + *
> + * - global tick
> + * - profiling (per cpu)
> + * - next timer events (per cpu)
> + *
> + * TODO:
> + * - implement variable frequency profiling
> + *
> + * This code is licenced under the GPL version 2. For details see
> + * kernel-base/COPYING.
> + */
> +
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/notifier.h>
> +#include <linux/module.h>
> +#include <linux/percpu.h>
> +#include <linux/profile.h>
> +#include <linux/sysdev.h>
> +#include <linux/hrtimer.h>
> +
> +#define MAX_CLOCK_EVENTS	4
> +#define GLOBAL_CLOCK_EVENT	MAX_CLOCK_EVENTS
> +
> +struct event_descr {
> +	struct clock_event *event;
> +	unsigned int mode;
> +	unsigned int real_caps;
> +	struct irqaction action;
> +};
> +
> +struct local_events {
> +	int installed;
> +	struct event_descr events[MAX_CLOCK_EVENTS];
> +	struct clock_event *nextevt;
> +};
> +
> +/* Variables related to the global event source */
> +static __read_mostly struct event_descr global_eventsource;
> +
> +/* Variables related to the per cpu local event sources */
> +static DEFINE_PER_CPU(struct local_events, local_eventsources);
> +
> +/* lock to protect the above */
> +static DEFINE_SPINLOCK(events_lock);

Does "the above" really refer to cpu-local storage?

> +/*
> + * Recalc the events and reassign the handlers if necessary
> + */
> +static int recalc_events(struct local_events *sources, struct clock_event *evt,
> +			 unsigned int caps, int new)

It's good to document the caller-provided environmental requirements.  I
see from the callers that this requires spin_lock_irq(&events_lock).

> +{
> +	int i;
> +
> +	if (new && sources->installed == MAX_CLOCK_EVENTS)
> +		return -ENOSPC;
> +
> +	/*
> +	 * If there is no handler and this is not a next-event capable
> +	 * event source, refuse to handle it
> +	 */
> +	if (!evt->capabilities & CLOCK_CAP_NEXTEVT && !event_handlers[caps]) {

bug - needs parentheses.

> +		printk(KERN_ERR "Unsupported event source %s\n", evt->name);
> +		return -EINVAL;
> +	}
> +
> +	if (caps && global_eventsource.event && global_eventsource.event != evt)
> +		recalc_active_event(&global_eventsource, caps);
> +
> +	for (i = 0; i < sources->installed; i++) {
> +		if (sources->events[i].event != evt)
> +			recalc_active_event(&sources->events[i], caps);
> +	}
> +
> +	if (new)
> +		sources->events[sources->installed++].event = evt;
> +
> +	if (caps) {
> +		/* Is next_event event source going to be installed? */
> +		if (caps & CLOCK_CAP_NEXTEVT)
> +			caps = CLOCK_CAP_NEXTEVT;
> +
> +		setup_event(&sources->events[sources->installed],
> +			    evt, caps);
> +	} else
> +		printk(KERN_INFO "Inactive event source %s registered\n",
> +		       evt->name);
> +
> +	return 0;
> +}
> +
> +/**
> + * register_local_clockevent - Set up a cpu local clock event device

We have a mixture of clock_event and clockevent.

> + *
> + * @evt:	event device to be registered
> + */
> +int register_local_clockevent(struct clock_event *evt)
> +{
> +	struct local_events *sources = &__get_cpu_var(local_eventsources);

event_sources?

> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&events_lock, flags);
> +
> +	/* Preset the handler in any case */
> +	evt->event_handler = handle_noop;
> +
> +	/* Recalc event sources and maybe reassign handlers */
> +	ret = recalc_events(sources, evt,
> +			    evt->capabilities & CLOCK_BASE_CAPS_MASK, 1);
> +
> +	spin_unlock_irqrestore(&events_lock, flags);
> +
> +	/*
> +	 * Trigger hrtimers, when the event source is next-event
> +	 * capable
> +	 */
> +	if (!ret && (evt->capabilities & CLOCK_CAP_NEXTEVT))
> +		hrtimer_clock_notify();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(register_local_clockevent);
> +
> +/*
> + * Find a next-event capable event source
> + */
> +static int get_next_event_source(void)
> +{
> +	struct local_events *sources = &__get_cpu_var(local_eventsources);
> +	int i;
> +
> +	for (i = 0; i < sources->installed; i++) {
> +		struct clock_event *evt;
> +
> +		evt = sources->events[i].event;
> +		if (evt->capabilities & CLOCK_CAP_NEXTEVT)
> +			return i;
> +	}
> +
> +#ifndef CONFIG_SMP
> +	if (global_eventsource.event->capabilities & CLOCK_CAP_NEXTEVT)
> +		return GLOBAL_CLOCK_EVENT;
> +#endif

How come this is UP-only?  Perhaps a comment describing what's going on here.

> +	return -ENODEV;
> +}
> +
> +/**
> + * clockevents_next_event_available - Check for a installed next-event source
> + */
> +int clockevents_next_event_available(void)
> +{
> +	unsigned long flags;
> +	int idx;
> +
> +	spin_lock_irqsave(&events_lock, flags);
> +	idx = get_next_event_source();
> +	spin_unlock_irqrestore(&events_lock, flags);
> +
> +	return idx < 0 ? 0 : 1;

Perhaps IS_ERR_VALUE() could be used to make this code clearer.

I really wish kerneldoc had a standard way of describing return values. 
People often leave it out, and it's important.

(Although it's fairly obvious here due to the well-chosen function name)

(But it'll be even better when generic-boolean is merged, and people start
using it).

> +}
> +
> +int clockevents_init_next_event(void)
> +{
> +	struct local_events *sources = &__get_cpu_var(local_eventsources);
> +	struct clock_event *nextevt;
> +	unsigned long flags;
> +	int idx, ret = -ENODEV;
> +
> +	if (sources->nextevt)
> +		return -EBUSY;
> +
> +	spin_lock_irqsave(&events_lock, flags);
> +
> +	idx = get_next_event_source();
> +	if (idx < 0)
> +		goto out_unlock;
> +
> +	if (idx == GLOBAL_CLOCK_EVENT)
> +		nextevt = global_eventsource.event;
> +	else
> +		nextevt = sources->events[idx].event;
> +
> +	ret = recalc_events(sources, nextevt, CLOCK_CAPS_MASK, 0);
> +	if (!ret)
> +		sources->nextevt = nextevt;
> + out_unlock:
> +	spin_unlock_irqrestore(&events_lock, flags);
> +
> +	return ret;
> +}
> +
> +int clockevents_set_next_event(ktime_t expires, int force)
> +{
> +	struct local_events *sources = &__get_cpu_var(local_eventsources);
> +	int64_t delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
> +	struct clock_event *nextevt = sources->nextevt;
> +	unsigned long long clc;
> +
> +	if (delta <= 0 && !force)
> +		return -ETIME;
> +
> +	if (delta > nextevt->max_delta_ns)
> +		delta = nextevt->max_delta_ns;
> +	if (delta < nextevt->min_delta_ns)
> +		delta = nextevt->min_delta_ns;
> +
> +	clc = delta * nextevt->mult;
> +	clc >>= nextevt->shift;
> +	nextevt->set_next_event((unsigned long)clc, sources->nextevt);
> +
> +	return 0;
> +}

These functions are exported to the whole kernel, but are undocumented.

AFAIK the timer and hrtimer code consistently uses s64's and u64's.  But
someone has snuck a couple of int64_t's in here.  Please review all the
patches for that.

> +/*
> + * Resume the cpu local clock events
> + */
> +static void clockevents_resume_local_events(void *arg)
> +{
> +	struct local_events *sources = &__get_cpu_var(local_eventsources);
> +	int i;
> +
> +	for (i = 0; i < sources->installed; i++) {
> +		if (sources->events[i].real_caps)
> +			startup_event(sources->events[i].event,
> +				      sources->events[i].real_caps);
> +	}
> +}
> +
> +/*
> + * Called after timekeeping is functional again
> + */
> +void clockevents_resume_events(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	/* Resume global event source */
> +	if (global_eventsource.real_caps)
> +		startup_event(global_eventsource.event,
> +			      global_eventsource.real_caps);
> +
> +	clockevents_resume_local_events(NULL);
> +	local_irq_restore(flags);
> +
> +	touch_softlockup_watchdog();
> +
> +	if (smp_call_function(clockevents_resume_local_events, NULL, 1, 1))
> +		BUG();
> +
> +}

hm.  The kernel's core resume code likes to call resume handlers under
local_irq_disable().  Does that happen here?  A BUG_ON(irqs_disabled())
would tell.

The above code can be simplified via on_each_cpu().

> +/*
> + * Functions related to initialization and hotplug
> + */
> +static int clockevents_cpu_notify(struct notifier_block *self,
> +				  unsigned long action, void *hcpu)
> +{
> +	switch(action) {
> +	case CPU_UP_PREPARE:
> +		break;
> +#ifdef CONFIG_HOTPLUG_CPU
> +	case CPU_DEAD:
> +		/*
> +		 * Do something sensible here !
> +		 * Disable the cpu local clocksources
> +		 */
> +		break;
> +#endif
> +	default:
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block __devinitdata clockevents_nb = {
> +	.notifier_call	= clockevents_cpu_notify,
> +};
> +
> +void __init clockevents_init(void)
> +{
> +	clockevents_cpu_notify(&clockevents_nb, (unsigned long)CPU_UP_PREPARE,
> +				(void *)(long)smp_processor_id());
> +	register_cpu_notifier(&clockevents_nb);
> +}
> 

No...  None of this code should be present if !CONFIG_HOTPLUG_CPU.  See
cpuid_class_cpu_callback() for an example
.  

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934205AbWKWWhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934205AbWKWWhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934224AbWKWWhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:37:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17567 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S934205AbWKWWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:36:59 -0500
Date: Thu, 23 Nov 2006 23:36:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 04/19] Add a framework to manage clock event devices.
In-Reply-To: <20061109233034.526217000@cruncher.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0611210159390.6242@scrub.home>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
 <20061109233034.526217000@cruncher.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Nov 2006, Thomas Gleixner wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> We have two types of clock event devices:
> - global events (one device per system)
> - local events (one device per cpu)
> 
> We assign the various time(r) related interrupts to those devices:
> 
> - global tick (advances jiffies)
> - update process times (per cpu)
> - profiling (per cpu)
> - next timer events (per cpu)
> 
> Architectures register their clock event devices, with specific capability
> bits set, and the framework code assigns the appropriate event handler to the
> event device.  The functionality is assigned via an event handler to avoid
> runtime evalutation of the assigned function bits.
> 
> This allows to control the clock event devices without the architectures
> having to worry about the details of function assignment.  This is also a
> preliminary for high resolution timers and dynamic ticks to allow the core
> code to control the clock functionality without intrusive changes to the
> architecture code.

I have a few problems with this code and I'd really prefer some more arch 
maintainers would look at this (i.e. post it to the arch ml).
It's basically limited to only one global and one per cpu timer, are you 
sure this enough? Large systems may have several timer.

Even for cases I'm interested in I have no idea how to make use of it, 
e.g. I have a somewhat limited timer, which can't be reprogrammed without 
losing accuracy, but I have two (or maybe more) of them, so I can use one 
as general tick timer and its interrupt can be disabled as needed and a 
second timer can be used for dynamic timer events.
Something else I want to use separate timer is for kernel profiling, 
currently events started from the timer tick are basically invisible, so 
I'd like to start profiling on a different timer with a different 
frequency.
Currently high resolution timer are used for quite a lot once enabled, but 
I would like to see the option to limit them, i.e. use a low resolution 
timer for standard tasks (e.g. itimer, nanosleep) and provide a separate 
high resolution posix timer to user space.

This should give some idea of the background with which I'm looking at 
this code and I'm trying to find an answer to the question, how generic 
this really is and how usable this is beyond dynamic ticks.

> +struct clock_event_device {
> +	const char	*name;
> +	unsigned int	capabilities;
> +	unsigned long	max_delta_ns;
> +	unsigned long	min_delta_ns;
> +	unsigned long	mult;
> +	int		shift;
> +	void		(*set_next_event)(unsigned long evt,
> +					  struct clock_event_device *);
> +	void		(*set_mode)(enum clock_event_mode mode,
> +				    struct clock_event_device *);
> +	void		(*event_handler)(struct pt_regs *regs);
> +};
> +
> +/*
> + * Calculate a multiplication factor for scaled math, which is used to convert
> + * nanoseconds based values to clock ticks:
> + *
> + * clock_ticks = (nanoseconds * factor) >> shift.
> + *
> + * div_sc is the rearranged equation to calculate a factor from a given clock
> + * ticks / nanoseconds ratio:
> + *
> + * factor = (clock_ticks << shift) / nanoseconds
> + */
> +static inline unsigned long div_sc(unsigned long ticks, unsigned long nsec,
> +				   int shift)
> +{
> +	uint64_t tmp = ((uint64_t)ticks) << shift;
> +
> +	do_div(tmp, nsec);
> +	return (unsigned long) tmp;
> +}

One possible problem in this area: the nsec2cycle multiplier is mostly
constant AFAICT, where as the clock source cycle2nsec isn't (especially if 
controlled via ntp). This means this could produce slightly wrong 
results, the larger the longer the period is between timer interrupts.


> +
> +#define MAX_CLOCK_EVENTS	4
> +#define GLOBAL_CLOCK_EVENT	MAX_CLOCK_EVENTS
> +
> +struct event_descr {
> +	struct clock_event_device *event;
> +	unsigned int mode;
> +	unsigned int real_caps;
> +	struct irqaction action;
> +};
> +
> +struct local_events {
> +	int installed;
> +	struct event_descr events[MAX_CLOCK_EVENTS];
> +	struct clock_event_device *nextevt;
> +	ktime_t	expires_next;
> +};
> +
[...]
> +static void handle_tick(struct pt_regs *regs)
> +{
> +	write_seqlock(&xtime_lock);
> +	do_timer(1);
> +	write_sequnlock(&xtime_lock);
> +}
> +
> +/*
> + * Bootup and lowres handler: ticks and update_process_times
> + */
> +static void handle_tick_update(struct pt_regs *regs)
> +{
> +	write_seqlock(&xtime_lock);
> +	do_timer(1);
> +	write_sequnlock(&xtime_lock);
> +
> +	update_process_times(user_mode(regs));
> +}
> +
> +/*
> + * Bootup and lowres handler: ticks and profileing
> + */
> +static void handle_tick_profile(struct pt_regs *regs)
> +{
> +	write_seqlock(&xtime_lock);
> +	do_timer(1);
> +	write_sequnlock(&xtime_lock);
> +
> +	profile_tick(CPU_PROFILING);
> +}
> +
> +/*
> + * Bootup and lowres handler: ticks, update_process_times and profiling
> + */
> +static void handle_tick_update_profile(struct pt_regs *regs)
> +{
> +	write_seqlock(&xtime_lock);
> +	do_timer(1);
> +	write_sequnlock(&xtime_lock);
> +
> +	update_process_times(user_mode(regs));
> +	profile_tick(CPU_PROFILING);
> +}
> +
> +/*
> + * Bootup and lowres handler: update_process_times
> + */
> +static void handle_update(struct pt_regs *regs)
> +{
> +	update_process_times(user_mode(regs));
> +}
> +
> +/*
> + * Bootup and lowres handler: update_process_times and profiling
> + */
> +static void handle_update_profile(struct pt_regs *regs)
> +{
> +	update_process_times(user_mode(regs));
> +	profile_tick(CPU_PROFILING);
> +}
> +
> +/*
> + * Bootup and lowres handler: profiling
> + */
> +static void handle_profile(struct pt_regs *regs)
> +{
> +	profile_tick(CPU_PROFILING);
> +}
> +
> +/*
> + * Noop handler when we shut down an event device
> + */
> +static void handle_noop(struct pt_regs *regs)
> +{
> +}
> +
> +/*
> + * Lookup table for bootup and lowres event assignment
> + *
> + * The event handler is choosen by the capability flags of the clock event
> + * device.
> + */
> +static void __read_mostly *event_handlers[] = {
> +	handle_noop,			/* 0: No capability selected */
> +	handle_tick,			/* 1: Tick only	*/
> +	handle_update,			/* 2: Update process times */
> +	handle_tick_update,		/* 3: Tick + update process times */
> +	handle_profile,			/* 4: Profiling int */
> +	handle_tick_profile,		/* 5: Tick + Profiling int */
> +	handle_update_profile,		/* 6: Update process times +
> +					      profiling */
> +	handle_tick_update_profile,	/* 7: Tick + update process times +
> +					      profiling */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	hrtimer_interrupt,		/* 8: Reprogrammable event device */
> +#endif
> +};
> +
> [...]

What's the point with all these little helper functions? This looks rather 
inflexible to me. The generic code has to know about all timer events and 
even provide helper to handle all variation between them?
There might be a small performance benefit in doing this, usually I'm all 
for it, but I don't think this one is really worth it. A simple list of 
active events would be much simpler, e.g. something like this is what I 
have in mind:

	source->time = gettime();
	source->timeout += MAX_TIMEOUT;
	for_each_handler() {
		if (source->time >= timer->timeout) {
			...
			source->timeout = min(source->timeout, timer->timeout);
		}
	}
	reprogram_timer();

The interrupt system already maintains a list of handler, so something 
like this should be reasonably possible without any extra overhead. AFAICT 
it could even simplify your hrtimer code by keeping realtime and 
monotonic hrtimer separate. Right now you have one loop for 
HRTIMER_MAX_CLOCK_BASES in the hrtimer code and another in the clock code 
only to calculate the next timeout.

The generic interrupt system already has a concept of per cpu interrupts, 
IMO it's worth it to check out how it can be used for clock events. IMO 
the core clock code should have almost no idea of per cpu clocks.

Basically I have these problems with this code (maybe there is a reason 
for all this, but I don't see it from the existing documentation):
- generic code shouldn't care about the number of used hw timer
- generic code shouldn't care about how these timers are used
- the various clients shouldn't know about each other (e.g. the sched_tick 
  code in the hrtimer source is just ugly).

In this context I still don't understand why you insist on the strict 
separation of clock events and sources, these _are_ related and separating 
it like this prevents more flexible usage, e.g. to have multiple clock 
sources and timer (and in many cases they are even the same).

> +/*
> + * Setup an event device. Assign an handler and start it up
> + */
> +static void setup_event(struct event_descr *descr,
> +			struct clock_event_device *evt, unsigned int caps)
> +{
> +	void *handler = event_handlers[caps];

These flags aren't really capabilities but intended usage. Every clock 
event driver has already its possible usage hardcoded (sometimes even with 
ugly ifdefs, e.g. lapic).
Capabilities would be something like:
- cpu local/global
- reprogrammable/fixed timer
Based on this the generic code should dynamically decide how to use and 
attach the clients.

bye, Roman

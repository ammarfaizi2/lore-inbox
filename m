Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWI3Io7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWI3Io7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWI3Iog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:44:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWI3Io0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:44:26 -0400
Date: Sat, 30 Sep 2006 01:43:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 15/23] high-res timers: core
Message-Id: <20060930014356.aa22dd48.akpm@osdl.org>
In-Reply-To: <20060929234440.521325000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234440.521325000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:34 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> add the core bits of high-res timers support.
> 
> the design makes use of the existing hrtimers subsystem which manages a
> per-CPU and per-clock tree of timers, and the clockevents framework, which
> provides a standard API to request programmable clock events from. The
> core code does not have to know about the clock details - it makes use
> of clockevents_set_next_event().
> 
> the code also provides dyntick functionality: it is implemented via a
> per-cpu sched_tick hrtimer that is set to HZ frequency, but which is
> reprogrammed to a longer timeout before going idle, and reprogrammed to
> HZ again once the CPU goes busy again. (If an non-timer IRQ hits the
> idle task then it will process jiffies before calling the IRQ code.)
> 
> the impact to non-high-res architectures is intended to be minimal.
> 
> ...
>  
> @@ -108,17 +134,53 @@ struct hrtimer_cpu_base {
>  	spinlock_t			lock;
>  	struct lock_class_key		lock_key;
>  	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	ktime_t				expires_next;
> +	int				hres_active;
> +	unsigned long			check_clocks;
> +	struct list_head		cb_pending;
> +	struct hrtimer			sched_timer;
> +	struct pt_regs			*sched_regs;
> +	unsigned long			events;
> +#endif

You forgot to update the kerneldoc for this struct.

Does `events' needs to be long?

<looks>

oh, it's a scalar this time ;)

> +#ifdef CONFIG_HIGH_RES_TIMERS
> +
> +extern void hrtimer_clock_notify(void);
> +extern void clock_was_set(void);
> +extern void hrtimer_interrupt(struct pt_regs *regs);
> +
> +# define hrtimer_cb_get_time(t)	(t)->base->get_time()
> +# define hrtimer_hres_active	(__get_cpu_var(hrtimer_bases).hres_active)

These two could be inline functions?

That might cause include file ordering problems I guess.

> +/*
> + * The resolution of the clocks. The resolution value is returned in
> + * the clock_getres() system call to give application programmers an
> + * idea of the (in)accuracy of timers. Timer values are rounded up to
> + * this resolution values.
> + */
> +# define KTIME_HIGH_RES		(ktime_t) { .tv64 = CONFIG_HIGH_RES_RESOLUTION }
> +# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
> +
> +#else
> +
> +# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
> +
>  /*
>   * clock_was_set() is a NOP for non- high-resolution systems. The
>   * time-sorted order guarantees that a timer does not expire early and
>   * is expired in the next softirq when the clock was advanced.
>   */
> -#define clock_was_set()		do { } while (0)
> -#define hrtimer_clock_notify()	do { } while (0)
> -extern ktime_t ktime_get(void);
> -extern ktime_t ktime_get_real(void);
> +# define clock_was_set()		do { } while (0)
> +# define hrtimer_clock_notify()		do { } while (0)

these could be inlines.

> +# define hrtimer_cb_get_time(t)		(t)->base->softirq_time

Does this need parenthesisation?  Probably it's OK..  An inline function
would be nicer.

> +# define hrtimer_hres_active		0

Perhaps this would be better if it was presented as a function.

> +/* High resolution timer related functions */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +
> +static ktime_t last_jiffies_update;

What's this do?

> +/*
> + * Reprogramm the event source with checking both queues for the

"Reprogramme" ;)

> + * next event
> + * Called with interrupts disabled and base->lock held
> + */
> +static void hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base)
> +{
> +	int i;
> +	struct hrtimer_clock_base *base = cpu_base->clock_base;
> +	ktime_t expires;
> +
> +	cpu_base->expires_next.tv64 = KTIME_MAX;
> +
> +	for (i = HRTIMER_MAX_CLOCK_BASES; i ; i--, base++) {

Downcounting loops hurt my brain.  Does it actually generate better code?

> +		struct hrtimer *timer;
> +
> +		if (!base->first)
> +			continue;
> +		timer = rb_entry(base->first, struct hrtimer, node);
> +		expires = ktime_sub(timer->expires, base->offset);
> +		if (expires.tv64 < cpu_base->expires_next.tv64)
> +			cpu_base->expires_next = expires;
> +	}
> +
> +	if (cpu_base->expires_next.tv64 != KTIME_MAX)
> +		clockevents_set_next_event(cpu_base->expires_next, 1);
> +}
> +
> +/*
> + * Shared reprogramming for clock_realtime and clock_monotonic
> + *
> + * When a new expires first timer is enqueued, we have

That sentence might need work.

> +/*
> + * Retrigger next event is called after clock was set
> + */
> +static void retrigger_next_event(void *arg)
> +{
> +	struct hrtimer_cpu_base *base;
> +	struct timespec realtime_offset;
> +	unsigned long flags, seq;
> +
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		set_normalized_timespec(&realtime_offset,
> +					-wall_to_monotonic.tv_sec,
> +					-wall_to_monotonic.tv_nsec);
> +	} while (read_seqretry(&xtime_lock, seq));
> +
> +	base = &per_cpu(hrtimer_bases, smp_processor_id());
> +
> +	/* Adjust CLOCK_REALTIME offset */
> +	spin_lock_irqsave(&base->lock, flags);
> +	base->clock_base[CLOCK_REALTIME].offset =
> +		timespec_to_ktime(realtime_offset);
> +
> +	hrtimer_force_reprogram(base);
> +	spin_unlock_irqrestore(&base->lock, flags);
> +}
> +
> +/*
> + * Clock realtime was set
> + *
> + * Change the offset of the realtime clock vs. the monotonic
> + * clock.
> + *
> + * We might have to reprogram the high resolution timer interrupt. On
> + * SMP we call the architecture specific code to retrigger _all_ high
> + * resolution timer interrupts. On UP we just disable interrupts and
> + * call the high resolution interrupt code.
> + */
> +void clock_was_set(void)
> +{
> +	preempt_disable();
> +	if (hrtimer_hres_active) {
> +		retrigger_next_event(NULL);
> +
> +		if (smp_call_function(retrigger_next_event, NULL, 1, 1))
> +			BUG();
> +	}
> +	preempt_enable();
> +}

If you use on_each_cpu() here you know that retrigger_next_event() will be
called under local_irq_disable().  The preempt_disable() goes away and the
spin_lock_irqsave() in retrigger_next_event() becomes a spin_lock() and
everything becomes simpler.

> +/**
> + * hrtimer_clock_notify - A clock source or a clock event has been installed
> + *
> + * Notify the per cpu softirqs to recheck the clock sources and events
> + */
> +void hrtimer_clock_notify(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NR_CPUS; i++)
> +		set_bit(0, &per_cpu(hrtimer_bases, i).check_clocks);
> +}

This will go splat if/when the arch chooses to not implement per-cpu
storage for not-possible CPUs.  Use for_each_possible_cpu().

> +
> +static const ktime_t nsec_per_hz = { .tv64 = NSEC_PER_SEC / HZ };
> +

This could use the same trick as KTIME_HIGH_RES and friends.  But perhaps
the compiler will generate the same code..

> +/*
> + * We switched off the global tick source when switching to high resolution
> + * mode. Update jiffies64.
> + *
> + * Must be called with interrupts disabled !
> + *
> + * FIXME: We need a mechanism to assign the update to a CPU. In principle this
> + * is not hard, but when dynamic ticks come into play it starts to be. We don't
> + * want to wake up a complete idle cpu just to update jiffies, so we need
> + * something more intellegent than a mere "do this only on CPUx".
> + */
> +static void update_jiffies64(ktime_t now)
> +{
> +	ktime_t delta;
> +
> +	write_seqlock(&xtime_lock);
> +
> +	delta = ktime_sub(now, last_jiffies_update);
> +	if (delta.tv64 >= nsec_per_hz.tv64) {
> +

stray blank line.

> +		unsigned long orun = 1;

"orun"?

> +
> +		delta = ktime_sub(delta, nsec_per_hz);
> +		last_jiffies_update = ktime_add(last_jiffies_update,
> +						nsec_per_hz);
> +
> +		/* Slow path for long timeouts */
> +		if (unlikely(delta.tv64 >= nsec_per_hz.tv64)) {
> +			s64 incr = ktime_to_ns(nsec_per_hz);
> +			orun = ktime_divns(delta, incr);
> +
> +			last_jiffies_update = ktime_add_ns(last_jiffies_update,
> +							   incr * orun);
> +			jiffies_64 += orun;
> +			orun++;
> +		}

That's a bit of a hack isn't it?  do_timer() owns the modification of
jiffies_64, so why is this code modifying it as well?

> +		do_timer(orun);

twice?

I suspect a bug.

> +	}
> +	write_sequnlock(&xtime_lock);
> +}
> +
> +/*
> + * We rearm the timer until we get disabled by the idle code
> + */
> +static int hrtimer_sched_tick(struct hrtimer *timer)
> +{
> +	unsigned long flags;
> +	struct hrtimer_cpu_base *cpu_base =
> +		container_of(timer, struct hrtimer_cpu_base, sched_timer);
> +
> +	local_irq_save(flags);
> +	/*
> +	 * Do not call, when we are not in irq context and have
> +	 * no valid regs pointer
> +	 */
> +	if (cpu_base->sched_regs) {
> +		update_process_times(user_mode(cpu_base->sched_regs));
> +		profile_tick(CPU_PROFILING, cpu_base->sched_regs);
> +	}
> +
> +	hrtimer_forward(timer, hrtimer_cb_get_time(timer), nsec_per_hz);
> +	local_irq_restore(flags);
> +
> +	return HRTIMER_RESTART;

bah.  hrtimer_restart is an `enum hrtimer_restart', not an integer.

> +	printk(KERN_INFO "hrtimers: Switched to high resolution mode CPU %d\n",
> +	       smp_processor_id());

"on CPU"

> +
> +static inline int hrtimer_enqueue_reprogram(struct hrtimer *timer,
> +					    struct hrtimer_clock_base *base)
> +{
> +	/*
> +	 * When High resolution timers are active try to reprogram. Note, that
> +	 * in case the state has HRTIMER_CALLBACK set, no reprogramming and no
> +	 * expiry check happens. The timer gets enqueued into the rbtree and
> +	 * the reprogramming / expiry check is done in the hrtimer_interrupt or
> +	 * in the softirq.
> +	 */

This (useful) comment should be above the function, not inside it.

> +	if (hrtimer_hres_active && hrtimer_reprogram(timer, base)) {
> +
> +		/* Timer is expired, act upon the callback mode */
> +		switch(timer->cb_mode) {
> +		case HRTIMER_CB_IRQSAFE_NO_RESTART:
> +			/*
> +			 * We can call the callback from here. No restart
> +			 * happens, so no danger of recursion
> +			 */
> +			BUG_ON(timer->function(timer) != HRTIMER_NORESTART);

Doing assert(thing-which-has-side-effects) is poor form.

I doubt if the kernel will work if someone goes and disables BUG_ON, but
it's a laudable objective.


> +			return 1;
> +		case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
> +			/*
> +			 * This is solely for the sched tick emulation with
> +			 * dynamic tick support to ensure that we do not
> +			 * restart the tick right on the edge and end up with
> +			 * the tick timer in the softirq ! The calling site
> +			 * takes care of this.
> +			 */
> +			return 1;
> +		case HRTIMER_CB_IRQSAFE:
> +		case HRTIMER_CB_SOFTIRQ:
> +			/*
> +			 * Move everything else into the softirq pending list !
> +			 */
> +			hrtimer_add_cb_pending(timer, base);
> +			raise_softirq(HRTIMER_SOFTIRQ);
> +			return 1;
> +		default:
> +			BUG();
> +		}
> +	}
> +	return 0;
> +}
> +
> +static inline void hrtimer_resume_jiffie_update(void)

hrtimer_resume_jiffy_update

> +{
> +	unsigned long flags;
> +	ktime_t now = ktime_get();
> +
> +	write_seqlock_irqsave(&xtime_lock, flags);
> +	last_jiffies_update = now;
> +	write_sequnlock_irqrestore(&xtime_lock, flags);
> +}
> +
> +#else
> +
> +# define hrtimer_hres_active		0
> +# define hrtimer_check_clocks()		do { } while (0)
> +# define hrtimer_enqueue_reprogram(t,b)	0
> +# define hrtimer_force_reprogram(b)	do { } while (0)
> +# define hrtimer_cb_pending(t)		0
> +# define hrtimer_remove_cb_pending(t)	do { } while (0)
> +# define hrtimer_init_hres(c)		do { } while (0)
> +# define hrtimer_init_timer_hres(t)	do { } while (0)
> +# define hrtimer_resume_jiffie_update()	do { } while (0)
> +
> +#endif /* CONFIG_HIGH_RES_TIMERS */
> +
>  /*
>   * Timekeeping resumed notification

resume

> +#ifdef CONFIG_HIGH_RES_TIMERS
> +
> +/*
> + * High resolution timer interrupt
> + * Called with interrupts disabled
> + */
> +void hrtimer_interrupt(struct pt_regs *regs)
> +{
> +	struct hrtimer_clock_base *base;
> +	ktime_t expires_next, now;
> +	int i, raise = 0, cpu = smp_processor_id();
> +	struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> +
> +	BUG_ON(!cpu_base->hres_active);
> +
> +	/* Store the regs for an possible sched_timer callback */
> +	cpu_base->sched_regs = regs;
> +	cpu_base->events++;
> +
> + retry:
> +	now = ktime_get();
> +
> +	/* Check, if the jiffies need an update */
> +	update_jiffies64(now);
> +
> +	expires_next.tv64 = KTIME_MAX;
> +
> +	base = cpu_base->clock_base;
> +
> +	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
> +		ktime_t basenow;
> +		struct rb_node *node;
> +
> +		spin_lock(&cpu_base->lock);
> +
> +		basenow = ktime_add(now, base->offset);

Would it be better to take the lock outside the loop, rather than hammering
on it like this?


> +		while ((node = base->first)) {
> +			struct hrtimer *timer;
> +
> +			timer = rb_entry(node, struct hrtimer, node);
> +
> +			if (basenow.tv64 < timer->expires.tv64) {
> +				ktime_t expires;
> +
> +				expires = ktime_sub(timer->expires,
> +						    base->offset);
> +				if (expires.tv64 < expires_next.tv64)
> +					expires_next = expires;
> +				break;
> +			}
> +
> +			/* Move softirq callbacks to the pending list */
> +			if (timer->cb_mode == HRTIMER_CB_SOFTIRQ) {
> +				__remove_hrtimer(timer, base, HRTIMER_PENDING, 0);
> +				hrtimer_add_cb_pending(timer, base);
> +				raise = 1;
> +				continue;
> +			}
> +
> +			__remove_hrtimer(timer, base, HRTIMER_CALLBACK, 0);
> +
> +			if (timer->function(timer) != HRTIMER_NORESTART) {
> +				BUG_ON(timer->state != HRTIMER_CALLBACK);
> +				/*
> +				 * state == HRTIMER_CALLBACK prevents
> +				 * reprogramming. We do this when we break out
> +				 * of the loop !
> +				 */
> +				enqueue_hrtimer(timer, base);
> +			}
> +			timer->state &= ~HRTIMER_CALLBACK;
> +		}
> +		spin_unlock(&cpu_base->lock);
> +		base++;
> +	}
> +
> +	cpu_base->expires_next = expires_next;
> +
> +	/* Reprogramming necessary ? */
> +	if (expires_next.tv64 != KTIME_MAX) {
> +		if (clockevents_set_next_event(expires_next, 0))
> +			goto retry;
> +	}
> +
> +	/* Invalidate regs */
> +	cpu_base->sched_regs = NULL;
> +
> +	/* Raise softirq ? */
> +	if (raise)
> +		raise_softirq(HRTIMER_SOFTIRQ);
> +}
> +
>  
> ...
>
>  static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
> @@ -701,7 +1226,8 @@ static int __sched do_nanosleep(struct h
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		hrtimer_start(&t->timer, t->timer.expires, mode);
>  
> -		schedule();
> +		if (likely(t->task))
> +			schedule();

Why?  Needs a comment.

> @@ -0,0 +1,22 @@
> +#
> +# Timer subsystem related configuration options
> +#
> +config HIGH_RES_TIMERS
> +	bool "High Resolution Timer Support"
> +	depends on GENERIC_TIME
> +	help
> +	  This option enables high resolution timer support. If your
> +	  hardware is not capable then this option only increases
> +	  the size of the kernel image.
> +
> +config HIGH_RES_RESOLUTION
> +	int "High Resolution Timer resolution (nanoseconds)"
> +	depends on HIGH_RES_TIMERS
> +	default 1000
> +	help
> +	  This sets the resolution in nanoseconds of the high resolution
> +	  timers. Too fine a resolution (small a number) will usually
> +	  not be observable due to normal system latencies.  For an
> +          800 MHz processor about 10,000 (10 microseconds) is recommended as a
> +	  finest resolution.  If you don't need that sort of resolution,
> +	  larger values may generate less overhead.

In that case the default is far too low.

What value are you suggesting that users and vendors set it to?



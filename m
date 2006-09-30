Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWI3Iqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWI3Iqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWI3IqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:46:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbWI3Ipc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:45:32 -0400
Date: Sat, 30 Sep 2006 01:44:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 16/23] dynticks: core
Message-Id: <20060930014456.55543e93.akpm@osdl.org>
In-Reply-To: <20060929234440.636609000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234440.636609000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:35 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> dynticks core code.
> 
> Add idling-stats to the cpu base (to be used to optimize power
> management decisions), add the scheduler tick and its stop/restart
> functions, and the jiffies-update function to be called when an irq
> context hits the idle context.
> 

I worry that we're making this feature optional.

Certainly for the public testing period we should wire these new features
to "on".

But long-term this is yet another question which we'll need to ask when
we're trying to work out why someone's computer failed.

> --- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-09-30 01:41:18.000000000 +0200
> +++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-09-30 01:41:18.000000000 +0200
> @@ -142,6 +142,14 @@ struct hrtimer_cpu_base {
>  	struct hrtimer			sched_timer;
>  	struct pt_regs			*sched_regs;
>  	unsigned long			events;
> +#ifdef CONFIG_NO_HZ
> +	ktime_t				idle_tick;
> +	int				tick_stopped;
> +	unsigned long			idle_jiffies;
> +	unsigned long			idle_calls;
> +	unsigned long			idle_sleeps;
> +	unsigned long			idle_sleeptime;
> +#endif

Forgot to update this structure's kerneldoc.

> +# define show_no_hz_stats(p)			do { } while (0)

static inlines provide type checking.

> @@ -451,7 +450,6 @@ static void update_jiffies64(ktime_t now
>  
>  			last_jiffies_update = ktime_add_ns(last_jiffies_update,
>  							   incr * orun);
> -			jiffies_64 += orun;
>  			orun++;
>  		}

I think we just fixed that bug I might have seen.

>  		do_timer(orun);
> @@ -459,28 +457,201 @@ static void update_jiffies64(ktime_t now
>  	write_sequnlock(&xtime_lock);
>  }
>  
> +#ifdef CONFIG_NO_HZ
> +/*
> + * Called from interrupt entry when then CPU was idle

tpyo

> + */
> +void update_jiffies(void)
> +{
> +	unsigned long flags;
> +	ktime_t now;
> +
> +	if (unlikely(!hrtimer_hres_active))
> +		return;
> +
> +	now = ktime_get();
> +
> +	local_irq_save(flags);
> +	update_jiffies64(now);
> +	local_irq_restore(flags);
> +}
> +
> +/*
> + * Called from the idle thread so careful!

about what?

> + */
> +int hrtimer_stop_sched_tick(void)
> +{
> +	int cpu = smp_processor_id();
> +	struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
> +	unsigned long seq, last_jiffies, next_jiffies;
> +	ktime_t last_update, expires;
> +	unsigned long delta_jiffies;
> +	unsigned long flags;
> +
> +	if (unlikely(!hrtimer_hres_active))
> +		return 0;
> +
> +	local_irq_save(flags);

Do we really need local_irq_save() here?  If it's called from the idle
thread then presumably local IRQs are enabled already.  They'd better be,
because this function unconditionally enables them in a couple of places.

> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		last_update = last_jiffies_update;
> +		last_jiffies = jiffies;
> +	} while (read_seqretry(&xtime_lock, seq));
> +
> +	next_jiffies = get_next_timer_interrupt(last_jiffies);
> +	delta_jiffies = next_jiffies - last_jiffies;
> +
> +	cpu_base->idle_calls++;
> +
> +	if ((long)delta_jiffies >= 1) {
> +		/*
> +		 * Save the current tick time, so we can restart the
> +		 * scheduler tick when we get woken up before the next
> +		 * wheel timer expires
> +		 */
> +		cpu_base->idle_tick = cpu_base->sched_timer.expires;
> +		expires = ktime_add_ns(last_update,
> +				       nsec_per_hz.tv64 * delta_jiffies);
> +		hrtimer_start(&cpu_base->sched_timer, expires, HRTIMER_ABS);
> +		cpu_base->idle_sleeps++;
> +		cpu_base->idle_jiffies = last_jiffies;
> +		cpu_base->tick_stopped = 1;
> +	} else {
> +		/* Keep the timer alive */
> +		if ((long) delta_jiffies < 0)
> +			raise_softirq(TIMER_SOFTIRQ);
> +	}
> +
> +	if (local_softirq_pending()) {
> +		inc_preempt_count();

I am unable to work out why the inc_preempt_count() is there.  Please add
comment.

> +		do_softirq();
> +		dec_preempt_count();
> +	}
> +
> +	WARN_ON(!idle_cpu(cpu));
> +	/*
> +	 * RCU normally depends on the timer IRQ kicking completion
> +	 * in every tick. We have to do this here now:
> +	 */
> +	if (rcu_pending(cpu)) {
> +		/*
> +		 * We are in quiescent state, so advance callbacks:
> +		 */
> +		rcu_advance_callbacks(cpu, 1);
> +		local_irq_enable();
> +		local_bh_disable();
> +		rcu_process_callbacks(0);
> +		local_bh_enable();
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	return need_resched();
> +}

Are the RCU guys OK with this?

> +void hrtimer_restart_sched_tick(void)

Am unable to work out what this does from its implementation and from its
caller.  Please document it.


> +{
> +	struct hrtimer_cpu_base *cpu_base = &__get_cpu_var(hrtimer_bases);
> +	unsigned long flags;
> +	ktime_t now;
> +
> +	if (!hrtimer_hres_active || !cpu_base->tick_stopped)
> +		return;
> +
> +	/* Update jiffies first */
> +	now = ktime_get();
> +
> +	local_irq_save(flags);

The sole caller of this function calls it with local interrupts enabled. 
local_irq_disable() could be used here.

> +	update_jiffies64(now);
> +
> +	/*
> +	 * Update process times would randomly account the time we slept to
> +	 * whatever the context of the next sched tick is.  Enforce that this
> +	 * is accounted to idle !
> +	 */
> +	add_preempt_count(HARDIRQ_OFFSET);
> +	update_process_times(0);
> +	sub_preempt_count(HARDIRQ_OFFSET);
> +
> +	cpu_base->idle_sleeptime += jiffies - cpu_base->idle_jiffies;
> +
> +	cpu_base->tick_stopped  = 0;
> +	hrtimer_cancel(&cpu_base->sched_timer);
> +	cpu_base->sched_timer.expires = cpu_base->idle_tick;
> +
> +	while (1) {
> +		hrtimer_forward(&cpu_base->sched_timer, now, nsec_per_hz);
> +		hrtimer_start(&cpu_base->sched_timer,
> +			      cpu_base->sched_timer.expires, HRTIMER_ABS);
> +		if (hrtimer_active(&cpu_base->sched_timer))
> +			break;
> +		/* We missed an update */
> +		update_jiffies64(now);
> +		now = ktime_get();
> +	}
> +	local_irq_restore(flags);
> +}
> +
> +void show_no_hz_stats(struct seq_file *p)
> +{
> +	int cpu;
> +	unsigned long calls = 0, sleeps = 0, time = 0, events = 0;
> +
> +	for_each_online_cpu(cpu) {
> +		struct hrtimer_cpu_base *base = &per_cpu(hrtimer_bases, cpu);
> +
> +		calls += base->idle_calls;
> +		sleeps += base->idle_sleeps;
> +		time += base->idle_sleeptime;
> +		events += base->events;
> +
> +		seq_printf(p, "nohz cpu%d I:%lu S:%lu T:%lu A:%lu E: %lu\n",
> +			   cpu, base->idle_calls, base->idle_sleeps,
> +			   base->idle_sleeptime, base->idle_sleeps ?
> +			   base->idle_sleeptime / sleeps : 0, base->events);
> +	}
> +#ifdef CONFIG_SMP
> +	seq_printf(p, "nohz total I:%lu S:%lu T:%lu A:%lu E:%lu\n",
> +		   calls, sleeps, time, sleeps ? time / sleeps : 0, events);
> +#endif
> +}

Wouldn't it be better to display the "total" line on UP rather than cpu0?



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWBYOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWBYOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWBYOZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:25:58 -0500
Received: from kanga.kvack.org ([66.96.29.28]:59578 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030234AbWBYOZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:25:58 -0500
Date: Sat, 25 Feb 2006 09:20:49 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] No idle HZ aka dynticks i386 for 2.6.16-rc4
Message-ID: <20060225142049.GA17844@kvack.org>
References: <200602251530.58797.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602251530.58797.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 03:30:57PM +1100, Con Kolivas wrote:
> +struct dyntick_timer {
> +	spinlock_t lock;
> +
> +	/* dyntick init */
> +	int (*arch_init)(void);
> +	/* Enables dynamic tick */
> +	int (*arch_enable)(void);
> +	/* Disables dynamic tick */
> +	int (*arch_disable)(void);
> +	/* Reprograms the timer */
> +	void (*arch_reprogram)(unsigned long);
> +	/* Function called when all cpus are idle, passing the idle duration */
> +	void (*arch_all_cpus_idle)(unsigned int);
> +
> +	unsigned short state;		/* Current state */
> +	unsigned int min_skip;		/* Min number of ticks to skip */
> +	unsigned int max_skip;		/* Max number of ticks to skip */
> +	unsigned long tick;		/* The next earliest tick */
> +};

If you make min_skip a short here, the structure will pack nicely and 
save 6 bytes of padding on 64 bit machines.  Alternatively, keep it an 
int and put it in the padding following the spinlock to save the whole 
8 bytes.

> +int dyntick_skipping(void)
> +{
> +	int ret = (get_cpu_var(dyn_cpu).next_tick > jiffies);
> +
> +	put_cpu_var(dyn_cpu);
> +	return ret;
>

This looks wrong...  Shouldn't it be time_after()?  Otherwise it seems to 
not work when jiffies wraps.

> +int dyntick_current_skip(void)
> +{
> +	int ret = 0;
> +
> +	if (get_cpu_var(dyn_cpu).next_tick > jiffies)
> +		ret = __get_cpu_var(dyn_cpu).skip;
> +	put_cpu_var(dyn_cpu);
> +	return ret;
> +}

Ditto.


> +/*
> + * Returns the next scheduled dyntick if we are skipping ticks.
> + */
> +unsigned long dyntick_next_tick(void)
> +{
> +	unsigned long next = 0;
> +
> +	if (get_cpu_var(dyn_cpu).next_tick > jiffies)
> +		next = __get_cpu_var(dyn_cpu).next_tick;
> +	put_cpu_var(dyn_cpu);
> +	return next;
> +}

Ditto.

> +/*
> + * dyn_early_reprogram is used to reprogram an earlier tick than is currently
> + * set by timer_dyn_reprogram.
> + * dyn_early_reprogram allows other code such as the acpi idle code to
> + * program an earlier tick than the one already chosen by timer_dyn_reprogram.
> + * It only reprograms it if the tick is earlier than the next one planned.
> + */
> +void dyn_early_reprogram(unsigned int delta)
> +{
> +	unsigned long flags, tick = jiffies + delta;
> +
> +	if (tick >= get_cpu_var(dyn_cpu).next_tick &&
> +		__get_cpu_var(dyn_cpu).next_tick > jiffies)
> +			goto put_out;

Ditto.

The SMP case requires a bit more thorough reading...  It seems there 
are a few places that call test_nohz_cpu() without taking the spinlock.  
That could be the race causing missed ticks on smp.  Cheers,

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.

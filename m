Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWJIT4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWJIT4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWJIT4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:56:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:56230 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964787AbWJIT4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:56:47 -0400
Subject: Re: [PATCH 07/10] -mm: clocksource: remove update_callback
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20061006185457.153724000@mvista.com>
References: <20061006185439.667702000@mvista.com>
	 <20061006185457.153724000@mvista.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 12:56:43 -0700
Message-Id: <1160423803.5458.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> plain text document attachment
> (clocksource_remove_update_callback.patch)
> Inorporated John's comment of moving the rating change code
> into mark_tsc_unstable() , then I renamed tsc_update_callback()
> to tsc_update_khz() and added a call to it into places that change
> the tsc_khz variable.
> 
> With the new notifier block the update_callback becomes
> obsolete.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

This (ie: dropping the update_callback logic) basically looks fine.
Although it builds ontop of some of the patches I'm not excited about,
so I'd probably want to see it independent of those changes.


On a related note: I take exception (albeit lightheartedly - I think he
was painting with a broad brush) to Thomas' comment earlier about
"fragile timekeeping". I feel the timekeeping code is really *leaps and
bounds* better with regard to correctness and robustness. There have
been a few embarrassing flubs, but really I do think we've made
improvements.

Now, with that said, I will admit that the TSC code is somewhat fragile
(and I believe this is what Thomas was getting at). Its been the real
problem causer in most cases, so we need to be careful about changes to
its logic that will affect clocksource selection.

So this patch in-particular, however reworked, would need some careful
testing.

thanks
-john

> ---
>  arch/i386/kernel/tsc.c      |   54 ++++++++++++++++++++++----------------------
>  include/linux/clocksource.h |    2 -
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> Index: linux-2.6.18/arch/i386/kernel/tsc.c
> ===================================================================
> --- linux-2.6.18.orig/arch/i386/kernel/tsc.c
> +++ linux-2.6.18/arch/i386/kernel/tsc.c
> @@ -50,8 +50,7 @@ static int __init tsc_setup(char *str)
>  __setup("notsc", tsc_setup);
>  
>  /*
> - * code to mark and check if the TSC is unstable
> - * due to cpufreq or due to unsynced TSCs
> + * Flag that denotes an unstable tsc and check function.
>   */
>  static int tsc_unstable;
>  
> @@ -60,12 +59,6 @@ static inline int check_tsc_unstable(voi
>  	return tsc_unstable;
>  }
>  
> -void mark_tsc_unstable(void)
> -{
> -	tsc_unstable = 1;
> -}
> -EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> -
>  /* Accellerators for sched_clock()
>   * convert from cycles(64bits) => nanoseconds (64bits)
>   *  basic equation:
> @@ -171,6 +164,21 @@ err:
>  	return 0;
>  }
>  
> +#if !defined(CONFIG_SMP) || defined(CONFIG_CPU_FREQ)
> +static struct clocksource clocksource_tsc;
> +static unsigned long current_tsc_khz;
> +static void tsc_update_khz(void)
> +{
> +	/* only update if tsc_khz has changed: */
> +	if (current_tsc_khz != tsc_khz) {
> +		current_tsc_khz = tsc_khz;
> +		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> +							clocksource_tsc.shift);
> +	}
> +
> +}
> +#endif
> +
>  int recalibrate_cpu_khz(void)
>  {
>  #ifndef CONFIG_SMP
> @@ -179,6 +187,7 @@ int recalibrate_cpu_khz(void)
>  	if (cpu_has_tsc) {
>  		cpu_khz = calculate_cpu_khz();
>  		tsc_khz = cpu_khz;
> +		tsc_update_khz();
>  		cpu_data[0].loops_per_jiffy =
>  			cpufreq_scale(cpu_data[0].loops_per_jiffy,
>  					cpu_khz_old, cpu_khz);
> @@ -282,6 +291,7 @@ time_cpufreq_notifier(struct notifier_bl
>  						ref_freq, freq->new);
>  			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
>  				tsc_khz = cpu_khz;
> +				tsc_update_khz();
>  				set_cyc2ns_scale(cpu_khz);
>  				/*
>  				 * TSC based sched_clock turns
> @@ -322,7 +332,6 @@ core_initcall(cpufreq_tsc);
>  /* clock source code */
>  
>  static unsigned long current_tsc_khz = 0;
> -static int tsc_update_callback(void);
>  
>  static cycle_t read_tsc(void)
>  {
> @@ -340,31 +349,24 @@ static struct clocksource clocksource_ts
>  	.mask			= CLOCKSOURCE_MASK(64),
>  	.mult			= 0, /* to be set */
>  	.shift			= 22,
> -	.update_callback	= tsc_update_callback,
>  	.is_continuous		= 1,
>  };
>  
> -static int tsc_update_callback(void)
> -{
> -	int change = 0;
>  
> -	/* check to see if we should switch to the safe clocksource: */
> -	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
> +/*
> + * code to mark if the TSC is unstable
> + * due to cpufreq or due to unsynced TSCs
> + */
> +void mark_tsc_unstable(void)
> +{
> +	if (unlikely(!tsc_unstable)) {
>  		clocksource_tsc.rating = 50;
>  		clocksource_rating_change(&clocksource_tsc);
> -		change = 1;
>  	}
> -
> -	/* only update if tsc_khz has changed: */
> -	if (current_tsc_khz != tsc_khz) {
> -		current_tsc_khz = tsc_khz;
> -		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> -							clocksource_tsc.shift);
> -		change = 1;
> -	}
> -
> -	return change;
> +	tsc_unstable = 1;
>  }
> +EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> +
>  
>  static int __init dmi_mark_tsc_unstable(struct dmi_system_id *d)
>  {
> Index: linux-2.6.18/include/linux/clocksource.h
> ===================================================================
> --- linux-2.6.18.orig/include/linux/clocksource.h
> +++ linux-2.6.18/include/linux/clocksource.h
> @@ -59,7 +59,6 @@ extern struct clocksource clocksource_ji
>   *			subtraction of non 64 bit counters
>   * @mult:		cycle to nanosecond multiplier
>   * @shift:		cycle to nanosecond divisor (power of two)
> - * @update_callback:	called when safe to alter clocksource values
>   * @is_continuous:	defines if clocksource is free-running.
>   * @cycle_interval:	Used internally by timekeeping core, please ignore.
>   * @xtime_interval:	Used internally by timekeeping core, please ignore.
> @@ -72,7 +71,6 @@ struct clocksource {
>  	cycle_t mask;
>  	u32 mult;
>  	u32 shift;
> -	int (*update_callback)(void);
>  	int is_continuous;
>  
>  	/* timekeeping specific data, ignore */
> 
> --
> 


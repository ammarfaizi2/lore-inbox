Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWCCDFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWCCDFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 22:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWCCDFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 22:05:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751468AbWCCDFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 22:05:47 -0500
Date: Thu, 2 Mar 2006 19:04:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
Message-Id: <20060302190408.1e754f12.akpm@osdl.org>
In-Reply-To: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
	<20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> ...
>
> In kernel 2.6, update_times() is called directly in timer interrupt,
> so there is no point calculating ticks here.  Then update_wall_time()
> and calc_load() can also be optimized.  This also get rid of
> difference of jiffies and jiffies_64 due to compiler's optimization
> (which was reported previously with subject "jiffies_64 vs. jiffies").
> 
> Also adjust x86_64 timer interrupt handler with this change.
> 
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> index 3080f84..7a1d790 100644
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -423,7 +423,8 @@ void main_timer_handler(struct pt_regs *
>  
>  	if (lost > 0) {
>  		handle_lost_ticks(lost, regs);
> -		jiffies += lost;
> +		while (lost--)
> +			do_timer(regs);
>  	}
>  
>  /*
> diff --git a/kernel/timer.c b/kernel/timer.c
> index fc6646f..54544a7 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -787,24 +787,14 @@ u64 current_tick_length(void)
>  	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
>  }
>  
> -/*
> - * Using a loop looks inefficient, but "ticks" is
> - * usually just one (we shouldn't be losing ticks,
> - * we're doing this this way mainly for interrupt
> - * latency reasons, not because we think we'll
> - * have lots of lost timer ticks
> - */
> -static void update_wall_time(unsigned long ticks)
> +static void update_wall_time(void)
>  {
> -	do {
> -		ticks--;
> -		update_wall_time_one_tick();
> -		if (xtime.tv_nsec >= 1000000000) {
> -			xtime.tv_nsec -= 1000000000;
> -			xtime.tv_sec++;
> -			second_overflow();
> -		}
> -	} while (ticks);
> +	update_wall_time_one_tick();
> +	if (xtime.tv_nsec >= 1000000000) {
> +		xtime.tv_nsec -= 1000000000;
> +		xtime.tv_sec++;
> +		second_overflow();
> +	}
>  }
>  
>  /*
> @@ -849,15 +839,15 @@ unsigned long avenrun[3];
>  EXPORT_SYMBOL(avenrun);
>  
>  /*
> - * calc_load - given tick count, update the avenrun load estimates.
> + * calc_load - update the avenrun load estimates.
>   * This is called while holding a write_lock on xtime_lock.
>   */
> -static inline void calc_load(unsigned long ticks)
> +static inline void calc_load(void)
>  {
>  	unsigned long active_tasks; /* fixed-point */
>  	static int count = LOAD_FREQ;
>  
> -	count -= ticks;
> +	count--;
>  	if (count < 0) {
>  		count += LOAD_FREQ;
>  		active_tasks = count_active_tasks();
> @@ -906,14 +896,9 @@ void run_local_timers(void)
>   */
>  static inline void update_times(void)
>  {
> -	unsigned long ticks;
> -
> -	ticks = jiffies - wall_jiffies;
> -	if (ticks) {
> -		wall_jiffies += ticks;
> -		update_wall_time(ticks);
> -	}
> -	calc_load(ticks);
> +	wall_jiffies++;
> +	update_wall_time();
> +	calc_load();
>  }
>    
>  /*

I'm actually creaking under the load of timer patches over here.  A lot of
the above code has been heavily redone in John's time patches.  I guess the
above optimisation is still relevant after John's work (?) but we need to
decide what to do.   Now is as good a time as any.

John, that timer stuff is so fundamental and hits on code which has
historically been so fragile that I'm not sure it's even 2.6.17 material. 
In which case we should sneak patches like the above underneath it all.

Or we decide to take your work into 2.6.17, in which case the above needs
to be redone for that context.

I'm not sure how to resolve this, really.  Worried.  Have you socialised
those changes with architecture maintainers?  If so, what was the feedback?

Andi, have you had time to think about it all?

Thanks.

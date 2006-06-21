Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWFUU6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWFUU6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWFUU6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:58:47 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:3714 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030261AbWFUU6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:58:46 -0400
Subject: Re: [PATCH] fix and optimize clock source update
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606211434020.904@scrub.home>
References: <Pine.LNX.4.64.0606211434020.904@scrub.home>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 13:58:38 -0700
Message-Id: <1150923519.2690.14.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 14:38 +0200, Roman Zippel wrote:
> This fixes the clock source updates in update_wall_time() to correctly
> track the time coming in via current_tick_length(). Optimize the fast
> paths to be as short as possible to keep the overhead low.

Unfortunately it also introduces time inconsistencies when clocksources
are changed. Comments and a fix below:

> Andrew, please apply this patch, it's essential so that we can finally
> get the clock source stuff merged. It keeps the overhead added by all
> the patches in a not really great but acceptable range.
> Tested with 2.6.17-rc6-mm2, applies and compiles with 2.6.17-mm1
> 
> 
> 
>  arch/powerpc/kernel/time.c  |    4 -
>  include/linux/clocksource.h |  113 ++---------------------------------
>  include/linux/timex.h       |    4 -
>  kernel/timer.c              |  142 ++++++++++++++++++++++++++++++--------------
>  4 files changed, 113 insertions(+), 150 deletions(-)
> 
> Index: linux-2.6-mm/arch/powerpc/kernel/time.c
> ===================================================================
> --- linux-2.6-mm.orig/arch/powerpc/kernel/time.c	2006-06-21 13:59:35.000000000 +0200
> +++ linux-2.6-mm/arch/powerpc/kernel/time.c	2006-06-21 14:01:22.000000000 +0200
> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(tb_ticks_per_sec);	/* for 
>  u64 tb_to_xs;
>  unsigned tb_to_us;
>  
> -#define TICKLEN_SCALE	(SHIFT_SCALE - 10)
> +#define TICKLEN_SCALE	TICK_LENGTH_SHIFT
>  u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
>  u64 ticklen_to_xs;	/* 0.64 fraction */
>  
> @@ -534,7 +534,7 @@ static __inline__ void timer_recalc_offs
>  
>  	if (__USE_RTC())
>  		return;
> -	tlen = current_tick_length(SHIFT_SCALE - 10);
> +	tlen = current_tick_length();
>  	offset = cur_tb - do_gtod.varp->tb_orig_stamp;
>  	if (tlen == last_tick_len && offset < 0x80000000u)
>  		return;
> Index: linux-2.6-mm/include/linux/clocksource.h
> ===================================================================
> --- linux-2.6-mm.orig/include/linux/clocksource.h	2006-06-21 14:00:38.000000000 +0200
> +++ linux-2.6-mm/include/linux/clocksource.h	2006-06-21 14:01:22.000000000 +0200
> @@ -46,8 +46,8 @@ typedef u64 cycle_t;
>   * @shift:		cycle to nanosecond divisor (power of two)
>   * @update_callback:	called when safe to alter clocksource values
>   * @is_continuous:	defines if clocksource is free-running.
> - * @interval_cycles:	Used internally by timekeeping core, please ignore.
> - * @interval_snsecs:	Used internally by timekeeping core, please ignore.
> + * @cycle_interval:	Used internally by timekeeping core, please ignore.
> + * @xtime_interval:	Used internally by timekeeping core, please ignore.
>   */

Where the variable name changes really necessary (I find them less
clear)? You also forgot to add error here as it is added below.

>  struct clocksource {
>  	char *name;
> @@ -61,8 +61,9 @@ struct clocksource {
>  	int is_continuous;
>  
>  	/* timekeeping specific data, ignore */
> -	cycle_t interval_cycles;
> -	u64 interval_snsecs;
> +	cycle_t cycle_last, cycle_interval;
> +	u64 xtime_nsec, xtime_interval;
> +	s64 error;
>  };
>  
[snip]
> +
> +#define clocksource_adjustcheck(sign, error, interval, offset) ({	\
> +	int adj = sign;							\
> +	error >>= 2;							\
> +	if (unlikely(sign > 0 ? error > interval : error < interval)) {	\
> +		adj = clocksource_bigadjust(sign, error,		\
> +					    interval, offset);		\
> +		interval <<= adj;					\
> +		offset <<= adj;						\
> +		adj = sign << adj;					\
> +	}								\
> +	adj;								\
> +})

That's still a #define with side effects. Yuck.

> +/*
> + * adjust the multiplier to reduce the error value,
> + * this is optimized for the most common adjustments of -1,0,1,
> + * for other values we can do a bit more work.
> + */
> +static void clocksource_adjust(struct clocksource *clock, s64 offset)
> +{
> +	s64 error, interval = clock->cycle_interval;
> +	int adj;
> +
> +	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
> +	if (error > interval) {
> +		adj = clocksource_adjustcheck(1, error, interval, offset);
> +	} else if (error < -interval) {
> +		interval = -interval;
> +		offset = -offset;
> +		adj = clocksource_adjustcheck(-1, error, interval, offset);
> +	} else
> +		goto done;
> +
> +	clock->mult += adj;
> +	clock->xtime_interval += interval;
> +	clock->xtime_nsec -= offset;
> +	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
> +done:
> +	/* store full nanoseconds into xtime */
> +	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
> +}

Why are you setting xtime.tv_nsec in clocksource_adjust()?
That should be kept in update_wall_time. 


> +/*
>   * update_wall_time - Uses the current clocksource to increment the wall time
>   *
>   * Called from the timer interrupt, must hold a write on xtime_lock.
>   */
>  static void update_wall_time(void)
>  {
> -	static s64 remainder_snsecs, error;
> -	s64 snsecs_per_sec;
> -	cycle_t now, offset;
> +	cycle_t offset;
>  
> -	snsecs_per_sec = (s64)NSEC_PER_SEC << clock->shift;
> -	remainder_snsecs += (s64)xtime.tv_nsec << clock->shift;
> +	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
>  
> -	now = clocksource_read(clock);
> -	offset = (now - last_clock_cycle)&clock->mask;
> +#ifdef CONFIG_GENERIC_TIME
> +	offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;
> +#else
> +	offset = clock->cycle_interval;
> +#endif

This looks ok, but I'd prefer the GENERIC_TIME case to be less dense
(not doing the read in the same line).

>  	/* normally this loop will run just once, however in the
>  	 * case of lost or late ticks, it will accumulate correctly.
>  	 */
> -	while (offset > clock->interval_cycles) {
> -		/* get the ntp interval in clock shifted nanoseconds */
> -		s64 ntp_snsecs	= current_tick_length(clock->shift);
> -
> +	while (offset > clock->cycle_interval) {

Shouldn't that be >= ? That was one of the fixes I made in my other
patch.

[snip]
> -		/* correct the clock when NTP error is too big */
> -		remainder_snsecs += make_ntp_adj(clock, offset, &error);
> +	/* correct the clock when NTP error is too big */
> +	clocksource_adjust(clock, offset);
>  
> -		if (remainder_snsecs >= snsecs_per_sec) {
> -			remainder_snsecs -= snsecs_per_sec;
> -			xtime.tv_sec++;
> -			second_overflow();
> -		}
> -	}
> -	/* store full nanoseconds into xtime */
> -	xtime.tv_nsec = remainder_snsecs >> clock->shift;
> -	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
> +	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
>  
>  	/* check to see if there is a new clocksource to use */
>  	if (change_clocksource()) {
> -		error = 0;
> -		remainder_snsecs = 0;
> +		clock->error = 0;
> +		clock->xtime_nsec = 0;
> +		xtime.tv_nsec = 0;
>  		clocksource_calculate_interval(clock, tick_nsec);
>  	}

Setting xtime.tv_nsec to zero in the above is incorrect and causes the
inconsistencies I mentioned at the top.

Overall, I've got some gripes, but I'm not going to block this because
of them. I appreciate you sending this and I think moving forward is
more important. We can continue to hash out the smaller details in the
future.

Include the following small patch which fixes the issue I've found in my
testing and this will get my ACK.

thanks
-john

Index: romanfix/kernel/timer.c
===================================================================
--- romanfix.orig/kernel/timer.c
+++ romanfix/kernel/timer.c
@@ -1062,15 +1062,12 @@ static void clocksource_adjust(struct cl
 		offset = -offset;
 		adj = clocksource_adjustcheck(-1, error, interval, offset);
 	} else
-		goto done;
+		return;
 
 	clock->mult += adj;
 	clock->xtime_interval += interval;
 	clock->xtime_nsec -= offset;
 	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
-done:
-	/* store full nanoseconds into xtime */
-	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
 }
 
 /*
@@ -1119,13 +1116,14 @@ static void update_wall_time(void)
 	/* correct the clock when NTP error is too big */
 	clocksource_adjust(clock, offset);
 
+	/* store full nanoseconds into xtime */
+	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 
 	/* check to see if there is a new clocksource to use */
 	if (change_clocksource()) {
 		clock->error = 0;
 		clock->xtime_nsec = 0;
-		xtime.tv_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
 }



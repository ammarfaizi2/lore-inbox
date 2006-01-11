Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWAKXFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWAKXFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWAKXFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:05:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43954 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932515AbWAKXFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:05:32 -0500
Subject: Re: [PATCH 3/10] NTP: add ntp_update_frequency
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220021210.30900@scrub.home>
References: <Pine.LNX.4.61.0512220021210.30900@scrub.home>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 15:05:30 -0800
Message-Id: <1137020731.2890.74.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 00:21 +0100, Roman Zippel wrote:
> This introduces ntp_update_frequency and deinlines ntp_clear() (as it's
> not performance critical).
> It also changes how tick_nsec is calculated from tick_usec, instead of
> scaling it using TICK_USEC_TO_NSEC it's simply shifted by the difference.
> Since ntp doesn't change the tick value, the result in practice is the
> same, but it's easier to change this into a clock parameter, which can
> be calculated during boot.
> 

Looks ok. Few comments below.

> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> ---
> 
>  include/linux/timex.h |   14 ++------------
>  kernel/time.c         |    7 ++++---
>  kernel/timer.c        |   28 ++++++++++++++++++++++++++--
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> Index: linux-2.6-mm/include/linux/timex.h
> ===================================================================
> --- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:11:56.000000000 +0100
> +++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:00.000000000 +0100
> @@ -219,18 +219,8 @@ extern long time_reftime;	/* time at las
>  extern long time_adjust;	/* The amount of adjtime left */
>  extern long time_next_adjust;	/* Value for time_adjust at next tick */
>  
> -/**
> - * ntp_clear - Clears the NTP state variables
> - *
> - * Must be called while holding a write on the xtime_lock
> - */
> -static inline void ntp_clear(void)
> -{
> -	time_adjust = 0;		/* stop active adjtime() */
> -	time_status |= STA_UNSYNC;
> -	time_maxerror = NTP_PHASE_LIMIT;
> -	time_esterror = NTP_PHASE_LIMIT;
> -}
> +extern void ntp_clear(void);
> +extern void ntp_update_frequency(void);

Yep, that looks good.


>  /**
>   * ntp_synced - Returns 1 if the NTP status is not UNSYNC
> Index: linux-2.6-mm/kernel/time.c
> ===================================================================
> --- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:11:48.000000000 +0100
> +++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:00.000000000 +0100
> @@ -334,10 +334,11 @@ int do_adjtimex(struct timex *txc)
>  		    time_freq = max(time_freq, -time_tolerance);
>  		} /* STA_PLL */
>  	    } /* txc->modes & ADJ_OFFSET */
> -	    if (txc->modes & ADJ_TICK) {
> +	    if (txc->modes & ADJ_TICK)
>  		tick_usec = txc->tick;
> -		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
> -	    }
> +
> +	    if (txc->modes & ADJ_TICK)
> +		    ntp_update_frequency();

Why the extra conditional instead of just adding ntp_update_frequency()
inside the braces?


>  	} /* txc->modes */
>  leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
>  		result = TIME_ERROR;
> Index: linux-2.6-mm/kernel/timer.c
> ===================================================================
> --- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:11:56.000000000 +0100
> +++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:00.000000000 +0100
> @@ -551,8 +551,8 @@ found:
>   * Timekeeping variables
>   */
>  unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
> -unsigned long tick_nsec = TICK_NSEC;		/* ACTHZ period (nsec) */
> -static unsigned long tick_nsec_curr = TICK_NSEC;
> +unsigned long tick_nsec;			/* ACTHZ period (nsec) */
> +static unsigned long tick_nsec_curr;
>  
>  /* 
>   * The current time 
> @@ -591,6 +591,29 @@ long time_reftime;			/* time at last adj
>  long time_adjust;
>  long time_next_adjust;
>  
> +/**
> + * ntp_clear - Clears the NTP state variables
> + *
> + * Must be called while holding a write on the xtime_lock
> + */
> +void ntp_clear(void)
> +{
> +	time_adjust = 0;		/* stop active adjtime() */
> +	time_status |= STA_UNSYNC;
> +	time_maxerror = NTP_PHASE_LIMIT;
> +	time_esterror = NTP_PHASE_LIMIT;
> +
> +	ntp_update_frequency();
> +
> +	tick_nsec_curr = tick_nsec;
> +}
> +
> +void ntp_update_frequency(void)
> +{
> +	tick_nsec = tick_usec * 1000;
> +	tick_nsec -= NSEC_PER_SEC / HZ - TICK_NSEC;
> +}

Could you add another "john is slow and forgetful" comment here?

>  /*
>   * this routine handles the overflow of the microsecond field
>   *
> @@ -1348,6 +1371,7 @@ static struct notifier_block __devinitda
>  
>  void __init init_timers(void)
>  {
> +	ntp_clear();
>  	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
>  				(void *)(long)smp_processor_id());
>  	register_cpu_notifier(&timers_nb);


thanks
-john


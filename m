Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVHQTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVHQTEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVHQTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:04:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60658 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751206AbVHQTEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:04:11 -0400
Message-ID: <43038A13.8010008@mvista.com>
Date: Wed, 17 Aug 2005 12:03:47 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>  <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home> <1124151001.8630.87.camel@cog.beaverton.ibm.com> <Pine.LNX.4.61.0508162337130.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508162337130.3728@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:


~

The thing that worries me about this function is that it does every 
thing in usec.  We are using nsec in xtime now and I wonder if it would 
not be more accurate to do the math in nsecs.  Even tick size 
(tick_nsec) does not translate well to usec, it currently being 999849 
nsecs.

George
> ---
> 
>  kernel/time.c  |    3 ++-
>  kernel/timer.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/kernel/time.c
> ===================================================================
> --- linux-2.6.orig/kernel/time.c	2005-07-13 03:18:04.000000000 +0200
> +++ linux-2.6/kernel/time.c	2005-08-16 01:37:20.000000000 +0200
> @@ -366,8 +366,9 @@ int do_adjtimex(struct timex *txc)
>  	    } /* txc->modes & ADJ_OFFSET */
>  	    if (txc->modes & ADJ_TICK) {
>  		tick_usec = txc->tick;
> -		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
>  	    }
> +	    if (txc->modes & (ADJ_FREQUENCY|ADJ_OFFSET|ADJ_TICK))
> +		    time_recalc();
>  	} /* txc->modes */
>  leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
>  	    || ((time_status & (STA_PPSFREQ|STA_PPSTIME)) != 0
> Index: linux-2.6/kernel/timer.c
> ===================================================================
> --- linux-2.6.orig/kernel/timer.c	2005-07-13 03:18:04.000000000 +0200
> +++ linux-2.6/kernel/timer.c	2005-08-16 23:10:53.000000000 +0200
> @@ -559,6 +559,7 @@ found:
>   */
>  unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
>  unsigned long tick_nsec = TICK_NSEC;		/* ACTHZ period (nsec) */
> +unsigned long tick_nsec2 = TICK_NSEC;
>  
>  /* 
>   * The current time 
> @@ -569,6 +570,7 @@ unsigned long tick_nsec = TICK_NSEC;		/*
>   * the usual normalization.
>   */
>  struct timespec xtime __attribute__ ((aligned (16)));
> +struct timespec xtime2 __attribute__ ((aligned (16)));
>  struct timespec wall_to_monotonic __attribute__ ((aligned (16)));
>  
>  EXPORT_SYMBOL(xtime);
> @@ -596,6 +598,33 @@ static long time_adj;			/* tick adjust (
>  long time_reftime;			/* time at last adjustment (s)	*/
>  long time_adjust;
>  long time_next_adjust;
> +static long time_adj2, time_adj2_cur, time_freq_adj2, time_freq_phase2, time_phase2;
> +
> +void time_recalc(void)
> +{
> +	long f, t;
> +	tick_nsec = TICK_USEC_TO_NSEC(tick_usec);

This leaves bits on the floor.  Is it not possible to do this whole 
calculation in nano seconds?  Currently, for example, tick_nsec is 999849...
> +
> +	t = time_freq >> (SHIFT_USEC + 8);
> +	if (t) {
> +		time_freq -= t << (SHIFT_USEC + 8);
> +		t *= 1000 << 8;
> +	}
> +	f = time_freq * 125;
> +	t += tick_usec * USER_HZ * 1000 + (f >> (SHIFT_USEC - 3));
> +	f &= (1 << (SHIFT_USEC - 3)) - 1;
> +	tick_nsec2 = t / HZ;
> +	f += (t % HZ) << (SHIFT_USEC - 3);
> +	f <<= 5;
> +	time_adj2 = f / HZ;
> +	time_freq_adj2 = f % HZ;
> +
> +	printk("tr: %ld.%09ld(%ld,%ld,%ld,%ld) - %ld.%09ld(%ld,%ld,%ld)\n",
> +		xtime.tv_sec, xtime.tv_sec,
> +		tick_nsec, time_freq, time_offset, time_next_adjust,
> +		xtime2.tv_sec, xtime2.tv_nsec,
> +		tick_nsec2, time_adj2, time_freq_adj2);
> +}
>  
>  /*
>   * this routine handles the overflow of the microsecond field
> @@ -739,6 +768,16 @@ static void second_overflow(void)
>  #endif
>  }
>  
> +static void second_overflow2(void)
> +{
> +	time_adj2_cur = time_adj2;
> +	time_freq_phase2 += time_freq_adj2;
> +	if (time_freq_phase2 > HZ) {
> +		time_freq_phase2 -= HZ;
> +		time_adj2_cur++;
> +	}
> +}
> +
>  /* in the NTP reference this is called "hardclock()" */
>  static void update_wall_time_one_tick(void)
>  {
> @@ -786,6 +825,20 @@ static void update_wall_time_one_tick(vo
>  		time_adjust = time_next_adjust;
>  		time_next_adjust = 0;
>  	}
> +
> +	delta_nsec = tick_nsec2;
> +	time_phase2 += time_adj2_cur;
> +	if (time_phase2 >= (1 << (SHIFT_USEC + 2))) {
> +		long ltemp = time_phase2 >> (SHIFT_USEC + 2);
> +		time_phase2 -= ltemp << (SHIFT_USEC + 2);
> +		delta_nsec += ltemp;
> +	}
> +	xtime2.tv_nsec += delta_nsec;
> +	if (xtime2.tv_nsec >= NSEC_PER_SEC) {
> +		xtime2.tv_nsec -= NSEC_PER_SEC;
> +		xtime2.tv_sec++;
> +		second_overflow2();
> +	}
>  }
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

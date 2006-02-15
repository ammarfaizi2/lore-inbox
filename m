Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWBOVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWBOVVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWBOVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:21:38 -0500
Received: from mailserver.applegatebroadband.net ([207.55.227.3]:27410 "EHLO
	apbb.net") by vger.kernel.org with ESMTP id S1750757AbWBOVVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:21:37 -0500
Message-ID: <43F39B2C.9030208@wildturkeyranch.net>
Date: Wed, 15 Feb 2006 13:20:44 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@wildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: Linux time routines
References: <43F2F135.24187.A9E0BD5@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-Reply-To: <43F2F135.24187.A9E0BD5@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> (Please CC: replies to me, not subscribed)
> Hi,
> 
> first of all I must conferss that I was wrong when presenting
> 1) a patch for getnstimeofday()
> 2) measurements based on 1)
> 
> My patch, even when looking right at the first glance, it was ignoring the tick-
> interpolation when no time interpolator was defined. It clearly indicates that the 
> the variety on non-coherent time routines is a mess. A revised fix would look like 
> this (other junks unaffected):
> 
> -#ifdef CONFIG_TIME_INTERPOLATION
> +/* get system time with nanosecond accuracy */
>  void getnstimeofday (struct timespec *tv)
>  {
> -	unsigned long seq,sec,nsec;
> -
> +	unsigned long seq, nsec, sec;
> +#ifdef CONFIG_TIME_INTERPOLATION
>  	do {
>  		seq = read_seqbegin(&xtime_lock);
>  		sec = xtime.tv_sec;
> -		nsec = xtime.tv_nsec+time_interpolator_get_offset();
> +		nsec = xtime.tv_nsec + time_interpolator_get_offset();
>  	} while (unlikely(read_seqretry(&xtime_lock, seq)));
>  
>  	while (unlikely(nsec >= NSEC_PER_SEC)) {
>  		nsec -= NSEC_PER_SEC;
>  		++sec;
>  	}
> +#else
> +	{	/*FIXME: Try not to loose nanoseconds */
> +		struct timeval tv;
> +
> +		do_gettimeofday(&tv);
> +		sec = tv.tv_sec;
> +		nsec = tv.tv_usec * 1000 + xtime.tv_nsec % 1000;
> +	}
> +#endif
>  	tv->tv_sec = sec;
>  	tv->tv_nsec = nsec;
>  }
> 
> 
> --
> 
> Another important issue is this:
> do_gettimeofday() (and related routines) currently does not return anything. 
> However occasionally one needs the "raw" (more or less) value of the tick 
> interpolation (e.g. for PPS frequency calibration). To get the current time and 
> the interpolation value in a coherent way, it seems easiest to make 
> do_gettimeofday() (and related) routines to return the interpolation value (they 
> have it anyway).
> 
> (Explanation: NTP offset correction plus frequency correction do already add to 
> the kernel clock. So when trying to estimate the absolute frequency error, you 
> must measure the timing without such corrections.)
> 
> Thus something like:
> unsigned long do_gettimeofday (struct timeval *tv)
> {
>         unsigned long seq, nsec, usec, sec, offset;
>         do {
>                 seq = read_seqbegin(&xtime_lock);
>                 offset = time_interpolator_get_offset();
>                 sec = xtime.tv_sec;
>                 nsec = xtime.tv_nsec;
>         } while (unlikely(read_seqretry(&xtime_lock, seq)));
> 
>         usec = (nsec + offset) / 1000;
> 
>         while (unlikely(usec >= USEC_PER_SEC)) {
>                 usec -= USEC_PER_SEC;
>                 ++sec;
>         }
> 
>         tv->tv_sec = sec;
>         tv->tv_usec = usec;
>         return offset / 1000;
> }
> 
> or
> 
> unsigned long do_gettimeofday(struct timeval *tv)
> {
>         unsigned long seq;
>         unsigned long result, usec, sec;
>         unsigned long max_ntp_tick;
> 
>         do {
>                 unsigned long lost;
> 
>                 seq = read_seqbegin(&xtime_lock);
> 
>                 result = usec = cur_timer->get_offset();
>                 lost = jiffies - wall_jiffies;
> 
>                 /*
>                  * If time_adjust is negative then NTP is slowing the clock
>                  * so make sure not to go into next possible interval.
>                  * Better to lose some accuracy than have time go backwards..
>                  */
>                 if (unlikely(time_adjust < 0)) {
>                         max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
>                         usec = min(usec, max_ntp_tick);
> 
>                         if (lost)
>                                 usec += lost * max_ntp_tick;
>                 }
>                 else if (unlikely(lost))
>                         usec += lost * (USEC_PER_SEC / HZ);
> 
>                 sec = xtime.tv_sec;
>                 usec += (xtime.tv_nsec / 1000);
>         } while (read_seqretry(&xtime_lock, seq));
> 
>         while (usec >= 1000000) {
>                 usec -= 1000000;
>                 sec++;
>         }
> 
>         tv->tv_sec = sec;
>         tv->tv_usec = usec;
>         return result;
> }
> 
> Similarly
> 
> static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
> {
>         if (clock->clock_get)
>                 return clock->clock_get(tp);
> 
>         return getnstimeofday(tp);
> }
> 
> with
> 
> int do_posix_clock_monotonic_gettime(struct timespec *tp) returning the proper 
> interpolation offset, etc.
> 
> Would such a change in the interface be acceptable?

The problem with this is that it leaves time_phase and the limit imposed by 
FINENSEC out.  What I did for a customer, a bit ago, was to change 
update_wall_time_one_tick() to calculate delta_nsec for NEXT time.  Then I 
used this pre-calculated delta_nsec to adjust do_gettimeofday().
> 

-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/


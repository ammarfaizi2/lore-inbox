Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUI0W4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUI0W4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUI0W4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:56:06 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:52217 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S267417AbUI0Wyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:54:51 -0400
Message-ID: <41589A18.7050504@mvista.com>
Date: Mon, 27 Sep 2004 15:54:16 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Posix compliant behavior of CLOCK_PROCESS/THREAD_CPUTIME_ID
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uh, do you have a test program to verify these?  I would like to add it to the 
support package on sourceforge.

George

Christoph Lameter wrote:
> Attached follows a patch to implement the POSIX clocks according to the
> POSIX standard which states in V3 of the Single Unix Specification:
> 
> 1. CLOCK_PROCESS_CPUTIME_ID
> 
>   Implementations shall also support the special clockid_t value
>   CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
>   calling process when invoking one of the clock_*() or timer_*()
>   functions. For these clock IDs, the values returned by clock_gettime() and specified
>   by clock_settime() represent the amount of execution time of the process
>   associated with the clock.
> 
> 2. CLOCK_THREAD_CPUTIME_ID
> 
>   Implementations shall also support the special clockid_t value
>   CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the
>   calling thread when invoking one of the clock_*() or timer_*()
>   functions. For these clock IDs, the values returned by clock_gettime()
>   and specified by clock_settime() shall represent the amount of
>   execution time of the thread associated with the clock.
> 
> These times mentioned are CPU processing times and not the time that has
> passed since the startup of a process. Glibc currently provides its own
> implementation of these two clocks which is designed to return the time
> that passed since the startup of a process or a thread.
> 
> Moreover this clock is bound to CPU timers which is problematic when the
> frequency of the clock changes or the process is moved to a different
> processor whose cpu timer may not be fully synchronized to the cpu timer
> of the current CPU.
> 
> I would like to have the following patch integrated into the kernel. Glibc
> would need to be modified to simply generate a system call for clock_* without
> doing its own emulation of a clock. CLOCK_PROCESS_CPUTIME_ID and
> CLOCK_THREAD_CPUTIME id were never intended to be used as a means to
> access a time stamp counter on a CPU and it may be better to find another
> means of accesses the cpu time registerss.
> 
> The patch is really quite straighforward and only affects one file...
> 
> Index: linus/kernel/posix-timers.c
> ===================================================================
> --- linus.orig/kernel/posix-timers.c	2004-09-23 15:12:01.000000000 -0700
> +++ linus/kernel/posix-timers.c	2004-09-27 13:42:40.000000000 -0700
> @@ -10,6 +10,10 @@
>   * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
>   *			     Copyright (C) 2004 Boris Hu
>   *
> + * 2004-07-27 Provide POSIX compliant clocks
> + *		CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
> + *		by Christoph Lameter
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or (at
> @@ -133,18 +137,10 @@
>   *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
>   *	    1/HZ resolution clock.
>   *
> - * CPUTIME & THREAD_CPUTIME: We are not, at this time, definding these
> - *	    two clocks (and the other process related clocks (Std
> - *	    1003.1d-1999).  The way these should be supported, we think,
> - *	    is to use large negative numbers for the two clocks that are
> - *	    pinned to the executing process and to use -pid for clocks
> - *	    pinned to particular pids.	Calls which supported these clock
> - *	    ids would split early in the function.
> - *
>   * RESOLUTION: Clock resolution is used to round up timer and interval
>   *	    times, NOT to report clock times, which are reported with as
>   *	    much resolution as the system can muster.  In some cases this
> - *	    resolution may depend on the underlaying clock hardware and
> + *	    resolution may depend on the underlying clock hardware and
>   *	    may not be quantifiable until run time, and only then is the
>   *	    necessary code is written.	The standard says we should say
>   *	    something about this issue in the documentation...
> @@ -162,7 +158,7 @@
>   *
>   *          At this time all functions EXCEPT clock_nanosleep can be
>   *          redirected by the CLOCKS structure.  Clock_nanosleep is in
> - *          there, but the code ignors it.
> + *          there, but the code ignores it.
>   *
>   * Permissions: It is assumed that the clock_settime() function defined
>   *	    for each clock will take care of permission checks.	 Some
> @@ -198,6 +194,8 @@
>  	struct timespec *tp, struct timespec *mo);
>  int do_posix_clock_monotonic_gettime(struct timespec *tp);
>  int do_posix_clock_monotonic_settime(struct timespec *tp);
> +int do_posix_clock_process_gettime(struct timespec *tp);
> +int do_posix_clock_thread_gettime(struct timespec *tp);
>  static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
> 
>  static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
> @@ -218,6 +216,14 @@
>  		.clock_get = do_posix_clock_monotonic_gettime,
>  		.clock_set = do_posix_clock_monotonic_settime
>  	};
> +	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
> +		.abs_struct = NULL,
> +		.clock_get = do_posix_clock_thread_gettime
> +	};
> +	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
> +		.abs_struct = NULL,
> +		.clock_get = do_posix_clock_process_gettime
> +	};

You will have to supply functions to return errors for the unimplemented calls. 
  Otherwise the caller will end up in the CLOCK_REALTIME code which will just 
not work.

Also, to trap calls to clock_nanosleep() you will need to start running it 
through the same dispatch table.  (See notes on this in the comments.).

-g
> 
>  #ifdef CONFIG_TIME_INTERPOLATION
>  	/* Clocks are more accurate with time interpolators */
> @@ -226,6 +232,8 @@
> 
>  	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
>  	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
> +	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
> +	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);
> 
>  	posix_timers_cache = kmem_cache_create("posix_timers_cache",
>  					sizeof (struct k_itimer), 0, 0, NULL, NULL);
> @@ -1227,6 +1235,46 @@
>  	return -EINVAL;
>  }
> 
> +/*
> + * Single Unix Specification V3:
> + *
> + * Implementations shall also support the special clockid_t value
> + * CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the calling
> + * thread when invoking one of the clock_*() or timer_*() functions. For these
> + * clock IDs, the values returned by clock_gettime() and specified by
> + * clock_settime() shall represent the amount of execution time of the thread
> + * associated with the clock.
> + */
> +int do_posix_clock_thread_gettime(struct timespec *tp)
> +{
> +	jiffies_to_timespec(current->signal->cutime + current->signal->cstime, tp);
> +	return 0;
> +}
> +
> +/*
> + * Single Unix Specification V3:
> + *
> + * Implementations shall also support the special clockid_t value
> + * CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
> + * calling process when invoking one of the clock_*() or timer_*() functions.
> + * For these clock IDs, the values returned by clock_gettime() and specified
> + * by clock_settime() represent the amount of execution time of the process
> + * associated with the clock.
> + */
> +int do_posix_clock_process_gettime(struct timespec *tp)
> +{
> +	unsigned long ticks = 0;
> +	struct task *t;
> +
> +	/* Add up the cpu time for all the threads of this process */
> +	for (t = current; t != current; t = next_thread(p)) {
> +		ticks += t->signal->cutime + t->signal->cstime;
> +	}
> +
> +	jiffies_to_timespec(ticks, tp);
> +	return 0;
> +}
> +
>  asmlinkage long
>  sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
>  {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


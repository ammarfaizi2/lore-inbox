Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUFJBH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUFJBH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUFJBH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:07:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13817 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266085AbUFJBHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:07:16 -0400
Message-ID: <40C7B41F.90307@mvista.com>
Date: Wed, 09 Jun 2004 18:06:39 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hu, Boris" <boris.hu@intel.com>
CC: ganzinger@mvista.com, drepper@redhat.com, "Li, Adam" <adam.li@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
References: <37FBBA5F3A361C41AB7CE44558C3448E045DD47F@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E045DD47F@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hu, Boris wrote:
> One minor update according to your comments. Thanks.

I think the locking is still not right.  We must address these issues.  Either 
with code or a good argument as to why they are not issues.

1.) Getting the timer's value pegged to a given clock set value (done by copying 
wall_to_monotonic to the k_timer struct).,  This must be done under the xtime 
read lock at the same time as the clock is read to set up the timer (i.e. the 
value in k_timer MUST match the value used to set up the timer).

2.) Covering the race between the timer adjustment code and possible POSIX timer 
deletion (done by NOT assuming the timer is there just because we found it in 
the abs timer list, although we do pin it down long enough to get it's ID by 
locking this list).  This also requires us to take the timer lock which means we 
have to drop the abs list lock.

3.) Covering the race between the timer expiring during the system clock setting 
processing.  Done by having the timer call back code verify that the same value 
of wall_to_monotonic is still in play.  Do note also that the timer could expire 
prio to its being put in the abs list.

George


> 
> diff -urN -X dontdiff linux-2.6.6/include/linux/posix-timers.h
> linux-2.6.6.dev/include/linux/posix-timers.h
> --- linux-2.6.6/include/linux/posix-timers.h	2004-06-04
> 15:48:33.000000000 +0800
> +++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-04
> 10:40:10.000000000 +0800
> @@ -1,9 +1,14 @@
>  #ifndef _linux_POSIX_TIMERS_H
>  #define _linux_POSIX_TIMERS_H
>  
> +#include <linux/spinlock.h>
> +#include <linux/list.h>
> +
>  struct k_clock {
>  	int res;		/* in nano seconds */
> -	int (*clock_set) (struct timespec * tp);
> +        struct list_head abs_timer_list;
> +        spinlock_t abs_timer_lock;
> +        int (*clock_set) (struct timespec * tp);
>  	int (*clock_get) (struct timespec * tp);
>  	int (*nsleep) (int flags,
>  		       struct timespec * new_setting,
> diff -urN -X dontdiff linux-2.6.6/include/linux/sched.h
> linux-2.6.6.dev/include/linux/sched.h
> --- linux-2.6.6/include/linux/sched.h	2004-06-04 15:48:33.000000000
> +0800
> +++ linux-2.6.6.dev/include/linux/sched.h	2004-06-04
> 10:39:53.000000000 +0800
> @@ -342,6 +342,8 @@
>  	struct task_struct *it_process;	/* process to send signal to */
>  	struct timer_list it_timer;
>  	struct sigqueue *sigq;		/* signal queue entry. */
> +        struct list_head abs_timer_entry; /* clock abs_timer_list */
> +        struct timespec wall_to_monotonic_prev;
>  };
>  
>  
> diff -urN -X dontdiff linux-2.6.6/kernel/posix-timers.c
> linux-2.6.6.dev/kernel/posix-timers.c
> --- linux-2.6.6/kernel/posix-timers.c	2004-06-04 15:48:33.000000000
> +0800
> +++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-07
> 12:57:28.000000000 +0800
> @@ -7,6 +7,9 @@
>   *
>   *			     Copyright (C) 2002 2003 by MontaVista
> Software.
>   *
> + * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
> + *                           Copyright (C) 2004 Boris Hu
> + *                            
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> (at
> @@ -95,7 +98,7 @@
>  # define set_timer_inactive(tmr) \
>  		do { \
>  			(tmr)->it_timer.entry.prev = (void
> *)TIMER_INACTIVE; \
> -		} while (0)
> +                } while (0)
>  #else
>  # define timer_active(tmr) BARFY	// error to use outside of SMP
>  # define set_timer_inactive(tmr) do { } while (0)
> @@ -200,7 +203,9 @@
>   */
>  static __init int init_posix_timers(void)
>  {
> -	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES };
> +	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
> +                .abs_timer_lock = SPIN_LOCK_UNLOCKED
> 
> +        };
>  	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
>  		.clock_get = do_posix_clock_monotonic_gettime,
>  		.clock_set = do_posix_clock_monotonic_settime
> @@ -212,7 +217,6 @@
>  	posix_timers_cache = kmem_cache_create("posix_timers_cache",
>  					sizeof (struct k_itimer), 0, 0,
> 0, 0);
>  	idr_init(&posix_timers_id);
> -
>  	return 0;
>  }
>  
> @@ -360,6 +364,11 @@
>   	set_timer_inactive(timr);
>  	timer_notify_task(timr);
>  	unlock_timer(timr, flags);
> +        if (CLOCK_REALTIME == timr->it_clock) {
> +
> spin_lock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
> +                list_del_init(&timr->abs_timer_entry);
> +
> spin_unlock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
> +        }        
>  }
>  
>  
> @@ -388,6 +397,7 @@
>  		return;
>  	}
>  	posix_clocks[clock_id] = *new_clock;
> +        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
>  }
>  
>  static struct k_itimer * alloc_posix_timer(void)
> @@ -402,6 +412,7 @@
>  		kmem_cache_free(posix_timers_cache, tmr);
>  		tmr = 0;
>  	}
> +        INIT_LIST_HEAD(&tmr->abs_timer_entry);
>  	return tmr;
>  }
>  
> @@ -787,6 +798,7 @@
>  {
>  	struct k_clock *clock = &posix_clocks[timr->it_clock];
>  	u64 expire_64;
> +        unsigned long seq;
>  
>  	if (old_setting)
>  		do_timer_gettime(timr, old_setting);
> @@ -813,6 +825,11 @@
>  #else
>  	del_timer(&timr->it_timer);
>  #endif
> +        if (CLOCK_REALTIME == timr->it_clock) {
> +                spin_lock(&clock->abs_timer_lock);
> +                list_del_init(&timr->abs_timer_entry);
> +                spin_unlock(&clock->abs_timer_lock);
> +        }
>  	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
>  		~REQUEUE_PENDING;
>  	timr->it_overrun_last = 0;
> @@ -834,7 +851,6 @@
>  	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
>  	timr->it_incr = (unsigned long)expire_64;
>  
> -
>  	/*
>  	 * For some reason the timer does not fire immediately if
> expires is
>  	 * equal to jiffies, so the timer notify function is called
> directly.
> @@ -843,8 +859,21 @@
>  	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
> {
>  		if (timr->it_timer.expires == jiffies)
>  			timer_notify_task(timr);
> -		else
> +		else {
>  			add_timer(&timr->it_timer);
> +                        if (flags & TIMER_ABSTIME &&
> +                            timr->it_clock == CLOCK_REALTIME) {
> +                                spin_lock(&clock->abs_timer_lock);
> +                                do {
> +                                        seq =
> read_seqbegin(&xtime_lock);
> +                                        timr->wall_to_monotonic_prev =
> +                                                wall_to_monotonic;
> +                                } while (read_seqretry(&xtime_lock,
> seq));
> +                                list_add_tail(&(timr->abs_timer_entry),
> +
> &(clock->abs_timer_list));
> +                                spin_unlock(&clock->abs_timer_lock);
> +                        }
> +                }
>  	}
>  	return 0;
>  }
> @@ -875,10 +904,10 @@
>  	if (!timr)
>  		return -EINVAL;
>  
> -	if (!posix_clocks[timr->it_clock].timer_set)
> +	if (!posix_clocks[timr->it_clock].timer_set) 
>  		error = do_timer_settime(timr, flags, &new_spec, rtn);
>  	else
> -		error = posix_clocks[timr->it_clock].timer_set(timr,
> +                error = posix_clocks[timr->it_clock].timer_set(timr,
>  							       flags,
>  
> &new_spec, rtn);
>  	unlock_timer(timr, flag);
> @@ -911,6 +940,11 @@
>  #else
>  	del_timer(&timer->it_timer);
>  #endif
> +        if (CLOCK_REALTIME == timer->it_clock) {
> +
> spin_lock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
> +                list_del_init(&timer->abs_timer_entry);
> +
> spin_unlock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
> +        }        
>  	return 0;
>  }
>  
> @@ -1086,10 +1120,10 @@
>  {
>  	struct timespec new_tp;
>  
> -	if ((unsigned) which_clock >= MAX_CLOCKS ||
> +        if ((unsigned) which_clock >= MAX_CLOCKS ||
>  					!posix_clocks[which_clock].res)
>  		return -EINVAL;
> -	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
> +        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
>  		return -EFAULT;
>  	if (posix_clocks[which_clock].clock_set)
>  		return posix_clocks[which_clock].clock_set(&new_tp);
> @@ -1159,7 +1193,55 @@
>  
>  void clock_was_set(void)
>  {
> +        struct k_clock *clock = &posix_clocks[CLOCK_REALTIME];
> +        struct k_itimer *timr, *tmp;
> +        struct timespec delta;
> +        u64 exp = 0;
> +        unsigned long seq;
> +        
>  	wake_up_all(&nanosleep_abs_wqueue);
> +
> +        /*
> +         * Check if there exist TIMER_ABSTIME timers to correct.
> +         */
> +        if (list_empty(&clock->abs_timer_list))
> +                return;
> +
> +        spin_lock(&clock->abs_timer_lock);
> +        list_for_each_entry_safe(timr, tmp,
> +                                 &clock->abs_timer_list,
> +                                 abs_timer_entry) {
> +                do {
> +                        seq = read_seqbegin(&xtime_lock);
> +                        delta.tv_sec =
> +                                wall_to_monotonic.tv_sec
> +                                - timr->wall_to_monotonic_prev.tv_sec;
> +                        delta.tv_nsec = 
> +                                wall_to_monotonic.tv_nsec
> +                                - timr->wall_to_monotonic_prev.tv_nsec;
> +                } while (read_seqretry(&xtime_lock, seq));
> +                
> +                while (delta.tv_nsec >= NSEC_PER_SEC) {
> +                        delta.tv_sec ++;
> +                        delta.tv_nsec -= NSEC_PER_SEC;
> +                }
> +                while (delta.tv_nsec < 0) {
> +                        delta.tv_sec --;
> +                        delta.tv_nsec += NSEC_PER_SEC;
> +                }
> +                do {
> +                        seq = read_seqbegin(&xtime_lock);
> +                        timr->wall_to_monotonic_prev =
> wall_to_monotonic;
> +                } while (read_seqretry(&xtime_lock, seq));
> +                         
> +                tstojiffie(&delta, clock->res, &exp);
> +                if (del_timer(&timr->it_timer)) { /* the timer has not
> run */
> +                        timr->it_timer.expires += exp; 
> +                        add_timer(&timr->it_timer);
> +                } else 
> +                        list_del_init(&timr->abs_timer_entry);
> +        }
> +        spin_unlock(&clock->abs_timer_lock);
>  }
>  
>  long clock_nanosleep_restart(struct restart_block *restart_block);
> 
> Boris Hu (Hu Jiangtao)
> *****************************************
> There are my thoughts, not my employer's.
> *****************************************
> 
> 
>>>Here is one update version. wall_to_monotonic copy has been moved to
>>>k_itimer. Thanks.
>>
>>As far as it goes...  the update of the k_timer wall_to_monotonic
> 
> should
> 
>>be the
>>same as that which is used to do the correction.  I.e. it should be
> 
> done
> 
>>within
>>the same lock region.
>>
>>I will be out of town till Tuesday or Wed. next week....
>>
>>George
>>>
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUFDR2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUFDR2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUFDR2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:28:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13310 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265891AbUFDRYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:24:04 -0400
Message-ID: <40C0AFC1.1020109@mvista.com>
Date: Fri, 04 Jun 2004 10:22:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hu, Boris" <boris.hu@intel.com>
CC: drepper@redhat.com, "Li, Adam" <adam.li@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
References: <37FBBA5F3A361C41AB7CE44558C3448E045DCE7D@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E045DCE7D@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hu, Boris wrote:
> Here is one update version. wall_to_monotonic copy has been moved to
> k_itimer. Thanks. 

As far as it goes...  the update of the k_timer wall_to_monotonic should be the 
same as that which is used to do the correction.  I.e. it should be done within 
the same lock region.

I will be out of town till Tuesday or Wed. next week....

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
> +++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-04
> 15:48:20.000000000 +0800
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
> +                                do {
> +                                        seq =
> read_seqbegin(&xtime_lock);
> +                                        timr->wall_to_monotonic_prev =
> +                                                wall_to_monotonic;
> +                                } while (read_seqretry(&xtime_lock,
> seq));
> +                                spin_lock(&clock->abs_timer_lock);
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
> 
>>Hu, Boris wrote:
>>
>>>Thanks for your detailed comments. :)
>>>
>>>
>>>
>>>>Hu, Boris wrote:
>>>>
>>>>
>>>>><<posix-abs_timer-bugfix.diff>> George,
>>>>>
>>>>>There is one bug of CLOCK_REALTIME timer reported by Adam at
>>>>>http://sources.redhat.com/ml/libc-alpha/2004-05/msg00177.html.
>>>>>
>>>>>Here is one possible bugfix and it is against linux-2.6.6. All
>>>>>TIMER_ABSTIME cloks will be collected in k_clock struct and updated
>>>
>>>in
>>>
>>>
>>>>>sys_clock_settime. Could you review it? Thanks.
>>>>
>>>>Thanks for the poke :).   Could you make the following changes:
>>>>
>>>>First, put the list in the posix timer structure (k_itimer), not in
>>>>timer_list.
>>>> This means one more dereference when doing things, but it does not
>>>
>>>push
>>>
>>>
>>>>into
>>>>the timer_list structure which is mostly used for other things.
>>>
>>>
>>>Done.
>>>
>>>
>>>
>>>>Second, I don't see the timer being removed from the list (should
>>>
>>>happen
>>>
>>>
>>>>when
>>>>ever it is inactive).  Timers that repeat should be out of the list
>>>
>>>while
>>>
>>>
>>>>waiting for the signal to be picked up and put back in when
> 
> add_timer
> 
>>>is
>>>
>>>
>>>>again
>>>>called.
>>>
>>>
>>>I tried to add the removed codes to set_timer_inactive() but it
> 
> would
> 
>>>trigger a strange oops. I am still investigating on it. Is there any
>>>recommending places except set_timer_inactive()?
>>
>>Hm,  set_timer_inactive() is called from the timer create routine.
> 
> Should
> 
>>not
>>need to remove it here...  Also, this function is used for SMP issues
> 
> and,
> 
>>in
>>some cases (do_timer_settime is one) it is not called if not on an SMP
>>system.
>>Also, it seems not to be called from sys_timer_delete().  This last
> 
> would
> 
>>be a
>>real problem as we are about to return the memory the list runs
> 
> through it.
> 
>>So, I think you will just have to find the places were we delete a
> 
> timer,
> 
>>that
>>and the timer call back function should do it.
>>
>>
>>>
>>>>Also, you should test to see if the clock is one that can be set
> 
> prior
> 
>>>to
>>>
>>>
>>>>putting the timer in the abs timer list.  We must not correct timers
>>>
>>>on
>>>
>>>
>>>>CLOCK_MONOTONIC.
>>>
>>>
>>>
>>>Done.
>>>
>>>
>>>
>>>>Now, for the correction.  Sys_clock_settime() is the wrong place for
>>>
>>>this
>>>
>>>
>>>>as the
>>>>clock can also be set a number of other ways.  The right place is in
>>>>clock_was_set(), which is called if time is set in any of the
> 
> several
> 
>>>ways.
>>>
>>>
>>>>The
>>>>next thing is to determine how far the clock was moved.  I think the
>>>
>>>best
>>>
>>>
>>>>way to
>>>>do this is to keep a copy of the wall_to_monotonic var in a private
>>>>location.
>>>>This should be set to be exactly wall_to_monotonic when the system
> 
> is
> 
>>>>booted (in
>>>>the same function you are setting up the clock lists) and at the end
>>>
>>>of
>>>
>>>
>>>>clock_was_set().  When clock_was_set() is called the difference
>>>
>>>between
>>>
>>>
>>>>this
>>>>value and wall_to_monotonic is exactly how far the clock was moved.
>>>
>>>(Be
>>>
>>>
>>>>careful
>>>>on the sign of this movement.)
>>>>
>>>
>>>
>>>Done.
>>>
>>>
>>>
>>>>Finally, be careful about races.  Timers can expire while
>>>
>>>clock_was_set()
>>>
>>>
>>>>is
>>>>running.  The removal code should take the timer lock as well as the
>>>>abs_time
>>>>list lock (at least I think this would be wise, but I could be wrong
>>>
>>>here).
>>>
>>>
>>>IMHO, we need not take the timer locks. We del_timer() first and if
> 
> the
> 
>>>timer has expired, we simply removed it from the abs_timer_list
> 
> which is
> 
>>>protected by abs_timer_lock.
>>
>>Me thinks you will need to do a bit more to convince me that locks are
> 
> not
> 
>>needed here.  Lets see if I can explain my concerns.
>>
>>First, I think the clock_was_set() function needs to serialize it self
> 
> so
> 
>>only
>>one cpu/ task can be in it at a time.  This, I think, can/is done with
> 
> the
> 
>>abs
>>list lock.
>>
>>Second there is the possibility that a timer in the list will already
> 
> be
> 
>>set via
>>the correct time.  To avoid this possibility I suggest (this is a
> 
> change
> 
>>from my
>>suggestion of yesterday) putting the current value of
> 
> wall_to_monotonic in
> 
>>the
>>k_timer structure when the timer is calculated.  This value must be
>>obtained
>>under the xtime read lock (which we already take to calculate the
> 
> timer).
> 
>>In
>>this way of doing things, clock_was_set() would take the xtime write
> 
> lock,
> 
>>possibly for each entry in the abs list.  It would use the
>>wall_to_monotonic
>>time in the structure rather than keeping a local copy, and it would
>>update that
>>time once the correction was made.
>>
>>We still haven't covered the case where time is set while a timer is
> 
> being
> 
>>set.
>>  I.e. where the expire time is calculated but the result has not yet
> 
> been
> 
>>put
>>in the timer structure and add_timer has not yet been called.  It is
> 
> here
> 
>>that
>>the timer lock would seem to be the right thing to do.  We would
> 
> require
> 
>>that
>>the timer be put in the abs list while the xtime read lock is held
>>(careful here
>>as this is now a sequence lock and we only want to add the timer to
> 
> the
> 
>>list
>>once).  This is complicated.  We must take the locks in the same order
> 
> so
> 
>>we can
>>not take the timer lock while holding the abs list lock.  The, IMHO,
>>simple
>>thing to do is to have clock_was_set() copy the whole abs list (this
> 
> is
> 
>>just a
>>simple pointer manipulation).  Then it can scan this list and move
> 
> each
> 
>>entry to
>>the abs list as it updates the timers.  The timer lock would be taken
> 
> for
> 
>>each
>>timer during this update.  This is to allow timers that are on the way
> 
> to
> 
>>add_timer to get there.  This code should not remove timers from the
> 
> abs
> 
>>list,
>>or rather, each timer it finds in the moved list should be put back in
> 
> the
> 
>>abs
>>list even if it is not in the system timer list (it just means that
>>someone else
>>is removing it).  Both the removal from the moved list and the insert
> 
> into
> 
>>the
>>abs list should be done under the same abs list lock but it must be
>>dropped
>>while taking the timer lock.
>>
>>There is a possible race here with the timer delete code.  Here is how
> 
> I
> 
>>would
>>solve this.  First, with the list being moved, you need only be
> 
> concerned
> 
>>with
>>the first entry in the list (as you will remove it as part of
> 
> processing
> 
>>and
>>then do the next first entry).  So, first lock the abs list.  Then
> 
> find
> 
>>the
>>timer ID for the first entry.  Unlock the abs list, and lock the timer
>>using the
>>ID.  The existing lock code will take care of possible races WRT
> 
> existence.
> 
>>Once the timer is locked, re lock the abs list and if the given timer
> 
> is
> 
>>still
>>the first entry, a.) remove it b.) if the system delete timer fails,
> 
> just
> 
>>take
>>the abs list lock and reinsert the timer, else under the xtime
> 
> readlock
> 
>>compare
>>wall_to_monotonic with the timers value c.) and put it in the abs list
> 
> and
> 
>>the
>>add_timer list.
>>
>>Note that the case of an expired timer that is still in the abs list
> 
> is
> 
>>handled
>>by just reinserting the timer.  This means that the expire call back
> 
> code
> 
>>needs
>>to check for a clock reset that may have made the expire invalid.
>>
>>I am sure there are other ways of doing this, but the main locking
> 
> issues
> 
>>are:
>>
>>1.) Getting the timer's value pegged to a given clock set value (done
> 
> by
> 
>>copying
>>wall_to_monotonic to the k_timer struct).,  This must be done under
> 
> the
> 
>>xtime
>>read lock.
>>
>>2.) Covering the race between the timer adjustment code and possible
> 
> POSIX
> 
>>timer
>>deletion (done by NOT assuming the timer is there just because we
> 
> found it
> 
>>in
>>the abs timer list, although we do pin it down long enough to get it's
> 
> ID
> 
>>by
>>locking this list).  This also requires us to take the timer lock
> 
> which
> 
>>means we
>>have to drop the abs list lock.
>>
>>3.) Covering the race between the timer expiring during the system
> 
> clock
> 
>>setting
>>processing.  Done by having the timer call back code verify that the
> 
> same
> 
>>value
>>of wall_to_monotonic is still in play.
>>
>>We note that the time used for NOW in the repeating timer update needs
> 
> to
> 
>>also
>>satisfy 1. above.
>>
>>And in passing, note that the overrun count will show something going
> 
> on
> 
>>when
>>the clock is moved forward and not when it is move backward.
>>
>>
>>>
>>>>And a minor issue, the community seems to prefer the C comment style
>>>
>>>to
>>>
>>>
>>>>the C++
>>>>style of comments...
>>>>
>>>
>>>
>>>Done.
>>>
>>>
>>>
>>>>Thanks for your effort in this matter.
>>>>
>>>>George
>>>>
>>>>
>>>>>diff -urN -X rt.ia32/base/dontdiff
>>>>>linux-2.6.6/include/linux/posix-timers.h
>>>>>linux-2.6.6.dev/include/linux/posix-timers.h
>>>>>--- linux-2.6.6/include/linux/posix-timers.h	2004-05-10
>>>>>10:32:29.000000000 +0800
>>>>>+++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-02
>>>>>10:30:57.000000000 +0800
>>>>>@@ -1,9 +1,14 @@
>>>>>#ifndef _linux_POSIX_TIMERS_H
>>>>>#define _linux_POSIX_TIMERS_H
>>>>>
>>>>>+#include <linux/list.h>
>>>>>+#include <linux/spinlock.h>
>>>>>+
>>>>>struct k_clock {
>>>>>	int res;		/* in nano seconds */
>>>>>-	int (*clock_set) (struct timespec * tp);
>>>>>+        struct list_head abs_timer_list;
>>>>>+        spinlock_t abs_timer_lock;
>>>>>+        int (*clock_set) (struct timespec * tp);
>>>>>	int (*clock_get) (struct timespec * tp);
>>>>>	int (*nsleep) (int flags,
>>>>>		       struct timespec * new_setting,
>>>>>diff -urN -X rt.ia32/base/dontdiff
> 
> linux-2.6.6/include/linux/timer.h
> 
>>>>>linux-2.6.6.dev/include/linux/timer.h
>>>>>--- linux-2.6.6/include/linux/timer.h	2004-05-10
>>>
>>>10:32:54.000000000
>>>
>>>
>>>>>+0800
>>>>>+++ linux-2.6.6.dev/include/linux/timer.h	2004-06-02
>>>>>19:16:08.000000000 +0800
>>>>>@@ -9,6 +9,7 @@
>>>>>
>>>>>struct timer_list {
>>>>>	struct list_head entry;
>>>>>+	struct list_head abs_timer_entry;
>>>>>	unsigned long expires;
>>>>>
>>>>>	spinlock_t lock;
>>>>>diff -urN -X rt.ia32/base/dontdiff
> 
> linux-2.6.6/kernel/posix-timers.c
> 
>>>>>linux-2.6.6.dev/kernel/posix-timers.c
>>>>>--- linux-2.6.6/kernel/posix-timers.c	2004-05-10
>>>
>>>10:32:37.000000000
>>>
>>>
>>>>>+0800
>>>>>+++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-02
>>>>>19:12:31.000000000 +0800
>>>>>@@ -7,6 +7,9 @@
>>>>> *
>>>>> *			     Copyright (C) 2002 2003 by
> 
> MontaVista
> 
>>>>>Software.
>>>>> *
>>>>>+ * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
>>>>>+ *                           Copyright (C) 2004 Boris Hu
>>>>>+ *
>>>>> * This program is free software; you can redistribute it and/or
>>>
>>>modify
>>>
>>>
>>>>> * it under the terms of the GNU General Public License as
>>>
>>>published by
>>>
>>>
>>>>> * the Free Software Foundation; either version 2 of the License,
>>>
>>>or
>>>
>>>
>>>>>(at
>>>>>@@ -200,7 +203,9 @@
>>>>> */
>>>>>static __init int init_posix_timers(void)
>>>>>{
>>>>>-	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES };
>>>>>+	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
>>>>>+                .abs_timer_lock = SPIN_LOCK_UNLOCKED
>>>>>
>>>>>+        };
>>>>>	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
>>>>>		.clock_get = do_posix_clock_monotonic_gettime,
>>>>>		.clock_set = do_posix_clock_monotonic_settime
>>>>>@@ -388,6 +393,7 @@
>>>>>		return;
>>>>>	}
>>>>>	posix_clocks[clock_id] = *new_clock;
>>>>>+        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
>>>>>}
>>>>>
>>>>>static struct k_itimer * alloc_posix_timer(void)
>>>>>@@ -843,8 +849,15 @@
>>>>>	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
>>>>>{
>>>>>		if (timr->it_timer.expires == jiffies)
>>>>>			timer_notify_task(timr);
>>>>>-		else
>>>>>+		else {
>>>>>			add_timer(&timr->it_timer);
>>>>>+                        if (flags & TIMER_ABSTIME) {
>>>>>+                                spin_lock(&clock->abs_timer_lock);
>>>>>+
>>>>>list_add_tail(&(timr->it_timer.abs_timer_entry),
>>>>>+
>>>>>&(clock->abs_timer_list));
>>>>>+
>>>
>>>spin_unlock(&clock->abs_timer_lock);
>>>
>>>
>>>>>+                        }
>>>>>+                }
>>>>>	}
>>>>>	return 0;
>>>>>}
>>>>>@@ -1085,16 +1098,61 @@
>>>>>sys_clock_settime(clockid_t which_clock, const struct timespec
>>>
>>>__user
>>>
>>>
>>>>>*tp)
>>>>>{
>>>>>	struct timespec new_tp;
>>>>>+        struct timespec before, now;
>>>>>+        struct k_clock *clock;
>>>>>+        long ret;
>>>>>+        struct timer_list *timer, *tmp;
>>>>>+        struct timespec delta;
>>>>>+        u64 exp = 0;
>>>>>
>>>>>-	if ((unsigned) which_clock >= MAX_CLOCKS ||
>>>>>+        if ((unsigned) which_clock >= MAX_CLOCKS ||
>>>>>					!posix_clocks[which_clock].res)
>>>>>		return -EINVAL;
>>>>>-	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
>>>>>+
>>>>>+        clock = &posix_clocks[which_clock];
>>>>>+
>>>>>+        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
>>>>>		return -EFAULT;
>>>>>	if (posix_clocks[which_clock].clock_set)
>>>>>		return posix_clocks[which_clock].clock_set(&new_tp);
>>>>>
>>>>>-	return do_sys_settimeofday(&new_tp, NULL);
>>>>>+        do_posix_gettime(clock, &before);
>>>>>+
>>>>>+	ret = do_sys_settimeofday(&new_tp, NULL);
>>>>>+
>>>>>+        /*
>>>>>+         * Check if there exist TIMER_ABSTIME timers to update.
>>>>>+         */
>>>>>+        if (which_clock != CLOCK_REALTIME ||
>>>>>+            list_empty(&clock->abs_timer_list))
>>>>>+                return ret;
>>>>>+
>>>>>+        do_posix_gettime(clock, &now);
>>>>>+        delta.tv_sec = before.tv_sec - now.tv_sec;
>>>>>+        delta.tv_nsec = before.tv_nsec - now.tv_nsec;
>>>>>+        while (delta.tv_nsec >= NSEC_PER_SEC) {
>>>>>+                delta.tv_sec ++;
>>>>>+                delta.tv_nsec -= NSEC_PER_SEC;
>>>>>+        }
>>>>>+        while (delta.tv_nsec < 0) {
>>>>>+                delta.tv_sec --;
>>>>>+                delta.tv_nsec += NSEC_PER_SEC;
>>>>>+        }
>>>>>+
>>>>>+        tstojiffie(&delta, clock->res, &exp);
>>>>>+
>>>>>+        spin_lock(&(clock->abs_timer_lock));
>>>>>+        list_for_each_entry_safe(timer, tmp,
>>>>>+                                 &clock->abs_timer_list,
>>>>>+                                 abs_timer_entry) {
>>>>>+                if (timer && del_timer(timer)) { //the timer has
>>>
>>>not
>>>
>>>
>>>>>run
>>>>>+                        timer->expires += exp;
>>>>>+                        add_timer(timer);
>>>>>+                } else
>>>>>+                        list_del(&timer->abs_timer_entry);
>>>>>+        }
>>>>>+        spin_unlock(&(clock->abs_timer_lock));
>>>>>+        return ret;
>>>>>}
>>>>>
>>>>>asmlinkage long
>>>>>
>>>>>Good Luck !
>>>>>Boris Hu (Hu Jiangtao)
>>>>>Intel China Software Center
>>>>>86-021-5257-4545#1277
>>>>>iNET: 8-752-1277
>>>>>************************************
>>>>>There are my thoughts, not my employer's.
>>>>>************************************
>>>>>"gpg --recv-keys --keyserver wwwkeys.pgp.net 0FD7685F"
>>>>>{0FD7685F:CFD6 6F5C A2CB 7881 725B  CEA0 956F 9F14 0FD7 685F}
>>>>>
>>>>>
>>>>
>>>>--
>>>>George Anzinger   george@mvista.com
>>>>High-res-timers:  http://sourceforge.net/projects/high-res-timers/
>>>>Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
>>>
>>>
>>>
>>>
>>--
>>George Anzinger   george@mvista.com
>>High-res-timers:  http://sourceforge.net/projects/high-res-timers/
>>Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


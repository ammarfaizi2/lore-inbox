Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUFCJ5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUFCJ5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUFCJ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 05:57:30 -0400
Received: from fmr05.intel.com ([134.134.136.6]:39869 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262114AbUFCJ5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 05:57:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
Date: Thu, 3 Jun 2004 17:56:46 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
Thread-Index: AcRI7e+WXFVVIe9jSHKwtDOqLykLeAAYYucg
From: "Hu, Boris" <boris.hu@intel.com>
To: "George Anzinger" <george@mvista.com>
Cc: <drepper@redhat.com>, "Li, Adam" <adam.li@intel.com>,
       <linux-kernel@vger.kernel.org>, "Hu, Boris" <boris.hu@intel.com>
X-OriginalArrivalTime: 03 Jun 2004 09:56:46.0377 (UTC) FILETIME=[14D30990:01C44951]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your detailed comments. :)

> 
> Hu, Boris wrote:
> >  <<posix-abs_timer-bugfix.diff>> George,
> >
> > There is one bug of CLOCK_REALTIME timer reported by Adam at
> > http://sources.redhat.com/ml/libc-alpha/2004-05/msg00177.html.
> >
> > Here is one possible bugfix and it is against linux-2.6.6. All
> > TIMER_ABSTIME cloks will be collected in k_clock struct and updated
in
> > sys_clock_settime. Could you review it? Thanks.
> 
> Thanks for the poke :).   Could you make the following changes:
> 
> First, put the list in the posix timer structure (k_itimer), not in
> timer_list.
>   This means one more dereference when doing things, but it does not
push
> into
> the timer_list structure which is mostly used for other things.

Done. 

> 
> Second, I don't see the timer being removed from the list (should
happen
> when
> ever it is inactive).  Timers that repeat should be out of the list
while
> waiting for the signal to be picked up and put back in when add_timer
is
> again
> called.

I tried to add the removed codes to set_timer_inactive() but it would
trigger a strange oops. I am still investigating on it. Is there any
recommending places except set_timer_inactive()?

> 
> Also, you should test to see if the clock is one that can be set prior
to
> putting the timer in the abs timer list.  We must not correct timers
on
> CLOCK_MONOTONIC.


Done.

> 
> Now, for the correction.  Sys_clock_settime() is the wrong place for
this
> as the
> clock can also be set a number of other ways.  The right place is in
> clock_was_set(), which is called if time is set in any of the several
ways.
> The
> next thing is to determine how far the clock was moved.  I think the
best
> way to
> do this is to keep a copy of the wall_to_monotonic var in a private
> location.
> This should be set to be exactly wall_to_monotonic when the system is
> booted (in
> the same function you are setting up the clock lists) and at the end
of
> clock_was_set().  When clock_was_set() is called the difference
between
> this
> value and wall_to_monotonic is exactly how far the clock was moved.
(Be
> careful
> on the sign of this movement.)
> 

Done.

> Finally, be careful about races.  Timers can expire while
clock_was_set()
> is
> running.  The removal code should take the timer lock as well as the
> abs_time
> list lock (at least I think this would be wise, but I could be wrong
here).
> 

IMHO, we need not take the timer locks. We del_timer() first and if the
timer has expired, we simply removed it from the abs_timer_list which is
protected by abs_timer_lock. 

> And a minor issue, the community seems to prefer the C comment style
to
> the C++
> style of comments...
> 

Done.

> Thanks for your effort in this matter.
> 
> George
> >
> >
> > diff -urN -X rt.ia32/base/dontdiff
> > linux-2.6.6/include/linux/posix-timers.h
> > linux-2.6.6.dev/include/linux/posix-timers.h
> > --- linux-2.6.6/include/linux/posix-timers.h	2004-05-10
> > 10:32:29.000000000 +0800
> > +++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-02
> > 10:30:57.000000000 +0800
> > @@ -1,9 +1,14 @@
> >  #ifndef _linux_POSIX_TIMERS_H
> >  #define _linux_POSIX_TIMERS_H
> >
> > +#include <linux/list.h>
> > +#include <linux/spinlock.h>
> > +
> >  struct k_clock {
> >  	int res;		/* in nano seconds */
> > -	int (*clock_set) (struct timespec * tp);
> > +        struct list_head abs_timer_list;
> > +        spinlock_t abs_timer_lock;
> > +        int (*clock_set) (struct timespec * tp);
> >  	int (*clock_get) (struct timespec * tp);
> >  	int (*nsleep) (int flags,
> >  		       struct timespec * new_setting,
> > diff -urN -X rt.ia32/base/dontdiff linux-2.6.6/include/linux/timer.h
> > linux-2.6.6.dev/include/linux/timer.h
> > --- linux-2.6.6/include/linux/timer.h	2004-05-10
10:32:54.000000000
> > +0800
> > +++ linux-2.6.6.dev/include/linux/timer.h	2004-06-02
> > 19:16:08.000000000 +0800
> > @@ -9,6 +9,7 @@
> >
> >  struct timer_list {
> >  	struct list_head entry;
> > +	struct list_head abs_timer_entry;
> >  	unsigned long expires;
> >
> >  	spinlock_t lock;
> > diff -urN -X rt.ia32/base/dontdiff linux-2.6.6/kernel/posix-timers.c
> > linux-2.6.6.dev/kernel/posix-timers.c
> > --- linux-2.6.6/kernel/posix-timers.c	2004-05-10
10:32:37.000000000
> > +0800
> > +++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-02
> > 19:12:31.000000000 +0800
> > @@ -7,6 +7,9 @@
> >   *
> >   *			     Copyright (C) 2002 2003 by MontaVista
> > Software.
> >   *
> > + * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
> > + *                           Copyright (C) 2004 Boris Hu
> > + *
> >   * This program is free software; you can redistribute it and/or
modify
> >   * it under the terms of the GNU General Public License as
published by
> >   * the Free Software Foundation; either version 2 of the License,
or
> > (at
> > @@ -200,7 +203,9 @@
> >   */
> >  static __init int init_posix_timers(void)
> >  {
> > -	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES };
> > +	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
> > +                .abs_timer_lock = SPIN_LOCK_UNLOCKED
> >
> > +        };
> >  	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
> >  		.clock_get = do_posix_clock_monotonic_gettime,
> >  		.clock_set = do_posix_clock_monotonic_settime
> > @@ -388,6 +393,7 @@
> >  		return;
> >  	}
> >  	posix_clocks[clock_id] = *new_clock;
> > +        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
> >  }
> >
> >  static struct k_itimer * alloc_posix_timer(void)
> > @@ -843,8 +849,15 @@
> >  	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
> > {
> >  		if (timr->it_timer.expires == jiffies)
> >  			timer_notify_task(timr);
> > -		else
> > +		else {
> >  			add_timer(&timr->it_timer);
> > +                        if (flags & TIMER_ABSTIME) {
> > +                                spin_lock(&clock->abs_timer_lock);
> > +
> > list_add_tail(&(timr->it_timer.abs_timer_entry),
> > +
> > &(clock->abs_timer_list));
> > +
spin_unlock(&clock->abs_timer_lock);
> > +                        }
> > +                }
> >  	}
> >  	return 0;
> >  }
> > @@ -1085,16 +1098,61 @@
> >  sys_clock_settime(clockid_t which_clock, const struct timespec
__user
> > *tp)
> >  {
> >  	struct timespec new_tp;
> > +        struct timespec before, now;
> > +        struct k_clock *clock;
> > +        long ret;
> > +        struct timer_list *timer, *tmp;
> > +        struct timespec delta;
> > +        u64 exp = 0;
> >
> > -	if ((unsigned) which_clock >= MAX_CLOCKS ||
> > +        if ((unsigned) which_clock >= MAX_CLOCKS ||
> >  					!posix_clocks[which_clock].res)
> >  		return -EINVAL;
> > -	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
> > +
> > +        clock = &posix_clocks[which_clock];
> > +
> > +        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
> >  		return -EFAULT;
> >  	if (posix_clocks[which_clock].clock_set)
> >  		return posix_clocks[which_clock].clock_set(&new_tp);
> >
> > -	return do_sys_settimeofday(&new_tp, NULL);
> > +        do_posix_gettime(clock, &before);
> > +
> > +	ret = do_sys_settimeofday(&new_tp, NULL);
> > +
> > +        /*
> > +         * Check if there exist TIMER_ABSTIME timers to update.
> > +         */
> > +        if (which_clock != CLOCK_REALTIME ||
> > +            list_empty(&clock->abs_timer_list))
> > +                return ret;
> > +
> > +        do_posix_gettime(clock, &now);
> > +        delta.tv_sec = before.tv_sec - now.tv_sec;
> > +        delta.tv_nsec = before.tv_nsec - now.tv_nsec;
> > +        while (delta.tv_nsec >= NSEC_PER_SEC) {
> > +                delta.tv_sec ++;
> > +                delta.tv_nsec -= NSEC_PER_SEC;
> > +        }
> > +        while (delta.tv_nsec < 0) {
> > +                delta.tv_sec --;
> > +                delta.tv_nsec += NSEC_PER_SEC;
> > +        }
> > +
> > +        tstojiffie(&delta, clock->res, &exp);
> > +
> > +        spin_lock(&(clock->abs_timer_lock));
> > +        list_for_each_entry_safe(timer, tmp,
> > +                                 &clock->abs_timer_list,
> > +                                 abs_timer_entry) {
> > +                if (timer && del_timer(timer)) { //the timer has
not
> > run
> > +                        timer->expires += exp;
> > +                        add_timer(timer);
> > +                } else
> > +                        list_del(&timer->abs_timer_entry);
> > +        }
> > +        spin_unlock(&(clock->abs_timer_lock));
> > +        return ret;
> >  }
> >
> >  asmlinkage long
> >
> > Good Luck !
> > Boris Hu (Hu Jiangtao)
> > Intel China Software Center
> > 86-021-5257-4545#1277
> > iNET: 8-752-1277
> > ************************************
> > There are my thoughts, not my employer's.
> > ************************************
> > "gpg --recv-keys --keyserver wwwkeys.pgp.net 0FD7685F"
> > {0FD7685F:CFD6 6F5C A2CB 7881 725B  CEA0 956F 9F14 0FD7 685F}
> >
> >
> 
> --
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml



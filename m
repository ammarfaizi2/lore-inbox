Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWJITjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWJITjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWJITjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:39:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:32154 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751893AbWJITjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:39:51 -0400
Subject: Re: [PATCH 05/10] -mm: clocksource: convert generic timeofday
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061006185456.838445000@mvista.com>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.838445000@mvista.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 12:39:45 -0700
Message-Id: <1160422785.5458.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> plain text document attachment (clocksource_more_generic.patch)
> Delete alot of remaining code in kernel/time/clocksource.c that
> is replaced with this patch. Removed the deprecated "clock" kernel
> parameter. 

Hmmm. This patch is a bit more confusing. From first glance it looks
like a lot of code churn for not a whole lot of benefit. And as Thomas
already mentioned, you should probably leave the "clock" bit alone for
now.

> Shifts some of the code around so that the time of day override 
> happens inside kernel/timer.c.

Maybe could you explain your rational for this a bit more. I personally
prefer the current breakdown, where the clocksource selection and
override bits are in the clocksource code.

Currently the layering is like this:
[timekeeping core]
[clocksource core]
[clocksource drivers]

Where timekeeping tries to have as little knowledge as possible of the
details of the clocksource drivers (outside of basic knowledge of how to
use them). To the timekeeping core, all clocksources are the same. It
leaves the selection algorithm and its management up to the clocksource
core.

Now if I understand your intent you seem to be splitting it up a bit:

[timekeeping core]                   [sched_clock code]
[timekeeping clocksource selection]  [sched_clock clocksource selection]
[                          clocksource core                            ]
[                        clocksource drivers                           ]


Where the selection code is moved from the clocksource core into the
timekeeping code. I can understand some of the rational, as timekeeping
and sched_clock have differing selection criteria, so why not have
separate logic and share the clocksource core.

So, here's where I'm coming from on this issue: I feel sched_clock to be
a unfortunately necessary hack. Ideally timekeeping reads should be fast
enough to do from the scheduler, but that just is not the case (just on
most arches, some don't have this problem). And since its just scheduler
decisions, it does not need the correctness that timekeeping needs, so
we have this arch specific hook that does whatever it needs. And since
its sorta simple and stupid, the code duplication is pretty minor (no
NTP adjustments, etc). 

In my mind this reduces the benefit gained from making a generic
sched_clock. Currently the clocksource rating logic for timekeeping is
pretty simple: "weigh correctness first, then consider performance". 

Now to have a generic sched_clock, we're going to have to introduce a
new rating scale, which would select a more vague "speed over
correctness, as long as its totally not insane" logic. To me, it seems a
bit complicated for generic logic.

Thus I prefer having the clocksource core keep the an understanding of
the "correctness first, then performance".

Now, I don't want to discourage your efforts here (BTW: I really
appreciate them, and I think attempting new users for the clocksource
infrastructure will make that infrastructure cleaner and better). It
seems perfectly logical to use the clocksource infrastructure in
sched_clock, but maybe, since sched_clock is the necessary hack that it
is, we can do a more minor cleanup, with less impact to the clocksource
infrastructure?

Maybe an idea just to start, would be to have the arch specific
sched_clock() code use __get_clock(char* name), with its internal
selection logic based on the clocksource names. This will then have
minor impact on the current timekeeping/clocksource core code, but still
allow for some reduction in code duplication. Then as hardware
clocksources are tested for viability (for example, HPET may be a good
bet here, but ACPI PM would not), we can add that logic to the arch
specific sched_clock code.

Sound reasonable?


Anyway, that was a bit long winded. I apologize. More specific comments
below:

> The biggest timeofday changes are in update_wall_time() and
> change_clocksource(). I removed the unconditional call to 
> change_clocksource(), and replaced it with a single atomic
> check. The atomic is asserted only when a clock change is
> needed. update_callback is no longer driven from 
> update_wall_time().
> 
> The fast path is now a single atomic check.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> ---
>  include/linux/clocksource.h |    3 
>  kernel/time/clocksource.c   |  216 ++++++--------------------------------------
>  kernel/timer.c              |  167 +++++++++++++++++++++++++++++-----
>  3 files changed, 178 insertions(+), 208 deletions(-)
> 
> Index: linux-2.6.18/include/linux/clocksource.h
> ===================================================================
> --- linux-2.6.18.orig/include/linux/clocksource.h
> +++ linux-2.6.18/include/linux/clocksource.h
> @@ -205,7 +205,8 @@ static inline void clocksource_calculate
>  
> 
>  /* used to install a new clocksource */
> -extern struct clocksource *clocksource_get_next(void);
> +extern int clocksource_sysfs_register(struct sysdev_attribute*);
> +extern void clocksource_sysfs_unregister(struct sysdev_attribute*);
>  extern int clocksource_register(struct clocksource*);
>  extern void clocksource_rating_change(struct clocksource*);
>  extern struct clocksource * clocksource_get_clock(char*);
> Index: linux-2.6.18/kernel/time/clocksource.c
> ===================================================================
> --- linux-2.6.18.orig/kernel/time/clocksource.c
> +++ linux-2.6.18/kernel/time/clocksource.c
> @@ -5,6 +5,8 @@
>   *
>   * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
>   *
> + * Copyright (C) 2006 MontaVista Daniel Walker (dwalker@mvista.com)
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -21,7 +23,6 @@
>   *
>   * TODO WishList:
>   *   o Allow clocksource drivers to be unregistered
> - *   o get rid of clocksource_jiffies extern
>   */
>  
>  #include <linux/clocksource.h>
> @@ -29,45 +30,15 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  
> -/* XXX - Would like a better way for initializing curr_clocksource */
> -extern struct clocksource clocksource_jiffies;
> -
>  /*[Clocksource internal variables]---------
> - * curr_clocksource:
> - *	currently selected clocksource. Initialized to clocksource_jiffies.
> - * next_clocksource:
> - *	pending next selected clocksource.
>   * clocksource_list:
>   *	priority list with the registered clocksources
>   * clocksource_lock:
> - *	protects manipulations to curr_clocksource and next_clocksource
> - *	and the clocksource_list
> - * override_name:
> - *	Name of the user-specified clocksource.
> + * 	protects manipulations to the clocksource_list
>   */
> -static struct clocksource *curr_clocksource = &clocksource_jiffies;
> -static struct clocksource *next_clocksource;
> -static struct list_head clocksource_list = LIST_HEAD_INIT(clocksource_list);
> +static __read_mostly
> +struct list_head clocksource_list = LIST_HEAD_INIT(clocksource_list);
>  static DEFINE_SPINLOCK(clocksource_lock);
> -static char override_name[32];
> -
> -/**
> - * clocksource_get_next - Returns the selected clocksource
> - *
> - */
> -struct clocksource *clocksource_get_next(void)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&clocksource_lock, flags);
> -	if (next_clocksource) {
> -		curr_clocksource = next_clocksource;
> -		next_clocksource = NULL;
> -	}
> -	spin_unlock_irqrestore(&clocksource_lock, flags);
> -
> -	return curr_clocksource;
> -}
>  
>  /**
>   * __is_registered - Returns a clocksource if it's registered
> @@ -95,28 +66,6 @@ static struct clocksource * __is_registe
>  }
>  
>  /**
> - * __get_clock - Finds a specific clocksource
> - * @name:		name of the clocksource to return
> - *
> - * Private function. Must hold clocksource_lock when called.
> - *
> - * Returns the clocksource if registered, zero otherwise.
> - * If the @name is null the highest rated clock is returned.
> - */
> -static inline struct clocksource * __get_clock(char * name)
> -{
> -
> -	if (unlikely(list_empty(&clocksource_list)))
> -		return &clocksource_jiffies;
> -
> -	if (!name)
> -		return list_entry(clocksource_list.next,
> -				  struct clocksource, list);
> -
> -	return __is_registered(name);
> -}
> -

Errr.. Wasn't this function just added in the last patch? Can we reduce
the churn here a bit?


> -/**
>   * clocksource_get_clock - Finds a specific clocksource
>   * @name:		name of the clocksource to return
>   *
> @@ -128,29 +77,17 @@ struct clocksource * clocksource_get_clo
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&clocksource_lock, flags);
> -	ret = __get_clock(name);
> +	if (unlikely(list_empty(&clocksource_list)))
> +		ret = &clocksource_jiffies;
> +	else if (!name)
> +		ret = list_entry(clocksource_list.next,
> +				 struct clocksource, list);
> +	else
> +		ret = __is_registered(name);
>  	spin_unlock_irqrestore(&clocksource_lock, flags);
>  	return ret;
>  }
>  

[snip]

> @@ -952,10 +1061,26 @@ static void update_wall_time(void)
>  	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
>  
>  	/* check to see if there is a new clocksource to use */
> -	if (change_clocksource()) {
> +	if (unlikely(atomic_read(&clock_check))) {
> +
> +		/*
> +		 * Switch to the new override clock, or the highest
> +		 * rated clock.
> +		 */
> +		if (*clock_override_name)
> +			change_clocksource(clock_override_name);
> +		else
> +			change_clocksource(NULL);
> +
>  		clock->error = 0;
>  		clock->xtime_nsec = 0;
>  		clocksource_calculate_interval(clock, tick_nsec);
> +
> +		/*
> +		 * Remove the change signal
> +		 */
> +		atomic_dec(&clock_check);
> +
>  	}
>  }
>  
I think this last chunk (changing the clocksource switching logic) has
some potential. Mind breaking it out into a separate patch?

thanks
-john



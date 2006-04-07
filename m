Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWDGSjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWDGSjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWDGSjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:39:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17118 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964855AbWDGSjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:39:05 -0400
Subject: Re: [PATCH 1/5] generic clocksource updates
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 11:38:42 -0700
Message-Id: <1144435123.2745.88.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 21:55 +0200, Roman Zippel wrote:
> A number of changes to the clocksource infrastructur:
> - use xtime_lock instead of clocksource_lock, so it's easier to
>   synchronize the clocksource switch for gettimeofday.

I'm not sure I understand the benefit of this. Could you explain?

> - add a few clock state variables (instead of making them global).

This goes against some of my goals for keeping the clocksource stupid
and simple (just a method for hardware access), so I don't know if I
view this as a good change. Most of the global variables it replaces
were static to a single function. Could you explain the rational a bit?

More on this below.

> - clocksource_get_nsec_offset(): this should become clocksource specific
>   later.
> - select_clocks: immediately switch clocksource.

Again, why is this desired?

> - cleanup naming to put the subsystem name in front

Most of these I can agree with.  :)


>  include/linux/clocksource.h |   33 +++++++-------
>  kernel/Makefile             |    1 
>  kernel/time/clocksource.c   |   99 +++++++++++++++++---------------------------
>  kernel/time/jiffies.c       |   16 ++++---
>  4 files changed, 67 insertions(+), 82 deletions(-)
> 
> Index: linux-2.6-mm/include/linux/clocksource.h
> ===================================================================
> --- linux-2.6-mm.orig/include/linux/clocksource.h	2006-04-02 06:53:29.000000000 +0200
> +++ linux-2.6-mm/include/linux/clocksource.h	2006-04-02 16:12:28.000000000 +0200
> @@ -45,9 +45,8 @@ typedef u64 cycle_t;
>   * @mult:		cycle to nanosecond multiplier
>   * @shift:		cycle to nanosecond divisor (power of two)
>   * @update_callback:	called when safe to alter clocksource values
> - * @is_continuous:	defines if clocksource is free-running.
> - * @interval_cycles:	Used internally by timekeeping core, please ignore.
> - * @interval_snsecs:	Used internally by timekeeping core, please ignore.
> + * @cycle_update:	Used internally by timekeeping core, please ignore.
> + * @xtime_update:	Used internally by timekeeping core, please ignore.

I don't think cycle_update/xtime_update are very clear variable names.
The interval_cycles/snsecs are the per-interval cycle and shifted
nanosecond components. Could you explain what you feel makes yours more
clear?


>  struct clocksource {
>  	char *name;
> @@ -58,11 +57,11 @@ struct clocksource {
>  	u32 mult;
>  	u32 shift;
>  	int (*update_callback)(void);
> -	int is_continuous;
>  
>  	/* timekeeping specific data, ignore */
> -	cycle_t interval_cycles;
> -	u64 interval_snsecs;
> +	u64 cycles_last, cycle_update;
> +	u64 xtime_nsec, xtime_update;
> +	s64 ntp_error;

My opinion: These add very timekeeping specific state values to the
clocksource structure. In my initial design, the clocksource structures
have no idea what they might be used for, so they only provide
information about the hardware. In my mind, this avoids mixing
functionality between files and makes the code easier to read. So I'd
prefer to keep it more limited (even going as far as removing the
interval_xxx units) to keep the clocksource structure from having any
timekeeping data in it.

Could you maybe provide more info why this information should be stored
in the clocksource structure instead of keeping it in the timekeeping
code?

Also again, the names are not clear and there isn't much documentation
as to what these values are. For example, xtime_nsec: it isn't even a
nsec value (its a shifted nanosecond value), so it doesn't make much
sense at all.

> Index: linux-2.6-mm/kernel/time/clocksource.c
> ===================================================================
> --- linux-2.6-mm.orig/kernel/time/clocksource.c	2006-04-02 06:53:29.000000000 +0200
> +++ linux-2.6-mm/kernel/time/clocksource.c	2006-04-02 16:11:28.000000000 +0200
> @@ -35,57 +35,28 @@ extern struct clocksource clocksource_ji
>  /*[Clocksource internal variables]---------
>   * curr_clocksource:
>   *	currently selected clocksource. Initialized to clocksource_jiffies.
> - * next_clocksource:
> - *	pending next selected clocksource.
>   * clocksource_list:
>   *	linked list with the registered clocksources
> - * clocksource_lock:
> - *	protects manipulations to curr_clocksource and next_clocksource
> - *	and the clocksource_list
>   * override_name:
>   *	Name of the user-specified clocksource.
>   */
> -static struct clocksource *curr_clocksource = &clocksource_jiffies;
> -static struct clocksource *next_clocksource;
> +struct clocksource *curr_clocksource = &clocksource_jiffies;
>  static LIST_HEAD(clocksource_list);
> -static DEFINE_SPINLOCK(clocksource_lock);
>  static char override_name[32];
> -static int finished_booting;

Again, why is it necessary to switch the clocksources here? It is what
forces all of the timekeeping code to be mingled in the clocksource
management. I think the way I did it was pretty clean, limiting
clocksource.c to only registration and selection of a clocksource. Now
we have timekeeping code in clocksource.c too? What is the gain here?

Also, why do you want to protect the list of clocksources w/
xtime_lock? 

thanks
-john


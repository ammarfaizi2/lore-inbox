Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSI0BnL>; Thu, 26 Sep 2002 21:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSI0BnL>; Thu, 26 Sep 2002 21:43:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:26544 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261599AbSI0BnJ>;
	Thu, 26 Sep 2002 21:43:09 -0400
Subject: Re: [PATCH] High-res-timers part 2 (x86 platform code)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
In-Reply-To: <3D93A379.23E82DAF@mvista.com>
References: <3D93A379.23E82DAF@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Sep 2002 18:42:51 -0700
Message-Id: <1033090971.930.114.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 17:16, george anzinger wrote:
> This patch, in conjunction with the "core" high-res-timers
> patch implements high resolution timers on the i386
> platforms.  The high-res-timers use the periodic interrupt
> to "remind" the system to look at the clock.  The clock
> should be relatively high resolution (1 micro second or
> better).  This patch allows configuring of three possible
> clocks, the TSC, the ACPM pm timer, or the Programmable
> interrupt timer (PIT).  Most of the changes in this patch
> are in the arch/i386/time.c code.
> 
> With this patch applied and enabled (at config time in the
> processor feature section), the system clock will be the
> specified clock.  The PIT is not used to keep track of time,
> but only to remind the system to look at the clock.  Sub
> jiffies are kept and available for code that knows how to
> use them.


Looks very cool. There are a couple of nice cleanups that I feel could
be submitted outside the scope of this patch. However if this just goes
in it won't really matter. Anyway, I'll point them out below just in
case this doesn't slip right in. 

<snip>
> diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.38-bk5-core/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
> --- linux-2.5.38-bk5-core/arch/i386/kernel/time.c	Thu Sep 26 11:24:58 2002
> +++ linux/arch/i386/kernel/time.c	Thu Sep 26 16:01:11 2002
<snip>
> +/*
> + * We have three of these do_xxx_gettimeoffset() routines:
> + * do_fast_gettimeoffset(void) for TSC systems with out high-res-timers
> + * do_slow_gettimeoffset(void) for ~TSC systems with out high-res-timers
> + * do_highres__gettimeoffset(void) for systems with high-res-timers
> + *
> + * Pick the desired one at compile time...
> + */
<snip>
> -#ifndef CONFIG_X86_TSC
> -
> +#if  ! defined(CONFIG_HIGH_RES_TIMERS) && ! defined(CONFIG_X86_TSC)

Well, first a plug. My timer-changes patch makes most of this ugliness
go away. I'll clean it up should your code go in first, however do take
a look at the way I'm abstracting out the timer_ops structure. I'm sure
you have some insights as to what extra interfaces could be useful. 


> @@ -240,16 +272,25 @@
>  	read_lock_irqsave(&xtime_lock, flags);
>  	usec = do_gettimeoffset();
>  	{
> +                /*
> +                 * FIX ME***** Due to adjtime and such
> +                 * this should be changed to actually update
> +                 * wall time using the proper routine.
> +                 * Otherwise we run the risk of time moving
> +                 * backward due to different interpretations
> +                 * of the jiffie.  I.e jiffie != 1/HZ
> +                 * (but it is close).
> +                 */
>  		unsigned long lost = jiffies - wall_jiffies;
>  		if (lost)
> -			usec += lost * (1000000 / HZ);
> +			usec += lost * (USEC_PER_SEC / HZ);
>  	}
>  	sec = xtime.tv_sec;
>  	usec += (xtime.tv_nsec / 1000);
>  	read_unlock_irqrestore(&xtime_lock, flags);
>  
> -	while (usec >= 1000000) {
> -		usec -= 1000000;
> +	while (usec >= USEC_PER_SEC) {
> +		usec -= USEC_PER_SEC;
>  		sec++;
>  	}
>  
> @@ -267,10 +308,10 @@
>  	 * made, and then undo it!
>  	 */
>  	tv->tv_usec -= do_gettimeoffset();
> -	tv->tv_usec -= (jiffies - wall_jiffies) * (1000000 / HZ);
> +	tv->tv_usec -= (jiffies - wall_jiffies) * (USEC_PER_SEC / HZ);
>  
>  	while (tv->tv_usec < 0) {
> -		tv->tv_usec += 1000000;
> +		tv->tv_usec += USEC_PER_SEC;
>  		tv->tv_sec--;
>  	}

These look like very good just general cleanups


> @@ -439,6 +474,10 @@
>  		 * the same time. We do the RDTSC stuff first, since it's
>  		 * faster. To avoid any inconsistencies, we need interrupts
>  		 * disabled locally.
> +                 * Note: It is dumb to put the spin_lock() between these two
> +                 * operations since we are trying to sync the two clocks.
> +                 * Also, the rdtscl is so fast, know one will know the
> +                 * difference.
>  		 */
>  
>  		/*
> @@ -446,11 +485,11 @@
>  		 * has the SA_INTERRUPT flag set. -arca
>  		 */
>  	
> -		/* read Pentium cycle counter */
>  
> +		spin_lock(&i8253_lock);
> +		/* read Pentium cycle counter */
>  		rdtscl(last_tsc_low);
>  
> -		spin_lock(&i8253_lock);
>  		outb_p(0x00, 0x43);     /* latch the count ASAP */
>  
>  		count = inb_p(0x40);    /* read the latched count */

This should def go in! Grabbing a lock in between isn't smart. 
Very good fix!


There are probably more, but I gotta' get home. 
I'll look at it more later. 

very cool, though. 
thanks
-john


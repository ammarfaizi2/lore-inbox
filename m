Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTFULh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTFULh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:37:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64764 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265142AbTFULhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:37:18 -0400
Message-ID: <3EF44680.10302@mvista.com>
Date: Sat, 21 Jun 2003 04:50:24 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: lkml <linux-kernel@vger.kernel.org>, Christian Kujau <evil@g-house.de>,
       Daniel Whitener <dwhitener@defeet.com>, johnstul@us.ibm.com,
       Clemens Schwaighofer <cs@tequila.co.jp>,
       Alex Goddard <agoddard@purdue.edu>
Subject: Re: [patch] fix wrong uptime on non-i386 platforms
References: <Pine.LNX.4.33.0306211002400.9843-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0306211002400.9843-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Fri, 20 Jun 2003, george anzinger wrote:
> 
> 
>>Tim Schmielau wrote:
>>
>>>Here are most of the missing wall_to_monotonic initializations that the
>>>non-i386 architectures still need to pick up.
>>>This should fix the reported uptime inconsistencies.
>>>
>>>Disclaimer: completely untested, since I don't have (most of) the hardware.
>>>
> 
> [...]
> 
>>>--- linux-2.5.72/arch/parisc/kernel/time.c	Fri Jun 20 23:25:45 2003
>>>+++ linux-2.5.72-ufix/arch/parisc/kernel/time.c	Fri Jun 20 23:37:10 2003
>>>@@ -242,7 +242,9 @@
>>> 	if(pdc_tod_read(&tod_data) == 0) {
>>> 		write_seqlock_irq(&xtime_lock);
>>> 		xtime.tv_sec = tod_data.tod_sec;
>>>+		wall_to_monotonic.tv_sec = -xtime.tv_sec;
>>> 		xtime.tv_nsec = tod_data.tod_usec * 1000;
>>>+		wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
>>> 		write_sequnlock_irq(&xtime_lock);
>>> 	} else {
>>> 		printk(KERN_ERR "Error reading tod clock\n");
>>
>>This one should normalize wall_to_monotonic so that nsec >= 0 and <
>>NSEC_PER_SEC.
> 
> 
> Valid point. Shouldn't i386 (that I blindly copied) also normalize, then?

Uh, I think I missed the initial set up.  If tv_nsec is not changed it 
is not needed.
> 
> This time I also added the missing bits to do_settimeofday() for
> architectures that don't yet know about wall_to_monotonic.

Looks like you missed the normalize on the s390 initial set up. 
Otherwise it looks good.

-g

> Disclaimer: previous disclaimer still applies
> 
> Tim
> 
> --- linux-2.5.72/arch/i386/kernel/time.c	Sat Jun 21 08:58:54 2003
> +++ linux-2.5.72-ufix/arch/i386/kernel/time.c	Sat Jun 21 09:11:36 2003
> @@ -306,10 +306,13 @@
>  {
> 
>  	xtime.tv_sec = get_cmos_time();
> -	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> -	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
> 
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	if (xtime.tv_nsec != 0) {
> +		wall_to_monotonic.tv_nsec = NSEC_PER_SEC - xtime.tv_nsec;
> +		wall_to_monotonic.tv_sec--;
> +	}
> 
>  	timer = select_timer();
>  	time_init_hook();
> 
> --- linux-2.5.72/arch/alpha/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/alpha/kernel/time.c	Sat Jun 21 09:55:11 2003
> @@ -371,6 +371,8 @@
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
>  	xtime.tv_nsec = 0;
> 
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +
>  	if (HZ > (1<<16)) {
>  		extern void __you_loose (void);
>  		__you_loose();
> @@ -478,6 +480,18 @@
>  		nsec += NSEC_PER_SEC;
>  		sec -= 1;
>  	}
> +
> +	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	xtime.tv_sec = sec;
>  	xtime.tv_nsec = nsec;
> 
> --- linux-2.5.72/arch/m68k/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/m68k/kernel/time.c	Sat Jun 21 09:22:31 2003
> @@ -102,6 +102,8 @@
>  		xtime.tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
>  				      time.tm_hour, time.tm_min, time.tm_sec);
>  		xtime.tv_nsec = 0;
> +
> +		wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	}
> 
>  	mach_sched_init(timer_interrupt);
> @@ -159,6 +161,18 @@
>  		tv->tv_nsec += NSEC_PER_SEC;
>  		tv->tv_sec--;
>  	}
> +
> +        wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	xtime.tv_sec = tv->tv_sec;
>  	xtime.tv_nsec = tv->tv_nsec;
> 
> --- linux-2.5.72/arch/m68knommu/kernel/time.c	Sat Jun 14 21:18:24 2003
> +++ linux-2.5.72-ufix/arch/m68knommu/kernel/time.c	Sat Jun 21 09:27:48 2003
> @@ -131,6 +131,8 @@
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
>  	xtime.tv_nsec = 0;
> 
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +
>  	mach_sched_init(timer_interrupt);
>  }
> 
> @@ -178,6 +180,18 @@
>  		tv->tv_usec += 1000000;
>  		tv->tv_sec--;
>  	}
> +
> +        wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	xtime.tv_sec = tv->tv_sec;
>  	xtime.tv_nsec = (tv->tv_usec * 1000);
> 
> --- linux-2.5.72/arch/parisc/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/parisc/kernel/time.c	Sat Jun 21 09:52:21 2003
> @@ -210,6 +210,18 @@
>  			tv->tv_sec--;
>  		}
> 
> +		wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +	        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +		if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +        	        wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                	wall_to_monotonic.tv_sec++;
> +	        }
> +        	if (wall_to_monotonic.tv_nsec < 0) {
> +                	wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +	                wall_to_monotonic.tv_sec--;
> +        	}
> +
>  		xtime.tv_sec = tv->tv_sec;
>  		xtime.tv_nsec = tv->tv_nsec;
>  		time_adjust = 0;		/* stop active adjtime() */
> @@ -241,8 +253,16 @@
> 
>  	if(pdc_tod_read(&tod_data) == 0) {
>  		write_seqlock_irq(&xtime_lock);
> +
>  		xtime.tv_sec = tod_data.tod_sec;
>  		xtime.tv_nsec = tod_data.tod_usec * 1000;
> +
> +		wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +		if (xtime.tv_nsec != 0) {
> +	                wall_to_monotonic.tv_nsec = NSEC_PER_SEC-xtime.tv_nsec;
> +	                wall_to_monotonic.tv_sec--;
> +        	}
> +
>  		write_sequnlock_irq(&xtime_lock);
>  	} else {
>  		printk(KERN_ERR "Error reading tod clock\n");
> 
> --- linux-2.5.72/arch/ppc/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/ppc/kernel/time.c	Sat Jun 21 09:40:20 2003
> @@ -276,6 +276,16 @@
>  	}
>  	xtime.tv_nsec = new_nsec;
>  	xtime.tv_sec = new_sec;
> +	wall_to_monotonic.tv_sec += xtime.tv_sec - new_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - new_nsec;
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	/* In case of a large backwards jump in time with NTP, we want the
>  	 * clock to be updated as soon as the PLL is again in lock.
> @@ -333,6 +343,7 @@
>  			printk("Warning: real time clock seems stuck!\n");
>  		xtime.tv_sec = sec;
>  		xtime.tv_nsec = 0;
> +		wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  		/* No update now, we just read the time from the RTC ! */
>  		last_rtc_update = xtime.tv_sec;
>  	}
> 
> --- linux-2.5.72/arch/ppc64/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/ppc64/kernel/time.c	Sat Jun 21 09:41:44 2003
> @@ -372,6 +372,16 @@
>  	}
>  	xtime.tv_nsec = new_nsec;
>  	xtime.tv_sec = new_sec;
> +	wall_to_monotonic.tv_sec += xtime.tv_sec - new_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - new_nsec;
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	/* In case of a large backwards jump in time with NTP, we want the
>  	 * clock to be updated as soon as the PLL is again in lock.
> @@ -468,6 +478,7 @@
>  	write_seqlock_irqsave(&xtime_lock, flags);
>  	xtime.tv_sec = mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>  			      tm.tm_hour, tm.tm_min, tm.tm_sec);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	tb_last_stamp = get_tb();
>  	do_gtod.tb_orig_stamp = tb_last_stamp;
>  	do_gtod.varp = &do_gtod.vars[0];
> 
> 
> --- linux-2.5.72/arch/sh/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/sh/kernel/time.c	Sat Jun 21 09:44:26 2003
> @@ -171,6 +171,18 @@
>  		tv->tv_sec--;
>  	}
> 
> +	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> +
>  	xtime = *tv;
>  	time_adjust = 0;		/* stop active adjtime() */
>  	time_status |= STA_UNSYNC;
> @@ -367,6 +379,11 @@
>  #endif
> 
>  	rtc_gettimeofday(&xtime);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	if (xtime.tv_nsec != 0) {
> +                wall_to_monotonic.tv_nsec = NSEC_PER_SEC - xtime.tv_nsec;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	setup_irq(TIMER_IRQ, &irq0);
> 
> 
> --- linux-2.5.72/arch/sparc/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/sparc/kernel/time.c	Sat Jun 21 09:46:06 2003
> @@ -408,9 +408,12 @@
>  	mon = MSTK_REG_MONTH(mregs);
>  	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
> -	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
>  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> -	wall_to_monotonic.tv_nsec = 0;
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	if (xtime.tv_nsec != 0) {
> +                wall_to_monotonic.tv_nsec = NSEC_PER_SEC - xtime.tv_nsec;
> +                wall_to_monotonic.tv_sec--;
> +        }
>  	mregs->creg &= ~MSTK_CREG_READ;
>  	spin_unlock_irq(&mostek_lock);
>  #ifdef CONFIG_SUN4
> 
> --- linux-2.5.72/arch/sparc64/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/sparc64/kernel/time.c	Sat Jun 21 09:46:35 2003
> @@ -703,9 +703,12 @@
>  	}
> 
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
> -	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
>  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> -	wall_to_monotonic.tv_nsec = 0;
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	if (xtime.tv_nsec != 0) {
> +                wall_to_monotonic.tv_nsec = NSEC_PER_SEC - xtime.tv_nsec;
> +                wall_to_monotonic.tv_sec--;
> +        }
> 
>  	if (mregs) {
>  		tmp = mostek_read(mregs + MOSTEK_CREG);
> 
> --- linux-2.5.72/arch/x86_64/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/x86_64/kernel/time.c	Sat Jun 21 09:48:14 2003
> @@ -137,6 +137,18 @@
>  		tv->tv_sec--;
>  	}
> 
> +	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> +
>  	xtime.tv_sec = tv->tv_sec;
>  	xtime.tv_nsec = tv->tv_nsec;
> 
> @@ -543,6 +555,8 @@
> 
>  	xtime.tv_sec = get_cmos_time();
>  	xtime.tv_nsec = 0;
> +
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> 
>  	if (!hpet_init()) {
>                  vxtime_hz = (1000000000000000L + hpet_period / 2) /
> 
> --- linux-2.5.72/arch/s390/kernel/time.c	Sat Jun 21 08:56:38 2003
> +++ linux-2.5.72-ufix/arch/s390/kernel/time.c	Sat Jun 21 10:01:03 2003
> @@ -121,6 +121,18 @@
>  		tv->tv_sec--;
>  	}
> 
> +	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
> +        wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
> +
> +        if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
> +                wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec++;
> +        }
> +        if (wall_to_monotonic.tv_nsec < 0) {
> +                wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
> +                wall_to_monotonic.tv_sec--;
> +        }
> +
>  	xtime.tv_sec = tv->tv_sec;
>  	xtime.tv_nsec = tv->tv_nsec;
>  	time_adjust = 0;		/* stop active adjtime() */
> @@ -263,6 +275,8 @@
>  	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
>  		(0x3c26700LL*1000000*4096);
>          tod_to_timeval(set_time_cc, &xtime);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;

Oops! Missed this one.
> 
>          /* request the 0x1004 external interrupt */
>          if (register_early_external_interrupt(0x1004, do_comparator_interrupt,
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


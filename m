Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTFTXKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFTXKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:10:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46068 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265024AbTFTXKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:10:02 -0400
Message-ID: <3EF39757.3020909@mvista.com>
Date: Fri, 20 Jun 2003 16:23:03 -0700
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
References: <Pine.LNX.4.33.0306202341050.7684-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0306202341050.7684-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> Here are most of the missing wall_to_monotonic initializations that the
> non-i386 architectures still need to pick up.
> This should fix the reported uptime inconsistencies.
> 
> Disclaimer: completely untested, since I don't have (most of) the hardware.
> 
> Tim
> 
> --- linux-2.5.72/arch/alpha/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/alpha/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -369,6 +369,7 @@
>  		year += 100;
> 
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	xtime.tv_nsec = 0;
> 
>  	if (HZ > (1<<16)) {
> 
> --- linux-2.5.72/arch/m68k/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/m68k/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -101,6 +101,7 @@
>  			time.tm_year += 100;
>  		xtime.tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
>  				      time.tm_hour, time.tm_min, time.tm_sec);
> +		wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  		xtime.tv_nsec = 0;
>  	}
> 
> 
> --- linux-2.5.72/arch/m68knommu/kernel/time.c	Sat Jun 14 21:18:24 2003
> +++ linux-2.5.72-ufix/arch/m68knommu/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -129,6 +129,7 @@
>  	if ((year += 1900) < 1970)
>  		year += 100;
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	xtime.tv_nsec = 0;
> 
>  	mach_sched_init(timer_interrupt);
> 
> --- linux-2.5.72/arch/parisc/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/parisc/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -242,7 +242,9 @@
>  	if(pdc_tod_read(&tod_data) == 0) {
>  		write_seqlock_irq(&xtime_lock);
>  		xtime.tv_sec = tod_data.tod_sec;
> +		wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  		xtime.tv_nsec = tod_data.tod_usec * 1000;
> +		wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
>  		write_sequnlock_irq(&xtime_lock);
>  	} else {
>  		printk(KERN_ERR "Error reading tod clock\n");

This one should normalize wall_to_monotonic so that nsec >= 0 and < 
NSEC_PER_SEC.
> 
> --- linux-2.5.72/arch/ppc/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/ppc/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -332,6 +332,7 @@
>  		if (sec==old_sec)
>  			printk("Warning: real time clock seems stuck!\n");
>  		xtime.tv_sec = sec;
> +		wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  		xtime.tv_nsec = 0;
>  		/* No update now, we just read the time from the RTC ! */
>  		last_rtc_update = xtime.tv_sec;
> 
> --- linux-2.5.72/arch/ppc64/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/ppc64/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -468,6 +468,7 @@
>  	write_seqlock_irqsave(&xtime_lock, flags);
>  	xtime.tv_sec = mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>  			      tm.tm_hour, tm.tm_min, tm.tm_sec);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	tb_last_stamp = get_tb();
>  	do_gtod.tb_orig_stamp = tb_last_stamp;
>  	do_gtod.varp = &do_gtod.vars[0];
> 
> --- linux-2.5.72/arch/s390/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/s390/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -263,6 +263,8 @@
>  	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
>  		(0x3c26700LL*1000000*4096);
>          tod_to_timeval(set_time_cc, &xtime);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
> 
This one also needs to normalize.
>          /* request the 0x1004 external interrupt */
>          if (register_early_external_interrupt(0x1004, do_comparator_interrupt,
> 
> --- linux-2.5.72/arch/sh/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/sh/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -367,6 +367,8 @@
>  #endif
> 
>  	rtc_gettimeofday(&xtime);
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
> +	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
This one also needs to normalize.
> 
>  	setup_irq(TIMER_IRQ, &irq0);
> 
> 
> --- linux-2.5.72/arch/sparc/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/sparc/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -408,9 +408,9 @@
>  	mon = MSTK_REG_MONTH(mregs);
>  	year = MSTK_CVT_YEAR( MSTK_REG_YEAR(mregs) );
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
> -	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> -	wall_to_monotonic.tv_nsec = 0;
> +	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
This one also needs to normalize.
>  	mregs->creg &= ~MSTK_CREG_READ;
>  	spin_unlock_irq(&mostek_lock);
>  #ifdef CONFIG_SUN4
> 
> --- linux-2.5.72/arch/sparc64/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/sparc64/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -703,9 +703,9 @@
>  	}
> 
>  	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
> -	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> -	wall_to_monotonic.tv_nsec = 0;
> +	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
This one also needs to normalize.
> 
>  	if (mregs) {
>  		tmp = mostek_read(mregs + MOSTEK_CREG);
> 
> --- linux-2.5.72/arch/x86_64/kernel/time.c	Fri Jun 20 23:25:45 2003
> +++ linux-2.5.72-ufix/arch/x86_64/kernel/time.c	Fri Jun 20 23:37:10 2003
> @@ -542,6 +542,7 @@
>  #endif
> 
>  	xtime.tv_sec = get_cmos_time();
> +	wall_to_monotonic.tv_sec = -xtime.tv_sec;
>  	xtime.tv_nsec = 0;
> 
>  	if (!hpet_init()) {
> 
> 
> 
> 
> 
> 
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


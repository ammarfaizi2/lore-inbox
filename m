Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWASXY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWASXY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWASXY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:24:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:44492 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422665AbWASXY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:24:58 -0500
Subject: Re: [PATCH] Blacklist TSC from systems where it is known to be bad
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1137712995.27699.124.camel@cog.beaverton.ibm.com>
References: <1137712995.27699.124.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 15:24:55 -0800
Message-Id: <1137713095.27699.126.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 15:23 -0800, john stultz wrote:
> 	This patch adds a blacklist infrastructure to the TSC clocksource as
> well as an entry for the 380XD Thinkpad. This allows us to manually add
> systems (mainly older-laptops) where the TSC frequency is changed by the
> BIOS without any notification to the OS.
> 
> The justification for using a blacklist instead of trying to detect the
> problem is because the detectable symptoms are exactly the same as what
> is observed when interrupts arrive too frequently (a semi-common issue
> w/ broken PIT hardware), and the number of other older laptops with this
> issue is likely small.
> 
> This patch resolves bugme bug #5868.
> 
> thanks
> -john

Oops, forgot the signoff.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

thanks
-john


> 
> diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
> index cab2546..7e72219 100644
> --- a/arch/i386/kernel/tsc.c
> +++ b/arch/i386/kernel/tsc.c
> @@ -9,6 +9,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/jiffies.h>
>  #include <linux/init.h>
> +#include <linux/dmi.h>
>  
>  #include <asm/delay.h>
>  #include <asm/tsc.h>
> @@ -359,6 +360,27 @@ static int tsc_update_callback(void)
>  	return change;
>  }
>  
> +static int __init dmi_mark_tsc_unstable(struct dmi_system_id *d)
> +{
> +	printk(KERN_NOTICE "%s detected: marking TSC unstable.\n",
> +		       d->ident);
> +	mark_tsc_unstable();
> +	return 0;
> +}
> +
> +/* List of systems that have known TSC problems */
> +static struct dmi_system_id __initdata bad_tsc_dmi_table[] = {
> +	{
> +	 .callback = dmi_mark_tsc_unstable,
> +	 .ident = "IBM Thinkpad 380XD",
> +	 .matches = {
> +		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
> +		     DMI_MATCH(DMI_BOARD_NAME, "2635FA0"),
> +		     },
> +	 },
> +	 {}
> +};
> +
>  /*
>   * Make an educated guess if the TSC is trustworthy and synchronized
>   * over all CPUs.
> @@ -376,16 +398,21 @@ static __init int unsynchronized_tsc(voi
>   	return num_possible_cpus() > 1;
>  }
>  
> -/* NUMAQ can't use TSC: */
>  static int __init init_tsc_clocksource(void)
>  {
> -	/* TSC initialization is done in arch/i386/kernel/tsc.c */
> +
>  	if (cpu_has_tsc && tsc_khz && !tsc_disable) {
> -		if (unsynchronized_tsc()) /* lower rating if unsynced */
> +		/* check blacklist */
> +		dmi_check_system(bad_tsc_dmi_table);
> +
> +		if (unsynchronized_tsc()) /* mark unstable if unsynced */
>  			mark_tsc_unstable();
>  		current_tsc_khz = tsc_khz;
>  		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
>  							clocksource_tsc.shift);
> +		/* lower the rating if we already know its unstable: */
> +		if (check_tsc_unstable())
> +			clocksource_tsc.rating = 50;
>  		register_clocksource(&clocksource_tsc);
>  	}
>  
> 
> 
> 


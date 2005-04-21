Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVDULQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVDULQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVDULQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:16:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52112 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261286AbVDULPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:15:55 -0400
Date: Thu, 21 Apr 2005 13:15:54 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, vojtech@suse.cz
Subject: Re: [PATCH] X86_64: fix hpet for systems that don't support legacy replacement  (v. A2)
Message-ID: <20050421111553.GP7715@wotan.suse.de>
References: <1113961261.19541.167.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113961261.19541.167.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 06:41:00PM -0700, john stultz wrote:
> Andrew, All,
> 	Currently the x86-64 HPET code assumes the entire HPET implementation
> from the spec is present. This breaks on boxes that do not implement the
> optional legacy timer replacement functionality portion of the spec.
> 
> This patch fixes this issue, allowing x86-64 systems that cannot use the
> HPET for the timer interrupt and RTC to still use the HPET as a time
> source. I've tested this patch on a system systems without HPET, with
> HPET but without legacy timer replacement, as well as HPET with legacy
> timer replacement.
> 
> I'm currently working on a similar patch for i386.

You should it get reviewed by Vojtech who wrote the original x86-64 HPET
code.

-Andi

> 
> Please consider for your tree.
> 
> thanks
> -john
> 
> Changelog:
> A0: First sent to lkml
> A1: Implemented suggestions from Venkatesh
> A2: Whitespace cleanup.
> 
> linux-2.6.12-rc2_hpet-nolegacy-fix_A2.patch
> ===========================================
> diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c	2005-04-19 18:28:49 -07:00
> +++ b/arch/x86_64/kernel/time.c	2005-04-19 18:28:49 -07:00
> @@ -60,6 +60,7 @@
>  unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
>  static unsigned long hpet_period;			/* fsecs / HPET clock */
>  unsigned long hpet_tick;				/* HPET clocks / interrupt */
> +static int hpet_use_timer;
>  unsigned long vxtime_hz = PIT_TICK_RATE;
>  int report_lost_ticks;				/* command line option */
>  unsigned long long monotonic_base;
> @@ -297,7 +298,7 @@
>  
>  			last_offset = vxtime.last;
>  			base = monotonic_base;
> -			this_offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
> +			this_offset = hpet_readl(HPET_COUNTER);
>  
>  		} while (read_seqretry(&xtime_lock, seq));
>  		offset = (this_offset - last_offset);
> @@ -373,7 +374,14 @@
>  
>  	write_seqlock(&xtime_lock);
>  
> -	if (vxtime.hpet_address) {
> +	if (vxtime.hpet_address)
> +		offset = hpet_readl(HPET_COUNTER);
> +
> +	if (hpet_use_timer) {
> +		/* if we're using the hpet timer functionality,
> +		 * we can more accurately know the counter value
> +		 * when the timer interrupt occured.
> +		 */
>  		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
>  		delay = hpet_readl(HPET_COUNTER) - offset;
>  	} else {
> @@ -794,17 +802,18 @@
>   * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
>   * and period also hpet_tick.
>   */
> -
> -	hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
> +	if (hpet_use_timer) {
> +		hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
>  		    HPET_TN_32BIT, HPET_T0_CFG);
> -	hpet_writel(hpet_tick, HPET_T0_CMP);
> -	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> -
> +		hpet_writel(hpet_tick, HPET_T0_CMP);
> +		hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> +		cfg |= HPET_CFG_LEGACY;
> +	}
>  /*
>   * Go!
>   */
>  
> -	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
> +	cfg |= HPET_CFG_ENABLE;
>  	hpet_writel(cfg, HPET_CFG);
>  
>  	return 0;
> @@ -825,8 +834,7 @@
>  
>  	id = hpet_readl(HPET_ID);
>  
> -	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
> -	    !(id & HPET_ID_LEGSUP))
> +	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER))
>  		return -1;
>  
>  	hpet_period = hpet_readl(HPET_PERIOD);
> @@ -836,6 +844,8 @@
>  	hpet_tick = (1000000000L * (USEC_PER_SEC / HZ) + hpet_period / 2) /
>  		hpet_period;
>  
> +	hpet_use_timer = (id & HPET_ID_LEGSUP);
> +
>  	return hpet_timer_stop_set_go(hpet_tick);
>  }
>  
> @@ -892,9 +902,11 @@
>  	set_normalized_timespec(&wall_to_monotonic,
>  	                        -xtime.tv_sec, -xtime.tv_nsec);
>  
> -	if (!hpet_init()) {
> +	if (!hpet_init())
>                  vxtime_hz = (1000000000000000L + hpet_period / 2) /
>  			hpet_period;
> +
> +	if (hpet_use_timer) {
>  		cpu_khz = hpet_calibrate_tsc();
>  		timename = "HPET";
>  	} else {
> @@ -940,12 +952,12 @@
>  	if (oem_force_hpet_timer())
>  		notsc = 1;
>  	if (vxtime.hpet_address && notsc) {
> -		timetype = "HPET";
> +		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
>  		vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
>  		vxtime.mode = VXTIME_HPET;
>  		do_gettimeoffset = do_gettimeoffset_hpet;
>  	} else {
> -		timetype = vxtime.hpet_address ? "HPET/TSC" : "PIT/TSC";
> +		timetype = hpet_use_timer ? "HPET/TSC" : "PIT/TSC";
>  		vxtime.mode = VXTIME_TSC;
>  	}
>  
> 
> 

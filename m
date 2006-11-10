Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424324AbWKJBNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424324AbWKJBNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424326AbWKJBNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:13:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32480 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1424324AbWKJBNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:13:17 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: john stultz <johnstul@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233035.569684000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.569684000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 17:10:45 -0800
Message-Id: <1163121045.836.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> plain text document attachment
> (gtod-mark-tsc-unusable-for-highres-timers.patch)
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The TSC is too unstable and unreliable to be used with high resolution timers.
> The automatic detection of TSC unstability fails once we switched to high
> resolution mode, because the tick emulation would use the TSC as reference. 
> This results in a circular dependency.  Mark it unusable for high res upfront.
> 
> [akpm@osdl.org: updated for i386-time-avoid-pit-smp-lockups.patch]
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> diff -puN arch/i386/kernel/tsc.c~gtod-mark-tsc-unusable-for-highres-timers arch/i386/kernel/tsc.c
> --- a/arch/i386/kernel/tsc.c~gtod-mark-tsc-unusable-for-highres-timers
> +++ a/arch/i386/kernel/tsc.c
> @@ -459,10 +459,23 @@ static int __init init_tsc_clocksource(v
>  		current_tsc_khz = tsc_khz;
>  		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
>  							clocksource_tsc.shift);
> +#ifndef CONFIG_HIGH_RES_TIMERS
>  		/* lower the rating if we already know its unstable: */
>  		if (check_tsc_unstable())
>  			clocksource_tsc.rating = 0;
> -
> +#else
> +		/*
> +		 * Mark TSC unsuitable for high resolution timers. TSC has so
> +		 * many pitfalls: frequency changes, stop in idle ...  When we
> +		 * switch to high resolution mode we can not longer detect a
> +		 * firmware caused frequency change, as the emulated tick uses
> +		 * TSC as reference. This results in a circular dependency.
> +		 * Switch only to high resolution mode, if pm_timer or such
> +		 * is available.
> +		 */
> +		clocksource_tsc.rating = 50;
> +		clocksource_tsc.is_continuous = 0;
> +#endif
>  		init_timer(&verify_tsc_freq_timer);
>  		verify_tsc_freq_timer.function = verify_tsc_freq;
>  		verify_tsc_freq_timer.expires =


Hmmm. I wish this patch was unnecessary, but I don't see an easy
solution. 

Mind adding a warning so users know why a system that might use the TSC
normally does not use the TSC w/ highres timers?

Otherwise looks ok.

Acked-by: John Stultz <johnstul@us.ibm.com>

thanks
-john


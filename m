Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVAHN2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVAHN2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVAHN2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:28:44 -0500
Received: from gprs215-164.eurotel.cz ([160.218.215.164]:63360 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261165AbVAHN1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:27:35 -0500
Date: Sat, 8 Jan 2005 14:27:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, David Shaohua <shaohua.li@intel.com>
Subject: Re: Patch 3/3: Reduce number of get_cmos_time_calls.
Message-ID: <20050108132718.GD7363@elf.ucw.cz>
References: <1105176732.5478.20.camel@desktop.cunninghams> <1105177308.5478.43.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105177308.5478.43.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Create new __get_cmos_time patch, which doesn't wait for the start of a
> new second before returning. Adjust timer_suspend to use this as we
> don't appear to need the exact start of a second when suspending.

Basically nice cleanup. I do not know if this does not mean up-to
second error in clock for each suspend/resume?

> --- 913-old/arch/x86_64/kernel/time.c	2004-12-10 14:27:08.000000000 +1100
> +++ 913-new/arch/x86_64/kernel/time.c	2005-01-08 19:39:24.664278320 +1100
> @@ -499,11 +499,56 @@ unsigned long long sched_clock(void)
>  	return cycles_2_ns(a);
>  }
>  
> +unsigned long __get_cmos_time(void)
> +{

Missing static?

> +
> +	/*
> +	 * Do we need the spinlock in here too?
> +	 *
> +	 * If we're called directly (not via get_cmos_time),
> +	 * we're in the middle of a sysdev suspend/resume
> +	 * and interrupts are disabled, so this 
> +	 * should be safe without any locking.
> +	 * 				-- NC
> +	 */

I'd say "Caller is responsible for locking"... and explain this in
caller. Also do not sign comments.

> +	do {
> +		sec = CMOS_READ(RTC_SECONDS);
> +		min = CMOS_READ(RTC_MINUTES);
> +		hour = CMOS_READ(RTC_HOURS);
> +		day = CMOS_READ(RTC_DAY_OF_MONTH);
> +		mon = CMOS_READ(RTC_MONTH);
> +		year = CMOS_READ(RTC_YEAR);
> +	} while (sec != CMOS_READ(RTC_SECONDS));
> +
> +	/*
> +	 * We know that x86-64 always uses BCD format, no need to check the config
> +	 * register.
> +	 */
> +
> +	    BCD_TO_BIN(sec);
> +	    BCD_TO_BIN(min);
> +	    BCD_TO_BIN(hour);
> +	    BCD_TO_BIN(day);
> +	    BCD_TO_BIN(mon);
> +	    BCD_TO_BIN(year);

Whitespace damage?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

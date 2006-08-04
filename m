Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161354AbWHDT2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161354AbWHDT2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWHDT2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:28:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54198 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161354AbWHDT2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:28:03 -0400
Subject: Re: [PATCH 07/10] -mm  clocksource: remove update_callback
From: john stultz <johnstul@us.ibm.com>
To: dwalker@mvista.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060804032522.521288000@mvista.com>
References: <20060804032414.304636000@mvista.com>
	 <20060804032522.521288000@mvista.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 12:28:00 -0700
Message-Id: <1154719680.5327.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 20:24 -0700, dwalker@mvista.com wrote:
> plain text document attachment
> (clocksource_remove_update_callback.patch)
> With the new notifier block the update_callback becomes
> obsolete.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> ---
>  arch/i386/kernel/tsc.c      |    5 +++--
>  include/linux/clocksource.h |    2 --
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.17/arch/i386/kernel/tsc.c
> ===================================================================
> --- linux-2.6.17.orig/arch/i386/kernel/tsc.c
> +++ linux-2.6.17/arch/i386/kernel/tsc.c
> @@ -60,9 +60,12 @@ static inline int check_tsc_unstable(voi
>  	return tsc_unstable;
>  }
>  
> +static int tsc_update_callback(void);
>  void mark_tsc_unstable(void)
>  {
>  	tsc_unstable = 1;
> +
> +	tsc_update_callback();
>  }
>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);

Hmm. I'd like to keep mark_tsc_unstable to just be a flag rather then
the hook into the update_callback(), as it may be called quite
frequently.

I do agree we can kill the update_callback all together, but we probably
need to do sometihng like:

void mark_tsc_unstable(void)
{
	if (unlikely(!tsc_unstable)) {
		clocksource_tsc.rating = 50;
		clocksource_rating_change(&clocksource_tsc);
	}
	tsc_unstable = 1;
}


> @@ -322,7 +325,6 @@ core_initcall(cpufreq_tsc);
>  /* clock source code */
>  
>  static unsigned long current_tsc_khz = 0;
> -static int tsc_update_callback(void);
>  
>  static cycle_t read_tsc(void)
>  {
> @@ -340,7 +342,6 @@ static struct clocksource clocksource_ts
>  	.mask			= CLOCKSOURCE_MASK(64),
>  	.mult			= 0, /* to be set */
>  	.shift			= 22,
> -	.update_callback	= tsc_update_callback,
>  	.is_continuous		= 1,
>  };
>  
> Index: linux-2.6.17/include/linux/clocksource.h
> ===================================================================
> --- linux-2.6.17.orig/include/linux/clocksource.h
> +++ linux-2.6.17/include/linux/clocksource.h
> @@ -60,7 +60,6 @@ extern struct clocksource clocksource_ji
>   *			subtraction of non 64 bit counters
>   * @mult:		cycle to nanosecond multiplier
>   * @shift:		cycle to nanosecond divisor (power of two)
> - * @update_callback:	called when safe to alter clocksource values
>   * @is_continuous:	defines if clocksource is free-running.
>   * @cycle_interval:	Used internally by timekeeping core, please ignore.
>   * @xtime_interval:	Used internally by timekeeping core, please ignore.
> @@ -73,7 +72,6 @@ struct clocksource {
>  	cycle_t mask;
>  	u32 mult;
>  	u32 shift;
> -	int (*update_callback)(void);
>  	int is_continuous;
>  
>  	/* timekeeping specific data, ignore */
> 

Other then the top bit I don't have an issue w/ this.

thanks
-john



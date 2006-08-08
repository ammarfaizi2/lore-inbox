Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWHHSsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWHHSsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWHHSsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:48:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58573 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965034AbWHHSsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:48:23 -0400
Subject: Re: [PATCH] AVR32: Switch to generic timekeeping framework
From: john stultz <johnstul@us.ibm.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <11550448722406-git-send-email-hskinnemoen@atmel.com>
References: <11550448722406-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 11:48:20 -0700
Message-Id: <1155062900.13030.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 15:47 +0200, Haavard Skinnemoen wrote:
> Define CONFIG_GENERIC_TIME and remove arch-specific versions of
> do_{get,set}timeofday(). Define and use a clocksource based on the
> AVR32 cycle counter.
> 
> Also clean up asm/timex.h a bit, including defining CLOCK_TICK_RATE
> to a "good cheat value" borrowed from MIPS instead of the i8254 value
> used by "everyone" else, which is really quite pointless on AVR32.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---
>  arch/avr32/Kconfig        |    4 +
>  arch/avr32/kernel/time.c  |  172 +++++++++-------------------------------------
>  include/asm-avr32/timex.h |   26 ++++--
>  3 files changed, 59 insertions(+), 143 deletions(-)

Can't argue w/ a diffstat like that :)
Glad to see the code is working for you!


Acked-by: John Stultz <johnstul@us.ibm.com>


> @@ -286,22 +183,22 @@ void __init time_init(void)
>  	       (unsigned long)sysreg_read(COUNT),
>  	       (unsigned long)sysreg_read(COMPARE));
>  
> -	if (!avr32_hpt_frequency && boot_cpu_data.clk)
> -		avr32_hpt_frequency = clk_get_rate(boot_cpu_data.clk);
> -
> -	if (avr32_hpt_frequency) {
> -		cycles_per_jiffy = (avr32_hpt_frequency + HZ / 2) / HZ;
> +	count_hz = clk_get_rate(boot_cpu_data.clk);
> +	shift = clocksource_avr32.shift;
> +	mult = clocksource_hz2mult(count_hz, shift);
> +	clocksource_avr32.mult = mult;
> +
> +	printk("Cycle counter: mult=%lu, shift=%lu\n", mult, shift);
> +
> +	{
> +		u64 tmp;
> +
> +		tmp = TICK_NSEC;
> +		tmp <<= shift;
> +		tmp += mult / 2;
> +		do_div(tmp, mult);
>  
> -		/* 10^6 * 2^32 / avr32_hpt_frequency */
> -		{
> -			u64 tmp = 1000000ULL << 32;
> -			do_div(tmp, avr32_hpt_frequency);
> -			sll32_usecs_per_cycle = tmp;
> -		}
> -
> -		printk("Using %u.%03u MHz high precision timer.\n",
> -		       ((avr32_hpt_frequency + 500) / 1000) / 1000,
> -		       ((avr32_hpt_frequency + 500) / 1000) % 1000);
> +		cycles_per_jiffy = tmp;

That looks redundant to the calculate_interval code in timer.c and
points to a need for a generic nanosecond to cycles interface. I'll put
that on my TODO list.

> +/*
> + * This is the frequency of the timer used for Linux's timer interrupt.
> + * The value should be defined as accurate as possible or under certain
> + * circumstances Linux timekeeping might become inaccurate or fail.
> + *
> + * For many system the exact clockrate of the timer isn't known but due to
> + * the way this value is used we can get away with a wrong value as long
> + * as this value is:
> + *
> + *  - a multiple of HZ
> + *  - a divisor of the actual rate
> + *
> + * 500000 is a good such cheat value.
> + *
> + * The obscure number 1193182 is the same as used by the original i8254
> + * time in legacy PC hardware; the chip is never found in AVR32 systems.
> + */
> +#define CLOCK_TICK_RATE		500000	/* Underlying HZ */
>  

Hmm.. Hopefully the future NTP cleanup will remove the need for these
sorts of, uh.. tricks. :)

thanks
-john


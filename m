Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWHICpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWHICpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWHICp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:45:26 -0400
Received: from mail.suse.de ([195.135.220.2]:5041 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030429AbWHICpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH 5/6] x86_64: Clocksources for x86-64
Date: Wed, 9 Aug 2006 04:41:09 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com> <20060809021739.23103.98698.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021739.23103.98698.sendpatchset@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090441.09224.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 04:17, john stultz wrote:
> Re-add TSC and HPET support to x86_64 via clocksource infrastructure.

The actual review needed is in the existing clock source drivers
I guess.

I definitely don't want the "read three times" pmtimer code that 
is in the generic clock source on 64bit. You would need at least an ifdef
there or better detect the case where it is needed at runtime.

  
> -unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
> +unsigned int cpu_khz;					/* CPU clocks / usec, not used here */

The previous comment was more correct. It is really TSC clocks.


>  EXPORT_SYMBOL(cpu_khz);
> +unsigned int tsc_khz;					/* TSC clocks / usec, not used here */

And that comment can't have the same unit as the earlier one?


> +/* clock source code: */
> +
> +static unsigned long current_tsc_khz = 0;

Another one? Don't we have already too many of these variables?

> +
> +static int tsc_update_callback(void);
> +
> +static cycle_t read_tsc(void)
> +{
> +	cycle_t ret;
> +	rdtscll(ret);

It would need to be _sync

> +
> +	/* only update if tsc_khz has changed: */
> +	if (current_tsc_khz != tsc_khz){
> +		current_tsc_khz = tsc_khz;
> +		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> +							clocksource_tsc.shift);
> +		change = 1;
> +	}

Are you sure this handles p-state invariant TSC correctly?

And I hope there is a printk somewhere when this happens?

> +	return change;
> +}
> +
> +static int __init init_tsc_clocksource(void)
> +{
> +	if (!notsc && tsc_khz) {

How can tsc_khz be 0 ?

> +		current_tsc_khz = tsc_khz;
> +		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> +							clocksource_tsc.shift);
> +		return clocksource_register(&clocksource_tsc);
> +	}
> +	return 0;
> +}
> +
> +module_init(init_tsc_clocksource);

So what clocksource does it use before?

BTW I guess i would be ok with putting tsc and hpet into their own files.
And is there a reason HPET can't be generic in drivers/clocksource now?


> +
> +
> +#define HPET_MASK	0xFFFFFFFF
> +#define HPET_SHIFT	22
> +
> +/* FSEC = 10^-15 NSEC = 10^-9 */
> +#define FSEC_PER_NSEC	1000000
> +
> +static void *hpet_ptr;
> +
> +static cycle_t read_hpet(void)
> +{
> +	return (cycle_t)readl(hpet_ptr);

No 64bit HPET support? 

> +}
> +
> +struct clocksource clocksource_hpet = {
> +	.name		= "hpet",
> +	.rating		= 250,
> +	.read		= read_hpet,
> +	.mask		= (cycle_t)HPET_MASK,
> +	.mult		= 0, /* set below */
> +	.shift		= HPET_SHIFT,
> +	.is_continuous	= 1,
> +};

How is priority of the different time sources established in this? 

e.g. is the old fallback selection logic still fully functional?

-Andi

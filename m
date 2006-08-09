Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWHIDlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWHIDlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWHIDlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:41:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46491 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030441AbWHIDlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:41:07 -0400
Subject: Re: [RFC][PATCH 5/6] x86_64: Clocksources for x86-64
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608090441.09224.ak@suse.de>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
	 <20060809021739.23103.98698.sendpatchset@cog.beaverton.ibm.com>
	 <200608090441.09224.ak@suse.de>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 20:41:04 -0700
Message-Id: <1155094864.13030.140.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 04:41 +0200, Andi Kleen wrote:
> On Wednesday 09 August 2006 04:17, john stultz wrote:
> > Re-add TSC and HPET support to x86_64 via clocksource infrastructure.
> 
> The actual review needed is in the existing clock source drivers
> I guess.

Well, the acpi_pm is the only x86-64/i386 generic clocksource, so yes,
please look that one over if you have a chance.

> I definitely don't want the "read three times" pmtimer code that 
> is in the generic clock source on 64bit. You would need at least an ifdef
> there or better detect the case where it is needed at runtime.

We do have blacklist detection enabled, and by default it does only a
single read.


>   
> > -unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
> > +unsigned int cpu_khz;					/* CPU clocks / usec, not used here */
> 
> The previous comment was more correct. It is really TSC clocks.

Well, I'm trying to clean up the cpu_khz to be a cpufreq rating so the
scheduler can make better decisions, while still having a constant
tsc_khz on systems that do not change freq. This change can be thrown
out, or atleast delayed if its an issue.

> 
> >  EXPORT_SYMBOL(cpu_khz);
> > +unsigned int tsc_khz;					/* TSC clocks / usec, not used here */
> 
> And that comment can't have the same unit as the earlier one?

> > +/* clock source code: */
> > +
> > +static unsigned long current_tsc_khz = 0;
> 
> Another one? Don't we have already too many of these variables?

Heh. :)  That one is specific to the TSC clocksource, which can only
change state during an update_callback(). But yes, its unclear and could
use a name-change and/or just be static to tsc_update_callback()


> > +
> > +static int tsc_update_callback(void);
> > +
> > +static cycle_t read_tsc(void)
> > +{
> > +	cycle_t ret;
> > +	rdtscll(ret);
> 
> It would need to be _sync

Good point.

> > +
> > +	/* only update if tsc_khz has changed: */
> > +	if (current_tsc_khz != tsc_khz){
> > +		current_tsc_khz = tsc_khz;
> > +		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> > +							clocksource_tsc.shift);
> > +		change = 1;
> > +	}
> 
> Are you sure this handles p-state invariant TSC correctly?

It should, as the tsc_khz won't be changed on those systems.

> And I hope there is a printk somewhere when this happens?

Maybe a BUGON would be the right thing if the TSC is p-state invariant?


> > +	return change;
> > +}
> > +
> > +static int __init init_tsc_clocksource(void)
> > +{
> > +	if (!notsc && tsc_khz) {
> 
> How can tsc_khz be 0 ?

In the case that cpu_khz is zero. Hmmm, that be an i386-ism that slipped
in. I'll look into it.


> > +		current_tsc_khz = tsc_khz;
> > +		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
> > +							clocksource_tsc.shift);
> > +		return clocksource_register(&clocksource_tsc);
> > +	}
> > +	return 0;
> > +}
> > +
> > +module_init(init_tsc_clocksource);
> 
> So what clocksource does it use before?

In early boot, the jiffies clocksource is used until the clocksource
drivers are registered.


> BTW I guess i would be ok with putting tsc and hpet into their own files.

Great, I actually prefer that, but I didn't want to change too much
right off.

> And is there a reason HPET can't be generic in drivers/clocksource now?

Nope. Thomas and Ingo suggested the clocksource drivers should be arch
specific, but hpet has been generic before.

We'll still likely need an arch/x86_64/hpet.c for the differences in the
HPET interrupt bits between i386/x86_64, but those could be combined at
some point (also ia64 will be interested in the same bits).


> > +#define HPET_MASK	0xFFFFFFFF
> > +#define HPET_SHIFT	22
> > +
> > +/* FSEC = 10^-15 NSEC = 10^-9 */
> > +#define FSEC_PER_NSEC	1000000
> > +
> > +static void *hpet_ptr;
> > +
> > +static cycle_t read_hpet(void)
> > +{
> > +	return (cycle_t)readl(hpet_ptr);
> 
> No 64bit HPET support? 

For no reason I can recall. Its probably a leftover from the i386/x86_64
shared hpet driver.


> > +}
> > +
> > +struct clocksource clocksource_hpet = {
> > +	.name		= "hpet",
> > +	.rating		= 250,
> > +	.read		= read_hpet,
> > +	.mask		= (cycle_t)HPET_MASK,
> > +	.mult		= 0, /* set below */
> > +	.shift		= HPET_SHIFT,
> > +	.is_continuous	= 1,
> > +};
> 
> How is priority of the different time sources established in this? 

Via the rating value above.


> e.g. is the old fallback selection logic still fully functional?

Yep, the only complication is when the TSC is marked unstable (using the
same logic as before) and we fall back to the next best clocksource
(HPET, then ACPI PM).


Once again, I really appreciate your time reviewing this!

I'll fix up the issues you pointed for the next release.

thanks
-john


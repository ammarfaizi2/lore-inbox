Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVIALFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVIALFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVIALFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:05:44 -0400
Received: from smtp07.web.de ([217.72.192.225]:27785 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S932249AbVIALFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:05:44 -0400
From: Thomas Schlichter <thomas.schlichter@web.de>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
Date: Thu, 1 Sep 2005 13:05:23 +0200
User-Agent: KMail/1.6.2
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200509010829.35958.thomas.schlichter@web.de> <200509010942.24026.thomas.schlichter@web.de> <20050901102839.GB9936@in.ibm.com>
In-Reply-To: <20050901102839.GB9936@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509011305.24038.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srivatsa,

Am Donnerstag, 1. September 2005 12:28 schrieb Srivatsa Vaddagiri:
> On Thu, Sep 01, 2005 at 09:42:23AM +0200, Thomas Schlichter wrote:
> > Think about two adjacent regular timer interrupts. Now consider the first
> > one is handled very late (indeed even after the second interrupt already
> > occoured). Then will see two "lost" ticks.
> >
> > Now directly the second timer interrupt handler is executed and, well it
> > sees there has _nearly_ no time passed, so no "lost" ticks are reported.
>
> Thomas,
> 	In such a case, we should not increment jiffie during second interrupt
> (mainline code increments jiffie always on a timer interrupt).

I know, that's a problem...

> Also in such a case, it is probably not a good idea to drop offset_delay.
> I think we should retain it - otherwise next tick will show up as zero
> ticks lost?).

Well, if lost < 1, than we have a problem. And maybe the better idea really is 
to keep offset_delay. I simply wanted to stay as close as possible to the 
original code.

> There is another complication that the offset_tick recorded 
> during init_pmtmr may not be aligned on jiffy boundary. Ideally we want
> offset_tick to be aligned as closely as possible to jiffy boundary. This is
> one of the reason why I added setup_pit_timer in my patch during
> init_pmtmr.

OK, now I see...
Yes, so of course, using setup_pit_timer in init_pmtmr makes a lot of sense...
(But my mistake should not influence more than the first two jiffies, I think)

> After all this, I think the patch you sent out and what I had
> sent are fundamentally same - they rely on some constant ticks per jiffy to
> be seen for lost tick calculation.

Yes, the only real differences are the two points mentioned in my first 
mail... I only wanted to help you fixing these.

> I have seen this works on some machines 
> and not on others. I am trying to come up with another way of calculating
> lost ticks, which partially depends on some known PMTMR_TICKS_PER_JIFFY
> _and_ also reads the PIT to find out how late we are in processing the
> interrupt (refer delay_at_last_interrupt calculation in timer_tsc.c).

Well, that seems to be fine. If you want somebody to have a look over your 
final patch, feel free to mail me...

> Note that if you are testing mainline kernel, probably it wont test
> the lost tick calculation code as much as dynamic tick does, since
> not many ticks may be lost in practice.

Yes, I am testing the mainline kernel, and I don't have any problems with time 
drift...

> This could be one of the reasons 
> why no one has probably complained about time drift bitterly in mainline!
> I would be much happy to accept a solution which works with dynamic tick.
> For this you will need to apply the set of patches I mailed out.

Well, I don't think I'll have enough spare time to test dynamic tick 
extensively, but maybe I'll have a look at them this evening...

> P.S : I think PMTMR_TICKS_PER_JIFFY has to be calculated differently,
>       since a tick is not exactly 1/HZ of a second (see definition
>       of LATCH and pm_ticks_per_jiffy in my patch).

You are surely right, I used my simple macro because I am not _that_ familiar 
with LATCH and CALIBRATE_LATCH and thus used the most intuitive way. So maybe 
I should have defined PMTMR_TICKS_PER_JIFFY like you assigned 
pm_ticks_per_jiffy (why did you use a static and constant variable and not a 
macro?):

#define PMTMR_TICKS_PER_JIFFY (PMTMR_EXPECTED_RATE / (CALIBRATE_LATCH/LATCH))

  Thomas

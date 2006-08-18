Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWHRXgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWHRXgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWHRXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:36:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:38637 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750799AbWHRXgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:36:39 -0400
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever
	clock
From: john stultz <johnstul@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200608171838.05527.david-b@pacbell.net>
References: <200608162247.41632.david-b@pacbell.net>
	 <200608171641.20919.david-b@pacbell.net>
	 <1155859636.31755.159.camel@cog.beaverton.ibm.com>
	 <200608171838.05527.david-b@pacbell.net>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 16:36:37 -0700
Message-Id: <1155944198.5361.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 18:38 -0700, David Brownell wrote:
> On Thursday 17 August 2006 5:07 pm, john stultz wrote:
> 
> > > Seems to me the better question is what non-framework RTC drivers are still
> > > in the tree ... and actually a good first pass at answering that is that
> > > every platform touched in your original patch was NOT using the RTC class
> > > framework.  (Not the answer you wanted, right?)  And drivers/char/*rtc* users.
> > > There may be a few other RTCs elsewhere in the tree.
> > 
> > Uh, so you're saying the RTC framework is basically ARM only?
> > Eek. You're right, that's not the answer I wanted to hear!
> 
> That's not what I said, no ... I hope you don't think that only ARM
> chips can use I2C or SPI to connect to battery backed RTCs!!
> 
> Maybe you should think of it more like "so far mostly embedded systems
> use that framework" ... since it's embedded systems that need to cope
> with that variety in hardware.  RTCs are not architectural features, but
> are just implementation choices made during board or SOC design.  Since
> custom designs are endemic to embedded hardware, that's where the need
> for this RTC framework is critical.  A huge chunk of those markets use
> ARM (it's the most popular embedded 32bit CPU), but I know various MIPS
> and PPC boards also rely on those Linux RTC framework drivers.

No, I'm sorry, I realize the RTC interface has the potential to be more
widely used. I'm just a bit frustrated that in order to utilize the RTC
framework for what I'm trying to do, I have to first implement RTC
drivers for 90% of the arches. :(

Also the "RTC might not be available when you need it" issue makes it
uh.. difficult to use. :)

So if we go w/  the "it may not be available, so always assume it isn't"
way of thinking, it forces us to rely upon the RTC driver(s) to resume
time (which means every RTC, no matter how simple has to have
suspend/resume hooks and call settimeofday at least). 

I don't really like that uses-graph (I can imagine someone system not
resuming properly because they forgot to compile in the right RTC
driver). Also it doesn't resolve the timekeeing resume ordering issue
I'm trying to address.

But we might have to deal with it. Just to make sure we can balance this
properly, what is the percentage of RTC drivers where the might not be
available at timekeeping_resume()?  If it is small, it might be
reasonable to special case them (and by "special case", i *don't* mean
ignore :)


> The RTC framework is no more ARM-only than the generic TOD framework
> is x86-only.  But those changes did start from different corners of the
> Linux market, which likely explains some of the surprise associated with
> this little collision.  (If rtc-acpi got a bit more attention, that'd
> surely help raise awareness outside the embedded space...)

Looking at the rtc-acpi code, it describes itself as being AT compatible
(ie: The old CMOS clock), but its not clear if it requires ACPI or not
to work. Further, does it work on x86_64, or ia64 as well?

Another comment, drivers/rtc/ is a bit overwhelming. Same with the
Kconfig. Is there any way it could be broken up so arch-specific RTCs
aren't shown on arches that do not support them? Or maybe there should
be two classes, the arch-defined RTCs and then the generic ones?

Your thoughts?

> > > {save,restore}_time_delta() in
> > > 
> > > 	include/asm-arm/mach/time.h
> > > 	arch/arm/kernel/time.c
> > > 
> > > The rtc-at91.c code is layered classically ... RTC is the first platform
> > > device registered, and thus resumed, but it's resumed after the jiffies
> > > timer sysdev (thus with IRQs enabled).  So it will restore the time delta
> > > very early in the resume sequence.  (PXA uses a different approach.)
> > 
> > Hmmm. So looking at the code, ARM doesn't update jiffies on resume?
> 
> Now that you mention it ... that's right.  Just the wall clocks.  If you
> want to argue that's buglike, take it up with Russell King.  Presumably
> some other architectures do advance jiffies, not just the wall clock?

Well, its a "some arches do, some arches don't" discrepancy, rather then
a specific bug. It was my hope that by putting the logic in generic code
we would get consistent behavior across arches.

> > > Presumably this is stuff that should be done by the RTC class resume()
> > > method, probably for the CONFIG_RTC_HCTOSYS_DEVICE clock (though there
> > > could be a better RTC ... one that's being NTP-corrected).  That'd
> > > be no sooner than 2.6.19, which adds new class-level suspend()/resume()
> > > calls to help offload individual drivers.
> > 
> > Hrm. I'm a bit skeptical that the RTC resume code should update the
> > timekeeping code instead of the timekeeping code doing it. It seems that
> > it would cause additional complexity (what if there are two RTC
> > devices?) and would still have some of the suspend/resume ordering
> > issues I'm worried about.
> 
> Could be.  "Two RTCs" scenarios are real, as I've mentioned before.  I'll
> leave it to you to sort this stuff out, you seem to have a good handle
> on it all ... I was mostly concerned that you incorporate the RTC class
> support into your updates.  Neither of us created the mess surrounding
> persistent wall clocks, but if you want to unify things, then you should
> build on the existing RTC framework or else come up with a better one ...

I do appreciate you bringing these point up. I do think the RTC class
looks promising, but until its widely implemented, its difficult to
use/rely upon generically.

A thought: The approach taken w/ the generic timekeeping was that by
using the jiffies clocksource, we could stagger the transition. So the
clocksource code can be used generically, because all arches are
guaranteed to have atleast one clocksource. 

Is there some way we can take a similar approach, by combining the
read_persistent_clock() and the RTC framework? Basically creating a
dummy RTC that would be on every arch, implementing only the read method
which would call something like read_persistent_clock(). This way the
RTC infrastructure could be used on all arches, while the conversion was
still happening.

Alternatively it may be that the real solution is to either introduce
resume ordering levels or explicitly call timekeeping resume, instead of
leaving it to the sysclass logic.

thanks
-john


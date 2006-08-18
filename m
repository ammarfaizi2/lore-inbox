Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWHRBiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWHRBiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWHRBiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:38:10 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:45195 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030178AbWHRBiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:38:09 -0400
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Thu, 17 Aug 2006 18:38:04 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200608162247.41632.david-b@pacbell.net> <200608171641.20919.david-b@pacbell.net> <1155859636.31755.159.camel@cog.beaverton.ibm.com>
In-Reply-To: <1155859636.31755.159.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171838.05527.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 5:07 pm, john stultz wrote:

> > Seems to me the better question is what non-framework RTC drivers are still
> > in the tree ... and actually a good first pass at answering that is that
> > every platform touched in your original patch was NOT using the RTC class
> > framework.  (Not the answer you wanted, right?)  And drivers/char/*rtc* users.
> > There may be a few other RTCs elsewhere in the tree.
> 
> Uh, so you're saying the RTC framework is basically ARM only?
> Eek. You're right, that's not the answer I wanted to hear!

That's not what I said, no ... I hope you don't think that only ARM
chips can use I2C or SPI to connect to battery backed RTCs!!

Maybe you should think of it more like "so far mostly embedded systems
use that framework" ... since it's embedded systems that need to cope
with that variety in hardware.  RTCs are not architectural features, but
are just implementation choices made during board or SOC design.  Since
custom designs are endemic to embedded hardware, that's where the need
for this RTC framework is critical.  A huge chunk of those markets use
ARM (it's the most popular embedded 32bit CPU), but I know various MIPS
and PPC boards also rely on those Linux RTC framework drivers.

The RTC framework is no more ARM-only than the generic TOD framework
is x86-only.  But those changes did start from different corners of the
Linux market, which likely explains some of the surprise associated with
this little collision.  (If rtc-acpi got a bit more attention, that'd
surely help raise awareness outside the embedded space...)


> > {save,restore}_time_delta() in
> > 
> > 	include/asm-arm/mach/time.h
> > 	arch/arm/kernel/time.c
> > 
> > The rtc-at91.c code is layered classically ... RTC is the first platform
> > device registered, and thus resumed, but it's resumed after the jiffies
> > timer sysdev (thus with IRQs enabled).  So it will restore the time delta
> > very early in the resume sequence.  (PXA uses a different approach.)
> 
> Hmmm. So looking at the code, ARM doesn't update jiffies on resume?

Now that you mention it ... that's right.  Just the wall clocks.  If you
want to argue that's buglike, take it up with Russell King.  Presumably
some other architectures do advance jiffies, not just the wall clock?


> > Presumably this is stuff that should be done by the RTC class resume()
> > method, probably for the CONFIG_RTC_HCTOSYS_DEVICE clock (though there
> > could be a better RTC ... one that's being NTP-corrected).  That'd
> > be no sooner than 2.6.19, which adds new class-level suspend()/resume()
> > calls to help offload individual drivers.
> 
> Hrm. I'm a bit skeptical that the RTC resume code should update the
> timekeeping code instead of the timekeeping code doing it. It seems that
> it would cause additional complexity (what if there are two RTC
> devices?) and would still have some of the suspend/resume ordering
> issues I'm worried about.

Could be.  "Two RTCs" scenarios are real, as I've mentioned before.  I'll
leave it to you to sort this stuff out, you seem to have a good handle
on it all ... I was mostly concerned that you incorporate the RTC class
support into your updates.  Neither of us created the mess surrounding
persistent wall clocks, but if you want to unify things, then you should
build on the existing RTC framework or else come up with a better one ...

- Dave


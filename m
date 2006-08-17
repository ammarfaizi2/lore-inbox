Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWHQXl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWHQXl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWHQXl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:41:26 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:9065 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030377AbWHQXlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:41:25 -0400
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Thu, 17 Aug 2006 16:41:20 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200608162247.41632.david-b@pacbell.net> <200608171328.24344.david-b@pacbell.net> <1155850921.31755.115.camel@cog.beaverton.ibm.com>
In-Reply-To: <1155850921.31755.115.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171641.20919.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 2:42 pm, john stultz wrote:
> On Thu, 2006-08-17 at 13:28 -0700, David Brownell wrote:
> > On Thursday 17 August 2006 12:08 pm, john stultz wrote:
> > > On Wed, 2006-08-16 at 22:47 -0700, David Brownell wrote:
> > > > 
> > > > Hmm, this seems to ignore the RTC framework rather entirely, which
> > > > seems to me like the wrong implementation approach.  You'd likely have
> > > > noticed that if you had supported a few ARM boards.  :)
> > > 
> > > Good point. I've not spent enough time looking at the RTC code, and it
> > > looks like it has potential to resolve some of the issues I'm looking
> > > at. Although, how common is it really?
> > 
> > Increasingly so; it solves a lot of reinvent-the-wheel problems, much
> > like the recent generic time-of-day updates are doing.  And just like
> > with clocksource updates, not all architectures have converted yet!
> 
> Is a breakdown somewhere of what is covered at this point? The two
> letters followed by six number driver files make it difficult to see
> which arches use what. :)

A lot of those are part numbers for discrete chips, and some names are
for various ARM SOC families.

Seems to me the better question is what non-framework RTC drivers are still
in the tree ... and actually a good first pass at answering that is that
every platform touched in your original patch was NOT using the RTC class
framework.  (Not the answer you wanted, right?)  And drivers/char/*rtc* users.
There may be a few other RTCs elsewhere in the tree.

It seems all in-kernel ARM platforms except ARM Ltd's own "Integrator" use
the new framework instead of the older arch/arm/common/rtctime.c code (from
which the RTC framework evolved).  And I know there are other RTC drivers
and patches in the queue.  ARMs that haven't yet merged to mainline will,
as usual, pay the price for their perfidy.


> 	 However the suspend/resume ordering
> issue is more difficult. On resume we need to have something usable
> before we resume the timekeeping code in order to correctly increment
> xtime and jiffies in one atomic action.

Right; not something addressed in your original patch, or by many current
drivers AFAIK.  For the longest time, swsusp resume got that wrong...


> > > > I'd be more interested in something that improves on CONFIG_RTC_HCTOSYS,
> > > > and for example addresses the need to update the system wall time from
> > > > such RTCs after resume, not just at boot time.
> > > 
> > > Agreed.
> > 
> > There's some ARM code to restore the jiffies-vs-rtc clock offset on resume,
> > which seems like a candidate for wider use.
> 
> Where is this code? I'm interested here, but I suspect for correctness
> that bit should be under the control of the timekeeping core.

{save,restore}_time_delta() in

	include/asm-arm/mach/time.h
	arch/arm/kernel/time.c

The rtc-at91.c code is layered classically ... RTC is the first platform
device registered, and thus resumed, but it's resumed after the jiffies
timer sysdev (thus with IRQs enabled).  So it will restore the time delta
very early in the resume sequence.  (PXA uses a different approach.)

Presumably this is stuff that should be done by the RTC class resume()
method, probably for the CONFIG_RTC_HCTOSYS_DEVICE clock (though there
could be a better RTC ... one that's being NTP-corrected).  That'd
be no sooner than 2.6.19, which adds new class-level suspend()/resume()
calls to help offload individual drivers.


> > I'm not entirely sure I see RTC as a clocksource, but maybe that'd
> > make sense...
> 
> Ehh. That's definitely not the direction I'm trying to go (although I
> guess one could possibly do so). I just want the 3 items above. :)

Glad to hear it!  Though strictly speaking it _ought_ to make sense to
declare RTCs as clock sources.  They are clocks, after all.  I can even
imagine systems where the RTC issues (non-dynamic) tick interupts; some
RTCs (like those on PCs) are happy giving e.g 256 or 1024 irq/sec.

- Dave


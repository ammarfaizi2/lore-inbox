Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWGMUYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWGMUYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWGMUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:24:13 -0400
Received: from www.osadl.org ([213.239.205.134]:20124 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030364AbWGMUYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:24:11 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152664944.760.70.camel@cog.beaverton.ibm.com>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
	 <1152554328.5320.6.camel@localhost.localdomain>
	 <20060710180839.GA16503@elf.ucw.cz>
	 <Pine.LNX.4.64.0607110035300.17704@scrub.home>
	 <1152571816.9062.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607110054180.12900@scrub.home>
	 <1152605229.32107.88.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607111120310.12900@scrub.home>
	 <1152616025.32107.151.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607120039380.12900@scrub.home>
	 <1152664944.760.70.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 22:27:13 +0200
Message-Id: <1152822433.24345.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On Tue, 2006-07-11 at 17:42 -0700, john stultz wrote: 
> > > 
> > > Time keeping code reads from a given source and does the necessary
> > > adjustments when NTP is active. There is no relation to an interrupt
> > > event at all. At the very end it boils down to a linear equation which
> > > is recalculated at the synchronization points.
> > > 
> > > The timer interrupt itself is not a synchronization point.
> > 
> > If the timer interrupt is not a synchronization point, what is?
> 
> Synchronization point seems like a bad term in my mind. I prefer to
> think of it as an accumulation point (to avoid clocksource overflows) as
> well as a calculation point where we can make careful adjustments to the
> clocksource frequency. Please note that these two actions are not
> logically linked and could be done separately (although there really
> isn't a need to do so).

I used the term synchronization point for the points on the timeline,
where the information of an external time reference is available, e.g.
NTP data, a PPS interrupt ....

At those points we calculate the deviation from the external time
reference and refine the conversion and adjustment factors. In the
simplest form this boils down to a linear equation where we interpolate
between the points which are defined by the external time reference.

> > The timekeeping doesn't care much where synchronizations point comes from, 
> > but it can do a much better job, if it knows when they come.
> > Without knowing this the timekeeping code has to do extra work and has to 
> > be either optimistic or assume the worst case, neither is good for precise 
> > timekeeping, the first causes extra jitter, the latter very slow 
> > adjustments.
> 
> This I agree with. But first lets bound the issue to make it more clear
> for everyone: The conflict lies only with the high-precision clocksource
> adjustment code and not so much with the rest of the timekeeping code.
> 
> The issue being that the high-precision clocksource adjustment code is
> needed because when NTP makes an adjustment, that very precise
> adjustment might be finer then the smallest multiplier unit adjustment
> that could be made to the clocksource (1/(2^clock->shift)).
> 
> To compensate for that, at interrupt time we accumulate the
> high-precision error between what NTP told us to use and what we're able
> to use and store it in the error value. Then we apply extra short-term
> correction when the error grows large enough to keep our long term
> accuracy finer then the (1/2^shift) clocksource resolution.
> 
> Without this high-precision adjustment, you would have to rely on NTPd
> to detect and adjust for this granularity difference, which would cause
> a slower, but larger jitter.
> 
> Now the problem is, that if interrupts are delayed, this extra short
> term correction might be applied for too long, causing the overshoot
> issue we've seen (which I believe is the "extra jitter" issue mentioned
> above).
> 
> However, if we greatly dampen our adjustments, so we are less likely to
> overshoot, this means it will take longer for us to converge (ie: the
> "slow adjustment" issue above).
> 
> My only problem here is this: I don't think the slow adjustment issue is
> as severe as claimed. NTPd itself limits its adjustment speed to 500ppm
> and the frequency of its adjustment changes are in the minutes range. So
> I'm not sure I see why damping the error correction so we converge a bit
> more slowly over a period of a second or two is such an issue. 
> 
> I think this would give a bit of independence between the clocksource
> adjustment code and the interrupt frequency (and likely improve
> robustness as well).

John, that's exactly the central point. In an environment where we have
non periodic interrupts (high resolution timers, dynamic ticks) this
adjustment mechanism which relies on the periodic precise event to do
the accumulation does not work any more. I do not like the idea of
modifying this in a way that the timekeeping code does this fine grained
adjustment on the non periodic timer events. This will be a nightmare of
math and decrease robustness a lot.

The whole concept of doing the fine grained adjustment in order to
compensate for the inaccuracy of the scaled math factors on a _periodic_
event is flawed by design. The latency of interrupts in the kernel and
the fact that the periodic interrupt might be driven by a different
hardware clock, which has a different drift behaviour than the clock
which drives the time source, are reason enough to think about a
solution which makes this interdependency go away completely. In a high
resolution timer / dyntick system and also on virtualized environments
we need to get this dependency removed anyway.

The adjustment code is simply interpolation between points and boils
down to linear equations. Due to the fact that the conversion factor is
not accurate enough we need some mechanism to compensate this. I accept
that the current design has its charm, but I'm quite sure that we can do
a equally precise calculation without the interaction with the timer
interrupt code.

I know you prefer shopping over math, but it is a solvable problem.

	tglx









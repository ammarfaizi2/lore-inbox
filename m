Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWGLAm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWGLAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWGLAm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:42:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8908 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932303AbWGLAm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:42:27 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0607120039380.12900@scrub.home>
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
Content-Type: text/plain
Date: Tue, 11 Jul 2006 17:42:23 -0700
Message-Id: <1152664944.760.70.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 01:31 +0200, Roman Zippel wrote:
> On Tue, 11 Jul 2006, Thomas Gleixner wrote:
> 
> > > > It is not illusionary at all and we have to find a way to handle this.
> > > > 
> > > > Forcing time keeping to be bound on some interrupt handling is the wrong
> > > > design and in the way of tickless systems.
> > > 
> > > So what is the correct design?
> > > Especially for tickless system it's vital for precise timekeeping that the 
> > > timekeeping code knows what the timer interrupt code does.
> > 
> > Err. Why needs the time keeping code to know what the next timer event
> > will be ? The time keeping code must not care at all about it. And there
> > is nothing vital at all.
> > 
> > Time keeping code reads from a given source and does the necessary
> > adjustments when NTP is active. There is no relation to an interrupt
> > event at all. At the very end it boils down to a linear equation which
> > is recalculated at the synchronization points.
> > 
> > The timer interrupt itself is not a synchronization point.
> 
> If the timer interrupt is not a synchronization point, what is?

Synchronization point seems like a bad term in my mind. I prefer to
think of it as an accumulation point (to avoid clocksource overflows) as
well as a calculation point where we can make careful adjustments to the
clocksource frequency. Please note that these two actions are not
logically linked and could be done separately (although there really
isn't a need to do so).

> > At any synchronization point you store the current time as seen by the
> > time keeping code for reference and calculate the deviation from the
> > reference time line. Until the next synchronization point you apply the
> > recalculated correction to the readout and it does not matter at all
> > whether there are 0, 10 or 1000 timer interrupts between those points
> > and whether the delta between those interrupts is constant or not.
> 
> Well, it does matter, otherwise the recent fix woudn't have been needed.

Assuming you're talking about the suspend fix, I'm not sure I agree.
Making sure the timekeeping code is initialized before we use it does
not, to me at least, illustrate how interrupt frequency and timekeeping
are entwined. That's just an initialization ordering problem, as Thomas
already said.

> The timekeeping doesn't care much where synchronizations point comes from, 
> but it can do a much better job, if it knows when they come.
> Without knowing this the timekeeping code has to do extra work and has to 
> be either optimistic or assume the worst case, neither is good for precise 
> timekeeping, the first causes extra jitter, the latter very slow 
> adjustments.

This I agree with. But first lets bound the issue to make it more clear
for everyone: The conflict lies only with the high-precision clocksource
adjustment code and not so much with the rest of the timekeeping code.

The issue being that the high-precision clocksource adjustment code is
needed because when NTP makes an adjustment, that very precise
adjustment might be finer then the smallest multiplier unit adjustment
that could be made to the clocksource (1/(2^clock->shift)).

To compensate for that, at interrupt time we accumulate the
high-precision error between what NTP told us to use and what we're able
to use and store it in the error value. Then we apply extra short-term
correction when the error grows large enough to keep our long term
accuracy finer then the (1/2^shift) clocksource resolution.

Without this high-precision adjustment, you would have to rely on NTPd
to detect and adjust for this granularity difference, which would cause
a slower, but larger jitter.

Now the problem is, that if interrupts are delayed, this extra short
term correction might be applied for too long, causing the overshoot
issue we've seen (which I believe is the "extra jitter" issue mentioned
above).

However, if we greatly dampen our adjustments, so we are less likely to
overshoot, this means it will take longer for us to converge (ie: the
"slow adjustment" issue above).

My only problem here is this: I don't think the slow adjustment issue is
as severe as claimed. NTPd itself limits its adjustment speed to 500ppm
and the frequency of its adjustment changes are in the minutes range. So
I'm not sure I see why damping the error correction so we converge a bit
more slowly over a period of a second or two is such an issue. 

I think this would give a bit of independence between the clocksource
adjustment code and the interrupt frequency (and likely improve
robustness as well).

> > I'm just opposing the general tight coupling of the time keeping to
> > timer interrupts.
> 
> Timekeeping needs control of something, interrupts are the general 
> mechanism for asynchronous events. (Unless I'm missing something) your 
> clockevent concept is far too complex, simple clocksources only need to 
> export a shareable interrupt source, which the timekeeping code can use to 
> synchronize.
> If by "tight coupling" you mean the current hardcoded timer interrupt I 
> agree, but I still don't see that the clockevent stuff is really a better 
> solution.

Both hardware and software caused lost ticks are a reality and for the
sake of power-saving and virtualization the dynamic ticks feature is
very much desired, so I do see the clockevent stuff as being a good step
in the right direction.

The timekeeping code must be robust enough to handle unexpected lost
ticks, and entwining interrupt frequency and the timekeeping makes
high-res and dynamic ticks more difficult to implement and debug.

I would be open to some sort of frequency-hint hook that would give the
timekeeping code a better idea of what the dyntick interrupt frequency
will be, but since terrible long running BIOS SMIs won't call this, I
think the adjustment code will have to just be robust enough to handle
semi-random tick frequencies.

thanks
-john



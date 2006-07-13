Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWGMWGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWGMWGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWGMWGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:06:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:59586 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030420AbWGMWGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:06:04 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: Roman Zippel <zippel@linux-m68k.org>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152822433.24345.19.camel@localhost.localdomain>
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
	 <1152822433.24345.19.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 15:05:44 -0700
Message-Id: <1152828344.6845.96.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 22:27 +0200, Thomas Gleixner wrote:
> On Tue, 2006-07-11 at 17:42 -0700, john stultz wrote: 
> > However, if we greatly dampen our adjustments, so we are less likely to
> > overshoot, this means it will take longer for us to converge (ie: the
> > "slow adjustment" issue above).
> > 
> > My only problem here is this: I don't think the slow adjustment issue is
> > as severe as claimed. NTPd itself limits its adjustment speed to 500ppm
> > and the frequency of its adjustment changes are in the minutes range. So
> > I'm not sure I see why damping the error correction so we converge a bit
> > more slowly over a period of a second or two is such an issue. 
> > 
> > I think this would give a bit of independence between the clocksource
> > adjustment code and the interrupt frequency (and likely improve
> > robustness as well).
> 
> John, that's exactly the central point. In an environment where we have
> non periodic interrupts (high resolution timers, dynamic ticks) this
> adjustment mechanism which relies on the periodic precise event to do
> the accumulation does not work any more. 

Agreed. I don't want to embed any dependency on a *precise* event in the
timekeeping code. I know of too much hardware that doesn't allow that to
occur, so I really want this code to be robust in the case of lost
ticks.

However, we do want precise timekeeping. Since there is a resolution
difference between NTP's precision and the clocksources, keeping track
of that error and adjusting for it is a desirable thing to do. 

> I do not like the idea of
> modifying this in a way that the timekeeping code does this fine grained
> adjustment on the non periodic timer events. This will be a nightmare of
> math and decrease robustness a lot.
> 
> The whole concept of doing the fine grained adjustment in order to
> compensate for the inaccuracy of the scaled math factors on a _periodic_
> event is flawed by design. The latency of interrupts in the kernel and
> the fact that the periodic interrupt might be driven by a different
> hardware clock, which has a different drift behaviour than the clock
> which drives the time source, are reason enough to think about a
> solution which makes this interdependency go away completely. In a high
> resolution timer / dyntick system and also on virtualized environments
> we need to get this dependency removed anyway.

Again, agreed.  I think the conflict is that since we want to keep track
of and adjust for this fine error caused by the resolution differences,
one can keep "closer" time if those synchronization points where the
error is used to make an adjustment are close together and evenly
spaced.

Now, we *know* that isn't going to be the case. And we don't want to
make that a requirement. However, just to function, we do need some
calculation point every once in awhile, just so the clocksource doesn't
overflow, and we have a point where we can make adjustments if NTPd
tells us to adjust our clocksource frequency. These don't have to be
precise events, they just need to happen every once in awhile. Lets say
~once a second just to have a number to work with.

Again, the closer they are, the faster we can take the NTP changes and
start applying them, so they have an effect on timekeeping, but my point
is "how much?". 

Notice, for the high-precsion clocksource adjustments remember the
granularity of the error we're keeping track of is nanoseconds shifted
up by 32. That's way small.

Also note: Assuming no NTP changes during a period, the maximum error in
nanosecond accumulated over a period is the number of clocksource cycles
in that period shifted down by the clocksource shift value. (This is
since the smallest adjustment is 1 mult unit, and mult/2^shift is
1/freq)

So for a counter w/ a 4Ghz frequency and a shift value of 22 (similar to
a TSC). Over 1 second, if there was no high-precision adjustment, you
could get a *maximum* of error of ~1us (4b/2^22 = ~1024ns), which is a
1ppm drift, if left uncorrected.

Now, if we have high-precision adjustments, the question is "how fast
should we fix that 1us error?". If the code assumes we're going to have
a tick every 1 ms, it can make a stronger adjustment (of 10 mult units)
which it will remove after the next tick. This however could cause
problems if we lost ticks and that interrupt was delayed as we would
overshoot.

Thus, if we assume that ticks will show up worse case, about once a
second or two, we can make an adjustment of a single mult unit and
assume that we'll correct it over the next second. This is what Roman
was saying would be "slow adjustments", but I don't see it as too
unacceptable. 

My P-D code did just this with its two part (freq/offset) adjustment,
and Roman's current code is more careful here as well, dampening the
adjustment when the error grows.

> The adjustment code is simply interpolation between points and boils
> down to linear equations. Due to the fact that the conversion factor is
> not accurate enough we need some mechanism to compensate this. I accept
> that the current design has its charm, but I'm quite sure that we can do
> a equally precise calculation without the interaction with the timer
> interrupt code.

I'd be open to other implementations as well (I'm no control theorist,
so I've been learning as I go). But while I 110% agree that the
timekeeping code should be robust in the face of lost ticks and function
w/ dynamic ticks, I think it will be hard to escape the fact that the
higher the frequency at which we evaluate and adjust the clock against
the reference clock, the closer we can keep to it.

But since i386 *just* got sub-microsecond timekeeping resolution w/ this
patch set, I think the term "close" does not need to mean "within a
nanosecond at all times". 

And really, after dealing for so long w/ issues like "Clock can't keep
within 100ms of NTP", I find this discussion refreshing :)

thanks
-john



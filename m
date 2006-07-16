Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWGPPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWGPPvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWGPPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:51:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52865 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750970AbWGPPvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:51:04 -0400
Date: Sun, 16 Jul 2006 17:50:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
In-Reply-To: <1152822433.24345.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607152209440.12900@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se> 
 <1152554328.5320.6.camel@localhost.localdomain>  <20060710180839.GA16503@elf.ucw.cz>
  <Pine.LNX.4.64.0607110035300.17704@scrub.home>  <1152571816.9062.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607110054180.12900@scrub.home>  <1152605229.32107.88.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607111120310.12900@scrub.home>  <1152616025.32107.151.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607120039380.12900@scrub.home>  <1152664944.760.70.camel@cog.beaverton.ibm.com>
 <1152822433.24345.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Jul 2006, Thomas Gleixner wrote:

> > > > The timer interrupt itself is not a synchronization point.
> > > 
> > > If the timer interrupt is not a synchronization point, what is?
> 
> I used the term synchronization point for the points on the timeline,
> where the information of an external time reference is available, e.g.
> NTP data, a PPS interrupt ....

This would be even less usable, there is no requirement that NTP is used 
for time synchronization and the kernel has no idea when then the next 
NTP adjustment happens.

> At those points we calculate the deviation from the external time
> reference and refine the conversion and adjustment factors. In the
> simplest form this boils down to a linear equation where we interpolate
> between the points which are defined by the external time reference.

This is true for the clock source, but the adjustments that come in via 
NTP are not exactly linear, so unless you want to rewrite the whole NTP 
system, I don't think this will work.

> > I think this would give a bit of independence between the clocksource
> > adjustment code and the interrupt frequency (and likely improve
> > robustness as well).
> 
> John, that's exactly the central point. In an environment where we have
> non periodic interrupts (high resolution timers, dynamic ticks) this
> adjustment mechanism which relies on the periodic precise event to do
> the accumulation does not work any more. I do not like the idea of
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
> 
> The adjustment code is simply interpolation between points and boils
> down to linear equations. Due to the fact that the conversion factor is
> not accurate enough we need some mechanism to compensate this. I accept
> that the current design has its charm, but I'm quite sure that we can do
> a equally precise calculation without the interaction with the timer
> interrupt code.
> 
> I know you prefer shopping over math, but it is a solvable problem.

Thomas, do you have any idea how insulting this is?
First of all you are pretty much wrong with your analysis. It does not 
rely on "periodic precise event", it helps if they are precise, but it's 
not a requirement and it's practically a one line change so it can deal 
with nonperiodic updates (the rest is just a matter of correct tuning). 
The "fine grained adjustment" doesn't "compensate for the inaccuracy of 
the scaled math" at all, one has to know here that we only have to be 
accurate within limits (usually the resolution of the clock), so that the 
inaccuracy is not really a problem and it has the advantage that is 
generally cheap. What the adjustments actually compensate for is the 
difference in resolution and the update delays.
Since your initial analysis is pretty much wrong, your conclusions are 
pretty much useless as well. So far so bad, by itself this wouldn't be 
really a problem yet, everyone makes mistakes. If you would at least ask 
some questions about whatever problem you'd like to see solved or if you 
would make some constructive suggestion how to solve these problems, this 
would have shown respect and could have been a nice discussion. Instead 
you just piss on my work by asking John to throw away everything I did and 
to "solve" it somehow.
Did you even consider for a second that I might have already thought about 
these problems? Did it enter your mind that the hard problems might 
already be pretty much solved? Since you don't ask me at all, you don't 
really seem to care about what I think. Instead of playing Mr. 
know-it-all, I would really appreciate it if you showed some more respect 
for my work.

bye, Roman

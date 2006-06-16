Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWFPSsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWFPSsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 14:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFPSsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 14:48:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:9870 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751350AbWFPSsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 14:48:21 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606161620190.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
	 <1149538810.9226.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606052226150.32445@scrub.home>
	 <1149622955.4266.84.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606070005550.32445@scrub.home>
	 <1149753904.2764.24.camel@leatherman>
	 <Pine.LNX.4.64.0606151319440.32445@scrub.home>
	 <1150428084.15267.74.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606161620190.32445@scrub.home>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 11:48:04 -0700
Message-Id: <1150483684.5316.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 17:33 +0200, Roman Zippel wrote:
> On Thu, 15 Jun 2006, john stultz wrote:
> > I've also been working on improving the adjustment algorithm. Paul
> > Mckenney enlightened me to the established concepts in control theory, I
> > started reading up on PID control (see:
> > http://en.wikipedia.org/wiki/PID_controller ). While I have understood
> > the basic concept, it was useful to read up on it. I've tried to rework
> > the adjustment code accordingly.
> > 
> > The method I came up with is really just P-D (proportional-derivative)
> > control, but that should be ok since the adjustments are all linear so I
> > don't think the integral control is necessary (control theorists can
> > pipe in here).
> 
> This makes it more complex than necessary. AFAICT this controller 
> calculates the adjustment solely based on the current error, but we have 
> more information than this, which make the current error rather 
> uninteresting.

Indeed it is the current error, but its also taking the change in error
into account as well.

> We know the clock frequency and the NTP frequency so we can easily 
> precalculate, how the error will look like at the next few ticks. Based on 
> this we can calculate how we have to adjust the clock frequency to reduce 
> the error. Overshooting is also not a real problem as long as the absolute 
> error gets smaller.

I'm not sure I agree here. Using your patch series, if I re-enable the
code that drops calls to update_wall_time (simulating lost ticks) the
clock does not appear very stable. Robustness and features like
dynamic/no_idle_hz are going to require that we can handle taking
something close to only one tick per second, so overshoot is a big
concern in my mind. Maybe I'm misunderstanding you?

However, I need to forward port your patchset to the new simulator to
really do a fair comparison as I know there were some issues w/ the
simulator that I addressed in order to get the new features working. If
you have already done this, let me know.

> An important point about the last patch is not just robustness but also 
> speed, it tries to keep the fast path small, which is basically:
> 
> 	interval = clock->cycle_interval;
> 	if (error > interval / 2) {
> 		adj = 1;
> 		if (unlikely(error > interval * 2)) {
> 			...
> 		}
> 	} else if (error < -interval / 2) {
> 		adj = -1
> 		interval = -interval;
> 		offset = -offset;
> 		if (unlikely(error < interval * 2)) {
> 			...
> 		}
> 	} else
> 		return;
> 
> 	clock->mult += adj;
> 	clock->xtime_interval += interval;
> 	clock->xtime_nsec -= offset;
> 	clock->error -= interval - offset;
> 
> You'll need a very good reason to do anything more than this for small 
> errors and I would suggest you start from something like this, as this is 
> the very core of the error adjustment.

I agree that the patch I sent could use some optimizations, and likely
even some tweaking (supposedly I can get rid of the proportional
adjustment limiter by using a gain value, but I need to test this a bit)
to improve it further.  

Now trying to compare it to your code:

Looking at your description of the code above from your documentation
email:
1)	mult_adj = error / cycle_update;
2)	mult += mult_adj;
3)	xtime -= cycle_offset * mult_adj;
4)	error -= (cycle_update - cycle_offset) * mult_adj;

Lines 1 & 2 calculates the proportional error adjustment for the error
at the next interval.

Line 3 is also well understood, as it corrects the base for the new
adjustment value if there is an offset value.

So I see the proportional adjustment, but I don't see how the derivative
is included. I suspect the density of the error adjustment bit is what
makes this so opaque to me. Breaking line 4 apart for a moment:

4a) error += cycle_offset * multadj;
4b) error -= cycle_update * muladj

Line 4a is also clear, since if the base had been changed in line 3, the
error between the base and ntp has changed as well, so it must be
changed by the negative amount the base was changed to stay in sync.

Line 4b is a bit foggy. Just assuming cycle_offset is zero, we can
ignore line 3 and 4a. So we're reducing the error by the change in
length of the next interval. I see how this would in effect dampen the
next adjustment, but I'm not sure how that then maps the error value to
the actual distance from ntp_time.

Abstractly I understand how looking at the next tick is good for when
the NTP adjustment value changes, but I'm not sure I see how looking
ahead makes the clock more stable when the NTP adjustment isn't
changing.

Is there a way you can map the math above to the terms of PID control
(or maybe some other established concept that I can dig deeper on?).

thanks
-john


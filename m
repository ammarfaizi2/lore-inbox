Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWFQTq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWFQTq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 15:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWFQTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 15:46:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28307 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750773AbWFQTqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 15:46:55 -0400
Date: Sat, 17 Jun 2006 21:45:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: clocksource
In-Reply-To: <1150483684.5316.56.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606170023260.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> 
 <Pine.LNX.4.64.0606050141120.17704@scrub.home>  <1149538810.9226.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0606052226150.32445@scrub.home>  <1149622955.4266.84.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.64.0606070005550.32445@scrub.home>  <1149753904.2764.24.camel@leatherman>
  <Pine.LNX.4.64.0606151319440.32445@scrub.home>  <1150428084.15267.74.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.64.0606161620190.32445@scrub.home> <1150483684.5316.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Jun 2006, john stultz wrote:

> > This makes it more complex than necessary. AFAICT this controller 
> > calculates the adjustment solely based on the current error, but we have 
> > more information than this, which make the current error rather 
> > uninteresting.
> 
> Indeed it is the current error, but its also taking the change in error
> into account as well.

Which is not really important anymore, as soon as you already _know_ the 
future error.

> > We know the clock frequency and the NTP frequency so we can easily 
> > precalculate, how the error will look like at the next few ticks. Based on 
> > this we can calculate how we have to adjust the clock frequency to reduce 
> > the error. Overshooting is also not a real problem as long as the absolute 
> > error gets smaller.
> 
> I'm not sure I agree here. Using your patch series, if I re-enable the
> code that drops calls to update_wall_time (simulating lost ticks) the
> clock does not appear very stable.

That's because the tick length is not applied in the same way in 
sim-main.c and time.c, if the drop happens around a call to 
second_overflow(), one gets the old value and the other gets the new 
value. If you prevent the drop around a ppm change, it will work just 
fine, it's a bug in the simulator.

> Robustness and features like
> dynamic/no_idle_hz are going to require that we can handle taking
> something close to only one tick per second, so overshoot is a big
> concern in my mind. Maybe I'm misunderstanding you?

Overshooting is not your real problem in this case, as large offsets and 
lost interrupts are less a problem. You're making it way too complex...

> However, I need to forward port your patchset to the new simulator to
> really do a fair comparison as I know there were some issues w/ the
> simulator that I addressed in order to get the new features working. If
> you have already done this, let me know.

The new simulator is far too complex and I don't want to spend the time 
verifying it does a really correct simulation, I don't think it's really a 
good idea to make the simulator more complex than the subject, otherwise 
you need a simulator to test the simulator...
You are also using rather smallish adjustments, changes of upto 1ms/s are 
more realistic (NTP allows a MAXPHASE offset which is spread over a period 
of time). Your simulator is also fixed to 1GHz and 1000Hz, which are 
rather convenient values.

> Line 4b is a bit foggy. Just assuming cycle_offset is zero, we can
> ignore line 3 and 4a. So we're reducing the error by the change in
> length of the next interval. I see how this would in effect dampen the
> next adjustment, but I'm not sure how that then maps the error value to
> the actual distance from ntp_time.

As I said it looks ahead to the next error, if we adjust the multiplier at 
the current tick, it also changes the error at the next tick.

> Abstractly I understand how looking at the next tick is good for when
> the NTP adjustment value changes, but I'm not sure I see how looking
> ahead makes the clock more stable when the NTP adjustment isn't
> changing.

Huh? If the NTP adjustment isn't changing, clock and NTP are hopefully in 
sync and there is no (significant) error to adjust.

> Is there a way you can map the math above to the terms of PID control

Please forget this one, it doesn't really apply here. We know more about 
the model, which allows for simpler calculations. You have to throw away 
information to fit it into the PID model.

> (or maybe some other established concept that I can dig deeper on?).

I guess it's basically a FLL.

Below is another patch, which better takes the update delays into account.

bye, Roman



take the offset better into account by applying the current adjustment
to the error and anticipate a possible large adjustment at the next
update due to a large offset.
---
 time.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: simulator_C2/time.c
===================================================================
--- simulator_C2.orig/time.c
+++ simulator_C2/time.c
@@ -227,7 +227,7 @@ device_initcall(timekeeping_init_device)
  * If the error is already larger, we look ahead another tick,
  * to compensate for late or lost adjustments.
  */
-static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 interval)
+static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 interval, s64 offset)
 {
 	int adj = 0;
 
@@ -236,8 +236,12 @@ static __always_inline int clocksource_b
 
 	while (1) {
 		error >>= 1;
-		if (sign > 0 ? error <= interval : error >= interval)
+		if (sign > 0 ? error <= interval : error >= interval) {
+			error = (error << 1) - interval + offset;
+			if (sign > 0 ? error > interval : error < interval)
+				adj++;
 			return adj;
+		}
 		adj++;
 	}
 }
@@ -246,7 +250,8 @@ static __always_inline int clocksource_b
 	int adj = sign;							\
 	error >>= 2;							\
 	if (unlikely(sign > 0 ? error > interval : error < interval)) {	\
-		adj = clocksource_bigadjust(sign, error, interval);	\
+		adj = clocksource_bigadjust(sign, error,		\
+					    interval, offset);		\
 		interval <<= adj;					\
 		offset <<= adj;						\
 		adj = sign << adj;					\

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWGGXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWGGXQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGGXQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:16:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29158 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932376AbWGGXQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:16:47 -0400
Date: Sat, 8 Jul 2006 01:16:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Uwe Bugla <uwe.bugla@gmx.de>
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <1152223506.24656.173.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0607070134020.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org> 
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> 
 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271903320.12900@scrub.home>  <Pine.LNX.4.64.0606271919450.17704@scrub.home>
  <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> 
 <1151453231.24656.49.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.64.0606281218130.12900@scrub.home>
  <Pine.LNX.4.64.0606281335380.17704@scrub.home> 
 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu> 
 <1151695569.5375.22.camel@localhost.localdomain> 
 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0607030256581.17704@scrub.home> 
 <200607050429.k654TXUr012316@turing-police.cc.vt.edu> 
 <1152147114.24656.117.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.64.0607061912370.12900@scrub.home> <1152223506.24656.173.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Jul 2006, john stultz wrote:

> Yea. I've been trying to map your method to the PID concept as well
> (when all you have is a hammer... ;) and they are similar, however the
> "future error" aspect of yours makes it a little more difficult to
> grasp, but it is more compact.

Let's take a different example model - let's take two cars, where one car 
tries to follow the other, but it's limited in how it can change the speed 
(and sometimes the driver also falls asleep :) ).
First we want to match of course the speed of both cars, so that the 
distance between the cars increases as little as possible over time. 
Second we want to decrease the distance between the cars. The problem is 
to stop the correction when the distance is near zero, which is simple 
when we know the next time, we can change the speed, but if we miss the 
point we overshoot and the distance grows again.
It's possible to keep these two parameters separate, but it's actually 
simpler to look at them together, by simply looking some time ahead and 
calculate the position of the car at this time and thus the speed of the 
other car to reach this position.

The adjustment code basically does just this by using the difference in 
speed to calculate the upcoming error. The new patch now uses the current 
error to decide by how much to look ahead, basically if we already have a 
large error, we have to be more careful, but overshooting with a small 
adjustment doesn't do much harm.
In the patch below I left some debug prints, which are useful to check how 
good the error adjustment works. It should be close to the final version 
(minus the prints and plus some more comments).

> > Regarding dynticks it would help a lot here to know how many ticks are 
> > skipped so you can spread the error correction evenly over this period 
> > until the next adjustment and the correction is stopped in time.
> 
> I've considered alternatives, where we use a constant gain with the
> proportional component (so any proportional change would be spread over
> one second), but to avoid constant offsets when the total error was
> smaller then the gain factor, we could also calculate a non-gain'ed
> adjustment w/ a limiter and include that. This would be more ideal in
> your irregular ticks example, but I'm not sure its really that much more
> beneficial from what I proposed.

The problem is we have conflicting goals, adjusting for an unknown number 
of lost ticks is bad for precise timekeeping. I prefer to assume that lost 
ticks are the exceptions and we need the help from the dynticks code to 
assure precise timekeeping.

bye, Roman


---
 kernel/timer.c |   89 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 33 deletions(-)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-07-07 02:51:57.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-07-07 23:58:47.000000000 +0200
@@ -1013,15 +1013,9 @@ device_initcall(timekeeping_init_device)
  */
 static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 *interval, s64 *offset)
 {
-	int adj;
+	s64 e, i;
+	int adj, mult;
 
-	/*
-	 * As soon as the machine is synchronized to the external time
-	 * source this should be the common case.
-	 */
-	error >>= 2;
-	if (likely(sign > 0 ? error <= *interval : error >= *interval))
-		return sign;
 
 	/*
 	 * An extra look ahead dampens the effect of the current error,
@@ -1029,33 +1023,41 @@ static __always_inline int clocksource_b
 	 * it would dominate the adjustment value and can lead to
 	 * oscillation.
 	 */
-	error += current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
-	error -= clock->xtime_interval >> 1;
-
-	adj = 0;
-	while (1) {
-		error >>= 1;
-		if (sign > 0 ? error <= *interval : error >= *interval)
-			break;
-		adj++;
+	e = (sign > 0 ? clock->error : -clock->error) >> (TICK_LENGTH_SHIFT + 20 - 2 * SHIFT_HZ);
+	for (adj = 0; (e >>= 2) > 0; adj++)
+		;
+	error >>= adj;
+	e = current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift);
+	e -= clock->xtime_interval;
+	error += e;
+	error -= e >> (adj + 1);
+
+	i = *interval;
+	mult = 1;
+	if (error < 0) {
+		error = -error;
+		*interval = -*interval;
+		*offset = -*offset;
+		mult = -1;
+	}
+
+	if (error <= i) {
+		*interval = 0;
+		*offset = 0;
+		return 0;
 	}
 
-	/*
-	 * Add the current adjustments to the error and take the offset
-	 * into account, the latter can cause the error to be hardly
-	 * reduced at the next tick. Check the error again if there's
-	 * room for another adjustment, thus further reducing the error
-	 * which otherwise had to be corrected at the next update.
-	 */
-	error = (error << 1) - *interval + *offset;
-	if (sign > 0 ? error > *interval : error < *interval)
-		adj++;
+	for (adj = 0; (error >>= 1) > i; adj++)
+		;
 
 	*interval <<= adj;
 	*offset <<= adj;
-	return sign << adj;
+	return mult << adj;
 }
 
+static unsigned long next_print = INITIAL_JIFFIES;
+static int big_cnt, one_cnt, zero_cnt;
+
 /*
  * Adjust the multiplier to reduce the error value,
  * this is optimized for the most common adjustments of -1,0,1,
@@ -1066,15 +1068,36 @@ static void clocksource_adjust(struct cl
 	s64 error, interval = clock->cycle_interval;
 	int adj;
 
+	if (time_after(jiffies, next_print)) {
+		printk("adj: %d,%d,%d\n", zero_cnt, one_cnt, big_cnt);
+		zero_cnt = one_cnt = big_cnt = 0;
+		next_print = jiffies + 10 * HZ;
+	}
 	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
 	if (error > interval) {
-		adj = clocksource_bigadjust(1, error, &interval, &offset);
+		error >>= 2;
+		if (likely(error <= interval)) {
+			one_cnt++;
+			adj = 1;
+		} else {
+			big_cnt++;
+			adj = clocksource_bigadjust(1, error, &interval, &offset);
+		}
 	} else if (error < -interval) {
-		interval = -interval;
-		offset = -offset;
-		adj = clocksource_bigadjust(-1, error, &interval, &offset);
-	} else
+		error >>= 2;
+		if (likely(error >= -interval)) {
+			one_cnt++;
+			adj = -1;
+			interval = -interval;
+			offset = -offset;
+		} else {
+			big_cnt++;
+			adj = clocksource_bigadjust(-1, error, &interval, &offset);
+		}
+	} else {
+		zero_cnt++;
 		return;
+	}
 
 	clock->mult += adj;
 	clock->xtime_interval += interval;

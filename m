Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWGHUCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWGHUCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWGHUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:02:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59117 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030307AbWGHUCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:02:52 -0400
Date: Sat, 8 Jul 2006 22:02:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Uwe Bugla <uwe.bugla@gmx.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH] adjust clock for lost ticks
In-Reply-To: <1152223506.24656.173.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0607082151400.12900@scrub.home>
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


A large number of lost ticks can cause an overadjustment of the clock.
To compensate for this we look at the current error and the larger the
error already is the more careful we are at adjusting the error.
As small extra fix reset the error when the clock is set.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 kernel/timer.c |   85 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-07-07 02:51:57.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-07-08 19:10:52.000000000 +0200
@@ -891,6 +891,7 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&xtime, sec, nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
+	clock->error = 0;
 	ntp_clear();
 
 	write_sequnlock_irqrestore(&xtime_lock, flags);
@@ -1008,52 +1009,52 @@ static int __init timekeeping_init_devic
 device_initcall(timekeeping_init_device);
 
 /*
- * If the error is already larger, we look ahead another tick,
+ * If the error is already larger, we look ahead even further
  * to compensate for late or lost adjustments.
  */
-static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 *interval, s64 *offset)
+static __always_inline int clocksource_bigadjust(s64 error, s64 *interval, s64 *offset)
 {
-	int adj;
+	s64 tick_error, i;
+	u32 look_ahead, adj;
+	s32 error2, mult;
 
 	/*
-	 * As soon as the machine is synchronized to the external time
-	 * source this should be the common case.
+	 * Use the current error value to determine how much to look ahead.
+	 * The larger the error the slower we adjust for it to avoid problems
+	 * with losing too many ticks, otherwise we would overadjust and
+	 * produce an even larger error.  The smaller the adjustment the
+	 * faster we try to adjust for it, as lost ticks can do less harm
+	 * here.  This is tuned so that an error of about 1 msec is adusted
+	 * within about 1 sec (or 2^20 nsec in 2^SHIFT_HZ ticks).
 	 */
-	error >>= 2;
-	if (likely(sign > 0 ? error <= *interval : error >= *interval))
-		return sign;
+	error2 = clock->error >> (TICK_LENGTH_SHIFT + 22 - 2 * SHIFT_HZ);
+	error2 = abs(error2);
+	for (look_ahead = 0; error2 > 0; look_ahead++)
+		error2 >>= 2;
 
 	/*
-	 * An extra look ahead dampens the effect of the current error,
-	 * which can grow quite large with continously late updates, as
-	 * it would dominate the adjustment value and can lead to
-	 * oscillation.
+	 * Now calculate the error in (1 << look_ahead) ticks, but first
+	 * remove the single look ahead already included in the error.
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
+	tick_error = current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
+	tick_error -= clock->xtime_interval >> 1;
+	error = ((error - tick_error) >> look_ahead) + tick_error;
+
+	/* Finally calculate the adjustment shift value.  */
+	i = *interval;
+	mult = 1;
+	if (error < 0) {
+		error = -error;
+		*interval = -*interval;
+		*offset = -*offset;
+		mult = -1;
 	}
-
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
+	for (adj = 0; error > i; adj++)
+		error >>= 1;
 
 	*interval <<= adj;
 	*offset <<= adj;
-	return sign << adj;
+	return mult << adj;
 }
 
 /*
@@ -1068,11 +1069,19 @@ static void clocksource_adjust(struct cl
 
 	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
 	if (error > interval) {
-		adj = clocksource_bigadjust(1, error, &interval, &offset);
+		error >>= 2;
+		if (likely(error <= interval))
+			adj = 1;
+		else
+			adj = clocksource_bigadjust(error, &interval, &offset);
 	} else if (error < -interval) {
-		interval = -interval;
-		offset = -offset;
-		adj = clocksource_bigadjust(-1, error, &interval, &offset);
+		error >>= 2;
+		if (likely(error >= -interval)) {
+			adj = -1;
+			interval = -interval;
+			offset = -offset;
+		} else
+			adj = clocksource_bigadjust(error, &interval, &offset);
 	} else
 		return;
 
@@ -1129,7 +1138,7 @@ static void update_wall_time(void)
 	clocksource_adjust(clock, offset);
 
 	/* store full nanoseconds into xtime */
-	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
+	xtime.tv_nsec = (s64)clock->xtime_nsec >> clock->shift;
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 
 	/* check to see if there is a new clocksource to use */

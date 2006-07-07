Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWGGSzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWGGSzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWGGSzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:55:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:34692 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932245AbWGGSzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:55:19 -0400
Subject: Re: boot errors in kernels 2.6.17-mm6 plus 2.6.18-rc1
From: john stultz <johnstul@us.ibm.com>
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20060707124552.9650@gmx.net>
References: <20060707124552.9650@gmx.net>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Jul 2006 11:55:15 -0700
Message-Id: <1152298515.5330.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 14:45 +0200, Uwe Bugla wrote:
> Hi Roman, hi John Stultz,
> Andrew told me that you were working on that issue.

Yep.

> I use Debian Etch in connection with latest kernel-headers and kernels.
> My system is a Pentium 4, the graphics card is an ATI Rage 128 Pro with 32 MB RAM.
> When I compile both mentioned kernels, I can activate FB and FB_VESA.
> But if I add „vga=791“ to menu.lst (i. e. as an additional parameter for the kernel to boot) two bugs happen:
> 1. The kernel takes an eternity to boot, taking about 4 long breaks to come up at all

This sounds very much like the "massive lost-ticks causing timekeeping
issues" bug. 

Roman is working on his version of this fix, but just to be sure we're
dealing with the same issue as the one Vladis saw, could you try the
following patch and let me know if it works for you?

Note that this doesn't fix the lost-tick issue, but tries to make the
timekeeping code more robust.

Andrew, its likely after we get this problem resolved we'll need another
detect-and-warn patch for this lost-ticks case so we don't just
wall-paper over bad pic/apic setups w/ robust timekeeping. Does that
sound reasonable?

thanks
-john

Implement P-D control for clocksource_adjust()

diff --git a/kernel/timer.c b/kernel/timer.c
index 396a3c0..f4e7681 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1007,81 +1007,108 @@ static int __init timekeeping_init_devic
 
 device_initcall(timekeeping_init_device);
 
-/*
- * If the error is already larger, we look ahead another tick,
- * to compensate for late or lost adjustments.
- */
-static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 *interval, s64 *offset)
+static int error_aproximation(u64 error, u64 unit, int max)
 {
-	int adj;
-
-	/*
-	 * As soon as the machine is synchronized to the external time
-	 * source this should be the common case.
-	 */
-	error >>= 2;
-	if (likely(sign > 0 ? error <= *interval : error >= *interval))
-		return sign;
-
-	/*
-	 * An extra look ahead dampens the effect of the current error,
-	 * which can grow quite large with continously late updates, as
-	 * it would dominate the adjustment value and can lead to
-	 * oscillation.
-	 */
-	error += current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
-	error -= clock->xtime_interval >> 1;
-
-	adj = 0;
+	int adj = 0;
 	while (1) {
 		error >>= 1;
-		if (sign > 0 ? error <= *interval : error >= *interval)
-			break;
-		adj++;
+		if (error <= unit)
+			return adj;
+		if (!max || adj < max)
+			adj++;
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
-
-	*interval <<= adj;
-	*offset <<= adj;
-	return sign << adj;
 }
+#define MAXOFFADJ 4 /* vary max oscillation vs convergance speed */
 
 /*
  * Adjust the multiplier to reduce the error value,
  * this is optimized for the most common adjustments of -1,0,1,
  * for other values we can do a bit more work.
  */
-static void clocksource_adjust(struct clocksource *clock, s64 offset)
+static void clocksource_adjust(struct clocksource *clock, s64 offset,
+				s64 interval_cycs, s64 interval_error)
 {
 	s64 error, interval = clock->cycle_interval;
-	int adj;
-
-	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
-	if (error > interval) {
-		adj = clocksource_bigadjust(1, error, &interval, &offset);
-	} else if (error < -interval) {
-		interval = -interval;
-		offset = -offset;
-		adj = clocksource_bigadjust(-1, error, &interval, &offset);
-	} else
-		return;
+	
+	error = shift_right(clock->error, (TICK_LENGTH_SHIFT - clock->shift));
+	interval_error = shift_right(interval_error, 
+					(TICK_LENGTH_SHIFT - clock->shift));
+
+	if ((error > interval)
+		||(error < -(interval)) ) {
+
+		int adj, multadj = 0;
+		s64 offset_update = 0, snsec_update = 0;
+		
+		/* First do the frequency adjustment:
+		 *   The idea here is to look at the error 
+		 *   accumulated since the last call to 
+		 *   update_wall_time to determine the 
+		 *   frequency adjustment needed so no new
+		 *   error will be incurred in the next
+		 *   interval.
+		 *
+		 *   This is basically derivative control
+		 *   using the PID terminology (we're calculating
+		 *   the derivative of the slope and correcting it).
+		 *
+		 *   The math is basically:
+		 *      multadj = interval_error/interval_cycles
+		 *   Which we fudge using binary approximation.
+		 */
+		if(interval_error >= 0) {
+			adj = error_aproximation(interval_error,
+						interval_cycs, 0);
+			multadj += 1 << adj;
+			snsec_update += interval << adj;
+			offset_update += offset << adj;
+		} else {
+			adj = error_aproximation(-interval_error, 
+						interval_cycs, 0);
+			multadj -= 1 << adj;
+			snsec_update -= interval << adj;
+			offset_update -= offset << adj;
+	        }
+		/* Now do the offset adjustment:
+		 *   Now that the frequncy is fixed, we
+		 *   want to look at the total error accumulated
+		 *   to move us back in sync using the same method.
+		 *   However, we must be careful as if we make too 
+		 *   sudden an adjustment we might overshoot. So we 
+		 *   limit the amount of change to spread the 
+		 *   adjustment (using MAXOFFADJ) over a longer 
+		 *   period of time.
+		 *
+		 *   This is basically proportional control
+		 *   using the PID terminology.
+		 *
+		 *   We use interval_cycs here as the divisor, which
+		 *   hopes that the next sample will be similar in 
+		 *   distance from the last.
+		 */
+		if(error >= 0) {
+			adj = error_aproximation(error, 
+					interval_cycs, MAXOFFADJ);
+			multadj += 1<<adj;
+			snsec_update += interval <<adj;
+			offset_update += offset << adj;
+		} else {
+			adj = error_aproximation(-error,
+						interval_cycs, MAXOFFADJ);
+			multadj -= 1<<adj;
+			snsec_update -= interval <<adj;
+			offset_update -= offset << adj;
+		}
 
-	clock->mult += adj;
-	clock->xtime_interval += interval;
-	clock->xtime_nsec -= offset;
-	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
+		clock->mult += multadj;
+		clock->xtime_interval += snsec_update;
+		clock->xtime_nsec -= offset_update;
+		clock->error += (offset_update) 
+					<< (TICK_LENGTH_SHIFT - clock->shift);
+	}
 }
 
+
 /*
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
@@ -1089,7 +1116,8 @@ static void clocksource_adjust(struct cl
  */
 static void update_wall_time(void)
 {
-	cycle_t offset;
+	cycle_t offset, interval_cycs = 0;
+	s64 interval_error = 0; 
 
 	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
 
@@ -1106,8 +1134,13 @@ static void update_wall_time(void)
 		/* accumulate one interval */
 		clock->xtime_nsec += clock->xtime_interval;
 		clock->cycle_last += clock->cycle_interval;
+		interval_cycs += clock->cycle_interval;
 		offset -= clock->cycle_interval;
 
+		/* accumulate error between NTP and clock interval */
+		interval_error += current_tick_length();
+		interval_error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
+
 		if (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
 			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
 			xtime.tv_sec++;
@@ -1119,14 +1152,10 @@ static void update_wall_time(void)
 						>> clock->shift);
 		/* increment the NTP state machine */
 		update_ntp_one_tick();
-
-		/* accumulate error between NTP and clock interval */
-		clock->error += current_tick_length();
-		clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
 	}
-
+	clock->error += interval_error;
 	/* correct the clock when NTP error is too big */
-	clocksource_adjust(clock, offset);
+	clocksource_adjust(clock, offset, interval_cycs, interval_error);
 
 	/* store full nanoseconds into xtime */
 	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;




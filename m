Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030695AbWI0Tft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030695AbWI0Tft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030696AbWI0Tft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:35:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:24493 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030695AbWI0Tfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:35:48 -0400
Subject: [RFC] exponential update_wall_time
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 12:35:33 -0700
Message-Id: <1159385734.29040.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Roman,
	Just wanted to run this by you for comment. Ingo was finding issues w/
update_wall_clock looping for too long when using dynticks. I also think
this will avoid the bad clocksource caused hangs that have been
occasionally reported (instead of looping forever, time will just
accumulate oddly), which will help point to the issue.

Anyway, just wanted to get your thoughts before I send it to Andrew for
more testing.

thanks
-john

Accumulate time in update_wall_time exponentially. 
This avoids long running loops seen with the dynticks patch
as well as the problematic hang" seen on systems with broken 
clocksources.

This applies on top of 2.6.18-mm1

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 kernel/timer.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

Index: linux-2.6.18/kernel/timer.c
===================================================================
--- linux-2.6.18.orig/kernel/timer.c	2006-09-20 16:17:54.000000000 +0200
+++ linux-2.6.18/kernel/timer.c	2006-09-20 16:17:59.000000000 +0200
@@ -902,6 +902,7 @@ static void clocksource_adjust(struct cl
 static void update_wall_time(void)
 {
 	cycle_t offset;
+	int shift = 0;
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
@@ -914,28 +915,39 @@ static void update_wall_time(void)
 #endif
 	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
 
+	while (offset > clock->cycle_interval << (shift + 1))
+		shift++;
+
 	/* normally this loop will run just once, however in the
 	 * case of lost or late ticks, it will accumulate correctly.
 	 */
 	while (offset >= clock->cycle_interval) {
+		if (offset < (clock->cycle_interval << shift)) {
+			shift--;
+			continue;
+		}
+
 		/* accumulate one interval */
-		clock->xtime_nsec += clock->xtime_interval;
-		clock->cycle_last += clock->cycle_interval;
-		offset -= clock->cycle_interval;
+		clock->xtime_nsec += clock->xtime_interval << shift;
+		clock->cycle_last += clock->cycle_interval << shift;
+		offset -= clock->cycle_interval << shift;
 
-		if (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
+		while (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
 			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
 			xtime.tv_sec++;
 			second_overflow();
 		}
 
 		/* interpolator bits */
-		time_interpolator_update(clock->xtime_interval
-						>> clock->shift);
+		time_interpolator_update((clock->xtime_interval
+						>> clock->shift)<<shift);
 
 		/* accumulate error between NTP and clock interval */
-		clock->error += current_tick_length();
-		clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
+		clock->error += current_tick_length() << shift;
+		clock->error -= (clock->xtime_interval
+			<< (TICK_LENGTH_SHIFT - clock->shift))<<shift;
+
+		shift--;
 	}
 
 	/* correct the clock when NTP error is too big */



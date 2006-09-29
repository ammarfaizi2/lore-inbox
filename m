Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWI3AD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWI3AD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWI3AD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:03:58 -0400
Received: from www.osadl.org ([213.239.205.134]:63891 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932365AbWI3AD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:03:57 -0400
Message-Id: <20060929234438.937909000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 01/23] GTOD: exponential update_wall_time
Content-Disposition: inline; filename=update-times-exponential.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <johnstul@us.ibm.com>

Accumulate time in update_wall_time() exponentially.  This avoids long
running loops seen with the dynticks patch as well as the problematic
hang seen on systems with broken clocksources.

NOTE: this only has relevance on dyntick kernels, so the quality of
NTP updates on jiffies-tick systems is unaffected. (non-dyntick
kernels call update_wall_time() in every timer tick)

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--

 kernel/timer.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm2/kernel/timer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/timer.c	2006-09-30 01:41:14.000000000 +0200
+++ linux-2.6.18-mm2/kernel/timer.c	2006-09-30 01:41:14.000000000 +0200
@@ -907,6 +907,7 @@ static void clocksource_adjust(struct cl
 static void update_wall_time(void)
 {
 	cycle_t offset;
+	int shift = 0;
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
@@ -919,28 +920,39 @@ static void update_wall_time(void)
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

--


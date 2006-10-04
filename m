Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWJDRht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWJDRht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWJDRht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:37:49 -0400
Received: from www.osadl.org ([213.239.205.134]:64740 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161156AbWJDRhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:48 -0400
Message-Id: <20061004172221.967912000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:31 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 01/22] GTOD: exponential update_wall_time
Content-Disposition: inline; filename=gtod-exponential-update_wall_time.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <johnstul@us.ibm.com>

Accumulate time in update_wall_time() exponentially.  This avoids long running
loops seen with the dynticks patch as well as the problematic hang seen on
systems with broken clocksources.

NOTE: this only has relevance on dyntick kernels, so the quality of NTP
updates on jiffies-tick systems is unaffected.  (non-dyntick kernels call
update_wall_time() in every timer tick)

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 kernel/timer.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm3/kernel/timer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/timer.c	2006-10-04 18:13:53.000000000 +0200
+++ linux-2.6.18-mm3/kernel/timer.c	2006-10-04 18:13:53.000000000 +0200
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


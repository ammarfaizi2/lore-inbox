Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWHDD2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWHDD2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWHDD0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:26:13 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:15817 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030316AbWHDDZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:55 -0400
Message-Id: <20060804032522.865606000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:22 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 08/10] -mm  clocksource: cleanup on -mm
Content-Disposition: inline; filename=clocksource_api_cleanup_on_mm.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some additional clean up only on the -mm tree. Moves the adjust
functions into kernel/time/clocksource.c . 

These functions directly modify the clocksource multiplier based
on ntp error. These adjustments will effect other users of that 
clock. This hasn't been  addressed in my patch set, since it 
needs some discussion.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/clocksource.h |    1 
 kernel/time/clocksource.c   |   90 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c              |   83 ----------------------------------------
 3 files changed, 91 insertions(+), 83 deletions(-)

Index: linux-2.6.17/include/linux/clocksource.h
===================================================================
--- linux-2.6.17.orig/include/linux/clocksource.h
+++ linux-2.6.17/include/linux/clocksource.h
@@ -217,6 +217,7 @@ extern int clocksource_sysfs_register(st
 extern void clocksource_sysfs_unregister(struct sysdev_attribute*);
 extern void clocksource_rating_change(struct clocksource*);
 extern struct clocksource * clocksource_get_clock(char*);
+extern void clocksource_adjust(struct clocksource *, s64);
 
 /**
  * clocksource_get_best_clock - Finds highest rated clocksource
Index: linux-2.6.17/kernel/time/clocksource.c
===================================================================
--- linux-2.6.17.orig/kernel/time/clocksource.c
+++ linux-2.6.17/kernel/time/clocksource.c
@@ -57,6 +57,96 @@ int clocksource_notifier_register(struct
 	return atomic_notifier_chain_register(&clocksource_list_notifier, nb);
 }
 
+/*
+ * If the error is already larger, we look ahead even further
+ * to compensate for late or lost adjustments.
+ */
+static __always_inline int
+clocksource_bigadjust(struct clocksource *clock, s64 error, s64 *interval,
+		      s64 *offset)
+{
+	s64 tick_error, i;
+	u32 look_ahead, adj;
+	s32 error2, mult;
+
+	/*
+	 * Use the current error value to determine how much to look ahead.
+	 * The larger the error the slower we adjust for it to avoid problems
+	 * with losing too many ticks, otherwise we would overadjust and
+	 * produce an even larger error.  The smaller the adjustment the
+	 * faster we try to adjust for it, as lost ticks can do less harm
+	 * here.  This is tuned so that an error of about 1 msec is adusted
+	 * within about 1 sec (or 2^20 nsec in 2^SHIFT_HZ ticks).
+	 */
+	error2 = clock->error >> (TICK_LENGTH_SHIFT + 22 - 2 * SHIFT_HZ);
+	error2 = abs(error2);
+	for (look_ahead = 0; error2 > 0; look_ahead++)
+		error2 >>= 2;
+
+	/*
+	 * Now calculate the error in (1 << look_ahead) ticks, but first
+	 * remove the single look ahead already included in the error.
+	 */
+	tick_error = current_tick_length() >>
+		     (TICK_LENGTH_SHIFT - clock->shift + 1);
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
+	}
+	for (adj = 0; error > i; adj++)
+		error >>= 1;
+
+	*interval <<= adj;
+	*offset <<= adj;
+	return mult << adj;
+}
+
+/*
+ * Adjust the multiplier to reduce the error value,
+ * this is optimized for the most common adjustments of -1,0,1,
+ * for other values we can do a bit more work.
+ */
+void clocksource_adjust(struct clocksource *clock, s64 offset)
+{
+	s64 error, interval = clock->cycle_interval;
+	int adj;
+
+	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
+	if (error > interval) {
+		error >>= 2;
+		if (likely(error <= interval))
+			adj = 1;
+		else
+			adj = clocksource_bigadjust(clock, error, &interval,
+						    &offset);
+	} else if (error < -interval) {
+		error >>= 2;
+		if (likely(error >= -interval)) {
+			adj = -1;
+			interval = -interval;
+			offset = -offset;
+		} else
+			adj = clocksource_bigadjust(clock, error, &interval,
+						    &offset);
+	} else
+		return;
+
+	clock->mult += adj;
+	clock->xtime_interval += interval;
+	clock->xtime_nsec -= offset;
+	clock->error -= (interval - offset) <<
+			(TICK_LENGTH_SHIFT - clock->shift);
+}
+
+
 /**
  * __is_registered - Returns a clocksource if it's registered
  * @name:		name of the clocksource to return
Index: linux-2.6.17/kernel/timer.c
===================================================================
--- linux-2.6.17.orig/kernel/timer.c
+++ linux-2.6.17/kernel/timer.c
@@ -1140,89 +1140,6 @@ static int __init timekeeping_init_devic
 device_initcall(timekeeping_init_device);
 
 /*
- * If the error is already larger, we look ahead even further
- * to compensate for late or lost adjustments.
- */
-static __always_inline int clocksource_bigadjust(s64 error, s64 *interval, s64 *offset)
-{
-	s64 tick_error, i;
-	u32 look_ahead, adj;
-	s32 error2, mult;
-
-	/*
-	 * Use the current error value to determine how much to look ahead.
-	 * The larger the error the slower we adjust for it to avoid problems
-	 * with losing too many ticks, otherwise we would overadjust and
-	 * produce an even larger error.  The smaller the adjustment the
-	 * faster we try to adjust for it, as lost ticks can do less harm
-	 * here.  This is tuned so that an error of about 1 msec is adusted
-	 * within about 1 sec (or 2^20 nsec in 2^SHIFT_HZ ticks).
-	 */
-	error2 = clock->error >> (TICK_LENGTH_SHIFT + 22 - 2 * SHIFT_HZ);
-	error2 = abs(error2);
-	for (look_ahead = 0; error2 > 0; look_ahead++)
-		error2 >>= 2;
-
-	/*
-	 * Now calculate the error in (1 << look_ahead) ticks, but first
-	 * remove the single look ahead already included in the error.
-	 */
-	tick_error = current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
-	tick_error -= clock->xtime_interval >> 1;
-	error = ((error - tick_error) >> look_ahead) + tick_error;
-
-	/* Finally calculate the adjustment shift value.  */
-	i = *interval;
-	mult = 1;
-	if (error < 0) {
-		error = -error;
-		*interval = -*interval;
-		*offset = -*offset;
-		mult = -1;
-	}
-	for (adj = 0; error > i; adj++)
-		error >>= 1;
-
-	*interval <<= adj;
-	*offset <<= adj;
-	return mult << adj;
-}
-
-/*
- * Adjust the multiplier to reduce the error value,
- * this is optimized for the most common adjustments of -1,0,1,
- * for other values we can do a bit more work.
- */
-static void clocksource_adjust(struct clocksource *clock, s64 offset)
-{
-	s64 error, interval = clock->cycle_interval;
-	int adj;
-
-	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
-	if (error > interval) {
-		error >>= 2;
-		if (likely(error <= interval))
-			adj = 1;
-		else
-			adj = clocksource_bigadjust(error, &interval, &offset);
-	} else if (error < -interval) {
-		error >>= 2;
-		if (likely(error >= -interval)) {
-			adj = -1;
-			interval = -interval;
-			offset = -offset;
-		} else
-			adj = clocksource_bigadjust(error, &interval, &offset);
-	} else
-		return;
-
-	clock->mult += adj;
-	clock->xtime_interval += interval;
-	clock->xtime_nsec -= offset;
-	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
-}
-
-/*
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
  * Called from the timer interrupt, must hold a write on xtime_lock.

--

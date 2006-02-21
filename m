Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWBUGWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWBUGWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWBUGWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:49065 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161434AbWBUGVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:48 -0500
Date: Mon, 20 Feb 2006 23:21:46 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Message-Id: <20060221062146.13304.76302.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 7/11] Time: generic timekeeping infrastructure - wall_offset helper cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up some of the wall_time offset manipulations
with a  __set_wall_time_offset() helper.

Also fixes some whitespaces.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Documentation/timekeeping.txt   |    2 
 include/asm-generic/timeofday.h |    2 
 include/linux/time.h            |    7 --
 kernel/time/clocksource.c       |    1 
 kernel/time/timeofday.c         |   97 +++++++++++++++++++---------------------
 kernel/timer.c                  |    1 
 6 files changed, 53 insertions(+), 57 deletions(-)

Index: mm-merge/kernel/timer.c
===================================================================
--- mm-merge.orig/kernel/timer.c
+++ mm-merge/kernel/timer.c
@@ -882,7 +882,6 @@ void ntp_advance(unsigned long interval_
 	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
 
-
 #ifdef CONFIG_GENERIC_TIME
 # define update_wall_time(x) do { } while (0)
 #else
Index: mm-merge/kernel/time/clocksource.c
===================================================================
--- mm-merge.orig/kernel/time/clocksource.c
+++ mm-merge/kernel/time/clocksource.c
@@ -155,6 +155,7 @@ int register_clocksource(struct clocksou
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 	return ret;
 }
+
 EXPORT_SYMBOL(register_clocksource);
 
 /**
Index: mm-merge/kernel/time/timeofday.c
===================================================================
--- mm-merge.orig/kernel/time/timeofday.c
+++ mm-merge/kernel/time/timeofday.c
@@ -338,6 +338,35 @@ void do_gettimeofday(struct timeval *tv)
 EXPORT_SYMBOL(do_gettimeofday);
 
 /**
+ * __increment_system_time - Increments system time
+ * @delta:	nanosecond delta to add to the time variables
+ *
+ * Private helper that increments system_time and related
+ * timekeeping variables.
+ */
+static void __increment_system_time(s64 delta)
+{
+	system_time = ktime_add_ns(system_time, delta);
+	timespec_add_ns(&wall_time_ts, delta);
+	timespec_add_ns(&mono_time_ts, delta);
+}
+
+/**
+ * __set_wall_time_offset - Sets the wall time offset
+ * @delta:	nanosecond delta to adjust to the time variables
+ *
+ * Private helper that adjusts wall_time_offset and related
+ * timekeeping variables.
+ */
+static void __set_wall_time_offset(ktime_t val)
+{
+	wall_time_offset = val;
+	wall_time_ts = ktime_to_timespec(ktime_add(system_time,
+						wall_time_offset));
+	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+}
+
+/**
  * do_settimeofday - Sets the time of day
  * @tv:		pointer to the timespec variable containing the new time
  *
@@ -356,12 +385,7 @@ int do_settimeofday(struct timespec *tv)
 	write_seqlock_irqsave(&system_time_lock, flags);
 
 	/* calculate the new offset from the monotonic clock */
-	wall_time_offset = ktime_sub(newtime, __get_monotonic_clock());
-
-	/* update the internal timespec variables */
-	wall_time_ts = ktime_to_timespec(ktime_add(system_time,
-						wall_time_offset));
-	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+	__set_wall_time_offset(ktime_sub(newtime, __get_monotonic_clock()));
 
 	ntp_clear();
 	update_legacy_time_values();
@@ -377,20 +401,6 @@ int do_settimeofday(struct timespec *tv)
 EXPORT_SYMBOL(do_settimeofday);
 
 /**
- * __increment_system_time - Increments system time
- * @delta:	nanosecond delta to add to the time variables
- *
- * Private helper that increments system_time and related
- * timekeeping variables.
- */
-static void __increment_system_time(nsec_t delta)
-{
-	system_time = ktime_add_ns(system_time, delta);
-	timespec_add_ns(&wall_time_ts, delta);
-	timespec_add_ns(&mono_time_ts, delta);
-}
-
-/**
  * timeofday_suspend_hook - allows the timeofday subsystem to be shutdown
  * @dev:	unused
  * @state:	unused
@@ -539,12 +549,9 @@ static void timeofday_periodic_hook(unsi
 	if (second_check >= NSEC_PER_SEC) {
 		/* do ntp leap second processing: */
 		leapsecond = ntp_leapsecond(wall_time_ts);
-		if (leapsecond) {
-			wall_time_offset = ktime_add_ns(wall_time_offset,
-						leapsecond * NSEC_PER_SEC);
-			wall_time_ts.tv_sec += leapsecond;
-			monotonic_time_offset_ts.tv_sec += leapsecond;
-		}
+		if (leapsecond)
+			__set_wall_time_offset(ktime_add_ns(wall_time_offset,
+						leapsecond * NSEC_PER_SEC));
 		second_check -= NSEC_PER_SEC;
 	}
 	/* sync the persistent clock: */
@@ -662,13 +669,8 @@ void __init timeofday_init(void)
 
 	/* initialize wall_time_offset to now: */
 	/* XXX - this should be something like ns_to_ktime() */
-	wall_time_offset = ktime_add_ns(wall_time_offset,
-					read_persistent_clock());
-
-	/* initialize timespec values: */
-	wall_time_ts = ktime_to_timespec(ktime_add(system_time,
-						wall_time_offset));
-	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+	__set_wall_time_offset(ktime_add_ns(wall_time_offset,
+					read_persistent_clock()));
 
 	/* clear NTP scaling factor & state machine: */
 	ntp_adj = 0;

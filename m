Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWHICRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWHICRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHICRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22194 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751245AbWHICRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:19 -0400
Date: Tue, 8 Aug 2006 22:17:14 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021714.23103.24280.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 1/6] x86_64: Enable arch-generic vsyscall support.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides generic infrastructure for vsyscall-gtod.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/clocksource.h |    2 ++
 kernel/timer.c              |    7 +++++++
 2 files changed, 9 insertions(+)

linux-2.6.18-rc4_timeofday-vsyscall-support_C5.patch
============================================
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d852024..f554273 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -46,6 +46,7 @@ typedef u64 cycle_t;
  * @shift:		cycle to nanosecond divisor (power of two)
  * @update_callback:	called when safe to alter clocksource values
  * @is_continuous:	defines if clocksource is free-running.
+ * @vread:		vsyscall based read
  * @cycle_interval:	Used internally by timekeeping core, please ignore.
  * @xtime_interval:	Used internally by timekeeping core, please ignore.
  */
@@ -59,6 +60,7 @@ struct clocksource {
 	u32 shift;
 	int (*update_callback)(void);
 	int is_continuous;
+	cycle_t (*vread)(void);
 
 	/* timekeeping specific data, ignore */
 	cycle_t cycle_last, cycle_interval;
diff --git a/kernel/timer.c b/kernel/timer.c
index b650f04..08b4a02 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1023,6 +1023,12 @@ static int __init timekeeping_init_devic
 
 device_initcall(timekeeping_init_device);
 
+#ifdef CONFIG_GENERIC_TIME_VSYSCALL
+extern void update_vsyscall(struct timespec* ts, struct clocksource* c);
+#else
+#define update_vsyscall(now, c)
+#endif
+
 /*
  * If the error is already larger, we look ahead even further
  * to compensate for late or lost adjustments.
@@ -1165,6 +1171,7 @@ static void update_wall_time(void)
 		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
+	update_vsyscall(&xtime, clock);
 }
 
 /*

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757046AbWK2DA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbWK2DA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 22:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757080AbWK2DA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 22:00:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61161 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1757046AbWK2DA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 22:00:26 -0500
Date: Tue, 28 Nov 2006 22:00:24 -0500
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Message-Id: <20061129025734.15379.47057.sendpatchset@localhost>
In-Reply-To: <20061129025728.15379.50707.sendpatchset@localhost>
References: <20061129025728.15379.50707.sendpatchset@localhost>
Subject: [PATCH 1/5][time][Generic] vsyscall-gtod support for GENERIC_TIME
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides generic infrastructure for vsyscall-gtod.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/clocksource.h |    8 ++++++++
 kernel/timer.c              |    1 +
 2 files changed, 9 insertions(+)

linux-2.6.19-rc6git11_timeofday-vsyscall-support_C7.patch
============================================
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d852024..62a600d 100644
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
@@ -182,4 +184,10 @@ int clocksource_register(struct clocksou
 void clocksource_reselect(void);
 struct clocksource* clocksource_get_next(void);
 
+#ifdef CONFIG_GENERIC_TIME_VSYSCALL
+extern void update_vsyscall(struct timespec *ts, struct clocksource *c);
+#else
+#define update_vsyscall(now, c) do { } while(0)
+#endif
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/timer.c b/kernel/timer.c
index c1c7fbc..38fd4a7 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -956,6 +956,7 @@ #endif
 		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
+	update_vsyscall(&xtime, clock);
 }
 
 /*

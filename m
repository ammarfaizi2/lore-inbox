Return-Path: <linux-kernel-owner+w=401wt.eu-S1030378AbWLTWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWLTWNa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWLTWNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:13:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37170 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030378AbWLTWN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:13:28 -0500
Date: Wed, 20 Dec 2006 17:13:25 -0500
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Valdis.Kletnieks@vt.edu, john stultz <johnstul@us.ibm.com>
Message-Id: <20061220220951.15178.41640.sendpatchset@localhost>
In-Reply-To: <20061220220945.15178.2669.sendpatchset@localhost>
References: <20061220220945.15178.2669.sendpatchset@localhost>
Subject: [PATCH -mm 1/5][time][generic] vsyscall-gtod support for GENERIC_TIME
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides generic infrastructure for vsyscall-gtod.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/clocksource.h |    8 ++++++++
 kernel/timer.c              |    1 +
 2 files changed, 9 insertions(+)

linux-2.6.20-rc1_timeofday-vsyscall-support_C7.patch
============================================
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1622d23..6899ef3 100644
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
index feddf81..d7a41e7 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1094,6 +1094,7 @@ #endif
 		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
+	update_vsyscall(&xtime, clock);
 }
 
 /*

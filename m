Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWIGCSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWIGCSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWIGCSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:18:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1228 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422655AbWIGCSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:18:51 -0400
Date: Wed, 6 Sep 2006 20:18:49 -0600
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060907021826.31476.38224.sendpatchset@localhost>
In-Reply-To: <20060907021820.31476.17484.sendpatchset@localhost>
References: <20060907021820.31476.17484.sendpatchset@localhost>
Subject: [PATCH 1/6] x86_64: Enable arch-generic vsyscall support.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides generic infrastructure for vsyscall-gtod.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/clocksource.h |    8 ++++++++
 include/linux/time.h        |    1 +
 kernel/timer.c              |    1 +
 3 files changed, 10 insertions(+)

linux-2.6.18-rc6_timeofday-vsyscall-support_C6.patch
============================================
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d852024..cd4d514 100644
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
+extern void update_vsyscall(struct timespec* ts, struct clocksource* c);
+#else
+#define update_vsyscall(now, c) do { } while(0)
+#endif
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/time.h b/include/linux/time.h
index a5b7399..14e12f0 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -174,6 +174,7 @@ static inline void timespec_add_ns(struc
 	}
 	a->tv_nsec = ns;
 }
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
diff --git a/kernel/timer.c b/kernel/timer.c
index 1d7dd62..a444016 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1165,6 +1165,7 @@ static void update_wall_time(void)
 		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
+	update_vsyscall(&xtime, clock);
 }
 
 /*

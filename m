Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWALXxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWALXxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWALXxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:53:38 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:907
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751425AbWALXxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:53:38 -0500
Subject: [PATCH-mm] Use generic timeofday interfaces in hrtimer / ktime
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 00:53:40 +0100
Message-Id: <1137110020.7634.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_GENERIC_TIME is enabled use the ktime_t based interfaces
of timeofday. Also disable the timespec based interfaces in hrtimers 
and use the timeofday interfaces directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/hrtimer.h |    1 +
 include/linux/ktime.h   |   11 +++++++++++
 kernel/hrtimer.c        |   47 ++++++++++++++++++++++++-----------------------
 3 files changed, 36 insertions(+), 23 deletions(-)

Index: linux-2.6.15-mm/include/linux/hrtimer.h
===================================================================
--- linux-2.6.15-mm.orig/include/linux/hrtimer.h
+++ linux-2.6.15-mm/include/linux/hrtimer.h
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/wait.h>
+#include <linux/timeofday.h>
 
 /*
  * Mode arguments of xxx_hrtimer functions:
Index: linux-2.6.15-mm/include/linux/ktime.h
===================================================================
--- linux-2.6.15-mm.orig/include/linux/ktime.h
+++ linux-2.6.15-mm/include/linux/ktime.h
@@ -275,10 +275,21 @@ static inline u64 ktime_to_ns(const ktim
 #define KTIME_REALTIME_RES	(NSEC_PER_SEC/HZ)
 #define KTIME_MONOTONIC_RES	(NSEC_PER_SEC/HZ)
 
+#ifdef CONFIG_GENERIC_TIME
+
+#define ktime_get		get_monotonic_clock
+#define ktime_get_real		get_realtime_clock
+#define ktime_get_ts(ts)	get_monotonic_clock_ts(ts)
+#define ktime_get_real_ts(ts)	get_realtime_clock_ts(ts)
+
+#else /* CONFIG_GENERIC_TIME */
+
 /* Get the monotonic time in timespec format: */
 extern void ktime_get_ts(struct timespec *ts);
 
 /* Get the real (wall-) time in timespec format: */
 #define ktime_get_real_ts(ts)	getnstimeofday(ts)
 
+#endif /* !CONFIG_GENERIC_TIME */
+
 #endif
Index: linux-2.6.15-mm/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-mm.orig/kernel/hrtimer.c
+++ linux-2.6.15-mm/kernel/hrtimer.c
@@ -29,12 +29,13 @@
 #include <linux/percpu.h>
 #include <linux/hrtimer.h>
 #include <linux/notifier.h>
-#include <linux/timeofday.h>
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 
 #include <asm/uaccess.h>
 
+#ifndef CONFIG_GENERIC_TIME
+
 /**
  * ktime_get - get the monotonic time in ktime_t format
  *
@@ -62,29 +63,8 @@ static ktime_t ktime_get_real(void)
 
 	return timespec_to_ktime(now);
 }
-
 EXPORT_SYMBOL_GPL(ktime_get_real);
 
-/*
- * The timer bases:
- */
-
-#define MAX_HRTIMER_BASES 2
-
-static DEFINE_PER_CPU(struct hrtimer_base, hrtimer_bases[MAX_HRTIMER_BASES]) =
-{
-	{
-		.index = CLOCK_REALTIME,
-		.get_time = &ktime_get_real,
-		.resolution = KTIME_REALTIME_RES,
-	},
-	{
-		.index = CLOCK_MONOTONIC,
-		.get_time = &ktime_get,
-		.resolution = KTIME_MONOTONIC_RES,
-	},
-};
-
 /**
  * ktime_get_ts - get the monotonic clock in timespec format
  *
@@ -111,6 +91,28 @@ void ktime_get_ts(struct timespec *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_ts);
 
+#endif
+
+/*
+ * The timer bases:
+ */
+
+#define MAX_HRTIMER_BASES 2
+
+static DEFINE_PER_CPU(struct hrtimer_base, hrtimer_bases[MAX_HRTIMER_BASES]) =
+{
+	{
+		.index = CLOCK_REALTIME,
+		.get_time = &ktime_get_real,
+		.resolution = KTIME_REALTIME_RES,
+	},
+	{
+		.index = CLOCK_MONOTONIC,
+		.get_time = &ktime_get,
+		.resolution = KTIME_MONOTONIC_RES,
+	},
+};
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
Index: linux-2.6.15-mm/kernel/time/timeofday.c
===================================================================
--- linux-2.6.15-mm.orig/kernel/time/timeofday.c
+++ linux-2.6.15-mm/kernel/time/timeofday.c
@@ -238,6 +238,8 @@ ktime_t get_realtime_clock(void)
 	return ret;
 }
 
+EXPORT_SYMBOL_GPL(get_realtime_clock);
+
 /**
  * get_realtime_offset - Returns the offset of realtime clock
  *



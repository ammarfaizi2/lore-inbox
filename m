Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCLKir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCLKir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWCLKhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:37:35 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31718
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751451AbWCLKhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:37:01 -0500
Message-Id: <20060312080332.750088000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:21 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 8/8] Remove nsec_t typedef
Content-Disposition: inline; filename=remove-nsec_t.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

nsec_t predates ktime_t and has mostly been superseded by it. In the few
places that are left it's better to make it explicit that we're dealing
with 64 bit values here.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <johnstul@us.ibm.com>

 include/linux/time.h |   18 ++++++------------
 kernel/time.c        |    4 ++--
 2 files changed, 8 insertions(+), 14 deletions(-)

Index: linux-2.6.16-updates/include/linux/time.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/time.h
+++ linux-2.6.16-updates/include/linux/time.h
@@ -73,12 +73,6 @@ extern void set_normalized_timespec(stru
 #define timespec_valid(ts) \
 	(((ts)->tv_sec >= 0) && (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC))
 
-/*
- * 64-bit nanosec type. Large enough to span 292+ years in nanosecond
- * resolution. Ought to be enough for a while.
- */
-typedef s64 nsec_t;
-
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
@@ -113,9 +107,9 @@ extern struct timespec timespec_trunc(st
  * Returns the scalar nanosecond representation of the timespec
  * parameter.
  */
-static inline nsec_t timespec_to_ns(const struct timespec *ts)
+static inline s64 timespec_to_ns(const struct timespec *ts)
 {
-	return ((nsec_t) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
+	return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
 }
 
 /**
@@ -125,9 +119,9 @@ static inline nsec_t timespec_to_ns(cons
  * Returns the scalar nanosecond representation of the timeval
  * parameter.
  */
-static inline nsec_t timeval_to_ns(const struct timeval *tv)
+static inline s64 timeval_to_ns(const struct timeval *tv)
 {
-	return ((nsec_t) tv->tv_sec * NSEC_PER_SEC) +
+	return ((s64) tv->tv_sec * NSEC_PER_SEC) +
 		tv->tv_usec * NSEC_PER_USEC;
 }
 
@@ -137,7 +131,7 @@ static inline nsec_t timeval_to_ns(const
  *
  * Returns the timespec representation of the nsec parameter.
  */
-extern struct timespec ns_to_timespec(const nsec_t nsec);
+extern struct timespec ns_to_timespec(const s64 nsec);
 
 /**
  * ns_to_timeval - Convert nanoseconds to timeval
@@ -145,7 +139,7 @@ extern struct timespec ns_to_timespec(co
  *
  * Returns the timeval representation of the nsec parameter.
  */
-extern struct timeval ns_to_timeval(const nsec_t nsec);
+extern struct timeval ns_to_timeval(const s64 nsec);
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6.16-updates/kernel/time.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/time.c
+++ linux-2.6.16-updates/kernel/time.c
@@ -637,7 +637,7 @@ void set_normalized_timespec(struct time
  *
  * Returns the timespec representation of the nsec parameter.
  */
-struct timespec ns_to_timespec(const nsec_t nsec)
+struct timespec ns_to_timespec(const s64 nsec)
 {
 	struct timespec ts;
 
@@ -657,7 +657,7 @@ struct timespec ns_to_timespec(const nse
  *
  * Returns the timeval representation of the nsec parameter.
  */
-struct timeval ns_to_timeval(const nsec_t nsec)
+struct timeval ns_to_timeval(const s64 nsec)
 {
 	struct timespec ts = ns_to_timespec(nsec);
 	struct timeval tv;
Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -266,7 +266,7 @@ ktime_t ktime_add_ns(const ktime_t kt, u
 /*
  * Divide a ktime value by a nanosecond value
  */
-static unsigned long ktime_divns(const ktime_t kt, nsec_t div)
+static unsigned long ktime_divns(const ktime_t kt, s64 div)
 {
 	u64 dclc, inc, dns;
 	int sft = 0;
@@ -322,7 +322,7 @@ hrtimer_forward(struct hrtimer *timer, k
 		interval.tv64 = timer->base->resolution.tv64;
 
 	if (unlikely(delta.tv64 >= interval.tv64)) {
-		nsec_t incr = ktime_to_ns(interval);
+		s64 incr = ktime_to_ns(interval);
 
 		orun = ktime_divns(delta, incr);
 		timer->expires = ktime_add_ns(timer->expires, incr * orun);

--


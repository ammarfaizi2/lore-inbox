Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbWBNKN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbWBNKN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWBNKNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:13:09 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42730 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030316AbWBNKND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:13:03 -0500
Date: Tue, 14 Feb 2006 11:12:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 12/12] hrtimer: remove nsec_t
Message-ID: <Pine.LNX.4.61.0602141112530.3751@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nsec_t predates ktime_t and has mostly been superseded by it. In the few
places that are left it's better to make it explicit that we're dealing
with 64 bit values here.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <johnstul@us.ibm.com>

---

 include/linux/time.h |   18 ++++++------------
 kernel/hrtimer.c     |    4 ++--
 kernel/time.c        |    4 ++--
 3 files changed, 10 insertions(+), 16 deletions(-)

Index: linux-2.6-git/include/linux/time.h
===================================================================
--- linux-2.6-git.orig/include/linux/time.h	2006-02-13 22:30:21.000000000 +0100
+++ linux-2.6-git/include/linux/time.h	2006-02-13 22:30:23.000000000 +0100
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
-static inline nsec_t timespec_to_nsec(const struct timespec *ts)
+static inline s64 timespec_to_nsec(const struct timespec *ts)
 {
-	return ((nsec_t) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
+	return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
 }
 
 /**
@@ -125,9 +119,9 @@ static inline nsec_t timespec_to_nsec(co
  * Returns the scalar nanosecond representation of the timeval
  * parameter.
  */
-static inline nsec_t timeval_to_nsec(const struct timeval *tv)
+static inline s64 timeval_to_nsec(const struct timeval *tv)
 {
-	return ((nsec_t) tv->tv_sec * NSEC_PER_SEC) +
+	return ((s64) tv->tv_sec * NSEC_PER_SEC) +
 		tv->tv_usec * NSEC_PER_USEC;
 }
 
@@ -137,7 +131,7 @@ static inline nsec_t timeval_to_nsec(con
  *
  * Returns the timespec representation of the nsec parameter.
  */
-extern struct timespec nsec_to_timespec(nsec_t nsec);
+extern struct timespec nsec_to_timespec(s64 nsec);
 
 /**
  * nsec_to_timeval - Convert nanoseconds to timeval
@@ -145,7 +139,7 @@ extern struct timespec nsec_to_timespec(
  *
  * Returns the timeval representation of the nsec parameter.
  */
-extern struct timeval nsec_to_timeval(nsec_t nsec);
+extern struct timeval nsec_to_timeval(s64 nsec);
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-13 22:30:21.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-13 22:30:23.000000000 +0100
@@ -246,7 +246,7 @@ ktime_t ktime_add_nsec(ktime_t kt, u64 n
 /*
  * Divide a ktime value by a nanosecond value
  */
-static unsigned long ktime_div_nsec(const ktime_t kt, nsec_t div)
+static unsigned long ktime_div_nsec(const ktime_t kt, s64 div)
 {
 	u64 dclc, inc, dns;
 	int sft = 0;
@@ -302,7 +302,7 @@ hrtimer_forward(struct hrtimer *timer, k
 		interval.tv64 = timer->base->resolution.tv64;
 
 	if (unlikely(delta.tv64 >= interval.tv64)) {
-		nsec_t incr = ktime_to_nsec(interval);
+		s64 incr = ktime_to_nsec(interval);
 
 		orun = ktime_div_nsec(delta, incr);
 		timer->expires = ktime_add_nsec(timer->expires, incr * orun);
Index: linux-2.6-git/kernel/time.c
===================================================================
--- linux-2.6-git.orig/kernel/time.c	2006-02-13 22:30:21.000000000 +0100
+++ linux-2.6-git/kernel/time.c	2006-02-13 22:30:23.000000000 +0100
@@ -637,7 +637,7 @@ void set_normalized_timespec(struct time
  *
  * Returns the timespec representation of the nsec parameter.
  */
-struct timespec nsec_to_timespec(nsec_t nsec)
+struct timespec nsec_to_timespec(s64 nsec)
 {
 	struct timespec ts;
 
@@ -657,7 +657,7 @@ struct timespec nsec_to_timespec(nsec_t 
  *
  * Returns the timeval representation of the nsec parameter.
  */
-struct timeval nsec_to_timeval(nsec_t nsec)
+struct timeval nsec_to_timeval(s64 nsec)
 {
 	struct timespec ts = nsec_to_timespec(nsec);
 	struct timeval tv;

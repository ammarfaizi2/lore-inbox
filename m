Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUGNQoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUGNQoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUGNQoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:44:11 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:25123 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267452AbUGNQl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:41:28 -0400
Date: Wed, 14 Jul 2004 09:41:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
cc: linux-ia64@vger.kernel.org
Subject: gettimeofday nanoseconds patch (makes it possible for the posix-timer
 functions to return higher accuracy)
Message-ID: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on some timer issues for the IA64 in order to make the timers
more efficient and return results with a higher accuracy.

However, in various locations do_gettimeofday is used and then the
resulting usecs are multiplied by 1000 to obtain nanoseconds. This is in
particular problematic for the posix timers and especially clock_gettime.

The following patch introduces a new gettimeofday function using
struct timespec instead of struct timeval. If a platforms supports time
interpolation then the new gettimeofday will use that to provide a
gettimeofday function with higher accuracy and then also clock_gettime
will return with nanosecond accuracy.

I would be interested in feedback on this approach. In this context
the time interpolator patches that are being discussed on linux-ia64
would also be of interest. Those provide a generic way to utilize
any memory mapped or CPU counter to do the time interpolations for any
platforms and would allow an easy way to realize a nanosecond resolution
for all platforms.

The way that gettimeofday implements getting the offset may be varied but
I hope that the general approach of providing a gettimeofday handling
nanoseconds is acceptable.

The patch is against 2.6.8-rc1

Index: linux-2.6.7/kernel/time.c
===================================================================
--- linux-2.6.7.orig/kernel/time.c
+++ linux-2.6.7/kernel/time.c
@@ -421,6 +421,40 @@

 EXPORT_SYMBOL(current_kernel_time);

+#ifdef TIME_INTERPOLATION
+void gettimeofday (struct timespec *tv)
+{
+        unsigned long seq;
+
+        do {
+                seq = read_seqbegin(&xtime_lock);
+                tv->tv_sec = xtime.tv_sec;
+                tv->tv_nsec = xtime.tv_nsec+time_interpolator_get_offset();
+        } while (unlikely(read_seqretry(&xtime_lock, seq)));
+
+        while (unlikely(tv->tv_nsec >= NSEC_PER_SEC)) {
+                tv->tv_nsec -= NSEC_PER_SEC;
+                ++tv->tv_sec;
+        }
+}
+
+#else
+/*
+ * Simulate gettimeofday using do_gettimeofday which only allows a timeval
+ * and therefore only yields usec accuracy
+ */
+void gettimeofday(struct timespec *tv)
+{
+	struct timeval x;
+
+	do_gettimeofday(&x);
+	tv->tv_sec = x.tv_sec;
+	tv->tv_nsec = x.tv_usec*NSEC_PER_USEC;
+}
+#endif
+
+EXPORT_SYMBOL(gettimeofday);
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
Index: linux-2.6.7/kernel/timer.c
===================================================================
--- linux-2.6.7.orig/kernel/timer.c
+++ linux-2.6.7/kernel/timer.c
@@ -1241,8 +1241,7 @@
 		 * too.
 		 */

-		do_gettimeofday((struct timeval *)&tp);
-		tp.tv_nsec *= NSEC_PER_USEC;
+		gettimeofday(&tp);
 		tp.tv_sec += wall_to_monotonic.tv_sec;
 		tp.tv_nsec += wall_to_monotonic.tv_nsec;
 		if (tp.tv_nsec - NSEC_PER_SEC >= 0) {
Index: linux-2.6.7/kernel/posix-timers.c
===================================================================
--- linux-2.6.7.orig/kernel/posix-timers.c
+++ linux-2.6.7/kernel/posix-timers.c
@@ -1168,15 +1168,10 @@
  */
 static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
 {
-	struct timeval tv;
-
 	if (clock->clock_get)
 		return clock->clock_get(tp);

-	do_gettimeofday(&tv);
-	tp->tv_sec = tv.tv_sec;
-	tp->tv_nsec = tv.tv_usec * NSEC_PER_USEC;
-
+	gettimeofday(tp);
 	return 0;
 }

@@ -1192,24 +1187,16 @@
 	struct timespec *tp, struct timespec *mo)
 {
 	u64 jiff;
-	struct timeval tpv;
 	unsigned int seq;

 	do {
 		seq = read_seqbegin(&xtime_lock);
-		do_gettimeofday(&tpv);
+		gettimeofday(tp);
 		*mo = wall_to_monotonic;
 		jiff = jiffies_64;

 	} while(read_seqretry(&xtime_lock, seq));

-	/*
-	 * Love to get this before it is converted to usec.
-	 * It would save a div AND a mpy.
-	 */
-	tp->tv_sec = tpv.tv_sec;
-	tp->tv_nsec = tpv.tv_usec * NSEC_PER_USEC;
-
 	return jiff;
 }

Index: linux-2.6.7/include/linux/time.h
===================================================================
--- linux-2.6.7.orig/include/linux/time.h
+++ linux-2.6.7/include/linux/time.h
@@ -348,6 +348,7 @@
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
+extern void gettimeofday (struct timespec *tv);

 static inline void
 set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
Index: linux-2.6.7/kernel/time.c
===================================================================
--- linux-2.6.7.orig/kernel/time.c
+++ linux-2.6.7/kernel/time.c
@@ -421,6 +421,40 @@

 EXPORT_SYMBOL(current_kernel_time);

+#ifdef TIME_INTERPOLATION
+void gettimeofday (struct timespec *tv)
+{
+        unsigned long seq;
+
+        do {
+                seq = read_seqbegin(&xtime_lock);
+                tv->tv_sec = xtime.tv_sec;
+                tv->tv_nsec = xtime.tv_nsec+time_interpolator_get_offset();
+        } while (unlikely(read_seqretry(&xtime_lock, seq)));
+
+        while (unlikely(tv->tv_nsec >= NSEC_PER_SEC)) {
+                tv->tv_nsec -= NSEC_PER_SEC;
+                ++tv->tv_sec;
+        }
+}
+
+#else
+/*
+ * Simulate gettimeofday using do_gettimeofday which only allows a timeval
+ * and therefore only yields usec accuracy
+ */
+void gettimeofday(struct timespec *tv)
+{
+	struct timeval x;
+
+	do_gettimeofday(&x);
+	tv->tv_sec = x.tv_sec;
+	tv->tv_nsec = x.tv_usec*NSEC_PER_USEC;
+}
+#endif
+
+EXPORT_SYMBOL(gettimeofday);
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
Index: linux-2.6.7/kernel/timer.c
===================================================================
--- linux-2.6.7.orig/kernel/timer.c
+++ linux-2.6.7/kernel/timer.c
@@ -1241,8 +1241,7 @@
 		 * too.
 		 */

-		do_gettimeofday((struct timeval *)&tp);
-		tp.tv_nsec *= NSEC_PER_USEC;
+		gettimeofday(&tp);
 		tp.tv_sec += wall_to_monotonic.tv_sec;
 		tp.tv_nsec += wall_to_monotonic.tv_nsec;
 		if (tp.tv_nsec - NSEC_PER_SEC >= 0) {
Index: linux-2.6.7/kernel/posix-timers.c
===================================================================
--- linux-2.6.7.orig/kernel/posix-timers.c
+++ linux-2.6.7/kernel/posix-timers.c
@@ -1168,15 +1168,10 @@
  */
 static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
 {
-	struct timeval tv;
-
 	if (clock->clock_get)
 		return clock->clock_get(tp);

-	do_gettimeofday(&tv);
-	tp->tv_sec = tv.tv_sec;
-	tp->tv_nsec = tv.tv_usec * NSEC_PER_USEC;
-
+	gettimeofday(tp);
 	return 0;
 }

@@ -1192,24 +1187,16 @@
 	struct timespec *tp, struct timespec *mo)
 {
 	u64 jiff;
-	struct timeval tpv;
 	unsigned int seq;

 	do {
 		seq = read_seqbegin(&xtime_lock);
-		do_gettimeofday(&tpv);
+		gettimeofday(tp);
 		*mo = wall_to_monotonic;
 		jiff = jiffies_64;

 	} while(read_seqretry(&xtime_lock, seq));

-	/*
-	 * Love to get this before it is converted to usec.
-	 * It would save a div AND a mpy.
-	 */
-	tp->tv_sec = tpv.tv_sec;
-	tp->tv_nsec = tpv.tv_usec * NSEC_PER_USEC;
-
 	return jiff;
 }

Index: linux-2.6.7/include/linux/time.h
===================================================================
--- linux-2.6.7.orig/include/linux/time.h
+++ linux-2.6.7/include/linux/time.h
@@ -348,6 +348,7 @@
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
+extern void gettimeofday (struct timespec *tv);

 static inline void
 set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)

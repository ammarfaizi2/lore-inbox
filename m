Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUGNV25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUGNV25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGNV25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:28:57 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26660 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265815AbUGNV2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:28:12 -0400
Date: Wed, 14 Jul 2004 14:27:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
 posix-timer functions to return higher accuracy)
In-Reply-To: <20040714210903.GA32326@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0407141425200.16274@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
 <20040714210903.GA32326@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004, Matthew Wilcox wrote:
> You seem to have included two patches here that are very similar ...
> could you send the patch you intended please?

Right. Somehow my patch management system did something strange.
Here is the patch:

Index: linux-2.6.7/kernel/time.c
===================================================================
--- linux-2.6.7.orig/kernel/time.c
+++ linux-2.6.7/kernel/time.c
@@ -421,6 +421,41 @@

 EXPORT_SYMBOL(current_kernel_time);

+#ifdef CONFIG_TIME_INTERPOLATION
+void gettimeofday (struct timespec *tv)
+{
+        unsigned long seq,sec,nsec;
+
+        do {
+                seq = read_seqbegin(&xtime_lock);
+                sec = xtime.tv_sec;
+                nsec = xtime.tv_nsec+time_interpolator_get_offset();
+        } while (unlikely(read_seqretry(&xtime_lock, seq)));
+
+        while (unlikely(nsec >= NSEC_PER_SEC)) {
+                nsec -= NSEC_PER_SEC;
+                ++sec;
+        }
+	tv->tv_sec = sec;
+	tv->tv_nsec = nsec;
+}
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTDOIZe (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbTDOIZe (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:25:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21233 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264399AbTDOIZ3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:25:29 -0400
Message-ID: <3E9BC49E.7010903@mvista.com>
Date: Tue, 15 Apr 2003 01:36:46 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix jiffies_to_time[spec | val] and converse to use actual
 jiffies increment rather than 1/HZ
Content-Type: multipart/mixed;
 boundary="------------010801020007030404000400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010801020007030404000400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In the current system (2.5.67) time_spec to jiffies, time_val to 
jiffies and the converse (jiffies to time_val and jiffies to 
time_spec) all use 1/HZ as the measure of a jiffie.  Because of the 
inability of the PIT to actually generate an accurate 1/HZ interrupt, 
the wall clock is updated with a more accurate value (999848 
nanoseconds per jiffie for HZ = 1000).  This causes a 1/HZ 
interpretation of jiffies based timing to run faster than the wall 
clock, thus causing sleeps and timers to expire short of the requested 
time.  Try, for example:

time sleep 60

This patch changes the conversion routines to use the same value as 
the wall clock update code to do the conversions.

The actual math is almost all done at compile time.  The run time 
conversions require little if any more execution time.

This patch must be applied after the patch I posted earlier today 
which fixed the CLOCK_MONOTONIC resolution issue.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------010801020007030404000400
Content-Type: text/plain;
 name="hrtimers-conv-2.5.67-bk3-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-conv-2.5.67-bk3-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-mono/include/asm-i386/div64.h linux/include/asm-i386/div64.h
--- linux-2.5.67-bk3-mono/include/asm-i386/div64.h	2002-09-09 10:35:00.000000000 -0700
+++ linux/include/asm-i386/div64.h	2003-04-14 17:14:39.000000000 -0700
@@ -14,4 +14,22 @@
 	__mod; \
 })
 
+/*
+ * (long)X = ((long long)divs) / (long)div
+ * (long)rem = ((long long)divs) % (long)div
+ *
+ * Warning, this will do an exception if X overflows.
+ */
+#define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
+
+extern inline long
+div_ll_X_l_rem(long long divs, long div, long *rem)
+{
+	long dum2;
+      __asm__("divl %2":"=a"(dum2), "=d"(*rem)
+      :	"rm"(div), "A"(divs));
+
+	return dum2;
+
+}
 #endif
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-mono/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.67-bk3-mono/include/linux/time.h	2003-04-12 02:49:36.000000000 -0700
+++ linux/include/linux/time.h	2003-04-15 00:06:38.000000000 -0700
@@ -26,6 +26,16 @@
 
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
+#include <linux/timex.h>
+#include <asm/div64.h>
+#ifndef div_long_long_rem
+
+#define div_long_long_rem(dividend,divisor,remainder) ({ \
+		       u64 result = dividend;		\
+		       *remainder = do_div(result,divisor); \
+		       result; })
+
+#endif
 
 /*
  * Have the 32 bit jiffies value wrap 5 minutes after boot
@@ -59,25 +69,52 @@
 #ifndef NSEC_PER_USEC
 #define NSEC_PER_USEC (1000L)
 #endif
+/*
+ * We want to do realistic conversions of time so we need to use the same
+ * values the update wall clock code uses as the jiffie size.  This value
+ * is: TICK_NSEC(TICK_USEC) (both of which are defined in timex.h).  This 
+ * is a constant and is in nanoseconds.  We will used scaled math and
+ * with a scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and 
+ * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
+ * constants and so are computed at compile time.  SHIFT_HZ (computed in
+ * timex.h) adjusts the scaling for different HZ values.
+ */
+#define SEC_JIFFIE_SC (30 - SHIFT_HZ)
+#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 30)
+#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 20)
+#define SEC_CONVERSION ((unsigned long)(((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) /\
+                            (u64)TICK_NSEC(TICK_USEC))) 
+#define NSEC_CONVERSION ((unsigned long)(((u64)1 << NSEC_JIFFIE_SC) / \
+                            (u64)TICK_NSEC(TICK_USEC))) 
+#define USEC_CONVERSION \
+               ((unsigned long)(((u64)NSEC_PER_USEC << USEC_JIFFIE_SC)/ \
+                                 (u64)TICK_NSEC(TICK_USEC))) 
+#define MAX_SEC_IN_JIFFIES \
+    (u32)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC(TICK_USEC)) / NSEC_PER_SEC)
 
 static __inline__ unsigned long
 timespec_to_jiffies(struct timespec *value)
 {
 	unsigned long sec = value->tv_sec;
-	long nsec = value->tv_nsec;
+	long nsec = value->tv_nsec + TICK_NSEC(TICK_USEC) - 1;
 
-	if (sec >= (MAX_JIFFY_OFFSET / HZ))
+	if (sec >=  MAX_SEC_IN_JIFFIES)
 		return MAX_JIFFY_OFFSET;
-	nsec += 1000000000L / HZ - 1;
-	nsec /= 1000000000L / HZ;
-	return HZ * sec + nsec;
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)nsec * NSEC_CONVERSION) >>
+		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+
 }
 
 static __inline__ void
 jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
 {
-	value->tv_nsec = (jiffies % HZ) * (1000000000L / HZ);
-	value->tv_sec = jiffies / HZ;
+	/*
+	 * Convert jiffies to nanoseconds and seperate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC(TICK_USEC); 
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }
 
 /* Same for "timeval" */
@@ -85,20 +122,25 @@
 timeval_to_jiffies(struct timeval *value)
 {
 	unsigned long sec = value->tv_sec;
-	long usec = value->tv_usec;
+	long usec = value->tv_usec + USEC_PER_SEC / HZ - 1;
 
-	if (sec >= (MAX_JIFFY_OFFSET / HZ))
+	if (sec >= MAX_SEC_IN_JIFFIES)
 		return MAX_JIFFY_OFFSET;
-	usec += 1000000L / HZ - 1;
-	usec /= 1000000L / HZ;
-	return HZ * sec + usec;
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)usec * USEC_CONVERSION) >>
+		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 }
 
 static __inline__ void
 jiffies_to_timeval(unsigned long jiffies, struct timeval *value)
 {
-	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
-	value->tv_sec = jiffies / HZ;
+	/*
+	 * Convert jiffies to nanoseconds and seperate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC(TICK_USEC); 
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
+	value->tv_usec /= NSEC_PER_USEC;
 }
 
 static __inline__ int timespec_equal(struct timespec *a, struct timespec *b) 
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-mono/include/linux/timex.h linux/include/linux/timex.h
--- linux-2.5.67-bk3-mono/include/linux/timex.h	2002-09-18 17:04:09.000000000 -0700
+++ linux/include/linux/timex.h	2003-04-12 03:17:18.000000000 -0700
@@ -51,7 +51,6 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
-#include <linux/time.h>
 #include <asm/param.h>
 
 /*
@@ -177,6 +176,7 @@
 /* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
 #define TICK_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
 
+#include <linux/time.h>
 /*
  * syscall interface - used (mainly by NTP daemon)
  * to discipline kernel clock oscillator
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-mono/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.67-bk3-mono/kernel/posix-timers.c	2003-04-14 16:10:43.000000000 -0700
+++ linux/kernel/posix-timers.c	2003-04-15 01:18:33.000000000 -0700
@@ -33,7 +33,12 @@
 		       result; })
 
 #endif
+#define CLOCK_REALTIME_RES TICK_NSEC(TICK_USEC)  // In nano seconds.
 
+static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
+{
+	return (u64)mpy1 * mpy2;
+}
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
  * Timer ids are allocated by an external routine that keeps track of the
@@ -173,8 +178,8 @@
  */
 static __init int init_posix_timers(void)
 {
-	struct k_clock clock_realtime = {.res = NSEC_PER_SEC / HZ };
-	struct k_clock clock_monotonic = {.res = NSEC_PER_SEC / HZ,
+	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES };
+	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_monotonic_settime
 	};
@@ -202,24 +207,14 @@
 	}
 
 	/*
-	 * A note on jiffy overflow: It is possible for the system to
-	 * have been up long enough for the jiffies quanity to overflow.
-	 * In order for correct timer evaluations we require that the
-	 * specified time be somewhere between now and now + (max
-	 * unsigned int/2).  Times beyond this will be truncated back to
-	 * this value.   This is done in the absolute adjustment code,
-	 * below.  Here it is enough to just discard the high order
-	 * bits.
-	 */
-	*jiff = (s64)sec * HZ;
-	/*
-	 * Do the res thing. (Don't forget the add in the declaration of nsec)
-	 */
-	nsec -= nsec % res;
-	/*
-	 * Split to jiffie and sub jiffie
-	 */
-	*jiff += nsec / (NSEC_PER_SEC / HZ);
+	 * The scaling constants are defined in <linux/time.h>
+	 * The difference between there and here is that we do the
+	 * res rounding and compute a 64-bit result (well so does that
+	 * but it then throws away the high bits).
+  	 */
+	*jiff =  (mpy_l_X_l_ll(sec, SEC_CONVERSION) +
+		  (mpy_l_X_l_ll(nsec, NSEC_CONVERSION) >> 
+		   (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 }
 
 static void schedule_next_timer(struct k_itimer *timr)
@@ -1234,7 +1229,6 @@
 		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
 
 	if (left > (s64)0) {
-		unsigned long rmd;
 
 		/*
 		 * Always restart abs calls from scratch to pick up any
@@ -1243,9 +1237,10 @@
 		if (abs)
 			return -ERESTARTNOHAND;
 
-		tsave->tv_sec = div_long_long_rem(left, HZ, &rmd);
-		tsave->tv_nsec = rmd * (NSEC_PER_SEC / HZ);
-
+		left *= TICK_NSEC(TICK_USEC);
+		tsave->tv_sec = div_long_long_rem(left, 
+						  NSEC_PER_SEC, 
+						  &tsave->tv_nsec);
 		restart_block->fn = clock_nanosleep_restart;
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (unsigned long)tsave;
Binary files linux-2.5.67-bk3-mono/usr/initramfs_data.cpio and linux/usr/initramfs_data.cpio differ
Binary files linux-2.5.67-bk3-mono/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------010801020007030404000400--


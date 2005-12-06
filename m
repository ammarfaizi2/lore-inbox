Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbVLFAe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbVLFAe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbVLFAeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:34:37 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24014
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751531AbVLFAee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:34 -0500
Message-Id: <20051206000153.102392000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:29 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 03/21] Deinline mktime and set_normalized_timespec
Content-Disposition: inline;
	filename=deinline-mktime-set-normalized-timespec.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- mktime() and set_normalized_timespec() are large inline functions used
  in many places: deinline them.

From: George Anzinger, off-by-1 bugfix

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/time.h |   52 ++++---------------------------------------
 kernel/time.c        |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 47 deletions(-)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -38,38 +38,9 @@ static __inline__ int timespec_equal(str
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 } 
 
-/* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
- * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
- * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
- *
- * [For the Julian calendar (which was used in Russia before 1917,
- * Britain & colonies before 1752, anywhere else before 1582,
- * and is still in use by some communities) leave out the
- * -year/100+year/400 terms, and add 10.]
- *
- * This algorithm was first published by Gauss (I think).
- *
- * WARNING: this function will overflow on 2106-02-07 06:28:16 on
- * machines were long is 32-bit! (However, as time_t is signed, we
- * will already get problems at other places on 2038-01-19 03:14:08)
- */
-static inline unsigned long
-mktime (unsigned int year, unsigned int mon,
-	unsigned int day, unsigned int hour,
-	unsigned int min, unsigned int sec)
-{
-	if (0 >= (int) (mon -= 2)) {	/* 1..12 -> 11,12,1..10 */
-		mon += 12;		/* Puts Feb last since it has leap day */
-		year -= 1;
-	}
-
-	return (((
-		(unsigned long) (year/4 - year/100 + year/400 + 367*mon/12 + day) +
-			year*365 - 719499
-	    )*24 + hour /* now have hours */
-	  )*60 + min /* now have minutes */
-	)*60 + sec; /* finally seconds */
-}
+extern unsigned long mktime (unsigned int year, unsigned int mon,
+			     unsigned int day, unsigned int hour,
+			     unsigned int min, unsigned int sec);
 
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
@@ -80,6 +51,8 @@ static inline unsigned long get_seconds(
 	return xtime.tv_sec;
 }
 
+extern void set_normalized_timespec (struct timespec *ts, time_t sec, long nsec);
+
 struct timespec current_kernel_time(void);
 
 #define CURRENT_TIME (current_kernel_time())
@@ -98,21 +71,6 @@ extern void getnstimeofday (struct times
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
-static inline void
-set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
-{
-	while (nsec >= NSEC_PER_SEC) {
-		nsec -= NSEC_PER_SEC;
-		++sec;
-	}
-	while (nsec < 0) {
-		nsec += NSEC_PER_SEC;
-		--sec;
-	}
-	ts->tv_sec = sec;
-	ts->tv_nsec = nsec;
-}
-
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -561,6 +561,67 @@ void getnstimeofday(struct timespec *tv)
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
 
+/* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
+ * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
+ * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
+ *
+ * [For the Julian calendar (which was used in Russia before 1917,
+ * Britain & colonies before 1752, anywhere else before 1582,
+ * and is still in use by some communities) leave out the
+ * -year/100+year/400 terms, and add 10.]
+ *
+ * This algorithm was first published by Gauss (I think).
+ *
+ * WARNING: this function will overflow on 2106-02-07 06:28:16 on
+ * machines were long is 32-bit! (However, as time_t is signed, we
+ * will already get problems at other places on 2038-01-19 03:14:08)
+ */
+unsigned long
+mktime (unsigned int year, unsigned int mon,
+	unsigned int day, unsigned int hour,
+	unsigned int min, unsigned int sec)
+{
+	if (0 >= (int) (mon -= 2)) {	/* 1..12 -> 11,12,1..10 */
+		mon += 12;		/* Puts Feb last since it has leap day */
+		year -= 1;
+	}
+
+	return ((((unsigned long)
+		  (year/4 - year/100 + year/400 + 367*mon/12 + day) +
+		  year*365 - 719499
+	    )*24 + hour /* now have hours */
+	  )*60 + min /* now have minutes */
+	)*60 + sec; /* finally seconds */
+}
+
+/**
+ * set_normalized_timespec - set timespec sec and nsec parts and normalize
+ *
+ * @ts:		pointer to timespec variable to be set
+ * @sec:	seconds to set
+ * @nsec:	nanoseconds to set
+ *
+ * Set seconds and nanoseconds field of a timespec variable and
+ * normalize to the timespec storage format
+ *
+ * Note: The tv_nsec part is always in the range of
+ * 	0 <= tv_nsec < NSEC_PER_SEC
+ * For negative values only the tv_sec field is negative !
+ */
+void set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
+{
+	while (nsec >= NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		++sec;
+	}
+	while (nsec < 0) {
+		nsec += NSEC_PER_SEC;
+		--sec;
+	}
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+}
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWJAXGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWJAXGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWJAXGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:06:46 -0400
Received: from www.osadl.org ([213.239.205.134]:57778 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932469AbWJAXGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:44 -0400
Message-Id: <20061001225723.491598000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:00:50 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 04/21] time: uninline jiffies.h
Content-Disposition: inline; filename=uninline-jiffies-h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

there are load of fat functions hidden in jiffies.h. Uninline them.
No code changes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 include/linux/jiffies.h |  223 +++---------------------------------------------
 kernel/time.c           |  218 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+), 207 deletions(-)

Index: linux-2.6.18-mm2/include/linux/jiffies.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/jiffies.h	2006-10-02 00:55:49.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/jiffies.h	2006-10-02 00:55:50.000000000 +0200
@@ -259,215 +259,24 @@ static inline u64 get_jiffies_64(void)
 #endif
 
 /*
- * Convert jiffies to milliseconds and back.
- *
- * Avoid unnecessary multiplications/divisions in the
- * two most common HZ cases:
+ * Convert various time units to each other:
  */
-static inline unsigned int jiffies_to_msecs(const unsigned long j)
-{
-#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
-	return (MSEC_PER_SEC / HZ) * j;
-#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
-	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
-#else
-	return (j * MSEC_PER_SEC) / HZ;
-#endif
-}
-
-static inline unsigned int jiffies_to_usecs(const unsigned long j)
-{
-#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
-	return (USEC_PER_SEC / HZ) * j;
-#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
-	return (j + (HZ / USEC_PER_SEC) - 1)/(HZ / USEC_PER_SEC);
-#else
-	return (j * USEC_PER_SEC) / HZ;
-#endif
-}
-
-static inline unsigned long msecs_to_jiffies(const unsigned int m)
-{
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
-		return MAX_JIFFY_OFFSET;
-#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
-	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
-#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
-	return m * (HZ / MSEC_PER_SEC);
-#else
-	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
-#endif
-}
-
-static inline unsigned long usecs_to_jiffies(const unsigned int u)
-{
-	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
-		return MAX_JIFFY_OFFSET;
-#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
-	return (u + (USEC_PER_SEC / HZ) - 1) / (USEC_PER_SEC / HZ);
-#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
-	return u * (HZ / USEC_PER_SEC);
-#else
-	return (u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
-#endif
-}
-
-/*
- * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
- * that a remainder subtract here would not do the right thing as the
- * resolution values don't fall on second boundries.  I.e. the line:
- * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
- *
- * Rather, we just shift the bits off the right.
- *
- * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
- * value to a scaled second value.
- */
-static __inline__ unsigned long
-timespec_to_jiffies(const struct timespec *value)
-{
-	unsigned long sec = value->tv_sec;
-	long nsec = value->tv_nsec + TICK_NSEC - 1;
-
-	if (sec >= MAX_SEC_IN_JIFFIES){
-		sec = MAX_SEC_IN_JIFFIES;
-		nsec = 0;
-	}
-	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)nsec * NSEC_CONVERSION) >>
-		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-
-}
-
-static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
-}
-
-/* Same for "timeval"
- *
- * Well, almost.  The problem here is that the real system resolution is
- * in nanoseconds and the value being converted is in micro seconds.
- * Also for some machines (those that use HZ = 1024, in-particular),
- * there is a LARGE error in the tick size in microseconds.
-
- * The solution we use is to do the rounding AFTER we convert the
- * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
- * Instruction wise, this should cost only an additional add with carry
- * instruction above the way it was done above.
- */
-static __inline__ unsigned long
-timeval_to_jiffies(const struct timeval *value)
-{
-	unsigned long sec = value->tv_sec;
-	long usec = value->tv_usec;
-
-	if (sec >= MAX_SEC_IN_JIFFIES){
-		sec = MAX_SEC_IN_JIFFIES;
-		usec = 0;
-	}
-	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
-		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-}
-
-static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
-	long tv_usec;
-
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &tv_usec);
-	tv_usec /= NSEC_PER_USEC;
-	value->tv_usec = tv_usec;
-}
-
-/*
- * Convert jiffies/jiffies_64 to clock_t and back.
- */
-static inline clock_t jiffies_to_clock_t(long x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	return x / (HZ / USER_HZ);
-#else
-	u64 tmp = (u64)x * TICK_NSEC;
-	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
-	return (long)tmp;
-#endif
-}
-
-static inline unsigned long clock_t_to_jiffies(unsigned long x)
-{
-#if (HZ % USER_HZ)==0
-	if (x >= ~0UL / (HZ / USER_HZ))
-		return ~0UL;
-	return x * (HZ / USER_HZ);
-#else
-	u64 jif;
-
-	/* Don't worry about loss of precision here .. */
-	if (x >= ~0UL / HZ * USER_HZ)
-		return ~0UL;
-
-	/* .. but do try to contain it here */
-	jif = x * (u64) HZ;
-	do_div(jif, USER_HZ);
-	return jif;
-#endif
-}
-
-static inline u64 jiffies_64_to_clock_t(u64 x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	do_div(x, HZ / USER_HZ);
-#else
-	/*
-	 * There are better ways that don't overflow early,
-	 * but even this doesn't overflow in hundreds of years
-	 * in 64 bits, so..
-	 */
-	x *= TICK_NSEC;
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
-#endif
-	return x;
-}
-
-static inline u64 nsec_to_clock_t(u64 x)
-{
-#if (NSEC_PER_SEC % USER_HZ) == 0
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
-#elif (USER_HZ % 512) == 0
-	x *= USER_HZ/512;
-	do_div(x, (NSEC_PER_SEC / 512));
-#else
-	/*
-         * max relative error 5.7e-8 (1.8s per year) for USER_HZ <= 1024,
-         * overflow after 64.99 years.
-         * exact for HZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
-         */
-	x *= 9;
-	do_div(x, (unsigned long)((9ull * NSEC_PER_SEC + (USER_HZ/2))
-	                          / USER_HZ));
-#endif
-	return x;
-}
+extern unsigned int jiffies_to_msecs(const unsigned long j);
+extern unsigned int jiffies_to_usecs(const unsigned long j);
+extern unsigned long msecs_to_jiffies(const unsigned int m);
+extern unsigned long usecs_to_jiffies(const unsigned int u);
+extern unsigned long timespec_to_jiffies(const struct timespec *value);
+extern void jiffies_to_timespec(const unsigned long jiffies,
+				struct timespec *value);
+extern unsigned long timeval_to_jiffies(const struct timeval *value);
+extern void jiffies_to_timeval(const unsigned long jiffies,
+			       struct timeval *value);
+extern clock_t jiffies_to_clock_t(long x);
+extern unsigned long clock_t_to_jiffies(unsigned long x);
+extern u64 jiffies_64_to_clock_t(u64 x);
+extern u64 nsec_to_clock_t(u64 x);
+extern int nsec_to_timestamp(char *s, u64 t);
 
-static inline int nsec_to_timestamp(char *s, u64 t)
-{
-	unsigned long nsec_rem = do_div(t, NSEC_PER_SEC);
-	return sprintf(s, "[%5lu.%06lu]", (unsigned long)t,
-		       nsec_rem/NSEC_PER_USEC);
-}
 #define TIMESTAMP_SIZE	30
 
 #endif
Index: linux-2.6.18-mm2/kernel/time.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/time.c	2006-10-02 00:55:49.000000000 +0200
+++ linux-2.6.18-mm2/kernel/time.c	2006-10-02 00:55:50.000000000 +0200
@@ -470,6 +470,224 @@ struct timeval ns_to_timeval(const s64 n
 	return tv;
 }
 
+/*
+ * Convert jiffies to milliseconds and back.
+ *
+ * Avoid unnecessary multiplications/divisions in the
+ * two most common HZ cases:
+ */
+unsigned int jiffies_to_msecs(const unsigned long j)
+{
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+	return (MSEC_PER_SEC / HZ) * j;
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
+#else
+	return (j * MSEC_PER_SEC) / HZ;
+#endif
+}
+EXPORT_SYMBOL(jiffies_to_msecs);
+
+unsigned int jiffies_to_usecs(const unsigned long j)
+{
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+	return (USEC_PER_SEC / HZ) * j;
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+	return (j + (HZ / USEC_PER_SEC) - 1)/(HZ / USEC_PER_SEC);
+#else
+	return (j * USEC_PER_SEC) / HZ;
+#endif
+}
+EXPORT_SYMBOL(jiffies_to_usecs);
+
+unsigned long msecs_to_jiffies(const unsigned int m)
+{
+	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+	return m * (HZ / MSEC_PER_SEC);
+#else
+	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
+#endif
+}
+EXPORT_SYMBOL(msecs_to_jiffies);
+
+unsigned long usecs_to_jiffies(const unsigned int u)
+{
+	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+	return (u + (USEC_PER_SEC / HZ) - 1) / (USEC_PER_SEC / HZ);
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+	return u * (HZ / USEC_PER_SEC);
+#else
+	return (u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
+#endif
+}
+EXPORT_SYMBOL(usecs_to_jiffies);
+
+/*
+ * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
+ * that a remainder subtract here would not do the right thing as the
+ * resolution values don't fall on second boundries.  I.e. the line:
+ * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
+ *
+ * Rather, we just shift the bits off the right.
+ *
+ * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
+ * value to a scaled second value.
+ */
+unsigned long
+timespec_to_jiffies(const struct timespec *value)
+{
+	unsigned long sec = value->tv_sec;
+	long nsec = value->tv_nsec + TICK_NSEC - 1;
+
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		nsec = 0;
+	}
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)nsec * NSEC_CONVERSION) >>
+		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+
+}
+EXPORT_SYMBOL(timespec_to_jiffies);
+
+void
+jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+{
+	/*
+	 * Convert jiffies to nanoseconds and separate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC;
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
+}
+
+/* Same for "timeval"
+ *
+ * Well, almost.  The problem here is that the real system resolution is
+ * in nanoseconds and the value being converted is in micro seconds.
+ * Also for some machines (those that use HZ = 1024, in-particular),
+ * there is a LARGE error in the tick size in microseconds.
+
+ * The solution we use is to do the rounding AFTER we convert the
+ * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
+ * Instruction wise, this should cost only an additional add with carry
+ * instruction above the way it was done above.
+ */
+unsigned long
+timeval_to_jiffies(const struct timeval *value)
+{
+	unsigned long sec = value->tv_sec;
+	long usec = value->tv_usec;
+
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		usec = 0;
+	}
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
+		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+}
+
+void jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+{
+	/*
+	 * Convert jiffies to nanoseconds and separate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC;
+	long tv_usec;
+
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &tv_usec);
+	tv_usec /= NSEC_PER_USEC;
+	value->tv_usec = tv_usec;
+}
+
+/*
+ * Convert jiffies/jiffies_64 to clock_t and back.
+ */
+clock_t jiffies_to_clock_t(long x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	return x / (HZ / USER_HZ);
+#else
+	u64 tmp = (u64)x * TICK_NSEC;
+	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
+	return (long)tmp;
+#endif
+}
+EXPORT_SYMBOL(jiffies_to_clock_t);
+
+unsigned long clock_t_to_jiffies(unsigned long x)
+{
+#if (HZ % USER_HZ)==0
+	if (x >= ~0UL / (HZ / USER_HZ))
+		return ~0UL;
+	return x * (HZ / USER_HZ);
+#else
+	u64 jif;
+
+	/* Don't worry about loss of precision here .. */
+	if (x >= ~0UL / HZ * USER_HZ)
+		return ~0UL;
+
+	/* .. but do try to contain it here */
+	jif = x * (u64) HZ;
+	do_div(jif, USER_HZ);
+	return jif;
+#endif
+}
+EXPORT_SYMBOL(clock_t_to_jiffies);
+
+u64 jiffies_64_to_clock_t(u64 x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	do_div(x, HZ / USER_HZ);
+#else
+	/*
+	 * There are better ways that don't overflow early,
+	 * but even this doesn't overflow in hundreds of years
+	 * in 64 bits, so..
+	 */
+	x *= TICK_NSEC;
+	do_div(x, (NSEC_PER_SEC / USER_HZ));
+#endif
+	return x;
+}
+
+EXPORT_SYMBOL(jiffies_64_to_clock_t);
+
+u64 nsec_to_clock_t(u64 x)
+{
+#if (NSEC_PER_SEC % USER_HZ) == 0
+	do_div(x, (NSEC_PER_SEC / USER_HZ));
+#elif (USER_HZ % 512) == 0
+	x *= USER_HZ/512;
+	do_div(x, (NSEC_PER_SEC / 512));
+#else
+	/*
+         * max relative error 5.7e-8 (1.8s per year) for USER_HZ <= 1024,
+         * overflow after 64.99 years.
+         * exact for HZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
+         */
+	x *= 9;
+	do_div(x, (unsigned long)((9ull * NSEC_PER_SEC + (USER_HZ/2)) /
+				  USER_HZ));
+#endif
+	return x;
+}
+
+int nsec_to_timestamp(char *s, u64 t)
+{
+	unsigned long nsec_rem = do_div(t, NSEC_PER_SEC);
+	return sprintf(s, "[%5lu.%06lu]", (unsigned long)t,
+		       nsec_rem/NSEC_PER_USEC);
+}
 __attribute__((weak)) unsigned long long timestamp_clock(void)
 {
 	return sched_clock();

--


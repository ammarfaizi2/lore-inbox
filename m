Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTFJApo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFJApn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:45:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20975 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262379AbTFJApI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:45:08 -0400
Message-ID: <3EE52CFA.6070607@mvista.com>
Date: Mon, 09 Jun 2003 17:57:30 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Eric Piel <Eric.Piel@Bull.Net>
Subject: [PATCH] More time clean up stuff.
Content-Type: multipart/mixed;
 boundary="------------080900020102000101060201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080900020102000101060201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

NOW on top of 2.5.70-bk9...  I also removed the dependency on the 
prior cleanup.

This patch addresses issues of roundoff error in the time keeping and
NTP code as follows:

The conversion of "actual jiffies" to TICK_USEC and then to TICK_NSEC
introduced large errors if jiffies was not a power of 10 (e.g. 1024
for the ia64).  Most of this is avoided by converting directly to
TICK_NSEC.

The calculation of MAX_SEC_IN_JIFFIES (the largest timespec or timeval
the kernel will attempt) had overflow problems in the 64-bit machines.
   We introduce a different equation for those machines.

The NTP frequency update code was allowing a micro second of error to
accumulate before applying the correction.  We change FINEUSEC to
FINENSEC to do the correction as soon as a full nanosecond has
accumulated.

The initial calculation of time_freq for NTP had severe roundoff
errors for HZ not a power of 10 (i.e. 1024).  A new equation fixes this.

clock_nanosleep is changed to round up to the next jiffie to cover
starting between jiffies.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


--------------080900020102000101060201
Content-Type: text/plain;
 name="timeclean-eric-2.5.70-bk9-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timeclean-eric-2.5.70-bk9-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.70-bk9-time_save/arch/i386/kernel/time.c	2003-06-09 17:16:13.000000000 -0700
+++ linux/arch/i386/kernel/time.c	2003-06-09 17:24:50.000000000 -0700
@@ -127,7 +127,7 @@
 	 * made, and then undo it!
 	 */
 	tv->tv_nsec -= timer->get_offset() * NSEC_PER_USEC;
-	tv->tv_nsec -= (jiffies - wall_jiffies) * TICK_NSEC(TICK_USEC);
+	tv->tv_nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
 
 	while (tv->tv_nsec < 0) {
 		tv->tv_nsec += NSEC_PER_SEC;
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/include/asm-i386/mach-pc9800/setup_arch_pre.h linux/include/asm-i386/mach-pc9800/setup_arch_pre.h
--- linux-2.5.70-bk9-time_save/include/asm-i386/mach-pc9800/setup_arch_pre.h	2003-03-24 23:34:12.000000000 -0800
+++ linux/include/asm-i386/mach-pc9800/setup_arch_pre.h	2003-06-09 17:24:50.000000000 -0700
@@ -26,7 +26,7 @@
 	CLOCK_TICK_RATE = PC9800_8MHz_P() ? 1996800 : 2457600;
 	printk(KERN_DEBUG "CLOCK_TICK_RATE = %d\n", CLOCK_TICK_RATE);
 	tick_usec = TICK_USEC; 		/* ACTHZ          period (usec) */
-	tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+	tick_nsec = TICK_NSEC;		/* USER_HZ period (nsec) */
 
 	pc9800_misc_flags = PC9800_MISC_FLAGS;
 #ifdef CONFIG_SMP
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/include/asm-ia64/timex.h linux/include/asm-ia64/timex.h
--- linux-2.5.70-bk9-time_save/include/asm-ia64/timex.h	2002-09-26 11:24:18.000000000 -0700
+++ linux/include/asm-ia64/timex.h	2003-06-09 17:24:50.000000000 -0700
@@ -14,7 +14,11 @@
 
 typedef unsigned long cycles_t;
 
-#define CLOCK_TICK_RATE		100000000
+/*
+ * Something low processor frequency like 100Mhz but 
+ * yet multiple of HZ to avoid truncation in some formulas.
+ */
+#define CLOCK_TICK_RATE		(HZ * 100000UL)
 
 static inline cycles_t
 get_cycles (void)
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.70-bk9-time_save/include/linux/time.h	2003-06-09 17:16:13.000000000 -0700
+++ linux/include/linux/time.h	2003-06-09 17:24:50.000000000 -0700
@@ -69,10 +69,11 @@
 #ifndef NSEC_PER_USEC
 #define NSEC_PER_USEC (1000L)
 #endif
+
 /*
  * We want to do realistic conversions of time so we need to use the same
  * values the update wall clock code uses as the jiffie size.  This value
- * is: TICK_NSEC(TICK_USEC) (both of which are defined in timex.h).  This 
+ * is: TICK_NSEC (both of which are defined in timex.h).  This 
  * is a constant and is in nanoseconds.  We will used scaled math and
  * with a scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and 
  * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
@@ -83,23 +84,30 @@
 #define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 30)
 #define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 20)
 #define SEC_CONVERSION ((unsigned long)(((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) /\
-                            (u64)TICK_NSEC(TICK_USEC))) 
-#define NSEC_CONVERSION ((unsigned long)(((u64)1 << NSEC_JIFFIE_SC) / \
-                            (u64)TICK_NSEC(TICK_USEC))) 
-#define USEC_CONVERSION \
-               ((unsigned long)(((u64)NSEC_PER_USEC << USEC_JIFFIE_SC)/ \
-                                 (u64)TICK_NSEC(TICK_USEC))) 
-#define MAX_SEC_IN_JIFFIES \
-    (u32)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC(TICK_USEC)) / NSEC_PER_SEC)
+				(u64)TICK_NSEC))
+#define NSEC_CONVERSION ((unsigned long)(((u64)1 << NSEC_JIFFIE_SC) /\
+				(u64)TICK_NSEC))
+#define USEC_CONVERSION ((unsigned long)(((u64)NSEC_PER_USEC << USEC_JIFFIE_SC)/\
+				(u64)TICK_NSEC))
+#if BITS_PER_LONG < 64
+# define MAX_SEC_IN_JIFFIES \
+	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
+#else	/* take care of overflow on 64 bits machines */
+# define MAX_SEC_IN_JIFFIES \
+	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
+
+#endif
 
 static __inline__ unsigned long
 timespec_to_jiffies(struct timespec *value)
 {
 	unsigned long sec = value->tv_sec;
-	long nsec = value->tv_nsec + TICK_NSEC(TICK_USEC) - 1;
+	long nsec = value->tv_nsec + TICK_NSEC - 1;
 
-	if (sec >=  MAX_SEC_IN_JIFFIES)
-		return MAX_JIFFY_OFFSET;
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		nsec = 0;
+	}
 	return (((u64)sec * SEC_CONVERSION) +
 		(((u64)nsec * NSEC_CONVERSION) >>
 		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
@@ -113,7 +121,7 @@
 	 * Convert jiffies to nanoseconds and seperate with
 	 * one divide.
 	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC(TICK_USEC); 
+	u64 nsec = (u64)jiffies * TICK_NSEC; 
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }
 
@@ -122,10 +130,12 @@
 timeval_to_jiffies(struct timeval *value)
 {
 	unsigned long sec = value->tv_sec;
-	long usec = value->tv_usec + USEC_PER_SEC / HZ - 1;
+	long usec = value->tv_usec + TICK_USEC - 1;
 
-	if (sec >= MAX_SEC_IN_JIFFIES)
-		return MAX_JIFFY_OFFSET;
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		usec = 0;
+	}
 	return (((u64)sec * SEC_CONVERSION) +
 		(((u64)usec * USEC_CONVERSION) >>
 		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
@@ -138,7 +148,7 @@
 	 * Convert jiffies to nanoseconds and seperate with
 	 * one divide.
 	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC(TICK_USEC); 
+	u64 nsec = (u64)jiffies * TICK_NSEC; 
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
 	value->tv_usec /= NSEC_PER_USEC;
 }
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/include/linux/timex.h linux/include/linux/timex.h
--- linux-2.5.70-bk9-time_save/include/linux/timex.h	2003-06-09 17:13:22.000000000 -0700
+++ linux/include/linux/timex.h	2003-06-09 17:24:50.000000000 -0700
@@ -102,19 +102,19 @@
  * variable which serves as an extension to the low-order bits of the
  * system clock variable. The SHIFT_UPDATE define establishes the decimal
  * point of the time_offset variable which represents the current offset
- * with respect to standard time. The FINEUSEC define represents 1 usec in
+ * with respect to standard time. The FINENSEC define represents 1 nsec in
  * scaled units.
  *
  * SHIFT_USEC defines the scaling (shift) of the time_freq and
  * time_tolerance variables, which represent the current frequency
  * offset and maximum frequency tolerance.
  *
- * FINEUSEC is 1 us in SHIFT_UPDATE units of the time_phase variable.
+ * FINENSEC is 1 ns in SHIFT_UPDATE units of the time_phase variable.
  */
 #define SHIFT_SCALE 22		/* phase scale (shift) */
 #define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
-#define FINEUSEC (1L << SHIFT_SCALE) /* 1 us in phase units */
+#define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
 
 #define MAXPHASE 512000L        /* max phase error (us) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
@@ -162,7 +162,7 @@
  *     (NOM << LSH) / DEN
  * This however means trouble for large NOM, because (NOM << LSH) may no
  * longer fit in 32 bits. The following way of calculating this gives us
- * some slack, under the following onditions:
+ * some slack, under the following conditions:
  *   - (NOM / DEN) fits in (32 - LSH) bits.
  *   - (NOM % DEN) fits in (32 - LSH) bits.
  */
@@ -172,12 +172,16 @@
 /* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
 #define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
 
+/* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ */
+#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))
+
 /* TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
-#define TICK_USEC ((1000000UL + USER_HZ/2) / USER_HZ)
+#define TICK_USEC ((TICK_NSEC + 1000UL/2) / 1000UL)
 
-/* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ and	*/
+/* TICK_USEC_TO_NSEC is the time between ticks in nsec assuming real ACTHZ and	*/
 /* a value TUSEC for TICK_USEC (can be set bij adjtimex)		*/
-#define TICK_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
+#define TICK_USEC_TO_NSEC(TUSEC) (SH_DIV (TUSEC * USER_HZ * 1000, ACTHZ, 8))
+
 
 #include <linux/time.h>
 /*
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.70-bk9-time_save/kernel/posix-timers.c	2003-06-09 17:37:10.000000000 -0700
+++ linux/kernel/posix-timers.c	2003-06-09 17:24:50.000000000 -0700
@@ -33,7 +33,7 @@
 		       result; })
 
 #endif
-#define CLOCK_REALTIME_RES TICK_NSEC(TICK_USEC)  // In nano seconds.
+#define CLOCK_REALTIME_RES TICK_NSEC  // In nano seconds.
 
 static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
 {
@@ -1192,6 +1192,7 @@
 		if (abs || !rq_time) {
 			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
 					&rq_time);
+			rq_time += (t.tv_sec || t.tv_nsec);
 		}
 
 		left = rq_time - get_jiffies_64();
@@ -1222,7 +1223,7 @@
 		if (abs)
 			return -ERESTARTNOHAND;
 
-		left *= TICK_NSEC(TICK_USEC);
+		left *= TICK_NSEC;
 		tsave->tv_sec = div_long_long_rem(left, 
 						  NSEC_PER_SEC, 
 						  &tsave->tv_nsec);
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/kernel/time.c linux/kernel/time.c
--- linux-2.5.70-bk9-time_save/kernel/time.c	2003-06-09 17:28:12.000000000 -0700
+++ linux/kernel/time.c	2003-06-09 17:22:49.000000000 -0700
@@ -337,7 +337,7 @@
 	    } /* txc->modes & ADJ_OFFSET */
 	    if (txc->modes & ADJ_TICK) {
 		tick_usec = txc->tick;
-		tick_nsec = TICK_NSEC(tick_usec);
+		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
 	    }
 	} /* txc->modes */
 leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-time_save/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.70-bk9-time_save/kernel/timer.c	2003-06-09 17:16:13.000000000 -0700
+++ linux/kernel/timer.c	2003-06-09 17:33:33.000000000 -0700
@@ -439,7 +439,7 @@
  * Timekeeping variables
  */
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
-unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+unsigned long tick_nsec = TICK_NSEC;		/* USER_HZ period (nsec) */
 
 /* 
  * The current time 
@@ -469,7 +469,7 @@
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
 long time_phase;			/* phase offset (scaled us)	*/
-long time_freq = ((1000000 + HZ/2) % HZ - HZ/2) << SHIFT_USEC;
+long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
 long time_adj;				/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
@@ -633,12 +633,12 @@
 	 * advance the tick more.
 	 */
 	time_phase += time_adj;
-	if (time_phase <= -FINEUSEC) {
+	if (time_phase <= -FINENSEC) {
 		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
 		time_phase += ltemp << (SHIFT_SCALE - 10);
 		delta_nsec -= ltemp;
 	}
-	else if (time_phase >= FINEUSEC) {
+	else if (time_phase >= FINENSEC) {
 		long ltemp = time_phase >> (SHIFT_SCALE - 10);
 		time_phase -= ltemp << (SHIFT_SCALE - 10);
 		delta_nsec += ltemp;

--------------080900020102000101060201--


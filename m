Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270148AbTHEUCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTHEUCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:02:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57331 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S270148AbTHEUCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:02:07 -0400
Message-ID: <3F300D16.5090800@mvista.com>
Date: Tue, 05 Aug 2003 13:01:26 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] for [Bug 858] New: itimer resolution and rounding vs posix
Content-Type: multipart/mixed;
 boundary="------------030308040100080900020909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------030308040100080900020909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch:

a) Fixes bug 858 (http://bugme.osdl.org/show_bug.cgi?id=858)
The problem was caused by round off error in calculating the correct 
jiffies value in micro seconds to do the round up to jiffies.  The fix 
is to do the round up AFTER conversion to jiffies, rather than before. 
  This only affected the timeval to jiffies calculation.

c.) Changed the scale values to get the highest possible precision 
short of going to full 64-bit math.  This is particularly useful in 
the scaling of the seconds part of time.  The code now computes a 
trial value at compile time and adjusts the scaling if the result is 
less than 32 bits.

b) Adds comments to time.h to remove (I hope) ALL the confusion that 
this file use to generate.

Please look over the comments, especially, and, if confusing, please 
suggest how they might be improved.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------030308040100080900020909
Content-Type: text/plain;
 name="time-2.6.0-t2-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="time-2.6.0-t2-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.0-test2-kb/include/linux/time.h linux/include/linux/time.h
--- linux-2.6.0-test2-kb/include/linux/time.h	2003-07-31 13:06:46.000000000 -0700
+++ linux/include/linux/time.h	2003-08-04 16:22:59.000000000 -0700
@@ -72,23 +72,103 @@
 
 /*
  * We want to do realistic conversions of time so we need to use the same
- * values the update wall clock code uses as the jiffie size.  This value
- * is: TICK_NSEC (both of which are defined in timex.h).  This 
- * is a constant and is in nanoseconds.  We will used scaled math and
- * with a scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and 
+ * values the update wall clock code uses as the jiffies size.  This value
+ * is: TICK_NSEC (which is defined in timex.h).  This 
+ * is a constant and is in nanoseconds.  We will used scaled math
+ * with a set of scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and 
  * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
  * constants and so are computed at compile time.  SHIFT_HZ (computed in
  * timex.h) adjusts the scaling for different HZ values.
+
+ * Scaled math???  What is that?  
+ *
+ * Scaled math is a way to do integer math on values that would,
+ * otherwise, either overflow, underflow, or cause undesired div
+ * instructions to appear in the execution path.  In short, we "scale"
+ * up the operands so they take more bits (more precision, less
+ * underflow), do the desired operation and then "scale" the result back
+ * by the same amount.  If we do the scaling by shifting we avoid the
+ * costly mpy and the dastardly div instructions.
+
+ * Suppose, for example, we want to convert from seconds to jiffies
+ * where jiffies is defined in nanoseconds as NSEC_PER_JIFFIE.  The
+ * simple math is: jiff = (sec * NSEC_PER_SEC) / NSEC_PER_JIFFIE; We
+ * observe that (NSEC_PER_SEC / NSEC_PER_JIFFIE) is a constant which we
+ * might calculate at compile time, however, the result will only have
+ * about 3-4 bits of precision (less for smaller values of HZ).  
+ *
+ * So, we scale as follows:
+ * jiff = (sec) * (NSEC_PER_SEC / NSEC_PER_JIFFIE);
+ * jiff = ((sec) * ((NSEC_PER_SEC * SCALE)/ NSEC_PER_JIFFIE)) / SCALE;
+ * Then we make SCALE a power of two so:
+ * jiff = ((sec) * ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE)) >> SCALE;
+ * Now we define:
+ * #define SEC_CONV = ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE))
+ * jiff = (sec * SEC_CONV) >> SCALE;
+ *
+ * Often the math we use will expand beyond 32-bits so we tell C how to
+ * do this and pass the 64-bit result of the mpy through the ">> SCALE"
+ * which should take the result back to 32-bits.  We want this expansion
+ * to capture as much precision as possible.  At the same time we don't
+ * want to overflow so we pick the SCALE to avoid this.  In this file,
+ * that means using a different scale for each range of HZ values (as
+ * defined in timex.h).
+ *
+ * For those who want to know, gcc will give a 64-bit result from a "*"
+ * operator if the result is a long long AND at least one of the
+ * operands is cast to long long (usually just prior to the "*" so as
+ * not to confuse it into thinking it really has a 64-bit operand,
+ * which, buy the way, it can do, but it take more code and at least 2
+ * mpys).
+
+ * We also need to be aware that one second in nanoseconds is only a
+ * couple of bits away from overflowing a 32-bit word, so we MUST use
+ * 64-bits to get the full range time in nanoseconds.
+
+ */
+
+/*
+ * Here are the scales we will use.  One for seconds, nanoseconds and
+ * microseconds.
+ *
+ * Within the limits of cpp we do a rough cut at the SEC_JIFFIE_SC and
+ * check if the sign bit is set.  If not, we bump the shift count by 1.
+ * (Gets an extra bit of precision where we can use it.)
+ * We know it is set for HZ = 1024 and HZ = 100 not for 1000.
+ * Haven't tested others.
+
+ * Limits of cpp (for #if expressions) only long (no long long), but
+ * then we only need the most signicant bit.
+ */
+
+#define SEC_JIFFIE_SC (31 - SHIFT_HZ)
+#if !((((NSEC_PER_SEC << 2) / TICK_NSEC) << (SEC_JIFFIE_SC - 2)) & 0x80000000)
+#undef SEC_JIFFIE_SC
+#define SEC_JIFFIE_SC (32 - SHIFT_HZ)
+#endif
+#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
+#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
+#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC))\
+                                         / (u64)TICK_NSEC))
+				
+#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC))\
+                                         / (u64)TICK_NSEC))
+#define USEC_CONVERSION  \
+                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC)) \
+                                         / (u64)TICK_NSEC))
+/*
+ * USEC_ROUND is used in the timeval to jiffie conversion.  See there
+ * for more details.  It is the scaled resolution rounding value.  Note
+ * that it is a 64-bit value.  Since, when it is applied, we are already
+ * in jiffies (albit scaled), it is nothing but the bits we will shift
+ * off.
+ */
+#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
+/*
+ * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
+ * into seconds.  The 64-bit case will overflow if we are not careful,
+ * so use the messy SH_DIV macro to do it.  Still all constants.
  */
-#define SEC_JIFFIE_SC (30 - SHIFT_HZ)
-#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 30)
-#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 20)
-#define SEC_CONVERSION ((unsigned long)(((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) /\
-				(u64)TICK_NSEC))
-#define NSEC_CONVERSION ((unsigned long)(((u64)1 << NSEC_JIFFIE_SC) /\
-				(u64)TICK_NSEC))
-#define USEC_CONVERSION ((unsigned long)(((u64)NSEC_PER_USEC << USEC_JIFFIE_SC)/\
-				(u64)TICK_NSEC))
 #if BITS_PER_LONG < 64
 # define MAX_SEC_IN_JIFFIES \
 	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
@@ -97,7 +177,17 @@
 	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
 
 #endif
-
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
 static __inline__ unsigned long
 timespec_to_jiffies(struct timespec *value)
 {
@@ -125,20 +215,30 @@
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }
 
-/* Same for "timeval" */
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
 static __inline__ unsigned long
 timeval_to_jiffies(struct timeval *value)
 {
 	unsigned long sec = value->tv_sec;
-	long usec = value->tv_usec 
-		+ ((TICK_NSEC + 1000UL/2) / 1000UL) - 1;
+	long usec = value->tv_usec;
 
 	if (sec >= MAX_SEC_IN_JIFFIES){
 		sec = MAX_SEC_IN_JIFFIES;
 		usec = 0;
 	}
 	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)usec * USEC_CONVERSION) >>
+		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
 		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 }
 

--------------030308040100080900020909--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTIDSXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265441AbTIDSXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:23:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:4058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265361AbTIDSWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:22:37 -0400
Date: Thu, 4 Sep 2003 11:04:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
Message-Id: <20030904110401.783ed6c1.akpm@osdl.org>
In-Reply-To: <1062698030.1315.1544.camel@cog.beaverton.ibm.com>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D23C@fmsmsx405.fm.intel.com>
	<1062698030.1315.1544.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> > I had to do an unrelated one line change in fixmap (last chunk in 
> > the patch) to compile for summit.
> 
> Is this just an -mm only thing (2.5 has _X86_CYCLONE_TIMER everywhere)?

That's the 4G/4G patch doing this:

+#ifdef CONFIG_X86_CYCLONE
        FIX_CYCLONE_TIMER, /*cyclone timer register*/
+       FIX_VSTACK_HOLE_2,
 #endif 

I was sent a patch which did:

        FIX_TSS_0,
        FIX_ENTRY_TRAMPOLINE_1,
        FIX_ENTRY_TRAMPOLINE_0,
-#ifdef CONFIG_X86_SUMMIT
+#ifdef CONFIG_X86_CYCLONE
        FIX_CYCLONE_TIMER, /*cyclone timer register*/
        FIX_VSTACK_HOLE_2,

So I'll make that CONFIG_X86_CYCLONE_TIMER.


Here's an updated version of Venkatesh's patch against current -linus. 
common.c needed asm/io.h



 arch/i386/kernel/timers/Makefile        |    2 
 arch/i386/kernel/timers/common.c        |  139 ++++++++++++++++++++++++++++++++
 arch/i386/kernel/timers/timer_cyclone.c |    1 
 arch/i386/kernel/timers/timer_hpet.c    |   59 -------------
 arch/i386/kernel/timers/timer_tsc.c     |  115 --------------------------
 include/asm-i386/fixmap.h               |    0 
 include/asm-i386/timer.h                |    2 
 7 files changed, 144 insertions(+), 174 deletions(-)

diff -puN /dev/null arch/i386/kernel/timers/common.c
--- /dev/null	2002-08-30 16:31:37.000000000 -0700
+++ 25-akpm/arch/i386/kernel/timers/common.c	2003-09-04 11:08:14.000000000 -0700
@@ -0,0 +1,139 @@
+/*
+ *	Common functions used across the timers go here
+ */
+
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/errno.h>
+
+#include <asm/io.h>
+#include <asm/timer.h>
+#include <asm/hpet.h>
+
+#include "mach_timer.h"
+
+/* ------ Calibrate the TSC -------
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+unsigned long __init calibrate_tsc(void)
+{
+	mach_prepare_counter();
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		mach_countup(&count);
+		rdtsc(endlow,endhigh);
+
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
+}
+
+#ifdef CONFIG_HPET_TIMER
+/* ------ Calibrate the TSC using HPET -------
+ * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
+ * Second output is parameter 1 (when non NULL)
+ * Set 2^32 * (1 / (tsc per HPET clk)) for delay_hpet().
+ * calibrate_tsc() calibrates the processor TSC by comparing
+ * it to the HPET timer of known frequency.
+ * Too much 64-bit arithmetic here to do this cleanly in C
+ */
+#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
+#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
+
+unsigned long __init calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr)
+{
+	unsigned long tsc_startlow, tsc_starthigh;
+	unsigned long tsc_endlow, tsc_endhigh;
+	unsigned long hpet_start, hpet_end;
+	unsigned long result, remain;
+
+	hpet_start = hpet_readl(HPET_COUNTER);
+	rdtsc(tsc_startlow, tsc_starthigh);
+	do {
+		hpet_end = hpet_readl(HPET_COUNTER);
+	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
+	rdtsc(tsc_endlow, tsc_endhigh);
+
+	/* 64-bit subtract - gcc just messes up with long longs */
+	__asm__("subl %2,%0\n\t"
+		"sbbl %3,%1"
+		:"=a" (tsc_endlow), "=d" (tsc_endhigh)
+		:"g" (tsc_startlow), "g" (tsc_starthigh),
+		 "0" (tsc_endlow), "1" (tsc_endhigh));
+
+	/* Error: ECPUTOOFAST */
+	if (tsc_endhigh)
+		goto bad_calibration;
+
+	/* Error: ECPUTOOSLOW */
+	if (tsc_endlow <= CALIBRATE_TIME_HPET)
+		goto bad_calibration;
+
+	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
+	if (remain > (tsc_endlow >> 1))
+		result++; /* rounding the result */
+
+	if (tsc_hpet_quotient_ptr) {
+		unsigned long tsc_hpet_quotient;
+
+		ASM_DIV64_REG(tsc_hpet_quotient, remain, tsc_endlow, 0,
+			CALIBRATE_CNT_HPET);
+		if (remain > (tsc_endlow >> 1))
+			tsc_hpet_quotient++; /* rounding the result */
+		*tsc_hpet_quotient_ptr = tsc_hpet_quotient;
+	}
+
+	return result;
+bad_calibration:
+	/*
+	 * the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+	return 0;
+}
+#endif
+
diff -puN arch/i386/kernel/timers/Makefile~calibrate_tsc-consolidation arch/i386/kernel/timers/Makefile
--- 25/arch/i386/kernel/timers/Makefile~calibrate_tsc-consolidation	2003-09-04 11:02:03.000000000 -0700
+++ 25-akpm/arch/i386/kernel/timers/Makefile	2003-09-04 11:02:03.000000000 -0700
@@ -2,7 +2,7 @@
 # Makefile for x86 timers
 #
 
-obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o
+obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o common.o
 
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
diff -puN arch/i386/kernel/timers/timer_cyclone.c~calibrate_tsc-consolidation arch/i386/kernel/timers/timer_cyclone.c
--- 25/arch/i386/kernel/timers/timer_cyclone.c~calibrate_tsc-consolidation	2003-09-04 11:02:03.000000000 -0700
+++ 25-akpm/arch/i386/kernel/timers/timer_cyclone.c	2003-09-04 11:02:03.000000000 -0700
@@ -19,7 +19,6 @@
 #include <asm/fixmap.h>
 
 extern spinlock_t i8253_lock;
-extern unsigned long calibrate_tsc(void);
 
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
diff -puN arch/i386/kernel/timers/timer_hpet.c~calibrate_tsc-consolidation arch/i386/kernel/timers/timer_hpet.c
--- 25/arch/i386/kernel/timers/timer_hpet.c~calibrate_tsc-consolidation	2003-09-04 11:02:03.000000000 -0700
+++ 25-akpm/arch/i386/kernel/timers/timer_hpet.c	2003-09-04 11:02:03.000000000 -0700
@@ -131,63 +131,6 @@ void delay_hpet(unsigned long loops)
 	} while ((hpet_end - hpet_start) < (loops));
 }
 
-/* ------ Calibrate the TSC -------
- * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
- * Set 2^32 * (1 / (tsc per HPET clk)) for delay_hpet().
- * calibrate_tsc() calibrates the processor TSC by comparing
- * it to the HPET timer of known frequency.
- * Too much 64-bit arithmetic here to do this cleanly in C
- */
-#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
-#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
-
-static unsigned long __init calibrate_tsc(void)
-{
-	unsigned long tsc_startlow, tsc_starthigh;
-	unsigned long tsc_endlow, tsc_endhigh;
-	unsigned long hpet_start, hpet_end;
-	unsigned long result, remain;
-
-	hpet_start = hpet_readl(HPET_COUNTER);
-	rdtsc(tsc_startlow, tsc_starthigh);
-	do {
-		hpet_end = hpet_readl(HPET_COUNTER);
-	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
-	rdtsc(tsc_endlow, tsc_endhigh);
-
-	/* 64-bit subtract - gcc just messes up with long longs */
-	__asm__("subl %2,%0\n\t"
-		"sbbl %3,%1"
-		:"=a" (tsc_endlow), "=d" (tsc_endhigh)
-		:"g" (tsc_startlow), "g" (tsc_starthigh),
-		 "0" (tsc_endlow), "1" (tsc_endhigh));
-
-	/* Error: ECPUTOOFAST */
-	if (tsc_endhigh)
-		goto bad_calibration;
-
-	/* Error: ECPUTOOSLOW */
-	if (tsc_endlow <= CALIBRATE_TIME_HPET)
-		goto bad_calibration;
-
-	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
-	if (remain > (tsc_endlow >> 1))
-		result++; /* rounding the result */
-
-	ASM_DIV64_REG(tsc_hpet_quotient, remain, tsc_endlow, 0,
-			CALIBRATE_CNT_HPET);
-	if (remain > (tsc_endlow >> 1))
-		tsc_hpet_quotient++; /* rounding the result */
-
-	return result;
-bad_calibration:
-	/*
-	 * the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-	return 0;
-}
-
 static int __init init_hpet(char* override)
 {
 	unsigned long result, remain;
@@ -201,7 +144,7 @@ static int __init init_hpet(char* overri
 
 	printk("Using HPET for gettimeofday\n");
 	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
+		unsigned long tsc_quotient = calibrate_tsc_hpet(&tsc_hpet_quotient);
 		if (tsc_quotient) {
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
diff -puN arch/i386/kernel/timers/timer_tsc.c~calibrate_tsc-consolidation arch/i386/kernel/timers/timer_tsc.c
--- 25/arch/i386/kernel/timers/timer_tsc.c~calibrate_tsc-consolidation	2003-09-04 11:02:03.000000000 -0700
+++ 25-akpm/arch/i386/kernel/timers/timer_tsc.c	2003-09-04 11:02:03.000000000 -0700
@@ -230,67 +230,6 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
 
-/* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
-static unsigned long __init calibrate_tsc(void)
-{
-	mach_prepare_counter();
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		mach_countup(&count);
-		rdtsc(endlow,endhigh);
-
-		last_tsc_low = endlow;
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
-	}
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-bad_ctc:
-	return 0;
-}
-
 #ifdef CONFIG_HPET_TIMER
 static void mark_offset_tsc_hpet(void)
 {
@@ -339,58 +278,6 @@ static void mark_offset_tsc_hpet(void)
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
 }
-
-/* ------ Calibrate the TSC based on HPET timer -------
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * calibrate_tsc() calibrates the processor TSC by comparing
- * it to the HPET timer of known frequency.
- * Too much 64-bit arithmetic here to do this cleanly in C
- */
-
-#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
-#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
-
-unsigned long __init calibrate_tsc_hpet(void)
-{
-	unsigned long tsc_startlow, tsc_starthigh;
-	unsigned long tsc_endlow, tsc_endhigh;
-	unsigned long hpet_start, hpet_end;
-	unsigned long result, remain;
-
-	hpet_start = hpet_readl(HPET_COUNTER);
-	rdtsc(tsc_startlow, tsc_starthigh);
-	do {
-		hpet_end = hpet_readl(HPET_COUNTER);
-	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
-	rdtsc(tsc_endlow, tsc_endhigh);
-
-	/* 64-bit subtract - gcc just messes up with long longs */
-	__asm__("subl %2,%0\n\t"
-		"sbbl %3,%1"
-		:"=a" (tsc_endlow), "=d" (tsc_endhigh)
-		:"g" (tsc_startlow), "g" (tsc_starthigh),
-		 "0" (tsc_endlow), "1" (tsc_endhigh));
-
-	/* Error: ECPUTOOFAST */
-	if (tsc_endhigh)
-		goto bad_calibration;
-
-	/* Error: ECPUTOOSLOW */
-	if (tsc_endlow <= CALIBRATE_TIME_HPET)
-		goto bad_calibration;
-
-	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
-	if (remain > (tsc_endlow >> 1))
-		result++; /* rounding the result */
-
-	return result;
-bad_calibration:
-	/*
-	 * the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_CPU_FREQ
@@ -491,7 +378,7 @@ static int __init init_tsc(char* overrid
 		if (is_hpet_enabled()){
 			unsigned long result, remain;
 			printk("Using TSC for gettimeofday\n");
-			tsc_quotient = calibrate_tsc_hpet();
+			tsc_quotient = calibrate_tsc_hpet(NULL);
 			timer_tsc.mark_offset = &mark_offset_tsc_hpet;
 			/*
 			 * Math to calculate hpet to usec multiplier
diff -puN include/asm-i386/fixmap.h~calibrate_tsc-consolidation include/asm-i386/fixmap.h
diff -puN include/asm-i386/timer.h~calibrate_tsc-consolidation include/asm-i386/timer.h
--- 25/include/asm-i386/timer.h~calibrate_tsc-consolidation	2003-09-04 11:02:03.000000000 -0700
+++ 25-akpm/include/asm-i386/timer.h	2003-09-04 11:02:03.000000000 -0700
@@ -38,8 +38,10 @@ extern struct timer_opts timer_tsc;
 extern struct timer_opts timer_cyclone;
 #endif
 
+extern unsigned long calibrate_tsc(void);
 #ifdef CONFIG_HPET_TIMER
 extern struct timer_opts timer_hpet;
+extern unsigned long calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr);
 #endif
 
 #endif

_


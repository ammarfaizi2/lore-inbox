Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVA2Cvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVA2Cvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVA2Cvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:51:43 -0500
Received: from fmr24.intel.com ([143.183.121.16]:32441 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262844AbVA2CvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:51:09 -0500
Date: Fri, 28 Jan 2005 18:51:01 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Cc: rohit.seth@intel.com, asit.k.mallick@intel.com
Subject: [Discuss][i386] Platform SMIs and their interferance with tsc based delay calibration
Message-ID: <20050128185101.A19117@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Issue: 
Current tsc based delay_calibration can result in significant errors in loops_per_jiffy count when the platform events like SMIs (System Management Interrupts that are non-maskable) are present. This could lead to potential kernel panic(). This issue is becoming more visible with 2.6 kernel (as default HZ is 1000) and on platforms with higher SMI handling latencies. During the boot time, SMIs are mostly used by BIOS (for things like legacy keyboard emulation). 

Description:
The psuedocode for current delay calibration with tsc based delay looks like
(0) Estimate a value for loops_per_jiffy
(1) While (loops_per_jiffy estimate is accurate enough)
(2)   wait for jiffy transition (jiffy1)
(3)   Note down current tsc (tsc1)
(4)   loop until tsc becomes tsc1 + loops_per_jiffy
(5)   check whether jiffy changed since jiffy1 or not and refine loops_per_jiffy estimate

Consider the following cases
Case 1:
If SMIs happen between (2) and (3) above, we can end up with a loops_per_jiffy value that is too low. This results in shorted delays and kernel can panic () during boot (Mostly at IOAPIC timer initialization timer_irq_works() as we don't have enough timer interrupts in a specified interval).

Case 2:
If SMIs happen between (3) and (4) above, then we can end up with a loops_per_jiffy value that is too high. And with current i386 code, too high lpj value (greater than 17M) can result in a overflow in delay.c:__const_udelay() again resulting in shorter delay and panic().


Solution:
The patch below makes the calibration routine aware of asynchronous events like SMIs. We increase the delay calibration time and also identify any significant errors (greater than 12.5%) in the calibration and notify it to user. Like to know your comments on this.

Thanks,
Venki

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

--- linux-2.6.10/./arch/i386/kernel/timers/timer_tsc.c.org	2005-01-05 16:06:52.000000000 -0800
+++ linux-2.6.10/./arch/i386/kernel/timers/timer_tsc.c	2005-01-19 12:38:20.000000000 -0800
@@ -552,6 +552,7 @@ static struct timer_opts timer_tsc = {
 	.get_offset = get_offset_tsc,
 	.monotonic_clock = monotonic_clock_tsc,
 	.delay = delay_tsc,
+	.calibrate_delay = calibrate_delay_tsc,
 };
 
 struct init_timer_opts __initdata timer_tsc_init = {
--- linux-2.6.10/./arch/i386/kernel/timers/common.c.org	2005-01-11 17:51:28.000000000 -0800
+++ linux-2.6.10/./arch/i386/kernel/timers/common.c	2005-01-19 12:38:20.000000000 -0800
@@ -158,3 +158,49 @@ void __init init_cpu_khz(void)
 		}
 	}
 }
+
+unsigned long calibrate_delay_tsc(void)
+{
+	unsigned long pre_start, start, post_start;
+	unsigned long pre_end, end, post_end;
+	unsigned long start_jiffies;
+	unsigned long tsc_rate_min, tsc_rate_max;
+
+	if (!cpu_has_tsc)
+		return 0;
+
+#define DELAY_CALIBRATION_TICKS		((HZ < 100) ? 1 : (HZ/100))
+	pre_start = 0;
+	rdtscl(start);
+	start_jiffies = jiffies;
+	while (jiffies <= (start_jiffies + 1)) {
+		pre_start = start;
+		rdtscl(start);
+	}
+	rdtscl(post_start);
+	pre_end = 0;
+	end = post_start;
+	while (jiffies <= (start_jiffies + 1 + DELAY_CALIBRATION_TICKS)) {
+		pre_end = end;
+		rdtscl(end);
+	}
+	rdtscl(post_end);
+
+	tsc_rate_max = (post_end - pre_start) / DELAY_CALIBRATION_TICKS;
+	tsc_rate_min = (pre_end - post_start) / DELAY_CALIBRATION_TICKS;
+
+	/*
+	 * If the upper limit and lower limit of the tsc_rate is more than
+	 * 12.5% apart.
+	 */
+	if (pre_start == 0 || pre_end == 0 ||
+	    (tsc_rate_max - tsc_rate_min) > (tsc_rate_max >> 3)) {
+		printk(KERN_WARNING "TSC calibration may not be precise. " 
+		       "Too many SMIs? "
+		       "Consider running with \"lpj=\" boot option\n");
+		return 0;
+	}
+
+	return tsc_rate_max;
+}
+
--- linux-2.6.10/./arch/i386/kernel/timers/timer_hpet.c.org	2005-01-11 17:52:31.000000000 -0800
+++ linux-2.6.10/./arch/i386/kernel/timers/timer_hpet.c	2005-01-19 12:38:20.000000000 -0800
@@ -183,6 +183,7 @@ static struct timer_opts timer_hpet = {
 	.get_offset =		get_offset_hpet,
 	.monotonic_clock =	monotonic_clock_hpet,
 	.delay = 		delay_hpet,
+	.calibrate_delay = 	calibrate_delay_tsc,
 };
 
 struct init_timer_opts __initdata timer_hpet_init = {
--- linux-2.6.10/./arch/i386/kernel/timers/timer_pm.c.org	2005-01-11 17:55:55.000000000 -0800
+++ linux-2.6.10/./arch/i386/kernel/timers/timer_pm.c	2005-01-19 12:38:20.000000000 -0800
@@ -246,6 +246,7 @@ static struct timer_opts timer_pmtmr = {
 	.get_offset		= get_offset_pmtmr,
 	.monotonic_clock 	= monotonic_clock_pmtmr,
 	.delay 			= delay_pmtmr,
+	.calibrate_delay 	= calibrate_delay_tsc,
 };
 
 struct init_timer_opts __initdata timer_pmtmr_init = {
--- linux-2.6.10/./arch/i386/kernel/timers/calibrate.c.org	2005-01-19 12:25:23.000000000 -0800
+++ linux-2.6.10/./arch/i386/kernel/timers/calibrate.c	2005-01-19 12:37:59.000000000 -0800
@@ -0,0 +1,96 @@
+/* calibrate.c: i386 specific delay calibration
+ *
+ * Mostly from init/calibrate.c with addition of __calibrate_delay() for arch
+ * specific stuff.
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <asm/timer.h>
+
+static unsigned long __init __calibrate_delay()
+{
+	if (cur_timer->calibrate_delay)
+		return cur_timer->calibrate_delay();
+
+	return 0;
+}
+
+static unsigned long preset_lpj;
+static int __init lpj_setup(char *str)
+{
+	preset_lpj = simple_strtoul(str,NULL,0);
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.  Each
+ * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
+ * better than 1%
+ */
+#define LPS_PREC 8
+
+void __devinit calibrate_delay(void)
+{
+	unsigned long ticks, loopbit;
+	int lps_precision = LPS_PREC;
+
+	if (preset_lpj) {
+		loops_per_jiffy = preset_lpj;
+		printk("Calibrating delay loop (skipped)... "
+			"%lu.%02lu BogoMIPS preset\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);
+	} else if ((loops_per_jiffy = __calibrate_delay()) != 0) {
+		printk("Calibrating delay using timer specific routine.. ");
+		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100,
+			loops_per_jiffy);
+	} else {
+		loops_per_jiffy = (1<<12);
+
+		printk(KERN_DEBUG "Calibrating delay loop... ");
+		while ((loops_per_jiffy <<= 1) != 0) {
+			/* wait for "start of" clock tick */
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			/* Go .. */
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			ticks = jiffies - ticks;
+			if (ticks)
+				break;
+		}
+
+		/*
+		 * Do a binary approximation to get loops_per_jiffy set to
+		 * equal one clock (up to lps_precision bits)
+		 */
+		loops_per_jiffy >>= 1;
+		loopbit = loops_per_jiffy;
+		while (lps_precision-- && (loopbit >>= 1)) {
+			loops_per_jiffy |= loopbit;
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			if (jiffies != ticks)	/* longer than 1 tick */
+				loops_per_jiffy &= ~loopbit;
+		}
+
+		/* Round the value and print it */
+		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100,
+			loops_per_jiffy);
+	}
+
+}
--- linux-2.6.10/./arch/i386/kernel/timers/Makefile.org	2005-01-19 12:25:30.000000000 -0800
+++ linux-2.6.10/./arch/i386/kernel/timers/Makefile	2005-01-19 12:26:00.000000000 -0800
@@ -2,7 +2,7 @@
 # Makefile for x86 timers
 #
 
-obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o common.o
+obj-y :=calibrate.o  timer.o timer_none.o timer_tsc.o timer_pit.o common.o
 
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
--- linux-2.6.10/./arch/i386/Kconfig.org	2005-01-19 12:24:13.000000000 -0800
+++ linux-2.6.10/./arch/i386/Kconfig	2005-01-19 12:24:37.000000000 -0800
@@ -373,10 +373,6 @@ config RWSEM_XCHGADD_ALGORITHM
 	depends on !M386
 	default y
 
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
 config X86_PPRO_FENCE
 	bool
 	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386
--- linux-2.6.10/./include/asm-i386/timer.h.org	2005-01-05 14:07:04.000000000 -0800
+++ linux-2.6.10/./include/asm-i386/timer.h	2005-01-19 12:38:20.000000000 -0800
@@ -22,6 +22,7 @@ struct timer_opts {
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
+	unsigned long (*calibrate_delay)(void);
 };
 
 struct init_timer_opts {
@@ -52,6 +53,7 @@ extern struct init_timer_opts timer_cycl
 #endif
 
 extern unsigned long calibrate_tsc(void);
+extern unsigned long calibrate_delay_tsc(void);
 extern void init_cpu_khz(void);
 #ifdef CONFIG_HPET_TIMER
 extern struct init_timer_opts timer_hpet_init;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVDODo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDODo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 23:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVDODo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 23:44:59 -0400
Received: from fmr23.intel.com ([143.183.121.15]:53398 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261508AbVDODom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 23:44:42 -0400
Date: Thu, 14 Apr 2005 20:44:23 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Rohit Seth <rohit.seth@intel.com>, asit.k.mallick@intel.com,
       Andi Kleen <ak@suse.de>, John Stultz <johnstul@us.ibm.com>,
       martin.wilck@fujitsu-siemens.com
Subject: [PATCH] Platform SMIs and their interferance with tsc based delay calibration
Message-ID: <20050414204422.A7663@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Missed copying to the list earlier... sorry if this mail is a duplicate.


Following up on earlier thread
http://www.ussg.iu.edu/hypermail/linux/kernel/0501.3/index.html#1694

Changes from the earlier version:
(1) Now this new routine is generic
(2) Handles both i386 amd x86-64
(3) Repeates the delay calibration 5 times to get good value


Thanks,
Venki 



Issue:
Current tsc based delay_calibration can result in significant errors in 
loops_per_jiffy count when the platform events like SMIs 
(System Management Interrupts that are non-maskable) are present. This could 
lead to potential kernel panic(). This issue is becoming more visible with 2.6 
kernel (as default HZ is 1000) and on platforms with higher SMI handling 
latencies. During the boot time, SMIs are mostly used by BIOS (for things 
like legacy keyboard emulation).

Description:
The psuedocode for current delay calibration with tsc based delay looks like
(0) Estimate a value for loops_per_jiffy
(1) While (loops_per_jiffy estimate is accurate enough)
(2)   wait for jiffy transition (jiffy1)
(3)   Note down current tsc (tsc1)
(4)   loop until tsc becomes tsc1 + loops_per_jiffy
(5)   check whether jiffy changed since jiffy1 or not and refine 
loops_per_jiffy estimate

Consider the following cases
Case 1:
If SMIs happen between (2) and (3) above, we can end up with a 
loops_per_jiffy value that is too low. This results in shorted delays and 
kernel can panic () during boot (Mostly at IOAPIC timer initialization 
timer_irq_works() as we don't have enough timer interrupts in a specified 
interval).

Case 2:
If SMIs happen between (3) and (4) above, then we can end up with a 
loops_per_jiffy value that is too high. And with current i386 code, too 
high lpj value (greater than 17M) can result in a overflow in 
delay.c:__const_udelay() again resulting in shorter delay and panic().


Solution:
The patch below makes the calibration routine aware of asynchronous events 
like SMIs. We increase the delay calibration time and also identify any 
significant errors (greater than 12.5%) in the calibration and notify it to 
user.

Patch below changes both i386 and x86-64 architectures to use this 
new and improved calibrate_delay_direct() routine.


Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>


diff -purN  linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer.c.orig linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer.c
--- linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer.c.orig	2005-03-01 23:38:26.000000000 -0800
+++ linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer.c	2005-04-14 17:06:04.000000000 -0700
@@ -64,3 +64,12 @@ struct timer_opts* __init select_timer(v
 	panic("select_timer: Cannot find a suitable timer\n");
 	return NULL;
 }
+
+int read_current_timer(unsigned long *timer_val)
+{
+	if (cur_timer->read_timer) {
+		*timer_val = cur_timer->read_timer();
+		return 0;
+	}
+	return -1;
+}
diff -purN  linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/common.c.orig linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/common.c
--- linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/common.c.orig	2005-04-14 17:03:42.000000000 -0700
+++ linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/common.c	2005-04-14 17:07:35.000000000 -0700
@@ -139,6 +139,15 @@ bad_calibration:
 }
 #endif
 
+ 
+unsigned long read_timer_tsc(void)
+{
+	unsigned long retval;
+	rdtscl(retval);
+	return retval;
+}
+
+
 /* calculate cpu_khz */
 void init_cpu_khz(void)
 {
diff -purN  linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_tsc.c.orig linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_tsc.c.orig	2005-04-14 17:03:42.000000000 -0700
+++ linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_tsc.c	2005-04-14 17:06:04.000000000 -0700
@@ -572,6 +572,7 @@ static struct timer_opts timer_tsc = {
 	.get_offset = get_offset_tsc,
 	.monotonic_clock = monotonic_clock_tsc,
 	.delay = delay_tsc,
+	.read_timer = read_timer_tsc,
 };
 
 struct init_timer_opts __initdata timer_tsc_init = {
diff -purN  linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_hpet.c.orig linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_hpet.c.orig	2005-04-14 17:03:28.000000000 -0700
+++ linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_hpet.c	2005-04-14 17:06:04.000000000 -0700
@@ -183,6 +183,7 @@ static struct timer_opts timer_hpet = {
 	.get_offset =		get_offset_hpet,
 	.monotonic_clock =	monotonic_clock_hpet,
 	.delay = 		delay_hpet,
+	.read_timer = 		read_timer_tsc,
 };
 
 struct init_timer_opts __initdata timer_hpet_init = {
diff -purN  linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_pm.c.orig linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_pm.c.orig	2005-03-01 23:37:48.000000000 -0800
+++ linux-2.6.12-rc2-mm3//arch/i386/kernel/timers/timer_pm.c	2005-04-14 17:06:04.000000000 -0700
@@ -246,6 +246,7 @@ static struct timer_opts timer_pmtmr = {
 	.get_offset		= get_offset_pmtmr,
 	.monotonic_clock 	= monotonic_clock_pmtmr,
 	.delay 			= delay_pmtmr,
+	.read_timer 		= read_timer_tsc,
 };
 
 struct init_timer_opts __initdata timer_pmtmr_init = {
diff -purN  linux-2.6.12-rc2-mm3//arch/x86_64/lib/delay.c.orig linux-2.6.12-rc2-mm3//arch/x86_64/lib/delay.c
--- linux-2.6.12-rc2-mm3//arch/x86_64/lib/delay.c.orig	2005-04-14 17:03:28.000000000 -0700
+++ linux-2.6.12-rc2-mm3//arch/x86_64/lib/delay.c	2005-04-14 17:06:04.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <asm/delay.h>
+#include <asm/msr.h>
 
 #ifdef CONFIG_SMP
 #include <asm/smp.h>
@@ -19,6 +20,12 @@
 
 int x86_udelay_tsc = 0;		/* Delay via TSC */
 
+int read_current_timer(unsigned long *timer_value)
+{
+	rdtscll(*timer_value);
+	return 0;
+}
+
 void __delay(unsigned long loops)
 {
 	unsigned bclock, now;
diff -purN  linux-2.6.12-rc2-mm3//include/asm-x86_64/timex.h.orig linux-2.6.12-rc2-mm3//include/asm-x86_64/timex.h
--- linux-2.6.12-rc2-mm3//include/asm-x86_64/timex.h.orig	2005-04-14 17:03:30.000000000 -0700
+++ linux-2.6.12-rc2-mm3//include/asm-x86_64/timex.h	2005-04-14 17:06:04.000000000 -0700
@@ -26,6 +26,9 @@ static inline cycles_t get_cycles (void)
 
 extern unsigned int cpu_khz;
 
+extern int read_current_timer(unsigned long *timer_value);
+#define ARCH_HAS_READ_CURRENT_TIMER	1
+
 extern struct vxtime_data vxtime;
 
 #endif
diff -purN  linux-2.6.12-rc2-mm3//include/asm-i386/timer.h.orig linux-2.6.12-rc2-mm3//include/asm-i386/timer.h
--- linux-2.6.12-rc2-mm3//include/asm-i386/timer.h.orig	2005-04-14 17:03:43.000000000 -0700
+++ linux-2.6.12-rc2-mm3//include/asm-i386/timer.h	2005-04-14 17:06:04.000000000 -0700
@@ -22,6 +22,7 @@ struct timer_opts {
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
+	unsigned long (*read_timer)(void);
 };
 
 struct init_timer_opts {
@@ -52,6 +53,7 @@ extern struct init_timer_opts timer_cycl
 #endif
 
 extern unsigned long calibrate_tsc(void);
+extern unsigned long read_timer_tsc(void);
 extern void init_cpu_khz(void);
 extern int recalibrate_cpu_khz(void);
 #ifdef CONFIG_HPET_TIMER
diff -purN  linux-2.6.12-rc2-mm3//include/asm-i386/timex.h.orig linux-2.6.12-rc2-mm3//include/asm-i386/timex.h
--- linux-2.6.12-rc2-mm3//include/asm-i386/timex.h.orig	2005-04-14 17:03:30.000000000 -0700
+++ linux-2.6.12-rc2-mm3//include/asm-i386/timex.h	2005-04-14 17:06:04.000000000 -0700
@@ -49,4 +49,7 @@ static inline cycles_t get_cycles (void)
 
 extern unsigned long cpu_khz;
 
+extern int read_current_timer(unsigned long *timer_value);
+#define ARCH_HAS_READ_CURRENT_TIMER	1
+
 #endif
diff -purN  linux-2.6.12-rc2-mm3//init/calibrate.c.orig linux-2.6.12-rc2-mm3//init/calibrate.c
--- linux-2.6.12-rc2-mm3//init/calibrate.c.orig	2005-03-01 23:37:49.000000000 -0800
+++ linux-2.6.12-rc2-mm3//init/calibrate.c	2005-04-14 17:21:33.000000000 -0700
@@ -8,6 +8,8 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 
+#include <asm/timex.h>
+
 static unsigned long preset_lpj;
 static int __init lpj_setup(char *str)
 {
@@ -17,6 +19,92 @@ static int __init lpj_setup(char *str)
 
 __setup("lpj=", lpj_setup);
 
+#ifdef ARCH_HAS_READ_CURRENT_TIMER
+
+/* This routine uses the read_current_timer() routine and gets the 
+ * loops per jiffy directly, instead of guessing it using delay().
+ * Also, this code tries to handle non-maskable asynchronous events 
+ * (like SMIs)
+ */
+#define DELAY_CALIBRATION_TICKS			((HZ < 100) ? 1 : (HZ/100))
+#define MAX_DIRECT_CALIBRATION_RETRIES		5
+
+unsigned long __devinit calibrate_delay_direct(void)
+{
+	unsigned long pre_start, start, post_start;
+	unsigned long pre_end, end, post_end;
+	unsigned long start_jiffies;
+	unsigned long tsc_rate_min, tsc_rate_max;
+	unsigned long good_tsc_sum = 0;
+	unsigned long good_tsc_count = 0;
+	int i;
+
+	if (read_current_timer(&pre_start) < 0 )
+		return 0;
+
+	/*
+	 * A simple loop like
+	 *	while ( jiffies < start_jiffies+1)
+	 *		start = read_current_timer();
+	 * will not do. As we don't really know whether jiffy switch 
+	 * happened first or timer_value was read first. And some asynchronous 
+	 * event can happen between these two events introducing errors in lpj.
+	 *
+	 * So, we do
+	 * 1. pre_start <- When we are sure that jiffy switch hasn't happened
+	 * 2. check jiffy switch
+	 * 3. start <- timer value before or after jiffy switch
+	 * 4. post_start <- When we are sure that jiffy switch has happened
+	 *
+	 * Note, we don't know anything about order of 2 and 3.
+	 * Now, by looking at post_start and pre_start difference, we can
+	 * check whether any asynchronous event happened or not
+	 */
+
+	for (i = 0; i < MAX_DIRECT_CALIBRATION_RETRIES; i++) {
+		pre_start = 0;
+		read_current_timer(&start);
+		start_jiffies = jiffies;
+		while (jiffies <= (start_jiffies + 1)) {
+			pre_start = start;
+			read_current_timer(&start);
+		}
+		read_current_timer(&post_start);
+
+		pre_end = 0;
+		end = post_start;
+		while (jiffies <= 
+		       (start_jiffies + 1 + DELAY_CALIBRATION_TICKS)) {
+			pre_end = end;
+			read_current_timer(&end);
+		}
+		read_current_timer(&post_end);
+
+		tsc_rate_max = (post_end - pre_start) / DELAY_CALIBRATION_TICKS;
+		tsc_rate_min = (pre_end - post_start) / DELAY_CALIBRATION_TICKS;
+
+		/*
+	 	 * If the upper limit and lower limit of the tsc_rate is 
+		 * >= 12.5% apart, redo calibration.
+		 */
+		if (pre_start != 0 && pre_end != 0 &&
+		    (tsc_rate_max - tsc_rate_min) < (tsc_rate_max >> 3)) {
+			good_tsc_count++;
+			good_tsc_sum += tsc_rate_max;
+		}
+	}
+
+	if (good_tsc_count)
+		return (good_tsc_sum/good_tsc_count);
+
+	printk(KERN_WARNING "calibrate_delay_direct() failed to get a good "
+	       "estimate for loops_per_jiffy.\nProbably due to long platform interrupts. Consider using \"lpj=\" boot option.\n");
+	return 0;
+}
+#else
+unsigned long __devinit calibrate_delay_direct(void) {return 0;}
+#endif
+ 
 /*
  * This is the number of bits of precision for the loops_per_jiffy.  Each
  * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
@@ -35,6 +123,12 @@ void __devinit calibrate_delay(void)
 			"%lu.%02lu BogoMIPS preset\n",
 			loops_per_jiffy/(500000/HZ),
 			(loops_per_jiffy/(5000/HZ)) % 100);
+	} else if ((loops_per_jiffy = calibrate_delay_direct()) != 0) {
+		printk("Calibrating delay using timer specific routine.. ");
+		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100,
+			loops_per_jiffy);
 	} else {
 		loops_per_jiffy = (1<<12);
 

----- End forwarded message -----

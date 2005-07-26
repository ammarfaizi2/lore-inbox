Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVGZWgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVGZWgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVGZWeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:34:09 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:9356 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262285AbVGZWck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:32:40 -0400
X-ME-UUID: 20050726223238271.069B91FFFD41@mwinf0102.wanadoo.fr
Subject: PATCH: Assume PM Timer to be reliable on broken board/BIOS
From: Olivier Fourdan <fourdan@xfce.org>
To: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-o6fye+2/SA/Op/iZmTa3"
Organization: http://www.xfce.org
Date: Wed, 27 Jul 2005 00:32:37 +0200
Message-Id: <1122417157.5661.2.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o6fye+2/SA/Op/iZmTa3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,


Background
==========

I have a laptop (Compaq R3480EA, AMD 64 3400+ with NForce3) and reported
multiple problems related to timer issues.

In a nutshell, sometimes, the PIT/TSC timer runs 3x too fast [1]. That
causes many issues, including DMA errors, MCE, and clock running way too
fast (making the laptop unusable for any software development). So far,
no BIOS update was able to fix the issue for me.

As I first reported this the LKML back in march [2], the only reliable
time source on this laptop seems to be the PM timer. However, the time
in Linux is tick based and forcing the PM timer doesn't help.

Also, the PIT timer being used to calibrate the lpj, the wrong LP was
causing the nasty errors I had with DMA and other MCE. Although the lpj
can be forced at boot, having it right in the first place even on such
broken hardware as my laptop can save quite a lot of time and
investigations for novice users.

Many similar reports can be found on the web for the Compaq R3000 and HP
zv5000 laptops, either with 64 or 32 bit CPU [3]. Similar bug reports
with no fix can be also found in SuSE and Red Hat bugzilla databases.

What the patch does
===================

Basically, the patch adjusts the PIT/TSC passed values based on the PM
timer rate.

The PM timer is compared to the TSC/PIT rate and a a multiplier is
computed. On a "normal" system, the ratio is 1. On my broken laptop, the
ratio is 3.

That ration is then applied to all values passed to the PIT timer.

For example, instead of using:

               outb_p(LATCH & 0xff, PIT_CH0);
               outb(LATCH >> 8, PIT_CH0);

The patch uses :
               outb_p((LATCH * timer_mult) & 0xff, PIT_CH0);
               outb((LATCH * timer_mult) >> 8, PIT_CH0);

Also, the ratio is computed/used only if the user has specified the
"clock=pmtmr" boot option on i386 or "pmtmr" on x86_64. If the user has
not explicitly asked for the PM timer to be used, and if there is a
delta of more than 5% between the PM timer and the PIT, then the PM
timer is not used (just like it is in the current implementation for
i386 arch).

What is included in the patch
=============================

The patch includes the code that implements the workaround described
above for x86_64 and i386 arch.

The patch applies in Linux 2.6.12.3.

Documentation is also updated.
==================================================================================


Please let me know if there are some fixes or improvements to add and if
such a patch could be suitable in the kernel.

As a side note, this patch is very useful for me as it makes the laptop
usable under Linux and I plan to keep it available somewhere on xfce.org
so that other Compaq R3000 and HP zv5000 owners can use it.

Ref.

[1] http://kerneltrap.org/mailarchive/1/message/43741/thread
[2] http://lkml.org/lkml/2005/3/29/265
[3] http://lists.pcxperience.com/pipermail/linuxr3000/2004-
September/003678.html
    http://lists.pcxperience.com/pipermail/linuxr3000/2004-
September/003788.html
    http://lists.pcxperience.com/pipermail/linuxr3000/2005-
July/006763.html
    http://lists.pcxperience.com/pipermail/linuxr3000/2005-
January/004650.html

Thanks,
Regards,
Olivier.


--=-o6fye+2/SA/Op/iZmTa3
Content-Disposition: attachment; filename=linux-2.6.12.3-pmtimer.patch
Content-Type: text/x-patch; name=linux-2.6.12.3-pmtimer.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.12.3/arch/i386/kernel/time.c linux-2.6.12.3-pmtimer/arch/i386/kernel/time.c
--- linux-2.6.12.3/arch/i386/kernel/time.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/i386/kernel/time.c	2005-07-26 22:30:52.000000000 +0200
@@ -77,6 +77,12 @@
 
 EXPORT_SYMBOL(jiffies_64);
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+u16 timer_mult = 1;
+
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
 
 extern unsigned long wall_jiffies;
diff -Naur linux-2.6.12.3/arch/i386/kernel/timers/timer_cyclone.c linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_cyclone.c
--- linux-2.6.12.3/arch/i386/kernel/timers/timer_cyclone.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_cyclone.c	2005-07-26 22:52:24.000000000 +0200
@@ -21,6 +21,12 @@
 
 extern spinlock_t i8253_lock;
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+extern u16 timer_mult;
+
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -70,8 +76,8 @@
 	 */
 	if (count > LATCH) {
 		outb_p(0x34, PIT_MODE);
-		outb_p(LATCH & 0xff, PIT_CH0);
-		outb(LATCH >> 8, PIT_CH0);
+		outb_p((LATCH * timer_mult) & 0xff, PIT_CH0);
+		outb((LATCH * timer_mult) >> 8, PIT_CH0);
 		count = LATCH - 1;
 	}
 	spin_unlock(&i8253_lock);
diff -Naur linux-2.6.12.3/arch/i386/kernel/timers/timer_pit.c linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12.3/arch/i386/kernel/timers/timer_pit.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_pit.c	2005-07-26 22:51:06.000000000 +0200
@@ -21,6 +21,12 @@
 #include "do_timer.h"
 #include "io_ports.h"
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+extern u16 timer_mult;
+
 static int count_p; /* counter in get_offset_pit() */
 
 static int __init init_pit(char* override)
@@ -117,8 +123,8 @@
         /* VIA686a test code... reset the latch if count > max + 1 */
         if (count > LATCH) {
                 outb_p(0x34, PIT_MODE);
-                outb_p(LATCH & 0xff, PIT_CH0);
-                outb(LATCH >> 8, PIT_CH0);
+                outb_p((LATCH * timer_mult) & 0xff, PIT_CH0);
+                outb((LATCH * timer_mult) >> 8, PIT_CH0);
                 count = LATCH - 1;
         }
 	
@@ -172,9 +178,9 @@
 	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
-	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+	outb_p((LATCH * timer_mult) & 0xff , PIT_CH0);	/* LSB */
 	udelay(10);
-	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	outb((LATCH * timer_mult) >> 8 , PIT_CH0);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
diff -Naur linux-2.6.12.3/arch/i386/kernel/timers/timer_pm.c linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.12.3/arch/i386/kernel/timers/timer_pm.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_pm.c	2005-07-26 21:29:36.000000000 +0200
@@ -35,6 +35,11 @@
  * in arch/i386/acpi/boot.c */
 u32 pmtmr_ioport = 0;
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+extern u16 timer_mult;
 
 /* value of the Power timer at last timer interrupt */
 static u32 offset_tick;
@@ -70,7 +75,7 @@
  * Some boards have the PMTMR running way too fast. We check
  * the PMTMR rate against PIT channel 2 to catch these cases.
  */
-static int verify_pmtmr_rate(void)
+static int verify_pmtmr_rate(char* override)
 {
 	u32 value1, value2;
 	unsigned long count, delta;
@@ -81,6 +86,16 @@
 	value2 = read_pmtmr();
 	delta = (value2 - value1) & ACPI_PM_MASK;
 
+	/* Assume PM timer is right if the user has specified an override clock */
+	if (override[0]) {
+		timer_mult = (1 + (PMTMR_EXPECTED_RATE << 1) / delta) >> 1;
+
+		if (!timer_mult)
+			timer_mult = 1;
+
+		if (timer_mult != 1)
+			printk(KERN_INFO "PM-Timer running at invalid rate, setting multiplier to %d\n",  timer_mult);
+	} else
 	/* Check that the PMTMR delta is within 5% of what we expect */
 	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
 	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
@@ -124,7 +139,7 @@
 	return -ENODEV;
 
 pm_good:
-	if (verify_pmtmr_rate() != 0)
+	if (verify_pmtmr_rate(override) != 0)
 		return -ENODEV;
 
 	init_cpu_khz();
diff -Naur linux-2.6.12.3/arch/i386/kernel/timers/timer_tsc.c linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12.3/arch/i386/kernel/timers/timer_tsc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/i386/kernel/timers/timer_tsc.c	2005-07-26 22:52:38.000000000 +0200
@@ -25,6 +25,12 @@
 
 #include <asm/hpet.h>
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+extern u16 timer_mult;
+
 #ifdef CONFIG_HPET_TIMER
 static unsigned long hpet_usec_quotient;
 static unsigned long hpet_last;
@@ -380,8 +386,8 @@
 	 */
 	if (count > LATCH) {
 		outb_p(0x34, PIT_MODE);
-		outb_p(LATCH & 0xff, PIT_CH0);
-		outb(LATCH >> 8, PIT_CH0);
+		outb_p((LATCH * timer_mult) & 0xff, PIT_CH0);
+		outb((LATCH * timer_mult) >> 8, PIT_CH0);
 		count = LATCH - 1;
 	}
 
diff -Naur linux-2.6.12.3/arch/x86_64/kernel/i8259.c linux-2.6.12.3-pmtimer/arch/x86_64/kernel/i8259.c
--- linux-2.6.12.3/arch/x86_64/kernel/i8259.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/x86_64/kernel/i8259.c	2005-07-25 01:48:08.000000000 +0200
@@ -38,6 +38,8 @@
  * interrupt-controller happy.
  */
 
+extern u32 timer_mult;
+
 #define BI(x,y) \
 	BUILD_IRQ(x##y)
 
@@ -483,9 +485,9 @@
 {
 	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
-	outb_p(LATCH & 0xff , 0x40);	/* LSB */
+	outb_p((LATCH * timer_mult) & 0xff , 0x40);	/* LSB */
 	udelay(10);
-	outb(LATCH >> 8 , 0x40);	/* MSB */
+	outb((LATCH * timer_mult) >> 8 , 0x40);	/* MSB */
 }
 
 static int timer_resume(struct sys_device *dev)
diff -Naur linux-2.6.12.3/arch/x86_64/kernel/pmtimer.c linux-2.6.12.3-pmtimer/arch/x86_64/kernel/pmtimer.c
--- linux-2.6.12.3/arch/x86_64/kernel/pmtimer.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/x86_64/kernel/pmtimer.c	2005-07-26 22:05:46.000000000 +0200
@@ -29,12 +29,82 @@
  * in arch/i386/kernel/acpi/boot.c */
 u32 pmtmr_ioport;
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+extern u16 timer_mult;
+
 /* value of the Power timer at last timer interrupt */
 static u32 offset_delay;
 static u32 last_pmtmr_tick;
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
+#define PMTMR_TICKS_PER_SEC 3579545
+#define PMTMR_EXPECTED_RATE \
+  ((LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
+
+/*helper function to safely read acpi pm timesource*/
+static inline u32 read_pmtmr(void)
+{
+	u32 v1=0,v2=0,v3=0;
+	/* It has been reported that because of various broken
+	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
+	 * source is not latched, so you must read it multiple
+	 * times to insure a safe value is read.
+	 */
+	do {
+		v1 = inl(pmtmr_ioport);
+		v2 = inl(pmtmr_ioport);
+		v3 = inl(pmtmr_ioport);
+	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
+			|| (v3 > v1 && v3 < v2));
+
+	/* mask the output to 24 bits */
+	return v2 & ACPI_PM_MASK;
+}
+
+int verify_pmtmr_rate(int override)
+{
+	u32 value1, value2;
+	unsigned long delta;
+	unsigned long count = 0;
+
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+	outb(0xb0, 0x43);
+	outb_p(LATCH & 0xff, 0x42);
+	outb_p(LATCH >> 8, 0x42);
+
+	value1 = read_pmtmr();
+
+	do {
+		count++;
+	} while ((inb_p(0x61) & 0x20) == 0);
+
+	value2 = read_pmtmr();
+	delta = (value2 - value1) & ACPI_PM_MASK;
+
+	if (override) {
+		timer_mult = (1 + (PMTMR_EXPECTED_RATE << 1) / delta) >> 1;
+
+		if (!timer_mult)
+			timer_mult = 1;
+
+		if (timer_mult != 1)
+			printk(KERN_INFO "PM-Timer running at invalid rate, setting multiplier to %d\n",  timer_mult);
+	} else
+	/* Check that the PMTMR delta is within 5% of what we expect */
+	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
+	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
+		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
+		return -1;
+	}
+
+	return 0;
+}
+
+
 static inline u32 cyc2us(u32 cycles)
 {
 	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
diff -Naur linux-2.6.12.3/arch/x86_64/kernel/time.c linux-2.6.12.3-pmtimer/arch/x86_64/kernel/time.c
--- linux-2.6.12.3/arch/x86_64/kernel/time.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/arch/x86_64/kernel/time.c	2005-07-26 22:05:12.000000000 +0200
@@ -47,6 +47,12 @@
 
 EXPORT_SYMBOL(jiffies_64);
 
+/* 
+ * timer_mult is a mutiplier used to work arround some very buggy BIOS
+ * or hardware where the PIT/TSC timer runs n times too fast.
+ */
+u16 timer_mult = 1;
+
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
 #endif
@@ -58,6 +64,7 @@
 
 static int nohpet __initdata = 0;
 static int notsc __initdata = 0;
+static int pmtimer __initdata = 0;
 
 #undef HPET_HACK_ENABLE_DANGEROUS
 
@@ -722,6 +729,11 @@
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
 	outb(0xb0, 0x43);
+
+	/* 
+	 * (PIT_TICK_RATE / (1000 / 50)) is 59659,
+	 *  so we can't use the timer_mult here.
+	 */
 	outb((PIT_TICK_RATE / (1000 / 50)) & 0xff, 0x42);
 	outb((PIT_TICK_RATE / (1000 / 50)) >> 8, 0x42);
 	rdtscll(start);
@@ -732,7 +744,11 @@
 
 	spin_unlock_irqrestore(&i8253_lock, flags);
 	
-	return (end - start) / 50;
+	/* 
+	 * It's safer to use timer_mult on the
+	 * computed value.
+	 */
+	return timer_mult * (end - start) / 50;
 }
 
 #ifdef	CONFIG_HPET
@@ -859,8 +875,8 @@
 
 	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34, 0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
-	outb_p(LATCH & 0xff, 0x40);	/* LSB */
-	outb_p(LATCH >> 8, 0x40);	/* MSB */
+	outb_p((LATCH * timer_mult) & 0xff, 0x40);	/* LSB */
+	outb_p((LATCH * timer_mult) >> 8, 0x40);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
@@ -901,13 +917,13 @@
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (!hpet_init()) {
+	if (!hpet_init() && !pmtimer) {
                 vxtime_hz = (1000000000000000L + hpet_period / 2) /
 			hpet_period;
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 #ifdef CONFIG_X86_PM_TIMER
-	} else if (pmtmr_ioport) {
+	} else if ((pmtmr_ioport) && verify_pmtmr_rate(pmtimer)) {
 		vxtime_hz = PM_TIMER_FREQUENCY;
 		timename = "PM";
 		pit_init();
@@ -1297,4 +1313,13 @@
 
 __setup("notsc", notsc_setup);
 
+static int __init pmtimer_setup(char *s)
+{
+	pmtimer = 1;
+	return 0;
+}
+
+__setup("pmtmr", pmtimer_setup);
+
+
 
diff -Naur linux-2.6.12.3/Documentation/kernel-parameters.txt linux-2.6.12.3-pmtimer/Documentation/kernel-parameters.txt
--- linux-2.6.12.3/Documentation/kernel-parameters.txt	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/Documentation/kernel-parameters.txt	2005-07-26 22:24:35.000000000 +0200
@@ -312,7 +312,11 @@
  	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. 
 			Forces specified timesource (if avaliable) to be used
 			when calculating gettimeofday(). If specicified timesource
-			is not avalible, it defaults to PIT. 
+			is not avalible, it defaults to PIT.
+			When timesource is set to pmtmr manually, the PM timer is
+			assumed to be a reliable time source and the PIT/TSC is
+			adjusted accordingly. This can work around some very buggy 
+			BIOS or hardware where the PIT/TSC timer runs N times too fast.
 			Format: { pit | tsc | cyclone | pmtmr }
 
 	hpet=		[IA-32,HPET] option to disable HPET and use PIT.
diff -Naur linux-2.6.12.3/Documentation/x86_64/boot-options.txt linux-2.6.12.3-pmtimer/Documentation/x86_64/boot-options.txt
--- linux-2.6.12.3/Documentation/x86_64/boot-options.txt	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/Documentation/x86_64/boot-options.txt	2005-07-26 22:24:13.000000000 +0200
@@ -49,6 +49,12 @@
   This can be used to work around timing problems on multiprocessor systems
   with not properly synchronized CPUs. Only useful with a SMP kernel
 
+
+  pmtmr
+  Assume the PM timer is a reliable time source and adjust the PIT/TSC accordingly.
+  This can work around some very buggy BIOS or hardware where the PIT/TSC timer
+  runs N times too fast.
+
   report_lost_ticks
   Report when timer interrupts are lost because some code turned off
   interrupts for too long.
diff -Naur linux-2.6.12.3/include/asm-x86_64/proto.h linux-2.6.12.3-pmtimer/include/asm-x86_64/proto.h
--- linux-2.6.12.3/include/asm-x86_64/proto.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12.3-pmtimer/include/asm-x86_64/proto.h	2005-07-26 22:03:16.000000000 +0200
@@ -32,6 +32,7 @@
 extern void time_init_gtod(void);
 extern int pmtimer_mark_offset(void);
 extern unsigned int do_gettimeoffset_pm(void);
+extern int verify_pmtmr_rate(int);
 extern u32 pmtmr_ioport;
 extern unsigned long long monotonic_base;
 extern int sysctl_vsyscall;

--=-o6fye+2/SA/Op/iZmTa3--



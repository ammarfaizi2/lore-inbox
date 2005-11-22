Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVKVBhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVKVBhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVKVBg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:36:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:12187 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964832AbVKVBgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:36:38 -0500
Date: Mon, 21 Nov 2005 18:36:35 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051122013635.18537.3747.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 12/13] Time: i386/x86-64 Clocksource Drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch implements the time sources shared between i386 and x86-64
(acpi_pm, cyclone, hpet, pit, tsc and tsc-interp). The patch should
apply on top of the timeofday-arch-i386-part4 patch as well as the
arch-x86-64 patch
	
	The patch should be fairly straight forward, only adding the new
clocksources.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.15-rc1-mm2_timeofday-clocks-i386_B11.patch
============================================
diff -ruN tod-mm_1/arch/i386/kernel/hpet.c tod-mm_2/arch/i386/kernel/hpet.c
--- tod-mm_1/arch/i386/kernel/hpet.c	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/hpet.c	2005-11-21 16:53:50.000000000 -0800
@@ -0,0 +1,66 @@
+#include <linux/clocksource.h>
+#include <linux/hpet.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/hpet.h>
+
+#define HPET_MASK (0xFFFFFFFF)
+#define HPET_SHIFT 22
+
+/* FSEC = 10^-15 NSEC = 10^-9 */
+#define FSEC_PER_NSEC 1000000
+
+static void *hpet_ptr;
+
+static cycle_t read_hpet(void)
+{
+	return (cycle_t)readl(hpet_ptr);
+}
+
+struct clocksource clocksource_hpet = {
+	.name = "hpet",
+	.rating = 250,
+	.read = read_hpet,
+	.mask = (cycle_t)HPET_MASK,
+	.mult = 0, /* set below */
+	.shift = HPET_SHIFT,
+	.is_continuous = 1,
+};
+
+static int __init init_hpet_clocksource(void)
+{
+	unsigned long hpet_period;
+	void __iomem* hpet_base;
+	u64 tmp;
+
+	if (!hpet_address)
+		return -ENODEV;
+
+	/* calculate the hpet address */
+	hpet_base =
+		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
+	hpet_ptr = hpet_base + HPET_COUNTER;
+
+	/* calculate the frequency */
+	hpet_period = readl(hpet_base + HPET_PERIOD);
+
+
+	/* hpet period is in femto seconds per cycle
+	 * so we need to convert this to ns/cyc units
+	 * aproximated by mult/2^shift
+	 *
+	 *  fsec/cyc * 1nsec/1000000fsec = nsec/cyc = mult/2^shift
+	 *  fsec/cyc * 1ns/1000000fsec * 2^shift = mult
+	 *  fsec/cyc * 2^shift * 1nsec/1000000fsec = mult
+	 *  (fsec/cyc << shift)/1000000 = mult
+	 *  (hpet_period << shift)/FSEC_PER_NSEC = mult
+	 */
+	tmp = (u64)hpet_period << HPET_SHIFT;
+	do_div(tmp, FSEC_PER_NSEC);
+	clocksource_hpet.mult = (u32)tmp;
+
+	register_clocksource(&clocksource_hpet);
+	return 0;
+}
+module_init(init_hpet_clocksource);
diff -ruN tod-mm_1/arch/i386/kernel/i8253.c tod-mm_2/arch/i386/kernel/i8253.c
--- tod-mm_1/arch/i386/kernel/i8253.c	2005-11-21 16:50:17.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/i8253.c	2005-11-21 16:53:50.000000000 -0800
@@ -6,6 +6,7 @@
 #include <linux/jiffies.h>
 #include <linux/spinlock.h>
 #include <linux/sysdev.h>
+#include <linux/clocksource.h>
 #include <linux/module.h>
 
 #include <asm/delay.h>
@@ -55,3 +56,60 @@
 }
 
 device_initcall(init_timer_sysfs);
+
+
+/* Since the PIT overflows every tick, its not very useful
+ * to just read by itself. So use jiffies to emulate a free
+ * running counter.
+ */
+
+static cycle_t pit_read(void)
+{
+	unsigned long flags, seq;
+	int count;
+	u64 jifs;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+
+		spin_lock_irqsave(&i8253_lock, flags);
+		outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
+		count = inb_p(PIT_CH0);	/* read the latched count */
+		count |= inb_p(PIT_CH0) << 8;
+
+		/* VIA686a test code... reset the latch if count > max + 1 */
+		if (count > LATCH) {
+			outb_p(0x34, PIT_MODE);
+			outb_p(LATCH & 0xff, PIT_CH0);
+			outb(LATCH >> 8, PIT_CH0);
+			count = LATCH - 1;
+		}
+		spin_unlock_irqrestore(&i8253_lock, flags);
+		jifs = jiffies_64;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	jifs -= INITIAL_JIFFIES;
+	count = (LATCH-1) - count;
+
+	return (cycle_t)(jifs * LATCH) + count;
+}
+
+static struct clocksource clocksource_pit = {
+	.name = "pit",
+	.rating = 110,
+	.read = pit_read,
+	.mask = (cycle_t)-1,
+	.mult = 0,
+	.shift = 20,
+};
+
+static int __init init_pit_clocksource(void)
+{
+	if (num_possible_cpus() > 4) /* PIT does not scale! */
+		return 0;
+
+	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
+	register_clocksource(&clocksource_pit);
+	return 0;
+}
+module_init(init_pit_clocksource);
diff -ruN tod-mm_1/arch/i386/kernel/Makefile tod-mm_2/arch/i386/kernel/Makefile
--- tod-mm_1/arch/i386/kernel/Makefile	2005-11-21 16:52:49.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/Makefile	2005-11-21 16:53:50.000000000 -0800
@@ -36,6 +36,7 @@
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -ruN tod-mm_1/arch/i386/kernel/tsc.c tod-mm_2/arch/i386/kernel/tsc.c
--- tod-mm_1/arch/i386/kernel/tsc.c	2005-11-21 16:52:49.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/tsc.c	2005-11-21 16:53:50.000000000 -0800
@@ -306,3 +306,97 @@
 core_initcall(cpufreq_tsc);
 
 #endif
+
+/* Clock source code */
+#include <linux/clocksource.h>
+
+static unsigned long current_tsc_khz = 0;
+static int tsc_update_callback(void);
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret;
+}
+
+static cycle_t read_tsc_c3(void)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret + tsc_read_c3_time();
+}
+
+
+static struct clocksource clocksource_tsc = {
+	.name = "tsc",
+	.rating = 300,
+	.read = read_tsc,
+	.mask = (cycle_t)-1,
+	.mult = 0, /* to be set */
+	.shift = 22,
+	.update_callback = tsc_update_callback,
+	.is_continuous = 1,
+};
+
+static int tsc_update_callback(void)
+{
+	int change = 0;
+	/* check to see if we should switch to the safe clocksource */
+	if (tsc_read_c3_time() &&
+		strncmp(clocksource_tsc.name, "c3tsc", 5)) {
+		printk("Falling back to C3 safe TSC\n");
+		clocksource_tsc.read = read_tsc_c3;
+		clocksource_tsc.name = "c3tsc";
+		change = 1;
+	}
+
+	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
+		clocksource_tsc.rating = 50;
+		reselect_clocksource();
+		change = 1;
+	}
+	/* only update if tsc_khz has changed */
+	if (current_tsc_khz != tsc_khz){
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		change = 1;
+	}
+	return change;
+}
+
+/*
+ * Make an educated guess if the TSC is trustworthy and synchronized
+ * over all CPUs.
+ */
+static __init int unsynchronized_tsc(void)
+{
+	/* Intel systems are normally all synchronized.
+	 * Exceptions must mark TSC as unstable.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+ 		return 0;
+
+	/* Assume multi socket systems are not synchronized */
+ 	return num_possible_cpus() > 1;
+}
+
+#ifndef CONFIG_X86_NUMAQ /* NUMAQ can't use TSC */
+static int __init init_tsc_clocksource(void)
+{
+
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && tsc_khz) {
+		if (unsynchronized_tsc()) /* lower rating if unsynced */
+			clocksource_tsc.rating = 150;
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		register_clocksource(&clocksource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
+#endif
diff -ruN tod-mm_1/drivers/clocksource/acpi_pm.c tod-mm_2/drivers/clocksource/acpi_pm.c
--- tod-mm_1/drivers/clocksource/acpi_pm.c	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/drivers/clocksource/acpi_pm.c	2005-11-21 16:53:50.000000000 -0800
@@ -0,0 +1,152 @@
+/*
+ * linux/drivers/clocksource/acpi_pm.c
+ *
+ * This file contains the ACPI PM based clocksource.
+ *
+ * This code was largely moved from the i386 timer_pm.c file
+ * which was (C) Dominik Brodowski <linux@brodo.de> 2003
+ * and contained the following comments:
+ *
+ * Driver to use the Power Management Timer (PMTMR) available in some
+ * southbridges as primary timing source for the Linux kernel.
+ *
+ * Based on parts of linux/drivers/acpi/hardware/hwtimer.c, timer_pit.c,
+ * timer_hpet.c, and on Arjan van de Ven's implementation for 2.4.
+ *
+ * This file is licensed under the GPL v2.
+ */
+
+
+#include <linux/clocksource.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+/* Number of PMTMR ticks expected during calibration run */
+#define PMTMR_TICKS_PER_SEC 3579545
+
+#if (defined(CONFIG_X86) && (!defined(CONFIG_X86_64)))
+#include "mach_timer.h"
+#define PMTMR_EXPECTED_RATE ((PMTMR_TICKS_PER_SEC*CALIBRATE_TIME_MSEC)/1000)
+#endif
+
+/* The I/O port the PMTMR resides at.
+ * The location is detected during setup_arch(),
+ * in arch/i386/acpi/boot.c */
+extern u32 acpi_pmtmr_ioport;
+extern int acpi_pmtmr_buggy;
+
+#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
+
+
+static inline u32 read_pmtmr(void)
+{
+	/* mask the output to 24 bits */
+	return inl(acpi_pmtmr_ioport) & ACPI_PM_MASK;
+}
+
+static cycle_t acpi_pm_read_verified(void)
+{
+	u32 v1=0,v2=0,v3=0;
+	/* It has been reported that because of various broken
+	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM clock
+	 * source is not latched, so you must read it multiple
+	 * times to insure a safe value is read.
+	 */
+	do {
+		v1 = read_pmtmr();
+		v2 = read_pmtmr();
+		v3 = read_pmtmr();
+	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
+			|| (v3 > v1 && v3 < v2));
+
+	return (cycle_t)v2;
+}
+
+
+static cycle_t acpi_pm_read(void)
+{
+	return (cycle_t)read_pmtmr();
+}
+
+struct clocksource clocksource_acpi_pm = {
+	.name = "acpi_pm",
+	.rating = 200,
+	.read = acpi_pm_read,
+	.mask = (cycle_t)ACPI_PM_MASK,
+	.mult = 0, /*to be caluclated*/
+	.shift = 22,
+	.is_continuous = 1,
+};
+
+#if (defined(CONFIG_X86) && (!defined(CONFIG_X86_64)))
+/*
+ * Some boards have the PMTMR running way too fast. We check
+ * the PMTMR rate against PIT channel 2 to catch these cases.
+ */
+static int __init verify_pmtmr_rate(void)
+{
+	u32 value1, value2;
+	unsigned long count, delta;
+
+	mach_prepare_counter();
+	value1 = read_pmtmr();
+	mach_countup(&count);
+	value2 = read_pmtmr();
+	delta = (value2 - value1) & ACPI_PM_MASK;
+
+	/* Check that the PMTMR delta is within 5% of what we expect */
+	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
+	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
+		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
+		return -1;
+	}
+
+	return 0;
+}
+#else
+#define verify_pmtmr_rate() (0)
+#endif
+
+static int __init init_acpi_pm_clocksource(void)
+{
+	u32 value1, value2;
+	unsigned int i;
+
+	if (!acpi_pmtmr_ioport)
+		return -ENODEV;
+
+	clocksource_acpi_pm.mult = clocksource_hz2mult(PMTMR_TICKS_PER_SEC,
+									clocksource_acpi_pm.shift);
+
+	/* "verify" this timing source */
+	value1 = read_pmtmr();
+	for (i = 0; i < 10000; i++) {
+		value2 = read_pmtmr();
+		if (value2 == value1)
+			continue;
+		if (value2 > value1)
+			goto pm_good;
+		if ((value2 < value1) && ((value2) < 0xFFF))
+			goto pm_good;
+		printk(KERN_INFO "PM-Timer had inconsistent results: 0x%#x, 0x%#x - aborting.\n", value1, value2);
+		return -EINVAL;
+	}
+	printk(KERN_INFO "PM-Timer had no reasonable result: 0x%#x - aborting.\n", value1);
+	return -ENODEV;
+
+pm_good:
+	if (verify_pmtmr_rate() != 0)
+		return -ENODEV;
+
+	/* check to see if pmtmr is known buggy */
+	if (acpi_pmtmr_buggy) {
+		clocksource_acpi_pm.read = acpi_pm_read_verified;
+		clocksource_acpi_pm.rating = 110;
+	}
+
+	register_clocksource(&clocksource_acpi_pm);
+	return 0;
+}
+
+module_init(init_acpi_pm_clocksource);
diff -ruN tod-mm_1/drivers/clocksource/cyclone.c tod-mm_2/drivers/clocksource/cyclone.c
--- tod-mm_1/drivers/clocksource/cyclone.c	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/drivers/clocksource/cyclone.c	2005-11-21 16:53:50.000000000 -0800
@@ -0,0 +1,116 @@
+#include <linux/clocksource.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include "mach_timer.h"
+
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0		/* base address ptr*/
+#define CYCLONE_PMCC_OFFSET 0x51A0		/* offset to control register */
+#define CYCLONE_MPCS_OFFSET 0x51A8		/* offset to select register */
+#define CYCLONE_MPMC_OFFSET 0x51D0		/* offset to count register */
+#define CYCLONE_TIMER_FREQ 99780000		/* 100Mhz, but not really */
+#define CYCLONE_TIMER_MASK (0xFFFFFFFF) /* 32 bit mask */
+
+int use_cyclone = 0;
+static void __iomem *cyclone_ptr;
+
+static cycle_t read_cyclone(void)
+{
+	return (cycle_t)readl(cyclone_ptr);
+}
+
+struct clocksource clocksource_cyclone = {
+	.name = "cyclone",
+	.rating = 250,
+	.read = read_cyclone,
+	.mask = (cycle_t)CYCLONE_TIMER_MASK,
+	.mult = 10,
+	.shift = 0,
+	.is_continuous = 1,
+};
+
+static int __init init_cyclone_clocksource(void)
+{
+	unsigned long base;	/* saved value from CBAR */
+	unsigned long offset;
+	u32 __iomem* reg;
+	u32 __iomem* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+	int i;
+
+	/*make sure we're on a summit box*/
+	if (!use_cyclone) return -ENODEV;
+
+	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
+
+	/* find base address */
+	offset = CYCLONE_CBAR_ADDR;
+	reg = ioremap_nocache(offset, sizeof(reg));
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
+		return -ENODEV;
+	}
+	/* even on 64bit systems, this is only 32bits */
+	base = readl(reg);
+	if(!base){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
+		return -ENODEV;
+	}
+	iounmap(reg);
+
+	/* setup PMCC */
+	offset = base + CYCLONE_PMCC_OFFSET;
+	reg = ioremap_nocache(offset, sizeof(reg));
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
+		return -ENODEV;
+	}
+	writel(0x00000001,reg);
+	iounmap(reg);
+
+	/* setup MPCS */
+	offset = base + CYCLONE_MPCS_OFFSET;
+	reg = ioremap_nocache(offset, sizeof(reg));
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
+		return -ENODEV;
+	}
+	writel(0x00000001,reg);
+	iounmap(reg);
+
+	/* map in cyclone_timer */
+	offset = base + CYCLONE_MPMC_OFFSET;
+	cyclone_timer = ioremap_nocache(offset, sizeof(u64));
+	if(!cyclone_timer){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
+		return -ENODEV;
+	}
+
+	/*quick test to make sure its ticking*/
+	for(i=0; i<3; i++){
+		u32 old = readl(cyclone_timer);
+		int stall = 100;
+		while(stall--) barrier();
+		if(readl(cyclone_timer) == old){
+			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
+			iounmap(cyclone_timer);
+			cyclone_timer = NULL;
+			return -ENODEV;
+		}
+	}
+	cyclone_ptr = cyclone_timer;
+
+	/* sort out mult/shift values */
+	clocksource_cyclone.shift = 22;
+	clocksource_cyclone.mult = clocksource_hz2mult(CYCLONE_TIMER_FREQ,
+						clocksource_cyclone.shift);
+
+	register_clocksource(&clocksource_cyclone);
+
+	return 0;
+}
+
+module_init(init_cyclone_clocksource);
diff -ruN tod-mm_1/drivers/clocksource/Makefile tod-mm_2/drivers/clocksource/Makefile
--- tod-mm_1/drivers/clocksource/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/drivers/clocksource/Makefile	2005-11-21 16:53:50.000000000 -0800
@@ -0,0 +1,3 @@
+#XXX doesn't boot! obj-$(CONFIG_X86) += tsc-interp.o
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
diff -ruN tod-mm_1/drivers/clocksource/tsc-interp.c tod-mm_2/drivers/clocksource/tsc-interp.c
--- tod-mm_1/drivers/clocksource/tsc-interp.c	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/drivers/clocksource/tsc-interp.c	2005-11-21 16:53:50.000000000 -0800
@@ -0,0 +1,112 @@
+/* TSC-Jiffies Interpolation clocksource
+	Example interpolation clocksource.
+TODO:
+	o per-cpu TSC offsets
+*/
+#include <linux/clocksource.h>
+#include <linux/timer.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/threads.h>
+#include <linux/smp.h>
+
+static unsigned long current_tsc_khz = 0;
+
+static seqlock_t tsc_interp_lock = SEQLOCK_UNLOCKED;
+static unsigned long tsc_then;
+static unsigned long jiffies_then;
+struct timer_list tsc_interp_timer;
+
+static unsigned long mult, shift;
+
+#define NSEC_PER_JIFFY ((((unsigned long long)NSEC_PER_SEC)<<8)/ACTHZ)
+#define SHIFT_VAL 22
+
+static cycle_t read_tsc_interp(void);
+static void tsc_interp_update_callback(void);
+
+static struct clocksource clocksource_tsc_interp = {
+	.name = "tsc-interp",
+	.rating = 150,
+	.type = CLOCKSOURCE_FUNCTION,
+	.read_fnct = read_tsc_interp,
+	.mask = (cycle_t)((1ULL<<32)-1),
+	.mult = 1<<SHIFT_VAL,
+	.shift = SHIFT_VAL,
+	.update_callback = tsc_interp_update_callback,
+};
+
+static void tsc_interp_sync(unsigned long unused)
+{
+	cycle_t tsc_now;
+	unsigned long jiffies_now;
+
+	do {
+		jiffies_now = jiffies;
+		rdtscll(tsc_now);
+	} while (jiffies_now != jiffies);
+
+	write_seqlock(&tsc_interp_lock);
+	jiffies_then = jiffies_now;
+	tsc_then = tsc_now;
+	write_sequnlock(&tsc_interp_lock);
+
+	mod_timer(&tsc_interp_timer, jiffies+1);
+}
+
+
+static cycle_t read_tsc_interp(void)
+{
+	cycle_t ret;
+	cycle_t now, then;
+	unsigned long jiffs_now, jiffs_then;
+	unsigned long seq;
+
+	do {
+		seq = read_seqbegin(&tsc_interp_lock);
+
+		jiffs_now = jiffies;
+		jiffs_then = jiffies_then;
+		then = tsc_then;
+
+	} while (read_seqretry(&tsc_interp_lock, seq));
+
+	rdtscll(now);
+	ret = (cycle_t)jiffs_then * NSEC_PER_JIFFY;
+	if (jiffs_then == jiffs_now)
+		ret += min((cycle_t)NSEC_PER_JIFFY,(cycle_t)((now - then)*mult)>> shift);
+	else
+		ret += (cycle_t)(jiffs_now - jiffs_then)*NSEC_PER_JIFFY;
+
+	return ret;
+}
+
+static void tsc_interp_update_callback(void)
+{
+	/* only update if tsc_khz has changed */
+	if (current_tsc_khz != tsc_khz){
+		current_tsc_khz = tsc_khz;
+		mult = clocksource_khz2mult(current_tsc_khz, shift);
+	}
+}
+
+
+static int __init init_tsc_interp_clocksource(void)
+{
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && tsc_khz) {
+		current_tsc_khz = tsc_khz;
+		shift = SHIFT_VAL;
+		mult = clocksource_khz2mult(current_tsc_khz, shift);
+		/* setup periodic soft-timer */
+		init_timer(&tsc_interp_timer);
+		tsc_interp_timer.function = tsc_interp_sync;
+		tsc_interp_timer.expires = jiffies;
+		add_timer(&tsc_interp_timer);
+
+		register_clocksource(&clocksource_tsc_interp);
+	}
+	return 0;
+}
+module_init(init_tsc_interp_clocksource);
diff -ruN tod-mm_1/drivers/Makefile tod-mm_2/drivers/Makefile
--- tod-mm_1/drivers/Makefile	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/drivers/Makefile	2005-11-21 16:53:50.000000000 -0800
@@ -71,3 +71,4 @@
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_GENERIC_TIME)	+= clocksource/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVJNCWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVJNCWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 22:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVJNCWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 22:22:52 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:60070 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932549AbVJNCWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 22:22:51 -0400
Subject: [RFC][PATCH 11/12] generic timeofday i386/x86-64 specific
	clocksources
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Frank Sorenson <frank@tuxrocks.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <1129256500.27168.48.camel@cog.beaverton.ibm.com>
References: <1129255182.27168.14.camel@cog.beaverton.ibm.com>
	 <1129255761.27168.26.camel@cog.beaverton.ibm.com>
	 <1129255831.27168.29.camel@cog.beaverton.ibm.com>
	 <1129255906.27168.32.camel@cog.beaverton.ibm.com>
	 <1129255977.27168.34.camel@cog.beaverton.ibm.com>
	 <1129256040.27168.35.camel@cog.beaverton.ibm.com>
	 <1129256131.27168.38.camel@cog.beaverton.ibm.com>
	 <1129256216.27168.41.camel@cog.beaverton.ibm.com>
	 <1129256381.27168.44.camel@cog.beaverton.ibm.com>
	 <1129256445.27168.46.camel@cog.beaverton.ibm.com>
	 <1129256500.27168.48.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 19:22:47 -0700
Message-Id: <1129256567.27168.51.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch implements the time sources shared between i386 and x86-64
(acpi_pm, cyclone, hpet, pit, tsc and tsc-interp). The patch should
apply on top of the timeofday-arch-i386-part6 patch.
	
	The patch should be fairly straight forward, only adding the new
clocksources.

thanks
-john

 Makefile     |    7 ++
 acpi_pm.c    |  152 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cyclone.c    |  138 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 hpet.c       |   59 ++++++++++++++++++++++
 i386_pit.c   |   63 ++++++++++++++++++++++++
 tsc-interp.c |  112 +++++++++++++++++++++++++++++++++++++++++++
 tsc.c        |   79 ++++++++++++++++++++++++++++++
 7 files changed, 610 insertions(+)

linux-2.6.14-rc4_timeofday-clocks-i386_B7.patch
============================================
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1 +1,8 @@
 obj-y += jiffies.o
+
+obj-$(CONFIG_X86) += tsc.o
+obj-$(CONFIG_X86) += i386_pit.o
+#XXX doesn't boot! obj-$(CONFIG_X86) += tsc-interp.o
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_HPET_TIMER) += hpet.o
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/acpi_pm.c
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
+	.type = CLOCKSOURCE_FUNCTION,
+	.read_fnct = acpi_pm_read,
+	.mask = (cycle_t)ACPI_PM_MASK,
+	.mult = 0, /*to be caluclated*/
+	.shift = 22,
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
+		clocksource_acpi_pm.read_fnct = acpi_pm_read_verified;
+		clocksource_acpi_pm.rating = 110;
+	}
+
+	register_clocksource(&clocksource_acpi_pm);
+	return 0;
+}
+
+module_init(init_acpi_pm_clocksource);
diff --git a/drivers/clocksource/cyclone.c b/drivers/clocksource/cyclone.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/cyclone.c
@@ -0,0 +1,138 @@
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
+#define CYCLONE_TIMER_FREQ 100000000
+#define CYCLONE_TIMER_MASK (0xFFFFFFFF) /* 32 bit mask */
+
+int use_cyclone = 0;
+
+struct clocksource clocksource_cyclone = {
+	.name = "cyclone",
+	.rating = 250,
+	.type = CLOCKSOURCE_MMIO_32,
+	.mmio_ptr = NULL, /* to be set */
+	.mask = (cycle_t)CYCLONE_TIMER_MASK,
+	.mult = 10,
+	.shift = 0,
+};
+
+static unsigned long __init calibrate_cyclone(void)
+{
+	u64 delta64;
+	unsigned long start, end;
+	unsigned long i, count;
+	unsigned long cyclone_freq_khz;
+
+	/* repeat 3 times to make sure the cache is warm */
+	for(i=0; i < 3; i++) {
+		mach_prepare_counter();
+		start = readl(clocksource_cyclone.mmio_ptr);
+		mach_countup(&count);
+		end = readl(clocksource_cyclone.mmio_ptr);
+	}
+
+	delta64 = end - start;
+
+	delta64 += CALIBRATE_TIME_MSEC/2; /* round for do_div */
+	do_div(delta64,CALIBRATE_TIME_MSEC);
+
+	cyclone_freq_khz = (unsigned long)delta64;
+
+	printk("calculated cyclone_freq: %lu khz\n", cyclone_freq_khz);
+	return cyclone_freq_khz;
+}
+
+static int __init init_cyclone_clocksource(void)
+{
+	unsigned long base;	/* saved value from CBAR */
+	unsigned long offset;
+	u32 __iomem* reg;
+	u32 __iomem* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+	unsigned long khz;
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
+	clocksource_cyclone.mmio_ptr = cyclone_timer;
+
+	/* sort out mult/shift values */
+	khz = calibrate_cyclone();
+	clocksource_cyclone.shift = 22;
+	clocksource_cyclone.mult = clocksource_khz2mult(khz,
+									clocksource_cyclone.shift);
+
+	register_clocksource(&clocksource_cyclone);
+
+	return 0;
+}
+
+module_init(init_cyclone_clocksource);
diff --git a/drivers/clocksource/hpet.c b/drivers/clocksource/hpet.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/hpet.c
@@ -0,0 +1,59 @@
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
+struct clocksource clocksource_hpet = {
+	.name = "hpet",
+	.rating = 250,
+	.type = CLOCKSOURCE_MMIO_32,
+	.mmio_ptr = NULL,
+	.mask = (cycle_t)HPET_MASK,
+	.mult = 0, /* set below */
+	.shift = HPET_SHIFT,
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
+	clocksource_hpet.mmio_ptr = hpet_base + HPET_COUNTER;
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
diff --git a/drivers/clocksource/i386_pit.c b/drivers/clocksource/i386_pit.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/i386_pit.c
@@ -0,0 +1,63 @@
+#include <linux/clocksource.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+/* pit clocksource does not build on x86-64 */
+#ifndef CONFIG_X86_64
+#include <asm/io.h>
+#include <asm/i8253.h>
+#include "io_ports.h"
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
+
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
+		jifs = get_jiffies_64() - INITIAL_JIFFIES;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	count = (LATCH-1) - count;
+
+	return (cycle_t)(jifs * LATCH) + count;
+}
+
+static struct clocksource clocksource_pit = {
+	.name = "pit",
+	.rating = 110,
+	.type = CLOCKSOURCE_FUNCTION,
+	.read_fnct = pit_read,
+	.mask = (cycle_t)-1,
+	.mult = 0,
+	.shift = 20,
+};
+
+static int __init init_pit_clocksource(void)
+{
+	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
+	register_clocksource(&clocksource_pit);
+	return 0;
+}
+module_init(init_pit_clocksource);
+#endif
diff --git a/drivers/clocksource/tsc-interp.c b/drivers/clocksource/tsc-interp.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/tsc-interp.c
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
diff --git a/drivers/clocksource/tsc.c b/drivers/clocksource/tsc.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/tsc.c
@@ -0,0 +1,79 @@
+/* TODO:
+ *		o better calibration
+ */
+
+#include <linux/clocksource.h>
+#include <linux/string.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+static unsigned long current_tsc_khz = 0;
+
+static cycle_t read_safe_tsc(void);
+static int tsc_update_callback(void);
+
+
+static struct clocksource clocksource_raw_tsc = {
+	.name = "tsc",
+	.rating = 300,
+	.type = CLOCKSOURCE_CYCLES,
+	.mask = (cycle_t)-1,
+	.mult = 0, /* to be set */
+	.shift = 22,
+	.update_callback = tsc_update_callback,
+};
+
+static struct clocksource clocksource_tsc;
+
+static cycle_t read_safe_tsc(void)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret + tsc_read_c3_time();
+}
+
+static int tsc_update_callback(void)
+{
+	int change = 0;
+	/* check to see if we should switch to the safe clocksource */
+	if (tsc_read_c3_time() &&
+		strncmp(clocksource_tsc.name, "c3tsc", 5)) {
+		printk("Falling back to C3 safe TSC\n");
+		clocksource_tsc.read_fnct = read_safe_tsc;
+		clocksource_tsc.type = CLOCKSOURCE_FUNCTION;
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
+static int __init init_tsc_clocksource(void)
+{
+
+	clocksource_tsc = clocksource_raw_tsc;
+
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && tsc_khz) {
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		register_clocksource(&clocksource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
+



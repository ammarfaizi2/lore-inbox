Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVENAcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVENAcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVENAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:32:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20698 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262641AbVENAVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:21:08 -0400
Subject: [RFC][PATCH (4/7)] new timeofday i386 and x86-64 timesources (v A5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <1116029971.26454.7.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 17:20:58 -0700
Message-Id: <1116030058.26454.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements the time sources shared between i386 and x86-64
(acpi_pm, cyclone, hpet, pit, tsc and tsc-interp). The patch should
apply ontop of either linux-2.6.12-rc4_timeofday-arch-x86-64_A5.patch or
linux-2.6.12-rc4_timeofday-arch-i386_A5.patch.
	
	The patch should be fairly straight forward, only adding the new
timesources. 
	
	I intend to send this patch along with the timeofday-core and
timeofday-arch-i386 patches to Andrew at the end of this month for
testing in his tree. So please, if you have any complaints, suggestions,
or blocking issues, let me know.

New in this release:
o i386_pit timesource has been fixed and properly works now
o New code to handle TSC stalls on cpus that halt the TSC in C3 mode
o A new TSC/Jiffies interpolation example. 

This new tsc-interp timesource provides the same interpolated
timekeeping method as was used previously in the i386 arch specific time
code. This should also quiet fears about the TSC timesource not being
stable enough for embedded systems.

Items still on the TODO list:
o make acpi-pm and pit x86-64 compatible
o make cyclone ia64 generic 

I look forward to your comments and feedback.

thanks
-john

linux-2.6.12-rc4_timeofday-timesources-i386_A5.patch
====================================================
Index: drivers/acpi/processor_idle.c
===================================================================
--- 0feb50d39a18b8a58ac2894eeac9b2f24a3b4435/drivers/acpi/processor_idle.c  (mode:100644)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/acpi/processor_idle.c  (mode:100644)
@@ -162,6 +162,7 @@
 	return;
 }
 
+extern void tsc_c3_compensate(unsigned long usecs);
 
 static void acpi_processor_idle (void)
 {
@@ -309,6 +310,10 @@
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Enable bus master arbitration */
 		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
+
+		/* compensate for TSC pause */
+		tsc_c3_compensate(((t2-t1)*286)>>10);
+
 		/* Re-enable interrupts */
 		local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
Index: drivers/timesource/Makefile
===================================================================
--- 0feb50d39a18b8a58ac2894eeac9b2f24a3b4435/drivers/timesource/Makefile  (mode:100644)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/Makefile  (mode:100644)
@@ -1 +1,7 @@
 obj-y += jiffies.o
+obj-$(CONFIG_X86) += tsc.o
+obj-$(CONFIG_X86) += i386_pit.o
+obj-$(CONFIG_X86) += tsc-interp.o
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_HPET_TIMER) += hpet.o
Index: drivers/timesource/acpi_pm.c
===================================================================
--- /dev/null  (tree:0feb50d39a18b8a58ac2894eeac9b2f24a3b4435)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/acpi_pm.c  (mode:100644)
@@ -0,0 +1,135 @@
+/*
+ * linux/drivers/timesource/acpi_pm.c
+ *
+ * This file contains the ACPI PM based time source.
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
+#include <linux/timesource.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include "mach_timer.h"
+
+/* Number of PMTMR ticks expected during calibration run */
+#define PMTMR_TICKS_PER_SEC 3579545
+#define PMTMR_EXPECTED_RATE \
+  ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
+
+
+/* The I/O port the PMTMR resides at.
+ * The location is detected during setup_arch(),
+ * in arch/i386/acpi/boot.c */
+u32 pmtmr_ioport = 0;
+
+#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
+
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
+
+static cycle_t acpi_pm_read(void)
+{
+	return (cycle_t)read_pmtmr();
+}
+
+struct timesource_t timesource_acpi_pm = {
+	.name = "acpi_pm",
+	.priority = 200,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = acpi_pm_read,
+	.mask = (cycle_t)ACPI_PM_MASK,
+	.mult = 0, /*to be caluclated*/
+	.shift = 22,
+};
+
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
+
+
+static int __init init_acpi_pm_timesource(void)
+{
+	u32 value1, value2;
+	unsigned int i;
+
+	if (!pmtmr_ioport)
+		return -ENODEV;
+
+	timesource_acpi_pm.mult = timesource_hz2mult(PMTMR_TICKS_PER_SEC,
+									timesource_acpi_pm.shift);
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
+	register_timesource(&timesource_acpi_pm);
+	return 0;
+}
+
+module_init(init_acpi_pm_timesource);
Index: drivers/timesource/cyclone.c
===================================================================
--- /dev/null  (tree:0feb50d39a18b8a58ac2894eeac9b2f24a3b4435)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/cyclone.c  (mode:100644)
@@ -0,0 +1,135 @@
+#include <linux/timesource.h>
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
+struct timesource_t timesource_cyclone = {
+	.name = "cyclone",
+	.priority = 100,
+	.type = TIMESOURCE_MMIO_32,
+	.mmio_ptr = NULL, /* to be set */
+	.mask = (cycle_t)CYCLONE_TIMER_MASK,
+	.mult = 10,
+	.shift = 0,
+};
+
+static unsigned long __init calibrate_cyclone(void)
+{
+	unsigned long start, end, delta;
+	unsigned long i, count;
+	unsigned long cyclone_freq_khz;
+
+	/* repeat 3 times to make sure the cache is warm */
+	for(i=0; i < 3; i++) {
+		mach_prepare_counter();
+		start = readl(timesource_cyclone.mmio_ptr);
+		mach_countup(&count);
+		end = readl(timesource_cyclone.mmio_ptr);
+	}
+
+	delta = end - start;
+	printk("cyclone delta: %lu\n", delta);
+	delta *= (ACTHZ/1000)>>8;
+	printk("delta*hz = %lu\n", delta);
+	cyclone_freq_khz = delta/CALIBRATE_ITERATION;
+	printk("calculated cyclone_freq: %lu khz\n", cyclone_freq_khz);
+	return cyclone_freq_khz;
+}
+
+static int __init init_cyclone_timesource(void)
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
+	timesource_cyclone.mmio_ptr = cyclone_timer;
+
+	/* sort out mult/shift values */
+	khz = calibrate_cyclone();
+	timesource_cyclone.shift = 22;
+	timesource_cyclone.mult = timesource_khz2mult(khz,
+									timesource_cyclone.shift);
+
+	register_timesource(&timesource_cyclone);
+
+	return 0;
+}
+
+module_init(init_cyclone_timesource);
Index: drivers/timesource/hpet.c
===================================================================
--- /dev/null  (tree:0feb50d39a18b8a58ac2894eeac9b2f24a3b4435)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/hpet.c  (mode:100644)
@@ -0,0 +1,59 @@
+#include <linux/timesource.h>
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
+struct timesource_t timesource_hpet = {
+	.name = "hpet",
+	.priority = 300,
+	.type = TIMESOURCE_MMIO_32,
+	.mmio_ptr = NULL,
+	.mask = (cycle_t)HPET_MASK,
+	.mult = 0, /* set below */
+	.shift = HPET_SHIFT,
+};
+
+static int __init init_hpet_timesource(void)
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
+	timesource_hpet.mmio_ptr = hpet_base + HPET_COUNTER;
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
+	timesource_hpet.mult = (u32)tmp;
+
+	register_timesource(&timesource_hpet);
+	return 0;
+}
+module_init(init_hpet_timesource);
Index: drivers/timesource/i386_pit.c
===================================================================
--- /dev/null  (tree:0feb50d39a18b8a58ac2894eeac9b2f24a3b4435)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/i386_pit.c  (mode:100644)
@@ -0,0 +1,64 @@
+#include <linux/timesource.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+/* pit timesource does not build on x86-64 */
+#ifndef CONFIG_X86_64
+#include <asm/io.h>
+#include "io_ports.h"
+
+extern spinlock_t i8253_lock;
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
+		jifs = get_jiffies_64();
+	} while (read_seqretry(&xtime_lock, seq));
+
+	count = (LATCH-1) - count;
+
+	return (cycle_t)(jifs * LATCH) + count;
+}
+
+static struct timesource_t timesource_pit = {
+	.name = "pit",
+	.priority = 0,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = pit_read,
+	.mask = (cycle_t)-1,
+	.mult = 0,
+	.shift = 20,
+};
+
+static int __init init_pit_timesource(void)
+{
+	timesource_pit.mult = timesource_hz2mult(CLOCK_TICK_RATE, 20);
+	register_timesource(&timesource_pit);
+	return 0;
+}
+module_init(init_pit_timesource);
+#endif
Index: drivers/timesource/tsc-interp.c
===================================================================
--- /dev/null  (tree:0feb50d39a18b8a58ac2894eeac9b2f24a3b4435)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/tsc-interp.c  (mode:100644)
@@ -0,0 +1,108 @@
+/* TSC-Jiffies Interpolation timesource
+	Example interpolation timesource.
+TODO:
+	o per-cpu TSC offsets
+*/
+#include <linux/timesource.h>
+#include <linux/timer.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/threads.h>
+#include <linux/smp.h>
+
+static unsigned long current_cpu_khz = 0;
+
+static seqlock_t tsc_interp_lock = SEQLOCK_UNLOCKED;
+static cycle_t tsc_then;
+static cycle_t jiffies_then;
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
+static struct timesource_t timesource_tsc_interp = {
+	.name = "tsc-interp",
+	.priority = 20,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = read_tsc_interp,
+	.mask = (cycle_t)-1,
+	.mult = 1<<SHIFT_VAL,
+	.shift = SHIFT_VAL,
+	.update_callback = tsc_interp_update_callback,
+};
+
+static void tsc_interp_sync(unsigned long unused)
+{
+	cycle_t tsc_now;
+	u64 jiffies_now;
+
+	do {
+		jiffies_now = get_jiffies_64();
+		rdtscll(tsc_now);
+	} while (jiffies_now != get_jiffies_64());
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
+	u64 jiffs;
+	unsigned long seq;
+
+	do {
+		seq = read_seqbegin(&tsc_interp_lock);
+
+		jiffs = jiffies_then;
+		then = tsc_then;
+
+	} while (read_seqretry(&tsc_interp_lock, seq));
+
+	rdtscll(now);
+	ret = jiffs * NSEC_PER_JIFFY;
+	ret += min((cycle_t)NSEC_PER_JIFFY,(cycle_t)((now - then)*mult)>> shift);
+
+	return ret;
+}
+
+static void tsc_interp_update_callback(void)
+{
+	/* only update if cpu_khz has changed */
+	if (current_cpu_khz != cpu_khz){
+		current_cpu_khz = cpu_khz;
+		mult = timesource_khz2mult(current_cpu_khz, shift);
+	}
+}
+
+
+static int __init init_tsc_interp_timesource(void)
+{
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && cpu_khz) {
+		current_cpu_khz = cpu_khz;
+		shift = SHIFT_VAL;
+		mult = timesource_khz2mult(current_cpu_khz, shift);
+		/* setup periodic soft-timer */
+		init_timer(&tsc_interp_timer);
+		tsc_interp_timer.function = tsc_interp_sync;
+		tsc_interp_timer.expires = jiffies;
+		add_timer(&tsc_interp_timer);
+
+		register_timesource(&timesource_tsc_interp);
+	}
+	return 0;
+}
+module_init(init_tsc_interp_timesource);
Index: drivers/timesource/tsc.c
===================================================================
--- /dev/null  (tree:0feb50d39a18b8a58ac2894eeac9b2f24a3b4435)
+++ 3b4165efeade40b65ea2e8188184e4f8d3d8d636/drivers/timesource/tsc.c  (mode:100644)
@@ -0,0 +1,95 @@
+/* TODO:
+ *		o better calibration
+ */
+
+#include <linux/timesource.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+static unsigned long current_cpu_khz = 0;
+static cycle_t tsc_c3_offset;
+
+static cycle_t read_safe_tsc(void);
+static void tsc_update_callback(void);
+
+static struct timesource_t timesource_safe_tsc = {
+	.name = "c3tsc",
+	.priority = 26,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = read_safe_tsc,
+	.mask = (cycle_t)-1,
+	.mult = 0, /* to be set */
+	.shift = 22,
+	.update_callback = tsc_update_callback,
+};
+
+static struct timesource_t timesource_raw_tsc = {
+	.name = "tsc",
+	.priority = 25,
+	.type = TIMESOURCE_CYCLES,
+	.mask = (cycle_t)-1,
+	.mult = 0, /* to be set */
+	.shift = 22,
+	.update_callback = tsc_update_callback,
+};
+
+static struct timesource_t timesource_tsc;
+
+static int use_safe_tsc = 0;
+
+static cycle_t read_safe_tsc(void)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret + tsc_c3_offset;
+}
+
+void tsc_c3_compensate(unsigned long usecs)
+{
+	u64 nsecs = (u64)usecs * 1000;
+	cycle_t offset = nsecs << timesource_tsc.shift;
+
+	if (!timesource_tsc.mult)
+		return;
+
+	if(!use_safe_tsc)
+		use_safe_tsc = 1;
+
+	do_div(offset, timesource_tsc.mult);
+	tsc_c3_offset += offset;
+}
+
+
+static void tsc_update_callback(void)
+{
+	/* check to see if we should switch to the safe timesource */
+	if (use_safe_tsc &&
+		strncmp(timesource_tsc.name, "c3tsc", 5)) {
+		printk("Falling back to C3 safe TSC\n");
+		timesource_safe_tsc.mult = timesource_tsc.mult;
+		timesource_tsc = timesource_safe_tsc;
+	}
+
+	/* only update if cpu_khz has changed */
+	if (current_cpu_khz != cpu_khz){
+		current_cpu_khz = cpu_khz;
+		timesource_tsc.mult = timesource_khz2mult(current_cpu_khz,
+							timesource_tsc.shift);
+	}
+}
+
+static int __init init_tsc_timesource(void)
+{
+	timesource_tsc = timesource_raw_tsc;
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && cpu_khz) {
+		current_cpu_khz = cpu_khz;
+		timesource_tsc.mult = timesource_khz2mult(current_cpu_khz,
+							timesource_tsc.shift);
+		register_timesource(&timesource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_timesource);
+



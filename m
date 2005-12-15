Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbVLOCCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVLOCCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVLOCCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:02:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:18352 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030296AbVLOCB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:01:28 -0500
Date: Wed, 14 Dec 2005 19:01:26 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, nikita@clusterfs.com,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051215020120.25589.4782.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
References: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 11/13] Time: i386/x86-64 Clocksource Drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch implements the time sources shared between i386 and 
x86-64 (acpi_pm, cyclone, hpet, pit, tsc and tsc-interp). The patch 
should apply on top of the timeofday-arch-i386-part4 patch as well as 
the arch-x86-64 patch
	
	The patch should be fairly straight forward, only adding the 
new clocksources.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/Makefile     |    1 
 arch/i386/kernel/hpet.c       |   69 +++++++++++++++++++++++
 arch/i386/kernel/i8253.c      |   60 ++++++++++++++++++++
 arch/i386/kernel/tsc.c        |   85 ++++++++++++++++++++++++++++-
 drivers/Makefile              |    1 
 drivers/clocksource/Makefile  |    2 
 drivers/clocksource/acpi_pm.c |  123 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/cyclone.c |  121 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 461 insertions(+), 1 deletion(-)

linux-2.6.15-rc5_timeofday-clocks-i386_B14.patch
============================================
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 5d1d9c9..984d488 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
 EXTRA_AFLAGS   := -traditional
 
diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
new file mode 100644
index 0000000..a620d15
--- /dev/null
+++ b/arch/i386/kernel/hpet.c
@@ -0,0 +1,69 @@
+#include <linux/clocksource.h>
+#include <linux/errno.h>
+#include <linux/hpet.h>
+#include <linux/init.h>
+
+#include <asm/hpet.h>
+#include <asm/io.h>
+
+#define HPET_MASK	0xFFFFFFFF
+#define HPET_SHIFT	22
+
+/* FSEC = 10^-15 NSEC = 10^-9 */
+#define FSEC_PER_NSEC	1000000
+
+static void *hpet_ptr;
+
+static cycle_t read_hpet(void)
+{
+	return (cycle_t)readl(hpet_ptr);
+}
+
+struct clocksource clocksource_hpet = {
+	.name		= "hpet",
+	.rating		= 250,
+	.read		= read_hpet,
+	.mask		= (cycle_t)HPET_MASK,
+	.mult		= 0, /* set below */
+	.shift		= HPET_SHIFT,
+	.is_continuous	= 1,
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
+	/* calculate the hpet address: */
+	hpet_base =
+		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
+	hpet_ptr = hpet_base + HPET_COUNTER;
+
+	/* calculate the frequency: */
+	hpet_period = readl(hpet_base + HPET_PERIOD);
+
+	/*
+	 * hpet period is in femto seconds per cycle
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
+
+	return 0;
+}
+
+module_init(init_hpet_clocksource);
diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
index e4b7f7d..5e62edd 100644
--- a/arch/i386/kernel/i8253.c
+++ b/arch/i386/kernel/i8253.c
@@ -2,6 +2,7 @@
  * i8253.c  8253/PIT functions
  *
  */
+#include <linux/clocksource.h>
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
 #include <linux/sysdev.h>
@@ -57,3 +58,62 @@ static int __init init_timer_sysfs(void)
 }
 
 device_initcall(init_timer_sysfs);
+
+
+/*
+ * Since the PIT overflows every tick, its not very useful
+ * to just read by itself. So use jiffies to emulate a free
+ * running counter:
+ */
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
+
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
+	.name	= "pit",
+	.rating = 110,
+	.read	= pit_read,
+	.mask	= (cycle_t)-1,
+	.mult	= 0,
+	.shift	= 20,
+};
+
+static int __init init_pit_clocksource(void)
+{
+	if (num_possible_cpus() > 4) /* PIT does not scale! */
+		return 0;
+
+	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
+	register_clocksource(&clocksource_pit);
+
+	return 0;
+}
+module_init(init_pit_clocksource);
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index bd04f92..d9004dc 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -4,13 +4,14 @@
  * See comments there for proper credits.
  */
 
+#include <linux/clocksource.h>
 #include <linux/workqueue.h>
 #include <linux/cpufreq.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
 
-#include <asm/tsc.h>
 #include <asm/delay.h>
+#include <asm/tsc.h>
 #include <asm/io.h>
 
 #include "mach_timer.h"
@@ -302,3 +303,85 @@ static int __init cpufreq_tsc(void)
 core_initcall(cpufreq_tsc);
 
 #endif
+
+/* clock source code */
+
+static unsigned long current_tsc_khz = 0;
+static int tsc_update_callback(void);
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret;
+
+	rdtscll(ret);
+
+	return ret;
+}
+
+static struct clocksource clocksource_tsc = {
+	.name			= "tsc",
+	.rating			= 300,
+	.read			= read_tsc,
+	.mask			= (cycle_t)-1,
+	.mult			= 0, /* to be set */
+	.shift			= 22,
+	.update_callback	= tsc_update_callback,
+	.is_continuous		= 1,
+};
+
+static int tsc_update_callback(void)
+{
+	int change = 0;
+
+	/* check to see if we should switch to the safe clocksource: */
+	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
+		clocksource_tsc.rating = 50;
+		reselect_clocksource();
+		change = 1;
+	}
+
+	/* only update if tsc_khz has changed: */
+	if (current_tsc_khz != tsc_khz) {
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		change = 1;
+	}
+
+	return change;
+}
+
+/*
+ * Make an educated guess if the TSC is trustworthy and synchronized
+ * over all CPUs.
+ */
+static __init int unsynchronized_tsc(void)
+{
+	/*
+	 * Intel systems are normally all synchronized.
+	 * Exceptions must mark TSC as unstable:
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+ 		return 0;
+
+	/* assume multi socket systems are not synchronized: */
+ 	return num_possible_cpus() > 1;
+}
+
+/* NUMAQ can't use TSC: */
+static int __init init_tsc_clocksource(void)
+{
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && tsc_khz && !tsc_disable) {
+		if (unsynchronized_tsc()) /* lower rating if unsynced */
+			mark_tsc_unstable();
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		register_clocksource(&clocksource_tsc);
+	}
+
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
diff --git a/drivers/Makefile b/drivers/Makefile
index ea410b6..b250984 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -70,3 +70,4 @@ obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
new file mode 100644
index 0000000..6e98a5e
--- /dev/null
+++ b/drivers/clocksource/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_ACPI) += acpi_pm.o
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
new file mode 100644
index 0000000..e5bc091
--- /dev/null
+++ b/drivers/clocksource/acpi_pm.c
@@ -0,0 +1,123 @@
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
+#include <linux/clocksource.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+/* Number of PMTMR ticks expected during calibration run */
+#define PMTMR_TICKS_PER_SEC 3579545
+
+#if (defined(CONFIG_X86) && (!defined(CONFIG_X86_64)))
+# include "mach_timer.h"
+# define PMTMR_EXPECTED_RATE ((PMTMR_TICKS_PER_SEC*CALIBRATE_TIME_MSEC)/1000)
+#endif
+
+/*
+ * The I/O port the PMTMR resides at.
+ * The location is detected during setup_arch(),
+ * in arch/i386/acpi/boot.c
+ */
+extern u32 acpi_pmtmr_ioport;
+extern int acpi_pmtmr_buggy;
+
+#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
+
+static inline u32 read_pmtmr(void)
+{
+	/* mask the output to 24 bits */
+	return inl(acpi_pmtmr_ioport) & ACPI_PM_MASK;
+}
+
+static cycle_t acpi_pm_read_verified(void)
+{
+	u32 v1 = 0, v2 = 0, v3 = 0;
+
+	/*
+	 * It has been reported that because of various broken
+	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM clock
+	 * source is not latched, so you must read it multiple
+	 * times to ensure a safe value is read:
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
+static cycle_t acpi_pm_read(void)
+{
+	return (cycle_t)read_pmtmr();
+}
+
+struct clocksource clocksource_acpi_pm = {
+	.name		= "acpi_pm",
+	.rating		= 200,
+	.read		= acpi_pm_read,
+	.mask		= (cycle_t)ACPI_PM_MASK,
+	.mult		= 0, /*to be caluclated*/
+	.shift		= 22,
+	.is_continuous	= 1,
+};
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
+						clocksource_acpi_pm.shift);
+
+	/* "verify" this timing source: */
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
+
+	/* check to see if pmtmr is known buggy: */
+	if (acpi_pmtmr_buggy) {
+		clocksource_acpi_pm.read = acpi_pm_read_verified;
+		clocksource_acpi_pm.rating = 110;
+	}
+
+	register_clocksource(&clocksource_acpi_pm);
+
+	return 0;
+}
+
+module_init(init_acpi_pm_clocksource);
diff --git a/drivers/clocksource/cyclone.c b/drivers/clocksource/cyclone.c
new file mode 100644
index 0000000..168e78b
--- /dev/null
+++ b/drivers/clocksource/cyclone.c
@@ -0,0 +1,121 @@
+#include <linux/clocksource.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+#include <asm/pgtable.h>
+#include <asm/io.h>
+
+#include "mach_timer.h"
+
+#define CYCLONE_CBAR_ADDR	0xFEB00CD0	/* base address ptr */
+#define CYCLONE_PMCC_OFFSET	0x51A0		/* offset to control register */
+#define CYCLONE_MPCS_OFFSET	0x51A8		/* offset to select register */
+#define CYCLONE_MPMC_OFFSET	0x51D0		/* offset to count register */
+#define CYCLONE_TIMER_FREQ	99780000	/* 100Mhz, but not really */
+#define CYCLONE_TIMER_MASK	0xFFFFFFFF	/* 32 bit mask */
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
+	.name		= "cyclone",
+	.rating		= 250,
+	.read		= read_cyclone,
+	.mask		= (cycle_t)CYCLONE_TIMER_MASK,
+	.mult		= 10,
+	.shift		= 0,
+	.is_continuous	= 1,
+};
+
+static int __init init_cyclone_clocksource(void)
+{
+	unsigned long base;	/* saved value from CBAR */
+	unsigned long offset;
+	u32 __iomem* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+	u32 __iomem* reg;
+	int i;
+
+	/* make sure we're on a summit box: */
+	if (!use_cyclone)
+		return -ENODEV;
+
+	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
+
+	/* find base address: */
+	offset = CYCLONE_CBAR_ADDR;
+	reg = ioremap_nocache(offset, sizeof(reg));
+	if (!reg) {
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
+		return -ENODEV;
+	}
+	/* even on 64bit systems, this is only 32bits: */
+	base = readl(reg);
+	if (!base) {
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
+		return -ENODEV;
+	}
+	iounmap(reg);
+
+	/* setup PMCC: */
+	offset = base + CYCLONE_PMCC_OFFSET;
+	reg = ioremap_nocache(offset, sizeof(reg));
+	if (!reg) {
+		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
+		return -ENODEV;
+	}
+	writel(0x00000001,reg);
+	iounmap(reg);
+
+	/* setup MPCS: */
+	offset = base + CYCLONE_MPCS_OFFSET;
+	reg = ioremap_nocache(offset, sizeof(reg));
+	if (!reg) {
+		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
+		return -ENODEV;
+	}
+	writel(0x00000001,reg);
+	iounmap(reg);
+
+	/* map in cyclone_timer: */
+	offset = base + CYCLONE_MPMC_OFFSET;
+	cyclone_timer = ioremap_nocache(offset, sizeof(u64));
+	if (!cyclone_timer) {
+		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
+		return -ENODEV;
+	}
+
+	/* quick test to make sure its ticking: */
+	for (i = 0; i < 3; i++){
+		u32 old = readl(cyclone_timer);
+		int stall = 100;
+
+		while (stall--)
+			barrier();
+
+		if (readl(cyclone_timer) == old) {
+			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
+			iounmap(cyclone_timer);
+			cyclone_timer = NULL;
+			return -ENODEV;
+		}
+	}
+	cyclone_ptr = cyclone_timer;
+
+	/* sort out mult/shift values: */
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

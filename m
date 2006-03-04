Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWCDEpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWCDEpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWCDEpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:45:13 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8367 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751796AbWCDEo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:44:58 -0500
Date: Fri, 3 Mar 2006 21:44:57 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>
Message-Id: <20060304044457.12782.25647.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060304044404.12782.88641.sendpatchset@cog.beaverton.ibm.com>
References: <20060304044404.12782.88641.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 9/9] Time: i386 Clocksource Drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch implements the time sources for i386 (acpi_pm, 
cyclone, hpet, pit, and tsc). With this patch, the conversion of the 
i386 arch to the generic timekeeping code should be complete.

The patch should be fairly straight forward, only adding the new 
clocksources.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/Makefile     |    1 
 arch/i386/kernel/hpet.c       |   67 +++++++++++++++++++++++
 arch/i386/kernel/i8253.c      |   57 ++++++++++++++++++++
 arch/i386/kernel/tsc.c        |  111 +++++++++++++++++++++++++++++++++++++++
 drivers/Makefile              |    1 
 drivers/clocksource/Makefile  |    2 
 drivers/clocksource/acpi_pm.c |   89 +++++++++++++++++++++++++++++++
 drivers/clocksource/cyclone.c |  119 ++++++++++++++++++++++++++++++++++++++++++
 kernel/time/clocksource.c     |    9 ++-
 9 files changed, 454 insertions(+), 2 deletions(-)

linux-2.6.16-rc5_timeofday-clocks-i386_B20.patch
============================================
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 5773f57..2824022 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
 obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
 EXTRA_AFLAGS   := -traditional
 
diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
new file mode 100644
index 0000000..91a5bdd
--- /dev/null
+++ b/arch/i386/kernel/hpet.c
@@ -0,0 +1,67 @@
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
+static struct clocksource clocksource_hpet = {
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
+	return register_clocksource(&clocksource_hpet);
+}
+
+module_init(init_hpet_clocksource);
diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
index 29cb2eb..cce0eb6 100644
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
@@ -30,3 +31,59 @@ void setup_pit_timer(void)
 	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
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
+	return register_clocksource(&clocksource_pit);
+}
+module_init(init_pit_clocksource);
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index aa4c51c..e0da759 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -4,11 +4,14 @@
  * See comments there for proper credits.
  */
 
+#include <linux/clocksource.h>
 #include <linux/workqueue.h>
 #include <linux/cpufreq.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/dmi.h>
 
+#include <asm/delay.h>
 #include <asm/tsc.h>
 #include <asm/delay.h>
 #include <asm/io.h>
@@ -315,3 +318,111 @@ static int __init cpufreq_tsc(void)
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
+static int __init dmi_mark_tsc_unstable(struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE "%s detected: marking TSC unstable.\n",
+		       d->ident);
+	mark_tsc_unstable();
+	return 0;
+}
+
+/* List of systems that have known TSC problems */
+static struct dmi_system_id __initdata bad_tsc_dmi_table[] = {
+	{
+	 .callback = dmi_mark_tsc_unstable,
+	 .ident = "IBM Thinkpad 380XD",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+		     DMI_MATCH(DMI_BOARD_NAME, "2635FA0"),
+		     },
+	 },
+	 {}
+};
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
+static int __init init_tsc_clocksource(void)
+{
+
+	if (cpu_has_tsc && tsc_khz && !tsc_disable) {
+		/* check blacklist */
+		dmi_check_system(bad_tsc_dmi_table);
+
+		if (unsynchronized_tsc()) /* mark unstable if unsynced */
+			mark_tsc_unstable();
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+		/* lower the rating if we already know its unstable: */
+		if (check_tsc_unstable())
+			clocksource_tsc.rating = 50;
+		return register_clocksource(&clocksource_tsc);
+	}
+
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
diff --git a/drivers/Makefile b/drivers/Makefile
index 5c69b86..55df79e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
new file mode 100644
index 0000000..be3511a
--- /dev/null
+++ b/drivers/clocksource/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
new file mode 100644
index 0000000..5440206
--- /dev/null
+++ b/drivers/clocksource/acpi_pm.c
@@ -0,0 +1,89 @@
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
+/*
+ * The I/O port the PMTMR resides at.
+ * The location is detected during setup_arch(),
+ * in arch/i386/acpi/boot.c
+ */
+u32 pmtmr_ioport;
+
+#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
+
+static inline u32 read_pmtmr(void)
+{
+	/* mask the output to 24 bits */
+	return inl(pmtmr_ioport) & ACPI_PM_MASK;
+}
+
+static cycle_t acpi_pm_read(void)
+{
+	return (cycle_t)read_pmtmr();
+}
+
+static struct clocksource clocksource_acpi_pm = {
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
+	if (!pmtmr_ioport)
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
+	return register_clocksource(&clocksource_acpi_pm);
+}
+
+module_init(init_acpi_pm_clocksource);
diff --git a/drivers/clocksource/cyclone.c b/drivers/clocksource/cyclone.c
new file mode 100644
index 0000000..444eb11
--- /dev/null
+++ b/drivers/clocksource/cyclone.c
@@ -0,0 +1,119 @@
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
+static struct clocksource clocksource_cyclone = {
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
+	return register_clocksource(&clocksource_cyclone);
+}
+
+module_init(init_cyclone_clocksource);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9668a34..d2ce2c3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -335,8 +335,13 @@ __setup("clocksource=", boot_override_cl
  */
 static int __init boot_override_clock(char* str)
 {
-	printk("Warning! clock= boot option is deprecated.\n");
-
+	if (!strcmp(str, "pmtmr")) {
+		printk("Warning: clock=pmtmr is depricated. "
+			"Use clocksource=acpi_pm.\n");
+		return boot_override_clocksource("acpi_pm");
+	}
+	printk("Warning! clock= boot option is deprecated. "
+		"Use clocksource=xyz\n");
 	return boot_override_clocksource(str);
 }
 

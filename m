Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVCLBeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVCLBeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCLBeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:34:13 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2192 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261877AbVCLB0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:26:09 -0500
Subject: [RFC][PATCH] new timeofday arch specific timesource drivers  (v.
	A3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <1110590710.30498.329.camel@cog.beaverton.ibm.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <1110590710.30498.329.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:26:03 -0800
Message-Id: <1110590763.30498.331.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements most of the time sources for i386, x86-64, ppc32
and ppc64 (tsc, pit, cyclone, acpi-pm, hpet and timebase). There are
also initial untested sketches for the ia64 itc and sn2_rtc timesources.
It applies ontop of my linux-2.6.11_timeofday-arch_A3 patch. It provides
real hardware timesources (opposed to the example jiffies timesource)
that can be used for more realistic testing.

This patch is the shabbiest of the three. It needs to be broken up, and
cleaned. The i386_pit.c is broken. The hpet and cyclone code have been
attempted to be cleaned up so they can be shared between x86-64, i386
and ia64, but they still need testing. acpi_pm also needs to be made
arch generic, but for now it will get you going so you can test and play
with the core code.

New in this release:
o ppc32_timebase code (by Darrick Wong!)
o move cyclone code to TIMESOURCE_MMIO_32
o cleaned up hpet to work on i386 as well as x86-64
o untested/uncompiled ia64 timesources (these are mine, don't blame
Max!)
o other minor code cleanups

Items still on the TODO list:
o real ia64 timesources
o make cyclone/apci_pm arch generic 
o example interpolation timesource
o fix i386_pit timesource
o all other arch timesources (volunteers wanted!)
o lots of cleanups
o lots of testing

thanks
-john

linux-2.6.11_timeofday-timesources_A3.patch
===================================================
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-03-11 17:04:48 -08:00
+++ b/arch/i386/kernel/Makefile	2005-03-11 17:04:48 -08:00
@@ -7,10 +7,10 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o
+		doublefault.o quirks.o tsc.o
 
 obj-y				+= cpu/
-obj-y				+= timers/
+obj-$(!CONFIG_NEWTOD)		+= timers/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c	2005-03-11 17:04:48 -08:00
+++ b/arch/i386/kernel/acpi/boot.c	2005-03-11 17:04:48 -08:00
@@ -547,7 +547,7 @@
 
 
 #ifdef CONFIG_HPET_TIMER
-
+#include <asm/hpet.h>
 static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 {
 	struct acpi_table_hpet *hpet_tbl;
@@ -570,18 +570,12 @@
 #ifdef	CONFIG_X86_64
         vxtime.hpet_address = hpet_tbl->addr.addrl |
                 ((long) hpet_tbl->addr.addrh << 32);
-
-        printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-               hpet_tbl->id, vxtime.hpet_address);
+	hpet_address = vxtime.hpet_address;
 #else	/* X86 */
-	{
-		extern unsigned long hpet_address;
-
 		hpet_address = hpet_tbl->addr.addrl;
+#endif	/* X86 */
 		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
 			hpet_tbl->id, hpet_address);
-	}
-#endif	/* X86 */
 
 	return 0;
 }
diff -Nru a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c	2005-03-11 17:04:48 -08:00
+++ b/arch/i386/kernel/i8259.c	2005-03-11 17:04:48 -08:00
@@ -387,6 +387,48 @@
 	}
 }
 
+#ifdef CONFIG_NEWTOD
+void setup_pit_timer(void)
+{
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
+	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+	udelay(10);
+	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int timer_resume(struct sys_device *dev)
+{
+	setup_pit_timer();
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer_pit"),
+	.resume	= timer_resume,
+};
+
+static struct sys_device device_timer = {
+	.id	= 0,
+	.cls	= &timer_sysclass,
+};
+
+static int __init init_timer_sysfs(void)
+{
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(init_timer_sysfs);
+#endif
+
 void __init init_IRQ(void)
 {
 	int i;
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2005-03-11 17:04:48 -08:00
+++ b/arch/i386/kernel/setup.c	2005-03-11 17:04:48 -08:00
@@ -50,6 +50,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/tsc.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -1527,6 +1528,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	tsc_init();
 }
 
 #include "setup_arch_post.h"
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-03-11 17:04:48 -08:00
+++ b/arch/i386/kernel/time.c	2005-03-11 17:04:48 -08:00
@@ -88,7 +88,9 @@
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+#ifndef CONFIG_NEWTOD
 struct timer_opts *cur_timer = &timer_none;
+#endif
 
 /*
  * This is a special lock that is owned by the CPU and holds the index
diff -Nru a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c	2005-03-11 17:04:48 -08:00
+++ b/arch/i386/kernel/timers/common.c	2005-03-11 17:04:48 -08:00
@@ -22,8 +22,6 @@
  * device.
  */
 
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
 unsigned long __init calibrate_tsc(void)
 {
 	mach_prepare_counter();
diff -Nru a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/kernel/tsc.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,111 @@
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/cpufreq.h>
+#include <asm/tsc.h>
+#include "mach_timer.h"
+
+unsigned long cpu_freq_khz;
+#ifdef CONFIG_NEWTOD
+int tsc_disable;
+#endif
+
+void tsc_init(void)
+{
+	unsigned long long start, end;
+	unsigned long count;
+	u64 delta64;
+	int i;
+
+	/* repeat 3 times to make sure the cache is warm */
+	for(i=0; i < 3; i++) {
+		mach_prepare_counter();
+		rdtscll(start);
+		mach_countup(&count);
+		rdtscll(end);
+	}
+	delta64 = end - start;
+
+	/* cpu freq too fast */
+	if(delta64 > (1ULL<<32))
+		return;
+	/* cpu freq too slow */
+	if (delta64 <= CALIBRATE_TIME)
+		return;
+
+	delta64 *= 1000;
+	do_div(delta64,CALIBRATE_TIME);
+	cpu_freq_khz = (unsigned long)delta64;
+
+	cpu_khz = cpu_freq_khz;
+
+	printk("Detected %lu.%03lu MHz processor.\n",
+				cpu_khz / 1000, cpu_khz % 1000);
+
+}
+
+
+/* All of the code below comes from arch/i386/kernel/timers/timer_tsc.c
+ * XXX: severly needs better comments and the ifdef's killed.
+ */
+
+#ifdef CONFIG_CPU_FREQ
+static unsigned int cpufreq_init = 0;
+
+/* If the CPU frequency is scaled, TSC-based delays will need a different
+ * loops_per_jiffy value to function properly.
+ */
+
+static unsigned int  ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+
+#ifndef CONFIG_SMP
+static unsigned long cpu_khz_ref = 0;
+#endif
+
+static int time_cpufreq_notifier(struct notifier_block *nb,
+		unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+
+	if (val != CPUFREQ_RESUMECHANGE)
+		write_seqlock_irq(&xtime_lock);
+	if (!ref_freq) {
+		ref_freq = freq->old;
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+#ifndef CONFIG_SMP
+		cpu_khz_ref = cpu_khz;
+#endif
+	}
+
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
+	    (val == CPUFREQ_RESUMECHANGE)) {
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+#ifndef CONFIG_SMP
+		if (cpu_khz)
+			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+#endif
+	}
+
+	if (val != CPUFREQ_RESUMECHANGE)
+		write_sequnlock_irq(&xtime_lock);
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	.notifier_call	= time_cpufreq_notifier
+};
+
+static int __init cpufreq_tsc(void)
+{
+	int ret;
+	ret = cpufreq_register_notifier(&time_cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (!ret)
+		cpufreq_init = 1;
+	return ret;
+}
+core_initcall(cpufreq_tsc);
+#endif /* CONFIG_CPU_FREQ */
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2005-03-11 17:04:48 -08:00
+++ b/arch/x86_64/kernel/time.c	2005-03-11 17:04:48 -08:00
@@ -59,6 +59,7 @@
 #undef HPET_HACK_ENABLE_DANGEROUS
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
+unsigned long hpet_address;
 unsigned long hpet_period;				/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 unsigned long vxtime_hz = PIT_TICK_RATE;
diff -Nru a/drivers/timesource/Makefile b/drivers/timesource/Makefile
--- a/drivers/timesource/Makefile	2005-03-11 17:04:48 -08:00
+++ b/drivers/timesource/Makefile	2005-03-11 17:04:48 -08:00
@@ -1 +1,14 @@
 obj-y += jiffies.o
+obj-$(CONFIG_X86) += tsc.o
+obj-$(CONFIG_PPC64) += ppc64_timebase.o
+obj-$(CONFIG_PPC) += ppc_timebase.o
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_HPET_TIMER) += hpet.o
+
+# XXX - Known broken
+#obj-$(CONFIG_X86) += i386_pit.o
+
+# XXX - Untested/Uncompiled
+#obj-$(CONFIG_IA64) += itc.c
+#obj-$(CONFIG_IA64_SGI_SN2) += sn2_rtc.c
diff -Nru a/drivers/timesource/acpi_pm.c b/drivers/timesource/acpi_pm.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/acpi_pm.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,116 @@
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
+static int verify_pmtmr_rate(void)
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
+static int init_acpi_pm_timesource(void)
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
diff -Nru a/drivers/timesource/cyclone.c b/drivers/timesource/cyclone.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/cyclone.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,137 @@
+#include <linux/timesource.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/fixmap.h>
+#include "mach_timer.h"
+
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0		/* base address ptr*/
+#define CYCLONE_PMCC_OFFSET 0x51A0		/* offset to control register */
+#define CYCLONE_MPCS_OFFSET 0x51A8		/* offset to select register */
+#define CYCLONE_MPMC_OFFSET 0x51D0		/* offset to count register */
+#define CYCLONE_TIMER_FREQ 100000000
+#define CYCLONE_TIMER_MASK (((u64)1<<32)-1) /* 32 bit mask */
+
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
+static unsigned long calibrate_cyclone(void)
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
+static int init_cyclone_timesource(void)
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
diff -Nru a/drivers/timesource/hpet.c b/drivers/timesource/hpet.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/hpet.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,58 @@
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
+static int init_hpet_timesource(void)
+{
+	unsigned long hpet_period, hpet_hz;
+	u64 tmp;
+
+	if (!hpet_address)
+		return -ENODEV;
+
+	/* calculate the hpet address */
+	timesource_hpet.mmio_ptr =
+		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE)
+		+ HPET_COUNTER;
+
+	/* calculate the frequency */
+	hpet_period = hpet_readl(HPET_PERIOD);
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
diff -Nru a/drivers/timesource/i386_pit.c b/drivers/timesource/i386_pit.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/i386_pit.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,100 @@
+/* pit timesource: XXX - broken!
+ */
+
+#include <linux/timesource.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/timer.h>
+#include "io_ports.h"
+#include "do_timer.h"
+
+extern u64 jiffies_64;
+extern long jiffies;
+extern spinlock_t i8253_lock;
+
+/* Since the PIT overflows every tick, its not very useful
+ * to just read by itself. So throw jiffies into the mix to
+ * and just return nanoseconds in pit_read().
+ */
+
+static cycle_t pit_read(void)
+{
+	unsigned long flags;
+	int count;
+	unsigned long jiffies_t;
+	static int count_p;
+	static unsigned long jiffies_p = 0;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+
+	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
+
+	count = inb_p(PIT_CH0);	/* read the latched count */
+	jiffies_t = jiffies;
+	count |= inb_p(PIT_CH0) << 8;
+
+	/* VIA686a test code... reset the latch if count > max + 1 */
+	if (count > LATCH) {
+		outb_p(0x34, PIT_MODE);
+		outb_p(LATCH & 0xff, PIT_CH0);
+		outb(LATCH >> 8, PIT_CH0);
+		count = LATCH - 1;
+	}
+
+	/*
+	 * avoiding timer inconsistencies (they are rare, but they happen)...
+	 * there are two kinds of problems that must be avoided here:
+	 *  1. the timer counter underflows
+	 *  2. hardware problem with the timer, not giving us continuous time,
+	 *     the counter does small "jumps" upwards on some Pentium systems,
+	 *     (see c't 95/10 page 335 for Neptun bug.)
+	 */
+
+	if( jiffies_t == jiffies_p ) {
+		if( count > count_p ) {
+			/* the nutcase */
+			count = do_timer_overflow(count);
+		}
+	} else
+		jiffies_p = jiffies_t;
+
+	count_p = count;
+
+	spin_unlock_irqrestore(&i8253_lock, flags);
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = (count + LATCH/2) / LATCH;
+
+	count *= 1000; /* convert count from usec->nsec */
+
+	return (cycle_t)((jiffies_64 * TICK_NSEC) + count);
+}
+
+static cycle_t pit_delta(cycle_t now, cycle_t then)
+{
+	return now - then;
+}
+
+/* just return cyc, as its already in ns */
+static nsec_t pit_cyc2ns(cycle_t cyc, cycle_t* remainder)
+{
+	return (nsec_t)cyc;
+}
+
+static struct timesource_t timesource_pit = {
+	.name = "pit",
+	.priority = 0,
+	.read = pit_read,
+	.delta = pit_delta,
+	.cyc2ns = pit_cyc2ns,
+};
+
+static int init_pit_timesource(void)
+{
+	register_timesource(&timesource_pit);
+	return 0;
+}
+
+module_init(init_pit_timesource);
diff -Nru a/drivers/timesource/itc.c b/drivers/timesource/itc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/itc.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,37 @@
+/* XXX - this is totally untested and uncompiled
+ * TODO:
+ *		o cpufreq issues
+ *		o unsynched ITCs ?
+ */
+#include <linux/timesource.h>
+
+/* XXX - Other includes needed for:
+ *		sal_platform_features, IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT,
+ *		local_cpu_data->itc_freq
+ * See arch/ia64/kernel/time.c for ideas
+ */
+
+#define ITC_MASK (0xffffffffffffffffLL)
+
+static struct timesource_t timesource_itc = {
+	.name = "itc",
+	.priority = 25,
+	.type = TIMESOURCE_CYCLES,
+	.mask = (cycle_t)ITC_MASK,
+	.mult = 0, /* to be set */
+	.shift = 22,
+};
+
+static int init_itc_timesource(void)
+{
+	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
+		/* XXX - I'm not really sure if itc_freq is in cyc/sec */
+		timesource_itc.mult = timesource_hz2mult(local_cpu_data->itc_freq,
+									timesource_itc.shift);
+		register_timesource(&timesource_itc);
+	}
+	return 0;
+}
+
+module_init(init_itc_timesource);
+
diff -Nru a/drivers/timesource/ppc64_timebase.c b/drivers/timesource/ppc64_timebase.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/ppc64_timebase.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,33 @@
+#include <linux/timesource.h>
+#include <asm/time.h>
+
+static cycle_t timebase_read(void)
+{
+	return (cycle_t)get_tb();
+}
+
+struct timesource_t timesource_timebase = {
+	.name = "timebase",
+	.priority = 200,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = timebase_read,
+	.mask = (cycle_t)-1UL,
+	.mult = 0,
+	.shift = 22,
+};
+
+
+/* XXX - this should be calculated or properly externed! */
+extern unsigned long tb_to_ns_scale;
+extern unsigned long tb_to_ns_shift;
+extern unsigned long tb_ticks_per_sec;
+
+static int init_timebase_timesource(void)
+{
+	timesource_timebase.mult = timesource_hz2mult(tb_ticks_per_sec,
+										timesource_timebase.shift);
+	register_timesource(&timesource_timebase);
+	return 0;
+}
+
+module_init(init_timebase_timesource);
diff -Nru a/drivers/timesource/ppc_timebase.c b/drivers/timesource/ppc_timebase.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/ppc_timebase.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,55 @@
+#include <linux/timesource.h>
+#include <linux/init.h>
+#include <asm/time.h>
+
+/* XXX - this should be calculated or properly externed! */
+
+/* DJWONG: tb_to_ns_scale is supposed to be set in time_init.
+ * No idea if that actually _happens_ on a ppc601, though it
+ * seems to work on a B&W G3. :D */
+extern unsigned long tb_to_ns_scale;
+
+static cycle_t ppc_timebase_read(void)
+{
+	unsigned long lo, hi, hi2;
+	unsigned long long tb;
+
+	do {
+		hi = get_tbu();
+		lo = get_tbl();
+		hi2 = get_tbu();
+	} while (hi2 != hi);
+	tb = ((unsigned long long) hi << 32) | lo;
+
+	return (cycle_t)tb;
+}
+
+struct timesource_t timesource_ppc_timebase = {
+	.name = "ppc_timebase",
+	.priority = 200,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = ppc_timebase_read,
+	.mask = (cycle_t)-1UL,
+	.mult = 0,
+	.shift = 22,
+};
+
+static int init_ppc_timebase_timesource(void)
+{
+	/* DJWONG: Extrapolated from ppc64 code. */
+	unsigned long tb_ticks_per_sec;
+	unsigned long long x;
+
+	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
+
+	timesource_ppc_timebase.mult = timesource_hz2mult(tb_ticks_per_sec,
+										timesource_ppc_timebase.shift);
+
+	printk(KERN_INFO "ppc_timebase: tb_ticks_per_sec = %lu, mult = %lu, tb_to_ns = %lu.\n",
+		tb_ticks_per_sec, timesource_ppc_timebase.mult , tb_to_ns_scale);
+
+	register_timesource(&timesource_ppc_timebase);
+	return 0;
+}
+
+module_init(init_ppc_timebase_timesource);
diff -Nru a/drivers/timesource/sn2_rtc.c b/drivers/timesource/sn2_rtc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/sn2_rtc.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,29 @@
+#include <linux/timesource.h>
+/* XXX this will need some includes
+ * to find: sn_rtc_cycles_per_second and RTC_COUNTER_ADDR
+ * See arch/ia64/sn/kernel/sn2/timer.c for likely suspects
+ */
+
+#define SN2_RTC_MASK ((1LL << 55) - 1)
+#define SN2_SHIFT 10
+
+struct timesource_t timesource_sn2_rtc = {
+	.name = "sn2_rtc",
+	.priority = 300, /* XXX - not sure what this should be */
+	.type = TIMESOURCE_MMIO_64,
+	.mmio_ptr = NULL,
+	.mask = (cycle_t)SN2_RTC_MASK,
+	.mult = 0, /* set below */
+	.shift = SN2_SHIFT,
+};
+
+static void init_sn2_timesource(void)
+{
+	timesource_sn2_rtc.mult = timesource_hz2mult(sn_rtc_cycles_per_second,
+												SN2_SHIFT);
+	timesource_sn2_rtc.mmio_ptr = RTC_COUNTER_ADDR;
+
+	register_time_interpolator(&timesource_sn2_rtc);
+	return 0;
+}
+module_init(init_sn2_timesource);
diff -Nru a/drivers/timesource/tsc.c b/drivers/timesource/tsc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/tsc.c	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,46 @@
+/* TODO:
+ *		o better calibration
+ */
+
+#include <linux/timesource.h>
+#include <linux/timex.h>
+#include <linux/init.h>
+
+static void tsc_update_callback(void);
+
+static struct timesource_t timesource_tsc = {
+	.name = "tsc",
+	.priority = 25,
+	.type = TIMESOURCE_CYCLES,
+	.mask = (cycle_t)~0,
+	.mult = 0, /* to be set */
+	.shift = 22,
+	.update_callback = tsc_update_callback,
+};
+
+static unsigned long current_cpu_khz = 0;
+
+static void tsc_update_callback(void)
+{
+	/* only update if cpu_khz has changed */
+	if (current_cpu_khz != cpu_khz){
+		current_cpu_khz = cpu_khz;
+		timesource_tsc.mult = timesource_khz2mult(current_cpu_khz,
+									timesource_tsc.shift);
+	}
+}
+
+static int init_tsc_timesource(void)
+{
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && cpu_khz) {
+		current_cpu_khz = cpu_khz;
+		timesource_tsc.mult = timesource_khz2mult(current_cpu_khz,
+									timesource_tsc.shift);
+		register_timesource(&timesource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_timesource);
+
diff -Nru a/include/asm-i386/mach-default/mach_timer.h b/include/asm-i386/mach-default/mach_timer.h
--- a/include/asm-i386/mach-default/mach_timer.h	2005-03-11 17:04:48 -08:00
+++ b/include/asm-i386/mach-default/mach_timer.h	2005-03-11 17:04:48 -08:00
@@ -14,8 +14,12 @@
  */
 #ifndef _MACH_TIMER_H
 #define _MACH_TIMER_H
+#include <linux/jiffies.h>
+#include <asm/io.h>
 
-#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_ITERATION 50
+#define CALIBRATE_LATCH	(CALIBRATE_ITERATION * LATCH)
+#define CALIBRATE_TIME	(CALIBRATE_ITERATION * 1000020/HZ)
 
 static inline void mach_prepare_counter(void)
 {
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	2005-03-11 17:04:48 -08:00
+++ b/include/asm-i386/timer.h	2005-03-11 17:04:48 -08:00
@@ -2,6 +2,13 @@
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
 
+#define TICK_SIZE (tick_nsec / 1000)
+void setup_pit_timer(void);
+/* Modifiers for buggy PIT handling */
+extern int pit_latch_buggy;
+extern int timer_ack;
+
+#ifndef CONFIG_NEWTOD
 /**
  * struct timer_ops - used to define a timer source
  *
@@ -29,18 +36,10 @@
 	struct timer_opts *opts;
 };
 
-#define TICK_SIZE (tick_nsec / 1000)
-
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
-void setup_pit_timer(void);
-
-/* Modifiers for buggy PIT handling */
-
-extern int pit_latch_buggy;
 
 extern struct timer_opts *cur_timer;
-extern int timer_ack;
 
 /* list of externed timers */
 extern struct timer_opts timer_none;
@@ -60,5 +59,6 @@
 
 #ifdef CONFIG_X86_PM_TIMER
 extern struct init_timer_opts timer_pmtmr_init;
+#endif
 #endif
 #endif
diff -Nru a/include/asm-i386/tsc.h b/include/asm-i386/tsc.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/tsc.h	2005-03-11 17:04:48 -08:00
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_TSC_H
+#define _ASM_I386_TSC_H
+extern unsigned long cpu_freq_khz;
+void tsc_init(void);
+
+#endif
diff -Nru a/include/asm-x86_64/hpet.h b/include/asm-x86_64/hpet.h
--- a/include/asm-x86_64/hpet.h	2005-03-11 17:04:48 -08:00
+++ b/include/asm-x86_64/hpet.h	2005-03-11 17:04:48 -08:00
@@ -44,6 +44,7 @@
 #define HPET_TN_SETVAL		0x040
 #define HPET_TN_32BIT		0x100
 
+extern unsigned long hpet_address;	/* hpet memory map physical address */
 extern int is_hpet_enabled(void);
 extern int hpet_rtc_timer_init(void);
 extern int oem_force_hpet_timer(void);
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2005-03-11 17:04:48 -08:00
+++ b/include/linux/sched.h	2005-03-11 17:04:48 -08:00
@@ -807,7 +807,11 @@
 }
 #endif
 
+#ifndef CONFIG_NEWTOD
 extern unsigned long long sched_clock(void);
+#else
+#define sched_clock() 0
+#endif
 extern unsigned long long current_sched_time(const task_t *current_task);
 
 /* sched_exec is called by processes performing an exec */
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2005-03-11 17:04:48 -08:00
+++ b/kernel/sched.c	2005-03-11 17:04:48 -08:00
@@ -176,6 +176,11 @@
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
+/* XXX - terrible hack just for now */
+#ifdef CONFIG_NEWTOD
+#define sched_clock() 0
+#endif
+
 /*
  * These are the runqueue data structures:
  */



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVAYBUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVAYBUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVAXXQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:16:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:58295 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261708AbVAXWxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:53:46 -0500
Subject: [RFC][PATCH] new timeofday arch specific timesources (v. A2)
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
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1106607153.30884.12.camel@cog.beaverton.ibm.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 14:53:35 -0800
Message-Id: <1106607215.30884.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements most of the time sources for i386, x86-64, and
ppc64 (tsc, pit, cyclone, acpi-pm, hpet and timebase). It applies on top
of my linux-2.6.11-rc2_timeofday-arch_A2 patch. It provides real
timesources (opposed to the example jiffies timesource) that can be used
for more realistic testing.

	This patch is the shabbiest of the three. It needs to be broken up, and
cleaned. The i386_pit.c is broken. Also, acpi_pm and hpet need to be
made generic so they can be shared between i386 and x86-64. But for now
it will get you going so you can test and play with the core code.

New in this release:
o ppc64_timebase code
o move tsc code to TIMESOURCE_CYCLES
o add tsc_update_callback for cpufreq changes (untested)
o move hpet code to TIMESOURCE_MMIO_32

thanks
-john

linux-2.6.11-rc2_timeofday-timesources_A2.patch
===================================================
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-01-24 13:36:22 -08:00
+++ b/arch/i386/kernel/Makefile	2005-01-24 13:36:22 -08:00
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o
+		doublefault.o quirks.o tsc.o
 
 obj-y				+= cpu/
 obj-$(!CONFIG_NEWTOD)		+= timers/
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2005-01-24 13:36:22 -08:00
+++ b/arch/i386/kernel/setup.c	2005-01-24 13:36:22 -08:00
@@ -49,6 +49,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/tsc.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -1439,6 +1440,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	tsc_init();
 }
 
 #include "setup_arch_post.h"
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-01-24 13:36:22 -08:00
+++ b/arch/i386/kernel/time.c	2005-01-24 13:36:22 -08:00
@@ -461,6 +461,7 @@
 
 void __init time_init(void)
 {
+#ifndef CONFIG_NEWTOD
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_capable()) {
 		/*
@@ -478,6 +479,7 @@
 
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
+#endif
 
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c	2005-01-24 13:36:22 -08:00
+++ b/arch/i386/kernel/timers/common.c	2005-01-24 13:36:22 -08:00
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
+++ b/arch/i386/kernel/tsc.c	2005-01-24 13:36:22 -08:00
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
diff -Nru a/drivers/timesource/Makefile b/drivers/timesource/Makefile
--- a/drivers/timesource/Makefile	2005-01-24 13:36:22 -08:00
+++ b/drivers/timesource/Makefile	2005-01-24 13:36:22 -08:00
@@ -1 +1,7 @@
 obj-y += jiffies.o
+obj-$(CONFIG_X86) += i386_tsc.o
+obj-$(CONFIG_PPC64) += ppc64_timebase.o
+#obj-$(CONFIG_X86) += i386_pit.o
+obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+obj-$(CONFIG_X86_64) += x86-64_hpet.o
diff -Nru a/drivers/timesource/acpi_pm.c b/drivers/timesource/acpi_pm.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/acpi_pm.c	2005-01-24 13:36:22 -08:00
@@ -0,0 +1,113 @@
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
+	.mult = 286070,
+	.shift = 10,
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
+++ b/drivers/timesource/cyclone.c	2005-01-24 13:36:22 -08:00
@@ -0,0 +1,154 @@
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
+#define CYCLONE_CBAR_ADDR 0xFEB00CD0
+#define CYCLONE_PMCC_OFFSET 0x51A0
+#define CYCLONE_MPMC_OFFSET 0x51D0
+#define CYCLONE_MPCS_OFFSET 0x51A8
+#define CYCLONE_TIMER_FREQ 100000000
+#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */
+
+unsigned long cyclone_freq_khz;
+
+int use_cyclone = 0;
+static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+
+/* helper macro to atomically read both cyclone counter registers */
+#define read_cyclone_counter(low,high) \
+	do{ \
+		high = cyclone_timer[1]; low = cyclone_timer[0]; \
+	} while (high != cyclone_timer[1]);
+
+
+static cycle_t cyclone_read(void)
+{
+	u32 low, high;
+	u64 ret;
+
+	read_cyclone_counter(low,high);
+	ret = ((u64)high << 32)|low;
+
+	return (cycle_t)ret;
+}
+
+struct timesource_t timesource_cyclone = {
+	.name = "cyclone",
+	.priority = 100,
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = cyclone_read,
+	.mask = (cycle_t)CYCLONE_TIMER_MASK,
+	.mult = 10,
+	.shift = 0,
+};
+
+
+static void calibrate_cyclone(void)
+{
+	u32 startlow, starthigh, endlow, endhigh, delta32;
+	u64 start, end, delta64;
+	unsigned long i, count;
+	/* repeat 3 times to make sure the cache is warm */
+	for(i=0; i < 3; i++) {
+		mach_prepare_counter();
+		read_cyclone_counter(startlow,starthigh);
+		mach_countup(&count);
+		read_cyclone_counter(endlow,endhigh);
+	}
+	start = (u64)starthigh<<32|startlow;
+	end = (u64)endhigh<<32|endlow;
+
+	delta64 = end - start;
+	printk("cyclone delta: %llu\n", delta64);
+	delta64 *= (ACTHZ/1000)>>8;
+	printk("delta*hz = %llu\n", delta64);
+	delta32 = (u32)delta64;
+	cyclone_freq_khz = delta32/CALIBRATE_ITERATION;
+	printk("calculated cyclone_freq: %lu khz\n", cyclone_freq_khz);
+}
+
+static int init_cyclone_timesource(void)
+{
+	u32* reg;
+	u32 base;		/* saved cyclone base address */
+	u32 pageaddr;	/* page that contains cyclone_timer register */
+	u32 offset;		/* offset from pageaddr to cyclone_timer register */
+	int i;
+
+	/*make sure we're on a summit box*/
+	if(!use_cyclone) return -ENODEV;
+
+	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
+
+	/* find base address */
+	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
+	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
+		return -ENODEV;
+	}
+	base = *reg;
+	if(!base){
+		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
+		return -ENODEV;
+	}
+
+	/* setup PMCC */
+	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
+		return -ENODEV;
+	}
+	reg[0] = 0x00000001;
+
+	/* setup MPCS */
+	pageaddr = (base + CYCLONE_MPCS_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_MPCS_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!reg){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
+		return -ENODEV;
+	}
+	reg[0] = 0x00000001;
+
+	/* map in cyclone_timer */
+	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
+	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
+	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
+	if(!cyclone_timer){
+		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
+		return -ENODEV;
+	}
+
+	/*quick test to make sure its ticking*/
+	for(i=0; i<3; i++){
+		u32 old = cyclone_timer[0];
+		int stall = 100;
+		while(stall--) barrier();
+		if(cyclone_timer[0] == old){
+			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
+			cyclone_timer = NULL;
+			return -ENODEV;
+		}
+	}
+	calibrate_cyclone();
+	register_timesource(&timesource_cyclone);
+
+	return 0;
+}
+
+module_init(init_cyclone_timesource);
diff -Nru a/drivers/timesource/i386_pit.c b/drivers/timesource/i386_pit.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/i386_pit.c	2005-01-24 13:36:22 -08:00
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
diff -Nru a/drivers/timesource/i386_tsc.c b/drivers/timesource/i386_tsc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/i386_tsc.c	2005-01-24 13:36:22 -08:00
@@ -0,0 +1,55 @@
+/* TODO:
+ *		o cpufreq code
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
+
+static inline u32 calculate_tsc_mult(unsigned long tsc_khz)
+{
+	unsigned long long x;
+	x = (NSEC_PER_SEC/HZ);
+	x = x << timesource_tsc.shift;
+	do_div(x, tsc_khz);
+	return (u32)x;
+}
+
+static unsigned long current_cpu_khz = 0;
+
+static void tsc_update_callback(void)
+{
+	/* only update if cpu_khz has changed */
+	if (current_cpu_khz != cpu_khz){
+		current_cpu_khz = cpu_khz;
+		timesource_tsc.mult = calculate_tsc_mult(current_cpu_khz);
+	}
+}
+
+static int init_tsc_timesource(void)
+{
+	/* TSC initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && cpu_khz) {
+		current_cpu_khz = cpu_khz;
+		timesource_tsc.mult = calculate_tsc_mult(current_cpu_khz);
+		register_timesource(&timesource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_timesource);
+
diff -Nru a/drivers/timesource/ppc64_timebase.c b/drivers/timesource/ppc64_timebase.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/ppc64_timebase.c	2005-01-24 13:36:22 -08:00
@@ -0,0 +1,37 @@
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
+	unsigned long long x;
+	x = (NSEC_PER_SEC/HZ);
+	x = x << timesource_timebase.shift;
+	do_div(x, (tb_ticks_per_sec/1000));
+	timesource_timebase.mult = (u32)x;
+
+	register_timesource(&timesource_timebase);
+	return 0;
+}
+
+module_init(init_timebase_timesource);
diff -Nru a/drivers/timesource/x86-64_hpet.c b/drivers/timesource/x86-64_hpet.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/x86-64_hpet.c	2005-01-24 13:36:22 -08:00
@@ -0,0 +1,40 @@
+#include <linux/timesource.h>
+#include <linux/hpet.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/hpet.h>
+
+#define HPET_MASK (~0L)
+#define HPET_SHIFT 32
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
+
+	if (!vxtime.hpet_address)
+		return -ENODEV;
+
+	/* calculate the hpet address */
+	timesource_hpet.mmio_ptr =
+		(void __iomem*)fix_to_virt(FIX_HPET_BASE) + HPET_COUNTER;
+
+	/* calculate and set the timesource multiplier */
+	hpet_period = hpet_readl(HPET_PERIOD);
+	hpet_hz = (1000000000000000L + hpet_period / 2) / hpet_period;
+	timesource_hpet.mult = (1000000L << HPET_SHIFT) / hpet_hz;
+
+	register_timesource(&timesource_hpet);
+	return 0;
+}
+module_init(init_hpet_timesource);
diff -Nru a/include/asm-i386/mach-default/mach_timer.h b/include/asm-i386/mach-default/mach_timer.h
--- a/include/asm-i386/mach-default/mach_timer.h	2005-01-24 13:36:22 -08:00
+++ b/include/asm-i386/mach-default/mach_timer.h	2005-01-24 13:36:22 -08:00
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
diff -Nru a/include/asm-i386/tsc.h b/include/asm-i386/tsc.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/tsc.h	2005-01-24 13:36:22 -08:00
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_TSC_H
+#define _ASM_I386_TSC_H
+extern unsigned long cpu_freq_khz;
+void tsc_init(void);
+
+#endif
diff -Nru a/include/linux/timeofday.h b/include/linux/timeofday.h
--- a/include/linux/timeofday.h	2005-01-24 13:36:22 -08:00
+++ b/include/linux/timeofday.h	2005-01-24 13:36:22 -08:00
@@ -8,7 +8,9 @@
 #define _LINUX_TIMEOFDAY_H
 #include <linux/types.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <asm/div64.h>
+
 
 #ifdef CONFIG_NEWTOD
 nsec_t get_lowres_timestamp(void);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2005-01-24 13:36:22 -08:00
+++ b/kernel/sched.c	2005-01-24 13:36:22 -08:00
@@ -174,6 +174,11 @@
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
+
+#ifdef CONFIG_NEWTOD
+#define sched_clock() 0
+#endif
+
 /*
  * These are the runqueue data structures:
  */



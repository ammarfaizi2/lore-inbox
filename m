Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUIBVcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUIBVcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269178AbUIBVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:31:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4851 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269132AbUIBVRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:17:13 -0400
Subject: [RFC][PATCH] new timeofday i386 timesources (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1094159492.14662.325.camel@cog.beaverton.ibm.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <1094159492.14662.325.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1094159573.14662.328.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 14:12:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements most of the i386 time sources (tsc, pit, cyclone,
acpi-pm). It applies ontop of my linux-2.6.9-rc1_timeofday-i386_A0
patch. It provides real timesources (opposed to the example jiffies
timesource) that can be used for more realistic testing.

	This patch is the shabbiest of the three. It needs to be broken up, and
cleaned. The i386_pit.c is broken and the cpufreq code needs to be added
to tsc.c. But it will get you going so you can test and play with the
core code.

thanks
-john

linux-2.6.9_rc1_timeofday-i386-timesources_A0.patch
===================================================
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2004-09-02 13:45:15 -07:00
+++ b/arch/i386/kernel/Makefile	2004-09-02 13:45:15 -07:00
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o
+		doublefault.o tsc.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2004-09-02 13:45:15 -07:00
+++ b/arch/i386/kernel/setup.c	2004-09-02 13:45:15 -07:00
@@ -48,6 +48,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/tsc.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -1413,6 +1414,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	tsc_init();
 }
 
 #include "setup_arch_post.h"
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2004-09-02 13:45:15 -07:00
+++ b/arch/i386/kernel/time.c	2004-09-02 13:45:15 -07:00
@@ -412,6 +412,7 @@
 
 void __init time_init(void)
 {
+#ifndef CONFIG_NEWTOD
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_capable()) {
 		/*
@@ -429,6 +430,7 @@
 
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
+#endif
 
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	2004-09-02 13:45:15 -07:00
+++ b/arch/i386/kernel/timers/Makefile	2004-09-02 13:45:15 -07:00
@@ -4,6 +4,6 @@
 
 obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o common.o
 
-obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
+#obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
-obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
+#obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
diff -Nru a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c	2004-09-02 13:45:15 -07:00
+++ b/arch/i386/kernel/timers/common.c	2004-09-02 13:45:15 -07:00
@@ -21,8 +21,6 @@
  * device.
  */
 
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
 unsigned long __init calibrate_tsc(void)
 {
 	mach_prepare_counter();
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	2004-09-02 13:45:15 -07:00
+++ b/arch/i386/kernel/timers/timer.c	2004-09-02 13:45:15 -07:00
@@ -14,13 +14,13 @@
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
 #ifdef CONFIG_X86_CYCLONE_TIMER
-	&timer_cyclone,
+//	&timer_cyclone,
 #endif
 #ifdef CONFIG_HPET_TIMER
 	&timer_hpet,
 #endif
 #ifdef CONFIG_X86_PM_TIMER
-	&timer_pmtmr,
+//	&timer_pmtmr,
 #endif
 	&timer_tsc,
 	&timer_pit,
diff -Nru a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/i386/kernel/tsc.c	2004-09-02 13:45:15 -07:00
@@ -0,0 +1,39 @@
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <asm/tsc.h>
+#include "mach_timer.h"
+
+unsigned long cpu_freq_khz;
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
+	printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+
+}
diff -Nru a/drivers/timesource/Makefile b/drivers/timesource/Makefile
--- a/drivers/timesource/Makefile	2004-09-02 13:45:15 -07:00
+++ b/drivers/timesource/Makefile	2004-09-02 13:45:15 -07:00
@@ -1 +1,6 @@
 obj-y += jiffies.o
+obj-$(CONFIG_X86) += i386_tsc.o
+#obj-$(CONFIG_X86) += i386_pit.o
+obj-$(CONFIG_X86_SUMMIT) += cyclone.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o
+
diff -Nru a/drivers/timesource/acpi_pm.c b/drivers/timesource/acpi_pm.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/acpi_pm.c	2004-09-02 13:45:15 -07:00
@@ -0,0 +1,130 @@
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
+static cycle_t acpi_pm_delta(cycle_t now, cycle_t then)
+{
+	return (now - then) & ACPI_PM_MASK;
+}
+
+static nsec_t acpi_pm_cyc2ns(cycle_t cyc, cycle_t* remainder)
+{
+	/* Power management timer runs at 3.579545 cycles per
+	 * microsecond. Thus it runs at 0.003579545 cyc/nsec which
+	 * inverted is 279.36511 ns/cyc.  Which is ~286070/1024
+	 */
+	u64 cycles = cyc;
+	cycles *= 286070;
+	cycles >>= 10;
+	if(remainder)
+		*remainder = 0;
+	return (nsec_t)cycles;
+}
+
+struct timesource_t timesource_acpi_pm = {
+	.name = "acpi_pm",
+	.priority = 200,
+	.read = acpi_pm_read,
+	.delta = acpi_pm_delta,
+	.cyc2ns = acpi_pm_cyc2ns,
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
+++ b/drivers/timesource/cyclone.c	2004-09-02 13:45:15 -07:00
@@ -0,0 +1,167 @@
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
+static cycle_t cyclone_delta(cycle_t now, cycle_t then)
+{
+	return (now - then)&CYCLONE_TIMER_MASK;
+}
+
+static nsec_t cyclone_cyc2ns(cycle_t cyc, cycle_t* remainder)
+{
+	u64 rem;
+	cyc *= 1000000;
+	rem = do_div(cyc, cyclone_freq_khz);
+	if (remainder)
+		*remainder = rem/1000000; /*XXX - do we still loose precision here? */
+	return (nsec_t)cyc;
+}
+
+struct timesource_t timesource_cyclone = {
+	.name = "cyclone",
+	.priority = 100,
+	.read = cyclone_read,
+	.delta = cyclone_delta,
+	.cyc2ns = cyclone_cyc2ns,
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
+			cyclone_timer = 0;
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
+++ b/drivers/timesource/i386_pit.c	2004-09-02 13:45:15 -07:00
@@ -0,0 +1,99 @@
+/* pit timesource */
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
+++ b/drivers/timesource/i386_tsc.c	2004-09-02 13:45:15 -07:00
@@ -0,0 +1,53 @@
+/* TODO:
+ *		o cpufreq code
+ *		o better calibration
+ */
+
+#include <linux/timesource.h>
+#include "mach_timer.h"
+#include <linux/timex.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <asm/tsc.h>
+
+static cycle_t tsc_read(void)
+{
+	u64 ret;
+	rdtscll(ret);
+	return (cycle_t)ret;
+}
+
+static cycle_t tsc_delta(cycle_t now, cycle_t then)
+{
+	return now - then;
+}
+
+static nsec_t tsc_cyc2ns(cycle_t cyc, cycle_t* remainder)
+{
+	u32 rem;
+	cyc *= 1000000;
+	rem = do_div(cyc, cpu_freq_khz);
+	if(remainder)
+		*remainder = rem/1000000; /*XXX - do we still loose precision here? */
+	return (nsec_t)cyc;
+}
+
+
+static struct timesource_t timesource_tsc = {
+	.name = "tsc",
+	.priority = 25,
+	.read = tsc_read,
+	.delta = tsc_delta,
+	.cyc2ns = tsc_cyc2ns,
+};
+
+
+static int init_tsc_timesource(void)
+{
+	/* All the initialization is done in arch/i386/kernel/tsc.c */
+	if (cpu_has_tsc && cpu_freq_khz)
+		register_timesource(&timesource_tsc);
+	return 0;
+}
+
+module_init(init_tsc_timesource);
diff -Nru a/include/asm-i386/mach-default/mach_timer.h b/include/asm-i386/mach-default/mach_timer.h
--- a/include/asm-i386/mach-default/mach_timer.h	2004-09-02 13:45:15 -07:00
+++ b/include/asm-i386/mach-default/mach_timer.h	2004-09-02 13:45:15 -07:00
@@ -14,8 +14,11 @@
  */
 #ifndef _MACH_TIMER_H
 #define _MACH_TIMER_H
+#include <asm/io.h>
 
-#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_ITERATION 50
+#define CALIBRATE_LATCH	(CALIBRATE_ITERATION * LATCH)
+#define CALIBRATE_TIME	(CALIBRATE_ITERATION * 1000020/HZ)
 
 static inline void mach_prepare_counter(void)
 {
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	2004-09-02 13:45:15 -07:00
+++ b/include/asm-i386/timer.h	2004-09-02 13:45:15 -07:00
@@ -42,7 +42,7 @@
 extern struct timer_opts timer_pit;
 extern struct timer_opts timer_tsc;
 #ifdef CONFIG_X86_CYCLONE_TIMER
-extern struct timer_opts timer_cyclone;
+//extern struct timer_opts timer_cyclone;
 #endif
 
 extern unsigned long calibrate_tsc(void);
@@ -53,6 +53,6 @@
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern struct timer_opts timer_pmtmr;
+//extern struct timer_opts timer_pmtmr;
 #endif
 #endif
diff -Nru a/include/asm-i386/tsc.h b/include/asm-i386/tsc.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/tsc.h	2004-09-02 13:45:15 -07:00
@@ -0,0 +1,6 @@
+#ifndef _ASM_I386_TSC_H
+#define _ASM_I386_TSC_H
+extern unsigned long cpu_freq_khz;
+void tsc_init(void);
+
+#endif



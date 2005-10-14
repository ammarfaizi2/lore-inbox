Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVJNCZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVJNCZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 22:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVJNCZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 22:25:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:15514 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932556AbVJNCZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 22:25:16 -0400
Subject: [RFC][PATCH 12/12] generic timeofday x86-64 arch specific changes
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Frank Sorenson <frank@tuxrocks.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <1129256567.27168.51.camel@cog.beaverton.ibm.com>
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
	 <1129256567.27168.51.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 19:25:12 -0700
Message-Id: <1129256712.27168.54.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch converts the x86-64 arch to use the generic timeofday
infrastructure. It applies ontop of my timeofday-core patch (or ontop of
my i386 cumulative patch). This is a full conversion, so most of this
patch is subtractions removing the existing arch specific time keeping
code. This patch does not provide any x86-64 clocksourcs, so using this
patch alone on top of the timeofday-core patch will only give you the
jiffies clocksource. To get full replacements for the code being removed
here, the following timeofday-clocks-i386 patch (x86-64 shares the same
clocksources as i386) will need to be applied as well.

thanks
-john

 arch/x86_64/kernel/pmtimer.c       |  101 ----------
 b/arch/i386/kernel/acpi/boot.c     |    9 
 b/arch/x86_64/Kconfig              |    8 
 b/arch/x86_64/kernel/Makefile      |    1 
 b/arch/x86_64/kernel/time.c        |  365 ++++---------------------------------
 b/arch/x86_64/kernel/vmlinux.lds.S |    7 
 b/arch/x86_64/kernel/vsyscall.c    |  133 ++++++++++---
 b/include/asm-generic/div64.h      |    9 
 b/include/asm-x86_64/hpet.h        |    3 
 b/include/asm-x86_64/timeofday.h   |    4 
 b/include/asm-x86_64/timex.h       |    4 
 b/include/asm-x86_64/vsyscall.h    |    2 
 12 files changed, 194 insertions(+), 452 deletions(-)

linux-2.6.14-rc4_timeofday-arch-x86-64_B7.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -570,7 +570,7 @@ static int __init acpi_parse_sbf(unsigne
 }
 
 #ifdef CONFIG_HPET_TIMER
-
+#include <asm/hpet.h>
 static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 {
 	struct acpi_table_hpet *hpet_tbl;
@@ -592,6 +592,7 @@ static int __init acpi_parse_hpet(unsign
 #ifdef	CONFIG_X86_64
 	vxtime.hpet_address = hpet_tbl->addr.addrl |
 	    ((long)hpet_tbl->addr.addrh << 32);
+	hpet_address = vxtime.hpet_address;
 
 	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
 	       hpet_tbl->id, vxtime.hpet_address);
@@ -600,10 +601,10 @@ static int __init acpi_parse_hpet(unsign
 		extern unsigned long hpet_address;
 
 		hpet_address = hpet_tbl->addr.addrl;
-		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-		       hpet_tbl->id, hpet_address);
 	}
-#endif				/* X86 */
+#endif	/* X86 */
+		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
+			hpet_tbl->id, hpet_address);
 
 	return 0;
 }
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -24,6 +24,14 @@ config X86
 	bool
 	default y
 
+config GENERICTOD
+       bool
+       default y
+
+config GENERICTOD_VSYSCALL
+       bool
+       default y
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o a
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 
diff --git a/arch/x86_64/kernel/pmtimer.c b/arch/x86_64/kernel/pmtimer.c
deleted file mode 100644
--- a/arch/x86_64/kernel/pmtimer.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/* Ported over from i386 by AK, original copyright was:
- *
- * (C) Dominik Brodowski <linux@brodo.de> 2003
- *
- * Driver to use the Power Management Timer (PMTMR) available in some
- * southbridges as primary timing source for the Linux kernel.
- *
- * Based on parts of linux/drivers/acpi/hardware/hwtimer.c, timer_pit.c,
- * timer_hpet.c, and on Arjan van de Ven's implementation for 2.4.
- *
- * This file is licensed under the GPL v2.
- *
- * Dropped all the hardware bug workarounds for now. Hopefully they
- * are not needed on 64bit chipsets.
- */
-
-#include <linux/jiffies.h>
-#include <linux/kernel.h>
-#include <linux/time.h>
-#include <linux/init.h>
-#include <linux/cpumask.h>
-#include <asm/io.h>
-#include <asm/proto.h>
-#include <asm/msr.h>
-#include <asm/vsyscall.h>
-
-/* The I/O port the PMTMR resides at.
- * The location is detected during setup_arch(),
- * in arch/i386/kernel/acpi/boot.c */
-u32 pmtmr_ioport;
-
-/* value of the Power timer at last timer interrupt */
-static u32 offset_delay;
-static u32 last_pmtmr_tick;
-
-#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
-
-static inline u32 cyc2us(u32 cycles)
-{
-	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
-	 * 1 / PM_TIMER_FREQUENCY == 0.27936511 =~ 286/1024 [error: 0.024%]
-	 *
-	 * Even with HZ = 100, delta is at maximum 35796 ticks, so it can
-	 * easily be multiplied with 286 (=0x11E) without having to fear
-	 * u32 overflows.
-	 */
-	cycles *= 286;
-	return (cycles >> 10);
-}
-
-int pmtimer_mark_offset(void)
-{
-	static int first_run = 1;
-	unsigned long tsc;
-	u32 lost;
-
-	u32 tick = inl(pmtmr_ioport);
-	u32 delta;
-
-	delta = cyc2us((tick - last_pmtmr_tick) & ACPI_PM_MASK);
-
-	last_pmtmr_tick = tick;
-	monotonic_base += delta * NSEC_PER_USEC;
-
-	delta += offset_delay;
-
-	lost = delta / (USEC_PER_SEC / HZ);
-	offset_delay = delta % (USEC_PER_SEC / HZ);
-
-	rdtscll(tsc);
-	vxtime.last_tsc = tsc - offset_delay * cpu_khz;
-
-	/* don't calculate delay for first run,
-	   or if we've got less then a tick */
-	if (first_run || (lost < 1)) {
-		first_run = 0;
-		offset_delay = 0;
-	}
-
-	return lost - 1;
-}
-
-unsigned int do_gettimeoffset_pm(void)
-{
-	u32 now, offset, delta = 0;
-
-	offset = last_pmtmr_tick;
-	now = inl(pmtmr_ioport);
-	delta = (now - offset) & ACPI_PM_MASK;
-
-	return offset_delay + cyc2us(delta);
-}
-
-
-static int __init nopmtimer_setup(char *s)
-{
-	pmtmr_ioport = 0;
-	return 0;
-}
-
-__setup("nopmtimer", nopmtimer_setup);
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -38,6 +38,7 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
+#include <linux/timeofday.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -46,9 +47,6 @@ u64 jiffies_64 = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
 
-#ifdef CONFIG_CPU_FREQ
-static void cpufreq_delayed_get(void);
-#endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
@@ -60,7 +58,9 @@ static int notsc __initdata = 0;
 
 #undef HPET_HACK_ENABLE_DANGEROUS
 
-unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
+unsigned int cpu_khz;					/* CPU clocks / usec, not used here */
+unsigned int tsc_khz;					/* TSC clocks / usec, not used here */
+unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 static int hpet_use_timer;
@@ -83,107 +83,6 @@ static inline void rdtscll_sync(unsigned
 	rdtscll(*tsc);
 }
 
-/*
- * do_gettimeoffset() returns microseconds since last timer interrupt was
- * triggered by hardware. A memory read of HPET is slower than a register read
- * of TSC, but much more reliable. It's also synchronized to the timer
- * interrupt. Note that do_gettimeoffset() may return more than hpet_tick, if a
- * timer interrupt has happened already, but vxtime.trigger wasn't updated yet.
- * This is not a problem, because jiffies hasn't updated either. They are bound
- * together by xtime_lock.
- */
-
-static inline unsigned int do_gettimeoffset_tsc(void)
-{
-	unsigned long t;
-	unsigned long x;
-	rdtscll_sync(&t);
-	if (t < vxtime.last_tsc) t = vxtime.last_tsc; /* hack */
-	x = ((t - vxtime.last_tsc) * vxtime.tsc_quot) >> 32;
-	return x;
-}
-
-static inline unsigned int do_gettimeoffset_hpet(void)
-{
-	/* cap counter read to one tick to avoid inconsistencies */
-	unsigned long counter = hpet_readl(HPET_COUNTER) - vxtime.last;
-	return (min(counter,hpet_tick) * vxtime.quot) >> 32;
-}
-
-unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
-
-/*
- * This version of gettimeofday() has microsecond resolution and better than
- * microsecond precision, as we're using at least a 10 MHz (usually 14.31818
- * MHz) HPET timer.
- */
-
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq, t;
- 	unsigned int sec, usec;
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-
-		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec / 1000;
-
-		/* i386 does some correction here to keep the clock 
-		   monotonous even when ntpd is fixing drift.
-		   But they didn't work for me, there is a non monotonic
-		   clock anyways with ntp.
-		   I dropped all corrections now until a real solution can
-		   be found. Note when you fix it here you need to do the same
-		   in arch/x86_64/kernel/vsyscall.c and export all needed
-		   variables in vmlinux.lds. -AK */ 
-
-		t = (jiffies - wall_jiffies) * (1000000L / HZ) +
-			do_gettimeoffset();
-		usec += t;
-
-	} while (read_seqretry(&xtime_lock, seq));
-
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-/*
- * settimeofday() first undoes the correction that gettimeofday would do
- * on the time, and then saves it. This is ugly, but has been like this for
- * ages already.
- */
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-
-	nsec -= do_gettimeoffset() * 1000 +
-		(jiffies - wall_jiffies) * (NSEC_PER_SEC/HZ);
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
@@ -283,90 +182,8 @@ static void set_rtc_mmss(unsigned long n
 	spin_unlock(&rtc_lock);
 }
 
-
-/* monotonic_clock(): returns # of nanoseconds passed since time_init()
- *		Note: This function is required to return accurate
- *		time even in the absence of multiple timer ticks.
- */
-unsigned long long monotonic_clock(void)
-{
-	unsigned long seq;
- 	u32 last_offset, this_offset, offset;
-	unsigned long long base;
-
-	if (vxtime.mode == VXTIME_HPET) {
-		do {
-			seq = read_seqbegin(&xtime_lock);
-
-			last_offset = vxtime.last;
-			base = monotonic_base;
-			this_offset = hpet_readl(HPET_COUNTER);
-
-		} while (read_seqretry(&xtime_lock, seq));
-		offset = (this_offset - last_offset);
-		offset *=(NSEC_PER_SEC/HZ)/hpet_tick;
-		return base + offset;
-	}else{
-		do {
-			seq = read_seqbegin(&xtime_lock);
-
-			last_offset = vxtime.last_tsc;
-			base = monotonic_base;
-		} while (read_seqretry(&xtime_lock, seq));
-		sync_core();
-		rdtscll(this_offset);
-		offset = (this_offset - last_offset)*1000/cpu_khz; 
-		return base + offset;
-	}
-
-
-}
-EXPORT_SYMBOL(monotonic_clock);
-
-static noinline void handle_lost_ticks(int lost, struct pt_regs *regs)
-{
-    static long lost_count;
-    static int warned;
-
-    if (report_lost_ticks) {
-	    printk(KERN_WARNING "time.c: Lost %d timer "
-		   "tick(s)! ", lost);
-	    print_symbol("rip %s)\n", regs->rip);
-    }
-
-    if (lost_count == 1000 && !warned) {
-	    printk(KERN_WARNING
-		   "warning: many lost ticks.\n"
-		   KERN_WARNING "Your time source seems to be instable or "
-		   		"some driver is hogging interupts\n");
-	    print_symbol("rip %s\n", regs->rip);
-	    if (vxtime.mode == VXTIME_TSC && vxtime.hpet_address) {
-		    printk(KERN_WARNING "Falling back to HPET\n");
-		    vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
-		    vxtime.mode = VXTIME_HPET;
-		    do_gettimeoffset = do_gettimeoffset_hpet;
-	    }
-	    /* else should fall back to PIT, but code missing. */
-	    warned = 1;
-    } else
-	    lost_count++;
-
-#ifdef CONFIG_CPU_FREQ
-    /* In some cases the CPU can change frequency without us noticing
-       (like going into thermal throttle)
-       Give cpufreq a change to catch up. */
-    if ((lost_count+1) % 25 == 0) {
-	    cpufreq_delayed_get();
-    }
-#endif
-}
-
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	static unsigned long rtc_update = 0;
-	unsigned long tsc;
-	int delay, offset = 0, lost = 0;
-
 /*
  * Here we are in the timer irq handler. We have irqs locally disabled (so we
  * don't need spin_lock_irqsave()) but we don't know if the timer_bh is running
@@ -376,67 +193,6 @@ static irqreturn_t timer_interrupt(int i
 
 	write_seqlock(&xtime_lock);
 
-	if (vxtime.hpet_address)
-		offset = hpet_readl(HPET_COUNTER);
-
-	if (hpet_use_timer) {
-		/* if we're using the hpet timer functionality,
-		 * we can more accurately know the counter value
-		 * when the timer interrupt occured.
-		 */
-		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-		delay = hpet_readl(HPET_COUNTER) - offset;
-	} else {
-		spin_lock(&i8253_lock);
-		outb_p(0x00, 0x43);
-		delay = inb_p(0x40);
-		delay |= inb(0x40) << 8;
-		spin_unlock(&i8253_lock);
-		delay = LATCH - 1 - delay;
-	}
-
-	rdtscll_sync(&tsc);
-
-	if (vxtime.mode == VXTIME_HPET) {
-		if (offset - vxtime.last > hpet_tick) {
-			lost = (offset - vxtime.last) / hpet_tick - 1;
-		}
-
-		monotonic_base += 
-			(offset - vxtime.last)*(NSEC_PER_SEC/HZ) / hpet_tick;
-
-		vxtime.last = offset;
-#ifdef CONFIG_X86_PM_TIMER
-	} else if (vxtime.mode == VXTIME_PMTMR) {
-		lost = pmtimer_mark_offset();
-#endif
-	} else {
-		offset = (((tsc - vxtime.last_tsc) *
-			   vxtime.tsc_quot) >> 32) - (USEC_PER_SEC / HZ);
-
-		if (offset < 0)
-			offset = 0;
-
-		if (offset > (USEC_PER_SEC / HZ)) {
-			lost = offset / (USEC_PER_SEC / HZ);
-			offset %= (USEC_PER_SEC / HZ);
-		}
-
-		monotonic_base += (tsc - vxtime.last_tsc)*1000000/cpu_khz ;
-
-		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
-
-		if ((((tsc - vxtime.last_tsc) *
-		      vxtime.tsc_quot) >> 32) < offset)
-			vxtime.last_tsc = tsc -
-				(((long) offset << 32) / vxtime.tsc_quot) - 1;
-	}
-
-	if (lost > 0) {
-		handle_lost_ticks(lost, regs);
-		jiffies += lost;
-	}
-
 /*
  * Do the timer stuff.
  */
@@ -459,25 +215,24 @@ static irqreturn_t timer_interrupt(int i
 		smp_local_timer_interrupt(regs);
 #endif
 
-/*
- * If we have an externally synchronized Linux clock, then update CMOS clock
- * accordingly every ~11 minutes. set_rtc_mmss() will be called in the jiffy
- * closest to exactly 500 ms before the next second. If the update fails, we
- * don't care, as it'll be updated on the next turn, and the problem (time way
- * off) isn't likely to go away much sooner anyway.
- */
-
-	if (ntp_synced() && xtime.tv_sec > rtc_update &&
-		abs(xtime.tv_nsec - 500000000) <= tick_nsec / 2) {
-		set_rtc_mmss(xtime.tv_sec);
-		rtc_update = xtime.tv_sec + 660;
-	}
- 
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
 }
 
+/* Code to compensate for C3 stalls */
+static u64 tsc_c3_offset;
+void tsc_c3_compensate(unsigned long usecs)
+{
+	u64 cycles = (usecs * tsc_khz)/1000;
+	tsc_c3_offset += cycles;
+}
+
+u64 tsc_read_c3_time(void)
+{
+	return tsc_c3_offset;
+}
+
 static unsigned int cyc2ns_scale;
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
@@ -573,6 +328,30 @@ unsigned long get_cmos_time(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+/* arch specific timeofday hooks */
+u64 read_persistent_clock(void)
+{
+	return (u64)get_cmos_time() * NSEC_PER_SEC;
+}
+
+void sync_persistent_clock(struct timespec ts)
+{
+	static unsigned long rtc_update = 0;
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. set_rtc_mmss() will
+	 * be called in the jiffy closest to exactly 500 ms before the
+	 * next second. If the update fails, we don't care, as it'll be
+	 * updated on the next turn, and the problem (time way off) isn't
+	 * likely to go away much sooner anyway.
+	 */
+	if (ts.tv_sec > rtc_update &&
+		abs(ts.tv_nsec - 500000000) <= tick_nsec / 2) {
+		set_rtc_mmss(xtime.tv_sec);
+		rtc_update = xtime.tv_sec + 660;
+	}
+}
+
 #ifdef CONFIG_CPU_FREQ
 
 /* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
@@ -600,23 +379,6 @@ static void handle_cpufreq_delayed_get(v
 	cpufreq_delayed_issched = 0;
 }
 
-/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
- * to verify the CPU frequency the timing core thinks the CPU is running
- * at is still correct.
- */
-static void cpufreq_delayed_get(void)
-{
-	static int warned;
-	if (cpufreq_init && !cpufreq_delayed_issched) {
-		cpufreq_delayed_issched = 1;
-		if (!warned) {
-			warned = 1;
-			printk(KERN_DEBUG "Losing some ticks... checking if CPU frequency changed.\n");
-		}
-		schedule_work(&cpufreq_delayed_get_work);
-	}
-}
-
 static unsigned int  ref_freq = 0;
 static unsigned long loops_per_jiffy_ref = 0;
 
@@ -651,8 +413,11 @@ static int time_cpufreq_notifier(struct 
 		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 
 		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 			vxtime.tsc_quot = (1000L << 32) / cpu_khz;
+			tsc_khz = cpu_khz;
+		}
+
 	}
 	
 	set_cyc2ns_scale(cpu_khz_ref / 1000);
@@ -916,18 +681,12 @@ void __init time_init(void)
 	if (hpet_use_timer) {
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
-#ifdef CONFIG_X86_PM_TIMER
-	} else if (pmtmr_ioport) {
-		vxtime_hz = PM_TIMER_FREQUENCY;
-		timename = "PM";
-		pit_init();
-		cpu_khz = pit_calibrate_tsc();
-#endif
 	} else {
 		pit_init();
 		cpu_khz = pit_calibrate_tsc();
 		timename = "PIT";
 	}
+	tsc_khz = cpu_khz;
 
 	printk(KERN_INFO "time.c: Using %ld.%06ld MHz %s timer.\n",
 	       vxtime_hz / 1000000, vxtime_hz % 1000000, timename);
@@ -950,7 +709,7 @@ void __init time_init(void)
  * Make an educated guess if the TSC is trustworthy and synchronized
  * over all CPUs.
  */
-static __init int unsynchronized_tsc(void)
+int check_tsc_unstable(void)
 {
 #ifdef CONFIG_SMP
 	if (oem_force_hpet_timer())
@@ -969,31 +728,8 @@ static __init int unsynchronized_tsc(voi
  */
 void __init time_init_gtod(void)
 {
-	char *timetype;
-
-	if (unsynchronized_tsc())
+	if (check_tsc_unstable())
 		notsc = 1;
-	if (vxtime.hpet_address && notsc) {
-		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
-		vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
-		vxtime.mode = VXTIME_HPET;
-		do_gettimeoffset = do_gettimeoffset_hpet;
-#ifdef CONFIG_X86_PM_TIMER
-	/* Using PM for gettimeofday is quite slow, but we have no other
-	   choice because the TSC is too unreliable on some systems. */
-	} else if (pmtmr_ioport && !vxtime.hpet_address && notsc) {
-		timetype = "PM";
-		do_gettimeoffset = do_gettimeoffset_pm;
-		vxtime.mode = VXTIME_PMTMR;
-		sysctl_vsyscall = 0;
-		printk(KERN_INFO "Disabling vsyscall due to use of PM timer\n");
-#endif
-	} else {
-		timetype = hpet_use_timer ? "HPET/TSC" : "PIT/TSC";
-		vxtime.mode = VXTIME_TSC;
-	}
-
-	printk(KERN_INFO "time.c: Using %s based timekeeping.\n", timetype);
 }
 
 __setup("report_lost_ticks", time_setup);
@@ -1016,7 +752,6 @@ static int timer_suspend(struct sys_devi
 
 static int timer_resume(struct sys_device *dev)
 {
-	unsigned long flags;
 	unsigned long sec;
 	unsigned long ctime = get_cmos_time();
 	unsigned long sleep_length = (ctime - sleep_start) * HZ;
@@ -1027,10 +762,6 @@ static int timer_resume(struct sys_devic
 		i8254_timer_resume();
 
 	sec = ctime + clock_cmos_diff;
-	write_seqlock_irqsave(&xtime_lock,flags);
-	xtime.tv_sec = sec;
-	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock,flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
 	touch_softlockup_watchdog();
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -99,6 +99,13 @@ SECTIONS
   .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
   jiffies = VVIRT(.jiffies);
 
+  .vsyscall_gtod_data : AT(VLOAD(.vsyscall_gtod_data)) { *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = VVIRT(.vsyscall_gtod_data);
+
+  .vsyscall_gtod_lock : AT(VLOAD(.vsyscall_gtod_lock)) { *(.vsyscall_gtod_lock) }
+  vsyscall_gtod_lock = VVIRT(.vsyscall_gtod_lock);
+
+
   .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1)) { *(.vsyscall_1) }
   .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
   .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -19,6 +19,8 @@
  *  want per guest time just set the kernel.vsyscall64 sysctl to 0.
  */
 
+#include <linux/timeofday.h>
+#include <linux/clocksource.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -40,6 +42,21 @@
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
 seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
 
+
+struct vsyscall_gtod_data_t {
+	struct timeval wall_time_tv;
+	struct timezone sys_tz;
+	cycle_t offset_base;
+	struct clocksource clock;
+};
+
+extern struct vsyscall_gtod_data_t vsyscall_gtod_data;
+struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data;
+
+extern seqlock_t vsyscall_gtod_lock;
+seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
+
+
 #include <asm/unistd.h>
 
 static force_inline void timeval_normalize(struct timeval * tv)
@@ -53,40 +70,54 @@ static force_inline void timeval_normali
 	}
 }
 
-static force_inline void do_vgettimeofday(struct timeval * tv)
+/* XXX - this is ugly. gettimeofday() has a label in it so we can't
+	call it twice.
+ */
+static force_inline int syscall_gtod(struct timeval *tv, struct timezone *tz)
 {
-	long sequence, t;
-	unsigned long sec, usec;
-
+	int ret;
+	asm volatile("syscall"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
+	return ret;
+}
+static force_inline void do_vgettimeofday(struct timeval* tv)
+{
+	cycle_t now, cycle_delta;
+	nsec_t nsec_delta;
+	unsigned long seq;
 	do {
-		sequence = read_seqbegin(&__xtime_lock);
-		
-		sec = __xtime.tv_sec;
-		usec = (__xtime.tv_nsec / 1000) +
-			(__jiffies - __wall_jiffies) * (1000000 / HZ);
-
-		if (__vxtime.mode != VXTIME_HPET) {
-			sync_core();
-			rdtscll(t);
-			if (t < __vxtime.last_tsc)
-				t = __vxtime.last_tsc;
-			usec += ((t - __vxtime.last_tsc) *
-				 __vxtime.tsc_quot) >> 32;
-			/* See comment in x86_64 do_gettimeofday. */
-		} else {
-			usec += ((readl((void *)fix_to_virt(VSYSCALL_HPET) + 0xf0) -
-				  __vxtime.last) * __vxtime.quot) >> 32;
+		seq = read_seqbegin(&__vsyscall_gtod_lock);
+
+		if (__vsyscall_gtod_data.clock.type == CLOCKSOURCE_FUNCTION) {
+			syscall_gtod(tv, NULL);
+			return;
 		}
-	} while (read_seqretry(&__xtime_lock, sequence));
 
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
+		/* read the timeosurce and calc cycle_delta */
+		now = read_clocksource(&__vsyscall_gtod_data.clock);
+		cycle_delta = (now - __vsyscall_gtod_data.offset_base)
+					& __vsyscall_gtod_data.clock.mask;
+
+		/* convert cycles to nsecs */
+		nsec_delta = cycle_delta * __vsyscall_gtod_data.clock.mult;
+		nsec_delta = nsec_delta >> __vsyscall_gtod_data.clock.shift;
+
+		/* add nsec offset to wall_time_tv */
+		*tv = __vsyscall_gtod_data.wall_time_tv;
+		do_div(nsec_delta, NSEC_PER_USEC);
+		tv->tv_usec += (unsigned long) nsec_delta;
+		while (tv->tv_usec > USEC_PER_SEC) {
+			tv->tv_sec += 1;
+			tv->tv_usec -= USEC_PER_SEC;
+		}
+	} while (read_seqretry(&__vsyscall_gtod_lock, seq));
 }
 
 /* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
 static force_inline void do_get_tz(struct timezone * tz)
 {
-	*tz = __sys_tz;
+	*tz = __vsyscall_gtod_data.sys_tz;
 }
 
 static force_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
@@ -122,11 +153,13 @@ int __vsyscall(0) vgettimeofday(struct t
  * unlikely */
 time_t __vsyscall(1) vtime(time_t *t)
 {
+	struct timeval tv;
 	if (unlikely(!__sysctl_vsyscall))
 		return time_syscall(t);
-	else if (t)
-		*t = __xtime.tv_sec;		
-	return __xtime.tv_sec;
+	vgettimeofday(&tv, 0);
+	if (t)
+		*t = tv.tv_sec;
+	return tv.tv_sec;
 }
 
 long __vsyscall(2) venosys_0(void)
@@ -139,6 +172,49 @@ long __vsyscall(3) venosys_1(void)
 	return -ENOSYS;
 }
 
+struct clocksource* curr_clock;
+
+void arch_update_vsyscall_gtod(struct timespec wall_time, cycle_t offset_base,
+				struct clocksource *clock, int ntp_adj)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&vsyscall_gtod_lock, flags);
+
+	/* XXX - hackitty hack hack. this is terrible! */
+	if (curr_clock != clock) {
+		if ((clock->type == CLOCKSOURCE_MMIO_32)
+				|| (clock->type == CLOCKSOURCE_MMIO_64)) {
+			unsigned long vaddr = (unsigned long)clock->mmio_ptr;
+			pgd_t *pgd = pgd_offset_k(vaddr);
+			pud_t *pud = pud_offset(pgd, vaddr);
+			pmd_t *pmd = pmd_offset(pud,vaddr);
+			pte_t *pte = pte_offset_kernel(pmd, vaddr);
+			*pte = pte_mkread(*pte);
+		}
+		curr_clock = clock;
+	}
+
+	/* save off wall time as timeval */
+	vsyscall_gtod_data.wall_time_tv.tv_sec = wall_time.tv_sec;
+	vsyscall_gtod_data.wall_time_tv.tv_usec = wall_time.tv_nsec/1000;
+
+	/* save offset_base */
+	vsyscall_gtod_data.offset_base = offset_base;
+
+	/* copy current clocksource */
+	vsyscall_gtod_data.clock = *clock;
+
+	/* apply ntp adjustment to clocksource mult */
+	vsyscall_gtod_data.clock.mult += ntp_adj;
+
+	/* save off current timezone */
+	vsyscall_gtod_data.sys_tz = sys_tz;
+
+	write_sequnlock_irqrestore(&vsyscall_gtod_lock, flags);
+
+}
+
 #ifdef CONFIG_SYSCTL
 
 #define SYSCALL 0x050f
@@ -217,6 +293,7 @@ static int __init vsyscall_init(void)
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
+	sysctl_vsyscall = 1;
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -55,4 +55,13 @@ extern uint32_t __div64_32(uint64_t *div
 
 #endif /* BITS_PER_LONG */
 
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend,divisor,remainder) \
+({							\
+	u64 result = dividend;				\
+	*remainder = do_div(result,divisor);		\
+	result;						\
+})
+#endif
+
 #endif /* _ASM_GENERIC_DIV64_H */
diff --git a/include/asm-x86_64/hpet.h b/include/asm-x86_64/hpet.h
--- a/include/asm-x86_64/hpet.h
+++ b/include/asm-x86_64/hpet.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_X8664_HPET_H
 #define _ASM_X8664_HPET_H 1
-
+#include <asm/fixmap.h>
 /*
  * Documentation on HPET can be found at:
  *      http://www.intel.com/ial/home/sp/pcmmspec.htm
@@ -44,6 +44,7 @@
 #define HPET_TN_SETVAL		0x040
 #define HPET_TN_32BIT		0x100
 
+extern unsigned long hpet_address;	/* hpet memory map physical address */
 extern int is_hpet_enabled(void);
 extern int hpet_rtc_timer_init(void);
 extern int oem_force_hpet_timer(void);
diff --git a/include/asm-x86_64/timeofday.h b/include/asm-x86_64/timeofday.h
new file mode 100644
--- /dev/null
+++ b/include/asm-x86_64/timeofday.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_64_TIMEOFDAY_H
+#define _ASM_X86_64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -24,6 +24,10 @@ static inline cycles_t get_cycles (void)
 }
 
 extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;
+extern int check_tsc_unstable(void);
+extern void tsc_c3_compensate(unsigned long usecs);
+extern u64 tsc_read_c3_time(void);
 
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
diff --git a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
--- a/include/asm-x86_64/vsyscall.h
+++ b/include/asm-x86_64/vsyscall.h
@@ -22,6 +22,8 @@ enum vsyscall_num {
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
 #define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
 #define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
+#define __section_vsyscall_gtod_data __attribute__ ((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
+#define __section_vsyscall_gtod_lock __attribute__ ((unused, __section__ (".vsyscall_gtod_lock"),aligned(16)))
 
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2



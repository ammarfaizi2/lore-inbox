Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFACOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFACOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFACOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:14:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16639 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261231AbVFACBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:01:43 -0400
Subject: [PATCH (3/4)] new timeofday x86-64 arch specific changes (v. B0)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1117587906.2102.4.camel@cog.beaverton.ibm.com>
References: <1117587813.2102.2.camel@cog.beaverton.ibm.com>
	 <1117587906.2102.4.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 19:01:39 -0700
Message-Id: <1117591300.6801.5.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to CC lkml. Resending.

Andi, All,

	This patch converts the x86-64 arch to use the new timeofday
infrastructure. It applies on top of my timeofday-core_B0 patch. This is
a full conversion, so most of this patch is subtractions removing the
existing arch specific time keeping code. This patch does not provide
any x86-64 timesources, so using this patch alone on top of the
timeofday-core patch will only give you the jiffies timesource. To get
full replacements for the code being removed here, the following
timeofday-timesources-i386 patch (x86-64 shares the same timesources as
i386) will need to be applied.

Andi: I'd like to submit this to Andrew for inclusion into his tree for
testing, however I'd like to get an ACK from you first. Please let me
know if you have any feedback or suggestions.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.12-rc5_timeofday-arch-x86-64_B0.patch
===============================================

Index: arch/i386/kernel/acpi/boot.c
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/i386/kernel/acpi/boot.c  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/arch/i386/kernel/acpi/boot.c  (mode:100644)
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
Index: arch/x86_64/Kconfig
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/x86_64/Kconfig  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/arch/x86_64/Kconfig  (mode:100644)
@@ -24,6 +24,14 @@
 	bool
 	default y
 
+config NEWTOD
+       bool
+       default y
+
+config NEWTOD_VSYSCALL
+       bool
+       default y
+
 config MMU
 	bool
 	default y
Index: arch/x86_64/kernel/Makefile
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/x86_64/kernel/Makefile  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/arch/x86_64/kernel/Makefile  (mode:100644)
@@ -28,7 +28,6 @@
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 
Index: arch/x86_64/kernel/pmtimer.c
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/x86_64/kernel/pmtimer.c  (mode:100644)
+++ /dev/null  (tree:cc17e2e072235a76e4c04af23ef7cb1bc7c4c787)
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
Index: arch/x86_64/kernel/time.c
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/x86_64/kernel/time.c  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/arch/x86_64/kernel/time.c  (mode:100644)
@@ -26,8 +26,6 @@
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <linux/kallsyms.h>
-#include <linux/acpi.h>
-#include <acpi/achware.h>	/* for PM timer frequency */
 #include <asm/8253pit.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
@@ -37,6 +35,7 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
+#include <linux/timeofday.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -45,9 +44,6 @@
 
 EXPORT_SYMBOL(jiffies_64);
 
-#ifdef CONFIG_CPU_FREQ
-static void cpufreq_delayed_get(void);
-#endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
@@ -60,6 +56,7 @@
 #undef HPET_HACK_ENABLE_DANGEROUS
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
+unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 unsigned long vxtime_hz = PIT_TICK_RATE;
@@ -81,108 +78,6 @@
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
-	return ((hpet_readl(HPET_COUNTER) - vxtime.last) * vxtime.quot) >> 32;
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
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
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
@@ -282,90 +177,8 @@
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
-			this_offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
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
@@ -375,60 +188,6 @@
 
 	write_seqlock(&xtime_lock);
 
-	if (vxtime.hpet_address) {
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
@@ -451,20 +210,6 @@
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
-	if ((~time_status & STA_UNSYNC) && xtime.tv_sec > rtc_update &&
-		abs(xtime.tv_nsec - 500000000) <= tick_nsec / 2) {
-		set_rtc_mmss(xtime.tv_sec);
-		rtc_update = xtime.tv_sec + 660;
-	}
- 
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
@@ -565,6 +310,30 @@
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+/* arch specific timeofday hooks */
+nsec_t read_persistent_clock(void)
+{
+	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
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
@@ -592,23 +361,6 @@
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
 
@@ -904,13 +656,6 @@
 			hpet_period;
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
@@ -961,31 +706,8 @@
  */
 void __init time_init_gtod(void)
 {
-	char *timetype;
-
 	if (unsynchronized_tsc())
 		notsc = 1;
-	if (vxtime.hpet_address && notsc) {
-		timetype = "HPET";
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
-		timetype = vxtime.hpet_address ? "HPET/TSC" : "PIT/TSC";
-		vxtime.mode = VXTIME_TSC;
-	}
-
-	printk(KERN_INFO "time.c: Using %s based timekeeping.\n", timetype);
 }
 
 __setup("report_lost_ticks", time_setup);
@@ -1008,7 +730,6 @@
 
 static int timer_resume(struct sys_device *dev)
 {
-	unsigned long flags;
 	unsigned long sec;
 	unsigned long ctime = get_cmos_time();
 	unsigned long sleep_length = (ctime - sleep_start) * HZ;
@@ -1019,10 +740,6 @@
 		i8254_timer_resume();
 
 	sec = ctime + clock_cmos_diff;
-	write_seqlock_irqsave(&xtime_lock,flags);
-	xtime.tv_sec = sec;
-	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock,flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
 	return 0;
Index: arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/x86_64/kernel/vmlinux.lds.S  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/arch/x86_64/kernel/vmlinux.lds.S  (mode:100644)
@@ -71,6 +71,13 @@
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .jiffies : AT CACHE_ALIGN(AFTER(.xtime)) { *(.jiffies) }
   jiffies = LOADADDR(.jiffies);
+
+  .vsyscall_gtod_data : AT AFTER(.jiffies) { *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = LOADADDR(.vsyscall_gtod_data);
+  .vsyscall_gtod_lock : AT AFTER(.vsyscall_gtod_data) { *(.vsyscall_gtod_lock) }
+  vsyscall_gtod_lock = LOADADDR(.vsyscall_gtod_lock);
+
+
   .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT (LOADADDR(.vsyscall_0) + 1024) { *(.vsyscall_1) }
   . = LOADADDR(.vsyscall_0) + 4096;
 
Index: arch/x86_64/kernel/vsyscall.c
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/arch/x86_64/kernel/vsyscall.c  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/arch/x86_64/kernel/vsyscall.c  (mode:100644)
@@ -19,6 +19,8 @@
  *  want per guest time just set the kernel.vsyscall64 sysctl to 0.
  */
 
+#include <linux/timeofday.h>
+#include <linux/timesource.h>
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
+	struct timesource_t timesource;
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
@@ -53,40 +70,54 @@
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
+		if (__vsyscall_gtod_data.timesource.type == TIMESOURCE_FUNCTION) {
+			syscall_gtod(tv, NULL);
+			return;
 		}
-	} while (read_seqretry(&__xtime_lock, sequence));
 
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
+		/* read the timeosurce and calc cycle_delta */
+		now = read_timesource(&__vsyscall_gtod_data.timesource);
+		cycle_delta = (now - __vsyscall_gtod_data.offset_base)
+					& __vsyscall_gtod_data.timesource.mask;
+
+		/* convert cycles to nsecs */
+		nsec_delta = cycle_delta * __vsyscall_gtod_data.timesource.mult;
+		nsec_delta = nsec_delta >> __vsyscall_gtod_data.timesource.shift;
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
@@ -118,15 +149,15 @@
 	return 0;
 }
 
-/* This will break when the xtime seconds get inaccurate, but that is
- * unlikely */
 static time_t __vsyscall(1) vtime(time_t *t)
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
 
 static long __vsyscall(2) venosys_0(void)
@@ -139,6 +170,48 @@
 	return -ENOSYS;
 }
 
+struct timesource_t* curr_timesource;
+
+void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
+				struct timesource_t* timesource, int ntp_adj)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&vsyscall_gtod_lock, flags);
+
+	/* XXX - hackitty hack hack. this is terrible! */
+	if (curr_timesource != timesource) {
+		if ((timesource->type == TIMESOURCE_MMIO_32)
+				|| (timesource->type == TIMESOURCE_MMIO_64)) {
+			unsigned long vaddr = (unsigned long)timesource->mmio_ptr;
+			pgd_t *pgd = pgd_offset_k(vaddr);
+			pud_t *pud = pud_offset(pgd, vaddr);
+			pmd_t *pmd = pmd_offset(pud,vaddr);
+			pte_t *pte = pte_offset_kernel(pmd, vaddr);
+			*pte = pte_mkread(*pte);
+		}
+		curr_timesource = timesource;
+	}
+
+	/* save off wall time as timeval */
+	vsyscall_gtod_data.wall_time_tv = ns_to_timeval(wall_time);
+
+	/* save offset_base */
+	vsyscall_gtod_data.offset_base = offset_base;
+
+	/* copy current timesource */
+	vsyscall_gtod_data.timesource = *timesource;
+
+	/* apply ntp adjustment to timesource mult */
+	vsyscall_gtod_data.timesource.mult += ntp_adj;
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
@@ -217,6 +290,7 @@
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
+	sysctl_vsyscall = 1;
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
Index: include/asm-generic/div64.h
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/include/asm-generic/div64.h  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/include/asm-generic/div64.h  (mode:100644)
@@ -55,4 +55,13 @@
 
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
Index: include/asm-x86_64/hpet.h
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/include/asm-x86_64/hpet.h  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/include/asm-x86_64/hpet.h  (mode:100644)
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
Index: include/asm-x86_64/timeofday.h
===================================================================
--- /dev/null  (tree:6e3d9e6298413e0aed3157cd848724bb12c42554)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/include/asm-x86_64/timeofday.h  (mode:100644)
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_64_TIMEOFDAY_H
+#define _ASM_X86_64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
Index: include/asm-x86_64/vsyscall.h
===================================================================
--- 6e3d9e6298413e0aed3157cd848724bb12c42554/include/asm-x86_64/vsyscall.h  (mode:100644)
+++ cc17e2e072235a76e4c04af23ef7cb1bc7c4c787/include/asm-x86_64/vsyscall.h  (mode:100644)
@@ -22,6 +22,8 @@
 #define __section_sysctl_vsyscall __attribute__ ((unused, __section__ (".sysctl_vsyscall"), aligned(16)))
 #define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
 #define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
+#define __section_vsyscall_gtod_data __attribute__ ((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
+#define __section_vsyscall_gtod_lock __attribute__ ((unused, __section__ (".vsyscall_gtod_lock"),aligned(16)))
 
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2



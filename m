Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVKAWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVKAWgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVKAWgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:36:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:9662 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751359AbVKAWgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:36:44 -0500
Subject: [RFC][PATCH 11/12] generic timeofday x86-64 arch specific changes
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130884504.27168.479.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
	 <1130883849.27168.458.camel@cog.beaverton.ibm.com>
	 <1130883935.27168.461.camel@cog.beaverton.ibm.com>
	 <1130884000.27168.462.camel@cog.beaverton.ibm.com>
	 <1130884065.27168.464.camel@cog.beaverton.ibm.com>
	 <1130884141.27168.467.camel@cog.beaverton.ibm.com>
	 <1130884206.27168.469.camel@cog.beaverton.ibm.com>
	 <1130884288.27168.472.camel@cog.beaverton.ibm.com>
	 <1130884334.27168.473.camel@cog.beaverton.ibm.com>
	 <1130884418.27168.476.camel@cog.beaverton.ibm.com>
	 <1130884504.27168.479.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:36:36 -0800
Message-Id: <1130884596.27168.481.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch converts the x86-64 arch to use the generic timeofday
infrastructure. It applies on top of my timeofday-core  patch. This is a
full conversion, so most of this patch is subtractions removing the
existing arch specific time keeping code. This patch provides only the
TSC and HPET clocksources for x86-64. To get full replacements for the
code being removed here (ACPI PM timer support, specifically), the
following timeofday-clocks-i386 patch will need to be applied.

thanks
-john

 arch/x86_64/kernel/pmtimer.c       |  101 -------
 b/arch/i386/kernel/acpi/boot.c     |    9 
 b/arch/x86_64/Kconfig              |    8 
 b/arch/x86_64/kernel/Makefile      |    1 
 b/arch/x86_64/kernel/time.c        |  522 ++++++++++++++-----------------------
 b/arch/x86_64/kernel/vmlinux.lds.S |   12 
 b/arch/x86_64/kernel/vsyscall.c    |  126 ++++++--
 b/include/asm-generic/div64.h      |    9 
 b/include/asm-x86_64/hpet.h        |    3 
 b/include/asm-x86_64/timeofday.h   |    4 
 b/include/asm-x86_64/timex.h       |    2 
 b/include/asm-x86_64/vsyscall.h    |    8 
 12 files changed, 353 insertions(+), 452 deletions(-)

linux-2.6.14-rc5-mm1_timeofday-arch-x86-64_B9.patch
============================================
diff -ruN linux-2.6-mmtod/arch/i386/kernel/acpi/boot.c mm-fixups/arch/i386/kernel/acpi/boot.c
--- linux-2.6-mmtod/arch/i386/kernel/acpi/boot.c	2005-10-31 18:04:02.000000000 -0800
+++ mm-fixups/arch/i386/kernel/acpi/boot.c	2005-10-31 18:06:40.000000000 -0800
@@ -573,7 +573,7 @@
 }
 
 #ifdef CONFIG_HPET_TIMER
-
+#include <asm/hpet.h>
 static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 {
 	struct acpi_table_hpet *hpet_tbl;
@@ -595,6 +595,7 @@
 #ifdef	CONFIG_X86_64
 	vxtime.hpet_address = hpet_tbl->addr.addrl |
 	    ((long)hpet_tbl->addr.addrh << 32);
+	hpet_address = vxtime.hpet_address;
 
 	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
 	       hpet_tbl->id, vxtime.hpet_address);
@@ -603,10 +604,10 @@
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
diff -ruN linux-2.6-mmtod/arch/x86_64/Kconfig mm-fixups/arch/x86_64/Kconfig
--- linux-2.6-mmtod/arch/x86_64/Kconfig	2005-10-31 17:22:38.000000000 -0800
+++ mm-fixups/arch/x86_64/Kconfig	2005-10-31 18:06:40.000000000 -0800
@@ -24,6 +24,14 @@
 	bool
 	default y
 
+config GENERIC_TIME
+       bool
+       default y
+
+config GENERIC_TIME_VSYSCALL
+       bool
+       default y
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff -ruN linux-2.6-mmtod/arch/x86_64/kernel/Makefile mm-fixups/arch/x86_64/kernel/Makefile
--- linux-2.6-mmtod/arch/x86_64/kernel/Makefile	2005-10-31 17:22:38.000000000 -0800
+++ mm-fixups/arch/x86_64/kernel/Makefile	2005-10-31 18:06:40.000000000 -0800
@@ -30,7 +30,6 @@
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_KGDB)		+= kgdb_stub.o
diff -ruN linux-2.6-mmtod/arch/x86_64/kernel/pmtimer.c mm-fixups/arch/x86_64/kernel/pmtimer.c
--- linux-2.6-mmtod/arch/x86_64/kernel/pmtimer.c	2005-10-31 17:21:58.000000000 -0800
+++ mm-fixups/arch/x86_64/kernel/pmtimer.c	1969-12-31 16:00:00.000000000 -0800
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
diff -ruN linux-2.6-mmtod/arch/x86_64/kernel/time.c mm-fixups/arch/x86_64/kernel/time.c
--- linux-2.6-mmtod/arch/x86_64/kernel/time.c	2005-10-31 17:22:38.000000000 -0800
+++ mm-fixups/arch/x86_64/kernel/time.c	2005-10-31 18:08:28.000000000 -0800
@@ -38,13 +38,11 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
+#include <linux/timeofday.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
 
-#ifdef CONFIG_CPU_FREQ
-static void cpufreq_delayed_get(void);
-#endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
@@ -56,7 +54,9 @@
 
 #undef HPET_HACK_ENABLE_DANGEROUS
 
-unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
+unsigned int cpu_khz;					/* CPU clocks / usec, not used here */
+unsigned int tsc_khz;					/* TSC clocks / usec, not used here */
+unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 static int hpet_use_timer;
@@ -84,107 +84,6 @@
 	return hpet_tick ? hpet_tick : 1;
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
@@ -285,89 +184,8 @@
 }
 
 
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
-		offset *=(NSEC_PER_SEC/HZ)/fixed_hpet_tick();
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
@@ -377,67 +195,6 @@
 
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
-			lost = (offset - vxtime.last) / fixed_hpet_tick() - 1;
-		}
-
-		monotonic_base +=  (offset - vxtime.last)*(NSEC_PER_SEC/HZ) /
-					fixed_hpet_tick();
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
@@ -460,20 +217,6 @@
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
@@ -514,6 +257,29 @@
 	return cycles_2_ns(a);
 }
 
+/* Code to compensate for TSC C3 stalls */
+static u64 tsc_c3_offset;
+static int tsc_unstable;
+static inline int check_tsc_unstable(void)
+{
+	return tsc_unstable;
+}
+static inline void mark_tsc_unstable(void)
+{
+	tsc_unstable = 1;;
+}
+
+void tsc_c3_compensate(unsigned long nsecs)
+{
+	u64 cycles = ((u64)nsecs * tsc_khz)/1000000;
+	tsc_c3_offset += cycles;
+}
+
+static inline u64 tsc_read_c3_time(void)
+{
+	return tsc_c3_offset;
+}
+
 unsigned long get_cmos_time(void)
 {
 	unsigned int timeout, year, mon, day, hour, min, sec;
@@ -574,6 +340,30 @@
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
@@ -601,23 +391,6 @@
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
 
@@ -652,8 +425,11 @@
 		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 
 		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 			vxtime.tsc_quot = (1000L << 32) / cpu_khz;
+			tsc_khz = cpu_khz;
+		}
+
 	}
 	
 	set_cyc2ns_scale(cpu_khz_ref);
@@ -918,18 +694,12 @@
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
@@ -975,31 +745,8 @@
  */
 void __init time_init_gtod(void)
 {
-	char *timetype;
-
 	if (unsynchronized_tsc())
-		notsc = 1;
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
+		mark_tsc_unstable();
 }
 
 __setup("report_lost_ticks", time_setup);
@@ -1022,7 +769,6 @@
 
 static int timer_resume(struct sys_device *dev)
 {
-	unsigned long flags;
 	unsigned long sec;
 	unsigned long ctime = get_cmos_time();
 	unsigned long sleep_length = (ctime - sleep_start) * HZ;
@@ -1033,10 +779,6 @@
 		i8254_timer_resume();
 
 	sec = ctime + clock_cmos_diff;
-	write_seqlock_irqsave(&xtime_lock,flags);
-	xtime.tv_sec = sec;
-	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock,flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
 	touch_softlockup_watchdog();
@@ -1313,3 +1055,152 @@
 __setup("notsc", notsc_setup);
 
 
+/* Clock source code */
+#include <linux/clocksource.h>
+#include <asm/vsyscall.h>
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
+static cycle_t __vsyscall_fn vread_tsc(void* unused)
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
+static struct clocksource clocksource_tsc = {
+	.name = "tsc",
+	.rating = 300,
+	.read = read_tsc,
+	.vread = vread_tsc,
+	.mask = (cycle_t)-1,
+	.mult = 0, /* to be set */
+	.shift = 22,
+	.update_callback = tsc_update_callback,
+	.is_continuous = 1,
+};
+
+
+static int tsc_update_callback(void)
+{
+	int change = 0;
+	/* check to see if we should switch to the safe clocksource */
+	if (tsc_read_c3_time() &&
+		strncmp(clocksource_tsc.name, "c3tsc", 5)) {
+		printk("Falling back to C3 safe TSC\n");
+		clocksource_tsc.read = read_tsc_c3;
+		clocksource_tsc.vread = 0;
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
+	if (!notsc && tsc_khz) {
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
+
+#define HPET_MASK (0xFFFFFFFF)
+#define HPET_SHIFT 22
+
+/* FSEC = 10^-15 NSEC = 10^-9 */
+#define FSEC_PER_NSEC 1000000
+
+
+static void *hpet_ptr;
+
+static cycle_t read_hpet(void)
+{
+	return (cycle_t)readl(hpet_ptr);
+}
+
+static cycle_t __vsyscall_fn vread_hpet(void* ptr)
+{
+	return (cycle_t)readl((void *)fix_to_virt(VSYSCALL_HPET) + 0xf0);
+}
+
+struct clocksource clocksource_hpet = {
+	.name = "hpet",
+	.rating = 250,
+	.read = read_hpet,
+	.vread = vread_hpet,
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
diff -ruN linux-2.6-mmtod/arch/x86_64/kernel/vmlinux.lds.S mm-fixups/arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6-mmtod/arch/x86_64/kernel/vmlinux.lds.S	2005-10-31 17:22:38.000000000 -0800
+++ mm-fixups/arch/x86_64/kernel/vmlinux.lds.S	2005-10-31 18:06:40.000000000 -0800
@@ -99,6 +99,18 @@
   .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
   jiffies = VVIRT(.jiffies);
 
+  .vsyscall_fn :  AT(VLOAD(.vsyscall_fn)) { *(.vsyscall_fn) }
+  .vsyscall_data :  AT(VLOAD(.vsyscall_data)) { *(.vsyscall_data) }
+
+  .vsyscall_gtod_data : AT(VLOAD(.vsyscall_gtod_data)) { *(.vsyscall_gtod_data) }
+  vsyscall_gtod_data = VVIRT(.vsyscall_gtod_data);
+
+  .vsyscall_gtod_lock : AT(VLOAD(.vsyscall_gtod_lock)) { *(.vsyscall_gtod_lock) }
+  vsyscall_gtod_lock = VVIRT(.vsyscall_gtod_lock);
+
+  .vsyscall_fn : AT(VLOAD(.vsyscall_fn)) { *(.vsyscall_fn) }
+  .vsyscall_data : AT(VLOAD(.vsyscall_data)) { *(.vsyscall_data) }
+
   .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1)) { *(.vsyscall_1) }
   .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
   .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
diff -ruN linux-2.6-mmtod/arch/x86_64/kernel/vsyscall.c mm-fixups/arch/x86_64/kernel/vsyscall.c
--- linux-2.6-mmtod/arch/x86_64/kernel/vsyscall.c	2005-10-31 17:21:58.000000000 -0800
+++ mm-fixups/arch/x86_64/kernel/vsyscall.c	2005-10-31 18:06:40.000000000 -0800
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
@@ -53,40 +70,56 @@
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
+		if (!__vsyscall_gtod_data.clock.vread) {
+			syscall_gtod(tv, NULL);
+			return;
 		}
-	} while (read_seqretry(&__xtime_lock, sequence));
 
-	tv->tv_sec = sec + usec / 1000000;
-	tv->tv_usec = usec % 1000000;
+		/* read the timeosurce and calc cycle_delta */
+		now = __vsyscall_gtod_data.clock.vread(
+				__vsyscall_gtod_data.clock.vdata);
+
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
@@ -122,11 +155,13 @@
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
@@ -139,6 +174,40 @@
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
@@ -217,6 +286,7 @@
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	map_vsyscall();
+	sysctl_vsyscall = 1;
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
diff -ruN linux-2.6-mmtod/include/asm-generic/div64.h mm-fixups/include/asm-generic/div64.h
--- linux-2.6-mmtod/include/asm-generic/div64.h	2005-10-31 17:22:01.000000000 -0800
+++ mm-fixups/include/asm-generic/div64.h	2005-10-31 18:06:40.000000000 -0800
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
diff -ruN linux-2.6-mmtod/include/asm-x86_64/hpet.h mm-fixups/include/asm-x86_64/hpet.h
--- linux-2.6-mmtod/include/asm-x86_64/hpet.h	2005-10-31 17:22:41.000000000 -0800
+++ mm-fixups/include/asm-x86_64/hpet.h	2005-10-31 18:06:40.000000000 -0800
@@ -1,6 +1,6 @@
 #ifndef _ASM_X8664_HPET_H
 #define _ASM_X8664_HPET_H 1
-
+#include <asm/fixmap.h>
 /*
  * Documentation on HPET can be found at:
  *      http://www.intel.com/ial/home/sp/pcmmspec.htm
@@ -51,6 +51,7 @@
 
 #define HPET_TN_ROUTE_SHIFT	9
 
+extern unsigned long hpet_address;	/* hpet memory map physical address */
 extern int is_hpet_enabled(void);
 extern int hpet_rtc_timer_init(void);
 extern int oem_force_hpet_timer(void);
diff -ruN linux-2.6-mmtod/include/asm-x86_64/timeofday.h mm-fixups/include/asm-x86_64/timeofday.h
--- linux-2.6-mmtod/include/asm-x86_64/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ mm-fixups/include/asm-x86_64/timeofday.h	2005-10-31 18:06:40.000000000 -0800
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_64_TIMEOFDAY_H
+#define _ASM_X86_64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -ruN linux-2.6-mmtod/include/asm-x86_64/timex.h mm-fixups/include/asm-x86_64/timex.h
--- linux-2.6-mmtod/include/asm-x86_64/timex.h	2005-10-31 17:22:06.000000000 -0800
+++ mm-fixups/include/asm-x86_64/timex.h	2005-10-31 18:06:40.000000000 -0800
@@ -24,6 +24,8 @@
 }
 
 extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;
+extern void tsc_c3_compensate(unsigned long usecs);
 
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
diff -ruN linux-2.6-mmtod/include/asm-x86_64/vsyscall.h mm-fixups/include/asm-x86_64/vsyscall.h
--- linux-2.6-mmtod/include/asm-x86_64/vsyscall.h	2005-10-31 17:22:06.000000000 -0800
+++ mm-fixups/include/asm-x86_64/vsyscall.h	2005-10-31 18:06:40.000000000 -0800
@@ -14,7 +14,7 @@
 #define VSYSCALL_ADDR(vsyscall_nr) (VSYSCALL_START+VSYSCALL_SIZE*(vsyscall_nr))
 
 #ifdef __KERNEL__
-
+/* XXX - All of these are unused w/ CONFIG_GENERIC_TIME and should be removed */
 #define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
 #define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies"), aligned(16)))
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
@@ -23,6 +23,12 @@
 #define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
 #define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(16)))
 
+/* Definitions for CONFIG_GENERIC_TIME definitions */
+#define __section_vsyscall_gtod_data __attribute__ ((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
+#define __section_vsyscall_gtod_lock __attribute__ ((unused, __section__ (".vsyscall_gtod_lock"),aligned(16)))
+#define __vsyscall_fn __attribute__ ((unused,__section__(".vsyscall_fn")))
+#define __vsyscall_data __attribute__ ((unused,__section__(".vsyscall_data")))
+
 #define VXTIME_TSC	1
 #define VXTIME_HPET	2
 #define VXTIME_PMTMR	3



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTFKShb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTFKSha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:37:30 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:56495 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263574AbTFKSgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:36:52 -0400
Subject: [PATCH] New x86_64 time code for 2.5.70
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: ak@suse.de, vojtech@suse.cz
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-miDEQXbCJ5tXjgdu0INz"
Message-Id: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 11:50:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-miDEQXbCJ5tXjgdu0INz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The time code for x86-64 in 2.5.70 isout of date and wildly unstable,
setting the clock to the year 1,115,117 (!) during boot about 60% of the
time.  This subsequently causes other pieces of completely unrelated
userspace software to crash randomly for no obvious reason once the
system comes up.

I've forward-ported Vojtech's time code from 2.4, fixing some locking
along the way.  The new code supports using the AMD8111 HPET for time
calculations.  It also works stably with the PIT/TSC on every boot,
which is the source of the time problems in current 2.5.

Right now, the only known problem is with the fixup of jiffies if a
timer interrupt is lost, which I've hence turned off.  There's
preliminary support for using HPET for the gettimeofday vsyscall, but
since vsyscalls are disabled on x86-64 for now, that's obviously
untested.

	<b

 arch/x86_64/Kconfig              |   12 +
 arch/x86_64/kernel/acpi/boot.c   |    6
 arch/x86_64/kernel/apic.c        |    8 +
 arch/x86_64/kernel/smpboot.c     |   11 +
 arch/x86_64/kernel/time.c        |  253 ++++++++++++++++++++++++++++++++++----- arch/x86_64/kernel/vsyscall.c    |   16 +-
 arch/x86_64/vmlinux.lds.S        |    6
 include/asm-x86_64/fixmap.h      |    2
 include/asm-x86_64/mc146818rtc.h |    5
 include/asm-x86_64/timex.h       |   30 ++++
 include/asm-x86_64/vsyscall.h    |   18 +-
 11 files changed, 315 insertions(+), 52 deletions(-)

--=-miDEQXbCJ5tXjgdu0INz
Content-Disposition: attachment; filename=x86-64-time-2.5.70.patch
Content-Type: text/plain; name=x86-64-time-2.5.70.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.5/arch/x86_64/vmlinux.lds.S	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/vmlinux.lds.S	2003-06-10 10:49:42.000000000 -0700
@@ -50,10 +50,10 @@
   .xtime_lock : AT ((LOADADDR(.vsyscall_0) + SIZEOF(.vsyscall_0) + 63) & ~(63)) { *(.xtime_lock) }
   xtime_lock = LOADADDR(.xtime_lock);
   . = ALIGN(16);
-  .hpet : AT ((LOADADDR(.xtime_lock) + SIZEOF(.xtime_lock) + 15) & ~(15)) { *(.hpet) }
-  hpet = LOADADDR(.hpet);
+  .vxtime : AT ((LOADADDR(.xtime_lock) + SIZEOF(.xtime_lock) + 15) & ~(15)) { *(.vxtime) }
+  vxtime = LOADADDR(.vxtime);
   . = ALIGN(16);
-  .wall_jiffies : AT ((LOADADDR(.hpet) + SIZEOF(.hpet) + 15) & ~(15)) { *(.wall_jiffies) }
+  .wall_jiffies : AT ((LOADADDR(.vxtime) + SIZEOF(.vxtime) + 15) & ~(15)) { *(.wall_jiffies) }
   wall_jiffies = LOADADDR(.wall_jiffies);
   . = ALIGN(16);
   .sys_tz : AT ((LOADADDR(.wall_jiffies) + SIZEOF(.wall_jiffies) + 15) & ~(15)) { *(.sys_tz) }
--- linux-2.5/arch/x86_64/kernel/apic.c	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/kernel/apic.c	2003-06-11 10:26:47.000000000 -0700
@@ -690,7 +690,13 @@
 	} 
 
 	/* wait for irq slice */
-	{
+	if (vxtime.hpet_address) {
+		int trigger = hpet_readl(HPET_T0_CMP);
+		while (hpet_readl(HPET_COUNTER) >= trigger)
+			/* do nothing */ ;
+		while (hpet_readl(HPET_COUNTER) <  trigger)
+			/* do nothing */ ;
+	} else {
 		int c1, c2;
 		outb_p(0x00, 0x43);
 		c2 = inb_p(0x40);
--- linux-2.5/include/asm-x86_64/fixmap.h	2003-06-11 11:43:32.000000000 -0700
+++ x86-64-2.5/include/asm-x86_64/fixmap.h	2003-06-09 15:50:07.000000000 -0700
@@ -35,6 +35,8 @@
 enum fixed_addresses {
 	VSYSCALL_LAST_PAGE,
 	VSYSCALL_FIRST_PAGE = VSYSCALL_LAST_PAGE + ((VSYSCALL_END-VSYSCALL_START) >> PAGE_SHIFT) - 1,
+	VSYSCALL_HPET,
+	FIX_HPET_BASE,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
--- linux-2.5/arch/x86_64/kernel/acpi/boot.c	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/kernel/acpi/boot.c	2003-06-10 10:36:47.000000000 -0700
@@ -244,9 +244,11 @@
 		return -1;
 	}
 
-	hpet.address = hpet_tbl->addr.addrl | ((long) hpet_tbl->addr.addrh << 32);
+	vxtime.hpet_address = hpet_tbl->addr.addrl |
+		((long) hpet_tbl->addr.addrh << 32);
 
-	printk(KERN_INFO "acpi: HPET id: %#x base: %#lx\n", hpet_tbl->id, hpet.address);
+	printk(KERN_INFO "acpi: HPET id: %#x base: %#lx\n",
+	       hpet_tbl->id, vxtime.hpet_address);
 
 	return 0;
 } 
--- linux-2.5/include/asm-x86_64/mc146818rtc.h	2003-06-11 11:43:32.000000000 -0700
+++ x86-64-2.5/include/asm-x86_64/mc146818rtc.h	2003-06-09 15:50:45.000000000 -0700
@@ -24,6 +24,11 @@
 outb_p((val),RTC_PORT(1)); \
 })
 
+#ifndef CONFIG_HPET_TIMER
 #define RTC_IRQ 8
+#else
+/* Temporary workaround due to IRQ routing problem. */
+#define RTC_IRQ 0
+#endif
 
 #endif /* _ASM_MC146818RTC_H */
--- linux-2.5/include/asm-x86_64/timex.h	2003-06-11 11:43:32.000000000 -0700
+++ x86-64-2.5/include/asm-x86_64/timex.h	2003-06-10 10:48:06.000000000 -0700
@@ -30,6 +30,34 @@
 
 extern unsigned int cpu_khz;
 
-extern struct hpet_data hpet;
+/*
+ * Documentation on HPET can be found at:
+ *      http://www.intel.com/ial/home/sp/pcmmspec.htm
+ *      ftp://download.intel.com/ial/home/sp/mmts098.pdf
+ */
+
+#define HPET_ID		0x000
+#define HPET_PERIOD	0x004
+#define HPET_CFG	0x010
+#define HPET_STATUS	0x020
+#define HPET_COUNTER	0x0f0
+#define HPET_T0_CFG	0x100
+#define HPET_T0_CMP	0x108
+#define HPET_T0_ROUTE	0x110
+
+#define HPET_ID_VENDOR	0xffff0000
+#define HPET_ID_LEGSUP	0x00008000
+#define HPET_ID_NUMBER	0x00000f00
+#define HPET_ID_REV	0x000000ff
+
+#define HPET_CFG_ENABLE	0x001
+#define HPET_CFG_LEGACY	0x002
+
+#define HPET_T0_ENABLE		0x004
+#define HPET_T0_PERIODIC	0x008
+#define HPET_T0_SETVAL		0x040
+#define HPET_T0_32BIT		0x100
+
+extern struct vxtime_data vxtime;
 
 #endif
--- linux-2.5/arch/x86_64/kernel/time.c	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/kernel/time.c	2003-06-11 10:20:49.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/bcd.h>
+#include <asm/pgtable.h>
 #include <asm/vsyscall.h>
 #include <asm/timex.h>
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -35,41 +36,59 @@
 extern int using_apic_timer;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 
 extern int using_apic_timer;
 extern void smp_local_timer_interrupt(struct pt_regs * regs);
 
+#undef HPET_HACK_ENABLE_DANGEROUS
+
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 unsigned long hpet_period;				/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
-int hpet_report_lost_ticks;				/* command line option */
+unsigned long vxtime_hz = 1193182;
+int report_lost_ticks;				/* command line option */
 
-struct hpet_data __hpet __section_hpet;			/* address, quotient, trigger, hz */
+struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
 volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
 unsigned long __wall_jiffies __section_wall_jiffies = INITIAL_JIFFIES;
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
 
+static inline void rdtscll_sync(unsigned long *tsc)
+{
+	sync_core();
+	rdtscll(*tsc);
+}
+
 /*
  * do_gettimeoffset() returns microseconds since last timer interrupt was
  * triggered by hardware. A memory read of HPET is slower than a register read
  * of TSC, but much more reliable. It's also synchronized to the timer
  * interrupt. Note that do_gettimeoffset() may return more than hpet_tick, if a
- * timer interrupt has happened already, but hpet.trigger wasn't updated yet.
+ * timer interrupt has happened already, but vxtime.trigger wasn't updated yet.
  * This is not a problem, because jiffies hasn't updated either. They are bound
  * together by xtime_lock.
          */
 
-inline unsigned int do_gettimeoffset(void)
+static inline unsigned int do_gettimeoffset_tsc(void)
 {
 	unsigned long t;
-	sync_core();
-	rdtscll(t);	
-	return (t  - hpet.last_tsc) * (1000000L / HZ) / hpet.ticks + hpet.offset;
+	unsigned long x;
+	rdtscll_sync(&t);
+	x = ((t - vxtime.last_tsc) * vxtime.tsc_quot) >> 32;
+	return x;
 }
 
+static inline unsigned int do_gettimeoffset_hpet(void)
+{
+	return ((hpet_readl(HPET_COUNTER) - vxtime.last) * vxtime.quot) >> 32;
+}
+
+unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
+
 /*
  * This version of gettimeofday() has microsecond resolution and better than
  * microsecond precision, as we're using at least a 10 MHz (usually 14.31818
@@ -87,7 +106,8 @@
 		sec = xtime.tv_sec;
 		usec = xtime.tv_nsec / 1000;
 
-		t = (jiffies - wall_jiffies) * (1000000L / HZ) + do_gettimeoffset();
+		t = (jiffies - wall_jiffies) * (1000000L / HZ) +
+			do_gettimeoffset();
 		usec += t;
 
 	} while (read_seqretry(&xtime_lock, seq));
@@ -178,8 +198,8 @@
 		CMOS_WRITE(real_seconds, RTC_SECONDS);
 		CMOS_WRITE(real_minutes, RTC_MINUTES);
 	} else
-		printk(KERN_WARNING "time.c: can't update CMOS clock from %d to %d\n",
-		       cmos_minutes, real_minutes);
+		printk(KERN_WARNING "time.c: can't update CMOS clock "
+		       "from %d to %d\n", cmos_minutes, real_minutes);
 
 /*
  * The following flags have to be released exactly in this order, otherwise the
@@ -198,6 +218,9 @@
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	static unsigned long rtc_update = 0;
+	unsigned long tsc, lost = 0;
+	int delay, offset = 0;
+	static unsigned long call;
 
 /*
  * Here we are in the timer irq handler. We have irqs locally disabled (so we
@@ -208,17 +231,53 @@
 
 	write_seqlock(&xtime_lock);
 
-	{
-		unsigned long t;
+	if (vxtime.hpet_address) {
+		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+		delay = hpet_readl(HPET_COUNTER) - offset;
+	} else {
+		spin_lock(&i8253_lock);
+		outb_p(0x00, 0x43);
+		delay = inb_p(0x40);
+		delay |= inb(0x40) << 8;
+		spin_unlock(&i8253_lock);
+		delay = LATCH - 1 - delay;
+	}
 
-		sync_core();
-		rdtscll(t);
-		hpet.offset = (t  - hpet.last_tsc) * (1000000L / HZ) / hpet.ticks + hpet.offset - 1000000L / HZ;
-		if (hpet.offset >= 1000000L / HZ)
-			hpet.offset = 0;
-		hpet.ticks = min_t(long, max_t(long, (t  - hpet.last_tsc) * (1000000L / HZ) / (1000000L / HZ - hpet.offset),
-				cpu_khz * 1000/HZ * 15 / 16), cpu_khz * 1000/HZ * 16 / 15); 
-		hpet.last_tsc = t;
+	rdtscll_sync(&tsc);
+
+	if (vxtime.mode == VXTIME_HPET) {
+		if (offset - vxtime.last > hpet_tick) {
+			lost = (offset - vxtime.last) / hpet_tick - 1;
+		}
+
+		vxtime.last = offset;
+	} else {
+		offset = (((tsc - vxtime.last_tsc) *
+			   vxtime.tsc_quot) >> 32) - tick_usec;
+
+		if (offset > tick_usec) {
+			lost = offset / tick_usec;
+			offset %= tick_usec;
+		}
+
+		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
+
+		if ((((tsc - vxtime.last_tsc) *
+		      vxtime.tsc_quot) >> 32) < offset)
+			vxtime.last_tsc = tsc -
+				(((long) offset << 32) / vxtime.tsc_quot) - 1;
+	}
+
+	if (lost) {
+		if (report_lost_ticks)
+			printk(KERN_WARNING "time.c: Lost %ld timer "
+			       "tick(s)! (rip %016lx)\n",
+			       (offset - vxtime.last) / hpet_tick - 1,
+			       regs->rip);
+		// XXX The accounting of lost ticks is way off right
+		// now. -bos
+
+		// jiffies += lost;
 	}
 
 /*
@@ -244,7 +303,7 @@
  * If we have an externally synchronized Linux clock, then update CMOS clock
  * accordingly every ~11 minutes. set_rtc_mmss() will be called in the jiffy
  * closest to exactly 500 ms before the next second. If the update fails, we
- * don'tcare, as it'll be updated on the next turn, and the problem (time way
+ * don't care, as it'll be updated on the next turn, and the problem (time way
  * off) isn't likely to go away much sooner anyway.
  */
 
@@ -254,6 +313,8 @@
 		rtc_update = xtime.tv_sec + 660;
 	}
  
+	call++;
+
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
@@ -263,6 +324,7 @@
 {
 	unsigned int timeout, year, mon, day, hour, min, sec;
 	unsigned char last, this;
+	unsigned long flags;
 
 /*
  * The Linux interpretation of the CMOS clock register contents: When the
@@ -272,7 +334,7 @@
  * standard 8.3 MHz ISA bus.
  */
 
-	spin_lock(&rtc_lock); 
+	spin_lock_irqsave(&rtc_lock, flags);
 
 	timeout = 1000000;
 	last = this = 0;
@@ -295,7 +357,7 @@
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
 
-	spin_unlock(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 /*
  * We know that x86-64 always uses BCD format, no need to check the config
@@ -326,6 +388,32 @@
 
 #define TICK_COUNT 100000000
 
+static unsigned int __init hpet_calibrate_tsc(void)
+{
+	int tsc_start, hpet_start;
+	int tsc_now, hpet_now;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	local_irq_disable();
+
+	hpet_start = hpet_readl(HPET_COUNTER);
+	rdtscl(tsc_start);
+
+	do {
+		local_irq_disable();
+		hpet_now = hpet_readl(HPET_COUNTER);
+		sync_core();
+		rdtscl(tsc_now);
+		local_irq_restore(flags);
+	} while ((tsc_now - tsc_start) < TICK_COUNT &&
+		 (hpet_now - hpet_start) < TICK_COUNT);
+
+	return (tsc_now - tsc_start) * 1000000000L
+		/ ((hpet_now - hpet_start) * hpet_period / 1000);
+}
+
+
 /*
  * pit_calibrate_tsc() uses the speaker output (channel 2) of
  * the PIT. This is better than using the timer interrupt output,
@@ -344,6 +432,8 @@
 	local_irq_save(flags);
 	local_irq_disable();
 
+	spin_lock_irqsave(&i8253_lock, flags);
+
 	outb(0xb0, 0x43);
 	outb((1193182 / (1000 / 50)) & 0xff, 0x42);
 	outb((1193182 / (1000 / 50)) >> 8, 0x42);
@@ -353,42 +443,145 @@
 	sync_core();
 	rdtscll(end);
 
-
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
 	
 	return (end - start) / 50;
 }
 
+static int hpet_init(void)
+{
+	unsigned int cfg, id;
+
+	if (!vxtime.hpet_address)
+		return -1;
+	set_fixmap_nocache(FIX_HPET_BASE, vxtime.hpet_address);
+
+/*
+ * Read the period, compute tick and quotient.
+ */
+
+	id = hpet_readl(HPET_ID);
+
+	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
+	    !(id & HPET_ID_LEGSUP))
+		return -1;
+
+	hpet_period = hpet_readl(HPET_PERIOD);
+	if (hpet_period < 100000 || hpet_period > 100000000)
+		return -1;
+
+	hpet_tick = (tick_nsec + hpet_period / 2) / hpet_period;
+
+/*
+ * Stop the timers and reset the main counter.
+ */
+
+	cfg = hpet_readl(HPET_CFG);
+	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
+	hpet_writel(cfg, HPET_CFG);
+	hpet_writel(0, HPET_COUNTER);
+	hpet_writel(0, HPET_COUNTER + 4);
+
+/*
+ * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
+ * and period also hpet_tick.
+ */
+
+	hpet_writel(HPET_T0_ENABLE | HPET_T0_PERIODIC | HPET_T0_SETVAL |
+		    HPET_T0_32BIT, HPET_T0_CFG);
+	hpet_writel(hpet_tick, HPET_T0_CMP);
+	hpet_writel(hpet_tick, HPET_T0_CMP);
+
+/*
+ * Go!
+ */
+
+	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+	hpet_writel(cfg, HPET_CFG);
+
+	return 0;
+}
+
 void __init pit_init(void)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34, 0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
 	outb_p(LATCH & 0xff, 0x40);	/* LSB */
 	outb_p(LATCH >> 8, 0x40);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
 int __init time_setup(char *str)
 {
-	hpet_report_lost_ticks = 1;
+	report_lost_ticks = 1;
 	return 1;
 }
 
-static struct irqaction irq0 = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+static struct irqaction irq0 = {
+	timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL
+};
 
 extern void __init config_acpi_tables(void);
 
 void __init time_init(void)
 {
+	char *timename;
+
+#ifdef HPET_HACK_ENABLE_DANGEROUS
+        if (!vxtime.hpet_address) {
+		printk(KERN_WARNING "time.c: WARNING: Enabling HPET base "
+		       "manually!\n");
+                outl(0x800038a0, 0xcf8);
+                outl(0xff000001, 0xcfc);
+                outl(0x800038a0, 0xcf8);
+                hpet_address = inl(0xcfc) & 0xfffffffe;
+		printk(KERN_WARNING "time.c: WARNING: Enabled HPET "
+		       "at %#lx.\n", hpet_address);
+        }
+#endif
+
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
 
+	if (!hpet_init()) {
+                vxtime_hz = (1000000000000000L + hpet_period / 2) /
+			hpet_period;
+		cpu_khz = hpet_calibrate_tsc();
+		timename = "HPET";
+	} else {
 	pit_init();
-	printk(KERN_INFO "time.c: Using 1.1931816 MHz PIT timer.\n");
 	cpu_khz = pit_calibrate_tsc();
+		timename = "PIT";
+	}
+
+	printk(KERN_INFO "time.c: Using %ld.%06ld MHz %s timer.\n",
+	       vxtime_hz / 1000000, vxtime_hz % 1000000, timename);
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
-	hpet.ticks = cpu_khz * (1000 / HZ);
-	rdtscll(hpet.last_tsc);
+	vxtime.mode = VXTIME_TSC;
+	vxtime.quot = (1000000L << 32) / vxtime_hz;
+	vxtime.tsc_quot = (1000L << 32) / cpu_khz;
+	vxtime.hz = vxtime_hz;
+	rdtscll_sync(&vxtime.last_tsc);
 	setup_irq(0, &irq0);
 }
 
+void __init time_init_smp(void)
+{
+	char *timetype;
+
+	if (vxtime.hpet_address) {
+		timetype = "HPET";
+		vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
+		vxtime.mode = VXTIME_HPET;
+		do_gettimeoffset = do_gettimeoffset_hpet;
+	} else {
+		timetype = "PIT/TSC";
+		vxtime.mode = VXTIME_TSC;
+	}
+	printk(KERN_INFO "time.c: Using %s based timekeeping.\n", timetype);
+}
+
 __setup("report_lost_ticks", time_setup);
--- linux-2.5/arch/x86_64/kernel/vsyscall.c	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/kernel/vsyscall.c	2003-06-10 10:46:18.000000000 -0700
@@ -78,13 +78,21 @@
 	do {
 		sequence = read_seqbegin(&__xtime_lock);
 		
-		sync_core();
-		rdtscll(t);
 		sec = __xtime.tv_sec;
 		usec = (__xtime.tv_nsec / 1000) +
-			(__jiffies - __wall_jiffies) * (1000000 / HZ) +
-			(t  - __hpet.last_tsc) * (1000000 / HZ) / __hpet.ticks + __hpet.offset;
+			(__jiffies - __wall_jiffies) * (1000000 / HZ);
 
+		if (__vxtime.mode == VXTIME_TSC) {
+			sync_core();
+			rdtscll(t);
+			usec += ((t - __vxtime.last_tsc) *
+				 __vxtime.tsc_quot) >> 32;
+		} else {
+#if 0
+			usec += ((readl(fix_to_virt(VSYSCALL_HPET) + 0xf0) -
+				  __vxtime.last) * __vxtime.quot) >> 32;
+#endif
+		}
 	} while (read_seqretry(&__xtime_lock, sequence));
 
 	tv->tv_sec = sec + usec / 1000000;
--- linux-2.5/arch/x86_64/Kconfig	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/Kconfig	2003-06-11 10:39:45.000000000 -0700
@@ -52,6 +52,18 @@
 	  klogd/syslogd or the X server. You should normally N here, unless
 	  you want to debug such a crash.
 	  
+config HPET_TIMER
+	bool
+	default n
+	help
+	  Use the IA-PC HPET (High Precision Event Timer) to manage
+	  time in preference to the PIT and RTC, if a HPET is
+	  present.  The HPET provides a stable time base on SMP
+	  systems, unlike the RTC, but it is more expensive to access,
+	  as it is off-chip.  You can find the HPET spec at
+	  <http://www.intel.com/labs/platcomp/hpet/hpetspec.htm>.
+
+	  If unsure, say Y.
 
 config GENERIC_ISA_DMA
 	bool
--- linux-2.5/include/asm-x86_64/vsyscall.h	2003-06-11 11:43:32.000000000 -0700
+++ x86-64-2.5/include/asm-x86_64/vsyscall.h	2003-06-11 10:21:35.000000000 -0700
@@ -15,7 +15,7 @@
 
 #ifdef __KERNEL__
 
-#define __section_hpet __attribute__ ((unused, __section__ (".hpet"), aligned(16)))
+#define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
 #define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies"), aligned(16)))
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
 #define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
@@ -23,22 +23,24 @@
 #define __section_xtime __attribute__ ((unused, __section__ (".xtime"), aligned(16)))
 #define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock"), aligned(L1_CACHE_BYTES)))
 
+#define VXTIME_TSC	1
+#define VXTIME_HPET	2
 
-struct hpet_data {
-	long address;		/* base address */
+struct vxtime_data {
+	long hpet_address;	/* HPET base address */
 	unsigned long hz;	/* HPET clocks / sec */
-	int trigger;		/* value at last interrupt */
 	int last;
-	int offset;
 	unsigned long last_tsc;
-	long ticks;
+	long quot;
+	long tsc_quot;
+	int mode;
 };
 
 #define hpet_readl(a)           readl(fix_to_virt(FIX_HPET_BASE) + a)
 #define hpet_writel(d,a)        writel(d, fix_to_virt(FIX_HPET_BASE) + a)
 
 /* vsyscall space (readonly) */
-extern struct hpet_data __hpet;
+extern struct vxtime_data __vxtime;
 extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
 extern unsigned long __wall_jiffies;
@@ -46,7 +48,7 @@
 extern seqlock_t __xtime_lock;
 
 /* kernel space (writeable) */
-extern struct hpet_data hpet;
+extern struct vxtime_data vxtime;
 extern unsigned long wall_jiffies;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
--- linux-2.5/arch/x86_64/kernel/smpboot.c	2003-06-11 11:43:09.000000000 -0700
+++ x86-64-2.5/arch/x86_64/kernel/smpboot.c	2003-06-10 12:30:52.000000000 -0700
@@ -67,6 +67,8 @@
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
+extern void time_init_smp(void);
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -760,7 +762,7 @@
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
-		return;
+		goto smp_done;
 	}
 
 	/*
@@ -784,7 +786,7 @@
 		cpu_online_map = phys_cpu_present_map = 1;
 		phys_cpu_present_map = 1;
 		disable_apic = 1;
-		return;
+		goto smp_done;
 	}
 
 	verify_local_APIC();
@@ -799,7 +801,7 @@
 		cpu_online_map = phys_cpu_present_map = 1;
 		phys_cpu_present_map = 1;
 		disable_apic = 1;
-		return;
+		goto smp_done;
 	}
 
 	connect_bsp_APIC();
@@ -883,6 +885,9 @@
 	 */
 	if (cpu_has_tsc && cpucount)
 		synchronize_tsc_bp();
+
+ smp_done:
+	time_init_smp();
 }
 
 /* These are wrappers to interface to the new boot process.  Someone

--=-miDEQXbCJ5tXjgdu0INz--


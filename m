Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbTFLVD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbTFLVD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:03:27 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:29112 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264998AbTFLVCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:02:55 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055446795.18644.148.camel@w-jstultz2.beaverton.ibm.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
	 <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
	 <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
	 <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com>
	 <1055440030.1043.7.camel@serpentine.internal.keyresearch.com>
	 <1055446795.18644.148.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-obpkefntqlXWt/KBbyt6"
Message-Id: <1055452600.1043.14.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 14:16:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-obpkefntqlXWt/KBbyt6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-06-12 at 12:39, john stultz wrote:

> One little tweak, you're still subtracting tick_usec when calculating
> offset.

Well spotted, thanks.

I'm leaving in the test for negative offset for now, in spite of the
fix.

	<b

 arch/x86_64/Kconfig              |   12 +
 arch/x86_64/kernel/acpi/boot.c   |    6
 arch/x86_64/kernel/apic.c        |   84 +++++-----
 arch/x86_64/kernel/smpboot.c     |   11 +
 arch/x86_64/kernel/time.c        |  306 +++++++++++++++++++++++++++++++-------- arch/x86_64/kernel/vsyscall.c    |   28 ++-
 arch/x86_64/vmlinux.lds.S        |    6
 include/asm-x86_64/fixmap.h      |    2
 include/asm-x86_64/mc146818rtc.h |    5
 include/asm-x86_64/timex.h       |   30 +++
 include/asm-x86_64/vsyscall.h    |   18 +-
 11 files changed, 384 insertions(+), 124 deletions(-)


--=-obpkefntqlXWt/KBbyt6
Content-Disposition: attachment; filename=x86-64-time-2.5.70-4.patch
Content-Type: text/plain; name=x86-64-time-2.5.70-4.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1436  -> 1.1441 
#	arch/x86_64/vmlinux.lds.S	1.16    -> 1.17   
#	arch/x86_64/kernel/apic.c	1.20    -> 1.21   
#	include/asm-x86_64/fixmap.h	1.3     -> 1.4    
#	arch/x86_64/kernel/acpi/boot.c	1.1     -> 1.2    
#	include/asm-x86_64/mc146818rtc.h	1.1     -> 1.2    
#	include/asm-x86_64/timex.h	1.6     -> 1.7    
#	arch/x86_64/kernel/time.c	1.15    -> 1.19   
#	arch/x86_64/kernel/vsyscall.c	1.10    -> 1.11   
#	 arch/x86_64/Kconfig	1.22    -> 1.23   
#	include/asm-x86_64/vsyscall.h	1.5     -> 1.6    
#	arch/x86_64/kernel/smpboot.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/11	bos@serpentine.com	1.1437
# Forward port 2.4 time code.  Optionally uses HPET instead of PIT/RTC for
# gettimeofday calculations.  Far more stable than the current 2.5 code.
# 
# Current caveat: this code doesn't track lost interrupts properly, so we
# can very slowly lose a jiffy here or there.
# --------------------------------------------
# 03/06/11	bos@serpentine.com	1.1438
# Fix residual bogons.
# --------------------------------------------
# 03/06/12	bos@serpentine.com	1.1440
# Further fixes to 2.5 time code.
# --------------------------------------------
# 03/06/12	bos@serpentine.com	1.1441
# Fix offset calculation.
# --------------------------------------------
#
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/Kconfig	Thu Jun 12 14:14:27 2003
@@ -52,6 +52,18 @@
 	  klogd/syslogd or the X server. You should normally N here, unless
 	  you want to debug such a crash.
 	  
+config HPET_TIMER
+	bool
+	default y
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
diff -Nru a/arch/x86_64/kernel/acpi/boot.c b/arch/x86_64/kernel/acpi/boot.c
--- a/arch/x86_64/kernel/acpi/boot.c	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/kernel/acpi/boot.c	Thu Jun 12 14:14:27 2003
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
diff -Nru a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/kernel/apic.c	Thu Jun 12 14:14:27 2003
@@ -46,7 +46,7 @@
 void enable_NMI_through_LVT0 (void * dummy)
 {
 	unsigned int v, ver;
-	
+
 	ver = apic_read(APIC_LVR);
 	ver = GET_APIC_VERSION(ver);
 	v = APIC_DM_NMI;                        /* unmask and set to NMI */
@@ -297,7 +297,7 @@
 	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
-	if (!clustered_apic_mode && 
+	if (!clustered_apic_mode &&
 	    !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
 		BUG();
 
@@ -309,7 +309,7 @@
 
 	if (!clustered_apic_mode) {
 		/*
-		 * In clustered apic mode, the firmware does this for us 
+		 * In clustered apic mode, the firmware does this for us
 		 * Put the APIC into flat delivery mode.
 		 * Must be "all ones" explicitly for 82489DX.
 		 */
@@ -422,15 +422,15 @@
 		value = apic_read(APIC_ESR);
 		Dprintk("ESR value after enabling vector: %08x\n", value);
 	} else {
-		if (esr_disable)	
-			/* 
-			 * Something untraceble is creating bad interrupts on 
+		if (esr_disable)
+			/*
+			 * Something untraceble is creating bad interrupts on
 			 * secondary quads ... for the moment, just leave the
 			 * ESR disabled - we can't do anything useful with the
 			 * errors anyway - mbligh
 			 */
 			printk("Leaving ESR disabled.\n");
-		else 
+		else
 			printk("No ESR for 82489DX.\n");
 	}
 
@@ -580,7 +580,7 @@
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  * On AMD64 we trust the BIOS - if it says no APIC it is likely
- * not correctly set up (usually the APIC timer won't work etc.) 
+ * not correctly set up (usually the APIC timer won't work etc.)
  */
 
 static int __init detect_init_APIC (void)
@@ -683,19 +683,25 @@
 
 	local_irq_save(flags);
 
-	/* For some reasons this doesn't work on Simics, so fake it for now */ 
-	if (!strstr(boot_cpu_data.x86_model_id, "Screwdriver")) { 
+	/* For some reasons this doesn't work on Simics, so fake it for now */
+	if (!strstr(boot_cpu_data.x86_model_id, "Screwdriver")) {
 	__setup_APIC_LVTT(clocks);
 		return;
-	} 
+	}
 
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
 		c2 |= inb_p(0x40) << 8;
-	do {
+		do {
 			c1 = c2;
 			outb_p(0x00, 0x43);
 			c2 = inb_p(0x40);
@@ -754,10 +760,10 @@
 
 void __init setup_boot_APIC_clock (void)
 {
-	if (disable_apic_timer) { 
-		printk(KERN_INFO "Disabling APIC timer\n"); 
-		return; 
-	} 
+	if (disable_apic_timer) {
+		printk(KERN_INFO "Disabling APIC timer\n");
+		return;
+	}
 
 	printk(KERN_INFO "Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
@@ -816,7 +822,7 @@
 	if ( (!multiplier) || (calibration_result/multiplier < 500))
 		return -EINVAL;
 
-	/* 
+	/*
 	 * Set the new multiplier for each CPU. CPUs don't start using the
 	 * new values until the next timer interrupt in which they do process
 	 * accounting. At that time they also adjust their APIC timers
@@ -856,7 +862,7 @@
 		 * Interrupts are already masked off at this point.
 		 */
 		per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
-		if (per_cpu(prof_counter, cpu) != 
+		if (per_cpu(prof_counter, cpu) !=
 		    per_cpu(prof_old_multiplier, cpu)) {
 			__setup_APIC_LVTT(calibration_result/
 					per_cpu(prof_counter, cpu));
@@ -928,19 +934,19 @@
 		ack_APIC_irq();
 
 #if 0
-	static unsigned long last_warning; 
-	static unsigned long skipped; 
+	static unsigned long last_warning;
+	static unsigned long skipped;
 
 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
-	if (time_before(last_warning+30*HZ,jiffies)) { 
+	if (time_before(last_warning+30*HZ,jiffies)) {
 		printk(KERN_INFO "spurious APIC interrupt on CPU#%d, %ld skipped.\n",
 		       smp_processor_id(), skipped);
-		last_warning = jiffies; 
+		last_warning = jiffies;
 		skipped = 0;
-	} else { 
-		skipped++; 
-	} 
-#endif 
+	} else {
+		skipped++;
+	}
+#endif
 	irq_exit();
 }
 
@@ -975,7 +981,7 @@
 	irq_exit();
 }
 
-int disable_apic; 
+int disable_apic;
 
 /*
  * This initializes the IO-APIC and APIC hardware if this is
@@ -983,11 +989,11 @@
  */
 int __init APIC_init_uniprocessor (void)
 {
-	if (disable_apic) { 
+	if (disable_apic) {
 		printk(KERN_INFO "Apic disabled\n");
-		return -1; 
+		return -1;
 	}
-	if (!cpu_has_apic) { 
+	if (!cpu_has_apic) {
 		disable_apic = 1;
 		printk(KERN_INFO "Apic disabled by BIOS\n");
 		return -1;
@@ -1015,18 +1021,18 @@
 	return 0;
 }
 
-static __init int setup_disableapic(char *str) 
-{ 
+static __init int setup_disableapic(char *str)
+{
 	disable_apic = 1;
 	return 0;
-} 
+}
 
-static __init int setup_noapictimer(char *str) 
-{ 
+static __init int setup_noapictimer(char *str)
+{
 	disable_apic_timer = 1;
 	return 0;
-} 
+}
 
-__setup("disableapic", setup_disableapic); 
-__setup("noapictimer", setup_noapictimer); 
+__setup("disableapic", setup_disableapic);
+__setup("noapictimer", setup_noapictimer);
 
diff -Nru a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/kernel/smpboot.c	Thu Jun 12 14:14:27 2003
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
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/kernel/time.c	Thu Jun 12 14:14:27 2003
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/bcd.h>
+#include <asm/pgtable.h>
 #include <asm/vsyscall.h>
 #include <asm/timex.h>
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -35,41 +36,61 @@
 extern int using_apic_timer;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 
 extern int using_apic_timer;
 extern void smp_local_timer_interrupt(struct pt_regs * regs);
 
+#undef HPET_HACK_ENABLE_DANGEROUS
 
-unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
-unsigned long hpet_period;				/* fsecs / HPET clock */
-unsigned long hpet_tick;				/* HPET clocks / interrupt */
-int hpet_report_lost_ticks;				/* command line option */
 
-struct hpet_data __hpet __section_hpet;			/* address, quotient, trigger, hz */
+unsigned int cpu_khz;				/* TSC clocks / usec, not used here */
+unsigned long hpet_period;			/* fsecs / HPET clock */
+unsigned long hpet_tick;			/* HPET clocks / interrupt */
+unsigned long vxtime_hz = 1193182;
+int report_lost_ticks;				/* command line option */
+
+struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
 volatile unsigned long __jiffies __section_jiffies = INITIAL_JIFFIES;
 unsigned long __wall_jiffies __section_wall_jiffies = INITIAL_JIFFIES;
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
 
+static inline void rdtscll_sync(unsigned long *tsc)
+{
+#ifdef CONFIG_SMP
+	sync_core();
+#endif
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
-         */
+ */
 
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
+}
+
+static inline unsigned int do_gettimeoffset_hpet(void)
+{
+	return ((hpet_readl(HPET_COUNTER) - vxtime.last) * vxtime.quot) >> 32;
 }
 
+unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
+
 /*
  * This version of gettimeofday() has microsecond resolution and better than
  * microsecond precision, as we're using at least a 10 MHz (usually 14.31818
@@ -87,7 +108,8 @@
 		sec = xtime.tv_sec;
 		usec = xtime.tv_nsec / 1000;
 
-		t = (jiffies - wall_jiffies) * (1000000L / HZ) + do_gettimeoffset();
+		t = (jiffies - wall_jiffies) * (1000000L / HZ) +
+			do_gettimeoffset();
 		usec += t;
 
 	} while (read_seqretry(&xtime_lock, seq));
@@ -169,17 +191,17 @@
 	real_seconds = nowtime % 60;
 	real_minutes = nowtime / 60;
 	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1)
-		real_minutes += 30;		/* correct for half hour time zone */
+		real_minutes += 30;	/* correct for half hour time zone */
 	real_minutes %= 60;
 
 	if (abs(real_minutes - cmos_minutes) < 30) {
-			BIN_TO_BCD(real_seconds);
-			BIN_TO_BCD(real_minutes);
+		BIN_TO_BCD(real_seconds);
+		BIN_TO_BCD(real_minutes);
 		CMOS_WRITE(real_seconds, RTC_SECONDS);
 		CMOS_WRITE(real_minutes, RTC_MINUTES);
 	} else
-		printk(KERN_WARNING "time.c: can't update CMOS clock from %d to %d\n",
-		       cmos_minutes, real_minutes);
+		printk(KERN_WARNING "time.c: can't update CMOS clock "
+		       "from %d to %d\n", cmos_minutes, real_minutes);
 
 /*
  * The following flags have to be released exactly in this order, otherwise the
@@ -198,27 +220,65 @@
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	static unsigned long rtc_update = 0;
+	unsigned long tsc, lost = 0;
+	int delay, offset = 0;
 
 /*
  * Here we are in the timer irq handler. We have irqs locally disabled (so we
  * don't need spin_lock_irqsave()) but we don't know if the timer_bh is running
  * on the other CPU, so we need a lock. We also need to lock the vsyscall
  * variables, because both do_timer() and us change them -arca+vojtech
-	 */
+ */
 
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
+
+	rdtscll_sync(&tsc);
 
-		sync_core();
-		rdtscll(t);
-		hpet.offset = (t  - hpet.last_tsc) * (1000000L / HZ) / hpet.ticks + hpet.offset - 1000000L / HZ;
-		if (hpet.offset >= 1000000L / HZ)
-			hpet.offset = 0;
-		hpet.ticks = min_t(long, max_t(long, (t  - hpet.last_tsc) * (1000000L / HZ) / (1000000L / HZ - hpet.offset),
-				cpu_khz * 1000/HZ * 15 / 16), cpu_khz * 1000/HZ * 16 / 15); 
-		hpet.last_tsc = t;
+	if (vxtime.mode == VXTIME_HPET) {
+		if (offset - vxtime.last > hpet_tick) {
+			lost = (offset - vxtime.last) / hpet_tick - 1;
+		}
+
+		vxtime.last = offset;
+	} else {
+		offset = (((tsc - vxtime.last_tsc) *
+			   vxtime.tsc_quot) >> 32) - (USEC_PER_SEC / HZ);
+
+		if (offset < 0)
+			offset = 0;
+
+		if (offset > (USEC_PER_SEC / HZ)) {
+			lost = offset / (USEC_PER_SEC / HZ);
+			offset %= (USEC_PER_SEC / HZ);
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
+		jiffies += lost;
 	}
 
 /*
@@ -244,16 +304,16 @@
  * If we have an externally synchronized Linux clock, then update CMOS clock
  * accordingly every ~11 minutes. set_rtc_mmss() will be called in the jiffy
  * closest to exactly 500 ms before the next second. If the update fails, we
- * don'tcare, as it'll be updated on the next turn, and the problem (time way
+ * don't care, as it'll be updated on the next turn, and the problem (time way
  * off) isn't likely to go away much sooner anyway.
  */
 
 	if ((~time_status & STA_UNSYNC) && xtime.tv_sec > rtc_update &&
-		abs(xtime.tv_nsec - 500000000) <= tick_nsec / 2) {
+	    abs(xtime.tv_nsec - 500000000) <= tick_nsec / 2) {
 		set_rtc_mmss(xtime.tv_sec);
 		rtc_update = xtime.tv_sec + 660;
 	}
- 
+
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
@@ -263,6 +323,7 @@
 {
 	unsigned int timeout, year, mon, day, hour, min, sec;
 	unsigned char last, this;
+	unsigned long flags;
 
 /*
  * The Linux interpretation of the CMOS clock register contents: When the
@@ -272,7 +333,7 @@
  * standard 8.3 MHz ISA bus.
  */
 
-	spin_lock(&rtc_lock); 
+	spin_lock_irqsave(&rtc_lock, flags);
 
 	timeout = 1000000;
 	last = this = 0;
@@ -286,28 +347,28 @@
 /*
  * Here we are safe to assume the registers won't change for a whole second, so
  * we just go ahead and read them.
-	 */
+ */
 
-		sec = CMOS_READ(RTC_SECONDS);
-		min = CMOS_READ(RTC_MINUTES);
-		hour = CMOS_READ(RTC_HOURS);
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
-		mon = CMOS_READ(RTC_MONTH);
-		year = CMOS_READ(RTC_YEAR);
+	sec = CMOS_READ(RTC_SECONDS);
+	min = CMOS_READ(RTC_MINUTES);
+	hour = CMOS_READ(RTC_HOURS);
+	day = CMOS_READ(RTC_DAY_OF_MONTH);
+	mon = CMOS_READ(RTC_MONTH);
+	year = CMOS_READ(RTC_YEAR);
 
-	spin_unlock(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 /*
  * We know that x86-64 always uses BCD format, no need to check the config
  * register.
  */
 
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
+	BCD_TO_BIN(sec);
+	BCD_TO_BIN(min);
+	BCD_TO_BIN(hour);
+	BCD_TO_BIN(day);
+	BCD_TO_BIN(mon);
+	BCD_TO_BIN(year);
 
 /*
  * This will work up to Dec 31, 2069.
@@ -326,6 +387,32 @@
 
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
@@ -339,10 +426,9 @@
 	unsigned long start, end;
 	unsigned long flags;
 
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+	spin_lock_irqsave(&i8253_lock, flags);
 
-	local_irq_save(flags);
-	local_irq_disable();
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
 	outb(0xb0, 0x43);
 	outb((1193182 / (1000 / 50)) & 0xff, 0x42);
@@ -353,42 +439,146 @@
 	sync_core();
 	rdtscll(end);
 
+	spin_unlock_irqrestore(&i8253_lock, flags);
 
-	local_irq_restore(flags);
-	
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
+	hpet_tick = (1000000000L * (USEC_PER_SEC / HZ) + hpet_period / 2) /
+		hpet_period;
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
 
-	pit_init();
-	printk(KERN_INFO "time.c: Using 1.1931816 MHz PIT timer.\n");
-	cpu_khz = pit_calibrate_tsc();
+	if (!hpet_init()) {
+                vxtime_hz = (1000000000000000L + hpet_period / 2) /
+			hpet_period;
+		cpu_khz = hpet_calibrate_tsc();
+		timename = "HPET";
+	} else {
+		pit_init();
+		cpu_khz = pit_calibrate_tsc();
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
+}
+
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
 }
 
 __setup("report_lost_ticks", time_setup);
diff -Nru a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
--- a/arch/x86_64/kernel/vsyscall.c	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/kernel/vsyscall.c	Thu Jun 12 14:14:27 2003
@@ -33,7 +33,7 @@
  *
  * Add HPET support (port from 2.4). Still needed?
  * Nop out vsyscall syscall to avoid anchor for buffer overflows when sysctl off.
- * 
+ *
  * These are not urgent things that we need to address only before shipping the first
  * production binary kernels.
  */
@@ -77,14 +77,22 @@
 
 	do {
 		sequence = read_seqbegin(&__xtime_lock);
-		
-		sync_core();
-		rdtscll(t);
+
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
@@ -100,7 +108,7 @@
 static force_inline int gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	int ret;
-	asm volatile("syscall" 
+	asm volatile("syscall"
 		: "=a" (ret)
 		: "0" (__NR_gettimeofday),"D" (tv),"S" (tz) : __syscall_clobber );
 	return ret;
@@ -109,7 +117,7 @@
 static int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
 {
 	if (unlikely(!__sysctl_vsyscall))
-	return gettimeofday(tv,tz); 
+	return gettimeofday(tv,tz);
 	if (tv)
 		do_vgettimeofday(tv);
 	if (tz)
@@ -119,13 +127,13 @@
 
 static time_t __vsyscall(1) vtime(time_t * t)
 {
-	struct timeval tv; 
+	struct timeval tv;
 	if (unlikely(!__sysctl_vsyscall))
 		gettimeofday(&tv, NULL);
 	else
 		do_vgettimeofday(&tv);
 	if (t)
-		*t = tv.tv_sec; 
+		*t = tv.tv_sec;
 	return tv.tv_sec;
 }
 
diff -Nru a/arch/x86_64/vmlinux.lds.S b/arch/x86_64/vmlinux.lds.S
--- a/arch/x86_64/vmlinux.lds.S	Thu Jun 12 14:14:27 2003
+++ b/arch/x86_64/vmlinux.lds.S	Thu Jun 12 14:14:27 2003
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
diff -Nru a/include/asm-x86_64/fixmap.h b/include/asm-x86_64/fixmap.h
--- a/include/asm-x86_64/fixmap.h	Thu Jun 12 14:14:27 2003
+++ b/include/asm-x86_64/fixmap.h	Thu Jun 12 14:14:27 2003
@@ -35,6 +35,8 @@
 enum fixed_addresses {
 	VSYSCALL_LAST_PAGE,
 	VSYSCALL_FIRST_PAGE = VSYSCALL_LAST_PAGE + ((VSYSCALL_END-VSYSCALL_START) >> PAGE_SHIFT) - 1,
+	VSYSCALL_HPET,
+	FIX_HPET_BASE,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
diff -Nru a/include/asm-x86_64/mc146818rtc.h b/include/asm-x86_64/mc146818rtc.h
--- a/include/asm-x86_64/mc146818rtc.h	Thu Jun 12 14:14:27 2003
+++ b/include/asm-x86_64/mc146818rtc.h	Thu Jun 12 14:14:27 2003
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
diff -Nru a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
--- a/include/asm-x86_64/timex.h	Thu Jun 12 14:14:27 2003
+++ b/include/asm-x86_64/timex.h	Thu Jun 12 14:14:27 2003
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
diff -Nru a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
--- a/include/asm-x86_64/vsyscall.h	Thu Jun 12 14:14:27 2003
+++ b/include/asm-x86_64/vsyscall.h	Thu Jun 12 14:14:27 2003
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

--=-obpkefntqlXWt/KBbyt6--


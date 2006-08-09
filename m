Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWHICRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWHICRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWHICRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60819 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751245AbWHICRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:23 -0400
Date: Tue, 8 Aug 2006 22:17:20 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021720.23103.26378.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 2/6] x86_64: hpet_address cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting generic timekeeping, this patch cleans up 
x86-64's use of vxtime.hpet_address, changing it to just hpet_address 
as is also used in i386. This is necessary since the vxtime structure 
will be going away.

Signed-off-by: John Stultz <johnstul@us.ibm.com>


 arch/i386/kernel/acpi/boot.c |   19 ++++++-------------
 arch/x86_64/kernel/apic.c    |    3 ++-
 arch/x86_64/kernel/time.c    |   34 ++++++++++++++++++----------------
 include/asm-x86_64/hpet.h    |    1 +
 4 files changed, 27 insertions(+), 30 deletions(-)

linux-2.6.18-rc4_timeofday-arch-x86-64-part1_C5.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 0db6387..f2c43da 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -575,6 +575,7 @@ static int __init acpi_parse_sbf(unsigne
 }
 
 #ifdef CONFIG_HPET_TIMER
+#include <asm/hpet.h>
 
 static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 {
@@ -595,21 +596,13 @@ static int __init acpi_parse_hpet(unsign
 		return -1;
 	}
 #ifdef	CONFIG_X86_64
-	vxtime.hpet_address = hpet_tbl->addr.addrl |
+	hpet_address = hpet_tbl->addr.addrl |
 	    ((long)hpet_tbl->addr.addrh << 32);
-
+#else
+	hpet_address = hpet_tbl->addr.addrl;
+#endif
 	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-	       hpet_tbl->id, vxtime.hpet_address);
-#else				/* X86 */
-	{
-		extern unsigned long hpet_address;
-
-		hpet_address = hpet_tbl->addr.addrl;
-		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-		       hpet_tbl->id, hpet_address);
-	}
-#endif				/* X86 */
-
+	       hpet_tbl->id, hpet_address);
 	return 0;
 }
 #else
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 2b8cef0..1b9e3d3 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -36,6 +36,7 @@
 #include <asm/idle.h>
 #include <asm/proto.h>
 #include <asm/timex.h>
+#include <asm/hpet.h>
 
 int apic_verbosity;
 int apic_runs_main_timer;
@@ -727,7 +728,7 @@ static void setup_APIC_timer(unsigned in
 	local_irq_save(flags);
 
 	/* wait for irq slice */
- 	if (vxtime.hpet_address && hpet_use_timer) {
+ 	if (hpet_address && hpet_use_timer) {
  		int trigger = hpet_readl(HPET_T0_CMP);
  		while (hpet_readl(HPET_COUNTER) >= trigger)
  			/* do nothing */ ;
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 7a9b182..da89e60 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -67,6 +67,7 @@ static int notsc __initdata = 0;
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
+unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
@@ -326,7 +327,7 @@ static noinline void handle_lost_ticks(i
 		       KERN_WARNING "Your time source seems to be instable or "
 		   		"some driver is hogging interupts\n");
 		print_symbol("rip %s\n", regs->rip);
-		if (vxtime.mode == VXTIME_TSC && vxtime.hpet_address) {
+		if (vxtime.mode == VXTIME_TSC && hpet_address) {
 			printk(KERN_WARNING "Falling back to HPET\n");
 			if (hpet_use_timer)
 				vxtime.last = hpet_readl(HPET_T0_CMP) - 
@@ -334,6 +335,7 @@ static noinline void handle_lost_ticks(i
 			else
 				vxtime.last = hpet_readl(HPET_COUNTER);
 			vxtime.mode = VXTIME_HPET;
+			vxtime.hpet_address = hpet_address;
 			do_gettimeoffset = do_gettimeoffset_hpet;
 		}
 		/* else should fall back to PIT, but code missing. */
@@ -364,7 +366,7 @@ void main_timer_handler(struct pt_regs *
 
 	write_seqlock(&xtime_lock);
 
-	if (vxtime.hpet_address)
+	if (hpet_address)
 		offset = hpet_readl(HPET_COUNTER);
 
 	if (hpet_use_timer) {
@@ -734,7 +736,7 @@ static __init int late_hpet_init(void)
 	struct hpet_data	hd;
 	unsigned int 		ntimer;
 
-	if (!vxtime.hpet_address)
+	if (!hpet_address)
         	return 0;
 
 	memset(&hd, 0, sizeof (hd));
@@ -747,7 +749,7 @@ static __init int late_hpet_init(void)
 	 * Register with driver.
 	 * Timer0 and Timer1 is used by platform.
 	 */
-	hd.hd_phys_address = vxtime.hpet_address;
+	hd.hd_phys_address = hpet_address;
 	hd.hd_address = (void __iomem *)fix_to_virt(FIX_HPET_BASE);
 	hd.hd_nirqs = ntimer;
 	hd.hd_flags = HPET_DATA_PLATFORM;
@@ -816,10 +818,10 @@ static int hpet_init(void)
 {
 	unsigned int id;
 
-	if (!vxtime.hpet_address)
+	if (!hpet_address)
 		return -1;
-	set_fixmap_nocache(FIX_HPET_BASE, vxtime.hpet_address);
-	__set_fixmap(VSYSCALL_HPET, vxtime.hpet_address, PAGE_KERNEL_VSYSCALL_NOCACHE);
+	set_fixmap_nocache(FIX_HPET_BASE, hpet_address);
+	__set_fixmap(VSYSCALL_HPET, hpet_address, PAGE_KERNEL_VSYSCALL_NOCACHE);
 
 /*
  * Read the period, compute tick and quotient.
@@ -873,7 +875,7 @@ void __init pit_stop_interrupt(void)
 void __init stop_timer_interrupt(void)
 {
 	char *name;
-	if (vxtime.hpet_address) {
+	if (hpet_address) {
 		name = "HPET";
 		hpet_timer_stop_set_go(0);
 	} else {
@@ -899,8 +901,7 @@ void __init time_init(void)
 	char *gtod;
 
 	if (nohpet)
-		vxtime.hpet_address = 0;
-
+		hpet_address = 0;
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
 
@@ -910,7 +911,7 @@ void __init time_init(void)
 	if (!hpet_init())
                 vxtime_hz = (FSEC_PER_SEC + hpet_period / 2) / hpet_period;
 	else
-		vxtime.hpet_address = 0;
+		hpet_address = 0;
 
 	if (hpet_use_timer) {
 		/* set tick_nsec to use the proper rate for HPET */
@@ -918,7 +919,7 @@ void __init time_init(void)
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 #ifdef CONFIG_X86_PM_TIMER
-	} else if (pmtmr_ioport && !vxtime.hpet_address) {
+	} else if (pmtmr_ioport && !hpet_address) {
 		vxtime_hz = PM_TIMER_FREQUENCY;
 		timename = "PM";
 		pit_init();
@@ -979,18 +980,19 @@ __init static char *time_init_gtod(void)
 
 	if (unsynchronized_tsc())
 		notsc = 1;
-	if (vxtime.hpet_address && notsc) {
+	if (hpet_address && notsc) {
 		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
 		if (hpet_use_timer)
 			vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		else
 			vxtime.last = hpet_readl(HPET_COUNTER);
 		vxtime.mode = VXTIME_HPET;
+		vxtime.hpet_address = hpet_address;
 		do_gettimeoffset = do_gettimeoffset_hpet;
 #ifdef CONFIG_X86_PM_TIMER
 	/* Using PM for gettimeofday is quite slow, but we have no other
 	   choice because the TSC is too unreliable on some systems. */
-	} else if (pmtmr_ioport && !vxtime.hpet_address && notsc) {
+	} else if (pmtmr_ioport && !hpet_address && notsc) {
 		timetype = "PM";
 		do_gettimeoffset = do_gettimeoffset_pm;
 		vxtime.mode = VXTIME_PMTMR;
@@ -1033,7 +1035,7 @@ static int timer_resume(struct sys_devic
 	unsigned long ctime = get_cmos_time();
 	unsigned long sleep_length = (ctime - sleep_start) * HZ;
 
-	if (vxtime.hpet_address)
+	if (hpet_address)
 		hpet_reenable();
 	else
 		i8254_timer_resume();
@@ -1118,7 +1120,7 @@ static unsigned int hpet_t1_cmp; /* cach
 
 int is_hpet_enabled(void)
 {
-	return vxtime.hpet_address != 0;
+	return hpet_address != 0;
 }
 
 /*
diff --git a/include/asm-x86_64/hpet.h b/include/asm-x86_64/hpet.h
index b390984..60d5127 100644
--- a/include/asm-x86_64/hpet.h
+++ b/include/asm-x86_64/hpet.h
@@ -58,6 +58,7 @@ extern int hpet_rtc_timer_init(void);
 extern int apic_is_clustered_box(void);
 
 extern int hpet_use_timer;
+extern unsigned long hpet_address;
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 extern int hpet_mask_rtc_irq_bit(unsigned long bit_mask);

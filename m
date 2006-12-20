Return-Path: <linux-kernel-owner+w=401wt.eu-S932826AbWLTBVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbWLTBVY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932850AbWLTBVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:21:12 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:48068 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932826AbWLTBUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:20:53 -0500
Date: Tue, 19 Dec 2006 20:20:51 -0500
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Message-Id: <20061220011719.25341.23668.sendpatchset@localhost>
In-Reply-To: <20061220011707.25341.6522.sendpatchset@localhost>
References: <20061220011707.25341.6522.sendpatchset@localhost>
Subject: [PATCH 2/5][time][x86_64] hpet_address cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting generic timekeeping, this patch cleans up 
x86-64's use of vxtime.hpet_address, changing it to just hpet_address 
as is also used in i386. This is necessary since the vxtime structure 
will be going away.

Signed-off-by: John Stultz <johnstul@us.ibm.com>


 arch/i386/kernel/acpi/boot.c |   23 ++++++-----------------
 arch/x86_64/kernel/apic.c    |    3 ++-
 arch/x86_64/kernel/time.c    |   36 +++++++++++++++++++-----------------
 include/asm-x86_64/hpet.h    |    1 +
 4 files changed, 28 insertions(+), 35 deletions(-)

linux-2.6.20-rc1_timeofday-arch-x86-64-hpet-address-cleanup_C7.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index c8f96cf..464f95b 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -638,6 +638,7 @@ static int __init acpi_parse_sbf(unsigne
 }
 
 #ifdef CONFIG_HPET_TIMER
+#include <asm/hpet.h>
 
 static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 {
@@ -671,32 +672,20 @@ #define HPET_RESOURCE_NAME_SIZE 9
 		hpet_res->end = (1 * 1024) - 1;
 	}
 
+	hpet_address = hpet_tbl->addr.addrl;
 #ifdef	CONFIG_X86_64
-	vxtime.hpet_address = hpet_tbl->addr.addrl |
-	    ((long)hpet_tbl->addr.addrh << 32);
-
+	hpet_address |= ((long)hpet_tbl->addr.addrh << 32);
+#endif
 	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-	       hpet_tbl->id, vxtime.hpet_address);
-
-	res_start = vxtime.hpet_address;
-#else				/* X86 */
-	{
-		extern unsigned long hpet_address;
+	       hpet_tbl->id, hpet_address);
 
-		hpet_address = hpet_tbl->addr.addrl;
-		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-		       hpet_tbl->id, hpet_address);
-
-		res_start = hpet_address;
-	}
-#endif				/* X86 */
+	res_start = hpet_address;
 
 	if (hpet_res) {
 		hpet_res->start = res_start;
 		hpet_res->end += res_start;
 		insert_resource(&iomem_resource, hpet_res);
 	}
-
 	return 0;
 }
 #else
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 124b2d2..7ce7797 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -37,6 +37,7 @@ #include <asm/nmi.h>
 #include <asm/idle.h>
 #include <asm/proto.h>
 #include <asm/timex.h>
+#include <asm/hpet.h>
 #include <asm/apic.h>
 
 int apic_mapped;
@@ -763,7 +764,7 @@ static void setup_APIC_timer(unsigned in
 	local_irq_save(flags);
 
 	/* wait for irq slice */
- 	if (vxtime.hpet_address && hpet_use_timer) {
+ 	if (hpet_address && hpet_use_timer) {
  		int trigger = hpet_readl(HPET_T0_CMP);
  		while (hpet_readl(HPET_COUNTER) >= trigger)
  			/* do nothing */ ;
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 9f05bc9..af9b072 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -67,6 +67,7 @@ #define US_SCALE	32 /* 2^32, arbitralril
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
+unsigned long hpet_address;
 static unsigned long hpet_period;			/* fsecs / HPET clock */
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
@@ -316,7 +317,7 @@ static noinline void handle_lost_ticks(i
 		       KERN_WARNING "Your time source seems to be instable or "
 		   		"some driver is hogging interupts\n");
 		print_symbol("rip %s\n", get_irq_regs()->rip);
-		if (vxtime.mode == VXTIME_TSC && vxtime.hpet_address) {
+		if (vxtime.mode == VXTIME_TSC && hpet_address) {
 			printk(KERN_WARNING "Falling back to HPET\n");
 			if (hpet_use_timer)
 				vxtime.last = hpet_readl(HPET_T0_CMP) - 
@@ -324,6 +325,7 @@ static noinline void handle_lost_ticks(i
 			else
 				vxtime.last = hpet_readl(HPET_COUNTER);
 			vxtime.mode = VXTIME_HPET;
+			vxtime.hpet_address = hpet_address;
 			do_gettimeoffset = do_gettimeoffset_hpet;
 		}
 		/* else should fall back to PIT, but code missing. */
@@ -354,7 +356,7 @@ void main_timer_handler(void)
 
 	write_seqlock(&xtime_lock);
 
-	if (vxtime.hpet_address)
+	if (hpet_address)
 		offset = hpet_readl(HPET_COUNTER);
 
 	if (hpet_use_timer) {
@@ -717,7 +719,7 @@ static __init int late_hpet_init(void)
 	struct hpet_data	hd;
 	unsigned int 		ntimer;
 
-	if (!vxtime.hpet_address)
+	if (!hpet_address)
         	return 0;
 
 	memset(&hd, 0, sizeof (hd));
@@ -730,7 +732,7 @@ static __init int late_hpet_init(void)
 	 * Register with driver.
 	 * Timer0 and Timer1 is used by platform.
 	 */
-	hd.hd_phys_address = vxtime.hpet_address;
+	hd.hd_phys_address = hpet_address;
 	hd.hd_address = (void __iomem *)fix_to_virt(FIX_HPET_BASE);
 	hd.hd_nirqs = ntimer;
 	hd.hd_flags = HPET_DATA_PLATFORM;
@@ -799,10 +801,10 @@ static int hpet_init(void)
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
@@ -856,7 +858,7 @@ void __init pit_stop_interrupt(void)
 void __init stop_timer_interrupt(void)
 {
 	char *name;
-	if (vxtime.hpet_address) {
+	if (hpet_address) {
 		name = "HPET";
 		hpet_timer_stop_set_go(0);
 	} else {
@@ -879,8 +881,7 @@ static struct irqaction irq0 = {
 void __init time_init(void)
 {
 	if (nohpet)
-		vxtime.hpet_address = 0;
-
+		hpet_address = 0;
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
 
@@ -890,7 +891,7 @@ void __init time_init(void)
 	if (!hpet_init())
                 vxtime_hz = (FSEC_PER_SEC + hpet_period / 2) / hpet_period;
 	else
-		vxtime.hpet_address = 0;
+		hpet_address = 0;
 
 	if (hpet_use_timer) {
 		/* set tick_nsec to use the proper rate for HPET */
@@ -898,7 +899,7 @@ void __init time_init(void)
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 #ifdef CONFIG_X86_PM_TIMER
-	} else if (pmtmr_ioport && !vxtime.hpet_address) {
+	} else if (pmtmr_ioport && !hpet_address) {
 		vxtime_hz = PM_TIMER_FREQUENCY;
 		timename = "PM";
 		pit_init();
@@ -957,23 +958,24 @@ void time_init_gtod(void)
 	if (unsynchronized_tsc())
 		notsc = 1;
 
- 	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
+	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
 		vgetcpu_mode = VGETCPU_RDTSCP;
 	else
 		vgetcpu_mode = VGETCPU_LSL;
 
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
 		sleep_length = 0;
 		ctime = sleep_start;
 	}
-	if (vxtime.hpet_address)
+	if (hpet_address)
 		hpet_reenable();
 	else
 		i8254_timer_resume();
@@ -1117,7 +1119,7 @@ static unsigned int hpet_t1_cmp; /* cach
 
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

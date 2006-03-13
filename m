Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWCMSQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWCMSQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWCMSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:16:18 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:5636 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932305AbWCMSQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:16:13 -0500
Date: Mon, 13 Mar 2006 10:16:12 -0800
Message-Id: <200603131816.k2DIGCpr005779@zach-dev.vmware.com>
Subject: [RFC, PATCH 22/24] i386 Consolidate redundant timer code
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:16:12.0484 (UTC) FILETIME=[35B21840:01C646CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isolate some of the non-VMI timer related changes in Linux.  This patch
moves the cyc_2_ns conversion code into a common location, eliminating
redundant code in hpet and tsc timer implementations, and introduces
some macros that may be redefined by the sub-architecture to avoid
dependence on APIC routing, CMOS time sync, and testing for broken time
hardware (which presumably, does not happen in a virtual machine).

Signed-off-by: Dan Hecht <dhecht@vmware.com>
Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc6/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/apic.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/apic.c	2006-03-12 19:57:42.000000000 -0800
@@ -39,6 +39,7 @@
 
 #include <mach_apic.h>
 #include <mach_ipi.h>
+#include <mach_apictimer.h>
 
 #include "io_ports.h"
 
@@ -1322,7 +1323,7 @@ int __init APIC_init_uniprocessor (void)
 		if (!skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
 #endif
-	setup_boot_APIC_clock();
+	mach_setup_boot_local_clock();
 
 	return 0;
 }
Index: linux-2.6.16-rc6/arch/i386/kernel/i8259.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/i8259.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/i8259.c	2006-03-12 19:57:42.000000000 -0800
@@ -425,7 +425,7 @@ void __init init_IRQ(void)
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
 	 */
-	setup_pit_timer();
+	setup_system_timer();
 
 	/*
 	 * External FPU? Set up irq13 if so, for
Index: linux-2.6.16-rc6/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/io_apic.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/io_apic.c	2006-03-12 19:57:42.000000000 -0800
@@ -40,6 +40,7 @@
 #include <asm/i8259.h>
 
 #include <mach_apic.h>
+#include <mach_apictimer.h>
 
 #include "io_ports.h"
 
@@ -1864,7 +1865,7 @@ static void __init setup_ioapic_ids_from
  *	- if this function detects that timer IRQs are defunct, then we fall
  *	  back to ISA timer IRQs
  */
-static int __init timer_irq_works(void)
+int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
 
@@ -2285,7 +2286,7 @@ static inline void check_timer(void)
 		 * Ok, does IRQ0 through the IOAPIC work?
 		 */
 		unmask_IO_APIC_irq(0);
-		if (timer_irq_works()) {
+		if (mach_timer_irq_works()) {
 			if (nmi_watchdog == NMI_IO_APIC) {
 				disable_8259A_irq(0);
 				setup_nmi();
@@ -2307,7 +2308,7 @@ static inline void check_timer(void)
 		 * legacy devices should be connected to IO APIC #0
 		 */
 		setup_ExtINT_IRQ0_pin(apic2, pin2, vector);
-		if (timer_irq_works()) {
+		if (mach_timer_irq_works()) {
 			printk("works.\n");
 			if (pin1 != -1)
 				replace_pin_at_irq(0, apic1, pin1, apic2, pin2);
@@ -2337,7 +2338,7 @@ static inline void check_timer(void)
 	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
 	enable_8259A_irq(0);
 
-	if (timer_irq_works()) {
+	if (mach_timer_irq_works()) {
 		printk(" works.\n");
 		return;
 	}
@@ -2353,7 +2354,7 @@ static inline void check_timer(void)
 
 	unlock_ExtINT_logic();
 
-	if (timer_irq_works()) {
+	if (mach_timer_irq_works()) {
 		printk(" works.\n");
 		return;
 	}
Index: linux-2.6.16-rc6/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/smpboot.c	2006-03-12 19:57:32.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/smpboot.c	2006-03-12 19:57:42.000000000 -0800
@@ -56,6 +56,7 @@
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
 #include <smpboot_hooks.h>
+#include <mach_apictimer.h>
 
 /* Set if we find a B stepping CPU */
 static int __devinitdata smp_b_stepping;
@@ -513,7 +514,7 @@ static void __devinit start_secondary(vo
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
-	setup_secondary_APIC_clock();
+	mach_setup_secondary_local_clock();
 	if (nmi_watchdog == NMI_IO_APIC) {
 		disable_8259A_irq(0);
 		enable_NMI_through_LVT0(NULL);
@@ -1270,7 +1271,7 @@ static void __init smp_boot_cpus(unsigne
 
 	smpboot_setup_io_apic();
 
-	setup_boot_APIC_clock();
+	mach_setup_boot_local_clock();
 
 	/*
 	 * Synchronize the TSC with the AP
Index: linux-2.6.16-rc6/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/time.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/time.c	2006-03-12 19:57:42.000000000 -0800
@@ -329,6 +329,7 @@ unsigned long get_cmos_time(void)
 }
 EXPORT_SYMBOL(get_cmos_time);
 
+int no_sync_cmos_timer;
 static void sync_cmos_clock(unsigned long dummy);
 
 static DEFINE_TIMER(sync_cmos_timer, sync_cmos_clock, 0, 0);
@@ -375,7 +376,8 @@ static void sync_cmos_clock(unsigned lon
 
 void notify_arch_cmos_timer(void)
 {
-	mod_timer(&sync_cmos_timer, jiffies + 1);
+	if (!no_sync_cmos_timer)
+		mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
 static long clock_cmos_diff, sleep_start;
@@ -446,16 +448,19 @@ static int time_init_device(void)
 
 device_initcall(time_init_device);
 
-#ifdef CONFIG_HPET_TIMER
-extern void (*late_time_init)(void);
-/* Duplicate of time_init() below, with hpet_enable part added */
-static void __init hpet_time_init(void)
+void __init init_xtime_from_cmos(void)
 {
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	set_normalized_timespec(&wall_to_monotonic,
 		-xtime.tv_sec, -xtime.tv_nsec);
+}
 
+#ifdef CONFIG_HPET_TIMER
+extern void (*late_time_init)(void);
+/* Duplicate of time_init() below, with hpet_enable part added */
+static void __init hpet_time_init(void)
+{
 	if ((hpet_enable() >= 0) && hpet_use_timer) {
 		printk("Using HPET for base-timer\n");
 	}
@@ -479,11 +484,6 @@ void __init time_init(void)
 		return;
 	}
 #endif
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/common.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/common.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/common.c	2006-03-12 19:57:42.000000000 -0800
@@ -14,6 +14,15 @@
 
 #include "mach_timer.h"
 
+unsigned long cyc2ns_scale; 
+unsigned long cyc2us_scale; 
+
+void set_cyc_scales(unsigned long cpu_mhz)
+{
+	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
+	cyc2us_scale = (1 << CYC2US_SCALE_FACTOR)/cpu_mhz;
+}
+
 /* ------ Calibrate the TSC -------
  * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
  * Too much 64-bit arithmetic here to do this cleanly in C, and for
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_cyclone.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_cyclone.c	2006-03-12 19:57:42.000000000 -0800
@@ -224,6 +224,7 @@ static int __init init_cyclone(char* ove
 		}
 	}
 
+	init_xtime_from_cmos();
 	init_cpu_khz();
 
 	/* Everything looks good! */
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_hpet.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_hpet.c	2006-03-12 19:57:42.000000000 -0800
@@ -26,39 +26,6 @@ static unsigned long last_tsc_high; 	/* 
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_khz * 10^3))
- *		ns = cycles * (10^6 / cpu_khz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to get:
- *		ns = cycles * (10^6 * SC / cpu_khz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *
- *  We can use khz divisor instead of mhz to keep a better percision, since
- *  cyc2ns_scale is limited to 10^6 * 2^10, which fits in 32 bits.
- *  (mathieu.desnoyers@polymtl.ca)
- *
- *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
- */
-static unsigned long cyc2ns_scale;
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
-{
-	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
 static unsigned long long monotonic_clock_hpet(void)
 {
 	unsigned long long last_offset, this_offset, base;
@@ -155,6 +122,7 @@ static int __init init_hpet(char* overri
 		return -ENODEV;
 
 	printk("Using HPET for gettimeofday\n");
+	init_xtime_from_cmos();
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient = calibrate_tsc_hpet(&tsc_hpet_quotient);
 		if (tsc_quotient) {
@@ -168,7 +136,7 @@ static int __init init_hpet(char* overri
 				printk("Detected %u.%03u MHz processor.\n",
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
-			set_cyc2ns_scale(cpu_khz);
+			set_cyc_scales(cpu_khz);
 		}
 		/* set this only when cpu_has_tsc */
 		timer_hpet.read_timer = read_timer_tsc;
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_pit.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_pit.c	2006-03-12 19:57:42.000000000 -0800
@@ -27,6 +27,7 @@ static int __init init_pit(char* overrid
  	if (override[0] && strncmp(override,"pit",3))
  		printk(KERN_ERR "Warning: clock= override failed. Defaulting "
 				"to PIT\n");
+	init_xtime_from_cmos();
  	init_cpu_khz();
 	count_p = LATCH;
 	return 0;
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_pm.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_pm.c	2006-03-12 19:57:42.000000000 -0800
@@ -127,6 +127,7 @@ pm_good:
 	if (verify_pmtmr_rate() != 0)
 		return -ENODEV;
 
+	init_xtime_from_cmos();
 	init_cpu_khz();
 	return 0;
 }
Index: linux-2.6.16-rc6/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.16-rc6.orig/arch/i386/kernel/timers/timer_tsc.c	2006-03-12 19:49:53.000000000 -0800
+++ linux-2.6.16-rc6/arch/i386/kernel/timers/timer_tsc.c	2006-03-12 19:57:42.000000000 -0800
@@ -54,39 +54,6 @@ static int __init start_lost_tick_compen
 }
 late_initcall(start_lost_tick_compensation);
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_khz * 10^3))
- *		ns = cycles * (10^6 / cpu_khz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to get:
- *		ns = cycles * (10^6 * SC / cpu_khz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *
- *  We can use khz divisor instead of mhz to keep a better percision, since
- *  cyc2ns_scale is limited to 10^6 * 2^10, which fits in 32 bits.
- *  (mathieu.desnoyers@polymtl.ca)
- *
- *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
- */
-static unsigned long cyc2ns_scale; 
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
-{
-	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
 static int count2; /* counter for mark_offset_tsc() */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -305,7 +272,7 @@ time_cpufreq_notifier(struct notifier_bl
 		if (use_tsc) {
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
-				set_cyc2ns_scale(cpu_khz);
+				set_cyc_scales(cpu_khz);
 			}
 		}
 #endif
@@ -540,6 +507,7 @@ static int __init init_tsc(char* overrid
 		}
 
 		if (tsc_quotient) {
+			init_xtime_from_cmos();
 			fast_gettimeoffset_quotient = tsc_quotient;
 			use_tsc = 1;
 			/*
@@ -558,7 +526,7 @@ static int __init init_tsc(char* overrid
 				printk("Detected %u.%03u MHz processor.\n",
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
-			set_cyc2ns_scale(cpu_khz);
+			set_cyc_scales(cpu_khz);
 			return 0;
 		}
 	}
Index: linux-2.6.16-rc6/include/asm-i386/timer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/timer.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/timer.h	2006-03-12 19:57:42.000000000 -0800
@@ -38,7 +38,9 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+void init_xtime_from_cmos(void);
 
+extern int no_sync_cmos_timer;
 /* Modifiers for buggy PIT handling */
 
 extern int pit_latch_buggy;
@@ -67,4 +69,44 @@ extern unsigned long calibrate_tsc_hpet(
 #ifdef CONFIG_X86_PM_TIMER
 extern struct init_timer_opts timer_pmtmr_init;
 #endif
+
+static inline void setup_system_timer(void) 
+{
+	setup_pit_timer();
+}
+
+/* convert from cycles(64bits) => nanoseconds (64bits)
+ *  basic equation:
+ *		ns = cycles / (freq / ns_per_sec)
+ *		ns = cycles * (ns_per_sec / freq)
+ *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
+ *		ns = cycles * (10^3 / cpu_mhz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
+ *		ns = cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.   
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+
+extern unsigned long cyc2ns_scale; 
+extern unsigned long cyc2us_scale; 
+
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+#define CYC2US_SCALE_FACTOR 20 
+
+extern void set_cyc_scales(unsigned long cpu_mhz);
+
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+
+static inline unsigned long long cycles_2_us(unsigned long long cyc)
+{
+	return (cyc * cyc2us_scale) >> CYC2US_SCALE_FACTOR;
+}
+
 #endif
Index: linux-2.6.16-rc6/include/asm-i386/mach-default/mach_apictimer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-i386/mach-default/mach_apictimer.h	2006-03-12 19:57:42.000000000 -0800
+++ linux-2.6.16-rc6/include/asm-i386/mach-default/mach_apictimer.h	2006-03-12 19:57:42.000000000 -0800
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to dhecht@vmware.com
+ *
+ */
+
+/*
+ * Initiation routines related to the APIC timer.
+ * These may optionally be overridden by the subarchitecture in
+ * mach_apictimer.h.
+ */
+
+#ifndef __ASM_MACH_APICTIMER_H
+#define __ASM_MACH_APICTIMER_H
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+extern int __init timer_irq_works(void);
+
+static inline void mach_setup_boot_local_clock(void)
+{
+	setup_boot_APIC_clock();
+}
+
+static inline void mach_setup_secondary_local_clock(void)
+{
+	setup_secondary_APIC_clock();
+}
+
+static inline int mach_timer_irq_works(void)
+{
+	return timer_irq_works();
+}
+
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+#endif /* __ASM_MACH_APICTIMER_H */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbTHSWIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbTHSWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:08:54 -0400
Received: from fmr04.intel.com ([143.183.121.6]:15839 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261494AbTHSWIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:08:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36686.E36BC59E"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6][2/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 12:20:02 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C4@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][2/5]Support for HPET based timer
Thread-Index: AcNmhuKzq3O8rTNsQ1WPcZQW4cDXpA==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 19 Aug 2003 19:20:03.0127 (UTC) FILETIME=[E3E01470:01C36686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36686.E36BC59E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

2/5 - hpet2.patch - All the changes required to use HPET in place
                    of PIT as the kernel base-timer at IRQ 0.




diff -purN linux-2.6.0-test1/arch/i386/kernel/apic.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/apic.c
--- linux-2.6.0-test1/arch/i386/kernel/apic.c	2003-07-13 =
20:39:27.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/apic.c	2003-08-13 =
11:36:24.000000000 -0700
@@ -34,6 +34,7 @@
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/hpet.h>
=20
 #include <mach_apic.h>
=20
@@ -749,7 +750,8 @@ static unsigned int __init get_8254_time
 	return count;
 }
=20
-void __init wait_8254_wraparound(void)
+/* next tick in 8254 can be caught by catching timer wraparound */
+static void __init wait_8254_wraparound(void)
 {
 	unsigned int curr_count, prev_count=3D~0;
 	int delta;
@@ -771,6 +773,12 @@ void __init wait_8254_wraparound(void)
 }
=20
 /*
+ * Default initialization for 8254 timers. If we use other timers like =
HPET,
+ * we override this later=20
+ */
+void (*wait_timer_tick)(void) =3D wait_8254_wraparound;
+
+/*
  * This function sets up the local APIC timer, with a timeout of
  * 'clocks' APIC bus clock. During calibration we actually call
  * this function twice on the boot CPU, once with a bogus timeout
@@ -811,7 +819,7 @@ static void setup_APIC_timer(unsigned in
 	/*
 	 * Wait for IRQ0's slice:
 	 */
-	wait_8254_wraparound();
+	wait_timer_tick();
=20
 	__setup_APIC_LVTT(clocks);
=20
@@ -854,7 +862,7 @@ int __init calibrate_APIC_clock(void)
 	 * (the current tick might have been already half done)
 	 */
=20
-	wait_8254_wraparound();
+	wait_timer_tick();
=20
 	/*
 	 * We wrapped around just now. Let's start:
@@ -867,7 +875,7 @@ int __init calibrate_APIC_clock(void)
 	 * Let's wait LOOPS wraprounds:
 	 */
 	for (i =3D 0; i < LOOPS; i++)
-		wait_8254_wraparound();
+		wait_timer_tick();
=20
 	tt2 =3D apic_read(APIC_TMCCT);
 	if (cpu_has_tsc)
diff -purN linux-2.6.0-test1/arch/i386/kernel/time.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/time.c
--- linux-2.6.0-test1/arch/i386/kernel/time.c	2003-07-13 =
20:34:29.000000000 -0700
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/time.c	2003-08-18 =
12:36:25.000000000 -0700
@@ -60,6 +60,8 @@
 #include <linux/timex.h>
 #include <linux/config.h>
=20
+#include <asm/hpet.h>
+
 #include <asm/arch_hooks.h>
=20
 #include "io_ports.h"
@@ -298,6 +300,12 @@ void __init time_init(void)
 	xtime.tv_nsec =3D (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec =3D -xtime.tv_nsec;
=20
+#ifdef CONFIG_HPET_TIMER
+	if (hpet_enable() >=3D 0) {
+		printk("Using HPET for base-timer\n");
+	}
+#endif
+
 	cur_timer =3D select_timer();
 	time_init_hook();
 }
diff -purN linux-2.6.0-test1/arch/i386/kernel/time_hpet.c =
linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c
--- linux-2.6.0-test1/arch/i386/kernel/time_hpet.c	1969-12-31 =
16:00:00.000000000 -0800
+++ linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c	2003-08-18 =
20:22:06.000000000 -0700
@@ -0,0 +1,153 @@
+/*
+ *  linux/arch/i386/kernel/time_hpet.c
+ *  This code largely copied from arch/x86_64/kernel/time.c
+ *  See that file for credits.
+ *
+ *  2003-06-30    Venkatesh Pallipadi - Additional changes for HPET =
support
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/timer.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+
+#include <linux/timex.h>
+#include <linux/config.h>
+
+#include <asm/hpet.h>
+
+unsigned long hpet_period;	/* fsecs / HPET clock */
+unsigned long hpet_tick;	/* hpet clks count per tick */
+unsigned long hpet_address;	/* hpet memory map address */
+
+static int use_hpet; 		/* can be used for runtime check of hpet */
+static int boot_hpet_disable; 	/* boottime override for HPET timer */
+
+#define FSEC_TO_USEC (1000000000UL)
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * HPET counters dont wrap around on every tick. They just change the=20
+ * comparator value and continue. Next tick can be caught by checking=20
+ * for a change in the comparator value. Used in apic.c.
+ */
+void __init wait_hpet_tick(void)
+{
+	unsigned int start_cmp_val, end_cmp_val;
+
+	start_cmp_val =3D hpet_readl(HPET_T0_CMP);
+	do {
+		end_cmp_val =3D hpet_readl(HPET_T0_CMP);
+	} while (start_cmp_val =3D=3D end_cmp_val);
+}
+#endif
+
+/*
+ * Check whether HPET was found by ACPI boot parse. If yes setup HPET=20
+ * counter 0 for kernel base timer.=20
+ */
+int __init hpet_enable(void)
+{
+	unsigned int cfg, id;
+	unsigned long tick_fsec_low, tick_fsec_high; /* tick in femto sec */
+	unsigned long hpet_tick_rem;
+
+	if (boot_hpet_disable)
+		return -1;
+
+	if (!hpet_address) {
+		return -1;
+	}
+	set_fixmap_nocache(FIX_HPET_BASE, hpet_address);
+	printk(KERN_INFO "HPET enabled at %#lx\n", hpet_address);
+
+	/*
+	 * Read the period, compute tick and quotient.
+	 */
+	id =3D hpet_readl(HPET_ID);
+
+	/*
+	 * We are checking for value '1' or more in number field.=20
+	 * So, we are OK with HPET_EMULATE_RTC part too, where we need
+	 * to have atleast 2 timers.
+	 */
+	if (!(id & HPET_ID_NUMBER) ||
+	    !(id & HPET_ID_LEGSUP))
+		return -1;
+
+	if (((id & HPET_ID_VENDOR) >> HPET_ID_VENDOR_SHIFT) !=3D=20
+				HPET_ID_VENDOR_8086)
+		return -1;
+
+	hpet_period =3D hpet_readl(HPET_PERIOD);
+	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > =
HPET_MAX_PERIOD))
+		return -1;
+
+	/*
+	 * 64 bit math
+	 * First changing tick into fsec
+	 * Then 64 bit div to find number of hpet clk per tick
+	 */
+	ASM_MUL64_REG(tick_fsec_low, tick_fsec_high,=20
+			KERNEL_TICK_USEC, FSEC_TO_USEC);
+	ASM_DIV64_REG(hpet_tick, hpet_tick_rem,=20
+			hpet_period, tick_fsec_low, tick_fsec_high);
+
+	if (hpet_tick_rem > (hpet_period >> 1))
+		hpet_tick++; /* rounding the result */
+
+	/*
+	 * Stop the timers and reset the main counter.
+	 */
+	cfg =3D hpet_readl(HPET_CFG);
+	cfg &=3D ~HPET_CFG_ENABLE;
+	hpet_writel(cfg, HPET_CFG);
+	hpet_writel(0, HPET_COUNTER);
+	hpet_writel(0, HPET_COUNTER + 4);
+
+	/*
+	 * Set up timer 0, as periodic with first interrupt to happen at=20
+	 * hpet_tick, and period also hpet_tick.
+	 */
+	cfg =3D hpet_readl(HPET_T0_CFG);
+	cfg |=3D HPET_TN_ENABLE | HPET_TN_PERIODIC |=20
+	       HPET_TN_SETVAL | HPET_TN_32BIT;
+	hpet_writel(cfg, HPET_T0_CFG);
+	hpet_writel(hpet_tick, HPET_T0_CMP);
+
+	/*
+ 	 * Go!
+ 	 */
+	cfg =3D hpet_readl(HPET_CFG);
+	cfg |=3D HPET_CFG_ENABLE | HPET_CFG_LEGACY;
+	hpet_writel(cfg, HPET_CFG);
+
+	use_hpet =3D 1;
+#ifdef CONFIG_X86_LOCAL_APIC
+	wait_timer_tick =3D wait_hpet_tick;
+#endif
+	return 0;
+}
+
+int is_hpet_enabled(void)
+{
+	return use_hpet;
+}
+
+static int __init hpet_setup(char* str)
+{
+	if (str) {
+		if (!strncmp("disable", str, 7))
+			boot_hpet_disable =3D 1;
+	}
+	return 1;
+}
+
+__setup("hpet=3D", hpet_setup);
+
diff -purN linux-2.6.0-test1/include/asm-i386/apic.h =
linux-2.6.0-test1-hpet/include/asm-i386/apic.h
--- linux-2.6.0-test1/include/asm-i386/apic.h	2003-07-13 =
20:38:53.000000000 -0700
+++ linux-2.6.0-test1-hpet/include/asm-i386/apic.h	2003-08-13 =
11:34:37.000000000 -0700
@@ -64,6 +64,8 @@ static inline void ack_APIC_irq(void)
 	apic_write_around(APIC_EOI, 0);
 }
=20
+extern void (*wait_timer_tick)(void);
+
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
diff -purN linux-2.6.0-test1/include/asm-i386/fixmap.h =
linux-2.6.0-test1-hpet/include/asm-i386/fixmap.h
--- linux-2.6.0-test1/include/asm-i386/fixmap.h	2003-07-13 =
20:29:30.000000000 -0700
+++ linux-2.6.0-test1-hpet/include/asm-i386/fixmap.h	2003-08-14 =
13:10:31.000000000 -0700
@@ -44,6 +44,9 @@
 enum fixed_addresses {
 	FIX_HOLE,
 	FIX_VSYSCALL,
+#ifdef CONFIG_HPET_TIMER
+	FIX_HPET_BASE,
+#endif
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
diff -purN linux-2.6.0-test1/include/asm-i386/hpet.h =
linux-2.6.0-test1-hpet/include/asm-i386/hpet.h
--- linux-2.6.0-test1/include/asm-i386/hpet.h	1969-12-31 =
16:00:00.000000000 -0800
+++ linux-2.6.0-test1-hpet/include/asm-i386/hpet.h	2003-08-18 =
20:22:40.000000000 -0700
@@ -0,0 +1,104 @@
+
+#ifndef _I386_HPET_H
+#define _I386_HPET_H
+
+#ifdef CONFIG_HPET_TIMER
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/irq.h>
+#include <asm/msr.h>
+#include <asm/delay.h>
+#include <asm/mpspec.h>
+#include <asm/uaccess.h>
+#include <asm/processor.h>
+
+#include <linux/timex.h>
+#include <linux/config.h>
+
+#include <asm/fixmap.h>
+
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
+#define HPET_T1_CFG	0x120
+#define HPET_T1_CMP	0x128
+#define HPET_T1_ROUTE	0x130
+#define HPET_T2_CFG	0x140
+#define HPET_T2_CMP	0x148
+#define HPET_T2_ROUTE	0x150
+
+#define HPET_ID_VENDOR	0xffff0000
+#define HPET_ID_LEGSUP	0x00008000
+#define HPET_ID_NUMBER	0x00001f00
+#define HPET_ID_REV	0x000000ff
+
+#define HPET_ID_VENDOR_SHIFT	16
+#define HPET_ID_VENDOR_8086	0x8086
+
+#define HPET_CFG_ENABLE	0x001
+#define HPET_CFG_LEGACY	0x002
+
+#define HPET_TN_ENABLE		0x004
+#define HPET_TN_PERIODIC	0x008
+#define HPET_TN_PERIODIC_CAP	0x010
+#define HPET_TN_SETVAL		0x040
+#define HPET_TN_32BIT		0x100
+
+/* Use our own asm for 64 bit multiply/divide */
+#define ASM_MUL64_REG(eax_out,edx_out,reg_in,eax_in) 			\
+		__asm__ __volatile__("mull %2" 				\
+				:"=3Da" (eax_out), "=3Dd" (edx_out) 	\
+				:"r" (reg_in), "0" (eax_in))
+
+#define ASM_DIV64_REG(eax_out,edx_out,reg_in,eax_in,edx_in) 		\
+		__asm__ __volatile__("divl %2" 				\
+				:"=3Da" (eax_out), "=3Dd" (edx_out) 	\
+				:"r" (reg_in), "0" (eax_in), "1" (edx_in))
+
+#define hpet_readl(a)		readl(fix_to_virt(FIX_HPET_BASE) + a)
+#define hpet_writel(d,a)	writel(d, fix_to_virt(FIX_HPET_BASE) + a)
+
+#define KERNEL_TICK_USEC 	(1000000UL/HZ)	/* tick value in microsec */
+/* Max HPET Period is 10^8 femto sec as in HPET spec */
+#define HPET_MAX_PERIOD (100000000UL)
+/*
+ * Min HPET period is 10^5 femto sec just for safety. If it is less =
than this,=20
+ * then 32 bit HPET counter wrapsaround in less than 0.5 sec.=20
+ */
+#define HPET_MIN_PERIOD (100000UL)
+
+extern unsigned long hpet_period;	/* fsecs / HPET clock */
+extern unsigned long hpet_tick;  	/* hpet clks count per tick */
+extern unsigned long hpet_address;	/* hpet memory map address */
+extern unsigned long hpet_virt_address;	/* hpet kernel virtual address =
*/
+
+extern int hpet_enable(void);
+extern int is_hpet_enabled(void);
+
+#endif /* CONFIG_HPET_TIMER */
+#endif /* _I386_HPET_H */
diff -purN linux-2.6.0-test1/include/asm-i386/mc146818rtc.h =
linux-2.6.0-test1-hpet/include/asm-i386/mc146818rtc.h
--- linux-2.6.0-test1/include/asm-i386/mc146818rtc.h	2003-07-13 =
20:36:37.000000000 -0700
+++ linux-2.6.0-test1-hpet/include/asm-i386/mc146818rtc.h	2003-08-18 =
20:23:43.000000000 -0700
@@ -24,6 +24,10 @@ outb_p((addr),RTC_PORT(0)); \
 outb_p((val),RTC_PORT(1)); \
 })
=20
+#ifdef CONFIG_HPET_TIMER
+#define RTC_IRQ 0
+#else
 #define RTC_IRQ 8
+#endif
=20
 #endif /* _ASM_MC146818RTC_H */
diff -purN linux-2.6.0-test1/Documentation/kernel-parameters.txt =
linux-2.6.0-test1-hpet/Documentation/kernel-parameters.txt
--- linux-2.6.0-test1/Documentation/kernel-parameters.txt       =
2003-07-13 20:39:36.000000000 -0700
+++ linux-2.6.0-test1-hpet/Documentation/kernel-parameters.txt  =
2003-08-18 20:37:41.000000000 -0700
@@ -212,7 +212,10 @@ running once the system is up.
			when calculating gettimeofday(). If specicified timesource
			is not avalible, it defaults to PIT.=20
			Format: { pit | tsc | cyclone | ... }
-
+
+	hpet=3D		[IA-32,HPET] option to disable HPET and use PIT.
+			Format: disable
+
	cm206=3D		[HW,CD]
			Format: { auto | [<io>,][<irq>] }
=20



------_=_NextPart_001_01C36686.E36BC59E
Content-Type: application/x-zip-compressed;
	name="hpet2.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet2.ZIP
Content-Disposition: attachment;
	filename="hpet2.ZIP"

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

------_=_NextPart_001_01C36686.E36BC59E--

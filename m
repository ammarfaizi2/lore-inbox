Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTH1Xrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTH1Xrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:47:36 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:31712 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S264460AbTH1Xop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:44:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DBE.54AAF1B0"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6-test4][4/6]Support for HPET based timer
Date: Thu, 28 Aug 2003 16:44:32 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D215@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6-test4][4/6]Support for HPET based timer
Thread-Index: AcNtvlSb62V6VLi3Tf2KzqO+CnHEdg==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 28 Aug 2003 23:44:33.0204 (UTC) FILETIME=[54E56740:01C36DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DBE.54AAF1B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

4/6 - hpet4.patch - All the changes required to use HPET in place
                    of PIT as the kernel base-timer at IRQ 0.



diff -purN linux-2.6.0-test4/arch/i386/kernel/apic.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/apic.c
--- linux-2.6.0-test4/arch/i386/kernel/apic.c	2003-08-22 =
17:03:01.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/apic.c	2003-08-28 =
12:18:15.000000000 -0700
@@ -34,6 +34,7 @@
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/hpet.h>
=20
 #include <mach_apic.h>
=20
@@ -779,7 +780,8 @@ static unsigned int __init get_8254_time
 	return count;
 }
=20
-void __init wait_8254_wraparound(void)
+/* next tick in 8254 can be caught by catching timer wraparound */
+static void __init wait_8254_wraparound(void)
 {
 	unsigned int curr_count, prev_count=3D~0;
 	int delta;
@@ -801,6 +803,12 @@ void __init wait_8254_wraparound(void)
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
@@ -841,7 +849,7 @@ static void setup_APIC_timer(unsigned in
 	/*
 	 * Wait for IRQ0's slice:
 	 */
-	wait_8254_wraparound();
+	wait_timer_tick();
=20
 	__setup_APIC_LVTT(clocks);
=20
@@ -884,7 +892,7 @@ int __init calibrate_APIC_clock(void)
 	 * (the current tick might have been already half done)
 	 */
=20
-	wait_8254_wraparound();
+	wait_timer_tick();
=20
 	/*
 	 * We wrapped around just now. Let's start:
@@ -897,7 +905,7 @@ int __init calibrate_APIC_clock(void)
 	 * Let's wait LOOPS wraprounds:
 	 */
 	for (i =3D 0; i < LOOPS; i++)
-		wait_8254_wraparound();
+		wait_timer_tick();
=20
 	tt2 =3D apic_read(APIC_TMCCT);
 	if (cpu_has_tsc)
diff -purN linux-2.6.0-test4/arch/i386/kernel/time.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/time.c
--- linux-2.6.0-test4/arch/i386/kernel/time.c	2003-08-22 =
16:55:44.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/time.c	2003-08-28 =
12:18:15.000000000 -0700
@@ -60,6 +60,8 @@
 #include <linux/timex.h>
 #include <linux/config.h>
=20
+#include <asm/hpet.h>
+
 #include <asm/arch_hooks.h>
=20
 #include "io_ports.h"
@@ -291,8 +293,38 @@ static int time_init_device(void)
=20
 device_initcall(time_init_device);
=20
+#ifdef CONFIG_HPET_TIMER
+extern void (*late_time_init)(void);
+/* Duplicate of time_init() below, with hpet_enable part added */
+void __init hpet_time_init(void)
+{
+	xtime.tv_sec =3D get_cmos_time();
+	wall_to_monotonic.tv_sec =3D -xtime.tv_sec;
+	xtime.tv_nsec =3D (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+	wall_to_monotonic.tv_nsec =3D -xtime.tv_nsec;
+
+	if (hpet_enable() >=3D 0) {
+		printk("Using HPET for base-timer\n");
+	}
+
+	cur_timer =3D select_timer();
+	time_init_hook();
+}
+#endif
+
 void __init time_init(void)
 {
+#ifdef CONFIG_HPET_TIMER
+	if (is_hpet_capable()) {
+		/*
+		 * HPET initialization needs to do memory-mapped io. So, let
+		 * us do a late initialization after mem_init().
+		 */
+		late_time_init =3D hpet_time_init;
+		return;
+	}
+#endif
+
 	xtime.tv_sec =3D get_cmos_time();
 	wall_to_monotonic.tv_sec =3D -xtime.tv_sec;
 	xtime.tv_nsec =3D (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
diff -purN linux-2.6.0-test4/arch/i386/kernel/time_hpet.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/time_hpet.c
--- linux-2.6.0-test4/arch/i386/kernel/time_hpet.c	1969-12-31 =
16:00:00.000000000 -0800
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/time_hpet.c	2003-08-28 =
12:20:34.000000000 -0700
@@ -0,0 +1,171 @@
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
+unsigned long hpet_address;	/* hpet memory map physical address */
+
+static int use_hpet; 		/* can be used for runtime check of hpet */
+static int boot_hpet_disable; 	/* boottime override for HPET timer */
+static unsigned long hpet_virt_address;	/* hpet kernel virtual address =
*/
+
+#define FSEC_TO_USEC (1000000000UL)
+
+int hpet_readl(unsigned long a)
+{
+	return readl(hpet_virt_address + a);
+}
+
+void hpet_writel(unsigned long d, unsigned long a)
+{
+	writel(d, hpet_virt_address + a);
+}
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
+	hpet_virt_address =3D (unsigned long) ioremap_nocache(hpet_address,=20
+	                                                    HPET_MMAP_SIZE);
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
+int is_hpet_capable(void)
+{
+	if (!boot_hpet_disable && hpet_address)
+		return 1;
+	return 0;
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
+
diff -purN linux-2.6.0-test4/include/asm-i386/apic.h =
linux-2.6.0-test4-hpet/include/asm-i386/apic.h
--- linux-2.6.0-test4/include/asm-i386/apic.h	2003-08-22 =
17:02:02.000000000 -0700
+++ linux-2.6.0-test4-hpet/include/asm-i386/apic.h	2003-08-28 =
12:18:15.000000000 -0700
@@ -64,6 +64,8 @@ static inline void ack_APIC_irq(void)
 	apic_write_around(APIC_EOI, 0);
 }
=20
+extern void (*wait_timer_tick)(void);
+
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
diff -purN linux-2.6.0-test4/include/asm-i386/hpet.h =
linux-2.6.0-test4-hpet/include/asm-i386/hpet.h
--- linux-2.6.0-test4/include/asm-i386/hpet.h	1969-12-31 =
16:00:00.000000000 -0800
+++ linux-2.6.0-test4-hpet/include/asm-i386/hpet.h	2003-08-28 =
12:21:19.000000000 -0700
@@ -0,0 +1,106 @@
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
+#define HPET_MMAP_SIZE	1024
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
+extern unsigned long hpet_address;	/* hpet memory map physical address =
*/
+
+extern int hpet_rtc_timer_init(void);
+extern int hpet_enable(void);
+extern int is_hpet_enabled(void);
+extern int is_hpet_capable(void);
+extern int hpet_readl(unsigned long a);
+extern void hpet_writel(unsigned long d, unsigned long a);
+
+#endif /* CONFIG_HPET_TIMER */
+#endif /* _I386_HPET_H */
diff -purN linux-2.6.0-test4/include/asm-i386/mc146818rtc.h =
linux-2.6.0-test4-hpet/include/asm-i386/mc146818rtc.h
--- linux-2.6.0-test4/include/asm-i386/mc146818rtc.h	2003-08-22 =
16:58:00.000000000 -0700
+++ linux-2.6.0-test4-hpet/include/asm-i386/mc146818rtc.h	2003-08-28 =
12:22:14.000000000 -0700
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



------_=_NextPart_001_01C36DBE.54AAF1B0
Content-Type: application/x-zip-compressed;
	name="hpet04.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet04.ZIP
Content-Disposition: attachment;
	filename="hpet04.ZIP"

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
AAAA

------_=_NextPart_001_01C36DBE.54AAF1B0--

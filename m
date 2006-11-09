Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424271AbWKIXkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424271AbWKIXkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424267AbWKIXkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:40:06 -0500
Received: from www.osadl.org ([213.239.205.134]:65180 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161870AbWKIXjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:11 -0500
Message-Id: <20061109233035.226521000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:27 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 10/19] PM_timer: allow early access and move externs to a
	header file
Content-Disposition: inline; filename=pm-timer-allow-early-access.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allow early access to the power management timer by exposing
the verified read function and providing a helper function
which checks the pmtmr_ioport variable and returns either the
pm timer readout or 0 in case the pm timer is not available.

Create a new header file and replace also the ifdef'ed extern
definition in arch/i386/kernel/acpi/boot.c

This is a preperatory patch for the rework of the local apic timer
calibration.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.19-rc5-mm1/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/arch/i386/kernel/acpi/boot.c	2006-11-09 20:55:37.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/acpi/boot.c	2006-11-09 21:06:19.000000000 +0100
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/acpi_pmtmr.h>
 #include <linux/efi.h>
 #include <linux/cpumask.h>
 #include <linux/module.h>
@@ -702,10 +703,6 @@ static int __init acpi_parse_hpet(unsign
 #define	acpi_parse_hpet	NULL
 #endif
 
-#ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
-#endif
-
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
 {
 	struct fadt_descriptor *fadt = NULL;
Index: linux-2.6.19-rc5-mm1/drivers/clocksource/acpi_pm.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/drivers/clocksource/acpi_pm.c	2006-11-09 20:55:37.000000000 +0100
+++ linux-2.6.19-rc5-mm1/drivers/clocksource/acpi_pm.c	2006-11-09 21:06:19.000000000 +0100
@@ -16,15 +16,13 @@
  * This file is licensed under the GPL v2.
  */
 
+#include <linux/acpi_pmtmr.h>
 #include <linux/clocksource.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
 
-/* Number of PMTMR ticks expected during calibration run */
-#define PMTMR_TICKS_PER_SEC 3579545
-
 /*
  * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -32,15 +30,13 @@
  */
 u32 pmtmr_ioport __read_mostly;
 
-#define ACPI_PM_MASK CLOCKSOURCE_MASK(24) /* limit it to 24 bits */
-
 static inline u32 read_pmtmr(void)
 {
 	/* mask the output to 24 bits */
 	return inl(pmtmr_ioport) & ACPI_PM_MASK;
 }
 
-static cycle_t acpi_pm_read_verified(void)
+u32 acpi_pm_read_verified(void)
 {
 	u32 v1 = 0, v2 = 0, v3 = 0;
 
@@ -57,7 +53,12 @@ static cycle_t acpi_pm_read_verified(voi
 	} while (unlikely((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
 			  || (v3 > v1 && v3 < v2)));
 
-	return (cycle_t)v2;
+	return v2;
+}
+
+static cycle_t acpi_pm_read_slow(void)
+{
+	return (cycle_t)acpi_pm_read_verified();
 }
 
 static cycle_t acpi_pm_read(void)
@@ -87,7 +88,7 @@ __setup("acpi_pm_good", acpi_pm_good_set
 
 static inline void acpi_pm_need_workaround(void)
 {
-	clocksource_acpi_pm.read = acpi_pm_read_verified;
+	clocksource_acpi_pm.read = acpi_pm_read_slow;
 	clocksource_acpi_pm.rating = 110;
 }
 
Index: linux-2.6.19-rc5-mm1/include/linux/acpi_pmtmr.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.19-rc5-mm1/include/linux/acpi_pmtmr.h	2006-11-09 21:06:19.000000000 +0100
@@ -0,0 +1,38 @@
+#ifndef _ACPI_PMTMR_H_
+#define _ACPI_PMTMR_H_
+
+#include <linux/clocksource.h>
+
+/* Number of PMTMR ticks expected during calibration run */
+#define PMTMR_TICKS_PER_SEC 3579545
+
+/* limit it to 24 bits */
+#define ACPI_PM_MASK CLOCKSOURCE_MASK(24)
+
+/* Overrun value */
+#define ACPI_PM_OVRRUN	1<<24
+
+#ifdef CONFIG_X86_PM_TIMER
+
+extern u32 acpi_pm_read_verified(void);
+extern u32 pmtmr_ioport;
+
+static inline u32 acpi_pm_read_early(void)
+{
+	if (!pmtmr_ioport)
+		return 0;
+	/* mask the output to 24 bits */
+	return acpi_pm_read_verified();
+}
+
+#else
+
+static inline u32 acpi_pm_read_early(void)
+{
+	return 0;
+}
+
+#endif
+
+#endif
+

--


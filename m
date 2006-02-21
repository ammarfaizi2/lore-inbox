Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161405AbWBUGW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161405AbWBUGW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161404AbWBUGWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:63914 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161457AbWBUGWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:22:14 -0500
Date: Mon, 20 Feb 2006 23:22:12 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Message-Id: <20060221062211.13304.10499.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 11/11]Time: i386 clocksource drivers - backout pmtmr changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sync up with changes to avoid pmtmr x86-64 collision. 

In order to avoid bisection troubles, this patch must be folded into 
its parent (time-i386-clocksource-drivers.patch) as the parent will 
fail to build.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 drivers/clocksource/Makefile  |    2 +-
 drivers/clocksource/acpi_pm.c |   13 ++++---------
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: mm-merge/drivers/clocksource/acpi_pm.c
===================================================================
--- mm-merge.orig/drivers/clocksource/acpi_pm.c
+++ mm-merge/drivers/clocksource/acpi_pm.c
@@ -24,25 +24,20 @@
 /* Number of PMTMR ticks expected during calibration run */
 #define PMTMR_TICKS_PER_SEC 3579545
 
-#if (defined(CONFIG_X86) && (!defined(CONFIG_X86_64)))
-# include "mach_timer.h"
-# define PMTMR_EXPECTED_RATE ((PMTMR_TICKS_PER_SEC*CALIBRATE_TIME_MSEC)/1000)
-#endif
-
 /*
  * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
  * in arch/i386/acpi/boot.c
  */
-extern u32 acpi_pmtmr_ioport;
-extern int acpi_pmtmr_buggy;
+u32 pmtmr_ioport;
+int acpi_pmtmr_buggy;
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
 static inline u32 read_pmtmr(void)
 {
 	/* mask the output to 24 bits */
-	return inl(acpi_pmtmr_ioport) & ACPI_PM_MASK;
+	return inl(pmtmr_ioport) & ACPI_PM_MASK;
 }
 
 static cycle_t acpi_pm_read_verified(void)
@@ -85,7 +80,7 @@ static int __init init_acpi_pm_clocksour
 	u32 value1, value2;
 	unsigned int i;
 
-	if (!acpi_pmtmr_ioport)
+	if (!pmtmr_ioport)
 		return -ENODEV;
 
 	clocksource_acpi_pm.mult = clocksource_hz2mult(PMTMR_TICKS_PER_SEC,
Index: mm-merge/drivers/clocksource/Makefile
===================================================================
--- mm-merge.orig/drivers/clocksource/Makefile
+++ mm-merge/drivers/clocksource/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_X86_CYCLONE_TIMER) += cyclone.o
-obj-$(CONFIG_ACPI) += acpi_pm.o
+obj-$(CONFIG_X86_PM_TIMER) += acpi_pm.o

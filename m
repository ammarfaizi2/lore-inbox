Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937671AbWLFVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937671AbWLFVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937676AbWLFVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:42:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46482 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937671AbWLFVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:42:24 -0500
Subject: [PATCH -mm] [Time] Re-add verify_pmtmr_rate
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ian Campbell <ijc@hellion.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 13:42:14 -0800
Message-Id: <1165441334.6729.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	This should go for a round or two in -mm but should be good for
inclusion into 2.6.20.

This patch re-adds the verify_pmtmr_rate functionality from 2.6.17 that
I dropped 2.6.18.

This resolves problems seen on older K6 ASUS boards where the ACPI PM
timer runs too fast.

See: 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=211902
http://bugme.osdl.org/show_bug.cgi?id=2375

Thanks to Ian Campbell for re-reporting this and testing the fix!

Signed-off-by: John Stultz <johnstul@us.ibm.com>

---
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 7fcb77a..8ab61ef 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -142,6 +142,39 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SE
 			acpi_pm_check_graylist);
 #endif
 
+#ifndef CONFIG_X86_64
+#include "mach_timer.h"
+#define PMTMR_EXPECTED_RATE \
+  ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
+/*
+ * Some boards have the PMTMR running way too fast. We check
+ * the PMTMR rate against PIT channel 2 to catch these cases.
+ */
+static int verify_pmtmr_rate(void)
+{
+	u32 value1, value2;
+	unsigned long count, delta;
+
+	mach_prepare_counter();
+	value1 = read_pmtmr();
+	mach_countup(&count);
+	value2 = read_pmtmr();
+	delta = (value2 - value1) & ACPI_PM_MASK;
+
+	/* Check that the PMTMR delta is within 5% of what we expect */
+	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
+	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
+		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% "
+			"of normal - aborting.\n",
+			100UL * delta / PMTMR_EXPECTED_RATE);
+		return -1;
+	}
+
+	return 0;
+}
+#else
+#define verify_pmtmr_rate() (0)
+#endif
 
 static int __init init_acpi_pm_clocksource(void)
 {
@@ -173,6 +206,9 @@ static int __init init_acpi_pm_clocksour
 	return -ENODEV;
 
 pm_good:
+	if (verify_pmtmr_rate() != 0)
+		return -ENODEV;
+
 	return clocksource_register(&clocksource_acpi_pm);
 }
 



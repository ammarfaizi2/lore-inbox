Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWB0WA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWB0WA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWB0WAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:00:55 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:18631 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932347AbWB0WAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:00:55 -0500
Date: Mon, 27 Feb 2006 16:57:53 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: clean up timer messages
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602271700_MC3-1-B969-F4A4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix verbosity level for x86_64 io-apic timer messages. These appear when
using ATI chipset systems with -rc5. Also, make exact APIC timer speed
message depend on APIC_VERBOSE.

Before:
	CPU: AMD Turion(tm) 64 Mobile Technology ML-28 stepping 02
	..MP-BIOS bug: 8254 timer not connected to IO-APIC
	 failed.
	 works.
	Using local APIC timer interrupts.
	result 12500904
	Detected 12.500 MHz APIC timer.

After:
	CPU: AMD Turion(tm) 64 Mobile Technology ML-28 stepping 02
	Using local APIC timer interrupts.
	Detected 12.500 MHz APIC timer.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/x86_64/kernel/apic.c    |    3 +--
 arch/x86_64/kernel/io_apic.c |   11 ++++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

--- 2.6.16-rc5-64.orig/arch/x86_64/kernel/io_apic.c
+++ 2.6.16-rc5-64/arch/x86_64/kernel/io_apic.c
@@ -1834,8 +1834,9 @@ static inline void check_timer(void)
 			return;
 		}
 		clear_IO_APIC_pin(apic1, pin1);
-		apic_printk(APIC_QUIET,KERN_ERR "..MP-BIOS bug: 8254 timer not "
-				"connected to IO-APIC\n");
+		if (timer_over_8254 > 0)
+			apic_printk(APIC_QUIET,KERN_ERR "..MP-BIOS bug: 8254 "
+					"timer not connected to IO-APIC\n");
 	}
 
 	apic_printk(APIC_VERBOSE,KERN_INFO "...trying to set up timer (IRQ0) "
@@ -1848,7 +1849,7 @@ static inline void check_timer(void)
 		 */
 		setup_ExtINT_IRQ0_pin(apic2, pin2, vector);
 		if (timer_irq_works()) {
-			printk("works.\n");
+			apic_printk(APIC_VERBOSE," works.\n");
 			nmi_watchdog_default();
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
@@ -1860,7 +1861,7 @@ static inline void check_timer(void)
 		 */
 		clear_IO_APIC_pin(apic2, pin2);
 	}
-	printk(" failed.\n");
+	apic_printk(APIC_VERBOSE," failed.\n");
 
 	if (nmi_watchdog == NMI_IO_APIC) {
 		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
@@ -1875,7 +1876,7 @@ static inline void check_timer(void)
 	enable_8259A_irq(0);
 
 	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, " works.\n");
+		apic_printk(APIC_VERBOSE," works.\n");
 		return;
 	}
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
--- 2.6.16-rc5-64.orig/arch/x86_64/kernel/apic.c
+++ 2.6.16-rc5-64/arch/x86_64/kernel/apic.c
@@ -786,8 +786,7 @@ static int __init calibrate_APIC_clock(v
 		result = (apic_start - apic) * 1000L * cpu_khz /
 					(tsc - tsc_start);
 	}
-	printk("result %d\n", result);
-
+	apic_printk(APIC_VERBOSE,KERN_INFO "result %d\n", result);
 
 	printk(KERN_INFO "Detected %d.%03d MHz APIC timer.\n",
 		result / 1000 / 1000, result / 1000 % 1000);
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWFAOXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWFAOXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWFAOXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:23:43 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:24637 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1750987AbWFAOXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:23:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 1/1] 2.6.17-rc5 patch for HPET operation on NVIDIA platforms
Date: Thu, 1 Jun 2006 07:23:37 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A15D0E4D7@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] 2.6.17-rc5 patch for HPET operation on NVIDIA platforms
Thread-Index: AcaFhvvbcfY4gY7GStKhuvbCGMGGfg==
From: "Andy Currid" <ACurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Jun 2006 14:23:38.0241 (UTC) FILETIME=[F95D9710:01C68586]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes a kernel panic during boot that occurs on NVIDIA
platforms that have
HPET enabled. When HPET is enabled, the standard timer IRQ is routed to
IOAPIC pin 2
and is advertised as such in the ACPI APIC table - but an earlier
workaround in the
kernel was ignoring this override. The fix is to honor timer IRQ
overrides from ACPI
when HPET is detected on an NVIDIA platform.

32-bit kernel patch:

Signed-off-by: Andy Currid <acurrid@nvidia.com>

diff -u linux-2.6.17-rc5-patch/arch/i386/kernel/acpi/earlyquirk.c
linux-2.6.17-rc5/arch/i386/kernel/acpi/earlyquirk.c
--- linux-2.6.17-rc5/arch/i386/kernel/acpi/earlyquirk.c	2006-03-19
22:53:29.000000000 -0700
+++ linux-2.6.17-rc5-patch/arch/i386/kernel/acpi/earlyquirk.c
2006-05-27 16:03:59.000000000 -0600
@@ -9,13 +9,30 @@
 #include <asm/acpi.h>
 #include <asm/apic.h>
 
+#ifdef CONFIG_ACPI
+
+#include <linux/acpi.h>
+
+static int nvidia_hpet_detected __initdata;
+
+static int __init nvidia_hpet_check(unsigned long phys, unsigned long
size)
+{
+	nvidia_hpet_detected = 1;
+	return 0;
+}
+#endif
+
 static int __init check_bridge(int vendor, int device)
 {
 #ifdef CONFIG_ACPI
-	/* According to Nvidia all timer overrides are bogus. Just
ignore
-	   them all. */
+	/* According to Nvidia all timer overrides are bogus unless HPET
+	   is enabled. */
 	if (vendor == PCI_VENDOR_ID_NVIDIA) {
-		acpi_skip_timer_override = 1;
+		nvidia_hpet_detected = 0;
+		acpi_table_parse(ACPI_HPET, nvidia_hpet_check);
+		if (nvidia_hpet_detected == 0) {
+			acpi_skip_timer_override = 1;
+		}
 	}
 #endif
 	if (vendor == PCI_VENDOR_ID_ATI && timer_over_8254 == 1) {

diff -u linux-2.6.17-rc5/arch/i386/kernel/setup.c
linux-2.6.17-rc5-patch/arch/i386/kernel/acpi/setup.c
--- linux-2.6.17-rc5/arch/i386/kernel/setup.c	2006-05-27
13:00:34.000000000 -0600
+++ linux-2.6.17-rc5-patch/arch/i386/kernel/setup.c	2006-05-27
15:38:38.000000000 -0600
@@ -1547,15 +1547,18 @@
 	if (efi_enabled)
 		efi_map_memmap();
 
-#ifdef CONFIG_X86_IO_APIC
-	check_acpi_pci();	/* Checks more than just ACPI actually
*/
-#endif
-
 #ifdef CONFIG_ACPI
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP
configuration.
 	 */
 	acpi_boot_table_init();
+#endif
+
+#ifdef CONFIG_X86_IO_APIC
+	check_acpi_pci();	/* Checks more than just ACPI actually
*/
+#endif
+
+#ifdef CONFIG_ACPI
 	acpi_boot_init();
 
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_PC)
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

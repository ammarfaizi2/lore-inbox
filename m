Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWFAOXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWFAOXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFAOXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:23:41 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:23101 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1750973AbWFAOXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:23:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 0/1] 2.6.17-rc5 patch for HPET operation on NVIDIA platforms
Date: Thu, 1 Jun 2006 07:23:36 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A15D0E4D6@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/1] 2.6.17-rc5 patch for HPET operation on NVIDIA platforms
Thread-Index: AcaFhvrmLspUKnLaS4qKZhJ2FNLmAw==
From: "Andy Currid" <ACurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Jun 2006 14:23:36.0710 (UTC) FILETIME=[F873FA60:01C68586]
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

64-bit kernel patch:

Signed-off-by: Andy Currid <acurrid@nvidia.com>

diff -u linux-2.6.17-rc5/arch/x86_64/kernel/io_apic.c
linux-2.6.17-rc5-patch/arch/x86_64/kernel/io_apic.c 
--- linux-2.6.17-rc5/arch/x86_64/kernel/io_apic.c	2006-05-27
15:38:26.000000000 -0700
+++ linux-2.6.17-rc5-patch/arch/x86_64/kernel/io_apic.c	2006-05-27
16:33:55.000000000 -0700
@@ -271,6 +271,18 @@
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
 
+
+#ifdef CONFIG_ACPI
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
 /* Temporary Hack. Nvidia and VIA boards currently only work with
IO-APIC
    off. Check for an Nvidia or VIA PCI bridge and turn it off.
    Use pci direct infrastructure because this runs before the PCI
subsystem. 
@@ -317,11 +329,15 @@
 					return;
 				case PCI_VENDOR_ID_NVIDIA:
 #ifdef CONFIG_ACPI
-					/* All timer overrides on Nvidia
-				           seem to be wrong. Skip them.
*/
-					acpi_skip_timer_override = 1;
-					printk(KERN_INFO 
-	     "Nvidia board detected. Ignoring ACPI timer override.\n");
+					/* All timer overrides on Nvidia
are wrong unless HPET
+				           is enabled. */
+					nvidia_hpet_detected = 0;
+					acpi_table_parse(ACPI_HPET,
nvidia_hpet_check);
+					if (nvidia_hpet_detected == 0) {
+						acpi_skip_timer_override
= 1;
+						printk(KERN_INFO 
+		     "Nvidia board detected. Ignoring ACPI timer
override.\n");
+					}
 #endif
 					/* RED-PEN skip them on mptables
too? */
 					return;

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

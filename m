Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUALCzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUALCzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:55:25 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:3799 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266010AbUALCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:55:22 -0500
Subject: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Jan 2004 21:55:16 -0500
Message-Id: <1073876117.2549.65.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The intel alder motherboard really dislikes the way the current kernel
reassigns all PCI resources.  It exports 6 memory bars from its Extended
Express System Support Controller, but if the system touches any of
them, it disables the secondary IO-APIC.

The system is bootable if you disable all IO-APICs apart from the
primary, but it does become a bit crowded in interrupt space.  The patch
fixes the problem by adding a quirk to clear the first six memory bars.

James

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1530  -> 1.1531 
#	drivers/pci/quirks.c	1.38    -> 1.39   
#	include/linux/pci_ids.h	1.130   -> 1.131  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/11	root@claymoor.il.steeleye.com	1.1531
# Fix intel alder boot failure
# 
# The alder has an intel Extended Express System Support Controller
# which presents apparently spurious BARs.  When the pci resource
# code tries to reassign these BARs, the second IO-APIC gets disabled
# (with disastrous consequences).
# 
# The patch adds a quirk to clear these BARs.
# --------------------------------------------
#
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Sun Jan 11 20:51:06 2004
+++ b/drivers/pci/quirks.c	Sun Jan 11 20:51:06 2004
@@ -786,6 +786,28 @@
 	sis_96x_compatible = 1;
 }
 
+#ifdef CONFIG_X86_IO_APIC
+static void __init quirk_alder_ioapic(struct pci_dev *pdev)
+{
+	struct resource *res;
+	int i;
+	
+	if ((pdev->class >> 8) != 0xff00)
+		return;
+	
+	res = &pdev->resource[0];
+	/* The first six bars must be cleared otherwise the IO-APIC
+	 * will throw a wobbly when the pci resource allocation tries
+	 * to reassign them */
+	for(i=0; i < 6; i++) {
+		res[i].start = 0;
+		res[i].end = 0;
+		res[i].flags = 0;
+	}
+	
+}
+#endif
+
 #ifdef CONFIG_SCSI_SATA
 static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
 {
@@ -910,6 +932,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw },
         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,
           quirk_amd_8131_ioapic }, 
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic },
 #endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sun Jan 11 20:51:06 2004
+++ b/include/linux/pci_ids.h	Sun Jan 11 20:51:06 2004
@@ -1901,6 +1901,7 @@
 #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
 
 #define PCI_VENDOR_ID_INTEL		0x8086
+#define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_21145	0x0039
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483


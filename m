Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUAMQwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAMQwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:52:45 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:38577 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264473AbUAMQwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:52:39 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave> 
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave> 
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave> 
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Jan 2004 11:52:34 -0500
Message-Id: <1074012755.2173.135.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 19:25, Linus Torvalds wrote:
> I think BARs 1-5 don't exist at all. Being set to all ones is common for
> "unused" (it ends up being a normal result of a lazy probe - you set all 
> bits to 1 to check for the size of the region, and if you decide not to 
> map it and leave it there, you'll get the above behaviour).
> 
> I suspect only BAR0 is actually real.

OK, I cleaned up the patch to forcibly insert BAR0 and clear BARs 1-5
(it still requires changes to insert_resource to work, though).

> What's in that ffe80000-ffffffff region that the BIOS has allocated,
> anyway?

I don't know...it comes from the BIOS-e820 map:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)

James

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1530  -> 1.1532 
#	drivers/pci/quirks.c	1.38    -> 1.40   
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
# 04/01/13	root@claymoor.il.steeleye.com	1.1532
# update the alder quirk
# --------------------------------------------
#
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Tue Jan 13 10:49:13 2004
+++ b/drivers/pci/quirks.c	Tue Jan 13 10:49:13 2004
@@ -786,6 +786,29 @@
 	sis_96x_compatible = 1;
 }
 
+#ifdef CONFIG_X86_IO_APIC
+static void __init quirk_alder_ioapic(struct pci_dev *pdev)
+{
+	int i;
+	
+	if ((pdev->class >> 8) != 0xff00)
+		return;
+	
+	/* the first BAR is the location of the IO APIC...we must
+	 * not touch this (and it's already covered by the fixmap), so
+	 * forcibly insert it into the resource tree */
+	if(pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
+		insert_resource(&iomem_resource, &pdev->resource[0]);
+
+	/* The next five BARs all seem to be rubbish, so just clean
+	 * them out */
+	for(i=1; i < 6; i++) {
+		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
+	}
+	
+}
+#endif
+
 #ifdef CONFIG_SCSI_SATA
 static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
 {
@@ -910,6 +933,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw },
         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,
           quirk_amd_8131_ioapic }, 
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic },
 #endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Jan 13 10:49:13 2004
+++ b/include/linux/pci_ids.h	Tue Jan 13 10:49:13 2004
@@ -1901,6 +1901,7 @@
 #define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
 
 #define PCI_VENDOR_ID_INTEL		0x8086
+#define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_21145	0x0039
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483


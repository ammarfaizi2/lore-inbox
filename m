Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVCFU2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVCFU2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVCFU2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:28:37 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:18532 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261490AbVCFU2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:28:13 -0500
Date: Sun, 6 Mar 2005 22:28:45 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, mj@ucw.cz
Cc: openib-general@openib.org
Subject: [PATCH] disable MSI for AMD-8131
Message-ID: <20050306202845.GE8486@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Martin,

The AMD-8131 I/O APIC (device id 1022:7450/7451) does not support message
signalled interrupts. Thus, if a device driver attempts to enable msi,
it will suceed, but interrupts are not actually delivered to the cpu.
The Nforce chipsets do not seem to have this limitation.
AMD confirmed that MSI mode is unsupported with this APIC.

The following patch adds a flag to pci quirks to detect this and disable msi.

Please let me know what do you think.

Signed-off-by: Michael S. Tsirkin <mst@mellano.co.il>


diff -rup linux-2.6.11/drivers/pci/msi.c linux-2.6.11-msi/drivers/pci/msi.c
--- linux-2.6.11/drivers/pci/msi.c	2005-03-02 09:38:26.000000000 +0200
+++ linux-2.6.11-msi/drivers/pci/msi.c	2005-05-21 23:29:08.000000000 +0300
@@ -20,6 +20,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 
+#include "pci.h"
 #include "msi.h"
 
 static DEFINE_SPINLOCK(msi_lock);
@@ -372,6 +373,13 @@ static int msi_init(void)
 	if (!status)
 		return status;
 
+	if (pci_msi_quirk) {
+		pci_msi_enable = 0;
+		printk(KERN_WARNING "PCI: MSI quirk detected. MSI disabled.\n");
+		status = -EINVAL;
+		return status;
+	}
+
 	if ((status = msi_cache_init()) < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: MSI cache init failed\n");
diff -rup linux-2.6.11/drivers/pci/pci.h linux-2.6.11-msi/drivers/pci/pci.h
--- linux-2.6.11/drivers/pci/pci.h	2005-03-02 09:37:55.000000000 +0200
+++ linux-2.6.11-msi/drivers/pci/pci.h	2005-05-21 22:28:21.000000000 +0300
@@ -65,6 +65,7 @@ extern void pci_remove_legacy_files(stru
 extern spinlock_t pci_bus_lock;
 
 extern int pcie_mch_quirk;
+extern int pci_msi_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;
 
diff -rup linux-2.6.11/drivers/pci/quirks.c linux-2.6.11-msi/drivers/pci/quirks.c
--- linux-2.6.11/drivers/pci/quirks.c	2005-03-02 09:37:31.000000000 +0200
+++ linux-2.6.11-msi/drivers/pci/quirks.c	2005-05-21 22:35:45.000000000 +0300
@@ -429,6 +429,8 @@ static void __init quirk_ioapic_rmw(stru
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw );
 
+int pci_msi_quirk;
+
 #define AMD8131_revA0        0x01
 #define AMD8131_revB0        0x11
 #define AMD8131_MISC         0x40
@@ -437,6 +439,9 @@ static void __init quirk_amd_8131_ioapic
 { 
         unsigned char revid, tmp;
         
+	pci_msi_quirk = 1;
+	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
+
         if (nr_ioapics == 0) 
                 return;
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVKHNlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVKHNlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKHNlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:41:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41430 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932313AbVKHNle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:41:34 -0500
Subject: PATCH: Update the AMD driver to support the AMD CS5536. Also add
	enablebit support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 14:12:22 +0000
Message-Id: <1131459142.25192.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This brings it back into line with the drivers/ide code. The full 5536
PCI identifiers are included. Trim to preference obviously

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm1/drivers/scsi/pata_amd.c linux-2.6.14-mm1/drivers/scsi/pata_amd.c
--- linux.vanilla-2.6.14-mm1/drivers/scsi/pata_amd.c	2005-11-07 13:06:24.000000000 +0000
+++ linux-2.6.14-mm1/drivers/scsi/pata_amd.c	2005-11-07 15:32:57.000000000 +0000
@@ -30,7 +30,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.1"
+#define DRV_VERSION "0.1.2"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -147,6 +147,17 @@
 
 static void amd_phy_reset(struct ata_port *ap)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	static struct pci_bits amd_enable_bits[] = {
+		{ 0x40, 0x02, 0x02 },
+		{ 0x40, 0x01, 0x01 }
+	};
+
+	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->hard_port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return;
+	}
 	ap->cbl = amd_cable_detect(ap);
 	ata_bus_reset(ap);
 	ata_port_probe(ap);
@@ -471,7 +482,7 @@
 
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	static struct ata_port_info info[9] = {
+	static struct ata_port_info info[10] = {
 		{	/* 0: AMD 7401 */
 			.sht = &amd_sht,
 			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
@@ -543,6 +554,14 @@
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x7f,	/* UDMA 133, no swdma */
 			.port_ops = &nv133_port_ops
+		},
+		{	/* 9: AMD CS5536 (Geode companion) */
+			.sht = &amd_sht,
+			.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+			.pio_mask = 0x1f,
+			.mwdma_mask = 0x07,
+			.udma_mask = 0x3f,	/* UDMA 100 */
+			.port_ops = &amd100_port_ops
 		}
 	};
 	static struct ata_port_info *port_info[2];
@@ -590,6 +609,7 @@
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9 },
 	{ 0, },
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm1/include/linux/pci_ids.h linux-2.6.14-mm1/include/linux/pci_ids.h
--- linux.vanilla-2.6.14-mm1/include/linux/pci_ids.h	2005-11-07 13:06:25.000000000 +0000
+++ linux-2.6.14-mm1/include/linux/pci_ids.h	2005-11-07 13:53:12.000000000 +0000
@@ -490,6 +490,14 @@
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
 #define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
+#define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
+#define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
+#define PCI_DEVICE_ID_AMD_CS5536_AUDIO  0x2093
+#define PCI_DEVICE_ID_AMD_CS5536_OHC    0x2094
+#define PCI_DEVICE_ID_AMD_CS5536_EHC    0x2095
+#define PCI_DEVICE_ID_AMD_CS5536_UDC    0x2096
+#define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
+#define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000


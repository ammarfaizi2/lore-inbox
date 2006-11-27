Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758362AbWK0QQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758362AbWK0QQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758364AbWK0QQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:16:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25263 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758362AbWK0QQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:16:32 -0500
Date: Mon, 27 Nov 2006 16:21:24 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_amd: suspend/resume
Message-ID: <20061127162124.75c9e453@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Early AMD chips require FIFO and/or simplex flag clearing work on resume
from RAM. Most devices need no help

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_amd.c linux-2.6.19-rc6-mm1/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_amd.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_amd.c	2006-11-24 14:21:56.000000000 +0000
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.4"
+#define DRV_VERSION "0.2.7"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -334,6 +334,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations amd33_port_ops = {
@@ -661,6 +663,23 @@
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static int amd_reinit_one(struct pci_dev *pdev)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
+		u8 fifo;
+		pci_read_config_byte(pdev, 0x41, &fifo);
+		if (pdev->device == PCI_DEVICE_ID_AMD_VIPER_7411)
+			/* FIFO is broken */
+			pci_write_config_byte(pdev, 0x41, fifo & 0x0F);
+		else
+			pci_write_config_byte(pdev, 0x41, fifo | 0xF0);
+		if (pdev->device == PCI_DEVICE_ID_AMD_VIPER_7409 ||
+		    pdev->device == PCI_DEVICE_ID_AMD_COBRA_7401)
+		    	ata_pci_clear_simplex(pdev);
+	}
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),		1 },
@@ -688,7 +707,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= amd,
 	.probe 		= amd_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= amd_reinit_one,
 };
 
 static int __init amd_init(void)

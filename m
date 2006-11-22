Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755953AbWKVRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbWKVRFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbWKVRFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:05:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34006 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755953AbWKVRFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:05:44 -0500
Date: Wed, 22 Nov 2006 16:59:07 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] pata_cmd64x: suspend/resume
Message-ID: <20061122165907.5a424362@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a resume of the CMD64x we must restore MRDMODE and latency if the BIOS
didn't get them right originally.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cmd64x.c linux-2.6.19-rc5-mm2/drivers/ata/pata_cmd64x.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cmd64x.c	2006-11-15 13:25:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_cmd64x.c	2006-11-22 15:47:25.680962200 +0000
@@ -31,7 +31,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.1"
+#define DRV_VERSION "0.2.2"
 
 /*
  * CMD64x specific registers definition.
@@ -276,6 +276,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations cmd64x_port_ops = {
@@ -468,6 +470,20 @@
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static int cmd64x_reinit_one(struct pci_dev *pdev)
+{
+	u8 mrdmode;
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 64);
+	pci_read_config_byte(pdev, MRDMODE, &mrdmode);
+	mrdmode &= ~ 0x30;	/* IRQ set up */
+	mrdmode |= 0x02;	/* Memory read line enable */
+	pci_write_config_byte(pdev, MRDMODE, mrdmode);
+#ifdef CONFIG_PPC
+	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
+#endif
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id cmd64x[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
@@ -481,7 +497,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= cmd64x,
 	.probe 		= cmd64x_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= cmd64x_reinit_one,
 };
 
 static int __init cmd64x_init(void)

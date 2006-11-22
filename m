Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756043AbWKVR2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbWKVR2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbWKVR2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:28:25 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12968 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756043AbWKVR2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:28:25 -0500
Date: Wed, 22 Nov 2006 17:23:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_rz1000: Force readahead off on resume
Message-ID: <20061122172337.068fcbff@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ1000 is a generic device except that it has a readahead fifo flaw
that corrupts. We force this off at init time but we want to be paranoid
and force it off at resume as well. I don't know of any actual hardware
that supports both RZ1000 and suspend to RAM but given its a disk muncher
better safe than sorry.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_rz1000.c linux-2.6.19-rc5-mm2/drivers/ata/pata_rz1000.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_rz1000.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_rz1000.c	2006-11-22 14:46:07.904069272 +0000
@@ -21,7 +21,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_rz1000"
-#define DRV_VERSION	"0.2.2"
+#define DRV_VERSION	"0.2.3"
 
 
 /**
@@ -91,6 +91,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations rz1000_port_ops = {
@@ -128,6 +130,19 @@
 	.host_stop	= ata_host_stop
 };
 
+static int rz1000_fifo_disable(struct pci_dev *pdev)
+{
+	u16 reg;
+	/* Be exceptionally paranoid as we must be sure to apply the fix */
+	if (pci_read_config_word(pdev, 0x40, &reg) != 0)
+		return -1;
+	reg &= 0xDFFF;
+	if (pci_write_config_word(pdev, 0x40, reg) != 0)
+		return -1;
+	printk(KERN_INFO DRV_NAME ": disabled chipset readahead.\n");
+	return 0;
+}
+
 /**
  *	rz1000_init_one - Register RZ1000 ATA PCI device with kernel services
  *	@pdev: PCI device to register
@@ -142,7 +157,6 @@
 {
 	static int printed_version;
 	struct ata_port_info *port_info[2];
-	u16 reg;
 	static struct ata_port_info info = {
 		.sht = &rz1000_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
@@ -153,23 +167,25 @@
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
-	/* Be exceptionally paranoid as we must be sure to apply the fix */
-	if (pci_read_config_word(pdev, 0x40, &reg) != 0)
-		goto fail;
-	reg &= 0xDFFF;
-	if (pci_write_config_word(pdev, 0x40, reg) != 0)
-		goto fail;
-	printk(KERN_INFO DRV_NAME ": disabled chipset readahead.\n");
-
-	port_info[0] = &info;
-	port_info[1] = &info;
-	return ata_pci_init_one(pdev, port_info, 2);
-fail:
+	if (rz1000_fifo_disable(pdev) == 0) {
+		port_info[0] = &info;
+		port_info[1] = &info;
+		return ata_pci_init_one(pdev, port_info, 2);
+	}
 	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
 	/* Not safe to use so skip */
 	return -ENODEV;
 }
 
+static int rz1000_reinit_one(struct pci_dev *pdev)
+{
+	/* If this fails on resume (which is a "cant happen" case), we
+	   must stop as any progress risks data loss */
+	if (rz1000_fifo_disable(pdev))
+		panic("rz1000 fifo");
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id pata_rz1000[] = {
 	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), },
 	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001), },
@@ -181,7 +197,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= pata_rz1000,
 	.probe 		= rz1000_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= rz1000_reinit_one,
 };
 
 static int __init rz1000_init(void)

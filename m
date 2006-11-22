Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755995AbWKVRbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbWKVRbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756053AbWKVRbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:31:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20648 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756049AbWKVRbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:31:09 -0500
Date: Wed, 22 Nov 2006 17:28:41 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_sil680 suspend/resume
Message-ID: <20061122172841.0b90f042@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SI680 can come back from s2ram with the clocks disabled (crash time)
or wrong (ugly as this can cause CRC errors, and in theory corruption).
On a resume we must put the clock back.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_sil680.c linux-2.6.19-rc5-mm2/drivers/ata/pata_sil680.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_sil680.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_sil680.c	2006-11-22 14:44:57.221814608 +0000
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sil680"
-#define DRV_VERSION "0.3.2"
+#define DRV_VERSION "0.4.1"
 
 /**
  *	sil680_selreg		-	return register base
@@ -262,32 +262,20 @@
 	.host_stop	= ata_host_stop
 };
 
-static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
+/**
+ *	sil680_init_chip		-	chip setup
+ *	@pdev: PCI device
+ *
+ *	Perform all the chip setup which must be done both when the device
+ *	is powered up on boot and when we resume in case we resumed from RAM.
+ *	Returns the final clock settings.
+ */
+ 
+static u8 sil680_init_chip(struct pci_dev *pdev)
 {
-	static struct ata_port_info info = {
-		.sht = &sil680_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-		.pio_mask = 0x1f,
-		.mwdma_mask = 0x07,
-		.udma_mask = 0x7f,
-		.port_ops = &sil680_port_ops
-	};
-	static struct ata_port_info info_slow = {
-		.sht = &sil680_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-		.pio_mask = 0x1f,
-		.mwdma_mask = 0x07,
-		.udma_mask = 0x3f,
-		.port_ops = &sil680_port_ops
-	};
-	static struct ata_port_info *port_info[2] = {&info, &info};
-	static int printed_version;
 	u32 class_rev	= 0;
 	u8 tmpbyte	= 0;
 
-	if (!printed_version++)
-		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
-
         pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class_rev);
         class_rev &= 0xff;
         /* FIXME: double check */
@@ -322,8 +310,6 @@
 	pci_read_config_byte(pdev,   0x8A, &tmpbyte);
 	printk(KERN_INFO "sil680: BA5_EN = %d clock = %02X\n",
 			tmpbyte & 1, tmpbyte & 0x30);
-	if ((tmpbyte & 0x30) == 0)
-		port_info[0] = port_info[1] = &info_slow;
 
 	pci_write_config_byte(pdev,  0xA1, 0x72);
 	pci_write_config_word(pdev,  0xA2, 0x328A);
@@ -342,11 +328,51 @@
 		case 0x20: printk(KERN_INFO "sil680: Using PCI clock.\n");break;
 		/* This last case is _NOT_ ok */
 		case 0x30: printk(KERN_ERR "sil680: Clock disabled ?\n");
-			return -EIO;
+	}
+	return tmpbyte & 0x30;
+}
+
+static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	static struct ata_port_info info = {
+		.sht = &sil680_sht,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
+		.udma_mask = 0x7f,
+		.port_ops = &sil680_port_ops
+	};
+	static struct ata_port_info info_slow = {
+		.sht = &sil680_sht,
+		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
+		.udma_mask = 0x3f,
+		.port_ops = &sil680_port_ops
+	};
+	static struct ata_port_info *port_info[2] = {&info, &info};
+	static int printed_version;
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
+
+	switch(sil680_init_chip(pdev))
+	{
+		case 0:
+			port_info[0] = port_info[1] = &info_slow;
+			break;
+		case 0x30:
+			return -ENODEV;
 	}
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static int sil680_reinit_one(struct pci_dev *pdev)
+{
+	sil680_init_chip(pdev);
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id sil680[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680), },
 
@@ -357,7 +383,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= sil680,
 	.probe 		= sil680_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= sil680_reinit_one,
 };
 
 static int __init sil680_init(void)


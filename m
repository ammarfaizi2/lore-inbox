Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755784AbWKVQzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbWKVQzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbWKVQza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:55:30 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12677 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755784AbWKVQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:55:30 -0500
Date: Wed, 22 Nov 2006 17:01:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] pata_cs5520: resume support
Message-ID: <20061122170106.7ed5e817@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CS5520 doesn't need much help to resume but we do need to restore
pcicfg which may have been reset to the BIOS default which is
sometimes incorrect.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cs5520.c linux-2.6.19-rc5-mm2/drivers/ata/pata_cs5520.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_cs5520.c	2006-11-15 13:25:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_cs5520.c	2006-11-22 15:01:20.215376872 +0000
@@ -41,7 +41,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_cs5520"
-#define DRV_VERSION	"0.6.2"
+#define DRV_VERSION	"0.6.3"
 
 struct pio_clocks
 {
@@ -167,6 +167,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations cs5520_port_ops = {
@@ -296,6 +298,22 @@
 	dev_set_drvdata(dev, NULL);
 }
 
+/**
+ *	cs5520_reinit_one	-	device resume
+ *	@pdev: PCI device
+ *
+ *	Do any reconfiguration work needed by a resume from RAM. We need
+ *	to restore DMA mode support on BIOSen which disabled it
+ */
+ 
+static int cs5520_reinit_one(struct pci_dev *pdev)
+{
+	u8 pcicfg;
+	pci_read_config_byte(pdev, 0x60, &pcicfg);
+	if ((pcicfg & 0x40) == 0)
+		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
+	return ata_pci_device_resume(pdev);
+}
 /* For now keep DMA off. We can set it for all but A rev CS5510 once the
    core ATA code can handle it */
 
@@ -310,7 +328,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= pata_cs5520,
 	.probe 		= cs5520_init_one,
-	.remove		= cs5520_remove_one
+	.remove		= cs5520_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= cs5520_reinit_one,
 };
 
 static int __init cs5520_init(void)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758373AbWK0QdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373AbWK0QdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758374AbWK0QdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:33:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61094 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758371AbWK0QdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:33:15 -0500
Date: Mon, 27 Nov 2006 16:25:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_hpt3x3: suspend/resume support
Message-ID: <20061127162551.07a0fdba@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again split the chipset init away and call it both on resume and on setup

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_hpt3x3.c linux-2.6.19-rc6-mm1/drivers/ata/pata_hpt3x3.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_hpt3x3.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_hpt3x3.c	2006-11-24 14:23:43.000000000 +0000
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x3"
-#define DRV_VERSION	"0.4.1"
+#define DRV_VERSION	"0.4.2"
 
 static int hpt3x3_probe_init(struct ata_port *ap)
 {
@@ -119,6 +119,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations hpt3x3_port_ops = {
@@ -157,6 +159,27 @@
 };
 
 /**
+ *	hpt3x3_init_chipset	-	chip setup
+ *	@dev: PCI device
+ *
+ *	Perform the setup required at boot and on resume.
+ */
+ 
+static void hpt3x3_init_chipset(struct pci_dev *dev)
+{
+	u16 cmd;
+	/* Initialize the board */
+	pci_write_config_word(dev, 0x80, 0x00);
+	/* Check if it is a 343 or a 363. 363 has COMMAND_MEMORY set */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_MEMORY)
+		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
+	else
+		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
+}
+
+
+/**
  *	hpt3x3_init_one		-	Initialise an HPT343/363
  *	@dev: PCI device
  *	@id: Entry in match table
@@ -177,21 +200,18 @@
 		.port_ops = &hpt3x3_port_ops
 	};
 	static struct ata_port_info *port_info[2] = { &info, &info };
-	u16 cmd;
-
-	/* Initialize the board */
-	pci_write_config_word(dev, 0x80, 0x00);
-	/* Check if it is a 343 or a 363. 363 has COMMAND_MEMORY set */
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_MEMORY)
-		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
-	else
-		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
 
+	hpt3x3_init_chipset(dev);
 	/* Now kick off ATA set up */
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
+static int hpt3x3_reinit_one(struct pci_dev *dev)
+{
+	hpt3x3_init_chipset(dev);
+	return ata_pci_device_resume(dev);
+}
+
 static const struct pci_device_id hpt3x3[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT343), },
 
@@ -202,7 +222,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= hpt3x3,
 	.probe 		= hpt3x3_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= hpt3x3_reinit_one,
 };
 
 static int __init hpt3x3_init(void)

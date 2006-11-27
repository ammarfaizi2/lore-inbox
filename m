Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758355AbWK0QRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbWK0QRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758356AbWK0QRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:17:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47754 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758353AbWK0QRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:17:46 -0500
Date: Mon, 27 Nov 2006 16:19:36 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH]: pata_via suspend/resume support
Message-ID: <20061127161936.6d92157f@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The major VIA issues were handled by the quirks update for resume quirks.
The ATA driver also has to do some work however when resuming from RAM.
Certain chips need the FIFO reconfiguring, and the 66MHz clock setup
updating. 

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_via.c linux-2.6.19-rc6-mm1/drivers/ata/pata_via.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_via.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_via.c	2006-11-24 14:25:32.000000000 +0000
@@ -60,7 +60,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.1.14"
+#define DRV_VERSION "0.2.0"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -368,6 +368,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations via_port_ops = {
@@ -441,8 +443,42 @@
 };
 
 /**
+ *	via_config_fifo		-	set up the FIFO
+ *	@pdev: PCI device
+ *	@flags: configuration flags
+ *
+ *	Set the FIFO properties for this device if neccessary. Used both on
+ *	set up and on and the resume path
+ */
+
+static void via_config_fifo(struct pci_dev *pdev, unsigned int flags)
+{
+	u8 enable;
+	
+	/* 0x40 low bits indicate enabled channels */
+	pci_read_config_byte(pdev, 0x40 , &enable);
+	enable &= 3;
+	
+	if (flags & VIA_SET_FIFO) {
+		u8 fifo_setting[4] = {0x00, 0x60, 0x00, 0x20};
+		u8 fifo;
+
+		pci_read_config_byte(pdev, 0x43, &fifo);
+
+		/* Clear PREQ# until DDACK# for errata */
+		if (flags & VIA_BAD_PREQ)
+			fifo &= 0x7F;
+		else
+			fifo &= 0x9f;
+		/* Turn on FIFO for enabled channels */
+		fifo |= fifo_setting[enable];
+		pci_write_config_byte(pdev, 0x43, fifo);
+	}
+}
+
+/**
  *	via_init_one		-	discovery callback
- *	@pdev: PCI device ID
+ *	@pdev: PCI device
  *	@id: PCI table info
  *
  *	A VIA IDE interface has been discovered. Figure out what revision
@@ -542,21 +578,8 @@
 	}
 
 	/* Initialise the FIFO for the enabled channels. */
-	if (config->flags & VIA_SET_FIFO) {
-		u8 fifo_setting[4] = {0x00, 0x60, 0x00, 0x20};
-		u8 fifo;
-
-		pci_read_config_byte(pdev, 0x43, &fifo);
-
-		/* Clear PREQ# until DDACK# for errata */
-		if (config->flags & VIA_BAD_PREQ)
-			fifo &= 0x7F;
-		else
-			fifo &= 0x9f;
-		/* Turn on FIFO for enabled channels */
-		fifo |= fifo_setting[enable];
-		pci_write_config_byte(pdev, 0x43, fifo);
-	}
+	via_config_fifo(pdev, config->flags);
+	
 	/* Clock set up */
 	switch(config->flags & VIA_UDMA) {
 		case VIA_UDMA_NONE:
@@ -600,6 +623,39 @@
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+/**
+ *	via_reinit_one		-	reinit after resume
+ *	@pdev; PCI device
+ *
+ *	Called when the VIA PATA device is resumed. We must then
+ *	reconfigure the fifo and other setup we may have altered. In
+ *	addition the kernel needs to have the resume methods on PCI
+ *	quirk supported.
+ */
+
+static int via_reinit_one(struct pci_dev *pdev)
+{
+	u32 timing;
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	const struct via_isa_bridge *config = host->private_data;
+	
+	via_config_fifo(pdev, config->flags);
+
+	if ((config->flags & VIA_UDMA) == VIA_UDMA_66) {
+		/* The 66 MHz devices require we enable the clock */
+		pci_read_config_dword(pdev, 0x50, &timing);
+		timing |= 0x80008;
+		pci_write_config_dword(pdev, 0x50, timing);
+	}
+	if (config->flags & VIA_BAD_CLK66) {
+		/* Disable the 66MHz clock on problem devices */
+		pci_read_config_dword(pdev, 0x50, &timing);
+		timing &= ~0x80008;
+		pci_write_config_dword(pdev, 0x50, timing);
+	}
+	return ata_pci_device_resume(pdev);	
+}
+
 static const struct pci_device_id via[] = {
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1), },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C586_1), },
@@ -613,7 +669,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= via,
 	.probe 		= via_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= via_reinit_one,
 };
 
 static int __init via_init(void)

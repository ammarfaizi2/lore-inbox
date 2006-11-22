Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756027AbWKVRZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbWKVRZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbWKVRZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:25:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58584 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756027AbWKVRZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:25:31 -0500
Date: Wed, 22 Nov 2006 17:26:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_ali: suspend/resume support
Message-ID: <20061122172606.0442e330@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various chipset functions must be reprogrammed on a resume from RAM,
without this things like ATAPI DMA stop working on resume with some
chipset variants. Split the chipset programming and init time method selection into two functions. 

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_ali.c linux-2.6.19-rc5-mm2/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_ali.c	2006-11-15 13:26:59.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_ali.c	2006-11-22 16:04:46.135789024 +0000
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.6.6"
+#define DRV_VERSION "0.7.1"
 
 /*
  *	Cable special cases
@@ -347,6 +347,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 /*
@@ -496,6 +498,69 @@
 	.host_stop	= ata_host_stop
 };
 
+
+/**
+ *	ali_init_chipset	-	chip setup function
+ *	@pdev: PCI device of ATA controller
+ *
+ *	Perform the setup on the device that must be done both at boot
+ *	and at resume time.
+ */
+ 
+static void ali_init_chipset(struct pci_dev *pdev)
+{
+	u8 rev, tmp;
+	struct pci_dev *north, *isa_bridge;
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
+
+	/*
+	 * The chipset revision selects the driver operations and
+	 * mode data.
+	 */
+
+	if (rev >= 0x20 && rev < 0xC2) {
+		/* 1543-E/F, 1543C-C, 1543C-D, 1543C-E */
+		pci_read_config_byte(pdev, 0x4B, &tmp);
+		/* Clear CD-ROM DMA write bit */
+		tmp &= 0x7F;
+		pci_write_config_byte(pdev, 0x4B, tmp);
+	} else if (rev >= 0xC2) {
+		/* Enable cable detection logic */
+		pci_read_config_byte(pdev, 0x4B, &tmp);
+		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
+	}
+	north = pci_get_slot(pdev->bus, PCI_DEVFN(0,0));
+	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+
+	if (north && north->vendor == PCI_VENDOR_ID_AL && isa_bridge) {
+		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
+		   Set the south bridge enable bit */
+		pci_read_config_byte(isa_bridge, 0x79, &tmp);
+		if (rev == 0xC2)
+			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x04);
+		else if (rev > 0xC2)
+			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x02);
+	}
+	if (rev >= 0x20) {
+		/*
+		 * CD_ROM DMA on (0x53 bit 0). Enable this even if we want
+		 * to use PIO. 0x53 bit 1 (rev 20 only) - enable FIFO control
+		 * via 0x54/55.
+		 */
+		pci_read_config_byte(pdev, 0x53, &tmp);
+		if (rev <= 0x20)
+			tmp &= ~0x02;
+		if (rev >= 0xc7)
+			tmp |= 0x03;
+		else
+			tmp |= 0x01;	/* CD_ROM enable for DMA */
+		pci_write_config_byte(pdev, 0x53, tmp);
+	}
+	pci_dev_put(isa_bridge);
+	pci_dev_put(north);
+	ata_pci_clear_simplex(pdev);
+}
 /**
  *	ali_init_one		-	discovery callback
  *	@pdev: PCI device ID
@@ -569,7 +634,7 @@
 
 	static struct ata_port_info *port_info[2];
 	u8 rev, tmp;
-	struct pci_dev *north, *isa_bridge;
+	struct pci_dev *isa_bridge;
 
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
 
@@ -581,11 +646,6 @@
 	if (rev < 0x20) {
 		port_info[0] = port_info[1] = &info_early;
 	} else if (rev < 0xC2) {
-		/* 1543-E/F, 1543C-C, 1543C-D, 1543C-E */
-		pci_read_config_byte(pdev, 0x4B, &tmp);
-		/* Clear CD-ROM DMA write bit */
-		tmp &= 0x7F;
-		pci_write_config_byte(pdev, 0x4B, tmp);
         	port_info[0] = port_info[1] = &info_20;
 	} else if (rev == 0xC2) {
         	port_info[0] = port_info[1] = &info_c2;
@@ -596,54 +656,25 @@
 	} else
         	port_info[0] = port_info[1] = &info_c5;
 
-	if (rev >= 0xC2) {
-		/* Enable cable detection logic */
-		pci_read_config_byte(pdev, 0x4B, &tmp);
-		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
-	}
-
-	north = pci_get_slot(pdev->bus, PCI_DEVFN(0,0));
+	ali_init_chipset(pdev);
+	
 	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
-
-	if (north && north->vendor == PCI_VENDOR_ID_AL) {
-		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
-		   Set the south bridge enable bit */
-		pci_read_config_byte(isa_bridge, 0x79, &tmp);
-		if (rev == 0xC2)
-			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x04);
-		else if (rev > 0xC2)
-			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x02);
+	if (isa_bridge && rev >= 0x20 && rev < 0xC2) {
+		/* Are we paired with a UDMA capable chip */
+		pci_read_config_byte(isa_bridge, 0x5E, &tmp);
+		if ((tmp & 0x1E) == 0x12)
+	        	port_info[0] = port_info[1] = &info_20_udma;
+		pci_dev_put(isa_bridge);
 	}
-
-	if (rev >= 0x20) {
-		if (rev < 0xC2) {
-			/* Are we paired with a UDMA capable chip */
-			pci_read_config_byte(isa_bridge, 0x5E, &tmp);
-			if ((tmp & 0x1E) == 0x12)
-		        	port_info[0] = port_info[1] = &info_20_udma;
-		}
-		/*
-		 * CD_ROM DMA on (0x53 bit 0). Enable this even if we want
-		 * to use PIO. 0x53 bit 1 (rev 20 only) - enable FIFO control
-		 * via 0x54/55.
-		 */
-		pci_read_config_byte(pdev, 0x53, &tmp);
-		if (rev <= 0x20)
-			tmp &= ~0x02;
-		if (rev >= 0xc7)
-			tmp |= 0x03;
-		else
-			tmp |= 0x01;	/* CD_ROM enable for DMA */
-		pci_write_config_byte(pdev, 0x53, tmp);
-	}
-
-	pci_dev_put(isa_bridge);
-	pci_dev_put(north);
-
-	ata_pci_clear_simplex(pdev);
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static int ali_reinit_one(struct pci_dev *pdev)
+{
+	ali_init_chipset(pdev);
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id ali[] = {
 	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), },
 	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5229), },
@@ -655,7 +686,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= ali,
 	.probe 		= ali_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ali_reinit_one,
 };
 
 static int __init ali_init(void)

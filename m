Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbTBRSY1>; Tue, 18 Feb 2003 13:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268016AbTBRSXi>; Tue, 18 Feb 2003 13:23:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55049 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268003AbTBRSWO>; Tue, 18 Feb 2003 13:22:14 -0500
Subject: PATCH: fix ALi 32bitisms, fix ALi FIFO, fix ALi IRQ crash
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:32:34 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCXi-0006Dn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also Enable ATI IGP/ALi combo

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/alim15x3.c linux-2.5.61-ac2/drivers/ide/pci/alim15x3.c
--- linux-2.5.61/drivers/ide/pci/alim15x3.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/alim15x3.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/alim15x3.c		Version 0.15	2002/08/19
+ * linux/drivers/ide/pci/alim15x3.c		Version 0.16	2003/01/02
  *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
@@ -19,6 +19,10 @@
  *	Don't use LBA48 mode on ALi <= 0xC4
  *	Don't poke 0x79 with a non ALi northbridge
  *	Don't flip undefined bits on newer chipsets (fix Fujitsu laptop hang)
+ *
+ *  Documentation
+ *	Chipset documentation available under NDA only
+ *
  */
 
 #include <linux/config.h>
@@ -94,7 +98,7 @@
  
 static int ali_get_info (char *buffer, char **addr, off_t offset, int count)
 {
-	u32 bibma;
+	unsigned long bibma;
 	u8 reg53h, reg5xh, reg5yh, reg5xh1, reg5yh1, c0, c1, rev, tmp;
 	char *q, *p = buffer;
 
@@ -106,14 +110,15 @@
 		fifo[3]  = "   ???  ";
 
 	/* first fetch bibma: */
-	pci_read_config_dword(bmide_dev, 0x20, &bibma);
-	bibma = (bibma & 0xfff0) ;
+	
+	bibma = pci_resource_start(bmide_dev, 4);
+
 	/*
 	 * at that point bibma+0x2 et bibma+0xa are byte
 	 * registers to investigate:
 	 */
-	c0 = inb((unsigned short)bibma + 0x02);
-	c1 = inb((unsigned short)bibma + 0x0a);
+	c0 = inb(bibma + 0x02);
+	c1 = inb(bibma + 0x0a);
 
 	p += sprintf(p,
 		"\n                                Ali M15x3 Chipset.\n");
@@ -295,6 +300,7 @@
 	int port = hwif->channel ? 0x5c : 0x58;
 	int portFIFO = hwif->channel ? 0x55 : 0x54;
 	u8 cd_dma_fifo = 0;
+	int unit = drive->select.b.unit & 1;
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, &d);
 	s_time = ide_pio_timings[pio].setup_time;
@@ -323,13 +329,13 @@
 	 */
 	pci_read_config_byte(dev, portFIFO, &cd_dma_fifo);
 	if (drive->media==ide_disk) {
-		if (hwif->channel) {
+		if (unit) {
 			pci_write_config_byte(dev, portFIFO, (cd_dma_fifo & 0x0F) | 0x50);
 		} else {
 			pci_write_config_byte(dev, portFIFO, (cd_dma_fifo & 0xF0) | 0x05);
 		}
 	} else {
-		if (hwif->channel) {
+		if (unit) {
 			pci_write_config_byte(dev, portFIFO, cd_dma_fifo & 0x0F);
 		} else {
 			pci_write_config_byte(dev, portFIFO, cd_dma_fifo & 0xF0);
@@ -779,9 +785,10 @@
 static void __init init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
 	u8 ideic, inmir;
-	u8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
+	s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
 				      1, 11, 0, 12, 0, 14, 0, 15 };
-
+	int irq = -1;
+	
 	hwif->irq = hwif->channel ? 15 : 14;
 
 	if (isa_dev) {
@@ -801,15 +808,17 @@
 			 */
 			pci_read_config_byte(isa_dev, 0x44, &inmir);
 			inmir = inmir & 0x0f;
-			hwif->irq = irq_routing_table[inmir];
+			irq = irq_routing_table[inmir];
 		} else if (hwif->channel && !(ideic & 0x01)) {
 			/*
 			 * get SIRQ2 routing table
 			 */
 			pci_read_config_byte(isa_dev, 0x75, &inmir);
 			inmir = inmir & 0x0f;
-			hwif->irq = irq_routing_table[inmir];
+			irq = irq_routing_table[inmir];
 		}
+		if(irq >= 0)
+			hwif->irq = irq;
 	}
 
 	init_hwif_common_ali15x3(hwif);
@@ -850,10 +859,8 @@
 	ide_pci_device_t *d = &ali15x3_chipsets[id->driver_data];
 	
 	if(pci_find_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_IGP, NULL))
-	{
-		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not supported by Linux\n");
-		return 1;
-	}
+		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
+
 #if defined(CONFIG_SPARC64)
 	d->init_hwif = init_hwif_common_ali15x3;
 #endif /* CONFIG_SPARC64 */

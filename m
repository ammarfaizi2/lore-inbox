Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbTBRS0G>; Tue, 18 Feb 2003 13:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268024AbTBRSZj>; Tue, 18 Feb 2003 13:25:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268003AbTBRSXo>; Tue, 18 Feb 2003 13:23:44 -0500
Subject: PATCH: clean up siimage, use generic mmio ops
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:34:00 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCZ6-0006EN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/siimage.c linux-2.5.61-ac2/drivers/ide/pci/siimage.c
--- linux-2.5.61/drivers/ide/pci/siimage.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/siimage.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/siimage.c		Version 1.01	Sept 11, 2002
+ * linux/drivers/ide/pci/siimage.c		Version 1.02	Jan 30, 2003
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  */
@@ -31,15 +31,15 @@
 {
 	char *p		= buf;
 	u8 mmio		= (pci_get_drvdata(dev) != NULL) ? 1 : 0;
-	u32 bmdma	= (mmio) ? ((u32) pci_get_drvdata(dev)) :
+	unsigned long bmdma	= (mmio) ? ((unsigned long) pci_get_drvdata(dev)) :
 				    (pci_resource_start(dev, 4));
 
 	p += sprintf(p, "\nController: %d\n", index);
 	p += sprintf(p, "SiI%x Chipset.\n", dev->device);
 	if (mmio)
-		p += sprintf(p, "MMIO Base 0x%08x\n", bmdma);
-	p += sprintf(p, "%s-DMA Base 0x%08x\n", (mmio)?"MMIO":"BM", bmdma);
-	p += sprintf(p, "%s-DMA Base 0x%08x\n", (mmio)?"MMIO":"BM", bmdma+8);
+		p += sprintf(p, "MMIO Base 0x%lx\n", bmdma);
+	p += sprintf(p, "%s-DMA Base 0x%lx\n", (mmio)?"MMIO":"BM", bmdma);
+	p += sprintf(p, "%s-DMA Base 0x%lx\n", (mmio)?"MMIO":"BM", bmdma+8);
 
 	p += sprintf(p, "--------------- Primary Channel "
 			"---------------- Secondary Channel "
@@ -248,9 +248,9 @@
 {
 	u8 speed	= ide_dma_speed(drive, siimage_ratemask(drive));
 
-	config_chipset_for_pio(drive, (!(speed)));
+	config_chipset_for_pio(drive, !speed);
 
-	if ((!(speed)))
+	if (!speed)
 		return 0;
 
 	if (ide_set_xfer_rate(drive, speed))
@@ -267,7 +267,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
-	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
+	if (id != NULL && (id->capability & 1) != 0 && drive->autodma) {
 		if (!(hwif->atapi_dma))
 			goto fast_ata_pio;
 		/* Consult the list of known "bad" drives */
@@ -317,10 +317,9 @@
 		return 1;
 
 	/* return 1 if Device INTR asserted */
-	if ((pci_read_config_byte(hwif->pci_dev, SELREG(1), &dma_altstat)),
-	    ((dma_altstat & 8) == 8))
+	pci_read_config_byte(hwif->pci_dev, SELREG(1), &dma_altstat);
+	if (dma_altstat & 8)
 		return 0;	//return 1;
-
 	return 0;
 }
 
@@ -355,7 +354,7 @@
 			hwif->OUTL(sata_error, SATA_ERROR_REG);
 			watchdog = (sata_error & 0x00680000) ? 1 : 0;
 #if 1
-			printk("%s: sata_error = 0x%08x, "
+			printk(KERN_WARNING "%s: sata_error = 0x%08x, "
 				"watchdog = %d, %s\n",
 				drive->name, sata_error, watchdog,
 				__FUNCTION__);
@@ -426,7 +425,7 @@
 		ide_hwif_t *hwif	= HWIF(drive);
 
 		if ((hwif->INL(SATA_STATUS_REG) & 0x03) != 0x03) {
-			printk("%s: reset phy dead, status=0x%08x\n",
+			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
 				hwif->name, hwif->INL(SATA_STATUS_REG));
 			HWGROUP(drive)->poll_timeout = 0;
 #if 0
@@ -475,10 +474,10 @@
 
 	if (SATA_STATUS_REG) {
 		u32 sata_stat = hwif->INL(SATA_STATUS_REG);
-		printk("%s: reset phy, status=0x%08x, %s\n",
+		printk(KERN_WARNING "%s: reset phy, status=0x%08x, %s\n",
 			hwif->name, sata_stat, __FUNCTION__);
 		if (!(sata_stat)) {
-			printk("%s: reset phy dead, status=0x%08x\n",
+			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
 				hwif->name, sata_stat);
 			drive->failures++;
 		}
@@ -491,7 +490,7 @@
 	if (dev->device == PCI_DEVICE_ID_SII_3112)
 		goto sata_skip;
 
-	printk("%s: BASE CLOCK ", name);
+	printk(KERN_INFO "%s: BASE CLOCK ", name);
 	clocking &= ~0x0C;
 	switch(clocking) {
 		case 0x03: printk("DISABLED !\n"); break;
@@ -514,13 +513,12 @@
 #endif /* DISPLAY_SIIMAGE_TIMINGS && CONFIG_PROC_FS */
 }
 
-#ifdef CONFIG_TRY_MMIO_SIIMAGE
 static unsigned int setup_mmio_siimage (struct pci_dev *dev, const char *name)
 {
-	u32 bar5	= pci_resource_start(dev, 5);
-	u32 end5	= pci_resource_end(dev, 5);
+	unsigned long bar5	= pci_resource_start(dev, 5);
+	unsigned long end5	= pci_resource_end(dev, 5);
 	u8 tmpbyte	= 0;
-	u32 addr;
+	unsigned long addr;
 	void *ioaddr;
 
 	ioaddr = ioremap_nocache(bar5, (end5 - bar5));
@@ -529,82 +527,77 @@
 		return 0;
 
 	pci_set_master(dev);
-	addr = (u32) ioaddr;
-	pci_set_drvdata(dev, (void *) addr);
+	pci_set_drvdata(dev, ioaddr);
+	addr = (unsigned long) ioaddr;
 
 	if (dev->device == PCI_DEVICE_ID_SII_3112) {
-		sii_outl(0, DEVADDR(0x148));
-		sii_outl(0, DEVADDR(0x1C8));
+		writel(0, DEVADDR(0x148));
+		writel(0, DEVADDR(0x1C8));
 	}
 
-	sii_outb(0, DEVADDR(0xB4));
-	sii_outb(0, DEVADDR(0xF4));
-	tmpbyte = sii_inb(DEVADDR(0x4A));
+	writeb(0, DEVADDR(0xB4));
+	writeb(0, DEVADDR(0xF4));
+	tmpbyte = readb(DEVADDR(0x4A));
 
 	switch(tmpbyte) {
 		case 0x01:
-			sii_outb(tmpbyte|0x10, DEVADDR(0x4A));
-			tmpbyte = sii_inb(DEVADDR(0x4A));
+			writeb(tmpbyte|0x10, DEVADDR(0x4A));
+			tmpbyte = readb(DEVADDR(0x4A));
 		case 0x31:
 			/* if clocking is disabled */
 			/* 133 clock attempt to force it on */
-			sii_outb(tmpbyte & ~0x20, DEVADDR(0x4A));
-			tmpbyte = sii_inb(DEVADDR(0x4A));
+			writeb(tmpbyte & ~0x20, DEVADDR(0x4A));
+			tmpbyte = readb(DEVADDR(0x4A));
 		case 0x11:
 		case 0x21:
 			break;
 		default:
 			tmpbyte &= ~0x30;
 			tmpbyte |= 0x20;
-			sii_outb(tmpbyte, DEVADDR(0x4A));
+			writeb(tmpbyte, DEVADDR(0x4A));
 			break;
 	}
 	
-	sii_outb(0x72, DEVADDR(0xA1));
-	sii_outw(0x328A, DEVADDR(0xA2));
-	sii_outl(0x62DD62DD, DEVADDR(0xA4));
-	sii_outl(0x43924392, DEVADDR(0xA8));
-	sii_outl(0x40094009, DEVADDR(0xAC));
-	sii_outb(0x72, DEVADDR(0xE1));
-	sii_outw(0x328A, DEVADDR(0xE2));
-	sii_outl(0x62DD62DD, DEVADDR(0xE4));
-	sii_outl(0x43924392, DEVADDR(0xE8));
-	sii_outl(0x40094009, DEVADDR(0xEC));
+	writeb(0x72, DEVADDR(0xA1));
+	writew(0x328A, DEVADDR(0xA2));
+	writel(0x62DD62DD, DEVADDR(0xA4));
+	writel(0x43924392, DEVADDR(0xA8));
+	writel(0x40094009, DEVADDR(0xAC));
+	writeb(0x72, DEVADDR(0xE1));
+	writew(0x328A, DEVADDR(0xE2));
+	writel(0x62DD62DD, DEVADDR(0xE4));
+	writel(0x43924392, DEVADDR(0xE8));
+	writel(0x40094009, DEVADDR(0xEC));
 
 	if (dev->device == PCI_DEVICE_ID_SII_3112) {
-		sii_outl(0xFFFF0000, DEVADDR(0x108));
-		sii_outl(0xFFFF0000, DEVADDR(0x188));
-		sii_outl(0x00680000, DEVADDR(0x148));
-		sii_outl(0x00680000, DEVADDR(0x1C8));
+		writel(0xFFFF0000, DEVADDR(0x108));
+		writel(0xFFFF0000, DEVADDR(0x188));
+		writel(0x00680000, DEVADDR(0x148));
+		writel(0x00680000, DEVADDR(0x1C8));
 	}
 
-	tmpbyte = sii_inb(DEVADDR(0x4A));
+	tmpbyte = readb(DEVADDR(0x4A));
 
 	proc_reports_siimage(dev, (tmpbyte>>=4), name);
 	return 1;
 }
-#endif /* CONFIG_TRY_MMIO_SIIMAGE */
 
 static unsigned int __init init_chipset_siimage (struct pci_dev *dev, const char *name)
 {
 	u32 class_rev	= 0;
 	u8 tmpbyte	= 0;
-#ifdef CONFIG_TRY_MMIO_SIIMAGE
 	u8 BA5_EN	= 0;
-#endif /* CONFIG_TRY_MMIO_SIIMAGE */
 
         pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
         class_rev &= 0xff;
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);	
 
-#ifdef CONFIG_TRY_MMIO_SIIMAGE
 	pci_read_config_byte(dev, 0x8A, &BA5_EN);
 	if ((BA5_EN & 0x01) || (pci_resource_start(dev, 5))) {
 		if (setup_mmio_siimage(dev, name)) {
 			return 0;
 		}
 	}
-#endif /* CONFIG_TRY_MMIO_SIIMAGE */
 
 	pci_write_config_byte(dev, 0x80, 0x00);
 	pci_write_config_byte(dev, 0x84, 0x00);
@@ -653,22 +646,12 @@
 static void __init init_mmio_iops_siimage (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
-	u32 addr		= (u32) pci_get_drvdata(hwif->pci_dev);
+	unsigned long addr	= (unsigned long) pci_get_drvdata(hwif->pci_dev);
 	u8 ch			= hwif->channel;
 //	u16 i			= 0;
 	hw_regs_t hw;
 
-	hwif->OUTB  = sii_outb;
-	hwif->OUTW  = sii_outw;
-	hwif->OUTL  = sii_outl;
-	hwif->OUTSW = sii_outsw;
-	hwif->OUTSL = sii_outsl;
-	hwif->INB   = sii_inb;
-	hwif->INW   = sii_inw;
-	hwif->INL   = sii_inl;
-	hwif->INSW  = sii_insw;
-	hwif->INSL  = sii_insl;
-
+	default_hwif_mmiops(hwif);
 	memset(&hw, 0, sizeof(hw_regs_t));
 
 #if 1
@@ -706,7 +689,7 @@
 #endif
 
 #if 0
-	printk("%s: ", hwif->name);
+	printk(KERN_DEBUG "%s: ", hwif->name);
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
 		printk("0x%08x ", DEVADDR((ch) ? 0xC0 : 0x80)|(i));
 	printk("0x%08x ", DEVADDR((ch) ? 0xCA : 0x8A)|(i));
@@ -726,7 +709,6 @@
 	hw.priv				= (void *) addr;
 //	hw.priv				= pci_get_drvdata(hwif->pci_dev);
 	hw.irq				= hwif->pci_dev->irq;
-//	hw.iops				= siimage_iops;
 
 	memcpy(&hwif->hw, &hw, sizeof(hw));
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
@@ -777,9 +759,6 @@
 		pci_read_config_byte(hwif->pci_dev, SELREG(0), &ata66);
 		return (ata66 & 0x01) ? 1 : 0;
 	}
-#ifndef CONFIG_TRY_MMIO_SIIMAGE
-	if (hwif->mmio) BUG();
-#endif /* CONFIG_TRY_MMIO_SIIMAGE */
 
 	return (hwif->INB(SELADDR(0)) & 0x01) ? 1 : 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/siimage.h linux-2.5.61-ac2/drivers/ide/pci/siimage.h
--- linux-2.5.61/drivers/ide/pci/siimage.h	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/siimage.h	2003-02-17 19:01:34.000000000 +0000
@@ -9,8 +9,6 @@
 
 #define DISPLAY_SIIMAGE_TIMINGS
 
-#define CONFIG_TRY_MMIO_SIIMAGE
-//#undef CONFIG_TRY_MMIO_SIIMAGE
 #undef SIIMAGE_VIRTUAL_DMAPIO
 #undef SIIMAGE_BUFFERED_TASKFILE
 #undef SIIMAGE_LARGE_DMA
@@ -31,63 +29,11 @@
 
 #define ADJREG(B,R)	((B)|(R)|((hwif->channel)<<(4+(2*(hwif->mmio)))))
 #define SELREG(R)	ADJREG((0xA0),(R))
-#define SELADDR(R)	((((u32)hwif->hwif_data)*(hwif->mmio))|SELREG((R)))
-#define HWIFADDR(R)	((((u32)hwif->hwif_data)*(hwif->mmio))|(R))
-#define DEVADDR(R)	(((u32) pci_get_drvdata(dev))|(R))
+#define SELADDR(R)	((((unsigned long)hwif->hwif_data)*(hwif->mmio))|SELREG((R)))
+#define HWIFADDR(R)	((((unsigned long)hwif->hwif_data)*(hwif->mmio))|(R))
+#define DEVADDR(R)	(((unsigned long) pci_get_drvdata(dev))|(R))
 
 
-inline u8 sii_inb (u32 port)
-{
-	return (u8) readb(port);
-}
-
-inline u16 sii_inw (u32 port)
-{
-	return (u16) readw(port);
-}
-
-inline void sii_insw (u32 port, void *addr, u32 count)
-{
-	while (count--) { *(u16 *)addr = readw(port); addr += 2; }
-}
-
-inline u32 sii_inl (u32 port)
-{
-	return (u32) readl(port);
-}
-
-inline void sii_insl (u32 port, void *addr, u32 count)
-{
-	sii_insw(port, addr, (count)<<1);
-//	while (count--) { *(u32 *)addr = readl(port); addr += 4; }
-}
-
-inline void sii_outb (u8 value, u32 port)
-{
-	writeb(value, port);
-}
-
-inline void sii_outw (u16 value, u32 port)
-{
-	writew(value, port);
-}
-
-inline void sii_outsw (u32 port, void *addr, u32 count)
-{
-	while (count--) { writew(*(u16 *)addr, port); addr += 2; }
-}
-
-inline void sii_outl (u32 value, u32 port)
-{
-	writel(value, port);
-}
-
-inline void sii_outsl (u32 port, void *addr, u32 count)
-{
-	sii_outsw(port, addr, (count)<<1);
-//	while (count--) { writel(*(u32 *)addr, port); addr += 4; }
-}
-
 #if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>

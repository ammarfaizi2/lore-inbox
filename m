Return-Path: <linux-kernel-owner+w=401wt.eu-S1030520AbXALEZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbXALEZe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXALEYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030520AbXALEYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:24:33 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=UDUObwErt+IUCuYKZ5BysnIVc20scchyCZP+a4ITqTXYKHHyK/wJ3UEPcMV5NTnc3VC5EvC7tNMuKCz0qhZ7Nf0KerWmTsfniOB52xUMGO30B0+tFk0sWH7PuhnW+9SILXAjfXqY2ySzPipuvwz9af4UBD4oLQjNyvXK0MtkmLc=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:28:07 +0100
Message-Id: <20070112042807.28794.8251.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 19/19] ide: use PIO/MMIO operations directly where possible
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: use PIO/MMIO operations directly where possible

This results in smaller/faster/simpler code and allows future optimizations.
Also remove no longer needed ide[_mm]_{inl,outl}() and ide_hwif_t.{INL,OUTL}.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/h8300/ide-h8300.c  |    2 -
 drivers/ide/ide-dma.c          |    5 ++-
 drivers/ide/ide-iops.c         |   24 --------------
 drivers/ide/ide.c              |    2 -
 drivers/ide/legacy/ht6560b.c   |   14 ++++----
 drivers/ide/pci/aec62xx.c      |    6 +--
 drivers/ide/pci/alim15x3.c     |    4 +-
 drivers/ide/pci/cmd64x.c       |   18 +++++------
 drivers/ide/pci/cs5530.c       |   22 ++++++-------
 drivers/ide/pci/cy82c693.c     |   12 +++----
 drivers/ide/pci/hpt366.c       |    2 -
 drivers/ide/pci/ns87415.c      |   10 +++---
 drivers/ide/pci/opti621.c      |   63 +++++++++++++++++++-------------------
 drivers/ide/pci/pdc202xx_new.c |    8 ++--
 drivers/ide/pci/pdc202xx_old.c |   41 ++++++++++++-------------
 drivers/ide/pci/serverworks.c  |    4 +-
 drivers/ide/pci/sgiioc4.c      |   67 +++++++++++++++++++++--------------------
 drivers/ide/pci/siimage.c      |   24 +++++++-------
 drivers/ide/pci/sl82c105.c     |    6 +--
 drivers/ide/pci/tc86c001.c     |   26 +++++++--------
 drivers/ide/pci/trm290.c       |   38 +++++++++++------------
 include/linux/ide.h            |    2 -
 22 files changed, 188 insertions(+), 212 deletions(-)

Index: a/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a.orig/drivers/ide/h8300/ide-h8300.c
+++ a/drivers/ide/h8300/ide-h8300.c
@@ -81,8 +81,6 @@ static inline void hwif_setup(ide_hwif_t
 	hwif->OUTSW = mm_outsw;
 	hwif->INW   = mm_inw;
 	hwif->INSW  = mm_insw;
-	hwif->OUTL  = NULL;
-	hwif->INL   = NULL;
 	hwif->OUTSL = NULL;
 	hwif->INSL  = NULL;
 }
Index: a/drivers/ide/ide-dma.c
===================================================================
--- a.orig/drivers/ide/ide-dma.c
+++ a/drivers/ide/ide-dma.c
@@ -565,7 +565,10 @@ int ide_dma_setup(ide_drive_t *drive)
 	}
 
 	/* PRD table */
-	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
+	if (hwif->mmio == 2)
+		writel(hwif->dmatable_dma, (void __iomem *)hwif->dma_prdtable);
+	else
+		outl(hwif->dmatable_dma, hwif->dma_prdtable);
 
 	/* specify r/w */
 	hwif->OUTB(reading, hwif->dma_command);
Index: a/drivers/ide/ide-iops.c
===================================================================
--- a.orig/drivers/ide/ide-iops.c
+++ a/drivers/ide/ide-iops.c
@@ -49,11 +49,6 @@ static void ide_insw (unsigned long port
 	insw(port, addr, count);
 }
 
-static u32 ide_inl (unsigned long port)
-{
-	return (u32) inl(port);
-}
-
 static void ide_insl (unsigned long port, void *addr, u32 count)
 {
 	insl(port, addr, count);
@@ -79,11 +74,6 @@ static void ide_outsw (unsigned long por
 	outsw(port, addr, count);
 }
 
-static void ide_outl (u32 val, unsigned long port)
-{
-	outl(val, port);
-}
-
 static void ide_outsl (unsigned long port, void *addr, u32 count)
 {
 	outsl(port, addr, count);
@@ -94,12 +84,10 @@ void default_hwif_iops (ide_hwif_t *hwif
 	hwif->OUTB	= ide_outb;
 	hwif->OUTBSYNC	= ide_outbsync;
 	hwif->OUTW	= ide_outw;
-	hwif->OUTL	= ide_outl;
 	hwif->OUTSW	= ide_outsw;
 	hwif->OUTSL	= ide_outsl;
 	hwif->INB	= ide_inb;
 	hwif->INW	= ide_inw;
-	hwif->INL	= ide_inl;
 	hwif->INSW	= ide_insw;
 	hwif->INSL	= ide_insl;
 }
@@ -123,11 +111,6 @@ static void ide_mm_insw (unsigned long p
 	__ide_mm_insw((void __iomem *) port, addr, count);
 }
 
-static u32 ide_mm_inl (unsigned long port)
-{
-	return (u32) readl((void __iomem *) port);
-}
-
 static void ide_mm_insl (unsigned long port, void *addr, u32 count)
 {
 	__ide_mm_insl((void __iomem *) port, addr, count);
@@ -153,11 +136,6 @@ static void ide_mm_outsw (unsigned long 
 	__ide_mm_outsw((void __iomem *) port, addr, count);
 }
 
-static void ide_mm_outl (u32 value, unsigned long port)
-{
-	writel(value, (void __iomem *) port);
-}
-
 static void ide_mm_outsl (unsigned long port, void *addr, u32 count)
 {
 	__ide_mm_outsl((void __iomem *) port, addr, count);
@@ -170,12 +148,10 @@ void default_hwif_mmiops (ide_hwif_t *hw
 	   this one is controller specific! */
 	hwif->OUTBSYNC	= ide_mm_outbsync;
 	hwif->OUTW	= ide_mm_outw;
-	hwif->OUTL	= ide_mm_outl;
 	hwif->OUTSW	= ide_mm_outsw;
 	hwif->OUTSL	= ide_mm_outsl;
 	hwif->INB	= ide_mm_inb;
 	hwif->INW	= ide_mm_inw;
-	hwif->INL	= ide_mm_inl;
 	hwif->INSW	= ide_mm_insw;
 	hwif->INSL	= ide_mm_insl;
 }
Index: a/drivers/ide/ide.c
===================================================================
--- a.orig/drivers/ide/ide.c
+++ a/drivers/ide/ide.c
@@ -511,13 +511,11 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->OUTB			= tmp_hwif->OUTB;
 	hwif->OUTBSYNC			= tmp_hwif->OUTBSYNC;
 	hwif->OUTW			= tmp_hwif->OUTW;
-	hwif->OUTL			= tmp_hwif->OUTL;
 	hwif->OUTSW			= tmp_hwif->OUTSW;
 	hwif->OUTSL			= tmp_hwif->OUTSL;
 
 	hwif->INB			= tmp_hwif->INB;
 	hwif->INW			= tmp_hwif->INW;
-	hwif->INL			= tmp_hwif->INL;
 	hwif->INSW			= tmp_hwif->INSW;
 	hwif->INSL			= tmp_hwif->INSL;
 
Index: a/drivers/ide/legacy/ht6560b.c
===================================================================
--- a.orig/drivers/ide/legacy/ht6560b.c
+++ a/drivers/ide/legacy/ht6560b.c
@@ -143,16 +143,16 @@ static void ht6560b_selectproc (ide_driv
 		current_timing = timing;
 		if (drive->media != ide_disk || !drive->present)
 			select |= HT_PREFETCH_MODE;
-		(void) HWIF(drive)->INB(HT_CONFIG_PORT);
-		(void) HWIF(drive)->INB(HT_CONFIG_PORT);
-		(void) HWIF(drive)->INB(HT_CONFIG_PORT);
-		(void) HWIF(drive)->INB(HT_CONFIG_PORT);
-		HWIF(drive)->OUTB(select, HT_CONFIG_PORT);
+		(void)inb(HT_CONFIG_PORT);
+		(void)inb(HT_CONFIG_PORT);
+		(void)inb(HT_CONFIG_PORT);
+		(void)inb(HT_CONFIG_PORT);
+		outb(select, HT_CONFIG_PORT);
 		/*
 		 * Set timing for this drive:
 		 */
-		HWIF(drive)->OUTB(timing, IDE_SELECT_REG);
-		(void) HWIF(drive)->INB(IDE_STATUS_REG);
+		outb(timing, IDE_SELECT_REG);
+		(void)inb(IDE_STATUS_REG);
 #ifdef DEBUG
 		printk("ht6560b: %s: select=%#x timing=%#x\n",
 			drive->name, select, timing);
Index: a/drivers/ide/pci/aec62xx.c
===================================================================
--- a.orig/drivers/ide/pci/aec62xx.c
+++ a/drivers/ide/pci/aec62xx.c
@@ -94,9 +94,9 @@ static u8 aec62xx_ratemask (ide_drive_t 
 	switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_ARTOP_ATP865:
 		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			mode = (hwif->INB(((hwif->channel) ?
-					hwif->mate->dma_status :
-					hwif->dma_status)) & 0x10) ? 4 : 3;
+			mode = (inb(hwif->channel ?
+				    hwif->mate->dma_status :
+				    hwif->dma_status) & 0x10) ? 4 : 3;
 			break;
 		case PCI_DEVICE_ID_ARTOP_ATP860:
 		case PCI_DEVICE_ID_ARTOP_ATP860R:
Index: a/drivers/ide/pci/alim15x3.c
===================================================================
--- a.orig/drivers/ide/pci/alim15x3.c
+++ a/drivers/ide/pci/alim15x3.c
@@ -852,8 +852,8 @@ static void __devinit init_dma_ali15x3 (
 {
 	if (m5229_revision < 0x20)
 		return;
-	if (!(hwif->channel))
-		hwif->OUTB(hwif->INB(dmabase+2) & 0x60, dmabase+2);
+	if (!hwif->channel)
+		outb(inb(dmabase + 2) & 0x60, dmabase + 2);
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
Index: a/drivers/ide/pci/cmd64x.c
===================================================================
--- a.orig/drivers/ide/pci/cmd64x.c
+++ a/drivers/ide/pci/cmd64x.c
@@ -507,13 +507,13 @@ static int cmd64x_ide_dma_end (ide_drive
 
 	drive->waiting_for_dma = 0;
 	/* read DMA command state */
-	dma_cmd = hwif->INB(hwif->dma_command);
+	dma_cmd = inb(hwif->dma_command);
 	/* stop DMA */
-	hwif->OUTB((dma_cmd & ~1), hwif->dma_command);
+	outb(dma_cmd & ~1, hwif->dma_command);
 	/* get DMA status */
-	dma_stat = hwif->INB(hwif->dma_status);
+	dma_stat = inb(hwif->dma_status);
 	/* clear the INTR & ERROR bits */
-	hwif->OUTB(dma_stat|6, hwif->dma_status);
+	outb(dma_stat | 6, hwif->dma_status);
 	if (cmd64x_alt_dma_status(dev)) {
 		u8 dma_intr	= 0;
 		u8 dma_mask	= (hwif->channel) ? ARTTIM23_INTR_CH1 :
@@ -535,7 +535,7 @@ static int cmd64x_ide_dma_test_irq (ide_
 	struct pci_dev *dev		= hwif->pci_dev;
         u8 dma_alt_stat = 0, mask	= (hwif->channel) ? MRDMODE_INTR_CH1 :
 							    MRDMODE_INTR_CH0;
-	u8 dma_stat = hwif->INB(hwif->dma_status);
+	u8 dma_stat = inb(hwif->dma_status);
 
 	(void) pci_read_config_byte(dev, MRDMODE, &dma_alt_stat);
 #ifdef DEBUG
@@ -565,13 +565,13 @@ static int cmd646_1_ide_dma_end (ide_dri
 
 	drive->waiting_for_dma = 0;
 	/* get DMA status */
-	dma_stat = hwif->INB(hwif->dma_status);
+	dma_stat = inb(hwif->dma_status);
 	/* read DMA command state */
-	dma_cmd = hwif->INB(hwif->dma_command);
+	dma_cmd = inb(hwif->dma_command);
 	/* stop DMA */
-	hwif->OUTB((dma_cmd & ~1), hwif->dma_command);
+	outb(dma_cmd & ~1, hwif->dma_command);
 	/* clear the INTR & ERROR bits */
-	hwif->OUTB(dma_stat|6, hwif->dma_status);
+	outb(dma_stat | 6, hwif->dma_status);
 	/* and free any DMA resources */
 	ide_destroy_dmatable(drive);
 	/* verify good DMA status */
Index: a/drivers/ide/pci/cs5530.c
===================================================================
--- a.orig/drivers/ide/pci/cs5530.c
+++ a/drivers/ide/pci/cs5530.c
@@ -81,8 +81,8 @@ static void cs5530_tuneproc (ide_drive_t
 
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
 	if (!cs5530_set_xfer_mode(drive, modes[pio])) {
-		format = (hwif->INL(basereg+4) >> 31) & 1;
-		hwif->OUTL(cs5530_pio_timings[format][pio],
+		format = (inl(basereg + 4) >> 31) & 1;
+		outl(cs5530_pio_timings[format][pio],
 			basereg+(drive->select.b.unit<<3));
 	}
 }
@@ -183,17 +183,17 @@ static int cs5530_config_dma (ide_drive_
 			break;
 	}
 	basereg = CS5530_BASEREG(hwif);
-	reg = hwif->INL(basereg+4);		/* get drive0 config register */
+	reg = inl(basereg + 4);			/* get drive0 config register */
 	timings |= reg & 0x80000000;		/* preserve PIO format bit */
 	if (unit == 0) {			/* are we configuring drive0? */
-		hwif->OUTL(timings, basereg+4);	/* write drive0 config register */
+		outl(timings, basereg + 4);	/* write drive0 config register */
 	} else {
 		if (timings & 0x00100000)
 			reg |=  0x00100000;	/* enable UDMA timings for both drives */
 		else
 			reg &= ~0x00100000;	/* disable UDMA timings for both drives */
-		hwif->OUTL(reg,     basereg+4);	/* write drive0 config register */
-		hwif->OUTL(timings, basereg+12);	/* write drive1 config register */
+		outl(reg, basereg + 4);		/* write drive0 config register */
+		outl(timings, basereg + 12);	/* write drive1 config register */
 	}
 
 	/*
@@ -315,17 +315,17 @@ static void __devinit init_hwif_cs5530 (
 
 	hwif->tuneproc = &cs5530_tuneproc;
 	basereg = CS5530_BASEREG(hwif);
-	d0_timings = hwif->INL(basereg+0);
+	d0_timings = inl(basereg + 0);
 	if (CS5530_BAD_PIO(d0_timings)) {
 		/* PIO timings not initialized? */
-		hwif->OUTL(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+0);
+		outl(cs5530_pio_timings[(d0_timings >> 31) & 1][0], basereg + 0);
 		if (!hwif->drives[0].autotune)
 			hwif->drives[0].autotune = 1;
 			/* needs autotuning later */
 	}
-	if (CS5530_BAD_PIO(hwif->INL(basereg+8))) {
-	/* PIO timings not initialized? */
-		hwif->OUTL(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+8);
+	if (CS5530_BAD_PIO(inl(basereg + 8))) {
+		/* PIO timings not initialized? */
+		outl(cs5530_pio_timings[(d0_timings >> 31) & 1][0], basereg + 8);
 		if (!hwif->drives[1].autotune)
 			hwif->drives[1].autotune = 1;
 			/* needs autotuning later */
Index: a/drivers/ide/pci/cy82c693.c
===================================================================
--- a.orig/drivers/ide/pci/cy82c693.c
+++ a/drivers/ide/pci/cy82c693.c
@@ -197,8 +197,8 @@ static void cy82c693_dma_enable (ide_dri
 #if CY82C693_DEBUG_LOGS
 	/* for debug let's show the previous values */
 
-	HWIF(drive)->OUTB(index, CY82_INDEX_PORT);
-	data = HWIF(drive)->INB(CY82_DATA_PORT);
+	outb(index, CY82_INDEX_PORT);
+	data = inb(CY82_DATA_PORT);
 
 	printk (KERN_INFO "%s (ch=%d, dev=%d): DMA mode is %d (single=%d)\n",
 		drive->name, HWIF(drive)->channel, drive->select.b.unit,
@@ -207,8 +207,8 @@ static void cy82c693_dma_enable (ide_dri
 
 	data = (u8)mode|(u8)(single<<2);
 
-	HWIF(drive)->OUTB(index, CY82_INDEX_PORT);
-	HWIF(drive)->OUTB(data, CY82_DATA_PORT);
+	outb(index, CY82_INDEX_PORT);
+	outb(data, CY82_DATA_PORT);
 
 #if CY82C693_DEBUG_INFO
 	printk(KERN_INFO "%s (ch=%d, dev=%d): set DMA mode to %d (single=%d)\n",
@@ -227,8 +227,8 @@ static void cy82c693_dma_enable (ide_dri
 	 */
 
 	data = BUSMASTER_TIMEOUT;
-	HWIF(drive)->OUTB(CY82_INDEX_TIMEOUT, CY82_INDEX_PORT);
-	HWIF(drive)->OUTB(data, CY82_DATA_PORT);
+	outb(CY82_INDEX_TIMEOUT, CY82_INDEX_PORT);
+	outb(data, CY82_DATA_PORT);
 
 #if CY82C693_DEBUG_INFO	
 	printk (KERN_INFO "%s: Set IDE Bus Master TimeOut Register to 0x%X\n",
Index: a/drivers/ide/pci/hpt366.c
===================================================================
--- a.orig/drivers/ide/pci/hpt366.c
+++ a/drivers/ide/pci/hpt366.c
@@ -836,7 +836,7 @@ static int hpt374_ide_dma_test_irq(ide_d
 		return 0;
 	}
 
-	dma_stat = hwif->INB(hwif->dma_status);
+	dma_stat = inb(hwif->dma_status);
 	/* return 1 if INTR asserted */
 	if (dma_stat & 4)
 		return 1;
Index: a/drivers/ide/pci/ns87415.c
===================================================================
--- a.orig/drivers/ide/pci/ns87415.c
+++ a/drivers/ide/pci/ns87415.c
@@ -166,10 +166,10 @@ static int ns87415_ide_dma_end (ide_driv
 	/* get dma command mode */
 	dma_cmd = hwif->INB(hwif->dma_command);
 	/* stop DMA */
-	hwif->OUTB(dma_cmd & ~1, hwif->dma_command);
+	outb(dma_cmd & ~1, hwif->dma_command);
 	/* from ERRATA: clear the INTR & ERROR bits */
 	dma_cmd = hwif->INB(hwif->dma_command);
-	hwif->OUTB(dma_cmd|6, hwif->dma_command);
+	outb(dma_cmd | 6, hwif->dma_command);
 	/* and free any DMA resources */
 	ide_destroy_dmatable(drive);
 	/* verify good DMA status */
@@ -243,9 +243,9 @@ static void __devinit init_hwif_ns87415 
 		 *      to SELECT_DRIVE() properly during first probe_hwif().
 		 */
 		timeout = 10000;
-		hwif->OUTB(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
+		outb(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		udelay(10);
-		hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
+		outb(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		do {
 			udelay(50);
 			stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
@@ -263,7 +263,7 @@ static void __devinit init_hwif_ns87415 
 	if (!hwif->dma_base)
 		return;
 
-	hwif->OUTB(0x60, hwif->dma_status);
+	outb(0x60, hwif->dma_status);
 	hwif->dma_setup = &ns87415_ide_dma_setup;
 	hwif->ide_dma_check = &ns87415_ide_dma_check;
 	hwif->ide_dma_end = &ns87415_ide_dma_end;
Index: a/drivers/ide/pci/opti621.c
===================================================================
--- a.orig/drivers/ide/pci/opti621.c
+++ a/drivers/ide/pci/opti621.c
@@ -176,34 +176,35 @@ static int cmpt_clk(int time, int bus_sp
 	return ((time*bus_speed+999)/1000);
 }
 
-static void write_reg(ide_hwif_t *hwif, u8 value, int reg)
 /* Write value to register reg, base of register
  * is at reg_base (0x1f0 primary, 0x170 secondary,
  * if not changed by PCI configuration).
  * This is from setupvic.exe program.
  */
+static void write_reg(u8 value, int reg)
 {
-	hwif->INW(reg_base+1);
-	hwif->INW(reg_base+1);
-	hwif->OUTB(3, reg_base+2);
-	hwif->OUTB(value, reg_base+reg);
-	hwif->OUTB(0x83, reg_base+2);
+	inw(reg_base + 1);
+	inw(reg_base + 1);
+	outb(3, reg_base + 2);
+	outb(value, reg_base + reg);
+	outb(0x83, reg_base + 2);
 }
 
-static u8 read_reg(ide_hwif_t *hwif, int reg)
 /* Read value from register reg, base of register
  * is at reg_base (0x1f0 primary, 0x170 secondary,
  * if not changed by PCI configuration).
  * This is from setupvic.exe program.
  */
+static u8 read_reg(int reg)
 {
 	u8 ret = 0;
 
-	hwif->INW(reg_base+1);
-	hwif->INW(reg_base+1);
-	hwif->OUTB(3, reg_base+2);
-	ret = hwif->INB(reg_base+reg);
-	hwif->OUTB(0x83, reg_base+2);
+	inw(reg_base + 1);
+	inw(reg_base + 1);
+	outb(3, reg_base + 2);
+	ret = inb(reg_base + reg);
+	outb(0x83, reg_base + 2);
+
 	return ret;
 }
 
@@ -286,39 +287,39 @@ static void opti621_tune_drive (ide_driv
      	reg_base = hwif->io_ports[IDE_DATA_OFFSET];
 
 	/* allow Register-B */
-	hwif->OUTB(0xc0, reg_base+CNTRL_REG);
+	outb(0xc0, reg_base + CNTRL_REG);
 	/* hmm, setupvic.exe does this ;-) */
-	hwif->OUTB(0xff, reg_base+5);
+	outb(0xff, reg_base + 5);
 	/* if reads 0xff, adapter not exist? */
-	(void) hwif->INB(reg_base+CNTRL_REG);
+	(void)inb(reg_base + CNTRL_REG);
 	/* if reads 0xc0, no interface exist? */
-	read_reg(hwif, CNTRL_REG);
+	read_reg(CNTRL_REG);
 	/* read version, probably 0 */
-	read_reg(hwif, STRAP_REG);
+	read_reg(STRAP_REG);
 
 	/* program primary drive */
-		/* select Index-0 for Register-A */
-	write_reg(hwif, 0,      MISC_REG);
-		/* set read cycle timings */
-	write_reg(hwif, cycle1, READ_REG);
-		/* set write cycle timings */
-	write_reg(hwif, cycle1, WRITE_REG);
+	/* select Index-0 for Register-A */
+	write_reg(0, MISC_REG);
+	/* set read cycle timings */
+	write_reg(cycle1, READ_REG);
+	/* set write cycle timings */
+	write_reg(cycle1, WRITE_REG);
 
 	/* program secondary drive */
-		/* select Index-1 for Register-B */
-	write_reg(hwif, 1,      MISC_REG);
-		/* set read cycle timings */
-	write_reg(hwif, cycle2, READ_REG);
-		/* set write cycle timings */
-	write_reg(hwif, cycle2, WRITE_REG);
+	/* select Index-1 for Register-B */
+	write_reg(1, MISC_REG);
+	/* set read cycle timings */
+	write_reg(cycle2, READ_REG);
+	/* set write cycle timings */
+	write_reg(cycle2, WRITE_REG);
 
 	/* use Register-A for drive 0 */
 	/* use Register-B for drive 1 */
-	write_reg(hwif, 0x85, CNTRL_REG);
+	write_reg(0x85, CNTRL_REG);
 
 	/* set address setup, DRDY timings,   */
 	/*  and read prefetch for both drives */
- 	write_reg(hwif, misc, MISC_REG);
+	write_reg(misc, MISC_REG);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
Index: a/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_new.c
+++ a/drivers/ide/pci/pdc202xx_new.c
@@ -101,8 +101,8 @@ static u8 get_indexed_reg(ide_hwif_t *hw
 {
 	u8 value;
 
-	hwif->OUTB(index, hwif->dma_vendor1);
-	value = hwif->INB(hwif->dma_vendor3);
+	outb(index, hwif->dma_vendor1);
+	value = inb(hwif->dma_vendor3);
 
 	DBG("index[%02X] value[%02X]\n", index, value);
 	return value;
@@ -115,8 +115,8 @@ static u8 get_indexed_reg(ide_hwif_t *hw
  */
 static void set_indexed_reg(ide_hwif_t *hwif, u8 index, u8 value)
 {
-	hwif->OUTB(index, hwif->dma_vendor1);
-	hwif->OUTB(value, hwif->dma_vendor3);
+	outb(index, hwif->dma_vendor1);
+	outb(value, hwif->dma_vendor3);
 	DBG("index[%02X] value[%02X]\n", index, value);
 }
 
Index: a/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_old.c
+++ a/drivers/ide/pci/pdc202xx_old.c
@@ -250,17 +250,17 @@ static u8 pdc202xx_old_cable_detect (ide
 static void pdc_old_enable_66MHz_clock(ide_hwif_t *hwif)
 {
 	unsigned long clock_reg = hwif->dma_master + 0x11;
-	u8 clock = hwif->INB(clock_reg);
+	u8 clock = inb(clock_reg);
 
-	hwif->OUTB(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
+	outb(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
 {
 	unsigned long clock_reg = hwif->dma_master + 0x11;
-	u8 clock = hwif->INB(clock_reg);
+	u8 clock = inb(clock_reg);
 
-	hwif->OUTB(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
+	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
 static int config_chipset_for_dma (ide_drive_t *drive)
@@ -367,14 +367,14 @@ static void pdc202xx_old_ide_dma_start(i
 		unsigned long high_16   = hwif->dma_master;
 		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
 		u32 word_count	= 0;
-		u8 clock = hwif->INB(high_16 + 0x11);
+		u8 clock = inb(high_16 + 0x11);
 
-		hwif->OUTB(clock|(hwif->channel ? 0x08 : 0x02), high_16+0x11);
+		outb(clock | (hwif->channel ? 0x08 : 0x02), high_16 + 0x11);
 		word_count = (rq->nr_sectors << 8);
 		word_count = (rq_data_dir(rq) == READ) ?
 					word_count | 0x05000000 :
 					word_count | 0x06000000;
-		hwif->OUTL(word_count, atapi_reg);
+		outl(word_count, atapi_reg);
 	}
 	ide_dma_start(drive);
 }
@@ -387,9 +387,9 @@ static int pdc202xx_old_ide_dma_end(ide_
 		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
 		u8 clock		= 0;
 
-		hwif->OUTL(0, atapi_reg); /* zero out extra */
-		clock = hwif->INB(high_16 + 0x11);
-		hwif->OUTB(clock & ~(hwif->channel ? 0x08:0x02), high_16+0x11);
+		outl(0, atapi_reg); /* zero out extra */
+		clock = inb(high_16 + 0x11);
+		outb(clock & ~(hwif->channel ? 0x08:0x02), high_16 + 0x11);
 	}
 	if (drive->current_speed > XFER_UDMA_2)
 		pdc_old_disable_66MHz_clock(drive->hwif);
@@ -400,8 +400,8 @@ static int pdc202xx_old_ide_dma_test_irq
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned long high_16	= hwif->dma_master;
-	u8 dma_stat		= hwif->INB(hwif->dma_status);
-	u8 sc1d			= hwif->INB((high_16 + 0x001d));
+	u8 dma_stat		= inb(hwif->dma_status);
+	u8 sc1d			= inb(high_16 + 0x001d);
 
 	if (hwif->channel) {
 		/* bit7: Error, bit6: Interrupting, bit5: FIFO Full, bit4: FIFO Empty */
@@ -437,11 +437,11 @@ static int pdc202xx_ide_dma_timeout(ide_
 static void pdc202xx_reset_host (ide_hwif_t *hwif)
 {
 	unsigned long high_16	= hwif->dma_master;
-	u8 udma_speed_flag	= hwif->INB(high_16|0x001f);
+	u8 udma_speed_flag	= inb(high_16 | 0x001f);
 
-	hwif->OUTB((udma_speed_flag | 0x10), (high_16|0x001f));
+	outb(udma_speed_flag | 0x10, high_16 | 0x001f);
 	mdelay(100);
-	hwif->OUTB((udma_speed_flag & ~0x10), (high_16|0x001f));
+	outb(udma_speed_flag & ~0x10, high_16 | 0x001f);
 	mdelay(2000);	/* 2 seconds ?! */
 
 	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
@@ -529,9 +529,9 @@ static void __devinit init_dma_pdc202xx(
 		return;
 	}
 
-	udma_speed_flag	= hwif->INB((dmabase|0x1f));
-	primary_mode	= hwif->INB((dmabase|0x1a));
-	secondary_mode	= hwif->INB((dmabase|0x1b));
+	udma_speed_flag	= inb(dmabase | 0x1f);
+	primary_mode	= inb(dmabase | 0x1a);
+	secondary_mode	= inb(dmabase | 0x1b);
 	printk(KERN_INFO "%s: (U)DMA Burst Bit %sABLED " \
 		"Primary %s Mode " \
 		"Secondary %s Mode.\n", hwif->cds->name,
@@ -544,9 +544,8 @@ static void __devinit init_dma_pdc202xx(
 		printk(KERN_INFO "%s: FORCING BURST BIT 0x%02x->0x%02x ",
 			hwif->cds->name, udma_speed_flag,
 			(udma_speed_flag|1));
-		hwif->OUTB(udma_speed_flag|1,(dmabase|0x1f));
-		printk("%sACTIVE\n",
-			(hwif->INB(dmabase|0x1f)&1) ? "":"IN");
+		outb(udma_speed_flag | 1, dmabase | 0x1f);
+		printk("%sACTIVE\n", (inb(dmabase | 0x1f) & 1) ? "" : "IN");
 	}
 #endif /* CONFIG_PDC202XX_BURST */
 
Index: a/drivers/ide/pci/serverworks.c
===================================================================
--- a.orig/drivers/ide/pci/serverworks.c
+++ a/drivers/ide/pci/serverworks.c
@@ -160,7 +160,7 @@ static int svwks_tune_chipset (ide_drive
 	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 	    (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
 		if (!drive->init_speed) {
-			u8 dma_stat = hwif->INB(hwif->dma_status);
+			u8 dma_stat = inb(hwif->dma_status);
 
 dma_pio:
 			if (((ultra_enable << (7-drive->dn) & 0x80) == 0x80) &&
@@ -529,7 +529,7 @@ static void __devinit init_hwif_svwks (i
 	if (!noautodma)
 		hwif->autodma = 1;
 
-	dma_stat = hwif->INB(hwif->dma_status);
+	dma_stat = inb(hwif->dma_status);
 	hwif->drives[0].autodma = (dma_stat & 0x20);
 	hwif->drives[1].autodma = (dma_stat & 0x40);
 	hwif->drives[0].autotune = (!(dma_stat & 0x20));
Index: a/drivers/ide/pci/sgiioc4.c
===================================================================
--- a.orig/drivers/ide/pci/sgiioc4.c
+++ a/drivers/ide/pci/sgiioc4.c
@@ -110,24 +110,24 @@ sgiioc4_init_hwif_ports(hw_regs_t * hw, 
 static void
 sgiioc4_maskproc(ide_drive_t * drive, int mask)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	hwif->OUTB(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
-		   IDE_CONTROL_REG);
+	writeb(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
+	       (void __iomem *)IDE_CONTROL_REG);
 }
 
 
 static int
 sgiioc4_checkirq(ide_hwif_t * hwif)
 {
-	u8 intr_reg =
-	    hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + IOC4_INTR_REG * 4);
+	unsigned long intr_addr =
+		hwif->io_ports[IDE_IRQ_OFFSET] + IOC4_INTR_REG * 4;
 
-	if (intr_reg & 0x03)
+	if ((u8)readl((void __iomem *)intr_addr) & 0x03)
 		return 1;
 
 	return 0;
 }
 
+static u8 sgiioc4_INB(unsigned long);
 
 static int
 sgiioc4_clearirq(ide_drive_t * drive)
@@ -138,21 +138,21 @@ sgiioc4_clearirq(ide_drive_t * drive)
 	    hwif->io_ports[IDE_IRQ_OFFSET] + (IOC4_INTR_REG << 2);
 
 	/* Code to check for PCI error conditions */
-	intr_reg = hwif->INL(other_ir);
+	intr_reg = readl((void __iomem *)other_ir);
 	if (intr_reg & 0x03) { /* Valid IOC4-IDE interrupt */
 		/*
-		 * Using hwif->INB to read the IDE_STATUS_REG has a side effect
+		 * Using sgiioc4_INB to read the IDE_STATUS_REG has a side effect
 		 * of clearing the interrupt.  The first read should clear it
 		 * if it is set.  The second read should return a "clear" status
 		 * if it got cleared.  If not, then spin for a bit trying to
 		 * clear it.
 		 */
-		u8 stat = hwif->INB(IDE_STATUS_REG);
+		u8 stat = sgiioc4_INB(IDE_STATUS_REG);
 		int count = 0;
-		stat = hwif->INB(IDE_STATUS_REG);
+		stat = sgiioc4_INB(IDE_STATUS_REG);
 		while ((stat & 0x80) && (count++ < 100)) {
 			udelay(1);
-			stat = hwif->INB(IDE_STATUS_REG);
+			stat = sgiioc4_INB(IDE_STATUS_REG);
 		}
 
 		if (intr_reg & 0x02) {
@@ -161,9 +161,9 @@ sgiioc4_clearirq(ide_drive_t * drive)
 			    pci_stat_cmd_reg;
 
 			pci_err_addr_low =
-				hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET]);
+				readl((void __iomem *)hwif->io_ports[IDE_IRQ_OFFSET]);
 			pci_err_addr_high =
-				hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + 4);
+				readl((void __iomem *)(hwif->io_ports[IDE_IRQ_OFFSET] + 4));
 			pci_read_config_dword(hwif->pci_dev, PCI_COMMAND,
 					      &pci_stat_cmd_reg);
 			printk(KERN_ERR
@@ -180,9 +180,9 @@ sgiioc4_clearirq(ide_drive_t * drive)
 		}
 
 		/* Clear the Interrupt, Error bits on the IOC4 */
-		hwif->OUTL(0x03, other_ir);
+		writel(0x03, (void __iomem *)other_ir);
 
-		intr_reg = hwif->INL(other_ir);
+		intr_reg = readl((void __iomem *)other_ir);
 	}
 
 	return intr_reg & 3;
@@ -191,23 +191,25 @@ sgiioc4_clearirq(ide_drive_t * drive)
 static void sgiioc4_ide_dma_start(ide_drive_t * drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	unsigned int reg = hwif->INL(hwif->dma_base + IOC4_DMA_CTRL * 4);
+	unsigned long ioc4_dma_addr = hwif->dma_base + IOC4_DMA_CTRL * 4;
+	unsigned int reg = readl((void __iomem *)ioc4_dma_addr);
 	unsigned int temp_reg = reg | IOC4_S_DMA_START;
 
-	hwif->OUTL(temp_reg, hwif->dma_base + IOC4_DMA_CTRL * 4);
+	writel(temp_reg, (void __iomem *)ioc4_dma_addr);
 }
 
 static u32
 sgiioc4_ide_dma_stop(ide_hwif_t *hwif, u64 dma_base)
 {
+	unsigned long ioc4_dma_addr = dma_base + IOC4_DMA_CTRL * 4;
 	u32	ioc4_dma;
 	int	count;
 
 	count = 0;
-	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+	ioc4_dma = readl((void __iomem *)ioc4_dma_addr);
 	while ((ioc4_dma & IOC4_S_DMA_STOP) && (count++ < 200)) {
 		udelay(1);
-		ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+		ioc4_dma = readl((void __iomem *)ioc4_dma_addr);
 	}
 	return ioc4_dma;
 }
@@ -218,11 +220,11 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 {
 	u32 ioc4_dma, bc_dev, bc_mem, num, valid = 0, cnt = 0;
 	ide_hwif_t *hwif = HWIF(drive);
-	u64 dma_base = hwif->dma_base;
+	unsigned long dma_base = hwif->dma_base;
 	int dma_stat = 0;
 	unsigned long *ending_dma = ide_get_hwifdata(hwif);
 
-	hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+	writel(IOC4_S_DMA_STOP, (void __iomem *)(dma_base + IOC4_DMA_CTRL * 4));
 
 	ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
 
@@ -254,8 +256,8 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 		dma_stat = 1;
 	}
 
-	bc_dev = hwif->INL(dma_base + IOC4_BC_DEV * 4);
-	bc_mem = hwif->INL(dma_base + IOC4_BC_MEM * 4);
+	bc_dev = readl((void __iomem *)(dma_base + IOC4_BC_DEV * 4));
+	bc_mem = readl((void __iomem *)(dma_base + IOC4_BC_MEM * 4));
 
 	if ((bc_dev & 0x01FF) || (bc_mem & 0x1FF)) {
 		if (bc_dev > bc_mem + 8) {
@@ -436,16 +438,17 @@ sgiioc4_configure_for_dma(int dma_direct
 {
 	u32 ioc4_dma;
 	ide_hwif_t *hwif = HWIF(drive);
-	u64 dma_base = hwif->dma_base;
+	unsigned long dma_base = hwif->dma_base;
+	unsigned long ioc4_dma_addr = dma_base + IOC4_DMA_CTRL * 4;
 	u32 dma_addr, ending_dma_addr;
 
-	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+	ioc4_dma = readl((void __iomem *)ioc4_dma_addr);
 
 	if (ioc4_dma & IOC4_S_DMA_ACTIVE) {
 		printk(KERN_WARNING
 			"%s(%s):Warning!! DMA from previous transfer was still active\n",
 		       __FUNCTION__, drive->name);
-		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		writel(IOC4_S_DMA_STOP, (void __iomem *)ioc4_dma_addr);
 		ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
 
 		if (ioc4_dma & IOC4_S_DMA_STOP)
@@ -454,13 +457,13 @@ sgiioc4_configure_for_dma(int dma_direct
 			       __FUNCTION__, drive->name);
 	}
 
-	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
+	ioc4_dma = readl((void __iomem *)ioc4_dma_addr);
 	if (ioc4_dma & IOC4_S_DMA_ERROR) {
 		printk(KERN_WARNING
 		       "%s(%s) : Warning!! - DMA Error during Previous"
 		       " transfer | status 0x%x\n",
 		       __FUNCTION__, drive->name, ioc4_dma);
-		hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
+		writel(IOC4_S_DMA_STOP, (void __iomem *)ioc4_dma_addr);
 		ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
 
 		if (ioc4_dma & IOC4_S_DMA_STOP)
@@ -471,14 +474,14 @@ sgiioc4_configure_for_dma(int dma_direct
 
 	/* Address of the Scatter Gather List */
 	dma_addr = cpu_to_le32(hwif->dmatable_dma);
-	hwif->OUTL(dma_addr, dma_base + IOC4_DMA_PTR_L * 4);
+	writel(dma_addr, (void __iomem *)(dma_base + IOC4_DMA_PTR_L * 4));
 
 	/* Address of the Ending DMA */
 	memset(ide_get_hwifdata(hwif), 0, IOC4_IDE_CACHELINE_SIZE);
 	ending_dma_addr = cpu_to_le32(hwif->dma_status);
-	hwif->OUTL(ending_dma_addr, dma_base + IOC4_DMA_END_ADDR * 4);
+	writel(ending_dma_addr, (void __iomem *)(dma_base + IOC4_DMA_END_ADDR * 4));
 
-	hwif->OUTL(dma_direction, dma_base + IOC4_DMA_CTRL * 4);
+	writel(dma_direction, (void __iomem *)ioc4_dma_addr);
 	drive->waiting_for_dma = 1;
 }
 
@@ -688,7 +691,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	default_hwif_mmiops(hwif);
 
 	/* Initializing chipset IRQ Registers */
-	hwif->OUTL(0x03, irqport + IOC4_INTR_SET * 4);
+	writel(0x03, (void __iomem *)(irqport + IOC4_INTR_SET * 4));
 
 	ide_init_sgiioc4(hwif);
 
Index: a/drivers/ide/pci/siimage.c
===================================================================
--- a.orig/drivers/ide/pci/siimage.c
+++ a/drivers/ide/pci/siimage.c
@@ -461,11 +461,11 @@ static int siimage_mmio_ide_dma_test_irq
 	unsigned long addr	= siimage_selreg(hwif, 0x1);
 
 	if (SATA_ERROR_REG) {
-		u32 ext_stat = hwif->INL(base + 0x10);
+		u32 ext_stat = readl((void __iomem *)(base + 0x10));
 		u8 watchdog = 0;
 		if (ext_stat & ((hwif->channel) ? 0x40 : 0x10)) {
-			u32 sata_error = hwif->INL(SATA_ERROR_REG);
-			hwif->OUTL(sata_error, SATA_ERROR_REG);
+			u32 sata_error = readl((void __iomem *)SATA_ERROR_REG);
+			writel(sata_error, (void __iomem *)SATA_ERROR_REG);
 			watchdog = (sata_error & 0x00680000) ? 1 : 0;
 			printk(KERN_WARNING "%s: sata_error = 0x%08x, "
 				"watchdog = %d, %s\n",
@@ -482,11 +482,11 @@ static int siimage_mmio_ide_dma_test_irq
 	}
 
 	/* return 1 if INTR asserted */
-	if ((hwif->INB(hwif->dma_status) & 0x04) == 0x04)
+	if ((readb((void __iomem *)hwif->dma_status) & 0x04) == 0x04)
 		return 1;
 
 	/* return 1 if Device INTR asserted */
-	if ((hwif->INB(addr) & 8) == 8)
+	if ((readb((void __iomem *)addr) & 8) == 8)
 		return 0;	//return 1;
 
 	return 0;
@@ -508,9 +508,9 @@ static int siimage_busproc (ide_drive_t 
 	u32 stat_config		= 0;
 	unsigned long addr	= siimage_selreg(hwif, 0);
 
-	if (hwif->mmio) {
-		stat_config = hwif->INL(addr);
-	} else
+	if (hwif->mmio)
+		stat_config = readl((void __iomem *)addr);
+	else
 		pci_read_config_dword(hwif->pci_dev, addr, &stat_config);
 
 	switch (state) {
@@ -546,9 +546,10 @@ static int siimage_reset_poll (ide_drive
 	if (SATA_STATUS_REG) {
 		ide_hwif_t *hwif	= HWIF(drive);
 
-		if ((hwif->INL(SATA_STATUS_REG) & 0x03) != 0x03) {
+		/* SATA_STATUS_REG is valid only when in MMIO mode */
+		if ((readl((void __iomem *)SATA_STATUS_REG) & 0x03) != 0x03) {
 			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
-				hwif->name, hwif->INL(SATA_STATUS_REG));
+				hwif->name, readl((void __iomem *)SATA_STATUS_REG));
 			HWGROUP(drive)->polling = 0;
 			return ide_started;
 		}
@@ -608,7 +609,8 @@ static void siimage_reset (ide_drive_t *
 	}
 
 	if (SATA_STATUS_REG) {
-		u32 sata_stat = hwif->INL(SATA_STATUS_REG);
+		/* SATA_STATUS_REG is valid only when in MMIO mode */
+		u32 sata_stat = readl((void __iomem *)SATA_STATUS_REG);
 		printk(KERN_WARNING "%s: reset phy, status=0x%08x, %s\n",
 			hwif->name, sata_stat, __FUNCTION__);
 		if (!(sata_stat)) {
Index: a/drivers/ide/pci/sl82c105.c
===================================================================
--- a.orig/drivers/ide/pci/sl82c105.c
+++ a/drivers/ide/pci/sl82c105.c
@@ -215,7 +215,7 @@ static int sl82c105_ide_dma_lost_irq(ide
 	 * Was DMA enabled?  If so, disable it - we're resetting the
 	 * host.  The IDE layer will be handling the drive for us.
 	 */
-	val = hwif->INB(dma_base);
+	val = inb(dma_base);
 	if (val & 1) {
 		outb(val & ~1, dma_base);
 		printk("sl82c105: DMA was enabled\n");
@@ -431,7 +431,7 @@ static void __devinit init_hwif_sl82c105
 	if (!hwif->dma_base)
 		return;
 
-	dma_state = hwif->INB(hwif->dma_base + 2) & ~0x60;
+	dma_state = inb(hwif->dma_base + 2) & ~0x60;
 	rev = sl82c105_bridge_revision(hwif->pci_dev);
 	if (rev <= 5) {
 		/*
@@ -462,7 +462,7 @@ static void __devinit init_hwif_sl82c105
 		if (hwif->mate)
 			hwif->serialized = hwif->mate->serialized = 1;
 	}
-	hwif->OUTB(dma_state, hwif->dma_base + 2);
+	outb(dma_state, hwif->dma_base + 2);
 }
 
 static ide_pci_device_t sl82c105_chipset __devinitdata = {
Index: a/drivers/ide/pci/tc86c001.c
===================================================================
--- a.orig/drivers/ide/pci/tc86c001.c
+++ a/drivers/ide/pci/tc86c001.c
@@ -45,7 +45,7 @@ static int tc86c001_tune_chipset(ide_dri
 
 	scr &= (speed < XFER_MW_DMA_0) ? 0xf8ff : 0xff0f;
 	scr |= mode;
-	hwif->OUTW(scr, scr_port);
+	outw(scr, scr_port);
 
 	return ide_config_drive_speed(drive, speed);
 }
@@ -89,15 +89,15 @@ static int tc86c001_timer_expiry(ide_dri
 		       "attempting recovery...\n", drive->name);
 
 		/* Stop DMA */
-		hwif->OUTB(dma_cmd & ~0x01, hwif->dma_command);
+		outb(dma_cmd & ~0x01, hwif->dma_command);
 
 		/* Setup the dummy DMA transfer */
-		hwif->OUTW(0, sc_base + 0x0a);	/* Sector Count */
-		hwif->OUTW(0, twcr_port);	/* Transfer Word Count 1 or 2 */
+		outw(0, sc_base + 0x0a);	/* Sector Count */
+		outw(0, twcr_port);	/* Transfer Word Count 1 or 2 */
 
 		/* Start the dummy DMA transfer */
-		hwif->OUTB(0x00, hwif->dma_command); /* clear R_OR_WCTR for write */
-		hwif->OUTB(0x01, hwif->dma_command); /* set START_STOPBM */
+		outb(0x00, hwif->dma_command); /* clear R_OR_WCTR for write */
+		outb(0x01, hwif->dma_command); /* set START_STOPBM */
 
 		/*
 		 * If an interrupt was pending, it should come thru shortly.
@@ -128,8 +128,8 @@ static void tc86c001_dma_start(ide_drive
 	 * the appropriate system control registers for DMA to work
 	 * with LBA48 and ATAPI devices...
 	 */
-	hwif->OUTW(nsectors, sc_base + 0x0a);	/* Sector Count */
-	hwif->OUTW(SECTOR_SIZE / 2, twcr_port); /* Transfer Word Count 1/2 */
+	outw(nsectors, sc_base + 0x0a);	/* Sector Count */
+	outw(SECTOR_SIZE / 2, twcr_port); /* Transfer Word Count 1/2 */
 
 	/* Install our timeout expiry hook, saving the current handler... */
 	ide_set_hwifdata(hwif, hwgroup->expiry);
@@ -168,7 +168,7 @@ static int tc86c001_busproc(ide_drive_t 
 	}
 
 	/* System Control 1 Register bit 11 (ATA Hard Reset) write */
-	hwif->OUTW(scr1, sc_base + 0x00);
+	outw(scr1, sc_base + 0x00);
 	return 0;
 }
 
@@ -204,13 +204,13 @@ static void __devinit init_hwif_tc86c001
 	u16 scr1		= hwif->INW(sc_base + 0x00);;
 
 	/* System Control 1 Register bit 15 (Soft Reset) set */
-	hwif->OUTW(scr1 |  0x8000, sc_base + 0x00);
+	outw(scr1 |  0x8000, sc_base + 0x00);
 
 	/* System Control 1 Register bit 14 (FIFO Reset) set */
-	hwif->OUTW(scr1 |  0x4000, sc_base + 0x00);
+	outw(scr1 |  0x4000, sc_base + 0x00);
 
 	/* System Control 1 Register: reset clear */
-	hwif->OUTW(scr1 & ~0xc000, sc_base + 0x00);
+	outw(scr1 & ~0xc000, sc_base + 0x00);
 
 	/* Store the system control register base for convenience... */
 	hwif->config_data = sc_base;
@@ -228,7 +228,7 @@ static void __devinit init_hwif_tc86c001
 	 * Sector Count Control Register bits 0 and 1 set:
 	 * software sets Sector Count Register for master and slave device
 	 */
-	hwif->OUTW(0x0003, sc_base + 0x0c);
+	outw(0x0003, sc_base + 0x0c);
 
 	/* Sector Count Register limit */
 	hwif->rqsize	 = 0xffff;
Index: a/drivers/ide/pci/trm290.c
===================================================================
--- a.orig/drivers/ide/pci/trm290.c
+++ a/drivers/ide/pci/trm290.c
@@ -157,16 +157,16 @@ static void trm290_prepare_drive (ide_dr
 	if (reg != hwif->select_data) {
 		hwif->select_data = reg;
 		/* set PIO/DMA */
-		hwif->OUTB(0x51|(hwif->channel<<3), hwif->config_data+1);
-		hwif->OUTW(reg & 0xff, hwif->config_data);
+		outb(0x51 | (hwif->channel << 3), hwif->config_data + 1);
+		outw(reg & 0xff, hwif->config_data);
 	}
 
 	/* enable IRQ if not probing */
 	if (drive->present) {
-		reg = hwif->INW(hwif->config_data + 3);
+		reg = inw(hwif->config_data + 3);
 		reg &= 0x13;
 		reg &= ~(1 << hwif->channel);
-		hwif->OUTW(reg, hwif->config_data+3);
+		outw(reg, hwif->config_data + 3);
 	}
 
 	local_irq_restore(flags);
@@ -179,12 +179,10 @@ static void trm290_selectproc (ide_drive
 
 static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
 	BUG_ON(HWGROUP(drive)->handler != NULL);	/* paranoia check */
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 	/* issue cmd to drive */
-	hwif->OUTB(command, IDE_COMMAND_REG);
+	outb(command, IDE_COMMAND_REG);
 }
 
 static int trm290_ide_dma_setup(ide_drive_t *drive)
@@ -210,10 +208,10 @@ static int trm290_ide_dma_setup(ide_driv
 	}
 	/* select DMA xfer */
 	trm290_prepare_drive(drive, 1);
-	hwif->OUTL(hwif->dmatable_dma|rw, hwif->dma_command);
+	outl(hwif->dmatable_dma | rw, hwif->dma_command);
 	drive->waiting_for_dma = 1;
 	/* start DMA */
-	hwif->OUTW((count * 2) - 1, hwif->dma_status);
+	outw((count * 2) - 1, hwif->dma_status);
 	return 0;
 }
 
@@ -229,7 +227,7 @@ static int trm290_ide_dma_end (ide_drive
 	drive->waiting_for_dma = 0;
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);
-	status = hwif->INW(hwif->dma_status);
+	status = inw(hwif->dma_status);
 	return (status != 0x00ff);
 }
 
@@ -238,7 +236,7 @@ static int trm290_ide_dma_test_irq (ide_
 	ide_hwif_t *hwif = HWIF(drive);
 	u16 status = 0;
 
-	status = hwif->INW(hwif->dma_status);
+	status = inw(hwif->dma_status);
 	return (status == 0x00ff);
 }
 
@@ -267,15 +265,15 @@ static void __devinit init_hwif_trm290(i
 
 	local_irq_save(flags);
 	/* put config reg into first byte of hwif->select_data */
-	hwif->OUTB(0x51|(hwif->channel<<3), hwif->config_data+1);
+	outb(0x51 | (hwif->channel << 3), hwif->config_data + 1);
 	/* select PIO as default */
 	hwif->select_data = 0x21;
-	hwif->OUTB(hwif->select_data, hwif->config_data);
+	outb(hwif->select_data, hwif->config_data);
 	/* get IRQ info */
-	reg = hwif->INB(hwif->config_data+3);
+	reg = inb(hwif->config_data + 3);
 	/* mask IRQs for both ports */
 	reg = (reg & 0x10) | 0x03;
-	hwif->OUTB(reg, hwif->config_data+3);
+	outb(reg, hwif->config_data + 3);
 	local_irq_restore(flags);
 
 	if ((reg & 0x10))
@@ -308,16 +306,16 @@ static void __devinit init_hwif_trm290(i
 		static u16 next_offset = 0;
 		u8 old_mask;
 
-		hwif->OUTB(0x54|(hwif->channel<<3), hwif->config_data+1);
-		old = hwif->INW(hwif->config_data);
+		outb(0x54 | (hwif->channel << 3), hwif->config_data + 1);
+		old = inw(hwif->config_data);
 		old &= ~1;
-		old_mask = hwif->INB(old+2);
+		old_mask = inb(old + 2);
 		if (old != compat && old_mask == 0xff) {
 			/* leave lower 10 bits untouched */
 			compat += (next_offset += 0x400);
 			hwif->io_ports[IDE_CONTROL_OFFSET] = compat + 2;
-			hwif->OUTW(compat|1, hwif->config_data);
-			new = hwif->INW(hwif->config_data);
+			outw(compat | 1, hwif->config_data);
+			new = inw(hwif->config_data);
 			printk(KERN_INFO "%s: control basereg workaround: "
 				"old=0x%04x, new=0x%04x\n",
 				hwif->name, old, new & ~1);
Index: a/include/linux/ide.h
===================================================================
--- a.orig/include/linux/ide.h
+++ a/include/linux/ide.h
@@ -734,13 +734,11 @@ typedef struct hwif_s {
 	void (*OUTB)(u8 addr, unsigned long port);
 	void (*OUTBSYNC)(ide_drive_t *drive, u8 addr, unsigned long port);
 	void (*OUTW)(u16 addr, unsigned long port);
-	void (*OUTL)(u32 addr, unsigned long port);
 	void (*OUTSW)(unsigned long port, void *addr, u32 count);
 	void (*OUTSL)(unsigned long port, void *addr, u32 count);
 
 	u8  (*INB)(unsigned long port);
 	u16 (*INW)(unsigned long port);
-	u32 (*INL)(unsigned long port);
 	void (*INSW)(unsigned long port, void *addr, u32 count);
 	void (*INSL)(unsigned long port, void *addr, u32 count);
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSIJTJD>; Tue, 10 Sep 2002 15:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSIJTJC>; Tue, 10 Sep 2002 15:09:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318031AbSIJTI6>;
	Tue, 10 Sep 2002 15:08:58 -0400
Date: Tue, 10 Sep 2002 21:13:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops + Aiee when mounting CDROM via ide-scsi under 2.4.20-pre5-ac4
Message-ID: <20020910191324.GJ21877@suse.de>
References: <200209102015.51536.martin.knoblauch@mscsoftware.com> <20020910190906.GI21877@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020910190906.GI21877@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10 2002, Jens Axboe wrote:
> On Tue, Sep 10 2002, Martin Knoblauch wrote:
> > Hi,
> > 
> >  I am getting a reproducable Oops+Aiee when trying to mount a ATAPI 
> > CDROM via the ide-scsi interface under 2.4.20-pre5-ac4. Works OK 
> > without ide-scsi.
> 
> Ok, the problem is that ide-scsi builds a request which eventually ends
> up going through the ide code dma mapping. ide_build_sglist() does a
> rq_data_dir() on the request, which BUG()'s if the command isn't an fs
> read or write. This actually went undetected before, because the ide
> code did:
> 
> 	if (rq->cmd == READ)
> 		direction is dma from device
> 	else
> 		direction is to device
> 
> and rq->cmd is IDESCSI_PC_RQ in this case. So we always mapped for dma
> to the device, even if that wasn't the case.
> 
> Hmm, maybe just adding a single direction bit to struct request is the
> easy way out for 2.4. Or... I'll cook something up.

ok try this patch, against 2.4.20-pre5-ac4 (well not a clean one, but I
think it should apply).

alan, this should probably go into ac5 provided that Martin tests it as
ok.

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/arm/icside.c linux-2.4.20-pre5-ac4/drivers/ide/arm/icside.c
--- /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/arm/icside.c	2002-09-10 12:56:51.000000000 +0200
+++ linux-2.4.20-pre5-ac4/drivers/ide/arm/icside.c	2002-09-10 21:04:58.000000000 +0200
@@ -264,9 +264,9 @@
 }
 
 static int
-icside_build_dmatable(ide_drive_t *drive, int reading)
+icside_build_dmatable(ide_drive_t *drive, int ddir)
 {
-	return HWIF(drive)->sg_nents = ide_build_sglist(HWIF(drive), HWGROUP(drive)->rq);
+	return HWIF(drive)->sg_nents = ide_build_sglist(HWIF(drive), HWGROUP(drive)->rq, ddir);
 }
 
 /* Teardown mappings after DMA has completed.  */
@@ -556,7 +556,7 @@
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	count = icside_build_dmatable(drive, 1);
+	count = icside_build_dmatable(drive, PCI_DMA_FROMDEVICE);
 	if (!count)
 		return 1;
 	disable_dma(hwif->hw.dma);
@@ -610,7 +610,7 @@
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	count = icside_build_dmatable(drive, 0);
+	count = icside_build_dmatable(drive, PCI_DMA_TODEVICE);
 	if (!count)
 		return 1;
 	disable_dma(hwif->hw.dma);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/ide-dma.c linux-2.4.20-pre5-ac4/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/ide-dma.c	2002-09-10 12:56:51.000000000 +0200
+++ linux-2.4.20-pre5-ac4/drivers/ide/ide-dma.c	2002-09-10 21:03:11.000000000 +0200
@@ -215,7 +214,7 @@
 	return DRIVER(drive)->error(drive, "dma_intr", stat);
 }
 
-static int ide_build_sglist (ide_hwif_t *hwif, struct request *rq)
+static int ide_build_sglist (ide_hwif_t *hwif, struct request *rq, int ddir)
 {
 	struct buffer_head *bh;
 	struct scatterlist *sg = hwif->sg_table;
@@ -223,11 +222,7 @@
 
 	if (hwif->sg_dma_active)
 		BUG();
-		
-	if (rq_data_dir(rq) == READ)
-		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-	else
-		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+
 	bh = rq->bh;
 	do {
 		unsigned char *virt_addr = bh->b_data;
@@ -252,7 +247,8 @@
 	if(nents == 0)
 		BUG();
 		
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+	hwif->sg_dma_direction = ddir;
+	return pci_map_sg(hwif->pci_dev, sg, nents, ddir);
 }
 
 static int ide_raw_build_sglist (ide_hwif_t *hwif, struct request *rq)
@@ -302,7 +298,7 @@
  * Returns 0 if all went okay, returns 1 otherwise.
  * May also be invoked from trm290.c
  */
-int ide_build_dmatable (ide_drive_t *drive, struct request *rq)
+int ide_build_dmatable (ide_drive_t *drive, struct request *rq, int ddir)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned int *table	= hwif->dmatable_cpu;
@@ -314,7 +310,7 @@
 	if (rq->cmd == IDE_DRIVE_TASKFILE)
 		hwif->sg_nents = i = ide_raw_build_sglist(hwif, rq);
 	else
-		hwif->sg_nents = i = ide_build_sglist(hwif, rq);
+		hwif->sg_nents = i = ide_build_sglist(hwif, rq, ddir);
 
 	if (!i)
 		return 0;
@@ -543,7 +539,7 @@
 	u8 dma_stat = 0, lba48	= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	if (!(count = ide_build_dmatable(drive, rq)))
+	if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_FROMDEVICE)))
 		/* try PIO instead of DMA */
 		return 1;
 	/* PRD table */
@@ -595,7 +591,7 @@
 	u8 dma_stat = 0, lba48	= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	if (!(count = ide_build_dmatable(drive, rq)))
+	if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_TODEVICE)))
 		/* try PIO instead of DMA */
 		return 1;
 	/* PRD table */
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/pci/trm290.c linux-2.4.20-pre5-ac4/drivers/ide/pci/trm290.c
--- /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/pci/trm290.c	2002-09-10 12:56:52.000000000 +0200
+++ linux-2.4.20-pre5-ac4/drivers/ide/pci/trm290.c	2002-09-10 21:08:15.000000000 +0200
@@ -191,7 +191,7 @@
 	trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 	return 1;
 #endif
-	if (!(count = ide_build_dmatable(drive, rq))) {
+	if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_TODEVICE))) {
 		/* try PIO instead of DMA */
 		trm290_prepare_drive(drive, 0); /* select PIO xfer */
 		return 1;
@@ -235,7 +235,7 @@
 	task_ioreg_t command	= WIN_NOP;
 	unsigned int count, reading = 2, writing = 0;
 
-	if (!(count = ide_build_dmatable(drive, rq))) {
+	if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_FROMDEVICE))) {
 		/* try PIO instead of DMA */
 		trm290_prepare_drive(drive, 0); /* select PIO xfer */
 		return 1;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/ppc/pmac.c linux-2.4.20-pre5-ac4/drivers/ide/ppc/pmac.c
--- /opt/kernel/linux-2.4.20-pre5-ac4/drivers/ide/ppc/pmac.c	2002-09-10 12:56:52.000000000 +0200
+++ linux-2.4.20-pre5-ac4/drivers/ide/ppc/pmac.c	2002-09-10 21:07:42.000000000 +0200
@@ -932,7 +932,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 static int
-pmac_ide_build_sglist(ide_hwif_t *hwif, struct request *rq)
+pmac_ide_build_sglist(ide_hwif_t *hwif, struct request *rq, int data_dir)
 {
 	pmac_ide_hwif_t *pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	struct buffer_head *bh;
@@ -942,10 +942,6 @@
 	if (hwif->sg_dma_active)
 		BUG();
 		
-	if (rq->cmd == READ)
-		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-	else
-		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
 	bh = rq->bh;
 	do {
 		unsigned char *virt_addr = bh->b_data;
@@ -965,7 +961,8 @@
 		nents++;
 	} while (bh != NULL);
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+	pmif->sg_dma_direction = data_dir;
+	return pci_map_sg(hwif->pci_dev, sg, nents, data_dir);
 }
 
 static int
@@ -1013,6 +1010,7 @@
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	volatile struct dbdma_regs *dma = pmif->dma_regs;
 	struct scatterlist *sg;
+	int data_dir;
 
 	/* DMA table is already aligned */
 	table = (struct dbdma_cmd *) pmif->dma_table_cpu;
@@ -1022,11 +1020,16 @@
 	while (readl(&dma->status) & RUN)
 		udelay(1);
 
+	if (wr)
+		data_dir = PCI_DMA_TODEVICE;
+	else
+		data_dir = PCI_DMA_FROMDEVICE;
+
 	/* Build sglist */
 	if (rq->cmd == IDE_DRIVE_TASKFILE)
 		pmif->sg_nents = i = pmac_ide_raw_build_sglist(hwif, rq);
 	else
-		pmif->sg_nents = i = pmac_ide_build_sglist(hwif, rq);
+		pmif->sg_nents = i = pmac_ide_build_sglist(hwif, rq, data_dir);
 	if (!i)
 		return 0;
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.20-pre5-ac4/include/linux/ide.h linux-2.4.20-pre5-ac4/include/linux/ide.h
--- /opt/kernel/linux-2.4.20-pre5-ac4/include/linux/ide.h	2002-09-10 12:56:54.000000000 +0200
+++ linux-2.4.20-pre5-ac4/include/linux/ide.h	2002-09-10 21:04:00.000000000 +0200
@@ -1732,7 +1732,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 #define BAD_DMA_DRIVE		0
 #define GOOD_DMA_DRIVE		1
-extern int ide_build_dmatable(ide_drive_t *, struct request *);
+extern int ide_build_dmatable(ide_drive_t *, struct request *, int);
 extern void ide_destroy_dmatable(ide_drive_t *);
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);

-- 
Jens Axboe


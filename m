Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTEIIQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTEIIQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:16:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17287 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262359AbTEIIQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:16:03 -0400
Date: Fri, 9 May 2003 10:28:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Sanitize hwif/drive addressing (was Re: [PATCH] 2.5 ide 48-bit usage)
Message-ID: <20030509082837.GG20941@suse.de>
References: <20030508161600.GE20941@suse.de> <Pine.LNX.4.44.0305080924400.2967-100000@home.transmeta.com> <20030508163441.GG20941@suse.de> <1052431594.13567.30.camel@dhcp22.swansea.linux.org.uk> <20030509070623.GV20941@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509070623.GV20941@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09 2003, Jens Axboe wrote:
> On Thu, May 08 2003, Alan Cox wrote:
> > On Iau, 2003-05-08 at 17:34, Jens Axboe wrote:
> > > Might not be a bad idea, drive->address_mode is a heck of a lot more to
> > > the point. I'll do a swipe of this tomorrow, if no one beats me to it.
> > 
> > We don't know if in the future drives will support some random mask of modes.
> > Would
> > 
> > 	drive->lba48
> > 	drive->lba96
> > 	drive->..
> > 
> > be safer ?
> 
> I had the same thought yesterday, that just because a device does lba89
> does not need it supports all of the lower modes. How about just using
> the drive->address_mode as a supported field of modes?
> 
> if (drive->address_mode & IDE_LBA48)
> 	lba48 = 1;

How about something like the attached? Removes ->addressing from both
drive and hwif, and adds:

drive->addr_mode: capability mask of addressing modes the drive supports
hwif->na_addr_mode: negated capability mask

Patch isn't tested, so this is just a RFC. If we agree on the concept, I
can finalize it.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1083  -> 1.1084 
#	drivers/ide/ide-taskfile.c	1.16    -> 1.17   
#	drivers/ide/ppc/pmac.c	1.10    -> 1.11   
#	drivers/ide/pci/trm290.c	1.11    -> 1.12   
#	   drivers/ide/ide.c	1.59    -> 1.60   
#	drivers/ide/pci/alim15x3.c	1.11    -> 1.12   
#	drivers/ide/pci/siimage.c	1.11    -> 1.12   
#	drivers/ide/ide-disk.c	1.40    -> 1.41   
#	drivers/ide/arm/icside.c	1.6     -> 1.7    
#	drivers/ide/legacy/pdc4030.c	1.8     -> 1.9    
#	drivers/ide/ide-dma.c	1.13    -> 1.14   
#	drivers/ide/ide-io.c	1.8     -> 1.9    
#	drivers/ide/pci/pdc202xx_old.c	1.13    -> 1.14   
#	drivers/ide/ide-tcq.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/09	axboe@smithers.home.kernel.dk	1.1084
# Sanitize hwif and drive addressing fields
# --------------------------------------------
#
diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/arm/icside.c	Fri May  9 10:27:36 2003
@@ -657,7 +657,7 @@
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
+	} else if (drive->addr_mode & IDE_ADDR_48BIT) {
 		cmd = WIN_READDMA_EXT;
 	} else {
 		cmd = WIN_READDMA;
@@ -698,7 +698,7 @@
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
+	} else if (drive->addr_mode & IDE_ADDR_48BIT) {
 		cmd = WIN_WRITEDMA_EXT;
 	} else {
 		cmd = WIN_WRITEDMA;
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ide-disk.c	Fri May  9 10:27:36 2003
@@ -358,7 +358,7 @@
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= drive->addr_mode & IDE_ADDR_48BIT;
 	task_ioreg_t command	= WIN_NOP;
 	ata_nsector_t		nsectors;
 
@@ -383,7 +383,7 @@
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
 	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
+		if (lba48) {
 			task_ioreg_t tasklets[10];
 
 			if (blk_rq_tagged(rq)) {
@@ -593,7 +593,7 @@
 		return ide_started;
 	}
 
-	if (drive->addressing == 1)		/* 48-bit LBA */
+	if (drive->addr_mode & IDE_ADDR_48BIT)
 		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
 		return lba_28_rw_disk(drive, rq, (unsigned long) block);
@@ -604,7 +604,7 @@
 
 static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
 {
-	int lba48bit = (drive->addressing == 1) ? 1 : 0;
+	int lba48bit = drive->addr_mode & IDE_ADDR_48BIT;
 
 	if ((cmd == READ) && drive->using_tcq)
 		return lba48bit ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
@@ -801,7 +801,7 @@
 		printk("}");
 		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
 		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			if (drive->addressing == 1) {
+			if (drive->addr_mode & IDE_ADDR_48BIT) {
 				__u64 sectors = 0;
 				u32 low = 0, high = 0;
 				low = ide_read_24(drive);
@@ -1464,22 +1464,34 @@
 }
 #endif
 
-static int probe_lba_addressing (ide_drive_t *drive, int arg)
+static int probe_lba48_addressing (ide_drive_t *drive)
 {
-	drive->addressing =  0;
+	/*
+	 * 28-bit is default capability
+	 */
+	drive->addr_mode = IDE_ADDR_28BIT;
 
-	if (HWIF(drive)->addressing)
+	if (HWIF(drive)->na_addr_mode & IDE_ADDR_48BIT)
 		return 0;
 
 	if (!(drive->id->cfs_enable_2 & 0x0400))
                 return -EIO;
-	drive->addressing = arg;
+
+	drive->addr_mode |= IDE_ADDR_48BIT;
 	return 0;
 }
 
+/*
+ * only check for 48-bit lba capability, we don't support higher than that
+ */
 static int set_lba_addressing (ide_drive_t *drive, int arg)
 {
-	return (probe_lba_addressing(drive, arg));
+	if (!arg) {
+		drive->addr_mode = IDE_ADDR_28BIT;
+		return 0;
+	}
+
+	return probe_lba48_addressing(drive);
 }
 
 static void idedisk_add_settings(ide_drive_t *drive)
@@ -1489,7 +1501,7 @@
 	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->bios_cyl,		NULL);
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"address",		SETTING_RW,					HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,	TYPE_INTA,	0,	2,				1,	1,	&drive->addressing,	set_lba_addressing);
+	ide_add_setting(drive,	"address",		SETTING_RW,					HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,	TYPE_INTA,	0,	2,				1,	1,	&drive->addr_mode,	set_lba_addressing);
 	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
@@ -1564,7 +1576,7 @@
 		}
 	}
 
-	(void) probe_lba_addressing(drive, 1);
+	(void) probe_lba48_addressing(drive);
 
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ide-dma.c	Fri May  9 10:27:36 2003
@@ -653,7 +653,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	unsigned int reading	= 1 << 3;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= drive->addr_mode & IDE_ADDR_48BIT;
 	task_ioreg_t command	= WIN_NOP;
 
 	/* try pio */
@@ -685,7 +685,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	unsigned int reading	= 0;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	u8 lba48		= drive->addr_mode & IDE_ADDR_48BIT;
 	task_ioreg_t command	= WIN_NOP;
 
 	/* try PIO instead of DMA */
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ide-io.c	Fri May  9 10:27:36 2003
@@ -205,7 +205,7 @@
 			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
 			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 
-			if (drive->addressing == 1) {
+			if (drive->addr_mode & IDE_ADDR_48BIT) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
 				args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
 				args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ide-taskfile.c	Fri May  9 10:27:36 2003
@@ -138,7 +138,7 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
+	u8 HIHI			= drive->addr_mode & IDE_ADDR_48BIT;
 
 #ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
 	void debug_taskfile(drive, task);
@@ -151,7 +151,7 @@
 	}
 	SELECT_MASK(drive, 0);
 
-	if (drive->addressing == 1) {
+	if (drive->addr_mode & IDE_ADDR_48BIT) {
 		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
 		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
 		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
@@ -241,7 +241,7 @@
 	args->tfRegister[IDE_STATUS_OFFSET]  = stat;
 	if ((drive->id->command_set_2 & 0x0400) &&
 	    (drive->id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1)) {
+	    (drive->addr_mode & IDE_ADDR_48BIT)) {
 		hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG_HOB);
 		args->hobRegister[IDE_FEATURE_OFFSET_HOB] = hwif->INB(IDE_FEATURE_REG);
 		args->hobRegister[IDE_NSECTOR_OFFSET_HOB] = hwif->INB(IDE_NSECTOR_REG);
@@ -514,7 +514,7 @@
 			drive->bad_wstat, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: no DRQ after issuing WRITE%s\n",
 			drive->name,
-			drive->addressing ? "_EXT" : "");
+			drive->addr_mode & IDE_ADDR_48BIT ? "_EXT" : "");
 		return startstop;
 	}
 	/* For Write_sectors we need to stuff the first sector */
@@ -597,7 +597,8 @@
 			drive->bad_wstat, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: no DRQ after issuing %s\n",
 			drive->name,
-			drive->addressing ? "MULTWRITE_EXT" : "MULTWRITE");
+			drive->addr_mode & IDE_ADDR_48BIT ?
+			"MULTWRITE_EXT" : "MULTWRITE");
 		return startstop;
 	}
 #ifdef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
@@ -1611,13 +1612,13 @@
 	 */
 	if (task->tf_out_flags.all == 0) {
 		task->tf_out_flags.all = IDE_TASKFILE_STD_OUT_FLAGS;
-		if (drive->addressing == 1)
+		if (drive->addr_mode & IDE_ADDR_48BIT)
 			task->tf_out_flags.all |= (IDE_HOB_STD_OUT_FLAGS << 8);
         }
 
 	if (task->tf_in_flags.all == 0) {
 		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing == 1)
+		if (drive->addr_mode & IDE_ADDR_48BIT)
 			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
         }
 
diff -Nru a/drivers/ide/ide-tcq.c b/drivers/ide/ide-tcq.c
--- a/drivers/ide/ide-tcq.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ide-tcq.c	Fri May  9 10:27:36 2003
@@ -666,7 +666,7 @@
 {
 	u8 command = WIN_READDMA_QUEUED;
 
-	if (drive->addressing == 1)
+	if (drive->addr_mode & IDE_ADDR_48BIT)
 		 command = WIN_READDMA_QUEUED_EXT;
 
 	return ide_dma_queued_rw(drive, command);
@@ -676,7 +676,7 @@
 {
 	u8 command = WIN_WRITEDMA_QUEUED;
 
-	if (drive->addressing == 1)
+	if (drive->addr_mode & IDE_ADDR_48BIT)
 		 command = WIN_WRITEDMA_QUEUED_EXT;
 
 	return ide_dma_queued_rw(drive, command);
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ide.c	Fri May  9 10:27:36 2003
@@ -402,7 +402,7 @@
 			if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR || (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
 				if ((drive->id->command_set_2 & 0x0400) &&
 				    (drive->id->cfs_enable_2 & 0x0400) &&
-				    (drive->addressing == 1)) {
+				    (drive->addr_mode & IDE_ADDR_48BIT)) {
 					u64 sectors = 0;
 					u32 high = 0;
 					u32 low = ide_read_24(drive);
@@ -811,7 +811,7 @@
 
 	hwif->mmio			= old_hwif.mmio;
 	hwif->rqsize			= old_hwif.rqsize;
-	hwif->addressing		= old_hwif.addressing;
+	hwif->na_addr_mode		= old_hwif.na_addr_mode;
 #ifndef CONFIG_BLK_DEV_IDECS
 	hwif->irq			= old_hwif.irq;
 #endif /* CONFIG_BLK_DEV_IDECS */
diff -Nru a/drivers/ide/legacy/pdc4030.c b/drivers/ide/legacy/pdc4030.c
--- a/drivers/ide/legacy/pdc4030.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/legacy/pdc4030.c	Fri May  9 10:27:36 2003
@@ -225,7 +225,7 @@
 	hwif2->mate	= hwif;
 	hwif2->channel	= 1;
 	hwif->rqsize	= hwif2->rqsize = 127;
-	hwif->addressing = hwif2->addressing = 1;
+	hwif->na_addr_mode = hwif2->na_addr_mode = IDE_ADDR_48BIT;
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 	/* DC4030 hosted drives need their own identify... */
diff -Nru a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/pci/alim15x3.c	Fri May  9 10:27:36 2003
@@ -745,7 +745,8 @@
 	hwif->speedproc = &ali15x3_tune_chipset;
 
 	/* Don't use LBA48 on ALi devices before rev 0xC5 */
-	hwif->addressing = (m5229_revision <= 0xC4) ? 1 : 0;
+	if (m5229_revision <= 0xC4)
+		hwif->na_addr_mode = IDE_ADDR_48BIT;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/pci/pdc202xx_old.c	Fri May  9 10:27:36 2003
@@ -535,7 +535,7 @@
 
 static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
+	if (drive->address_mode & IDE_ADDR_48BIT) {
 		struct request *rq	= HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	= HWIF(drive);
 //		struct pci_dev *dev	= hwif->pci_dev;
@@ -557,7 +557,7 @@
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
+	if (drive->address_mode & IDE_ADDR_48BIT) {
 		ide_hwif_t *hwif	= HWIF(drive);
 //		unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
 		unsigned long high_16	= hwif->dma_master;
@@ -749,8 +749,10 @@
 	hwif->tuneproc  = &config_chipset_for_pio;
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
-		hwif->addressing = (hwif->channel) ? 0 : 1;
+	if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265) {
+		if (!hwif->channel)
+			hwif->na_addr_mode = IDE_ADDR_48BIT;
+	}
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
 		hwif->busproc   = &pdc202xx_tristate;
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/pci/siimage.c	Fri May  9 10:27:36 2003
@@ -724,7 +724,7 @@
 	}
 
 #ifdef SIIMAGE_BUFFERED_TASKFILE
-        hwif->addressing = 1;
+        hwif->na_addr_mode = IDE_ADDR_48BIT;
 #endif /* SIIMAGE_BUFFERED_TASKFILE */
 	hwif->irq			= hw.irq;
 	hwif->hwif_data			= pci_get_drvdata(hwif->pci_dev);
diff -Nru a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
--- a/drivers/ide/pci/trm290.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/pci/trm290.c	Fri May  9 10:27:36 2003
@@ -309,7 +309,7 @@
 	u8 reg = 0;
 	struct pci_dev *dev = hwif->pci_dev;
 
-	hwif->addressing = 1;
+	hwif->na_addr_mode = IDE_ADDR_48BIT;
 	hwif->chipset = ide_trm290;
 	cfgbase = pci_resource_start(dev, 4);
 	if ((dev->class & 5) && cfgbase) {
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	Fri May  9 10:27:36 2003
+++ b/drivers/ide/ppc/pmac.c	Fri May  9 10:27:36 2003
@@ -1240,7 +1240,7 @@
 //	ide_task_t *args = rq->special;
 	u8 unit = (drive->select.b.unit & 0x01);
 	u8 ata4;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
+	u8 lba48 = drive->address_mode & IDE_ADDR_48BIT;
 	task_ioreg_t command = WIN_NOP;
 
 	if (pmif == NULL)
@@ -1293,7 +1293,7 @@
 //	ide_task_t *args = rq->special;
 	u8 unit = (drive->select.b.unit & 0x01);
 	u8 ata4;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
+	u8 lba48 = drive->address_mode & IDE_ADDR_48BIT;
 	task_ioreg_t command = WIN_NOP;
 
 	if (pmif == NULL)

-- 
Jens Axboe


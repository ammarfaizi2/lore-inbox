Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269440AbUJSVKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269440AbUJSVKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269882AbUJSVAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:00:35 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:63694 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269770AbUJSUr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:47:59 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=FDRT6RS6EJ2aE0EVqDwUgQNFIntzvOONaCJRnkuApszS22BBn6Mr2ZfKIFafPSu1XoGSlW6+6meUjE/wpYazSaGEMDMDhpUHRsFJwnbs9/MrnYfBThxiOZm5ijTkAWnXuzp3QLQ//2o2J2NVR7SKe0L/GUA/riF2ZszLYrbeN6I
Message-ID: <58cb370e041019134718286fd4@mail.gmail.com>
Date: Tue, 19 Oct 2004 22:47:58 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: torvalds@osdl.org
Subject: [BK PATCHES] ide-2.6 update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

DMA cleanups/fixups that have been in -mm for almost a month.

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 arch/cris/arch-v10/drivers/ide.c |  150 ++++++++++-----------------------------
 drivers/ide/arm/icside.c         |   97 +++----------------------
 drivers/ide/ide-cd.c             |   15 +--
 drivers/ide/ide-disk.c           |   22 ++++-
 drivers/ide/ide-dma.c            |  105 +++++----------------------
 drivers/ide/ide-floppy.c         |   12 +--
 drivers/ide/ide-tape.c           |   10 --
 drivers/ide/ide-taskfile.c       |   18 ++--
 drivers/ide/ide.c                |    6 -
 drivers/ide/pci/alim15x3.c       |   21 ++---
 drivers/ide/pci/hpt366.c         |    8 +-
 drivers/ide/pci/ns87415.c        |   18 ----
 drivers/ide/pci/pdc202xx_old.c   |    6 -
 drivers/ide/pci/sgiioc4.c        |   45 ++++-------
 drivers/ide/pci/sl82c105.c       |    8 --
 drivers/ide/pci/trm290.c         |   97 +++++--------------------
 drivers/ide/ppc/pmac.c           |   89 +++--------------------
 drivers/scsi/ide-scsi.c          |   12 +--
 include/linux/ide.h              |   12 +--
 include/linux/scatterlist.h      |   14 +++
 20 files changed, 219 insertions(+), 546 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/19 1.2071)
   [ide] convert ide_hwif_t->ide_dma_begin() to ->dma_start()
   
   Make ->ide_dma_begin() functions void and rename them to ->dma_start().
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/19 1.2070)
   [ide] add ide_hwif_t->dma_exec_cmd()
   
   * split off ->dma_exec_cmd() from ->ide_dma_[read,write] functions
   * choose command to execute by ->dma_exec_cmd() in higher layers
     and remove ->ide_dma_[read,write]
   * in Etrax ide.c driver REQ_DRIVE_TASKFILE requests weren't
     handled properly for drive->addressing == 0
   * in trm290.c read and write commands were interchanged
   * in sgiioc4.c commands weren't sent to disk devices
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/19 1.2069)
   [ide] add ide_hwif_t->dma_setup()
   
   * tag REQ_DRIVE_TASKFILE write requests with REQ_RW
   * split off ->dma_setup() from ->ide_dma_[read,write] functions
   * use ->dma_setup() directly in ATAPI drivers and remove media
     checks from ->ide_dma_[read,write]
   * ->ide_dma_[read,write,begin] cannot fail now
   * in Etrax ide.c setup DMA for ATAPI devices before sending
     command to drive (so setup order is the same as for disks)
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/19 1.2068)
   [ide] add sg_init_one() helper and teach ide about it
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/arch/cris/arch-v10/drivers/ide.c b/arch/cris/arch-v10/drivers/ide.c
--- a/arch/cris/arch-v10/drivers/ide.c	2004-10-19 22:11:26 +02:00
+++ b/arch/cris/arch-v10/drivers/ide.c	2004-10-19 22:11:26 +02:00
@@ -30,6 +30,7 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/arch/svinto.h>
@@ -207,10 +208,8 @@
 #define ATA_PIO0_HOLD    4
 
 static int e100_dma_check (ide_drive_t *drive);
-static int e100_dma_begin (ide_drive_t *drive);
+static void e100_dma_start(ide_drive_t *drive);
 static int e100_dma_end (ide_drive_t *drive);
-static int e100_dma_read (ide_drive_t *drive);
-static int e100_dma_write (ide_drive_t *drive);
 static void e100_ide_input_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_ide_output_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_atapi_input_bytes(ide_drive_t *drive, void *, unsigned int);
@@ -281,6 +280,38 @@
 	}
 }
 
+static int e100_dma_setup(ide_drive_t *drive)
+{
+	struct request *rq = drive->hwif->hwgroup->rq;
+
+	if (rq_data_dir(rq)) {
+		e100_read_command = 0;
+
+		RESET_DMA(ATA_TX_DMA_NBR); /* sometimes the DMA channel get stuck
so we need to do this */
+		WAIT_DMA(ATA_TX_DMA_NBR);
+	} else {
+		e100_read_command = 1;
+
+		RESET_DMA(ATA_RX_DMA_NBR); /* sometimes the DMA channel get stuck
so we need to do this */
+		WAIT_DMA(ATA_RX_DMA_NBR);
+	}
+
+	/* set up the Etrax DMA descriptors */
+	if (e100_ide_build_dmatable(drive))
+		return 1;
+
+	return 0;
+}
+
+static void e100_dma_exec_cmd(ide_drive_t *drive, u8 command)
+{
+	/* set the irq handler which will finish the request when DMA is done */
+	ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
+
+	/* issue cmd to drive */
+	etrax100_ide_outb(command, IDE_COMMAND_REG);
+}
+
 void __init
 init_e100_ide (void)
 {
@@ -302,9 +333,9 @@
                 hwif->atapi_output_bytes = &e100_atapi_output_bytes;
                 hwif->ide_dma_check = &e100_dma_check;
                 hwif->ide_dma_end = &e100_dma_end;
-		hwif->ide_dma_write = &e100_dma_write;
-		hwif->ide_dma_read = &e100_dma_read;
-		hwif->ide_dma_begin = &e100_dma_begin;
+		hwif->dma_setup = &e100_dma_setup;
+		hwif->dma_exec_cmd = &e100_dma_exec_cmd;
+		hwif->dma_start = &e100_dma_start;
 		hwif->OUTB = &etrax100_ide_outb;
 		hwif->OUTW = &etrax100_ide_outw;
 		hwif->OUTBSYNC = &etrax100_ide_outbsync;
@@ -624,12 +655,7 @@
 	ata_tot_size = 0;
 
 	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-		u8 *virt_addr = rq->buffer;
-		int sector_count = rq->nr_sectors;
-		memset(&sg[0], 0, sizeof(*sg));
-		sg[0].page = virt_to_page(virt_addr);
-		sg[0].offset = offset_in_page(virt_addr);
-		sg[0].length =  sector_count  * SECTOR_SIZE;
+		sg_init_one(&sg[0], rq->buffer, rq->nr_sectors * SECTOR_SIZE);
 		hwif->sg_nents = i = 1;
 	}
 	else
@@ -773,10 +799,6 @@
  * sector address using CHS or LBA.  All that remains is to prepare for DMA
  * and then issue the actual read/write DMA/PIO command to the drive.
  *
- * For ATAPI devices, we just prepare for DMA and return. The caller should
- * then issue the packet command to the drive and call us again with
- * ide_dma_begin afterwards.
- *
  * Returns 0 if all went well.
  * Returns 1 if DMA read/write could not be started, in which case
  * the caller should revert to PIO for the current request.
@@ -793,35 +815,9 @@
 	return 0;
 }
 
-static int e100_start_dma(ide_drive_t *drive, int atapi, int reading)
+static void e100_dma_start(ide_drive_t *drive)
 {
-	if(reading) {
-
-		RESET_DMA(ATA_RX_DMA_NBR); /* sometimes the DMA channel get stuck
so we need to do this */
-		WAIT_DMA(ATA_RX_DMA_NBR);
-
-		/* set up the Etrax DMA descriptors */
-
-		if(e100_ide_build_dmatable (drive))
-			return 1;
-
-		if(!atapi) {
-			/* set the irq handler which will finish the request when DMA is done */
-
-			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-
-			/* issue cmd to drive */
-                        if ((HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE) &&
-			    (drive->addressing == 1)) {
-				ide_task_t *args = HWGROUP(drive)->rq->special;
-				etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
-			} else if (drive->addressing) {
-				etrax100_ide_outb(WIN_READDMA_EXT, IDE_COMMAND_REG);
-			} else {
-				etrax100_ide_outb(WIN_READDMA, IDE_COMMAND_REG);
-			}
-		}
-
+	if (e100_read_command) {
 		/* begin DMA */
 
 		/* need to do this before RX DMA due to a chip bug
@@ -854,32 +850,6 @@
 
 	} else {
 		/* writing */
-
-		RESET_DMA(ATA_TX_DMA_NBR); /* sometimes the DMA channel get stuck
so we need to do this */
-		WAIT_DMA(ATA_TX_DMA_NBR);
-
-		/* set up the Etrax DMA descriptors */
-
-		if(e100_ide_build_dmatable (drive))
-			return 1;
-
-		if(!atapi) {
-			/* set the irq handler which will finish the request when DMA is done */
-
-			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-
-			/* issue cmd to drive */
-			if ((HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE) &&
-			    (drive->addressing == 1)) {
-				ide_task_t *args = HWGROUP(drive)->rq->special;
-				etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
-			} else if (drive->addressing) {
-				etrax100_ide_outb(WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-			} else {
-				etrax100_ide_outb(WIN_WRITEDMA, IDE_COMMAND_REG);
-			}
-		}
-
 		/* begin DMA */
 
 		*R_DMA_CH2_FIRST = virt_to_phys(ata_descrs);
@@ -902,44 +872,4 @@
 
 		D(printk("dma write of %d bytes.\n", ata_tot_size));
 	}
-	return 0;
-}
-
-static int e100_dma_write(ide_drive_t *drive)
-{
-	e100_read_command = 0;
-	/* ATAPI-devices (not disks) first call ide_dma_read/write to set
the direction
-	 * then they call ide_dma_begin after they have issued the
appropriate drive command
-	 * themselves to actually start the chipset DMA. so we just return
here if we're
-	 * not a diskdrive.
-	 */
-	if (drive->media != ide_disk)
-                return 0;
-	return e100_start_dma(drive, 0, 0);
-}
-
-static int e100_dma_read(ide_drive_t *drive)
-{
-	e100_read_command = 1;
-	/* ATAPI-devices (not disks) first call ide_dma_read/write to set
the direction
-	 * then they call ide_dma_begin after they have issued the
appropriate drive command
-	 * themselves to actually start the chipset DMA. so we just return
here if we're
-	 * not a diskdrive.
-	 */
-	if (drive->media != ide_disk)
-                return 0;
-	return e100_start_dma(drive, 0, 1);
-}
-
-static int e100_dma_begin(ide_drive_t *drive)
-{
-	/* begin DMA, used by ATAPI devices which want to issue the
-	 * appropriate IDE command themselves.
-	 *
-	 * they have already called ide_dma_read/write to set the
-	 * static reading flag, now they call ide_dma_begin to do
-	 * the real stuff. we tell our code below not to issue
-	 * any IDE commands itself and jump into it.
-	 */
-	 return e100_start_dma(drive, 1, e100_read_command);
 }
diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/arm/icside.c	2004-10-19 22:11:26 +02:00
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/scatterlist.h>
 
 #include <asm/dma.h>
 #include <asm/ecard.h>
@@ -223,10 +224,7 @@
 		else
 			hwif->sg_dma_direction = DMA_FROM_DEVICE;
 
-		memset(sg, 0, sizeof(*sg));
-		sg->page   = virt_to_page(rq->buffer);
-		sg->offset = offset_in_page(rq->buffer);
-		sg->length = rq->nr_sectors * SECTOR_SIZE;
+		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
 		nents = 1;
 	} else {
 		nents = blk_rq_map_sg(drive->queue, rq, sg);
@@ -402,14 +400,13 @@
 	return get_dma_residue(hwif->hw.dma) != 0;
 }
 
-static int icside_dma_begin(ide_drive_t *drive)
+static void icside_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 
 	/* We can not enable DMA on both channels simultaneously. */
 	BUG_ON(dma_channel_active(hwif->hw.dma));
 	enable_dma(hwif->hw.dma);
-	return 0;
 }
 
 /*
@@ -441,11 +438,16 @@
 	return DRIVER(drive)->error(drive, __FUNCTION__, stat);
 }
 
-static int
-icside_dma_common(ide_drive_t *drive, struct request *rq,
-		  unsigned int dma_mode)
+static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	struct request *rq = hwif->hwgroup->rq;
+	unsigned int dma_mode;
+
+	if (rq_data_dir(rq))
+		dma_mode = DMA_MODE_WRITE;
+	else
+		dma_mode = DMA_MODE_READ;
 
 	/*
 	 * We can not enable DMA on both channels.
@@ -481,79 +483,10 @@
 	return 0;
 }
 
-static int icside_dma_read(ide_drive_t *drive)
+static void icside_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	struct request *rq = HWGROUP(drive)->rq;
-	task_ioreg_t cmd;
-
-	if (icside_dma_common(drive, rq, DMA_MODE_READ))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	BUG_ON(HWGROUP(drive)->handler != NULL);
-
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
-		cmd = WIN_READDMA_EXT;
-	} else {
-		cmd = WIN_READDMA;
-	}
-#endif
 	/* issue cmd to drive */
 	ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
-
-	return icside_dma_begin(drive);
-}
-
-static int icside_dma_write(ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	task_ioreg_t cmd;
-
-	if (icside_dma_common(drive, rq, DMA_MODE_WRITE))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	BUG_ON(HWGROUP(drive)->handler != NULL);
-
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		cmd = args->tfRegister[IDE_COMMAND_OFFSET];
-	} else if (drive->addressing == 1) {
-		cmd = WIN_WRITEDMA_EXT;
-	} else {
-		cmd = WIN_WRITEDMA;
-	}
-#endif
-
-	/* issue cmd to drive */
-	ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
-
-	return icside_dma_begin(drive);
 }
 
 static int icside_dma_test_irq(ide_drive_t *drive)
@@ -623,9 +556,9 @@
 	hwif->ide_dma_off_quietly = icside_dma_off_quietly;
 	hwif->ide_dma_host_on	= icside_dma_host_on;
 	hwif->ide_dma_on	= icside_dma_on;
-	hwif->ide_dma_read	= icside_dma_read;
-	hwif->ide_dma_write	= icside_dma_write;
-	hwif->ide_dma_begin	= icside_dma_begin;
+	hwif->dma_setup		= icside_dma_setup;
+	hwif->dma_exec_cmd	= icside_dma_exec_cmd;
+	hwif->dma_start		= icside_dma_start;
 	hwif->ide_dma_end	= icside_dma_end;
 	hwif->ide_dma_test_irq	= icside_dma_test_irq;
 	hwif->ide_dma_verbose	= icside_dma_verbose;
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/ide-cd.c	2004-10-19 22:11:26 +02:00
@@ -865,20 +865,14 @@
 {
 	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
+	ide_hwif_t *hwif = drive->hwif;
 
 	/* Wait for the controller to be idle. */
 	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
 		return startstop;
 
-	if (info->dma) {
-		if (info->cmd == READ) {
-			info->dma = !HWIF(drive)->ide_dma_read(drive);
-		} else if (info->cmd == WRITE) {
-			info->dma = !HWIF(drive)->ide_dma_write(drive);
-		} else {
-			printk("ide-cd: DMA set, but not allowed\n");
-		}
-	}
+	if (info->dma)
+		info->dma = !hwif->dma_setup(drive);
 
 	/* Set up the controller registers. */
 	/* FIXME: for Virtual DMA we must check harder */
@@ -916,6 +910,7 @@
 					  struct request *rq,
 					  ide_handler_t *handler)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	int cmd_len;
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
@@ -947,7 +942,7 @@
 
 	/* Start the DMA if need be */
 	if (info->dma)
-		(void) HWIF(drive)->ide_dma_begin(drive);
+		hwif->dma_start(drive);
 
 	return ide_started;
 }
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/ide-disk.c	2004-10-19 22:11:26 +02:00
@@ -419,10 +419,25 @@
 		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
 	}
 
-	if (rq_data_dir(rq) == READ) {
-		if (dma && !hwif->ide_dma_read(drive))
+	if (dma) {
+		if (!hwif->dma_setup(drive)) {
+			if (rq_data_dir(rq)) {
+				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+				if (drive->vdma)
+					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
+			} else {
+				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
+				if (drive->vdma)
+					command = lba48 ? WIN_READ_EXT: WIN_READ;
+			}
+			hwif->dma_exec_cmd(drive, command);
+			hwif->dma_start(drive);
 			return ide_started;
+		}
+		/* fallback to PIO */
+	}
 
+	if (rq_data_dir(rq) == READ) {
 		command = ((drive->mult_count) ?
 			   ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
 			   ((lba48) ? WIN_READ_EXT : WIN_READ));
@@ -430,9 +445,6 @@
 		return ide_started;
 	} else {
 		ide_startstop_t startstop;
-
-		if (dma && !hwif->ide_dma_write(drive))
-			return ide_started;
 
 		command = ((drive->mult_count) ?
 			   ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/ide-dma.c	2004-10-19 22:11:26 +02:00
@@ -85,6 +85,7 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 #include <linux/delay.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -253,18 +254,12 @@
 #else
 	while (sector_count > 128) {
 #endif
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = offset_in_page(virt_addr);
-		sg[nents].length = 128  * SECTOR_SIZE;
+		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
-	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = offset_in_page(virt_addr);
-	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
@@ -590,10 +585,8 @@
 EXPORT_SYMBOL(__ide_dma_check);
 
 /**
- *	ide_start_dma	-	begin a DMA phase
- *	@hwif: interface
+ *	ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
- *	@reading: set if reading, clear if writing
  *
  *	Build an IDE DMA PRD (IDE speak for scatter gather table)
  *	and then set up the DMA transfer registers for a device
@@ -603,12 +596,19 @@
  *	Returns 0 on success. If a PIO fallback is required then 1
  *	is returned. 
  */
- 
-int ide_start_dma(ide_hwif_t *hwif, ide_drive_t *drive, int reading)
+
+int ide_dma_setup(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int reading;
 	u8 dma_stat;
 
+	if (rq_data_dir(rq))
+		reading = 0;
+	else
+		reading = 1 << 3;
+
 	/* fall back to pio! */
 	if (!ide_build_dmatable(drive, rq))
 		return 1;
@@ -628,73 +628,15 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(ide_start_dma);
-
-int __ide_dma_read (ide_drive_t *drive /*, struct request *rq */)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	unsigned int reading	= 1 << 3;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
-
-	/* try pio */
-	if (ide_start_dma(hwif, drive, reading))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
-	
-	if (drive->vdma)
-		command = (lba48) ? WIN_READ_EXT: WIN_READ;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
-	/* issue cmd to drive */
-	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD,
dma_timer_expiry);
-	return hwif->ide_dma_begin(drive);
-}
-
-EXPORT_SYMBOL(__ide_dma_read);
+EXPORT_SYMBOL_GPL(ide_dma_setup);
 
-int __ide_dma_write (ide_drive_t *drive /*, struct request *rq */)
+static void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	unsigned int reading	= 0;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
-
-	/* try PIO instead of DMA */
-	if (ide_start_dma(hwif, drive, reading))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-	if (drive->vdma)
-		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD,
dma_timer_expiry);
-
-	return hwif->ide_dma_begin(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_write);
-
-int __ide_dma_begin (ide_drive_t *drive)
+void ide_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_cmd		= hwif->INB(hwif->dma_command);
@@ -708,10 +650,9 @@
 	hwif->OUTB(dma_cmd|1, hwif->dma_command);
 	hwif->dma = 1;
 	wmb();
-	return 0;
 }
 
-EXPORT_SYMBOL(__ide_dma_begin);
+EXPORT_SYMBOL_GPL(ide_dma_start);
 
 /* returns 1 on error, 0 otherwise */
 int __ide_dma_end (ide_drive_t *drive)
@@ -1009,12 +950,12 @@
 		hwif->ide_dma_host_on = &__ide_dma_host_on;
 	if (!hwif->ide_dma_check)
 		hwif->ide_dma_check = &__ide_dma_check;
-	if (!hwif->ide_dma_read)
-		hwif->ide_dma_read = &__ide_dma_read;
-	if (!hwif->ide_dma_write)
-		hwif->ide_dma_write = &__ide_dma_write;
-	if (!hwif->ide_dma_begin)
-		hwif->ide_dma_begin = &__ide_dma_begin;
+	if (!hwif->dma_setup)
+		hwif->dma_setup = &ide_dma_setup;
+	if (!hwif->dma_exec_cmd)
+		hwif->dma_exec_cmd = &ide_dma_exec_cmd;
+	if (!hwif->dma_start)
+		hwif->dma_start = &ide_dma_start;
 	if (!hwif->ide_dma_end)
 		hwif->ide_dma_end = &__ide_dma_end;
 	if (!hwif->ide_dma_test_irq)
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/ide-floppy.c	2004-10-19 22:11:26 +02:00
@@ -995,6 +995,7 @@
 static ide_startstop_t idefloppy_issue_pc (ide_drive_t *drive,
idefloppy_pc_t *pc)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
+	ide_hwif_t *hwif = drive->hwif;
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
@@ -1049,13 +1050,8 @@
 	}
 	feature.all = 0;
 
-	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
-		if (test_bit(PC_WRITING, &pc->flags)) {
-			feature.b.dma = !HWIF(drive)->ide_dma_write(drive);
-		} else {
-			feature.b.dma = !HWIF(drive)->ide_dma_read(drive);
-		}
-	}
+	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+		feature.b.dma = !hwif->dma_setup(drive);
 
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
@@ -1067,7 +1063,7 @@
 
 	if (feature.b.dma) {	/* Begin DMA, if necessary */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->ide_dma_begin(drive));
+		hwif->dma_start(drive);
 	}
 
 	/* Can we transfer the packet when we get the interrupt or wait? */
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/ide-tape.c	2004-10-19 22:11:26 +02:00
@@ -2067,7 +2067,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	/* Begin DMA, if necessary */
 	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags))
-		(void) (HWIF(drive)->ide_dma_begin(drive));
+		hwif->dma_start(drive);
 #endif
 	/* Send the actual packet */
 	HWIF(drive)->atapi_output_bytes(drive, pc->c, 12);
@@ -2135,12 +2135,8 @@
 				"reverting to PIO\n");
 		(void)__ide_dma_off(drive);
 	}
-	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
-		if (test_bit(PC_WRITING, &pc->flags))
-			dma_ok = !HWIF(drive)->ide_dma_write(drive);
-		else
-			dma_ok = !HWIF(drive)->ide_dma_read(drive);
-	}
+	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+		dma_ok = !hwif->dma_setup(drive);
 
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-10-19 22:11:25 +02:00
+++ b/drivers/ide/ide-taskfile.c	2004-10-19 22:11:25 +02:00
@@ -150,15 +150,15 @@
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
-			if (!hwif->ide_dma_write(drive))
-				return ide_started;
-			break;
 		case WIN_READDMA_ONCE:
 		case WIN_READDMA:
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
-			if (!hwif->ide_dma_read(drive))
+			if (!hwif->dma_setup(drive)) {
+				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->dma_start(drive);
 				return ide_started;
+			}
 			break;
 		default:
 			if (task->handler == NULL)
@@ -517,6 +517,9 @@
 
 		rq.hard_nr_sectors = rq.nr_sectors;
 		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
+
+		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+			rq.flags |= REQ_RW;
 	}
 
 	rq.special = args;
@@ -896,12 +899,11 @@
 
    	        case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
-			hwif->ide_dma_write(drive);
-			break;
-
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
-			hwif->ide_dma_read(drive);
+			hwif->dma_setup(drive);
+			hwif->dma_exec_cmd(drive, taskfile->command);
+			hwif->dma_start(drive);
 			break;
 
 	        default:
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/ide.c	2004-10-19 22:11:26 +02:00
@@ -685,9 +685,9 @@
 	hwif->atapi_input_bytes		= tmp_hwif->atapi_input_bytes;
 	hwif->atapi_output_bytes	= tmp_hwif->atapi_output_bytes;
 
-	hwif->ide_dma_read		= tmp_hwif->ide_dma_read;
-	hwif->ide_dma_write		= tmp_hwif->ide_dma_write;
-	hwif->ide_dma_begin		= tmp_hwif->ide_dma_begin;
+	hwif->dma_setup			= tmp_hwif->dma_setup;
+	hwif->dma_exec_cmd		= tmp_hwif->dma_exec_cmd;
+	hwif->dma_start			= tmp_hwif->dma_start;
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
 	hwif->ide_dma_check		= tmp_hwif->ide_dma_check;
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
diff -Nru a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/pci/alim15x3.c	2004-10-19 22:11:26 +02:00
@@ -558,18 +558,19 @@
 }
 
 /**
- *	ali15x3_dma_write	-	do a DMA IDE write
- *	@drive:	drive to issue write for
+ *	ali15x3_dma_setup	-	begin a DMA phase
+ *	@drive:	target device
  *
- *	Returns 1 if the DMA write cannot be performed, zero on 
- *	success.
+ *	Returns 1 if the DMA cannot be performed, zero on success.
  */
- 
-static int ali15x3_dma_write (ide_drive_t *drive)
+
+static int ali15x3_dma_setup(ide_drive_t *drive)
 {
-	if ((m5229_revision < 0xC2) && (drive->media != ide_disk))
-		return 1;	/* try PIO instead of DMA */
-	return __ide_dma_write(drive);
+	if (m5229_revision < 0xC2 && drive->media != ide_disk) {
+		if (rq_data_dir(drive->hwif->hwgroup->rq))
+			return 1;	/* try PIO instead of DMA */
+	}
+	return ide_dma_setup(drive);
 }
 
 /**
@@ -773,7 +774,7 @@
                  * M1543C or newer for DMAing
                  */
                 hwif->ide_dma_check = &ali15x3_config_drive_for_dma;
-                hwif->ide_dma_write = &ali15x3_dma_write;
+		hwif->dma_setup = &ali15x3_dma_setup;
 		if (!noautodma)
 			hwif->autodma = 1;
 		if (!(hwif->udma_four))
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/pci/hpt366.c	2004-10-19 22:11:26 +02:00
@@ -577,7 +577,7 @@
 	/* how about we flush and reset, mmmkay? */
 	pci_write_config_byte(dev, 0x51, 0x1F);
 	/* fall through to a reset */
-	case ide_dma_begin:
+	case dma_start:
 	case ide_dma_end:
 	/* reset the chips state over and over.. */
 	pci_write_config_byte(dev, 0x51, 0x13);
@@ -592,12 +592,12 @@
 	udelay(10);
 }
 
-static int hpt370_ide_dma_begin (ide_drive_t *drive)
+static void hpt370_ide_dma_start(ide_drive_t *drive)
 {
 #ifdef HPT_RESET_STATE_ENGINE
 	hpt370_clear_engine(drive);
 #endif
-	return __ide_dma_begin(drive);
+	ide_dma_start(drive);
 }
 
 static int hpt370_ide_dma_end (ide_drive_t *drive)
@@ -1230,7 +1230,7 @@
 		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
 	} else if (hpt_minimum_revision(dev,3)) {
-		hwif->ide_dma_begin = &hpt370_ide_dma_begin;
+		hwif->dma_start = &hpt370_ide_dma_start;
 		hwif->ide_dma_end = &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout = &hpt370_ide_dma_timeout;
 		hwif->ide_dma_lostirq = &hpt370_ide_dma_lostirq;
diff -Nru a/drivers/ide/pci/ns87415.c b/drivers/ide/pci/ns87415.c
--- a/drivers/ide/pci/ns87415.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/pci/ns87415.c	2004-10-19 22:11:26 +02:00
@@ -101,22 +101,11 @@
 	return (dma_stat & 7) != 4;
 }
 
-static int ns87415_ide_dma_read (ide_drive_t *drive)
+static int ns87415_ide_dma_setup(ide_drive_t *drive)
 {
 	/* select DMA xfer */
 	ns87415_prepare_drive(drive, 1);
-	if (!(__ide_dma_read(drive)))
-		return 0;
-	/* DMA failed: select PIO xfer */
-	ns87415_prepare_drive(drive, 0);
-	return 1;
-}
-
-static int ns87415_ide_dma_write (ide_drive_t *drive)
-{
-	/* select DMA xfer */
-	ns87415_prepare_drive(drive, 1);
-	if (!(__ide_dma_write(drive)))
+	if (!ide_dma_setup(drive))
 		return 0;
 	/* DMA failed: select PIO xfer */
 	ns87415_prepare_drive(drive, 0);
@@ -204,8 +193,7 @@
 		return;
 
 	hwif->OUTB(0x60, hwif->dma_status);
-	hwif->ide_dma_read = &ns87415_ide_dma_read;
-	hwif->ide_dma_write = &ns87415_ide_dma_write;
+	hwif->dma_setup = &ns87415_ide_dma_setup;
 	hwif->ide_dma_check = &ns87415_ide_dma_check;
 	hwif->ide_dma_end = &ns87415_ide_dma_end;
 
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/pci/pdc202xx_old.c	2004-10-19 22:11:26 +02:00
@@ -494,7 +494,7 @@
 	return ((int) check_in_drive_lists(drive, pdc_quirk_drives));
 }
 
-static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
+static void pdc202xx_old_ide_dma_start(ide_drive_t *drive)
 {
 	if (drive->current_speed > XFER_UDMA_2)
 		pdc_old_enable_66MHz_clock(drive->hwif);
@@ -515,7 +515,7 @@
 					word_count | 0x06000000;
 		hwif->OUTL(word_count, atapi_reg);
 	}
-	return __ide_dma_begin(drive);
+	ide_dma_start(drive);
 }
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
@@ -736,7 +736,7 @@
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
 		if (!(hwif->udma_four))
 			hwif->udma_four = (pdc202xx_old_cable_detect(hwif)) ? 0 : 1;
-		hwif->ide_dma_begin = &pdc202xx_old_ide_dma_begin;
+		hwif->dma_start = &pdc202xx_old_ide_dma_start;
 		hwif->ide_dma_end = &pdc202xx_old_ide_dma_end;
 	} 
 	hwif->ide_dma_test_irq = &pdc202xx_old_ide_dma_test_irq;
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/pci/sgiioc4.c	2004-10-19 22:11:26 +02:00
@@ -192,16 +192,13 @@
 	return intr_reg & 3;
 }
 
-static int
-sgiioc4_ide_dma_begin(ide_drive_t * drive)
+static void sgiioc4_ide_dma_start(ide_drive_t * drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned int reg = hwif->INL(hwif->dma_base + IOC4_DMA_CTRL * 4);
 	unsigned int temp_reg = reg | IOC4_S_DMA_START;
 
 	hwif->OUTL(temp_reg, hwif->dma_base + IOC4_DMA_CTRL * 4);
-
-	return 0;
 }
 
 static u32
@@ -574,35 +571,30 @@
 	return 0;		/* revert to PIO for this request */
 }
 
-static int
-sgiioc4_ide_dma_read(ide_drive_t * drive)
+static int sgiioc4_ide_dma_setup(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	unsigned int count = 0;
+	int ddir;
 
-	if (!(count = sgiioc4_build_dma_table(drive, rq, PCI_DMA_FROMDEVICE))) {
-		/* try PIO instead of DMA */
-		return 1;
-	}
-	/* Writes FROM the IOC4 TO Main Memory */
-	sgiioc4_configure_for_dma(IOC4_DMA_WRITE, drive);
-
-	return 0;
-}
-
-static int
-sgiioc4_ide_dma_write(ide_drive_t * drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	unsigned int count = 0;
+	if (rq_data_dir(rq))
+		ddir = PCI_DMA_TODEVICE;
+	else
+		ddir = PCI_DMA_FROMDEVICE;
 
-	if (!(count = sgiioc4_build_dma_table(drive, rq, PCI_DMA_TODEVICE))) {
+	if (!(count = sgiioc4_build_dma_table(drive, rq, ddir))) {
 		/* try PIO instead of DMA */
 		return 1;
 	}
 
-	sgiioc4_configure_for_dma(IOC4_DMA_READ, drive);
-	/* Writes TO the IOC4 FROM Main Memory */
+	if (rq_data_dir(rq))
+		/* Writes TO the IOC4 FROM Main Memory */
+		ddir = IOC4_DMA_READ;
+	else
+		/* Writes FROM the IOC4 TO Main Memory */
+		ddir = IOC4_DMA_WRITE;
+
+	sgiioc4_configure_for_dma(ddir, drive);
 
 	return 0;
 }
@@ -629,9 +621,8 @@
 	hwif->quirkproc = NULL;
 	hwif->busproc = NULL;
 
-	hwif->ide_dma_read = &sgiioc4_ide_dma_read;
-	hwif->ide_dma_write = &sgiioc4_ide_dma_write;
-	hwif->ide_dma_begin = &sgiioc4_ide_dma_begin;
+	hwif->dma_setup = &sgiioc4_ide_dma_setup;
+	hwif->dma_start = &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
 	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
diff -Nru a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
--- a/drivers/ide/pci/sl82c105.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/ide/pci/sl82c105.c	2004-10-19 22:11:26 +02:00
@@ -236,15 +236,13 @@
  * The generic IDE core will have disabled the BMEN bit before this
  * function is called.
  */
-static int sl82c105_ide_dma_begin(ide_drive_t *drive)
+static void sl82c105_ide_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
 
-//	DBG(("sl82c105_ide_dma_begin(drive:%s)\n", drive->name));
-
 	sl82c105_reset_host(dev);
-	return __ide_dma_begin(drive);
+	ide_dma_start(drive);
 }
 
 static int sl82c105_ide_dma_timeout(ide_drive_t *drive)
@@ -469,7 +467,7 @@
 	hwif->ide_dma_on = &sl82c105_ide_dma_on;
 	hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
 	hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
-	hwif->ide_dma_begin = &sl82c105_ide_dma_begin;
+	hwif->dma_start = &sl82c105_ide_dma_start;
 	hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
 
 	if (!noautodma)
diff -Nru a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
--- a/drivers/ide/pci/trm290.c	2004-10-19 22:11:25 +02:00
+++ b/drivers/ide/pci/trm290.c	2004-10-19 22:11:25 +02:00
@@ -179,64 +179,32 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int trm290_ide_dma_write (ide_drive_t *drive /*, struct request *rq */)
+static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-//	ide_task_t *args	= rq->special;
-	task_ioreg_t command	= WIN_NOP;
-	unsigned int count, reading = 2, writing = 0;
 
-	reading = 0;
-	writing = 1;
-#ifdef TRM290_NO_DMA_WRITES
-	/* always use PIO for writes */
-	trm290_prepare_drive(drive, 0);	/* select PIO xfer */
-	return 1;
-#endif
-	if (!(count = ide_build_dmatable(drive, rq))) {
-		/* try PIO instead of DMA */
-		trm290_prepare_drive(drive, 0); /* select PIO xfer */
-		return 1;
-	}
-	/* select DMA xfer */
-	trm290_prepare_drive(drive, 1);
-	hwif->OUTL(hwif->dmatable_dma|reading|writing, hwif->dma_command);
-	drive->waiting_for_dma = 1;
-	/* start DMA */
-	hwif->OUTW((count * 2) - 1, hwif->dma_status);
-	if (drive->media != ide_disk)
-		return 0;
 	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
 		BUG();
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	command = /* (lba48) ? WIN_READDMA_EXT : */ WIN_READDMA;
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#endif
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
-	return hwif->ide_dma_begin(drive);
 }
 
-static int trm290_ide_dma_read (ide_drive_t *drive  /*, struct request *rq */)
+static int trm290_ide_dma_setup(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-//	ide_task_t *args	= rq->special;
-	task_ioreg_t command	= WIN_NOP;
-	unsigned int count, reading = 2, writing = 0;
+	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->hwgroup->rq;
+	unsigned int count, rw;
+
+	if (rq_data_dir(rq)) {
+#ifdef TRM290_NO_DMA_WRITES
+		/* always use PIO for writes */
+		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
+		return 1;
+#endif
+		rw = 1;
+	} else
+		rw = 2;
 
 	if (!(count = ide_build_dmatable(drive, rq))) {
 		/* try PIO instead of DMA */
@@ -245,38 +213,15 @@
 	}
 	/* select DMA xfer */
 	trm290_prepare_drive(drive, 1);
-	hwif->OUTL(hwif->dmatable_dma|reading|writing, hwif->dma_command);
+	hwif->OUTL(hwif->dmatable_dma|rw, hwif->dma_command);
 	drive->waiting_for_dma = 1;
 	/* start DMA */
 	hwif->OUTW((count * 2) - 1, hwif->dma_status);
-	if (drive->media != ide_disk)
-		return 0;
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
-	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-	/*
-	 * FIX ME to use only ACB ide_task_t args Struct
-	 */
-#if 0
-	{
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#else
-	command = /* (lba48) ? WIN_WRITEDMA_EXT : */ WIN_WRITEDMA;
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-#endif
-	/* issue cmd to drive */
-	hwif->OUTB(command, IDE_COMMAND_REG);
-	return hwif->ide_dma_begin(drive);
+	return 0;
 }
 
-static int trm290_ide_dma_begin (ide_drive_t *drive)
+static void trm290_ide_dma_start(ide_drive_t *drive)
 {
-	return 0;
 }
 
 static int trm290_ide_dma_end (ide_drive_t *drive)
@@ -347,9 +292,9 @@
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ?
0x0080 : 0x0000), 3);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	hwif->ide_dma_write = &trm290_ide_dma_write;
-	hwif->ide_dma_read = &trm290_ide_dma_read;
-	hwif->ide_dma_begin = &trm290_ide_dma_begin;
+	hwif->dma_setup = &trm290_ide_dma_setup;
+	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
+	hwif->dma_start = &trm290_ide_dma_start;
 	hwif->ide_dma_end = &trm290_ide_dma_end;
 	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2004-10-19 22:11:25 +02:00
+++ b/drivers/ide/ppc/pmac.c	2004-10-19 22:11:25 +02:00
@@ -34,6 +34,7 @@
 #include <linux/pci.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/scatterlist.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -361,7 +362,6 @@
 static void pmac_ide_tuneproc(ide_drive_t *drive, u8 pio);
 static void pmac_ide_selectproc(ide_drive_t *drive);
 static void pmac_ide_kauai_selectproc(ide_drive_t *drive);
-static int pmac_ide_dma_begin (ide_drive_t *drive);
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
@@ -1604,18 +1604,12 @@
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	
 	if (sector_count > 128) {
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = offset_in_page(virt_addr);
-		sg[nents].length = 128  * SECTOR_SIZE;
+		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
-	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = offset_in_page(virt_addr);
-	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
    
 	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
@@ -1885,7 +1879,7 @@
  * a read on KeyLargo ATA/66 and mark us as waiting for DMA completion
  */
 static int __pmac
-pmac_ide_dma_start(ide_drive_t *drive, int reading)
+pmac_ide_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
@@ -1902,7 +1896,7 @@
 
 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
-		writel(pmif->timings[unit] + (reading ? 0x00800000UL : 0),
+		writel(pmif->timings[unit] + (!rq_data_dir(rq) ? 0x00800000UL : 0),
 			PMAC_IDE_REG(IDE_TIMING_CONFIG));
 		(void)readl(PMAC_IDE_REG(IDE_TIMING_CONFIG));
 	}
@@ -1912,87 +1906,28 @@
 	return 0;
 }
 
-/*
- * Start a DMA READ command
- */
-static int __pmac
-pmac_ide_dma_read(ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command = WIN_NOP;
-
-	if (pmac_ide_dma_start(drive, 1))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
-	
-	if (drive->vdma)
-		command = (lba48) ? WIN_READ_EXT: WIN_READ;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
-	/* issue cmd to drive */
-	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
-
-	return pmac_ide_dma_begin(drive);
-}
-
-/*
- * Start a DMA WRITE command
- */
-static int __pmac
-pmac_ide_dma_write (ide_drive_t *drive)
+static void __pmac
+pmac_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
-	struct request *rq = HWGROUP(drive)->rq;
-	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command = WIN_NOP;
-
-	if (pmac_ide_dma_start(drive, 0))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-	if (drive->vdma)
-		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
-		
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		ide_task_t *args = rq->special;
-		command = args->tfRegister[IDE_COMMAND_OFFSET];
-	}
-
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
-
-	return pmac_ide_dma_begin(drive);
 }
 
 /*
  * Kick the DMA controller into life after the DMA command has been issued
  * to the drive.
  */
-static int __pmac
-pmac_ide_dma_begin (ide_drive_t *drive)
+static void __pmac
+pmac_ide_dma_start(ide_drive_t *drive)
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	volatile struct dbdma_regs __iomem *dma;
 
-	if (pmif == NULL)
-		return 1;
 	dma = pmif->dma_regs;
 
 	writel((RUN << 16) | RUN, &dma->control);
 	/* Make sure it gets to the controller right now */
 	(void)readl(&dma->control);
-	return 0;
 }
 
 /*
@@ -2148,9 +2083,9 @@
 	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
-	hwif->ide_dma_read = &pmac_ide_dma_read;
-	hwif->ide_dma_write = &pmac_ide_dma_write;
-	hwif->ide_dma_begin = &pmac_ide_dma_begin;
+	hwif->dma_setup = &pmac_ide_dma_setup;
+	hwif->dma_exec_cmd = &pmac_ide_dma_exec_cmd;
+	hwif->dma_start = &pmac_ide_dma_start;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;
 	hwif->ide_dma_host_off = &pmac_ide_dma_host_off;
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2004-10-19 22:11:26 +02:00
+++ b/drivers/scsi/ide-scsi.c	2004-10-19 22:11:26 +02:00
@@ -555,6 +555,7 @@
 
 static ide_startstop_t idescsi_transfer_pc(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t *pc = scsi->pc;
 	atapi_ireason_t ireason;
@@ -579,7 +580,7 @@
 	atapi_output_bytes(drive, scsi->pc->c, 12);
 	if (test_bit (PC_DMA_OK, &pc->flags)) {
 		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->ide_dma_begin(drive));
+		hwif->dma_start(drive);
 	}
 	return ide_started;
 }
@@ -590,6 +591,7 @@
 static ide_startstop_t idescsi_issue_pc (ide_drive_t *drive, idescsi_pc_t *pc)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
+	ide_hwif_t *hwif = drive->hwif;
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 	struct request *rq = pc->rq;
@@ -600,12 +602,8 @@
 	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to
transfer the entire buffer at once */
 
 	feature.all = 0;
-	if (drive->using_dma && rq->bio) {
-		if (test_bit(PC_WRITING, &pc->flags))
-			feature.b.dma = !HWIF(drive)->ide_dma_write(drive);
-		else
-			feature.b.dma = !HWIF(drive)->ide_dma_read(drive);
-	}
+	if (drive->using_dma && rq->bio)
+		feature.b.dma = !hwif->dma_setup(drive);
 
 	SELECT_DRIVE(drive);
 	if (IDE_CONTROL_REG)
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-19 22:11:26 +02:00
+++ b/include/linux/ide.h	2004-10-19 22:11:26 +02:00
@@ -887,9 +887,9 @@
 	void (*atapi_input_bytes)(ide_drive_t *, void *, u32);
 	void (*atapi_output_bytes)(ide_drive_t *, void *, u32);
 
-	int (*ide_dma_read)(ide_drive_t *drive);
-	int (*ide_dma_write)(ide_drive_t *drive);
-	int (*ide_dma_begin)(ide_drive_t *drive);
+	int (*dma_setup)(ide_drive_t *);
+	void (*dma_exec_cmd)(ide_drive_t *, u8);
+	void (*dma_start)(ide_drive_t *);
 	int (*ide_dma_end)(ide_drive_t *drive);
 	int (*ide_dma_check)(ide_drive_t *drive);
 	int (*ide_dma_on)(ide_drive_t *drive);
@@ -1544,16 +1544,14 @@
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
-extern int ide_start_dma(ide_hwif_t *, ide_drive_t *, int);
 
 extern int __ide_dma_host_off(ide_drive_t *);
 extern int __ide_dma_off_quietly(ide_drive_t *);
 extern int __ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
 extern int __ide_dma_check(ide_drive_t *);
-extern int __ide_dma_read(ide_drive_t *);
-extern int __ide_dma_write(ide_drive_t *);
-extern int __ide_dma_begin(ide_drive_t *);
+extern int ide_dma_setup(ide_drive_t *);
+extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern int __ide_dma_test_irq(ide_drive_t *);
 extern int __ide_dma_verbose(ide_drive_t *);
diff -Nru a/include/linux/scatterlist.h b/include/linux/scatterlist.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/scatterlist.h	2004-10-19 22:11:26 +02:00
@@ -0,0 +1,14 @@
+#ifndef _LINUX_SCATTERLIST_H
+#define _LINUX_SCATTERLIST_H
+
+static inline void sg_init_one(struct scatterlist *sg,
+			       u8 *buf, unsigned int buflen)
+{
+	memset(sg, 0, sizeof(*sg));
+
+	sg->page = virt_to_page(buf);
+	sg->offset = offset_in_page(buf);
+	sg->length = buflen;
+}
+
+#endif /* _LINUX_SCATTERLIST_H */

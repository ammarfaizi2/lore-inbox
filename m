Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVAGD5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVAGD5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAGD5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:57:04 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:48569 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261209AbVAGDxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:53:21 -0500
Date: Fri, 7 Jan 2005 04:48:48 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.58.0501070440440.22876@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/arm/icside.c   |    2
 drivers/ide/cris/ide-v10.c |    2
 drivers/ide/ide-cd.c       |   69 +---------------
 drivers/ide/ide-disk.c     |  190 ---------------------------------------------
 drivers/ide/ide-dma.c      |    3
 drivers/ide/ide-floppy.c   |    4
 drivers/ide/ide-io.c       |  169 +++++++++++++++++++++++-----------------
 drivers/ide/ide-iops.c     |    4
 drivers/ide/ide-lib.c      |  132 ++++++++++++++++++++++++++++++-
 drivers/ide/ide-taskfile.c |    8 -
 drivers/ide/ide.c          |  151 +----------------------------------
 drivers/ide/pci/sgiioc4.c  |    8 -
 drivers/ide/ppc/pmac.c     |    2
 drivers/ide/setup-pci.c    |   27 +-----
 drivers/pci/quirks.c       |   20 ++++
 drivers/scsi/ide-scsi.c    |   33 -------
 include/linux/ide.h        |   22 +----
 17 files changed, 293 insertions(+), 553 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/01/07 1.2241)
   [ide] kill current_capacity()

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2240)
   [ide] ide_driver_t->abort() cleanup

   * add drive->media != ide_disk check to ide_abort()
   * kill ide_cdrom_abort() and idedisk_abort()
   * split __ide_abort() out of ide_abort()
   * call driver->abort() inside ide_abort()
   * convert the only user of driver->abort()
   * fix default_abort() and idescsi_atapi_abort()
   * make idescsi_atapi_abort() static

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2239)
   [ide] rework ide_driver_t->error

   * split __ide_error() out of ide_error()
   * call driver->error() inside ide_error()
   * convert all users of driver->error()
   * fix default_cleanup() and idescsi_atapi_error()
   * make idescsi_atapi_error() static

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2238)
   [ide] cleanup ide_error()

   * move idedisk_error() and ide_cdrom_error() to ide-io.c
   * rename idedisk_error() to ide_ata_error()
   * rename ide_cdrom_error() to ide_atapi_error()
   * use ide_{ata,atapi}_error() in ide_error()

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2237)
   [ide] cleanup ide_dump_status()

   * move idedisk_dump_status() and ide_dump_status() to ide-lib.c
   * rename idedisk_dump_status() to ide_dump_ata_status()
   * use ide_dump_{ata,atapi}_status() in ide_dump_status()
   * use ide_dump_status() in ide-cd.c, ide-disk.c and ide-scsi.c
   * make ide_dump_opcode() and ide_dump_atapi_status)() static

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2236)
   [ide] add ide_dump_opcode()

   * add it to ide-lib.c and cleanup ide{disk}_dump_status()
   * as a bonus it fixes unknown opcode reporting in ide_dump_status()
   * use ide_dump_opcode() in ide_dump_atapi_status()

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2235)
   [ide] kill write-only ide_driver_t->sense

   also kill default_sense() in ide.c

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2234)
   [ide] PCI quirk for ICH3-M IDE

   From: Jim Paris <jim@jtan.com>

   Bartlomiej: I have an ICH3-M controller on my laptop.  The BIOS is
   leaving the prog-if as 0x8E (primary = legacy, secondary = native).
   When the PCI interrupt is routed (either in the IDE driver's
   pci_enable_device, or earlier if pci=routeirq is used), unhandled
   interrupts cause IRQ 9 to be disabled, breaking most of my other
   hardware.  This seems to be caused by having the nonexistant secondary
   interface set to native mode.  According to the datasheet I checked,
   having different modes for primary/secondary is not an allowed
   combination anyway, so the following PCI quirk checks for this case
   and forces both interfaces to legacy if true.

   It may make sense to make this more generic (this problem may affect
   other PCI IDs as well), or it may be better solved in the IDE driver,
   at least when pci=routeirq is not used.  But the following patch does
   work well for me.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2233)
   [ide] fix erroneous rq->buffer = NULL in ide-io.c:ide_dma_timeout_retry()

   From: Prarit Bhargava <prarit@sgi.com>

   Please see discussion related to this patch here,

   http://marc.theaimsgroup.com/?l=linux-ide&m=110485007824374&w=2

   Acked-by: Jens Axboe <axboe@suse.de>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2232)
   [ide] disable debug in IDE ppc/pmac driver

   Ben did not disagree to hide the 3 additional lines printed when booting
   my ibook with the 'quiet' cmdline option.
   I think these debug printk have no real value for normal operation.

   Signed-off-by: Olaf Hering <olh@suse.de>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2231)
   [ide] remove CRD-8480C from the DMA blacklist

   Reported to work OK by Daniel Robitaille <robitaille@gmail.com>.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/07 1.2230)
   [ide] remove pci_disable_device() calls from setup-pci.c and sgiioc4.c

   On Mon, 03 Jan 2005 21:44:33 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
   >
   > Different PCI functions are but nothing requires that the PCI function
   > that is the IDE controller is only the IDE controller. In some cases
   > other logic lives in the "spare" BAR register areas of the device.
   >
   > One example where the weird design makes it obvious is the CS5520. Here
   > the 5520 bridge has the IDE in one BAR and all sorts of other logic
   > (including the xBUS virtual ISA environment) in the same PCI function.
   > On that chip a pci_disable_device on the IDE pci_dev turns off mundane
   > things like the timer chips keyboard and mouse 8).
   >
   > Other vendors do equally evil things and providing the chip reports IDE
   > class and has the IDE BARs set up nobody else is any the wiser and
   > presumably gate count goes down.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/arm/icside.c	2005-01-07 04:16:03 +01:00
@@ -423,7 +423,7 @@
 		       drive->name, dma_stat);
 	}

-	return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+	return ide_error(drive, __FUNCTION__, stat);
 }

 static int icside_dma_setup(ide_drive_t *drive)
diff -Nru a/drivers/ide/cris/ide-v10.c b/drivers/ide/cris/ide-v10.c
--- a/drivers/ide/cris/ide-v10.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/cris/ide-v10.c	2005-01-07 04:16:03 +01:00
@@ -773,7 +773,7 @@
 		}
 		printk("%s: bad DMA status\n", drive->name);
 	}
-	return DRIVER(drive)->error(drive, "dma_intr", stat);
+	return ide_error(drive, "dma_intr", stat);
 }

 /*
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-07 04:16:03 +01:00
@@ -559,62 +559,6 @@
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }

-/*
- * ide_error() takes action based on the error returned by the drive.
- */
-static ide_startstop_t ide_cdrom_error (ide_drive_t *drive, const char *msg, byte stat)
-{
-	struct request *rq;
-	byte err;
-
-	err = ide_dump_atapi_status(drive, msg, stat);
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, stat, err);
-		return ide_stopped;
-	}
-
-	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
-		/* other bits are useless when BUSY */
-		rq->errors |= ERROR_RESET;
-	} else {
-		/* add decoding error stuff */
-	}
-	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
-		/* force an abort */
-		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
-	if (rq->errors >= ERROR_MAX) {
-		DRIVER(drive)->end_request(drive, 0, 0);
-	} else {
-		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
-			++rq->errors;
-			return ide_do_reset(drive);
-		}
-		++rq->errors;
-	}
-	return ide_stopped;
-}
-
-static ide_startstop_t ide_cdrom_abort (ide_drive_t *drive, const char *msg)
-{
-	struct request *rq;
-
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, BUSY_STAT, 0);
-		return ide_stopped;
-	}
-	rq->errors |= ERROR_RESET;
-	DRIVER(drive)->end_request(drive, 0, 0);
-	return ide_stopped;
-}
-
 static void cdrom_end_request (ide_drive_t *drive, int uptodate)
 {
 	struct request *rq = HWGROUP(drive)->rq;
@@ -690,7 +634,7 @@

 		rq->flags |= REQ_FAILED;
 		cdrom_end_request(drive, 0);
-		DRIVER(drive)->error(drive, "request sense failure", stat);
+		ide_error(drive, "request sense failure", stat);
 		return 1;

 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
@@ -801,7 +745,7 @@
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
-			DRIVER(drive)->error(drive, "cdrom_decode_status",stat);
+			ide_error(drive, "cdrom_decode_status", stat);
 			return 1;
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
@@ -1070,7 +1014,7 @@
 			ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		} else
-			return DRIVER(drive)->error(drive, "dma error", stat);
+			return ide_error(drive, "dma error", stat);
 	}

 	/* Read the interrupt reason and the transfer length. */
@@ -1673,7 +1617,7 @@
 		if (dma_error) {
 			printk("ide-cd: dma error\n");
 			__ide_dma_off(drive);
-			return DRIVER(drive)->error(drive, "dma error", stat);
+			return ide_error(drive, "dma error", stat);
 		}

 		end_that_request_chunk(rq, 1, rq->data_len);
@@ -1811,7 +1755,7 @@
 	 */
 	if (dma) {
 		if (dma_error)
-			return DRIVER(drive)->error(drive, "dma error", stat);
+			return ide_error(drive, "dma error", stat);

 		ide_end_request(drive, 1, rq->nr_sectors);
 		return ide_stopped;
@@ -3369,9 +3313,6 @@
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
-	.sense			= ide_dump_atapi_status,
-	.error			= ide_cdrom_error,
-	.abort			= ide_cdrom_abort,
 	.capacity		= ide_cdrom_capacity,
 	.attach			= ide_cdrom_attach,
 	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-07 04:16:03 +01:00
@@ -287,189 +287,6 @@
 		return __ide_do_rw_disk(drive, rq, block);
 }

-static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
-	u8 err = 0;
-
-	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-	printk(" { ");
-	if (stat & BUSY_STAT)
-		printk("Busy ");
-	else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
-	}
-	printk("}");
-	printk("\n");
-	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
-		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-		printk(" { ");
-		if (err & ABRT_ERR)	printk("DriveStatusError ");
-		if (err & ICRC_ERR)
-			printk("Bad%s ", (err & ABRT_ERR) ? "CRC" : "Sector");
-		if (err & ECC_ERR)	printk("UncorrectableError ");
-		if (err & ID_ERR)	printk("SectorIdNotFound ");
-		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-		printk("}");
-		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
-		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			if (drive->addressing == 1) {
-				__u64 sectors = 0;
-				u32 low = 0, high = 0;
-				low = ide_read_24(drive);
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				high = ide_read_24(drive);
-				sectors = ((__u64)high << 24) | low;
-				printk(", LBAsect=%llu, high=%d, low=%d",
-				       (unsigned long long) sectors,
-				       high, low);
-			} else {
-				u8 cur = hwif->INB(IDE_SELECT_REG);
-				if (cur & 0x40) {	/* using LBA? */
-					printk(", LBAsect=%ld", (unsigned long)
-					 ((cur&0xf)<<24)
-					 |(hwif->INB(IDE_HCYL_REG)<<16)
-					 |(hwif->INB(IDE_LCYL_REG)<<8)
-					 | hwif->INB(IDE_SECTOR_REG));
-				} else {
-					printk(", CHS=%d/%d/%d",
-					 (hwif->INB(IDE_HCYL_REG)<<8) +
-					  hwif->INB(IDE_LCYL_REG),
-					  cur & 0xf,
-					  hwif->INB(IDE_SECTOR_REG));
-				}
-			}
-			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=%llu",
-					(unsigned long long)HWGROUP(drive)->rq->sector);
-		}
-	}
-	printk("\n");
-	{
-		struct request *rq;
-		unsigned char opcode = 0;
-		int found = 0;
-
-		spin_lock(&ide_lock);
-		rq = HWGROUP(drive)->rq;
-		spin_unlock(&ide_lock);
-		if (!rq)
-			goto out;
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
-			char *args = rq->buffer;
-			if (args) {
-				opcode = args[0];
-				found = 1;
-			}
-		} else if (rq->flags & REQ_DRIVE_TASKFILE) {
-			ide_task_t *args = rq->special;
-			if (args) {
-				task_struct_t *tf = (task_struct_t *) args->tfRegister;
-				opcode = tf->command;
-				found = 1;
-			}
-		}
-		printk("ide: failed opcode was: ");
-		if (!found)
-			printk("unknown\n");
-		else
-			printk("0x%02x\n", opcode);
-	}
-out:
-	local_irq_restore(flags);
-	return err;
-}
-
-static ide_startstop_t idedisk_error (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif;
-	struct request *rq;
-	u8 err;
-
-	err = idedisk_dump_status(drive, msg, stat);
-
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-
-	hwif = HWIF(drive);
-	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, stat, err);
-		return ide_stopped;
-	}
-
-	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
-		/* other bits are useless when BUSY */
-		rq->errors |= ERROR_RESET;
-	} else if (stat & ERR_STAT) {
-		/* err has different meaning on cdrom and tape */
-		if (err == ABRT_ERR) {
-			if (drive->select.b.lba &&
-			    /* some newer drives don't support WIN_SPECIFY */
-			    hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY)
-				return ide_stopped;
-		} else if ((err & BAD_CRC) == BAD_CRC) {
-			/* UDMA crc error, just retry the operation */
-			drive->crc_count++;
-		} else if (err & (BBD_ERR | ECC_ERR)) {
-			/* retries won't help these */
-			rq->errors = ERROR_MAX;
-		} else if (err & TRK0_ERR) {
-			/* help it find track zero */
-			rq->errors |= ERROR_RECAL;
-		}
-	}
-	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ)
-		try_to_flush_leftover_data(drive);
-	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
-		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
-	}
-	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
-		DRIVER(drive)->end_request(drive, 0, 0);
-	else {
-		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
-			++rq->errors;
-			return ide_do_reset(drive);
-		}
-		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			drive->special.b.recalibrate = 1;
-		++rq->errors;
-	}
-	return ide_stopped;
-}
-
-static ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
-{
-	ide_hwif_t *hwif;
-	struct request *rq;
-
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-
-	hwif = HWIF(drive);
-
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, BUSY_STAT, 0);
-		return ide_stopped;
-	}
-
-	DRIVER(drive)->end_request(drive, 0, 0);
-	return ide_stopped;
-}
-
 /*
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
@@ -1358,9 +1175,6 @@
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
 	.do_request		= ide_do_rw_disk,
-	.sense			= idedisk_dump_status,
-	.error			= idedisk_error,
-	.abort			= idedisk_abort,
 	.pre_reset		= idedisk_pre_reset,
 	.capacity		= idedisk_capacity,
 	.special		= idedisk_special,
@@ -1434,7 +1248,7 @@
 static int idedisk_revalidate_disk(struct gendisk *disk)
 {
 	ide_drive_t *drive = disk->private_data;
-	set_capacity(disk, current_capacity(drive));
+	set_capacity(disk, idedisk_capacity(drive));
 	return 0;
 }

@@ -1478,7 +1292,7 @@
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
-	set_capacity(g, current_capacity(drive));
+	set_capacity(g, idedisk_capacity(drive));
 	g->fops = &idedisk_ops;
 	add_disk(g);
 	return 0;
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-dma.c	2005-01-07 04:16:03 +01:00
@@ -116,7 +116,6 @@
 	{ "Compaq CRD-8241B"	,	"ALL"		},
 	{ "CRD-8400B"		,	"ALL"		},
 	{ "CRD-8480B",			"ALL"		},
-	{ "CRD-8480C",			"ALL"		},
 	{ "CRD-8482B",			"ALL"		},
  	{ "CRD-84"		,	"ALL"		},
 	{ "SanDisk SDP3B"	,	"ALL"		},
@@ -184,7 +183,7 @@
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
-	return DRIVER(drive)->error(drive, "dma_intr", stat);
+	return ide_error(drive, "dma_intr", stat);
 }

 EXPORT_SYMBOL_GPL(ide_dma_intr);
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-07 04:16:03 +01:00
@@ -1640,7 +1640,7 @@
 }

 /*
- *	Return the current floppy capacity to ide.c.
+ *	Return the current floppy capacity.
  */
 static sector_t idefloppy_capacity (ide_drive_t *drive)
 {
@@ -2034,7 +2034,7 @@
 static int idefloppy_revalidate_disk(struct gendisk *disk)
 {
 	ide_drive_t *drive = disk->private_data;
-	set_capacity(disk, current_capacity(drive));
+	set_capacity(disk, idefloppy_capacity(drive));
 	return 0;
 }

diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-io.c	2005-01-07 04:16:03 +01:00
@@ -454,9 +454,88 @@

 EXPORT_SYMBOL(try_to_flush_leftover_data);

-/*
- * FIXME Add an ATAPI error
- */
+static ide_startstop_t ide_ata_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
+{
+	ide_hwif_t *hwif = drive->hwif;
+
+	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
+		/* other bits are useless when BUSY */
+		rq->errors |= ERROR_RESET;
+	} else if (stat & ERR_STAT) {
+		/* err has different meaning on cdrom and tape */
+		if (err == ABRT_ERR) {
+			if (drive->select.b.lba &&
+			    /* some newer drives don't support WIN_SPECIFY */
+			    hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY)
+				return ide_stopped;
+		} else if ((err & BAD_CRC) == BAD_CRC) {
+			/* UDMA crc error, just retry the operation */
+			drive->crc_count++;
+		} else if (err & (BBD_ERR | ECC_ERR)) {
+			/* retries won't help these */
+			rq->errors = ERROR_MAX;
+		} else if (err & TRK0_ERR) {
+			/* help it find track zero */
+			rq->errors |= ERROR_RECAL;
+		}
+	}
+
+	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ)
+		try_to_flush_leftover_data(drive);
+
+	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
+		/* force an abort */
+		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
+
+	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
+		drive->driver->end_request(drive, 0, 0);
+	else {
+		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
+			++rq->errors;
+			return ide_do_reset(drive);
+		}
+		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
+			drive->special.b.recalibrate = 1;
+		++rq->errors;
+	}
+	return ide_stopped;
+}
+
+static ide_startstop_t ide_atapi_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
+{
+	ide_hwif_t *hwif = drive->hwif;
+
+	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
+		/* other bits are useless when BUSY */
+		rq->errors |= ERROR_RESET;
+	} else {
+		/* add decoding error stuff */
+	}
+
+	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
+		/* force an abort */
+		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
+
+	if (rq->errors >= ERROR_MAX) {
+		drive->driver->end_request(drive, 0, 0);
+	} else {
+		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
+			++rq->errors;
+			return ide_do_reset(drive);
+		}
+		++rq->errors;
+	}
+
+	return ide_stopped;
+}
+
+ide_startstop_t
+__ide_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
+{
+	if (drive->media == ide_disk)
+		return ide_ata_error(drive, rq, stat, err);
+	return ide_atapi_error(drive, rq, stat, err);
+}

 /**
  *	ide_error	-	handle an error on the IDE
@@ -473,73 +552,32 @@

 ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, u8 stat)
 {
-	ide_hwif_t *hwif;
 	struct request *rq;
 	u8 err;

 	err = ide_dump_status(drive, msg, stat);
+
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;

-	hwif = HWIF(drive);
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, stat, err);
-		return ide_stopped;
-	}
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
 	}

-	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
-		 /* other bits are useless when BUSY */
+	return drive->driver->error(drive, rq, stat, err);
+}
+
+EXPORT_SYMBOL_GPL(ide_error);
+
+ide_startstop_t __ide_abort(ide_drive_t *drive, struct request *rq)
+{
+	if (drive->media != ide_disk)
 		rq->errors |= ERROR_RESET;
-	} else {
-		if (drive->media != ide_disk)
-			goto media_out;

-		if (stat & ERR_STAT) {
-			/* err has different meaning on cdrom and tape */
-			if (err == ABRT_ERR) {
-				if (drive->select.b.lba &&
-				    (hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY))
-					/* some newer drives don't
-					 * support WIN_SPECIFY
-					 */
-					return ide_stopped;
-			} else if ((err & BAD_CRC) == BAD_CRC) {
-				drive->crc_count++;
-				/* UDMA crc error -- just retry the operation */
-			} else if (err & (BBD_ERR | ECC_ERR)) {
-				/* retries won't help these */
-				rq->errors = ERROR_MAX;
-			} else if (err & TRK0_ERR) {
-				/* help it find track zero */
-				rq->errors |= ERROR_RECAL;
-			}
-		}
-media_out:
-		if ((stat & DRQ_STAT) && rq_data_dir(rq) != WRITE)
-			try_to_flush_leftover_data(drive);
-	}
-	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
-		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
-	}
-	if (rq->errors >= ERROR_MAX) {
-		DRIVER(drive)->end_request(drive, 0, 0);
-	} else {
-		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
-			++rq->errors;
-			return ide_do_reset(drive);
-		}
-		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			drive->special.b.recalibrate = 1;
-		++rq->errors;
-	}
+	DRIVER(drive)->end_request(drive, 0, 0);
 	return ide_stopped;
 }

@@ -559,28 +597,19 @@

 ide_startstop_t ide_abort(ide_drive_t *drive, const char *msg)
 {
-	ide_hwif_t *hwif;
 	struct request *rq;

 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;

-	hwif = HWIF(drive);
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, BUSY_STAT, 0);
-		return ide_stopped;
-	}
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, BUSY_STAT, 0);
 		return ide_stopped;
 	}

-	rq->errors |= ERROR_RESET;
-	DRIVER(drive)->end_request(drive, 0, 0);
-	return ide_stopped;
+	return drive->driver->abort(drive, rq);
 }

 /**
@@ -634,7 +663,7 @@
 	}

 	if (!OK_STAT(stat, READY_STAT, BAD_STAT) && DRIVER(drive) != NULL)
-		return DRIVER(drive)->error(drive, "drive_cmd", stat);
+		return ide_error(drive, "drive_cmd", stat);
 		/* calls ide_end_drive_cmd */
 	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
 	return ide_stopped;
@@ -1181,7 +1210,7 @@
 	if (error < 0) {
 		printk(KERN_WARNING "%s: DMA timeout error\n", drive->name);
 		(void)HWIF(drive)->ide_dma_end(drive);
-		ret = DRIVER(drive)->error(drive, "dma timeout error",
+		ret = ide_error(drive, "dma timeout error",
 						hwif->INB(IDE_STATUS_REG));
 	} else {
 		printk(KERN_WARNING "%s: DMA timeout retry\n", drive->name);
@@ -1212,7 +1241,7 @@
 	rq->sector = rq->bio->bi_sector;
 	rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
 	rq->hard_cur_sectors = rq->current_nr_sectors;
-	rq->buffer = NULL;
+	rq->buffer = bio_data(rq->bio);
 out:
 	return ret;
 }
@@ -1304,7 +1333,7 @@
 					startstop = ide_dma_timeout_retry(drive, wait);
 				} else
 					startstop =
-					DRIVER(drive)->error(drive, "irq timeout", hwif->INB(IDE_STATUS_REG));
+					ide_error(drive, "irq timeout", hwif->INB(IDE_STATUS_REG));
 			}
 			drive->service_time = jiffies - drive->service_start;
 			spin_lock_irq(&ide_lock);
diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-iops.c	2005-01-07 04:16:03 +01:00
@@ -576,7 +576,7 @@
 					break;

 				local_irq_restore(flags);
-				*startstop = DRIVER(drive)->error(drive, "status timeout", stat);
+				*startstop = ide_error(drive, "status timeout", stat);
 				return 1;
 			}
 		}
@@ -594,7 +594,7 @@
 		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
 			return 0;
 	}
-	*startstop = DRIVER(drive)->error(drive, "status error", stat);
+	*startstop = ide_error(drive, "status error", stat);
 	return 1;
 }

diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-lib.c	2005-01-07 04:16:03 +01:00
@@ -445,6 +445,114 @@

 EXPORT_SYMBOL_GPL(ide_set_xfer_rate);

+static void ide_dump_opcode(ide_drive_t *drive)
+{
+	struct request *rq;
+	u8 opcode = 0;
+	int found = 0;
+
+	spin_lock(&ide_lock);
+	rq = NULL;
+	if (HWGROUP(drive))
+		rq = HWGROUP(drive)->rq;
+	spin_unlock(&ide_lock);
+	if (!rq)
+		return;
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+		char *args = rq->buffer;
+		if (args) {
+			opcode = args[0];
+			found = 1;
+		}
+	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
+		ide_task_t *args = rq->special;
+		if (args) {
+			task_struct_t *tf = (task_struct_t *) args->tfRegister;
+			opcode = tf->command;
+			found = 1;
+		}
+	}
+
+	printk("ide: failed opcode was: ");
+	if (!found)
+		printk("unknown\n");
+	else
+		printk("0x%02x\n", opcode);
+}
+
+static u8 ide_dump_ata_status(ide_drive_t *drive, const char *msg, u8 stat)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long flags;
+	u8 err = 0;
+
+	local_irq_set(flags);
+	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
+	printk(" { ");
+	if (stat & BUSY_STAT)
+		printk("Busy ");
+	else {
+		if (stat & READY_STAT)	printk("DriveReady ");
+		if (stat & WRERR_STAT)	printk("DeviceFault ");
+		if (stat & SEEK_STAT)	printk("SeekComplete ");
+		if (stat & DRQ_STAT)	printk("DataRequest ");
+		if (stat & ECC_STAT)	printk("CorrectedError ");
+		if (stat & INDEX_STAT)	printk("Index ");
+		if (stat & ERR_STAT)	printk("Error ");
+	}
+	printk("}");
+	printk("\n");
+	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
+		err = hwif->INB(IDE_ERROR_REG);
+		printk("%s: %s: error=0x%02x", drive->name, msg, err);
+		printk(" { ");
+		if (err & ABRT_ERR)	printk("DriveStatusError ");
+		if (err & ICRC_ERR)
+			printk("Bad%s ", (err & ABRT_ERR) ? "CRC" : "Sector");
+		if (err & ECC_ERR)	printk("UncorrectableError ");
+		if (err & ID_ERR)	printk("SectorIdNotFound ");
+		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
+		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
+		printk("}");
+		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
+		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
+			if (drive->addressing == 1) {
+				__u64 sectors = 0;
+				u32 low = 0, high = 0;
+				low = ide_read_24(drive);
+				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
+				high = ide_read_24(drive);
+				sectors = ((__u64)high << 24) | low;
+				printk(", LBAsect=%llu, high=%d, low=%d",
+				       (unsigned long long) sectors,
+				       high, low);
+			} else {
+				u8 cur = hwif->INB(IDE_SELECT_REG);
+				if (cur & 0x40) {	/* using LBA? */
+					printk(", LBAsect=%ld", (unsigned long)
+					 ((cur&0xf)<<24)
+					 |(hwif->INB(IDE_HCYL_REG)<<16)
+					 |(hwif->INB(IDE_LCYL_REG)<<8)
+					 | hwif->INB(IDE_SECTOR_REG));
+				} else {
+					printk(", CHS=%d/%d/%d",
+					 (hwif->INB(IDE_HCYL_REG)<<8) +
+					  hwif->INB(IDE_LCYL_REG),
+					  cur & 0xf,
+					  hwif->INB(IDE_SECTOR_REG));
+				}
+			}
+			if (HWGROUP(drive) && HWGROUP(drive)->rq)
+				printk(", sector=%llu",
+					(unsigned long long)HWGROUP(drive)->rq->sector);
+		}
+	}
+	printk("\n");
+	ide_dump_opcode(drive);
+	local_irq_restore(flags);
+	return err;
+}
+
 /**
  *	ide_dump_atapi_status       -       print human readable atapi status
  *	@drive: drive that status applies to
@@ -453,7 +561,8 @@
  *
  *	Error reporting, in human readable form (luxurious, but a memory hog).
  */
-byte ide_dump_atapi_status (ide_drive_t *drive, const char *msg, byte stat)
+
+static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	unsigned long flags;

@@ -488,8 +597,27 @@
 						error.b.sense_key);
 		printk("\n");
 	}
+	ide_dump_opcode(drive);
 	local_irq_restore(flags);
 	return error.all;
 }

-EXPORT_SYMBOL(ide_dump_atapi_status);
+/**
+ *	ide_dump_status		-	translate ATA/ATAPI error
+ *	@drive: drive the error occured on
+ *	@msg: information string
+ *	@stat: status byte
+ *
+ *	Error reporting, in human readable form (luxurious, but a memory hog).
+ *	Combines the drive name, message and status byte to provide a
+ *	user understandable explanation of the device error.
+ */
+
+u8 ide_dump_status(ide_drive_t *drive, const char *msg, u8 stat)
+{
+	if (drive->media == ide_disk)
+		return ide_dump_ata_status(drive, msg, stat);
+	return ide_dump_atapi_status(drive, msg, stat);
+}
+
+EXPORT_SYMBOL(ide_dump_status);
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-01-07 04:16:03 +01:00
@@ -199,7 +199,7 @@
 		return ide_stopped;

 	if (stat & (ERR_STAT|DRQ_STAT))
-		return DRIVER(drive)->error(drive, "set_geometry_intr", stat);
+		return ide_error(drive, "set_geometry_intr", stat);

 	if (HWGROUP(drive)->handler != NULL)
 		BUG();
@@ -218,7 +218,7 @@
 	u8 stat;

 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), READY_STAT, BAD_STAT))
-		return DRIVER(drive)->error(drive, "recal_intr", stat);
+		return ide_error(drive, "recal_intr", stat);
 	return ide_stopped;
 }

@@ -235,7 +235,7 @@

 	local_irq_enable();
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),READY_STAT,BAD_STAT)) {
-		return DRIVER(drive)->error(drive, "task_no_data_intr", stat);
+		return ide_error(drive, "task_no_data_intr", stat);
 		/* calls ide_end_drive_cmd */
 	}
 	if (args)
@@ -363,7 +363,7 @@
 		if (sectors > 0)
 			drive->driver->end_request(drive, 1, sectors);
 	}
-	return drive->driver->error(drive, s, stat);
+	return ide_error(drive, s, stat);
 }

 static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ide.c	2005-01-07 04:16:03 +01:00
@@ -358,137 +358,6 @@
 	return system_bus_speed;
 }

-/**
- *	current_capacity	-	drive capacity
- *	@drive: drive to query
- *
- *	Return the current capacity (in sectors) of a drive according to
- *	its current geometry/LBA settings. Empty removables are reported
- *	as size zero.
- */
-
-sector_t current_capacity (ide_drive_t *drive)
-{
-	if (!drive->present)
-		return 0;
-	return DRIVER(drive)->capacity(drive);
-}
-
-EXPORT_SYMBOL(current_capacity);
-
-/**
- *	ide_dump_status		-	translate ATA error
- *	@drive: drive the error occured on
- *	@msg: information string
- *	@stat: status byte
- *
- *	Error reporting, in human readable form (luxurious, but a memory hog).
- *	Combines the drive name, message and status byte to provide a
- *	user understandable explanation of the device error.
- */
-
-u8 ide_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
-	u8 err = 0;
-
-	local_irq_set(flags);
-	printk(KERN_WARNING "%s: %s: status=0x%02x", drive->name, msg, stat);
-	printk(" { ");
-	if (stat & BUSY_STAT) {
-		printk("Busy ");
-	} else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
-	}
-	printk("}");
-	printk("\n");
-	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
-		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-		if (drive->media == ide_disk) {
-			printk(" { ");
-			if (err & ABRT_ERR)	printk("DriveStatusError ");
-			if (err & ICRC_ERR)	printk("Bad%s ", (err & ABRT_ERR) ? "CRC" : "Sector");
-			if (err & ECC_ERR)	printk("UncorrectableError ");
-			if (err & ID_ERR)	printk("SectorIdNotFound ");
-			if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-			if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-			printk("}");
-			if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR || (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-				if ((drive->id->command_set_2 & 0x0400) &&
-				    (drive->id->cfs_enable_2 & 0x0400) &&
-				    (drive->addressing == 1)) {
-					u64 sectors = 0;
-					u32 high = 0;
-					u32 low = ide_read_24(drive);
-					hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-					high = ide_read_24(drive);
-
-					sectors = ((u64)high << 24) | low;
-					printk(", LBAsect=%llu, high=%d, low=%d",
-					       (long long) sectors,
-					       high, low);
-				} else {
-					u8 cur = hwif->INB(IDE_SELECT_REG);
-					if (cur & 0x40) {	/* using LBA? */
-						printk(", LBAsect=%ld", (unsigned long)
-						 ((cur&0xf)<<24)
-						 |(hwif->INB(IDE_HCYL_REG)<<16)
-						 |(hwif->INB(IDE_LCYL_REG)<<8)
-						 | hwif->INB(IDE_SECTOR_REG));
-					} else {
-						printk(", CHS=%d/%d/%d",
-						 (hwif->INB(IDE_HCYL_REG)<<8) +
-						  hwif->INB(IDE_LCYL_REG),
-						  cur & 0xf,
-						  hwif->INB(IDE_SECTOR_REG));
-					}
-				}
-				if (HWGROUP(drive) && HWGROUP(drive)->rq)
-					printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
-			}
-		}
-		printk("\n");
-	}
-	{
-		struct request *rq;
-		int opcode = 0x100;
-
-		spin_lock(&ide_lock);
-		rq = NULL;
-		if (HWGROUP(drive))
-			rq = HWGROUP(drive)->rq;
-		spin_unlock(&ide_lock);
-		if (!rq)
-			goto out;
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
-			char *args = rq->buffer;
-			if (args)
-				opcode = args[0];
-		} else if (rq->flags & REQ_DRIVE_TASKFILE) {
-			ide_task_t *args = rq->special;
-			if (args) {
-				task_struct_t *tf = (task_struct_t *) args->tfRegister;
-				opcode = tf->command;
-			}
-		}
-
-		printk("ide: failed opcode was %x\n", opcode);
-	}
-out:
-	local_irq_restore(flags);
-	return err;
-}
-
-EXPORT_SYMBOL(ide_dump_status);
-
 static int ide_open (struct inode * inode, struct file * filp)
 {
 	return -ENXIO;
@@ -1673,8 +1542,9 @@
 			 */

 			spin_lock_irqsave(&ide_lock, flags);
-
-			DRIVER(drive)->abort(drive, "drive reset");
+
+			ide_abort(drive, "drive reset");
+
 			if(HWGROUP(drive)->handler)
 				BUG();

@@ -2180,14 +2050,10 @@
 	return ide_end_request(drive, uptodate, nr_sects);
 }

-static u8 default_sense (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	return ide_dump_status(drive, msg, stat);
-}
-
-static ide_startstop_t default_error (ide_drive_t *drive, const char *msg, u8 stat)
+static ide_startstop_t
+default_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
 {
-	return ide_error(drive, msg, stat);
+	return __ide_error(drive, rq, stat, err);
 }

 static void default_pre_reset (ide_drive_t *drive)
@@ -2216,9 +2082,9 @@
 	return 0;
 }

-static ide_startstop_t default_abort (ide_drive_t *drive, const char *msg)
+static ide_startstop_t default_abort(ide_drive_t *drive, struct request *rq)
 {
-	return ide_abort(drive, msg);
+	return __ide_abort(drive, rq);
 }

 static ide_startstop_t default_start_power_step(ide_drive_t *drive,
@@ -2233,7 +2099,6 @@
 	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
-	if (d->sense == NULL)		d->sense = default_sense;
 	if (d->error == NULL)		d->error = default_error;
 	if (d->abort == NULL)		d->abort = default_abort;
 	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/pci/sgiioc4.c	2005-01-07 04:16:03 +01:00
@@ -701,17 +701,11 @@
 			"firmware is obsolete - please upgrade to revision"
 			"46 or higher\n", d->name, dev->slot_name);
 		ret = -EAGAIN;
-		goto err_disable;
+		goto out;
 	}
 	ret = sgiioc4_ide_setup_pci_device(dev, d);
-	if (ret < 0)
-		goto err_disable;
 out:
 	return ret;
-
-err_disable:
-	pci_disable_device(dev);
-	goto out;
 }

 static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/ppc/pmac.c	2005-01-07 04:16:03 +01:00
@@ -52,7 +52,7 @@

 #include "ide-timing.h"

-#define IDE_PMAC_DEBUG
+#undef IDE_PMAC_DEBUG

 #define DMA_WAIT_TIMEOUT	50

diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/ide/setup-pci.c	2005-01-07 04:16:03 +01:00
@@ -311,13 +311,11 @@
 	ret = pci_set_dma_mask(dev, DMA_32BIT_MASK);
 	if (ret < 0) {
 		printk(KERN_ERR "%s: can't set dma mask\n", d->name);
-		pci_disable_device(dev);
 		goto out;
 	}

 	/* FIXME: Temporary - until we put in the hotplug interface logic
-	   Check that the bits we want are not in use by someone else.
-	   As someone else uses it, we do not (yuck) disable the device */
+	   Check that the bits we want are not in use by someone else. */
 	ret = pci_request_region(dev, 4, "ide_tmp");
 	if (ret < 0)
 		goto out;
@@ -542,12 +540,12 @@
 	ret = pci_read_config_word(dev, PCI_COMMAND, &pcicmd);
 	if (ret < 0) {
 		printk(KERN_ERR "%s: error accessing PCI regs\n", d->name);
-		goto err_disable;
+		goto out;
 	}
 	if (!(pcicmd & PCI_COMMAND_IO)) {	/* is device disabled? */
 		ret = ide_pci_configure(dev, d);
 		if (ret < 0)
-			goto err_disable;
+			goto out;
 		*config = 1;
 		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
 	}
@@ -558,17 +556,6 @@
 		printk(KERN_INFO "%s: chipset revision %d\n", d->name, class_rev);
 out:
 	return ret;
-
-err_disable:
-	pci_disable_device(dev);
-	goto out;
-}
-
-static void ide_release_pci_controller(struct pci_dev *dev, ide_pci_device_t *d,
-				       int noisy)
-{
-	/* Balance ide_pci_enable() */
-	pci_disable_device(dev);
 }

 /**
@@ -701,7 +688,7 @@
 		 */
 		ret = d->init_chipset ? d->init_chipset(dev, d->name) : 0;
 		if (ret < 0)
-			goto err_release_pci_controller;
+			goto out;
 		pciirq = ret;
 	} else if (tried_config) {
 		if (noisy)
@@ -716,7 +703,7 @@
 		if (d->init_chipset) {
 			ret = d->init_chipset(dev, d->name);
 			if (ret < 0)
-				goto err_release_pci_controller;
+				goto out;
 		}
 		if (noisy)
 #ifdef __sparc__
@@ -734,10 +721,6 @@
 	ide_pci_setup_ports(dev, d, pciirq, index);
 out:
 	return ret;
-
-err_release_pci_controller:
-	ide_release_pci_controller(dev, d, noisy);
-	goto out;
 }

 int ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d)
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/pci/quirks.c	2005-01-07 04:16:03 +01:00
@@ -699,6 +699,26 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );

+/*
+ *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
+ */
+static void __init quirk_ide_samemode(struct pci_dev *pdev)
+{
+	u8 prog;
+
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+
+	if (((prog & 1) && !(prog & 4)) || ((prog & 4) && !(prog & 1))) {
+		printk(KERN_INFO "PCI: IDE mode mismatch; forcing legacy mode\n");
+		prog &= ~5;
+		pdev->class &= ~5;
+		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+		/* need to re-assign BARs for compat mode */
+		quirk_ide_bases(pdev);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
+
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-01-07 04:16:03 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-01-07 04:16:03 +01:00
@@ -301,23 +301,9 @@
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }

-ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
+static ide_startstop_t
+idescsi_atapi_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
 {
-	struct request *rq;
-	byte err;
-
-	err = ide_dump_atapi_status(drive, msg, stat);
-
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-
-	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, stat, err);
-		return ide_stopped;
-	}
-
 	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
 		/* force an abort */
 		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
@@ -327,20 +313,9 @@
 	return ide_stopped;
 }

-ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
+static ide_startstop_t
+idescsi_atapi_abort(ide_drive_t *drive, struct request *rq)
 {
-	struct request *rq;
-
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-	       return ide_stopped;
-
-	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, BUSY_STAT, 0);
-		return ide_stopped;
-	}
-
 #if IDESCSI_DEBUG_LOG
 	printk(KERN_WARNING "idescsi_atapi_abort called for %lu\n",
 			((idescsi_pc_t *) rq->special)->scsi_cmd->serial_number);
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-07 04:16:03 +01:00
+++ b/include/linux/ide.h	2005-01-07 04:16:03 +01:00
@@ -1097,9 +1097,8 @@
 	int		(*cleanup)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);
-	u8		(*sense)(ide_drive_t *, const char *, u8);
-	ide_startstop_t	(*error)(ide_drive_t *, const char *, u8);
-	ide_startstop_t	(*abort)(ide_drive_t *, const char *);
+	ide_startstop_t	(*error)(ide_drive_t *, struct request *rq, u8, u8);
+	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	void		(*pre_reset)(ide_drive_t *);
 	sector_t	(*capacity)(ide_drive_t *);
@@ -1147,12 +1146,7 @@
  */
 extern void ide_execute_command(ide_drive_t *, task_ioreg_t cmd, ide_handler_t *, unsigned int, ide_expiry_t *);

-/*
- * Error reporting, in human readable form (luxurious, but a memory hog).
- *
- * (drive, msg, status)
- */
-byte ide_dump_status (ide_drive_t *drive, const char *msg, byte stat);
+ide_startstop_t __ide_error(ide_drive_t *, struct request *, u8, u8);

 /*
  * ide_error() takes action based on the error returned by the controller.
@@ -1162,6 +1156,8 @@
  */
 ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, byte stat);

+ide_startstop_t __ide_abort(ide_drive_t *, struct request *);
+
 /*
  * Abort a running command on the controller triggering the abort
  * from a host side, non error situation
@@ -1192,11 +1188,6 @@
 extern int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);

 /*
- * Return the current idea about the total capacity of this drive.
- */
-extern sector_t current_capacity (ide_drive_t *drive);
-
-/*
  * Start a reset operation for an IDE interface.
  * The caller should return immediately after invoking this.
  */
@@ -1511,7 +1502,8 @@
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
-extern byte ide_dump_atapi_status(ide_drive_t *drive, const char *msg, byte stat);
+
+u8 ide_dump_status(ide_drive_t *, const char *, u8);

 typedef struct ide_pio_timings_s {
 	int	setup_time;	/* Address setup (ns) minimum */

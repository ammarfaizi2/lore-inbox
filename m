Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271036AbUJVAtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271036AbUJVAtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271167AbUJVAqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:46:11 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:47926 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271139AbUJVAep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:34:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=HwBIKQIAme9EOaP5AhJkyPPx+R7dZEm+qwDTZyK65QRoByzTMA2y5gA+rIV6yjuTtlc3xswHrIZe6jprLtqekk9MLrCqZ0FddVfdwafO+PzYTG8HlgE8wSukA/0VibG0BR8G3nHg0djsgJNa2y/dJ4WrVye/FNFqMYHl7rLTRPM=
Message-ID: <58cb370e04102117346281cb87@mail.gmail.com>
Date: Fri, 22 Oct 2004 02:34:44 +0200
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

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/legacy/pdc4030.c |  679 -------------------------------------------
 drivers/ide/legacy/pdc4030.h |   70 ----
 Documentation/ide.txt        |    4 
 drivers/block/ll_rw_blk.c    |  114 -------
 drivers/ide/Kconfig          |   22 -
 drivers/ide/ide-disk.c       |  168 ----------
 drivers/ide/ide-io.c         |   12 
 drivers/ide/ide-probe.c      |   19 -
 drivers/ide/ide-proc.c       |    1 
 drivers/ide/ide.c            |   18 -
 drivers/ide/legacy/Makefile  |    1 
 drivers/ide/pci/sgiioc4.c    |    1 
 include/linux/blkdev.h       |   36 --
 include/linux/ide.h          |    4 
 14 files changed, 17 insertions(+), 1132 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/22 1.2039)
   [ide] kill CONFIG_IDE_TASKFILE_IO
   
   It is not needed any longer:
   * PIO code is unified and converted to use scatterlists
   * taskfile code doesn't support falling back to PIO
   * it is much easier to convert non-taskfile version of
     __ide_do_rw_disk() to something sane than taskfile one
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/22 1.2038)
   [block] remove bio walking
   
   All users of this code were fixed to use scatterlists.
   
   Acked by Jens.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/21 1.2037)
   [ide] remove broken pdc4030 driver
   
   Sigh, I broke it by accident 16 months ago and nobody has noticed
   (I suspect that it was non-functional even earlier).
   
   Additionally, this driver:
   * should be converted to use scatterlists
   * has verbose debugging enabled by default
   * needs hacks all over IDE code
   * is guilty of crimes against ide_hwifs[]
   
   Just remove it for now.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/Documentation/ide.txt b/Documentation/ide.txt
--- a/Documentation/ide.txt	2004-10-22 02:20:30 +02:00
+++ b/Documentation/ide.txt	2004-10-22 02:20:30 +02:00
@@ -304,7 +304,7 @@
 
  "ide=reverse"		: formerly called to pci sub-system, but now local.
 
-The following are valid ONLY on ide0 (except dc4030), which usually corresponds
+The following are valid ONLY on ide0, which usually corresponds
 to the first ATA interface found on the particular host, and the defaults for
 the base,ctl ports must not be altered.
 
@@ -315,7 +315,7 @@
  "ide0=qd65xx"		: probe/support qd65xx interface
  "ide0=ali14xx"		: probe/support ali14xx chipsets (ALI M1439/M1443/M1445)
  "ide0=umc8672"		: probe/support umc8672 chipsets
- "idex=dc4030"		: probe/support Promise DC4030VL interface
+
  "ide=doubler"		: probe/support IDE doublers on Amiga
 
 There may be more options than shown -- use the source, Luke!
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/block/ll_rw_blk.c	2004-10-22 02:20:30 +02:00
@@ -2360,9 +2360,7 @@
 				break;
 
 			bio->bi_next = req->bio;
-			req->cbio = req->bio = bio;
-			req->nr_cbio_segments = bio_segments(bio);
-			req->nr_cbio_sectors = bio_sectors(bio);
+			req->bio = bio;
 
 			/*
 			 * may not be valid. if the low level driver said
@@ -2434,11 +2432,9 @@
 	req->current_nr_sectors = req->hard_cur_sectors = cur_nr_sectors;
 	req->nr_phys_segments = bio_phys_segments(q, bio);
 	req->nr_hw_segments = bio_hw_segments(q, bio);
-	req->nr_cbio_segments = bio_segments(bio);
-	req->nr_cbio_sectors = bio_sectors(bio);
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
-	req->cbio = req->bio = req->biotail = bio;
+	req->bio = req->biotail = bio;
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
@@ -2685,83 +2681,6 @@
 
 EXPORT_SYMBOL(submit_bio);
 
-/**
- * blk_rq_next_segment
- * @rq:		the request being processed
- *
- * Description:
- *	Points to the next segment in the request if the current segment
- *	is complete. Leaves things unchanged if this segment is not over
- *	or if no more segments are left in this request.
- *
- *	Meant to be used for bio traversal during I/O submission
- *	Does not affect any I/O completions or update completion state
- *	in the request, and does not modify any bio fields.
- *
- *	Decrementing rq->nr_sectors, rq->current_nr_sectors and
- *	rq->nr_cbio_sectors as data is transferred is the caller's
- *	responsibility and should be done before calling this routine.
- **/
-void blk_rq_next_segment(struct request *rq)
-{
-	if (rq->current_nr_sectors > 0)
-		return;
-
-	if (rq->nr_cbio_sectors > 0) {
-		--rq->nr_cbio_segments;
-		rq->current_nr_sectors = blk_rq_vec(rq)->bv_len >> 9;
-	} else {
-		if ((rq->cbio = rq->cbio->bi_next)) {
-			rq->nr_cbio_segments = bio_segments(rq->cbio);
-			rq->nr_cbio_sectors = bio_sectors(rq->cbio);
- 			rq->current_nr_sectors = bio_cur_sectors(rq->cbio);
-		}
- 	}
-
-	/* remember the size of this segment before we start I/O */
-	rq->hard_cur_sectors = rq->current_nr_sectors;
-}
-
-/**
- * process_that_request_first	-	process partial request submission
- * @req:	the request being processed
- * @nr_sectors:	number of sectors I/O has been submitted on
- *
- * Description:
- *	May be used for processing bio's while submitting I/O without
- *	signalling completion. Fails if more data is requested than is
- *	available in the request in which case it doesn't advance any
- *	pointers.
- *
- *	Assumes a request is correctly set up. No sanity checks.
- *
- * Return:
- *	0 - no more data left to submit (not processed)
- *	1 - data available to submit for this request (processed)
- **/
-int process_that_request_first(struct request *req, unsigned int nr_sectors)
-{
-	unsigned int nsect;
-
-	if (req->nr_sectors < nr_sectors)
-		return 0;
-
-	req->nr_sectors -= nr_sectors;
-	req->sector += nr_sectors;
-	while (nr_sectors) {
-		nsect = min_t(unsigned, req->current_nr_sectors, nr_sectors);
-		req->current_nr_sectors -= nsect;
-		nr_sectors -= nsect;
-		if (req->cbio) {
-			req->nr_cbio_sectors -= nsect;
-			blk_rq_next_segment(req);
-		}
-	}
-	return 1;
-}
-
-EXPORT_SYMBOL(process_that_request_first);
-
 void blk_recalc_rq_segments(struct request *rq)
 {
 	struct bio *bio, *prevbio = NULL;
@@ -2797,8 +2716,7 @@
 		rq->hard_nr_sectors -= nsect;
 
 		/*
-		 * Move the I/O submission pointers ahead if required,
-		 * i.e. for drivers not aware of rq->cbio.
+		 * Move the I/O submission pointers ahead if required.
 		 */
 		if ((rq->nr_sectors >= rq->hard_nr_sectors) &&
 		    (rq->sector <= rq->hard_sector)) {
@@ -2806,11 +2724,7 @@
 			rq->nr_sectors = rq->hard_nr_sectors;
 			rq->hard_cur_sectors = bio_cur_sectors(rq->bio);
 			rq->current_nr_sectors = rq->hard_cur_sectors;
-			rq->nr_cbio_segments = bio_segments(rq->bio);
-			rq->nr_cbio_sectors = bio_sectors(rq->bio);
 			rq->buffer = bio_data(rq->bio);
-
-			rq->cbio = rq->bio;
 		}
 
 		/*
@@ -3022,32 +2936,12 @@
 	rq->current_nr_sectors = bio_cur_sectors(bio);
 	rq->hard_cur_sectors = rq->current_nr_sectors;
 	rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
-	rq->nr_cbio_segments = bio_segments(bio);
-	rq->nr_cbio_sectors = bio_sectors(bio);
 	rq->buffer = bio_data(bio);
 
-	rq->cbio = rq->bio = rq->biotail = bio;
+	rq->bio = rq->biotail = bio;
 }
 
 EXPORT_SYMBOL(blk_rq_bio_prep);
-
-void blk_rq_prep_restart(struct request *rq)
-{
-	struct bio *bio;
-
-	bio = rq->cbio = rq->bio;
-	if (bio) {
-		rq->nr_cbio_segments = bio_segments(bio);
-		rq->nr_cbio_sectors = bio_sectors(bio);
-		rq->hard_cur_sectors = bio_cur_sectors(bio);
-		rq->buffer = bio_data(bio);
-	}
-	rq->sector = rq->hard_sector;
-	rq->nr_sectors = rq->hard_nr_sectors;
-	rq->current_nr_sectors = rq->hard_cur_sectors;
-}
-
-EXPORT_SYMBOL(blk_rq_prep_restart);
 
 int kblockd_schedule_work(struct work_struct *work)
 {
diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/Kconfig	2004-10-22 02:20:30 +02:00
@@ -273,15 +273,6 @@
 
 	  If you are unsure, say N here.
 
-config IDE_TASKFILE_IO
-	bool 'IDE Taskfile IO (EXPERIMENTAL)'
-	depends on EXPERIMENTAL
-	default n
-	---help---
-	  Use new taskfile IO code.
-
-	  It is safe to say Y to this question, in most cases.
-
 comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
@@ -1006,19 +997,6 @@
 	  of the Holtek card, and permits faster I/O speeds to be set as well.
 	  See the <file:Documentation/ide.txt> and
 	  <file:drivers/ide/legacy/ht6560b.c> files for more info.
-
-config BLK_DEV_PDC4030
-	tristate "PROMISE DC4030 support (EXPERIMENTAL)"
-	depends on BLK_DEV_IDEDISK && EXPERIMENTAL
-	help
-	  This driver provides support for the secondary IDE interface and
-	  cache of the original Promise IDE chipsets, e.g. DC4030 and DC5030.
-	  It is nothing to do with the later range of Promise UDMA chipsets -
-	  see the PDC_202XX support for these. CD-ROM and TAPE devices are not
-	  supported (and probably never will be since I don't think the cards
-	  support them). This driver is enabled at runtime using the "ide0=dc4030"
-	  or "ide1=dc4030" kernel boot parameter. See the
-	  <file:drivers/ide/legacy/pdc4030.c> file for more info.
 
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/ide-disk.c	2004-10-22 02:20:30 +02:00
@@ -71,10 +71,6 @@
 #include <asm/io.h>
 #include <asm/div64.h>
 
-/* FIXME: some day we shouldn't need to look in here! */
-
-#include "legacy/pdc4030.h"
-
 /*
  * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
@@ -120,8 +116,6 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
-#ifndef CONFIG_IDE_TASKFILE_IO
-
 /*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
@@ -150,6 +144,8 @@
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
+	/* FIXME: SELECT_MASK(drive, 0) ? */
+
 	if (drive->select.b.lba) {
 		if (drive->addressing == 1) {
 			task_ioreg_t tasklets[10];
@@ -254,6 +250,7 @@
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
 
+		/* FIXME: ->OUTBSYNC ? */
 		hwif->OUTB(command, IDE_COMMAND_REG);
 
 		pre_task_out_intr(drive, rq);
@@ -262,169 +259,12 @@
 }
 EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
 
-#else /* CONFIG_IDE_TASKFILE_IO */
-
-static ide_startstop_t chs_rw_disk(ide_drive_t *, struct request *,
unsigned long);
-static ide_startstop_t lba_28_rw_disk(ide_drive_t *, struct request
*, unsigned long);
-static ide_startstop_t lba_48_rw_disk(ide_drive_t *, struct request
*, unsigned long long);
-
-/*
- * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
- * using LBA if supported, or CHS otherwise, to address sectors.
- * It also takes care of issuing special DRIVE_CMDs.
- */
-ide_startstop_t __ide_do_rw_disk (ide_drive_t *drive, struct request
*rq, sector_t block)
-{
-	/*
-	 * 268435455  == 137439 MB or 28bit limit
-	 *
-	 * need to add split taskfile operations based on 28bit threshold.
-	 */
-	if (drive->addressing == 1)		/* 48-bit LBA */
-		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
-	if (drive->select.b.lba)		/* 28-bit LBA */
-		return lba_28_rw_disk(drive, rq, (unsigned long) block);
-
-	/* 28-bit CHS : DIE DIE DIE piece of legacy crap!!! */
-	return chs_rw_disk(drive, rq, (unsigned long) block);
-}
-EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
-
-static u8 get_command(ide_drive_t *drive, struct request *rq, ide_task_t *task)
-{
-	unsigned int lba48 = (drive->addressing == 1) ? 1 : 0;
-	unsigned int dma = drive->using_dma;
-
-	if (drive->hwif->no_lba48_dma && lba48 && dma) {
-		if (rq->sector + rq->nr_sectors > 1ULL << 28)
-			dma = 0;
-	}
-
-	if (!dma) {
-		ide_init_sg_cmd(drive, rq);
-		ide_map_sg(drive, rq);
-	}
-
-	if (rq_data_dir(rq) == READ) {
-		task->command_type = IDE_DRIVE_TASK_IN;
-		if (dma)
-			return lba48 ? WIN_READDMA_EXT : WIN_READDMA;
-		task->handler = &task_in_intr;
-		if (drive->mult_count) {
-			task->data_phase = TASKFILE_MULTI_IN;
-			return lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
-		}
-		task->data_phase = TASKFILE_IN;
-		return lba48 ? WIN_READ_EXT : WIN_READ;
-	} else {
-		task->command_type = IDE_DRIVE_TASK_RAW_WRITE;
-		if (dma)
-			return lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-		task->prehandler = &pre_task_out_intr;
-		task->handler = &task_out_intr;
-		if (drive->mult_count) {
-			task->data_phase = TASKFILE_MULTI_OUT;
-			return lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
-		}
-		task->data_phase = TASKFILE_OUT;
-		return lba48 ? WIN_WRITE_EXT : WIN_WRITE;
-	}
-}
-
-static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct
request *rq, unsigned long block)
-{
-	ide_task_t		args;
-	int			sectors;
-	ata_nsector_t		nsectors;
-	unsigned int track	= (block / drive->sect);
-	unsigned int sect	= (block % drive->sect) + 1;
-	unsigned int head	= (track % drive->head);
-	unsigned int cyl	= (track / drive->head);
-
-	nsectors.all = (u16) rq->nr_sectors;
-
-	pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
-
-	memset(&args, 0, sizeof(ide_task_t));
-
-	sectors	= (rq->nr_sectors == 256) ? 0x00 : rq->nr_sectors;
-
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= sectors;
-	args.tfRegister[IDE_SECTOR_OFFSET]	= sect;
-	args.tfRegister[IDE_LCYL_OFFSET]	= cyl;
-	args.tfRegister[IDE_HCYL_OFFSET]	= (cyl>>8);
-	args.tfRegister[IDE_SELECT_OFFSET]	= head;
-	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq, &args);
-	args.rq					= (struct request *) rq;
-	rq->special				= (ide_task_t *)&args;
-	drive->hwif->data_phase = args.data_phase;
-	return do_rw_taskfile(drive, &args);
-}
-
-static ide_startstop_t lba_28_rw_disk (ide_drive_t *drive, struct
request *rq, unsigned long block)
-{
-	ide_task_t		args;
-	int			sectors;
-	ata_nsector_t		nsectors;
-
-	nsectors.all = (u16) rq->nr_sectors;
-
-	memset(&args, 0, sizeof(ide_task_t));
-
-	sectors = (rq->nr_sectors == 256) ? 0x00 : rq->nr_sectors;
-
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= sectors;
-	args.tfRegister[IDE_SECTOR_OFFSET]	= block;
-	args.tfRegister[IDE_LCYL_OFFSET]	= (block>>=8);
-	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);
-	args.tfRegister[IDE_SELECT_OFFSET]	= ((block>>8)&0x0f);
-	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq, &args);
-	args.rq					= (struct request *) rq;
-	rq->special				= (ide_task_t *)&args;
-	drive->hwif->data_phase = args.data_phase;
-	return do_rw_taskfile(drive, &args);
-}
-
 /*
  * 268435455  == 137439 MB or 28bit limit
  * 320173056  == 163929 MB or 48bit addressing
  * 1073741822 == 549756 MB or 48bit addressing fake drive
  */
 
-static ide_startstop_t lba_48_rw_disk (ide_drive_t *drive, struct
request *rq, unsigned long long block)
-{
-	ide_task_t		args;
-	int			sectors;
-	ata_nsector_t		nsectors;
-
-	nsectors.all = (u16) rq->nr_sectors;
-
-	memset(&args, 0, sizeof(ide_task_t));
-
-	sectors = (rq->nr_sectors == 65536) ? 0 : rq->nr_sectors;
-
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= sectors;
-	args.hobRegister[IDE_NSECTOR_OFFSET]	= sectors >> 8;
-	args.tfRegister[IDE_SECTOR_OFFSET]	= block;	/* low lba */
-	args.tfRegister[IDE_LCYL_OFFSET]	= (block>>=8);	/* mid lba */
-	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);	/* hi  lba */
-	args.tfRegister[IDE_SELECT_OFFSET]	= drive->select.all;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq, &args);
-	args.hobRegister[IDE_SECTOR_OFFSET]	= (block>>=8);	/* low lba */
-	args.hobRegister[IDE_LCYL_OFFSET]	= (block>>=8);	/* mid lba */
-	args.hobRegister[IDE_HCYL_OFFSET]	= (block>>=8);	/* hi  lba */
-	args.hobRegister[IDE_SELECT_OFFSET]	= drive->select.all;
-	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
-	args.rq					= (struct request *) rq;
-	rq->special				= (ide_task_t *)&args;
-	drive->hwif->data_phase = args.data_phase;
-	return do_rw_taskfile(drive, &args);
-}
-
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 static ide_startstop_t ide_do_rw_disk (ide_drive_t *drive, struct
request *rq, sector_t block)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -862,6 +702,8 @@
 {
 	return drive->capacity64 - drive->sect0;
 }
+
+#define IS_PDC4030_DRIVE	0
 
 static ide_startstop_t idedisk_special (ide_drive_t *drive)
 {
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/ide-io.c	2004-10-22 02:20:30 +02:00
@@ -1587,18 +1587,6 @@
 	int where = ELEVATOR_INSERT_BACK, err;
 	int must_wait = (action == ide_wait || action == ide_head_wait);
 
-#ifdef CONFIG_BLK_DEV_PDC4030
-	/*
-	 *	FIXME: there should be a drive or hwif->special
-	 *	handler that points here by default, not hacks
-	 *	in the ide-io.c code
-	 *
-	 *	FIXME2: That code breaks power management if used with
-	 *	this chipset, that really doesn't belong here !
-	 */
-	if (HWIF(drive)->chipset == ide_pdc4030 && rq->buffer != NULL)
-		return -ENOSYS;  /* special drive cmds not supported */
-#endif
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/ide-probe.c	2004-10-22 02:20:30 +02:00
@@ -180,12 +180,6 @@
 	if (cmd == WIN_PIDENTIFY) {
 		u8 type = (id->config >> 8) & 0x1f;
 		printk("ATAPI ");
-#ifdef CONFIG_BLK_DEV_PDC4030
-		if (hwif->channel == 1 && hwif->chipset == ide_pdc4030) {
-			printk(" -- not supported on 2nd Promise port\n");
-			goto err_misc;
-		}
-#endif /* CONFIG_BLK_DEV_PDC4030 */
 		switch (type) {
 			case ide_floppy:
 				if (!strstr(id->model, "CD-ROM")) {
@@ -297,13 +291,9 @@
 		/* disable dma & overlap */
 		hwif->OUTB(0, IDE_FEATURE_REG);
 
-	if (hwif->identify != NULL) {
-		if (hwif->identify(drive))
-			return 1;
-	} else {
-		/* ask drive for ID */
-		hwif->OUTB(cmd, IDE_COMMAND_REG);
-	}
+	/* ask drive for ID */
+	hwif->OUTB(cmd, IDE_COMMAND_REG);
+
 	timeout = ((cmd == WIN_IDENTIFY) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
 	timeout += jiffies;
 	do {
@@ -676,9 +666,6 @@
 		return;
 
 	if ((hwif->chipset != ide_4drives || !hwif->mate || !hwif->mate->present) &&
-#ifdef CONFIG_BLK_DEV_PDC4030
-	    (hwif->chipset != ide_pdc4030 || hwif->channel == 0) &&
-#endif /* CONFIG_BLK_DEV_PDC4030 */
 	    (ide_hwif_request_regions(hwif))) {
 		u16 msgout = 0;
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/ide-proc.c	2004-10-22 02:20:30 +02:00
@@ -314,7 +314,6 @@
 		case ide_qd65xx:	name = "qd65xx";	break;
 		case ide_umc8672:	name = "umc8672";	break;
 		case ide_ht6560b:	name = "ht6560b";	break;
-		case ide_pdc4030:	name = "pdc4030";	break;
 		case ide_rz1000:	name = "rz1000";	break;
 		case ide_trm290:	name = "trm290";	break;
 		case ide_cmd646:	name = "cmd646";	break;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/ide.c	2004-10-22 02:20:30 +02:00
@@ -668,7 +668,6 @@
 	hwif->cds			= tmp_hwif->cds;
 #endif
 
-	hwif->identify			= tmp_hwif->identify;
 	hwif->tuneproc			= tmp_hwif->tuneproc;
 	hwif->speedproc			= tmp_hwif->speedproc;
 	hwif->selectproc		= tmp_hwif->selectproc;
@@ -1778,9 +1777,6 @@
 	return 0;	/* zero = nothing matched */
 }
 
-#ifdef CONFIG_BLK_DEV_PDC4030
-static int __initdata probe_pdc4030;
-#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 static int __initdata probe_ali14xx;
 extern int ali14xx_init(void);
@@ -1949,7 +1945,7 @@
 			"noprobe", "serialize", "autotune", "noautotune", 
 			"reset", "dma", "ata66", "minus8", "minus9",
 			"minus10", "four", "qd65xx", "ht6560b", "cmd640_vlb",
-			"dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
+			"dtc2278", "umc8672", "ali14xx", NULL };
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
 		i = match_parm(&s[4], ide_words, vals, 3);
@@ -1975,11 +1971,6 @@
 		}
 
 		switch (i) {
-#ifdef CONFIG_BLK_DEV_PDC4030
-			case -18: /* "dc4030" */
-				probe_pdc4030 = 1;
-				goto done;
-#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 			case -17: /* "ali14xx" */
 				probe_ali14xx = 1;
@@ -2114,13 +2105,6 @@
 		ide_probe_for_cmd640x();
 	}
 #endif /* CONFIG_BLK_DEV_CMD640 */
-#ifdef CONFIG_BLK_DEV_PDC4030
-	{
-		extern int pdc4030_init(void);
-		if (probe_pdc4030)
-			(void)pdc4030_init();
-	}
-#endif /* CONFIG_BLK_DEV_PDC4030 */
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
 	{
 		extern void pmac_ide_probe(void);
diff -Nru a/drivers/ide/legacy/Makefile b/drivers/ide/legacy/Makefile
--- a/drivers/ide/legacy/Makefile	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/legacy/Makefile	2004-10-22 02:20:30 +02:00
@@ -2,7 +2,6 @@
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+= ali14xx.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+= dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+= ht6560b.o
-obj-$(CONFIG_BLK_DEV_PDC4030)		+= pdc4030.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+= qd65xx.o
 obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
 
diff -Nru a/drivers/ide/legacy/pdc4030.c b/drivers/ide/legacy/pdc4030.c
--- a/drivers/ide/legacy/pdc4030.c	2004-10-22 02:20:30 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,679 +0,0 @@
-/*  -*- linux-c -*-
- *  linux/drivers/ide/legacy/pdc4030.c		Version 0.90  May 27, 1999
- *
- *  Copyright (C) 1995-2002  Linus Torvalds & authors (see below)
- */
-
-/*
- *  Principal Author/Maintainer:  Peter Denison <promise@pnd-pc.demon.co.uk>
- *
- *  This file provides support for the second port and cache of Promise
- *  IDE interfaces, e.g. DC4030VL, DC4030VL-1 and DC4030VL-2.
- *
- *  Thanks are due to Mark Lord for advice and patiently answering stupid
- *  questions, and all those mugs^H^H^H^Hbrave souls who've tested this,
- *  especially Andre Hedrick.
- *
- *  Version 0.01	Initial version, #include'd in ide.c rather than
- *                      compiled separately.
- *                      Reads use Promise commands, writes as before. Drives
- *                      on second channel are read-only.
- *  Version 0.02        Writes working on second channel, reads on both
- *                      channels. Writes fail under high load. Suspect
- *			transfers of >127 sectors don't work.
- *  Version 0.03        Brought into line with ide.c version 5.27.
- *                      Other minor changes.
- *  Version 0.04        Updated for ide.c version 5.30
- *                      Changed initialization strategy
- *  Version 0.05	Kernel integration.  -ml
- *  Version 0.06	Ooops. Add hwgroup to direct call of ide_intr() -ml
- *  Version 0.07	Added support for DC4030 variants
- *			Secondary interface autodetection
- *  Version 0.08	Renamed to pdc4030.c
- *  Version 0.09	Obsolete - never released - did manual write request
- *			splitting before max_sectors[major][minor] available.
- *  Version 0.10	Updated for 2.1 series of kernels
- *  Version 0.11	Updated for 2.3 series of kernels
- *			Autodetection code added.
- *
- *  Version 0.90	Transition to BETA code. No lost/unexpected interrupts
- */
-
-/*
- * Once you've compiled it in, you'll have to also enable the interface
- * setup routine from the kernel command line, as in 
- *
- *	'linux ide0=dc4030' or 'linux ide1=dc4030'
- *
- * It should now work as a second controller also ('ide1=dc4030') but only
- * if you DON'T have BIOS V4.44, which has a bug. If you have this version
- * and EPROM programming facilities, you need to fix 4 bytes:
- * 	2496:	81	81
- *	2497:	3E	3E
- *	2498:	22	98	*
- *	2499:	06	05	*
- *	249A:	F0	F0
- *	249B:	01	01
- *	...
- *	24A7:	81	81
- *	24A8:	3E	3E
- *	24A9:	22	98	*
- *	24AA:	06	05	*
- *	24AB:	70	70
- *	24AC:	01	01
- *
- * As of January 1999, Promise Technology Inc. have finally supplied me with
- * some technical information which has shed a glimmer of light on some of the
- * problems I was having, especially with writes. 
- *
- * There are still potential problems with the robustness and efficiency of
- * this driver because I still don't understand what the card is doing with
- * interrupts, however, it has been stable for a while with no reports of ill
- * effects.
- */
-
-#define DEBUG_READ
-#define DEBUG_WRITE
-#define __PROMISE_4030
-
-#include <linux/module.h>
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include "pdc4030.h"
-
-static ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct
request *rq, sector_t block);
-
-/*
- * promise_selectproc() is invoked by ide.c
- * in preparation for access to the specified drive.
- */
-static void promise_selectproc (ide_drive_t *drive)
-{
-	unsigned int number;
-
-	number = (HWIF(drive)->channel << 1) + drive->select.b.unit;
-	HWIF(drive)->OUTB(number, IDE_FEATURE_REG);
-}
-
-/*
- * pdc4030_cmd handles the set of vendor specific commands that are initiated
- * by command F0. They all have the same success/failure notification -
- * 'P' (=0x50) on success, 'p' (=0x70) on failure.
- */
-int pdc4030_cmd(ide_drive_t *drive, u8 cmd)
-{
-	unsigned long timeout;
-	u8 status_val;
-
-	promise_selectproc(drive);	/* redundant? */
-	HWIF(drive)->OUTB(0xF3, IDE_SECTOR_REG);
-	HWIF(drive)->OUTB(cmd, IDE_SELECT_REG);
-	HWIF(drive)->OUTB(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
-	timeout = HZ * 10;
-	timeout += jiffies;
-	do {
-		if(time_after(jiffies, timeout)) {
-			return 2; /* device timed out */
-		}
-		/* Delays at least 10ms to give interface a chance */
-		mdelay(10);
-		status_val = HWIF(drive)->INB(IDE_SECTOR_REG);
-	} while (status_val != 0x50 && status_val != 0x70);
-
-	if(status_val == 0x50)
-		return 0; /* device returned success */
-	else
-		return 1; /* device returned failure */
-}
-
-/*
- * pdc4030_identify sends a vendor-specific IDENTIFY command to the drive
- */
-int pdc4030_identify(ide_drive_t *drive)
-{
-	return pdc4030_cmd(drive, PROMISE_IDENTIFY);
-}
-
-/*
- * setup_pdc4030()
- * Completes the setup of a Promise DC4030 controller card, once found.
- */
-int __init setup_pdc4030(ide_hwif_t *hwif)
-{
-        ide_drive_t *drive;
-	ide_hwif_t *hwif2;
-	struct dc_ident ident;
-	int i;
-	ide_startstop_t startstop;
-	
-	if (!hwif) return 0;
-
-	drive = &hwif->drives[0];
-	hwif2 = &ide_hwifs[hwif->index+1];
-	if (hwif->chipset == ide_pdc4030) /* we've already been found ! */
-		return 1;
-
-	if (hwif->INB(IDE_NSECTOR_REG) == 0xFF ||
-	    hwif->INB(IDE_SECTOR_REG) == 0xFF) {
-		return 0;
-	}
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(0x08, IDE_CONTROL_REG);
-	if (pdc4030_cmd(drive,PROMISE_GET_CONFIG)) {
-		return 0;
-	}
-	if (ide_wait_stat(&startstop, drive,DATA_READY,BAD_W_STAT,WAIT_DRQ)) {
-		printk(KERN_INFO
-			"%s: Failed Promise read config!\n",hwif->name);
-		return 0;
-	}
-	hwif->ata_input_data(drive, &ident, SECTOR_WORDS);
-	if (ident.id[1] != 'P' || ident.id[0] != 'T') {
-		return 0;
-	}
-	printk(KERN_INFO "%s: Promise caching controller, ",hwif->name);
-	switch(ident.type) {
-		case 0x43:	printk("DC4030VL-2, "); break;
-		case 0x41:	printk("DC4030VL-1, "); break;
-		case 0x40:	printk("DC4030VL, "); break;
-		default:
-			printk("unknown - type 0x%02x - please report!\n"
-			       ,ident.type);
-			printk("Please e-mail the following data to "
-			       "promise@pnd-pc.demon.co.uk along with\n"
-			       "a description of your card and drives:\n");
-			for (i=0; i < 0x90; i++) {
-				printk("%02x ", ((unsigned char *)&ident)[i]);
-				if ((i & 0x0f) == 0x0f) printk("\n");
-			}
-			return 0;
-	}
-	printk("%dKB cache, ",(int)ident.cache_mem);
-	switch(ident.irq) {
-            case 0x00: hwif->irq = 14; break;
-            case 0x01: hwif->irq = 12; break;
-            default:   hwif->irq = 15; break;
-	}
-	printk("on IRQ %d\n",hwif->irq);
-
-	/*
-	 * Once found and identified, we set up the next hwif in the array
-	 * (hwif2 = ide_hwifs[hwif->index+1]) with the same io ports, irq
-	 * and other settings as the main hwif. This gives us two "mated"
-	 * hwifs pointing to the Promise card.
-	 *
-	 * We also have to shift the default values for the remaining
-	 * interfaces "up by one" to make room for the second interface on the
-	 * same set of values.
-	 */
-
-	hwif->chipset	= hwif2->chipset = ide_pdc4030;
-	hwif->mate	= hwif2;
-	hwif2->mate	= hwif;
-	hwif2->channel	= 1;
-	hwif->rqsize	= hwif2->rqsize = 127;
-	hwif->no_lba48 = hwif2->no_lba48 = 1;
-	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
-	hwif->serialized = hwif2->serialized = 1;
-	/* DC4030 hosted drives need their own identify... */
-	hwif->identify = hwif2->identify = &pdc4030_identify;
-
-	/* Override the normal ide disk read/write. */
-	hwif->rw_disk = promise_rw_disk;
-	hwif2->rw_disk = promise_rw_disk;
-
-	/* Shift the remaining interfaces up by one */
-	for (i=MAX_HWIFS-1 ; i > hwif->index+1 ; i--) {
-		ide_hwif_t *h = &ide_hwifs[i];
-
-#ifdef DEBUG
-		printk(KERN_DEBUG "pdc4030: Shifting i/f %d values to i/f %d\n",i-1,i);
-#endif /* DEBUG */
-		ide_init_hwif_ports(&h->hw, (h-1)->io_ports[IDE_DATA_OFFSET], 0, NULL);
-		memcpy(h->io_ports, h->hw.io_ports, sizeof(h->io_ports));
-		h->noprobe = (h-1)->noprobe;
-	}
-	ide_init_hwif_ports(&hwif2->hw, hwif->io_ports[IDE_DATA_OFFSET], 0, NULL);
-	memcpy(hwif2->io_ports, hwif->hw.io_ports, sizeof(hwif2->io_ports));
-	hwif2->irq = hwif->irq;
-	hwif2->hw.irq = hwif->hw.irq = hwif->irq;
-	for (i=0; i<2 ; i++) {
-		hwif->drives[i].io_32bit = 3;
-		hwif2->drives[i].io_32bit = 3;
-		hwif->drives[i].keep_settings = 1;
-		hwif2->drives[i].keep_settings = 1;
-		if (!ident.current_tm[i].cyl)
-			hwif->drives[i].noprobe = 1;
-		if (!ident.current_tm[i+2].cyl)
-			hwif2->drives[i].noprobe = 1;
-	}
-
-	probe_hwif_init(&ide_hwifs[hwif->index]);
-	probe_hwif_init(&ide_hwifs[hwif2->index]);
-
-	return 1;
-}
-
-/*
- * detect_pdc4030()
- * Tests for the presence of a DC4030 Promise card on this interface
- * Returns: 1 if found, 0 if not found
- */
-int __init detect_pdc4030(ide_hwif_t *hwif)
-{
-	ide_drive_t *drive = &hwif->drives[0];
-
-	if (IDE_DATA_REG == 0) { /* Skip test for non-existent interface */
-		return 0;
-	}
-	hwif->OUTB(0xF3, IDE_SECTOR_REG);
-	hwif->OUTB(0x14, IDE_SELECT_REG);
-	hwif->OUTB(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
-
-	msleep(50);
-
-	if (hwif->INB(IDE_ERROR_REG) == 'P' &&
-	    hwif->INB(IDE_NSECTOR_REG) == 'T' &&
-	    hwif->INB(IDE_SECTOR_REG) == 'I') {
-		return 1;
-	} else {
-		return 0;
-	}
-}
-
-int __init pdc4030_init(void)
-{
-	unsigned int	index;
-	ide_hwif_t	*hwif;
-
-	for (index = 0; index < MAX_HWIFS; index++) {
-		hwif = &ide_hwifs[index];
-		if (hwif->chipset == ide_unknown && detect_pdc4030(hwif)) {
-			if (!setup_pdc4030(hwif))
-				return -ENODEV;
-			return 0;
-		}
-	}
-	return -ENODEV;
-}
-
-#ifdef MODULE
-module_init(pdc4030_init);
-#endif
-
-MODULE_AUTHOR("Peter Denison");
-MODULE_DESCRIPTION("Support of Promise 4030 VLB series IDE chipsets");
-MODULE_LICENSE("GPL");
-
-/*
- * promise_read_intr() is the handler for disk read/multread interrupts
- */
-static ide_startstop_t promise_read_intr (ide_drive_t *drive)
-{
-	unsigned int sectors_left, sectors_avail, nsect;
-	struct request *rq = HWGROUP(drive)->rq;
-	ata_status_t status;
-
-	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (!OK_STAT(status.all, DATA_READY, BAD_R_STAT))
-		return DRIVER(drive)->error(drive, __FUNCTION__, status.all);
-
-read_again:
-	do {
-		sectors_left = HWIF(drive)->INB(IDE_NSECTOR_REG);
-		HWIF(drive)->INB(IDE_SECTOR_REG);
-	} while (HWIF(drive)->INB(IDE_NSECTOR_REG) != sectors_left);
-	sectors_avail = rq->nr_sectors - sectors_left;
-	if (!sectors_avail)
-		goto read_again;
-
-read_next:
-	nsect = rq->current_nr_sectors;
-	if (nsect > sectors_avail)
-		nsect = sectors_avail;
-	sectors_avail -= nsect;
-
-#ifdef DEBUG_READ
-	printk(KERN_DEBUG "%s: %s: sectors(%lu-%lu), rem=%lu\n",
-			  drive->name, __FUNCTION__,
-			  (unsigned long)rq->sector,
-			  (unsigned long)rq->sector + nsect - 1,
-			  (unsigned long)rq->nr_sectors - nsect);
-#endif /* DEBUG_READ */
-
-	HWIF(drive)->ata_input_data(drive, rq->buffer, nsect * SECTOR_WORDS);
-	rq->buffer += nsect<<9;
-	rq->sector += nsect;
-	rq->errors = 0;
-	rq->nr_sectors -= nsect;
-	if (!rq->current_nr_sectors)
-		DRIVER(drive)->end_request(drive, 1, 0);
-
-/*
- * Now the data has been read in, do the following:
- * 
- * if there are still sectors left in the request, 
- *   if we know there are still sectors available from the interface,
- *     go back and read the next bit of the request.
- *   else if DRQ is asserted, there are more sectors available, so
- *     go back and find out how many, then read them in.
- *   else if BUSY is asserted, we are going to get an interrupt, so
- *     set the handler for the interrupt and just return
- */
-	if (rq->nr_sectors > 0) {
-		if (sectors_avail)
-			goto read_next;
-		status.all = HWIF(drive)->INB(IDE_STATUS_REG);
-		if (status.b.drq)
-			goto read_again;
-		if (status.b.bsy) {
-			if (HWGROUP(drive)->handler != NULL)
-				BUG();
-			ide_set_handler(drive,
-					&promise_read_intr,
-					WAIT_CMD,
-					NULL);
-#ifdef DEBUG_READ
-			printk(KERN_DEBUG "%s: promise_read: waiting for"
-			       "interrupt\n", drive->name);
-#endif /* DEBUG_READ */
-			return ide_started;
-		}
-		printk(KERN_ERR "%s: Eeek! promise_read_intr: sectors left "
-		       "!DRQ !BUSY\n", drive->name);
-		return DRIVER(drive)->error(drive,
-				"promise read intr", status.all);
-	}
-	return ide_stopped;
-}
-
-/*
- * promise_complete_pollfunc()
- * This is the polling function for waiting (nicely!) until drive stops
- * being busy. It is invoked at the end of a write, after the previous poll
- * has finished.
- *
- * Once not busy, the end request is called.
- */
-static ide_startstop_t promise_complete_pollfunc(ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	struct request *rq = &hwgroup->wrq;
-	struct bio *bio = rq->bio;
-
-	if ((HWIF(drive)->INB(IDE_STATUS_REG)) & BUSY_STAT) {
-		if (time_before(jiffies, hwgroup->poll_timeout)) {
-			if (hwgroup->handler != NULL)
-				BUG();
-			ide_set_handler(drive,
-					&promise_complete_pollfunc,
-					HZ/100,
-					NULL);
-			return ide_started; /* continue polling... */
-		}
-		hwgroup->poll_timeout = 0;
-		printk(KERN_ERR "%s: completion timeout - still busy!\n",
-		       drive->name);
-		return DRIVER(drive)->error(drive, "busy timeout",
-				HWIF(drive)->INB(IDE_STATUS_REG));
-	}
-
-	hwgroup->poll_timeout = 0;
-#ifdef DEBUG_WRITE
-	printk(KERN_DEBUG "%s: Write complete - end_request\n", drive->name);
-#endif /* DEBUG_WRITE */
-
-	bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-	rq = hwgroup->rq;
-	DRIVER(drive)->end_request(drive, 1, rq->hard_nr_sectors);
-
-	return ide_stopped;
-}
-
-/*
- * promise_multwrite() transfers a block of up to mcount sectors of data
- * to a drive as part of a disk multiple-sector write operation.
- */
-static void promise_multwrite (ide_drive_t *drive, unsigned int mcount)
-{
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	struct request *rq	= &hwgroup->wrq;
-
-	do {
-		char *buffer;
-		int nsect = rq->current_nr_sectors;
-
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-		buffer = rq->buffer;
-
-		rq->sector += nsect;
-		rq->buffer += nsect << 9;
-		rq->nr_sectors -= nsect;
-		rq->current_nr_sectors -= nsect;
-
-		/* Do we move to the next bh after this? */
-		if (!rq->current_nr_sectors) {
-			struct bio *bio = rq->bio;
-
-			/*
-			 * only move to next bio, when we have processed
-			 * all bvecs in this one.
-			 */
-			if (++bio->bi_idx >= bio->bi_vcnt) {
-				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-				bio = bio->bi_next;
-			}
-
-			/* end early early we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->nr_cbio_segments = bio_segments(bio);
-				rq->current_nr_sectors = bio_cur_sectors(bio);
-				rq->hard_cur_sectors = rq->current_nr_sectors;
-			}
-		}
-
-		/*
-		 * Ok, we're all setup for the interrupt
-		 * re-entering us on the last transfer.
-		 */
-		taskfile_output_data(drive, buffer, nsect<<7);
-	} while (mcount);
-}
-
-/*
- * promise_write_pollfunc() is the handler for disk write completion polling.
- */
-static ide_startstop_t promise_write_pollfunc (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	struct request *rq = &hwgroup->wrq;
-	struct bio *bio = rq->bio;
-
-	if (HWIF(drive)->INB(IDE_NSECTOR_REG) != 0) {
-		if (time_before(jiffies, hwgroup->poll_timeout)) {
-			if (hwgroup->handler != NULL)
-				BUG();
-			ide_set_handler(drive,
-					&promise_write_pollfunc,
-					HZ/100,
-					NULL);
-			return ide_started; /* continue polling... */
-		}
-		hwgroup->poll_timeout = 0;
-		printk(KERN_ERR "%s: write timed-out!\n",drive->name);
-		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-		return DRIVER(drive)->error(drive, "write timeout",
-				HWIF(drive)->INB(IDE_STATUS_REG));
-	}
-
-	/*
-	 * Now write out last 4 sectors and poll for not BUSY
-	 */
-	promise_multwrite(drive, 4);
-	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
-	if (hwgroup->handler != NULL)
-		BUG();
-	ide_set_handler(drive, &promise_complete_pollfunc, HZ/100, NULL);
-#ifdef DEBUG_WRITE
-	printk(KERN_DEBUG "%s: Done last 4 sectors - status = %02x\n",
-		drive->name, HWIF(drive)->INB(IDE_STATUS_REG));
-#endif /* DEBUG_WRITE */
-	return ide_started;
-}
-
-/*
- * promise_write() transfers a block of one or more sectors of data to a
- * drive as part of a disk write operation. All but 4 sectors are transferred
- * in the first attempt, then the interface is polled (nicely!) for completion
- * before the final 4 sectors are transferred. There is no interrupt generated
- * on writes (at least on the DC4030VL-2), we just have to poll for NOT BUSY.
- */
-static ide_startstop_t promise_write (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	struct request *rq = &hwgroup->wrq;
-
-#ifdef DEBUG_WRITE
-	printk(KERN_DEBUG "%s: %s: sectors(%lu-%lu)\n",
-			  drive->name, __FUNCTION__,
-			  (unsigned long)rq->sector,
-			  (unsigned long)rq->sector + rq->nr_sectors - 1);
-#endif /* DEBUG_WRITE */
-
-	/*
-	 * If there are more than 4 sectors to transfer, do n-4 then go into
-	 * the polling strategy as defined above.
-	 */
-	if (rq->nr_sectors > 4) {
-		promise_multwrite(drive, rq->nr_sectors - 4);
-		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
-		if (hwgroup->handler != NULL)	/* paranoia check */
-			BUG();
-		ide_set_handler (drive, &promise_write_pollfunc, HZ/100, NULL);
-		return ide_started;
-	} else {
-	/*
-	 * There are 4 or fewer sectors to transfer, do them all in one go
-	 * and wait for NOT BUSY.
-	 */
-		promise_multwrite(drive, rq->nr_sectors);
-		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
-		if (hwgroup->handler != NULL)
-			BUG();
-		ide_set_handler(drive,
-				&promise_complete_pollfunc,
-				HZ/100,
-				NULL);
-
-#ifdef DEBUG_WRITE
-		printk(KERN_DEBUG "%s: promise_write: <= 4 sectors, "
-			"status = %02x\n", drive->name,
-			HWIF(drive)->INB(IDE_STATUS_REG));
-#endif /* DEBUG_WRITE */
-		return ide_started;
-	}
-}
-
-/*
- * do_pdc4030_io() is called from promise_rw_disk, having had the block number
- * already set up. It issues a READ or WRITE command to the Promise
- * controller, assuming LBA has been used to set up the block number.
- */
-ide_startstop_t do_pdc4030_io (ide_drive_t *drive, struct request *rq)
-{
-	ide_startstop_t startstop;
-	unsigned long timeout;
-	u8 stat = 0;
-
-	if (rq_data_dir(rq) == READ) {
-		HWIF(drive)->OUTB(PROMISE_READ, IDE_COMMAND_REG);
-/*
- * The card's behaviour is odd at this point. If the data is
- * available, DRQ will be true, and no interrupt will be
- * generated by the card. If this is the case, we need to call the 
- * "interrupt" handler (promise_read_intr) directly. Otherwise, if
- * an interrupt is going to occur, bit0 of the SELECT register will
- * be high, so we can set the handler the just return and be interrupted.
- * If neither of these is the case, we wait for up to 50ms (badly I'm
- * afraid!) until one of them is.
- */
-		timeout = jiffies + HZ/20; /* 50ms wait */
-		do {
-			stat = HWIF(drive)->INB(IDE_STATUS_REG);
-			if (stat & DRQ_STAT) {
-				udelay(1);
-				return promise_read_intr(drive);
-			}
-			if (HWIF(drive)->INB(IDE_SELECT_REG) & 0x01) {
-#ifdef DEBUG_READ
-				printk(KERN_DEBUG "%s: read: waiting for "
-						"interrupt\n", drive->name);
-#endif /* DEBUG_READ */
-				ide_set_handler(drive,
-						&promise_read_intr,
-						WAIT_CMD,
-						NULL);
-				return ide_started;
-			}
-			udelay(1);
-		} while (time_before(jiffies, timeout));
-
-		printk(KERN_ERR "%s: reading: No DRQ and not "
-				"waiting - Odd!\n", drive->name);
-		return ide_stopped;
-	} else {
-		HWIF(drive)->OUTB(PROMISE_WRITE, IDE_COMMAND_REG);
-		if (ide_wait_stat(&startstop, drive, DATA_READY,
-				drive->bad_wstat, WAIT_DRQ)) {
-			printk(KERN_ERR "%s: no DRQ after issuing "
-				"PROMISE_WRITE\n", drive->name);
-			return startstop;
-	    	}
-		if (!drive->unmask)
-			local_irq_disable();
-		HWGROUP(drive)->wrq = *rq; /* scratchpad */
-		return promise_write(drive);
-	}
-}
-
-static ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct
request *rq, sector_t block)
-{
-	/* The four drives on the two logical (one physical) interfaces
-	   are distinguished by writing the drive number (0-3) to the
-	   Feature register.
-	   FIXME: Is promise_selectproc now redundant??
-	*/
-	ide_hwif_t *hwif = HWIF(drive);
-	int drive_number = (hwif->channel << 1) + drive->select.b.unit;
-
-	BUG_ON(rq->nr_sectors > 127);
-
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	hwif->OUTB(drive_number, IDE_FEATURE_REG);
-	hwif->OUTB(rq->nr_sectors, IDE_NSECTOR_REG);
-	hwif->OUTB(block,IDE_SECTOR_REG);
-	hwif->OUTB(block>>=8,IDE_LCYL_REG);
-	hwif->OUTB(block>>=8,IDE_HCYL_REG);
-	hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
-
-	return do_pdc4030_io(drive, rq);
-}
diff -Nru a/drivers/ide/legacy/pdc4030.h b/drivers/ide/legacy/pdc4030.h
--- a/drivers/ide/legacy/pdc4030.h	2004-10-22 02:20:30 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,70 +0,0 @@
-/*
- *  linux/drivers/ide/legacy/pdc4030.h
- *
- *  Copyright (C) 1995-1998  Linus Torvalds & authors
- */
-
-/*
- * Principal author: Peter Denison <peterd@pnd-pc.demon.co.uk>
- */
-
-#ifndef IDE_PROMISE_H
-#define IDE_PROMISE_H
-
-#include <linux/config.h>
-
-#ifndef CONFIG_BLK_DEV_PDC4030
-# ifdef _IDE_DISK
-
-# define IS_PDC4030_DRIVE (0)	/* auto-NULLs out pdc4030 code */
-
-ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *,
unsigned long);
-
-ide_startstop_t promise_rw_disk(ide_drive_t *drive, struct request
*rq, unsigned long block)
-{
-        return ide_stopped;
-}
-# endif /* _IDE_DISK */
-#else /* CONFIG_BLK_DEV_PDC4030 */
-# ifdef _IDE_DISK
-#  define IS_PDC4030_DRIVE (HWIF(drive)->chipset == ide_pdc4030)
-
-ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *,
unsigned long);
-
-# endif /* _IDE_DISK */
-#endif /* CONFIG_BLK_DEV_PDC4030 */
-
-#ifdef __PROMISE_4030
-#define	PROMISE_EXTENDED_COMMAND	0xF0
-#define	PROMISE_READ			0xF2
-#define	PROMISE_WRITE			0xF3
-/* Extended commands - main command code = 0xf0 */
-#define	PROMISE_GET_CONFIG		0x10
-#define	PROMISE_IDENTIFY		0x20
-
-struct translation_mode {
-	u16	cyl;
-	u8	head;
-	u8	sect;
-};
-
-struct dc_ident {
-	u8	type;
-	u8	unknown1;
-	u8	hw_revision;
-	u8	firmware_major;
-	u8	firmware_minor;
-	u8	bios_address;
-	u8	irq;
-	u8	unknown2;
-	u16	cache_mem;
-	u16	unknown3;
-	u8	id[2];
-	u16	info;
-	struct translation_mode current_tm[4];
-	u8	pad[SECTOR_WORDS*4 - 32];
-};
-
-#endif /* __PROMISE_4030 */
-
-#endif /* IDE_PROMISE_H */
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2004-10-22 02:20:30 +02:00
+++ b/drivers/ide/pci/sgiioc4.c	2004-10-22 02:20:30 +02:00
@@ -602,7 +602,6 @@
 	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
 	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
 	hwif->swdma_mask = 0x2;
-	hwif->identify = NULL;
 	hwif->tuneproc = NULL;	/* Sets timing for PIO mode */
 	hwif->speedproc = NULL;	/* Sets timing for DMA &/or PIO modes */
 	hwif->selectproc = NULL;/* Use the default routine to select drive */
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	2004-10-22 02:20:30 +02:00
+++ b/include/linux/blkdev.h	2004-10-22 02:20:30 +02:00
@@ -125,13 +125,7 @@
 	/* no. of sectors left to complete in the current segment */
 	unsigned int hard_cur_sectors;
 
-	/* no. of segments left to submit in the current bio */
-	unsigned short nr_cbio_segments;
-	/* no. of sectors left to submit in the current bio */
-	unsigned long nr_cbio_sectors;
-
-	struct bio *cbio;		/* next bio to submit */
-	struct bio *bio;		/* next unfinished bio to complete */
+	struct bio *bio;
 	struct bio *biotail;
 
 	void *elevator_private;
@@ -465,32 +459,6 @@
  */
 #define blk_queue_headactive(q, head_active)
 
-/* current index into bio being processed for submission */
-#define blk_rq_idx(rq)	((rq)->cbio->bi_vcnt - (rq)->nr_cbio_segments)
-
-/* current bio vector being processed */
-#define blk_rq_vec(rq)	(bio_iovec_idx((rq)->cbio, blk_rq_idx(rq)))
-
-/* current offset with respect to start of the segment being submitted */
-#define blk_rq_offset(rq) \
-	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
-
-/*
- * temporarily mapping a (possible) highmem bio (typically for PIO transfer)
- */
-
-/* Assumes rq->cbio != NULL */
-static inline char * rq_map_buffer(struct request *rq, unsigned long *flags)
-{
-	return (__bio_kmap_irq(rq->cbio, blk_rq_idx(rq), flags)
-		+ blk_rq_offset(rq));
-}
-
-static inline void rq_unmap_buffer(char *buffer, unsigned long *flags)
-{
-	__bio_kunmap_irq(buffer, flags);
-}
-
 /*
  * q->prep_rq_fn return values
  */
@@ -589,7 +557,6 @@
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
 extern void end_that_request_last(struct request *);
-extern int process_that_request_first(struct request *, unsigned int);
 extern void end_request(struct request *req, int uptodate);
 
 /*
@@ -660,7 +627,6 @@
 extern long blk_congestion_wait(int rw, long timeout);
 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
-extern void blk_rq_prep_restart(struct request *);
 extern int blkdev_issue_flush(struct block_device *, sector_t *);
 
 #define MAX_PHYS_SEGMENTS 128
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-22 02:20:30 +02:00
+++ b/include/linux/ide.h	2004-10-22 02:20:30 +02:00
@@ -242,7 +242,7 @@
 typedef enum {	ide_unknown,	ide_generic,	ide_pci,
 		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
-		ide_pdc4030,	ide_rz1000,	ide_trm290,
+		ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
 		ide_forced
@@ -832,8 +832,6 @@
 #if 0
 	ide_hwif_ops_t	*hwifops;
 #else
-	/* routine is for HBA specific IDENTITY operations */
-	int	(*identify)(ide_drive_t *);
 	/* routine to tune PIO mode for drives */
 	void	(*tuneproc)(ide_drive_t *, u8);
 	/* routine to retune DMA modes for drives */

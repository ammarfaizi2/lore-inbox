Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUJTRyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUJTRyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUJTRyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:54:18 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:59819 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268693AbUJTRmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:42:09 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=JQz/D+cm43h3/Y4lv7THTCM4tZSTsBb9ocb+TBWurCkWRwDh5zsqB2HJdq5el1UZ0NVOX8KZTLIEgRJKLASu/ZR/IcYK2yJw8k7pJFFeShUy981podZ2uECXW0MCSbxt+yvpt7gjt6cloF3YExfm7lrtCSzQiiyTqcoPZqd5N4o
Message-ID: <58cb370e041020104214af06bd@mail.gmail.com>
Date: Wed, 20 Oct 2004 19:42:09 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: torvalds@osdl.org, akpm@osdl.org
Subject: [BK PATCHES] ide-2.6 update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some more syncing with -mm:
* convert PIO code to use scatterlists
* unify ide-disk.c and ide-taskfile.c PIO code

Andrew, ide-dev will break again for a short moment.
I'll send you mail when it is fixed.

Linus, please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 Documentation/block/biodoc.txt   |    3 
 arch/cris/arch-v10/drivers/ide.c |    4 
 drivers/ide/arm/icside.c         |   27 ---
 drivers/ide/ide-disk.c           |  273 ++++-----------------------------------
 drivers/ide/ide-dma.c            |   15 --
 drivers/ide/ide-io.c             |   37 +++++
 drivers/ide/ide-probe.c          |   10 +
 drivers/ide/ide-taskfile.c       |  149 +++++++++------------
 drivers/ide/ide.c                |    3 
 drivers/ide/pci/sgiioc4.c        |   10 -
 drivers/ide/ppc/pmac.c           |   70 ++++------
 include/linux/ide.h              |   59 +-------
 12 files changed, 194 insertions(+), 466 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/20 1.2016)
   [ide] unify PIO code
   
   Use PIO code from ide-taskfile.c in ide-disk.c so:
   * drive status is checked after PIO read
   * request is failed if invalid data phase
     is detected during PIO write
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/20 1.2015)
   [ide] ide-disk: unify PIO write/multiwrite code
   
   Merge multwrite_intr() into write_intr().
   
   The only change in functionality is that rq->errors is
   now also cleared for multiwrite PIO (if there is no error).
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/20 1.2014)
   [ide] sg PIO for fs requests
   
   Convert CONFIG_IDE_TASKFILE_IO=n code
   to use scatterlists for PIO transfers.
   
   Fixes longstanding 'data integrity on error'
   issue and makes barriers work with PIO.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/20 1.2013)
   [ide] sg PIO for taskfile requests
   
   Use scatterlists for taskfile based PIO transfers
   instead of directly walking rq->[bio,cbio] lists.
   
   If CONFIG_IDE_TASKFILE_IO is defined
   this code will be used for fs requests.
   
   ide_pio_sector() is based on ata_pio_sector()
   from libata-core.c so kudos to Jeff.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/20 1.2012)
   [ide] always allocate hwif->sg_table
   
   Allocate hwif->sg_table in hwif_init() so it can also be used for PIO.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/20 1.2011)
   [ide] pmac: use more ide_hwif_t fields
   
   Use dmatable_dma, sg_table, sg_nents and sg_dma_direction fields
   of ide_hwif_t and remove their equivalents from pmac_ide_hwif_t.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt	2004-10-20 19:31:17 +02:00
+++ b/Documentation/block/biodoc.txt	2004-10-20 19:31:17 +02:00
@@ -1172,8 +1172,7 @@
 while (IDE for example)), where the CPU is doing the actual data
 transfer a virtual mapping is needed. If the driver supports highmem I/O,
 (Sec 1.1, (ii) ) it needs to use __bio_kmap_atomic and bio_kmap_irq to
-temporarily map a bio into the virtual address space. See how IDE handles
-this with ide_map_buffer.
+temporarily map a bio into the virtual address space.
 
 
 8. Prior/Related/Impacted patches
diff -Nru a/arch/cris/arch-v10/drivers/ide.c b/arch/cris/arch-v10/drivers/ide.c
--- a/arch/cris/arch-v10/drivers/ide.c	2004-10-20 19:31:17 +02:00
+++ b/arch/cris/arch-v10/drivers/ide.c	2004-10-20 19:31:17 +02:00
@@ -297,8 +297,10 @@
 	}
 
 	/* set up the Etrax DMA descriptors */
-	if (e100_ide_build_dmatable(drive))
+	if (e100_ide_build_dmatable(drive)) {
+		ide_map_sg(drive, rq);
 		return 1;
+	}
 
 	return 0;
 }
diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/arm/icside.c	2004-10-20 19:31:17 +02:00
@@ -206,8 +206,6 @@
  * here, but we rely on the main IDE driver spotting that both
  * interfaces use the same IRQ, which should guarantee this.
  */
-#define NR_ENTRIES 256
-#define TABLE_SIZE (NR_ENTRIES * 8)
 
 static void icside_build_sglist(ide_drive_t *drive, struct request *rq)
 {
@@ -527,7 +525,7 @@
 	return 1;
 }
 
-static int icside_dma_init(ide_hwif_t *hwif)
+static void icside_dma_init(ide_hwif_t *hwif)
 {
 	int autodma = 0;
 
@@ -537,11 +535,6 @@
 
 	printk("    %s: SG-DMA", hwif->name);
 
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * NR_ENTRIES,
-				 GFP_KERNEL);
-	if (!hwif->sg_table)
-		goto failed;
-
 	hwif->atapi_dma		= 1;
 	hwif->mwdma_mask	= 7; /* MW0..2 */
 	hwif->swdma_mask	= 7; /* SW0..2 */
@@ -569,24 +562,9 @@
 	hwif->drives[1].autodma = hwif->autodma;
 
 	printk(" capable%s\n", hwif->autodma ? ", auto-enable" : "");
-
-	return 1;
-
-failed:
-	printk(" disabled, unable to allocate DMA table\n");
-	return 0;
-}
-
-static void icside_dma_exit(ide_hwif_t *hwif)
-{
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
-	}
 }
 #else
 #define icside_dma_init(hwif)	(0)
-#define icside_dma_exit(hwif)	do { } while (0)
 #endif
 
 static ide_hwif_t *icside_find_hwif(unsigned long dataport)
@@ -811,9 +789,6 @@
 
 	case ICS_TYPE_V6:
 		/* FIXME: tell IDE to stop using the interface */
-		icside_dma_exit(state->hwif[1]);
-		icside_dma_exit(state->hwif[0]);
-
 		if (ec->dma != NO_DMA)
 			free_dma(ec->dma);
 
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ide-disk.c	2004-10-20 19:31:17 +02:00
@@ -123,216 +123,6 @@
 #ifndef CONFIG_IDE_TASKFILE_IO
 
 /*
- * read_intr() is the handler for disk read/multread interrupts
- */
-static ide_startstop_t read_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u32 i = 0, nsect	= 0, msect = drive->mult_count;
-	struct request *rq;
-	unsigned long flags;
-	u8 stat;
-	char *to;
-
-	/* new way for dealing with premature shared PCI interrupts */
-	if (!OK_STAT(stat=hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "read_intr", stat);
-		}
-		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-		return ide_started;
-	}
-	
-read_next:
-	rq = HWGROUP(drive)->rq;
-	if (msect) {
-		if ((nsect = rq->current_nr_sectors) > msect)
-			nsect = msect;
-		msect -= nsect;
-	} else
-		nsect = 1;
-	to = ide_map_buffer(rq, &flags);
-	taskfile_input_data(drive, to, nsect * SECTOR_WORDS);
-#ifdef DEBUG
-	printk("%s:  read: sectors(%ld-%ld), buffer=0x%08lx, remaining=%ld\n",
-		drive->name, rq->sector, rq->sector+nsect-1,
-		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
-#endif
-	ide_unmap_buffer(rq, to, &flags);
-	rq->sector += nsect;
-	rq->errors = 0;
-	i = (rq->nr_sectors -= nsect);
-	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
-		ide_end_request(drive, 1, rq->hard_cur_sectors);
-	/*
-	 * Another BH Page walker and DATA INTEGRITY Questioned on ERROR.
-	 * If passed back up on multimode read, BAD DATA could be ACKED
-	 * to FILE SYSTEMS above ...
-	 */
-	if (i > 0) {
-		if (msect)
-			goto read_next;
-		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-                return ide_started;
-	}
-        return ide_stopped;
-}
-
-/*
- * write_intr() is the handler for disk write interrupts
- */
-static ide_startstop_t write_intr (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= hwgroup->rq;
-	u32 i = 0;
-	u8 stat;
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),
-			DRIVE_READY, drive->bad_wstat)) {
-		printk("%s: write_intr error1: nr_sectors=%ld, stat=0x%02x\n",
-			drive->name, rq->nr_sectors, stat);
-        } else {
-#ifdef DEBUG
-		printk("%s: write: sector %ld, buffer=0x%08lx, remaining=%ld\n",
-			drive->name, rq->sector, (unsigned long) rq->buffer,
-			rq->nr_sectors-1);
-#endif
-		if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
-			rq->sector++;
-			rq->errors = 0;
-			i = --rq->nr_sectors;
-			--rq->current_nr_sectors;
-			if (((long)rq->current_nr_sectors) <= 0)
-				ide_end_request(drive, 1, rq->hard_cur_sectors);
-			if (i > 0) {
-				unsigned long flags;
-				char *to = ide_map_buffer(rq, &flags);
-				taskfile_output_data(drive, to, SECTOR_WORDS);
-				ide_unmap_buffer(rq, to, &flags);
-				ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-                                return ide_started;
-			}
-                        return ide_stopped;
-		}
-		/* the original code did this here (?) */
-		return ide_stopped;
-	}
-	return DRIVER(drive)->error(drive, "write_intr", stat);
-}
-
-/*
- * ide_multwrite() transfers a block of up to mcount sectors of data
- * to a drive as part of a disk multiple-sector write operation.
- *
- * Note that we may be called from two contexts - __ide_do_rw_disk() context
- * and IRQ context. The IRQ can happen any time after we've output the
- * full "mcount" number of sectors, so we must make sure we update the
- * state _before_ we output the final part of the data!
- *
- * The update and return to BH is a BLOCK Layer Fakey to get more data
- * to satisfy the hardware atomic segment.  If the hardware atomic segment
- * is shorter or smaller than the BH segment then we should be OKAY.
- * This is only valid if we can rewind the rq->current_nr_sectors counter.
- */
-static void ide_multwrite(ide_drive_t *drive, unsigned int mcount)
-{
- 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
- 	struct request *rq	= &hwgroup->wrq;
- 
-  	do {
-  		char *buffer;
-  		int nsect = rq->current_nr_sectors;
-		unsigned long flags;
- 
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-		buffer = ide_map_buffer(rq, &flags);
-
-		rq->sector += nsect;
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
-		ide_unmap_buffer(rq, buffer, &flags);
-	} while (mcount);
-}
-
-/*
- * multwrite_intr() is the handler for disk multwrite interrupts
- */
-static ide_startstop_t multwrite_intr (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= &hwgroup->wrq;
-	struct bio *bio		= rq->bio;
-	u8 stat;
-
-	stat = hwif->INB(IDE_STATUS_REG);
-	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
-		if (stat & DRQ_STAT) {
-			/*
-			 *	The drive wants data. Remember rq is the copy
-			 *	of the request
-			 */
-			if (rq->nr_sectors) {
-				ide_multwrite(drive, drive->mult_count);
-				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-				return ide_started;
-			}
-		} else {
-			/*
-			 *	If the copy has all the blocks completed then
-			 *	we can end the original request.
-			 */
-			if (!rq->nr_sectors) {	/* all done? */
-				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-				rq = hwgroup->rq;
-				ide_end_request(drive, 1, rq->nr_sectors);
-				return ide_stopped;
-			}
-		}
-		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-		/* the original code did this here (?) */
-		return ide_stopped;
-	}
-	bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
-}
-
-/*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
  * It also takes care of issuing special DRIVE_CMDs.
@@ -352,6 +142,11 @@
 			dma = 0;
 	}
 
+	if (!dma) {
+		ide_init_sg_cmd(drive, rq);
+		ide_map_sg(drive, rq);
+	}
+
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
@@ -435,44 +230,33 @@
 			return ide_started;
 		}
 		/* fallback to PIO */
+		ide_init_sg_cmd(drive, rq);
 	}
 
 	if (rq_data_dir(rq) == READ) {
-		command = ((drive->mult_count) ?
-			   ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
-			   ((lba48) ? WIN_READ_EXT : WIN_READ));
-		ide_execute_command(drive, command, &read_intr, WAIT_CMD, NULL);
-		return ide_started;
-	} else {
-		ide_startstop_t startstop;
-
-		command = ((drive->mult_count) ?
-			   ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
-			   ((lba48) ? WIN_WRITE_EXT : WIN_WRITE));
-		hwif->OUTB(command, IDE_COMMAND_REG);
 
-		if (ide_wait_stat(&startstop, drive, DATA_READY,
-				drive->bad_wstat, WAIT_DRQ)) {
-			printk(KERN_ERR "%s: no DRQ after issuing %s\n",
-				drive->name,
-				drive->mult_count ? "MULTWRITE" : "WRITE");
-			return startstop;
-		}
-		if (!drive->unmask)
-			local_irq_disable();
 		if (drive->mult_count) {
-			ide_hwgroup_t *hwgroup = HWGROUP(drive);
+			hwif->data_phase = TASKFILE_MULTI_IN;
+			command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
+		} else {
+			hwif->data_phase = TASKFILE_IN;
+			command = lba48 ? WIN_READ_EXT : WIN_READ;
+		}
 
-			hwgroup->wrq = *rq; /* scratchpad */
-			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-			ide_multwrite(drive, drive->mult_count);
+		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
+		return ide_started;
+	} else {
+		if (drive->mult_count) {
+			hwif->data_phase = TASKFILE_MULTI_OUT;
+			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
 		} else {
-			unsigned long flags;
-			char *to = ide_map_buffer(rq, &flags);
-			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-			taskfile_output_data(drive, to, SECTOR_WORDS);
-			ide_unmap_buffer(rq, to, &flags);
+			hwif->data_phase = TASKFILE_OUT;
+			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
+
+		hwif->OUTB(command, IDE_COMMAND_REG);
+
+		pre_task_out_intr(drive, rq);
 		return ide_started;
 	}
 }
@@ -516,6 +300,11 @@
 			dma = 0;
 	}
 
+	if (!dma) {
+		ide_init_sg_cmd(drive, rq);
+		ide_map_sg(drive, rq);
+	}
+
 	if (rq_data_dir(rq) == READ) {
 		task->command_type = IDE_DRIVE_TASK_IN;
 		if (dma)
@@ -779,10 +568,6 @@
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
 	}
-#ifdef CONFIG_IDE_TASKFILE_IO
-	/* make rq completion pointers new submission pointers */
-	blk_rq_prep_restart(rq);
-#endif
 
 	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
 		/* other bits are useless when BUSY */
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ide-dma.c	2004-10-20 19:31:17 +02:00
@@ -610,8 +610,10 @@
 		reading = 1 << 3;
 
 	/* fall back to pio! */
-	if (!ide_build_dmatable(drive, rq))
+	if (!ide_build_dmatable(drive, rq)) {
+		ide_map_sg(drive, rq);
 		return 1;
+	}
 
 	/* PRD table */
 	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
@@ -810,10 +812,6 @@
 				    hwif->dmatable_dma);
 		hwif->dmatable_cpu = NULL;
 	}
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
-	}
 	return 1;
 }
 
@@ -846,15 +844,12 @@
 	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
 						  PRD_ENTRIES * PRD_BYTES,
 						  &hwif->dmatable_dma);
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
-				GFP_KERNEL);
 
-	if ((hwif->dmatable_cpu) && (hwif->sg_table))
+	if (hwif->dmatable_cpu)
 		return 0;
 
-	printk(KERN_ERR "%s: -- Error, unable to allocate%s%s table(s).\n",
+	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
 		(hwif->dmatable_cpu == NULL) ? " CPU" : "",
-		(hwif->sg_table == NULL) ?  " SG DMA" : " DMA",
 		hwif->cds->name);
 
 	ide_release_dma_engine(hwif);
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ide-io.c	2004-10-20 19:31:17 +02:00
@@ -47,6 +47,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/kmod.h>
+#include <linux/scatterlist.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -674,6 +675,31 @@
 
 EXPORT_SYMBOL(do_special);
 
+void ide_map_sg(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct scatterlist *sg = hwif->sg_table;
+
+	if ((rq->flags & REQ_DRIVE_TASKFILE) == 0) {
+		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
+	} else {
+		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
+		hwif->sg_nents = 1;
+	}
+}
+
+EXPORT_SYMBOL_GPL(ide_map_sg);
+
+void ide_init_sg_cmd(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = drive->hwif;
+
+	hwif->nsect = hwif->nleft = rq->nr_sectors;
+	hwif->cursg = hwif->cursg_ofs = 0;
+}
+
+EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
+
 /**
  *	execute_drive_command	-	issue special drive command
  *	@drive: the drive to issue th command on
@@ -696,6 +722,17 @@
 			goto done;
 
 		hwif->data_phase = args->data_phase;
+
+		switch (hwif->data_phase) {
+		case TASKFILE_MULTI_OUT:
+		case TASKFILE_OUT:
+		case TASKFILE_MULTI_IN:
+		case TASKFILE_IN:
+			ide_init_sg_cmd(drive, rq);
+			ide_map_sg(drive, rq);
+		default:
+			break;
+		}
 
 		if (args->tf_out_flags.all != 0) 
 			return flagged_taskfile(drive, args);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ide-probe.c	2004-10-20 19:31:17 +02:00
@@ -1246,6 +1246,16 @@
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
 
+	if (!hwif->sg_max_nents)
+		hwif->sg_max_nents = PRD_ENTRIES;
+
+	hwif->sg_table = kmalloc(sizeof(struct scatterlist)*hwif->sg_max_nents,
+				 GFP_KERNEL);
+	if (!hwif->sg_table) {
+		printk(KERN_ERR "%s: unable to allocate SG table.\n", hwif->name);
+		goto out;
+	}
+
 	if (alloc_disks(hwif) < 0)
 		goto out;
 	
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ide-taskfile.c	2004-10-20 19:31:17 +02:00
@@ -5,7 +5,7 @@
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2001-2002	Klaus Smolin
  *					IBM Storage Technology Division
- *  Copyright (C) 2003		Bartlomiej Zolnierkiewicz
+ *  Copyright (C) 2003-2004	Bartlomiej Zolnierkiewicz
  *
  *  The big the bad and the ugly.
  *
@@ -253,73 +253,6 @@
 
 EXPORT_SYMBOL(task_no_data_intr);
 
-static void task_buffer_sectors(ide_drive_t *drive, struct request *rq,
-				unsigned nsect, unsigned rw)
-{
-	char *buf = rq->buffer + blk_rq_offset(rq);
-
-	rq->sector += nsect;
-	rq->current_nr_sectors -= nsect;
-	rq->nr_sectors -= nsect;
-	__task_sectors(drive, buf, nsect, rw);
-}
-
-static inline void task_buffer_multi_sectors(ide_drive_t *drive,
-					     struct request *rq, unsigned rw)
-{
-	unsigned int msect = drive->mult_count, nsect;
-
-	nsect = rq->current_nr_sectors;
-	if (nsect > msect)
-		nsect = msect;
-
-	task_buffer_sectors(drive, rq, nsect, rw);
-}
-
-#ifdef CONFIG_IDE_TASKFILE_IO
-static void task_sectors(ide_drive_t *drive, struct request *rq,
-			 unsigned nsect, unsigned rw)
-{
-	if (rq->cbio) {	/* fs request */
-		rq->errors = 0;
-		task_bio_sectors(drive, rq, nsect, rw);
-	} else		/* task request */
-		task_buffer_sectors(drive, rq, nsect, rw);
-}
-
-static inline void task_bio_multi_sectors(ide_drive_t *drive,
-					  struct request *rq, unsigned rw)
-{
-	unsigned int nsect, msect = drive->mult_count;
-
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-
-		task_bio_sectors(drive, rq, nsect, rw);
-
-		if (!rq->nr_sectors)
-			msect = 0;
-		else
-			msect -= nsect;
-	} while (msect);
-}
-
-static void task_multi_sectors(ide_drive_t *drive,
-			       struct request *rq, unsigned rw)
-{
-	if (rq->cbio) {	/* fs request */
-		rq->errors = 0;
-		task_bio_multi_sectors(drive, rq, rw);
-	} else		/* task request */
-		task_buffer_multi_sectors(drive, rq, rw);
-}
-#else
-# define task_sectors(d, rq, nsect, rw)	task_buffer_sectors(d, rq, nsect, rw)
-# define task_multi_sectors(d, rq, rw)	task_buffer_multi_sectors(d, rq, rw)
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -340,37 +273,86 @@
 	return stat;
 }
 
+static void ide_pio_sector(ide_drive_t *drive, unsigned int write)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct scatterlist *sg = hwif->sg_table;
+	struct page *page;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
+	u8 *buf;
+
+	page = sg[hwif->cursg].page;
+#ifdef CONFIG_HIGHMEM
+	local_irq_save(flags);
+#endif
+	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) +
+	      sg[hwif->cursg].offset + (hwif->cursg_ofs * SECTOR_SIZE);
+
+	hwif->nleft--;
+	hwif->cursg_ofs++;
+
+	if ((hwif->cursg_ofs * SECTOR_SIZE) == sg[hwif->cursg].length) {
+		hwif->cursg++;
+		hwif->cursg_ofs = 0;
+	}
+
+	/* do the actual data transfer */
+	if (write)
+		taskfile_output_data(drive, buf, SECTOR_WORDS);
+	else
+		taskfile_input_data(drive, buf, SECTOR_WORDS);
+
+	kunmap_atomic(page, KM_BIO_SRC_IRQ);
+#ifdef CONFIG_HIGHMEM
+	local_irq_restore(flags);
+#endif
+}
+
+static void ide_pio_multi(ide_drive_t *drive, unsigned int write)
+{
+	unsigned int nsect;
+
+	nsect = min_t(unsigned int, drive->hwif->nleft, drive->mult_count);
+	while (nsect--)
+		ide_pio_sector(drive, write);
+}
+
 static inline void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
+	if (rq->bio)	/* fs request */
+		rq->errors = 0;
+
 	switch (drive->hwif->data_phase) {
 	case TASKFILE_MULTI_IN:
 	case TASKFILE_MULTI_OUT:
-		task_multi_sectors(drive, rq, write);
+		ide_pio_multi(drive, write);
 		break;
 	default:
-		task_sectors(drive, rq, 1, write);
+		ide_pio_sector(drive, write);
 		break;
 	}
 }
 
-#ifdef CONFIG_IDE_TASKFILE_IO
 static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
 				  const char *s, u8 stat)
 {
 	if (rq->bio) {
-		int sectors = rq->hard_nr_sectors - rq->nr_sectors;
+		ide_hwif_t *hwif = drive->hwif;
+		int sectors = hwif->nsect - hwif->nleft;
 
-		switch (drive->hwif->data_phase) {
+		switch (hwif->data_phase) {
 		case TASKFILE_IN:
-			if (rq->nr_sectors)
+			if (hwif->nleft)
 				break;
 			/* fall through */
 		case TASKFILE_OUT:
 			sectors--;
 			break;
 		case TASKFILE_MULTI_IN:
-			if (rq->nr_sectors)
+			if (hwif->nleft)
 				break;
 			/* fall through */
 		case TASKFILE_MULTI_OUT:
@@ -384,9 +366,6 @@
 	}
 	return drive->driver->error(drive, s, stat);
 }
-#else
-# define task_error(d, rq, s, stat) drive->driver->error(d, s, stat)
-#endif
 
 static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
@@ -407,9 +386,11 @@
  */
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat = HWIF(drive)->INB(IDE_STATUS_REG);
+	u8 stat = hwif->INB(IDE_STATUS_REG);
 
+	/* new way for dealing with premature shared PCI interrupts */
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
@@ -421,7 +402,7 @@
 	ide_pio_datablock(drive, rq, 0);
 
 	/* If it was the last datablock check status and finish transfer. */
-	if (!rq->nr_sectors) {
+	if (!hwif->nleft) {
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
@@ -441,18 +422,18 @@
  */
 ide_startstop_t task_out_intr (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat;
+	u8 stat = hwif->INB(IDE_STATUS_REG);
 
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
 		return task_error(drive, rq, __FUNCTION__, stat);
 
 	/* Deal with unexpected ATA data phase. */
-	if (((stat & DRQ_STAT) == 0) ^ !rq->nr_sectors)
+	if (((stat & DRQ_STAT) == 0) ^ !hwif->nleft)
 		return task_error(drive, rq, __FUNCTION__, stat);
 
-	if (!rq->nr_sectors) {
+	if (!hwif->nleft) {
 		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ide.c	2004-10-20 19:31:17 +02:00
@@ -712,6 +712,8 @@
 	hwif->INSW			= tmp_hwif->INSW;
 	hwif->INSL			= tmp_hwif->INSL;
 
+	hwif->sg_max_nents		= tmp_hwif->sg_max_nents;
+
 	hwif->mmio			= tmp_hwif->mmio;
 	hwif->rqsize			= tmp_hwif->rqsize;
 	hwif->no_lba48			= tmp_hwif->no_lba48;
@@ -900,6 +902,7 @@
 		hwif->drives[i].disk = NULL;
 		put_disk(disk);
 	}
+	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
 	spin_lock_irq(&ide_lock);
 
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/pci/sgiioc4.c	2004-10-20 19:31:17 +02:00
@@ -404,11 +404,7 @@
 	if (!hwif->dmatable_cpu)
 		goto dma_alloc_failure;
 
-	hwif->sg_table =
-	    kmalloc(sizeof (struct scatterlist) * IOC4_PRD_ENTRIES, GFP_KERNEL);
-
-	if (!hwif->sg_table)
-		goto dma_sgalloc_failure;
+	hwif->sg_max_nents = IOC4_PRD_ENTRIES;
 
 	hwif->dma_base2 = (unsigned long)
 		pci_alloc_consistent(hwif->pci_dev,
@@ -421,9 +417,6 @@
 	return;
 
 dma_base2alloc_failure:
-	kfree(hwif->sg_table);
-
-dma_sgalloc_failure:
 	pci_free_consistent(hwif->pci_dev,
 			    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 			    hwif->dmatable_cpu, hwif->dmatable_dma);
@@ -584,6 +577,7 @@
 
 	if (!(count = sgiioc4_build_dma_table(drive, rq, ddir))) {
 		/* try PIO instead of DMA */
+		ide_map_sg(drive, rq);
 		return 1;
 	}
 
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2004-10-20 19:31:17 +02:00
+++ b/drivers/ide/ppc/pmac.c	2004-10-20 19:31:17 +02:00
@@ -78,10 +78,6 @@
 	 */
 	volatile struct dbdma_regs __iomem *	dma_regs;
 	struct dbdma_cmd*		dma_table_cpu;
-	dma_addr_t			dma_table_dma;
-	struct scatterlist*		sg_table;
-	int				sg_nents;
-	int				sg_dma_direction;
 #endif
 	
 } pmac_ide_hwif_t;
@@ -1245,6 +1241,8 @@
 		hwif->noprobe = 0;
 #endif /* CONFIG_PMAC_PBOOK */
 
+	hwif->sg_max_nents = MAX_DCMDS;
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* has a DBDMA controller channel */
 	if (pmif->dma_regs)
@@ -1562,26 +1560,23 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 /*
- * This is very close to the generic ide-dma version of the function except
- * that we don't use the fields in the hwif but our own copies for sg_table
- * and friends. We build & map the sglist for a given request
+ * We build & map the sglist for a given request.
  */
 static int __pmac
 pmac_ide_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t *pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	struct scatterlist *sg = pmif->sg_table;
+	struct scatterlist *sg = hwif->sg_table;
 	int nents;
 
 	nents = blk_rq_map_sg(drive->queue, rq, sg);
 		
 	if (rq_data_dir(rq) == READ)
-		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
-		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
 /*
@@ -1591,18 +1586,17 @@
 pmac_ide_raw_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	pmac_ide_hwif_t *pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	struct scatterlist *sg = pmif->sg_table;
+	struct scatterlist *sg = hwif->sg_table;
 	int nents = 0;
 	ide_task_t *args = rq->special;
 	unsigned char *virt_addr = rq->buffer;
 	int sector_count = rq->nr_sectors;
 
 	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
 	else
-		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-	
+		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
 	if (sector_count > 128) {
 		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
@@ -1611,8 +1605,8 @@
 	}
 	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
-   
-	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
 /*
@@ -1640,14 +1634,14 @@
 
 	/* Build sglist */
 	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
-		pmif->sg_nents = i = pmac_ide_raw_build_sglist(drive, rq);
+		hwif->sg_nents = i = pmac_ide_raw_build_sglist(drive, rq);
 	else
-		pmif->sg_nents = i = pmac_ide_build_sglist(drive, rq);
+		hwif->sg_nents = i = pmac_ide_build_sglist(drive, rq);
 	if (!i)
 		return 0;
 
 	/* Build DBDMA commands list */
-	sg = pmif->sg_table;
+	sg = hwif->sg_table;
 	while (i && sg_dma_len(sg)) {
 		u32 cur_addr;
 		u32 cur_len;
@@ -1692,16 +1686,16 @@
 		memset(table, 0, sizeof(struct dbdma_cmd));
 		st_le16(&table->command, DBDMA_STOP);
 		mb();
-		writel(pmif->dma_table_dma, &dma->cmdptr);
+		writel(hwif->dmatable_dma, &dma->cmdptr);
 		return 1;
 	}
 
 	printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
  use_pio_instead:
 	pci_unmap_sg(hwif->pci_dev,
-		     pmif->sg_table,
-		     pmif->sg_nents,
-		     pmif->sg_dma_direction);
+		     hwif->sg_table,
+		     hwif->sg_nents,
+		     hwif->sg_dma_direction);
 	return 0; /* revert to PIO for this request */
 }
 
@@ -1709,14 +1703,14 @@
 static void __pmac
 pmac_ide_destroy_dmatable (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct pci_dev *dev = HWIF(drive)->pci_dev;
-	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
-	struct scatterlist *sg = pmif->sg_table;
-	int nents = pmif->sg_nents;
+	struct scatterlist *sg = hwif->sg_table;
+	int nents = hwif->sg_nents;
 
 	if (nents) {
-		pci_unmap_sg(dev, sg, nents, pmif->sg_dma_direction);
-		pmif->sg_nents = 0;
+		pci_unmap_sg(dev, sg, nents, hwif->sg_dma_direction);
+		hwif->sg_nents = 0;
 	}
 }
 
@@ -1891,8 +1885,10 @@
 		return 1;
 	ata4 = (pmif->kind == controller_kl_ata4);	
 
-	if (!pmac_ide_build_dmatable(drive, rq))
+	if (!pmac_ide_build_dmatable(drive, rq)) {
+		ide_map_sg(drive, rq);
 		return 1;
+	}
 
 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
@@ -2065,21 +2061,13 @@
 	pmif->dma_table_cpu = (struct dbdma_cmd*)pci_alloc_consistent(
 		hwif->pci_dev,
 		(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
-		&pmif->dma_table_dma);
+		&hwif->dmatable_dma);
 	if (pmif->dma_table_cpu == NULL) {
 		printk(KERN_ERR "%s: unable to allocate DMA command list\n",
 		       hwif->name);
 		return;
 	}
 
-	pmif->sg_table = kmalloc(sizeof(struct scatterlist) * MAX_DCMDS,
-				 GFP_KERNEL);
-	if (pmif->sg_table == NULL) {
-		pci_free_consistent(	hwif->pci_dev,
-					(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
-				    	pmif->dma_table_cpu, pmif->dma_table_dma);
-		return;
-	}
 	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-20 19:31:17 +02:00
+++ b/include/linux/ide.h	2004-10-20 19:31:17 +02:00
@@ -789,27 +789,6 @@
 	struct gendisk *disk;
 } ide_drive_t;
 
-/*
- * mapping stuff, prepare for highmem...
- * 
- * temporarily mapping a (possible) highmem bio for PIO transfer
- */
-#ifndef CONFIG_IDE_TASKFILE_IO
-
-#define ide_rq_offset(rq) \
-	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
-
-static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
-{
-	return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
-}
-
-static inline void ide_unmap_buffer(struct request *rq, char *buffer,
unsigned long *flags)
-{
-	bio_kunmap_irq(buffer, flags);
-}
-#endif /* !CONFIG_IDE_TASKFILE_IO */
-
 #define IDE_CHIPSET_PCI_MASK	\
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
@@ -920,12 +899,18 @@
 	dma_addr_t	dmatable_dma;
 	/* Scatter-gather list used to build the above */
 	struct scatterlist *sg_table;
+	int sg_max_nents;		/* Maximum number of entries in it */
 	int sg_nents;			/* Current number of entries in it */
 	int sg_dma_direction;		/* dma transfer direction */
 
 	/* data phase of the active command (currently only valid for PIO/DMA) */
 	int		data_phase;
 
+	unsigned int nsect;
+	unsigned int nleft;
+	unsigned int cursg;
+	unsigned int cursg_ofs;
+
 	int		mmio;		/* hosts iomio (0) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
@@ -1369,35 +1354,6 @@
 extern void taskfile_input_data(ide_drive_t *, void *, u32);
 extern void taskfile_output_data(ide_drive_t *, void *, u32);
 
-#define IDE_PIO_IN	0
-#define IDE_PIO_OUT	1
-
-static inline void __task_sectors(ide_drive_t *drive, char *buf,
-				  unsigned nsect, unsigned rw)
-{
-	/*
-	 * IRQ can happen instantly after reading/writing
-	 * last sector of the datablock.
-	 */
-	if (rw == IDE_PIO_OUT)
-		taskfile_output_data(drive, buf, nsect * SECTOR_WORDS);
-	else
-		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);
-}
-
-#ifdef CONFIG_IDE_TASKFILE_IO
-static inline void task_bio_sectors(ide_drive_t *drive, struct request *rq,
-				    unsigned nsect, unsigned rw)
-{
-	unsigned long flags;
-	char *buf = rq_map_buffer(rq, &flags);
-
-	process_that_request_first(rq, nsect);
-	__task_sectors(drive, buf, nsect, rw);
-	rq_unmap_buffer(buf, &flags);
-}
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 
@@ -1527,6 +1483,9 @@
 
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 extern void ide_setup_pci_devices(struct pci_dev *, struct pci_dev *,
ide_pci_device_t *);
+
+void ide_map_sg(ide_drive_t *, struct request *);
+void ide_init_sg_cmd(ide_drive_t *, struct request *);
 
 #define BAD_DMA_DRIVE		0
 #define GOOD_DMA_DRIVE		1

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSHIL7A>; Fri, 9 Aug 2002 07:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHIL7A>; Fri, 9 Aug 2002 07:59:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30225 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318249AbSHIL6w>; Fri, 9 Aug 2002 07:58:52 -0400
Message-ID: <3D53AE13.7060907@evision.ag>
Date: Fri, 09 Aug 2002 13:57:07 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.30 IDE 115
Content-Type: multipart/mixed;
 boundary="------------030007080409020004010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007080409020004010207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix small typo introduced in 113, which prevented CD-ROMs from
   working altogether.

- Eliminate block_ioctl(). This code can't be shared in the way
   proposed by this file. We will port it to the proper
   blk_insert_request() soon. This will eliminate the _elv_add_request()
   "layering violation".

- Don't play IRQ wreck havoc in ata_dump().

- Fix delays on seeks in ide-cd.c

- Integrate special_intr() and tcq_nop_intr() in to one single IRQ
   handler. This way we don't have to kmalloc anything for sending a NOP
   to the drive in TCQ.

- Eliminate the usage of the XXX_handler from the ata_taskfile
   structure. Now we always deduce which handler will be needed from
   the command which will be executed. This makes the usage of the
   channel IRQ handler pointer much more cleaner now.

- Don't pass taskfiles through rq->special. Pass them through rq->cmd[]
   as every other block device does or at least should do. This way
   we don't pass pointers to structures on local stack around any more.

- pdc4030 code doesn't have anything to do with the normal taskfile
   stuff.

--------------030007080409020004010207
Content-Type: text/plain;
 name="ide-115.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-115.diff"

diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/block/block_ioctl.c linux/drivers/block/block_ioctl.c
--- linux-2.5.30/drivers/block/block_ioctl.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/block/block_ioctl.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,83 +0,0 @@
-/*
- * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
-
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public Licens
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
- *
- */
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/config.h>
-#include <linux/swap.h>
-#include <linux/init.h>
-#include <linux/smp_lock.h>
-#include <linux/module.h>
-#include <linux/blk.h>
-#include <linux/completion.h>
-
-#include <linux/cdrom.h>
-
-int blk_do_rq(request_queue_t *q, struct request *rq)
-{
-	DECLARE_COMPLETION(wait);
-	int err = 0;
-
-	rq->flags |= REQ_NOMERGE;
-	rq->waiting = &wait;
-	elv_add_request(q, rq, 1);
-	generic_unplug_device(q);
-	wait_for_completion(&wait);
-
-	/*
-	 * for now, never retry anything
-	 */
-	if (rq->errors)
-		err = -EIO;
-
-	return err;
-}
-
-int block_ioctl(struct block_device *bdev, unsigned int cmd, unsigned long arg)
-{
-	request_queue_t *q;
-	struct request *rq;
-	int close = 0, err;
-
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
-	switch (cmd) {
-		case CDROMCLOSETRAY:
-			close = 1;
-		case CDROMEJECT:
-			rq = blk_get_request(q, WRITE, __GFP_WAIT);
-			rq->flags = REQ_BLOCK_PC;
-			memset(rq->cmd, 0, sizeof(rq->cmd));
-			rq->cmd[0] = GPCMD_START_STOP_UNIT;
-			rq->cmd[4] = 0x02 + (close != 0);
-			err = blk_do_rq(q, rq);
-			blk_put_request(rq);
-			break;
-		default:
-			err = -ENOTTY;
-	}
-
-	blk_put_queue(q);
-	return err;
-}
-
-EXPORT_SYMBOL(block_ioctl);
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/block/Makefile linux/drivers/block/Makefile
--- linux-2.5.30/drivers/block/Makefile	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/block/Makefile	2002-08-06 18:02:03.000000000 +0200
@@ -8,10 +8,9 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o genhd.o \
-		   block_ioctl.o acsi.o
+export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o genhd.o acsi.o
 
-obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.30/drivers/ide/ide.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-08-09 09:51:24.000000000 +0200
@@ -233,12 +233,12 @@ static inline u32 read_24(struct ata_dev
 
 #if FANCY_STATUS_DUMPS
 struct ata_bit_messages {
-	u8 mask;
-	u8 match;
+	const u8 mask;
+	const u8 match;
 	const char *msg;
 };
 
-static struct ata_bit_messages ata_status_msgs[] = {
+static const struct ata_bit_messages ata_status_msgs[] = {
 	{ BUSY_STAT,  BUSY_STAT,  "busy"            },
 	{ READY_STAT, READY_STAT, "drive ready"     },
 	{ WRERR_STAT, WRERR_STAT, "device fault"    },
@@ -249,7 +249,7 @@ static struct ata_bit_messages ata_statu
 	{ ERR_STAT,   ERR_STAT,   "error"           }
 };
 
-static struct ata_bit_messages ata_error_msgs[] = {
+static const struct ata_bit_messages ata_error_msgs[] = {
 	{ ICRC_ERR|ABRT_ERR,	ABRT_ERR,		"drive status error"	},
 	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR,		"bad sector"		},
 	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR|ABRT_ERR,	"invalid checksum"	},
@@ -259,22 +259,23 @@ static struct ata_bit_messages ata_error
 	{ MARK_ERR,		MARK_ERR,		"addr mark not found"   }
 };
 
-static void dump_bits(struct ata_bit_messages *msgs, int nr, u8 bits)
+static void dump_bits(const struct ata_bit_messages *msgs, int n, u8 bits)
 {
 	int i;
 	int first = 1;
 
 	printk(" [ ");
 
-	for (i = 0; i < nr; i++, msgs++)
+	for (i = 0; i < n; i++, msgs++) {
 		if ((bits & msgs->mask) == msgs->match) {
 			if (!first)
-				printk(",");
+				printk(", ");
 			printk("%s", msgs->msg);
 			first = 0;
 		}
+	}
 
-	printk("] ");
+	printk(" ] ");
 }
 #else
 # define dump_bits(msgs,nr,bits) do { } while (0)
@@ -285,13 +286,8 @@ static void dump_bits(struct ata_bit_mes
  */
 u8 ata_dump(struct ata_device *drive, struct request * rq, const char *msg)
 {
-	unsigned long flags;
 	u8 err = 0;
 
-	/* FIXME:  --bzolnier */
-	local_save_flags(flags);
-	local_irq_enable();
-
 	printk("%s: %s: status=0x%02x", drive->name, msg, drive->status);
 	dump_bits(ata_status_msgs, ARRAY_SIZE(ata_status_msgs), drive->status);
 	printk("\n");
@@ -338,7 +334,6 @@ u8 ata_dump(struct ata_device *drive, st
 #endif
 		printk("\n");
 	}
-	local_irq_restore (flags);
 
 	return err;
 }
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.30/drivers/ide/ide-cd.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-08-09 10:05:54.000000000 +0200
@@ -306,6 +306,7 @@
 #include <linux/errno.h>
 #include <linux/cdrom.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 
@@ -1617,11 +1618,16 @@ ide_cdrom_do_request(struct ata_device *
 
 	if (rq->flags & REQ_CMD) {
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
-			if (ATA_OP_READY != ata_status_poll(drive, SEEK_STAT, 0, IDECD_SEEK_TIMEOUT, rq)) {
+			unsigned long elpased = jiffies - info->start_seek;
+
+			if (!ata_status(drive, SEEK_STAT, 0)) {
+				if (elpased < IDECD_SEEK_TIMEOUT) {
+					udelay(IDECD_SEEK_TIMER / HZ);
+					return ATA_OP_FINISHED;
+				}
 				printk ("%s: DSC timeout\n", drive->name);
-				CDROM_CONFIG_FLAGS(drive)->seeking = 0;
-			} else
-				return ATA_OP_FINISHED;
+			}
+			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			ret = cdrom_start_seek(drive, rq, block);
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.30/drivers/ide/ide-disk.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-08-08 08:27:07.000000000 +0200
@@ -40,7 +40,7 @@
 #endif
 
 /*
- * for now, taskfile requests are special :/
+ * For now, taskfile requests are special :/
  */
 static inline char *ide_map_rq(struct request *rq, unsigned long *flags)
 {
@@ -328,6 +328,58 @@ static ide_startstop_t task_mulout_intr(
 }
 
 /*
+ * Invoked on completion of a special REQ_SPECIAL command.
+ */
+static ide_startstop_t special_intr(struct ata_device *drive, struct request *rq) {
+	unsigned long flags;
+	struct ata_channel *ch =drive->channel;
+	struct ata_taskfile *ar = (struct ata_taskfile *) rq->cmd;
+	ide_startstop_t ret = ATA_OP_FINISHED;
+
+	local_irq_enable();
+
+	/* Keep quiet for NOP because it is expected to fail. */
+	if (ar->cmd != WIN_NOP) {
+		if (rq->buffer && ar->taskfile.sector_number) {
+			if (!ata_status(drive, 0, DRQ_STAT) && ar->taskfile.sector_number) {
+				int retries = 10;
+
+				ata_read(drive, rq->buffer, ar->taskfile.sector_number * SECTOR_WORDS);
+
+				while (!ata_status(drive, 0, BUSY_STAT) && retries--)
+					udelay(100);
+			}
+		}
+
+		if (!ata_status(drive, READY_STAT, BAD_STAT)) {
+			ret = ata_error(drive, rq, __FUNCTION__);
+			rq->errors = 1;
+		}
+
+		ar->taskfile.feature = IN_BYTE(IDE_ERROR_REG);
+		ata_in_regfile(drive, &ar->taskfile);
+		ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
+		if ((drive->id->command_set_2 & 0x0400) &&
+				(drive->id->cfs_enable_2 & 0x0400) &&
+				(drive->addressing == 1)) {
+			/* The following command goes to the hob file! */
+			OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
+			ar->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
+			ata_in_regfile(drive, &ar->hobfile);
+		}
+	}
+	spin_lock_irqsave(ch->lock, flags);
+
+	blkdev_dequeue_request(rq);
+	drive->rq = NULL;
+	end_that_request_last(rq);
+
+	spin_unlock_irqrestore(ch->lock, flags);
+
+	return ret;
+}
+
+/*
  * Issue a READ or WRITE command to a disk, using LBA if supported, or CHS
  * otherwise, to address sectors.  It also takes care of issuing special
  * DRIVE_CMDs.
@@ -338,12 +390,14 @@ static ide_startstop_t idedisk_do_reques
 	struct ata_taskfile *ar;
 	struct hd_driveid *id = drive->id;
 	u8 cmd;
+	ata_handler_t *handler = NULL;
 
 	/* Special drive commands don't need any kind of setup.
 	 */
 	if (rq->flags & REQ_SPECIAL) {
-		ar = rq->special;
-		cmd  = ar->cmd;
+		ar = (struct ata_taskfile *) rq->cmd;
+		cmd = ar->cmd;
+		handler = special_intr;
 	} else  {
 		unsigned int sectors;
 
@@ -460,10 +514,10 @@ static ide_startstop_t idedisk_do_reques
 				} else if (drive->using_dma) {
 					cmd = WIN_READDMA_EXT;
 				} else if (drive->mult_count) {
-					args.XXX_handler = task_mulin_intr;
+					handler = task_mulin_intr;
 					cmd = WIN_MULTREAD_EXT;
 				} else {
-					args.XXX_handler = task_in_intr;
+					handler = task_in_intr;
 					cmd = WIN_READ_EXT;
 				}
 			} else {
@@ -472,10 +526,10 @@ static ide_startstop_t idedisk_do_reques
 				} else if (drive->using_dma) {
 					cmd = WIN_READDMA;
 				} else if (drive->mult_count) {
-					args.XXX_handler = task_mulin_intr;
+					handler = task_mulin_intr;
 					cmd = WIN_MULTREAD;
 				} else {
-					args.XXX_handler = task_in_intr;
+					handler = task_in_intr;
 					cmd = WIN_READ;
 				}
 			}
@@ -487,10 +541,10 @@ static ide_startstop_t idedisk_do_reques
 				} else if (drive->using_dma) {
 					cmd = WIN_WRITEDMA_EXT;
 				} else if (drive->mult_count) {
-					args.XXX_handler = task_mulout_intr;
+					handler = task_mulout_intr;
 					cmd = WIN_MULTWRITE_EXT;
 				} else {
-					args.XXX_handler = task_out_intr;
+					handler = task_out_intr;
 					cmd = WIN_WRITE_EXT;
 				}
 			} else {
@@ -499,10 +553,10 @@ static ide_startstop_t idedisk_do_reques
 				} else if (drive->using_dma) {
 					cmd = WIN_WRITEDMA;
 				} else if (drive->mult_count) {
-					args.XXX_handler = task_mulout_intr;
+					handler = task_mulout_intr;
 					cmd = WIN_MULTWRITE;
 				} else {
-					args.XXX_handler = task_out_intr;
+					handler = task_out_intr;
 					cmd = WIN_WRITE;
 				}
 			}
@@ -516,7 +570,7 @@ static ide_startstop_t idedisk_do_reques
 		printk("buffer=%p\n", rq->buffer);
 #endif
 		ar->cmd = cmd;
-		rq->special = ar;
+		memcpy(rq->cmd, ar, sizeof(*ar));
 	}
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands.
@@ -539,11 +593,10 @@ static ide_startstop_t idedisk_do_reques
 
 	/* FIXME: this is actually distingushing between PIO and DMA requests.
 	 */
-	if (ar->XXX_handler) {
+	if (handler) {
 		if (ar->command_type == IDE_DRIVE_TASK_IN ||
 		    ar->command_type == IDE_DRIVE_TASK_NO_DATA) {
-
-			ata_set_handler(drive, ar->XXX_handler, WAIT_CMD, NULL);
+			ata_set_handler(drive, handler, WAIT_CMD, NULL);
 			OUT_BYTE(cmd, IDE_COMMAND_REG);
 
 			return ATA_OP_CONTINUES;
@@ -576,7 +629,7 @@ static ide_startstop_t idedisk_do_reques
 				unsigned long flags;
 				char *buf = ide_map_rq(rq, &flags);
 
-				ata_set_handler(drive, ar->XXX_handler, WAIT_CMD, NULL);
+				ata_set_handler(drive, handler, WAIT_CMD, NULL);
 
 				/* For Write_sectors we need to stuff the first sector */
 				/* FIXME: what if !rq->current_nr_sectors  --bzolnier */
@@ -614,7 +667,7 @@ static ide_startstop_t idedisk_do_reques
 				}
 
 				/* will set handler for us */
-				return ar->XXX_handler(drive, rq);
+				return handler(drive, rq);
 			}
 		}
 	} else {
@@ -625,10 +678,9 @@ static ide_startstop_t idedisk_do_reques
 		 * FIXME: Handle the alternateives by a command type.
 		 */
 
-		/* FIXME: ATA_OP_CONTINUES?  --bzolnier */
-		/* Not started a request - BUG() ot ATA_OP_FINISHED to avoid lockup ? - alat*/
+		/* Not started a request - BUG() on ATA_OP_FINISHED to avoid lockup ? - alat*/
 		if (!drive->using_dma)
-			return ATA_OP_CONTINUES;
+			return ATA_OP_FINISHED;
 
 		/* for dma commands we don't set the handler */
 		if (cmd == WIN_WRITEDMA ||
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.30/drivers/ide/ide-pci.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-08-08 05:51:50.000000000 +0200
@@ -236,7 +236,7 @@ static void __init setup_channel_dma(str
 /*
  * Setup a particular port on an ATA host controller.
  *
- * This gets called once for the master and for the slave interface.
+ * This gets called once for the primary and for the seondary interface.
  */
 static int __init setup_host_channel(struct pci_dev *dev,
 		struct ata_pci_device *d,
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.30/drivers/ide/ide-taskfile.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-08-08 08:03:04.000000000 +0200
@@ -70,12 +70,12 @@ static void ata_write_slow(struct ata_de
 
 static void ata_read_16(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
-	insw(IDE_DATA_REG, buffer, wcount<<1);
+	insw(IDE_DATA_REG, buffer, wcount << 1);
 }
 
 static void ata_write_16(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
-	outsw(IDE_DATA_REG, buffer, wcount<<1);
+	outsw(IDE_DATA_REG, buffer, wcount << 1);
 }
 
 /*
@@ -96,9 +96,9 @@ void ata_read(struct ata_device *drive, 
 
 	io_32bit = drive->channel->io_32bit;
 
-	if (io_32bit) {
+	if (io_32bit)
 		ata_read_32(drive, buffer, wcount);
-	} else {
+	else {
 #if SUPPORT_SLOW_DATA_PORTS
 		if (drive->channel->slow)
 			ata_read_slow(drive, buffer, wcount);
@@ -122,9 +122,9 @@ void ata_write(struct ata_device *drive,
 
 	io_32bit = drive->channel->io_32bit;
 
-	if (io_32bit) {
+	if (io_32bit)
 		ata_write_32(drive, buffer, wcount);
-	} else {
+	else {
 #if SUPPORT_SLOW_DATA_PORTS
 		if (drive->channel->slow)
 			ata_write_slow(drive, buffer, wcount);
@@ -134,58 +134,6 @@ void ata_write(struct ata_device *drive,
 	}
 }
 
-/*
- * Invoked on completion of a special REQ_SPECIAL command.
- */
-static ide_startstop_t special_intr(struct ata_device *drive, struct request *rq) {
-	unsigned long flags;
-	struct ata_channel *ch =drive->channel;
-	struct ata_taskfile *ar = rq->special;
-	ide_startstop_t ret = ATA_OP_FINISHED;
-
-	local_irq_enable();
-
-	if (rq->buffer && ar->taskfile.sector_number) {
-		if (!ata_status(drive, 0, DRQ_STAT) && ar->taskfile.sector_number) {
-			int retries = 10;
-
-			ata_read(drive, rq->buffer, ar->taskfile.sector_number * SECTOR_WORDS);
-
-			while (!ata_status(drive, 0, BUSY_STAT) && retries--)
-				udelay(100);
-		}
-	}
-
-	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
-		/* Keep quiet for NOP because it is expected to fail. */
-		if (ar->cmd != WIN_NOP)
-			ret = ata_error(drive, rq, __FUNCTION__);
-		rq->errors = 1;
-	}
-
-	ar->taskfile.feature = IN_BYTE(IDE_ERROR_REG);
-	ata_in_regfile(drive, &ar->taskfile);
-	ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
-	if ((drive->id->command_set_2 & 0x0400) &&
-			(drive->id->cfs_enable_2 & 0x0400) &&
-			(drive->addressing == 1)) {
-		/* The following command goes to the hob file! */
-		OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
-		ar->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
-		ata_in_regfile(drive, &ar->hobfile);
-	}
-
-	spin_lock_irqsave(ch->lock, flags);
-
-	blkdev_dequeue_request(rq);
-	drive->rq = NULL;
-	end_that_request_last(rq);
-
-	spin_unlock_irqrestore(ch->lock, flags);
-
-	return ret;
-}
-
 int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar, char *buf)
 {
 	struct request *rq;
@@ -205,13 +153,13 @@ int ide_raw_taskfile(struct ata_device *
 	rq->buffer = buf;
 	rq->rq_status = RQ_ACTIVE;
 	rq->waiting = &wait;
-
-	ar->XXX_handler = special_intr;
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
+	memcpy(rq->cmd, ar, sizeof(*ar));
 
 	blk_insert_request(q, rq, 1, ar);
 	wait_for_completion(&wait);
 
+	memcpy(ar, rq->cmd, sizeof(*ar));
 	errors = rq->errors;
 	blk_put_request(rq);
 
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.30/drivers/ide/ioctl.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-08-08 08:03:45.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/cdrom.h>
 #include <linux/device.h>
+#include <linux/completion.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 
@@ -104,6 +105,62 @@ static int do_cmd_ioctl(struct ata_devic
 }
 
 /*
+ * FIXME: First make this working here. Generalize later.  In esp. maintaining
+ * tight REQ_SPECIAL semantics in all the other drivers could turn out to be
+ * more difficulat then appears at the first glance.
+ */
+static int blk_do_rq(request_queue_t *q, struct request *rq)
+{
+	DECLARE_COMPLETION(wait);
+	int err = 0;
+
+	rq->flags |= REQ_NOMERGE;
+	rq->waiting = &wait;
+	elv_add_request(q, rq, 1);
+	generic_unplug_device(q);
+	wait_for_completion(&wait);
+
+	/*
+	 * for now, never retry anything
+	 */
+	if (rq->errors)
+		err = -EIO;
+
+	return err;
+}
+
+static int do_blk_ioctl(struct block_device *bdev, unsigned int cmd, unsigned long arg)
+{
+	request_queue_t *q;
+	struct request *rq;
+	int close = 0, err;
+
+	q = bdev_get_queue(bdev);
+	if (!q)
+		return -ENXIO;
+
+	switch (cmd) {
+		case CDROMCLOSETRAY:
+			close = 1;
+		case CDROMEJECT:
+			rq = blk_get_request(q, WRITE, __GFP_WAIT);
+			rq->flags = REQ_BLOCK_PC;
+			memset(rq->cmd, 0, sizeof(rq->cmd));
+			rq->cmd[0] = GPCMD_START_STOP_UNIT;
+			rq->cmd[4] = 0x02 + (close != 0);
+			err = blk_do_rq(q, rq);
+			blk_put_request(rq);
+			break;
+		default:
+			err = -ENOTTY;
+	}
+
+	blk_put_queue(q);
+
+	return err;
+}
+
+/*
  * NOTE: Due to ridiculous coding habbits in the hdparm utility we have to
  * always return unsigned long in case we are returning simple values.
  */
@@ -342,12 +399,9 @@ int ata_ioctl(struct inode *inode, struc
 
 			return do_cmd_ioctl(drive, arg);
 
-		/*
-		 * uniform packet command handling
-		 */
 		case CDROMEJECT:
 		case CDROMCLOSETRAY:
-			return block_ioctl(inode->i_bdev, cmd, arg);
+			return do_blk_ioctl(inode->i_bdev, cmd, arg);
 
 		case BLKRRPART: /* Re-read partition tables */
 			return ata_revalidate(inode->i_rdev);
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.30/drivers/ide/pcidma.c	2002-08-06 14:15:07.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-08-09 13:27:22.000000000 +0200
@@ -86,6 +86,26 @@ static ide_startstop_t dma_timer_expiry(
 	return ATA_OP_FINISHED;
 }
 
+int ata_start_dma(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	unsigned int reading = 0;
+
+	if (rq_data_dir(rq) == READ)
+		reading = 1 << 3;
+
+	/* try PIO instead of DMA */
+	if (!udma_new_table(drive, rq))
+		return 1;
+
+	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+
+	return 0;
+}
+
 /* generic udma_setup() function for drivers having ->speedproc/tuneproc */
 int udma_generic_setup(struct ata_device *drive, int map)
 {
@@ -468,11 +488,7 @@ int udma_pci_init(struct ata_device *dri
 
 	/* try PIO instead of DMA */
 	if (!udma_new_table(drive, rq))
-		return 1;
-
-	/* No DMA transfers on ATAPI devices. */
-	if (drive->type != ATA_DISK)
-		return ATA_OP_CONTINUES;
+		return ATA_OP_FINISHED;
 
 	if (rq_data_dir(rq) == READ)
 		cmd = 0x08;
@@ -483,6 +499,10 @@ int udma_pci_init(struct ata_device *dri
 	outb(cmd, dma_base);				/* specify r/w */
 	outb(inb(dma_base + 2) | 6, dma_base + 2);	/* clear INTR & ERROR flags */
 
+	/* No DMA transfers on ATAPI devices. */
+	if (drive->type != ATA_DISK)
+		return ATA_OP_CONTINUES;
+
 	ata_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);
 	if (drive->addressing)
 		outb(cmd ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.30/drivers/ide/pdc4030.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-08-08 08:19:38.000000000 +0200
@@ -619,9 +619,8 @@ static ide_startstop_t promise_do_write(
  * number already set up. It issues a READ or WRITE command to the Promise
  * controller, assuming LBA has been used to set up the block number.
  */
-ide_startstop_t do_pdc4030_io(struct ata_device *drive, struct ata_taskfile *args, struct request *rq)
+ide_startstop_t do_pdc4030_io(struct ata_device *drive, u8 cmd, struct hd_drive_task_hdr *taskfile, struct request *rq)
 {
-	struct hd_drive_task_hdr *taskfile = &(args->taskfile);
 	unsigned long timeout;
 
 	/* Check that it's a regular command. If not, bomb out early. */
@@ -638,7 +637,7 @@ ide_startstop_t do_pdc4030_io(struct ata
 	ata_out_regfile(drive, taskfile);
 
 	outb(taskfile->device_head, IDE_SELECT_REG);
-	outb(args->cmd, IDE_COMMAND_REG);
+	outb(cmd, IDE_COMMAND_REG);
 
 	switch (rq_data_dir(rq)) {
 	case READ:
@@ -714,24 +713,112 @@ ide_startstop_t do_pdc4030_io(struct ata
 
 ide_startstop_t promise_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	struct ata_taskfile args;
-
-	memset(&args, 0, sizeof(args));
+	struct hd_drive_task_hdr rf;
+	unsigned long timeout;
+	u8 cmd;
 
 	/* The four drives on the two logical (one physical) interfaces
 	   are distinguished by writing the drive number (0-3) to the
 	   Feature register.
 	   FIXME: Is promise_selectproc now redundant??
 	*/
-	args.taskfile.feature		= (drive->channel->unit << 1) + drive->select.b.unit;
-	args.taskfile.sector_count	= rq->nr_sectors;
-	args.taskfile.sector_number	= block;
-	args.taskfile.low_cylinder	= (block>>=8);
-	args.taskfile.high_cylinder	= (block>>=8);
-	args.taskfile.device_head	= ((block>>8)&0x0f)|drive->select.all;
-	args.cmd = (rq_data_dir(rq) == READ) ? PROMISE_READ : PROMISE_WRITE;
-	args.XXX_handler	= NULL;
-	rq->special	= &args;
+	rf.feature		= (drive->channel->unit << 1) + drive->select.b.unit;
+	rf.sector_count		= rq->nr_sectors;
+	rf.sector_number	= block;
+	rf.low_cylinder		= (block >>= 8);
+	rf.high_cylinder	= (block >>= 8);
+	rf.device_head		= ((block >> 8) & 0x0f)|drive->select.all;
+	cmd = (rq_data_dir(rq) == READ) ? PROMISE_READ : PROMISE_WRITE;
 
-	return do_pdc4030_io(drive, &args, rq);
+	/*
+	 * Issue a READ or WRITE command to the Promise controller, assuming
+	 * LBA has been used to set up the block number.
+	 */
+
+	/* Check that it's a regular command. If not, bomb out early. */
+	if (!(rq->flags & REQ_CMD)) {
+		blk_dump_rq_flags(rq, "pdc4030 bad flags");
+		ata_end_request(drive, rq, 0, 0);
+
+		return ATA_OP_FINISHED;
+	}
+
+	ata_irq_enable(drive, 1);
+	ata_mask(drive);
+
+	ata_out_regfile(drive, &rf);
+
+	outb(rf.device_head, IDE_SELECT_REG);
+	outb(cmd, IDE_COMMAND_REG);
+
+	switch (rq_data_dir(rq)) {
+	case READ:
+
+		/*
+		 * The card's behaviour is odd at this point. If the data is
+		 * available, DRQ will be true, and no interrupt will be
+		 * generated by the card. If this is the case, we need to call
+		 * the "interrupt" handler (promise_read_intr) directly.
+		 * Otherwise, if an interrupt is going to occur, bit0 of the
+		 * SELECT register will be high, so we can set the handler the
+		 * just return and be interrupted.  If neither of these is the
+		 * case, we wait for up to 50ms (badly I'm afraid!) until one
+		 * of them is.
+		 */
+
+		timeout = jiffies + HZ/20; /* 50ms wait */
+		do {
+			if (!ata_status(drive, 0, DRQ_STAT)) {
+				udelay(1);
+				return promise_read_intr(drive, rq);
+			}
+			if (inb(IDE_SELECT_REG) & 0x01) {
+#ifdef DEBUG_READ
+				printk(KERN_DEBUG "%s: read: waiting for "
+				                  "interrupt\n", drive->name);
+#endif
+				ata_set_handler(drive, promise_read_intr, WAIT_CMD, NULL);
+
+				return ATA_OP_CONTINUES;
+			}
+			udelay(1);
+		} while (time_before(jiffies, timeout));
+
+		printk(KERN_ERR "%s: reading: No DRQ and not waiting - Odd!\n",
+			drive->name);
+		return ATA_OP_FINISHED;
+
+	case WRITE: {
+		ide_startstop_t ret;
+
+		/*
+		 * Strategy on write is: look for the DRQ that should have been
+		 * immediately asserted copy the request into the hwgroup's
+		 * scratchpad call the promise_write function to deal with
+		 * writing the data out.
+		 *
+		 * NOTE: No interrupts are generated on writes. Write
+		 * completion must be polled
+		 */
+
+		ret = ata_status_poll(drive, DATA_READY, drive->bad_wstat,
+					WAIT_DRQ, rq);
+		if (ret != ATA_OP_READY) {
+			printk(KERN_ERR "%s: no DRQ after issuing "
+			       "PROMISE_WRITE\n", drive->name);
+
+			return ret;
+		}
+		if (!drive->channel->unmask)
+			local_irq_disable();
+
+		return promise_do_write(drive, rq);
+	}
+
+	default:
+		printk(KERN_ERR "pdc4030: command not READ or WRITE! Huh?\n");
+
+		ata_end_request(drive, rq, 0, 0);
+		return ATA_OP_FINISHED;
+	}
 }
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.30/drivers/ide/tcq.c	2002-08-09 13:37:52.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-08-08 08:07:15.000000000 +0200
@@ -56,27 +56,6 @@
 static ide_startstop_t ide_dmaq_intr(struct ata_device *drive, struct request *rq);
 static ide_startstop_t service(struct ata_device *drive, struct request *rq);
 
-static ide_startstop_t tcq_nop_handler(struct ata_device *drive, struct request *rq)
-{
-	unsigned long flags;
-	struct ata_taskfile *args = rq->special;
-	struct ata_channel *ch = drive->channel;
-
-	local_irq_enable();
-
-	spin_lock_irqsave(ch->lock, flags);
-
-	blkdev_dequeue_request(rq);
-	drive->rq = NULL;
-	end_that_request_last(rq);
-
-	spin_unlock_irqrestore(ch->lock, flags);
-
-	kfree(args);
-
-	return ATA_OP_FINISHED;
-}
-
 /*
  * If we encounter _any_ error doing I/O to one of the tags, we must
  * invalidate the pending queue. Clear the software busy queue and requeue
@@ -112,11 +91,6 @@ static void tcq_invalidate_queue(struct 
 	 * executed before any new commands are started. issue a NOP
 	 * to clear internal queue on drive.
 	 */
-	ar = kmalloc(sizeof(*ar), GFP_ATOMIC);
-	if (!ar) {
-		printk(KERN_ERR "ATA: %s: failed to issue NOP\n", drive->name);
-		goto out;
-	}
 
 	rq = __blk_get_request(&drive->queue, READ);
 	if (!rq)
@@ -130,14 +104,13 @@ static void tcq_invalidate_queue(struct 
 
 	/* WIN_NOP is a special request so set it's flags ?? */
 	rq->flags = REQ_SPECIAL;
-	rq->special = ar;
+	ar = (struct ata_taskfile *) rq->cmd;
 	ar->cmd = WIN_NOP;
-	ar->XXX_handler = tcq_nop_handler;
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
+	memcpy(rq->cmd, ar, sizeof(*ar));
 
 	_elv_add_request(q, rq, 0, 0);
 
-out:
 #ifdef IDE_TCQ_NIEN
 	ata_irq_enable(drive, 1);
 #endif
@@ -566,7 +539,7 @@ ide_startstop_t udma_tcq_init(struct ata
 	u8 stat;
 	u8 feat;
 
-	struct ata_taskfile *args = rq->special;
+	struct ata_taskfile *args = (struct ata_taskfile *) rq->cmd;
 
 	TCQ_PRINTK("%s: start tag %d\n", drive->name, rq->tag);
 
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.30/include/linux/blkdev.h	2002-08-09 13:37:52.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-08-08 06:14:50.000000000 +0200
@@ -28,7 +28,7 @@ struct request {
 				     * blkdev_dequeue_request! */
 	void *elevator_private;
 
-	unsigned char cmd[16];
+	unsigned char cmd[32];
 
 	unsigned long flags;		/* see REQ_ bits below */
 
@@ -293,7 +293,6 @@ extern int blk_remove_plug(request_queue
 extern void blk_recount_segments(request_queue_t *, struct bio *);
 extern inline int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern inline int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
-extern int block_ioctl(struct block_device *, unsigned int, unsigned long);
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
 extern void __blk_stop_queue(request_queue_t *q);
diff -durNp -X /tmp/diff.iiayAi linux-2.5.30/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.30/include/linux/ide.h	2002-08-09 13:37:52.000000000 +0200
+++ linux/include/linux/ide.h	2002-08-08 08:02:27.000000000 +0200
@@ -1101,11 +1101,10 @@ struct ata_device *get_info_ptr(kdev_t i
 #define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
 struct ata_taskfile {
+	u8 cmd;		/* actual ATA command */
+	int command_type;
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_task_hdr  hobfile;
-	u8 cmd;					/* actual ATA command */
-	int command_type;
-	ide_startstop_t (*XXX_handler)(struct ata_device *, struct request *);
 };
 
 extern void ata_read(struct ata_device *, void *, unsigned int);

--------------030007080409020004010207--


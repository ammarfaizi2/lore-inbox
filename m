Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265172AbSJRPvn>; Fri, 18 Oct 2002 11:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSJRPvn>; Fri, 18 Oct 2002 11:51:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16617 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265172AbSJRPu5>;
	Fri, 18 Oct 2002 11:50:57 -0400
Date: Fri, 18 Oct 2002 17:56:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch][cft] zero-copy dma cd writing and ripping
Message-ID: <20021018155650.GJ15494@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5 now has the very cool feature that you can write with an ATAPI CD-R
device without having to use ide-scsi, but it has one problem at least.
ide-cd has historically never used dma transfers for anything but
requests originating from a file system. So while generic cd writing
works now, it is done in pio. Needless to say, this is suboptimal.

This patch should make 2.5 ide-cd writing even faster than using
ide-scsi. Data is read/written directly to/from user space pages, and it
is done using dma whenever possible.

Patch also adds support to sd and sr for SG_IO. It's against 2.5.43-BK,
please test it. You should grab the latest modified cdrecord and
cdda2wav where announced the other day:

*.kernel.org/pub/linux/kernel/people/axboe/tools

If you compile from the tar ball, remember to patch with linus-cdr.diff
or it wont work.

I'd appreciate reports on audio extraction with cdda2wav and burning
with cdrecord. We need to have this working before 2.6/3.0, or cd
writing will simply suck.

===== drivers/block/ll_rw_blk.c 1.122 vs edited =====
--- 1.122/drivers/block/ll_rw_blk.c	Tue Oct 15 22:55:04 2002
+++ edited/drivers/block/ll_rw_blk.c	Fri Oct 18 17:41:37 2002
@@ -670,12 +670,10 @@
 		bit++;
 	} while (bit < __REQ_NR_BITS);
 
-	if (rq->flags & REQ_CMD)
-		printk("sector %llu, nr/cnr %lu/%u\n", (unsigned long long)rq->sector,
+	printk("sector %llu, nr/cnr %lu/%u\n", (unsigned long long)rq->sector,
 						       rq->nr_sectors,
 						       rq->current_nr_sectors);
-
-	printk("\n");
+	printk("bio %p, biotail %p\n", rq->bio, rq->biotail);
 }
 
 void blk_recount_segments(request_queue_t *q, struct bio *bio)
@@ -1927,7 +1925,7 @@
 
 inline void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
-	if (rq->flags & REQ_CMD) {
+	if (rq->bio) {
 		rq->hard_sector += nsect;
 		rq->nr_sectors = rq->hard_nr_sectors -= nsect;
 		rq->sector = rq->hard_sector;
@@ -1968,20 +1966,28 @@
 
 	req->errors = 0;
 	if (!uptodate) {
-		printk("end_request: I/O error, dev %s, sector %llu\n",
-			kdevname(req->rq_dev), (unsigned long long)req->sector);
 		error = -EIO;
+		if (!(req->flags & REQ_QUIET))
+			printk("end_request: I/O error, dev %s, sector %llu\n",
+				kdevname(req->rq_dev),
+				(unsigned long long)req->sector);
 	}
 
 	while ((bio = req->bio)) {
-		const int nsect = bio_iovec(bio)->bv_len >> 9;
-		int new_bio = 0;
+		int new_bio = 0, nsect;
+
+		if (unlikely(bio->bi_idx >= bio->bi_vcnt)) {
+			printk("%s: bio idx %d >= vcnt %d\n", __FUNCTION__,
+						bio->bi_idx, bio->bi_vcnt);
+			break;
+		}
 
 		BIO_BUG_ON(bio_iovec(bio)->bv_len > bio->bi_size);
 
 		/*
 		 * not a complete bvec done
 		 */
+		nsect = bio_iovec(bio)->bv_len >> 9;
 		if (unlikely(nsect > nr_sectors)) {
 			int partial = nr_sectors << 9;
 
===== drivers/block/scsi_ioctl.c 1.12 vs edited =====
--- 1.12/drivers/block/scsi_ioctl.c	Tue Oct 15 20:50:18 2002
+++ edited/drivers/block/scsi_ioctl.c	Fri Oct 18 17:24:37 2002
@@ -29,11 +29,14 @@
 #include <linux/completion.h>
 #include <linux/cdrom.h>
 #include <linux/slab.h>
+#include <linux/bio.h>
 
 #include <scsi/scsi.h>
 
 #include <asm/uaccess.h>
 
+#define BLK_DEFAULT_TIMEOUT	(60 * HZ)
+
 int blk_do_rq(request_queue_t *q, struct request *rq)
 {
 	DECLARE_COMPLETION(wait);
@@ -74,30 +77,32 @@
 
 static int sg_get_timeout(request_queue_t *q)
 {
-	return HZ;
+	return q->sg_timeout;
 }
 
 static int sg_set_timeout(request_queue_t *q, int *p)
 {
-	int timeout;
-	int error = get_user(timeout, p);
-	return error;
-}
+	int timeout, err = get_user(timeout, p);
 
-static int reserved_size = 0;
+	if (!err)
+		q->sg_timeout = timeout;
+
+	return err;
+}
 
 static int sg_get_reserved_size(request_queue_t *q, int *p)
 {
-	return put_user(reserved_size, p);
+	return put_user(q->sg_reserved_size, p);
 }
 
 static int sg_set_reserved_size(request_queue_t *q, int *p)
 {
-	int size;
-	int error = get_user(size, p);
-	if (!error)
-		reserved_size = size;
-	return error;
+	int size, err = get_user(size, p);
+
+	if (!err)
+		q->sg_reserved_size = size;
+
+	return err;
 }
 
 static int sg_emulated_host(request_queue_t *q, int *p)
@@ -105,11 +110,14 @@
 	return put_user(1, p);
 }
 
-static int sg_io(request_queue_t *q, struct sg_io_hdr *uptr)
+static int sg_io(request_queue_t *q, struct block_device *bdev,
+		 struct sg_io_hdr *uptr)
 {
-	int err;
+	unsigned long uaddr, start_time;
+	int err, reading, writing;
 	struct sg_io_hdr hdr;
 	struct request *rq;
+	struct bio *bio;
 	void *buffer;
 
 	if (!access_ok(VERIFY_WRITE, uptr, sizeof(*uptr)))
@@ -117,47 +125,114 @@
 	if (copy_from_user(&hdr, uptr, sizeof(*uptr)))
 		return -EFAULT;
 
-	if ( hdr.cmd_len > sizeof(rq->cmd) )
+	if (hdr.cmd_len > sizeof(rq->cmd))
 		return -EINVAL;
+	if (!access_ok(VERIFY_READ, hdr.cmdp, hdr.cmd_len))
+		return -EFAULT;
+
+	if (hdr.dxfer_len > 65536)
+		return -EINVAL;
+
+	/*
+	 * we'll do that later
+	 */
+	if (hdr.iovec_count)
+		return -EOPNOTSUPP;
 
+	reading = writing = 0;
 	buffer = NULL;
+	bio = NULL;
 	if (hdr.dxfer_len) {
 		unsigned int bytes = (hdr.dxfer_len + 511) & ~511;
 
 		switch (hdr.dxfer_direction) {
 		default:
 			return -EINVAL;
+		case SG_DXFER_TO_FROM_DEV:
+			reading = 1;
+			/* fall through */
 		case SG_DXFER_TO_DEV:
+			writing = 1;
+			break;
 		case SG_DXFER_FROM_DEV:
-		case SG_DXFER_TO_FROM_DEV:
+			reading = 1;
 			break;
 		}
-		buffer = kmalloc(bytes, GFP_USER);
-		if (!buffer)
-			return -ENOMEM;
-		if (hdr.dxfer_direction == SG_DXFER_TO_DEV ||
-		    hdr.dxfer_direction == SG_DXFER_TO_FROM_DEV)
-			copy_from_user(buffer, hdr.dxferp, hdr.dxfer_len);
+
+		uaddr = (unsigned long) hdr.dxferp;
+		if (writing && !access_ok(VERIFY_WRITE, uaddr, bytes))
+			return -EFAULT;
+		if (reading && !access_ok(VERIFY_READ, uaddr, bytes))
+			return -EFAULT;
+
+		/*
+		 * first try to map it into a bio
+		 */
+		bio = bio_map_user(bdev, uaddr, hdr.dxfer_len, reading);
+		if (bio && bio->bi_size < hdr.dxfer_len) {
+			bio_endio(bio, bio->bi_size, 0);
+			bio = NULL;
+		}
+
+		/*
+		 * if bio setup failed, fall back to slow approach
+		 */
+		if (!bio) {
+			buffer = kmalloc(bytes, GFP_USER);
+			if (!buffer)
+				return -ENOMEM;
+			if (writing)
+				copy_from_user(buffer,hdr.dxferp,hdr.dxfer_len);
+		}
 	}
 
 	rq = blk_get_request(q, WRITE, __GFP_WAIT);
-	rq->timeout = 60*HZ;
+	rq->bio = rq->biotail = bio;
 	rq->data = buffer;
+
+	if (bio) {
+		if (writing)
+			bio->bi_rw |= (1 << BIO_RW);
+
+		rq->buffer = bio_data(bio);
+		rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
+		rq->current_nr_sectors = bio_cur_sectors(bio);
+		rq->hard_cur_sectors = rq->current_nr_sectors;
+		rq->nr_phys_segments = bio_phys_segments(q, bio);
+		rq->nr_hw_segments = bio_hw_segments(q, bio);
+	}
+
+	rq->rq_dev = to_kdev_t(bdev->bd_dev);
+
+	rq->timeout = hdr.timeout;
+	if (!rq->timeout)
+		rq->timeout = q->sg_timeout;
+	if (!rq->timeout)
+		rq->timeout = BLK_DEFAULT_TIMEOUT;
+
 	rq->data_len = hdr.dxfer_len;
-	rq->flags = REQ_BLOCK_PC;
+	rq->flags |= REQ_BLOCK_PC;
+	if (writing)
+		rq->flags |= REQ_RW;
+
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len);
+
+	start_time = jiffies;
 	err = blk_do_rq(q, rq);
 
+	hdr.duration = (jiffies - start_time) * 1000 / HZ;
 	blk_put_request(rq);
 
 	copy_to_user(uptr, &hdr, sizeof(*uptr));
+
 	if (buffer) {
-		if (hdr.dxfer_direction == SG_DXFER_FROM_DEV ||
-		    hdr.dxfer_direction == SG_DXFER_TO_FROM_DEV)
+		if (reading)
 			copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len);
+
 		kfree(buffer);
 	}
+
 	return err;
 }
 
@@ -189,7 +264,7 @@
 		case SG_EMULATED_HOST:
 			return sg_emulated_host(q, (int *) arg);
 		case SG_IO:
-			return sg_io(q, (struct sg_io_hdr *) arg);
+			return sg_io(q, bdev, (struct sg_io_hdr *) arg);
 		case CDROMCLOSETRAY:
 			close = 1;
 		case CDROMEJECT:
@@ -197,7 +272,7 @@
 			rq->flags = REQ_BLOCK_PC;
 			rq->data = NULL;
 			rq->data_len = 0;
-			rq->timeout = 60*HZ;
+			rq->timeout = 60 * HZ;
 			memset(rq->cmd, 0, sizeof(rq->cmd));
 			rq->cmd[0] = GPCMD_START_STOP_UNIT;
 			rq->cmd[4] = 0x02 + (close != 0);
===== drivers/cdrom/cdrom.c 1.29 vs edited =====
--- 1.29/drivers/cdrom/cdrom.c	Sat Oct 12 20:08:17 2002
+++ edited/drivers/cdrom/cdrom.c	Fri Oct 18 14:12:43 2002
@@ -267,6 +267,7 @@
 #include <linux/blkpg.h>
 #include <linux/init.h>
 #include <linux/fcntl.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 
@@ -1464,6 +1465,11 @@
 	struct cdrom_device_info *cdi = cdrom_find_device(dev);
 	struct cdrom_device_ops *cdo = cdi->ops;
 	int ret;
+
+	/* Try the generic SCSI command ioctl's first.. */
+	ret = scsi_cmd_ioctl(ip->i_bdev, cmd, arg);
+	if (ret != -ENOTTY)
+		return ret;
 
 	/* the first few commands do not deal with audio drive_info, but
 	   only with routines in cdrom device operations. */
===== drivers/ide/ide-cd.c 1.25 vs edited =====
--- 1.25/drivers/ide/ide-cd.c	Tue Oct 15 22:54:07 2002
+++ edited/drivers/ide/ide-cd.c	Fri Oct 18 14:12:08 2002
@@ -608,7 +608,7 @@
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 	/* retry only "normal" I/O: */
-	if ((rq->flags & REQ_DRIVE_CMD) || (rq->flags & REQ_DRIVE_TASK)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
@@ -635,7 +635,7 @@
 	return ide_stopped;
 }
 
-static void cdrom_end_request (ide_drive_t *drive, int uptodate)
+static int cdrom_end_request (ide_drive_t *drive, int uptodate)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 
@@ -651,10 +651,11 @@
 		cdrom_analyze_sense_data(drive, failed, sense);
 	}
 
-	if (blk_fs_request(rq) && !rq->current_nr_sectors)
-		uptodate = 1;
+	if (!rq->current_nr_sectors)
+		if (blk_fs_request(rq) || blk_pc_request(rq))
+			uptodate = 1;
 
-	ide_end_request(drive, uptodate, rq->hard_cur_sectors);
+	return ide_end_request(drive, uptodate, rq->hard_cur_sectors);
 }
 
 /* Handle differences between SCSI and ATAPI packet commands */
@@ -779,8 +780,10 @@
 		   queue a request sense command. */
 		if ((stat & ERR_STAT) != 0)
 			cdrom_queue_request_sense(drive, NULL, NULL, NULL);
-	} else
-		blk_dump_rq_flags(rq, "ide-cd bad flags");
+	} else {
+		blk_dump_rq_flags(rq, "ide-cd: bad rq");
+		cdrom_end_request(drive, 0);
+	}
 
 	/* Retry, or handle the next request. */
 	*startstop = ide_stopped;
@@ -848,7 +851,7 @@
 	HWIF(drive)->OUTB(xferlen >> 8  , IDE_BCOUNTH_REG);
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
- 
+
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		if (HWGROUP(drive)->handler != NULL)
 			BUG();
@@ -876,9 +879,6 @@
 					  struct request *rq,
 					  ide_handler_t *handler)
 {
-	unsigned char *cmd_buf	= rq->cmd;
-	int cmd_len		= sizeof(rq->cmd);
-	unsigned int timeout	= rq->timeout;
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
 
@@ -901,10 +901,10 @@
 		BUG();
 
 	/* Arm the interrupt handler. */
-	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
+	ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
-	HWIF(drive)->atapi_output_bytes(drive, cmd_buf, cmd_len);
+	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, sizeof(rq->cmd));
 
 	/* Start the DMA if need be */
 	if (info->dma)
@@ -1016,7 +1016,9 @@
 
 	struct request *rq = HWGROUP(drive)->rq;
 
-	/* Check for errors. */
+	/*
+	 * handle dma case
+	 */
 	if (dma) {
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive)))
@@ -1025,15 +1027,20 @@
 
 	if (cdrom_decode_status (&startstop, drive, 0, &stat))
 		return startstop;
- 
+
 	if (dma) {
 		if (!dma_error) {
-			ide_end_request(drive, 1, rq->nr_sectors);
+			if (ide_end_request(drive, 1, rq->nr_sectors))
+				printk("%s: bad end_request return\n", __FUNCTION__);
 			return ide_stopped;
 		} else
 			return DRIVER(drive)->error(drive, "dma error", stat);
 	}
 
+	/*
+	 * below is the pio data handling
+	 */
+
 	/* Read the interrupt reason and the transfer length. */
 	ireason = HWIF(drive)->INB(IDE_IREASON_REG);
 	lowcyl  = HWIF(drive)->INB(IDE_BCOUNTL_REG);
@@ -1080,7 +1087,7 @@
 
 	/* First, figure out if we need to bit-bucket
 	   any of the leading sectors. */
-	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);
+	nskip = MIN((int)(rq->current_nr_sectors - bio_cur_sectors(rq->bio)), sectors_to_transfer);
 
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
@@ -1107,6 +1114,9 @@
 			cdrom_buffer_sectors(drive, rq->sector, sectors_to_transfer);
 			sectors_to_transfer = 0;
 		} else {
+			if (rq->bio)
+				rq->buffer = bio_data(rq->bio);
+
 			/* Transfer data to the buffers.
 			   Figure out how many sectors we can transfer
 			   to the current buffer. */
@@ -1180,7 +1190,7 @@
 	   represent the number of sectors to skip at the start of a transfer
 	   will fail.  I think that this will never happen, but let's be
 	   paranoid and check. */
-	if (rq->current_nr_sectors < bio_sectors(rq->bio) &&
+	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
 	    (rq->sector % SECTORS_PER_FRAME) != 0) {
 		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, (long)rq->sector);
@@ -1218,7 +1228,7 @@
 	nskip = (sector % SECTORS_PER_FRAME);
 	if (nskip > 0) {
 		/* Sanity check... */
-		if (rq->current_nr_sectors != bio_sectors(rq->bio) &&
+		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
 			(rq->sector % CD_FRAMESIZE != 0)) {
 			printk ("%s: cdrom_start_read_continuation: buffer botch (%u)\n",
 				drive->name, rq->current_nr_sectors);
@@ -1318,7 +1328,7 @@
 		rq->nr_sectors += n;
 		rq->sector -= n;
 	}
-	rq->hard_cur_sectors = rq->current_nr_sectors = bio_sectors(rq->bio);
+	rq->hard_cur_sectors = rq->current_nr_sectors = bio_cur_sectors(rq->bio);
 	rq->hard_nr_sectors = rq->nr_sectors;
 	rq->hard_sector = rq->sector;
 	rq->q->prep_rq_fn(rq->q, rq);
@@ -1606,6 +1616,9 @@
 
 	struct request *rq = HWGROUP(drive)->rq;
 
+	if (rq->rq_status == RQ_INACTIVE)
+		printk("%s: rq is gone\n", __FUNCTION__);
+
 	/* Check for errors. */
 	if (dma) {
 		info->dma = 0;
@@ -1619,7 +1632,7 @@
 		printk("ide-cd: write_intr decode_status bad\n");
 		return startstop;
 	}
- 
+
 	/*
 	 * using dma, transfer is complete now
 	 */
@@ -1671,6 +1684,9 @@
 			break;
 		}
 
+		if (rq->bio)
+			rq->buffer = bio_data(rq->bio);
+
 		/*
 		 * Figure out how many sectors we can transfer
 		 */
@@ -1755,6 +1771,7 @@
 static int pre_transform_command(struct request *req)
 {
 	u8 *c = req->cmd;
+
 	/* Transform 6-byte read/write commands to the 10-byte version. */
 	if (c[0] == READ_6 || c[0] == WRITE_6) {
 		c[8] = c[4];
@@ -1778,10 +1795,27 @@
 {
 }
 
+static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *drive)
+{
+	struct cdrom_info *info = drive->driver_data;
+	struct request *rq = HWGROUP(drive)->rq;
+	ide_handler_t *handler;
+
+	if (!rq->timeout)
+		rq->timeout = WAIT_CMD;
+
+	if (info->cmd == READ)
+		handler = cdrom_read_intr;
+	else
+		handler = cdrom_write_intr;
+
+	return cdrom_transfer_packet_command(drive, rq, handler);
+}
+
 static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 {
-	ide_startstop_t startstop;
-	struct cdrom_info *info;
+	struct cdrom_info *info = drive->driver_data;
+	ide_handler_t *handler;
 
 	if (pre_transform_command(rq) < 0) {
 		cdrom_end_request(drive, 0);
@@ -1790,14 +1824,23 @@
 
 	rq->flags |= REQ_QUIET;
 
-	info = drive->driver_data;
-	info->dma = 0;
-	info->cmd = 0;
+	if (rq->bio) {
+		if (rq->data_len & 511) {
+			printk("%s: block pc not aligned, len=%d\n", drive->name, rq->data_len);
+			cdrom_end_request(drive, 0);
+			return ide_stopped;
+		}
+		info->dma = drive->using_dma;
+		info->cmd = rq_data_dir(rq);
+		handler = cdrom_do_newpc_cont;
+	} else {
+		info->dma = 0;
+		info->cmd = 0;
+		handler = cdrom_do_pc_continuation;
+	}
 
 	/* Start sending the command to the drive. */
-	startstop = cdrom_start_packet_command(drive, rq->data_len, cdrom_do_pc_continuation);
-
-	return startstop;
+	return cdrom_start_packet_command(drive, rq->data_len, handler);
 }
 
 /****************************************************************************
@@ -3026,13 +3069,6 @@
 		     struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	int error;
-
-	/* Try the generic SCSI command ioctl's first.. */
-	error = scsi_cmd_ioctl(inode->i_bdev, cmd, arg);
-	if (error != -ENOTTY)
-		return error;
-
 	/* Then the generic cdrom ioctl's.. */
 	return cdrom_ioctl(inode, file, cmd, arg);
 }
===== drivers/md/linear.c 1.20 vs edited =====
--- 1.20/drivers/md/linear.c	Wed Oct 16 06:49:22 2002
+++ edited/drivers/md/linear.c	Thu Oct 17 20:15:53 2002
@@ -52,8 +52,7 @@
  *	@bio: the buffer head that's been built up so far
  *	@biovec: the request that could be merged to it.
  *
- *	Return 1 if the merge is not permitted (because the
- *	result would cross a device boundary), 0 otherwise.
+ *	FIXME: return amount we can take at this offset, not a bool
  */
 static int linear_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
 {
@@ -64,7 +63,10 @@
 	dev1 = which_dev(mddev, bio->bi_sector +
 			        ((bio->bi_size + biovec->bv_len - 1) >> 9));
 
-	return dev0 != dev1;
+	if (dev0 == dev1)
+		return biovec->bv_len;
+
+	return 0;
 }
 
 static int linear_run (mddev_t *mddev)
===== drivers/md/raid0.c 1.18 vs edited =====
--- 1.18/drivers/md/raid0.c	Tue Oct 15 12:03:07 2002
+++ edited/drivers/md/raid0.c	Thu Oct 17 20:18:19 2002
@@ -168,8 +168,7 @@
  *	@bio: the buffer head that's been built up so far
  *	@biovec: the request that could be merged to it.
  *
- *	Return 1 if the merge is not permitted (because the
- *	result would cross a chunk boundary), 0 otherwise.
+ *	Return amount of bytes we can accept at this offset
  */
 static int raid0_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
 {
@@ -182,7 +181,7 @@
 	block = bio->bi_sector >> 1;
 	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
 
-	return chunk_size < ((block & (chunk_size - 1)) + bio_sz);
+	return chunk_size - ((block & (chunk_size - 1)) + bio_sz);
 }
 
 static int raid0_run (mddev_t *mddev)
===== drivers/scsi/scsi_lib.c 1.34 vs edited =====
--- 1.34/drivers/scsi/scsi_lib.c	Mon Oct  7 23:58:37 2002
+++ edited/drivers/scsi/scsi_lib.c	Fri Oct 18 14:22:51 2002
@@ -857,7 +857,7 @@
 				scsi_init_cmd_from_req(SCpnt, SRpnt);
 			}
 
-		} else if (req->flags & REQ_CMD) {
+		} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
 			SRpnt = NULL;
 			STpnt = scsi_get_request_dev(req);
 			if (!STpnt) {
@@ -919,7 +919,7 @@
 		req = NULL;
 		spin_unlock_irq(q->queue_lock);
 
-		if (SCpnt->request->flags & REQ_CMD) {
+		if (SCpnt->request->flags & (REQ_CMD | REQ_BLOCK_PC)) {
 			/*
 			 * This will do a couple of things:
 			 *  1) Fill in the actual SCSI command.
===== drivers/scsi/scsi_merge.c 1.23 vs edited =====
--- 1.23/drivers/scsi/scsi_merge.c	Mon Sep 30 23:38:43 2002
+++ edited/drivers/scsi/scsi_merge.c	Fri Oct 18 13:14:30 2002
@@ -62,16 +62,28 @@
 	int count, gfp_mask;
 
 	/*
-	 * First we need to know how many scatter gather segments are needed.
+	 * non-sg block request. FIXME: check bouncing for isa hosts!
 	 */
-	count = req->nr_phys_segments;
+	if ((req->flags & REQ_BLOCK_PC) && !req->bio) {
+		/*
+		 * FIXME: isa bouncing
+		 */
+		if (SCpnt->host->unchecked_isa_dma)
+			goto fail;
+
+		SCpnt->request_bufflen = req->data_len;
+		SCpnt->request_buffer = req->data;
+		req->buffer = req->data;
+		SCpnt->use_sg = 0;
+		return 1;
+	}
 
 	/*
 	 * we used to not use scatter-gather for single segment request,
 	 * but now we do (it makes highmem I/O easier to support without
 	 * kmapping pages)
 	 */
-	SCpnt->use_sg = count;
+	SCpnt->use_sg = req->nr_phys_segments;
 
 	gfp_mask = GFP_NOIO;
 	if (in_interrupt()) {
@@ -111,6 +123,7 @@
 	/*
 	 * kill it. there should be no leftover blocks in this request
 	 */
+fail:
 	SCpnt = scsi_end_request(SCpnt, 0, req->nr_sectors);
 	BUG_ON(SCpnt);
 	return 0;
===== drivers/scsi/sd.c 1.71 vs edited =====
--- 1.71/drivers/scsi/sd.c	Fri Oct 18 05:39:02 2002
+++ edited/drivers/scsi/sd.c	Fri Oct 18 14:10:15 2002
@@ -193,6 +193,7 @@
 	Scsi_Device * sdp;
 	int diskinfo[4];
 	int dsk_nr = DEVICE_NR(dev);
+	int error;
     
 	SCSI_LOG_IOCTL(1, printk("sd_ioctl: dsk_nr=%d, cmd=0x%x\n",
 		       dsk_nr, cmd));
@@ -209,6 +210,10 @@
 	if( !scsi_block_when_processing_errors(sdp) )
 		return -ENODEV;
 
+	error = scsi_cmd_ioctl(inode->i_bdev, cmd, arg);
+	if (error != -ENOTTY)
+		return error;
+
 	switch (cmd) 
 	{
 		case HDIO_GETGEO:   /* Return BIOS disk parameters */
@@ -299,14 +304,43 @@
  **/
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dsk_nr, part_nr, this_count;
+	int dsk_nr, part_nr, this_count, timeout;
 	sector_t block;
-	Scsi_Device *sdp;
+	Scsi_Device *sdp = SCpnt->device;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
 #endif
+
+	timeout = SD_TIMEOUT;
+	if (SCpnt->device->type != TYPE_DISK)
+		timeout = SD_MOD_TIMEOUT;
+
+	/*
+	 * these are already setup, just copy cdb basically
+	 */
+	if (SCpnt->request->flags & REQ_BLOCK_PC) {
+		struct request *rq = SCpnt->request;
+
+		if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
+			return 0;
+
+		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
+		if (rq_data_dir(rq) == WRITE)
+			SCpnt->sc_data_direction = SCSI_DATA_WRITE;
+		else if (rq->data_len)
+			SCpnt->sc_data_direction = SCSI_DATA_READ;
+		else
+			SCpnt->sc_data_direction = SCSI_DATA_NONE;
+
+		this_count = rq->data_len;
+		if (rq->timeout)
+			timeout = rq->timeout;
+
+		goto queue;
+	}
+
 	/*
-	 * don't support specials for nwo
+	 * we only do REQ_CMD and REQ_BLOCK_PC
 	 */
 	if (!(SCpnt->request->flags & REQ_CMD))
 		return 0;
@@ -320,7 +354,6 @@
 	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%llu, "
 			    "count=%d\n", dsk_nr, (unsigned long long)block, this_count));
 
-	sdp = SCpnt->device;
 	/* >>>>> the "(part_nr & 0xf)" excludes 15th partition, why?? */
 	/* >>>>> this change is not in the lk 2.5 series */
 	if (part_nr >= (sd_template.dev_max << 4) || (part_nr & 0xf) ||
@@ -432,12 +465,12 @@
 	 * host adapter, it's safe to assume that we can at least transfer
 	 * this many bytes between each connect / disconnect.
 	 */
+queue:
 	SCpnt->transfersize = sdp->sector_size;
 	SCpnt->underflow = this_count << 9;
 
 	SCpnt->allowed = MAX_RETRIES;
-	SCpnt->timeout_per_command = (SCpnt->device->type == TYPE_DISK ?
-				      SD_TIMEOUT : SD_MOD_TIMEOUT);
+	SCpnt->timeout_per_command = timeout;
 
 	/*
 	 * This is the completion routine we use.  This is matched in terms
===== drivers/scsi/sr.c 1.51 vs edited =====
--- 1.51/drivers/scsi/sr.c	Thu Oct 17 19:52:39 2002
+++ edited/drivers/scsi/sr.c	Fri Oct 18 14:10:15 2002
@@ -262,7 +262,7 @@
 
 static int sr_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dev, devm, block=0, this_count, s_size;
+	int dev, devm, block=0, this_count, s_size, timeout = SR_TIMEOUT;
 	Scsi_CD *cd;
 
 	devm = minor(SCpnt->request->rq_dev);
@@ -285,6 +285,30 @@
 		return 0;
 	}
 
+	/*
+	 * these are already setup, just copy cdb basically
+	 */
+	if (SCpnt->request->flags & REQ_BLOCK_PC) {
+		struct request *rq = SCpnt->request;
+
+		if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
+			return 0;
+
+		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
+		if (rq_data_dir(rq) == WRITE)
+			SCpnt->sc_data_direction = SCSI_DATA_WRITE;
+		else if (rq->data_len)
+			SCpnt->sc_data_direction = SCSI_DATA_READ;
+		else
+			SCpnt->sc_data_direction = SCSI_DATA_NONE;
+
+		this_count = rq->data_len;
+		if (rq->timeout)
+			timeout = rq->timeout;
+
+		goto queue;
+	}
+
 	if (!(SCpnt->request->flags & REQ_CMD)) {
 		blk_dump_rq_flags(SCpnt->request, "sr unsup command");
 		return 0;
@@ -355,11 +379,12 @@
 	 * host adapter, it's safe to assume that we can at least transfer
 	 * this many bytes between each connect / disconnect.
 	 */
+queue:
 	SCpnt->transfersize = cd->device->sector_size;
 	SCpnt->underflow = this_count << 9;
 
 	SCpnt->allowed = MAX_RETRIES;
-	SCpnt->timeout_per_command = SR_TIMEOUT;
+	SCpnt->timeout_per_command = timeout;
 
 	/*
 	 * This is the completion routine we use.  This is matched in terms
===== drivers/scsi/sym53c8xx_2/sym_glue.c 1.8 vs edited =====
--- 1.8/drivers/scsi/sym53c8xx_2/sym_glue.c	Mon Oct 14 11:22:57 2002
+++ edited/drivers/scsi/sym53c8xx_2/sym_glue.c	Fri Oct 18 10:11:15 2002
@@ -1793,16 +1793,12 @@
 	hcb_p np = 0;
 	int retv;
 
-	for (host = first_host; host; host = host->next) {
-		if (host->hostt != first_host->hostt)
-			continue;
-		if (host->host_no == hostno) {
-			host_data = (struct host_data *) host->hostdata;
-			np = host_data->ncb;
-			break;
-		}
-	}
+	host = scsi_host_hn_get(hostno);
+	if (!host)
+		return -EINVAL;
 
+	host_data = (struct host_data *) host->hostdata;
+	np = host_data->ncb;
 	if (!np)
 		return -EINVAL;
 
@@ -1823,6 +1819,7 @@
 #endif
 	}
 
+	scsi_host_put(host);
 	return retv;
 }
 #endif /* SYM_LINUX_PROC_INFO_SUPPORT */
===== fs/bio.c 1.30 vs edited =====
--- 1.30/fs/bio.c	Sun Oct 13 17:39:40 2002
+++ edited/fs/bio.c	Fri Oct 18 17:05:31 2002
@@ -353,7 +353,7 @@
 	request_queue_t *q = bdev_get_queue(bdev);
 	int nr_pages;
 
-	nr_pages = q->max_sectors >> (PAGE_SHIFT - 9);
+	nr_pages = ((q->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	if (nr_pages > q->max_phys_segments)
 		nr_pages = q->max_phys_segments;
 	if (nr_pages > q->max_hw_segments)
@@ -384,13 +384,13 @@
 	 * cloned bio must not modify vec list
 	 */
 	if (unlikely(bio_flagged(bio, BIO_CLONED)))
-		return 1;
+		return 0;
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
-		return 1;
+		return 0;
 
 	if (((bio->bi_size + len) >> 9) > q->max_sectors)
-		return 1;
+		return 0;
 
 	/*
 	 * we might loose a segment or two here, but rather that than
@@ -403,7 +403,7 @@
 
 	if (fail_segments) {
 		if (retried_segments)
-			return 1;
+			return 0;
 
 		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 		retried_segments = 1;
@@ -424,21 +424,127 @@
 	 * depending on offset), it can specify a merge_bvec_fn in the
 	 * queue to get further control
 	 */
-	if (q->merge_bvec_fn && q->merge_bvec_fn(q, bio, bvec)) {
-		bvec->bv_page = NULL;
-		bvec->bv_len = 0;
-		bvec->bv_offset = 0;
-		return 1;
+	if (q->merge_bvec_fn) {
+		/*
+		 * merge_bvec_fn() returns number of bytes it can accept
+		 * at this offset
+		 */
+		if (q->merge_bvec_fn(q, bio, bvec) < len) {
+			bvec->bv_page = NULL;
+			bvec->bv_len = 0;
+			bvec->bv_offset = 0;
+			return 0;
+		}
 	}
 
 	bio->bi_vcnt++;
 	bio->bi_phys_segments++;
 	bio->bi_hw_segments++;
 	bio->bi_size += len;
+	return len;
+}
+
+static int bio_user_end_io(struct bio *bio, unsigned int bytes_done, int error)
+{
+	struct bio_vec *bvec;
+	int i;
+
+	if (bio->bi_size)
+		return 1;
+
+	bio_for_each_segment(bvec, bio, i)
+		page_cache_release(bvec->bv_page);
+
+	bio_put(bio);
 	return 0;
 }
 
 /**
+ *	bio_map_user	-	map user address into bio
+ *	@bdev: destination block device
+ *	@uaddr: start of user address
+ *	@len: length in bytes
+ *	@read: reading or not
+ *
+ *	Map the user space address into a bio suitable for io to a block
+ *	device. Caller should check the size of the returned bio, we might
+ *	not have mapped the entire range specified.
+ */
+struct bio *bio_map_user(struct block_device *bdev, unsigned long uaddr,
+			 unsigned int len, int read)
+{
+	unsigned long end = (uaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = uaddr >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	int ret, offset, i, align_mask;
+	struct page **pages;
+	struct bio *bio;
+
+	/*
+	 * transfer and buffer must be aligned to at least hardsector
+	 * size for now, in the future we can relax this restriction
+	 */
+	align_mask = bdev_hardsect_size(bdev) - 1;
+	if ((uaddr & align_mask) || (len & align_mask))
+		return NULL;
+
+	bio = bio_alloc(GFP_KERNEL, nr_pages);
+	if (!bio)
+		return NULL;
+
+	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		goto out;
+
+	/*
+	 * 'read' here means read from device, a write to the page
+	 */
+	down_read(&current->mm->mmap_sem);
+	ret = get_user_pages(current, current->mm, uaddr, nr_pages, read, 0,
+								pages, NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (ret < nr_pages)
+		goto out;
+
+	bio->bi_bdev = bdev;
+
+	offset = uaddr & ~PAGE_MASK;
+	for (i = 0; i < nr_pages; i++) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (len <= 0)
+			break;
+
+		if (bytes > len)
+			bytes = len;
+
+		/*
+		 * sorry...
+		 */
+		if (bio_add_page(bio, pages[i], bytes, offset) < bytes)
+			break;
+
+		len -= bytes;
+		offset = 0;
+	}
+
+	/*
+	 * release the pages we didn't map into the bio, if any
+	 */
+	while (i < nr_pages)
+		page_cache_release(pages[i++]);
+
+	bio->bi_end_io = bio_user_end_io;
+	kfree(pages);
+	return bio;
+out:
+	kfree(pages);
+	bio_put(bio);
+	return NULL;
+}
+
+/**
  * bio_endio - end I/O on a bio
  * @bio:	bio
  * @bytes_done:	number of bytes completed
@@ -536,7 +642,7 @@
 	return 0;
 }
 
-module_init(init_bio);
+subsys_initcall(init_bio);
 
 EXPORT_SYMBOL(bio_alloc);
 EXPORT_SYMBOL(bio_put);
@@ -549,3 +655,4 @@
 EXPORT_SYMBOL(bio_hw_segments);
 EXPORT_SYMBOL(bio_add_page);
 EXPORT_SYMBOL(bio_get_nr_vecs);
+EXPORT_SYMBOL(bio_map_user);
===== fs/direct-io.c 1.14 vs edited =====
--- 1.14/fs/direct-io.c	Sun Oct 13 00:45:44 2002
+++ edited/fs/direct-io.c	Thu Oct 17 21:00:38 2002
@@ -417,7 +417,7 @@
 
 	/* Take a ref against the page each time it is placed into a BIO */
 	page_cache_get(page);
-	if (bio_add_page(dio->bio, page, bv_len, bv_offset)) {
+	if (bio_add_page(dio->bio, page, bv_len, bv_offset) < bv_len) {
 		dio_bio_submit(dio);
 		ret = dio_new_bio(dio, blkno);
 		if (ret == 0) {
===== fs/mpage.c 1.25 vs edited =====
--- 1.25/fs/mpage.c	Wed Oct 16 02:30:10 2002
+++ edited/fs/mpage.c	Fri Oct 18 16:49:49 2002
@@ -176,6 +176,7 @@
 	unsigned first_hole = blocks_per_page;
 	struct block_device *bdev = NULL;
 	struct buffer_head bh;
+	int length;
 
 	if (page_has_buffers(page))
 		goto confused;
@@ -233,7 +234,8 @@
 			goto confused;
 	}
 
-	if (bio_add_page(bio, page, first_hole << blkbits, 0)) {
+	length = first_hole << blkbits;
+	if (bio_add_page(bio, page, length, 0) < length) {
 		bio = mpage_bio_submit(READ, bio);
 		goto alloc_new;
 	}
@@ -334,6 +336,7 @@
 	int boundary = 0;
 	sector_t boundary_block = 0;
 	struct block_device *boundary_bdev = NULL;
+	int length;
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -467,7 +470,8 @@
 			try_to_free_buffers(page);
 	}
 
-	if (bio_add_page(bio, page, first_unmapped << blkbits, 0)) {
+	length = first_unmapped << blkbits;
+	if (bio_add_page(bio, page, length, 0) < length) {
 		bio = mpage_bio_submit(WRITE, bio);
 		goto alloc_new;
 	}
===== fs/xfs/pagebuf/page_buf.c 1.15 vs edited =====
--- 1.15/fs/xfs/pagebuf/page_buf.c	Mon Oct 14 22:54:12 2002
+++ edited/fs/xfs/pagebuf/page_buf.c	Thu Oct 17 20:53:30 2002
@@ -1448,7 +1448,7 @@
 		if (nbytes > size)
 			nbytes = size;
 
-		if (bio_add_page(bio, pb->pb_pages[map_i], nbytes, offset))
+		if (bio_add_page(bio, pb->pb_pages[map_i], nbytes, offset) < nbytes)
 			break;
 
 		offset = 0;
===== include/linux/bio.h 1.22 vs edited =====
--- 1.22/include/linux/bio.h	Tue Oct  8 13:27:47 2002
+++ edited/include/linux/bio.h	Thu Oct 17 17:46:01 2002
@@ -131,6 +131,7 @@
 #define bio_page(bio)		bio_iovec((bio))->bv_page
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
+#define bio_cur_sectors(bio)	(bio_iovec(bio)->bv_len >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
 #define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_RW_BARRIER))
 
@@ -214,6 +215,8 @@
 
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_get_nr_vecs(struct block_device *);
+extern struct bio *bio_map_user(struct block_device *, unsigned long,
+				unsigned int, int);
 
 #ifdef CONFIG_HIGHMEM
 /*
===== include/linux/blkdev.h 1.75 vs edited =====
--- 1.75/include/linux/blkdev.h	Tue Oct 15 22:55:04 2002
+++ edited/include/linux/blkdev.h	Thu Oct 17 20:46:51 2002
@@ -219,6 +219,12 @@
 	wait_queue_head_t	queue_wait;
 
 	struct blk_queue_tag	*queue_tags;
+
+	/*
+	 * sg stuff
+	 */
+	unsigned int		sg_timeout;
+	unsigned int		sg_reserved_size;
 };
 
 #define RQ_INACTIVE		(-1)
@@ -235,6 +241,7 @@
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_empty(q)	elv_queue_empty(q)
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
+#define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		((rq)->flags & 1)

-- 
Jens Axboe


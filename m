Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUCCLi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUCCLi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:38:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262444AbUCCLh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:37:58 -0500
Date: Wed, 3 Mar 2004 12:37:56 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040303113756.GQ9196@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
optimal of course... This patch uses the block layer infrastructure to
enable zero copy DMA ripping through CDROMREADAUDIO.

I'd appreciate people giving this a test spin. Patch is against
2.6.4-rc1 (well current BK, actually).

===== drivers/block/ll_rw_blk.c 1.228 vs edited =====
--- 1.228/drivers/block/ll_rw_blk.c	Sun Feb  1 19:09:12 2004
+++ edited/drivers/block/ll_rw_blk.c	Wed Mar  3 11:34:38 2004
@@ -28,6 +28,11 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 
+/*
+ * for max sense size
+ */
+#include <scsi/scsi_cmnd.h>
+
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
 
@@ -1756,6 +1761,138 @@
 }
 
 EXPORT_SYMBOL(blk_insert_request);
+
+/**
+ * blk_rq_map_user - map user data to a request, for REQ_BLOCK_PC usage
+ * @q:		request queue where request should be inserted
+ * @rw:		READ or WRITE data
+ * @ubuf:	the user buffer
+ * @len:	length of user data
+ *
+ * Description:
+ *    Data will be mapped directly for zero copy io, if possible. Otherwise
+ *    a kernel bounce buffer is used.
+ *
+ *    A matching blk_rq_unmap_user() must be issued at the end of io, while
+ *    still in process context.
+ */
+struct request *blk_rq_map_user(request_queue_t *q, int rw, void __user *ubuf,
+				unsigned int len)
+{
+	struct request *rq = NULL;
+	char *buf = NULL;
+	struct bio *bio;
+
+	rq = blk_get_request(q, rw, __GFP_WAIT);
+	if (!rq)
+		return NULL;
+
+	bio = bio_map_user(q, NULL, (unsigned long) ubuf, len, rw == READ);
+	if (!bio) {
+		buf = kmalloc(len, q->bounce_gfp | GFP_USER);
+		if (!buf)
+			goto fault;
+
+		if (rw == WRITE) {
+			if (copy_from_user(buf, ubuf, len))
+				goto fault;
+		} else
+			memset(buf, 0, len);
+	}
+
+	rq->bio = rq->biotail = bio;
+	if (rq->bio)
+		blk_rq_bio_prep(q, rq, bio);
+
+	rq->buffer = rq->data = buf;
+	rq->data_len = len;
+	return rq;
+fault:
+	if (buf)
+		kfree(buf);
+	if (bio)
+		bio_unmap_user(bio, 1);
+	if (rq)
+		blk_put_request(rq);
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(blk_rq_map_user);
+
+/**
+ * blk_rq_unmap_user - unmap a request with user data
+ * @rq:		request to be unmapped
+ * @ubuf:	user buffer
+ * @ulen:	length of user buffer
+ * @rw:		operation was a READ or WRITE
+ *
+ * Description:
+ *    Unmap a request previously mapped by blk_rq_map_user().
+ */
+int blk_rq_unmap_user(struct request *rq, void __user *ubuf, unsigned int ulen,
+		      int rw)
+{
+	int ret = 0;
+
+	if (rq->biotail)
+		bio_unmap_user(rq->biotail, rw == READ);
+	if (rq->buffer) {
+		if (rw == READ && copy_to_user(ubuf, rq->buffer, ulen))
+			ret = -EFAULT;
+		kfree(rq->buffer);
+	}
+
+	blk_put_request(rq);
+	return ret;
+}
+
+EXPORT_SYMBOL(blk_rq_unmap_user);
+
+/**
+ * blk_execute_rq - insert a request into queue for execution
+ * @q:		queue to insert the request in
+ * @bd_disk:	matching gendisk
+ * @rq:		request to insert
+ *
+ * Description:
+ *    Insert a fully prepared request at the back of the io scheduler queue
+ *    for execution.
+ */
+int blk_execute_rq(request_queue_t *q, struct gendisk *bd_disk,
+		   struct request *rq)
+{
+	DECLARE_COMPLETION(wait);
+	char sense[SCSI_SENSE_BUFFERSIZE];
+	int err = 0;
+
+	rq->rq_disk = bd_disk;
+
+	/*
+	 * we need an extra reference to the request, so we can look at
+	 * it after io completion
+	 */
+	rq->ref_count++;
+
+	if (!rq->sense) {
+		memset(sense, 0, sizeof(sense));
+		rq->sense = sense;
+		rq->sense_len = 0;
+	}
+
+	rq->flags |= REQ_NOMERGE;
+	rq->waiting = &wait;
+	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
+	generic_unplug_device(q);
+	wait_for_completion(&wait);
+
+	if (rq->errors)
+		err = -EIO;
+
+	return err;
+}
+
+EXPORT_SYMBOL(blk_execute_rq);
 
 void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
 {
===== drivers/block/scsi_ioctl.c 1.40 vs edited =====
--- 1.40/drivers/block/scsi_ioctl.c	Sun Feb  1 12:53:03 2004
+++ edited/drivers/block/scsi_ioctl.c	Wed Mar  3 11:28:07 2004
@@ -30,7 +30,7 @@
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
-
+#include <scsi/scsi_cmnd.h>
 
 /* Command group 3 is reserved and should never be used.  */
 const unsigned char scsi_command_size[8] =
@@ -41,44 +41,6 @@
 
 #define BLK_DEFAULT_TIMEOUT	(60 * HZ)
 
-/* defined in ../scsi/scsi.h  ... should it be included? */
-#ifndef SCSI_SENSE_BUFFERSIZE
-#define SCSI_SENSE_BUFFERSIZE 64
-#endif
-
-static int blk_do_rq(request_queue_t *q, struct gendisk *bd_disk,
-		     struct request *rq)
-{
-	char sense[SCSI_SENSE_BUFFERSIZE];
-	DECLARE_COMPLETION(wait);
-	int err = 0;
-
-	rq->rq_disk = bd_disk;
-
-	/*
-	 * we need an extra reference to the request, so we can look at
-	 * it after io completion
-	 */
-	rq->ref_count++;
-
-	if (!rq->sense) {
-		memset(sense, 0, sizeof(sense));
-		rq->sense = sense;
-		rq->sense_len = 0;
-	}
-
-	rq->flags |= REQ_NOMERGE;
-	rq->waiting = &wait;
-	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
-	generic_unplug_device(q);
-	wait_for_completion(&wait);
-
-	if (rq->errors)
-		err = -EIO;
-
-	return err;
-}
-
 #include <scsi/sg.h>
 
 static int sg_get_version(int *p)
@@ -246,7 +208,7 @@
 	 * (if he doesn't check that is his problem).
 	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
 	 */
-	blk_do_rq(q, bd_disk, rq);
+	blk_execute_rq(q, bd_disk, rq);
 
 	if (bio)
 		bio_unmap_user(bio, reading);
@@ -369,7 +331,7 @@
 	rq->data_len = bytes;
 	rq->flags |= REQ_BLOCK_PC;
 
-	blk_do_rq(q, bd_disk, rq);
+	blk_execute_rq(q, bd_disk, rq);
 	err = rq->errors & 0xff;	/* only 8 bit SCSI status */
 	if (err) {
 		if (rq->sense_len && rq->sense) {
@@ -529,7 +491,7 @@
 			rq->cmd[0] = GPCMD_START_STOP_UNIT;
 			rq->cmd[4] = 0x02 + (close != 0);
 			rq->cmd_len = 6;
-			err = blk_do_rq(q, bd_disk, rq);
+			err = blk_execute_rq(q, bd_disk, rq);
 			blk_put_request(rq);
 			break;
 		default:
===== drivers/cdrom/cdrom.c 1.48 vs edited =====
--- 1.48/drivers/cdrom/cdrom.c	Mon Feb  9 21:58:21 2004
+++ edited/drivers/cdrom/cdrom.c	Wed Mar  3 12:34:01 2004
@@ -406,6 +406,11 @@
 	if (CDROM_CAN(CDC_MRW_W))
 		cdi->exit = cdrom_mrw_exit;
 
+	if (cdi->disk)
+		cdi->cdda_method = CDDA_BPC_FULL;
+	else
+		cdi->cdda_method = CDDA_OLD;
+
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
 	spin_lock(&cdrom_lock);
 	cdi->next = topCdromPtr; 	
@@ -1788,6 +1793,142 @@
 	return cdo->generic_packet(cdi, cgc);
 }
 
+static int cdrom_read_cdda_old(struct cdrom_device_info *cdi, __u8 __user *ubuf,
+			       int lba, int nframes)
+{
+	struct cdrom_generic_command cgc;
+	int nr, ret;
+
+	memset(&cgc, 0, sizeof(cgc));
+
+	/*
+	 * start with will ra.nframes size, back down if alloc fails
+	 */
+	nr = nframes;
+	do {
+		cgc.buffer = kmalloc(CD_FRAMESIZE_RAW * nr, GFP_KERNEL);
+		if (cgc.buffer)
+			break;
+
+		nr >>= 1;
+	} while (nr);
+
+	if (!nr)
+		return -ENOMEM;
+
+	if (!access_ok(VERIFY_WRITE, ubuf, nframes * CD_FRAMESIZE_RAW)) {
+		kfree(cgc.buffer);
+		return -EFAULT;
+	}
+
+	cgc.data_direction = CGC_DATA_READ;
+	while (nframes > 0) {
+		if (nr > nframes)
+			nr = nframes;
+
+		ret = cdrom_read_block(cdi, &cgc, lba, nr, 1, CD_FRAMESIZE_RAW);
+		if (ret)
+			break;
+		__copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr);
+		ubuf += CD_FRAMESIZE_RAW * nr;
+		nframes -= nr;
+		lba += nr;
+	}
+	kfree(cgc.buffer);
+	return 0;
+}
+
+static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
+			       int lba, int nframes)
+{
+	request_queue_t *q = cdi->disk->queue;
+	struct request *rq;
+	unsigned int len;
+	int nr, ret = 0;
+
+	if (!q)
+		return -ENXIO;
+
+	while (nframes) {
+		nr = nframes;
+		if (cdi->cdda_method == CDDA_BPC_SINGLE)
+			nr = 1;
+		if (nr * CD_FRAMESIZE_RAW > (q->max_sectors << 9))
+			nr = (q->max_sectors << 9) / CD_FRAMESIZE_RAW;
+
+		len = nr * CD_FRAMESIZE_RAW;
+
+		rq = blk_rq_map_user(q, READ, ubuf, len);
+		if (!rq)
+			return -ENOMEM;
+
+		memset(rq->cmd, 0, sizeof(rq->cmd));
+		rq->cmd[0] = GPCMD_READ_CD;
+		rq->cmd[1] = 1 << 2;
+		rq->cmd[2] = (lba >> 24) & 0xff;
+		rq->cmd[3] = (lba >> 16) & 0xff;
+		rq->cmd[4] = (lba >>  8) & 0xff;
+		rq->cmd[5] = lba & 0xff;
+		rq->cmd[6] = (nr >> 16) & 0xff;
+		rq->cmd[7] = (nr >>  8) & 0xff;
+		rq->cmd[8] = nr & 0xff;
+		rq->cmd[9] = 0xf8;
+
+		rq->cmd_len = 12;
+		rq->flags |= REQ_BLOCK_PC;
+		rq->timeout = 60 * HZ;
+
+		if (blk_execute_rq(q, cdi->disk, rq)) {
+			struct request_sense *s = rq->sense;
+			ret = -EIO;
+			printk("cdrom: cdda rip sense %02x/%02x/%02x\n", s->sense_key, s->asc, s->ascq);
+		}
+
+		if (blk_rq_unmap_user(rq, ubuf, len, READ))
+			ret = -EFAULT;
+
+		if (ret)
+			break;
+
+		nframes -= nr;
+		lba += nr;
+	}
+
+	return ret;
+}
+
+static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
+			   int lba, int nframes)
+{
+	int ret;
+
+	if (cdi->cdda_method == CDDA_OLD)
+		return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);
+
+	do {
+		ret = cdrom_read_cdda_bpc(cdi, ubuf, lba, nframes);
+
+		if (!ret)
+			break;
+
+		/*
+		 * I've seen drives get sense 4/8/3 udma crc errors, so
+		 * drop to single frame dma if we need to
+		 */
+		if (cdi->cdda_method == CDDA_BPC_FULL && nframes > 1) {
+			printk("cdrom: dropping to single frame dma\n");
+			cdi->cdda_method = CDDA_BPC_SINGLE;
+			continue;
+		}
+
+		printk("cdrom: dropping to old style cdda\n");
+		cdi->cdda_method = CDDA_OLD;
+		ret = cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
+	} while (0);
+
+	return ret;
+}
+
 /* Just about every imaginable ioctl is supported in the Uniform layer
  * these days. ATAPI / SCSI specific code now mainly resides in
  * mmc_ioct().
@@ -2280,7 +2421,7 @@
 		}
 	case CDROMREADAUDIO: {
 		struct cdrom_read_audio ra;
-		int lba, nr;
+		int lba;
 
 		IOCTL_IN(arg, struct cdrom_read_audio, ra);
 
@@ -2297,40 +2438,7 @@
 		if (lba < 0 || ra.nframes <= 0 || ra.nframes > CD_FRAMES)
 			return -EINVAL;
 
-		/*
-		 * start with will ra.nframes size, back down if alloc fails
-		 */
-		nr = ra.nframes;
-		do {
-			cgc.buffer = kmalloc(CD_FRAMESIZE_RAW * nr, GFP_KERNEL);
-			if (cgc.buffer)
-				break;
-
-			nr >>= 1;
-		} while (nr);
-
-		if (!nr)
-			return -ENOMEM;
-
-		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
-			kfree(cgc.buffer);
-			return -EFAULT;
-		}
-		cgc.data_direction = CGC_DATA_READ;
-		while (ra.nframes > 0) {
-			if (nr > ra.nframes)
-				nr = ra.nframes;
-
-			ret = cdrom_read_block(cdi, &cgc, lba, nr, 1, CD_FRAMESIZE_RAW);
-			if (ret)
-				break;
-			__copy_to_user(ra.buf, cgc.buffer, CD_FRAMESIZE_RAW*nr);
-			ra.buf += CD_FRAMESIZE_RAW * nr;
-			ra.nframes -= nr;
-			lba += nr;
-		}
-		kfree(cgc.buffer);
-		return ret;
+		return cdrom_read_cdda(cdi, ra.buf, lba, ra.nframes);
 		}
 	case CDROMSUBCHNL: {
 		struct cdrom_subchnl q;
===== drivers/ide/ide-cd.c 1.72 vs edited =====
--- 1.72/drivers/ide/ide-cd.c	Thu Feb 19 02:09:06 2004
+++ edited/drivers/ide/ide-cd.c	Wed Mar  3 12:24:21 2004
@@ -2931,6 +2931,7 @@
 	if (!CDROM_CONFIG_FLAGS(drive)->mrw_w)
 		devinfo->mask |= CDC_MRW_W;
 
+	devinfo->disk = drive->disk;
 	return register_cdrom(devinfo);
 }
 
===== drivers/scsi/sr.c 1.99 vs edited =====
--- 1.99/drivers/scsi/sr.c	Mon Feb 23 15:20:57 2004
+++ edited/drivers/scsi/sr.c	Wed Mar  3 11:28:07 2004
@@ -566,13 +566,16 @@
 	snprintf(disk->devfs_name, sizeof(disk->devfs_name),
 			"%s/cd", sdev->devfs_name);
 	disk->driverfs_dev = &sdev->sdev_gendev;
-	register_cdrom(&cd->cdi);
 	set_capacity(disk, cd->capacity);
 	disk->private_data = &cd->driver;
 	disk->queue = sdev->request_queue;
+	cd->cdi.disk = disk;
 
 	dev_set_drvdata(dev, cd);
 	add_disk(disk);
+
+	if (register_cdrom(&cd->cdi))
+		goto fail_put;
 
 	printk(KERN_DEBUG
 	    "Attached scsi CD-ROM %s at scsi%d, channel %d, id %d, lun %d\n",
===== include/linux/blkdev.h 1.134 vs edited =====
--- 1.134/include/linux/blkdev.h	Sun Feb  1 12:53:03 2004
+++ edited/include/linux/blkdev.h	Wed Mar  3 11:28:07 2004
@@ -514,6 +514,9 @@
 extern void __blk_stop_queue(request_queue_t *q);
 extern void blk_run_queue(request_queue_t *q);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
+extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
+extern int blk_rq_unmap_user(struct request *, void __user *, unsigned int, int);
+extern int blk_execute_rq(request_queue_t *, struct gendisk *, struct request *);
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)
 {
===== include/linux/cdrom.h 1.16 vs edited =====
--- 1.16/include/linux/cdrom.h	Wed Feb  4 06:37:42 2004
+++ edited/include/linux/cdrom.h	Wed Mar  3 12:00:29 2004
@@ -877,10 +877,15 @@
 #include <linux/fs.h>		/* not really needed, later.. */
 #include <linux/device.h>
 
+#define CDDA_OLD		0	/* old style */
+#define CDDA_BPC_SINGLE		1	/* block_pc, but single frame  */
+#define CDDA_BPC_FULL		2	/* full speed block pc */
+
 /* Uniform cdrom data structures for cdrom.c */
 struct cdrom_device_info {
 	struct cdrom_device_ops  *ops;  /* link to device_ops */
 	struct cdrom_device_info *next; /* next device_info for this major */
+	struct gendisk *disk;		/* matching block layer disk */
 	void *handle;		        /* driver-dependent data */
 /* specifications */
 	int mask;                       /* mask of capability: disables them */
@@ -894,6 +899,7 @@
 /* per-device flags */
         __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
         __u8 reserved		: 6;	/* not used yet */
+	int cdda_method;		/* see flags */
 	int for_data;
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;

-- 
Jens Axboe


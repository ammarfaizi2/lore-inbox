Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTE3Mtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTE3Mtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 08:49:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53724 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263631AbTE3MtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 08:49:11 -0400
Date: Fri, 30 May 2003 15:02:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] SG_IO readcd and various bugs
Message-ID: <20030530130230.GD813@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below patch should make readcd (and others) behave, please test.

===== drivers/block/ioctl.c 1.54 vs edited =====
--- 1.54/drivers/block/ioctl.c	Sat Apr 26 00:16:28 2003
+++ edited/drivers/block/ioctl.c	Fri May 30 10:25:55 2003
@@ -207,11 +207,8 @@
 		set_device_ro(bdev, n);
 		return 0;
 	default:
-		if (disk->fops->ioctl) {
-			ret = disk->fops->ioctl(inode, file, cmd, arg);
-			if (ret != -EINVAL)
-				return ret;
-		}
+		if (disk->fops->ioctl)
+			return disk->fops->ioctl(inode, file, cmd, arg);
 	}
 	return -ENOTTY;
 }
===== drivers/block/scsi_ioctl.c 1.27 vs edited =====
--- 1.27/drivers/block/scsi_ioctl.c	Sat May 17 12:05:21 2003
+++ edited/drivers/block/scsi_ioctl.c	Fri May 30 15:00:08 2003
@@ -68,7 +68,6 @@
 
 	rq->flags |= REQ_NOMERGE;
 	rq->waiting = &wait;
-        drive_stat_acct(rq, rq->nr_sectors, 1);
 	elv_add_request(q, rq, 1, 1);
 	generic_unplug_device(q);
 	wait_for_completion(&wait);
@@ -99,7 +98,7 @@
 
 static int sg_get_timeout(request_queue_t *q)
 {
-	return q->sg_timeout;
+	return q->sg_timeout / (HZ / USER_HZ);
 }
 
 static int sg_set_timeout(request_queue_t *q, int *p)
@@ -107,7 +106,7 @@
 	int timeout, err = get_user(timeout, p);
 
 	if (!err)
-		q->sg_timeout = timeout;
+		q->sg_timeout = timeout * (HZ / USER_HZ);
 
 	return err;
 }
@@ -121,10 +120,14 @@
 {
 	int size, err = get_user(size, p);
 
-	if (!err)
-		q->sg_reserved_size = size;
+	if (err)
+		return err;
 
-	return err;
+	if (size > (q->max_sectors << 9))
+		return -EINVAL;
+
+	q->sg_reserved_size = size;
+	return 0;
 }
 
 /*
@@ -139,16 +142,14 @@
 static int sg_io(request_queue_t *q, struct block_device *bdev,
 		 struct sg_io_hdr *uptr)
 {
-	unsigned long uaddr, start_time;
-	int reading, writing, nr_sectors;
+	unsigned long start_time;
+	int reading, writing;
 	struct sg_io_hdr hdr;
 	struct request *rq;
 	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	void *buffer;
 
-	if (!access_ok(VERIFY_WRITE, uptr, sizeof(*uptr)))
-		return -EFAULT;
 	if (copy_from_user(&hdr, uptr, sizeof(*uptr)))
 		return -EFAULT;
 
@@ -156,11 +157,6 @@
 		return -EINVAL;
 	if (hdr.cmd_len > sizeof(rq->cmd))
 		return -EINVAL;
-	if (!access_ok(VERIFY_READ, hdr.cmdp, hdr.cmd_len))
-		return -EFAULT;
-
-	if (hdr.dxfer_len > 65536)
-		return -EINVAL;
 
 	/*
 	 * we'll do that later
@@ -168,7 +164,9 @@
 	if (hdr.iovec_count)
 		return -EOPNOTSUPP;
 
-	nr_sectors = 0;
+	if (hdr.dxfer_len > (q->max_sectors << 9))
+		return -EIO;
+
 	reading = writing = 0;
 	buffer = NULL;
 	bio = NULL;
@@ -189,19 +187,12 @@
 			break;
 		}
 
-		uaddr = (unsigned long) hdr.dxferp;
-		/* writing to device -> reading from vm */
-		if (writing && !access_ok(VERIFY_READ, uaddr, bytes))
-			return -EFAULT;
-		/* reading from device -> writing to vm */
-		else if (reading && !access_ok(VERIFY_WRITE, uaddr, bytes))
-			return -EFAULT;
-
 		/*
 		 * first try to map it into a bio. reading from device will
 		 * be a write to vm.
 		 */
-		bio = bio_map_user(bdev, uaddr, hdr.dxfer_len, reading);
+		bio = bio_map_user(bdev, (unsigned long) hdr.dxferp,
+				   hdr.dxfer_len, reading);
 
 		/*
 		 * if bio setup failed, fall back to slow approach
@@ -211,10 +202,11 @@
 			if (!buffer)
 				return -ENOMEM;
 
-			nr_sectors = bytes >> 9;
-			if (writing)
-				copy_from_user(buffer,hdr.dxferp,hdr.dxfer_len);
-			else
+			if (writing) {
+				if (copy_from_user(buffer, hdr.dxferp,
+						   hdr.dxfer_len))
+					goto out_buffer;
+			} else
 				memset(buffer, 0, hdr.dxfer_len);
 		}
 	}
@@ -225,7 +217,8 @@
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr.cmd_len;
-	copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len);
+	if (copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len))
+		goto out_request;
 	if (sizeof(rq->cmd) != hdr.cmd_len)
 		memset(rq->cmd + hdr.cmd_len, 0, sizeof(rq->cmd) - hdr.cmd_len);
 
@@ -235,18 +228,15 @@
 
 	rq->flags |= REQ_BLOCK_PC;
 
-	rq->hard_nr_sectors = rq->nr_sectors = nr_sectors;
-	rq->hard_cur_sectors = rq->current_nr_sectors = nr_sectors;
-
-	rq->bio = rq->biotail = bio;
+	rq->bio = rq->biotail = NULL;
 
 	if (bio)
 		blk_rq_bio_prep(q, rq, bio);
 
-	rq->data_len = hdr.dxfer_len;
 	rq->data = buffer;
+	rq->data_len = hdr.dxfer_len;
 
-	rq->timeout = hdr.timeout;
+	rq->timeout = (hdr.timeout * HZ) / 1000;
 	if (!rq->timeout)
 		rq->timeout = q->sg_timeout;
 	if (!rq->timeout)
@@ -273,7 +263,7 @@
 	if (hdr.masked_status || hdr.host_status || hdr.driver_status)
 		hdr.info |= SG_INFO_CHECK;
 	hdr.resid = rq->data_len;
-	hdr.duration = (jiffies - start_time) * (1000 / HZ);
+	hdr.duration = ((jiffies - start_time) * 1000) / HZ;
 	hdr.sb_len_wr = 0;
 
 	if (rq->sense_len && hdr.sbp) {
@@ -286,17 +276,25 @@
 
 	blk_put_request(rq);
 
-	copy_to_user(uptr, &hdr, sizeof(*uptr));
+	if (copy_to_user(uptr, &hdr, sizeof(*uptr)))
+		goto out_buffer;
 
 	if (buffer) {
 		if (reading)
-			copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len);
+			if (copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len))
+				goto out_buffer;
 
 		kfree(buffer);
 	}
+
 	/* may not have succeeded, but output values written to control
 	 * structure (struct sg_io_hdr).  */
 	return 0;
+out_request:
+	blk_put_request(rq);
+out_buffer:
+	kfree(buffer);
+	return -EFAULT;
 }
 
 #define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
===== drivers/ide/ide-cd.c 1.46 vs edited =====
--- 1.46/drivers/ide/ide-cd.c	Thu May  8 10:39:34 2003
+++ edited/drivers/ide/ide-cd.c	Fri May 30 14:38:59 2003
@@ -666,8 +666,10 @@
 		struct cdrom_info *info = drive->driver_data;
 		void *sense = &info->sense_data;
 		
-		if (failed && failed->sense)
+		if (failed && failed->sense) {
 			sense = failed->sense;
+			failed->sense_len = rq->sense_len;
+		}
 
 		cdrom_analyze_sense_data(drive, failed, sense);
 	}
@@ -723,7 +725,7 @@
 		 * scsi status byte
 		 */
 		if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
-			rq->errors = CHECK_CONDITION;
+			rq->errors = SAM_STAT_CHECK_CONDITION;
 
 		/* Check for tray open. */
 		if (sense_key == NOT_READY) {
@@ -1609,10 +1611,18 @@
 
 static void post_transform_command(struct request *req)
 {
-	char *ibuf = req->buffer;
 	u8 *c = req->cmd;
+	char *ibuf;
 
 	if (!blk_pc_request(req))
+		return;
+
+	if (req->bio)
+		ibuf = bio_data(req->bio);
+	else
+		ibuf = req->data;
+
+	if (!ibuf)
 		return;
 
 	/*
===== fs/bio.c 1.45 vs edited =====
--- 1.45/fs/bio.c	Tue May 27 03:53:39 2003
+++ edited/fs/bio.c	Fri May 30 14:32:56 2003
@@ -538,12 +538,6 @@
 	bio = __bio_map_user(bdev, uaddr, len, write_to_vm);
 
 	if (bio) {
-		if (bio->bi_size < len) {
-			bio_endio(bio, bio->bi_size, 0);
-			bio_unmap_user(bio, 0);
-			return NULL;
-		}
-
 		/*
 		 * subtle -- if __bio_map_user() ended up bouncing a bio,
 		 * it would normally disappear when its bi_end_io is run.
@@ -551,6 +545,12 @@
 		 * reference to it
 		 */
 		bio_get(bio);
+
+		if (bio->bi_size < len) {
+			bio_endio(bio, bio->bi_size, 0);
+			bio_unmap_user(bio, 0);
+			return NULL;
+		}
 	}
 
 	return bio;

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHDIyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHDIyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 04:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHDIyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 04:54:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9088 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261300AbUHDIuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 04:50:18 -0400
Date: Wed, 4 Aug 2004 10:50:01 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: block layer sg, bsg
Message-ID: <20040804085000.GH10340@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a little project I've been tinkering with in my copius spare
time. Since it's been mentioned a few times (as bsg), I thought I'd at
least try and post something. Lately Peter Jones has been contributing
changes as well.

This is a block layer implementation of the SG (SCSI generic) character
device, supporting only the sg v3 interface (this is on purpose, older
ones are not worth supporting since they suck). It allows you to talk to
a device synchronously through the SG_IO ioctl and async through
regular read(2) and write(2). Additionally, there's a readv/writev
interface where you pass the seperate elements of the sg_io_hdr as iovec
entries. This is mainly handy for debugging purposes (you can watch what
happens with strace closely), and I'm not quite sure this will even stay
in the future.

There's just one character device, /dev/bsg. You open this control
device and issue a BSG_IOC_ADD ioctl to bind it to any given device, and
then talk to it through that file descriptor. I've attached a silly test
app that just reads randomly from a device as a show case.

Patch is against 2.6-BK as of this morning.

===== drivers/block/Kconfig 1.25 vs edited =====
--- 1.25/drivers/block/Kconfig	2004-08-02 10:00:43 +02:00
+++ edited/drivers/block/Kconfig	2004-08-04 08:28:53 +02:00
@@ -301,6 +301,12 @@
 
 	  Use devices /dev/sx8/$N and /dev/sx8/$Np$M.
 
+config BLK_DEV_BSG
+	tristate "Block layer SG support"
+	---help---
+	  Saying Y or M here will enable generic SG (SCSI generic) v3
+	  support for any block device.
+
 config BLK_DEV_RAM
 	tristate "RAM disk support"
 	---help---
===== drivers/block/Makefile 1.26 vs edited =====
--- 1.26/drivers/block/Makefile	2004-06-21 20:52:50 +02:00
+++ edited/drivers/block/Makefile	2004-08-04 08:28:53 +02:00
@@ -42,4 +42,5 @@
 
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
+obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
 
===== drivers/block/ll_rw_blk.c 1.261 vs edited =====
--- 1.261/drivers/block/ll_rw_blk.c	2004-08-03 08:10:56 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2004-08-04 10:39:00 +02:00
@@ -1657,6 +1657,7 @@
 	rq->data_len = 0;
 	rq->data = NULL;
 	rq->sense = NULL;
+	rq->end_io = NULL;
 
 out:
 	put_io_context(ioc);
@@ -1891,6 +1892,25 @@
 EXPORT_SYMBOL(blk_rq_unmap_user);
 
 /**
+ * blk_end_sync_rq - executes a completion event on a request
+ * @rq: request to complete
+ */
+void blk_end_sync_rq(struct request *rq)
+{
+	struct completion *waiting = rq->waiting;
+
+	rq->waiting = NULL;
+	__blk_put_request(rq->q, rq);
+
+	/*
+	 * complete last, if this is a stack request the process (and thus
+	 * the rq pointer) could be invalid right after this complete()
+	 */
+	complete(waiting);
+}
+EXPORT_SYMBOL(blk_end_sync_rq);
+
+/**
  * blk_execute_rq - insert a request into queue for execution
  * @q:		queue to insert the request in
  * @bd_disk:	matching gendisk
@@ -1923,6 +1943,7 @@
 
 	rq->flags |= REQ_NOMERGE;
 	rq->waiting = &wait;
+	rq->end_io = blk_end_sync_rq;
 	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
 	generic_unplug_device(q);
 	wait_for_completion(&wait);
@@ -2014,6 +2035,7 @@
 
 	if (unlikely(!q))
 		return;
+
 	if (unlikely(--req->ref_count))
 		return;
 
@@ -2784,7 +2806,6 @@
 void end_that_request_last(struct request *req)
 {
 	struct gendisk *disk = req->rq_disk;
-	struct completion *waiting = req->waiting;
 
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
@@ -2804,10 +2825,10 @@
 		disk_round_stats(disk);
 		disk->in_flight--;
 	}
-	__blk_put_request(req->q, req);
-	/* Do this LAST! The structure may be freed immediately afterwards */
-	if (waiting)
-		complete(waiting);
+	if (req->end_io)
+		req->end_io(req);
+	else
+		__blk_put_request(req->q, req);
 }
 
 EXPORT_SYMBOL(end_that_request_last);
@@ -2828,16 +2849,21 @@
 	/* first three bits are identical in rq->flags and bio->bi_rw */
 	rq->flags |= (bio->bi_rw & 7);
 
-	rq->nr_phys_segments = bio_phys_segments(q, bio);
-	rq->nr_hw_segments = bio_hw_segments(q, bio);
+	rq->nr_sectors = bio_sectors(bio);
 	rq->current_nr_sectors = bio_cur_sectors(bio);
+
+	rq->hard_nr_sectors = rq->nr_sectors;
 	rq->hard_cur_sectors = rq->current_nr_sectors;
-	rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
+
 	rq->nr_cbio_segments = bio_segments(bio);
 	rq->nr_cbio_sectors = bio_sectors(bio);
-	rq->buffer = bio_data(bio);
 
 	rq->cbio = rq->bio = rq->biotail = bio;
+
+	rq->nr_phys_segments = bio_phys_segments(q, bio);
+	rq->nr_hw_segments = bio_hw_segments(q, bio);
+	rq->buffer = bio_data(bio);
+	rq->data_len = bio->bi_size;
 }
 
 EXPORT_SYMBOL(blk_rq_bio_prep);
===== drivers/block/scsi_ioctl.c 1.48 vs edited =====
--- 1.48/drivers/block/scsi_ioctl.c	2004-08-03 08:10:56 +02:00
+++ edited/drivers/block/scsi_ioctl.c	2004-08-04 08:33:30 +02:00
@@ -40,10 +40,94 @@
 
 EXPORT_SYMBOL(scsi_command_size);
 
-#define BLK_DEFAULT_TIMEOUT	(60 * HZ)
-
 #include <scsi/sg.h>
 
+int blk_fill_sghdr_rq(request_queue_t *q, struct request *rq,
+		      struct sg_io_hdr *hdr)
+{
+	if (copy_from_user(rq->cmd, hdr->cmdp, hdr->cmd_len))
+		return -EFAULT;
+
+	/*
+	 * fill in request structure
+	 */
+	rq->cmd_len = hdr->cmd_len;
+	if (sizeof(rq->cmd) != hdr->cmd_len) {
+		unsigned end = sizeof(rq->cmd) - hdr->cmd_len;
+		memset(rq->cmd + hdr->cmd_len, 0, end);
+	}
+
+	rq->flags |= REQ_BLOCK_PC;
+
+	rq->timeout = (hdr->timeout * HZ) / 1000;
+	if (!rq->timeout)
+		rq->timeout = q->sg_timeout;
+	if (!rq->timeout)
+		rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL(blk_fill_sghdr_rq);
+
+/*
+ * unmap a request that was previously mapped to this sg_io_hdr. handles
+ * both sg and non-sg sg_io_hdr.
+ */
+int blk_unmap_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr)
+{
+	struct bio *bio = rq->bio;
+	int ret = 0;
+
+	/*
+	 * also releases request
+	 */
+	if (!hdr->iovec_count)
+		return blk_rq_unmap_user(rq, bio, hdr->dxfer_len);
+
+	while ((bio = rq->bio)) {
+		rq->bio = bio->bi_next;
+		bio->bi_next = NULL;
+
+		if (bio_flagged(bio, BIO_USER_MAPPED))
+			bio_unmap_user(bio);
+		else
+			ret = bio_uncopy_user(bio);
+	}
+
+	blk_put_request(rq);
+	return ret;
+}
+EXPORT_SYMBOL(blk_unmap_sghdr_rq);
+
+int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
+			  struct bio *bio)
+{
+	/*
+	 * fill in all the output members
+	 */
+	hdr->status = rq->errors & 0xff;
+	hdr->masked_status = status_byte(rq->errors);
+	hdr->msg_status = msg_byte(rq->errors);
+	hdr->host_status = host_byte(rq->errors);
+	hdr->driver_status = driver_byte(rq->errors);
+	hdr->info = 0;
+	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
+		hdr->info |= SG_INFO_CHECK;
+	hdr->resid = rq->data_len;
+	hdr->sb_len_wr = 0;
+
+	if (rq->sense_len && hdr->sbp) {
+		int len = min((unsigned int) hdr->mx_sb_len, rq->sense_len);
+
+		if (!copy_to_user(hdr->sbp, rq->sense, len))
+			hdr->sb_len_wr = len;
+	}
+
+	rq->bio = bio;
+	return blk_unmap_sghdr_rq(rq, hdr);
+}
+EXPORT_SYMBOL(blk_complete_sghdr_rq);
+
 static int sg_get_version(int __user *p)
 {
 	static int sg_version_num = 30527;
@@ -113,15 +197,11 @@
 	struct request *rq;
 	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
-	unsigned char cmd[BLK_MAX_CDB];
 
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
-	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
-		return -EFAULT;
-
 	/*
 	 * we'll do that later
 	 */
@@ -155,20 +235,19 @@
 	} else
 		rq = blk_get_request(q, READ, __GFP_WAIT);
 
-	/*
-	 * fill in request structure
-	 */
-	rq->cmd_len = hdr->cmd_len;
-	memcpy(rq->cmd, cmd, hdr->cmd_len);
-	if (sizeof(rq->cmd) != hdr->cmd_len)
-		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
+	bio = rq->bio;
+
+	if (blk_fill_sghdr_rq(q, rq, hdr)) {
+		blk_rq_unmap_user(rq, bio, hdr->dxfer_len);
+		blk_put_request(rq);
+		return -EFAULT;
+	}
 
 	memset(sense, 0, sizeof(sense));
 	rq->sense = sense;
 	rq->sense_len = 0;
 
-	rq->flags |= REQ_BLOCK_PC;
-	bio = rq->bio;
+	start_time = jiffies;
 
 	/*
 	 * bounce this after holding a reference to the original bio, it's
@@ -177,46 +256,15 @@
 	if (rq->bio)
 		blk_queue_bounce(q, &rq->bio);
 
-	rq->timeout = (hdr->timeout * HZ) / 1000;
-	if (!rq->timeout)
-		rq->timeout = q->sg_timeout;
-	if (!rq->timeout)
-		rq->timeout = BLK_DEFAULT_TIMEOUT;
-
-	start_time = jiffies;
-
 	/* ignore return value. All information is passed back to caller
 	 * (if he doesn't check that is his problem).
 	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
 	 */
 	blk_execute_rq(q, bd_disk, rq);
 
-	/* write to all output members */
-	hdr->status = rq->errors;	
-	hdr->masked_status = (hdr->status >> 1) & 0x1f;
-	hdr->msg_status = 0;
-	hdr->host_status = 0;
-	hdr->driver_status = 0;
-	hdr->info = 0;
-	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
-		hdr->info |= SG_INFO_CHECK;
-	hdr->resid = rq->data_len;
 	hdr->duration = ((jiffies - start_time) * 1000) / HZ;
-	hdr->sb_len_wr = 0;
 
-	if (rq->sense_len && hdr->sbp) {
-		int len = min((unsigned int) hdr->mx_sb_len, rq->sense_len);
-
-		if (!copy_to_user(hdr->sbp, rq->sense, len))
-			hdr->sb_len_wr = len;
-	}
-
-	if (blk_rq_unmap_user(rq, bio, hdr->dxfer_len))
-		return -EFAULT;
-
-	/* may not have succeeded, but output values written to control
-	 * structure (struct sg_io_hdr).  */
-	return 0;
+	return blk_complete_sghdr_rq(rq, hdr, bio);
 }
 
 #define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
@@ -287,7 +335,7 @@
 			rq->timeout = READ_DEFECT_DATA_TIMEOUT;
 			break;
 		default:
-			rq->timeout = BLK_DEFAULT_TIMEOUT;
+			rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 			break;
 	}
 
@@ -446,7 +494,7 @@
 			rq->flags |= REQ_BLOCK_PC;
 			rq->data = NULL;
 			rq->data_len = 0;
-			rq->timeout = BLK_DEFAULT_TIMEOUT;
+			rq->timeout = BLK_DEFAULT_SG_TIMEOUT;
 			memset(rq->cmd, 0, sizeof(rq->cmd));
 			rq->cmd[0] = GPCMD_START_STOP_UNIT;
 			rq->cmd[4] = 0x02 + (close != 0);
===== drivers/block/paride/pd.c 1.76 vs edited =====
--- 1.76/drivers/block/paride/pd.c	2004-05-29 11:12:56 +02:00
+++ edited/drivers/block/paride/pd.c	2004-08-04 08:28:53 +02:00
@@ -743,6 +743,7 @@
 	rq.rq_disk = disk->gd;
 	rq.ref_count = 1;
 	rq.waiting = &wait;
+	rq.end_io = blk_end_sync_rq;
 	blk_insert_request(disk->gd->queue, &rq, 0, func, 0);
 	wait_for_completion(&wait);
 	rq.waiting = NULL;
===== drivers/ide/ide-floppy.c 1.39 vs edited =====
--- 1.39/drivers/ide/ide-floppy.c	2004-06-04 06:12:07 +02:00
+++ edited/drivers/ide/ide-floppy.c	2004-08-04 08:28:53 +02:00
@@ -1210,19 +1210,25 @@
 	set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
 
-static int
+static void
 idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy, idefloppy_pc_t *pc, struct request *rq)
 {
-	/*
-	 * just support eject for now, it would not be hard to make the
-	 * REQ_BLOCK_PC support fully-featured
-	 */
-	if (rq->cmd[0] != IDEFLOPPY_START_STOP_CMD)
-		return 1;
-
 	idefloppy_init_pc(pc);
+	pc->callback = &idefloppy_rw_callback;
 	memcpy(pc->c, rq->cmd, sizeof(pc->c));
-	return 0;
+	pc->rq = rq;
+	pc->b_count = rq->data_len;
+	if (rq->data_len && rq_data_dir(rq) == WRITE)
+		set_bit(PC_WRITING, &pc->flags);
+	pc->buffer = rq->data;
+	if (rq->bio)
+		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
+		
+	/*
+	 * possibly problematic, doesn't look like ide-floppy correctly
+	 * handled scattered requests if dma fails...
+	 */
+	pc->request_transfer = pc->buffer_size = rq->data_len;
 }
 
 /*
@@ -1267,10 +1273,7 @@
 		pc = (idefloppy_pc_t *) rq->buffer;
 	} else if (rq->flags & REQ_BLOCK_PC) {
 		pc = idefloppy_next_pc_storage(drive);
-		if (idefloppy_blockpc_cmd(floppy, pc, rq)) {
-			idefloppy_do_end_request(drive, 0, 0);
-			return ide_stopped;
-		}
+		idefloppy_blockpc_cmd(floppy, pc, rq);
 	} else {
 		blk_dump_rq_flags(rq,
 			"ide-floppy: unsupported command in queue");
===== drivers/ide/ide-io.c 1.27 vs edited =====
--- 1.27/drivers/ide/ide-io.c	2004-06-05 21:58:33 +02:00
+++ edited/drivers/ide/ide-io.c	2004-08-04 08:28:53 +02:00
@@ -1353,6 +1353,7 @@
 	if (must_wait) {
 		rq->ref_count++;
 		rq->waiting = &wait;
+		rq->end_io = blk_end_sync_rq;
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
===== drivers/ide/ide-tape.c 1.41 vs edited =====
--- 1.41/drivers/ide/ide-tape.c	2004-06-18 17:04:58 +02:00
+++ edited/drivers/ide/ide-tape.c	2004-08-04 08:28:53 +02:00
@@ -2798,6 +2798,7 @@
 	}
 #endif /* IDETAPE_DEBUG_BUGS */
 	rq->waiting = &wait;
+	rq->end_io = blk_end_sync_rq;
 	spin_unlock_irq(&tape->spinlock);
 	wait_for_completion(&wait);
 	/* The stage and its struct request have been deallocated */
===== drivers/ide/ide.c 1.151 vs edited =====
--- 1.151/drivers/ide/ide.c	2004-06-30 18:22:19 +02:00
+++ edited/drivers/ide/ide.c	2004-08-04 08:28:53 +02:00
@@ -1458,9 +1458,14 @@
 {
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	ide_settings_t *setting;
-	int err = 0;
+	int err;
 	void __user *p = (void __user *)arg;
 
+	err = scsi_cmd_ioctl(bdev->bd_disk, cmd, p);
+	if (err != -ENOTTY)
+		return err;
+
+	err = 0;
 	down(&ide_setting_sem);
 	if ((setting = ide_find_setting_by_ioctl(drive, cmd)) != NULL) {
 		if (cmd == setting->read_ioctl) {
@@ -1602,10 +1607,6 @@
 			}
 			return 0;
 		}
-
-		case CDROMEJECT:
-		case CDROMCLOSETRAY:
-			return scsi_cmd_ioctl(bdev->bd_disk, cmd, p);
 
 		case HDIO_GET_BUSSTATE:
 			if (!capable(CAP_SYS_ADMIN))
===== drivers/scsi/scsi_lib.c 1.129 vs edited =====
--- 1.129/drivers/scsi/scsi_lib.c	2004-06-19 16:40:25 +02:00
+++ edited/drivers/scsi/scsi_lib.c	2004-08-04 08:28:53 +02:00
@@ -711,8 +711,7 @@
 	}
 
 	if (blk_pc_request(req)) { /* SG_IO ioctl from block level */
-		req->errors = (driver_byte(result) & DRIVER_SENSE) ?
-			      (CHECK_CONDITION << 1) : (result & 0xff);
+		req->errors = result;
 		if (result) {
 			clear_errors = 0;
 			if (cmd->sense_buffer[0] & 0x70) {
===== fs/bio.c 1.63 vs edited =====
--- 1.63/fs/bio.c	2004-08-03 08:10:56 +02:00
+++ edited/fs/bio.c	2004-08-04 08:34:17 +02:00
@@ -644,6 +644,7 @@
  */
 void bio_unmap_user(struct bio *bio)
 {
+	BUG_ON(!bio_flagged(bio, BIO_USER_MAPPED));
 	__bio_unmap_user(bio);
 	bio_put(bio);
 }
===== include/linux/blkdev.h 1.149 vs edited =====
--- 1.149/include/linux/blkdev.h	2004-08-03 08:10:56 +02:00
+++ edited/include/linux/blkdev.h	2004-08-04 08:30:10 +02:00
@@ -22,6 +22,8 @@
 struct elevator_s;
 typedef struct elevator_s elevator_t;
 struct request_pm_state;
+struct request;
+struct sg_io_hdr;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -76,6 +78,8 @@
 void copy_io_context(struct io_context **pdst, struct io_context **psrc);
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
+typedef void (rq_end_io_fn)(struct request *);
+
 struct request_list {
 	int count[2];
 	mempool_t *rq_pool;
@@ -163,6 +167,13 @@
 	 * For Power Management requests
 	 */
 	struct request_pm_state *pm;
+
+	rq_end_io_fn *end_io;
+
+	/*
+	 * issuer private data
+	 */
+	void *private;
 };
 
 /*
@@ -479,6 +490,11 @@
 #define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
+/*
+ * default timeout for SG_IO if none specified
+ */
+#define BLK_DEFAULT_SG_TIMEOUT	(60 * HZ)
+
 #ifdef CONFIG_MMU
 extern int init_emergency_isa_pool(void);
 extern void blk_queue_bounce(request_queue_t *q, struct bio **bio);
@@ -506,10 +522,11 @@
 extern void register_disk(struct gendisk *dev);
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
+extern void __blk_put_request(request_queue_t *, struct request *);
+extern void blk_end_sync_rq(struct request *rq);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern void blk_put_request(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *, int);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
@@ -525,6 +542,9 @@
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
 extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
 extern int blk_rq_unmap_user(struct request *, struct bio *, unsigned int);
+extern int blk_fill_sghdr_rq(request_queue_t *, struct request *, struct sg_io_hdr *);
+extern int blk_unmap_sghdr_rq(struct request *, struct sg_io_hdr *);
+extern int blk_complete_sghdr_rq(struct request *, struct sg_io_hdr *, struct bio *);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *, struct request *);
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)
===== include/scsi/sg.h 1.15 vs edited =====
--- 1.15/include/scsi/sg.h	2004-08-02 10:00:45 +02:00
+++ edited/include/scsi/sg.h	2004-08-04 08:28:53 +02:00
@@ -193,6 +193,8 @@
 #define SG_SET_RESERVED_SIZE 0x2275  /* request a new reserved buffer size */
 #define SG_GET_RESERVED_SIZE 0x2272  /* actual size of reserved buffer */
 
+#define SG_GET_MAX_COMMAND_SIZE 0x2277 /* how many bytes is q->max_sectors */
+
 /* The following ioctl has a 'sg_scsi_id_t *' object as its 3rd argument. */
 #define SG_GET_SCSI_ID 0x2276   /* Yields fd's bus, chan, dev, lun + type */
 /* SCSI id information can also be obtained from SCSI_IOCTL_GET_IDLUN */
--- /dev/null	2004-04-06 15:27:52.000000000 +0200
+++ linux-2.6-bsg/drivers/block/bsg.c	2004-08-04 10:37:08.520991672 +0200
@@ -0,0 +1,1317 @@
+/*
+ * bsg.c - block layer implementation of the sg v3 interface
+ *
+ * Copyright (C) 2004 Jens Axboe <axboe@suse.de> SUSE Labs
+ * Copyright (C) 2004 Peter M. Jones <pjones@redhat.com>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License version 2.  See the file "COPYING" in the main directory of this
+ *  archive for more details.
+ *
+ */
+/*
+ * TODO
+ *	- Should this get merged, block/scsi_ioctl.c will be migrated into
+ *	  this file. To keep maintenance down, it's easier to have them
+ *	  seperated right now.
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/blkdev.h>
+#include <linux/poll.h>
+#include <linux/cdev.h>
+#include <linux/percpu.h>
+#include <linux/uio.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_ioctl.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/sg.h>
+
+#include "bsg.h"
+
+static char bsg_version[] = "block layer sg (bsg) 0.4";
+
+struct bsg_command;
+struct bsg_device {
+	struct block_device *bdev;
+	struct file *file;
+	request_queue_t *queue;
+	spinlock_t lock;
+	struct list_head busy_list;
+	struct list_head done_list;
+	int queued_cmds;
+	int done_cmds;
+	unsigned long *cmd_bitmap;
+	struct bsg_command *cmd_map;
+	wait_queue_head_t wq_done;
+	wait_queue_head_t wq_free;
+	char name[BDEVNAME_SIZE];
+	int max_queue;
+	int can_block;
+};
+
+/*
+ * command allocation bitmap defines
+ */
+#define BSG_CMDS_PAGE_ORDER	(1)
+#define BSG_CMDS_PER_LONG	(sizeof(unsigned long) * 8)
+#define BSG_CMDS_MASK		(BSG_CMDS_PER_LONG - 1)
+#define BSG_CMDS_BYTES		(PAGE_SIZE * (1 << BSG_CMDS_PAGE_ORDER))
+#define BSG_CMDS		(BSG_CMDS_BYTES / sizeof(struct bsg_command))
+
+/*
+ * arbitrary limit, mapping bio's will reveal true device limit
+ */
+#define BSG_MAX_VECS		(128)
+
+#undef BSG_DEBUG
+#define BSG_DEBUG_CPU
+
+#ifdef BSG_DEBUG
+#define dprintk(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ##args)
+#else
+#define dprintk(fmt, args...)
+#endif
+
+#define list_entry_bc(entry)	list_entry((entry), struct bsg_command, list)
+
+/*
+ * just for testing
+ */
+#define BSG_MAJOR	(240)
+
+/*
+ * stuff to support per-cpu completions of commands
+ */
+static struct workqueue_struct *bsg_wq;
+
+static DEFINE_PER_CPU(struct list_head, bsg_cpu_work);
+
+static void bsg_complete_work(void *);
+static DECLARE_WORK(bsg_work, bsg_complete_work, NULL);
+
+static DECLARE_MUTEX(bsg_sem);
+
+/*
+ * our internal command type
+ */
+struct bsg_command {
+	struct bsg_device *bd;
+	struct list_head list;
+	struct request *rq;
+	struct bio *bio;
+	int err;
+	struct sg_io_hdr hdr;
+	struct sg_io_hdr *uhdr;
+	char sense[SCSI_SENSE_BUFFERSIZE];
+#ifdef BSG_DEBUG_CPU
+	int cpu;
+#endif
+};
+
+static void bsg_free_command(struct bsg_command *bc)
+{
+	struct bsg_device *bd = bc->bd;
+	int bitnr = bc - bd->cmd_map;
+	unsigned long flags;
+
+	dprintk("%s: command bit offset %d\n", bd->name, bitnr);
+
+	spin_lock_irqsave(&bd->lock, flags);
+	bd->queued_cmds--;
+	__clear_bit(bitnr, bd->cmd_bitmap);
+	spin_unlock_irqrestore(&bd->lock, flags);
+
+	wake_up(&bd->wq_free);
+}
+
+static struct bsg_command *
+__bsg_alloc_command(struct bsg_device *bd)
+{
+	struct bsg_command *bc = NULL;
+	unsigned long *map;
+	int free_nr;
+
+	spin_lock_irq(&bd->lock);
+
+	if (bd->queued_cmds >= bd->max_queue)
+		goto out;
+
+	for (free_nr = 0, map = bd->cmd_bitmap; *map == ~0UL; map++)
+		free_nr += BSG_CMDS_PER_LONG;
+
+	BUG_ON(*map == ~0UL);
+			
+	bd->queued_cmds++;
+	free_nr += ffz(*map);
+	__set_bit(free_nr, bd->cmd_bitmap);
+	spin_unlock_irq(&bd->lock);
+
+	bc = bd->cmd_map + free_nr;
+	memset(bc, 0, sizeof(*bc));
+	bc->bd = bd;
+	INIT_LIST_HEAD(&bc->list);
+	dprintk("%s: returning free cmd %p (bit %d)\n", bd->name, bc, free_nr);
+	return bc;
+out:
+	dprintk("%s: failed (depth %d)\n", bd->name, bd->queued_cmds);
+	spin_unlock_irq(&bd->lock);
+	return bc;
+}
+
+static inline void
+bsg_del_done_cmd(struct bsg_device *bd, struct bsg_command *bc)
+{
+	bd->done_cmds--;
+	list_del(&bc->list);
+}
+
+static inline void
+bsg_add_done_cmd(struct bsg_device *bd, struct bsg_command *bc)
+{
+	bd->done_cmds++;
+	list_add_tail(&bc->list, &bd->done_list);
+}
+
+static inline int bsg_io_schedule(struct bsg_device *bd, int state)
+{
+	DEFINE_WAIT(wait);
+	int ret = 0;
+
+	spin_lock_irq(&bd->lock);
+
+	BUG_ON(bd->done_cmds > bd->queued_cmds);
+
+	/*
+	 * -ENOSPC or -ENODATA?  I'm going for -ENODATA, meaning "I have no
+	 * work to do", even though we return -ENOSPC after this same test
+	 * during bsg_write() -- there, it means our buffer can't have more
+	 * bsg_commands added to it, thus has no space left.
+	 */
+	if (bd->done_cmds == bd->queued_cmds) {
+		ret = -ENODATA;
+		goto unlock;
+	}
+
+	if (!bd->can_block) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	spin_unlock_irq(&bd->lock);
+	prepare_to_wait(&bd->wq_done, &wait, state);
+	io_schedule();
+	finish_wait(&bd->wq_done, &wait);
+
+	if ((state == TASK_INTERRUPTIBLE) && signal_pending(current))
+		ret = -ERESTARTSYS;
+
+	return ret;
+unlock:
+	spin_unlock_irq(&bd->lock);
+	return ret;
+}
+
+/*
+ * get a new free command, blocking if needed and specified
+ */
+static struct bsg_command *
+bsg_get_command(struct bsg_device *bd)
+{
+	struct bsg_command *bc;
+	int ret;
+
+	do {
+		bc = __bsg_alloc_command(bd);
+		if (bc)
+			break;
+			
+		ret = bsg_io_schedule(bd, TASK_INTERRUPTIBLE);
+		if (ret) {
+			bc = ERR_PTR(ret);
+			break;
+		}
+
+	} while (1);
+
+	return bc;
+}
+
+/*
+ * Check if sg_io_hdr from user is allowed and valid
+ */
+static int
+bsg_validate_sghdr(request_queue_t *q, struct sg_io_hdr *hdr, int *rw)
+{
+	if (hdr->interface_id != 'S')
+		return -EINVAL;
+	if (hdr->cmd_len > BLK_MAX_CDB)
+		return -EINVAL;
+	if (hdr->iovec_count > BSG_MAX_VECS)
+		return -EINVAL;
+	if (hdr->dxfer_len > (q->max_sectors << 9))
+		return -EIO;
+
+	/*
+	 * looks sane, if no data then it should be fine from our POV
+	 */
+	if (!hdr->dxfer_len)
+		return 0;
+
+	switch (hdr->dxfer_direction) {
+		case SG_DXFER_TO_FROM_DEV:
+		case SG_DXFER_FROM_DEV:
+			*rw = READ;
+			break;
+		case SG_DXFER_TO_DEV:
+			*rw = WRITE;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void bsg_unmap_hdr(struct request *rq, struct sg_io_hdr *hdr)
+{
+	blk_unmap_sghdr_rq(rq, hdr);
+}
+
+/*
+ * map sg_io_hdr to a request. for scatter-gather sg_io_hdr, we map
+ * each segment to a bio and string multiple bio's to the request
+ */
+static struct request *
+bsg_map_hdr(request_queue_t *q, int rw, struct sg_io_hdr *hdr)
+{
+	struct sg_iovec iov;
+	struct sg_iovec __user *u_iov;
+	struct request *rq;
+	struct bio *bio;
+	int ret, i;
+
+	dprintk("map hdr %p/%d/%d\n", hdr->dxferp, hdr->dxfer_len,
+					hdr->iovec_count);
+
+	ret = bsg_validate_sghdr(q, hdr, &rw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!hdr->iovec_count)
+		return blk_rq_map_user(q, rw, hdr->dxferp, hdr->dxfer_len);
+
+	/*
+	 * map scatter-gather elements seperately and string them to request
+	 */
+	rq = blk_get_request(q, rw, __GFP_WAIT);
+
+	u_iov = hdr->dxferp;
+	for (ret = 0, i = 0; i < hdr->iovec_count; i++, u_iov++) {
+		int to_vm = rw == READ;
+		unsigned long uaddr;
+
+		if (copy_from_user(&iov, u_iov, sizeof(iov))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (!iov.iov_len || !iov.iov_base) {
+			ret = -EINVAL;
+			break;
+		}
+
+		uaddr = (unsigned long) iov.iov_base;
+		if (!(uaddr & queue_dma_alignment(q))
+		    && !(iov.iov_len & queue_dma_alignment(q)))
+			bio = bio_map_user(q, NULL, uaddr, iov.iov_len, to_vm);
+		else
+			bio = bio_copy_user(q, uaddr, iov.iov_len, to_vm);
+
+		if (IS_ERR(bio)) {
+			ret = PTR_ERR(bio);
+			bio = NULL;
+			break;
+		}
+
+		dprintk("bsg: adding segment %d\n", i);
+
+		if (rq->bio) {
+			/*
+			 * for most (all? don't know of any) queues we could
+			 * skip grabbing the queue lock here. only drivers with
+			 * funky private ->back_merge_fn() function could be
+			 * problematic.
+			 */
+			spin_lock_irq(q->queue_lock);
+			ret = q->back_merge_fn(q, rq, bio);
+			spin_unlock_irq(q->queue_lock);
+
+			rq->biotail->bi_next = bio;
+			rq->biotail = bio;
+
+			/*
+			 * break after adding bio, so we don't have to special
+			 * case the cleanup too much
+			 */
+			if (!ret) {
+				ret = -EINVAL;
+				break;
+			}
+
+			/*
+			 * merged ok, update state
+			 */
+			rq->nr_sectors += bio_sectors(bio);
+			rq->hard_nr_sectors = rq->nr_sectors;
+			rq->data_len += bio->bi_size;
+		} else {
+			/*
+			 * first bio, setup rq state
+			 */
+			blk_rq_bio_prep(q, rq, bio);
+		}
+		ret = 0;
+	}
+
+	/*
+	 * bugger, cleanup
+	 */
+	if (ret) {
+		dprintk("failed map at %d: %d\n", i, ret);
+		bsg_unmap_hdr(rq, hdr);
+		rq = ERR_PTR(ret);
+	}
+
+	return rq;
+}
+
+/*
+ * empties the completed commands from the per-cpu lists, and unmaps
+ * them if possible (otherwise they are deferred to bsg_read()).
+ */
+static void bsg_complete_work(void *data)
+{
+	struct list_head *list = &get_cpu_var(bsg_cpu_work);
+	struct bsg_device *bd, *prev_bd = NULL;
+	struct bsg_command *bc;
+
+	/*
+	 * should be safe, interrupts must be enabled when entered so no
+	 * need to save flags
+	 */
+	local_irq_disable();
+
+	while (!list_empty(list)) {
+		bc = list_entry_bc(list->next);
+		list_del(&bc->list);
+		bd = bc->bd;
+
+		local_irq_enable();
+
+#ifdef BSG_DEBUG_CPU
+		BUG_ON(bc->cpu != smp_processor_id());
+#endif
+
+		bc->err = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+		bc->rq = NULL;
+		bc->bio = NULL;
+
+		spin_lock_irq(&bd->lock);
+		bsg_add_done_cmd(bd, bc);
+		spin_unlock_irq(&bd->lock);
+
+		/*
+		 * minimize wakeups by only issuing them if 'bd' changes
+		 */
+		if (prev_bd && prev_bd != bd)
+			wake_up(&prev_bd->wq_done);
+
+		prev_bd = bd;
+
+		local_irq_disable();
+	}
+
+	local_irq_enable();
+	put_cpu_var(bsg_cpu_work);
+
+	/*
+	 * make sure we wakeup bd if it never changed
+	 */
+	if (prev_bd)
+		wake_up(&prev_bd->wq_done);
+}
+
+/*
+ * async completion call-back from the block layer, when scsi/ide/whatever
+ * calls end_that_request_last() on a request
+ */
+static void bsg_rq_end_io(struct request *rq)
+{
+	struct bsg_command *bc = rq->private;
+	struct bsg_device *bd = bc->bd;
+	unsigned long flags;
+	int done = 1;
+
+	dprintk("%s: finished rq %p bio %p, bc %p offset %d\n", bd->name, rq,
+							bc, bc->bio,
+							bc - bd->cmd_map);
+
+	bc->hdr.duration = ((jiffies - bc->hdr.duration) * 1000) / HZ;
+
+	spin_lock_irqsave(&bd->lock, flags);
+	list_del(&bc->list);
+
+	/*
+	 * we can let the bsg thread complete the command, if it was bio
+	 * backed _or_ we don't need to copy data back. otherwise, the issuing
+	 * process must copy the data itself in its own context
+	 */
+	if (!bc->bio && rq_data_dir(rq) == READ) {
+		bsg_add_done_cmd(bd, bc);
+		done = 0;
+	}
+	spin_unlock_irqrestore(&bd->lock, flags);
+
+	if (done) {
+		struct list_head *list = &get_cpu_var(bsg_cpu_work);
+
+		local_irq_save(flags);
+		list_add_tail(&bc->list, list);
+		local_irq_restore(flags);
+
+#ifdef BSG_DEBUG_CPU
+		bc->cpu = smp_processor_id();
+#endif
+
+		/*
+		 * defer enabling preemption until work is queued, so we know
+		 * that we will get queued on the cpu that we just added the
+		 * work to
+		 */
+		queue_work(bsg_wq, &bsg_work);
+		put_cpu_var(bsg_cpu_work);
+	} else
+		wake_up(&bd->wq_done);
+}
+
+/*
+ * do final setup of a 'bc' and submit the matching 'rq' to the block
+ * layer for io
+ */
+static void bsg_add_command(struct bsg_device *bd, request_queue_t *q,
+			    struct bsg_command *bc, struct request *rq)
+{
+	rq->sense = bc->sense;
+	rq->sense_len = 0;
+
+	rq->rq_disk = bd->bdev->bd_disk;
+	rq->private = bc;
+	rq->end_io = bsg_rq_end_io;
+
+	/*
+	 * add bc command to busy queue and submit rq for io
+	 */
+	bc->rq = rq;
+	bc->bio = rq->bio;
+	bc->hdr.duration = jiffies;
+	spin_lock_irq(&bd->lock);
+	list_add_tail(&bc->list, &bd->busy_list);
+	spin_unlock_irq(&bd->lock);
+
+	dprintk("%s: queueing rq %p, bc %p\n", bd->name, rq, bc);
+
+	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
+	generic_unplug_device(q);
+}
+
+static inline struct bsg_command *bsg_next_done_cmd(struct bsg_device *bd)
+{
+	struct bsg_command *bc = NULL;
+
+	spin_lock_irq(&bd->lock);
+	if (bd->done_cmds) {
+		bc = list_entry_bc(bd->done_list.next);
+		bsg_del_done_cmd(bd, bc);
+	}
+	spin_unlock_irq(&bd->lock);
+
+	return bc;
+}
+
+/*
+ * Get a finished command from the done list
+ */
+static struct bsg_command *
+__bsg_get_done_cmd(struct bsg_device *bd, int state)
+{
+	struct bsg_command *bc;
+	int ret;
+
+	do {
+		bc = bsg_next_done_cmd(bd);
+		if (bc)
+			break;
+
+		ret = bsg_io_schedule(bd, state);
+		if (ret) {
+			bc = ERR_PTR(ret);
+			break;
+		}
+	} while (1);
+
+	dprintk("%s: returning done %p\n", bd->name, bc);
+
+	return bc;
+}
+
+static struct bsg_command *
+bsg_get_done_cmd(struct bsg_device *bd, struct iovec *iov)
+{
+	return __bsg_get_done_cmd(bd, TASK_INTERRUPTIBLE);
+}
+
+static struct bsg_command *
+bsg_get_done_cmd_nosignals(struct bsg_device *bd)
+{
+	return __bsg_get_done_cmd(bd, TASK_UNINTERRUPTIBLE);
+}
+
+static int bsg_complete_all_commands(struct bsg_device *bd)
+{
+	struct bsg_command *bc;
+	int ret, tmp_ret;
+
+	dprintk("%s: entered\n", bd->name);
+
+	spin_lock_irq(&bd->lock);
+	bd->can_block = 1;
+	spin_unlock_irq(&bd->lock);
+
+	/*
+	 * wait for all commands to complete
+	 */
+	ret = 0;
+	do {
+		ret = bsg_io_schedule(bd, TASK_UNINTERRUPTIBLE);
+		/*
+		 * look for -ENODATA specifically -- we'll sometimes get
+		 * -ERESTARTSYS when we've taken a signal, but we can't
+		 * return until we're done freeing the queue, so ignore
+		 * it.  The signal will get handled when we're done freeing
+		 * the bsg_device.
+		 */
+	} while (ret != -ENODATA);
+ 
+	/*
+	 * discard done commands
+	 */
+	ret = 0;
+	do {
+		spin_lock_irq(&bd->lock);
+		if (!bd->queued_cmds) {
+			spin_unlock_irq(&bd->lock);
+			break;
+		}
+		spin_unlock_irq(&bd->lock);
+	
+		/*
+		 * we don't actually _need_ to flush the work queue, just
+		 * let it finish on its own. plus, flush_workqueue() destroys
+		 * the otherwise affine cpu guarantees of work queues...
+		 */
+#if 0
+		flush_workqueue(bsg_wq);
+#endif
+		bc = bsg_get_done_cmd_nosignals(bd);
+
+		/*
+		 * we _must_ complete before restarting, because
+		 * bsg_release can't handle this failing.
+		 */
+		if (PTR_ERR(bc) == -ERESTARTSYS)
+			continue;
+
+		/*
+		 * If we get any other error, bd->queued_cmds is wrong.
+		 */
+		BUG_ON(IS_ERR(bc));
+
+		if (bc->rq)
+			tmp_ret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+		else
+			tmp_ret = bc->err;
+
+		if (!ret)
+			ret = tmp_ret;
+
+		bsg_free_command(bc);
+	} while (1);
+
+	return ret;
+}
+
+typedef struct bsg_command *(*bsg_command_callback)(
+		struct bsg_device *bd, struct iovec *iov);
+
+static ssize_t
+__bsg_read(char __user *buf, size_t count,
+	   bsg_command_callback get_bc, struct bsg_device *bd,
+	   struct iovec *iov, ssize_t *bytes_read)
+{
+	struct bsg_command *bc;
+	int nr_commands, ret;
+
+	if (count % sizeof(struct sg_io_hdr))
+		return -EINVAL;
+
+	ret = 0;
+	nr_commands = count / sizeof(struct sg_io_hdr);
+	while (nr_commands) {
+		bc = get_bc(bd, iov);
+		if (IS_ERR(bc)) {
+			ret = PTR_ERR(bc);
+			break;
+		}
+
+		/*
+		 * this is the only case where we need to copy data back
+		 * after completing the request. so do that here,
+		 * bsg_complete_work() cannot do that for us
+		 */
+		if (bc->rq)
+			ret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+		else
+			ret = bc->err;
+	
+		if (copy_to_user(buf, (char *) &bc->hdr, sizeof(bc->hdr)))
+			ret = -EFAULT;
+
+		bsg_free_command(bc);
+
+		if (ret)
+			break;
+
+		buf += sizeof(struct sg_io_hdr);
+		*bytes_read += sizeof(struct sg_io_hdr);
+		nr_commands--;
+	}
+
+	return ret;
+}
+
+#define err_block_err(ret)	\
+	((ret) && (ret) != -ENOSPC && (ret) != -ENODATA && (ret) != -EAGAIN)
+
+static ssize_t
+bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	int ret;
+	ssize_t bytes_read;
+
+	if (!bd)
+		return -ENXIO;
+
+	dprintk("%s: read %d bytes\n", bd->name, count);
+
+	bd->can_block = !(file->f_flags & O_NONBLOCK);
+
+	bytes_read = 0;
+	ret = __bsg_read(buf, count, bsg_get_done_cmd,
+			bd, NULL, &bytes_read);
+	*ppos = bytes_read;
+
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+
+	return bytes_read;
+}
+
+static int
+bsg_readv_validate_iovec(struct bsg_command *bc, struct iovec *iov)
+{
+	/*
+	 * Here we just check that we weren't given some random weird wacky
+	 * values.  The values must be the same as in the original sg_io_hdr.
+	 * We use -ENXIO to say the address is bad, so we can try the next
+	 * bsg_command instead of erroring immediately.
+	 */
+	dprintk("iov[0] = {%p, %Zu}, bc->uhdr = {%p, %Zu}\n",
+		iov[0].iov_base, iov[0].iov_len,
+		bc->uhdr, sizeof(struct sg_io_hdr));
+	if (iov[0].iov_base != bc->uhdr)
+		return -ENXIO;
+	if (iov[0].iov_len != sizeof(struct sg_io_hdr))
+		return -EINVAL;
+	dprintk("iov[1] = {%p, %Zu}, bc->hdr.dxferp = {%p, %Zu}\n",
+		iov[1].iov_base, iov[1].iov_len,
+		bc->hdr.dxferp, bc->hdr.dxfer_len);
+	if (iov[1].iov_base != bc->hdr.dxferp)
+		return -EINVAL;
+	if (iov[1].iov_len != bc->hdr.dxfer_len)
+		return -EINVAL;
+	dprintk("iov[2] = {%p, %Zu}, bc->hdr.sbp = {%p, %Zu}\n",
+		iov[2].iov_base, iov[2].iov_len,
+		bc->hdr.sbp, bc->hdr.sb_len_wr);
+	if (iov[2].iov_base != bc->hdr.sbp)
+		return -EINVAL;
+	if (iov[2].iov_len != bc->hdr.sb_len_wr)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct bsg_command *__get_cmd_by_hdr(struct bsg_device *bd,
+		struct iovec *iov)
+{
+	struct bsg_command *bc;
+	int ret;
+
+	spin_lock_irq(&bd->lock);
+
+	while (!bd->done_cmds && bd->queued_cmds) {
+		dprintk("done list is empty, but commands are queued\n");
+
+		spin_unlock_irq(&bd->lock);
+
+		ret = bsg_io_schedule(bd, TASK_INTERRUPTIBLE);
+		if (ret) {
+			bc = ERR_PTR(ret);
+			goto out;
+		}
+
+		spin_lock_irq(&bd->lock);
+	}
+
+	if (!bd->done_cmds) {
+		bc = ERR_PTR(-ENODATA);
+		goto unlock;
+	}
+
+	list_for_each_entry(bc, &bd->done_list, list) {
+		ret = bsg_readv_validate_iovec(bc, iov);
+		if (ret == -ENXIO)
+			continue;
+		if (ret) {
+			bc = ERR_PTR(ret);
+			break;
+		}
+		bsg_del_done_cmd(bd, bc);
+		break;
+	}
+unlock:
+	spin_unlock_irq(&bd->lock);
+out:
+	return bc;
+}
+
+static ssize_t
+bsg_readv(struct file *file, const struct iovec __user *_iov,
+          unsigned long nr_segs, loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	struct iovec *iov = (struct iovec *)_iov;
+	int ret = 0;
+	ssize_t bytes_read = 0;
+
+	if (!bd)
+		return -ENXIO;
+
+	dprintk("%s: readv %lu regions\n", bd->name, nr_segs);
+
+	if (nr_segs != 3)
+		return -EINVAL;
+	dprintk("[{%p,%Zu},{%p,%Zu},{%p,%Zu}]\n", 
+		iov[0].iov_base, iov[0].iov_len,
+		iov[1].iov_base, iov[1].iov_len,
+		iov[2].iov_base, iov[2].iov_len);
+
+	bd->can_block = !(file->f_flags & O_NONBLOCK);
+
+	ret = __bsg_read(iov->iov_base, iov->iov_len, __get_cmd_by_hdr,
+			bd, iov, &bytes_read);
+	*ppos = bytes_read;
+
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+	
+	return bytes_read;
+}
+
+static ssize_t
+__bsg_write(struct bsg_device *bd,
+	const char __user *buf, size_t count,
+	ssize_t *bytes_read)
+{
+	struct bsg_command *bc;
+	struct request *rq;
+	int ret, nr_commands;
+
+	if (count % sizeof(struct sg_io_hdr))
+		return -EINVAL;
+
+	nr_commands = count / sizeof(struct sg_io_hdr);
+	rq = NULL;
+	bc = NULL;
+	ret = 0;
+	while (nr_commands) {
+		request_queue_t *q = bd->queue;
+		int rw = READ;
+
+		bc = bsg_get_command(bd);
+		if (!bc)
+			break;
+		if (IS_ERR(bc)) {
+			ret = PTR_ERR(bc);
+			bc = NULL;
+			break;
+		}
+
+		bc->uhdr = (void *) buf;
+		if (copy_from_user(&bc->hdr, buf, sizeof(bc->hdr))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		/*
+		 * get a request, fill in the blanks, and add to request queue
+		 */
+		rq = bsg_map_hdr(q, rw, &bc->hdr);
+		if (IS_ERR(rq)) {
+			ret = PTR_ERR(rq);
+			rq = NULL;
+			break;
+		}
+
+		ret = blk_fill_sghdr_rq(q, rq, &bc->hdr);
+		if (ret)
+			break;
+
+		bsg_add_command(bd, q, bc, rq);
+		bc = NULL;
+		rq = NULL;
+		nr_commands--;
+		buf += sizeof(struct sg_io_hdr);
+		*bytes_read += sizeof(struct sg_io_hdr);
+	}
+
+	if (rq)
+		bsg_unmap_hdr(rq, &bc->hdr);
+	if (bc)
+		bsg_free_command(bc);
+	
+	return ret;
+}
+
+static ssize_t
+bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	ssize_t bytes_read;
+	int ret;
+
+	if (!bd)
+		return -ENXIO;
+
+	dprintk("%s: write %d bytes\n", bd->name, count);
+
+	bd->can_block = !(file->f_flags & O_NONBLOCK);
+
+	bytes_read = 0;
+	ret = __bsg_write(bd, buf, count, &bytes_read);
+	*ppos = bytes_read;
+
+	/*
+	 * return bytes written on non-fatal errors
+	 */
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+
+	dprintk("%s: returning %d\n", bd->name, bytes_read);
+	return bytes_read;
+}
+
+static int
+bsg_writev_validate_iovec(struct iovec *iov)
+{
+	struct sg_io_hdr hdr;
+
+	dprintk("iov[0] = {%p, %Zu}, sizeof(struct sg_io_hdr) = %Zu\n",
+		iov[0].iov_base, iov[0].iov_len, sizeof(struct sg_io_hdr));
+	if (iov[0].iov_len != sizeof(struct sg_io_hdr))
+		return -EINVAL;
+
+	/*
+	 * I really don't like doing this copy twice, but I don't see a good
+	 * way around it...
+	 */
+	if (copy_from_user(&hdr, iov[0].iov_base, sizeof(struct sg_io_hdr)))
+		return -EFAULT;
+
+	dprintk("iov[1] = {%p, %Zu}, hdr->cmdp = {%p, %Zu}\n",
+		iov[1].iov_base, iov[1].iov_len,
+		hdr.cmdp, hdr.cmd_len);
+	if (iov[1].iov_base != hdr.cmdp)
+		return -EINVAL;
+	if (iov[1].iov_len != hdr.cmd_len)
+		return -EINVAL;
+
+	dprintk("iov[2] = {%p, %Zu}, hdr->dxferp = {%p, %Zu}\n",
+		iov[1].iov_base, iov[1].iov_len,
+		hdr.dxferp, hdr.dxfer_len);
+	if (iov[2].iov_base != hdr.dxferp)
+		return -EINVAL;
+	if (iov[2].iov_len != hdr.dxfer_len)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t
+bsg_writev(struct file *file, const struct iovec __user *_iov,
+	    unsigned long nr_segs, loff_t *ppos)
+{
+	struct bsg_device *bd = file->private_data;
+	struct iovec *iov = (struct iovec *)_iov;
+	int ret = 0;
+	size_t bytes_read;
+
+	if (!bd)
+		return -ENXIO;
+
+	dprintk("%s: writev %lu regions\n", bd->name, nr_segs);
+
+	if (nr_segs != 3)
+		return -EINVAL;
+	dprintk("[{%p,%Zu},{%p,%Zu},{%p,%Zu}]\n",
+		iov[0].iov_base, iov[0].iov_len,
+		iov[1].iov_base, iov[1].iov_len,
+		iov[2].iov_base, iov[2].iov_len);
+
+	bd->can_block = !(file->f_flags & O_NONBLOCK);
+
+	ret = bsg_writev_validate_iovec(iov);
+	if (ret)
+		return ret;
+
+	bytes_read = 0;
+	ret = __bsg_write(bd, iov->iov_base, iov->iov_len, &bytes_read);
+	*ppos = bytes_read;
+
+	if (!bytes_read || (bytes_read && err_block_err(ret)))
+		bytes_read = ret;
+
+	dprintk("%s: returning %d\n", bd->name, bytes_read);
+	return bytes_read;
+}
+
+static struct bsg_device *bsg_alloc_device(void)
+{
+	struct bsg_device *bd = kmalloc(sizeof(struct bsg_device), GFP_KERNEL);
+	struct bsg_command *cmd_map;
+	unsigned long *cmd_bitmap;
+	int bits;
+
+	if (!bd)
+		return NULL;
+
+	memset(bd, 0, sizeof(struct bsg_device));
+	spin_lock_init(&bd->lock);
+
+	bd->max_queue = BSG_CMDS;
+
+	bits = (BSG_CMDS / BSG_CMDS_PER_LONG) + 1;
+	cmd_bitmap = kmalloc(bits * sizeof(unsigned long), GFP_KERNEL);
+	if (!cmd_bitmap)
+		goto out_free_bd;
+	bd->cmd_bitmap = cmd_bitmap;
+
+	cmd_map = (struct bsg_command *) __get_free_pages(GFP_KERNEL,
+							  BSG_CMDS_PAGE_ORDER);
+	if (!cmd_map)
+		goto out_free_bitmap;
+	bd->cmd_map = cmd_map;
+
+	memset(cmd_map, 0, BSG_CMDS_BYTES);
+	memset(cmd_bitmap, 0, bits * sizeof(unsigned long));
+	INIT_LIST_HEAD(&bd->busy_list);
+	INIT_LIST_HEAD(&bd->done_list);
+	
+	init_waitqueue_head(&bd->wq_free);
+	init_waitqueue_head(&bd->wq_done);
+	return bd;
+
+out_free_bitmap:
+	kfree(cmd_bitmap);
+out_free_bd:
+	kfree(bd);
+	return NULL;
+}
+
+static int bsg_open(struct inode *inode, struct file *file)
+{
+	if (iminor(inode))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int bsg_release(struct inode *inode, struct file *file)
+{
+	struct bsg_device *bd = file->private_data;
+	int ret;
+
+	down(&bsg_sem);
+
+	ret = -ENXIO;
+	if (!bd)
+		goto out;
+
+	dprintk("%s: tearing down\n", bd->name);
+
+	/*
+	 * close can always block
+	 */
+	bd->can_block = 1;
+
+	/*
+	 * correct error detection baddies here again. it's the responsibility
+	 * of the app to properly reap commands before close() if it wants
+	 * fool-proof error detection
+	 */
+	ret = bsg_complete_all_commands(bd);
+
+	bdput(bd->bdev);
+	fput(bd->file);
+	free_pages((unsigned long) bd->cmd_map, BSG_CMDS_PAGE_ORDER);
+	kfree(bd->cmd_bitmap);
+	bd->bdev = NULL;
+	bd->file = NULL;
+	bd->cmd_map = NULL;
+	bd->cmd_bitmap = NULL;
+	kfree(bd);
+	file->private_data = NULL;
+out:
+	up(&bsg_sem);
+	return ret;
+}
+
+static unsigned int bsg_poll(struct file *file, poll_table *wait)
+{
+	struct bsg_device *bd = file->private_data;
+	unsigned int mask = 0;
+
+	if (!bd)
+		return -ENXIO;
+
+	poll_wait(file, &bd->wq_done, wait);
+	poll_wait(file, &bd->wq_free, wait);
+
+	spin_lock_irq(&bd->lock);
+	if (!list_empty(&bd->done_list))
+		mask |= POLLIN | POLLRDNORM;
+	if (bd->queued_cmds >= bd->max_queue)
+		mask |= POLLOUT;
+	spin_unlock_irq(&bd->lock);
+
+	return mask;
+}
+
+static int
+bsg_add_device(struct inode *inode, struct file *file, unsigned long arg)
+{
+	struct block_device *bdev = NULL;
+	struct bsg_device *bd;
+	request_queue_t *queue;
+	struct inode *i;
+	struct file *f;
+#ifdef BSG_DEBUG
+	unsigned char buf[32];
+#endif
+	int ret;
+
+	down(&bsg_sem);
+
+	ret = -EBUSY;
+	if (file->private_data)
+		goto out;
+
+	ret = -ENOMEM;
+	bd = bsg_alloc_device();
+	if (!bd)
+		goto out;
+
+	ret = -ENODEV;
+	f = fget(arg);
+	if (!f)
+		goto out;
+	i = f->f_mapping->host;
+
+	ret = -EINVAL;
+	if (!S_ISBLK(i->i_mode))
+		goto out_fput;
+
+	ret = -ENODEV;
+	bdev = bdget(i->i_rdev);
+	if (!bdev)
+		goto out_fput;
+
+	ret = -ENXIO;
+	if (!bdev->bd_disk)
+		goto out_bdput;
+
+	/*
+	 * we require a request_fn, otherwise we cannot send it struct
+	 * request's
+	 */
+	ret = -ENOTBLK;
+	queue = bdev_get_queue(bdev);
+	if (!queue || !queue->request_fn)
+		goto out_bdput;
+
+	bd->bdev = bdev;
+	bd->queue = queue;
+	bd->file = f;
+	bd->can_block = !(file->f_flags & O_NONBLOCK);
+	strncpy(bd->name, bdev->bd_disk->disk_name, sizeof(bd->name));
+	dprintk("bound to <%s>, max queue %d\n",
+		format_dev_t(buf, i->i_rdev), bd->max_queue);
+	file->private_data = bd;
+	up(&bsg_sem);
+	return 0;
+out_bdput:
+	bdput(bdev);
+out_fput:
+	fput(f);
+out:
+	up(&bsg_sem);
+	return ret;
+}
+
+static int
+bsg_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	struct bsg_device *bd = file->private_data;
+	int __user *uarg = (int __user *) arg;
+
+	if (!bd && cmd != BSG_IOC_ADD)
+		return -ENXIO;
+
+	switch (cmd) {
+		/*
+		 * our own ioctls
+		 */
+		case BSG_IOC_ADD:
+			return bsg_add_device(inode, file, arg);
+		case SG_GET_COMMAND_Q:
+			return put_user(bd->max_queue, uarg);
+		case SG_SET_COMMAND_Q: {
+			int queue;
+
+			if (get_user(queue, uarg))
+				return -EFAULT;
+			if (queue > BSG_CMDS || queue < 1)
+				return -EINVAL;
+
+			bd->max_queue = queue;
+			return 0;
+		}
+		case SG_GET_MAX_COMMAND_SIZE: {
+			request_queue_t *q = bd->bdev->bd_disk->queue;
+			int bytes = q->max_sectors << 9;
+
+			return put_user(bytes, uarg);
+		}
+		/*
+		 * SCSI/sg ioctls
+		 */
+		case SG_GET_VERSION_NUM:
+		case SCSI_IOCTL_GET_IDLUN:
+		case SCSI_IOCTL_GET_BUS_NUMBER:
+		case SG_SET_TIMEOUT:
+		case SG_GET_TIMEOUT:
+		case SG_GET_RESERVED_SIZE:
+		case SG_SET_RESERVED_SIZE:
+		case SG_EMULATED_HOST:
+		case SG_IO:
+		case SCSI_IOCTL_SEND_COMMAND: {
+			void __user *uarg = (void __user *) arg;
+			return scsi_cmd_ioctl(bd->bdev->bd_disk, cmd, uarg);
+		}
+		/*
+		 * block device ioctls
+		 */
+		default:
+			return ioctl_by_bdev(bd->bdev, cmd, arg);
+	}
+}
+
+static struct file_operations bsg_fops = {
+	.read		=	bsg_read,
+	.write		=	bsg_write,
+	.poll		=	bsg_poll,
+	.open		=	bsg_open,
+	.release	=	bsg_release,
+	.ioctl		=	bsg_ioctl,
+	.readv		=	bsg_readv,
+	.writev		=	bsg_writev,
+	.owner		=	THIS_MODULE,
+};
+
+static struct cdev bsg_cdev = {
+	.kobj	=	{ .name = "bsg", },
+	.owner	=	THIS_MODULE,
+};
+
+static int __init bsg_init(void)
+{
+	dev_t dev = MKDEV(BSG_MAJOR, 0);
+	int ret, cpu;
+
+	bsg_wq = create_workqueue("bsg");
+	if (!bsg_wq)
+		return -ENOMEM;
+
+	ret = register_chrdev_region(dev, 1, "bsg");
+	if (ret) {
+		destroy_workqueue(bsg_wq);
+		return ret;
+	}
+
+	cdev_init(&bsg_cdev, &bsg_fops);
+	ret = cdev_add(&bsg_cdev, dev, 1);
+	if (ret) {
+		destroy_workqueue(bsg_wq);
+		kobject_put(&bsg_cdev.kobj);
+		unregister_chrdev_region(dev, 1);
+		return ret;
+	}
+
+	for_each_cpu(cpu)
+		INIT_LIST_HEAD(&per_cpu(bsg_cpu_work, cpu));
+
+	printk(KERN_INFO "%s loaded\n", bsg_version);
+	return 0;
+}
+
+static void __exit bsg_exit(void)
+{
+	dev_t dev = MKDEV(BSG_MAJOR, 0);
+
+	destroy_workqueue(bsg_wq);
+	cdev_del(&bsg_cdev);
+	unregister_chrdev_region(dev, 1);
+}
+
+MODULE_AUTHOR("Jens Axboe");
+MODULE_DESCRIPTION("Block layer SGSI generic (sg) driver");
+MODULE_LICENSE("GPL");
+
+module_init(bsg_init);
+module_exit(bsg_exit);
--- /dev/null	2004-04-06 15:27:52.000000000 +0200
+++ linux-2.6-bsg/drivers/block/bsg.h	2004-08-03 09:30:33.000000000 +0200
@@ -0,0 +1,7 @@
+#ifndef BSG_H
+#define BSG_H
+
+#define BSG_IOC_MAGIC		0x89
+#define BSG_IOC_ADD		0x8900
+
+#endif

-- 
Jens Axboe


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bsg_test.c"

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <scsi/sg.h>

#ifndef BSG_IOC_ADD
#define BSG_IOC_ADD     0x8900
#define BSG_IOC_DEL     0x8901
#endif

#define NR_QUEUE	(64)
#define NR_VECS		(4)

#if 1
#define SECTORS		(768)
#define BS		(512)
#define ACCOUNT		(100)
#else
#define SECTORS		(32)
#define BS		(2048)
#define ACCOUNT		(1)
#endif

#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) & ~(4095))

struct sg_io_hdr *hdr;
char *cdb;
char *buffer[NR_QUEUE];
#if NR_VECS > 1
static struct sg_iovec vecs[NR_QUEUE][NR_VECS];
#endif
char *sense;
static int nr_queue = NR_QUEUE;

static unsigned long ms;
static unsigned long kb;

typedef unsigned char u8;
#define __LITTLE_ENDIAN_BITFIELD

struct request_sense {
#if defined(__BIG_ENDIAN_BITFIELD)
	u8 valid		: 1;
	u8 error_code		: 7;
#elif defined(__LITTLE_ENDIAN_BITFIELD)
	u8 error_code		: 7;
	u8 valid		: 1;
#endif
	u8 segment_number;
#if defined(__BIG_ENDIAN_BITFIELD)
	u8 reserved1		: 2;
	u8 ili			: 1;
	u8 reserved2		: 1;
	u8 sense_key		: 4;
#elif defined(__LITTLE_ENDIAN_BITFIELD)
	u8 sense_key		: 4;
	u8 reserved2		: 1;
	u8 ili			: 1;
	u8 reserved1		: 2;
#endif
	u8 information[4];
	u8 add_sense_len;
	u8 command_info[4];
	u8 asc;
	u8 ascq;
	u8 fruc;
	u8 sks[3];
	u8 asb[46];
};

int queue_cmds(int fd, struct sg_io_hdr *hdr, int nr)
{
	return write(fd, hdr, sizeof(struct sg_io_hdr) * nr);
}

inline void account_hdr(struct sg_io_hdr *hdr)
{
	kb += hdr->dxfer_len / 1024;
	ms += hdr->duration;
	if (kb > ACCOUNT*1024) {
		printf("data rate %luKiB/sec\n", kb * 1000 / ms);
		ms = kb = 0;
	}
}

void sense_decode(struct sg_io_hdr *h)
{
	struct request_sense *s = (struct request_sense *) h->sbp;
	int i;

	printf("cdb: ");
	for (i = 0; i < h->cmd_len; i++)
		printf("%02x ", h->cmdp[i]);
	printf("\n");
	printf("0x%02x/0x%02x/0x%02x\n", s->sense_key, s->asc, s->ascq);
}

int wait_cmd(int fd, struct sg_io_hdr *hdr, int nr)
{
	int ret = read(fd, hdr, sizeof(struct sg_io_hdr) * nr);
	int i;

	if (ret == -1)
		return ret;

	for (i = 0; i < nr; i++) {
		struct sg_io_hdr *h = hdr + i;

		//printf("%d completed\n", h->pack_id);
		if (h->status == 0x02)
			sense_decode(h);
		account_hdr(h);
	}

	return ret;
}

void do_read10(int fd, struct sg_io_hdr *hdr, unsigned long lba)
{
	hdr->interface_id = 'S';
	hdr->cmd_len = 10;
	hdr->dxfer_direction = SG_DXFER_FROM_DEV;
	hdr->dxfer_len = SECTORS * BS;

	hdr->cmdp[0] = 0x28;
	hdr->cmdp[2] = (lba >> 24) & 0xff;
	hdr->cmdp[3] = (lba >> 16) & 0xff;
	hdr->cmdp[4] = (lba >>  8) & 0xff;
	hdr->cmdp[5] = (lba      ) & 0xff;
	hdr->cmdp[7] = (SECTORS >> 8) & 0xff;
	hdr->cmdp[8] = (SECTORS     ) & 0xff;
}

int bind_device(const char *device)
{
	int fd = open(device, O_RDONLY | O_NONBLOCK);
	int bsg_fd;

	if (fd == -1) {
		perror("open input");
		return -1;
	}

	bsg_fd = open("/dev/bsg", O_RDWR);
	if (bsg_fd == -1) {
		perror("open bsg");
		return -1;
	}

	if (ioctl(bsg_fd, BSG_IOC_ADD, fd) == -1) {
		perror("BSG_IOC_ADD");
		return -1;
	}

	return bsg_fd;
}

int main(int argc, const char *argv[])
{
	unsigned long lba = 0, read_kb;
	int fd, i, ret;

	if (argc < 2) {
		printf("%s: <device>\n", argv[0]);
		return 1;
	}

	fd = bind_device(argv[1]);
	if (fd == -1)
		return 1;

	cdb = malloc(10 * NR_QUEUE);
	memset(cdb, 0, 10 * NR_QUEUE);

	hdr = malloc(NR_QUEUE * sizeof(struct sg_io_hdr));
	memset(hdr, 0, NR_QUEUE * sizeof(struct sg_io_hdr));

	sense = malloc(NR_QUEUE * 64);
	memset(sense, 0, 64);
	
	for (i = 0; i < NR_QUEUE; i++) {
#if NR_VECS > 1
		int j;
		hdr[i].dxferp = vecs[i];
		hdr[i].iovec_count = NR_VECS;
		for (j = 0; j < NR_VECS; j++) {
			int size = SECTORS*BS/NR_VECS;
			vecs[i][j].iov_base = ALIGN(malloc(size*2));
			vecs[i][j].iov_len = size;
		}
#else
		buffer[i] = ALIGN(malloc(SECTORS*BS+BS-1));
#endif
	}

	for (read_kb = 0; read_kb < 256*1024;) {
		for (i = 0; i < nr_queue; i++) {
			struct sg_io_hdr *h = hdr + i;
#if NR_VECS <= 1
			h->dxferp = buffer[i];
#endif
			h->cmdp = cdb + i*10;
			h->pack_id = i;
			h->sbp = sense + i*64;
			h->mx_sb_len = 64;

			lba = (1+(int) (5120000.0*rand()/(RAND_MAX+1.0)));

			do_read10(fd, h, lba);
			lba += SECTORS;
		}

		ret = queue_cmds(fd, hdr, nr_queue);
		if (ret == -1) {
			perror("write cmds\n");
			break;
		} else if (!ret) {
			printf("strange, nothing queued but no error\n");
			break;
		} else if ((ret / sizeof(struct sg_io_hdr)) < nr_queue) {
			nr_queue = ret / sizeof(struct sg_io_hdr);
			printf("adjusting depth %d\n", nr_queue);
		}
		if (wait_cmd(fd, hdr, nr_queue) == -1) {
			perror("read cmd\n");
			break;
		}
		read_kb += nr_queue * (SECTORS >> 1);
	}

	close(fd);
	return 0;
}

--oyUTqETQ0mS9luUI--

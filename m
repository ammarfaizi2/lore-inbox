Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUETNf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUETNf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 09:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUETNfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 09:35:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36058 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265087AbUETNeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 09:34:44 -0400
Date: Thu, 20 May 2004 15:34:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Philip Dodd <phil.lists@two-towers.net>
Cc: linux-kernel@vger.kernel.org, Hugo Mills <hugo-lkml@carfax.org.uk>,
       Daniele Bernardini <db@sqbc.com>
Subject: Re: dma ripping
Message-ID: <20040520133437.GH1952@suse.de>
References: <1084548566.12022.57.camel@linux.site> <20040515101415.GA24600@suse.de> <1084610731.4666.8.camel@linux.site> <20040515145800.GE24600@suse.de> <1084629809.4612.51.camel@linux.site> <20040515211901.GG24600@suse.de> <40A78834.1030605@two-towers.net> <20040516153945.GA21520@selene> <40A9377A.70200@two-towers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A9377A.70200@two-towers.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18 2004, Philip Dodd wrote:
> Hugo Mills wrote:
> 8<
> >   Put me down for this latter one, too. I'm using a vanilla 2.6.[56]
> >on amd64. Controller is VIA.
> >
> >   It seems to be related to hard-to-read CDs (dirty/scratched/badly-
> >made) -- I've got a couple here that I'm pretty sure I can use as test
> >cases to trigger the problem instantly.
> 8<
> Hi,
> 
> OK - I don't know if any of this helps, but I guess a little more 
> precision won't do anyone any harm.
> Intel i820 Chipset on P3C-D mobo.
> ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
> hda: ASUS DVD-ROM E616, ATAPI CD/DVD-ROM drive
> hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> 
> ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
> hdc: RICOH CD-R/RW MP7060A, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
> 
> Now hda is the one that bogs out, ripping silence after the "cdrom:
> dropping to single frame dma" error. hdc can rip for hours and hardly 
> ever get cdparanoia errors - even on "problematic" CDs that would appear 
> to be a declenching factor for the single frame dma switch for hda.

Any chance you can see if this makes any difference (on 2.6.6-BK)?

===== drivers/block/ll_rw_blk.c 1.252 vs edited =====
--- 1.252/drivers/block/ll_rw_blk.c	2004-05-15 08:11:55 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2004-05-20 14:38:53 +02:00
@@ -1760,21 +1760,20 @@
  *    A matching blk_rq_unmap_user() must be issued at the end of io, while
  *    still in process context.
  */
-struct request *blk_rq_map_user(request_queue_t *q, int rw, void __user *ubuf,
-				unsigned int len)
+struct request *blk_rq_map_user(request_queue_t *q, struct rq_map_data *rmd)
 {
 	struct request *rq = NULL;
 	char *buf = NULL;
 	struct bio *bio;
 	int ret;
 
-	rq = blk_get_request(q, rw, __GFP_WAIT);
+	rq = blk_get_request(q, rmd->rw, __GFP_WAIT);
 	if (!rq)
 		return ERR_PTR(-ENOMEM);
 
-	bio = bio_map_user(q, NULL, (unsigned long) ubuf, len, rw == READ);
+	bio = bio_map_user(q, NULL, rmd->userptr, rmd->len, rmd->rw == READ);
 	if (!bio) {
-		int bytes = (len + 511) & ~511;
+		int bytes = (rmd->len + 511) & ~511;
 
 		buf = kmalloc(bytes, q->bounce_gfp | GFP_USER);
 		if (!buf) {
@@ -1782,21 +1781,26 @@
 			goto fault;
 		}
 
-		if (rw == WRITE) {
-			if (copy_from_user(buf, ubuf, len)) {
+		if (rmd->rw == WRITE) {
+			char *userptr = (char *) rmd->userptr;
+
+			if (copy_from_user(buf, userptr, rmd->len)) {
 				ret = -EFAULT;
 				goto fault;
 			}
 		} else
-			memset(buf, 0, len);
+			memset(buf, 0, rmd->len);
 	}
 
 	rq->bio = rq->biotail = bio;
 	if (rq->bio)
 		blk_rq_bio_prep(q, rq, bio);
 
+	rmd->buf = buf;
+	rmd->bio = bio;
+
 	rq->buffer = rq->data = buf;
-	rq->data_len = len;
+	rq->data_len = rmd->len;
 	return rq;
 fault:
 	if (buf)
@@ -1806,6 +1810,8 @@
 	if (rq)
 		blk_put_request(rq);
 
+	rmd->bio = NULL;
+	rmd->buf = NULL;
 	return ERR_PTR(ret);
 }
 
@@ -1820,18 +1826,19 @@
  * Description:
  *    Unmap a request previously mapped by blk_rq_map_user().
  */
-int blk_rq_unmap_user(struct request *rq, void __user *ubuf, struct bio *bio,
-		      unsigned int ulen)
+int blk_rq_unmap_user(struct request *rq, struct rq_map_data *rmd)
 {
-	const int read = rq_data_dir(rq) == READ;
+	const int read = rmd->rw == READ;
 	int ret = 0;
 
-	if (bio)
-		bio_unmap_user(bio, read);
-	if (rq->buffer) {
-		if (read && copy_to_user(ubuf, rq->buffer, ulen))
+	if (rmd->bio)
+		bio_unmap_user(rmd->bio, read);
+	else if (rmd->buf) {
+		char *userptr = (char *) rmd->userptr;
+
+		if (read && copy_to_user(userptr, rmd->buf, rmd->len))
 			ret = -EFAULT;
-		kfree(rq->buffer);
+		kfree(rmd->buf);
 	}
 
 	blk_put_request(rq);
===== drivers/block/scsi_ioctl.c 1.42 vs edited =====
--- 1.42/drivers/block/scsi_ioctl.c	2004-04-27 15:20:34 +02:00
+++ edited/drivers/block/scsi_ioctl.c	2004-05-20 15:10:56 +02:00
@@ -110,8 +110,8 @@
 {
 	unsigned long start_time;
 	int reading, writing;
+	struct rq_map_data rmd;
 	struct request *rq;
-	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
 
 	if (hdr->interface_id != 'S')
@@ -128,6 +128,7 @@
 	if (hdr->dxfer_len > (q->max_sectors << 9))
 		return -EIO;
 
+	memset(&rmd, 0, sizeof(rmd));
 	reading = writing = 0;
 	if (hdr->dxfer_len) {
 		switch (hdr->dxfer_direction) {
@@ -144,8 +145,10 @@
 			break;
 		}
 
-		rq = blk_rq_map_user(q, writing ? WRITE : READ, hdr->dxferp,
-				     hdr->dxfer_len);
+		rmd.userptr = (unsigned long) hdr->dxferp;
+		rmd.len = hdr->dxfer_len;
+		rmd.rw = writing ? WRITE : READ;
+		rq = blk_rq_map_user(q, &rmd);
 
 		if (IS_ERR(rq))
 			return PTR_ERR(rq);
@@ -165,7 +168,6 @@
 	rq->sense_len = 0;
 
 	rq->flags |= REQ_BLOCK_PC;
-	bio = rq->bio;
 
 	rq->timeout = (hdr->timeout * HZ) / 1000;
 	if (!rq->timeout)
@@ -201,7 +203,7 @@
 			hdr->sb_len_wr = len;
 	}
 
-	if (blk_rq_unmap_user(rq, hdr->dxferp, bio, hdr->dxfer_len))
+	if (blk_rq_unmap_user(rq, &rmd))
 		return -EFAULT;
 
 	/* may not have succeeded, but output values written to control
===== drivers/cdrom/cdrom.c 1.52 vs edited =====
--- 1.52/drivers/cdrom/cdrom.c	2004-04-27 15:11:55 +02:00
+++ edited/drivers/cdrom/cdrom.c	2004-05-20 15:13:30 +02:00
@@ -1946,23 +1946,26 @@
 {
 	request_queue_t *q = cdi->disk->queue;
 	struct request *rq;
-	struct bio *bio;
-	unsigned int len;
 	int nr, ret = 0;
 
 	if (!q)
 		return -ENXIO;
 
 	while (nframes) {
+		struct rq_map_data rmd;
+
 		nr = nframes;
 		if (cdi->cdda_method == CDDA_BPC_SINGLE)
 			nr = 1;
 		if (nr * CD_FRAMESIZE_RAW > (q->max_sectors << 9))
 			nr = (q->max_sectors << 9) / CD_FRAMESIZE_RAW;
 
-		len = nr * CD_FRAMESIZE_RAW;
+		memset(&rmd, 0, sizeof(rmd));
+		rmd.userptr = (unsigned long) ubuf;
+		rmd.len = nr * CD_FRAMESIZE_RAW;
+		rmd.rw = READ;
 
-		rq = blk_rq_map_user(q, READ, ubuf, len);
+		rq = blk_rq_map_user(q, &rmd);
 		if (IS_ERR(rq))
 			return PTR_ERR(rq);
 
@@ -1981,7 +1984,6 @@
 		rq->cmd_len = 12;
 		rq->flags |= REQ_BLOCK_PC;
 		rq->timeout = 60 * HZ;
-		bio = rq->bio;
 
 		if (blk_execute_rq(q, cdi->disk, rq)) {
 			struct request_sense *s = rq->sense;
@@ -1989,7 +1991,7 @@
 			cdi->last_sense = s->sense_key;
 		}
 
-		if (blk_rq_unmap_user(rq, ubuf, bio, len))
+		if (blk_rq_unmap_user(rq, &rmd))
 			ret = -EFAULT;
 
 		if (ret)
===== include/linux/blkdev.h 1.145 vs edited =====
--- 1.145/include/linux/blkdev.h	2004-05-19 18:02:45 +02:00
+++ edited/include/linux/blkdev.h	2004-05-20 14:37:09 +02:00
@@ -501,6 +501,24 @@
 	unsigned block_size_bits;
 };
 
+/*
+ * passed in and out of blk_rq_map/unmap_user()
+ */
+struct rq_map_data {
+	/*
+	 * input data
+	 */
+	unsigned long userptr;
+	unsigned int len;
+	int rw;
+
+	/*
+	 * output data
+	 */
+	struct bio *bio;
+	unsigned char *buf;
+};
+
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern void register_disk(struct gendisk *dev);
@@ -523,8 +541,8 @@
 extern void __blk_stop_queue(request_queue_t *q);
 extern void blk_run_queue(request_queue_t *);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
-extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
-extern int blk_rq_unmap_user(struct request *, void __user *, struct bio *, unsigned int);
+extern struct request *blk_rq_map_user(request_queue_t *q, struct rq_map_data *rmd);
+extern int blk_rq_unmap_user(struct request *rq, struct rq_map_data *rmd);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *, struct request *);
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)

-- 
Jens Axboe


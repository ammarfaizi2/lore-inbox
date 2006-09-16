Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWIPEIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWIPEIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 00:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWIPEIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 00:08:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932415AbWIPEIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 00:08:50 -0400
From: michaelc@cs.wisc.edu
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 2/2] block: convert blk_rq_map_users take 2
Reply-To: michaelc@cs.wisc.edu
Date: Fri, 15 Sep 2006 23:08:36 -0400
Message-Id: <11583761182381-git-send-email-michaelc@cs.wisc.edu>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11583761161108-git-send-email-michaelc@cs.wisc.edu>
References: <11583761161108-git-send-email-michaelc@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch converts cdrom, scsi_ioctl and bsg to use the modified
blk_rq_map_usr.

Changes:
1. Have caller track bio head.
2. Fix bug in bsg.c multiple iovec mapping. We were resetting the head
everytime we call blk_rq_map_usr and so new calls where leaking the
previously mapped iovec.
Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 block/bsg.c           |   78 +++++++------------------------------------------
 block/scsi_ioctl.c    |   30 +++++++------------
 drivers/cdrom/cdrom.c |    6 +---
 3 files changed, 24 insertions(+), 90 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index cf48a81..5d23f97 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -70,11 +70,6 @@ #define BSG_CMDS_MASK		(BSG_CMDS_PER_LON
 #define BSG_CMDS_BYTES		(PAGE_SIZE * (1 << BSG_CMDS_PAGE_ORDER))
 #define BSG_CMDS		(BSG_CMDS_BYTES / sizeof(struct bsg_command))
 
-/*
- * arbitrary limit, mapping bio's will reveal true device limit
- */
-#define BSG_MAX_VECS		(128)
-
 #undef BSG_DEBUG
 
 #ifdef BSG_DEBUG
@@ -251,8 +246,6 @@ bsg_validate_sghdr(request_queue_t *q, s
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
-	if (hdr->iovec_count > BSG_MAX_VECS)
-		return -EINVAL;
 	if (hdr->dxfer_len > (q->max_sectors << 9))
 		return -EIO;
 
@@ -282,12 +275,12 @@ bsg_validate_sghdr(request_queue_t *q, s
  * each segment to a bio and string multiple bio's to the request
  */
 static struct request *
-bsg_map_hdr(request_queue_t *q, int rw, struct sg_io_hdr *hdr)
+bsg_map_hdr(struct bsg_device *bd, int rw, struct sg_io_hdr *hdr)
 {
+	request_queue_t *q = bd->queue;
 	struct sg_iovec iov;
 	struct sg_iovec __user *u_iov;
 	struct request *rq;
-	struct bio *bio;
 	int ret, i = 0;
 
 	dprintk("map hdr %p/%d/%d\n", hdr->dxferp, hdr->dxfer_len,
@@ -301,6 +294,12 @@ bsg_map_hdr(request_queue_t *q, int rw, 
 	 * map scatter-gather elements seperately and string them to request
 	 */
 	rq = blk_get_request(q, rw, GFP_KERNEL);
+	ret = blk_fill_sghdr_rq(q, rq, hdr, test_bit(BSG_F_WRITE_PERM,
+				&bd->flags));
+	if (ret) {
+		blk_put_request(rq);
+		return ERR_PTR(ret);
+	}
 
 	if (!hdr->iovec_count) {
 		ret = blk_rq_map_user(q, rq, hdr->dxferp, hdr->dxfer_len);
@@ -310,9 +309,6 @@ bsg_map_hdr(request_queue_t *q, int rw, 
 
 	u_iov = hdr->dxferp;
 	for (ret = 0, i = 0; i < hdr->iovec_count; i++, u_iov++) {
-		int to_vm = rw == READ;
-		unsigned long uaddr;
-
 		if (copy_from_user(&iov, u_iov, sizeof(iov))) {
 			ret = -EFAULT;
 			break;
@@ -323,57 +319,9 @@ bsg_map_hdr(request_queue_t *q, int rw, 
 			break;
 		}
 
-		uaddr = (unsigned long) iov.iov_base;
-		if (!(uaddr & queue_dma_alignment(q))
-		    && !(iov.iov_len & queue_dma_alignment(q)))
-			bio = bio_map_user(q, NULL, uaddr, iov.iov_len, to_vm);
-		else
-			bio = bio_copy_user(q, uaddr, iov.iov_len, to_vm);
-
-		if (IS_ERR(bio)) {
-			ret = PTR_ERR(bio);
-			bio = NULL;
+		ret = blk_rq_map_user(q, rq, iov.iov_base, iov.iov_len);
+		if (ret)
 			break;
-		}
-
-		dprintk("bsg: adding segment %d\n", i);
-
-		if (rq->bio) {
-			/*
-			 * for most (all? don't know of any) queues we could
-			 * skip grabbing the queue lock here. only drivers with
-			 * funky private ->back_merge_fn() function could be
-			 * problematic.
-			 */
-			spin_lock_irq(q->queue_lock);
-			ret = q->back_merge_fn(q, rq, bio);
-			spin_unlock_irq(q->queue_lock);
-
-			rq->biotail->bi_next = bio;
-			rq->biotail = bio;
-
-			/*
-			 * break after adding bio, so we don't have to special
-			 * case the cleanup too much
-			 */
-			if (!ret) {
-				ret = -EINVAL;
-				break;
-			}
-
-			/*
-			 * merged ok, update state
-			 */
-			rq->nr_sectors += bio_sectors(bio);
-			rq->hard_nr_sectors = rq->nr_sectors;
-			rq->data_len += bio->bi_size;
-		} else {
-			/*
-			 * first bio, setup rq state
-			 */
-			blk_rq_bio_prep(q, rq, bio);
-		}
-		ret = 0;
 	}
 
 	/*
@@ -767,17 +715,13 @@ static ssize_t __bsg_write(struct bsg_de
 		/*
 		 * get a request, fill in the blanks, and add to request queue
 		 */
-		rq = bsg_map_hdr(q, rw, &bc->hdr);
+		rq = bsg_map_hdr(bd, rw, &bc->hdr);
 		if (IS_ERR(rq)) {
 			ret = PTR_ERR(rq);
 			rq = NULL;
 			break;
 		}
 
-		ret = blk_fill_sghdr_rq(q, rq, &bc->hdr, test_bit(BSG_F_WRITE_PERM, &bd->flags));
-		if (ret)
-			break;
-
 		bsg_add_command(bd, q, bc, rq);
 		bc = NULL;
 		rq = NULL;
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 9426b54..bbc2925 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -246,17 +246,10 @@ EXPORT_SYMBOL_GPL(blk_fill_sghdr_rq);
  */
 int blk_unmap_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr)
 {
-	struct bio *bio = rq->bio;
-
 	/*
 	 * also releases request
 	 */
-	if (!hdr->iovec_count)
-		return blk_rq_unmap_user(bio, hdr->dxfer_len);
-
-	rq_for_each_bio(bio, rq)
-		bio_unmap_user(bio);
-
+	blk_rq_unmap_user(rq);
 	blk_put_request(rq);
 	return 0;
 }
@@ -332,6 +325,14 @@ static int sg_io(struct file *file, requ
 	if (!rq)
 		return -ENOMEM;
 
+	if (file)
+		has_write_perm = file->f_mode & FMODE_WRITE;
+
+	if (blk_fill_sghdr_rq(q, rq, hdr, has_write_perm)) {
+		blk_put_request(rq);
+		return -EFAULT;
+	}
+
 	if (hdr->iovec_count) {
 		const int size = sizeof(struct sg_iovec) * hdr->iovec_count;
 		struct sg_iovec *iov;
@@ -348,7 +349,8 @@ static int sg_io(struct file *file, requ
 			goto out;
 		}
 
-		ret = blk_rq_map_user_iov(q, rq, iov, hdr->iovec_count);
+		ret = blk_rq_map_user_iov(q, rq, iov, hdr->iovec_count,
+					  hdr->dxfer_len);
 		kfree(iov);
 	} else if (hdr->dxfer_len)
 		ret = blk_rq_map_user(q, rq, hdr->dxferp, hdr->dxfer_len);
@@ -356,17 +358,7 @@ static int sg_io(struct file *file, requ
 	if (ret)
 		goto out;
 
-	if (file)
-		has_write_perm = file->f_mode & FMODE_WRITE;
-
 	bio = rq->bio;
-
-	if (blk_fill_sghdr_rq(q, rq, hdr, has_write_perm)) {
-		blk_rq_unmap_user(bio, hdr->dxfer_len);
-		blk_put_request(rq);
-		return -EFAULT;
-	}
-
 	memset(sense, 0, sizeof(sense));
 	rq->sense = sense;
 	rq->sense_len = 0;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index b38c84a..b7f16fa 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2133,16 +2133,14 @@ static int cdrom_read_cdda_bpc(struct cd
 		rq->timeout = 60 * HZ;
 		bio = rq->bio;
 
-		if (rq->bio)
-			blk_queue_bounce(q, &rq->bio);
-
 		if (blk_execute_rq(q, cdi->disk, rq, 0)) {
 			struct request_sense *s = rq->sense;
 			ret = -EIO;
 			cdi->last_sense = s->sense_key;
 		}
 
-		if (blk_rq_unmap_user(bio, len))
+		rq->bio = bio;
+		if (blk_rq_unmap_user(rq))
 			ret = -EFAULT;
 
 		if (ret)
-- 
1.4.1


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWIIXJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWIIXJj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWIIXJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:09:38 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:1957 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964994AbWIIXJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:09:37 -0400
Subject: Re: [PATCH 2/2] block: convert bsg, scsi_ioctl and cdrom to new
	blk_rq_map_user fns
From: Mike Christie <michaelc@cs.wisc.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, axboe@suse.de
In-Reply-To: <1157835222.4543.11.camel@max>
References: <1157835222.4543.11.camel@max>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 18:09:45 -0400
Message-Id: <1157839785.5281.4.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 16:53 -0400, Mike Christie wrote:
> This patch just converts bsg, scsi_ioctl and cdrom to
> the new functions. There is not really much of a change
> for scsi_ioctl and cdrom. The block layer functions
> handle things like bounce buffers, and bio unmapping accounting
> for them now.
> 
> The bsg change is larger since I based the blk layer functions
> on it and the scsi lib code, so there are lots of deletions.
> There were also a couple of bugs that got fixes as a result
> of using the blk layer API:
> - If the hdr iovec_count = 0, then the request was not getting
> freed because blk_unmap_sghdr_rq thought blk_rq_unmap_user
> would free the request which it does not.
> - blk_unmap_sghdr_rq would always call bio_unmap_user, even if
> bio_copy_user was used. This was causing all types of weird bugs
> like slab corruption.
> 
> I have tested the copy and map code with scsi_ioctl.c with large
> requests having multiple bios. I have not tested bsg or cdrom.
> And High Mem is not tested well. I am not sure how to force high
> mem pages to be used for the mapping. Was there a proc or module
> param that can be used?
> 
> Patch was made over Jens's block tree and the bsg branch
> 
> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>


That patch was bad. As you can probably tell, I was trying to use git
and was hand editing the patch at the same time. The patch below fixes
the compile errors found in the previous patch.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

diff --git a/block/bsg.c b/block/bsg.c
index cf48a81..d3f53f8 100644
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
@@ -107,7 +102,6 @@ struct bsg_command {
 	struct bsg_device *bd;
 	struct list_head list;
 	struct request *rq;
-	struct bio *bio;
 	int err;
 	struct sg_io_hdr hdr;
 	struct sg_io_hdr __user *uhdr;
@@ -251,8 +245,6 @@ bsg_validate_sghdr(request_queue_t *q, s
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
-	if (hdr->iovec_count > BSG_MAX_VECS)
-		return -EINVAL;
 	if (hdr->dxfer_len > (q->max_sectors << 9))
 		return -EIO;
 
@@ -282,12 +274,12 @@ bsg_validate_sghdr(request_queue_t *q, s
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
@@ -301,6 +293,12 @@ bsg_map_hdr(request_queue_t *q, int rw, 
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
@@ -310,9 +308,6 @@ bsg_map_hdr(request_queue_t *q, int rw, 
 
 	u_iov = hdr->dxferp;
 	for (ret = 0, i = 0; i < hdr->iovec_count; i++, u_iov++) {
-		int to_vm = rw == READ;
-		unsigned long uaddr;
-
 		if (copy_from_user(&iov, u_iov, sizeof(iov))) {
 			ret = -EFAULT;
 			break;
@@ -323,57 +318,9 @@ bsg_map_hdr(request_queue_t *q, int rw, 
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
@@ -399,8 +346,8 @@ static void bsg_rq_end_io(struct request
 	struct bsg_device *bd = bc->bd;
 	unsigned long flags;
 
-	dprintk("%s: finished rq %p bio %p, bc %p offset %ld stat %d\n",
-			bd->name, rq, bc, bc->bio, bc - bd->cmd_map, uptodate);
+	dprintk("%s: finished rq %p, bc %p offset %ld stat %d\n",
+			bd->name, rq, bc, bc - bd->cmd_map, uptodate);
 
 	bc->hdr.duration = jiffies_to_msecs(jiffies - bc->hdr.duration);
 
@@ -424,7 +371,6 @@ static void bsg_add_command(struct bsg_d
 	 * add bc command to busy queue and submit rq for io
 	 */
 	bc->rq = rq;
-	bc->bio = rq->bio;
 	bc->hdr.duration = jiffies;
 	spin_lock_irq(&bd->lock);
 	list_add_tail(&bc->list, &bd->busy_list);
@@ -529,7 +475,7 @@ static int bsg_complete_all_commands(str
 			break;
 		}
 
-		tret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+		tret = blk_complete_sghdr_rq(bc->rq, &bc->hdr);
 		if (!ret)
 			ret = tret;
 
@@ -565,7 +511,7 @@ __bsg_read(char __user *buf, size_t coun
 		 * after completing the request. so do that here,
 		 * bsg_complete_work() cannot do that for us
 		 */
-		ret = blk_complete_sghdr_rq(bc->rq, &bc->hdr, bc->bio);
+		ret = blk_complete_sghdr_rq(bc->rq, &bc->hdr);
 
 		if (copy_to_user(buf, (char *) &bc->hdr, sizeof(bc->hdr)))
 			ret = -EFAULT;
@@ -767,17 +713,13 @@ static ssize_t __bsg_write(struct bsg_de
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
index 9426b54..afd4630 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -246,24 +246,16 @@ EXPORT_SYMBOL_GPL(blk_fill_sghdr_rq);
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
 EXPORT_SYMBOL_GPL(blk_unmap_sghdr_rq);
 
-int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
-			  struct bio *bio)
+int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr)
 {
 	int r, ret = 0;
 
@@ -290,7 +282,6 @@ int blk_complete_sghdr_rq(struct request
 			ret = -EFAULT;
 	}
 
-	rq->bio = bio;
 	r = blk_unmap_sghdr_rq(rq, hdr);
 	if (ret)
 		r = ret;
@@ -305,7 +296,6 @@ static int sg_io(struct file *file, requ
 	unsigned long start_time;
 	int writing = 0, ret = 0, has_write_perm = 0;
 	struct request *rq;
-	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
 
 	if (hdr->interface_id != 'S')
@@ -332,6 +322,14 @@ static int sg_io(struct file *file, requ
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
@@ -348,7 +346,8 @@ static int sg_io(struct file *file, requ
 			goto out;
 		}
 
-		ret = blk_rq_map_user_iov(q, rq, iov, hdr->iovec_count);
+		ret = blk_rq_map_user_iov(q, rq, iov, hdr->iovec_count,
+					  hdr->dxfer_len);
 		kfree(iov);
 	} else if (hdr->dxfer_len)
 		ret = blk_rq_map_user(q, rq, hdr->dxferp, hdr->dxfer_len);
@@ -356,17 +355,6 @@ static int sg_io(struct file *file, requ
 	if (ret)
 		goto out;
 
-	if (file)
-		has_write_perm = file->f_mode & FMODE_WRITE;
-
-	bio = rq->bio;
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
@@ -383,7 +371,7 @@ static int sg_io(struct file *file, requ
 
 	hdr->duration = ((jiffies - start_time) * 1000) / HZ;
 
-	return blk_complete_sghdr_rq(rq, hdr, bio);
+	return blk_complete_sghdr_rq(rq, hdr);
 out:
 	blk_put_request(rq);
 	return ret;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index b38c84a..5991263 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2090,7 +2090,6 @@ static int cdrom_read_cdda_bpc(struct cd
 {
 	request_queue_t *q = cdi->disk->queue;
 	struct request *rq;
-	struct bio *bio;
 	unsigned int len;
 	int nr, ret = 0;
 
@@ -2131,10 +2130,6 @@ static int cdrom_read_cdda_bpc(struct cd
 		rq->cmd_len = 12;
 		rq->cmd_type = REQ_TYPE_BLOCK_PC;
 		rq->timeout = 60 * HZ;
-		bio = rq->bio;
-
-		if (rq->bio)
-			blk_queue_bounce(q, &rq->bio);
 
 		if (blk_execute_rq(q, cdi->disk, rq, 0)) {
 			struct request_sense *s = rq->sense;
@@ -2142,7 +2137,7 @@ static int cdrom_read_cdda_bpc(struct cd
 			cdi->last_sense = s->sense_key;
 		}
 
-		if (blk_rq_unmap_user(bio, len))
+		if (blk_rq_unmap_user(rq))
 			ret = -EFAULT;
 
 		if (ret)



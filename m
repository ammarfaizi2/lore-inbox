Return-Path: <linux-kernel-owner+w=401wt.eu-S1754389AbWLRSji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbWLRSji (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbWLRSji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:39:38 -0500
Received: from brick.kernel.dk ([62.242.22.158]:24866 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388AbWLRSjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:39:37 -0500
Date: Mon, 18 Dec 2006 19:41:17 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061218184117.GQ5010@kernel.dk>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061214212055.GR5010@kernel.dk> <200612150048.25552.s0348365@sms.ed.ac.uk> <200612150141.09020.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org> <20061218183209.GP5010@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218183209.GP5010@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18 2006, Jens Axboe wrote:
> On Sat, Dec 16 2006, Linus Torvalds wrote:
> > That said: Jens - I think 0e75f906 was a mistake. "blk_rq_unmap()" really 
> > should be passed the "struct bio", not the "struct request *". Right now 
> > it does something _really_ strange with requests with linked bio's, and I 
> > don't think your and FUJITA's "leak fix" really works. What happens when 
> > the bio was a linked list on the request, and you put the old _head_ on 
> > the request with "rq->bio = bio"? What happens to the other parts of it?
> 
> I agree it's fishy and I did think about it. The design isn't exactly
> the prettiest, but it should be safe. The reason is that we don't
> actually unlink the individual bio from the list, even if we may set
> rq->bio to point somewhere further into the list. So as long as the bio
> is valid, the bi_next field is still valid as well. We need a reference
> on the bio to perform the unmap and blk_rq_unmap_user() drops this
> reference on its own, so the bio must be valid.
> 
> Taking a rq pointer when we really want a bio is nasty, though. I'll
> chance that at least.

Something like this. One alternative I did originally consider was to
add a rq->cbio (for lack of a better name) that points to the original
bio and isn't cleared on io completion, just to have the original bio
location stored. That makes the API symmetric and doesn't have any
hidden requirements, at the cost of an extra pointer in struct request.
So I think the included is the better patch, since it's still clear what
needs to be done and it doesn't add extra members to struct request.

-----

The blk_rq_unmap_user() API is not very nice. It expects the caller to
know that rq->bio has to be reset to the original bio, and it will
silently do nothing if that is not done. Instead make it explicit that
we need to pass in the first bio, by expecting a bio argument.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index fb40575..51c828e 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2323,6 +2323,7 @@ int blk_rq_map_user(request_queue_t *q, struct request *rq, void __user *ubuf,
 		    unsigned long len)
 {
 	unsigned long bytes_read = 0;
+	struct bio *bio = NULL;
 	int ret;
 
 	if (len > (q->max_hw_sectors << 9))
@@ -2349,6 +2350,8 @@ int blk_rq_map_user(request_queue_t *q, struct request *rq, void __user *ubuf,
 		ret = __blk_rq_map_user(q, rq, ubuf, map_len);
 		if (ret < 0)
 			goto unmap_rq;
+		if (!bio)
+			bio = rq->bio;
 		bytes_read += ret;
 		ubuf += ret;
 	}
@@ -2356,7 +2359,7 @@ int blk_rq_map_user(request_queue_t *q, struct request *rq, void __user *ubuf,
 	rq->buffer = rq->data = NULL;
 	return 0;
 unmap_rq:
-	blk_rq_unmap_user(rq);
+	blk_rq_unmap_user(bio);
 	return ret;
 }
 
@@ -2413,26 +2416,28 @@ EXPORT_SYMBOL(blk_rq_map_user_iov);
 
 /**
  * blk_rq_unmap_user - unmap a request with user data
- * @rq:		rq to be unmapped
+ * @bio:		start of bio list
  *
  * Description:
- *    Unmap a rq previously mapped by blk_rq_map_user().
- *    rq->bio must be set to the original head of the request.
+ *    Unmap a rq previously mapped by blk_rq_map_user(). The caller must
+ *    supply the original rq->bio from the blk_rq_map_user() return, since
+ *    the io completion may have changed rq->bio.
  */
-int blk_rq_unmap_user(struct request *rq)
+int blk_rq_unmap_user(struct bio *bio)
 {
-	struct bio *bio, *mapped_bio;
+	struct bio *mapped_bio;
 
-	while ((bio = rq->bio)) {
-		if (bio_flagged(bio, BIO_BOUNCED))
+	while (bio) {
+		mapped_bio = bio;
+		if (unlikely(bio_flagged(bio, BIO_BOUNCED)))
 			mapped_bio = bio->bi_private;
-		else
-			mapped_bio = bio;
 
 		__blk_rq_unmap_user(mapped_bio);
-		rq->bio = bio->bi_next;
-		bio_put(bio);
+		mapped_bio = bio;
+		bio = bio->bi_next;
+		bio_put(mapped_bio);
 	}
+
 	return 0;
 }
 
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f322b6a..2528a0c 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -333,8 +333,7 @@ static int sg_io(struct file *file, request_queue_t *q,
 			hdr->sb_len_wr = len;
 	}
 
-	rq->bio = bio;
-	if (blk_rq_unmap_user(rq))
+	if (blk_rq_unmap_user(bio))
 		ret = -EFAULT;
 
 	/* may not have succeeded, but output values written to control
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e4a2f8f..66d028d 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2139,8 +2139,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 			cdi->last_sense = s->sense_key;
 		}
 
-		rq->bio = bio;
-		if (blk_rq_unmap_user(rq))
+		if (blk_rq_unmap_user(bio))
 			ret = -EFAULT;
 
 		if (ret)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a801cc..d93f8ea 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -710,7 +710,7 @@ extern void __blk_stop_queue(request_queue_t *q);
 extern void blk_run_queue(request_queue_t *);
 extern void blk_start_queueing(request_queue_t *);
 extern int blk_rq_map_user(request_queue_t *, struct request *, void __user *, unsigned long);
-extern int blk_rq_unmap_user(struct request *);
+extern int blk_rq_unmap_user(struct bio *);
 extern int blk_rq_map_kern(request_queue_t *, struct request *, void *, unsigned int, gfp_t);
 extern int blk_rq_map_user_iov(request_queue_t *, struct request *,
 			       struct sg_iovec *, int, unsigned int);

-- 
Jens Axboe


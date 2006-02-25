Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWBYLUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWBYLUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWBYLUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:20:37 -0500
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:50417 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1030219AbWBYLUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:20:35 -0500
To: axboe@suse.de
Cc: michaelc@cs.wisc.edu, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] scsi tgt: add partial mappings support to
 bio_map_user
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20060216195917.GY4203@suse.de>
References: <1140119620.20193.51.camel@max>
	<20060216195917.GY4203@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20060225202016E.fujita.tomonori@lab.ntt.co.jp>
Date: Sat, 25 Feb 2006 20:20:16 +0900
X-Dispatcher: imput version 20040704(IM147)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cc'ed lkml for ide people.

From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 3/6] scsi tgt: add partial mappings support to bio_map_user
Date: Thu, 16 Feb 2006 20:59:17 +0100

> On Thu, Feb 16 2006, Mike Christie wrote:
> > Subject: [PATCH] block layer: add partial mappings support to bio_map_user
> > 
> > For target mode we could end up with the case where we get very large
> > request from the initiator. The request could be so large that we
> > cannot transfer all the data in one operation. For example the
> > HBA's segment or max_sector limits might limit us to a 1 MB transfer.
> > To send a 5 MB command then we need to transfer the command chunk by chunk.
> > 
> > To do this, tgt core will map in as much data as possible into a bio,
> > send this off, then when that transfer is completed we send off another
> > request/bio. To be able to pack as much data into a bio as possible
> > we need bio_map_user to support partially mapped bios. The attached patch
> > just adds a new argument to the those functions and if set will not
> > return a failure if the bio is partially mapped.
> 
> Drop the partial flag and just always allow it, fixing up the few
> in-kernel users we have.

Could you take a look at this patch?


- bio_map_user_iov always allows partial mappings.

- The two users (blk_rq_map_user and blk_rq_map_user_iov) will fails
if the bio is partially mapped.

- Added a length argument to blk_rq_map_user_iov in order to avoid
including sg.h in ll_rw_blk.c for struct sg_iovec.


Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

---

 block/ll_rw_blk.c      |   29 ++++++++++++++++++-----------
 block/scsi_ioctl.c     |    3 ++-
 fs/bio.c               |   14 +-------------
 include/linux/blkdev.h |    3 ++-
 4 files changed, 23 insertions(+), 26 deletions(-)

cd71b46a9cf86022631c1fed9123b01e07f337a3
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 03d9c82..6849859 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2291,19 +2291,20 @@ int blk_rq_map_user(request_queue_t *q, 
 	else
 		bio = bio_copy_user(q, uaddr, len, reading);
 
-	if (!IS_ERR(bio)) {
-		rq->bio = rq->biotail = bio;
-		blk_rq_bio_prep(q, rq, bio);
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
 
-		rq->buffer = rq->data = NULL;
-		rq->data_len = len;
-		return 0;
+	if (bio->bi_size != len) {
+		bio_endio(bio, bio->bi_size, 0);
+		bio_unmap_user(bio);
+		return -EINVAL;
 	}
 
-	/*
-	 * bio is the err-ptr
-	 */
-	return PTR_ERR(bio);
+	rq->bio = rq->biotail = bio;
+	blk_rq_bio_prep(q, rq, bio);
+	rq->buffer = rq->data = NULL;
+	rq->data_len = len;
+	return 0;
 }
 
 EXPORT_SYMBOL(blk_rq_map_user);
@@ -2329,7 +2330,7 @@ EXPORT_SYMBOL(blk_rq_map_user);
  *    unmapping.
  */
 int blk_rq_map_user_iov(request_queue_t *q, struct request *rq,
-			struct sg_iovec *iov, int iov_count)
+			struct sg_iovec *iov, int iov_count, unsigned int len)
 {
 	struct bio *bio;
 
@@ -2343,6 +2344,12 @@ int blk_rq_map_user_iov(request_queue_t 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
+	if (bio->bi_size != len) {
+		bio_endio(bio, bio->bi_size, 0);
+		bio_unmap_user(bio);
+		return -EINVAL;
+	}
+
 	rq->bio = rq->biotail = bio;
 	blk_rq_bio_prep(q, rq, bio);
 	rq->buffer = rq->data = NULL;
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 24f7af9..ef9900d 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -274,7 +274,8 @@ static int sg_io(struct file *file, requ
 			goto out;
 		}
 
-		ret = blk_rq_map_user_iov(q, rq, iov, hdr->iovec_count);
+		ret = blk_rq_map_user_iov(q, rq, iov, hdr->iovec_count,
+					  hdr->dxfer_len);
 		kfree(iov);
 	} else if (hdr->dxfer_len)
 		ret = blk_rq_map_user(q, rq, hdr->dxferp, hdr->dxfer_len);
diff --git a/fs/bio.c b/fs/bio.c
index 1f3bb50..f75c2f4 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -750,7 +750,6 @@ struct bio *bio_map_user_iov(request_que
 			     int write_to_vm)
 {
 	struct bio *bio;
-	int len = 0, i;
 
 	bio = __bio_map_user_iov(q, bdev, iov, iov_count, write_to_vm);
 
@@ -765,18 +764,7 @@ struct bio *bio_map_user_iov(request_que
 	 */
 	bio_get(bio);
 
-	for (i = 0; i < iov_count; i++)
-		len += iov[i].iov_len;
-
-	if (bio->bi_size == len)
-		return bio;
-
-	/*
-	 * don't support partial mappings
-	 */
-	bio_endio(bio, bio->bi_size, 0);
-	bio_unmap_user(bio);
-	return ERR_PTR(-EINVAL);
+	return bio;
 }
 
 static void __bio_unmap_user(struct bio *bio)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 860e7a4..619ef1d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -611,7 +611,8 @@ extern void blk_queue_activity_fn(reques
 extern int blk_rq_map_user(request_queue_t *, struct request *, void __user *, unsigned int);
 extern int blk_rq_unmap_user(struct bio *, unsigned int);
 extern int blk_rq_map_kern(request_queue_t *, struct request *, void *, unsigned int, gfp_t);
-extern int blk_rq_map_user_iov(request_queue_t *, struct request *, struct sg_iovec *, int);
+extern int blk_rq_map_user_iov(request_queue_t *, struct request *,
+			       struct sg_iovec *, int, unsigned int);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *,
 			  struct request *, int);
 extern void blk_execute_rq_nowait(request_queue_t *, struct gendisk *,
-- 
1.1.3

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTJaJxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTJaJxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:53:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:36233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263142AbTJaJxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:53:08 -0500
Date: Fri, 31 Oct 2003 01:55:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Slusky <sluskyb@paranoiacs.org>
Cc: jariruusu@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-Id: <20031031015500.44a94f88.akpm@osdl.org>
In-Reply-To: <20031031005246.GE12147@fukurou.paranoiacs.org>
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
	<3FA15506.B9B76A5D@users.sourceforge.net>
	<20031030133000.6a04febf.akpm@osdl.org>
	<20031031005246.GE12147@fukurou.paranoiacs.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Slusky <sluskyb@paranoiacs.org> wrote:
>
> On Thu, 30 Oct 2003 13:30:00 -0800, Andrew Morton wrote:
> > Ben, I confess that I'd forgotten about #1198.  I'll take a look at your
> > memory allocation fix - it seems to be unfortunately large, but we may need
> > to go that way.
> 
> The current memory allocation procedure really is inadequate. It worked
> ok up thru 2.4 because the loop device was used almost exclusively
> as a nifty hack to make an initrd or to double-check the ISO you just
> created.

mm..  Last time I looked the 2.4 loop driver is fairly robust from the
memory management point of view.

> Throw strong crypto into the mix and it becomes reasonable to
> have your laptop mount all its filesystems and swap off of loop devices.
> 
> > One question is: why do we go down a different code path for blockdevs
> > nowadays anyway?  The handoff to the loop thread seems to work OK for
> > file-backed loop, and providing a bmap() for blockdevs is easy enough?
> 
> The code path for file-backed loop handles one page at a time, as that's
> the limit of the FS interface.

I doubt if there's much of a difference really - both code paths involve a
single copy of the data.  The additional context switches are probably more
significant.


> Block-backed loop devices can throw
> huge bios at their backing device with one make_request. If we could
> get both working on the same code path, would that be worth hobbling
> block-backed loop?

Here's the patch; feel free to benchmark it.  It kills 200 lines of code
and unifies the block-backed and file-backed codepaths.  That surely is a
good thing.

It fixes bug 1198 too, it appears.


 drivers/block/loop.c |  205 +--------------------------------------------------
 fs/block_dev.c       |    0 
 include/linux/loop.h |    3 
 3 files changed, 6 insertions(+), 202 deletions(-)

diff -puN drivers/block/loop.c~loop-remove-blkdev-special-case drivers/block/loop.c
--- 25/drivers/block/loop.c~loop-remove-blkdev-special-case	2003-10-31 00:37:08.000000000 -0800
+++ 25-akpm/drivers/block/loop.c	2003-10-31 00:37:08.000000000 -0800
@@ -345,23 +345,6 @@ static int do_bio_filebacked(struct loop
 	return ret;
 }
 
-static int loop_end_io_transfer(struct bio *, unsigned int, int);
-
-static void loop_put_buffer(struct bio *bio)
-{
-	/*
-	 * check bi_end_io, may just be a remapped bio
-	 */
-	if (bio && bio->bi_end_io == loop_end_io_transfer) {
-		int i;
-
-		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
-
-		bio_put(bio);
-	}
-}
-
 /*
  * Add bio to back of pending list
  */
@@ -399,129 +382,8 @@ static struct bio *loop_get_bio(struct l
 	return bio;
 }
 
-/*
- * if this was a WRITE lo->transfer stuff has already been done. for READs,
- * queue it for the loop thread and let it do the transfer out of
- * bi_end_io context (we don't want to do decrypt of a page with irqs
- * disabled)
- */
-static int loop_end_io_transfer(struct bio *bio, unsigned int bytes_done, int err)
-{
-	struct bio *rbh = bio->bi_private;
-	struct loop_device *lo = rbh->bi_bdev->bd_disk->private_data;
-
-	if (bio->bi_size)
-		return 1;
-
-	if (err || bio_rw(bio) == WRITE) {
-		bio_endio(rbh, rbh->bi_size, err);
-		if (atomic_dec_and_test(&lo->lo_pending))
-			up(&lo->lo_bh_mutex);
-		loop_put_buffer(bio);
-	} else
-		loop_add_bio(lo, bio);
-
-	return 0;
-}
-
-static struct bio *loop_copy_bio(struct bio *rbh)
-{
-	struct bio *bio;
-	struct bio_vec *bv;
-	int i;
-
-	bio = bio_alloc(__GFP_NOWARN, rbh->bi_vcnt);
-	if (!bio)
-		return NULL;
-
-	/*
-	 * iterate iovec list and alloc pages
-	 */
-	__bio_for_each_segment(bv, rbh, i, 0) {
-		struct bio_vec *bbv = &bio->bi_io_vec[i];
-
-		bbv->bv_page = alloc_page(__GFP_NOWARN|__GFP_HIGHMEM);
-		if (bbv->bv_page == NULL)
-			goto oom;
-
-		bbv->bv_len = bv->bv_len;
-		bbv->bv_offset = bv->bv_offset;
-	}
-
-	bio->bi_vcnt = rbh->bi_vcnt;
-	bio->bi_size = rbh->bi_size;
-
-	return bio;
-
-oom:
-	while (--i >= 0)
-		__free_page(bio->bi_io_vec[i].bv_page);
-
-	bio_put(bio);
-	return NULL;
-}
-
-static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
-{
-	struct bio *bio;
-
-	/*
-	 * When called on the page reclaim -> writepage path, this code can
-	 * trivially consume all memory.  So we drop PF_MEMALLOC to avoid
-	 * stealing all the page reserves and throttle to the writeout rate.
-	 * pdflush will have been woken by page reclaim.  Let it do its work.
-	 */
-	do {
-		int flags = current->flags;
-
-		current->flags &= ~PF_MEMALLOC;
-		bio = loop_copy_bio(rbh);
-		if (flags & PF_MEMALLOC)
-			current->flags |= PF_MEMALLOC;
-
-		if (bio == NULL)
-			blk_congestion_wait(WRITE, HZ/10);
-	} while (bio == NULL);
-
-	bio->bi_end_io = loop_end_io_transfer;
-	bio->bi_private = rbh;
-	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
-	bio->bi_rw = rbh->bi_rw;
-	bio->bi_bdev = lo->lo_device;
-
-	return bio;
-}
-
-static int loop_transfer_bio(struct loop_device *lo,
-			     struct bio *to_bio, struct bio *from_bio)
-{
-	sector_t IV;
-	struct bio_vec *from_bvec, *to_bvec;
-	char *vto, *vfrom;
-	int ret = 0, i;
-
-	IV = from_bio->bi_sector + (lo->lo_offset >> 9);
-
-	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
-		to_bvec = &to_bio->bi_io_vec[i];
-
-		kmap(from_bvec->bv_page);
-		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
-		kunmap(from_bvec->bv_page);
-		kunmap(to_bvec->bv_page);
-		IV += from_bvec->bv_len >> 9;
-	}
-
-	return ret;
-}
-		
 static int loop_make_request(request_queue_t *q, struct bio *old_bio)
 {
-	struct bio *new_bio = NULL;
 	struct loop_device *lo = q->queuedata;
 	int rw = bio_rw(old_bio);
 
@@ -543,31 +405,11 @@ static int loop_make_request(request_que
 		printk(KERN_ERR "loop: unknown command (%x)\n", rw);
 		goto err;
 	}
-
-	/*
-	 * file backed, queue for loop_thread to handle
-	 */
-	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		loop_add_bio(lo, old_bio);
-		return 0;
-	}
-
-	/*
-	 * piggy old buffer on original, and submit for I/O
-	 */
-	new_bio = loop_get_buffer(lo, old_bio);
-	if (rw == WRITE) {
-		if (loop_transfer_bio(lo, new_bio, old_bio))
-			goto err;
-	}
-
-	generic_make_request(new_bio);
+	loop_add_bio(lo, old_bio);
 	return 0;
-
 err:
 	if (atomic_dec_and_test(&lo->lo_pending))
 		up(&lo->lo_bh_mutex);
-	loop_put_buffer(new_bio);
 out:
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
@@ -580,20 +422,8 @@ static inline void loop_handle_bio(struc
 {
 	int ret;
 
-	/*
-	 * For block backed loop, we know this is a READ
-	 */
-	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		ret = do_bio_filebacked(lo, bio);
-		bio_endio(bio, bio->bi_size, ret);
-	} else {
-		struct bio *rbh = bio->bi_private;
-
-		ret = loop_transfer_bio(lo, bio, rbh);
-
-		bio_endio(rbh, rbh->bi_size, ret);
-		loop_put_buffer(bio);
-	}
+	ret = do_bio_filebacked(lo, bio);
+	bio_endio(bio, bio->bi_size, ret);
 }
 
 /*
@@ -685,29 +515,19 @@ static int loop_set_fd(struct loop_devic
 
 	error = -EINVAL;
 
-	if (S_ISBLK(inode->i_mode)) {
-		lo_device = I_BDEV(inode);
-		if (lo_device == bdev) {
-			error = -EBUSY;
-			goto out;
-		}
-		lo_blocksize = block_size(lo_device);
-		if (bdev_read_only(lo_device))
-			lo_flags |= LO_FLAGS_READ_ONLY;
-	} else if (S_ISREG(inode->i_mode)) {
+	if (S_ISREG(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		struct address_space_operations *aops = mapping->a_ops;
 		/*
 		 * If we can't read - sorry. If we only can't write - well,
 		 * it's going to be read-only.
 		 */
-		if (!inode->i_fop->sendfile)
+		if (!lo_file->f_op->sendfile)
 			goto out_putf;
 
 		if (!aops->prepare_write || !aops->commit_write)
 			lo_flags |= LO_FLAGS_READ_ONLY;
 
 		lo_blocksize = inode->i_blksize;
-		lo_flags |= LO_FLAGS_DO_BMAP;
 		error = 0;
 	} else
 		goto out_putf;
@@ -744,21 +564,6 @@ static int loop_set_fd(struct loop_devic
 	 */
 	blk_queue_make_request(lo->lo_queue, loop_make_request);
 	lo->lo_queue->queuedata = lo;
-
-	/*
-	 * we remap to a block device, make sure we correctly stack limits
-	 */
-	if (S_ISBLK(inode->i_mode)) {
-		request_queue_t *q = bdev_get_queue(lo_device);
-
-		blk_queue_max_sectors(lo->lo_queue, q->max_sectors);
-		blk_queue_max_phys_segments(lo->lo_queue,q->max_phys_segments);
-		blk_queue_max_hw_segments(lo->lo_queue, q->max_hw_segments);
-		blk_queue_max_segment_size(lo->lo_queue, q->max_segment_size);
-		blk_queue_segment_boundary(lo->lo_queue, q->seg_boundary_mask);
-		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
-	}
-
 	kernel_thread(loop_thread, lo, CLONE_KERNEL);
 	down(&lo->lo_sem);
 
diff -puN fs/block_dev.c~loop-remove-blkdev-special-case fs/block_dev.c
diff -puN include/linux/loop.h~loop-remove-blkdev-special-case include/linux/loop.h
--- 25/include/linux/loop.h~loop-remove-blkdev-special-case	2003-10-31 00:37:08.000000000 -0800
+++ 25-akpm/include/linux/loop.h	2003-10-31 00:37:08.000000000 -0800
@@ -70,8 +70,7 @@ struct loop_device {
 /*
  * Loop flags
  */
-#define LO_FLAGS_DO_BMAP	1
-#define LO_FLAGS_READ_ONLY	2
+#define LO_FLAGS_READ_ONLY	1
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <asm/types.h>		/* for __u64 */

_


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbUKEHhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbUKEHhC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 02:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUKEHhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 02:37:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20673 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262622AbUKEHg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 02:36:27 -0500
Date: Fri, 5 Nov 2004 08:35:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Terry Kyriacopoulos <terryk@echo-on.net>
Cc: linux-kernel@vger.kernel.org, gadio@netvision.net.il, andre@linux-ide.org
Subject: Re: [PATCH] ide-scsi: DMA alignment bug fixed
Message-ID: <20041105073556.GE16649@suse.de>
References: <Pine.LNX.4.56.0411050042250.88@vk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0411050042250.88@vk.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05 2004, Terry Kyriacopoulos wrote:
> 
> It's about time somebody fixed this.  ide-scsi no longer reverts to PIO
> when the user buffers aren't 512-byte aligned, thanks to this patch.
> 
> [For brevity, only the patch to 2.6.8.1 (and 2.6.9) is quoted below,
>  although I made and tested patches to 2.4.27 and 2.2.26.  If interested,
>  let me know.]
> 
> DMA is done on a combination of the user buffers and bounce buffers as
> follows:
> 
> - If everything is aligned, no copying is done.
> - If only the length (of the last segment) is unaligned, only that partial
>   last block is copied.
> - In the remaining cases, everything from the first misaligned block onwards
>   is copied, but to minimize extra buffer allocation, any aligned space within
>   the user buffers is used for DMA.
> 
> The following changes were made to implement this:
> 
> - introduced the structure 'bounce' in 'idescsi_pc_t' to point to the
>   list of buffers to be copied.  Note the special meaning of NULL in the
>   field 'alloc': it means a section (or all of) a user buffer is being
>   used for DMA.  (kfree on 'alloc' is thus harmless on user buffers.)
> 
> - overhauled 'idescsi_dma_bio', the function that decides if DMA is
>   possible and that sets up the buffers.  The DMA table (rq->bio) is built
>   one entry at a time while checking the boundaries of the user sg table.
>   When this is done additional bounce buffers are kmalloc'ed to carry the
>   leftover data.
> 
> - added the function 'idescsi_bounce_dma' to do the copying.  Source and
>   destination may overlap, so the 'bounce' list is processed backwards
>   when writing.  Notice that source and destination blocks will
>   coincide for aligned cases, and thus will not require copying.
> 
> - added GPCMD_READ_CD and GPCMD_READ_CD_MSF to 'idescsi_set_direction'
>   from <linux/cdrom.h>  The command list may be incomplete.
> 
> - made a few cleanups:
> 	- properly intialized 'bh->bi_next' to NULL in
> 	  'idescsi_kmalloc_bio'
> 	- made some existing variables unsigned, to suppress warnings

I don't think this is the right way to go. The design of ide-scsi's dma
setup is based on the old buffer_heads, where you can only have a single
page at the time so you need to string them manually. We actually have
kernel helpers for mapping _user_ data to a request, we could add one
for mapping kernel data to a request as well.

Here's a patch that I did some time ago for mapping a kernel pointer to
a bio. bio_copy_user() would be good inspiration, too. Mapping an sglist
to a new bio should be even simpler and it would clean up the ide-scsi
stuff a lot. It's not exactly pretty.

--- linux-2.6.5/drivers/block/ll_rw_blk.c~	2004-10-20 11:50:54.251503944 +0200
+++ linux-2.6.5/drivers/block/ll_rw_blk.c	2004-10-20 11:56:33.191196072 +0200
@@ -1818,6 +1818,35 @@
 
 EXPORT_SYMBOL(blk_insert_request);
 
+struct request *blk_rq_map_data(request_queue_t *q, int rw, char *buf,
+				unsigned int len)
+{
+	struct request *rq;
+	struct bio *bio;
+
+	if (len > (q->max_sectors << 9))
+		return ERR_PTR(-EINVAL);
+	if ((!len && buf) || (len && !buf))
+		return ERR_PTR(-EINVAL);
+
+	rq = blk_get_request(q, rw, __GFP_WAIT);
+	if (!rq)
+		return ERR_PTR(-ENOMEM);
+
+	bio = bio_map_data(q, buf, len, rw == READ);
+	if (IS_ERR(bio)) {
+		blk_put_request(rq);
+		return (struct request *) bio;
+	}
+
+	rq->bio = rq->biotail = bio;
+	blk_rq_bio_prep(q, rq, bio);
+
+	rq->buffer = rq->data = NULL;
+	rq->data_len = len;
+	return rq;
+}
+
 /**
  * blk_rq_map_user - map user data to a request, for REQ_BLOCK_PC usage
  * @q:		request queue where request should be inserted
--- linux-2.6.5/fs/bio.c~	2004-10-20 11:18:39.949303783 +0200
+++ linux-2.6.5/fs/bio.c	2004-10-20 12:00:31.559750584 +0200
@@ -368,6 +368,59 @@
 			      len, offset);
 }
 
+static int bio_map_data_endio(struct bio *bio, unsigned int done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	bio_put(bio);
+	return 0;
+}
+
+struct bio *bio_map_data(request_queue_t *q, unsigned char *ptr,
+			 unsigned int len, int read)
+{
+
+	unsigned long data = (unsigned long) ptr;
+	unsigned long end = (data + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = data >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	unsigned int bytes, offset;
+	struct bio *bio;
+	struct page *page;
+	int i;
+
+	if (!len || !nr_pages)
+		return ERR_PTR(-EINVAL);
+	
+	bio = bio_alloc(GFP_KERNEL, nr_pages);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < nr_pages; i++) {
+		if (len <= 0)
+			break;
+
+		page = virt_to_page(ptr);
+		offset = offset_in_page(ptr);
+
+		bytes = PAGE_SIZE - offset;
+		if (bytes > len)
+			bytes = len;
+		
+		if (__bio_add_page(q, bio, page, bytes, offset) < bytes)
+			break;
+
+		len -= bytes;
+		offset = 0;
+		ptr += bytes;
+	}
+
+	bio->bi_end_io = bio_map_data_endio;
+	bio->bi_rw |= (!read << BIO_RW);
+	return bio;
+}
+
 struct bio_map_data {
 	struct bio_vec *iovecs;
 	void __user *userptr;
--- linux-2.6.5/include/linux/bio.h~	2004-10-20 11:50:10.597180596 +0200
+++ linux-2.6.5/include/linux/bio.h	2004-10-20 11:56:21.349459943 +0200
@@ -255,6 +255,7 @@
 extern void bio_check_pages_dirty(struct bio *bio);
 extern struct bio *bio_copy_user(struct request_queue *, unsigned long, unsigned int, int);
 extern int bio_uncopy_user(struct bio *);
+extern struct bio *bio_map_data(struct request_queue *, unsigned char *, unsigned int, int);
 
 #ifdef CONFIG_HIGHMEM
 /*
--- linux-2.6.5/include/linux/blkdev.h~	2004-10-20 11:56:46.407785439 +0200
+++ linux-2.6.5/include/linux/blkdev.h	2004-10-20 11:57:09.654304229 +0200
@@ -533,6 +533,7 @@
 extern void blk_run_queue(request_queue_t *);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
 extern struct request *blk_rq_map_user(request_queue_t *, int, void __user *, unsigned int);
+extern struct request *blk_rq_map_data(request_queue_t *, int, char *, unsigned int);
 extern int blk_rq_unmap_user(struct request *, struct bio *, unsigned int);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *, struct request *);
 



-- 
Jens Axboe


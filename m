Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSGEAYl>; Thu, 4 Jul 2002 20:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGDXra>; Thu, 4 Jul 2002 19:47:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43021 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315204AbSGDXqa>;
	Thu, 4 Jul 2002 19:46:30 -0400
Message-ID: <3D24E04D.E16225C0@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 19/27] suppress more allocation failure warnings
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The `page allocation failure' warning in __alloc_pages() is being a
pain.  But I'm persisting with it...

The patch renames PF_RADIX_TREE to PF_NOWARN, and uses it in a few
places where allocations failures are known to happen.  These code
paths are well-tested now and suppressing the warning is OK.



 drivers/scsi/scsi.c   |    2 ++
 fs/bio.c              |   13 +++++++++----
 fs/buffer.c           |    2 ++
 include/linux/sched.h |    2 +-
 mm/page_alloc.c       |    2 +-
 mm/vmscan.c           |    2 +-
 6 files changed, 16 insertions(+), 7 deletions(-)

--- 2.5.24/include/linux/sched.h~alloc-warnings	Thu Jul  4 16:17:27 2002
+++ 2.5.24-akpm/include/linux/sched.h	Thu Jul  4 16:17:27 2002
@@ -386,7 +386,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_FLUSHER	0x00004000	/* responsible for disk writeback */
-#define PF_RADIX_TREE	0x00008000	/* debug: performing radix tree alloc */
+#define PF_NOWARN	0x00008000	/* debug: don't warn if alloc fails */
 
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
--- 2.5.24/mm/page_alloc.c~alloc-warnings	Thu Jul  4 16:17:27 2002
+++ 2.5.24-akpm/mm/page_alloc.c	Thu Jul  4 16:22:04 2002
@@ -399,7 +399,7 @@ rebalance:
 				return page;
 		}
 nopage:
-		if (!(current->flags & PF_RADIX_TREE)) {
+		if (!(current->flags & PF_NOWARN)) {
 			printk("%s: page allocation failure."
 				" order:%d, mode:0x%x\n",
 				current->comm, order, gfp_mask);
--- 2.5.24/mm/vmscan.c~alloc-warnings	Thu Jul  4 16:17:27 2002
+++ 2.5.24-akpm/mm/vmscan.c	Thu Jul  4 16:17:27 2002
@@ -63,7 +63,7 @@ swap_out_add_to_swap_cache(struct page *
 	int ret;
 
 	current->flags &= ~PF_MEMALLOC;
-	current->flags |= PF_RADIX_TREE;
+	current->flags |= PF_NOWARN;
 	ClearPageUptodate(page);		/* why? */
 	ClearPageReferenced(page);		/* why? */
 	ret = add_to_swap_cache(page, entry);
--- 2.5.24/fs/bio.c~alloc-warnings	Thu Jul  4 16:17:27 2002
+++ 2.5.24-akpm/fs/bio.c	Thu Jul  4 16:17:27 2002
@@ -135,21 +135,26 @@ inline void bio_init(struct bio *bio)
  **/
 struct bio *bio_alloc(int gfp_mask, int nr_iovecs)
 {
-	struct bio *bio = mempool_alloc(bio_pool, gfp_mask);
+	struct bio *bio;
 	struct bio_vec *bvl = NULL;
 
+	current->flags |= PF_NOWARN;
+	bio = mempool_alloc(bio_pool, gfp_mask);
 	if (unlikely(!bio))
-		return NULL;
+		goto out;
 
 	if (!nr_iovecs || (bvl = bvec_alloc(gfp_mask,nr_iovecs,&bio->bi_max))) {
 		bio_init(bio);
 		bio->bi_destructor = bio_destructor;
 		bio->bi_io_vec = bvl;
-		return bio;
+		goto out;
 	}
 
 	mempool_free(bio, bio_pool);
-	return NULL;
+	bio = NULL;
+out:
+	current->flags &= ~PF_NOWARN;
+	return bio;
 }
 
 /**
--- 2.5.24/drivers/scsi/scsi.c~alloc-warnings	Thu Jul  4 16:17:27 2002
+++ 2.5.24-akpm/drivers/scsi/scsi.c	Thu Jul  4 16:17:27 2002
@@ -2481,7 +2481,9 @@ struct scatterlist *scsi_alloc_sgtable(S
 
 	sgp = scsi_sg_pools + SCpnt->sglist_len;
 
+	current->flags |= PF_NOWARN;
 	sgl = mempool_alloc(sgp->pool, gfp_mask);
+	current->flags &= ~PF_NOWARN;
 	if (sgl) {
 		memset(sgl, 0, sgp->size);
 		return sgl;
--- 2.5.24/fs/buffer.c~alloc-warnings	Thu Jul  4 16:17:27 2002
+++ 2.5.24-akpm/fs/buffer.c	Thu Jul  4 16:22:04 2002
@@ -965,7 +965,9 @@ try_again:
 	head = NULL;
 	offset = PAGE_SIZE;
 	while ((offset -= size) >= 0) {
+		current->flags |= PF_NOWARN;
 		bh = alloc_buffer_head();
+		current->flags &= ~PF_NOWARN;
 		if (!bh)
 			goto no_grow;
 

-

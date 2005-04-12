Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVDLNuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVDLNuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVDLMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:55:29 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:30039 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262329AbVDLMta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:49:30 -0400
Message-ID: <425BC3D2.3020909@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:49:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 3/9] no PF_MEMALLOC tinkering
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090204030208050909020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090204030208050909020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/9

-- 
SUSE Labs, Novell Inc.

--------------090204030208050909020808
Content-Type: text/plain;
 name="no-PF_MEMALLOC-tinkering.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-PF_MEMALLOC-tinkering.patch"

PF_MEMALLOC is really not a tool for tinkering. It is pretty specifically
used to prevent recursion into page reclaim, and to prevent low memory
deadlocks.

The mm/swap_state.c code was the only legitimate tinkerer. Its concern
was addressed by the previous patch.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c	2005-04-12 22:05:44.000000000 +1000
+++ linux-2.6/mm/swap_state.c	2005-04-12 22:26:12.000000000 +1000
@@ -143,7 +143,6 @@ void __delete_from_swap_cache(struct pag
 int add_to_swap(struct page * page)
 {
 	swp_entry_t entry;
-	int pf_flags;
 	int err;
 
 	if (!PageLocked(page))
@@ -154,30 +153,11 @@ int add_to_swap(struct page * page)
 		if (!entry.val)
 			return 0;
 
-		/* Radix-tree node allocations are performing
-		 * GFP_ATOMIC allocations under PF_MEMALLOC.  
-		 * They can completely exhaust the page allocator.  
-		 *
-		 * So PF_MEMALLOC is dropped here.  This causes the slab 
-		 * allocations to fail earlier, so radix-tree nodes will 
-		 * then be allocated from the mempool reserves.
-		 *
-		 * We're still using __GFP_HIGH for radix-tree node
-		 * allocations, so some of the emergency pools are available,
-		 * just not all of them.
-		 */
-
-		pf_flags = current->flags;
-		current->flags &= ~PF_MEMALLOC;
-
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
 		err = __add_to_swap_cache(page, entry, GFP_ATOMIC|__GFP_NOWARN);
 
-		if (pf_flags & PF_MEMALLOC)
-			current->flags |= PF_MEMALLOC;
-
 		switch (err) {
 		case 0:				/* Success */
 			SetPageUptodate(page);
Index: linux-2.6/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-crypt.c	2005-04-12 22:05:44.000000000 +1000
+++ linux-2.6/drivers/md/dm-crypt.c	2005-04-12 22:26:12.000000000 +1000
@@ -331,25 +331,14 @@ crypt_alloc_buffer(struct crypt_config *
 	struct bio *bio;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
-	unsigned long flags = current->flags;
 	unsigned int i;
 
-	/*
-	 * Tell VM to act less aggressively and fail earlier.
-	 * This is not necessary but increases throughput.
-	 * FIXME: Is this really intelligent?
-	 */
-	current->flags &= ~PF_MEMALLOC;
-
 	if (base_bio)
 		bio = bio_clone(base_bio, GFP_NOIO);
 	else
 		bio = bio_alloc(GFP_NOIO, nr_iovecs);
-	if (!bio) {
-		if (flags & PF_MEMALLOC)
-			current->flags |= PF_MEMALLOC;
+	if (!bio)
 		return NULL;
-	}
 
 	/* if the last bio was not complete, continue where that one ended */
 	bio->bi_idx = *bio_vec_idx;
@@ -386,9 +375,6 @@ crypt_alloc_buffer(struct crypt_config *
 		size -= bv->bv_len;
 	}
 
-	if (flags & PF_MEMALLOC)
-		current->flags |= PF_MEMALLOC;
-
 	if (!bio->bi_size) {
 		bio_put(bio);
 		return NULL;
Index: linux-2.6/fs/mpage.c
===================================================================
--- linux-2.6.orig/fs/mpage.c	2005-04-12 22:05:44.000000000 +1000
+++ linux-2.6/fs/mpage.c	2005-04-12 22:26:12.000000000 +1000
@@ -105,11 +105,6 @@ mpage_alloc(struct block_device *bdev,
 
 	bio = bio_alloc(gfp_flags, nr_vecs);
 
-	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
-		while (!bio && (nr_vecs /= 2))
-			bio = bio_alloc(gfp_flags, nr_vecs);
-	}
-
 	if (bio) {
 		bio->bi_bdev = bdev;
 		bio->bi_sector = first_sector;

--------------090204030208050909020808--


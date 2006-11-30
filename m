Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758531AbWK3HWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758531AbWK3HWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758523AbWK3HWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:22:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:45478 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758531AbWK3HWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:22:05 -0500
Date: Thu, 30 Nov 2006 08:22:02 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: [patch 2/3] mm: pagecache write deadlocks stale holes fix
Message-ID: <20061130072202.GB18004@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130072058.GA18004@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the data copy within a prepare_write can potentially allocate blocks
to fill holes, so if the page copy fails then new blocks must be zeroed
so uninitialised data cannot be exposed with a subsequent read.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1951,7 +1951,14 @@ retry_noprogress:
 						bytes);
 		dec_preempt_count();
 
-		if (!PageUptodate(page)) {
+		if (unlikely(copied != bytes)) {
+			/*
+			 * Must zero out new buffers here so that we do end
+			 * up properly filling holes rather than leaving stale
+			 * data in them that might be read in future.
+			 */
+			page_zero_new_buffers(page);
+
 			/*
 			 * If the page is not uptodate, we cannot allow a
 			 * partial commit_write because when we unlock the
@@ -1965,10 +1972,10 @@ retry_noprogress:
 			 * Abort the operation entirely with a zero length
 			 * commit_write. Retry.  We will enter the
 			 * single-segment path below, which should get the
-			 * filesystem to bring the page uputodate for us next
+			 * filesystem to bring the page uptodate for us next
 			 * time.
 			 */
-			if (unlikely(copied != bytes))
+			if (!PageUptodate(page))
 				copied = 0;
 		}
 
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1491,6 +1491,39 @@ out:
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
+void page_zero_new_buffers(struct page *page)
+{
+	unsigned int block_start, block_end;
+	struct buffer_head *head, *bh;
+
+	BUG_ON(!PageLocked(page));
+	if (!page_has_buffers(page))
+		return;
+
+	bh = head = page_buffers(page);
+	block_start = 0;
+	do {
+		block_end = block_start + bh->b_size;
+
+		if (buffer_new(bh)) {
+			void *kaddr;
+
+			if (!PageUptodate(page)) {
+				kaddr = kmap_atomic(page, KM_USER0);
+				memset(kaddr+block_start, 0, bh->b_size);
+				flush_dcache_page(page);
+				kunmap_atomic(kaddr, KM_USER0);
+			}
+			clear_buffer_new(bh);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+		}
+
+		block_start = block_end;
+		bh = bh->b_this_page;
+	} while (bh != head);
+}
+
 /*
  * We attach and possibly dirty the buffers atomically wrt
  * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
@@ -1784,36 +1817,33 @@ static int __block_prepare_write(struct 
 			}
 			continue;
 		}
-		if (buffer_new(bh))
-			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
-			if (buffer_new(bh)) {
-				unmap_underlying_metadata(bh->b_bdev,
-							bh->b_blocknr);
-				if (PageUptodate(page)) {
-					set_buffer_uptodate(bh);
-					continue;
-				}
-				if (block_end > to || block_start < from) {
-					void *kaddr;
-
-					kaddr = kmap_atomic(page, KM_USER0);
-					if (block_end > to)
-						memset(kaddr+to, 0,
-							block_end-to);
-					if (block_start < from)
-						memset(kaddr+block_start,
-							0, from-block_start);
-					flush_dcache_page(page);
-					kunmap_atomic(kaddr, KM_USER0);
-				}
+		}
+		if (buffer_new(bh)) {
+			unmap_underlying_metadata(bh->b_bdev, bh->b_blocknr);
+			if (PageUptodate(page)) {
+				set_buffer_uptodate(bh);
 				continue;
 			}
+			if (block_end > to || block_start < from) {
+				void *kaddr;
+
+				kaddr = kmap_atomic(page, KM_USER0);
+				if (block_end > to)
+					memset(kaddr+to, 0, block_end-to);
+				if (block_start < from)
+					memset(kaddr+block_start,
+							0, from-block_start);
+				flush_dcache_page(page);
+				kunmap_atomic(kaddr, KM_USER0);
+			}
+			continue;
 		}
+
 		if (PageUptodate(page)) {
 			if (!buffer_uptodate(bh))
 				set_buffer_uptodate(bh);
@@ -1833,43 +1863,10 @@ static int __block_prepare_write(struct 
 		if (!buffer_uptodate(*wait_bh))
 			err = -EIO;
 	}
-	if (!err) {
-		bh = head;
-		do {
-			if (buffer_new(bh))
-				clear_buffer_new(bh);
-		} while ((bh = bh->b_this_page) != head);
-		return 0;
-	}
-	/* Error case: */
-	/*
-	 * Zero out any newly allocated blocks to avoid exposing stale
-	 * data.  If BH_New is set, we know that the block was newly
-	 * allocated in the above loop.
-	 */
-	bh = head;
-	block_start = 0;
-	do {
-		block_end = block_start+blocksize;
-		if (block_end <= from)
-			goto next_bh;
-		if (block_start >= to)
-			break;
-		if (buffer_new(bh)) {
-			void *kaddr;
 
-			clear_buffer_new(bh);
-			kaddr = kmap_atomic(page, KM_USER0);
-			memset(kaddr+block_start, 0, bh->b_size);
-			flush_dcache_page(page);
-			kunmap_atomic(kaddr, KM_USER0);
-			set_buffer_uptodate(bh);
-			mark_buffer_dirty(bh);
-		}
-next_bh:
-		block_start = block_end;
-		bh = bh->b_this_page;
-	} while (bh != head);
+	if (err)
+		page_zero_new_buffers(page);
+
 	return err;
 }
 
@@ -2246,7 +2243,6 @@ int nobh_prepare_write(struct page *page
 	int i;
 	int ret = 0;
 	int is_mapped_to_disk = 1;
-	int dirtied_it = 0;
 
 	if (PageMappedToDisk(page))
 		return 0;
@@ -2282,15 +2278,16 @@ int nobh_prepare_write(struct page *page
 		if (PageUptodate(page))
 			continue;
 		if (buffer_new(&map_bh) || !buffer_mapped(&map_bh)) {
+			/*
+			 * XXX: stale data can be exposed as we are not zeroing
+			 * out newly allocated blocks. If a subsequent operation
+			 * fails, we'll never know about this :(
+			 */
 			kaddr = kmap_atomic(page, KM_USER0);
-			if (block_start < from) {
-				memset(kaddr+block_start, 0, from-block_start);
-				dirtied_it = 1;
-			}
-			if (block_end > to) {
+			if (block_start < from)
+				memset(kaddr+block_start, 0, block_end-block_start);
+			if (block_end > to)
 				memset(kaddr + to, 0, block_end - to);
-				dirtied_it = 1;
-			}
 			flush_dcache_page(page);
 			kunmap_atomic(kaddr, KM_USER0);
 			continue;
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -151,6 +151,7 @@ struct buffer_head *alloc_page_buffers(s
 		int retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
+void page_zero_new_buffers(struct page *page);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -206,7 +206,7 @@ static inline int fault_in_pages_writeab
 	 * the zero gets there, we'll be overwriting it.
 	 */
 	ret = __put_user(0, uaddr);
-	if (ret == 0) {
+	if (likely(ret == 0)) {
 		char __user *end = uaddr + size - 1;
 
 		/*
@@ -229,7 +229,7 @@ static inline int fault_in_pages_readabl
 		return 0;
 
 	ret = __get_user(c, uaddr);
-	if (ret == 0) {
+	if (likely(ret == 0)) {
 		const char __user *end = uaddr + size - 1;
 
 		if (((unsigned long)uaddr & PAGE_MASK) !=

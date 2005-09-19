Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVISJcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVISJcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVISJcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:32:46 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:17851 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932403AbVISJcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:32:45 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 19 Sep 2005 10:32:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [3/3] NTFS: Fix ntfs_{read,write}page() to cope with concurrent
 truncates better.
In-Reply-To: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509191031580.19497@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix ntfs_{read,write}page() to cope with concurrent truncates better.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/aops.c   |  110 ++++++++++++++++++++++++++++++++++++------------------
 fs/ntfs/inode.c  |    9 ++--
 fs/ntfs/malloc.h |    2 -
 3 files changed, 80 insertions(+), 41 deletions(-)

f6098cf449b81c14a51e48dd22ae47d03126a1de
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -59,39 +59,49 @@ static void ntfs_end_buffer_async_read(s
 	unsigned long flags;
 	struct buffer_head *first, *tmp;
 	struct page *page;
+	struct inode *vi;
 	ntfs_inode *ni;
 	int page_uptodate = 1;
 
 	page = bh->b_page;
-	ni = NTFS_I(page->mapping->host);
+	vi = page->mapping->host;
+	ni = NTFS_I(vi);
 
 	if (likely(uptodate)) {
-		s64 file_ofs, initialized_size;
+		loff_t i_size;
+		s64 file_ofs, init_size;
 
 		set_buffer_uptodate(bh);
 
 		file_ofs = ((s64)page->index << PAGE_CACHE_SHIFT) +
 				bh_offset(bh);
 		read_lock_irqsave(&ni->size_lock, flags);
-		initialized_size = ni->initialized_size;
+		init_size = ni->initialized_size;
+		i_size = i_size_read(vi);
 		read_unlock_irqrestore(&ni->size_lock, flags);
+		if (unlikely(init_size > i_size)) {
+			/* Race with shrinking truncate. */
+			init_size = i_size;
+		}
 		/* Check for the current buffer head overflowing. */
-		if (file_ofs + bh->b_size > initialized_size) {
-			char *addr;
-			int ofs = 0;
-
-			if (file_ofs < initialized_size)
-				ofs = initialized_size - file_ofs;
-			addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
-			memset(addr + bh_offset(bh) + ofs, 0, bh->b_size - ofs);
+		if (unlikely(file_ofs + bh->b_size > init_size)) {
+			u8 *kaddr;
+			int ofs;
+
+			ofs = 0;
+			if (file_ofs < init_size)
+				ofs = init_size - file_ofs;
+			kaddr = kmap_atomic(page, KM_BIO_SRC_IRQ);
+			memset(kaddr + bh_offset(bh) + ofs, 0,
+					bh->b_size - ofs);
+			kunmap_atomic(kaddr, KM_BIO_SRC_IRQ);
 			flush_dcache_page(page);
-			kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		}
 	} else {
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
-		ntfs_error(ni->vol->sb, "Buffer I/O error, logical block %llu.",
-				(unsigned long long)bh->b_blocknr);
+		ntfs_error(ni->vol->sb, "Buffer I/O error, logical block "
+				"0x%llx.", (unsigned long long)bh->b_blocknr);
 	}
 	first = page_buffers(page);
 	local_irq_save(flags);
@@ -124,7 +134,7 @@ static void ntfs_end_buffer_async_read(s
 		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
 	} else {
-		char *addr;
+		u8 *kaddr;
 		unsigned int i, recs;
 		u32 rec_size;
 
@@ -132,12 +142,12 @@ static void ntfs_end_buffer_async_read(s
 		recs = PAGE_CACHE_SIZE / rec_size;
 		/* Should have been verified before we got here... */
 		BUG_ON(!recs);
-		addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
+		kaddr = kmap_atomic(page, KM_BIO_SRC_IRQ);
 		for (i = 0; i < recs; i++)
-			post_read_mst_fixup((NTFS_RECORD*)(addr +
+			post_read_mst_fixup((NTFS_RECORD*)(kaddr +
 					i * rec_size), rec_size);
+		kunmap_atomic(kaddr, KM_BIO_SRC_IRQ);
 		flush_dcache_page(page);
-		kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
 	}
@@ -168,8 +178,11 @@ still_busy:
  */
 static int ntfs_read_block(struct page *page)
 {
+	loff_t i_size;
 	VCN vcn;
 	LCN lcn;
+	s64 init_size;
+	struct inode *vi;
 	ntfs_inode *ni;
 	ntfs_volume *vol;
 	runlist_element *rl;
@@ -180,7 +193,8 @@ static int ntfs_read_block(struct page *
 	int i, nr;
 	unsigned char blocksize_bits;
 
-	ni = NTFS_I(page->mapping->host);
+	vi = page->mapping->host;
+	ni = NTFS_I(vi);
 	vol = ni->vol;
 
 	/* $MFT/$DATA must have its complete runlist in memory at all times. */
@@ -199,11 +213,28 @@ static int ntfs_read_block(struct page *
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
 
+	/*
+	 * We may be racing with truncate.  To avoid some of the problems we
+	 * now take a snapshot of the various sizes and use those for the whole
+	 * of the function.  In case of an extending truncate it just means we
+	 * may leave some buffers unmapped which are now allocated.  This is
+	 * not a problem since these buffers will just get mapped when a write
+	 * occurs.  In case of a shrinking truncate, we will detect this later
+	 * on due to the runlist being incomplete and if the page is being
+	 * fully truncated, truncate will throw it away as soon as we unlock
+	 * it so no need to worry what we do with it.
+	 */
 	iblock = (s64)page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
 	read_lock_irqsave(&ni->size_lock, flags);
 	lblock = (ni->allocated_size + blocksize - 1) >> blocksize_bits;
-	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
+	init_size = ni->initialized_size;
+	i_size = i_size_read(vi);
 	read_unlock_irqrestore(&ni->size_lock, flags);
+	if (unlikely(init_size > i_size)) {
+		/* Race with shrinking truncate. */
+		init_size = i_size;
+	}
+	zblock = (init_size + blocksize - 1) >> blocksize_bits;
 
 	/* Loop through all the buffers in the page. */
 	rl = NULL;
@@ -366,6 +397,8 @@ handle_zblock:
  */
 static int ntfs_readpage(struct file *file, struct page *page)
 {
+	loff_t i_size;
+	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
 	u8 *kaddr;
 	ntfs_attr_search_ctx *ctx;
@@ -384,7 +417,8 @@ retry_readpage:
 		unlock_page(page);
 		return 0;
 	}
-	ni = NTFS_I(page->mapping->host);
+	vi = page->mapping->host;
+	ni = NTFS_I(vi);
 	/*
 	 * Only $DATA attributes can be encrypted and only unnamed $DATA
 	 * attributes can be compressed.  Index root can have the flags set but
@@ -458,7 +492,12 @@ retry_readpage:
 	read_lock_irqsave(&ni->size_lock, flags);
 	if (unlikely(attr_len > ni->initialized_size))
 		attr_len = ni->initialized_size;
+	i_size = i_size_read(vi);
 	read_unlock_irqrestore(&ni->size_lock, flags);
+	if (unlikely(attr_len > i_size)) {
+		/* Race with shrinking truncate. */
+		attr_len = i_size;
+	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	/* Copy the data to the page. */
 	memcpy(kaddr, (u8*)ctx->attr +
@@ -1383,8 +1422,8 @@ retry_writepage:
 			unsigned int ofs = i_size & ~PAGE_CACHE_MASK;
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + ofs, 0, PAGE_CACHE_SIZE - ofs);
-			flush_dcache_page(page);
 			kunmap_atomic(kaddr, KM_USER0);
+			flush_dcache_page(page);
 		}
 		/* Handle mst protected attributes. */
 		if (NInoMstProtected(ni))
@@ -1447,34 +1486,33 @@ retry_writepage:
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
-	/*
-	 * Here, we do not need to zero the out of bounds area everytime
-	 * because the below memcpy() already takes care of the
-	 * mmap-at-end-of-file requirements.  If the file is converted to a
-	 * non-resident one, then the code path use is switched to the
-	 * non-resident one where the zeroing happens on each ntfs_writepage()
-	 * invocation.
-	 */
 	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
 	i_size = i_size_read(vi);
 	if (unlikely(attr_len > i_size)) {
+		/* Race with shrinking truncate or a failed truncate. */
 		attr_len = i_size;
-		ctx->attr->data.resident.value_length = cpu_to_le32(attr_len);
+		/*
+		 * If the truncate failed, fix it up now.  If a concurrent
+		 * truncate, we do its job, so it does not have to do anything.
+		 */
+		err = ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr,
+				attr_len);
+		/* Shrinking cannot fail. */
+		BUG_ON(err);
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	/* Copy the data from the page to the mft record. */
 	memcpy((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset),
 			kaddr, attr_len);
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	/* Zero out of bounds area in the page cache page. */
 	memset(kaddr + attr_len, 0, PAGE_CACHE_SIZE - attr_len);
-	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
-
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
+	flush_dcache_page(page);
+	/* We are done with the page. */
 	end_page_writeback(page);
-
-	/* Mark the mft record dirty, so it gets written back. */
+	/* Finally, mark the mft record dirty, so it gets written back. */
 	mark_mft_record_dirty(ctx->ntfs_ino);
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1166,6 +1166,8 @@ err_out:
  *
  * Return 0 on success and -errno on error.  In the error case, the inode will
  * have had make_bad_inode() executed on it.
+ *
+ * Note this cannot be called for AT_INDEX_ALLOCATION.
  */
 static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 {
@@ -1242,8 +1244,8 @@ static int ntfs_read_locked_attr_inode(s
 			}
 		}
 		/*
-		 * The encryption flag set in an index root just means to
-		 * compress all files.
+		 * The compressed/sparse flag set in an index root just means
+		 * to compress all files.
 		 */
 		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
 			ntfs_error(vi->i_sb, "Found mst protected attribute "
@@ -1319,8 +1321,7 @@ static int ntfs_read_locked_attr_inode(s
 					"the mapping pairs array.");
 			goto unm_err_out;
 		}
-		if ((NInoCompressed(ni) || NInoSparse(ni)) &&
-				ni->type != AT_INDEX_ROOT) {
+		if (NInoCompressed(ni) || NInoSparse(ni)) {
 			if (a->data.non_resident.compression_unit != 4) {
 				ntfs_error(vi->i_sb, "Found nonstandard "
 						"compression unit (%u instead "
diff --git a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
--- a/fs/ntfs/malloc.h
+++ b/fs/ntfs/malloc.h
@@ -1,7 +1,7 @@
 /*
  * malloc.h - NTFS kernel memory handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2001-2005 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published

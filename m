Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936550AbWLBH2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936550AbWLBH2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936545AbWLBH2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 02:28:37 -0500
Received: from cantor.suse.de ([195.135.220.2]:34526 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S936476AbWLBH2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 02:28:35 -0500
Date: Sat, 2 Dec 2006 08:28:22 +0100
From: Nick Piggin <npiggin@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: [new patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061202072822.GA5911@wotan.suse.de>
References: <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp> <20061201020910.GC455@wotan.suse.de> <87mz68xoyi.fsf@duaron.myhome.or.jp> <20061201050852.GA31347@wotan.suse.de> <20061130232102.0cc7fc0b.akpm@osdl.org> <20061201075341.GB31347@wotan.suse.de> <87slfzu0ty.fsf@duaron.myhome.or.jp> <4570CA90.8050203@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4570CA90.8050203@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see. I guess you need to synchronise your writepage versus this
> extention in order to handle it properly then. I won't bother with
> that though: it won't be worse than it was before.
> 
> Thanks for review, do you agree with the other hunks?

Well, Andrew's got the rest of the patches in his tree, so I'll send
what we've got for now. Has had some testing on both reiserfs and
fat. Doesn't look like the other filesystems using cont_prepare_write
will have any problems...

Andrew, please apply this patch as a replacement for the fat-fix
patch in your rollup (this patch includes the same fix, and is a
more logical change unit I think).
--

Stop overloading zero length prepare/commit_write to request a
file extend operation by the "cont" buffer code. Instead, have
generic_cont_expand perform a zeroing operation on the last
page, and cont_prepare_write naturally zeroes any previous
pages required.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Reiserfs was trying to "extend" a file to something smaller than
it already is with generic_cont_expand. This broke the above fix.
Open code the prepare/ commit pair instead... maybe the code would
be cleaner if reiserfs just did the operation explicitly (call
get_block or whatever helper is used to unpack the tail)?

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -2004,18 +2004,24 @@ int block_read_full_page(struct page *pa
 	return 0;
 }
 
-/* utility function for filesystems that need to do work on expanding
+/*
+ * utility function for filesystems that need to do work on expanding
  * truncates.  Uses prepare/commit_write to allow the filesystem to
  * deal with the hole.  
  */
-static int __generic_cont_expand(struct inode *inode, loff_t size,
-				 pgoff_t index, unsigned int offset)
+int generic_cont_expand(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
+	loff_t pos = inode->i_size;
 	struct page *page;
 	unsigned long limit;
+	pgoff_t index;
+	unsigned int from, to;
+	void *kaddr;
 	int err;
 
+	WARN_ON(pos >= size);
+
 	err = -EFBIG;
         limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
@@ -2025,11 +2031,18 @@ static int __generic_cont_expand(struct 
 	if (size > inode->i_sb->s_maxbytes)
 		goto out;
 
+	index = (size - 1) >> PAGE_CACHE_SHIFT;
+	to = size - ((loff_t)index << PAGE_CACHE_SHIFT);
+	if (index != (pos >> PAGE_CACHE_SHIFT))
+		from = 0;
+	else
+		from = pos & (PAGE_CACHE_SIZE - 1);
+
 	err = -ENOMEM;
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		goto out;
-	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
+	err = mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err) {
 		/*
 		 * ->prepare_write() may have instantiated a few blocks
@@ -2041,7 +2054,12 @@ static int __generic_cont_expand(struct 
 		goto out;
 	}
 
-	err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + from, 0, to - from);
+	flush_dcache_page(page);
+	kunmap_atomic(kaddr, KM_USER0);
+
+	err = mapping->a_ops->commit_write(NULL, page, from, to);
 
 	unlock_page(page);
 	page_cache_release(page);
@@ -2051,36 +2069,6 @@ out:
 	return err;
 }
 
-int generic_cont_expand(struct inode *inode, loff_t size)
-{
-	pgoff_t index;
-	unsigned int offset;
-
-	offset = (size & (PAGE_CACHE_SIZE - 1)); /* Within page */
-
-	/* ugh.  in prepare/commit_write, if from==to==start of block, we
-	** skip the prepare.  make sure we never send an offset for the start
-	** of a block
-	*/
-	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
-		/* caller must handle this extra byte. */
-		offset++;
-	}
-	index = size >> PAGE_CACHE_SHIFT;
-
-	return __generic_cont_expand(inode, size, index, offset);
-}
-
-int generic_cont_expand_simple(struct inode *inode, loff_t size)
-{
-	loff_t pos = size - 1;
-	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
-	unsigned int offset = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
-
-	/* prepare/commit_write can handle even if from==to==start of block. */
-	return __generic_cont_expand(inode, size, index, offset);
-}
-
 /*
  * For moronic filesystems that do not allow holes in file.
  * We may have to extend the file.
@@ -3015,7 +3003,6 @@ EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(generic_cont_expand);
-EXPORT_SYMBOL(generic_cont_expand_simple);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(invalidate_bdev);
 EXPORT_SYMBOL(ll_rw_block);
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -203,7 +203,6 @@ int block_prepare_write(struct page*, un
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				loff_t *);
 int generic_cont_expand(struct inode *inode, loff_t size);
-int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 void block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
Index: linux-2.6/fs/fat/file.c
===================================================================
--- linux-2.6.orig/fs/fat/file.c
+++ linux-2.6/fs/fat/file.c
@@ -143,7 +143,7 @@ static int fat_cont_expand(struct inode 
 	loff_t start = inode->i_size, count = size - inode->i_size;
 	int err;
 
-	err = generic_cont_expand_simple(inode, size);
+	err = generic_cont_expand(inode, size);
 	if (err)
 		goto out;
 
Index: linux-2.6/fs/fat/inode.c
===================================================================
--- linux-2.6.orig/fs/fat/inode.c
+++ linux-2.6/fs/fat/inode.c
@@ -151,7 +151,8 @@ static int fat_commit_write(struct file 
 {
 	struct inode *inode = page->mapping->host;
 	int err;
-	if (to - from > 0)
+
+	if (to - from == 0)
 		return 0;
 
 	err = generic_commit_write(file, page, from, to);
Index: linux-2.6/fs/reiserfs/file.c
===================================================================
--- linux-2.6.orig/fs/reiserfs/file.c
+++ linux-2.6/fs/reiserfs/file.c
@@ -892,6 +892,37 @@ static int reiserfs_submit_file_region_f
 	return retval;
 }
 
+/* To not overcomplicate matters, we just call prepare/commit_wrie
+   which will in turn call other stuff and finally will boil down to
+   reiserfs_get_block() that would do necessary conversion. */
+static int reiserfs_convert_tail(struct inode *inode, loff_t offset)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t index;
+	struct page *page;
+	int err = -ENOMEM;
+
+	index = offset >> PAGE_CACHE_SHIFT;
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		goto out;
+
+	offset = offset & ~PAGE_CACHE_MASK;
+	WARN_ON(!offset); /* shouldn't pass zero length to prepare/commit */
+
+	err = mapping->a_ops->prepare_write(NULL, page, 0, offset);
+	if (err)
+		goto out_unlock;
+
+	err = mapping->a_ops->commit_write(NULL, page, 0, offset);
+
+out_unlock:
+	unlock_page(page);
+	page_cache_release(page);
+out:
+	return err;
+}
+
 /* Look if passed writing region is going to touch file's tail
    (if it is present). And if it is, convert the tail to unformatted node */
 static int reiserfs_check_for_tail_and_convert(struct inode *inode,	/* inode to deal with */
@@ -930,14 +961,12 @@ static int reiserfs_check_for_tail_and_c
 	if (is_direct_le_ih(ih)) {
 		/* Ok, closest item is file tail (tails are stored in "direct"
 		 * items), so we need to unpack it. */
-		/* To not overcomplicate matters, we just call generic_cont_expand
-		   which will in turn call other stuff and finally will boil down to
-		   reiserfs_get_block() that would do necessary conversion. */
 		cont_expand_offset =
 		    le_key_k_offset(get_inode_item_key_version(inode),
 				    &(ih->ih_key));
 		pathrelse(&path);
-		res = generic_cont_expand(inode, cont_expand_offset);
+
+		res = reiserfs_convert_tail(inode, cont_expand_offset);
 	} else
 		pathrelse(&path);
 

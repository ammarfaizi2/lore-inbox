Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759255AbWK3Lcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255AbWK3Lcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759257AbWK3Lcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:32:46 -0500
Received: from ns2.suse.de ([195.135.220.15]:47064 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1759255AbWK3Lco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:32:44 -0500
Date: Thu, 30 Nov 2006 12:32:42 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061130113241.GC12579@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130072247.GC18004@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, missed a hunk which prevented fat from linking :(

---

Rework the cont filesystem helpers so that generic_cont_expand does the
actual work of expanding the file. cont_prepare_write then calls this
routine if expanding is needed, and retries. Also solves the problem
where cont_prepare_write would previously hold the target page locked
while doing not-very-nice things like locking other pages.

Means that zero-length prepare/commit_write pairs are no longer needed
as an overloaded directive to extend the file, thus cont should operate
better within the new deadlock-free buffered write code.

Converts fat over to the new cont scheme.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -2004,19 +2004,20 @@ int block_read_full_page(struct page *pa
 	return 0;
 }
 
-/* utility function for filesystems that need to do work on expanding
- * truncates.  Uses prepare/commit_write to allow the filesystem to
- * deal with the hole.  
+/*
+ * Utility function for filesystems that need to do work on expanding
+ * truncates. For moronic filesystems that do not allow holes in file.
  */
-static int __generic_cont_expand(struct inode *inode, loff_t size,
-				 pgoff_t index, unsigned int offset)
+int generic_cont_expand(struct inode *inode, loff_t size, loff_t *bytes,
+						get_block_t *get_block)
 {
 	struct address_space *mapping = inode->i_mapping;
+	unsigned long blocksize = 1 << inode->i_blkbits;
 	struct page *page;
 	unsigned long limit;
-	int err;
+	int status;
 
-	err = -EFBIG;
+	status = -EFBIG;
         limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
 		send_sig(SIGXFSZ, current, 0);
@@ -2025,146 +2026,83 @@ static int __generic_cont_expand(struct 
 	if (size > inode->i_sb->s_maxbytes)
 		goto out;
 
-	err = -ENOMEM;
-	page = grab_cache_page(mapping, index);
-	if (!page)
-		goto out;
-	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
-	if (err) {
-		/*
-		 * ->prepare_write() may have instantiated a few blocks
-		 * outside i_size.  Trim these off again.
-		 */
-		unlock_page(page);
-		page_cache_release(page);
-		vmtruncate(inode, inode->i_size);
-		goto out;
-	}
+	status = 0;
 
-	err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+	while (*bytes < size) {
+		unsigned int zerofrom;
+		unsigned int zeroto;
+		void *kaddr;
+		pgoff_t pgpos;
+
+		pgpos = *bytes >> PAGE_CACHE_SHIFT;
+		page = grab_cache_page(mapping, pgpos);
+		if (!page) {
+			status = -ENOMEM;
+			break;
+		}
+		/* we might sleep */
+		if (*bytes >> PAGE_CACHE_SHIFT != pgpos)
+			goto unlock;
 
-	unlock_page(page);
-	page_cache_release(page);
-	if (err > 0)
-		err = 0;
-out:
-	return err;
-}
+		zerofrom = *bytes & ~PAGE_CACHE_MASK;
+		if (zerofrom & (blocksize-1))
+			*bytes = (*bytes + blocksize-1) & (blocksize-1);
 
-int generic_cont_expand(struct inode *inode, loff_t size)
-{
-	pgoff_t index;
-	unsigned int offset;
+		zeroto = PAGE_CACHE_SIZE;
 
-	offset = (size & (PAGE_CACHE_SIZE - 1)); /* Within page */
+		status = __block_prepare_write(inode, page, zerofrom,
+						zeroto, get_block);
+		if (status)
+			goto unlock;
+		kaddr = kmap_atomic(page, KM_USER0);
+		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+		status = __block_commit_write(inode, page, zerofrom, zeroto);
 
-	/* ugh.  in prepare/commit_write, if from==to==start of block, we
-	** skip the prepare.  make sure we never send an offset for the start
-	** of a block
-	*/
-	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
-		/* caller must handle this extra byte. */
-		offset++;
+unlock:
+		unlock_page(page);
+		page_cache_release(page);
+		if (status) {
+			BUG_ON(status == AOP_TRUNCATED_PAGE);
+			break;
+		}
 	}
-	index = size >> PAGE_CACHE_SHIFT;
 
-	return __generic_cont_expand(inode, size, index, offset);
-}
-
-int generic_cont_expand_simple(struct inode *inode, loff_t size)
-{
-	loff_t pos = size - 1;
-	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
-	unsigned int offset = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
+	/*
+	 * No need to use i_size_read() here, the i_size
+	 * cannot change under us because we hold i_mutex.
+	 */
+	if (size > inode->i_size) {
+		i_size_write(inode, size);
+		mark_inode_dirty(inode);
+	}
 
-	/* prepare/commit_write can handle even if from==to==start of block. */
-	return __generic_cont_expand(inode, size, index, offset);
+out:
+	return status;
 }
 
-/*
- * For moronic filesystems that do not allow holes in file.
- * We may have to extend the file.
- */
-
 int cont_prepare_write(struct page *page, unsigned offset,
 		unsigned to, get_block_t *get_block, loff_t *bytes)
 {
-	struct address_space *mapping = page->mapping;
-	struct inode *inode = mapping->host;
-	struct page *new_page;
-	pgoff_t pgpos;
-	long status;
-	unsigned zerofrom;
-	unsigned blocksize = 1 << inode->i_blkbits;
-	void *kaddr;
-
-	while(page->index > (pgpos = *bytes>>PAGE_CACHE_SHIFT)) {
-		status = -ENOMEM;
-		new_page = grab_cache_page(mapping, pgpos);
-		if (!new_page)
-			goto out;
-		/* we might sleep */
-		if (*bytes>>PAGE_CACHE_SHIFT != pgpos) {
-			unlock_page(new_page);
-			page_cache_release(new_page);
-			continue;
-		}
-		zerofrom = *bytes & ~PAGE_CACHE_MASK;
-		if (zerofrom & (blocksize-1)) {
-			*bytes |= (blocksize-1);
-			(*bytes)++;
-		}
-		status = __block_prepare_write(inode, new_page, zerofrom,
-						PAGE_CACHE_SIZE, get_block);
-		if (status)
-			goto out_unmap;
-		kaddr = kmap_atomic(new_page, KM_USER0);
-		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
-		flush_dcache_page(new_page);
-		kunmap_atomic(kaddr, KM_USER0);
-		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
-		unlock_page(new_page);
-		page_cache_release(new_page);
-	}
-
-	if (page->index < pgpos) {
-		/* completely inside the area */
-		zerofrom = offset;
-	} else {
-		/* page covers the boundary, find the boundary offset */
-		zerofrom = *bytes & ~PAGE_CACHE_MASK;
-
-		/* if we will expand the thing last block will be filled */
-		if (to > zerofrom && (zerofrom & (blocksize-1))) {
-			*bytes |= (blocksize-1);
-			(*bytes)++;
-		}
+	loff_t size = (page->index << PAGE_CACHE_SHIFT) + offset;
+	struct inode *inode = page->mapping->host;
+	int err;
 
-		/* starting below the boundary? Nothing to zero out */
-		if (offset <= zerofrom)
-			zerofrom = offset;
-	}
-	status = __block_prepare_write(inode, page, zerofrom, to, get_block);
-	if (status)
-		goto out1;
-	if (zerofrom < offset) {
-		kaddr = kmap_atomic(page, KM_USER0);
-		memset(kaddr+zerofrom, 0, offset-zerofrom);
-		flush_dcache_page(page);
-		kunmap_atomic(kaddr, KM_USER0);
-		__block_commit_write(inode, page, zerofrom, offset);
+	if (*bytes < size) {
+		unlock_page(page);
+		err = generic_cont_expand(inode, size, bytes, get_block);
+		if (!err)
+			err = AOP_TRUNCATED_PAGE;
+		else
+			lock_page(page); /* caller expects this */
+		return err;
 	}
-	return 0;
-out1:
-	ClearPageUptodate(page);
-	return status;
 
-out_unmap:
-	ClearPageUptodate(new_page);
-	unlock_page(new_page);
-	page_cache_release(new_page);
-out:
-	return status;
+	err = __block_prepare_write(inode, page, offset, to, get_block);
+	if (err)
+		ClearPageUptodate(page);
+	return err;
 }
 
 int block_prepare_write(struct page *page, unsigned from, unsigned to,
@@ -3015,7 +2953,6 @@ EXPORT_SYMBOL(fsync_bdev);
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
@@ -202,8 +202,7 @@ int block_read_full_page(struct page*, g
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				loff_t *);
-int generic_cont_expand(struct inode *inode, loff_t size);
-int generic_cont_expand_simple(struct inode *inode, loff_t size);
+int generic_cont_expand(struct inode *inode, loff_t size, loff_t *bytes, get_block_t *);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 void block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
Index: linux-2.6/fs/fat/inode.c
===================================================================
--- linux-2.6.orig/fs/fat/inode.c
+++ linux-2.6/fs/fat/inode.c
@@ -117,6 +117,25 @@ static int fat_get_block(struct inode *i
 	return 0;
 }
 
+int fat_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t start = inode->i_size, count = size - inode->i_size;
+	int err;
+
+	err = generic_cont_expand(inode, size,
+			&MSDOS_I(inode)->mmu_private, fat_get_block);
+	if (err)
+		goto out;
+
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
+	mark_inode_dirty(inode);
+	if (IS_SYNC(inode))
+		err = sync_page_range_nolock(inode, mapping, start, count);
+out:
+	return err;
+}
+
 static int fat_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, fat_get_block, wbc);
@@ -151,11 +170,12 @@ static int fat_commit_write(struct file 
 {
 	struct inode *inode = page->mapping->host;
 	int err;
-	if (to - from > 0)
-		return 0;
 
 	err = generic_commit_write(file, page, from, to);
-	if (!err && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
+	if (err)
+		return err;
+
+	if (!(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
Index: linux-2.6/fs/fat/file.c
===================================================================
--- linux-2.6.orig/fs/fat/file.c
+++ linux-2.6/fs/fat/file.c
@@ -137,24 +137,6 @@ const struct file_operations fat_file_op
 	.sendfile	= generic_file_sendfile,
 };
 
-static int fat_cont_expand(struct inode *inode, loff_t size)
-{
-	struct address_space *mapping = inode->i_mapping;
-	loff_t start = inode->i_size, count = size - inode->i_size;
-	int err;
-
-	err = generic_cont_expand_simple(inode, size);
-	if (err)
-		goto out;
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
-	mark_inode_dirty(inode);
-	if (IS_SYNC(inode))
-		err = sync_page_range_nolock(inode, mapping, start, count);
-out:
-	return err;
-}
-
 int fat_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
Index: linux-2.6/include/linux/msdos_fs.h
===================================================================
--- linux-2.6.orig/include/linux/msdos_fs.h
+++ linux-2.6/include/linux/msdos_fs.h
@@ -406,6 +406,7 @@ extern int fat_getattr(struct vfsmount *
 		       struct kstat *stat);
 
 /* fat/inode.c */
+extern int fat_cont_expand(struct inode *inode, loff_t size);
 extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);

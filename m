Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSDXIyo>; Wed, 24 Apr 2002 04:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSDXIwy>; Wed, 24 Apr 2002 04:52:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43025 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293337AbSDXIvx>;
	Wed, 24 Apr 2002 04:51:53 -0400
Message-ID: <3CC67244.F5B84094@zip.com.au>
Date: Wed, 24 Apr 2002 01:52:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] remove some buffer-based writeout functions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove writeout_one_page(), waitfor_one_page() and the now-unused
generic_buffer_fdatasync().

Add new

	write_one_page(struct page *page, int wait)

which is exported to modules.  Update callers to use that.  It's only
used for IS_SYNC operations.


=====================================

--- 2.5.9/fs/buffer.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/buffer.c	Wed Apr 24 01:45:01 2002
@@ -1896,49 +1896,6 @@ int block_write_full_page(struct page *p
 	return __block_write_full_page(inode, page, get_block);
 }
 
-/*
- * Commence writeout of all the buffers against a page.  The
- * page must be locked.   Returns zero on success or a negative
- * errno.
- */
-int writeout_one_page(struct page *page)
-{
-	struct buffer_head * const head = page_buffers(page);
-	struct buffer_head *arr[MAX_BUF_PER_PAGE];
-	struct buffer_head *bh;
-	int nr = 0;
-	BUG_ON(!PageLocked(page));
-	bh = head;
-	do {
-		if (!buffer_locked(bh) && buffer_dirty(bh) &&
-				buffer_mapped(bh) && buffer_uptodate(bh))
-			arr[nr++] = bh;
-	} while ((bh = bh->b_this_page) != head);
-	if (nr)
-		ll_rw_block(WRITE, nr, arr);	
-	return 0;
-}
-EXPORT_SYMBOL(writeout_one_page);
-
-/*
- * Wait for completion of I/O of all buffers against a page.  The page
- * must be locked.  Returns zero on success or a negative errno.
- */
-int waitfor_one_page(struct page *page)
-{
-	int error = 0;
-	struct buffer_head *bh, *head = page_buffers(page);
-
-	bh = head;
-	do {
-		wait_on_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
-			error = -EIO;
-	} while ((bh = bh->b_this_page) != head);
-	return error;
-}
-EXPORT_SYMBOL(waitfor_one_page);
-
 sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
 			    get_block_t *get_block)
 {
--- 2.5.9/mm/page-writeback.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/page-writeback.c	Wed Apr 24 01:44:52 2002
@@ -375,6 +375,45 @@ int generic_writeback_mapping(struct add
 }
 EXPORT_SYMBOL(generic_writeback_mapping);
 
+/**
+ * write_one_page - write out a single page and optionally wait on I/O
+ *
+ * @page - the page to write
+ * @wait - if true, wait on writeout
+ *
+ * The page must be locked by the caller and will come unlocked when I/O
+ * completes.
+ *
+ * write_one_page() returns a negative error code if I/O failed.
+ */
+int write_one_page(struct page *page, int wait)
+{
+	struct address_space *mapping = page->mapping;
+	int ret = 0;
+
+	BUG_ON(!PageLocked(page));
+
+	write_lock(&mapping->page_lock);
+	list_del(&page->list);
+	list_add(&page->list, &mapping->locked_pages);
+	write_unlock(&mapping->page_lock);
+
+	if (TestClearPageDirty(page)) {
+		page_cache_get(page);
+		ret = mapping->a_ops->writepage(page);
+		if (ret == 0 && wait) {
+			wait_on_page(page);
+			if (PageError(page))
+				ret = -EIO;
+		}
+		page_cache_release(page);
+	} else {
+		unlock_page(page);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(write_one_page);
+
 /*
  * Add a page to the dirty page list.
  *
--- 2.5.9/include/linux/mm.h~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/include/linux/mm.h	Wed Apr 24 01:39:42 2002
@@ -449,6 +449,7 @@ extern struct page *filemap_nopage(struc
 
 /* mm/page-writeback.c */
 int generic_writeback_mapping(struct address_space *mapping, int *nr_to_write);
+int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
 #define VM_MAX_READAHEAD	128	/* kbytes */
--- 2.5.9/fs/ext2/dir.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/ext2/dir.c	Wed Apr 24 01:06:11 2002
@@ -67,13 +67,10 @@ static int ext2_commit_chunk(struct page
 	int err = 0;
 	dir->i_version = ++event;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir)) {
-		int err2;
-		err = writeout_one_page(page);
-		err2 = waitfor_one_page(page);
-		if (err == 0)
-			err = err2;
-	}
+	if (IS_SYNC(dir))
+		err = write_one_page(page, 1);
+	else
+		unlock_page(page);
 	return err;
 }
 
@@ -417,7 +414,6 @@ void ext2_set_link(struct inode *dir, st
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
-	unlock_page(page);
 	ext2_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
@@ -511,11 +507,13 @@ got_it:
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
-out_unlock:
-	unlock_page(page);
+out_put:
 	ext2_put_page(page);
 out:
 	return err;
+out_unlock:
+	unlock_page(page);
+	goto out_put;
 }
 
 /*
@@ -553,7 +551,6 @@ int ext2_delete_entry (struct ext2_dir_e
 		pde->rec_len = cpu_to_le16(to-from);
 	dir->inode = 0;
 	err = ext2_commit_chunk(page, from, to);
-	unlock_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 out:
@@ -576,9 +573,10 @@ int ext2_make_empty(struct inode *inode,
 	if (!page)
 		return -ENOMEM;
 	err = mapping->a_ops->prepare_write(NULL, page, 0, chunk_size);
-	if (err)
+	if (err) {
+		unlock_page(page);
 		goto fail;
-
+	}
 	base = page_address(page);
 
 	de = (struct ext2_dir_entry_2 *) base;
@@ -597,7 +595,6 @@ int ext2_make_empty(struct inode *inode,
 
 	err = ext2_commit_chunk(page, 0, chunk_size);
 fail:
-	unlock_page(page);
 	page_cache_release(page);
 	return err;
 }
--- 2.5.9/fs/jfs/jfs_metapage.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/jfs/jfs_metapage.c	Wed Apr 24 01:44:59 2002
@@ -489,12 +489,10 @@ static inline void sync_metapage(metapag
 	lock_page(page);
 
 	/* we're done with this page - no need to check for errors */
-	if (page_has_buffers(page)) {
-		writeout_one_page(page);
-		waitfor_one_page(page);
-	}
-
-	unlock_page(page);
+	if (page_has_buffers(page))
+		write_one_page(page, 1);
+	else
+		unlock_page(page);
 	page_cache_release(page);
 }
 
--- 2.5.9/fs/minix/dir.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/minix/dir.c	Wed Apr 24 01:06:11 2002
@@ -48,13 +48,10 @@ static int dir_commit_chunk(struct page 
 	struct inode *dir = (struct inode *)page->mapping->host;
 	int err = 0;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir)) {
-		int err2;
-		err = writeout_one_page(page);
-		err2 = waitfor_one_page(page);
-		if (err == 0)
-			err = err2;
-	}
+	if (IS_SYNC(dir))
+		err = write_one_page(page, 1);
+	else
+		unlock_page(page);
 	return err;
 }
 
@@ -247,11 +244,13 @@ got_it:
 	err = dir_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
-out_unlock:
-	unlock_page(page);
+out_put:
 	dir_put_page(page);
 out:
 	return err;
+out_unlock:
+	unlock_page(page);
+	goto out_put;
 }
 
 int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
@@ -268,8 +267,9 @@ int minix_delete_entry(struct minix_dir_
 	if (err == 0) {
 		de->inode = 0;
 		err = dir_commit_chunk(page, from, to);
+	} else {
+		unlock_page(page);
 	}
-	unlock_page(page);
 	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -288,8 +288,10 @@ int minix_make_empty(struct inode *inode
 	if (!page)
 		return -ENOMEM;
 	err = mapping->a_ops->prepare_write(NULL, page, 0, 2 * sbi->s_dirsize);
-	if (err)
+	if (err) {
+		unlock_page(page);
 		goto fail;
+	}
 
 	base = (char*)page_address(page);
 	memset(base, 0, PAGE_CACHE_SIZE);
@@ -303,7 +305,6 @@ int minix_make_empty(struct inode *inode
 
 	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
 fail:
-	unlock_page(page);
 	page_cache_release(page);
 	return err;
 }
@@ -368,8 +369,9 @@ void minix_set_link(struct minix_dir_ent
 	if (err == 0) {
 		de->inode = inode->i_ino;
 		err = dir_commit_chunk(page, from, to);
+	} else {
+		unlock_page(page);
 	}
-	unlock_page(page);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
--- 2.5.9/fs/sysv/dir.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/fs/sysv/dir.c	Wed Apr 24 01:06:11 2002
@@ -42,13 +42,10 @@ static int dir_commit_chunk(struct page 
 	int err = 0;
 
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
-	if (IS_SYNC(dir)) {
-		int err2;
-		err = writeout_one_page(page);
-		err2 = waitfor_one_page(page);
-		if (err == 0)
-			err = err2;
-	}
+	if (IS_SYNC(dir))
+		err = write_one_page(page, 1);
+	else
+		unlock_page(page);
 	return err;
 }
 
@@ -232,12 +229,13 @@ got_it:
 	err = dir_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
-out_unlock:
-	unlock_page(page);
 out_page:
 	dir_put_page(page);
 out:
 	return err;
+out_unlock:
+	unlock_page(page);
+	goto out_page;
 }
 
 int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
@@ -255,7 +253,6 @@ int sysv_delete_entry(struct sysv_dir_en
 		BUG();
 	de->inode = 0;
 	err = dir_commit_chunk(page, from, to);
-	unlock_page(page);
 	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -273,8 +270,10 @@ int sysv_make_empty(struct inode *inode,
 	if (!page)
 		return -ENOMEM;
 	err = mapping->a_ops->prepare_write(NULL, page, 0, 2 * SYSV_DIRSIZE);
-	if (err)
+	if (err) {
+		unlock_page(page);
 		goto fail;
+	}
 
 	base = (char*)page_address(page);
 	memset(base, 0, PAGE_CACHE_SIZE);
@@ -288,7 +287,6 @@ int sysv_make_empty(struct inode *inode,
 
 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
 fail:
-	unlock_page(page);
 	page_cache_release(page);
 	return err;
 }
@@ -352,7 +350,6 @@ void sysv_set_link(struct sysv_dir_entry
 		BUG();
 	de->inode = cpu_to_fs16(inode->i_sb, inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
-	unlock_page(page);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
--- 2.5.9/include/linux/fs.h~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/include/linux/fs.h	Wed Apr 24 01:45:01 2002
@@ -1559,8 +1559,6 @@ sector_t generic_block_bmap(struct addre
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 extern int generic_direct_IO(int, struct inode *, struct kiobuf *, unsigned long, int, get_block_t *);
-extern int waitfor_one_page(struct page *);
-extern int writeout_one_page(struct page *);
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
@@ -1613,7 +1611,6 @@ extern ssize_t char_write(struct file *,
 extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
 
 extern int file_fsync(struct file *, struct dentry *, int);
-extern int generic_buffer_fdatasync(struct inode *inode, unsigned long start_idx, unsigned long end_idx);
 extern int generic_osync_inode(struct inode *, int);
 #define OSYNC_METADATA (1<<0)
 #define OSYNC_DATA (1<<1)
--- 2.5.9/mm/filemap.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/mm/filemap.c	Wed Apr 24 01:44:59 2002
@@ -387,76 +387,6 @@ void invalidate_inode_pages2(struct addr
 	write_unlock(&mapping->page_lock);
 }
 
-static int do_buffer_fdatasync(struct address_space *mapping,
-		struct list_head *head, unsigned long start,
-		unsigned long end, int (*fn)(struct page *))
-{
-	struct list_head *curr;
-	struct page *page;
-	int retval = 0;
-
-	write_lock(&mapping->page_lock);
-	curr = head->next;
-	while (curr != head) {
-		page = list_entry(curr, struct page, list);
-		curr = curr->next;
-		if (!page_has_buffers(page))
-			continue;
-		if (page->index >= end)
-			continue;
-		if (page->index < start)
-			continue;
-
-		page_cache_get(page);
-		write_unlock(&mapping->page_lock);
-		lock_page(page);
-
-		/* The buffers could have been free'd while we waited for the page lock */
-		if (page_has_buffers(page))
-			retval |= fn(page);
-
-		unlock_page(page);
-		write_lock(&mapping->page_lock);
-		curr = page->list.next;
-		page_cache_release(page);
-	}
-	write_unlock(&mapping->page_lock);
-
-	return retval;
-}
-
-/*
- * Two-stage data sync: first start the IO, then go back and
- * collect the information..
- */
-int generic_buffer_fdatasync(struct inode *inode, unsigned long start_idx, unsigned long end_idx)
-{
-	struct address_space *mapping = inode->i_mapping;
-	int retval;
-
-	/* writeout dirty buffers on pages from both clean and dirty lists */
-	retval = do_buffer_fdatasync(mapping, &mapping->dirty_pages,
-			start_idx, end_idx, writeout_one_page);
-	retval = do_buffer_fdatasync(mapping, &mapping->io_pages,
-			start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(mapping, &mapping->clean_pages,
-			start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(mapping, &mapping->locked_pages,
-			start_idx, end_idx, writeout_one_page);
-
-	/* now wait for locked buffers on pages from both clean and dirty lists */
-	retval |= do_buffer_fdatasync(mapping, &mapping->dirty_pages,
-			start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(mapping, &mapping->io_pages,
-			start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(mapping, &mapping->clean_pages,
-			start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(mapping, &mapping->locked_pages,
-			start_idx, end_idx, waitfor_one_page);
-
-	return retval;
-}
-
 /*
  * In-memory filesystems have to fail their
  * writepage function - and this has to be
--- 2.5.9/kernel/ksyms.c~cleanup-020-write_one_page	Wed Apr 24 01:06:11 2002
+++ 2.5.9-akpm/kernel/ksyms.c	Wed Apr 24 01:06:11 2002
@@ -224,7 +224,6 @@ EXPORT_SYMBOL(do_generic_file_read);
 EXPORT_SYMBOL(generic_file_write);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
-EXPORT_SYMBOL(generic_buffer_fdatasync);
 EXPORT_SYMBOL(file_lock_list);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289893AbSAKIBk>; Fri, 11 Jan 2002 03:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289895AbSAKIBV>; Fri, 11 Jan 2002 03:01:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19975 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289893AbSAKIBB>; Fri, 11 Jan 2002 03:01:01 -0500
Message-ID: <3C3E9A76.F9DEFF96@zip.com.au>
Date: Thu, 10 Jan 2002 23:55:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Alexander Viro <viro@math.psu.edu>, Christoph Hellwig <hch@ns.caldera.de>
Subject: [patch] ext2, sysvfs, minixfs directory syncs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These three filesytems are not honouring synchronous mounts for
directories, and ext2 is also not honouring `chattr +S' for
directories.  This is because they are calling waitfor_one_page()
against the directory page without having started I/O.

- writeout_one_page() and waitfor_one_page() have been moved to
  fs/buffer.c.  mm/filemap.c now has no mention of `buffer_head'.

- waitfor_one_page() was exported to modules in 2.4.5.  This patch
  unexports it.

- The new function sync_one_page() has been created and exported
  to modules.

- The three filesystems are converted to use sync_one_page().

- Minixfs had a couple of BUG()s which appeared to be triggerable
  by -EIO or -ENOSPC in prepare_write().  These have been converted
  to proper error handling.

I've only tested ext2.    Christoph, could you please test the
sysvfs changes?   Thanks.

The time to create and remove 100 ext2 directories went from
four seconds to seven on a disk which does not perform write
caching, with a synchronous mount.


--- linux-2.4.18-pre3/include/linux/fs.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/fs.h	Thu Jan 10 23:19:00 2002
@@ -1391,8 +1391,10 @@ int generic_block_bmap(struct address_sp
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 extern int generic_direct_IO(int, struct inode *, struct kiobuf *, unsigned long, int, get_block_t *);
+extern int waitfor_one_page(struct page *);
+extern int writeout_one_page(struct page *);
+extern int sync_one_page(struct page *);
 
-extern int waitfor_one_page(struct page*);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
--- linux-2.4.18-pre3/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Thu Jan 10 23:19:00 2002
@@ -1989,6 +1989,58 @@ done:
 	goto done;
 }
 
+/*
+ * Commence writeout of all the buffers against a page.  The
+ * page must be locked.   Returns zero on success or a negative
+ * errno.
+ */
+int writeout_one_page(struct page *page)
+{
+	struct buffer_head *bh, *head = page->buffers;
+
+	if (!PageLocked(page))
+		BUG();
+	bh = head;
+	do {
+		if (buffer_locked(bh) || !buffer_dirty(bh) || !buffer_uptodate(bh))
+			continue;
+
+		bh->b_flushtime = jiffies;
+		ll_rw_block(WRITE, 1, &bh);	
+	} while ((bh = bh->b_this_page) != head);
+	return 0;
+}
+
+/*
+ * Wait for completion of I/O of all buffers against a page.  The page
+ * must be locked.  Returns zero on success or a negative errno.
+ */
+int waitfor_one_page(struct page *page)
+{
+	int error = 0;
+	struct buffer_head *bh, *head = page->buffers;
+
+	bh = head;
+	do {
+		wait_on_buffer(bh);
+		if (buffer_req(bh) && !buffer_uptodate(bh))
+			error = -EIO;
+	} while ((bh = bh->b_this_page) != head);
+	return error;
+}
+
+int sync_one_page(struct page *page)
+{
+	int ret, ret2;
+
+	ret = writeout_one_page(page);
+	ret2 = waitfor_one_page(page);
+	if (ret == 0)
+		ret = ret2;
+	return ret;
+}
+EXPORT_SYMBOL(sync_one_page);
+
 int generic_block_bmap(struct address_space *mapping, long block, get_block_t *get_block)
 {
 	struct buffer_head tmp;
--- linux-2.4.18-pre3/mm/filemap.c	Thu Jan 10 13:39:50 2002
+++ linux-akpm/mm/filemap.c	Thu Jan 10 23:19:00 2002
@@ -454,41 +454,6 @@ not_found:
 	return page;
 }
 
-/*
- * By the time this is called, the page is locked and
- * we don't have to worry about any races any more.
- *
- * Start the IO..
- */
-static int writeout_one_page(struct page *page)
-{
-	struct buffer_head *bh, *head = page->buffers;
-
-	bh = head;
-	do {
-		if (buffer_locked(bh) || !buffer_dirty(bh) || !buffer_uptodate(bh))
-			continue;
-
-		bh->b_flushtime = jiffies;
-		ll_rw_block(WRITE, 1, &bh);	
-	} while ((bh = bh->b_this_page) != head);
-	return 0;
-}
-
-int waitfor_one_page(struct page *page)
-{
-	int error = 0;
-	struct buffer_head *bh, *head = page->buffers;
-
-	bh = head;
-	do {
-		wait_on_buffer(bh);
-		if (buffer_req(bh) && !buffer_uptodate(bh))
-			error = -EIO;
-	} while ((bh = bh->b_this_page) != head);
-	return error;
-}
-
 static int do_buffer_fdatasync(struct list_head *head, unsigned long start, unsigned long end, int (*fn)(struct page *))
 {
 	struct list_head *curr;
--- linux-2.4.18-pre3/kernel/ksyms.c	Thu Jan 10 13:39:50 2002
+++ linux-akpm/kernel/ksyms.c	Thu Jan 10 23:19:13 2002
@@ -208,7 +208,6 @@ EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);
-EXPORT_SYMBOL(waitfor_one_page);
 EXPORT_SYMBOL(generic_file_read);
 EXPORT_SYMBOL(do_generic_file_read);
 EXPORT_SYMBOL(generic_file_write);
--- linux-2.4.18-pre3/fs/ext2/dir.c	Mon Sep 17 13:16:30 2001
+++ linux-akpm/fs/ext2/dir.c	Thu Jan 10 23:19:00 2002
@@ -54,7 +54,7 @@ static int ext2_commit_chunk(struct page
 	dir->i_version = ++event;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
 	if (IS_SYNC(dir))
-		err = waitfor_one_page(page);
+		err = sync_one_page(page);
 	return err;
 }
 
--- linux-2.4.18-pre3/fs/minix/dir.c	Fri Sep  7 09:45:51 2001
+++ linux-akpm/fs/minix/dir.c	Thu Jan 10 23:19:00 2002
@@ -37,7 +37,7 @@ static int dir_commit_chunk(struct page 
 	int err = 0;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
 	if (IS_SYNC(dir))
-		err = waitfor_one_page(page);
+		err = sync_one_page(page);
 	return err;
 }
 
@@ -236,10 +236,10 @@ int minix_delete_entry(struct minix_dir_
 
 	lock_page(page);
 	err = mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
-	de->inode = 0;
-	err = dir_commit_chunk(page, from, to);
+	if (err == 0) {
+		de->inode = 0;
+		err = dir_commit_chunk(page, from, to);
+	}
 	UnlockPage(page);
 	dir_put_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
@@ -336,10 +336,10 @@ void minix_set_link(struct minix_dir_ent
 
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
-	de->inode = inode->i_ino;
-	err = dir_commit_chunk(page, from, to);
+	if (err == 0) {
+		de->inode = inode->i_ino;
+		err = dir_commit_chunk(page, from, to);
+	}
 	UnlockPage(page);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
--- linux-2.4.18-pre3/fs/sysv/dir.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/fs/sysv/dir.c	Thu Jan 10 23:19:00 2002
@@ -44,7 +44,7 @@ static int dir_commit_chunk(struct page 
 	dir->i_version = ++event;
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
 	if (IS_SYNC(dir))
-		err = waitfor_one_page(page);
+		err = sync_one_page(page);
 	return err;
 }
 
--- linux-2.4.18-pre3/fs/sysv/ChangeLog	Fri Dec 21 11:19:23 2001
+++ linux-akpm/fs/sysv/ChangeLog	Thu Jan 10 23:19:00 2002
@@ -20,3 +20,8 @@ Fri Oct 26 2001  Christoph Hellwig  <hch
 	Remove symlink faking.	Noone really wants to use these as
 	linux filesystems and native OSes don't support it anyway.
 
+Thu Jan 10 2002  Andrew Morton  <akpm@zip.com.au>
+
+	* dir.c: use sync_one_page() rather than waitfor_one_page() for
+	  IS_SYNC directories, so that we actually do sync the directory.
+

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTBKSka>; Tue, 11 Feb 2003 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBKSka>; Tue, 11 Feb 2003 13:40:30 -0500
Received: from waste.org ([209.173.204.2]:33220 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S263313AbTBKSkC>;
	Tue, 11 Feb 2003 13:40:02 -0500
Date: Tue, 11 Feb 2003 12:49:46 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Propagate write errors to userspace
Message-ID: <20030211184946.GR28107@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, this is my write error propagation patch updated to 2.5.60-mm1.
Please add this to your collection.

diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
--- orig/fs/buffer.c	2003-02-11 12:24:54.000000000 -0600
+++ patched/fs/buffer.c	2003-02-11 12:25:59.000000000 -0600
@@ -164,15 +164,27 @@
  * Default synchronous end-of-IO handler..  Just mark it up-to-date and
  * unlock the buffer. This is what ll_rw_block uses too.
  */
-void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
-		/*
-		 * This happens, due to failed READA attempts.
-		 * buffer_io_error(bh);
-		 */
+		/* This happens, due to failed READA attempts. */
+		clear_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
+	put_bh(bh);
+}
+
+void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
+{
+	if (uptodate) {
+		set_buffer_uptodate(bh);
+	} else {
+		buffer_io_error(bh);
+		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
+		       bdevname(bh->b_bdev));
+		set_buffer_write_io_error(bh);
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -549,6 +561,9 @@
 		set_buffer_uptodate(bh);
 	} else {
 		buffer_io_error(bh);
+		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
+		       bdevname(bh->b_bdev));
+		page->mapping->error = -EIO;
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}
@@ -1200,7 +1215,7 @@
 		if (buffer_dirty(bh))
 			buffer_error();
 		get_bh(bh);
-		bh->b_end_io = end_buffer_io_sync;
+		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, bh);
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
@@ -2542,8 +2557,10 @@
 		buffer_error();
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
-				
-	set_buffer_req(bh);
+
+	/* Only clear out a write error when rewriting */
+	if (test_set_buffer_req(bh) && rw == WRITE)
+		clear_buffer_write_io_error(bh);
 
 	/*
 	 * from here on down, it's all bio -- do the initial mapping,
@@ -2603,13 +2620,14 @@
 			continue;
 
 		get_bh(bh);
-		bh->b_end_io = end_buffer_io_sync;
 		if (rw == WRITE) {
+			bh->b_end_io = end_buffer_write_sync;
 			if (test_clear_buffer_dirty(bh)) {
 				submit_bh(WRITE, bh);
 				continue;
 			}
 		} else {
+			bh->b_end_io = end_buffer_read_sync;
 			if (!buffer_uptodate(bh)) {
 				submit_bh(rw, bh);
 				continue;
@@ -2630,7 +2648,7 @@
 	lock_buffer(bh);
 	if (test_clear_buffer_dirty(bh)) {
 		get_bh(bh);
-		bh->b_end_io = end_buffer_io_sync;
+		bh->b_end_io = end_buffer_write_sync;
 		submit_bh(WRITE, bh);
 		wait_on_buffer(bh);
 	} else {
@@ -2689,6 +2707,8 @@
 	bh = head;
 	do {
 		check_ttfb_buffer(page, bh);
+		if (buffer_write_io_error(bh))
+			page->mapping->error = -EIO;
 		if (buffer_busy(bh))
 			goto failed;
 		if (!buffer_uptodate(bh) && !buffer_req(bh))
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/inode.c patched/fs/inode.c
--- orig/fs/inode.c	2003-02-11 11:12:26.000000000 -0600
+++ patched/fs/inode.c	2003-02-11 12:24:58.000000000 -0600
@@ -134,6 +134,7 @@
 		mapping->dirtied_when = 0;
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+		mapping->error = 0;
 		if (sb->s_bdev)
 			inode->i_data.backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/mpage.c patched/fs/mpage.c
--- orig/fs/mpage.c	2003-02-11 11:12:26.000000000 -0600
+++ patched/fs/mpage.c	2003-02-11 12:24:58.000000000 -0600
@@ -562,6 +562,8 @@
 	if (bio)
 		bio = mpage_bio_submit(WRITE, bio);
 	*ret = page->mapping->a_ops->writepage(page, wbc);
+	if (*ret < 0)
+		page->mapping->error = *ret;
 out:
 	return bio;
 }
@@ -665,6 +667,8 @@
 					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page, wbc);
+				if (ret < 0)
+					page->mapping->error = ret;
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
 					&last_block_in_bio, &ret, wbc);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/ntfs/compress.c patched/fs/ntfs/compress.c
--- orig/fs/ntfs/compress.c	2003-01-16 20:22:13.000000000 -0600
+++ patched/fs/ntfs/compress.c	2003-02-11 12:24:58.000000000 -0600
@@ -598,7 +598,7 @@
 			continue;
 		}
 		atomic_inc(&tbh->b_count);
-		tbh->b_end_io = end_buffer_io_sync;
+		tbh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, tbh);
 	}
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/open.c patched/fs/open.c
--- orig/fs/open.c	2003-01-16 20:21:37.000000000 -0600
+++ patched/fs/open.c	2003-02-11 12:24:58.000000000 -0600
@@ -843,21 +843,38 @@
  */
 int filp_close(struct file *filp, fl_owner_t id)
 {
-	int retval;
+	struct address_space *mapping = filp->f_dentry->d_inode->i_mapping;
+	int retval = 0, err;
+
+	/* Report and clear outstanding errors */
+	err = filp->f_error;
+	if (err) {
+		filp->f_error = 0;
+		retval = err;
+	}
+
+	err = mapping->error;
+	if (err && !retval) {
+		mapping->error = 0;
+		retval = err;
+	}
 
 	if (!file_count(filp)) {
 		printk(KERN_ERR "VFS: Close: file count is 0\n");
-		return 0;
+		return retval;
 	}
-	retval = 0;
+
 	if (filp->f_op && filp->f_op->flush) {
 		lock_kernel();
-		retval = filp->f_op->flush(filp);
+		err = filp->f_op->flush(filp);
 		unlock_kernel();
+		if (err && !retval)
+			retval = err;
 	}
 	dnotify_flush(filp, id);
 	locks_remove_posix(filp, id);
 	fput(filp);
+
 	return retval;
 }
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/buffer_head.h patched/include/linux/buffer_head.h
--- orig/include/linux/buffer_head.h	2003-02-11 12:24:55.000000000 -0600
+++ patched/include/linux/buffer_head.h	2003-02-11 12:24:58.000000000 -0600
@@ -24,8 +24,9 @@
 	BH_Async_Read,	/* Is under end_buffer_async_read I/O */
 	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
 	BH_Delay,	/* Buffer is not yet allocated on disk */
-
 	BH_Boundary,	/* Block is followed by a discontiguity */
+	BH_Write_EIO,	/* I/O error on write */
+
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
 			 */
@@ -103,12 +104,14 @@
 BUFFER_FNS(Lock, locked)
 TAS_BUFFER_FNS(Lock, locked)
 BUFFER_FNS(Req, req)
+TAS_BUFFER_FNS(Req, req)
 BUFFER_FNS(Mapped, mapped)
 BUFFER_FNS(New, new)
 BUFFER_FNS(Async_Read, async_read)
 BUFFER_FNS(Async_Write, async_write)
-BUFFER_FNS(Delay, delay);
+BUFFER_FNS(Delay, delay)
 BUFFER_FNS(Boundary, boundary)
+BUFFER_FNS(Write_EIO,write_io_error)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)
@@ -136,7 +139,8 @@
 int try_to_free_buffers(struct page *);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
-void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
+void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
+void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
 void buffer_insert_list(spinlock_t *lock,
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/fs.h patched/include/linux/fs.h
--- orig/include/linux/fs.h	2003-02-11 12:24:55.000000000 -0600
+++ patched/include/linux/fs.h	2003-02-11 12:24:58.000000000 -0600
@@ -326,6 +326,7 @@
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	int			error;		/* write error for fsync */
 };
 
 struct char_device {
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/kernel/ksyms.c patched/kernel/ksyms.c
--- orig/kernel/ksyms.c	2003-02-11 12:24:55.000000000 -0600
+++ patched/kernel/ksyms.c	2003-02-11 12:24:58.000000000 -0600
@@ -170,7 +170,8 @@
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
-EXPORT_SYMBOL(end_buffer_io_sync);
+EXPORT_SYMBOL(end_buffer_read_sync);
+EXPORT_SYMBOL(end_buffer_write_sync);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(init_private_file);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/filemap.c patched/mm/filemap.c
--- orig/mm/filemap.c	2003-02-11 11:12:31.000000000 -0600
+++ patched/mm/filemap.c	2003-02-11 12:24:58.000000000 -0600
@@ -185,6 +185,14 @@
 		write_lock(&mapping->page_lock);
 	}
 	write_unlock(&mapping->page_lock);
+
+	/* Check for outstanding write errors */
+	if (mapping->error)
+	{
+		ret = mapping->error;
+		mapping->error = 0;
+	}
+
 	return ret;
 }
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/vmscan.c patched/mm/vmscan.c
--- orig/mm/vmscan.c	2003-02-11 12:24:56.000000000 -0600
+++ patched/mm/vmscan.c	2003-02-11 12:24:58.000000000 -0600
@@ -342,6 +342,9 @@
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
 
+				if (res < 0) {
+					mapping->error = res;
+				}
 				if (res == WRITEPAGE_ACTIVATE) {
 					ClearPageReclaim(page);
 					goto activate_locked;


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

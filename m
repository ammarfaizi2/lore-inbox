Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTA2GAC>; Wed, 29 Jan 2003 01:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA2GAC>; Wed, 29 Jan 2003 01:00:02 -0500
Received: from waste.org ([209.173.204.2]:13231 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S264857AbTA2F77>;
	Wed, 29 Jan 2003 00:59:59 -0500
Date: Wed, 29 Jan 2003 00:09:16 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] Report write errors to applications
Message-ID: <20030129060916.GA3186@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, this is a forward-port of the 2.4 write error propagation
patch I just posted, applies against -mm6. Lightly tested on 2.5, but
should be straightforward.

diff -urN -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
--- orig/fs/buffer.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/fs/buffer.c	2003-01-24 13:25:08.000000000 -0600
@@ -165,15 +165,27 @@
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
+		bh->b_page->mapping->error = -EIO;
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -550,6 +562,9 @@
 		set_buffer_uptodate(bh);
 	} else {
 		buffer_io_error(bh);
+		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
+		       bdevname(bh->b_bdev));
+		bh->b_page->mapping->error = -EIO;
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}
@@ -1201,7 +1216,7 @@
 		if (buffer_dirty(bh))
 			buffer_error();
 		get_bh(bh);
-		bh->b_end_io = end_buffer_io_sync;
+		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, bh);
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
@@ -2604,13 +2619,14 @@
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
diff -urN -x '.patch*' -x '*.orig' orig/fs/inode.c patched/fs/inode.c
--- orig/fs/inode.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/fs/inode.c	2003-01-24 13:24:26.000000000 -0600
@@ -134,6 +134,7 @@
 		mapping->dirtied_when = 0;
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+		mapping->error = 0;
 		if (sb->s_bdev)
 			inode->i_data.backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
diff -urN -x '.patch*' -x '*.orig' orig/fs/ntfs/compress.c patched/fs/ntfs/compress.c
--- orig/fs/ntfs/compress.c	2003-01-13 23:58:43.000000000 -0600
+++ patched/fs/ntfs/compress.c	2003-01-24 13:24:26.000000000 -0600
@@ -598,7 +598,7 @@
 			continue;
 		}
 		atomic_inc(&tbh->b_count);
-		tbh->b_end_io = end_buffer_io_sync;
+		tbh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, tbh);
 	}
 
diff -urN -x '.patch*' -x '*.orig' orig/fs/open.c patched/fs/open.c
--- orig/fs/open.c	2003-01-13 23:58:05.000000000 -0600
+++ patched/fs/open.c	2003-01-24 13:24:26.000000000 -0600
@@ -843,21 +843,41 @@
  */
 int filp_close(struct file *filp, fl_owner_t id)
 {
-	int retval;
+	struct address_space *mapping = filp->f_dentry->d_inode->i_mapping;
+	struct inode	*inode = mapping->host;
+	int retval = 0, err;
+
+	/* Report and clear outstanding errors */
+	err = filp->f_error;
+	if (err) {
+		filp->f_error = 0;
+		retval = err;
+	}
+
+	down(&inode->i_sem);
+	err = mapping->error;
+	if (err && !retval) {
+		mapping->error = 0;
+		retval = err;
+	}
+	up(&inode->i_sem);
 
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
 
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/buffer_head.h patched/include/linux/buffer_head.h
--- orig/include/linux/buffer_head.h	2003-01-24 13:24:21.000000000 -0600
+++ patched/include/linux/buffer_head.h	2003-01-24 13:24:26.000000000 -0600
@@ -136,7 +136,8 @@
 int try_to_free_buffers(struct page *);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
-void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
+void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
+void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
 void buffer_insert_list(spinlock_t *lock,
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/fs.h patched/include/linux/fs.h
--- orig/include/linux/fs.h	2003-01-24 13:24:21.000000000 -0600
+++ patched/include/linux/fs.h	2003-01-24 13:24:26.000000000 -0600
@@ -326,6 +326,7 @@
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	int			error;		/* write error for fsync */
 };
 
 struct char_device {
diff -urN -x '.patch*' -x '*.orig' orig/kernel/ksyms.c patched/kernel/ksyms.c
--- orig/kernel/ksyms.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/kernel/ksyms.c	2003-01-24 13:24:26.000000000 -0600
@@ -176,7 +176,8 @@
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
-EXPORT_SYMBOL(end_buffer_io_sync);
+EXPORT_SYMBOL(end_buffer_read_sync);
+EXPORT_SYMBOL(end_buffer_write_sync);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(init_private_file);
diff -urN -x '.patch*' -x '*.orig' orig/mm/filemap.c patched/mm/filemap.c
--- orig/mm/filemap.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/mm/filemap.c	2003-01-24 13:24:26.000000000 -0600
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
 
diff -urN -x '.patch*' -x '*.orig' orig/mm/vmscan.c patched/mm/vmscan.c
--- orig/mm/vmscan.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/mm/vmscan.c	2003-01-24 13:24:26.000000000 -0600
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

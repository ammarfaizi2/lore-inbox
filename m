Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTA2Fwi>; Wed, 29 Jan 2003 00:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTA2Fwi>; Wed, 29 Jan 2003 00:52:38 -0500
Received: from waste.org ([209.173.204.2]:62894 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265037AbTA2Fwe>;
	Wed, 29 Jan 2003 00:52:34 -0500
Date: Wed, 29 Jan 2003 00:01:42 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Report write errors to applications (resend)
Message-ID: <20030129060134.GZ3186@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, this should apply cleanly to -pre4, please consider it for
inclusion.

As a couple other folks have noted, Linux currently fails to propagate
write errors to userspace, quietly marking pages clean. Write IO
errors are extremely uncommon for most systems, thanks to low-level
sector remapping and the like. but with the increasing use of
networked and hotpluggable storage, new scenarios for IO failure are
appearing.

I've been looking at this a bit and discussing it with Andrew and
Linus and here's what I've come up with.

Basic scenario:

Process dirties page in pagecache via write, mapping, etc.
Reader sees current data in pagecache
Pagecache decides to push page to disk due to memory pressure
 page is locked, marked clean and submitted to block driver via IO layer
  driver reports IO error and ripples failure back to pagecache
   pagecache marks page not uptodate and unlocks page
Process calls fsync which reports success
Next reader sees page not uptodate and refetches old data from disk

Discussion:

First let's address readers seeing old data. Ideally we'd like for
readers not to see the new data and then later see the old data again
- this is likely to confuse applications. To accomplish this, we
either have to not allow other apps to see it before it touches the
disk (which is equivalent to turning off write caching) or we have to
retry the write until we encounter a permanent error. Linus argues
that retries are currently the driver's responsibility and not the
pagecache's, so the error should be treated as permanent. Given that
we're unwilling to turn off write caching, we are therefore forced to
address the old data problem by coordination at the application layer.

This leads us to the second problem: the write IO error isn't reported to
the application layer in any form. The code is currently designed for
handling of errors on read, where the failure of the page to be
uptodate is caught synchronously. Further, the pagecache callback is
not able to determine whether its dealing with a read or write
failure, so we need to use different callbacks for read and write.

Andrew points out that a related problem that can occur here is
ENOSPC. Since most filesystems don't implement proper reservations,
it's possible for a write() to return success while the delayed block
allocation fails. This patch detects that case as well.

Passing these error back to userspace turns out to be tricky. We'd like
to report it on the next fsync/fdatasync/msync or close on a given
filehandle. Unfortunately, by the time we've reached the pagecache,
the filehandle is long forgotten and the best we can do without
crippling the pagecache is report the error for the next sync on the
given inode. This means that multiple writers to the same file might
get their error reporting crossed, but apps doing that should probably
be coordinating their activities anyway.

The obvious places to track this error are in the inode, the mapping,
or in the give page struct's bits. The page bits looked promising at
first because they can be safely handled in interrupt context, but
because pages are taken off the dirty list when they hit the IO layer,
it would require a new list for errored pages or searching through the
entire mapping on fsync, etc.

That leaves us with recording the error in the inode/mapping and clearing it
when we get a chance to report it. The mapping appears to be pinned in
memory at the appropriate places, but we're unable to properly protect
it from concurrent users with the inode semaphore from interrupt
context. 

Does this matter? Probably not. We already have no guarantee that I/O
is completed when we call close() so we're not particularly concerned
with losing the error in a race here. And for the sync variants, we're
waiting for all I/O for the mapping to complete so we're protected
from races there.

Other loose ends:

Linus suggested that errors could be reported on the next write(),
similar to sockets. I think this would confuse a lot of applications
into thinking the current write failed and not the previous and the
few that would expect it would already be using sync.

This problem doesn't affect writes via rawio or O_DIRECT, but it does
affect metadata stored in the pagecache by filesystems, which are
probably unprepared for dealing with write errors. So if you encounter
IO errors on write, there's currently a fair chance that you'll end up
with a corrupted filesystem. 

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

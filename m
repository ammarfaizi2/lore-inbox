Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTAJQ2T>; Fri, 10 Jan 2003 11:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTAJQ2S>; Fri, 10 Jan 2003 11:28:18 -0500
Received: from waste.org ([209.173.204.2]:50121 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265277AbTAJQ1w>;
	Fri, 10 Jan 2003 11:27:52 -0500
Date: Fri, 10 Jan 2003 10:36:34 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC/CFT 2.4] The trouble with write errors
Message-ID: <20030110163634.GF14778@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a couple other folks have noted, Linux currently fails to propagate
write errors to userspace, quietly marking page clean. Write IO errors
are extremely uncommon for most systems, thanks to low-level sector
remapping and the like, but with the increasing use of networked and
hotpluggable storage, new scenarios for IO failure are appearing.

I've been looking at this a bit and discussing it with Andrew and
Linus and here's what I've come up with. This patch is against
2.4.21-pre3 and works nicely for all the cases I've tested it with.
I'll whip up a 2.5 version once I get some thoughts on this.

Basic scenario:

Process dirties page in pagecache via write, mapping, etc.
Reader sees current data in pagecache
Pagecache decides to push page to disk due to memory pressure
 page is locked, marked clean and submitted to block driver via IO layer
  driver reports IO error and ripples failure back to pagecache
   pagecache marks page not uptodate and unlocks page
Process calls fsync which reports success
Next reader sees page not uptodate and refetches old data from disk

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
with a corrupted filesystem, with or without this patch.


diff -urN -x '.patch*' -x '*.orig' orig/drivers/block/ll_rw_blk.c patched/drivers/block/ll_rw_blk.c
--- orig/drivers/block/ll_rw_blk.c	2003-01-09 13:13:18.000000000 -0600
+++ patched/drivers/block/ll_rw_blk.c	2003-01-09 13:15:06.000000000 -0600
@@ -1282,10 +1282,10 @@
 
 		/* We have the buffer lock */
 		atomic_inc(&bh->b_count);
-		bh->b_end_io = end_buffer_io_sync;
 
 		switch(rw) {
 		case WRITE:
+			bh->b_end_io = end_buffer_write_sync;
 			if (!atomic_set_buffer_clean(bh))
 				/* Hmmph! Nothing to write */
 				goto end_io;
@@ -1294,6 +1294,7 @@
 
 		case READA:
 		case READ:
+			bh->b_end_io = end_buffer_read_sync;
 			if (buffer_uptodate(bh))
 				/* Hmmph! Already have it */
 				goto end_io;
diff -urN -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
--- orig/fs/buffer.c	2003-01-09 13:13:33.000000000 -0600
+++ patched/fs/buffer.c	2003-01-09 13:15:06.000000000 -0600
@@ -168,13 +168,30 @@
  * Default synchronous end-of-IO handler..  Just mark it up-to-date and
  * unlock the buffer. This is what ll_rw_block uses too.
  */
-void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
 	mark_buffer_uptodate(bh, uptodate);
 	unlock_buffer(bh);
 	put_bh(bh);
 }
 
+void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
+{
+	mark_buffer_uptodate(bh, uptodate);
+
+	/* Flag failed writes for late fsync/msync */
+	if (!uptodate)
+	{
+		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
+		       kdevname(bh->b_dev));
+		/* mapping is pinned by PG_locked */
+		bh->b_page->mapping->error=-EIO;
+	}
+
+	unlock_buffer(bh);
+	put_bh(bh);
+}
+
 /*
  * The buffers have been marked clean and locked.  Just submit the dang
  * things.. 
@@ -183,7 +200,7 @@
 {
 	do {
 		struct buffer_head * bh = *array++;
-		bh->b_end_io = end_buffer_io_sync;
+		bh->b_end_io = end_buffer_write_sync;
 		submit_bh(WRITE, bh);
 	} while (--count);
 }
@@ -751,7 +768,12 @@
 	page = bh->b_page;
 
 	if (!uptodate)
+	{
+		printk(KERN_WARNING "lost async page write due to I/O error on %s\n",
+		       kdevname(bh->b_dev));
+		bh->b_page->mapping->error=-EIO;
 		SetPageError(page);
+	}
 
 	/*
 	 * Be _very_ careful from here on. Bad things can happen if
@@ -2608,7 +2630,7 @@
 
 		__mark_buffer_clean(bh);
 		get_bh(bh);
-		bh->b_end_io = end_buffer_io_sync;
+		bh->b_end_io = end_buffer_write_sync;
 		submit_bh(WRITE, bh);
 		tryagain = 0;
 	} while ((bh = bh->b_this_page) != head);
diff -urN -x '.patch*' -x '*.orig' orig/fs/inode.c patched/fs/inode.c
--- orig/fs/inode.c	2003-01-09 13:13:33.000000000 -0600
+++ patched/fs/inode.c	2003-01-09 13:17:41.000000000 -0600
@@ -115,6 +115,7 @@
 		mapping->a_ops = &empty_aops;
 		mapping->host = inode;
 		mapping->gfp_mask = GFP_HIGHUSER;
+		mapping->error = 0;
 		inode->i_mapping = mapping;
 	}
 	return inode;
diff -urN -x '.patch*' -x '*.orig' orig/fs/open.c patched/fs/open.c
--- orig/fs/open.c	2002-11-28 17:53:15.000000000 -0600
+++ patched/fs/open.c	2003-01-09 13:15:06.000000000 -0600
@@ -829,21 +829,41 @@
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
 
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/fs.h patched/include/linux/fs.h
--- orig/include/linux/fs.h	2003-01-09 13:13:37.000000000 -0600
+++ patched/include/linux/fs.h	2003-01-09 13:15:06.000000000 -0600
@@ -410,6 +410,7 @@
 	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
 	int			gfp_mask;	/* how to allocate the pages */
+	int			error;		/* write error for fsync */
 };
 
 struct char_device {
@@ -1127,7 +1128,8 @@
 extern int FASTCALL(try_to_free_buffers(struct page *, unsigned int));
 extern void refile_buffer(struct buffer_head * buf);
 extern void create_empty_buffers(struct page *, kdev_t, unsigned long);
-extern void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
+extern void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
+extern void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 
 /* reiserfs_writepage needs this */
 extern void set_buffer_async_io(struct buffer_head *bh) ;
diff -urN -x '.patch*' -x '*.orig' orig/mm/filemap.c patched/mm/filemap.c
--- orig/mm/filemap.c	2003-01-09 13:13:39.000000000 -0600
+++ patched/mm/filemap.c	2003-01-09 13:15:06.000000000 -0600
@@ -492,7 +492,7 @@
 		page_cache_release(page);
 	}
 	spin_unlock(&pagecache_lock);
-
+out:
 	return retval;
 }
 
@@ -587,6 +587,14 @@
 		spin_lock(&pagecache_lock);
 	}
 	spin_unlock(&pagecache_lock);
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
--- orig/mm/vmscan.c	2002-11-28 17:53:15.000000000 -0600
+++ patched/mm/vmscan.c	2003-01-09 13:15:06.000000000 -0600
@@ -400,15 +400,21 @@
 			 * so the direct writes to the page cannot get lost.
 			 */
 			int (*writepage)(struct page *);
+			struct address_space *mapping = page->mapping;
 
-			writepage = page->mapping->a_ops->writepage;
+			writepage = mapping->a_ops->writepage;
 			if ((gfp_mask & __GFP_FS) && writepage) {
+				int err;
+
 				ClearPageDirty(page);
 				SetPageLaunder(page);
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
 
-				writepage(page);
+				err = writepage(page);
+				if (err)
+					mapping->error = err;
+
 				page_cache_release(page);
 
 				spin_lock(&pagemap_lru_lock);



-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

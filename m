Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTBSX75>; Wed, 19 Feb 2003 18:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTBSX75>; Wed, 19 Feb 2003 18:59:57 -0500
Received: from waste.org ([209.173.204.2]:62680 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262780AbTBSX7u>;
	Wed, 19 Feb 2003 18:59:50 -0500
Date: Wed, 19 Feb 2003 18:09:45 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Khoa Huynh <khoa@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: [CFT] Re: Status of write error patch ?
Message-ID: <20030220000945.GY28107@waste.org>
References: <OF6DA624A8.9F2DEF0A-ON85256CD2.00705B8A@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6DA624A8.9F2DEF0A-ON85256CD2.00705B8A@pok.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc:ed back to Linux-kernel in case anyone else wants to give these a spin]

On Wed, Feb 19, 2003 at 02:36:18PM -0600, Khoa Huynh wrote:
> 
> Oliver Xymoron <oxymoron@waste.org> wrote:
> 
> > > If IBM folks (currently the only other people to express any interest
> in this)
> > > can devote some effort to testing the 2.5 version, things might move
> along more
> > > quickly, otherwise this could take a while.
> 
> Thanks for all of the info and status update....
> 
> What kind of testing do you need for this patch?  We certainly can help if
> possible.  Would running the kernel with this patch under the LTP
> (Linux Test Project) be sufficient?  I guess we can also test it with
> simulated error conditions using NAS devices as well...

Testing should cover:

 - proper return of EIO for failed writes to fsync/msync/fclose for
    - writes via write()
    - writes via mmap()
    - forced out by memory pressure
    - forced out by fsync

I've already done this, but it could use additional banging on.

 - reporting ENOSPC for filling in holes in mappings to fsync/msync

Andrew's done some of this.

 - no errors reported for normal usage and racing FS loads for multiple
   filesystems
   (I've had to touch the corner case checking for the generic VFS,
   CIFS, NFS, NTFS, Reiser, and SMBFS so that they don't report
   spurious IO errors when racing with truncate)
 
> Can you send me the latest version of the patch for 2.5 ?

Appended. I've just rediffed and compiled these against 2.5.62-mm1, Andrew feel
free to give these a whirl.
 
> Actually, we are more interested in getting the patch into the 2.4 kernel.
> All of the Linux distributions are currently using 2.4 kernel, and our
> storage products need to work properly using current Linux distributions
> with 2.4 kernel.  Are there any problems with the patch for 2.4 ?  Can
> you send me the latest version for 2.4 (if any) ?

While I was initially aiming to push a simpler version of the current
fix to 2.4, I've decided it needs to go to 2.5 first. Once it makes it
into mainline 2.5, pushing the backport to 2.4 should be easier. 

diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/buffer.c work/fs/buffer.c
--- orig/fs/buffer.c	2003-02-17 10:32:39.000000000 -0600
+++ work/fs/buffer.c	2003-02-17 10:32:53.000000000 -0600
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
@@ -2548,8 +2563,10 @@
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
@@ -2609,13 +2626,14 @@
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
@@ -2636,7 +2654,7 @@
 	lock_buffer(bh);
 	if (test_clear_buffer_dirty(bh)) {
 		get_bh(bh);
-		bh->b_end_io = end_buffer_io_sync;
+		bh->b_end_io = end_buffer_write_sync;
 		submit_bh(WRITE, bh);
 		wait_on_buffer(bh);
 	} else {
@@ -2695,6 +2713,8 @@
 	bh = head;
 	do {
 		check_ttfb_buffer(page, bh);
+		if (buffer_write_io_error(bh))
+			page->mapping->error = -EIO;
 		if (buffer_busy(bh))
 			goto failed;
 		if (!buffer_uptodate(bh) && !buffer_req(bh))
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/inode.c work/fs/inode.c
--- orig/fs/inode.c	2003-02-11 11:12:26.000000000 -0600
+++ work/fs/inode.c	2003-02-17 10:32:53.000000000 -0600
@@ -134,6 +134,7 @@
 		mapping->dirtied_when = 0;
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+		mapping->error = 0;
 		if (sb->s_bdev)
 			inode->i_data.backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/mpage.c work/fs/mpage.c
--- orig/fs/mpage.c	2003-02-11 11:12:26.000000000 -0600
+++ work/fs/mpage.c	2003-02-17 10:32:53.000000000 -0600
@@ -388,6 +388,7 @@
 mpage_writepage(struct bio *bio, struct page *page, get_block_t get_block,
 	sector_t *last_block_in_bio, int *ret, struct writeback_control *wbc)
 {
+	struct address_space *mapping = page->mapping;
 	struct inode *inode = page->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
 	unsigned long end_index;
@@ -562,6 +563,17 @@
 	if (bio)
 		bio = mpage_bio_submit(WRITE, bio);
 	*ret = page->mapping->a_ops->writepage(page, wbc);
+	if (*ret < 0) {
+		/*
+		 * lock the page to keep truncate away
+		 * then check that it is still on the
+		 * mapping.
+		 */
+		lock_page(page);
+		if (page->mapping == mapping)
+			mapping->error = *ret;
+		unlock_page(page);
+	}
 out:
 	return bio;
 }
@@ -665,6 +677,17 @@
 					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page, wbc);
+				if (ret < 0) {
+					/*
+					 * lock the page to keep truncate away
+					 * then check that it is still on the
+					 * mapping.
+					 */
+					lock_page(page);
+					if (page->mapping == mapping)
+						mapping->error = ret;
+					unlock_page(page);
+				}
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
 					&last_block_in_bio, &ret, wbc);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/ntfs/compress.c work/fs/ntfs/compress.c
--- orig/fs/ntfs/compress.c	2003-01-16 20:22:13.000000000 -0600
+++ work/fs/ntfs/compress.c	2003-02-17 10:32:53.000000000 -0600
@@ -598,7 +598,7 @@
 			continue;
 		}
 		atomic_inc(&tbh->b_count);
-		tbh->b_end_io = end_buffer_io_sync;
+		tbh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, tbh);
 	}
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/open.c work/fs/open.c
--- orig/fs/open.c	2003-01-16 20:21:37.000000000 -0600
+++ work/fs/open.c	2003-02-17 10:32:53.000000000 -0600
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
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/buffer_head.h work/include/linux/buffer_head.h
--- orig/include/linux/buffer_head.h	2003-02-17 09:59:32.000000000 -0600
+++ work/include/linux/buffer_head.h	2003-02-17 10:32:53.000000000 -0600
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
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/fs.h work/include/linux/fs.h
--- orig/include/linux/fs.h	2003-02-17 10:32:40.000000000 -0600
+++ work/include/linux/fs.h	2003-02-17 10:32:53.000000000 -0600
@@ -326,6 +326,7 @@
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	int			error;		/* write error for fsync */
 };
 
 struct char_device {
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/kernel/ksyms.c work/kernel/ksyms.c
--- orig/kernel/ksyms.c	2003-02-17 10:32:40.000000000 -0600
+++ work/kernel/ksyms.c	2003-02-17 10:32:53.000000000 -0600
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
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/filemap.c work/mm/filemap.c
--- orig/mm/filemap.c	2003-02-17 10:32:40.000000000 -0600
+++ work/mm/filemap.c	2003-02-17 10:32:53.000000000 -0600
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
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/vmscan.c work/mm/vmscan.c
--- orig/mm/vmscan.c	2003-02-17 10:32:40.000000000 -0600
+++ work/mm/vmscan.c	2003-02-17 10:32:53.000000000 -0600
@@ -342,6 +342,20 @@
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
 
+				if (res < 0) {
+					/*
+					 * lock the page to keep truncate away
+					 * then check that it is still on the
+					 * mapping.
+					 */
+					lock_page(page);
+					if (page->mapping == mapping)
+						mapping->error = res;
+					unlock_page(page);
+				}
+				if (res < 0) {
+					mapping->error = res;
+				}
 				if (res == WRITEPAGE_ACTIVATE) {
 					ClearPageReclaim(page);
 					goto activate_locked;


diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/buffer.c work/fs/buffer.c
--- orig/fs/buffer.c	2003-02-19 17:44:14.000000000 -0600
+++ work/fs/buffer.c	2003-02-19 17:44:14.000000000 -0600
@@ -2509,7 +2509,7 @@
 		 */
 		block_invalidatepage(page, 0);
 		unlock_page(page);
-		return -EIO;
+		return 0; /* don't care */
 	}
 
 	/*
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/cifs/file.c work/fs/cifs/file.c
--- orig/fs/cifs/file.c	2003-02-19 17:38:03.000000000 -0600
+++ work/fs/cifs/file.c	2003-02-19 17:44:14.000000000 -0600
@@ -386,13 +386,19 @@
 	offset += (loff_t)from;
 	write_data += from;
 
-	if((to > PAGE_CACHE_SIZE) || (from > to) || (offset > mapping->host->i_size)) {
+	if((to > PAGE_CACHE_SIZE) || (from > to)) {
 		FreeXid(xid);
 		return -EIO;
 	}
 
+	/* racing with truncate? */
+	if(offset > mapping->host->i_size) {
+		FreeXid(xid);
+		return 0; /* don't care */
+	}
+
 	/* check to make sure that we are not extending the file */
-    if(mapping->host->i_size - offset < (loff_t)to)
+	if(mapping->host->i_size - offset < (loff_t)to)
 		to = (unsigned)(mapping->host->i_size - offset); 
 		
 
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/nfs/write.c work/fs/nfs/write.c
--- orig/fs/nfs/write.c	2003-02-19 17:44:04.000000000 -0600
+++ work/fs/nfs/write.c	2003-02-19 17:44:14.000000000 -0600
@@ -231,7 +231,7 @@
 	struct inode *inode = page->mapping->host;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
-	int err = -EIO;
+	int err = 0;
 	int flags_save;
 
 	flags_save = current->flags;
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/ntfs/aops.c work/fs/ntfs/aops.c
--- orig/fs/ntfs/aops.c	2003-01-16 20:22:28.000000000 -0600
+++ work/fs/ntfs/aops.c	2003-02-19 17:44:14.000000000 -0600
@@ -811,8 +811,8 @@
 	if (unlikely(page->index >= (vi->i_size + PAGE_CACHE_SIZE - 1) >>
 			PAGE_CACHE_SHIFT)) {
 		unlock_page(page);
-		ntfs_debug("Write outside i_size. Returning i/o error.");
-		return -EIO;
+		ntfs_debug("Write outside i_size - truncated?");
+		return 0;
 	}
 
 	ni = NTFS_I(vi);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/reiserfs/inode.c work/fs/reiserfs/inode.c
--- orig/fs/reiserfs/inode.c	2003-02-19 17:44:04.000000000 -0600
+++ work/fs/reiserfs/inode.c	2003-02-19 17:44:14.000000000 -0600
@@ -2036,8 +2036,8 @@
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
-	    error =  -EIO ;
-	    goto fail ;
+	    error = 0 ;
+	    goto done ;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/smbfs/file.c work/fs/smbfs/file.c
--- orig/fs/smbfs/file.c	2003-01-16 20:22:42.000000000 -0600
+++ work/fs/smbfs/file.c	2003-02-19 17:44:14.000000000 -0600
@@ -193,7 +193,7 @@
 	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
 	/* OK, are we completely out? */
 	if (page->index >= end_index+1 || !offset)
-		return -EIO;
+		return 0; /* truncated - don't care */
 do_it:
 	page_cache_get(page);
 	err = smb_writepage_sync(inode, page, 0, offset);


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

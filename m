Return-Path: <linux-kernel-owner+w=401wt.eu-S932098AbXACUow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXACUow (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbXACUow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:44:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48491 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098AbXACUov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:44:51 -0500
Date: Wed, 3 Jan 2007 12:44:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] Export invalidate_mapping_pages() to modules.
Message-Id: <20070103124436.05128698.akpm@osdl.org>
In-Reply-To: <20070103201123.GA1097@infradead.org>
References: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk>
	<1167830972.3095.3.camel@laptopd505.fenrus.org>
	<20070103110332.ba3d39a2.akpm@osdl.org>
	<20070103201123.GA1097@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 20:11:23 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jan 03, 2007 at 11:03:32AM -0800, Andrew Morton wrote:
> > It makes no sense to me to export invalidate_inode_pages() and not
> > invalidate_mapping_pages() and I actually need invalidate_mapping_pages()
> > because of its range specification ability...
> > 
> > akpm: also remove the export of invalidate_inode_pages() by making it an
> > inlined wrapper.
> 
> What about just killing invalidate_inode_pages()?  It only has about
> a dozend callers, and it's already rather misnamed since it actually
> operates on an address_space, not an inode.

spoze so.  Like this?


From: Andrew Morton <akpm@osdl.org>

Convert all calls to invalidate_inode_pages() into open-coded calls to
invalidate_mapping_pages().

Leave the invalidate_inode_pages() wrapper in place for now, marked as
deprecated.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/md/bitmap.c               |    2 +-
 drivers/mtd/devices/block2mtd.c   |    3 ++-
 drivers/usb/gadget/file_storage.c |    2 +-
 fs/9p/vfs_file.c                  |    4 ++--
 fs/buffer.c                       |    2 +-
 fs/drop_caches.c                  |    2 +-
 fs/fuse/file.c                    |    2 +-
 fs/fuse/inode.c                   |    2 +-
 fs/inode.c                        |    3 ++-
 fs/jffs/inode-v23.c               |    4 ++--
 include/linux/fs.h                |    4 ++--
 mm/truncate.c                     |    4 ++--
 12 files changed, 18 insertions(+), 16 deletions(-)

diff -puN drivers/md/bitmap.c~remove-invalidate_inode_pages drivers/md/bitmap.c
--- a/drivers/md/bitmap.c~remove-invalidate_inode_pages
+++ a/drivers/md/bitmap.c
@@ -663,7 +663,7 @@ static void bitmap_file_put(struct bitma
 
 	if (file) {
 		struct inode *inode = file->f_path.dentry->d_inode;
-		invalidate_inode_pages(inode->i_mapping);
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		fput(file);
 	}
 }
diff -puN drivers/mtd/devices/block2mtd.c~remove-invalidate_inode_pages drivers/mtd/devices/block2mtd.c
--- a/drivers/mtd/devices/block2mtd.c~remove-invalidate_inode_pages
+++ a/drivers/mtd/devices/block2mtd.c
@@ -278,7 +278,8 @@ static void block2mtd_free_device(struct
 	kfree(dev->mtd.name);
 
 	if (dev->blkdev) {
-		invalidate_inode_pages(dev->blkdev->bd_inode->i_mapping);
+		invalidate_mapping_pages(dev->blkdev->bd_inode->i_mapping,
+					0, -1);
 		close_bdev_excl(dev->blkdev);
 	}
 
diff -puN drivers/usb/gadget/file_storage.c~remove-invalidate_inode_pages drivers/usb/gadget/file_storage.c
--- a/drivers/usb/gadget/file_storage.c~remove-invalidate_inode_pages
+++ a/drivers/usb/gadget/file_storage.c
@@ -1953,7 +1953,7 @@ static void invalidate_sub(struct lun *c
 	struct inode	*inode = filp->f_path.dentry->d_inode;
 	unsigned long	rc;
 
-	rc = invalidate_inode_pages(inode->i_mapping);
+	rc = invalidate_mapping_pages(inode->i_mapping, 0, -1);
 	VLDBG(curlun, "invalidate_inode_pages -> %ld\n", rc);
 }
 
diff -puN fs/9p/vfs_file.c~remove-invalidate_inode_pages fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c~remove-invalidate_inode_pages
+++ a/fs/9p/vfs_file.c
@@ -143,7 +143,7 @@ static int v9fs_file_lock(struct file *f
 
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
-		invalidate_inode_pages(&inode->i_data);
+		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 
 	return res;
@@ -267,7 +267,7 @@ v9fs_file_write(struct file *filp, const
 		total += result;
 	} while (count);
 
-		invalidate_inode_pages2(inode->i_mapping);
+	invalidate_inode_pages2(inode->i_mapping);
 	return total;
 }
 
diff -puN fs/buffer.c~remove-invalidate_inode_pages fs/buffer.c
--- a/fs/buffer.c~remove-invalidate_inode_pages
+++ a/fs/buffer.c
@@ -345,7 +345,7 @@ void invalidate_bdev(struct block_device
 	 * We really want to use invalidate_inode_pages2() for
 	 * that, but not until that's cleaned up.
 	 */
-	invalidate_inode_pages(mapping);
+	invalidate_mapping_pages(mapping, 0, -1);
 }
 
 /*
diff -puN fs/drop_caches.c~remove-invalidate_inode_pages fs/drop_caches.c
--- a/fs/drop_caches.c~remove-invalidate_inode_pages
+++ a/fs/drop_caches.c
@@ -20,7 +20,7 @@ static void drop_pagecache_sb(struct sup
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		if (inode->i_state & (I_FREEING|I_WILL_FREE))
 			continue;
-		invalidate_inode_pages(inode->i_mapping);
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 	}
 	spin_unlock(&inode_lock);
 }
diff -puN fs/fuse/file.c~remove-invalidate_inode_pages fs/fuse/file.c
--- a/fs/fuse/file.c~remove-invalidate_inode_pages
+++ a/fs/fuse/file.c
@@ -69,7 +69,7 @@ void fuse_finish_open(struct inode *inod
 	if (outarg->open_flags & FOPEN_DIRECT_IO)
 		file->f_op = &fuse_direct_io_file_operations;
 	if (!(outarg->open_flags & FOPEN_KEEP_CACHE))
-		invalidate_inode_pages(inode->i_mapping);
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 	ff->fh = outarg->fh;
 	file->private_data = ff;
 }
diff -puN fs/fuse/inode.c~remove-invalidate_inode_pages fs/fuse/inode.c
--- a/fs/fuse/inode.c~remove-invalidate_inode_pages
+++ a/fs/fuse/inode.c
@@ -112,7 +112,7 @@ void fuse_change_attributes(struct inode
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	if (S_ISREG(inode->i_mode) && i_size_read(inode) != attr->size)
-		invalidate_inode_pages(inode->i_mapping);
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 
 	inode->i_ino     = attr->ino;
 	inode->i_mode    = (inode->i_mode & S_IFMT) + (attr->mode & 07777);
diff -puN fs/inode.c~remove-invalidate_inode_pages fs/inode.c
--- a/fs/inode.c~remove-invalidate_inode_pages
+++ a/fs/inode.c
@@ -414,7 +414,8 @@ static void prune_icache(int nr_to_scan)
 			__iget(inode);
 			spin_unlock(&inode_lock);
 			if (remove_inode_buffers(inode))
-				reap += invalidate_inode_pages(&inode->i_data);
+				reap += invalidate_mapping_pages(&inode->i_data,
+								0, -1);
 			iput(inode);
 			spin_lock(&inode_lock);
 
diff -puN fs/jffs/inode-v23.c~remove-invalidate_inode_pages fs/jffs/inode-v23.c
--- a/fs/jffs/inode-v23.c~remove-invalidate_inode_pages
+++ a/fs/jffs/inode-v23.c
@@ -296,7 +296,7 @@ jffs_setattr(struct dentry *dentry, stru
 		inode->i_blocks = (inode->i_size + 511) >> 9;
 
 		if (len) {
-			invalidate_inode_pages(inode->i_mapping);
+			invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		}
 		inode->i_ctime = CURRENT_TIME_SEC;
 		inode->i_mtime = inode->i_ctime;
@@ -1518,7 +1518,7 @@ jffs_file_write(struct file *filp, const
 	}
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
-	invalidate_inode_pages(inode->i_mapping);
+	invalidate_mapping_pages(inode->i_mapping, 0, -1);
 
  out_isem:
 	return err;
diff -puN include/linux/fs.h~remove-invalidate_inode_pages include/linux/fs.h
--- a/include/linux/fs.h~remove-invalidate_inode_pages
+++ a/include/linux/fs.h
@@ -1573,7 +1573,7 @@ extern int invalidate_inodes(struct supe
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
-static inline unsigned long
+static inline unsigned long __deprecated
 invalidate_inode_pages(struct address_space *mapping)
 {
 	return invalidate_mapping_pages(mapping, 0, ~0UL);
@@ -1583,7 +1583,7 @@ static inline void invalidate_remote_ino
 {
 	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode))
-		invalidate_inode_pages(inode->i_mapping);
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 }
 extern int invalidate_inode_pages2(struct address_space *mapping);
 extern int invalidate_inode_pages2_range(struct address_space *mapping,
diff -puN mm/truncate.c~remove-invalidate_inode_pages mm/truncate.c
--- a/mm/truncate.c~remove-invalidate_inode_pages
+++ a/mm/truncate.c
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(cancel_dirty_page);
  *
  * We need to bale out if page->mapping is no longer equal to the original
  * mapping.  This happens a) when the VM reclaimed the page while we waited on
- * its lock, b) when a concurrent invalidate_inode_pages got there first and
+ * its lock, b) when a concurrent invalidate_mapping_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
  */
 static void
@@ -99,7 +99,7 @@ truncate_complete_page(struct address_sp
 }
 
 /*
- * This is for invalidate_inode_pages().  That function can be called at
+ * This is for invalidate_mapping_pages().  That function can be called at
  * any time, and is not supposed to throw away dirty pages.  But pages can
  * be marked dirty at any time too, so use remove_mapping which safely
  * discards clean, unused pages.
_


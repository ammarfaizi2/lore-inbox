Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272623AbTHBETX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 00:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272627AbTHBETX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 00:19:23 -0400
Received: from waste.org ([209.173.204.2]:35243 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272623AbTHBES1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 00:18:27 -0400
Date: Fri, 1 Aug 2003 23:18:23 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2/3] writes: use flags in address space
Message-ID: <20030802041823.GB22824@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

Combine mapping->error and ->gfp_mask into ->flags

diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/drivers/block/loop.c patched/drivers/block/loop.c
--- orig/drivers/block/loop.c	2003-07-13 22:34:42.000000000 -0500
+++ patched/drivers/block/loop.c	2003-07-31 11:45:45.000000000 -0500
@@ -727,8 +727,9 @@
 		fput(file);
 		goto out_putf;
 	}
-	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
-	inode->i_mapping->gfp_mask &= ~(__GFP_IO|__GFP_FS);
+	lo->old_gfp_mask = mapping_gfp_mask(inode->i_mapping);
+	mapping_set_gfp_mask(inode->i_mapping, 
+			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
 	set_blocksize(bdev, lo_blocksize);
 
@@ -845,7 +846,7 @@
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
 	invalidate_bdev(bdev, 0);
 	set_capacity(disks[lo->lo_number], 0);
-	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
+	mapping_set_gfp_mask(filp->f_dentry->d_inode->i_mapping, gfp);
 	lo->lo_state = Lo_unbound;
 	fput(filp);
 	/* This is safe: open() is still holding a reference. */
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/block_dev.c patched/fs/block_dev.c
--- orig/fs/block_dev.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/fs/block_dev.c	2003-07-31 11:45:45.000000000 -0500
@@ -320,7 +320,7 @@
 			inode->i_rdev = kdev;
 			inode->i_bdev = new_bdev;
 			inode->i_data.a_ops = &def_blk_aops;
-			inode->i_data.gfp_mask = GFP_USER;
+			mapping_set_gfp_mask(&inode->i_data, GFP_USER);
 			inode->i_data.backing_dev_info = &default_backing_dev_info;
 			spin_lock(&bdev_lock);
 			bdev = bdfind(dev, head);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
--- orig/fs/buffer.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/fs/buffer.c	2003-07-31 11:45:45.000000000 -0500
@@ -604,7 +604,7 @@
 		buffer_io_error(bh);
 		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
 		       bdevname(bh->b_bdev, b));
-		page->mapping->error = -EIO;
+		set_bit(AS_EIO, &page->mapping->flags);
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}
@@ -2862,7 +2862,7 @@
 	do {
 		check_ttfb_buffer(page, bh);
 		if (buffer_write_io_error(bh))
-			page->mapping->error = -EIO;
+			set_bit(AS_EIO, &page->mapping->flags);
 		if (buffer_busy(bh))
 			goto failed;
 		if (!buffer_uptodate(bh) && !buffer_req(bh))
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/inode.c patched/fs/inode.c
--- orig/fs/inode.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/fs/inode.c	2003-07-31 11:45:45.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/hash.h>
 #include <linux/swap.h>
 #include <linux/security.h>
+#include <linux/pagemap.h>
 #include <linux/cdev.h>
 
 /*
@@ -141,11 +142,11 @@
 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
-		mapping->gfp_mask = GFP_HIGHUSER;
+		mapping->flags = 0;
+		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
 		mapping->dirtied_when = 0;
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
-		mapping->error = 0;
 		if (sb->s_bdev)
 			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/jfs/inode.c patched/fs/jfs/inode.c
--- orig/fs/jfs/inode.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/fs/jfs/inode.c	2003-07-31 11:45:45.000000000 -0500
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/mpage.h>
 #include <linux/buffer_head.h>
+#include <linux/pagemap.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_imap.h"
@@ -51,7 +52,7 @@
 		inode->i_op = &jfs_dir_inode_operations;
 		inode->i_fop = &jfs_dir_operations;
 		inode->i_mapping->a_ops = &jfs_aops;
-		inode->i_mapping->gfp_mask = GFP_NOFS;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (S_ISLNK(inode->i_mode)) {
 		if (inode->i_size >= IDATASIZE) {
 			inode->i_op = &page_symlink_inode_operations;
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/jfs/jfs_imap.c patched/fs/jfs/jfs_imap.c
--- orig/fs/jfs/jfs_imap.c	2003-07-13 22:30:48.000000000 -0500
+++ patched/fs/jfs/jfs_imap.c	2003-07-31 11:45:45.000000000 -0500
@@ -43,6 +43,7 @@
 
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
+#include <linux/pagemap.h>
 
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
@@ -504,7 +505,7 @@
 	}
 
 	ip->i_mapping->a_ops = &jfs_aops;
-	ip->i_mapping->gfp_mask = GFP_NOFS;
+	mapping_set_gfp_mask(ip->i_mapping, GFP_NOFS);
 
 	if ((inum == FILESYSTEM_I) && (JFS_IP(ip)->ipimap == sbi->ipaimap)) {
 		sbi->gengen = le32_to_cpu(dp->di_gengen);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/jfs/namei.c patched/fs/jfs/namei.c
--- orig/fs/jfs/namei.c	2003-07-13 22:36:44.000000000 -0500
+++ patched/fs/jfs/namei.c	2003-07-31 11:45:45.000000000 -0500
@@ -258,7 +258,7 @@
 	ip->i_op = &jfs_dir_inode_operations;
 	ip->i_fop = &jfs_dir_operations;
 	ip->i_mapping->a_ops = &jfs_aops;
-	ip->i_mapping->gfp_mask = GFP_NOFS;
+	mapping_set_gfp_mask(ip->i_mapping, GFP_NOFS);
 
 	insert_inode_hash(ip);
 	mark_inode_dirty(ip);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/mpage.c patched/fs/mpage.c
--- orig/fs/mpage.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/fs/mpage.c	2003-07-31 11:45:45.000000000 -0500
@@ -570,8 +570,12 @@
 		 * mapping.
 		 */
 		lock_page(page);
-		if (page->mapping == mapping)
-			mapping->error = *ret;
+		if (page->mapping == mapping) {
+			if (*ret == -EIO)
+				set_bit(AS_EIO, &mapping->flags);
+			else if (*ret == -ENOSPC)
+				set_bit(AS_ENOSPC, &mapping->flags);
+		}
 		unlock_page(page);
 	}
 out:
@@ -682,8 +686,12 @@
 					 * mapping.
 					 */
 					lock_page(page);
-					if (page->mapping == mapping)
-						mapping->error = ret;
+					if (page->mapping == mapping) {
+						if (ret == -EIO)
+							set_bit(AS_EIO, &mapping->flags);
+						else if (ret == -ENOSPC)
+							set_bit(AS_ENOSPC, &mapping->flags);
+					}
 					unlock_page(page);
 				}
 			} else {
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/open.c patched/fs/open.c
--- orig/fs/open.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/fs/open.c	2003-07-31 11:46:35.000000000 -0500
@@ -21,6 +21,7 @@
 #include <linux/vfs.h>
 #include <asm/uaccess.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 
 int vfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
@@ -954,11 +955,10 @@
 		retval = err;
 	}
 
-	err = mapping->error;
-	if (err && !retval) {
-		mapping->error = 0;
-		retval = err;
-	}
+	if (test_and_clear_bit(AS_ENOSPC, &mapping->flags))
+		retval = -ENOSPC;
+	if (test_and_clear_bit(AS_EIO, &mapping->flags))
+		retval = -EIO;
 
 	if (!file_count(filp)) {
 		printk(KERN_ERR "VFS: Close: file count is 0\n");
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/fs.h patched/include/linux/fs.h
--- orig/include/linux/fs.h	2003-07-31 11:45:47.000000000 -0500
+++ patched/include/linux/fs.h	2003-07-31 11:45:45.000000000 -0500
@@ -327,12 +327,11 @@
 	struct semaphore	i_shared_sem;	/* protect both above lists */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
-	int			gfp_mask;	/* how to allocate the pages */
+	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
-	int			error;		/* write error for fsync */
 };
 
 struct block_device {
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/gfp.h patched/include/linux/gfp.h
--- orig/include/linux/gfp.h	2003-07-13 22:32:28.000000000 -0500
+++ patched/include/linux/gfp.h	2003-07-31 11:45:45.000000000 -0500
@@ -33,6 +33,9 @@
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 
+#define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
+#define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
+
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/include/linux/pagemap.h patched/include/linux/pagemap.h
--- orig/include/linux/pagemap.h	2003-07-31 11:45:47.000000000 -0500
+++ patched/include/linux/pagemap.h	2003-07-31 11:45:45.000000000 -0500
@@ -8,7 +8,30 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
+#include <linux/gfp.h>
+
+/*
+ * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
+ * allocation mode flags.
+ */
+#define	AS_EIO		(__GFP_BITS_SHIFT + 0)	/* IO error on async write */
+#define AS_ENOSPC	(__GFP_BITS_SHIFT + 1)	/* ENOSPC on async write */
+
+static inline int mapping_gfp_mask(struct address_space * mapping)
+{
+	return mapping->flags & __GFP_BITS_MASK;
+}
+
+/*
+ * This is non-atomic.  Only to be used before the mapping is activated.
+ * Probably needs a barrier...
+ */
+static inline void mapping_set_gfp_mask(struct address_space *m, int mask)
+{
+	m->flags = (m->flags & ~__GFP_BITS_MASK) | mask;
+}
 
 /*
  * The page cache can done in larger chunks than
@@ -29,12 +52,12 @@
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask, 0);
+	return alloc_pages(mapping_gfp_mask(x), 0);
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask|__GFP_COLD, 0);
+	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
 }
 
 typedef int filler_t(void *, struct page *);
@@ -56,7 +79,7 @@
  */
 static inline struct page *grab_cache_page(struct address_space *mapping, unsigned long index)
 {
-	return find_or_create_page(mapping, index, mapping->gfp_mask);
+	return find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
 }
 
 extern struct page * grab_cache_page_nowait(struct address_space *mapping,
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/filemap.c patched/mm/filemap.c
--- orig/mm/filemap.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/mm/filemap.c	2003-07-31 11:45:45.000000000 -0500
@@ -199,11 +199,10 @@
 	spin_unlock(&mapping->page_lock);
 
 	/* Check for outstanding write errors */
-	if (mapping->error)
-	{
-		ret = mapping->error;
-		mapping->error = 0;
-	}
+	if (test_and_clear_bit(AS_ENOSPC, &mapping->flags))
+		ret = -ENOSPC;
+	if (test_and_clear_bit(AS_EIO, &mapping->flags))
+		ret = -EIO;
 
 	return ret;
 }
@@ -583,7 +582,7 @@
 		page_cache_release(page);
 		return NULL;
 	}
-	gfp_mask = mapping->gfp_mask & ~__GFP_FS;
+	gfp_mask = mapping_gfp_mask(mapping) & ~__GFP_FS;
 	page = alloc_pages(gfp_mask, 0);
 	if (page && add_to_page_cache_lru(page, mapping, index, gfp_mask)) {
 		page_cache_release(page);
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/shmem.c patched/mm/shmem.c
--- orig/mm/shmem.c	2003-07-13 22:33:41.000000000 -0500
+++ patched/mm/shmem.c	2003-07-31 11:45:45.000000000 -0500
@@ -320,7 +320,7 @@
 		spin_unlock(&sbinfo->stat_lock);
 
 		spin_unlock(&info->lock);
-		page = shmem_dir_alloc(inode->i_mapping->gfp_mask);
+		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
 		if (page) {
 			clear_highpage(page);
 			page->nr_swapped = 0;
diff -urN -x '*.ver' -x '.patch*' -x '*.orig' orig/mm/vmscan.c patched/mm/vmscan.c
--- orig/mm/vmscan.c	2003-07-31 11:45:47.000000000 -0500
+++ patched/mm/vmscan.c	2003-07-31 11:45:45.000000000 -0500
@@ -370,13 +370,14 @@
 					 * mapping.
 					 */
 					lock_page(page);
-					if (page->mapping == mapping)
-						mapping->error = res;
+					if (page->mapping == mapping) {
+						if (res == -EIO)
+							set_bit(AS_EIO, &mapping->flags);
+						else if (res == -ENOSPC)
+							set_bit(AS_ENOSPC, &mapping->flags);
+					}
 					unlock_page(page);
 				}
-				if (res < 0) {
-					mapping->error = res;
-				}
 				if (res == WRITEPAGE_ACTIVATE) {
 					ClearPageReclaim(page);
 					goto activate_locked;

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

----- End forwarded message -----

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

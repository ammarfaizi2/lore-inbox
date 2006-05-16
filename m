Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWEPBNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWEPBNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWEPBNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:13:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:29598 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750931AbWEPBNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:13:20 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 May 2006 11:13:02 +1000
Message-Id: <1060516011302.2711@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Reuben Farrelly <reuben-lkml@reub.net>
Subject: [PATCH 001 of 3] md: Change md/bitmap file handling to use bmap to file blocks-fix
References: <20060516111036.2649.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix problems with new bmap based access to bitmap files.

1/ When not using a file based bitmap, attach a NULL list of buffers
   to each page so the common free_buffer routine can cope.
2/ Use submit_bh to read as well as write, rather than vfs_read.  
   This makes read and write more symetric.
3/ sync the file before reading, to ensure that the page cache has no
   dirty pages that might get written out later.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |   46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2006-05-16 11:09:26.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-05-16 11:09:33.000000000 +1000
@@ -247,6 +247,8 @@ static struct page *read_sb_page(mddev_t
 
 		if (sync_page_io(rdev->bdev, target, PAGE_SIZE, page, READ)) {
 			page->index = index;
+			attach_page_buffers(page, NULL); /* so that free_buffer will
+							  * quietly no-op */
 			return page;
 		}
 	}
@@ -349,11 +351,8 @@ static struct page *read_page(struct fil
 {
 	struct page *page = NULL;
 	struct inode *inode = file->f_dentry->d_inode;
-	loff_t pos = index << PAGE_SHIFT;
-	int ret;
 	struct buffer_head *bh;
 	sector_t block;
-	mm_segment_t oldfs;
 
 	PRINTK("read bitmap file (%dB @ %Lu)\n", (int)PAGE_SIZE,
 			(unsigned long long)index << PAGE_SHIFT);
@@ -364,18 +363,6 @@ static struct page *read_page(struct fil
 	if (IS_ERR(page))
 		goto out;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = vfs_read(file, (char __user*) page_address(page), count, &pos);
-	set_fs(oldfs);
-
-	if (ret >= 0 && ret != count)
-		ret = -EIO;
-	if (ret < 0) {
-		put_page(page);
-		page = ERR_PTR(ret);
-		goto out;
-	}
 	bh = alloc_page_buffers(page, 1<<inode->i_blkbits, 0);
 	if (!bh) {
 		put_page(page);
@@ -403,12 +390,22 @@ static struct page *read_page(struct fil
 
 			bh->b_end_io = end_bitmap_write;
 			bh->b_private = bitmap;
+			atomic_inc(&bitmap->pending_writes);
+			set_buffer_locked(bh);
+			set_buffer_mapped(bh);
+			submit_bh(READ, bh);
 		}
 		block++;
 		bh = bh->b_this_page;
 	}
-
 	page->index = index;
+
+	wait_event(bitmap->write_wait,
+		   atomic_read(&bitmap->pending_writes)==0);
+	if (bitmap->flags & BITMAP_WRITE_ERROR) {
+		free_buffers(page);
+		page = ERR_PTR(-EIO);
+	}
 out:
 	if (IS_ERR(page))
 		printk(KERN_ALERT "md: bitmap read error: (%dB @ %Lu): %ld\n",
@@ -1415,15 +1412,19 @@ int bitmap_create(mddev_t *mddev)
 		return -ENOMEM;
 
 	spin_lock_init(&bitmap->lock);
+	atomic_set(&bitmap->pending_writes, 0);
+	init_waitqueue_head(&bitmap->write_wait);
+
 	bitmap->mddev = mddev;
 
 	bitmap->file = file;
 	bitmap->offset = mddev->bitmap_offset;
-	if (file) get_file(file);
-
-	/* Ensure we read fresh data */
-	invalidate_inode_pages(file->f_dentry->d_inode->i_mapping);
-
+	if (file) {
+		get_file(file);
+		do_sync_file_range(file, 0, LLONG_MAX,
+				   SYNC_FILE_RANGE_WRITE |
+				   SYNC_FILE_RANGE_WAIT_AFTER);
+	}
 	/* read superblock from bitmap file (this sets bitmap->chunksize) */
 	err = bitmap_read_sb(bitmap);
 	if (err)
@@ -1446,9 +1447,6 @@ int bitmap_create(mddev_t *mddev)
 
 	bitmap->syncchunk = ~0UL;
 
-	atomic_set(&bitmap->pending_writes, 0);
-	init_waitqueue_head(&bitmap->write_wait);
-
 #ifdef INJECT_FATAL_FAULT_1
 	bitmap->bp = NULL;
 #else

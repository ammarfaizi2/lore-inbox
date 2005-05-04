Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVEDTl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVEDTl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVEDTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:41:26 -0400
Received: from verein.lst.de ([213.95.11.210]:36076 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261529AbVEDTjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:39:46 -0400
Date: Wed, 4 May 2005 21:39:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove do_sync parameter from __invalidate_device
Message-ID: <20050504193941.GA21713@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the only caller that ever sets it can call fsync_bdev itself easily.
Also update some comments.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: drivers/block/floppy.c
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/drivers/block/floppy.c  (mode:100644 sha1:42dfa281a880f684ba6b187cbb57712f752e6afe)
+++ uncommitted/drivers/block/floppy.c  (mode:100644)
@@ -3345,7 +3345,7 @@
 			struct block_device *bdev = opened_bdev[cnt];
 			if (!bdev || ITYPE(drive_state[cnt].fd_device) != type)
 				continue;
-			__invalidate_device(bdev, 0);
+			__invalidate_device(bdev);
 		}
 		up(&open_lock);
 	} else {
Index: drivers/block/genhd.c
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/drivers/block/genhd.c  (mode:100644 sha1:ab4db71375e08e41c13e4049efe1cd3cef5cbc8a)
+++ uncommitted/drivers/block/genhd.c  (mode:100644)
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
+#include <linux/buffer_head.h>
 
 #define MAX_PROBE_HASH 255	/* random */
 
@@ -676,7 +677,8 @@
 	int res = 0;
 	struct block_device *bdev = bdget_disk(disk, index);
 	if (bdev) {
-		res = __invalidate_device(bdev, 1);
+		fsync_bdev(bdev);
+		res = __invalidate_device(bdev);
 		bdput(bdev);
 	}
 	return res;
Index: fs/inode.c
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/fs/inode.c  (mode:100644 sha1:af8fd78d2099a0852d7867a4b2691924c1ed3982)
+++ uncommitted/fs/inode.c  (mode:100644)
@@ -26,7 +26,6 @@
  * This is needed for the following functions:
  *  - inode_has_buffers
  *  - invalidate_inode_buffers
- *  - fsync_bdev
  *  - invalidate_bdev
  *
  * FIXME: remove all knowledge of the buffer layer from this file
@@ -332,14 +331,6 @@
 	return busy;
 }
 
-/*
- * This is a two-stage process. First we collect all
- * offending inodes onto the throw-away list, and in
- * the second stage we actually dispose of them. This
- * is because we don't want to sleep while messing
- * with the global lists..
- */
- 
 /**
  *	invalidate_inodes	- discard the inodes on a device
  *	@sb: superblock
@@ -366,16 +357,11 @@
 
 EXPORT_SYMBOL(invalidate_inodes);
  
-int __invalidate_device(struct block_device *bdev, int do_sync)
+int __invalidate_device(struct block_device *bdev)
 {
-	struct super_block *sb;
-	int res;
+	struct super_block *sb = get_super(bdev);
+	int res = 0;
 
-	if (do_sync)
-		fsync_bdev(bdev);
-
-	res = 0;
-	sb = get_super(bdev);
 	if (sb) {
 		/*
 		 * no need to lock the super, get_super holds the
@@ -390,7 +376,6 @@
 	invalidate_bdev(bdev, 0);
 	return res;
 }
-
 EXPORT_SYMBOL(__invalidate_device);
 
 static int can_unuse(struct inode *inode)
Index: include/linux/fs.h
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/include/linux/fs.h  (mode:100644 sha1:4edba067a7178103f78544717a91ef98dae7994d)
+++ uncommitted/include/linux/fs.h  (mode:100644)
@@ -1341,7 +1341,7 @@
 
 extern int check_disk_change(struct block_device *);
 extern int invalidate_inodes(struct super_block *);
-extern int __invalidate_device(struct block_device *, int);
+extern int __invalidate_device(struct block_device *);
 extern int invalidate_partition(struct gendisk *, int);
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);

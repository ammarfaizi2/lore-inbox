Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUFWVMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUFWVMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUFWVME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:12:04 -0400
Received: from holomorphy.com ([207.189.100.168]:17029 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266674AbUFWVHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:07:48 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [oom]: [1/4] add __GFP_WIRED to pinned allocations
Message-ID: <0406231407.ZaHbZa1aIbIbKbZa3aHbLb3aYa2a3a5aWaIbWaKb2aYaKb4a4aHbIb3aLb5aHb2a342@holomorphy.com>
In-Reply-To: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
CC: akpm@osdl.org
Date: Wed, 23 Jun 2004 14:07:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.7/include/linux/gfp.h
===================================================================
--- linux-2.6.7.orig/include/linux/gfp.h	2004-06-16 05:19:02.000000000 +0000
+++ linux-2.6.7/include/linux/gfp.h	2004-06-23 16:06:08.000000000 +0000
@@ -37,20 +37,21 @@
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 #define __GFP_COMP	0x4000	/* Add compound page metadata */
+#define __GFP_WIRED	0x8000	/* pinned */
 
 #define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
-			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL|\
+			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_WIRED)
 
-#define GFP_ATOMIC	(__GFP_HIGH)
-#define GFP_NOIO	(__GFP_WAIT)
-#define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
-#define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
+#define GFP_ATOMIC	(__GFP_HIGH | __GFP_WIRED)
+#define GFP_NOIO	(__GFP_WAIT | __GFP_WIRED)
+#define GFP_NOFS	(__GFP_WAIT | __GFP_IO | __GFP_WIRED)
+#define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_WIRED)
+#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_WIRED)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
Index: linux-2.6.7/mm/slab.c
===================================================================
--- linux-2.6.7.orig/mm/slab.c	2004-06-16 05:19:44.000000000 +0000
+++ linux-2.6.7/mm/slab.c	2004-06-23 16:06:08.000000000 +0000
@@ -1709,7 +1709,7 @@
 		return 0;
 
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
-	local_flags = (flags & SLAB_LEVEL_MASK);
+	local_flags = (flags & SLAB_LEVEL_MASK) | __GFP_WIRED;
 	if (!(local_flags & __GFP_WAIT))
 		/*
 		 * Not allowed to sleep.  Need to tell a constructor about
Index: linux-2.6.7/fs/block_dev.c
===================================================================
--- linux-2.6.7.orig/fs/block_dev.c	2004-06-16 05:20:26.000000000 +0000
+++ linux-2.6.7/fs/block_dev.c	2004-06-23 16:06:08.000000000 +0000
@@ -365,7 +365,7 @@
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
 		inode->i_data.a_ops = &def_blk_aops;
-		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
+		mapping_set_gfp_mask(&inode->i_data, GFP_USER & ~__GFP_WIRED);
 		inode->i_data.backing_dev_info = &default_backing_dev_info;
 		spin_lock(&bdev_lock);
 		list_add(&bdev->bd_list, &all_bdevs);
Index: linux-2.6.7/fs/ramfs/inode.c
===================================================================
--- linux-2.6.7.orig/fs/ramfs/inode.c	2004-06-16 05:19:11.000000000 +0000
+++ linux-2.6.7/fs/ramfs/inode.c	2004-06-23 17:33:10.000000000 +0000
@@ -61,6 +61,8 @@
 		inode->i_mapping->a_ops = &ramfs_aops;
 		inode->i_mapping->backing_dev_info = &ramfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		mapping_set_gfp_mask(inode->i_mapping,
+						GFP_HIGHUSER | __GFP_WIRED);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);

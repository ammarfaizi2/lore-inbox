Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWGCBBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWGCBBx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWGCBBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:01:43 -0400
Received: from thunk.org ([69.25.196.29]:6596 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750977AbWGCBA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:26 -0400
Message-Id: <20060703010023.720991000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 7/8] inode-diet: Use a union for i_blocks and i_size, i_rdev and i_devices
Content-Disposition: inline; filename=inode-slim-7
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i_blocks and i_size fields are only used for regular files.  So we
move them into the union, along with i_rdev and i_devices, which are
only used by block or character devices.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:29:49.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:29:52.000000000 -0400
@@ -501,15 +501,12 @@
 	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
-	dev_t			i_rdev;
 	loff_t			i_size;
 	struct timespec		i_atime;
 	struct timespec		i_mtime;
 	struct timespec		i_ctime;
 	unsigned int		i_blkbits;
 	unsigned long		i_version;
-	blkcnt_t		i_blocks;
-	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct mutex		i_mutex;
 	struct rw_semaphore	i_alloc_sem;
@@ -522,11 +519,20 @@
 #ifdef CONFIG_QUOTA
 	struct dquot		*i_dquot[MAXQUOTAS];
 #endif
-	struct list_head	i_devices;
 	union {
 		struct pipe_inode_info	*i_pipe;
-		struct block_device	*i_bdev;
-		struct cdev		*i_cdev;
+		struct {
+			union {
+				struct block_device	*i_bdev;
+				struct cdev		*i_cdev;
+			};
+			dev_t			i_rdev;
+			struct list_head	i_devices;
+		};
+		struct {
+			unsigned short          i_bytes;
+			blkcnt_t		i_blocks;
+		};
 	};
 
 	__u32			i_generation;
Index: linux-2.6.17-mm5/fs/stat.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/stat.c	2006-07-02 20:29:16.000000000 -0400
+++ linux-2.6.17-mm5/fs/stat.c	2006-07-02 20:29:52.000000000 -0400
@@ -32,7 +32,7 @@
 	stat->mtime = inode->i_mtime;
 	stat->ctime = inode->i_ctime;
 	stat->size = i_size_read(inode);
-	stat->blocks = inode->i_blocks;
+	stat->blocks = S_ISREG(inode->i_mode) ? inode->i_blocks : 0;
 	stat->blksize = PAGE_CACHE_SIZE;
 }
 

--

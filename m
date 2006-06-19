Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWFSPbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWFSPbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFSPbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:31:37 -0400
Received: from thunk.org ([69.25.196.29]:8074 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932525AbWFSPbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:31:16 -0400
Message-Id: <20060619153110.454388000@candygram.thunk.org>
References: <20060619152003.830437000@candygram.thunk.org>
Date: Mon, 19 Jun 2006 11:20:10 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 7/8] inode-diet: Use a union for i_blocks and i_size, i_rdev and i_devices
Content-Disposition: inline; filename=inode-slim-7
From: Theodore Tso <tytso@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i_blocks and i_size fields are only used for regular files.  So we
move them into the union, along with i_rdev and i_devices, which are
only used by block or character devices.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-18 19:59:59.000000000 -0400
+++ linux-2.6.17/include/linux/fs.h	2006-06-19 07:29:36.000000000 -0400
@@ -486,15 +486,12 @@
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
@@ -507,11 +504,20 @@
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

--

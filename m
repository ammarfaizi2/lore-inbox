Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWFSPcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWFSPcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWFSPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:31:43 -0400
Received: from thunk.org ([69.25.196.29]:6794 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932517AbWFSPbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:31:12 -0400
Message-Id: <20060619153109.060309000@candygram.thunk.org>
References: <20060619152003.830437000@candygram.thunk.org>
Date: Mon, 19 Jun 2006 11:20:06 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 3/8] inode-diet: Move i_bdev into a union
Content-Disposition: inline; filename=inode-slim-3
From: Theodore Tso <tytso@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i_bdev pointer in struct inode into a union.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-18 19:39:52.000000000 -0400
+++ linux-2.6.17/include/linux/fs.h	2006-06-18 19:46:10.000000000 -0400
@@ -511,8 +511,8 @@
 	struct list_head	i_devices;
 	union {
 		struct pipe_inode_info	*i_pipe;
+		struct block_device	*i_bdev;
 	};
-	struct block_device	*i_bdev;
 	struct cdev		*i_cdev;
 	int			i_cindex;
 
Index: linux-2.6.17/fs/block_dev.c
===================================================================
--- linux-2.6.17.orig/fs/block_dev.c	2006-06-18 19:37:14.000000000 -0400
+++ linux-2.6.17/fs/block_dev.c	2006-06-18 19:46:10.000000000 -0400
@@ -439,7 +439,7 @@
 void bd_forget(struct inode *inode)
 {
 	spin_lock(&bdev_lock);
-	if (inode->i_bdev)
+	if (S_ISBLK(inode->i_mode) && inode->i_bdev)
 		__bd_forget(inode);
 	spin_unlock(&bdev_lock);
 }
Index: linux-2.6.17/fs/inode.c
===================================================================
--- linux-2.6.17.orig/fs/inode.c	2006-06-18 19:42:16.000000000 -0400
+++ linux-2.6.17/fs/inode.c	2006-06-18 19:46:10.000000000 -0400
@@ -255,7 +255,7 @@
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
-	if (inode->i_bdev)
+	if (S_ISBLK(inode->i_mode) && inode->i_bdev)
 		bd_forget(inode);
 	if (inode->i_cdev)
 		cd_forget(inode);

--

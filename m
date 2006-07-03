Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWGCBBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWGCBBg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWGCBA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:00:26 -0400
Received: from thunk.org ([69.25.196.29]:3780 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750955AbWGCBAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:24 -0400
Message-Id: <20060703010022.784625000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/8] inode-diet: Move i_cdev into a union
Content-Disposition: inline; filename=inode-slim-4
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i_cdev pointer in struct inode into a union.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:28:55.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:28:58.000000000 -0400
@@ -527,8 +527,8 @@
 	union {
 		struct pipe_inode_info	*i_pipe;
 		struct block_device	*i_bdev;
+		struct cdev		*i_cdev;
 	};
-	struct cdev		*i_cdev;
 	int			i_cindex;
 
 	__u32			i_generation;
Index: linux-2.6.17-mm5/fs/file_table.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/file_table.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/file_table.c	2006-07-02 20:28:58.000000000 -0400
@@ -176,7 +176,7 @@
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
 	security_file_free(file);
-	if (unlikely(inode->i_cdev != NULL))
+	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL))
 		cdev_put(inode->i_cdev);
 	fops_put(file->f_op);
 	if (file->f_mode & FMODE_WRITE)
Index: linux-2.6.17-mm5/fs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/inode.c	2006-07-02 20:28:55.000000000 -0400
+++ linux-2.6.17-mm5/fs/inode.c	2006-07-02 20:28:58.000000000 -0400
@@ -256,7 +256,7 @@
 		inode->i_sb->s_op->clear_inode(inode);
 	if (S_ISBLK(inode->i_mode) && inode->i_bdev)
 		bd_forget(inode);
-	if (inode->i_cdev)
+	if (S_ISCHR(inode->i_mode) && inode->i_cdev)
 		cd_forget(inode);
 	inode->i_state = I_CLEAR;
 }

--

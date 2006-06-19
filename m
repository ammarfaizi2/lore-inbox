Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWFSPcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWFSPcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFSPbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:31:41 -0400
Received: from thunk.org ([69.25.196.29]:7050 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932514AbWFSPbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:31:14 -0400
Message-Id: <20060619153109.539332000@candygram.thunk.org>
References: <20060619152003.830437000@candygram.thunk.org>
Date: Mon, 19 Jun 2006 11:20:07 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 4/8] inode-diet: Move i_cdev into a union
Content-Disposition: inline; filename=inode-slim-4
From: Theodore Tso <tytso@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i_cdev pointer in struct inode into a union.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-18 19:46:10.000000000 -0400
+++ linux-2.6.17/include/linux/fs.h	2006-06-18 19:50:56.000000000 -0400
@@ -512,8 +512,8 @@
 	union {
 		struct pipe_inode_info	*i_pipe;
 		struct block_device	*i_bdev;
+		struct cdev		*i_cdev;
 	};
-	struct cdev		*i_cdev;
 	int			i_cindex;
 
 	__u32			i_generation;
Index: linux-2.6.17/fs/file_table.c
===================================================================
--- linux-2.6.17.orig/fs/file_table.c	2006-06-18 19:37:14.000000000 -0400
+++ linux-2.6.17/fs/file_table.c	2006-06-18 19:50:56.000000000 -0400
@@ -170,7 +170,7 @@
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
 	security_file_free(file);
-	if (unlikely(inode->i_cdev != NULL))
+	if (unlikely(S_ISCHR(inode->i_mode) && (inode->i_cdev != NULL)))
 		cdev_put(inode->i_cdev);
 	fops_put(file->f_op);
 	if (file->f_mode & FMODE_WRITE)
Index: linux-2.6.17/fs/inode.c
===================================================================
--- linux-2.6.17.orig/fs/inode.c	2006-06-18 19:46:10.000000000 -0400
+++ linux-2.6.17/fs/inode.c	2006-06-18 19:50:56.000000000 -0400
@@ -257,7 +257,7 @@
 		inode->i_sb->s_op->clear_inode(inode);
 	if (S_ISBLK(inode->i_mode) && inode->i_bdev)
 		bd_forget(inode);
-	if (inode->i_cdev)
+	if (S_ISCHR(inode->i_mode) && inode->i_cdev)
 		cd_forget(inode);
 	inode->i_state = I_CLEAR;
 }

--

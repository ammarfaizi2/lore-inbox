Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWGCBAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWGCBAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWGCBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:00:28 -0400
Received: from thunk.org ([69.25.196.29]:3268 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750954AbWGCBAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:24 -0400
Message-Id: <20060703010022.612985000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/8] inode-diet: Move i_bdev into a union
Content-Disposition: inline; filename=inode-slim-3
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i_bdev pointer in struct inode into a union.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:28:45.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:28:55.000000000 -0400
@@ -526,8 +526,8 @@
 	struct list_head	i_devices;
 	union {
 		struct pipe_inode_info	*i_pipe;
+		struct block_device	*i_bdev;
 	};
-	struct block_device	*i_bdev;
 	struct cdev		*i_cdev;
 	int			i_cindex;
 
Index: linux-2.6.17-mm5/fs/inode.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/inode.c	2006-07-02 20:27:00.000000000 -0400
+++ linux-2.6.17-mm5/fs/inode.c	2006-07-02 20:28:55.000000000 -0400
@@ -254,7 +254,7 @@
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
-	if (inode->i_bdev)
+	if (S_ISBLK(inode->i_mode) && inode->i_bdev)
 		bd_forget(inode);
 	if (inode->i_cdev)
 		cd_forget(inode);

--

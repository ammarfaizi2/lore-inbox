Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264866AbSJOVNl>; Tue, 15 Oct 2002 17:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSJOVMo>; Tue, 15 Oct 2002 17:12:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:37940 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S264828AbSJOVMF>; Tue, 15 Oct 2002 17:12:05 -0400
Date: Tue, 15 Oct 2002 22:18:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] simple_rename link count
Message-ID: <Pine.LNX.4.44.0210152217000.1521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simple_rename, like shmem_rename until I fixed that a few weeks ago,
got the parent directory's link count wrong in the exceptional case
of renaming a directory in place of an existing empty directory.

--- 2.5.42-mm3/fs/libfs.c	Tue Oct 15 06:43:39 2002
+++ linux/fs/libfs.c	Tue Oct 15 13:14:34 2002
@@ -263,17 +263,16 @@
 int simple_rename(struct inode *old_dir, struct dentry *old_dentry,
 		struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct inode *inode;
+	int they_are_dirs = S_ISDIR(old_dentry->d_inode->i_mode);
 
 	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
-	inode = new_dentry->d_inode;
-	if (inode) {
-		inode->i_nlink--;
-		dput(new_dentry);
-	}
-	if (S_ISDIR(old_dentry->d_inode->i_mode)) {
+	if (new_dentry->d_inode) {
+		simple_unlink(new_dir, new_dentry);
+		if (they_are_dirs)
+			old_dir->i_nlink--;
+	} else if (they_are_dirs) {
 		old_dir->i_nlink--;
 		new_dir->i_nlink++;
 	}


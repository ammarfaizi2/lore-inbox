Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSIOJaa>; Sun, 15 Sep 2002 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSIOJaa>; Sun, 15 Sep 2002 05:30:30 -0400
Received: from [143.127.3.97] ([143.127.3.97]:13069 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S317580AbSIOJaa>; Sun, 15 Sep 2002 05:30:30 -0400
Date: Sun, 15 Sep 2002 10:36:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 1/5 shmem_rename fixes
Message-ID: <Pine.LNX.4.44.0209151033190.10490-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_rename still didn't get parent directory link count quite right,
in the case where you rename a directory in place of an empty directory
(with rename syscall: doesn't happen like that with mv command); and it
forgot to update new directory's ctime and mtime.

--- 2.4.20-pre7/mm/shmem.c	Fri Sep 13 10:28:10 2002
+++ tmpfs1/mm/shmem.c	Sat Sep 14 18:21:23 2002
@@ -1124,24 +1124,24 @@
  */
 static int shmem_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
 {
-	struct inode *inode;
+	struct inode *inode = old_dentry->d_inode;
+	int they_are_dirs = S_ISDIR(inode->i_mode);
 
 	if (!shmem_empty(new_dentry)) 
 		return -ENOTEMPTY;
 
-	inode = new_dentry->d_inode;
-	if (inode) {
-		inode->i_ctime = CURRENT_TIME;
-		inode->i_nlink--;
-		dput(new_dentry);
-	}
-	inode = old_dentry->d_inode;
-	if (S_ISDIR(inode->i_mode)) {
+	if (new_dentry->d_inode) {
+		(void) shmem_unlink(new_dir, new_dentry);
+		if (they_are_dirs)
+			old_dir->i_nlink--;
+	} else if (they_are_dirs) {
 		old_dir->i_nlink--;
 		new_dir->i_nlink++;
 	}
 
-	inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	old_dir->i_ctime = old_dir->i_mtime =
+	new_dir->i_ctime = new_dir->i_mtime =
+	inode->i_ctime = CURRENT_TIME;
 	return 0;
 }
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSIOJen>; Sun, 15 Sep 2002 05:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSIOJen>; Sun, 15 Sep 2002 05:34:43 -0400
Received: from [143.127.3.97] ([143.127.3.97]:44557 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S317986AbSIOJel>; Sun, 15 Sep 2002 05:34:41 -0400
Date: Sun, 15 Sep 2002 10:40:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, "H. Peter Anvin" <hpa@zytor.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 3/5 pretend dirent size
In-Reply-To: <Pine.LNX.4.44.0209151033190.10490-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151038050.10490-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre6 had mod by hpa, to make tmpfs directory size always 1
instead of always 0, so as not to mislead apps.  Okay, but I think
it looks better if we use a pretend directory entry size instead.

--- tmpfs2/mm/shmem.c	Sat Sep 14 18:21:23 2002
+++ tmpfs3/mm/shmem.c	Sat Sep 14 18:21:23 2002
@@ -35,6 +35,9 @@
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
 
+/* Pretend that each entry is of this size in directory's i_size */
+#define BOGO_DIRENT_SIZE 20
+
 #define SHMEM_SB(sb) (&sb->u.shmem_sb)
 
 static struct super_operations shmem_ops;
@@ -737,7 +740,7 @@
 		case S_IFDIR:
 			inode->i_nlink++;
 			/* Some things misbehave if size == 0 on a directory */
-			inode->i_size = 1;
+			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
 			inode->i_fop = &dcache_dir_ops;
 			break;
@@ -1024,6 +1027,7 @@
 	int error = -ENOSPC;
 
 	if (inode) {
+		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
@@ -1057,6 +1061,7 @@
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
+	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink++;
 	atomic_inc(&inode->i_count);	/* New dentry reference */
@@ -1101,6 +1106,8 @@
 static int shmem_unlink(struct inode * dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
+
+	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink--;
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@ -1139,6 +1146,8 @@
 		new_dir->i_nlink++;
 	}
 
+	old_dir->i_size -= BOGO_DIRENT_SIZE;
+	new_dir->i_size += BOGO_DIRENT_SIZE;
 	old_dir->i_ctime = old_dir->i_mtime =
 	new_dir->i_ctime = new_dir->i_mtime =
 	inode->i_ctime = CURRENT_TIME;
@@ -1187,6 +1196,7 @@
 		page_cache_release(page);
 		up(&info->sem);
 	}
+	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	d_instantiate(dentry, inode);
 	dget(dentry);


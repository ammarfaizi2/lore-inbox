Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSIOJcR>; Sun, 15 Sep 2002 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSIOJcR>; Sun, 15 Sep 2002 05:32:17 -0400
Received: from [143.127.3.88] ([143.127.3.88]:42756 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S317589AbSIOJcQ>; Sun, 15 Sep 2002 05:32:16 -0400
Date: Sun, 15 Sep 2002 10:37:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 2/5 shmem_symlink like 2.5/ac 
In-Reply-To: <Pine.LNX.4.44.0209151033190.10490-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151036220.10490-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_symlink is okay, but I prefer the 2.5/ac ordering, which leaves
instantiation until the end: and is better for layering the next patch.

--- tmpfs1/mm/shmem.c	Sat Sep 14 18:21:23 2002
+++ tmpfs2/mm/shmem.c	Sat Sep 14 18:21:23 2002
@@ -1147,42 +1147,38 @@
 
 static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
-	int error;
 	int len;
 	struct inode *inode;
 	struct page *page;
 	char *kaddr;
 	struct shmem_inode_info * info;
 
-	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
-	if (error)
-		return error;
-
 	len = strlen(symname) + 1;
-	inode = dentry->d_inode;
+	if (len > PAGE_CACHE_SIZE)
+		return -ENAMETOOLONG;
+
+	inode = shmem_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
+	if (!inode)
+		return -ENOSPC;
+
 	info = SHMEM_I(inode);
 	inode->i_size = len-1;
-	inode->i_op = &shmem_symlink_inline_operations;
-
 	if (len <= sizeof(struct shmem_inode_info)) {
 		/* do it inline */
 		memcpy(info, symname, len);
+		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
-		if (len > PAGE_CACHE_SIZE) {
-			error = -ENAMETOOLONG;
-			goto rmnod;
-		}
-		inode->i_op = &shmem_symlink_inode_operations;
-		spin_lock (&shmem_ilock);
-		list_add_tail(&info->list, &shmem_inodes);
-		spin_unlock (&shmem_ilock);
 		down(&info->sem);
 		page = shmem_getpage_locked(info, inode, 0);
 		if (IS_ERR(page)) {
 			up(&info->sem);
-			error = PTR_ERR(page);
-			goto rmnod;
+			iput(inode);
+			return PTR_ERR(page);
 		}
+		inode->i_op = &shmem_symlink_inode_operations;
+		spin_lock (&shmem_ilock);
+		list_add_tail(&info->list, &shmem_inodes);
+		spin_unlock (&shmem_ilock);
 		kaddr = kmap(page);
 		memcpy(kaddr, symname, len);
 		kunmap(page);
@@ -1192,12 +1188,9 @@
 		up(&info->sem);
 	}
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	d_instantiate(dentry, inode);
+	dget(dentry);
 	return 0;
-
-rmnod:
-	if (!shmem_unlink(dir, dentry))
-		d_delete(dentry);
-	return error;
 }
 
 static int shmem_readlink_inline(struct dentry *dentry, char *buffer, int buflen)


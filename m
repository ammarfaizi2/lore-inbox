Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSFLCwO>; Tue, 11 Jun 2002 22:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317310AbSFLCwN>; Tue, 11 Jun 2002 22:52:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26972 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317309AbSFLCwM>; Tue, 11 Jun 2002 22:52:12 -0400
Date: Wed, 12 Jun 2002 03:51:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs 1/4 symlink unwind
In-Reply-To: <Pine.LNX.4.21.0206120343290.1036-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0206120348170.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_symlink error path forgot to unwind.  The failed symlink left
over could be unlinked, but long ones were left on the shmem_inodes
list, causing oops in swapoff at shutdown if not earlier.

--- 2.4.19-pre10/mm/shmem.c	Tue Jun  4 13:54:20 2002
+++ linux/mm/shmem.c	Tue Jun 11 19:02:30 2002
@@ -1123,17 +1123,20 @@
 		return error;
 
 	len = strlen(symname) + 1;
-	if (len > PAGE_CACHE_SIZE)
-		return -ENAMETOOLONG;
-		
 	inode = dentry->d_inode;
 	info = SHMEM_I(inode);
 	inode->i_size = len-1;
+	inode->i_op = &shmem_symlink_inline_operations;
+
 	if (len <= sizeof(struct shmem_inode_info)) {
 		/* do it inline */
 		memcpy(info, symname, len);
-		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
+		if (len > PAGE_CACHE_SIZE) {
+			error = -ENAMETOOLONG;
+			goto rmnod;
+		}
+		inode->i_op = &shmem_symlink_inode_operations;
 		spin_lock (&shmem_ilock);
 		list_add (&info->list, &shmem_inodes);
 		spin_unlock (&shmem_ilock);
@@ -1141,7 +1144,8 @@
 		page = shmem_getpage_locked(info, inode, 0);
 		if (IS_ERR(page)) {
 			up(&info->sem);
-			return PTR_ERR(page);
+			error = PTR_ERR(page);
+			goto rmnod;
 		}
 		kaddr = kmap(page);
 		memcpy(kaddr, symname, len);
@@ -1150,10 +1154,14 @@
 		UnlockPage(page);
 		page_cache_release(page);
 		up(&info->sem);
-		inode->i_op = &shmem_symlink_inode_operations;
 	}
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	return 0;
+
+rmnod:
+	if (!shmem_unlink(dir, dentry))
+		d_delete(dentry);
+	return error;
 }
 
 static int shmem_readlink_inline(struct dentry *dentry, char *buffer, int buflen)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTJOST5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTJOST5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:19:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13238 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263895AbTJOSTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:19:50 -0400
Date: Wed, 15 Oct 2003 19:19:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 2/7 LTP S_ISGID dir
In-Reply-To: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310151918560.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTP tests the filesystem on /tmp: many failures when tmpfs because
it missed the way giddy directories hand down their gid.  Also fix
ramfs and hugetlbfs.

--- tmpfs1/fs/hugetlbfs/inode.c	2003-10-15 08:49:54.000000000 +0100
+++ tmpfs2/fs/hugetlbfs/inode.c	2003-10-15 15:38:41.333893024 +0100
@@ -409,10 +409,18 @@
 static int hugetlbfs_mknod(struct inode *dir,
 			struct dentry *dentry, int mode, dev_t dev)
 {
-	struct inode *inode = hugetlbfs_get_inode(dir->i_sb, current->fsuid, 
-					current->fsgid, mode, dev);
+	struct inode *inode;
 	int error = -ENOSPC;
+	gid_t gid;
 
+	if (dir->i_mode & S_ISGID) {
+		gid = dir->i_gid;
+		if (S_ISDIR(mode))
+			mode |= S_ISGID;
+	} else {
+		gid = current->fsgid;
+	}
+	inode = hugetlbfs_get_inode(dir->i_sb, current->fsuid, gid, mode, dev);
 	if (inode) {
 		dir->i_size += PSEUDO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -441,9 +449,15 @@
 {
 	struct inode *inode;
 	int error = -ENOSPC;
+	gid_t gid;
+
+	if (dir->i_mode & S_ISGID)
+		gid = dir->i_gid;
+	else
+		gid = current->fsgid;
 
 	inode = hugetlbfs_get_inode(dir->i_sb, current->fsuid,
-					current->fsgid, S_IFLNK|S_IRWXUGO, 0);
+					gid, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
--- tmpfs1/fs/ramfs/inode.c	2003-09-08 20:51:04.000000000 +0100
+++ tmpfs2/fs/ramfs/inode.c	2003-10-15 15:38:41.333893024 +0100
@@ -95,6 +95,11 @@
 	int error = -ENOSPC;
 
 	if (inode) {
+		if (dir->i_mode & S_ISGID) {
+			inode->i_gid = dir->i_gid;
+			if (S_ISDIR(mode))
+				inode->i_mode |= S_ISGID;
+		}
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
@@ -125,6 +130,8 @@
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
 		if (!error) {
+			if (dir->i_mode & S_ISGID)
+				inode->i_gid = dir->i_gid;
 			d_instantiate(dentry, inode);
 			dget(dentry);
 		} else
--- tmpfs1/mm/shmem.c	2003-10-15 08:47:31.000000000 +0100
+++ tmpfs2/mm/shmem.c	2003-10-15 15:38:41.336892568 +0100
@@ -1395,6 +1395,11 @@
 	int error = -ENOSPC;
 
 	if (inode) {
+		if (dir->i_mode & S_ISGID) {
+			inode->i_gid = dir->i_gid;
+			if (S_ISDIR(mode))
+				inode->i_mode |= S_ISGID;
+		}
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 		d_instantiate(dentry, inode);
@@ -1531,6 +1536,8 @@
 		set_page_dirty(page);
 		page_cache_release(page);
 	}
+	if (dir->i_mode & S_ISGID)
+		inode->i_gid = dir->i_gid;
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	d_instantiate(dentry, inode);


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUCOICj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 03:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCOIBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 03:01:41 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:463 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262027AbUCOH70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:59:26 -0500
Date: Mon, 15 Mar 2004 08:59:24 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04.1 5/5
Message-ID: <20040315075924.GG31818@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314203427.27857fd9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/xfs/xfs_inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/xfs/xfs_inode.c
--- linux-2.6.4-20040314_2308/fs/xfs/xfs_inode.c	2004-03-11 03:55:50.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/xfs/xfs_inode.c	2004-03-15 06:17:57.000000000 +0100
@@ -3677,7 +3677,7 @@ xfs_iaccess(
 	if (mode & S_IWUSR) {
 		umode_t		imode = inode->i_mode;
 
-		if (IS_RDONLY(inode) &&
+		if (IS_RDONLY_INODE(inode) &&
 		    (S_ISREG(imode) || S_ISDIR(imode) || S_ISLNK(imode)))
 			return XFS_ERROR(EROFS);
 
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/nfsd/vfs.c linux-2.6.4-20040314_2308-bme0.04.1/fs/nfsd/vfs.c
--- linux-2.6.4-20040314_2308/fs/nfsd/vfs.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/nfsd/vfs.c	2004-03-15 06:19:48.000000000 +0100
@@ -1539,7 +1539,7 @@ nfsd_permission(struct svc_export *exp, 
 		inode->i_mode,
 		IS_IMMUTABLE(inode)?	" immut" : "",
 		IS_APPEND(inode)?	" append" : "",
-		IS_RDONLY(inode)?	" ro" : "");
+		IS_RDONLY_INODE(inode)?	" ro" : "");
 	dprintk("      owner %d/%d user %d/%d\n",
 		inode->i_uid, inode->i_gid, current->fsuid, current->fsgid);
 #endif
@@ -1550,7 +1550,7 @@ nfsd_permission(struct svc_export *exp, 
 	 */
 	if (!(acc & MAY_LOCAL_ACCESS))
 		if (acc & (MAY_WRITE | MAY_SATTR | MAY_TRUNC)) {
-			if (EX_RDONLY(exp) || IS_RDONLY(inode))
+			if (EX_RDONLY(exp) || IS_RDONLY_INODE(inode))
 				return nfserr_rofs;
 			if (/* (acc & MAY_WRITE) && */ IS_IMMUTABLE(inode))
 				return nfserr_perm;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ntfs/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ntfs/inode.c
--- linux-2.6.4-20040314_2308/fs/ntfs/inode.c	2004-03-11 03:55:44.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ntfs/inode.c	2004-03-15 06:18:51.000000000 +0100
@@ -885,7 +885,7 @@ skip_large_dir_stuff:
 		/* Everyone gets read and scan permissions. */
 		vi->i_mode |= S_IRUGO | S_IXUGO;
 		/* If not read-only, set write permissions. */
-		if (!IS_RDONLY(vi))
+		if (!IS_RDONLY_INODE(vi))
 			vi->i_mode |= S_IWUGO;
 		/*
 		 * Apply the directory permissions mask set in the mount
@@ -1026,7 +1026,7 @@ no_data_attr_special_case:
 		/* Everyone gets all permissions. */
 		vi->i_mode |= S_IRWXUGO;
 		/* If read-only, noone gets write permissions. */
-		if (IS_RDONLY(vi))
+		if (IS_RDONLY_INODE(vi))
 			vi->i_mode &= ~S_IWUGO;
 		/* Apply the file permissions mask set in the mount options. */
 		vi->i_mode &= ~vol->fmask;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/fat/file.c linux-2.6.4-20040314_2308-bme0.04.1/fs/fat/file.c
--- linux-2.6.4-20040314_2308/fs/fat/file.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/fat/file.c	2004-03-15 06:28:31.000000000 +0100
@@ -90,7 +90,7 @@ void fat_truncate(struct inode *inode)
 	int nr_clusters;
 
 	/* Why no return value?  Surely the disk could fail... */
-	if (IS_RDONLY (inode))
+	if (IS_RDONLY_INODE(inode))
 		return /* -EPERM */;
 	if (IS_IMMUTABLE(inode))
 		return /* -EPERM */;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/jfs/xattr.c linux-2.6.4-20040314_2308-bme0.04.1/fs/jfs/xattr.c
--- linux-2.6.4-20040314_2308/fs/jfs/xattr.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/jfs/xattr.c	2004-03-15 06:40:42.000000000 +0100
@@ -717,7 +717,7 @@ static int can_set_system_xattr(struct i
 static int can_set_xattr(struct inode *inode, const char *name,
 			 const void *value, size_t value_len)
 {
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY_INODE(inode))
 		return -EROFS;
 
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) || S_ISLNK(inode->i_mode))
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext3/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/inode.c
--- linux-2.6.4-20040314_2308/fs/ext3/inode.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/inode.c	2004-03-15 06:27:47.000000000 +0100
@@ -3018,7 +3018,7 @@ int ext3_change_inode_journal_flag(struc
 	 */
 
 	journal = EXT3_JOURNAL(inode);
-	if (is_journal_aborted(journal) || IS_RDONLY(inode))
+	if (is_journal_aborted(journal) || IS_RDONLY_INODE(inode))
 		return -EROFS;
 
 	journal_lock_updates(journal);
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ncpfs/file.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ncpfs/file.c
--- linux-2.6.4-20040314_2308/fs/ncpfs/file.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ncpfs/file.c	2004-03-15 06:21:31.000000000 +0100
@@ -175,7 +175,7 @@ ncp_file_read(struct file *file, char *b
 
 	*ppos = pos;
 
-	if (!IS_RDONLY(inode)) {
+	if (!IS_RDONLY_INODE(inode)) {
 		inode->i_atime = CURRENT_TIME;
 	}
 	
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ncpfs/mmap.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ncpfs/mmap.c
--- linux-2.6.4-20040314_2308/fs/ncpfs/mmap.c	2004-03-11 03:55:36.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ncpfs/mmap.c	2004-03-15 06:21:00.000000000 +0100
@@ -123,7 +123,7 @@ int ncp_mmap(struct file *file, struct v
 	if (((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff 
 	   > (1U << (32 - PAGE_SHIFT)))
 		return -EFBIG;
-	if (!IS_RDONLY(inode)) {
+	if (!IS_RDONLY_INODE(inode)) {
 		inode->i_atime = CURRENT_TIME;
 	}
 

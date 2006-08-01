Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWHAXyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWHAXyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHAXyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:54:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46544 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750755AbWHAXxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:43 -0400
Subject: [PATCH 05/28] monitor zeroing of i_nlink
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:43 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235243.460FC930@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some filesystems, instead of simply decrementing i_nlink, simply zero
it during an unlink operation.  We need to catch these in addition
to the decrement operations.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/autofs4/root.c   |    4 ++--
 lxc-dave/fs/cifs/inode.c     |    2 +-
 lxc-dave/fs/ext3/namei.c     |    2 +-
 lxc-dave/fs/fuse/dir.c       |    4 ++--
 lxc-dave/fs/hfs/dir.c        |    2 +-
 lxc-dave/fs/hfsplus/dir.c    |    4 ++--
 lxc-dave/fs/hpfs/namei.c     |    4 ++--
 lxc-dave/fs/jfs/namei.c      |    2 +-
 lxc-dave/fs/libfs.c          |    1 -
 lxc-dave/fs/msdos/namei.c    |    4 ++--
 lxc-dave/fs/nfs/dir.c        |    2 +-
 lxc-dave/fs/qnx4/namei.c     |    2 +-
 lxc-dave/fs/reiserfs/namei.c |    4 ++--
 lxc-dave/fs/udf/namei.c      |    2 +-
 lxc-dave/fs/vfat/namei.c     |    4 ++--
 lxc-dave/include/linux/fs.h  |    2 +-
 16 files changed, 22 insertions(+), 23 deletions(-)

diff -puN fs/libfs.c~monitor-clear-i_nlink fs/libfs.c
--- lxc/fs/libfs.c~monitor-clear-i_nlink	2006-08-01 16:35:16.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-08-01 16:35:17.000000000 -0700
@@ -273,7 +273,6 @@ out:
 void __inode_set_awaiting_final_iput(struct inode *inode)
 {
 }
-EXPORT_SYMBOL_GPL(inode_drop_nlink);
 
 int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
diff -puN fs/cifs/inode.c~monitor-clear-i_nlink fs/cifs/inode.c
--- lxc/fs/cifs/inode.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/cifs/inode.c	2006-08-01 16:35:17.000000000 -0700
@@ -819,7 +819,7 @@ int cifs_rmdir(struct inode *inode, stru
 	if (!rc) {
 		inode_drop_nlink(inode);
 		i_size_write(direntry->d_inode,0);
-		direntry->d_inode->i_nlink = 0;
+		inode_clear_nlink(direntry->d_inode);
 	}
 
 	cifsInode = CIFS_I(direntry->d_inode);
diff -puN fs/ext3/namei.c~monitor-clear-i_nlink fs/ext3/namei.c
--- lxc/fs/ext3/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/ext3/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -2044,7 +2044,7 @@ static int ext3_rmdir (struct inode * di
 			      "empty directory has nlink!=2 (%d)",
 			      inode->i_nlink);
 	inode->i_version++;
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	/* There's no need to set i_disksize: the fact that i_nlink is
 	 * zero will ensure that the right thing happens during any
 	 * recovery. */
diff -puN fs/autofs4/root.c~monitor-clear-i_nlink fs/autofs4/root.c
--- lxc/fs/autofs4/root.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/autofs4/root.c	2006-08-01 16:35:17.000000000 -0700
@@ -638,7 +638,7 @@ static int autofs4_dir_unlink(struct ino
 	dput(ino->dentry);
 
 	dentry->d_inode->i_size = 0;
-	dentry->d_inode->i_nlink = 0;
+	inode_clear_nlink(dentry->d_inode);
 
 	dir->i_mtime = CURRENT_TIME;
 
@@ -673,7 +673,7 @@ static int autofs4_dir_rmdir(struct inod
 	}
 	dput(ino->dentry);
 	dentry->d_inode->i_size = 0;
-	dentry->d_inode->i_nlink = 0;
+	inode_clear_nlink(dentry->d_inode);
 
 	if (dir->i_nlink)
 		inode_drop_nlink(dir);
diff -puN fs/fuse/dir.c~monitor-clear-i_nlink fs/fuse/dir.c
--- lxc/fs/fuse/dir.c~monitor-clear-i_nlink	2006-08-01 16:35:11.000000000 -0700
+++ lxc-dave/fs/fuse/dir.c	2006-08-01 16:35:17.000000000 -0700
@@ -477,7 +477,7 @@ static int fuse_unlink(struct inode *dir
 		/* Set nlink to zero so the inode can be cleared, if
                    the inode does have more links this will be
                    discovered at the next lookup/getattr */
-		inode->i_nlink = 0;
+		inode_clear_nlink(inode);
 		fuse_invalidate_attr(inode);
 		fuse_invalidate_attr(dir);
 		fuse_invalidate_entry_cache(entry);
@@ -503,7 +503,7 @@ static int fuse_rmdir(struct inode *dir,
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
 	if (!err) {
-		entry->d_inode->i_nlink = 0;
+		inode_clear_nlink(entry->d_inode);
 		fuse_invalidate_attr(dir);
 		fuse_invalidate_entry_cache(entry);
 	} else if (err == -EINTR)
diff -puN fs/hfs/dir.c~monitor-clear-i_nlink fs/hfs/dir.c
--- lxc/fs/hfs/dir.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/hfs/dir.c	2006-08-01 16:35:17.000000000 -0700
@@ -273,7 +273,7 @@ static int hfs_rmdir(struct inode *dir, 
 	res = hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
 	if (res)
 		return res;
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	hfs_delete_inode(inode);
 	mark_inode_dirty(inode);
diff -puN fs/hfsplus/dir.c~monitor-clear-i_nlink fs/hfsplus/dir.c
--- lxc/fs/hfsplus/dir.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/hfsplus/dir.c	2006-08-01 16:35:17.000000000 -0700
@@ -348,7 +348,7 @@ static int hfsplus_unlink(struct inode *
 		} else
 			inode->i_flags |= S_DEAD;
 	} else
-		inode->i_nlink = 0;
+		inode_clear_nlink(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 
@@ -387,7 +387,7 @@ static int hfsplus_rmdir(struct inode *d
 	res = hfsplus_delete_cat(inode->i_ino, dir, &dentry->d_name);
 	if (res)
 		return res;
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	hfsplus_delete_inode(inode);
 	mark_inode_dirty(inode);
diff -puN fs/hpfs/namei.c~monitor-clear-i_nlink fs/hpfs/namei.c
--- lxc/fs/hpfs/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/hpfs/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -495,7 +495,7 @@ static int hpfs_rmdir(struct inode *dir,
 		break;
 	default:
 		inode_drop_nlink(dir);
-		inode->i_nlink = 0;
+		inode_clear_nlink(inode);
 		err = 0;
 	}
 	goto out;
@@ -590,7 +590,7 @@ static int hpfs_rename(struct inode *old
 		int r;
 		if ((r = hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1)) != 2) {
 			if ((nde = map_dirent(new_dir, hpfs_i(new_dir)->i_dno, (char *)new_name, new_len, NULL, &qbh1))) {
-				new_inode->i_nlink = 0;
+				inode_clear_nlink(new_inode);
 				copy_de(nde, &de);
 				memcpy(nde->name, new_name, new_len);
 				hpfs_mark_4buffers_dirty(&qbh1);
diff -puN fs/jfs/namei.c~monitor-clear-i_nlink fs/jfs/namei.c
--- lxc/fs/jfs/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/jfs/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -414,7 +414,7 @@ static int jfs_rmdir(struct inode *dip, 
 	JFS_IP(ip)->acl.flag = 0;
 
 	/* mark the target directory as deleted */
-	ip->i_nlink = 0;
+	inode_clear_nlink(ip);
 	mark_inode_dirty(ip);
 
 	rc = txCommit(tid, 2, &iplist[0], 0);
diff -puN fs/msdos/namei.c~monitor-clear-i_nlink fs/msdos/namei.c
--- lxc/fs/msdos/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/msdos/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -343,7 +343,7 @@ static int msdos_rmdir(struct inode *dir
 		goto out;
 	inode_drop_nlink(dir);
 
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 out:
@@ -425,7 +425,7 @@ static int msdos_unlink(struct inode *di
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 out:
diff -puN fs/nfs/dir.c~monitor-clear-i_nlink fs/nfs/dir.c
--- lxc/fs/nfs/dir.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/nfs/dir.c	2006-08-01 16:35:17.000000000 -0700
@@ -1280,7 +1280,7 @@ static int nfs_rmdir(struct inode *dir, 
 	error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
 	/* Ensure the VFS deletes this inode */
 	if (error == 0 && dentry->d_inode != NULL)
-		dentry->d_inode->i_nlink = 0;
+		inode_clear_nlink(dentry->d_inode);
 	nfs_end_data_update(dir);
 	unlock_kernel();
 
diff -puN fs/ocfs2/namei.c~monitor-clear-i_nlink fs/ocfs2/namei.c
diff -puN fs/qnx4/namei.c~monitor-clear-i_nlink fs/qnx4/namei.c
--- lxc/fs/qnx4/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/qnx4/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -186,7 +186,7 @@ int qnx4_rmdir(struct inode *dir, struct
 	memset(de->di_fname, 0, sizeof de->di_fname);
 	de->di_mode = 0;
 	mark_buffer_dirty(bh);
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	mark_inode_dirty(inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	inode_dec_link_count(dir);
diff -puN fs/reiserfs/namei.c~monitor-clear-i_nlink fs/reiserfs/namei.c
--- lxc/fs/reiserfs/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/reiserfs/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -913,7 +913,7 @@ static int reiserfs_rmdir(struct inode *
 		reiserfs_warning(inode->i_sb, "%s: empty directory has nlink "
 				 "!= 2 (%d)", __FUNCTION__, inode->i_nlink);
 
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME_SEC;
 	reiserfs_update_sd(&th, inode);
 
@@ -1473,7 +1473,7 @@ static int reiserfs_rename(struct inode 
 	if (new_dentry_inode) {
 		// adjust link number of the victim
 		if (S_ISDIR(new_dentry_inode->i_mode)) {
-			new_dentry_inode->i_nlink = 0;
+			inode_clear_nlink(new_dentry_inode);
 		} else {
 			inode_drop_nlink(new_dentry_inode);
 		}
diff -puN fs/udf/namei.c~monitor-clear-i_nlink fs/udf/namei.c
--- lxc/fs/udf/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/udf/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -876,7 +876,7 @@ static int udf_rmdir(struct inode * dir,
 		udf_warning(inode->i_sb, "udf_rmdir",
 			"empty directory has nlink != 2 (%d)",
 			inode->i_nlink);
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_size = 0;
 	inode_dec_link_count(inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_fs_time(dir->i_sb);
diff -puN fs/vfat/namei.c~monitor-clear-i_nlink fs/vfat/namei.c
--- lxc/fs/vfat/namei.c~monitor-clear-i_nlink	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/vfat/namei.c	2006-08-01 16:35:17.000000000 -0700
@@ -784,7 +784,7 @@ static int vfat_rmdir(struct inode *dir,
 		goto out;
 	inode_drop_nlink(dir);
 
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 out:
@@ -808,7 +808,7 @@ static int vfat_unlink(struct inode *dir
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	inode->i_nlink = 0;
+	inode_clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
 out:
diff -puN include/linux/fs.h~monitor-clear-i_nlink include/linux/fs.h
--- lxc/include/linux/fs.h~monitor-clear-i_nlink	2006-08-01 16:35:16.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-08-01 16:35:17.000000000 -0700
@@ -1273,7 +1273,7 @@ static inline void inode_drop_nlink(stru
 
 static inline void inode_dec_link_count(struct inode *inode)
 {
-	inode_drop_nlink(inode)
+	inode_drop_nlink(inode);
 	mark_inode_dirty(inode);
 }
 
_

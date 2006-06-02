Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWFBOvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWFBOvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWFBOvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:51:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:8584 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751429AbWFBOvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:51:24 -0400
Subject: checking vfsmount for r/o flag
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Herbert Poetzl <herbert@13thfloor.at>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 07:50:39 -0700
Message-Id: <1149259839.16665.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I had first started trying to port some of Herbert Poetzl's patches, but
I realized that there are quite a few things suggested by you and others
back in 2004 that haven't yet been approached.  I figured we probably
need to get to these changes first.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107970825119250&w=2

Could you elaborate a bit on how the delayed writes and extra write
request should work?

Basic premise: if you want to through a mount point, you must have first
elevated mnt->writer_count.  This effectively encompasses any time a
call is made permission() with the MAY_WRITE flags set.

The following patch takes a stab at auditing all callers to permission()
(and thus ->permission).  It sometimes seems a bit high in the layering
(added in quite a few places).  This still leaves callers from the
following, but, I figured I'd check that the basic approach is sane for
now:

        ecryptfs_permission
        vfs_permission
        file_permission
        user_eo_get
        user_eo_set
        user_eo_remove
        gfs2_repermission
        may_create
                <- vfs_rename
                        <- ecryptfs_rename
                <- vfs_mknod
                <- vfs_mkdir
                <- vfs_symlink
                <- vfs_link
        vfs_rename_dir
        nfsd_acceptable
        nfsd_permission
        nfsd_permission
        xattr_permission

I'm a bit confused by some messages from 2004.  It seems
vfs_permission() has changed function a bit since then:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107961332908524&w=2

-- Dave

--- linux.orig/fs/namei.c~convert-permission-to-file-and-vfs	2006-06-02 07:40:33.000000000 -0700
+++ linux/fs/namei.c	2006-06-02 07:40:34.000000000 -0700
@@ -1461,22 +1461,29 @@
 int vfs_create(struct inode *dir, struct dentry *dentry, int mode,
 		struct nameidata *nd)
 {
-	int error = may_create(dir, dentry, nd);
+	int error;
 
+	error = mnt_want_write(nd.mnt);
 	if (error)
 		return error;
 
+	error = may_create(dir, dentry, nd);
+	if (error)
+		goto out;
+
 	if (!dir->i_op || !dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
 	mode &= S_IALLUGO;
 	mode |= S_IFREG;
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
-		return error;
+		goto out;
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error)
 		fsnotify_create(dir, dentry);
+out:
+	mnt_put_write(nd.mnt);
 	return error;
 }
 
@@ -2007,13 +2014,21 @@
 			error = -EBUSY;
 			goto exit1;
 	}
+	error = -EROFS;
+	if (nd_is_readonly(&nd))
+		goto exit1;
 	mutex_lock(&nd.dentry->d_inode->i_mutex);
 	dentry = lookup_hash(&nd);
 	error = PTR_ERR(dentry);
-	if (!IS_ERR(dentry)) {
-		error = vfs_rmdir(nd.dentry->d_inode, dentry);
-		dput(dentry);
-	}
+	if (IS_ERR(dentry))
+		goto exit2;
+	if (!mnt_want_write(nd.mnt))
+		goto exit3;
+	error = vfs_rmdir(nd.dentry->d_inode, dentry);
+	mnt_drop_write(nd.mnt);
+exit3:
+	dput(dentry);
+exit2:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
 exit1:
 	path_release(&nd);
@@ -2081,6 +2096,8 @@
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
+	if (nd_is_readonly(&nd))
+		goto exit1;
 	mutex_lock(&nd.dentry->d_inode->i_mutex);
 	dentry = lookup_hash(&nd);
 	error = PTR_ERR(dentry);
@@ -2091,7 +2108,11 @@
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
+		error = mnt_want_write(nd.mnt);
+		if (error)
+			goto exit2;
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
+		mnt_put_write(nd.mnt);
 	exit2:
 		dput(dentry);
 	}
@@ -2456,16 +2477,21 @@
 	if (newnd.last_type != LAST_NORM)
 		goto exit2;
 
+	if (!mnt_want_write(oldnd.mnt))
+		goto exit2;
+	if (!mnt_want_write(newnd.mnt))
+		goto exit3;
+
 	trap = lock_rename(new_dir, old_dir);
 
 	old_dentry = lookup_hash(&oldnd);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
-		goto exit3;
+		goto exit4;
 	/* source must exist */
 	error = -ENOENT;
 	if (!old_dentry->d_inode)
-		goto exit4;
+		goto exit5;
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!S_ISDIR(old_dentry->d_inode->i_mode)) {
 		error = -ENOTDIR;
@@ -2477,24 +2503,27 @@
 	/* source should not be ancestor of target */
 	error = -EINVAL;
 	if (old_dentry == trap)
-		goto exit4;
+		goto exit5;
 	new_dentry = lookup_hash(&newnd);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
-		goto exit4;
+		goto exit5;
 	/* target should not be an ancestor of source */
 	error = -ENOTEMPTY;
 	if (new_dentry == trap)
-		goto exit5;
+		goto exit6;
 
 	error = vfs_rename(old_dir->d_inode, old_dentry,
 				   new_dir->d_inode, new_dentry);
-exit5:
+exit6:
 	dput(new_dentry);
-exit4:
+exit5:
 	dput(old_dentry);
-exit3:
+exit4:
+	mnt_drop_write(newnd.mnt);
 	unlock_rename(new_dir, old_dir);
+exit3:
+	mnt_drop_write(oldnd.mnt);
 exit2:
 	path_release(&newnd);
 exit1:
--- linux.orig/fs/namespace.c~convert-permission-to-file-and-vfs	2006-06-02 07:40:33.000000000 -0700
+++ linux/fs/namespace.c	2006-06-02 07:40:33.000000000 -0700
@@ -66,6 +66,7 @@
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count, 1);
+		/* atomic_set(&mnt->writer_count, 0); */
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
--- linux.orig/include/linux/mount.h~convert-permission-to-file-and-vfs	2006-06-02 07:40:33.000000000 -0700
+++ linux/include/linux/mount.h	2006-06-02 07:40:33.000000000 -0700
@@ -38,6 +38,7 @@
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
+	atomic_t writer_count;
 	int mnt_flags;
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
@@ -58,6 +59,26 @@
 	return mnt;
 }
 
+static inline int mnt_readonly(struct vfsmount *mnt)
+{
+	if (mnt->mnt_sb->s_flags & MS_RDONLY)
+		return -EROFS;
+	return 0;
+}
+
+static inline int mnt_want_write(struct vfsmount *mnt)
+{
+	if (mnt_readonly(mnt))
+		return -EROFS;
+	atomic_inc(&mnt->mnt_writers);
+	return 0;
+}
+
+static inline int mnt_drop_write(struct vfsmount *mnt)
+{
+	atomic_dec(&mnt->mnt_writers);
+}
+
 extern void mntput_no_expire(struct vfsmount *mnt);
 extern void mnt_pin(struct vfsmount *mnt);
 extern void mnt_unpin(struct vfsmount *mnt);
--- linux.orig/ipc/mqueue.c~elevate-writers-vfs_unlink	2006-06-02 07:40:34.000000000 -0700
+++ linux/ipc/mqueue.c	2006-06-02 07:40:34.000000000 -0700
@@ -738,8 +738,11 @@
 	inode = dentry->d_inode;
 	if (inode)
 		atomic_inc(&inode->i_count);
-
+	err = mnt_want_write(mqueue_mnt);
+	if (err)
+		goto out_err;
 	err = vfs_unlink(dentry->d_parent->d_inode, dentry);
+	mnt_put_write(mqueue_mnt);
 out_err:
 	dput(dentry);
 



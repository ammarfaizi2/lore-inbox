Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUCOIBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 03:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCOIBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 03:01:05 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:64206 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262133AbUCOH6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:58:16 -0500
Date: Mon, 15 Mar 2004 08:58:14 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040315075814.GE31818@MAIL.13thfloor.at>
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

diff -NurpP --minimal linux-2.6.4-20040314_2308/include/linux/posix_acl.h linux-2.6.4-20040314_2308-bme0.04.1/include/linux/posix_acl.h
--- linux-2.6.4-20040314_2308/include/linux/posix_acl.h	2004-03-11 03:55:54.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/include/linux/posix_acl.h	2004-03-15 07:45:19.000000000 +0100
@@ -9,6 +9,7 @@
 #define __LINUX_POSIX_ACL_H
 
 #include <linux/slab.h>
+#include <linux/namei.h>
 
 #define ACL_UNDEFINED_ID	(-1)
 
diff -NurpP --minimal linux-2.6.4-20040314_2308/include/linux/fs.h linux-2.6.4-20040314_2308-bme0.04.1/include/linux/fs.h
--- linux-2.6.4-20040314_2308/include/linux/fs.h	2004-03-15 05:41:50.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/include/linux/fs.h	2004-03-15 06:42:13.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/mount.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -155,7 +156,8 @@ extern int leases_enable, dir_notify_ena
  */
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
+#define IS_RDONLY_INODE(inode)	((inode)->i_sb->s_flags & MS_RDONLY)
+#define IS_RDONLY(inode,mount)	(IS_RDONLY_INODE(inode) || MNT_IS_RDONLY(mount))
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
 					((inode)->i_flags & S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
@@ -1226,7 +1228,7 @@ extern sector_t bmap(struct inode *, sec
 extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int, struct nameidata *);
-extern int vfs_permission(struct inode *, int);
+extern int vfs_permission(struct inode *, int, struct nameidata *);
 extern int get_write_access(struct inode *);
 extern int deny_write_access(struct file *);
 static inline void put_write_access(struct inode * inode)
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/open.c linux-2.6.4-20040314_2308-bme0.04.1/fs/open.c
--- linux-2.6.4-20040314_2308/fs/open.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/open.c	2004-03-15 05:58:51.000000000 +0100
@@ -226,7 +226,7 @@ static inline long do_sys_truncate(const
 		goto dput_and_out;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -350,7 +350,7 @@ asmlinkage long sys_utime(char __user * 
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -407,7 +407,7 @@ long do_utimes(char __user * filename, s
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -489,8 +489,9 @@ asmlinkage long sys_access(const char __
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode, &nd);
 		/* SuS v2 requires we report a read only fs too */
-		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
-		   && !special_file(nd.dentry->d_inode->i_mode))
+		if (!res && (mode & S_IWOTH)
+		   && !special_file(nd.dentry->d_inode->i_mode)
+		   && (IS_RDONLY(nd.dentry->d_inode, nd.mnt)))
 			res = -EROFS;
 		path_release(&nd);
 	}
@@ -595,7 +596,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	inode = dentry->d_inode;
 
 	err = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, file->f_vfsmnt))
 		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -627,7 +628,7 @@ asmlinkage long sys_chmod(const char __u
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -648,7 +649,7 @@ out:
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct vfsmount *mnt, struct dentry * dentry, uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -660,7 +661,7 @@ static int chown_common(struct dentry * 
 		goto out;
 	}
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, mnt))
 		goto out;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -690,7 +691,7 @@ asmlinkage long sys_chown(const char __u
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -703,7 +704,7 @@ asmlinkage long sys_lchown(const char __
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -717,7 +718,7 @@ asmlinkage long sys_fchown(unsigned int 
 
 	file = fget(fd);
 	if (file) {
-		error = chown_common(file->f_dentry, user, group);
+		error = chown_common(file->f_vfsmnt, file->f_dentry, user, group);
 		fput(file);
 	}
 	return error;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/namei.c linux-2.6.4-20040314_2308-bme0.04.1/fs/namei.c
--- linux-2.6.4-20040314_2308/fs/namei.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/namei.c	2004-03-15 07:29:50.000000000 +0100
@@ -209,14 +209,18 @@ int permission(struct inode * inode,int 
 {
 	int retval;
 	int submask;
+	umode_t	mode = inode->i_mode;
 
 	/* Ordinary permission routines do not understand MAY_APPEND. */
 	submask = mask & ~MAY_APPEND;
 
+	if (nd && (mask & MAY_WRITE) && MNT_IS_RDONLY(nd->mnt) &&
+		(S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+		return -EROFS;
 	if (inode->i_op && inode->i_op->permission)
 		retval = inode->i_op->permission(inode, submask, nd);
 	else
-		retval = vfs_permission(inode, submask);
+		retval = vfs_permission(inode, submask, nd);
 	if (retval)
 		return retval;
 
@@ -1062,6 +1066,24 @@ static inline int may_create(struct inod
 	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
 }
 
+static inline int mnt_may_create(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+       if (child->d_inode)
+               return -EEXIST;
+       if (IS_DEADDIR(dir))
+               return -ENOENT;
+       if (mnt->mnt_flags & MNT_RDONLY)
+               return -EROFS;
+       return 0;
+}
+
+static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+       if (!child->d_inode)
+               return -ENOENT;
+       if (mnt->mnt_flags & MNT_RDONLY)
+               return -EROFS;
+       return 0;
+}
+
 /* 
  * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
  * reasons.
@@ -1183,7 +1205,7 @@ int may_open(struct nameidata *nd, int a
 			return -EACCES;
 
 		flag &= ~O_TRUNC;
-	} else if (IS_RDONLY(inode) && (flag & FMODE_WRITE))
+	} else if ((IS_RDONLY(inode, nd->mnt)) && (flag & FMODE_WRITE))
 		return -EROFS;
 	/*
 	 * An append-only file must be opened in append mode for writing.
@@ -1408,23 +1430,28 @@ do_link:
 struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
+	int error;
 
 	down(&nd->dentry->d_inode->i_sem);
-	dentry = ERR_PTR(-EEXIST);
+	error = -EEXIST;
 	if (nd->last_type != LAST_NORM)
-		goto fail;
+		goto out;
 	nd->flags &= ~LOOKUP_PARENT;
 	dentry = lookup_hash(&nd->last, nd->dentry);
 	if (IS_ERR(dentry))
+		goto ret;
+	error = mnt_may_create(nd->mnt, nd->dentry->d_inode, dentry);
+	if (error)
 		goto fail;
+	error = -ENOENT;
 	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
-		goto enoent;
+		goto fail;
+ret:
 	return dentry;
-enoent:
-	dput(dentry);
-	dentry = ERR_PTR(-ENOENT);
 fail:
-	return dentry;
+	dput(dentry);
+out:
+	return ERR_PTR(error);
 }
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
@@ -1653,7 +1680,11 @@ asmlinkage long sys_rmdir(const char __u
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (error)
+			goto exit2;
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+	exit2:
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1725,6 +1756,9 @@ asmlinkage long sys_unlink(const char __
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (error)
+			goto exit2;
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
@@ -2089,6 +2123,9 @@ static inline int do_rename(const char *
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd.last, new_dir);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurpP --minimal linux-2.6.4-20040314_2308/arch/sparc64/solaris/fs.c linux-2.6.4-20040314_2308-bme0.04.1/arch/sparc64/solaris/fs.c
--- linux-2.6.4-20040314_2308/arch/sparc64/solaris/fs.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/arch/sparc64/solaris/fs.c	2004-03-15 06:26:55.000000000 +0100
@@ -405,7 +405,7 @@ static int report_statvfs(struct vfsmoun
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
-		if (IS_RDONLY(inode)) i = 1;
+		if (IS_RDONLY(inode, mnt)) i = 1;
 		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (!sysv_valid_dev(inode->i_sb->s_dev))
 			return -EOVERFLOW;
@@ -441,7 +441,7 @@ static int report_statvfs64(struct vfsmo
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
-		if (IS_RDONLY(inode)) i = 1;
+		if (IS_RDONLY(inode, mnt)) i = 1;
 		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (!sysv_valid_dev(inode->i_sb->s_dev))
 			return -EOVERFLOW;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext2/ioctl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/ioctl.c
--- linux-2.6.4-20040314_2308/fs/ext2/ioctl.c	2004-03-11 03:55:54.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/ioctl.c	2004-03-15 05:58:51.000000000 +0100
@@ -29,7 +30,7 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -68,7 +69,7 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext2/xattr.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/xattr.c
--- linux-2.6.4-20040314_2308/fs/ext2/xattr.c	2004-03-11 03:55:34.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/xattr.c	2004-03-15 06:27:13.000000000 +0100
@@ -496,7 +496,7 @@ ext2_xattr_set(struct inode *inode, int 
 	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
 		  name_index, name, value, (long)value_len);
 
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY_INODE(inode))
 		return -EROFS;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		return -EPERM;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext3/ioctl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/ioctl.c
--- linux-2.6.4-20040314_2308/fs/ext3/ioctl.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/ioctl.c	2004-03-15 05:58:51.000000000 +0100
@@ -34,7 +35,7 @@ int ext3_ioctl (struct inode * inode, st
 		unsigned int oldflags;
 		unsigned int jflag;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -110,7 +111,7 @@ flags_err:
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(generation, (int *) arg))
 			return -EFAULT;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext3/xattr.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/xattr.c
--- linux-2.6.4-20040314_2308/fs/ext3/xattr.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/xattr.c	2004-03-15 06:28:18.000000000 +0100
@@ -496,7 +496,7 @@ ext3_xattr_set_handle(handle_t *handle, 
 	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
 		  name_index, name, value, (long)value_len);
 
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY_INODE(inode))
 		return -EROFS;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		return -EPERM;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/hfs/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/hfs/inode.c
--- linux-2.6.4-20040314_2308/fs/hfs/inode.c	2004-03-11 03:55:54.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/hfs/inode.c	2004-03-15 06:23:57.000000000 +0100
@@ -516,7 +516,7 @@ static int hfs_permission(struct inode *
 {
 	if (S_ISREG(inode->i_mode) && mask & MAY_EXEC)
 		return 0;
-	return vfs_permission(inode, mask);
+	return vfs_permission(inode, mask, nd);
 }
 
 static int hfs_file_open(struct inode *inode, struct file *file)
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/hfsplus/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/hfsplus/inode.c
--- linux-2.6.4-20040314_2308/fs/hfsplus/inode.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/hfsplus/inode.c	2004-03-15 06:23:48.000000000 +0100
@@ -260,7 +260,7 @@ static int hfsplus_permission(struct ino
 	 */
 	if (S_ISREG(inode->i_mode) && mask & MAY_EXEC && !(inode->i_mode & 0111))
 		return 0;
-	return vfs_permission(inode, mask);
+	return vfs_permission(inode, mask, nd);
 }
 
 
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/intermezzo/dir.c linux-2.6.4-20040314_2308-bme0.04.1/fs/intermezzo/dir.c
--- linux-2.6.4-20040314_2308/fs/intermezzo/dir.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/intermezzo/dir.c	2004-03-15 06:23:38.000000000 +0100
@@ -864,7 +864,7 @@ int presto_permission(struct inode *inod
         /* The cache filesystem doesn't have its own permission function,
          * so we call the default one.
          */
-        rc = vfs_permission(inode, mask);
+        rc = vfs_permission(inode, mask, nd);
 
         EXIT;
         return rc;
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/intermezzo/vfs.c linux-2.6.4-20040314_2308-bme0.04.1/fs/intermezzo/vfs.c
--- linux-2.6.4-20040314_2308/fs/intermezzo/vfs.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/intermezzo/vfs.c	2004-03-15 06:40:07.000000000 +0100
@@ -258,7 +258,7 @@ int presto_settime(struct presto_file_se
                 inode = dentry->d_inode;
 
                 error = -EROFS;
-                if (IS_RDONLY(inode)) {
+                if (IS_RDONLY_INODE(inode)) {
                         EXIT;
                         return -EROFS;
                 }
@@ -373,7 +373,7 @@ int presto_do_setattr(struct presto_file
 
         ENTRY;
         error = -EROFS;
-        if (IS_RDONLY(inode)) {
+        if (IS_RDONLY_INODE(inode)) {
                 EXIT;
                 return -EROFS;
         }
@@ -2316,7 +2316,7 @@ int presto_do_set_ext_attr(struct presto
 
         ENTRY;
         error = -EROFS;
-        if (IS_RDONLY(inode)) {
+        if (IS_RDONLY_INODE(inode)) {
                 EXIT;
                 return -EROFS;
         }
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/hfsplus/ioctl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/hfsplus/ioctl.c
--- linux-2.6.4-20040314_2308/fs/hfsplus/ioctl.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/hfsplus/ioctl.c	2004-03-15 06:29:01.000000000 +0100
@@ -33,7 +33,7 @@ int hfsplus_ioctl(struct inode *inode, s
 			flags |= EXT2_FLAG_NODUMP; /* EXT2_NODUMP_FL */
 		return put_user(flags, (int *)arg);
 	case HFSPLUS_IOC_EXT2_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/inode.c
--- linux-2.6.4-20040314_2308/fs/inode.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/inode.c	2004-03-15 06:32:33.000000000 +0100
@@ -1173,14 +1175,14 @@ EXPORT_SYMBOL(update_atime);
  *	When ctime_too is specified update the ctime too.
  */
 
-void inode_update_time(struct inode *inode, int ctime_too)
+void inode_update_time(struct inode *inode, int ctime_too, struct vfsmount *mount)
 {
 	struct timespec now;
 	int sync_it = 0;
 
 	if (IS_NOCMTIME(inode))
 		return;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, mount))
 		return;
 
 	now = current_kernel_time();
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/nfs/dir.c linux-2.6.4-20040314_2308-bme0.04.1/fs/nfs/dir.c
--- linux-2.6.4-20040314_2308/fs/nfs/dir.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/nfs/dir.c	2004-03-15 06:24:31.000000000 +0100
@@ -778,7 +778,8 @@ static int is_atomic_open(struct inode *
 	if (nd->flags & LOOKUP_DIRECTORY)
 		return 0;
 	/* Are we trying to write to a read only partition? */
-	if (IS_RDONLY(dir) && (nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
+	if (IS_RDONLY(dir, nd->mnt) &&
+		(nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
 		return 0;
 	return 1;
 }
@@ -1514,7 +1515,7 @@ nfs_permission(struct inode *inode, int 
 		 * Nobody gets write access to a read-only fs.
 		 *
 		 */
-		if (IS_RDONLY(inode) &&
+		if (IS_RDONLY(inode, nd->mnt) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
 
@@ -1565,7 +1566,7 @@ out:
 	return res;
 out_notsup:
 	nfs_revalidate_inode(NFS_SERVER(inode), inode);
-	res = vfs_permission(inode, mask);
+	res = vfs_permission(inode, mask, nd);
 	unlock_kernel();
 	return res;
 add_cache:
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/proc/base.c linux-2.6.4-20040314_2308-bme0.04.1/fs/proc/base.c
--- linux-2.6.4-20040314_2308/fs/proc/base.c	2004-03-11 03:55:34.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/proc/base.c	2004-03-15 06:24:42.000000000 +0100
@@ -449,7 +449,7 @@ out:
 
 static int proc_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
-	if (vfs_permission(inode, mask) != 0)
+	if (vfs_permission(inode, mask, nd) != 0)
 		return -EACCES;
 	return proc_check_root(inode);
 }
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/reiserfs/ioctl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/reiserfs/ioctl.c
--- linux-2.6.4-20040314_2308/fs/reiserfs/ioctl.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/reiserfs/ioctl.c	2004-03-15 05:58:51.000000000 +0100
@@ -38,7 +39,7 @@ int reiserfs_ioctl (struct inode * inode
 		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
 		return put_user(flags, (int *) arg);
 	case REISERFS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -70,7 +71,7 @@ int reiserfs_ioctl (struct inode * inode
 	case REISERFS_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode, filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	

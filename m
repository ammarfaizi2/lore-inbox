Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWB1F3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWB1F3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWB1F3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:29:07 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:4258 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751819AbWB1F3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:29:05 -0500
Date: Tue, 28 Feb 2006 06:29:03 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [RFC 1/2] vfs: remove nameidata from *_permission()
Message-ID: <20060228052903.GB6494@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060228052606.GA6494@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060228052606.GA6494@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


remove struct nameidata from *_permission() and 
related security functions.

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---

diff -NurpP --minimal linux-2.6.16-rc5/fs/cifs/cifsfs.c linux-2.6.16-rc5-vfs0.02.1/fs/cifs/cifsfs.c
--- linux-2.6.16-rc5/fs/cifs/cifsfs.c	2006-02-28 03:41:04 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/cifs/cifsfs.c	2006-02-28 05:08:53 +0100
@@ -220,7 +220,7 @@ cifs_statfs(struct super_block *sb, stru
 				   longer available? */
 }
 
-static int cifs_permission(struct inode * inode, int mask, struct nameidata *nd)
+static int cifs_permission(struct inode * inode, int mask)
 {
 	struct cifs_sb_info *cifs_sb;
 
diff -NurpP --minimal linux-2.6.16-rc5/fs/coda/dir.c linux-2.6.16-rc5-vfs0.02.1/fs/coda/dir.c
--- linux-2.6.16-rc5/fs/coda/dir.c	2006-02-28 03:41:04 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/coda/dir.c	2006-02-28 05:08:18 +0100
@@ -151,7 +151,7 @@ exit:
 }
 
 
-int coda_permission(struct inode *inode, int mask, struct nameidata *nd)
+int coda_permission(struct inode *inode, int mask)
 {
         int error = 0;
  
diff -NurpP --minimal linux-2.6.16-rc5/fs/coda/pioctl.c linux-2.6.16-rc5-vfs0.02.1/fs/coda/pioctl.c
--- linux-2.6.16-rc5/fs/coda/pioctl.c	2004-08-14 12:55:47 +0200
+++ linux-2.6.16-rc5-vfs0.02.1/fs/coda/pioctl.c	2006-02-28 06:04:48 +0100
@@ -24,8 +24,7 @@
 #include <linux/coda_psdev.h>
 
 /* pioctl ops */
-static int coda_ioctl_permission(struct inode *inode, int mask,
-				 struct nameidata *nd);
+static int coda_ioctl_permission(struct inode *inode, int mask);
 static int coda_pioctl(struct inode * inode, struct file * filp, 
                        unsigned int cmd, unsigned long user_data);
 
@@ -42,8 +41,7 @@ struct file_operations coda_ioctl_operat
 };
 
 /* the coda pioctl inode ops */
-static int coda_ioctl_permission(struct inode *inode, int mask,
-				 struct nameidata *nd)
+static int coda_ioctl_permission(struct inode *inode, int mask)
 {
         return 0;
 }
diff -NurpP --minimal linux-2.6.16-rc5/fs/ext2/acl.c linux-2.6.16-rc5-vfs0.02.1/fs/ext2/acl.c
--- linux-2.6.16-rc5/fs/ext2/acl.c	2006-02-28 03:41:04 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/ext2/acl.c	2006-02-28 05:09:10 +0100
@@ -294,7 +294,7 @@ ext2_check_acl(struct inode *inode, int 
 }
 
 int
-ext2_permission(struct inode *inode, int mask, struct nameidata *nd)
+ext2_permission(struct inode *inode, int mask)
 {
 	return generic_permission(inode, mask, ext2_check_acl);
 }
diff -NurpP --minimal linux-2.6.16-rc5/fs/ext3/acl.c linux-2.6.16-rc5-vfs0.02.1/fs/ext3/acl.c
--- linux-2.6.16-rc5/fs/ext3/acl.c	2006-02-28 03:41:04 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/ext3/acl.c	2006-02-28 05:09:22 +0100
@@ -299,7 +299,7 @@ ext3_check_acl(struct inode *inode, int 
 }
 
 int
-ext3_permission(struct inode *inode, int mask, struct nameidata *nd)
+ext3_permission(struct inode *inode, int mask)
 {
 	return generic_permission(inode, mask, ext3_check_acl);
 }
diff -NurpP --minimal linux-2.6.16-rc5/fs/fuse/dir.c linux-2.6.16-rc5-vfs0.02.1/fs/fuse/dir.c
--- linux-2.6.16-rc5/fs/fuse/dir.c	2006-02-28 03:41:05 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/fuse/dir.c	2006-02-28 05:56:38 +0100
@@ -702,7 +702,7 @@ static int fuse_access(struct inode *ino
  * access request is sent.  Execute permission is still checked
  * locally based on file mode.
  */
-static int fuse_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int fuse_permission(struct inode *inode, int mask)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
diff -NurpP --minimal linux-2.6.16-rc5/fs/hfs/inode.c linux-2.6.16-rc5-vfs0.02.1/fs/hfs/inode.c
--- linux-2.6.16-rc5/fs/hfs/inode.c	2006-02-28 03:41:05 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/hfs/inode.c	2006-02-28 05:11:18 +0100
@@ -519,8 +519,7 @@ void hfs_clear_inode(struct inode *inode
 	}
 }
 
-static int hfs_permission(struct inode *inode, int mask,
-			  struct nameidata *nd)
+static int hfs_permission(struct inode *inode, int mask)
 {
 	if (S_ISREG(inode->i_mode) && mask & MAY_EXEC)
 		return 0;
diff -NurpP --minimal linux-2.6.16-rc5/fs/hfsplus/inode.c linux-2.6.16-rc5-vfs0.02.1/fs/hfsplus/inode.c
--- linux-2.6.16-rc5/fs/hfsplus/inode.c	2006-02-28 03:41:05 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/hfsplus/inode.c	2006-02-28 05:11:30 +0100
@@ -237,7 +237,7 @@ static void hfsplus_set_perms(struct ino
 	perms->dev = cpu_to_be32(HFSPLUS_I(inode).dev);
 }
 
-static int hfsplus_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int hfsplus_permission(struct inode *inode, int mask)
 {
 	/* MAY_EXEC is also used for lookup, if no x bit is set allow lookup,
 	 * open_exec has the same test, so it's still not executable, if a x bit
diff -NurpP --minimal linux-2.6.16-rc5/fs/hostfs/hostfs_kern.c linux-2.6.16-rc5-vfs0.02.1/fs/hostfs/hostfs_kern.c
--- linux-2.6.16-rc5/fs/hostfs/hostfs_kern.c	2006-01-03 17:29:56 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/hostfs/hostfs_kern.c	2006-02-28 05:11:51 +0100
@@ -796,7 +796,7 @@ int hostfs_rename(struct inode *from_ino
 	return(err);
 }
 
-int hostfs_permission(struct inode *ino, int desired, struct nameidata *nd)
+int hostfs_permission(struct inode *ino, int desired)
 {
 	char *name;
 	int r = 0, w = 0, x = 0, err;
diff -NurpP --minimal linux-2.6.16-rc5/fs/hpfs/namei.c linux-2.6.16-rc5-vfs0.02.1/fs/hpfs/namei.c
--- linux-2.6.16-rc5/fs/hpfs/namei.c	2004-08-14 12:55:19 +0200
+++ linux-2.6.16-rc5-vfs0.02.1/fs/hpfs/namei.c	2006-02-28 04:54:18 +0100
@@ -415,7 +415,7 @@ again:
 		d_drop(dentry);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count) > 1 ||
-		    permission(inode, MAY_WRITE, NULL) ||
+		    permission(inode, MAY_WRITE) ||
 		    !S_ISREG(inode->i_mode) ||
 		    get_write_access(inode)) {
 			spin_unlock(&dentry->d_lock);
diff -NurpP --minimal linux-2.6.16-rc5/fs/jfs/acl.c linux-2.6.16-rc5-vfs0.02.1/fs/jfs/acl.c
--- linux-2.6.16-rc5/fs/jfs/acl.c	2005-10-28 20:49:44 +0200
+++ linux-2.6.16-rc5-vfs0.02.1/fs/jfs/acl.c	2006-02-28 05:12:01 +0100
@@ -140,7 +140,7 @@ static int jfs_check_acl(struct inode *i
 	return -EAGAIN;
 }
 
-int jfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+int jfs_permission(struct inode *inode, int mask)
 {
 	return generic_permission(inode, mask, jfs_check_acl);
 }
diff -NurpP --minimal linux-2.6.16-rc5/fs/jfs/jfs_acl.h linux-2.6.16-rc5-vfs0.02.1/fs/jfs/jfs_acl.h
--- linux-2.6.16-rc5/fs/jfs/jfs_acl.h	2005-10-28 20:49:44 +0200
+++ linux-2.6.16-rc5-vfs0.02.1/fs/jfs/jfs_acl.h	2006-02-28 06:07:00 +0100
@@ -20,7 +20,7 @@
 
 #ifdef CONFIG_JFS_POSIX_ACL
 
-int jfs_permission(struct inode *, int, struct nameidata *);
+int jfs_permission(struct inode *, int);
 int jfs_init_acl(tid_t, struct inode *, struct inode *);
 int jfs_setattr(struct dentry *, struct iattr *);
 
diff -NurpP --minimal linux-2.6.16-rc5/fs/namei.c linux-2.6.16-rc5-vfs0.02.1/fs/namei.c
--- linux-2.6.16-rc5/fs/namei.c	2006-02-28 03:41:07 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/namei.c	2006-02-28 05:34:28 +0100
@@ -225,7 +225,7 @@ int generic_permission(struct inode *ino
 	return -EACCES;
 }
 
-int permission(struct inode *inode, int mask, struct nameidata *nd)
+int permission(struct inode *inode, int mask)
 {
 	int retval, submask;
 
@@ -250,13 +250,13 @@ int permission(struct inode *inode, int 
 	/* Ordinary permission routines do not understand MAY_APPEND. */
 	submask = mask & ~MAY_APPEND;
 	if (inode->i_op && inode->i_op->permission)
-		retval = inode->i_op->permission(inode, submask, nd);
+		retval = inode->i_op->permission(inode, submask);
 	else
 		retval = generic_permission(inode, submask, NULL);
 	if (retval)
 		return retval;
 
-	return security_inode_permission(inode, mask, nd);
+	return security_inode_permission(inode, mask);
 }
 
 /**
@@ -271,7 +271,8 @@ int permission(struct inode *inode, int 
  */
 int vfs_permission(struct nameidata *nd, int mask)
 {
-	return permission(nd->dentry->d_inode, mask, nd);
+	/* do nd based stuff here */
+	return permission(nd->dentry->d_inode, mask);
 }
 
 /**
@@ -288,7 +289,8 @@ int vfs_permission(struct nameidata *nd,
  */
 int file_permission(struct file *file, int mask)
 {
-	return permission(file->f_dentry->d_inode, mask, NULL);
+	/* do file based stuff here */
+	return permission(file->f_dentry->d_inode, mask);
 }
 
 /*
@@ -425,7 +427,7 @@ static int exec_permission_lite(struct i
 
 	return -EACCES;
 ok:
-	return security_inode_permission(inode, MAY_EXEC, nd);
+	return security_inode_permission(inode, MAY_EXEC);
 }
 
 /*
@@ -1219,7 +1221,8 @@ static struct dentry * __lookup_hash(str
 	int err;
 
 	inode = base->d_inode;
-	err = permission(inode, MAY_EXEC, nd);
+	/* should become vfs_permission() */
+	err = permission(inode, MAY_EXEC);
 	dentry = ERR_PTR(err);
 	if (err)
 		goto out;
@@ -1354,7 +1357,7 @@ static int may_delete(struct inode *dir,
 
 	BUG_ON(victim->d_parent->d_inode != dir);
 
-	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
+	error = permission(dir,MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -1391,7 +1394,8 @@ static inline int may_create(struct inod
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
+	/* should become vfs_permission() */
+	return permission(dir,MAY_WRITE | MAY_EXEC);
 }
 
 /* 
@@ -2313,7 +2317,7 @@ static int vfs_rename_dir(struct inode *
 	 * we'll need to flip '..'.
 	 */
 	if (new_dir != old_dir) {
-		error = permission(old_dentry->d_inode, MAY_WRITE, NULL);
+		error = permission(old_dentry->d_inode, MAY_WRITE);
 		if (error)
 			return error;
 	}
diff -NurpP --minimal linux-2.6.16-rc5/fs/nfs/dir.c linux-2.6.16-rc5-vfs0.02.1/fs/nfs/dir.c
--- linux-2.6.16-rc5/fs/nfs/dir.c	2006-02-28 03:41:07 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/nfs/dir.c	2006-02-28 05:56:38 +0100
@@ -1635,7 +1635,7 @@ out:
 	return -EACCES;
 }
 
-int nfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+int nfs_permission(struct inode *inode, int mask)
 {
 	struct rpc_cred *cred;
 	int res = 0;
diff -NurpP --minimal linux-2.6.16-rc5/fs/nfsd/nfsfh.c linux-2.6.16-rc5-vfs0.02.1/fs/nfsd/nfsfh.c
--- linux-2.6.16-rc5/fs/nfsd/nfsfh.c	2005-06-22 02:38:37 +0200
+++ linux-2.6.16-rc5-vfs0.02.1/fs/nfsd/nfsfh.c	2006-02-28 05:35:53 +0100
@@ -56,7 +56,7 @@ static int nfsd_acceptable(void *expv, s
 		/* make sure parents give x permission to user */
 		int err;
 		parent = dget_parent(tdentry);
-		err = permission(parent->d_inode, MAY_EXEC, NULL);
+		err = permission(parent->d_inode, MAY_EXEC);
 		if (err < 0) {
 			dput(parent);
 			break;
diff -NurpP --minimal linux-2.6.16-rc5/fs/nfsd/vfs.c linux-2.6.16-rc5-vfs0.02.1/fs/nfsd/vfs.c
--- linux-2.6.16-rc5/fs/nfsd/vfs.c	2006-02-28 03:41:07 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/nfsd/vfs.c	2006-02-28 05:36:11 +0100
@@ -1817,12 +1817,12 @@ nfsd_permission(struct svc_export *exp, 
 	    inode->i_uid == current->fsuid)
 		return 0;
 
-	err = permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC), NULL);
+	err = permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC));
 
 	/* Allow read access to binaries even when mode 111 */
 	if (err == -EACCES && S_ISREG(inode->i_mode) &&
 	    acc == (MAY_READ | MAY_OWNER_OVERRIDE))
-		err = permission(inode, MAY_EXEC, NULL);
+		err = permission(inode, MAY_EXEC);
 
 	return err? nfserrno(err) : 0;
 }
diff -NurpP --minimal linux-2.6.16-rc5/fs/proc/base.c linux-2.6.16-rc5-vfs0.02.1/fs/proc/base.c
--- linux-2.6.16-rc5/fs/proc/base.c	2006-02-28 03:41:08 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/proc/base.c	2006-02-28 05:14:35 +0100
@@ -579,14 +579,14 @@ static int proc_check_root(struct inode 
 	return proc_check_chroot(root, vfsmnt);
 }
 
-static int proc_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int proc_permission(struct inode *inode, int mask)
 {
 	if (generic_permission(inode, mask, NULL) != 0)
 		return -EACCES;
 	return proc_check_root(inode);
 }
 
-static int proc_task_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int proc_task_permission(struct inode *inode, int mask)
 {
 	struct dentry *root;
 	struct vfsmount *vfsmnt;
diff -NurpP --minimal linux-2.6.16-rc5/fs/reiserfs/xattr.c linux-2.6.16-rc5-vfs0.02.1/fs/reiserfs/xattr.c
--- linux-2.6.16-rc5/fs/reiserfs/xattr.c	2006-02-28 03:41:08 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/reiserfs/xattr.c	2006-02-28 05:14:55 +0100
@@ -1343,7 +1343,7 @@ static int reiserfs_check_acl(struct ino
 	return error;
 }
 
-int reiserfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+int reiserfs_permission(struct inode *inode, int mask)
 {
 	/*
 	 * We don't do permission checks on the internal objects.
diff -NurpP --minimal linux-2.6.16-rc5/fs/smbfs/file.c linux-2.6.16-rc5-vfs0.02.1/fs/smbfs/file.c
--- linux-2.6.16-rc5/fs/smbfs/file.c	2006-02-28 03:41:08 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/smbfs/file.c	2006-02-28 05:15:06 +0100
@@ -387,7 +387,7 @@ smb_file_release(struct inode *inode, st
  * privileges, so we need our own check for this.
  */
 static int
-smb_file_permission(struct inode *inode, int mask, struct nameidata *nd)
+smb_file_permission(struct inode *inode, int mask)
 {
 	int mode = inode->i_mode;
 	int error = 0;
diff -NurpP --minimal linux-2.6.16-rc5/fs/xattr.c linux-2.6.16-rc5-vfs0.02.1/fs/xattr.c
--- linux-2.6.16-rc5/fs/xattr.c	2006-02-28 03:41:08 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/xattr.c	2006-02-28 05:35:18 +0100
@@ -58,7 +58,7 @@ xattr_permission(struct inode *inode, co
 			return -EPERM;
 	}
 
-	return permission(inode, mask, NULL);
+	return permission(inode, mask);
 }
 
 int
diff -NurpP --minimal linux-2.6.16-rc5/fs/xfs/linux-2.6/xfs_iops.c linux-2.6.16-rc5-vfs0.02.1/fs/xfs/linux-2.6/xfs_iops.c
--- linux-2.6.16-rc5/fs/xfs/linux-2.6/xfs_iops.c	2006-02-28 03:41:09 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/fs/xfs/linux-2.6/xfs_iops.c	2006-02-28 05:15:25 +0100
@@ -614,8 +614,7 @@ linvfs_put_link(
 STATIC int
 linvfs_permission(
 	struct inode	*inode,
-	int		mode,
-	struct nameidata *nd)
+	int		mode)
 {
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 	int		error;
diff -NurpP --minimal linux-2.6.16-rc5/include/linux/fs.h linux-2.6.16-rc5-vfs0.02.1/include/linux/fs.h
--- linux-2.6.16-rc5/include/linux/fs.h	2006-02-28 03:41:18 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/include/linux/fs.h	2006-02-28 05:29:44 +0100
@@ -1040,7 +1040,7 @@ struct inode_operations {
 	void * (*follow_link) (struct dentry *, struct nameidata *);
 	void (*put_link) (struct dentry *, struct nameidata *, void *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int, struct nameidata *);
+	int (*permission) (struct inode *, int);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
 	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
@@ -1465,7 +1465,8 @@ extern int do_remount_sb(struct super_bl
 			 void *data, int force);
 extern sector_t bmap(struct inode *, sector_t);
 extern int notify_change(struct dentry *, struct iattr *);
-extern int permission(struct inode *, int, struct nameidata *);
+extern int permission(struct inode *, int);
+// extern int vfs_permission(struct nameidata *, int);
 extern int generic_permission(struct inode *, int,
 		int (*check_acl)(struct inode *, int));
 
diff -NurpP --minimal linux-2.6.16-rc5/include/linux/nfs_fs.h linux-2.6.16-rc5-vfs0.02.1/include/linux/nfs_fs.h
--- linux-2.6.16-rc5/include/linux/nfs_fs.h	2006-02-28 03:41:19 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/include/linux/nfs_fs.h	2006-02-28 05:58:49 +0100
@@ -296,7 +296,7 @@ extern struct inode *nfs_fhget(struct su
 extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_post_op_update_inode(struct inode *inode, struct nfs_fattr *fattr);
 extern int nfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
-extern int nfs_permission(struct inode *, int, struct nameidata *);
+extern int nfs_permission(struct inode *, int);
 extern int nfs_access_get_cached(struct inode *, struct rpc_cred *, struct nfs_access_entry *);
 extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *);
 extern int nfs_open(struct inode *, struct file *);
diff -NurpP --minimal linux-2.6.16-rc5/include/linux/security.h linux-2.6.16-rc5-vfs0.02.1/include/linux/security.h
--- linux-2.6.16-rc5/include/linux/security.h	2006-02-28 03:41:19 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/include/linux/security.h	2006-02-28 06:09:30 +0100
@@ -346,7 +346,6 @@ struct swap_info_struct;
  *	called when the actual read/write operations are performed.
  *	@inode contains the inode structure to check.
  *	@mask contains the permission mask.
- *     @nd contains the nameidata (may be NULL).
  *	Return 0 if permission is granted.
  * @inode_setattr:
  *	Check permission before setting file attributes.  Note that the kernel
@@ -1157,7 +1156,7 @@ struct security_operations {
 	                     struct inode *new_dir, struct dentry *new_dentry);
 	int (*inode_readlink) (struct dentry *dentry);
 	int (*inode_follow_link) (struct dentry *dentry, struct nameidata *nd);
-	int (*inode_permission) (struct inode *inode, int mask, struct nameidata *nd);
+	int (*inode_permission) (struct inode *inode, int mask);
 	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
 	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
         void (*inode_delete) (struct inode *inode);
@@ -1606,12 +1605,11 @@ static inline int security_inode_follow_
 	return security_ops->inode_follow_link (dentry, nd);
 }
 
-static inline int security_inode_permission (struct inode *inode, int mask,
-					     struct nameidata *nd)
+static inline int security_inode_permission (struct inode *inode, int mask)
 {
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_permission (inode, mask, nd);
+	return security_ops->inode_permission (inode, mask);
 }
 
 static inline int security_inode_setattr (struct dentry *dentry,
@@ -2270,8 +2268,7 @@ static inline int security_inode_follow_
 	return 0;
 }
 
-static inline int security_inode_permission (struct inode *inode, int mask,
-					     struct nameidata *nd)
+static inline int security_inode_permission (struct inode *inode, int mask)
 {
 	return 0;
 }
diff -NurpP --minimal linux-2.6.16-rc5/ipc/mqueue.c linux-2.6.16-rc5-vfs0.02.1/ipc/mqueue.c
--- linux-2.6.16-rc5/ipc/mqueue.c	2006-02-28 03:41:21 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/ipc/mqueue.c	2006-02-28 05:28:20 +0100
@@ -639,7 +639,7 @@ static int oflag2acc[O_ACCMODE] = { MAY_
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL)) {
+	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE])) {
 		dput(dentry);
 		mntput(mqueue_mnt);
 		return ERR_PTR(-EACCES);
diff -NurpP --minimal linux-2.6.16-rc5/security/dummy.c linux-2.6.16-rc5-vfs0.02.1/security/dummy.c
--- linux-2.6.16-rc5/security/dummy.c	2006-02-28 03:41:33 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/security/dummy.c	2006-02-28 05:16:36 +0100
@@ -324,7 +324,7 @@ static int dummy_inode_follow_link (stru
 	return 0;
 }
 
-static int dummy_inode_permission (struct inode *inode, int mask, struct nameidata *nd)
+static int dummy_inode_permission (struct inode *inode, int mask)
 {
 	return 0;
 }
diff -NurpP --minimal linux-2.6.16-rc5/security/seclvl.c linux-2.6.16-rc5-vfs0.02.1/security/seclvl.c
--- linux-2.6.16-rc5/security/seclvl.c	2006-02-28 03:41:33 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/security/seclvl.c	2006-02-28 05:19:56 +0100
@@ -422,7 +422,7 @@ static void seclvl_bd_release(struct ino
  * seclvl 1, we only deny writes to *mounted* block devices.
  */
 static int
-seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
+seclvl_inode_permission(struct inode *inode, int mask)
 {
 	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
 		switch (seclvl) {
diff -NurpP --minimal linux-2.6.16-rc5/security/selinux/hooks.c linux-2.6.16-rc5-vfs0.02.1/security/selinux/hooks.c
--- linux-2.6.16-rc5/security/selinux/hooks.c	2006-02-28 03:41:34 +0100
+++ linux-2.6.16-rc5-vfs0.02.1/security/selinux/hooks.c	2006-02-28 05:20:22 +0100
@@ -2052,12 +2052,11 @@ static int selinux_inode_follow_link(str
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
 }
 
-static int selinux_inode_permission(struct inode *inode, int mask,
-				    struct nameidata *nd)
+static int selinux_inode_permission(struct inode *inode, int mask)
 {
 	int rc;
 
-	rc = secondary_ops->inode_permission(inode, mask, nd);
+	rc = secondary_ops->inode_permission(inode, mask);
 	if (rc)
 		return rc;
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVB0ULz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVB0ULz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVB0ULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 15:11:54 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:21149 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261214AbVB0ULh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 15:11:37 -0500
Date: Sun, 27 Feb 2005 21:11:36 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 4/6] BME 0.06.1 nameidata propagation
Message-ID: <20050227201136.GB17720@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is a rewrite of the previous co0.01 which introduced
the mnt_may_* functions (as generalized approach)

best,
Herbert

;
; Bind Mount Extensions
;
; This part propagates the nameidata into the relevant vfs_*()
; to allow for proper checks via permission()
; it replaces the co0.01 part from bme0.06
;
; Copyright (C) 2003-2005 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:
;
;   0.01  - initial version
;
; this patch is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; this patch is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;

diff -NurpP --minimal linux-2.6.11-rc5/fs/namei.c linux-2.6.11-rc5-bme0.06.1-nd0.01/fs/namei.c
--- linux-2.6.11-rc5/fs/namei.c	2005-02-24 20:50:07 +0100
+++ linux-2.6.11-rc5-bme0.06.1-nd0.01/fs/namei.c	2005-02-27 18:40:09 +0100
@@ -1119,7 +1119,8 @@ static inline int check_sticky(struct in
  * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static inline int may_delete(struct inode *dir,struct dentry *victim,int isdir)
+static inline int may_delete(struct inode *dir, struct dentry *victim,
+	int isdir, struct nameidata *nd)
 {
 	int error;
 
@@ -1128,7 +1129,7 @@ static inline int may_delete(struct inod
 
 	BUG_ON(victim->d_parent->d_inode != dir);
 
-	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
+	error = permission(dir,MAY_WRITE | MAY_EXEC, nd);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -1537,9 +1538,10 @@ fail:
 	return dentry;
 }
 
-int vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+int vfs_mknod(struct inode *dir, struct dentry *dentry,
+	int mode, dev_t dev, struct nameidata *nd)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, nd);
 
 	if (error)
 		return error;
@@ -1581,7 +1583,6 @@ asmlinkage long sys_mknod(const char __u
 		goto out;
 	dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(dentry);
-
 	if (!IS_POSIXACL(nd.dentry->d_inode))
 		mode &= ~current->fs->umask;
 	if (!IS_ERR(dentry)) {
@@ -1590,11 +1591,12 @@ asmlinkage long sys_mknod(const char __u
 			error = vfs_create(nd.dentry->d_inode,dentry,mode,&nd);
 			break;
 		case S_IFCHR: case S_IFBLK:
-			error = vfs_mknod(nd.dentry->d_inode,dentry,mode,
-					new_decode_dev(dev));
+			error = vfs_mknod(nd.dentry->d_inode, dentry, mode,
+					new_decode_dev(dev), &nd);
 			break;
 		case S_IFIFO: case S_IFSOCK:
-			error = vfs_mknod(nd.dentry->d_inode,dentry,mode,0);
+			error = vfs_mknod(nd.dentry->d_inode, dentry, mode,
+					0, &nd);
 			break;
 		case S_IFDIR:
 			error = -EPERM;
@@ -1612,9 +1614,10 @@ out:
 	return error;
 }
 
-int vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+int vfs_mkdir(struct inode *dir, struct dentry *dentry,
+	int mode, struct nameidata *nd)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, nd);
 
 	if (error)
 		return error;
@@ -1655,7 +1658,8 @@ asmlinkage long sys_mkdir(const char __u
 		if (!IS_ERR(dentry)) {
 			if (!IS_POSIXACL(nd.dentry->d_inode))
 				mode &= ~current->fs->umask;
-			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
+			error = vfs_mkdir(nd.dentry->d_inode, dentry,
+				mode, &nd);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
@@ -1699,9 +1703,10 @@ void dentry_unhash(struct dentry *dentry
 	spin_unlock(&dcache_lock);
 }
 
-int vfs_rmdir(struct inode *dir, struct dentry *dentry)
+int vfs_rmdir(struct inode *dir, struct dentry *dentry,
+	struct nameidata *nd)
 {
-	int error = may_delete(dir, dentry, 1);
+	int error = may_delete(dir, dentry, 1, nd);
 
 	if (error)
 		return error;
@@ -1763,7 +1768,7 @@ asmlinkage long sys_rmdir(const char __u
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+		error = vfs_rmdir(nd.dentry->d_inode, dentry, &nd);
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1774,9 +1779,10 @@ exit:
 	return error;
 }
 
-int vfs_unlink(struct inode *dir, struct dentry *dentry)
+int vfs_unlink(struct inode *dir, struct dentry *dentry,
+	struct nameidata *nd)
 {
-	int error = may_delete(dir, dentry, 0);
+	int error = may_delete(dir, dentry, 0, nd);
 
 	if (error)
 		return error;
@@ -1838,7 +1844,7 @@ asmlinkage long sys_unlink(const char __
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
-		error = vfs_unlink(nd.dentry->d_inode, dentry);
+		error = vfs_unlink(nd.dentry->d_inode, dentry, &nd);
 	exit2:
 		dput(dentry);
 	}
@@ -1857,9 +1863,10 @@ slashes:
 	goto exit2;
 }
 
-int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname, int mode)
+int vfs_symlink(struct inode *dir, struct dentry *dentry,
+	const char *oldname, int mode, struct nameidata *nd)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, nd);
 
 	if (error)
 		return error;
@@ -1901,7 +1908,8 @@ asmlinkage long sys_symlink(const char _
 		dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
-			error = vfs_symlink(nd.dentry->d_inode, dentry, from, S_IALLUGO);
+			error = vfs_symlink(nd.dentry->d_inode, dentry,
+				from, S_IALLUGO, &nd);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
@@ -1913,7 +1921,8 @@ out:
 	return error;
 }
 
-int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
+int vfs_link(struct dentry *old_dentry, struct inode *dir,
+	struct dentry *new_dentry, struct nameidata *nd)
 {
 	struct inode *inode = old_dentry->d_inode;
 	int error;
@@ -1921,7 +1930,7 @@ int vfs_link(struct dentry *old_dentry, 
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(dir, new_dentry, NULL);
+	error = may_create(dir, new_dentry, nd);
 	if (error)
 		return error;
 
@@ -1985,7 +1994,8 @@ asmlinkage long sys_link(const char __us
 	new_dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(new_dentry);
 	if (!IS_ERR(new_dentry)) {
-		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+		error = vfs_link(old_nd.dentry, nd.dentry->d_inode,
+			new_dentry, &nd);
 		dput(new_dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -2115,14 +2125,14 @@ int vfs_rename(struct inode *old_dir, st
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
  
-	error = may_delete(old_dir, old_dentry, is_dir);
+	error = may_delete(old_dir, old_dentry, is_dir, NULL);
 	if (error)
 		return error;
 
 	if (!new_dentry->d_inode)
 		error = may_create(new_dir, new_dentry, NULL);
 	else
-		error = may_delete(new_dir, new_dentry, is_dir);
+		error = may_delete(new_dir, new_dentry, is_dir, NULL);
 	if (error)
 		return error;
 
diff -NurpP --minimal linux-2.6.11-rc5/fs/nfsd/vfs.c linux-2.6.11-rc5-bme0.06.1-nd0.01/fs/nfsd/vfs.c
--- linux-2.6.11-rc5/fs/nfsd/vfs.c	2005-02-24 20:50:07 +0100
+++ linux-2.6.11-rc5-bme0.06.1-nd0.01/fs/nfsd/vfs.c	2005-02-27 18:40:09 +0100
@@ -1115,13 +1115,13 @@ nfsd_create(struct svc_rqst *rqstp, stru
 		err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
 		break;
 	case S_IFDIR:
-		err = vfs_mkdir(dirp, dchild, iap->ia_mode);
+		err = vfs_mkdir(dirp, dchild, iap->ia_mode, NULL);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		err = vfs_mknod(dirp, dchild, iap->ia_mode, rdev);
+		err = vfs_mknod(dirp, dchild, iap->ia_mode, rdev, NULL);
 		break;
 	default:
 	        printk("nfsd: bad file type %o in nfsd_create\n", type);
@@ -1397,11 +1397,13 @@ nfsd_symlink(struct svc_rqst *rqstp, str
 		else {
 			strncpy(path_alloced, path, plen);
 			path_alloced[plen] = 0;
-			err = vfs_symlink(dentry->d_inode, dnew, path_alloced, mode);
+			err = vfs_symlink(dentry->d_inode, dnew,
+				path_alloced, mode, NULL);
 			kfree(path_alloced);
 		}
 	} else
-		err = vfs_symlink(dentry->d_inode, dnew, path, mode);
+		err = vfs_symlink(dentry->d_inode, dnew,
+			path, mode, NULL);
 
 	if (!err) {
 		if (EX_ISSYNC(fhp->fh_export))
@@ -1459,7 +1461,7 @@ nfsd_link(struct svc_rqst *rqstp, struct
 	dold = tfhp->fh_dentry;
 	dest = dold->d_inode;
 
-	err = vfs_link(dold, dirp, dnew);
+	err = vfs_link(dold, dirp, dnew, NULL);
 	if (!err) {
 		if (EX_ISSYNC(ffhp->fh_export)) {
 			nfsd_sync_dir(ddir);
@@ -1620,9 +1622,9 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 			err = nfserr_perm;
 		} else
 #endif
-		err = vfs_unlink(dirp, rdentry);
+		err = vfs_unlink(dirp, rdentry, NULL);
 	} else { /* It's RMDIR */
-		err = vfs_rmdir(dirp, rdentry);
+		err = vfs_rmdir(dirp, rdentry, NULL);
 	}
 
 	dput(rdentry);
diff -NurpP --minimal linux-2.6.11-rc5/fs/reiserfs/xattr.c linux-2.6.11-rc5-bme0.06.1-nd0.01/fs/reiserfs/xattr.c
--- linux-2.6.11-rc5/fs/reiserfs/xattr.c	2005-02-24 20:50:08 +0100
+++ linux-2.6.11-rc5-bme0.06.1-nd0.01/fs/reiserfs/xattr.c	2005-02-27 18:40:09 +0100
@@ -834,7 +834,7 @@ reiserfs_delete_xattrs (struct inode *in
     if (dir->d_inode->i_nlink <= 2) {
         root = get_xa_root (inode->i_sb);
         reiserfs_write_lock_xattrs (inode->i_sb);
-        err = vfs_rmdir (root->d_inode, dir);
+	err = vfs_rmdir (root->d_inode, dir, NULL);
         reiserfs_write_unlock_xattrs (inode->i_sb);
         dput (root);
     } else {
diff -NurpP --minimal linux-2.6.11-rc5/include/linux/fs.h linux-2.6.11-rc5-bme0.06.1-nd0.01/include/linux/fs.h
--- linux-2.6.11-rc5/include/linux/fs.h	2005-02-24 20:50:17 +0100
+++ linux-2.6.11-rc5-bme0.06.1-nd0.01/include/linux/fs.h	2005-02-27 18:40:09 +0100
@@ -835,12 +835,12 @@ static inline void unlock_super(struct s
  * VFS helper functions..
  */
 extern int vfs_create(struct inode *, struct dentry *, int, struct nameidata *);
-extern int vfs_mkdir(struct inode *, struct dentry *, int);
-extern int vfs_mknod(struct inode *, struct dentry *, int, dev_t);
-extern int vfs_symlink(struct inode *, struct dentry *, const char *, int);
-extern int vfs_link(struct dentry *, struct inode *, struct dentry *);
-extern int vfs_rmdir(struct inode *, struct dentry *);
-extern int vfs_unlink(struct inode *, struct dentry *);
+extern int vfs_mkdir(struct inode *, struct dentry *, int, struct nameidata *);
+extern int vfs_mknod(struct inode *, struct dentry *, int, dev_t, struct nameidata *);
+extern int vfs_symlink(struct inode *, struct dentry *, const char *, int, struct nameidata *);
+extern int vfs_link(struct dentry *, struct inode *, struct dentry *, struct nameidata *);
+extern int vfs_rmdir(struct inode *, struct dentry *, struct nameidata *);
+extern int vfs_unlink(struct inode *, struct dentry *, struct nameidata *);
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
 
 /*
diff -NurpP --minimal linux-2.6.11-rc5/ipc/mqueue.c linux-2.6.11-rc5-bme0.06.1-nd0.01/ipc/mqueue.c
--- linux-2.6.11-rc5/ipc/mqueue.c	2004-12-25 01:55:30 +0100
+++ linux-2.6.11-rc5-bme0.06.1-nd0.01/ipc/mqueue.c	2005-02-27 18:40:09 +0100
@@ -728,7 +728,7 @@ asmlinkage long sys_mq_unlink(const char
 	if (inode)
 		atomic_inc(&inode->i_count);
 
-	err = vfs_unlink(dentry->d_parent->d_inode, dentry);
+	err = vfs_unlink(dentry->d_parent->d_inode, dentry, NULL);
 out_err:
 	dput(dentry);
 
diff -NurpP --minimal linux-2.6.11-rc5/net/unix/af_unix.c linux-2.6.11-rc5-bme0.06.1-nd0.01/net/unix/af_unix.c
--- linux-2.6.11-rc5/net/unix/af_unix.c	2005-02-24 20:50:23 +0100
+++ linux-2.6.11-rc5-bme0.06.1-nd0.01/net/unix/af_unix.c	2005-02-27 18:40:09 +0100
@@ -794,7 +794,7 @@ static int unix_bind(struct socket *sock
 		 */
 		mode = S_IFSOCK |
 		       (SOCK_INODE(sock)->i_mode & ~current->fs->umask);
-		err = vfs_mknod(nd.dentry->d_inode, dentry, mode, 0);
+		err = vfs_mknod(nd.dentry->d_inode, dentry, mode, 0, NULL);
 		if (err)
 			goto out_mknod_dput;
 		up(&nd.dentry->d_inode->i_sem);

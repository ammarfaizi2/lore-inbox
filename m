Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWAUImP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWAUImP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWAUImP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:42:15 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:28349 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751175AbWAUImO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:42:14 -0500
Date: Sat, 21 Jan 2006 09:42:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] vfs: propagate the nameidata into the relevant vfs_*()
Message-ID: <20060121084213.GE10044@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121083843.GA10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


;
; Bind Mount Extensions
;
; Copyright (C) 2003-2006 Herbert Pötzl <herbert@13thfloor.at>
;
; propagate the nameidata into the relevant vfs_*() functions
; similar to the existing vfs_create() to allow for proper
; checks via may_create(), may_delete() and permission()
;
;
; Changelog:
;
;   0.01  - initial version
;

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.16-rc1/fs/namei.c linux-2.6.16-rc1-bme0.06.2-nd0.01/fs/namei.c
--- linux-2.6.16-rc1/fs/namei.c	2006-01-18 06:08:30 +0100
+++ linux-2.6.16-rc1-bme0.06.2-nd0.01/fs/namei.c	2006-01-21 09:08:56 +0100
@@ -1294,7 +1294,8 @@ static inline int check_sticky(struct in
  * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static int may_delete(struct inode *dir,struct dentry *victim,int isdir)
+static int may_delete(struct inode *dir, struct dentry *victim,
+	int isdir, struct nameidata *nd)
 {
 	int error;
 
@@ -1303,7 +1304,7 @@ static int may_delete(struct inode *dir,
 
 	BUG_ON(victim->d_parent->d_inode != dir);
 
-	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
+	error = permission(dir,MAY_WRITE | MAY_EXEC, nd);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -1720,9 +1721,10 @@ fail:
 }
 EXPORT_SYMBOL_GPL(lookup_create);
 
-int vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+int vfs_mknod(struct inode *dir, struct dentry *dentry,
+	int mode, dev_t dev, struct nameidata *nd)
 {
-	int error = may_create(dir, dentry, NULL);
+	int error = may_create(dir, dentry, nd);
 
 	if (error)
 		return error;
@@ -1771,11 +1773,12 @@ asmlinkage long sys_mknod(const char __u
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
@@ -1793,9 +1796,10 @@ out:
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
@@ -1834,7 +1838,8 @@ asmlinkage long sys_mkdir(const char __u
 		if (!IS_ERR(dentry)) {
 			if (!IS_POSIXACL(nd.dentry->d_inode))
 				mode &= ~current->fs->umask;
-			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
+			error = vfs_mkdir(nd.dentry->d_inode, dentry,
+				mode, &nd);
 			dput(dentry);
 		}
 		mutex_unlock(&nd.dentry->d_inode->i_mutex);
@@ -1874,9 +1879,10 @@ void dentry_unhash(struct dentry *dentry
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
@@ -1937,7 +1943,7 @@ asmlinkage long sys_rmdir(const char __u
 	dentry = lookup_hash(&nd);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+		error = vfs_rmdir(nd.dentry->d_inode, dentry, &nd);
 		dput(dentry);
 	}
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
@@ -1948,9 +1954,10 @@ exit:
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
@@ -2012,7 +2019,7 @@ asmlinkage long sys_unlink(const char __
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
-		error = vfs_unlink(nd.dentry->d_inode, dentry);
+		error = vfs_unlink(nd.dentry->d_inode, dentry, &nd);
 	exit2:
 		dput(dentry);
 	}
@@ -2031,9 +2038,10 @@ slashes:
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
@@ -2073,7 +2081,8 @@ asmlinkage long sys_symlink(const char _
 		dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
-			error = vfs_symlink(nd.dentry->d_inode, dentry, from, S_IALLUGO);
+			error = vfs_symlink(nd.dentry->d_inode, dentry,
+				from, S_IALLUGO, &nd);
 			dput(dentry);
 		}
 		mutex_unlock(&nd.dentry->d_inode->i_mutex);
@@ -2085,7 +2094,8 @@ out:
 	return error;
 }
 
-int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
+int vfs_link(struct dentry *old_dentry, struct inode *dir,
+	struct dentry *new_dentry, struct nameidata *nd)
 {
 	struct inode *inode = old_dentry->d_inode;
 	int error;
@@ -2093,7 +2103,7 @@ int vfs_link(struct dentry *old_dentry, 
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(dir, new_dentry, NULL);
+	error = may_create(dir, new_dentry, nd);
 	if (error)
 		return error;
 
@@ -2155,7 +2165,8 @@ asmlinkage long sys_link(const char __us
 	new_dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(new_dentry);
 	if (!IS_ERR(new_dentry)) {
-		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+		error = vfs_link(old_nd.dentry, nd.dentry->d_inode,
+			new_dentry, &nd);
 		dput(new_dentry);
 	}
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
@@ -2282,14 +2293,14 @@ int vfs_rename(struct inode *old_dir, st
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
 
diff -NurpP --minimal linux-2.6.16-rc1/fs/nfsd/vfs.c linux-2.6.16-rc1-bme0.06.2-nd0.01/fs/nfsd/vfs.c
--- linux-2.6.16-rc1/fs/nfsd/vfs.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-nd0.01/fs/nfsd/vfs.c	2006-01-21 09:08:56 +0100
@@ -1159,13 +1159,13 @@ nfsd_create(struct svc_rqst *rqstp, stru
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
@@ -1441,11 +1441,13 @@ nfsd_symlink(struct svc_rqst *rqstp, str
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
@@ -1503,7 +1505,7 @@ nfsd_link(struct svc_rqst *rqstp, struct
 	dold = tfhp->fh_dentry;
 	dest = dold->d_inode;
 
-	err = vfs_link(dold, dirp, dnew);
+	err = vfs_link(dold, dirp, dnew, NULL);
 	if (!err) {
 		if (EX_ISSYNC(ffhp->fh_export)) {
 			nfsd_sync_dir(ddir);
@@ -1664,9 +1666,9 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
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
diff -NurpP --minimal linux-2.6.16-rc1/fs/reiserfs/xattr.c linux-2.6.16-rc1-bme0.06.2-nd0.01/fs/reiserfs/xattr.c
--- linux-2.6.16-rc1/fs/reiserfs/xattr.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-nd0.01/fs/reiserfs/xattr.c	2006-01-21 09:08:56 +0100
@@ -35,6 +35,7 @@
 #include <linux/namei.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
 #include <linux/xattr.h>
@@ -827,7 +828,7 @@ int reiserfs_delete_xattrs(struct inode 
 	if (dir->d_inode->i_nlink <= 2) {
 		root = get_xa_root(inode->i_sb);
 		reiserfs_write_lock_xattrs(inode->i_sb);
-		err = vfs_rmdir(root->d_inode, dir);
+		err = vfs_rmdir(root->d_inode, dir, NULL);
 		reiserfs_write_unlock_xattrs(inode->i_sb);
 		dput(root);
 	} else {
diff -NurpP --minimal linux-2.6.16-rc1/include/linux/fs.h linux-2.6.16-rc1-bme0.06.2-nd0.01/include/linux/fs.h
--- linux-2.6.16-rc1/include/linux/fs.h	2006-01-18 06:08:43 +0100
+++ linux-2.6.16-rc1-bme0.06.2-nd0.01/include/linux/fs.h	2006-01-21 09:08:56 +0100
@@ -901,12 +901,12 @@ static inline void unlock_super(struct s
  */
 extern int vfs_permission(struct nameidata *, int);
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
diff -NurpP --minimal linux-2.6.16-rc1/ipc/mqueue.c linux-2.6.16-rc1-bme0.06.2-nd0.01/ipc/mqueue.c
--- linux-2.6.16-rc1/ipc/mqueue.c	2006-01-18 06:08:45 +0100
+++ linux-2.6.16-rc1-bme0.06.2-nd0.01/ipc/mqueue.c	2006-01-21 09:08:59 +0100
@@ -738,7 +738,7 @@ asmlinkage long sys_mq_unlink(const char
 	if (inode)
 		atomic_inc(&inode->i_count);
 
-	err = vfs_unlink(dentry->d_parent->d_inode, dentry);
+	err = vfs_unlink(dentry->d_parent->d_inode, dentry, NULL);
 out_err:
 	dput(dentry);
 
diff -NurpP --minimal linux-2.6.16-rc1/net/unix/af_unix.c linux-2.6.16-rc1-bme0.06.2-nd0.01/net/unix/af_unix.c
--- linux-2.6.16-rc1/net/unix/af_unix.c	2006-01-18 06:08:56 +0100
+++ linux-2.6.16-rc1-bme0.06.2-nd0.01/net/unix/af_unix.c	2006-01-21 09:09:04 +0100
@@ -781,7 +781,7 @@ static int unix_bind(struct socket *sock
 		 */
 		mode = S_IFSOCK |
 		       (SOCK_INODE(sock)->i_mode & ~current->fs->umask);
-		err = vfs_mknod(nd.dentry->d_inode, dentry, mode, 0);
+		err = vfs_mknod(nd.dentry->d_inode, dentry, mode, 0, NULL);
 		if (err)
 			goto out_mknod_dput;
 		mutex_unlock(&nd.dentry->d_inode->i_mutex);


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTF3O3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbTF3O3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:29:00 -0400
Received: from pat.uio.no ([129.240.130.16]:17826 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264776AbTF3OXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:23:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16128.19258.196767.5060@charged.uio.no>
Date: Mon, 30 Jun 2003 16:37:46 +0200
To: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 3/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   - Make the VFS pass the struct nameidata as an optional parameter
     to the permission() inode operation.

   - Patch may_create()/may_open() so it passes the struct nameidata from
     vfs_create()/open_namei() as an argument to permission().

   - Add an intent flag for the sys_access() function.

diff -u --recursive --new-file linux-2.5.73-05-createintent/drivers/block/floppy.c linux-2.5.73-06-permission/drivers/block/floppy.c
--- linux-2.5.73-05-createintent/drivers/block/floppy.c	2003-05-25 11:45:06.000000000 +0200
+++ linux-2.5.73-06-permission/drivers/block/floppy.c	2003-06-30 08:49:25.000000000 +0200
@@ -3767,7 +3767,7 @@
 	 * Needed so that programs such as fdrawcmd still can work on write
 	 * protected disks */
 	if ((filp->f_mode & 2) || 
-	    (inode->i_sb && (permission(inode,2) == 0)))
+	    (inode->i_sb && (permission(inode,2, NULL) == 0)))
 	    filp->private_data = (void*) 8;
 
 	if (UFDCS->rawcmd == 1)
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/cifs/cifsfs.c linux-2.5.73-06-permission/fs/cifs/cifsfs.c
--- linux-2.5.73-05-createintent/fs/cifs/cifsfs.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-06-permission/fs/cifs/cifsfs.c	2003-06-30 08:49:25.000000000 +0200
@@ -178,7 +178,7 @@
 	return 0;		/* always return success? what if volume is no longer available? */
 }
 
-static int cifs_permission(struct inode * inode, int mask)
+static int cifs_permission(struct inode * inode, int mask, struct nameidata *nd)
 {
 	/* the server does permission checks, we do not need to do it here */
 	return 0;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/coda/dir.c linux-2.5.73-06-permission/fs/coda/dir.c
--- linux-2.5.73-05-createintent/fs/coda/dir.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/coda/dir.c	2003-06-30 08:49:25.000000000 +0200
@@ -147,7 +147,7 @@
 }
 
 
-int coda_permission(struct inode *inode, int mask)
+int coda_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
         int error = 0;
  
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/coda/pioctl.c linux-2.5.73-06-permission/fs/coda/pioctl.c
--- linux-2.5.73-05-createintent/fs/coda/pioctl.c	2002-10-06 00:36:27.000000000 +0200
+++ linux-2.5.73-06-permission/fs/coda/pioctl.c	2003-06-30 08:49:25.000000000 +0200
@@ -24,7 +24,8 @@
 #include <linux/coda_psdev.h>
 
 /* pioctl ops */
-static int coda_ioctl_permission(struct inode *inode, int mask);
+static int coda_ioctl_permission(struct inode *inode, int mask,
+				 struct nameidata *nd);
 static int coda_pioctl(struct inode * inode, struct file * filp, 
                        unsigned int cmd, unsigned long user_data);
 
@@ -41,7 +42,8 @@
 };
 
 /* the coda pioctl inode ops */
-static int coda_ioctl_permission(struct inode *inode, int mask)
+static int coda_ioctl_permission(struct inode *inode, int mask,
+				 struct nameidata *nd)
 {
         return 0;
 }
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/exec.c linux-2.5.73-06-permission/fs/exec.c
--- linux-2.5.73-05-createintent/fs/exec.c	2003-06-30 08:48:42.000000000 +0200
+++ linux-2.5.73-06-permission/fs/exec.c	2003-06-30 08:49:25.000000000 +0200
@@ -126,7 +126,7 @@
 	if (!S_ISREG(nd.dentry->d_inode->i_mode))
 		goto exit;
 
-	error = permission(nd.dentry->d_inode, MAY_READ | MAY_EXEC);
+	error = permission(nd.dentry->d_inode, MAY_READ | MAY_EXEC, &nd);
 	if (error)
 		goto exit;
 
@@ -462,7 +462,7 @@
 		file = ERR_PTR(-EACCES);
 		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
 		    S_ISREG(inode->i_mode)) {
-			int err = permission(inode, MAY_EXEC);
+			int err = permission(inode, MAY_EXEC, &nd);
 			if (!err && !(inode->i_mode & 0111))
 				err = -EACCES;
 			file = ERR_PTR(err);
@@ -792,7 +792,7 @@
 	flush_thread();
 
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
-	    permission(bprm->file->f_dentry->d_inode,MAY_READ))
+	    permission(bprm->file->f_dentry->d_inode,MAY_READ, NULL))
 		current->mm->dumpable = 0;
 
 	/* An exec changes our domain. We are no longer part of the thread
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ext2/acl.c linux-2.5.73-06-permission/fs/ext2/acl.c
--- linux-2.5.73-05-createintent/fs/ext2/acl.c	2003-02-25 17:21:08.000000000 +0100
+++ linux-2.5.73-06-permission/fs/ext2/acl.c	2003-06-30 08:49:25.000000000 +0200
@@ -309,7 +309,7 @@
  * BKL held [before 2.5.x]
  */
 int
-ext2_permission(struct inode *inode, int mask)
+ext2_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	return __ext2_permission(inode, mask, 1);
 }
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ext2/acl.h linux-2.5.73-06-permission/fs/ext2/acl.h
--- linux-2.5.73-05-createintent/fs/ext2/acl.h	2002-10-31 08:34:13.000000000 +0100
+++ linux-2.5.73-06-permission/fs/ext2/acl.h	2003-06-30 08:49:25.000000000 +0200
@@ -59,7 +59,7 @@
 #define EXT2_ACL_NOT_CACHED ((void *)-1)
 
 /* acl.c */
-extern int ext2_permission (struct inode *, int);
+extern int ext2_permission (struct inode *, int, struct nameidata *);
 extern int ext2_permission_locked (struct inode *, int);
 extern int ext2_acl_chmod (struct inode *);
 extern int ext2_init_acl (struct inode *, struct inode *);
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ext2/xattr_user.c linux-2.5.73-06-permission/fs/ext2/xattr_user.c
--- linux-2.5.73-05-createintent/fs/ext2/xattr_user.c	2003-02-25 17:21:08.000000000 +0100
+++ linux-2.5.73-06-permission/fs/ext2/xattr_user.c	2003-06-30 08:49:25.000000000 +0200
@@ -47,7 +47,7 @@
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	error = ext2_permission_locked(inode, MAY_READ);
 #else
-	error = permission(inode, MAY_READ);
+	error = permission(inode, MAY_READ, NULL);
 #endif
 	if (error)
 		return error;
@@ -71,7 +71,7 @@
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	error = ext2_permission_locked(inode, MAY_WRITE);
 #else
-	error = permission(inode, MAY_WRITE);
+	error = permission(inode, MAY_WRITE, NULL);
 #endif
 	if (error)
 		return error;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ext3/acl.c linux-2.5.73-06-permission/fs/ext3/acl.c
--- linux-2.5.73-05-createintent/fs/ext3/acl.c	2003-06-20 22:16:31.000000000 +0200
+++ linux-2.5.73-06-permission/fs/ext3/acl.c	2003-06-30 08:49:25.000000000 +0200
@@ -312,7 +312,7 @@
  * inode->i_sem: up
  */
 int
-ext3_permission(struct inode *inode, int mask)
+ext3_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	return __ext3_permission(inode, mask, 1);
 }
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ext3/acl.h linux-2.5.73-06-permission/fs/ext3/acl.h
--- linux-2.5.73-05-createintent/fs/ext3/acl.h	2002-10-31 08:32:57.000000000 +0100
+++ linux-2.5.73-06-permission/fs/ext3/acl.h	2003-06-30 08:49:25.000000000 +0200
@@ -59,7 +59,7 @@
 #define EXT3_ACL_NOT_CACHED ((void *)-1)
 
 /* acl.c */
-extern int ext3_permission (struct inode *, int);
+extern int ext3_permission (struct inode *, int, struct nameidata *);
 extern int ext3_permission_locked (struct inode *, int);
 extern int ext3_acl_chmod (struct inode *);
 extern int ext3_init_acl (handle_t *, struct inode *, struct inode *);
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ext3/xattr_user.c linux-2.5.73-06-permission/fs/ext3/xattr_user.c
--- linux-2.5.73-05-createintent/fs/ext3/xattr_user.c	2003-02-25 17:21:08.000000000 +0100
+++ linux-2.5.73-06-permission/fs/ext3/xattr_user.c	2003-06-30 08:49:25.000000000 +0200
@@ -49,7 +49,7 @@
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	error = ext3_permission_locked(inode, MAY_READ);
 #else
-	error = permission(inode, MAY_READ);
+	error = permission(inode, MAY_READ, NULL);
 #endif
 	if (error)
 		return error;
@@ -73,7 +73,7 @@
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	error = ext3_permission_locked(inode, MAY_WRITE);
 #else
-	error = permission(inode, MAY_WRITE);
+	error = permission(inode, MAY_WRITE, NULL);
 #endif
 	if (error)
 		return error;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/hpfs/namei.c linux-2.5.73-06-permission/fs/hpfs/namei.c
--- linux-2.5.73-05-createintent/fs/hpfs/namei.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/hpfs/namei.c	2003-06-30 08:49:25.000000000 +0200
@@ -374,7 +374,7 @@
 		d_drop(dentry);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count) > 1 ||
-		    permission(inode, MAY_WRITE) ||
+		    permission(inode, MAY_WRITE, NULL) ||
 		    get_write_access(inode)) {
 			spin_unlock(&dentry->d_lock);
 			d_rehash(dentry);
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/intermezzo/dir.c linux-2.5.73-06-permission/fs/intermezzo/dir.c
--- linux-2.5.73-05-createintent/fs/intermezzo/dir.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/intermezzo/dir.c	2003-06-30 08:49:25.000000000 +0200
@@ -81,7 +81,7 @@
 /*
  * these are initialized in super.c
  */
-extern int presto_permission(struct inode *inode, int mask);
+extern int presto_permission(struct inode *inode, int mask, struct nameidata *nd);
 static int izo_authorized_uid = 0;
 
 int izo_dentry_is_ilookup(struct dentry *dentry, ino_t *id,
@@ -830,7 +830,7 @@
  * appropriate permission function. Thus we do not worry here about ACLs
  * or EAs. -SHP
  */
-int presto_permission(struct inode *inode, int mask)
+int presto_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
         unsigned short mode = inode->i_mode;
         struct presto_cache *cache;
@@ -852,11 +852,11 @@
 
                 if ( S_ISREG(mode) && fiops && fiops->permission ) {
                         EXIT;
-                        return fiops->permission(inode, mask);
+                        return fiops->permission(inode, mask, nd);
                 }
                 if ( S_ISDIR(mode) && diops && diops->permission ) {
                         EXIT;
-                        return diops->permission(inode, mask);
+                        return diops->permission(inode, mask, nd);
                 }
         }
 
@@ -867,7 +867,7 @@
          * the VFS permission function.
          */
         inode->i_op->permission = NULL;
-        rc = permission(inode, mask);
+        rc = permission(inode, mask, nd);
         inode->i_op->permission = &presto_permission;
 
         EXIT;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/intermezzo/file.c linux-2.5.73-06-permission/fs/intermezzo/file.c
--- linux-2.5.73-05-createintent/fs/intermezzo/file.c	2003-03-18 18:08:01.000000000 +0100
+++ linux-2.5.73-06-permission/fs/intermezzo/file.c	2003-06-30 08:49:25.000000000 +0200
@@ -53,7 +53,7 @@
 /*
  * these are initialized in super.c
  */
-extern int presto_permission(struct inode *inode, int mask);
+extern int presto_permission(struct inode *inode, int mask, struct nameidata *nd);
 
 
 static int presto_open_upcall(int minor, struct dentry *de)
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/intermezzo/vfs.c linux-2.5.73-06-permission/fs/intermezzo/vfs.c
--- linux-2.5.73-05-createintent/fs/intermezzo/vfs.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/intermezzo/vfs.c	2003-06-30 08:49:25.000000000 +0200
@@ -134,7 +134,7 @@
         int error;
         if (!victim->d_inode || victim->d_parent->d_inode != dir)
                 return -ENOENT;
-        error = permission(dir,MAY_WRITE | MAY_EXEC);
+        error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
         if (error)
                 return error;
         if (IS_APPEND(dir))
@@ -158,7 +158,7 @@
                 return -EEXIST;
         if (IS_DEADDIR(dir))
                 return -ENOENT;
-        return permission(dir,MAY_WRITE | MAY_EXEC);
+        return permission(dir,MAY_WRITE | MAY_EXEC, NULL);
 }
 
 #ifdef PRESTO_DEBUG
@@ -1840,7 +1840,7 @@
          * we'll need to flip '..'.
          */
         if (new_dir != old_dir) {
-                error = permission(old_dentry->d_inode, MAY_WRITE);
+                error = permission(old_dentry->d_inode, MAY_WRITE, NULL);
         }
         if (error)
                 return error;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/jfs/acl.c linux-2.5.73-06-permission/fs/jfs/acl.c
--- linux-2.5.73-05-createintent/fs/jfs/acl.c	2002-11-11 15:27:31.000000000 +0100
+++ linux-2.5.73-06-permission/fs/jfs/acl.c	2003-06-30 08:49:25.000000000 +0200
@@ -208,7 +208,7 @@
 
 	return -EACCES;
 }
-int jfs_permission(struct inode * inode, int mask)
+int jfs_permission(struct inode * inode, int mask, struct nameidata *nd)
 {
 	return __jfs_permission(inode, mask, 0);
 }
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/jfs/jfs_acl.h linux-2.5.73-06-permission/fs/jfs/jfs_acl.h
--- linux-2.5.73-05-createintent/fs/jfs/jfs_acl.h	2002-11-09 21:41:48.000000000 +0100
+++ linux-2.5.73-06-permission/fs/jfs/jfs_acl.h	2003-06-30 08:49:25.000000000 +0200
@@ -25,7 +25,7 @@
 struct posix_acl *jfs_get_acl(struct inode *, int);
 int jfs_set_acl(struct inode *, int, struct posix_acl *);
 int jfs_permission_have_sem(struct inode *, int);
-int jfs_permission(struct inode *, int);
+int jfs_permission(struct inode *, int, struct nameidata *);
 int jfs_init_acl(struct inode *, struct inode *);
 int jfs_setattr(struct dentry *, struct iattr *);
 
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/jfs/xattr.c linux-2.5.73-06-permission/fs/jfs/xattr.c
--- linux-2.5.73-05-createintent/fs/jfs/xattr.c	2003-02-25 17:21:08.000000000 +0100
+++ linux-2.5.73-06-permission/fs/jfs/xattr.c	2003-06-30 08:49:25.000000000 +0200
@@ -731,7 +731,7 @@
 #ifdef CONFIG_JFS_POSIX_ACL
 	return jfs_permission_have_sem(inode, MAY_WRITE);
 #else
-	return permission(inode, MAY_WRITE);
+	return permission(inode, MAY_WRITE, NULL);
 #endif
 }
 
@@ -893,7 +893,7 @@
 	else
 		return jfs_permission_have_sem(inode, MAY_READ);
 #else
-	return permission(inode, MAY_READ);
+	return permission(inode, MAY_READ, NULL);
 #endif
 }
 
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/namei.c linux-2.5.73-06-permission/fs/namei.c
--- linux-2.5.73-05-createintent/fs/namei.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/namei.c	2003-06-30 08:49:25.000000000 +0200
@@ -203,7 +203,7 @@
 	return -EACCES;
 }
 
-int permission(struct inode * inode,int mask)
+int permission(struct inode * inode,int mask, struct nameidata *nd)
 {
 	int retval;
 	int submask;
@@ -212,7 +212,7 @@
 	submask = mask & ~MAY_APPEND;
 
 	if (inode->i_op && inode->i_op->permission)
-		retval = inode->i_op->permission(inode, submask);
+		retval = inode->i_op->permission(inode, submask, nd);
 	else
 		retval = vfs_permission(inode, submask);
 	if (retval)
@@ -588,7 +588,7 @@
 
 		err = exec_permission_lite(inode);
 		if (err == -EAGAIN) { 
-			err = permission(inode, MAY_EXEC);
+			err = permission(inode, MAY_EXEC, nd);
 		}
  		if (err)
 			break;
@@ -876,7 +876,7 @@
 	int err;
 
 	inode = base->d_inode;
-	err = permission(inode, MAY_EXEC);
+	err = permission(inode, MAY_EXEC, nd);
 	dentry = ERR_PTR(err);
 	if (err)
 		goto out;
@@ -996,12 +996,12 @@
  * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
+static inline int may_delete(struct inode *dir,struct dentry *victim,int isdir)
 {
 	int error;
 	if (!victim->d_inode || victim->d_parent->d_inode != dir)
 		return -ENOENT;
-	error = permission(dir,MAY_WRITE | MAY_EXEC);
+	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -1031,12 +1031,14 @@
  *  3. We should have write and exec permissions on dir
  *  4. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct inode *dir, struct dentry *child) {
+static inline int may_create(struct inode *dir, struct dentry *child,
+			     struct nameidata *nd)
+{
 	if (child->d_inode)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return permission(dir,MAY_WRITE | MAY_EXEC);
+	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
 }
 
 /* 
@@ -1108,7 +1110,7 @@
 int vfs_create(struct inode *dir, struct dentry *dentry, int mode,
 		struct nameidata *nd)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(dir, dentry, nd);
 
 	if (error)
 		return error;
@@ -1144,7 +1146,7 @@
 	if (S_ISDIR(inode->i_mode) && (flag & FMODE_WRITE))
 		return -EISDIR;
 
-	error = permission(inode, acc_mode);
+	error = permission(inode, acc_mode, nd);
 	if (error)
 		return error;
 
@@ -1398,7 +1400,7 @@
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(dir, dentry, NULL);
 
 	if (error)
 		return error;
@@ -1469,7 +1471,7 @@
 
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(dir, dentry, NULL);
 
 	if (error)
 		return error;
@@ -1715,7 +1717,7 @@
 
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(dir, dentry, NULL);
 
 	if (error)
 		return error;
@@ -1777,7 +1779,7 @@
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(dir, new_dentry);
+	error = may_create(dir, new_dentry, NULL);
 	if (error)
 		return error;
 
@@ -1898,7 +1900,7 @@
 	 * we'll need to flip '..'.
 	 */
 	if (new_dir != old_dir) {
-		error = permission(old_dentry->d_inode, MAY_WRITE);
+		error = permission(old_dentry->d_inode, MAY_WRITE, NULL);
 		if (error)
 			return error;
 	}
@@ -1976,7 +1978,7 @@
 		return error;
 
 	if (!new_dentry->d_inode)
-		error = may_create(new_dir, new_dentry);
+		error = may_create(new_dir, new_dentry, NULL);
 	else
 		error = may_delete(new_dir, new_dentry, is_dir);
 	if (error)
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/namespace.c linux-2.5.73-06-permission/fs/namespace.c
--- linux-2.5.73-05-createintent/fs/namespace.c	2003-06-05 17:55:12.000000000 +0200
+++ linux-2.5.73-06-permission/fs/namespace.c	2003-06-30 08:49:25.000000000 +0200
@@ -403,7 +403,7 @@
 		if (current->uid != nd->dentry->d_inode->i_uid)
 			return -EPERM;
 	}
-	if (permission(nd->dentry->d_inode, MAY_WRITE))
+	if (permission(nd->dentry->d_inode, MAY_WRITE, nd))
 		return -EPERM;
 	return 0;
 #endif
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/ncpfs/ioctl.c linux-2.5.73-06-permission/fs/ncpfs/ioctl.c
--- linux-2.5.73-05-createintent/fs/ncpfs/ioctl.c	2003-03-11 07:34:29.000000000 +0100
+++ linux-2.5.73-06-permission/fs/ncpfs/ioctl.c	2003-06-30 08:49:25.000000000 +0200
@@ -40,7 +40,7 @@
 	switch (cmd) {
 	case NCP_IOC_NCPREQUEST:
 
-		if ((permission(inode, MAY_WRITE) != 0)
+		if ((permission(inode, MAY_WRITE, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid)) {
 			return -EACCES;
 		}
@@ -99,7 +99,7 @@
 		{
 			struct ncp_fs_info info;
 
-			if ((permission(inode, MAY_WRITE) != 0)
+			if ((permission(inode, MAY_WRITE, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid)) {
 				return -EACCES;
 			}
@@ -127,7 +127,7 @@
 		{
 			struct ncp_fs_info_v2 info2;
 
-			if ((permission(inode, MAY_WRITE) != 0)
+			if ((permission(inode, MAY_WRITE, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid)) {
 				return -EACCES;
 			}
@@ -155,7 +155,7 @@
 		{
 			unsigned long tmp = server->m.mounted_uid;
 
-			if (   (permission(inode, MAY_READ) != 0)
+			if (   (permission(inode, MAY_READ, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid))
 			{
 				return -EACCES;
@@ -169,7 +169,7 @@
 		{
 			struct ncp_setroot_ioctl sr;
 
-			if (   (permission(inode, MAY_READ) != 0)
+			if (   (permission(inode, MAY_READ, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid))
 			{
 				return -EACCES;
@@ -249,7 +249,7 @@
 
 #ifdef CONFIG_NCPFS_PACKET_SIGNING	
 	case NCP_IOC_SIGN_INIT:
-		if ((permission(inode, MAY_WRITE) != 0)
+		if ((permission(inode, MAY_WRITE, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid))
 		{
 			return -EACCES;
@@ -272,7 +272,7 @@
 		return 0;		
 		
         case NCP_IOC_SIGN_WANTED:
-		if (   (permission(inode, MAY_READ) != 0)
+		if (   (permission(inode, MAY_READ, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid))
 		{
 			return -EACCES;
@@ -285,7 +285,7 @@
 		{
 			int newstate;
 
-			if (   (permission(inode, MAY_WRITE) != 0)
+			if (   (permission(inode, MAY_WRITE, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid))
 			{
 				return -EACCES;
@@ -306,7 +306,7 @@
 
 #ifdef CONFIG_NCPFS_IOCTL_LOCKING
 	case NCP_IOC_LOCKUNLOCK:
-		if (   (permission(inode, MAY_WRITE) != 0)
+		if (   (permission(inode, MAY_WRITE, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid))
 		{
 			return -EACCES;
@@ -608,7 +608,7 @@
 		}
 #endif /* CONFIG_NCPFS_NLS */
 	case NCP_IOC_SETDENTRYTTL:
-		if ((permission(inode, MAY_WRITE) != 0) &&
+		if ((permission(inode, MAY_WRITE, NULL) != 0) &&
 				 (current->uid != server->m.mounted_uid))
 			return -EACCES;
 		{
@@ -637,7 +637,7 @@
 	/* NCP_IOC_GETMOUNTUID may be same as NCP_IOC_GETMOUNTUID2,
            so we have this out of switch */
 	if (cmd == NCP_IOC_GETMOUNTUID) {
-		if ((permission(inode, MAY_READ) != 0)
+		if ((permission(inode, MAY_READ, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid)) {
 			return -EACCES;
 		}
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/nfs/dir.c linux-2.5.73-06-permission/fs/nfs/dir.c
--- linux-2.5.73-05-createintent/fs/nfs/dir.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/nfs/dir.c	2003-06-30 08:49:25.000000000 +0200
@@ -1240,7 +1240,7 @@
 }
 
 int
-nfs_permission(struct inode *inode, int mask)
+nfs_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	struct nfs_access_cache *cache = &NFS_I(inode)->cache_access;
 	struct rpc_cred *cred;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/nfsd/nfsfh.c linux-2.5.73-06-permission/fs/nfsd/nfsfh.c
--- linux-2.5.73-05-createintent/fs/nfsd/nfsfh.c	2003-06-18 01:31:29.000000000 +0200
+++ linux-2.5.73-06-permission/fs/nfsd/nfsfh.c	2003-06-30 08:49:26.000000000 +0200
@@ -56,7 +56,7 @@
 		/* make sure parents give x permission to user */
 		int err;
 		parent = dget_parent(tdentry);
-		err = permission(parent->d_inode, S_IXOTH);
+		err = permission(parent->d_inode, S_IXOTH, NULL);
 		if (err < 0) {
 			dput(parent);
 			break;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/nfsd/vfs.c linux-2.5.73-06-permission/fs/nfsd/vfs.c
--- linux-2.5.73-05-createintent/fs/nfsd/vfs.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/nfsd/vfs.c	2003-06-30 08:49:26.000000000 +0200
@@ -1584,12 +1584,12 @@
 	    inode->i_uid == current->fsuid)
 		return 0;
 
-	err = permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC));
+	err = permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC), NULL);
 
 	/* Allow read access to binaries even when mode 111 */
 	if (err == -EACCES && S_ISREG(inode->i_mode) &&
 	    acc == (MAY_READ | MAY_OWNER_OVERRIDE))
-		err = permission(inode, MAY_EXEC);
+		err = permission(inode, MAY_EXEC, NULL);
 
 	return err? nfserrno(err) : 0;
 }
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/open.c linux-2.5.73-06-permission/fs/open.c
--- linux-2.5.73-05-createintent/fs/open.c	2003-06-20 22:16:06.000000000 +0200
+++ linux-2.5.73-06-permission/fs/open.c	2003-06-30 08:49:26.000000000 +0200
@@ -219,7 +219,7 @@
 	if (!S_ISREG(inode->i_mode))
 		goto dput_and_out;
 
-	error = permission(inode,MAY_WRITE);
+	error = permission(inode,MAY_WRITE,&nd);
 	if (error)
 		goto dput_and_out;
 
@@ -365,7 +365,7 @@
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
 		if (current->fsuid != inode->i_uid &&
-		    (error = permission(inode,MAY_WRITE)) != 0)
+		    (error = permission(inode,MAY_WRITE,&nd)) != 0)
 			goto dput_and_out;
 	}
 	down(&inode->i_sem);
@@ -410,7 +410,7 @@
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
 		if (current->fsuid != inode->i_uid &&
-		    (error = permission(inode,MAY_WRITE)) != 0)
+		    (error = permission(inode,MAY_WRITE,&nd)) != 0)
 			goto dput_and_out;
 	}
 	down(&inode->i_sem);
@@ -467,9 +467,9 @@
 	else
 		current->cap_effective = current->cap_permitted;
 
-	res = user_path_walk(filename, &nd);
+	res = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
 	if (!res) {
-		res = permission(nd.dentry->d_inode, mode);
+		res = permission(nd.dentry->d_inode, mode, &nd);
 		/* SuS v2 requires we report a read only fs too */
 		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
 		   && !special_file(nd.dentry->d_inode->i_mode))
@@ -493,7 +493,7 @@
 	if (error)
 		goto out;
 
-	error = permission(nd.dentry->d_inode,MAY_EXEC);
+	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd);
 	if (error)
 		goto dput_and_out;
 
@@ -526,7 +526,7 @@
 	if (!S_ISDIR(inode->i_mode))
 		goto out_putf;
 
-	error = permission(inode, MAY_EXEC);
+	error = permission(inode, MAY_EXEC, NULL);
 	if (!error)
 		set_fs_pwd(current->fs, mnt, dentry);
 out_putf:
@@ -544,7 +544,7 @@
 	if (error)
 		goto out;
 
-	error = permission(nd.dentry->d_inode,MAY_EXEC);
+	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd);
 	if (error)
 		goto dput_and_out;
 
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/proc/base.c linux-2.5.73-06-permission/fs/proc/base.c
--- linux-2.5.73-05-createintent/fs/proc/base.c	2003-06-30 08:48:43.000000000 +0200
+++ linux-2.5.73-06-permission/fs/proc/base.c	2003-06-30 08:49:26.000000000 +0200
@@ -334,7 +334,7 @@
 	goto exit;
 }
 
-static int proc_permission(struct inode *inode, int mask)
+static int proc_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	if (vfs_permission(inode, mask) != 0)
 		return -EACCES;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/smbfs/file.c linux-2.5.73-06-permission/fs/smbfs/file.c
--- linux-2.5.73-05-createintent/fs/smbfs/file.c	2002-12-14 18:42:09.000000000 +0100
+++ linux-2.5.73-06-permission/fs/smbfs/file.c	2003-06-30 08:49:26.000000000 +0200
@@ -367,7 +367,7 @@
  * privileges, so we need our own check for this.
  */
 static int
-smb_file_permission(struct inode *inode, int mask)
+smb_file_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	int mode = inode->i_mode;
 	int error = 0;
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/udf/file.c linux-2.5.73-06-permission/fs/udf/file.c
--- linux-2.5.73-05-createintent/fs/udf/file.c	2002-12-14 18:42:09.000000000 +0100
+++ linux-2.5.73-06-permission/fs/udf/file.c	2003-06-30 08:49:26.000000000 +0200
@@ -188,7 +188,7 @@
 {
 	int result = -EINVAL;
 
-	if ( permission(inode, MAY_READ) != 0 )
+	if ( permission(inode, MAY_READ, NULL) != 0 )
 	{
 		udf_debug("no permission to access inode %lu\n",
 						inode->i_ino);
diff -u --recursive --new-file linux-2.5.73-05-createintent/fs/xfs/linux/xfs_iops.c linux-2.5.73-06-permission/fs/xfs/linux/xfs_iops.c
--- linux-2.5.73-05-createintent/fs/xfs/linux/xfs_iops.c	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/fs/xfs/linux/xfs_iops.c	2003-06-30 08:49:26.000000000 +0200
@@ -431,7 +431,8 @@
 STATIC int
 linvfs_permission(
 	struct inode	*inode,
-	int		mode)
+	int		mode,
+	struct nameidata *nd)
 {
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 	int		error;
diff -u --recursive --new-file linux-2.5.73-05-createintent/include/linux/coda_linux.h linux-2.5.73-06-permission/include/linux/coda_linux.h
--- linux-2.5.73-05-createintent/include/linux/coda_linux.h	2002-11-17 04:49:10.000000000 +0100
+++ linux-2.5.73-06-permission/include/linux/coda_linux.h	2003-06-30 08:49:26.000000000 +0200
@@ -38,7 +38,7 @@
 int coda_open(struct inode *i, struct file *f);
 int coda_flush(struct file *f);
 int coda_release(struct inode *i, struct file *f);
-int coda_permission(struct inode *inode, int mask);
+int coda_permission(struct inode *inode, int mask, struct nameidata *nd);
 int coda_revalidate_inode(struct dentry *);
 int coda_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 int coda_setattr(struct dentry *, struct iattr *);
diff -u --recursive --new-file linux-2.5.73-05-createintent/include/linux/fs.h linux-2.5.73-06-permission/include/linux/fs.h
--- linux-2.5.73-05-createintent/include/linux/fs.h	2003-06-30 08:49:04.000000000 +0200
+++ linux-2.5.73-06-permission/include/linux/fs.h	2003-06-30 08:49:26.000000000 +0200
@@ -743,7 +743,7 @@
 	int (*readlink) (struct dentry *, char __user *,int);
 	int (*follow_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
+	int (*permission) (struct inode *, int, struct nameidata *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
 	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
@@ -1121,7 +1121,7 @@
 extern sector_t bmap(struct inode *, sector_t);
 extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);
-extern int permission(struct inode *, int);
+extern int permission(struct inode *, int, struct nameidata *);
 extern int vfs_permission(struct inode *, int);
 extern int get_write_access(struct inode *);
 extern int deny_write_access(struct file *);
diff -u --recursive --new-file linux-2.5.73-05-createintent/include/linux/namei.h linux-2.5.73-06-permission/include/linux/namei.h
--- linux-2.5.73-05-createintent/include/linux/namei.h	2003-06-30 08:48:43.000000000 +0200
+++ linux-2.5.73-06-permission/include/linux/namei.h	2003-06-30 08:49:26.000000000 +0200
@@ -52,6 +52,7 @@
  */
 #define LOOKUP_OPEN		(0x0100)
 #define LOOKUP_CREATE		(0x0200)
+#define LOOKUP_ACCESS		(0x0400)
 
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct nameidata *));
 #define user_path_walk(name,nd) \
diff -u --recursive --new-file linux-2.5.73-05-createintent/include/linux/nfs_fs.h linux-2.5.73-06-permission/include/linux/nfs_fs.h
--- linux-2.5.73-05-createintent/include/linux/nfs_fs.h	2003-04-08 00:27:32.000000000 +0200
+++ linux-2.5.73-06-permission/include/linux/nfs_fs.h	2003-06-30 08:49:26.000000000 +0200
@@ -240,7 +240,7 @@
 				struct nfs_fattr *);
 extern int __nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
-extern int nfs_permission(struct inode *, int);
+extern int nfs_permission(struct inode *, int, struct nameidata *);
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_release(struct inode *, struct file *);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
diff -u --recursive --new-file linux-2.5.73-05-createintent/kernel/sysctl.c linux-2.5.73-06-permission/kernel/sysctl.c
--- linux-2.5.73-05-createintent/kernel/sysctl.c	2003-06-15 01:16:11.000000000 +0200
+++ linux-2.5.73-06-permission/kernel/sysctl.c	2003-06-30 08:49:26.000000000 +0200
@@ -130,7 +130,7 @@
 
 static ssize_t proc_readsys(struct file *, char __user *, size_t, loff_t *);
 static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
-static int proc_sys_permission(struct inode *, int);
+static int proc_sys_permission(struct inode *, int, struct nameidata *);
 
 struct file_operations proc_sys_file_operations = {
 	.read		= proc_readsys,
@@ -1177,7 +1177,7 @@
 	return do_rw_proc(1, file, (char __user *) buf, count, ppos);
 }
 
-static int proc_sys_permission(struct inode *inode, int op)
+static int proc_sys_permission(struct inode *inode, int op, struct nameidata *nd)
 {
 	return test_perm(inode->i_mode, op);
 }
diff -u --recursive --new-file linux-2.5.73-05-createintent/net/unix/af_unix.c linux-2.5.73-06-permission/net/unix/af_unix.c
--- linux-2.5.73-05-createintent/net/unix/af_unix.c	2003-06-18 22:59:01.000000000 +0200
+++ linux-2.5.73-06-permission/net/unix/af_unix.c	2003-06-30 08:49:26.000000000 +0200
@@ -594,7 +594,7 @@
 		err = path_lookup(sunname->sun_path, LOOKUP_FOLLOW, &nd);
 		if (err)
 			goto fail;
-		err = permission(nd.dentry->d_inode,MAY_WRITE);
+		err = permission(nd.dentry->d_inode,MAY_WRITE, &nd);
 		if (err)
 			goto put_fail;
 

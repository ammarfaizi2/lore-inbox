Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTANSxN>; Tue, 14 Jan 2003 13:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbTANSxK>; Tue, 14 Jan 2003 13:53:10 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:34702 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S264984AbTANSwg>;
	Tue, 14 Jan 2003 13:52:36 -0500
Message-Id: <200301141908.OAA16969@moss-shockers.ncsc.mil>
Date: Tue, 14 Jan 2003 14:08:16 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [RFC] Changes to the LSM file-related hooks for 2.5.58
To: viro@math.psu.edu, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: +jYzuBrPCUMxfyMlsDREmg==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch contains several changes to the LSM file-related hooks for
2.5.58, split out from the lsm-2.5 BitKeeper tree.  This patch can be
further split into a separate patch per change if desired.  Logically,
the changes are:

1) Add a security_sb_kern_mount hook call to the do_kern_mount
function.  This hook enables initialization of the superblock security
information of all superblock objects.  Placing a hook in
do_kern_mount was originally suggested by Al Viro.  This hook is used
by SELinux to setup the superblock security state and eliminated the
need for the superblock_precondition function.

2) Remove the security_inode_post_lookup hook entirely and add a
security_d_instantiate hook call to the d_instantiate function and the
d_splice_alias function.  The inode_post_lookup hook was subject to
races since the inode is already accessible through the dcache before
it is called, didn't handle filesystems that directly populate the
dcache, and wasn't always called in the desired context (e.g. for
pipe, shmem, and devpts inodes).  The d_instantiate hook enables
initialization of the inode security information.  This hook is used
by SELinux and by DTE to setup the inode security state, and
eliminated the need for the inode_precondition function in SELinux.

3) Add a security_file_alloc call to init_private_file and create a
release_private_file function to encapsulate release of private file
structures.  These changes ensure that security structures for private
files will be allocated and freed appropriately.

If anyone has any objections to these changes, please let me know.

 fs/dcache.c              |    3 +++
 fs/exportfs/expfs.c      |    3 +--
 fs/file_table.c          |   22 ++++++++++++++++++----
 fs/namei.c               |    9 +++------
 fs/nfsd/vfs.c            |    3 +--
 fs/super.c               |    8 ++++++++
 include/linux/fs.h       |    1 +
 include/linux/security.h |   37 +++++++++++++++++++++----------------
 kernel/ksyms.c           |    1 +
 security/dummy.c         |   19 +++++++++++++------
 10 files changed, 70 insertions(+), 36 deletions(-)
------

===== fs/dcache.c 1.37 vs edited =====
--- 1.37/fs/dcache.c	Mon Nov 18 07:37:59 2002
+++ edited/fs/dcache.c	Tue Jan 14 08:17:03 2003
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <asm/uaccess.h>
+#include <linux/security.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -699,6 +700,7 @@
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	if (!list_empty(&entry->d_alias)) BUG();
+	security_d_instantiate(entry, inode);
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
@@ -825,6 +827,7 @@
 	struct dentry *new = NULL;
 
 	if (inode && S_ISDIR(inode->i_mode)) {
+		security_d_instantiate(dentry, inode);
 		spin_lock(&dcache_lock);
 		if (!list_empty(&inode->i_dentry)) {
 			new = list_entry(inode->i_dentry.next, struct dentry, d_alias);
===== fs/file_table.c 1.16 vs edited =====
--- 1.16/fs/file_table.c	Tue Nov 26 14:29:39 2002
+++ edited/fs/file_table.c	Tue Jan 14 08:17:03 2003
@@ -98,6 +98,7 @@
  */
 int init_private_file(struct file *filp, struct dentry *dentry, int mode)
 {
+	int error;
 	memset(filp, 0, sizeof(*filp));
 	eventpoll_init_file(filp);
 	filp->f_mode   = mode;
@@ -106,10 +107,23 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
-	if (filp->f_op->open)
-		return filp->f_op->open(dentry->d_inode, filp);
-	else
-		return 0;
+	error = security_file_alloc(filp);
+	if (!error)
+		if (filp->f_op->open) {
+			error = filp->f_op->open(dentry->d_inode, filp);
+			if (error)
+				security_file_free(filp);
+		}
+	return error;
+}
+
+void release_private_file(struct file *file)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+
+	if (file->f_op && file->f_op->release)
+		file->f_op->release(inode, file);
+	security_file_free(file);
 }
 
 void fput(struct file * file)
===== fs/namei.c 1.63 vs edited =====
--- 1.63/fs/namei.c	Sat Jan 11 00:06:26 2003
+++ edited/fs/namei.c	Tue Jan 14 08:17:03 2003
@@ -372,10 +372,8 @@
 			result = dir->i_op->lookup(dir, dentry);
 			if (result)
 				dput(dentry);
-			else {
+			else
 				result = dentry;
-				security_inode_post_lookup(dir, result);
-			}
 		}
 		up(&dir->i_sem);
 		return result;
@@ -916,10 +914,9 @@
 		if (!new)
 			goto out;
 		dentry = inode->i_op->lookup(inode, new);
-		if (!dentry) {
+		if (!dentry)
 			dentry = new;
-			security_inode_post_lookup(inode, dentry);
-		} else
+		else
 			dput(new);
 	}
 out:
===== fs/super.c 1.93 vs edited =====
--- 1.93/fs/super.c	Tue Dec 31 21:44:36 2002
+++ edited/fs/super.c	Tue Jan 14 08:17:03 2003
@@ -610,6 +610,7 @@
 	struct file_system_type *type = get_fs_type(fstype);
 	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
+	int error;
 
 	if (!type)
 		return ERR_PTR(-ENODEV);
@@ -620,6 +621,13 @@
 	sb = type->get_sb(type, flags, name, data);
 	if (IS_ERR(sb))
 		goto out_mnt;
+ 	error = security_sb_kern_mount(sb);
+ 	if (error) {
+ 		up_write(&sb->s_umount);
+ 		deactivate_super(sb);
+ 		sb = ERR_PTR(error);
+ 		goto out_mnt;
+ 	}
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
===== fs/exportfs/expfs.c 1.9 vs edited =====
--- 1.9/fs/exportfs/expfs.c	Thu Oct 10 19:07:34 2002
+++ edited/fs/exportfs/expfs.c	Tue Jan 14 08:17:03 2003
@@ -381,8 +381,7 @@
 	}
 
 out_close:
-	if (file.f_op->release)
-		file.f_op->release(dir, &file);
+	release_private_file(&file);
 out:
 	return error;
 }
===== fs/nfsd/vfs.c 1.55 vs edited =====
--- 1.55/fs/nfsd/vfs.c	Fri Jan 10 20:00:12 2003
+++ edited/fs/nfsd/vfs.c	Tue Jan 14 08:17:03 2003
@@ -491,8 +491,7 @@
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
 
-	if (filp->f_op->release)
-		filp->f_op->release(inode, filp);
+	release_private_file(filp);
 	if (filp->f_mode & FMODE_WRITE)
 		put_write_access(inode);
 }
===== include/linux/fs.h 1.210 vs edited =====
--- 1.210/include/linux/fs.h	Wed Jan  8 15:37:23 2003
+++ edited/include/linux/fs.h	Tue Jan 14 08:17:03 2003
@@ -493,6 +493,7 @@
 #define file_count(x)	atomic_read(&(x)->f_count)
 
 extern int init_private_file(struct file *, struct dentry *, int);
+extern void release_private_file(struct file *file);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
===== include/linux/security.h 1.9 vs edited =====
--- 1.9/include/linux/security.h	Wed Dec 18 09:10:50 2002
+++ edited/include/linux/security.h	Tue Jan 14 08:17:03 2003
@@ -339,10 +339,6 @@
  *	@mnt is the vfsmount where the dentry was looked up
  *	@dentry contains the dentry structure for the file.
  *	Return 0 if permission is granted.
- * @inode_post_lookup:
- *	Set the security attributes for a file after it has been looked up.
- *	@inode contains the inode structure for parent directory.
- *	@d contains the dentry structure for the file.
  * @inode_delete:
  *	@inode contains the inode structure for deleted inode.
  *	This hook is called when a deleted inode is released (i.e. an inode
@@ -814,6 +810,7 @@
 
 	int (*sb_alloc_security) (struct super_block * sb);
 	void (*sb_free_security) (struct super_block * sb);
+	int (*sb_kern_mount) (struct super_block *sb);
 	int (*sb_statfs) (struct super_block * sb);
 	int (*sb_mount) (char *dev_name, struct nameidata * nd,
 			 char *type, unsigned long flags, void *data);
@@ -867,7 +864,6 @@
 	int (*inode_permission_lite) (struct inode *inode, int mask);
 	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
 	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
-	void (*inode_post_lookup) (struct inode *inode, struct dentry *d);
         void (*inode_delete) (struct inode *inode);
 	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
 			       size_t size, int flags);
@@ -952,6 +948,8 @@
 	                          struct security_operations *ops);
 	int (*unregister_security) (const char *name,
 	                            struct security_operations *ops);
+
+	void (*d_instantiate) (struct dentry * dentry, struct inode * inode);
 };
 
 /* global variables */
@@ -1034,6 +1032,11 @@
 	security_ops->sb_free_security (sb);
 }
 
+static inline int security_sb_kern_mount (struct super_block *sb)
+{
+	return security_ops->sb_kern_mount (sb);
+}
+
 static inline int security_sb_statfs (struct super_block *sb)
 {
 	return security_ops->sb_statfs (sb);
@@ -1240,12 +1243,6 @@
 	return security_ops->inode_getattr (mnt, dentry);
 }
 
-static inline void security_inode_post_lookup (struct inode *inode,
-					       struct dentry *dentry)
-{
-	security_ops->inode_post_lookup (inode, dentry);
-}
-
 static inline void security_inode_delete (struct inode *inode)
 {
 	security_ops->inode_delete (inode);
@@ -1543,6 +1540,11 @@
 	return security_ops->sem_semop(sma, sops, nsops, alter);
 }
 
+static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	security_ops->d_instantiate (dentry, inode);
+}
+
 /* prototypes */
 extern int security_scaffolding_startup	(void);
 extern int register_security	(struct security_operations *ops);
@@ -1550,7 +1552,6 @@
 extern int mod_reg_security	(const char *name, struct security_operations *ops);
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
 
-
 #else /* CONFIG_SECURITY */
 
 /*
@@ -1639,6 +1640,11 @@
 static inline void security_sb_free (struct super_block *sb)
 { }
 
+static inline int security_sb_kern_mount (struct super_block *sb)
+{
+	return 0;
+}
+
 static inline int security_sb_statfs (struct super_block *sb)
 {
 	return 0;
@@ -1817,10 +1823,6 @@
 	return 0;
 }
 
-static inline void security_inode_post_lookup (struct inode *inode,
-					       struct dentry *dentry)
-{ }
-
 static inline void security_inode_delete (struct inode *inode)
 { }
 
@@ -2103,6 +2105,9 @@
 {
 	return 0;
 }
+
+static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
+{ }
 
 #endif	/* CONFIG_SECURITY */
 
===== kernel/ksyms.c 1.178 vs edited =====
--- 1.178/kernel/ksyms.c	Mon Jan 13 04:24:04 2003
+++ edited/kernel/ksyms.c	Tue Jan 14 08:17:03 2003
@@ -180,6 +180,7 @@
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(init_private_file);
+EXPORT_SYMBOL(release_private_file);
 EXPORT_SYMBOL(filp_open);
 EXPORT_SYMBOL(filp_close);
 EXPORT_SYMBOL(put_filp);
===== security/dummy.c 1.14 vs edited =====
--- 1.14/security/dummy.c	Wed Dec 18 09:11:56 2002
+++ edited/security/dummy.c	Tue Jan 14 08:17:03 2003
@@ -120,6 +120,11 @@
 	return;
 }
 
+static int dummy_sb_kern_mount (struct super_block *sb)
+{
+	return 0;
+}
+
 static int dummy_sb_statfs (struct super_block *sb)
 {
 	return 0;
@@ -306,11 +311,6 @@
 	return 0;
 }
 
-static void dummy_inode_post_lookup (struct inode *ino, struct dentry *d)
-{
-	return;
-}
-
 static void dummy_inode_delete (struct inode *ino)
 {
 	return;
@@ -607,6 +607,12 @@
 	return -EINVAL;
 }
 
+static void dummy_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
+
 struct security_operations dummy_security_ops;
 
 #define set_to_dummy_if_null(ops, function)				\
@@ -635,6 +641,7 @@
 	set_to_dummy_if_null(ops, bprm_check_security);
 	set_to_dummy_if_null(ops, sb_alloc_security);
 	set_to_dummy_if_null(ops, sb_free_security);
+	set_to_dummy_if_null(ops, sb_kern_mount);
 	set_to_dummy_if_null(ops, sb_statfs);
 	set_to_dummy_if_null(ops, sb_mount);
 	set_to_dummy_if_null(ops, sb_check_sb);
@@ -668,7 +675,6 @@
 	set_to_dummy_if_null(ops, inode_permission_lite);
 	set_to_dummy_if_null(ops, inode_setattr);
 	set_to_dummy_if_null(ops, inode_getattr);
-	set_to_dummy_if_null(ops, inode_post_lookup);
 	set_to_dummy_if_null(ops, inode_delete);
 	set_to_dummy_if_null(ops, inode_setxattr);
 	set_to_dummy_if_null(ops, inode_getxattr);
@@ -725,5 +731,6 @@
 	set_to_dummy_if_null(ops, sem_semop);
 	set_to_dummy_if_null(ops, register_security);
 	set_to_dummy_if_null(ops, unregister_security);
+	set_to_dummy_if_null(ops, d_instantiate);
 }
 


--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


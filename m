Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263118AbVCDUL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbVCDUL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVCDUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:09:29 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:23356 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S263034AbVCDTwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:52:08 -0500
Date: Fri, 4 Mar 2005 14:52:04 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to security
Message-ID: <20050304195204.GA19711@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
filesystem-internal. As such, it should be excepted from the security
infrastructure to allow the filesystem to perform its own access control.

Changes:
    - Post-operations for calls that generally instantiate the dentry but
      aren't obligated to now allow for a NULL dentry->d_inode

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.11.orig/include/linux/fs.h linux-2.6.11.devel/include/linux/fs.h
--- linux-2.6.11.orig/include/linux/fs.h	2005-03-02 02:37:50.000000000 -0500
+++ linux-2.6.11.devel/include/linux/fs.h	2005-03-04 09:58:45.000000000 -0500
@@ -129,6 +129,7 @@ extern int dir_notify_enable;
 #define S_DIRSYNC	64	/* Directory modifications are synchronous */
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
+#define S_PRIVATE	512	/* Inode is fs-internal */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -162,6 +163,7 @@ extern int dir_notify_enable;
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
+#define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
diff -ruNpX dontdiff linux-2.6.11.orig/include/linux/security.h linux-2.6.11.devel/include/linux/security.h
--- linux-2.6.11.orig/include/linux/security.h	2005-03-02 02:38:17.000000000 -0500
+++ linux-2.6.11.devel/include/linux/security.h	2005-03-04 10:02:40.000000000 -0500
@@ -1426,11 +1426,15 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_alloc_security (inode);
 }
 
 static inline void security_inode_free (struct inode *inode)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return;
 	security_ops->inode_free_security (inode);
 }
 	
@@ -1438,6 +1442,8 @@ static inline int security_inode_create 
 					 struct dentry *dentry,
 					 int mode)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_create (dir, dentry, mode);
 }
 
@@ -1445,6 +1451,8 @@ static inline void security_inode_post_c
 					       struct dentry *dentry,
 					       int mode)
 {
+	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_create (dir, dentry, mode);
 }
 
@@ -1452,6 +1460,8 @@ static inline int security_inode_link (s
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
+	if (unlikely (IS_PRIVATE (old_dentry->d_inode)))
+		return 0;
 	return security_ops->inode_link (old_dentry, dir, new_dentry);
 }
 
@@ -1459,12 +1469,16 @@ static inline void security_inode_post_l
 					     struct inode *dir,
 					     struct dentry *new_dentry)
 {
+	if (new_dentry->d_inode && unlikely (IS_PRIVATE (new_dentry->d_inode)))
+		return;
 	security_ops->inode_post_link (old_dentry, dir, new_dentry);
 }
 
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_unlink (dir, dentry);
 }
 
@@ -1472,6 +1486,8 @@ static inline int security_inode_symlink
 					  struct dentry *dentry,
 					  const char *old_name)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_symlink (dir, dentry, old_name);
 }
 
@@ -1479,6 +1495,8 @@ static inline void security_inode_post_s
 						struct dentry *dentry,
 						const char *old_name)
 {
+	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_symlink (dir, dentry, old_name);
 }
 
@@ -1486,6 +1504,8 @@ static inline int security_inode_mkdir (
 					struct dentry *dentry,
 					int mode)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_mkdir (dir, dentry, mode);
 }
 
@@ -1493,12 +1513,16 @@ static inline void security_inode_post_m
 					      struct dentry *dentry,
 					      int mode)
 {
+	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_mkdir (dir, dentry, mode);
 }
 
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_rmdir (dir, dentry);
 }
 
@@ -1506,6 +1530,8 @@ static inline int security_inode_mknod (
 					struct dentry *dentry,
 					int mode, dev_t dev)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_mknod (dir, dentry, mode, dev);
 }
 
@@ -1513,6 +1539,8 @@ static inline void security_inode_post_m
 					      struct dentry *dentry,
 					      int mode, dev_t dev)
 {
+	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_mknod (dir, dentry, mode, dev);
 }
 
@@ -1521,6 +1549,9 @@ static inline int security_inode_rename 
 					 struct inode *new_dir,
 					 struct dentry *new_dentry)
 {
+        if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
+            (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
+		return 0;
 	return security_ops->inode_rename (old_dir, old_dentry,
 					   new_dir, new_dentry);
 }
@@ -1530,83 +1561,114 @@ static inline void security_inode_post_r
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
 {
+	if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
+	    (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
+		return;
 	security_ops->inode_post_rename (old_dir, old_dentry,
 						new_dir, new_dentry);
 }
 
 static inline int security_inode_readlink (struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_readlink (dentry);
 }
 
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_follow_link (dentry, nd);
 }
 
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_permission (inode, mask, nd);
 }
 
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_setattr (dentry, attr);
 }
 
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_getattr (mnt, dentry);
 }
 
 static inline void security_inode_delete (struct inode *inode)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return;
 	security_ops->inode_delete (inode);
 }
 
 static inline int security_inode_setxattr (struct dentry *dentry, char *name,
 					   void *value, size_t size, int flags)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_setxattr (dentry, name, value, size, flags);
 }
 
 static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
 						void *value, size_t size, int flags)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
 }
 
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_getxattr (dentry, name);
 }
 
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_listxattr (dentry);
 }
 
 static inline int security_inode_removexattr (struct dentry *dentry, char *name)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_removexattr (dentry, name);
 }
 
 static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_getsecurity(inode, name, buffer, size);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_setsecurity(inode, name, value, size, flags);
 }
 
 static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
 }
 
@@ -1883,6 +1945,8 @@ static inline int security_sem_semop (st
 
 static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
 {
+	if (unlikely (inode && IS_PRIVATE (inode)))
+		return;
 	security_ops->d_instantiate (dentry, inode);
 }
 
-- 
Jeff Mahoney
SuSE Labs

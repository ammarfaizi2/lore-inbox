Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVBBQZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVBBQZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVBBQXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:23:21 -0500
Received: from news.suse.de ([195.135.220.2]:20653 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262404AbVBBQSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:18:25 -0500
Message-Id: <20050202161845.976934000@blunzn.suse.de>
References: <20050202161340.660712000@blunzn.suse.de>
Date: Wed, 26 Aug 1931 02:52:25 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Chris Mason <mason@suse.de>
Subject: [RFC][PATCH 2/3] Access Control Lists for tmpfs
Content-Disposition: inline; filename=tmpfs-acl.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add access control lists for tmpfs. There is more code in tmpfs itself
than in the generic acl layer, but at least the acl handling
complexities are hidden from the filesystem.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc2-mm2/mm/shmem.c
===================================================================
--- linux-2.6.11-rc2-mm2.orig/mm/shmem.c
+++ linux-2.6.11-rc2-mm2/mm/shmem.c
@@ -1617,6 +1617,8 @@ static int shmem_statfs(struct super_blo
 	return 0;
 }
 
+static void shmem_destroy_inode(struct inode *inode);
+
 /*
  * File creation. Allocate an inode, and we're done..
  */
@@ -1627,6 +1629,11 @@ shmem_mknod(struct inode *dir, struct de
 	int error = -ENOSPC;
 
 	if (inode) {
+		error = shmem_acl_init(inode, dir);
+		if (error) {
+			shmem_destroy_inode(inode);
+			return error;
+		}
 		if (dir->i_mode & S_ISGID) {
 			inode->i_gid = dir->i_gid;
 			if (S_ISDIR(mode))
@@ -1993,6 +2000,9 @@ static int shmem_fill_super(struct super
 		sbinfo->free_inodes = inodes;
 	}
 	sb->s_xattr = shmem_xattr_handlers;
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	sb->s_flags |= MS_POSIXACL;
+#endif
 #else
 	sb->s_flags |= MS_NOUSER;
 #endif
@@ -2037,6 +2047,7 @@ static void shmem_destroy_inode(struct i
 		/* only struct inode is valid if it's an inline symlink */
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
 	}
+	shmem_acl_destroy_inode(inode);
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
@@ -2047,6 +2058,10 @@ static void init_once(void *foo, kmem_ca
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
 		inode_init_once(&p->vfs_inode);
+#ifdef CONFIG_TMPFS_POSIX_ACL
+		p->i_acl = NULL;
+		p->i_default_acl = NULL;
+#endif
 	}
 }
 
@@ -2095,6 +2110,8 @@ static struct inode_operations shmem_ino
 	.listxattr      = generic_listxattr,
 	.removexattr    = generic_removexattr,
 #endif
+	.setattr	= shmem_setattr,
+	.permission	= shmem_permission,
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -2114,6 +2131,8 @@ static struct inode_operations shmem_dir
 	.listxattr      = generic_listxattr,
 	.removexattr    = generic_removexattr,
 #endif
+	.setattr	= shmem_setattr,
+	.permission	= shmem_permission,
 #endif
 };
 
@@ -2124,6 +2143,8 @@ static struct inode_operations shmem_spe
 	.listxattr	= generic_listxattr,
 	.removexattr	= generic_removexattr,
 #endif
+	.setattr	= shmem_setattr,
+	.permission	= shmem_permission,
 };
 
 static struct super_operations shmem_ops = {
@@ -2182,6 +2203,10 @@ static struct xattr_handler shmem_xattr_
 #ifdef CONFIG_TMPFS_XATTR
 
 static struct xattr_handler *shmem_xattr_handlers[] = {
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	&shmem_xattr_acl_access_handler,
+	&shmem_xattr_acl_default_handler,
+#endif
 #ifdef CONFIG_TMPFS_SECURITY
 	&shmem_xattr_security_handler,
 #endif
Index: linux-2.6.11-rc2-mm2/include/linux/shmem_fs.h
===================================================================
--- linux-2.6.11-rc2-mm2.orig/include/linux/shmem_fs.h
+++ linux-2.6.11-rc2-mm2/include/linux/shmem_fs.h
@@ -19,6 +19,10 @@ struct shmem_inode_info {
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* first blocks */
 	struct list_head	swaplist;	/* chain of maybes on swap */
 	struct inode		vfs_inode;
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	struct posix_acl	*i_acl;
+	struct posix_acl	*i_default_acl;
+#endif
 };
 
 struct shmem_sb_info {
@@ -34,4 +38,25 @@ static inline struct shmem_inode_info *S
 	return container_of(inode, struct shmem_inode_info, vfs_inode);
 }
 
+#ifdef CONFIG_TMPFS_POSIX_ACL
+int shmem_setattr(struct dentry *, struct iattr *);
+int shmem_permission(struct inode *, int, struct nameidata *);
+int shmem_acl_init(struct inode *, struct inode *);
+void shmem_acl_destroy_inode(struct inode *);
+
+extern struct xattr_handler shmem_xattr_acl_access_handler;
+extern struct xattr_handler shmem_xattr_acl_default_handler;
+#else
+#define shmem_setattr NULL
+#define shmem_permission NULL
+
+static inline int shmem_acl_init(struct inode *inode, struct inode *dir)
+{
+	return 0;
+}
+void shmem_acl_destroy_inode(struct inode *inode)
+{
+}
+#endif  /* CONFIG_TMPFS_POSIX_ACL */
+
 #endif
Index: linux-2.6.11-rc2-mm2/fs/Kconfig
===================================================================
--- linux-2.6.11-rc2-mm2.orig/fs/Kconfig
+++ linux-2.6.11-rc2-mm2/fs/Kconfig
@@ -884,6 +884,19 @@ config TMPFS_XATTR
 
 	  If unsure, say N.
 
+config TMPFS_POSIX_ACL
+	bool "tmpfs POSIX Access Control Lists"
+	depends on TMPFS_XATTR
+	select GENERIC_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the POSIX ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N.
+
 config TMPFS_SECURITY
 	bool "tmpfs Security Labels"
 	depends on TMPFS_XATTR
Index: linux-2.6.11-rc2-mm2/mm/shmem_acl.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc2-mm2/mm/shmem_acl.c
@@ -0,0 +1,178 @@
+/*
+ * mm/shmem_acl.c
+ *
+ * (C) 2005 Andreas Gruenbacher <agruen@suse.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
+#include <linux/xattr.h>
+#include <linux/generic_acl.h>
+
+static struct posix_acl *
+shmem_get_acl(struct inode *inode, int type)
+{
+	struct posix_acl *acl = NULL;
+
+	spin_lock(&inode->i_lock);
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			acl = posix_acl_dup(SHMEM_I(inode)->i_acl);
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			acl = posix_acl_dup(SHMEM_I(inode)->i_default_acl);
+			break;
+	}
+	spin_unlock(&inode->i_lock);
+
+	return acl;
+}
+
+static void
+shmem_set_acl(struct inode *inode, int type, struct posix_acl *acl)
+{
+	spin_lock(&inode->i_lock);
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			if (SHMEM_I(inode)->i_acl)
+				posix_acl_release(SHMEM_I(inode)->i_acl);
+			SHMEM_I(inode)->i_acl = posix_acl_dup(acl);
+			break;
+			
+		case ACL_TYPE_DEFAULT:
+			if (SHMEM_I(inode)->i_default_acl)
+				posix_acl_release(SHMEM_I(inode)->i_default_acl);
+			SHMEM_I(inode)->i_default_acl = posix_acl_dup(acl);
+			break;
+	}
+	spin_unlock(&inode->i_lock);
+}
+
+struct generic_acl_operations shmem_acl_ops = {
+	.getacl = shmem_get_acl,
+	.setacl = shmem_set_acl,
+};
+
+static size_t
+shmem_list_acl_access(struct inode *inode, char *list, size_t list_size,
+		      const char *name, size_t name_len)
+{
+	return generic_acl_list(inode, &shmem_acl_ops, ACL_TYPE_ACCESS,
+				list, list_size);
+}
+
+static size_t
+shmem_list_acl_default(struct inode *inode, char *list, size_t list_size,
+		       const char *name, size_t name_len)
+{
+	return generic_acl_list(inode, &shmem_acl_ops, ACL_TYPE_DEFAULT,
+				list, list_size);
+}
+
+static int
+shmem_get_acl_access(struct inode *inode, const char *name, void *buffer,
+		     size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_get(inode, &shmem_acl_ops, ACL_TYPE_ACCESS, buffer,
+			       size);
+}
+
+static int
+shmem_get_acl_default(struct inode *inode, const char *name, void *buffer,
+		      size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_get(inode, &shmem_acl_ops, ACL_TYPE_DEFAULT, buffer,
+			       size);
+}
+
+static int
+shmem_set_acl_access(struct inode *inode, const char *name, const void *value,
+		     size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_set(inode, &shmem_acl_ops, ACL_TYPE_ACCESS, value,
+			       size);
+}
+
+static int
+shmem_set_acl_default(struct inode *inode, const char *name, const void *value,
+		      size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_set(inode, &shmem_acl_ops, ACL_TYPE_DEFAULT, value,
+			       size);
+}
+
+struct xattr_handler shmem_xattr_acl_access_handler = {
+	.prefix = XATTR_NAME_ACL_ACCESS,
+	.list	= shmem_list_acl_access,
+	.get	= shmem_get_acl_access,
+	.set	= shmem_set_acl_access,
+};
+
+struct xattr_handler shmem_xattr_acl_default_handler = {
+	.prefix = XATTR_NAME_ACL_DEFAULT,
+	.list	= shmem_list_acl_default,
+	.get	= shmem_get_acl_default,
+	.set	= shmem_set_acl_default,
+};
+
+int
+shmem_acl_init(struct inode *inode, struct inode *dir)
+{
+	return generic_acl_init(inode, dir, &shmem_acl_ops);
+}
+
+void
+shmem_acl_destroy_inode(struct inode *inode)
+{
+	if (SHMEM_I(inode)->i_acl)
+		posix_acl_release(SHMEM_I(inode)->i_acl);
+	if (SHMEM_I(inode)->i_default_acl)
+		posix_acl_release(SHMEM_I(inode)->i_default_acl);
+	SHMEM_I(inode)->i_acl = NULL;
+	SHMEM_I(inode)->i_default_acl = NULL;
+}
+
+int
+shmem_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+	
+	error = inode_change_ok(inode, iattr);
+	if (error)
+		return error;
+	error = inode_setattr(inode, iattr);
+	if (!error && (iattr->ia_valid & ATTR_MODE))
+		error = generic_acl_chmod(inode, &shmem_acl_ops);
+	return error;
+}
+
+static int
+shmem_check_acl(struct inode *inode, int mask)
+{
+	struct posix_acl *acl = shmem_get_acl(inode, ACL_TYPE_ACCESS);
+
+	if (acl) {
+		int error = posix_acl_permission(inode, acl, mask);
+		posix_acl_release(acl);
+		return error;
+	}
+	return -EAGAIN;
+}
+
+int
+shmem_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	return generic_permission(inode, mask, shmem_check_acl);
+}
Index: linux-2.6.11-rc2-mm2/mm/Makefile
===================================================================
--- linux-2.6.11-rc2-mm2.orig/mm/Makefile
+++ linux-2.6.11-rc2-mm2/mm/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+obj-$(CONFIG_TMPFS_POSIX_ACL) += shmem_acl.o
 

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVBBQZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVBBQZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVBBQYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:24:52 -0500
Received: from cantor.suse.de ([195.135.220.2]:20397 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262396AbVBBQSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:18:25 -0500
Message-Id: <20050202161846.093204000@blunzn.suse.de>
References: <20050202161340.660712000@blunzn.suse.de>
Date: Wed, 26 Aug 1931 02:51:25 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Chris Mason <mason@suse.de>
Subject: [RFC][PATCH 3/3] Access Control Lists for /dev/pts
Content-Disposition: inline; filename=devpts-acl.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/dev/pts is somewhat special: there are no directories, and so we
don't need default acls.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc2-mm2/fs/devpts/inode.c
===================================================================
--- linux-2.6.11-rc2-mm2.orig/fs/devpts/inode.c
+++ linux-2.6.11-rc2-mm2/fs/devpts/inode.c
@@ -19,15 +19,43 @@
 #include <linux/tty.h>
 #include <linux/devpts_fs.h>
 #include <linux/xattr.h>
+#include <linux/generic_acl.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
+#ifdef CONFIG_DEVPTS_POSIX_ACL
+static struct inode *
+devpts_alloc_inode(struct super_block *sb)
+{
+	struct devpts_inode_info *ei;
+	ei = kmalloc(sizeof(*ei), SLAB_KERNEL);
+	if (!ei)
+		return NULL;
+	inode_init_once(&ei->vfs_inode);
+	ei->i_acl = NULL;
+	return &ei->vfs_inode;
+}
+
+static void
+devpts_destroy_inode(struct inode *inode)
+{
+	struct devpts_inode_info *ei = DEVPTS_I(inode);
+	if (ei->i_acl)
+		posix_acl_release(ei->i_acl);
+	kfree(ei);
+}
+#endif  /* CONFIG_DEVPTS_POSIX_ACL */
+
 extern struct xattr_handler devpts_xattr_security_handler;
+extern struct xattr_handler devpts_xattr_acl_access_handler;
 
 static struct xattr_handler *devpts_xattr_handlers[] = {
 #ifdef CONFIG_DEVPTS_FS_SECURITY
 	&devpts_xattr_security_handler,
 #endif
+#ifdef CONFIG_DEVPTS_POSIX_ACL
+	&devpts_xattr_acl_access_handler,
+#endif
 	NULL
 };
 
@@ -38,6 +66,10 @@ static struct inode_operations devpts_fi
 	.listxattr	= generic_listxattr,
 	.removexattr	= generic_removexattr,
 #endif
+#ifdef CONFIG_DEVPTS_POSIX_ACL
+	.setattr	= devpts_setattr,
+	.permission	= devpts_permission,
+#endif
 };
 
 static struct vfsmount *devpts_mnt;
@@ -89,6 +121,10 @@ static int devpts_remount(struct super_b
 }
 
 static struct super_operations devpts_sops = {
+#ifdef CONFIG_DEVPTS_POSIX_ACL
+	.alloc_inode    = devpts_alloc_inode,
+	.destroy_inode	= devpts_destroy_inode,
+#endif
 	.statfs		= simple_statfs,
 	.remount_fs	= devpts_remount,
 };
@@ -117,6 +153,9 @@ devpts_fill_super(struct super_block *s,
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_nlink = 2;
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	s->s_flags |= MS_POSIXACL;
+#endif
 
 	devpts_root = s->s_root = d_alloc_root(inode);
 	if (s->s_root)
Index: linux-2.6.11-rc2-mm2/fs/devpts/Makefile
===================================================================
--- linux-2.6.11-rc2-mm2.orig/fs/devpts/Makefile
+++ linux-2.6.11-rc2-mm2/fs/devpts/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_UNIX98_PTYS)		+= devpts.o
 
 devpts-$(CONFIG_UNIX98_PTYS)		:= inode.o
 devpts-$(CONFIG_DEVPTS_FS_SECURITY)	+= xattr_security.o
+devpts-$(CONFIG_DEVPTS_POSIX_ACL)	+= acl.o
Index: linux-2.6.11-rc2-mm2/include/linux/devpts_fs.h
===================================================================
--- linux-2.6.11-rc2-mm2.orig/include/linux/devpts_fs.h
+++ linux-2.6.11-rc2-mm2/include/linux/devpts_fs.h
@@ -17,6 +17,23 @@
 
 #ifdef CONFIG_UNIX98_PTYS
 
+#ifdef CONFIG_DEVPTS_POSIX_ACL
+struct devpts_inode_info {
+	struct posix_acl	*i_acl;
+	struct inode		vfs_inode;
+};
+
+static inline struct devpts_inode_info *DEVPTS_I(struct inode *inode)
+{
+	return container_of(inode, struct devpts_inode_info, vfs_inode);
+}
+
+/* acl.c */
+int devpts_setattr(struct dentry *, struct iattr *);
+int devpts_permission(struct inode *, int, struct nameidata *);
+#endif  /* CONFIG_DEVPTS_POSIX_ACL */
+
+/* inode.c */
 int devpts_pty_new(struct tty_struct *tty);      /* mknod in devpts */
 struct tty_struct *devpts_get_tty(int number);	 /* get tty structure */
 void devpts_pty_kill(int number);		 /* unlink */
Index: linux-2.6.11-rc2-mm2/fs/Kconfig
===================================================================
--- linux-2.6.11-rc2-mm2.orig/fs/Kconfig
+++ linux-2.6.11-rc2-mm2/fs/Kconfig
@@ -850,6 +850,19 @@ config DEVPTS_FS_XATTR
 
 	  If unsure, say N.
 
+config DEVPTS_POSIX_ACL
+	bool "/dev/pts POSIX Access Control Lists"
+	depends on DEVPTS_FS_XATTR
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
 config DEVPTS_FS_SECURITY
 	bool "/dev/pts Security Labels"
 	depends on DEVPTS_FS_XATTR
Index: linux-2.6.11-rc2-mm2/fs/devpts/acl.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc2-mm2/fs/devpts/acl.c
@@ -0,0 +1,112 @@
+/*
+ * fs/devpts/acl.c
+ *
+ * (C) 2005 Andreas Gruenbacher <agruen@suse.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/fs.h>
+#include <linux/tty.h>
+#include <linux/devpts_fs.h>
+#include <linux/xattr.h>
+#include <linux/generic_acl.h>
+
+static struct posix_acl *
+devpts_get_acl(struct inode *inode, int type)
+{
+	struct posix_acl *acl = NULL;
+
+	spin_lock(&inode->i_lock);
+	if (type == ACL_TYPE_ACCESS)
+		acl = posix_acl_dup(DEVPTS_I(inode)->i_acl);
+	spin_unlock(&inode->i_lock);
+
+	return acl;
+}
+
+static void
+devpts_set_acl(struct inode *inode, int type, struct posix_acl *acl)
+{
+	spin_lock(&inode->i_lock);
+	if (type == ACL_TYPE_ACCESS) {
+		if (DEVPTS_I(inode)->i_acl)
+			posix_acl_release(DEVPTS_I(inode)->i_acl);
+		DEVPTS_I(inode)->i_acl = posix_acl_dup(acl);
+	}
+	spin_unlock(&inode->i_lock);
+}
+
+struct generic_acl_operations devpts_acl_ops = {
+	.getacl = devpts_get_acl,
+	.setacl = devpts_set_acl,
+};
+
+static size_t
+devpts_list_acl_access(struct inode *inode, char *list, size_t list_size,
+		       const char *name, size_t name_len)
+{
+	return generic_acl_list(inode, &devpts_acl_ops, ACL_TYPE_ACCESS,
+				list, list_size);
+}
+
+static int
+devpts_get_acl_access(struct inode *inode, const char *name, void *buffer,
+		      size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_get(inode, &devpts_acl_ops, ACL_TYPE_ACCESS, buffer,
+			       size);
+}
+
+static int
+devpts_set_acl_access(struct inode *inode, const char *name, const void *value,
+		      size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_set(inode, &devpts_acl_ops, ACL_TYPE_ACCESS, value,
+			       size);
+}
+
+struct xattr_handler devpts_xattr_acl_access_handler = {
+	.prefix = XATTR_NAME_ACL_ACCESS,
+	.list   = devpts_list_acl_access,
+	.get    = devpts_get_acl_access,
+	.set    = devpts_set_acl_access,
+};
+
+int
+devpts_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	error = inode_change_ok(inode, iattr);
+	if (error)
+		return error;
+	error = inode_setattr(inode, iattr);
+	if (!error && (iattr->ia_valid & ATTR_MODE))
+		error = generic_acl_chmod(inode, &devpts_acl_ops);
+	return error;
+}
+
+static int
+devpts_check_acl(struct inode *inode, int mask)
+{
+        struct posix_acl *acl = devpts_get_acl(inode, ACL_TYPE_ACCESS);
+
+        if (acl) {
+                int error = posix_acl_permission(inode, acl, mask);
+                posix_acl_release(acl);
+                return error;
+        }
+        return -EAGAIN;
+}
+
+int
+devpts_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+        return generic_permission(inode, mask, devpts_check_acl);
+}

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUIWEGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUIWEGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUIWEGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:06:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268248AbUIWD7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:59:19 -0400
Date: Wed, 22 Sep 2004 23:59:06 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] xattr consolidation v3 - tmpfs
In-Reply-To: <Xine.LNX.4.44.0409222351160.447@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409222351480.447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds xattr support to tmpfs, and a security xattr handler.
The purpose of this is to allow udev to be mounted on tmpfs, as
used currently by Fedora.

Original patch from: Luke Kenneth Casson Leighton <lkcl@lkcl.net>.


 fs/Kconfig |   21 ++++++++++++++
 mm/shmem.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/Kconfig linux-2.6.9-rc2-mm2.w/fs/Kconfig
--- linux-2.6.9-rc2-mm2.p/fs/Kconfig	2004-09-22 19:05:34.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/Kconfig	2004-09-22 19:34:38.000000000 -0400
@@ -944,6 +944,27 @@ config TMPFS
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
+config TMPFS_XATTR
+	bool "tmpfs Extended Attributes"
+	depends on TMPFS
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+	  
+	  If unsure, say N.
+
+config TMPFS_SECURITY
+	bool "tmpfs Security Labels"
+	depends on TMPFS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the tmpfs filesystem.
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/mm/shmem.c linux-2.6.9-rc2-mm2.w/mm/shmem.c
--- linux-2.6.9-rc2-mm2.p/mm/shmem.c	2004-09-22 19:05:36.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/mm/shmem.c	2004-09-22 19:55:32.000000000 -0400
@@ -10,6 +10,10 @@
  * Copyright (C) 2002-2004 VERITAS Software Corporation.
  * Copyright (C) 2004 Andi Kleen, SuSE Labs
  *
+ * Extended attribute support for tmpfs:
+ * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
  * This file is released under the GPL.
  */
 
@@ -41,6 +45,7 @@
 #include <linux/swapops.h>
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
+#include <linux/xattr.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/pgtable.h>
@@ -171,6 +176,7 @@ static struct address_space_operations s
 static struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
+static struct inode_operations shmem_special_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
@@ -1235,6 +1241,7 @@ shmem_get_inode(struct super_block *sb, 
 
 		switch (mode & S_IFMT) {
 		default:
+			inode->i_op = &shmem_special_inode_operations;
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
@@ -1756,6 +1763,12 @@ static void shmem_put_link(struct dentry
 static struct inode_operations shmem_symlink_inline_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link_inline,
+#ifdef CONFIG_TMPFS_XATTR
+	.setxattr       = generic_setxattr,
+	.getxattr       = generic_getxattr,
+	.listxattr      = generic_listxattr,
+	.removexattr    = generic_removexattr,
+#endif
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
@@ -1763,6 +1776,12 @@ static struct inode_operations shmem_sym
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link,
 	.put_link	= shmem_put_link,
+#ifdef CONFIG_TMPFS_XATTR
+	.setxattr       = generic_setxattr,
+	.getxattr       = generic_getxattr,
+	.listxattr      = generic_listxattr,
+	.removexattr    = generic_removexattr,
+#endif
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
@@ -1862,6 +1881,12 @@ static void shmem_put_super(struct super
 	sb->s_fs_info = NULL;
 }
 
+#ifdef CONFIG_TMPFS_XATTR
+static struct xattr_handler *shmem_xattr_handlers[];
+#else
+#define shmem_xattr_handlers NULL
+#endif
+
 static int shmem_fill_super(struct super_block *sb,
 			    void *data, int silent)
 {
@@ -1904,6 +1929,7 @@ static int shmem_fill_super(struct super
 		sbinfo->max_inodes = inodes;
 		sbinfo->free_inodes = inodes;
 	}
+	sb->s_xattr = shmem_xattr_handlers;
 #endif
 
 	sb->s_maxbytes = SHMEM_MAX_BYTES;
@@ -1995,6 +2021,12 @@ static struct file_operations shmem_file
 static struct inode_operations shmem_inode_operations = {
 	.truncate	= shmem_truncate,
 	.setattr	= shmem_notify_change,
+#ifdef CONFIG_TMPFS_XATTR
+	.setxattr       = generic_setxattr,
+	.getxattr       = generic_getxattr,
+	.listxattr      = generic_listxattr,
+	.removexattr    = generic_removexattr,
+#endif
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -2008,6 +2040,21 @@ static struct inode_operations shmem_dir
 	.rmdir		= shmem_rmdir,
 	.mknod		= shmem_mknod,
 	.rename		= shmem_rename,
+#ifdef CONFIG_TMPFS_XATTR
+	.setxattr       = generic_setxattr,
+	.getxattr       = generic_getxattr,
+	.listxattr      = generic_listxattr,
+	.removexattr    = generic_removexattr,
+#endif
+#endif
+};
+
+static struct inode_operations shmem_special_inode_operations = {
+#ifdef CONFIG_TMPFS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= generic_listxattr,
+	.removexattr	= generic_removexattr,
 #endif
 };
 
@@ -2032,6 +2079,49 @@ static struct vm_operations_struct shmem
 #endif
 };
 
+
+#ifdef CONFIG_TMPFS_SECURITY
+
+static size_t shmem_xattr_security_list(struct inode *inode, char *list, size_t list_len,
+					const char *name, size_t name_len)
+{
+	return security_inode_listsecurity(inode, list, name_len);
+}
+
+static int shmem_xattr_security_get(struct inode *inode, const char *name, void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_getsecurity(inode, name, buffer, size);
+}
+
+static int shmem_xattr_security_set(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_setsecurity(inode, name, value, size, flags);
+}
+
+struct xattr_handler shmem_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= shmem_xattr_security_list,
+	.get	= shmem_xattr_security_get,
+	.set	= shmem_xattr_security_set,
+};
+
+#endif	/* CONFIG_TMPFS_SECURITY */
+
+#ifdef CONFIG_TMPFS_XATTR
+
+static struct xattr_handler *shmem_xattr_handlers[] = {
+#ifdef CONFIG_TMPFS_SECURITY
+	&shmem_xattr_security_handler,
+#endif	
+	NULL
+};
+
+#endif	/* CONFIG_TMPFS_XATTR */
+
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {



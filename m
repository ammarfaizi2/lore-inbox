Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269150AbUIRHcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269150AbUIRHcd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUIRHcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:32:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31931 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269150AbUIRH2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:28:43 -0400
Date: Sat, 18 Sep 2004 03:28:24 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] xattr consolidation v2 - tmpfs
In-Reply-To: <Xine.LNX.4.44.0409180311550.10905@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409180313250.10905-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds xattr support to tmpfs, and a security xattr handler.
The purpose of this is to allow udev to be mounted on tmpfs, as 
used currently by Fedora.

Original patch from: Luke Kenneth Casson Leighton <lkcl@lkcl.net>.


 fs/Kconfig |   21 ++++++++++++++
 mm/shmem.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)


Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/Kconfig linux-2.6.9-rc2.w/fs/Kconfig
--- linux-2.6.9-rc2.p/fs/Kconfig	2004-09-13 01:32:54.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/Kconfig	2004-09-18 02:11:02.412291912 -0400
@@ -919,6 +919,27 @@ config TMPFS
 
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
diff -purN -X dontdiff linux-2.6.9-rc2.p/mm/shmem.c linux-2.6.9-rc2.w/mm/shmem.c
--- linux-2.6.9-rc2.p/mm/shmem.c	2004-09-13 01:32:26.000000000 -0400
+++ linux-2.6.9-rc2.w/mm/shmem.c	2004-09-18 02:10:28.785403976 -0400
@@ -10,6 +10,10 @@
  * Copyright (C) 2002-2003 VERITAS Software Corporation.
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
@@ -1211,6 +1217,7 @@ shmem_get_inode(struct super_block *sb, 
  		mpol_shared_policy_init(&info->policy);
 		switch (mode & S_IFMT) {
 		default:
+			inode->i_op = &shmem_special_inode_operations;
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
@@ -1708,6 +1715,12 @@ static void shmem_put_link(struct dentry
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
@@ -1715,6 +1728,12 @@ static struct inode_operations shmem_sym
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
@@ -1798,6 +1817,12 @@ static int shmem_remount_fs(struct super
 }
 #endif
 
+#ifdef CONFIG_TMPFS_XATTR
+static struct xattr_handler *shmem_xattr_handlers[];
+#else
+#define shmem_xattr_handlers NULL
+#endif
+
 static int shmem_fill_super(struct super_block *sb,
 			    void *data, int silent)
 {
@@ -1814,6 +1839,7 @@ static int shmem_fill_super(struct super
 	if (!sbinfo)
 		return -ENOMEM;
 	sb->s_fs_info = sbinfo;
+	sb->s_xattr = shmem_xattr_handlers;
 	memset(sbinfo, 0, sizeof(struct shmem_sb_info));
 
 	/*
@@ -1933,6 +1959,12 @@ static struct file_operations shmem_file
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
@@ -1946,6 +1978,21 @@ static struct inode_operations shmem_dir
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
 
@@ -1970,6 +2017,48 @@ static struct vm_operations_struct shmem
 #endif
 };
 
+
+#ifdef CONFIG_TMPFS_SECURITY
+
+static size_t shmem_xattr_security_list(struct inode *inode, char *list, const char *name, int name_len)
+{
+	return security_inode_listsecurity(inode, list);
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



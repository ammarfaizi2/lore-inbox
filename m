Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbTEASAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbTEASAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:00:30 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:25223 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261184AbTEASAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:00:16 -0400
Subject: [PATCH] ext2 xattr handler for security modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Christoph Hellwig <hch@infradead.org>, ext2-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051812082.1377.276.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 14:12:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.68 implements an xattr handler for ext2 to
support the use of extended attributes by security modules for storing
file security labels.  As per the earlier discussion of extended
attributes for security modules, this handler uses a "security." prefix
and allows for per-module attribute names.  Security checking on
userspace access to these attributes can be performed by the security
module using the LSM hooks in fs/xattr.c, and the security module is
free to internally use the inode operations without restriction for
managing its security labels.  Unlike the trusted namespace, these
labels are used internally for access control purposes by the security
module, and controls over userspace access to them require finer
granularity than capable() supports.  Please apply, or let me know if
any changes are needed.  Thanks.

Index: linux-2.5/fs/Kconfig
diff -u linux-2.5/fs/Kconfig:1.1.1.3 linux-2.5/fs/Kconfig:1.5
--- linux-2.5/fs/Kconfig:1.1.1.3	Tue Mar 25 09:36:05 2003
+++ linux-2.5/fs/Kconfig	Fri Apr 18 12:16:24 2003
@@ -73,6 +73,18 @@
 
 	  If you don't know what Access Control Lists are, say N
 
+config EXT2_FS_SECURITY
+	bool "Ext2 Security Labels"
+	depends on EXT2_FS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the ext2 filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config EXT3_FS
 	tristate "Ext3 journalling file system support"
 	help
Index: linux-2.5/fs/ext2/Makefile
diff -u linux-2.5/fs/ext2/Makefile:1.1.1.1 linux-2.5/fs/ext2/Makefile:1.2
--- linux-2.5/fs/ext2/Makefile:1.1.1.1	Wed Mar 12 10:55:33 2003
+++ linux-2.5/fs/ext2/Makefile	Fri Apr 18 12:16:34 2003
@@ -14,3 +14,7 @@
 ifeq ($(CONFIG_EXT2_FS_POSIX_ACL),y)
 ext2-objs += acl.o
 endif
+
+ifeq ($(CONFIG_EXT2_FS_SECURITY),y)
+ext2-objs += xattr_security.o
+endif
Index: linux-2.5/fs/ext2/xattr.c
diff -u linux-2.5/fs/ext2/xattr.c:1.1.1.4 linux-2.5/fs/ext2/xattr.c:1.3
--- linux-2.5/fs/ext2/xattr.c:1.1.1.4	Mon Apr 21 10:15:47 2003
+++ linux-2.5/fs/ext2/xattr.c	Mon Apr 21 11:03:31 2003
@@ -1102,22 +1102,33 @@
 				  &ext2_xattr_trusted_handler);
 	if (err)
 		goto out;
+#ifdef CONFIG_EXT2_FS_SECURITY
+	err = ext2_xattr_register(EXT2_XATTR_INDEX_SECURITY,
+				  &ext2_xattr_security_handler);
+	if (err)
+		goto out1;
+#endif
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	err = init_ext2_acl();
 	if (err)
-		goto out1;
+		goto out2;
 #endif
 	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
 	if (!ext2_xattr_cache) {
 		err = -ENOMEM;
-		goto out2;
+		goto out3;
 	}
 	return 0;
-out2:
+out3:
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	exit_ext2_acl();
+out2:
+#endif
+#ifdef CONFIG_EXT2_FS_SECURITY
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
+			      &ext2_xattr_security_handler);
 out1:
 #endif
 	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
@@ -1134,6 +1145,10 @@
 	mb_cache_destroy(ext2_xattr_cache);
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	exit_ext2_acl();
+#endif
+#ifdef CONFIG_EXT2_FS_SECURITY
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
+			      &ext2_xattr_security_handler);
 #endif
 	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
 			      &ext2_xattr_trusted_handler);
Index: linux-2.5/fs/ext2/xattr.h
diff -u linux-2.5/fs/ext2/xattr.h:1.1.1.1 linux-2.5/fs/ext2/xattr.h:1.2
--- linux-2.5/fs/ext2/xattr.h:1.1.1.1	Wed Mar 12 10:55:33 2003
+++ linux-2.5/fs/ext2/xattr.h	Fri Apr 18 12:16:34 2003
@@ -22,6 +22,7 @@
 #define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
 #define EXT2_XATTR_INDEX_TRUSTED		4
+#define EXT2_XATTR_INDEX_SECURITY	        5
 
 struct ext2_xattr_header {
 	__u32	h_magic;	/* magic number for identification */
@@ -134,4 +135,5 @@
 
 extern struct ext2_xattr_handler ext2_xattr_user_handler;
 extern struct ext2_xattr_handler ext2_xattr_trusted_handler;
+extern struct ext2_xattr_handler ext2_xattr_security_handler;
 
Index: linux-2.5/fs/ext2/xattr_security.c
diff -u /dev/null linux-2.5/fs/ext2/xattr_security.c:1.2
--- /dev/null	Thu May  1 12:55:01 2003
+++ linux-2.5/fs/ext2/xattr_security.c	Thu Apr 24 14:46:04 2003
@@ -0,0 +1,54 @@
+/*
+ * linux/fs/ext2/xattr_security.c
+ * Handler for storing security labels as extended attributes.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ext2_fs.h>
+#include "xattr.h"
+
+#define XATTR_SECURITY_PREFIX "security."
+
+static size_t
+ext2_xattr_security_list(char *list, struct inode *inode,
+			const char *name, int name_len)
+{
+	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
+
+	if (list) {
+		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
+		memcpy(list+prefix_len, name, name_len);
+		list[prefix_len + name_len] = '\0';
+	}
+	return prefix_len + name_len + 1;
+}
+
+static int
+ext2_xattr_security_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_SECURITY, name,
+			      buffer, size);
+}
+
+static int
+ext2_xattr_security_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY, name,
+			      value, size, flags);
+}
+
+struct ext2_xattr_handler ext2_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= ext2_xattr_security_list,
+	.get	= ext2_xattr_security_get,
+	.set	= ext2_xattr_security_set,
+};



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


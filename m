Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTEASAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbTEASAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:00:19 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:24967 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261159AbTEASAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:00:13 -0400
Subject: [PATCH] ext3 xattr handler for security modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Andreas Dilger <adilger@clusterfs.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051812724.1377.286.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 14:12:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.68 implements an xattr handler for ext3 to
support the use of extended attributes by security modules for storing
file security labels.  As per the earlier discussion of extended
attributes for security modules, this handler uses a "security." prefix
and allows for per-module attribute names.  Security checking for
userspace access to these attributes can be performed by the security
module using the LSM hooks in fs/xattr.c, and the security module is
free to internally use the inode operations without restriction for
managing its security labels.  Unlike the trusted namespace, these
labels are used internally for access control purposes by the security
modules, and controls over userspace access to them require finer
granularity than capable() supports.  Please apply, or let me know if
any changes are needed.  Thanks.

Index: linux-2.5/fs/Kconfig
diff -u linux-2.5/fs/Kconfig:1.1.1.3 linux-2.5/fs/Kconfig:1.5
--- linux-2.5/fs/Kconfig:1.1.1.3	Tue Mar 25 09:36:05 2003
+++ linux-2.5/fs/Kconfig	Fri Apr 18 12:16:24 2003
@@ -130,6 +142,18 @@
 	  Linux website <http://acl.bestbits.at/>.
 
 	  If you don't know what Access Control Lists are, say N
+
+config EXT3_FS_SECURITY
+	bool "Ext3 Security Labels"
+	depends on EXT3_FS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the ext3 filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
 
 config JBD
 # CONFIG_JBD could be its own option (even modular), but until there are
Index: linux-2.5/fs/ext3/Makefile
diff -u linux-2.5/fs/ext3/Makefile:1.1.1.1 linux-2.5/fs/ext3/Makefile:1.2
--- linux-2.5/fs/ext3/Makefile:1.1.1.1	Wed Mar 12 10:55:31 2003
+++ linux-2.5/fs/ext3/Makefile	Wed Mar 26 14:03:26 2003
@@ -14,3 +14,7 @@
 ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
 ext3-objs += acl.o
 endif
+
+ifeq ($(CONFIG_EXT3_FS_SECURITY),y)
+ext3-objs += xattr_security.o
+endif
Index: linux-2.5/fs/ext3/xattr.c
diff -u linux-2.5/fs/ext3/xattr.c:1.1.1.4 linux-2.5/fs/ext3/xattr.c:1.3
--- linux-2.5/fs/ext3/xattr.c:1.1.1.4	Mon Apr 21 10:15:42 2003
+++ linux-2.5/fs/ext3/xattr.c	Mon Apr 21 11:03:31 2003
@@ -1142,22 +1142,33 @@
 				  &ext3_xattr_trusted_handler);
 	if (err)
 		goto out;
+#ifdef CONFIG_EXT3_FS_SECURITY
+	err = ext3_xattr_register(EXT3_XATTR_INDEX_SECURITY,
+				  &ext3_xattr_security_handler);
+	if (err)
+		goto out1;
+#endif
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	err = init_ext3_acl();
 	if (err)
-		goto out1;
+		goto out2;
 #endif
 	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
 	if (!ext3_xattr_cache) {
 		err = -ENOMEM;
-		goto out2;
+		goto out3;
 	}
 	return 0;
-out2:
+out3:
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	exit_ext3_acl();
+out2:
+#endif
+#ifdef CONFIG_EXT3_FS_SECURITY
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
+			      &ext3_xattr_security_handler);
 out1:
 #endif
 	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
@@ -1176,6 +1187,10 @@
 	ext3_xattr_cache = NULL;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	exit_ext3_acl();
+#endif
+#ifdef CONFIG_EXT3_FS_SECURITY
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
+			      &ext3_xattr_security_handler);
 #endif
 	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
 			      &ext3_xattr_trusted_handler);
Index: linux-2.5/fs/ext3/xattr.h
diff -u linux-2.5/fs/ext3/xattr.h:1.1.1.1 linux-2.5/fs/ext3/xattr.h:1.2
--- linux-2.5/fs/ext3/xattr.h:1.1.1.1	Wed Mar 12 10:55:32 2003
+++ linux-2.5/fs/ext3/xattr.h	Wed Mar 26 14:03:26 2003
@@ -21,6 +21,7 @@
 #define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
 #define EXT3_XATTR_INDEX_TRUSTED		4
+#define EXT3_XATTR_INDEX_SECURITY	        5
 
 struct ext3_xattr_header {
 	__u32	h_magic;	/* magic number for identification */
@@ -141,3 +142,4 @@
 
 extern struct ext3_xattr_handler ext3_xattr_user_handler;
 extern struct ext3_xattr_handler ext3_xattr_trusted_handler;
+extern struct ext3_xattr_handler ext3_xattr_security_handler;
Index: linux-2.5/fs/ext3/xattr_security.c
diff -u /dev/null linux-2.5/fs/ext3/xattr_security.c:1.2
--- /dev/null	Thu May  1 12:55:02 2003
+++ linux-2.5/fs/ext3/xattr_security.c	Thu Apr 24 14:46:07 2003
@@ -0,0 +1,55 @@
+/*
+ * linux/fs/ext3/xattr_security.c
+ * Handler for storing security labels as extended attributes.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include "xattr.h"
+
+#define XATTR_SECURITY_PREFIX "security."
+
+static size_t
+ext3_xattr_security_list(char *list, struct inode *inode,
+		    const char *name, int name_len)
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
+ext3_xattr_security_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_SECURITY, name,
+			      buffer, size);
+}
+
+static int
+ext3_xattr_security_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_SECURITY, name,
+			      value, size, flags);
+}
+
+struct ext3_xattr_handler ext3_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= ext3_xattr_security_list,
+	.get	= ext3_xattr_security_get,
+	.set	= ext3_xattr_security_set,
+};

 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


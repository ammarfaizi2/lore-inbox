Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTDWRkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbTDWRky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:40:54 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:5323 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264180AbTDWRkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:40:31 -0400
Subject: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 13:52:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.68 implements changes to the LSM xattr-related
hooks and adds xattr handlers for ext[23] to support the use of extended
attributes by security modules for storing file security labels, as
described in my April 8th RFC posting.  Please apply, or let me know if
any changes are needed.  Thanks.

 fs/Kconfig               |   24 +++++++++++++++++++++
 fs/ext2/Makefile         |    4 +++
 fs/ext2/xattr.c          |   21 ++++++++++++++++--
 fs/ext2/xattr.h          |    2 +
 fs/ext2/xattr_security.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext3/Makefile         |    4 +++
 fs/ext3/xattr.c          |   21 ++++++++++++++++--
 fs/ext3/xattr.h          |    2 +
 fs/ext3/xattr_security.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/xattr.c               |    7 +++---
 include/linux/security.h |   15 +++++++++++++
 security/dummy.c         |    6 +++++
 12 files changed, 200 insertions(+), 9 deletions(-)

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
Index: linux-2.5/fs/xattr.c
diff -u linux-2.5/fs/xattr.c:1.1.1.1 linux-2.5/fs/xattr.c:1.4
--- linux-2.5/fs/xattr.c:1.1.1.1	Wed Mar 12 10:55:12 2003
+++ linux-2.5/fs/xattr.c	Wed Mar 26 14:03:25 2003
@@ -79,15 +79,16 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
+		down(&d->d_inode->i_sem);
 		error = security_inode_setxattr(d, kname, kvalue, size, flags);
 		if (error)
 			goto out;
-		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
+		if (!error)
+			security_inode_post_setxattr(d, kname, kvalue, size, flags);
+out:
 		up(&d->d_inode->i_sem);
 	}
-
-out:
 	xattr_free(kvalue, size);
 	return error;
 }
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
diff -u /dev/null linux-2.5/fs/ext2/xattr_security.c:1.1
--- /dev/null	Mon Apr 21 11:26:50 2003
+++ linux-2.5/fs/ext2/xattr_security.c	Fri Apr 18 12:16:34 2003
@@ -0,0 +1,51 @@
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
+#define XATTR_NAME_SECURITY "system.security"
+
+static size_t
+ext2_xattr_security_list(char *list, struct inode *inode,
+			const char *name, int name_len)
+{
+	const int size = sizeof(XATTR_NAME_SECURITY);
+
+	if (list)
+		memcpy(list, XATTR_NAME_SECURITY, size);
+	return size;
+}
+
+static int
+ext2_xattr_security_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_SECURITY, name,
+			      buffer, size);
+}
+
+static int
+ext2_xattr_security_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY, name,
+			      value, size, flags);
+}
+
+struct ext2_xattr_handler ext2_xattr_security_handler = {
+	.prefix	= XATTR_NAME_SECURITY,
+	.list	= ext2_xattr_security_list,
+	.get	= ext2_xattr_security_get,
+	.set	= ext2_xattr_security_set,
+};
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
diff -u /dev/null linux-2.5/fs/ext3/xattr_security.c:1.1
--- /dev/null	Mon Apr 21 11:26:50 2003
+++ linux-2.5/fs/ext3/xattr_security.c	Wed Mar 26 14:03:26 2003
@@ -0,0 +1,52 @@
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
+#define XATTR_NAME_SECURITY "system.security"
+
+static size_t
+ext3_xattr_security_list(char *list, struct inode *inode,
+		    const char *name, int name_len)
+{
+	const int size = sizeof(XATTR_NAME_SECURITY);
+
+	if (list) 
+		memcpy(list, XATTR_NAME_SECURITY, size);
+	return size;
+}
+
+static int
+ext3_xattr_security_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_SECURITY, name,
+			      buffer, size);
+}
+
+static int
+ext3_xattr_security_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_SECURITY, name,
+			      value, size, flags);
+}
+
+struct ext3_xattr_handler ext3_xattr_security_handler = {
+	.prefix	= XATTR_NAME_SECURITY,
+	.list	= ext3_xattr_security_list,
+	.get	= ext3_xattr_security_get,
+	.set	= ext3_xattr_security_set,
+};
Index: linux-2.5/include/linux/security.h
diff -u linux-2.5/include/linux/security.h:1.1.1.2 linux-2.5/include/linux/security.h:1.16
--- linux-2.5/include/linux/security.h:1.1.1.2	Wed Mar 19 09:54:58 2003
+++ linux-2.5/include/linux/security.h	Fri Apr 18 11:17:19 2003
@@ -361,6 +361,9 @@
  * 	Check permission before setting the extended attributes
  * 	@value identified by @name for @dentry.
  * 	Return 0 if permission is granted.
+ * @inode_post_setxattr:
+ * 	Update inode security field after successful setxattr operation.
+ * 	@value identified by @name for @dentry.
  * @inode_getxattr:
  * 	Check permission before obtaining the extended attributes
  * 	identified by @name for @dentry.
@@ -1036,6 +1039,8 @@
         void (*inode_delete) (struct inode *inode);
 	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
 			       size_t size, int flags);
+	void (*inode_post_setxattr) (struct dentry *dentry, char *name, void *value,
+				     size_t size, int flags);
 	int (*inode_getxattr) (struct dentry *dentry, char *name);
 	int (*inode_listxattr) (struct dentry *dentry);
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
@@ -1464,6 +1472,12 @@
 	return security_ops->inode_setxattr (dentry, name, value, size, flags);
 }
 
+static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
+						void *value, size_t size, int flags)
+{
+	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
+}
+
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
 	return security_ops->inode_getxattr (dentry, name);
@@ -2063,6 +2087,10 @@
 	return 0;
 }
 
+static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
+						 void *value, size_t size, int flags)
+{ }
+
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
 	return 0;
Index: linux-2.5/security/dummy.c
diff -u linux-2.5/security/dummy.c:1.1.1.2 linux-2.5/security/dummy.c:1.14
--- linux-2.5/security/dummy.c:1.1.1.2	Wed Mar 19 09:59:17 2003
+++ linux-2.5/security/dummy.c	Fri Apr 18 11:17:20 2003
@@ -334,6 +334,11 @@
 	return 0;
 }
 
+static void dummy_inode_post_setxattr (struct dentry *dentry, char *name, void *value,
+				       size_t size, int flags)
+{
+}
+
 static int dummy_inode_getxattr (struct dentry *dentry, char *name)
 {
 	return 0;
@@ -803,6 +818,7 @@
 	set_to_dummy_if_null(ops, inode_getattr);
 	set_to_dummy_if_null(ops, inode_delete);
 	set_to_dummy_if_null(ops, inode_setxattr);
+	set_to_dummy_if_null(ops, inode_post_setxattr);
 	set_to_dummy_if_null(ops, inode_getxattr);
 	set_to_dummy_if_null(ops, inode_listxattr);
 	set_to_dummy_if_null(ops, inode_removexattr);

  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


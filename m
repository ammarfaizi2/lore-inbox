Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUIWEEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUIWEEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUIWEEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:04:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28358 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268253AbUIWD6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:58:43 -0400
Date: Wed, 22 Sep 2004 23:58:31 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] xattr consolidation v3 - devpts
In-Reply-To: <Xine.LNX.4.44.0409222349470.447@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409222351160.447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the devpts xattr handler code to the generic xattr API,
also adds a GPL notice, author and copyright details.


 fs/devpts/Makefile         |    1 
 fs/devpts/inode.c          |   34 ++++---
 fs/devpts/xattr.c          |  214 ---------------------------------------------
 fs/devpts/xattr.h          |   59 ------------
 fs/devpts/xattr_security.c |   29 +++---
 5 files changed, 39 insertions(+), 298 deletions(-)

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/devpts/inode.c linux-2.6.9-rc2-mm2.w/fs/devpts/inode.c
--- linux-2.6.9-rc2-mm2.p/fs/devpts/inode.c	2004-09-13 01:31:57.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/devpts/inode.c	2004-09-22 19:33:38.703409560 -0400
@@ -18,10 +18,28 @@
 #include <linux/mount.h>
 #include <linux/tty.h>
 #include <linux/devpts_fs.h>
-#include "xattr.h"
+#include <linux/xattr.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
+extern struct xattr_handler devpts_xattr_security_handler;
+
+static struct xattr_handler *devpts_xattr_handlers[] = {
+#ifdef CONFIG_DEVPTS_FS_SECURITY
+	&devpts_xattr_security_handler,
+#endif	
+	NULL
+};
+
+struct inode_operations devpts_file_inode_operations = {
+#ifdef CONFIG_DEVPTS_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= generic_listxattr,
+	.removexattr	= generic_removexattr,
+#endif
+};
+
 static struct vfsmount *devpts_mnt;
 static struct dentry *devpts_root;
 
@@ -84,6 +102,7 @@ devpts_fill_super(struct super_block *s,
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
+	s->s_xattr = devpts_xattr_handlers;
 
 	inode = new_inode(s);
 	if (!inode)
@@ -134,13 +153,6 @@ static struct dentry *get_node(int num)
 	return lookup_one_len(s, root, sprintf(s, "%d", num));
 }
 
-static struct inode_operations devpts_file_inode_operations = {
-	.setxattr	= devpts_setxattr,
-	.getxattr	= devpts_getxattr,
-	.listxattr	= devpts_listxattr,
-	.removexattr	= devpts_removexattr,
-};
-
 int devpts_pty_new(struct tty_struct *tty)
 {
 	int number = tty->index;
@@ -209,10 +221,7 @@ void devpts_pty_kill(int number)
 
 static int __init init_devpts_fs(void)
 {
-	int err = init_devpts_xattr();
-	if (err)
-		return err;
-	err = register_filesystem(&devpts_fs_type);
+	int err = register_filesystem(&devpts_fs_type);
 	if (!err) {
 		devpts_mnt = kern_mount(&devpts_fs_type);
 		if (IS_ERR(devpts_mnt))
@@ -225,7 +234,6 @@ static void __exit exit_devpts_fs(void)
 {
 	unregister_filesystem(&devpts_fs_type);
 	mntput(devpts_mnt);
-	exit_devpts_xattr();
 }
 
 module_init(init_devpts_fs)
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/devpts/Makefile linux-2.6.9-rc2-mm2.w/fs/devpts/Makefile
--- linux-2.6.9-rc2-mm2.p/fs/devpts/Makefile	2004-09-13 01:32:55.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/devpts/Makefile	2004-09-22 19:33:38.704409408 -0400
@@ -5,5 +5,4 @@
 obj-$(CONFIG_UNIX98_PTYS)		+= devpts.o
 
 devpts-$(CONFIG_UNIX98_PTYS)		:= inode.o
-devpts-$(CONFIG_DEVPTS_FS_XATTR)	+= xattr.o 
 devpts-$(CONFIG_DEVPTS_FS_SECURITY)	+= xattr_security.o
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/devpts/xattr.c linux-2.6.9-rc2-mm2.w/fs/devpts/xattr.c
--- linux-2.6.9-rc2-mm2.p/fs/devpts/xattr.c	2004-09-13 01:33:23.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/devpts/xattr.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,214 +0,0 @@
-/*
-  File: fs/devpts/xattr.c
- 
-  Derived from fs/ext3/xattr.c, changed in the following ways:
-      drop everything related to persistent storage of EAs
-      pass dentry rather than inode to internal methods
-      only presently define a handler for security modules
-*/
-
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <asm/semaphore.h>
-#include "xattr.h"
-
-static struct devpts_xattr_handler *devpts_xattr_handlers[DEVPTS_XATTR_INDEX_MAX];
-static rwlock_t devpts_handler_lock = RW_LOCK_UNLOCKED;
-
-int
-devpts_xattr_register(int name_index, struct devpts_xattr_handler *handler)
-{
-	int error = -EINVAL;
-
-	if (name_index > 0 && name_index <= DEVPTS_XATTR_INDEX_MAX) {
-		write_lock(&devpts_handler_lock);
-		if (!devpts_xattr_handlers[name_index-1]) {
-			devpts_xattr_handlers[name_index-1] = handler;
-			error = 0;
-		}
-		write_unlock(&devpts_handler_lock);
-	}
-	return error;
-}
-
-void
-devpts_xattr_unregister(int name_index, struct devpts_xattr_handler *handler)
-{
-	if (name_index > 0 || name_index <= DEVPTS_XATTR_INDEX_MAX) {
-		write_lock(&devpts_handler_lock);
-		devpts_xattr_handlers[name_index-1] = NULL;
-		write_unlock(&devpts_handler_lock);
-	}
-}
-
-static inline const char *
-strcmp_prefix(const char *a, const char *a_prefix)
-{
-	while (*a_prefix && *a == *a_prefix) {
-		a++;
-		a_prefix++;
-	}
-	return *a_prefix ? NULL : a;
-}
-
-/*
- * Decode the extended attribute name, and translate it into
- * the name_index and name suffix.
- */
-static inline struct devpts_xattr_handler *
-devpts_xattr_resolve_name(const char **name)
-{
-	struct devpts_xattr_handler *handler = NULL;
-	int i;
-
-	if (!*name)
-		return NULL;
-	read_lock(&devpts_handler_lock);
-	for (i=0; i<DEVPTS_XATTR_INDEX_MAX; i++) {
-		if (devpts_xattr_handlers[i]) {
-			const char *n = strcmp_prefix(*name,
-				devpts_xattr_handlers[i]->prefix);
-			if (n) {
-				handler = devpts_xattr_handlers[i];
-				*name = n;
-				break;
-			}
-		}
-	}
-	read_unlock(&devpts_handler_lock);
-	return handler;
-}
-
-static inline struct devpts_xattr_handler *
-devpts_xattr_handler(int name_index)
-{
-	struct devpts_xattr_handler *handler = NULL;
-	if (name_index > 0 && name_index <= DEVPTS_XATTR_INDEX_MAX) {
-		read_lock(&devpts_handler_lock);
-		handler = devpts_xattr_handlers[name_index-1];
-		read_unlock(&devpts_handler_lock);
-	}
-	return handler;
-}
-
-/*
- * Inode operation getxattr()
- *
- * dentry->d_inode->i_sem down
- */
-ssize_t
-devpts_getxattr(struct dentry *dentry, const char *name,
-	      void *buffer, size_t size)
-{
-	struct devpts_xattr_handler *handler;
-
-	handler = devpts_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->get(dentry, name, buffer, size);
-}
-
-/*
- * Inode operation listxattr()
- *
- * dentry->d_inode->i_sem down
- */
-ssize_t
-devpts_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
-{
-	struct devpts_xattr_handler *handler = NULL;
-	int i, error = 0;
-	unsigned int size = 0;
-	char *buf;
-
-	read_lock(&devpts_handler_lock);
-
-	for (i=0; i<DEVPTS_XATTR_INDEX_MAX; i++) {
-		handler = devpts_xattr_handlers[i];
-		if (handler)
-			size += handler->list(dentry, NULL);
-	}
-
-	if (!buffer) {
-		error = size;
-		goto out;
-	} else {
-		error = -ERANGE;
-		if (size > buffer_size)
-			goto out;
-	}
-
-	buf = buffer;
-	for (i=0; i<DEVPTS_XATTR_INDEX_MAX; i++) {
-		handler = devpts_xattr_handlers[i];
-		if (handler)
-			buf += handler->list(dentry, buf);
-	}
-	error = size;
-
-out:
-	read_unlock(&devpts_handler_lock);
-	return size;
-}
-
-/*
- * Inode operation setxattr()
- *
- * dentry->d_inode->i_sem down
- */
-int
-devpts_setxattr(struct dentry *dentry, const char *name,
-	      const void *value, size_t size, int flags)
-{
-	struct devpts_xattr_handler *handler;
-
-	if (size == 0)
-		value = "";  /* empty EA, do not remove */
-	handler = devpts_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->set(dentry, name, value, size, flags);
-}
-
-/*
- * Inode operation removexattr()
- *
- * dentry->d_inode->i_sem down
- */
-int
-devpts_removexattr(struct dentry *dentry, const char *name)
-{
-	struct devpts_xattr_handler *handler;
-
-	handler = devpts_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->set(dentry, name, NULL, 0, XATTR_REPLACE);
-}
-
-int __init
-init_devpts_xattr(void)
-{
-#ifdef CONFIG_DEVPTS_FS_SECURITY	
-	int	err;
-
-	err = devpts_xattr_register(DEVPTS_XATTR_INDEX_SECURITY,
-				    &devpts_xattr_security_handler);
-	if (err)
-		return err;
-#endif
-
-	return 0;
-}
-
-void
-exit_devpts_xattr(void)
-{
-#ifdef CONFIG_DEVPTS_FS_SECURITY	
-	devpts_xattr_unregister(DEVPTS_XATTR_INDEX_SECURITY,
-				&devpts_xattr_security_handler);
-#endif
-
-}
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/devpts/xattr.h linux-2.6.9-rc2-mm2.w/fs/devpts/xattr.h
--- linux-2.6.9-rc2-mm2.p/fs/devpts/xattr.h	2004-09-13 01:32:48.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/devpts/xattr.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,59 +0,0 @@
-/*
-  File: fs/devpts/xattr.h
- 
-  Derived from fs/ext3/xattr.h, changed in the following ways:
-      drop everything related to persistent storage of EAs
-      pass dentry rather than inode to internal methods
-      only presently define a handler for security modules
-*/
-
-#include <linux/config.h>
-#include <linux/xattr.h>
-
-/* Name indexes */
-#define DEVPTS_XATTR_INDEX_MAX			10
-#define DEVPTS_XATTR_INDEX_SECURITY	        1
-
-# ifdef CONFIG_DEVPTS_FS_XATTR
-
-struct devpts_xattr_handler {
-	char *prefix;
-	size_t (*list)(struct dentry *dentry, char *buffer);
-	int (*get)(struct dentry *dentry, const char *name, void *buffer,
-		   size_t size);
-	int (*set)(struct dentry *dentry, const char *name, const void *buffer,
-		   size_t size, int flags);
-};
-
-extern int devpts_xattr_register(int, struct devpts_xattr_handler *);
-extern void devpts_xattr_unregister(int, struct devpts_xattr_handler *);
-
-extern int devpts_setxattr(struct dentry *, const char *, const void *, size_t, int);
-extern ssize_t devpts_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t devpts_listxattr(struct dentry *, char *, size_t);
-extern int devpts_removexattr(struct dentry *, const char *);
-
-extern int init_devpts_xattr(void);
-extern void exit_devpts_xattr(void);
-
-# else  /* CONFIG_DEVPTS_FS_XATTR */
-#  define devpts_setxattr		NULL
-#  define devpts_getxattr		NULL
-#  define devpts_listxattr	NULL
-#  define devpts_removexattr	NULL
-
-static inline int
-init_devpts_xattr(void)
-{
-	return 0;
-}
-
-static inline void
-exit_devpts_xattr(void)
-{
-}
-
-# endif  /* CONFIG_DEVPTS_FS_XATTR */
-
-extern struct devpts_xattr_handler devpts_xattr_security_handler;
-
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/devpts/xattr_security.c linux-2.6.9-rc2-mm2.w/fs/devpts/xattr_security.c
--- linux-2.6.9-rc2-mm2.p/fs/devpts/xattr_security.c	2004-09-13 01:32:27.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/devpts/xattr_security.c	2004-09-22 19:33:38.709408648 -0400
@@ -1,38 +1,45 @@
 /*
- * File: fs/devpts/xattr_security.c
+ * Security xattr support for devpts.
+ *
+ * Author: Stephen Smalley <sds@epoch.ncsc.mil>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
  */
-
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/security.h>
-#include "xattr.h"
+#include <linux/xattr.h>
 
 static size_t
-devpts_xattr_security_list(struct dentry *dentry, char *buffer)
+devpts_xattr_security_list(struct inode *inode, char *list, size_t list_len,
+			   const char *name, size_t name_len)
 {
-	return security_inode_listsecurity(dentry, buffer);
+	return security_inode_listsecurity(inode, list, list_len);
 }
 
 static int
-devpts_xattr_security_get(struct dentry *dentry, const char *name,
+devpts_xattr_security_get(struct inode *inode, const char *name,
 			  void *buffer, size_t size)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return security_inode_getsecurity(dentry, name, buffer, size);
+	return security_inode_getsecurity(inode, name, buffer, size);
 }
 
 static int
-devpts_xattr_security_set(struct dentry *dentry, const char *name,
+devpts_xattr_security_set(struct inode *inode, const char *name,
 			  const void *value, size_t size, int flags)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return security_inode_setsecurity(dentry, name, value, size, flags);
+	return security_inode_setsecurity(inode, name, value, size, flags);
 }
 
-struct devpts_xattr_handler devpts_xattr_security_handler = {
+struct xattr_handler devpts_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= devpts_xattr_security_list,
 	.get	= devpts_xattr_security_get,



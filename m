Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUHWS3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUHWS3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUHWS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:26:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16878 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266486AbUHWSUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:20:00 -0400
Date: Mon, 23 Aug 2004 14:19:54 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [5/7] xattr consolidation - devpts
In-Reply-To: <Xine.LNX.4.44.0408231417380.13728-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408231419010.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the devpts xattr handler code to the new libs API, also
adds a GPL notice, author and copyright details.


 fs/devpts/xattr.c          |  171 +++++++++------------------------------------
 fs/devpts/xattr.h          |   16 ----
 fs/devpts/xattr_security.c |   34 +++++---
 3 files changed, 58 insertions(+), 163 deletions(-)

 Signed-off-by: James Morris <jmorris@redhat.com>
 Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
    
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/devpts/xattr.c linux-2.6.8.1-mm2.w/fs/devpts/xattr.c
--- linux-2.6.8.1-mm2.p/fs/devpts/xattr.c	2004-08-23 01:23:25.470272608 -0400
+++ linux-2.6.8.1-mm2.w/fs/devpts/xattr.c	2004-08-23 01:25:08.832559152 -0400
@@ -1,97 +1,24 @@
 /*
-  File: fs/devpts/xattr.c
- 
-  Derived from fs/ext3/xattr.c, changed in the following ways:
-      drop everything related to persistent storage of EAs
-      pass dentry rather than inode to internal methods
-      only presently define a handler for security modules
-*/
-
+ * Pseudo xattr support for devpts.
+ *
+ * Originally derived from fs/ext3/xattr.c, changed in the following ways:
+ *   drop everything related to persistent storage of EAs
+ *   only presently define a handler for security modules
+ *
+ * Author: Stephen Smalley <sds@epoch.ncsc.mil>
+ * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ */
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <asm/semaphore.h>
 #include "xattr.h"
 
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
+static struct simple_xattr_handler *devpts_xattr_handlers[SIMPLE_XATTR_MAX];
+static struct simple_xattr_info devpts_xattr_info;
 
 /*
  * Inode operation getxattr()
@@ -102,12 +29,13 @@ ssize_t
 devpts_getxattr(struct dentry *dentry, const char *name,
 	      void *buffer, size_t size)
 {
-	struct devpts_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
 
-	handler = devpts_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&devpts_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->get(dentry, name, buffer, size);
+	return handler->get(inode, name, buffer, size);
 }
 
 /*
@@ -116,41 +44,9 @@ devpts_getxattr(struct dentry *dentry, c
  * dentry->d_inode->i_sem down
  */
 ssize_t
-devpts_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
+devpts_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
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
+	return simple_xattr_list(&devpts_xattr_info, dentry, buffer, size);
 }
 
 /*
@@ -162,14 +58,15 @@ int
 devpts_setxattr(struct dentry *dentry, const char *name,
 	      const void *value, size_t size, int flags)
 {
-	struct devpts_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
 
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	handler = devpts_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&devpts_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(dentry, name, value, size, flags);
+	return handler->set(inode, name, value, size, flags);
 }
 
 /*
@@ -180,12 +77,13 @@ devpts_setxattr(struct dentry *dentry, c
 int
 devpts_removexattr(struct dentry *dentry, const char *name)
 {
-	struct devpts_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
 
-	handler = devpts_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&devpts_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(dentry, name, NULL, 0, XATTR_REPLACE);
+	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
 }
 
 int __init
@@ -193,8 +91,12 @@ init_devpts_xattr(void)
 {
 #ifdef CONFIG_DEVPTS_FS_SECURITY	
 	int	err;
+	
+	devpts_xattr_info.lock = RW_LOCK_UNLOCKED;
+	devpts_xattr_info.handlers = devpts_xattr_handlers;
 
-	err = devpts_xattr_register(DEVPTS_XATTR_INDEX_SECURITY,
+	err = simple_xattr_register(&devpts_xattr_info,
+				    DEVPTS_XATTR_INDEX_SECURITY,
 				    &devpts_xattr_security_handler);
 	if (err)
 		return err;
@@ -207,7 +109,8 @@ void
 exit_devpts_xattr(void)
 {
 #ifdef CONFIG_DEVPTS_FS_SECURITY	
-	devpts_xattr_unregister(DEVPTS_XATTR_INDEX_SECURITY,
+	simple_xattr_unregister(&devpts_xattr_info,
+				DEVPTS_XATTR_INDEX_SECURITY,
 				&devpts_xattr_security_handler);
 #endif
 
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/devpts/xattr.h linux-2.6.8.1-mm2.w/fs/devpts/xattr.h
--- linux-2.6.8.1-mm2.p/fs/devpts/xattr.h	2004-08-23 01:23:25.471272456 -0400
+++ linux-2.6.8.1-mm2.w/fs/devpts/xattr.h	2004-08-23 01:19:12.341753992 -0400
@@ -3,7 +3,6 @@
  
   Derived from fs/ext3/xattr.h, changed in the following ways:
       drop everything related to persistent storage of EAs
-      pass dentry rather than inode to internal methods
       only presently define a handler for security modules
 */
 
@@ -11,23 +10,10 @@
 #include <linux/xattr.h>
 
 /* Name indexes */
-#define DEVPTS_XATTR_INDEX_MAX			10
 #define DEVPTS_XATTR_INDEX_SECURITY	        1
 
 # ifdef CONFIG_DEVPTS_FS_XATTR
 
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
 extern int devpts_setxattr(struct dentry *, const char *, const void *, size_t, int);
 extern ssize_t devpts_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t devpts_listxattr(struct dentry *, char *, size_t);
@@ -55,5 +41,5 @@ exit_devpts_xattr(void)
 
 # endif  /* CONFIG_DEVPTS_FS_XATTR */
 
-extern struct devpts_xattr_handler devpts_xattr_security_handler;
+extern struct simple_xattr_handler devpts_xattr_security_handler;
 
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/devpts/xattr_security.c linux-2.6.8.1-mm2.w/fs/devpts/xattr_security.c
--- linux-2.6.8.1-mm2.p/fs/devpts/xattr_security.c	2004-08-23 01:23:25.472272304 -0400
+++ linux-2.6.8.1-mm2.w/fs/devpts/xattr_security.c	2004-08-23 01:25:07.312790192 -0400
@@ -1,38 +1,44 @@
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
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include "xattr.h"
 
-static size_t
-devpts_xattr_security_list(struct dentry *dentry, char *buffer)
+static size_t devpts_xattr_security_list(struct inode *inode, char *list,
+					 const char *name, int name_len)
+                       
 {
-	return security_inode_listsecurity(dentry, buffer);
+	return security_inode_listsecurity(inode, list);
 }
 
-static int
-devpts_xattr_security_get(struct dentry *dentry, const char *name,
-			  void *buffer, size_t size)
+static int devpts_xattr_security_get(struct inode *inode, const char *name,
+				     void *buffer, size_t size)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return security_inode_getsecurity(dentry, name, buffer, size);
+	return security_inode_getsecurity(inode, name, buffer, size);
 }
 
-static int
-devpts_xattr_security_set(struct dentry *dentry, const char *name,
-			  const void *value, size_t size, int flags)
+static int devpts_xattr_security_set(struct inode *inode, const char *name,
+				     const void *value, size_t size, int flags)
 {
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return security_inode_setsecurity(dentry, name, value, size, flags);
+	return security_inode_setsecurity(inode, name, value, size, flags);
 }
 
-struct devpts_xattr_handler devpts_xattr_security_handler = {
+struct simple_xattr_handler devpts_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= devpts_xattr_security_list,
 	.get	= devpts_xattr_security_get,


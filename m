Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUIWDyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUIWDyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUIWDyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:54:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19396 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268240AbUIWDyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:54:31 -0400
Date: Wed, 22 Sep 2004 23:54:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] xattr consolidation v3 - generic xattr API
In-Reply-To: <Xine.LNX.4.44.0409222342090.447@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409222347120.447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch consolidates common xattr handling logic into the core fs code,
with modifications suggested by Christoph Hellwig (hang off superblock,
remove locking, use generic code as methods), for use by ext2, ext3 and
devpts, as well as upcoming tmpfs xattr code.


 fs/xattr.c            |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    1 
 include/linux/xattr.h |   16 ++++++
 3 files changed, 146 insertions(+)

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/xattr.c linux-2.6.9-rc2-mm2.w/fs/xattr.c
--- linux-2.6.9-rc2-mm2.p/fs/xattr.c	2004-09-22 19:05:35.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/xattr.c	2004-09-22 19:24:34.124198184 -0400
@@ -5,6 +5,7 @@
 
   Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
   Copyright (C) 2001 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+  Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  */
 #include <linux/fs.h>
 #include <linux/slab.h>
@@ -14,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 
 /*
@@ -348,3 +350,130 @@ sys_fremovexattr(int fd, char __user *na
 	fput(f);
 	return error;
 }
+
+
+static const char *strcmp_prefix(const char *a, const char *a_prefix)
+{
+	while (*a_prefix && *a == *a_prefix) {
+		a++;
+		a_prefix++;
+	}
+	return *a_prefix ? NULL : a;
+}
+
+/*
+ * In order to implement different sets of xattr operations for each xattr
+ * prefix with the generic xattr API, a filesystem should create a
+ * null-terminated array of struct xattr_handler (one for each prefix) and
+ * hang a pointer to it off of the s_xattr field of the superblock.
+ *
+ * The generic_fooxattr() functions will use this list to dispatch xattr
+ * operations to the correct xattr_handler.
+ */
+#define for_each_xattr_handler(handlers, handler)		\
+		for ((handler) = *(handlers)++;			\
+			(handler) != NULL;			\
+			(handler) = *(handlers)++)	
+
+/*
+ * Find the xattr_handler with the matching prefix.
+ */
+static struct xattr_handler *
+xattr_resolve_name(struct xattr_handler **handlers, const char **name)
+{
+	struct xattr_handler *handler;
+
+	if (!*name)
+		return NULL;
+
+	for_each_xattr_handler(handlers, handler) {
+		const char *n = strcmp_prefix(*name, handler->prefix);
+		if (n) {
+			*name = n;
+			break;
+		}
+	}
+	return handler;
+}
+
+/*
+ * Find the handler for the prefix and dispatch its get() operation.
+ */
+ssize_t
+generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	struct xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = xattr_resolve_name(inode->i_sb->s_xattr, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->get(inode, name, buffer, size);
+}
+
+/*
+ * Combine the results of the list() operation from every xattr_handler in the
+ * list.
+ */
+ssize_t
+generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct xattr_handler *handler, **handlers = inode->i_sb->s_xattr;
+	unsigned int size = 0;
+
+	if (!buffer) {
+		for_each_xattr_handler(handlers, handler)
+			size += handler->list(inode, NULL, 0, NULL, 0);
+	} else {
+		char *buf = buffer;
+
+		for_each_xattr_handler(handlers, handler) {
+			size = handler->list(inode, buf, buffer_size, NULL, 0);
+			if (size > buffer_size)
+				return -ERANGE;
+			buf += size;
+			buffer_size -= size;
+		}
+		size = buf - buffer;
+	}
+	return size;
+}
+
+/*
+ * Find the handler for the prefix and dispatch its set() operation.
+ */
+int
+generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags)
+{
+	struct xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+	
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+	handler = xattr_resolve_name(inode->i_sb->s_xattr, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, value, size, flags);
+}
+
+/*
+ * Find the handler for the prefix and dispatch its set() operation to remove
+ * any associated extended attribute.
+ */
+int
+generic_removexattr(struct dentry *dentry, const char *name)
+{
+	struct xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = xattr_resolve_name(inode->i_sb->s_xattr, &name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+}
+
+EXPORT_SYMBOL(generic_getxattr);
+EXPORT_SYMBOL(generic_listxattr);
+EXPORT_SYMBOL(generic_setxattr);
+EXPORT_SYMBOL(generic_removexattr);
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/include/linux/fs.h linux-2.6.9-rc2-mm2.w/include/linux/fs.h
--- linux-2.6.9-rc2-mm2.p/include/linux/fs.h	2004-09-22 19:05:35.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/include/linux/fs.h	2004-09-22 19:22:07.509487008 -0400
@@ -785,6 +785,7 @@ struct super_block {
 	int			s_need_sync_fs;
 	atomic_t		s_active;
 	void                    *s_security;
+	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_inodes;	/* all inodes */
 	struct list_head	s_dirty;	/* dirty inodes */
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/include/linux/xattr.h linux-2.6.9-rc2-mm2.w/include/linux/xattr.h
--- linux-2.6.9-rc2-mm2.p/include/linux/xattr.h	2004-09-13 01:32:55.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/include/linux/xattr.h	2004-09-22 19:22:07.510486856 -0400
@@ -5,6 +5,7 @@
 
   Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
   Copyright (c) 2001-2002 Silicon Graphics, Inc.  All Rights Reserved.
+  Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
 */
 #ifndef _LINUX_XATTR_H
 #define _LINUX_XATTR_H
@@ -14,4 +15,19 @@
 
 #define XATTR_SECURITY_PREFIX	"security."
 
+struct xattr_handler {
+	char *prefix;
+	size_t (*list)(struct inode *inode, char *list, size_t list_size,
+		       const char *name, size_t name_len);
+	int (*get)(struct inode *inode, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct inode *inode, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size);
+ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
+int generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
+int generic_removexattr(struct dentry *dentry, const char *name);
+
 #endif	/* _LINUX_XATTR_H */



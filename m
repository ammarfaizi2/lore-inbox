Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269151AbUIRHXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbUIRHXX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUIRHXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:23:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59576 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269149AbUIRHU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:20:56 -0400
Date: Sat, 18 Sep 2004 03:20:37 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] xattr consolidation v2 - generic xattr API
In-Reply-To: <Xine.LNX.4.44.0409180252090.10905@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409180305300.10905-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch consolidates common xattr handling logic into the core fs code,
with modifications suggested by Christoph Hellwig (hang off superblock,
remove locking, use generic code as methods), for use by ext2, ext3 and
devpts, as well as upcoming tmpfs xattr code.


 fs/xattr.c            |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    |    1 
 include/linux/xattr.h |   16 ++++++++
 3 files changed, 115 insertions(+)


Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/xattr.c linux-2.6.9-rc2.w/fs/xattr.c
--- linux-2.6.9-rc2.p/fs/xattr.c	2004-09-13 01:32:26.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/xattr.c	2004-09-18 01:26:57.271414448 -0400
@@ -5,6 +5,7 @@
 
   Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
   Copyright (C) 2001 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+  Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  */
 #include <linux/fs.h>
 #include <linux/slab.h>
@@ -13,6 +14,7 @@
 #include <linux/xattr.h>
 #include <linux/namei.h>
 #include <linux/security.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 
 /*
@@ -347,3 +349,99 @@ sys_fremovexattr(int fd, char __user *na
 	fput(f);
 	return error;
 }
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
+#define for_each_xattr_handler(handlers, handler)		\
+		for ((handler) = *(handlers)++;			\
+			(handler) != NULL;			\
+			(handler) = *(handlers)++)	
+			
+static struct xattr_handler *xattr_resolve_name(struct xattr_handler **handlers, const char **name)
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
+ssize_t generic_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size)
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
+ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct xattr_handler *handler, **handlers = inode->i_sb->s_xattr;
+	unsigned int size = 0;
+	char *buf;
+
+	for_each_xattr_handler(handlers, handler)
+		size += handler->list(inode, NULL, NULL, 0);
+
+	if (!buffer)
+		return size;
+		
+	if (size > buffer_size)
+		return -ERANGE;
+
+	buf = buffer;
+	handlers = inode->i_sb->s_xattr;
+	
+	for_each_xattr_handler(handlers, handler)
+		buf += handler->list(inode, buf, NULL, 0);
+
+	return size;
+}
+
+int generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags)
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
+int generic_removexattr(struct dentry *dentry, const char *name)
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
diff -purN -X dontdiff linux-2.6.9-rc2.p/include/linux/fs.h linux-2.6.9-rc2.w/include/linux/fs.h
--- linux-2.6.9-rc2.p/include/linux/fs.h	2004-09-13 01:31:58.000000000 -0400
+++ linux-2.6.9-rc2.w/include/linux/fs.h	2004-09-18 01:26:57.273414144 -0400
@@ -758,6 +758,7 @@ struct super_block {
 	int			s_need_sync_fs;
 	atomic_t		s_active;
 	void                    *s_security;
+	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
diff -purN -X dontdiff linux-2.6.9-rc2.p/include/linux/xattr.h linux-2.6.9-rc2.w/include/linux/xattr.h
--- linux-2.6.9-rc2.p/include/linux/xattr.h	2004-09-13 01:32:55.000000000 -0400
+++ linux-2.6.9-rc2.w/include/linux/xattr.h	2004-09-18 01:26:57.274413992 -0400
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
+	size_t (*list)(struct inode *inode, char *list, const char *name,
+		       int name_len);
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



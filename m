Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVBBQ3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVBBQ3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVBBQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:27:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:12205 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262390AbVBBQSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:18:24 -0500
Message-Id: <20050202161845.866892000@blunzn.suse.de>
References: <20050202161340.660712000@blunzn.suse.de>
Date: Wed, 26 Aug 1931 02:53:25 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Chris Mason <mason@suse.de>
Subject: [RFC][PATCH 1/3] Generic infrastructure for acls
Content-Disposition: inline; filename=generic-acl.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some infrastructure for access control lists on in-memory
filesystems such as tmpfs and devpts. We can probably also use
this code from ext2 and ext3, but this hasn't been started, yet.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc2-mm2/fs/Kconfig
===================================================================
--- linux-2.6.11-rc2-mm2.orig/fs/Kconfig
+++ linux-2.6.11-rc2-mm2/fs/Kconfig
@@ -1809,6 +1809,10 @@ config AFS_FSCACHE
 config RXRPC
 	tristate
 
+config GENERIC_ACL
+	bool
+	select FS_POSIX_ACL
+
 endmenu
 
 menu "Partition Types"
Index: linux-2.6.11-rc2-mm2/fs/Makefile
===================================================================
--- linux-2.6.11-rc2-mm2.orig/fs/Makefile
+++ linux-2.6.11-rc2-mm2/fs/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
+obj-$(CONFIG_GENERIC_ACL)	+= generic_acl.o
 obj-$(CONFIG_NFS_ACL_SUPPORT)	+= nfsacl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
Index: linux-2.6.11-rc2-mm2/include/linux/generic_acl.h
===================================================================
--- /dev/null
+++ linux-2.6.11-rc2-mm2/include/linux/generic_acl.h
@@ -0,0 +1,30 @@
+/*
+ * fs/generic_acl.c
+ *
+ * (C) 2005 Andreas Gruenbacher <agruen@suse.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#ifndef GENERIC_ACL_H
+#define GENERIC_ACL_H
+
+#include <linux/posix_acl.h>
+#include <linux/xattr_acl.h>
+
+struct generic_acl_operations {
+	struct posix_acl *(*getacl)(struct inode *, int);
+	void (*setacl)(struct inode *, int, struct posix_acl *);
+};
+
+size_t generic_acl_list(struct inode *, struct generic_acl_operations *, int,
+			char *, size_t);
+int generic_acl_get(struct inode *, struct generic_acl_operations *, int,
+		    void *, size_t);
+int generic_acl_set(struct inode *, struct generic_acl_operations *, int,
+		    const void *, size_t);
+int generic_acl_init(struct inode *, struct inode *,
+		     struct generic_acl_operations *);
+int generic_acl_chmod(struct inode *, struct generic_acl_operations *);
+
+#endif
Index: linux-2.6.11-rc2-mm2/fs/generic_acl.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc2-mm2/fs/generic_acl.c
@@ -0,0 +1,172 @@
+/*
+ * fs/generic_acl.c
+ *
+ * (C) 2005 Andreas Gruenbacher <agruen@suse.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/generic_acl.h>
+
+size_t
+generic_acl_list(struct inode *inode, struct generic_acl_operations *ops,
+		 int type, char *list, size_t list_size)
+{
+	struct posix_acl *acl;
+	const char *name;
+	size_t size;
+	
+	acl = ops->getacl(inode, type);
+	if (!acl)
+		return 0;
+	posix_acl_release(acl);
+
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			name = XATTR_NAME_ACL_ACCESS;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			name = XATTR_NAME_ACL_DEFAULT;
+			break;
+			
+		default:
+			return 0;
+	}
+	size = strlen(name) + 1;
+	if (list && size <= list_size)
+		memcpy(list, name, size);
+	return size;
+}
+
+int
+generic_acl_get(struct inode *inode, struct generic_acl_operations *ops,
+		int type, void *buffer, size_t size)
+{
+	struct posix_acl *acl;
+	int error;
+
+	acl = ops->getacl(inode, type);
+	if (!acl)
+		return -ENODATA;
+	error = posix_acl_to_xattr(acl, buffer, size);
+	posix_acl_release(acl);
+
+	return error;
+}
+
+int
+generic_acl_set(struct inode *inode, struct generic_acl_operations *ops,
+		int type, const void *value, size_t size)
+{
+	struct posix_acl *acl = NULL;
+	int error;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		return -EPERM;
+	if (value) {
+		acl = posix_acl_from_xattr(value, size);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+	}
+	if (acl) {
+		mode_t mode;
+
+		error = posix_acl_valid(acl);
+		if (error)
+			goto failed;
+		switch(type) {
+			case ACL_TYPE_ACCESS:
+				mode = inode->i_mode;
+				error = posix_acl_equiv_mode(acl, &mode);
+				if (error < 0)
+					goto failed;
+				inode->i_mode = mode;
+				if (error == 0) {
+					posix_acl_release(acl);
+					acl = NULL;
+				}
+				break;
+
+			case ACL_TYPE_DEFAULT:
+				if (!S_ISDIR(inode->i_mode)) {
+					error = -EINVAL;
+					goto failed;
+				}
+				break;
+		}
+	}
+	ops->setacl(inode, type, acl);
+	error = 0;
+failed:
+	posix_acl_release(acl);
+	return error;
+}
+
+int
+generic_acl_init(struct inode *inode, struct inode *dir,
+		 struct generic_acl_operations *ops)
+{
+	struct posix_acl *acl = NULL;
+	mode_t mode = inode->i_mode;
+	int error;
+
+	inode->i_mode = mode & ~current->fs->umask;
+	if (!S_ISLNK(inode->i_mode))
+		acl = ops->getacl(dir, ACL_TYPE_DEFAULT);
+	if (acl) {
+		struct posix_acl *clone;
+		
+		if (S_ISDIR(inode->i_mode)) {
+			clone = posix_acl_clone(acl, GFP_KERNEL);
+			error = -ENOMEM;
+			if (!clone)
+				goto cleanup;
+			ops->setacl(inode, ACL_TYPE_DEFAULT, clone);
+			posix_acl_release(clone);
+		}
+		clone = posix_acl_clone(acl, GFP_KERNEL);
+		error = -ENOMEM;
+		if (!clone)
+			goto cleanup;
+		error = posix_acl_create_masq(clone, &mode);
+		if (error >= 0) {
+			inode->i_mode = mode;
+			if (error > 0) {
+				ops->setacl(inode, ACL_TYPE_ACCESS, clone);
+			}
+		}
+		posix_acl_release(clone);
+	}
+	error = 0;
+
+cleanup:
+	posix_acl_release(acl);
+	return error;
+}
+
+int
+generic_acl_chmod(struct inode *inode, struct generic_acl_operations *ops)
+{
+	struct posix_acl *acl, *clone;
+	int error = 0;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+	acl = ops->getacl(inode, ACL_TYPE_ACCESS);
+	if (acl) {
+		clone = posix_acl_clone(acl, GFP_KERNEL);
+		posix_acl_release(acl);
+		if (!clone)
+			return -ENOMEM;
+		error = posix_acl_chmod_masq(clone, inode->i_mode);
+		if (!error)
+			ops->setacl(inode, ACL_TYPE_ACCESS, clone);
+		posix_acl_release(clone);
+	}
+	return error;
+}

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH


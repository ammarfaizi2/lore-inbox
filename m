Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWIAVcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWIAVcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWIAVcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:32:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:28808 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750913AbWIAVcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:32:45 -0400
Message-Id: <20060901221457.803728153@winden.suse.de>
References: <20060901221421.968954146@winden.suse.de>
User-Agent: quilt/0.44-16.4
Date: Sat, 02 Sep 2006 00:14:22 +0200
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@namei.org>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Generic infrastructure for acls
Content-Disposition: inline; filename=generic-acl.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some infrastructure for access control lists on in-memory
filesystems such as tmpfs.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

---
 fs/Kconfig                  |    4 +
 fs/Makefile                 |    1 
 fs/generic_acl.c            |  172 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/generic_acl.h |   30 +++++++
 4 files changed, 207 insertions(+)

Index: linux-2.6.18-rc5/fs/Kconfig
===================================================================
--- linux-2.6.18-rc5.orig/fs/Kconfig
+++ linux-2.6.18-rc5/fs/Kconfig
@@ -1921,6 +1921,10 @@ config 9P_FS
 
 	  If unsure, say N.
 
+config GENERIC_ACL
+	bool
+	select FS_POSIX_ACL
+
 endmenu
 
 menu "Partition Types"
Index: linux-2.6.18-rc5/fs/Makefile
===================================================================
--- linux-2.6.18-rc5.orig/fs/Makefile
+++ linux-2.6.18-rc5/fs/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
+obj-$(CONFIG_GENERIC_ACL)	+= generic_acl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
Index: linux-2.6.18-rc5/include/linux/generic_acl.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc5/include/linux/generic_acl.h
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
+#include <linux/posix_acl_xattr.h>
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
Index: linux-2.6.18-rc5/fs/generic_acl.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc5/fs/generic_acl.c
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
+			name = POSIX_ACL_XATTR_ACCESS;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			name = POSIX_ACL_XATTR_DEFAULT;
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
SUSE Labs, SUSE LINUX Products GmbH / Novell Inc.

-- 
VGER BF report: H 0

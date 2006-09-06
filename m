Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWIFQfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWIFQfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWIFQfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:35:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:55697 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751581AbWIFQfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:35:50 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Generic infrastructure for acls
Date: Wed, 6 Sep 2006 18:40:12 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20060901221421.968954146@winden.suse.de> <20060901221457.803728153@winden.suse.de> <20060901144423.aa306d36.akpm@osdl.org>
In-Reply-To: <20060901144423.aa306d36.akpm@osdl.org>
MIME-Version: 1.0
X-Length: 9032
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_snv/EGFPGXxxtKz"
Message-Id: <200609061840.12707.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_snv/EGFPGXxxtKz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, 01 September 2006 23:44, Andrew Morton wrote:
> That's a clumsy-looking interface.

I have added a little documentation now. This will hopefully suffice to 
clarify why the interface is as clumsy-looking as it is ;)

Thanks,
Andreas

--Boundary-00=_snv/EGFPGXxxtKz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="generic-acl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="generic-acl.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Generic infrastructure for acls

Add some infrastructure for access control lists on in-memory
filesystems such as tmpfs.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

---
 fs/Kconfig                  |    4 +
 fs/Makefile                 |    1 
 fs/generic_acl.c            |  172 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/generic_acl.h |   30 +++++++
 4 files changed, 207 insertions(+)

Index: linux-2.6.18-rc6/fs/Kconfig
===================================================================
--- linux-2.6.18-rc6.orig/fs/Kconfig
+++ linux-2.6.18-rc6/fs/Kconfig
@@ -1921,6 +1921,10 @@ config 9P_FS
 
 	  If unsure, say N.
 
+config GENERIC_ACL
+	bool
+	select FS_POSIX_ACL
+
 endmenu
 
 menu "Partition Types"
Index: linux-2.6.18-rc6/fs/Makefile
===================================================================
--- linux-2.6.18-rc6.orig/fs/Makefile
+++ linux-2.6.18-rc6/fs/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
+obj-$(CONFIG_GENERIC_ACL)	+= generic_acl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
Index: linux-2.6.18-rc6/include/linux/generic_acl.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/include/linux/generic_acl.h
@@ -0,0 +1,36 @@
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
+/**
+ * struct generic_acl_operations  -  filesystem operations
+ *
+ * Filesystems must make these operations available to the generic
+ * operations.
+ */
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
Index: linux-2.6.18-rc6/fs/generic_acl.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/fs/generic_acl.c
@@ -0,0 +1,197 @@
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
+/**
+ * generic_acl_list  -  Generic xattr_handler->list() operation
+ * @ops:	Filesystem specific getacl and setacl callbacks
+ */
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
+/**
+ * generic_acl_get  -  Generic xattr_handler->get() operation
+ * @ops:	Filesystem specific getacl and setacl callbacks
+ */
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
+/**
+ * generic_acl_set  -  Generic xattr_handler->set() operation
+ * @ops:	Filesystem specific getacl and setacl callbacks
+ */
+int
+generic_acl_set(struct inode *inode, struct generic_acl_operations *ops,
+		int type, const void *value, size_t size)
+{
+	struct posix_acl *acl = NULL;
+	int error;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+	if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER))
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
+/**
+ * generic_acl_init  -  Take care of acl inheritance at @inode create time
+ * @ops:	Filesystem specific getacl and setacl callbacks
+ *
+ * Files created inside a directory with a default ACL inherit the
+ * directory's default ACL.
+ */
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
+			if (error > 0)
+				ops->setacl(inode, ACL_TYPE_ACCESS, clone);
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
+/**
+ * generic_acl_chmod  -  change the access acl of @inode upon chmod()
+ * @ops:	FIlesystem specific getacl and setacl callbacks
+ *
+ * A chmod also changes the permissions of the owner, group/mask, and
+ * other ACL entries.
+ */
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

--Boundary-00=_snv/EGFPGXxxtKz--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWIFOpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWIFOpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWIFOpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:45:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:57579 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751180AbWIFOpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:45:12 -0400
Message-Id: <20060906151645.064363757@winden.suse.de>
References: <20060906151438.228071937@winden.suse.de>
User-Agent: quilt/0.44-16.4
Date: Wed, 06 Sep 2006 17:14:41 +0200
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [patch 3/3] NFSv4 ACLs on ext3
Content-Disposition: inline; filename=ext3-nfs4acl.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements NFSv4 ACLs on the ext3 filesystem. When an ext3
filesystem is mounted with -o acl=nfs4 or -o acl=nfs4+max, the filesystem
will support NFSv4 ACLs instead of POSIX ACLs.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

---
 fs/Kconfig                    |   12 
 fs/Makefile                   |    4 
 fs/ext3/Makefile              |    3 
 fs/ext3/acl.c                 |    8 
 fs/ext3/acl.h                 |    4 
 fs/ext3/file.c                |    1 
 fs/ext3/ialloc.c              |    6 
 fs/ext3/inode.c               |    9 
 fs/ext3/namei.c               |   11 
 fs/ext3/namei.h               |    1 
 fs/ext3/nfs4acl.c             |  281 +++++++++++++++
 fs/ext3/nfs4acl.h             |   26 +
 fs/ext3/super.c               |   54 ++-
 fs/ext3/xattr.c               |    9 
 fs/ext3/xattr.h               |    5 
 fs/nfs4acl_base.c             |  532 ++++++++++++++++++++++++++++++
 fs/nfs4acl_compat.c           |  743 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfs4acl_xattr.c            |  153 ++++++++
 include/linux/ext3_fs.h       |    2 
 include/linux/nfs4acl.h       |  181 ++++++++++
 include/linux/nfs4acl_xattr.h |   31 +
 21 files changed, 2051 insertions(+), 25 deletions(-)

Index: linux-2.6.18-rc6/include/linux/nfs4acl.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/include/linux/nfs4acl.h
@@ -0,0 +1,181 @@
+#ifndef __NFS4ACL_H
+#define __NFS4ACL_H
+
+struct nfs4ace {
+	unsigned short	e_type;
+	unsigned short	e_flags;
+	unsigned int	e_mask;
+	union {
+		unsigned int	e_id;
+		const char	*e_who;
+	} u;
+};
+
+struct nfs4acl {
+	unsigned int	a_owner_mask;
+	unsigned int	a_group_mask;
+	unsigned int	a_other_mask;
+	unsigned int	a_count;
+	struct nfs4ace	a_entries[0];
+};
+
+#define nfs4acl_for_each_entry(_ace, _acl) \
+	for (_ace = _acl->a_entries; \
+	     _ace != _acl->a_entries + _acl->a_count; \
+	     _ace++)
+
+#define nfs4acl_for_each_entry_reverse(_ace, _acl) \
+	for (_ace = _acl->a_entries + _acl->a_count - 1; \
+	     _ace != _acl->a_entries - 1; \
+	     _ace--)
+
+/* e_type values */
+#define ACE4_ACCESS_ALLOWED_ACE_TYPE	0x0000
+#define ACE4_ACCESS_DENIED_ACE_TYPE	0x0001
+/*#define ACE4_SYSTEM_AUDIT_ACE_TYPE	0x0002*/
+/*#define ACE4_SYSTEM_ALARM_ACE_TYPE	0x0003*/
+
+/* e_flags bitflags */
+#define ACE4_FILE_INHERIT_ACE		0x0001
+#define ACE4_DIRECTORY_INHERIT_ACE	0x0002
+#define ACE4_NO_PROPAGATE_INHERIT_ACE	0x0004
+#define ACE4_INHERIT_ONLY_ACE		0x0008
+/*#define ACE4_SUCCESSFUL_ACCESS_ACE_FLAG	0x0010*/
+/*#define ACE4_FAILED_ACCESS_ACE_FLAG	0x0020*/
+#define ACE4_IDENTIFIER_GROUP		0x0040
+#define ACE4_SPECIAL_WHO		0x4000  /* in-kernel only */
+
+#define ACE4_VALID_FLAGS ( \
+	ACE4_FILE_INHERIT_ACE | \
+	ACE4_DIRECTORY_INHERIT_ACE | \
+	ACE4_NO_PROPAGATE_INHERIT_ACE | \
+	ACE4_INHERIT_ONLY_ACE | \
+	ACE4_IDENTIFIER_GROUP )
+
+/* e_mask bitflags */
+#define ACE4_READ_DATA			0x00000001
+#define ACE4_LIST_DIRECTORY		0x00000001
+#define ACE4_WRITE_DATA			0x00000002
+#define ACE4_ADD_FILE			0x00000002
+#define ACE4_APPEND_DATA		0x00000004
+#define ACE4_ADD_SUBDIRECTORY		0x00000004
+#define ACE4_READ_NAMED_ATTRS		0x00000008
+#define ACE4_WRITE_NAMED_ATTRS		0x00000010
+#define ACE4_EXECUTE			0x00000020
+#define ACE4_DELETE_CHILD		0x00000040
+#define ACE4_READ_ATTRIBUTES		0x00000080
+#define ACE4_WRITE_ATTRIBUTES		0x00000100
+#define ACE4_DELETE			0x00010000
+#define ACE4_READ_ACL			0x00020000
+#define ACE4_WRITE_ACL			0x00040000
+#define ACE4_WRITE_OWNER		0x00080000
+#define ACE4_SYNCHRONIZE		0x00100000
+
+#define ACE4_VALID_MASK ( \
+	ACE4_READ_DATA | \
+	ACE4_LIST_DIRECTORY | \
+	ACE4_WRITE_DATA | \
+	ACE4_ADD_FILE | \
+	ACE4_APPEND_DATA | \
+	ACE4_ADD_SUBDIRECTORY | \
+	ACE4_READ_NAMED_ATTRS | \
+	ACE4_WRITE_NAMED_ATTRS | \
+	ACE4_EXECUTE | \
+	ACE4_DELETE_CHILD | \
+	ACE4_READ_ATTRIBUTES | \
+	ACE4_WRITE_ATTRIBUTES | \
+	ACE4_DELETE | \
+	ACE4_READ_ACL | \
+	ACE4_WRITE_ACL | \
+	ACE4_WRITE_OWNER | \
+	ACE4_SYNCHRONIZE )
+
+/* Special e_who identifiers: we use these pointer values in comparisons
+   instead of strcmp for efficiency. */
+
+extern const char *nfs4ace_owner_who;
+extern const char *nfs4ace_group_who;
+extern const char *nfs4ace_everyone_who;
+
+static inline int
+nfs4ace_is_owner(struct nfs4ace *ace)
+{
+	return (ace->e_flags & ACE4_SPECIAL_WHO) &&
+	       ace->u.e_who == nfs4ace_owner_who;
+}
+
+static inline int
+nfs4ace_is_group(struct nfs4ace *ace)
+{
+	return (ace->e_flags & ACE4_SPECIAL_WHO) &&
+	       ace->u.e_who == nfs4ace_group_who;
+}
+
+static inline int
+nfs4ace_is_everyone(struct nfs4ace *ace)
+{
+	return (ace->e_flags & ACE4_SPECIAL_WHO) &&
+	       ace->u.e_who == nfs4ace_everyone_who;
+}
+
+static inline int
+nfs4ace_is_unix_id(struct nfs4ace *ace)
+{
+	return !(ace->e_flags & ACE4_SPECIAL_WHO);
+}
+
+static inline int
+nfs4ace_is_inherit_only(struct nfs4ace *ace)
+{
+	return ace->e_flags & ACE4_INHERIT_ONLY_ACE;
+}
+
+static inline int
+nfs4ace_is_inheritable(struct nfs4ace *ace)
+{
+	return ace->e_flags & (ACE4_FILE_INHERIT_ACE |
+			       ACE4_DIRECTORY_INHERIT_ACE);
+}
+
+static inline void
+nfs4ace_clear_inheritance_flags(struct nfs4ace *ace)
+{
+	ace->e_flags &= ~(ACE4_FILE_INHERIT_ACE |
+			  ACE4_DIRECTORY_INHERIT_ACE |
+			  ACE4_NO_PROPAGATE_INHERIT_ACE |
+			  ACE4_INHERIT_ONLY_ACE);
+}
+
+static inline int
+nfs4ace_is_allow(struct nfs4ace *ace)
+{
+	return ace->e_type == ACE4_ACCESS_ALLOWED_ACE_TYPE;
+}
+
+static inline int
+nfs4ace_is_deny(struct nfs4ace *ace)
+{
+	return ace->e_type == ACE4_ACCESS_DENIED_ACE_TYPE;
+}
+
+extern int nfs4ace_dup(struct nfs4ace *, struct nfs4ace *);
+extern void nfs4ace_free(struct nfs4ace *);
+
+extern struct nfs4acl *nfs4acl_alloc(int count);
+extern struct nfs4acl *nfs4acl_clone(struct nfs4acl *acl);
+extern void __nfs4acl_free(struct nfs4acl *);
+
+static inline void
+nfs4acl_free(struct nfs4acl *acl)
+{
+	kfree(acl);
+}
+
+extern int nfs4acl_permission(struct inode *, const struct nfs4acl *, int, int);
+extern int nfs4ace_is_same_who(struct nfs4ace *, struct nfs4ace *);
+extern struct nfs4acl *nfs4acl_inherit(struct nfs4acl *, mode_t, int);
+extern int nfs4acl_masks_to_mode(struct nfs4acl *);
+extern void nfs4acl_chmod(struct nfs4acl *, mode_t);
+extern int nfs4acl_apply_masks(struct nfs4acl **acl, int);
+
+#endif /* __NFS4ACL_H */
Index: linux-2.6.18-rc6/include/linux/nfs4acl_xattr.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/include/linux/nfs4acl_xattr.h
@@ -0,0 +1,31 @@
+#ifndef __NFS4ACL_XATTR_H
+#define __NFS4ACL_XATTR_H
+
+#include <linux/nfs4acl.h>
+
+#define NFS4ACL_XATTR "system.nfs4acl"
+
+struct nfs4ace_xattr {
+	__be16		e_type;
+	__be16		e_flags;
+	__be32		e_mask;
+	__be32		e_id;
+	char		e_who[0];
+};
+
+struct nfs4acl_xattr {
+	unsigned char	a_version;
+	unsigned char	a_flags;
+	__be16		a_count;
+	__be32		a_owner_mask;
+	__be32		a_group_mask;
+	__be32		a_other_mask;
+};
+
+#define ACL4_XATTR_VERSION	0
+#define ACL4_XATTR_MAX_COUNT	1024
+
+extern struct nfs4acl *nfs4acl_from_xattr(const void *, size_t);
+extern void *nfs4acl_to_xattr(const struct nfs4acl *, size_t *);
+
+#endif /* __NFS4ACL_XATTR_H */
Index: linux-2.6.18-rc6/fs/nfs4acl_xattr.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/fs/nfs4acl_xattr.c
@@ -0,0 +1,153 @@
+/*
+ * Copyright (C) 2006 Andreas Gruenbacher <a.gruenbacher@computer.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/nfs4acl_xattr.h>
+
+MODULE_LICENSE("GPL");
+
+struct nfs4acl *
+nfs4acl_from_xattr(const void *value, size_t size)
+{
+	const struct nfs4acl_xattr *xattr_acl = value;
+	const struct nfs4ace_xattr *xattr_ace = (void *)(xattr_acl + 1);
+	struct nfs4acl *acl;
+	struct nfs4ace *ace;
+	int count;
+
+	if (size < sizeof(struct nfs4acl_xattr) ||
+	    xattr_acl->a_version != ACL4_XATTR_VERSION ||
+	    xattr_acl->a_flags != 0)
+		return ERR_PTR(-EINVAL);
+
+	count = be16_to_cpu(xattr_acl->a_count);
+	if (count > ACL4_XATTR_MAX_COUNT)
+		return ERR_PTR(-EINVAL);
+
+	acl = nfs4acl_alloc(count);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+
+	acl->a_owner_mask = be32_to_cpu(xattr_acl->a_owner_mask);
+	if (acl->a_owner_mask & ~ACE4_VALID_MASK)
+		goto fail_einval;
+	acl->a_group_mask = be32_to_cpu(xattr_acl->a_group_mask);
+	if (acl->a_group_mask & ~ACE4_VALID_MASK)
+		goto fail_einval;
+	acl->a_other_mask = be32_to_cpu(xattr_acl->a_other_mask);
+	if (acl->a_other_mask & ~ACE4_VALID_MASK)
+		goto fail_einval;
+
+	nfs4acl_for_each_entry(ace, acl) {
+		const char *who = (void *)(xattr_ace + 1), *end;
+		ssize_t used = (void *)who - value;
+
+		if (used > size)
+			goto fail_einval;
+		end = memchr(who, 0, size - used);
+		if (!end)
+			goto fail_einval;
+
+		ace->e_type = be16_to_cpu(xattr_ace->e_type);
+		ace->e_flags = be16_to_cpu(xattr_ace->e_flags);
+		ace->e_mask = be32_to_cpu(xattr_ace->e_mask);
+		ace->u.e_id = be32_to_cpu(xattr_ace->e_id);
+
+		if (ace->e_flags & ~ACE4_VALID_FLAGS) {
+			memset(ace, 0, sizeof(struct nfs4ace));
+			goto fail_einval;
+		}
+		if (ace->e_type > ACE4_ACCESS_DENIED_ACE_TYPE ||
+		    (ace->e_mask & ~ACE4_VALID_MASK))
+			goto fail_einval;
+
+		if (who == end) {
+			if (ace->u.e_id == -1)
+				goto fail_einval;  /* uid/gid needed */
+		} else if (!strcmp(who, nfs4ace_owner_who)) {
+			ace->e_flags |= ACE4_SPECIAL_WHO;
+			ace->u.e_who = nfs4ace_owner_who;
+		} else if (!strcmp(who, nfs4ace_group_who)) {
+			ace->e_flags |= ACE4_SPECIAL_WHO;
+			ace->u.e_who = nfs4ace_group_who;
+		} else if (!strcmp(who, nfs4ace_everyone_who)) {
+			ace->e_flags |= ACE4_SPECIAL_WHO;
+			ace->u.e_who = nfs4ace_everyone_who;
+		} else
+			goto fail_einval;
+
+		xattr_ace = (void *)who + ALIGN(end - who + 1, 4);
+	}
+
+	return acl;
+
+fail_einval:
+	nfs4acl_free(acl);
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(nfs4acl_from_xattr);
+
+void *
+nfs4acl_to_xattr(const struct nfs4acl *acl, size_t *xattr_size)
+{
+	struct nfs4acl_xattr *xattr_acl;
+	struct nfs4ace_xattr *xattr_ace;
+	size_t size = sizeof(struct nfs4acl_xattr);
+	struct nfs4ace *ace;
+
+	nfs4acl_for_each_entry(ace, acl) {
+		size += sizeof(struct nfs4ace_xattr) +
+			(nfs4ace_is_unix_id(ace) ? 4 :
+			 ALIGN(strlen(ace->u.e_who) + 1, 4));
+	}
+
+	xattr_acl = kmalloc(size, GFP_KERNEL);
+	if (!xattr_acl)
+		return ERR_PTR(-ENOMEM);
+
+	xattr_acl->a_version = ACL4_XATTR_VERSION;
+	xattr_acl->a_flags = 0;
+	xattr_acl->a_count = cpu_to_be16(acl->a_count);
+
+	xattr_acl->a_owner_mask = cpu_to_be32(acl->a_owner_mask);
+	xattr_acl->a_group_mask = cpu_to_be32(acl->a_group_mask);
+	xattr_acl->a_other_mask = cpu_to_be32(acl->a_other_mask);
+
+	xattr_ace = (void *)(xattr_acl + 1);
+	nfs4acl_for_each_entry(ace, acl) {
+		xattr_ace->e_type = cpu_to_be16(ace->e_type);
+		xattr_ace->e_flags = cpu_to_be16(ace->e_flags &
+			ACE4_VALID_FLAGS);
+		xattr_ace->e_mask = cpu_to_be32(ace->e_mask);
+		if (nfs4ace_is_unix_id(ace)) {
+			xattr_ace->e_id = cpu_to_be32(ace->u.e_id);
+			memset(xattr_ace->e_who, 0, 4);
+			xattr_ace = (void *)xattr_ace->e_who + 4;
+		} else {
+			int sz = ALIGN(strlen(ace->u.e_who) + 1, 4);
+
+			xattr_ace->e_id = cpu_to_be32(-1);
+			memset(xattr_ace->e_who + sz - 4, 0, 4);
+			strcpy(xattr_ace->e_who, ace->u.e_who);
+			xattr_ace = (void *)xattr_ace->e_who + sz;
+		}
+	}
+
+	*xattr_size = size;
+	return xattr_acl;
+}
+EXPORT_SYMBOL_GPL(nfs4acl_to_xattr);
Index: linux-2.6.18-rc6/fs/Kconfig
===================================================================
--- linux-2.6.18-rc6.orig/fs/Kconfig
+++ linux-2.6.18-rc6/fs/Kconfig
@@ -126,6 +126,14 @@ config EXT3_FS_POSIX_ACL
 
 	  If you don't know what Access Control Lists are, say N
 
+config EXT3_FS_NFS4ACL
+	bool "Native NFSv4 ACLs (EXPERIMENTAL)"
+	depends on EXT3_FS_XATTR && EXPERIMENTAL
+	select FS_NFS4ACL
+	help
+	  Allow to use NFSv4 ACLs instead of POSIX ACLs. This may become
+	  useful for filesystems exported over NFSv4 or Samba.
+
 config EXT3_FS_SECURITY
 	bool "Ext3 Security Labels"
 	depends on EXT3_FS_XATTR
@@ -322,6 +330,10 @@ config FS_POSIX_ACL
 	bool
 	default n
 
+config FS_NFS4ACL
+	bool
+	default n
+
 source "fs/xfs/Kconfig"
 
 config OCFS2_FS
Index: linux-2.6.18-rc6/fs/Makefile
===================================================================
--- linux-2.6.18-rc6.orig/fs/Makefile
+++ linux-2.6.18-rc6/fs/Makefile
@@ -36,6 +36,10 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
 
+obj-$(CONFIG_FS_NFS4ACL:y=m)	+= nfs4acl.o
+nfs4acl-y			:= nfs4acl_base.o nfs4acl_xattr.o \
+				   nfs4acl_compat.o
+
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
 obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
Index: linux-2.6.18-rc6/fs/ext3/file.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/file.c
+++ linux-2.6.18-rc6/fs/ext3/file.c
@@ -23,6 +23,7 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
+#include "namei.h"
 #include "xattr.h"
 #include "acl.h"
 
Index: linux-2.6.18-rc6/fs/ext3/inode.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/inode.c
+++ linux-2.6.18-rc6/fs/ext3/inode.c
@@ -38,6 +38,7 @@
 #include <linux/uio.h>
 #include "xattr.h"
 #include "acl.h"
+#include "nfs4acl.h"
 
 static int ext3_writepage_trans_blocks(struct inode *inode);
 
@@ -2964,8 +2965,12 @@ int ext3_setattr(struct dentry *dentry, 
 	if (inode->i_nlink)
 		ext3_orphan_del(NULL, inode);
 
-	if (!rc && (ia_valid & ATTR_MODE))
-		rc = ext3_acl_chmod(inode);
+	if (!rc && (ia_valid & ATTR_MODE)) {
+		if (test_opt(inode->i_sb, NFS4ACL))
+			rc = ext3_nfs4acl_chmod(inode);
+		else
+			rc = ext3_acl_chmod(inode);
+	}
 
 err_out:
 	ext3_std_error(inode->i_sb, error);
Index: linux-2.6.18-rc6/fs/ext3/namei.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/namei.c
+++ linux-2.6.18-rc6/fs/ext3/namei.c
@@ -40,6 +40,7 @@
 #include "namei.h"
 #include "xattr.h"
 #include "acl.h"
+#include "nfs4acl.h"
 
 /*
  * define how far ahead to read directories while searching them.
@@ -2361,6 +2362,16 @@ end_rename:
 	return retval;
 }
 
+int ext3_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+#ifdef CONFIG_EXT3_FS_NFS4ACL
+	if (test_opt(inode->i_sb, NFS4ACL))
+		return ext3_nfs4acl_permission(inode, mask);
+	else
+#endif
+        return generic_permission(inode, mask, ext3_check_acl);
+}
+
 /*
  * directories can handle most operations...
  */
Index: linux-2.6.18-rc6/fs/ext3/super.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/super.c
+++ linux-2.6.18-rc6/fs/ext3/super.c
@@ -628,7 +628,7 @@ enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
 	Opt_nouid32, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov,
-	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
+	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_acl_flavor, Opt_noacl,
 	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh, Opt_bh,
 	Opt_commit, Opt_journal_update, Opt_journal_inum, Opt_journal_dev,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
@@ -660,6 +660,7 @@ static match_table_t tokens = {
 	{Opt_user_xattr, "user_xattr"},
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
+	{Opt_acl_flavor, "acl=%s"},
 	{Opt_noacl, "noacl"},
 	{Opt_reservation, "reservation"},
 	{Opt_noreservation, "noreservation"},
@@ -803,19 +804,39 @@ static int parse_options (char *options,
 			printk("EXT3 (no)user_xattr options not supported\n");
 			break;
 #endif
-#ifdef CONFIG_EXT3_FS_POSIX_ACL
 		case Opt_acl:
-			set_opt(sbi->s_mount_opt, POSIX_ACL);
+			args[0].to = args[0].from;
+			/* fall through */
+		case Opt_acl_flavor:
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+			if (match_string(&args[0], "") ||
+			    match_string(&args[0], "posix")) {
+				set_opt(sbi->s_mount_opt, POSIX_ACL);
+				clear_opt(sbi->s_mount_opt, NFS4ACL);
+			} else
+#endif
+#ifdef CONFIG_EXT3_FS_NFS4ACL
+			if (match_string(&args[0], "nfs4")) {
+				clear_opt(sbi->s_mount_opt, POSIX_ACL);
+				set_opt(sbi->s_mount_opt, NFS4ACL);
+				clear_opt(sbi->s_mount_opt, NFS4ACL_MAX);
+			} else
+			if (match_string(&args[0], "nfs4+max")) {
+				clear_opt(sbi->s_mount_opt, POSIX_ACL);
+				set_opt(sbi->s_mount_opt, NFS4ACL);
+				set_opt(sbi->s_mount_opt, NFS4ACL_MAX);
+			} else
+#endif
+			{
+				printk(KERN_ERR "EXT3-fs: unsupported acl "
+				       "flavor\n");
+				return 0;
+			}
 			break;
 		case Opt_noacl:
 			clear_opt(sbi->s_mount_opt, POSIX_ACL);
+			clear_opt(sbi->s_mount_opt, NFS4ACL);
 			break;
-#else
-		case Opt_acl:
-		case Opt_noacl:
-			printk("EXT3 (no)acl options not supported\n");
-			break;
-#endif
 		case Opt_reservation:
 			set_opt(sbi->s_mount_opt, RESERVATION);
 			break;
@@ -1434,8 +1455,11 @@ static int ext3_fill_super (struct super
 			    NULL, 0))
 		goto failed_mount;
 
-	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
-		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
+	sb->s_flags = (sb->s_flags & ~(MS_POSIXACL | MS_XPERM));
+	if (sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL)
+		sb->s_flags |= MS_POSIXACL;
+	if (sbi->s_mount_opt & EXT3_MOUNT_NFS4ACL)
+		sb->s_flags |= MS_POSIXACL | MS_XPERM;
 
 	if (le32_to_cpu(es->s_rev_level) == EXT3_GOOD_OLD_REV &&
 	    (EXT3_HAS_COMPAT_FEATURE(sb, ~0U) ||
@@ -2250,8 +2274,12 @@ static int ext3_remount (struct super_bl
 	if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
 		ext3_abort(sb, __FUNCTION__, "Abort forced by user");
 
-	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
-		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
+	sb->s_flags = (sb->s_flags & ~(MS_POSIXACL | MS_XPERM));
+	if (sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL)
+		sb->s_flags |= MS_POSIXACL;
+	if (sbi->s_mount_opt & EXT3_MOUNT_NFS4ACL)
+		sb->s_flags |= MS_POSIXACL | MS_XPERM;
+
 
 	es = sbi->s_es;
 
Index: linux-2.6.18-rc6/fs/ext3/xattr.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/xattr.c
+++ linux-2.6.18-rc6/fs/ext3/xattr.c
@@ -112,6 +112,9 @@ static struct xattr_handler *ext3_xattr_
 #ifdef CONFIG_EXT3_FS_SECURITY
 	[EXT3_XATTR_INDEX_SECURITY]	     = &ext3_xattr_security_handler,
 #endif
+#ifdef CONFIG_EXT3_FS_NFS4ACL
+	[EXT3_XATTR_INDEX_NFS4ACL]	     = &ext3_nfs4acl_xattr_handler,
+#endif
 };
 
 struct xattr_handler *ext3_xattr_handlers[] = {
@@ -124,6 +127,12 @@ struct xattr_handler *ext3_xattr_handler
 #ifdef CONFIG_EXT3_FS_SECURITY
 	&ext3_xattr_security_handler,
 #endif
+#ifdef CONFIG_EXT3_FS_NFS4ACL
+	&ext3_nfs4acl_xattr_handler,
+#ifdef NFS4ACL_DEBUG
+	&ext3_masked_nfs4acl_xattr_handler,
+#endif
+#endif
 	NULL
 };
 
Index: linux-2.6.18-rc6/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/ext3_fs.h
+++ linux-2.6.18-rc6/include/linux/ext3_fs.h
@@ -371,6 +371,8 @@ struct ext3_inode {
 #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
 #define EXT3_MOUNT_USRQUOTA		0x100000 /* "old" user quota */
 #define EXT3_MOUNT_GRPQUOTA		0x200000 /* "old" group quota */
+#define EXT3_MOUNT_NFS4ACL		0x400000 /* NFS version 4 ACLs */
+#define EXT3_MOUNT_NFS4ACL_MAX		0x800000 /* "write-through" behavior */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
Index: linux-2.6.18-rc6/fs/ext3/xattr.h
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/xattr.h
+++ linux-2.6.18-rc6/fs/ext3/xattr.h
@@ -21,6 +21,7 @@
 #define EXT3_XATTR_INDEX_TRUSTED		4
 #define	EXT3_XATTR_INDEX_LUSTRE			5
 #define EXT3_XATTR_INDEX_SECURITY	        6
+#define EXT3_XATTR_INDEX_NFS4ACL		7
 
 struct ext3_xattr_header {
 	__le32	h_magic;	/* magic number for identification */
@@ -63,6 +64,10 @@ extern struct xattr_handler ext3_xattr_t
 extern struct xattr_handler ext3_xattr_acl_access_handler;
 extern struct xattr_handler ext3_xattr_acl_default_handler;
 extern struct xattr_handler ext3_xattr_security_handler;
+extern struct xattr_handler ext3_nfs4acl_xattr_handler;
+#ifdef NFS4ACL_DEBUG
+extern struct xattr_handler ext3_masked_nfs4acl_xattr_handler;
+#endif
 
 extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
 
Index: linux-2.6.18-rc6/fs/ext3/Makefile
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/Makefile
+++ linux-2.6.18-rc6/fs/ext3/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux ext3-filesystem routines.
 #
 
+EXTRA_CFLAGS := -DNFS4ACL_DEBUG
+
 obj-$(CONFIG_EXT3_FS) += ext3.o
 
 ext3-y	:= balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
@@ -10,3 +12,4 @@ ext3-y	:= balloc.o bitmap.o dir.o file.o
 ext3-$(CONFIG_EXT3_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext3-$(CONFIG_EXT3_FS_POSIX_ACL) += acl.o
 ext3-$(CONFIG_EXT3_FS_SECURITY)	 += xattr_security.o
+ext3-$(CONFIG_EXT3_FS_NFS4ACL)	 += nfs4acl.o
Index: linux-2.6.18-rc6/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/ialloc.c
+++ linux-2.6.18-rc6/fs/ext3/ialloc.c
@@ -28,6 +28,7 @@
 
 #include "xattr.h"
 #include "acl.h"
+#include "nfs4acl.h"
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
@@ -603,7 +604,10 @@ got:
 		goto fail_drop;
 	}
 
-	err = ext3_init_acl(handle, inode, dir);
+	if (test_opt(sb, NFS4ACL))
+		err = ext3_nfs4acl_init(handle, inode, dir);
+	else
+		err = ext3_init_acl(handle, inode, dir);
 	if (err)
 		goto fail_free_drop;
 
Index: linux-2.6.18-rc6/fs/ext3/nfs4acl.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/fs/ext3/nfs4acl.c
@@ -0,0 +1,281 @@
+/*
+ * Copyright (C) 2006 Andreas Gruenbacher <a.gruenbacher@computer.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include <linux/nfs4acl.h>
+#include <linux/nfs4acl_xattr.h>
+#include "xattr.h"
+
+static struct nfs4acl *
+ext3_get_nfs4acl(struct inode *inode)
+{
+	const int name_index = EXT3_XATTR_INDEX_NFS4ACL;
+	void *value = NULL;
+	struct nfs4acl *acl;
+	int retval;
+
+	retval = ext3_xattr_get(inode, name_index, "", NULL, 0);
+	if (retval > 0) {
+		value = kmalloc(retval, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		retval = ext3_xattr_get(inode, name_index, "", value, retval);
+	}
+	if (retval > 0) {
+		acl = nfs4acl_from_xattr(value, retval);
+		if (acl == ERR_PTR(-EINVAL))
+			acl = ERR_PTR(-EIO);
+	} else if (retval == -ENODATA || retval == -ENOSYS)
+		acl = NULL;
+	else
+		acl = ERR_PTR(retval);
+	kfree(value);
+
+	return acl;
+}
+
+static int
+ext3_set_nfs4acl(handle_t *handle, struct inode *inode, struct nfs4acl *acl)
+{
+	const int name_index = EXT3_XATTR_INDEX_NFS4ACL;
+	size_t size;
+	void *value;
+	int retval;
+
+	value = nfs4acl_to_xattr(acl, &size);
+	if (IS_ERR(value))
+		return PTR_ERR(value);
+	if (handle)
+		retval = ext3_xattr_set_handle(handle, inode, name_index, "",
+					       value, size, 0);
+	else
+		retval = ext3_xattr_set(inode, name_index, "", value, size, 0);
+	kfree(value);
+	return retval;
+}
+
+int
+ext3_nfs4acl_permission(struct inode *inode, int want)
+{
+	struct nfs4acl *acl = ext3_get_nfs4acl(inode);
+	int retval;
+
+	BUG_ON(!test_opt(inode->i_sb, NFS4ACL));
+
+	if (!acl)
+		retval = generic_permission(inode, want, NULL);
+	else if (IS_ERR(acl))
+		retval = PTR_ERR(acl);
+	else {
+		retval = nfs4acl_permission(inode, acl, want,
+					    test_opt(inode->i_sb, NFS4ACL_MAX));
+		nfs4acl_free(acl);
+	}
+
+	return retval;
+}
+
+int
+ext3_nfs4acl_init(handle_t *handle, struct inode *inode, struct inode *dir)
+{
+	struct nfs4acl *dir_acl, *acl;
+	int retval = 0;
+
+	BUG_ON(!test_opt(inode->i_sb, NFS4ACL));
+
+	dir_acl = ext3_get_nfs4acl(dir);
+	retval = PTR_ERR(dir_acl);
+	if (!dir_acl || IS_ERR(dir_acl))
+		goto out;
+	acl = nfs4acl_inherit(dir_acl, inode->i_mode,
+			      test_opt(inode->i_sb, NFS4ACL_MAX));
+	nfs4acl_free(dir_acl);
+
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	else if (acl) {
+		retval = ext3_set_nfs4acl(handle, inode, acl);
+		inode->i_mode = (inode->i_mode & ~S_IRWXUGO) |
+				nfs4acl_masks_to_mode(acl);
+		nfs4acl_free(acl);
+		return retval;
+	}
+
+out:
+	if (!retval)
+		inode->i_mode &= ~current->fs->umask;
+
+	return retval;
+}
+
+int
+ext3_nfs4acl_chmod(struct inode *inode)
+{
+	struct nfs4acl *acl;
+	int retval;
+
+	BUG_ON(!test_opt(inode->i_sb, NFS4ACL));
+
+	acl = ext3_get_nfs4acl(inode);
+	if (!acl || IS_ERR(acl))
+		return PTR_ERR(acl);
+	nfs4acl_chmod(acl, inode->i_mode);
+	retval = ext3_set_nfs4acl(NULL, inode, acl);
+	nfs4acl_free(acl);
+
+	return retval;
+}
+
+static size_t
+ext3_xattr_list_nfs4acl(struct inode *inode, char *list, size_t list_len,
+			const char *name, size_t name_len)
+{
+	const size_t size = sizeof(NFS4ACL_XATTR);
+
+	if (!test_opt(inode->i_sb, NFS4ACL))
+		return 0;
+	if (list && size <= list_len)
+		memcpy(list, NFS4ACL_XATTR, size);
+	return size;
+}
+
+static int
+ext3_xattr_get_nfs4acl(struct inode *inode, const char *name, void *buffer,
+		       size_t buffer_size)
+{
+	const int name_index = EXT3_XATTR_INDEX_NFS4ACL;
+
+	if (!test_opt(inode->i_sb, NFS4ACL))
+		return -EOPNOTSUPP;
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_get(inode, name_index, "", buffer, buffer_size);
+}
+
+#ifdef NFS4ACL_DEBUG
+static size_t
+ext3_xattr_list_masked_nfs4acl(struct inode *inode, char *list, size_t list_len,
+			       const char *name, size_t name_len)
+{
+	return 0;
+}
+
+static int
+ext3_xattr_get_masked_nfs4acl(struct inode *inode, const char *name,
+			      void *buffer, size_t buffer_size)
+{
+	const int name_index = EXT3_XATTR_INDEX_NFS4ACL;
+	struct nfs4acl *acl;
+	void *xattr;
+	size_t size;
+	int error;
+
+	if (!test_opt(inode->i_sb, NFS4ACL))
+		return -EOPNOTSUPP;
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	error = ext3_xattr_get(inode, name_index, "", NULL, 0);
+	if (error <= 0)
+		return error;
+	xattr = kmalloc(error, GFP_KERNEL);
+	if (!xattr)
+		return -ENOMEM;
+	error = ext3_xattr_get(inode, name_index, "", xattr, error);
+	if (error <= 0)
+		return error;
+	acl = nfs4acl_from_xattr(xattr, error);
+	kfree(xattr);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	error = nfs4acl_apply_masks(&acl, test_opt(inode->i_sb, NFS4ACL_MAX));
+	if (error) {
+		nfs4acl_free(acl);
+		return error;
+	}
+	xattr = nfs4acl_to_xattr(acl, &size);
+	nfs4acl_free(acl);
+	if (IS_ERR(xattr))
+		return PTR_ERR(xattr);
+	if (buffer) {
+		if (size > buffer_size)
+			return -ERANGE;
+		memcpy(buffer, xattr, size);
+	}
+	kfree(xattr);
+	return size;
+}
+#endif
+
+static int
+ext3_set_mode(struct inode *inode, int mode)
+{
+	handle_t *handle = ext3_journal_start(inode,
+		EXT3_DATA_TRANS_BLOCKS(inode->i_sb));
+	int error;
+
+	error = PTR_ERR(handle);
+	if (!IS_ERR(handle)) {
+		inode->i_mode = mode;
+		error = ext3_mark_inode_dirty(handle, inode);
+		ext3_journal_stop(handle);
+	}
+	return error;
+}
+
+static int
+ext3_xattr_set_nfs4acl(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	const int name_index = EXT3_XATTR_INDEX_NFS4ACL;
+	struct nfs4acl *acl = NULL;
+	int retval;
+
+	if (!test_opt(inode->i_sb, NFS4ACL))
+		return -EOPNOTSUPP;
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	if (value) {
+		acl = nfs4acl_from_xattr(value, size);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+
+		retval = ext3_set_mode(inode, (inode->i_mode & ~S_IRWXUGO) |
+					      nfs4acl_masks_to_mode(acl));
+		if (retval)
+			goto out;
+	}
+	retval = ext3_xattr_set(inode, name_index, "", value, size, flags);
+out:
+	nfs4acl_free(acl);
+	return retval;
+}
+
+struct xattr_handler ext3_nfs4acl_xattr_handler = {
+	.prefix	= NFS4ACL_XATTR,
+	.list	= ext3_xattr_list_nfs4acl,
+	.get	= ext3_xattr_get_nfs4acl,
+	.set	= ext3_xattr_set_nfs4acl,
+};
+
+#ifdef NFS4ACL_DEBUG
+struct xattr_handler ext3_masked_nfs4acl_xattr_handler = {
+	.prefix	= "system.masked-nfs4acl",
+	.list	= ext3_xattr_list_masked_nfs4acl,
+	.get	= ext3_xattr_get_masked_nfs4acl,
+	.set	= ext3_xattr_set_nfs4acl,
+};
+#endif
Index: linux-2.6.18-rc6/fs/ext3/nfs4acl.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/fs/ext3/nfs4acl.h
@@ -0,0 +1,26 @@
+#ifndef __FS_EXT3_NFS4ACL_H
+#define __FS_EXT3_NFS4ACL_H
+
+#ifdef CONFIG_EXT3_FS_NFS4ACL
+
+extern int ext3_nfs4acl_permission(struct inode *, int);
+extern int ext3_nfs4acl_init(handle_t *, struct inode *, struct inode *);
+extern int ext3_nfs4acl_chmod(struct inode *);
+
+#else  /* CONFIG_FS_EXT3_NFS4ACL */
+
+static inline int
+ext3_nfs4acl_init(handle_t *handle, struct inode *inode, struct inode *dir)
+{
+	return 0;
+}
+
+static inline int
+ext3_nfs4acl_chmod(struct inode *inode)
+{
+	return 0;
+}
+
+#endif  /* CONFIG_FS_EXT3_NFS4ACL */
+
+#endif  /* __FS_EXT3_NFS4ACL_H */
Index: linux-2.6.18-rc6/fs/ext3/acl.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/acl.c
+++ linux-2.6.18-rc6/fs/ext3/acl.c
@@ -282,7 +282,7 @@ ext3_set_acl(handle_t *handle, struct in
 	return error;
 }
 
-static int
+int
 ext3_check_acl(struct inode *inode, int mask)
 {
 	struct posix_acl *acl = ext3_get_acl(inode, ACL_TYPE_ACCESS);
@@ -298,12 +298,6 @@ ext3_check_acl(struct inode *inode, int 
 	return -EAGAIN;
 }
 
-int
-ext3_permission(struct inode *inode, int mask, struct nameidata *nd)
-{
-	return generic_permission(inode, mask, ext3_check_acl);
-}
-
 /*
  * Initialize the ACLs of a new inode. Called from ext3_new_inode.
  *
Index: linux-2.6.18-rc6/fs/ext3/acl.h
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/acl.h
+++ linux-2.6.18-rc6/fs/ext3/acl.h
@@ -58,13 +58,13 @@ static inline int ext3_acl_count(size_t 
 #define EXT3_ACL_NOT_CACHED ((void *)-1)
 
 /* acl.c */
-extern int ext3_permission (struct inode *, int, struct nameidata *);
+extern int ext3_check_acl(struct inode *, int);
 extern int ext3_acl_chmod (struct inode *);
 extern int ext3_init_acl (handle_t *, struct inode *, struct inode *);
 
 #else  /* CONFIG_EXT3_FS_POSIX_ACL */
 #include <linux/sched.h>
-#define ext3_permission NULL
+#define ext3_check_acl NULL
 
 static inline int
 ext3_acl_chmod(struct inode *inode)
Index: linux-2.6.18-rc6/fs/ext3/namei.h
===================================================================
--- linux-2.6.18-rc6.orig/fs/ext3/namei.h
+++ linux-2.6.18-rc6/fs/ext3/namei.h
@@ -5,4 +5,5 @@
  *
 */
 
+extern int ext3_permission (struct inode *, int, struct nameidata *);
 extern struct dentry *ext3_get_parent(struct dentry *child);
Index: linux-2.6.18-rc6/fs/nfs4acl_base.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/fs/nfs4acl_base.c
@@ -0,0 +1,532 @@
+/*
+ * Copyright (C) 2006 Andreas Gruenbacher <a.gruenbacher@computer.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/nfs4acl.h>
+
+MODULE_LICENSE("GPL");
+
+/**
+ * ACL entries that have ACE4_SPECIAL_WHO set in ace->e_flags use the
+ * pointer values of these constants in ace->u.e_who to avoid massive
+ * amounts of string comparisons.
+ */
+
+const char *nfs4ace_owner_who	 = "OWNER@";
+const char *nfs4ace_group_who	 = "GROUP@";
+const char *nfs4ace_everyone_who = "EVERYONE@";
+
+EXPORT_SYMBOL_GPL(nfs4ace_owner_who);
+EXPORT_SYMBOL_GPL(nfs4ace_group_who);
+EXPORT_SYMBOL_GPL(nfs4ace_everyone_who);
+
+/**
+ * nfs4acl_alloc  -  allocate an acl
+ * @count:	number of entries
+ */
+struct nfs4acl *
+nfs4acl_alloc(int count)
+{
+	size_t size = sizeof(struct nfs4acl) + count * sizeof(struct nfs4ace);
+	struct nfs4acl *acl = kmalloc(size, GFP_KERNEL);
+
+	if (acl) {
+		memset(acl, 0, size);
+		acl->a_count = count;
+	}
+	return acl;
+}
+
+#if 0
+/**
+ * nfs4acl_clone  -  create a copy of an acl
+ */
+struct nfs4acl *
+nfs4acl_clone(struct nfs4acl *acl)
+{
+	struct nfs4acl *dup = nfs4acl_alloc(acl->a_count);
+
+	if (acl) {
+		memcpy(dup, acl, sizeof(struct nfs4acl) +
+		       sizeof(struct nfs4ace) * acl->a_count);
+	}
+	return acl;
+}
+EXPORT_SYMBOL(nfs4acl_clone);
+#endif
+
+/**
+ * The POSIX permissions are supersets of the below mask flags.
+ *
+ * The ACE4_READ_ATTRIBUTES and ACE4_READ_ACL flags are always granted
+ * in POSIX. The ACE4_SYNCHRONIZE flag has no meaning under POSIX. We
+ * make sure that we do not mask them if they are set, so that users who
+ * rely on these flags won't get confused.
+ */
+#define ACE4_GENERIC_READ ( \
+	ACE4_READ_DATA)
+#define ACE4_GENERIC_WRITE ( \
+	ACE4_WRITE_DATA | \
+	ACE4_APPEND_DATA | \
+	ACE4_DELETE_CHILD)
+#define ACE4_GENERIC_EXEC ( \
+	ACE4_EXECUTE)
+#define ACE4_ALWAYS_ALLOWED ( \
+	ACE4_SYNCHRONIZE | \
+	ACE4_READ_ATTRIBUTES | \
+	ACE4_READ_ACL )
+
+static int
+nfs4acl_mask_to_mode(unsigned int mask)
+{
+	int mode = 0;
+
+	if (mask & ACE4_GENERIC_READ)
+		mode |= MAY_READ;
+	if (mask & ACE4_GENERIC_WRITE)
+		mode |= MAY_WRITE;
+	if (mask & ACE4_GENERIC_EXEC)
+		mode |= MAY_EXEC;
+
+	return mode;
+}
+
+/**
+ * nfs4acl_masks_to_mode  -  compute file mode permission bits from file masks
+ *
+ * Compute the file mode permission bits from the file masks in the acl.
+ */
+int
+nfs4acl_masks_to_mode(struct nfs4acl *acl)
+{
+	return nfs4acl_mask_to_mode(acl->a_owner_mask) << 6 |
+	       nfs4acl_mask_to_mode(acl->a_group_mask) << 3 |
+	       nfs4acl_mask_to_mode(acl->a_other_mask);
+}
+EXPORT_SYMBOL_GPL(nfs4acl_masks_to_mode);
+
+static unsigned int
+nfs4acl_mode_to_mask(mode_t mode)
+{
+	unsigned int mask = 0;
+
+	if (mode & MAY_READ)
+		mask |= ACE4_ALWAYS_ALLOWED | ACE4_GENERIC_READ;
+	if (mode & MAY_WRITE)
+		mask |= ACE4_ALWAYS_ALLOWED | ACE4_GENERIC_WRITE;
+	if (mode & MAY_EXEC)
+		mask |= ACE4_ALWAYS_ALLOWED | ACE4_GENERIC_EXEC;
+
+	return mask;
+}
+
+/**
+ * nfs4acl_chmod  -  update the file masks to reflect the new mode
+ * @mode:	file mode permission bits to apply to the @acl
+ *
+ * Converts the mask flags corresponding to the owner, group, and other file
+ * permissions and updates the file masks in @acl accordingly.
+ */
+void
+nfs4acl_chmod(struct nfs4acl *acl, mode_t mode)
+{
+	acl->a_owner_mask = nfs4acl_mode_to_mask(mode >> 6);
+	acl->a_group_mask = nfs4acl_mode_to_mask(mode >> 3);
+	acl->a_other_mask = nfs4acl_mode_to_mask(mode);
+}
+EXPORT_SYMBOL_GPL(nfs4acl_chmod);
+
+/**
+ * nfs4acl_want_to_mask  - convert permission want argument to a mask
+ * @want:	@want argument of the permission inode operation
+ */
+static unsigned int
+nfs4acl_want_to_mask(int want)
+{
+	unsigned int mask = 0;
+
+	/**
+	 * FIXME: This needs more changes in the vfs so that the vfs
+	 * will ask the permission inode operations what it actually
+	 * wants to do.  Until then, we can only differentiate MAY_READ,
+	 * MAY_APPEND (for regular files), MAY_WRITE, and MAY_EXEC.
+	 */
+
+	if (want & MAY_READ)
+		mask |= ACE4_READ_DATA;
+	if (want & MAY_APPEND)
+		mask |= ACE4_APPEND_DATA;
+	else if (want & MAY_WRITE)
+		mask |= ACE4_WRITE_DATA;
+	if (want & MAY_EXEC)
+		mask |= ACE4_EXECUTE;
+
+	return mask;
+}
+
+/**
+ * __nfs4acl_permission  -  permission check algorithm without masking
+ * @inode:	inode to check permissions for
+ * @acl:	nfs4 acl if the inode
+ * @mask:	requested mask flags
+ * @in_group_class: returns if the process matches a group class acl entry
+ *
+ * Checks if the current process is granted @mask flags in @acl. The
+ * @inode determines the file type, current owner and owning group.
+ *
+ * In addition to checking permissions, this function checks if the
+ * process matches a group class acl entry even after the result of the
+ * permission check has been determined: for non-owners, this property
+ * determines which file mask applies to the acl.
+ */
+static int
+__nfs4acl_permission(struct inode *inode, const struct nfs4acl *acl,
+		     unsigned int mask, int *in_group_class)
+{
+	struct nfs4ace *ace;
+	int retval = -EACCES;
+
+	nfs4acl_for_each_entry(ace, acl) {
+		unsigned int ace_mask = ace->e_mask;
+
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+
+		/**
+		 * Check if the ACE matches the process. Remember when a
+		 * group class ACE matches the process.
+		 *
+		 * For ACEs other than OWNER@ and EVERYONE@, we apply the
+		 * file group mask: this would not strictly be necessary for
+		 * access checking, but it saves us from allowing accesses
+		 * that the ACL that nfs4acl_apply_masks() would deny:
+		 * otherwise, ACLs like 'group@:rw::allow' with mode 0600
+		 * would allow processes that match the owner and the
+		 * owning group rw access. This scenario cannot be expressed
+		 * as an ACL.
+		 */
+		if (nfs4ace_is_owner(ace)) {
+			if (current->fsuid != inode->i_uid)
+				continue;
+		} else if (nfs4ace_is_group(ace)) {
+			if (!in_group_p(inode->i_gid))
+				continue;
+			ace_mask &= acl->a_group_mask;
+			*in_group_class = 1;
+		} else if (nfs4ace_is_unix_id(ace)) {
+			if (ace->e_flags & ACE4_IDENTIFIER_GROUP) {
+				if (!in_group_p(ace->u.e_id))
+					continue;
+			} else {
+				if (current->fsuid != ace->u.e_id)
+					continue;
+			}
+			ace_mask &= acl->a_group_mask;
+			*in_group_class = 1;
+		} else if (!nfs4ace_is_everyone(ace))
+			continue;
+
+		/* Check which mask flags the ACE allows or denies. */
+		if (nfs4ace_is_allow(ace)) {
+			if (!S_ISDIR(inode->i_mode)) {
+				/* Everybody who is allowed ACE4_WRITE_DATA is
+				   also allowed ACE4_APPEND_DATA. */
+				if (ace_mask & ACE4_WRITE_DATA)
+					ace_mask |= ACE4_APPEND_DATA;
+			}
+			mask &= ~ace_mask;
+			if (mask == 0) {
+				retval = 0;
+				goto check_remaining_aces;
+			}
+		} else if (nfs4ace_is_deny(ace)) {
+			unsigned int ace_mask = ace->e_mask;
+
+			if (!S_ISDIR(inode->i_mode)) {
+				/* Everybody who is denied ACE4_APPEND_DATA is
+				   also denied ACE4_WRITE_DATA. */
+				if (ace_mask & ACE4_APPEND_DATA)
+					ace_mask |= ACE4_WRITE_DATA;
+			}
+			if (mask & ace_mask)
+				goto check_remaining_aces;
+		}
+	}
+	return retval;
+
+check_remaining_aces:
+	/* Check if any of the remaining group class ACEs match the process. */
+	for (ace++; ace != acl->a_entries + acl->a_count; ace++) {
+		if (nfs4ace_is_group(ace)) {
+			if (in_group_p(inode->i_gid))
+				*in_group_class = 1;
+		} else if (nfs4ace_is_unix_id(ace)) {
+			if (ace->e_flags & ACE4_IDENTIFIER_GROUP) {
+				if (in_group_p(ace->u.e_id))
+					*in_group_class = 1;
+			} else {
+				if (current->fsuid == ace->u.e_id)
+					*in_group_class = 1;
+			}
+		}
+	}
+	return retval;
+}
+
+/**
+ * nfs4acl_permission  -  permission check algorithm with masking
+ * @inode:	inode to check permissions for
+ * @acl:	nfs4 acl if the inode
+ * @want:	requested access (permission want argument)
+ * @write_through: assume that the masks "writes through" to the acl
+ *
+ * Checks if the current process is granted @mask flags in @acl. If
+ * @write_through is true, then the OWNER@ is always granted the owner
+ * mask, the GROUP@ is always granted the group mask, and EVERYONE@ is
+ * always granted the other mask. Otherwise, the OWNER@, GROUP@, and
+ * EVERYONE@ are only granted mask flags which they are granted both in
+ * the @acl and in the file mask that applies to the process (which
+ * depends on which file class the process is in).
+ */
+int
+nfs4acl_permission(struct inode *inode, const struct nfs4acl *acl, int want,
+		   int write_through)
+{
+	unsigned int mask = nfs4acl_want_to_mask(want);
+	int in_group_class = 0, error;
+
+	error = __nfs4acl_permission(inode, acl, mask, &in_group_class);
+	if (write_through) {
+		if (current->fsuid == inode->i_uid ||
+		    in_group_p(inode->i_gid) ||
+		    !in_group_class)
+			error = 0;  /* only check the mask */
+	}
+	if (error)
+		goto capability_check;
+	if (current->fsuid == inode->i_uid) {
+		if (mask & ~acl->a_owner_mask)
+			goto capability_check;
+	} else if (in_group_p(inode->i_gid) || in_group_class) {
+		if (mask & ~acl->a_group_mask)
+			goto capability_check;
+	} else {
+		if (mask & ~acl->a_other_mask)
+			goto capability_check;
+	}
+	return 0;
+
+capability_check:
+	/*
+	 * Read/write DACs are always overridable.
+	 * Executable DACs are overridable if at least one exec bit is set.
+	 */
+	if (!(want & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+
+	/*
+	 * Searching includes executable on directories, else just read.
+	 */
+	if (want == MAY_READ || (S_ISDIR(inode->i_mode) && !(want & MAY_WRITE)))
+		if (capable(CAP_DAC_READ_SEARCH))
+			return 0;
+	return -EACCES;
+
+}
+EXPORT_SYMBOL_GPL(nfs4acl_permission);
+
+/**
+ * nfs4ace_is_same_who  -  do both acl entries refer to the same identifier?
+ */
+int
+nfs4ace_is_same_who(struct nfs4ace *a, struct nfs4ace *b)
+{
+#define WHO_FLAGS (ACE4_SPECIAL_WHO | ACE4_IDENTIFIER_GROUP)
+	if ((a->e_flags & WHO_FLAGS) != (b->e_flags & WHO_FLAGS))
+		return 0;
+	if (a->e_flags & ACE4_SPECIAL_WHO)
+		return a->u.e_who == b->u.e_who;
+	else
+		return a->u.e_id == b->u.e_id;
+#undef WHO_FLAGS
+}
+
+/**
+ * nfs4acl_allowed_to_who  -  mask flags allowed to a specific who value
+ *
+ * Computes the mask values allowed to a specific who value, taking
+ * EVERYONE@ entries into account.
+ */
+static unsigned int
+nfs4acl_allowed_to_who(struct nfs4acl *acl, struct nfs4ace *who)
+{
+	struct nfs4ace *ace;
+	unsigned int allowed = 0;
+
+	nfs4acl_for_each_entry_reverse(ace, acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_same_who(ace, who) ||
+		    nfs4ace_is_everyone(ace)) {
+			if (nfs4ace_is_allow(ace))
+				allowed |= ace->e_mask;
+			else if (nfs4ace_is_deny(ace))
+				allowed &= ~ace->e_mask;
+		}
+	}
+	return allowed;
+}
+
+/**
+ * nfs4acl_compute_max_masks  -  compute upper bound masks
+ *
+ * Computes upper bound owner, group, and other masks so that none of
+ * the mask flags allowed by the acl are disabled (for any choice of the
+ * file owner or group membership).
+ */
+static void
+nfs4acl_compute_max_masks(struct nfs4acl *acl)
+{
+	struct nfs4ace *ace;
+
+	acl->a_owner_mask = 0;
+	acl->a_group_mask = 0;
+	acl->a_other_mask = 0;
+
+	nfs4acl_for_each_entry_reverse(ace, acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+
+		if (nfs4ace_is_owner(ace)) {
+			if (nfs4ace_is_allow(ace))
+				acl->a_owner_mask |= ace->e_mask;
+			else if (nfs4ace_is_deny(ace))
+				acl->a_owner_mask &= ~ace->e_mask;
+		} else if (nfs4ace_is_everyone(ace)) {
+			if (nfs4ace_is_allow(ace)) {
+				struct nfs4ace who = {
+					.e_flags = ACE4_SPECIAL_WHO,
+					.u.e_who = nfs4ace_group_who,
+				};
+
+				acl->a_other_mask |= ace->e_mask;
+				acl->a_group_mask |=
+					nfs4acl_allowed_to_who(acl, &who);
+				acl->a_owner_mask |= ace->e_mask;
+			} else if (nfs4ace_is_deny(ace)) {
+				acl->a_other_mask &= ~ace->e_mask;
+				acl->a_group_mask &= ~ace->e_mask;
+				acl->a_owner_mask &= ~ace->e_mask;
+			}
+		} else {
+			if (nfs4ace_is_allow(ace)) {
+				unsigned int mask =
+					nfs4acl_allowed_to_who(acl, ace);
+
+				acl->a_group_mask |= mask;
+				acl->a_owner_mask |= mask;
+			}
+		}
+	}
+}
+
+/**
+ * nfs4acl_inherit  -  compute the acl a new file will inherit
+ * @dir_acl:	acl of the containing direcory
+ * @mode:	file type and create mode of the new file
+ * @write_through: assume that the mode "writes through" to the acl
+ *
+ * Given the containing directory's acl, this function will compute the
+ * acl that new files in that directory will inherit, or %NULL if
+ * @dir_acl does not contain acl entries inheritable by this file.
+ *
+ * Without @write_through, the file masks in the returned acl are set to
+ * the intersection of the create mode and the maximum permissions
+ * allowed to each file class. With @write_through, the file masks are
+ * set to the create mode.
+ */
+struct nfs4acl *
+nfs4acl_inherit(struct nfs4acl *dir_acl, mode_t mode, int write_through)
+{
+	struct nfs4ace *dir_ace;
+	struct nfs4acl *acl;
+	struct nfs4ace *ace;
+	int count = 0;
+
+	if (S_ISDIR(mode)) {
+		nfs4acl_for_each_entry(dir_ace, dir_acl) {
+			if (!nfs4ace_is_inheritable(dir_ace))
+				continue;
+			count++;
+		}
+		if (!count)
+			return NULL;
+		acl = nfs4acl_alloc(count);
+		if (!acl)
+			return ERR_PTR(-ENOMEM);
+		ace = acl->a_entries;
+		nfs4acl_for_each_entry(dir_ace, dir_acl) {
+			if (!nfs4ace_is_inheritable(dir_ace))
+				continue;
+			memcpy(ace, dir_ace, sizeof(struct nfs4ace));
+			if (dir_ace->e_flags & ACE4_NO_PROPAGATE_INHERIT_ACE)
+				nfs4ace_clear_inheritance_flags(ace);
+			if ((dir_ace->e_flags & ACE4_FILE_INHERIT_ACE) &&
+			    !(dir_ace->e_flags & ACE4_DIRECTORY_INHERIT_ACE))
+				ace->e_flags |= ACE4_INHERIT_ONLY_ACE;
+			ace++;
+		}
+	} else {
+		nfs4acl_for_each_entry(dir_ace, dir_acl) {
+			if (!(dir_ace->e_flags & ACE4_FILE_INHERIT_ACE))
+				continue;
+			count++;
+		}
+		if (!count)
+			return NULL;
+		acl = nfs4acl_alloc(count);
+		if (!acl)
+			return ERR_PTR(-ENOMEM);
+		ace = acl->a_entries;
+		nfs4acl_for_each_entry(dir_ace, dir_acl) {
+			if (!(dir_ace->e_flags & ACE4_FILE_INHERIT_ACE))
+				continue;
+			memcpy(ace, dir_ace, sizeof(struct nfs4ace));
+			nfs4ace_clear_inheritance_flags(ace);
+			ace++;
+		}
+	}
+
+	/* The maximum max flags that the owner, group, and other classes
+	   are allowed. */
+	if (write_through) {
+		acl->a_owner_mask = ACE4_VALID_MASK;
+		acl->a_group_mask = ACE4_VALID_MASK;
+		acl->a_other_mask = ACE4_VALID_MASK;
+
+		mode &= ~current->fs->umask;
+	} else
+		nfs4acl_compute_max_masks(acl);
+
+	/* Apply the create mode. */
+	acl->a_owner_mask &= nfs4acl_mode_to_mask(mode >> 6);
+	acl->a_group_mask &= nfs4acl_mode_to_mask(mode >> 3);
+	acl->a_other_mask &= nfs4acl_mode_to_mask(mode);
+
+	return acl;
+}
+EXPORT_SYMBOL_GPL(nfs4acl_inherit);
Index: linux-2.6.18-rc6/fs/nfs4acl_compat.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/fs/nfs4acl_compat.c
@@ -0,0 +1,743 @@
+/*
+ * Copyright (C) 2006 Andreas Gruenbacher <a.gruenbacher@computer.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/nfs4acl.h>
+
+/**
+ * struct nfs4acl_alloc  -  remember how many entries are actually allocated
+ * @acl:	acl with a_count <= @count
+ * @count:	the actual number of entries allocated in @acl
+ *
+ * We pass around this structure while modifying an acl, so that we do
+ * not have to reallocate when we remove existing entries followed by
+ * adding new entries.
+ */
+struct nfs4acl_alloc {
+	struct nfs4acl *acl;
+	unsigned int count;
+};
+
+/**
+ * nfs4acl_delete_entry  -  delete an entry in an acl
+ * @x:		acl and number of allocated entries
+ * @ace:	an entry in @x->acl
+ *
+ * Updates @ace so that it points to the entry before the deleted entry
+ * on return. (When deleting the first entry, @ace will point to the
+ * (non-existant) entry before the first entry). This behavior is the
+ * expected behavior when deleting entries while forward iterating over
+ * an acl.
+ */
+static void
+nfs4acl_delete_entry(struct nfs4acl_alloc *x, struct nfs4ace **ace)
+{
+	void *end = x->acl->a_entries + x->acl->a_count;
+
+	memmove(*ace, *ace + 1, end - (void *)(*ace + 1));
+	(*ace)--;
+	x->acl->a_count--;
+}
+
+/**
+ * nfs4acl_insert_entry  -  insert an entry in an acl
+ * @x:		acl and number of allocated entries
+ * @ace:	entry before which the new entry shall be inserted
+ *
+ * Insert a new entry in @x->acl at position @ace, and zero-initialize
+ * it.  This may require reallocating @x->acl.
+ */
+static int
+nfs4acl_insert_entry(struct nfs4acl_alloc *x, struct nfs4ace **ace)
+{
+	if (x->count == x->acl->a_count) {
+		int n = *ace - x->acl->a_entries;
+		struct nfs4acl *acl2;
+
+		acl2 = nfs4acl_alloc(x->acl->a_count + 1);
+		if (!acl2)
+			return -ENOMEM;
+		acl2->a_owner_mask = x->acl->a_owner_mask;
+		acl2->a_group_mask = x->acl->a_group_mask;
+		acl2->a_other_mask = x->acl->a_other_mask;
+		memcpy(acl2->a_entries, x->acl->a_entries,
+		       n * sizeof(struct nfs4ace));
+		memcpy(acl2->a_entries + n + 1, *ace,
+		       (x->acl->a_count - n) * sizeof(struct nfs4ace));
+		kfree(x->acl);
+		x->acl = acl2;
+		x->count = acl2->a_count;
+		*ace = acl2->a_entries + n;
+	} else {
+		void *end = x->acl->a_entries + x->acl->a_count;
+
+		memmove(*ace + 1, *ace, end - (void *)*ace);
+		x->acl->a_count++;
+	}
+	memset(*ace, 0, sizeof(struct nfs4ace));
+	return 0;
+}
+
+/**
+ * nfs4ace_change_mask  -  change the mask in @ace to @mask
+ * @x:		acl and number of allocated entries
+ * @ace:	entry to modify
+ * @mask:	new mask for @ace
+ *
+ * Set the effective mask of @ace to @mask. This will require splitting
+ * off a separate acl entry if @ace is inheritable. In that case, the
+ * effective- only acl entry is inserted after the inheritable acl
+ * entry, end the inheritable acl entry is set to inheritable-only. If
+ * @mode is 0, either set the original acl entry to inheritable-only if
+ * it was inheritable, or remove it otherwise.  The returned @ace points
+ * to the modified or inserted effective-only acl entry if that entry
+ * exists, to the entry that has become inheritable-only, or else to the
+ * previous entry in the acl. This is the expected behavior when
+ * modifying masks while forward iterating over an acl.
+ */
+static int
+nfs4ace_change_mask(struct nfs4acl_alloc *x, struct nfs4ace **ace,
+			   unsigned int mask)
+{
+	if (mask && (*ace)->e_mask == mask)
+		return 0;
+	if (mask == 0) {
+		if (nfs4ace_is_inheritable(*ace))
+			(*ace)->e_flags |= ACE4_INHERIT_ONLY_ACE;
+		else
+			nfs4acl_delete_entry(x, ace);
+	} else {
+		if (nfs4ace_is_inheritable(*ace)) {
+			if (nfs4acl_insert_entry(x, ace))
+				return -ENOMEM;
+			memcpy(*ace, *ace + 1, sizeof(struct nfs4ace));
+			(*ace)->e_flags |= ACE4_INHERIT_ONLY_ACE;
+			(*ace)++;
+			nfs4ace_clear_inheritance_flags(*ace);
+		}
+		(*ace)->e_mask = mask;
+	}
+	return 0;
+}
+
+/**
+ * nfs4acl_move_everyone_aces_down  -  move everyone@ acl entries to the end
+ * @x:		acl and number of allocated entries
+ *
+ * Move all everyone acl entries to the bottom of the acl so that only a
+ * single everyone@ allow acl entry remains at the end, and update the
+ * mask fields of all acl entries on the way. If everyone@ is not
+ * granted any permissions, no empty everyone@ acl entry is inserted.
+ *
+ * This transformation does not modify the permissions that the acl
+ * grants, but we need it to simplify successive transformations.
+ */
+static int
+nfs4acl_move_everyone_aces_down(struct nfs4acl_alloc *x)
+{
+	struct nfs4ace *ace;
+	unsigned int allowed = 0, denied = 0;
+
+	nfs4acl_for_each_entry(ace, x->acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_everyone(ace)) {
+			if (nfs4ace_is_allow(ace))
+				allowed |= (ace->e_mask & ~denied);
+			else if (nfs4ace_is_deny(ace))
+				denied |= (ace->e_mask & ~allowed);
+			else
+				continue;
+			if (nfs4ace_change_mask(x, &ace, 0))
+				return -ENOMEM;
+		} else {
+			if (nfs4ace_is_allow(ace)) {
+				if (nfs4ace_change_mask(x, &ace, allowed |
+						(ace->e_mask & ~denied)))
+					return -ENOMEM;
+			} else if (nfs4ace_is_deny(ace)) {
+				if (nfs4ace_change_mask(x, &ace, denied |
+						(ace->e_mask & ~allowed)))
+					return -ENOMEM;
+			}
+		}
+	}
+	if (allowed) {
+		if (nfs4acl_insert_entry(x, &ace))
+			return -ENOMEM;
+		ace->e_type = ACE4_ACCESS_ALLOWED_ACE_TYPE;
+		ace->e_flags = ACE4_SPECIAL_WHO;
+		ace->e_mask = allowed;
+		ace->u.e_who = nfs4ace_everyone_who;
+	}
+	return 0;
+}
+
+/**
+ * __nfs4acl_propagate_everyone  -  propagate everyone@ mask flags up for @who
+ * @x:		acl and number of allocated entries
+ * @who:	identifier to propagate mask flags for
+ * @allow:	mask flags to propagate up
+ *
+ * Propagate mask flags from the trailing everyone@ allow acl entry up
+ * for the specified @who.
+ *
+ * The idea here is to precede the trailing EVERYONE@ ALLOW entry by an
+ * additional @who ALLOW entry, but with the following optimizations:
+ * (1) we don't bother setting any flags in the new @who ALLOW entry
+ * that has already been allowed or denied by a previous @who entry, (2)
+ * we merge the new @who entry with a previous @who entry if there is
+ * such a previous @who entry and there are no intervening DENY entries
+ * with mask flags that overlap the flags we care about.
+ */
+static int
+__nfs4acl_propagate_everyone(struct nfs4acl_alloc *x, struct nfs4ace *who,
+			  unsigned int allow)
+{
+	struct nfs4ace *allow_last = NULL, *ace;
+
+	/* Remove the mask flags from allow that are already determined for
+	   this who value, and figure out if there is an ALLOW entry for
+	   this who value that is "reachable" from the trailing EVERYONE@
+	   ALLOW ACE. */
+	nfs4acl_for_each_entry(ace, x->acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_allow(ace)) {
+			if (nfs4ace_is_same_who(ace, who)) {
+				allow &= ~ace->e_mask;
+				allow_last = ace;
+			}
+		} else if (nfs4ace_is_deny(ace)) {
+			if (nfs4ace_is_same_who(ace, who))
+				allow &= ~ace->e_mask;
+			if (allow & ace->e_mask)
+				allow_last = NULL;
+		}
+	}
+
+	if (allow) {
+		if (allow_last)
+			return nfs4ace_change_mask(x, &allow_last,
+						   allow_last->e_mask | allow);
+		else {
+			struct nfs4ace who_copy;
+
+			ace = x->acl->a_entries + x->acl->a_count - 1;
+			memcpy(&who_copy, who, sizeof(struct nfs4ace));
+			if (nfs4acl_insert_entry(x, &ace))
+				return -ENOMEM;
+			memcpy(ace, &who_copy, sizeof(struct nfs4ace));
+			ace->e_type = ACE4_ACCESS_ALLOWED_ACE_TYPE;
+			nfs4ace_clear_inheritance_flags(ace);
+			ace->e_mask = allow;
+		}
+	}
+	return 0;
+}
+
+/**
+ * nfs4acl_propagate_everyone  -  propagate everyone@ mask flags up the acl
+ * @x:		acl and number of allocated entries
+ *
+ * Make sure for owner@, group@, and all other users, groups, and
+ * special identifiers that they are allowed or denied all permissions
+ * that are granted be the trailing everyone@ acl entry. If they are
+ * not, try to add the missing permissions to existing allow acl entries
+ * for those users, or introduce additional acl entries if that is not
+ * possible.
+ *
+ * We do this so that no mask flags will get lost when finally applying
+ * the file masks to the acl entries: otherwise, with an other file mask
+ * that is more restrictive than the owner and/or group file mask, mask
+ * flags that were allowed to processes in the owner and group classes
+ * and that the other mask denies would be lost. For example, the
+ * following two acls show the problem when mode 0664 is applied to
+ * them:
+ *
+ *    masking without propagation (wrong)
+ *    ===========================================================
+ *    joe:r::allow		=> joe:r::allow
+ *    everyone@:rwx::allow	=> everyone@:r::allow
+ *    -----------------------------------------------------------
+ *    joe:w::deny		=> joe:w::deny
+ *    everyone@:rwx::allow	   everyone@:r::allow
+ *
+ * Note that the permissions of joe end up being more restrictive than
+ * what the acl would allow when first computing the allowed flags and
+ * then applying the respective mask. With propagation of permissions,
+ * we get:
+ *
+ *    masking after propagation (correct)
+ *    ===========================================================
+ *    joe:r::allow		=> joe:rw::allow
+ *				   owner@:rw::allow
+ *				   group@:rw::allow
+ *    everyone@:rwx::allow	   everyone@:r::allow
+ *    -----------------------------------------------------------
+ *    joe:w::deny		=> owner@:x::deny
+ *				   joe:w::deny
+ *				   owner@:rw::allow
+ *				   owner@:rw::allow
+ *				   joe:r::allow
+ *    everyone@:rwx::allow	   everyone@:r::allow
+ *
+ * The examples show the acls that would result from propagation with no
+ * masking performed. In fact, we do apply the respective mask to the
+ * acl entries before computing the propagation because this will save
+ * us from adding acl entries that would end up with empty mask fields
+ * after applying the masks.
+ *
+ * It is ensured that no more than one entry will be inserted for each
+ * who value, no matter how many entries each who value has already.
+ */
+static int
+nfs4acl_propagate_everyone(struct nfs4acl_alloc *x, int write_through)
+{
+	struct nfs4ace who = { .e_flags = ACE4_SPECIAL_WHO };
+	struct nfs4ace *ace;
+	unsigned int owner_allow, group_allow;
+	int error;
+
+	if (!((x->acl->a_owner_mask | x->acl->a_group_mask) &
+	      ~x->acl->a_other_mask))
+		return 0;
+	if (!x->acl->a_count)
+		return 0;
+	ace = x->acl->a_entries + x->acl->a_count - 1;
+	if (nfs4ace_is_inherit_only(ace) || !nfs4ace_is_everyone(ace))
+		return 0;
+	if (!(ace->e_mask & ~x->acl->a_other_mask)) {
+		/* None of the allowed permissions will get masked. */
+		return 0;
+	}
+	owner_allow = ace->e_mask & x->acl->a_owner_mask;
+	group_allow = ace->e_mask & x->acl->a_group_mask;
+
+	/* Propagate everyone@ permissions through to owner@. */
+	if (owner_allow && !write_through &&
+	    (x->acl->a_owner_mask & ~x->acl->a_other_mask)) {
+		who.u.e_who = nfs4ace_owner_who;
+		error = __nfs4acl_propagate_everyone(x, &who, owner_allow);
+		if (error)
+			return -ENOMEM;
+	}
+
+	if (group_allow && (x->acl->a_group_mask & ~x->acl->a_other_mask)) {
+		int n;
+
+		if (!write_through) {
+			/* Propagate everyone@ permissions through to group@. */
+			who.u.e_who = nfs4ace_group_who;
+			error = __nfs4acl_propagate_everyone(x, &who,
+							     group_allow);
+			if (error)
+				return -ENOMEM;
+		}
+
+		/* Start from the entry before the trailing EVERYONE@ ALLOW
+		   entry. We will not hit EVERYONE@ entries in the loop. */
+		for (n = x->acl->a_count - 2; n != -1; n--) {
+			ace = x->acl->a_entries + n;
+
+			if (nfs4ace_is_inherit_only(ace) ||
+			    nfs4ace_is_owner(ace) ||
+			    nfs4ace_is_group(ace))
+				continue;
+			if (nfs4ace_is_allow(ace) || nfs4ace_is_deny(ace)) {
+				/* Any inserted entry will end up below the
+				   current entry. */
+				error = __nfs4acl_propagate_everyone(x, ace,
+								   group_allow);
+				if (error)
+					return -ENOMEM;
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * __nfs4acl_apply_masks  -  apply the masks to the acl entries
+ * @x:		acl and number of allocated entries
+ *
+ * Apply the owner file mask to owner@ entries, the intersection of the
+ * group and other file masks to everyone@ entries, and the group file
+ * mask to all other entries.
+ */
+static int
+__nfs4acl_apply_masks(struct nfs4acl_alloc *x)
+{
+	struct nfs4ace *ace;
+
+	nfs4acl_for_each_entry(ace, x->acl) {
+		unsigned int mask;
+
+		if (nfs4ace_is_inherit_only(ace) || !nfs4ace_is_allow(ace))
+			continue;
+		if (nfs4ace_is_owner(ace))
+			mask = x->acl->a_owner_mask;
+		else if (nfs4ace_is_everyone(ace))
+			mask = x->acl->a_other_mask;
+		else
+			mask = x->acl->a_group_mask;
+		if (nfs4ace_change_mask(x, &ace, ace->e_mask & mask))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/**
+ * nfs4acl_max_allowed  -  maximum mask flags that anybody is allowed
+ */
+static unsigned int
+nfs4acl_max_allowed(struct nfs4acl *acl)
+{
+	struct nfs4ace *ace;
+	unsigned int allowed = 0;
+
+	nfs4acl_for_each_entry_reverse(ace, acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_allow(ace))
+			allowed |= ace->e_mask;
+		else if (nfs4ace_is_deny(ace)) {
+			if (nfs4ace_is_everyone(ace))
+				allowed &= ~ace->e_mask;
+		}
+	}
+	return allowed;
+}
+
+/**
+ * nfs4acl_isolate_owner_class  -  limit the owner class to the owner file mask
+ * @x:		acl and number of allocated entries
+ *
+ * Make sure the owner class (owner@) is granted no more than the owner
+ * mask by first checking which permissions anyone is granted, and then
+ * denying owner@ all permissions beyond that.
+ */
+static int
+nfs4acl_isolate_owner_class(struct nfs4acl_alloc *x)
+{
+	struct nfs4ace *ace;
+	unsigned int allowed = 0;
+
+	allowed = nfs4acl_max_allowed(x->acl);
+	if (allowed & ~x->acl->a_owner_mask) {
+		/* Figure out if we can update an existig OWNER@ DENY entry. */
+		nfs4acl_for_each_entry(ace, x->acl) {
+			if (nfs4ace_is_inherit_only(ace))
+				continue;
+			if (nfs4ace_is_deny(ace)) {
+				if (nfs4ace_is_owner(ace))
+					break;
+			} else if (nfs4ace_is_allow(ace)) {
+				ace = x->acl->a_entries + x->acl->a_count;
+				break;
+			}
+		}
+		if (ace != x->acl->a_entries + x->acl->a_count) {
+			if (nfs4ace_change_mask(x, &ace, ace->e_mask |
+					(allowed & ~x->acl->a_owner_mask)))
+				return -ENOMEM;
+		} else {
+			/* Insert an owner@ deny entry at the front. */
+			ace = x->acl->a_entries;
+			if (nfs4acl_insert_entry(x, &ace))
+				return -ENOMEM;
+			ace->e_type = ACE4_ACCESS_DENIED_ACE_TYPE;
+			ace->e_flags = ACE4_SPECIAL_WHO;
+			ace->e_mask = allowed & ~x->acl->a_owner_mask;
+			ace->u.e_who = nfs4ace_owner_who;
+		}
+	}
+	return 0;
+}
+
+/**
+ * __nfs4acl_isolate_who  -  isolate entry from EVERYONE@ ALLOW entry
+ * @x:		acl and number of allocated entries
+ * @who:	identifier to isolate
+ * @deny:	mask flags this identifier should not be allowed
+ *
+ * Make sure that @who is not allowed any mask flags in @deny by checking
+ * which mask flags this identifier is allowed, and adding excess allowed
+ * mask flags to an existing DENY entry before the trailing EVERYONE@ ALLOW
+ * entry, or inserting such an entry.
+ */
+static int
+__nfs4acl_isolate_who(struct nfs4acl_alloc *x, struct nfs4ace *who,
+		      unsigned int deny)
+{
+	struct nfs4ace *ace;
+	unsigned int allowed = 0, n;
+
+	/* Compute the mask flags granted to this who value. */
+	nfs4acl_for_each_entry_reverse(ace, x->acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_same_who(ace, who)) {
+			if (nfs4ace_is_allow(ace))
+				allowed |= ace->e_mask;
+			else if (nfs4ace_is_deny(ace))
+				allowed &= ~ace->e_mask;
+			deny &= ~ace->e_mask;
+		}
+	}
+	if (!deny)
+		return 0;
+
+	/* Figure out if we can update an existig DENY entry.  Start
+	   from the entry before the trailing EVERYONE@ ALLOW entry. We
+	   will not hit EVERYONE@ entries in the loop. */
+	for (n = x->acl->a_count - 2; n != -1; n--) {
+		ace = x->acl->a_entries + n;
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_deny(ace)) {
+			if (nfs4ace_is_same_who(ace, who))
+				break;
+		} else if (nfs4ace_is_allow(ace) &&
+			   (ace->e_mask & deny)) {
+			n = -1;
+			break;
+		}
+	}
+	if (n != -1) {
+		if (nfs4ace_change_mask(x, &ace, ace->e_mask | deny))
+			return -ENOMEM;
+	} else {
+		/* Insert a eny entry before the trailing EVERYONE@ DENY
+		   entry. */
+		struct nfs4ace who_copy;
+
+		ace = x->acl->a_entries + x->acl->a_count - 1;
+		memcpy(&who_copy, who, sizeof(struct nfs4ace));
+		if (nfs4acl_insert_entry(x, &ace))
+			return -ENOMEM;
+		memcpy(ace, &who_copy, sizeof(struct nfs4ace));
+		ace->e_type = ACE4_ACCESS_DENIED_ACE_TYPE;
+		nfs4ace_clear_inheritance_flags(ace);
+		ace->e_mask = deny;
+	}
+	return 0;
+}
+
+/**
+ * nfs4acl_isolate_group_class  -  limit the group class to the group file mask
+ * @x:		acl and number of allocated entries
+ *
+ * Make sure the group class (all entries except owner@ and everyone@) is
+ * granted no more than the group mask by inserting DENY entries for group
+ * class entries where necessary.
+ */
+static int
+nfs4acl_isolate_group_class(struct nfs4acl_alloc *x)
+{
+	struct nfs4ace who = {
+		.e_flags = ACE4_SPECIAL_WHO,
+		.u.e_who = nfs4ace_group_who,
+	};
+	struct nfs4ace *ace;
+	unsigned int deny;
+
+	if (!x->acl->a_count)
+		return 0;
+	ace = x->acl->a_entries + x->acl->a_count - 1;
+	if (nfs4ace_is_inherit_only(ace) || !nfs4ace_is_everyone(ace))
+		return 0;
+	deny = ace->e_mask & ~x->acl->a_group_mask;
+
+	if (deny) {
+		unsigned int n;
+
+		if (__nfs4acl_isolate_who(x, &who, deny))
+			return -ENOMEM;
+
+		/* Start from the entry before the trailing EVERYONE@ ALLOW
+		   entry. We will not hit EVERYONE@ entries in the loop. */
+		for (n = x->acl->a_count - 2; n != -1; n--) {
+			ace = x->acl->a_entries + n;
+
+			if (nfs4ace_is_inherit_only(ace) ||
+			    nfs4ace_is_owner(ace) ||
+			    nfs4ace_is_group(ace))
+				continue;
+			if (__nfs4acl_isolate_who(x, ace, deny))
+				return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/**
+ * nfs4acl_write_through  -  grant the full masks to owner@, group@, everyone@
+ *
+ * Make sure that owner, group@, and everyone@ are allowed the full mask
+ * permissions, and not only the permissions granted both by the acl and
+ * the masks.
+ */
+static int
+nfs4acl_write_through(struct nfs4acl_alloc *x)
+{
+	struct nfs4ace *ace;
+	unsigned int allowed;
+
+	/* Remove all owner@ and group@ ACEs: we re-insert them at the
+	   top. */
+	nfs4acl_for_each_entry(ace, x->acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if ((nfs4ace_is_owner(ace) || nfs4ace_is_group(ace)) &&
+		    nfs4ace_change_mask(x, &ace, 0))
+			return -ENOMEM;
+	}
+
+	/* Insert the everyone@ allow entry at the end, or update the
+	   existing entry. */
+	allowed = x->acl->a_other_mask;
+	if (allowed) {
+		ace = x->acl->a_entries + x->acl->a_count - 1;
+		if (x->acl->a_count && nfs4ace_is_everyone(ace) &&
+		    !nfs4ace_is_inherit_only(ace)) {
+			if (nfs4ace_change_mask(x, &ace, allowed))
+				return -ENOMEM;
+		} else {
+			ace = x->acl->a_entries + x->acl->a_count;
+			if (nfs4acl_insert_entry(x, &ace))
+				return -ENOMEM;
+			ace->e_type = ACE4_ACCESS_ALLOWED_ACE_TYPE;
+			ace->e_flags = ACE4_SPECIAL_WHO;
+			ace->e_mask = allowed;
+			ace->u.e_who = nfs4ace_everyone_who;
+		}
+	}
+
+	/* Compute the permissions that owner@ and group@ are already granted
+	   though the everyone@ allow entry at the end. Note that the acl
+	   contains no owner@ or group@ entries at this point. */
+	allowed = 0;
+	nfs4acl_for_each_entry_reverse(ace, x->acl) {
+		if (nfs4ace_is_inherit_only(ace))
+			continue;
+		if (nfs4ace_is_allow(ace)) {
+			if (nfs4ace_is_everyone(ace))
+				allowed |= ace->e_mask;
+		} else if (nfs4ace_is_deny(ace))
+				allowed &= ~ace->e_mask;
+	}
+
+	/* Insert the appropriate group@ allow entry at the front. */
+	if (x->acl->a_group_mask & ~allowed) {
+		ace = x->acl->a_entries;
+		if (nfs4acl_insert_entry(x, &ace))
+			return -ENOMEM;
+		ace->e_type = ACE4_ACCESS_ALLOWED_ACE_TYPE;
+		ace->e_flags = ACE4_SPECIAL_WHO;
+		ace->e_mask = x->acl->a_group_mask /*& ~allowed*/;
+		ace->u.e_who = nfs4ace_group_who;
+	}
+
+	/* Insert the appropriate owner@ allow entry at the front. */
+	if (x->acl->a_owner_mask & ~allowed) {
+		ace = x->acl->a_entries;
+		if (nfs4acl_insert_entry(x, &ace))
+			return -ENOMEM;
+		ace->e_type = ACE4_ACCESS_ALLOWED_ACE_TYPE;
+		ace->e_flags = ACE4_SPECIAL_WHO;
+		ace->e_mask = x->acl->a_owner_mask /*& ~allowed*/;
+		ace->u.e_who = nfs4ace_owner_who;
+	}
+
+	/* Insert the appropriate owner@ deny entry at the front. */
+	allowed = nfs4acl_max_allowed(x->acl);
+	if (allowed & ~x->acl->a_owner_mask) {
+		nfs4acl_for_each_entry(ace, x->acl) {
+			if (nfs4ace_is_inherit_only(ace))
+				continue;
+			if (nfs4ace_is_allow(ace)) {
+				ace = x->acl->a_entries + x->acl->a_count;
+				break;
+			}
+			if (nfs4ace_is_deny(ace) && nfs4ace_is_owner(ace))
+				break;
+		}
+		if (ace != x->acl->a_entries + x->acl->a_count) {
+			if (nfs4ace_change_mask(x, &ace, ace->e_mask |
+					(allowed & ~x->acl->a_owner_mask)))
+				return -ENOMEM;
+		} else {
+			ace = x->acl->a_entries;
+			if (nfs4acl_insert_entry(x, &ace))
+				return -ENOMEM;
+			ace->e_type = ACE4_ACCESS_DENIED_ACE_TYPE;
+			ace->e_flags = ACE4_SPECIAL_WHO;
+			ace->e_mask = allowed & ~x->acl->a_owner_mask;
+			ace->u.e_who = nfs4ace_owner_who;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * nfs4acl_apply_masks  -  apply the masks to the acl
+ *
+ * Apply the masks so that the acl allows no more flags than the
+ * intersection between the flags that the original acl allows and the
+ * mask matching the process.
+ *
+ * With @write_through, change the acl so that the owner@, group@, and
+ * everyone@ are always granted the full owner, group, and other masks,
+ * respectively.
+ *
+ * In any case, the resulting acl will allow no more permissions to
+ * the other class (everyone@) than to the group class. This restriction
+ * allows us to avoid inserting a variable number of deny entries for
+ * each group class identifier before the final everyone@ allow entry.
+ *
+ * Note: this algorithm may push the number of entries in the acl above
+ * ACL4_XATTR_MAX_COUNT, so a read-modify-write cycle would fail.
+ */
+int
+nfs4acl_apply_masks(struct nfs4acl **acl, int write_through)
+{
+	struct nfs4acl_alloc x = {
+		.acl = *acl,
+		.count = (*acl)->a_count,
+	};
+
+	if (nfs4acl_move_everyone_aces_down(&x) ||
+	    nfs4acl_propagate_everyone(&x, write_through) ||
+	    __nfs4acl_apply_masks(&x))
+		goto out_enomem;
+	if (write_through) {
+		if (nfs4acl_write_through(&x) ||
+		    nfs4acl_isolate_group_class(&x))
+			goto out_enomem;
+	} else {
+		if (nfs4acl_isolate_owner_class(&x) ||
+		    nfs4acl_isolate_group_class(&x))
+			goto out_enomem;
+	}
+	*acl = x.acl;
+	return 0;
+
+out_enomem:
+	*acl = x.acl;
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(nfs4acl_apply_masks);

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX Products GmbH / Novell Inc.


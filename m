Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSJaIaf>; Thu, 31 Oct 2002 03:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264781AbSJaIaI>; Thu, 31 Oct 2002 03:30:08 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:63459 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S265226AbSJaIWq>;
	Thu, 31 Oct 2002 03:22:46 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 11/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E187AhR-0003bV-00@snap.thunk.org>
Date: Thu, 31 Oct 2002 03:29:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Port of (bugfixed) 0.8.50 acl-ext2 to 2.5

This patch adds ACL support to the ext2 filesystem.

 fs/Kconfig              |   12 +
 fs/ext2/Makefile        |    4 
 fs/ext2/acl.c           |  573 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/acl.h           |   88 +++++++
 fs/ext2/ext2.h          |    5 
 fs/ext2/file.c          |    3 
 fs/ext2/ialloc.c        |   37 +--
 fs/ext2/inode.c         |   22 +
 fs/ext2/namei.c         |   10 
 fs/ext2/super.c         |   43 +++
 fs/ext2/xattr.c         |   21 +
 include/linux/ext2_fs.h |    1 
 12 files changed, 797 insertions(+), 22 deletions(-)

diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Thu Oct 31 02:39:46 2002
+++ b/fs/Kconfig	Thu Oct 31 02:39:46 2002
@@ -970,6 +970,18 @@
 
 	  If unsure, say N.
 
+config EXT2_FS_POSIX_ACL
+	bool "Ext2 POSIX Access Control Lists"
+	depends on EXT2_FS_XATTR
+	---help---
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
 	---help---
diff -Nru a/fs/ext2/Makefile b/fs/ext2/Makefile
--- a/fs/ext2/Makefile	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/Makefile	Thu Oct 31 02:39:46 2002
@@ -13,4 +13,8 @@
 ext2-objs += xattr.o xattr_user.o
 endif
 
+ifeq ($(CONFIG_EXT2_FS_POSIX_ACL),y)
+ext2-objs += acl.o
+endif
+
 include $(TOPDIR)/Rules.make
diff -Nru a/fs/ext2/acl.c b/fs/ext2/acl.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext2/acl.c	Thu Oct 31 02:39:46 2002
@@ -0,0 +1,573 @@
+/*
+ * linux/fs/ext2/acl.c
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include "ext2.h"
+#include "xattr.h"
+#include "acl.h"
+
+/*
+ * Convert from filesystem to in-memory representation.
+ */
+static struct posix_acl *
+ext2_acl_from_disk(const void *value, size_t size)
+{
+	const char *end = (char *)value + size;
+	int n, count;
+	struct posix_acl *acl;
+
+	if (!value)
+		return NULL;
+	if (size < sizeof(ext2_acl_header))
+		 return ERR_PTR(-EINVAL);
+	if (((ext2_acl_header *)value)->a_version !=
+	    cpu_to_le32(EXT2_ACL_VERSION))
+		return ERR_PTR(-EINVAL);
+	value = (char *)value + sizeof(ext2_acl_header);
+	count = ext2_acl_count(size);
+	if (count < 0)
+		return ERR_PTR(-EINVAL);
+	if (count == 0)
+		return NULL;
+	acl = posix_acl_alloc(count, GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+	for (n=0; n < count; n++) {
+		ext2_acl_entry *entry =
+			(ext2_acl_entry *)value;
+		if ((char *)value + sizeof(ext2_acl_entry_short) > end)
+			goto fail;
+		acl->a_entries[n].e_tag  = le16_to_cpu(entry->e_tag);
+		acl->a_entries[n].e_perm = le16_to_cpu(entry->e_perm);
+		switch(acl->a_entries[n].e_tag) {
+			case ACL_USER_OBJ:
+			case ACL_GROUP_OBJ:
+			case ACL_MASK:
+			case ACL_OTHER:
+				value = (char *)value +
+					sizeof(ext2_acl_entry_short);
+				acl->a_entries[n].e_id = ACL_UNDEFINED_ID;
+				break;
+
+			case ACL_USER:
+			case ACL_GROUP:
+				value = (char *)value + sizeof(ext2_acl_entry);
+				if ((char *)value > end)
+					goto fail;
+				acl->a_entries[n].e_id =
+					le32_to_cpu(entry->e_id);
+				break;
+
+			default:
+				goto fail;
+		}
+	}
+	if (value != end)
+		goto fail;
+	return acl;
+
+fail:
+	posix_acl_release(acl);
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * Convert from in-memory to filesystem representation.
+ */
+static void *
+ext2_acl_to_disk(const struct posix_acl *acl, size_t *size)
+{
+	ext2_acl_header *ext_acl;
+	char *e;
+	int n;
+
+	*size = ext2_acl_size(acl->a_count);
+	ext_acl = (ext2_acl_header *)kmalloc(sizeof(ext2_acl_header) +
+		acl->a_count * sizeof(ext2_acl_entry), GFP_KERNEL);
+	if (!ext_acl)
+		return ERR_PTR(-ENOMEM);
+	ext_acl->a_version = cpu_to_le32(EXT2_ACL_VERSION);
+	e = (char *)ext_acl + sizeof(ext2_acl_header);
+	for (n=0; n < acl->a_count; n++) {
+		ext2_acl_entry *entry = (ext2_acl_entry *)e;
+		entry->e_tag  = cpu_to_le16(acl->a_entries[n].e_tag);
+		entry->e_perm = cpu_to_le16(acl->a_entries[n].e_perm);
+		switch(acl->a_entries[n].e_tag) {
+			case ACL_USER:
+			case ACL_GROUP:
+				entry->e_id =
+					cpu_to_le32(acl->a_entries[n].e_id);
+				e += sizeof(ext2_acl_entry);
+				break;
+
+			case ACL_USER_OBJ:
+			case ACL_GROUP_OBJ:
+			case ACL_MASK:
+			case ACL_OTHER:
+				e += sizeof(ext2_acl_entry_short);
+				break;
+
+			default:
+				goto fail;
+		}
+	}
+	return (char *)ext_acl;
+
+fail:
+	kfree(ext_acl);
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * inode->i_sem: down
+ */
+static struct posix_acl *
+ext2_get_acl(struct inode *inode, int type)
+{
+	int name_index;
+	char *value;
+	struct posix_acl *acl, **p_acl;
+	const size_t size = ext2_acl_size(EXT2_ACL_MAX_ENTRIES);
+	int retval;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			p_acl = &EXT2_I(inode)->i_acl;
+			name_index = EXT2_XATTR_INDEX_POSIX_ACL_ACCESS;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			p_acl = &EXT2_I(inode)->i_default_acl;
+			name_index = EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT;
+			break;
+
+		default:
+			return ERR_PTR(-EINVAL);
+	}
+	if (*p_acl != EXT2_ACL_NOT_CACHED)
+		return posix_acl_dup(*p_acl);
+	value = kmalloc(size, GFP_KERNEL);
+	if (!value)
+		return ERR_PTR(-ENOMEM);
+
+	retval = ext2_xattr_get(inode, name_index, "", value, size);
+
+	if (retval == -ENODATA || retval == -ENOSYS)
+		*p_acl = acl = NULL;
+	else if (retval < 0)
+		acl = ERR_PTR(retval);
+	else {
+		acl = ext2_acl_from_disk(value, retval);
+		if (!IS_ERR(acl))
+			*p_acl = posix_acl_dup(acl);
+	}
+	kfree(value);
+	return acl;
+}
+
+/*
+ * inode->i_sem: down
+ */
+static int
+ext2_set_acl(struct inode *inode, int type, struct posix_acl *acl)
+{
+	int name_index;
+	void *value = NULL;
+	struct posix_acl **p_acl;
+	size_t size;
+	int error;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			name_index = EXT2_XATTR_INDEX_POSIX_ACL_ACCESS;
+			p_acl = &EXT2_I(inode)->i_acl;
+			if (acl) {
+				mode_t mode = inode->i_mode;
+				error = posix_acl_equiv_mode(acl, &mode);
+				if (error < 0)
+					return error;
+				else {
+					inode->i_mode = mode;
+					mark_inode_dirty(inode);
+					if (error == 0)
+						acl = NULL;
+				}
+			}
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			name_index = EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT;
+			p_acl = &EXT2_I(inode)->i_default_acl;
+			if (!S_ISDIR(inode->i_mode))
+				return acl ? -EACCES : 0;
+			break;
+
+		default:
+			return -EINVAL;
+	}
+ 	if (acl) {
+		if (acl->a_count > EXT2_ACL_MAX_ENTRIES)
+			return -EINVAL;
+		value = ext2_acl_to_disk(acl, &size);
+		if (IS_ERR(value))
+			return (int)PTR_ERR(value);
+	}
+
+	error = ext2_xattr_set(inode, name_index, "", value, size, 0);
+
+	if (value)
+		kfree(value);
+	if (!error) {
+		if (*p_acl && *p_acl != EXT2_ACL_NOT_CACHED)
+			posix_acl_release(*p_acl);
+		*p_acl = posix_acl_dup(acl);
+	}
+	return error;
+}
+
+static int
+__ext2_permission(struct inode *inode, int mask, int lock)
+{
+	int mode = inode->i_mode;
+
+	/* Nobody gets write access to a read-only fs */
+	if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
+	    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+		return -EROFS;
+	/* Nobody gets write access to an immutable file */
+	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
+	    return -EACCES;
+	if (current->fsuid == inode->i_uid) {
+		mode >>= 6;
+	} else if (test_opt(inode->i_sb, POSIX_ACL)) {
+		/* ACL can't contain additional permissions if
+		   the ACL_MASK entry is 0 */
+		if (!(mode & S_IRWXG))
+			goto check_groups;
+		if (EXT2_I(inode)->i_acl == EXT2_ACL_NOT_CACHED) {
+			struct posix_acl *acl;
+
+			if (lock) {
+				down(&inode->i_sem);
+				acl = ext2_get_acl(inode, ACL_TYPE_ACCESS);
+				up(&inode->i_sem);
+			} else
+				acl = ext2_get_acl(inode, ACL_TYPE_ACCESS);
+
+			if (IS_ERR(acl))
+				return PTR_ERR(acl);
+			posix_acl_release(acl);
+			if (EXT2_I(inode)->i_acl == EXT2_ACL_NOT_CACHED)
+				return -EIO;
+		}
+		if (EXT2_I(inode)->i_acl) {
+			int error = posix_acl_permission(inode,
+				EXT2_I(inode)->i_acl, mask);
+			if (error == -EACCES)
+				goto check_capabilities;
+			return error;
+		} else
+			goto check_groups;
+	} else {
+check_groups:
+		if (in_group_p(inode->i_gid))
+			mode >>= 3;
+	}
+	if ((mode & mask & S_IRWXO) == mask)
+		return 0;
+
+check_capabilities:
+	/* Allowed to override Discretionary Access Control? */
+	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+		if (capable(CAP_DAC_OVERRIDE))
+			return 0;
+	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
+	if (capable(CAP_DAC_READ_SEARCH) && ((mask == MAY_READ) ||
+	    (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE))))
+		return 0;
+	return -EACCES;
+}
+
+/*
+ * Inode operation permission().
+ *
+ * inode->i_sem: up
+ * BKL held [before 2.5.x]
+ */
+int
+ext2_permission(struct inode *inode, int mask)
+{
+	return __ext2_permission(inode, mask, 1);
+}
+
+/*
+ * Used internally if i_sem is already down.
+ */
+int
+ext2_permission_locked(struct inode *inode, int mask)
+{
+	return __ext2_permission(inode, mask, 0);
+}
+
+/*
+ * Initialize the ACLs of a new inode. Called from ext2_new_inode.
+ *
+ * dir->i_sem: down
+ * inode->i_sem: up (access to inode is still exclusive)
+ * BKL held [before 2.5.x] 
+ */
+int
+ext2_init_acl(struct inode *inode, struct inode *dir)
+{
+	struct posix_acl *acl = NULL;
+	int error = 0;
+
+	if (!S_ISLNK(inode->i_mode)) {
+		if (test_opt(dir->i_sb, POSIX_ACL)) {
+			acl = ext2_get_acl(dir, ACL_TYPE_DEFAULT);
+			if (IS_ERR(acl))
+				return PTR_ERR(acl);
+		}
+		if (!acl)
+			inode->i_mode &= ~current->fs->umask;
+	}
+	if (test_opt(inode->i_sb, POSIX_ACL) && acl) {
+               struct posix_acl *clone;
+	       mode_t mode;
+
+		if (S_ISDIR(inode->i_mode)) {
+			error = ext2_set_acl(inode, ACL_TYPE_DEFAULT, acl);
+			if (error)
+				goto cleanup;
+		}
+		clone = posix_acl_clone(acl, GFP_KERNEL);
+		error = -ENOMEM;
+		if (!clone)
+			goto cleanup;
+		mode = inode->i_mode;
+		error = posix_acl_create_masq(clone, &mode);
+		if (error >= 0) {
+			inode->i_mode = mode;
+			if (error > 0) {
+				/* This is an extended ACL */
+				error = ext2_set_acl(inode,
+						     ACL_TYPE_ACCESS, clone);
+			}
+		}
+		posix_acl_release(clone);
+	}
+cleanup:
+       posix_acl_release(acl);
+       return error;
+}
+
+/*
+ * Does chmod for an inode that may have an Access Control List. The
+ * inode->i_mode field must be updated to the desired value by the caller
+ * before calling this function.
+ * Returns 0 on success, or a negative error number.
+ *
+ * We change the ACL rather than storing some ACL entries in the file
+ * mode permission bits (which would be more efficient), because that
+ * would break once additional permissions (like  ACL_APPEND, ACL_DELETE
+ * for directories) are added. There are no more bits available in the
+ * file mode.
+ *
+ * inode->i_sem: down
+ * BKL held [before 2.5.x]
+ */
+int
+ext2_acl_chmod(struct inode *inode)
+{
+	struct posix_acl *acl, *clone;
+        int error;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+	acl = ext2_get_acl(inode, ACL_TYPE_ACCESS);
+	if (IS_ERR(acl) || !acl)
+		return PTR_ERR(acl);
+	clone = posix_acl_clone(acl, GFP_KERNEL);
+	posix_acl_release(acl);
+	if (!clone)
+		return -ENOMEM;
+	error = posix_acl_chmod_masq(clone, inode->i_mode);
+	if (!error)
+		error = ext2_set_acl(inode, ACL_TYPE_ACCESS, clone);
+	posix_acl_release(clone);
+	return error;
+}
+
+/*
+ * Extended attribut handlers
+ */
+static size_t
+ext2_xattr_list_acl_access(char *list, struct inode *inode,
+			   const char *name, int name_len)
+{
+	const size_t len = sizeof(XATTR_NAME_ACL_ACCESS)-1;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+	if (list)
+		memcpy(list, XATTR_NAME_ACL_ACCESS, len);
+	return len;
+}
+
+static size_t
+ext2_xattr_list_acl_default(char *list, struct inode *inode,
+			    const char *name, int name_len)
+{
+	const size_t len = sizeof(XATTR_NAME_ACL_DEFAULT)-1;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+	if (list)
+		memcpy(list, XATTR_NAME_ACL_DEFAULT, len);
+	return len;
+}
+
+static int
+ext2_xattr_get_acl(struct inode *inode, int type, void *buffer, size_t size)
+{
+	struct posix_acl *acl;
+	int error;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return -EOPNOTSUPP;
+
+	acl = ext2_get_acl(inode, type);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	if (acl == NULL)
+		return -ENODATA;
+	error = posix_acl_to_xattr(acl, buffer, size);
+	posix_acl_release(acl);
+
+	return error;
+}
+
+static int
+ext2_xattr_get_acl_access(struct inode *inode, const char *name,
+			  void *buffer, size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext2_xattr_get_acl(inode, ACL_TYPE_ACCESS, buffer, size);
+}
+
+static int
+ext2_xattr_get_acl_default(struct inode *inode, const char *name,
+			   void *buffer, size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext2_xattr_get_acl(inode, ACL_TYPE_DEFAULT, buffer, size);
+}
+
+static int
+ext2_xattr_set_acl(struct inode *inode, int type, const void *value, size_t size)
+{
+	struct posix_acl *acl;
+	int error;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return -EOPNOTSUPP;
+	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		return -EPERM;
+
+	if (value) {
+		acl = posix_acl_from_xattr(value, size);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+		else if (acl) {
+			error = posix_acl_valid(acl);
+			if (error)
+				goto release_and_out;
+		}
+	} else
+		acl = NULL;
+
+	error = ext2_set_acl(inode, type, acl);
+
+release_and_out:
+	posix_acl_release(acl);
+	return error;
+}
+
+static int
+ext2_xattr_set_acl_access(struct inode *inode, const char *name,
+			  const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext2_xattr_set_acl(inode, ACL_TYPE_ACCESS, value, size);
+}
+
+static int
+ext2_xattr_set_acl_default(struct inode *inode, const char *name,
+			   const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext2_xattr_set_acl(inode, ACL_TYPE_DEFAULT, value, size);
+}
+
+struct ext2_xattr_handler ext2_xattr_acl_access_handler = {
+	prefix:	XATTR_NAME_ACL_ACCESS,
+	list:	ext2_xattr_list_acl_access,
+	get:	ext2_xattr_get_acl_access,
+	set:	ext2_xattr_set_acl_access,
+};
+
+struct ext2_xattr_handler ext2_xattr_acl_default_handler = {
+	prefix:	XATTR_NAME_ACL_DEFAULT,
+	list:	ext2_xattr_list_acl_default,
+	get:	ext2_xattr_get_acl_default,
+	set:	ext2_xattr_set_acl_default,
+};
+
+void
+exit_ext2_acl(void)
+{
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
+			      &ext2_xattr_acl_access_handler);
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
+			      &ext2_xattr_acl_default_handler);
+}
+
+int __init
+init_ext2_acl(void)
+{
+	int error;
+
+	error = ext2_xattr_register(EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
+				    &ext2_xattr_acl_access_handler);
+	if (error)
+		goto fail;
+	error = ext2_xattr_register(EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
+				    &ext2_xattr_acl_default_handler);
+	if (error)
+		goto fail;
+	return 0;
+
+fail:
+	exit_ext2_acl();
+	return error;
+}
diff -Nru a/fs/ext2/acl.h b/fs/ext2/acl.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext2/acl.h	Thu Oct 31 02:39:46 2002
@@ -0,0 +1,88 @@
+/*
+  File: fs/ext2/acl.h
+
+  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#include <linux/xattr_acl.h>
+
+#define EXT2_ACL_VERSION	0x0001
+#define EXT2_ACL_MAX_ENTRIES	32
+
+typedef struct {
+	__u16		e_tag;
+	__u16		e_perm;
+	__u32		e_id;
+} ext2_acl_entry;
+
+typedef struct {
+	__u16		e_tag;
+	__u16		e_perm;
+} ext2_acl_entry_short;
+
+typedef struct {
+	__u32		a_version;
+} ext2_acl_header;
+
+static inline size_t ext2_acl_size(int count)
+{
+	if (count <= 4) {
+		return sizeof(ext2_acl_header) +
+		       count * sizeof(ext2_acl_entry_short);
+	} else {
+		return sizeof(ext2_acl_header) +
+		       4 * sizeof(ext2_acl_entry_short) +
+		       (count - 4) * sizeof(ext2_acl_entry);
+	}
+}
+
+static inline int ext2_acl_count(size_t size)
+{
+	ssize_t s;
+	size -= sizeof(ext2_acl_header);
+	s = size - 4 * sizeof(ext2_acl_entry_short);
+	if (s < 0) {
+		if (size % sizeof(ext2_acl_entry_short))
+			return -1;
+		return size / sizeof(ext2_acl_entry_short);
+	} else {
+		if (s % sizeof(ext2_acl_entry))
+			return -1;
+		return s / sizeof(ext2_acl_entry) + 4;
+	}
+}
+
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+
+/* Value for inode->u.ext2_i.i_acl and inode->u.ext2_i.i_default_acl
+   if the ACL has not been cached */
+#define EXT2_ACL_NOT_CACHED ((void *)-1)
+
+/* acl.c */
+extern int ext2_permission (struct inode *, int);
+extern int ext2_permission_locked (struct inode *, int);
+extern int ext2_acl_chmod (struct inode *);
+extern int ext2_init_acl (struct inode *, struct inode *);
+
+extern int init_ext2_acl(void);
+extern void exit_ext2_acl(void);
+
+#else
+#include <linux/sched.h>
+#define ext2_permission NULL
+#define ext2_get_acl	NULL
+#define ext2_set_acl	NULL
+
+static inline int
+ext2_acl_chmod (struct inode *inode)
+{
+	return 0;
+}
+
+static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
+{
+	inode->i_mode &= ~current->fs->umask;
+	return 0;
+}
+#endif
+
diff -Nru a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/ext2.h	Thu Oct 31 02:39:46 2002
@@ -20,6 +20,10 @@
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
 	__u32	i_dir_start_lookup;
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	struct posix_acl	*i_acl;
+	struct posix_acl	*i_default_acl;
+#endif
 	rwlock_t i_meta_lock;
 	struct inode	vfs_inode;
 };
@@ -85,6 +89,7 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
+extern int ext2_setattr (struct dentry *, struct iattr *);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
diff -Nru a/fs/ext2/file.c b/fs/ext2/file.c
--- a/fs/ext2/file.c	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/file.c	Thu Oct 31 02:39:46 2002
@@ -21,6 +21,7 @@
 #include <linux/time.h>
 #include "ext2.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Called when an inode is released. Note that this is different
@@ -60,4 +61,6 @@
 	.getxattr	= ext2_getxattr,
 	.listxattr	= ext2_listxattr,
 	.removexattr	= ext2_removexattr,
+	.setattr	= ext2_setattr,
+	.permission	= ext2_permission,
 };
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/ialloc.c	Thu Oct 31 02:39:46 2002
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>
 #include "ext2.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
@@ -302,7 +303,6 @@
 	struct ext2_super_block * es;
 	struct ext2_inode_info *ei;
 	int err;
-	struct inode *ret;
 
 	sb = dir->i_sb;
 	inode = new_inode(sb);
@@ -323,7 +323,6 @@
 		goto fail;
 
 	err = -EIO;
-	brelse(bitmap_bh);
 	bitmap_bh = read_inode_bitmap(sb, group);
 	if (!bitmap_bh)
 		goto fail2;
@@ -339,6 +338,7 @@
 		ll_rw_block(WRITE, 1, &bitmap_bh);
 		wait_on_buffer(bitmap_bh);
 	}
+	brelse(bitmap_bh);
 
 	ino = group * EXT2_INODES_PER_GROUP(sb) + i + 1;
 	if (ino < EXT2_FIRST_INO(sb) || ino > le32_to_cpu(es->s_inodes_count)) {
@@ -395,21 +395,27 @@
 		inode->i_flags |= S_DIRSYNC;
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
-	mark_inode_dirty(inode);
 
 	unlock_super(sb);
-	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
-		inode->i_flags |= S_NOQUOTA;
-		inode->i_nlink = 0;
-		iput(inode);
-		ret = ERR_PTR(-EDQUOT);
-	} else {
-		ext2_debug("allocating inode %lu\n", inode->i_ino);
-		ext2_preread_inode(inode);
+		goto fail3;
+	}
+	err = ext2_init_acl(inode, dir);
+	if (err) {
+		DQUOT_FREE_INODE(inode);
+		goto fail3;
 	}
-	goto out;
+	mark_inode_dirty(inode);
+	ext2_debug("allocating inode %lu\n", inode->i_ino);
+	ext2_preread_inode(inode);
+	return inode;
+
+fail3:
+	inode->i_flags |= S_NOQUOTA;
+	inode->i_nlink = 0;
+	iput(inode);
+	return ERR_PTR(err);
 
 fail2:
 	desc = ext2_get_group_desc (sb, group, &bh2);
@@ -423,10 +429,10 @@
 	unlock_super(sb);
 	make_bad_inode(inode);
 	iput(inode);
-	ret = ERR_PTR(err);
-	goto out;
+	return ERR_PTR(err);
 
 bad_count:
+	brelse(bitmap_bh);
 	ext2_error (sb, "ext2_new_inode",
 		    "Free inodes count corrupted in group %d",
 		    group);
@@ -439,9 +445,6 @@
 	desc->bg_free_inodes_count = 0;
 	mark_buffer_dirty(bh2);
 	goto repeat;
-out:
-	brelse(bitmap_bh);
-	return ret;
 }
 
 unsigned long ext2_count_free_inodes (struct super_block * sb)
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/inode.c	Thu Oct 31 02:39:46 2002
@@ -22,7 +22,6 @@
  *  Assorted race fixes, rewrite of ext2_get_block() by Al Viro, 2000
  */
 
-#include "ext2.h"
 #include <linux/smp_lock.h>
 #include <linux/time.h>
 #include <linux/highuid.h>
@@ -31,6 +30,8 @@
 #include <linux/module.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
+#include "ext2.h"
+#include "acl.h"
 
 MODULE_AUTHOR("Remy Card and others");
 MODULE_DESCRIPTION("Second Extended Filesystem");
@@ -982,6 +983,10 @@
 	struct ext2_inode * raw_inode = ext2_get_inode(inode->i_sb, ino, &bh);
 	int n;
 
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	ei->i_acl = EXT2_ACL_NOT_CACHED;
+	ei->i_default_acl = EXT2_ACL_NOT_CACHED;
+#endif
 	if (IS_ERR(raw_inode))
  		goto bad_inode;
 
@@ -1177,3 +1182,18 @@
 {
 	return ext2_update_inode (inode, 1);
 }
+
+int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	error = inode_change_ok(inode, iattr);
+	if (error)
+		return error;
+	inode_setattr(inode, iattr);
+	if (iattr->ia_valid & ATTR_MODE)
+		error = ext2_acl_chmod(inode);
+	return error;
+}
+
diff -Nru a/fs/ext2/namei.c b/fs/ext2/namei.c
--- a/fs/ext2/namei.c	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/namei.c	Thu Oct 31 02:39:46 2002
@@ -32,6 +32,7 @@
 #include <linux/pagemap.h>
 #include "ext2.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
@@ -138,7 +139,10 @@
 	struct inode * inode = ext2_new_inode (dir, mode);
 	int err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
-		init_special_inode(inode, mode, rdev);
+		init_special_inode(inode, inode->i_mode, rdev);
+#ifdef CONFIG_EXT2_FS_EXT_ATTR
+		inode->i_op = &ext2_special_inode_operations;
+#endif
 		mark_inode_dirty(inode);
 		err = ext2_add_nondir(dentry, inode);
 	}
@@ -373,6 +377,8 @@
 	.getxattr	= ext2_getxattr,
 	.listxattr	= ext2_listxattr,
 	.removexattr	= ext2_removexattr,
+	.setattr	= ext2_setattr,
+	.permission	= ext2_permission,
 };
 
 struct inode_operations ext2_special_inode_operations = {
@@ -380,4 +386,6 @@
 	.getxattr	= ext2_getxattr,
 	.listxattr	= ext2_listxattr,
 	.removexattr	= ext2_removexattr,
+	.setattr	= ext2_setattr,
+	.permission	= ext2_permission,
 };
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/super.c	Thu Oct 31 02:39:46 2002
@@ -28,7 +28,7 @@
 #include <asm/uaccess.h>
 #include "ext2.h"
 #include "xattr.h"
-
+#include "acl.h"
 
 static void ext2_sync_super(struct super_block *sb,
 			    struct ext2_super_block *es);
@@ -155,6 +155,10 @@
 	ei = (struct ext2_inode_info *)kmem_cache_alloc(ext2_inode_cachep, SLAB_KERNEL);
 	if (!ei)
 		return NULL;
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	ei->i_acl = EXT2_ACL_NOT_CACHED;
+	ei->i_default_acl = EXT2_ACL_NOT_CACHED;
+#endif
 	return &ei->vfs_inode;
 }
 
@@ -191,6 +195,26 @@
 		printk(KERN_INFO "ext2_inode_cache: not all structures were freed\n");
 }
 
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+
+static void ext2_clear_inode(struct inode *inode)
+{
+	struct ext2_inode_info *ei = EXT2_I(inode);
+
+	if (ei->i_acl && ei->i_acl != EXT2_ACL_NOT_CACHED) {
+		posix_acl_release(ei->i_acl);
+		ei->i_acl = EXT2_ACL_NOT_CACHED;
+	}
+	if (ei->i_default_acl && ei->i_default_acl != EXT2_ACL_NOT_CACHED) {
+		posix_acl_release(ei->i_default_acl);
+		ei->i_default_acl = EXT2_ACL_NOT_CACHED;
+	}
+}
+
+#else
+# define ext2_clear_inode NULL
+#endif
+
 static struct super_operations ext2_sops = {
 	.alloc_inode	= ext2_alloc_inode,
 	.destroy_inode	= ext2_destroy_inode,
@@ -202,6 +226,7 @@
 	.write_super	= ext2_write_super,
 	.statfs		= ext2_statfs,
 	.remount_fs	= ext2_remount,
+	.clear_inode	= ext2_clear_inode,
 };
 
 /* Yes, most of these are left as NULL!!
@@ -287,6 +312,13 @@
 			clear_opt (sbi->s_mount_opt, XATTR_USER);
 		else
 #endif
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+		if (!strcmp(this_char, "acl"))
+			set_opt(sbi->s_mount_opt, POSIX_ACL);
+		else if (!strcmp(this_char, "noacl"))
+			clear_opt(sbi->s_mount_opt, POSIX_ACL);
+		else
+#endif
 		if (!strcmp (this_char, "bsddf"))
 			clear_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
@@ -571,6 +603,8 @@
 		set_opt(sbi->s_mount_opt, NO_UID32);
 	if (def_mount_opts & EXT2_DEFM_XATTR_USER)
 		set_opt(sbi->s_mount_opt, XATTR_USER);
+	if (def_mount_opts & EXT2_DEFM_ACL)
+		set_opt(sbi->s_mount_opt, POSIX_ACL);
 	
 	if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
 		set_opt(sbi->s_mount_opt, ERRORS_PANIC);
@@ -583,6 +617,10 @@
 	if (!parse_options ((char *) data, sbi))
 		goto failed_mount;
 
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		((EXT2_SB(sb)->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ?
+		 MS_POSIXACL : 0);
+
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
 	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT2_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
@@ -827,6 +865,9 @@
 	 */
 	if (!parse_options (data, sbi))
 		return -EINVAL;
+
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
 
 	es = sbi->s_es;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
diff -Nru a/fs/ext2/xattr.c b/fs/ext2/xattr.c
--- a/fs/ext2/xattr.c	Thu Oct 31 02:39:46 2002
+++ b/fs/ext2/xattr.c	Thu Oct 31 02:39:46 2002
@@ -60,6 +60,7 @@
 #include <asm/semaphore.h>
 #include "ext2.h"
 #include "xattr.h"
+#include "acl.h"
 
 /* These symbols may be needed by a module. */
 EXPORT_SYMBOL(ext2_xattr_register);
@@ -1100,19 +1101,35 @@
 	err = ext2_xattr_register(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
 	if (err)
 		return err;
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	err = init_ext2_acl();
+	if (err)
+		goto out;
+#endif
 	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
 	if (!ext2_xattr_cache) {
-		ext2_xattr_unregister(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out1;
 	}
 	return 0;
+out1:
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	exit_ext2_acl();
+out:
+#endif
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
+			      &ext2_xattr_user_handler);
+	return err;
 }
 
 void
 exit_ext2_xattr(void)
 {
 	mb_cache_destroy(ext2_xattr_cache);
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	exit_ext2_acl();
+#endif
 	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
 }
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Thu Oct 31 02:39:46 2002
+++ b/include/linux/ext2_fs.h	Thu Oct 31 02:39:46 2002
@@ -308,6 +308,7 @@
 #define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
 #define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
 #define EXT2_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
+#define EXT2_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt

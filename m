Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSJ2Qo4>; Tue, 29 Oct 2002 11:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSJ2Qox>; Tue, 29 Oct 2002 11:44:53 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:47072 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261996AbSJ2QgM>;
	Tue, 29 Oct 2002 11:36:12 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 10/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E186ZRm-0006ti-00@snap.thunk.org>
Date: Tue, 29 Oct 2002 11:42:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Port of (bugfixed) 0.8.50 acl-ext3 to 2.5.

This patch adds ACL support to the ext3 filesystem.

fs/Config.help            |   11 
fs/Config.in              |    1 
fs/ext3/Makefile          |    4 
fs/ext3/acl.c             |  590 ++++++++++++++++++++++++++++++++++++++++++++++
fs/ext3/acl.h             |   87 ++++++
fs/ext3/file.c            |    2 
fs/ext3/ialloc.c          |   32 +-
fs/ext3/inode.c           |   21 +
fs/ext3/namei.c           |   11 
fs/ext3/super.c           |   41 +++
fs/ext3/xattr.c           |   23 +
include/linux/ext3_fs.h   |    1 
include/linux/ext3_fs_i.h |    4 
13 files changed, 805 insertions(+), 23 deletions(-)

diff -Nru a/fs/Config.help b/fs/Config.help
--- a/fs/Config.help	Tue Oct 29 09:56:01 2002
+++ b/fs/Config.help	Tue Oct 29 09:56:01 2002
@@ -166,7 +166,18 @@
   the kernel or by users (see the attr(5) manual page, or visit
   <http://acl.bestbits.at/> for details).
 
+  You need this for POSIX ACL support on ext3.
+
   If unsure, say N.
+
+CONFIG_EXT3_FS_POSIX_ACL
+  Posix Access Control Lists (ACLs) support permissions for users and
+  groups beyond the owner/group/world scheme.
+
+  To learn more about Access Control Lists, visit the Posix ACLs for
+  Linux website <http://acl.bestbits.at/>.
+
+  If you don't know what Access Control Lists are, say N.
 
 CONFIG_JBD
   This is a generic journaling layer for block devices.  It is
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Oct 29 09:56:01 2002
+++ b/fs/Config.in	Tue Oct 29 09:56:01 2002
@@ -31,6 +31,7 @@
 
 tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
 dep_mbool '  Ext3 extended attributes' CONFIG_EXT3_FS_XATTR $CONFIG_EXT3_FS
+dep_mbool '  Ext3 POSIX Access Control Lists' CONFIG_EXT3_FS_POSIX_ACL $CONFIG_EXT3_FS_XATTR
 # CONFIG_JBD could be its own option (even modular), but until there are
 # other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
diff -Nru a/fs/ext3/Makefile b/fs/ext3/Makefile
--- a/fs/ext3/Makefile	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/Makefile	Tue Oct 29 09:56:01 2002
@@ -13,4 +13,8 @@
 ext3-objs += xattr.o xattr_user.o
 endif
 
+ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
+ext3-objs += acl.o
+endif
+
 include $(TOPDIR)/Rules.make
diff -Nru a/fs/ext3/acl.c b/fs/ext3/acl.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext3/acl.c	Tue Oct 29 09:56:01 2002
@@ -0,0 +1,590 @@
+/*
+ * linux/fs/ext3/acl.c
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include "xattr.h"
+#include "acl.h"
+
+/*
+ * Convert from filesystem to in-memory representation.
+ */
+static struct posix_acl *
+ext3_acl_from_disk(const void *value, size_t size)
+{
+	const char *end = (char *)value + size;
+	int n, count;
+	struct posix_acl *acl;
+
+	if (!value)
+		return NULL;
+	if (size < sizeof(ext3_acl_header))
+		 return ERR_PTR(-EINVAL);
+	if (((ext3_acl_header *)value)->a_version !=
+	    cpu_to_le32(EXT3_ACL_VERSION))
+		return ERR_PTR(-EINVAL);
+	value = (char *)value + sizeof(ext3_acl_header);
+	count = ext3_acl_count(size);
+	if (count < 0)
+		return ERR_PTR(-EINVAL);
+	if (count == 0)
+		return NULL;
+	acl = posix_acl_alloc(count, GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+	for (n=0; n < count; n++) {
+		ext3_acl_entry *entry =
+			(ext3_acl_entry *)value;
+		if ((char *)value + sizeof(ext3_acl_entry_short) > end)
+			goto fail;
+		acl->a_entries[n].e_tag  = le16_to_cpu(entry->e_tag);
+		acl->a_entries[n].e_perm = le16_to_cpu(entry->e_perm);
+		switch(acl->a_entries[n].e_tag) {
+			case ACL_USER_OBJ:
+			case ACL_GROUP_OBJ:
+			case ACL_MASK:
+			case ACL_OTHER:
+				value = (char *)value +
+					sizeof(ext3_acl_entry_short);
+				acl->a_entries[n].e_id = ACL_UNDEFINED_ID;
+				break;
+
+			case ACL_USER:
+			case ACL_GROUP:
+				value = (char *)value + sizeof(ext3_acl_entry);
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
+ext3_acl_to_disk(const struct posix_acl *acl, size_t *size)
+{
+	ext3_acl_header *ext_acl;
+	char *e;
+	int n;
+
+	*size = ext3_acl_size(acl->a_count);
+	ext_acl = (ext3_acl_header *)kmalloc(sizeof(ext3_acl_header) +
+		acl->a_count * sizeof(ext3_acl_entry), GFP_KERNEL);
+	if (!ext_acl)
+		return ERR_PTR(-ENOMEM);
+	ext_acl->a_version = cpu_to_le32(EXT3_ACL_VERSION);
+	e = (char *)ext_acl + sizeof(ext3_acl_header);
+	for (n=0; n < acl->a_count; n++) {
+		ext3_acl_entry *entry = (ext3_acl_entry *)e;
+		entry->e_tag  = cpu_to_le16(acl->a_entries[n].e_tag);
+		entry->e_perm = cpu_to_le16(acl->a_entries[n].e_perm);
+		switch(acl->a_entries[n].e_tag) {
+			case ACL_USER:
+			case ACL_GROUP:
+				entry->e_id =
+					cpu_to_le32(acl->a_entries[n].e_id);
+				e += sizeof(ext3_acl_entry);
+				break;
+
+			case ACL_USER_OBJ:
+			case ACL_GROUP_OBJ:
+			case ACL_MASK:
+			case ACL_OTHER:
+				e += sizeof(ext3_acl_entry_short);
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
+ * Inode operation get_posix_acl().
+ *
+ * inode->i_sem: down
+ */
+static struct posix_acl *
+ext3_get_acl(struct inode *inode, int type)
+{
+	int name_index;
+	char *value;
+	struct posix_acl *acl, **p_acl;
+	const size_t size = ext3_acl_size(EXT3_ACL_MAX_ENTRIES);
+	int retval;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			p_acl = &EXT3_I(inode)->i_acl;
+			name_index = EXT3_XATTR_INDEX_POSIX_ACL_ACCESS;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			p_acl = &EXT3_I(inode)->i_default_acl;
+			name_index = EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT;
+			break;
+
+		default:
+			return ERR_PTR(-EINVAL);
+	}
+	if (*p_acl != EXT3_ACL_NOT_CACHED)
+		return posix_acl_dup(*p_acl);
+	value = kmalloc(size, GFP_KERNEL);
+	if (!value)
+		return ERR_PTR(-ENOMEM);
+
+	retval = ext3_xattr_get(inode, name_index, "", value, size);
+
+	if (retval == -ENODATA || retval == -ENOSYS)
+		*p_acl = acl = NULL;
+	else if (retval < 0)
+		acl = ERR_PTR(retval);
+	else {
+		acl = ext3_acl_from_disk(value, retval);
+		if (!IS_ERR(acl))
+			*p_acl = posix_acl_dup(acl);
+	}
+	kfree(value);
+	return acl;
+}
+
+/*
+ * Set the access or default ACL of an inode.
+ *
+ * inode->i_sem: down unless called from ext3_new_inode
+ */
+static int
+ext3_set_acl(handle_t *handle, struct inode *inode, int type,
+	     struct posix_acl *acl)
+{
+	int name_index;
+	void *value = NULL;
+	struct posix_acl **p_acl;
+	size_t size;
+	int error;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			name_index = EXT3_XATTR_INDEX_POSIX_ACL_ACCESS;
+			p_acl = &EXT3_I(inode)->i_acl;
+			if (acl) {
+				mode_t mode = inode->i_mode;
+				error = posix_acl_equiv_mode(acl, &mode);
+				if (error < 0)
+					return error;
+				else {
+					inode->i_mode = mode;
+					ext3_mark_inode_dirty(handle, inode);
+					if (error == 0)
+						acl = NULL;
+				}
+			}
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			name_index = EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT;
+			p_acl = &EXT3_I(inode)->i_default_acl;
+			if (!S_ISDIR(inode->i_mode))
+				return acl ? -EACCES : 0;
+			break;
+
+		default:
+			return -EINVAL;
+	}
+ 	if (acl) {
+		if (acl->a_count > EXT3_ACL_MAX_ENTRIES)
+			return -EINVAL;
+		value = ext3_acl_to_disk(acl, &size);
+		if (IS_ERR(value))
+			return (int)PTR_ERR(value);
+	}
+
+	error = ext3_xattr_set(handle, inode, name_index, "", value, size, 0);
+
+	if (value)
+		kfree(value);
+	if (!error) {
+		if (*p_acl && *p_acl != EXT3_ACL_NOT_CACHED)
+			posix_acl_release(*p_acl);
+		*p_acl = posix_acl_dup(acl);
+	}
+	return error;
+}
+
+static int
+__ext3_permission(struct inode *inode, int mask, int lock)
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
+		if (EXT3_I(inode)->i_acl == EXT3_ACL_NOT_CACHED) {
+			struct posix_acl *acl;
+
+			if (lock) {
+				down(&inode->i_sem);
+				acl = ext3_get_acl(inode, ACL_TYPE_ACCESS);
+				up(&inode->i_sem);
+			} else
+				acl = ext3_get_acl(inode, ACL_TYPE_ACCESS);
+
+			if (IS_ERR(acl))
+				return PTR_ERR(acl);
+			posix_acl_release(acl);
+			if (EXT3_I(inode)->i_acl == EXT3_ACL_NOT_CACHED)
+				return -EIO;
+		}
+		if (EXT3_I(inode)->i_acl) {
+			int error = posix_acl_permission(inode,
+				EXT3_I(inode)->i_acl, mask);
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
+ */
+int
+ext3_permission(struct inode *inode, int mask)
+{
+	return __ext3_permission(inode, mask, 1);
+}
+
+/*
+ * Used internally if i_sem is already down.
+ */
+int
+ext3_permission_locked(struct inode *inode, int mask)
+{
+	return __ext3_permission(inode, mask, 0);
+}
+
+/*
+ * Initialize the ACLs of a new inode. Called from ext3_new_inode.
+ *
+ * dir->i_sem: down
+ * inode->i_sem: up (access to inode is still exclusive)
+ */
+int
+ext3_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
+{
+	struct posix_acl *acl = NULL;
+	int error = 0;
+
+	if (!S_ISLNK(inode->i_mode)) {
+		if (test_opt(dir->i_sb, POSIX_ACL)) {
+			acl = ext3_get_acl(dir, ACL_TYPE_DEFAULT);
+			if (IS_ERR(acl))
+				return PTR_ERR(acl);
+		}
+		if (!acl)
+			inode->i_mode &= ~current->fs->umask;
+	}
+	if (test_opt(inode->i_sb, POSIX_ACL) && acl) {
+		struct posix_acl *clone;
+		mode_t mode;
+
+		if (S_ISDIR(inode->i_mode)) {
+			error = ext3_set_acl(handle, inode,
+					     ACL_TYPE_DEFAULT, acl);
+			if (error)
+				goto cleanup;
+		}
+		clone = posix_acl_clone(acl, GFP_KERNEL);
+		error = -ENOMEM;
+		if (!clone)
+			goto cleanup;
+		
+		mode = inode->i_mode;
+		error = posix_acl_create_masq(clone, &mode);
+		if (error >= 0) {
+			inode->i_mode = mode;
+			if (error > 0) {
+				/* This is an extended ACL */
+				error = ext3_set_acl(handle, inode,
+						     ACL_TYPE_ACCESS, clone);
+			}
+		}
+		posix_acl_release(clone);
+	}
+cleanup:
+	posix_acl_release(acl);
+	return error;
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
+ */
+int
+ext3_acl_chmod(struct inode *inode)
+{
+	struct posix_acl *acl, *clone;
+        int error;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return 0;
+	acl = ext3_get_acl(inode, ACL_TYPE_ACCESS);
+	if (IS_ERR(acl) || !acl)
+		return PTR_ERR(acl);
+	clone = posix_acl_clone(acl, GFP_KERNEL);
+	posix_acl_release(acl);
+	if (!clone)
+		return -ENOMEM;
+	error = posix_acl_chmod_masq(clone, inode->i_mode);
+	if (!error) {
+		handle_t *handle;
+
+		handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
+		if (IS_ERR(handle)) {
+			ext3_std_error(inode->i_sb, error);
+			return PTR_ERR(handle);
+		}
+		error = ext3_set_acl(handle, inode, ACL_TYPE_ACCESS, clone);
+		ext3_journal_stop(handle, inode);
+	}
+	posix_acl_release(clone);
+	return error;
+}
+
+/*
+ * Extended attribute handlers
+ */
+static size_t
+ext3_xattr_list_acl_access(char *list, struct inode *inode,
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
+ext3_xattr_list_acl_default(char *list, struct inode *inode,
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
+ext3_xattr_get_acl(struct inode *inode, int type, void *buffer, size_t size)
+{
+	struct posix_acl *acl;
+	int error;
+
+	if (!test_opt(inode->i_sb, POSIX_ACL))
+		return -EOPNOTSUPP;
+
+	acl = ext3_get_acl(inode, type);
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
+ext3_xattr_get_acl_access(struct inode *inode, const char *name,
+			  void *buffer, size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_get_acl(inode, ACL_TYPE_ACCESS, buffer, size);
+}
+
+static int
+ext3_xattr_get_acl_default(struct inode *inode, const char *name,
+			   void *buffer, size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_get_acl(inode, ACL_TYPE_DEFAULT, buffer, size);
+}
+
+static int
+ext3_xattr_set_acl(struct inode *inode, int type, const void *value, size_t size)
+{
+	handle_t *handle;
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
+	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	error = ext3_set_acl(handle, inode, type, acl);
+	ext3_journal_stop(handle, inode);
+
+release_and_out:
+	posix_acl_release(acl);
+	return error;
+}
+
+static int
+ext3_xattr_set_acl_access(struct inode *inode, const char *name,
+			  const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_set_acl(inode, ACL_TYPE_ACCESS, value, size);
+}
+
+static int
+ext3_xattr_set_acl_default(struct inode *inode, const char *name,
+			   const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return ext3_xattr_set_acl(inode, ACL_TYPE_DEFAULT, value, size);
+}
+
+struct ext3_xattr_handler ext3_xattr_acl_access_handler = {
+	prefix:	XATTR_NAME_ACL_ACCESS,
+	list:	ext3_xattr_list_acl_access,
+	get:	ext3_xattr_get_acl_access,
+	set:	ext3_xattr_set_acl_access,
+};
+
+struct ext3_xattr_handler ext3_xattr_acl_default_handler = {
+	prefix:	XATTR_NAME_ACL_DEFAULT,
+	list:	ext3_xattr_list_acl_default,
+	get:	ext3_xattr_get_acl_default,
+	set:	ext3_xattr_set_acl_default,
+};
+
+void
+exit_ext3_acl(void)
+{
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
+			      &ext3_xattr_acl_access_handler);
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
+			      &ext3_xattr_acl_default_handler);
+}
+
+int __init
+init_ext3_acl(void)
+{
+	int error;
+
+	error = ext3_xattr_register(EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
+				    &ext3_xattr_acl_access_handler);
+	if (error)
+		goto fail;
+	error = ext3_xattr_register(EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
+				    &ext3_xattr_acl_default_handler);
+	if (error)
+		goto fail;
+	return 0;
+
+fail:
+	exit_ext3_acl();
+	return error;
+}
diff -Nru a/fs/ext3/acl.h b/fs/ext3/acl.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext3/acl.h	Tue Oct 29 09:56:01 2002
@@ -0,0 +1,87 @@
+/*
+  File: fs/ext3/acl.h
+
+  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#include <linux/xattr_acl.h>
+
+#define EXT3_ACL_VERSION	0x0001
+#define EXT3_ACL_MAX_ENTRIES	32
+
+typedef struct {
+	__u16		e_tag;
+	__u16		e_perm;
+	__u32		e_id;
+} ext3_acl_entry;
+
+typedef struct {
+	__u16		e_tag;
+	__u16		e_perm;
+} ext3_acl_entry_short;
+
+typedef struct {
+	__u32		a_version;
+} ext3_acl_header;
+
+static inline size_t ext3_acl_size(int count)
+{
+	if (count <= 4) {
+		return sizeof(ext3_acl_header) +
+		       count * sizeof(ext3_acl_entry_short);
+	} else {
+		return sizeof(ext3_acl_header) +
+		       4 * sizeof(ext3_acl_entry_short) +
+		       (count - 4) * sizeof(ext3_acl_entry);
+	}
+}
+
+static inline int ext3_acl_count(size_t size)
+{
+	ssize_t s;
+	size -= sizeof(ext3_acl_header);
+	s = size - 4 * sizeof(ext3_acl_entry_short);
+	if (s < 0) {
+		if (size % sizeof(ext3_acl_entry_short))
+			return -1;
+		return size / sizeof(ext3_acl_entry_short);
+	} else {
+		if (s % sizeof(ext3_acl_entry))
+			return -1;
+		return s / sizeof(ext3_acl_entry) + 4;
+	}
+}
+
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+
+/* Value for inode->u.ext3_i.i_acl and inode->u.ext3_i.i_default_acl
+   if the ACL has not been cached */
+#define EXT3_ACL_NOT_CACHED ((void *)-1)
+
+/* acl.c */
+extern int ext3_permission (struct inode *, int);
+extern int ext3_permission_locked (struct inode *, int);
+extern int ext3_acl_chmod (struct inode *);
+extern int ext3_init_acl (handle_t *, struct inode *, struct inode *);
+
+extern int init_ext3_acl(void);
+extern void exit_ext3_acl(void);
+
+#else  /* CONFIG_EXT3_FS_POSIX_ACL */
+#include <linux/sched.h>
+#define ext3_permission NULL
+
+static inline int
+ext3_acl_chmod(struct inode *inode)
+{
+	return 0;
+}
+
+static inline int
+ext3_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
+{
+	inode->i_mode &= ~current->fs->umask;
+	return 0;
+}
+#endif  /* CONFIG_EXT3_FS_POSIX_ACL */
+
diff -Nru a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/file.c	Tue Oct 29 09:56:01 2002
@@ -24,6 +24,7 @@
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Called when an inode is released. Note that this is different
@@ -102,5 +103,6 @@
 	.getxattr	= ext3_getxattr,
 	.listxattr	= ext3_listxattr,
 	.removexattr	= ext3_removexattr,
+	.permission	= ext3_permission,
 };
 
diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/ialloc.c	Tue Oct 29 09:56:01 2002
@@ -26,6 +26,7 @@
 #include <asm/byteorder.h>
 
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
@@ -423,20 +424,27 @@
 	inode->i_generation = EXT3_SB(sb)->s_next_generation++;
 
 	ei->i_state = EXT3_STATE_NEW;
-	err = ext3_mark_inode_dirty(handle, inode);
-	if (err) goto fail;
-	
+
 	unlock_super(sb);
 	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
-		inode->i_flags |= S_NOQUOTA;
-		inode->i_nlink = 0;
-		iput(inode);
-		ret = ERR_PTR(-EDQUOT);
-	} else {
-		ext3_debug("allocating inode %lu\n", inode->i_ino);
+		err = -EDQUOT;
+		goto fail2;
 	}
+	err = ext3_init_acl(handle, inode, dir);
+	if (err) {
+		DQUOT_FREE_INODE(inode);
+		goto fail2;
+  	}
+	err = ext3_mark_inode_dirty(handle, inode);
+	if (err) {
+		ext3_std_error(sb, err);
+		DQUOT_FREE_INODE(inode);
+		goto fail2;
+	}
+
+	ext3_debug("allocating inode %lu\n", inode->i_ino);
 	goto really_out;
 fail:
 	ext3_std_error(sb, err);
@@ -447,6 +455,12 @@
 really_out:
 	brelse(bitmap_bh);
 	return ret;
+
+fail2:
+	inode->i_flags |= S_NOQUOTA;
+	inode->i_nlink = 0;
+	iput(inode);
+	return ERR_PTR(err);
 }
 
 /* Verify that we are loading a valid orphan from disk */
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/inode.c	Tue Oct 29 09:56:01 2002
@@ -34,6 +34,8 @@
 #include <linux/string.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
+#include "xattr.h"
+#include "acl.h"
 
 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the start
@@ -2199,7 +2201,11 @@
 	struct buffer_head *bh;
 	int block;
 	
-	if(ext3_get_inode_loc(inode, &iloc))
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	ei->i_acl = EXT3_ACL_NOT_CACHED;
+	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
+#endif
+	if (ext3_get_inode_loc(inode, &iloc))
 		goto bad_inode;
 	bh = iloc.bh;
 	raw_inode = iloc.raw_inode;
@@ -2491,13 +2497,8 @@
  * be freed, so we have a strong guarantee that no future commit will
  * leave these blocks visible to the user.)  
  *
- * This is only needed for regular files.  rmdir() has its own path, and
- * we can never truncate a direcory except on final unlink (at which
- * point i_nlink is zero so recovery is easy.)
- *
- * Called with the BKL.  
+ * Called with inode->sem down.
  */
-
 int ext3_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -2517,7 +2518,8 @@
 
 	lock_kernel();
 
-	if (attr->ia_valid & ATTR_SIZE && attr->ia_size < inode->i_size) {
+	if (S_ISREG(inode->i_mode) &&
+	    attr->ia_valid & ATTR_SIZE && attr->ia_size < inode->i_size) {
 		handle_t *handle;
 
 		handle = ext3_journal_start(inode, 3);
@@ -2541,6 +2543,9 @@
 	 * orphan list manually. */
 	if (inode->i_nlink)
 		ext3_orphan_del(NULL, inode);
+
+	if (!rc && (ia_valid & ATTR_MODE))
+		rc = ext3_acl_chmod(inode);
 
 err_out:
 	ext3_std_error(inode->i_sb, error);
diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/namei.c	Tue Oct 29 09:56:01 2002
@@ -37,7 +37,7 @@
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include "xattr.h"
-
+#include "acl.h"
 
 /*
  * define how far ahead to read directories while searching them.
@@ -1624,7 +1624,10 @@
 	inode = ext3_new_inode (handle, dir, mode);
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
-		init_special_inode(inode, mode, rdev);
+		init_special_inode(inode, inode->i_mode, rdev);
+#ifdef CONFIG_EXT3_FS_XATTR
+		inode->i_op = &ext3_special_inode_operations;
+#endif
 		err = ext3_add_nondir(handle, dentry, inode);
 		ext3_mark_inode_dirty(handle, inode);
 	}
@@ -2281,17 +2284,21 @@
 	.rmdir		= ext3_rmdir,
 	.mknod		= ext3_mknod,
 	.rename		= ext3_rename,
+	.setattr	= ext3_setattr,
 	.setxattr	= ext3_setxattr,	
 	.getxattr	= ext3_getxattr,	
 	.listxattr	= ext3_listxattr,	
 	.removexattr	= ext3_removexattr,
+	.permission	= ext3_permission,
 };
 
 struct inode_operations ext3_special_inode_operations = {
+	.setattr	= ext3_setattr,
 	.setxattr	= ext3_setxattr,
 	.getxattr	= ext3_getxattr,
 	.listxattr	= ext3_listxattr,
 	.removexattr	= ext3_removexattr,
+	.permission	= ext3_permission,
 };
 
  
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/super.c	Tue Oct 29 09:56:01 2002
@@ -31,6 +31,7 @@
 #include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 #include "xattr.h"
+#include "acl.h"
 
 #ifdef CONFIG_JBD_DEBUG
 static int ext3_ro_after; /* Make fs read-only after this many jiffies */
@@ -428,6 +429,10 @@
 	ei = kmem_cache_alloc(ext3_inode_cachep, SLAB_NOFS);
 	if (!ei)
 		return NULL;
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	ei->i_acl = EXT3_ACL_NOT_CACHED;
+	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
+#endif
 	return &ei->vfs_inode;
 }
 
@@ -465,6 +470,26 @@
 		printk(KERN_INFO "ext3_inode_cache: not all structures were freed\n");
 }
 
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+
+static void ext3_clear_inode(struct inode *inode)
+{
+       if (EXT3_I(inode)->i_acl &&
+           EXT3_I(inode)->i_acl != EXT3_ACL_NOT_CACHED) {
+               posix_acl_release(EXT3_I(inode)->i_acl);
+               EXT3_I(inode)->i_acl = EXT3_ACL_NOT_CACHED;
+       }
+       if (EXT3_I(inode)->i_default_acl &&
+           EXT3_I(inode)->i_default_acl != EXT3_ACL_NOT_CACHED) {
+               posix_acl_release(EXT3_I(inode)->i_default_acl);
+               EXT3_I(inode)->i_default_acl = EXT3_ACL_NOT_CACHED;
+       }
+}
+
+#else
+# define ext3_clear_inode NULL
+#endif
+
 static struct super_operations ext3_sops = {
 	.alloc_inode	= ext3_alloc_inode,
 	.destroy_inode	= ext3_destroy_inode,
@@ -479,6 +504,7 @@
 	.unlockfs	= ext3_unlockfs,		/* BKL not held.  We take it */
 	.statfs		= ext3_statfs,		/* BKL not held. */
 	.remount_fs	= ext3_remount,		/* BKL held */
+	.clear_inode	= ext3_clear_inode,	/* BKL not needed. */
 };
 
 struct dentry *ext3_get_parent(struct dentry *child);
@@ -560,6 +586,13 @@
 			clear_opt (sbi->s_mount_opt, XATTR_USER);
 		else
 #endif
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+		if (!strcmp(this_char, "acl"))
+			set_opt (sbi->s_mount_opt, POSIX_ACL);
+		else if (!strcmp(this_char, "noacl"))
+			clear_opt (sbi->s_mount_opt, POSIX_ACL);
+		else
+#endif
 		if (!strcmp (this_char, "bsddf"))
 			clear_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
@@ -1035,6 +1068,8 @@
 		set_opt(sbi->s_mount_opt, NO_UID32);
 	if (def_mount_opts & EXT3_DEFM_XATTR_USER)
 		set_opt(sbi->s_mount_opt, XATTR_USER);
+	if (def_mount_opts & EXT3_DEFM_ACL)
+		set_opt(sbi->s_mount_opt, POSIX_ACL);
 	if ((def_mount_opts & EXT3_DEFM_JMODE) == EXT3_DEFM_JMODE_DATA)
 		sbi->s_mount_opt |= EXT3_MOUNT_JOURNAL_DATA;
 	else if ((def_mount_opts & EXT3_DEFM_JMODE) == EXT3_DEFM_JMODE_ORDERED)
@@ -1053,6 +1088,9 @@
 	if (!parse_options ((char *) data, sbi, &journal_inum, 0))
 		goto failed_mount;
 
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
+
 	if (le32_to_cpu(es->s_rev_level) == EXT3_GOOD_OLD_REV &&
 	    (EXT3_HAS_COMPAT_FEATURE(sb, ~0U) ||
 	     EXT3_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
@@ -1741,6 +1779,9 @@
 
 	if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
 		ext3_abort(sb, __FUNCTION__, "Abort forced by user");
+
+	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
+		((sbi->s_mount_opt & EXT3_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
 
 	es = sbi->s_es;
 
diff -Nru a/fs/ext3/xattr.c b/fs/ext3/xattr.c
--- a/fs/ext3/xattr.c	Tue Oct 29 09:56:01 2002
+++ b/fs/ext3/xattr.c	Tue Oct 29 09:56:01 2002
@@ -61,6 +61,7 @@
 #include <linux/quotaops.h>
 #include <asm/semaphore.h>
 #include "xattr.h"
+#include "acl.h"
 
 #define EXT3_EA_USER "user."
 
@@ -1105,15 +1106,27 @@
 	err = ext3_xattr_register(EXT3_XATTR_INDEX_USER, &ext3_xattr_user_handler);
 	if (err)
 		return err;
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	err = init_ext3_acl();
+	if (err)
+		goto out;
+#endif
 	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
 	if (!ext3_xattr_cache) {
-		ext3_xattr_unregister(EXT3_XATTR_INDEX_USER, &ext3_xattr_user_handler);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out1;
 	}
-
 	return 0;
+out1:
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	exit_ext3_acl();
+out:
+#endif
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
+			      &ext3_xattr_user_handler);
+	return err;
 }
 
 void
@@ -1122,6 +1135,8 @@
 	if (ext3_xattr_cache)
 		mb_cache_destroy(ext3_xattr_cache);
 	ext3_xattr_cache = NULL;
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	exit_ext3_acl();
+#endif
 	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER, &ext3_xattr_user_handler);
 }
-
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Tue Oct 29 09:56:01 2002
+++ b/include/linux/ext3_fs.h	Tue Oct 29 09:56:01 2002
@@ -323,6 +323,7 @@
 #define EXT3_MOUNT_UPDATE_JOURNAL	0x1000	/* Update the journal format */
 #define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs */
 #define EXT3_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
+#define EXT3_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
diff -Nru a/include/linux/ext3_fs_i.h b/include/linux/ext3_fs_i.h
--- a/include/linux/ext3_fs_i.h	Tue Oct 29 09:56:01 2002
+++ b/include/linux/ext3_fs_i.h	Tue Oct 29 09:56:01 2002
@@ -41,6 +41,10 @@
 	__u32	i_prealloc_count;
 #endif
 	__u32	i_dir_start_lookup;
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	struct posix_acl	*i_acl;
+	struct posix_acl	*i_default_acl;
+#endif
 	
 	struct list_head i_orphan;	/* unlinked but open inodes */
 

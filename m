Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbSJ2Qoy>; Tue, 29 Oct 2002 11:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJ2QnT>; Tue, 29 Oct 2002 11:43:19 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:43232 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261950AbSJ2QgC>;
	Tue, 29 Oct 2002 11:36:02 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 7/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E186ZRe-0006tc-00@snap.thunk.org>
Date: Tue, 29 Oct 2002 11:42:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Port of 0.8.50 acl patch to 2.5

This patch (as well as the following two) implements core ACL support.
This set of convenience functions is used by the ext2/3 filesystem, 
and may be useful to other filesystems that wish to use "struct posix_acl"
as their internal representation of acl's.  User mode tools which
support this interface may be found at http://acl.bestbits.at

fs/Config.in              |    5 
fs/Makefile               |    3 
fs/posix_acl.c            |  423 ++++++++++++++++++++++++++++++++++++++++++++++
include/linux/posix_acl.h |   87 +++++++++
4 files changed, 517 insertions(+), 1 deletion(-)

diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Oct 29 09:55:28 2002
+++ b/fs/Config.in	Tue Oct 29 09:55:28 2002
@@ -198,6 +198,11 @@
    fi
 fi
 
+# Posix ACL utility routines (for now, only ext2/ext3)
+if [ "$CONFIG_EXT2_FS_POSIX_ACL" = "y" -o "$CONFIG_EXT3_FS_POSIX_ACL" = "y" ]; then
+   define_bool CONFIG_FS_POSIX_ACL y
+fi
+
 mainmenu_option next_comment
 comment 'Partition Types'
 source fs/partitions/Config.in
diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Tue Oct 29 09:55:28 2002
+++ b/fs/Makefile	Tue Oct 29 09:55:28 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o mbcache.o
+                fcntl.o read_write.o dcookies.o mbcache.o posix_acl.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
@@ -31,6 +31,7 @@
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
+obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
diff -Nru a/fs/posix_acl.c b/fs/posix_acl.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/posix_acl.c	Tue Oct 29 09:55:28 2002
@@ -0,0 +1,423 @@
+/*
+ * linux/fs/posix_acl.c
+ *
+ *  Copyright (C) 2002 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+ *
+ *  Fixes from William Schumacher incorporated on 15 March 2001.
+ *     (Reported by Charles Bertsch, <CBertsch@microtest.com>).
+ */
+
+/*
+ *  This file contains generic functions for manipulating
+ *  POSIX 1003.1e draft standard 17 ACLs.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <asm/atomic.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/posix_acl.h>
+#include <linux/module.h>
+
+#include <linux/errno.h>
+
+EXPORT_SYMBOL(posix_acl_alloc);
+EXPORT_SYMBOL(posix_acl_clone);
+EXPORT_SYMBOL(posix_acl_valid);
+EXPORT_SYMBOL(posix_acl_equiv_mode);
+EXPORT_SYMBOL(posix_acl_from_mode);
+EXPORT_SYMBOL(posix_acl_create_masq);
+EXPORT_SYMBOL(posix_acl_chmod_masq);
+EXPORT_SYMBOL(posix_acl_masq_nfs_mode);
+EXPORT_SYMBOL(posix_acl_permission);
+
+/*
+ * Allocate a new ACL with the specified number of entries.
+ */
+struct posix_acl *
+posix_acl_alloc(int count, int flags)
+{
+	const size_t size = sizeof(struct posix_acl) +
+	                    count * sizeof(struct posix_acl_entry);
+	struct posix_acl *acl = kmalloc(size, flags);
+	if (acl) {
+		atomic_set(&acl->a_refcount, 1);
+		acl->a_count = count;
+	}
+	return acl;
+}
+
+/*
+ * Clone an ACL.
+ */
+struct posix_acl *
+posix_acl_clone(const struct posix_acl *acl, int flags)
+{
+	struct posix_acl *clone = NULL;
+
+	if (acl) {
+		int size = sizeof(struct posix_acl) + acl->a_count *
+		           sizeof(struct posix_acl_entry);
+		clone = kmalloc(size, flags);
+		if (clone) {
+			memcpy(clone, acl, size);
+			atomic_set(&clone->a_refcount, 1);
+		}
+	}
+	return clone;
+}
+
+/*
+ * Check if an acl is valid. Returns 0 if it is, or -E... otherwise.
+ */
+int
+posix_acl_valid(const struct posix_acl *acl)
+{
+	const struct posix_acl_entry *pa, *pe;
+	int state = ACL_USER_OBJ;
+	unsigned int id = 0;  /* keep gcc happy */
+	int needs_mask = 0;
+
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+		if (pa->e_perm & ~(ACL_READ|ACL_WRITE|ACL_EXECUTE))
+			return -EINVAL;
+		switch (pa->e_tag) {
+			case ACL_USER_OBJ:
+				if (state == ACL_USER_OBJ) {
+					id = 0;
+					state = ACL_USER;
+					break;
+				}
+				return -EINVAL;
+
+			case ACL_USER:
+				if (state != ACL_USER)
+					return -EINVAL;
+				if (pa->e_id == ACL_UNDEFINED_ID ||
+				    pa->e_id < id)
+					return -EINVAL;
+				id = pa->e_id + 1;
+				needs_mask = 1;
+				break;
+
+			case ACL_GROUP_OBJ:
+				if (state == ACL_USER) {
+					id = 0;
+					state = ACL_GROUP;
+					break;
+				}
+				return -EINVAL;
+
+			case ACL_GROUP:
+				if (state != ACL_GROUP)
+					return -EINVAL;
+				if (pa->e_id == ACL_UNDEFINED_ID ||
+				    pa->e_id < id)
+					return -EINVAL;
+				id = pa->e_id + 1;
+				needs_mask = 1;
+				break;
+
+			case ACL_MASK:
+				if (state != ACL_GROUP)
+					return -EINVAL;
+				state = ACL_OTHER;
+				break;
+
+			case ACL_OTHER:
+				if (state == ACL_OTHER ||
+				    (state == ACL_GROUP && !needs_mask)) {
+					state = 0;
+					break;
+				}
+				return -EINVAL;
+
+			default:
+				return -EINVAL;
+		}
+	}
+	if (state == 0)
+		return 0;
+	return -EINVAL;
+}
+
+/*
+ * Returns 0 if the acl can be exactly represented in the traditional
+ * file mode permission bits, or else 1. Returns -E... on error.
+ */
+int
+posix_acl_equiv_mode(const struct posix_acl *acl, mode_t *mode_p)
+{
+	const struct posix_acl_entry *pa, *pe;
+	mode_t mode = 0;
+	int not_equiv = 0;
+
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+		switch (pa->e_tag) {
+			case ACL_USER_OBJ:
+				mode |= (pa->e_perm & S_IRWXO) << 6;
+				break;
+			case ACL_GROUP_OBJ:
+				mode |= (pa->e_perm & S_IRWXO) << 3;
+				break;
+			case ACL_OTHER:
+				mode |= pa->e_perm & S_IRWXO;
+				break;
+			case ACL_MASK:
+				mode = (mode & ~S_IRWXG) |
+				       ((pa->e_perm & S_IRWXO) << 3);
+				not_equiv = 1;
+				break;
+			case ACL_USER:
+			case ACL_GROUP:
+				not_equiv = 1;
+				break;
+			default:
+				return -EINVAL;
+		}
+	}
+        if (mode_p)
+                *mode_p = (*mode_p & ~S_IRWXUGO) | mode;
+        return not_equiv;
+}
+
+/*
+ * Create an ACL representing the file mode permission bits of an inode.
+ */
+struct posix_acl *
+posix_acl_from_mode(mode_t mode, int flags)
+{
+	struct posix_acl *acl = posix_acl_alloc(3, flags);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+
+	acl->a_entries[0].e_tag  = ACL_USER_OBJ;
+	acl->a_entries[0].e_id   = ACL_UNDEFINED_ID;
+	acl->a_entries[0].e_perm = (mode & S_IRWXU) >> 6;
+
+	acl->a_entries[1].e_tag  = ACL_GROUP_OBJ;
+	acl->a_entries[1].e_id   = ACL_UNDEFINED_ID;
+	acl->a_entries[1].e_perm = (mode & S_IRWXG) >> 3;
+
+	acl->a_entries[2].e_tag  = ACL_OTHER;
+	acl->a_entries[2].e_id   = ACL_UNDEFINED_ID;
+	acl->a_entries[2].e_perm = (mode & S_IRWXO);
+	return acl;
+}
+
+/*
+ * Return 0 if current is granted want access to the inode
+ * by the acl. Returns -E... otherwise.
+ */
+int
+posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
+{
+	const struct posix_acl_entry *pa, *pe, *mask_obj;
+	int found = 0;
+
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+                switch(pa->e_tag) {
+                        case ACL_USER_OBJ:
+				/* (May have been checked already) */
+                                if (inode->i_uid == current->fsuid)
+                                        goto check_perm;
+                                break;
+                        case ACL_USER:
+                                if (pa->e_id == current->fsuid)
+                                        goto mask;
+				break;
+                        case ACL_GROUP_OBJ:
+                                if (in_group_p(inode->i_gid)) {
+					found = 1;
+					if ((pa->e_perm & want) == want)
+						goto mask;
+                                }
+				break;
+                        case ACL_GROUP:
+                                if (in_group_p(pa->e_id)) {
+					found = 1;
+					if ((pa->e_perm & want) == want)
+						goto mask;
+                                }
+                                break;
+                        case ACL_MASK:
+                                break;
+                        case ACL_OTHER:
+				if (found)
+					return -EACCES;
+				else
+					goto check_perm;
+			default:
+				return -EIO;
+                }
+        }
+	return -EIO;
+
+mask:
+	for (mask_obj = pa+1; mask_obj != pe; mask_obj++) {
+		if (mask_obj->e_tag == ACL_MASK) {
+			if ((pa->e_perm & mask_obj->e_perm & want) == want)
+				return 0;
+			return -EACCES;
+		}
+	}
+
+check_perm:
+	if ((pa->e_perm & want) == want)
+		return 0;
+	return -EACCES;
+}
+
+/*
+ * Modify acl when creating a new inode. The caller must ensure the acl is
+ * only referenced once.
+ *
+ * mode_p initially must contain the mode parameter to the open() / creat()
+ * system calls. All permissions that are not granted by the acl are removed.
+ * The permissions in the acl are changed to reflect the mode_p parameter.
+ */
+int
+posix_acl_create_masq(struct posix_acl *acl, mode_t *mode_p)
+{
+	struct posix_acl_entry *pa, *pe;
+	struct posix_acl_entry *group_obj = NULL, *mask_obj = NULL;
+	mode_t mode = *mode_p;
+	int not_equiv = 0;
+
+	/* assert(atomic_read(acl->a_refcount) == 1); */
+
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+                switch(pa->e_tag) {
+                        case ACL_USER_OBJ:
+				pa->e_perm &= (mode >> 6) | ~S_IRWXO;
+				mode &= (pa->e_perm << 6) | ~S_IRWXU;
+				break;
+
+			case ACL_USER:
+			case ACL_GROUP:
+				not_equiv = 1;
+				break;
+
+                        case ACL_GROUP_OBJ:
+				group_obj = pa;
+                                break;
+
+                        case ACL_OTHER:
+				pa->e_perm &= mode | ~S_IRWXO;
+				mode &= pa->e_perm | ~S_IRWXO;
+                                break;
+
+                        case ACL_MASK:
+				mask_obj = pa;
+				not_equiv = 1;
+                                break;
+
+			default:
+				return -EIO;
+                }
+        }
+
+	if (mask_obj) {
+		mask_obj->e_perm &= (mode >> 3) | ~S_IRWXO;
+		mode &= (mask_obj->e_perm << 3) | ~S_IRWXG;
+	} else {
+		if (!group_obj)
+			return -EIO;
+		group_obj->e_perm &= (mode >> 3) | ~S_IRWXO;
+		mode &= (group_obj->e_perm << 3) | ~S_IRWXG;
+	}
+
+	*mode_p = (*mode_p & ~S_IRWXUGO) | mode;
+        return not_equiv;
+}
+
+/*
+ * Modify the ACL for the chmod syscall.
+ */
+int
+posix_acl_chmod_masq(struct posix_acl *acl, mode_t mode)
+{
+	struct posix_acl_entry *group_obj = NULL, *mask_obj = NULL;
+	struct posix_acl_entry *pa, *pe;
+
+	/* assert(atomic_read(acl->a_refcount) == 1); */
+
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+		switch(pa->e_tag) {
+			case ACL_USER_OBJ:
+				pa->e_perm = (mode & S_IRWXU) >> 6;
+				break;
+
+			case ACL_USER:
+			case ACL_GROUP:
+				break;
+
+			case ACL_GROUP_OBJ:
+				group_obj = pa;
+				break;
+
+			case ACL_MASK:
+				mask_obj = pa;
+				break;
+
+			case ACL_OTHER:
+				pa->e_perm = (mode & S_IRWXO);
+				break;
+
+			default:
+				return -EIO;
+		}
+	}
+
+	if (mask_obj) {
+		mask_obj->e_perm = (mode & S_IRWXG) >> 3;
+	} else {
+		if (!group_obj)
+			return -EIO;
+		group_obj->e_perm = (mode & S_IRWXG) >> 3;
+	}
+
+	return 0;
+}
+
+/*
+ * Adjust the mode parameter so that NFSv2 grants nobody permissions
+ * that may not be granted by the ACL. This is necessary because NFSv2
+ * may compute access permissions on the client side, and may serve cached
+ * data whenever it assumes access would be granted.  Since ACLs may also
+ * be used to deny access to specific users, the minimal permissions
+ * for secure operation over NFSv2 are very restrictive. Permissions
+ * granted to users via Access Control Lists will not be effective over
+ * NFSv2.
+ *
+ * Privilege escalation can only happen for read operations, as writes are
+ * always carried out on the NFS server, where the proper access checks are
+ * implemented.
+ */
+int
+posix_acl_masq_nfs_mode(struct posix_acl *acl, mode_t *mode_p)
+{
+	struct posix_acl_entry *pa, *pe; int min_perm = S_IRWXO;
+
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+                switch(pa->e_tag) {
+			case ACL_USER_OBJ:
+				break;
+
+			case ACL_USER:
+			case ACL_GROUP_OBJ:
+			case ACL_GROUP:
+			case ACL_MASK:
+			case ACL_OTHER:
+				min_perm &= pa->e_perm;
+				break;
+
+			default:
+				return -EIO;
+		}
+	}
+	*mode_p = (*mode_p & ~(S_IRWXG|S_IRWXO)) | (min_perm << 3) | min_perm;
+
+	return 0;
+}
diff -Nru a/include/linux/posix_acl.h b/include/linux/posix_acl.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/posix_acl.h	Tue Oct 29 09:55:28 2002
@@ -0,0 +1,87 @@
+/*
+  File: linux/posix_acl.h
+
+  (C) 2002 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+
+#ifndef __LINUX_POSIX_ACL_H
+#define __LINUX_POSIX_ACL_H
+
+#include <linux/slab.h>
+
+#define ACL_UNDEFINED_ID	(-1)
+
+/* a_type field in acl_user_posix_entry_t */
+#define ACL_TYPE_ACCESS		(0x8000)
+#define ACL_TYPE_DEFAULT	(0x4000)
+
+/* e_tag entry in struct posix_acl_entry */
+#define ACL_USER_OBJ		(0x01)
+#define ACL_USER		(0x02)
+#define ACL_GROUP_OBJ		(0x04)
+#define ACL_GROUP		(0x08)
+#define ACL_MASK		(0x10)
+#define ACL_OTHER		(0x20)
+
+/* permissions in the e_perm field */
+#define ACL_READ		(0x04)
+#define ACL_WRITE		(0x02)
+#define ACL_EXECUTE		(0x01)
+//#define ACL_ADD		(0x08)
+//#define ACL_DELETE		(0x10)
+
+struct posix_acl_entry {
+	short			e_tag;
+	unsigned short		e_perm;
+	unsigned int		e_id;
+};
+
+struct posix_acl {
+	atomic_t		a_refcount;
+	unsigned int		a_count;
+	struct posix_acl_entry	a_entries[0];
+};
+
+#define FOREACH_ACL_ENTRY(pa, acl, pe) \
+	for(pa=(acl)->a_entries, pe=pa+(acl)->a_count; pa<pe; pa++)
+
+
+/*
+ * Duplicate an ACL handle.
+ */
+static inline struct posix_acl *
+posix_acl_dup(struct posix_acl *acl)
+{
+	if (acl)
+		atomic_inc(&acl->a_refcount);
+	return acl;
+}
+
+/*
+ * Free an ACL handle.
+ */
+static inline void
+posix_acl_release(struct posix_acl *acl)
+{
+	if (acl && atomic_dec_and_test(&acl->a_refcount))
+		kfree(acl);
+}
+
+
+/* posix_acl.c */
+
+extern struct posix_acl *posix_acl_alloc(int, int);
+extern struct posix_acl *posix_acl_clone(const struct posix_acl *, int);
+extern int posix_acl_valid(const struct posix_acl *);
+extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
+extern struct posix_acl *posix_acl_from_mode(mode_t, int);
+extern int posix_acl_equiv_mode(const struct posix_acl *, mode_t *);
+extern int posix_acl_create_masq(struct posix_acl *, mode_t *);
+extern int posix_acl_chmod_masq(struct posix_acl *, mode_t);
+extern int posix_acl_masq_nfs_mode(struct posix_acl *, mode_t *);
+
+extern struct posix_acl *get_posix_acl(struct inode *, int);
+extern int set_posix_acl(struct inode *, int, struct posix_acl *);
+
+#endif  /* __LINUX_POSIX_ACL_H */

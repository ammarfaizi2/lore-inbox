Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264793AbSJaI3L>; Thu, 31 Oct 2002 03:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbSJaI2n>; Thu, 31 Oct 2002 03:28:43 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:61411 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S265225AbSJaIWh>;
	Thu, 31 Oct 2002 03:22:37 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 9/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E187AhJ-0003bR-00@snap.thunk.org>
Date: Thu, 31 Oct 2002 03:29:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Port 0.8.50 acl-xattr patch to 2.5 (harmonize header file with SGI/XFS)

This patch provides converts extended attributes passed in from user
space to a generic Posix ACL representation.

 fs/Makefile                     |    5 +-
 fs/xattr_acl.c                  |   99 ++++++++++++++++++++++++++++++++++++++++
 include/linux/posix_acl_xattr.h |   55 ++++++++++++++++++++++
 include/linux/xattr_acl.h       |   50 ++++++++++++++++++++
 4 files changed, 207 insertions(+), 2 deletions(-)

diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Thu Oct 31 02:39:35 2002
+++ b/fs/Makefile	Thu Oct 31 02:39:35 2002
@@ -6,7 +6,8 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o fcblist.o mbcache.o posix_acl.o
+                fcntl.o read_write.o dcookies.o fcblist.o mbcache.o \
+		posix_acl.o xattr_acl.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
@@ -31,7 +32,7 @@
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
-obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
+obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
diff -Nru a/fs/xattr_acl.c b/fs/xattr_acl.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/xattr_acl.c	Thu Oct 31 02:39:35 2002
@@ -0,0 +1,99 @@
+/*
+ * linux/fs/xattr_acl.c
+ *
+ * Almost all from linux/fs/ext2/acl.c:
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/posix_acl_xattr.h>
+
+
+/*
+ * Convert from extended attribute to in-memory representation.
+ */
+struct posix_acl *
+posix_acl_from_xattr(const void *value, size_t size)
+{
+	posix_acl_xattr_header *header = (posix_acl_xattr_header *)value;
+	posix_acl_xattr_entry *entry = (posix_acl_xattr_entry *)(header+1), *end;
+	int count;
+	struct posix_acl *acl;
+	struct posix_acl_entry *acl_e;
+
+	if (!value)
+		return NULL;
+	if (size < sizeof(posix_acl_xattr_header))
+		 return ERR_PTR(-EINVAL);
+	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
+		return ERR_PTR(-EINVAL);
+
+	count = posix_acl_xattr_count(size);
+	if (count < 0)
+		return ERR_PTR(-EINVAL);
+	if (count == 0)
+		return NULL;
+	
+	acl = posix_acl_alloc(count, GFP_KERNEL);
+	if (!acl)
+		return ERR_PTR(-ENOMEM);
+	acl_e = acl->a_entries;
+	
+	for (end = entry + count; entry != end; acl_e++, entry++) {
+		acl_e->e_tag  = le16_to_cpu(entry->e_tag);
+		acl_e->e_perm = le16_to_cpu(entry->e_perm);
+
+		switch(acl_e->e_tag) {
+			case ACL_USER_OBJ:
+			case ACL_GROUP_OBJ:
+			case ACL_MASK:
+			case ACL_OTHER:
+				acl_e->e_id = ACL_UNDEFINED_ID;
+				break;
+
+			case ACL_USER:
+			case ACL_GROUP:
+				acl_e->e_id = le32_to_cpu(entry->e_id);
+				break;
+
+			default:
+				goto fail;
+		}
+	}
+	return acl;
+
+fail:
+	posix_acl_release(acl);
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL (posix_acl_from_xattr);
+
+/*
+ * Convert from in-memory to extended attribute representation.
+ */
+int
+posix_acl_to_xattr(const struct posix_acl *acl, void *buffer, size_t size)
+{
+	posix_acl_xattr_header *ext_acl = (posix_acl_xattr_header *)buffer;
+	posix_acl_xattr_entry *ext_entry = ext_acl->a_entries;
+	int real_size, n;
+
+	real_size = posix_acl_xattr_size(acl->a_count);
+	if (!buffer)
+		return real_size;
+	if (real_size > size)
+		return -ERANGE;
+	
+	ext_acl->a_version = cpu_to_le32(POSIX_ACL_XATTR_VERSION);
+
+	for (n=0; n < acl->a_count; n++, ext_entry++) {
+		ext_entry->e_tag  = cpu_to_le16(acl->a_entries[n].e_tag);
+		ext_entry->e_perm = cpu_to_le16(acl->a_entries[n].e_perm);
+		ext_entry->e_id   = cpu_to_le32(acl->a_entries[n].e_id);
+	}
+	return real_size;
+}
+EXPORT_SYMBOL (posix_acl_to_xattr);
diff -Nru a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/posix_acl_xattr.h	Thu Oct 31 02:39:35 2002
@@ -0,0 +1,55 @@
+/*
+  File: linux/posix_acl_xattr.h
+
+  Extended attribute system call representation of Access Control Lists.
+
+  Copyright (C) 2000 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+  Copyright (C) 2002 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+ */
+#ifndef _POSIX_ACL_XATTR_H
+#define _POSIX_ACL_XATTR_H
+
+#include <linux/posix_acl.h>
+
+/* Extended attribute names */
+#define POSIX_ACL_XATTR_ACCESS	"system.posix_acl_access"
+#define POSIX_ACL_XATTR_DEFAULT	"system.posix_acl_default"
+
+/* Supported ACL a_version fields */
+#define POSIX_ACL_XATTR_VERSION	0x0002
+
+
+/* An undefined entry e_id value */
+#define ACL_UNDEFINED_ID	(-1)
+
+typedef struct {
+	__u16			e_tag;
+	__u16			e_perm;
+	__u32			e_id;
+} posix_acl_xattr_entry;
+
+typedef struct {
+	__u32			a_version;
+	posix_acl_xattr_entry	a_entries[0];
+} posix_acl_xattr_header;
+
+
+static inline size_t
+posix_acl_xattr_size(int count)
+{
+	return (sizeof(posix_acl_xattr_header) +
+		(count * sizeof(posix_acl_xattr_entry)));
+}
+
+static inline int
+posix_acl_xattr_count(size_t size)
+{
+	if (size < sizeof(posix_acl_xattr_header))
+		return -1;
+	size -= sizeof(posix_acl_xattr_header);
+	if (size % sizeof(posix_acl_xattr_entry))
+		return -1;
+	return size / sizeof(posix_acl_xattr_entry);
+}
+
+#endif	/* _POSIX_ACL_XATTR_H */
diff -Nru a/include/linux/xattr_acl.h b/include/linux/xattr_acl.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/xattr_acl.h	Thu Oct 31 02:39:35 2002
@@ -0,0 +1,50 @@
+/*
+  File: linux/xattr_acl.h
+
+  (extended attribute representation of access control lists)
+
+  (C) 2000 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#ifndef _LINUX_XATTR_ACL_H
+#define _LINUX_XATTR_ACL_H
+
+#include <linux/posix_acl.h>
+
+#define XATTR_NAME_ACL_ACCESS	"system.posix_acl_access"
+#define XATTR_NAME_ACL_DEFAULT	"system.posix_acl_default"
+
+#define XATTR_ACL_VERSION	0x0002
+
+typedef struct {
+	__u16		e_tag;
+	__u16		e_perm;
+	__u32		e_id;
+} xattr_acl_entry;
+
+typedef struct {
+	__u32		a_version;
+	xattr_acl_entry	a_entries[0];
+} xattr_acl_header;
+
+static inline size_t xattr_acl_size(int count)
+{
+	return sizeof(xattr_acl_header) + count * sizeof(xattr_acl_entry);
+}
+
+static inline int xattr_acl_count(size_t size)
+{
+	if (size < sizeof(xattr_acl_header))
+		return -1;
+	size -= sizeof(xattr_acl_header);
+	if (size % sizeof(xattr_acl_entry))
+		return -1;
+	return size / sizeof(xattr_acl_entry);
+}
+
+struct posix_acl * posix_acl_from_xattr(const void *value, size_t size);
+int posix_acl_to_xattr(const struct posix_acl *acl, void *buffer, size_t size);
+
+
+
+#endif /* _LINUX_XATTR_ACL_H */

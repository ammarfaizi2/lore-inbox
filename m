Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSJQDSb>; Wed, 16 Oct 2002 23:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJQDRP>; Wed, 16 Oct 2002 23:17:15 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:58040 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261668AbSJQDOR>;
	Wed, 16 Oct 2002 23:14:17 -0400
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [PATCH 3/5] Posix ACL support for ext 2/3 filesystems
From: tytso@mit.edu
Message-Id: <E1821Co-0004At-00@snap.thunk.org>
Date: Wed, 16 Oct 2002 23:20:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


his patch provides converts extended attributes passed in from user
space to a generic Posix ACL representation.

                                                - Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.799   -> 1.800  
#	         fs/Makefile	1.43    -> 1.44   
#	               (new)	        -> 1.1     include/linux/xattr_acl.h
#	               (new)	        -> 1.1     fs/xattr_acl.c 
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/16	tytso@snap.thunk.org	1.800
# Port 0.8.50 acl-xattr patch to 2.5
# 
# This patch provides converts extended attributes passed in from user
# space to a generic Posix ACL representation.
# --------------------------------------------
#
diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Wed Oct 16 23:02:20 2002
+++ b/fs/Makefile	Wed Oct 16 23:02:20 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o mbcache.o
+                fcntl.o read_write.o dcookies.o mbcache.o xattr_acl.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
@@ -31,7 +31,7 @@
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
-obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
+obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
diff -Nru a/fs/xattr_acl.c b/fs/xattr_acl.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/xattr_acl.c	Wed Oct 16 23:02:20 2002
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
+#include <linux/xattr_acl.h>
+
+
+/*
+ * Convert from extended attribute to in-memory representation.
+ */
+struct posix_acl *
+posix_acl_from_xattr(const void *value, size_t size)
+{
+	xattr_acl_header *header = (xattr_acl_header *)value;
+	xattr_acl_entry *entry = (xattr_acl_entry *)(header+1), *end;
+	int count;
+	struct posix_acl *acl;
+	struct posix_acl_entry *acl_e;
+
+	if (!value)
+		return NULL;
+	if (size < sizeof(xattr_acl_header))
+		 return ERR_PTR(-EINVAL);
+	if (header->a_version != cpu_to_le32(XATTR_ACL_VERSION))
+		return ERR_PTR(-EINVAL);
+
+	count = xattr_acl_count(size);
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
+	xattr_acl_header *ext_acl = (xattr_acl_header *)buffer;
+	xattr_acl_entry *ext_entry = ext_acl->a_entries;
+	int real_size, n;
+
+	real_size = xattr_acl_size(acl->a_count);
+	if (!buffer)
+		return real_size;
+	if (real_size > size)
+		return -ERANGE;
+	
+	ext_acl->a_version = cpu_to_le32(XATTR_ACL_VERSION);
+
+	for (n=0; n < acl->a_count; n++, ext_entry++) {
+		ext_entry->e_tag  = cpu_to_le16(acl->a_entries[n].e_tag);
+		ext_entry->e_perm = cpu_to_le16(acl->a_entries[n].e_perm);
+		ext_entry->e_id   = cpu_to_le32(acl->a_entries[n].e_id);
+	}
+	return real_size;
+}
+EXPORT_SYMBOL (posix_acl_to_xattr);
diff -Nru a/include/linux/xattr_acl.h b/include/linux/xattr_acl.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/xattr_acl.h	Wed Oct 16 23:02:20 2002
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTBKTJi>; Tue, 11 Feb 2003 14:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTBKTJi>; Tue, 11 Feb 2003 14:09:38 -0500
Received: from ns.suse.de ([213.95.15.193]:22291 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265135AbTBKTJM>;
	Tue, 11 Feb 2003 14:09:12 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] Extended attribute fixes, etc.
Date: Tue, 11 Feb 2003 20:18:58 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, "Theodore T'so" <tytso@mit.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L"
Message-Id: <200302112018.58862.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

here are five patches against 2.5.60. Each file contains a brief=20
description of what it does.

The first two fix an [un]lock_kernel() bug, and an iops->listxattr() bug=20
that for some reason hasn't found its way into 2.5 yet. (Both bugs do=20
not exist in the current 2.4.19/2.4.20 patches at acl.bestbits.at).

The third to fifth are all steps towards trusted extended attributes,=20
which are useful for privileged processes (mostly daemons). One use for=20
this is Hierarchical Storage Management, in which a user space daemon=20
stores online/offline information for files in trusted EA's, and the=20
kernel communicates requests to bring files online to that daemon. This=20
class of EA's will also find its way into XFS and ReiserFS, and=20
expectedly also into JFS in this form. (Trusted EAs are included in the=20
2.4.19/2.4.20 patches as well.)

The intended patch order is:

=09kernel_lock_bug.diff=20
=09ext2_ext3_listxattr-bug.diff=20
=09xattr-flags.diff=20
=09xattr-flags-policy.diff=20
=09xattr-trusted.diff=20

Could you please feed the patches to Linus?

Thank you very much,
Andreas Gruenbacher.

--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ext2_ext3_listxattr-bug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ext2_ext3_listxattr-bug.diff"

This patch fixes a bug in the ext2 and ext3 listxattr operation: Even if
an attribute is hidden from the user, the terminating NULL character was
included in the listxattr result. After the patch this doesn't happen
anymore.

Index: linux-2.5.60/fs/ext2/acl.c
--- linux-2.5.60~ext2_ext3_listxattr-bug/fs/ext2/acl.c	2003-02-11 12:30:30.000000000 +0100
+++ linux-2.5.60/fs/ext2/acl.c	2003-02-11 12:40:11.000000000 +0100
@@ -421,26 +421,26 @@
 ext2_xattr_list_acl_access(char *list, struct inode *inode,
 			   const char *name, int name_len)
 {
-	const size_t len = sizeof(XATTR_NAME_ACL_ACCESS)-1;
+	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
 	if (list)
-		memcpy(list, XATTR_NAME_ACL_ACCESS, len);
-	return len;
+		memcpy(list, XATTR_NAME_ACL_ACCESS, size);
+	return size;
 }
 
 static size_t
 ext2_xattr_list_acl_default(char *list, struct inode *inode,
 			    const char *name, int name_len)
 {
-	const size_t len = sizeof(XATTR_NAME_ACL_DEFAULT)-1;
+	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
 	if (list)
-		memcpy(list, XATTR_NAME_ACL_DEFAULT, len);
-	return len;
+		memcpy(list, XATTR_NAME_ACL_DEFAULT, size);
+	return size;
 }
 
 static int
Index: linux-2.5.60/fs/ext2/xattr.c
--- linux-2.5.60~ext2_ext3_listxattr-bug/fs/ext2/xattr.c	2003-02-11 12:30:30.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr.c	2003-02-11 12:40:11.000000000 +0100
@@ -409,10 +409,9 @@
 			goto bad_block;
 
 		handler = ext2_xattr_handler(entry->e_name_index);
-		if (handler) {
+		if (handler)
 			size += handler->list(NULL, inode, entry->e_name,
-					      entry->e_name_len) + 1;
-		}
+					      entry->e_name_len);
 	}
 
 	if (ext2_xattr_cache_insert(bh))
@@ -433,11 +432,9 @@
 		struct ext2_xattr_handler *handler;
 		
 		handler = ext2_xattr_handler(entry->e_name_index);
-		if (handler) {
+		if (handler)
 			buf += handler->list(buf, inode, entry->e_name,
 					     entry->e_name_len);
-			*buf++ = '\0';
-		}
 	}
 	error = size;
 
Index: linux-2.5.60/fs/ext2/xattr_user.c
--- linux-2.5.60~ext2_ext3_listxattr-bug/fs/ext2/xattr_user.c	2003-02-11 12:30:30.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr_user.c	2003-02-11 12:40:11.000000000 +0100
@@ -29,8 +29,9 @@
 	if (list) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
+		list[prefix_len + name_len] = '\0';
 	}
-	return prefix_len + name_len;
+	return prefix_len + name_len + 1;
 }
 
 static int
Index: linux-2.5.60/fs/ext3/acl.c
--- linux-2.5.60~ext2_ext3_listxattr-bug/fs/ext3/acl.c	2003-02-11 12:37:36.000000000 +0100
+++ linux-2.5.60/fs/ext3/acl.c	2003-02-11 12:40:11.000000000 +0100
@@ -434,26 +434,26 @@
 ext3_xattr_list_acl_access(char *list, struct inode *inode,
 			   const char *name, int name_len)
 {
-	const size_t len = sizeof(XATTR_NAME_ACL_ACCESS)-1;
+	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
 	if (list)
-		memcpy(list, XATTR_NAME_ACL_ACCESS, len);
-	return len;
+		memcpy(list, XATTR_NAME_ACL_ACCESS, size);
+	return size;
 }
 
 static size_t
 ext3_xattr_list_acl_default(char *list, struct inode *inode,
 			    const char *name, int name_len)
 {
-	const size_t len = sizeof(XATTR_NAME_ACL_DEFAULT)-1;
+	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
 	if (list)
-		memcpy(list, XATTR_NAME_ACL_DEFAULT, len);
-	return len;
+		memcpy(list, XATTR_NAME_ACL_DEFAULT, size);
+	return size;
 }
 
 static int
Index: linux-2.5.60/fs/ext3/xattr.c
--- linux-2.5.60~ext2_ext3_listxattr-bug/fs/ext3/xattr.c	2003-02-11 12:33:45.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.c	2003-02-11 12:40:11.000000000 +0100
@@ -402,10 +402,9 @@
 			goto bad_block;
 
 		handler = ext3_xattr_handler(entry->e_name_index);
-		if (handler) {
+		if (handler)
 			size += handler->list(NULL, inode, entry->e_name,
-					      entry->e_name_len) + 1;
-		}
+					      entry->e_name_len);
 	}
 
 	if (ext3_xattr_cache_insert(bh))
@@ -426,11 +425,9 @@
 		struct ext3_xattr_handler *handler;
 
 		handler = ext3_xattr_handler(entry->e_name_index);
-		if (handler) {
+		if (handler)
 			buf += handler->list(buf, inode, entry->e_name,
 					     entry->e_name_len);
-			*buf++ = '\0';
-		}
 	}
 	error = size;
 
Index: linux-2.5.60/fs/ext3/xattr_user.c
--- linux-2.5.60~ext2_ext3_listxattr-bug/fs/ext3/xattr_user.c	2003-02-11 12:38:02.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr_user.c	2003-02-11 12:40:11.000000000 +0100
@@ -31,8 +31,9 @@
 	if (list) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
+		list[prefix_len + name_len] = '\0';
 	}
-	return prefix_len + name_len;
+	return prefix_len + name_len + 1;
 }
 
 static int

--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kernel_lock_bug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kernel_lock_bug.diff"

This patch fixes an unbalanced lock_kernel()/unlock_kernel() path in the
ext3 extended attributes code. Instead of fixing this in
fs/ext3/xattr_user.c, the locking code is modev to fs/ext3/xattr.c,
since most other types of extended attributes will need the exact same
functioanlity.

Andreas Gruenbacher <agruen@suse.de>


Index: linux-2.5.60/fs/ext3/xattr.c
--- linux-2.5.60~kernel_lock_bug/fs/ext3/xattr.c	2003-02-10 22:46:39.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.c	2003-02-11 12:33:45.000000000 +0100
@@ -88,8 +88,9 @@
 # define ea_bdebug(f...)
 #endif
 
-static int ext3_xattr_set2(handle_t *, struct inode *, struct buffer_head *,
-			   struct ext3_xattr_header *);
+static int ext3_xattr_set_handle2(handle_t *, struct inode *,
+				  struct buffer_head *,
+				  struct ext3_xattr_header *);
 
 static int ext3_xattr_cache_insert(struct buffer_head *);
 static struct buffer_head *ext3_xattr_cache_find(struct inode *,
@@ -459,7 +460,7 @@
 }
 
 /*
- * ext3_xattr_set()
+ * ext3_xattr_set_handle()
  *
  * Create, replace or remove an extended attribute for this inode. Buffer
  * is NULL to remove an existing extended attribute, and non-NULL to
@@ -471,8 +472,9 @@
  * Returns 0, or a negative error number on failure.
  */
 int
-ext3_xattr_set(handle_t *handle, struct inode *inode, int name_index,
-	       const char *name, const void *value, size_t value_len, int flags)
+ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
+		      const char *name, const void *value, size_t value_len,
+		      int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh = NULL;
@@ -673,7 +675,8 @@
 			/* Remove this attribute. */
 			if (EXT3_XATTR_NEXT(ENTRY(header+1)) == last) {
 				/* This block is now empty. */
-				error = ext3_xattr_set2(handle, inode, bh,NULL);
+				error = ext3_xattr_set_handle2(handle, inode,
+							       bh, NULL);
 				goto cleanup;
 			} else {
 				/* Remove the old name. */
@@ -701,7 +704,7 @@
 	}
 	ext3_xattr_rehash(header, here);
 
-	error = ext3_xattr_set2(handle, inode, bh, header);
+	error = ext3_xattr_set_handle2(handle, inode, bh, header);
 
 cleanup:
 	brelse(bh);
@@ -713,11 +716,12 @@
 }
 
 /*
- * Second half of ext3_xattr_set(): Update the file system.
+ * Second half of ext3_xattr_set_handle(): Update the file system.
  */
 static int
-ext3_xattr_set2(handle_t *handle, struct inode *inode,
-		struct buffer_head *old_bh, struct ext3_xattr_header *header)
+ext3_xattr_set_handle2(handle_t *handle, struct inode *inode,
+		       struct buffer_head *old_bh,
+		       struct ext3_xattr_header *header)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *new_bh = NULL;
@@ -832,6 +836,34 @@
 }
 
 /*
+ * ext3_xattr_set()
+ *
+ * Like ext3_xattr_set_handle, but start from an inode. This extended
+ * attribute modification is a filesystem transaction by itself.
+ *
+ * Returns 0, or a negative error number on failure.
+ */
+int
+ext3_xattr_set(struct inode *inode, int name_index, const char *name,
+	       const void *value, size_t value_len, int flags)
+{
+	handle_t *handle;
+	int error;
+
+	lock_kernel();
+	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
+	if (IS_ERR(handle))
+		error = PTR_ERR(handle);
+	else
+		error = ext3_xattr_set_handle(handle, inode, name_index, name,
+					      value, value_len, flags);
+	ext3_journal_stop(handle, inode);
+	unlock_kernel();
+
+	return error;
+}
+
+/*
  * ext3_xattr_delete_inode()
  *
  * Free extended attribute resources associated with this inode. This
Index: linux-2.5.60/fs/ext3/xattr.h
--- linux-2.5.60~kernel_lock_bug/fs/ext3/xattr.h	2003-02-10 22:46:39.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.h	2003-02-11 12:39:17.000000000 +0100
@@ -73,7 +73,8 @@
 
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
 extern int ext3_xattr_list(struct inode *, char *, size_t);
-extern int ext3_xattr_set(handle_t *handle, struct inode *, int, const char *, const void *, size_t, int);
+extern int ext3_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
+extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *, const void *, size_t, int);
 
 extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
 extern void ext3_xattr_put_super(struct super_block *);
@@ -101,7 +102,14 @@
 }
 
 static inline int
-ext3_xattr_set(handle_t *handle, struct inode *inode, int name_index,
+ext3_xattr_set(struct inode *inode, int name_index, const char *name,
+	       const void *value, size_t size, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 	       const char *name, const void *value, size_t size, int flags)
 {
 	return -EOPNOTSUPP;
Index: linux-2.5.60/fs/ext3/xattr_user.c
--- linux-2.5.60~kernel_lock_bug/fs/ext3/xattr_user.c	2003-02-10 22:46:39.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr_user.c	2003-02-11 12:38:02.000000000 +0100
@@ -61,7 +61,6 @@
 ext3_xattr_user_set(struct inode *inode, const char *name,
 		    const void *value, size_t size, int flags)
 {
-	handle_t *handle;
 	int error;
 
 	if (strcmp(name, "") == 0)
@@ -79,16 +78,9 @@
 	if (error)
 		return error;
   
-	lock_kernel();
-	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
-	error = ext3_xattr_set(handle, inode, EXT3_XATTR_INDEX_USER, name,
-			       value, size, flags);
-	ext3_journal_stop(handle, inode);
-	unlock_kernel();
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_USER, name,
+			      value, size, flags);
 
-	return error;
 }
 
 struct ext3_xattr_handler ext3_xattr_user_handler = {

--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xattr-trusted.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xattr-trusted.diff"

This patch adds trusted extended attributes.  Trusted extended
attributes  are visible  and  accessible only  to  processes that have
the CAP_SYS_ADMIN capability. Attributes in  this class  are  used to
implement mechanisms in user space (i.e., outside the kernel) which keep
information in extended attributes to which ordinary processes have no
access. HSM is an example.

Index: linux-2.5.60/fs/ext2/Makefile
--- linux-2.5.60~xattr-trusted/fs/ext2/Makefile	2003-02-11 12:29:38.000000000 +0100
+++ linux-2.5.60/fs/ext2/Makefile	2003-02-11 12:47:41.000000000 +0100
@@ -8,7 +8,7 @@
 	     ioctl.o namei.o super.o symlink.o
 
 ifeq ($(CONFIG_EXT2_FS_XATTR),y)
-ext2-objs += xattr.o xattr_user.o
+ext2-objs += xattr.o xattr_user.o xattr_trusted.o
 endif
 
 ifeq ($(CONFIG_EXT2_FS_POSIX_ACL),y)
Index: linux-2.5.60/fs/ext2/xattr.c
--- linux-2.5.60~xattr-trusted/fs/ext2/xattr.c	2003-02-11 12:40:20.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr.c	2003-02-11 12:47:41.000000000 +0100
@@ -1096,27 +1096,35 @@
 {
 	int	err;
 	
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
+	err = ext2_xattr_register(EXT2_XATTR_INDEX_USER,
+				  &ext2_xattr_user_handler);
 	if (err)
 		return err;
+	err = ext2_xattr_register(EXT2_XATTR_INDEX_TRUSTED,
+				  &ext2_xattr_trusted_handler);
+	if (err)
+		goto out;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	err = init_ext2_acl();
 	if (err)
-		goto out;
+		goto out1;
 #endif
 	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
 	if (!ext2_xattr_cache) {
 		err = -ENOMEM;
-		goto out1;
+		goto out2;
 	}
 	return 0;
-out1:
+out2:
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	exit_ext2_acl();
-out:
+out1:
 #endif
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
+			      &ext2_xattr_trusted_handler);
+out:
 	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
 			      &ext2_xattr_user_handler);
 	return err;
@@ -1129,5 +1137,8 @@
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 	exit_ext2_acl();
 #endif
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
+			      &ext2_xattr_trusted_handler);
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
+			      &ext2_xattr_user_handler);
 }
Index: linux-2.5.60/fs/ext2/xattr.h
--- linux-2.5.60~xattr-trusted/fs/ext2/xattr.h	2003-02-11 12:29:38.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr.h	2003-02-11 12:47:41.000000000 +0100
@@ -21,6 +21,7 @@
 #define EXT2_XATTR_INDEX_USER			1
 #define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+#define EXT2_XATTR_INDEX_TRUSTED		4
 
 struct ext2_xattr_header {
 	__u32	h_magic;	/* magic number for identification */
@@ -132,4 +133,5 @@
 # endif  /* CONFIG_EXT2_FS_XATTR */
 
 extern struct ext2_xattr_handler ext2_xattr_user_handler;
+extern struct ext2_xattr_handler ext2_xattr_trusted_handler;
 
Index: linux-2.5.60/fs/ext2/xattr_trusted.c
--- linux-2.5.60~xattr-trusted/fs/ext2/xattr_trusted.c	2003-02-11 12:47:41.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr_trusted.c	2003-02-11 12:47:41.000000000 +0100
@@ -0,0 +1,63 @@
+/*
+ * linux/fs/ext2/xattr_trusted.c
+ * Handler for trusted extended attributes.
+ *
+ * Copyright (C) 2003 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ext2_fs.h>
+#include "xattr.h"
+
+#define XATTR_TRUSTED_PREFIX "trusted."
+
+static size_t
+ext2_xattr_trusted_list(char *list, struct inode *inode,
+			const char *name, int name_len, int flags)
+{
+	const int prefix_len = sizeof(XATTR_TRUSTED_PREFIX)-1;
+
+	if (!((flags & XATTR_KERNEL_CONTEXT) || capable(CAP_SYS_ADMIN)))
+		return 0;
+
+	if (list) {
+		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
+		memcpy(list+prefix_len, name, name_len);
+		list[prefix_len + name_len] = '\0';
+	}
+	return prefix_len + name_len + 1;
+}
+
+static int
+ext2_xattr_trusted_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!((flags & XATTR_KERNEL_CONTEXT) || capable(CAP_SYS_ADMIN)))
+		return -EPERM;
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_TRUSTED, name,
+			      buffer, size);
+}
+
+static int
+ext2_xattr_trusted_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!((flags & XATTR_KERNEL_CONTEXT) || capable(CAP_SYS_ADMIN)))
+		return -EPERM;
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_TRUSTED, name,
+			      value, size, flags);
+}
+
+struct ext2_xattr_handler ext2_xattr_trusted_handler = {
+	.prefix	= XATTR_TRUSTED_PREFIX,
+	.list	= ext2_xattr_trusted_list,
+	.get	= ext2_xattr_trusted_get,
+	.set	= ext2_xattr_trusted_set,
+};
Index: linux-2.5.60/fs/ext3/Makefile
--- linux-2.5.60~xattr-trusted/fs/ext3/Makefile	2003-02-11 12:29:38.000000000 +0100
+++ linux-2.5.60/fs/ext3/Makefile	2003-02-11 12:47:41.000000000 +0100
@@ -8,7 +8,7 @@
 		ioctl.o namei.o super.o symlink.o hash.o
 
 ifeq ($(CONFIG_EXT3_FS_XATTR),y)
-ext3-objs += xattr.o xattr_user.o
+ext3-objs += xattr.o xattr_user.o xattr_trusted.o
 endif
 
 ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
Index: linux-2.5.60/fs/ext3/xattr.c
--- linux-2.5.60~xattr-trusted/fs/ext3/xattr.c	2003-02-11 12:40:20.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.c	2003-02-11 12:47:41.000000000 +0100
@@ -1133,27 +1133,35 @@
 {
 	int	err;
 	
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_USER, &ext3_xattr_user_handler);
+	err = ext3_xattr_register(EXT3_XATTR_INDEX_USER,
+				  &ext3_xattr_user_handler);
 	if (err)
 		return err;
+	err = ext3_xattr_register(EXT3_XATTR_INDEX_TRUSTED,
+				  &ext3_xattr_trusted_handler);
+	if (err)
+		goto out;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	err = init_ext3_acl();
 	if (err)
-		goto out;
+		goto out1;
 #endif
 	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
 	if (!ext3_xattr_cache) {
 		err = -ENOMEM;
-		goto out1;
+		goto out2;
 	}
 	return 0;
-out1:
+out2:
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	exit_ext3_acl();
-out:
+out1:
 #endif
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
+			      &ext3_xattr_trusted_handler);
+out:
 	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
 			      &ext3_xattr_user_handler);
 	return err;
@@ -1168,5 +1176,8 @@
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
 	exit_ext3_acl();
 #endif
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER, &ext3_xattr_user_handler);
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
+			      &ext3_xattr_trusted_handler);
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
+			      &ext3_xattr_user_handler);
 }
Index: linux-2.5.60/fs/ext3/xattr.h
--- linux-2.5.60~xattr-trusted/fs/ext3/xattr.h	2003-02-11 12:39:17.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.h	2003-02-11 12:47:41.000000000 +0100
@@ -20,6 +20,7 @@
 #define EXT3_XATTR_INDEX_USER			1
 #define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+#define EXT3_XATTR_INDEX_TRUSTED		4
 
 struct ext3_xattr_header {
 	__u32	h_magic;	/* magic number for identification */
@@ -139,3 +140,4 @@
 # endif  /* CONFIG_EXT3_FS_XATTR */
 
 extern struct ext3_xattr_handler ext3_xattr_user_handler;
+extern struct ext3_xattr_handler ext3_xattr_trusted_handler;
Index: linux-2.5.60/fs/ext3/xattr_trusted.c
--- linux-2.5.60~xattr-trusted/fs/ext3/xattr_trusted.c	2003-02-11 12:47:41.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr_trusted.c	2003-02-11 12:47:41.000000000 +0100
@@ -0,0 +1,64 @@
+/*
+ * linux/fs/ext3/xattr_trusted.c
+ * Handler for trusted extended attributes.
+ *
+ * Copyright (C) 2003 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include "xattr.h"
+
+#define XATTR_TRUSTED_PREFIX "trusted."
+
+static size_t
+ext3_xattr_trusted_list(char *list, struct inode *inode,
+			const char *name, int name_len, int flags)
+{
+	const int prefix_len = sizeof(XATTR_TRUSTED_PREFIX)-1;
+
+	if (!((flags & XATTR_KERNEL_CONTEXT) || capable(CAP_SYS_ADMIN)))
+		return 0;
+
+	if (list) {
+		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
+		memcpy(list+prefix_len, name, name_len);
+		list[prefix_len + name_len] = '\0';
+	}
+	return prefix_len + name_len + 1;
+}
+
+static int
+ext3_xattr_trusted_get(struct inode *inode, const char *name,
+		       void *buffer, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!((flags & XATTR_KERNEL_CONTEXT) || capable(CAP_SYS_ADMIN)))
+		return -EPERM;
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_TRUSTED, name,
+			      buffer, size);
+}
+
+static int
+ext3_xattr_trusted_set(struct inode *inode, const char *name,
+		       const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!((flags & XATTR_KERNEL_CONTEXT) || capable(CAP_SYS_ADMIN)))
+		return -EPERM;
+	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_TRUSTED, name,
+			      value, size, flags);
+}
+
+struct ext3_xattr_handler ext3_xattr_trusted_handler = {
+	.prefix	= XATTR_TRUSTED_PREFIX,
+	.list	= ext3_xattr_trusted_list,
+	.get	= ext3_xattr_trusted_get,
+	.set	= ext3_xattr_trusted_set,
+};

--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xattr-flags-policy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xattr-flags-policy.diff"

This adds the XATTR_KERNEL_CONTEXT extended attributes flag. Kernel
code may use this flag to override extended attribute permission
restrictions that would otherwise be imposed on the calling process.

--- linux-2.5.60~xattr-flags-policy/fs/ext2/xattr_user.c	2003-02-11 12:40:20.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr_user.c	2003-02-11 12:40:29.000000000 +0100
@@ -23,7 +23,8 @@
 {
 	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
 
-	if (!test_opt(inode->i_sb, XATTR_USER))
+	if (!(flags & XATTR_KERNEL_CONTEXT) &&
+	    !test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
 	if (list) {
@@ -38,20 +39,21 @@
 ext2_xattr_user_get(struct inode *inode, const char *name,
 		    void *buffer, size_t size, int flags)
 {
-	int error;
-
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(inode->i_sb, XATTR_USER))
-		return -EOPNOTSUPP;
+	if (!(flags & XATTR_KERNEL_CONTEXT)) {
+		int error;
+
+		if (!test_opt(inode->i_sb, XATTR_USER))
+			return -EOPNOTSUPP;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
-	error = ext2_permission_locked(inode, MAY_READ);
+		error = ext2_permission_locked(inode, MAY_READ);
 #else
-	error = permission(inode, MAY_READ);
+		error = permission(inode, MAY_READ);
 #endif
-	if (error)
-		return error;
-
+		if (error)
+			return error;
+	}
 	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_USER, name,
 			      buffer, size);
 }
@@ -60,23 +62,24 @@
 ext2_xattr_user_set(struct inode *inode, const char *name,
 		    const void *value, size_t size, int flags)
 {
-	int error;
-
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(inode->i_sb, XATTR_USER))
-		return -EOPNOTSUPP;
 	if ( !S_ISREG(inode->i_mode) &&
 	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
 		return -EPERM;
+	if (!(flags & XATTR_KERNEL_CONTEXT)) {
+		int error;
+
+		if (!test_opt(inode->i_sb, XATTR_USER))
+			return -EOPNOTSUPP;
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
-	error = ext2_permission_locked(inode, MAY_WRITE);
+		error = ext2_permission_locked(inode, MAY_WRITE);
 #else
-	error = permission(inode, MAY_WRITE);
+		error = permission(inode, MAY_WRITE);
 #endif
-	if (error)
-		return error;
-  
+		if (error)
+			return error;
+	}
 	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_USER, name,
 			      value, size, flags);
 }
Index: linux-2.5.60/fs/ext3/xattr_user.c
--- linux-2.5.60~xattr-flags-policy/fs/ext3/xattr_user.c	2003-02-11 12:40:20.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr_user.c	2003-02-11 12:46:12.000000000 +0100
@@ -25,7 +25,8 @@
 {
 	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
 
-	if (!test_opt(inode->i_sb, XATTR_USER))
+	if (!(flags & XATTR_KERNEL_CONTEXT) &&
+	    !test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
 	if (list) {
@@ -40,20 +41,21 @@
 ext3_xattr_user_get(struct inode *inode, const char *name,
 		    void *buffer, size_t size, int flags)
 {
-	int error;
-
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(inode->i_sb, XATTR_USER))
-		return -EOPNOTSUPP;
+	if (!(flags & XATTR_KERNEL_CONTEXT)) {
+		int error;
+
+		if (!test_opt(inode->i_sb, XATTR_USER))
+			return -EOPNOTSUPP;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
-	error = ext3_permission_locked(inode, MAY_READ);
+		error = ext3_permission_locked(inode, MAY_READ);
 #else
-	error = permission(inode, MAY_READ);
+		error = permission(inode, MAY_READ);
 #endif
-	if (error)
-		return error;
-
+		if (error)
+			return error;
+	}
 	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_USER, name,
 			      buffer, size);
 }
@@ -62,26 +64,26 @@
 ext3_xattr_user_set(struct inode *inode, const char *name,
 		    const void *value, size_t size, int flags)
 {
-	int error;
-
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	if (!test_opt(inode->i_sb, XATTR_USER))
-		return -EOPNOTSUPP;
 	if ( !S_ISREG(inode->i_mode) &&
 	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
 		return -EPERM;
+	if (!(flags & XATTR_KERNEL_CONTEXT)) {
+		int error;
+
+		if (!test_opt(inode->i_sb, XATTR_USER))
+			return -EOPNOTSUPP;
 #ifdef CONFIG_EXT3_FS_POSIX_ACL
-	error = ext3_permission_locked(inode, MAY_WRITE);
+		error = ext3_permission_locked(inode, MAY_WRITE);
 #else
-	error = permission(inode, MAY_WRITE);
+		error = permission(inode, MAY_WRITE);
 #endif
-	if (error)
-		return error;
-  
+		if (error)
+			return error;
+	}
 	return ext3_xattr_set(inode, EXT3_XATTR_INDEX_USER, name,
 			      value, size, flags);
-
 }
 
 struct ext3_xattr_handler ext3_xattr_user_handler = {
Index: linux-2.5.60/include/linux/xattr.h
--- linux-2.5.60~xattr-flags-policy/include/linux/xattr.h	2003-02-10 19:38:44.000000000 +0100
+++ linux-2.5.60/include/linux/xattr.h	2003-02-11 12:40:29.000000000 +0100
@@ -9,7 +9,8 @@
 #ifndef _LINUX_XATTR_H
 #define _LINUX_XATTR_H
 
-#define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
-#define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
+#define XATTR_CREATE		0x1	/* fail if attr already exists */
+#define XATTR_REPLACE		0x2	/* fail if attr does not exist */
+#define XATTR_KERNEL_CONTEXT	0x4	/* called from kernel context */
 
 #endif	/* _LINUX_XATTR_H */

--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xattr-flags.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xattr-flags.diff"

This adds flags parameters to the getxattr, listxattr, and removexattr
inode operations. This is in preparation for the next patch, which
allows in-kernel code (i.e., modules) to override extended attribute
permission restrictions (which in turn is used by HSM implementations
and the like).

Index: linux-2.5.60/fs/ext2/acl.c
--- linux-2.5.60~xattr-flags/fs/ext2/acl.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext2/acl.c	2003-02-11 13:56:43.000000000 +0100
@@ -419,7 +419,7 @@
  */
 static size_t
 ext2_xattr_list_acl_access(char *list, struct inode *inode,
-			   const char *name, int name_len)
+			   const char *name, int name_len, int flags)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
 
@@ -432,7 +432,7 @@
 
 static size_t
 ext2_xattr_list_acl_default(char *list, struct inode *inode,
-			    const char *name, int name_len)
+			    const char *name, int name_len, int flags)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
 
@@ -465,7 +465,7 @@
 
 static int
 ext2_xattr_get_acl_access(struct inode *inode, const char *name,
-			  void *buffer, size_t size)
+			  void *buffer, size_t size, int flags)
 {
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
@@ -474,7 +474,7 @@
 
 static int
 ext2_xattr_get_acl_default(struct inode *inode, const char *name,
-			   void *buffer, size_t size)
+			   void *buffer, size_t size, int flags)
 {
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
@@ -482,7 +482,8 @@
 }
 
 static int
-ext2_xattr_set_acl(struct inode *inode, int type, const void *value, size_t size)
+ext2_xattr_set_acl(struct inode *inode, int type, const void *value,
+		   size_t size)
 {
 	struct posix_acl *acl;
 	int error;
Index: linux-2.5.60/fs/ext2/xattr.c
--- linux-2.5.60~xattr-flags/fs/ext2/xattr.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr.c	2003-02-11 13:56:43.000000000 +0100
@@ -199,7 +199,7 @@
  */
 ssize_t
 ext2_getxattr(struct dentry *dentry, const char *name,
-	      void *buffer, size_t size)
+	      void *buffer, size_t size, int flags)
 {
 	struct ext2_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
@@ -207,7 +207,7 @@
 	handler = ext2_xattr_resolve_name(&name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->get(inode, name, buffer, size);
+	return handler->get(inode, name, buffer, size, flags);
 }
 
 /*
@@ -217,9 +217,9 @@
  * BKL held [before 2.5.x]
  */
 ssize_t
-ext2_listxattr(struct dentry *dentry, char *buffer, size_t size)
+ext2_listxattr(struct dentry *dentry, char *buffer, size_t size, int flags)
 {
-	return ext2_xattr_list(dentry->d_inode, buffer, size);
+	return ext2_xattr_list(dentry->d_inode, buffer, size, flags);
 }
 
 /*
@@ -250,7 +250,7 @@
  * BKL held [before 2.5.x]
  */
 int
-ext2_removexattr(struct dentry *dentry, const char *name)
+ext2_removexattr(struct dentry *dentry, const char *name, int flags)
 {
 	struct ext2_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
@@ -258,7 +258,7 @@
 	handler = ext2_xattr_resolve_name(&name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+	return handler->set(inode, name, NULL, 0, flags | XATTR_REPLACE);
 }
 
 /*
@@ -371,7 +371,8 @@
  * used / required on success.
  */
 int
-ext2_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+ext2_xattr_list(struct inode *inode, char *buffer, size_t buffer_size,
+		int flags)
 {
 	struct buffer_head *bh = NULL;
 	struct ext2_xattr_entry *entry;
@@ -411,7 +412,7 @@
 		handler = ext2_xattr_handler(entry->e_name_index);
 		if (handler)
 			size += handler->list(NULL, inode, entry->e_name,
-					      entry->e_name_len);
+					      entry->e_name_len, flags);
 	}
 
 	if (ext2_xattr_cache_insert(bh))
@@ -434,7 +435,7 @@
 		handler = ext2_xattr_handler(entry->e_name_index);
 		if (handler)
 			buf += handler->list(buf, inode, entry->e_name,
-					     entry->e_name_len);
+					     entry->e_name_len, flags);
 	}
 	error = size;
 
Index: linux-2.5.60/fs/ext2/xattr.h
--- linux-2.5.60~xattr-flags/fs/ext2/xattr.h	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr.h	2003-02-11 14:02:30.000000000 +0100
@@ -57,9 +57,9 @@
 struct ext2_xattr_handler {
 	char *prefix;
 	size_t (*list)(char *list, struct inode *inode, const char *name,
-		       int name_len);
+		       int name_len, int flags);
 	int (*get)(struct inode *inode, const char *name, void *buffer,
-		   size_t size);
+		   size_t size, int flags);
 	int (*set)(struct inode *inode, const char *name, const void *buffer,
 		   size_t size, int flags);
 };
@@ -68,12 +68,12 @@
 extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
 
 extern int ext2_setxattr(struct dentry *, const char *, const void *, size_t, int);
-extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
-extern int ext2_removexattr(struct dentry *, const char *);
+extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t ext2_listxattr(struct dentry *, char *, size_t, int);
+extern int ext2_removexattr(struct dentry *, const char *, int);
 
 extern int ext2_xattr_get(struct inode *, int, const char *, void *, size_t);
-extern int ext2_xattr_list(struct inode *, char *, size_t);
+extern int ext2_xattr_list(struct inode *, char *, size_t, int flags);
 extern int ext2_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
 
 extern void ext2_xattr_delete_inode(struct inode *);
Index: linux-2.5.60/fs/ext2/xattr_user.c
--- linux-2.5.60~xattr-flags/fs/ext2/xattr_user.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext2/xattr_user.c	2003-02-11 13:56:43.000000000 +0100
@@ -19,7 +19,7 @@
 
 static size_t
 ext2_xattr_user_list(char *list, struct inode *inode,
-		     const char *name, int name_len)
+		     const char *name, int name_len, int flags)
 {
 	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
 
@@ -36,7 +36,7 @@
 
 static int
 ext2_xattr_user_get(struct inode *inode, const char *name,
-		    void *buffer, size_t size)
+		    void *buffer, size_t size, int flags)
 {
 	int error;
 
Index: linux-2.5.60/fs/ext3/acl.c
--- linux-2.5.60~xattr-flags/fs/ext3/acl.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext3/acl.c	2003-02-11 13:56:43.000000000 +0100
@@ -432,7 +432,7 @@
  */
 static size_t
 ext3_xattr_list_acl_access(char *list, struct inode *inode,
-			   const char *name, int name_len)
+			   const char *name, int name_len, int flags)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
 
@@ -445,7 +445,7 @@
 
 static size_t
 ext3_xattr_list_acl_default(char *list, struct inode *inode,
-			    const char *name, int name_len)
+			    const char *name, int name_len, int flags)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
 
@@ -478,7 +478,7 @@
 
 static int
 ext3_xattr_get_acl_access(struct inode *inode, const char *name,
-			  void *buffer, size_t size)
+			  void *buffer, size_t size, int flags)
 {
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
@@ -487,7 +487,7 @@
 
 static int
 ext3_xattr_get_acl_default(struct inode *inode, const char *name,
-			   void *buffer, size_t size)
+			   void *buffer, size_t size, int flags)
 {
 	if (strcmp(name, "") != 0)
 		return -EINVAL;
@@ -495,7 +495,8 @@
 }
 
 static int
-ext3_xattr_set_acl(struct inode *inode, int type, const void *value, size_t size)
+ext3_xattr_set_acl(struct inode *inode, int type, const void *value,
+		   size_t size)
 {
 	handle_t *handle;
 	struct posix_acl *acl;
Index: linux-2.5.60/fs/ext3/xattr.c
--- linux-2.5.60~xattr-flags/fs/ext3/xattr.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.c	2003-02-11 13:56:43.000000000 +0100
@@ -195,7 +195,7 @@
  */
 ssize_t
 ext3_getxattr(struct dentry *dentry, const char *name,
-	      void *buffer, size_t size)
+	      void *buffer, size_t size, int flags)
 {
 	struct ext3_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
@@ -203,7 +203,7 @@
 	handler = ext3_xattr_resolve_name(&name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->get(inode, name, buffer, size);
+	return handler->get(inode, name, buffer, size, flags);
 }
 
 /*
@@ -212,9 +212,9 @@
  * dentry->d_inode->i_sem down
  */
 ssize_t
-ext3_listxattr(struct dentry *dentry, char *buffer, size_t size)
+ext3_listxattr(struct dentry *dentry, char *buffer, size_t size, int flags)
 {
-	return ext3_xattr_list(dentry->d_inode, buffer, size);
+	return ext3_xattr_list(dentry->d_inode, buffer, size, flags);
 }
 
 /*
@@ -243,7 +243,7 @@
  * dentry->d_inode->i_sem down
  */
 int
-ext3_removexattr(struct dentry *dentry, const char *name)
+ext3_removexattr(struct dentry *dentry, const char *name, int flags)
 {
 	struct ext3_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
@@ -251,7 +251,7 @@
 	handler = ext3_xattr_resolve_name(&name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+	return handler->set(inode, name, NULL, 0, flags | XATTR_REPLACE);
 }
 
 /*
@@ -364,7 +364,8 @@
  * used / required on success.
  */
 int
-ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size,
+		int flags)
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
@@ -404,7 +405,7 @@
 		handler = ext3_xattr_handler(entry->e_name_index);
 		if (handler)
 			size += handler->list(NULL, inode, entry->e_name,
-					      entry->e_name_len);
+					      entry->e_name_len, flags);
 	}
 
 	if (ext3_xattr_cache_insert(bh))
@@ -427,7 +428,7 @@
 		handler = ext3_xattr_handler(entry->e_name_index);
 		if (handler)
 			buf += handler->list(buf, inode, entry->e_name,
-					     entry->e_name_len);
+					     entry->e_name_len, flags);
 	}
 	error = size;
 
Index: linux-2.5.60/fs/ext3/xattr.h
--- linux-2.5.60~xattr-flags/fs/ext3/xattr.h	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr.h	2003-02-11 14:00:59.000000000 +0100
@@ -56,9 +56,9 @@
 struct ext3_xattr_handler {
 	char *prefix;
 	size_t (*list)(char *list, struct inode *inode, const char *name,
-		       int name_len);
+		       int name_len, int flags);
 	int (*get)(struct inode *inode, const char *name, void *buffer,
-		   size_t size);
+		   size_t size, int flags);
 	int (*set)(struct inode *inode, const char *name, const void *buffer,
 		   size_t size, int flags);
 };
@@ -67,12 +67,12 @@
 extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
 
 extern int ext3_setxattr(struct dentry *, const char *, const void *, size_t, int);
-extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
-extern int ext3_removexattr(struct dentry *, const char *);
+extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t ext3_listxattr(struct dentry *, char *, size_t, int);
+extern int ext3_removexattr(struct dentry *, const char *, int);
 
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
-extern int ext3_xattr_list(struct inode *, char *, size_t);
+extern int ext3_xattr_list(struct inode *, char *, size_t, int flags);
 extern int ext3_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
 extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *, const void *, size_t, int);
 
Index: linux-2.5.60/fs/ext3/xattr_user.c
--- linux-2.5.60~xattr-flags/fs/ext3/xattr_user.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/ext3/xattr_user.c	2003-02-11 13:56:43.000000000 +0100
@@ -21,7 +21,7 @@
 
 static size_t
 ext3_xattr_user_list(char *list, struct inode *inode,
-		     const char *name, int name_len)
+		     const char *name, int name_len, int flags)
 {
 	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
 
@@ -38,7 +38,7 @@
 
 static int
 ext3_xattr_user_get(struct inode *inode, const char *name,
-		    void *buffer, size_t size)
+		    void *buffer, size_t size, int flags)
 {
 	int error;
 
Index: linux-2.5.60/fs/xattr.c
--- linux-2.5.60~xattr-flags/fs/xattr.c	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/fs/xattr.c	2003-02-11 13:56:43.000000000 +0100
@@ -160,7 +160,7 @@
 		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
-		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
+		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size, 0);
 		up(&d->d_inode->i_sem);
 	}
 
@@ -233,7 +233,7 @@
 		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
-		error = d->d_inode->i_op->listxattr(d, klist, size);
+		error = d->d_inode->i_op->listxattr(d, klist, size, 0);
 		up(&d->d_inode->i_sem);
 	}
 
@@ -308,7 +308,7 @@
 		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
-		error = d->d_inode->i_op->removexattr(d, kname);
+		error = d->d_inode->i_op->removexattr(d, kname, 0);
 		up(&d->d_inode->i_sem);
 	}
 out:
Index: linux-2.5.60/include/linux/fs.h
--- linux-2.5.60~xattr-flags/include/linux/fs.h	2003-02-11 13:56:41.000000000 +0100
+++ linux-2.5.60/include/linux/fs.h	2003-02-11 13:56:43.000000000 +0100
@@ -743,9 +743,9 @@
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
 	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
-	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
-	ssize_t (*listxattr) (struct dentry *, char *, size_t);
-	int (*removexattr) (struct dentry *, const char *);
+	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t,int);
+	ssize_t (*listxattr) (struct dentry *, char *, size_t, int);
+	int (*removexattr) (struct dentry *, const char *, int);
 };
 
 struct seq_file;
Index: linux-2.5.60/fs/jfs/xattr.c
--- linux-2.5.60~xattr-flags/fs/jfs/xattr.c	2003-02-10 19:38:20.000000000 +0100
+++ linux-2.5.60/fs/jfs/xattr.c	2003-02-11 14:07:06.000000000 +0100
@@ -962,12 +962,13 @@
 }
 
 ssize_t jfs_getxattr(struct dentry *dentry, const char *name, void *data,
-		     size_t buf_size)
+		     size_t buf_size, int flags)
 {
 	return __jfs_getxattr(dentry->d_inode, name, data, buf_size);
 }
 
-ssize_t jfs_listxattr(struct dentry * dentry, char *data, size_t buf_size)
+ssize_t jfs_listxattr(struct dentry * dentry, char *data, size_t buf_size,
+		      int flags)
 {
 	struct inode *inode = dentry->d_inode;
 	char *buffer;
@@ -1013,7 +1014,7 @@
 	return size;
 }
 
-int jfs_removexattr(struct dentry *dentry, const char *name)
+int jfs_removexattr(struct dentry *dentry, const char *name, int flags)
 {
 	return __jfs_setxattr(dentry->d_inode, name, 0, 0, XATTR_REPLACE);
 }
Index: linux-2.5.60/fs/jfs/jfs_xattr.h
--- linux-2.5.60~xattr-flags/fs/jfs/jfs_xattr.h	2003-02-10 19:38:52.000000000 +0100
+++ linux-2.5.60/fs/jfs/jfs_xattr.h	2003-02-11 14:07:49.000000000 +0100
@@ -57,8 +57,8 @@
 extern int jfs_setxattr(struct dentry *, const char *, const void *, size_t,
 			int);
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
-extern ssize_t jfs_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t jfs_listxattr(struct dentry *, char *, size_t);
-extern int jfs_removexattr(struct dentry *, const char *);
+extern ssize_t jfs_getxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t jfs_listxattr(struct dentry *, char *, size_t, int);
+extern int jfs_removexattr(struct dentry *, const char *, int);
 
 #endif	/* H_JFS_XATTR */
Index: linux-2.5.60/fs/xfs/linux/xfs_iops.c
--- linux-2.5.60~xattr-flags/fs/xfs/linux/xfs_iops.c	2003-02-10 19:38:17.000000000 +0100
+++ linux-2.5.60/fs/xfs/linux/xfs_iops.c	2003-02-11 14:10:51.000000000 +0100
@@ -640,7 +640,8 @@
 	struct dentry	*dentry,
 	const char	*name,
 	void		*data,
-	size_t		size)
+	size_t		size,
+	int		flags)
 {
 	ssize_t		error;
 	int		xflags = 0;
@@ -697,7 +698,8 @@
 linvfs_listxattr(
 	struct dentry		*dentry,
 	char			*data,
-	size_t			size)
+	size_t			size,
+	int			flags)
 {
 	ssize_t			error;
 	int			result = 0;
@@ -741,7 +743,8 @@
 STATIC int
 linvfs_removexattr(
 	struct dentry	*dentry,
-	const char	*name)
+	const char	*name,
+	int		flags)
 {
 	int		error;
 	int		xflags = 0;

--------------Boundary-00=_MBS5CUR0E9HRKQKOIL3L--


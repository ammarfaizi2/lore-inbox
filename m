Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUBER3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbUBER3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:29:03 -0500
Received: from ns.suse.de ([195.135.220.2]:50097 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266481AbUBER16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:27:58 -0500
Subject: [RFC PATCH] Remove arbitrary #acl entries limits
From: Andreas Gruenbacher <agruen@suse.de>
To: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-nvBiAl0p0BBbfDizFlF/"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1076001953.27389.47.camel@E136.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 05 Feb 2004 18:25:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nvBiAl0p0BBbfDizFlF/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

some users have complained about the limit of 32 acl entries on ext2 and
ext3. There is no reason for this limit other than enforcing "reasonably
short" acls. The attached patches (in this order) remove this limit.

  ext23-no-ace-read-limit.diff
  ext23-no-ace-write-limit.diff

The first patch ensures that big acls can properly be read. The second
removes the check when writing. With both patches applied, ext[23]
supports up to 123 acl entries with 1k-blocks, and up to 507 entries
with 4k-blocks.

[XFS inherits a limit of 25 acl entries from Irix. The other file
systems that support acls (jfs, reiserfs) enforce no limit, which means
that up to 8181 acl entries are theoretically possible.]

The write patch unfortunately breaks backward compatibility: Older
kernels cannot read ACLs with more than 32 entries; accessing such files
will result in EIO.

I don't think breaking backward compatibility in this way is acceptable,
so IMHO we should  apply only the "read" patch now, as it ensures a more
or less painless upgrade later. (I will also add the read patch to the
2.4 patch set.)


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-nvBiAl0p0BBbfDizFlF/
Content-Disposition: attachment; filename=ext23-no-ace-read-limit.diff
Content-Type: text/plain; name=ext23-no-ace-read-limit.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove arbitrary #acl entries limits on ext[23] when reading

This patch removes the arbitrary limit of 32 ACL entries on
ext[23] when reading from disk. This change is backward compatible.

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs


Index: linux-2.6.2/fs/ext2/acl.c
===================================================================
--- linux-2.6.2.orig/fs/ext2/acl.c
+++ linux-2.6.2/fs/ext2/acl.c
@@ -154,10 +154,9 @@ ext2_iset_acl(struct inode *inode, struc
 static struct posix_acl *
 ext2_get_acl(struct inode *inode, int type)
 {
-	const size_t max_size = ext2_acl_size(EXT2_ACL_MAX_ENTRIES);
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	int name_index;
-	char *value;
+	char *value = NULL;
 	struct posix_acl *acl;
 	int retval;
 
@@ -182,17 +181,21 @@ ext2_get_acl(struct inode *inode, int ty
 		default:
 			return ERR_PTR(-EINVAL);
 	}
-	value = kmalloc(max_size, GFP_KERNEL);
-	if (!value)
-		return ERR_PTR(-ENOMEM);
-
-	retval = ext2_xattr_get(inode, name_index, "", value, max_size);
-	acl = ERR_PTR(retval);
-	if (retval >= 0)
+	retval = ext2_xattr_get(inode, name_index, "", NULL, 0);
+	if (retval > 0) {
+		value = kmalloc(retval, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		retval = ext2_xattr_get(inode, name_index, "", value, retval);
+	}
+	if (retval > 0)
 		acl = ext2_acl_from_disk(value, retval);
 	else if (retval == -ENODATA || retval == -ENOSYS)
 		acl = NULL;
-	kfree(value);
+	else
+		acl = ERR_PTR(retval);
+	if (value)
+		kfree(value);
 
 	if (!IS_ERR(acl)) {
 		switch(type) {
Index: linux-2.6.2/fs/ext3/acl.c
===================================================================
--- linux-2.6.2.orig/fs/ext3/acl.c
+++ linux-2.6.2/fs/ext3/acl.c
@@ -157,10 +157,9 @@ ext3_iset_acl(struct inode *inode, struc
 static struct posix_acl *
 ext3_get_acl(struct inode *inode, int type)
 {
-	const size_t max_size = ext3_acl_size(EXT3_ACL_MAX_ENTRIES);
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	int name_index;
-	char *value;
+	char *value = NULL;
 	struct posix_acl *acl;
 	int retval;
 
@@ -185,17 +184,21 @@ ext3_get_acl(struct inode *inode, int ty
 		default:
 			return ERR_PTR(-EINVAL);
 	}
-	value = kmalloc(max_size, GFP_KERNEL);
-	if (!value)
-		return ERR_PTR(-ENOMEM);
-
-	retval = ext3_xattr_get(inode, name_index, "", value, max_size);
-	acl = ERR_PTR(retval);
+	retval = ext2_xattr_get(inode, name_index, "", NULL, 0);
+	if (retval > 0) {
+		value = kmalloc(retval, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		retval = ext2_xattr_get(inode, name_index, "", value, retval);
+	}
 	if (retval > 0)
 		acl = ext3_acl_from_disk(value, retval);
 	else if (retval == -ENODATA || retval == -ENOSYS)
 		acl = NULL;
-	kfree(value);
+	else
+		acl = ERR_PTR(retval);
+	if (value)
+		kfree(value);
 
 	if (!IS_ERR(acl)) {
 		switch(type) {

--=-nvBiAl0p0BBbfDizFlF/
Content-Disposition: attachment; filename=ext23-no-ace-write-limit.diff
Content-Type: text/plain; name=ext23-no-ace-write-limit.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove arbitrary #acl entries limits on ext[23] when writing

This patch removes the arbitrary limit of 32 ACL entries on
ext[23] when writing. With the path applied, the available space in
the xattr block determines the effective number-of-entries limit.
Even before this patch the xattr block could contain less space than
required for the acl, so no additional error conditions are introduced.

When kernels without the ext23-no-ace-read-limit.diff patch try to
access a file with an acl that is too big, they will return ERANGE
in the getxattr syscalls; access to the file will be denied. Big acls
can still be replaced with `setfacl --set'.

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs


Index: linux-2.6.2/fs/ext2/acl.c
===================================================================
--- linux-2.6.2.orig/fs/ext2/acl.c
+++ linux-2.6.2/fs/ext2/acl.c
@@ -255,8 +255,6 @@ ext2_set_acl(struct inode *inode, int ty
 			return -EINVAL;
 	}
  	if (acl) {
-		if (acl->a_count > EXT2_ACL_MAX_ENTRIES)
-			return -EINVAL;
 		value = ext2_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);
Index: linux-2.6.2/fs/ext2/acl.h
===================================================================
--- linux-2.6.2.orig/fs/ext2/acl.h
+++ linux-2.6.2/fs/ext2/acl.h
@@ -7,7 +7,6 @@
 #include <linux/xattr_acl.h>
 
 #define EXT2_ACL_VERSION	0x0001
-#define EXT2_ACL_MAX_ENTRIES	32
 
 typedef struct {
 	__u16		e_tag;
Index: linux-2.6.2/fs/ext3/acl.c
===================================================================
--- linux-2.6.2.orig/fs/ext3/acl.c
+++ linux-2.6.2/fs/ext3/acl.c
@@ -259,8 +259,6 @@ ext3_set_acl(handle_t *handle, struct in
 			return -EINVAL;
 	}
  	if (acl) {
-		if (acl->a_count > EXT3_ACL_MAX_ENTRIES)
-			return -EINVAL;
 		value = ext3_acl_to_disk(acl, &size);
 		if (IS_ERR(value))
 			return (int)PTR_ERR(value);
Index: linux-2.6.2/fs/ext3/acl.h
===================================================================
--- linux-2.6.2.orig/fs/ext3/acl.h
+++ linux-2.6.2/fs/ext3/acl.h
@@ -7,7 +7,6 @@
 #include <linux/xattr_acl.h>
 
 #define EXT3_ACL_VERSION	0x0001
-#define EXT3_ACL_MAX_ENTRIES	32
 
 typedef struct {
 	__u16		e_tag;

--=-nvBiAl0p0BBbfDizFlF/--


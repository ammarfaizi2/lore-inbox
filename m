Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUCGAVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 19:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCGAVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 19:21:14 -0500
Received: from ns.suse.de ([195.135.220.2]:57551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261476AbUCGAVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 19:21:08 -0500
Subject: Remove arbitrary #acl entries limits on ext[23] when reading
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1078618902.3155.116.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 07 Mar 2004 01:21:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

could you please add this patch to the mainline kernel. It removes the
arbitrary limit of 32 ACL entries on ext[23] when reading from disk.
This change is backward compatible; we need to have this change in to be
able to also allow writing big ACLs. We have the patch in our kernel
since a while now.

The second patch that removes the ACL entry limit for writes is not
included. I don't want to push that patch now, because large ACLs would
cause 2.4 and current 2.6 kernels to fail. My plan is to remove the
second limit later, in a half-year or year or so. If you think we should
go the full way I wouldn't mind, however.


Index: linux-2.6.3/fs/ext2/acl.c
===================================================================
--- linux-2.6.3.orig/fs/ext2/acl.c
+++ linux-2.6.3/fs/ext2/acl.c
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
Index: linux-2.6.3/fs/ext3/acl.c
===================================================================
--- linux-2.6.3.orig/fs/ext3/acl.c
+++ linux-2.6.3/fs/ext3/acl.c
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
+	retval = ext3_xattr_get(inode, name_index, "", NULL, 0);
+	if (retval > 0) {
+		value = kmalloc(retval, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		retval = ext3_xattr_get(inode, name_index, "", value, retval);
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


Thank you,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


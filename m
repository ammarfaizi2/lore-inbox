Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUIWNYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUIWNYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUIWNYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:24:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:6579 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268447AbUIWNYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:24:16 -0400
Subject: Re: [PATCH 0/6] xattr consolidation v3
From: Andreas Gruenbacher <agruen@suse.de>
To: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Xine.LNX.4.44.0409222342090.447-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0409222342090.447-100000@thoron.boston.redhat.com>
Content-Type: multipart/mixed; boundary="=-gvecPQra3BePY1WdD2Gg"
Organization: SUSE Labs
Message-Id: <1095945983.27603.9.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 15:26:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gvecPQra3BePY1WdD2Gg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Looks good IMO -- thanks, James.

There is one minor issue in the ext[23]_xattr_list changes: The xattr
block gets inserted into the cache even if it later turns out to be
corrupted. The attached patch reintroduces the sanity check, and has a
few other cosmetical-only changes.

Andrew, do you want to add this to -mm?

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


--=-gvecPQra3BePY1WdD2Gg
Content-Disposition: attachment; filename=delta.diff
Content-Type: text/x-patch; name=delta.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.9-rc2/fs/ext2/acl.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext2/acl.c
+++ linux-2.6.9-rc2/fs/ext2/acl.c
@@ -436,7 +436,7 @@ ext2_xattr_list_acl_access(struct inode 
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
-	if (list && (size <= list_size))
+	if (list && size <= list_size)
 		memcpy(list, XATTR_NAME_ACL_ACCESS, size);
 	return size;
 }
@@ -449,7 +449,7 @@ ext2_xattr_list_acl_default(struct inode
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
-	if (list && (size <= list_size))
+	if (list && size <= list_size)
 		memcpy(list, XATTR_NAME_ACL_DEFAULT, size);
 	return size;
 }
Index: linux-2.6.9-rc2/fs/ext2/xattr.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext2/xattr.c
+++ linux-2.6.9-rc2/fs/ext2/xattr.c
@@ -270,7 +270,6 @@ ext2_xattr_list(struct inode *inode, cha
 {
 	struct buffer_head *bh = NULL;
 	struct ext2_xattr_entry *entry;
-	size_t total_size = 0;
 	char *buf, *end;
 	int error;
 
@@ -298,6 +297,15 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 		goto cleanup;
 	}
 
+	/* check the on-disk data structure */
+	entry = FIRST_ENTRY(bh);
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(entry);
+
+		if ((char *)next >= end)
+			goto bad_block;
+		entry = next;
+	}
 	if (ext2_xattr_cache_insert(bh))
 		ea_idebug(inode, "cache insert failed");
 
@@ -305,13 +313,9 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 	buf = buffer;
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT2_XATTR_NEXT(entry)) {
-		struct xattr_handler *handler;
-		struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(entry);
-		
-		if ((char *)next >= end)
-			goto bad_block;
-			
-		handler = ext2_xattr_handler(entry->e_name_index);
+		struct xattr_handler *handler =
+			ext2_xattr_handler(entry->e_name_index);
+
 		if (handler) {
 			size_t size = handler->list(inode, buf, buffer_size,
 						    entry->e_name,
@@ -324,10 +328,9 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 				buf += size;
 				buffer_size -= size;
 			}
-			total_size += size;
 		}
 	}
-	error = total_size;
+	error = buf - buffer;  /* total size */
 
 cleanup:
 	brelse(bh);
Index: linux-2.6.9-rc2/fs/ext2/xattr_security.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext2/xattr_security.c
+++ linux-2.6.9-rc2/fs/ext2/xattr_security.c
@@ -17,7 +17,7 @@ ext2_xattr_security_list(struct inode *i
 	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
 	const size_t total_len = prefix_len + name_len + 1;
 	
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2/fs/ext2/xattr_trusted.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext2/xattr_trusted.c
+++ linux-2.6.9-rc2/fs/ext2/xattr_trusted.c
@@ -24,7 +24,7 @@ ext2_xattr_trusted_list(struct inode *in
 	if (!capable(CAP_SYS_ADMIN))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2/fs/ext2/xattr_user.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext2/xattr_user.c
+++ linux-2.6.9-rc2/fs/ext2/xattr_user.c
@@ -23,7 +23,7 @@ ext2_xattr_user_list(struct inode *inode
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2/fs/ext3/acl.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext3/acl.c
+++ linux-2.6.9-rc2/fs/ext3/acl.c
@@ -459,7 +459,7 @@ ext3_xattr_list_acl_access(struct inode 
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
-	if (list && (size <= list_len))
+	if (list && size <= list_len)
 		memcpy(list, XATTR_NAME_ACL_ACCESS, size);
 	return size;
 }
@@ -472,7 +472,7 @@ ext3_xattr_list_acl_default(struct inode
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
-	if (list && (size <= list_len))
+	if (list && size <= list_len)
 		memcpy(list, XATTR_NAME_ACL_DEFAULT, size);
 	return size;
 }
Index: linux-2.6.9-rc2/fs/ext3/xattr.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext3/xattr.c
+++ linux-2.6.9-rc2/fs/ext3/xattr.c
@@ -267,7 +267,6 @@ ext3_xattr_list(struct inode *inode, cha
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
-	size_t total_size = 0;
 	char *buf, *end;
 	int error;
 
@@ -295,6 +294,15 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 		goto cleanup;
 	}
 
+	/* check the on-disk data structure */
+	entry = FIRST_ENTRY(bh);
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(entry);
+
+		if ((char *)next >= end)
+			goto bad_block;
+		entry = next;
+	}
 	if (ext3_xattr_cache_insert(bh))
 		ea_idebug(inode, "cache insert failed");
 
@@ -302,13 +310,9 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 	buf = buffer;
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT3_XATTR_NEXT(entry)) {
-		struct xattr_handler *handler;
-		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(entry);
-
-		if ((char *)next >= end)
-			goto bad_block;
+		struct xattr_handler *handler =
+			ext3_xattr_handler(entry->e_name_index);
 
-		handler = ext3_xattr_handler(entry->e_name_index);
 		if (handler) {
 			size_t size = handler->list(inode, buf, buffer_size,
 						    entry->e_name,
@@ -321,10 +325,9 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 				buf += size;
 				buffer_size -= size;
 			}
-			total_size += size;
 		}
 	}
-	error = total_size;
+	error = buf - buffer;  /* total size */
 
 cleanup:
 	brelse(bh);
Index: linux-2.6.9-rc2/fs/ext3/xattr_security.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext3/xattr_security.c
+++ linux-2.6.9-rc2/fs/ext3/xattr_security.c
@@ -19,7 +19,7 @@ ext3_xattr_security_list(struct inode *i
 	const size_t total_len = prefix_len + name_len + 1;
 	
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2/fs/ext3/xattr_trusted.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext3/xattr_trusted.c
+++ linux-2.6.9-rc2/fs/ext3/xattr_trusted.c
@@ -25,7 +25,7 @@ ext3_xattr_trusted_list(struct inode *in
 	if (!capable(CAP_SYS_ADMIN))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2/fs/ext3/xattr_user.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/ext3/xattr_user.c
+++ linux-2.6.9-rc2/fs/ext3/xattr_user.c
@@ -25,7 +25,7 @@ ext3_xattr_user_list(struct inode *inode
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2/fs/xattr.c
===================================================================
--- linux-2.6.9-rc2.orig/fs/xattr.c
+++ linux-2.6.9-rc2/fs/xattr.c
@@ -351,7 +351,8 @@ sys_fremovexattr(int fd, char __user *na
 }
 
 
-static const char *strcmp_prefix(const char *a, const char *a_prefix)
+static const char *
+strcmp_prefix(const char *a, const char *a_prefix)
 {
 	while (*a_prefix && *a == *a_prefix) {
 		a++;

--=-gvecPQra3BePY1WdD2Gg--


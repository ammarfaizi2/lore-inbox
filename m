Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUIXXCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUIXXCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUIXXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:02:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:13743 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269038AbUIXW6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:58:22 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 0/6] xattr consolidation v3
Date: Sat, 25 Sep 2004 00:59:11 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0409241237560.8101-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0409241237560.8101-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/aKVBGY0EMX8kGB"
Message-Id: <200409250059.12129.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/aKVBGY0EMX8kGB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 24 September 2004 18:39, James Morris wrote:
> On Thu, 23 Sep 2004, Andreas Gruenbacher wrote:
> > There is one minor issue in the ext[23]_xattr_list changes: The xattr
> > block gets inserted into the cache even if it later turns out to be
> > corrupted. The attached patch reintroduces the sanity check, and has a
> > few other cosmetical-only changes.
> >
> > Andrew, do you want to add this to -mm?
>
> These 'cosmetical-only' changes break listxattr on ext3 and ext2.  Andrew,
> please drop this patch.

Here is a fixed version. Feedback welcome.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--Boundary-00=_/aKVBGY0EMX8kGB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="delta-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delta-2.diff"

Index: linux-2.6.9-rc2-bk10/fs/ext2/acl.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext2/acl.c
+++ linux-2.6.9-rc2-bk10/fs/ext2/acl.c
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
Index: linux-2.6.9-rc2-bk10/fs/ext2/xattr.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext2/xattr.c
+++ linux-2.6.9-rc2-bk10/fs/ext2/xattr.c
@@ -270,8 +270,8 @@ ext2_xattr_list(struct inode *inode, cha
 {
 	struct buffer_head *bh = NULL;
 	struct ext2_xattr_entry *entry;
-	size_t total_size = 0;
-	char *buf, *end;
+	char *end;
+	size_t rest = buffer_size;
 	int error;
 
 	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
@@ -298,36 +298,39 @@ bad_block:	ext2_error(inode->i_sb, "ext2
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
 
 	/* list the attribute names */
-	buf = buffer;
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
-			size_t size = handler->list(inode, buf, buffer_size,
+			size_t size = handler->list(inode, buffer, rest,
 						    entry->e_name,
 						    entry->e_name_len);
-			if (buf) {
-				if (size > buffer_size) {
+			if (buffer) {
+				if (size > rest) {
 					error = -ERANGE;
 					goto cleanup;
 				}
-				buf += size;
-				buffer_size -= size;
+				buffer += size;
 			}
-			total_size += size;
+			rest -= size;
 		}
 	}
-	error = total_size;
+	error = buffer_size - rest;  /* total size */
 
 cleanup:
 	brelse(bh);
Index: linux-2.6.9-rc2-bk10/fs/ext2/xattr_security.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext2/xattr_security.c
+++ linux-2.6.9-rc2-bk10/fs/ext2/xattr_security.c
@@ -17,7 +17,7 @@ ext2_xattr_security_list(struct inode *i
 	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
 	const size_t total_len = prefix_len + name_len + 1;
 	
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2-bk10/fs/ext2/xattr_trusted.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext2/xattr_trusted.c
+++ linux-2.6.9-rc2-bk10/fs/ext2/xattr_trusted.c
@@ -24,7 +24,7 @@ ext2_xattr_trusted_list(struct inode *in
 	if (!capable(CAP_SYS_ADMIN))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2-bk10/fs/ext2/xattr_user.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext2/xattr_user.c
+++ linux-2.6.9-rc2-bk10/fs/ext2/xattr_user.c
@@ -23,7 +23,7 @@ ext2_xattr_user_list(struct inode *inode
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2-bk10/fs/ext3/acl.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext3/acl.c
+++ linux-2.6.9-rc2-bk10/fs/ext3/acl.c
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
Index: linux-2.6.9-rc2-bk10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext3/xattr.c
+++ linux-2.6.9-rc2-bk10/fs/ext3/xattr.c
@@ -267,8 +267,8 @@ ext3_xattr_list(struct inode *inode, cha
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
-	size_t total_size = 0;
-	char *buf, *end;
+	char *end;
+	size_t rest = buffer_size;
 	int error;
 
 	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
@@ -295,36 +295,39 @@ bad_block:	ext3_error(inode->i_sb, "ext3
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
 
 	/* list the attribute names */
-	buf = buffer;
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
-			size_t size = handler->list(inode, buf, buffer_size,
+			size_t size = handler->list(inode, buffer, rest,
 						    entry->e_name,
 						    entry->e_name_len);
-			if (buf) {
-				if (size > buffer_size) {
+			if (buffer) {
+				if (size > rest) {
 					error = -ERANGE;
 					goto cleanup;
 				}
-				buf += size;
-				buffer_size -= size;
+				buffer += size;
 			}
-			total_size += size;
+			rest -= size;
 		}
 	}
-	error = total_size;
+	error = buffer_size - rest;  /* total size */
 
 cleanup:
 	brelse(bh);
Index: linux-2.6.9-rc2-bk10/fs/ext3/xattr_security.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext3/xattr_security.c
+++ linux-2.6.9-rc2-bk10/fs/ext3/xattr_security.c
@@ -19,7 +19,7 @@ ext3_xattr_security_list(struct inode *i
 	const size_t total_len = prefix_len + name_len + 1;
 	
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2-bk10/fs/ext3/xattr_trusted.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext3/xattr_trusted.c
+++ linux-2.6.9-rc2-bk10/fs/ext3/xattr_trusted.c
@@ -25,7 +25,7 @@ ext3_xattr_trusted_list(struct inode *in
 	if (!capable(CAP_SYS_ADMIN))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2-bk10/fs/ext3/xattr_user.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/ext3/xattr_user.c
+++ linux-2.6.9-rc2-bk10/fs/ext3/xattr_user.c
@@ -25,7 +25,7 @@ ext3_xattr_user_list(struct inode *inode
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
-	if (list && (total_len <= list_size)) {
+	if (list && total_len <= list_size) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
Index: linux-2.6.9-rc2-bk10/fs/xattr.c
===================================================================
--- linux-2.6.9-rc2-bk10.orig/fs/xattr.c
+++ linux-2.6.9-rc2-bk10/fs/xattr.c
@@ -351,7 +351,8 @@ sys_fremovexattr(int fd, char __user *na
 }
 
 
-static const char *strcmp_prefix(const char *a, const char *a_prefix)
+static const char *
+strcmp_prefix(const char *a, const char *a_prefix)
 {
 	while (*a_prefix && *a == *a_prefix) {
 		a++;

--Boundary-00=_/aKVBGY0EMX8kGB--

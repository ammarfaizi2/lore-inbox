Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUHWSZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUHWSZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUHWSYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:24:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22765 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266296AbUHWSSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:18:48 -0400
Date: Mon, 23 Aug 2004 14:18:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][4/7] xattr consolidation - ext2
In-Reply-To: <Xine.LNX.4.44.0408231416400.13728-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408231417380.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ext2 xattr and acl code to the new libs API, as well
as removing two unused functions: init_ext2_xattr_user() and
exit_ext2_xattr_user().


 fs/ext2/acl.c            |   30 +++++---
 fs/ext2/xattr.c          |  158 ++++++++++++++---------------------------------
 fs/ext2/xattr.h          |   19 -----
 fs/ext2/xattr_security.c |    4 -
 fs/ext2/xattr_trusted.c  |    4 -
 fs/ext2/xattr_user.c     |   18 -----
 6 files changed, 75 insertions(+), 158 deletions(-)

 Signed-off-by: James Morris <jmorris@redhat.com>
 Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext2/acl.c linux-2.6.8.1-mm2.w/fs/ext2/acl.c
--- linux-2.6.8.1-mm2.p/fs/ext2/acl.c	2004-08-14 10:25:39.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext2/acl.c	2004-08-23 13:25:02.114182256 -0400
@@ -12,6 +12,8 @@
 #include "xattr.h"
 #include "acl.h"
 
+extern struct simple_xattr_info ext2_xattr_info;
+
 /*
  * Convert from filesystem to in-memory representation.
  */
@@ -429,7 +431,7 @@ ext2_acl_chmod(struct inode *inode)
  * Extended attribut handlers
  */
 static size_t
-ext2_xattr_list_acl_access(char *list, struct inode *inode,
+ext2_xattr_list_acl_access(struct inode *inode, char *list,
 			   const char *name, int name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
@@ -442,7 +444,7 @@ ext2_xattr_list_acl_access(char *list, s
 }
 
 static size_t
-ext2_xattr_list_acl_default(char *list, struct inode *inode,
+ext2_xattr_list_acl_default(struct inode *inode, char *list,
 			    const char *name, int name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
@@ -541,14 +543,14 @@ ext2_xattr_set_acl_default(struct inode 
 	return ext2_xattr_set_acl(inode, ACL_TYPE_DEFAULT, value, size);
 }
 
-struct ext2_xattr_handler ext2_xattr_acl_access_handler = {
+struct simple_xattr_handler ext2_xattr_acl_access_handler = {
 	.prefix	= XATTR_NAME_ACL_ACCESS,
 	.list	= ext2_xattr_list_acl_access,
 	.get	= ext2_xattr_get_acl_access,
 	.set	= ext2_xattr_set_acl_access,
 };
 
-struct ext2_xattr_handler ext2_xattr_acl_default_handler = {
+struct simple_xattr_handler ext2_xattr_acl_default_handler = {
 	.prefix	= XATTR_NAME_ACL_DEFAULT,
 	.list	= ext2_xattr_list_acl_default,
 	.get	= ext2_xattr_get_acl_default,
@@ -558,10 +560,12 @@ struct ext2_xattr_handler ext2_xattr_acl
 void
 exit_ext2_acl(void)
 {
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
-			      &ext2_xattr_acl_access_handler);
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
-			      &ext2_xattr_acl_default_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
+				&ext2_xattr_acl_access_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
+				&ext2_xattr_acl_default_handler);
 }
 
 int __init
@@ -569,12 +573,14 @@ init_ext2_acl(void)
 {
 	int error;
 
-	error = ext2_xattr_register(EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
-				    &ext2_xattr_acl_access_handler);
+	error = simple_xattr_register(&ext2_xattr_info,
+				      EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
+				      &ext2_xattr_acl_access_handler);
 	if (error)
 		goto fail;
-	error = ext2_xattr_register(EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
-				    &ext2_xattr_acl_default_handler);
+	error = simple_xattr_register(&ext2_xattr_info,
+				      EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
+				      &ext2_xattr_acl_default_handler);
 	if (error)
 		goto fail;
 	return 0;
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext2/xattr.c linux-2.6.8.1-mm2.w/fs/ext2/xattr.c
--- linux-2.6.8.1-mm2.p/fs/ext2/xattr.c	2004-08-14 10:25:40.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext2/xattr.c	2004-08-23 13:25:23.235971256 -0400
@@ -6,6 +6,7 @@
  * Fix by Harrison Xing <harrison@mountainviewdata.com>.
  * Extended attributes for symlinks and special files added per
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
+ * libfs consolidation James Morris <jmorris@redhat.com>
  */
 
 /*
@@ -62,8 +63,6 @@
 #include "acl.h"
 
 /* These symbols may be needed by a module. */
-EXPORT_SYMBOL(ext2_xattr_register);
-EXPORT_SYMBOL(ext2_xattr_unregister);
 EXPORT_SYMBOL(ext2_xattr_get);
 EXPORT_SYMBOL(ext2_xattr_list);
 EXPORT_SYMBOL(ext2_xattr_set);
@@ -93,6 +92,8 @@ EXPORT_SYMBOL(ext2_xattr_set);
 # define ea_bdebug(f...)
 #endif
 
+struct simple_xattr_info ext2_xattr_info;
+
 static int ext2_xattr_set2(struct inode *, struct buffer_head *,
 			   struct ext2_xattr_header *);
 
@@ -104,84 +105,7 @@ static void ext2_xattr_rehash(struct ext
 			      struct ext2_xattr_entry *);
 
 static struct mb_cache *ext2_xattr_cache;
-static struct ext2_xattr_handler *ext2_xattr_handlers[EXT2_XATTR_INDEX_MAX];
-static rwlock_t ext2_handler_lock = RW_LOCK_UNLOCKED;
-
-int
-ext2_xattr_register(int name_index, struct ext2_xattr_handler *handler)
-{
-	int error = -EINVAL;
-
-	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX) {
-		write_lock(&ext2_handler_lock);
-		if (!ext2_xattr_handlers[name_index-1]) {
-			ext2_xattr_handlers[name_index-1] = handler;
-			error = 0;
-		}
-		write_unlock(&ext2_handler_lock);
-	}
-	return error;
-}
-
-void
-ext2_xattr_unregister(int name_index, struct ext2_xattr_handler *handler)
-{
-	if (name_index > 0 || name_index <= EXT2_XATTR_INDEX_MAX) {
-		write_lock(&ext2_handler_lock);
-		ext2_xattr_handlers[name_index-1] = NULL;
-		write_unlock(&ext2_handler_lock);
-	}
-}
-
-static inline const char *
-strcmp_prefix(const char *a, const char *a_prefix)
-{
-	while (*a_prefix && *a == *a_prefix) {
-		a++;
-		a_prefix++;
-	}
-	return *a_prefix ? NULL : a;
-}
-
-/*
- * Decode the extended attribute name, and translate it into
- * the name_index and name suffix.
- */
-static struct ext2_xattr_handler *
-ext2_xattr_resolve_name(const char **name)
-{
-	struct ext2_xattr_handler *handler = NULL;
-	int i;
-
-	if (!*name)
-		return NULL;
-	read_lock(&ext2_handler_lock);
-	for (i=0; i<EXT2_XATTR_INDEX_MAX; i++) {
-		if (ext2_xattr_handlers[i]) {
-			const char *n = strcmp_prefix(*name,
-				ext2_xattr_handlers[i]->prefix);
-			if (n) {
-				handler = ext2_xattr_handlers[i];
-				*name = n;
-				break;
-			}
-		}
-	}
-	read_unlock(&ext2_handler_lock);
-	return handler;
-}
-
-static inline struct ext2_xattr_handler *
-ext2_xattr_handler(int name_index)
-{
-	struct ext2_xattr_handler *handler = NULL;
-	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX) {
-		read_lock(&ext2_handler_lock);
-		handler = ext2_xattr_handlers[name_index-1];
-		read_unlock(&ext2_handler_lock);
-	}
-	return handler;
-}
+static struct simple_xattr_handler *ext2_xattr_handlers[SIMPLE_XATTR_MAX];
 
 /*
  * Inode operation getxattr()
@@ -192,10 +116,10 @@ ssize_t
 ext2_getxattr(struct dentry *dentry, const char *name,
 	      void *buffer, size_t size)
 {
-	struct ext2_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 
-	handler = ext2_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&ext2_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
 	return handler->get(inode, name, buffer, size);
@@ -221,12 +145,12 @@ int
 ext2_setxattr(struct dentry *dentry, const char *name,
 	      const void *value, size_t size, int flags)
 {
-	struct ext2_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	handler = ext2_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&ext2_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
 	return handler->set(inode, name, value, size, flags);
@@ -240,10 +164,10 @@ ext2_setxattr(struct dentry *dentry, con
 int
 ext2_removexattr(struct dentry *dentry, const char *name)
 {
-	struct ext2_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 
-	handler = ext2_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&ext2_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
 	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
@@ -397,15 +321,16 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 	/* compute the size required for the list of attribute names */
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT2_XATTR_NEXT(entry)) {
-		struct ext2_xattr_handler *handler;
+		struct simple_xattr_handler *handler;
 		struct ext2_xattr_entry *next =
 			EXT2_XATTR_NEXT(entry);
 		if ((char *)next >= end)
 			goto bad_block;
 
-		handler = ext2_xattr_handler(entry->e_name_index);
+		handler = simple_xattr_handler(&ext2_xattr_info,
+					       entry->e_name_index);
 		if (handler)
-			size += handler->list(NULL, inode, entry->e_name,
+			size += handler->list(inode, NULL, entry->e_name,
 					      entry->e_name_len);
 	}
 
@@ -424,11 +349,12 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 	buf = buffer;
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT2_XATTR_NEXT(entry)) {
-		struct ext2_xattr_handler *handler;
+		struct simple_xattr_handler *handler;
 		
-		handler = ext2_xattr_handler(entry->e_name_index);
+		handler = simple_xattr_handler(&ext2_xattr_info,
+					       entry->e_name_index);
 		if (handler)
-			buf += handler->list(buf, inode, entry->e_name,
+			buf += handler->list(inode, buf, entry->e_name,
 					     entry->e_name_len);
 	}
 	error = size;
@@ -1121,18 +1047,24 @@ int __init
 init_ext2_xattr(void)
 {
 	int	err;
+
+	ext2_xattr_info.lock = RW_LOCK_UNLOCKED;
+	ext2_xattr_info.handlers = ext2_xattr_handlers;
 	
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_USER,
-				  &ext2_xattr_user_handler);
+	err = simple_xattr_register(&ext2_xattr_info,
+				    EXT2_XATTR_INDEX_USER,
+				    &ext2_xattr_user_handler);
 	if (err)
 		return err;
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_TRUSTED,
-				  &ext2_xattr_trusted_handler);
+	err = simple_xattr_register(&ext2_xattr_info,
+				    EXT2_XATTR_INDEX_TRUSTED,
+				    &ext2_xattr_trusted_handler);
 	if (err)
 		goto out;
 #ifdef CONFIG_EXT2_FS_SECURITY
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_SECURITY,
-				  &ext2_xattr_security_handler);
+	err = simple_xattr_register(&ext2_xattr_info,
+				    EXT2_XATTR_INDEX_SECURITY,
+				    &ext2_xattr_security_handler);
 	if (err)
 		goto out1;
 #endif
@@ -1155,15 +1087,18 @@ out3:
 out2:
 #endif
 #ifdef CONFIG_EXT2_FS_SECURITY
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
-			      &ext2_xattr_security_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_SECURITY,
+				&ext2_xattr_security_handler);
 out1:
 #endif
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
-			      &ext2_xattr_trusted_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_TRUSTED,
+				&ext2_xattr_trusted_handler);
 out:
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
-			      &ext2_xattr_user_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_USER,
+				&ext2_xattr_user_handler);
 	return err;
 }
 
@@ -1175,11 +1110,14 @@ exit_ext2_xattr(void)
 	exit_ext2_acl();
 #endif
 #ifdef CONFIG_EXT2_FS_SECURITY
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
-			      &ext2_xattr_security_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_SECURITY,
+				&ext2_xattr_security_handler);
 #endif
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
-			      &ext2_xattr_trusted_handler);
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
-			      &ext2_xattr_user_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_TRUSTED,
+				&ext2_xattr_trusted_handler);
+	simple_xattr_unregister(&ext2_xattr_info,
+				EXT2_XATTR_INDEX_USER,
+				&ext2_xattr_user_handler);
 }
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext2/xattr.h linux-2.6.8.1-mm2.w/fs/ext2/xattr.h
--- linux-2.6.8.1-mm2.p/fs/ext2/xattr.h	2004-06-16 01:19:42.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext2/xattr.h	2004-08-23 13:25:02.117181800 -0400
@@ -57,19 +57,6 @@ struct ext2_xattr_entry {
 
 # ifdef CONFIG_EXT2_FS_XATTR
 
-struct ext2_xattr_handler {
-	char *prefix;
-	size_t (*list)(char *list, struct inode *inode, const char *name,
-		       int name_len);
-	int (*get)(struct inode *inode, const char *name, void *buffer,
-		   size_t size);
-	int (*set)(struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
-};
-
-extern int ext2_xattr_register(int, struct ext2_xattr_handler *);
-extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
-
 extern int ext2_setxattr(struct dentry *, const char *, const void *, size_t, int);
 extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
@@ -134,7 +121,7 @@ exit_ext2_xattr(void)
 
 # endif  /* CONFIG_EXT2_FS_XATTR */
 
-extern struct ext2_xattr_handler ext2_xattr_user_handler;
-extern struct ext2_xattr_handler ext2_xattr_trusted_handler;
-extern struct ext2_xattr_handler ext2_xattr_security_handler;
+extern struct simple_xattr_handler ext2_xattr_user_handler;
+extern struct simple_xattr_handler ext2_xattr_trusted_handler;
+extern struct simple_xattr_handler ext2_xattr_security_handler;
 
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext2/xattr_security.c linux-2.6.8.1-mm2.w/fs/ext2/xattr_security.c
--- linux-2.6.8.1-mm2.p/fs/ext2/xattr_security.c	2004-06-16 01:19:23.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext2/xattr_security.c	2004-08-23 13:25:02.118181648 -0400
@@ -11,7 +11,7 @@
 #include "xattr.h"
 
 static size_t
-ext2_xattr_security_list(char *list, struct inode *inode,
+ext2_xattr_security_list(struct inode *inode, char *list,
 			const char *name, int name_len)
 {
 	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
@@ -44,7 +44,7 @@ ext2_xattr_security_set(struct inode *in
 			      value, size, flags);
 }
 
-struct ext2_xattr_handler ext2_xattr_security_handler = {
+struct simple_xattr_handler ext2_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= ext2_xattr_security_list,
 	.get	= ext2_xattr_security_get,
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext2/xattr_trusted.c linux-2.6.8.1-mm2.w/fs/ext2/xattr_trusted.c
--- linux-2.6.8.1-mm2.p/fs/ext2/xattr_trusted.c	2004-06-16 01:18:58.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext2/xattr_trusted.c	2004-08-23 13:25:02.119181496 -0400
@@ -15,7 +15,7 @@
 #define XATTR_TRUSTED_PREFIX "trusted."
 
 static size_t
-ext2_xattr_trusted_list(char *list, struct inode *inode,
+ext2_xattr_trusted_list(struct inode *inode, char *list,
 			const char *name, int name_len)
 {
 	const int prefix_len = sizeof(XATTR_TRUSTED_PREFIX)-1;
@@ -55,7 +55,7 @@ ext2_xattr_trusted_set(struct inode *ino
 			      value, size, flags);
 }
 
-struct ext2_xattr_handler ext2_xattr_trusted_handler = {
+struct simple_xattr_handler ext2_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.list	= ext2_xattr_trusted_list,
 	.get	= ext2_xattr_trusted_get,
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext2/xattr_user.c linux-2.6.8.1-mm2.w/fs/ext2/xattr_user.c
--- linux-2.6.8.1-mm2.p/fs/ext2/xattr_user.c	2004-06-16 01:19:36.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext2/xattr_user.c	2004-08-23 13:25:02.120181344 -0400
@@ -14,7 +14,7 @@
 #define XATTR_USER_PREFIX "user."
 
 static size_t
-ext2_xattr_user_list(char *list, struct inode *inode,
+ext2_xattr_user_list(struct inode *inode, char *list,
 		     const char *name, int name_len)
 {
 	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
@@ -68,23 +68,9 @@ ext2_xattr_user_set(struct inode *inode,
 			      value, size, flags);
 }
 
-struct ext2_xattr_handler ext2_xattr_user_handler = {
+struct simple_xattr_handler ext2_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.list	= ext2_xattr_user_list,
 	.get	= ext2_xattr_user_get,
 	.set	= ext2_xattr_user_set,
 };
-
-int __init
-init_ext2_xattr_user(void)
-{
-	return ext2_xattr_register(EXT2_XATTR_INDEX_USER,
-				   &ext2_xattr_user_handler);
-}
-
-void
-exit_ext2_xattr_user(void)
-{
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
-			      &ext2_xattr_user_handler);
-}


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUHWSVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUHWSVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUHWSVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:21:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266306AbUHWSRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:17:30 -0400
Date: Mon, 23 Aug 2004 14:17:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][3/7] xattr consolidation - ext3
In-Reply-To: <Xine.LNX.4.44.0408231415310.13728-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0408231416400.13728-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the ext3 xattr and acl code to the new libfs API.


 fs/ext3/acl.c            |   30 +++++---
 fs/ext3/xattr.c          |  158 ++++++++++++++---------------------------------
 fs/ext3/xattr.h          |   21 +-----
 fs/ext3/xattr_security.c |    6 -
 fs/ext3/xattr_trusted.c  |    4 -
 fs/ext3/xattr_user.c     |    4 -
 6 files changed, 78 insertions(+), 145 deletions(-)

 Signed-off-by: James Morris <jmorris@redhat.com>
 Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
    

diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext3/acl.c linux-2.6.8.1-mm2.w/fs/ext3/acl.c
--- linux-2.6.8.1-mm2.p/fs/ext3/acl.c	2004-08-14 10:25:40.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext3/acl.c	2004-08-23 13:20:40.845901072 -0400
@@ -13,6 +13,8 @@
 #include "xattr.h"
 #include "acl.h"
 
+extern struct simple_xattr_info ext3_xattr_info;
+
 /*
  * Convert from filesystem to in-memory representation.
  */
@@ -452,7 +454,7 @@ out:
  * Extended attribute handlers
  */
 static size_t
-ext3_xattr_list_acl_access(char *list, struct inode *inode,
+ext3_xattr_list_acl_access(struct inode *inode, char *list,
 			   const char *name, int name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
@@ -465,7 +467,7 @@ ext3_xattr_list_acl_access(char *list, s
 }
 
 static size_t
-ext3_xattr_list_acl_default(char *list, struct inode *inode,
+ext3_xattr_list_acl_default(struct inode *inode, char *list,
 			    const char *name, int name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
@@ -572,14 +574,14 @@ ext3_xattr_set_acl_default(struct inode 
 	return ext3_xattr_set_acl(inode, ACL_TYPE_DEFAULT, value, size);
 }
 
-struct ext3_xattr_handler ext3_xattr_acl_access_handler = {
+struct simple_xattr_handler ext3_xattr_acl_access_handler = {
 	.prefix	= XATTR_NAME_ACL_ACCESS,
 	.list	= ext3_xattr_list_acl_access,
 	.get	= ext3_xattr_get_acl_access,
 	.set	= ext3_xattr_set_acl_access,
 };
 
-struct ext3_xattr_handler ext3_xattr_acl_default_handler = {
+struct simple_xattr_handler ext3_xattr_acl_default_handler = {
 	.prefix	= XATTR_NAME_ACL_DEFAULT,
 	.list	= ext3_xattr_list_acl_default,
 	.get	= ext3_xattr_get_acl_default,
@@ -589,10 +591,12 @@ struct ext3_xattr_handler ext3_xattr_acl
 void
 exit_ext3_acl(void)
 {
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
-			      &ext3_xattr_acl_access_handler);
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
-			      &ext3_xattr_acl_default_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
+				&ext3_xattr_acl_access_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
+				&ext3_xattr_acl_default_handler);
 }
 
 int __init
@@ -600,12 +604,14 @@ init_ext3_acl(void)
 {
 	int error;
 
-	error = ext3_xattr_register(EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
-				    &ext3_xattr_acl_access_handler);
+	error = simple_xattr_register(&ext3_xattr_info,
+				      EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
+				      &ext3_xattr_acl_access_handler);
 	if (error)
 		goto fail;
-	error = ext3_xattr_register(EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
-				    &ext3_xattr_acl_default_handler);
+	error = simple_xattr_register(&ext3_xattr_info,
+				      EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
+				      &ext3_xattr_acl_default_handler);
 	if (error)
 		goto fail;
 	return 0;
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext3/xattr.c linux-2.6.8.1-mm2.w/fs/ext3/xattr.c
--- linux-2.6.8.1-mm2.p/fs/ext3/xattr.c	2004-08-19 10:32:52.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext3/xattr.c	2004-08-23 13:21:25.420124760 -0400
@@ -7,6 +7,7 @@
  * Ext3 code with a lot of help from Eric Jarman <ejarman@acm.org>.
  * Extended attributes for symlinks and special files added per
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
+ * libfs consolidation James Morris <jmorris@redhat.com>
  */
 
 /*
@@ -87,6 +88,8 @@
 # define ea_bdebug(f...)
 #endif
 
+struct simple_xattr_info ext3_xattr_info;
+
 static int ext3_xattr_set_handle2(handle_t *, struct inode *,
 				  struct buffer_head *,
 				  struct ext3_xattr_header *);
@@ -100,84 +103,7 @@ static void ext3_xattr_rehash(struct ext
 			      struct ext3_xattr_entry *);
 
 static struct mb_cache *ext3_xattr_cache;
-static struct ext3_xattr_handler *ext3_xattr_handlers[EXT3_XATTR_INDEX_MAX];
-static rwlock_t ext3_handler_lock = RW_LOCK_UNLOCKED;
-
-int
-ext3_xattr_register(int name_index, struct ext3_xattr_handler *handler)
-{
-	int error = -EINVAL;
-
-	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX) {
-		write_lock(&ext3_handler_lock);
-		if (!ext3_xattr_handlers[name_index-1]) {
-			ext3_xattr_handlers[name_index-1] = handler;
-			error = 0;
-		}
-		write_unlock(&ext3_handler_lock);
-	}
-	return error;
-}
-
-void
-ext3_xattr_unregister(int name_index, struct ext3_xattr_handler *handler)
-{
-	if (name_index > 0 || name_index <= EXT3_XATTR_INDEX_MAX) {
-		write_lock(&ext3_handler_lock);
-		ext3_xattr_handlers[name_index-1] = NULL;
-		write_unlock(&ext3_handler_lock);
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
-static inline struct ext3_xattr_handler *
-ext3_xattr_resolve_name(const char **name)
-{
-	struct ext3_xattr_handler *handler = NULL;
-	int i;
-
-	if (!*name)
-		return NULL;
-	read_lock(&ext3_handler_lock);
-	for (i=0; i<EXT3_XATTR_INDEX_MAX; i++) {
-		if (ext3_xattr_handlers[i]) {
-			const char *n = strcmp_prefix(*name,
-				ext3_xattr_handlers[i]->prefix);
-			if (n) {
-				handler = ext3_xattr_handlers[i];
-				*name = n;
-				break;
-			}
-		}
-	}
-	read_unlock(&ext3_handler_lock);
-	return handler;
-}
-
-static inline struct ext3_xattr_handler *
-ext3_xattr_handler(int name_index)
-{
-	struct ext3_xattr_handler *handler = NULL;
-	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX) {
-		read_lock(&ext3_handler_lock);
-		handler = ext3_xattr_handlers[name_index-1];
-		read_unlock(&ext3_handler_lock);
-	}
-	return handler;
-}
+static struct simple_xattr_handler *ext3_xattr_handlers[SIMPLE_XATTR_MAX];
 
 /*
  * Inode operation getxattr()
@@ -188,10 +114,10 @@ ssize_t
 ext3_getxattr(struct dentry *dentry, const char *name,
 	      void *buffer, size_t size)
 {
-	struct ext3_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 
-	handler = ext3_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&ext3_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
 	return handler->get(inode, name, buffer, size);
@@ -217,12 +143,12 @@ int
 ext3_setxattr(struct dentry *dentry, const char *name,
 	      const void *value, size_t size, int flags)
 {
-	struct ext3_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	handler = ext3_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&ext3_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
 	return handler->set(inode, name, value, size, flags);
@@ -236,10 +162,10 @@ ext3_setxattr(struct dentry *dentry, con
 int
 ext3_removexattr(struct dentry *dentry, const char *name)
 {
-	struct ext3_xattr_handler *handler;
+	struct simple_xattr_handler *handler;
 	struct inode *inode = dentry->d_inode;
 
-	handler = ext3_xattr_resolve_name(&name);
+	handler = simple_xattr_resolve_name(&ext3_xattr_info, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
 	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
@@ -393,15 +319,16 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 	/* compute the size required for the list of attribute names */
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT3_XATTR_NEXT(entry)) {
-		struct ext3_xattr_handler *handler;
+		struct simple_xattr_handler *handler;
 		struct ext3_xattr_entry *next =
 			EXT3_XATTR_NEXT(entry);
 		if ((char *)next >= end)
 			goto bad_block;
 
-		handler = ext3_xattr_handler(entry->e_name_index);
+		handler = simple_xattr_handler(&ext3_xattr_info,
+					       entry->e_name_index);
 		if (handler)
-			size += handler->list(NULL, inode, entry->e_name,
+			size += handler->list(inode, NULL, entry->e_name,
 					      entry->e_name_len);
 	}
 
@@ -420,12 +347,13 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 	buf = buffer;
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT3_XATTR_NEXT(entry)) {
-		struct ext3_xattr_handler *handler;
+		struct simple_xattr_handler *handler;
 
-		handler = ext3_xattr_handler(entry->e_name_index);
+		handler = simple_xattr_handler(&ext3_xattr_info,
+					       entry->e_name_index);
 		if (handler)
-			buf += handler->list(buf, inode, entry->e_name,
-					     entry->e_name_len);
+			buf += handler->list(inode, buf,
+					     entry->e_name, entry->e_name_len);
 	}
 	error = size;
 
@@ -1180,17 +1108,23 @@ init_ext3_xattr(void)
 {
 	int	err;
 
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_USER,
-				  &ext3_xattr_user_handler);
+	ext3_xattr_info.lock = RW_LOCK_UNLOCKED;
+	ext3_xattr_info.handlers = ext3_xattr_handlers;
+        
+	err = simple_xattr_register(&ext3_xattr_info,
+				    EXT3_XATTR_INDEX_USER,
+				    &ext3_xattr_user_handler);
 	if (err)
 		return err;
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_TRUSTED,
-				  &ext3_xattr_trusted_handler);
+	err = simple_xattr_register(&ext3_xattr_info,
+				    EXT3_XATTR_INDEX_TRUSTED,
+				    &ext3_xattr_trusted_handler);
 	if (err)
 		goto out;
 #ifdef CONFIG_EXT3_FS_SECURITY
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_SECURITY,
-				  &ext3_xattr_security_handler);
+	err = simple_xattr_register(&ext3_xattr_info,
+				    EXT3_XATTR_INDEX_SECURITY,
+				    &ext3_xattr_security_handler);
 	if (err)
 		goto out1;
 #endif
@@ -1213,15 +1147,18 @@ out3:
 out2:
 #endif
 #ifdef CONFIG_EXT3_FS_SECURITY
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
-			      &ext3_xattr_security_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_SECURITY,
+				&ext3_xattr_security_handler);
 out1:
 #endif
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
-			      &ext3_xattr_trusted_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_TRUSTED,
+				&ext3_xattr_trusted_handler);
 out:
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
-			      &ext3_xattr_user_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_USER,
+				&ext3_xattr_user_handler);
 	return err;
 }
 
@@ -1235,11 +1172,14 @@ exit_ext3_xattr(void)
 	exit_ext3_acl();
 #endif
 #ifdef CONFIG_EXT3_FS_SECURITY
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
-			      &ext3_xattr_security_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_SECURITY,
+				&ext3_xattr_security_handler);
 #endif
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
-			      &ext3_xattr_trusted_handler);
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
-			      &ext3_xattr_user_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_TRUSTED,
+				&ext3_xattr_trusted_handler);
+	simple_xattr_unregister(&ext3_xattr_info,
+				EXT3_XATTR_INDEX_USER,
+				&ext3_xattr_user_handler);
 }
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext3/xattr.h linux-2.6.8.1-mm2.w/fs/ext3/xattr.h
--- linux-2.6.8.1-mm2.p/fs/ext3/xattr.h	2004-06-16 01:20:04.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext3/xattr.h	2004-08-23 13:20:40.848900616 -0400
@@ -16,7 +16,6 @@
 #define EXT3_XATTR_REFCOUNT_MAX		1024
 
 /* Name indexes */
-#define EXT3_XATTR_INDEX_MAX			10
 #define EXT3_XATTR_INDEX_USER			1
 #define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
 #define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
@@ -56,19 +55,6 @@ struct ext3_xattr_entry {
 
 # ifdef CONFIG_EXT3_FS_XATTR
 
-struct ext3_xattr_handler {
-	char *prefix;
-	size_t (*list)(char *list, struct inode *inode, const char *name,
-		       int name_len);
-	int (*get)(struct inode *inode, const char *name, void *buffer,
-		   size_t size);
-	int (*set)(struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
-};
-
-extern int ext3_xattr_register(int, struct ext3_xattr_handler *);
-extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
-
 extern int ext3_setxattr(struct dentry *, const char *, const void *, size_t, int);
 extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
@@ -141,6 +127,7 @@ exit_ext3_xattr(void)
 
 # endif  /* CONFIG_EXT3_FS_XATTR */
 
-extern struct ext3_xattr_handler ext3_xattr_user_handler;
-extern struct ext3_xattr_handler ext3_xattr_trusted_handler;
-extern struct ext3_xattr_handler ext3_xattr_security_handler;
+extern struct simple_xattr_handler ext3_xattr_user_handler;
+extern struct simple_xattr_handler ext3_xattr_trusted_handler;
+extern struct simple_xattr_handler ext3_xattr_security_handler;
+
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext3/xattr_security.c linux-2.6.8.1-mm2.w/fs/ext3/xattr_security.c
--- linux-2.6.8.1-mm2.p/fs/ext3/xattr_security.c	2004-06-16 01:19:23.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext3/xattr_security.c	2004-08-23 13:20:40.849900464 -0400
@@ -12,8 +12,8 @@
 #include "xattr.h"
 
 static size_t
-ext3_xattr_security_list(char *list, struct inode *inode,
-		    const char *name, int name_len)
+ext3_xattr_security_list(struct inode *inode, char *list,
+			 const char *name, int name_len)
 {
 	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
 
@@ -45,7 +45,7 @@ ext3_xattr_security_set(struct inode *in
 			      value, size, flags);
 }
 
-struct ext3_xattr_handler ext3_xattr_security_handler = {
+struct simple_xattr_handler ext3_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= ext3_xattr_security_list,
 	.get	= ext3_xattr_security_get,
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext3/xattr_trusted.c linux-2.6.8.1-mm2.w/fs/ext3/xattr_trusted.c
--- linux-2.6.8.1-mm2.p/fs/ext3/xattr_trusted.c	2004-06-16 01:19:42.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext3/xattr_trusted.c	2004-08-23 13:20:40.850900312 -0400
@@ -16,7 +16,7 @@
 #define XATTR_TRUSTED_PREFIX "trusted."
 
 static size_t
-ext3_xattr_trusted_list(char *list, struct inode *inode,
+ext3_xattr_trusted_list(struct inode *inode, char *list,
 			const char *name, int name_len)
 {
 	const int prefix_len = sizeof(XATTR_TRUSTED_PREFIX)-1;
@@ -56,7 +56,7 @@ ext3_xattr_trusted_set(struct inode *ino
 			      value, size, flags);
 }
 
-struct ext3_xattr_handler ext3_xattr_trusted_handler = {
+struct simple_xattr_handler ext3_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.list	= ext3_xattr_trusted_list,
 	.get	= ext3_xattr_trusted_get,
diff -purN -X dontdiff linux-2.6.8.1-mm2.p/fs/ext3/xattr_user.c linux-2.6.8.1-mm2.w/fs/ext3/xattr_user.c
--- linux-2.6.8.1-mm2.p/fs/ext3/xattr_user.c	2004-06-16 01:18:58.000000000 -0400
+++ linux-2.6.8.1-mm2.w/fs/ext3/xattr_user.c	2004-08-23 13:20:40.851900160 -0400
@@ -16,7 +16,7 @@
 #define XATTR_USER_PREFIX "user."
 
 static size_t
-ext3_xattr_user_list(char *list, struct inode *inode,
+ext3_xattr_user_list(struct inode *inode, char *list,
 		     const char *name, int name_len)
 {
 	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
@@ -70,7 +70,7 @@ ext3_xattr_user_set(struct inode *inode,
 			      value, size, flags);
 }
 
-struct ext3_xattr_handler ext3_xattr_user_handler = {
+struct simple_xattr_handler ext3_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.list	= ext3_xattr_user_list,
 	.get	= ext3_xattr_user_get,


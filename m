Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUIWD7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUIWD7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUIWD7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:59:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14789 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268247AbUIWD4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:56:44 -0400
Date: Wed, 22 Sep 2004 23:56:26 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] xattr consolidation v3 - ext3
In-Reply-To: <Xine.LNX.4.44.0409222348090.447@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409222349091.447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the ext3 xattr and acl code to the generic xattr API.


 fs/ext3/acl.c            |   45 +-------
 fs/ext3/file.c           |    8 -
 fs/ext3/namei.c          |   16 +-
 fs/ext3/super.c          |    1 
 fs/ext3/symlink.c        |   16 +-
 fs/ext3/xattr.c          |  259 +++++++++--------------------------------------
 fs/ext3/xattr.h          |   32 +----
 fs/ext3/xattr_security.c |   14 +-
 fs/ext3/xattr_trusted.c  |   13 +-
 fs/ext3/xattr_user.c     |   13 +-
 10 files changed, 118 insertions(+), 299 deletions(-)

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/acl.c linux-2.6.9-rc2-mm2.w/fs/ext3/acl.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/acl.c	2004-09-22 19:05:34.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/acl.c	2004-09-22 19:30:08.363386104 -0400
@@ -416,27 +416,27 @@ out:
  * Extended attribute handlers
  */
 static size_t
-ext3_xattr_list_acl_access(char *list, struct inode *inode,
-			   const char *name, int name_len)
+ext3_xattr_list_acl_access(struct inode *inode, char *list, size_t list_len,
+			   const char *name, size_t name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
-	if (list)
+	if (list && (size <= list_len))
 		memcpy(list, XATTR_NAME_ACL_ACCESS, size);
 	return size;
 }
 
 static size_t
-ext3_xattr_list_acl_default(char *list, struct inode *inode,
-			    const char *name, int name_len)
+ext3_xattr_list_acl_default(struct inode *inode, char *list, size_t list_len,
+			    const char *name, size_t name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
 
 	if (!test_opt(inode->i_sb, POSIX_ACL))
 		return 0;
-	if (list)
+	if (list && (size <= list_len))
 		memcpy(list, XATTR_NAME_ACL_DEFAULT, size);
 	return size;
 }
@@ -536,45 +536,16 @@ ext3_xattr_set_acl_default(struct inode 
 	return ext3_xattr_set_acl(inode, ACL_TYPE_DEFAULT, value, size);
 }
 
-struct ext3_xattr_handler ext3_xattr_acl_access_handler = {
+struct xattr_handler ext3_xattr_acl_access_handler = {
 	.prefix	= XATTR_NAME_ACL_ACCESS,
 	.list	= ext3_xattr_list_acl_access,
 	.get	= ext3_xattr_get_acl_access,
 	.set	= ext3_xattr_set_acl_access,
 };
 
-struct ext3_xattr_handler ext3_xattr_acl_default_handler = {
+struct xattr_handler ext3_xattr_acl_default_handler = {
 	.prefix	= XATTR_NAME_ACL_DEFAULT,
 	.list	= ext3_xattr_list_acl_default,
 	.get	= ext3_xattr_get_acl_default,
 	.set	= ext3_xattr_set_acl_default,
 };
-
-void
-exit_ext3_acl(void)
-{
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
-			      &ext3_xattr_acl_access_handler);
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
-			      &ext3_xattr_acl_default_handler);
-}
-
-int __init
-init_ext3_acl(void)
-{
-	int error;
-
-	error = ext3_xattr_register(EXT3_XATTR_INDEX_POSIX_ACL_ACCESS,
-				    &ext3_xattr_acl_access_handler);
-	if (error)
-		goto fail;
-	error = ext3_xattr_register(EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT,
-				    &ext3_xattr_acl_default_handler);
-	if (error)
-		goto fail;
-	return 0;
-
-fail:
-	exit_ext3_acl();
-	return error;
-}
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/file.c linux-2.6.9-rc2-mm2.w/fs/ext3/file.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/file.c	2004-09-22 19:05:34.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/file.c	2004-09-22 19:30:08.364385952 -0400
@@ -134,10 +134,12 @@ struct file_operations ext3_file_operati
 struct inode_operations ext3_file_inode_operations = {
 	.truncate	= ext3_truncate,
 	.setattr	= ext3_setattr,
-	.setxattr	= ext3_setxattr,
-	.getxattr	= ext3_getxattr,
+#ifdef CONFIG_EXT3_FS_XATTR	
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext3_listxattr,
-	.removexattr	= ext3_removexattr,
+	.removexattr	= generic_removexattr,
+#endif
 	.permission	= ext3_permission,
 };
 
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/namei.c linux-2.6.9-rc2-mm2.w/fs/ext3/namei.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/namei.c	2004-09-22 19:05:34.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/namei.c	2004-09-22 19:30:08.366385648 -0400
@@ -2356,18 +2356,22 @@ struct inode_operations ext3_dir_inode_o
 	.mknod		= ext3_mknod,
 	.rename		= ext3_rename,
 	.setattr	= ext3_setattr,
-	.setxattr	= ext3_setxattr,
-	.getxattr	= ext3_getxattr,
+#ifdef CONFIG_EXT3_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext3_listxattr,
-	.removexattr	= ext3_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 	.permission	= ext3_permission,
 };
 
 struct inode_operations ext3_special_inode_operations = {
 	.setattr	= ext3_setattr,
-	.setxattr	= ext3_setxattr,
-	.getxattr	= ext3_getxattr,
+#ifdef CONFIG_EXT3_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext3_listxattr,
-	.removexattr	= ext3_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 	.permission	= ext3_permission,
 }; 
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/super.c linux-2.6.9-rc2-mm2.w/fs/ext3/super.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/super.c	2004-09-22 19:05:34.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/super.c	2004-09-22 19:30:08.369385192 -0400
@@ -1506,6 +1506,7 @@ static int ext3_fill_super (struct super
 	 */
 	sb->s_op = &ext3_sops;
 	sb->s_export_op = &ext3_export_ops;
+	sb->s_xattr = ext3_xattr_handlers;
 #ifdef CONFIG_QUOTA
 	sb->s_qcop = &ext3_qctl_operations;
 	sb->dq_op = &ext3_quota_operations;
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/symlink.c linux-2.6.9-rc2-mm2.w/fs/ext3/symlink.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/symlink.c	2004-09-13 01:32:48.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/symlink.c	2004-09-22 19:30:08.370385040 -0400
@@ -34,17 +34,21 @@ struct inode_operations ext3_symlink_ino
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
-	.setxattr	= ext3_setxattr,
-	.getxattr	= ext3_getxattr,
+#ifdef CONFIG_EXT3_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext3_listxattr,
-	.removexattr	= ext3_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 };
 
 struct inode_operations ext3_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ext3_follow_link,
-	.setxattr	= ext3_setxattr,
-	.getxattr	= ext3_getxattr,
+#ifdef CONFIG_EXT3_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext3_listxattr,
-	.removexattr	= ext3_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 };
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/xattr.c linux-2.6.9-rc2-mm2.w/fs/ext3/xattr.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/xattr.c	2004-09-22 19:05:34.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/xattr.c	2004-09-22 19:30:08.372384736 -0400
@@ -7,6 +7,8 @@
  * Ext3 code with a lot of help from Eric Jarman <ejarman@acm.org>.
  * Extended attributes for symlinks and special files added per
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
+ * xattr consolidation Copyright (c) 2004 James Morris <jmorris@redhat.com>,
+ *  Red Hat Inc.
  */
 
 /*
@@ -100,101 +102,40 @@ static void ext3_xattr_rehash(struct ext
 			      struct ext3_xattr_entry *);
 
 static struct mb_cache *ext3_xattr_cache;
-static struct ext3_xattr_handler *ext3_xattr_handlers[EXT3_XATTR_INDEX_MAX];
-static rwlock_t ext3_handler_lock = RW_LOCK_UNLOCKED;
 
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
+static struct xattr_handler *ext3_xattr_handler_map[EXT3_XATTR_INDEX_MAX] = {
+	[EXT3_XATTR_INDEX_USER]		     = &ext3_xattr_user_handler,
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	[EXT3_XATTR_INDEX_POSIX_ACL_ACCESS]  = &ext3_xattr_acl_access_handler,
+	[EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT] = &ext3_xattr_acl_default_handler,
+#endif	
+	[EXT3_XATTR_INDEX_TRUSTED]	     = &ext3_xattr_trusted_handler,
+#ifdef CONFIG_EXT3_FS_SECURITY	
+	[EXT3_XATTR_INDEX_SECURITY]	     = &ext3_xattr_security_handler,
+#endif
+};
 
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
+struct xattr_handler *ext3_xattr_handlers[] = {
+	&ext3_xattr_user_handler,
+	&ext3_xattr_trusted_handler,
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	&ext3_xattr_acl_access_handler,
+	&ext3_xattr_acl_default_handler,
+#endif
+#ifdef CONFIG_EXT3_FS_SECURITY	
+	&ext3_xattr_security_handler,
+#endif	
+	NULL
+};
 
-static inline struct ext3_xattr_handler *
+static inline struct xattr_handler *
 ext3_xattr_handler(int name_index)
 {
-	struct ext3_xattr_handler *handler = NULL;
-	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX) {
-		read_lock(&ext3_handler_lock);
-		handler = ext3_xattr_handlers[name_index-1];
-		read_unlock(&ext3_handler_lock);
-	}
-	return handler;
-}
+	struct xattr_handler *handler = NULL;
 
-/*
- * Inode operation getxattr()
- *
- * dentry->d_inode->i_sem: don't care
- */
-ssize_t
-ext3_getxattr(struct dentry *dentry, const char *name,
-	      void *buffer, size_t size)
-{
-	struct ext3_xattr_handler *handler;
-	struct inode *inode = dentry->d_inode;
-
-	handler = ext3_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->get(inode, name, buffer, size);
+	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX)
+		handler = ext3_xattr_handler_map[name_index];
+	return handler;
 }
 
 /*
@@ -209,43 +150,6 @@ ext3_listxattr(struct dentry *dentry, ch
 }
 
 /*
- * Inode operation setxattr()
- *
- * dentry->d_inode->i_sem: down
- */
-int
-ext3_setxattr(struct dentry *dentry, const char *name,
-	      const void *value, size_t size, int flags)
-{
-	struct ext3_xattr_handler *handler;
-	struct inode *inode = dentry->d_inode;
-
-	if (size == 0)
-		value = "";  /* empty EA, do not remove */
-	handler = ext3_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->set(inode, name, value, size, flags);
-}
-
-/*
- * Inode operation removexattr()
- *
- * dentry->d_inode->i_sem: down
- */
-int
-ext3_removexattr(struct dentry *dentry, const char *name)
-{
-	struct ext3_xattr_handler *handler;
-	struct inode *inode = dentry->d_inode;
-
-	handler = ext3_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
-}
-
-/*
  * ext3_xattr_get()
  *
  * Copy an extended attribute into the buffer
@@ -363,7 +267,7 @@ ext3_xattr_list(struct inode *inode, cha
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
-	size_t size = 0;
+	size_t total_size = 0;
 	char *buf, *end;
 	int error;
 
@@ -390,44 +294,37 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 		error = -EIO;
 		goto cleanup;
 	}
-	/* compute the size required for the list of attribute names */
-	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
-	     entry = EXT3_XATTR_NEXT(entry)) {
-		struct ext3_xattr_handler *handler;
-		struct ext3_xattr_entry *next =
-			EXT3_XATTR_NEXT(entry);
-		if ((char *)next >= end)
-			goto bad_block;
-
-		handler = ext3_xattr_handler(entry->e_name_index);
-		if (handler)
-			size += handler->list(NULL, inode, entry->e_name,
-					      entry->e_name_len);
-	}
 
 	if (ext3_xattr_cache_insert(bh))
 		ea_idebug(inode, "cache insert failed");
-	if (!buffer) {
-		error = size;
-		goto cleanup;
-	} else {
-		error = -ERANGE;
-		if (size > buffer_size)
-			goto cleanup;
-	}
 
 	/* list the attribute names */
 	buf = buffer;
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT3_XATTR_NEXT(entry)) {
-		struct ext3_xattr_handler *handler;
+		struct xattr_handler *handler;
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(entry);
+
+		if ((char *)next >= end)
+			goto bad_block;
 
 		handler = ext3_xattr_handler(entry->e_name_index);
-		if (handler)
-			buf += handler->list(buf, inode, entry->e_name,
-					     entry->e_name_len);
+		if (handler) {
+			size_t size = handler->list(inode, buf, buffer_size,
+						    entry->e_name,
+						    entry->e_name_len);
+			if (buf) {
+				if (size > buffer_size) {
+					error = -ERANGE;
+					goto cleanup;
+				}
+				buf += size;
+				buffer_size -= size;
+			}
+			total_size += size;
+		}
 	}
-	error = size;
+	error = total_size;
 
 cleanup:
 	brelse(bh);
@@ -1178,51 +1075,12 @@ static void ext3_xattr_rehash(struct ext
 int __init
 init_ext3_xattr(void)
 {
-	int	err;
-
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_USER,
-				  &ext3_xattr_user_handler);
-	if (err)
-		return err;
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_TRUSTED,
-				  &ext3_xattr_trusted_handler);
-	if (err)
-		goto out;
-#ifdef CONFIG_EXT3_FS_SECURITY
-	err = ext3_xattr_register(EXT3_XATTR_INDEX_SECURITY,
-				  &ext3_xattr_security_handler);
-	if (err)
-		goto out1;
-#endif
-#ifdef CONFIG_EXT3_FS_POSIX_ACL
-	err = init_ext3_acl();
-	if (err)
-		goto out2;
-#endif
 	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
-	if (!ext3_xattr_cache) {
-		err = -ENOMEM;
-		goto out3;
-	}
+	if (!ext3_xattr_cache)
+		return -ENOMEM;
 	return 0;
-out3:
-#ifdef CONFIG_EXT3_FS_POSIX_ACL
-	exit_ext3_acl();
-out2:
-#endif
-#ifdef CONFIG_EXT3_FS_SECURITY
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
-			      &ext3_xattr_security_handler);
-out1:
-#endif
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
-			      &ext3_xattr_trusted_handler);
-out:
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
-			      &ext3_xattr_user_handler);
-	return err;
 }
 
 void
@@ -1231,15 +1089,4 @@ exit_ext3_xattr(void)
 	if (ext3_xattr_cache)
 		mb_cache_destroy(ext3_xattr_cache);
 	ext3_xattr_cache = NULL;
-#ifdef CONFIG_EXT3_FS_POSIX_ACL
-	exit_ext3_acl();
-#endif
-#ifdef CONFIG_EXT3_FS_SECURITY
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_SECURITY,
-			      &ext3_xattr_security_handler);
-#endif
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_TRUSTED,
-			      &ext3_xattr_trusted_handler);
-	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
-			      &ext3_xattr_user_handler);
 }
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/xattr.h linux-2.6.9-rc2-mm2.w/fs/ext3/xattr.h
--- linux-2.6.9-rc2-mm2.p/fs/ext3/xattr.h	2004-09-13 01:33:37.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/xattr.h	2004-09-22 19:30:08.373384584 -0400
@@ -56,23 +56,13 @@ struct ext3_xattr_entry {
 
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
+extern struct xattr_handler ext3_xattr_user_handler;
+extern struct xattr_handler ext3_xattr_trusted_handler;
+extern struct xattr_handler ext3_xattr_acl_access_handler;
+extern struct xattr_handler ext3_xattr_acl_default_handler;
+extern struct xattr_handler ext3_xattr_security_handler;
 
-extern int ext3_xattr_register(int, struct ext3_xattr_handler *);
-extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
-
-extern int ext3_setxattr(struct dentry *, const char *, const void *, size_t, int);
-extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
-extern int ext3_removexattr(struct dentry *, const char *);
 
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
 extern int ext3_xattr_list(struct inode *, char *, size_t);
@@ -85,11 +75,9 @@ extern void ext3_xattr_put_super(struct 
 extern int init_ext3_xattr(void);
 extern void exit_ext3_xattr(void);
 
+extern struct xattr_handler *ext3_xattr_handlers[];
+
 # else  /* CONFIG_EXT3_FS_XATTR */
-#  define ext3_setxattr		NULL
-#  define ext3_getxattr		NULL
-#  define ext3_listxattr	NULL
-#  define ext3_removexattr	NULL
 
 static inline int
 ext3_xattr_get(struct inode *inode, int name_index, const char *name,
@@ -139,8 +127,6 @@ exit_ext3_xattr(void)
 {
 }
 
-# endif  /* CONFIG_EXT3_FS_XATTR */
+#define ext3_xattr_handlers	NULL
 
-extern struct ext3_xattr_handler ext3_xattr_user_handler;
-extern struct ext3_xattr_handler ext3_xattr_trusted_handler;
-extern struct ext3_xattr_handler ext3_xattr_security_handler;
+# endif  /* CONFIG_EXT3_FS_XATTR */
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/xattr_security.c linux-2.6.9-rc2-mm2.w/fs/ext3/xattr_security.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/xattr_security.c	2004-09-13 01:32:45.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/xattr_security.c	2004-09-22 19:30:08.374384432 -0400
@@ -12,17 +12,19 @@
 #include "xattr.h"
 
 static size_t
-ext3_xattr_security_list(char *list, struct inode *inode,
-		    const char *name, int name_len)
+ext3_xattr_security_list(struct inode *inode, char *list, size_t list_size,
+			 const char *name, size_t name_len)
 {
-	const int prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
+	const size_t prefix_len = sizeof(XATTR_SECURITY_PREFIX)-1;
+	const size_t total_len = prefix_len + name_len + 1;
+	
 
-	if (list) {
+	if (list && (total_len <= list_size)) {
 		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
 	}
-	return prefix_len + name_len + 1;
+	return total_len;
 }
 
 static int
@@ -45,7 +47,7 @@ ext3_xattr_security_set(struct inode *in
 			      value, size, flags);
 }
 
-struct ext3_xattr_handler ext3_xattr_security_handler = {
+struct xattr_handler ext3_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= ext3_xattr_security_list,
 	.get	= ext3_xattr_security_get,
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/xattr_trusted.c linux-2.6.9-rc2-mm2.w/fs/ext3/xattr_trusted.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/xattr_trusted.c	2004-09-13 01:32:55.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/xattr_trusted.c	2004-09-22 19:30:08.375384280 -0400
@@ -16,20 +16,21 @@
 #define XATTR_TRUSTED_PREFIX "trusted."
 
 static size_t
-ext3_xattr_trusted_list(char *list, struct inode *inode,
-			const char *name, int name_len)
+ext3_xattr_trusted_list(struct inode *inode, char *list, size_t list_size,
+			const char *name, size_t name_len)
 {
-	const int prefix_len = sizeof(XATTR_TRUSTED_PREFIX)-1;
+	const size_t prefix_len = sizeof(XATTR_TRUSTED_PREFIX)-1;
+	const size_t total_len = prefix_len + name_len + 1;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return 0;
 
-	if (list) {
+	if (list && (total_len <= list_size)) {
 		memcpy(list, XATTR_TRUSTED_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
 	}
-	return prefix_len + name_len + 1;
+	return total_len;
 }
 
 static int
@@ -56,7 +57,7 @@ ext3_xattr_trusted_set(struct inode *ino
 			      value, size, flags);
 }
 
-struct ext3_xattr_handler ext3_xattr_trusted_handler = {
+struct xattr_handler ext3_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.list	= ext3_xattr_trusted_list,
 	.get	= ext3_xattr_trusted_get,
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/fs/ext3/xattr_user.c linux-2.6.9-rc2-mm2.w/fs/ext3/xattr_user.c
--- linux-2.6.9-rc2-mm2.p/fs/ext3/xattr_user.c	2004-09-13 01:31:43.000000000 -0400
+++ linux-2.6.9-rc2-mm2.w/fs/ext3/xattr_user.c	2004-09-22 19:30:08.375384280 -0400
@@ -16,20 +16,21 @@
 #define XATTR_USER_PREFIX "user."
 
 static size_t
-ext3_xattr_user_list(char *list, struct inode *inode,
-		     const char *name, int name_len)
+ext3_xattr_user_list(struct inode *inode, char *list, size_t list_size,
+		     const char *name, size_t name_len)
 {
-	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
+	const size_t prefix_len = sizeof(XATTR_USER_PREFIX)-1;
+	const size_t total_len = prefix_len + name_len + 1;
 
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return 0;
 
-	if (list) {
+	if (list && (total_len <= list_size)) {
 		memcpy(list, XATTR_USER_PREFIX, prefix_len);
 		memcpy(list+prefix_len, name, name_len);
 		list[prefix_len + name_len] = '\0';
 	}
-	return prefix_len + name_len + 1;
+	return total_len;
 }
 
 static int
@@ -70,7 +71,7 @@ ext3_xattr_user_set(struct inode *inode,
 			      value, size, flags);
 }
 
-struct ext3_xattr_handler ext3_xattr_user_handler = {
+struct xattr_handler ext3_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.list	= ext3_xattr_user_list,
 	.get	= ext3_xattr_user_get,



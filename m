Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUIRH3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUIRH3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIRH3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:29:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269153AbUIRHZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:25:56 -0400
Date: Sat, 18 Sep 2004 03:25:34 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] xattr consolidation v2 - ext2
In-Reply-To: <Xine.LNX.4.44.0409180308040.10905@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409180311190.10905-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ext2 xattr and acl code to the new generic xattr API.

 fs/ext2/acl.c            |   37 -------
 fs/ext2/acl.h            |    3 
 fs/ext2/file.c           |    8 +
 fs/ext2/namei.c          |   16 ++-
 fs/ext2/super.c          |    1 
 fs/ext2/symlink.c        |   16 ++-
 fs/ext2/xattr.c          |  221 +++++++----------------------------------------
 fs/ext2/xattr.h          |   32 +-----
 fs/ext2/xattr_security.c |    4 
 fs/ext2/xattr_trusted.c  |    4 
 fs/ext2/xattr_user.c     |   18 ---
 11 files changed, 82 insertions(+), 278 deletions(-)


Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>


diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/acl.c linux-2.6.9-rc2.w/fs/ext2/acl.c
--- linux-2.6.9-rc2.p/fs/ext2/acl.c	2004-09-13 01:33:11.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/acl.c	2004-09-18 01:47:46.546495768 -0400
@@ -429,7 +429,7 @@ ext2_acl_chmod(struct inode *inode)
  * Extended attribut handlers
  */
 static size_t
-ext2_xattr_list_acl_access(char *list, struct inode *inode,
+ext2_xattr_list_acl_access(struct inode *inode, char *list,
 			   const char *name, int name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_ACCESS);
@@ -442,7 +442,7 @@ ext2_xattr_list_acl_access(char *list, s
 }
 
 static size_t
-ext2_xattr_list_acl_default(char *list, struct inode *inode,
+ext2_xattr_list_acl_default(struct inode *inode, char *list,
 			    const char *name, int name_len)
 {
 	const size_t size = sizeof(XATTR_NAME_ACL_DEFAULT);
@@ -541,45 +541,16 @@ ext2_xattr_set_acl_default(struct inode 
 	return ext2_xattr_set_acl(inode, ACL_TYPE_DEFAULT, value, size);
 }
 
-struct ext2_xattr_handler ext2_xattr_acl_access_handler = {
+struct xattr_handler ext2_xattr_acl_access_handler = {
 	.prefix	= XATTR_NAME_ACL_ACCESS,
 	.list	= ext2_xattr_list_acl_access,
 	.get	= ext2_xattr_get_acl_access,
 	.set	= ext2_xattr_set_acl_access,
 };
 
-struct ext2_xattr_handler ext2_xattr_acl_default_handler = {
+struct xattr_handler ext2_xattr_acl_default_handler = {
 	.prefix	= XATTR_NAME_ACL_DEFAULT,
 	.list	= ext2_xattr_list_acl_default,
 	.get	= ext2_xattr_get_acl_default,
 	.set	= ext2_xattr_set_acl_default,
 };
-
-void
-exit_ext2_acl(void)
-{
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
-			      &ext2_xattr_acl_access_handler);
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
-			      &ext2_xattr_acl_default_handler);
-}
-
-int __init
-init_ext2_acl(void)
-{
-	int error;
-
-	error = ext2_xattr_register(EXT2_XATTR_INDEX_POSIX_ACL_ACCESS,
-				    &ext2_xattr_acl_access_handler);
-	if (error)
-		goto fail;
-	error = ext2_xattr_register(EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT,
-				    &ext2_xattr_acl_default_handler);
-	if (error)
-		goto fail;
-	return 0;
-
-fail:
-	exit_ext2_acl();
-	return error;
-}
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/acl.h linux-2.6.9-rc2.w/fs/ext2/acl.h
--- linux-2.6.9-rc2.p/fs/ext2/acl.h	2004-09-13 01:32:56.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/acl.h	2004-09-18 01:47:46.547495616 -0400
@@ -63,9 +63,6 @@ extern int ext2_permission (struct inode
 extern int ext2_acl_chmod (struct inode *);
 extern int ext2_init_acl (struct inode *, struct inode *);
 
-extern int init_ext2_acl(void);
-extern void exit_ext2_acl(void);
-
 #else
 #include <linux/sched.h>
 #define ext2_permission NULL
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/file.c linux-2.6.9-rc2.w/fs/ext2/file.c
--- linux-2.6.9-rc2.p/fs/ext2/file.c	2004-09-13 01:32:16.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/file.c	2004-09-18 01:47:46.548495464 -0400
@@ -57,10 +57,12 @@ struct file_operations ext2_file_operati
 
 struct inode_operations ext2_file_inode_operations = {
 	.truncate	= ext2_truncate,
-	.setxattr	= ext2_setxattr,
-	.getxattr	= ext2_getxattr,
+#ifdef CONFIG_EXT2_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext2_listxattr,
-	.removexattr	= ext2_removexattr,
+	.removexattr	= generic_removexattr,
+#endif
 	.setattr	= ext2_setattr,
 	.permission	= ext2_permission,
 };
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/namei.c linux-2.6.9-rc2.w/fs/ext2/namei.c
--- linux-2.6.9-rc2.p/fs/ext2/namei.c	2004-09-13 01:33:23.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/namei.c	2004-09-18 01:47:46.549495312 -0400
@@ -395,19 +395,23 @@ struct inode_operations ext2_dir_inode_o
 	.rmdir		= ext2_rmdir,
 	.mknod		= ext2_mknod,
 	.rename		= ext2_rename,
-	.setxattr	= ext2_setxattr,
-	.getxattr	= ext2_getxattr,
+#ifdef CONFIG_EXT2_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext2_listxattr,
-	.removexattr	= ext2_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 	.setattr	= ext2_setattr,
 	.permission	= ext2_permission,
 };
 
 struct inode_operations ext2_special_inode_operations = {
-	.setxattr	= ext2_setxattr,
-	.getxattr	= ext2_getxattr,
+#ifdef CONFIG_EXT2_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext2_listxattr,
-	.removexattr	= ext2_removexattr,
+	.removexattr	= generic_removexattr,
+#endif
 	.setattr	= ext2_setattr,
 	.permission	= ext2_permission,
 };
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/super.c linux-2.6.9-rc2.w/fs/ext2/super.c
--- linux-2.6.9-rc2.p/fs/ext2/super.c	2004-09-13 01:32:55.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/super.c	2004-09-18 01:47:46.550495160 -0400
@@ -800,6 +800,7 @@ static int ext2_fill_super(struct super_
 	 */
 	sb->s_op = &ext2_sops;
 	sb->s_export_op = &ext2_export_ops;
+	sb->s_xattr = ext2_xattr_handlers;
 	root = iget(sb, EXT2_ROOT_INO);
 	sb->s_root = d_alloc_root(root);
 	if (!sb->s_root) {
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/symlink.c linux-2.6.9-rc2.w/fs/ext2/symlink.c
--- linux-2.6.9-rc2.p/fs/ext2/symlink.c	2004-09-13 01:31:58.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/symlink.c	2004-09-18 01:47:46.551495008 -0400
@@ -32,17 +32,21 @@ struct inode_operations ext2_symlink_ino
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
-	.setxattr	= ext2_setxattr,
-	.getxattr	= ext2_getxattr,
+#ifdef CONFIG_EXT2_FS_XATTR	
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext2_listxattr,
-	.removexattr	= ext2_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 };
  
 struct inode_operations ext2_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ext2_follow_link,
-	.setxattr	= ext2_setxattr,
-	.getxattr	= ext2_getxattr,
+#ifdef CONFIG_EXT2_FS_XATTR	
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
 	.listxattr	= ext2_listxattr,
-	.removexattr	= ext2_removexattr,
+	.removexattr	= generic_removexattr,
+#endif	
 };
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/xattr.c linux-2.6.9-rc2.w/fs/ext2/xattr.c
--- linux-2.6.9-rc2.p/fs/ext2/xattr.c	2004-09-13 01:32:54.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/xattr.c	2004-09-18 01:47:46.553494704 -0400
@@ -6,6 +6,9 @@
  * Fix by Harrison Xing <harrison@mountainviewdata.com>.
  * Extended attributes for symlinks and special files added per
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
+ * xattr consolidation Copyright (c) 2004 James Morris <jmorris@redhat.com>,
+ *  Red Hat Inc.
+ *
  */
 
 /*
@@ -62,8 +65,6 @@
 #include "acl.h"
 
 /* These symbols may be needed by a module. */
-EXPORT_SYMBOL(ext2_xattr_register);
-EXPORT_SYMBOL(ext2_xattr_unregister);
 EXPORT_SYMBOL(ext2_xattr_get);
 EXPORT_SYMBOL(ext2_xattr_list);
 EXPORT_SYMBOL(ext2_xattr_set);
@@ -104,101 +105,40 @@ static void ext2_xattr_rehash(struct ext
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
+static struct xattr_handler *ext2_xattr_handler_map[EXT2_XATTR_INDEX_MAX] = {
+	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
+#ifdef CONFIG_EXT2_FS_POSIX_ACL	
+	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &ext2_xattr_acl_access_handler,
+	[EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT] = &ext2_xattr_acl_default_handler,
+#endif	
+	[EXT2_XATTR_INDEX_TRUSTED]	     = &ext2_xattr_trusted_handler,
+#ifdef CONFIG_EXT2_FS_SECURITY
+	[EXT2_XATTR_INDEX_SECURITY]	     = &ext2_xattr_security_handler,
+#endif
+};
 
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
+struct xattr_handler *ext2_xattr_handlers[] = {
+	&ext2_xattr_user_handler,
+	&ext2_xattr_trusted_handler,
+#ifdef CONFIG_EXT2_FS_POSIX_ACL			
+	&ext2_xattr_acl_access_handler,
+	&ext2_xattr_acl_default_handler,
+#endif
+#ifdef CONFIG_EXT2_FS_SECURITY	
+	&ext2_xattr_security_handler,
+#endif	
+	NULL
+};
 
-static inline struct ext2_xattr_handler *
+static inline struct xattr_handler *
 ext2_xattr_handler(int name_index)
 {
-	struct ext2_xattr_handler *handler = NULL;
-	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX) {
-		read_lock(&ext2_handler_lock);
-		handler = ext2_xattr_handlers[name_index-1];
-		read_unlock(&ext2_handler_lock);
-	}
-	return handler;
-}
-
-/*
- * Inode operation getxattr()
- *
- * dentry->d_inode->i_sem: don't care
- */
-ssize_t
-ext2_getxattr(struct dentry *dentry, const char *name,
-	      void *buffer, size_t size)
-{
-	struct ext2_xattr_handler *handler;
-	struct inode *inode = dentry->d_inode;
+	struct xattr_handler *handler = NULL;
 
-	handler = ext2_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->get(inode, name, buffer, size);
+	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX)
+		handler = ext2_xattr_handler_map[name_index];
+	return handler;
 }
 
 /*
@@ -213,43 +153,6 @@ ext2_listxattr(struct dentry *dentry, ch
 }
 
 /*
- * Inode operation setxattr()
- *
- * dentry->d_inode->i_sem: down
- */
-int
-ext2_setxattr(struct dentry *dentry, const char *name,
-	      const void *value, size_t size, int flags)
-{
-	struct ext2_xattr_handler *handler;
-	struct inode *inode = dentry->d_inode;
-
-	if (size == 0)
-		value = "";  /* empty EA, do not remove */
-	handler = ext2_xattr_resolve_name(&name);
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
-ext2_removexattr(struct dentry *dentry, const char *name)
-{
-	struct ext2_xattr_handler *handler;
-	struct inode *inode = dentry->d_inode;
-
-	handler = ext2_xattr_resolve_name(&name);
-	if (!handler)
-		return -EOPNOTSUPP;
-	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
-}
-
-/*
  * ext2_xattr_get()
  *
  * Copy an extended attribute into the buffer
@@ -397,7 +300,7 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 	/* compute the size required for the list of attribute names */
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT2_XATTR_NEXT(entry)) {
-		struct ext2_xattr_handler *handler;
+		struct xattr_handler *handler;
 		struct ext2_xattr_entry *next =
 			EXT2_XATTR_NEXT(entry);
 		if ((char *)next >= end)
@@ -405,7 +308,7 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 
 		handler = ext2_xattr_handler(entry->e_name_index);
 		if (handler)
-			size += handler->list(NULL, inode, entry->e_name,
+			size += handler->list(inode, NULL, entry->e_name,
 					      entry->e_name_len);
 	}
 
@@ -424,11 +327,11 @@ bad_block:	ext2_error(inode->i_sb, "ext2
 	buf = buffer;
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT2_XATTR_NEXT(entry)) {
-		struct ext2_xattr_handler *handler;
+		struct xattr_handler *handler;
 		
 		handler = ext2_xattr_handler(entry->e_name_index);
 		if (handler)
-			buf += handler->list(buf, inode, entry->e_name,
+			buf += handler->list(inode, buf, entry->e_name,
 					     entry->e_name_len);
 	}
 	error = size;
@@ -1120,66 +1023,16 @@ static void ext2_xattr_rehash(struct ext
 int __init
 init_ext2_xattr(void)
 {
-	int	err;
-	
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_USER,
-				  &ext2_xattr_user_handler);
-	if (err)
-		return err;
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_TRUSTED,
-				  &ext2_xattr_trusted_handler);
-	if (err)
-		goto out;
-#ifdef CONFIG_EXT2_FS_SECURITY
-	err = ext2_xattr_register(EXT2_XATTR_INDEX_SECURITY,
-				  &ext2_xattr_security_handler);
-	if (err)
-		goto out1;
-#endif
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	err = init_ext2_acl();
-	if (err)
-		goto out2;
-#endif
 	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
 		sizeof(struct mb_cache_entry_index), 1, 6);
-	if (!ext2_xattr_cache) {
-		err = -ENOMEM;
-		goto out3;
-	}
+	if (!ext2_xattr_cache)
+		return -ENOMEM;
 	return 0;
-out3:
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	exit_ext2_acl();
-out2:
-#endif
-#ifdef CONFIG_EXT2_FS_SECURITY
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
-			      &ext2_xattr_security_handler);
-out1:
-#endif
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
-			      &ext2_xattr_trusted_handler);
-out:
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
-			      &ext2_xattr_user_handler);
-	return err;
 }
 
 void
 exit_ext2_xattr(void)
 {
 	mb_cache_destroy(ext2_xattr_cache);
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	exit_ext2_acl();
-#endif
-#ifdef CONFIG_EXT2_FS_SECURITY
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_SECURITY,
-			      &ext2_xattr_security_handler);
-#endif
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_TRUSTED,
-			      &ext2_xattr_trusted_handler);
-	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
-			      &ext2_xattr_user_handler);
 }
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/xattr.h linux-2.6.9-rc2.w/fs/ext2/xattr.h
--- linux-2.6.9-rc2.p/fs/ext2/xattr.h	2004-09-13 01:32:55.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/xattr.h	2004-09-18 01:47:46.554494552 -0400
@@ -57,23 +57,13 @@ struct ext2_xattr_entry {
 
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
+extern struct xattr_handler ext2_xattr_user_handler;
+extern struct xattr_handler ext2_xattr_trusted_handler;
+extern struct xattr_handler ext2_xattr_acl_access_handler;
+extern struct xattr_handler ext2_xattr_acl_default_handler;
+extern struct xattr_handler ext2_xattr_security_handler;
 
-extern int ext2_xattr_register(int, struct ext2_xattr_handler *);
-extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
-
-extern int ext2_setxattr(struct dentry *, const char *, const void *, size_t, int);
-extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
 extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
-extern int ext2_removexattr(struct dentry *, const char *);
 
 extern int ext2_xattr_get(struct inode *, int, const char *, void *, size_t);
 extern int ext2_xattr_list(struct inode *, char *, size_t);
@@ -85,11 +75,9 @@ extern void ext2_xattr_put_super(struct 
 extern int init_ext2_xattr(void);
 extern void exit_ext2_xattr(void);
 
+extern struct xattr_handler *ext2_xattr_handlers[];
+
 # else  /* CONFIG_EXT2_FS_XATTR */
-#  define ext2_setxattr		NULL
-#  define ext2_getxattr		NULL
-#  define ext2_listxattr	NULL
-#  define ext2_removexattr	NULL
 
 static inline int
 ext2_xattr_get(struct inode *inode, int name_index,
@@ -132,9 +120,7 @@ exit_ext2_xattr(void)
 {
 }
 
-# endif  /* CONFIG_EXT2_FS_XATTR */
+#define ext2_xattr_handlers NULL
 
-extern struct ext2_xattr_handler ext2_xattr_user_handler;
-extern struct ext2_xattr_handler ext2_xattr_trusted_handler;
-extern struct ext2_xattr_handler ext2_xattr_security_handler;
+# endif  /* CONFIG_EXT2_FS_XATTR */
 
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/xattr_security.c linux-2.6.9-rc2.w/fs/ext2/xattr_security.c
--- linux-2.6.9-rc2.p/fs/ext2/xattr_security.c	2004-09-13 01:32:47.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/xattr_security.c	2004-09-18 01:47:46.555494400 -0400
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
+struct xattr_handler ext2_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= ext2_xattr_security_list,
 	.get	= ext2_xattr_security_get,
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/xattr_trusted.c linux-2.6.9-rc2.w/fs/ext2/xattr_trusted.c
--- linux-2.6.9-rc2.p/fs/ext2/xattr_trusted.c	2004-09-13 01:31:43.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/xattr_trusted.c	2004-09-18 01:47:46.556494248 -0400
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
+struct xattr_handler ext2_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.list	= ext2_xattr_trusted_list,
 	.get	= ext2_xattr_trusted_get,
diff -purN -X dontdiff linux-2.6.9-rc2.p/fs/ext2/xattr_user.c linux-2.6.9-rc2.w/fs/ext2/xattr_user.c
--- linux-2.6.9-rc2.p/fs/ext2/xattr_user.c	2004-09-13 01:32:54.000000000 -0400
+++ linux-2.6.9-rc2.w/fs/ext2/xattr_user.c	2004-09-18 01:47:46.557494096 -0400
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
+struct xattr_handler ext2_xattr_user_handler = {
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



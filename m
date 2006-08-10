Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbWHJBSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbWHJBSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWHJBSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:18:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:49382 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030522AbWHJBR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:17:58 -0400
Subject: [PATCH 2/5] Register ext3dev filesystem
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:17:22 -0700
Message-Id: <1155172642.3161.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Register ext4 filesystem as ext3dev filesystem in kernel.

Signed-Off-By: Mingming Cao<cmm@us.ibm.com>


---

 linux-2.6.18-rc4-ming/fs/Kconfig                |   74 ++++++++++++++++++++++--
 linux-2.6.18-rc4-ming/fs/Makefile               |    1 
 linux-2.6.18-rc4-ming/fs/ext4/Makefile          |   10 +--
 linux-2.6.18-rc4-ming/fs/ext4/acl.h             |    6 -
 linux-2.6.18-rc4-ming/fs/ext4/file.c            |    2 
 linux-2.6.18-rc4-ming/fs/ext4/inode.c           |    2 
 linux-2.6.18-rc4-ming/fs/ext4/namei.c           |    6 -
 linux-2.6.18-rc4-ming/fs/ext4/super.c           |   20 +++---
 linux-2.6.18-rc4-ming/fs/ext4/symlink.c         |    4 -
 linux-2.6.18-rc4-ming/fs/ext4/xattr.c           |    8 +-
 linux-2.6.18-rc4-ming/fs/ext4/xattr.h           |    8 +-
 linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h |    4 -
 12 files changed, 106 insertions(+), 39 deletions(-)

diff -puN fs/ext4/super.c~register-ext3dev fs/ext4/super.c
--- linux-2.6.18-rc4/fs/ext4/super.c~register-ext3dev	2006-08-09 15:41:29.273105685 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/super.c	2006-08-09 15:41:29.317106042 -0700
@@ -447,7 +447,7 @@ static struct inode *ext4_alloc_inode(st
 	ei = kmem_cache_alloc(ext4_inode_cachep, SLAB_NOFS);
 	if (!ei)
 		return NULL;
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 	ei->i_acl = EXT4_ACL_NOT_CACHED;
 	ei->i_default_acl = EXT4_ACL_NOT_CACHED;
 #endif
@@ -468,7 +468,7 @@ static void init_once(void * foo, kmem_c
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
 		INIT_LIST_HEAD(&ei->i_orphan);
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 		init_rwsem(&ei->xattr_sem);
 #endif
 		mutex_init(&ei->truncate_mutex);
@@ -497,7 +497,7 @@ static void destroy_inodecache(void)
 static void ext4_clear_inode(struct inode *inode)
 {
 	struct ext4_block_alloc_info *rsv = EXT4_I(inode)->i_block_alloc_info;
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 	if (EXT4_I(inode)->i_acl &&
 			EXT4_I(inode)->i_acl != EXT4_ACL_NOT_CACHED) {
 		posix_acl_release(EXT4_I(inode)->i_acl);
@@ -790,7 +790,7 @@ static int parse_options (char *options,
 		case Opt_orlov:
 			clear_opt (sbi->s_mount_opt, OLDALLOC);
 			break;
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 		case Opt_user_xattr:
 			set_opt (sbi->s_mount_opt, XATTR_USER);
 			break;
@@ -803,7 +803,7 @@ static int parse_options (char *options,
 			printk("EXT4 (no)user_xattr options not supported\n");
 			break;
 #endif
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 		case Opt_acl:
 			set_opt(sbi->s_mount_opt, POSIX_ACL);
 			break;
@@ -2669,9 +2669,9 @@ static int ext4_get_sb(struct file_syste
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext4_fill_super, mnt);
 }
 
-static struct file_system_type ext4_fs_type = {
+static struct file_system_type ext3dev_fs_type = {
 	.owner		= THIS_MODULE,
-	.name		= "ext4",
+	.name		= "ext3dev",
 	.get_sb		= ext4_get_sb,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
@@ -2685,7 +2685,7 @@ static int __init init_ext4_fs(void)
 	err = init_inodecache();
 	if (err)
 		goto out1;
-        err = register_filesystem(&ext4_fs_type);
+        err = register_filesystem(&ext3dev_fs_type);
 	if (err)
 		goto out;
 	return 0;
@@ -2698,13 +2698,13 @@ out1:
 
 static void __exit exit_ext4_fs(void)
 {
-	unregister_filesystem(&ext4_fs_type);
+	unregister_filesystem(&ext3dev_fs_type);
 	destroy_inodecache();
 	exit_ext4_xattr();
 }
 
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
-MODULE_DESCRIPTION("Second Extended Filesystem with journaling extensions");
+MODULE_DESCRIPTION("Fourth Extended Filesystem with extents");
 MODULE_LICENSE("GPL");
 module_init(init_ext4_fs)
 module_exit(exit_ext4_fs)
diff -puN fs/Kconfig~register-ext3dev fs/Kconfig
--- linux-2.6.18-rc4/fs/Kconfig~register-ext3dev	2006-08-09 15:41:29.277105718 -0700
+++ linux-2.6.18-rc4-ming/fs/Kconfig	2006-08-09 15:41:29.321106074 -0700
@@ -138,6 +138,72 @@ config EXT3_FS_SECURITY
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config EXT3DEV_FS
+	tristate "Developmenting extended fs support"
+	select JBD
+	help
+	  Ext3dev is a precede filesystem toward next generation
+	  of extended fs, based on ext3 filesystem code. It will be
+	  renamed ext4 fs later once this ext3dev is mature and stabled.
+
+	  Unlike the change from ext2 filesystem to ext3 filesystem,
+	  the on-disk format of ext3dev is not the same as ext3 any more:
+	  it is based on extent maps and it support 48 bit physical block
+	  numbers. These combined on-disk format changes will allow
+	  ext3dev/ext4 to handle more than 16TB filesystem volume --
+	  a hard limit that ext3 can not overcome without changing
+	  on-disk format.
+
+	  Other than extent maps and 48 bit block number, ext3dev also is
+	  likely to have other new features such as persistent preallocation,
+	  high resolution time stamps and larger file support etc.  These
+	  features will be added to ext3dev gradually.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called ext2.  Be aware however that the file system
+	  of your root partition (the one containing the directory /) cannot
+	  be compiled as a module, and so this could be dangerous.
+
+	  If unsure, say N.
+
+config EXT3DEV_FS_XATTR
+	bool "Ext3dev extended attributes"
+	depends on EXT3DEV_FS
+	default y
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+
+	  If unsure, say N.
+
+	  You need this for POSIX ACL support on ext3.
+
+config EXT3DEV_FS_POSIX_ACL
+	bool "Ext3dev POSIX Access Control Lists"
+	depends on EXT3DEV_FS_XATTR
+	select FS_POSIX_ACL
+	help
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
+config EXT3DEV_FS_SECURITY
+	bool "Ext3dev Security Labels"
+	depends on EXT3DEV_FS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the ext3 filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config JBD
 	tristate
 	help
@@ -171,11 +237,11 @@ config JBD_DEBUG
 	  "echo 0 > /proc/sys/fs/jbd-debug".
 
 config FS_MBCACHE
-# Meta block cache for Extended Attributes (ext2/ext3)
+# Meta block cache for Extended Attributes (ext2/ext3/ext4)
 	tristate
-	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
-	default y if EXT2_FS=y || EXT3_FS=y
-	default m if EXT2_FS=m || EXT3_FS=m
+	depends on EXT2_FS_XATTR || EXT3_FS_XATTR || EXT3DEV_FS_XATTR
+	default y if EXT2_FS=y || EXT3_FS=y || EXT3DEV_FS=y
+	default m if EXT2_FS=m || EXT3_FS=m || EXT3DEV_FS=m
 
 config REISERFS_FS
 	tristate "Reiserfs support"
diff -puN fs/Makefile~register-ext3dev fs/Makefile
--- linux-2.6.18-rc4/fs/Makefile~register-ext3dev	2006-08-09 15:41:29.280105742 -0700
+++ linux-2.6.18-rc4-ming/fs/Makefile	2006-08-09 15:41:29.322106082 -0700
@@ -54,6 +54,7 @@ obj-$(CONFIG_PROFILING)		+= dcookies.o
 # Do not add any filesystems before this line
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
+obj-$(CONFIG_EXT3DEV_FS)	+= ext4/ # Before ext2 so root fs can be ext3dev
 obj-$(CONFIG_JBD)		+= jbd/
 obj-$(CONFIG_EXT2_FS)		+= ext2/
 obj-$(CONFIG_CRAMFS)		+= cramfs/
diff -puN include/linux/ext4_fs_i.h~register-ext3dev include/linux/ext4_fs_i.h
--- linux-2.6.18-rc4/include/linux/ext4_fs_i.h~register-ext3dev	2006-08-09 15:41:29.284105775 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h	2006-08-09 15:41:29.323106090 -0700
@@ -93,7 +93,7 @@ struct ext4_inode_info {
 	struct ext4_block_alloc_info *i_block_alloc_info;
 
 	__u32	i_dir_start_lookup;
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 	/*
 	 * Extended attributes can be read independently of the main file
 	 * data. Taking i_mutex even when reading would cause contention
@@ -103,7 +103,7 @@ struct ext4_inode_info {
 	 */
 	struct rw_semaphore xattr_sem;
 #endif
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 	struct posix_acl	*i_acl;
 	struct posix_acl	*i_default_acl;
 #endif
diff -puN fs/ext4/acl.h~register-ext3dev fs/ext4/acl.h
--- linux-2.6.18-rc4/fs/ext4/acl.h~register-ext3dev	2006-08-09 15:41:29.287105799 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/acl.h	2006-08-09 15:41:29.323106090 -0700
@@ -51,7 +51,7 @@ static inline int ext4_acl_count(size_t 
 	}
 }
 
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 
 /* Value for inode->u.ext4_i.i_acl and inode->u.ext4_i.i_default_acl
    if the ACL has not been cached */
@@ -62,7 +62,7 @@ extern int ext4_permission (struct inode
 extern int ext4_acl_chmod (struct inode *);
 extern int ext4_init_acl (handle_t *, struct inode *, struct inode *);
 
-#else  /* CONFIG_EXT4_FS_POSIX_ACL */
+#else  /* CONFIG_EXT3DEV_FS_POSIX_ACL */
 #include <linux/sched.h>
 #define ext4_permission NULL
 
@@ -77,5 +77,5 @@ ext4_init_acl(handle_t *handle, struct i
 {
 	return 0;
 }
-#endif  /* CONFIG_EXT4_FS_POSIX_ACL */
+#endif  /* CONFIG_EXT3DEV_FS_POSIX_ACL */
 
diff -puN fs/ext4/file.c~register-ext3dev fs/ext4/file.c
--- linux-2.6.18-rc4/fs/ext4/file.c~register-ext3dev	2006-08-09 15:41:29.290105823 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/file.c	2006-08-09 15:41:29.324106098 -0700
@@ -126,7 +126,7 @@ const struct file_operations ext4_file_o
 struct inode_operations ext4_file_inode_operations = {
 	.truncate	= ext4_truncate,
 	.setattr	= ext4_setattr,
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
 	.listxattr	= ext4_listxattr,
diff -puN fs/ext4/inode.c~register-ext3dev fs/ext4/inode.c
--- linux-2.6.18-rc4/fs/ext4/inode.c~register-ext3dev	2006-08-09 15:41:29.294105856 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/inode.c	2006-08-09 15:41:29.329106139 -0700
@@ -2584,7 +2584,7 @@ void ext4_read_inode(struct inode * inod
 	struct buffer_head *bh;
 	int block;
 
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 	ei->i_acl = EXT4_ACL_NOT_CACHED;
 	ei->i_default_acl = EXT4_ACL_NOT_CACHED;
 #endif
diff -puN fs/ext4/namei.c~register-ext3dev fs/ext4/namei.c
--- linux-2.6.18-rc4/fs/ext4/namei.c~register-ext3dev	2006-08-09 15:41:29.298105888 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/namei.c	2006-08-09 15:41:29.332106163 -0700
@@ -1689,7 +1689,7 @@ retry:
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 		inode->i_op = &ext4_special_inode_operations;
 #endif
 		err = ext4_add_nondir(handle, dentry, inode);
@@ -2364,7 +2364,7 @@ struct inode_operations ext4_dir_inode_o
 	.mknod		= ext4_mknod,
 	.rename		= ext4_rename,
 	.setattr	= ext4_setattr,
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
 	.listxattr	= ext4_listxattr,
@@ -2375,7 +2375,7 @@ struct inode_operations ext4_dir_inode_o
 
 struct inode_operations ext4_special_inode_operations = {
 	.setattr	= ext4_setattr,
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
 	.listxattr	= ext4_listxattr,
diff -puN fs/ext4/symlink.c~register-ext3dev fs/ext4/symlink.c
--- linux-2.6.18-rc4/fs/ext4/symlink.c~register-ext3dev	2006-08-09 15:41:29.301105912 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/symlink.c	2006-08-09 15:41:29.333106171 -0700
@@ -34,7 +34,7 @@ struct inode_operations ext4_symlink_ino
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
 	.listxattr	= ext4_listxattr,
@@ -45,7 +45,7 @@ struct inode_operations ext4_symlink_ino
 struct inode_operations ext4_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ext4_follow_link,
-#ifdef CONFIG_EXT4_FS_XATTR
+#ifdef CONFIG_EXT3DEV_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
 	.listxattr	= ext4_listxattr,
diff -puN fs/ext4/xattr.c~register-ext3dev fs/ext4/xattr.c
--- linux-2.6.18-rc4/fs/ext4/xattr.c~register-ext3dev	2006-08-09 15:41:29.304105937 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/xattr.c	2006-08-09 15:41:29.335106188 -0700
@@ -104,12 +104,12 @@ static struct mb_cache *ext4_xattr_cache
 
 static struct xattr_handler *ext4_xattr_handler_map[] = {
 	[EXT4_XATTR_INDEX_USER]		     = &ext4_xattr_user_handler,
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 	[EXT4_XATTR_INDEX_POSIX_ACL_ACCESS]  = &ext4_xattr_acl_access_handler,
 	[EXT4_XATTR_INDEX_POSIX_ACL_DEFAULT] = &ext4_xattr_acl_default_handler,
 #endif
 	[EXT4_XATTR_INDEX_TRUSTED]	     = &ext4_xattr_trusted_handler,
-#ifdef CONFIG_EXT4_FS_SECURITY
+#ifdef CONFIG_EXT3DEV_FS_SECURITY
 	[EXT4_XATTR_INDEX_SECURITY]	     = &ext4_xattr_security_handler,
 #endif
 };
@@ -117,11 +117,11 @@ static struct xattr_handler *ext4_xattr_
 struct xattr_handler *ext4_xattr_handlers[] = {
 	&ext4_xattr_user_handler,
 	&ext4_xattr_trusted_handler,
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
+#ifdef CONFIG_EXT3DEV_FS_POSIX_ACL
 	&ext4_xattr_acl_access_handler,
 	&ext4_xattr_acl_default_handler,
 #endif
-#ifdef CONFIG_EXT4_FS_SECURITY
+#ifdef CONFIG_EXT3DEV_FS_SECURITY
 	&ext4_xattr_security_handler,
 #endif
 	NULL
diff -puN fs/ext4/xattr.h~register-ext3dev fs/ext4/xattr.h
--- linux-2.6.18-rc4/fs/ext4/xattr.h~register-ext3dev	2006-08-09 15:41:29.307105961 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/xattr.h	2006-08-09 15:41:29.336106196 -0700
@@ -56,7 +56,7 @@ struct ext4_xattr_entry {
 #define EXT4_XATTR_SIZE(size) \
 	(((size) + EXT4_XATTR_ROUND) & ~EXT4_XATTR_ROUND)
 
-# ifdef CONFIG_EXT4_FS_XATTR
+# ifdef CONFIG_EXT3DEV_FS_XATTR
 
 extern struct xattr_handler ext4_xattr_user_handler;
 extern struct xattr_handler ext4_xattr_trusted_handler;
@@ -79,7 +79,7 @@ extern void exit_ext4_xattr(void);
 
 extern struct xattr_handler *ext4_xattr_handlers[];
 
-# else  /* CONFIG_EXT4_FS_XATTR */
+# else  /* CONFIG_EXT3DEV_FS_XATTR */
 
 static inline int
 ext4_xattr_get(struct inode *inode, int name_index, const char *name,
@@ -131,9 +131,9 @@ exit_ext4_xattr(void)
 
 #define ext4_xattr_handlers	NULL
 
-# endif  /* CONFIG_EXT4_FS_XATTR */
+# endif  /* CONFIG_EXT3DEV_FS_XATTR */
 
-#ifdef CONFIG_EXT4_FS_SECURITY
+#ifdef CONFIG_EXT3DEV_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 				struct inode *dir);
 #else
diff -puN fs/ext4/Makefile~register-ext3dev fs/ext4/Makefile
--- linux-2.6.18-rc4/fs/ext4/Makefile~register-ext3dev	2006-08-09 15:41:29.310105985 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/Makefile	2006-08-09 15:41:29.336106196 -0700
@@ -2,11 +2,11 @@
 # Makefile for the linux ext4-filesystem routines.
 #
 
-obj-$(CONFIG_EXT4_FS) += ext4.o
+obj-$(CONFIG_EXT3DEV_FS) += ext3dev.o
 
-ext4-y	:= balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
+ext3dev-y	:= balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 	   ioctl.o namei.o super.o symlink.o hash.o resize.o
 
-ext4-$(CONFIG_EXT4_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
-ext4-$(CONFIG_EXT4_FS_POSIX_ACL) += acl.o
-ext4-$(CONFIG_EXT4_FS_SECURITY)	 += xattr_security.o
+ext3dev-$(CONFIG_EXT3DEV_FS_XATTR)	+= xattr.o xattr_user.o xattr_trusted.o
+ext3dev-$(CONFIG_EXT3DEV_FS_POSIX_ACL)	+= acl.o
+ext3dev-$(CONFIG_EXT3DEV_FS_SECURITY)	+= xattr_security.o

_



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSJ2Qmr>; Tue, 29 Oct 2002 11:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSJ2Qmi>; Tue, 29 Oct 2002 11:42:38 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:42976 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261934AbSJ2QgB>;
	Tue, 29 Oct 2002 11:36:01 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 6/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E186ZRb-0006ta-00@snap.thunk.org>
Date: Tue, 29 Oct 2002 11:42:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Port of (bugfixed) 0.8.50 xattr-ext2 to 2.5 (w/ hch cleanups. mbcache API)

This patch adds extended attribute support to the ext2 filesystem.  This
uses the generic extended attribute patch which was developed by Andreas
Gruenbacher and the XFS team.  As a result, the user space utilities
which work for XFS will also work with these patches.

fs/Config.help          |    7 
fs/Config.in            |    1 
fs/ext2/Makefile        |    6 
fs/ext2/ext2.h          |    2 
fs/ext2/file.c          |    7 
fs/ext2/ialloc.c        |    4 
fs/ext2/inode.c         |   39 -
fs/ext2/namei.c         |   16 
fs/ext2/super.c         |   20 
fs/ext2/symlink.c       |   14 
fs/ext2/xattr.c         | 1118 ++++++++++++++++++++++++++++++++++++++++++++++++
fs/ext2/xattr.h         |  135 +++++
fs/ext2/xattr_user.c    |  102 ++++
include/linux/ext2_fs.h |   28 -
14 files changed, 1450 insertions(+), 49 deletions(-)

diff -Nru a/fs/Config.help b/fs/Config.help
--- a/fs/Config.help	Tue Oct 29 09:55:08 2002
+++ b/fs/Config.help	Tue Oct 29 09:55:08 2002
@@ -123,6 +123,13 @@
   be compiled as a module, and so this could be dangerous.  Most
   everyone wants to say Y here.
 
+CONFIG_EXT2_FS_XATTR
+  Extended attributes are name:value pairs associated with inodes by
+  the kernel or by users (see the attr(5) manual page, or visit
+  <http://acl.bestbits.at/> for details).
+
+  If unsure, say N.
+
 CONFIG_EXT3_FS
   This is the journaling version of the Second extended file system
   (often called ext3), the de facto standard Linux file system
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Oct 29 09:55:08 2002
+++ b/fs/Config.in	Tue Oct 29 09:55:08 2002
@@ -96,6 +96,7 @@
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
 tristate 'Second extended fs support' CONFIG_EXT2_FS
+dep_mbool '  Ext2 extended attributes' CONFIG_EXT2_FS_XATTR $CONFIG_EXT2_FS
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 
diff -Nru a/fs/ext2/Makefile b/fs/ext2/Makefile
--- a/fs/ext2/Makefile	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/Makefile	Tue Oct 29 09:55:08 2002
@@ -7,4 +7,10 @@
 ext2-objs := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 	     ioctl.o namei.o super.o symlink.o
 
+export-objs += xattr.o
+
+ifeq ($(CONFIG_EXT2_FS_XATTR),y)
+ext2-objs += xattr.o xattr_user.o
+endif
+
 include $(TOPDIR)/Rules.make
diff -Nru a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/ext2.h	Tue Oct 29 09:55:08 2002
@@ -117,6 +117,8 @@
 
 /* namei.c */
 extern struct inode_operations ext2_dir_inode_operations;
+extern struct inode_operations ext2_special_inode_operations;
 
 /* symlink.c */
 extern struct inode_operations ext2_fast_symlink_inode_operations;
+extern struct inode_operations ext2_symlink_inode_operations;
diff -Nru a/fs/ext2/file.c b/fs/ext2/file.c
--- a/fs/ext2/file.c	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/file.c	Tue Oct 29 09:55:08 2002
@@ -18,8 +18,9 @@
  * 	(jj@sunsite.ms.mff.cuni.cz)
  */
 
-#include "ext2.h"
 #include <linux/time.h>
+#include "ext2.h"
+#include "xattr.h"
 
 /*
  * Called when an inode is released. Note that this is different
@@ -55,4 +56,8 @@
 
 struct inode_operations ext2_file_inode_operations = {
 	.truncate	= ext2_truncate,
+	.setxattr	= ext2_setxattr,
+	.getxattr	= ext2_getxattr,
+	.listxattr	= ext2_listxattr,
+	.removexattr	= ext2_removexattr,
 };
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/ialloc.c	Tue Oct 29 09:55:08 2002
@@ -13,11 +13,12 @@
  */
 
 #include <linux/config.h>
-#include "ext2.h"
 #include <linux/quotaops.h>
 #include <linux/sched.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include "ext2.h"
+#include "xattr.h"
 
 /*
  * ialloc.c contains the inodes allocation and deallocation routines
@@ -97,6 +98,7 @@
 	 */
 	if (!is_bad_inode(inode)) {
 		/* Quota is already initialized in iput() */
+		ext2_xattr_delete_inode(inode);
 	    	DQUOT_FREE_INODE(inode);
 		DQUOT_DROP(inode);
 	}
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/inode.c	Tue Oct 29 09:55:08 2002
@@ -39,6 +39,18 @@
 static int ext2_update_inode(struct inode * inode, int do_sync);
 
 /*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int ext2_inode_is_fast_symlink(struct inode *inode)
+{
+	int ea_blocks = EXT2_I(inode)->i_file_acl ?
+		(inode->i_sb->s_blocksize >> 9) : 0;
+
+	return (S_ISLNK(inode->i_mode) &&
+		inode->i_blocks - ea_blocks == 0);
+}
+
+/*
  * Called at each iput()
  */
 void ext2_put_inode (struct inode * inode)
@@ -51,9 +63,7 @@
  */
 void ext2_delete_inode (struct inode * inode)
 {
-	if (is_bad_inode(inode) ||
-	    inode->i_ino == EXT2_ACL_IDX_INO ||
-	    inode->i_ino == EXT2_ACL_DATA_INO)
+	if (is_bad_inode(inode))
 		goto no_delete;
 	EXT2_I(inode)->i_dtime	= CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -843,6 +853,8 @@
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
+	if (ext2_inode_is_fast_symlink(inode))
+		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 
@@ -929,8 +941,7 @@
 	struct ext2_group_desc * gdp;
 
 	*p = NULL;
-	if ((ino != EXT2_ROOT_INO && ino != EXT2_ACL_IDX_INO &&
-	     ino != EXT2_ACL_DATA_INO && ino < EXT2_FIRST_INO(sb)) ||
+	if ((ino != EXT2_ROOT_INO && ino < EXT2_FIRST_INO(sb)) ||
 	    ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
 		goto Einval;
 
@@ -1026,9 +1037,7 @@
 	for (n = 0; n < EXT2_N_BLOCKS; n++)
 		ei->i_data[n] = raw_inode->i_block[n];
 
-	if (ino == EXT2_ACL_IDX_INO || ino == EXT2_ACL_DATA_INO)
-		/* Nothing to do */ ;
-	else if (S_ISREG(inode->i_mode)) {
+	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext2_file_inode_operations;
 		inode->i_fop = &ext2_file_operations;
 		inode->i_mapping->a_ops = &ext2_aops;
@@ -1037,15 +1046,17 @@
 		inode->i_fop = &ext2_dir_operations;
 		inode->i_mapping->a_ops = &ext2_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
+		if (ext2_inode_is_fast_symlink(inode))
 			inode->i_op = &ext2_fast_symlink_inode_operations;
 		else {
-			inode->i_op = &page_symlink_inode_operations;
+			inode->i_op = &ext2_symlink_inode_operations;
 			inode->i_mapping->a_ops = &ext2_aops;
 		}
-	} else 
+	} else {
+		inode->i_op = &ext2_special_inode_operations;
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(raw_inode->i_block[0]));
+	}
 	brelse (bh);
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -1082,12 +1093,6 @@
 	if (ei->i_state & EXT2_STATE_NEW)
 		memset(raw_inode, 0, EXT2_SB(sb)->s_inode_size);
 
-	if (ino == EXT2_ACL_IDX_INO || ino == EXT2_ACL_DATA_INO) {
-		ext2_error (sb, "ext2_write_inode", "bad inode number: %lu",
-			    (unsigned long) ino);
-		brelse(bh);
-		return -EIO;
-	}
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if (!(test_opt(sb, NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(uid));
diff -Nru a/fs/ext2/namei.c b/fs/ext2/namei.c
--- a/fs/ext2/namei.c	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/namei.c	Tue Oct 29 09:55:08 2002
@@ -29,8 +29,9 @@
  *        David S. Miller (davem@caip.rutgers.edu), 1995
  */
 
-#include "ext2.h"
 #include <linux/pagemap.h>
+#include "ext2.h"
+#include "xattr.h"
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
@@ -162,7 +163,7 @@
 
 	if (l > sizeof (EXT2_I(inode)->i_data)) {
 		/* slow symlink */
-		inode->i_op = &page_symlink_inode_operations;
+		inode->i_op = &ext2_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ext2_aops;
 		err = page_symlink(inode, symname, l);
 		if (err)
@@ -368,4 +369,15 @@
 	.rmdir		= ext2_rmdir,
 	.mknod		= ext2_mknod,
 	.rename		= ext2_rename,
+	.setxattr	= ext2_setxattr,
+	.getxattr	= ext2_getxattr,
+	.listxattr	= ext2_listxattr,
+	.removexattr	= ext2_removexattr,
+};
+
+struct inode_operations ext2_special_inode_operations = {
+	.setxattr	= ext2_setxattr,
+	.getxattr	= ext2_getxattr,
+	.listxattr	= ext2_listxattr,
+	.removexattr	= ext2_removexattr,
 };
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/super.c	Tue Oct 29 09:55:08 2002
@@ -19,7 +19,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include "ext2.h"
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
@@ -27,6 +26,8 @@
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
+#include "ext2.h"
+#include "xattr.h"
 
 
 static void ext2_sync_super(struct super_block *sb,
@@ -127,6 +128,7 @@
 	int i;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
+	ext2_xattr_put_super(sb);
 	if (!(sb->s_flags & MS_RDONLY)) {
 		struct ext2_super_block *es = sbi->s_es;
 
@@ -278,6 +280,13 @@
 			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
+#ifdef CONFIG_EXT2_FS_XATTR
+		if (!strcmp (this_char, "user_xattr"))
+			set_opt (sbi->s_mount_opt, XATTR_USER);
+		else if (!strcmp (this_char, "nouser_xattr"))
+			clear_opt (sbi->s_mount_opt, XATTR_USER);
+		else
+#endif
 		if (!strcmp (this_char, "bsddf"))
 			clear_opt (sbi->s_mount_opt, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
@@ -560,6 +569,8 @@
 		set_opt(sbi->s_mount_opt, GRPID);
 	if (def_mount_opts & EXT2_DEFM_UID16)
 		set_opt(sbi->s_mount_opt, NO_UID32);
+	if (def_mount_opts & EXT2_DEFM_XATTR_USER)
+		set_opt(sbi->s_mount_opt, XATTR_USER);
 	
 	if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
 		set_opt(sbi->s_mount_opt, ERRORS_PANIC);
@@ -917,7 +928,10 @@
 
 static int __init init_ext2_fs(void)
 {
-	int err = init_inodecache();
+	int err = init_ext2_xattr();
+	if (err)
+		return err;
+	err = init_inodecache();
 	if (err)
 		goto out1;
         err = register_filesystem(&ext2_fs_type);
@@ -927,6 +941,7 @@
 out:
 	destroy_inodecache();
 out1:
+	exit_ext2_xattr();
 	return err;
 }
 
@@ -934,6 +949,7 @@
 {
 	unregister_filesystem(&ext2_fs_type);
 	destroy_inodecache();
+	exit_ext2_xattr();
 }
 
 module_init(init_ext2_fs)
diff -Nru a/fs/ext2/symlink.c b/fs/ext2/symlink.c
--- a/fs/ext2/symlink.c	Tue Oct 29 09:55:08 2002
+++ b/fs/ext2/symlink.c	Tue Oct 29 09:55:08 2002
@@ -18,6 +18,7 @@
  */
 
 #include "ext2.h"
+#include "xattr.h"
 
 static int ext2_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
@@ -31,7 +32,20 @@
 	return vfs_follow_link(nd, (char *)ei->i_data);
 }
 
+struct inode_operations ext2_symlink_inode_operations = {
+	.readlink	= page_readlink,
+	.follow_link	= page_follow_link,
+	.setxattr	= ext2_setxattr,
+	.getxattr	= ext2_getxattr,
+	.listxattr	= ext2_listxattr,
+	.removexattr	= ext2_removexattr,
+};
+ 
 struct inode_operations ext2_fast_symlink_inode_operations = {
 	.readlink	= ext2_readlink,
 	.follow_link	= ext2_follow_link,
+	.setxattr	= ext2_setxattr,
+	.getxattr	= ext2_getxattr,
+	.listxattr	= ext2_listxattr,
+	.removexattr	= ext2_removexattr,
 };
diff -Nru a/fs/ext2/xattr.c b/fs/ext2/xattr.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext2/xattr.c	Tue Oct 29 09:55:08 2002
@@ -0,0 +1,1118 @@
+/*
+ * linux/fs/ext2/xattr.c
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ *
+ * Fix by Harrison Xing <harrison@mountainviewdata.com>.
+ * Extended attributes for symlinks and special files added per
+ *  suggestion of Luka Renko <luka.renko@hermes.si>.
+ */
+
+/*
+ * Extended attributes are stored on disk blocks allocated outside of
+ * any inode. The i_file_acl field is then made to point to this allocated
+ * block. If all extended attributes of an inode are identical, these
+ * inodes may share the same extended attribute block. Such situations
+ * are automatically detected by keeping a cache of recent attribute block
+ * numbers and hashes over the block's contents in memory.
+ *
+ *
+ * Extended attribute block layout:
+ *
+ *   +------------------+
+ *   | header           |
+ *   ¦ entry 1          | |
+ *   | entry 2          | | growing downwards
+ *   | entry 3          | v
+ *   | four null bytes  |
+ *   | . . .            |
+ *   | value 1          | ^
+ *   | value 3          | | growing upwards
+ *   | value 2          | |
+ *   +------------------+
+ *
+ * The block header is followed by multiple entry descriptors. These entry
+ * descriptors are variable in size, and alligned to EXT2_XATTR_PAD
+ * byte boundaries. The entry descriptors are sorted by attribute name,
+ * so that two extended attribute blocks can be compared efficiently.
+ *
+ * Attribute values are aligned to the end of the block, stored in
+ * no specific order. They are also padded to EXT2_XATTR_PAD byte
+ * boundaries. No additional gaps are left between them.
+ *
+ * Locking strategy
+ * ----------------
+ * The VFS already holds the BKL and the inode->i_sem semaphore when any of
+ * the xattr inode operations are called, so we are guaranteed that only one
+ * processes accesses extended attributes of an inode at any time.
+ *
+ * For writing we also grab the ext2_xattr_sem semaphore. This ensures that
+ * only a single process is modifying an extended attribute block, even
+ * if the block is shared among inodes.
+ */
+
+#include <linux/buffer_head.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/mbcache.h>
+#include <linux/quotaops.h>
+#include <asm/semaphore.h>
+#include "ext2.h"
+#include "xattr.h"
+
+/* These symbols may be needed by a module. */
+EXPORT_SYMBOL(ext2_xattr_register);
+EXPORT_SYMBOL(ext2_xattr_unregister);
+EXPORT_SYMBOL(ext2_xattr_get);
+EXPORT_SYMBOL(ext2_xattr_list);
+EXPORT_SYMBOL(ext2_xattr_set);
+
+#define HDR(bh) ((struct ext2_xattr_header *)((bh)->b_data))
+#define ENTRY(ptr) ((struct ext2_xattr_entry *)(ptr))
+#define FIRST_ENTRY(bh) ENTRY(HDR(bh)+1)
+#define IS_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
+
+#ifdef EXT2_XATTR_DEBUG
+# define ea_idebug(inode, f...) do { \
+		printk(KERN_DEBUG "inode %s:%ld: ", \
+			kdevname(inode->i_dev), inode->i_ino); \
+		printk(f); \
+		printk("\n"); \
+	} while (0)
+# define ea_bdebug(bh, f...) do { \
+		printk(KERN_DEBUG "block %s:%ld: ", \
+			kdevname(bh->b_dev), bh->b_blocknr); \
+		printk(f); \
+		printk("\n"); \
+	} while (0)
+#else
+# define ea_idebug(f...)
+# define ea_bdebug(f...)
+#endif
+
+static int ext2_xattr_set2(struct inode *, struct buffer_head *,
+			   struct ext2_xattr_header *);
+
+static int ext2_xattr_cache_insert(struct buffer_head *);
+static struct buffer_head *ext2_xattr_cache_find(struct inode *,
+						 struct ext2_xattr_header *);
+static void ext2_xattr_cache_remove(struct buffer_head *);
+static void ext2_xattr_rehash(struct ext2_xattr_header *,
+			      struct ext2_xattr_entry *);
+
+static struct mb_cache *ext2_xattr_cache;
+
+/*
+ * If a file system does not share extended attributes among inodes,
+ * we should not need the ext2_xattr_sem semaphore. However, the
+ * filesystem may still contain shared blocks, so we always take
+ * the lock.
+ */
+
+static DECLARE_MUTEX(ext2_xattr_sem);
+static struct ext2_xattr_handler *ext2_xattr_handlers[EXT2_XATTR_INDEX_MAX];
+static rwlock_t ext2_handler_lock = RW_LOCK_UNLOCKED;
+
+int
+ext2_xattr_register(int name_index, struct ext2_xattr_handler *handler)
+{
+	int error = -EINVAL;
+
+	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX) {
+		write_lock(&ext2_handler_lock);
+		if (!ext2_xattr_handlers[name_index-1]) {
+			ext2_xattr_handlers[name_index-1] = handler;
+			error = 0;
+		}
+		write_unlock(&ext2_handler_lock);
+	}
+	return error;
+}
+
+void
+ext2_xattr_unregister(int name_index, struct ext2_xattr_handler *handler)
+{
+	if (name_index > 0 || name_index <= EXT2_XATTR_INDEX_MAX) {
+		write_lock(&ext2_handler_lock);
+		ext2_xattr_handlers[name_index-1] = NULL;
+		write_unlock(&ext2_handler_lock);
+	}
+}
+
+static inline const char *
+strcmp_prefix(const char *a, const char *a_prefix)
+{
+	while (*a_prefix && *a == *a_prefix) {
+		a++;
+		a_prefix++;
+	}
+	return *a_prefix ? NULL : a;
+}
+
+/*
+ * Decode the extended attribute name, and translate it into
+ * the name_index and name suffix.
+ */
+static struct ext2_xattr_handler *
+ext2_xattr_resolve_name(const char **name)
+{
+	struct ext2_xattr_handler *handler = NULL;
+	int i;
+
+	if (!*name)
+		return NULL;
+	read_lock(&ext2_handler_lock);
+	for (i=0; i<EXT2_XATTR_INDEX_MAX; i++) {
+		if (ext2_xattr_handlers[i]) {
+			const char *n = strcmp_prefix(*name,
+				ext2_xattr_handlers[i]->prefix);
+			if (n) {
+				handler = ext2_xattr_handlers[i];
+				*name = n;
+				break;
+			}
+		}
+	}
+	read_unlock(&ext2_handler_lock);
+	return handler;
+}
+
+static inline struct ext2_xattr_handler *
+ext2_xattr_handler(int name_index)
+{
+	struct ext2_xattr_handler *handler = NULL;
+	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX) {
+		read_lock(&ext2_handler_lock);
+		handler = ext2_xattr_handlers[name_index-1];
+		read_unlock(&ext2_handler_lock);
+	}
+	return handler;
+}
+
+/*
+ * Inode operation getxattr()
+ *
+ * dentry->d_inode->i_sem down
+ * BKL held [before 2.5.x]
+ */
+ssize_t
+ext2_getxattr(struct dentry *dentry, const char *name,
+	      void *buffer, size_t size)
+{
+	struct ext2_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = ext2_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->get(inode, name, buffer, size);
+}
+
+/*
+ * Inode operation listxattr()
+ *
+ * dentry->d_inode->i_sem down
+ * BKL held [before 2.5.x]
+ */
+ssize_t
+ext2_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	return ext2_xattr_list(dentry->d_inode, buffer, size);
+}
+
+/*
+ * Inode operation setxattr()
+ *
+ * dentry->d_inode->i_sem down
+ * BKL held [before 2.5.x]
+ */
+int
+ext2_setxattr(struct dentry *dentry, const char *name,
+	      void *value, size_t size, int flags)
+{
+	struct ext2_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+	handler = ext2_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, value, size, flags);
+}
+
+/*
+ * Inode operation removexattr()
+ *
+ * dentry->d_inode->i_sem down
+ * BKL held [before 2.5.x]
+ */
+int
+ext2_removexattr(struct dentry *dentry, const char *name)
+{
+	struct ext2_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = ext2_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+}
+
+/*
+ * ext2_xattr_get()
+ *
+ * Copy an extended attribute into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext2_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	struct buffer_head *bh = NULL;
+	struct ext2_xattr_entry *entry;
+	unsigned int size;
+	char *end;
+	int name_len, error;
+
+	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
+		  name_index, name, buffer, (long)buffer_size);
+
+	if (name == NULL)
+		return -EINVAL;
+	if (!EXT2_I(inode)->i_file_acl)
+		return -ENODATA;
+	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
+	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
+	if (!bh)
+		return -EIO;
+	ea_bdebug(bh, "b_count=%d, refcount=%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+	end = bh->b_data + bh->b_size;
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
+			"inode %ld: bad block %d", inode->i_ino,
+			EXT2_I(inode)->i_file_acl);
+		error = -EIO;
+		goto cleanup;
+	}
+	/* find named attribute */
+	name_len = strlen(name);
+
+	error = -ERANGE;
+	if (name_len > 255)
+		goto cleanup;
+	entry = FIRST_ENTRY(bh);
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext2_xattr_entry *next =
+			EXT2_XATTR_NEXT(entry);
+		if ((char *)next >= end)
+			goto bad_block;
+		if (name_index == entry->e_name_index &&
+		    name_len == entry->e_name_len &&
+		    memcmp(name, entry->e_name, name_len) == 0)
+			goto found;
+		entry = next;
+	}
+	/* Check the remaining name entries */
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext2_xattr_entry *next =
+			EXT2_XATTR_NEXT(entry);
+		if ((char *)next >= end)
+			goto bad_block;
+		entry = next;
+	}
+	if (ext2_xattr_cache_insert(bh))
+		ea_idebug(inode, "cache insert failed");
+	error = -ENODATA;
+	goto cleanup;
+found:
+	/* check the buffer size */
+	if (entry->e_value_block != 0)
+		goto bad_block;
+	size = le32_to_cpu(entry->e_value_size);
+	if (size > inode->i_sb->s_blocksize ||
+	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
+		goto bad_block;
+
+	if (ext2_xattr_cache_insert(bh))
+		ea_idebug(inode, "cache insert failed");
+	if (buffer) {
+		error = -ERANGE;
+		if (size > buffer_size)
+			goto cleanup;
+		/* return value of attribute */
+		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
+			size);
+	}
+	error = size;
+
+cleanup:
+	brelse(bh);
+
+	return error;
+}
+
+/*
+ * ext2_xattr_list()
+ *
+ * Copy a list of attribute names into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext2_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	struct buffer_head *bh = NULL;
+	struct ext2_xattr_entry *entry;
+	unsigned int size = 0;
+	char *buf, *end;
+	int error;
+
+	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
+		  buffer, (long)buffer_size);
+
+	if (!EXT2_I(inode)->i_file_acl)
+		return 0;
+	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
+	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
+	if (!bh)
+		return -EIO;
+	ea_bdebug(bh, "b_count=%d, refcount=%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+	end = bh->b_data + bh->b_size;
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
+			"inode %ld: bad block %d", inode->i_ino,
+			EXT2_I(inode)->i_file_acl);
+		error = -EIO;
+		goto cleanup;
+	}
+	/* compute the size required for the list of attribute names */
+	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
+	     entry = EXT2_XATTR_NEXT(entry)) {
+		struct ext2_xattr_handler *handler;
+		struct ext2_xattr_entry *next =
+			EXT2_XATTR_NEXT(entry);
+		if ((char *)next >= end)
+			goto bad_block;
+
+		handler = ext2_xattr_handler(entry->e_name_index);
+		if (handler) {
+			size += handler->list(NULL, inode, entry->e_name,
+					      entry->e_name_len) + 1;
+		}
+	}
+
+	if (ext2_xattr_cache_insert(bh))
+		ea_idebug(inode, "cache insert failed");
+	if (!buffer) {
+		error = size;
+		goto cleanup;
+	} else {
+		error = -ERANGE;
+		if (size > buffer_size)
+			goto cleanup;
+	}
+
+	/* list the attribute names */
+	buf = buffer;
+	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
+	     entry = EXT2_XATTR_NEXT(entry)) {
+		struct ext2_xattr_handler *handler;
+		
+		handler = ext2_xattr_handler(entry->e_name_index);
+		if (handler) {
+			buf += handler->list(buf, inode, entry->e_name,
+					     entry->e_name_len);
+			*buf++ = '\0';
+		}
+	}
+	error = size;
+
+cleanup:
+	brelse(bh);
+
+	return error;
+}
+
+/*
+ * If the EXT2_FEATURE_COMPAT_EXT_ATTR feature of this file system is
+ * not set, set it.
+ */
+static void ext2_xattr_update_super_block(struct super_block *sb)
+{
+	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_EXT_ATTR))
+		return;
+
+	lock_super(sb);
+	EXT2_SB(sb)->s_es->s_feature_compat |=
+		cpu_to_le32(EXT2_FEATURE_COMPAT_EXT_ATTR);
+	sb->s_dirt = 1;
+	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
+	unlock_super(sb);
+}
+
+/*
+ * ext2_xattr_set()
+ *
+ * Create, replace or remove an extended attribute for this inode. Buffer
+ * is NULL to remove an existing extended attribute, and non-NULL to
+ * either replace an existing extended attribute, or create a new extended
+ * attribute. The flags XATTR_REPLACE and XATTR_CREATE
+ * specify that an extended attribute must exist and must not exist
+ * previous to the call, respectively.
+ *
+ * Returns 0, or a negative error number on failure.
+ */
+int
+ext2_xattr_set(struct inode *inode, int name_index, const char *name,
+	       const void *value, size_t value_len, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh = NULL;
+	struct ext2_xattr_header *header = NULL;
+	struct ext2_xattr_entry *here, *last;
+	unsigned int name_len;
+	int min_offs = sb->s_blocksize, not_found = 1, free, error;
+	char *end;
+	
+	/*
+	 * header -- Points either into bh, or to a temporarily
+	 *           allocated buffer.
+	 * here -- The named entry found, or the place for inserting, within
+	 *         the block pointed to by header.
+	 * last -- Points right after the last named entry within the block
+	 *         pointed to by header.
+	 * min_offs -- The offset of the first value (values are aligned
+	 *             towards the end of the block).
+	 * end -- Points right after the block pointed to by header.
+	 */
+	
+	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
+		  name_index, name, value, (long)value_len);
+
+	if (IS_RDONLY(inode))
+		return -EROFS;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		return -EPERM;
+	if (value == NULL)
+		value_len = 0;
+	if (name == NULL)
+		return -EINVAL;
+	name_len = strlen(name);
+	if (name_len > 255 || value_len > sb->s_blocksize)
+		return -ERANGE;
+	down(&ext2_xattr_sem);
+
+	if (EXT2_I(inode)->i_file_acl) {
+		/* The inode already has an extended attribute block. */
+		bh = sb_bread(sb, EXT2_I(inode)->i_file_acl);
+		error = -EIO;
+		if (!bh)
+			goto cleanup;
+		ea_bdebug(bh, "b_count=%d, refcount=%d",
+			atomic_read(&(bh->b_count)),
+			le32_to_cpu(HDR(bh)->h_refcount));
+		header = HDR(bh);
+		end = bh->b_data + bh->b_size;
+		if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
+		    header->h_blocks != cpu_to_le32(1)) {
+bad_block:		ext2_error(sb, "ext2_xattr_set",
+				"inode %ld: bad block %d", inode->i_ino, 
+				   EXT2_I(inode)->i_file_acl);
+			error = -EIO;
+			goto cleanup;
+		}
+		/* Find the named attribute. */
+		here = FIRST_ENTRY(bh);
+		while (!IS_LAST_ENTRY(here)) {
+			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(here);
+			if ((char *)next >= end)
+				goto bad_block;
+			if (!here->e_value_block && here->e_value_size) {
+				int offs = le16_to_cpu(here->e_value_offs);
+				if (offs < min_offs)
+					min_offs = offs;
+			}
+			not_found = name_index - here->e_name_index;
+			if (!not_found)
+				not_found = name_len - here->e_name_len;
+			if (!not_found)
+				not_found = memcmp(name, here->e_name,name_len);
+			if (not_found <= 0)
+				break;
+			here = next;
+		}
+		last = here;
+		/* We still need to compute min_offs and last. */
+		while (!IS_LAST_ENTRY(last)) {
+			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
+			if ((char *)next >= end)
+				goto bad_block;
+			if (!last->e_value_block && last->e_value_size) {
+				int offs = le16_to_cpu(last->e_value_offs);
+				if (offs < min_offs)
+					min_offs = offs;
+			}
+			last = next;
+		}
+
+		/* Check whether we have enough space left. */
+		free = min_offs - ((char*)last - (char*)header) - sizeof(__u32);
+	} else {
+		/* We will use a new extended attribute block. */
+		free = sb->s_blocksize -
+			sizeof(struct ext2_xattr_header) - sizeof(__u32);
+		here = last = NULL;  /* avoid gcc uninitialized warning. */
+	}
+
+	if (not_found) {
+		/* Request to remove a nonexistent attribute? */
+		error = -ENODATA;
+		if (flags & XATTR_REPLACE)
+			goto cleanup;
+		error = 0;
+		if (value == NULL)
+			goto cleanup;
+		else
+			free -= EXT2_XATTR_LEN(name_len);
+	} else {
+		/* Request to create an existing attribute? */
+		error = -EEXIST;
+		if (flags & XATTR_CREATE)
+			goto cleanup;
+		if (!here->e_value_block && here->e_value_size) {
+			unsigned int size = le32_to_cpu(here->e_value_size);
+
+			if (le16_to_cpu(here->e_value_offs) + size > 
+			    sb->s_blocksize || size > sb->s_blocksize)
+				goto bad_block;
+			free += EXT2_XATTR_SIZE(size);
+		}
+	}
+	free -= EXT2_XATTR_SIZE(value_len);
+	error = -ENOSPC;
+	if (free < 0)
+		goto cleanup;
+
+	/* Here we know that we can set the new attribute. */
+
+	if (header) {
+		if (header->h_refcount == cpu_to_le32(1)) {
+			ea_bdebug(bh, "modifying in-place");
+			ext2_xattr_cache_remove(bh);
+		} else {
+			int offset;
+
+			ea_bdebug(bh, "cloning");
+			header = kmalloc(bh->b_size, GFP_KERNEL);
+			error = -ENOMEM;
+			if (header == NULL)
+				goto cleanup;
+			memcpy(header, HDR(bh), bh->b_size);
+			header->h_refcount = cpu_to_le32(1);
+			offset = (char *)header - bh->b_data;
+			here = ENTRY((char *)here + offset);
+			last = ENTRY((char *)last + offset);
+		}
+	} else {
+		/* Allocate a buffer where we construct the new block. */
+		header = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		error = -ENOMEM;
+		if (header == NULL)
+			goto cleanup;
+		memset(header, 0, sb->s_blocksize);
+		end = (char *)header + sb->s_blocksize;
+		header->h_magic = cpu_to_le32(EXT2_XATTR_MAGIC);
+		header->h_blocks = header->h_refcount = cpu_to_le32(1);
+		last = here = ENTRY(header+1);
+	}
+
+	if (not_found) {
+		/* Insert the new name. */
+		int size = EXT2_XATTR_LEN(name_len);
+		int rest = (char *)last - (char *)here;
+		memmove((char *)here + size, here, rest);
+		memset(here, 0, size);
+		here->e_name_index = name_index;
+		here->e_name_len = name_len;
+		memcpy(here->e_name, name, name_len);
+	} else {
+		/* Remove the old value. */
+		if (!here->e_value_block && here->e_value_size) {
+			char *first_val = (char *)header + min_offs;
+			int offs = le16_to_cpu(here->e_value_offs);
+			char *val = (char *)header + offs;
+			size_t size = EXT2_XATTR_SIZE(
+				le32_to_cpu(here->e_value_size));
+			memmove(first_val + size, first_val, val - first_val);
+			memset(first_val, 0, size);
+			here->e_value_offs = 0;
+			min_offs += size;
+
+			/* Adjust all value offsets. */
+			last = ENTRY(header+1);
+			while (!IS_LAST_ENTRY(last)) {
+				int o = le16_to_cpu(last->e_value_offs);
+				if (!last->e_value_block && o < offs)
+					last->e_value_offs =
+						cpu_to_le16(o + size);
+				last = EXT2_XATTR_NEXT(last);
+			}
+		}
+		if (value == NULL) {
+			/* Remove this attribute. */
+			if (EXT2_XATTR_NEXT(ENTRY(header+1)) == last) {
+				/* This block is now empty. */
+				error = ext2_xattr_set2(inode, bh, NULL);
+				goto cleanup;
+			} else {
+				/* Remove the old name. */
+				int size = EXT2_XATTR_LEN(name_len);
+				last = ENTRY((char *)last - size);
+				memmove(here, (char*)here + size,
+					(char*)last - (char*)here);
+				memset(last, 0, size);
+			}
+		}
+	}
+
+	if (value != NULL) {
+		/* Insert the new value. */
+		here->e_value_size = cpu_to_le32(value_len);
+		if (value_len) {
+			size_t size = EXT2_XATTR_SIZE(value_len);
+			char *val = (char *)header + min_offs - size;
+			here->e_value_offs =
+				cpu_to_le16((char *)val - (char *)header);
+			memset(val + size - EXT2_XATTR_PAD, 0,
+			       EXT2_XATTR_PAD); /* Clear the pad bytes. */
+			memcpy(val, value, value_len);
+		}
+	}
+	ext2_xattr_rehash(header, here);
+
+	error = ext2_xattr_set2(inode, bh, header);
+
+cleanup:
+	brelse(bh);
+	if (!(bh && header == HDR(bh)))
+		kfree(header);
+	up(&ext2_xattr_sem);
+
+	return error;
+}
+
+/*
+ * Second half of ext2_xattr_set(): Update the file system.
+ */
+static int
+ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
+		struct ext2_xattr_header *header)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *new_bh = NULL;
+	int error;
+
+	if (header) {
+		new_bh = ext2_xattr_cache_find(inode, header);
+		if (new_bh) {
+			/*
+			 * We found an identical block in the cache.
+			 * The old block will be released after updating
+			 * the inode.
+			 */
+			ea_bdebug(old_bh, "reusing block %ld",
+				new_bh->b_blocknr);
+			
+			error = -EDQUOT;
+			if (DQUOT_ALLOC_BLOCK(inode, 1))
+				goto cleanup;
+			
+			HDR(new_bh)->h_refcount = cpu_to_le32(
+				le32_to_cpu(HDR(new_bh)->h_refcount) + 1);
+			ea_bdebug(new_bh, "refcount now=%d",
+				le32_to_cpu(HDR(new_bh)->h_refcount));
+		} else if (old_bh && header == HDR(old_bh)) {
+			/* Keep this block. */
+			new_bh = old_bh;
+			ext2_xattr_cache_insert(new_bh);
+		} else {
+			/* We need to allocate a new block */
+			int goal = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
+				EXT2_I(inode)->i_block_group * EXT2_BLOCKS_PER_GROUP(sb);
+			int block = ext2_new_block(inode, goal, 0, 0, &error);
+			if (error)
+				goto cleanup;
+			ea_idebug(inode, "creating block %d", block);
+
+			new_bh = sb_getblk(sb, block);
+			if (!new_bh) {
+				ext2_free_blocks(inode, block, 1);
+				error = -EIO;
+				goto cleanup;
+			}
+			lock_buffer(new_bh);
+			memcpy(new_bh->b_data, header, new_bh->b_size);
+			set_buffer_uptodate(new_bh);
+			unlock_buffer(new_bh);
+			ext2_xattr_cache_insert(new_bh);
+			
+			ext2_xattr_update_super_block(sb);
+		}
+		mark_buffer_dirty(new_bh);
+		if (IS_SYNC(inode)) {
+			ll_rw_block(WRITE, 1, &new_bh);
+			wait_on_buffer(new_bh); 
+			error = -EIO;
+			if (buffer_req(new_bh) && !buffer_uptodate(new_bh))
+				goto cleanup;
+		}
+	}
+
+	/* Update the inode. */
+	EXT2_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
+	inode->i_ctime = CURRENT_TIME;
+	if (IS_SYNC(inode)) {
+		error = ext2_sync_inode (inode);
+		if (error)
+			goto cleanup;
+	} else
+		mark_inode_dirty(inode);
+
+	error = 0;
+	if (old_bh && old_bh != new_bh) {
+		/*
+		 * If there was an old block, and we are not still using it,
+		 * we now release the old block.
+		*/
+		unsigned int refcount = le32_to_cpu(HDR(old_bh)->h_refcount);
+
+		if (refcount == 1) {
+			/* Free the old block. */
+			ea_bdebug(old_bh, "freeing");
+			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
+			/* We let our caller release old_bh, so we
+			 * need to duplicate the buffer before. */
+			get_bh(old_bh);
+			bforget(old_bh);
+		} else {
+			/* Decrement the refcount only. */
+			refcount--;
+			HDR(old_bh)->h_refcount = cpu_to_le32(refcount);
+			DQUOT_FREE_BLOCK(inode, 1);
+			mark_buffer_dirty(old_bh);
+			ea_bdebug(old_bh, "refcount now=%d", refcount);
+		}
+	}
+
+cleanup:
+	if (old_bh != new_bh)
+		brelse(new_bh);
+
+	return error;
+}
+
+/*
+ * ext2_xattr_delete_inode()
+ *
+ * Free extended attribute resources associated with this inode. This
+ * is called immediately before an inode is freed.
+ */
+void
+ext2_xattr_delete_inode(struct inode *inode)
+{
+	struct buffer_head *bh;
+
+	if (!EXT2_I(inode)->i_file_acl)
+		return;
+	down(&ext2_xattr_sem);
+
+	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
+	if (!bh) {
+		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
+			"inode %ld: block %d read error", inode->i_ino,
+			EXT2_I(inode)->i_file_acl);
+		goto cleanup;
+	}
+	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
+			"inode %ld: bad block %d", inode->i_ino,
+			EXT2_I(inode)->i_file_acl);
+		goto cleanup;
+	}
+	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
+	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
+		ext2_xattr_cache_remove(bh);
+		ext2_free_blocks(inode, EXT2_I(inode)->i_file_acl, 1);
+		bforget(bh);
+		bh = NULL;
+	} else {
+		HDR(bh)->h_refcount = cpu_to_le32(
+			le32_to_cpu(HDR(bh)->h_refcount) - 1);
+		mark_buffer_dirty(bh);
+		if (IS_SYNC(inode)) {
+			ll_rw_block(WRITE, 1, &bh);
+			wait_on_buffer(bh);
+		}
+		DQUOT_FREE_BLOCK(inode, 1);
+	}
+	EXT2_I(inode)->i_file_acl = 0;
+
+cleanup:
+	brelse(bh);
+	up(&ext2_xattr_sem);
+}
+
+/*
+ * ext2_xattr_put_super()
+ *
+ * This is called when a file system is unmounted.
+ */
+void
+ext2_xattr_put_super(struct super_block *sb)
+{
+	mb_cache_shrink(ext2_xattr_cache, sb->s_bdev);
+}
+
+
+/*
+ * ext2_xattr_cache_insert()
+ *
+ * Create a new entry in the extended attribute cache, and insert
+ * it unless such an entry is already in the cache.
+ *
+ * Returns 0, or a negative error number on failure.
+ */
+static int
+ext2_xattr_cache_insert(struct buffer_head *bh)
+{
+	__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
+	struct mb_cache_entry *ce;
+	int error;
+
+	ce = mb_cache_entry_alloc(ext2_xattr_cache);
+	if (!ce)
+		return -ENOMEM;
+	error = mb_cache_entry_insert(ce, bh->b_bdev, bh->b_blocknr, &hash);
+	if (error) {
+		mb_cache_entry_free(ce);
+		if (error == -EBUSY) {
+			ea_bdebug(bh, "already in cache (%d cache entries)",
+				atomic_read(&ext2_xattr_cache->c_entry_count));
+			error = 0;
+		}
+	} else {
+		ea_bdebug(bh, "inserting [%x] (%d cache entries)", (int)hash,
+			  atomic_read(&ext2_xattr_cache->c_entry_count));
+		mb_cache_entry_release(ce);
+	}
+	return error;
+}
+
+/*
+ * ext2_xattr_cmp()
+ *
+ * Compare two extended attribute blocks for equality.
+ *
+ * Returns 0 if the blocks are equal, 1 if they differ, and
+ * a negative error number on errors.
+ */
+static int
+ext2_xattr_cmp(struct ext2_xattr_header *header1,
+	       struct ext2_xattr_header *header2)
+{
+	struct ext2_xattr_entry *entry1, *entry2;
+
+	entry1 = ENTRY(header1+1);
+	entry2 = ENTRY(header2+1);
+	while (!IS_LAST_ENTRY(entry1)) {
+		if (IS_LAST_ENTRY(entry2))
+			return 1;
+		if (entry1->e_hash != entry2->e_hash ||
+		    entry1->e_name_len != entry2->e_name_len ||
+		    entry1->e_value_size != entry2->e_value_size ||
+		    memcmp(entry1->e_name, entry2->e_name, entry1->e_name_len))
+			return 1;
+		if (entry1->e_value_block != 0 || entry2->e_value_block != 0)
+			return -EIO;
+		if (memcmp((char *)header1 + le16_to_cpu(entry1->e_value_offs),
+			   (char *)header2 + le16_to_cpu(entry2->e_value_offs),
+			   le32_to_cpu(entry1->e_value_size)))
+			return 1;
+
+		entry1 = EXT2_XATTR_NEXT(entry1);
+		entry2 = EXT2_XATTR_NEXT(entry2);
+	}
+	if (!IS_LAST_ENTRY(entry2))
+		return 1;
+	return 0;
+}
+
+/*
+ * ext2_xattr_cache_find()
+ *
+ * Find an identical extended attribute block.
+ *
+ * Returns a pointer to the block found, or NULL if such a block was
+ * not found or an error occurred.
+ */
+static struct buffer_head *
+ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
+{
+	__u32 hash = le32_to_cpu(header->h_hash);
+	struct mb_cache_entry *ce;
+
+	if (!header->h_hash)
+		return NULL;  /* never share */
+	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
+	ce = mb_cache_entry_find_first(ext2_xattr_cache, 0, inode->i_bdev, hash);
+	while (ce) {
+		struct buffer_head *bh = sb_bread(inode->i_sb, ce->e_block);
+
+		if (!bh) {
+			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
+				"inode %ld: block %ld read error",
+				inode->i_ino, (unsigned long) ce->e_block);
+		} else if (le32_to_cpu(HDR(bh)->h_refcount) >
+			   EXT2_XATTR_REFCOUNT_MAX) {
+			ea_idebug(inode, "block %ld refcount %d>%d",
+				  (unsigned long) ce->e_block,
+				  le32_to_cpu(HDR(bh)->h_refcount),
+				  EXT2_XATTR_REFCOUNT_MAX);
+		} else if (!ext2_xattr_cmp(header, HDR(bh))) {
+			ea_bdebug(bh, "b_count=%d",atomic_read(&(bh->b_count)));
+			mb_cache_entry_release(ce);
+			return bh;
+		}
+		brelse(bh);
+		ce = mb_cache_entry_find_next(ce, 0, inode->i_bdev, hash);
+	}
+	return NULL;
+}
+
+/*
+ * ext2_xattr_cache_remove()
+ *
+ * Remove the cache entry of a block from the cache. Called when a
+ * block becomes invalid.
+ */
+static void
+ext2_xattr_cache_remove(struct buffer_head *bh)
+{
+	struct mb_cache_entry *ce;
+
+	ce = mb_cache_entry_get(ext2_xattr_cache, bh->b_bdev, bh->b_blocknr);
+	if (ce) {
+		ea_bdebug(bh, "removing (%d cache entries remaining)",
+			  atomic_read(&ext2_xattr_cache->c_entry_count)-1);
+		mb_cache_entry_free(ce);
+	} else 
+		ea_bdebug(bh, "no cache entry");
+}
+
+#define NAME_HASH_SHIFT 5
+#define VALUE_HASH_SHIFT 16
+
+/*
+ * ext2_xattr_hash_entry()
+ *
+ * Compute the hash of an extended attribute.
+ */
+static inline void ext2_xattr_hash_entry(struct ext2_xattr_header *header,
+					 struct ext2_xattr_entry *entry)
+{
+	__u32 hash = 0;
+	char *name = entry->e_name;
+	int n;
+
+	for (n=0; n < entry->e_name_len; n++) {
+		hash = (hash << NAME_HASH_SHIFT) ^
+		       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
+		       *name++;
+	}
+
+	if (entry->e_value_block == 0 && entry->e_value_size != 0) {
+		__u32 *value = (__u32 *)((char *)header +
+			le16_to_cpu(entry->e_value_offs));
+		for (n = (le32_to_cpu(entry->e_value_size) +
+		     EXT2_XATTR_ROUND) >> EXT2_XATTR_PAD_BITS; n; n--) {
+			hash = (hash << VALUE_HASH_SHIFT) ^
+			       (hash >> (8*sizeof(hash) - VALUE_HASH_SHIFT)) ^
+			       le32_to_cpu(*value++);
+		}
+	}
+	entry->e_hash = cpu_to_le32(hash);
+}
+
+#undef NAME_HASH_SHIFT
+#undef VALUE_HASH_SHIFT
+
+#define BLOCK_HASH_SHIFT 16
+
+/*
+ * ext2_xattr_rehash()
+ *
+ * Re-compute the extended attribute hash value after an entry has changed.
+ */
+static void ext2_xattr_rehash(struct ext2_xattr_header *header,
+			      struct ext2_xattr_entry *entry)
+{
+	struct ext2_xattr_entry *here;
+	__u32 hash = 0;
+	
+	ext2_xattr_hash_entry(header, entry);
+	here = ENTRY(header+1);
+	while (!IS_LAST_ENTRY(here)) {
+		if (!here->e_hash) {
+			/* Block is not shared if an entry's hash value == 0 */
+			hash = 0;
+			break;
+		}
+		hash = (hash << BLOCK_HASH_SHIFT) ^
+		       (hash >> (8*sizeof(hash) - BLOCK_HASH_SHIFT)) ^
+		       le32_to_cpu(here->e_hash);
+		here = EXT2_XATTR_NEXT(here);
+	}
+	header->h_hash = cpu_to_le32(hash);
+}
+
+#undef BLOCK_HASH_SHIFT
+
+int __init
+init_ext2_xattr(void)
+{
+	int	err;
+	
+	err = ext2_xattr_register(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
+	if (err)
+		return err;
+	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
+		sizeof(struct mb_cache_entry) +
+		sizeof(struct mb_cache_entry_index), 1, 6);
+	if (!ext2_xattr_cache) {
+		ext2_xattr_unregister(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void
+exit_ext2_xattr(void)
+{
+	mb_cache_destroy(ext2_xattr_cache);
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER, &ext2_xattr_user_handler);
+}
diff -Nru a/fs/ext2/xattr.h b/fs/ext2/xattr.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext2/xattr.h	Tue Oct 29 09:55:08 2002
@@ -0,0 +1,135 @@
+/*
+  File: linux/ext2_xattr.h
+
+  On-disk format of extended attributes for the ext2 filesystem.
+
+  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/xattr.h>
+
+/* Magic value in attribute blocks */
+#define EXT2_XATTR_MAGIC		0xEA020000
+
+/* Maximum number of references to one attribute block */
+#define EXT2_XATTR_REFCOUNT_MAX		1024
+
+/* Name indexes */
+#define EXT2_XATTR_INDEX_MAX			10
+#define EXT2_XATTR_INDEX_USER			1
+#define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
+#define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+
+struct ext2_xattr_header {
+	__u32	h_magic;	/* magic number for identification */
+	__u32	h_refcount;	/* reference count */
+	__u32	h_blocks;	/* number of disk blocks used */
+	__u32	h_hash;		/* hash value of all attributes */
+	__u32	h_reserved[4];	/* zero right now */
+};
+
+struct ext2_xattr_entry {
+	__u8	e_name_len;	/* length of name */
+	__u8	e_name_index;	/* attribute name index */
+	__u16	e_value_offs;	/* offset in disk block of value */
+	__u32	e_value_block;	/* disk block attribute is stored on (n/i) */
+	__u32	e_value_size;	/* size of attribute value */
+	__u32	e_hash;		/* hash value of name and value */
+	char	e_name[0];	/* attribute name */
+};
+
+#define EXT2_XATTR_PAD_BITS		2
+#define EXT2_XATTR_PAD		(1<<EXT2_XATTR_PAD_BITS)
+#define EXT2_XATTR_ROUND		(EXT2_XATTR_PAD-1)
+#define EXT2_XATTR_LEN(name_len) \
+	(((name_len) + EXT2_XATTR_ROUND + \
+	sizeof(struct ext2_xattr_entry)) & ~EXT2_XATTR_ROUND)
+#define EXT2_XATTR_NEXT(entry) \
+	( (struct ext2_xattr_entry *)( \
+	  (char *)(entry) + EXT2_XATTR_LEN((entry)->e_name_len)) )
+#define EXT2_XATTR_SIZE(size) \
+	(((size) + EXT2_XATTR_ROUND) & ~EXT2_XATTR_ROUND)
+
+# ifdef CONFIG_EXT2_FS_XATTR
+
+struct ext2_xattr_handler {
+	char *prefix;
+	size_t (*list)(char *list, struct inode *inode, const char *name,
+		       int name_len);
+	int (*get)(struct inode *inode, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct inode *inode, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+extern int ext2_xattr_register(int, struct ext2_xattr_handler *);
+extern void ext2_xattr_unregister(int, struct ext2_xattr_handler *);
+
+extern int ext2_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t ext2_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
+extern int ext2_removexattr(struct dentry *, const char *);
+
+extern int ext2_xattr_get(struct inode *, int, const char *, void *, size_t);
+extern int ext2_xattr_list(struct inode *, char *, size_t);
+extern int ext2_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
+
+extern void ext2_xattr_delete_inode(struct inode *);
+extern void ext2_xattr_put_super(struct super_block *);
+
+extern int init_ext2_xattr(void);
+extern void exit_ext2_xattr(void);
+
+# else  /* CONFIG_EXT2_FS_XATTR */
+#  define ext2_setxattr		NULL
+#  define ext2_getxattr		NULL
+#  define ext2_listxattr	NULL
+#  define ext2_removexattr	NULL
+
+static inline int
+ext2_xattr_get(struct inode *inode, int name_index,
+	       const char *name, void *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+ext2_xattr_list(struct inode *inode, char *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+ext2_xattr_set(struct inode *inode, int name_index, const char *name,
+	       const void *value, size_t size, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+ext2_xattr_delete_inode(struct inode *inode)
+{
+}
+
+static inline void
+ext2_xattr_put_super(struct super_block *sb)
+{
+}
+
+static inline int
+init_ext2_xattr(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext2_xattr(void)
+{
+}
+
+# endif  /* CONFIG_EXT2_FS_XATTR */
+
+extern struct ext2_xattr_handler ext2_xattr_user_handler;
+
diff -Nru a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext2/xattr_user.c	Tue Oct 29 09:55:08 2002
@@ -0,0 +1,102 @@
+/*
+ * linux/fs/ext2/xattr_user.c
+ * Handler for extended user attributes.
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include "ext2.h"
+#include "xattr.h"
+
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+# include "acl.h"
+#endif
+
+#define XATTR_USER_PREFIX "user."
+
+static size_t
+ext2_xattr_user_list(char *list, struct inode *inode,
+		     const char *name, int name_len)
+{
+	const int prefix_len = sizeof(XATTR_USER_PREFIX)-1;
+
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return 0;
+
+	if (list) {
+		memcpy(list, XATTR_USER_PREFIX, prefix_len);
+		memcpy(list+prefix_len, name, name_len);
+	}
+	return prefix_len + name_len;
+}
+
+static int
+ext2_xattr_user_get(struct inode *inode, const char *name,
+		    void *buffer, size_t size)
+{
+	int error;
+
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return -EOPNOTSUPP;
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	error = ext2_permission_locked(inode, MAY_READ);
+#else
+	error = permission(inode, MAY_READ);
+#endif
+	if (error)
+		return error;
+
+	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_USER, name,
+			      buffer, size);
+}
+
+static int
+ext2_xattr_user_set(struct inode *inode, const char *name,
+		    const void *value, size_t size, int flags)
+{
+	int error;
+
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return -EOPNOTSUPP;
+	if ( !S_ISREG(inode->i_mode) &&
+	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
+		return -EPERM;
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	error = ext2_permission_locked(inode, MAY_WRITE);
+#else
+	error = permission(inode, MAY_WRITE);
+#endif
+	if (error)
+		return error;
+  
+	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_USER, name,
+			      value, size, flags);
+}
+
+struct ext2_xattr_handler ext2_xattr_user_handler = {
+	prefix:	XATTR_USER_PREFIX,
+	list:	ext2_xattr_user_list,
+	get:	ext2_xattr_user_get,
+	set:	ext2_xattr_user_set,
+};
+
+int __init
+init_ext2_xattr_user(void)
+{
+	return ext2_xattr_register(EXT2_XATTR_INDEX_USER,
+				   &ext2_xattr_user_handler);
+}
+
+void
+exit_ext2_xattr_user(void)
+{
+	ext2_xattr_unregister(EXT2_XATTR_INDEX_USER,
+			      &ext2_xattr_user_handler);
+}
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Tue Oct 29 09:55:08 2002
+++ b/include/linux/ext2_fs.h	Tue Oct 29 09:55:08 2002
@@ -58,8 +58,6 @@
  */
 #define	EXT2_BAD_INO		 1	/* Bad blocks inode */
 #define EXT2_ROOT_INO		 2	/* Root inode */
-#define EXT2_ACL_IDX_INO	 3	/* ACL inode */
-#define EXT2_ACL_DATA_INO	 4	/* ACL inode */
 #define EXT2_BOOT_LOADER_INO	 5	/* Boot loader inode */
 #define EXT2_UNDEL_DIR_INO	 6	/* Undelete directory inode */
 
@@ -99,7 +97,6 @@
 #else
 # define EXT2_BLOCK_SIZE(s)		(EXT2_MIN_BLOCK_SIZE << (s)->s_log_block_size)
 #endif
-#define EXT2_ACLE_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (struct ext2_acl_entry))
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE_BITS(s)	((s)->s_blocksize_bits)
@@ -134,28 +131,6 @@
 #endif
 
 /*
- * ACL structures
- */
-struct ext2_acl_header	/* Header of Access Control Lists */
-{
-	__u32	aclh_size;
-	__u32	aclh_file_count;
-	__u32	aclh_acle_count;
-	__u32	aclh_first_acle;
-};
-
-struct ext2_acl_entry	/* Access Control List Entry */
-{
-	__u32	acle_size;
-	__u16	acle_perms;	/* Access permissions */
-	__u16	acle_type;	/* Type of entry */
-	__u16	acle_tag;	/* User or group identity */
-	__u16	acle_pad1;
-	__u32	acle_next;	/* Pointer on next entry for the */
-					/* same inode or on next free entry */
-};
-
-/*
  * Structure of a blocks group descriptor
  */
 struct ext2_group_desc
@@ -332,6 +307,7 @@
 #define EXT2_MOUNT_ERRORS_PANIC		0x0040	/* Panic on errors */
 #define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
 #define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
+#define EXT2_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
@@ -489,7 +465,7 @@
 #define EXT2_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT2_FEATURE_INCOMPAT_ANY		0xffffffff
 
-#define EXT2_FEATURE_COMPAT_SUPP	0
+#define EXT2_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT2_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT2_FEATURE_INCOMPAT_META_BG)
 #define EXT2_FEATURE_RO_COMPAT_SUPP	(EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER| \

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSJHSEn>; Tue, 8 Oct 2002 14:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJHSEm>; Tue, 8 Oct 2002 14:04:42 -0400
Received: from thunk.org ([140.239.227.29]:17347 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261340AbSJHSCk>;
	Tue, 8 Oct 2002 14:02:40 -0400
To: linux-kernel@vger.kernel.org
cc: ext2-devel@lists.sourceforge.net
Subject: [RFC] [PATCH 3/4] Add extended attributes to ext2/3
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17yymK-00021n-00@think.thunk.org>
Date: Tue, 08 Oct 2002 14:08:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the third of four patches which add extended attribute support
to the ext2 and ext3 filesystems.  Please comment and bleed.

This patch adds extended attribute support to the ext3 filesystem.  This
uses the generic extended attribute patch which was developed by Andreas
Gruenbacher and the XFS team.  As a result, the user space utilities
which work for XFS will also work with these patches.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
#
# fs/Config.help             |   24 
# fs/Config.in               |    5 
# fs/ext3/Makefile           |    4 
# fs/ext3/file.c             |    5 
# fs/ext3/ialloc.c           |    2 
# fs/ext3/inode.c            |   35 -
# fs/ext3/namei.c            |   22 
# fs/ext3/super.c            |   30 +
# fs/ext3/symlink.c          |   16 
# fs/ext3/xattr.c            | 1233 +++++++++++++++++++++++++++++++++++++++++++++
# fs/ext3/xattr_user.c       |  113 ++++
# include/linux/ext3_fs.h    |   31 -
# include/linux/ext3_jbd.h   |    8 
# include/linux/ext3_xattr.h |  157 +++++
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/05	tytso@think.thunk.org	1.667
# Port of 0.8.50 xattr-ext3 to 2.5.
# 
# Enable EA's by default.
# --------------------------------------------
#
diff -Nru a/fs/Config.help b/fs/Config.help
--- a/fs/Config.help	Tue Oct  8 13:52:30 2002
+++ b/fs/Config.help	Tue Oct  8 13:52:30 2002
@@ -154,6 +154,30 @@
   of your root partition (the one containing the directory /) cannot
   be compiled as a module, and so this may be dangerous.
 
+Ext3 extended attributes
+CONFIG_EXT3_FS_XATTR
+  Extended attributes are name:value pairs associated with inodes by
+  the kernel or by users (see the attr(5) manual page, or visit
+  <http://acl.bestbits.at/> for details).
+
+  If unsure, say N.
+
+Ext3 extended attribute block sharing
+CONFIG_EXT3_FS_XATTR_SHARING
+  This options enables code for sharing identical extended attribute
+  blocks among multiple inodes.
+
+  Usually, say Y.
+
+Ext3 extended user attributes
+CONFIG_EXT3_FS_XATTR_USER
+  This option enables extended user attributes on ext3. Processes can
+  associate extended user attributes with inodes to store additional
+  information such as the character encoding of files, etc. (see the
+  attr(5) manual page, or visit <http://acl.bestbits.at/> for details).
+
+  If unsure, say N.
+
 CONFIG_JBD
   This is a generic journaling layer for block devices.  It is
   currently used by the ext3 file system, but it could also be used to
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Oct  8 13:52:30 2002
+++ b/fs/Config.in	Tue Oct  8 13:52:30 2002
@@ -27,6 +27,11 @@
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
 
 tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
+if [ "$CONFIG_EXT3_FS" != "n" ] ; then
+  define_tristate CONFIG_EXT3_FS_XATTR $CONFIG_EXT3_FS
+  define_bool CONFIG_EXT3_FS_XATTR_SHARING y
+  define_bool CONFIG_EXT3_FS_XATTR_USER y
+fi
 # CONFIG_JBD could be its own option (even modular), but until there are
 # other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
diff -Nru a/fs/ext3/Makefile b/fs/ext3/Makefile
--- a/fs/ext3/Makefile	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/Makefile	Tue Oct  8 13:52:30 2002
@@ -7,4 +7,8 @@
 ext3-objs    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 		ioctl.o namei.o super.o symlink.o
 
+export-objs += xattr.o
+obj-$(CONFIG_EXT3_FS_XATTR) += xattr.o
+obj-$(CONFIG_EXT3_FS_XATTR_USER) += xattr_user.o
+
 include $(TOPDIR)/Rules.make
diff -Nru a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/file.c	Tue Oct  8 13:52:31 2002
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/ext3_xattr.h>
 #include <linux/ext3_jbd.h>
 #include <linux/smp_lock.h>
 
@@ -92,5 +93,9 @@
 struct inode_operations ext3_file_inode_operations = {
 	.truncate	= ext3_truncate,
 	.setattr	= ext3_setattr,
+	.setxattr	= ext3_setxattr,
+	.getxattr	= ext3_getxattr,
+	.listxattr	= ext3_listxattr,
+	.removexattr	= ext3_removexattr,
 };
 
diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/ialloc.c	Tue Oct  8 13:52:30 2002
@@ -17,6 +17,7 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
+#include <linux/ext3_xattr.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
@@ -118,6 +119,7 @@
 	 * as writing the quota to disk may need the lock as well.
 	 */
 	DQUOT_INIT(inode);
+	ext3_xattr_delete_inode(handle, inode);
 	DQUOT_FREE_INODE(inode);
 	DQUOT_DROP(inode);
 
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/inode.c	Tue Oct  8 13:52:30 2002
@@ -42,6 +42,18 @@
  */
 #undef SEARCH_FROM_ZERO
 
+/*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int ext3_inode_is_fast_symlink(struct inode *inode)
+{
+	int ea_blocks = EXT3_I(inode)->i_file_acl ?
+		(inode->i_sb->s_blocksize >> 9) : 0;
+
+	return (S_ISLNK(inode->i_mode) &&
+		inode->i_blocks - ea_blocks == 0);
+}
+
 /* The ext3 forget function must perform a revoke if we are freeing data
  * which has been journaled.  Metadata (eg. indirect blocks) must be
  * revoked in all cases. 
@@ -51,7 +63,7 @@
  * still needs to be revoked.
  */
 
-static int ext3_forget(handle_t *handle, int is_metadata,
+int ext3_forget(handle_t *handle, int is_metadata,
 		       struct inode *inode, struct buffer_head *bh,
 		       int blocknr)
 {
@@ -167,9 +179,7 @@
 {
 	handle_t *handle;
 	
-	if (is_bad_inode(inode) ||
-	    inode->i_ino == EXT3_ACL_IDX_INO ||
-	    inode->i_ino == EXT3_ACL_DATA_INO)
+	if (is_bad_inode(inode))
 		goto no_delete;
 
 	lock_kernel();
@@ -1985,6 +1995,8 @@
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
+	if (ext3_inode_is_fast_symlink(inode))
+		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 
@@ -2136,8 +2148,6 @@
 	struct ext3_group_desc * gdp;
 		
 	if ((inode->i_ino != EXT3_ROOT_INO &&
-		inode->i_ino != EXT3_ACL_IDX_INO &&
-		inode->i_ino != EXT3_ACL_DATA_INO &&
 		inode->i_ino != EXT3_JOURNAL_INO &&
 		inode->i_ino < EXT3_FIRST_INO(inode->i_sb)) ||
 		inode->i_ino > le32_to_cpu(
@@ -2269,10 +2279,7 @@
 
 	brelse (iloc.bh);
 
-	if (inode->i_ino == EXT3_ACL_IDX_INO ||
-	    inode->i_ino == EXT3_ACL_DATA_INO)
-		/* Nothing to do */ ;
-	else if (S_ISREG(inode->i_mode)) {
+	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
 		if (ext3_should_writeback_data(inode))
@@ -2283,18 +2290,20 @@
 		inode->i_op = &ext3_dir_inode_operations;
 		inode->i_fop = &ext3_dir_operations;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks)
+		if (ext3_inode_is_fast_symlink(inode))
 			inode->i_op = &ext3_fast_symlink_inode_operations;
 		else {
-			inode->i_op = &page_symlink_inode_operations;
+			inode->i_op = &ext3_symlink_inode_operations;
 			if (ext3_should_writeback_data(inode))
 				inode->i_mapping->a_ops = &ext3_writeback_aops;
 			else
 				inode->i_mapping->a_ops = &ext3_aops;
 		}
-	} else 
+	} else {
+		inode->i_op = &ext3_special_inode_operations;
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(iloc.raw_inode->i_block[0]));
+	}
 	if (ei->i_flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (ei->i_flags & EXT3_APPEND_FL)
diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/namei.c	Tue Oct  8 13:52:30 2002
@@ -23,6 +23,7 @@
 #include <linux/time.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
+#include <linux/ext3_xattr.h>
 #include <linux/fcntl.h>
 #include <linux/stat.h>
 #include <linux/string.h>
@@ -572,7 +573,7 @@
 	if (IS_DIRSYNC(dir))
 		handle->h_sync = 1;
 
-	inode = ext3_new_inode (handle, dir, S_IFDIR);
+	inode = ext3_new_inode (handle, dir, S_IFDIR | mode);
 	err = PTR_ERR(inode);
 	if (IS_ERR(inode))
 		goto out_stop;
@@ -580,7 +581,6 @@
 	inode->i_op = &ext3_dir_inode_operations;
 	inode->i_fop = &ext3_dir_operations;
 	inode->i_size = EXT3_I(inode)->i_disksize = inode->i_sb->s_blocksize;
-	inode->i_blocks = 0;	
 	dir_block = ext3_bread (handle, inode, 0, 1, &err);
 	if (!dir_block) {
 		inode->i_nlink--; /* is this nlink == 0? */
@@ -607,9 +607,6 @@
 	BUFFER_TRACE(dir_block, "call ext3_journal_dirty_metadata");
 	ext3_journal_dirty_metadata(handle, dir_block);
 	brelse (dir_block);
-	inode->i_mode = S_IFDIR | mode;
-	if (dir->i_mode & S_ISGID)
-		inode->i_mode |= S_ISGID;
 	ext3_mark_inode_dirty(handle, inode);
 	err = ext3_add_entry (handle, dentry, inode);
 	if (err)
@@ -987,7 +984,7 @@
 		goto out_stop;
 
 	if (l > sizeof (EXT3_I(inode)->i_data)) {
-		inode->i_op = &page_symlink_inode_operations;
+		inode->i_op = &ext3_symlink_inode_operations;
 		if (ext3_should_writeback_data(inode))
 			inode->i_mapping->a_ops = &ext3_writeback_aops;
 		else
@@ -1203,4 +1200,17 @@
 	.rmdir		= ext3_rmdir,
 	.mknod		= ext3_mknod,
 	.rename		= ext3_rename,
+	.setxattr	= ext3_setxattr,	
+	.getxattr	= ext3_getxattr,	
+	.listxattr	= ext3_listxattr,	
+	.removexattr	= ext3_removexattr,
 };
+
+struct inode_operations ext3_special_inode_operations = {
+	.setxattr	= ext3_setxattr,
+	.getxattr	= ext3_getxattr,
+	.listxattr	= ext3_listxattr,
+	.removexattr	= ext3_removexattr,
+};
+
+ 
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/super.c	Tue Oct  8 13:52:30 2002
@@ -24,6 +24,7 @@
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
+#include <linux/ext3_xattr.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
@@ -405,6 +406,7 @@
 	struct ext3_super_block *es = sbi->s_es;
 	int i;
 
+	ext3_xattr_put_super(sb);
 	journal_destroy(sbi->s_journal);
 	if (!(sb->s_flags & MS_RDONLY)) {
 		EXT3_CLEAR_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
@@ -554,6 +556,7 @@
 			  int is_remount)
 {
 	unsigned long *mount_options = &sbi->s_mount_opt;
+	
 	uid_t *resuid = &sbi->s_resuid;
 	gid_t *resgid = &sbi->s_resgid;
 	char * this_char;
@@ -566,6 +569,13 @@
 			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
+#ifdef CONFIG_EXT3_FS_XATTR_USER
+		if (!strcmp (this_char, "user_xattr"))
+			set_opt (*mount_options, XATTR_USER);
+		else if (!strcmp (this_char, "nouser_xattr"))
+			clear_opt (*mount_options, XATTR_USER);
+		else
+#endif
 		if (!strcmp (this_char, "bsddf"))
 			clear_opt (*mount_options, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
@@ -979,6 +989,12 @@
 	sbi->s_mount_opt = 0;
 	sbi->s_resuid = EXT3_DEF_RESUID;
 	sbi->s_resgid = EXT3_DEF_RESGID;
+
+	/* Default extended attribute flags */
+#ifdef CONFIG_EXT3_FS_XATTR_USER
+	set_opt(sbi->s_mount_opt, XATTR_USER);
+#endif
+
 	if (!parse_options ((char *) data, &sb_block, sbi, &journal_inum, 0))
 		goto out_fail;
 
@@ -1814,7 +1830,13 @@
 
 static int __init init_ext3_fs(void)
 {
-	int err = init_inodecache();
+	int err = init_ext3_xattr();
+	if (err)
+		return err;
+	err = init_ext3_xattr_user();
+	if (err)
+		goto out2;
+	err = init_inodecache();
 	if (err)
 		goto out1;
         err = register_filesystem(&ext3_fs_type);
@@ -1824,13 +1846,17 @@
 out:
 	destroy_inodecache();
 out1:
+	exit_ext3_xattr_user();
+out2:
+ 	exit_ext3_xattr();
 	return err;
 }
 
 static void __exit exit_ext3_fs(void)
 {
 	unregister_filesystem(&ext3_fs_type);
-	destroy_inodecache();
+	exit_ext3_xattr_user();
+	exit_ext3_xattr();
 }
 
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
diff -Nru a/fs/ext3/symlink.c b/fs/ext3/symlink.c
--- a/fs/ext3/symlink.c	Tue Oct  8 13:52:30 2002
+++ b/fs/ext3/symlink.c	Tue Oct  8 13:52:30 2002
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/ext3_xattr.h>
 
 static int ext3_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
@@ -33,7 +34,20 @@
 	return vfs_follow_link(nd, (char*)ei->i_data);
 }
 
+struct inode_operations ext3_symlink_inode_operations = {
+	.readlink	= page_readlink,
+	.follow_link	= page_follow_link,
+	.setxattr	= ext3_setxattr,
+	.getxattr	= ext3_getxattr,
+	.listxattr	= ext3_listxattr,
+	.removexattr	= ext3_removexattr,
+};
+
 struct inode_operations ext3_fast_symlink_inode_operations = {
-	.readlink	= ext3_readlink,		/* BKL not held.  Don't need */
+	.readlink	= ext3_readlink,	/* BKL not held.  Don't need */
 	.follow_link	= ext3_follow_link,	/* BKL not held.  Don't need */
+	.setxattr	= ext3_setxattr,
+	.getxattr	= ext3_getxattr,
+	.listxattr	= ext3_listxattr,
+	.removexattr	= ext3_removexattr,
 };
diff -Nru a/fs/ext3/xattr.c b/fs/ext3/xattr.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext3/xattr.c	Tue Oct  8 13:52:31 2002
@@ -0,0 +1,1233 @@
+/*
+ * linux/fs/ext3/xattr.c
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ *
+ * Fix by Harrison Xing <harrison@mountainviewdata.com>.
+ * Ext3 code with a lot of help from Eric Jarman <ejarman@acm.org>.
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
+ *   � entry 1          | |
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
+ * descriptors are variable in size, and alligned to EXT3_XATTR_PAD
+ * byte boundaries. The entry descriptors are sorted by attribute name,
+ * so that two extended attribute blocks can be compared efficiently.
+ *
+ * Attribute values are aligned to the end of the block, stored in
+ * no specific order. They are also padded to EXT3_XATTR_PAD byte
+ * boundaries. No additional gaps are left between them.
+ *
+ * Locking strategy
+ * ----------------
+ * The VFS holdsinode->i_sem semaphore when any of the xattr inode
+ * operations are called, so we are guaranteed that only one
+ * processes accesses extended attributes of an inode at any time.
+ *
+ * For writing we also grab the ext3_xattr_sem semaphore. This ensures that
+ * only a single process is modifying an extended attribute block, even
+ * if the block is shared among inodes.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include <linux/ext3_xattr.h>
+#include <linux/mbcache.h>
+#include <linux/quotaops.h>
+#include <asm/semaphore.h>
+#include <linux/compatmac.h>
+
+#define EXT3_EA_USER "user."
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
+# define mark_buffer_dirty(bh) mark_buffer_dirty(bh, 1)
+#endif
+
+#define HDR(bh) ((struct ext3_xattr_header *)((bh)->b_data))
+#define ENTRY(ptr) ((struct ext3_xattr_entry *)(ptr))
+#define FIRST_ENTRY(bh) ENTRY(HDR(bh)+1)
+#define IS_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
+
+#ifdef EXT3_XATTR_DEBUG
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
+static int ext3_xattr_set2(handle_t *, struct inode *, struct buffer_head *,
+			   struct ext3_xattr_header *);
+
+#ifdef CONFIG_EXT3_FS_XATTR_SHARING
+
+static int ext3_xattr_cache_insert(struct buffer_head *);
+static struct buffer_head *ext3_xattr_cache_find(struct inode *,
+						 struct ext3_xattr_header *);
+static void ext3_xattr_cache_remove(struct buffer_head *);
+static void ext3_xattr_rehash(struct ext3_xattr_header *,
+			      struct ext3_xattr_entry *);
+
+static struct mb_cache *ext3_xattr_cache;
+
+#else
+# define ext3_xattr_cache_insert(bh) 0
+# define ext3_xattr_cache_find(inode, header) NULL
+# define ext3_xattr_cache_remove(bh) while(0) {}
+# define ext3_xattr_rehash(header, entry) while(0) {}
+#endif
+
+/*
+ * If a file system does not share extended attributes among inodes,
+ * we should not need the ext3_xattr_sem semaphore. However, the
+ * filesystem may still contain shared blocks, so we always take
+ * the lock.
+ */
+
+DECLARE_MUTEX(ext3_xattr_sem);
+
+static inline void
+ext3_xattr_lock(void)
+{
+	down(&ext3_xattr_sem);
+}
+
+static inline void
+ext3_xattr_unlock(void)
+{
+	up(&ext3_xattr_sem);
+}
+
+static inline int
+ext3_xattr_new_block(handle_t *handle, struct inode *inode,
+		     int * errp, int force)
+{
+	struct super_block *sb = inode->i_sb;
+	int goal = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
+		EXT3_I(inode)->i_block_group * EXT3_BLOCKS_PER_GROUP(sb);
+
+	/* How can we enforce the allocation? */
+	int block = ext3_new_block(handle, inode, goal, 0, 0, errp);
+#ifdef OLD_QUOTAS
+	if (!*errp)
+		inode->i_blocks += inode->i_sb->s_blocksize >> 9;
+#endif
+	return block;
+}
+
+static inline int
+ext3_xattr_quota_alloc(struct inode *inode, int force)
+{
+	/* How can we enforce the allocation? */
+#ifdef OLD_QUOTAS
+	int error = DQUOT_ALLOC_BLOCK(inode->i_sb, inode, 1);
+	if (!error)
+		inode->i_blocks += inode->i_sb->s_blocksize >> 9;
+#else
+	int error = DQUOT_ALLOC_BLOCK(inode, 1);
+#endif
+	return error;
+}
+
+#ifdef OLD_QUOTAS
+
+static inline void
+ext3_xattr_quota_free(struct inode *inode)
+{
+	DQUOT_FREE_BLOCK(inode->i_sb, inode, 1);
+	inode->i_blocks -= inode->i_sb->s_blocksize >> 9;
+}
+
+static inline void
+ext3_xattr_free_block(handle_t *handle, struct inode * inode,
+		      unsigned long block)
+{
+	ext3_free_blocks(handle, inode, block, 1);
+	inode->i_blocks -= inode->i_sb->s_blocksize >> 9;
+}
+
+#else
+# define ext3_xattr_quota_free(inode) \
+	DQUOT_FREE_BLOCK(inode, 1)
+# define ext3_xattr_free_block(handle, inode, block) \
+	ext3_free_blocks(handle, inode, block, 1)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,18)
+
+static inline struct buffer_head *
+sb_bread(struct super_block *sb, int block)
+{
+	return bread(sb->s_dev, block, sb->s_blocksize);
+}
+
+static inline struct buffer_head *
+sb_getblk(struct super_block *sb, int block)
+{
+	return getblk(sb->s_dev, block, sb->s_blocksize);
+}
+
+#endif
+
+struct ext3_xattr_handler *ext3_xattr_handlers[EXT3_XATTR_INDEX_MAX];
+rwlock_t ext3_handler_lock = RW_LOCK_UNLOCKED;
+
+int
+ext3_xattr_register(int name_index, struct ext3_xattr_handler *handler)
+{
+	int error = -EINVAL;
+
+	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX) {
+		write_lock(&ext3_handler_lock);
+		if (!ext3_xattr_handlers[name_index-1]) {
+			ext3_xattr_handlers[name_index-1] = handler;
+			error = 0;
+		}
+		write_unlock(&ext3_handler_lock);
+	}
+	return error;
+}
+
+void
+ext3_xattr_unregister(int name_index, struct ext3_xattr_handler *handler)
+{
+	if (name_index > 0 || name_index <= EXT3_XATTR_INDEX_MAX) {
+		write_lock(&ext3_handler_lock);
+		ext3_xattr_handlers[name_index-1] = NULL;
+		write_unlock(&ext3_handler_lock);
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
+static inline struct ext3_xattr_handler *
+ext3_xattr_resolve_name(const char **name)
+{
+	struct ext3_xattr_handler *handler = NULL;
+	int i;
+
+	if (!*name)
+		return NULL;
+	read_lock(&ext3_handler_lock);
+	for (i=0; i<EXT3_XATTR_INDEX_MAX; i++) {
+		if (ext3_xattr_handlers[i]) {
+			const char *n = strcmp_prefix(*name,
+				ext3_xattr_handlers[i]->prefix);
+			if (n) {
+				handler = ext3_xattr_handlers[i];
+				*name = n;
+				break;
+			}
+		}
+	}
+	read_unlock(&ext3_handler_lock);
+	return handler;
+}
+
+static inline struct ext3_xattr_handler *
+ext3_xattr_handler(int name_index)
+{
+	struct ext3_xattr_handler *handler = NULL;
+	if (name_index > 0 && name_index <= EXT3_XATTR_INDEX_MAX) {
+		read_lock(&ext3_handler_lock);
+		handler = ext3_xattr_handlers[name_index-1];
+		read_unlock(&ext3_handler_lock);
+	}
+	return handler;
+}
+
+/*
+ * Inode operation getxattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+ssize_t
+ext3_getxattr(struct dentry *dentry, const char *name,
+	      void *buffer, size_t size)
+{
+	struct ext3_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = ext3_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->get(inode, name, buffer, size);
+}
+
+/*
+ * Inode operation listxattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+ssize_t
+ext3_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	return ext3_xattr_list(dentry->d_inode, buffer, size);
+}
+
+/*
+ * Inode operation setxattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+int
+ext3_setxattr(struct dentry *dentry, const char *name,
+	      void *value, size_t size, int flags)
+{
+	struct ext3_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+	handler = ext3_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, value, size, flags);
+}
+
+/*
+ * Inode operation removexattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+int
+ext3_removexattr(struct dentry *dentry, const char *name)
+{
+	struct ext3_xattr_handler *handler;
+	struct inode *inode = dentry->d_inode;
+
+	handler = ext3_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(inode, name, NULL, 0, XATTR_REPLACE);
+}
+
+/*
+ * ext3_xattr_get()
+ *
+ * Copy an extended attribute into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	struct buffer_head *bh = NULL;
+	struct ext3_xattr_entry *entry;
+	unsigned int block, size;
+	char *end;
+	int name_len, error;
+
+	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
+		  name_index, name, buffer, (long)buffer_size);
+
+	if (name == NULL)
+		return -EINVAL;
+	if (!EXT3_I(inode)->i_file_acl)
+		return -ENODATA;
+	block = EXT3_I(inode)->i_file_acl;
+	ea_idebug(inode, "reading block %d", block);
+	bh = sb_bread(inode->i_sb, block);
+	if (!bh)
+		return -EIO;
+	ea_bdebug(bh, "b_count=%d, refcount=%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+	end = bh->b_data + bh->b_size;
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+bad_block:	ext3_error(inode->i_sb, "ext3_xattr_get",
+			"inode %ld: bad block %d", inode->i_ino, block);
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
+		struct ext3_xattr_entry *next =
+			EXT3_XATTR_NEXT(entry);
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
+		struct ext3_xattr_entry *next =
+			EXT3_XATTR_NEXT(entry);
+		if ((char *)next >= end)
+			goto bad_block;
+		entry = next;
+	}
+	if (ext3_xattr_cache_insert(bh))
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
+	if (ext3_xattr_cache_insert(bh))
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
+ * ext3_xattr_list()
+ *
+ * Copy a list of attribute names into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	struct buffer_head *bh = NULL;
+	struct ext3_xattr_entry *entry;
+	unsigned int block, size = 0;
+	char *buf, *end;
+	int error;
+
+	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
+		  buffer, (long)buffer_size);
+
+	if (!EXT3_I(inode)->i_file_acl)
+		return 0;
+	block = EXT3_I(inode)->i_file_acl;
+	ea_idebug(inode, "reading block %d", block);
+	bh = sb_bread(inode->i_sb, block);
+	if (!bh)
+		return -EIO;
+	ea_bdebug(bh, "b_count=%d, refcount=%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+	end = bh->b_data + bh->b_size;
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+bad_block:	ext3_error(inode->i_sb, "ext3_xattr_list",
+			"inode %ld: bad block %d", inode->i_ino, block);
+		error = -EIO;
+		goto cleanup;
+	}
+	/* compute the size required for the list of attribute names */
+	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
+	     entry = EXT3_XATTR_NEXT(entry)) {
+		struct ext3_xattr_handler *handler;
+		struct ext3_xattr_entry *next =
+			EXT3_XATTR_NEXT(entry);
+		if ((char *)next >= end)
+			goto bad_block;
+
+		handler = ext3_xattr_handler(entry->e_name_index);
+		if (handler) {
+			size += handler->list(NULL, inode, entry->e_name,
+					      entry->e_name_len) + 1;
+		}
+	}
+
+	if (ext3_xattr_cache_insert(bh))
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
+	     entry = EXT3_XATTR_NEXT(entry)) {
+		struct ext3_xattr_handler *handler;
+
+		handler = ext3_xattr_handler(entry->e_name_index);
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
+ * If the EXT3_FEATURE_COMPAT_EXT_ATTR feature of this file system is
+ * not set, set it.
+ */
+static void ext3_xattr_update_super_block(handle_t *handle,
+					  struct super_block *sb)
+{
+	if (EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_EXT_ATTR))
+		return;
+
+	lock_super(sb);
+	ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
+	EXT3_SB(sb)->s_feature_compat |= EXT3_FEATURE_COMPAT_EXT_ATTR;
+#endif
+	EXT3_SB(sb)->s_es->s_feature_compat |=
+		cpu_to_le32(EXT3_FEATURE_COMPAT_EXT_ATTR);
+	sb->s_dirt = 1;
+	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
+	unlock_super(sb);
+}
+
+/*
+ * ext3_xattr_set()
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
+ext3_xattr_set(handle_t *handle, struct inode *inode, int name_index,
+	       const char *name, const void *value, size_t value_len, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh = NULL;
+	struct ext3_xattr_header *header = NULL;
+	struct ext3_xattr_entry *here, *last;
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
+	ext3_xattr_lock();
+
+	if (EXT3_I(inode)->i_file_acl) {
+		/* The inode already has an extended attribute block. */
+		int block = EXT3_I(inode)->i_file_acl;
+
+		bh = sb_bread(sb, block);
+		error = -EIO;
+		if (!bh)
+			goto cleanup;
+		ea_bdebug(bh, "b_count=%d, refcount=%d",
+			atomic_read(&(bh->b_count)),
+			le32_to_cpu(HDR(bh)->h_refcount));
+		header = HDR(bh);
+		end = bh->b_data + bh->b_size;
+		if (header->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+		    header->h_blocks != cpu_to_le32(1)) {
+bad_block:		ext3_error(sb, "ext3_xattr_set",
+				"inode %ld: bad block %d", inode->i_ino, block);
+			error = -EIO;
+			goto cleanup;
+		}
+		/* Find the named attribute. */
+		here = FIRST_ENTRY(bh);
+		while (!IS_LAST_ENTRY(here)) {
+			struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(here);
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
+			struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
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
+			sizeof(struct ext3_xattr_header) - sizeof(__u32);
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
+			free -= EXT3_XATTR_LEN(name_len);
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
+			free += EXT3_XATTR_SIZE(size);
+		}
+	}
+	free -= EXT3_XATTR_SIZE(value_len);
+	error = -ENOSPC;
+	if (free < 0)
+		goto cleanup;
+
+	/* Here we know that we can set the new attribute. */
+
+	if (header) {
+		if (header->h_refcount == cpu_to_le32(1)) {
+			ea_bdebug(bh, "modifying in-place");
+			ext3_xattr_cache_remove(bh);
+			error = ext3_journal_get_write_access(handle, bh);
+			if (error)
+				goto cleanup;
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
+		header->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
+		header->h_blocks = header->h_refcount = cpu_to_le32(1);
+		last = here = ENTRY(header+1);
+	}
+
+	if (not_found) {
+		/* Insert the new name. */
+		int size = EXT3_XATTR_LEN(name_len);
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
+			size_t size = EXT3_XATTR_SIZE(
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
+				last = EXT3_XATTR_NEXT(last);
+			}
+		}
+		if (value == NULL) {
+			/* Remove this attribute. */
+			if (EXT3_XATTR_NEXT(ENTRY(header+1)) == last) {
+				/* This block is now empty. */
+				error = ext3_xattr_set2(handle, inode, bh,NULL);
+				goto cleanup;
+			} else {
+				/* Remove the old name. */
+				int size = EXT3_XATTR_LEN(name_len);
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
+			size_t size = EXT3_XATTR_SIZE(value_len);
+			char *val = (char *)header + min_offs - size;
+			here->e_value_offs =
+				cpu_to_le16((char *)val - (char *)header);
+			memset(val + size - EXT3_XATTR_PAD, 0,
+			       EXT3_XATTR_PAD); /* Clear the pad bytes. */
+			memcpy(val, value, value_len);
+		}
+	}
+	ext3_xattr_rehash(header, here);
+
+	error = ext3_xattr_set2(handle, inode, bh, header);
+
+cleanup:
+	brelse(bh);
+	if (!(bh && header == HDR(bh)))
+		kfree(header);
+	ext3_xattr_unlock();
+
+	return error;
+}
+
+/*
+ * Second half of ext3_xattr_set(): Update the file system.
+ */
+static int
+ext3_xattr_set2(handle_t *handle, struct inode *inode,
+		struct buffer_head *old_bh, struct ext3_xattr_header *header)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *new_bh = NULL;
+	int error;
+
+	if (header) {
+		new_bh = ext3_xattr_cache_find(inode, header);
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
+			if (ext3_xattr_quota_alloc(inode, 1))
+				goto cleanup;
+			
+			error = ext3_journal_get_write_access(handle, new_bh);
+			if (error)
+				goto cleanup;
+			HDR(new_bh)->h_refcount = cpu_to_le32(
+				le32_to_cpu(HDR(new_bh)->h_refcount) + 1);
+			ea_bdebug(new_bh, "refcount now=%d",
+				le32_to_cpu(HDR(new_bh)->h_refcount));
+		} else if (old_bh && header == HDR(old_bh)) {
+			/* Keep this block. */
+			new_bh = old_bh;
+			ext3_xattr_cache_insert(new_bh);
+		} else {
+			/* We need to allocate a new block */
+			int force = EXT3_I(inode)->i_file_acl != 0;
+			int block = ext3_xattr_new_block(handle, inode,
+							 &error, force);
+			if (error)
+				goto cleanup;
+			ea_idebug(inode, "creating block %d", block);
+
+			new_bh = sb_getblk(sb, block);
+			if (!new_bh) {
+getblk_failed:			ext3_xattr_free_block(handle, inode, block);
+				error = -EIO;
+				goto cleanup;
+			}
+			lock_buffer(new_bh);
+			error = ext3_journal_get_create_access(handle, new_bh);
+			if (error) {
+				unlock_buffer(new_bh);
+				goto getblk_failed;
+			}
+			memcpy(new_bh->b_data, header, new_bh->b_size);
+			set_buffer_uptodate(new_bh);
+			unlock_buffer(new_bh);
+			ext3_xattr_cache_insert(new_bh);
+			
+			ext3_xattr_update_super_block(handle, sb);
+		}
+		error = ext3_journal_dirty_metadata(handle, new_bh);
+		if (error)
+			goto cleanup;
+	}
+
+	/* Update the inode. */
+	EXT3_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
+	inode->i_ctime = CURRENT_TIME;
+	ext3_mark_inode_dirty(handle, inode);
+	if (IS_SYNC(inode))
+		handle->h_sync = 1;
+
+	error = 0;
+	if (old_bh && old_bh != new_bh) {
+		/*
+		 * If there was an old block, and we are not still using it,
+		 * we now release the old block.
+		*/
+		unsigned int refcount = le32_to_cpu(HDR(old_bh)->h_refcount);
+
+		error = ext3_journal_get_write_access(handle, old_bh);
+		if (error)
+			goto cleanup;
+		if (refcount == 1) {
+			/* Free the old block. */
+			ea_bdebug(old_bh, "freeing");
+			ext3_xattr_free_block(handle, inode, old_bh->b_blocknr);
+
+			/* ext3_forget() calls bforget() for us, but we
+			   let our caller release old_bh, so we need to
+			   duplicate the handle before. */
+			get_bh(old_bh);
+			ext3_forget(handle, 1, inode, old_bh,old_bh->b_blocknr);
+		} else {
+			/* Decrement the refcount only. */
+			refcount--;
+			HDR(old_bh)->h_refcount = cpu_to_le32(refcount);
+			ext3_xattr_quota_free(inode);
+			ext3_journal_dirty_metadata(handle, old_bh);
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
+ * ext3_xattr_delete_inode()
+ *
+ * Free extended attribute resources associated with this inode. This
+ * is called immediately before an inode is freed.
+ */
+void
+ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
+{
+	struct buffer_head *bh;
+	unsigned int block = EXT3_I(inode)->i_file_acl;
+
+	if (!block)
+		return;
+	ext3_xattr_lock();
+
+	bh = sb_bread(inode->i_sb, block);
+	if (!bh) {
+		ext3_error(inode->i_sb, "ext3_xattr_delete_inode",
+			"inode %ld: block %d read error", inode->i_ino, block);
+		goto cleanup;
+	}
+	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+		ext3_error(inode->i_sb, "ext3_xattr_delete_inode",
+			"inode %ld: bad block %d", inode->i_ino, block);
+		goto cleanup;
+	}
+	ext3_journal_get_write_access(handle, bh);
+	ea_bdebug(bh, "refcount now=%d", le32_to_cpu(HDR(bh)->h_refcount) - 1);
+	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
+		ext3_xattr_cache_remove(bh);
+		ext3_xattr_free_block(handle, inode, block);
+		ext3_forget(handle, 1, inode, bh, block);
+		bh = NULL;
+	} else {
+		HDR(bh)->h_refcount = cpu_to_le32(
+			le32_to_cpu(HDR(bh)->h_refcount) - 1);
+		ext3_journal_dirty_metadata(handle, bh);
+		if (IS_SYNC(inode))
+			handle->h_sync = 1;
+		ext3_xattr_quota_free(inode);
+	}
+	EXT3_I(inode)->i_file_acl = 0;
+
+cleanup:
+	brelse(bh);
+	ext3_xattr_unlock();
+}
+
+/*
+ * ext3_xattr_put_super()
+ *
+ * This is called when a file system is unmounted.
+ */
+void
+ext3_xattr_put_super(struct super_block *sb)
+{
+#ifdef CONFIG_EXT3_FS_XATTR_SHARING
+	mb_cache_shrink(ext3_xattr_cache, sb->s_dev);
+#endif
+}
+
+#ifdef CONFIG_EXT3_FS_XATTR_SHARING
+
+/*
+ * ext3_xattr_cache_insert()
+ *
+ * Create a new entry in the extended attribute cache, and insert
+ * it unless such an entry is already in the cache.
+ *
+ * Returns 0, or a negative error number on failure.
+ */
+static int
+ext3_xattr_cache_insert(struct buffer_head *bh)
+{
+	__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
+	struct mb_cache_entry *ce;
+	int error;
+
+	ce = mb_cache_entry_alloc(ext3_xattr_cache);
+	if (!ce)
+		return -ENOMEM;
+	error = mb_cache_entry_insert(ce, bh->b_bdev->bd_dev,
+				      bh->b_blocknr, &hash);
+	if (error) {
+		mb_cache_entry_free(ce);
+		if (error == -EBUSY) {
+			ea_bdebug(bh, "already in cache (%d cache entries)",
+				atomic_read(&ext3_xattr_cache->c_entry_count));
+			error = 0;
+		}
+	} else {
+		ea_bdebug(bh, "inserting [%x] (%d cache entries)", (int)hash,
+			  atomic_read(&ext3_xattr_cache->c_entry_count));
+		mb_cache_entry_release(ce);
+	}
+	return error;
+}
+
+/*
+ * ext3_xattr_cmp()
+ *
+ * Compare two extended attribute blocks for equality.
+ *
+ * Returns 0 if the blocks are equal, 1 if they differ, and
+ * a negative error number on errors.
+ */
+static int
+ext3_xattr_cmp(struct ext3_xattr_header *header1,
+	       struct ext3_xattr_header *header2)
+{
+	struct ext3_xattr_entry *entry1, *entry2;
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
+		entry1 = EXT3_XATTR_NEXT(entry1);
+		entry2 = EXT3_XATTR_NEXT(entry2);
+	}
+	if (!IS_LAST_ENTRY(entry2))
+		return 1;
+	return 0;
+}
+
+/*
+ * ext3_xattr_cache_find()
+ *
+ * Find an identical extended attribute block.
+ *
+ * Returns a pointer to the block found, or NULL if such a block was
+ * not found or an error occurred.
+ */
+static struct buffer_head *
+ext3_xattr_cache_find(struct inode *inode, struct ext3_xattr_header *header)
+{
+	__u32 hash = le32_to_cpu(header->h_hash);
+	struct mb_cache_entry *ce;
+
+	if (!header->h_hash)
+		return NULL;  /* never share */
+	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
+	ce = mb_cache_entry_find_first(ext3_xattr_cache, 0, inode->i_dev, hash);
+	while (ce) {
+		struct buffer_head *bh = sb_bread(inode->i_sb, ce->e_block);
+
+		if (!bh) {
+			ext3_error(inode->i_sb, "ext3_xattr_cache_find",
+				"inode %ld: block %ld read error",
+				inode->i_ino, ce->e_block);
+		} else if (le32_to_cpu(HDR(bh)->h_refcount) >
+			   EXT3_XATTR_REFCOUNT_MAX) {
+			ea_idebug(inode, "block %ld refcount %d>%d",ce->e_block,
+				le32_to_cpu(HDR(bh)->h_refcount),
+				EXT3_XATTR_REFCOUNT_MAX);
+		} else if (!ext3_xattr_cmp(header, HDR(bh))) {
+			ea_bdebug(bh, "b_count=%d",atomic_read(&(bh->b_count)));
+			mb_cache_entry_release(ce);
+			return bh;
+		}
+		brelse(bh);
+		ce = mb_cache_entry_find_next(ce, 0, inode->i_dev, hash);
+	}
+	return NULL;
+}
+
+/*
+ * ext3_xattr_cache_remove()
+ *
+ * Remove the cache entry of a block from the cache. Called when a
+ * block becomes invalid.
+ */
+static void
+ext3_xattr_cache_remove(struct buffer_head *bh)
+{
+	struct mb_cache_entry *ce;
+
+	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev->bd_dev,
+				bh->b_blocknr);
+	if (ce) {
+		ea_bdebug(bh, "removing (%d cache entries remaining)",
+			  atomic_read(&ext3_xattr_cache->c_entry_count)-1);
+		mb_cache_entry_free(ce);
+	} else 
+		ea_bdebug(bh, "no cache entry");
+}
+
+#define NAME_HASH_SHIFT 5
+#define VALUE_HASH_SHIFT 16
+
+/*
+ * ext3_xattr_hash_entry()
+ *
+ * Compute the hash of an extended attribute.
+ */
+static inline void ext3_xattr_hash_entry(struct ext3_xattr_header *header,
+					 struct ext3_xattr_entry *entry)
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
+		     EXT3_XATTR_ROUND) >> EXT3_XATTR_PAD_BITS; n; n--) {
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
+ * ext3_xattr_rehash()
+ *
+ * Re-compute the extended attribute hash value after an entry has changed.
+ */
+static void ext3_xattr_rehash(struct ext3_xattr_header *header,
+			      struct ext3_xattr_entry *entry)
+{
+	struct ext3_xattr_entry *here;
+	__u32 hash = 0;
+	
+	ext3_xattr_hash_entry(header, entry);
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
+		here = EXT3_XATTR_NEXT(here);
+	}
+	header->h_hash = cpu_to_le32(hash);
+}
+
+#undef BLOCK_HASH_SHIFT
+
+int __init
+init_ext3_xattr(void)
+{
+	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
+		sizeof(struct mb_cache_entry) +
+		sizeof(struct mb_cache_entry_index), 1, 61);
+	if (!ext3_xattr_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void
+exit_ext3_xattr(void)
+{
+	if (ext3_xattr_cache)
+		mb_cache_destroy(ext3_xattr_cache);
+	ext3_xattr_cache = NULL;
+}
+
+#else  /* CONFIG_EXT3_FS_XATTR_SHARING */
+
+int __init
+init_ext3_xattr(void)
+{
+	return 0;
+}
+
+void
+exit_ext3_xattr(void)
+{
+}
+
+#endif  /* CONFIG_EXT3_FS_XATTR_SHARING */
diff -Nru a/fs/ext3/xattr_user.c b/fs/ext3/xattr_user.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext3/xattr_user.c	Tue Oct  8 13:52:31 2002
@@ -0,0 +1,113 @@
+/*
+ * linux/fs/ext3/xattr_user.c
+ * Handler for extended user attributes.
+ *
+ * Copyright (C) 2001 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/smp_lock.h>
+#include <linux/ext3_jbd.h>
+#include <linux/ext3_fs.h>
+#include <linux/ext3_xattr.h>
+
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+# include <linux/ext3_acl.h>
+#endif
+
+#define XATTR_USER_PREFIX "user."
+
+static size_t
+ext3_xattr_user_list(char *list, struct inode *inode,
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
+ext3_xattr_user_get(struct inode *inode, const char *name,
+		    void *buffer, size_t size)
+{
+	int error;
+
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return -EOPNOTSUPP;
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	error = ext3_permission_locked(inode, MAY_READ);
+#else
+	error = permission(inode, MAY_READ);
+#endif
+	if (error)
+		return error;
+
+	return ext3_xattr_get(inode, EXT3_XATTR_INDEX_USER, name,
+			      buffer, size);
+}
+
+static int
+ext3_xattr_user_set(struct inode *inode, const char *name,
+		    const void *value, size_t size, int flags)
+{
+	handle_t *handle;
+	int error;
+
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	if (!test_opt(inode->i_sb, XATTR_USER))
+		return -EOPNOTSUPP;
+	if ( !S_ISREG(inode->i_mode) &&
+	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
+		return -EPERM;
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
+	error = ext3_permission_locked(inode, MAY_WRITE);
+#else
+	error = permission(inode, MAY_WRITE);
+#endif
+	if (error)
+		return error;
+  
+	lock_kernel();
+	handle = ext3_journal_start(inode, EXT3_XATTR_TRANS_BLOCKS);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	error = ext3_xattr_set(handle, inode, EXT3_XATTR_INDEX_USER, name,
+			       value, size, flags);
+	ext3_journal_stop(handle, inode);
+	unlock_kernel();
+
+	return error;
+}
+
+struct ext3_xattr_handler ext3_xattr_user_handler = {
+	prefix:	XATTR_USER_PREFIX,
+	list:	ext3_xattr_user_list,
+	get:	ext3_xattr_user_get,
+	set:	ext3_xattr_user_set,
+};
+
+int __init
+init_ext3_xattr_user(void)
+{
+	return ext3_xattr_register(EXT3_XATTR_INDEX_USER,
+				   &ext3_xattr_user_handler);
+}
+
+void
+exit_ext3_xattr_user(void)
+{
+	ext3_xattr_unregister(EXT3_XATTR_INDEX_USER,
+			      &ext3_xattr_user_handler);
+}
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Tue Oct  8 13:52:30 2002
+++ b/include/linux/ext3_fs.h	Tue Oct  8 13:52:30 2002
@@ -58,8 +58,6 @@
  */
 #define	EXT3_BAD_INO		 1	/* Bad blocks inode */
 #define EXT3_ROOT_INO		 2	/* Root inode */
-#define EXT3_ACL_IDX_INO	 3	/* ACL inode */
-#define EXT3_ACL_DATA_INO	 4	/* ACL inode */
 #define EXT3_BOOT_LOADER_INO	 5	/* Boot loader inode */
 #define EXT3_UNDEL_DIR_INO	 6	/* Undelete directory inode */
 #define EXT3_RESIZE_INO		 7	/* Reserved group descriptors inode */
@@ -89,7 +87,6 @@
 #else
 # define EXT3_BLOCK_SIZE(s)		(EXT3_MIN_BLOCK_SIZE << (s)->s_log_block_size)
 #endif
-#define EXT3_ACLE_PER_BLOCK(s)		(EXT3_BLOCK_SIZE(s) / sizeof (struct ext3_acl_entry))
 #define	EXT3_ADDR_PER_BLOCK(s)		(EXT3_BLOCK_SIZE(s) / sizeof (__u32))
 #ifdef __KERNEL__
 # define EXT3_BLOCK_SIZE_BITS(s)	((s)->s_blocksize_bits)
@@ -124,28 +121,6 @@
 #endif
 
 /*
- * ACL structures
- */
-struct ext3_acl_header	/* Header of Access Control Lists */
-{
-	__u32	aclh_size;
-	__u32	aclh_file_count;
-	__u32	aclh_acle_count;
-	__u32	aclh_first_acle;
-};
-
-struct ext3_acl_entry	/* Access Control List Entry */
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
 struct ext3_group_desc
@@ -341,6 +316,7 @@
   #define EXT3_MOUNT_WRITEBACK_DATA	0x0C00	/* No data ordering */
 #define EXT3_MOUNT_UPDATE_JOURNAL	0x1000	/* Update the journal format */
 #define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs */
+#define EXT3_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
@@ -520,7 +496,7 @@
 #define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004 /* Needs recovery */
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 
-#define EXT3_FEATURE_COMPAT_SUPP	0
+#define EXT3_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT3_FEATURE_INCOMPAT_RECOVER)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
@@ -636,6 +612,7 @@
 extern unsigned long ext3_count_free (struct buffer_head *, unsigned);
 
 /* inode.c */
+extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
 extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 
@@ -702,8 +679,10 @@
 
 /* namei.c */
 extern struct inode_operations ext3_dir_inode_operations;
+extern struct inode_operations ext3_special_inode_operations;
 
 /* symlink.c */
+extern struct inode_operations ext3_symlink_inode_operations;
 extern struct inode_operations ext3_fast_symlink_inode_operations;
 
 
diff -Nru a/include/linux/ext3_jbd.h b/include/linux/ext3_jbd.h
--- a/include/linux/ext3_jbd.h	Tue Oct  8 13:52:30 2002
+++ b/include/linux/ext3_jbd.h	Tue Oct  8 13:52:30 2002
@@ -30,13 +30,19 @@
 
 #define EXT3_SINGLEDATA_TRANS_BLOCKS	8
 
+/* Extended attributes may touch two data buffers, two bitmap buffers,
+ * and two group and summaries. */
+
+#define EXT3_XATTR_TRANS_BLOCKS		8
+
 /* Define the minimum size for a transaction which modifies data.  This
  * needs to take into account the fact that we may end up modifying two
  * quota files too (one for the group, one for the user quota).  The
  * superblock only gets updated once, of course, so don't bother
  * counting that again for the quota updates. */
 
-#define EXT3_DATA_TRANS_BLOCKS		(3 * EXT3_SINGLEDATA_TRANS_BLOCKS - 2)
+#define EXT3_DATA_TRANS_BLOCKS		(3 * EXT3_SINGLEDATA_TRANS_BLOCKS + \
+					 EXT3_XATTR_TRANS_BLOCKS - 2)
 
 extern int ext3_writepage_trans_blocks(struct inode *inode);
 
diff -Nru a/include/linux/ext3_xattr.h b/include/linux/ext3_xattr.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ext3_xattr.h	Tue Oct  8 13:52:31 2002
@@ -0,0 +1,157 @@
+/*
+  File: linux/ext3_xattr.h
+
+  On-disk format of extended attributes for the ext3 filesystem.
+
+  (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
+*/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/xattr.h>
+
+/* Magic value in attribute blocks */
+#define EXT3_XATTR_MAGIC		0xEA020000
+
+/* Maximum number of references to one attribute block */
+#define EXT3_XATTR_REFCOUNT_MAX		1024
+
+/* Name indexes */
+#define EXT3_XATTR_INDEX_MAX			10
+#define EXT3_XATTR_INDEX_USER			1
+#define EXT3_XATTR_INDEX_POSIX_ACL_ACCESS	2
+#define EXT3_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+
+struct ext3_xattr_header {
+	__u32	h_magic;	/* magic number for identification */
+	__u32	h_refcount;	/* reference count */
+	__u32	h_blocks;	/* number of disk blocks used */
+	__u32	h_hash;		/* hash value of all attributes */
+	__u32	h_reserved[4];	/* zero right now */
+};
+
+struct ext3_xattr_entry {
+	__u8	e_name_len;	/* length of name */
+	__u8	e_name_index;	/* attribute name index */
+	__u16	e_value_offs;	/* offset in disk block of value */
+	__u32	e_value_block;	/* disk block attribute is stored on (n/i) */
+	__u32	e_value_size;	/* size of attribute value */
+	__u32	e_hash;		/* hash value of name and value */
+	char	e_name[0];	/* attribute name */
+};
+
+#define EXT3_XATTR_PAD_BITS		2
+#define EXT3_XATTR_PAD		(1<<EXT3_XATTR_PAD_BITS)
+#define EXT3_XATTR_ROUND		(EXT3_XATTR_PAD-1)
+#define EXT3_XATTR_LEN(name_len) \
+	(((name_len) + EXT3_XATTR_ROUND + \
+	sizeof(struct ext3_xattr_entry)) & ~EXT3_XATTR_ROUND)
+#define EXT3_XATTR_NEXT(entry) \
+	( (struct ext3_xattr_entry *)( \
+	  (char *)(entry) + EXT3_XATTR_LEN((entry)->e_name_len)) )
+#define EXT3_XATTR_SIZE(size) \
+	(((size) + EXT3_XATTR_ROUND) & ~EXT3_XATTR_ROUND)
+
+#ifdef __KERNEL__
+
+# ifdef CONFIG_EXT3_FS_XATTR
+
+struct ext3_xattr_handler {
+	char *prefix;
+	size_t (*list)(char *list, struct inode *inode, const char *name,
+		       int name_len);
+	int (*get)(struct inode *inode, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct inode *inode, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+extern int ext3_xattr_register(int, struct ext3_xattr_handler *);
+extern void ext3_xattr_unregister(int, struct ext3_xattr_handler *);
+
+extern int ext3_setxattr(struct dentry *, const char *, void *, size_t, int);
+extern ssize_t ext3_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t ext3_listxattr(struct dentry *, char *, size_t);
+extern int ext3_removexattr(struct dentry *, const char *);
+
+extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
+extern int ext3_xattr_list(struct inode *, char *, size_t);
+extern int ext3_xattr_set(handle_t *handle, struct inode *, int, const char *, const void *, size_t, int);
+
+extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
+extern void ext3_xattr_put_super(struct super_block *);
+
+extern int init_ext3_xattr(void) __init;
+extern void exit_ext3_xattr(void);
+
+# else  /* CONFIG_EXT3_FS_XATTR */
+#  define ext3_setxattr		NULL
+#  define ext3_getxattr		NULL
+#  define ext3_listxattr	NULL
+#  define ext3_removexattr	NULL
+
+static inline int
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t size, int flags)
+{
+	return -ENOTSUP;
+}
+
+static inline int
+ext3_xattr_list(struct inode *inode, void *buffer, size_t size, int flags)
+{
+	return -ENOTSUP;
+}
+
+static inline int
+ext3_xattr_set(handle_t *handle, struct inode *inode, int name_index,
+	       const char *name, const void *value, size_t size, int flags)
+{
+	return -ENOTSUP;
+}
+
+static inline void
+ext3_xattr_delete_inode(handle_t *handle, struct inode *inode)
+{
+}
+
+static inline void
+ext3_xattr_put_super(struct super_block *sb)
+{
+}
+
+static inline int
+init_ext3_xattr(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext3_xattr(void)
+{
+}
+
+# endif  /* CONFIG_EXT3_FS_XATTR */
+
+# ifdef CONFIG_EXT3_FS_XATTR_USER
+
+extern int init_ext3_xattr_user(void) __init;
+extern void exit_ext3_xattr_user(void);
+
+# else  /* CONFIG_EXT3_FS_XATTR_USER */
+
+static inline int
+init_ext3_xattr_user(void)
+{
+	return 0;
+}
+
+static inline void
+exit_ext3_xattr_user(void)
+{
+}
+
+#endif  /* CONFIG_EXT3_FS_XATTR_USER */
+
+#endif  /* __KERNEL__ */
+

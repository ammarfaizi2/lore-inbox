Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSKBT7h>; Sat, 2 Nov 2002 14:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKBT7h>; Sat, 2 Nov 2002 14:59:37 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:20230 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261340AbSKBT7b>; Sat, 2 Nov 2002 14:59:31 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove the exported symbols on fat (2/2)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 03 Nov 2002 05:05:48 +0900
Message-ID: <87wunv91pf.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch from Christoph Hellwig. Please apply.


The <foo>_syms.c files of both drivers contain two things:
(1) some mount-related code, and
(2) exported symbols

(1) should obviously be merged into namei.c and (2) isn't used
at all in the current tree.  dmsdos is not likely to come ever
back from death, and Al's plans for umdos are to rewrite it as
proper stackable filesystem so it doesn't need them either (*).

So remove them, if someone needs them ever back he can still
readd them.

(*) in fact there's even a comment complaining about them
exported.


 fs/msdos/Makefile        |    8 +------
 fs/msdos/namei.c         |   48 ++++++++++++++++++++++++++++++++----------
 fs/vfat/Makefile         |    8 +------
 fs/vfat/namei.c          |   49 +++++++++++++++++++++++++++++++++++--------
 include/linux/msdos_fs.h |   26 -----------------------
 fs/msdos/msdosfs_syms.c  |   53 -----------------------------------------------
 fs/vfat/vfatfs_syms.c    |   47 -----------------------------------------
 7 files changed, 82 insertions(+), 157 deletions(-)

--- fat-2.5.45-bk1/fs/msdos/Makefile~fat_kill_export	2002-11-03 03:40:37.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/fs/msdos/Makefile	2002-11-03 03:40:38.000000000 +0900
@@ -2,10 +2,6 @@
 # Makefile for the Linux msdos filesystem routines.
 #
 
-export-objs := msdosfs_syms.o
+msdos-objs		:= namei.o
 
-obj-$(CONFIG_MSDOS_FS) += msdos.o
-
-msdos-objs := namei.o msdosfs_syms.o
-
-include $(TOPDIR)/Rules.make
+obj-$(CONFIG_MSDOS_FS)	+= msdos.o
--- fat-2.5.45-bk1/fs/msdos/msdosfs_syms.c
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,53 +0,0 @@
-/*
- * linux/fs/msdos/msdosfs_syms.c
- *
- * Exported kernel symbols for the MS-DOS filesystem.
- * These symbols are used by umsdos.
- */
-
-#include <linux/module.h>
-
-#include <linux/mm.h>
-#include <linux/msdos_fs.h>
-#include <linux/init.h>
-
-/*
- * Support for umsdos fs
- *
- * These symbols are _always_ exported, in case someone
- * wants to install the umsdos module later.
- */
-EXPORT_SYMBOL(msdos_create);
-EXPORT_SYMBOL(msdos_lookup);
-EXPORT_SYMBOL(msdos_mkdir);
-EXPORT_SYMBOL(msdos_rename);
-EXPORT_SYMBOL(msdos_rmdir);
-EXPORT_SYMBOL(msdos_unlink);
-
-static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
-{
-	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
-}
-
-static struct file_system_type msdos_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "msdos",
-	.get_sb		= msdos_get_sb,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
-};
-
-static int __init init_msdos_fs(void)
-{
-	return register_filesystem(&msdos_fs_type);
-}
-
-static void __exit exit_msdos_fs(void)
-{
-	unregister_filesystem(&msdos_fs_type);
-}
-
-module_init(init_msdos_fs)
-module_exit(exit_msdos_fs)
-MODULE_LICENSE("GPL");
--- fat-2.5.45-bk1/fs/msdos/namei.c~fat_kill_export	2002-11-03 03:40:37.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/fs/msdos/namei.c	2002-11-03 03:40:38.000000000 +0900
@@ -12,6 +12,9 @@
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MS-DOS filesystem driver");
+MODULE_AUTHOR("Werner Almesberger");
 
 /* MS-DOS "device special files" */
 static const char *reserved_names[] = {
@@ -257,12 +260,8 @@ static int msdos_add_entry(struct inode 
 	return 0;
 }
 
-/*
- * AV. Huh??? It's exported. Oughtta check usage.
- */
-
 /***** Create a file */
-int msdos_create(struct inode *dir,struct dentry *dentry,int mode)
+static int msdos_create(struct inode *dir,struct dentry *dentry,int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
@@ -305,7 +304,7 @@ int msdos_create(struct inode *dir,struc
 }
 
 /***** Remove a directory */
-int msdos_rmdir(struct inode *dir, struct dentry *dentry)
+static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	int res,ino;
@@ -343,7 +342,7 @@ rmdir_done:
 }
 
 /***** Make a directory */
-int msdos_mkdir(struct inode *dir,struct dentry *dentry,int mode)
+static int msdos_mkdir(struct inode *dir,struct dentry *dentry,int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
@@ -411,7 +410,7 @@ out_exist:
 }
 
 /***** Unlink a file */
-int msdos_unlink( struct inode *dir, struct dentry *dentry)
+static int msdos_unlink( struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	int res,ino;
@@ -539,7 +538,7 @@ degenerate_case:
 }
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
-int msdos_rename(struct inode *old_dir,struct dentry *old_dentry,
+static int msdos_rename(struct inode *old_dir,struct dentry *old_dentry,
 		 struct inode *new_dir,struct dentry *new_dentry)
 {
 	struct buffer_head *old_bh;
@@ -578,7 +577,7 @@ rename_done:
 
 
 /* The public inode operations for the msdos fs */
-struct inode_operations msdos_dir_inode_operations = {
+static struct inode_operations msdos_dir_inode_operations = {
 	.create		= msdos_create,
 	.lookup		= msdos_lookup,
 	.unlink		= msdos_unlink,
@@ -588,7 +587,7 @@ struct inode_operations msdos_dir_inode_
 	.setattr	= fat_notify_change,
 };
 
-int msdos_fill_super(struct super_block *sb,void *data, int silent)
+static int msdos_fill_super(struct super_block *sb,void *data, int silent)
 {
 	int res;
 
@@ -599,3 +598,30 @@ int msdos_fill_super(struct super_block 
 	sb->s_root->d_op = &msdos_dentry_operations;
 	return 0;
 }
+
+static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
+	int flags, char *dev_name, void *data)
+{
+	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
+}
+
+static struct file_system_type msdos_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "msdos",
+	.get_sb		= msdos_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
+};
+
+static int __init init_msdos_fs(void)
+{
+	return register_filesystem(&msdos_fs_type);
+}
+
+static void __exit exit_msdos_fs(void)
+{
+	unregister_filesystem(&msdos_fs_type);
+}
+
+module_init(init_msdos_fs)
+module_exit(exit_msdos_fs)
--- fat-2.5.45-bk1/fs/vfat/Makefile~fat_kill_export	2002-11-03 03:40:37.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/fs/vfat/Makefile	2002-11-03 03:40:38.000000000 +0900
@@ -2,10 +2,6 @@
 # Makefile for the linux vfat-filesystem routines.
 #
 
-export-objs := vfatfs_syms.o
+vfat-objs		:= namei.o
 
-obj-$(CONFIG_VFAT_FS) += vfat.o
-
-vfat-objs := namei.o vfatfs_syms.o
-
-include $(TOPDIR)/Rules.make
+obj-$(CONFIG_VFAT_FS)	+= vfat.o
--- fat-2.5.45-bk1/fs/vfat/namei.c~fat_kill_export	2002-11-03 03:40:37.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/fs/vfat/namei.c	2002-11-03 03:40:38.000000000 +0900
@@ -16,7 +16,6 @@
  */
 
 #include <linux/module.h>
-
 #include <linux/jiffies.h>
 #include <linux/msdos_fs.h>
 #include <linux/ctype.h>
@@ -24,6 +23,10 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VFAT filesystem driver");
+MODULE_AUTHOR("Gordon Chaffee, Werner Almesberger");
+
 #define DEBUG_LEVEL 0
 #if (DEBUG_LEVEL >= 1)
 #  define PRINTK1(x) printk x
@@ -859,7 +862,7 @@ static int vfat_find(struct inode *dir,s
 	return res ? res : -ENOENT;
 }
 
-struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry)
+static struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -911,7 +914,7 @@ error:
 	return dentry;
 }
 
-int vfat_create(struct inode *dir,struct dentry* dentry,int mode)
+static int vfat_create(struct inode *dir,struct dentry* dentry,int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -967,7 +970,7 @@ static void vfat_remove_entry(struct ino
 	brelse(bh);
 }
 
-int vfat_rmdir(struct inode *dir,struct dentry* dentry)
+static int vfat_rmdir(struct inode *dir,struct dentry* dentry)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -998,7 +1001,7 @@ int vfat_rmdir(struct inode *dir,struct 
 	return 0;
 }
 
-int vfat_unlink(struct inode *dir, struct dentry* dentry)
+static int vfat_unlink(struct inode *dir, struct dentry* dentry)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -1025,7 +1028,7 @@ int vfat_unlink(struct inode *dir, struc
 }
 
 
-int vfat_mkdir(struct inode *dir,struct dentry* dentry,int mode)
+static int vfat_mkdir(struct inode *dir,struct dentry* dentry,int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -1073,7 +1076,7 @@ mkdir_failed:
 	return res;
 }
  
-int vfat_rename(struct inode *old_dir,struct dentry *old_dentry,
+static int vfat_rename(struct inode *old_dir,struct dentry *old_dentry,
 		struct inode *new_dir,struct dentry *new_dentry)
 {
 	struct buffer_head *old_bh,*new_bh,*dotdot_bh;
@@ -1160,7 +1163,7 @@ rename_done:
 
 
 /* Public inode operations for the VFAT fs */
-struct inode_operations vfat_dir_inode_operations = {
+static struct inode_operations vfat_dir_inode_operations = {
 	.create		= vfat_create,
 	.lookup		= vfat_lookup,
 	.unlink		= vfat_unlink,
@@ -1170,7 +1173,7 @@ struct inode_operations vfat_dir_inode_o
 	.setattr	= fat_notify_change,
 };
 
-int vfat_fill_super(struct super_block *sb, void *data, int silent)
+static int vfat_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int res;
 
@@ -1185,3 +1188,31 @@ int vfat_fill_super(struct super_block *
 
 	return 0;
 }
+
+static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
+	int flags, char *dev_name, void *data)
+{
+	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
+}
+
+static struct file_system_type vfat_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "vfat",
+	.get_sb		= vfat_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
+};
+
+
+static int __init init_vfat_fs(void)
+{
+	return register_filesystem(&vfat_fs_type);
+}
+
+static void __exit exit_vfat_fs(void)
+{
+	unregister_filesystem(&vfat_fs_type);
+}
+
+module_init(init_vfat_fs)
+module_exit(exit_vfat_fs)
--- fat-2.5.45-bk1/fs/vfat/vfatfs_syms.c
+++ /dev/null	2002-07-27 03:36:37.000000000 +0900
@@ -1,47 +0,0 @@
-/*
- * linux/fs/msdos/vfatfs_syms.c
- *
- * Exported kernel symbols for the VFAT filesystem.
- * These symbols are used by dmsdos.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/mm.h>
-#include <linux/msdos_fs.h>
-
-static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
-{
-	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
-}
-
-static struct file_system_type vfat_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "vfat",
-	.get_sb		= vfat_get_sb,
-	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
-};
-
-EXPORT_SYMBOL(vfat_create);
-EXPORT_SYMBOL(vfat_unlink);
-EXPORT_SYMBOL(vfat_mkdir);
-EXPORT_SYMBOL(vfat_rmdir);
-EXPORT_SYMBOL(vfat_rename);
-EXPORT_SYMBOL(vfat_lookup);
-
-static int __init init_vfat_fs(void)
-{
-	return register_filesystem(&vfat_fs_type);
-}
-
-static void __exit exit_vfat_fs(void)
-{
-	unregister_filesystem(&vfat_fs_type);
-}
-
-module_init(init_vfat_fs)
-module_exit(exit_vfat_fs)
-MODULE_LICENSE("GPL");
--- fat-2.5.45-bk1/include/linux/msdos_fs.h~fat_kill_export	2002-11-03 03:40:38.000000000 +0900
+++ fat-2.5.45-bk1-hirofumi/include/linux/msdos_fs.h	2002-11-03 03:40:38.000000000 +0900
@@ -373,29 +373,5 @@ extern int fat_scan(struct inode *dir, c
 		    struct buffer_head **res_bh,
 		    struct msdos_dir_entry **res_de, int *ino);
 
-/* msdos/namei.c  - these are for Umsdos */
-extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *);
-extern int msdos_create(struct inode *dir, struct dentry *dentry, int mode);
-extern int msdos_rmdir(struct inode *dir, struct dentry *dentry);
-extern int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode);
-extern int msdos_unlink(struct inode *dir, struct dentry *dentry);
-extern int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry);
-extern int msdos_fill_super(struct super_block *sb, void *data, int silent);
-
-/* vfat/namei.c - these are for dmsdos */
-extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *);
-extern int vfat_create(struct inode *dir, struct dentry *dentry, int mode);
-extern int vfat_rmdir(struct inode *dir, struct dentry *dentry);
-extern int vfat_unlink(struct inode *dir, struct dentry *dentry);
-extern int vfat_mkdir(struct inode *dir, struct dentry *dentry, int mode);
-extern int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry);
-extern int vfat_fill_super(struct super_block *sb, void *data, int silent);
-
-/* vfat/vfatfs_syms.c */
-extern struct file_system_type vfat_fs_type;
-
 #endif /* __KERNEL__ */
-
-#endif
+#endif /* _LINUX_MSDOS_FS_H */

.

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

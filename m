Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUEBNN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUEBNN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUEBNN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:13:56 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:24844 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263041AbUEBNM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:12:59 -0400
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: remove symbols exports from msdosfs/vfat (4/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 May 2004 22:12:52 +0900
Message-ID: <87r7u3rmzv.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    From Christoph Hellwig <hch@lst.de>

If we're ever going to ressurect umsdos it should be a stackable
filesystem..

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>





 fs/msdos/Makefile        |    2 -
 fs/msdos/namei.c         |   56 ++++++++++++++++++++++++++++++++++-------------
 fs/vfat/Makefile         |    2 -
 fs/vfat/namei.c          |   53 ++++++++++++++++++++++++++++++++++----------
 include/linux/msdos_fs.h |   23 -------------------
 fs/msdos/msdosfs_syms.c  |   53 --------------------------------------------
 fs/vfat/vfatfs_syms.c    |   47 ---------------------------------------
 7 files changed, 84 insertions(+), 152 deletions(-)

diff -puN fs/msdos/Makefile~fat_unexport-symbols fs/msdos/Makefile
--- linux-2.6.6-rc3/fs/msdos/Makefile~fat_unexport-symbols	2004-05-02 19:15:47.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/msdos/Makefile	2004-05-02 19:15:47.000000000 +0900
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_MSDOS_FS) += msdos.o
 
-msdos-objs := namei.o msdosfs_syms.o
+msdos-y := namei.o
diff -puN -L fs/msdos/msdosfs_syms.c fs/msdos/msdosfs_syms.c~fat_unexport-symbols /dev/null
--- linux-2.6.6-rc3/fs/msdos/msdosfs_syms.c
+++ /dev/null	2004-04-14 22:04:04.000000000 +0900
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
-	int flags, const char *dev_name, void *data)
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
diff -puN fs/msdos/namei.c~fat_unexport-symbols fs/msdos/namei.c
--- linux-2.6.6-rc3/fs/msdos/namei.c~fat_unexport-symbols	2004-05-02 19:15:47.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/msdos/namei.c	2004-05-02 19:15:47.000000000 +0900
@@ -193,7 +193,8 @@ static struct dentry_operations msdos_de
  */
 
 /***** Get inode using directory and name */
-struct dentry *msdos_lookup(struct inode *dir,struct dentry *dentry, struct nameidata *nd)
+static struct dentry *msdos_lookup(struct inode *dir, struct dentry *dentry,
+		struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -257,12 +258,8 @@ static int msdos_add_entry(struct inode 
 	return 0;
 }
 
-/*
- * AV. Huh??? It's exported. Oughtta check usage.
- */
-
 /***** Create a file */
-int msdos_create(struct inode *dir,struct dentry *dentry,int mode,
+static int msdos_create(struct inode *dir, struct dentry *dentry, int mode,
 		struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
@@ -307,7 +304,7 @@ int msdos_create(struct inode *dir,struc
 }
 
 /***** Remove a directory */
-int msdos_rmdir(struct inode *dir, struct dentry *dentry)
+static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	loff_t i_pos;
@@ -346,7 +343,7 @@ rmdir_done:
 }
 
 /***** Make a directory */
-int msdos_mkdir(struct inode *dir,struct dentry *dentry,int mode)
+static int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
@@ -413,7 +410,7 @@ out_exist:
 }
 
 /***** Unlink a file */
-int msdos_unlink( struct inode *dir, struct dentry *dentry)
+static int msdos_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	loff_t i_pos;
@@ -539,8 +536,8 @@ degenerate_case:
 }
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
-int msdos_rename(struct inode *old_dir,struct dentry *old_dentry,
-		 struct inode *new_dir,struct dentry *new_dentry)
+static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *old_bh;
 	struct msdos_dir_entry *old_de;
@@ -576,9 +573,7 @@ rename_done:
 	return error;
 }
 
-
-/* The public inode operations for the msdos fs */
-struct inode_operations msdos_dir_inode_operations = {
+static struct inode_operations msdos_dir_inode_operations = {
 	.create		= msdos_create,
 	.lookup		= msdos_lookup,
 	.unlink		= msdos_unlink,
@@ -588,7 +583,7 @@ struct inode_operations msdos_dir_inode_
 	.setattr	= fat_notify_change,
 };
 
-int msdos_fill_super(struct super_block *sb,void *data, int silent)
+static int msdos_fill_super(struct super_block *sb,void *data, int silent)
 {
 	int res;
 
@@ -599,3 +594,34 @@ int msdos_fill_super(struct super_block 
 	sb->s_root->d_op = &msdos_dentry_operations;
 	return 0;
 }
+
+static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
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
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Werner Almesberger");
+MODULE_DESCRIPTION("MS-DOS filesystem support");
+
+module_init(init_msdos_fs)
+module_exit(exit_msdos_fs)
diff -puN fs/vfat/Makefile~fat_unexport-symbols fs/vfat/Makefile
--- linux-2.6.6-rc3/fs/vfat/Makefile~fat_unexport-symbols	2004-05-02 19:15:47.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/vfat/Makefile	2004-05-02 19:15:47.000000000 +0900
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_VFAT_FS) += vfat.o
 
-vfat-objs := namei.o vfatfs_syms.o
+vfat-y := namei.o
diff -puN fs/vfat/namei.c~fat_unexport-symbols fs/vfat/namei.c
--- linux-2.6.6-rc3/fs/vfat/namei.c~fat_unexport-symbols	2004-05-02 19:15:47.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/vfat/namei.c	2004-05-02 19:15:47.000000000 +0900
@@ -805,7 +805,8 @@ static int vfat_find(struct inode *dir,s
 	return res ? res : -ENOENT;
 }
 
-struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry, struct nameidata *nd)
+static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
+		struct nameidata *nd)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -854,7 +855,7 @@ error:
 	return dentry;
 }
 
-int vfat_create(struct inode *dir,struct dentry* dentry,int mode,
+static int vfat_create(struct inode *dir, struct dentry* dentry, int mode,
 		struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
@@ -908,7 +909,7 @@ static void vfat_remove_entry(struct ino
 	brelse(bh);
 }
 
-int vfat_rmdir(struct inode *dir,struct dentry* dentry)
+static int vfat_rmdir(struct inode *dir, struct dentry* dentry)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -936,7 +937,7 @@ out:
 	return res;
 }
 
-int vfat_unlink(struct inode *dir, struct dentry* dentry)
+static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -959,8 +960,7 @@ out:
 	return res;
 }
 
-
-int vfat_mkdir(struct inode *dir,struct dentry* dentry,int mode)
+static int vfat_mkdir(struct inode *dir,struct dentry* dentry,int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -1005,8 +1005,8 @@ mkdir_failed:
 	goto out;
 }
  
-int vfat_rename(struct inode *old_dir,struct dentry *old_dentry,
-		struct inode *new_dir,struct dentry *new_dentry)
+static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *old_bh,*new_bh,*dotdot_bh;
 	struct msdos_dir_entry *old_de,*new_de,*dotdot_de;
@@ -1094,9 +1094,7 @@ rename_done:
 
 }
 
-
-/* Public inode operations for the VFAT fs */
-struct inode_operations vfat_dir_inode_operations = {
+static struct inode_operations vfat_dir_inode_operations = {
 	.create		= vfat_create,
 	.lookup		= vfat_lookup,
 	.unlink		= vfat_unlink,
@@ -1106,7 +1104,7 @@ struct inode_operations vfat_dir_inode_o
 	.setattr	= fat_notify_change,
 };
 
-int vfat_fill_super(struct super_block *sb, void *data, int silent)
+static int vfat_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int res;
 
@@ -1121,3 +1119,34 @@ int vfat_fill_super(struct super_block *
 
 	return 0;
 }
+
+static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VFAT filesystem support");
+MODULE_AUTHOR("Gordon Chaffee");
+
+module_init(init_vfat_fs)
+module_exit(exit_vfat_fs)
diff -puN -L fs/vfat/vfatfs_syms.c fs/vfat/vfatfs_syms.c~fat_unexport-symbols /dev/null
--- linux-2.6.6-rc3/fs/vfat/vfatfs_syms.c
+++ /dev/null	2004-04-14 22:04:04.000000000 +0900
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
-	int flags, const char *dev_name, void *data)
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
diff -puN include/linux/msdos_fs.h~fat_unexport-symbols include/linux/msdos_fs.h
--- linux-2.6.6-rc3/include/linux/msdos_fs.h~fat_unexport-symbols	2004-05-02 19:15:47.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/include/linux/msdos_fs.h	2004-05-02 19:15:47.000000000 +0900
@@ -309,29 +309,6 @@ static __inline__ int fat_get_entry(stru
 	return fat__get_entry(dir, pos, bh, de, i_pos);
 }
 
-/* msdos/namei.c  - these are for Umsdos */
-extern struct dentry *msdos_lookup(struct inode *dir, struct dentry *, struct nameidata *);
-extern int msdos_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *);
-extern int msdos_rmdir(struct inode *dir, struct dentry *dentry);
-extern int msdos_mkdir(struct inode *dir, struct dentry *dentry, int mode);
-extern int msdos_unlink(struct inode *dir, struct dentry *dentry);
-extern int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry);
-extern int msdos_fill_super(struct super_block *sb, void *data, int silent);
-
-/* vfat/namei.c - these are for dmsdos */
-extern struct dentry *vfat_lookup(struct inode *dir, struct dentry *, struct nameidata *);
-extern int vfat_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *);
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
 
 #endif

_

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282838AbRLBLbi>; Sun, 2 Dec 2001 06:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282839AbRLBLbc>; Sun, 2 Dec 2001 06:31:32 -0500
Received: from mail209.mail.bellsouth.net ([205.152.58.149]:10830 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282838AbRLBLbX>; Sun, 2 Dec 2001 06:31:23 -0500
Message-ID: <3C0A1105.18B76D64@mandrakesoft.com>
Date: Sun, 02 Dec 2001 06:31:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.17.2: make ext2 smaller
Content-Type: multipart/mixed;
 boundary="------------E9C65426C09668E6D2F566D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E9C65426C09668E6D2F566D1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I do not plan to submit this patch to Linus/Marcelo.

This patch applies an obvious technique to the kernel:  increase the
amount of code compiled in a single compilation unit, to increase the
overall knowledge the compiler has of the code, to allow for better
optimization and dead code removal.  KDE does this, with definite
success, though they definitely are not the first to do this.

Simply, all ext2 files are #include'd into a single file, ext2_all.c,
and all functions and data structures are declared static.

This technique can be used in the kernel, userspace applications, and
userspace libraries to decrease icache footprint and overall size of
your applications.

Results from 2.4.17-pre2 plus the attached patch:  1135 bytes saved in
vmlinux, simply from making all the functions static.
(*.orig is prior to my patch.  kernel is P2 SMP-based)
> [jgarzik@rum linux-e2all]$ ls -l vmlinux* arch/i386/boot/bzImage*
> -rw-r--r--    1 jgarzik  jgarzik   1030259 Dec  2 06:18 arch/i386/boot/bzImage
> -rw-r--r--    1 jgarzik  jgarzik   1030263 Dec  2 06:04 arch/i386/boot/bzImage.orig
> -rwxr-xr-x    1 jgarzik  jgarzik   2814631 Dec  2 06:18 vmlinux*
> -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 06:04 vmlinux.orig*

I can only imagine the large amount of space savings if large drivers
like ACPI or reiserfs or aic7xxx use this technique.

Maybe a global CONFIG_FINAL flag could enable *_all.c compilation for
various drivers and subsystems.  Functions not unconditionally static
would be marked KSTATIC.  [obviously the size of the compilation unit
must not be larger than a single driver or subsystem, due to potential
namespace collisions]

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------E9C65426C09668E6D2F566D1
Content-Type: text/plain; charset=us-ascii;
 name="ext2-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext2-small.patch"

diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/include/linux/ext2_fs.h linux-e2all/include/linux/ext2_fs.h
--- linux-2.4.17-pre2/include/linux/ext2_fs.h	Thu Nov 22 19:46:52 2001
+++ linux-e2all/include/linux/ext2_fs.h	Sun Dec  2 11:04:09 2001
@@ -16,6 +16,10 @@
 #ifndef _LINUX_EXT2_FS_H
 #define _LINUX_EXT2_FS_H
 
+#ifndef E2STATIC
+#define E2STATIC
+#endif
+
 #include <linux/types.h>
 
 /*
@@ -546,86 +550,86 @@
 # define NORET_AND     noreturn,
 
 /* balloc.c */
-extern int ext2_bg_has_super(struct super_block *sb, int group);
-extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern int ext2_new_block (struct inode *, unsigned long,
+E2STATIC int ext2_bg_has_super(struct super_block *sb, int group);
+E2STATIC unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
+E2STATIC int ext2_new_block (struct inode *, unsigned long,
 			   __u32 *, __u32 *, int *);
-extern void ext2_free_blocks (struct inode *, unsigned long,
+E2STATIC void ext2_free_blocks (struct inode *, unsigned long,
 			      unsigned long);
-extern unsigned long ext2_count_free_blocks (struct super_block *);
-extern void ext2_check_blocks_bitmap (struct super_block *);
-extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
+E2STATIC unsigned long ext2_count_free_blocks (struct super_block *);
+E2STATIC void ext2_check_blocks_bitmap (struct super_block *);
+E2STATIC struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,
 						    struct buffer_head ** bh);
 
 /* dir.c */
-extern int ext2_add_link (struct dentry *, struct inode *);
-extern ino_t ext2_inode_by_name(struct inode *, struct dentry *);
-extern int ext2_make_empty(struct inode *, struct inode *);
-extern struct ext2_dir_entry_2 * ext2_find_entry (struct inode *,struct dentry *, struct page **);
-extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
-extern int ext2_empty_dir (struct inode *);
-extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
-extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *);
+E2STATIC int ext2_add_link (struct dentry *, struct inode *);
+E2STATIC ino_t ext2_inode_by_name(struct inode *, struct dentry *);
+E2STATIC int ext2_make_empty(struct inode *, struct inode *);
+E2STATIC struct ext2_dir_entry_2 * ext2_find_entry (struct inode *,struct dentry *, struct page **);
+E2STATIC int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
+E2STATIC int ext2_empty_dir (struct inode *);
+E2STATIC struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
+E2STATIC void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *);
 
 /* fsync.c */
-extern int ext2_sync_file (struct file *, struct dentry *, int);
-extern int ext2_fsync_inode (struct inode *, int);
+E2STATIC int ext2_sync_file (struct file *, struct dentry *, int);
+E2STATIC int ext2_fsync_inode (struct inode *, int);
 
 /* ialloc.c */
-extern struct inode * ext2_new_inode (const struct inode *, int);
-extern void ext2_free_inode (struct inode *);
-extern unsigned long ext2_count_free_inodes (struct super_block *);
-extern void ext2_check_inodes_bitmap (struct super_block *);
-extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
+E2STATIC struct inode * ext2_new_inode (const struct inode *, int);
+E2STATIC void ext2_free_inode (struct inode *);
+E2STATIC unsigned long ext2_count_free_inodes (struct super_block *);
+E2STATIC void ext2_check_inodes_bitmap (struct super_block *);
+E2STATIC unsigned long ext2_count_free (struct buffer_head *, unsigned);
 
 /* inode.c */
-extern void ext2_read_inode (struct inode *);
-extern void ext2_write_inode (struct inode *, int);
-extern void ext2_put_inode (struct inode *);
-extern void ext2_delete_inode (struct inode *);
-extern int ext2_sync_inode (struct inode *);
-extern void ext2_discard_prealloc (struct inode *);
-extern void ext2_truncate (struct inode *);
+E2STATIC void ext2_read_inode (struct inode *);
+E2STATIC void ext2_write_inode (struct inode *, int);
+E2STATIC void ext2_put_inode (struct inode *);
+E2STATIC void ext2_delete_inode (struct inode *);
+E2STATIC int ext2_sync_inode (struct inode *);
+E2STATIC void ext2_discard_prealloc (struct inode *);
+E2STATIC void ext2_truncate (struct inode *);
 
 /* ioctl.c */
-extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
+E2STATIC int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
 
 /* super.c */
-extern void ext2_error (struct super_block *, const char *, const char *, ...)
+E2STATIC void ext2_error (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
-extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
+E2STATIC NORET_TYPE void ext2_panic (struct super_block *, const char *,
 				   const char *, ...)
 	__attribute__ ((NORET_AND format (printf, 3, 4)));
-extern void ext2_warning (struct super_block *, const char *, const char *, ...)
+E2STATIC void ext2_warning (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
-extern void ext2_update_dynamic_rev (struct super_block *sb);
-extern void ext2_put_super (struct super_block *);
-extern void ext2_write_super (struct super_block *);
-extern int ext2_remount (struct super_block *, int *, char *);
-extern struct super_block * ext2_read_super (struct super_block *,void *,int);
-extern int ext2_statfs (struct super_block *, struct statfs *);
+E2STATIC void ext2_update_dynamic_rev (struct super_block *sb);
+E2STATIC void ext2_put_super (struct super_block *);
+E2STATIC void ext2_write_super (struct super_block *);
+E2STATIC int ext2_remount (struct super_block *, int *, char *);
+E2STATIC struct super_block * ext2_read_super (struct super_block *,void *,int);
+E2STATIC int ext2_statfs (struct super_block *, struct statfs *);
 
 /*
  * Inodes and files operations
  */
 
 /* dir.c */
-extern struct file_operations ext2_dir_operations;
+E2STATIC struct file_operations ext2_dir_operations;
 
 /* file.c */
-extern struct inode_operations ext2_file_inode_operations;
-extern struct file_operations ext2_file_operations;
+E2STATIC struct inode_operations ext2_file_inode_operations;
+E2STATIC struct file_operations ext2_file_operations;
 
 /* inode.c */
-extern struct address_space_operations ext2_aops;
+E2STATIC struct address_space_operations ext2_aops;
 
 /* namei.c */
-extern struct inode_operations ext2_dir_inode_operations;
+E2STATIC struct inode_operations ext2_dir_inode_operations;
 
 /* symlink.c */
-extern struct inode_operations ext2_fast_symlink_inode_operations;
+E2STATIC struct inode_operations ext2_fast_symlink_inode_operations;
 
 #endif	/* __KERNEL__ */
 
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/Config.in linux-e2all/fs/Config.in
--- linux-2.4.17-pre2/fs/Config.in	Mon Nov 12 17:34:16 2001
+++ linux-e2all/fs/Config.in	Sun Dec  2 11:04:51 2001
@@ -77,6 +77,9 @@
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
 tristate 'Second extended fs support' CONFIG_EXT2_FS
+if [ "$CONFIG_EXT2_FS" = "y" -o "$CONFIG_EXT2_FS" = "m" ]; then
+   bool '  Memory-intensive final production build' CONFIG_EXT2_FS_FINAL
+fi
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/Makefile linux-e2all/fs/ext2/Makefile
--- linux-2.4.17-pre2/fs/ext2/Makefile	Thu Oct 11 15:05:18 2001
+++ linux-e2all/fs/ext2/Makefile	Sun Dec  2 10:55:43 2001
@@ -9,8 +9,14 @@
 
 O_TARGET := ext2.o
 
+
+ifdef CONFIG_EXT2_FS_FINAL
+obj-y	 := ext2_all.o
+else
 obj-y    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 		ioctl.o namei.o super.o symlink.o
+endif
+
 obj-m    := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/balloc.c linux-e2all/fs/ext2/balloc.c
--- linux-2.4.17-pre2/fs/ext2/balloc.c	Fri Oct  5 19:23:53 2001
+++ linux-e2all/fs/ext2/balloc.c	Sun Dec  2 10:58:08 2001
@@ -35,7 +35,7 @@
 
 #define in_range(b, first, len)		((b) >= (first) && (b) <= (first) + (len) - 1)
 
-struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
+E2STATIC struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 					     unsigned int block_group,
 					     struct buffer_head ** bh)
 {
@@ -248,7 +248,7 @@
 }
 
 /* Free given blocks, update quota and i_blocks field */
-void ext2_free_blocks (struct inode * inode, unsigned long block,
+E2STATIC void ext2_free_blocks (struct inode * inode, unsigned long block,
 		       unsigned long count)
 {
 	struct buffer_head * bh;
@@ -354,7 +354,7 @@
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext2_new_block (struct inode * inode, unsigned long goal,
+E2STATIC int ext2_new_block (struct inode * inode, unsigned long goal,
     u32 * prealloc_count, u32 * prealloc_block, int * err)
 {
 	struct buffer_head * bh;
@@ -614,7 +614,7 @@
 	
 }
 
-unsigned long ext2_count_free_blocks (struct super_block * sb)
+E2STATIC unsigned long ext2_count_free_blocks (struct super_block * sb)
 {
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
@@ -673,7 +673,7 @@
 	}
 }
 
-int ext2_group_sparse(int group)
+E2STATIC int ext2_group_sparse(int group)
 {
 	return (test_root(group, 3) || test_root(group, 5) ||
 		test_root(group, 7));
@@ -687,7 +687,7 @@
  *	Return the number of blocks used by the superblock (primary or backup)
  *	in this group.  Currently this will be only 0 or 1.
  */
-int ext2_bg_has_super(struct super_block *sb, int group)
+E2STATIC int ext2_bg_has_super(struct super_block *sb, int group)
 {
 	if (EXT2_HAS_RO_COMPAT_FEATURE(sb,EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
 	    !ext2_group_sparse(group))
@@ -704,7 +704,7 @@
  *	(primary or backup) in this group.  In the future there may be a
  *	different number of descriptor blocks in each group.
  */
-unsigned long ext2_bg_num_gdb(struct super_block *sb, int group)
+E2STATIC unsigned long ext2_bg_num_gdb(struct super_block *sb, int group)
 {
 	if (EXT2_HAS_RO_COMPAT_FEATURE(sb,EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
 	    !ext2_group_sparse(group))
@@ -714,7 +714,7 @@
 
 #ifdef CONFIG_EXT2_CHECK
 /* Called at mount-time, super-block is locked */
-void ext2_check_blocks_bitmap (struct super_block * sb)
+E2STATIC void ext2_check_blocks_bitmap (struct super_block * sb)
 {
 	struct buffer_head * bh;
 	struct ext2_super_block * es;
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/bitmap.c linux-e2all/fs/ext2/bitmap.c
--- linux-2.4.17-pre2/fs/ext2/bitmap.c	Wed Sep 27 20:41:33 2000
+++ linux-e2all/fs/ext2/bitmap.c	Sun Dec  2 11:17:37 2001
@@ -10,10 +10,11 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 
+#ifdef EXT2FS_DEBUG
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
 
-unsigned long ext2_count_free (struct buffer_head * map, unsigned int numchars)
+E2STATIC unsigned long ext2_count_free (struct buffer_head * map, unsigned int numchars)
 {
 	unsigned int i;
 	unsigned long sum = 0;
@@ -25,3 +26,5 @@
 			nibblemap[(map->b_data[i] >> 4) & 0xf];
 	return (sum);
 }
+
+#endif /* EXT2FS_DEBUG */
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/dir.c linux-e2all/fs/ext2/dir.c
--- linux-2.4.17-pre2/fs/ext2/dir.c	Mon Sep 17 20:16:30 2001
+++ linux-e2all/fs/ext2/dir.c	Sun Dec  2 11:00:01 2001
@@ -297,7 +297,7 @@
  * (as a parameter - res_dir). Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
  */
-struct ext2_dir_entry_2 * ext2_find_entry (struct inode * dir,
+E2STATIC struct ext2_dir_entry_2 * ext2_find_entry (struct inode * dir,
 			struct dentry *dentry, struct page ** res_page)
 {
 	const char *name = dentry->d_name.name;
@@ -340,7 +340,7 @@
 	return de;
 }
 
-struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
+E2STATIC struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
 {
 	struct page *page = ext2_get_page(dir, 0);
 	ext2_dirent *de = NULL;
@@ -352,7 +352,7 @@
 	return de;
 }
 
-ino_t ext2_inode_by_name(struct inode * dir, struct dentry *dentry)
+E2STATIC ino_t ext2_inode_by_name(struct inode * dir, struct dentry *dentry)
 {
 	ino_t res = 0;
 	struct ext2_dir_entry_2 * de;
@@ -368,7 +368,7 @@
 }
 
 /* Releases the page */
-void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
+E2STATIC void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 			struct page *page, struct inode *inode)
 {
 	unsigned from = (char *) de - (char *) page_address(page);
@@ -391,7 +391,7 @@
 /*
  *	Parent is locked.
  */
-int ext2_add_link (struct dentry *dentry, struct inode *inode)
+E2STATIC int ext2_add_link (struct dentry *dentry, struct inode *inode)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
 	const char *name = dentry->d_name.name;
@@ -465,7 +465,7 @@
  * ext2_delete_entry deletes a directory entry by merging it with the
  * previous entry. Page is up-to-date. Releases the page.
  */
-int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
+E2STATIC int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
@@ -500,7 +500,7 @@
 /*
  * Set the first fragment of directory.
  */
-int ext2_make_empty(struct inode *inode, struct inode *parent)
+E2STATIC int ext2_make_empty(struct inode *inode, struct inode *parent)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page = grab_cache_page(mapping, 0);
@@ -541,7 +541,7 @@
 /*
  * routine to check that the specified directory is empty (for rmdir)
  */
-int ext2_empty_dir (struct inode * inode)
+E2STATIC int ext2_empty_dir (struct inode * inode)
 {
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
@@ -583,7 +583,7 @@
 	return 0;
 }
 
-struct file_operations ext2_dir_operations = {
+E2STATIC struct file_operations ext2_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	ext2_readdir,
 	ioctl:		ext2_ioctl,
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/ext2_all.c linux-e2all/fs/ext2/ext2_all.c
--- linux-2.4.17-pre2/fs/ext2/ext2_all.c	Thu Jan  1 00:00:00 1970
+++ linux-e2all/fs/ext2/ext2_all.c	Sun Dec  2 11:13:49 2001
@@ -0,0 +1,12 @@
+#define E2STATIC static
+#include "balloc.c"
+#include "bitmap.c"
+#include "dir.c"
+#include "file.c"
+#include "fsync.c"
+#include "ialloc.c"
+#include "inode.c"
+#include "ioctl.c"
+#include "namei.c"
+#include "super.c"
+#include "symlink.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/file.c linux-e2all/fs/ext2/file.c
--- linux-2.4.17-pre2/fs/ext2/file.c	Thu Oct 11 15:05:18 2001
+++ linux-e2all/fs/ext2/file.c	Sun Dec  2 11:02:54 2001
@@ -38,7 +38,7 @@
  * We have mostly NULL's here: the current defaults are ok for
  * the ext2 filesystem.
  */
-struct file_operations ext2_file_operations = {
+E2STATIC struct file_operations ext2_file_operations = {
 	llseek:		generic_file_llseek,
 	read:		generic_file_read,
 	write:		generic_file_write,
@@ -49,6 +49,6 @@
 	fsync:		ext2_sync_file,
 };
 
-struct inode_operations ext2_file_inode_operations = {
+E2STATIC struct inode_operations ext2_file_inode_operations = {
 	truncate:	ext2_truncate,
 };
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/fsync.c linux-e2all/fs/ext2/fsync.c
--- linux-2.4.17-pre2/fs/ext2/fsync.c	Mon Sep 17 20:16:30 2001
+++ linux-e2all/fs/ext2/fsync.c	Sun Dec  2 11:02:43 2001
@@ -33,13 +33,13 @@
  *	even pass file to fsync ?
  */
 
-int ext2_sync_file(struct file * file, struct dentry *dentry, int datasync)
+E2STATIC int ext2_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	struct inode *inode = dentry->d_inode;
 	return ext2_fsync_inode(inode, datasync);
 }
 
-int ext2_fsync_inode(struct inode *inode, int datasync)
+E2STATIC int ext2_fsync_inode(struct inode *inode, int datasync)
 {
 	int err;
 	
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/ialloc.c linux-e2all/fs/ext2/ialloc.c
--- linux-2.4.17-pre2/fs/ext2/ialloc.c	Sun Nov 11 17:59:56 2001
+++ linux-e2all/fs/ext2/ialloc.c	Sun Dec  2 11:02:35 2001
@@ -147,7 +147,7 @@
  * though), and then we'd have two inodes sharing the
  * same inode number and space on the harddisk.
  */
-void ext2_free_inode (struct inode * inode)
+E2STATIC void ext2_free_inode (struct inode * inode)
 {
 	struct super_block * sb = inode->i_sb;
 	int is_directory;
@@ -312,7 +312,7 @@
 	return group;
 }
 
-struct inode * ext2_new_inode (const struct inode * dir, int mode)
+E2STATIC struct inode * ext2_new_inode (const struct inode * dir, int mode)
 {
 	struct super_block * sb;
 	struct buffer_head * bh;
@@ -437,7 +437,7 @@
 	goto repeat;
 }
 
-unsigned long ext2_count_free_inodes (struct super_block * sb)
+E2STATIC unsigned long ext2_count_free_inodes (struct super_block * sb)
 {
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
@@ -474,7 +474,7 @@
 
 #ifdef CONFIG_EXT2_CHECK
 /* Called at mount-time, super-block is locked */
-void ext2_check_inodes_bitmap (struct super_block * sb)
+E2STATIC void ext2_check_inodes_bitmap (struct super_block * sb)
 {
 	struct ext2_super_block * es = sb->u.ext2_sb.s_es;
 	unsigned long desc_count = 0, bitmap_count = 0;
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/inode.c linux-e2all/fs/ext2/inode.c
--- linux-2.4.17-pre2/fs/ext2/inode.c	Wed Nov 21 22:07:25 2001
+++ linux-e2all/fs/ext2/inode.c	Sun Dec  2 11:02:11 2001
@@ -41,7 +41,7 @@
 /*
  * Called at each iput()
  */
-void ext2_put_inode (struct inode * inode)
+E2STATIC void ext2_put_inode (struct inode * inode)
 {
 	ext2_discard_prealloc (inode);
 }
@@ -49,7 +49,7 @@
 /*
  * Called at the last iput() if i_nlink is zero.
  */
-void ext2_delete_inode (struct inode * inode)
+E2STATIC void ext2_delete_inode (struct inode * inode)
 {
 	lock_kernel();
 
@@ -72,7 +72,7 @@
 	clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
-void ext2_discard_prealloc (struct inode * inode)
+E2STATIC void ext2_discard_prealloc (struct inode * inode)
 {
 #ifdef EXT2_PREALLOCATE
 	lock_kernel();
@@ -596,7 +596,7 @@
 {
 	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, ext2_get_block);
 }
-struct address_space_operations ext2_aops = {
+E2STATIC struct address_space_operations ext2_aops = {
 	readpage: ext2_readpage,
 	writepage: ext2_writepage,
 	sync_page: block_sync_page,
@@ -786,7 +786,7 @@
 		ext2_free_data(inode, p, q);
 }
 
-void ext2_truncate (struct inode * inode)
+E2STATIC void ext2_truncate (struct inode * inode)
 {
 	u32 *i_data = inode->u.ext2_i.i_data;
 	int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
@@ -879,7 +879,7 @@
 		mark_inode_dirty(inode);
 }
 
-void ext2_read_inode (struct inode * inode)
+E2STATIC void ext2_read_inode (struct inode * inode)
 {
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
@@ -1148,14 +1148,14 @@
 	return err;
 }
 
-void ext2_write_inode (struct inode * inode, int wait)
+E2STATIC void ext2_write_inode (struct inode * inode, int wait)
 {
 	lock_kernel();
 	ext2_update_inode (inode, wait);
 	unlock_kernel();
 }
 
-int ext2_sync_inode (struct inode *inode)
+E2STATIC int ext2_sync_inode (struct inode *inode)
 {
 	return ext2_update_inode (inode, 1);
 }
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/ioctl.c linux-e2all/fs/ext2/ioctl.c
--- linux-2.4.17-pre2/fs/ext2/ioctl.c	Wed Sep 27 20:41:33 2000
+++ linux-e2all/fs/ext2/ioctl.c	Sun Dec  2 11:01:29 2001
@@ -13,7 +13,7 @@
 #include <asm/uaccess.h>
 
 
-int ext2_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
+E2STATIC int ext2_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
 {
 	unsigned int flags;
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/namei.c linux-e2all/fs/ext2/namei.c
--- linux-2.4.17-pre2/fs/ext2/namei.c	Thu Oct  4 05:57:36 2001
+++ linux-e2all/fs/ext2/namei.c	Sun Dec  2 11:01:22 2001
@@ -335,7 +335,7 @@
 	return err;
 }
 
-struct inode_operations ext2_dir_inode_operations = {
+E2STATIC struct inode_operations ext2_dir_inode_operations = {
 	create:		ext2_create,
 	lookup:		ext2_lookup,
 	link:		ext2_link,
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/super.c linux-e2all/fs/ext2/super.c
--- linux-2.4.17-pre2/fs/ext2/super.c	Sat Dec  1 04:16:03 2001
+++ linux-e2all/fs/ext2/super.c	Sun Dec  2 11:01:09 2001
@@ -33,7 +33,7 @@
 
 static char error_buf[1024];
 
-void ext2_error (struct super_block * sb, const char * function,
+E2STATIC void ext2_error (struct super_block * sb, const char * function,
 		 const char * fmt, ...)
 {
 	va_list args;
@@ -63,7 +63,7 @@
 	}
 }
 
-NORET_TYPE void ext2_panic (struct super_block * sb, const char * function,
+NORET_TYPE E2STATIC void ext2_panic (struct super_block * sb, const char * function,
 			    const char * fmt, ...)
 {
 	va_list args;
@@ -83,7 +83,7 @@
 	       bdevname(sb->s_dev), function, error_buf);
 }
 
-void ext2_warning (struct super_block * sb, const char * function,
+E2STATIC void ext2_warning (struct super_block * sb, const char * function,
 		   const char * fmt, ...)
 {
 	va_list args;
@@ -95,7 +95,7 @@
 		bdevname(sb->s_dev), function, error_buf);
 }
 
-void ext2_update_dynamic_rev(struct super_block *sb)
+E2STATIC void ext2_update_dynamic_rev(struct super_block *sb)
 {
 	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
 
@@ -120,7 +120,7 @@
 	 */
 }
 
-void ext2_put_super (struct super_block * sb)
+E2STATIC void ext2_put_super (struct super_block * sb)
 {
 	int db_count;
 	int i;
@@ -397,7 +397,7 @@
 	return res;
 }
 
-struct super_block * ext2_read_super (struct super_block * sb, void * data,
+E2STATIC struct super_block * ext2_read_super (struct super_block * sb, void * data,
 				      int silent)
 {
 	struct buffer_head * bh;
@@ -685,7 +685,7 @@
  * set s_state to EXT2_VALID_FS after some corrections.
  */
 
-void ext2_write_super (struct super_block * sb)
+E2STATIC void ext2_write_super (struct super_block * sb)
 {
 	struct ext2_super_block * es;
 
@@ -704,7 +704,7 @@
 	sb->s_dirt = 0;
 }
 
-int ext2_remount (struct super_block * sb, int * flags, char * data)
+E2STATIC int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct ext2_super_block * es;
 	unsigned short resuid = sb->u.ext2_sb.s_resuid;
@@ -758,7 +758,7 @@
 	return 0;
 }
 
-int ext2_statfs (struct super_block * sb, struct statfs * buf)
+E2STATIC int ext2_statfs (struct super_block * sb, struct statfs * buf)
 {
 	unsigned long overhead;
 	int i;
@@ -820,5 +820,5 @@
 
 EXPORT_NO_SYMBOLS;
 
-module_init(init_ext2_fs)
-module_exit(exit_ext2_fs)
+module_init(init_ext2_fs);
+module_exit(exit_ext2_fs);
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/symlink.c linux-e2all/fs/ext2/symlink.c
--- linux-2.4.17-pre2/fs/ext2/symlink.c	Wed Sep 27 20:41:33 2000
+++ linux-e2all/fs/ext2/symlink.c	Sun Dec  2 11:00:10 2001
@@ -32,7 +32,7 @@
 	return vfs_follow_link(nd, s);
 }
 
-struct inode_operations ext2_fast_symlink_inode_operations = {
+E2STATIC struct inode_operations ext2_fast_symlink_inode_operations = {
 	readlink:	ext2_readlink,
 	follow_link:	ext2_follow_link,
 };

--------------E9C65426C09668E6D2F566D1--



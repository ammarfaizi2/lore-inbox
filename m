Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUJ3VgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUJ3VgT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUJ3VgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:36:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261337AbUJ3VeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:34:16 -0400
Date: Sat, 30 Oct 2004 23:33:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill fatfs_syms.c
Message-ID: <20041030213343.GZ4374@stusta.de>
References: <20041030014522.GH6677@stusta.de> <20041030063925.GB22838@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030063925.GB22838@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:39:25AM +0100, Christoph Hellwig wrote:

>...
> just move this to inode.c


Thanks for this suggestion.
An updated patch is below.


diffstat output:
 fs/fat/Makefile     |    2 -
 fs/fat/dir.c        |   11 ++++++++++
 fs/fat/fatfs_syms.c |   48 --------------------------------------------
 fs/fat/inode.c      |   35 ++++++++++++++++++++++++++++++++
 fs/fat/misc.c       |    4 +++
 5 files changed, 51 insertions(+), 49 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/fat/fatfs_syms.c	2004-10-30 01:25:27.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,48 +0,0 @@
-/*
- * linux/fs/fat/fatfs_syms.c
- *
- * Exported kernel symbols for the low-level FAT-based fs support.
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-
-#include <linux/mm.h>
-#include <linux/msdos_fs.h>
-
-EXPORT_SYMBOL(fat_new_dir);
-EXPORT_SYMBOL(fat_date_unix2dos);
-EXPORT_SYMBOL(fat__get_entry);
-EXPORT_SYMBOL(fat_notify_change);
-EXPORT_SYMBOL(fat_attach);
-EXPORT_SYMBOL(fat_detach);
-EXPORT_SYMBOL(fat_build_inode);
-EXPORT_SYMBOL(fat_fill_super);
-EXPORT_SYMBOL(fat_search_long);
-EXPORT_SYMBOL(fat_scan);
-EXPORT_SYMBOL(fat_add_entries);
-EXPORT_SYMBOL(fat_dir_empty);
-
-int __init fat_cache_init(void);
-void __exit fat_cache_destroy(void);
-int __init fat_init_inodecache(void);
-void __exit fat_destroy_inodecache(void);
-static int __init init_fat_fs(void)
-{
-	int ret;
-
-	ret = fat_cache_init();
-	if (ret < 0)
-		return ret;
-	return fat_init_inodecache();
-}
-
-static void __exit exit_fat_fs(void)
-{
-	fat_cache_destroy();
-	fat_destroy_inodecache();
-}
-
-module_init(init_fat_fs)
-module_exit(exit_fat_fs)
--- linux-2.6.10-rc1-mm2-full/fs/fat/dir.c.old	2004-10-30 01:30:08.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/fat/dir.c	2004-10-30 02:11:40.000000000 +0200
@@ -13,6 +13,7 @@
  *  Short name translation 1999, 2001 by Wolfram Pienkoss <wp@bszh.de>
  */
 
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
@@ -325,6 +326,8 @@
 	return res;
 }
 
+EXPORT_SYMBOL(fat_search_long);
+
 static int fat_readdirx(struct inode *inode, struct file *filp, void *dirent,
 			filldir_t filldir, int shortnames, int both)
 {
@@ -714,6 +717,8 @@
 	return offset;
 }
 
+EXPORT_SYMBOL(fat_add_entries);
+
 int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat)
 {
 	struct buffer_head *bh;
@@ -749,6 +754,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(fat_new_dir);
+
 static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de, loff_t *i_pos)
@@ -782,6 +789,8 @@
 	return result;
 }
 
+EXPORT_SYMBOL(fat_dir_empty);
+
 /*
  * fat_subdirs counts the number of sub-directories of dir. It can be run
  * on directories being created.
@@ -821,3 +830,5 @@
 	}
 	return -ENOENT;
 }
+
+EXPORT_SYMBOL(fat_scan);
--- linux-2.6.10-rc1-mm2-full/fs/fat/misc.c.old	2004-10-30 01:31:15.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/fat/misc.c	2004-10-30 02:12:11.000000000 +0200
@@ -6,6 +6,7 @@
  *		 and date_dos2unix for date==0 by Igor Zhbanov(bsg@uniyar.ac.ru)
  */
 
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
@@ -272,6 +273,7 @@
 	*date = cpu_to_le16(nl_day-day_n[month-1]+1+(month << 5)+(year << 9));
 }
 
+EXPORT_SYMBOL(fat_date_unix2dos);
 
 /* Returns the inode number of the directory entry at offset pos. If bh is
    non-NULL, it is brelse'd before. Pos is incremented. The buffer header is
@@ -320,3 +322,5 @@
 
 	return 0;
 }
+
+EXPORT_SYMBOL(fat__get_entry);
--- linux-2.6.10-rc1-mm2-full/fs/fat/Makefile.old	2004-10-30 20:23:31.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/fat/Makefile	2004-10-30 20:27:22.000000000 +0200
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := cache.o dir.o file.o inode.o misc.o fatfs_syms.o
+fat-objs := cache.o dir.o file.o inode.o misc.o
--- linux-2.6.10-rc1-mm2-full/fs/fat/inode.c.old	2004-10-30 20:23:31.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/fat/inode.c	2004-10-30 20:27:12.000000000 +0200
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
@@ -87,6 +88,8 @@
 	spin_unlock(&sbi->inode_hash_lock);
 }
 
+EXPORT_SYMBOL(fat_attach);
+
 void fat_detach(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
@@ -96,6 +99,8 @@
 	spin_unlock(&sbi->inode_hash_lock);
 }
 
+EXPORT_SYMBOL(fat_detach);
+
 struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
@@ -145,6 +150,8 @@
 	return inode;
 }
 
+EXPORT_SYMBOL(fat_build_inode);
+
 static void fat_delete_inode(struct inode *inode)
 {
 	if (!is_bad_inode(inode)) {
@@ -1070,6 +1077,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(fat_fill_super);
+
 static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int free, nr, ret;
@@ -1328,4 +1336,30 @@
 	unlock_kernel();
 	return error;
 }
+EXPORT_SYMBOL(fat_notify_change);
+
+
+int __init fat_cache_init(void);
+void __exit fat_cache_destroy(void);
+
+static int __init init_fat_fs(void)
+{
+	int ret;
+
+	ret = fat_cache_init();
+	if (ret < 0)
+		return ret;
+	return fat_init_inodecache();
+}
+
+static void __exit exit_fat_fs(void)
+{
+	fat_cache_destroy();
+	fat_destroy_inodecache();
+}
+
+module_init(init_fat_fs)
+module_exit(exit_fat_fs)
+
+
 MODULE_LICENSE("GPL");


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVJTQlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVJTQlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVJTQlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:41:11 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:6153 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932403AbVJTQlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:41:10 -0400
To: linux-kernel@vger.kernel.org
Subject: [EXPERIMENT,RFC] FAT: Add "flush" option for hotplug devices
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 21 Oct 2005 01:41:02 +0900
Message-ID: <871x2gf8f5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds new "flush" option on experiment for hotplug devices.

Current implementation of "flush" option does,

	- synchronizing data pages at ->release() (last close(2))
	- if user's work seems to be done (fs is not active), all
	  metadata syncs by pdflush()

This option would provide kind of sane progress, and dirty buffers is
flushed more frequently (if fs is not active).  This option doesn't
provide any robustness (robustness is provided by other options), but
probably the option is proper for hotplug devices.

(Please don't assume that dirty buffers is synchronized at any point.
This implementation will be changed easily.)


Please try this if you have interest. What do you think? Comment?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/buffer.c  |    1 +
 mm/filemap.c |    1 +
 mm/pdflush.c |    1 +
 3 files changed, 3 insertions(+)

diff -puN mm/filemap.c~export-for-flush mm/filemap.c
--- linux-2.6.14-rc4/mm/filemap.c~export-for-flush	2005-10-20 02:00:36.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/mm/filemap.c	2005-10-20 02:00:37.000000000 +0900
@@ -352,6 +352,7 @@ int filemap_write_and_wait(struct addres
 	}
 	return retval;
 }
+EXPORT_SYMBOL(filemap_write_and_wait);
 
 int filemap_write_and_wait_range(struct address_space *mapping,
 				 loff_t lstart, loff_t lend)
diff -puN mm/pdflush.c~export-for-flush mm/pdflush.c
--- linux-2.6.14-rc4/mm/pdflush.c~export-for-flush	2005-10-20 02:00:56.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/mm/pdflush.c	2005-10-20 02:01:19.000000000 +0900
@@ -210,6 +210,7 @@ int pdflush_operation(void (*fn)(unsigne
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pdflush_operation);
 
 static void start_one_pdflush_thread(void)
 {
diff -puN fs/buffer.c~export-for-flush fs/buffer.c
--- linux-2.6.14-rc4/fs/buffer.c~export-for-flush	2005-10-20 02:01:39.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/buffer.c	2005-10-20 02:01:50.000000000 +0900
@@ -185,6 +185,7 @@ int fsync_super(struct super_block *sb)
 
 	return sync_blockdev(sb->s_bdev);
 }
+EXPORT_SYMBOL(fsync_super);
 
 /*
  * Write out and wait upon all dirty data associated with this
_




Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/Makefile          |    2 -
 fs/fat/dir.c             |    1 
 fs/fat/file.c            |   16 +++++++-
 fs/fat/flush.c           |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/inode.c           |   14 ++++++-
 fs/msdos/namei.c         |    2 +
 fs/vfat/namei.c          |    2 +
 include/linux/msdos_fs.h |   17 ++++++++
 8 files changed, 140 insertions(+), 4 deletions(-)

diff -puN /dev/null fs/fat/flush.c
--- /dev/null	2005-10-20 04:05:07.660603750 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/fat/flush.c	2005-10-21 00:25:22.000000000 +0900
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2005, OGAWA Hirofumi
+ * Released under GPL v2.
+ */
+
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/writeback.h>
+#include <linux/msdos_fs.h>
+
+int fat_sync_fdata(struct inode *inode, struct file *filp)
+{
+	int err = 0;
+
+	if (filp->f_mode & FMODE_WRITE) {
+#if 1
+		current->flags |= PF_SYNCWRITE;
+		err = filemap_write_and_wait(inode->i_mapping);
+		current->flags &= ~PF_SYNCWRITE;
+#else
+		down(&inode->i_sem);
+#if 1
+		err = generic_osync_inode(inode, inode->i_mapping, OSYNC_DATA);
+#else
+		err = filp->f_op->fsync(filp, filp->f_dentry, 1);
+#endif
+		up(&inode->i_sem);
+#endif
+	}
+	return err;
+}
+
+static void fat_pdflush_handler(unsigned long arg)
+{
+	struct super_block *sb = (struct super_block *)arg;
+	fsync_super(sb);
+}
+
+static void fat_flush_timer(unsigned long data)
+{
+	struct super_block *sb = (struct super_block *)data;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct backing_dev_info *bdi = blk_get_backing_dev_info(sb->s_bdev);
+	unsigned long last_flush_jiff;
+
+	if (bdi_write_congested(bdi)) {
+		mod_timer(&sbi->flush_timer, jiffies + (HZ / 10));
+		return;
+	}
+
+	last_flush_jiff = sbi->last_flush_jiff;
+
+	if (!time_after_eq(jiffies, last_flush_jiff + (HZ / 2))) {
+		mod_timer(&sbi->flush_timer, last_flush_jiff + (HZ / 2));
+		return;
+	}
+
+	if (pdflush_operation(fat_pdflush_handler, (unsigned long)sb) < 0)
+		mod_timer(&sbi->flush_timer, jiffies + HZ);
+}
+
+void __fat_mark_flush(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	sbi->last_flush_jiff = jiffies;
+	/*
+	 * make sure by smb_wmb() that dirty buffers before here is
+	 * processed at the timer routine.
+	 */
+	smp_wmb();
+
+	if (!timer_pending(&sbi->flush_timer))
+		mod_timer(&sbi->flush_timer, jiffies + HZ);
+}
+EXPORT_SYMBOL(__fat_mark_flush);
+
+void fat_flush_stop(struct super_block *sb)
+{
+	del_timer_sync(&MSDOS_SB(sb)->flush_timer);
+}
+
+void fat_flush_init(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	init_timer(&sbi->flush_timer);
+	sbi->flush_timer.data = (unsigned long)sb;
+	sbi->flush_timer.function = fat_flush_timer;
+	sbi->last_flush_jiff = 0;
+}
diff -puN fs/fat/Makefile~fat_add-flush fs/fat/Makefile
--- linux-2.6.14-rc4/fs/fat/Makefile~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/fat/Makefile	2005-10-21 00:25:22.000000000 +0900
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := cache.o dir.o fatent.o file.o inode.o misc.o
+fat-objs := cache.o dir.o fatent.o file.o flush.o inode.o misc.o
diff -puN include/linux/msdos_fs.h~fat_add-flush include/linux/msdos_fs.h
--- linux-2.6.14-rc4/include/linux/msdos_fs.h~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/include/linux/msdos_fs.h	2005-10-21 00:25:22.000000000 +0900
@@ -184,6 +184,7 @@ struct fat_slot_info {
 #include <linux/string.h>
 #include <linux/nls.h>
 #include <linux/fs.h>
+#include <linux/timer.h>
 
 struct fat_mount_options {
 	uid_t fs_uid;
@@ -202,6 +203,7 @@ struct fat_mount_options {
 		 utf8:1,	  /* Use of UTF8 character set (Default) */
 		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
+		 flush:1,	  /* frequently flush for hotplug device */
 		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
 		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
 };
@@ -241,6 +243,9 @@ struct msdos_sb_info {
 
 	spinlock_t inode_hash_lock;
 	struct hlist_head inode_hashtable[FAT_HASH_SIZE];
+
+	struct timer_list flush_timer;
+	unsigned long last_flush_jiff;
 };
 
 #define FAT_CACHE_VALID	0	/* special case for valid cache */
@@ -389,6 +394,18 @@ extern struct inode_operations fat_file_
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 extern void fat_truncate(struct inode *inode);
 
+/* fat/flush.c */
+int fat_sync_fdata(struct inode *inode, struct file *filp);
+void __fat_mark_flush(struct super_block *sb);
+void fat_flush_stop(struct super_block *sb);
+void fat_flush_init(struct super_block *sb);
+
+static inline void fat_mark_flush(struct super_block *sb)
+{
+	if (MSDOS_SB(sb)->options.flush)
+		__fat_mark_flush(sb);
+}
+
 /* fat/inode.c */
 extern void fat_attach(struct inode *inode, loff_t i_pos);
 extern void fat_detach(struct inode *inode);
diff -puN fs/fat/inode.c~fat_add-flush fs/fat/inode.c
--- linux-2.6.14-rc4/fs/fat/inode.c~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/fat/inode.c	2005-10-21 00:25:22.000000000 +0900
@@ -112,6 +112,7 @@ static int fat_commit_write(struct file 
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
 	}
+	fat_mark_flush(inode->i_sb);
 	return err;
 }
 
@@ -381,6 +382,8 @@ static void fat_put_super(struct super_b
 	if (!(sb->s_flags & MS_RDONLY))
 		fat_clusters_flush(sb);
 
+	fat_flush_stop(sb);
+
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
 		sbi->nls_disk = NULL;
@@ -742,6 +745,8 @@ static int fat_show_options(struct seq_f
 			break;
 		}
 	}
+	if (opts->flush)
+		seq_puts(m, ",flush");
 	if (opts->name_check != 'n')
 		seq_printf(m, ",check=%c", opts->name_check);
 	if (opts->quiet)
@@ -770,7 +775,7 @@ static int fat_show_options(struct seq_f
 enum {
 	Opt_check_n, Opt_check_r, Opt_check_s, Opt_uid, Opt_gid,
 	Opt_umask, Opt_dmask, Opt_fmask, Opt_codepage, Opt_nocase,
-	Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
+	Opt_flush, Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
 	Opt_dots, Opt_nodots,
 	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
 	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
@@ -792,6 +797,7 @@ static match_table_t fat_tokens = {
 	{Opt_fmask, "fmask=%o"},
 	{Opt_codepage, "codepage=%u"},
 	{Opt_nocase, "nocase"},
+	{Opt_flush, "flush"},
 	{Opt_quiet, "quiet"},
 	{Opt_showexec, "showexec"},
 	{Opt_debug, "debug"},
@@ -859,6 +865,7 @@ static int parse_options(char *options, 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
 	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
+	opts->flush = 0;
 	opts->codepage = fat_default_codepage;
 	opts->iocharset = fat_default_iocharset;
 	if (is_vfat)
@@ -906,6 +913,9 @@ static int parse_options(char *options, 
 					| VFAT_SFN_CREATE_WIN95;
 			}
 			break;
+		case Opt_flush:
+			opts->flush = 1;
+			break;
 		case Opt_quiet:
 			opts->quiet = 1;
 			break;
@@ -1091,6 +1101,8 @@ int fat_fill_super(struct super_block *s
 	sb->s_export_op = &fat_export_ops;
 	sbi->dir_ops = fs_dir_inode_ops;
 
+	fat_flush_init(sb);
+
 	error = parse_options(data, isvfat, &debug, &sbi->options);
 	if (error)
 		goto out_fail;
diff -puN fs/fat/file.c~fat_add-flush fs/fat/file.c
--- linux-2.6.14-rc4/fs/fat/file.c~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/fat/file.c	2005-10-21 00:25:22.000000000 +0900
@@ -15,7 +15,8 @@
 int fat_generic_ioctl(struct inode *inode, struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	u32 __user *user_attr = (u32 __user *)arg;
 
 	switch (cmd) {
@@ -101,6 +102,7 @@ int fat_generic_ioctl(struct inode *inod
 
 		MSDOS_I(inode)->i_attrs = attr & ATTR_UNUSED;
 		mark_inode_dirty(inode);
+		fat_mark_flush(sb);
 	up:
 		up(&inode->i_sem);
 		return err;
@@ -110,6 +112,13 @@ int fat_generic_ioctl(struct inode *inod
 	}
 }
 
+static int fat_release_file(struct inode *inode, struct file *filp)
+{
+	if (MSDOS_SB(inode->i_sb)->options.flush)
+		return fat_sync_fdata(inode, filp);
+	return 0;
+}
+
 struct file_operations fat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
@@ -118,6 +127,7 @@ struct file_operations fat_file_operatio
 	.writev		= generic_file_writev,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
+	.release	= fat_release_file,
 	.mmap		= generic_file_mmap,
 	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
@@ -126,7 +136,8 @@ struct file_operations fat_file_operatio
 
 int fat_notify_change(struct dentry *dentry, struct iattr *attr)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
+	struct super_block *sb = dentry->d_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct inode *inode = dentry->d_inode;
 	int mask, error = 0;
 
@@ -170,6 +181,7 @@ int fat_notify_change(struct dentry *den
 	inode->i_mode &= S_IFMT | (S_IRWXUGO & ~mask);
 out:
 	unlock_kernel();
+	fat_mark_flush(sb);
 	return error;
 }
 
diff -puN fs/vfat/namei.c~fat_add-flush fs/vfat/namei.c
--- linux-2.6.14-rc4/fs/vfat/namei.c~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/vfat/namei.c	2005-10-21 00:25:22.000000000 +0900
@@ -688,6 +688,7 @@ static int vfat_add_entry(struct inode *
 		(void)fat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
+	fat_mark_flush(dir->i_sb);
 cleanup:
 	kfree(slots);
 	return err;
@@ -980,6 +981,7 @@ static int vfat_rename(struct inode *old
 		new_inode->i_ctime = ts;
 	}
 out:
+	fat_mark_flush(old_dir->i_sb);
 	brelse(sinfo.bh);
 	brelse(dotdot_bh);
 	brelse(old_sinfo.bh);
diff -puN fs/msdos/namei.c~fat_add-flush fs/msdos/namei.c
--- linux-2.6.14-rc4/fs/msdos/namei.c~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/msdos/namei.c	2005-10-21 00:25:22.000000000 +0900
@@ -284,6 +284,7 @@ static int msdos_add_entry(struct inode 
 		(void)fat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
+	fat_mark_flush(dir->i_sb);
 
 	return 0;
 }
@@ -583,6 +584,7 @@ static int do_msdos_rename(struct inode 
 		new_inode->i_ctime = ts;
 	}
 out:
+	fat_mark_flush(old_dir->i_sb);
 	brelse(sinfo.bh);
 	brelse(dotdot_bh);
 	brelse(old_sinfo.bh);
diff -puN fs/fat/dir.c~fat_add-flush fs/fat/dir.c
--- linux-2.6.14-rc4/fs/fat/dir.c~fat_add-flush	2005-10-21 00:25:22.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/fat/dir.c	2005-10-21 00:25:22.000000000 +0900
@@ -960,6 +960,7 @@ int fat_remove_entries(struct inode *dir
 		(void)fat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
+	fat_mark_flush(dir->i_sb);
 
 	return 0;
 }
_

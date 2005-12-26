Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVLZTA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVLZTA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVLZTA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:00:27 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:11276 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932100AbVLZTA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:00:26 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT] Add new "flush" option
References: <877j9ufeio.fsf@devron.myhome.or.jp>
	<20051225041900.38fdcba7.akpm@osdl.org>
	<878xu99rxx.fsf@devron.myhome.or.jp>
	<20051225150500.317bb7b3.akpm@osdl.org>
	<87oe336chg.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 27 Dec 2005 04:00:16 +0900
In-Reply-To: <87oe336chg.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 27 Dec 2005 01:37:31 +0900")
Message-ID: <87wthrznsv.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is updated patch. The changes is

   - s/EXPORT_SYMBOL/&_GPL/
   - Use filp->f_mapping in fs_flush_sync_fdata().
   - Remove bdi_write_congested() check


Please try this if you have interests/complaints.

These patches is including the debug patch to try "-o flush" without
changeing mount command.

e.g.
	# mount -t vfat /dev/xxx /mnt -o flush

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


This adds new "flush" option for hotplug devices.

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

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/Makefile        |    2 -
 fs/flush.c         |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fs-writeback.c  |    1 
 fs/namespace.c     |    1 
 fs/super.c         |    3 +
 include/linux/fs.h |   21 +++++++++++-
 6 files changed, 112 insertions(+), 3 deletions(-)

diff -puN fs/Makefile~add-flush_option fs/Makefile
--- linux-2.6/fs/Makefile~add-flush_option	2005-12-26 00:45:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/Makefile	2005-12-26 00:45:16.000000000 +0900
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o
+		ioprio.o pnode.o flush.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff -puN /dev/null fs/flush.c
--- /dev/null	2005-12-26 10:53:17.220513750 +0900
+++ linux-2.6-hirofumi/fs/flush.c	2005-12-27 01:41:43.000000000 +0900
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2005, OGAWA Hirofumi
+ * Released under GPL v2.
+ */
+
+#include <linux/fs.h>
+#include <linux/writeback.h>
+#include <linux/buffer_head.h>
+
+#define FLUSH_INITAL_DELAY	HZ
+#define FLUSH_DELAY		(HZ / 2)
+
+int fs_flush_sync_fdata(struct inode *inode, struct file *filp)
+{
+	int err = 0;
+
+	if (IS_FLUSH(inode) && filp->f_mode & FMODE_WRITE) {
+		current->flags |= PF_SYNCWRITE;
+		err = filemap_write_and_wait(filp->f_mapping);
+		current->flags &= ~PF_SYNCWRITE;
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(fs_flush_sync_fdata);
+
+static void fs_flush_pdflush_handler(unsigned long arg)
+{
+	struct super_block *sb = (struct super_block *)arg;
+	fsync_super(sb);
+	up_read(&sb->s_umount);
+}
+
+static void fs_flush_timer(unsigned long data)
+{
+	struct super_block *sb = (struct super_block *)data;
+	unsigned long last_flush_jiff;
+	int err;
+
+	last_flush_jiff = sb->last_flush_jiff;
+
+	if (!time_after_eq(jiffies, last_flush_jiff + FLUSH_DELAY)) {
+		mod_timer(&sb->flush_timer, last_flush_jiff + FLUSH_DELAY);
+		return;
+	}
+
+	if (down_read_trylock(&sb->s_umount)) {
+		if (sb->s_root) {
+			err = pdflush_operation(fs_flush_pdflush_handler, data);
+			if (!err)
+				return;
+			mod_timer(&sb->flush_timer, jiffies + FLUSH_DELAY);
+		}
+		up_read(&sb->s_umount);
+	}
+}
+
+void __fs_mark_flush(struct super_block *sb)
+{
+	sb->last_flush_jiff = jiffies;
+	/*
+	 * make sure by smb_wmb() that dirty buffers before here is
+	 * processed at the timer routine.
+	 */
+	smp_wmb();
+
+	if (!timer_pending(&sb->flush_timer))
+		mod_timer(&sb->flush_timer, jiffies + FLUSH_INITAL_DELAY);
+}
+EXPORT_SYMBOL_GPL(__fs_mark_flush);
+
+/*
+ * caller must take down_write(sb->s_umount), otherwise pdflush
+ * handler may be run after this del_timer_sync.
+ */
+void fs_flush_stop(struct super_block *sb)
+{
+	sb->s_flags &= ~MS_FLUSH;
+	del_timer_sync(&sb->flush_timer);
+}
+
+void fs_flush_init(struct super_block *sb)
+{
+	init_timer(&sb->flush_timer);
+	sb->flush_timer.data = (unsigned long)sb;
+	sb->flush_timer.function = fs_flush_timer;
+	sb->last_flush_jiff = 0;
+}
diff -puN fs/fs-writeback.c~add-flush_option fs/fs-writeback.c
--- linux-2.6/fs/fs-writeback.c~add-flush_option	2005-12-26 00:45:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/fs-writeback.c	2005-12-26 00:45:16.000000000 +0900
@@ -63,6 +63,7 @@ void __mark_inode_dirty(struct inode *in
 	if (flags & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {
 		if (sb->s_op->dirty_inode)
 			sb->s_op->dirty_inode(inode);
+		fs_mark_flush(sb);
 	}
 
 	/*
diff -puN fs/namespace.c~add-flush_option fs/namespace.c
--- linux-2.6/fs/namespace.c~add-flush_option	2005-12-26 00:45:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/namespace.c	2005-12-26 00:45:16.000000000 +0900
@@ -354,6 +354,7 @@ static int show_vfsmnt(struct seq_file *
 	} fs_info[] = {
 		{ MS_SYNCHRONOUS, ",sync" },
 		{ MS_DIRSYNC, ",dirsync" },
+		{ MS_FLUSH, ",flush" },
 		{ MS_MANDLOCK, ",mand" },
 		{ MS_NOATIME, ",noatime" },
 		{ MS_NODIRATIME, ",nodiratime" },
diff -puN fs/super.c~add-flush_option fs/super.c
--- linux-2.6/fs/super.c~add-flush_option	2005-12-26 00:45:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/super.c	2005-12-26 00:45:16.000000000 +0900
@@ -86,6 +86,7 @@ static struct super_block *alloc_super(v
 		s->s_qcop = sb_quotactl_ops;
 		s->s_op = &default_op;
 		s->s_time_gran = 1000000000;
+		fs_flush_init(s);
 	}
 out:
 	return s;
@@ -230,6 +231,7 @@ void generic_shutdown_super(struct super
 
 	if (root) {
 		sb->s_root = NULL;
+		fs_flush_stop(sb);
 		shrink_dcache_parent(root);
 		shrink_dcache_anon(&sb->s_anon);
 		dput(root);
@@ -536,6 +538,7 @@ int do_remount_sb(struct super_block *sb
 		return -EACCES;
 	if (flags & MS_RDONLY)
 		acct_auto_close(sb);
+	fs_flush_stop(sb);
 	shrink_dcache_sb(sb);
 	fsync_super(sb);
 
diff -puN include/linux/fs.h~add-flush_option include/linux/fs.h
--- linux-2.6/include/linux/fs.h~add-flush_option	2005-12-26 00:45:16.000000000 +0900
+++ linux-2.6-hirofumi/include/linux/fs.h	2005-12-26 00:45:16.000000000 +0900
@@ -98,6 +98,7 @@ extern int dir_notify_enable;
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
 #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_FLUSH	256	/* Frequently flushes for hotplug devices */
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
@@ -115,8 +116,8 @@ extern int dir_notify_enable;
 /*
  * Superblock flags that can be altered by MS_REMOUNT
  */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
-			 MS_NODIRATIME)
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_FLUSH| \
+			 MS_NOATIME|MS_NODIRATIME)
 
 /*
  * Old magic mount flag and mask
@@ -157,6 +158,7 @@ extern int dir_notify_enable;
 					((inode)->i_flags & S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
 					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
+#define IS_FLUSH(inode)		__IS_FLG(inode, MS_FLUSH)
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
@@ -222,6 +224,7 @@ extern int dir_notify_enable;
 #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/timer.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -826,6 +829,9 @@ struct super_block {
 	/* Granuality of c/m/atime in ns.
 	   Cannot be worse than a second */
 	u32		   s_time_gran;
+
+	struct timer_list flush_timer;
+	unsigned long last_flush_jiff;
 };
 
 extern struct timespec current_fs_time(struct super_block *sb);
@@ -1099,6 +1105,17 @@ static inline void file_accessed(struct 
 		touch_atime(file->f_vfsmnt, file->f_dentry);
 }
 
+int fs_flush_sync_fdata(struct inode *inode, struct file *filp);
+void __fs_mark_flush(struct super_block *sb);
+void fs_flush_stop(struct super_block *sb);
+void fs_flush_init(struct super_block *sb);
+
+static inline void fs_mark_flush(struct super_block *sb)
+{
+	if (sb->s_flags & MS_FLUSH)
+		__fs_mark_flush(sb);
+}
+
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
 
 /**
_



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff -puN fs/fat/file.c~fat_flush-support fs/fat/file.c
--- linux-2.6/fs/fat/file.c~fat_flush-support	2005-12-26 00:55:31.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/file.c	2005-12-26 00:55:31.000000000 +0900
@@ -119,6 +119,7 @@ struct file_operations fat_file_operatio
 	.writev		= generic_file_writev,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
+	.release	= fs_flush_sync_fdata,
 	.mmap		= generic_file_mmap,
 	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
@@ -272,7 +273,8 @@ static int fat_free(struct inode *inode,
 
 void fat_truncate(struct inode *inode)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
 
@@ -288,6 +290,7 @@ void fat_truncate(struct inode *inode)
 	lock_kernel();
 	fat_free(inode, nr_clusters);
 	unlock_kernel();
+	fs_mark_flush(sb);
 }
 
 struct inode_operations fat_file_inode_operations = {
_



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff -puN fs/fat/inode.c~fat_flush-debug fs/fat/inode.c
--- linux-2.6/fs/fat/inode.c~fat_flush-debug	2005-12-26 00:55:35.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/inode.c	2005-12-26 00:55:35.000000000 +0900
@@ -855,7 +855,7 @@ static int fat_show_options(struct seq_f
 enum {
 	Opt_check_n, Opt_check_r, Opt_check_s, Opt_uid, Opt_gid,
 	Opt_umask, Opt_dmask, Opt_fmask, Opt_codepage, Opt_nocase,
-	Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
+	Opt_flush, Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
 	Opt_dots, Opt_nodots,
 	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
 	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
@@ -877,6 +877,7 @@ static match_table_t fat_tokens = {
 	{Opt_fmask, "fmask=%o"},
 	{Opt_codepage, "codepage=%u"},
 	{Opt_nocase, "nocase"},
+	{Opt_flush, "flush"},
 	{Opt_quiet, "quiet"},
 	{Opt_showexec, "showexec"},
 	{Opt_debug, "debug"},
@@ -991,6 +992,9 @@ static int parse_options(char *options, 
 					| VFAT_SFN_CREATE_WIN95;
 			}
 			break;
+		case Opt_flush:
+			*debug = 1;
+			break;
 		case Opt_quiet:
 			opts->quiet = 1;
 			break;
@@ -1182,6 +1186,8 @@ int fat_fill_super(struct super_block *s
 	error = parse_options(data, isvfat, silent, &debug, &sbi->options);
 	if (error)
 		goto out_fail;
+	if (debug)
+		sb->s_flags |= MS_FLUSH;
 
 	error = -EIO;
 	sb_min_blocksize(sb, 512);
_

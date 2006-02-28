Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWB1SsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWB1SsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWB1SsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:48:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:57297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751890AbWB1SsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:48:16 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: o_sync in vfat driver
Date: Tue, 28 Feb 2006 13:47:43 -0500
User-Agent: KMail/1.9.1
Cc: col-pepper@piments.com, linux-kernel@vger.kernel.org
References: <op.s5lrw0hrj68xd1@mail.piments.com> <op.s5nkafhpj68xd1@mail.piments.com> <20060227151230.695de2af.akpm@osdl.org>
In-Reply-To: <20060227151230.695de2af.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281347.46169.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 18:12, Andrew Morton wrote:

> We don't know that the same number of same-sized write()s were happening in
> each case.
>
> There's been some talk about implementing fsync()-on-file-close for this
> problem, and some protopatches.  But nothing final yet.

Here's the patch I'm using in -suse right now.  What I want to do is make a 
much more generic -o flush, but it'll still need a few bits in individual 
filesystem to kick off metadata writes quickly.

The basic goal behind the code is to trigger writes without waiting for both
data and metadata.  If the user is watching the memory stick, when the 
little light stops flashing all the data and metadata will be on disk.

It also generally throttles userland a little during file release.  This 
could be changed to throttle for each page dirtied, but most users I 
asked liked the current setup better.

-chris

From: Chris Mason <mason@suse.com>
Subject: add -o flush for fat

Fat is commonly used on removable media, mounting with -o flush tells the
FS to write things to disk as quickly as possible.  It is like -o sync, but
much faster (and not as safe).

diff -r a06cef570da0 fs/fat/file.c
--- a/fs/fat/file.c	Sun Jan 15 11:59:32 2006 -0500
+++ b/fs/fat/file.c	Sun Jan 15 13:00:35 2006 -0500
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
+#include <linux/blkdev.h>
 
 int fat_generic_ioctl(struct inode *inode, struct file *filp,
 		      unsigned int cmd, unsigned long arg)
@@ -112,6 +113,19 @@ int fat_generic_ioctl(struct inode *inod
 	}
 }
 
+static int
+fat_file_release(struct inode *inode, struct file *filp)
+{
+
+	if ((filp->f_mode & FMODE_WRITE) &&
+	     MSDOS_SB(inode->i_sb)->options.flush) {
+		writeback_inode(inode);
+		writeback_bdev(inode->i_sb);
+		blk_congestion_wait(WRITE, HZ/10);
+	}
+	return 0;
+}
+
 struct file_operations fat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
@@ -121,6 +135,7 @@ struct file_operations fat_file_operatio
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
+	.release	= fat_file_release,
 	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
 	.sendfile	= generic_file_sendfile,
@@ -293,6 +308,10 @@ void fat_truncate(struct inode *inode)
 	lock_kernel();
 	fat_free(inode, nr_clusters);
 	unlock_kernel();
+	if (MSDOS_SB(inode->i_sb)->options.flush) {
+		writeback_inode(inode);
+		writeback_bdev(inode->i_sb);
+	}
 }
 
 struct inode_operations fat_file_inode_operations = {
diff -r a06cef570da0 fs/fat/inode.c
--- a/fs/fat/inode.c	Sun Jan 15 11:59:32 2006 -0500
+++ b/fs/fat/inode.c	Sun Jan 15 13:00:35 2006 -0500
@@ -24,6 +24,7 @@
 #include <linux/vfs.h>
 #include <linux/parser.h>
 #include <linux/uio.h>
+#include <linux/writeback.h>
 #include <asm/unaligned.h>
 
 #ifndef CONFIG_FAT_DEFAULT_IOCHARSET
@@ -860,7 +861,7 @@ enum {
 	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
 	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
 	Opt_uni_xl_no, Opt_uni_xl_yes, Opt_nonumtail_no, Opt_nonumtail_yes,
-	Opt_obsolate, Opt_err,
+	Opt_obsolate, Opt_flush, Opt_err,
 };
 
 static match_table_t fat_tokens = {
@@ -892,7 +893,8 @@ static match_table_t fat_tokens = {
 	{Opt_obsolate, "cvf_format=%20s"},
 	{Opt_obsolate, "cvf_options=%100s"},
 	{Opt_obsolate, "posix"},
-	{Opt_err, NULL}
+	{Opt_flush, "flush"},
+	{Opt_err, NULL},
 };
 static match_table_t msdos_tokens = {
 	{Opt_nodots, "nodots"},
@@ -1033,6 +1035,9 @@ static int parse_options(char *options, 
 				return 0;
 			opts->codepage = option;
 			break;
+		case Opt_flush:
+			opts->flush = 1;
+			break;
 
 		/* msdos specific */
 		case Opt_dots:
diff -r a06cef570da0 fs/fs-writeback.c
--- a/fs/fs-writeback.c	Sun Jan 15 11:59:32 2006 -0500
+++ b/fs/fs-writeback.c	Sun Jan 15 13:00:35 2006 -0500
@@ -390,6 +390,29 @@ sync_sb_inodes(struct super_block *sb, s
 	return;		/* Leave any unwritten inodes on s_io */
 }
 
+void
+writeback_bdev(struct super_block *sb)
+{
+	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	filemap_flush(mapping);
+	blk_run_address_space(mapping);
+}
+EXPORT_SYMBOL_GPL(writeback_bdev);
+
+void
+writeback_inode(struct inode *inode)
+{
+
+	struct address_space *mapping = inode->i_mapping;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_NONE,
+		.nr_to_write = 0,
+	};
+	sync_inode(inode, &wbc);
+	filemap_fdatawrite(mapping);
+}
+EXPORT_SYMBOL_GPL(writeback_inode);
+
 /*
  * Start writeback of dirty pagecache data against all unlocked inodes.
  *
diff -r a06cef570da0 fs/msdos/namei.c
--- a/fs/msdos/namei.c	Sun Jan 15 11:59:32 2006 -0500
+++ b/fs/msdos/namei.c	Sun Jan 15 13:00:35 2006 -0500
@@ -11,6 +11,7 @@
 #include <linux/buffer_head.h>
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/writeback.h>
 
 /* MS-DOS "device special files" */
 static const unsigned char *reserved_names[] = {
@@ -293,7 +294,7 @@ static int msdos_create(struct inode *di
 			struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	struct fat_slot_info sinfo;
 	struct timespec ts;
 	unsigned char msdos_name[MSDOS_NAME];
@@ -329,6 +330,11 @@ static int msdos_create(struct inode *di
 	d_instantiate(dentry, inode);
 out:
 	unlock_kernel();
+	if (!err && MSDOS_SB(sb)->options.flush) {
+		writeback_inode(dir);
+		writeback_inode(inode);
+		writeback_bdev(sb);
+	}
 	return err;
 }
 
@@ -361,6 +367,11 @@ static int msdos_rmdir(struct inode *dir
 	fat_detach(inode);
 out:
 	unlock_kernel();
+	if (!err && MSDOS_SB(inode->i_sb)->options.flush) {
+		writeback_inode(dir);
+		writeback_inode(inode);
+		writeback_bdev(inode->i_sb);
+	}
 
 	return err;
 }
@@ -414,6 +425,11 @@ static int msdos_mkdir(struct inode *dir
 	d_instantiate(dentry, inode);
 
 	unlock_kernel();
+	if (MSDOS_SB(sb)->options.flush) {
+		writeback_inode(dir);
+		writeback_inode(inode);
+		writeback_bdev(sb);
+	}
 	return 0;
 
 out_free:
@@ -443,6 +459,11 @@ static int msdos_unlink(struct inode *di
 	fat_detach(inode);
 out:
 	unlock_kernel();
+	if (!err && MSDOS_SB(inode->i_sb)->options.flush) {
+		writeback_inode(dir);
+		writeback_inode(inode);
+		writeback_bdev(inode->i_sb);
+	}
 
 	return err;
 }
@@ -648,6 +669,11 @@ static int msdos_rename(struct inode *ol
 			      new_dir, new_msdos_name, new_dentry, is_hid);
 out:
 	unlock_kernel();
+	if (!err && MSDOS_SB(old_dir->i_sb)->options.flush) {
+		writeback_inode(old_dir);
+		writeback_inode(new_dir);
+		writeback_bdev(old_dir->i_sb);
+	}
 	return err;
 }
 
diff -r a06cef570da0 include/linux/msdos_fs.h
--- a/include/linux/msdos_fs.h	Sun Jan 15 11:59:32 2006 -0500
+++ b/include/linux/msdos_fs.h	Sun Jan 15 13:00:35 2006 -0500
@@ -203,6 +203,7 @@ struct fat_mount_options {
 		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
 		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
+		 flush:1,	  /* write things quickly */
 		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
 };
 
diff -r a06cef570da0 include/linux/writeback.h
--- a/include/linux/writeback.h	Sun Jan 15 11:59:32 2006 -0500
+++ b/include/linux/writeback.h	Sun Jan 15 13:00:35 2006 -0500
@@ -68,6 +68,8 @@ int inode_wait(void *);
 int inode_wait(void *);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
+void writeback_bdev(struct super_block *);
+void writeback_inode(struct inode *);
 
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)

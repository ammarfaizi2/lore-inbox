Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTEDQ6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbTEDQ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:58:17 -0400
Received: from verein.lst.de ([212.34.181.86]:25359 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261185AbTEDQ5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:57:50 -0400
Date: Sun, 4 May 2003 19:10:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] how to fix is_local_disk()?
Message-ID: <20030504191013.A10659@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030504090003.A7285@lst.de> <20030504003021.077e8819.akpm@digeo.com> <20030504010014.67352345.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030504010014.67352345.akpm@digeo.com>; from akpm@digeo.com on Sun, May 04, 2003 at 01:00:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 01:00:14AM -0700, Andrew Morton wrote:
> The below should do the trick.
> 
> But we still need superblock walking code to do the remount-ro thing. 
> Another superblock-iterator which calls do_remount_sb()?

Yupp, patch below.  The iterator is in fs/super.c to allow sharing
a piece of code with the normal remount path and to avoid forgetting
it when updating the locking rules like approximately the last two
years.  Works fine here but I'm not sure what we want to do with
panic()..


--- 1.26/drivers/char/sysrq.c	Fri Feb 21 10:36:41 2003
+++ edited/drivers/char/sysrq.c	Sun May  4 17:10:50 2003
@@ -101,131 +101,19 @@
 {
 	machine_restart(NULL);
 }
+
 static struct sysrq_key_op sysrq_reboot_op = {
 	.handler	= sysrq_handle_reboot,
 	.help_msg	= "reBoot",
 	.action_msg	= "Resetting",
 };
 
-
-
-/* SYNC SYSRQ HANDLERS BLOCK */
-
-/* do_emergency_sync helper function */
-/* Guesses if the device is a local hard drive */
-static int is_local_disk(struct block_device *bdev)
-{
-	switch (MAJOR(bdev->bd_dev)) {
-	case IDE0_MAJOR:
-	case IDE1_MAJOR:
-	case IDE2_MAJOR:
-	case IDE3_MAJOR:
-	case IDE4_MAJOR:
-	case IDE5_MAJOR:
-	case IDE6_MAJOR:
-	case IDE7_MAJOR:
-	case IDE8_MAJOR:
-	case IDE9_MAJOR:
-	case SCSI_DISK0_MAJOR:
-	case SCSI_DISK1_MAJOR:
-	case SCSI_DISK2_MAJOR:
-	case SCSI_DISK3_MAJOR:
-	case SCSI_DISK4_MAJOR:
-	case SCSI_DISK5_MAJOR:
-	case SCSI_DISK6_MAJOR:
-	case SCSI_DISK7_MAJOR:
-	case XT_DISK_MAJOR:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
-/* do_emergency_sync helper function */
-static void go_sync(struct super_block *sb, int remount_flag)
-{
-	int orig_loglevel;
-	orig_loglevel = console_loglevel;
-	console_loglevel = 7;
-	printk(KERN_INFO "%sing device %s ... ",
-	       remount_flag ? "Remount" : "Sync",
-	       sb->s_id);
-
-	if (remount_flag) { /* Remount R/O */
-		int ret, flags;
-		struct file *file;
-
-		if (sb->s_flags & MS_RDONLY) {
-			printk("R/O\n");
-			return;
-		}
-
-		file_list_lock();
-		list_for_each_entry(file, &sb->s_files, f_list) {
-			if (file->f_dentry && file_count(file)
-				&& S_ISREG(file->f_dentry->d_inode->i_mode))
-				file->f_mode &= ~2;
-		}
-		file_list_unlock();
-		DQUOT_OFF(sb);
-		fsync_bdev(sb->s_bdev);
-		flags = MS_RDONLY;
-		if (sb->s_op && sb->s_op->remount_fs) {
-			ret = sb->s_op->remount_fs(sb, &flags, NULL);
-			if (ret)
-				printk("error %d\n", ret);
-			else {
-				sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (flags & MS_RMT_MASK);
-				printk("OK\n");
-			}
-		} else
-			printk("nothing to do\n");
-	} else { /* Sync only */
-		fsync_bdev(sb->s_bdev);
-		printk("OK\n");
-	}
-	console_loglevel = orig_loglevel;
-}
-/*
- * Emergency Sync or Unmount. We cannot do it directly, so we set a special
- * flag and wake up the bdflush kernel thread which immediately calls this function.
- * We process all mounted hard drives first to recover from crashed experimental
- * block devices and malfunctional network filesystems.
- */
-
-int emergency_sync_scheduled;
-
-void do_emergency_sync(void) {
-	struct super_block *sb;
-	int remount_flag;
-	int orig_loglevel;
-
-	lock_kernel();
-	remount_flag = (emergency_sync_scheduled == EMERG_REMOUNT);
-	emergency_sync_scheduled = 0;
-
-	list_for_each_entry(sb, &super_blocks, s_list)
-		if (sb->s_bdev && is_local_disk(sb->s_bdev))
-			go_sync(sb, remount_flag);
-
-	list_for_each_entry(sb, &super_blocks, s_list)
-		if (sb->s_bdev && !is_local_disk(sb->s_bdev))
-			go_sync(sb, remount_flag);
-
-	unlock_kernel();
-
-	orig_loglevel = console_loglevel;
-	console_loglevel = 7;
-	printk(KERN_INFO "Done.\n");
-	console_loglevel = orig_loglevel;
-}
-
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
-	emergency_sync_scheduled = EMERG_SYNC;
-	wakeup_bdflush(0);
+	emergency_sync();
 }
+
 static struct sysrq_key_op sysrq_sync_op = {
 	.handler	= sysrq_handle_sync,
 	.help_msg	= "Sync",
@@ -235,9 +123,9 @@
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
 				 struct tty_struct *tty) 
 {
-	emergency_sync_scheduled = EMERG_REMOUNT;
-	wakeup_bdflush(0);
+	emergency_remount();
 }
+
 static struct sysrq_key_op sysrq_mountro_op = {
 	.handler	= sysrq_handle_mountro,
 	.help_msg	= "Unmount",
--- 1.198/fs/buffer.c	Wed Apr 30 03:03:42 2003
+++ edited/fs/buffer.c	Sun May  4 09:24:51 2003
@@ -244,16 +244,26 @@
  * sync everything.  Start out by waking pdflush, because that writes back
  * all queues in parallel.
  */
-asmlinkage long sys_sync(void)
+static void do_sync(unsigned long wait)
 {
 	wakeup_bdflush(0);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
 	sync_supers();		/* Write the superblocks */
 	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(1);	/* Waitingly sync the filesystems */
-	sync_inodes(1);		/* Mappings, inodes and blockdevs, again. */
+	sync_filesystems(wait);	/* Waitingly sync the filesystems */
+	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+}
+
+asmlinkage long sys_sync(void)
+{
+	do_sync(1);
 	return 0;
+}
+
+void emergency_sync(void)
+{
+	pdflush_operation(do_sync, 0);
 }
 
 /*
--- 1.39/fs/namespace.c	Sat Apr 19 19:17:34 2003
+++ edited/fs/namespace.c	Sun May  4 17:25:25 2003
@@ -24,7 +24,7 @@
 #include <asm/uaccess.h>
 
 extern struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
-extern int do_remount_sb(struct super_block *sb, int flags, void * data);
+extern int do_remount_sb(struct super_block *sb, int flags, void *data, int force);
 extern int __init init_rootfs(void);
 extern int __init fs_subsys_init(void);
 
@@ -326,7 +326,7 @@
 		down_write(&sb->s_umount);
 		if (!(sb->s_flags & MS_RDONLY)) {
 			lock_kernel();
-			retval = do_remount_sb(sb, MS_RDONLY, 0);
+			retval = do_remount_sb(sb, MS_RDONLY, 0, 0);
 			unlock_kernel();
 		}
 		up_write(&sb->s_umount);
@@ -555,7 +555,7 @@
 		return -EINVAL;
 
 	down_write(&sb->s_umount);
-	err = do_remount_sb(sb, flags, data);
+	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
 		nd->mnt->mnt_flags=mnt_flags;
 	up_write(&sb->s_umount);
--- 1.100/fs/super.c	Thu Apr 10 13:23:49 2003
+++ edited/fs/super.c	Sun May  4 17:28:05 2003
@@ -31,6 +31,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/vfs.h>
+#include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <asm/uaccess.h>
 
 
@@ -431,6 +432,18 @@
 	return err;
 }
 
+static void mark_files_ro(struct super_block *sb)
+{
+	struct file *f;
+
+	file_list_lock();
+	list_for_each_entry(f, &sb->s_files, f_list) {
+		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
+			f->f_mode &= ~2;
+	}
+	file_list_unlock();
+}
+
 /**
  *	do_remount_sb	-	asks filesystem to change mount options.
  *	@sb:	superblock in question
@@ -439,21 +452,25 @@
  *
  *	Alters the mount options of a mounted file system.
  */
-int do_remount_sb(struct super_block *sb, int flags, void *data)
+int do_remount_sb(struct super_block *sb, int flags, void *data, int force)
 {
 	int retval;
 	
 	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
 		return -EACCES;
-		/*flags |= MS_RDONLY;*/
 	if (flags & MS_RDONLY)
 		acct_auto_close(sb);
 	shrink_dcache_sb(sb);
 	fsync_super(sb);
+
 	/* If we are remounting RDONLY, make sure there are no rw files open */
-	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY))
-		if (!fs_may_remount_ro(sb))
+	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY)) {
+		if (force)
+			mark_files_ro(sb);
+		else if (!fs_may_remount_ro(sb))
 			return -EBUSY;
+	}
+
 	if (sb->s_op->remount_fs) {
 		lock_super(sb);
 		retval = sb->s_op->remount_fs(sb, &flags, data);
@@ -465,6 +482,28 @@
 	return 0;
 }
 
+static void do_emergency_remount(unsigned long foo)
+{
+	struct super_block *sb;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		down_read(&sb->s_umount);
+		if (sb->s_bdev && !(sb->s_flags & MS_RDONLY))
+			do_remount_sb(sb, MS_RDONLY, NULL, 1);
+		drop_super(sb);
+		spin_lock(&sb_lock);
+	}
+	spin_unlock(&sb_lock);
+}
+
+void emergency_remount(void)
+{
+	pdflush_operation(do_emergency_remount, 0);
+}
+
 /*
  * Unnamed block devices are dummy devices used by virtual
  * filesystems which don't use real block-devices.  -- jrs
@@ -618,7 +657,7 @@
 		}
 		s->s_flags |= MS_ACTIVE;
 	}
-	do_remount_sb(s, flags, data);
+	do_remount_sb(s, flags, data, 0);
 	return s;
 }
 
--- 1.238/include/linux/fs.h	Tue Apr 29 17:42:50 2003
+++ edited/include/linux/fs.h	Sun May  4 09:45:49 2003
@@ -1113,6 +1113,8 @@
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
+extern void emergency_sync(void);
+extern void emergency_remount(void);
 extern sector_t bmap(struct inode *, sector_t);
 extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);
--- 1.4/include/linux/sysrq.h	Thu Jun 27 18:32:51 2002
+++ edited/include/linux/sysrq.h	Sun May  4 09:46:22 2003
@@ -92,21 +92,3 @@
 #define unregister_sysrq_key(ig,nore) __reterr()
 
 #endif
-
-
-/* Deferred actions */
-
-extern int emergency_sync_scheduled;
-
-#define EMERG_SYNC 1
-#define EMERG_REMOUNT 2
-
-void do_emergency_sync(void);
-
-#ifdef CONFIG_MAGIC_SYSRQ
-#define CHECK_EMERGENCY_SYNC			\
-	if (emergency_sync_scheduled)		\
-		do_emergency_sync();
-#else
-#define CHECK_EMERGENCY_SYNC
-#endif
--- 1.10/kernel/panic.c	Wed Apr  9 04:01:38 2003
+++ edited/kernel/panic.c	Sun May  4 09:54:07 2003
@@ -96,9 +96,8 @@
         disabled_wait(caller);
 #endif
 	local_irq_enable();
-	for(;;) {
-		CHECK_EMERGENCY_SYNC
-	}
+	for (;;)
+		;
 }
 
 /**
--- 1.62/mm/page-writeback.c	Sun Apr 20 02:22:32 2003
+++ edited/mm/page-writeback.c	Sun May  4 09:59:20 2003
@@ -20,7 +20,6 @@
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/init.h>
-#include <linux/sysrq.h>
 #include <linux/backing-dev.h>
 #include <linux/blkdev.h>
 #include <linux/mpage.h>
@@ -237,7 +236,6 @@
 		.nonblocking	= 1,
 	};
 
-	CHECK_EMERGENCY_SYNC
 	for ( ; ; ) {
 		struct page_state ps;
 		long background_thresh;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUCNAjn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUCNAjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:39:43 -0500
Received: from gprs40-159.eurotel.cz ([160.218.40.159]:25993 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263231AbUCNAii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:38:38 -0500
Date: Sun, 14 Mar 2004 01:37:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with swsusp vs. pmdisk
Message-ID: <20040314003717.GI549@elf.ucw.cz>
References: <20040312224645.GA326@elf.ucw.cz> <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston> <20040313123620.GA3352@openzaurus.ucw.cz> <1079223482.1960.113.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079223482.1960.113.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 14-03-04 11:18:02, Benjamin Herrenschmidt wrote:
> On Sat, 2004-03-13 at 23:36, Pavel Machek wrote:
> > Hi!
> > 
> > > > Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
> > > > complaint about it is that since it's maintained outside of the
> > > > kernel, it's constantly behind about 0.75 revisions behind the latest
> > > > 2.6 release.  The feature set of swsusp2, if they can ever get it
> > > > completely bugfree(tm) is certainly impressive.
> > > 
> > > I'd like it to be merged upstream too.
> > 
> > Are we talking 2.6 or 2.7 here?
> 
> 2.6. I don't see any problem merging it at this point as long as
> it's not invasive (I haven't looked at the code though). If it's
> self-contained, it's more/less like adding a driver.

:-( [I just hand-selected most intrusive stuff, there's more of it].

I guess this is non starter. I'm afraid this is non-starter even for
2.7.

Anyway this solves my problem. I need swsusp working with highmem. I
thought I might simply switch to swsusp2, but that is not really an
option.

[Well, it only *looks* ugly, those macros are nops on non-swsusp
system. But it seems way too intrusive anyway].

								Pavel

diff -ruN linux-2.6.2/drivers/acpi/sleep/proc.c software-suspend-linux-2.6.2/drivers/acpi/sleep/proc.c
--- linux-2.6.2/drivers/acpi/sleep/proc.c	2004-02-06 17:27:23.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/acpi/sleep/proc.c	2004-02-06 17:41:09.000000000 +1300
@@ -1,7 +1,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
+#include <linux/sched.h>
 #include <linux/bcd.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -54,6 +56,9 @@
 	char	str[12];
 	u32	state = 0;
 	int	error = 0;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_PAUSING;
 
 	if (count > sizeof(str) - 1)
 		goto Done;
@@ -61,6 +66,7 @@
 	if (copy_from_user(str, buffer, count))
 		return -EFAULT;
 
+
 	/* Check for S4 bios request */
 	if (!strcmp(str,"4b")) {
 		error = acpi_suspend(4);
@@ -75,6 +81,7 @@
 #endif
 	error = acpi_suspend(state);
  Done:
+	SWSUSP_ACTIVITY_RESTARTING(0);
 	return error ? error : count;
 }


(and similar changes in)
 
+++ software-suspend-linux-2.6.2/drivers/char/hvc_console.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/char/n_tty.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/char/tty_io.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/media/video/msp3400.c	2004-02-06 17:43:15.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/media/video/tvaudio.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/message/i2o/i2o_core.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/mtd/mtdblock.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/net/irda/sir_kthread.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/parport/ieee1284.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/pcmcia/cs.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/usb/core/hub.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/drivers/usb/storage/usb.c	2004-02-06 17:41:09.000000000 +1300
diff -ruN linux-2.6.2/fs/buffer.c software-suspend-linux-2.6.2/fs/buffer.c
--- linux-2.6.2/fs/buffer.c	2004-02-06 17:27:46.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/buffer.c	2004-02-06 17:41:09.000000000 +1300
@@ -37,6 +37,7 @@
 #include <linux/bio.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/init.h>
 #include <asm/bitops.h>
 
 static void invalidate_bh_lrus(void);
@@ -229,16 +230,24 @@
  */
 int fsync_super(struct super_block *sb)
 {
-	sync_inodes_sb(sb, 0);
-	DQUOT_SYNC(sb);
-	lock_super(sb);
-	if (sb->s_dirt && sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
-	sync_inodes_sb(sb, 1);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	if (likely(!(swsusp_state & FREEZE_UNREFRIGERATED)))
+#endif
+	{
+		sync_inodes_sb(sb, 0);
+		DQUOT_SYNC(sb);
+		lock_super(sb);
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		unlock_super(sb);
+		if (sb->s_op->sync_fs)
+			sb->s_op->sync_fs(sb, 1);
+		sync_blockdev(sb->s_bdev);
+		sync_inodes_sb(sb, 1);
+	}
 
 	return sync_blockdev(sb->s_bdev);
 }
@@ -251,12 +260,20 @@
 int fsync_bdev(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
+	int result = 0;
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+	
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 	if (sb) {
 		int res = fsync_super(sb);
 		drop_super(sb);
 		return res;
 	}
-	return sync_blockdev(bdev);
+	result = sync_blockdev(bdev);
+	current->flags &= ~PF_SYNCTHREAD;
+ 	SWSUSP_ACTIVITY_END;
+	return result;
 }
 
 /*
@@ -265,20 +282,34 @@
  */
 static void do_sync(unsigned long wait)
 {
-	wakeup_bdflush(0);
-	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
-	DQUOT_SYNC(NULL);
-	sync_supers();		/* Write the superblocks */
-	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(wait);	/* Waitingly sync the filesystems */
-	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
-	if (!wait)
-		printk("Emergency Sync complete\n");
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	if (likely(!(swsusp_state & FREEZE_UNREFRIGERATED)))
+#endif
+	{
+		wakeup_bdflush(0);
+		sync_inodes(0);		/* All mappings, inodes and their blockdevs */
+		DQUOT_SYNC(NULL);
+		sync_supers();		/* Write the superblocks */
+		sync_filesystems(0);	/* Start syncing the filesystems */
+		sync_filesystems(wait);	/* Waitingly sync the filesystems */
+		sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+		if (!wait)
+			printk("Emergency Sync complete\n");
+	}
 }
 
 asmlinkage long sys_sync(void)
 {
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 	do_sync(1);
+	current->flags &= ~PF_SYNCTHREAD;
+ 	SWSUSP_ACTIVITY_END;
 	return 0;
 }
 
@@ -319,6 +350,10 @@
 	struct file * file;
 	struct address_space *mapping;
 	int ret, err;
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 
 	ret = -EBADF;
 	file = fget(fd);
@@ -349,6 +384,8 @@
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -357,6 +394,10 @@
 	struct file * file;
 	struct address_space *mapping;
 	int ret, err;
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 
 	ret = -EBADF;
 	file = fget(fd);
@@ -384,6 +425,8 @@
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -1071,6 +1114,10 @@
 	 * async buffer heads in use.
 	 */
 	free_more_memory();
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	if (suspend_task == current->pid)
+		cleanup_finished_swsusp_io();
+#endif
 	goto try_again;
 }
 
@@ -2800,7 +2847,7 @@
  *
  * try_to_free_buffers() is non-blocking.
  */
-static inline int buffer_busy(struct buffer_head *bh)
+inline int buffer_busy(struct buffer_head *bh)
 {
 	return atomic_read(&bh->b_count) |
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
diff -ruN linux-2.6.2/fs/dcache.c software-suspend-linux-2.6.2/fs/dcache.c
--- linux-2.6.2/fs/dcache.c	2004-01-13 16:17:23.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/dcache.c	2004-02-06 17:41:09.000000000 +1300
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/file.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
@@ -1372,10 +1373,13 @@
 	struct vfsmount *pwdmnt, *rootmnt;
 	struct dentry *pwd, *root;
 	char *page = (char *) __get_free_page(GFP_USER);
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (!page)
 		return -ENOMEM;
 
+	SWSUSP_ACTIVITY_START(0);
+
 	read_lock(&current->fs->lock);
 	pwdmnt = mntget(current->fs->pwdmnt);
 	pwd = dget(current->fs->pwd);
@@ -1413,6 +1417,7 @@
 	dput(root);
 	mntput(rootmnt);
 	free_page((unsigned long) page);
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
diff -ruN linux-2.6.2/fs/devfs/base.c software-suspend-linux-2.6.2/fs/devfs/base.c
--- linux-2.6.2/fs/devfs/base.c	2004-02-06 17:27:46.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/devfs/base.c	2004-02-06 17:41:09.000000000 +1300
@@ -676,6 +676,7 @@
 #include <linux/smp.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -2607,11 +2608,13 @@
     struct fs_info *fs_info = file->f_dentry->d_inode->i_sb->s_fs_info;
     struct devfsd_notify_struct *info = fs_info->devfsd_info;
     DECLARE_WAITQUEUE (wait, current);
+    DECLARE_SWSUSP_LOCAL_VAR;
 
     /*  Can't seek (pread) on this device  */
     if (ppos != &file->f_pos) return -ESPIPE;
     /*  Verify the task has grabbed the queue  */
     if (fs_info->devfsd_task != current) return -EPERM;
+    current->flags |= PF_SYNCTHREAD;
     info->major = 0;
     info->minor = 0;
     /*  Block for a new entry  */
@@ -2621,12 +2624,15 @@
     {
 	fs_info->devfsd_sleeping = TRUE;
 	wake_up (&fs_info->revalidate_wait_queue);
+        SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING;
 	schedule ();
+        SWSUSP_ACTIVITY_RESTARTING(0);
 	fs_info->devfsd_sleeping = FALSE;
 	if ( signal_pending (current) )
 	{
 	    remove_wait_queue (&fs_info->devfsd_wait_queue, &wait);
 	    __set_current_state (TASK_RUNNING);
+    	    current->flags &= ~PF_SYNCTHREAD;
 	    return -EINTR;
 	}
 	set_current_state (TASK_INTERRUPTIBLE);
@@ -2650,7 +2656,10 @@
 	info->minor = MINOR(de->u.bdev.dev);
     }
     pos = devfs_generate_path (de, info->devname, DEVFS_PATHLEN);
-    if (pos < 0) return pos;
+    if (pos < 0) {
+    	    current->flags &= ~PF_SYNCTHREAD;
+	    return pos;
+    }
     info->namelen = DEVFS_PATHLEN - pos - 1;
     if (info->mode == 0) info->mode = de->mode;
     devname_offset = info->devname - (char *) info;
@@ -2662,6 +2671,7 @@
 	if (tlen > len) tlen = len;
 	if ( copy_to_user (buf, (char *) info + rpos, tlen) )
 	{
+    	    current->flags &= ~PF_SYNCTHREAD;
 	    return -EFAULT;
 	}
 	rpos += tlen;
@@ -2677,6 +2687,7 @@
 	if ( copy_to_user (buf, info->devname + pos + rpos - devname_offset,
 			   tlen) )
 	{
+    	    current->flags &= ~PF_SYNCTHREAD;
 	    return -EFAULT;
 	}
 	rpos += tlen;
@@ -2700,6 +2711,7 @@
 	*ppos = 0;
     }
     else *ppos = rpos;
+    current->flags &= ~PF_SYNCTHREAD;
     return tlen;
 }   /*  End Function devfsd_read  */
 
diff -ruN linux-2.6.2/fs/exec.c software-suspend-linux-2.6.2/fs/exec.c
--- linux-2.6.2/fs/exec.c	2004-02-06 17:27:47.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/exec.c	2004-02-06 17:41:09.000000000 +1300
@@ -45,6 +45,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/rmap-locking.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -120,6 +121,9 @@
 	struct file * file;
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	nd.intent.open.flags = FMODE_READ;
 	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
@@ -160,6 +164,7 @@
 	}
 	fput(file);
 out:
+	SWSUSP_ACTIVITY_END;
   	return error;
 exit:
 	path_release(&nd);
@@ -1090,14 +1095,19 @@
 	struct file *file;
 	int retval;
 	int i;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	sched_balance_exec();
 
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		SWSUSP_ACTIVITY_END;
 		return retval;
+	}
 
 	bprm.p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 	memset(bprm.page, 0, MAX_ARG_PAGES*sizeof(bprm.page[0]));
@@ -1153,6 +1163,7 @@
 
 		/* execve success */
 		security_bprm_free(&bprm);
+		SWSUSP_ACTIVITY_END;
 		return retval;
 	}
 
@@ -1176,6 +1187,7 @@
 		allow_write_access(bprm.file);
 		fput(bprm.file);
 	}
+	SWSUSP_ACTIVITY_END;
 	return retval;
 }
 
@@ -1366,6 +1378,9 @@
 	struct inode * inode;
 	struct file * file;
 	int retval = 0;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	lock_kernel();
 	binfmt = current->binfmt;
@@ -1413,5 +1428,6 @@
 	complete_all(&mm->core_done);
 fail:
 	unlock_kernel();
+	SWSUSP_ACTIVITY_END;
 	return retval;
 }
diff -ruN linux-2.6.2/fs/fcntl.c software-suspend-linux-2.6.2/fs/fcntl.c
--- linux-2.6.2/fs/fcntl.c	2004-02-06 17:27:47.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/fcntl.c	2004-02-06 17:41:09.000000000 +1300
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/suspend.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -153,6 +154,9 @@
 	int err = -EBADF;
 	struct file * file, *tofree;
 	struct files_struct * files = current->files;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	spin_lock(&files->file_lock);
 	if (!(file = fcheck(oldfd)))
@@ -191,6 +195,7 @@
 		filp_close(tofree, files);
 	err = newfd;
 out:
+	SWSUSP_ACTIVITY_END;
 	return err;
 out_unlock:
 	spin_unlock(&files->file_lock);
@@ -206,9 +211,13 @@
 {
 	int ret = -EBADF;
 	struct file * file = fget(fildes);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (file)
 		ret = dupfd(file, 0);
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -357,6 +366,9 @@
 {	
 	struct file * filp;
 	long err = -EBADF;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	filp = fget(fd);
 	if (!filp)
@@ -365,6 +377,7 @@
 	err = security_file_fcntl(filp, cmd, arg);
 	if (err) {
 		fput(filp);
+		SWSUSP_ACTIVITY_END;
 		return err;
 	}
 
@@ -372,6 +385,7 @@
 
  	fput(filp);
 out:
+	SWSUSP_ACTIVITY_END;
 	return err;
 }
 
@@ -380,6 +394,9 @@
 {	
 	struct file * filp;
 	long err;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	err = -EBADF;
 	filp = fget(fd);
@@ -389,6 +406,7 @@
 	err = security_file_fcntl(filp, cmd, arg);
 	if (err) {
 		fput(filp);
+		SWSUSP_ACTIVITY_END;
 		return err;
 	}
 	err = -EBADF;
@@ -407,6 +425,7 @@
 	}
 	fput(filp);
 out:
+	SWSUSP_ACTIVITY_END;
 	return err;
 }
 #endif

(and more in)
+++ software-suspend-linux-2.6.2/fs/jbd/journal.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/jffs/intrep.c	2004-02-06 17:43:15.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/jffs2/background.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/jfs/jfs_logmgr.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/jfs/jfs_txnmgr.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/lockd/clntlock.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/lockd/clntproc.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/lockd/svc.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/locks.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/namei.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/namespace.c	2004-02-06 17:41:09.000000000 +1300
@@ -21,6 +21,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 
 extern int __init init_rootfs(void);
@@ -377,6 +378,9 @@
 {
 	struct nameidata nd;
 	int retval;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	retval = __user_walk(name, LOOKUP_FOLLOW, &nd);
 	if (retval)
@@ -395,6 +399,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return retval;
 }
 
@@ -877,10 +882,15 @@
 	unsigned long type_page;
 	unsigned long dev_page;
 	char *dir_page;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	retval = copy_mount_options (type, &type_page);
-	if (retval < 0)
+	if (retval < 0) {
+		SWSUSP_ACTIVITY_END;
 		return retval;
+	}
 
 	dir_page = getname(dir_name);
 	retval = PTR_ERR(dir_page);
@@ -907,6 +917,7 @@
 	putname(dir_page);
 out1:
 	free_page(type_page);
+	SWSUSP_ACTIVITY_END;
 	return retval;
 }
 
@@ -999,10 +1010,12 @@
 	struct vfsmount *tmp;
 	struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	SWSUSP_ACTIVITY_START(0);
 	lock_kernel();
 
 	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
@@ -1079,6 +1092,7 @@
 	path_release(&new_nd);
 out0:
 	unlock_kernel();
+	SWSUSP_ACTIVITY_END;
 	return error;
 out3:
 	spin_unlock(&vfsmount_lock);
diff -ruN linux-2.6.2/fs/open.c software-suspend-linux-2.6.2/fs/open.c
--- linux-2.6.2/fs/open.c	2004-02-06 17:27:48.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/open.c	2004-02-06 17:41:09.000000000 +1300
@@ -19,6 +19,7 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
@@ -109,6 +110,9 @@
 {
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = user_path_walk(path, &nd);
 	if (!error) {
@@ -118,6 +122,7 @@
 			error = -EFAULT;
 		path_release(&nd);
 	}
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -126,9 +131,13 @@
 {
 	struct nameidata nd;
 	long error;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (sz != sizeof(*buf))
 		return -EINVAL;
+	
+	SWSUSP_ACTIVITY_START(0);
+
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs64 tmp;
@@ -137,6 +146,7 @@
 			error = -EFAULT;
 		path_release(&nd);
 	}
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -146,6 +156,9 @@
 	struct file * file;
 	struct statfs tmp;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = -EBADF;
 	file = fget(fd);
@@ -156,6 +169,7 @@
 		error = -EFAULT;
 	fput(file);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -164,10 +178,13 @@
 	struct file * file;
 	struct statfs64 tmp;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (sz != sizeof(*buf))
 		return -EINVAL;
 
+	SWSUSP_ACTIVITY_START(0);
+
 	error = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -177,6 +194,7 @@
 		error = -EFAULT;
 	fput(file);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -202,6 +220,9 @@
 	struct nameidata nd;
 	struct inode * inode;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = -EINVAL;
 	if (length < 0)	/* sorry, but loff_t says... */
@@ -254,6 +275,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -269,6 +291,9 @@
 	struct dentry *dentry;
 	struct file * file;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = -EINVAL;
 	if (length < 0)
@@ -303,6 +328,7 @@
 out_putf:
 	fput(file);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -343,6 +369,9 @@
 	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = user_path_walk(filename, &nd);
 	if (error)
@@ -384,6 +413,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -399,6 +429,9 @@
 	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = user_path_walk(filename, &nd);
 
@@ -437,6 +470,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -461,10 +495,13 @@
 	int old_fsuid, old_fsgid;
 	kernel_cap_t old_cap;
 	int res;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
 
+	SWSUSP_ACTIVITY_START(0);
+
 	old_fsuid = current->fsuid;
 	old_fsgid = current->fsgid;
 	old_cap = current->cap_effective;
@@ -499,6 +536,7 @@
 	current->fsgid = old_fsgid;
 	current->cap_effective = old_cap;
 
+	SWSUSP_ACTIVITY_END;
 	return res;
 }
 
@@ -506,6 +544,9 @@
 {
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
 	if (error)
@@ -520,6 +561,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -530,6 +572,9 @@
 	struct inode *inode;
 	struct vfsmount *mnt;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = -EBADF;
 	file = fget(fd);
@@ -550,6 +595,7 @@
 out_putf:
 	fput(file);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -557,6 +603,9 @@
 {
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = __user_walk(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
 	if (error)
@@ -576,6 +625,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -586,6 +636,9 @@
 	struct file * file;
 	int err = -EBADF;
 	struct iattr newattrs;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	file = fget(fd);
 	if (!file)
@@ -611,6 +664,7 @@
 out_putf:
 	fput(file);
 out:
+	SWSUSP_ACTIVITY_END;
 	return err;
 }
 
@@ -620,6 +674,9 @@
 	struct inode * inode;
 	int error;
 	struct iattr newattrs;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = user_path_walk(filename, &nd);
 	if (error)
@@ -645,6 +702,7 @@
 dput_and_out:
 	path_release(&nd);
 out:
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -687,12 +745,16 @@
 {
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
 		error = chown_common(nd.dentry, user, group);
 		path_release(&nd);
 	}
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -700,12 +762,16 @@
 {
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
 		error = chown_common(nd.dentry, user, group);
 		path_release(&nd);
 	}
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -714,12 +780,16 @@
 {
 	struct file * file;
 	int error = -EBADF;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	file = fget(fd);
 	if (file) {
 		error = chown_common(file->f_dentry, user, group);
 		fput(file);
 	}
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -929,6 +999,9 @@
 {
 	char * tmp;
 	int fd, error;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 #if BITS_PER_LONG != 32
 	flags |= O_LARGEFILE;
@@ -947,6 +1020,7 @@
 out:
 		putname(tmp);
 	}
+	SWSUSP_ACTIVITY_END;
 	return fd;
 
 out_error:
@@ -1009,6 +1083,9 @@
 {
 	struct file * filp;
 	struct files_struct *files = current->files;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	spin_lock(&files->file_lock);
 	if (fd >= files->max_fds)
@@ -1020,10 +1097,12 @@
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
+	SWSUSP_ACTIVITY_END;
 	return filp_close(filp, files);
 
 out_unlock:
 	spin_unlock(&files->file_lock);
+	SWSUSP_ACTIVITY_END;
 	return -EBADF;
 }
 
@@ -1035,10 +1114,15 @@
  */
 asmlinkage long sys_vhangup(void)
 {
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 	if (capable(CAP_SYS_TTY_CONFIG)) {
 		tty_vhangup(current->tty);
+		SWSUSP_ACTIVITY_END;
 		return 0;
 	}
+	SWSUSP_ACTIVITY_END;
 	return -EPERM;
 }
 
diff -ruN linux-2.6.2/fs/pipe.c software-suspend-linux-2.6.2/fs/pipe.c
--- linux-2.6.2/fs/pipe.c	2004-02-06 17:27:48.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/pipe.c	2004-02-06 17:41:09.000000000 +1300
@@ -14,6 +14,7 @@
 #include <linux/mount.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/uio.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
@@ -36,10 +37,13 @@
 void pipe_wait(struct inode * inode)
 {
 	DEFINE_WAIT(wait);
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
 	up(PIPE_SEM(*inode));
+	SWSUSP_ACTIVITY_PAUSING;
 	schedule();
+	SWSUSP_ACTIVITY_RESTARTING(0);
 	finish_wait(PIPE_WAIT(*inode), &wait);
 	down(PIPE_SEM(*inode));
 }

(and more)
+++ software-suspend-linux-2.6.2/fs/proc/generic.c	2004-02-06 17:41:09.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/proc/kmsg.c	2004-02-06 17:41:09.000000000 +1300
diff -ruN linux-2.6.2/fs/read_write.c software-suspend-linux-2.6.2/fs/read_write.c
--- linux-2.6.2/fs/read_write.c	2004-02-06 17:27:48.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/read_write.c	2004-02-06 17:41:09.000000000 +1300
@@ -13,6 +13,7 @@
 #include <linux/dnotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 
@@ -126,6 +127,9 @@
 	off_t retval;
 	struct file * file;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	retval = -EBADF;
 	file = fget_light(fd, &fput_needed);
@@ -141,6 +145,7 @@
 	}
 	fput_light(file, fput_needed);
 bad:
+	SWSUSP_ACTIVITY_END;
 	return retval;
 }
 
@@ -153,6 +158,9 @@
 	struct file * file;
 	loff_t offset;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	retval = -EBADF;
 	file = fget_light(fd, &fput_needed);
@@ -175,6 +183,7 @@
 out_putf:
 	fput_light(file, fput_needed);
 bad:
+	SWSUSP_ACTIVITY_END;
 	return retval;
 }
 #endif
@@ -272,12 +281,16 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = vfs_read(file, buf, count, &file->f_pos);
 		fput_light(file, fput_needed);
 	}
+	SWSUSP_ACTIVITY_END;
 
 	return ret;
 }
@@ -287,6 +300,9 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
+	
+	SWSUSP_ACTIVITY_START(0);
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
@@ -294,6 +310,7 @@
 		fput_light(file, fput_needed);
 	}
 
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -303,16 +320,20 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 	int fput_needed;
-
+	DECLARE_SWSUSP_LOCAL_VAR;
+	
 	if (pos < 0)
 		return -EINVAL;
 
+	SWSUSP_ACTIVITY_START(0);
+
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = vfs_read(file, buf, count, &pos);
 		fput_light(file, fput_needed);
 	}
 
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -322,16 +343,19 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (pos < 0)
 		return -EINVAL;
 
+	SWSUSP_ACTIVITY_START(0);
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = vfs_write(file, buf, count, &pos);
 		fput_light(file, fput_needed);
 	}
 
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -509,13 +533,16 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
+	SWSUSP_ACTIVITY_START(0);
 	file = fget_light(fd, &fput_needed);
 	if (file) {
 		ret = vfs_readv(file, vec, vlen, &file->f_pos);
 		fput_light(file, fput_needed);
 	}
 
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -525,6 +552,9 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 	int fput_needed;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
@@ -532,6 +562,7 @@
 		fput_light(file, fput_needed);
 	}
 
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -622,33 +653,48 @@
 	loff_t pos;
 	off_t off;
 	ssize_t ret;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (offset) {
 		if (unlikely(get_user(off, offset)))
-			return -EFAULT;
-		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
-		if (unlikely(put_user(pos, offset)))
-			return -EFAULT;
+			ret = -EFAULT;
+		else {
+			pos = off;
+			ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+			if (unlikely(put_user(pos, offset)))
+				ret = -EFAULT;
+		}
+		SWSUSP_ACTIVITY_END;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, MAX_NON_LFS);
+	ret = do_sendfile(out_fd, in_fd, NULL, count, MAX_NON_LFS);
+	SWSUSP_ACTIVITY_END;
+	return ret;
 }
 
 asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t __user *offset, size_t count)
 {
 	loff_t pos;
 	ssize_t ret;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
-		if (unlikely(put_user(pos, offset)))
-			return -EFAULT;
+		else {
+			ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+			if (unlikely(put_user(pos, offset)))
+				ret = -EFAULT;
+		}
+		SWSUSP_ACTIVITY_END;
 		return ret;
 	}
 
+	SWSUSP_ACTIVITY_END;
 	return do_sendfile(out_fd, in_fd, NULL, count, 0);
 }
diff -ruN linux-2.6.2/fs/stat.c software-suspend-linux-2.6.2/fs/stat.c
--- linux-2.6.2/fs/stat.c	2004-02-06 17:27:49.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/stat.c	2004-02-06 17:43:15.000000000 +1300
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/security.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 
@@ -150,30 +151,42 @@
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_old_stat(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_lstat(char __user * filename, struct __old_kernel_stat __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_old_stat(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_fstat(unsigned int fd, struct __old_kernel_stat __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_old_stat(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -229,30 +242,42 @@
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_newlstat(char __user * filename, struct stat __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -260,10 +285,13 @@
 {
 	struct nameidata nd;
 	int error;
+	DECLARE_SWSUSP_LOCAL_VAR;
 
 	if (bufsiz <= 0)
 		return -EINVAL;
 
+	SWSUSP_ACTIVITY_START(0);
+
 	error = user_path_walk_link(path, &nd);
 	if (!error) {
 		struct inode * inode = nd.dentry->d_inode;
@@ -278,6 +306,7 @@
 		}
 		path_release(&nd);
 	}
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
@@ -324,30 +353,42 @@
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat64(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_lstat64(char __user * filename, struct stat64 __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat64(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user * statbuf)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
 	if (!error)
 		error = cp_new_stat64(&stat, statbuf);
 
+	SWSUSP_ACTIVITY_END;
 	return error;
 }
 
diff -ruN linux-2.6.2/fs/super.c software-suspend-linux-2.6.2/fs/super.c
--- linux-2.6.2/fs/super.c	2004-01-13 16:19:45.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/super.c	2004-02-06 17:41:09.000000000 +1300
@@ -34,6 +34,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <asm/uaccess.h>
+#include <linux/suspend.h>
 
 
 void get_filesystem(struct file_system_type *fs);
@@ -430,6 +431,9 @@
         struct ustat tmp;
         struct kstatfs sbuf;
 	int err = -EINVAL;
+	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(0);
 
         s = user_get_super(new_decode_dev(dev));
         if (s == NULL)
@@ -445,6 +449,7 @@
 
         err = copy_to_user(ubuf,&tmp,sizeof(struct ustat)) ? -EFAULT : 0;
 out:
+	SWSUSP_ACTIVITY_END;
 	return err;
 }
 

...and more....

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

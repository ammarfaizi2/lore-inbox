Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269992AbRHJTtl>; Fri, 10 Aug 2001 15:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269993AbRHJTtd>; Fri, 10 Aug 2001 15:49:33 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:20741
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269992AbRHJTtU>; Fri, 10 Aug 2001 15:49:20 -0400
Date: Fri, 10 Aug 2001 15:49:06 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
Message-ID: <992230000.997472946@tiny>
In-Reply-To: <Pine.GSO.4.21.0108091856020.25945-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi guys,

Here's a new patch against 2.4.8-pre8, updated to Al's new super
handling.  The differences between the original are small, 
but they are big enough that I want extra testing from the
LVM guys (and ext3/XFS).  Linus is just cc'd as an FYI.

Changes:

fsync_dev_lockfs(0) will just call fsync_dev instead of
trying to lock every FS on the system.  LVM always sends
a real device, so it doesn't change any of the current
users.  If someone wants to experiment with locking all
of them, let me know (I'm guessing you'll end up deadlocked
somewhere).

unlockfs() grabs mount_sem so that we don't race
against someone mounting the FS.  It can't lock the super
because somebody might be waiting for the FS to unlock
with the super lock already held.  

-chris

--- linux/include/linux/fs.h	Thu Aug  9 12:43:59 2001
+++ linux/include/linux/fs.h	Fri Aug 10 14:24:17 2001
@@ -1161,6 +1161,7 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
@@ -1170,6 +1171,8 @@
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
--- linux/kernel/ksyms.c	Thu Aug  9 12:41:36 2001
+++ linux/kernel/ksyms.c	Fri Aug 10 14:03:49 2001
@@ -177,6 +177,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
 EXPORT_SYMBOL(inode_setattr);
--- linux/drivers/md/lvm.c	Wed Jul 11 12:35:37 2001
+++ linux/drivers/md/lvm.c	Fri Aug 10 14:03:49 2001
@@ -161,9 +161,6 @@
 #define MAJOR_NR	LVM_BLK_MAJOR
 #define	DEVICE_OFF(device)
 
-/* lvm_do_lv_create calls fsync_dev_lockfs()/unlockfs() */
-/* #define	LVM_VFS_ENHANCEMENT */
-
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -2321,12 +2318,8 @@
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
 		lv_t *org = lv_ptr->lv_snapshot_org, *last;
 
-		/* sync the original logical volume */
-		fsync_dev(org->lv_dev);
-#ifdef	LVM_VFS_ENHANCEMENT
 		/* VFS function call to sync and lock the filesystem */
 		fsync_dev_lockfs(org->lv_dev);
-#endif
 
 		down(&org->lv_snapshot_sem);
 		org->lv_access |= LV_SNAPSHOT_ORG;
@@ -2346,12 +2339,10 @@
 	else
 		set_device_ro(lv_ptr->lv_dev, 1);
 
-#ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
 		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
 	}
-#endif
 
 	lv_ptr->vg = vg_ptr;
 
--- linux/fs/buffer.c	Thu Aug  9 12:41:36 2001
+++ linux/fs/buffer.c	Fri Aug 10 14:16:52 2001
@@ -374,6 +374,34 @@
 	fsync_dev(dev);
 }
 
+int fsync_dev_lockfs(kdev_t dev)
+{
+	/* you are not allowed to try locking all the filesystems
+	** on the system, your chances of getting through without
+	** total deadlock are slim to none.
+	*/
+	if (!dev)
+		return fsync_dev(dev) ;
+
+	sync_buffers(dev, 0);
+
+	lock_kernel();
+	/* note, the FS might need to start transactions to 
+	** sync the inodes, or the quota, no locking until
+	** after these are done
+	*/
+	sync_inodes(dev);
+	DQUOT_SYNC(dev);
+	/* if inodes or quotas could be dirtied during the
+	** sync_supers_lockfs call, the FS is responsible for getting
+	** them on disk, without deadlocking against the lock
+	*/
+	sync_supers_lockfs(dev) ;
+	unlock_kernel();
+
+	return sync_buffers(dev, 1) ;
+}
+
 asmlinkage long sys_sync(void)
 {
 	fsync_dev(0);
--- linux/fs/super.c	Thu Aug  9 12:41:36 2001
+++ linux/fs/super.c	Fri Aug 10 15:34:32 2001
@@ -681,6 +681,18 @@
 			sb->s_op->write_super(sb);
 	unlock_super(sb);
 }
+
+static inline void write_super_lockfs(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root) {
+		if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op && sb->s_op->write_super_lockfs)
+			sb->s_op->write_super_lockfs(sb);
+	}
+	unlock_super(sb);
+}
  
 /*
  * Note: check the dirty flag before waiting, so we don't
@@ -714,6 +726,48 @@
 		} else
 			sb = sb_entry(sb->s_list.next);
 	spin_unlock(&sb_lock);
+}
+
+/*
+ * Note: don't check the dirty flag before waiting, we want the lock
+ * to happen every time this is called.  dev must be non-zero
+ */
+void sync_supers_lockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	if (dev) {
+		sb = get_super(dev);
+		if (sb) {
+			write_super_lockfs(sb);
+			drop_super(sb);
+		}
+	}
+}
+
+void unlockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	if (dev) {
+		/* we cannot lock the super here because someone
+		** might be waiting on the unlock with the
+		** super already locked
+		**
+		** so, we grab the mount semaphore instead, we have
+		** to make sure nobody is mounting during our
+		** unlock operation.  The FS won't unmount because it
+		** was locked.
+		*/
+		down(&mount_sem);
+		sb = get_super(dev);
+		if (sb) {
+			if (sb->s_op && sb->s_op->unlockfs)
+				sb->s_op->unlockfs(sb) ;
+			drop_super(sb);
+		}
+		up(&mount_sem);
+	}
 }
 
 /**
--- linux/fs/reiserfs/super.c	Fri Jun 29 11:38:17 2001
+++ linux/fs/reiserfs/super.c	Fri Aug 10 15:17:08 2001
@@ -80,7 +80,7 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;








Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUAGPxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUAGPxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:53:08 -0500
Received: from smtp14.eresmas.com ([62.81.235.114]:10891 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S266225AbUAGPwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:52:55 -0500
Message-ID: <3FFC2B15.4000803@wanadoo.es>
Date: Wed, 07 Jan 2004 16:51:49 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LVM <linux-lvm@sistina.com>
Subject: [PATCH] 2.4.25--pre4 VFS lvm_snapshots
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050302060600090608050509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050302060600090608050509
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi,

This patch is necessary to be able to mount snapshots of journalling
filesystems. It was flying around lvm for long time, years!!.
And LiNUX distributions bring it, Red Hat at least since 7.x.
So, it should be sure.

Last thread about it [1] is recent and the patch still is pending...

[1] http://marc.theaimsgroup.com/?t=106623259800004&r=1&w=2

-thanks-

--------------050302060600090608050509
Content-Type: text/plain;
 name="VFS-lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VFS-lock.patch"

diff -Nuar a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	2004-01-06 15:41:19.000000000 +0100
+++ b/drivers/md/lvm.c	2004-01-07 15:35:13.000000000 +0100
@@ -236,9 +236,6 @@
 #define DEVICE_OFF(device)
 #define LOCAL_END_REQUEST
 
-/* lvm_do_lv_create calls fsync_dev_lockfs()/unlockfs() */
-/* #define	LVM_VFS_ENHANCEMENT */
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -2250,12 +2247,8 @@
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
 		lv_t *org = lv_ptr->lv_snapshot_org, *last;
 
-		/* sync the original logical volume */
-		fsync_dev(org->lv_dev);
-#ifdef	LVM_VFS_ENHANCEMENT
 		/* VFS function call to sync and lock the filesystem */
 		fsync_dev_lockfs(org->lv_dev);
-#endif
 
 		down_write(&org->lv_lock);
 		org->lv_access |= LV_SNAPSHOT_ORG;
@@ -2281,11 +2274,9 @@
 	else
 		set_device_ro(lv_ptr->lv_dev, 1);
 
-#ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
 	if (lv_ptr->lv_access & LV_SNAPSHOT)
 		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
-#endif
 
 	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].de =
 	    lvm_fs_create_lv(vg_ptr, lv_ptr);
diff -Nuar a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	2004-01-06 15:41:29.000000000 +0100
+++ b/fs/buffer.c	2004-01-07 15:43:24.000000000 +0100
@@ -419,6 +419,34 @@
 	fsync_dev(dev);
 }
 
+int fsync_dev_lockfs(kdev_t dev)
+{
+	/* you are not allowed to try locking all the filesystems
+	 * on the system, your chances of getting through without
+	 * total deadlock are slim to none.
+	 */
+	if (!dev)
+		return fsync_dev(dev);
+
+	sync_buffers(dev, 0);
+
+	lock_kernel();
+	/* note, the FS might need to start transactions to 
+	 * sync the inodes, or the quota, no locking until
+	 * after these are done
+	 */
+	sync_inodes(dev);
+	DQUOT_SYNC(dev);
+	/* if inodes or quotas could be dirtied during the
+	 * sync_supers_lockfs call, the FS is responsible for getting
+	 * them on disk, without deadlocking against the lock
+	 */
+	sync_supers_lockfs(dev);
+	unlock_kernel();
+
+	return sync_buffers(dev, 1);
+}
+
 asmlinkage long sys_sync(void)
 {
 	fsync_dev(0);
diff -Nuar a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	2003-08-27 17:26:49.000000000 +0200
+++ b/fs/reiserfs/super.c	2004-01-07 15:44:17.000000000 +0100
@@ -73,7 +73,7 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
diff -Nuar a/fs/super.c b/fs/super.c
--- a/fs/super.c	2003-08-27 17:26:49.000000000 +0200
+++ b/fs/super.c	2004-01-07 15:59:23.000000000 +0100
@@ -39,6 +39,14 @@
 spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
 /*
+ * lock/unlockfs grab a read lock on s_umount, but you need this lock to
+ * make sure no lockfs runs are in progress before inserting/removing
+ * supers from the list.
+ */
+
+static DECLARE_MUTEX(lockfs_sem);
+
+/*
  * Handling of filesystem drivers list.
  * Rules:
  *	Inclusion to/removals from/scanning of list are protected by spinlock.
@@ -436,6 +444,18 @@
 	put_super(sb);
 }
 
+static void write_super_lockfs(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_op) {
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op->write_super_lockfs)
+			sb->s_op->write_super_lockfs(sb);
+        }
+	unlock_super(sb);
+}
+
 static inline void write_super(struct super_block *sb)
 {
 	lock_super(sb);
@@ -483,6 +503,39 @@
 	spin_unlock(&sb_lock);
 }
 
+/*
+ * Note: don't check the dirty flag before waiting, we want the lock
+ * to happen every time this is called.  dev must be non-zero
+ */
+void sync_supers_lockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	down(&lockfs_sem);
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
+		sb = get_super(dev);
+		if (sb) {
+			if (sb->s_op && sb->s_op->unlockfs)
+				sb->s_op->unlockfs(sb);
+			drop_super(sb);
+		}
+	}
+	up(&lockfs_sem);
+}
+
 /**
  *	get_super	-	get the superblock of a device
  *	@dev: device to get the superblock for
@@ -702,6 +755,7 @@
 		goto out1;
 
 	error = -EBUSY;
+	down(&lockfs_sem);
 restart:
 	spin_lock(&sb_lock);
 
@@ -713,6 +767,7 @@
 		    ((flags ^ old->s_flags) & MS_RDONLY)) {
 			spin_unlock(&sb_lock);
 			destroy_super(s);
+			up(&lockfs_sem);
 			goto out1;
 		}
 		if (!grab_super(old))
@@ -720,12 +775,14 @@
 		destroy_super(s);
 		blkdev_put(bdev, BDEV_FS);
 		path_release(&nd);
+		up(&lockfs_sem);
 		return old;
 	}
 	s->s_dev = dev;
 	s->s_bdev = bdev;
 	s->s_flags = flags;
 	insert_super(s, fs_type);
+	up(&lockfs_sem);
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto Einval;
 	s->s_flags |= MS_ACTIVE;
@@ -833,7 +890,9 @@
 	if (!deactivate_super(sb))
 		return;
 
+	down(&lockfs_sem);
 	down_write(&sb->s_umount);
+	up(&lockfs_sem);
 	sb->s_root = NULL;
 	/* Need to clean after the sucker */
 	if (fs->fs_flags & FS_LITTER)
diff -Nuar a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2004-01-06 15:41:41.000000000 +0100
+++ b/include/linux/fs.h	2004-01-07 16:00:46.000000000 +0100
@@ -1277,6 +1277,7 @@
 extern int sync_buffers(kdev_t, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
@@ -1295,6 +1296,8 @@
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t dev, int wait);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
diff -Nuar a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	2004-01-06 15:41:43.000000000 +0100
+++ b/kernel/ksyms.c	2004-01-07 16:01:23.000000000 +0100
@@ -194,6 +194,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(fsync_no_super);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);

--------------050302060600090608050509--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275067AbRJOITE>; Mon, 15 Oct 2001 04:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJOISz>; Mon, 15 Oct 2001 04:18:55 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:19410
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S275067AbRJOISj>; Mon, 15 Oct 2001 04:18:39 -0400
Date: Mon, 15 Oct 2001 04:18:42 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Ed Tomlinson <tomlins@CAM.ORG>,
        Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <2314290000.1003133922@tiny>
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[ bad lvm<->reiserfs locking patch causes hangs ]

Ok, here's an updated patch, one liner fix from the original.

-chris

Index: 0.41/fs/super.c
--- 0.41/fs/super.c Thu, 11 Oct 2001 09:27:57 -0400 root (linux/d/45_super.c 1.1.2.1.4.1.2.1 644)
+++ 0.42/fs/super.c Mon, 15 Oct 2001 03:42:49 -0400 root (linux/d/45_super.c 1.1.2.1.4.1.2.2 644)
@@ -54,6 +54,8 @@
 LIST_HEAD(super_blocks);
 spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
+static DECLARE_MUTEX(lockfs_sem);
+
 /*
  * Handling of filesystem drivers list.
  * Rules:
@@ -322,6 +324,19 @@
 			sb->s_op->write_super(sb);
 	unlock_super(sb);
 }
+
+static inline void write_super_lockfs(struct super_block *sb)
+{
+	lock_super(sb);
+	if (sb->s_root && sb->s_op) {
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op->write_super_lockfs) {
+			sb->s_op->write_super_lockfs(sb);
+		}
+	}
+	unlock_super(sb);
+}
  
 /*
  * Note: check the dirty flag before waiting, so we don't
@@ -357,6 +372,39 @@
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
+				sb->s_op->unlockfs(sb) ;
+			drop_super(sb);
+		}
+	}
+	up(&lockfs_sem);
+}
+
 /**
  *	get_super	-	get the superblock of a device
  *	@dev: device to get the superblock for
@@ -578,6 +626,7 @@
 	if (!s)
 		goto out1;
 	down_write(&s->s_umount);
+	down(&lockfs_sem) ;
 
 	error = -EBUSY;
 restart:
@@ -590,11 +639,13 @@
 		if (old->s_type != fs_type ||
 		    ((flags ^ old->s_flags) & MS_RDONLY)) {
 			spin_unlock(&sb_lock);
+			up(&lockfs_sem);
 			put_super(s);
 			goto out1;
 		}
 		if (!grab_super(old))
 			goto restart;
+		up(&lockfs_sem);
 		put_super(s);
 		blkdev_put(bdev, BDEV_FS);
 		path_release(&nd);
@@ -615,6 +666,9 @@
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto out_fail;
 	unlock_super(s);
+
+	up(&lockfs_sem);
+
 	get_filesystem(fs_type);
 	path_release(&nd);
 	return s;
@@ -623,6 +677,7 @@
 	s->s_dev = 0;
 	s->s_bdev = 0;
 	s->s_type = NULL;
+	up(&lockfs_sem) ;
 	unlock_super(s);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
@@ -728,6 +783,7 @@
 	sb->s_count -= S_BIAS;
 	spin_unlock(&sb_lock);
 
+	down(&lockfs_sem);
 	down_write(&sb->s_umount);
 	lock_kernel();
 	sb->s_root = NULL;
@@ -744,6 +800,7 @@
 		if (sop->put_super)
 			sop->put_super(sb);
 	}
+	up(&lockfs_sem);
 
 	/* Forget any remaining inodes */
 	if (invalidate_inodes(sb)) {
Index: 0.41/fs/buffer.c
--- 0.41/fs/buffer.c Sun, 14 Oct 2001 10:34:39 -0400 root (linux/i/46_buffer.c 1.1.2.1.9.1.4.1 644)
+++ 0.42/fs/buffer.c Mon, 15 Oct 2001 03:42:49 -0400 root (linux/i/46_buffer.c 1.1.2.1.9.1.4.2 644)
@@ -359,6 +359,34 @@
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
Index: 0.41/drivers/md/lvm.c
--- 0.41/drivers/md/lvm.c Sun, 23 Sep 2001 20:11:16 -0400 root (linux/i/c/30_lvm.c 1.1.2.1 644)
+++ 0.42/drivers/md/lvm.c Mon, 15 Oct 2001 03:42:49 -0400 root (linux/i/c/30_lvm.c 1.1.2.1.9.1 644)
@@ -161,9 +161,6 @@
 #define MAJOR_NR	LVM_BLK_MAJOR
 #define	DEVICE_OFF(device)
 
-/* lvm_do_lv_create calls fsync_dev_lockfs()/unlockfs() */
-/* #define	LVM_VFS_ENHANCEMENT */
-
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -2301,12 +2298,8 @@
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
@@ -2326,12 +2319,10 @@
 	else
 		set_device_ro(lv_ptr->lv_dev, 1);
 
-#ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
 		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
 	}
-#endif
 
 	lv_ptr->vg = vg_ptr;
 
Index: 0.41/kernel/ksyms.c
--- 0.41/kernel/ksyms.c Sun, 14 Oct 2001 10:34:39 -0400 root (linux/n/c/22_ksyms.c 1.1.2.1.9.1.4.1 644)
+++ 0.42/kernel/ksyms.c Mon, 15 Oct 2001 03:42:49 -0400 root (linux/n/c/22_ksyms.c 1.1.2.1.9.1.4.2 644)
@@ -178,6 +178,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(fsync_no_super);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
Index: 0.41/include/linux/fs.h
--- 0.41/include/linux/fs.h Sun, 14 Oct 2001 10:34:39 -0400 root (linux/f/d/9_fs.h 1.1.2.1.10.1.2.2 644)
+++ 0.42/include/linux/fs.h Mon, 15 Oct 2001 03:42:49 -0400 root (linux/f/d/9_fs.h 1.1.2.1.10.1.2.2.1.1 644)
@@ -1185,6 +1185,7 @@
 extern int sync_buffers(kdev_t, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
@@ -1196,6 +1197,8 @@
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);


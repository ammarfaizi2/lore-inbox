Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJNRRW>; Sun, 14 Oct 2001 13:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275811AbRJNRRM>; Sun, 14 Oct 2001 13:17:12 -0400
Received: from cogito.cam.org ([198.168.100.2]:29702 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S275790AbRJNRQ5>;
	Sun, 14 Oct 2001 13:16:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Alexander Viro <viro@math.psu.edu>, Chris Mason <mason@suse.com>
Subject: Re: mount hanging 2.4.12
Date: Sun, 14 Oct 2001 08:11:50 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014121151.9973F18F0C@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 14, 2001 01:46 am, Alexander Viro wrote:
> On Sun, 14 Oct 2001, Alexander Viro wrote:
> > 	Deadlocks on lock_super().  I don't see any changes in that
> > area, though...
>
> Erm, wait...  What patches do you have applied?  After a second look
> at your objdump it seems that you've got spinlocks turned into semaphores.
> What the hell is going on there?

OK this rings a bell.  I use reiserfs and LVM (1.01-rc4).  For snapshots to
work Chris Mason created a VFS locking patch - I am using the version below.
Suspect this is what is doing the down.

Chris, I will forward a few messages other messages to give you the context.

Ed

--- 0.11/fs/super.c Fri, 05 Oct 2001 14:39:50 -0400 root (linux/d/45_super.c 1.1.2.1.2.1 644)
+++ 0.12/fs/super.c Fri, 05 Oct 2001 23:52:55 -0400 root (linux/d/45_super.c 1.1.2.1.2.2 644)
@@ -54,6 +56,8 @@
 LIST_HEAD(super_blocks);
 spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
+static DECLARE_MUTEX(lockfs_sem);
+
 /*
  * Handling of filesystem drivers list.
  * Rules:
@@ -333,6 +337,19 @@
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
@@ -368,6 +385,39 @@
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
@@ -591,6 +641,7 @@
 	if (!s)
 		goto out1;
 	down_write(&s->s_umount);
+	down(&lockfs_sem) ;
 
 	error = -EBUSY;
 restart:
@@ -603,11 +654,13 @@
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
@@ -628,6 +681,9 @@
 	if (!fs_type->read_super(s, data, 0))
 		goto out_fail;
 	unlock_super(s);
+
+	up(&lockfs_sem);
+
 	get_filesystem(fs_type);
 	path_release(&nd);
 	return s;
@@ -741,6 +797,7 @@
 	sb->s_count -= S_BIAS;
 	spin_unlock(&sb_lock);
 
+	down(&lockfs_sem);
 	down_write(&sb->s_umount);
 	lock_kernel();
 	sb->s_root = NULL;
@@ -757,6 +814,7 @@
 		if (sop->put_super)
 			sop->put_super(sb);
 	}
+	up(&lockfs_sem);
 
 	/* Forget any remaining inodes */
 	if (invalidate_inodes(sb)) {
Index: 0.11/fs/buffer.c
--- 0.11/fs/buffer.c Fri, 05 Oct 2001 14:39:50 -0400 root (linux/i/46_buffer.c 1.1.2.1.7.1 644)
+++ 0.12/fs/buffer.c Fri, 05 Oct 2001 23:52:55 -0400 root (linux/i/46_buffer.c 1.1.2.1.7.2 644)
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
Index: 0.11/drivers/md/lvm.c
--- 0.11/drivers/md/lvm.c Sun, 23 Sep 2001 20:11:16 -0400 root (linux/i/c/30_lvm.c 1.1.2.1 644)
+++ 0.12/drivers/md/lvm.c Fri, 05 Oct 2001 23:52:55 -0400 root (linux/i/c/30_lvm.c 1.1.2.1.2.1 644)
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
-/* VFS function call to unlock the filesystem */
+	/* VFS function call to unlock the filesystem */
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
 		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
 	}
-#endif
 
 	lv_ptr->vg = vg_ptr;
 
Index: 0.11/kernel/ksyms.c
--- 0.11/kernel/ksyms.c Fri, 05 Oct 2001 14:39:50 -0400 root (linux/n/c/22_ksyms.c 1.1.2.1.7.1 644)
+++ 0.12/kernel/ksyms.c Fri, 05 Oct 2001 23:52:55 -0400 root (linux/n/c/22_ksyms.c 1.1.2.1.7.2 644)
@@ -178,6 +178,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(fsync_no_super);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
Index: 0.11/include/linux/fs.h
--- 0.11/include/linux/fs.h Fri, 05 Oct 2001 14:39:50 -0400 root (linux/f/d/9_fs.h 1.1.2.1.8.1 644)
+++ 0.12/include/linux/fs.h Fri, 05 Oct 2001 23:52:55 -0400 root (linux/f/d/9_fs.h 1.1.2.1.8.2 644)
@@ -1182,6 +1182,7 @@
 extern int sync_buffers(kdev_t, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
@@ -1193,6 +1194,8 @@
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);



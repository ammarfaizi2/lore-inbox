Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271923AbRHVEHN>; Wed, 22 Aug 2001 00:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271925AbRHVEGy>; Wed, 22 Aug 2001 00:06:54 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:5767 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S271923AbRHVEGm>; Wed, 22 Aug 2001 00:06:42 -0400
Date: Wed, 22 Aug 2001 00:06:39 -0400
From: Chris Mason <mason@suse.com>
To: alan@redhat.com, Alexander Viro <viro@math.psu.edu>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
Message-ID: <227990000.998453199@tiny>
In-Reply-To: <992230000.997472946@tiny>
In-Reply-To: <992230000.997472946@tiny>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here's a version against 2.4.8-ac8, tested against ext2 and
reiserfs.  Andreas reported ext3 success with the last patch,
and none of the LVM guys have complained yet ;-)

BTW [sistina folks], it might be a good idea to update lvm-1.0.x 
the 2.4.4 VFS-lock patches no longer apply cleanly.

Alan, please include:

-chris

# allow LVM to lock the filesystem during snapshot creation, so the
# FS can flush pending changes and put things into a consistent state.
#
# includes small fix to current reiserfs support, forcing a transaction
# commit during the lock.
#
#
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Tue Aug 21 23:55:59 2001
+++ b/drivers/md/lvm.c	Tue Aug 21 23:55:59 2001
@@ -182,9 +182,6 @@
 #define DEVICE_OFF(device)
 #define LOCAL_END_REQUEST
 
-/* lvm_do_lv_create calls fsync_dev_lockfs()/unlockfs() */
-/* #define	LVM_VFS_ENHANCEMENT */
-
 #include <linux/config.h>
 #include <linux/version.h>
 
@@ -1933,12 +1930,8 @@
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
@@ -1962,12 +1955,10 @@
 	else
 		set_device_ro(lv_ptr->lv_dev, 1);
 
-#ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
 	if (lv_ptr->lv_access & LV_SNAPSHOT) {
 		unlockfs(lv_ptr->lv_snapshot_org->lv_dev);
 	}
-#endif
 
 	lv_ptr->vg = vg_ptr;
 
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Tue Aug 21 23:55:59 2001
+++ b/fs/buffer.c	Tue Aug 21 23:55:59 2001
@@ -350,6 +350,34 @@
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
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue Aug 21 23:55:59 2001
+++ b/fs/reiserfs/super.c	Tue Aug 21 23:55:59 2001
@@ -66,7 +66,7 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Tue Aug 21 23:55:59 2001
+++ b/fs/super.c	Tue Aug 21 23:55:59 2001
@@ -637,6 +637,18 @@
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
+		if (sb->s_op->write_super_lockfs)
+			sb->s_op->write_super_lockfs(sb);
+	}
+	unlock_super(sb);
+}
  
 /*
  * Note: check the dirty flag before waiting, so we don't
@@ -670,6 +682,48 @@
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
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Aug 21 23:55:59 2001
+++ b/include/linux/fs.h	Tue Aug 21 23:55:59 2001
@@ -1223,6 +1223,7 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
@@ -1232,6 +1233,8 @@
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Aug 21 23:55:59 2001
+++ b/kernel/ksyms.c	Tue Aug 21 23:55:59 2001
@@ -178,6 +178,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(fsync_no_super);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270599AbRHIWU7>; Thu, 9 Aug 2001 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHIWUt>; Thu, 9 Aug 2001 18:20:49 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:17420
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S270599AbRHIWUn>; Thu, 9 Aug 2001 18:20:43 -0400
Date: Thu, 09 Aug 2001 18:20:42 -0400
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu,
        lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
Message-ID: <505560000.997395642@tiny>
In-Reply-To: <200108092058.f79KwIKn024532@webber.adilger.int>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here it is:

LVM_VFS_ENHANCEMENT #define is gone, lvm only calls fsync_dev_lockfs
when syncing for the snapshot

sync_supers_lockfs calls write_super if the super is dirty,
and write_super_lockfs (regardless of dirty state).

Works on reiserfs and ext2, should not break other filesystems
using the old patch.

updated to 2.4.8-pre7

-chris

diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Thu Aug  9 18:17:52 2001
+++ b/drivers/md/lvm.c	Thu Aug  9 18:17:52 2001
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
 
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu Aug  9 18:17:52 2001
+++ b/fs/buffer.c	Thu Aug  9 18:17:52 2001
@@ -368,6 +368,27 @@
 	fsync_dev(dev);
 }
 
+int fsync_dev_lockfs(kdev_t dev)
+{
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
--- a/fs/reiserfs/super.c	Thu Aug  9 18:17:52 2001
+++ b/fs/reiserfs/super.c	Thu Aug  9 18:17:52 2001
@@ -80,7 +80,7 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Aug  9 18:17:52 2001
+++ b/fs/super.c	Thu Aug  9 18:17:52 2001
@@ -672,6 +672,49 @@
 	}
 }
 
+/*
+ * Note: don't check the dirty flag before waiting, we want the lock
+ * to happen every time this is called.
+ */
+void sync_supers_lockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	for (sb = sb_entry(super_blocks.next);
+	     sb != sb_entry(&super_blocks); 
+	     sb = sb_entry(sb->s_list.next)) {
+		if (!sb->s_dev)
+			continue;
+		if (dev && sb->s_dev != dev)
+			continue;
+		lock_super(sb);
+		if (sb->s_dev && (!dev || dev == sb->s_dev)) {
+			if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
+				sb->s_op->write_super(sb);
+			if (sb->s_op && sb->s_op->write_super_lockfs)
+				sb->s_op->write_super_lockfs(sb);
+		}
+		unlock_super(sb);
+	}
+}
+
+void unlockfs(kdev_t dev)
+{
+	struct super_block * sb;
+
+	for (sb = sb_entry(super_blocks.next);
+	     sb != sb_entry(&super_blocks); 
+	     sb = sb_entry(sb->s_list.next)) {
+		if (!sb->s_dev)
+			continue;
+		if (dev && sb->s_dev != dev)
+			continue;
+		if (sb->s_dev && (!dev || dev == sb->s_dev))
+			if (sb->s_op && sb->s_op->unlockfs)
+				sb->s_op->unlockfs(sb);
+	}
+}
+
 /**
  *	get_super	-	get the superblock of a device
  *	@dev: device to get the superblock for
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Aug  9 18:17:52 2001
+++ b/include/linux/fs.h	Thu Aug  9 18:17:52 2001
@@ -1160,6 +1160,7 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_dev_lockfs(kdev_t);
 extern int fsync_super(struct super_block *);
 extern void sync_inodes_sb(struct super_block *);
 extern int fsync_inode_buffers(struct inode *);
@@ -1168,6 +1169,8 @@
 extern void filemap_fdatasync(struct address_space *);
 extern void filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
+extern void sync_supers_lockfs(kdev_t);
+extern void unlockfs(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Aug  9 18:17:52 2001
+++ b/kernel/ksyms.c	Thu Aug  9 18:17:52 2001
@@ -176,6 +176,8 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);
+EXPORT_SYMBOL(fsync_dev_lockfs);
+EXPORT_SYMBOL(unlockfs);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
 EXPORT_SYMBOL(inode_setattr);




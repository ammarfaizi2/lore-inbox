Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUCIV3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUCIV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:29:16 -0500
Received: from ns.suse.de ([195.135.220.2]:32433 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262211AbUCIV2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:28:49 -0500
Subject: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078867885.25075.1458.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 16:31:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

In order to get consistent snapshots with the device mapper code, you
need to sync and lock down any filesystems sitting on top of the
device.  This isn't as critical in the 2.6 code since it can do writable
snapshots, but it is still nice to have things properly synced and
consistent.  

I've had various forms of this against 2.4, the ugly part was always the
locking to make sure a new FS wasn't mounted on the source while the
snapshot was being setup.  Here's my 2.6 version, with the DM code
contributed by Kevin Corry.  The basic idea is to add a semaphore to the
block device that gets used to make sure there are no new mounts.

This needs the rest of Joe's device mapper updates to be useful, but I
wanted to send here for comments on locking and other issues:

-chris

Index: linux.dm/fs/block_dev.c
===================================================================
--- linux.dm.orig/fs/block_dev.c	2004-02-27 15:47:10.796588369 -0500
+++ linux.dm/fs/block_dev.c	2004-02-27 15:48:41.512740351 -0500
@@ -242,6 +242,7 @@
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		sema_init(&bdev->bd_sem, 1);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
Index: linux.dm/fs/super.c
===================================================================
--- linux.dm.orig/fs/super.c	2004-02-27 15:47:11.065508887 -0500
+++ linux.dm/fs/super.c	2004-02-27 15:48:41.521737673 -0500
@@ -292,6 +292,62 @@
 }
 
 /*
+ * triggered by the device mapper code to lock a filesystem and force
+ * it into a consistent state.
+ *
+ * This takes the block device bd_mount_sem to make sure no new mounts
+ * happen on bdev until unlockfs is called.  If a super is found on this
+ * block device, we hould a read lock on the s->s_umount sem to make sure
+ * nobody unmounts until the snapshot creation is done
+ */
+void sync_super_lockfs(struct block_device *bdev) 
+{
+	struct super_block *sb;
+	down(&bdev->bd_mount_sem);
+	sb = get_super(bdev);
+	if (sb) {
+		lock_super(sb);
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op->write_super_lockfs)
+			sb->s_op->write_super_lockfs(sb);
+		unlock_super(sb);
+	}
+	/* unlockfs releases s->s_umount and bd_mount_sem */
+}
+
+void unlockfs(struct block_device *bdev)
+{
+	struct list_head *p;
+	/*
+	 * copied from get_super, but we need to
+	 * do special things since lockfs left the
+	 * s_umount sem held
+	 */
+	spin_lock(&sb_lock);
+	list_for_each(p, &super_blocks) {
+		struct super_block *s = sb_entry(p);
+		/*
+		 * if there is a super for this block device
+		 * in the list, get_super must have found it
+		 * during sync_super_lockfs, so our drop_super
+		 * will drop the reference created there.
+		 */
+		if (s->s_bdev == bdev && s->s_root) {
+			spin_unlock(&sb_lock);
+			if (s->s_op->unlockfs)
+				s->s_op->unlockfs(s);
+			drop_super(s);
+			goto unlock;
+		}
+	}
+	spin_unlock(&sb_lock);
+unlock:
+	up(&bdev->bd_mount_sem);
+}
+EXPORT_SYMBOL(unlockfs);
+
+/*
  * Note: check the dirty flag before waiting, so we don't
  * hold up the sync while mounting a device. (The newly
  * mounted device won't need syncing.)
@@ -612,7 +668,14 @@
 	if (IS_ERR(bdev))
 		return (struct super_block *)bdev;
 
+	/*
+	 * once the super is inserted into the list by sget, s_umount
+	 * will protect the lockfs code from trying to start a snapshot
+	 * while we are mounting
+	 */
+	down(&bdev->bd_mount_sem);
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
+	up(&bdev->bd_mount_sem);
 	if (IS_ERR(s))
 		goto out;
 
Index: linux.dm/fs/buffer.c
===================================================================
--- linux.dm.orig/fs/buffer.c	2004-02-27 15:47:36.139106189 -0500
+++ linux.dm/fs/buffer.c	2004-02-27 15:48:41.516739161 -0500
@@ -260,6 +260,17 @@
 	return sync_blockdev(bdev);
 }
 
+int fsync_bdev_lockfs(struct block_device *bdev)
+{
+	int res;
+	res = fsync_bdev(bdev);
+	if (res)
+		return res;
+	sync_super_lockfs(bdev);
+	return sync_blockdev(bdev);
+}
+EXPORT_SYMBOL(fsync_bdev_lockfs);
+
 /*
  * sync everything.  Start out by waking pdflush, because that writes back
  * all queues in parallel.
Index: linux.dm/drivers/md/dm.c
===================================================================
--- linux.dm.orig/drivers/md/dm.c	2004-02-27 15:48:38.171735120 -0500
+++ linux.dm/drivers/md/dm.c	2004-02-27 15:48:41.510740946 -0500
@@ -12,6 +12,7 @@
 #include <linux/moduleparam.h>
 #include <linux/blkpg.h>
 #include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
 
@@ -51,6 +52,7 @@
  */
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
+#define DMF_FS_LOCKED 2
 
 struct mapped_device {
 	struct rw_semaphore lock;
@@ -844,6 +846,24 @@
 	return 0;
 }
 
+static void __lock_disk(struct gendisk *disk)
+{
+	struct block_device *bdev = bdget_disk(disk, 0);
+	if (bdev) {
+		fsync_bdev_lockfs(bdev);
+		bdput(bdev);
+	}
+}
+
+static void __unlock_disk(struct gendisk *disk)
+{
+	struct block_device *bdev = bdget_disk(disk, 0);
+	if (bdev) {
+		unlockfs(bdev);
+		bdput(bdev);
+	}
+}
+
 /*
  * We need to be able to change a mapping table under a mounted
  * filesystem.  For example we might want to move some data in
@@ -855,12 +875,23 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-	down_write(&md->lock);
+	/* Flush I/O to the device. */
+	down_read(&md->lock);
+	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		up_read(&md->lock);
+		return -EINVAL;
+	}
+
+	if (!test_and_set_bit(DMF_FS_LOCKED, &md->flags)) {
+		__lock_disk(md->disk);
+	}
+	up_read(&md->lock);
 
 	/*
 	 * First we set the BLOCK_IO flag so no more ios will be
 	 * mapped.
 	 */
+	down_write(&md->lock);
 	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
 		up_write(&md->lock);
 		return -EINVAL;
@@ -910,11 +941,13 @@
 	dm_table_resume_targets(md->map);
 	clear_bit(DMF_SUSPENDED, &md->flags);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
+	clear_bit(DMF_FS_LOCKED, &md->flags);
 
 	def = bio_list_get(&md->deferred);
 	__flush_deferred_io(md, def);
 	up_write(&md->lock);
 
+	__unlock_disk(md->disk);
 	blk_run_queues();
 
 	return 0;
Index: linux.dm/include/linux/fs.h
===================================================================
--- linux.dm.orig/include/linux/fs.h	2004-02-27 15:47:33.193980650 -0500
+++ linux.dm/include/linux/fs.h	2004-02-27 15:48:41.532734400 -0500
@@ -343,6 +343,7 @@
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct semaphore	bd_mount_sem;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
@@ -1218,6 +1219,7 @@
 extern int filemap_flush(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
+extern void sync_super_lockfs(struct block_device *);
 extern void sync_filesystems(int wait);
 extern void emergency_sync(void);
 extern void emergency_remount(void);
Index: linux.dm/include/linux/buffer_head.h
===================================================================
--- linux.dm.orig/include/linux/buffer_head.h	2004-02-05 16:56:30.000000000 -0500
+++ linux.dm/include/linux/buffer_head.h	2004-02-27 15:48:41.530734995 -0500
@@ -164,6 +164,8 @@
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
 int fsync_bdev(struct block_device *);
+int fsync_bdev_lockfs(struct block_device *);
+void unlockfs(struct block_device *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
 struct buffer_head *__find_get_block(struct block_device *, sector_t, int);





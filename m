Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUDAUgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUDAUgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:36:47 -0500
Received: from ns.suse.de ([195.135.220.2]:37267 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263148AbUDAUgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:36:32 -0500
Subject: Re: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, thornber@redhat.com, kevcorry@us.ibm.com
In-Reply-To: <20040326102549.A4248@infradead.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	 <20040313131447.A25900@infradead.org>
	 <1079191213.4187.243.camel@watt.suse.com>
	 <20040313163346.A27004@infradead.org> <20040314140032.A8901@infradead.org>
	 <1079277810.4183.249.camel@watt.suse.com>
	 <20040326102549.A4248@infradead.org>
Content-Type: multipart/mixed; boundary="=-8QGXIM7xuc98BxyFeMpO"
Message-Id: <1080851723.3547.285.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 15:35:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8QGXIM7xuc98BxyFeMpO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-03-26 at 05:25, Christoph Hellwig wrote:
> On Sun, Mar 14, 2004 at 10:23:31AM -0500, Chris Mason wrote:
> > > P.S. this patch now kills 16 lines of kernel code summarized :)
> > > 
> > 
> > It looks good, I'll give it a try.
> 
> ping?  I've seen you merged the old patch into the suse tree, and having
> shipping distros with incompatible APIs doesn't sound exactly like a good
> idea..

Christoph's vfs patch looks good, I've stripped out the XFS bits (FS
parts should probably be in different patches) and made one small
change.  freeze/thaw now check to make sure bdev != NULL.

On the device mapper side, I had to add a struct super_block pointer to
the dm struct and changed it to pin the bdev struct during the freeze. 
Before, it could go away due to bdput, leading to deadlock when someone
else got a bdev struct with bd_mount_sem held.

New patches attached, along with an incremental to clearly show my
changes to the dm patch.

-chris


--=-8QGXIM7xuc98BxyFeMpO
Content-Disposition: attachment; filename=vfs-lockfs-2
Content-Type: text/plain; name=vfs-lockfs-2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- 1.225/mm/filemap.c	Mon Mar  8 15:21:17 2004
+++ edited/mm/filemap.c	Sun Mar 14 14:16:40 2004
@@ -1746,6 +1746,8 @@
 	unsigned long	seg;
 	char __user	*buf;
 
+	vfs_check_frozen(inode->i_sb, SB_FREEZE_WRITE);
+
 	ocount = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
 		const struct iovec *iv = &iov[seg];


Index: linux.t/fs/block_dev.c
===================================================================
--- linux.t.orig/fs/block_dev.c	2004-04-01 08:55:22.000000000 -0500
+++ linux.t/fs/block_dev.c	2004-04-01 09:05:36.000000000 -0500
@@ -251,6 +251,7 @@ static void init_once(void * foo, kmem_c
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		sema_init(&bdev->bd_sem, 1);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
Index: linux.t/fs/super.c
===================================================================
--- linux.t.orig/fs/super.c	2004-04-01 08:54:28.000000000 -0500
+++ linux.t/fs/super.c	2004-04-01 09:05:36.000000000 -0500
@@ -77,6 +77,7 @@ static struct super_block *alloc_super(v
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqonoff_sem, 1);
 		init_rwsem(&s->s_dquot.dqptr_sem);
+		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
@@ -621,7 +622,14 @@ struct super_block *get_sb_bdev(struct f
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
 
Index: linux.t/fs/buffer.c
===================================================================
--- linux.t.orig/fs/buffer.c	2004-04-01 08:55:22.000000000 -0500
+++ linux.t/fs/buffer.c	2004-04-01 13:27:01.478991040 -0500
@@ -265,6 +265,73 @@ int fsync_bdev(struct block_device *bdev
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
+struct super_block *freeze_bdev(struct block_device *bdev)
+{
+	struct super_block *sb;
+
+	if (!bdev)
+		return NULL;
+	down(&bdev->bd_mount_sem);
+	sb = get_super(bdev);
+	if (sb && !(sb->s_flags & MS_RDONLY)) {
+		sb->s_frozen = SB_FREEZE_WRITE;
+		wmb();
+
+		sync_inodes_sb(sb, 0);
+		DQUOT_SYNC(sb);
+
+		sb->s_frozen = SB_FREEZE_TRANS;
+		wmb();
+		
+		lock_super(sb);
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		unlock_super(sb);
+
+		if (sb->s_op->sync_fs)
+			sb->s_op->sync_fs(sb, 1);
+	
+		sync_blockdev(sb->s_bdev);
+		sync_inodes_sb(sb, 1);
+		sync_blockdev(sb->s_bdev);
+
+		if (sb->s_op->write_super_lockfs)
+			sb->s_op->write_super_lockfs(sb);
+	}
+
+	sync_blockdev(bdev);
+	return sb;	/* thaw_bdev releases s->s_umount and bd_mount_sem */
+}
+EXPORT_SYMBOL(freeze_bdev);
+
+void thaw_bdev(struct block_device *bdev, struct super_block *sb)
+{
+	if (!bdev)
+		return;
+	if (sb) {
+		BUG_ON(sb->s_bdev != bdev);
+
+		if (sb->s_op->unlockfs)
+			sb->s_op->unlockfs(sb);
+		sb->s_frozen = SB_UNFROZEN;
+		wmb();
+		wake_up(&sb->s_wait_unfrozen);
+		drop_super(sb);
+	}
+
+	up(&bdev->bd_mount_sem);
+}
+EXPORT_SYMBOL(thaw_bdev);
+
+/*
  * sync everything.  Start out by waking pdflush, because that writes back
  * all queues in parallel.
  */
Index: linux.t/include/linux/fs.h
===================================================================
--- linux.t.orig/include/linux/fs.h	2004-04-01 08:55:22.000000000 -0500
+++ linux.t/include/linux/fs.h	2004-04-01 09:05:36.000000000 -0500
@@ -344,6 +344,7 @@ struct block_device {
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct semaphore	bd_mount_sem;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
@@ -722,6 +723,9 @@ struct super_block {
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	int			s_frozen;
+	wait_queue_head_t	s_wait_unfrozen;
+
 	char s_id[32];				/* Informational name */
 
 	struct kobject           kobj;          /* anchor for sysfs */
@@ -735,6 +739,18 @@ struct super_block {
 };
 
 /*
+ * Snapshotting support.
+ */
+enum {
+	SB_UNFROZEN = 0,
+	SB_FREEZE_WRITE	= 1,
+	SB_FREEZE_TRANS = 2,
+};
+
+#define vfs_check_frozen(sb, level) \
+	wait_event((sb)->s_wait_unfrozen, ((sb)->s_frozen < (level)))
+
+/*
  * Superblock locking.
  */
 static inline void lock_super(struct super_block * sb)
Index: linux.t/include/linux/buffer_head.h
===================================================================
--- linux.t.orig/include/linux/buffer_head.h	2004-02-05 16:56:30.000000000 -0500
+++ linux.t/include/linux/buffer_head.h	2004-04-01 09:05:36.000000000 -0500
@@ -164,6 +164,8 @@ void __wait_on_buffer(struct buffer_head
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
 int fsync_bdev(struct block_device *);
+struct super_block *freeze_bdev(struct block_device *);
+void thaw_bdev(struct block_device *, struct super_block *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
 struct buffer_head *__find_get_block(struct block_device *, sector_t, int);

--=-8QGXIM7xuc98BxyFeMpO
Content-Disposition: attachment; filename=dm-09-dm-lockfs
Content-Type: text/plain; name=dm-09-dm-lockfs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Lock the filesystem while a device is suspended.  [Kevin Corry, Joe Thornber]
Index: linux.t/drivers/md/dm.c
===================================================================
--- linux.t.orig/drivers/md/dm.c	2004-04-01 13:29:22.000000000 -0500
+++ linux.t/drivers/md/dm.c	2004-04-01 14:54:57.911207304 -0500
@@ -12,6 +12,7 @@
 #include <linux/moduleparam.h>
 #include <linux/blkpg.h>
 #include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
 
@@ -46,6 +47,7 @@ struct target_io {
  */
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
+#define DMF_FS_LOCKED 2
 
 struct mapped_device {
 	struct rw_semaphore lock;
@@ -80,6 +82,11 @@ struct mapped_device {
 	 */
 	uint32_t event_nr;
 	wait_queue_head_t eventq;
+
+	/*
+	 * freeze/thaw support require holding onto a super block
+	 */
+	struct super_block *frozen_sb;
 };
 
 #define MIN_IOS 256
@@ -895,6 +902,52 @@ int dm_swap_table(struct mapped_device *
 }
 
 /*
+ * Functions to lock and unlock any filesystem running on the
+ * device.
+ */
+static int __lock_fs(struct mapped_device *md)
+{
+	struct block_device *bdev;
+
+	if (test_and_set_bit(DMF_FS_LOCKED, &md->flags))
+		return 0;
+
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev) {
+		DMWARN("bdget failed in __lock_fs");
+		return -ENOMEM;
+	}
+
+	WARN_ON(md->frozen_sb);
+	md->frozen_sb = freeze_bdev(bdev);
+	/* don't bdput right now, we don't want the bdev
+	 * to go away while it is locked.  We'll bdput
+	 * in __unlock_fs
+	 */
+	return 0;
+}
+
+static int __unlock_fs(struct mapped_device *md)
+{
+	struct block_device *bdev;
+
+	if (!test_and_clear_bit(DMF_FS_LOCKED, &md->flags))
+		return 0;
+
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev) {
+		DMWARN("bdget failed in __unlock_fs");
+		return -ENOMEM;
+	}
+
+	thaw_bdev(bdev, md->frozen_sb);
+	md->frozen_sb = NULL;
+	bdput(bdev);
+	bdput(bdev);
+	return 0;
+}
+
+/*
  * We need to be able to change a mapping table under a mounted
  * filesystem.  For example we might want to move some data in
  * the background.  Before the table can be swapped with
@@ -906,13 +959,27 @@ int dm_suspend(struct mapped_device *md)
 	struct dm_table *map;
 	DECLARE_WAITQUEUE(wait, current);
 
-	down_write(&md->lock);
+	/* Flush I/O to the device. */
+	down_read(&md->lock);
+	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		up_read(&md->lock);
+		return -EINVAL;
+	}
+
+	__lock_fs(md);
+	up_read(&md->lock);
 
 	/*
 	 * First we set the BLOCK_IO flag so no more ios will be
 	 * mapped.
 	 */
+	down_write(&md->lock);
 	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		/*
+		 * If we get here we know another thread is
+		 * trying to suspend as well, so we leave the fs
+		 * locked for this thread.
+		 */
 		up_write(&md->lock);
 		return -EINVAL;
 	}
@@ -947,6 +1014,7 @@ int dm_suspend(struct mapped_device *md)
 
 	/* were we interrupted ? */
 	if (atomic_read(&md->pending)) {
+		__unlock_fs(md);
 		clear_bit(DMF_BLOCK_IO, &md->flags);
 		up_write(&md->lock);
 		return -EINTR;
@@ -984,6 +1052,7 @@ int dm_resume(struct mapped_device *md)
 	def = bio_list_get(&md->deferred);
 	__flush_deferred_io(md, def);
 	up_write(&md->lock);
+	__unlock_fs(md);
 	dm_table_unplug_all(map);
 	dm_table_put(map);
 

--=-8QGXIM7xuc98BxyFeMpO
Content-Disposition: attachment; filename=dm-incr
Content-Type: text/x-patch; name=dm-incr; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -u linux.t/drivers/md/dm.c linux.t/drivers/md/dm.c
--- linux.t/drivers/md/dm.c	2004-03-16 11:30:55.360478210 -0500
+++ linux.t/drivers/md/dm.c	2004-04-01 14:54:57.911207304 -0500
@@ -82,6 +82,11 @@
 	 */
 	uint32_t event_nr;
 	wait_queue_head_t eventq;
+
+	/*
+	 * freeze/thaw support require holding onto a super block
+	 */
+	struct super_block *frozen_sb;
 };
 
 #define MIN_IOS 256
@@ -913,8 +918,12 @@
 		return -ENOMEM;
 	}
 
-	fsync_bdev_lockfs(bdev);
-	bdput(bdev);
+	WARN_ON(md->frozen_sb);
+	md->frozen_sb = freeze_bdev(bdev);
+	/* don't bdput right now, we don't want the bdev
+	 * to go away while it is locked.  We'll bdput
+	 * in __unlock_fs
+	 */
 	return 0;
 }
 
@@ -931,7 +940,9 @@
 		return -ENOMEM;
 	}
 
-	unlockfs(bdev);
+	thaw_bdev(bdev, md->frozen_sb);
+	md->frozen_sb = NULL;
+	bdput(bdev);
 	bdput(bdev);
 	return 0;
 }

--=-8QGXIM7xuc98BxyFeMpO--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUDQWGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 18:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbUDQWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 18:06:47 -0400
Received: from verein.lst.de ([212.34.189.10]:37311 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263121AbUDQWGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 18:06:41 -0400
Date: Sun, 18 Apr 2004 00:06:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] lockfs - vfs bits
Message-ID: <20040417220632.GA2573@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the generic lockfs bits.  Basically it takes the XFS freezing
statemachine into the VFS.  It's all behind the kernel-doc documented
freeze_bdev and thaw_bdev interfaces.

Based on an older patch from Chris Mason.


--- 1.158/fs/block_dev.c	Mon Apr 12 19:54:33 2004
+++ edited/fs/block_dev.c	Sat Apr 17 19:38:29 2004
@@ -251,6 +251,7 @@
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		sema_init(&bdev->bd_sem, 1);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
===== fs/buffer.c 1.235 vs edited =====
--- 1.235/fs/buffer.c	Mon Apr 12 19:55:21 2004
+++ edited/fs/buffer.c	Sun Apr 18 01:14:57 2004
@@ -263,6 +263,77 @@
 	return sync_blockdev(bdev);
 }
 
+/**
+ * freeze_bdev  --  lock a filesystem and force it into a consistent state
+ * @bdev:	blockdevice to lock
+ *
+ * This takes the block device bd_mount_sem to make sure no new mounts
+ * happen on bdev until thaw_bdev() is called.
+ * If a superblock is found on this device, we take the s_umount semaphore
+ * on it to make sure nobody unmounts until the snapshot creation is done.
+ */
+struct super_block *freeze_bdev(struct block_device *bdev)
+{
+	struct super_block *sb;
+
+	down(&bdev->bd_mount_sem);
+	sb = get_super(bdev);
+	if (sb && !(sb->s_flags & MS_RDONLY)) {
+		sb->s_frozen = SB_FREEZE_WRITE;
+		wmb();
+
+		sync_inodes_sb(sb, 0);
+		DQUOT_SYNC(sb);
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
+
+		sb->s_frozen = SB_FREEZE_TRANS;
+		wmb();
+
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
+/**
+ * thaw_bdev  -- unlock filesystem
+ * @bdev:	blockdevice to unlock
+ * @sb:		associated superblock
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_bdev().
+ */
+void thaw_bdev(struct block_device *bdev, struct super_block *sb)
+{
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
 /*
  * sync everything.  Start out by waking pdflush, because that writes back
  * all queues in parallel.
===== fs/super.c 1.116 vs edited =====
--- 1.116/fs/super.c	Thu Mar 25 09:39:55 2004
+++ edited/fs/super.c	Sat Apr 17 19:38:30 2004
@@ -77,6 +77,7 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqonoff_sem, 1);
 		init_rwsem(&s->s_dquot.dqptr_sem);
+		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
@@ -621,7 +622,14 @@
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
 
--- 1.46/include/linux/buffer_head.h	Tue Jan 20 00:38:11 2004
+++ edited/include/linux/buffer_head.h	Sat Apr 17 19:38:30 2004
@@ -164,6 +164,8 @@
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
 int fsync_bdev(struct block_device *);
+struct super_block *freeze_bdev(struct block_device *);
+void thaw_bdev(struct block_device *, struct super_block *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
 struct buffer_head *__find_get_block(struct block_device *, sector_t, int);
--- 1.310/include/linux/fs.h	Thu Apr 15 03:37:51 2004
+++ edited/include/linux/fs.h	Sat Apr 17 19:38:30 2004
@@ -345,6 +345,7 @@
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct semaphore	bd_mount_sem;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
@@ -749,6 +750,9 @@
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	int			s_frozen;
+	wait_queue_head_t	s_wait_unfrozen;
+
 	char s_id[32];				/* Informational name */
 
 	struct kobject           kobj;          /* anchor for sysfs */
@@ -760,6 +764,18 @@
 	 */
 	struct semaphore s_vfs_rename_sem;	/* Kludge */
 };
+
+/*
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
 
 /*
  * Superblock locking.

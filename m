Return-Path: <linux-kernel-owner+w=401wt.eu-S965171AbXAGVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbXAGVhr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbXAGVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:37:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52074 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965171AbXAGVhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:37:46 -0500
Date: Mon, 8 Jan 2007 08:37:34 +1100
From: David Chinner <dgc@sgi.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: xfs@oss.sgi.com
Subject: Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
Message-ID: <20070107213734.GS44411608@melbourne.sgi.com>
References: <20070104001420.GA32440@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104001420.GA32440@m.safari.iki.fi>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 02:14:21AM +0200, Sami Farin wrote:
> just a simple test I did...
> xfs_freeze -f /mnt/newtest
> cp /etc/fstab /mnt/newtest
> xfs_freeze -u /mnt/newtest
> 
> 2007-01-04 01:44:30.341979500 <4>BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
> 2007-01-04 01:44:30.385771500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
> 2007-01-04 01:44:30.385774500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
> 2007-01-04 01:44:30.385775500 <4> [<c0103dcb>] show_trace+0x12/0x14
> 2007-01-04 01:44:30.385777500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
> 2007-01-04 01:44:30.385778500 <4> [<c013a3af>] debug_mutex_unlock+0x69/0x120
> 2007-01-04 01:44:30.385779500 <4> [<c04b4aac>] __mutex_unlock_slowpath+0x44/0xf0
> 2007-01-04 01:44:30.385780500 <4> [<c04b4887>] mutex_unlock+0x8/0xa
> 2007-01-04 01:44:30.385782500 <4> [<c018d0ba>] thaw_bdev+0x57/0x6e
> 2007-01-04 01:44:30.385791500 <4> [<c026a6cf>] xfs_ioctl+0x7ce/0x7d3
> 2007-01-04 01:44:30.385793500 <4> [<c0269158>] xfs_file_ioctl+0x33/0x54
> 2007-01-04 01:44:30.385794500 <4> [<c01793f2>] do_ioctl+0x76/0x85
> 2007-01-04 01:44:30.385795500 <4> [<c0179570>] vfs_ioctl+0x59/0x1aa
> 2007-01-04 01:44:30.385796500 <4> [<c0179728>] sys_ioctl+0x67/0x77
> 2007-01-04 01:44:30.385797500 <4> [<c0102e73>] syscall_call+0x7/0xb
> 2007-01-04 01:44:30.385799500 <4> [<001be410>] 0x1be410
> 2007-01-04 01:44:30.385800500 <4> =======================
> 
> fstab was there just fine after -u.

Oh, that still hasn't been fixed? Generic bug, not XFS - the global
semaphore->mutex cleanup converted the bd_mount_sem to a mutex, and
mutexes complain loudly when a the process unlocking the mutex is
not the process that locked it.

Basically, the generic code is broken - the bd_mount_mutex needs to
be reverted back to a semaphore because it is locked and unlocked
by different processes. The following patch does this....

BTW, Sami, can you cc xfs@oss.sgi.com on XFS bug reports in future;
you'll get more XFS savvy eyes there.....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

---

Revert bd_mount_mutex back to a semaphore so that xfs_freeze -f /mnt/newtest;
xfs_freeze -u /mnt/newtest works safely and doesn't produce lockdep warnings.

Signed-off-by: Dave Chinner <dgc@sgi.com>


---
 fs/block_dev.c       |    2 +-
 fs/buffer.c          |    6 +++---
 fs/gfs2/ops_fstype.c |    4 ++--
 fs/super.c           |    4 ++--
 include/linux/fs.h   |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

Index: 2.6.x-xfs-new/fs/block_dev.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/block_dev.c	2006-12-22 10:53:20.000000000 +1100
+++ 2.6.x-xfs-new/fs/block_dev.c	2007-01-08 08:26:15.843378600 +1100
@@ -263,7 +263,7 @@ static void init_once(void * foo, kmem_c
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		mutex_init(&bdev->bd_mutex);
-		mutex_init(&bdev->bd_mount_mutex);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 #ifdef CONFIG_SYSFS
Index: 2.6.x-xfs-new/fs/buffer.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/buffer.c	2006-12-12 12:04:51.000000000 +1100
+++ 2.6.x-xfs-new/fs/buffer.c	2007-01-08 08:28:40.832542651 +1100
@@ -179,7 +179,7 @@ int fsync_bdev(struct block_device *bdev
  * freeze_bdev  --  lock a filesystem and force it into a consistent state
  * @bdev:	blockdevice to lock
  *
- * This takes the block device bd_mount_mutex to make sure no new mounts
+ * This takes the block device bd_mount_sem to make sure no new mounts
  * happen on bdev until thaw_bdev() is called.
  * If a superblock is found on this device, we take the s_umount semaphore
  * on it to make sure nobody unmounts until the snapshot creation is done.
@@ -188,7 +188,7 @@ struct super_block *freeze_bdev(struct b
 {
 	struct super_block *sb;
 
-	mutex_lock(&bdev->bd_mount_mutex);
+	down(&bdev->bd_mount_sem);
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
@@ -230,7 +230,7 @@ void thaw_bdev(struct block_device *bdev
 		drop_super(sb);
 	}
 
-	mutex_unlock(&bdev->bd_mount_mutex);
+	up(&bdev->bd_mount_sem);
 }
 EXPORT_SYMBOL(thaw_bdev);
 
Index: 2.6.x-xfs-new/fs/gfs2/ops_fstype.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/gfs2/ops_fstype.c	2006-12-12 12:04:58.000000000 +1100
+++ 2.6.x-xfs-new/fs/gfs2/ops_fstype.c	2007-01-08 08:27:12.847973663 +1100
@@ -867,9 +867,9 @@ static int gfs2_get_sb_meta(struct file_
 		error = -EBUSY;
 		goto error;
 	}
-	mutex_lock(&sb->s_bdev->bd_mount_mutex);
+	down(&sb->s_bdev->bd_mount_sem);
 	new = sget(fs_type, test_bdev_super, set_bdev_super, sb->s_bdev);
-	mutex_unlock(&sb->s_bdev->bd_mount_mutex);
+	up(&sb->s_bdev->bd_mount_sem);
 	if (IS_ERR(new)) {
 		error = PTR_ERR(new);
 		goto error;
Index: 2.6.x-xfs-new/fs/super.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/super.c	2006-12-22 11:45:59.000000000 +1100
+++ 2.6.x-xfs-new/fs/super.c	2007-01-08 08:24:20.718330640 +1100
@@ -736,9 +736,9 @@ int get_sb_bdev(struct file_system_type 
 	 * will protect the lockfs code from trying to start a snapshot
 	 * while we are mounting
 	 */
-	mutex_lock(&bdev->bd_mount_mutex);
+	down(&bdev->bd_mount_sem);
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
-	mutex_unlock(&bdev->bd_mount_mutex);
+	up(&bdev->bd_mount_sem);
 	if (IS_ERR(s))
 		goto error_s;
 
Index: 2.6.x-xfs-new/include/linux/fs.h
===================================================================
--- 2.6.x-xfs-new.orig/include/linux/fs.h	2006-12-12 12:06:31.000000000 +1100
+++ 2.6.x-xfs-new/include/linux/fs.h	2007-01-08 08:24:53.602060200 +1100
@@ -456,7 +456,7 @@ struct block_device {
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct mutex		bd_mutex;	/* open/close mutex */
-	struct mutex		bd_mount_mutex;	/* mount mutex */
+	struct semaphore	bd_mount_sem;
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;

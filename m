Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbUCMQeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUCMQeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 11:34:05 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5899 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263123AbUCMQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 11:33:48 -0500
Date: Sat, 13 Mar 2004 16:33:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040313163346.A27004@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
References: <1078867885.25075.1458.camel@watt.suse.com> <20040313131447.A25900@infradead.org> <1079191213.4187.243.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1079191213.4187.243.camel@watt.suse.com>; from mason@suse.com on Sat, Mar 13, 2004 at 10:20:14AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 10:20:14AM -0500, Chris Mason wrote:
> This is basically how reiserfs does it.  Various critical spots (like
> the code to start a transaction) check to see if the FS is frozen.
> 
> I'll rework the patch as we've discussed on Friday, if you need it
> broken up differently, please let me know.

Here's the reworked patch I have, ignoring dm but converting the xfs-internal
interfaces that do freezing.  But without an interface change we still need
to do all the flushing a second time inside XFS which I absoutely dislike.

Let me think about how to do this nicer.

--- 1.155/fs/block_dev.c	Fri Mar 12 10:33:01 2004
+++ edited/fs/block_dev.c	Sat Mar 13 15:28:49 2004
@@ -251,6 +251,7 @@
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		sema_init(&bdev->bd_sem, 1);
+		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
===== fs/buffer.c 1.224 vs edited =====
--- 1.224/fs/buffer.c	Sun Mar  7 08:16:11 2004
+++ edited/fs/buffer.c	Sat Mar 13 17:59:13 2004
@@ -260,6 +260,50 @@
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
+	down(&bdev->bd_mount_sem);
+	sb = get_super(bdev);
+	if (sb && !(sb->s_flags & MS_RDONLY)) {
+		fsync_super(sb);
+		lock_super(sb);
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		if (sb->s_op->write_super_lockfs)
+			sb->s_op->write_super_lockfs(sb);
+		unlock_super(sb);
+	}
+
+	sync_blockdev(bdev);
+	return sb;	/* thaw_bdev releases s->s_umount and bd_mount_sem */
+}
+EXPORT_SYMBOL(freeze_bdev);
+
+void thaw_bdev(struct block_device *bdev, struct super_block *sb)
+{
+	if (sb) {
+		BUG_ON(sb->s_bdev != bdev);
+
+		if (sb->s_op->unlockfs)
+			sb->s_op->unlockfs(sb);
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
===== fs/super.c 1.115 vs edited =====
--- 1.115/fs/super.c	Fri Mar 12 10:30:24 2004
+++ edited/fs/super.c	Sat Mar 13 15:30:35 2004
@@ -621,7 +621,14 @@
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
 
===== fs/xfs/xfs_fsops.c 1.11 vs edited =====
--- 1.11/fs/xfs/xfs_fsops.c	Fri Feb 27 07:28:05 2004
+++ edited/fs/xfs/xfs_fsops.c	Sat Mar 13 18:12:11 2004
@@ -582,15 +582,14 @@
 }
 
 int
-xfs_fs_freeze(
-	xfs_mount_t	*mp)
+xfs_freeze(
+	bhv_desc_t	*bdp)
 {
-	vfs_t		*vfsp;
+	vfs_t		*vfsp = bhvtovfs(bdp);
+	xfs_mount_t	*mp = XFS_BHVTOM(bdp);
 	/*REFERENCED*/
 	int		error;
 
-	vfsp = XFS_MTOVFS(mp);
-
 	/* Stop new writers */
 	xfs_start_freeze(mp, XFS_FREEZE_WRITE);
 
@@ -619,12 +618,11 @@
 	return 0;
 }
 
-int
-xfs_fs_thaw(
-	xfs_mount_t	*mp)
+void
+xfs_thaw(
+	bhv_desc_t	*bdp)
 {
-	xfs_finish_freeze(mp);
-	return 0;
+	xfs_finish_freeze(XFS_BHVTOM(bdp));
 }
 
 int
@@ -632,13 +630,21 @@
 	xfs_mount_t	*mp,
 	__uint32_t	inflags)
 {
-	switch (inflags)
-	{
-	case XFS_FSOP_GOING_FLAGS_DEFAULT:
-		xfs_fs_freeze(mp);
-		xfs_force_shutdown(mp, XFS_FORCE_UMOUNT);
-		xfs_fs_thaw(mp);
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	switch (inflags) {
+	case XFS_FSOP_GOING_FLAGS_DEFAULT: {
+		struct vfs *vfsp = XFS_MTOVFS(mp);
+		struct super_block *sb = freeze_bdev(vfsp->vfs_super->s_bdev);
+
+		if (sb) {
+			xfs_force_shutdown(mp, XFS_FORCE_UMOUNT);
+			thaw_bdev(sb->s_bdev, sb);
+		}
+	
 		break;
+	}
 	case XFS_FSOP_GOING_FLAGS_LOGFLUSH:
 		xfs_force_shutdown(mp, XFS_FORCE_UMOUNT);
 		break;
===== fs/xfs/xfs_fsops.h 1.3 vs edited =====
--- 1.3/fs/xfs/xfs_fsops.h	Fri Feb 27 07:28:05 2004
+++ edited/fs/xfs/xfs_fsops.h	Sat Mar 13 18:08:01 2004
@@ -60,12 +60,12 @@
 	xfs_fsop_resblks_t	*outval);
 
 int
-xfs_fs_freeze(
-	xfs_mount_t		*mp);
+xfs_freeze(
+	struct bhv_desc		*bdp);
 
-int
-xfs_fs_thaw(
-	xfs_mount_t		*mp);
+void
+xfs_thaw(
+	struct bhv_desc		*bdp);
 
 int
 xfs_fs_goingdown(
===== fs/xfs/linux/xfs_ioctl.c 1.21 vs edited =====
--- 1.21/fs/xfs/linux/xfs_ioctl.c	Fri Feb 27 07:28:05 2004
+++ edited/fs/xfs/linux/xfs_ioctl.c	Sat Mar 13 18:23:23 2004
@@ -825,13 +825,14 @@
 	case XFS_IOC_FREEZE:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		xfs_fs_freeze(mp);
+
+		freeze_bdev(inode->i_sb->s_bdev);
 		return 0;
 
 	case XFS_IOC_THAW:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		xfs_fs_thaw(mp);
+		thaw_bdev(inode->i_sb->s_bdev, inode->i_sb);
 		return 0;
 
 	case XFS_IOC_GOINGDOWN: {
===== fs/xfs/linux/xfs_super.c 1.70 vs edited =====
--- 1.70/fs/xfs/linux/xfs_super.c	Sat Mar  6 04:46:51 2004
+++ edited/fs/xfs/linux/xfs_super.c	Sat Mar 13 17:59:56 2004
@@ -590,14 +590,9 @@
 	struct super_block	*sb)
 {
 	vfs_t			*vfsp = LINVFS_GET_VFS(sb);
-	vnode_t			*vp;
 	int			error;
 
-	if (sb->s_flags & MS_RDONLY)
-		return;
-	VFS_ROOT(vfsp, &vp, error);
-	VOP_IOCTL(vp, LINVFS_GET_IP(vp), NULL, 0, XFS_IOC_FREEZE, 0, error);
-	VN_RELE(vp);
+	VFS_FREEZE(vfsp, error);
 }
 
 STATIC void
@@ -605,12 +600,8 @@
 	struct super_block	*sb)
 {
 	vfs_t			*vfsp = LINVFS_GET_VFS(sb);
-	vnode_t			*vp;
-	int			error;
 
-	VFS_ROOT(vfsp, &vp, error);
-	VOP_IOCTL(vp, LINVFS_GET_IP(vp), NULL, 0, XFS_IOC_THAW, 0, error);
-	VN_RELE(vp);
+	VFS_THAW(vfsp);
 }
 
 STATIC struct dentry *
===== fs/xfs/linux/xfs_vfs.c 1.11 vs edited =====
--- 1.11/fs/xfs/linux/xfs_vfs.c	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/linux/xfs_vfs.c	Sat Mar 13 17:57:06 2004
@@ -230,6 +230,30 @@
 	((*bhvtovfsops(next)->vfs_force_shutdown)(next, fl, file, line));
 }
 
+int
+vfs_freeze(
+	struct bhv_desc		*bdp)
+{
+	struct bhv_desc		*next = bdp;
+
+	ASSERT(next);
+	while (! (bhvtovfsops(next))->vfs_freeze)
+		next = BHV_NEXT(next);
+	return ((*bhvtovfsops(next)->vfs_freeze)(next));
+}
+
+void
+vfs_thaw(
+	struct bhv_desc		*bdp)
+{
+	struct bhv_desc		*next = bdp;
+
+	ASSERT(next);
+	while (! (bhvtovfsops(next))->vfs_thaw)
+		next = BHV_NEXT(next);
+	((*bhvtovfsops(next)->vfs_thaw)(next));
+}
+
 vfs_t *
 vfs_allocate( void )
 {
===== fs/xfs/linux/xfs_vfs.h 1.18 vs edited =====
--- 1.18/fs/xfs/linux/xfs_vfs.h	Fri Jan  9 06:59:58 2004
+++ edited/fs/xfs/linux/xfs_vfs.h	Sat Mar 13 17:55:33 2004
@@ -112,6 +112,8 @@
 typedef void	(*vfs_init_vnode_t)(bhv_desc_t *,
 				struct vnode *, bhv_desc_t *, int);
 typedef void	(*vfs_force_shutdown_t)(bhv_desc_t *, int, char *, int);
+typedef int	(*vfs_freeze_t)(bhv_desc_t *);
+typedef void	(*vfs_thaw_t)(bhv_desc_t *);
 
 typedef struct vfsops {
 	bhv_position_t		vf_position;	/* behavior chain position */
@@ -128,6 +130,8 @@
 	vfs_quotactl_t		vfs_quotactl;	/* disk quota */
 	vfs_init_vnode_t	vfs_init_vnode;	/* initialize a new vnode */
 	vfs_force_shutdown_t	vfs_force_shutdown;	/* crash and burn */
+	vfs_freeze_t		vfs_freeze;	/* freeze fs for snapshot */
+	vfs_thaw_t		vfs_thaw;	/* .. and release it again */
 } vfsops_t;
 
 /*
@@ -147,6 +151,8 @@
 #define VFS_QUOTACTL(v, c,id,p, rv)	((rv) = vfs_quotactl(VHEAD(v), c,id,p))
 #define VFS_INIT_VNODE(v, vp,b,ul)	( vfs_init_vnode(VHEAD(v), vp,b,ul) )
 #define VFS_FORCE_SHUTDOWN(v, fl,f,l)	( vfs_force_shutdown(VHEAD(v), fl,f,l) )
+#define VFS_FREEZE(v, rv)		((rv) = vfs_freeze(VHEAD(v)))
+#define VFS_THAW(v)			( vfs_thaw(VHEAD(v)) )
 
 /*
  * PVFS's.  Operates on behavior descriptor pointers.
@@ -164,6 +170,8 @@
 #define PVFS_QUOTACTL(b, c,id,p, rv)	((rv) = vfs_quotactl(b, c,id,p))
 #define PVFS_INIT_VNODE(b, vp,b2,ul)	( vfs_init_vnode(b, vp,b2,ul) )
 #define PVFS_FORCE_SHUTDOWN(b, fl,f,l)	( vfs_force_shutdown(b, fl,f,l) )
+#define PVFS_FREEZE(b, rv)		((rv) = vfs_freeze(b))
+#define PVFS_THAW(b)			( vfs_thaw(b) )
 
 extern int vfs_mount(bhv_desc_t *, struct xfs_mount_args *, struct cred *);
 extern int vfs_parseargs(bhv_desc_t *, char *, struct xfs_mount_args *, int);
@@ -178,6 +186,8 @@
 extern int vfs_quotactl(bhv_desc_t *, int, int, caddr_t);
 extern void vfs_init_vnode(bhv_desc_t *, struct vnode *, bhv_desc_t *, int);
 extern void vfs_force_shutdown(bhv_desc_t *, int, char *, int);
+extern int vfs_freeze(bhv_desc_t *);
+extern void vfs_thaw(bhv_desc_t *);
 
 typedef struct bhv_vfsops {
 	struct vfsops		bhv_common;
===== include/linux/buffer_head.h 1.46 vs edited =====
--- 1.46/include/linux/buffer_head.h	Tue Jan 20 00:38:11 2004
+++ edited/include/linux/buffer_head.h	Sat Mar 13 15:35:32 2004
@@ -164,6 +164,8 @@
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
 int fsync_bdev(struct block_device *);
+struct super_block *freeze_bdev(struct block_device *);
+void thaw_bdev(struct block_device *, struct super_block *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
 struct buffer_head *__find_get_block(struct block_device *, sector_t, int);
===== include/linux/fs.h 1.290 vs edited =====
--- 1.290/include/linux/fs.h	Fri Mar 12 10:32:59 2004
+++ edited/include/linux/fs.h	Sat Mar 13 15:35:44 2004
@@ -344,6 +344,7 @@
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct semaphore	bd_mount_sem;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;

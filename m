Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUCNOAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUCNOAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:00:54 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:47376 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263364AbUCNOAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:00:35 -0500
Date: Sun, 14 Mar 2004 14:00:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040314140032.A8901@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <1078867885.25075.1458.camel@watt.suse.com> <20040313131447.A25900@infradead.org> <1079191213.4187.243.camel@watt.suse.com> <20040313163346.A27004@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040313163346.A27004@infradead.org>; from hch@infradead.org on Sat, Mar 13, 2004 at 04:33:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 04:33:46PM +0000, Christoph Hellwig wrote:
> Here's the reworked patch I have, ignoring dm but converting the xfs-internal
> interfaces that do freezing.  But without an interface change we still need
> to do all the flushing a second time inside XFS which I absoutely dislike.
> 
> Let me think about how to do this nicer.

Okay, here's a new patch that basically moves all the XFS freezing
infrastructure to the VFS, leavin only writing of the log record and some
transaction count handing inside XFS.

I've given it some heavy testing with xfs_freeze, dm is still not updated.

P.S. this patch now kills 16 lines of kernel code summarized :)

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
+++ edited/fs/buffer.c	Sun Mar 14 15:37:00 2004
@@ -260,6 +260,69 @@
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
===== fs/super.c 1.115 vs edited =====
--- 1.115/fs/super.c	Fri Mar 12 10:30:24 2004
+++ edited/fs/super.c	Sun Mar 14 14:24:56 2004
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
 
===== fs/xfs/xfs_fsops.c 1.11 vs edited =====
--- 1.11/fs/xfs/xfs_fsops.c	Fri Feb 27 07:28:05 2004
+++ edited/fs/xfs/xfs_fsops.c	Sun Mar 14 14:03:01 2004
@@ -582,63 +582,25 @@
 }
 
 int
-xfs_fs_freeze(
-	xfs_mount_t	*mp)
-{
-	vfs_t		*vfsp;
-	/*REFERENCED*/
-	int		error;
-
-	vfsp = XFS_MTOVFS(mp);
-
-	/* Stop new writers */
-	xfs_start_freeze(mp, XFS_FREEZE_WRITE);
-
-	/* Flush the refcache */
-	xfs_refcache_purge_mp(mp);
-
-	/* Flush delalloc and delwri data */
-	VFS_SYNC(vfsp, SYNC_DELWRI|SYNC_WAIT, NULL, error);
-
-	/* Pause transaction subsystem */
-	xfs_start_freeze(mp, XFS_FREEZE_TRANS);
-
-	/* Flush any remaining inodes into buffers */
-	VFS_SYNC(vfsp, SYNC_ATTR|SYNC_WAIT, NULL, error);
-
-	/* Push all buffers out to disk */
-	xfs_binval(mp->m_ddev_targp);
-	if (mp->m_rtdev_targp) {
-		xfs_binval(mp->m_rtdev_targp);
-	}
-
-	/* Push the superblock and write an unmount record */
-	xfs_log_unmount_write(mp);
-	xfs_unmountfs_writesb(mp);
-
-	return 0;
-}
-
-int
-xfs_fs_thaw(
-	xfs_mount_t	*mp)
-{
-	xfs_finish_freeze(mp);
-	return 0;
-}
-
-int
 xfs_fs_goingdown(
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
+++ edited/fs/xfs/xfs_fsops.h	Sun Mar 14 14:03:33 2004
@@ -60,14 +60,6 @@
 	xfs_fsop_resblks_t	*outval);
 
 int
-xfs_fs_freeze(
-	xfs_mount_t		*mp);
-
-int
-xfs_fs_thaw(
-	xfs_mount_t		*mp);
-
-int
 xfs_fs_goingdown(
 	xfs_mount_t		*mp,
 	__uint32_t		inflags);
===== fs/xfs/xfs_log.c 1.34 vs edited =====
--- 1.34/fs/xfs/xfs_log.c	Sat Mar  6 04:16:30 2004
+++ edited/fs/xfs/xfs_log.c	Sun Mar 14 13:59:50 2004
@@ -820,7 +820,7 @@
 	xlog_t		*log = mp->m_log;
 	vfs_t		*vfsp = XFS_MTOVFS(mp);
 
-	if (mp->m_frozen || XFS_FORCED_SHUTDOWN(mp) ||
+	if (vfsp->vfs_super->s_frozen || XFS_FORCED_SHUTDOWN(mp) ||
 	    (vfsp->vfs_flag & VFS_RDONLY))
 		return 0;
 
===== fs/xfs/xfs_mount.c 1.41 vs edited =====
--- 1.41/fs/xfs/xfs_mount.c	Fri Feb 27 07:54:47 2004
+++ edited/fs/xfs/xfs_mount.c	Sun Mar 14 14:01:45 2004
@@ -139,9 +139,6 @@
 	 */
 	xfs_trans_ail_init(mp);
 
-	/* Init freeze sync structures */
-	spinlock_init(&mp->m_freeze_lock, "xfs_freeze");
-	init_sv(&mp->m_wait_unfreeze, SV_DEFAULT, "xfs_freeze", 0);
 	atomic_set(&mp->m_active_trans, 0);
 
 	return mp;
@@ -191,8 +188,6 @@
 		VFS_REMOVEBHV(vfsp, &mp->m_bhv);
 	}
 
-	spinlock_destroy(&mp->m_freeze_lock);
-	sv_destroy(&mp->m_wait_unfreeze);
 	kmem_free(mp, sizeof(xfs_mount_t));
 }
 
@@ -1584,60 +1579,4 @@
 	}
 	xfs_mod_sb(tp, fields);
 	xfs_trans_commit(tp, 0, NULL);
-}
-
-/* Functions to lock access out of the filesystem for forced
- * shutdown or snapshot.
- */
-
-void
-xfs_start_freeze(
-	xfs_mount_t	*mp,
-	int		level)
-{
-	unsigned long	s = mutex_spinlock(&mp->m_freeze_lock);
-
-	mp->m_frozen = level;
-	mutex_spinunlock(&mp->m_freeze_lock, s);
-
-	if (level == XFS_FREEZE_TRANS) {
-		while (atomic_read(&mp->m_active_trans) > 0)
-			delay(100);
-	}
-}
-
-void
-xfs_finish_freeze(
-	xfs_mount_t	*mp)
-{
-	unsigned long	s = mutex_spinlock(&mp->m_freeze_lock);
-
-	if (mp->m_frozen) {
-		mp->m_frozen = 0;
-		sv_broadcast(&mp->m_wait_unfreeze);
-	}
-
-	mutex_spinunlock(&mp->m_freeze_lock, s);
-}
-
-void
-xfs_check_frozen(
-	xfs_mount_t	*mp,
-	bhv_desc_t	*bdp,
-	int		level)
-{
-	unsigned long	s;
-
-	if (mp->m_frozen) {
-		s = mutex_spinlock(&mp->m_freeze_lock);
-
-		if (mp->m_frozen < level) {
-			mutex_spinunlock(&mp->m_freeze_lock, s);
-		} else {
-			sv_wait(&mp->m_wait_unfreeze, 0, &mp->m_freeze_lock, s);
-		}
-	}
-
-	if (level == XFS_FREEZE_TRANS)
-		atomic_inc(&mp->m_active_trans);
 }
===== fs/xfs/xfs_mount.h 1.25 vs edited =====
--- 1.25/fs/xfs/xfs_mount.h	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/xfs_mount.h	Sun Mar 14 14:02:01 2004
@@ -379,10 +379,6 @@
 	struct xfs_dmops	m_dm_ops;	/* vector of DMI ops */
 	struct xfs_qmops	m_qm_ops;	/* vector of XQM ops */
 	struct xfs_ioops	m_io_ops;	/* vector of I/O ops */
-	lock_t			m_freeze_lock;	/* Lock for m_frozen */
-	uint			m_frozen;	/* FS frozen for shutdown or
-						 * snapshot */
-	sv_t			m_wait_unfreeze;/* waiting to unfreeze */
 	atomic_t		m_active_trans;	/* number trans frozen */
 } xfs_mount_t;
 
@@ -557,16 +553,6 @@
 extern void	xfs_initialize_perag(xfs_mount_t *, int);
 extern void	xfs_xlatesb(void *, struct xfs_sb *, int, xfs_arch_t,
 			__int64_t);
-
-/*
- * Flags for freeze operations.
- */
-#define XFS_FREEZE_WRITE	1
-#define XFS_FREEZE_TRANS	2
-
-extern void	xfs_start_freeze(xfs_mount_t *, int);
-extern void	xfs_finish_freeze(xfs_mount_t *);
-extern void	xfs_check_frozen(xfs_mount_t *, bhv_desc_t *, int);
 
 extern struct vfsops xfs_vfsops;
 extern struct vnodeops xfs_vnodeops;
===== fs/xfs/xfs_trans.c 1.14 vs edited =====
--- 1.14/fs/xfs/xfs_trans.c	Fri Jan  9 00:18:09 2004
+++ edited/fs/xfs/xfs_trans.c	Sun Mar 14 14:01:41 2004
@@ -131,7 +131,9 @@
 	xfs_mount_t	*mp,
 	uint		type)
 {
-	xfs_check_frozen(mp, NULL, XFS_FREEZE_TRANS);
+	vfs_check_frozen(XFS_MTOVFS(mp)->vfs_super, SB_FREEZE_TRANS);
+	atomic_inc(&mp->m_active_trans);
+
 	return (_xfs_trans_alloc(mp, type));
 
 }
===== fs/xfs/xfs_vfsops.c 1.57 vs edited =====
--- 1.57/fs/xfs/xfs_vfsops.c	Wed Mar  3 05:52:58 2004
+++ edited/fs/xfs/xfs_vfsops.c	Sun Mar 14 14:42:21 2004
@@ -1544,6 +1544,11 @@
 		}
 	}
 
+	if (XFS_MTOVFS(mp)->vfs_super->s_frozen == SB_FREEZE_TRANS) {
+		while (atomic_read(&mp->m_active_trans) > 0)
+			delay(100);
+	}
+
 	return XFS_ERROR(last_error);
 }
 
@@ -1853,6 +1858,17 @@
 	return 0;
 }
 
+STATIC void
+xfs_freeze(
+	bhv_desc_t	*bdp)
+{
+	xfs_mount_t	*mp = XFS_BHVTOM(bdp);
+
+	/* Push the superblock and write an unmount record */
+	xfs_log_unmount_write(mp);
+	xfs_unmountfs_writesb(mp);
+}
+
 
 vfsops_t xfs_vfsops = {
 	BHV_IDENTITY_INIT(VFS_BHV_XFS,VFS_POSITION_XFS),
@@ -1869,4 +1885,5 @@
 	.vfs_quotactl		= (vfs_quotactl_t)fs_nosys,
 	.vfs_init_vnode		= xfs_initialize_vnode,
 	.vfs_force_shutdown	= xfs_do_force_shutdown,
+	.vfs_freeze		= xfs_freeze,
 };
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
===== fs/xfs/linux/xfs_lrw.c 1.40 vs edited =====
--- 1.40/fs/xfs/linux/xfs_lrw.c	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/linux/xfs_lrw.c	Sun Mar 14 14:47:00 2004
@@ -682,8 +682,6 @@
 	io = &xip->i_iocore;
 	mp = io->io_mount;
 
-	xfs_check_frozen(mp, bdp, XFS_FREEZE_WRITE);
-
 	if (XFS_FORCED_SHUTDOWN(mp)) {
 		return -EIO;
 	}
===== fs/xfs/linux/xfs_super.c 1.70 vs edited =====
--- 1.70/fs/xfs/linux/xfs_super.c	Sat Mar  6 04:46:51 2004
+++ edited/fs/xfs/linux/xfs_super.c	Sun Mar 14 14:43:46 2004
@@ -589,28 +589,7 @@
 linvfs_freeze_fs(
 	struct super_block	*sb)
 {
-	vfs_t			*vfsp = LINVFS_GET_VFS(sb);
-	vnode_t			*vp;
-	int			error;
-
-	if (sb->s_flags & MS_RDONLY)
-		return;
-	VFS_ROOT(vfsp, &vp, error);
-	VOP_IOCTL(vp, LINVFS_GET_IP(vp), NULL, 0, XFS_IOC_FREEZE, 0, error);
-	VN_RELE(vp);
-}
-
-STATIC void
-linvfs_unfreeze_fs(
-	struct super_block	*sb)
-{
-	vfs_t			*vfsp = LINVFS_GET_VFS(sb);
-	vnode_t			*vp;
-	int			error;
-
-	VFS_ROOT(vfsp, &vp, error);
-	VOP_IOCTL(vp, LINVFS_GET_IP(vp), NULL, 0, XFS_IOC_THAW, 0, error);
-	VN_RELE(vp);
+	VFS_FREEZE(LINVFS_GET_VFS(sb));
 }
 
 STATIC struct dentry *
@@ -850,7 +829,6 @@
 	.write_super		= linvfs_write_super,
 	.sync_fs		= linvfs_sync_super,
 	.write_super_lockfs	= linvfs_freeze_fs,
-	.unlockfs		= linvfs_unfreeze_fs,
 	.statfs			= linvfs_statfs,
 	.remount_fs		= linvfs_remount,
 	.show_options		= linvfs_show_options,
===== fs/xfs/linux/xfs_vfs.c 1.11 vs edited =====
--- 1.11/fs/xfs/linux/xfs_vfs.c	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/linux/xfs_vfs.c	Sun Mar 14 14:43:15 2004
@@ -230,6 +230,18 @@
 	((*bhvtovfsops(next)->vfs_force_shutdown)(next, fl, file, line));
 }
 
+void
+vfs_freeze(
+	struct bhv_desc		*bdp)
+{
+	struct bhv_desc		*next = bdp;
+
+	ASSERT(next);
+	while (! (bhvtovfsops(next))->vfs_freeze)
+		next = BHV_NEXT(next);
+	((*bhvtovfsops(next)->vfs_freeze)(next));
+}
+
 vfs_t *
 vfs_allocate( void )
 {
===== fs/xfs/linux/xfs_vfs.h 1.18 vs edited =====
--- 1.18/fs/xfs/linux/xfs_vfs.h	Fri Jan  9 06:59:58 2004
+++ edited/fs/xfs/linux/xfs_vfs.h	Sun Mar 14 14:43:07 2004
@@ -112,6 +112,7 @@
 typedef void	(*vfs_init_vnode_t)(bhv_desc_t *,
 				struct vnode *, bhv_desc_t *, int);
 typedef void	(*vfs_force_shutdown_t)(bhv_desc_t *, int, char *, int);
+typedef void	(*vfs_freeze_t)(bhv_desc_t *);
 
 typedef struct vfsops {
 	bhv_position_t		vf_position;	/* behavior chain position */
@@ -128,6 +129,7 @@
 	vfs_quotactl_t		vfs_quotactl;	/* disk quota */
 	vfs_init_vnode_t	vfs_init_vnode;	/* initialize a new vnode */
 	vfs_force_shutdown_t	vfs_force_shutdown;	/* crash and burn */
+	vfs_freeze_t		vfs_freeze;	/* freeze fs for snapshot */
 } vfsops_t;
 
 /*
@@ -147,6 +149,7 @@
 #define VFS_QUOTACTL(v, c,id,p, rv)	((rv) = vfs_quotactl(VHEAD(v), c,id,p))
 #define VFS_INIT_VNODE(v, vp,b,ul)	( vfs_init_vnode(VHEAD(v), vp,b,ul) )
 #define VFS_FORCE_SHUTDOWN(v, fl,f,l)	( vfs_force_shutdown(VHEAD(v), fl,f,l) )
+#define VFS_FREEZE(v)			( vfs_freeze(VHEAD(v)) )
 
 /*
  * PVFS's.  Operates on behavior descriptor pointers.
@@ -164,6 +167,7 @@
 #define PVFS_QUOTACTL(b, c,id,p, rv)	((rv) = vfs_quotactl(b, c,id,p))
 #define PVFS_INIT_VNODE(b, vp,b2,ul)	( vfs_init_vnode(b, vp,b2,ul) )
 #define PVFS_FORCE_SHUTDOWN(b, fl,f,l)	( vfs_force_shutdown(b, fl,f,l) )
+#define PVFS_FREEZE(b)			( vfs_freeze(b) )
 
 extern int vfs_mount(bhv_desc_t *, struct xfs_mount_args *, struct cred *);
 extern int vfs_parseargs(bhv_desc_t *, char *, struct xfs_mount_args *, int);
@@ -178,6 +182,7 @@
 extern int vfs_quotactl(bhv_desc_t *, int, int, caddr_t);
 extern void vfs_init_vnode(bhv_desc_t *, struct vnode *, bhv_desc_t *, int);
 extern void vfs_force_shutdown(bhv_desc_t *, int, char *, int);
+extern void vfs_freeze(bhv_desc_t *);
 
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
+++ edited/include/linux/fs.h	Sun Mar 14 14:08:14 2004
@@ -344,6 +344,7 @@
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct semaphore	bd_mount_sem;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;
@@ -712,6 +713,9 @@
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	int			s_frozen;
+	wait_queue_head_t	s_wait_unfrozen;
+
 	char s_id[32];				/* Informational name */
 
 	struct kobject           kobj;          /* anchor for sysfs */
@@ -723,6 +727,18 @@
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
===== mm/filemap.c 1.225 vs edited =====
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

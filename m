Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264055AbUDQWHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 18:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUDQWHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 18:07:25 -0400
Received: from verein.lst.de ([212.34.189.10]:38591 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264055AbUDQWGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 18:06:47 -0400
Date: Sun, 18 Apr 2004 00:06:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] lockfs - xfs bits
Message-ID: <20040417220640.GB2573@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the code now in the VFS, make XFS's freeze ioctls use the
new infastructure and reorganize some code.

This code needs some work so the source files shared with 2.4 aren't
exposed to the new VFS interfaces directly.  You'll get an update once
this has been discussed with the other XFS developers and is
implemented.  Note that the current patch works fine and I wouldn't
complain if it gets into Linus' tree as-is.


--- 1.11/fs/xfs/xfs_fsops.c	Fri Feb 27 07:28:05 2004
+++ edited/fs/xfs/xfs_fsops.c	Sat Apr 17 19:39:48 2004
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
--- 1.3/fs/xfs/xfs_fsops.h	Fri Feb 27 07:28:05 2004
+++ edited/fs/xfs/xfs_fsops.h	Sat Apr 17 19:39:48 2004
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
--- 1.36/fs/xfs/xfs_log.c	Thu Apr  1 04:21:13 2004
+++ edited/fs/xfs/xfs_log.c	Sat Apr 17 19:39:48 2004
@@ -820,7 +820,7 @@
 	xlog_t		*log = mp->m_log;
 	vfs_t		*vfsp = XFS_MTOVFS(mp);
 
-	if (mp->m_frozen || XFS_FORCED_SHUTDOWN(mp) ||
+	if (vfsp->vfs_super->s_frozen || XFS_FORCED_SHUTDOWN(mp) ||
 	    (vfsp->vfs_flag & VFS_RDONLY))
 		return 0;
 
--- 1.42/fs/xfs/xfs_mount.c	Thu Apr  1 03:39:54 2004
+++ edited/fs/xfs/xfs_mount.c	Sun Apr 18 01:28:21 2004
@@ -140,9 +140,6 @@
 	 */
 	xfs_trans_ail_init(mp);
 
-	/* Init freeze sync structures */
-	spinlock_init(&mp->m_freeze_lock, "xfs_freeze");
-	init_sv(&mp->m_wait_unfreeze, SV_DEFAULT, "xfs_freeze", 0);
 	atomic_set(&mp->m_active_trans, 0);
 
 	return mp;
@@ -192,8 +189,6 @@
 		VFS_REMOVEBHV(vfsp, &mp->m_bhv);
 	}
 
-	spinlock_destroy(&mp->m_freeze_lock);
-	sv_destroy(&mp->m_wait_unfreeze);
 	kmem_free(mp, sizeof(xfs_mount_t));
 }
 
@@ -1585,60 +1580,4 @@
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
--- 1.25/fs/xfs/xfs_mount.h	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/xfs_mount.h	Sat Apr 17 19:39:48 2004
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
--- 1.15/fs/xfs/xfs_trans.c	Thu Apr  1 02:43:37 2004
+++ edited/fs/xfs/xfs_trans.c	Sat Apr 17 19:39:48 2004
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
--- 1.59/fs/xfs/xfs_vfsops.c	Thu Apr  1 04:06:43 2004
+++ edited/fs/xfs/xfs_vfsops.c	Sat Apr 17 21:23:40 2004
@@ -1858,6 +1858,20 @@
 	return 0;
 }
 
+STATIC void
+xfs_freeze(
+	bhv_desc_t	*bdp)
+{
+	xfs_mount_t	*mp = XFS_BHVTOM(bdp);
+
+	while (atomic_read(&mp->m_active_trans) > 0)
+		delay(100);
+
+	/* Push the superblock and write an unmount record */
+	xfs_log_unmount_write(mp);
+	xfs_unmountfs_writesb(mp);
+}
+
 
 vfsops_t xfs_vfsops = {
 	BHV_IDENTITY_INIT(VFS_BHV_XFS,VFS_POSITION_XFS),
@@ -1874,4 +1888,5 @@
 	.vfs_quotactl		= (vfs_quotactl_t)fs_nosys,
 	.vfs_init_vnode		= xfs_initialize_vnode,
 	.vfs_force_shutdown	= xfs_do_force_shutdown,
+	.vfs_freeze		= xfs_freeze,
 };
--- 1.22/fs/xfs/linux/xfs_ioctl.c	Thu Apr  1 03:58:02 2004
+++ edited/fs/xfs/linux/xfs_ioctl.c	Sat Apr 17 19:39:48 2004
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
--- 1.40/fs/xfs/linux/xfs_lrw.c	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/linux/xfs_lrw.c	Sat Apr 17 19:39:48 2004
@@ -682,8 +682,6 @@
 	io = &xip->i_iocore;
 	mp = io->io_mount;
 
-	xfs_check_frozen(mp, bdp, XFS_FREEZE_WRITE);
-
 	if (XFS_FORCED_SHUTDOWN(mp)) {
 		return -EIO;
 	}
--- 1.70/fs/xfs/linux/xfs_super.c	Sat Mar  6 04:46:51 2004
+++ edited/fs/xfs/linux/xfs_super.c	Sun Apr 18 01:28:26 2004
@@ -589,28 +581,7 @@
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
@@ -850,7 +821,6 @@
 	.write_super		= linvfs_write_super,
 	.sync_fs		= linvfs_sync_super,
 	.write_super_lockfs	= linvfs_freeze_fs,
-	.unlockfs		= linvfs_unfreeze_fs,
 	.statfs			= linvfs_statfs,
 	.remount_fs		= linvfs_remount,
 	.show_options		= linvfs_show_options,
--- 1.11/fs/xfs/linux/xfs_vfs.c	Wed Mar  3 05:52:57 2004
+++ edited/fs/xfs/linux/xfs_vfs.c	Sat Apr 17 19:39:48 2004
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
--- 1.18/fs/xfs/linux/xfs_vfs.h	Fri Jan  9 06:59:58 2004
+++ edited/fs/xfs/linux/xfs_vfs.h	Sat Apr 17 19:39:48 2004
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

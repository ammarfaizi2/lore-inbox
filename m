Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWGDMwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWGDMwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWGDMwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:52:55 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:31907 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750875AbWGDMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:52:54 -0400
To: xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: i_state of inode is changed after the inode is freed
Message-Id: <20060704215256m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Tue, 4 Jul 2006 21:52:56 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the case that i_state of the inode was changed when 
the inode was freed in xfs filesystem.  It's as follows to be 
concrete.

(1) xfs_fs_destroy function is called.
(2) after (1), i_state of the inode is changed within
    __mark_inode_dirty function.

In addition to the case of the above, I confirm the case that
i_state of the inode is changed after xfs_inode is reclaimed.
It occurs when xfs_inode reclaim transaction is running with
the transaction mentioned above in parallel. 

My machine has 32way CPUs(IA-64).  The kernel is linux-2.6.17.1.

I think that the cause of the case is that xfs_inode is not
locked.  For this reason, these two(or three) transactions
can be running in parallel.
Here is the typical pattern.  (transaction A runs while transaction
B is running)

generic_delete_inode  xfs_iunpin
---------------------------------------------------------------------------
                      if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE)))
                      +-vnode_t *vp = XFS_ITOV_NULL(ip)
                      ==================(transaction B-Start)==============
                      +-if (vp)
                        +-struct inode    *inode = vn_to_inode(vp)
                        +-if (!(inode->i_state & I_NEW))
                          | +-mark_inode_dirty_sync(inode)
                          |   +-__mark_inode_dirty(inode, I_DIRTY_SYNC)
                                             :



==============(transaction A)=================
(XFS_IRECLAIMABLE or XFS_IRECLAIM set)
(I_CLEAR set)
+-destroy_inode
  +-security_inode_free
    +-inode->i_sb->s_op->destroy_inode
      +-xfs_fs_destroy_inode
        +-kmem_zone_free
==============================================



                                             :
                          |     +-spin_lock(&inode_lock)
                          =================(transaction B-End)=============
                          |     +-inode->i_state |= flags(I_DIRTY_SYNC set)
---------------------------------------------------------------------------

I fixed this problem with adding spinlock for appropriate places.
The patch is against 2.6.17.1.  I confirmed with this patch that the 
inode of i_state is not changed after the inode is freed.

Please comments.

Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
---

--- linux-2.6.17.1/fs/xfs/xfs_inode.h.orig	2006-06-29 16:43:21.783055861 +0900
+++ linux-2.6.17.1/fs/xfs/xfs_inode.h	2006-06-29 16:44:44.720968782 +0900
@@ -267,6 +267,7 @@ typedef struct xfs_inode {
 	sema_t			i_flock;	/* inode flush lock */
 	atomic_t		i_pincount;	/* inode pin count */
 	wait_queue_head_t	i_ipin_wait;	/* inode pinning wait queue */
+	spinlock_t              i_vlock;        /* inode lock when inode link/unlink vnode */
 #ifdef HAVE_REFCACHE
 	struct xfs_inode	**i_refcache;	/* ptr to entry in ref cache */
 	struct xfs_inode	*i_release;	/* inode to unref */
--- linux-2.6.17.1/fs/xfs/xfs_inode.c.orig	2006-06-29 16:45:00.297510902 +0900
+++ linux-2.6.17.1/fs/xfs/xfs_inode.c	2006-06-29 17:54:41.929675716 +0900
@@ -861,6 +861,7 @@ xfs_iread(
 	ip = kmem_zone_zalloc(xfs_inode_zone, KM_SLEEP);
 	ip->i_ino = ino;
 	ip->i_mount = mp;
+	spin_lock_init(&ip->i_vlock);
 
 	/*
 	 * Get pointer's to the on-disk inode and the buffer containing it.
@@ -2744,6 +2745,7 @@ xfs_iunpin(
 		 * call as the inode reclaim may be blocked waiting for
 		 * the inode to become unpinned.
 		 */
+		spin_lock(&ip->i_vlock);
 		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
 			vnode_t	*vp = XFS_ITOV_NULL(ip);
 
@@ -2755,6 +2757,8 @@ xfs_iunpin(
 					mark_inode_dirty_sync(inode);
 			}
 		}
+		spin_unlock(&ip->i_vlock);		
+
 		wake_up(&ip->i_ipin_wait);
 	}
 }
--- linux-2.6.17.1/fs/xfs/linux-2.6/xfs_super.c.orig	2006-06-29 16:49:56.987695062 +0900
+++ linux-2.6.17.1/fs/xfs/linux-2.6/xfs_super.c	2006-06-29 17:55:25.518797628 +0900
@@ -213,11 +213,13 @@ xfs_initialize_vnode(
 	xfs_inode_t		*ip = XFS_BHVTOI(inode_bhv);
 	struct inode		*inode = vn_to_inode(vp);
 
+	spin_lock(&ip->i_vlock);
 	if (!inode_bhv->bd_vobj) {
 		vp->v_vfsp = bhvtovfs(bdp);
 		bhv_desc_init(inode_bhv, ip, vp, &xfs_vnodeops);
 		bhv_insert(VN_BHV_HEAD(vp), inode_bhv);
 	}
+	spin_unlock(&ip->i_vlock);
 
 	/*
 	 * We need to set the ops vectors, and unlock the inode, but if
--- linux-2.6.17.1/fs/xfs/xfs_vnodeops.c.orig	2006-06-29 16:52:06.513256745 +0900
+++ linux-2.6.17.1/fs/xfs/xfs_vnodeops.c	2006-06-29 16:54:56.107495843 +0900
@@ -3834,9 +3834,13 @@ xfs_reclaim(
 
 		/* Protect sync from us */
 		XFS_MOUNT_ILOCK(mp);
-		vn_bhv_remove(VN_BHV_HEAD(vp), XFS_ITOBHV(ip));
-		list_add_tail(&ip->i_reclaim, &mp->m_del_inodes);
-		ip->i_flags |= XFS_IRECLAIMABLE;
+		spin_lock(&ip->i_vlock);
+		if (!(ip->i_flags & XFS_IRECLAIMABLE)) {
+			vn_bhv_remove(VN_BHV_HEAD(vp), XFS_ITOBHV(ip));
+			list_add_tail(&ip->i_reclaim, &mp->m_del_inodes);
+			ip->i_flags |= XFS_IRECLAIMABLE;
+		}
+		spin_unlock(&ip->i_vlock);
 		XFS_MOUNT_IUNLOCK(mp);
 	}
 	return 0;
--- linux-2.6.17.1/fs/xfs/xfs_iget.c.orig	2006-06-29 16:55:45.379720997 +0900
+++ linux-2.6.17.1/fs/xfs/xfs_iget.c	2006-06-29 16:56:51.574275914 +0900
@@ -675,10 +675,12 @@ xfs_ireclaim(xfs_inode_t *ip)
 	/*
 	 * Pull our behavior descriptor from the vnode chain.
 	 */
+	spin_lock(&ip->i_vlock);
 	vp = XFS_ITOV_NULL(ip);
 	if (vp) {
 		vn_bhv_remove(VN_BHV_HEAD(vp), XFS_ITOBHV(ip));
 	}
+	spin_unlock(&ip->i_vlock);
 
 	/*
 	 * Free all memory associated with the inode.
--- linux-2.6.17.1/fs/xfs/xfs_itable.c.orig	2006-06-29 16:58:48.376845205 +0900
+++ linux-2.6.17.1/fs/xfs/xfs_itable.c	2006-06-29 16:59:49.857144001 +0900
@@ -559,6 +559,8 @@ xfs_bulkstat(
 								      KM_SLEEP);
 						ip->i_ino = ino;
 						ip->i_mount = mp;
+						spin_lock_init(&ip->i_vlock);
+
 						if (bp)
 							xfs_buf_relse(bp);
 						error = xfs_itobp(mp, NULL, ip,

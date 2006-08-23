Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWHWLNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWHWLNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWHWLNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:13:05 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45731 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964883AbWHWLNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:13:02 -0400
To: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Add new spin_lock for i_flags of xfs_inode [try #2]
Message-Id: <20060823201251m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Wed, 23 Aug 2006 20:12:51 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is the problem that i_flags of xfs_inode has no consistent
locking protection.

For the reason, I define a new spin_lock(i_flags_lock) for i_flags
of xfs_inode.  And I add this spin_lock for appropriate places.

I divided into two patches.  A summary of patches is as follows.

 [1/2] add a new lock for i_flags of xfs_inode
 [2/2] fix i_state of the inode is changed after the inode is freed

The following changes were made in [try #2]:
 [1/2] Nothing
 [2/2] wake_up() is done before iput() in xfs_iunpin().

I have tested the two patches and confirmed with these patches that
the inode of i_state is not changed after the inode is freed.

Appreciate any comments and feedbacks.

Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
---

--- linux-2.6.17.7/fs/xfs/xfs_inode.h.orig	2006-07-29 15:41:28.570341641 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_inode.h	2006-08-01 02:51:53.598587423 +0900
@@ -267,6 +267,7 @@ typedef struct xfs_inode {
 	sema_t			i_flock;	/* inode flush lock */
 	atomic_t		i_pincount;	/* inode pin count */
 	wait_queue_head_t	i_ipin_wait;	/* inode pinning wait queue */
+	spinlock_t		i_flags_lock;	/* inode i_flags lock */
 #ifdef HAVE_REFCACHE
 	struct xfs_inode	**i_refcache;	/* ptr to entry in ref cache */
 	struct xfs_inode	*i_release;	/* inode to unref */
--- linux-2.6.17.7/fs/xfs/xfs_inode.c.orig	2006-07-29 15:41:39.050936181 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_inode.c	2006-08-01 14:13:51.615782806 +0900
@@ -861,6 +861,7 @@ xfs_iread(
 	ip = kmem_zone_zalloc(xfs_inode_zone, KM_SLEEP);
 	ip->i_ino = ino;
 	ip->i_mount = mp;
+	spin_lock_init(&ip->i_flags_lock);
 
 	/*
 	 * Get pointer's to the on-disk inode and the buffer containing it.
@@ -2204,7 +2205,9 @@ xfs_ifree_cluster(
 
 			if (ip == free_ip) {
 				if (xfs_iflock_nowait(ip)) {
+					spin_lock(&ip->i_flags_lock);
 					ip->i_flags |= XFS_ISTALE;
+					spin_unlock(&ip->i_flags_lock);
 
 					if (xfs_inode_clean(ip)) {
 						xfs_ifunlock(ip);
@@ -2218,7 +2221,9 @@ xfs_ifree_cluster(
 
 			if (xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
 				if (xfs_iflock_nowait(ip)) {
+					spin_lock(&ip->i_flags_lock);
 					ip->i_flags |= XFS_ISTALE;
+					spin_unlock(&ip->i_flags_lock);
 
 					if (xfs_inode_clean(ip)) {
 						xfs_ifunlock(ip);
@@ -2248,7 +2253,9 @@ xfs_ifree_cluster(
 				AIL_LOCK(mp,s);
 				iip->ili_flush_lsn = iip->ili_item.li_lsn;
 				AIL_UNLOCK(mp, s);
+				spin_lock(&iip->ili_inode->i_flags_lock);
 				iip->ili_inode->i_flags |= XFS_ISTALE;
+				spin_unlock(&iip->ili_inode->i_flags_lock);
 				pre_flushed++;
 			}
 			lip = lip->li_bio_list;
--- linux-2.6.17.7/fs/xfs/xfs_itable.c.orig	2006-07-29 15:41:52.071674818 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_itable.c	2006-08-01 02:51:53.698593096 +0900
@@ -559,6 +559,7 @@ xfs_bulkstat(
 								      KM_SLEEP);
 						ip->i_ino = ino;
 						ip->i_mount = mp;
+						spin_lock_init(&ip->i_flags_lock);
 						if (bp)
 							xfs_buf_relse(bp);
 						error = xfs_itobp(mp, NULL, ip,
--- linux-2.6.17.7/fs/xfs/xfs_iget.c.orig	2006-07-29 15:42:03.992351051 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_iget.c	2006-08-01 21:17:58.173213088 +0900
@@ -246,7 +246,9 @@ again:
 
 				XFS_STATS_INC(xs_ig_found);
 
+				spin_lock(&ip->i_flags_lock);
 				ip->i_flags &= ~XFS_IRECLAIMABLE;
+				spin_unlock(&ip->i_flags_lock);
 				version = ih->ih_version;
 				read_unlock(&ih->ih_lock);
 				xfs_ihash_promote(ih, ip, version);
@@ -300,7 +302,9 @@ finish_inode:
 			if (lock_flags != 0)
 				xfs_ilock(ip, lock_flags);
 
+			spin_lock(&ip->i_flags_lock);
 			ip->i_flags &= ~XFS_ISTALE;
+			spin_unlock(&ip->i_flags_lock);
 
 			vn_trace_exit(vp, "xfs_iget.found",
 						(inst_t *)__return_address);
@@ -371,7 +375,9 @@ finish_inode:
 	ih->ih_next = ip;
 	ip->i_udquot = ip->i_gdquot = NULL;
 	ih->ih_version++;
+	spin_lock(&ip->i_flags_lock);
 	ip->i_flags |= XFS_INEW;
+	spin_unlock(&ip->i_flags_lock);
 
 	write_unlock(&ih->ih_lock);
 
--- linux-2.6.17.7/fs/xfs/xfs_vnodeops.c.orig	2006-07-29 15:42:40.182404031 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_vnodeops.c	2006-08-02 03:43:12.163597123 +0900
@@ -3836,7 +3836,9 @@ xfs_reclaim(
 		XFS_MOUNT_ILOCK(mp);
 		vn_bhv_remove(VN_BHV_HEAD(vp), XFS_ITOBHV(ip));
 		list_add_tail(&ip->i_reclaim, &mp->m_del_inodes);
+		spin_lock(&ip->i_flags_lock);
 		ip->i_flags |= XFS_IRECLAIMABLE;
+		spin_unlock(&ip->i_flags_lock);
 		XFS_MOUNT_IUNLOCK(mp);
 	}
 	return 0;
@@ -3861,8 +3863,10 @@ xfs_finish_reclaim(
 	 * us.
 	 */
 	write_lock(&ih->ih_lock);
+	spin_lock(&ip->i_flags_lock);
 	if ((ip->i_flags & XFS_IRECLAIM) ||
 	    (!(ip->i_flags & XFS_IRECLAIMABLE) && vp == NULL)) {
+		spin_unlock(&ip->i_flags_lock);
 		write_unlock(&ih->ih_lock);
 		if (locked) {
 			xfs_ifunlock(ip);
@@ -3871,6 +3875,7 @@ xfs_finish_reclaim(
 		return 1;
 	}
 	ip->i_flags |= XFS_IRECLAIM;
+	spin_unlock(&ip->i_flags_lock);
 	write_unlock(&ih->ih_lock);
 
 	/*
--- linux-2.6.17.7/fs/xfs/linux-2.6/xfs_super.c.orig	2006-07-29 15:43:17.768536207 +0900
+++ linux-2.6.17.7/fs/xfs/linux-2.6/xfs_super.c	2006-08-01 13:23:09.934740893 +0900
@@ -230,7 +230,9 @@ xfs_initialize_vnode(
 		xfs_revalidate_inode(XFS_BHVTOM(bdp), vp, ip);
 		xfs_set_inodeops(inode);
 
+		spin_lock(&ip->i_flags_lock);
 		ip->i_flags &= ~XFS_INEW;
+		spin_unlock(&ip->i_flags_lock);
 		barrier();
 
 		unlock_new_inode(inode);

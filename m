Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVBJE7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVBJE7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVBJE7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:59:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14746 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262021AbVBJE65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:58:57 -0500
Date: Thu, 10 Feb 2005 15:54:57 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-bk5: XFS: fcron: could not write() buf to disk: Resource temporarily unavailable
Message-ID: <20050210045457.GB1206@frodo>
References: <200502082051.36989.gluk@php4.ru> <20050209012900.GA1140@frodo> <200502091744.55137.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502091744.55137.gluk@php4.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 05:44:54PM +0300, Alexander Y. Fomichev wrote:
> On Wednesday 09 February 2005 04:29, Nathan Scott wrote:
> > Is that an O_SYNC write, do you know?  Or a write to an inode
> > with the sync flag set?
> 
> Yes, it is O_SYNC, as i can see from fcron sources, and, no, kernel

OK, thanks.

> > I'm chasing down a problem similar to this atm, so far looks like
> > something in the generic VM code below sync_page_range is giving
> > back EAGAIN, and that is getting passed back out to userspace by
> > XFS.  Not sure where/why/how its been caused yet though ... I'll
> > let you know once I have a fix or have found the culprit change.

Turns out it was actually XFS giving back this EAGAIN, indirectly -
and some of the generic VM routines have been tweaked recently to
propogate more sync write errors out to userspace.  Try this patch,
it will fix your problem - we're still discussing if this is the
ideal fix, so something else may be merged in the end.

cheers.

-- 
Nathan


Index: test/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- test.orig/fs/xfs/linux-2.6/xfs_super.c
+++ test/fs/xfs/linux-2.6/xfs_super.c
@@ -348,6 +348,12 @@
 		if (sync)
 			flags |= FLUSH_SYNC;
 		VOP_IFLUSH(vp, flags, error);
+		if (error == EAGAIN) {
+			if (sync)
+				VOP_IFLUSH(vp, flags | FLUSH_LOG, error);
+			else
+				error = 0;
+		}
 	}
 
 	return -error;
Index: test/fs/xfs/xfs_vnodeops.c
===================================================================
--- test.orig/fs/xfs/xfs_vnodeops.c
+++ test/fs/xfs/xfs_vnodeops.c
@@ -3681,27 +3681,27 @@
 {
 	xfs_inode_t	*ip;
 	xfs_mount_t	*mp;
+	xfs_inode_log_item_t *iip;
 	int		error = 0;
 
 	ip = XFS_BHVTOI(bdp);
 	mp = ip->i_mount;
+	iip = ip->i_itemp;
 
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return XFS_ERROR(EIO);
 
-	/* Bypass inodes which have already been cleaned by
+	/*
+	 * Bypass inodes which have already been cleaned by
 	 * the inode flush clustering code inside xfs_iflush
 	 */
 	if ((ip->i_update_core == 0) &&
-	    ((ip->i_itemp == NULL) ||
-	     !(ip->i_itemp->ili_format.ilf_fields & XFS_ILOG_ALL)))
+	    ((iip == NULL) || !(iip->ili_format.ilf_fields & XFS_ILOG_ALL)))
 		return 0;
 
 	if (flags & FLUSH_LOG) {
-		xfs_inode_log_item_t *iip = ip->i_itemp;
-
 		if (iip && iip->ili_last_lsn) {
-			xlog_t	*log = mp->m_log;
+			xlog_t		*log = mp->m_log;
 			xfs_lsn_t	sync_lsn;
 			int		s, log_flags = XFS_LOG_FORCE;
 
@@ -3714,12 +3714,14 @@
 
 			if (flags & FLUSH_SYNC)
 				log_flags |= XFS_LOG_SYNC;
-			return xfs_log_force(mp, iip->ili_last_lsn,
-						log_flags);
+			error = xfs_log_force(mp, iip->ili_last_lsn, log_flags);
+			if (error)
+				return error;
 		}
 	}
 
-	/* We make this non-blocking if the inode is contended,
+	/*
+	 * We make this non-blocking if the inode is contended,
 	 * return EAGAIN to indicate to the caller that they
 	 * did not succeed. This prevents the flush path from
 	 * blocking on inodes inside another operation right
@@ -3728,8 +3730,11 @@
 	if (flags & FLUSH_INODE) {
 		int	flush_flags;
 
+		if (!(flags & FLUSH_LOG))
+			error = EAGAIN;
+
 		if (xfs_ipincount(ip))
-			return EAGAIN;
+			return error;
 
 		if (flags & FLUSH_SYNC) {
 			xfs_ilock(ip, XFS_ILOCK_SHARED);
@@ -3737,10 +3742,10 @@
 		} else if (xfs_ilock_nowait(ip, XFS_ILOCK_SHARED)) {
 			if (xfs_ipincount(ip) || !xfs_iflock_nowait(ip)) {
 				xfs_iunlock(ip, XFS_ILOCK_SHARED);
-				return EAGAIN;
+				return error;
 			}
 		} else {
-			return EAGAIN;
+			return error;
 		}
 
 		if (flags & FLUSH_SYNC)
Index: test/fs/xfs/linux-2.6/xfs_lrw.c
===================================================================
--- test.orig/fs/xfs/linux-2.6/xfs_lrw.c
+++ test/fs/xfs/linux-2.6/xfs_lrw.c
@@ -962,9 +962,9 @@
 				xfs_trans_set_sync(tp);
 				error = xfs_trans_commit(tp, 0, NULL);
 				xfs_iunlock(xip, XFS_ILOCK_EXCL);
-				if (error)
-					goto out_unlock_internal;
 			}
+			if (error)
+				goto out_unlock_internal;
 		}
 	
 		xfs_rwunlock(bdp, locktype);

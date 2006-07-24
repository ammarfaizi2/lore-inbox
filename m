Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWGXICF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWGXICF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGXICE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:02:04 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:18331 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932087AbWGXICD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:02:03 -0400
To: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
In-reply-to: <20060717140751.GW2114946@melbourne.sgi.com>
Message-Id: <20060724170133m-saito@mail.aom.tnes.nec.co.jp>
References: <20060717140751.GW2114946@melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Mon, 24 Jul 2006 17:01:33 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan, David,
Thank you for comments.

>I don't think it fixes the problem because igrab() fails to handle
>the case we are hitting where I_CLEAR is set on the inode when we
>mark it dirty. There's nothing in this patch preventing us from
>sleeping after the !(I_NEW|I_FREEING|I_CLEAR) check is done and then
>racing with generic_drop_inode() before the igrab() can take a
>reference on the inode.

I overlooked the case.  Thank you for your review.


>Worse, the i_flags field does not use atomic bitops and
>there is no consistent locking protecting i_flags so updates
>and reads of this filed can race or even get lost....

I agree it, too.  I think that we should add new spin_lock for
i_flags.


>I think a fix is going to be much more invasive than just adding
>reference as my fixes appear to have only narrowed the race window
>and not solved it. The addition of the lock in the original patch
>solves the atomic xfs_iunpin()/xfs_reclaim() execution problem,
>but it does not solve the problems with the i_flags field. Adding
>a new lock may be our only option here.

I'm considering the solution which fixes two problems([a] i_state of
the inode is changed while the inode is freed in xfs filesystem and
[b] the above i_flags problem)

the solution:
(1)Add new spin_lock(i_flags_lock) for all refernece and change
   places of all i_flags.
(2)Add igrab()/iput() for xfs_iunpin().

It makes sure that mark_inode_dirty_sync() is never called if
xfs_iunpin() runs after I_CLEAR is set.  Because XFS_IRECLAIM
or XFS_IRECLAIMABLE is set/checked within the spin_lock.

And there is the reason that igrab()/iput() is needed even if I add
new spin_lock for xfs_iunpin().  We can prevent the following case
by adding them.
* After passing (I_NEW|I_FREEING|I_CLEAR) check in xfs_iunpin(),
  I_FREEING is set.
* Then mark_inode_dirty_sync() is called and i_state is changed.
* Hit BUG_ON(!(inode->i_state & I_FREEING)) in clear_inode().

If these ideas seem to be correct, I'll make patches for above (1),(2).
Any comment?


(The following is a part of my thinking patch.  Only xfs_iunpin().)

--- linux-2.6.17.6/fs/xfs/xfs_inode.c.orig	2006-07-22 08:07:50.194236144 +0900
+++ linux-2.6.17.6/fs/xfs/xfs_inode.c	2006-07-25 06:07:18.062853045 +0900
@@ -2729,6 +2729,8 @@ void
 xfs_iunpin(
 	xfs_inode_t	*ip)
 {
+	int need_unlock;
+
 	ASSERT(atomic_read(&ip->i_pincount) > 0);
 
 	if (atomic_dec_and_test(&ip->i_pincount)) {
@@ -2744,6 +2746,8 @@ xfs_iunpin(
 		 * call as the inode reclaim may be blocked waiting for
 		 * the inode to become unpinned.
 		 */
+		spin_lock(&ip->i_flags_lock);
+		need_unlock = 1;
 		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
 			vnode_t	*vp = XFS_ITOV_NULL(ip);
 
@@ -2751,10 +2755,22 @@ xfs_iunpin(
 			if (vp) {
 				struct inode	*inode = vn_to_inode(vp);
 
-				if (!(inode->i_state & I_NEW))
-					mark_inode_dirty_sync(inode);
+				if (!(inode->i_state &
+						(I_NEW|I_FREEING|I_CLEAR))) {
+					inode = igrab(inode);
+					if (inode != NULL) {
+						mark_inode_dirty_sync(inode);
+						spin_unlock(&ip->i_flags_lock);
+						need_unlock = 0;
+						iput(inode);
+					}
+				}
 			}
 		}
+		if (need_unlock) {
+			spin_unlock(&ip->i_flags_lock);
+			need_unlock = 0;
+		}
 		wake_up(&ip->i_ipin_wait);
 	}
 }

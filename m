Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWHHMA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWHHMA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWHHMA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:00:58 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:463 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750847AbWHHMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:00:57 -0400
To: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed
Message-Id: <20060808210026m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Tue, 8 Aug 2006 21:00:26 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix i_state of the inode is changed after the inode is freed.

Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
---

--- linux-2.6.17.7/fs/xfs/xfs_inode.c.orig	2006-08-01 14:20:00.903511531 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_inode.c	2006-08-01 14:14:39.588213059 +0900
@@ -2736,6 +2736,8 @@ void
 xfs_iunpin(
 	xfs_inode_t	*ip)
 {
+	int need_unlock;
+
 	ASSERT(atomic_read(&ip->i_pincount) > 0);
 
 	if (atomic_dec_and_test(&ip->i_pincount)) {
@@ -2751,6 +2753,8 @@ xfs_iunpin(
 		 * call as the inode reclaim may be blocked waiting for
 		 * the inode to become unpinned.
 		 */
+		need_unlock = 1;
+		spin_lock(&ip->i_flags_lock);
 		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
 			vnode_t	*vp = XFS_ITOV_NULL(ip);
 
@@ -2758,10 +2762,22 @@ xfs_iunpin(
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


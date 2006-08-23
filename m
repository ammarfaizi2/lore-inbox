Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWHWLOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWHWLOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWHWLOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:14:46 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:51620 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964886AbWHWLOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:14:45 -0400
To: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed [try #2]
Message-Id: <20060823201445m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Wed, 23 Aug 2006 20:14:45 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix i_state of the inode is changed after the inode is freed.

Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
---

--- linux-2.6.17.7/fs/xfs/xfs_inode.c.orig	2006-08-21 20:15:58.385211286 +0900
+++ linux-2.6.17.7/fs/xfs/xfs_inode.c	2006-08-21 21:21:22.277033371 +0900
@@ -2751,18 +2751,30 @@ xfs_iunpin(
 		 * call as the inode reclaim may be blocked waiting for
 		 * the inode to become unpinned.
 		 */
+		int need_iput = 0;
+		struct inode *inode;
+		spin_lock(&ip->i_flags_lock);
 		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
 			vnode_t	*vp = XFS_ITOV_NULL(ip);
 
 			/* make sync come back and flush this inode */
 			if (vp) {
-				struct inode	*inode = vn_to_inode(vp);
+				inode = vn_to_inode(vp);
 
-				if (!(inode->i_state & I_NEW))
-					mark_inode_dirty_sync(inode);
+				if (!(inode->i_state &
+						(I_NEW|I_FREEING|I_CLEAR))) {
+					inode = igrab(inode);
+					if (inode) {
+						need_iput = 1;
+						mark_inode_dirty_sync(inode);
+					}
+				}
 			}
 		}
+		spin_unlock(&ip->i_flags_lock);
 		wake_up(&ip->i_ipin_wait);
+		if (need_iput)
+			iput(inode);
 	}
 }

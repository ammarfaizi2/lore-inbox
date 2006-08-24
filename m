Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWHXHRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWHXHRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWHXHRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:17:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30424 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750754AbWHXHRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:17:12 -0400
Date: Thu, 24 Aug 2006 17:16:53 +1000
From: Nathan Scott <nathans@sgi.com>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>, David Chinner <dgc@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed [try #2]
Message-ID: <20060824171653.C3003989@wobbly.melbourne.sgi.com>
References: <20060823201445m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060823201445m-saito@mail.aom.tnes.nec.co.jp>; from m-saito@tnes.nec.co.jp on Wed, Aug 23, 2006 at 08:14:45PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 08:14:45PM +0900, Masayuki Saito wrote:
> Fix i_state of the inode is changed after the inode is freed.
> 
> Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
> Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>

This version is producing a gcc warning...

fs/xfs/xfs_inode.c: In function 'xfs_iunpin':
fs/xfs/xfs_inode.c:2765: warning: 'inode' may be used uninitialized in this function

Which doesn't look correct due to your need_iput guard, but perhaps
we should do this instead...

cheers.

-- 
Nathan


Fix i_state of the inode is changed after the inode is freed.

Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
---

Index: xfs-linux/xfs_inode.c
===================================================================
--- xfs-linux.orig/xfs_inode.c	2006-08-24 17:02:36.896740000 +1000
+++ xfs-linux/xfs_inode.c	2006-08-24 17:09:29.430521750 +1000
@@ -2761,19 +2761,29 @@ xfs_iunpin(
 		 * call as the inode reclaim may be blocked waiting for
 		 * the inode to become unpinned.
 		 */
+		struct inode *inode = NULL;
+
+		spin_lock(&ip->i_flags_lock);
 		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
 			bhv_vnode_t	*vp = XFS_ITOV_NULL(ip);
 
 			/* make sync come back and flush this inode */
 			if (vp) {
-				struct inode	*inode = vn_to_inode(vp);
+				inode = vn_to_inode(vp);
 
 				if (!(inode->i_state &
-						(I_NEW|I_FREEING|I_CLEAR)))
-					mark_inode_dirty_sync(inode);
+						(I_NEW|I_FREEING|I_CLEAR))) {
+					inode = igrab(inode);
+					if (inode)
+						mark_inode_dirty_sync(inode);
+				} else
+					inode = NULL;
 			}
 		}
+		spin_unlock(&ip->i_flags_lock);
 		wake_up(&ip->i_ipin_wait);
+		if (inode)
+			iput(inode);
 	}
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWHaCss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWHaCss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 22:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHaCsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 22:48:47 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:59826 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751635AbWHaCsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 22:48:47 -0400
To: Nathan Scott <nathans@sgi.com>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed [try #2]
In-reply-to: <20060824171653.C3003989@wobbly.melbourne.sgi.com>
Message-Id: <20060831114423m-saito@mail.aom.tnes.nec.co.jp>
References: <20060824171653.C3003989@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Thu, 31 Aug 2006 11:44:23 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nathan


>Fix i_state of the inode is changed after the inode is freed.
>
>Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
>Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
>---
>
>Index: xfs-linux/xfs_inode.c
>===================================================================
>--- xfs-linux.orig/xfs_inode.c	2006-08-24 17:02:36.896740000 +1000
>+++ xfs-linux/xfs_inode.c	2006-08-24 17:09:29.430521750 +1000
>@@ -2761,19 +2761,29 @@ xfs_iunpin(
> 		 * call as the inode reclaim may be blocked waiting for
> 		 * the inode to become unpinned.
> 		 */
>+		struct inode *inode = NULL;
>+
>+		spin_lock(&ip->i_flags_lock);
> 		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
> 			bhv_vnode_t	*vp = XFS_ITOV_NULL(ip);
> 
> 			/* make sync come back and flush this inode */
> 			if (vp) {
>-				struct inode	*inode = vn_to_inode(vp);
>+				inode = vn_to_inode(vp);
> 
> 				if (!(inode->i_state &
>-						(I_NEW|I_FREEING|I_CLEAR)))
>-					mark_inode_dirty_sync(inode);
>+						(I_NEW|I_FREEING|I_CLEAR))) {
>+					inode = igrab(inode);
>+					if (inode)
>+						mark_inode_dirty_sync(inode);
>+				} else
>+					inode = NULL;
> 			}
> 		}
>+		spin_unlock(&ip->i_flags_lock);
> 		wake_up(&ip->i_ipin_wait);
>+		if (inode)
>+			iput(inode);
> 	}
> }

Are the patches going to be merged?

Masayuki

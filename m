Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWGNKZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWGNKZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWGNKZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:25:32 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:23208 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1161025AbWGNKZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:25:32 -0400
To: Nathan Scott <nathans@sgi.com>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
In-reply-to: <20060710103740.B1674239@wobbly.melbourne.sgi.com>
Message-Id: <20060714192520m-saito@mail.aom.tnes.nec.co.jp>
References: <20060710103740.B1674239@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Fri, 14 Jul 2006 19:25:20 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nathan.

>I'll leave it to Dave to comment more later (he's travelling at the
>moment), since he's had his head deep in this area of the code most
>recently - but my first thoughts on your patch are that its solving
>the problem incorrectly.  We should not be in the destroy_inode code
>if the inode reference counting is correct everywhere - I would have
>expected the fix to be a get/put style change, rather than adding an
>inode lock and new lock/unlock semantics around an individual field;
>... and if that cannot be done to fix this (eh?), then some comments
>as to why refcounting didn't solve the problem here.

On the basis of the above, I consider the get/put style fix which use
i_count.

This problem is that i_state of the inode is changed while the inode
is freed in xfs filesystem.  And the cause is that the inode release
and xfs_iunpun() can run in parallel.

To fix this problem, I added a pair of igrab()/iput() before and behind
mark_inode_dirty_sync() at xfs_iunpin().  I think this can change it as
follows.

(1)The case that the inode release transaction runs after xfs_iunpin()
is called.
While mark_inode_dirty_sync() is running, igrab() promises that the
inode is alive.

(2)The case that xfs_iunpin() is called after iput() in the inode
release transaction is called(i_count is 0).
mark_inode_dirty_sync() is not called because the igrab() can not get
the inode.

I have made the following patch, but it is not yet tested.
I would like to hear your comment, first.

Signed-off-by: Masayuki Saito <m-saito@tnes.nec.co.jp>
---

--- linux-2.6.17.4/fs/xfs/xfs_inode.c.orig	2006-07-14 09:44:44.187844139 +0900
+++ linux-2.6.17.4/fs/xfs/xfs_inode.c	2006-07-14 09:58:26.398486290 +0900
@@ -2751,8 +2751,14 @@ xfs_iunpin(
 			if (vp) {
 				struct inode	*inode = vn_to_inode(vp);
 
-				if (!(inode->i_state & I_NEW))
-					mark_inode_dirty_sync(inode);
+				if (!(inode->i_state & 
+						(I_NEW|I_FREEING|I_CLEAR))) {
+					inode = igrab(inode);
+					if (inode != NULL) {
+						mark_inode_dirty_sync(inode);
+						iput(inode);
+					}
+				}
 			}
 		}
 		wake_up(&ip->i_ipin_wait);

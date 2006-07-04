Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWGDUmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWGDUmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWGDUmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:42:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53673 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932395AbWGDUmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:42:22 -0400
Date: Wed, 5 Jul 2006 06:41:45 +1000
From: David Chinner <dgc@sgi.com>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
Message-ID: <20060704204145.GU15160733@melbourne.sgi.com>
References: <20060704215256m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704215256m-saito@mail.aom.tnes.nec.co.jp>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 09:52:56PM +0900, Masayuki Saito wrote:
> Hi,
> 
> I found the case that i_state of the inode was changed when 
> the inode was freed in xfs filesystem.  It's as follows to be 
> concrete.
> 
> (1) xfs_fs_destroy function is called.
> (2) after (1), i_state of the inode is changed within
>     __mark_inode_dirty function.

You'd be talking about xfs_iunpin(), wouldn't you ;)

> In addition to the case of the above, I confirm the case that
> i_state of the inode is changed after xfs_inode is reclaimed.
> It occurs when xfs_inode reclaim transaction is running with
> the transaction mentioned above in parallel. 

Well, it occurs because the xfs_inode_t has a different life cycle
to the linux inode (inherited from Irix). Basically, we can still be
doing transactions on the xfs_inode_t whilst the linux inode is
being freed or has been freed.  Indeed, there was a long standing
use-after-free in this code, as fixed here:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=58829e490ee805f1c8b3009abc90e2a1a7a0d278

Initially I thought this was all that was necessary to fix the problem.

The problem you are seeing is a fast log transaction completion
(NVRAM in front of your disks, perhaps?), and so the transaction
completion is occurring before the linux inode has been completely
freed. This is the condition the above fix does not handle.....

> I think that the cause of the case is that xfs_inode is not
> locked.  For this reason, these two(or three) transactions
> can be running in parallel.

The inode is locked while the transaction is being built and
unlocked when the transaction is committed to the incore log buffer.
The inode is pinned during the transaction commit, so we can have
multiple _committed_ transactions in flight on the one inode at the
same time, but we only allow an inode to be part of a single
uncommitted transaction at a time.

FYI, see xfs_trans_iget(), xfs_trans_ijoin(), etc for an
explanation of inode transaction locking rules.

> Here is the typical pattern.  (transaction A runs while transaction
> B is running)
> 
> generic_delete_inode  xfs_iunpin
> ---------------------------------------------------------------------------
>                       if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE)))
>                       +-vnode_t *vp = XFS_ITOV_NULL(ip)
>                       ==================(transaction B-Start)==============
>                       +-if (vp)
>                         +-struct inode    *inode = vn_to_inode(vp)
>                         +-if (!(inode->i_state & I_NEW))


This check fails to detect the fact the inode is in the process
of being freed.

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=714250879ea61cdb1a39bb96fe9d934ee0c669a2

This fixed the reproducable test case I had for the problem.
Can you see if it fixes your problem as well?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWHNC76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWHNC76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 22:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWHNC76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 22:59:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9939 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751829AbWHNC75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 22:59:57 -0400
Date: Mon, 14 Aug 2006 12:59:02 +1000
From: David Chinner <dgc@sgi.com>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>
Cc: Nathan Scott <nathans@sgi.com>, David Chinner <dgc@sgi.com>,
       xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
Message-ID: <20060814025901.GE51703024@melbourne.sgi.com>
References: <20060717140751.GW2114946@melbourne.sgi.com> <20060724170133m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724170133m-saito@mail.aom.tnes.nec.co.jp>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masayuki,

Sorry for taking so long to get back to you - travelling and vacation
left a mountain of email for me to delete :/

On Mon, Jul 24, 2006 at 05:01:33PM +0900, Masayuki Saito wrote:
> >I think a fix is going to be much more invasive than just adding
> >reference as my fixes appear to have only narrowed the race window
> >and not solved it. The addition of the lock in the original patch
> >solves the atomic xfs_iunpin()/xfs_reclaim() execution problem,
> >but it does not solve the problems with the i_flags field. Adding
> >a new lock may be our only option here.
> 
> I'm considering the solution which fixes two problems([a] i_state of
> the inode is changed while the inode is freed in xfs filesystem and
> [b] the above i_flags problem)
> 
> the solution:
> (1)Add new spin_lock(i_flags_lock) for all refernece and change
>    places of all i_flags.
> (2)Add igrab()/iput() for xfs_iunpin().
> 
> It makes sure that mark_inode_dirty_sync() is never called if
> xfs_iunpin() runs after I_CLEAR is set.  Because XFS_IRECLAIM
> or XFS_IRECLAIMABLE is set/checked within the spin_lock.

*nod*

> And there is the reason that igrab()/iput() is needed even if I add
> new spin_lock for xfs_iunpin().  We can prevent the following case
> by adding them.
> * After passing (I_NEW|I_FREEING|I_CLEAR) check in xfs_iunpin(),
>   I_FREEING is set.
> * Then mark_inode_dirty_sync() is called and i_state is changed.
> * Hit BUG_ON(!(inode->i_state & I_FREEING)) in clear_inode().

*nod*

> If these ideas seem to be correct, I'll make patches for above (1),(2).
> Any comment?
> 
> 
> (The following is a part of my thinking patch.  Only xfs_iunpin().)
> 
> --- linux-2.6.17.6/fs/xfs/xfs_inode.c.orig	2006-07-22 08:07:50.194236144 +0900
> +++ linux-2.6.17.6/fs/xfs/xfs_inode.c	2006-07-25 06:07:18.062853045 +0900
> @@ -2729,6 +2729,8 @@ void
>  xfs_iunpin(
>  	xfs_inode_t	*ip)
>  {
> +	int need_unlock;
> +
>  	ASSERT(atomic_read(&ip->i_pincount) > 0);
>  
>  	if (atomic_dec_and_test(&ip->i_pincount)) {
> @@ -2744,6 +2746,8 @@ xfs_iunpin(
>  		 * call as the inode reclaim may be blocked waiting for
>  		 * the inode to become unpinned.
>  		 */
> +		spin_lock(&ip->i_flags_lock);
> +		need_unlock = 1;
>  		if (!(ip->i_flags & (XFS_IRECLAIM|XFS_IRECLAIMABLE))) {
>  			vnode_t	*vp = XFS_ITOV_NULL(ip);
>  
> @@ -2751,10 +2755,22 @@ xfs_iunpin(
>  			if (vp) {
>  				struct inode	*inode = vn_to_inode(vp);
>  
> -				if (!(inode->i_state & I_NEW))
> -					mark_inode_dirty_sync(inode);
> +				if (!(inode->i_state &
> +						(I_NEW|I_FREEING|I_CLEAR))) {
> +					inode = igrab(inode);
> +					if (inode != NULL) {
> +						mark_inode_dirty_sync(inode);
> +						spin_unlock(&ip->i_flags_lock);
> +						need_unlock = 0;
> +						iput(inode);
> +					}
> +				}
>  			}
>  		}
> +		if (need_unlock) {
> +			spin_unlock(&ip->i_flags_lock);
> +			need_unlock = 0;
> +		}
>  		wake_up(&ip->i_ipin_wait);
>  	}
>  }

Hmmm - Idon't think we should iput() before we wake up any pinned waiters.
When we have a waiter on i_ipin_wait (called from xfs_iflush()), we have
a thread sleeping with the inode locked.

If we then call iput() and it drops the last reference, we can call back
into the filesystem and start transactions. Those transactions will need
to lock the inode. Hence I think the above can deadlock when racing against
an inode flush. 

The code should probably read:

	if (dropped last pincount) {
		int need_iput = 0;
		struct inode *inode;

		spin_lock(i_flags_lock)
		if (!reclaimable) {
			if (!vp) {
				if (!(i_state & (NEW|CLEAR))) {
					inode = igrab(inode)
					if (inode) {
						need_iput = 1	
						mark_inode_dirty_sync(inode)
					}
				}
			}
		}
		spin_unlock(i_flags_lock)
		wake_up(&ip->i_ipin_wait)
		if (need_iput)
			iput(inode);
	}

to avoid this possible deadlock.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

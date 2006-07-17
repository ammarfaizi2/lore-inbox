Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWGQOIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWGQOIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWGQOIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:08:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18858 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750782AbWGQOIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:08:39 -0400
Date: Tue, 18 Jul 2006 00:07:51 +1000
From: David Chinner <dgc@sgi.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Masayuki Saito <m-saito@tnes.nec.co.jp>, David Chinner <dgc@sgi.com>,
       xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
Message-ID: <20060717140751.GW2114946@melbourne.sgi.com>
References: <20060710103740.B1674239@wobbly.melbourne.sgi.com> <20060714192520m-saito@mail.aom.tnes.nec.co.jp> <20060717210501.A1895298@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717210501.A1895298@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 09:05:01PM +1000, Nathan Scott wrote:
> On Fri, Jul 14, 2006 at 07:25:20PM +0900, Masayuki Saito wrote:
> > Hi, Nathan.
> > 
> > >I'll leave it to Dave to comment more later (he's travelling at the
> > >moment), since he's had his head deep in this area of the code most
> > >recently - but my first thoughts on your patch are that its solving
> > >the problem incorrectly.  We should not be in the destroy_inode code
> > >if the inode reference counting is correct everywhere - I would have
> > >expected the fix to be a get/put style change, rather than adding an
> > >inode lock and new lock/unlock semantics around an individual field;
> > >... and if that cannot be done to fix this (eh?), then some comments
> > >as to why refcounting didn't solve the problem here.

Looking at this a bit deeper, I think the reference counting is
correct and the problem is that we are not breaking the link between
the linux inode and the xfs inode atomically w.r.t xfs_iunpin()
usage....

> > On the basis of the above, I consider the get/put style fix which use
> > i_count.
> > 
> > This problem is that i_state of the inode is changed while the inode
> > is freed in xfs filesystem.  And the cause is that the inode release
> > and xfs_iunpun() can run in parallel.
> > 
> > To fix this problem, I added a pair of igrab()/iput() before and behind
> > mark_inode_dirty_sync() at xfs_iunpin().  I think this can change it as
> > follows.
> > 
> > (1)The case that the inode release transaction runs after xfs_iunpin()
> > is called.
> > While mark_inode_dirty_sync() is running, igrab() promises that the
> > inode is alive.
> > 
> > (2)The case that xfs_iunpin() is called after iput() in the inode
> > release transaction is called(i_count is 0).
> > mark_inode_dirty_sync() is not called because the igrab() can not get
> > the inode.
> > 
> > I have made the following patch, but it is not yet tested.
> > I would like to hear your comment, first.
> 
> If this fixes your test case, then I like the look of it. ;-)

I don't think it fixes the problem because igrab() fails to handle
the case we are hitting where I_CLEAR is set on the inode when we
mark it dirty. There's nothing in this patch preventing us from
sleeping after the !(I_NEW|I_FREEING|I_CLEAR) check is done and then
racing with generic_drop_inode() before the igrab() can take a
reference on the inode.

ATM, I think the real problem is the use of the XFS_IRECLAIMABLE
flag and the locking involved. Nathan, the inode hash lock
is used to sync that flag between xfs_iget_core() and
xfs_finish_reclaim(), but no lock is used when setting it or
(now) checking in xfs_iunpin().....

Worse, the i_flags field does not use atomic bitops and
there is no consistent locking protecting i_flags so updates
and reads of this filed can race or even get lost....

Also, I think that xfs_iunpin() must execute atomically w.r.t
xfs_reclaim(), otherwise we cannot ever safely do the checks
we are doing in xfs_iunpin().

> It does seem much simpler and less invasive than the earlier fix
> using a spinlock.  I'll run with this in my testing for awhile,
> let me know how your own testing goes too, please (I especially
> would like to hear if it fixes that reproducible failure case).

I think a fix is going to be much more invasive than just adding
reference as my fixes appear to have only narrowed the race window
and not solved it. The addition of the lock in the original patch
solves the atomic xfs_iunpin()/xfs_reclaim() execution problem,
but it does not solve the problems with the i_flags field. Adding
a new lock may be our only option here.

This will have to wait until after OLS before I get a chance to
look at this further...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

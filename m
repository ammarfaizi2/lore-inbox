Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWGHTqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWGHTqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWGHTqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:46:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41479 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964966AbWGHTqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:46:08 -0400
Date: Sat, 8 Jul 2006 21:46:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Chinner <dgc@sgi.com>
Cc: xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: fs/xfs/xfs_vnodeops.c:xfs_readdir(): NULL variable dereferenced
Message-ID: <20060708194609.GB5020@stusta.de>
References: <20060706211320.GW26941@stusta.de> <20060706233246.GB15160733@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706233246.GB15160733@melbourne.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 09:32:46AM +1000, David Chinner wrote:
> On Thu, Jul 06, 2006 at 11:13:20PM +0200, Adrian Bunk wrote:
> > The Coverity checker spotted the following:
> > 
> > <--  snip  -->
> > 
> > ...
> > STATIC int
> > xfs_readdir(
> >         bhv_desc_t      *dir_bdp,
> >         uio_t           *uiop,
> >         cred_t          *credp,
> >         int             *eofp)
> > {
> >         xfs_inode_t     *dp;
> >         xfs_trans_t     *tp = NULL;
> >         int             error = 0;
> >         uint            lock_mode;
> > 
> >         vn_trace_entry(BHV_TO_VNODE(dir_bdp), __FUNCTION__,
> >                                                (inst_t *)__return_address);
> >         dp = XFS_BHVTOI(dir_bdp);
> > 
> >         if (XFS_FORCED_SHUTDOWN(dp->i_mount))
> >                 return XFS_ERROR(EIO);
> > 
> >         lock_mode = xfs_ilock_map_shared(dp);
> >         error = xfs_dir_getdents(tp, dp, uiop, eofp);
> >         xfs_iunlock_map_shared(dp, lock_mode);
> >         return error;
> > }
> > ...
> > 
> > <--  snip  -->
> > 
> > Note that tp is never assigned any value other than NULL (and the 
> > Coverity checker found a way how tp might be dereferenced four function 
> > calls later).
> 
> Then the bug is probably in the function call that uses tp without
> first checking whether it's null. Can you tell us where that dereference
> occurs?

xfs_readdir()
  xfs_dir_getdents()
    xfs_dir2_leaf_getdents()
      xfs_bmapi()
        xfs_trans_log_inode()
          tp->t_flags |= XFS_TRANS_DIRTY;

> Cheers,
> 
> Dave.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


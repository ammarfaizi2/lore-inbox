Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWGFXdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWGFXdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWGFXdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:33:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9198 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751046AbWGFXdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:33:40 -0400
Date: Fri, 7 Jul 2006 09:32:46 +1000
From: David Chinner <dgc@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: fs/xfs/xfs_vnodeops.c:xfs_readdir(): NULL variable dereferenced
Message-ID: <20060706233246.GB15160733@melbourne.sgi.com>
References: <20060706211320.GW26941@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706211320.GW26941@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 11:13:20PM +0200, Adrian Bunk wrote:
> The Coverity checker spotted the following:
> 
> <--  snip  -->
> 
> ...
> STATIC int
> xfs_readdir(
>         bhv_desc_t      *dir_bdp,
>         uio_t           *uiop,
>         cred_t          *credp,
>         int             *eofp)
> {
>         xfs_inode_t     *dp;
>         xfs_trans_t     *tp = NULL;
>         int             error = 0;
>         uint            lock_mode;
> 
>         vn_trace_entry(BHV_TO_VNODE(dir_bdp), __FUNCTION__,
>                                                (inst_t *)__return_address);
>         dp = XFS_BHVTOI(dir_bdp);
> 
>         if (XFS_FORCED_SHUTDOWN(dp->i_mount))
>                 return XFS_ERROR(EIO);
> 
>         lock_mode = xfs_ilock_map_shared(dp);
>         error = xfs_dir_getdents(tp, dp, uiop, eofp);
>         xfs_iunlock_map_shared(dp, lock_mode);
>         return error;
> }
> ...
> 
> <--  snip  -->
> 
> Note that tp is never assigned any value other than NULL (and the 
> Coverity checker found a way how tp might be dereferenced four function 
> calls later).

Then the bug is probably in the function call that uses tp without
first checking whether it's null. Can you tell us where that dereference
occurs?

Cheers,

Dave.

-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

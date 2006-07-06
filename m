Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWGFVNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWGFVNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWGFVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:13:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45573 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750866AbWGFVNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:13:21 -0400
Date: Thu, 6 Jul 2006 23:13:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: xfs-masters@oss.sgi.com
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: fs/xfs/xfs_vnodeops.c:xfs_readdir(): NULL variable dereferenced
Message-ID: <20060706211320.GW26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following:

<--  snip  -->

...
STATIC int
xfs_readdir(
        bhv_desc_t      *dir_bdp,
        uio_t           *uiop,
        cred_t          *credp,
        int             *eofp)
{
        xfs_inode_t     *dp;
        xfs_trans_t     *tp = NULL;
        int             error = 0;
        uint            lock_mode;

        vn_trace_entry(BHV_TO_VNODE(dir_bdp), __FUNCTION__,
                                               (inst_t *)__return_address);
        dp = XFS_BHVTOI(dir_bdp);

        if (XFS_FORCED_SHUTDOWN(dp->i_mount))
                return XFS_ERROR(EIO);

        lock_mode = xfs_ilock_map_shared(dp);
        error = xfs_dir_getdents(tp, dp, uiop, eofp);
        xfs_iunlock_map_shared(dp, lock_mode);
        return error;
}
...

<--  snip  -->

Note that tp is never assigned any value other than NULL (and the 
Coverity checker found a way how tp might be dereferenced four function 
calls later).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


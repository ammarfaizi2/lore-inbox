Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424713AbWKPVxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424713AbWKPVxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424716AbWKPVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:53:54 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:55635 "EHLO
	ext.agami.com") by vger.kernel.org with ESMTP id S1424713AbWKPVxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:53:53 -0500
Message-ID: <455CD6C8.5030907@agami.com>
Date: Thu, 16 Nov 2006 13:23:20 -0800
From: Shailendra Tripathi <stripathi@agami.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       nathans@sgi.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][RFC][resend] potential NULL pointer deref in XFS on failed
 mount
References: <200611162218.26945.jesper.juhl@gmail.com>
In-Reply-To: <200611162218.26945.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jesper,
                Rather,  it can be done as below. Nothing to say that 
your code wouldn't work. Just that catch it early, so that potential 
function call overhead to call xfs_free_buftarg can be avoided.

void
xfs_unmountfs_close(xfs_mount_t *mp, struct cred *cr)
{
       if (mp->m_logdev_targp && (mp->m_logdev_targp != mp->m_ddev_targp))
                xfs_free_buftarg(mp->m_logdev_targp, 1);
        if (mp->m_rtdev_targp)
                xfs_free_buftarg(mp->m_rtdev_targp, 1);
        xfs_free_buftarg(mp->m_ddev_targp, 0);
}


Jesper Juhl wrote:
> (got no reply on this when I originally send it on 20061031, so resending
>  now that a bit of time has passed.  The patch still applies cleanly to
>  Linus' git tree as of today.)
>
>
> The Coverity checker spotted a potential problem in XFS.
>
> The problem is that if, in xfs_mount(), this code triggers:
>
> 	...
> 	if (!mp->m_logdev_targp)
> 		goto error0;
> 	...
>
> Then we'll end up calling xfs_unmountfs_close() with a NULL 
> 'mp->m_logdev_targp'. 
> This in turn will result in a call to xfs_free_buftarg() with its 'btp' 
> argument == NULL. xfs_free_buftarg() dereferences 'btp' leading to
> a NULL pointer dereference and crash.
>
> I think this can happen, since the fatal call to xfs_free_buftarg() 
> happens when 'm_logdev_targp != m_ddev_targp' and due to a check of
> 'm_ddev_targp' against NULL in xfs_mount() (and subsequent return if it is 
> NULL) the two will never both be NULL when we hit the error0 label from 
> the two lines cited above.
>
> Comments welcome (please keep me on Cc: on replies).
>
> Here's a proposed patch to fix this by testing 'btp' against NULL in 
> xfs_free_buftarg().
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  fs/xfs/linux-2.6/xfs_buf.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
> index db5f5a3..6ef1860 100644
> --- a/fs/xfs/linux-2.6/xfs_buf.c
> +++ b/fs/xfs/linux-2.6/xfs_buf.c
> @@ -1450,6 +1450,9 @@ xfs_free_buftarg(
>  	xfs_buftarg_t		*btp,
>  	int			external)
>  {
> +	if (unlikely(!btp))
> +		return;
> +
>  	xfs_flush_buftarg(btp, 1);
>  	if (external)
>  		xfs_blkdev_put(btp->bt_bdev);
>
>
>
>   


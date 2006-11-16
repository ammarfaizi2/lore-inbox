Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424469AbWKPWKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424469AbWKPWKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424513AbWKPWKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:10:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:21712 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424490AbWKPWKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:10:17 -0500
Date: Fri, 17 Nov 2006 09:09:58 +1100
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][RFC][resend] potential NULL pointer deref in XFS on failed mount
Message-ID: <20061116220958.GE11034@melbourne.sgi.com>
References: <200611162218.26945.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611162218.26945.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 10:18:26PM +0100, Jesper Juhl wrote:
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

Interesting that coverity found that, but failed to find the other
leaks in that function from exactly the same code and error
case.....

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

Not the right fix - we should only be trying to free valid
buftargs, which means xfs_unmountfs_close() is the correct
place to fix this....

e.g:

-	if (mp->m_logdev_targp != mp->m_ddev_targp)
+	if (mp->m_logdev_targp && (mp->m_logdev_targp != mp->m_ddev_targp))

As to the afore-mentioned leaks, if we fail to allocate a realtime
buftarg, then we will leak a reference to both the rtdev and logdev,
and if we fail to allocate an external log buftarg we'll leak a
reference to the logdev. i.e., we fail to do one or both of:

	xfs_blkdev_put(logdev);
	xfs_blkdev_put(rtdev);

To remove the bdev references we may have gained earlier. Normally,
these references are released by xfs_free_buftarg(), but because we
failed to allocate the buftarg, we can't drop the references via
that method....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUCKWpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCKWpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:45:55 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29354 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261793AbUCKWpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:45:52 -0500
Date: Fri, 12 Mar 2004 09:44:43 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       kenneth.w.chen@intel.com, cattelan@xfs.org, lord@xfs.org
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040311224443.GC736@frodo>
References: <20040311083619.GH6955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311083619.GH6955@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, Mar 11, 2004 at 09:36:19AM +0100, Jens Axboe wrote:
> Hi,
> 
> Final version, unless something stupid pops up. Changes:
> 
> - Adapt to 2.6.4-mm1
> - Cleaned up the dm bits, much nicer with the lockless unplugging
>   (thanks Joe)
> - md and loop unplugging, stacked devices should unplug their targets.
>   Otherwise they'll end up waiting for the unplug timer, which sucks.
> - XFS fixed up, I hope. XFS folks still encouraged to look at this,
>   looks better this time around though (and works, I tested).

...[snip]

> diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c
> --- /opt/kernel/linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c	2004-03-11 03:55:21.000000000 +0100
> +++ linux-2.6.4-mm1/fs/xfs/linux/xfs_buf.c	2004-03-11 09:07:12.706793571 +0100

...[snip]

> @@ -1689,7 +1685,6 @@
>  	page_buf_t		*pb;
>  	struct list_head	*curr, *next, tmp;
>  	int			pincount = 0;
> -	int			flush_cnt = 0;
>  
>  	pagebuf_runall_queues(pagebuf_dataio_workqueue);
>  	pagebuf_runall_queues(pagebuf_logio_workqueue);
> @@ -1733,14 +1728,8 @@
>  
>  		pagebuf_lock(pb);
>  		pagebuf_iostrategy(pb);
> -		if (++flush_cnt > 32) {
> -			blk_run_queues();
> -			flush_cnt = 0;
> -		}
>  	}
>  
> -	blk_run_queues();
> -

Extrapolating out from Steve's last comment yesterday/day before,
this final blk_run_queues removal here should be replaced with:

+	if (flags & PBDF_WAIT)
+		blk_run_address_space(target->pbr_mapping);

and we XFS guys need to huddle some more and figure out whether the
magic number used earlier there (32) and the request starvation it
was preventing, is still an issue on 2.6.  

cheers.

-- 
Nathan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVF2SAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVF2SAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVF2SAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:00:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54944 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262346AbVF2R62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:58:28 -0400
Date: Wed, 29 Jun 2005 19:58:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.13-rc1 get_request nastiness
Message-ID: <20050629175805.GA15356@suse.de>
References: <Pine.LNX.4.61.0506291509170.13974@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506291509170.13974@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29 2005, Hugh Dickins wrote:
> get_request is now expected to be holding on to queue_lock, with interrupts
> disabled, when it returns NULL; but one path forgot that, causing all kinds
> of nastiness under swap load - badness backtraces, strange failures, BUGs.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> --- 2.6.13-rc1/drivers/block/ll_rw_blk.c	2005-06-29 11:54:08.000000000 +0100
> +++ linux/drivers/block/ll_rw_blk.c	2005-06-29 14:41:04.000000000 +0100
> @@ -1917,10 +1917,9 @@ get_rq:
>  	 * limit of requests, otherwise we could have thousands of requests
>  	 * allocated with any setting of ->nr_requests
>  	 */
> -	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
> -		spin_unlock_irq(q->queue_lock);
> +	if (rl->count[rw] >= (3 * q->nr_requests / 2))
>  		goto out;
> -	}
> +

Woops, my bad, sorry about that. I still have to think about that
locking, not directly obvious. Thanks Hugh!

-- 
Jens Axboe


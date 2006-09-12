Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWILWtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWILWtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWILWtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:49:41 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10056 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932332AbWILWti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:49:38 -0400
Date: Wed, 13 Sep 2006 00:47:08 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 12/20] nbd: limit blk_queue
Message-ID: <20060912224708.GA23515@kernel.dk>
References: <20060912143049.278065000@chello.nl> <20060912144904.299910000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912144904.299910000@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12 2006, Peter Zijlstra wrote:
> Limit each request to 1 page, so that the request throttling also limits the
> number of in-flight pages.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Daniel Phillips <phillips@google.com>
> CC: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/block/nbd.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/block/nbd.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/nbd.c	2006-09-07 18:43:41.000000000 +0200
> +++ linux-2.6/drivers/block/nbd.c	2006-09-07 18:44:12.000000000 +0200
> @@ -638,6 +638,9 @@ static int __init nbd_init(void)
>  			put_disk(disk);
>  			goto out;
>  		}
> +		blk_queue_max_segment_size(disk->queue, PAGE_SIZE);
> +		blk_queue_max_hw_segments(disk->queue, 1);
> +		blk_queue_max_phys_segments(disk->queue, 1);

Another bandaid. What happens if nr_requests number of pages is still
too many for a system? You just moved whatever problem you had, you
didn't solve anything.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTEHGRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 02:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTEHGRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 02:17:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48597 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261188AbTEHGRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 02:17:18 -0400
Date: Thu, 8 May 2003 08:29:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] fixes for linked list bugs in block I/O code
Message-ID: <20030508062942.GB823@suse.de>
References: <200305071622.36352.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071622.36352.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Dave Peterson wrote:
> I found a couple of small linked list bugs in __make_request() in
> drivers/block/ll_rw_blk.c.  The bugs exist in both kernels
> 2.4.20 and 2.5.69.  Therefore I have made patches for both
> kernels.  The problem is that when inserting a new buffer_head
> into the linked list of buffer_head structures maintained by
> "struct request", the b_reqnext field is not initialized.
> 
> -Dave Peterson
>  dsp@llnl.gov
> 
> 
> ========== START OF 2.4.20 PATCH FOR drivers/block/ll_rw_blk.c ===========
> --- ll_rw_blk.c.old     Wed May  7 15:54:58 2003
> +++ ll_rw_blk.c.new     Wed May  7 15:58:07 2003
> @@ -973,6 +973,7 @@
>                                 insert_here = &req->queue;
>                                 break;
>                         }
> +                       bh->b_reqnext = req->bhtail->b_reqnext;

This is convoluted nonsense, bhtail->b_reqnext is NULL by definition. So
a simple

	bh->b_reqnext = NULL;

is much clearer.

>                         req->bhtail->b_reqnext = bh;
>                         req->bhtail = bh;
>                         req->nr_sectors = req->hard_nr_sectors += count;
> @@ -1061,6 +1062,7 @@
>         req->waiting = NULL;
>         req->bh = bh;
>         req->bhtail = bh;
> +       bh->b_reqnext = NULL;
>         req->rq_dev = bh->b_rdev;
>         req->start_time = jiffies;
>         req_new_io(req, 0, count);

Bart already covered why 2.5 definitely does not need it. I dunno what
to say for 2.4, to me it looks like a BUG if you pass in a buffer_head
with uninitialized b_reqnext. Why should that member be any different?

In fact, from where did you see this buffer_head coming from? Who is
submitting IO on a not properly inited bh? To me, that sounds like not a
block layer bug but an fs bug.

-- 
Jens Axboe


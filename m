Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSGZOfs>; Fri, 26 Jul 2002 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSGZOfs>; Fri, 26 Jul 2002 10:35:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57504 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317528AbSGZOfr>;
	Fri, 26 Jul 2002 10:35:47 -0400
Date: Fri, 26 Jul 2002 16:38:40 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020726143840.GC8761@suse.de>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com> <3D40E62B.9070202@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D40E62B.9070202@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26 2002, Marcin Dalecki wrote:
> The attached patch does the following:

Looks fine to me. One thing sticks out though:

> +	/*
> +	 * tell I/O scheduler that this isn't a regular read/write (ie it
> +	 * must not attempt merges on this) and that it acts as a soft
> +	 * barrier
> +	 */
> +	rq->flags &= REQ_QUEUED;

this can't be right. Either it's a bug for REQ_QUEUED to be set here, or
it needs to end the tag properly.

> +	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
> +
> +	rq->special = data;
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	/* If command is tagged, release the tag */
> +	if(blk_rq_tagged(rq))
> +		blk_queue_end_tag(q, rq);

woops, you just possible leaked a tag. I really don't think you should
mix inserting a special and ending a tag into the same function, makes
no sense. If a driver wants that it should do:

	if (blk_rq_tagged(rq))
		blk_queue_end_tag(q, rq);

	blk_insert_request(q, rq, bla bla);

Also, please use the right spacing, if(bla :-)

So kill any reference to tagging (and REQ_QUEUED)i in
blk_insert_request, and I'm ok with it.

-- 
Jens Axboe


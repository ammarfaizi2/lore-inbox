Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTJMPfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTJMPfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:35:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14547 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261827AbTJMPfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:35:13 -0400
Date: Mon, 13 Oct 2003 17:35:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031013153503.GZ1107@suse.de>
References: <20031013140858.GU1107@suse.de> <20031013152315.GA26889@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013152315.GA26889@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13 2003, Jeff Garzik wrote:
> On Mon, Oct 13, 2003 at 04:08:58PM +0200, Jens Axboe wrote:
> > +/*
> > + * preempt pending requests, and store this cache flush for immediate
> > + * execution
> > + */
> > +static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
> > +					   struct request *rq, int post)
> > +{
> > +	struct request *flush_rq = &HWGROUP(drive)->wrq;
> > +
> > +	blkdev_dequeue_request(rq);
> > +
> > +	memset(drive->special_buf, 0, sizeof(drive->special_buf));
> > +
> > +	ide_init_drive_cmd(flush_rq);
> > +
> > +	flush_rq->buffer = drive->special_buf;
> > +	flush_rq->special = rq;
> > +	flush_rq->buffer[0] = WIN_FLUSH_CACHE;
> > +
> > +	if (drive->id->cfs_enable_2 & 0x2400)
> > +		flush_rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> > +
> > +	if (!post) {
> > +		drive->doing_barrier = 1;
> > +		flush_rq->flags |= REQ_BAR_PREFLUSH;
> > +	} else
> > +		flush_rq->flags |= REQ_BAR_POSTFLUSH;
> > +
> > +	flush_rq->flags |= REQ_STARTED;
> > +	list_add(&flush_rq->queuelist, &drive->queue->queue_head);
> > +	return flush_rq;
> > +}
> 
> AFAICS you're missing some code that could be a major data corrupter:
> 
> FLUSH CACHE [EXT] may return before it's complete.  You need to create
> an issue loop, that does FLUSH CACHE [EXT] and reads the result.  If the
> result indicates the flush cache was partial, then you need to re-issue
> the flush.  Lather, rinse, repeat until flush cache indicates all data
> is really flushed.

It looks like you are right, at least the wording has changed since ata5
that states that BSY must remain set until all data has been flushed out
(or error occurs). Which seems sane.

Only in the error case can I see this making sense, with partial
flushes. It needs fixing (the error case too), but I'd hardly call that
a major data corrupter. Not for the general case, we'd have to do really
badly to risk corrupting data when compared to how 2.4 and 2.6 with
journalling works now.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVDTJQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDTJQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDTJQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 05:16:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41346 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261392AbVDTJP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 05:15:57 -0400
Date: Wed, 20 Apr 2005 11:14:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/05] scsi: make blk layer set	REQ_SOFTBARRIER when a request is dispatched
Message-ID: <20050420091428.GH6558@suse.de>
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.2DEBE102@htj.dyndns.org> <20050420063009.GB9371@suse.de> <20050420074026.GA11228@htj.dyndns.org> <1113983899.5074.111.camel@npiggin-nld.site> <426614B7.5010204@gmail.com> <20050420083853.GB6558@suse.de> <42661B2C.1020100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42661B2C.1020100@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2005, Nick Piggin wrote:
> >>Hmm, well, it seems that setting REQ_SOFTBARRIER on requeue path isn't
> >>necessary as we have INSERT_FRONT policy on requeue, and if
> >>elv_next_req_fn() is required to return the same request when the
> >>request isn't dequeued, you're right and we don't need this patch at
> >>all.  We are guaranteed that all requeued requests are served in LIFO
> >>manner.
> >
> >
> >After a requeue, it is not required to return the same request again.
> >
> 
> Well I guess not.
> 
> Would there be any benefit to reordering after a requeue?

Logic dictates that requeues should maintain ordering, since we don't
want to reorder around the original io scheduler decisions. But you
could be requeuing more than one request.

> >>BTW, the same un-dequeued request rule is sort of already broken as
> >>INSERT_FRONT request passes a returned but un-dequeued request, but,
> >>then again, we need this behavior as we have to favor fully-prepped
> >>requests over partially-prepped one.
> >
> >
> >INSERT_FRONT really should skip requests with REQ_STARTED on the
> >dispatch list to be fully safe.
> >
> 
> I guess this could be one use of 'reordering' after a requeue.

Yeah, or perhaps the io scheduler might determine that a request has
higher prio than a requeued one.  I'm not sure what semantics to place
on soft-barrier, I've always taken it to mean 'maintain ordering if
convenient' where the hard-barrier must be followed.

> I'm not sure this would need a REQ_SOFTBARRIER either though, really.
> 
> Your basic io scheduler framework - ie. a FIFO dispatch list which
> can have requests requeued on the front models pretty well what the
> block layer needs of the elevator.
> 
> Considering all requeues and all elv_next_request but not dequeued
> requests would have this REQ_SOFTBARRIER bit set, any other model
> that theoretically would allow reordering would degenerate to this
> dispatch list behaviour, right?

Not sure I follow this - I don't want REQ_SOFTBARRIER set automatically
on elv_next_request() return, it should only happen on requeues.
REQ_STARTED implies that you should not pass this request, since the io
scheduler is required to return this request again until dequeue is
called. But the result is the same, correct.

> In which case, the dispatch list is effectively basically the most
> efficient way to do it? In which case should we just explicitly
> document that in the API?

You lost me, please detail exactly what behaviour you want documented :)

-- 
Jens Axboe


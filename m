Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVDTIk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDTIk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDTIkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:40:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4061 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261352AbVDTIkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:40:24 -0400
Date: Wed, 20 Apr 2005 10:38:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, James.Bottomley@steeleye.com,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/05] scsi: make blk layer set	REQ_SOFTBARRIER when a request is dispatched
Message-ID: <20050420083853.GB6558@suse.de>
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.2DEBE102@htj.dyndns.org> <20050420063009.GB9371@suse.de> <20050420074026.GA11228@htj.dyndns.org> <1113983899.5074.111.camel@npiggin-nld.site> <426614B7.5010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426614B7.5010204@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2005, Tejun Heo wrote:
> Nick Piggin wrote:
> > On Wed, 2005-04-20 at 16:40 +0900, Tejun Heo wrote:
> > 
> >> Hello, Jens.
> >>
> >>On Wed, Apr 20, 2005 at 08:30:10AM +0200, Jens Axboe wrote:
> >>
> >>>Do it on requeue, please - not on the initial spotting of the request.
> >>
> >> This is the reworked version of the patch.  It sets REQ_SOFTBARRIER
> >>in two places - in elv_next_request() on BLKPREP_DEFER and in
> >>blk_requeue_request().
> >>
> >> Other patches apply cleanly with this patch or the original one and
> >>the end result is the same, so take your pick.  :-)
> >>
> > 
> > 
> > I'm not sure that you need *either* one.
> > 
> > As far as I'm aware, REQ_SOFTBARRIER is used when feeding requests
> > into the top of the block layer, and is used to guarantee the device
> > driver gets the requests in a specific ordering.
> > 
> > When dealing with the requests at the other end (ie.
> > elevator_next_req_fn, blk_requeue_request), then ordering does not
> > change.
> > 
> > That is - if you call elevator_next_req_fn and don't dequeue the
> > request, then that's the same request you'll get next time.
> > 
> > And blk_requeue_request will push the request back onto the end of
> > the queue in a LIFO manner.
> > 
> > So I think adding barriers, apart from not doing anything, confuses
> > the issue because it suggests there *could* be reordering without
> > them.
> > 
> > Or am I completely wrong? It's been a while since I last got into
> > the code.
> 
>  Well, yeah, all schedulers have dispatch queue (noop has only the
> dispatch queue) and use them to defer/requeue, so no reordering will
> happen, but I'm not sure they are required to be like this or just
> happen to be implemented so.

Precisely, I feel much better making sure SOFTBARRIER is set so that we
_know_ that a scheduler following the outlined rules will do the right
thing.

>  Hmm, well, it seems that setting REQ_SOFTBARRIER on requeue path isn't
> necessary as we have INSERT_FRONT policy on requeue, and if
> elv_next_req_fn() is required to return the same request when the
> request isn't dequeued, you're right and we don't need this patch at
> all.  We are guaranteed that all requeued requests are served in LIFO
> manner.

After a requeue, it is not required to return the same request again.

>  BTW, the same un-dequeued request rule is sort of already broken as
> INSERT_FRONT request passes a returned but un-dequeued request, but,
> then again, we need this behavior as we have to favor fully-prepped
> requests over partially-prepped one.

INSERT_FRONT really should skip requests with REQ_STARTED on the
dispatch list to be fully safe.

-- 
Jens Axboe


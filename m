Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVDSOaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVDSOaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDSOaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:30:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18859 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261554AbVDSOaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:30:06 -0400
Date: Tue, 19 Apr 2005 16:30:01 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Regarding posted scsi midlyaer patchsets
Message-ID: <20050419142959.GK2827@suse.de>
References: <20050417224101.GA2344@htj.dyndns.org> <1113833744.4998.13.camel@mulgrave> <4263CB26.2070609@gmail.com> <20050419123436.GA2827@suse.de> <1113920295.4998.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113920295.4998.13.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19 2005, James Bottomley wrote:
> On Tue, 2005-04-19 at 14:34 +0200, Jens Axboe wrote:
> > On Mon, Apr 18 2005, Tejun Heo wrote:
> > >  And, James, regarding REQ_SOFTBARRIER, if the REQ_SOFTBARRIER thing can
> > > be removed from SCSI midlayer, do you agree to change REQ_SPECIAL to
> > > mean special requests?  If so, I have three proposals.
> > > 
> > >  * move REQ_SOFTBARRIER setting to right after the allocation of
> > > scsi_cmnd in scsi_prep_fn().  This will be the only place where
> > > REQ_SOFTBARRIER is used in SCSI midlayer, making it less pervasive.
> > >  * Or, make another API which sets REQ_SOFTBARRIER on requeue.  maybe
> > > blk_requeue_ordered_request()?
> > >  * Or, make blk_insert_request() not set REQ_SPECIAL on requeue.  IMHO,
> > > this is a bit too subtle.
> > > 
> > >  I like #1 or #2.  Jens, what do you think?  Do you agree to remove
> > > requeue feature from blk_insert_request()?
> > 
> > #2 is the best, imho. We really want to maintain ordering on requeue
> > always, marking it softbarrier automatically in the block layer means
> > the io schedulers don't have to do anything specific to handle it.
> 
> This is my preference too.  In general, block is the only one that
> should care what the REQ_SOFTBARRIER flag actually means.  SCSI only
> cares that it submits a non mergeable request.
> 
> I'm happy to separate the meaning of REQ_SPECIAL from req->special.

Isn't it just duplicate information anyways? I mean, just clear
->special if it isn't valid anymore. Having a seperate flag to indicate
this seems a little suboptimal. It made more sense when ->cmd was a
integer being READ, WRITE, etc. But as a seperate state now it doesn't.

> > I have no problem with removing the requeue stuff from
> > blk_insert_request(). That function is horribly weird as it is, it is
> > supposed to look generic but is really just a scsi special case.
> 
> heh .. would this be because no other driver uses the block layer for
> requeuing ... ?

Not so much that, more that it isn't very clean. It sets rq flags,
assigns ->special, insert the request and then runs the queue. It does
way too much. Either the caller wants a requeue, so he calls
blk_requeue_request(). Or call blk_insert_request(), which should just
do what the name indicates and not a whole bunch of other stuff. Then
add a nicely named function for actually running the queue:

void blk_kick_queue_handling(request_queue_t *q)
{
        if (blk_queue_plugged(q))
                __generic_unplug_device(q);
        else
                q->request_fn(q);
}

(with a better name, I cannot come up with one just now :-)

Yep, this requires you do do the ->special assignment and the queue run
in the caller, but I rather like that compared to a function that you
have to look up in source everytime because you don't know exactly how
much it does.

-- 
Jens Axboe


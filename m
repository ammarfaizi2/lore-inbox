Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbVKPPa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbVKPPa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVKPPa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:30:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12603 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751474AbVKPPaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:30:55 -0500
Date: Wed, 16 Nov 2005 16:31:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051116153119.GN7787@suse.de>
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com> <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu> <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de> <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> 
> > I updated that patch, and converted IDE and SCSI to use it. See the
> > results here:
> >
> > http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq
> 
> I like it but:
> 
> * "we know it's either an FS or PC request" assumption in
>   ide_softirq_done() is really wrong

It used to be correct :-)

No, the problem is that I changed the partial stuff to allow the
deletion/putting of the request to work for every type of request. But
it definitely needs some more looking into.

> * same with "uptodate = rq->errors"

Yeah. In general, ->errors needs to be streamlined. It's a huge mess
right now and it's making generic code really hard to do because every
driver does their own weird thing with it.

I'd like for IDE to really do stuff the error in ->errors, and push the
retry or whatever counting into a ->retries instead. Then we can honor
the simple rule of, rq->errors:

< 0, it contains an -Exxxx value
== 0, no errors, uptodate
> 0, not uptodate, no specific error info. Usually 1.

> * blk_complete_request() is called with ide_lock hold but
>   ide_softirq_done() also takes ide_lock - is this correct?

blk_complete_request() need not be called with the lock held, in fact it
would be best if it wasn't (no point in holding the lock). But right now
it is in ide, because of the below. ide_softirq_done() always needs to
grab the lock. There are no recursion problems there, ide_softirq_done()
is called out-of-order from the actual completion call.

> "There's still room for improvement, as __ide_end_request() really
> could drop the lock after getting HWGROUP->rq (why does it need to
> hold it in the first place? If ->rq access isn't serialized, we are
> screwed anyways)."
> 
> ide_preempt?  and yes we are screwed...

Irk it's nasty, since it basically means we have to hold ide_lock over
the entire functions looking at hwgroup->rq.

It's ok for __ide_end_request() to be entered with the ide_lock held,
the costly affair is usually completing the request. Which now happens
outside of the lock.

We could split the completion path in two - if we know this call will
end the request completely, we can drop the lock and call into the
blk_complete_request() stuff for free. We know we need to clear
hwgroup->rq anyways, so we can do it up front and complete the request
'privately'. If we are not fully completing the request, keep the lock
and do the partial completion. The bonus here is that the first case
will be the often taken path by far (always with DMA and no errors), the
other cases are not interesting from a performance perspective.

-- 
Jens Axboe


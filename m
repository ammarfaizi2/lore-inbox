Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVKPQGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVKPQGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVKPQGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:06:49 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:28009 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030385AbVKPQGs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:06:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c6Ip7wfg/ra7XSm4B48e4Cy6lAPQ0/fsW8DOu+SM8AF8YzlAEmnTxhmig0Epp98mXBZsS5W3vLGoqyDszAgfGIfT9SjS4u1+NIILiR/6/e8xp9OuwhQZa2LCB7Jw9KjewgCSryN0fm1PoehOiFMibXKSGIvxV6c/boQv+q3/Cgc=
Message-ID: <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com>
Date: Wed, 16 Nov 2005 17:06:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20051116153119.GN7787@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114195717.GA24373@havoc.gtf.org> <4379AA5B.1060900@pobox.com>
	 <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com>
	 <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu>
	 <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de>
	 <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com>
	 <20051116153119.GN7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> > On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> >
> > > I updated that patch, and converted IDE and SCSI to use it. See the
> > > results here:
> > >
> > > http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq
> >
> > I like it but:
> >
> > * "we know it's either an FS or PC request" assumption in
> >   ide_softirq_done() is really wrong
>
> It used to be correct :-)

Sorry but it has been always like that,
other requests also pass through ide_end_request()
(which of course needs fixing).

> No, the problem is that I changed the partial stuff to allow the
> deletion/putting of the request to work for every type of request. But
> it definitely needs some more looking into.
>
> > * same with "uptodate = rq->errors"
>
> Yeah. In general, ->errors needs to be streamlined. It's a huge mess
> right now and it's making generic code really hard to do because every
> driver does their own weird thing with it.

Agreed.

> I'd like for IDE to really do stuff the error in ->errors, and push the
> retry or whatever counting into a ->retries instead. Then we can honor
> the simple rule of, rq->errors:
>
> < 0, it contains an -Exxxx value
> == 0, no errors, uptodate
> > 0, not uptodate, no specific error info. Usually 1.

This is a very good idea.

> > * blk_complete_request() is called with ide_lock hold but
> >   ide_softirq_done() also takes ide_lock - is this correct?
>
> blk_complete_request() need not be called with the lock held, in fact it
> would be best if it wasn't (no point in holding the lock). But right now
> it is in ide, because of the below. ide_softirq_done() always needs to
> grab the lock. There are no recursion problems there, ide_softirq_done()
> is called out-of-order from the actual completion call.
>
> > "There's still room for improvement, as __ide_end_request() really
> > could drop the lock after getting HWGROUP->rq (why does it need to
> > hold it in the first place? If ->rq access isn't serialized, we are
> > screwed anyways)."
> >
> > ide_preempt?  and yes we are screwed...
>
> Irk it's nasty, since it basically means we have to hold ide_lock over
> the entire functions looking at hwgroup->rq.
>
> It's ok for __ide_end_request() to be entered with the ide_lock held,
> the costly affair is usually completing the request. Which now happens
> outside of the lock.

We should get rid of ide_preempt later.

This will also allow us to remove ide_do_drive_cmd()
and use blk_execute_rq() exclusively.

> We could split the completion path in two - if we know this call will
> end the request completely, we can drop the lock and call into the
> blk_complete_request() stuff for free. We know we need to clear
> hwgroup->rq anyways, so we can do it up front and complete the request
> 'privately'. If we are not fully completing the request, keep the lock
> and do the partial completion. The bonus here is that the first case
> will be the often taken path by far (always with DMA and no errors), the
> other cases are not interesting from a performance perspective.

Sounds good.

Bartlomiej

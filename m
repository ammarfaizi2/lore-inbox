Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSGXPMe>; Wed, 24 Jul 2002 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSGXPMe>; Wed, 24 Jul 2002 11:12:34 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:22512 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317037AbSGXPMc>; Wed, 24 Jul 2002 11:12:32 -0400
Date: Wed, 24 Jul 2002 17:15:30 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <martin@dalecki.de>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: cpqarray broken since 2.5.19
In-Reply-To: <3D3EBDC6.3060601@evision.ag>
Message-ID: <Pine.SOL.4.30.0207241713370.2960-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Marcin Dalecki wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 24 Jul 2002, Jens Axboe wrote:
> >
> >
> >>On Wed, Jul 24 2002, Marcin Dalecki wrote:
> >>
> >>>>Jens, the same is in cciss.c.
> >>>>Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> >>>>unlocking in request_functions.
> >>>>
> >>>
> >>>Bartek I think the removal is just for reassertion that the
> >>>locking is the problem. You can't remove it easly from
> >>>blk_stop_queue() unless you make it mandatory that blk_stop_queue
> >>>has to be run with the lock already held. Or in other words
> >>>basically -> Don't use blk_stop_queue() outside of ->request_fn.
> >>
> >>Of couse Bart is advocating just making sure that every caller of
> >>blk_stop_queue() _has_ the queue_lock before calling it, not removing
> >>the locking there.
> >>
> >>--
> >>Jens Axboe
> >
> >
> > And I'm also advocating for __blk_start_queue() ideal for usage in
> > ata_end_request(). And moving spin_lock scope to cover test_and_set_bit()
> > in blk_start_queue() (for coherency and avoiding spurious calls to
> > q->request_fn() )
>
> You mean this:
>
> void blk_start_queue(request_queue_t *q)
> {
> 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> 		unsigned long flags;
>
> 		spin_lock_irqsave(q->queue_lock, flags);
> 		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> 			spin_unlock_irqrestore(q->queue_lock, flags);
> 			return;
> 		}
> 		clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
> 		if (!elv_queue_empty(q))
> 			q->request_fn(q);
> 		spin_unlock_irqrestore(q->queue_lock, flags);
> 	}
> }

No I mean full locking version. Look at usage context - queue will be
almost (== queueing drivers) stopped.

> Becouse this is avoiding checking for spinlock in the case
> the queue is not stopped.
>
> The spinlock free variant isn't needed right.

Is needed/helpful.

> > However IDE_BUSY -> QUEUE_STOPPED_FLAG is braindamaged idea.
>
> You should never see it. Think of it as a mind bridge between
> IDE_BUSY and queue plug and unplug please. Becouse the purpose
> of IDE_BUSY *is* to effectively stall queue processing for
> the time of internally issued request. OK?

I don't care == I'm tired of bullshit.

--
Bartlomiej


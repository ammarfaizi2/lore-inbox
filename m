Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSGXMqc>; Wed, 24 Jul 2002 08:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGXMqc>; Wed, 24 Jul 2002 08:46:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5837 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317181AbSGXMqb>; Wed, 24 Jul 2002 08:46:31 -0400
Date: Wed, 24 Jul 2002 14:49:18 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: <martin@dalecki.de>, <linux-kernel@vger.kernel.org>
Subject: Re: please DON'T run 2.5.27 with IDE!
In-Reply-To: <20020724124124.GA15201@suse.de>
Message-ID: <Pine.SOL.4.30.0207241446130.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Jens Axboe wrote:

> On Wed, Jul 24 2002, Bartlomiej Zolnierkiewicz wrote:
> > > void blk_start_queue(request_queue_t *q)
> > > {
> > >          if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> > >                  unsigned long flags;
> > >
> > > ================== possigle race here for qeue_flags BTW.
> > >
> > >                  spin_lock_irqsave(q->queue_lock, flags);
> > >                  clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
> > >
> > >                  if (!elv_queue_empty(q))
> > >                          q->request_fn(q);
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > If we call it from within request_fn then if this isn't recursion on the
> > > kernel stack then I don't know...
> >
> > You really don't know.
> >
> > And funny thing is I have diffirent blk_start_queue() function in my tree
> > (2.5.27) ? Without described above race and without possibilty of
> > recursion...
> >
> > 2.5.27:drivers/block/ll_rw_blk.c
> > void blk_start_queue(request_queue_t *q)
> > {
> >         if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> >                 unsigned long flags;
> >
> >                 spin_lock_irqsave(q->queue_lock, flags);
> >                 if (!elv_queue_empty(q))
> >                         q->request_fn(q);
> >                 spin_unlock_irqrestore(q->queue_lock, flags);
> >         }
> > }
>
> Yep, the version Martin posted must be really old.

It's worst. Martin's version exists only in his tree (mind?).
I checked back revision and blk_start_queue() was inroduced in 2.5.19
and it was the correct one.

> --
> Jens Axboe



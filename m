Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSGXOF2>; Wed, 24 Jul 2002 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSGXOF2>; Wed, 24 Jul 2002 10:05:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44001 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317117AbSGXOF1>; Wed, 24 Jul 2002 10:05:27 -0400
Date: Wed, 24 Jul 2002 16:07:59 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Adam Kropelin <akropel1@rochester.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: cpqarray broken since 2.5.19
In-Reply-To: <20020724133959.GD5159@suse.de>
Message-ID: <Pine.SOL.4.30.0207241606090.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Jens Axboe wrote:

> On Sun, Jul 21 2002, Adam Kropelin wrote:
> > The cpqarray driver seems to have been broken around 2.5.19 with the
> > blk_start_queue/blk_stop_queue changes. As-is, cpqarray deadlocks the entire
> > system when it tries to do partition detection. The bits from the 2.5.19 patch
> > which seem to relate are:
> >
> > > @@ -916,6 +915,7 @@
> > >       goto queue_next;
> > >
> > >  startio:
> > > +     blk_stop_queue(q);
> > >       start_io(h);
> > >  }
> > >
> > > @@ -1066,8 +1066,8 @@
> > >       /*
> > >        * See if we can queue up some more IO
> > >        */
> > > -     do_ida_request(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
> > >       spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags);
> > > +     blk_start_queue(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
> > >  }
> > >
> > >  /*
> >
> > Simply reverting these changes allows the driver to successfully do
> > partition detect, but it quickly hangs if any significant amount of
> > I/O is attempted. The hang in this case seems to just affect processes
> > trying to do I/O on the array; it is not a whole-system-deadlock.
> >
> > Test machine is SMP ppro.
>
> Thanks for the report. Could you just kill the spin_lock/unlock in
> blk_stop_queue() in drivers/block/ll_rw_blk.c and see if it works?
>
> --
> Jens Axboe

Jens, the same is in cciss.c.
Please remove locking from blk_stop_queue() (as you suggested) or intrduce
unlocking in request_functions.

--
Bartlomiej


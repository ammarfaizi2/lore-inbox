Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTEHNWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTEHNWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:22:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35988 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261405AbTEHNWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:22:49 -0400
Date: Thu, 8 May 2003 15:35:04 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030508132314.GZ823@suse.de>
Message-ID: <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Jens Axboe wrote:
> On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Thu, 8 May 2003, Jens Axboe wrote:
> >
> > > n Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> > > > 	if (!hwif->rqsize)
> > > > 		hwif->rqsize = hwif->addressing ? 65536 : 256;
> > >
> > > btw, you didn't get this right this time either :-)
> >
> > It is right.
> > hwif->addressing means hwif supports 48-bit
>
> No it doesn't, that's what I keep saying:
>
> static int probe_lba_addressing (ide_drive_t *drive, int arg)
> {
>         drive->addressing =  0;
>
>         if (HWIF(drive)->addressing)
>                 return 0;
>
> 	...
>
> so if hwif->addressing != 0, you will never allow 48-bit lba on any
> units on this hardware interface. So the correct logic is:
>
> 	hwif->rqsize = hwif->addressing ? 256 : 65536;
>
> as in the patch.

Yep, you are right, hwif->addressing logic is reversed, what a mess.

> > hwif->rqsize means max rq size for _hwif_
>
> Correct.
>
> > > drive->addressing == 1, 48-bit is ok
> > > hwif->addressing == 1, 48-bit is _not_ ok
> >
> > And?
> > Even if !drive->addressing, hwif->addressing can be 1,
>
> If hwif->addressing == 1, drive->addressing will never be anything _but_
> 0.
>
> > so hwif->rqsize can be 65536.
>
> Wrong
>
> > > below patch covers the lat change as well, boots and works on my router.
> >
> > Patch still misses pdx202xx_old.c changes :-).
>
> Which?

Checking for taskfile requests.

> > Two new ones:
> > - rq_lba48(rq) should check for rq->hard_* values
>
> Doesn't matter. I actually only thought about dma, in which case it
> doesn't matter because we never change sector or nr_sectors until after
> we have called ide_dma_end. For pio, it's no more reliable with hard_*
> than without. This is all for end_request context of course, at init
> time it's all the same. Essentially, we _need_ the taskfile changes for
> this to work. In that case we can limit rq_lba48() to init request time,
> and set task->addressing and use that from then on.

Yes.

> > - after some thought, drop _all_ changes to ide_dump_status()
> >   (we may hit error when rq->nr_sectors is already < 256)
>
> Ditto, cannot be reliable without the taskfile changes.
>
> I won't bother with anything new until the taskfile stuff is in.

Good decision.
--
Bartlomiej

> --
> Jens Axboe


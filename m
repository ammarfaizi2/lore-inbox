Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSHBP7T>; Fri, 2 Aug 2002 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSHBP7N>; Fri, 2 Aug 2002 11:59:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17579 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316446AbSHBP56>; Fri, 2 Aug 2002 11:57:58 -0400
Date: Fri, 2 Aug 2002 18:01:05 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: <martin@dalecki.de>, Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
In-Reply-To: <20020802142037.GT3010@suse.de>
Message-ID: <Pine.SOL.4.30.0208021625020.3612-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, Jens Axboe wrote:

> On Fri, Aug 02 2002, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Fri, 2 Aug 2002, Jens Axboe wrote:
> >
> > > On Fri, Aug 02 2002, Jens Axboe wrote:
> > > > On Fri, Aug 02 2002, Marcin Dalecki wrote:
> > > > > U?ytkownik Stephen Lord napisa?:
> > > > > >In 2.5.30 I started getting these warning messages out ide during
> > > > > >the mount of an XFS filesystem:
> > > > > >
> > > > > >ide-dma: received 1 phys segments, build 2
> > > > > >
> > > > > >Can anyone translate that into English please.
> > > > >
> > > > > It can be found in pcidma.c.
> > > > > It is repoting that we have one physical segment needed by
> > > > > the request in question but the sctter gather list allocation
> > > > > needed to break it up for mapping in two.
> > > >
> > > > You don't seem to realise that this is a BUG (somewhere, could even be
> > > > in the generic mapping functions)! blk_rq_map_sg() must never map a
> > > > request to more entries that rq->nr_segments, that's just very wrong.
> > > >
> > > > That's why I'm suspecting the recent pcidma changes. Just a feeling, I
> > > > have not looked at them.
> > >
> > > I'll take that back. Having looked at Adam's changes there are perfectly
> > > fine. I'm now putting my money on IDE breakage somewhere instead. It
> >
> > Look again Jens. Adam's changes made IDE queue handling inconsistent.
> > hint: 2 * 127 != 255
> >
> > But noticed warning deals with design of ll_rw_blk.c. ;-)
> > (right now max_segment_size have to be max bv->bv_len aligned)
>
> Yeah that's true, actually was just saying that on linux-scsi
> yesterday/today.

:-)

> > Jens, please look at segment checking/counting code, it does it on
> > bv->bv_len (4kb most likely) not sector granuality...
> >
> > So for not 4kb aligned max_segment_size we will get new segment...
> >
> > Best fix will be to make block layer count sectors not bv->bv_len...
>
> Well I'm inclined to just make that page size granularity. It's like
> that in 2.4 as well (no guarentees that we will honor anything less than
> that granularity).

Anyway it must be also something diffirent - __make_request() should have
noticed that rq has 2 segments not 1... this puzzles me a bit.

This case also shows limits of BIO_MAX_SECTORS again (Adam worked on
generic solution, but I don't know current state). There some devices
which set q->max_sectors to 64, i.e. broken ide-floppy driver ;-)

> > btw. I like Adam's patch but it was draft not to include in mainline (?).
>
> The concept is sound, so it has a bug... I can say the same for other
> stuff in the kernel as well :-)

Yes. :-)

> I probably just wanted more review (my 1 minute review surely wasn't
> enough).
>
> --
> Jens Axboe

Greets
--
Bartlomiej


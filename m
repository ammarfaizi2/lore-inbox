Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSG3Vbl>; Tue, 30 Jul 2002 17:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSG3Vbl>; Tue, 30 Jul 2002 17:31:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14610 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316621AbSG3Vbi>; Tue, 30 Jul 2002 17:31:38 -0400
Date: Tue, 30 Jul 2002 17:44:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] disable READA
In-Reply-To: <Pine.LNX.4.44.0207301740090.2285-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0207301743280.2285-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ah, haven't read the full message.

Forget about my question. :)

On Tue, 30 Jul 2002, Marcelo Tosatti wrote:

>
> Who is using READA this days ?
>
>
> On Tue, 30 Jul 2002, Andrew Morton wrote:
>
> >
> > There's a bug in bread() which can cause it to misinterpret a
> > failed READA request as an IO error on SMP.
> >
> > If a filesytem block is subject to READA and __make_request()
> > decides that the request would block then __make_request()
> > will (via end_buffer_io_sync) mark the buffer as not uptodate
> > and will unlock it.
> >
> > But if another CPU attempts to bread() the same buffer at the same
> > time, the following happens:
> >
> > 1: ll_rw_block() sees the buffer is locked and does nothing at all
> >
> > 2: bread() does a wait_on_buffer()
> >
> > 3: the other CPU (the one doing READA) unlocks the non uptodate buffer
> >
> > 4: bread() sees the buffer come unlocked.  It's not uptodate, so
> >    bread() bogusly reports an IO error.
> >
> > I haven't seen it in the wild, because it is rare to get that
> > much read I/O in flight.  reiserfs and ext3 (at least) use READA.
> >
> > An appropriate fix for 2.4 is to disable READA.
> >
> >
> >  ll_rw_blk.c |    2 ++
> >  1 files changed, 2 insertions
> >
> > --- 2.4.19-rc3/drivers/block/ll_rw_blk.c~no-readahead	Tue Jul 30 14:18:17 2002
> > +++ 2.4.19-rc3-akpm/drivers/block/ll_rw_blk.c	Tue Jul 30 14:19:52 2002
> > @@ -841,7 +841,9 @@ static int __make_request(request_queue_
> >  	rw_ahead = 0;	/* normal case; gets changed below for READA */
> >  	switch (rw) {
> >  		case READA:
> > +#if 0	/* bread() misinterprets failed READA attempts as IO errors on SMP */
> >  			rw_ahead = 1;
> > +#endif
> >  			rw = READ;	/* drop into READ */
> >  		case READ:
> >  		case WRITE:


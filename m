Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUADRbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUADRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:31:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:42730 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265807AbUADRbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:31:06 -0500
Subject: Re: Possibly wrong BIO usage in ide_multwrite
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200401032302.32914.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401020127.50558.bzolnier@elka.pw.edu.pl>
	 <1073013643.20163.51.camel@leto.cs.pocnet.net>
	 <200401032302.32914.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1073237458.6069.31.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 18:30:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 03.01.2004 schrieb Bartlomiej Zolnierkiewicz um 23:02:

> > The way I would prefer is that when someone calls bio_endio the bi_idx
> > and bv_offset just point where the processed data begins.
> 
> Are you aware that this will make partial completions illegal?
> [ No problem for me. ]

Why that? __end_that_request_first already does this (when moving thw
two lines updating bv_offset/bv_len after the call of the bi_end_io
function).

> > Can't another (some local) variable be used as bvec index instead of
> > bi_idx in the original bio? (except from ide_map_buffer using exactly
> > this index...)
> 
> see rq_map_buffer() in include/linux/blkdev.h

Right. I've been going through ide-taskfile.c for the last hours.

The IDE_TASKFILE_IO gets things right (from my point of view) and is
also much cleaner. (I would personally vote for dropping the non
TASKFILE_IO code, it would make my problem go away :D - why is it still
marked as experimental BTW? I've been using it since it was introduced,
without any problems)

BTW: The taskfile code that is used when IDE_TASKFILE_IO is disabled
might partially end requests without knowing the actual status, right?

>      /*
>       * FIXME :: We really can not legally get a new page/bh
>       * regardless, if this is the end of our segment.
>       * BH walking or segment can only be updated after we
>       * have a good  hwif->INB(IDE_STATUS_REG); return.
>       */
>      if (!rq->current_nr_sectors) {
>         if (!DRIVER(drive)->end_request(drive, 1, 0))
>            if (!rq->bio)
>               return ide_stopped;
>      }
>   } while (msect);

Well, there's a FIXME so you know this is not legal, but to make sure.
In ide-disk.c you're walking the segments yourself using the original
bi_idx which avoids this problem but which is my original problem. And
TASKFILE_IO gets things right (from my point of view) and doesn't do
illegal things because it uses the "generic driver walking code" using
cbio/process_that_request_first and co.

So non TASKFILE_IO code has two multout codepaths (taskfile and not)
that are both "awkward" while TASKFILE_IO merges both into a single and
clean version.

> > Still, I see, mcount could go to zero before the bio is finished and we
> > would need to store the bvec index somewhere, I see the problem.
> 
> bvec index and offset

Exactly.

> > What about doing a partial bio completion in multwrite_intr? If there is
> > data left you know you've finished multcount sectors, right?
> 
> Not always, ie. no. of sectors equal to no. of multicount sectors.

Yes, I didn't think about this one.

> > > There are 2 solutions for this problem:
> > >
> > > - Use separate bio lists (rq->cbio) and temporary data
> > >   (rq->nr_cbio_segments and rq->nr_cbio_sectors) for
> > > submission/completion.
> >
> > That would be somewhat similar to what I just proposed, right?
> 
> Right, rq->nr_cbio_segments holds number of bvecs still to be processed
> (no need to change bio->bi_idx) and rq->nr_cbio_sectors number of sectors
> in the bio still to be proccessed (so rq->current_nr_sectors can be number
> of sectors still to do in the current bvec).
> 
> Please note that this method doesn't require copy of struct request
> (using scratch request copy is quite expensive).

Yes. There's a memcpy commented out (#if 0) in ide-taskfile.c which you
don't ned because you "illegaly" let end_request (and so
end_that_request_first) to walk the request for you.

Using the cbio & co. mechanism you can let process_that_request_first
walk the code for you ("legally") without needing the copy either.

> > Would you be interested in a small patch (well, if I can come up with
> > one)?
> 
> Sure, but I don't know what you want to change... :-)

I'm not yet sure, either. I don't think that a too invasive version
would be adequate though converting this mess to the cbio method would
be nice. Or would you prefer to see that? I don't think it's worth
starting on that since you said you'de like to see this part of the IDE
layer die in 2.7 anyway. I would really like to see ide_map_buffer die
in favor of rq_map_buffer though. Hmm.
Perhaps I can think of something else. It's really tricky...

> > >   Please look at process_that_request_first() and its usage in TASKFILE
> > > code.
> >
> > I'll do. I already noticed that it used the other fields and obviously
> > doesn't use bi_idx the same way.
> >
> > >   You are then required to do partial bio completion.
> >
> > Yes.
> 
> Actually no, my mistake... s/required/allowed/
> IDE taskfile code doesn't use partial completions.

Not partial completions of bios but partial completion of requests,
right?

Things like

>   while (rq->bio != rq->cbio)
>      if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
>         return ide_stopped;

in the interrupt handlers if you know they suceedeed.

Partial bio completions would probably also be possible, I see, but I
don't need to or want to change that.

Okay.

I'm trying to figure something out to avoid my original ++bio->bi_idx
problem.



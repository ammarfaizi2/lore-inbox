Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTEHAOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTEHAOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:14:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30381 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264145AbTEHAOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:14:23 -0400
Date: Thu, 8 May 2003 02:26:37 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dave Peterson <dsp@llnl.gov>
cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>, <davej@suse.de>
Subject: Re: [PATCH] fixes for linked list bugs in block I/O code
In-Reply-To: <200305071709.57757.dsp@llnl.gov>
Message-ID: <Pine.SOL.4.30.0305080214580.5113-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Dave Peterson wrote:

> On Wednesday 07 May 2003 04:42 pm, Bartlomiej Zolnierkiewicz wrote:
> > > ========== START OF 2.5.69 PATCH FOR drivers/block/ll_rw_blk.c
> > > =========== --- ll_rw_blk.c.old     Wed May  7 15:55:18 2003
> > > +++ ll_rw_blk.c.new     Wed May  7 16:01:56 2003
> > > @@ -1721,6 +1721,7 @@
> > >                                 break;
> > >                         }
> > >
> > > +                       bio->bi_next = req->biotail->bi_next;
> >
> > This is simply wrong, look at the line below.
> >
> > >                         req->biotail->bi_next = bio;
> >
> > req->bio - first bio
> > req->bio->bi_next - next bio
> > ...
> > req->biotail - last bio
> >
> > so req->biotail->bi_next should be NULL
>
> I believe it is correct.  Assuming that the list is initially in a
> sane state, req->biotail->bi_next will be NULL immediately before
> executing the statement that I added.  Therefore, my fix will set
> bio->bi_next to NULL, which is what we want because bio becomes the
> new end of the list.

Yes, but bio->bi_next is a NULL already.

> > >                         req->biotail = bio;
> > >                         req->nr_sectors = req->hard_nr_sectors +=
> > > nr_sectors; @@ -1811,6 +1812,7 @@
> > >         req->buffer = bio_data(bio);    /* see ->buffer comment above */
> > >         req->waiting = NULL;
> > >         req->bio = req->biotail = bio;
> > > +       bio->bi_next = NULL;
> >
> > No need for that, look at bio_init() in fs/bio.c.
>
> Yes, it looks like bio_init has been added in the 2.5 kernels, solving
> the problem.  However, this is still a bug in 2.4.20.

Maybe. If so only second part of the patch is important.

Regards,
--
Bartlomiej


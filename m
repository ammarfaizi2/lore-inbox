Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUAWPUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbUAWPUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:20:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9405 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266585AbUAWPTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:19:51 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pascal Schmidt <der.eremit@email.de>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
Date: Fri, 23 Jan 2004 16:24:14 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401231456450.944-100000@neptune.local>
In-Reply-To: <Pine.LNX.4.44.0401231456450.944-100000@neptune.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401231624.14687.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 of January 2004 15:01, Pascal Schmidt wrote:
> On Fri, 23 Jan 2004, Jens Axboe wrote:
> > It's a good first start, thanks for doing this. You really want to be
> > storing this info in the queue, though, there's a hardsector size just
> > for this very purpose. That way other layers know about the hardware
> > sector size as well, not just ide-cd. And you get other things right for
> > free as well, for instance ide_cdrom_prep_fs() needs a correct hardware
> > block size or it will build wrong cdbs.
>
> Hmmm. I'm doing
>
> 	blk_queue_hardsect_size(drive->queue, sectors_per_frame << 9);
>
> inside of cdrom_read_toc, is that not enough? Or do you mean that
> I should only store it in the queue and not also in cdrom_state_flags?

I think Jens means storing it only in q->hardsect_size.
This way you can just use rq->q->hardsect_size << 9 to get sectors_per_frame.

> > Hmm, you made it a bit more confusing. It should read that writes must
> > be hardware sector aligned. Something ala
> >
> > 	if ((rq->nr_sectors << 9) & (sector_size - 1) ||
> > 	    (rq->sector & ((sector_size >> 9) - 1)))
> > 		problem
>
> I'll change that.

If you do that please remember to revert this chunk
(except comment fix of course):

@@ -1969,9 +1959,13 @@ static ide_startstop_t cdrom_start_write
 
        info->nsectors_buffered = 0;
 
-        /* use dma, if possible. we don't need to check more, since we
-        * know that the transfer is always (at least!) 2KB aligned */
-       info->dma = drive->using_dma ? 1 : 0;
+       /* use dma, if possible */
+       if (drive->using_dma && (rq->sector % sectors_per_frame == 0) &&
+                               (rq->nr_sectors % sectors_per_frame == 0))
+               info->dma = 1;
+       else
+               info->dma = 0;
+

> > > -	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
> > > +	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
> > > +
> > > +	if (CDROM_STATE_FLAGS(drive)->sectors_per_frame != sectors_per_frame)
> > > +		printk(KERN_INFO "%s: new hardware sector size %lu\n",
> > > +			drive->name, sectors_per_frame << 9);
> >
> > if you feel you must print this, then do it in the same line as the
> > other cdrom info printed.
>
> This happens on disc change, no other info is normally printed. But this
> printk can probably go away, I just put it there for debugging.

Good. 

Cheers,
--bart


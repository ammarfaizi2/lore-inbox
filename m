Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTEHMIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEHMIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:08:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9461 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261350AbTEHMId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:08:33 -0400
Date: Thu, 8 May 2003 14:20:35 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030508115950.GQ823@suse.de>
Message-ID: <Pine.SOL.4.30.0305081406310.12362-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Jens Axboe wrote:

> On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Thu, 8 May 2003, Jens Axboe wrote:
> > > On Wed, May 07 2003, Jens Axboe wrote:
> > > > > Jens you your patch sets hwif->rqsize to 65535 in setup-pci.c for all
> > > > > PCI hwifs which is simply wrong as not all of them supports LBA48.
> > > > > You should check for hwif->addressing and if true set rqsize to 65536
> > > > > (not 65535) and not in IDE PCI code but in ide_init_queue() in ide-probe.c.
> > > >
> > > > Yes you are right, that would be the best way of doing it. As it happens
> > > > for that patch, it does not hurt or break anything. But it is certainly
> > > > cleaner, I'll fix that up.
> > >
> > > That part is added, I still kept it at 65535 though akin to how we don't
> > > use that last sector in 28-bit commands either. For 48-bit commands this
> >
> > No, ide_init_queue() sets it to 256, so I want 65536 too.
>
> Alright, I don't care enough about that 1 sector to argue.
>
> > Note that it should be done after setting queue max sectors to 256,
> > because not only ide-disk depends on this code:
> >
> > 	max_sectors = 256;
> >
> > 	(...)
> >
> > 	/*
> > 	 * Added "< max_sectors" check for safety if it will
> > 	 * be called again later with rq->size = 65536.
> > 	 * I don't believe it ever is.
> > 	*/
> > 	if (hwif->rqsize < max_sectors)
> > 		max_sectors = hwif->rqsize;
> > 	blk_queue_max_sectors(q, max_sectors);
> > 	if (!hwif->rqsize)
> > 		hwif->rqsize = hwif->addressing ? 65536 : 256;
>
> You have the logic reversed here, the hwif and drive addressing are
> reversed. Yeah, it's convoluted, dunno who thought that logic up...

Not me.
Logic is to prevent some bugs and actually my comment "I don't believe it
ever is." is totally wrong.

ide_init_queue() is called for all drives on hwif.

ie. failure scenario:
1st drive 48-bit: !rqsize -> max_sectors = 256, rqsize = 65536
2nd drive 28-bit: rqsize -> max_sectors = 65536 -> doh!

so "< max_sectors" is really needed.

It can look a bit saner:

	if (!hwif->rqsize)
		hwif->rqsize = hwif->addressing ? 65536 : 256;
	if (hwif->rqsize < max_sectors)
		max_sectors = hwif->rqsize;
	blk_queue_max_sectors(q, max_sectors);

> > > > > Patch also misses updates for many uses of drive->addressing
> > > > > (in ide.c, ide-io.c, icside.c, ide-tcq.c and even in ide-taskfile.c).
> > > >
> > > > Hmm bad grep, weird.
> > >
> > > ide.c: ide_dump_status(). this is an ugly one, but to me it already
> > > looks correct. we are not throwing away any info by not reading the high
> > > bits.
> >
> > It should check for rq_lba48(rq) || task->addressing.
> > After taskfile IO switch it will be checking for task->addressing only.
>
> This is really ugly, but it has to look like that until you make the
> global taskfile changes...

Yep.

> > > ide-io.c, ide-tcq.c, icside.c: indeed, missed these.
> > >
> > > > > Jens, I like the general idea of the patch, but it needs some more work.
> > > > > Linus, please don't apply for now.
> > > >
> > > > Agree, I'll update the patch to suit your concerns tomorrow.
> > >
> > > Apart from the pdc202xx_old part, I think I've addressed all of your
> > > concerns in this patch.
> >
> > Nope ;-), please move setting of hwif->rqsize from setup-pci.c to where
> > it belongs, ide_init_queue() in ide-probe.c.
>
> So how's this?

Looks good.
Now test/review it for some time, we don't want any bugs to slip in.
:-)

--
Bartlomiej



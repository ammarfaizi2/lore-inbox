Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTEHMOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTEHMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:14:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261449AbTEHMOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:14:05 -0400
Date: Thu, 8 May 2003 14:26:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508122641.GW823@suse.de>
References: <20030508115950.GQ823@suse.de> <Pine.SOL.4.30.0305081406310.12362-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305081406310.12362-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> On Thu, 8 May 2003, Jens Axboe wrote:
> 
> > On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > On Thu, 8 May 2003, Jens Axboe wrote:
> > > > On Wed, May 07 2003, Jens Axboe wrote:
> > > > > > Jens you your patch sets hwif->rqsize to 65535 in setup-pci.c for all
> > > > > > PCI hwifs which is simply wrong as not all of them supports LBA48.
> > > > > > You should check for hwif->addressing and if true set rqsize to 65536
> > > > > > (not 65535) and not in IDE PCI code but in ide_init_queue() in ide-probe.c.
> > > > >
> > > > > Yes you are right, that would be the best way of doing it. As it happens
> > > > > for that patch, it does not hurt or break anything. But it is certainly
> > > > > cleaner, I'll fix that up.
> > > >
> > > > That part is added, I still kept it at 65535 though akin to how we don't
> > > > use that last sector in 28-bit commands either. For 48-bit commands this
> > >
> > > No, ide_init_queue() sets it to 256, so I want 65536 too.
> >
> > Alright, I don't care enough about that 1 sector to argue.
> >
> > > Note that it should be done after setting queue max sectors to 256,
> > > because not only ide-disk depends on this code:
> > >
> > > 	max_sectors = 256;
> > >
> > > 	(...)
> > >
> > > 	/*
> > > 	 * Added "< max_sectors" check for safety if it will
> > > 	 * be called again later with rq->size = 65536.
> > > 	 * I don't believe it ever is.
> > > 	*/
> > > 	if (hwif->rqsize < max_sectors)
> > > 		max_sectors = hwif->rqsize;
> > > 	blk_queue_max_sectors(q, max_sectors);
> > > 	if (!hwif->rqsize)
> > > 		hwif->rqsize = hwif->addressing ? 65536 : 256;
> >
> > You have the logic reversed here, the hwif and drive addressing are
> > reversed. Yeah, it's convoluted, dunno who thought that logic up...
> 
> Not me.
> Logic is to prevent some bugs and actually my comment "I don't believe it
> ever is." is totally wrong.
> 
> ide_init_queue() is called for all drives on hwif.
> 
> ie. failure scenario:
> 1st drive 48-bit: !rqsize -> max_sectors = 256, rqsize = 65536
> 2nd drive 28-bit: rqsize -> max_sectors = 65536 -> doh!
> 
> so "< max_sectors" is really needed.
>
> It can look a bit saner:
> 
> 	if (!hwif->rqsize)
> 		hwif->rqsize = hwif->addressing ? 65536 : 256;
> 	if (hwif->rqsize < max_sectors)
> 		max_sectors = hwif->rqsize;
> 	blk_queue_max_sectors(q, max_sectors);

Ugh yeah, that stinks. Your changed version looks better.

> Looks good.
> Now test/review it for some time, we don't want any bugs to slip in.
> :-)

I'll give it a test spin.

-- 
Jens Axboe


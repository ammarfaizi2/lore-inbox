Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTLXJko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 04:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLXJko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 04:40:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64004
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263497AbTLXJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 04:40:42 -0500
Date: Wed, 24 Dec 2003 01:39:56 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Jim Lawson <jim+linux-kernel@jimlawson.org>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.0, SiI3112, md raid1 problem: bio too big device (128 > 15)
In-Reply-To: <3FE91EB8.8020107@pobox.com>
Message-ID: <Pine.LNX.4.10.10312240057500.18820-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem is creating a sane MOD15(bio->table).
Where one has to control the FIS out the PHY and prevent a the trailing
FIS to be full if it is the last FIS.  Where a FIS is 8K, should one have
a data segment in the final FIS which fills the FIS, one needs to break
and create a new one composed of a 7.5K and 0.5K FIS.

Now in SATA 1.0, there is no control or interface to managing the "raw
fis".  So this is handled by creating a clever scattergather table.

So if the total transfer has a remainder on the last bh/bio, the a new
nent must be created.  The description starts to get mangled from now on
out :-/

	int remainder = MOD15(total transfer in 512b sectors);

	NOT the Mickey Mouse fake sectors of 1024b !!!

	do {
		blah_blah(SFF-8038i dma sglist);

		if ((total transfer - remainder == current nent) &&
		    (the remainder will fill the final nent)) {
			fill_nent_fill_less_one_sector();
			create_new_nent();
			fill_nent_with_last_sector():
 		}
	} while();

Yeah, this is one of those emails where I need a translator.
So read the documents from the working groups.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 24 Dec 2003, Jeff Garzik wrote:

> Jim Lawson wrote:
> > Hi all,
> > 
> > I am having trouble creating a raid1 array under 2.6.0.  I am able to
> > create raid0 and raid5 mds, but raid1s fail with "bio too big device hde3
> > (128 > 15)", which doesn't tell me a lot.  I can see it's in
> > drivers/block/ll_rw_blk.c, right at the boundary with the device driver,
> > but I'm not enough of a kernel wonk to find out a lot more.
> > 
> > I'm not sure if this has to do with a kernel bug, a bug in the driver for
> > the controller I have (SiI3112, Silicon Image 3112), or the disks I am
> > using (Seagate Barracuda 7200.7, 160 GB SATA disks) ... or the combination
> > thereof :-)
> 
> 
> Hum... that's kinda interesting.
> 
> AFAICS, the basic problem is that Silicon Image's sector size limitation 
> means that md cannot submit stripe-sized bio's as it wishes.
> 
> md does indeed split bio's in raid0, so it makes sense that it works (to 
> my naive eye).  I'm amazed raid5 works, since raid5 appears to hardcode 
> STRIPE_SIZE.  And I don't see splitting code in raid1, so it would make 
> sense that raid1 would fail.
> 
> In general though, I'm surprised that each block driver has to 
> reimplement the pain of splitting its own bio's, to conform to the 
> underlying device.  Since bio's can be merged after 
> generic_make_request(), surely it makes sense to implement bio splitting 
> -once- in the block layer, rather than in each block driver that has to 
> care about stackable block devices?
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


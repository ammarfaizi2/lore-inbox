Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTLXKsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 05:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTLXKsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 05:48:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40396 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263568AbTLXKsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 05:48:05 -0500
Date: Wed, 24 Dec 2003 11:47:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jim Lawson <jim+linux-kernel@jimlawson.org>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.0, SiI3112, md raid1 problem: bio too big device (128 > 15)
Message-ID: <20031224104735.GJ1601@suse.de>
References: <Pine.LNX.4.58.0312232253140.7841@infocalypse.jimlawson.org> <3FE91EB8.8020107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE91EB8.8020107@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24 2003, Jeff Garzik wrote:
> Jim Lawson wrote:
> >Hi all,
> >
> >I am having trouble creating a raid1 array under 2.6.0.  I am able to
> >create raid0 and raid5 mds, but raid1s fail with "bio too big device hde3
> >(128 > 15)", which doesn't tell me a lot.  I can see it's in
> >drivers/block/ll_rw_blk.c, right at the boundary with the device driver,
> >but I'm not enough of a kernel wonk to find out a lot more.
> >
> >I'm not sure if this has to do with a kernel bug, a bug in the driver for
> >the controller I have (SiI3112, Silicon Image 3112), or the disks I am
> >using (Seagate Barracuda 7200.7, 160 GB SATA disks) ... or the combination
> >thereof :-)
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

bio splitting _is_ implemented in the block layer, bio_split(). The
restriction is that the bio to be split can only contain one page. The
normal bio buildup makes this easy to guarentee.

We can easily move the actual call to generic_make_request() instead, I
suppose that is what you mean?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319204AbSHTQ4X>; Tue, 20 Aug 2002 12:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319210AbSHTQ4X>; Tue, 20 Aug 2002 12:56:23 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:36767 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S319204AbSHTQ4W>; Tue, 20 Aug 2002 12:56:22 -0400
Date: Tue, 20 Aug 2002 11:00:26 -0600
Message-Id: <200208201700.g7KH0Qr10235@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <Pine.LNX.4.44.0208191121530.28515-100000@serv>
References: <200208190048.g7J0mGW12548@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208191121530.28515-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Sun, 18 Aug 2002, Richard Gooch wrote:
> 
> > > > > In the "devfs=only" case, where is the module count incremented, when a
> > > > > block device is opened?
> >
> > I've already told you about fops_get(). And for a block device, it's
> > def_blk_fops.open().
> 
> Which basically calls block_dev.c:do_open() and the module count
> there is only incremented if get_blkfops() is successfull, which is
> a dummy in this case. So where again is the module count
> incremented?

Which kernel tree are you looking at? I'm looking at 2.4.20-pre4. In
there, I see this code in fs/block_dev:do_open():
	if (!bdev->bd_op)
		bdev->bd_op = get_blkfops(MAJOR(dev));
	if (bdev->bd_op) {
		ret = 0;
		if (bdev->bd_op->owner)
			__MOD_INC_USE_COUNT(bdev->bd_op->owner);
		if (bdev->bd_op->open)
			ret = bdev->bd_op->open(inode, file);
		if (!ret) {
			bdev->bd_openers++;
			bdev->bd_inode->i_size = blkdev_size(dev);
			bdev->bd_inode->i_blkbits = blksize_bits(block_size(dev));
		} else {
			if (bdev->bd_op->owner)
				__MOD_DEC_USE_COUNT(bdev->bd_op->owner);
			if (!bdev->bd_openers)
				bdev->bd_op = NULL;
		}
	}

So if bdev->bd_op has been set (either by devfs_open() or by the
return from get_blkfops()), the module refcount is incremented.

> > I've fixed that in my tree,
> > by using devfs_get_ops(), which safely handles this. I've also added
> > some comments, to make it clearer.
> 
> You never answered my question, why you insist on managing the ops
> pointer. The far easier fix would be to simply remove this nonsense.

Because it's an optimsation, avoiding the need for looking up ops from
tables/lists. It's the sensible way of doing it. I've explained this
to others on the list, and in the FAQ. I'm not going to keep going
over it again and again.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

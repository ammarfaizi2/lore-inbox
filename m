Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbREOPfM>; Tue, 15 May 2001 11:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbREOPfD>; Tue, 15 May 2001 11:35:03 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29195 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262792AbREOPeq>; Tue, 15 May 2001 11:34:46 -0400
Date: Tue, 15 May 2001 08:34:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <15105.5789.377277.276674@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0105150819420.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Neil Brown wrote:
> 
> Ofcourse setting the "queue" function that __blk_get_queue call to do
> a lookup of the minor and choose an appropriate queue for the "real"
> device wont work as you need to munge bh->b_rdev too.

What I would do is:
 - remove b_rdev completely. No driver is actually interested in what the
   device number is, the only thing they want to use it for is to look up
   which device index we have (and for doing the partition handling, but
   as discussed in a completely independent discussion a few months ago,
   we should handle that as a lvm remapping thing, NOT at the driver
   level!)
 - replace is with b_index

Then, the "get_queue" functions basically end up doing the mapping of

	b_dev -> <queue,b_index>

and the LVM remapping would do

	<queue1,b_index1> -> <queue2,b_index2>

instead of what happens now (right now we have:

	/* At request creation time */
	b_rdev = b_dev  (equivalent to <queue,b_index> <- b_dev in get_queue)

	/* at lvm remapping time */
	b_rdev = mapping(b_rdev);

The current reliance on b_rdev is rather confusing, and has resulted in a
ton of bugs exactly because of that.

> You would still nee to make sure the blk_size[], blksize_size[],
> hardsect_size[], max_readahead[], max_sectors[] all got handled
> properly.

Actually, I htink Jens did most of these, and moved them into a device
array.

> Does the minor number for this "disk" layer have N bits for partition
> number and 8-N bits (later to be 20-N bits or similar) for device
> number?

I'd go with N=8, and only use this for the "new" cases, We've seen that
N=4 is too small (SCSI), and N=6 (IDE) is already too cramped with a 8-bit
minor number.

BUT! Note that when you do the partition handling in get_queue too (and
thus index is an index to the _device_ and has nothing to do with
partitions), you can trivially allow different majors to have different
numbers of partition bits, because the driver no longer cares. This is
required so that the get_queue remapping can easily handle the legacy
IDE/SCSI numbers anyway, so it's easyish to just have both at the same
time - you could have N=4 for a "disk major for old users that need the
16-bit device numbers and a single major", with N=8 for the "new style
major" which doesn't fit in 8 bits.

> Finally, how do I say that I want the root filesystem to be on a
> particular "mdp" device+partition.  I cannot assume that my device
> will be the first to register with the "disk" layer, so I cannot be
> sure that "root=/dev/diska1" will work.

You have never been able to really assume that. Disks move around. 

A lot of people seem to think that controller type or location on the PCI
bus should somehow have some "meaning", and that it guarantees that the
disks don't move in the namespace. That's crap. You can do that in user
space ("what controller are you on?") if you really really care.

		Linus


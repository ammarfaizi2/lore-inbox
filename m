Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262953AbREWCf7>; Tue, 22 May 2001 22:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262954AbREWCft>; Tue, 22 May 2001 22:35:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19462 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262953AbREWCfk>; Tue, 22 May 2001 22:35:40 -0400
Date: Tue, 22 May 2001 19:35:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.GSO.4.21.0105221909001.17373-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105221928380.4713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001, Alexander Viro wrote:

> >    which populate the "inode->dev" union pointer, which in turn is _only_
> >    a cache of the lookup. Right now we do this purely based on "dev_t",
> >    and I think that is bogus. We should never pass a "dev_t" around
> >    without an inode, I think.
> 
> I doubt it. First of all, then we'd better make i_rdev dev_t. Right now
> we have it kdev_t and it makes absolutely no sense that way.

Absolutely.

In fact, the whole "kdev_t" makes no sense if we have proper char_dev and
block_dev pointers.

We have "dev_t" which is what we export to user space. And if we split up
char dev and block dev (which I'm an avid proponent for), kdev_t will be
an anachronism.

> The real thing is inode->dev. Notice that for devfs (and per-device
> filesystems) we can set it upon inode creation, since they _know_ it
> from the very beginning and there is absolutely no reason to do any
> hash lookups. Moreover, in these cases we may have no meaningful device
> number at all.

Sure. If something like devfs _knows_ the device pointers from the very
beginning, then just do: 
 - increment reference count
 - inode->dev.char = cdev;

> >    Block devices will have the "request queue" pointer, and the size and
> >    partitioning information. Character devices currently would not have
> 
> Do we really want a separate queue for each partition?

No. 

But the pointer is not a 1:1 thing (otherwise we'd just put the whole
request queue _into_ the block device).

The block device should have a pointer to the request queue, along with
the partitioning information. Why? Because that way it becomes very simple
indeed to do request processing: none of the current "look up the proper
queue for each request and do the partition offset magic inside each
driver". Instead, the queuing function becomes:

	bh->index = bdev->index;
	bh->sector += bdev->sector_offset;
	submit_bh(bh, bdev->request_queue);

and you're done. Those three lines did both the queue lookup, the
"index" for the driver, and the partitioning offset. Whoa, nelly.

And THAT is why you want to have the queue pointer in the bdev structure.

		Linus


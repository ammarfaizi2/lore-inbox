Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136308AbRD1BWB>; Fri, 27 Apr 2001 21:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136309AbRD1BVv>; Fri, 27 Apr 2001 21:21:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52639 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136308AbRD1BVm>;
	Fri, 27 Apr 2001 21:21:42 -0400
Date: Fri, 27 Apr 2001 21:21:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.LNX.4.21.0104271813150.970-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104272117440.21109-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Linus Torvalds wrote:

> On Fri, 27 Apr 2001, Alexander Viro wrote:
> >
> > Each of these places is an oopsable race with umount. We can't fix them
> > without touching a lot of drivers. However, we can make the future fix
> > easier if we put the above into a helper function. Patch below does that.
> 
> I don't like the name "ream_inodes()".
> 
> Also, a driver shouldn't know about "inodes" and "buffers". It should just
> do something like
> 
> 	invalidate_device(dev);
> 
> because the only thing the driver knows about is the _device_.
> 
> Then, invalidate_device() might do 
> 
> 	sb = get_super(dev)
> 	if (sb)
> 		invalidate_inodes (sb);
> 	invalidate_buffers(dev);
> 
> which makes some amount of sense. And which can later be extended to deal
> with the page cache etc without the drivers ever knowing or caring.

Fine with me. Actually in _all_ cases execept cdrom.c it's preceded by
either sync_dev() or fsync_dev(). What do you think about pulling that
into the same function? Actually, that's what I've done in namespace
patch (name being invalidate_dev(), BTW ;-) The only problem I see
here is the argument telling whether we want sync or fsync (or nothing).
OTOH, I seriously suspect that we ought replace all sync_dev() cases
with fsync_dev() anyway... Your opinion?
								Al


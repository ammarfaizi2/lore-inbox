Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318811AbSIITg1>; Mon, 9 Sep 2002 15:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSIITg1>; Mon, 9 Sep 2002 15:36:27 -0400
Received: from packet.digeo.com ([12.110.80.53]:19918 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318811AbSIITgY>;
	Mon, 9 Sep 2002 15:36:24 -0400
Message-ID: <3D7CF93A.972FCC8D@digeo.com>
Date: Mon, 09 Sep 2002 12:40:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Jesse Barnes <jbarnes@sgi.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Imran Badr <imran.badr@cavium.com>,
       "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com> <20020909181355.GA1510567@sgi.com> <E17oTES-0006qj-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 19:40:57.0852 (UTC) FILETIME=[D1A5EBC0:01C25838]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 09 September 2002 20:13, Jesse Barnes wrote:
> > On Mon, Sep 09, 2002 at 02:00:35PM -0400, Richard B. Johnson wrote:
> > > Well I just read Documentation/DMA-mapping.txt as advised by David
> > > and it seems as though it will no longer be possible to do what
> > > many programmers have been wanting to do, to wit:
> > >
> > > (1) In user-code, allocate a buffer.
> > > (2) Lock that buffer into memory.
> > > (3) Call some driver that DMAs data to/from that buffer.
> >
> > It looks drivers/media/video/video-buf.c uses alloc_kiovec() and
> > map_user_kiobuf() to do it.  And I think Ben LaHaise was talking about
> > removing these functions and creating some other, lightweight
> > interface for the same purpose?
> 
> Hopefully.  My understanding is that kio is obsoleted by bio and aio,
> anyone want to confirm/deny this?

Mumble, mutter, dunno.

There are two sides to kiobufs: they can be used as a front-end to get_user_pages (video-buf.c, Imran's application and at least one
proprietary mpeg streaming driver of which I am aware).  And they
can be used as a container for direct IO to a block device (mtdblk.c
and LVM1).

Nobody seems to have come forth to implement a thought-out scatter/gather,
map-user-pages library infrastructure so I'd be a bit reluctant to
break stuff without offering a replacement.

We need a general-purpose "read or write these pages to this blockdev"
library function.  For mtdblk, LVM1/LVM2 and probably swapper_space.
With that we can remove the block IO stuff from kiovecs.  And convert
the other drivers to use get_user_pages() directly into an ad-hoc private
page array.  Those things would allow kiovecs/kiobufs to be retired.

I guess we need to get more motivated about this, before some large
piece of infrastructure (EVMS/LVM2) lands in the tree using ll_rw_kiovec.

This:

generic_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
        loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)

is getting close to what we need.  But it is synchronous, and too
heavyweight for swap I/O.

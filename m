Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268849AbRHBIMn>; Thu, 2 Aug 2001 04:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268848AbRHBIMe>; Thu, 2 Aug 2001 04:12:34 -0400
Received: from zok.SGI.COM ([204.94.215.101]:934 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268849AbRHBIMX>;
	Thu, 2 Aug 2001 04:12:23 -0400
Date: Thu, 2 Aug 2001 01:10:44 -0700 (PDT)
From: jeremy@classic.engr.sgi.com (Jeremy Higdon)
Message-Id: <10108020110.ZM232959@classic.engr.sgi.com>
In-Reply-To: Andrea Arcangeli <andrea@suse.de>
        "Re: changes to kiobuf support in 2.4.(?)4" (Aug  2,  9:45am)
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> 
	<20010802084259.H29065@athlon.random>  <andrea@suse.de> 
	<10108020031.ZM229058@classic.engr.sgi.com> 
	<20010802094517.I29065@athlon.random>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: changes to kiobuf support in 2.4.(?)4
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 2,  9:45am, Andrea Arcangeli wrote:
> 
> > I am doing direct I/O.  I'm using the kiobuf to hold the page addresses
> > of the user's data buffer, but I'm calling directly into my driver
> > after doing the map_user_kiobuf() (I have a read/write request, a file
> > offset, a byte count, and a set of pages to DMA into/out of, and that
> > gets directly translated into a SCSI command).
> > 
> > It turns out that the old kmem_cache_alloc was very lightweight, so I
> > could get away with doing it once per I/O request, so I would indeed
> > profit by going back to a light weight kiobuf, or at least an optional
> > allocation of the bh and blocks arrays (perhaps turn them into pointers
> > to arrays?).
> 
> I see your problem and it's a valid point indeed. But could you actually
> allocate the kiobuf in the file->f_iobuf pointer? I mean: could you
> allocate it at open/close too?  That would be the way I prefer since you
> would need to allocate the bh anyways later (but with a flood of
> alloc/free). So if you could move the kiobufs allocation out of the fast
> path you would get a benefit too I believe.

I have two answers to this.

The first is that I don't need the bh's or block's in my implementation.
Everything I need is in the old-style kiobuf or is passed as an argument.

The second is I don't see a file->f_iobuf pointer in my source tree, which
is 2.4.8-pre3, I believe.  In fact, the kiobuf pointer is stored in the
raw_devices array in my version of raw.c, and there is only one per raw
device.

Assuming I'm out of date, and there is some way to store a kiobuf pointer
into the file data structure, and I'll never see two requests outstanding
at the same time to the same file, then I could do as you suggest.  I'd
be wasting about 16KB per open file (assuming 512KB and 64 bit) and adding
unneeded CPU overhead at open time, but I could live with that.

> Andrea

thanks

jeremy

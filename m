Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbRE1WQ0>; Mon, 28 May 2001 18:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263185AbRE1WQQ>; Mon, 28 May 2001 18:16:16 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:27908 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263182AbRE1WP6>; Mon, 28 May 2001 18:15:58 -0400
Date: Mon, 28 May 2001 15:15:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
In-Reply-To: <20010528223733.O9102@suse.de>
Message-ID: <Pine.LNX.4.10.10105281501100.366-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001, Jens Axboe wrote:

> On Mon, May 28 2001, Mark Hahn wrote:
> > > request, when we hit a dma timout. In this case, what we really want to
> > > do is retry the request in pio mode and revert to normal dma operations
> > > later again.
> > 
> > really?  do we know the nature of the DMA engine problem well enough?
> > is there a reason to believe that it'll work better "later"?
> > I guess I was surprised at resorting to PIO - couldn't we just
> > break the request up into smaller chunks, still using DMA?
> 
> That is indeed possible, it will require some surgery to the dma request
> path though. IDE has no concept of doing part of a request for dma
> currently, it's an all-or-nothing approach. That's why it falls back to
> pio right now.
> 
> > I seem to recall Andre saying that the problem arises when the 
> > ide DMA engine looses PCI arbitration during a burst.  shorter 
> > bursts would seem like the best workaround if this is the problem...
> 
> It's worth a shot. My patch was not meant as the end-all solution,
> however we need something _now_. Loosing sectors is not funny.
> Dynamically limiting general request size for to make dma work is a
> piece of cake, that'll be about a one-liner addition to the current
> patch. So the logic could be something of the order of:
> 
> 	- 1st dma timeout
> 	- scale max size down from 128kB (127.5kB really) to half that
> 	...
> 	- things aren't working, 2nd dma timeout. Scale down to 32kB.
> 
> and so forth, revert to pio and reset full size if it's really no good.
> If limiting transfer sizes solves the problem, this would be the way to
> go. I'll do another version that does this.
> 
> Testers? Who has frequent ide dma timeout problems??
> 
> > resorting to PIO would be such a shame, not only because it eats
> > CPU so badly, but also because it has no checksum like UDMA...
> 
> Look at the patch -- we resort to pio for _one_ hunk. That's 8 sectors
> tops, then back to dma. Hardly a big issue.

Unless we reissue the entire request from scratch you have no idea what if
anything is on the platters.  Since one can generally only get control
over the device with a soft reset, you have to assume that anything and
everything about that request was lost at the device level and begin
again.

<RANT>
This is why it is so important to change to TFAM, because we carry a copy
of the setup-seek operations with the request, and not unless we error out
do we change that content.  Thus is a timeout fault not a error case we
have all the info to re-issue or copy into a retry queue.  But as we all
know the proper fix can not be even attempted until 2.5...
</RANT>

One thing that I have been trying is to pop the local ISR at a timeout and
that looks to handle much if the problem; however, I need to reassemble my
one test box that I can reproduce the fault 100% of the time.

As I recall, there is a way to reinsert the faulted request, but that
means the request_struct needs fault counter.  If it is truly a DMA error
because of re-seeks then the timeout value for that request must be
expanded.

Now the final issue could be that the value of the calculated get-out
timer may be to short for other reason and the driver is jumping the gun
to notify and recover.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com


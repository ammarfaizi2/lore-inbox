Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbRE1UlV>; Mon, 28 May 2001 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbRE1UlB>; Mon, 28 May 2001 16:41:01 -0400
Received: from [195.184.98.160] ([195.184.98.160]:38406 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263142AbRE1Uk6>;
	Mon, 28 May 2001 16:40:58 -0400
Date: Mon, 28 May 2001 22:37:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: andre@linux-ide.org, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
Message-ID: <20010528223733.O9102@suse.de>
In-Reply-To: <20010528203421.N9102@suse.de> <Pine.LNX.4.10.10105281533400.25183-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10105281533400.25183-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Mon, May 28, 2001 at 03:39:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28 2001, Mark Hahn wrote:
> > request, when we hit a dma timout. In this case, what we really want to
> > do is retry the request in pio mode and revert to normal dma operations
> > later again.
> 
> really?  do we know the nature of the DMA engine problem well enough?
> is there a reason to believe that it'll work better "later"?
> I guess I was surprised at resorting to PIO - couldn't we just
> break the request up into smaller chunks, still using DMA?

That is indeed possible, it will require some surgery to the dma request
path though. IDE has no concept of doing part of a request for dma
currently, it's an all-or-nothing approach. That's why it falls back to
pio right now.

> I seem to recall Andre saying that the problem arises when the 
> ide DMA engine looses PCI arbitration during a burst.  shorter 
> bursts would seem like the best workaround if this is the problem...

It's worth a shot. My patch was not meant as the end-all solution,
however we need something _now_. Loosing sectors is not funny.
Dynamically limiting general request size for to make dma work is a
piece of cake, that'll be about a one-liner addition to the current
patch. So the logic could be something of the order of:

	- 1st dma timeout
	- scale max size down from 128kB (127.5kB really) to half that
	...
	- things aren't working, 2nd dma timeout. Scale down to 32kB.

and so forth, revert to pio and reset full size if it's really no good.
If limiting transfer sizes solves the problem, this would be the way to
go. I'll do another version that does this.

Testers? Who has frequent ide dma timeout problems??

> resorting to PIO would be such a shame, not only because it eats
> CPU so badly, but also because it has no checksum like UDMA...

Look at the patch -- we resort to pio for _one_ hunk. That's 8 sectors
tops, then back to dma. Hardly a big issue.

-- 
Jens Axboe


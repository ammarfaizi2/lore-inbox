Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTEMT5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTEMT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:57:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46857 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263186AbTEMT5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:57:46 -0400
Date: Tue, 13 May 2003 16:04:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Oleg Drokin <green@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Mudama, Eric" <eric_mudama@maxtor.com>
cc: "'Jens Axboe'" <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69, IDE TCQ can't be enabled
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.3.96.1030513154829.18019A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Oleg Drokin wrote:

> How do you think people will test code that is removed?

The people most likely to fix it know there's a problem, why leave it
around to corrupt filesystems? Leave the code if Jens thinks he will get
to it before 2.6, but comment out the option until he does.

> Or do you mean that nobody plans to look at this ever?

Jens plans to, but there are other things on his plate.

> I remember that Jens Axboe promised to take a look at it some
> months ago.


On Mon, 12 May 2003, Jeff Garzik wrote:

> On Mon, May 12, 2003 at 11:58:10AM -0600, Mudama, Eric wrote:
> > The only difference between SATA TCQ and PATA TCQ is that in PATA TCQ, the
> > drive doesn't report the active tag bitmap back to the host after each
> > command.  Other than that they are functionally identical to my
> > understanding.  (Yes, there are options like first-party DMA, but these are
> > not requirements)
> 
> That's from the "drive side."  From the OS side, the ideal
> implementation isn't here yet :)
> 
> Ideally there is a DMA ring of taskfiles and scatterlists.  The OS
> (producer) queues these up asynchrously, and the host+devices
> (consumer) executes the taskfiles in the ring.  AHCI does this.
> 
> With PATA TCQ, we only have a single scatterlist, and are forced to
> have more OS-side infrastructure for command queueing, processing, etc.
> 
> As an aside, as drives and hosts get faster, we will actually want
> _fewer_ interrupts (i.e. interrupt coalescing).
> 
> All this points to making the host smarter.
> The drives are already pretty damn smart ;-)

Unfortunately it depends on the drive actually working if it claims to
support the feature. That seems to be a problem.


On Mon, 12 May 2003, Mudama, Eric wrote:

> TCQ shouldn't benefit writes significantly from a performance perspective if
> the drive is reasonably smart.  TCQ *will* have a huge performance
> improvement for random reads since the drive can order responses based on
> minimal rotational latency.
> 
> Increasing queue depth reduces the average seek time between commands, both
> in distance and rotational latency.  Provided a drive doesn't do dumb stuff
> like we discussed earlier, then it should be good.

One problem which seems probable is that the drive knows less about the
system than the o/s (I hope!) and therefore it can only optimize the order
of i/o for most i/o in the shortest time. It would seem that the deadline
scheduler benefits from doing not the quickest thing but the correct thing
in terms of ordering. I believe that once the i/o is queued (assuming the
drive works right) the drive makes the decision about i/o order. That may
be the wrong thing to do under load, and starve some processes.

There was discussion recently about limiting the requests with SCSI, for
just this reason.

Unless there's a *lot* of gain from doing TCQ, perhaps this should either
wait, be dropped, or only be enabled for a whitelist of known actually
functional drives. Seems like a poor risk to benefit ratio if it doesn't
work just right, and perhaps this should go on the "it seemed like a good
idea at the time" pile. There's nothing the code can do to guard against
bad drive firmware except not use it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


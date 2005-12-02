Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVLBWHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVLBWHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVLBWHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:07:24 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:54440 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750799AbVLBWHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:07:23 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] MTD/SPI dataflash driver
Date: Fri, 2 Dec 2005 14:07:18 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <200512011033.41627.david-b@pacbell.net> <438FE350.1010106@ru.mvista.com>
In-Reply-To: <438FE350.1010106@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200512021407.18816.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, it would be nice if someone compared the performance of both 
> variants.

> >     * original code could be implemented in a single DMA chain on
> >      at least two systems I happen to have handy ... one IRQ.
> >
> >    * this version requires two separate chains, with an intervening
> >      task schedule.  (More than twice the cost.)

They differ by at least the cost of an extra IRQ and task schedule, so
the performance delta would be load-dependant.  In a real-time setup
where that task was given time slices at fixed intervals, that might
mean the two-request version takes twice as long.  ;)



> Whoops. Lemme express my thoughts here.
> First, the DMA controller that can handle chained requests which are 
> working with different devices (i.e. write then read does that - first 
> mem2per, then per2mem) are *very* rare thing.

The way they usually work is allocate two DMA channels to the device,
one for read and one for write.  The controllers just makes sure there's
one byte read for every one written, and the DMA channels just stream
along with them.  (Possibly one channel talks to a bitbucket.)

AT91, OMAP, and PXA hardware all claim hardware support sufficient to
do that.  (Errata aside.)  That's not even rare hardware, much less
"very rare"; they're stocked at DigiKey, ready to throw into boards.


> > - Chipselect works differently in your code.  You're giving one
> >   driver control over all the devices sharing a controller, by
> >   blocking requests going to other devices until your driver yields
> >   the chipselect.  
> >  
> >
> The controllers we were working with are _not_ able to handle 
> simultaneous requests to different devices on the same bus.

Of course not; SPI doesn't work that way.  But my point was that your
changes show a controller driver that's clearly required to "lock" the
bus, through that chipselect, between requests ... which is not only
antithetical to the "requests are asynchronous" model that had earlier
been agreed on, but also creates problems of its own:

> >  		This seems like a bad idea even if you ignore
> > how it produces priority inversions in your framework.  :)

So consider two different tasks accessing devices on the same SPI bus.

One is lower priority, currently waiting for an SPI request to complete.
A request that has your magic "leave me owning chipselect/bus after
this request flag" ... because the first thing it's going to do when
it returns is start another transfer.  (And in the case of the MTD driver,
that transfer could already have been queued, removing the issue as
well as the need for that flag.)

Now the high priority task issues a request to the other device on
that same SPI bus.  This means that *two* other tasks ought to be
temporarily operating with that higher priority:  whatever task
you've allocated to manage the I/O queue on that bus (plus maybe
an IRQ task with RT_PREEMPT); and the task that's waiting for that
transfer to complete.  Inversions ... 

- Dave

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbRE2AJv>; Mon, 28 May 2001 20:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbRE2AJm>; Mon, 28 May 2001 20:09:42 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:1028 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261837AbRE2AJX>; Mon, 28 May 2001 20:09:23 -0400
Date: Mon, 28 May 2001 17:09:20 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@kernel.org>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
In-Reply-To: <20010529002600.B26871@suse.de>
Message-ID: <Pine.LNX.4.10.10105281701070.414-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, Jens Axboe wrote:

> This is bull shit. If IDE didn't muck around with the request so much in
> the first place, the info could always be trusted. Even so, we have the
> hard_* numbers to go by. So this argument does not hold.

Maybe if you looked at the new code model as a whole you would see that
the request-forking is gone.  The object is to preserve a copy of the io
instructions out to the registers to not have to repeat the do_request
call unless it is a do or die thing.  Also it is good to carry a copy of
the local request even if it is never used.  Also are you resetting the
pointer (back to the geginning) on rq->buffer on the retry?

You first flush the DMA engine and issue a device soft reset not using the
current drive reset, is presevers the hwgroup->busy state and allows the
request to be retried without reinserting.

> > As I recall, there is a way to reinsert the faulted request, but that
> 
> Again, look at the patch. The request is never off the list, so there is
> never a reason to reinsert. hwgroup->busy is cleared (and, again for
> good measure, hwgroup->rq), so ide_do_request/start_request will get the
> same request that we just handled.

I will have to poke in a few flags to verify this but if you say so.

> > means the request_struct needs fault counter.  If it is truly a DMA error
> 
> ->errors, it's already there.

Wrong location to poke and by that time it requires a full retry.
The new code would have had the task structs filled with the error.

> > because of re-seeks then the timeout value for that request must be
> > expanded.
> 
> Yep

In some cases yes, but it would be better if I had a standard counter that
meant something.  Also changing the jiffie counter in ide_delay_50ms to a
mdelay may have done more harm than good.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbRE2AbE>; Mon, 28 May 2001 20:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261902AbRE2Aat>; Mon, 28 May 2001 20:30:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261898AbRE2Aab>;
	Mon, 28 May 2001 20:30:31 -0400
Date: Tue, 29 May 2001 02:30:29 +0200
From: Jens Axboe <axboe@kernel.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
Message-ID: <20010529023029.G26871@suse.de>
In-Reply-To: <20010529002600.B26871@suse.de> <Pine.LNX.4.10.10105281701070.414-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10105281701070.414-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, May 28, 2001 at 05:09:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28 2001, Andre Hedrick wrote:
> On Tue, 29 May 2001, Jens Axboe wrote:
> 
> > This is bull shit. If IDE didn't muck around with the request so much in
> > the first place, the info could always be trusted. Even so, we have the
> > hard_* numbers to go by. So this argument does not hold.
> 
> Maybe if you looked at the new code model as a whole you would see that
> the request-forking is gone.  The object is to preserve a copy of the io

There's only a 'fork' (I'm assuming you mean copy?) for the pio
multwrite path, which I don't consider a big issue. I'm not saying that
TFAM is not needed, I'm saying don't go touting that as the big saviour
when it really has no relation to this topic at all.

> instructions out to the registers to not have to repeat the do_request
> call unless it is a do or die thing.  Also it is good to carry a copy of
> the local request even if it is never used.  Also are you resetting the

Retry is by no means a performance thing, and I would indeed prefer to
just pretend this is a brand new request rather than count on anything
being in a sane state.

> pointer (back to the geginning) on rq->buffer on the retry?

Of course

> You first flush the DMA engine and issue a device soft reset not using the
> current drive reset, is presevers the hwgroup->busy state and allows the
> request to be retried without reinserting.

Again, _there is no reinsertion_. And why would we want to preserve
hwgroup->busy? In fact, we need to clear it at all times to start the
request over sanely.

> > > As I recall, there is a way to reinsert the faulted request, but that
> > 
> > Again, look at the patch. The request is never off the list, so there is
> > never a reason to reinsert. hwgroup->busy is cleared (and, again for
> > good measure, hwgroup->rq), so ide_do_request/start_request will get the
> > same request that we just handled.
> 
> I will have to poke in a few flags to verify this but if you say so.

Ok, this is how it goes: a queue list is build of requests. IDE grabs
the very first request on the list, the path:

ide_do_request:
	hwgroup->rq = blkdev_entry_next_request(&drive->queue.queue_head)

start_request:
	struct request *rq = blkdev_entry_next_request(&drive->queue.queue_head)

There is no deletion going on. Request is started, runs, and is done. At
this point the low level driver calls ide_end_request:

ide_end_request:
	if (last_part_of_request) {
		blkdev_dequeue_request(rq);
		hwgroup->rq = NULL;
		...
	}

_here_ we take the request off the list, and we better be completely
done with it at this point. So as long as the request is not ended
completely, it will always be the at the head of the pending queue.

> > > means the request_struct needs fault counter.  If it is truly a DMA error
> > 
> > ->errors, it's already there.
> 
> Wrong location to poke and by that time it requires a full retry.
> The new code would have had the task structs filled with the error.

->errors is just meant as a simple counter, so you can do stuff like

	if (io_error)
		if (rq->errors++ > ERROR_MAX)
			/* uh oh */

if you need more than this, then yes a dedicated 'ide command' pointer
is what we want. You would need that for queueing anyway.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264074AbSIQMYf>; Tue, 17 Sep 2002 08:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264078AbSIQMYf>; Tue, 17 Sep 2002 08:24:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38072 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264074AbSIQMYe>;
	Tue, 17 Sep 2002 08:24:34 -0400
Date: Tue, 17 Sep 2002 14:29:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: tagged block requests
Message-ID: <20020917122911.GW3289@suse.de>
References: <20020917055440.GG3289@suse.de> <Pine.LNX.4.10.10209170052140.11597-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209170052140.11597-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17 2002, Andre Hedrick wrote:
> 
> Jens,
> 
> Help me out on this new idea of shoving tag management into BLOCK and away
> from the local device.  If I understand the process observed, one has to
> dequeue the request from block and move it to a new listhead?  If so why
> do we not stuff the real queuehead with a bogus place holder?  What I am
> driving to specifically, why must the request be dequeued and not just
> marked as inproccess and left on the queuehead?

blk_queue_start_tag() will dequeue the request itself, so in fact it
must not be done prior to calling it. I think I'll change
blkdev_dequeue_request() to a list_del_init() though, so this wont hurt.

I see no point in leaving the request on the dispatch queue, and lots of
problems. For one, then you would have to maintain two lists which would
further increase size of struct request. You would have to complicate
elv_next_request() to skip request that have been tagged, instead of
just extracting the first one.

> If for some reason our device tanks and requires a reset or for some
> unknown reason one needs to blast through the device and hit platter, we
> end up frying all the data and requests with active tags in the device.
> 
> Thus one needs to invalidate the new-second listhead of requests moved off
> the queuehead and find a way to stuff them back in the device queue.  Now
> if the device->queue is full, here is where I see us getting beat up.

This is the typical error case for devices using queueing, that the
hardware queue is invalidated by the device and the software queue must
be invalidated by the device driver. blk_queue_invalidate_tags() does
this for you, and even preserves order of request.

I don't understand by device->queue. If you mean the hardware device
queue, that doesn't matter. The requests are now again safe and valid on
the block dispatch queue and will be served to the driver as if nothing
ever happened. The software device queue can never be full.

> We have to nuke requests in the queue or nuke the ones we are trying to
> remerge.  I have a real concern about this after tearing appart the
> scsi-mid-layer and becoming ill.  There are parts where the HBA marks the
> hba->queue full and commands still arrive and are not blocked or the queue
> is not unplugged or something.  Thus seeing the cdb formation hitting
> SCpnt->special and jumping the queue.

I think you'll need to explain this bug some more, please detail in code
where you are seeing stuff go wrong.

> My question surrounds why remove the requests from the device->queue?
> If we leave them on then if the device goes south and pees on itself, one
> just clears the req->command_is_queued (may not exist yet) and req->tag
> (may not exist yet).

See my first paragraph on why this is a bad idea. The design is much
better with busy requests being on a separate queue, code is cleaner,
data structures slightly slimmer. Where are you seeing the
disadvantage??

> If this is possible then we may be able to mark a series of requests a
> ordered and strenghten the barrier operations, regardless if FUA is set in
> SCSI or IDE (future opcode and messy!).  This would require a group index
> marker w/ associated ordering list, but this may be present already.

It's currently not possible to group requests, marking them as dependent
on each other.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263881AbSIQIHR>; Tue, 17 Sep 2002 04:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263883AbSIQIHR>; Tue, 17 Sep 2002 04:07:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20484
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263881AbSIQIHP>; Tue, 17 Sep 2002 04:07:15 -0400
Date: Tue, 17 Sep 2002 01:09:32 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: tagged block requests
In-Reply-To: <20020917055440.GG3289@suse.de>
Message-ID: <Pine.LNX.4.10.10209170052140.11597-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

Help me out on this new idea of shoving tag management into BLOCK and away
from the local device.  If I understand the process observed, one has to
dequeue the request from block and move it to a new listhead?  If so why
do we not stuff the real queuehead with a bogus place holder?  What I am
driving to specifically, why must the request be dequeued and not just
marked as inproccess and left on the queuehead?

If for some reason our device tanks and requires a reset or for some
unknown reason one needs to blast through the device and hit platter, we
end up frying all the data and requests with active tags in the device.

Thus one needs to invalidate the new-second listhead of requests moved off
the queuehead and find a way to stuff them back in the device queue.  Now
if the device->queue is full, here is where I see us getting beat up.

We have to nuke requests in the queue or nuke the ones we are trying to
remerge.  I have a real concern about this after tearing appart the
scsi-mid-layer and becoming ill.  There are parts where the HBA marks the
hba->queue full and commands still arrive and are not blocked or the queue
is not unplugged or something.  Thus seeing the cdb formation hitting
SCpnt->special and jumping the queue.

My question surrounds why remove the requests from the device->queue?
If we leave them on then if the device goes south and pees on itself, one
just clears the req->command_is_queued (may not exist yet) and req->tag
(may not exist yet).

If this is possible then we may be able to mark a series of requests a
ordered and strenghten the barrier operations, regardless if FUA is set in
SCSI or IDE (future opcode and messy!).  This would require a group index
marker w/ associated ordering list, but this may be present already.

Sorry for being block stupid in 2.5 still.



On Tue, 17 Sep 2002, Jens Axboe wrote:

> On Tue, Sep 17 2002, Peter T. Breuer wrote:
> > Can someone point me to some documentation or an example
> > or give me a quick rundown on how I should use the new
> > tagged block request structure in 2.5.3x?
> > 
> > It looks like something I want. I've already tried issuing
> > "special" requests as (re)ordering barriers, and that works 
> > fine. How does the tag request interface fit in with that,
> > if it does?
> 
> The request tagging is used for hardware that can have multiple commands
> in flight at any point in time. To do this, we need some sort of cookie
> to differentiate between the different commands. For SCSI and IDE, we
> use integer tags to do so. An example:
> 
> my_request_fn(q)
> {
> 	struct request *rq;
> 
> next:
> 	rq = elv_next_request(q);
> 	if (!rq)
> 		return;
> 
> 	/*
> 	 * assuming some tags are already in flight, ending those will
> 	 * restart queue handling
> 	 */
> 	if (blk_queue_start_tag(q, rq))
> 		return;
> 
> 	/*
> 	 * now rq is tagged, rq->tag contains the integer identifier
> 	 * for this request
> 	 */
> 	dma_map_command();
> 	send_command_to_hw();
> 	goto next;
> }
> 
> So request_fn calls blk_queue_start_tag(), which associates rq with a
> free tag, if available. Then the hardware completes the request:
> 
> my_isr(..., devid, ...)
> {
> 	struct my_dev *dev = devid;
> 	struct request *rq;
> 	int stat, tag;
> 
> 	stat = read_device_stat(dev);
> 
> 	/* tag is upper 5 bits */
> 	tag = (stat >> 3);
> 
> 	rq = blk_queue_find_tag(q, tag);
> 
> 	if (stat & DEVICE_GOOD_STAT) {
> 		blk_queue_end_tag(q, rq);
> 		complete_request(rq, 1);
> 	} else {
> 		blk_queue_invalidate_tags(q);
> 		lock_queue;
> 		my_request_fn(&dev->queue);
> 		unlock_queue;
> 	}
> }
> 
> Tag is either completed normally (blk_queue_end_tag()) for good status,
> and is ended. Or for bad status, we invalidate the entire pending tag
> queue because this particular piece of hardware requires us to do so.
> This makes sure that requests gets moved from the tag queue to the
> dispatch queue for the device again, so request_fn() gets a chance to
> start them over.
> 
> That's basically the API. In addition to the above,
> blk_queue_init_tags(q, depth) sets up a queue for tagged operation and
> blk_queue_free_tags(q) tears it down again.
> 
> Now how that fits in with whatever you are trying to do (which
> apparently isn't tagging in the ordinary sense), I have no idea. But now
> you should now what the interface does.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group


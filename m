Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263634AbSIQFtu>; Tue, 17 Sep 2002 01:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263649AbSIQFtu>; Tue, 17 Sep 2002 01:49:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59628 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263634AbSIQFtt>;
	Tue, 17 Sep 2002 01:49:49 -0400
Date: Tue, 17 Sep 2002 07:54:40 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: tagged block requests
Message-ID: <20020917055440.GG3289@suse.de>
References: <200209162234.g8GMY2825694@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209162234.g8GMY2825694@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17 2002, Peter T. Breuer wrote:
> Can someone point me to some documentation or an example
> or give me a quick rundown on how I should use the new
> tagged block request structure in 2.5.3x?
> 
> It looks like something I want. I've already tried issuing
> "special" requests as (re)ordering barriers, and that works 
> fine. How does the tag request interface fit in with that,
> if it does?

The request tagging is used for hardware that can have multiple commands
in flight at any point in time. To do this, we need some sort of cookie
to differentiate between the different commands. For SCSI and IDE, we
use integer tags to do so. An example:

my_request_fn(q)
{
	struct request *rq;

next:
	rq = elv_next_request(q);
	if (!rq)
		return;

	/*
	 * assuming some tags are already in flight, ending those will
	 * restart queue handling
	 */
	if (blk_queue_start_tag(q, rq))
		return;

	/*
	 * now rq is tagged, rq->tag contains the integer identifier
	 * for this request
	 */
	dma_map_command();
	send_command_to_hw();
	goto next;
}

So request_fn calls blk_queue_start_tag(), which associates rq with a
free tag, if available. Then the hardware completes the request:

my_isr(..., devid, ...)
{
	struct my_dev *dev = devid;
	struct request *rq;
	int stat, tag;

	stat = read_device_stat(dev);

	/* tag is upper 5 bits */
	tag = (stat >> 3);

	rq = blk_queue_find_tag(q, tag);

	if (stat & DEVICE_GOOD_STAT) {
		blk_queue_end_tag(q, rq);
		complete_request(rq, 1);
	} else {
		blk_queue_invalidate_tags(q);
		lock_queue;
		my_request_fn(&dev->queue);
		unlock_queue;
	}
}

Tag is either completed normally (blk_queue_end_tag()) for good status,
and is ended. Or for bad status, we invalidate the entire pending tag
queue because this particular piece of hardware requires us to do so.
This makes sure that requests gets moved from the tag queue to the
dispatch queue for the device again, so request_fn() gets a chance to
start them over.

That's basically the API. In addition to the above,
blk_queue_init_tags(q, depth) sets up a queue for tagged operation and
blk_queue_free_tags(q) tears it down again.

Now how that fits in with whatever you are trying to do (which
apparently isn't tagging in the ordinary sense), I have no idea. But now
you should now what the interface does.

-- 
Jens Axboe


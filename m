Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSFFFbo>; Thu, 6 Jun 2002 01:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSFFFbn>; Thu, 6 Jun 2002 01:31:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38053 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316589AbSFFFbm>;
	Thu, 6 Jun 2002 01:31:42 -0400
Date: Thu, 6 Jun 2002 07:31:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020606053123.GN16600@suse.de>
In-Reply-To: <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <15613.26250.675556.878683@notabene.cse.unsw.edu.au> <20020605101315.GY1105@suse.de> <15614.53205.986092.882909@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06 2002, Neil Brown wrote:
> > > In ll_rw_blk.c we change blk_plug_device to avoid the check for
> > > the queue being empty as this may not be well define for
> > > umem/raid5.  Instead, blk_plug_device is not called when
> > > the queue is not empty (which is mostly wasn' anyway).
> > 
> > I left it that way on purpose, and yes I did see you changed that in the
> > previous patch as well. I think it's a bit of a mess to have both
> > blk_plug_device and blk_plug_queue. Without looking at it, I have no
> > idea which does what?! blk_queue_empty() will always be true for
> > make_request_fn type drivers, so no change is necessary there.
> 
> I'm not pushing the blk_plug_device vs blk_plug_queue distinction.
> 
> It is just that I think the current blk_plug_device is wrong...  let
> me try to show you why..
> 
> First, look where it is called, in __make_request (which I always
> thought should be spelt "elevator_make_request") - note that this is
> the ONLY place that it is called other than the calls that have just
> been introduced in md and umem - :
> 
> 
> 	if (blk_queue_empty(q) || bio_barrier(bio)) {
> 		blk_plug_device(q);
> 		goto get_rq;
> 	}
> 
> Which says "if the queue is empty or this is a barrier bio, then
> plug the queue and go an make a request, skipping the merging".
> 
> One then wonders why you would want to plug the queue for a barrier
> bio.  The queue-empty bit makes sense, but not the barrier bit...

No for the barrier bit we need not do the plugging, we just need to skip
the merge step and go directly to grabbing a new request. However if the
queue is indeed empty, then we do need to plug it. See?

> Ok, lets see exactly what blk_plug_device(q) does by (mentally)
> inlining it:
> 
> 	if (blk_queue_empty(q) || bio_barrier(bio)) {
> 
> 		if (!elv_queue_empty(q))
> 			goto return;
> 
> 			if (!blk_queue_plugged(q)) {
> 				spin_lock(&blk_plug_lock);
> 				list_add_tail(&q->plug_list, &blk_plug_list);
> 				spin_unlock(&blk_plug_lock);
> 			}
> 	return:
> 		goto get_rq;
> 	}
> 
> So we are actually plugging it if it isn't already plugged (makes
> sense) and elv_queue_empty, and blk_queue_empty ... or bio_barrier.
> I wander what those two differnt *_queue_empty functions are .....
> looks in blkdev.h.. Oh, they are the same.

Oh agreed, I'll get rid of one of them.

> So we can simplify this a bit:
> 
> 	If (the_queue_is_empty(q)) {
> 		plug_if_not_plugged(q);
> 		goto get_rq;
> 	}
> 	if (bio_barrier(bio)) {
> 	   /* we know the queue is not empty, so avoid that check and 
> 	      simply don't plug */
> 	   goto get_rq;
>         }
> 
> Now that makes sense.  The answer to the question "why would you want
> to plug the queue for a barrier bio?" is that you don't.

The answer is that you don't want to plug it anymore than what you do
for a regular request, but see what I wrote above.

> This is how I came to the change the I suggested.  The current code is
> confusing, and testing elv_queue_empty in blk_plug_device is really a
> layering violation.
> 
> You are correct from a operational sense when you say that "no change
> is necessary there" (providing the queue_head is initialised, which it
> is by blk_init_queue via elevator_init, but isn't by
> blk_queue_make_request) but I don't think you are correct from an
> abstractional purity perspective.

Alright you've convinced me about that part. Will you send me the
updated patch?

-- 
Jens Axboe


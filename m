Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSFFC6r>; Wed, 5 Jun 2002 22:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSFFC6q>; Wed, 5 Jun 2002 22:58:46 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:7860 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316750AbSFFC6o>; Wed, 5 Jun 2002 22:58:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 6 Jun 2002 12:58:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15614.53205.986092.882909@notabene.cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
In-Reply-To: message from Jens Axboe on Wednesday June 5
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 5, axboe@suse.de wrote:
> 
> To some extent, I agree with you. However, I'm not sure it's worth it
> abstracting this bit out. The size of the request queue right now in
> 2.5.20 (with plug change) is 196 bytes on i386 SMP. If you really feel
> it's worth saving these bytes, then I'd much rather go in a different
> direction: only keep the "main" elements of request_queue_t, and have
> blk_init_queue() alloc the "remainder"

It's not really the bytes that worry about.  More the cleanliness of
the abstraction.
I actually realy like the approach of embeding a more general data
structure inside a more specific data structure and using a list_entry
type macro to get from the one to the other...  it has a very OO feel
to it (which is, in this case, good I think) but I suspect it a very
personal-taste sort of thing.

> 
> > In ll_rw_blk.c we change blk_plug_device to avoid the check for
> > the queue being empty as this may not be well define for
> > umem/raid5.  Instead, blk_plug_device is not called when
> > the queue is not empty (which is mostly wasn' anyway).
> 
> I left it that way on purpose, and yes I did see you changed that in the
> previous patch as well. I think it's a bit of a mess to have both
> blk_plug_device and blk_plug_queue. Without looking at it, I have no
> idea which does what?! blk_queue_empty() will always be true for
> make_request_fn type drivers, so no change is necessary there.

I'm not pushing the blk_plug_device vs blk_plug_queue distinction.

It is just that I think the current blk_plug_device is wrong...  let
me try to show you why..

First, look where it is called, in __make_request (which I always
thought should be spelt "elevator_make_request") - note that this is
the ONLY place that it is called other than the calls that have just
been introduced in md and umem - :


	if (blk_queue_empty(q) || bio_barrier(bio)) {
		blk_plug_device(q);
		goto get_rq;
	}

Which says "if the queue is empty or this is a barrier bio, then
plug the queue and go an make a request, skipping the merging".

One then wonders why you would want to plug the queue for a barrier
bio.  The queue-empty bit makes sense, but not the barrier bit...

Ok, lets see exactly what blk_plug_device(q) does by (mentally)
inlining it:

	if (blk_queue_empty(q) || bio_barrier(bio)) {

		if (!elv_queue_empty(q))
			goto return;

			if (!blk_queue_plugged(q)) {
				spin_lock(&blk_plug_lock);
				list_add_tail(&q->plug_list, &blk_plug_list);
				spin_unlock(&blk_plug_lock);
			}
	return:
		goto get_rq;
	}

So we are actually plugging it if it isn't already plugged (makes
sense) and elv_queue_empty, and blk_queue_empty ... or bio_barrier.
I wander what those two differnt *_queue_empty functions are .....
looks in blkdev.h.. Oh, they are the same.
So we can simplify this a bit:

	If (the_queue_is_empty(q)) {
		plug_if_not_plugged(q);
		goto get_rq;
	}
	if (bio_barrier(bio)) {
	   /* we know the queue is not empty, so avoid that check and 
	      simply don't plug */
	   goto get_rq;
        }

Now that makes sense.  The answer to the question "why would you want
to plug the queue for a barrier bio?" is that you don't.

This is how I came to the change the I suggested.  The current code is
confusing, and testing elv_queue_empty in blk_plug_device is really a
layering violation.

You are correct from a operational sense when you say that "no change
is necessary there" (providing the queue_head is initialised, which it
is by blk_init_queue via elevator_init, but isn't by
blk_queue_make_request) but I don't think you are correct from an
abstractional purity perspective.

NeilBrown

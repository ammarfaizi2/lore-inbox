Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSFOIuX>; Sat, 15 Jun 2002 04:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSFOIuW>; Sat, 15 Jun 2002 04:50:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62403 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315178AbSFOIuW>;
	Sat, 15 Jun 2002 04:50:22 -0400
Date: Sat, 15 Jun 2002 10:50:11 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020615085011.GA5812@suse.de>
In-Reply-To: <200206150845.BAA00793@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15 2002, Adam J. Richter wrote:
> >> 	At any time, there could be only one "hinted" bio in a
> >> request: the last bio in the request.  So you only have to
> >> clear the hint when:
> >> 
> >> 		1. you merge bio's,
> >> 		2. elv_next_request is called,
> >> 		3. newbio is submitted.
> >> 
> >> 	In all three cases q->queue_lock gets taken, so we should
> >> not need to add any additional spin_lock_irq's, and the two lines
> >> to clear the hint pointers should be trivial.
> 
> >This logic is flawed. As I said, once you pass the bio to submit_bio,
> >you can't maintain a pointer to it for these purposes. Grabbing the
> >queue_lock guarentees absolutely nothing in this regard. Consider loop,
> >for instance. I/O could be completed by the time bio_submit returns.
> 
> 	So, I need a fourth location at in generic_make_request
> just before the call to q->make_request_fn, like so:
> 
> 	if (q->make_request_fn != __make_request) {
> 		int flags;
> 		spin_lock_irqsave(q->lock, flags);
> 		clear_hint(bio);
> 		spin_unlock_irqrestore(q->lock, flags);
> 	}
> 	ret = q->make_request_fn(q, bio);

Irk, this is ugly. But how you are moving away from the initial goal (or
maybe this was your goal the whole time, just a single merge hint?) of
passing back the hint instead of maintaing it in the queue. So let me
ask, are you aware of the last_merge I/O scheduler hint? Which does
exactly this already...

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSFOIpf>; Sat, 15 Jun 2002 04:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSFOIpe>; Sat, 15 Jun 2002 04:45:34 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:63896 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315179AbSFOIpe>; Sat, 15 Jun 2002 04:45:34 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 01:45:27 -0700
Message-Id: <200206150845.BAA00793@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	At any time, there could be only one "hinted" bio in a
>> request: the last bio in the request.  So you only have to
>> clear the hint when:
>> 
>> 		1. you merge bio's,
>> 		2. elv_next_request is called,
>> 		3. newbio is submitted.
>> 
>> 	In all three cases q->queue_lock gets taken, so we should
>> not need to add any additional spin_lock_irq's, and the two lines
>> to clear the hint pointers should be trivial.

>This logic is flawed. As I said, once you pass the bio to submit_bio,
>you can't maintain a pointer to it for these purposes. Grabbing the
>queue_lock guarentees absolutely nothing in this regard. Consider loop,
>for instance. I/O could be completed by the time bio_submit returns.

	So, I need a fourth location at in generic_make_request
just before the call to q->make_request_fn, like so:

	if (q->make_request_fn != __make_request) {
		int flags;
		spin_lock_irqsave(q->lock, flags);
		clear_hint(bio);
		spin_unlock_irqrestore(q->lock, flags);
	}
	ret = q->make_request_fn(q, bio);

	Perhaps it would be clearer for blk_queue_make_request to
set a queue flag, and then have generic_make_request check that flag
rather than checking the value of q->make_request_fn.

	If some other driver wants to implement its own weird queuing
system, then it merely doesn't benefit from the bio hints (because
they are cleared as bio's are passed into the weird queuing system).
Better yet, if the weird queuing system uses struct requet the way
__make_request does, then it could conceivably set tha new queue flag
and take care grabbing q->lock and clearing the hints when it takes
requests off of its internal queue if it wants to.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

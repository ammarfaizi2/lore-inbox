Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRKKTnA>; Sun, 11 Nov 2001 14:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRKKTmu>; Sun, 11 Nov 2001 14:42:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280537AbRKKTmo>; Sun, 11 Nov 2001 14:42:44 -0500
Date: Sun, 11 Nov 2001 11:38:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.GSO.4.21.0111111423110.17411-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111111126500.901-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Nov 2001, Alexander Viro wrote:
> >
> > There may be old requests that haven't finished, of course. And there may
> > be requests on the request queue that the driver hasn't even looked at yet
> > (Hmm.. I'm not sure that latter one is right - we must have done the
> > device sync anyway, and that will unplug the requests queue etc).
>
> Why would it?  Sync deals with write requests, read requests are left as-is.
> Notice that in your tree the thing shuts readahead requests down is
> invalidate_bdev() and we don't want to get it called - for very obvious
> reasons.

read and write requests are on the same queue. Starting write requests
starts the read requests.

And we will _not_ be adding any more read requests if the device count has
gone down to zero.

> Sure.  But there may very well be requests coming into driver from the
> queue.

So? We should wait for the QUEUE, not for something else.

> Umm... So you want sync to wait for read requests, not just the write ones?
> That would certainly be enough, but that's not what everyone expects from
> sync...

No, I want the _shutdown_ to wait for all requests. It could even be as
simple as

	generic_unplug_queue(q);
	while (!queue_empty(q)) {
		set_task_state(TASK_UNINTERRUPTIBLE);
		schedule_timeout(1);
	}

but if we want to be fancy we allow shared queues to ignore other drivers
that share the queue (queue sharing is really not supposed to happen any
more, though, and neither IDE nor SCSI do it, so I doubt it matters).

So the above would be called from "invalidate_bdev()" or something..

Hmm.. Looking at "invalidate_bdev()", I doubt it matters, actually - it
will already wait for all buffers, whether dirty or not. So it looks like
it would already be impossible to have buffers on the queue.

		Linus


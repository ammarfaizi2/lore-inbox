Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSFKJEa>; Tue, 11 Jun 2002 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSFKJE3>; Tue, 11 Jun 2002 05:04:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18448 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316847AbSFKJE2>; Tue, 11 Jun 2002 05:04:28 -0400
Message-ID: <3D05BD10.106@evision-ventures.com>
Date: Tue, 11 Jun 2002 11:04:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And while I'd like to avoid #include hell, I'm not willing to replace
> inline functions with #define's to avoid it ;^p


A more real example from blk.h:


extern inline struct request *elv_next_request(request_queue_t *q)
{
	struct request *rq;

	while ((rq = __elv_next_request(q))) {
		rq->flags |= REQ_STARTED;

		if (&rq->queuelist == q->last_merge)
			q->last_merge = NULL;

		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
			break;

		/*
		 * all ok, break and return it
		 */
		if (!q->prep_rq_fn(q, rq))
			break;

		/*
		 * prep said no-go, kill it
		 */
		blkdev_dequeue_request(rq);
		if (end_that_request_first(rq, 0, rq->nr_sectors))
			BUG();

		end_that_request_last(rq);
	}

	return rq;
}

The only thing this achvies is kernel bload, since
elv_next_request is:

1. Calling tons of functions, which could be inlined as well.

2. Not precisely on any ultra fast path.

3. Bound by the device speed.

4. Increasing the pressure on branch prediction due
to the while construct.


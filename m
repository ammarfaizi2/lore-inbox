Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131774AbQK2SXa>; Wed, 29 Nov 2000 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131912AbQK2SXU>; Wed, 29 Nov 2000 13:23:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44039 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S131928AbQK2SXI>; Wed, 29 Nov 2000 13:23:08 -0500
Date: Wed, 29 Nov 2000 09:52:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: plug problem in linux-2.4.0-test11
In-Reply-To: <20001129152308.A28399@suse.de>
Message-ID: <Pine.LNX.4.10.10011290949520.11951-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Jens Axboe wrote:
> 
> I agree with your reasoning, even if the s390 behaviour is a bit
> "non-standard" wrt block devices. Linus, could you apply?
> 
> --- drivers/block/ll_rw_blk.c~	Wed Nov 29 15:17:33 2000
> +++ drivers/block/ll_rw_blk.c	Wed Nov 29 15:18:43 2000
> @@ -347,10 +347,9 @@
>   */
>  static inline void __generic_unplug_device(request_queue_t *q)
>  {
> -	if (!list_empty(&q->queue_head)) {
> -		q->plugged = 0;
> +	q->plugged = 0;
> +	if (!list_empty(&q->queue_head))
>  		q->request_fn(q);
> -	}
>  }

I would much rather actually go back to the original setup, which did
nothing at all if the queue wasn't plugged in the first place.

I think that we should strive for a setup that calls "request_fn" only to
start new IO, and that expects the low-level driver to be able to do the
whole request queue until it is empty. Then we re-start it the next time
around.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

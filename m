Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUK7R>; Tue, 21 Nov 2000 05:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKUK7H>; Tue, 21 Nov 2000 05:59:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16903 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129208AbQKUK66>;
	Tue, 21 Nov 2000 05:58:58 -0500
Date: Tue, 21 Nov 2000 11:28:36 +0100
From: Jens Axboe <axboe@suse.de>
To: kumon@flab.fujitsu.co.jp
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
Message-ID: <20001121112836.B10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Tue, Nov 21, 2000 at 05:38:44PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2000, kumon@flab.fujitsu.co.jp wrote:
> The current elevator_linus() doesn't obey the true elevator
> scheduling, and causes I/O livelock during frequent random write
> traffics. In such environment I/O (read/write) transactions may be
> delayed almost infinitely (more than 1 hour).
> 
> Problem:
>  Current elevator_linus() traverses the I/O requesting queue from the
> tail to top. And when the current request has smaller sector number
> than the request on the top of queue, it is always placed just after
> the top.
>  This means, if requests in some sector range are continuously
> generated, a request with larger sector number is always places at the
> last and has no chance to go to the front.  e.g. it is not scheduled.

Believe it or not, but this is intentional. In that regard, the
function name is a misnomer -- call it i/o scheduler instead :-)
The current settings in test11 cause this behaviour, because the
starting request sequence numbers are a 'bit' too high.

I'd be very interested if you could repeat your test with my
block patch applied. It has, among other things, a more fair (and
faster) insertion.

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/blk-11.bz2

> [...] Additionally, it may be better to add extra priority to reads
> than writes to obtain better response, but this patch doesn't.

READs do have bigger priority, they start out with lower sequence
numbers than WRITEs do:

	latency = elevator_request_latency(elevator, rw);

With my patch, READ sequence start is now 8192. WRITEs are twice
that.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

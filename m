Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135504AbRDZO5P>; Thu, 26 Apr 2001 10:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbRDZO5F>; Thu, 26 Apr 2001 10:57:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23308 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135504AbRDZO4x>;
	Thu, 26 Apr 2001 10:56:53 -0400
Date: Thu, 26 Apr 2001 16:56:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block device strategy and requests
Message-ID: <20010426165647.D496@suse.de>
In-Reply-To: <20010426153815.B2101@sable.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010426153815.B2101@sable.ox.ac.uk>; from mbeattie@sable.ox.ac.uk on Thu, Apr 26, 2001 at 03:38:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26 2001, Malcolm Beattie wrote:
> I'm designing a block device driver for a high performance disk
> subsystem with unusual characteristics. To what extent is the
> limited number of "struct request"s (128 by default) necessary for
> back-pressure? With this I/O subsystem it would be possible for the

Not at all

> strategy function to rip the requests from the request list straight
> away, arrange for the I/Os to be done to/from the buffer_heads (with
> no additional state required) with no memory "leak". This would
> effectively mean that the only limit on the number of I/Os queued
> would be the number of buffer_heads allocated; not a fixed number of
> "struct request"s in flight. Is this reasonable or does any memory or
> resource balancing depend on the number of I/Os outstanding being
> bounded?

The requests need not be bounded, as long as the buffer_heads are. I
don't see how the above scheme differs from some of the drivers that are
currently in the tree though?

> Also, there is a lot of flexibility in how often interrupts are sent
> to mark the buffer_heads up-to-date. (With the requests pulled
> straight off the queue, the job of end_that_request_first() in doing
> the linked list updates and bh->b_end_io() callbacks would be done by
> the interrupt routine directly.) At one extreme, I could take an
> interrupt for each 4K block issued and mark it up-to-date very
> quickly making for very low-latency I/O but a very large interrupt
> rate when I/O throughput is high. The alternative would be to arrange
> for an interrupt every n buffer_heads (or based on some other
> criterion) and only take an interrupt and mark buffers up-to-date on
> each of those). Are there any rules of thumb on which is best or
> doesn't it matter too much?

An interrupt per request would give you anywhere between 4kB and XXXkB
transfer per interrupt, depending on what you set your max_sectors to.
Going bigger than that probably won't make a whole lot of sense, and you
would have to do additional foot-work to make it happen. In theory. Only
real-life testing can tell you for sure, and how big requests you get
depends heavily on the workload so there will be no one true answer for
this.

-- 
Jens Axboe


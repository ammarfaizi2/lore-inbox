Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbTFCJqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTFCJqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:46:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:27218 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264860AbTFCJqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:46:40 -0400
Date: Tue, 3 Jun 2003 03:00:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Counter-kludge for 2.5.x hanging when writing to block device
Message-Id: <20030603030023.69d39d6e.akpm@digeo.com>
In-Reply-To: <20030603091018.GI482@suse.de>
References: <200306030848.h538mwE22282@freya.yggdrasil.com>
	<20030603091018.GI482@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 10:00:07.0413 (UTC) FILETIME=[E9763250:01C329B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Tue, Jun 03 2003, Adam J. Richter wrote:
> > 	For at least the past few months, the Linux 2.5 kernels have
> > hung when I try to write a large amount of data to a block device.

Well ytf is this the first time I've heard about it?

> > I most commonly notice this when trying to clear a disk with a command
> > like "dd if=/dev/zero of=/dev/discs/disc1/disc".  Sometimes doing
> > an mkfs on a big file system is enough to cause the hang.
> > I wrote a little program to repeatedly write a 4kB block of zeroes
> > to the kernel so I could track how far it got before hanging, and it
> > would write 210-215MB of zeroes to the disk on a computer that had
> > 512MB of RAM before hanging.  When these hangs occur, other processes
> > continue to run fine, and I can do syncs, which return, but the
> > hung process never resumes.  In the past, I've verified with a
> > printk that it is looping in balance_dirty_pages, repeatedly
> > calling blk_congestion_wait, and never leaving the loop.
> > 

Please debug it further.  Something may have gone wrong with the arithmetic
in balance_dirty_pages().

> > 	Here is a counter-kludge that seems to stop the problem.
> > This is certainly not the "right" fix.  It just illustrates a way
> > to stop the problem.
> > 
> > 	By the way, I say "counter-kludge", because I get the impression
> > that blk_congestion_wait is itself a kludge, since it calls
> > blk_run_queues and waits a fixed amount of time, 100ms in this case,
> > potentially a big waste of time, rather than awaiting some more
> > accurate criterion.

The sleep in blk_congestion_wait() terminates when a request is returned to
the queue.  The timeout is only really there for non-request-based backing
devices.

> Does something like this work? Andrew, what's the point of doing the
> wait if the queue isn't congested?!

We need to wait until the amount of dirty memory in the machine is below
the designated limits.  This is unrelated to queue congestion.  The way the
logic is now we can have 256 megs worth of requests queues on a 32M machine
and everything throttles and clamps as intended.


There are several things wrong with blk_congestion_wait(), including:

a) it should be called throttle_on_io()

b) it should check that there are still requests in flight after parking
   itself on the waitqueue rather than relying on the timeout.

c) for memory reclaim we should terminate the sleep on a certain number
   of pages coming unreclaimable, not on write requests being returned or
   timeout.

d) network filesystems should be delivering wakeups to throttled
   processes rather than relying on the timeout.

But none of these have proven sufficiently problematic to justify futzing
with it.  I expect d) will eventually need to be implemented.

As for Adam's hang: dunno.  I and many others have run mkfs and dd an
unbelievable number of times.  He needs to debug it more.


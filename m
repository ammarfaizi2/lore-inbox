Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUH1NIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUH1NIS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUH1NIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:08:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53888 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265691AbUH1NIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:08:14 -0400
Date: Sat, 28 Aug 2004 15:07:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-ID: <20040828130757.GA2397@suse.de>
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de> <m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de> <m3hdqsckoo.fsf@telia.com> <20040825065055.GA2321@suse.de> <m3u0unwplj.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u0unwplj.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28 2004, Peter Osterlund wrote:
> > > The situation happened when I dumped >1GB of data to a DVD+RW disc on
> > > a 1GB RAM machine. For some reason, the number of pending bio's didn't
> > > go much larger than 200000 (ie 400MB) even though it could probably
> > > have gone to 800MB without swapping. The machine didn't feel
> > > unresponsive during this test.
> > 
> > But it very well could have. If you dive into the bio mempool (or the
> > biovec pool) and end up having most of those reserved entries built up
> > for execution half an hour from now, you'll stall (or at least hinder)
> > other processes from getting real work done.
> > 
> > Latencies are horrible, I don't think it makes sense to allow more than
> > a few handful of pending zone writes in the packet writing driver.
> 
> I ran some tests copying files to a 4x DVD+RW disc for different
> values of the maximum number of allowed bios in the queue. I used
> kernel 2.6.8.1 with the packet writing patches from the -mm tree. All
> tests used the udf filesystem.
> 
> Test 1: dd-ing 250MB from /dev/zero:
> 
>         1024:  	53.2s
>         8192:	54.6s
>         inf:	51.2s

Out of how many runs did you average those numbers? Look close enough to
be normal variance, so not conclusive I'd say.

> Test 2: Writing 29 files, total size 120MB (Source files cached in RAM
> before the test started):
> 
>         1024:	71.6s
>         8192:	81.1s
>         32768:	52.7s
>         49152:	31.4s
>         65536:	26.6s
>         inf:	27.7s
> 
> Test 3: Writing 48 files, total size 196MB (Source files cached in RAM
> before the test started):
> 
>         65536:	65.8s
>         inf:	40.2s
> 
> Test 4: Repeat of test 3:
> 
>         65536:	67.4s
>         inf:	41.8s
> 
> The conclusion is that when writing one big file, it doesn't hurt to
> limit the number of pending bios, but when writing many files,
> limiting the amount of queued data to "only" 128MB makes the write
> performance 60% slower.

I'd rather say that the above is indicative of a layout (or other)
problem with the file system. 64K bio queue must be at least 256MB
pending in itself, how can inf even make a difference there? You would
gain so much more performance by fixing the fs instead of attempting to
build up hundreds of megabytes of pending data, I think that's a really
bad idea (not just a suboptimal solution, also extremely bad for the
rest of the system).

> Note that the reduced I/O performance will also reduce the lifetime of
> the disc, because some sectors will be written more often than
> necessary.

Surely, yes.

> +	while (pd->bio_queue_size >= 8192)
> +		blk_congestion_wait(WRITE, HZ / 5);
> +

This is not really how you'd want to do it. When you reach that
threshold, mark the queue congested and get pdflush to leave you alone
instead. Then clear the congestion when you get below a certain number
again. For this test I don't think it should make a difference, though.

-- 
Jens Axboe


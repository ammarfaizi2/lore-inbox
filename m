Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUH1KKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUH1KKG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUH1KDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:03:35 -0400
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:52919 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S264973AbUH1J7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:59:21 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com> <20040825065055.GA2321@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Aug 2004 11:59:04 +0200
In-Reply-To: <20040825065055.GA2321@suse.de>
Message-ID: <m3u0unwplj.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Tue, Aug 24 2004, Peter Osterlund wrote:
> > Jens Axboe <axboe@suse.de> writes:
> > 
> > > You are right, the code looks fine indeed. The bigger problem is
> > > probably that a faster data structure is needed at all, having hundreds
> > > of thousands bio's pending for a packet writing device is not nice at
> > > all.
> > 
> > Why is it not nice? If the VM has decided to create 400MB of dirty
> > data on a DVD+RW packet device, I don't see a problem with submitting
> > all bio's at the same time to the packet device.
> 
> It's not nice because flushing 400MB of dirty data to the packet device
> will take _ages_. That the vm will dirty that much data for you
> non-blocking is a problem in itself. It would still be a really good
> idea for the packet writing driver to "congest" itself, like it happens
> for struct request devices, to prevent build up of these huge queues.

That would be easy to do, see patch below.

> > The situation happened when I dumped >1GB of data to a DVD+RW disc on
> > a 1GB RAM machine. For some reason, the number of pending bio's didn't
> > go much larger than 200000 (ie 400MB) even though it could probably
> > have gone to 800MB without swapping. The machine didn't feel
> > unresponsive during this test.
> 
> But it very well could have. If you dive into the bio mempool (or the
> biovec pool) and end up having most of those reserved entries built up
> for execution half an hour from now, you'll stall (or at least hinder)
> other processes from getting real work done.
> 
> Latencies are horrible, I don't think it makes sense to allow more than
> a few handful of pending zone writes in the packet writing driver.

I ran some tests copying files to a 4x DVD+RW disc for different
values of the maximum number of allowed bios in the queue. I used
kernel 2.6.8.1 with the packet writing patches from the -mm tree. All
tests used the udf filesystem.

Test 1: dd-ing 250MB from /dev/zero:

        1024:  	53.2s
        8192:	54.6s
        inf:	51.2s

Test 2: Writing 29 files, total size 120MB (Source files cached in RAM
before the test started):

        1024:	71.6s
        8192:	81.1s
        32768:	52.7s
        49152:	31.4s
        65536:	26.6s
        inf:	27.7s

Test 3: Writing 48 files, total size 196MB (Source files cached in RAM
before the test started):

        65536:	65.8s
        inf:	40.2s

Test 4: Repeat of test 3:

        65536:	67.4s
        inf:	41.8s

The conclusion is that when writing one big file, it doesn't hurt to
limit the number of pending bios, but when writing many files,
limiting the amount of queued data to "only" 128MB makes the write
performance 60% slower.

Note that the reduced I/O performance will also reduce the lifetime of
the disc, because some sectors will be written more often than
necessary.

---

 linux-petero/drivers/block/pktcdvd.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/block/pktcdvd.c~packet-congest drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-congest	2004-08-28 10:18:48.350080048 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-28 11:26:32.851181960 +0200
@@ -2159,6 +2159,9 @@ static int pkt_make_request(request_queu
 		goto end_io;
 	}
 
+	while (pd->bio_queue_size >= 8192)
+		blk_congestion_wait(WRITE, HZ / 5);
+
 	blk_queue_bounce(q, &bio);
 
 	zone = ZONE(bio->bi_sector, pd);
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

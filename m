Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUH1Smo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUH1Smo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUH1Smo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:42:44 -0400
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:11660 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267519AbUH1Smb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:42:31 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com> <20040825065055.GA2321@suse.de>
	<m3u0unwplj.fsf@telia.com> <20040828130757.GA2397@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Aug 2004 20:42:25 +0200
Message-ID: <m3zn4ff6jy.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Sat, Aug 28 2004, Peter Osterlund wrote:
> > > > The situation happened when I dumped >1GB of data to a DVD+RW disc on
> > > > a 1GB RAM machine. For some reason, the number of pending bio's didn't
> > > > go much larger than 200000 (ie 400MB) even though it could probably
> > > > have gone to 800MB without swapping. The machine didn't feel
> > > > unresponsive during this test.
> > > 
> > > But it very well could have. If you dive into the bio mempool (or the
> > > biovec pool) and end up having most of those reserved entries built up
> > > for execution half an hour from now, you'll stall (or at least hinder)
> > > other processes from getting real work done.
> > > 
> > > Latencies are horrible, I don't think it makes sense to allow more than
> > > a few handful of pending zone writes in the packet writing driver.
> > 
> > I ran some tests copying files to a 4x DVD+RW disc for different
> > values of the maximum number of allowed bios in the queue. I used
> > kernel 2.6.8.1 with the packet writing patches from the -mm tree. All
> > tests used the udf filesystem.
> > 
> > Test 1: dd-ing 250MB from /dev/zero:
> > 
> >         1024:  	53.2s
> >         8192:	54.6s
> >         inf:	51.2s
> 
> Out of how many runs did you average those numbers? Look close enough to
> be normal variance, so not conclusive I'd say.

One run only. I agree the difference is probably not significant,
that's why I said below that for one big file, limiting the queue size
doesn't hurt.

> > Test 2: Writing 29 files, total size 120MB (Source files cached in RAM
> > before the test started):
> > 
> >         1024:	71.6s
> >         8192:	81.1s
> >         32768:	52.7s
> >         49152:	31.4s
> >         65536:	26.6s
> >         inf:	27.7s
> > 
> > Test 3: Writing 48 files, total size 196MB (Source files cached in RAM
> > before the test started):
> > 
> >         65536:	65.8s
> >         inf:	40.2s
> > 
> > Test 4: Repeat of test 3:
> > 
> >         65536:	67.4s
> >         inf:	41.8s
> > 
> > The conclusion is that when writing one big file, it doesn't hurt to
> > limit the number of pending bios, but when writing many files,
> > limiting the amount of queued data to "only" 128MB makes the write
> > performance 60% slower.
> 
> I'd rather say that the above is indicative of a layout (or other)
> problem with the file system. 64K bio queue must be at least 256MB
> pending in itself, how can inf even make a difference there?

Because 64K bio queue is 128MB. Each bio is 2KB when using the udf
filesystem.

> You would gain so much more performance by fixing the fs

I reran the 48 files test using ext2 instead of udf and got this:

Test 5: (48 files, 196MB, ext2)

        1024:   169.7s
        2048:   110.4s
        2048:   144.4s
        4096:   76.8s
        4096:   71.4s
        inf:    59.9s
        inf:    57.0s
        inf:    68.9s

A typical bio seems to be 32KB when using ext2. In the "inf" tests,
the number of queued bios didn't go above 6500. Performance suffers a
lot for ext2 too, although not as bad as for udf when allowing 128MB
in the queue (ie 4096 bios).

The reason ext2 is slower than udf in the "inf" case appears to be
because it reads more from the disc than udf does in these tests.
(Not read gathering from the packet driver, but reads originating from
the ext2 file system.)

> instead of attempting to build up hundreds of megabytes of pending
> data,

Note that the packet writing driver only allocates one rb_node per bio
in the writeout paths, it doesn't allocate any bio or bio_vec
objects. The bio objects are allocated by higher layers before they
call generic_make_request().

> I think that's a really bad idea (not just a suboptimal solution,
> also extremely bad for the rest of the system).

With an otherwise idle system, running

        dd if=/dev/zero bs=1M count=2048 | pipemeter -a -i 2 >tmpfile

on an IDE disk produces 40-45MB/s. 

When running two such commands writing both to the HD and the DVD at
the same time, I get: (The DVD and the HD are on different IDE
channels)

        No queue limit: 4-5MB/s to the DVD, 5-6MB/s to the HD.
        max 4096 bios:  ~4MB/s to the DVD, 8.4MB/s average to the HD.

However, with the 4096 bio limit, the HD writing speed is very
irregular. It blocks for ~30s, then writes data at 30-45MB/s for a
short time, then blocks again, etc. I didn't observe this behavior
when there was no bio queue limit. The DVD writing speed was pretty
stable in both cases, ie the bio queue stayed at ~200000 and 4096
respectively.

Is this a general VM limitation? Has anyone been able to saturate the
write bandwidth of two different block devices at the same time, when
they operate at vastly different speeds (45MB/s vs 5MB/s), and when
the writes are large enough to cause memory pressure?

> > +	while (pd->bio_queue_size >= 8192)
> > +		blk_congestion_wait(WRITE, HZ / 5);
> > +
> 
> This is not really how you'd want to do it. When you reach that
> threshold, mark the queue congested and get pdflush to leave you alone
> instead. Then clear the congestion when you get below a certain number
> again. For this test I don't think it should make a difference, though.

I tried the patch below, then ran:

        dd if=/dev/zero bs=1M count=2048 | pipemeter -a -i 2 >/udf/tmpfile

The queue length stayed below 4096 until there was memory pressure.
The queue then became very long (>200000) and the driver reported:

        pkt_make_request: Process pipemeter didn't honor congestion

Maybe some code path forgets to check the queue congestion state.


 linux-petero/drivers/block/ll_rw_blk.c |    6 ++++--
 linux-petero/drivers/block/pktcdvd.c   |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-congest drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-congest	2004-08-28 10:18:48.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-28 19:49:44.168377544 +0200
@@ -51,6 +51,10 @@
 
 #include <asm/uaccess.h>
 
+void clear_queue_congested(request_queue_t *q, int rw);
+void set_queue_congested(request_queue_t *q, int rw);
+
+
 #if PACKET_DEBUG
 #define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
 #else
@@ -981,6 +985,9 @@ try_next_bio:
 	}
 	spin_unlock(&pd->lock);
 
+	if (pd->bio_queue_size < 3*1024)
+		clear_queue_congested(pd->disk->queue, WRITE);
+
 	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
 	pkt_set_state(pkt, PACKET_WAITING_STATE);
 	atomic_set(&pkt->run_sm, 1);
@@ -2159,6 +2166,13 @@ static int pkt_make_request(request_queu
 		goto end_io;
 	}
 
+	if (pd->bio_queue_size >= 4096)
+		set_queue_congested(q, WRITE);
+
+	if (pd->bio_queue_size >= 5*1024)
+		printk("pkt_make_request: Process %s didn't honor congestion\n",
+		       current->comm);
+
 	blk_queue_bounce(q, &bio);
 
 	zone = ZONE(bio->bi_sector, pd);
diff -puN drivers/block/ll_rw_blk.c~packet-congest drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c~packet-congest	2004-08-28 19:27:46.000000000 +0200
+++ linux-petero/drivers/block/ll_rw_blk.c	2004-08-28 19:28:31.000000000 +0200
@@ -111,7 +111,7 @@ static void blk_queue_congestion_thresho
  * congested queues, and wake up anyone who was waiting for requests to be
  * put back.
  */
-static void clear_queue_congested(request_queue_t *q, int rw)
+void clear_queue_congested(request_queue_t *q, int rw)
 {
 	enum bdi_state bit;
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
@@ -122,18 +122,20 @@ static void clear_queue_congested(reques
 	if (waitqueue_active(wqh))
 		wake_up(wqh);
 }
+EXPORT_SYMBOL(clear_queue_congested);
 
 /*
  * A queue has just entered congestion.  Flag that in the queue's VM-visible
  * state flags and increment the global gounter of congested queues.
  */
-static void set_queue_congested(request_queue_t *q, int rw)
+void set_queue_congested(request_queue_t *q, int rw)
 {
 	enum bdi_state bit;
 
 	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
 	set_bit(bit, &q->backing_dev_info.state);
 }
+EXPORT_SYMBOL(set_queue_congested);
 
 /**
  * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270857AbTGNTjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270868AbTGNTjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:39:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21667 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270857AbTGNThI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:37:08 -0400
Date: Mon, 14 Jul 2003 21:51:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030714195138.GX833@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714131206.GJ833@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14 2003, Jens Axboe wrote:
> On Mon, Jul 14 2003, Marcelo Tosatti wrote:
> > 
> > 
> > On Mon, 14 Jul 2003, Jens Axboe wrote:
> > 
> > > On Sun, Jul 13 2003, Andrea Arcangeli wrote:
> > > > On Sun, Jul 13, 2003 at 11:01:16AM +0200, Jens Axboe wrote:
> > > > > No I don't have anything specific, it just seems like a bad heuristic to
> > > > > get rid of. I can try and do some testing tomorrow. I do feel strongly
> > > >
> > > > well, it's not an heuristic, it's a simplification and it will certainly
> > > > won't provide any benefit (besides saving some hundred kbytes of ram per
> > > > harddisk that is a minor benefit).
> > >
> > > You are missing my point - I don't care about loosing the extra request
> > > list, I never said anything about that in this thread. I care about
> > > loosing the reserved requests for reads. And we can do that just fine
> > > with just holding back a handful of requests.
> > >
> > > > > that we should at least make sure to reserve a few requests for reads
> > > > > exclusively, even if you don't agree with the oversized check. Anything
> > > > > else really contradicts all the io testing we have done the past years
> > > > > that shows how important it is to get a read in ASAP. And doing that in
> > > >
> > > > Important for latency or throughput? Do you know which is the benchmarks
> > > > that returned better results with the two queues, what's the theory
> > > > behind this?
> > >
> > > Forget the two queues, noone has said anything about that. The reserved
> > > reads are important for latency reasons, not throughput.
> > 
> > So Jens,
> > 
> > Please bench (as you said you would), and send us the results.
> > 
> > Its very important.
> 
> Yes of course I'll send the results, at the current rate (they are
> running on the box) it probably wont be before tomorrow though.

Some initial results with the attached patch, I'll try and do some more
fine grained tomorrow. Base kernel was 2.4.22-pre5 (obviously), drive
tested is a SCSI drive (on aic7xxx, tcq fixed at 4), fs is ext3. I would
have done ide testing actually, but the drive in that machine appears to
have gone dead. I'll pop in a new one tomorrow and test on that too.

no_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.22-pre5            2        134     196.3   0.0     0.0     1.00
2.4.22-pre5-axboe      3        133     196.2   0.0     0.0     1.00
ctar_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46
xtar_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.22-pre5            3        309     86.4    15.0    14.9    2.31
2.4.22-pre5-axboe      3        249     107.2   11.3    14.1    1.87
io_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06
io_other:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.22-pre5            3        576     47.2    107.7   19.8    4.30
2.4.22-pre5-axboe      3        452     59.7    85.3    19.5    3.40
read_load:
Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
2.4.22-pre5            3        150     181.3   8.1     9.3     1.12
2.4.22-pre5-axboe      3        152     178.9   8.2     9.9     1.14


===== drivers/block/ll_rw_blk.c 1.47 vs edited =====
--- 1.47/drivers/block/ll_rw_blk.c	Fri Jul 11 10:30:54 2003
+++ edited/drivers/block/ll_rw_blk.c	Mon Jul 14 20:42:36 2003
@@ -549,10 +549,12 @@
 static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
-	struct request_list *rl;
+	struct request_list *rl = &q->rq;
 
-	rl = &q->rq;
-	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
+	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
+		return NULL;
+
+	if (!list_empty(&rl->free)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
@@ -947,7 +949,7 @@
 static int __make_request(request_queue_t * q, int rw,
 				  struct buffer_head * bh)
 {
-	unsigned int sector, count;
+	unsigned int sector, count, sync;
 	int max_segments = MAX_SEGMENTS;
 	struct request * req, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
@@ -958,6 +960,7 @@
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
+	sync = test_and_clear_bit(BH_Sync, &bh->b_state);
 
 	rw_ahead = 0;	/* normal case; gets changed below for READA */
 	switch (rw) {
@@ -1124,6 +1127,8 @@
 		blkdev_release_request(freereq);
 	if (should_wake)
 		get_request_wait_wakeup(q, rw);
+	if (sync)
+		__generic_unplug_device(q);
 	spin_unlock_irq(&io_request_lock);
 	return 0;
 end_io:
===== fs/buffer.c 1.89 vs edited =====
--- 1.89/fs/buffer.c	Tue Jun 24 23:11:29 2003
+++ edited/fs/buffer.c	Mon Jul 14 16:59:59 2003
@@ -1142,6 +1142,7 @@
 	bh = getblk(dev, block, size);
 	if (buffer_uptodate(bh))
 		return bh;
+	set_bit(BH_Sync, &bh->b_state);
 	ll_rw_block(READ, 1, &bh);
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
===== include/linux/fs.h 1.82 vs edited =====
--- 1.82/include/linux/fs.h	Wed Jul  9 20:42:38 2003
+++ edited/include/linux/fs.h	Mon Jul 14 16:59:47 2003
@@ -221,6 +221,7 @@
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Sync,
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities

-- 
Jens Axboe


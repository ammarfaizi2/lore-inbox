Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285148AbRL2RtI>; Sat, 29 Dec 2001 12:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285114AbRL2Rs7>; Sat, 29 Dec 2001 12:48:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16656 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285148AbRL2Rsr>;
	Sat, 29 Dec 2001 12:48:47 -0500
Date: Sat, 29 Dec 2001 18:48:37 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011229184837.F1821@suse.de>
In-Reply-To: <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net> <20011228153022.D1248@suse.de> <20011229014248.A17257@earthlink.net> <20011229183315.E1821@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011229183315.E1821@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29 2001, Jens Axboe wrote:
> On Sat, Dec 29 2001, rwhron@earthlink.net wrote:
> > > > Kernel panic: Out of memory and no killable processes...
> > > 
> > > Someone else did report a similar case. Very strange, doesn't look bio
> > 
> > Al Viro posted a fix:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=100959128922157&w=2
> > 
> > I used Al's patch and 2.5.2-pre3 boots with reiserfs root_fs
> > and no panic.
> > 
> > Below is the trace on 2.5.2-pre3 after dbench 32 livelocked.
> 
> Thanks, could you try with this patch? It's not a fix (haven't found the
> bug yet), but I think we are looking at list corruption so please check
> if this patch at least alters when it hangs etc.

Ah I think I got it -- appears to be down to no rechecking for empty
queue after a potential queue_lock droppage (busy I/O, no request left
get_request returns NULL, drop lock and run get_request_wait). This
explains the get_request_wait deadlock, compiling right now...

--- /opt/kernel/linux-2.5.2-pre3/drivers/block/ll_rw_blk.c	Sat Dec 29 12:17:53 2001
+++ drivers/block/ll_rw_blk.c	Sat Dec 29 12:45:04 2001
@@ -881,7 +881,9 @@
 
 	BUG_ON(rw != READ && rw != WRITE);
 
+	spin_lock_irq(q->queue_lock);
 	rq = get_request(q, rw);
+	spin_unlock_irq(q->queue_lock);
 
 	if (!rq && (gfp_mask & __GFP_WAIT))
 		rq = get_request_wait(q, rw);
@@ -1081,7 +1083,7 @@
 {
 	struct request *req, *freereq = NULL;
 	int el_ret, latency = 0, rw, nr_sectors, cur_nr_sectors, barrier;
-	struct list_head *insert_here = &q->queue_head;
+	struct list_head *insert_here;
 	elevator_t *elevator = &q->elevator;
 	sector_t sector;
 
@@ -1103,15 +1105,14 @@
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
 	spin_lock_irq(q->queue_lock);
+again:
+	req = NULL;
+	insert_here = q->queue_head.prev;
 
 	if (blk_queue_empty(q) || barrier) {
 		blk_plug_device(q);
 		goto get_rq;
 	}
-
-again:
-	req = NULL;
-	insert_here = q->queue_head.prev;
 
 	el_ret = elevator->elevator_merge_fn(q, &req, bio);
 	switch (el_ret) {

-- 
Jens Axboe


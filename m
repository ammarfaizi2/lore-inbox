Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267300AbTGLHit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 03:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267888AbTGLHit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 03:38:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47000 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267300AbTGLHir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 03:38:47 -0400
Date: Sat, 12 Jul 2003 09:48:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030712074827.GA31308@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712073710.GK843@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12 2003, Jens Axboe wrote:
> On Fri, Jul 11 2003, Chris Mason wrote:
> > On Thu, 2003-07-10 at 09:57, Jens Axboe wrote:
> > > On Tue, Jul 08 2003, Marcelo Tosatti wrote:
> > > > 
> > > > Hello people,
> > > > 
> > > > To get better IO interactivity and to fix potential SMP IO hangs (due to
> > > > missed wakeups) we, (Chris Mason integrated Andrea's work) added
> > > > "io-stalls-10" patch in 2.4.22-pre3.
> > > > 
> > > > The "low-latency" patch (which is part of io-stalls-10) seemed to be a
> > > > good approach to increase IO fairness. Some people (Alan, AFAIK) are a bit
> > > > concerned about that, though.
> > > > 
> > > > Could you guys, Stephen, Andrew and maybe Viro (if interested :)) which
> > > > havent been part of the discussions around the IO stalls issue take a look
> > > > at the patch, please?
> > > > 
> > > > It seems safe and a good approach to me, but might not be. Or have small
> > > > "glitches".
> > > 
> > > Well, I have one naive question. What prevents writes from eating the
> > > entire request pool now? In the 2.2 and earlier days, we reserved the
> > > last 3rd of the requests to writes. 2.4.1 and later used a split request
> > > list to make that same guarentee.
> > > 
> > > I only did a quick read of the patch so maybe I'm missing the new
> > > mechanism for this. Are we simply relying on fair (FIFO) request
> > > allocation and oversized queue to do its job alone?
> > 
> > Seems that way.  With the 2.4.21 code, a read might easily get a
> > request, but then spend forever waiting for a huge queue of merged
> > writes to get to disk.
> 
> Correct
> 
> > I believe the new way provides better overall read performance in the
> > presence of lots of writes.
> 
> I fail to see the logic in that. Reads are now treated fairly wrt
> writes, but it would be really easy to let writes consume the entire
> capacity of the queue (be it all the requests, or just going oversized).
> 
> I think the oversized logic is flawed right now, and should only apply
> to writes. Always let reads get through. And don't let writes consume
> the last 1/8th of the requests, or something like that at least. I'll
> try and do a patch for pre4.

Something simple like this should really be added, imo. Untested.

===== drivers/block/ll_rw_blk.c 1.47 vs edited =====
--- 1.47/drivers/block/ll_rw_blk.c	Fri Jul 11 10:30:54 2003
+++ edited/drivers/block/ll_rw_blk.c	Sat Jul 12 09:47:32 2003
@@ -549,10 +549,18 @@
 static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
-	struct request_list *rl;
+	struct request_list *rl = &q->rq;
 
-	rl = &q->rq;
-	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
+	/*
+	 * only apply the oversized queue logic to writes. and only let
+	 * writes consume 7/8ths of the queue, always leave room for some
+	 * reads
+	 */
+	if ((rw == WRITE) &&
+	    blk_oversized_queue(q) || rl->count < q->nr_requests / 8)
+		return NULL;
+
+	if (!list_empty(&rl->free)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;

-- 
Jens Axboe


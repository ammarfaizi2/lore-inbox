Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264680AbUEJOah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264680AbUEJOah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbUEJOah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:30:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23242 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264680AbUEJOab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:30:31 -0400
Date: Mon, 10 May 2004 16:30:24 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040510143024.GF14403@suse.de>
References: <20040507093921.GD21109@suse.de> <200405072200.i47M0AF00868@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405072200.i47M0AF00868@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07 2004, Chen, Kenneth W wrote:
> >>>> Jens Axboe wrote on Friday, May 07, 2004 2:39 AM
> > On Thu, May 06 2004, Chen, Kenneth W wrote:
> > > (3) can we allocate request structure up front in __make_request?
> > >     For I/O that cannot be merged, the elevator code executes twice
> > >     in __make_request.
> > >
> >
> > Actually, with the good working batching we might get away with killing
> > freereq completely. Have you tested that (if not, could you?)
> 
> Sorry, I'm clueless on "good working batching".  If you could please give
> me some pointers, I will definitely test it.

Something like this.

--- linux-2.6.6/drivers/block/ll_rw_blk.c~	2004-05-10 16:23:45.684726955 +0200
+++ linux-2.6.6/drivers/block/ll_rw_blk.c	2004-05-10 16:29:04.333792268 +0200
@@ -2138,8 +2138,8 @@
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
+	struct request *req;
 	sector_t sector;
 
 	sector = bio->bi_sector;
@@ -2161,15 +2161,15 @@
 
 	ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
 
-again:
+	if (barrier)
+		goto get_rq_nolock;
+
 	spin_lock_irq(q->queue_lock);
 
 	if (elv_queue_empty(q)) {
 		blk_plug_device(q);
 		goto get_rq;
 	}
-	if (barrier)
-		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
 	switch (el_ret) {
@@ -2230,21 +2230,17 @@
 	 * a free slot.
 	 */
 get_rq:
-	if (freereq) {
-		req = freereq;
-		freereq = NULL;
-	} else {
-		spin_unlock_irq(q->queue_lock);
-		if ((freereq = get_request(q, rw, GFP_ATOMIC)) == NULL) {
-			/*
-			 * READA bit set
-			 */
-			if (ra)
-				goto end_io;
+	spin_unlock_irq(q->queue_lock);
+get_rq_nolock:
+	req = get_request(q, rw, GFP_ATOMIC);
+	if (!req) {
+		/*
+		 * READA bit set
+		 */
+		if (ra)
+			goto end_io;
 	
-			freereq = get_request_wait(q, rw);
-		}
-		goto again;
+		req = get_request_wait(q, rw);
 	}
 
 	req->flags |= REQ_CMD;
@@ -2276,10 +2272,9 @@
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
+	spin_lock_irq(q->queue_lock);
 	add_request(q, req);
 out:
-	if (freereq)
-		__blk_put_request(q, freereq);
 
 	if (blk_queue_plugged(q)) {
 		int nrq = q->rq.count[READ] + q->rq.count[WRITE] - q->in_flight;

-- 
Jens Axboe


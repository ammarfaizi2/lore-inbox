Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUELNs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUELNs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUELNs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:48:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58816 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265048AbUELNs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:48:29 -0400
Date: Wed, 12 May 2004 15:48:22 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040512134821.GX14789@suse.de>
References: <20040510143024.GF14403@suse.de> <200405120532.i4C5WCF25908@unix-os.sc.intel.com> <20040512070543.GC1803@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512070543.GC1803@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 2004, Jens Axboe wrote:
> On Tue, May 11 2004, Chen, Kenneth W wrote:
> > >>>> Jens Axboe wrote on Monday, May 10, 2004 7:30 AM
> > > > >
> > > > > Actually, with the good working batching we might get away with killing
> > > > > freereq completely. Have you tested that (if not, could you?)
> > > >
> > > > Sorry, I'm clueless on "good working batching".  If you could please give
> > > > me some pointers, I will definitely test it.
> > >
> > > Something like this.
> > >
> > > --- linux-2.6.6/drivers/block/ll_rw_blk.c~	2004-05-10 16:23:45.684726955 +0200
> > > +++ linux-2.6.6/drivers/block/ll_rw_blk.c	2004-05-10 16:29:04.333792268 +0200
> > > @@ -2138,8 +2138,8 @@
> > >
> > >  static int __make_request(request_queue_t *q, struct bio *bio)
> > >  {
> > > -	struct request *req, *freereq = NULL;
> > >  	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
> > > +	struct request *req;
> > >  	sector_t sector;
> > >
> > >
> > > [snip] ...
> > 
> > I'm still working on this.  With this patch, several processes stuck
> > in "D" state and never finish.  Suspect it's the barrier thing, it
> > jumps through blk_plug_device() and might goof up the queue afterwards.
> 
> I'll do a quick test run (and review) of the patch, it wasn't even
> compiled here. So the chance of a slip-up is non-zero.

This at least boots here, does it work correctly for you?

--- include/linux/bio.h~	2004-05-12 09:57:55.000000000 +0200
+++ include/linux/bio.h	2004-05-12 13:15:16.672532790 +0200
@@ -126,6 +126,7 @@
 #define BIO_RW_BARRIER	2
 #define BIO_RW_FAILFAST	3
 #define BIO_RW_SYNC	4
+#define bio_rw_flagged(bio, flag)	((bio)->bi_rw & (1 << (flag)))
 
 /*
  * various member access, note that bio_data should of course not be used
--- drivers/block/ll_rw_blk.c~	2004-05-12 09:40:37.000000000 +0200
+++ drivers/block/ll_rw_blk.c	2004-05-12 15:42:06.924309518 +0200
@@ -1614,7 +1615,6 @@
 	DEFINE_WAIT(wait);
 	struct request *rq;
 
-	generic_unplug_device(q);
 	do {
 		struct request_list *rl = &q->rq;
 
@@ -1626,6 +1626,7 @@
 		if (!rq) {
 			struct io_context *ioc;
 
+			generic_unplug_device(q);
 			io_schedule();
 
 			/*
@@ -2133,8 +2134,8 @@
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
+	struct request *req = NULL;
 	sector_t sector;
 
 	sector = bio->bi_sector;
@@ -2152,17 +2153,17 @@
 
 	spin_lock_prefetch(q->queue_lock);
 
-	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
-
-	ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
+	mb();
+	barrier = bio_rw_flagged(bio, BIO_RW_BARRIER);
+	ra = bio_rw_flagged(bio, BIO_RW_AHEAD);
 
-again:
 	spin_lock_irq(q->queue_lock);
 
 	if (elv_queue_empty(q)) {
 		blk_plug_device(q);
 		goto get_rq;
 	}
+
 	if (barrier)
 		goto get_rq;
 
@@ -2225,21 +2226,16 @@
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
@@ -2248,7 +2244,7 @@
 	 * inherit FAILFAST from bio and don't stack up
 	 * retries for read ahead
 	 */
-	if (ra || test_bit(BIO_RW_FAILFAST, &bio->bi_rw))	
+	if (ra || bio_rw_flagged(bio, BIO_RW_FAILFAST))
 		req->flags |= REQ_FAILFAST;
 
 	/*
@@ -2271,10 +2267,9 @@
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


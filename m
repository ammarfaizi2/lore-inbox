Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSAaVin>; Thu, 31 Jan 2002 16:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291338AbSAaVie>; Thu, 31 Jan 2002 16:38:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49168 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291329AbSAaViT>;
	Thu, 31 Jan 2002 16:38:19 -0500
Date: Thu, 31 Jan 2002 22:37:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Errors in the VM - detailed
Message-ID: <20020131223754.V5301@suse.de>
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net> <200201312024.g0VKORD19223@mailf.telia.com>, <200201312024.g0VKORD19223@mailf.telia.com> <20020131212909.T5301@suse.de> <3C59AC5C.6B6C6066@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C59AC5C.6B6C6066@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31 2002, Andrew Morton wrote:
> rmap 11c:
>   ...
>   - elevator improvement                                  (Andrew Morton)
> 
> Which includes:
> 
> -       queue_nr_requests = 64;
> -       if (total_ram > MB(32))
> -               queue_nr_requests = 128;                                                                 +       queue_nr_requests = (total_ram >> 9) & ~15;     /* One per half-megabyte */
> +       if (queue_nr_requests < 32)
> +               queue_nr_requests = 32;
> +       if (queue_nr_requests > 1024)
> +               queue_nr_requests = 1024;
> 
> 
> So Roy is running with 1024 requests.

Ah yes, of course.

> The question is (sorry, Roy): does this need fixing?
> 
> The only thing which can trigger it is when we have
> zillions of threads doing reads (or zillions of outstanding
> aio read requests) or when there are a large number of
> unmerged write requests in the elevator.  It's a rare
> case.

Indeed.

> If we _do_ need a fix, then perhaps we should just stop
> using READA in the readhead code?  readahead is absolutely
> vital to throughput, and best-effort request allocation
> just isn't good enough.

Hmm well. Maybe just a small pool of requests set aside for READA would
be a better idea. That way "normal" reads are not able to starve READA
completely.

Something ala this, completely untested. Will try and boot it now :-)
Roy, could you please test? It's against 2.4.18-pre7, I'll boot it now
as well...

--- /opt/kernel/linux-2.4.18-pre7/include/linux/blkdev.h	Mon Nov 26 14:29:17 2001
+++ linux/include/linux/blkdev.h	Thu Jan 31 22:29:01 2002
@@ -74,9 +74,9 @@
 struct request_queue
 {
 	/*
-	 * the queue request freelist, one for reads and one for writes
+	 * the queue request freelist, one for READ, WRITE, and READA
 	 */
-	struct request_list	rq[2];
+	struct request_list	rq[3];
 
 	/*
 	 * Together with queue_head for cacheline sharing
--- /opt/kernel/linux-2.4.18-pre7/drivers/block/ll_rw_blk.c	Sun Jan 27 16:06:31 2002
+++ linux/drivers/block/ll_rw_blk.c	Thu Jan 31 22:36:24 2002
@@ -333,8 +333,10 @@
 
 	INIT_LIST_HEAD(&q->rq[READ].free);
 	INIT_LIST_HEAD(&q->rq[WRITE].free);
+	INIT_LIST_HEAD(&q->rq[READA].free);
 	q->rq[READ].count = 0;
 	q->rq[WRITE].count = 0;
+	q->rq[READA].count = 0;
 
 	/*
 	 * Divide requests in half between read and write
@@ -352,6 +354,20 @@
 		q->rq[i&1].count++;
 	}
 
+	for (i = 0; i < queue_nr_requests / 4; i++) {
+		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
+		/*
+		 * hey well, this needs better checking (as well as the above)
+		 */
+		if (!rq)
+			break;
+
+		memset(rq, 0, sizeof(struct request));
+		rq->rq_status = RQ_INACTIVE;
+		list_add(&rq->queue, &q->rq[READA].free);
+		q->rq[READA].count++;
+	}
+
 	init_waitqueue_head(&q->wait_for_request);
 	spin_lock_init(&q->queue_lock);
 }
@@ -752,12 +768,18 @@
 		req = freereq;
 		freereq = NULL;
 	} else if ((req = get_request(q, rw)) == NULL) {
-		spin_unlock_irq(&io_request_lock);
+
 		if (rw_ahead)
-			goto end_io;
+			req = get_request(q, READA);
 
-		freereq = __get_request_wait(q, rw);
-		goto again;
+		spin_unlock_irq(&io_request_lock);
+
+		if (!req && rw_ahead)
+			goto end_io;
+		else if (!req) {
+			freereq = __get_request_wait(q, rw);
+			goto again;
+		}
 	}
 
 /* fill up the request-info, and add it to the queue */
@@ -1119,7 +1141,7 @@
 	 */
 	queue_nr_requests = 64;
 	if (total_ram > MB(32))
-		queue_nr_requests = 128;
+		queue_nr_requests = 256;
 
 	/*
 	 * Batch frees according to queue length

-- 
Jens Axboe


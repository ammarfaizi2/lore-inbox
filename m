Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTBPLtw>; Sun, 16 Feb 2003 06:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTBPLtw>; Sun, 16 Feb 2003 06:49:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55238 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266431AbTBPLtv>;
	Sun, 16 Feb 2003 06:49:51 -0500
Date: Sun, 16 Feb 2003 12:59:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] elv_former_request reversion
Message-ID: <20030216115908.GY26738@suse.de>
References: <20030215161236.67ce3f24.akpm@digeo.com> <20030216093244.GP26738@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216093244.GP26738@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16 2003, Jens Axboe wrote:
> On Sat, Feb 15 2003, Andrew Morton wrote:
> > 
> > This morning's fix for elv_former_request() is causing oopses all over the
> > place in the IO scheduler.
> > 
> > Jens, remember that I did try that fix a while ago, and the same happened.
> > 
> > I believe it has exposed a new problem at the
> > __make_request/attempt_front_merge level: if attempt_front_merge()
> > actually succeeds, the wrong request gets freed up in
> > elv_merged_request().
> > 
> > It may be best to back this change out until it can be fixed up for
> > real.
> 
> Yes agreed, I had forgotten about that point... Will fix.

Andrew, does this work for you?

===== drivers/block/deadline-iosched.c 1.14 vs edited =====
--- 1.14/drivers/block/deadline-iosched.c	Fri Feb 14 13:57:15 2003
+++ edited/drivers/block/deadline-iosched.c	Sun Feb 16 12:57:35 2003
@@ -297,6 +297,9 @@
 		deadline_del_drq_rb(dd, drq);
 	}
 
+	if (q->last_merge == &rq->queuelist)
+		q->last_merge = NULL;
+
 	list_del_init(&rq->queuelist);
 }
 
@@ -424,12 +427,7 @@
 {
 	request_queue_t *q = drq->request->q;
 
-	if (q->last_merge == &drq->request->queuelist)
-		q->last_merge = NULL;
-
-	deadline_del_drq_hash(drq);
-	deadline_del_drq_rb(dd, drq);
-	list_del_init(&drq->fifo);
+	deadline_remove_request(q, drq->request);
 	list_add_tail(&drq->request->queuelist, dd->dispatch);
 }
 
===== drivers/block/elevator.c 1.39 vs edited =====
--- 1.39/drivers/block/elevator.c	Sun Feb 16 00:57:09 2003
+++ edited/drivers/block/elevator.c	Sun Feb 16 11:32:35 2003
@@ -399,7 +399,7 @@
 	elevator_t *e = &q->elevator;
 
 	if (e->elevator_former_req_fn)
-		return e->elevator_latter_req_fn(q, rq);
+		return e->elevator_former_req_fn(q, rq);
 
 	prev = rq->queuelist.prev;
 	if (prev != &q->queue_head && prev != &rq->queuelist)

-- 
Jens Axboe


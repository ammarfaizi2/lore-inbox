Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWILP57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWILP57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWILP56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:57:58 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:41974 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751429AbWILPu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:57 -0400
Message-Id: <20060912144904.197253000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 11/20] nbd: request_fn fixup
Content-Disposition: inline; filename=nbd_fix.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping the queue_lock opens up a nasty race, fix this race by
plugging the device when we're done.

Also includes a small cleanup.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Pavel Machek <pavel@ucw.cz>
---
 drivers/block/nbd.c |   67 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/block/nbd.c
===================================================================
--- linux-2.6.orig/drivers/block/nbd.c	2006-09-07 17:20:52.000000000 +0200
+++ linux-2.6/drivers/block/nbd.c	2006-09-07 17:35:05.000000000 +0200
@@ -97,20 +97,24 @@ static const char *nbdcmd_to_ascii(int c
 }
 #endif /* NDEBUG */
 
-static void nbd_end_request(struct request *req)
+static void __nbd_end_request(struct request *req)
 {
 	int uptodate = (req->errors == 0) ? 1 : 0;
-	request_queue_t *q = req->q;
-	unsigned long flags;
 
 	dprintk(DBG_BLKDEV, "%s: request %p: %s\n", req->rq_disk->disk_name,
 			req, uptodate? "done": "failed");
 
-	spin_lock_irqsave(q->queue_lock, flags);
-	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
+	if (!end_that_request_first(req, uptodate, req->nr_sectors))
 		end_that_request_last(req, uptodate);
-	}
-	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
+static void nbd_end_request(struct request *req)
+{
+	request_queue_t *q = req->q;
+
+	spin_lock_irq(q->queue_lock);
+	__nbd_end_request(req);
+	spin_unlock_irq(q->queue_lock);
 }
 
 /*
@@ -435,10 +439,8 @@ static void do_nbd_request(request_queue
 			mutex_unlock(&lo->tx_lock);
 			printk(KERN_ERR "%s: Attempted send on closed socket\n",
 			       lo->disk->disk_name);
-			req->errors++;
-			nbd_end_request(req);
 			spin_lock_irq(q->queue_lock);
-			continue;
+			goto error_out;
 		}
 
 		lo->active_req = req;
@@ -463,10 +465,13 @@ static void do_nbd_request(request_queue
 
 error_out:
 		req->errors++;
-		spin_unlock(q->queue_lock);
-		nbd_end_request(req);
-		spin_lock(q->queue_lock);
+		__nbd_end_request(req);
 	}
+	/*
+	 * q->queue_lock has been dropped, this opens up a race
+	 * plug the device to close it.
+	 */
+	blk_plug_device(q);
 	return;
 }
 

--


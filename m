Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTFLADw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264620AbTFLADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:03:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32751 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264619AbTFLADs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:03:48 -0400
Subject: Re: 2.5.70-mm8: freeze after starting X
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
In-Reply-To: <1055374476.673.1.camel@localhost>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
Content-Type: text/plain
Message-Id: <1055377120.665.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 17:18:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 16:34, Robert Love wrote:

> I will debunk both theories: its not Radeon (I have a Matrox) and its
> not the pci-init-ordering-fix patch (I already tried that).

Ah, it is the anticipatory I/O scheduler.

There is a logic thinko somewhere... I have not found it yet, but I have
narrowed it down to something which the attached patch fixes (i.e.,
apply this patch and the problem is fixed).

Maybe Nick can see the bug and short circuit my search? The problem is
related to the as-autotune-write-batches patch.

	Robert Love


Fix system deadlock in 2.5.70-mm6 and beyond.

 drivers/block/as-iosched.c |   68 +++++++--------------------------------------
 1 files changed, 11 insertions(+), 57 deletions(-)


diff -urN linux-2.5.70-mm8/drivers/block/as-iosched.c linux/drivers/block/as-iosched.c
--- linux-2.5.70-mm8/drivers/block/as-iosched.c	2003-06-11 17:12:02.919110360 -0700
+++ linux/drivers/block/as-iosched.c	2003-06-11 17:05:59.000000000 -0700
@@ -52,7 +52,7 @@
  * See, the problem is: we can send a lot of writes to disk cache / TCQ in
  * a short amount of time...
  */
-#define default_write_batch_expire (HZ / 20)
+#define default_write_batch_expire (5)
 
 /*
  * max time we may wait to anticipate a read (default around 6ms)
@@ -135,9 +135,6 @@
 	unsigned long last_check_fifo[2];
 	int changed_batch;
 	int batch_data_dir;		/* current batch REQ_SYNC / REQ_ASYNC */
-	int write_batch_count;		/* max # of reqs in a write batch */
-	int current_write_count;	/* how many requests left this batch */
-	int write_batch_idled;		/* has the write batch gone idle? */
 	mempool_t *arq_pool;
 
 	enum anticipation_status antic_status;
@@ -938,35 +935,6 @@
 }
 
 /*
- * Gathers timings and resizes the write batch automatically
- */
-void update_write_batch(struct as_data *ad)
-{
-	unsigned long batch = ad->batch_expire[REQ_ASYNC];
-	long write_time;
-
-	write_time = (jiffies - ad->current_batch_expires) + batch;
-	if (write_time < 0)
-		write_time = 0;
-
-	if (write_time > batch + 5 && !ad->write_batch_idled) {
-		if (write_time / batch > 2)
-			ad->write_batch_count /= 2;
-		else
-			ad->write_batch_count--;
-		
-	} else if (write_time + 5 < batch && ad->current_write_count == 0) {
-		if (batch / write_time > 2)
-			ad->write_batch_count *= 2;
-		else
-			ad->write_batch_count++;
-	}
-
-	if (ad->write_batch_count < 1)
-		ad->write_batch_count = 1;
-}
-
-/*
  * as_completed_request is to be called when a request has completed and
  * returned something to the requesting process, be it an error or data.
  */
@@ -981,7 +949,8 @@
 		return;
 	}
 
-	WARN_ON(blk_fs_request(rq) && arq->state == AS_RQ_NEW);
+	if (blk_fs_request(rq) && arq->state == AS_RQ_NEW)
+		printk(KERN_INFO "warning: as_completed_request got bad request\n");
 				
 	if (arq->state != AS_RQ_DISPATCHED)
 		return;
@@ -999,7 +968,6 @@
 	 */
 	if (ad->batch_data_dir == REQ_SYNC && ad->changed_batch
 			&& ad->batch_data_dir == arq->is_sync) {
-		update_write_batch(ad);
 		ad->current_batch_expires = jiffies +
 				ad->batch_expire[REQ_SYNC];
 		ad->changed_batch = 0;
@@ -1151,11 +1119,10 @@
 		return 0;
 
 	if (ad->batch_data_dir == REQ_SYNC)
-		/* TODO! add a check so a complete fifo gets written? */
-		return time_after(jiffies, ad->current_batch_expires);
+		return time_after(jiffies, ad->current_batch_expires) &&
+		 	time_after(jiffies, ad->fifo_expire[REQ_SYNC]);
 
-	return time_after(jiffies, ad->current_batch_expires)
-		|| ad->current_write_count == 0;
+	return !ad->current_batch_expires;
 }
 
 /*
@@ -1187,9 +1154,8 @@
 			put_as_io_context(&ad->as_io_context);
 			ad->as_io_context = NULL;
 		}
-
-		if (ad->current_write_count != 0)
-			ad->current_write_count--;
+		if (ad->current_batch_expires)
+			ad->current_batch_expires--;
 	}
 	ad->aic_finished = 0;
 
@@ -1218,12 +1184,6 @@
 	const int reads = !list_empty(&ad->fifo_list[REQ_SYNC]);
 	const int writes = !list_empty(&ad->fifo_list[REQ_ASYNC]);
 
-	/* Signal that the write batch was uncontended, so we can't time it */
-	if (ad->batch_data_dir == REQ_ASYNC && !reads) {
-		if (ad->current_write_count == 0 || !writes)
-			ad->write_batch_idled = 1;
-	}
-	
 	if (!(reads || writes)
 		|| ad->antic_status == ANTIC_WAIT_REQ
 		|| ad->antic_status == ANTIC_WAIT_NEXT
@@ -1288,8 +1248,7 @@
  		if (ad->batch_data_dir == REQ_SYNC)
  			ad->changed_batch = 1;
 		ad->batch_data_dir = REQ_ASYNC;
-		ad->current_write_count = ad->write_batch_count;
-		ad->write_batch_idled = 0;
+		ad->current_batch_expires = ad->batch_expire[REQ_ASYNC];
 		arq = ad->next_arq[ad->batch_data_dir];
 		goto dispatch_request;
 	}
@@ -1311,11 +1270,9 @@
 	if (ad->changed_batch) {
 		if (ad->changed_batch == 1 && ad->nr_dispatched)
 			return 0;
-		if (ad->batch_data_dir == REQ_ASYNC) {
-			ad->current_batch_expires = jiffies +
-					ad->batch_expire[REQ_ASYNC];
+		if (ad->changed_batch == 1 && ad->batch_data_dir == REQ_ASYNC)
 			ad->changed_batch = 0;
-		} else
+		else
 			ad->changed_batch = 2;
 		arq->request->flags |= REQ_HARDBARRIER;
 	}
@@ -1727,9 +1684,6 @@
 	e->elevator_data = ad;
 
 	ad->current_batch_expires = jiffies + ad->batch_expire[REQ_SYNC];
-	ad->write_batch_count = ad->batch_expire[REQ_ASYNC] / 10;
-	if (ad->write_batch_count < 2)
-		ad->write_batch_count = 2;
 	return 0;
 }
 



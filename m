Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTKMKid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 05:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTKMKid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 05:38:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263698AbTKMKib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 05:38:31 -0500
Date: Thu, 13 Nov 2003 11:38:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: AS spin lock bugs
Message-ID: <20031113103823.GB4441@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Was looking at io tracking for cfq, and I think I found some spin lock
bugs in current as (current BK). as_update_iohist() runs from
add_request which is typically in process context. It could be run with
interrupts disabled though, either driver private stuff or using the
generic block layer tagging.

Anyways, as_update_iohist() grabs aic->lock without disabling
interrupts, while as_completed_request() typically runs at interrupt
time and grabs the same lock. Deadlock.

To be safe, both need to use the flags saving lock variants.

===== drivers/block/as-iosched.c 1.28 vs edited =====
--- 1.28/drivers/block/as-iosched.c	Mon Nov 10 06:12:07 2003
+++ edited/drivers/block/as-iosched.c	Thu Nov 13 11:37:47 2003
@@ -783,14 +783,14 @@
 {
 	struct as_rq *arq = RQ_DATA(rq);
 	int data_dir = arq->is_sync;
-	unsigned long thinktime;
+	unsigned long thinktime, flags;
 	sector_t seek_dist;
 
 	if (aic == NULL)
 		return;
 
 	if (data_dir == REQ_SYNC) {
-		spin_lock(&aic->lock);
+		spin_lock_irqsave(&aic->lock, flags);
 
 		if (test_bit(AS_TASK_IORUNNING, &aic->state)
 				&& !atomic_read(&aic->nr_queued)
@@ -844,7 +844,7 @@
 		aic->seek_total = (aic->seek_total>>1)
 					+ (aic->seek_total>>2);
 
-		spin_unlock(&aic->lock);
+		spin_unlock_irqrestore(&aic->lock, flags);
 	}
 }
 
@@ -909,6 +909,7 @@
 	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 	struct as_io_context *aic;
+	unsigned long flags;
 
 	WARN_ON(!list_empty(&rq->queuelist));
 
@@ -959,12 +960,12 @@
 	if (!aic)
 		return;
 
-	spin_lock(&aic->lock);
+	spin_lock_irqsave(&aic->lock, flags);
 	if (arq->is_sync == REQ_SYNC) {
 		set_bit(AS_TASK_IORUNNING, &aic->state);
 		aic->last_end_request = jiffies;
 	}
-	spin_unlock(&aic->lock);
+	spin_unlock_irqrestore(&aic->lock, flags);
 
 	put_io_context(arq->io_context);
 }

-- 
Jens Axboe


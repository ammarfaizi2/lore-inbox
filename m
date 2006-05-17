Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWEQWMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWEQWMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWEQWML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:11 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7552 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751236AbWEQWME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:04 -0400
Message-Id: <20060517221408.232432000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:13 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jens Axboe <axboe@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/22] [PATCH] [BLOCK] limit request_fn recursion
Content-Disposition: inline; filename=BLOCK-limit-request_fn-recursion.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Don't recurse back into the driver even if the unplug threshold is met,
when the driver asks for a requeue. This is both silly from a logical
point of view (requeues typically happen due to driver/hardware
shortage), and also dangerous since we could hit an endless request_fn
-> requeue -> unplug -> request_fn loop and crash on stack overrun.

Also limit blk_run_queue() to one level of recursion, similar to how
blk_start_queue() works.

This patch fixed a real problem with SLES10 and lpfc, and it could hit
any SCSI lld that returns non-zero from it's ->queuecommand() handler.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 block/elevator.c  |    8 +++++++-
 block/ll_rw_blk.c |   17 +++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

--- linux-2.6.16.16.orig/block/elevator.c
+++ linux-2.6.16.16/block/elevator.c
@@ -314,6 +314,7 @@ void elv_insert(request_queue_t *q, stru
 {
 	struct list_head *pos;
 	unsigned ordseq;
+	int unplug_it = 1;
 
 	rq->q = q;
 
@@ -378,6 +379,11 @@ void elv_insert(request_queue_t *q, stru
 		}
 
 		list_add_tail(&rq->queuelist, pos);
+		/*
+		 * most requeues happen because of a busy condition, don't
+		 * force unplug of the queue for that case.
+		 */
+		unplug_it = 0;
 		break;
 
 	default:
@@ -386,7 +392,7 @@ void elv_insert(request_queue_t *q, stru
 		BUG();
 	}
 
-	if (blk_queue_plugged(q)) {
+	if (unplug_it && blk_queue_plugged(q)) {
 		int nrq = q->rq.count[READ] + q->rq.count[WRITE]
 			- q->in_flight;
 
--- linux-2.6.16.16.orig/block/ll_rw_blk.c
+++ linux-2.6.16.16/block/ll_rw_blk.c
@@ -1719,8 +1719,21 @@ void blk_run_queue(struct request_queue 
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	blk_remove_plug(q);
-	if (!elv_queue_empty(q))
-		q->request_fn(q);
+
+	/*
+	 * Only recurse once to avoid overrunning the stack, let the unplug
+	 * handling reinvoke the handler shortly if we already got there.
+	 */
+	if (!elv_queue_empty(q)) {
+		if (!test_and_set_bit(QUEUE_FLAG_REENTER, &q->queue_flags)) {
+			q->request_fn(q);
+			clear_bit(QUEUE_FLAG_REENTER, &q->queue_flags);
+		} else {
+			blk_plug_device(q);
+			kblockd_schedule_work(&q->unplug_work);
+		}
+	}
+
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL(blk_run_queue);

--

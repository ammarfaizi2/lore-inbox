Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVC2CyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVC2CyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVC2CyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:54:02 -0500
Received: from fmr24.intel.com ([143.183.121.16]:59848 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262160AbVC2Cxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:53:55 -0500
Message-Id: <200503290253.j2T2rqg25691@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] use cheaper elv_queue_empty when unplug a device
Date: Mon, 28 Mar 2005 18:53:49 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0Cogdblw5dczUTFy1c4/YC8HgbA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was posted last year and if I remember correctly, Jens said
he is OK with the patch.  In function __generic_unplug_deivce(), kernel
can use a cheaper function elv_queue_empty() instead of more expensive
elv_next_request to find whether the queue is empty or not. blk_run_queue
can also made conditional on whether queue's emptiness before calling
request_fn().


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.11/drivers/block/ll_rw_blk.c.orig	2005-03-28 18:22:26.000000000 -0800
+++ linux-2.6.11/drivers/block/ll_rw_blk.c	2005-03-28 18:44:46.000000000 -0800
@@ -1459,7 +1459,7 @@ void __generic_unplug_device(request_que
 	/*
 	 * was plugged, fire request_fn if queue has stuff to do
 	 */
-	if (elv_next_request(q))
+	if (!elv_queue_empty(q))
 		q->request_fn(q);
 }
 EXPORT_SYMBOL(__generic_unplug_device);
@@ -1589,7 +1589,8 @@ void blk_run_queue(struct request_queue

 	spin_lock_irqsave(q->queue_lock, flags);
 	blk_remove_plug(q);
-	q->request_fn(q);
+	if (!elv_queue_empty(q))
+		q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL(blk_run_queue);





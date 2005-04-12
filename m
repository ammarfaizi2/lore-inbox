Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVDLSxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVDLSxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVDLSvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:51:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:1226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262225AbVDLKcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:47 -0400
Message-Id: <200504121032.j3CAWe8M005649@shell0.pdx.osdl.net>
Subject: [patch 128/198] use cheaper elv_queue_empty when unplug a device
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, kenneth.w.chen@intel.com,
       axboe@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ken Chen <kenneth.w.chen@intel.com>

In function __generic_unplug_device(), kernel can use a cheaper function
elv_queue_empty() instead of more expensive elv_next_request to find
whether the queue is empty or not.  blk_run_queue can also made conditional
on whether queue's emptiness before calling request_fn().

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/block/ll_rw_blk.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/block/ll_rw_blk.c~use-cheaper-elv_queue_empty-when-unplug-a-device drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~use-cheaper-elv_queue_empty-when-unplug-a-device	2005-04-12 03:21:34.394908080 -0700
+++ 25-akpm/drivers/block/ll_rw_blk.c	2005-04-12 03:21:34.399907320 -0700
@@ -1589,7 +1589,8 @@ void blk_run_queue(struct request_queue 
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	blk_remove_plug(q);
-	q->request_fn(q);
+	if (!elv_queue_empty(q))
+		q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL(blk_run_queue);
_

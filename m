Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWHGNrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWHGNrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHGNrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:47:40 -0400
Received: from brick.kernel.dk ([62.242.22.158]:7272 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932082AbWHGNrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:47:39 -0400
Date: Mon, 7 Aug 2006 15:48:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20060807134841.GC10444@suse.de>
References: <200608061200.37701.mlkernel@mortal-soul.de> <20060806031512.57585f5d.akpm@osdl.org> <200608061554.42992.mlkernel@mortal-soul.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608061554.42992.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06 2006, Matthias Dahl wrote:
> > I'd suggest that you generate a kernel profile while the sluggishness is
> > happening.
> 
> Done...
> 
> profile 1: (emerge of three huge packages which caused quite some IO)

Can you see if this makes any difference whatsoever?

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 61d6b3c..ed6a30e 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3422,6 +3422,7 @@ #endif /* CONFIG_HOTPLUG_CPU */
 
 void blk_complete_request(struct request *req)
 {
+#if 0
 	struct list_head *cpu_list;
 	unsigned long flags;
 
@@ -3434,6 +3435,14 @@ void blk_complete_request(struct request
 	raise_softirq_irqoff(BLOCK_SOFTIRQ);
 
 	local_irq_restore(flags);
+#else
+	unsigned long flags;
+	request_queue_t *q = req->q;
+
+	local_irq_save(flags);
+	q->softirq_done_fn(req);
+	local_irq_restore(flags);
+#endif
 }
 
 EXPORT_SYMBOL(blk_complete_request);

-- 
Jens Axboe


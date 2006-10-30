Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161351AbWJ3Suh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbWJ3Suh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWJ3Suh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:50:37 -0500
Received: from brick.kernel.dk ([62.242.22.158]:34827 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161351AbWJ3Suf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:50:35 -0500
Date: Mon, 30 Oct 2006 19:52:14 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <liml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030185214.GH14055@kernel.dk>
References: <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk> <454644C1.4080702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454644C1.4080702@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Mark Lord wrote:
> (gdb) l *cfq_set_request+0x33e
> 0xc021780e is in cfq_set_request (block/cfq-iosched.c:1224).
> 1219            if (unlikely(!cfqd))
> 1220                    return;
> 1221
> 1222            spin_lock(cfqd->queue->queue_lock);
> 1223
> 1224            cfqq = cic->cfqq[ASYNC];
> 1225            if (cfqq) {
> 1226                    struct cfq_queue *new_cfqq;
> 1227                    new_cfqq = cfq_get_queue(cfqd, CFQ_KEY_ASYNC, 
> cic->ioc->task,
> 1228                                             GFP_ATOMIC);

Bingo, that's a lot better! So that's the real bug, I'm guessing this
got introduced when the ioprio stuff got juggled around recently. Pretty
straight forward, this should fix it for you.


diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index d3d7613..25c4e7e 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1215,11 +1215,12 @@ static inline void changed_ioprio(struct
 {
 	struct cfq_data *cfqd = cic->key;
 	struct cfq_queue *cfqq;
+	unsigned long flags;
 
 	if (unlikely(!cfqd))
 		return;
 
-	spin_lock(cfqd->queue->queue_lock);
+	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
 
 	cfqq = cic->cfqq[ASYNC];
 	if (cfqq) {
@@ -1236,7 +1237,7 @@ static inline void changed_ioprio(struct
 	if (cfqq)
 		cfq_mark_cfqq_prio_changed(cfqq);
 
-	spin_unlock(cfqd->queue->queue_lock);
+	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
 }
 
 static void cfq_ioc_set_ioprio(struct io_context *ioc)

-- 
Jens Axboe


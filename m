Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422812AbWA1CYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWA1CYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWA1CXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:23:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:62906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422812AbWA1CWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:55 -0500
Date: Fri, 27 Jan 2006 18:20:41 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       axboe@suse.de
Subject: [patch 02/12] [BLOCK] Kill blk_attempt_remerge()
Message-ID: <20060128022041.GC17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kill-blk_attempt_remerge.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Jens Axboe <axboe@suse.de>

[BLOCK] Kill blk_attempt_remerge()

It's a broken interface, it's done way too late. And apparently it triggers
slab problems in recent kernels as well (most likely after the generic dispatch
code was merged). So kill it, ide-cd is the only user of it.

chrisw: backport to 2.6.15 tree

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 block/ll_rw_blk.c      |   24 ------------------------
 drivers/ide/ide-cd.c   |   10 ----------
 include/linux/blkdev.h |    1 -
 3 files changed, 35 deletions(-)

--- linux-2.6.15.1.orig/block/ll_rw_blk.c
+++ linux-2.6.15.1/block/ll_rw_blk.c
@@ -2609,30 +2609,6 @@ static inline int attempt_front_merge(re
 	return 0;
 }
 
-/**
- * blk_attempt_remerge  - attempt to remerge active head with next request
- * @q:    The &request_queue_t belonging to the device
- * @rq:   The head request (usually)
- *
- * Description:
- *    For head-active devices, the queue can easily be unplugged so quickly
- *    that proper merging is not done on the front request. This may hurt
- *    performance greatly for some devices. The block layer cannot safely
- *    do merging on that first request for these queues, but the driver can
- *    call this function and make it happen any way. Only the driver knows
- *    when it is safe to do so.
- **/
-void blk_attempt_remerge(request_queue_t *q, struct request *rq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	attempt_back_merge(q, rq);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
-
-EXPORT_SYMBOL(blk_attempt_remerge);
-
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req;
--- linux-2.6.15.1.orig/drivers/ide/ide-cd.c
+++ linux-2.6.15.1/drivers/ide/ide-cd.c
@@ -1332,8 +1332,6 @@ static ide_startstop_t cdrom_start_read 
 	if (cdrom_read_from_buffer(drive))
 		return ide_stopped;
 
-	blk_attempt_remerge(drive->queue, rq);
-
 	/* Clear the local sector buffer. */
 	info->nsectors_buffered = 0;
 
@@ -1874,14 +1872,6 @@ static ide_startstop_t cdrom_start_write
 		return ide_stopped;
 	}
 
-	/*
-	 * for dvd-ram and such media, it's a really big deal to get
-	 * big writes all the time. so scour the queue and attempt to
-	 * remerge requests, often the plugging will not have had time
-	 * to do this properly
-	 */
-	blk_attempt_remerge(drive->queue, rq);
-
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. we don't need to check more, since we
--- linux-2.6.15.1.orig/include/linux/blkdev.h
+++ linux-2.6.15.1/include/linux/blkdev.h
@@ -559,7 +559,6 @@ extern void register_disk(struct gendisk
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
 extern void blk_end_sync_rq(struct request *rq);
-extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);

--

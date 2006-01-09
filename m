Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWAIK4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWAIK4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 05:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWAIK4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 05:56:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5477 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932181AbWAIK4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 05:56:16 -0500
Date: Mon, 9 Jan 2006 11:58:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15 cfq oops
Message-ID: <20060109105800.GT3389@suse.de>
References: <20060106201928.GI4595@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106201928.GI4595@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06 2006, Dave Jones wrote:
> Looks like some nice slab poison...
> 
> 		Dave
> 
> Oops: 0000 [#1]
> last sysfs file:
> /devices/pci0000:00/0000:00:1d.7/usb1/1-0:1.0/bAlternateSettingModules linked
> in: usb_storage ata_piix libata e1000 ohci1394 ieee1394 uhci_hcdsCPU:    0
> EIP:    0060:[<c01c312e>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.15-1.1819_FC5)
> EIP is at rb_next+0x9/0x22
> eax: 6b6b6b6b   ebx: dfed01f8   ecx: c01bf65a   edx: 6b6b6b6b
> esi: c1991e98   edi: 00000202   ebp: dfed403c   esp: c03c1f14
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c03c1000 task=c0327ba0)
> Stack: c01bf662 c01b5dfa dfed01f8 c01b85dc c040c284 00000004 c1991e98 c023c8ab
>        c1991e98 00000000 c040c284 00000000 c023d3a4 000194d0 00000000 dfed403c
>        c1991e98 c040c284 c1991e98 00000000 c0231f2d 000194d0 00000000 000194d0
> Call Trace:
>  [<c01bf662>] cfq_latter_request+0x8/0x14     [<c01b5dfa>] elv_latter_request+07
> [<c01b85dc>] blk_attempt_remerge+0x1d/0x3c     [<c023c8ab>] cdrom_start_read+0e
> [<c023d3a4>] ide_do_rw_cdrom+0xdd/0x14a     [<c0231f2d>] start_request+0x1b1/01
> [<c023220f>] ide_do_request+0x2a0/0x2fb     [<c023265e>] ide_intr+0xf3/0x11b
>  [<c023c1a7>] cdrom_read_intr+0x0/0x2a1     [<c013632a>] handle_IRQ_event+0x23/c
> [<c01363cd>] __do_IRQ+0x7a/0xcd     [<c01054d0>] do_IRQ+0x5c/0x77
>  =======================
>  [<c0103cea>] common_interrupt+0x1a/0x20     [<c0101120>] mwait_idle+0x1a/0x2e
>  [<c01010a3>] cpu_idle+0x38/0x4d     [<c0390635>] start_kernel+0x17a/0x17c
> Code: 85 c0 74 0b 8b 50 0c 85 d2 74 04 89 d0 eb f5 c3 8b 00 85 c0 74 0b 8b 50 0

The blk_attempt_remerge() is a bad interface to be honest, and it's hard
to get to work reliably because it's done too late. I think the best
option is just to kill it, this will cause problems with other io
schedulers as well.

I've merged this up for 2.6.16-rc inclusion, probably should go to
stabel as well.

---

[PATCH] Kill blk_attempt_remerge()

It's a bad interface, and it's always done too late. Remove it.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8e13645..c130519 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2748,30 +2748,6 @@ static inline int attempt_front_merge(re
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
 static void init_request_from_bio(struct request *req, struct bio *bio)
 {
 	req->flags |= REQ_CMD;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 1539603..2e44d81 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -426,7 +426,7 @@ int register_cdrom(struct cdrom_device_i
 		cdi->exit = cdrom_mrw_exit;
 
 	if (cdi->disk)
-		cdi->cdda_method = CDDA_BPC_FULL;
+		cdi->cdda_method = CDDA_BPC_SINGLE;
 	else
 		cdi->cdda_method = CDDA_OLD;
 
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index d31117e..e4d55ad 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 804cc4e..02a585f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -595,7 +595,6 @@ extern void generic_make_request(struct 
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(request_queue_t *, struct request *);
 extern void blk_end_sync_rq(struct request *rq, int error);
-extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);

-- 
Jens Axboe


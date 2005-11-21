Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVKUPir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVKUPir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVKUPir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:38:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45882 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932330AbVKUPiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:38:46 -0500
Date: Mon, 21 Nov 2005 16:39:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.14: Badness in as-iosched
Message-ID: <20051121153958.GF15804@suse.de>
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org> <4373C042.3060901@ens-lyon.org> <20051121145446.GA15804@suse.de> <4381E960.8070108@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4381E960.8070108@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21 2005, Brice Goglin wrote:
> Jens Axboe wrote:
> 
> >On Thu, Nov 10 2005, Brice Goglin wrote:
> >  
> >
> >>Hi Jens,
> >>
> >>I just hit a badness (actually, tons of badness like this) in as-iosched
> >>while ripping
> >>an audio CD with ripperX (with cdparanoia as a backend).
> >>I was using 2.6.14 on an IBM Thinkpad R52. The kernel has been compiled with
> >>gcc-4.0.2-2 (Debian testing).
> >>
> >>The first badness in dmesg is:
> >>
> >>cdrom: dropping to single frame dma
> >>arq->state: 4
> >>Badness in as_insert_request at drivers/block/as-iosched.c:1519
> >> [<c0237410>] as_insert_request+0x70/0x1d0
> >> [<c022dc25>] __elv_add_request+0xa5/0xe0
> >> [<c022dc8b>] elv_add_request+0x2b/0x40
> >> [<c0230fe6>] blk_execute_rq_nowait+0x46/0x60
> >> [<c023107a>] blk_execute_rq+0x7a/0xe0
> >> [<c0231310>] blk_end_sync_rq+0x0/0x30
> >> [<c0160b77>] bio_phys_segments+0x27/0x30
> >> [<c0232610>] blk_rq_bio_prep+0x40/0xb0
> >> [<c0230dc7>] blk_rq_map_user+0xb7/0xf0
> >> [<c026bc32>] cdrom_read_cdda_bpc+0x182/0x210
> >> [<c026bd1b>] cdrom_read_cdda+0x5b/0xc0
> >>    
> >>
> >
> >Similar case was posted yesterday (I realize yours is older, just missed
> >it the first time around), see my explanation here:
> >
> >http://lkml.org/lkml/2005/11/20/119
> >
> >And work-around below.
> >  
> >
> Thank you very much, Jens.
> Is this patch going to -stable ?

Probably just killing the 'as' printk is a lot better for -stable.

Signed-off-by: Jens Axboe <axboe@suse.de>

--- linux-2.6.14/drivers/block/as-iosched.c~	2005-11-21 16:38:36.000000000 +0100
+++ linux-2.6.14/drivers/block/as-iosched.c	2005-11-21 16:39:07.000000000 +0100
@@ -1513,13 +1513,8 @@
 	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-	if (arq) {
-		if (arq->state != AS_RQ_PRESCHED) {
-			printk("arq->state: %d\n", arq->state);
-			WARN_ON(1);
-		}
+	if (arq)
 		arq->state = AS_RQ_NEW;
-	}
 
 	/* barriers must flush the reorder queue */
 	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)

-- 
Jens Axboe


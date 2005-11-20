Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVKTVZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVKTVZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVKTVZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:25:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932103AbVKTVZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:25:57 -0500
Date: Sun, 20 Nov 2005 22:27:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14.2] Badness in as_insert_request at drivers/block/as-iosched.c:1519
Message-ID: <20051120212711.GQ25454@suse.de>
References: <20051120203603.GA12216@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120203603.GA12216@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20 2005, Luca wrote:
> Hi,
> while playing an audio CD with XMMS using digital audio extraction the
> kernel started flooding my logs (syslog writes my kernel logs synchronously)
> with the following message:
> 
>  cdrom: dropping to single frame dma
>  arq->state: 4
>  Badness in as_insert_request at drivers/block/as-iosched.c:1519
>   [<c0104027>] dump_stack+0x17/0x20
>   [<c0263b2c>] as_insert_request+0x5c/0x160
>   [<c025aa0a>] __elv_add_request+0x8a/0xc0
>   [<c025aa75>] elv_add_request+0x35/0x70
>   [<c025dc4b>] blk_execute_rq_nowait+0x3b/0x50
>   [<c025dcda>] blk_execute_rq+0x7a/0xb0
>   [<c028daad>] cdrom_read_cdda_bpc+0x14d/0x1b0

This is actually the 'as' request state detection being a little to
anxious, I think. The cdrom layer reuses the same request several times
instead of allocating/freeing it inside the loop, and 'as' barfs if the
request state isn't 'fresh' when it first sees the request after it has
completed once.

This should work around the issue in the cdrom layer, even though it
isn't actually buggy.

> This happens both with my DVD unit and the CD/RW unit. The cause may be
> a couple of skratches on the disk (my portable cd player is happy with
> it though) and the drives behave fine with other audio disks. In the
> dmesg there isn't any other error related to the cd (i.e. no medium
> errors...)

It just so happens to trigger there, because then you drop into single
frame dma mode which will iterate the loop several times per request
(which then exposes the bug).

> As workaround I'm using noop scheduler for the unit...

That'll do fine as well, of course.

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 1539603..7540d27 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2089,7 +2089,7 @@ static int cdrom_read_cdda_bpc(struct cd
 			       int lba, int nframes)
 {
 	request_queue_t *q = cdi->disk->queue;
-	struct request *rq;
+	struct request *rq = NULL;
 	struct bio *bio;
 	unsigned int len;
 	int nr, ret = 0;
@@ -2097,13 +2097,13 @@ static int cdrom_read_cdda_bpc(struct cd
 	if (!q)
 		return -ENXIO;
 
-	rq = blk_get_request(q, READ, GFP_KERNEL);
-	if (!rq)
-		return -ENOMEM;
-
 	cdi->last_sense = 0;
 
 	while (nframes) {
+		rq = blk_get_request(q, READ, GFP_KERNEL);
+		if (!rq)
+			return -ENOMEM;
+
 		nr = nframes;
 		if (cdi->cdda_method == CDDA_BPC_SINGLE)
 			nr = 1;
@@ -2151,9 +2151,13 @@ static int cdrom_read_cdda_bpc(struct cd
 		nframes -= nr;
 		lba += nr;
 		ubuf += len;
+		blk_put_request(rq);
+		rq = NULL;
 	}
 
-	blk_put_request(rq);
+	if (rq)
+		blk_put_request(rq);
+
 	return ret;
 }
 

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752539AbWAGOxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbWAGOxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbWAGOxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:53:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51986 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1752539AbWAGOxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:53:31 -0500
Date: Sat, 7 Jan 2006 15:55:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark v Wolher <trilight@ns666.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as_insert_request at drivers/block/as-iosched.c:1519
Message-ID: <20060107145520.GH3389@suse.de>
References: <43BFC3FF.5080908@ns666.com> <20060107143447.GF3389@suse.de> <43BFD54A.2080805@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BFD54A.2080805@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07 2006, Mark v Wolher wrote:
> Jens Axboe wrote:
> > On Sat, Jan 07 2006, Mark v Wolher wrote:
> > 
> >>Hiya all,
> >>
> >>I was just playing a cd as usual and i noticed suddenly the errors
> >>below, they repeated like 8 times.
> >>
> >>kernel: 2.6.14.5
> > 
> > 
> > Should be fixed in newer 2.6.14.x, and in 2.6.15.
> > 
> 
> Looks like it isn't :( , well in 2.6.14.5

Oh, indeed. 2.6.15 has it fixed though. For 2.6.14.5 you have two
choices:

1) Delete the warning from as-iosched.c. It's harmless, it doesn't
   indicate a bug in this case.

2) Apply this attached patch to prevent cdrom.c from reusing a request
   when doing single frame cdda dma.

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


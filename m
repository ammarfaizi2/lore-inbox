Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWCFWSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWCFWSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWCFWSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:18:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWCFWSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:18:21 -0500
Date: Mon, 6 Mar 2006 14:17:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
  <200603062136.17098.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, Jesper Juhl wrote:
> 
> Ok, booting a plain 2.6.16-rc5-mm2 kernel with the above being the
> only change made results in this :

Yeah. I'm not surprised. A real mode-sense shouldn't be even 64 bytes, 
much less 96, so it shouldn't have overflowed, and we had no indication of 
the corruption spreading past the one allocation anyway.

It did/does seem a bug, though, so worth checking.

So onward in our tireless battle. Does this patch make any difference for 
you? It does two things:

 - it clears the "->sense" buffer in blk_end_sync_rq() (since it won't be 
   valid any more: the request is gone)
 - it adds a BUG_ON() if we appear to have already done the sense fill on 
   SCSI IO completion, and do it again.

Now, I've not tried either of these, and the BUG_ON() in particular might 
be a false positive itself, but it might be worth testing.

		Linus

---
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 03d9c82..4351d34 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2637,6 +2637,7 @@ void blk_end_sync_rq(struct request *rq,
 	struct completion *waiting = rq->waiting;
 
 	rq->waiting = NULL;
+	rq->sense = NULL;
 	__blk_put_request(rq->q, rq);
 
 	/*
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 701a328..2b60769 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -961,6 +961,10 @@ void scsi_io_completion(struct scsi_cmnd
 		if (result) {
 			clear_errors = 0;
 			if (sense_valid && req->sense) {
+
+				/* Have we already filled the sense buffer? */
+				BUG_ON(req->sense_len);
+
 				/*
 				 * SG_IO wants current and deferred errors
 				 */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSG2Fvt>; Mon, 29 Jul 2002 01:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSG2Fvs>; Mon, 29 Jul 2002 01:51:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:388 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318032AbSG2Fvn>;
	Mon, 29 Jul 2002 01:51:43 -0400
Date: Mon, 29 Jul 2002 07:55:20 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Marcin Dalecki <dalecki@evision.ag>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729075520.C4445@suse.de>
References: <200207282013.g6SKDjg02769@localhost.localdomain> <20020729073746.A4437@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729073746.A4437@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29 2002, Jens Axboe wrote:
> On Sun, Jul 28 2002, James Bottomley wrote:
> > > You are right the
> > > > rq->flags &= REQ_QUEUED;
> > > > and the
> > > > if (blk_rq_tagged(rq))
> > > blk_queue_end_tag(q, rq);
> > > > should be just removed and things are fine.
> > > They only survive becouse they don't provide a tag for the request in
> > > first place.
> > > > Thanks for pointing it out.
> > 
> > 
> > Please don't remove this.
> > 
> > insert_special isn't just used to start new requests, it's also used to queue 
> > incoming requests that cannot be processed by the device (host adapter, 
> > queue_full etc.).
> > 
> > In this latter case, the tag is already begun, so it needs to go back with 
> > end_tag (we start a new tag when the device begins processing again).
> > 
> > I own up to introducing the &= REQ_QUEUED rubbish---I was just keeping the 
> > original  placement of the flag clearing code, but now we need to preserve 
> > whether the request was queued or not for the blk_rq_tagged check.  On 
> > reflection it would have been better just to set the flags to REQ_SPECIAL | 
> > REQ_BARRIER after the end tag code.
> 
> I think you are missing the point. The stuff should not be in the
> _generic_ blk_insert_request(). As I posted in my first reply to Martin,
> SCSI needs to clear the tag before calling blk_insert_request() if it
> needs to.

Here's the patch to fix it, btw. Linus, please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.509   -> 1.510  
#	drivers/block/ll_rw_blk.c	1.96    -> 1.97   
#	drivers/scsi/scsi_lib.c	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/29	axboe@burns.home.kernel.dk	1.510
# undo REQ_QUEUED breakage in recent blk_insert_request() introduction
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Jul 29 07:53:43 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Jul 29 07:53:43 2002
@@ -1253,7 +1253,7 @@
  *    host that is unable to accept a particular command.
  */
 void blk_insert_request(request_queue_t *q, struct request *rq,
-		int at_head, void *data)
+			int at_head, void *data)
 {
 	unsigned long flags;
 
@@ -1262,15 +1262,11 @@
 	 * must not attempt merges on this) and that it acts as a soft
 	 * barrier
 	 */
-	rq->flags &= REQ_QUEUED;
 	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
 
 	rq->special = data;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	/* If command is tagged, release the tag */
-	if(blk_rq_tagged(rq))
-		blk_queue_end_tag(q, rq);
 	_elv_add_request(q, rq, !at_head, 0);
 	q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Mon Jul 29 07:53:43 2002
+++ b/drivers/scsi/scsi_lib.c	Mon Jul 29 07:53:43 2002
@@ -74,6 +74,9 @@
 {
 	request_queue_t *q = &SCpnt->device->request_queue;
 
+	if (blk_rq_tagged(SCpnt->request))
+		blk_queue_end_tag(q, SCpnt->request);
+
 	blk_insert_request(q, SCpnt->request, at_head, SCpnt);
 	return 0;
 }
@@ -101,6 +104,9 @@
 int scsi_insert_special_req(Scsi_Request * SRpnt, int at_head)
 {
 	request_queue_t *q = &SRpnt->sr_device->request_queue;
+
+	if (blk_rq_tagged(SRpnt->sr_request))
+		blk_queue_end_tag(q, SRpnt->sr_request);
 
 	blk_insert_request(q, SRpnt->sr_request, at_head, SRpnt);
 	return 0;

-- 
Jens Axboe


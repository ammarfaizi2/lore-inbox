Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSG2Gac>; Mon, 29 Jul 2002 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318066AbSG2Gab>; Mon, 29 Jul 2002 02:30:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318062AbSG2Gaa>;
	Mon, 29 Jul 2002 02:30:30 -0400
Date: Mon, 29 Jul 2002 08:34:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Marcin Dalecki <dalecki@evision.ag>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729083409.D4445@suse.de>
References: <20020729075520.C4445@suse.de> <Pine.LNX.4.44.0207282319590.872-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207282319590.872-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28 2002, Linus Torvalds wrote:
> 
> 
> On Mon, 29 Jul 2002, Jens Axboe wrote:
> > >
> > > I think you are missing the point. The stuff should not be in the
> > > _generic_ blk_insert_request(). As I posted in my first reply to Martin,
> > > SCSI needs to clear the tag before calling blk_insert_request() if it
> > > needs to.
> >
> > Here's the patch to fix it, btw. Linus, please apply.
> 
> I can't apply this while I think it looks horribly broken.
> 
> Your patch makes scsi_lib call blk_queue_end_tag() without holding the
> queue spinlock.
> 
> Which looks horribly broken, since it _will_ corrupt the queues.
> 
> In fact, it looks about a million times more broken than the code that
> Martin submitted.
> 
> Please explain to me why I am wrong.

Duh yes, the locking is broken of course :/

Ok I'd rather just make a __blk_insert_request as well, and have SCSI
grab the lock itself.

> 		Linus
> 
> PS. I actually do tend to look as the patches I apply. Right now it looks
> like you're wrong, and Martin is right.

I think Martin's was wrong in concept, mine was wrong in implementation.

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
# blk_insert_request + REQ_QUEUED fixed
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Jul 29 08:33:16 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Jul 29 08:33:16 2002
@@ -1233,6 +1233,23 @@
 	return rq;
 }
 
+void __blk_insert_request(request_queue_t *q, struct request *rq,
+			  int at_head, void *data)
+{
+	/*
+	 * tell I/O scheduler that this isn't a regular read/write (ie it
+	 * must not attempt merges on this) and that it acts as a soft
+	 * barrier
+	 */
+	rq->flags &= REQ_QUEUED;
+	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
+
+	rq->special = data;
+
+	_elv_add_request(q, rq, !at_head, 0);
+	q->request_fn(q);
+}
+
 /**
  * blk_insert_request - insert a special request in to a request queue
  * @q:		request queue where request should be inserted
@@ -1253,24 +1270,11 @@
  *    host that is unable to accept a particular command.
  */
 void blk_insert_request(request_queue_t *q, struct request *rq,
-		int at_head, void *data)
+			int at_head, void *data)
 {
 	unsigned long flags;
 
-	/*
-	 * tell I/O scheduler that this isn't a regular read/write (ie it
-	 * must not attempt merges on this) and that it acts as a soft
-	 * barrier
-	 */
-	rq->flags &= REQ_QUEUED;
-	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
-
-	rq->special = data;
-
 	spin_lock_irqsave(q->queue_lock, flags);
-	/* If command is tagged, release the tag */
-	if(blk_rq_tagged(rq))
-		blk_queue_end_tag(q, rq);
 	_elv_add_request(q, rq, !at_head, 0);
 	q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
@@ -2125,6 +2129,7 @@
 EXPORT_SYMBOL(blk_get_request);
 EXPORT_SYMBOL(__blk_get_request);
 EXPORT_SYMBOL(blk_put_request);
+EXPORT_SYMBOL(__blk_insert_request);
 EXPORT_SYMBOL(blk_insert_request);
 
 EXPORT_SYMBOL(blk_queue_prep_rq);
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Mon Jul 29 08:33:16 2002
+++ b/drivers/scsi/scsi_lib.c	Mon Jul 29 08:33:16 2002
@@ -73,8 +73,15 @@
 int scsi_insert_special_cmd(Scsi_Cmnd * SCpnt, int at_head)
 {
 	request_queue_t *q = &SCpnt->device->request_queue;
+	unsigned long flags;
 
-	blk_insert_request(q, SCpnt->request, at_head, SCpnt);
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	if (blk_rq_tagged(SCpnt->request))
+		blk_queue_end_tag(q, SCpnt->request);
+
+	__blk_insert_request(q, SCpnt->request, at_head, SCpnt);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 	return 0;
 }
 
@@ -101,8 +108,15 @@
 int scsi_insert_special_req(Scsi_Request * SRpnt, int at_head)
 {
 	request_queue_t *q = &SRpnt->sr_device->request_queue;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	if (blk_rq_tagged(SRpnt->sr_request))
+		blk_queue_end_tag(q, SRpnt->sr_request);
 
-	blk_insert_request(q, SRpnt->sr_request, at_head, SRpnt);
+	__blk_insert_request(q, SRpnt->sr_request, at_head, SRpnt);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 	return 0;
 }
 

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSG2KkT>; Mon, 29 Jul 2002 06:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSG2KkT>; Mon, 29 Jul 2002 06:40:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54440 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314553AbSG2KkR>;
	Mon, 29 Jul 2002 06:40:17 -0400
Date: Mon, 29 Jul 2002 12:43:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Marcin Dalecki <dalecki@evision.ag>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729124351.C4861@suse.de>
References: <20020729083409.D4445@suse.de> <Pine.LNX.4.44.0207282352030.10092-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207282352030.10092-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28 2002, Linus Torvalds wrote:
> 
> 
> On Mon, 29 Jul 2002, Jens Axboe wrote:
> >
> > I think Martin's was wrong in concept, mine was wrong in implementation.
> 
> I don't understand why you think the concept is wrong. Right now all users
> clearly do want to free the tag on re-issue, and doing so clearly cleans
> up the code and avoids duplication.
> 
> So I still don't see the advantage of your patch, even once you've fixed
> the locking issue.

Ok... I had two issues with the patch. 1) it did

	rq->flags &= REQ_QUEUED;

which is just broken. 2) it combined the act of inserting back into the
block queue with clearing the tag associated with the request. #1 is
clearly a bug that should be fixed regardless of what we do. Right now,
yes, the only user of blk_insert_request (SCSI) needs the tag cleared. I
still don't think that's a reason to mingle the two different tasks into
one. Code duplication is not an argument, the two scsi_insert_* should
be folded into one. The only difference is SRpnt->sr_request vs
SCpnt->request after all.

> HOWEVER, if you really think that some future users might not want to have
> the tag played with, how about making the "at_head" thing a flags field,
> and letting people say so by having "INSERT_NOTAG" (and making the
> existing bit be INSERT_ATHEAD).
> 
> So then the SCSI users would look like
> 
> 	blk_insert_request(q, SRpnt->sr_request,
> 		at_head ? INSERT_ATHEAD : 0,
> 		SRpnt)
> 
> while your future non-tag user might do
> 
> 	blk_insert_request(q, newreq,
> 		INSERT_ATHEAD | INSERT_NOTAG,
> 		channel);
> 
> _without_ having that unnecessary code duplication.

*shrug* I guess we could do that. I don't see any immediate use beyond
at_head/back and tag clearing.

I'll back down, it's not a matter of life and death after all. Here's
the minimal patch that corrects the flag thing, and also makes
blk_insert_request() conform to kernel style. Are we all happy?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.509   -> 1.510  
#	drivers/block/ll_rw_blk.c	1.96    -> 1.97   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/29	axboe@burns.home.kernel.dk	1.510
# fix REQ_QUEUED clearing in blk_insert_request()
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Jul 29 12:42:43 2002
+++ b/drivers/block/ll_rw_blk.c	Mon Jul 29 12:42:43 2002
@@ -1253,7 +1253,7 @@
  *    host that is unable to accept a particular command.
  */
 void blk_insert_request(request_queue_t *q, struct request *rq,
-		int at_head, void *data)
+			int at_head, void *data)
 {
 	unsigned long flags;
 
@@ -1262,15 +1262,18 @@
 	 * must not attempt merges on this) and that it acts as a soft
 	 * barrier
 	 */
-	rq->flags &= REQ_QUEUED;
 	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
 
 	rq->special = data;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	/* If command is tagged, release the tag */
-	if(blk_rq_tagged(rq))
+
+	/*
+	 * If command is tagged, release the tag
+	 */
+	if (blk_rq_tagged(rq))
 		blk_queue_end_tag(q, rq);
+
 	_elv_add_request(q, rq, !at_head, 0);
 	q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);


-- 
Jens Axboe


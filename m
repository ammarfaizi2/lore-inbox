Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVDSXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVDSXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVDSXQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 19:16:25 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:13500 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261744AbVDSXPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 19:15:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=bVNY+xKVoCLqsfAuMT3YIgoX1rSb61sfRvh8e+ZiSJOKBJbqDhypxU54xhqCnEjAIrLgbRzXt02mie2JPZFt0rWPMiKkReRwreSa5aiwDa5rC+jCKWipbEv7rJ2po86NALICp+4+FVGZuWK21iHPnYVmLsqhkOVIPDtNdqxlp1Q=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419231435.D85F89C0@htj.dyndns.org>
In-Reply-To: <20050419231435.D85F89C0@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/05] scsi: make blk layer set REQ_SOFTBARRIER when a request is dispatched
Message-ID: <20050419231435.2DEBE102@htj.dyndns.org>
Date: Wed, 20 Apr 2005 08:15:44 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_blk_make_started_requests_ordered.patch

	Reordering already started requests is without any real
	benefit and causes problems if the request has its
	driver-specific resources allocated (as in SCSI).  This patch
	makes elv_next_request() set REQ_SOFTBARRIER automatically
	when a request is dispatched.

	As both as and cfq schedulers don't allow passing requeued
	requests, the only behavior change is that requests deferred
	by prep_fn won't be passed by other requests.  This change
	shouldn't cause any problem.  The only affected driver other
	than SCSI is i2o_block.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 elevator.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: scsi-reqfn-export/drivers/block/elevator.c
===================================================================
--- scsi-reqfn-export.orig/drivers/block/elevator.c	2005-04-20 08:13:01.000000000 +0900
+++ scsi-reqfn-export/drivers/block/elevator.c	2005-04-20 08:13:33.000000000 +0900
@@ -370,11 +370,11 @@ struct request *elv_next_request(request
 
 	while ((rq = __elv_next_request(q)) != NULL) {
 		/*
-		 * just mark as started even if we don't start it, a request
-		 * that has been delayed should not be passed by new incoming
-		 * requests
+		 * just mark as started even if we don't start it.
+		 * also, as a request that has been delayed should not
+		 * be passed by new incoming requests, set softbarrier.
 		 */
-		rq->flags |= REQ_STARTED;
+		rq->flags |= REQ_STARTED | REQ_SOFTBARRIER;
 
 		if (rq == q->last_merge)
 			q->last_merge = NULL;


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVDLKwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVDLKwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVDLKv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:51:59 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:48860 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262267AbVDLKdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=EMdVgcJOUdcivr8sYHgNX67UYbI9WuGvAupZeRBWK201V8B/k0/rD1fEbfdkHZhDQcUwuzODmLxd2LWnaOF8dmMBwVm7EtfYNWhVntmy2zJ403jebiLlZ0T6JORuZkHMp4Ul5rH9+UUEwU5v+a7BtQz+QiETdKXKXdL2aY04JQ4=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412103128.69172FEB@htj.dyndns.org>
In-Reply-To: <20050412103128.69172FEB@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove unnecessary scsi_wait_req_end_io()
Message-ID: <20050412103128.66BBB7B1@htj.dyndns.org>
Date: Tue, 12 Apr 2005 19:33:08 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_reqfn_remove_wait_req_end_io.patch

	As all requests are now terminated via scsi midlayer, we don't
	need to set end_io for special reqs, remove it.

	Note that scsi_kill_requests() still terminates requests using
	blk layer.  The path is circular-ref workaround and soon to be
	replaced, so ignore it for now.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |   11 -----------
 1 files changed, 11 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 19:27:55.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 19:27:56.000000000 +0900
@@ -260,16 +260,6 @@ static void scsi_wait_done(struct scsi_c
 		complete(req->waiting);
 }
 
-/* This is the end routine we get to if a command was never attached
- * to the request.  Simply complete the request without changing
- * rq_status; this will cause a DRIVER_ERROR. */
-static void scsi_wait_req_end_io(struct request *req)
-{
-	BUG_ON(!req->waiting);
-
-	complete(req->waiting);
-}
-
 void scsi_wait_req(struct scsi_request *sreq, const void *cmnd, void *buffer,
 		   unsigned bufflen, int timeout, int retries)
 {
@@ -277,7 +267,6 @@ void scsi_wait_req(struct scsi_request *
 	
 	sreq->sr_request->waiting = &wait;
 	sreq->sr_request->rq_status = RQ_SCSI_BUSY;
-	sreq->sr_request->end_io = scsi_wait_req_end_io;
 	scsi_do_req(sreq, cmnd, buffer, bufflen, scsi_wait_done,
 			timeout, retries);
 	wait_for_completion(&wait);


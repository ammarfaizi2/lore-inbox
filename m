Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVDKDsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVDKDsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDKDr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:47:28 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:43887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261691AbVDKDqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:46:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=GQlormIo9HS8yKeaD/qHqduFUvxUsgVGnlWvEdOo8vxZZ1sY1jJELLwiktXnSJG/k3MokgjgIOIKQXZpMc+C+v6c8JAY3ADGKKj13r8uKmrMukKWOKrJEFc8zX/EzPQyp5tRnFOQo2OKCrKbJ0FHq8ZV2Rb/K/LloRl/fXUBXQA=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050411034451.B75F3870@htj.dyndns.org>
In-Reply-To: <20050411034451.B75F3870@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 03/04] scsi: make scsi_requeue_request() use blk_requeue_request()
Message-ID: <20050411034451.6204E57B@htj.dyndns.org>
Date: Mon, 11 Apr 2005 12:45:52 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_scsi_REQ_SPECIAL_semantic_scsi_requeue_command.patch

	scsi_requeue_request() used to use blk_insert_request() for
	requeueing requests.  This behavior depends on the unobvious
	behavior of blk_insert_request() setting REQ_SPECIAL and
	REQ_SOFTBARRIER when requeueing.  This patch makes
	scsi_requeue_request() use blk_requeue_request() and
	explicitly set REQ_SOFTBARRIER.  As REQ_SPECIAL now means
	special requests, the flag is not set on requeue.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-11 12:27:07.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-11 12:27:08.000000000 +0900
@@ -483,8 +483,14 @@ static void scsi_run_queue(struct reques
  */
 static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 {
+	unsigned long flags;
+
 	cmd->request->flags &= ~REQ_DONTPREP;
-	blk_insert_request(q, cmd->request, 1, cmd, 1);
+	cmd->request->flags |= REQ_SOFTBARRIER;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, cmd->request);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	scsi_run_queue(q);
 }


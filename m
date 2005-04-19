Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVDSXS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVDSXS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 19:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDSXRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 19:17:03 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:62750 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261750AbVDSXQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 19:16:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=dnmNGJkbz0HZKCxdyZnAXSN5jKzAH+6Bjhalv7EXxESztLVbDFtkgihcep/5K2mr65H9xzaAULLQa3lAlXQ/L0N1+K4BW5+oqYxqA19YEdgf5mnBiMUxAcsDybAkszEC0E2EHtqgPLcC3PZQz74VRNAPIjxFKk9k/uILR+Y/gjg=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419231435.D85F89C0@htj.dyndns.org>
In-Reply-To: <20050419231435.D85F89C0@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 04/05] scsi: make scsi_requeue_request() use blk_requeue_request()
Message-ID: <20050419231435.177BB9D6@htj.dyndns.org>
Date: Wed, 20 Apr 2005 08:15:59 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_scsi_REQ_SPECIAL_semantic_scsi_requeue_command.patch

	scsi_requeue_request() used to use blk_insert_request() for
	requeueing requests.  This depends on the unobvious behavior
	of blk_insert_request() setting REQ_SPECIAL and
	REQ_SOFTBARRIER when requeueing.  This patch makes
	scsi_queue_insert() use blk_requeue_request().  As REQ_SPECIAL
	means special requests and REQ_SOFTBARRIER is automatically
	handled by blk layer now, no flag needs to be set.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-20 08:13:34.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-20 08:13:35.000000000 +0900
@@ -480,8 +480,13 @@ static void scsi_run_queue(struct reques
  */
 static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 {
+	unsigned long flags;
+
 	cmd->request->flags &= ~REQ_DONTPREP;
-	blk_insert_request(q, cmd->request, 1, cmd, 1);
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, cmd->request);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	scsi_run_queue(q);
 }


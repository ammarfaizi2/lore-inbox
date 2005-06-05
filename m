Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFEF7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFEF7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 01:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFEF7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 01:59:01 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:43252 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261464AbVFEF5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=rJRnk95HywKw8nEJkmSiABBRVWtvKZRV+2RgSuPbm0ZExYGN0aWDD+DSFn5Yg2lmGhz8a/C9OkiNms2y5v6NhVVjxaUL8TsAOGZv7NMBxJO8NsuDszNjHQPLL8NQIajXhG85y2pJg8lq3pYVKSIOLZWbNQsDjSdpGDIPEAHiEhE=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 03/09] blk: make ide use -EOPNOTSUPP instead of -EIO on ABRT_ERR
Message-ID: <20050605055337.D65503EC@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_blk_ide_eopnotsupp.patch

	Use -EOPNOTSUPP instead of -EIO on ABRT_ERR.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-io.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: blk-fixes/drivers/ide/ide-io.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-io.c	2005-06-05 14:53:32.000000000 +0900
+++ blk-fixes/drivers/ide/ide-io.c	2005-06-05 14:53:33.000000000 +0900
@@ -305,6 +305,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
+	int uptodate;
 
 	spin_lock_irqsave(&ide_lock, flags);
 	rq = HWGROUP(drive)->rq;
@@ -379,7 +380,10 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
 	rq->errors = err;
-	end_that_request_last(rq, !rq->errors);
+	uptodate = 1;
+	if (err)
+		uptodate = err & ABRT_ERR ? -EOPNOTSUPP : -EIO;
+	end_that_request_last(rq, uptodate);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 


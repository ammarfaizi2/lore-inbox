Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWBJSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWBJSXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWBJSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:23:34 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:57866 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751305AbWBJSXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:23:33 -0500
Date: Fri, 10 Feb 2006 19:23:24 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.15.4
Message-Id: <20060210192324.0af51931.khali@linux-fr.org>
In-Reply-To: <20060210081720.GG30803@sorel.sous-sol.org>
References: <20060210081552.GF30803@sorel.sous-sol.org>
	<20060210081720.GG30803@sorel.sous-sol.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, all,

> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1534,11 +1534,6 @@ struct request_queue *scsi_alloc_queue(s
>  	 */
>  	if (shost->ordered_tag)
>  		blk_queue_ordered(q, QUEUE_ORDERED_TAG);
> -	else if (shost->ordered_flush) {
> -		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
> -		q->prepare_flush_fn = scsi_prepare_flush_fn;
> -		q->end_flush_fn = scsi_end_flush_fn;
> -	}
>  
>  	if (!shost->use_clustering)
>  		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);

This change causes the following warnings:
drivers/scsi/scsi_lib.c:1035: warning: `scsi_prepare_flush_fn' defined but not used
drivers/scsi/scsi_lib.c:1050: warning: `scsi_end_flush_fn' defined but not used
Following patch fixes this.

Thanks.

* * * * *

Fix the following warnings introduced by stable patch 2.6.15.4:

drivers/scsi/scsi_lib.c:1035: warning: `scsi_prepare_flush_fn' defined but not used
drivers/scsi/scsi_lib.c:1050: warning: `scsi_end_flush_fn' defined but not used

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/scsi/scsi_lib.c |   32 --------------------------------
 1 file changed, 32 deletions(-)

--- linux-2.6.15.4.orig/drivers/scsi/scsi_lib.c	2006-02-10 18:50:46.000000000 +0100
+++ linux-2.6.15.4/drivers/scsi/scsi_lib.c	2006-02-10 19:14:57.000000000 +0100
@@ -1031,38 +1031,6 @@
 	return BLKPREP_KILL;
 }
 
-static int scsi_prepare_flush_fn(request_queue_t *q, struct request *rq)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct scsi_driver *drv;
-
-	if (sdev->sdev_state == SDEV_RUNNING) {
-		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
-
-		if (drv->prepare_flush)
-			return drv->prepare_flush(q, rq);
-	}
-
-	return 0;
-}
-
-static void scsi_end_flush_fn(request_queue_t *q, struct request *rq)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct request *flush_rq = rq->end_io_data;
-	struct scsi_driver *drv;
-
-	if (flush_rq->errors) {
-		printk("scsi: barrier error, disabling flush support\n");
-		blk_queue_ordered(q, QUEUE_ORDERED_NONE);
-	}
-
-	if (sdev->sdev_state == SDEV_RUNNING) {
-		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
-		drv->end_flush(q, rq);
-	}
-}
-
 static int scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
 			       sector_t *error_sector)
 {


-- 
Jean Delvare

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVCaJUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVCaJUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCaJT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:19:58 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:61743 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261245AbVCaJIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=JwZyzodtIOm+P1DsqUlyq4qcupHmcyx9W7Zxac5tvnrs5P9aPYRcihh45mZi/cTSToTX50MzARIzYw0yMplLqdlWKfwOir2RFXk1iSGnVrK9DOWIzhwZL3Ur2gHrlp7Fo0XszgBxlS7k/dzRoW/LRt5SrLDSnM9qydXd2Kf/POk=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050331090647.FEDC3964@htj.dyndns.org>
In-Reply-To: <20050331090647.FEDC3964@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 07/13] scsi: move error handling out of scsi_init_io() into scsi_prep_fn()
Message-ID: <20050331090647.79DF3B09@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:08:25 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_scsi_consolidate_prep_fn_error_handling.patch

	When scsi_init_io() returns BLKPREP_DEFER or BLKPREP_KILL,
	it's supposed to free resources itself.  This patch
	consolidates defer and kill handling into scsi_prep_fn().
	This fixes a queue stall bug which occurred when sgtable
	allocation failed and device_busy == 0.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

Index: scsi-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-export.orig/drivers/scsi/scsi_lib.c	2005-03-31 18:06:21.000000000 +0900
+++ scsi-export/drivers/scsi/scsi_lib.c	2005-03-31 18:06:21.000000000 +0900
@@ -960,9 +960,6 @@ static int scsi_init_io(struct scsi_cmnd
 	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", req->nr_sectors,
 			req->current_nr_sectors);
 
-	/* release the command and kill it */
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
 	return BLKPREP_KILL;
 }
 
@@ -1130,18 +1127,17 @@ static int scsi_prep_fn(struct request_q
 		 * required).
 		 */
 		ret = scsi_init_io(cmd);
-		if (ret)	/* BLKPREP_KILL return also releases the command */
-			return ret;
-		
+		if (ret == BLKPREP_DEFER)
+			goto defer;
+		else if (ret == BLKPREP_KILL)
+			goto kill;
+
 		/*
 		 * Initialize the actual SCSI command for this request.
 		 */
 		drv = *(struct scsi_driver **)req->rq_disk->private_data;
-		if (unlikely(!drv->init_command(cmd))) {
-			scsi_release_buffers(cmd);
-			scsi_put_command(cmd);
-			return BLKPREP_KILL;
-		}
+		if (unlikely(!drv->init_command(cmd)))
+			goto kill;
 	}
 
 	/*
@@ -1157,6 +1153,11 @@ static int scsi_prep_fn(struct request_q
 	if (sdev->device_busy == 0)
 		blk_plug_device(q);
 	return BLKPREP_DEFER;
+
+ kill:
+	scsi_release_buffers(cmd);
+	scsi_put_command(cmd);
+	return BLKPREP_KILL;
 }
 
 /*


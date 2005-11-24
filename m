Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVKXQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVKXQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKXQ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:26:35 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:44907 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751380AbVKXQ0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:26:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=rlDU2JxwfG7BWjdf0MsCyv5TTcRZzq76gvgWfhRTR/u0dMlELPrDvkk5tOCfptUUn912ru9+JS0BksBIfGoSi2EOqZTBU31IQjvi3eyDYBKgEaKFOr5s4zClx3sNWBQWRR6q0R2u3TfNoM2dIoy1QPvNZTjgL2GTQEaxKyY7Lj4=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051124162449.209CADD5@htj.dyndns.org>
In-Reply-To: <20051124162449.209CADD5@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 05/11] blk: add FUA support to SCSI disk
Message-ID: <20051124162449.2344C13A@htj.dyndns.org>
Date: Fri, 25 Nov 2005 01:26:06 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_blk_scsi-add-fua-support.patch

	Add FUA support to SCSI disk.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sd.c |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

Index: work/drivers/scsi/sd.c
===================================================================
--- work.orig/drivers/scsi/sd.c	2005-11-25 00:52:02.000000000 +0900
+++ work/drivers/scsi/sd.c	2005-11-25 00:52:02.000000000 +0900
@@ -102,6 +102,7 @@ struct scsi_disk {
 	u8		write_prot;
 	unsigned	WCE : 1;	/* state of disk WCE bit */
 	unsigned	RCD : 1;	/* state of disk RCD bit, unused */
+	unsigned	DPOFUA : 1;	/* state of disk DPOFUA bit */
 };
 
 static DEFINE_IDR(sd_index_idr);
@@ -357,6 +358,7 @@ static int sd_init_command(struct scsi_c
 	
 	if (block > 0xffffffff) {
 		SCpnt->cmnd[0] += READ_16 - READ_6;
+		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
 		SCpnt->cmnd[2] = sizeof(block) > 4 ? (unsigned char) (block >> 56) & 0xff : 0;
 		SCpnt->cmnd[3] = sizeof(block) > 4 ? (unsigned char) (block >> 48) & 0xff : 0;
 		SCpnt->cmnd[4] = sizeof(block) > 4 ? (unsigned char) (block >> 40) & 0xff : 0;
@@ -376,6 +378,7 @@ static int sd_init_command(struct scsi_c
 			this_count = 0xffff;
 
 		SCpnt->cmnd[0] += READ_10 - READ_6;
+		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
 		SCpnt->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
 		SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
 		SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
@@ -384,6 +387,17 @@ static int sd_init_command(struct scsi_c
 		SCpnt->cmnd[7] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[8] = (unsigned char) this_count & 0xff;
 	} else {
+		if (unlikely(blk_fua_rq(rq))) {
+			/*
+			 * This happens only if this drive failed
+			 * 10byte rw command with ILLEGAL_REQUEST
+			 * during operation and thus turned off
+			 * use_10_for_rw.
+			 */
+			printk(KERN_ERR "sd: FUA write on READ/WRITE(6) drive\n");
+			return 0;
+		}
+
 		SCpnt->cmnd[1] |= (unsigned char) ((block >> 16) & 0x1f);
 		SCpnt->cmnd[2] = (unsigned char) ((block >> 8) & 0xff);
 		SCpnt->cmnd[3] = (unsigned char) block & 0xff;
@@ -1409,10 +1423,18 @@ sd_read_cache_type(struct scsi_disk *sdk
 			sdkp->RCD = 0;
 		}
 
+		sdkp->DPOFUA = (data.device_specific & 0x10) != 0;
+		if (sdkp->DPOFUA && !sdkp->device->use_10_for_rw) {
+			printk(KERN_NOTICE "SCSI device %s: uses "
+			       "READ/WRITE(6), disabling FUA\n", diskname);
+			sdkp->DPOFUA = 0;
+		}
+
 		ct =  sdkp->RCD + 2*sdkp->WCE;
 
-		printk(KERN_NOTICE "SCSI device %s: drive cache: %s\n",
-		       diskname, types[ct]);
+		printk(KERN_NOTICE "SCSI device %s: drive cache: %s%s\n",
+		       diskname, types[ct],
+		       sdkp->DPOFUA ? " w/ FUA" : "");
 
 		return;
 	}
@@ -1491,7 +1513,8 @@ static int sd_revalidate_disk(struct gen
 	 * QUEUE_ORDERED_TAG_* even when ordered tag is supported.
 	 */
 	if (sdkp->WCE)
-		ordered = QUEUE_ORDERED_DRAIN_FLUSH;
+		ordered = sdkp->DPOFUA
+			? QUEUE_ORDERED_DRAIN_FUA : QUEUE_ORDERED_DRAIN_FLUSH;
 	else
 		ordered = QUEUE_ORDERED_DRAIN;
 


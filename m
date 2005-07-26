Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVGZQzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVGZQzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVGZPrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:36 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:36736 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261872AbVGZPqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Leqn15QxrBRJ5nGN843t6FTSlSEzFoVa0XuDMLWKldq7wjblAM5VVBpy6zHZJRMBqtk5kLRKPK6TMU/CM086TAaBAXM0ReI55XDx8fUwXiHIJw81s4NXMLd8A42iwucndZtzgCdMxMnBMUeNVYyPX+nai8OiD/gNsZeXHqLYsus=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 05/10] blk: add FUA support to SCSI disk
Message-ID: <20050726154457.A3DFCA04@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:16 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_blk_scsi-add-fua-support.patch

	Add FUA support to SCSI disk.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sd.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

Index: blk-fixes/drivers/scsi/sd.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sd.c	2005-07-27 00:44:51.000000000 +0900
+++ blk-fixes/drivers/scsi/sd.c	2005-07-27 00:44:51.000000000 +0900
@@ -103,6 +103,7 @@ struct scsi_disk {
 	u8		write_prot;
 	unsigned	WCE : 1;	/* state of disk WCE bit */
 	unsigned	RCD : 1;	/* state of disk RCD bit, unused */
+	unsigned	DPOFUA : 1;	/* state of disk DPOFUA bit */
 };
 
 static DEFINE_IDR(sd_index_idr);
@@ -343,6 +344,7 @@ static int sd_init_command(struct scsi_c
 	
 	if (block > 0xffffffff) {
 		SCpnt->cmnd[0] += READ_16 - READ_6;
+		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
 		SCpnt->cmnd[2] = sizeof(block) > 4 ? (unsigned char) (block >> 56) & 0xff : 0;
 		SCpnt->cmnd[3] = sizeof(block) > 4 ? (unsigned char) (block >> 48) & 0xff : 0;
 		SCpnt->cmnd[4] = sizeof(block) > 4 ? (unsigned char) (block >> 40) & 0xff : 0;
@@ -362,6 +364,7 @@ static int sd_init_command(struct scsi_c
 			this_count = 0xffff;
 
 		SCpnt->cmnd[0] += READ_10 - READ_6;
+		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
 		SCpnt->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
 		SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
 		SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
@@ -370,6 +373,17 @@ static int sd_init_command(struct scsi_c
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
 		if (this_count > 0xff)
 			this_count = 0xff;
 
@@ -1399,10 +1413,18 @@ sd_read_cache_type(struct scsi_disk *sdk
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
@@ -1489,7 +1511,8 @@ static int sd_revalidate_disk(struct gen
 	 * QUEUE_ORDERED_TAG_* even when ordered tag is supported.
 	 */
 	if (sdkp->WCE)
-		ordered = QUEUE_ORDERED_DRAIN_FLUSH;
+		ordered = sdkp->DPOFUA
+			? QUEUE_ORDERED_DRAIN_FUA : QUEUE_ORDERED_DRAIN_FLUSH;
 	else
 		ordered = QUEUE_ORDERED_DRAIN;
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTLQQsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTLQQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:48:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19851 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264463AbTLQQse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:48:34 -0500
Date: Wed, 17 Dec 2003 17:48:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Voegtle <thomas@voegtle-clan.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Message-ID: <20031217164832.GA2495@suse.de>
References: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17 2003, Thomas Voegtle wrote:
> 
> Hello,
>   
> cdrecord -dev=ATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows this:
>   
> scsibus0:
>         0,0,0     0) '' '' '' NON CCS Disk
>         0,1,0     1) '' '' '' NON CCS Disk
> 
>   
> but this works well with 2.6.0-test11.
> =>
>   
>         0,0,0     0) 'CREATIVE' ' CD5233E        ' '2.05' Removable CD-ROM
>         0,1,0     1) 'PLEXTOR ' 'CD-R   PX-W1610A' '1.04' Removable CD-ROM
>   
> SuSE 9.0

Apply this to test11-bkLATEST

===== drivers/block/scsi_ioctl.c 1.38 vs edited =====
--- 1.38/drivers/block/scsi_ioctl.c	Thu Dec 11 18:55:17 2003
+++ edited/drivers/block/scsi_ioctl.c	Wed Dec 17 13:49:40 2003
@@ -150,13 +150,10 @@
 	struct request *rq;
 	struct bio *bio;
 	char sense[SCSI_SENSE_BUFFERSIZE];
-	unsigned char cdb[BLK_MAX_CDB];
 	void *buffer;
 
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
-	if (hdr->cmd_len > sizeof(rq->cmd))
-		return -EINVAL;
 
 	/*
 	 * we'll do that later
@@ -167,9 +164,6 @@
 	if (hdr->dxfer_len > (q->max_sectors << 9))
 		return -EIO;
 
-	if (copy_from_user(cdb, hdr->cmdp, hdr->cmd_len))
-		return -EFAULT;
-
 	reading = writing = 0;
 	buffer = NULL;
 	bio = NULL;
@@ -220,7 +214,7 @@
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr->cmd_len;
-	memcpy(rq->cmd, cdb, hdr->cmd_len);
+	memcpy(rq->cmd, hdr->cmdp, hdr->cmd_len);
 	if (sizeof(rq->cmd) != hdr->cmd_len)
 		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
 
@@ -436,12 +430,23 @@
 			break;
 		case SG_IO: {
 			struct sg_io_hdr hdr;
+			unsigned char cdb[BLK_MAX_CDB], *old_cdb;
 
-			if (copy_from_user(&hdr, (struct sg_io_hdr *) arg, sizeof(hdr))) {
-				err = -EFAULT;
+			err = -EFAULT;
+			if (copy_from_user(&hdr, (struct sg_io_hdr *) arg, sizeof(hdr)))
 				break;
-			}
+			err = -EINVAL;
+			if (hdr.cmd_len > sizeof(rq->cmd))
+				break;
+			err = -EFAULT;
+			if (copy_from_user(cdb, hdr.cmdp, hdr.cmd_len))
+				break;
+
+			old_cdb = hdr.cmdp;
+			hdr.cmdp = cdb;
 			err = sg_io(q, bdev, &hdr);
+
+			hdr.cmdp = old_cdb;
 			if (copy_to_user((struct sg_io_hdr *) arg, &hdr, sizeof(hdr)))
 				err = -EFAULT;
 			break;

-- 
Jens Axboe


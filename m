Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWBBRaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWBBRaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWBBRaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:30:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:64204 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932187AbWBBR37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:29:59 -0500
Message-Id: <200602021729.k12HTtmg018944@d03av02.boulder.ibm.com>
Subject: [PATCH 1/1] blk: Fix SG_IO ioctl failure retry looping
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       brking@us.ibm.com
From: Brian King <brking@us.ibm.com>
Date: Thu, 02 Feb 2006 11:29:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When issuing an SG_IO ioctl through sd that resulted
in an unrecoverable error, a nearly infinite retry loop
was discovered. This is due to the fact that the block
layer SG_IO code is not setting up rq->retries. This
patch also fixes up the sg_scsi_ioctl path.


Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6-bjking1/block/scsi_ioctl.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN block/scsi_ioctl.c~scsi_ioctl_retries block/scsi_ioctl.c
--- linux-2.6/block/scsi_ioctl.c~scsi_ioctl_retries	2006-02-02 11:07:50.000000000 -0600
+++ linux-2.6-bjking1/block/scsi_ioctl.c	2006-02-02 11:09:11.000000000 -0600
@@ -309,6 +309,7 @@ static int sg_io(struct file *file, requ
 		rq->timeout = q->sg_timeout;
 	if (!rq->timeout)
 		rq->timeout = BLK_DEFAULT_TIMEOUT;
+	rq->retries = 0;
 
 	start_time = jiffies;
 
@@ -427,6 +428,7 @@ static int sg_scsi_ioctl(struct file *fi
 	rq->data = buffer;
 	rq->data_len = bytes;
 	rq->flags |= REQ_BLOCK_PC;
+	rq->retries = 0;
 
 	blk_execute_rq(q, bd_disk, rq, 0);
 	err = rq->errors & 0xff;	/* only 8 bit SCSI status */
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTI2HvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTI2HvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:51:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59049 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262864AbTI2HvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:51:04 -0400
Date: Mon, 29 Sep 2003 09:51:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Kernel Developer List <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: error in drivers/block/scsi_ioctl.c and ll_rw_block.c?
Message-ID: <20030929075105.GO15415@suse.de>
References: <20030928160238.A18507@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928160238.A18507@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28 2003, Matthew Dharm wrote:
> While working on usb-storage (a virtual SCSI HBA), I noticed that the
> command 'eject /dev/scd0' sent a START_STOP command to the device with the
> data direction set to SCSI_DATA_WRITE but a transfer length of zero.  This
> causes a problem for some code paths.
> 
> For clarity, the START_STOP command doesn't want to move any data at all.
> 
> It looks to me like the error is a combination of
> drivers/block/scsi_ioctl.c and ll_rw_block.c
> 
> scsi_ioctl.c calls blk_get_request(q, WRITE, __GFP_WAIT) to allocate the
> request -- specifying WRITE here is one problem.
> 
> In ll_rw_block.c, blk_get_request() calls BUG_ON(rq != READ && rw != WRITE)
> -- in other words, it can only allocate a request for reading or writing,
> but not for no data.  I'm not familiar with this code, but it looks like
> requests are tracked by data direction, so making this accept NONE may be
> difficult.
> 
> One possible solution may be to re-write the CDROMEJECT ioctl into a call
> to sg_scsi_ioctl(), but that doesn't fix the general problem with
> ll_rw_block.c -- if, indeed, that is a problem.

No it's not a problem, clearly the request doesn't want to move any data
if rq->data_len == 0.

===== drivers/scsi/sr.c 1.93 vs edited =====
--- 1.93/drivers/scsi/sr.c	Fri Sep  5 13:31:51 2003
+++ edited/drivers/scsi/sr.c	Mon Sep 29 09:49:43 2003
@@ -289,12 +289,12 @@
 			return 0;
 
 		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-		if (rq_data_dir(rq) == WRITE)
+		if (!rq->data_len)
+			SCpnt->sc_data_direction = SCSI_DATA_NONE;
+		else if (rq_data_dir(rq) == WRITE)
 			SCpnt->sc_data_direction = SCSI_DATA_WRITE;
-		else if (rq->data_len)
+		else (rq->data_len)
 			SCpnt->sc_data_direction = SCSI_DATA_READ;
-		else
-			SCpnt->sc_data_direction = SCSI_DATA_NONE;
 
 		this_count = rq->data_len;
 		if (rq->timeout)

-- 
Jens Axboe


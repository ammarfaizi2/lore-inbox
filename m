Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272537AbRIPQzT>; Sun, 16 Sep 2001 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272547AbRIPQzK>; Sun, 16 Sep 2001 12:55:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1287 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S272537AbRIPQzB>;
	Sun, 16 Sep 2001 12:55:01 -0400
Date: Sun, 16 Sep 2001 18:55:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: lkml@krimedawg.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: OOPS in scsi generic stuff 2.4.10-pre6
Message-ID: <20010916185522.D9006@suse.de>
In-Reply-To: <3BA4CB70.50B4A3AB@torque.net> <20010916182208.B9006@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010916182208.B9006@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16 2001, Jens Axboe wrote:
> It looks like a race in that sg_cmd_done_bh can be completed before
> generic_unplug_device is called (and thus on a free'd scsi request). We
> then pass an invalid queue to generic_unplug_device.

(corrected version, scsi_allocate_request can of course fail)

--- drivers/scsi/sg.c~	Sun Sep 16 18:17:20 2001
+++ drivers/scsi/sg.c	Sun Sep 16 18:53:38 2001
@@ -645,6 +645,7 @@
     Scsi_Request        * SRpnt;
     Sg_device           * sdp = sfp->parentdp;
     sg_io_hdr_t         * hp = &srp->header;
+    request_queue_t	* q;
 
     srp->data.cmd_opcode = cmnd[0];  /* hold opcode of command */
     hp->status = 0;
@@ -680,6 +681,7 @@
     }
 
     srp->my_cmdp = SRpnt;
+    q = &SRpnt->sr_device->request_queue;
     SRpnt->sr_request.rq_dev = sdp->i_rdev;
     SRpnt->sr_request.rq_status = RQ_ACTIVE;
     SRpnt->sr_sense_buffer[0] = 0;
@@ -715,7 +717,7 @@
 		(void *)SRpnt->sr_buffer, hp->dxfer_len,
 		sg_cmd_done_bh, timeout, SG_DEFAULT_RETRIES);
     /* dxfer_len overwrites SRpnt->sr_bufflen, hence need for b_malloc_len */
-    generic_unplug_device(&SRpnt->sr_device->request_queue);
+    generic_unplug_device(q);
     return 0;
 }
 
-- 
Jens Axboe


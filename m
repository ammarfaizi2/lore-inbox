Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272429AbRIPQWO>; Sun, 16 Sep 2001 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272418AbRIPQVz>; Sun, 16 Sep 2001 12:21:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20742 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S272404AbRIPQVu>;
	Sun, 16 Sep 2001 12:21:50 -0400
Date: Sun, 16 Sep 2001 18:22:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: lkml@krimedawg.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: OOPS in scsi generic stuff 2.4.10-pre6
Message-ID: <20010916182208.B9006@suse.de>
In-Reply-To: <3BA4CB70.50B4A3AB@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA4CB70.50B4A3AB@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16 2001, Douglas Gilbert wrote:
> lkml@krimedawg.org <<nameless>> wrote:
> > The ksymoops output.  Let me know if there is anything else I can offer
> > to help?  This happened when ripping a cd with cdparanoia on an IDE drive
> > with the ide-scsi stuff.
> 
> ....
> 
> > >>EIP; c01b7688 <generic_unplug_device+8/30>   <=====
> > Trace; c01f8fe6 <sg_common_write+1d6/1f0>
> > Trace; c01f9bc0 <sg_cmd_done_bh+0/280>    #### bizarre
> > Trace; c01f8c16 <sg_write+256/280>
> 
> generic_unplug_device() was an addition into the sg driver
> by Jens Axboe. Under heavy stress testing I have also received
> an oops from this function.

It looks like a race in that sg_cmd_done_bh can be completed before
generic_unplug_device is called (and thus on a free'd scsi request). We
then pass an invalid queue to generic_unplug_device.

> It is there because the tentacles of the Linux block subsystem 
> have found their way into the the SCSI midlevel. The st and sg 
> drivers are proof of why this is bad design as they are char 
> devices.

Not so. The SCSI mid level should just force this unplug, or have a
special do_req that forces imediate completion (or start of execution,
rather). The unplug in sg is needed because of that.

> If the generic_unplug_device() call is removed then the
> sg driver will periodically have its commands suspended
> on the SCSI mid level queue until the block subsystem
> decides to send something to the device in question.
> This can be seconds (which isn't a pleasant thing to do
> to a cdwriter).

Because the scsi_request_fn can quit with commands on the queue. That's
a SCSI internal issue. This is not a block layer bug.

--- drivers/scsi/sg.c~	Sun Sep 16 18:17:20 2001
+++ drivers/scsi/sg.c	Sun Sep 16 18:18:44 2001
@@ -645,6 +645,7 @@
     Scsi_Request        * SRpnt;
     Sg_device           * sdp = sfp->parentdp;
     sg_io_hdr_t         * hp = &srp->header;
+    request_queue_t	* q;
 
     srp->data.cmd_opcode = cmnd[0];  /* hold opcode of command */
     hp->status = 0;
@@ -673,6 +674,7 @@
     	return -ENODEV;
     }
     SRpnt = scsi_allocate_request(sdp->device);
+    q = &SRpnt->sr_device->request_queue;
     if(SRpnt == NULL) {
     	SCSI_LOG_TIMEOUT(1, printk("sg_write: no mem\n"));
     	sg_finish_rem_req(srp);
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


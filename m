Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVCYDPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVCYDPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 22:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVCYDPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 22:15:41 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:43655 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261162AbVCYDPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 22:15:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZfLnD0JQFdWV80Yefj4dxZj+Tins5Xd5k7NEHCST5v7VNpn2WhQyIQsXdgKgSw5kIzv/DpniWo4YBE9vZlnHvEdcVYQyhxKz/3CVZN8xEZu3O01NPSenR9dtvHYHhpfOpA3hTMvLq7lpfZ7MC5MHLF1ioNL5h8nTeBbGlDKzEPo=
Date: Fri, 25 Mar 2005 12:15:11 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
Message-ID: <20050325031511.GA22114@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.4682C732@htj.dyndns.org> <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com> <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave> <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111711558.5612.52.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James and Jens.

On Thu, Mar 24, 2005 at 06:45:58PM -0600, James Bottomley wrote:
> On Wed, 2005-03-23 at 16:25 +0100, Jens Axboe wrote:
> > Let me guess, it is hanging in wait_for_completion()?
> 
> Yes, I have the trace now.  Why is curious.  This is the trace of the
> failure:
> 
> Mar 24 18:40:34 localhost kernel: usb 4-2: USB disconnect, address 3
> Mar 24 18:40:34 localhost kernel: sd 0:0:0:0: CMD c25c98b0 done, completing
> Mar 24 18:40:34 localhost kernel:  0:0:0:0: cmd c25c98b0 returning
> Mar 24 18:40:34 localhost kernel:  0:0:0:0: cmd c25c98b0 going out <6>Read Capacity (10) 25 00 00 00 00 00 00 00 00 00
> Mar 24 18:40:34 localhost kernel: scsi0 (0:0): rejecting I/O to dead device (req c25c98b0)
> Mar 24 18:40:34 localhost kernel: usb 4-2: new full speed USB device using uhci_hcd and address 4
> Mar 24 18:40:34 localhost kernel: scsi1 : SCSI emulation for USB Mass Storage devices
> Mar 24 18:40:34 localhost kernel:  1:0:0:0: cmd c1a1b4b0 going out <6>Inquiry 12 00 00 00 24 00
> 
> The problem occurs when the mid-layer rejects the I/O to the dead
> device.  Here it returns BLKPREP_KILL to the prep function, but after
> that we never get a completion back.

 I think I found the cause.  Special requests submitted using
scsi_do_req() never initializes ->end_io().  Normally, SCSI midlayer
terminates special requests inside the SCSI midlayer without passing
through the blkdev layer.  However, if a device is going away or taken
offline, blkdev layer gets to terminate special requests and, as
->end_io() is never set-up, nothing happens and the completion gets
lost.

 The following patch implements scsi_do_req_endio() and sets up
->end_io() and ->end_io_data before sending out special commands.
It's a quick fix & hacky.  I think the proper fix might be one of

 * Don't return BLKPREP_KILL in the prep_fn and always terminate
   special commands inside request_fn without using end_that_*
   functions.

 * I don't really know why the scsi_request/scsi_cmnd distincion
   is made (resource usage?), but, if it's a legacy thing, replace
   scsi_request with scsi_cmnd; then we can BLKPREP_KILL without using
   dummy scsi_cmnd.


 Signed-off-by: Tejun Heo <htejun@gmail.com>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/25 11:57:25+09:00 tj@htj.dyndns.org 
#   midlayer special command termination fix
# 
# drivers/scsi/scsi_lib.c
#   2005/03/25 11:57:17+09:00 tj@htj.dyndns.org +30 -0
#   midlayer special command termination fix
# 
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	2005-03-25 11:59:28 +09:00
+++ b/drivers/scsi/scsi_lib.c	2005-03-25 11:59:28 +09:00
@@ -274,6 +274,33 @@
 }
 
 /*
+ * Special requests usually gets terminated inside scsi midlayer
+ * proper; however, they can be terminated by the blkdev layer when
+ * scsi_prep_fn() returns BLKPREP_KILL or scsi_request_fn() detects
+ * offline condition.  The following callback is invoked when the
+ * blkdev layer terminates a special request.  Emulate DID_NO_CONNECT.
+ */
+static void scsi_do_req_endio(struct request *rq)
+{
+	struct scsi_request *sreq = rq->end_io_data;
+	struct request_queue *q = sreq->sr_device->request_queue;
+	struct scsi_cmnd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.device = sreq->sr_device;
+	scsi_init_cmd_from_req(&cmd, sreq);
+	/* Our command is dummy, nullify back link. */
+	sreq->sr_command = NULL;
+
+	sreq->sr_result = cmd.result = DID_NO_CONNECT << 16;
+
+	/* The sreq->done() callback expects queue_lock to be unlocked. */
+	spin_unlock(q->queue_lock);
+	cmd.done(&cmd);
+	spin_lock(q->queue_lock);
+}
+
+/*
  * Function:    scsi_do_req
  *
  * Purpose:     Queue a SCSI request
@@ -326,6 +353,9 @@
 
 	if (sreq->sr_cmd_len == 0)
 		sreq->sr_cmd_len = COMMAND_SIZE(sreq->sr_cmnd[0]);
+
+	sreq->sr_request->end_io = scsi_do_req_endio;
+	sreq->sr_request->end_io_data = sreq;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work

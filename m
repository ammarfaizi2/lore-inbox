Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbVINVdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbVINVdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbVINVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:33:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48052 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932747AbVINVdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:33:40 -0400
Date: Wed, 14 Sep 2005 17:33:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Anton Blanchard <anton@samba.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc1] sym scsi boot hang
In-Reply-To: <1126730659.4825.18.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0509141716410.8011-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, James Bottomley wrote:

> On Wed, 2005-09-14 at 16:19 -0400, Alan Stern wrote:
> > On Wed, 14 Sep 2005, James Bottomley wrote:
> > Then shouldn't you also avoid unprepping and reprepping a command that is
> > deferred because the host isn't ready?
> 
> Yes ... really the only case for unprep is when we've partially released
> the command (like in scsi_io_completion) where we need to tear the rest
> of it down.

In other words, in scsi_requeue_command and nowhere else.

> The rule should be that if it needs preparing, then it's in the same
> state as the block layer would send it to us in (with no appendages).

That's what the unprep routine was supposed to accomplish.

> For most requeues, we have all the prepared resources attached, so they
> don't need tearing down and repreparing.
> 
> > And isn't it necessary to make sure that req->special is NULL when
> > submitting a special request with no scsi_request, and that
> 
> Yes, but only if the command will be prepared again.

Or will be prepared for the first time, as in scsi_execute.  As far as I 
can tell, a new struct request is not set to all 0's.  So if you queue a 
request with REQ_SPECIAL set and you fail to clear req->special, you're in 
trouble.  Do you have any idea why this hasn't been causing errors all 
along?

> > cmd->sc_request is NULL when associating a command block to a special
> > request with no scsi_request?
> 
> No, that's zeroed out when the command is allocated.  It's only set in
> the path that sends down a scsi_request.

Oops, yes.  I must have been reading __scsi_get_command instead of 
scsi_get_command.

Okay, then how does this patch look (moved the routine over to where it 
gets used, plus two real changes)?

Alan Stern



Index: usb-2.6/drivers/scsi/scsi_lib.c
===================================================================
--- usb-2.6.orig/drivers/scsi/scsi_lib.c
+++ usb-2.6/drivers/scsi/scsi_lib.c
@@ -100,29 +100,6 @@ static void scsi_run_queue(struct reques
 static void scsi_release_buffers(struct scsi_cmnd *cmd);
 
 /*
- * Function:	scsi_unprep_request()
- *
- * Purpose:	Remove all preparation done for a request, including its
- *		associated scsi_cmnd, so that it can be requeued.
- *
- * Arguments:	req	- request to unprepare
- *
- * Lock status:	Assumed that no locks are held upon entry.
- *
- * Returns:	Nothing.
- */
-static void scsi_unprep_request(struct request *req)
-{
-	struct scsi_cmnd *cmd = req->special;
-
-	req->flags &= ~REQ_DONTPREP;
-	req->special = (req->flags & REQ_SPECIAL) ? cmd->sc_request : NULL;
-
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
-}
-
-/*
  * Function:    scsi_queue_insert()
  *
  * Purpose:     Insert a command in the midlevel queue.
@@ -343,6 +320,7 @@ int scsi_execute(struct scsi_device *sde
 	req->sense_len = 0;
 	req->timeout = timeout;
 	req->flags |= flags | REQ_BLOCK_PC | REQ_SPECIAL | REQ_QUIET;
+	req->special = NULL;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
@@ -564,6 +542,29 @@ static void scsi_run_queue(struct reques
 }
 
 /*
+ * Function:	scsi_unprep_request()
+ *
+ * Purpose:	Remove all preparation done for a request, including its
+ *		associated scsi_cmnd, so that it can be requeued.
+ *
+ * Arguments:	req	- request to unprepare
+ *
+ * Lock status:	Assumed that no locks are held upon entry.
+ *
+ * Returns:	Nothing.
+ */
+static void scsi_unprep_request(struct request *req)
+{
+	struct scsi_cmnd *cmd = req->special;
+
+	req->flags &= ~REQ_DONTPREP;
+	req->special = (req->flags & REQ_SPECIAL) ? cmd->sc_request : NULL;
+
+	scsi_release_buffers(cmd);
+	scsi_put_command(cmd);
+}
+
+/*
  * Function:	scsi_requeue_command()
  *
  * Purpose:	Handle post-processing of completed commands.
@@ -1514,7 +1515,6 @@ static void scsi_request_fn(struct reque
 	 * cases (host limits or settings) should run the queue at some
 	 * later time.
 	 */
-	scsi_unprep_request(req);
 	spin_lock_irq(q->queue_lock);
 	blk_requeue_request(q, req);
 	sdev->device_busy--;



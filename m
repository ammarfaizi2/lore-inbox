Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVDASZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVDASZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVDASZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:25:50 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:20404 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262833AbVDASXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:23:44 -0500
Subject: Re: [PATCH scsi-misc-2.6 07/13] scsi: move error handling out of
	scsi_init_io() into scsi_prep_fn()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331090647.79DF3B09@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org>
	 <20050331090647.79DF3B09@htj.dyndns.org>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 12:23:37 -0600
Message-Id: <1112379817.5776.27.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> 	When scsi_init_io() returns BLKPREP_DEFER or BLKPREP_KILL,
> 	it's supposed to free resources itself.  This patch
> 	consolidates defer and kill handling into scsi_prep_fn().
> 	This fixes a queue stall bug which occurred when sgtable
> 	allocation failed and device_busy == 0.

This one I like, but I think it doesn't go far enough.  There are
situations where a re-queue can also re-prepare, which means we leak sg
lists and commands on BLKPREP_KILL because of SCSI state.

How about the attached.

Note, I've also altered the prepare function so req->special never gets
altered if it points to a scsi_request. Previously it would be altered
to point to the command, but now we couldn't put the command since the
scsi_request we can't get to also has a copy of if.  So, if you can make
your later REQ_SPECIAL removal work, we can dispense with sr_magic and
simply use REQ_SPECIAL as the discriminator for the contents of req-
>special.

James

===== drivers/scsi/scsi_lib.c 1.153 vs edited =====
--- 1.153/drivers/scsi/scsi_lib.c	2005-03-30 13:49:45 -06:00
+++ edited/drivers/scsi/scsi_lib.c	2005-04-01 12:18:36 -06:00
@@ -63,6 +63,21 @@
 }; 	
 #undef SP
 
+static inline struct scsi_request *scsi_request(struct request *req) {
+	struct scsi_request *sreq = req->special;
+
+	if (sreq && sreq->sr_magic == SCSI_REQ_MAGIC)
+		return sreq;
+	return NULL;
+}
+
+static struct scsi_cmnd *scsi_command(struct request *req) {
+	struct scsi_request *sreq = scsi_request(req);
+
+	if (sreq)
+		return sreq->sr_command;
+	return req->special;
+}
 
 /*
  * Function:    scsi_insert_special_req()
@@ -626,6 +641,9 @@
 {
 	struct scsi_host_sg_pool *sgp;
 
+	if (sgl == NULL)
+		return;
+
 	BUG_ON(index > SG_MEMPOOL_NR);
 
 	sgp = scsi_sg_pools + index;
@@ -973,9 +991,6 @@
 	printk(KERN_ERR "req nr_sec %lu, cur_nr_sec %u\n", req->nr_sectors,
 			req->current_nr_sectors);
 
-	/* release the command and kill it */
-	scsi_release_buffers(cmd);
-	scsi_put_command(cmd);
 	return BLKPREP_KILL;
 }
 
@@ -1041,7 +1056,7 @@
 	if (unlikely(!scsi_device_online(sdev))) {
 		printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
 		       sdev->host->host_no, sdev->id, sdev->lun);
-		return BLKPREP_KILL;
+		goto kill;
 	}
 	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
 		/* OK, we're not in a running state don't prep
@@ -1051,7 +1066,7 @@
 			 * at all allowed down */
 			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to dead device\n",
 			       sdev->host->host_no, sdev->id, sdev->lun);
-			return BLKPREP_KILL;
+			goto kill;
 		}
 		/* OK, we only allow special commands (i.e. not
 		 * user initiated ones */
@@ -1069,15 +1084,14 @@
 	 * at request->cmd, as this tells us the real story.
 	 */
 	if (req->flags & REQ_SPECIAL) {
-		struct scsi_request *sreq = req->special;
+		struct scsi_request *sreq = scsi_request(req);
 
-		if (sreq->sr_magic == SCSI_REQ_MAGIC) {
+		if (sreq) {
 			cmd = scsi_get_command(sreq->sr_device, GFP_ATOMIC);
 			if (unlikely(!cmd))
 				goto defer;
 			scsi_init_cmd_from_req(cmd, sreq);
-		} else
-			cmd = req->special;
+		}
 	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
 
 		if(unlikely(specials_only)) {
@@ -1087,7 +1101,7 @@
 			
 			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to device being removed\n",
 			       sdev->host->host_no, sdev->id, sdev->lun);
-			return BLKPREP_KILL;
+			goto kill;
 		}
 			
 			
@@ -1098,22 +1112,16 @@
 			cmd = scsi_get_command(sdev, GFP_ATOMIC);
 			if (unlikely(!cmd))
 				goto defer;
-		} else
-			cmd = req->special;
-		
+			req->special = cmd;
+			cmd->request = req;
+		}
 		/* pull a tag out of the request if we have one */
 		cmd->tag = req->tag;
 	} else {
 		blk_dump_rq_flags(req, "SCSI bad req");
-		return BLKPREP_KILL;
+		goto kill;
 	}
-	
-	/* note the overloading of req->special.  When the tag
-	 * is active it always means cmd.  If the tag goes
-	 * back for re-queueing, it may be reset */
-	req->special = cmd;
-	cmd->request = req;
-	
+
 	/*
 	 * FIXME: drop the lock here because the functions below
 	 * expect to be called without the queue lock held.  Also,
@@ -1143,18 +1151,26 @@
 		 * required).
 		 */
 		ret = scsi_init_io(cmd);
-		if (ret)	/* BLKPREP_KILL return also releases the command */
-			return ret;
+		switch (ret) {
+		case 0:
+			/* successful initialisation */
+			break;
+
+		case BLKPREP_DEFER:
+			goto defer;
+
+		default:
+			/* Unrecognised return, fall through */
+		case BLKPREP_KILL:
+			goto kill;
+		}
 		
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
@@ -1170,6 +1186,22 @@
 	if (sdev->device_busy == 0)
 		blk_plug_device(q);
 	return BLKPREP_DEFER;
+ kill:
+	/* Here we have to release every resource associated with the
+	 * request because this will complete at the request level
+	 * (req->end_io), not the scsi command level, so no scsi
+	 * routine will get to free the associated resources */
+
+	cmd = scsi_command(req);
+
+	if (cmd) {
+		struct scsi_request *sreq = scsi_request(req);
+		scsi_release_buffers(cmd);
+		scsi_put_command(cmd);
+		if (sreq)
+			sreq->sr_command = NULL;
+	}
+	return BLKPREP_KILL;
 }
 
 /*
@@ -1341,7 +1373,7 @@
 		 */
 		spin_unlock_irq(shost->host_lock);
 
-		cmd = req->special;
+		cmd = scsi_command(req);
 		if (unlikely(cmd == NULL)) {
 			printk(KERN_CRIT "impossible request in %s.\n"
 					 "please mail a stack trace to "



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVDLLCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVDLLCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVDLLC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:02:29 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:982 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262263AbVDLKdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=FVYPvZDnGwv3szFXEAMi72E6wD782iWYeAJr2vD3B8CxaHhvSGDUeJ437pgu8TeA8Od7vq4DSL/FSDrZMIz86VhczAeUrMALWcOiNTD/ojvPOtPY/IoIqCHZAJ+0fSgqDh/8EMGqr4s+k6aGzgquKYGcmFuxx6VamU5MOWf2Sjg=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412103128.69172FEB@htj.dyndns.org>
In-Reply-To: <20050412103128.69172FEB@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 03/04] scsi: reimplement scsi_request_fn()
Message-ID: <20050412103128.5C5F0B72@htj.dyndns.org>
Date: Tue, 12 Apr 2005 19:33:03 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_scsi_reqfn_reimplementation.patch

	This patch rewrites scsi_request_fn().	scsi_dispatch_cmd() is
	merged into scsi_request_fn().	Goals are

	* Remove unnecessary operations (host_lock unlocking/locking,
	  recursing into scsi_run_queue(), ...)
	* Consolidate defer/kill paths.
	* Be concise.

	The following bugs are fixed.

	* All killed requests now get fully prep'ed and pass through
	  __scsi_done().  This is the only kill path.
		- scsi_cmnd leak in offline-kill path removed
		- unfinished request bug in
		  scsi_dispatch_cmd():SDEV_DEL-kill path removed.
		- commands are never terminated directly from blk
		  layer unless they are invalid, so no need to supply
		  req->end_io callback for special requests.
	* Timer is added while holding host_lock, after all conditions
	  are checked and serial number is assigned.  This guarantees
	  that until host_lock is released, the scsi_cmnd pointed to
	  by cmd isn't released.  That didn't hold in the original
	  code and, theoretically, the original code could access
	  already released cmd.
	* For the same reason, if shost->hostt->queuecommand() fails,
	  we try to delete the timer before releasing host_lock.

	Other changes/notes

	* host_lock is acquired and released only once.
	  enter (qlocked) -> enter loop -> dev-prep -> switch to hlock -\
			  ^---- switch to qlock <- issue <- host-prep <-/
	* unnecessary if () on get_device() removed.
	* loop on elv_next_request() instead of blk_queue_plugged().
	  We now explicitly break out of loop when we plug and check if
	  the queue has been plugged underneath us at the end of loop.
	* All device/host state checks are done in this function and
	  done only once while holding qlock/host_lock respectively.
	* Requests which get deferred during dev-prep are never
	  removed from request queue, so deferring is achieved by
	  simply breaking out of the loop and returning.
	* Failure of blk_queue_start_tag() on tagged queue is a BUG
	  now.	This condition should have been catched by
	  scsi_dev_queue_ready().
	* req->special == NULL test removed.  This just can't happen,
	  and even if it ever happens, scsi_request_fn() will
	  deterministically oops.
	* Requests which gets deferred during host-prep are requeued
	  using blk_requeue_request().	This is the only requeue path.

	Note that scsi_kill_requests() still terminates requests using
	blk layer.  The path is circular-ref workaround and soon to be
	replaced, so ignore it for now.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c      |  137 ----------------------------
 scsi_lib.c  |  286 +++++++++++++++++++++++++++++++++---------------------------
 scsi_priv.h |    1 
 3 files changed, 159 insertions(+), 265 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-12 19:27:55.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-12 19:27:55.000000000 +0900
@@ -70,15 +70,6 @@
 
 
 /*
- * Definitions and constants.
- */
-
-#define MIN_RESET_DELAY (2*HZ)
-
-/* Do not call reset on error if we just did a reset within 15 sec. */
-#define MIN_RESET_PERIOD (15*HZ)
-
-/*
  * Note - the initial logging level can be set here to log events at boot time.
  * After the system is up, you may enable logging via the /proc interface.
  */
@@ -495,134 +486,6 @@ void scsi_log_completion(struct scsi_cmn
 }
 #endif
 
-/* 
- * Assign a serial number and pid to the request for error recovery
- * and debugging purposes.  Protected by the Host_Lock of host.
- */
-static inline void scsi_cmd_get_serial(struct Scsi_Host *host, struct scsi_cmnd *cmd)
-{
-	cmd->serial_number = host->cmd_serial_number++;
-	if (cmd->serial_number == 0) 
-		cmd->serial_number = host->cmd_serial_number++;
-	
-	cmd->pid = host->cmd_pid++;
-	if (cmd->pid == 0)
-		cmd->pid = host->cmd_pid++;
-}
-
-/*
- * Function:    scsi_dispatch_command
- *
- * Purpose:     Dispatch a command to the low-level driver.
- *
- * Arguments:   cmd - command block we are dispatching.
- *
- * Notes:
- */
-int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
-{
-	struct Scsi_Host *host = cmd->device->host;
-	unsigned long flags = 0;
-	unsigned long timeout;
-	int rtn = 0;
-
-	/* check if the device is still usable */
-	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
-		/* in SDEV_DEL we error all commands. DID_NO_CONNECT
-		 * returns an immediate error upwards, and signals
-		 * that the device is no longer present */
-		cmd->result = DID_NO_CONNECT << 16;
-		atomic_inc(&cmd->device->iorequest_cnt);
-		scsi_done(cmd);
-		/* return 0 (because the command has been processed) */
-		goto out;
-	}
-
-	/* Check to see if the scsi lld put this device into state SDEV_BLOCK. */
-	if (unlikely(cmd->device->sdev_state == SDEV_BLOCK)) {
-		/* 
-		 * in SDEV_BLOCK, the command is just put back on the device
-		 * queue.  The suspend state has already blocked the queue so
-		 * future requests should not occur until the device 
-		 * transitions out of the suspend state.
-		 */
-		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
-
-		SCSI_LOG_MLQUEUE(3, printk("queuecommand : device blocked \n"));
-
-		/*
-		 * NOTE: rtn is still zero here because we don't need the
-		 * queue to be plugged on return (it's already stopped)
-		 */
-		goto out;
-	}
-
-	/*
-	 * We will wait MIN_RESET_DELAY clock ticks after the last reset so
-	 * we can avoid the drive not being ready.
-	 */
-	timeout = host->last_reset + MIN_RESET_DELAY;
-
-	if (host->resetting && time_before(jiffies, timeout)) {
-		int ticks_remaining = timeout - jiffies;
-		/*
-		 * NOTE: This may be executed from within an interrupt
-		 * handler!  This is bad, but for now, it'll do.  The irq
-		 * level of the interrupt handler has been masked out by the
-		 * platform dependent interrupt handling code already, so the
-		 * sti() here will not cause another call to the SCSI host's
-		 * interrupt handler (assuming there is one irq-level per
-		 * host).
-		 */
-		while (--ticks_remaining >= 0)
-			mdelay(1 + 999 / HZ);
-		host->resetting = 0;
-	}
-
-	/* 
-	 * AK: unlikely race here: for some reason the timer could
-	 * expire before the serial number is set up below.
-	 */
-	scsi_add_timer(cmd, cmd->timeout_per_command);
-
-	scsi_log_send(cmd);
-
-	/*
-	 * We will use a queued command if possible, otherwise we will
-	 * emulate the queuing and calling of completion function ourselves.
-	 */
-
-	cmd->state = SCSI_STATE_QUEUED;
-	cmd->owner = SCSI_OWNER_LOWLEVEL;
-
-	atomic_inc(&cmd->device->iorequest_cnt);
-
-	spin_lock_irqsave(host->host_lock, flags);
-	scsi_cmd_get_serial(host, cmd); 
-
-	if (unlikely(test_bit(SHOST_CANCEL, &host->shost_state))) {
-		cmd->result = (DID_NO_CONNECT << 16);
-		scsi_done(cmd);
-	} else {
-		rtn = host->hostt->queuecommand(cmd, scsi_done);
-	}
-	spin_unlock_irqrestore(host->host_lock, flags);
-	if (rtn) {
-		if (scsi_delete_timer(cmd)) {
-			atomic_inc(&cmd->device->iodone_cnt);
-			scsi_queue_insert(cmd,
-					  (rtn == SCSI_MLQUEUE_DEVICE_BUSY) ?
-					  rtn : SCSI_MLQUEUE_HOST_BUSY);
-		}
-		SCSI_LOG_MLQUEUE(3,
-		    printk("queuecommand : request rejected\n"));
-	}
-
- out:
-	SCSI_LOG_MLQUEUE(3, printk("leaving scsi_dispatch_cmnd()\n"));
-	return rtn;
-}
-
 /*
  * Function:    scsi_init_cmd_from_req
  *
Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 19:27:55.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 19:27:55.000000000 +0900
@@ -28,6 +28,8 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
+#define MIN_RESET_DELAY (2*HZ)
+
 /*
  * Macro to determine the size of SCSI command. This macro takes vendor
  * unique commands into account. SCSI commands in groups 6 and 7 are
@@ -1036,32 +1038,6 @@ static int scsi_prep_fn(struct request_q
 {
 	struct scsi_device *sdev = q->queuedata;
 	struct scsi_cmnd *cmd;
-	int specials_only = 0;
-
-	/*
-	 * Just check to see if the device is online.  If it isn't, we
-	 * refuse to process any commands.  The device must be brought
-	 * online before trying any recovery commands
-	 */
-	if (unlikely(!scsi_device_online(sdev))) {
-		printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
-		       sdev->host->host_no, sdev->id, sdev->lun);
-		return BLKPREP_KILL;
-	}
-	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
-		/* OK, we're not in a running state don't prep
-		 * user commands */
-		if (sdev->sdev_state == SDEV_DEL) {
-			/* Device is fully deleted, no commands
-			 * at all allowed down */
-			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to dead device\n",
-			       sdev->host->host_no, sdev->id, sdev->lun);
-			return BLKPREP_KILL;
-		}
-		/* OK, we only allow special commands (i.e. not
-		 * user initiated ones */
-		specials_only = sdev->sdev_state;
-	}
 
 	/*
 	 * Find the actual device driver associated with this command.
@@ -1084,30 +1060,12 @@ static int scsi_prep_fn(struct request_q
 		} else
 			cmd = req->special;
 	} else if (req->flags & (REQ_CMD | REQ_BLOCK_PC)) {
-
-		if(unlikely(specials_only)) {
-			if(specials_only == SDEV_QUIESCE ||
-					specials_only == SDEV_BLOCK)
-				return BLKPREP_DEFER;
-			
-			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to device being removed\n",
-			       sdev->host->host_no, sdev->id, sdev->lun);
-			return BLKPREP_KILL;
-		}
-			
-			
-		/*
-		 * Now try and find a command block that we can use.
-		 */
 		if (!req->special) {
 			cmd = scsi_get_command(sdev, GFP_ATOMIC);
 			if (unlikely(!cmd))
 				goto defer;
 		} else
 			cmd = req->special;
-		
-		/* pull a tag out of the request if we have one */
-		cmd->tag = req->tag;
 	} else {
 		blk_dump_rq_flags(req, "SCSI bad req");
 		return BLKPREP_KILL;
@@ -1295,6 +1253,54 @@ static void scsi_kill_requests(request_q
 }
 
 /*
+ * scsi_wait_reset: We will wait MIN_RESET_DELAY clock ticks after the
+ * last reset so we can avoid the drive not being ready.
+ *
+ * Called with no lock held and irq disabled.
+ */
+static inline void scsi_wait_reset(struct Scsi_Host *shost)
+{
+	unsigned long timeout = shost->last_reset + MIN_RESET_DELAY;
+
+	if (shost->resetting && time_before(jiffies, timeout)) {
+		int ticks_remaining = timeout - jiffies;
+		/*
+		 * NOTE: This may be executed from within an interrupt
+		 * handler!  This is bad, but for now, it'll do.  The
+		 * irq level of the interrupt handler has been masked
+		 * out by the platform dependent interrupt handling
+		 * code already, so the local_irq_enable() here will
+		 * not cause another call to the SCSI host's interrupt
+		 * handler (assuming there is one irq-level per host).
+		 */
+		local_irq_enable();
+
+		while (--ticks_remaining >= 0)
+			mdelay(1 + 999 / HZ);
+		shost->resetting = 0;
+
+		local_irq_disable();
+	}
+}
+
+/* 
+ * scsi_cmd_get_serial: Assign a serial number and pid to the request
+ * for error recovery and debugging purposes.
+ *
+ * Called with host_lock held.
+ */
+static inline void scsi_cmd_get_serial(struct Scsi_Host *host, struct scsi_cmnd *cmd)
+{
+	cmd->serial_number = host->cmd_serial_number++;
+	if (cmd->serial_number == 0) 
+		cmd->serial_number = host->cmd_serial_number++;
+
+	cmd->pid = host->cmd_pid++;
+	if (cmd->pid == 0)
+		cmd->pid = host->cmd_pid++;
+}
+
+/*
  * Function:    scsi_request_fn()
  *
  * Purpose:     Main strategy routine for SCSI.
@@ -1309,8 +1315,9 @@ static void scsi_request_fn(struct reque
 {
 	struct scsi_device *sdev = q->queuedata;
 	struct Scsi_Host *shost;
-	struct scsi_cmnd *cmd;
 	struct request *req;
+	struct scsi_cmnd *cmd;
+	int ret = 0;
 
 	if (!sdev) {
 		printk("scsi: killing requests for dead queue\n");
@@ -1318,117 +1325,142 @@ static void scsi_request_fn(struct reque
 		return;
 	}
 
-	if(!get_device(&sdev->sdev_gendev))
-		/* We must be tearing the block queue down already */
-		return;
+	/* FIXME: Once fire & forgetters are fixed, this and the
+	 * unlock_irq/put_device/lock_irq dance at the end of this
+	 * function can go away. */
+	get_device(&sdev->sdev_gendev);
 
-	/*
-	 * To start with, we keep looping until the queue is empty, or until
-	 * the host is no longer able to accept any more requests.
-	 */
 	shost = sdev->host;
-	while (!blk_queue_plugged(q)) {
-		int rtn;
-		/*
-		 * get next queueable request.  We do this early to make sure
-		 * that the request is fully prepared even if we cannot 
-		 * accept it.
-		 */
-		req = elv_next_request(q);
-		if (!req || !scsi_dev_queue_ready(q, sdev))
-			break;
-
-		if (unlikely(!scsi_device_online(sdev))) {
-			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
-			       sdev->host->host_no, sdev->id, sdev->lun);
-			blkdev_dequeue_request(req);
-			req->flags |= REQ_QUIET;
-			while (end_that_request_first(req, 0, req->nr_sectors))
-				;
-			end_that_request_last(req);
-			continue;
-		}
+	while ((req = elv_next_request(q))) {
+		enum scsi_device_state state;
+		int kill = 0, is_special = req->flags & REQ_SPECIAL;
 
+		cmd = req->special;
+		state = cmd->device->sdev_state;
 
-		/*
-		 * Remove the request from the request list.
-		 */
-		if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
+		if (state == SDEV_OFFLINE || state == SDEV_DEL ||
+		    (state == SDEV_CANCEL && !is_special)) {
+			printk(KERN_ERR
+			       "scsi%d (%d:%d): rejecting I/O to %s\n",
+			       shost->host_no, sdev->id, sdev->lun,
+			       (state == SDEV_OFFLINE ?
+					"offline device" :
+				(state == SDEV_DEL ?
+					"dead device" :
+					"device being removed")));
+			kill = 1;
+		} else if (state == SDEV_BLOCK ||
+			   (state == SDEV_QUIESCE && !is_special) ||
+			   !scsi_dev_queue_ready(q, sdev))
+			goto out;
+
+		/* Start tag / remove from the request queue. */
+		if (blk_queue_tagged(q)) {
+			if (blk_queue_start_tag(q, req))
+				BUG();
+			cmd->tag = req->tag;
+		} else
 			blkdev_dequeue_request(req);
+
 		sdev->device_busy++;
 
+		/* Switch to host_lock. */
 		spin_unlock(q->queue_lock);
+		scsi_wait_reset(shost);
 		spin_lock(shost->host_lock);
 
+		if (kill || test_bit(SHOST_CANCEL, &shost->shost_state)) {
+			SCSI_LOG_MLQUEUE(3,
+			    printk("%s: rejecting request\n", __FUNCTION__));
+			shost->host_busy++;
+			atomic_inc(&sdev->iorequest_cnt);
+			cmd->result = DID_NO_CONNECT << 16;
+			__scsi_done(cmd);
+			goto relock;
+		}
+
 		if (!scsi_host_queue_ready(q, shost, sdev))
-			goto not_ready;
+			goto requeue_out;
+
 		if (sdev->single_lun) {
-			if (scsi_target(sdev)->starget_sdev_user &&
-			    scsi_target(sdev)->starget_sdev_user != sdev)
-				goto not_ready;
-			scsi_target(sdev)->starget_sdev_user = sdev;
+			struct scsi_target *target = scsi_target(sdev);
+			if (target->starget_sdev_user &&
+			    target->starget_sdev_user != sdev)
+				goto requeue_out;
+			target->starget_sdev_user = sdev;
 		}
+
+		/* Once requeue path is cleaned up, init_cmd_errh can
+		 * be moved to prep_fn() where it belongs. */
+		scsi_init_cmd_errh(cmd);
 		shost->host_busy++;
+		scsi_log_send(cmd);
+		scsi_cmd_get_serial(shost, cmd);
+		scsi_add_timer(cmd, cmd->timeout_per_command);
 
-		/*
-		 * XXX(hch): This is rather suboptimal, scsi_dispatch_cmd will
-		 *		take the lock again.
-		 */
-		spin_unlock_irq(shost->host_lock);
+		cmd->state = SCSI_STATE_QUEUED;
+		cmd->owner = SCSI_OWNER_LOWLEVEL;
 
-		cmd = req->special;
-		if (unlikely(cmd == NULL)) {
-			printk(KERN_CRIT "impossible request in %s.\n"
-					 "please mail a stack trace to "
-					 "linux-scsi@vger.kernel.org",
-					 __FUNCTION__);
-			BUG();
+		ret = shost->hostt->queuecommand(cmd, scsi_done);
+		if (ret) {
+			SCSI_LOG_MLQUEUE(3,
+			    printk("%s: queuecommand deferred request (%d)\n",
+				   __FUNCTION__, ret));
+			/*
+			 * Timer should be deleted while holding the
+			 * host_lock.  Once it gets released, we don't
+			 * know if cmd is still there or not.
+			 */
+			if (scsi_delete_timer(cmd)) {
+				shost->host_busy--;
+				goto block_requeue_out;
+			}
+
+			spin_unlock_irq(shost->host_lock);
+			goto out_unlocked;
 		}
 
-		/*
-		 * Finally, initialize any error handling parameters, and set up
-		 * the timers for timeouts.
-		 */
-		scsi_init_cmd_errh(cmd);
+		atomic_inc(&sdev->iorequest_cnt);
 
-		/*
-		 * Dispatch the command to the low-level driver.
-		 */
-		rtn = scsi_dispatch_cmd(cmd);
-		spin_lock_irq(q->queue_lock);
-		if(rtn) {
-			/* we're refusing the command; because of
-			 * the way locks get dropped, we need to 
-			 * check here if plugging is required */
-			if(sdev->device_busy == 0)
-				blk_plug_device(q);
+	relock:
+		/* Switch back to queue_lock. */
+		spin_unlock(shost->host_lock);
+		spin_lock(q->queue_lock);
 
-			break;
-		}
+		/* The queue could have been plugged underneath us. */
+		if (blk_queue_plugged(q))
+			goto out;
 	}
 
 	goto out;
 
- not_ready:
-	spin_unlock_irq(shost->host_lock);
+ block_requeue_out:
+	if (ret == SCSI_MLQUEUE_DEVICE_BUSY)
+		sdev->device_blocked = sdev->max_device_blocked;
+	else
+		shost->host_blocked = shost->max_host_blocked;
+ requeue_out:
+	/* Switch back to queue_lock */
+	spin_unlock(shost->host_lock);
+	spin_lock(q->queue_lock);
 
-	/*
-	 * lock q, handle tag, requeue req, and decrement device_busy. We
-	 * must return with queue_lock held.
-	 *
-	 * Decrementing device_busy without checking it is OK, as all such
-	 * cases (host limits or settings) should run the queue at some
-	 * later time.
-	 */
-	spin_lock_irq(q->queue_lock);
+	cmd->state = SCSI_STATE_MLQUEUE;
+	cmd->owner = SCSI_OWNER_MIDLEVEL;
+
+	SCSI_LOG_MLQUEUE(3,
+	    printk("%s: requeueing request\n", __FUNCTION__));
+
+	req->flags |= REQ_SOFTBARRIER;	/* Don't pass this request. */
 	blk_requeue_request(q, req);
-	sdev->device_busy--;
-	if(sdev->device_busy == 0)
+	if (--sdev->device_busy == 0)
 		blk_plug_device(q);
  out:
-	/* must be careful here...if we trigger the ->remove() function
-	 * we cannot be holding the q lock */
+	/*
+	 * must be careful here...if we trigger the ->remove() function
+	 * we cannot be holding the q lock
+	 */
 	spin_unlock_irq(q->queue_lock);
+ out_unlocked:
 	put_device(&sdev->sdev_gendev);
 	spin_lock_irq(q->queue_lock);
 }
Index: scsi-reqfn-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_priv.h	2005-04-12 19:27:54.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_priv.h	2005-04-12 19:27:55.000000000 +0900
@@ -57,7 +57,6 @@ extern int scsi_init_hosts(void);
 extern void scsi_exit_hosts(void);
 
 /* scsi.c */
-extern int scsi_dispatch_cmd(struct scsi_cmnd *cmd);
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
 extern void scsi_done(struct scsi_cmnd *cmd);


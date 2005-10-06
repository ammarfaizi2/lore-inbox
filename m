Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVJFX1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVJFX1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJFX0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:26:40 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:59054 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751249AbVJFX0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:26:36 -0400
Message-ID: <4345B24A.2080104@dresco.co.uk>
Date: Fri, 07 Oct 2005 00:24:58 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
CC: hdaps-devel@lists.sourceforge.net
Subject: [RFC] Hard disk protection revisited
Content-Type: multipart/mixed;
 boundary="------------010900000309080908030805"
X-Hops: 1
X-Originating-Pythagoras-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900000309080908030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I would like to submit the latest disk protection (a.k.a. parking and 
freezing) code from the hdaps-devel side for comment, along with a brief 
overview of what's in the patch -

During initialisation, disk drivers with 'protect' helper functions 
(currently ide and libata) fill in two new function pointers in the 
queue structure. A sysfs 'protect' queue attribute is then created in 
the block layer for devices who's lower level drivers have registered 
these helpers.

When a value (in seconds) is written to the protect attribute, the block 
layer code calls the driver 'protect' helper function. This helper 
parks/suspends the disk, and then stops the queue. Control then returns 
to the block layer which re-uses the plugging timer to set an automatic 
timeout to restart the queue. When 0 is written to the protect 
attribute, or the timer expires, the queue is restarted using the 
'unprotect' helper function, and the plugging timer is restored.

This interface is intended to be used by a daemon process, that monitors 
the hdaps driver output for excessive changes in acceleration, and keeps 
the device parked and the queue stopped until the values become normal.

Patch applies to 2.6.14-rc3 (also 2.6.13.x), and requires libata_passthru..

Regards,
Jon.




______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
--------------010900000309080908030805
Content-Type: text/x-patch;
 name="disk_protect.061005.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disk_protect.061005.patch"

diff -urN linux-2.6.14-rc3.passthru/drivers/block/ll_rw_blk.c linux-2.6.14-rc3.hdaps/drivers/block/ll_rw_blk.c
--- linux-2.6.14-rc3.passthru/drivers/block/ll_rw_blk.c	2005-10-06 22:50:50.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/drivers/block/ll_rw_blk.c	2005-10-06 22:59:39.000000000 +0100
@@ -38,6 +38,8 @@
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
+static int blk_protect_register(request_queue_t *q);
+static void blk_protect_unregister(request_queue_t *q);
 
 /*
  * For the allocated request tables
@@ -345,6 +347,18 @@
 
 EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 
+void blk_queue_issue_protect_fn(request_queue_t *q, issue_protect_fn *ipf)
+{
+	q->issue_protect_fn = ipf;
+}
+EXPORT_SYMBOL(blk_queue_issue_protect_fn);
+
+void blk_queue_issue_unprotect_fn(request_queue_t *q, issue_unprotect_fn *iuf)
+{
+	q->issue_unprotect_fn = iuf;
+}
+EXPORT_SYMBOL(blk_queue_issue_unprotect_fn);
+
 /*
  * Cache flushing for ordered writes handling
  */
@@ -3693,6 +3707,7 @@
 		return ret;
 	}
 
+	blk_protect_register(q);
 	return 0;
 }
 
@@ -3701,9 +3716,121 @@
 	request_queue_t *q = disk->queue;
 
 	if (q && q->request_fn) {
+		blk_protect_unregister(q);
 		elv_unregister_queue(q);
 
 		kobject_unregister(&q->kobj);
 		kobject_put(&disk->kobj);
 	}
 }
+
+/*
+ * Restore the unplugging timer that we re-used
+ * to implement the queue freeze timeout...
+ */
+static void blk_unfreeze_work(void *data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+
+	INIT_WORK(&q->unplug_work, blk_unplug_work, q);
+	q->unplug_timer.function = blk_unplug_timeout;
+
+	q->issue_unprotect_fn(q);
+}
+
+/*
+ * Called when the queue freeze timeout expires...
+ */
+static void blk_unfreeze_timeout(unsigned long data)
+{
+	request_queue_t *q = (request_queue_t *) data;
+	kblockd_schedule_work(&q->unplug_work);
+}
+
+/* 
+ * The lower level driver parks and freezes the queue, and this block layer
+ *  function sets up the freeze timeout timer on return. If the queue is
+ *  already frozen then this is called to extend the timer...
+ */
+void blk_freeze_queue(request_queue_t *q, int seconds)
+{
+	/* set/reset the timer */
+	mod_timer(&q->unplug_timer, msecs_to_jiffies(seconds*1000) + jiffies);
+
+	/* we do this every iteration - is this sane? */
+	INIT_WORK(&q->unplug_work, blk_unfreeze_work, q);
+	q->unplug_timer.function = blk_unfreeze_timeout;
+}
+
+/* 
+ * When reading the 'protect' attribute, we return boolean frozen or active
+ * todo:
+ * - maybe we should return seconds remaining instead?
+ */
+static ssize_t queue_protect_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(blk_queue_stopped(q), (page));
+}
+
+/* 
+ * When writing the 'protect' attribute, input is the number of seconds
+ * to freeze the queue for. We call a lower level helper function to 
+ * park the heads and freeze/block the queue, then we make a block layer
+ * call to setup the thaw timeout. If input is 0, then we thaw the queue.
+ */
+static ssize_t queue_protect_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long freeze = 0;
+	queue_var_store(&freeze, page, count);
+
+	printk(KERN_DEBUG "queue_protect_store(): freeze = %lu\n", freeze);
+
+	if(freeze>0) {
+		/* Park and freeze */
+		if (!blk_queue_stopped(q))
+			q->issue_protect_fn(q);
+		/* set / reset the thaw timer */
+		blk_freeze_queue(q, freeze);
+	}
+	else
+		blk_unfreeze_timeout((unsigned long) q);
+
+	return count;
+}
+
+static struct queue_sysfs_entry queue_protect_entry = {
+	.attr = {.name = "protect", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_protect_show,
+	.store = queue_protect_store,
+};
+
+static int blk_protect_register(request_queue_t *q)
+{
+	int error = 0;
+
+	/* check that the lower level driver has a protect handler */	
+	if (!q->issue_protect_fn)
+		return 1;
+	
+	/* create the attribute */
+	error = sysfs_create_file(&q->kobj, &queue_protect_entry.attr);
+	if(error){
+		printk(KERN_ERR 
+			"blk_protect_register(): failed to create protect queue attribute!\n");
+		return error;
+	}
+	
+	kobject_get(&q->kobj);
+	return 0;		
+}
+
+static void blk_protect_unregister(request_queue_t *q)
+{
+	/* check that the lower level driver has a protect handler */	
+	if (!q->issue_protect_fn)
+		return;
+
+	/* remove the attribute */
+	sysfs_remove_file(&q->kobj,&queue_protect_entry.attr);
+	kobject_put(&q->kobj);
+}
diff -urN linux-2.6.14-rc3.passthru/drivers/ide/ide-disk.c linux-2.6.14-rc3.hdaps/drivers/ide/ide-disk.c
--- linux-2.6.14-rc3.passthru/drivers/ide/ide-disk.c	2005-10-06 22:50:50.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/drivers/ide/ide-disk.c	2005-10-06 22:59:39.000000000 +0100
@@ -767,6 +767,117 @@
 }
 
 /*
+ * todo:
+ *  - we freeze the queue regardless of success and rely on the 
+ *    ide_protect_queue function to thaw immediately if the command
+ *    failed (to be consistent with the libata handler)... should 
+ *    we also inspect here?
+ */
+void ide_end_protect_rq(struct request *rq)
+{
+	struct completion *waiting = rq->waiting;
+
+	/* spin lock already accquired */
+	if (!blk_queue_stopped(rq->q))
+		blk_stop_queue(rq->q);
+
+	complete(waiting);
+}
+
+int ide_unprotect_queue(request_queue_t *q)
+{
+	unsigned long flags;
+
+	if (!blk_queue_stopped(q))
+		return -EIO;
+	
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_start_queue(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+	return 0;
+}
+
+int ide_protect_queue(request_queue_t *q, int unload)
+{
+	ide_drive_t 	*drive = q->queuedata;
+	struct request	rq;
+	u8 		args[7], *argbuf = args;
+	int		ret = 0;
+	DECLARE_COMPLETION(wait);
+
+	memset(&rq, 0, sizeof(rq));
+	memset(args, 0, sizeof(args));
+
+	if (blk_queue_stopped(q))
+		return -EIO;
+
+	if (unload) {
+		argbuf[0] = 0xe1;
+		argbuf[1] = 0x44;
+		argbuf[3] = 0x4c;
+		argbuf[4] = 0x4e;
+		argbuf[5] = 0x55;
+	} else
+		argbuf[0] = 0xe0;
+
+	/* Issue the park command & freeze */
+	ide_init_drive_cmd(&rq);
+
+	rq.flags = REQ_DRIVE_TASK;
+	rq.buffer = argbuf;
+	rq.waiting = &wait;
+	rq.end_io = ide_end_protect_rq;
+
+	ret = ide_do_drive_cmd(drive, &rq, ide_next);
+	wait_for_completion(&wait);
+	rq.waiting = NULL;
+
+	if (ret)
+	{
+		printk(KERN_DEBUG "ide_protect_queue(): Warning: head NOT parked..\n");
+		ide_unprotect_queue(q);
+		return ret;
+	}
+
+	if (unload) {
+		if (args[3] == 0xc4)
+			printk(KERN_DEBUG "ide_protect_queue(): head parked!..\n");
+		else {
+			/* error parking the head */
+			printk(KERN_DEBUG "ide_protect_queue(): head NOT parked!..\n");
+			ret = -EIO;
+			ide_unprotect_queue(q);
+		}
+	} else
+		printk(KERN_DEBUG "ide_protect_queue(): head park not requested, used standby!..\n");
+
+	return ret;
+}	
+
+int idedisk_issue_protect_fn(request_queue_t *q)
+{
+	ide_drive_t		*drive = q->queuedata;
+
+	/*
+	 * Check capability of the device -
+	 *  - if "idle immediate with unload" is supported we use that, else
+	 *    we use "standby immediate" and live with spinning down the drive..
+	 *    (Word 84, bit 13 of IDENTIFY DEVICE data)
+	 */
+	if (drive->id->cfsse & (1 << 13))
+		printk(KERN_DEBUG "idedisk_issue_protect_fn(): unload support reported..\n");
+	else
+		printk(KERN_DEBUG "idedisk_issue_protect_fn(): unload support NOT reported..\n");
+
+	return ide_protect_queue(q, (drive->id->cfsse & (1 << 13)) ? 1: 0);
+}
+
+int idedisk_issue_unprotect_fn(request_queue_t *q)
+{
+	return ide_unprotect_queue(q);
+}
+
+/*
  * This is tightly woven into the driver->do_special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
  */
@@ -1017,6 +1128,8 @@
 		drive->queue->end_flush_fn = idedisk_end_flush;
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
 	}
+	blk_queue_issue_protect_fn(drive->queue, idedisk_issue_protect_fn);	
+	blk_queue_issue_unprotect_fn(drive->queue, idedisk_issue_unprotect_fn);	
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
diff -urN linux-2.6.14-rc3.passthru/drivers/ide/ide-io.c linux-2.6.14-rc3.hdaps/drivers/ide/ide-io.c
--- linux-2.6.14-rc3.passthru/drivers/ide/ide-io.c	2005-10-06 22:50:50.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/drivers/ide/ide-io.c	2005-10-06 22:59:39.000000000 +0100
@@ -1181,6 +1181,17 @@
 		}
 
 		/*
+		 * Don't accept a request when the queue is stopped (unless we
+		 * are resuming from suspend). Prevents existing queue entries 
+		 * being processed after queue is stopped by the hard disk 
+		 * protection mechanism...
+		 */
+		if (test_bit(QUEUE_FLAG_STOPPED, &drive->queue->queue_flags) && !blk_pm_resume_request(rq)) {
+			hwgroup->busy = 0;
+			break;
+		}
+
+		/*
 		 * Sanity: don't accept a request that isn't a PM request
 		 * if we are currently power managed. This is very important as
 		 * blk_stop_queue() doesn't prevent the elv_next_request()
@@ -1661,6 +1672,9 @@
 		where = ELEVATOR_INSERT_FRONT;
 		rq->flags |= REQ_PREEMPT;
 	}
+	if (action == ide_next)
+		where = ELEVATOR_INSERT_FRONT;
+
 	__elv_add_request(drive->queue, rq, where, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
diff -urN linux-2.6.14-rc3.passthru/drivers/scsi/libata-scsi.c linux-2.6.14-rc3.hdaps/drivers/scsi/libata-scsi.c
--- linux-2.6.14-rc3.passthru/drivers/scsi/libata-scsi.c	2005-10-06 22:54:19.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/drivers/scsi/libata-scsi.c	2005-10-06 22:59:39.000000000 +0100
@@ -607,6 +607,29 @@
 	}
 }
 
+extern int scsi_protect_queue(request_queue_t *q, int unload);
+extern int scsi_unprotect_queue(request_queue_t *q);
+
+static int ata_scsi_issue_protect_fn(request_queue_t *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+
+	if (ata_id_has_unload(dev->id))
+		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support reported..\n");
+	else
+		printk(KERN_DEBUG "ata_scsi_issue_protect_fn(): unload support NOT reported..\n");
+
+	/* call scsi_protect_queue, requesting either unload or standby */
+	return scsi_protect_queue(q, ata_id_has_unload(dev->id) ? 1 : 0);
+}
+
+static int ata_scsi_issue_unprotect_fn(request_queue_t *q)
+{
+	return scsi_unprotect_queue(q);
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -647,6 +670,8 @@
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
 	}
+	blk_queue_issue_protect_fn(sdev->request_queue, ata_scsi_issue_protect_fn);	
+	blk_queue_issue_unprotect_fn(sdev->request_queue, ata_scsi_issue_unprotect_fn);	
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
 }
diff -urN linux-2.6.14-rc3.passthru/drivers/scsi/scsi_lib.c linux-2.6.14-rc3.hdaps/drivers/scsi/scsi_lib.c
--- linux-2.6.14-rc3.passthru/drivers/scsi/scsi_lib.c	2005-10-06 22:50:51.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/drivers/scsi/scsi_lib.c	2005-10-06 22:59:40.000000000 +0100
@@ -255,6 +255,36 @@
 }
 EXPORT_SYMBOL(scsi_do_req);
 
+/*
+ * As per scsi_wait_done(), except calls scsi_device_block
+ * to block the queue at command completion. Only called by
+ * scsi_protect_wait().
+ * todo:
+ *  - find a better way to do this - too much code duplication
+ *  - we block the queue regardless of success and rely on the 
+ *    scsi_protect_queue function to unblock if the command
+ *    failed... should we also inspect here?
+ */
+static void scsi_protect_wait_done(struct scsi_cmnd *cmd)
+{
+	struct request *req = cmd->request;
+	struct request_queue *q = cmd->device->request_queue;
+	struct scsi_device *sdev = cmd->device;
+	unsigned long flags;
+
+	req->rq_status = RQ_SCSI_DONE;	/* Busy, but indicate request done */
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	if (blk_rq_tagged(req))
+		blk_queue_end_tag(q, req);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	scsi_internal_device_block(sdev);
+
+	if (req->waiting)
+		complete(req->waiting);
+}
+
 /* This is the end routine we get to if a command was never attached
  * to the request.  Simply complete the request without changing
  * rq_status; this will cause a DRIVER_ERROR. */
@@ -378,6 +408,30 @@
 EXPORT_SYMBOL(scsi_execute_req);
 
 /*
+ * As per scsi_wait_req(), except sets the completion function
+ * as scsi_protect_wait_done().
+ * todo:
+ *  - find a better way to do this - too much code duplication
+ */
+void scsi_protect_wait_req(struct scsi_request *sreq, const void *cmnd, void *buffer,
+		   unsigned bufflen, int timeout, int retries)
+{
+	DECLARE_COMPLETION(wait);
+	
+	sreq->sr_request->waiting = &wait;
+	sreq->sr_request->rq_status = RQ_SCSI_BUSY;
+	sreq->sr_request->end_io = scsi_wait_req_end_io;
+	scsi_do_req(sreq, cmnd, buffer, bufflen, scsi_protect_wait_done,
+			timeout, retries);
+	wait_for_completion(&wait);
+	sreq->sr_request->waiting = NULL;
+	if (sreq->sr_request->rq_status != RQ_SCSI_DONE)
+		sreq->sr_result |= (DRIVER_ERROR << 24);
+
+	__scsi_release_request(sreq);
+}
+
+/*
  * Function:    scsi_init_cmd_errh()
  *
  * Purpose:     Initialize cmd fields related to error handling.
@@ -1128,6 +1182,101 @@
 	scsi_io_completion(cmd, cmd->result == 0 ? cmd->bufflen : 0, 0);
 }
 
+int scsi_unprotect_queue(request_queue_t *q){
+	struct scsi_device *sdev = q->queuedata;
+
+	if (sdev->sdev_state != SDEV_BLOCK)
+		return -ENXIO;
+
+	return scsi_internal_device_unblock(sdev);
+}
+EXPORT_SYMBOL_GPL(scsi_unprotect_queue);
+
+int scsi_protect_queue(request_queue_t *q, int unload)
+{
+	struct scsi_device *sdev = q->queuedata;
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[7];
+	struct scsi_request *sreq;
+	unsigned char *sb, *desc;
+
+	if (sdev->sdev_state != SDEV_RUNNING)
+		return -ENXIO;
+
+	memset(args, 0, sizeof(args));
+
+	if (unload) {
+		args[0] = 0xe1;
+		args[1] = 0x44;
+		args[3] = 0x4c;
+		args[4] = 0x4e;
+		args[5] = 0x55;
+	} else
+		args[0] = 0xe0;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[1]  = (3 << 1); /* Non-data */
+	scsi_cmd[2]  = 0x20;     /* no off.line, or data xfer, request cc */
+	scsi_cmd[4]  = args[1];
+	scsi_cmd[6]  = args[2];
+	scsi_cmd[8]  = args[3];
+	scsi_cmd[10] = args[4];
+	scsi_cmd[12] = args[5];
+	scsi_cmd[14] = args[0];
+
+	sreq = scsi_allocate_request(sdev, GFP_KERNEL);
+	if (!sreq) {
+		rc = -EINTR;
+		goto error;
+	}
+
+	sreq->sr_data_direction = DMA_NONE;
+
+	/* Call scsi_protect_wait_req() instead of scsi_wait_req()
+	 * so that we can override the completion handler..
+	 * todo:
+	 *   - find a better way to set up completion handler...
+	 */
+	scsi_protect_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
+
+	if (!sreq->sr_result == ((DRIVER_SENSE << 24) + SAM_STAT_CHECK_CONDITION)) {
+		printk(KERN_DEBUG "scsi_protect_queue(): head NOT parked!..\n");
+		scsi_unprotect_queue(q);		/* just in case we still managed to block */
+		rc = -EIO;
+		goto error;
+	}
+
+	sb = sreq->sr_sense_buffer;
+	desc = sb + 8;
+
+	/* Retrieve data from check condition */
+	args[1] = desc[3];
+	args[2] = desc[5];
+	args[3] = desc[7];
+	args[4] = desc[9];
+	args[5] = desc[11];
+	args[0] = desc[13];
+
+	if (unload) {
+		if (args[3] == 0xc4)
+			printk(KERN_DEBUG "scsi_protect_queue(): head parked!..\n");
+		else {
+			/* error parking the head */
+			printk(KERN_DEBUG "scsi_protect_queue(): head NOT parked!..\n");
+			rc = -EIO;
+			scsi_unprotect_queue(q);
+		}
+	} else
+		printk(KERN_DEBUG "scsi_protect_queue(): head park not requested, used standby!..\n");
+
+error:
+	scsi_release_request(sreq);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(scsi_protect_queue);
+
 static int scsi_prep_fn(struct request_queue *q, struct request *req)
 {
 	struct scsi_device *sdev = q->queuedata;
diff -urN linux-2.6.14-rc3.passthru/include/linux/ata.h linux-2.6.14-rc3.hdaps/include/linux/ata.h
--- linux-2.6.14-rc3.passthru/include/linux/ata.h	2005-10-06 22:50:53.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/include/linux/ata.h	2005-10-06 22:59:40.000000000 +0100
@@ -234,6 +234,7 @@
 #define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
+#define ata_id_has_unload(id) ((id)[84] & (1 << 13))
 #define ata_id_has_flush(id) ((id)[83] & (1 << 12))
 #define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
 #define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
diff -urN linux-2.6.14-rc3.passthru/include/linux/blkdev.h linux-2.6.14-rc3.hdaps/include/linux/blkdev.h
--- linux-2.6.14-rc3.passthru/include/linux/blkdev.h	2005-10-06 22:50:53.000000000 +0100
+++ linux-2.6.14-rc3.hdaps/include/linux/blkdev.h	2005-10-06 22:59:40.000000000 +0100
@@ -287,6 +287,8 @@
 typedef int (merge_bvec_fn) (request_queue_t *, struct bio *, struct bio_vec *);
 typedef void (activity_fn) (void *data, int rw);
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
+typedef int (issue_protect_fn) (request_queue_t *);
+typedef int (issue_unprotect_fn) (request_queue_t *);
 typedef int (prepare_flush_fn) (request_queue_t *, struct request *);
 typedef void (end_flush_fn) (request_queue_t *, struct request *);
 
@@ -331,6 +333,8 @@
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
 	end_flush_fn		*end_flush_fn;
+	issue_protect_fn	*issue_protect_fn;
+	issue_unprotect_fn	*issue_unprotect_fn;
 
 	/*
 	 * Auto-unplugging state
@@ -644,6 +648,8 @@
 extern struct request *blk_start_pre_flush(request_queue_t *,struct request *);
 extern int blk_complete_barrier_rq(request_queue_t *, struct request *, int);
 extern int blk_complete_barrier_rq_locked(request_queue_t *, struct request *, int);
+extern void blk_queue_issue_protect_fn(request_queue_t *, issue_protect_fn *);
+extern void blk_queue_issue_unprotect_fn(request_queue_t *, issue_unprotect_fn *);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);


--------------010900000309080908030805--

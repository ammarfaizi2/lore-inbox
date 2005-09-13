Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVIMPCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVIMPCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVIMPCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:02:22 -0400
Received: from ozlabs.org ([203.10.76.45]:63898 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932658AbVIMPCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:02:21 -0400
Date: Wed, 14 Sep 2005 00:29:39 +1000
From: Anton Blanchard <anton@samba.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050913142939.GE26162@krispykreme>
References: <20050913124804.GA5008@in.ibm.com> <20050913131739.GD26162@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913131739.GD26162@krispykreme>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Looks like a change between 2.6.13-git11 and 2.6.14-rc1 caused this - so
> something in the last 24 hours.

I just noticed a similar hang on the ibmvscsi driver. The following
backout patch seems to fix it (part of the scsi merge yesterday), I'll
look closer after I get some sleep.

Anton

diff -urN build/drivers/scsi/scsi_lib.c build2/drivers/scsi/scsi_lib.c
--- build/drivers/scsi/scsi_lib.c	2005-09-13 15:13:32.000000000 +1000
+++ build2/drivers/scsi/scsi_lib.c	2005-09-14 00:44:57.000000000 +1000
@@ -97,30 +97,6 @@
 }
 
 static void scsi_run_queue(struct request_queue *q);
-static void scsi_release_buffers(struct scsi_cmnd *cmd);
-
-/*
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
 
 /*
  * Function:    scsi_queue_insert()
@@ -140,14 +116,12 @@
  *              commands.
  * Notes:       This could be called either from an interrupt context or a
  *              normal process context.
- * Notes:	Upon return, cmd is a stale pointer.
  */
 int scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct scsi_device *device = cmd->device;
 	struct request_queue *q = device->request_queue;
-	struct request *req = cmd->request;
 	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1,
@@ -188,9 +162,8 @@
 	 * function.  The SCSI request function detects the blocked condition
 	 * and plugs the queue appropriately.
          */
-	scsi_unprep_request(req);
 	spin_lock_irqsave(q->queue_lock, flags);
-	blk_requeue_request(q, req);
+	blk_requeue_request(q, cmd->request);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	scsi_run_queue(q);
@@ -366,7 +339,7 @@
 	int result;
 	
 	if (sshdr) {
-		sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_NOIO);
+		sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
 		if (!sense)
 			return DRIVER_ERROR << 24;
 		memset(sense, 0, SCSI_SENSE_BUFFERSIZE);
@@ -579,16 +552,15 @@
  *		I/O errors in the middle of the request, in which case
  *		we need to request the blocks that come after the bad
  *		sector.
- * Notes:	Upon return, cmd is a stale pointer.
  */
 static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 {
-	struct request *req = cmd->request;
 	unsigned long flags;
 
-	scsi_unprep_request(req);
+	cmd->request->flags &= ~REQ_DONTPREP;
+
 	spin_lock_irqsave(q->queue_lock, flags);
-	blk_requeue_request(q, req);
+	blk_requeue_request(q, cmd->request);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	scsi_run_queue(q);
@@ -623,14 +595,13 @@
  *
  * Lock status: Assumed that lock is not held upon entry.
  *
- * Returns:     cmd if requeue required, NULL otherwise.
+ * Returns:     cmd if requeue done or required, NULL otherwise
  *
  * Notes:       This is called for block device requests in order to
  *              mark some number of sectors as complete.
  * 
  *		We are guaranteeing that the request queue will be goosed
  *		at some point during this call.
- * Notes:	If cmd was requeued, upon return it will be a stale pointer.
  */
 static struct scsi_cmnd *scsi_end_request(struct scsi_cmnd *cmd, int uptodate,
 					  int bytes, int requeue)
@@ -653,15 +624,14 @@
 		if (!uptodate && blk_noretry_request(req))
 			end_that_request_chunk(req, 0, leftover);
 		else {
-			if (requeue) {
+			if (requeue)
 				/*
 				 * Bleah.  Leftovers again.  Stick the
 				 * leftovers in the front of the
 				 * queue, and goose the queue again.
 				 */
 				scsi_requeue_command(q, cmd);
-				cmd = NULL;
-			}
+
 			return cmd;
 		}
 	}
@@ -887,13 +857,15 @@
 		 * requeueing right here - we will requeue down below
 		 * when we handle the bad sectors.
 		 */
+		cmd = scsi_end_request(cmd, 1, good_bytes, result == 0);
 
 		/*
-		 * If the command completed without error, then either
-		 * finish off the rest of the command, or start a new one.
+		 * If the command completed without error, then either finish off the
+		 * rest of the command, or start a new one.
 		 */
-		if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
+		if (result == 0 || cmd == NULL ) {
 			return;
+		}
 	}
 	/*
 	 * Now, if we were good little boys and girls, Santa left us a request
@@ -908,7 +880,7 @@
 				 * and quietly refuse further access.
 				 */
 				cmd->device->changed = 1;
-				scsi_end_request(cmd, 0,
+				cmd = scsi_end_request(cmd, 0,
 						this_count, 1);
 				return;
 			} else {
@@ -942,7 +914,7 @@
 				scsi_requeue_command(q, cmd);
 				result = 0;
 			} else {
-				scsi_end_request(cmd, 0, this_count, 1);
+				cmd = scsi_end_request(cmd, 0, this_count, 1);
 				return;
 			}
 			break;
@@ -959,7 +931,7 @@
 				dev_printk(KERN_INFO,
 					   &cmd->device->sdev_gendev,
 					   "Device not ready.\n");
-			scsi_end_request(cmd, 0, this_count, 1);
+			cmd = scsi_end_request(cmd, 0, this_count, 1);
 			return;
 		case VOLUME_OVERFLOW:
 			if (!(req->flags & REQ_QUIET)) {
@@ -969,7 +941,7 @@
 				__scsi_print_command(cmd->data_cmnd);
 				scsi_print_sense("", cmd);
 			}
-			scsi_end_request(cmd, 0, block_bytes, 1);
+			cmd = scsi_end_request(cmd, 0, block_bytes, 1);
 			return;
 		default:
 			break;
@@ -1000,7 +972,7 @@
 		block_bytes = req->hard_cur_sectors << 9;
 		if (!block_bytes)
 			block_bytes = req->data_len;
-		scsi_end_request(cmd, 0, block_bytes, 1);
+		cmd = scsi_end_request(cmd, 0, block_bytes, 1);
 	}
 }
 EXPORT_SYMBOL(scsi_io_completion);
@@ -1146,7 +1118,7 @@
 	if (unlikely(!scsi_device_online(sdev))) {
 		printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
 		       sdev->host->host_no, sdev->id, sdev->lun);
-		goto kill;
+		return BLKPREP_KILL;
 	}
 	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
 		/* OK, we're not in a running state don't prep
@@ -1156,7 +1128,7 @@
 			 * at all allowed down */
 			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to dead device\n",
 			       sdev->host->host_no, sdev->id, sdev->lun);
-			goto kill;
+			return BLKPREP_KILL;
 		}
 		/* OK, we only allow special commands (i.e. not
 		 * user initiated ones */
@@ -1188,11 +1160,11 @@
 		if(unlikely(specials_only) && !(req->flags & REQ_SPECIAL)) {
 			if(specials_only == SDEV_QUIESCE ||
 					specials_only == SDEV_BLOCK)
-				goto defer;
+				return BLKPREP_DEFER;
 			
 			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to device being removed\n",
 			       sdev->host->host_no, sdev->id, sdev->lun);
-			goto kill;
+			return BLKPREP_KILL;
 		}
 			
 			
@@ -1210,7 +1182,7 @@
 		cmd->tag = req->tag;
 	} else {
 		blk_dump_rq_flags(req, "SCSI bad req");
-		goto kill;
+		return BLKPREP_KILL;
 	}
 	
 	/* note the overloading of req->special.  When the tag
@@ -1248,13 +1220,8 @@
 		 * required).
 		 */
 		ret = scsi_init_io(cmd);
-		switch(ret) {
-		case BLKPREP_KILL:
-			/* BLKPREP_KILL return also releases the command */
-			goto kill;
-		case BLKPREP_DEFER:
-			goto defer;
-		}
+		if (ret)	/* BLKPREP_KILL return also releases the command */
+			return ret;
 		
 		/*
 		 * Initialize the actual SCSI command for this request.
@@ -1264,7 +1231,7 @@
 			if (unlikely(!drv->init_command(cmd))) {
 				scsi_release_buffers(cmd);
 				scsi_put_command(cmd);
-				goto kill;
+				return BLKPREP_KILL;
 			}
 		} else {
 			memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
@@ -1295,9 +1262,6 @@
 	if (sdev->device_busy == 0)
 		blk_plug_device(q);
 	return BLKPREP_DEFER;
- kill:
-	req->errors = DID_NO_CONNECT << 16;
-	return BLKPREP_KILL;
 }
 
 /*
@@ -1372,24 +1336,19 @@
 }
 
 /*
- * Kill a request for a dead device
+ * Kill requests for a dead device
  */
-static void scsi_kill_request(struct request *req, request_queue_t *q)
+static void scsi_kill_requests(request_queue_t *q)
 {
-	struct scsi_cmnd *cmd = req->special;
-
-	blkdev_dequeue_request(req);
+	struct request *req;
 
-	if (unlikely(cmd == NULL)) {
-		printk(KERN_CRIT "impossible request in %s.\n",
-				 __FUNCTION__);
-		BUG();
+	while ((req = elv_next_request(q)) != NULL) {
+		blkdev_dequeue_request(req);
+		req->flags |= REQ_QUIET;
+		while (end_that_request_first(req, 0, req->nr_sectors))
+			;
+		end_that_request_last(req);
 	}
-
-	scsi_init_cmd_errh(cmd);
-	cmd->result = DID_NO_CONNECT << 16;
-	atomic_inc(&cmd->device->iorequest_cnt);
-	__scsi_done(cmd);
 }
 
 /*
@@ -1412,8 +1371,7 @@
 
 	if (!sdev) {
 		printk("scsi: killing requests for dead queue\n");
-		while ((req = elv_next_request(q)) != NULL)
-			scsi_kill_request(req, q);
+		scsi_kill_requests(q);
 		return;
 	}
 
@@ -1440,7 +1398,11 @@
 		if (unlikely(!scsi_device_online(sdev))) {
 			printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
 			       sdev->host->host_no, sdev->id, sdev->lun);
-			scsi_kill_request(req, q);
+			blkdev_dequeue_request(req);
+			req->flags |= REQ_QUIET;
+			while (end_that_request_first(req, 0, req->nr_sectors))
+				;
+			end_that_request_last(req);
 			continue;
 		}
 
@@ -1453,14 +1415,6 @@
 		sdev->device_busy++;
 
 		spin_unlock(q->queue_lock);
-		cmd = req->special;
-		if (unlikely(cmd == NULL)) {
-			printk(KERN_CRIT "impossible request in %s.\n"
-					 "please mail a stack trace to "
-					 "linux-scsi@vger.kernel.org",
-					 __FUNCTION__);
-			BUG();
-		}
 		spin_lock(shost->host_lock);
 
 		if (!scsi_host_queue_ready(q, shost, sdev))
@@ -1479,6 +1433,15 @@
 		 */
 		spin_unlock_irq(shost->host_lock);
 
+		cmd = req->special;
+		if (unlikely(cmd == NULL)) {
+			printk(KERN_CRIT "impossible request in %s.\n"
+					 "please mail a stack trace to "
+					 "linux-scsi@vger.kernel.org",
+					 __FUNCTION__);
+			BUG();
+		}
+
 		/*
 		 * Finally, initialize any error handling parameters, and set up
 		 * the timers for timeouts.
@@ -1514,7 +1477,6 @@
 	 * cases (host limits or settings) should run the queue at some
 	 * later time.
 	 */
-	scsi_unprep_request(req);
 	spin_lock_irq(q->queue_lock);
 	blk_requeue_request(q, req);
 	sdev->device_busy--;
diff -urN build/drivers/scsi/scsi_priv.h build2/drivers/scsi/scsi_priv.h
--- build/drivers/scsi/scsi_priv.h	2005-09-13 15:13:32.000000000 +1000
+++ build2/drivers/scsi/scsi_priv.h	2005-09-14 00:44:57.000000000 +1000
@@ -124,7 +124,6 @@
 extern void scsi_sysfs_device_initialize(struct scsi_device *);
 extern int scsi_sysfs_target_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
-extern void __scsi_remove_device(struct scsi_device *);
 
 extern struct bus_type scsi_bus_type;
 
diff -urN build/drivers/scsi/scsi_scan.c build2/drivers/scsi/scsi_scan.c
--- build/drivers/scsi/scsi_scan.c	2005-09-13 15:13:32.000000000 +1000
+++ build2/drivers/scsi/scsi_scan.c	2005-09-14 00:44:57.000000000 +1000
@@ -870,12 +870,8 @@
  out_free_sdev:
 	if (res == SCSI_SCAN_LUN_PRESENT) {
 		if (sdevp) {
-			if (scsi_device_get(sdev) == 0) {
-				*sdevp = sdev;
-			} else {
-				__scsi_remove_device(sdev);
-				res = SCSI_SCAN_NO_RESPONSE;
-			}
+			scsi_device_get(sdev);
+			*sdevp = sdev;
 		}
 	} else {
 		if (sdev->host->hostt->slave_destroy)
@@ -1264,19 +1260,6 @@
 }
 EXPORT_SYMBOL(__scsi_add_device);
 
-int scsi_add_device(struct Scsi_Host *host, uint channel,
-		    uint target, uint lun)
-{
-	struct scsi_device *sdev = 
-		__scsi_add_device(host, channel, target, lun, NULL);
-	if (IS_ERR(sdev))
-		return PTR_ERR(sdev);
-
-	scsi_device_put(sdev);
-	return 0;
-}
-EXPORT_SYMBOL(scsi_add_device);
-
 void scsi_rescan_device(struct device *dev)
 {
 	struct scsi_driver *drv;
@@ -1293,8 +1276,27 @@
 }
 EXPORT_SYMBOL(scsi_rescan_device);
 
-static void __scsi_scan_target(struct device *parent, unsigned int channel,
-		unsigned int id, unsigned int lun, int rescan)
+/**
+ * scsi_scan_target - scan a target id, possibly including all LUNs on the
+ *     target.
+ * @sdevsca:	Scsi_Device handle for scanning
+ * @shost:	host to scan
+ * @channel:	channel to scan
+ * @id:		target id to scan
+ *
+ * Description:
+ *     Scan the target id on @shost, @channel, and @id. Scan at least LUN
+ *     0, and possibly all LUNs on the target id.
+ *
+ *     Use the pre-allocated @sdevscan as a handle for the scanning. This
+ *     function sets sdevscan->host, sdevscan->id and sdevscan->lun; the
+ *     scanning functions modify sdevscan->lun.
+ *
+ *     First try a REPORT LUN scan, if that does not scan the target, do a
+ *     sequential scan of LUNs on the target id.
+ **/
+void scsi_scan_target(struct device *parent, unsigned int channel,
+		      unsigned int id, unsigned int lun, int rescan)
 {
 	struct Scsi_Host *shost = dev_to_shost(parent);
 	int bflags = 0;
@@ -1308,7 +1310,9 @@
 		 */
 		return;
 
+
 	starget = scsi_alloc_target(parent, channel, id);
+
 	if (!starget)
 		return;
 
@@ -1354,33 +1358,6 @@
 
 	put_device(&starget->dev);
 }
-
-/**
- * scsi_scan_target - scan a target id, possibly including all LUNs on the
- *     target.
- * @parent:	host to scan
- * @channel:	channel to scan
- * @id:		target id to scan
- * @lun:	Specific LUN to scan or SCAN_WILD_CARD
- * @rescan:	passed to LUN scanning routines
- *
- * Description:
- *     Scan the target id on @parent, @channel, and @id. Scan at least LUN 0,
- *     and possibly all LUNs on the target id.
- *
- *     First try a REPORT LUN scan, if that does not scan the target, do a
- *     sequential scan of LUNs on the target id.
- **/
-void scsi_scan_target(struct device *parent, unsigned int channel,
-		      unsigned int id, unsigned int lun, int rescan)
-{
-	struct Scsi_Host *shost = dev_to_shost(parent);
-
-	down(&shost->scan_mutex);
-	if (scsi_host_scan_allowed(shost))
-		__scsi_scan_target(parent, channel, id, lun, rescan);
-	up(&shost->scan_mutex);
-}
 EXPORT_SYMBOL(scsi_scan_target);
 
 static void scsi_scan_channel(struct Scsi_Host *shost, unsigned int channel,
@@ -1406,12 +1383,10 @@
 				order_id = shost->max_id - id - 1;
 			else
 				order_id = id;
-			__scsi_scan_target(&shost->shost_gendev, channel,
-					order_id, lun, rescan);
+			scsi_scan_target(&shost->shost_gendev, channel, order_id, lun, rescan);
 		}
 	else
-		__scsi_scan_target(&shost->shost_gendev, channel,
-				id, lun, rescan);
+		scsi_scan_target(&shost->shost_gendev, channel, id, lun, rescan);
 }
 
 int scsi_scan_host_selected(struct Scsi_Host *shost, unsigned int channel,
@@ -1509,15 +1484,12 @@
  */
 struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
 {
-	struct scsi_device *sdev = NULL;
+	struct scsi_device *sdev;
 	struct scsi_target *starget;
 
-	down(&shost->scan_mutex);
-	if (!scsi_host_scan_allowed(shost))
-		goto out;
 	starget = scsi_alloc_target(&shost->shost_gendev, 0, shost->this_id);
 	if (!starget)
-		goto out;
+		return NULL;
 
 	sdev = scsi_alloc_sdev(starget, 0, NULL);
 	if (sdev) {
@@ -1525,8 +1497,6 @@
 		sdev->borken = 0;
 	}
 	put_device(&starget->dev);
- out:
-	up(&shost->scan_mutex);
 	return sdev;
 }
 EXPORT_SYMBOL(scsi_get_host_dev);
diff -urN build/drivers/scsi/scsi_sysfs.c build2/drivers/scsi/scsi_sysfs.c
--- build/drivers/scsi/scsi_sysfs.c	2005-09-13 15:13:32.000000000 +1000
+++ build2/drivers/scsi/scsi_sysfs.c	2005-09-14 00:44:57.000000000 +1000
@@ -653,7 +653,7 @@
 			error = attr_add(&sdev->sdev_gendev,
 					sdev->host->hostt->sdev_attrs[i]);
 			if (error) {
-				__scsi_remove_device(sdev);
+				scsi_remove_device(sdev);
 				goto out;
 			}
 		}
@@ -667,7 +667,7 @@
 							scsi_sysfs_sdev_attrs[i]);
 			error = device_create_file(&sdev->sdev_gendev, attr);
 			if (error) {
-				__scsi_remove_device(sdev);
+				scsi_remove_device(sdev);
 				goto out;
 			}
 		}
@@ -687,10 +687,17 @@
 	return error;
 }
 
-void __scsi_remove_device(struct scsi_device *sdev)
+/**
+ * scsi_remove_device - unregister a device from the scsi bus
+ * @sdev:	scsi_device to unregister
+ **/
+void scsi_remove_device(struct scsi_device *sdev)
 {
+	struct Scsi_Host *shost = sdev->host;
+
+	down(&shost->scan_mutex);
 	if (scsi_device_set_state(sdev, SDEV_CANCEL) != 0)
-		return;
+		goto out;
 
 	class_device_unregister(&sdev->sdev_classdev);
 	device_del(&sdev->sdev_gendev);
@@ -699,17 +706,8 @@
 		sdev->host->hostt->slave_destroy(sdev);
 	transport_unregister_device(&sdev->sdev_gendev);
 	put_device(&sdev->sdev_gendev);
-}
-
-/**
- * scsi_remove_device - unregister a device from the scsi bus
- * @sdev:	scsi_device to unregister
- **/
-void scsi_remove_device(struct scsi_device *sdev)
-{
-	down(&sdev->host->scan_mutex);
-	__scsi_remove_device(sdev);
-	up(&sdev->host->scan_mutex);
+out:
+	up(&shost->scan_mutex);
 }
 EXPORT_SYMBOL(scsi_remove_device);
 
diff -urN build/include/scsi/scsi_device.h build2/include/scsi/scsi_device.h
--- build/include/scsi/scsi_device.h	2005-09-13 15:13:32.000000000 +1000
+++ build2/include/scsi/scsi_device.h	2005-09-14 00:44:57.000000000 +1000
@@ -178,8 +178,8 @@
 
 extern struct scsi_device *__scsi_add_device(struct Scsi_Host *,
 		uint, uint, uint, void *hostdata);
-extern int scsi_add_device(struct Scsi_Host *host, uint channel,
-			   uint target, uint lun);
+#define scsi_add_device(host, channel, target, lun) \
+	__scsi_add_device(host, channel, target, lun, NULL)
 extern void scsi_remove_device(struct scsi_device *);
 extern int scsi_device_cancel(struct scsi_device *, int);
 

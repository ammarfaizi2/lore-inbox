Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSIQWqf>; Tue, 17 Sep 2002 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSIQWqe>; Tue, 17 Sep 2002 18:46:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9954 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264666AbSIQWpZ>;
	Tue, 17 Sep 2002 18:45:25 -0400
Date: Tue, 17 Sep 2002 15:50:18 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 1/7 2.5.35 SCSI multi-path
Message-ID: <20020917155018.A18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917154940.A18401@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:49:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 3 to add mid-layer scsi changes to simplify and enable the
addition of scsi multi-path IO support.

The bulk (number of lines changed) of these changes are:

	add a Scsi_Device iterator

	add and use functions for removal and addition of a Scsi_Device

	add hooks for calls to multi-path functions - with this patch, the
	hooks are either NULL code, or code that matches the current scsi
	behaviour

 hosts.c      |   25 +--
 hosts.h      |   30 +++-
 scsi.c       |  429 +++++++++++++++++++++++++++++------------------------------
 scsi_error.c |  189 +++++++++++++++----------
 4 files changed, 364 insertions(+), 309 deletions(-)

diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/hosts.c	Mon Sep 16 15:29:45 2002
@@ -259,30 +259,27 @@
     return retval;
 }
 
-void scsi_host_busy_inc(struct Scsi_Host *shost, Scsi_Device *sdev)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(shost->host_lock, flags);
-	shost->host_busy++;
-	sdev->device_busy++;
-	spin_unlock_irqrestore(shost->host_lock, flags);
-}
-
+/*
+ * Decrement shost->host_busy, and check if any conditions require action.
+ * Must be called with the queue_lock held. Hack to get the host_lock if
+ * host_lock and queue_lock are different.
+ */
 void scsi_host_busy_dec_and_test(struct Scsi_Host *shost, Scsi_Device *sdev)
 {
-	unsigned long flags;
+	unsigned long flags = 0;
+	request_queue_t *q = &sdev->request_queue;
 
-	spin_lock_irqsave(shost->host_lock, flags);
+	if (q->queue_lock != shost->host_lock)
+		spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_busy--;
-	sdev->device_busy--;
 	if (shost->in_recovery && (shost->host_busy == shost->host_failed)) {
 		up(shost->eh_wait);
 		SCSI_LOG_ERROR_RECOVERY(5, printk("Waking error handler"
 					  "thread (%d)\n",
 					  atomic_read(&shost->eh_wait->count)));
 	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
+	if (q->queue_lock != shost->host_lock)
+		spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
 void scsi_host_failed_inc_and_test(struct Scsi_Host *shost)
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/hosts.h	Mon Sep 16 15:29:45 2002
@@ -576,7 +576,6 @@
 #define SD_EXTRA_DEVS CONFIG_SD_EXTRA_DEVS
 #define SR_EXTRA_DEVS CONFIG_SR_EXTRA_DEVS
 
-
 /**
  * scsi_find_device - find a device given the host
  * @channel:	SCSI channel (zero if only one channel)
@@ -589,13 +588,40 @@
 
         for(SDpnt = host->host_queue;
             SDpnt != NULL;
-            SDpnt = SDpnt->next)
+            SDpnt = SDpnt->sdev_next)
                 if(SDpnt->channel == channel && SDpnt->id == pun
                    && SDpnt->lun ==lun)
                         break;
         return SDpnt;
 }
     
+/*
+ * XXX For now, check for the existence of the NUMA topology patch via the
+ * define of MAX_NR_MEMBLKS.
+ */
+#if defined(CONFIG_MULTIQUAD) && defined(MAX_NR_MEMBLKS)
+static inline int scsihost_to_node(struct Scsi_Host *host)
+{
+        if (!host) {
+                printk("%s: host == NULL \n", __FUNCTION__);
+                return 0;
+        }
+        if(host->pci_dev)
+                return pcidev_to_node(host->pci_dev);
+
+	/*
+	 * XXX umm what about usb and ide over scsi?
+	 */
+        printk("%s: Unable to determine bus type\n", __FUNCTION__);
+        return 0;
+}
+#else
+/* 
+ * In the absence of NUMA, assign to node 0 
+ */
+#define scsihost_to_node(host)	0
+#endif /* CONFIG_MULTIQUAD */
+
 #endif
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi.c	Mon Sep 16 15:29:45 2002
@@ -142,7 +142,7 @@
  * Note - the initial logging level can be set here to log events at boot time.
  * After the system is up, you may enable logging via the /proc interface.
  */
-unsigned int scsi_logging_level;
+unsigned int scsi_logging_level = 0x00000140 /* XXX scan log remove */;
 
 const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE] =
 {
@@ -318,7 +318,6 @@
 	memset(SRpnt, 0, size);
         SRpnt->sr_request = (struct request *)(((char *)SRpnt) + offset);
 	SRpnt->sr_device = device;
-	SRpnt->sr_host = device->host;
 	SRpnt->sr_magic = SCSI_REQ_MAGIC;
 	SRpnt->sr_data_direction = SCSI_DATA_UNKNOWN;
 
@@ -381,17 +380,18 @@
  */
 
 Scsi_Cmnd *scsi_allocate_device(Scsi_Device * device, int wait, 
-                                int interruptable)
+                                int interruptable, struct scsi_path_id *path_p)
 {
  	struct Scsi_Host *host;
   	Scsi_Cmnd *SCpnt = NULL;
 	Scsi_Device *SDpnt;
 	unsigned long flags;
+	scsi_traverse_hndl_t STrav_hndl;
   
   	if (!device)
   		panic("No device passed to scsi_allocate_device().\n");
   
-  	host = device->host;
+  	host = path_p->spi_shpnt;
   
 	spin_lock_irqsave(&device_request_lock, flags);
  
@@ -413,16 +413,11 @@
 				 * allow us to more easily figure out whether we should
 				 * do anything here or not.
 				 */
-				for (SDpnt = host->host_queue;
-				     SDpnt;
-				     SDpnt = SDpnt->next) {
-					/*
-					 * Only look for other devices on the same bus
-					 * with the same target ID.
-					 */
-					if (SDpnt->channel != device->channel
-					    || SDpnt->id != device->id
-					    || SDpnt == device) {
+				scsi_for_each_sdev_lun(&STrav_hndl, SDpnt,
+						host->host_no,
+						path_p->spi_channel, 
+						path_p->spi_id) {
+					if (SDpnt == device) {
  						continue;
 					}
                                         if( atomic_read(&SDpnt->device_active) != 0)
@@ -513,6 +508,8 @@
 		}
 	}
 
+	scsi_path_set_scmnd_ids(SCpnt, path_p);
+
 	SCpnt->request = NULL;
 	atomic_inc(&SCpnt->host->host_active);
 	atomic_inc(&SCpnt->device->device_active);
@@ -608,8 +605,10 @@
 {
         request_queue_t *q;
         Scsi_Device * SDpnt;
+	struct Scsi_Host * SHpnt;
 
         SDpnt = SCpnt->device;
+	SHpnt = SCpnt->host;
 
         __scsi_release_command(SCpnt);
 
@@ -620,7 +619,7 @@
          * will go on.  
          */
         q = &SDpnt->request_queue;
-        scsi_queue_next_request(q, NULL);                
+        scsi_queue_next_request(q, NULL, SHpnt); 
 }
 
 /*
@@ -689,10 +688,12 @@
 	 * We will use a queued command if possible, otherwise we will emulate the
 	 * queuing and calling of completion function ourselves.
 	 */
-	SCSI_LOG_MLQUEUE(3, printk("scsi_dispatch_cmnd (host = %d, channel = %d, target = %d, "
-	       "command = %p, buffer = %p, \nbufflen = %d, done = %p)\n",
-	SCpnt->host->host_no, SCpnt->channel, SCpnt->target, SCpnt->cmnd,
-			    SCpnt->buffer, SCpnt->bufflen, SCpnt->done));
+	SCSI_LOG_MLQUEUE(3, 
+		printk("scsi_dispatch_cmnd (host = %d, channel = %d, target"
+		       " = %d, lun = %d,\n command = %p, buffer = %p,"
+		       " bufflen = %d, done = %p)\n", SCpnt->host->host_no,
+		       SCpnt->channel, SCpnt->target, SCpnt->lun, SCpnt->cmnd,
+		       SCpnt->buffer, SCpnt->bufflen, SCpnt->done));
 
 	SCpnt->state = SCSI_STATE_QUEUED;
 	SCpnt->owner = SCSI_OWNER_LOWLEVEL;
@@ -808,30 +809,17 @@
 	      void *buffer, unsigned bufflen, void (*done) (Scsi_Cmnd *),
 		 int timeout, int retries)
 {
-	Scsi_Device * SDpnt = SRpnt->sr_device;
-	struct Scsi_Host *host = SDpnt->host;
-
-	ASSERT_LOCK(host->host_lock, 0);
-
 	SCSI_LOG_MLQUEUE(4,
 			 {
 			 int i;
-			 int target = SDpnt->id;
 			 int size = COMMAND_SIZE(((const unsigned char *)cmnd)[0]);
-			 printk("scsi_do_req (host = %d, channel = %d target = %d, "
-		    "buffer =%p, bufflen = %d, done = %p, timeout = %d, "
-				"retries = %d)\n"
-				"command : ", host->host_no, SDpnt->channel, target, buffer,
-				bufflen, done, timeout, retries);
+			 printk("scsi_do_req (buffer =%p, bufflen = %d, done = "
+				" %p, timeout = %d, retries = %d)\n command : ",
+				buffer, bufflen, done, timeout, retries);
 			 for (i	 = 0; i < size; ++i)
 			 	printk("%02x  ", ((unsigned char *) cmnd)[i]);
 			 	printk("\n");
 			 });
-
-	if (!host) {
-		panic("Invalid or not present host.\n");
-	}
-
 	/*
 	 * If the upper level driver is reusing these things, then
 	 * we should release the low-level block now.  Another one will
@@ -1199,6 +1187,15 @@
 
 				scsi_retry_command(SCpnt);
 				break;
+			case REQUEUE:
+				/*
+				 * Resend the IO, likely using a different
+				 * path.
+				 */
+				SCSI_LOG_MLCOMPLETE(3, printk("Requeuing IO %d %d 0x%x\n", SCpnt->host->host_busy,
+				SCpnt->host->host_failed, SCpnt->result));
+				scsi_mlqueue_insert(SCpnt, SCSI_MLQUEUE_RETRY);
+				break;
 			case ADD_TO_MLQUEUE:
 				/* 
 				 * This typically happens for a QUEUE_FULL
@@ -1291,6 +1288,7 @@
 	struct Scsi_Host *host;
 	Scsi_Device *device;
 	Scsi_Request * SRpnt;
+	unsigned long flags;
 
 	host = SCpnt->host;
 	device = SCpnt->device;
@@ -1304,7 +1302,11 @@
          * one execution context, but the device and host structures are
          * shared.
          */
+	spin_lock_irqsave(device->request_queue.queue_lock, flags);
+	device->device_busy--;
 	scsi_host_busy_dec_and_test(host, device);
+	spin_unlock_irqrestore(device->request_queue.queue_lock, flags);
+
 
         /*
          * Clear the flags which say that the device/host is no longer
@@ -1323,7 +1325,7 @@
 		SCpnt->result |= (DRIVER_SENSE << 24);
 	}
 	SCSI_LOG_MLCOMPLETE(3, printk("Notifying upper driver of completion for device %d %x\n",
-				      SCpnt->device->id, SCpnt->result));
+				      SCpnt->target, SCpnt->result));
 
 	SCpnt->owner = SCSI_OWNER_HIGHLEVEL;
 	SCpnt->state = SCSI_STATE_FINISHED;
@@ -1392,12 +1394,18 @@
 void scsi_build_commandblocks(Scsi_Device * SDpnt)
 {
 	unsigned long flags;
-	struct Scsi_Host *host = SDpnt->host;
+	struct Scsi_Host *host;
 	int j;
 	Scsi_Cmnd *SCpnt;
 
 	spin_lock_irqsave(&device_request_lock, flags);
 
+	host = scsi_get_host(SDpnt);
+	/*
+	 * We are called during scan, and must always have at least one
+	 * path.
+	 */
+	BUG_ON(host == NULL);
 	if (SDpnt->queue_depth == 0)
 	{
 		SDpnt->queue_depth = host->cmd_per_lun;
@@ -1415,10 +1423,10 @@
 			break;	/* If not, the next line will oops ... */
 		memset(SCpnt, 0, sizeof(Scsi_Cmnd));
 		SCpnt->host = host;
-		SCpnt->device = SDpnt;
 		SCpnt->target = SDpnt->id;
 		SCpnt->lun = SDpnt->lun;
 		SCpnt->channel = SDpnt->channel;
+		SCpnt->device = SDpnt;
 		SCpnt->request = NULL;
 		SCpnt->use_sg = 0;
 		SCpnt->old_use_sg = 0;
@@ -1477,44 +1485,37 @@
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int length)
 {
 	Scsi_Device *scd;
-	struct Scsi_Host *HBA_ptr;
+	scsi_traverse_hndl_t STrav_hndl;
 	int size, len = 0;
 	off_t begin = 0;
 	off_t pos = 0;
+	int header_output = 0;
 
-	/*
-	 * First, see if there are any attached devices or not.
-	 */
-	for (HBA_ptr = scsi_hostlist; HBA_ptr; HBA_ptr = HBA_ptr->next) {
-		if (HBA_ptr->host_queue != NULL) {
-			break;
+	scsi_for_all_sdevs(&STrav_hndl, scd) {
+		if (!header_output) {
+			size = sprintf(buffer + len, "Attached devices:\n");
+			len += size;
+			pos = begin + len;
+			header_output = 1;
 		}
-	}
-	size = sprintf(buffer + len, "Attached devices: %s\n", (HBA_ptr) ? "" : "none");
-	len += size;
-	pos = begin + len;
-	for (HBA_ptr = scsi_hostlist; HBA_ptr; HBA_ptr = HBA_ptr->next) {
-#if 0
-		size += sprintf(buffer + len, "scsi%2d: %s\n", (int) HBA_ptr->host_no,
-				HBA_ptr->hostt->procname);
+		proc_print_scsidevice(scd, buffer, &size, len);
 		len += size;
 		pos = begin + len;
-#endif
-		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
-			proc_print_scsidevice(scd, buffer, &size, len);
-			len += size;
-			pos = begin + len;
 
-			if (pos < offset) {
-				len = 0;
-				begin = pos;
-			}
-			if (pos > offset + length)
-				goto stop_output;
+		if (pos < offset) {
+			len = 0;
+			begin = pos;
 		}
+		if (pos > offset + length)
+			goto stop_output;
 	}
 
 stop_output:
+	if (!header_output) {
+		size = sprintf(buffer + len, "Attached devices: none\n");
+		len += size;
+		pos = begin + len;
+	}
 	*start = buffer + (offset - begin);	/* Start of wanted data */
 	len -= (offset - begin);	/* Start slop */
 	if (len > length)
@@ -1669,13 +1670,7 @@
 		if (!HBA_ptr)
 			goto out;
 
-		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
-			if ((scd->channel == channel
-			     && scd->id == id
-			     && scd->lun == lun)) {
-				break;
-			}
-		}
+		scd = scsi_locate_sdev(host, channel, id, lun);
 
 		err = -ENOSYS;
 		if (scd)
@@ -1721,13 +1716,7 @@
 		if (!HBA_ptr)
 			goto out;
 
-		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
-			if ((scd->channel == channel
-			     && scd->id == id
-			     && scd->lun == lun)) {
-				break;
-			}
-		}
+		scd = scsi_locate_sdev(host, channel, id, lun);
 
 		if (scd == NULL)
 			goto out;	/* there is no such device attached */
@@ -1744,6 +1733,10 @@
 		}
 
 		if (scd->attached == 0) {
+			scsi_remove_path(scd, SCSI_FIND_ALL_HOST_NO,
+					 SCSI_FIND_ALL_CHANNEL,
+					 SCSI_FIND_ALL_ID,
+					 SCSI_FIND_ALL_LUN);
 			/*
 			 * Nobody is using this device any more.
 			 * Free all of the command structures.
@@ -1752,21 +1745,11 @@
                                 HBA_ptr->hostt->revoke(scd);
 			devfs_unregister (scd->de);
 			scsi_release_commandblocks(scd);
-
-			/* Now we can remove the device structure */
-			if (scd->next != NULL)
-				scd->next->prev = scd->prev;
-
-			if (scd->prev != NULL)
-				scd->prev->next = scd->next;
-
-			if (HBA_ptr->host_queue == scd) {
-				HBA_ptr->host_queue = scd->next;
-			}
 			blk_cleanup_queue(&scd->request_queue);
 			if (scd->inquiry)
 				kfree(scd->inquiry);
-			kfree((char *) scd);
+			/* Now we can remove the device structure */
+			scsi_remove_scsi_device(scd);
 		} else {
 			goto out;
 		}
@@ -1791,6 +1774,7 @@
 	struct Scsi_Device_Template *sdtpnt;
 	const char *name;
 	int out_of_space = 0;
+	scsi_traverse_hndl_t STrav_hndl;
 
 	if (tpnt->next || !tpnt->detect)
 		return 1;	/* Must be already loaded, or
@@ -1901,18 +1885,19 @@
 		/*
 		 * Next we create the Scsi_Cmnd structures for this host 
 		 */
-		for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-			for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next)
-				if (SDpnt->host->hostt == tpnt) {
-					for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next)
-						if (sdtpnt->attach)
-							(*sdtpnt->attach) (SDpnt);
-					if (SDpnt->attached) {
-						scsi_build_commandblocks(SDpnt);
-						if (0 == SDpnt->has_cmdblocks)
-							out_of_space = 1;
-					}
+		scsi_for_all_sdevs(&STrav_hndl, SDpnt) {
+			shpnt = scsi_get_host(SDpnt);
+			if (shpnt && shpnt->hostt == tpnt) {
+				for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next)
+					if (sdtpnt->attach)
+						(*sdtpnt->attach) (SDpnt);
+				if (SDpnt->attached && (0 ==
+				    SDpnt->has_cmdblocks)) {
+					scsi_build_commandblocks(SDpnt);
+					if (0 == SDpnt->has_cmdblocks)
+						out_of_space = 1;
 				}
+			}
 		}
 
 		/* This does any final handling that is required. */
@@ -1943,8 +1928,9 @@
 	Scsi_Device *SDpnt1;
 	struct Scsi_Device_Template *sdtpnt;
 	struct Scsi_Host *sh1;
-	struct Scsi_Host *shpnt;
+	struct Scsi_Host *shpnt, *shpnt2;
 	char name[10];	/* host_no>=10^9? I don't think so. */
+	scsi_traverse_hndl_t STrav_hndl;
 
 	/* get the big kernel lock, so we don't race with open() */
 	lock_kernel();
@@ -1954,12 +1940,16 @@
 	 * commands 
 	 */
 	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (SDpnt->host->hostt == tpnt
-			    && SDpnt->host->hostt->module
-			    && GET_USE_COUNT(SDpnt->host->hostt->module))
-				goto err_out;
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, shpnt->host_no) {
+			/*
+			 * If any shpnt2 is still in use, it should be
+			 * impossible to call this function.
+			 */
+			shpnt2 = scsi_get_host(SDpnt);
+			if (shpnt2 && shpnt2->hostt == tpnt
+			    && shpnt2->hostt->module
+			    && GET_USE_COUNT(shpnt2->hostt->module))
+				BUG();
 			/* 
 			 * FIXME(eric) - We need to find a way to notify the
 			 * low level driver that we are shutting down - via the
@@ -1976,9 +1966,9 @@
 	 * get in and queue a command.
 	 */
 	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (SDpnt->host->hostt == tpnt)
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, shpnt->host_no) {
+			shpnt2 = scsi_get_host(SDpnt);
+			if (shpnt2 && shpnt2->hostt == tpnt)
 				SDpnt->online = FALSE;
 
 		}
@@ -1988,8 +1978,7 @@
 		if (shpnt->hostt != tpnt) {
 			continue;
 		}
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, shpnt->host_no) {
 			/*
 			 * Loop over all of the commands associated with the device.  If any of
 			 * them are busy, then set the state back to inactive and bail.
@@ -1998,12 +1987,12 @@
 			     SCpnt = SCpnt->next) {
 				online_status = SDpnt->online;
 				SDpnt->online = FALSE;
-				if (SCpnt->request && SCpnt->request->rq_status != RQ_INACTIVE) {
+				if ((SCpnt->request && SCpnt->request->rq_status != RQ_INACTIVE)
+				    && SCpnt->request->rq_status != RQ_SCSI_DISCONNECTING) {
 					printk(KERN_ERR "SCSI device not inactive - rq_status=%d, target=%d, pid=%ld, state=%d, owner=%d.\n",
 					       SCpnt->request->rq_status, SCpnt->target, SCpnt->pid,
 					     SCpnt->state, SCpnt->owner);
-					for (SDpnt1 = shpnt->host_queue; SDpnt1;
-					     SDpnt1 = SDpnt1->next) {
+					scsi_for_each_host_sdev(&STrav_hndl, SDpnt1, shpnt->host_no) {
 						for (SCpnt = SDpnt1->device_queue; SCpnt;
 						     SCpnt = SCpnt->next)
 							if (SCpnt->request->rq_status == RQ_SCSI_DISCONNECTING)
@@ -2029,18 +2018,20 @@
 		if (shpnt->hostt != tpnt) {
 			continue;
 		}
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next)
-				if (sdtpnt->detach)
-					(*sdtpnt->detach) (SDpnt);
-
-			/* If something still attached, punt */
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, shpnt->host_no) {
 			if (SDpnt->attached) {
-				printk(KERN_ERR "Attached usage count = %d\n", SDpnt->attached);
-				goto err_out;
+				for (sdtpnt = scsi_devicelist; sdtpnt; sdtpnt = sdtpnt->next) {
+					if (sdtpnt->detach)
+						(*sdtpnt->detach) (SDpnt);
+				}
+
+				/* If something still attached, punt */
+				if (SDpnt->attached) {
+					printk(KERN_ERR "Attached usage count = %d\n", SDpnt->attached);
+					goto err_out;
+				}
+				devfs_unregister (SDpnt->de);
 			}
-			devfs_unregister (SDpnt->de);
 			put_device(&SDpnt->sdev_driverfs_dev);
 		}
 	}
@@ -2066,17 +2057,15 @@
 		if (shpnt->hostt != tpnt) {
 			continue;
 		}
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = shpnt->host_queue) {
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, shpnt->host_no) {
+			/* Next free up the Scsi_Device structures for this host */
+			scsi_remove_path(SDpnt, shpnt->host_no,
+					 SCSI_FIND_ALL_CHANNEL,
+					 SCSI_FIND_ALL_ID,
+					 SCSI_FIND_ALL_LUN);
 			scsi_release_commandblocks(SDpnt);
-
 			blk_cleanup_queue(&SDpnt->request_queue);
-			/* Next free up the Scsi_Device structures for this host */
-			shpnt->host_queue = SDpnt->next;
-			if (SDpnt->inquiry)
-				kfree(SDpnt->inquiry);
-			kfree((char *) SDpnt);
-
+			scsi_remove_scsi_device(SDpnt);
 		}
 	}
 
@@ -2150,8 +2139,8 @@
 int scsi_register_device(struct Scsi_Device_Template *tpnt)
 {
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *shpnt;
 	int out_of_space = 0;
+	scsi_traverse_hndl_t STrav_hndl;
 
 #ifdef CONFIG_KMOD
 	if (scsi_hosts == NULL)
@@ -2168,12 +2157,9 @@
 	 * First scan the devices that we know about, and see if we notice them.
 	 */
 
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (tpnt->detect)
-				SDpnt->attached += (*tpnt->detect) (SDpnt);
-		}
+	scsi_for_all_sdevs(&STrav_hndl, SDpnt) {
+		if (tpnt->detect)
+			SDpnt->attached += (*tpnt->detect) (SDpnt);
 	}
 
 	/*
@@ -2187,21 +2173,24 @@
 	/*
 	 * Now actually connect the devices to the new driver.
 	 */
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (tpnt->attach)
-				(*tpnt->attach) (SDpnt);
-			/*
-			 * If this driver attached to the device, and don't have any
-			 * command blocks for this device, allocate some.
-			 */
-			if (SDpnt->attached && SDpnt->has_cmdblocks == 0) {
-				SDpnt->online = TRUE;
-				scsi_build_commandblocks(SDpnt);
-				if (0 == SDpnt->has_cmdblocks)
-					out_of_space = 1;
-			}
+	scsi_for_all_sdevs(&STrav_hndl, SDpnt) {
+		/*
+		 * We know this device cannot already be attached,
+		 * since this is the first chance we have to call
+		 * the tpnt->attach, unlike registration of the adapter
+		 * (in scsi_register_host).
+		 */
+		if (tpnt->attach)
+			(*tpnt->attach) (SDpnt);
+		/*
+		 * If this driver attached to the device, and don't have any
+		 * command blocks for this device, allocate some.
+		 */
+		if (SDpnt->attached && SDpnt->has_cmdblocks == 0) {
+			SDpnt->online = TRUE;
+			scsi_build_commandblocks(SDpnt);
+			if (0 == SDpnt->has_cmdblocks)
+				out_of_space = 1;
 		}
 	}
 
@@ -2222,9 +2211,9 @@
 int scsi_unregister_device(struct Scsi_Device_Template *tpnt)
 {
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *shpnt;
 	struct Scsi_Device_Template *spnt;
 	struct Scsi_Device_Template *prev_spnt;
+	scsi_traverse_hndl_t STrav_hndl;
 	
 	lock_kernel();
 	/*
@@ -2237,22 +2226,20 @@
 	 * Next, detach the devices from the driver.
 	 */
 
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (tpnt->detach)
-				(*tpnt->detach) (SDpnt);
-			if (SDpnt->attached == 0) {
-				SDpnt->online = FALSE;
+	scsi_for_all_sdevs(&STrav_hndl, SDpnt) {
+		if (tpnt->detach)
+			(*tpnt->detach) (SDpnt);
+		if (SDpnt->attached == 0) {
+			SDpnt->online = FALSE;
 
-				/*
-				 * Nobody is using this device any more.  Free all of the
-				 * command structures.
-				 */
-				scsi_release_commandblocks(SDpnt);
-			}
+			/*
+			 * Nobody is using this device any more.  Free all of the
+			 * command structures.
+			 */
+			scsi_release_commandblocks(SDpnt);
 		}
 	}
+
 	/*
 	 * Extract the template from the linked list.
 	 */
@@ -2305,6 +2292,8 @@
 	struct Scsi_Host *shpnt;
 	Scsi_Cmnd *SCpnt;
 	Scsi_Device *SDpnt;
+	scsi_traverse_hndl_t STrav_hndl;
+
 	printk(KERN_INFO "Dump of scsi host parameters:\n");
 	i = 0;
 	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
@@ -2318,38 +2307,36 @@
 
 	printk(KERN_INFO "\n\n");
 	printk(KERN_INFO "Dump of scsi command parameters:\n");
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		printk(KERN_INFO "h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result\n");
-		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
-			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
-				/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
-				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4ld %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
-				       i++,
-
-				       SCpnt->host->host_no,
-				       SCpnt->channel,
-				       SCpnt->target,
-				       SCpnt->lun,
-
-				       kdevname(SCpnt->request->rq_dev),
-				       SCpnt->request->sector,
-				       SCpnt->request->nr_sectors,
-				       (long)SCpnt->request->current_nr_sectors,
-				       SCpnt->request->rq_status,
-				       SCpnt->use_sg,
-
-				       SCpnt->retries,
-				       SCpnt->allowed,
-				       SCpnt->flags,
-
-				       SCpnt->timeout_per_command,
-				       SCpnt->timeout,
-				       SCpnt->internal_timeout,
-
-				       SCpnt->cmnd[0],
-				       SCpnt->sense_buffer[2],
-				       SCpnt->result);
-			}
+	printk(KERN_INFO "h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result\n");
+	scsi_for_all_sdevs(&STrav_hndl, SDpnt) {
+		for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
+			/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
+			printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4ld %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
+			       i++,
+
+			       SCpnt->host->host_no,
+			       SCpnt->channel,
+			       SCpnt->target,
+			       SCpnt->lun,
+
+			       kdevname(SCpnt->request->rq_dev),
+			       SCpnt->request->sector,
+			       SCpnt->request->nr_sectors,
+			       (long)SCpnt->request->current_nr_sectors,
+			       SCpnt->request->rq_status,
+			       SCpnt->use_sg,
+
+			       SCpnt->retries,
+			       SCpnt->allowed,
+			       SCpnt->flags,
+
+			       SCpnt->timeout_per_command,
+			       SCpnt->timeout,
+			       SCpnt->internal_timeout,
+
+			       SCpnt->cmnd[0],
+			       SCpnt->sense_buffer[2],
+			       SCpnt->result);
 		}
 	}
 #endif	/* CONFIG_SCSI_LOGGING */ /* } */
@@ -2592,15 +2579,21 @@
         if(SDpnt == NULL)
         	return NULL;
         	
+	scsi_add_scsi_device(SDpnt, SHpnt);
         memset(SDpnt, 0, sizeof(Scsi_Device));
 	SDpnt->vendor = scsi_null_device_strs;
 	SDpnt->model = scsi_null_device_strs;
 	SDpnt->rev = scsi_null_device_strs;
 
-        SDpnt->host = SHpnt;
-        SDpnt->id = SHpnt->this_id;
         SDpnt->type = -1;
         SDpnt->queue_depth = 1;
+	/*
+	 * add a path: host is SHpnt, channel 0, id is SHpnt->this_id, lun 0
+	 */
+	if (scsi_add_path(SDpnt, SHpnt, 0, SHpnt->this_id, 0)) {
+		scsi_remove_scsi_device(SDpnt);
+		return NULL;
+	}
         
 	scsi_build_commandblocks(SDpnt);
 
@@ -2630,11 +2623,17 @@
  */
 void scsi_free_host_dev(Scsi_Device * SDpnt)
 {
-        if( (unsigned char) SDpnt->id != (unsigned char) SDpnt->host->this_id )
-        {
+	struct scsi_path_id scsi_path;
+
+	scsi_get_path(SDpnt, &scsi_path);
+	if ((unsigned char) scsi_path.spi_id != (unsigned char)
+	    scsi_path.spi_shpnt->this_id) {
                 panic("Attempt to delete wrong device\n");
         }
-
+	scsi_remove_path(SDpnt, scsi_path.spi_shpnt->host_no,
+			 scsi_path.spi_channel,
+			 scsi_path.spi_id,
+			 scsi_path.spi_lun);
         blk_cleanup_queue(&SDpnt->request_queue);
 
         /*
@@ -2642,9 +2641,7 @@
          * it now.
          */
 	scsi_release_commandblocks(SDpnt);
-	if (SDpnt->inquiry)
-		kfree(SDpnt->inquiry);
-        kfree(SDpnt);
+	scsi_remove_scsi_device(SDpnt);
 }
 
 /*
@@ -2682,14 +2679,16 @@
 	Scsi_Cmnd SC, *SCpnt = &SC;
         struct request req;
 	int rtn;
+	struct scsi_path_id scsi_path;
 
         SCpnt->request = &req;
 	memset(&SCpnt->eh_timeout, 0, sizeof(SCpnt->eh_timeout));
-	SCpnt->host                    	= dev->host;
+	scsi_get_path(dev, &scsi_path);
+	SCpnt->host                    	= scsi_path.spi_shpnt;
 	SCpnt->device                  	= dev;
-	SCpnt->target                  	= dev->id;
-	SCpnt->lun                     	= dev->lun;
-	SCpnt->channel                 	= dev->channel;
+	SCpnt->target                  	= scsi_path.spi_id;
+	SCpnt->lun                     	= scsi_path.spi_lun;
+	SCpnt->channel                 	= scsi_path.spi_channel;
 	SCpnt->request->rq_status      	= RQ_SCSI_BUSY;
 	SCpnt->request->waiting        	= NULL;
 	SCpnt->use_sg                  	= 0;
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_error.c	Mon Sep 16 15:29:45 2002
@@ -126,37 +126,6 @@
 }
 
 /**
- * scsi_times_out - Timeout function for normal scsi commands.
- * @scmd:	Cmd that is timing out.
- *
- * Notes:
- *     We do not need to lock this.  There is the potential for a race
- *     only in that the normal completion handling might run, but if the
- *     normal completion function determines that the timer has already
- *     fired, then it mustn't do anything.
- **/
-void scsi_times_out(Scsi_Cmnd *scmd)
-{
-	/* Set the serial_number_at_timeout to the current serial_number */
-	scmd->serial_number_at_timeout = scmd->serial_number;
-
-	scsi_eh_eflags_set(scmd, SCSI_EH_CMD_TIMEOUT | SCSI_EH_CMD_ERR);
-
-	if( scmd->host->eh_wait == NULL ) {
-		panic("Error handler thread not present at %p %p %s %d",
-		      scmd, scmd->host, __FILE__, __LINE__);
-	}
-
-	scsi_host_failed_inc_and_test(scmd->host);
-
-	SCSI_LOG_TIMEOUT(3, printk("Command timed out active=%d busy=%d "
-				   "failed=%d\n",
-				   atomic_read(&scmd->host->host_active),
-				   scmd->host->host_busy,
-				   scmd->host->host_failed));
-}
-
-/**
  * scsi_block_when_processing_errors - Prevent cmds from being queued.
  * @sdev:	Device on which we are performing recovery.
  *
@@ -172,7 +141,6 @@
 {
 
 	SCSI_SLEEP(&sdev->host->host_wait, sdev->host->in_recovery);
-
 	SCSI_LOG_ERROR_RECOVERY(5, printk("Open returning %d\n",
 					  sdev->online));
 
@@ -193,9 +161,9 @@
 	int cmd_failed = 0;
 	int cmd_timed_out = 0;
 	int devices_failed = 0;
+	scsi_traverse_hndl_t strav_hndl;
 
-
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (scmd = sc_list; scmd; scmd = scmd->bh_next) {
 			if (scmd->device == sdev) {
 				++total_failures;
@@ -208,12 +176,13 @@
 		}
 
 		if (cmd_timed_out || cmd_failed) {
-			SCSI_LOG_ERROR_RECOVERY(3,
-				printk("scsi_eh: %d:%d:%d:%d cmds failed: %d,"
-				       "timedout: %d\n",
-				       shost->host_no, sdev->channel,
-				       sdev->id, sdev->lun,
-				       cmd_failed, cmd_timed_out));
+			SCSI_LOG_ERROR_RECOVERY(3, {
+				printk("scsi_eh: device at ");
+				scsi_paths_printk(sdev, " ",
+						  "<%d, %d, %d, %d>");
+				printk(" cmds failed: %d, timedout: %d\n",
+				       cmd_failed, cmd_timed_out); 
+			});
 			cmd_timed_out = 0;
 			cmd_failed = 0;
 			++devices_failed;
@@ -239,8 +208,10 @@
 	int found;
 	Scsi_Device *sdev;
 	Scsi_Cmnd *scmd;
+	scsi_traverse_hndl_t strav_hndl;
 
-	for (found = 0, sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	found = 0;
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (scmd = sdev->device_queue; scmd; scmd = scmd->next) {
 			if (scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR)) {
 				scmd->bh_next = *sc_list;
@@ -285,7 +256,7 @@
  * scsi_check_sense - Examine scsi cmd sense
  * @scmd:	Cmd to have sense checked.
  **/
-static int scsi_check_sense(Scsi_Cmnd *scmd)
+int scsi_check_sense(Scsi_Cmnd *scmd)
 {
 	if (!SCSI_SENSE_VALID(scmd)) {
 		return FAILED;
@@ -836,6 +807,72 @@
 }
 
 /**
+ * scsi_times_out - Timeout function for normal scsi commands.
+ * @scmd:	Cmd that is timing out.
+ *
+ * Notes:
+ *     We do not need to lock this.  There is the potential for a race
+ *     only in that the normal completion handling might run, but if the
+ *     normal completion function determines that the timer has already
+ *     fired, then it mustn't do anything.
+ **/
+void scsi_times_out(Scsi_Cmnd *scmd)
+{
+
+	/*
+	 * We can get here with DID_ERROR set, meaning someone has touched
+	 * the result. For qlogicfc, it looks like it might change the
+	 * result, even though it does not let us know the IO has
+	 * completed (on loop down)! So, don't just or in DID_TIME_OUT.
+	 *
+	 * XXX maybe only set DRIVER_TIMEOUT? We then need changes in
+	 * scsi_path_decide_disposition.
+	 */
+	scmd->result = (scmd->result & 0xff00ffff) | (DID_TIME_OUT << 16) |
+		(DRIVER_TIMEOUT << 24);
+	if (scsi_path_decide_disposition(scmd) == REQUEUE) {
+		/*
+		 * Abort the command, and then requeue it.
+		 *
+		 * XXX If the abort is not possible, what do we do?
+		 * Probably should not retry. But, for example, qlogicfc.c
+		 * times out commands after a loop down, and the command
+		 * is no longer live; so the abort command always fails
+		 * after a loop down causes the command to timeout. This
+		 * is also a problem for the current error handling, since
+		 * it does not know if the command was not able to be
+		 * aborted, or if the command failed to abort because the
+		 * adapter no longer has it.
+		 */
+		(void)scsi_try_to_abort_cmd(scmd);
+		SCSI_LOG_TIMEOUT(3, 
+			printk("Requeuing timed out IO host %d channel %d id % d lun %d; result 0x%x\n",
+			       scmd->host->host_no, scmd->channel,
+			       scmd->target, scmd->lun, scmd->result));
+		scsi_mlqueue_insert(scmd, SCSI_MLQUEUE_RETRY);
+		return;
+	}
+
+	/* Set the serial_number_at_timeout to the current serial_number */
+	scmd->serial_number_at_timeout = scmd->serial_number;
+
+	scsi_eh_eflags_set(scmd, SCSI_EH_CMD_TIMEOUT | SCSI_EH_CMD_ERR);
+
+	if( scmd->host->eh_wait == NULL ) {
+		panic("Error handler thread not present at %p %p %s %d",
+		      scmd, scmd->host, __FILE__, __LINE__);
+	}
+
+	scsi_host_failed_inc_and_test(scmd->host);
+
+	SCSI_LOG_TIMEOUT(3, printk("Command timed out active=%d busy=%d "
+				   "failed=%d\n",
+				   atomic_read(&scmd->host->host_active),
+				   scmd->host->host_busy,
+				   scmd->host->host_failed));
+}
+
+/**
  * scsi_eh_tur - Send TUR to device.
  * @scmd:	Scsi cmd to send TUR
  *
@@ -982,10 +1019,11 @@
 	int rtn;
 	Scsi_Cmnd *scmd;
 	Scsi_Device *sdev;
+	scsi_traverse_hndl_t strav_hndl;
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Trying BDR\n", __FUNCTION__));
 
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (scmd = sc_todo; scmd; scmd = scmd->bh_next)
 			if ((scmd->device == sdev) &&
 			    scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
@@ -1021,6 +1059,7 @@
 	unsigned long flags;
 	int rtn;
 	Scsi_Device *sdev;
+	scsi_traverse_hndl_t strav_hndl;
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Snd Bus RST\n",
 					  __FUNCTION__));
@@ -1039,11 +1078,11 @@
 		/*
 		 * Mark all affected devices to expect a unit attention.
 		 */
-		for (sdev = scmd->host->host_queue; sdev; sdev = sdev->next)
-			if (scmd->channel == sdev->channel) {
-				sdev->was_reset = 1;
-				sdev->expecting_cc_ua = 1;
-			}
+		scsi_for_each_host_chan_sdev(&strav_hndl, sdev,
+		     scmd->host->host_no, scmd->channel) {
+			sdev->was_reset = 1;
+			sdev->expecting_cc_ua = 1;
+		}
 	}
 	return rtn;
 }
@@ -1056,7 +1095,8 @@
 {
 	unsigned long flags;
 	int rtn;
-	 Scsi_Device *sdev;
+	Scsi_Device *sdev;
+	scsi_traverse_hndl_t strav_hndl;
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Snd Host RST\n",
 					  __FUNCTION__));
@@ -1075,11 +1115,11 @@
 		/*
 		 * Mark all affected devices to expect a unit attention.
 		 */
-		for (sdev = scmd->host->host_queue; sdev; sdev = sdev->next)
-			if (scmd->channel == sdev->channel) {
-				sdev->was_reset = 1;
-				sdev->expecting_cc_ua = 1;
-			}
+		scsi_for_each_host_chan_sdev(&strav_hndl, sdev,
+		     scmd->host->host_no, scmd->channel) {
+			sdev->was_reset = 1;
+			sdev->expecting_cc_ua = 1;
+		}
 	}
 	return rtn;
 }
@@ -1132,8 +1172,7 @@
 		 * we now know that we are able to perform a reset for the
 		 * channel that scmd points to.
 		 */
-		rtn = scsi_try_bus_reset(scmd);
-		if (rtn != SUCCESS)
+		rtn = scsi_try_bus_reset(scmd); if (rtn != SUCCESS)
 			rtn = scsi_try_host_reset(scmd);
 
 		if (rtn == SUCCESS) {
@@ -1168,14 +1207,11 @@
 		if (!scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
 			continue;
 
-		printk(KERN_INFO "%s: Device set offline - not"
-				"ready or command retry failed"
-				"after error recovery: host"
-				"%d channel %d id %d lun %d\n",
-				__FUNCTION__, shost->host_no,
-				scmd->device->channel,
-				scmd->device->id,
-				scmd->device->lun);
+		printk(KERN_INFO "%s: device at ", __FUNCTION__);
+		scsi_paths_printk(scmd->device,
+				  " ", "<%d, %d, %d, %d>");
+		printk(" set offline - not ready or command retry"
+		       " failed after bus and host reset\n");
 		scmd->device->online = FALSE;
 		scsi_eh_finish_cmd(scmd, shost);
 	}
@@ -1247,6 +1283,12 @@
 						  __FUNCTION__));
 		return SUCCESS;
 	}
+
+	rtn = scsi_path_decide_disposition(scmd);
+	if (rtn != UNKNOWN_ERROR) {
+		return(rtn);
+	}
+
 	/*
 	 * first check the host byte, to see if there is anything in there
 	 * that would indicate what we need to do.
@@ -1364,7 +1406,7 @@
 	case RESERVATION_CONFLICT:
 		printk("scsi%d (%d,%d,%d) : reservation conflict\n", 
 		       scmd->host->host_no, scmd->channel,
-		       scmd->device->id, scmd->device->lun);
+		       scmd->target, scmd->lun);
 		return SUCCESS; /* causes immediate i/o error */
 	default:
 		return FAILED;
@@ -1394,7 +1436,7 @@
 static void scsi_restart_operations(struct Scsi_Host *shost)
 {
 	Scsi_Device *sdev;
-	unsigned long flags;
+	scsi_traverse_hndl_t strav_hndl;
 
 	ASSERT_LOCK(shost->host_lock, 0);
 
@@ -1414,21 +1456,12 @@
 	 * now that error recovery is done, we will need to ensure that these
 	 * requests are started.
 	 */
-	spin_lock_irqsave(shost->host_lock, flags);
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		request_queue_t *q = &sdev->request_queue;
-
-		if ((shost->can_queue > 0 &&
-		     (shost->host_busy >= shost->can_queue))
-		    || (shost->host_blocked)
-		    || (shost->host_self_blocked)
-		    || (sdev->device_blocked)) {
-			break;
-		}
-
+		spin_lock_irq(q->queue_lock);
 		q->request_fn(q);
+		spin_unlock_irq(q->queue_lock);
 	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
 /**

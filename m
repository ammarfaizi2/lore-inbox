Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSJYWRg>; Fri, 25 Oct 2002 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJYWRg>; Fri, 25 Oct 2002 18:17:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:37540 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261657AbSJYWPl>; Fri, 25 Oct 2002 18:15:41 -0400
Date: Fri, 25 Oct 2002 15:21:49 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 1/6 2.5.44 scsi multi-path IO - mid layer changes
Message-ID: <20021025152149.A17527@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20021025152116.A17462@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021025152116.A17462@eng2.beaverton.ibm.com>; from patman on Fri, Oct 25, 2002 at 03:21:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI mid-layer multi-path IO changes

 Config.help  |   22 +++
 Config.in    |   11 +
 Makefile     |    2 
 hosts.c      |  107 ++++++++------
 hosts.h      |   35 +---
 scsi.c       |  421 +++++++++++++++++++++++++++++------------------------------
 scsi.h       |  152 +++++++++++++++++++--
 scsi_error.c |  361 +++++++++++++++-----------------------------------
 8 files changed, 570 insertions(+), 541 deletions(-)

diff -Nru a/drivers/scsi/Config.help b/drivers/scsi/Config.help
--- a/drivers/scsi/Config.help	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/Config.help	Fri Oct 25 11:26:47 2002
@@ -152,6 +152,28 @@
   REPORT LUNS scanning is done only for SCSI-3 devices. Most users can safely
   answer N here.
 
+CONFIG_SCSI_MULTI_PATH_IO
+  If your system contains SCSI host adapters connecting into a shared
+  transport, or you have storage devices that have multiple ports, and
+  you are using an adapter that properly supports multiple paths, and your
+  storage devices support unique id's (unique serial numbers) say Y
+  here to enable the multiple paths/ports to be merged into one mid layer
+  SCSI device.
+
+  If you are unsure if your system can properly support this
+  capability or that your devices have this capability say N.
+
+CONFIG_SCSI_PATH_POLICY_LPU 
+  When CONFIG_SCSI_MULTI_PATH_IO is selected this option sets the path
+  selection policy. 
+
+  The last path used policy only uses another path after a path failure.
+
+  The round robin policy round robins across all active paths.
+
+  The last path used policy is the safest path policy to select if you
+  cannot determine the best path policy for your storage device.
+
 CONFIG_SCSI_CONSTANTS
   The error messages regarding your SCSI hardware will be easier to
   understand if you say Y here; it will enlarge your kernel by about
diff -Nru a/drivers/scsi/Config.in b/drivers/scsi/Config.in
--- a/drivers/scsi/Config.in	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/Config.in	Fri Oct 25 11:26:47 2002
@@ -22,7 +22,16 @@
 
 bool '  Probe all LUNs on each SCSI device' CONFIG_SCSI_MULTI_LUN
 bool '  Build with SCSI REPORT LUNS support' CONFIG_SCSI_REPORT_LUNS
-  
+
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+	bool '  Enable Mid Layer Multi-Path IO support (EXPERIMENTAL)' CONFIG_SCSI_MULTI_PATH_IO
+	if [ "$CONFIG_SCSI_MULTI_PATH_IO" != "n" ] ; then
+	     choice ' Multipath Routing algorithim'			\
+		 "LastPathUsed		CONFIG_SCSI_PATH_POLICY_LPU	\
+		  RoundRobin		CONFIG_SCSI_PATH_POLICY_RR"	\
+		LastPathUsed
+	fi
+fi
 bool '  Verbose SCSI error reporting (kernel size +=12K)' CONFIG_SCSI_CONSTANTS
 bool '  SCSI logging facility' CONFIG_SCSI_LOGGING
 
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	Fri Oct 25 11:26:48 2002
+++ b/drivers/scsi/Makefile	Fri Oct 25 11:26:48 2002
@@ -123,7 +123,7 @@
 
 scsi_mod-objs	:= scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o \
 			scsi_proc.o scsi_error.o scsi_lib.o scsi_merge.o \
-			scsi_scan.o scsi_syms.o
+			scsi_scan.o scsi_syms.o scsi_paths.o
 			
 sd_mod-objs	:= sd.o
 sr_mod-objs	:= sr.o sr_ioctl.o sr_vendor.o
diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/hosts.c	Fri Oct 25 11:26:47 2002
@@ -117,6 +117,7 @@
 	Scsi_Device *sdev;
 	struct Scsi_Device_Template *sdev_tp;
 	Scsi_Cmnd *scmd;
+	struct scsi_traverse_hndl strav_hndl;
 
 	/*
 	 * Current policy is all shosts go away on unregister.
@@ -129,10 +130,10 @@
 	 * help prevent race conditions where other hosts/processors could
 	 * try and get in and queue a command.
 	 */
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) 
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no)
 		sdev->online = FALSE;
 
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		/*
 		 * Loop over all of the commands associated with the
 		 * device.  If any of them are busy, then set the state
@@ -147,8 +148,8 @@
 				       scmd->request->rq_status,
 				       scmd->target, scmd->pid,
 				       scmd->state, scmd->owner);
-				for (sdev = shost->host_queue; sdev;
-				     sdev = sdev->next) {
+				scsi_for_each_host_sdev(&strav_hndl, sdev,
+							shost->host_no) {
 					for (scmd = sdev->device_queue; scmd;
 					     scmd = scmd->next)
 						if (scmd->request->rq_status ==
@@ -174,7 +175,7 @@
 	 * Next we detach the high level drivers from the Scsi_Device
 	 * structures
 	 */
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (sdev_tp = scsi_devicelist; sdev_tp;
 		     sdev_tp = sdev_tp->next)
 			if (sdev_tp->detach)
@@ -196,16 +197,8 @@
 
 	/* Next we free up the Scsi_Cmnd structures for this host */
 
-	for (sdev = shost->host_queue; sdev;
-	     sdev = shost->host_queue) {
-		scsi_release_commandblocks(sdev);
-		blk_cleanup_queue(&sdev->request_queue);
-		/* Next free up the Scsi_Device structures for this host */
-		shost->host_queue = sdev->next;
-		if (sdev->inquiry)
-			kfree(sdev->inquiry);
-		kfree(sdev);
-	}
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no)
+		scsi_remove_scsi_device(sdev);
 
 	/* Remove the instance of the individual hosts */
 	pcount = scsi_hosts_registered;
@@ -473,6 +466,7 @@
 	struct Scsi_Device_Template *sdev_tp;
 	struct list_head *lh;
 	struct Scsi_Host *shost;
+	struct scsi_traverse_hndl strav_hndl;
 
 	INIT_LIST_HEAD(&shost_tp->shtp_list);
 
@@ -557,21 +551,27 @@
 		/*
 		 * Next we create the Scsi_Cmnd structures for this host 
 		 */
-		list_for_each(lh, &scsi_host_list) {
-			shost = list_entry(lh, struct Scsi_Host, sh_list);
-			for (sdev = shost->host_queue; sdev; sdev = sdev->next)
-				if (sdev->host->hostt == shost_tp) {
-					for (sdev_tp = scsi_devicelist;
-					     sdev_tp;
-					     sdev_tp = sdev_tp->next)
-						if (sdev_tp->attach)
-							(*sdev_tp->attach) (sdev);
-					if (sdev->attached) {
-						scsi_build_commandblocks(sdev);
-						if (sdev->current_queue_depth == 0)
-							goto out_of_space;
-					}
+		scsi_for_all_sdevs(&strav_hndl, sdev) {
+			shost = scsi_get_host(sdev);
+			/*
+			 * As long as we only support multiple paths that
+			 * all use the same adapter and driver, the attach
+			 * function will only be called once for each
+			 * Scsi_Device. Alternatively, set a flag if the
+			 * device has been attached (to upper levels), or
+			 * check current_queue_depth.
+			 */
+			if (shost && shost->hostt == shost_tp) {
+				for (sdev_tp = scsi_devicelist; sdev_tp;
+				     sdev_tp = sdev_tp->next)
+					if (sdev_tp->attach)
+						(*sdev_tp->attach) (sdev);
+				if (sdev->attached) {
+					scsi_build_commandblocks(sdev);
+					if (sdev->current_queue_depth == 0)
+						goto out_of_space;
 				}
+			}
 		}
 
 		/* This does any final handling that is required. */
@@ -743,29 +743,26 @@
 	}
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
 					  " thread\n"));
 	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
+	if (q->queue_lock != shost->host_lock)
+		spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
 void scsi_host_failed_inc_and_test(struct Scsi_Host *shost)
@@ -782,6 +779,30 @@
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
+
+#if defined(CONFIG_NUMA)
+/*
+ * scsihost_to_node: return the node id that *host is on. This only
+ * knows about pci devices.
+ */
+int scsihost_to_node(struct Scsi_Host *host)
+{
+        if (!host) {
+                printk(KERN_ERR "%s: host NULL\n", __FUNCTION__);
+                return 0;
+        }
+        if(host->pci_dev)
+		/*
+		 * What interface is available today?
+		 * return pcidev_to_node(host->pci_dev);
+                 * return BUS2QUAD(host->pci_dev->bus->number);
+		 */ 
+                return mp_bus_id_to_node[host->pci_dev->bus->number];
+
+        printk(KERN_INFO "%s: Unable to determine bus type\n", __FUNCTION__);
+        return 0;
+}
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/hosts.h	Fri Oct 25 11:26:47 2002
@@ -27,6 +27,7 @@
 #include <linux/config.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
+#include <linux/mm.h>
 
 /* It is senseless to set SG_ALL any higher than this - the performance
  *  does not get any better, and it wastes memory
@@ -373,7 +374,6 @@
      * struct private is a way of marking it in a sort of C++ type of way.
      */
     struct list_head      sh_list;
-    Scsi_Device           * host_queue;
     struct list_head	  all_scsi_hosts;
     struct list_head	  my_devices;
 
@@ -551,9 +551,6 @@
 {
 	shost->pci_dev = pdev;
 	shost->host_driverfs_dev.parent=&pdev->dev;
-
-	/* register parent with driverfs */
-	device_register(&shost->host_driverfs_dev);
 }
 
 
@@ -592,7 +589,14 @@
 };
 
 void  scsi_initialize_queue(Scsi_Device *, struct Scsi_Host *);
-
+#if defined(CONFIG_NUMA)
+int scsihost_to_node(struct Scsi_Host *host);
+#else
+static inline int scsihost_to_node(struct Scsi_Host *host) 
+{ 
+	return 0; 
+}
+#endif
 
 /*
  * Driver registration/unregistration.
@@ -640,27 +644,6 @@
 #define SD_EXTRA_DEVS CONFIG_SD_EXTRA_DEVS
 #define SR_EXTRA_DEVS CONFIG_SR_EXTRA_DEVS
 
-
-/**
- * scsi_find_device - find a device given the host
- * @shost:	SCSI host pointer
- * @channel:	SCSI channel (zero if only one channel)
- * @pun:	SCSI target number (physical unit number)
- * @lun:	SCSI Logical Unit Number
- **/
-static inline Scsi_Device *scsi_find_device(struct Scsi_Host *shost,
-                                            int channel, int pun, int lun) {
-        Scsi_Device *sdev;
-
-        for (sdev = shost->host_queue;
-            sdev != NULL;
-            sdev = sdev->next)
-                if (sdev->channel == channel && sdev->id == pun
-                   && sdev->lun ==lun)
-                        break;
-        return sdev;
-}
-    
 #endif
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/scsi.c	Fri Oct 25 11:26:47 2002
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
+	struct scsi_traverse_hndl strav_hndl;
   
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
+				scsi_for_each_sdev_lun(&strav_hndl, SDpnt,
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
@@ -551,6 +548,7 @@
 {
 	unsigned long flags;
         Scsi_Device * SDpnt;
+	struct Scsi_Host *shpnt;
 	int alloc_cmd = 0;
 
 	spin_lock_irqsave(&device_request_lock, flags);
@@ -601,19 +599,16 @@
 	 * device_request_lock since that's nice and quick, but allocation
 	 * can take more time so do it outside that scope instead.
 	 */
-	if(alloc_cmd) {
+	shpnt = scsi_get_host(SDpnt);
+	if(shpnt && alloc_cmd) {
 		Scsi_Cmnd *newSCpnt;
 
 		newSCpnt = kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC |
-				(SDpnt->host->unchecked_isa_dma ?
+				(shpnt->unchecked_isa_dma ?
 				 GFP_DMA : 0));
 		if(newSCpnt) {
 			memset(newSCpnt, 0, sizeof(Scsi_Cmnd));
-			newSCpnt->host = SDpnt->host;
 			newSCpnt->device = SDpnt;
-			newSCpnt->target = SDpnt->id;
-			newSCpnt->lun = SDpnt->lun;
-			newSCpnt->channel = SDpnt->channel;
 			newSCpnt->request = NULL;
 			newSCpnt->use_sg = 0;
 			newSCpnt->old_use_sg = 0;
@@ -687,8 +682,14 @@
 	 */
 	if (reason == SCSI_MLQUEUE_HOST_BUSY) {
 		host->host_blocked = host->max_host_blocked;
-	} else {
+		cmd->retries = 0;
+	} else if (reason == SCSI_MLQUEUE_DEVICE_BUSY) {
                 cmd->device->device_blocked = cmd->device->max_device_blocked;
+		cmd->retries = 0;
+	} else if (reason != SCSI_MLQUEUE_RETRY) {
+		printk("%s: unexpected value of reason %d\n", __FUNCTION__,
+		       reason);
+		return 0;
 	}
 
 	/*
@@ -702,16 +703,29 @@
 	 * Decrement the counters, since these commands are no longer
 	 * active on the host/device.
 	 */
-	spin_lock_irqsave(cmd->host->host_lock, flags);
-	cmd->host->host_busy--;
-	cmd->device->device_busy--;
-	spin_unlock_irqrestore(cmd->host->host_lock, flags);
+	spin_lock_irqsave(cmd->device->request_queue.queue_lock, flags);
+	cmd->device->device_busy--; /* XXX race */
+	scsi_host_busy_dec_and_test(cmd->host, cmd->device);
+	spin_unlock_irqrestore(cmd->device->request_queue.queue_lock, flags);
 
 	/*
 	 * Insert this command at the head of the queue for it's device.
 	 * It will go before all other commands that are already in the queue.
 	 */
-	scsi_insert_special_cmd(cmd, 1);
+	if (cmd->request->flags & REQ_SPECIAL) {
+		/*
+		 * Calling this for REQ_CMD requests is fatal.
+		 */
+		scsi_insert_special_cmd(cmd, 1);
+	} else {
+		/*
+		 * Clean up the IO, and requeue it without setting cmd to
+		 * REQ_SPECIAL.
+		 */
+		scsi_cleanup_io(cmd);
+		scsi_queue_next_request(&cmd->device->request_queue, cmd,
+					cmd->host);
+	}
 	return 0;
 }
 
@@ -746,8 +760,10 @@
 {
         request_queue_t *q;
         Scsi_Device * SDpnt;
+	struct Scsi_Host * SHpnt;
 
         SDpnt = SCpnt->device;
+	SHpnt = SCpnt->host;
 
         __scsi_release_command(SCpnt);
 
@@ -758,7 +774,7 @@
          * will go on.  
          */
         q = &SDpnt->request_queue;
-        scsi_queue_next_request(q, NULL);                
+        scsi_queue_next_request(q, NULL, SHpnt); 
 }
 
 /*
@@ -833,10 +849,12 @@
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
@@ -952,30 +970,17 @@
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
@@ -1343,6 +1348,15 @@
 
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
@@ -1431,6 +1445,7 @@
 	struct Scsi_Host *host;
 	Scsi_Device *device;
 	Scsi_Request * SRpnt;
+	unsigned long flags;
 
 	host = SCpnt->host;
 	device = SCpnt->device;
@@ -1444,7 +1459,11 @@
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
@@ -1463,7 +1482,7 @@
 		SCpnt->result |= (DRIVER_SENSE << 24);
 	}
 	SCSI_LOG_MLCOMPLETE(3, printk("Notifying upper driver of completion for device %d %x\n",
-				      SCpnt->device->id, SCpnt->result));
+				      SCpnt->target, SCpnt->result));
 
 	SCpnt->owner = SCSI_OWNER_HIGHLEVEL;
 	SCpnt->state = SCSI_STATE_FINISHED;
@@ -1533,30 +1552,34 @@
 void scsi_build_commandblocks(Scsi_Device * SDpnt)
 {
 	unsigned long flags;
+	struct Scsi_Host *host;
 	Scsi_Cmnd *SCpnt;
 
 	if (SDpnt->current_queue_depth != 0)
 		return;
 		
+	host = scsi_get_host(SDpnt);
+	/*
+	 * We are called during scan, and must always have at least one
+	 * path.
+	 */
+	BUG_ON(host == NULL);
+
 	SCpnt = (Scsi_Cmnd *) kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC |
-			(SDpnt->host->unchecked_isa_dma ? GFP_DMA : 0));
+			(host->unchecked_isa_dma ? GFP_DMA : 0));
 	if (NULL == SCpnt) {
 		/*
 		 * Since we don't currently have *any* command blocks on this
 		 * device, go ahead and try an atomic allocation...
 		 */
 		SCpnt = (Scsi_Cmnd *) kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC |
-			(SDpnt->host->unchecked_isa_dma ? GFP_DMA : 0));
+			(host->unchecked_isa_dma ? GFP_DMA : 0));
 		if (NULL == SCpnt)
 			return;	/* Oops, we aren't going anywhere for now */
 	}
 
 	memset(SCpnt, 0, sizeof(Scsi_Cmnd));
-	SCpnt->host = SDpnt->host;
 	SCpnt->device = SDpnt;
-	SCpnt->target = SDpnt->id;
-	SCpnt->lun = SDpnt->lun;
-	SCpnt->channel = SDpnt->channel;
 	SCpnt->request = NULL;
 	SCpnt->use_sg = 0;
 	SCpnt->old_use_sg = 0;
@@ -1649,10 +1672,10 @@
 			SDpnt->simple_tags = 1;
 			break;
 		default:
-			printk(KERN_WARNING "(scsi%d:%d:%d:%d) "
-				"scsi_adjust_queue_depth, bad queue type, "
-				"disabled\n", SDpnt->host->host_no,
-				SDpnt->channel, SDpnt->id, SDpnt->lun); 
+			printk(KERN_WARNING); 
+			scsi_paths_printk(SDpnt, NULL, "<%d, %d, %d, %d>");
+			printk("scsi_adjust_queue_depth, bad queue type, "
+				"disabled\n");
 		case 0:
 			SDpnt->ordered_tags = SDpnt->simple_tags = 0;
 			SDpnt->new_queue_depth = tags;
@@ -1669,46 +1692,37 @@
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int length)
 {
 	Scsi_Device *scd;
-	struct Scsi_Host *HBA_ptr;
+	struct scsi_traverse_hndl strav_hndl;
 	int size, len = 0;
 	off_t begin = 0;
 	off_t pos = 0;
+	int header_output = 0;
 
-	/*
-	 * First, see if there are any attached devices or not.
-	 */
-	for (HBA_ptr = scsi_host_get_next(NULL); HBA_ptr;
-	     HBA_ptr = scsi_host_get_next(HBA_ptr)) {
-		if (HBA_ptr->host_queue != NULL) {
-			break;
+	scsi_for_all_sdevs(&strav_hndl, scd) {
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
-	for (HBA_ptr = scsi_host_get_next(NULL); HBA_ptr;
-	     HBA_ptr = scsi_host_get_next(HBA_ptr)) {
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
@@ -1864,13 +1878,7 @@
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
@@ -1910,13 +1918,7 @@
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
@@ -1933,6 +1935,10 @@
 		}
 
 		if (scd->attached == 0) {
+			scsi_remove_path(scd, SCSI_FIND_ALL_HOST_NO,
+					 SCSI_FIND_ALL_CHANNEL,
+					 SCSI_FIND_ALL_ID,
+					 SCSI_FIND_ALL_LUN);
 			/*
 			 * Nobody is using this device any more.
 			 * Free all of the command structures.
@@ -1942,22 +1948,8 @@
 			if (HBA_ptr->hostt->slave_detach)
 				(*HBA_ptr->hostt->slave_detach) (scd);
 			devfs_unregister (scd->de);
-			scsi_release_commandblocks(scd);
-
 			/* Now we can remove the device structure */
-			if (scd->next != NULL)
-				scd->next->prev = scd->prev;
-
-			if (scd->prev != NULL)
-				scd->prev->next = scd->next;
-
-			if (HBA_ptr->host_queue == scd) {
-				HBA_ptr->host_queue = scd->next;
-			}
-			blk_cleanup_queue(&scd->request_queue);
-			if (scd->inquiry)
-				kfree(scd->inquiry);
-			kfree((char *) scd);
+			scsi_remove_scsi_device(scd);
 		} else {
 			goto out;
 		}
@@ -1977,8 +1969,8 @@
 int scsi_register_device(struct Scsi_Device_Template *tpnt)
 {
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *shpnt;
 	int out_of_space = 0;
+	struct scsi_traverse_hndl strav_hndl;
 
 #ifdef CONFIG_KMOD
 	if (scsi_host_get_next(NULL) == NULL)
@@ -1994,15 +1986,9 @@
 	/*
 	 * First scan the devices that we know about, and see if we notice them.
 	 */
-
-	for (shpnt = scsi_host_get_next(NULL); shpnt;
-	     shpnt = scsi_host_get_next(shpnt)) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (tpnt->detect)
-				SDpnt->attached += (*tpnt->detect) (SDpnt);
-		}
-	}
+	scsi_for_all_sdevs(&strav_hndl, SDpnt)
+		if (tpnt->detect)
+			SDpnt->attached += (*tpnt->detect) (SDpnt);
 
 	/*
 	 * If any of the devices would match this driver, then perform the
@@ -2015,22 +2001,24 @@
 	/*
 	 * Now actually connect the devices to the new driver.
 	 */
-	for (shpnt = scsi_host_get_next(NULL); shpnt;
-	     shpnt = scsi_host_get_next(shpnt)) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (tpnt->attach)
-				(*tpnt->attach) (SDpnt);
-			/*
-			 * If this driver attached to the device, and don't have any
-			 * command blocks for this device, allocate some.
-			 */
-			if (SDpnt->attached && SDpnt->current_queue_depth == 0) {
-				SDpnt->online = TRUE;
-				scsi_build_commandblocks(SDpnt);
-				if (SDpnt->current_queue_depth == 0)
-					out_of_space = 1;
-			}
+	scsi_for_all_sdevs(&strav_hndl, SDpnt) {
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
+		if (SDpnt->attached && SDpnt->current_queue_depth == 0) {
+			SDpnt->online = TRUE;
+			scsi_build_commandblocks(SDpnt);
+			if (SDpnt->current_queue_depth == 0)
+				out_of_space = 1;
 		}
 	}
 
@@ -2051,9 +2039,10 @@
 int scsi_unregister_device(struct Scsi_Device_Template *tpnt)
 {
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *shpnt;
 	struct Scsi_Device_Template *spnt;
 	struct Scsi_Device_Template *prev_spnt;
+	struct scsi_traverse_hndl strav_hndl;
+	struct Scsi_Host *shpnt;
 	
 	lock_kernel();
 	/*
@@ -2066,25 +2055,29 @@
 	 * Next, detach the devices from the driver.
 	 */
 
-	for (shpnt = scsi_host_get_next(NULL); shpnt;
-	     shpnt = scsi_host_get_next(shpnt)) {
-		for (SDpnt = shpnt->host_queue; SDpnt;
-		     SDpnt = SDpnt->next) {
-			if (tpnt->detach)
-				(*tpnt->detach) (SDpnt);
-			if (SDpnt->attached == 0) {
-				SDpnt->online = FALSE;
+	scsi_for_all_sdevs(&strav_hndl, SDpnt) {
+		if (tpnt->detach)
+			(*tpnt->detach) (SDpnt);
+		if (SDpnt->attached == 0) {
+			SDpnt->online = FALSE;
 
-				/*
-				 * Nobody is using this device any more.  Free all of the
-				 * command structures.
-				 */
-				if (shpnt->hostt->slave_detach)
-					(*shpnt->hostt->slave_detach) (SDpnt);
-				scsi_release_commandblocks(SDpnt);
-			}
+			/*
+			 * Nobody is using this device any more.  Free all of the
+			 * command structures.
+			 */
+			shpnt = scsi_get_host(SDpnt);
+			/*
+			 * XXX fix if no paths left, we still want one
+			 * detach call.  Maybe call slave_detach() when
+			 * the last path goes away, and slave_attach()
+			 * when the first path is added.
+			 */
+			if (shpnt && shpnt->hostt->slave_detach)
+				(*shpnt->hostt->slave_detach) (SDpnt);
+			scsi_release_commandblocks(SDpnt);
 		}
 	}
+
 	/*
 	 * Extract the template from the linked list.
 	 */
@@ -2137,6 +2130,8 @@
 	struct Scsi_Host *shpnt;
 	Scsi_Cmnd *SCpnt;
 	Scsi_Device *SDpnt;
+	struct scsi_traverse_hndl strav_hndl;
+
 	printk(KERN_INFO "Dump of scsi host parameters:\n");
 	i = 0;
 	for (shpnt = scsi_host_get_next(NULL); shpnt;
@@ -2151,39 +2146,36 @@
 
 	printk(KERN_INFO "\n\n");
 	printk(KERN_INFO "Dump of scsi command parameters:\n");
-	for (shpnt = scsi_host_get_next(NULL); shpnt;
-	     shpnt = scsi_host_get_next(shpnt)) {
-		printk(KERN_INFO "h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result\n");
-		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
-			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
-				/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
-				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4llu %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
-				       i++,
-
-				       SCpnt->host->host_no,
-				       SCpnt->channel,
-                                       SCpnt->target,
-                                       SCpnt->lun,
-
-                                       kdevname(SCpnt->request->rq_dev),
-                                       (unsigned long long)SCpnt->request->sector,
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
+	scsi_for_all_sdevs(&strav_hndl, SDpnt) {
+		for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
+			/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
+			printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4llu %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
+			       i++,
+
+			       SCpnt->host->host_no,
+			       SCpnt->channel,
+			       SCpnt->target,
+			       SCpnt->lun,
+
+			       kdevname(SCpnt->request->rq_dev),
+			       (unsigned long long)SCpnt->request->sector,
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
@@ -2326,6 +2318,7 @@
 		return -ENOMEM;
 	}
 	generic->write_proc = proc_scsi_gen_write;
+	scsi_paths_proc_init();
 #endif
 
         scsi_devfs_handle = devfs_mk_dir (NULL, "scsi", NULL);
@@ -2349,6 +2342,7 @@
 	scsi_host_hn_release();
 
 #ifdef CONFIG_PROC_FS
+	scsi_paths_proc_cleanup();
 	/* No, we're not here anymore. Don't show the /proc/scsi files. */
 	remove_proc_entry ("scsi/scsi", 0);
 	remove_proc_entry ("scsi", 0);
@@ -2399,19 +2393,25 @@
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
+	/*
+	 * add a path: host is SHpnt, channel 0, id is SHpnt->this_id, lun 0
+	 */
+	if (scsi_add_path(SDpnt, SHpnt, 0, SHpnt->this_id, 0)) {
+		scsi_remove_scsi_device(SDpnt);
+		return NULL;
+	}
 	SDpnt->new_queue_depth = 1;
         
 	scsi_build_commandblocks(SDpnt);
 	if(SDpnt->current_queue_depth == 0) {
-		kfree(SDpnt);
+		scsi_remove_scsi_device(SDpnt);
 		return NULL;
 	}
 
@@ -2441,21 +2441,14 @@
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
-        blk_cleanup_queue(&SDpnt->request_queue);
-
-        /*
-         * We only have a single SCpnt attached to this device.  Free
-         * it now.
-         */
-	scsi_release_commandblocks(SDpnt);
-	if (SDpnt->inquiry)
-		kfree(SDpnt->inquiry);
-        kfree(SDpnt);
+	scsi_remove_scsi_device(SDpnt);
 }
 
 /*
@@ -2493,14 +2486,20 @@
 	Scsi_Cmnd SC, *SCpnt = &SC;
         struct request req;
 	int rtn;
+	struct scsi_path_id scsi_path;
 
         SCpnt->request = &req;
 	memset(&SCpnt->eh_timeout, 0, sizeof(SCpnt->eh_timeout));
-	SCpnt->host                    	= dev->host;
+	scsi_get_path(dev, &scsi_path);
+	/*
+	 * XXX this is broken if we have multiple paths and we want to
+	 * reset the bus or the adapter on all paths to dev.
+	 */
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
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/scsi.h	Fri Oct 25 11:26:47 2002
@@ -133,12 +133,14 @@
 #define sense_error(sense)  ((sense) & 0xf)
 #define sense_valid(sense)  ((sense) & 0x80);
 
+#define	UNKNOWN_ERROR	0x0000
 #define NEEDS_RETRY     0x2001
 #define SUCCESS         0x2002
 #define FAILED          0x2003
 #define QUEUED          0x2004
 #define SOFT_ERROR      0x2005
 #define ADD_TO_MLQUEUE  0x2006
+#define REQUEUE  	0x2007
 
 /*
  * These are the values that scsi_cmd->state can take.
@@ -387,6 +389,13 @@
 #define SYNC_RESET      0x40
 
 /*
+ * Prefix values for the SCSI id's. These are stored in the first byte of the
+ * driverfs name field, see scsi_scan.c.
+ */
+#define SCSI_UID_SER_NUM 'S'
+#define SCSI_UID_UNKNOWN 'Z'
+
+/*
  * This is the crap from the old error handling code.  We have it in a special
  * place so that we can more easily delete it later on.
  */
@@ -398,6 +407,7 @@
 typedef struct scsi_device Scsi_Device;
 typedef struct scsi_cmnd Scsi_Cmnd;
 typedef struct scsi_request Scsi_Request;
+struct scsi_path_id;
 
 #define SCSI_CMND_MAGIC 0xE25C23A5
 #define SCSI_REQ_MAGIC  0x75F6D354
@@ -428,7 +438,7 @@
 			   void (*complete) (Scsi_Cmnd *));
 extern int scsi_delete_timer(Scsi_Cmnd * SCset);
 extern void scsi_error_handler(void *host);
-extern int scsi_decide_disposition(Scsi_Cmnd * SCpnt);
+extern int scsi_check_sense(Scsi_Cmnd * SCpnt);
 extern int scsi_block_when_processing_errors(Scsi_Device *);
 extern void scsi_sleep(int);
 
@@ -458,10 +468,12 @@
  */
 extern void scsi_initialize_merge_fn(Scsi_Device *SDpnt);
 extern int scsi_init_io(Scsi_Cmnd *SCpnt);
+extern void scsi_cleanup_io(Scsi_Cmnd *SCpnt);
 
 /*
  * Prototypes for functions in scsi_lib.c
  */
+struct Scsi_Host;
 extern int scsi_maybe_unblock_host(Scsi_Device * SDpnt);
 extern Scsi_Cmnd *scsi_end_request(Scsi_Cmnd * SCpnt, int uptodate,
 				   int sectors);
@@ -471,9 +483,12 @@
 extern int scsi_insert_special_cmd(Scsi_Cmnd * SCpnt, int);
 extern void scsi_io_completion(Scsi_Cmnd * SCpnt, int good_sectors,
 			       int block_sectors);
-extern void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt);
+extern void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt,
+				    struct Scsi_Host * SHpnt);
 extern void scsi_request_fn(request_queue_t * q);
 extern int scsi_starvation_completion(Scsi_Device * SDpnt);
+extern void scsi_add_scsi_device(Scsi_Device *SDpnt, struct Scsi_Host *SHpnt);
+extern void scsi_remove_scsi_device(Scsi_Device *SDpnt);
 
 /*
  * Prototypes for functions in scsi.c
@@ -486,7 +501,8 @@
 extern void scsi_done(Scsi_Cmnd * SCpnt);
 extern void scsi_finish_command(Scsi_Cmnd *);
 extern int scsi_retry_command(Scsi_Cmnd *);
-extern Scsi_Cmnd *scsi_allocate_device(Scsi_Device *, int, int);
+extern Scsi_Cmnd *scsi_allocate_device(Scsi_Device *, int, int,
+				       struct scsi_path_id *);
 extern void __scsi_release_command(Scsi_Cmnd *);
 extern void scsi_release_command(Scsi_Cmnd *);
 extern void scsi_do_cmd(Scsi_Cmnd *, const void *cmnd,
@@ -495,6 +511,9 @@
 			int timeout, int retries);
 extern int scsi_dev_init(void);
 
+extern int scsi_paths_proc_print_paths(Scsi_Device *SDpnt, char *buffer,
+				       char *format);
+
 /*
  * Newer request-based interfaces.
  */
@@ -539,6 +558,17 @@
 extern const char *scsi_extd_sense_format(unsigned char, unsigned char);
 
 /*
+ * The scsi_path_id struct contains the basic description of a path. IO to any
+ * logical unit (Scsi_Device) must use all four of these elements.
+ */
+struct scsi_path_id {
+	struct Scsi_Host *spi_shpnt;	/* Host adapter to use */
+	unsigned int spi_channel;	/* channel on the host */
+	unsigned int spi_id;		/* target id on the channel */
+	unsigned int spi_lun;		/* LUN on the target */
+};
+
+/*
  *  The scsi_device struct contains what we know about each given scsi
  *  device.
  *
@@ -555,13 +585,18 @@
 	/*
 	 * This information is private to the scsi mid-layer.
 	 */
-	struct scsi_device *next;	/* Used for linked list */
-	struct scsi_device *prev;	/* Used for linked list */
+	/*
+	 * Only the SCSI mid-layer routines should access sdev_next and 
+	 * sdev_prev. If you need to traverse through scsi_device's, use
+	 * one of the scsi traverse functions - adapter drivers probably want
+	 * to use scsi_for_each_host_sdev.
+	 */
+	struct scsi_device *sdev_next;	/* Used for linked list */
+	struct scsi_device *sdev_prev;	/* Used for linked list */
 	struct list_head    siblings;   /* list of all devices on this host */
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 	wait_queue_head_t   scpnt_wait;	/* Used to wait if
 					   device is busy */
-	struct Scsi_Host *host;
 	request_queue_t request_queue;
         atomic_t                device_active; /* commands checked out for device */
 	volatile unsigned short device_busy;	/* commands actually active on low-level */
@@ -569,11 +604,9 @@
 	struct list_head busy_cmnds;    /* list of Scsi_Cmnd structs in use */
 	Scsi_Cmnd *device_queue;	/* queue of SCSI Command structures */
         Scsi_Cmnd *current_cmnd;	/* currently active command */
+ 	void	*sdev_paths;
 	unsigned short current_queue_depth;/* How deep of a queue we have */
 	unsigned short new_queue_depth; /* How deep of a queue we want */
-
-	unsigned int id, lun, channel;
-
 	unsigned int manufacturer;	/* Manufacturer of device, for using 
 					 * vendor-specific cmd's */
 	unsigned sector_size;	/* size in bytes */
@@ -626,6 +659,7 @@
 	unsigned remap:1;	/* support remapping  */
 	unsigned starved:1;	/* unable to process commands because
 				   host busy */
+	unsigned scanning:1;	/* set while scanning */
 //	unsigned sync:1;	/* Sync transfer state, managed by host */
 //	unsigned wide:1;	/* WIDE transfer state, managed by host */
 
@@ -635,7 +669,6 @@
   	/* default value if the device doesn't override */
 	#define SCSI_DEFAULT_DEVICE_BLOCKED	3
 
-
 	// Flag to allow revalidate to succeed in sd_open
 	int allow_revalidate;
 	struct device sdev_driverfs_dev;
@@ -678,7 +711,6 @@
 						 * received on original command 
 						 * (auto-sense) */
 
-	struct Scsi_Host *sr_host;
 	Scsi_Device *sr_device;
 	Scsi_Cmnd *sr_command;
 	struct request *sr_request;	/* A copy of the command we are
@@ -753,6 +785,10 @@
 	struct scsi_cmnd *bh_next;	/* To enumerate the commands waiting 
 					   to be processed. */
 
+	/*
+	 * XXX a scsi_path_id should eventually replace the following,
+	 * including the *host.
+	 */
 	unsigned int target;
 	unsigned int lun;
 	unsigned int channel;
@@ -847,6 +883,7 @@
  */
 #define SCSI_MLQUEUE_HOST_BUSY   0x1055
 #define SCSI_MLQUEUE_DEVICE_BUSY 0x1056
+#define SCSI_MLQUEUE_RETRY       0x1057
 
 #define SCSI_SLEEP(QUEUE, CONDITION) {		    \
     if (CONDITION) {			            \
@@ -867,6 +904,72 @@
 	current->state = TASK_RUNNING;	\
     }; }
 
+struct scsi_traverse_hndl {
+	Scsi_Device *next_sdev;
+	struct Scsi_Host *cur_shost;
+};
+
+extern Scsi_Device *scsi_traverse_sdevs(struct scsi_traverse_hndl *handle,
+					uint host_no, uint channel, uint id,
+					uint lun);
+/*
+ * Values used for scsi_find_lun_start()
+ */
+#define SCSI_FIND_ALL_HOST_NO	0xffffffff
+#define SCSI_FIND_ALL_CHANNEL	0xffffffff
+#define SCSI_FIND_ALL_ID	0xffffffff
+#define SCSI_FIND_ALL_LUN	0xffffffff
+
+#define __INIT_TRAVERSE_HNDL(name) \
+	(name)->next_sdev = scsi_sdev_list
+
+#define SCSI_TRAVERSE_ALL_SDEVS(hndl) \
+	scsi_traverse_sdevs(hndl, SCSI_FIND_ALL_HOST_NO, \
+		SCSI_FIND_ALL_CHANNEL, SCSI_FIND_ALL_ID, \
+		SCSI_FIND_ALL_LUN)
+
+#define scsi_for_all_sdevs(hndl, sdev) \
+	for (__INIT_TRAVERSE_HNDL(hndl), sdev = SCSI_TRAVERSE_ALL_SDEVS(hndl); \
+	     sdev != NULL; sdev = SCSI_TRAVERSE_ALL_SDEVS(hndl))
+
+#define SCSI_TRAVERSE_HOST_SDEVS(hndl, host) \
+	scsi_traverse_sdevs(hndl, host, SCSI_FIND_ALL_CHANNEL, \
+			    SCSI_FIND_ALL_ID, SCSI_FIND_ALL_LUN)
+
+#define scsi_for_each_host_sdev(hndl, sdev, host) \
+	for (__INIT_TRAVERSE_HNDL(hndl), \
+	     sdev = SCSI_TRAVERSE_HOST_SDEVS(hndl, host); sdev != NULL; \
+	     sdev = SCSI_TRAVERSE_HOST_SDEVS(hndl, host))
+
+#define SCSI_TRAVERSE_HOST_CHAN_SDEVS(hndl, host, chan) \
+	scsi_traverse_sdevs(hndl, host, chan, SCSI_FIND_ALL_ID, \
+			    SCSI_FIND_ALL_LUN)
+
+#define scsi_for_each_host_chan_sdev(hndl, sdev, host, chan) \
+	for (__INIT_TRAVERSE_HNDL(hndl), \
+	     sdev = SCSI_TRAVERSE_HOST_CHAN_SDEVS(hndl, host, chan); \
+	     sdev != NULL; \
+	     sdev = SCSI_TRAVERSE_HOST_CHAN_SDEVS(hndl, host, chan))
+
+#define SCSI_TRAVERSE_SDEV_LUNS(hndl, host, chan, id) \
+	scsi_traverse_sdevs(hndl, host, chan, id, SCSI_FIND_ALL_LUN)
+
+#define scsi_for_each_sdev_lun(hndl, sdev, host, chan, id) \
+	for (__INIT_TRAVERSE_HNDL(hndl), \
+	     sdev = SCSI_TRAVERSE_SDEV_LUNS(hndl, host, chan, id); \
+	     sdev != NULL; \
+	     sdev = SCSI_TRAVERSE_SDEV_LUNS(hndl, host, chan, id))
+
+
+#define scsi_for_each_sdev(hndl, sdev, host, chan, id, lun) \
+	for (__INIT_TRAVERSE_HNDL(hndl), \
+	     sdev = scsi_traverse_sdevs(hndl, host, chan, id, lun); \
+	     sdev != NULL; \
+	     sdev = scsi_traverse_sdevs(hndl, host, chan, id, lun))
+
+#define scsi_locate_sdev(host, chan, id, lun) \
+	scsi_traverse_sdevs((struct scsi_traverse_hndl *) NULL, host, chan, \
+			    id, lun)
 /*
  * old style reset request from external source
  * (private to sg.c and scsi_error.c, supplied by scsi_obsolete.c)
@@ -960,6 +1063,33 @@
 
         return (Scsi_Cmnd *)req->special;
 }
+
+extern struct scsi_device *scsi_sdev_list;
+
+extern int scsi_paths_proc_init( void );
+extern void scsi_paths_proc_cleanup( void );
+extern struct Scsi_Host *scsi_get_host(Scsi_Device *SDpnt);
+extern int scsi_get_path(Scsi_Device *SDpnt, struct scsi_path_id *pathp);
+extern int scsi_get_best_path(Scsi_Device *SDpnt, struct scsi_path_id *pathp,
+			      struct request *);
+extern int scsi_decide_disposition(struct scsi_cmnd *);
+extern int scsi_add_path(Scsi_Device *SDpnt, struct Scsi_Host *shpnt,
+			 unsigned int channel, unsigned int dev,
+			 unsigned int lun);
+extern void  scsi_remove_path(Scsi_Device *SDpnt, unsigned int host_no,
+			      unsigned int channel, unsigned int dev,
+			      unsigned int lun);
+extern Scsi_Device *scsi_lookup_id(char *id, Scsi_Device *sdev);
+extern void scsi_replace_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+	unsigned int channel, unsigned int id, unsigned int lun);
+
+extern void scsi_paths_printk(Scsi_Device *SDpnt, char *prefix, char *format);
+
+#define scsi_path_set_scmnd_ids(scp, pathp) do {		 	\
+	scp->host = pathp->spi_shpnt;			\
+	scp->target = pathp->spi_id;			\
+	scp->lun = pathp->spi_lun; 				\
+	scp->channel = pathp->spi_channel; } while(0)
 
 #define scsi_eh_eflags_chk(scp, flags) (scp->eh_eflags & flags)
 
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Fri Oct 25 11:26:47 2002
+++ b/drivers/scsi/scsi_error.c	Fri Oct 25 11:26:47 2002
@@ -133,37 +133,6 @@
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
-				   " failed=%d\n",
-				   atomic_read(&scmd->host->host_active),
-				   scmd->host->host_busy,
-				   scmd->host->host_failed));
-}
-
-/**
  * scsi_block_when_processing_errors - Prevent cmds from being queued.
  * @sdev:	Device on which we are performing recovery.
  *
@@ -177,12 +146,15 @@
  **/
 int scsi_block_when_processing_errors(Scsi_Device *sdev)
 {
-
-	SCSI_SLEEP(&sdev->host->host_wait, sdev->host->in_recovery);
-
 	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: rtn: %d\n", __FUNCTION__,
 					  sdev->online));
-
+	/*
+	 * If a device is in_recovery, IO will be not be processed when
+	 * scsi_request_fn is called. We used to sleep here, doing so
+	 * raced with the setting of in_recovery, but prevented lots of IO
+	 * from queueing up after the open returns, but did not prevent IO
+	 * from queueing up for already open devices.
+	 */
 	return sdev->online;
 }
 
@@ -200,9 +172,9 @@
 	int cmd_failed = 0;
 	int cmd_timed_out = 0;
 	int devices_failed = 0;
+	struct scsi_traverse_hndl strav_hndl;
 
-
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (scmd = sc_list; scmd; scmd = scmd->bh_next) {
 			if (scmd->device == sdev) {
 				++total_failures;
@@ -215,12 +187,13 @@
 		}
 
 		if (cmd_timed_out || cmd_failed) {
-			SCSI_LOG_ERROR_RECOVERY(3,
-				printk("%s: %d:%d:%d:%d cmds failed: %d,"
-				       " timedout: %d\n",
-				       __FUNCTION__, shost->host_no,
-				       sdev->channel, sdev->id, sdev->lun,
-				       cmd_failed, cmd_timed_out));
+			SCSI_LOG_ERROR_RECOVERY(3, {
+				printk("scsi_eh: device at ");
+				scsi_paths_printk(sdev, " ",
+						  "<%d, %d, %d, %d>");
+				printk(" cmds failed: %d, timed out: %d\n",
+				       cmd_failed, cmd_timed_out); 
+			});
 			cmd_timed_out = 0;
 			cmd_failed = 0;
 			++devices_failed;
@@ -246,8 +219,10 @@
 	int found;
 	Scsi_Device *sdev;
 	Scsi_Cmnd *scmd;
+	struct scsi_traverse_hndl strav_hndl;
 
-	for (found = 0, sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	found = 0;
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (scmd = sdev->device_queue; scmd; scmd = scmd->next) {
 			if (scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR)) {
 				scmd->bh_next = *sc_list;
@@ -297,7 +272,7 @@
  * Return value:
  * 	SUCCESS or FAILED or NEEDS_RETRY
  **/
-static int scsi_check_sense(Scsi_Cmnd *scmd)
+int scsi_check_sense(Scsi_Cmnd *scmd)
 {
 	if (!SCSI_SENSE_VALID(scmd)) {
 		return FAILED;
@@ -823,6 +798,73 @@
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
+	 * scsi_decide_disposition.
+	 */
+	scmd->result = (scmd->result & 0xff00ffff) | (DID_TIME_OUT << 16) |
+		(DRIVER_TIMEOUT << 24);
+	if (scsi_decide_disposition(scmd) == REQUEUE) {
+#ifdef WILL_NOT_WORK
+		/*
+		 * XXX Ideally, abort the command, and then requeue it.
+		 * The current adapter abort command (eh_abort_handler) is
+		 * optional, and is allowed to block, so it will not work
+		 * here. Since we need to effectively reuse scmd, and we
+		 * can't tell if it is still used by the adapter, the only
+		 * solution for now is to allow the standard error handler
+		 * to kick in and retry the command - with the current
+		 * error handling code, this means the command will likely
+		 * not be retried or even failed for quite a bit of time,
+		 * maybe minutes.
+		 */
+		(void)scsi_try_to_abort_cmd(scmd);
+		SCSI_LOG_TIMEOUT(3, 
+			printk("Requeuing timed out IO host %d channel %d id % d lun %d; result 0x%x\n",
+			       scmd->host->host_no, scmd->channel,
+			       scmd->target, scmd->lun, scmd->result));
+		scsi_mlqueue_insert(scmd, SCSI_MLQUEUE_RETRY);
+		return;
+#endif
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
@@ -959,10 +1001,11 @@
 	int rtn;
 	Scsi_Cmnd *scmd;
 	Scsi_Device *sdev;
+	struct scsi_traverse_hndl strav_hndl;
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Trying BDR\n", __FUNCTION__));
 
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no) {
 		for (scmd = sc_todo; scmd; scmd = scmd->bh_next)
 			if ((scmd->device == sdev) &&
 			    scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
@@ -998,6 +1041,7 @@
 	unsigned long flags;
 	int rtn;
 	Scsi_Device *sdev;
+	struct scsi_traverse_hndl strav_hndl;
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Snd Bus RST\n",
 					  __FUNCTION__));
@@ -1016,11 +1060,11 @@
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
@@ -1033,7 +1077,8 @@
 {
 	unsigned long flags;
 	int rtn;
-	 Scsi_Device *sdev;
+	Scsi_Device *sdev;
+	struct scsi_traverse_hndl strav_hndl;
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Snd Host RST\n",
 					  __FUNCTION__));
@@ -1052,11 +1097,11 @@
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
@@ -1109,7 +1154,7 @@
 		 * we now know that we are able to perform a reset for the
 		 * channel that scmd points to.
 		 */
-		rtn = scsi_try_bus_reset(scmd);
+		rtn = scsi_try_bus_reset(scmd); 
 		if (rtn != SUCCESS)
 			rtn = scsi_try_host_reset(scmd);
 
@@ -1145,14 +1190,11 @@
 		if (!scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
 			continue;
 
-		printk(KERN_INFO "%s: Device offlined - not"
-				" ready or command retry failed"
-				" after error recovery: host"
-				" %d channel %d id %d lun %d\n",
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
@@ -1197,175 +1239,6 @@
 }
 
 /**
- * scsi_decide_disposition - Disposition a cmd on return from LLD.
- * @scmd:	SCSI cmd to examine.
- *
- * Notes:
- *    This is *only* called when we are examining the status after sending
- *    out the actual data command.  any commands that are queued for error
- *    recovery (i.e. test_unit_ready) do *not* come through here.
- *
- *    When this routine returns failed, it means the error handler thread
- *    is woken.  in cases where the error code indicates an error that
- *    doesn't require the error handler read (i.e. we don't need to
- *    abort/reset), then this function should return SUCCESS.
- **/
-int scsi_decide_disposition(Scsi_Cmnd *scmd)
-{
-	int rtn;
-
-	/*
-	 * if the device is offline, then we clearly just pass the result back
-	 * up to the top level.
-	 */
-	if (scmd->device->online == FALSE) {
-		SCSI_LOG_ERROR_RECOVERY(5, printk("%s: device offline - report"
-						  " as SUCCESS\n",
-						  __FUNCTION__));
-		return SUCCESS;
-	}
-	/*
-	 * first check the host byte, to see if there is anything in there
-	 * that would indicate what we need to do.
-	 */
-
-	switch (host_byte(scmd->result)) {
-	case DID_PASSTHROUGH:
-		/*
-		 * no matter what, pass this through to the upper layer.
-		 * nuke this special code so that it looks like we are saying
-		 * did_ok.
-		 */
-		scmd->result &= 0xff00ffff;
-		return SUCCESS;
-	case DID_OK:
-		/*
-		 * looks good.  drop through, and check the next byte.
-		 */
-		break;
-	case DID_NO_CONNECT:
-	case DID_BAD_TARGET:
-	case DID_ABORT:
-		/*
-		 * note - this means that we just report the status back
-		 * to the top level driver, not that we actually think
-		 * that it indicates SUCCESS.
-		 */
-		return SUCCESS;
-		/*
-		 * when the low level driver returns did_soft_error,
-		 * it is responsible for keeping an internal retry counter 
-		 * in order to avoid endless loops (db)
-		 *
-		 * actually this is a bug in this function here.  we should
-		 * be mindful of the maximum number of retries specified
-		 * and not get stuck in a loop.
-		 */
-	case DID_SOFT_ERROR:
-		goto maybe_retry;
-
-	case DID_ERROR:
-		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
-		    status_byte(scmd->result) == RESERVATION_CONFLICT)
-			/*
-			 * execute reservation conflict processing code
-			 * lower down
-			 */
-			break;
-		/* fallthrough */
-
-	case DID_BUS_BUSY:
-	case DID_PARITY:
-		goto maybe_retry;
-	case DID_TIME_OUT:
-		/*
-		 * when we scan the bus, we get timeout messages for
-		 * these commands if there is no device available.
-		 * other hosts report did_no_connect for the same thing.
-		 */
-		if ((scmd->cmnd[0] == TEST_UNIT_READY ||
-		     scmd->cmnd[0] == INQUIRY)) {
-			return SUCCESS;
-		} else {
-			return FAILED;
-		}
-	case DID_RESET:
-		/*
-		 * in the normal case where we haven't initiated a reset,
-		 * this is a failure.
-		 */
-		if (scmd->flags & IS_RESETTING) {
-			scmd->flags &= ~IS_RESETTING;
-			goto maybe_retry;
-		}
-		return SUCCESS;
-	default:
-		return FAILED;
-	}
-
-	/*
-	 * next, check the message byte.
-	 */
-	if (msg_byte(scmd->result) != COMMAND_COMPLETE) {
-		return FAILED;
-	}
-	/*
-	 * now, check the status byte to see if this indicates anything special.
-	 */
-	switch (status_byte(scmd->result)) {
-	case QUEUE_FULL:
-		/*
-		 * the case of trying to send too many commands to a
-		 * tagged queueing device.
-		 */
-	case BUSY:
-		/*
-		 * device can't talk to us at the moment.  Should only
-		 * occur (SAM-3) when the task queue is empty, so will cause
-		 * the empty queue handling to trigger a stall in the
-		 * device.
-		 */
-		return ADD_TO_MLQUEUE;
-	case GOOD:
-	case COMMAND_TERMINATED:
-		return SUCCESS;
-	case CHECK_CONDITION:
-		rtn = scsi_check_sense(scmd);
-		if (rtn == NEEDS_RETRY) {
-			goto maybe_retry;
-		}
-		return rtn;
-	case CONDITION_GOOD:
-	case INTERMEDIATE_GOOD:
-	case INTERMEDIATE_C_GOOD:
-		/*
-		 * who knows?  FIXME(eric)
-		 */
-		return SUCCESS;
-
-	case RESERVATION_CONFLICT:
-		printk("scsi%d (%d,%d,%d) : reservation conflict\n",
-		       scmd->host->host_no, scmd->channel,
-		       scmd->device->id, scmd->device->lun);
-		return SUCCESS; /* causes immediate i/o error */
-	default:
-		return FAILED;
-	}
-	return FAILED;
-
-      maybe_retry:
-
-	if ((++scmd->retries) < scmd->allowed) {
-		return NEEDS_RETRY;
-	} else {
-		/*
-		 * no more retries - report this one back to upper level.
-		 */
-		return SUCCESS;
-	}
-}
-
-/**
  * scsi_eh_lock_done - done function for eh door lock request
  * @scmd:	SCSI command block for the door lock request
  *
@@ -1445,7 +1318,7 @@
 static void scsi_restart_operations(struct Scsi_Host *shost)
 {
 	Scsi_Device *sdev;
-	unsigned long flags;
+	struct scsi_traverse_hndl strav_hndl;
 
 	ASSERT_LOCK(shost->host_lock, 0);
 
@@ -1454,7 +1327,7 @@
 	 * onto the head of the SCSI request queue for the device.  There
 	 * is no point trying to lock the door of an off-line device.
 	 */
-	for (sdev = shost->host_queue; sdev; sdev = sdev->next)
+	scsi_for_each_host_sdev(&strav_hndl, sdev, shost->host_no)
 		if (sdev->online && sdev->locked)
 			scsi_eh_lock_door(sdev);
 
@@ -1474,20 +1347,12 @@
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
-		    || (shost->host_self_blocked)) {
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

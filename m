Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTLOVjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTLOVjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:39:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:21434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264095AbTLOVjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:39:33 -0500
Date: Mon, 15 Dec 2003 13:40:53 -0800
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, piggin@cyberone.com.au
Subject: [PATCH] 2.6.0-test11 DAC960 request queue per disk
Message-ID: <20031215214053.GA3308@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch that changes the DAC960 driver from having one request
queue for ALL disks on the controller, to having a request queue for
each logical disk.  This turns out to make little difference for deadline
scheduler, nor for AS scheduler under light IO load.  But under AS
scheduler with heavy IO, it makes about a 40% difference on dbt2
workload.  Here are the measured numbers:

The 2.6.0-test11-D kernel version includes this mutli-queue patch to the
DAC960 driver.

For non-cached dbt2 workload  (heavy IO load)

Scheduler	kernel/driver	NOTPM(bigger is better)
AS		2.6.0-test11-D  1598
AS		2.6.0-test11     973
deadline	2.6.0-test11    1640
deadline	2.6.0-test11-D  1645

For cached dbt2 workload (lighter IO load)

AS		2.6.0-test11-D  4993
AS		2.6.-test6-mm4  4976, 4890, 4972
deadline	2.6.0-test11-D  4998

Can this be included in 2.6.0?  I know it's not a "critical patch"
in the sense that something won't work without it.  On the other hand,
the change is isolated to a driver.


diff -ur linux-2.6.0-test11_original/drivers/block/DAC960.c linux-2.6.0-test11_DAC/drivers/block/DAC960.c
--- linux-2.6.0-test11_original/drivers/block/DAC960.c	2003-12-15 10:37:55.000000000 -0800
+++ linux-2.6.0-test11_DAC/drivers/block/DAC960.c	2003-12-15 10:38:13.000000000 -0800
@@ -2474,7 +2474,6 @@
 static boolean DAC960_RegisterBlockDevice(DAC960_Controller_T *Controller)
 {
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
-  struct request_queue *RequestQueue;
   int n;
 
   /*
@@ -2483,26 +2482,22 @@
   if (register_blkdev(MajorNumber, "dac960") < 0)
       return false;
 
-  /*
-    Initialize the I/O Request Queue.
-  */
-  RequestQueue = blk_init_queue(DAC960_RequestFunction,&Controller->queue_lock);
-  if (!RequestQueue) {
-      unregister_blkdev(MajorNumber, "dac960");
-      return false;
-  }
-  Controller->RequestQueue = RequestQueue;
-  blk_queue_bounce_limit(RequestQueue, Controller->BounceBufferLimit);
-  RequestQueue->queuedata = Controller;
-  blk_queue_max_hw_segments(RequestQueue,
-			    Controller->DriverScatterGatherLimit);
-  blk_queue_max_phys_segments(RequestQueue,
-		 	    Controller->DriverScatterGatherLimit);
-  blk_queue_max_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
-
   for (n = 0; n < DAC960_MaxLogicalDrives; n++) {
 	struct gendisk *disk = Controller->disks[n];
+  	struct request_queue *RequestQueue;
 
+	/* for now, let all request queues share controller's lock */
+  	RequestQueue = blk_init_queue(DAC960_RequestFunction,&Controller->queue_lock);
+  	if (!RequestQueue) {
+		printk("DAC960: failure to allocate request queue\n");
+		continue;
+  	}
+  	Controller->RequestQueue[n] = RequestQueue;
+  	blk_queue_bounce_limit(RequestQueue, Controller->BounceBufferLimit);
+  	RequestQueue->queuedata = Controller;
+  	blk_queue_max_hw_segments(RequestQueue, Controller->DriverScatterGatherLimit);
+	blk_queue_max_phys_segments(RequestQueue, Controller->DriverScatterGatherLimit);
+	blk_queue_max_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
 	disk->queue = RequestQueue;
 	sprintf(disk->disk_name, "rd/c%dd%d", Controller->ControllerNumber, n);
 	sprintf(disk->devfs_name, "rd/host%d/target%d", Controller->ControllerNumber, n);
@@ -2527,17 +2522,17 @@
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
   int disk;
 
-  for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++)
-	  del_gendisk(Controller->disks[disk]);
+  /* does order matter when deleting gendisk and cleanup in request queue? */
+  for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++) {
+	del_gendisk(Controller->disks[disk]);
+	blk_cleanup_queue(Controller->RequestQueue[disk]);
+	Controller->RequestQueue[disk] = NULL;
+  }
 
   /*
     Unregister the Block Device Major Number for this DAC960 Controller.
   */
   unregister_blkdev(MajorNumber, "dac960");
-  /*
-    Remove the I/O Request Queue.
-  */
-  blk_cleanup_queue(Controller->RequestQueue);
 }
 
 /*
@@ -3253,58 +3248,83 @@
 }
 
 
+static int DAC960_process_queue(DAC960_Controller_T *Controller, struct request_queue *req_q)
+{
+	struct request *Request;
+	DAC960_Command_T *Command;
+
+   while(1) {
+	Request = elv_next_request(req_q);
+	if (!Request)
+		return 1;
+
+	Command = DAC960_AllocateCommand(Controller);
+	if (Command == NULL)
+		return 0;
+
+	if (rq_data_dir(Request) == READ) {
+		Command->DmaDirection = PCI_DMA_FROMDEVICE;
+		Command->CommandType = DAC960_ReadCommand;
+	} else {
+		Command->DmaDirection = PCI_DMA_TODEVICE;
+		Command->CommandType = DAC960_WriteCommand;
+	}
+	Command->Completion = Request->waiting;
+	Command->LogicalDriveNumber = (long)Request->rq_disk->private_data;
+	Command->BlockNumber = Request->sector;
+	Command->BlockCount = Request->nr_sectors;
+	Command->Request = Request;
+	blkdev_dequeue_request(Request);
+	Command->SegmentCount = blk_rq_map_sg(req_q,
+		  Command->Request, Command->cmd_sglist);
+	/* pci_map_sg MAY change the value of SegCount */
+	Command->SegmentCount = pci_map_sg(Controller->PCIDevice, Command->cmd_sglist,
+		 Command->SegmentCount, Command->DmaDirection);
+
+	DAC960_QueueReadWriteCommand(Command);
+  }
+}
+
 /*
   DAC960_ProcessRequest attempts to remove one I/O Request from Controller's
   I/O Request Queue and queues it to the Controller.  WaitForCommand is true if
   this function should wait for a Command to become available if necessary.
   This function returns true if an I/O Request was queued and false otherwise.
 */
-
-static boolean DAC960_ProcessRequest(DAC960_Controller_T *Controller,
-				     boolean WaitForCommand)
+static void DAC960_ProcessRequest(DAC960_Controller_T *controller)
 {
-  struct request_queue *RequestQueue = Controller->RequestQueue;
-  struct request *Request;
-  DAC960_Command_T *Command;
+	int i;
 
-  if (!Controller->ControllerInitialized)
-     return false;
+	if (!controller->ControllerInitialized)
+		return;
 
-  while (true) {
-      Request = elv_next_request(RequestQueue);
-      if (!Request)
-	      return false;
+	/* Do this better later! */
+	for (i = controller->req_q_index; i < DAC960_MaxLogicalDrives; i++) {
+		struct request_queue *req_q = controller->RequestQueue[i];
 
-      Command = DAC960_AllocateCommand(Controller);
-      if (Command != NULL)
-          break;
+		if (req_q == NULL)
+			continue;
 
-      if (!WaitForCommand)
-          return false;
+		if (!DAC960_process_queue(controller, req_q)) {
+			controller->req_q_index = i;
+			return;
+		}
+	}
 
-      DAC960_WaitForCommand(Controller);
-  }
-  if (rq_data_dir(Request) == READ) {
-    Command->DmaDirection = PCI_DMA_FROMDEVICE;
-    Command->CommandType = DAC960_ReadCommand;
-  } else {
-    Command->DmaDirection = PCI_DMA_TODEVICE;
-    Command->CommandType = DAC960_WriteCommand;
-  }
-  Command->Completion = Request->waiting;
-  Command->LogicalDriveNumber = (long)Request->rq_disk->private_data;
-  Command->BlockNumber = Request->sector;
-  Command->BlockCount = Request->nr_sectors;
-  Command->Request = Request;
-  blkdev_dequeue_request(Request);
-  Command->SegmentCount = blk_rq_map_sg(Controller->RequestQueue,
-		  Command->Request, Command->cmd_sglist);
-  /* pci_map_sg MAY change the value of SegCount */
-  Command->SegmentCount = pci_map_sg(Controller->PCIDevice, Command->cmd_sglist,
-		 Command->SegmentCount, Command->DmaDirection);
+	if (controller->req_q_index == 0)
+		return;
 
-  DAC960_QueueReadWriteCommand(Command);
-  return true;
+	for (i = 0; i < controller->req_q_index; i++) {
+		struct request_queue *req_q = controller->RequestQueue[i];
+
+		if (req_q == NULL)
+			continue;
+
+		if (!DAC960_process_queue(controller, req_q)) {
+			controller->req_q_index = i;
+			return;
+		}
+	}
 }
 
 
@@ -3321,6 +3341,7 @@
 {
   DAC960_Controller_T *Controller = Command->Controller;
   struct request *Request = Command->Request;
+  struct request_queue *req_q = Controller->RequestQueue[Command->LogicalDriveNumber];
 
   if (Command->DmaDirection == PCI_DMA_FROMDEVICE)
     Command->CommandType = DAC960_ReadRetryCommand;
@@ -3333,11 +3354,9 @@
    * code should almost never be called, just go with a
    * simple coding.
    */
-  (void)blk_rq_map_sg(Controller->RequestQueue, Command->Request,
-                                        Command->cmd_sglist);
+  (void)blk_rq_map_sg(req_q, Command->Request, Command->cmd_sglist);
 
-  (void)pci_map_sg(Controller->PCIDevice, Command->cmd_sglist, 1,
-		                        Command->DmaDirection);
+  (void)pci_map_sg(Controller->PCIDevice, Command->cmd_sglist, 1, Command->DmaDirection);
   /*
    * Resubmitting the request sector at a time is really tedious.
    * But, this should almost never happen.  So, we're willing to pay
@@ -3357,9 +3376,7 @@
 
 static void DAC960_RequestFunction(struct request_queue *RequestQueue)
 {
-	int i = 0;
-	while (DAC960_ProcessRequest(RequestQueue->queuedata, (i++ == 0)))
-		;
+	DAC960_ProcessRequest(RequestQueue->queuedata);
 }
 
 /*
@@ -5205,8 +5222,7 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false))
-	  ;
+  DAC960_ProcessRequest(Controller);
   spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
@@ -5249,8 +5265,7 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false))
-	  ;
+  DAC960_ProcessRequest(Controller);
   spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
@@ -5289,8 +5304,7 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false))
-	  ;
+  DAC960_ProcessRequest(Controller);
   spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
@@ -5329,8 +5343,7 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false))
-	  ;
+  DAC960_ProcessRequest(Controller);
   spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
@@ -5365,8 +5378,7 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false))
-	  ;
+  DAC960_ProcessRequest(Controller);
   spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
@@ -5440,8 +5452,7 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false))
-	  ;
+  DAC960_ProcessRequest(Controller);
   spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
diff -ur linux-2.6.0-test11_original/drivers/block/DAC960.h linux-2.6.0-test11_DAC/drivers/block/DAC960.h
--- linux-2.6.0-test11_original/drivers/block/DAC960.h	2003-12-15 10:37:55.000000000 -0800
+++ linux-2.6.0-test11_DAC/drivers/block/DAC960.h	2003-12-15 10:38:13.000000000 -0800
@@ -2333,7 +2333,8 @@
   DAC960_Command_T *FreeCommands;
   unsigned char *CombinedStatusBuffer;
   unsigned char *CurrentStatusBuffer;
-  struct request_queue *RequestQueue;
+  struct request_queue *RequestQueue[DAC960_MaxLogicalDrives];
+  int req_q_index;
   spinlock_t queue_lock;
   wait_queue_head_t CommandWaitQueue;
   wait_queue_head_t HealthStatusWaitQueue;

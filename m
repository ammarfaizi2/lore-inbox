Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267842AbTAMR1o>; Mon, 13 Jan 2003 12:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbTAMR1o>; Mon, 13 Jan 2003 12:27:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267842AbTAMR1h>;
	Mon, 13 Jan 2003 12:27:37 -0500
Date: Mon, 13 Jan 2003 09:36:14 -0800
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] linux2.5.56 patch to DAC960 driver for error retry
Message-ID: <20030113093614.A18488@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch implements retry on media errors for the DAC960
driver.  On such media errors, the DAC960 apparently doesn't report
how much of the transfer may have been successful before the error
was encountered.

This type of error should be rare on healthy hardware, especially if
the disks are stripped or mirrored.  But, when large transfers are
submitted to the controller, it's especially bad to have to fail the
entire transfer because one disk sector may have been bad.

---------------------------------------------------------------------------

diff -ur linux-2.5.56_original/drivers/block/DAC960.c linux-2.5.56_DAC/drivers/block/DAC960.c
--- linux-2.5.56_original/drivers/block/DAC960.c	Mon Jan 13 09:29:04 2003
+++ linux-2.5.56_DAC/drivers/block/DAC960.c	Mon Jan 13 09:30:06 2003
@@ -267,10 +267,12 @@
 	  }
         }
      if (Controller->FirmwareType == DAC960_V1_Controller) {
+        Command->cmd_sglist = Command->V1.ScatterList;
 	Command->V1.ScatterGatherList =
 		(DAC960_V1_ScatterGatherSegment_T *)ScatterGatherCPU;
 	Command->V1.ScatterGatherListDMA = ScatterGatherDMA;
       } else {
+        Command->cmd_sglist = Command->V2.ScatterList;
 	Command->V2.ScatterGatherList =
 		(DAC960_V2_ScatterGatherSegment_T *)ScatterGatherCPU;
 	Command->V2.ScatterGatherListDMA = ScatterGatherDMA;
@@ -3046,25 +3048,12 @@
   DAC960_V1_ScatterGatherSegment_T *ScatterGatherList =
 					Command->V1.ScatterGatherList;
   struct scatterlist *ScatterList = Command->V1.ScatterList;
-  int DmaDirection, SegCount;
 
   DAC960_V1_ClearCommand(Command);
 
-  if (Command->CommandType == DAC960_ReadCommand)
-        DmaDirection = PCI_DMA_FROMDEVICE;
-  else
-        DmaDirection = PCI_DMA_TODEVICE;
-
-  SegCount = blk_rq_map_sg(&Controller->RequestQueue, Command->Request,
-								ScatterList);
-  /* pci_map_sg MAY change the value of SegCount */
-  SegCount = pci_map_sg(Command->PciDevice, ScatterList, SegCount,
-								DmaDirection);
-  Command->SegmentCount = SegCount;
-
-  if (SegCount == 1)
+  if (Command->SegmentCount == 1)
     {
-      if (Command->CommandType == DAC960_ReadCommand)
+      if (Command->DmaDirection == PCI_DMA_FROMDEVICE)
 	CommandMailbox->Type5.CommandOpcode = DAC960_V1_Read;
       else 
         CommandMailbox->Type5.CommandOpcode = DAC960_V1_Write;
@@ -3079,7 +3068,7 @@
     {
       int i;
 
-      if (Command->CommandType == DAC960_ReadCommand)
+      if (Command->DmaDirection == PCI_DMA_FROMDEVICE)
 	CommandMailbox->Type5.CommandOpcode = DAC960_V1_ReadWithScatterGather;
       else
 	CommandMailbox->Type5.CommandOpcode = DAC960_V1_WriteWithScatterGather;
@@ -3089,9 +3078,9 @@
       CommandMailbox->Type5.LogicalBlockAddress = Command->BlockNumber;
       CommandMailbox->Type5.BusAddress = Command->V1.ScatterGatherListDMA;
 
-      CommandMailbox->Type5.ScatterGatherCount = SegCount;
+      CommandMailbox->Type5.ScatterGatherCount = Command->SegmentCount;
 
-      for (i = 0; i < SegCount; i++, ScatterList++, ScatterGatherList++) {
+      for (i = 0; i < Command->SegmentCount; i++, ScatterList++, ScatterGatherList++) {
 		ScatterGatherList->SegmentDataPointer =
 			(DAC960_BusAddress32_T)sg_dma_address(ScatterList);
 		ScatterGatherList->SegmentByteCount =
@@ -3112,25 +3101,12 @@
   DAC960_Controller_T *Controller = Command->Controller;
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   struct scatterlist *ScatterList = Command->V2.ScatterList;
-  int DmaDirection, SegCount;
 
   DAC960_V2_ClearCommand(Command);
 
-  if (Command->CommandType == DAC960_ReadCommand)
-        DmaDirection = PCI_DMA_FROMDEVICE;
-  else
-        DmaDirection = PCI_DMA_TODEVICE;
-
-  SegCount = blk_rq_map_sg(&Controller->RequestQueue, Command->Request,
-								ScatterList);
-  /* pci_map_sg MAY change the value of SegCount */
-  SegCount = pci_map_sg(Command->PciDevice, ScatterList, SegCount,
-								DmaDirection);
-  Command->SegmentCount = SegCount;
-
   CommandMailbox->SCSI_10.CommandOpcode = DAC960_V2_SCSI_10;
   CommandMailbox->SCSI_10.CommandControlBits.DataTransferControllerToHost =
-    (Command->CommandType == DAC960_ReadCommand);
+    (Command->DmaDirection == PCI_DMA_FROMDEVICE);
   CommandMailbox->SCSI_10.DataTransferSize =
     Command->BlockCount << DAC960_BlockSizeBits;
   CommandMailbox->SCSI_10.RequestSenseBusAddress = Command->V2.RequestSenseDMA;
@@ -3139,7 +3115,7 @@
   CommandMailbox->SCSI_10.RequestSenseSize = sizeof(DAC960_SCSI_RequestSense_T);
   CommandMailbox->SCSI_10.CDBLength = 10;
   CommandMailbox->SCSI_10.SCSI_CDB[0] =
-    (Command->CommandType == DAC960_ReadCommand ? 0x28 : 0x2A);
+    (Command->DmaDirection == PCI_DMA_FROMDEVICE ? 0x28 : 0x2A);
   CommandMailbox->SCSI_10.SCSI_CDB[2] = Command->BlockNumber >> 24;
   CommandMailbox->SCSI_10.SCSI_CDB[3] = Command->BlockNumber >> 16;
   CommandMailbox->SCSI_10.SCSI_CDB[4] = Command->BlockNumber >> 8;
@@ -3147,7 +3123,7 @@
   CommandMailbox->SCSI_10.SCSI_CDB[7] = Command->BlockCount >> 8;
   CommandMailbox->SCSI_10.SCSI_CDB[8] = Command->BlockCount;
 
-  if (SegCount == 1)
+  if (Command->SegmentCount == 1)
     {
       CommandMailbox->SCSI_10.DataTransferMemoryAddress
 			     .ScatterGatherSegments[0]
@@ -3163,13 +3139,13 @@
       DAC960_V2_ScatterGatherSegment_T *ScatterGatherList;
       int i;
 
-      if (SegCount > 2)
+      if (Command->SegmentCount > 2)
 	{
           ScatterGatherList = Command->V2.ScatterGatherList;
 	  CommandMailbox->SCSI_10.CommandControlBits
 			 .AdditionalScatterGatherListMemory = true;
 	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
-		.ExtendedScatterGather.ScatterGatherList0Length = SegCount;
+		.ExtendedScatterGather.ScatterGatherList0Length = Command->SegmentCount;
 	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
 			 .ExtendedScatterGather.ScatterGatherList0Address =
 	    Command->V2.ScatterGatherListDMA;
@@ -3178,7 +3154,7 @@
 	ScatterGatherList = CommandMailbox->SCSI_10.DataTransferMemoryAddress
 				 .ScatterGatherSegments;
 
-      for (i = 0; i < SegCount; i++, ScatterList++, ScatterGatherList++) {
+      for (i = 0; i < Command->SegmentCount; i++, ScatterList++, ScatterGatherList++) {
 		ScatterGatherList->SegmentDataPointer =
 			(DAC960_BusAddress64_T)sg_dma_address(ScatterList);
 		ScatterGatherList->SegmentByteCount =
@@ -3220,22 +3196,67 @@
 
       DAC960_WaitForCommand(Controller);
   }
-  if (rq_data_dir(Request) == READ)
+  if (rq_data_dir(Request) == READ) {
+    Command->DmaDirection = PCI_DMA_FROMDEVICE;
     Command->CommandType = DAC960_ReadCommand;
-  else
+  } else {
+    Command->DmaDirection = PCI_DMA_TODEVICE;
     Command->CommandType = DAC960_WriteCommand;
+  }
   Command->Completion = Request->waiting;
   Command->LogicalDriveNumber = (int)Request->rq_disk->private_data;
   Command->BlockNumber = Request->sector;
   Command->BlockCount = Request->nr_sectors;
   Command->Request = Request;
   blkdev_dequeue_request(Request);
+  Command->SegmentCount = blk_rq_map_sg(&Controller->RequestQueue,
+		  Command->Request, Command->cmd_sglist);
+  /* pci_map_sg MAY change the value of SegCount */
+  Command->SegmentCount = pci_map_sg(Command->PciDevice, Command->cmd_sglist,
+		 Command->SegmentCount, Command->DmaDirection);
+
   DAC960_QueueReadWriteCommand(Command);
   return true;
 }
 
 
 /*
+  DAC960_queue_partial_rw extracts one bio from the request already
+  associated with argument command, and construct a new command block to retry I/O
+  only on that bio.  Queue that command to the controller.
+
+  This function re-uses a previously-allocated Command,
+  	there is no failure mode from trying to allocate a command.
+*/
+
+static void DAC960_queue_partial_rw(DAC960_Command_T *Command)
+{
+  DAC960_Controller_T *Controller = Command->Controller;
+  IO_Request_T *Request = Command->Request;
+
+  if (Command->DmaDirection == PCI_DMA_FROMDEVICE)
+    Command->CommandType = DAC960_ReadRetryCommand;
+  else
+    Command->CommandType = DAC960_WriteRetryCommand;
+
+  (void)blk_rq_map_sg(&Controller->RequestQueue, Command->Request,
+                                        Command->cmd_sglist);
+
+  /*
+   * This relies on a single bio always being
+   * one dma segment.
+   */
+  (void)pci_map_sg(Command->PciDevice, Command->cmd_sglist, 1,
+		                        Command->DmaDirection);
+  Command->SegmentCount = 1;
+  Command->BlockNumber = Request->sector;
+  Command->BlockCount = Request->bio->bi_size >> 9;
+  DAC960_QueueReadWriteCommand(Command);
+  return;
+}
+
+
+/*
   DAC960_ProcessRequests attempts to remove as many I/O Requests as possible
   from Controller's I/O Request Queue and queue them to the Controller.
 */
@@ -3276,43 +3297,30 @@
   individual Buffer.
 */
 
-static inline void DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
+static inline boolean DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
 						 boolean SuccessfulIO)
 {
-	DAC960_CommandType_T CommandType = Command->CommandType;
 	IO_Request_T *Request = Command->Request;
-	int DmaDirection, UpToDate;
+	int UpToDate;
 
 	UpToDate = 0;
 	if (SuccessfulIO)
 		UpToDate = 1;
 
-	/*
-	 * We could save DmaDirection in the command structure
-	 * and just reuse that information here.
-	 */
-	if (CommandType == DAC960_ReadCommand ||
-		CommandType == DAC960_ReadRetryCommand)
-		DmaDirection = PCI_DMA_FROMDEVICE;
-	else
-		DmaDirection = PCI_DMA_TODEVICE;
-
-	pci_unmap_sg(Command->PciDevice, Command->V1.ScatterList,
-		Command->SegmentCount, DmaDirection);
-	/*
-	 * BlockCount is redundant with nr_sectors in the request
-	 * structure.  Consider eliminating BlockCount from the
-	 * command structure now that Command includes a pointer to
-	 * the request.
-	 */
-	 while (end_that_request_first(Request, UpToDate, Command->BlockCount))
-		 ;
- 	 end_that_request_last(Request);
-
-	if (Command->Completion) {
-		complete(Command->Completion);
-		Command->Completion = NULL;
+	pci_unmap_sg(Command->PciDevice, Command->cmd_sglist,
+		Command->SegmentCount, Command->DmaDirection);
+
+	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
+
+ 	 	end_that_request_last(Request);
+
+		if (Command->Completion) {
+			complete(Command->Completion);
+			Command->Completion = NULL;
+		}
+		return true;
 	}
+	return false;
 }
 
 /*
@@ -3384,46 +3392,64 @@
   if (CommandType == DAC960_ReadCommand ||
       CommandType == DAC960_WriteCommand)
     {
-      if (CommandStatus == DAC960_V1_NormalCompletion)
 
-		DAC960_ProcessCompletedRequest(Command, true);
+#ifdef FORCE_RETRY_DEBUG
+      CommandStatus = DAC960_V1_IrrecoverableDataError;
+#endif
+
+      if (CommandStatus == DAC960_V1_NormalCompletion) {
 
-      else if (CommandStatus == DAC960_V1_IrrecoverableDataError ||
+		if (!DAC960_ProcessCompletedRequest(Command, true))
+			BUG();
+
+      } else if (CommandStatus == DAC960_V1_IrrecoverableDataError ||
 		CommandStatus == DAC960_V1_BadDataEncountered)
 	{
-
 	  /*
-	   * Finish this later.
-	   *
-	   * We should call "complete_that_request_first()"
-	   * to remove the first part of the request.  Then, if there
-	   * is still more I/O to be done, resubmit the request.
-	   *
-	   * We want to recalculate scatter/gather list,
-	   * and requeue the command.
-	   *
-	   * For now, print a message on the console, and clone
-	   * the code for "normal" completion.
+	   * break the command down into pieces and resubmit each
+	   * piece, hoping that some of them will succeed.
 	   */
-	  printk("V1_ProcessCompletedCommand: I/O error on read/write\n");
-
-	  DAC960_ProcessCompletedRequest(Command, false);
+	   DAC960_queue_partial_rw(Command);
+	   return;
 	}
       else
 	{
 	  if (CommandStatus != DAC960_V1_LogicalDriveNonexistentOrOffline)
 	    DAC960_V1_ReadWriteError(Command);
 
-	  DAC960_ProcessCompletedRequest(Command, false);
+	 if (!DAC960_ProcessCompletedRequest(Command, false))
+		BUG();
 	}
     }
   else if (CommandType == DAC960_ReadRetryCommand ||
 	   CommandType == DAC960_WriteRetryCommand)
     {
-	/*
-	 * We're not doing retry commands yet.
-	 */
-	printk("DAC960_ProcessCompletedCommand: RetryCommand not done yet\n");
+      boolean normal_completion;
+#ifdef FORCE_RETRY_FAILURE_DEBUG
+      static int retry_count = 1;
+#endif
+      /*
+        Perform completion processing for the portion that was
+        retried, and submit the next portion, if any.
+      */
+      normal_completion = true;
+      if (CommandStatus != DAC960_V1_NormalCompletion) {
+        normal_completion = false;
+        if (CommandStatus != DAC960_V1_LogicalDriveNonexistentOrOffline)
+            DAC960_V1_ReadWriteError(Command);
+      }
+
+#ifdef FORCE_RETRY_FAILURE_DEBUG
+      if (!(++retry_count % 10000)) {
+	      printk("V1 error retry failure test\n");
+	      normal_completion = false;
+      }
+#endif
+
+      if (!DAC960_ProcessCompletedRequest(Command, normal_completion)) {
+        DAC960_queue_partial_rw(Command);
+        return;
+      }
     }
 
   else if (CommandType == DAC960_MonitoringCommand)
@@ -4451,23 +4477,25 @@
   if (CommandType == DAC960_ReadCommand ||
       CommandType == DAC960_WriteCommand)
     {
-      if (CommandStatus == DAC960_V2_NormalCompletion)
 
-		DAC960_ProcessCompletedRequest(Command, true);
+#ifdef FORCE_RETRY_DEBUG
+      CommandStatus = DAC960_V2_AbormalCompletion;
+#endif
+      Command->V2.RequestSense->SenseKey = DAC960_SenseKey_MediumError;
+
+      if (CommandStatus == DAC960_V2_NormalCompletion) {
+
+		if (!DAC960_ProcessCompletedRequest(Command, true))
+			BUG();
 
-      else if (Command->V2.RequestSense->SenseKey == DAC960_SenseKey_MediumError)
+      } else if (Command->V2.RequestSense->SenseKey == DAC960_SenseKey_MediumError)
 	{
-	  
 	  /*
-	   * Don't know yet how to handle this case.  
-	   * See comments in DAC960_V1_ProcessCompletedCommand()
-	   *
-	   * For now, print a message on the console, and clone
-	   * the code for "normal" completion.
+	   * break the command down into pieces and resubmit each
+	   * piece, hoping that some of them will succeed.
 	   */
-	  printk("V1_ProcessCompletedCommand: I/O error on read/write\n");
-
-	  DAC960_ProcessCompletedRequest(Command, false);
+	   DAC960_queue_partial_rw(Command);
+	   return;
 	}
       else
 	{
@@ -4476,13 +4504,39 @@
 	  /*
 	    Perform completion processing for all buffers in this I/O Request.
 	  */
-          DAC960_ProcessCompletedRequest(Command, false);
+          (void)DAC960_ProcessCompletedRequest(Command, false);
 	}
     }
   else if (CommandType == DAC960_ReadRetryCommand ||
 	   CommandType == DAC960_WriteRetryCommand)
     {
-	printk("DAC960_V2_ProcessCompletedCommand: retries not coded yet\n");
+      boolean normal_completion;
+
+#ifdef FORCE_RETRY_FAILURE_DEBUG
+      static int retry_count = 1;
+#endif
+      /*
+        Perform completion processing for the portion that was
+	retried, and submit the next portion, if any.
+      */
+      normal_completion = true;
+      if (CommandStatus != DAC960_V2_NormalCompletion) {
+	normal_completion = false;
+	if (Command->V2.RequestSense->SenseKey != DAC960_SenseKey_NotReady)
+	    DAC960_V2_ReadWriteError(Command);
+      }
+
+#ifdef FORCE_RETRY_FAILURE_DEBUG
+      if (!(++retry_count % 10000)) {
+	      printk("V2 error retry failure test\n");
+	      normal_completion = false;
+      }
+#endif
+
+      if (!DAC960_ProcessCompletedRequest(Command, normal_completion)) {
+		DAC960_queue_partial_rw(Command);
+        	return;
+      }
     }
   else if (CommandType == DAC960_MonitoringCommand)
     {
diff -ur linux-2.5.56_original/drivers/block/DAC960.h linux-2.5.56_DAC/drivers/block/DAC960.h
--- linux-2.5.56_original/drivers/block/DAC960.h	Mon Jan 13 09:29:04 2003
+++ linux-2.5.56_DAC/drivers/block/DAC960.h	Mon Jan 13 09:30:06 2003
@@ -2305,6 +2305,8 @@
   unsigned int BlockNumber;
   unsigned int BlockCount;
   unsigned int SegmentCount;
+  int	DmaDirection;
+  struct scatterlist *cmd_sglist;
   IO_Request_T *Request;
   struct pci_dev *PciDevice;
   union {

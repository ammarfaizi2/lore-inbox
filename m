Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbSIPWDY>; Mon, 16 Sep 2002 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbSIPWDY>; Mon, 16 Sep 2002 18:03:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262535AbSIPWDM>;
	Mon, 16 Sep 2002 18:03:12 -0400
Date: Mon, 16 Sep 2002 15:08:22 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020916150822.B17880@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <20020916131359.A17880@acpi.pdx.osdl.net> <E17r2Rr-0001Vk-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17r2Rr-0001Vk-00@starship>; from phillips@arcor.de on Mon, Sep 16, 2002 at 10:26:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Please post the patch, I'll try it right away.
> 
> -- 
> Daniel

Here's what I have so far.  Just don't try
to create a new disk partition using this patch.
Just use the partitions that already exist on the
logical drives.


diff -ur linux-2.5.34_original/drivers/block/DAC960.c linux-2.5.34_patch/drivers/block/DAC960.c
--- linux-2.5.34_original/drivers/block/DAC960.c	Mon Sep 16 14:34:12 2002
+++ linux-2.5.34_patch/drivers/block/DAC960.c	Mon Sep 16 14:59:14 2002
@@ -156,15 +156,42 @@
   int CommandAllocationLength, CommandAllocationGroupSize;
   int CommandsRemaining = 0, CommandIdentifier, CommandGroupByteCount;
   void *AllocationPointer = NULL;
+  void *ScatterGatherCPU = NULL;
+  dma_addr_t ScatterGatherDMA;
+  struct pci_pool *ScatterGatherPool;
+  void *RequestSenseCPU = NULL;
+  dma_addr_t RequestSenseDMA;
+  struct pci_pool *RequestSensePool = NULL;
+
   if (Controller->FirmwareType == DAC960_V1_Controller)
     {
       CommandAllocationLength = offsetof(DAC960_Command_T, V1.EndMarker);
       CommandAllocationGroupSize = DAC960_V1_CommandAllocationGroupSize;
+      ScatterGatherPool = pci_pool_create("DAC960_V1_ScatterGather",
+		Controller->PCIDevice,
+	DAC960_V1_ScatterGatherLimit * sizeof(DAC960_V1_ScatterGatherSegment_T),
+	sizeof(DAC960_V1_ScatterGatherSegment_T), 0, SLAB_ATOMIC);
+      if (ScatterGatherPool == NULL)
+	    return DAC960_Failure(Controller,
+			"AUXILIARY STRUCTURE CREATION (SG)");
+      Controller->ScatterGatherPool = ScatterGatherPool;
     }
   else
     {
       CommandAllocationLength = offsetof(DAC960_Command_T, V2.EndMarker);
       CommandAllocationGroupSize = DAC960_V2_CommandAllocationGroupSize;
+      ScatterGatherPool = pci_pool_create("DAC960_V2_ScatterGather",
+		Controller->PCIDevice,
+	DAC960_V2_ScatterGatherLimit * sizeof(DAC960_V2_ScatterGatherSegment_T),
+	sizeof(DAC960_V2_ScatterGatherSegment_T), 0, SLAB_ATOMIC);
+      RequestSensePool = pci_pool_create("DAC960_V2_RequestSense",
+		Controller->PCIDevice, sizeof(DAC960_SCSI_RequestSense_T),
+		sizeof(int), 0, SLAB_ATOMIC);
+      if (ScatterGatherPool == NULL || RequestSensePool == NULL)
+	    return DAC960_Failure(Controller,
+			"AUXILIARY STRUCTURE CREATION (SG)");
+      Controller->ScatterGatherPool = ScatterGatherPool;
+      Controller->V2.RequestSensePool = RequestSensePool;
     }
   Controller->CommandAllocationGroupSize = CommandAllocationGroupSize;
   Controller->FreeCommands = NULL;
@@ -176,16 +203,17 @@
       if (--CommandsRemaining <= 0)
 	{
 	  CommandsRemaining =
-	    Controller->DriverQueueDepth - CommandIdentifier + 1;
+		Controller->DriverQueueDepth - CommandIdentifier + 1;
 	  if (CommandsRemaining > CommandAllocationGroupSize)
-	    CommandsRemaining = CommandAllocationGroupSize;
+		CommandsRemaining = CommandAllocationGroupSize;
 	  CommandGroupByteCount =
-	    CommandsRemaining * CommandAllocationLength;
+		CommandsRemaining * CommandAllocationLength;
 	  AllocationPointer = kmalloc(CommandGroupByteCount, GFP_ATOMIC);
 	  if (AllocationPointer == NULL)
-	    return DAC960_Failure(Controller, "AUXILIARY STRUCTURE CREATION");
+		return DAC960_Failure(Controller,
+					"AUXILIARY STRUCTURE CREATION");
 	  memset(AllocationPointer, 0, CommandGroupByteCount);
-	}
+	 }
       Command = (DAC960_Command_T *) AllocationPointer;
       AllocationPointer += CommandAllocationLength;
       Command->CommandIdentifier = CommandIdentifier;
@@ -193,6 +221,33 @@
       Command->Next = Controller->FreeCommands;
       Controller->FreeCommands = Command;
       Controller->Commands[CommandIdentifier-1] = Command;
+      ScatterGatherCPU = pci_pool_alloc(ScatterGatherPool, SLAB_ATOMIC,
+							&ScatterGatherDMA);
+      if (ScatterGatherCPU == NULL)
+	  return DAC960_Failure(Controller, "AUXILIARY STRUCTURE CREATION");
+
+      if (RequestSensePool != NULL) {
+  	  RequestSenseCPU = pci_pool_alloc(RequestSensePool, SLAB_ATOMIC,
+						&RequestSenseDMA);
+  	  if (RequestSenseCPU == NULL) {
+                pci_pool_free(ScatterGatherPool, ScatterGatherCPU,
+                                ScatterGatherDMA);
+    		return DAC960_Failure(Controller,
+					"AUXILIARY STRUCTURE CREATION");
+	  }
+        }
+     if (Controller->FirmwareType == DAC960_V1_Controller) {
+	Command->V1.ScatterGatherList =
+		(DAC960_V1_ScatterGatherSegment_T *)ScatterGatherCPU;
+	Command->V1.ScatterGatherListDMA = ScatterGatherDMA;
+      } else {
+	Command->V2.ScatterGatherList =
+		(DAC960_V2_ScatterGatherSegment_T *)ScatterGatherCPU;
+	Command->V2.ScatterGatherListDMA = ScatterGatherDMA;
+	Command->V2.RequestSense =
+				(DAC960_SCSI_RequestSense_T *)RequestSenseCPU;
+	Command->V2.RequestSenseDMA = RequestSenseDMA;
+      }
     }
   return true;
 }
@@ -206,16 +261,57 @@
 static void DAC960_DestroyAuxiliaryStructures(DAC960_Controller_T *Controller)
 {
   int i;
+  struct pci_pool *ScatterGatherPool;
+  struct pci_pool *RequestSensePool;
+  void *ScatterGatherCPU;
+  dma_addr_t ScatterGatherDMA;
+  void *RequestSenseCPU;
+  dma_addr_t RequestSenseDMA = 0;
+  DAC960_Command_T *CommandGroup = NULL;
+  
+  ScatterGatherPool = Controller->ScatterGatherPool;
+  if (Controller->FirmwareType == DAC960_V1_Controller)
+        RequestSensePool = Controller->V2.RequestSensePool;
+
   Controller->FreeCommands = NULL;
+  RequestSenseCPU = NULL;
   for (i = 0; i < Controller->DriverQueueDepth; i++)
     {
       DAC960_Command_T *Command = Controller->Commands[i];
-      if (Command != NULL &&
-	  (Command->CommandIdentifier
-	   % Controller->CommandAllocationGroupSize) == 1)
-	kfree(Command);
+
+      if (Command == NULL)
+	  continue;
+
+      if (Controller->FirmwareType == DAC960_V1_Controller) {
+	  ScatterGatherCPU = (void *)Command->V1.ScatterGatherList;
+	  ScatterGatherDMA = Command->V1.ScatterGatherListDMA;
+      } else {
+          ScatterGatherCPU = (void *)Command->V2.ScatterGatherList;
+	  ScatterGatherDMA = Command->V2.ScatterGatherListDMA;
+	  RequestSenseCPU = (void *)Command->V2.RequestSense;
+	  RequestSenseDMA = Command->V2.RequestSenseDMA;
+      }
+      if (ScatterGatherCPU != NULL)
+          pci_pool_free(ScatterGatherPool, ScatterGatherCPU, ScatterGatherDMA);
+      if (RequestSenseCPU != NULL)
+          pci_pool_free(ScatterGatherPool, RequestSenseCPU, RequestSenseDMA);
+
+      if ((Command->CommandIdentifier
+	   % Controller->CommandAllocationGroupSize) == 1) {
+	   /*
+	    * We can't free the group of commands until all of the
+	    * request sense and scatter gather dma structures are free.
+            * Remember the beginning of the group, but don't free it
+	    * until we've reached the beginning of the next group.
+	    */
+	   if (CommandGroup != NULL)
+		kfree(CommandGroup);
+	    CommandGroup = Command;
+      }
       Controller->Commands[i] = NULL;
     }
+  if (CommandGroup != NULL)
+      kfree(CommandGroup);
   if (Controller->CombinedStatusBuffer != NULL)
     {
       kfree(Controller->CombinedStatusBuffer);
@@ -297,6 +393,8 @@
 static inline void DAC960_DeallocateCommand(DAC960_Command_T *Command)
 {
   DAC960_Controller_T *Controller = Command->Controller;
+
+  Command->Request = NULL;
   Command->Next = Controller->FreeCommands;
   Controller->FreeCommands = Command;
 }
@@ -308,9 +406,9 @@
 
 static void DAC960_WaitForCommand(DAC960_Controller_T *Controller)
 {
-  spin_unlock_irq(Controller->RequestQueue->queue_lock);
+  spin_unlock_irq(&Controller->queue_lock);
   __wait_event(Controller->CommandWaitQueue, Controller->FreeCommands);
-  spin_lock_irq(Controller->RequestQueue->queue_lock);
+  spin_lock_irq(&Controller->queue_lock);
 }
 
 
@@ -1932,7 +2030,6 @@
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
   char *names;
   RequestQueue_T *RequestQueue;
-  int MinorNumber;
   int n;
 
   names = kmalloc(9 * DAC960_MaxLogicalDrives, GFP_KERNEL);
@@ -1955,7 +2052,6 @@
     Initialize the I/O Request Queue.
   */
   RequestQueue = BLK_DEFAULT_QUEUE(MajorNumber);
-  Controller->queue_lock = SPIN_LOCK_UNLOCKED;
   blk_init_queue(RequestQueue, DAC960_RequestFunction, &Controller->queue_lock);
   RequestQueue->queuedata = Controller;
   blk_queue_max_hw_segments(RequestQueue,
@@ -1991,10 +2087,11 @@
 {
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
   int disk;
-  for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++) {
+
+  for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++)
 	  del_gendisk(&Controller->disks[disk]);
-	  kfree(Controller->disks[0].major_name);
-  }
+
+  kfree(Controller->disks[0].major_name);
   /*
     Unregister the Block Device Major Number for this DAC960 Controller.
   */
@@ -2218,6 +2315,7 @@
       Controller->ControllerNumber = DAC960_ControllerCount;
       init_waitqueue_head(&Controller->CommandWaitQueue);
       init_waitqueue_head(&Controller->HealthStatusWaitQueue);
+      Controller->queue_lock = SPIN_LOCK_UNLOCKED; 
       DAC960_Controllers[DAC960_ControllerCount++] = Controller;
       DAC960_AnnounceDriver(Controller);
       Controller->FirmwareType = FirmwareType;
@@ -2676,57 +2774,60 @@
 {
   DAC960_Controller_T *Controller = Command->Controller;
   DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
+  DAC960_V1_ScatterGatherSegment_T *ScatterGatherList =
+					Command->V1.ScatterGatherList;
+  struct scatterlist *ScatterList = Command->V1.ScatterList;
+  int DmaDirection, SegCount;
+
   DAC960_V1_ClearCommand(Command);
-  if (Command->SegmentCount == 1)
+
+  if (Command->CommandType == DAC960_ReadCommand)
+        DmaDirection = PCI_DMA_FROMDEVICE;
+  else
+        DmaDirection = PCI_DMA_TODEVICE;
+
+  SegCount = blk_rq_map_sg(Controller->RequestQueue, Command->Request,
+								ScatterList);
+  /* pci_map_sg MAY change the value of SegCount */
+  SegCount = pci_map_sg(Command->PciDevice, ScatterList, SegCount,
+								DmaDirection);
+  Command->SegmentCount = SegCount;
+
+  if (SegCount == 1)
     {
       if (Command->CommandType == DAC960_ReadCommand)
 	CommandMailbox->Type5.CommandOpcode = DAC960_V1_Read;
-      else CommandMailbox->Type5.CommandOpcode = DAC960_V1_Write;
+      else 
+        CommandMailbox->Type5.CommandOpcode = DAC960_V1_Write;
+
       CommandMailbox->Type5.LD.TransferLength = Command->BlockCount;
       CommandMailbox->Type5.LD.LogicalDriveNumber = Command->LogicalDriveNumber;
       CommandMailbox->Type5.LogicalBlockAddress = Command->BlockNumber;
       CommandMailbox->Type5.BusAddress =
-	Virtual_to_Bus32(Command->RequestBuffer);
+			(DAC960_BusAddress32_T)sg_dma_address(ScatterList);	
     }
   else
     {
-      DAC960_V1_ScatterGatherSegment_T
-	*ScatterGatherList = Command->V1.ScatterGatherList;
-      BufferHeader_T *BufferHeader = Command->BufferHeader;
-      char *LastDataEndPointer = NULL;
-      int SegmentNumber = 0;
+      int i;
+
       if (Command->CommandType == DAC960_ReadCommand)
 	CommandMailbox->Type5.CommandOpcode = DAC960_V1_ReadWithScatterGather;
       else
 	CommandMailbox->Type5.CommandOpcode = DAC960_V1_WriteWithScatterGather;
+
       CommandMailbox->Type5.LD.TransferLength = Command->BlockCount;
       CommandMailbox->Type5.LD.LogicalDriveNumber = Command->LogicalDriveNumber;
       CommandMailbox->Type5.LogicalBlockAddress = Command->BlockNumber;
-      CommandMailbox->Type5.BusAddress = Virtual_to_Bus32(ScatterGatherList);
-      CommandMailbox->Type5.ScatterGatherCount = Command->SegmentCount;
-      while (BufferHeader != NULL)
-	{
-	  if (bio_data(BufferHeader) == LastDataEndPointer)
-	    {
-	      ScatterGatherList[SegmentNumber-1].SegmentByteCount +=
-		BufferHeader->bi_size;
-	      LastDataEndPointer += BufferHeader->bi_size;
-	    }
-	  else
-	    {
-	      ScatterGatherList[SegmentNumber].SegmentDataPointer =
-		Virtual_to_Bus32(bio_data(BufferHeader));
-	      ScatterGatherList[SegmentNumber].SegmentByteCount =
-		BufferHeader->bi_size;
-	      LastDataEndPointer = bio_data(BufferHeader) +
-		BufferHeader->bi_size;
-	      if (SegmentNumber++ > Controller->DriverScatterGatherLimit)
-		panic("DAC960: Scatter/Gather Segment Overflow\n");
-	    }
-	  BufferHeader = BufferHeader->bi_next;
-	}
-      if (SegmentNumber != Command->SegmentCount)
-	panic("DAC960: SegmentNumber != SegmentCount\n");
+      CommandMailbox->Type5.BusAddress = Command->V1.ScatterGatherListDMA;
+
+      CommandMailbox->Type5.ScatterGatherCount = SegCount;
+
+      for (i = 0; i < SegCount; i++, ScatterList++, ScatterGatherList++) {
+		ScatterGatherList->SegmentDataPointer =
+			(DAC960_BusAddress32_T)sg_dma_address(ScatterList);
+		ScatterGatherList->SegmentByteCount =
+			(DAC960_ByteCount32_T)sg_dma_len(ScatterList);
+      }
     }
   DAC960_QueueCommand(Command);
 }
@@ -2741,18 +2842,32 @@
 {
   DAC960_Controller_T *Controller = Command->Controller;
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  struct scatterlist *ScatterList = Command->V2.ScatterList;
+  int DmaDirection, SegCount;
+
   DAC960_V2_ClearCommand(Command);
+
+  if (Command->CommandType == DAC960_ReadCommand)
+        DmaDirection = PCI_DMA_FROMDEVICE;
+  else
+        DmaDirection = PCI_DMA_TODEVICE;
+
+  SegCount = blk_rq_map_sg(Controller->RequestQueue, Command->Request,
+								ScatterList);
+  /* pci_map_sg MAY change the value of SegCount */
+  SegCount = pci_map_sg(Command->PciDevice, ScatterList, SegCount,
+								DmaDirection);
+  Command->SegmentCount = SegCount;
+
   CommandMailbox->SCSI_10.CommandOpcode = DAC960_V2_SCSI_10;
   CommandMailbox->SCSI_10.CommandControlBits.DataTransferControllerToHost =
     (Command->CommandType == DAC960_ReadCommand);
   CommandMailbox->SCSI_10.DataTransferSize =
     Command->BlockCount << DAC960_BlockSizeBits;
-  CommandMailbox->SCSI_10.RequestSenseBusAddress =
-    Virtual_to_Bus64(&Command->V2.RequestSense);
+  CommandMailbox->SCSI_10.RequestSenseBusAddress = Command->V2.RequestSenseDMA;
   CommandMailbox->SCSI_10.PhysicalDevice =
     Controller->V2.LogicalDriveToVirtualDevice[Command->LogicalDriveNumber];
-  CommandMailbox->SCSI_10.RequestSenseSize =
-    sizeof(DAC960_SCSI_RequestSense_T);
+  CommandMailbox->SCSI_10.RequestSenseSize = sizeof(DAC960_SCSI_RequestSense_T);
   CommandMailbox->SCSI_10.CDBLength = 10;
   CommandMailbox->SCSI_10.SCSI_CDB[0] =
     (Command->CommandType == DAC960_ReadCommand ? 0x28 : 0x2A);
@@ -2762,12 +2877,13 @@
   CommandMailbox->SCSI_10.SCSI_CDB[5] = Command->BlockNumber;
   CommandMailbox->SCSI_10.SCSI_CDB[7] = Command->BlockCount >> 8;
   CommandMailbox->SCSI_10.SCSI_CDB[8] = Command->BlockCount;
-  if (Command->SegmentCount == 1)
+
+  if (SegCount == 1)
     {
       CommandMailbox->SCSI_10.DataTransferMemoryAddress
 			     .ScatterGatherSegments[0]
 			     .SegmentDataPointer =
-	Virtual_to_Bus64(Command->RequestBuffer);
+	(DAC960_BusAddress64_T)sg_dma_address(ScatterList);
       CommandMailbox->SCSI_10.DataTransferMemoryAddress
 			     .ScatterGatherSegments[0]
 			     .SegmentByteCount =
@@ -2775,49 +2891,30 @@
     }
   else
     {
-      DAC960_V2_ScatterGatherSegment_T
-	*ScatterGatherList = Command->V2.ScatterGatherList;
-      BufferHeader_T *BufferHeader = Command->BufferHeader;
-      char *LastDataEndPointer = NULL;
-      int SegmentNumber = 0;
-      if (Command->SegmentCount > 2)
+      DAC960_V2_ScatterGatherSegment_T *ScatterGatherList;
+      int i;
+
+      if (SegCount > 2)
 	{
+          ScatterGatherList = Command->V2.ScatterGatherList;
 	  CommandMailbox->SCSI_10.CommandControlBits
 			 .AdditionalScatterGatherListMemory = true;
 	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
-			 .ExtendedScatterGather.ScatterGatherList0Length =
-	    Command->SegmentCount;
+		.ExtendedScatterGather.ScatterGatherList0Length = SegCount;
 	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
 			 .ExtendedScatterGather.ScatterGatherList0Address =
-	    Virtual_to_Bus64(ScatterGatherList);
+	    Command->V2.ScatterGatherListDMA;
 	}
       else
-	ScatterGatherList =
-	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
+	ScatterGatherList = CommandMailbox->SCSI_10.DataTransferMemoryAddress
 				 .ScatterGatherSegments;
-      while (BufferHeader != NULL)
-	{
-	  if (bio_data(BufferHeader) == LastDataEndPointer)
-	    {
-	      ScatterGatherList[SegmentNumber-1].SegmentByteCount +=
-		BufferHeader->bi_size;
-	      LastDataEndPointer += BufferHeader->bi_size;
-	    }
-	  else
-	    {
-	      ScatterGatherList[SegmentNumber].SegmentDataPointer =
-		Virtual_to_Bus64(bio_data(BufferHeader));
-	      ScatterGatherList[SegmentNumber].SegmentByteCount =
-		BufferHeader->bi_size;
-	      LastDataEndPointer = bio_data(BufferHeader) +
-		BufferHeader->bi_size;
-	      if (SegmentNumber++ > Controller->DriverScatterGatherLimit)
-		panic("DAC960: Scatter/Gather Segment Overflow\n");
-	    }
-	  BufferHeader = BufferHeader->bi_next;
-	}
-      if (SegmentNumber != Command->SegmentCount)
-	panic("DAC960: SegmentNumber != SegmentCount\n");
+
+      for (i = 0; i < SegCount; i++, ScatterList++, ScatterGatherList++) {
+		ScatterGatherList->SegmentDataPointer =
+			(DAC960_BusAddress64_T)sg_dma_address(ScatterList);
+		ScatterGatherList->SegmentByteCount =
+			(DAC960_ByteCount64_T)sg_dma_len(ScatterList);
+      }
     }
   DAC960_QueueCommand(Command);
 }
@@ -2834,32 +2931,36 @@
 				     boolean WaitForCommand)
 {
   RequestQueue_T *RequestQueue = Controller->RequestQueue;
-  ListHead_T *RequestQueueHead;
   IO_Request_T *Request;
   DAC960_Command_T *Command;
-  if (RequestQueue == NULL) return false;
-  RequestQueueHead = &RequestQueue->queue_head;
-  while (true)
-    {
-      if (list_empty(RequestQueueHead)) return false;
+
+  if (RequestQueue == NULL)
+     return false;
+
+  while (true) {
+      if (blk_queue_empty(RequestQueue))
+          return false;
+
       Request = elv_next_request(RequestQueue);
       Command = DAC960_AllocateCommand(Controller);
-      if (Command != NULL) break;
-      if (!WaitForCommand) return false;
+      if (Command != NULL)
+          break;
+
+      if (!WaitForCommand)
+          return false;
+
       DAC960_WaitForCommand(Controller);
-    }
-  if (Request->cmd == READ)
+  }
+  if (rq_data_dir(Request) == READ)
     Command->CommandType = DAC960_ReadCommand;
-  else Command->CommandType = DAC960_WriteCommand;
+  else
+    Command->CommandType = DAC960_WriteCommand;
   Command->Completion = Request->waiting;
   Command->LogicalDriveNumber = DAC960_LogicalDriveNumber(Request->rq_dev);
   Command->BlockNumber = Request->sector;
   Command->BlockCount = Request->nr_sectors;
-  Command->SegmentCount = Request->nr_phys_segments;
-  Command->BufferHeader = Request->bio;
-  Command->RequestBuffer = Request->buffer;
+  Command->Request = Request;
   blkdev_dequeue_request(Request);
-  blk_put_request(Request);
   DAC960_QueueReadWriteCommand(Command);
   return true;
 }
@@ -2906,18 +3007,50 @@
   individual Buffer.
 */
 
-static inline void DAC960_ProcessCompletedBuffer(BufferHeader_T *BufferHeader,
+static inline void DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
 						 boolean SuccessfulIO)
 {
-  if (SuccessfulIO)
-    set_bit(BIO_UPTODATE, &BufferHeader->bi_flags);
-  blk_finished_io(bio_sectors(BufferHeader));
-  BufferHeader->bi_end_io(BufferHeader);
+	DAC960_CommandType_T CommandType = Command->CommandType;
+	IO_Request_T *Request = Command->Request;
+	int DmaDirection;
+	int UpToDate;
+
+	UpToDate = 0;
+	if (SuccessfulIO == true)
+		UpToDate = 1;
+
+	/*
+	 * We could save DmaDirection in the command structure
+	 * and just reuse that information here.
+	 */
+	if (CommandType == DAC960_ReadCommand ||
+		CommandType == DAC960_ReadRetryCommand)
+		DmaDirection = PCI_DMA_FROMDEVICE;
+	else
+		DmaDirection = PCI_DMA_TODEVICE;
+
+	pci_unmap_sg(Command->PciDevice, Command->V1.ScatterList,
+		Command->SegmentCount, DmaDirection);
+	/*
+	 * BlockCount is redundant with nr_sectors in the request
+	 * structure.  Consider eliminating BlockCount from the
+	 * command structure now that Command includes a pointer to
+	 * the request.
+	 */
+	 while (end_that_request_first(Request, UpToDate, Command->BlockCount));
+
+ 	 end_that_request_last(Request);
+
+	if (Command->Completion != NULL)
+	{
+		complete(Command->Completion);
+		Command->Completion = NULL;
+	}
 }
 
 static inline int DAC960_PartitionByCommand(DAC960_Command_T *Command)
 {
-	return DAC960_PartitionNumber(to_kdev_t(Command->BufferHeader->bi_bdev->bd_dev)); 
+	return DAC960_PartitionNumber(Command->Request->rq_dev);
 }
 
 /*
@@ -2975,8 +3108,8 @@
 		 Controller, Controller->ControllerNumber,
 		 Command->LogicalDriveNumber,
 		 DAC960_PartitionByCommand(Command),
-		 Command->BufferHeader->bi_sector,
-		 Command->BufferHeader->bi_sector + Command->BlockCount - 1);
+		 Command->Request->sector, 
+		 Command->Request->sector + Command->BlockCount - 1);
 }
 
 
@@ -2992,106 +3125,50 @@
   DAC960_V1_CommandOpcode_T CommandOpcode =
     Command->V1.CommandMailbox.Common.CommandOpcode;
   DAC960_V1_CommandStatus_T CommandStatus = Command->V1.CommandStatus;
-  BufferHeader_T *BufferHeader = Command->BufferHeader;
+
   if (CommandType == DAC960_ReadCommand ||
       CommandType == DAC960_WriteCommand)
     {
       if (CommandStatus == DAC960_V1_NormalCompletion)
+
+		DAC960_ProcessCompletedRequest(Command, true);
+
+      else if (CommandStatus == DAC960_V1_IrrecoverableDataError ||
+		CommandStatus == DAC960_V1_BadDataEncountered)
 	{
+
 	  /*
-	    Perform completion processing for all buffers in this I/O Request.
-	  */
-	  while (BufferHeader != NULL)
-	    {
-	      BufferHeader_T *NextBufferHeader = BufferHeader->bi_next;
-	      BufferHeader->bi_next = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
-	      BufferHeader = NextBufferHeader;
-	    }
-	  if (Command->Completion != NULL)
-	    {
-	      complete(Command->Completion);
-	      Command->Completion = NULL;
-	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
-	}
-      else if ((CommandStatus == DAC960_V1_IrrecoverableDataError ||
-		CommandStatus == DAC960_V1_BadDataEncountered) &&
-	       BufferHeader != NULL &&
-	       BufferHeader->bi_next != NULL)
-	{
-	  DAC960_V1_CommandMailbox_T *CommandMailbox =
-	    &Command->V1.CommandMailbox;
-	  if (CommandType == DAC960_ReadCommand)
-	    {
-	      Command->CommandType = DAC960_ReadRetryCommand;
-	      CommandMailbox->Type5.CommandOpcode = DAC960_V1_Read;
-	    }
-	  else
-	    {
-	      Command->CommandType = DAC960_WriteRetryCommand;
-	      CommandMailbox->Type5.CommandOpcode = DAC960_V1_Write;
-	    }
-	  Command->BlockCount = BufferHeader->bi_size >> DAC960_BlockSizeBits;
-	  CommandMailbox->Type5.LD.TransferLength = Command->BlockCount;
-	  CommandMailbox->Type5.BusAddress =
-	    Virtual_to_Bus32(bio_data(BufferHeader));
-	  DAC960_QueueCommand(Command);
-	  return;
+	   * Finish this later.
+	   *
+	   * We should call "complete_that_request_first()"
+	   * to remove the first part of the request.  Then, if there
+	   * is still more I/O to be done, resubmit the request.
+	   *
+	   * We want to recalculate scatter/gather list,
+	   * and requeue the command.
+	   *
+	   * For now, print a message on the console, and clone
+	   * the code for "normal" completion.
+	   */
+	  printk("V1_ProcessCompletedCommand: I/O error on read/write\n");
+
+	  DAC960_ProcessCompletedRequest(Command, false);
 	}
       else
 	{
 	  if (CommandStatus != DAC960_V1_LogicalDriveNonexistentOrOffline)
 	    DAC960_V1_ReadWriteError(Command);
-	  /*
-	    Perform completion processing for all buffers in this I/O Request.
-	  */
-	  while (BufferHeader != NULL)
-	    {
-	      BufferHeader_T *NextBufferHeader = BufferHeader->bi_next;
-	      BufferHeader->bi_next = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
-	      BufferHeader = NextBufferHeader;
-	    }
-	  if (Command->Completion != NULL)
-	    {
-	      complete(Command->Completion);
-	      Command->Completion = NULL;
-	    }
+
+	  DAC960_ProcessCompletedRequest(Command, false);
 	}
     }
   else if (CommandType == DAC960_ReadRetryCommand ||
 	   CommandType == DAC960_WriteRetryCommand)
     {
-      BufferHeader_T *NextBufferHeader = BufferHeader->bi_next;
-      BufferHeader->bi_next = NULL;
-      /*
-	Perform completion processing for this single buffer.
-      */
-      if (CommandStatus == DAC960_V1_NormalCompletion)
-	DAC960_ProcessCompletedBuffer(BufferHeader, true);
-      else
-	{
-	  if (CommandStatus != DAC960_V1_LogicalDriveNonexistentOrOffline)
-	    DAC960_V1_ReadWriteError(Command);
-	  DAC960_ProcessCompletedBuffer(BufferHeader, false);
-	}
-      if (NextBufferHeader != NULL)
-	{
-	  DAC960_V1_CommandMailbox_T *CommandMailbox =
-	    &Command->V1.CommandMailbox;
-	  Command->BlockNumber +=
-	    BufferHeader->bi_size >> DAC960_BlockSizeBits;
-	  Command->BlockCount =
-	    NextBufferHeader->bi_size >> DAC960_BlockSizeBits;
-	  Command->BufferHeader = NextBufferHeader;
-	  CommandMailbox->Type5.LD.TransferLength = Command->BlockCount;
-	  CommandMailbox->Type5.LogicalBlockAddress = Command->BlockNumber;
-	  CommandMailbox->Type5.BusAddress =
-	    Virtual_to_Bus32(bio_data(NextBufferHeader));
-	  DAC960_QueueCommand(Command);
-	  return;
-	}
+	/*
+	 * We're not doing retry commands yet.
+	 */
+	printk("DAC960_ProcessCompletedCommand: RetryCommand not done yet\n");
     }
   else if (CommandType == DAC960_MonitoringCommand ||
 	   CommandOpcode == DAC960_V1_Enquiry ||
@@ -3829,7 +3906,7 @@
       break;
     }
   DAC960_Error("Error Condition %s on %s:\n", Controller,
-	       SenseErrors[Command->V2.RequestSense.SenseKey], CommandName);
+	       SenseErrors[Command->V2.RequestSense->SenseKey], CommandName);
   DAC960_Error("  /dev/rd/c%dd%d:   absolute blocks %u..%u\n",
 	       Controller, Controller->ControllerNumber,
 	       Command->LogicalDriveNumber, Command->BlockNumber,
@@ -3839,8 +3916,8 @@
 		 Controller, Controller->ControllerNumber,
 		 Command->LogicalDriveNumber,
 		 DAC960_PartitionByCommand(Command),
-		 Command->BufferHeader->bi_sector,
-		 Command->BufferHeader->bi_sector + Command->BlockCount - 1);
+		 Command->Request->sector,
+		 Command->Request->sector + Command->BlockCount - 1);
 }
 
 
@@ -4098,116 +4175,42 @@
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_IOCTL_Opcode_T CommandOpcode = CommandMailbox->Common.IOCTL_Opcode;
   DAC960_V2_CommandStatus_T CommandStatus = Command->V2.CommandStatus;
-  BufferHeader_T *BufferHeader = Command->BufferHeader;
+
   if (CommandType == DAC960_ReadCommand ||
       CommandType == DAC960_WriteCommand)
     {
       if (CommandStatus == DAC960_V2_NormalCompletion)
+
+		DAC960_ProcessCompletedRequest(Command, true);
+
+      else if (Command->V2.RequestSense->SenseKey == DAC960_SenseKey_MediumError)
 	{
+	  
 	  /*
-	    Perform completion processing for all buffers in this I/O Request.
-	  */
-	  while (BufferHeader != NULL)
-	    {
-	      BufferHeader_T *NextBufferHeader = BufferHeader->bi_next;
-	      BufferHeader->bi_next = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
-	      BufferHeader = NextBufferHeader;
-	    }
-	  if (Command->Completion != NULL)
-	    {
-	      complete(Command->Completion);
-	      Command->Completion = NULL;
-	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
-	}
-      else if (Command->V2.RequestSense.SenseKey
-	       == DAC960_SenseKey_MediumError &&
-	       BufferHeader != NULL &&
-	       BufferHeader->bi_next != NULL)
-	{
-	  if (CommandType == DAC960_ReadCommand)
-	    Command->CommandType = DAC960_ReadRetryCommand;
-	  else Command->CommandType = DAC960_WriteRetryCommand;
-	  Command->BlockCount = BufferHeader->bi_size >> DAC960_BlockSizeBits;
-	  CommandMailbox->SCSI_10.CommandControlBits
-				 .AdditionalScatterGatherListMemory = false;
-	  CommandMailbox->SCSI_10.DataTransferSize =
-	    Command->BlockCount << DAC960_BlockSizeBits;
-	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
-				 .ScatterGatherSegments[0].SegmentDataPointer =
-	    Virtual_to_Bus64(bio_data(BufferHeader));
-	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
-				 .ScatterGatherSegments[0].SegmentByteCount =
-	    CommandMailbox->SCSI_10.DataTransferSize;
-	  CommandMailbox->SCSI_10.SCSI_CDB[7] = Command->BlockCount >> 8;
-	  CommandMailbox->SCSI_10.SCSI_CDB[8] = Command->BlockCount;
-	  DAC960_QueueCommand(Command);
-	  return;
+	   * Don't know yet how to handle this case.  
+	   * See comments in DAC960_V1_ProcessCompletedCommand()
+	   *
+	   * For now, print a message on the console, and clone
+	   * the code for "normal" completion.
+	   */
+	  printk("V1_ProcessCompletedCommand: I/O error on read/write\n");
+
+	  DAC960_ProcessCompletedRequest(Command, false);
 	}
       else
 	{
-	  if (Command->V2.RequestSense.SenseKey != DAC960_SenseKey_NotReady)
+	  if (Command->V2.RequestSense->SenseKey != DAC960_SenseKey_NotReady)
 	    DAC960_V2_ReadWriteError(Command);
 	  /*
 	    Perform completion processing for all buffers in this I/O Request.
 	  */
-	  while (BufferHeader != NULL)
-	    {
-	      BufferHeader_T *NextBufferHeader = BufferHeader->bi_next;
-	      BufferHeader->bi_next = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
-	      BufferHeader = NextBufferHeader;
-	    }
-	  if (Command->Completion != NULL)
-	    {
-	      complete(Command->Completion);
-	      Command->Completion = NULL;
-	    }
+          DAC960_ProcessCompletedRequest(Command, false);
 	}
     }
   else if (CommandType == DAC960_ReadRetryCommand ||
 	   CommandType == DAC960_WriteRetryCommand)
     {
-      BufferHeader_T *NextBufferHeader = BufferHeader->bi_next;
-      BufferHeader->bi_next = NULL;
-      /*
-	Perform completion processing for this single buffer.
-      */
-      if (CommandStatus == DAC960_V2_NormalCompletion)
-	DAC960_ProcessCompletedBuffer(BufferHeader, true);
-      else
-	{
-	  if (Command->V2.RequestSense.SenseKey != DAC960_SenseKey_NotReady)
-	    DAC960_V2_ReadWriteError(Command);
-	  DAC960_ProcessCompletedBuffer(BufferHeader, false);
-	}
-      if (NextBufferHeader != NULL)
-	{
-	  Command->BlockNumber +=
-	    BufferHeader->bi_size >> DAC960_BlockSizeBits;
-	  Command->BlockCount =
-	    NextBufferHeader->bi_size >> DAC960_BlockSizeBits;
-	  Command->BufferHeader = NextBufferHeader;
-	  CommandMailbox->SCSI_10.DataTransferSize =
-	    Command->BlockCount << DAC960_BlockSizeBits;
-	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
-				 .ScatterGatherSegments[0]
-				 .SegmentDataPointer =
-	    Virtual_to_Bus64(bio_data(NextBufferHeader));
-	  CommandMailbox->SCSI_10.DataTransferMemoryAddress
-				 .ScatterGatherSegments[0]
-				 .SegmentByteCount =
-	    CommandMailbox->SCSI_10.DataTransferSize;
-	  CommandMailbox->SCSI_10.SCSI_CDB[2] = Command->BlockNumber >> 24;
-	  CommandMailbox->SCSI_10.SCSI_CDB[3] = Command->BlockNumber >> 16;
-	  CommandMailbox->SCSI_10.SCSI_CDB[4] = Command->BlockNumber >> 8;
-	  CommandMailbox->SCSI_10.SCSI_CDB[5] = Command->BlockNumber;
-	  CommandMailbox->SCSI_10.SCSI_CDB[7] = Command->BlockCount >> 8;
-	  CommandMailbox->SCSI_10.SCSI_CDB[8] = Command->BlockCount;
-	  DAC960_QueueCommand(Command);
-	  return;
-	}
+	printk("DAC960_V2_ProcessCompletedCommand: retries not coded yet\n");
     }
   else if (CommandType == DAC960_MonitoringCommand)
     {
@@ -5319,7 +5322,6 @@
   int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
   DiskGeometry_T Geometry, *UserGeometry;
   DAC960_Controller_T *Controller;
-  int res;
 
   if (File != NULL && (File->f_flags & O_NONBLOCK))
     return DAC960_UserIOCTL(Inode, File, Request, Argument);
@@ -5497,11 +5499,11 @@
 	    while (Controller->V1.DirectCommandActive[DCDB.Channel]
 						     [DCDB.TargetID])
 	      {
-		spin_unlock_irq(Controller->RequestQueue->queue_lock);
+		spin_unlock_irq(&Controller->queue_lock);
 		__wait_event(Controller->CommandWaitQueue,
 			     !Controller->V1.DirectCommandActive
 					     [DCDB.Channel][DCDB.TargetID]);
-		spin_lock_irq(Controller->RequestQueue->queue_lock);
+		spin_lock_irq(&Controller->queue_lock);
 	      }
 	    Controller->V1.DirectCommandActive[DCDB.Channel]
 					      [DCDB.TargetID] = true;
@@ -5536,9 +5538,10 @@
 	if (DataTransferLength > 0)
 	  {
 	    if (copy_to_user(UserCommand.DataTransferBuffer,
-			     DataTransferBuffer, DataTransferLength))
+			     DataTransferBuffer, DataTransferLength)) {
 		ErrorCode = -EFAULT;
 		goto Failure1;
+            }
 	  }
 	if (CommandOpcode == DAC960_V1_DCDB)
 	  {
diff -ur linux-2.5.34_original/drivers/block/DAC960.h linux-2.5.34_patch/drivers/block/DAC960.h
--- linux-2.5.34_original/drivers/block/DAC960.h	Mon Sep 16 14:34:12 2002
+++ linux-2.5.34_patch/drivers/block/DAC960.h	Mon Sep 16 14:41:41 2002
@@ -109,6 +109,43 @@
 
 typedef unsigned long long DAC960_ByteCount64_T;
 
+/******************************************/
+
+/*
+  Virtual_to_Bus32 maps from Kernel Virtual Addresses to 32 Bit PCI Bus
+  Addresses.
+*/
+
+static inline DAC960_BusAddress32_T Virtual_to_Bus32(void *VirtualAddress)
+{
+  return (DAC960_BusAddress32_T) virt_to_bus(VirtualAddress);
+}
+
+
+/*
+  Bus32_to_Virtual maps from 32 Bit PCI Bus Addresses to Kernel Virtual
+  Addresses.
+*/
+
+static inline void *Bus32_to_Virtual(DAC960_BusAddress32_T BusAddress)
+{
+  return (void *) bus_to_virt(BusAddress);
+}
+
+
+/*
+  Virtual_to_Bus64 maps from Kernel Virtual Addresses to 64 Bit PCI Bus
+  Addresses.
+*/
+
+static inline DAC960_BusAddress64_T Virtual_to_Bus64(void *VirtualAddress)
+{
+  return (DAC960_BusAddress64_T) virt_to_bus(VirtualAddress);
+}
+
+
+/******************************************/
+
 
 /*
   Define the SCSI INQUIRY Standard Data structure.
@@ -2191,7 +2228,6 @@
   of the Linux Kernel and I/O Subsystem.
 */
 
-typedef struct bio BufferHeader_T;
 typedef struct file File_T;
 typedef struct block_device_operations BlockDeviceOperations_T;
 typedef struct completion Completion_T;
@@ -2278,16 +2314,16 @@
   unsigned int BlockNumber;
   unsigned int BlockCount;
   unsigned int SegmentCount;
-  BufferHeader_T *BufferHeader;
-  void *RequestBuffer;
+  IO_Request_T *Request;
+  struct pci_dev *PciDevice;
   union {
     struct {
       DAC960_V1_CommandMailbox_T CommandMailbox;
       DAC960_V1_KernelCommand_T *KernelCommand;
       DAC960_V1_CommandStatus_T CommandStatus;
-      DAC960_V1_ScatterGatherSegment_T
-	ScatterGatherList[DAC960_V1_ScatterGatherLimit]
-	__attribute__ ((aligned (sizeof(DAC960_V1_ScatterGatherSegment_T))));
+      DAC960_V1_ScatterGatherSegment_T *ScatterGatherList;
+      dma_addr_t ScatterGatherListDMA;
+      struct scatterlist ScatterList[DAC960_V1_ScatterGatherLimit];
       unsigned int EndMarker[0];
     } V1;
     struct {
@@ -2296,11 +2332,11 @@
       DAC960_V2_CommandStatus_T CommandStatus;
       unsigned char RequestSenseLength;
       int DataTransferResidue;
-      DAC960_V2_ScatterGatherSegment_T
-	ScatterGatherList[DAC960_V2_ScatterGatherLimit]
-	__attribute__ ((aligned (sizeof(DAC960_V2_ScatterGatherSegment_T))));
-      DAC960_SCSI_RequestSense_T RequestSense
-	__attribute__ ((aligned (sizeof(int))));
+      DAC960_V2_ScatterGatherSegment_T *ScatterGatherList;
+      dma_addr_t ScatterGatherListDMA;
+      DAC960_SCSI_RequestSense_T *RequestSense;
+      dma_addr_t RequestSenseDMA;
+      struct scatterlist ScatterList[DAC960_V2_ScatterGatherLimit];
       unsigned int EndMarker[0];
     } V2;
   } FW;
@@ -2320,6 +2356,7 @@
   DAC960_HardwareType_T HardwareType;
   DAC960_IO_Address_T IO_Address;
   DAC960_PCI_Address_T PCI_Address;
+  PCI_Device_T  *PCIDevice;
   unsigned char ControllerNumber;
   unsigned char ControllerName[4];
   unsigned char ModelName[20];
@@ -2361,6 +2398,7 @@
   boolean SuppressEnclosureMessages;
   Timer_T MonitoringTimer;
   struct gendisk disks[DAC960_MaxLogicalDrives];
+  struct pci_pool *ScatterGatherPool;
   DAC960_Command_T *FreeCommands;
   unsigned char *CombinedStatusBuffer;
   unsigned char *CurrentStatusBuffer;
@@ -2446,6 +2484,7 @@
       boolean NeedDeviceSerialNumberInformation;
       boolean StartLogicalDeviceInformationScan;
       boolean StartPhysicalDeviceInformationScan;
+      struct pci_pool *RequestSensePool;
       DAC960_V2_CommandMailbox_T *FirstCommandMailbox;
       DAC960_V2_CommandMailbox_T *LastCommandMailbox;
       DAC960_V2_CommandMailbox_T *NextCommandMailbox;
@@ -2498,13 +2537,18 @@
 
 /*
   DAC960_AcquireControllerLock acquires exclusive access to Controller.
+	Reference the queue_lock through the controller structure,
+	rather than through the request queue.  These macros are
+        used to mutex on the controller structure during initialization,
+	BEFORE the request queue is allocated and initialized in
+	DAC960_RegisterBlockDevice().
 */
 
 static inline
 void DAC960_AcquireControllerLock(DAC960_Controller_T *Controller,
 				  ProcessorFlags_T *ProcessorFlags)
 {
-  spin_lock_irqsave(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_lock_irqsave(&Controller->queue_lock, *ProcessorFlags);
 }
 
 
@@ -2516,7 +2560,7 @@
 void DAC960_ReleaseControllerLock(DAC960_Controller_T *Controller,
 				  ProcessorFlags_T *ProcessorFlags)
 {
-  spin_unlock_irqrestore(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, *ProcessorFlags);
 }
 
 
@@ -2553,7 +2597,7 @@
 void DAC960_AcquireControllerLockIH(DAC960_Controller_T *Controller,
 				    ProcessorFlags_T *ProcessorFlags)
 {
-  spin_lock_irqsave(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_lock_irqsave(&Controller->queue_lock, *ProcessorFlags);
 }
 
 
@@ -2566,10 +2610,9 @@
 void DAC960_ReleaseControllerLockIH(DAC960_Controller_T *Controller,
 				    ProcessorFlags_T *ProcessorFlags)
 {
-  spin_unlock_irqrestore(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, *ProcessorFlags);
 }
 
-#error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
 
 /*
   Define the DAC960 BA Series Controller Interface Register Offsets.
@@ -4208,7 +4251,7 @@
 static void DAC960_FinalizeController(DAC960_Controller_T *);
 static int DAC960_Notifier(NotifierBlock_T *, unsigned long, void *);
 static void DAC960_V1_QueueReadWriteCommand(DAC960_Command_T *);
-static void DAC960_V2_QueueReadWriteCommand(DAC960_Command_T *);
+static void DAC960_V2_QueueReadWriteCommand(DAC960_Command_T *); 
 static void DAC960_RequestFunction(RequestQueue_T *);
 static void DAC960_BA_InterruptHandler(int, void *, Registers_T *);
 static void DAC960_LP_InterruptHandler(int, void *, Registers_T *);

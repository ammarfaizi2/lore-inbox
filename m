Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSIWTBP>; Mon, 23 Sep 2002 15:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbSIWTBH>; Mon, 23 Sep 2002 15:01:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261400AbSIWS6s>;
	Mon, 23 Sep 2002 14:58:48 -0400
Date: Mon, 23 Sep 2002 12:04:00 -0700
From: Dave Olien <dmo@osdl.org>
To: axboe@suse.de, phillips@arcor.de
Cc: _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: DAC960 in 2.5.38, with new changes
Message-ID: <20020923120400.A15452@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel, Jens

Thanks for the feedback.  Daniel, I've incorporated your patch into my
driver changes, and moved to linux 2.5.38.

Included are changes to put the memory mailbox and completion status
mailboxes into dma mapped pages.

I made a decision to remove some behavior from the functions:

	DAC960_V1_EnableMemoryMailboxInterface
	DAC960_FinalizeController

Following is a description of the behavior I have removed.

In the original code, for the  "LA" and "PG" controller types,
the FinalizeController() function does NOT free the memory for the
mailboxes for these controllers.  Instead, the Finalize function calls

	DAC960_LA_SaveMemoryMailboxInfo
		or
	DAC960_PG_SaveMemoryMailboxInfo

to instruct the controller to remember its memory mailbox addresses.

The driver EnableMemoryMailboxInterface() function calls 

	"DAC960_LA_RestoreMemoryMailboxInfo"
		or
	"DAC960_PG_RestoreMemoryMailboxInfo"

functions to retrieve the controller's stored memory mailbox pointers.

This behavior is "useful" only when the driver is unloaded, and then
reloaded.  

I changed to code to just free the memory mailboxes during Finalize,
and reallocate new ones when the driver is reloaded.
I feel it is much better to release this resource when the driver
isn't loaded.

In 2.5. the driver needs both DMA addresses (that would be the address
stored in the controller), and the CPU address.  To preserve the old
behavior in 2.5, the driver would need to save these CPU addresses
somewhere.  Strictly speaking, we shouldn't be translating between
the two address types.

I don't have specifications for these devices.
I don't know if there is some real reason for the old behavior.
I don't have either of these controller types available to test this change
either.  So, if you can think of any reason I should preserve the original
behavior, I'd appreciate the feedback.

Here is the new patch.  

--------------------Begin Patch---------------------------------------


diff -ur linux-2.5.38_original/drivers/block/DAC960.c linux-2.5.38_patch/drivers/block/DAC960.c
--- linux-2.5.38_original/drivers/block/DAC960.c	Mon Sep 23 11:12:25 2002
+++ linux-2.5.38_patch/drivers/block/DAC960.c	Mon Sep 23 10:59:14 2002
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
@@ -206,16 +261,58 @@
 static void DAC960_DestroyAuxiliaryStructures(DAC960_Controller_T *Controller)
 {
   int i;
+  struct pci_pool *ScatterGatherPool = NULL;
+  struct pci_pool *RequestSensePool = NULL;
+  void *ScatterGatherCPU;
+  dma_addr_t ScatterGatherDMA;
+  void *RequestSenseCPU;
+  dma_addr_t RequestSenseDMA = 0;
+  DAC960_Command_T *CommandGroup = NULL;
+  
+  ScatterGatherPool = Controller->ScatterGatherPool;
+
+  if (Controller->FirmwareType == DAC960_V2_Controller)
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
+          pci_pool_free(RequestSensePool, RequestSenseCPU, RequestSenseDMA);
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
@@ -297,6 +394,8 @@
 static inline void DAC960_DeallocateCommand(DAC960_Command_T *Command)
 {
   DAC960_Controller_T *Controller = Command->Controller;
+
+  Command->Request = NULL;
   Command->Next = Controller->FreeCommands;
   Controller->FreeCommands = Command;
 }
@@ -308,9 +407,9 @@
 
 static void DAC960_WaitForCommand(DAC960_Controller_T *Controller)
 {
-  spin_unlock_irq(Controller->RequestQueue->queue_lock);
+  spin_unlock_irq(&Controller->queue_lock);
   __wait_event(Controller->CommandWaitQueue, Controller->FreeCommands);
-  spin_lock_irq(Controller->RequestQueue->queue_lock);
+  spin_lock_irq(&Controller->queue_lock);
 }
 
 
@@ -825,84 +924,84 @@
 /*
   DAC960_V1_EnableMemoryMailboxInterface enables the Memory Mailbox Interface
   for DAC960 V1 Firmware Controllers.
+
+  This is never called for PD and P controller types,
+ 	 which have no memory mailbox.
 */
 
 static boolean DAC960_V1_EnableMemoryMailboxInterface(DAC960_Controller_T
 						      *Controller)
 {
   void *ControllerBaseAddress = Controller->BaseAddress;
+  PCI_Device_T	*PCI_Device = Controller->PCIDevice;
+
+  void *MemoryMailboxPagesAddress;
+  dma_addr_t MemoryMailboxPagesDMA;
+  unsigned long MemoryMailboxPagesSize;
+
   DAC960_V1_CommandMailbox_T *CommandMailboxesMemory;
+  dma_addr_t CommandMailboxesMemoryDMA;
+
   DAC960_V1_StatusMailbox_T *StatusMailboxesMemory;
+  dma_addr_t StatusMailboxesMemoryDMA;
+
   DAC960_V1_CommandMailbox_T CommandMailbox;
-  DAC960_V1_CommandStatus_T CommandStatus;
-  unsigned long MemoryMailboxPagesAddress;
-  unsigned long MemoryMailboxPagesOrder;
-  unsigned long MemoryMailboxPagesSize;
-  void *SavedMemoryMailboxesAddress = NULL;
-  short NextCommandMailboxIndex = 0;
-  short NextStatusMailboxIndex = 0;
-  int TimeoutCounter = 1000000, i;
-  MemoryMailboxPagesOrder = 0;
+  DAC960_V1_CommandStatus_T CommandStatus = 0;
+  int TimeoutCounter;
+  int i;
+
   MemoryMailboxPagesSize =
     DAC960_V1_CommandMailboxCount * sizeof(DAC960_V1_CommandMailbox_T) +
     DAC960_V1_StatusMailboxCount * sizeof(DAC960_V1_StatusMailbox_T);
-  while (MemoryMailboxPagesSize > PAGE_SIZE << MemoryMailboxPagesOrder)
-    MemoryMailboxPagesOrder++;
-  if (Controller->HardwareType == DAC960_LA_Controller)
-    DAC960_LA_RestoreMemoryMailboxInfo(Controller,
-				       &SavedMemoryMailboxesAddress,
-				       &NextCommandMailboxIndex,
-				       &NextStatusMailboxIndex);
-  else DAC960_PG_RestoreMemoryMailboxInfo(Controller,
-					  &SavedMemoryMailboxesAddress,
-					  &NextCommandMailboxIndex,
-					  &NextStatusMailboxIndex);
-  if (SavedMemoryMailboxesAddress == NULL)
-    {
-      MemoryMailboxPagesAddress =
-	__get_free_pages(GFP_KERNEL, MemoryMailboxPagesOrder);
-      Controller->MemoryMailboxPagesAddress = MemoryMailboxPagesAddress;
-      CommandMailboxesMemory =
+
+  MemoryMailboxPagesAddress = pci_alloc_consistent(PCI_Device,
+		    MemoryMailboxPagesSize, &MemoryMailboxPagesDMA);
+  if (MemoryMailboxPagesAddress == NULL)
+	    return false;
+  memset(MemoryMailboxPagesAddress, 0, MemoryMailboxPagesSize);
+  Controller->MemoryMailboxPagesAddress = MemoryMailboxPagesAddress;
+  Controller->MemoryMailboxPagesDMA = MemoryMailboxPagesDMA;
+  Controller->MemoryMailboxPagesSize = MemoryMailboxPagesSize;
+
+  CommandMailboxesMemory =
 	(DAC960_V1_CommandMailbox_T *) MemoryMailboxPagesAddress;
-    }
-  else CommandMailboxesMemory = SavedMemoryMailboxesAddress;
-  if (CommandMailboxesMemory == NULL) return false;
-  Controller->MemoryMailboxPagesOrder = MemoryMailboxPagesOrder;
-  memset(CommandMailboxesMemory, 0, MemoryMailboxPagesSize);
+  CommandMailboxesMemoryDMA = MemoryMailboxPagesDMA;
+  
   Controller->V1.FirstCommandMailbox = CommandMailboxesMemory;
+  Controller->V1.FirstCommandMailboxDMA = CommandMailboxesMemoryDMA;
+
   CommandMailboxesMemory += DAC960_V1_CommandMailboxCount - 1;
   Controller->V1.LastCommandMailbox = CommandMailboxesMemory;
-  Controller->V1.NextCommandMailbox =
-    &Controller->V1.FirstCommandMailbox[NextCommandMailboxIndex];
-  if (--NextCommandMailboxIndex < 0)
-    NextCommandMailboxIndex = DAC960_V1_CommandMailboxCount - 1;
-  Controller->V1.PreviousCommandMailbox1 =
-    &Controller->V1.FirstCommandMailbox[NextCommandMailboxIndex];
-  if (--NextCommandMailboxIndex < 0)
-    NextCommandMailboxIndex = DAC960_V1_CommandMailboxCount - 1;
+  Controller->V1.NextCommandMailbox = Controller->V1.FirstCommandMailbox;
+  Controller->V1.PreviousCommandMailbox1 = Controller->V1.LastCommandMailbox;
   Controller->V1.PreviousCommandMailbox2 =
-    &Controller->V1.FirstCommandMailbox[NextCommandMailboxIndex];
+	  				Controller->V1.LastCommandMailbox - 1;
   StatusMailboxesMemory =
-    (DAC960_V1_StatusMailbox_T *) (CommandMailboxesMemory + 1);
+    		(DAC960_V1_StatusMailbox_T *) (CommandMailboxesMemory + 1);
+  StatusMailboxesMemoryDMA = cpu_to_dma((void *)StatusMailboxesMemory,
+		  	MemoryMailboxPagesAddress, MemoryMailboxPagesDMA);
   Controller->V1.FirstStatusMailbox = StatusMailboxesMemory;
+  Controller->V1.FirstStatusMailboxDMA = StatusMailboxesMemoryDMA;
   StatusMailboxesMemory += DAC960_V1_StatusMailboxCount - 1;
   Controller->V1.LastStatusMailbox = StatusMailboxesMemory;
-  Controller->V1.NextStatusMailbox =
-    &Controller->V1.FirstStatusMailbox[NextStatusMailboxIndex];
-  if (SavedMemoryMailboxesAddress != NULL) return true;
+  Controller->V1.NextStatusMailbox = Controller->V1.FirstStatusMailbox;
+ 
   /* Enable the Memory Mailbox Interface. */
   Controller->V1.DualModeMemoryMailboxInterface = true;
   CommandMailbox.TypeX.CommandOpcode = 0x2B;
   CommandMailbox.TypeX.CommandIdentifier = 0;
   CommandMailbox.TypeX.CommandOpcode2 = 0x14;
   CommandMailbox.TypeX.CommandMailboxesBusAddress =
-    Virtual_to_Bus32(Controller->V1.FirstCommandMailbox);
+    				Controller->V1.FirstCommandMailboxDMA;
   CommandMailbox.TypeX.StatusMailboxesBusAddress =
-    Virtual_to_Bus32(Controller->V1.FirstStatusMailbox);
+    				Controller->V1.FirstStatusMailboxDMA;
+#define TIMEOUT_COUNT 1000000
+
   for (i = 0; i < 2; i++)
     switch (Controller->HardwareType)
       {
       case DAC960_LA_Controller:
+	TimeoutCounter = TIMEOUT_COUNT;
 	while (--TimeoutCounter >= 0)
 	  {
 	    if (!DAC960_LA_HardwareMailboxFullP(ControllerBaseAddress))
@@ -912,6 +1011,7 @@
 	if (TimeoutCounter < 0) return false;
 	DAC960_LA_WriteHardwareMailbox(ControllerBaseAddress, &CommandMailbox);
 	DAC960_LA_HardwareMailboxNewCommand(ControllerBaseAddress);
+	TimeoutCounter = TIMEOUT_COUNT;
 	while (--TimeoutCounter >= 0)
 	  {
 	    if (DAC960_LA_HardwareMailboxStatusAvailableP(
@@ -928,6 +1028,7 @@
 	CommandMailbox.TypeX.CommandOpcode2 = 0x10;
 	break;
       case DAC960_PG_Controller:
+	TimeoutCounter = TIMEOUT_COUNT;
 	while (--TimeoutCounter >= 0)
 	  {
 	    if (!DAC960_PG_HardwareMailboxFullP(ControllerBaseAddress))
@@ -937,6 +1038,8 @@
 	if (TimeoutCounter < 0) return false;
 	DAC960_PG_WriteHardwareMailbox(ControllerBaseAddress, &CommandMailbox);
 	DAC960_PG_HardwareMailboxNewCommand(ControllerBaseAddress);
+
+	TimeoutCounter = TIMEOUT_COUNT;
 	while (--TimeoutCounter >= 0)
 	  {
 	    if (DAC960_PG_HardwareMailboxStatusAvailableP(
@@ -968,69 +1071,104 @@
 						      *Controller)
 {
   void *ControllerBaseAddress = Controller->BaseAddress;
+  PCI_Device_T	*PCI_Device = Controller->PCIDevice;
+
+  void *MemoryMailboxPagesAddress;
+  dma_addr_t MemoryMailboxPagesDMA;
+  unsigned long MemoryMailboxPagesSize;
+
   DAC960_V2_CommandMailbox_T *CommandMailboxesMemory;
+  dma_addr_t CommandMailboxesMemoryDMA;
+
   DAC960_V2_StatusMailbox_T *StatusMailboxesMemory;
-  DAC960_V2_CommandMailbox_T CommandMailbox;
+  dma_addr_t StatusMailboxesMemoryDMA;
+
+  DAC960_V2_CommandMailbox_T *CommandMailbox;
+  dma_addr_t	CommandMailboxDMA;
   DAC960_V2_CommandStatus_T CommandStatus = 0;
-  unsigned long MemoryMailboxPagesAddress;
-  unsigned long MemoryMailboxPagesOrder;
-  unsigned long MemoryMailboxPagesSize;
-  MemoryMailboxPagesOrder = 0;
+
+  CommandMailbox =
+	  (DAC960_V2_CommandMailbox_T *)pci_alloc_consistent( PCI_Device,
+		sizeof(DAC960_V2_CommandMailbox_T), &CommandMailboxDMA);
+  if (CommandMailbox == NULL)
+	  return false;
+
   MemoryMailboxPagesSize =
     DAC960_V2_CommandMailboxCount * sizeof(DAC960_V2_CommandMailbox_T) +
     DAC960_V2_StatusMailboxCount * sizeof(DAC960_V2_StatusMailbox_T) +
     sizeof(DAC960_V2_HealthStatusBuffer_T);
-  while (MemoryMailboxPagesSize > PAGE_SIZE << MemoryMailboxPagesOrder)
-    MemoryMailboxPagesOrder++;
-  MemoryMailboxPagesAddress =
-    __get_free_pages(GFP_KERNEL, MemoryMailboxPagesOrder);
+
+  MemoryMailboxPagesAddress = pci_alloc_consistent(PCI_Device,
+		 	 MemoryMailboxPagesSize, &MemoryMailboxPagesDMA);
+  if (MemoryMailboxPagesAddress == NULL) {
+  	pci_free_consistent(PCI_Device, sizeof(DAC960_V2_CommandMailbox_T),
+					CommandMailbox, CommandMailboxDMA);
+	  return false;
+  }
+  memset(MemoryMailboxPagesAddress, 0, MemoryMailboxPagesSize);
   Controller->MemoryMailboxPagesAddress = MemoryMailboxPagesAddress;
+  Controller->MemoryMailboxPagesDMA = MemoryMailboxPagesDMA;
+  Controller->MemoryMailboxPagesSize = MemoryMailboxPagesSize;
+
   CommandMailboxesMemory =
     (DAC960_V2_CommandMailbox_T *) MemoryMailboxPagesAddress;
-  if (CommandMailboxesMemory == NULL) return false;
-  Controller->MemoryMailboxPagesOrder = MemoryMailboxPagesOrder;
-  memset(CommandMailboxesMemory, 0, MemoryMailboxPagesSize);
+  CommandMailboxesMemoryDMA = MemoryMailboxPagesDMA;
+  
+  /* These are the base addresses for the memory mailbox array */
   Controller->V2.FirstCommandMailbox = CommandMailboxesMemory;
+  Controller->V2.FirstCommandMailboxDMA = CommandMailboxesMemoryDMA;
+
   CommandMailboxesMemory += DAC960_V2_CommandMailboxCount - 1;
   Controller->V2.LastCommandMailbox = CommandMailboxesMemory;
   Controller->V2.NextCommandMailbox = Controller->V2.FirstCommandMailbox;
   Controller->V2.PreviousCommandMailbox1 = Controller->V2.LastCommandMailbox;
   Controller->V2.PreviousCommandMailbox2 =
-    Controller->V2.LastCommandMailbox - 1;
+    					Controller->V2.LastCommandMailbox - 1;
+
   StatusMailboxesMemory =
     (DAC960_V2_StatusMailbox_T *) (CommandMailboxesMemory + 1);
+  StatusMailboxesMemoryDMA = cpu_to_dma((void *)StatusMailboxesMemory,
+		(void *)MemoryMailboxPagesAddress, MemoryMailboxPagesDMA);
+
   Controller->V2.FirstStatusMailbox = StatusMailboxesMemory;
+  Controller->V2.FirstStatusMailboxDMA = StatusMailboxesMemoryDMA;
   StatusMailboxesMemory += DAC960_V2_StatusMailboxCount - 1;
   Controller->V2.LastStatusMailbox = StatusMailboxesMemory;
   Controller->V2.NextStatusMailbox = Controller->V2.FirstStatusMailbox;
+
   Controller->V2.HealthStatusBuffer =
     (DAC960_V2_HealthStatusBuffer_T *) (StatusMailboxesMemory + 1);
+  Controller->V2.HealthStatusBufferDMA =
+	  cpu_to_dma((void *)Controller->V2.HealthStatusBuffer,
+			  (void *)MemoryMailboxPagesAddress,
+			  MemoryMailboxPagesDMA);
+
   /* Enable the Memory Mailbox Interface. */
-  memset(&CommandMailbox, 0, sizeof(DAC960_V2_CommandMailbox_T));
-  CommandMailbox.SetMemoryMailbox.CommandIdentifier = 1;
-  CommandMailbox.SetMemoryMailbox.CommandOpcode = DAC960_V2_IOCTL;
-  CommandMailbox.SetMemoryMailbox.CommandControlBits.NoAutoRequestSense = true;
-  CommandMailbox.SetMemoryMailbox.FirstCommandMailboxSizeKB =
+  memset(CommandMailbox, 0, sizeof(DAC960_V2_CommandMailbox_T));
+  CommandMailbox->SetMemoryMailbox.CommandIdentifier = 1;
+  CommandMailbox->SetMemoryMailbox.CommandOpcode = DAC960_V2_IOCTL;
+  CommandMailbox->SetMemoryMailbox.CommandControlBits.NoAutoRequestSense = true;
+  CommandMailbox->SetMemoryMailbox.FirstCommandMailboxSizeKB =
     (DAC960_V2_CommandMailboxCount * sizeof(DAC960_V2_CommandMailbox_T)) >> 10;
-  CommandMailbox.SetMemoryMailbox.FirstStatusMailboxSizeKB =
+  CommandMailbox->SetMemoryMailbox.FirstStatusMailboxSizeKB =
     (DAC960_V2_StatusMailboxCount * sizeof(DAC960_V2_StatusMailbox_T)) >> 10;
-  CommandMailbox.SetMemoryMailbox.SecondCommandMailboxSizeKB = 0;
-  CommandMailbox.SetMemoryMailbox.SecondStatusMailboxSizeKB = 0;
-  CommandMailbox.SetMemoryMailbox.RequestSenseSize = 0;
-  CommandMailbox.SetMemoryMailbox.IOCTL_Opcode = DAC960_V2_SetMemoryMailbox;
-  CommandMailbox.SetMemoryMailbox.HealthStatusBufferSizeKB = 1;
-  CommandMailbox.SetMemoryMailbox.HealthStatusBufferBusAddress =
-    Virtual_to_Bus64(Controller->V2.HealthStatusBuffer);
-  CommandMailbox.SetMemoryMailbox.FirstCommandMailboxBusAddress =
-    Virtual_to_Bus64(Controller->V2.FirstCommandMailbox);
-  CommandMailbox.SetMemoryMailbox.FirstStatusMailboxBusAddress =
-    Virtual_to_Bus64(Controller->V2.FirstStatusMailbox);
+  CommandMailbox->SetMemoryMailbox.SecondCommandMailboxSizeKB = 0;
+  CommandMailbox->SetMemoryMailbox.SecondStatusMailboxSizeKB = 0;
+  CommandMailbox->SetMemoryMailbox.RequestSenseSize = 0;
+  CommandMailbox->SetMemoryMailbox.IOCTL_Opcode = DAC960_V2_SetMemoryMailbox;
+  CommandMailbox->SetMemoryMailbox.HealthStatusBufferSizeKB = 1;
+  CommandMailbox->SetMemoryMailbox.HealthStatusBufferBusAddress =
+    					Controller->V2.HealthStatusBufferDMA;
+  CommandMailbox->SetMemoryMailbox.FirstCommandMailboxBusAddress =
+    					Controller->V2.FirstCommandMailboxDMA;
+  CommandMailbox->SetMemoryMailbox.FirstStatusMailboxBusAddress =
+    					Controller->V2.FirstStatusMailboxDMA;
   switch (Controller->HardwareType)
     {
     case DAC960_BA_Controller:
       while (DAC960_BA_HardwareMailboxFullP(ControllerBaseAddress))
 	udelay(1);
-      DAC960_BA_WriteHardwareMailbox(ControllerBaseAddress, &CommandMailbox);
+      DAC960_BA_WriteHardwareMailbox(ControllerBaseAddress, CommandMailboxDMA);
       DAC960_BA_HardwareMailboxNewCommand(ControllerBaseAddress);
       while (!DAC960_BA_HardwareMailboxStatusAvailableP(ControllerBaseAddress))
 	udelay(1);
@@ -1041,7 +1179,7 @@
     case DAC960_LP_Controller:
       while (DAC960_LP_HardwareMailboxFullP(ControllerBaseAddress))
 	udelay(1);
-      DAC960_LP_WriteHardwareMailbox(ControllerBaseAddress, &CommandMailbox);
+      DAC960_LP_WriteHardwareMailbox(ControllerBaseAddress, CommandMailboxDMA);
       DAC960_LP_HardwareMailboxNewCommand(ControllerBaseAddress);
       while (!DAC960_LP_HardwareMailboxStatusAvailableP(ControllerBaseAddress))
 	udelay(1);
@@ -1052,6 +1190,8 @@
     default:
       break;
     }
+  pci_free_consistent(PCI_Device, sizeof(DAC960_V2_CommandMailbox_T),
+					CommandMailbox, CommandMailboxDMA);
   return (CommandStatus == DAC960_V2_NormalCompletion);
 }
 
@@ -1932,7 +2072,6 @@
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
   char *names;
   RequestQueue_T *RequestQueue;
-  int MinorNumber;
   int n;
 
   names = kmalloc(9 * DAC960_MaxLogicalDrives, GFP_KERNEL);
@@ -1955,12 +2094,12 @@
     Initialize the I/O Request Queue.
   */
   RequestQueue = BLK_DEFAULT_QUEUE(MajorNumber);
-  Controller->queue_lock = SPIN_LOCK_UNLOCKED;
   blk_init_queue(RequestQueue, DAC960_RequestFunction, &Controller->queue_lock);
   RequestQueue->queuedata = Controller;
   blk_queue_max_hw_segments(RequestQueue,
 			    Controller->DriverScatterGatherLimit);
-  blk_queue_max_phys_segments(RequestQueue, ~0);
+  blk_queue_max_phys_segments(RequestQueue,
+		 	    Controller->DriverScatterGatherLimit);
   blk_queue_max_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
 
   Controller->RequestQueue = RequestQueue;
@@ -1973,6 +2112,7 @@
 	disk->major_name = names + 9 * n;
 	disk->minor_shift = DAC960_MaxPartitionsBits;
 	disk->fops = &DAC960_BlockDeviceOperations;
+	add_disk(disk);
    }
   /*
     Indicate the Block Device Registration completed successfully,
@@ -1990,10 +2130,11 @@
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
@@ -2217,6 +2358,7 @@
       Controller->ControllerNumber = DAC960_ControllerCount;
       init_waitqueue_head(&Controller->CommandWaitQueue);
       init_waitqueue_head(&Controller->HealthStatusWaitQueue);
+      Controller->queue_lock = SPIN_LOCK_UNLOCKED; 
       DAC960_Controllers[DAC960_ControllerCount++] = Controller;
       DAC960_AnnounceDriver(Controller);
       Controller->FirmwareType = FirmwareType;
@@ -2560,16 +2702,11 @@
 	  switch (Controller->HardwareType)
 	    {
 	    case DAC960_LA_Controller:
-	      if (Controller->V1.DualModeMemoryMailboxInterface)
-		free_pages(Controller->MemoryMailboxPagesAddress,
-			   Controller->MemoryMailboxPagesOrder);
-	      else DAC960_LA_SaveMemoryMailboxInfo(Controller);
-	      break;
 	    case DAC960_PG_Controller:
-	      if (Controller->V1.DualModeMemoryMailboxInterface)
-		free_pages(Controller->MemoryMailboxPagesAddress,
-			   Controller->MemoryMailboxPagesOrder);
-	      else DAC960_PG_SaveMemoryMailboxInfo(Controller);
+		pci_free_consistent(Controller->PCIDevice,
+				Controller->MemoryMailboxPagesSize,
+				Controller->MemoryMailboxPagesAddress,
+				Controller->MemoryMailboxPagesDMA);
 	      break;
 	    case DAC960_PD_Controller:
 	      release_region(Controller->IO_Address, 0x80);
@@ -2584,8 +2721,10 @@
 	  DAC960_V2_DeviceOperation(Controller, DAC960_V2_PauseDevice,
 				    DAC960_V2_RAID_Controller);
 	  DAC960_Notice("done\n", Controller);
-	  free_pages(Controller->MemoryMailboxPagesAddress,
-		     Controller->MemoryMailboxPagesOrder);
+	  pci_free_consistent(Controller->PCIDevice,
+			Controller->MemoryMailboxPagesSize,
+			Controller->MemoryMailboxPagesAddress,
+			Controller->MemoryMailboxPagesDMA);
 	}
     }
   free_irq(Controller->IRQ_Channel, Controller);
@@ -2621,8 +2760,10 @@
       if (Controller == NULL) continue;
       DAC960_InitializeController(Controller);
       for (disk = 0; disk < DAC960_MaxLogicalDrives; disk++) {
-	set_capacity(&Controller->disks[disk], disk_size(Controller, disk));
-	add_disk(&Controller->disks[disk]);
+	long size = disk_size(Controller, disk);
+	register_disk(&Controller->disks[disk],
+	    DAC960_KernelDevice(Controller->ControllerNumber, disk, 0),
+	    DAC960_MaxPartitions, &DAC960_BlockDeviceOperations, size);
       }
     }
   DAC960_CreateProcEntries();
@@ -2673,57 +2814,60 @@
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
@@ -2738,18 +2882,32 @@
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
@@ -2759,12 +2917,13 @@
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
@@ -2772,49 +2931,30 @@
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
@@ -2831,32 +2971,36 @@
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
@@ -2903,16 +3047,48 @@
   individual Buffer.
 */
 
-static inline void DAC960_ProcessCompletedBuffer(BufferHeader_T *BufferHeader,
+static inline void DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
 						 boolean SuccessfulIO)
 {
-  bio_endio(BufferHeader, BufferHeader->bi_size, SuccessfulIO ? 0 : -EIO);
-  blk_finished_io(bio_sectors(BufferHeader));
+	DAC960_CommandType_T CommandType = Command->CommandType;
+	IO_Request_T *Request = Command->Request;
+	int DmaDirection, UpToDate;
+
+	UpToDate = 0;
+	if (SuccessfulIO)
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
+	 while (end_that_request_first(Request, UpToDate, Command->BlockCount))
+		 ;
+ 	 end_that_request_last(Request);
+
+	if (Command->Completion) {
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
@@ -2970,8 +3146,8 @@
 		 Controller, Controller->ControllerNumber,
 		 Command->LogicalDriveNumber,
 		 DAC960_PartitionByCommand(Command),
-		 Command->BufferHeader->bi_sector,
-		 Command->BufferHeader->bi_sector + Command->BlockCount - 1);
+		 Command->Request->sector, 
+		 Command->Request->sector + Command->BlockCount - 1);
 }
 
 
@@ -2987,106 +3163,50 @@
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
@@ -3824,7 +3944,7 @@
       break;
     }
   DAC960_Error("Error Condition %s on %s:\n", Controller,
-	       SenseErrors[Command->V2.RequestSense.SenseKey], CommandName);
+	       SenseErrors[Command->V2.RequestSense->SenseKey], CommandName);
   DAC960_Error("  /dev/rd/c%dd%d:   absolute blocks %u..%u\n",
 	       Controller, Controller->ControllerNumber,
 	       Command->LogicalDriveNumber, Command->BlockNumber,
@@ -3834,8 +3954,8 @@
 		 Controller, Controller->ControllerNumber,
 		 Command->LogicalDriveNumber,
 		 DAC960_PartitionByCommand(Command),
-		 Command->BufferHeader->bi_sector,
-		 Command->BufferHeader->bi_sector + Command->BlockCount - 1);
+		 Command->Request->sector,
+		 Command->Request->sector + Command->BlockCount - 1);
 }
 
 
@@ -4093,116 +4213,42 @@
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
@@ -5265,8 +5311,9 @@
       Controller->LogicalDriveInitiallyAccessible[LogicalDriveNumber] = true;
       size = disk_size(Controller, LogicalDriveNumber);
       /* BROKEN, same as modular ide-floppy/ide-disk; same fix - ->probe() */
-      set_capacity(&Controller->disks[LogicalDriveNumber], size);
-      add_disk(&Controller->disks[LogicalDriveNumber]);
+      register_disk(&Controller->disks[LogicalDriveNumber],
+	    DAC960_KernelDevice(Controller->ControllerNumber, LogicalDriveNumber, 0),
+	    DAC960_MaxPartitions, &DAC960_BlockDeviceOperations, size);
     }
   if (!get_capacity(&Controller->disks[LogicalDriveNumber]))
     return -ENXIO;
@@ -5313,7 +5360,6 @@
   int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
   DiskGeometry_T Geometry, *UserGeometry;
   DAC960_Controller_T *Controller;
-  int res;
 
   if (File != NULL && (File->f_flags & O_NONBLOCK))
     return DAC960_UserIOCTL(Inode, File, Request, Argument);
@@ -5491,11 +5537,11 @@
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
@@ -5530,9 +5576,10 @@
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
diff -ur linux-2.5.38_original/drivers/block/DAC960.h linux-2.5.38_patch/drivers/block/DAC960.h
--- linux-2.5.38_original/drivers/block/DAC960.h	Mon Sep 23 11:12:27 2002
+++ linux-2.5.38_patch/drivers/block/DAC960.h	Mon Sep 23 10:59:17 2002
@@ -111,6 +111,54 @@
 
 
 /*
+ * Convert an item's CPU address to its dma address, based
+ * on that item's offset within a region of dma-mapped memory.
+ */
+static inline dma_addr_t cpu_to_dma(void *cpu_item, void *cpu_base,
+							dma_addr_t dma_base)
+{
+	return dma_base + (cpu_item - cpu_base);
+}
+
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
+
+/*
   Define the SCSI INQUIRY Standard Data structure.
 */
 
@@ -2191,7 +2239,6 @@
   of the Linux Kernel and I/O Subsystem.
 */
 
-typedef struct bio BufferHeader_T;
 typedef struct file File_T;
 typedef struct block_device_operations BlockDeviceOperations_T;
 typedef struct completion Completion_T;
@@ -2278,16 +2325,16 @@
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
@@ -2296,11 +2343,11 @@
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
@@ -2320,6 +2367,7 @@
   DAC960_HardwareType_T HardwareType;
   DAC960_IO_Address_T IO_Address;
   DAC960_PCI_Address_T PCI_Address;
+  PCI_Device_T  *PCIDevice;
   unsigned char ControllerNumber;
   unsigned char ControllerName[4];
   unsigned char ModelName[20];
@@ -2345,8 +2393,9 @@
   unsigned int CurrentStatusLength;
   unsigned int ProgressBufferLength;
   unsigned int UserStatusLength;
-  unsigned long MemoryMailboxPagesAddress;
-  unsigned long MemoryMailboxPagesOrder;
+  void *MemoryMailboxPagesAddress;
+  dma_addr_t MemoryMailboxPagesDMA;
+  unsigned long MemoryMailboxPagesSize;
   unsigned long MonitoringTimerCount;
   unsigned long PrimaryMonitoringTime;
   unsigned long SecondaryMonitoringTime;
@@ -2361,6 +2410,7 @@
   boolean SuppressEnclosureMessages;
   Timer_T MonitoringTimer;
   struct gendisk disks[DAC960_MaxLogicalDrives];
+  struct pci_pool *ScatterGatherPool;
   DAC960_Command_T *FreeCommands;
   unsigned char *CombinedStatusBuffer;
   unsigned char *CurrentStatusBuffer;
@@ -2404,11 +2454,13 @@
       boolean RebuildProgressFirst;
       boolean RebuildFlagPending;
       boolean RebuildStatusPending;
+      dma_addr_t	FirstCommandMailboxDMA;
       DAC960_V1_CommandMailbox_T *FirstCommandMailbox;
       DAC960_V1_CommandMailbox_T *LastCommandMailbox;
       DAC960_V1_CommandMailbox_T *NextCommandMailbox;
       DAC960_V1_CommandMailbox_T *PreviousCommandMailbox1;
       DAC960_V1_CommandMailbox_T *PreviousCommandMailbox2;
+      dma_addr_t	FirstStatusMailboxDMA;
       DAC960_V1_StatusMailbox_T *FirstStatusMailbox;
       DAC960_V1_StatusMailbox_T *LastStatusMailbox;
       DAC960_V1_StatusMailbox_T *NextStatusMailbox;
@@ -2446,14 +2498,18 @@
       boolean NeedDeviceSerialNumberInformation;
       boolean StartLogicalDeviceInformationScan;
       boolean StartPhysicalDeviceInformationScan;
+      struct pci_pool *RequestSensePool;
+      dma_addr_t	FirstCommandMailboxDMA;
       DAC960_V2_CommandMailbox_T *FirstCommandMailbox;
       DAC960_V2_CommandMailbox_T *LastCommandMailbox;
       DAC960_V2_CommandMailbox_T *NextCommandMailbox;
       DAC960_V2_CommandMailbox_T *PreviousCommandMailbox1;
       DAC960_V2_CommandMailbox_T *PreviousCommandMailbox2;
+      dma_addr_t	FirstStatusMailboxDMA;
       DAC960_V2_StatusMailbox_T *FirstStatusMailbox;
       DAC960_V2_StatusMailbox_T *LastStatusMailbox;
       DAC960_V2_StatusMailbox_T *NextStatusMailbox;
+      dma_addr_t	HealthStatusBufferDMA;
       DAC960_V2_HealthStatusBuffer_T *HealthStatusBuffer;
       DAC960_V2_ControllerInfo_T ControllerInformation;
       DAC960_V2_ControllerInfo_T NewControllerInformation;
@@ -2498,13 +2554,18 @@
 
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
 
 
@@ -2516,7 +2577,7 @@
 void DAC960_ReleaseControllerLock(DAC960_Controller_T *Controller,
 				  ProcessorFlags_T *ProcessorFlags)
 {
-  spin_unlock_irqrestore(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, *ProcessorFlags);
 }
 
 
@@ -2553,7 +2614,7 @@
 void DAC960_AcquireControllerLockIH(DAC960_Controller_T *Controller,
 				    ProcessorFlags_T *ProcessorFlags)
 {
-  spin_lock_irqsave(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_lock_irqsave(&Controller->queue_lock, *ProcessorFlags);
 }
 
 
@@ -2566,10 +2627,9 @@
 void DAC960_ReleaseControllerLockIH(DAC960_Controller_T *Controller,
 				    ProcessorFlags_T *ProcessorFlags)
 {
-  spin_unlock_irqrestore(Controller->RequestQueue->queue_lock, *ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, *ProcessorFlags);
 }
 
-#error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
 
 /*
   Define the DAC960 BA Series Controller Interface Register Offsets.
@@ -2836,13 +2896,13 @@
 
 static inline
 void DAC960_BA_WriteHardwareMailbox(void *ControllerBaseAddress,
-				    DAC960_V2_CommandMailbox_T *CommandMailbox)
+				    dma_addr_t CommandMailboxDMA)
 {
 #ifdef __ia64__
-  writeq(Virtual_to_Bus64(CommandMailbox),
+  writeq(CommandMailboxDMA,
 	 ControllerBaseAddress + DAC960_BA_CommandMailboxBusAddressOffset);
 #else
-  writel(Virtual_to_Bus32(CommandMailbox),
+  writel(CommandMailboxDMA,
 	 ControllerBaseAddress + DAC960_BA_CommandMailboxBusAddressOffset);
 #endif
 }
@@ -3142,13 +3202,13 @@
 
 static inline
 void DAC960_LP_WriteHardwareMailbox(void *ControllerBaseAddress,
-				    DAC960_V2_CommandMailbox_T *CommandMailbox)
+				    dma_addr_t CommandMailboxDMA)
 {
 #ifdef __ia64__
-  writeq(Virtual_to_Bus64(CommandMailbox),
+  writeq(CommandMailboxDMA,
 	 ControllerBaseAddress + DAC960_LP_CommandMailboxBusAddressOffset);
 #else
-  writel(Virtual_to_Bus32(CommandMailbox),
+  writel(CommandMailboxDMA,
 	 ControllerBaseAddress + DAC960_LP_CommandMailboxBusAddressOffset);
 #endif
 }
@@ -4208,7 +4268,7 @@
 static void DAC960_FinalizeController(DAC960_Controller_T *);
 static int DAC960_Notifier(NotifierBlock_T *, unsigned long, void *);
 static void DAC960_V1_QueueReadWriteCommand(DAC960_Command_T *);
-static void DAC960_V2_QueueReadWriteCommand(DAC960_Command_T *);
+static void DAC960_V2_QueueReadWriteCommand(DAC960_Command_T *); 
 static void DAC960_RequestFunction(RequestQueue_T *);
 static void DAC960_BA_InterruptHandler(int, void *, Registers_T *);
 static void DAC960_LP_InterruptHandler(int, void *, Registers_T *);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTEMXem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTEMXem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:34:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4820 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261849AbTEMXeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:34:02 -0400
Date: Tue, 13 May 2003 16:47:04 -0700
From: Dave Olien <dmo@osdl.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, hch@lst.de
Subject: DAC960 typedef cleanup patch
Message-ID: <20030513234704.GA2656@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

I'm forwarding this patch to the DAC9690 driver from Christoph.
I've applied it to the 2.5.69 DAC960 driver, compiled it, and
ran it through some tests on both V1 and V2 type controllers.
It looks good. Can you pass this on to Linus?

Thanks!

On Thu, May 08, 2003 at 02:33:54PM +0200, Christoph Hellwig wrote:
> and kill some obsfucation locking inlines in favour of direct
> spin_{,un}lock* calls.  Maybe we'll get DAC960 to lock like
> a normal kernel driver at some point :)

--- 1.57/drivers/block/DAC960.c	Mon Apr 28 11:02:45 2003
+++ edited/drivers/block/DAC960.c	Mon May  5 08:11:06 2003
@@ -48,8 +48,7 @@
 
 static DAC960_Controller_T *DAC960_Controllers[DAC960_MaxControllers];
 static int DAC960_ControllerCount;
-static PROC_DirectoryEntry_T *DAC960_ProcDirectoryEntry;
-
+static struct proc_dir_entry *DAC960_ProcDirectoryEntry;
 
 static long disk_size(DAC960_Controller_T *p, int drive_nr)
 {
@@ -759,12 +758,15 @@
 {
   DAC960_Controller_T *Controller = Command->Controller;
   DECLARE_COMPLETION(Completion);
-  unsigned long ProcessorFlags;
+  unsigned long flags;
   Command->Completion = &Completion;
-  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_QueueCommand(Command);
-  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
-  if (in_interrupt()) return;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
+ 
+  if (in_interrupt())
+	  return;
   wait_for_completion(&Completion);
 }
 
@@ -1132,7 +1134,7 @@
 {
   void *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_HardwareType_T hw_type = Controller->HardwareType;
-  PCI_Device_T	*PCI_Device = Controller->PCIDevice;
+  struct pci_dev *PCI_Device = Controller->PCIDevice;
   struct dma_loaf *DmaPages = &Controller->DmaPages;
   size_t DmaPagesSize;
   size_t CommandMailboxesSize;
@@ -1337,7 +1339,7 @@
 						      *Controller)
 {
   void *ControllerBaseAddress = Controller->BaseAddress;
-  PCI_Device_T	*PCI_Device = Controller->PCIDevice;
+  struct pci_dev *PCI_Device = Controller->PCIDevice;
   struct dma_loaf *DmaPages = &Controller->DmaPages;
   size_t DmaPagesSize;
   size_t CommandMailboxesSize;
@@ -1915,8 +1917,8 @@
   dma_addr_t SCSI_NewInquiryUnitSerialNumberDMA[DAC960_V1_MaxChannels];
   DAC960_SCSI_Inquiry_UnitSerialNumber_T *SCSI_NewInquiryUnitSerialNumberCPU[DAC960_V1_MaxChannels];
 
-  Completion_T Completions[DAC960_V1_MaxChannels];
-  unsigned long ProcessorFlags;
+  struct completion Completions[DAC960_V1_MaxChannels];
+  unsigned long flags;
   int Channel, TargetID;
 
   if (!init_dma_loaf(Controller->PCIDevice, &local_dma, 
@@ -1951,7 +1953,7 @@
   	  DAC960_V1_DCDB_T *DCDB = DCDBs_cpu[Channel];
   	  dma_addr_t DCDB_dma = DCDBs_dma[Channel];
 	  DAC960_Command_T *Command = Controller->Commands[Channel];
-          Completion_T *Completion = &Completions[Channel];
+          struct completion *Completion = &Completions[Channel];
 
 	  init_completion(Completion);
 	  DAC960_V1_ClearCommand(Command);
@@ -1977,9 +1979,10 @@
 	  DCDB->CDB[3] = 0; /* Reserved */
 	  DCDB->CDB[4] = sizeof(DAC960_SCSI_Inquiry_T);
 	  DCDB->CDB[5] = 0; /* Control */
-	  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+	  spin_lock_irqsave(&Controller->queue_lock, flags);
 	  DAC960_QueueCommand(Command);
-	  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	  spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	}
       /*
        * Wait for the problems submitted in the previous loop
@@ -1999,7 +2002,7 @@
 	    &Controller->V1.InquiryUnitSerialNumber[Channel][TargetID];
 	  DAC960_Command_T *Command = Controller->Commands[Channel];
   	  DAC960_V1_DCDB_T *DCDB = DCDBs_cpu[Channel];
-          Completion_T *Completion = &Completions[Channel];
+          struct completion *Completion = &Completions[Channel];
 
 	  wait_for_completion(Completion);
 
@@ -2021,9 +2024,10 @@
 	  DCDB->CDB[3] = 0; /* Reserved */
 	  DCDB->CDB[4] = sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T);
 	  DCDB->CDB[5] = 0; /* Control */
-	  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+	  spin_lock_irqsave(&Controller->queue_lock, flags);
 	  DAC960_QueueCommand(Command);
-	  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	  spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	  wait_for_completion(Completion);
 
 	  if (Command->V1.CommandStatus != DAC960_V1_NormalCompletion) {
@@ -2457,7 +2461,7 @@
 static boolean DAC960_RegisterBlockDevice(DAC960_Controller_T *Controller)
 {
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
-  RequestQueue_T *RequestQueue;
+  struct request_queue *RequestQueue;
   int n;
 
   /*
@@ -2642,11 +2646,13 @@
 */
 
 static DAC960_Controller_T * 
-DAC960_DetectController(PCI_Device_T *PCI_Device,
-					const struct pci_device_id *entry)
+DAC960_DetectController(struct pci_dev *PCI_Device,
+			const struct pci_device_id *entry)
 {
-  struct DAC960_privdata *privdata = (struct DAC960_privdata *)entry->driver_data;
-  irqreturn_t (*InterruptHandler)(int, void *, Registers_T *) = privdata->InterruptHandler;
+  struct DAC960_privdata *privdata =
+	  	(struct DAC960_privdata *)entry->driver_data;
+  irqreturn_t (*InterruptHandler)(int, void *, struct pt_regs *) =
+	  	privdata->InterruptHandler;
   unsigned int MemoryWindowSize = privdata->MemoryWindowSize;
   DAC960_Controller_T *Controller = NULL;
   unsigned char DeviceFunction = PCI_Device->devfn;
@@ -3001,7 +3007,7 @@
 {
   if (Controller->ControllerInitialized)
     {
-      unsigned long ProcessorFlags;
+      unsigned long flags;
 
       /*
        * Acquiring and releasing lock here eliminates
@@ -3019,9 +3025,11 @@
        * commands that complete from this time on will NOT return
        * their command structure to the free list.
        */
-      DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+      spin_lock_irqsave(&Controller->queue_lock, flags);
       Controller->ShutdownMonitoringTimer = 1;
-      DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+      spin_unlock_irqrestore(&Controller->queue_lock, flags);
+
       del_timer_sync(&Controller->MonitoringTimer);
       if (Controller->FirmwareType == DAC960_V1_Controller)
 	{
@@ -3088,7 +3096,7 @@
   DAC960_Finalize finalizes the DAC960 Driver.
 */
 
-static void DAC960_Remove(PCI_Device_T *PCI_Device)
+static void DAC960_Remove(struct pci_dev *PCI_Device)
 {
   int Controller_Number = (int)pci_get_drvdata(PCI_Device);
   DAC960_Controller_T *Controller = DAC960_Controllers[Controller_Number];
@@ -3236,8 +3244,8 @@
 static boolean DAC960_ProcessRequest(DAC960_Controller_T *Controller,
 				     boolean WaitForCommand)
 {
-  RequestQueue_T *RequestQueue = &Controller->RequestQueue;
-  IO_Request_T *Request;
+  struct request_queue *RequestQueue = &Controller->RequestQueue;
+  struct request *Request;
   DAC960_Command_T *Command;
 
   if (!Controller->ControllerInitialized)
@@ -3293,7 +3301,7 @@
 static void DAC960_queue_partial_rw(DAC960_Command_T *Command)
 {
   DAC960_Controller_T *Controller = Command->Controller;
-  IO_Request_T *Request = Command->Request;
+  struct request *Request = Command->Request;
 
   if (Command->DmaDirection == PCI_DMA_FROMDEVICE)
     Command->CommandType = DAC960_ReadRetryCommand;
@@ -3324,43 +3332,17 @@
   return;
 }
 
-
-/*
-  DAC960_ProcessRequests attempts to remove as many I/O Requests as possible
-  from Controller's I/O Request Queue and queue them to the Controller.
-*/
-
-static inline void DAC960_ProcessRequests(DAC960_Controller_T *Controller)
-{
-  int Counter = 0;
-  while (DAC960_ProcessRequest(Controller, Counter++ == 0)) ;
-}
-
-
 /*
   DAC960_RequestFunction is the I/O Request Function for DAC960 Controllers.
 */
 
-static void DAC960_RequestFunction(RequestQueue_T *RequestQueue)
+static void DAC960_RequestFunction(struct request_queue *RequestQueue)
 {
-  DAC960_Controller_T *Controller =
-    (DAC960_Controller_T *) RequestQueue->queuedata;
-  ProcessorFlags_T ProcessorFlags;
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockRF(Controller, &ProcessorFlags);
-  /*
-    Process I/O Requests for Controller.
-  */
-  DAC960_ProcessRequests(Controller);
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockRF(Controller, &ProcessorFlags);
+	int i = 0;
+	while (DAC960_ProcessRequest(RequestQueue->queuedata, (i++ == 0)))
+		;
 }
 
-
 /*
   DAC960_ProcessCompletedBuffer performs completion processing for an
   individual Buffer.
@@ -3369,7 +3351,7 @@
 static inline boolean DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
 						 boolean SuccessfulIO)
 {
-	IO_Request_T *Request = Command->Request;
+	struct request *Request = Command->Request;
 	int UpToDate;
 
 	UpToDate = 0;
@@ -5174,20 +5156,14 @@
 
 static irqreturn_t DAC960_BA_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier,
-				       Registers_T *InterruptRegisters)
+				       struct pt_regs *InterruptRegisters)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
   void *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V2_StatusMailbox_T *NextStatusMailbox;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long flags;
 
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockIH(Controller, &ProcessorFlags);
-  /*
-    Process Hardware Interrupts for Controller.
-  */
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_BA_AcknowledgeInterrupt(ControllerBaseAddress);
   NextStatusMailbox = Controller->V2.NextStatusMailbox;
   while (NextStatusMailbox->Fields.CommandIdentifier > 0)
@@ -5210,11 +5186,9 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false)) ;
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockIH(Controller, &ProcessorFlags);
+  while (DAC960_ProcessRequest(Controller, false))
+	  ;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
 
@@ -5226,19 +5200,14 @@
 
 static irqreturn_t DAC960_LP_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier,
-				       Registers_T *InterruptRegisters)
+				       struct pt_regs *InterruptRegisters)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
   void *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V2_StatusMailbox_T *NextStatusMailbox;
-  ProcessorFlags_T ProcessorFlags;
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockIH(Controller, &ProcessorFlags);
-  /*
-    Process Hardware Interrupts for Controller.
-  */
+  unsigned long flags;
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_LP_AcknowledgeInterrupt(ControllerBaseAddress);
   NextStatusMailbox = Controller->V2.NextStatusMailbox;
   while (NextStatusMailbox->Fields.CommandIdentifier > 0)
@@ -5261,11 +5230,9 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false)) ;
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockIH(Controller, &ProcessorFlags);
+  while (DAC960_ProcessRequest(Controller, false))
+	  ;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
 
@@ -5277,19 +5244,14 @@
 
 static irqreturn_t DAC960_LA_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier,
-				       Registers_T *InterruptRegisters)
+				       struct pt_regs *InterruptRegisters)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
   void *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V1_StatusMailbox_T *NextStatusMailbox;
-  ProcessorFlags_T ProcessorFlags;
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockIH(Controller, &ProcessorFlags);
-  /*
-    Process Hardware Interrupts for Controller.
-  */
+  unsigned long flags;
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_LA_AcknowledgeInterrupt(ControllerBaseAddress);
   NextStatusMailbox = Controller->V1.NextStatusMailbox;
   while (NextStatusMailbox->Fields.Valid)
@@ -5308,11 +5270,9 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false)) ;
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockIH(Controller, &ProcessorFlags);
+  while (DAC960_ProcessRequest(Controller, false))
+	  ;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
 
@@ -5324,19 +5284,14 @@
 
 static irqreturn_t DAC960_PG_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier,
-				       Registers_T *InterruptRegisters)
+				       struct pt_regs *InterruptRegisters)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
   void *ControllerBaseAddress = Controller->BaseAddress;
   DAC960_V1_StatusMailbox_T *NextStatusMailbox;
-  ProcessorFlags_T ProcessorFlags;
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockIH(Controller, &ProcessorFlags);
-  /*
-    Process Hardware Interrupts for Controller.
-  */
+  unsigned long flags;
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_PG_AcknowledgeInterrupt(ControllerBaseAddress);
   NextStatusMailbox = Controller->V1.NextStatusMailbox;
   while (NextStatusMailbox->Fields.Valid)
@@ -5355,11 +5310,9 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false)) ;
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockIH(Controller, &ProcessorFlags);
+  while (DAC960_ProcessRequest(Controller, false))
+	  ;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
 
@@ -5371,18 +5324,13 @@
 
 static irqreturn_t DAC960_PD_InterruptHandler(int IRQ_Channel,
 				       void *DeviceIdentifier,
-				       Registers_T *InterruptRegisters)
+				       struct pt_regs *InterruptRegisters)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
   void *ControllerBaseAddress = Controller->BaseAddress;
-  ProcessorFlags_T ProcessorFlags;
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockIH(Controller, &ProcessorFlags);
-  /*
-    Process Hardware Interrupts for Controller.
-  */
+  unsigned long flags;
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   while (DAC960_PD_StatusAvailableP(ControllerBaseAddress))
     {
       DAC960_V1_CommandIdentifier_T CommandIdentifier =
@@ -5398,11 +5346,9 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false)) ;
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockIH(Controller, &ProcessorFlags);
+  while (DAC960_ProcessRequest(Controller, false))
+	  ;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
 
@@ -5418,18 +5364,13 @@
 
 static irqreturn_t DAC960_P_InterruptHandler(int IRQ_Channel,
 				      void *DeviceIdentifier,
-				      Registers_T *InterruptRegisters)
+				      struct pt_regs *InterruptRegisters)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
   void *ControllerBaseAddress = Controller->BaseAddress;
-  ProcessorFlags_T ProcessorFlags;
-  /*
-    Acquire exclusive access to Controller.
-  */
-  DAC960_AcquireControllerLockIH(Controller, &ProcessorFlags);
-  /*
-    Process Hardware Interrupts for Controller.
-  */
+  unsigned long flags;
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   while (DAC960_PD_StatusAvailableP(ControllerBaseAddress))
     {
       DAC960_V1_CommandIdentifier_T CommandIdentifier =
@@ -5480,11 +5421,9 @@
     Attempt to remove additional I/O Requests from the Controller's
     I/O Request Queue and queue them to the Controller.
   */
-  while (DAC960_ProcessRequest(Controller, false)) ;
-  /*
-    Release exclusive access to Controller.
-  */
-  DAC960_ReleaseControllerLockIH(Controller, &ProcessorFlags);
+  while (DAC960_ProcessRequest(Controller, false))
+	  ;
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return IRQ_HANDLED;
 }
 
@@ -5547,13 +5486,11 @@
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) TimerData;
   DAC960_Command_T *Command;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long flags;
+
   if (Controller->FirmwareType == DAC960_V1_Controller)
     {
-      /*
-	Acquire exclusive access to Controller.
-      */
-      DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+      spin_lock_irqsave(&Controller->queue_lock, flags);
       /*
 	Queue a Status Monitoring Command to Controller.
       */
@@ -5561,10 +5498,7 @@
       if (Command != NULL)
 	DAC960_V1_QueueMonitoringCommand(Command);
       else Controller->MonitoringCommandDeferred = true;
-      /*
-	Release exclusive access to Controller.
-      */
-      DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+      spin_unlock_irqrestore(&Controller->queue_lock, flags);
     }
   else
     {
@@ -5613,10 +5547,8 @@
 	}
       Controller->V2.StatusChangeCounter = StatusChangeCounter;
       Controller->PrimaryMonitoringTime = jiffies;
-      /*
-	Acquire exclusive access to Controller.
-      */
-      DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+      spin_lock_irqsave(&Controller->queue_lock, flags);
       /*
 	Queue a Status Monitoring Command to Controller.
       */
@@ -5624,10 +5556,7 @@
       if (Command != NULL)
 	DAC960_V2_QueueMonitoringCommand(Command);
       else Controller->MonitoringCommandDeferred = true;
-      /*
-	Release exclusive access to Controller.
-      */
-      DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+      spin_unlock_irqrestore(&Controller->queue_lock, flags);
       /*
 	Wake up any processes waiting on a Health Status Buffer change.
       */
@@ -5639,7 +5568,7 @@
   DAC960_UserIOCTL is the User IOCTL Function for the DAC960 Driver.
 */
 
-static int DAC960_UserIOCTL(Inode_T *Inode, File_T *File,
+static int DAC960_UserIOCTL(struct inode *inode, struct file *file,
 			    unsigned int Request, unsigned long Argument)
 {
   int ErrorCode = 0;
@@ -5691,7 +5620,7 @@
 	DAC960_V1_DCDB_T DCDB;
 	DAC960_V1_DCDB_T *DCDB_IOBUF = NULL;
 	dma_addr_t	DCDB_IOBUFDMA;
-	ProcessorFlags_T ProcessorFlags;
+	unsigned long flags;
 	int ControllerNumber, DataTransferLength;
 	unsigned char *DataTransferBuffer = NULL;
 	dma_addr_t DataTransferBufferDMA;
@@ -5764,7 +5693,7 @@
 	  }
 	if (CommandOpcode == DAC960_V1_DCDB)
 	  {
-	    DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+	    spin_lock_irqsave(&Controller->queue_lock, flags);
 	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
 	      DAC960_WaitForCommand(Controller);
 	    while (Controller->V1.DirectCommandActive[DCDB.Channel]
@@ -5778,7 +5707,7 @@
 	      }
 	    Controller->V1.DirectCommandActive[DCDB.Channel]
 					      [DCDB.TargetID] = true;
-	    DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	    spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	    DAC960_V1_ClearCommand(Command);
 	    Command->CommandType = DAC960_ImmediateCommand;
 	    memcpy(&Command->V1.CommandMailbox, &UserCommand.CommandMailbox,
@@ -5789,10 +5718,10 @@
 	  }
 	else
 	  {
-	    DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+	    spin_lock_irqsave(&Controller->queue_lock, flags);
 	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
 	      DAC960_WaitForCommand(Controller);
-	    DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	    spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	    DAC960_V1_ClearCommand(Command);
 	    Command->CommandType = DAC960_ImmediateCommand;
 	    memcpy(&Command->V1.CommandMailbox, &UserCommand.CommandMailbox,
@@ -5803,9 +5732,9 @@
 	  }
 	DAC960_ExecuteCommand(Command);
 	CommandStatus = Command->V1.CommandStatus;
-	DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+	spin_lock_irqsave(&Controller->queue_lock, flags);
 	DAC960_DeallocateCommand(Command);
-	DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	if (DataTransferLength > 0)
 	  {
 	    if (copy_to_user(UserCommand.DataTransferBuffer,
@@ -5848,7 +5777,7 @@
 	DAC960_Command_T *Command = NULL;
 	DAC960_V2_CommandMailbox_T *CommandMailbox;
 	DAC960_V2_CommandStatus_T CommandStatus;
-	ProcessorFlags_T ProcessorFlags;
+	unsigned long flags;
 	int ControllerNumber, DataTransferLength;
 	int DataTransferResidue, RequestSenseLength;
 	unsigned char *DataTransferBuffer = NULL;
@@ -5900,10 +5829,10 @@
 	      }
 	    memset(RequestSenseBuffer, 0, RequestSenseLength);
 	  }
-	DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+	spin_lock_irqsave(&Controller->queue_lock, flags);
 	while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
 	  DAC960_WaitForCommand(Controller);
-	DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	DAC960_V2_ClearCommand(Command);
 	Command->CommandType = DAC960_ImmediateCommand;
 	CommandMailbox = &Command->V2.CommandMailbox;
@@ -5951,9 +5880,9 @@
 	CommandStatus = Command->V2.CommandStatus;
 	RequestSenseLength = Command->V2.RequestSenseLength;
 	DataTransferResidue = Command->V2.DataTransferResidue;
-	DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+	spin_lock_irqsave(&Controller->queue_lock, flags);
 	DAC960_DeallocateCommand(Command);
-	DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+	spin_unlock_irqrestore(&Controller->queue_lock, flags);
 	if (RequestSenseLength > UserCommand.RequestSenseLength)
 	  RequestSenseLength = UserCommand.RequestSenseLength;
 	if (copy_to_user(&UserSpaceUserCommand->DataTransferLength,
@@ -6302,12 +6231,13 @@
 {
   DAC960_Command_T *Command;
   DAC960_V1_CommandMailbox_T *CommandMailbox;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long flags;
   unsigned char Channel, TargetID, LogicalDriveNumber;
-  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
     DAC960_WaitForCommand(Controller);
-  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   Controller->UserStatusLength = 0;
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
@@ -6497,9 +6427,10 @@
     }
   else DAC960_UserCritical("Illegal User Command: '%s'\n",
 			   Controller, UserCommand);
-  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_DeallocateCommand(Command);
-  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return true;
 }
 
@@ -6562,13 +6493,14 @@
 {
   DAC960_Command_T *Command;
   DAC960_V2_CommandMailbox_T *CommandMailbox;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long flags;
   unsigned char Channel, TargetID, LogicalDriveNumber;
   unsigned short LogicalDeviceNumber;
-  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
     DAC960_WaitForCommand(Controller);
-  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   Controller->UserStatusLength = 0;
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
@@ -6758,9 +6690,10 @@
     Controller->SuppressEnclosureMessages = true;
   else DAC960_UserCritical("Illegal User Command: '%s'\n",
 			   Controller, UserCommand);
-  DAC960_AcquireControllerLock(Controller, &ProcessorFlags);
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
   DAC960_DeallocateCommand(Command);
-  DAC960_ReleaseControllerLock(Controller, &ProcessorFlags);
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
   return true;
 }
 
@@ -6893,7 +6826,7 @@
   DAC960_ProcWriteUserCommand implements writing /proc/rd/cN/user_command.
 */
 
-static int DAC960_ProcWriteUserCommand(File_T *File, const char *Buffer,
+static int DAC960_ProcWriteUserCommand(struct file *file, const char *Buffer,
 				       unsigned long Count, void *Data)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
@@ -6921,9 +6854,9 @@
 
 static void DAC960_CreateProcEntries(DAC960_Controller_T *Controller)
 {
-	PROC_DirectoryEntry_T *StatusProcEntry;
-	PROC_DirectoryEntry_T *ControllerProcEntry;
-	PROC_DirectoryEntry_T *UserCommandProcEntry;
+	struct proc_dir_entry *StatusProcEntry;
+	struct proc_dir_entry *ControllerProcEntry;
+	struct proc_dir_entry *UserCommandProcEntry;
 
 	if (DAC960_ProcDirectoryEntry == NULL) {
   		DAC960_ProcDirectoryEntry = proc_mkdir("rd", NULL);
--- 1.20/drivers/block/DAC960.h	Mon Apr 28 11:02:45 2003
+++ edited/drivers/block/DAC960.h	Mon May  5 08:11:06 2003
@@ -2203,33 +2203,10 @@
   DAC960_Message(DAC960_UserCriticalLevel, Format, ##Arguments)
 
 
-/*
-  Define types for some of the structures that interface with the rest
-  of the Linux Kernel and I/O Subsystem.
-*/
-
-typedef struct file File_T;
-typedef struct block_device_operations BlockDeviceOperations_T;
-typedef struct completion Completion_T;
-typedef struct hd_geometry DiskGeometry_T;
-typedef struct inode Inode_T;
-typedef struct inode_operations InodeOperations_T;
-typedef kdev_t KernelDevice_T;
-typedef struct list_head ListHead_T;
-typedef struct pci_dev PCI_Device_T;
-typedef struct proc_dir_entry PROC_DirectoryEntry_T;
-typedef unsigned long ProcessorFlags_T;
-typedef struct pt_regs Registers_T;
-typedef struct request IO_Request_T;
-typedef request_queue_t RequestQueue_T;
-typedef struct super_block SuperBlock_T;
-typedef struct timer_list Timer_T;
-typedef wait_queue_head_t WaitQueue_T;
-
 struct DAC960_privdata {
 	DAC960_HardwareType_T	HardwareType;
 	DAC960_FirmwareType_T	FirmwareType;
-	irqreturn_t (*InterruptHandler)(int, void *, Registers_T *);
+	irqreturn_t (*InterruptHandler)(int, void *, struct pt_regs *);
 	unsigned int		MemoryWindowSize;
 };
 
@@ -2295,14 +2272,14 @@
   DAC960_CommandType_T CommandType;
   struct DAC960_Controller *Controller;
   struct DAC960_Command *Next;
-  Completion_T *Completion;
+  struct completion *Completion;
   unsigned int LogicalDriveNumber;
   unsigned int BlockNumber;
   unsigned int BlockCount;
   unsigned int SegmentCount;
   int	DmaDirection;
   struct scatterlist *cmd_sglist;
-  IO_Request_T *Request;
+  struct request *Request;
   struct pci_dev *PciDevice;
   union {
     struct {
@@ -2344,7 +2321,7 @@
   DAC960_HardwareType_T HardwareType;
   DAC960_IO_Address_T IO_Address;
   DAC960_PCI_Address_T PCI_Address;
-  PCI_Device_T  *PCIDevice;
+  struct pci_dev *PCIDevice;
   unsigned char ControllerNumber;
   unsigned char ControllerName[4];
   unsigned char ModelName[20];
@@ -2383,19 +2360,19 @@
   boolean DriveSpinUpMessageDisplayed;
   boolean MonitoringAlertMode;
   boolean SuppressEnclosureMessages;
-  Timer_T MonitoringTimer;
+  struct timer_list MonitoringTimer;
   struct gendisk *disks[DAC960_MaxLogicalDrives];
   struct pci_pool *ScatterGatherPool;
   DAC960_Command_T *FreeCommands;
   unsigned char *CombinedStatusBuffer;
   unsigned char *CurrentStatusBuffer;
-  RequestQueue_T RequestQueue;
+  struct request_queue RequestQueue;
   spinlock_t queue_lock;
-  WaitQueue_T CommandWaitQueue;
-  WaitQueue_T HealthStatusWaitQueue;
+  wait_queue_head_t CommandWaitQueue;
+  wait_queue_head_t HealthStatusWaitQueue;
   DAC960_Command_T InitialCommand;
   DAC960_Command_T *Commands[DAC960_MaxDriverQueueDepth];
-  PROC_DirectoryEntry_T *ControllerProcEntry;
+  struct proc_dir_entry *ControllerProcEntry;
   boolean LogicalDriveInitiallyAccessible[DAC960_MaxLogicalDrives];
   void (*QueueCommand)(DAC960_Command_T *Command);
   boolean (*ReadControllerConfiguration)(struct DAC960_Controller *);
@@ -2596,85 +2573,6 @@
 }
 
 /*
-  DAC960_AcquireControllerLock acquires exclusive access to Controller.
-	Reference the queue_lock through the controller structure,
-	rather than through the request queue.  These macros are
-        used to mutex on the controller structure during initialization,
-	BEFORE the request queue is allocated and initialized in
-	DAC960_RegisterBlockDevice().
-*/
-
-static inline
-void DAC960_AcquireControllerLock(DAC960_Controller_T *Controller,
-				  ProcessorFlags_T *ProcessorFlags)
-{
-  spin_lock_irqsave(&Controller->queue_lock, *ProcessorFlags);
-}
-
-
-/*
-  DAC960_ReleaseControllerLock releases exclusive access to Controller.
-*/
-
-static inline
-void DAC960_ReleaseControllerLock(DAC960_Controller_T *Controller,
-				  ProcessorFlags_T *ProcessorFlags)
-{
-  spin_unlock_irqrestore(&Controller->queue_lock, *ProcessorFlags);
-}
-
-
-/*
-  DAC960_AcquireControllerLockRF acquires exclusive access to Controller,
-  but is only called from the request function with the queue lock held.
-*/
-
-static inline
-void DAC960_AcquireControllerLockRF(DAC960_Controller_T *Controller,
-				    ProcessorFlags_T *ProcessorFlags)
-{
-}
-
-
-/*
-  DAC960_ReleaseControllerLockRF releases exclusive access to Controller,
-  but is only called from the request function with the queue lock held.
-*/
-
-static inline
-void DAC960_ReleaseControllerLockRF(DAC960_Controller_T *Controller,
-				    ProcessorFlags_T *ProcessorFlags)
-{
-}
-
-
-/*
-  DAC960_AcquireControllerLockIH acquires exclusive access to Controller,
-  but is only called from the interrupt handler.
-*/
-
-static inline
-void DAC960_AcquireControllerLockIH(DAC960_Controller_T *Controller,
-				    ProcessorFlags_T *ProcessorFlags)
-{
-  spin_lock_irqsave(&Controller->queue_lock, *ProcessorFlags);
-}
-
-
-/*
-  DAC960_ReleaseControllerLockIH releases exclusive access to Controller,
-  but is only called from the interrupt handler.
-*/
-
-static inline
-void DAC960_ReleaseControllerLockIH(DAC960_Controller_T *Controller,
-				    ProcessorFlags_T *ProcessorFlags)
-{
-  spin_unlock_irqrestore(&Controller->queue_lock, *ProcessorFlags);
-}
-
-
-/*
   Define the DAC960 BA Series Controller Interface Register Offsets.
 */
 
@@ -4230,17 +4128,18 @@
 static void DAC960_FinalizeController(DAC960_Controller_T *);
 static void DAC960_V1_QueueReadWriteCommand(DAC960_Command_T *);
 static void DAC960_V2_QueueReadWriteCommand(DAC960_Command_T *); 
-static void DAC960_RequestFunction(RequestQueue_T *);
-static irqreturn_t DAC960_BA_InterruptHandler(int, void *, Registers_T *);
-static irqreturn_t DAC960_LP_InterruptHandler(int, void *, Registers_T *);
-static irqreturn_t DAC960_LA_InterruptHandler(int, void *, Registers_T *);
-static irqreturn_t DAC960_PG_InterruptHandler(int, void *, Registers_T *);
-static irqreturn_t DAC960_PD_InterruptHandler(int, void *, Registers_T *);
-static irqreturn_t DAC960_P_InterruptHandler(int, void *, Registers_T *);
+static void DAC960_RequestFunction(struct request_queue *);
+static irqreturn_t DAC960_BA_InterruptHandler(int, void *, struct pt_regs *);
+static irqreturn_t DAC960_LP_InterruptHandler(int, void *, struct pt_regs *);
+static irqreturn_t DAC960_LA_InterruptHandler(int, void *, struct pt_regs *);
+static irqreturn_t DAC960_PG_InterruptHandler(int, void *, struct pt_regs *);
+static irqreturn_t DAC960_PD_InterruptHandler(int, void *, struct pt_regs *);
+static irqreturn_t DAC960_P_InterruptHandler(int, void *, struct pt_regs *);
 static void DAC960_V1_QueueMonitoringCommand(DAC960_Command_T *);
 static void DAC960_V2_QueueMonitoringCommand(DAC960_Command_T *);
 static void DAC960_MonitoringTimerFunction(unsigned long);
-static int DAC960_UserIOCTL(Inode_T *, File_T *, unsigned int, unsigned long);
+static int DAC960_UserIOCTL(struct inode *, struct file *,
+			    unsigned int, unsigned long);
 static void DAC960_Message(DAC960_MessageLevel_T, unsigned char *,
 			   DAC960_Controller_T *, ...);
 static void DAC960_CreateProcEntries(DAC960_Controller_T *);


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSFXFQH>; Mon, 24 Jun 2002 01:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSFXFQG>; Mon, 24 Jun 2002 01:16:06 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:32272 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317334AbSFXFQD>;
	Mon, 24 Jun 2002 01:16:03 -0400
Date: Mon, 24 Jun 2002 01:07:18 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : BusLogic cleanup
Message-ID: <Pine.LNX.4.44.0206240104380.922-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch removes some unneccessary (it seems) typedefs, and 
adds in the pci_set_dma_mask() check mentioned in 
Documentation/DMA-mapping.txt . Please review.

Regards,
Frank

--- drivers/scsi/BusLogic.h.old	Sun Feb  3 19:53:47 2002
+++ drivers/scsi/BusLogic.h	Mon Jun 24 01:02:35 2002
@@ -28,37 +28,18 @@
 
 #include <linux/config.h>
 
-
-/*
-  Define types for some of the structures that interface with the rest
-  of the Linux Kernel and SCSI Subsystem.
-*/
-
-typedef kdev_t KernelDevice_T;
-typedef unsigned long ProcessorFlags_T;
-typedef struct pt_regs Registers_T;
-typedef struct partition PartitionTable_T;
-typedef struct pci_dev PCI_Device_T;
-typedef Scsi_Host_Template SCSI_Host_Template_T;
-typedef struct Scsi_Host SCSI_Host_T;
-typedef struct scsi_device SCSI_Device_T;
-typedef struct scsi_disk SCSI_Disk_T;
-typedef struct scsi_cmnd SCSI_Command_T;
-typedef struct scatterlist SCSI_ScatterList_T;
-
-
 /*
   Define prototypes for the BusLogic Driver Interface Functions.
 */
 
-extern const char *BusLogic_DriverInfo(SCSI_Host_T *);
-extern int BusLogic_DetectHostAdapter(SCSI_Host_Template_T *);
-extern int BusLogic_ReleaseHostAdapter(SCSI_Host_T *);
-extern int BusLogic_QueueCommand(SCSI_Command_T *,
-				 void (*CompletionRoutine)(SCSI_Command_T *));
-extern int BusLogic_AbortCommand(SCSI_Command_T *);
-extern int BusLogic_ResetCommand(SCSI_Command_T *, unsigned int);
-extern int BusLogic_BIOSDiskParameters(SCSI_Disk_T *, KernelDevice_T, int *);
+extern const char *BusLogic_DriverInfo(struct Scsi_Host *);
+extern int BusLogic_DetectHostAdapter(Scsi_Host_Template *);
+extern int BusLogic_ReleaseHostAdapter(struct Scsi_Host *);
+extern int BusLogic_QueueCommand(struct scsi_cmnd *,
+				 void (*CompletionRoutine)(struct scsi_cmnd *));
+extern int BusLogic_AbortCommand(struct scsi_cmnd *);
+extern int BusLogic_ResetCommand(struct scsi_cmnd *, unsigned int);
+extern int BusLogic_BIOSDiskParameters(struct scsi_disk *, kdev_t, int *);
 extern int BusLogic_ProcDirectoryInfo(char *, char **, off_t, int, int, int);
 
 
@@ -1195,7 +1176,7 @@
   boolean AllocationGroupHead;
   BusLogic_CCB_Status_T Status;
   unsigned long SerialNumber;
-  SCSI_Command_T *Command;
+  struct scsi_cmnd *Command;
   struct BusLogic_HostAdapter *HostAdapter;
   struct BusLogic_CCB *Next;
   struct BusLogic_CCB *NextAll;
@@ -1355,7 +1336,7 @@
 
 typedef struct BusLogic_HostAdapter
 {
-  SCSI_Host_T *SCSI_Host;
+  struct Scsi_Host *SCSI_Host;
   BusLogic_HostAdapterType_T HostAdapterType;
   BusLogic_HostAdapterBusType_T HostAdapterBusType;
   BusLogic_IO_Address_T IO_Address;
@@ -1506,7 +1487,7 @@
 
 static inline
 void BusLogic_AcquireHostAdapterLock(BusLogic_HostAdapter_T *HostAdapter,
-				     ProcessorFlags_T *ProcessorFlags)
+				     unsigned long *ProcessorFlags)
 {
 }
 
@@ -1517,7 +1498,7 @@
 
 static inline
 void BusLogic_ReleaseHostAdapterLock(BusLogic_HostAdapter_T *HostAdapter,
-				     ProcessorFlags_T *ProcessorFlags)
+				     unsigned long *ProcessorFlags)
 {
 }
 
@@ -1529,7 +1510,7 @@
 
 static inline
 void BusLogic_AcquireHostAdapterLockIH(BusLogic_HostAdapter_T *HostAdapter,
-				       ProcessorFlags_T *ProcessorFlags)
+				       unsigned long *ProcessorFlags)
 {
   spin_lock_irqsave(HostAdapter->SCSI_Host->host_lock, *ProcessorFlags);
 }
@@ -1542,7 +1523,7 @@
 
 static inline
 void BusLogic_ReleaseHostAdapterLockIH(BusLogic_HostAdapter_T *HostAdapter,
-				       ProcessorFlags_T *ProcessorFlags)
+				       unsigned long *ProcessorFlags)
 {
   spin_unlock_irqrestore(HostAdapter->SCSI_Host->host_lock, *ProcessorFlags);
 }
@@ -1763,9 +1744,9 @@
 */
 
 static void BusLogic_QueueCompletedCCB(BusLogic_CCB_T *);
-static void BusLogic_InterruptHandler(int, void *, Registers_T *);
+static void BusLogic_InterruptHandler(int, void *, struct pt_regs *);
 static int BusLogic_ResetHostAdapter(BusLogic_HostAdapter_T *,
-				     SCSI_Command_T *, unsigned int);
+				     struct scsi_cmnd *, unsigned int);
 static void BusLogic_Message(BusLogic_MessageLevel_T, char *,
 			     BusLogic_HostAdapter_T *, ...);
 
@@ -1798,9 +1779,9 @@
 static void BusLogic_ReleaseResources(BusLogic_HostAdapter_T *) __init;
 static boolean BusLogic_TargetDeviceInquiry(BusLogic_HostAdapter_T *) __init;
 static void BusLogic_InitializeHostStructure(BusLogic_HostAdapter_T *,
-					     SCSI_Host_T *) __init;
-int BusLogic_DetectHostAdapter(SCSI_Host_Template_T *) __init;
-int BusLogic_ReleaseHostAdapter(SCSI_Host_T *) __init;
+					     struct Scsi_Host *) __init;
+int BusLogic_DetectHostAdapter(Scsi_Host_Template *) __init;
+int BusLogic_ReleaseHostAdapter(struct Scsi_Host *) __init;
 static boolean BusLogic_ParseKeyword(char **, char *) __init;
 static int BusLogic_ParseDriverOptions(char *) __init;
 static int BusLogic_Setup(char *) __init;

--- drivers/scsi/BusLogic.c.old	Sat May  4 12:23:23 2002
+++ drivers/scsi/BusLogic.c	Mon Jun 24 00:57:15 2002
@@ -161,7 +161,7 @@
   Driver and Host Adapter.
 */
 
-const char *BusLogic_DriverInfo(SCSI_Host_T *Host)
+const char *BusLogic_DriverInfo(struct Scsi_Host *Host)
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) Host->hostdata;
@@ -415,7 +415,7 @@
   unsigned char *ReplyPointer = (unsigned char *) ReplyData;
   BusLogic_StatusRegister_T StatusRegister;
   BusLogic_InterruptRegister_T InterruptRegister;
-  ProcessorFlags_T ProcessorFlags = 0;
+  unsigned long ProcessorFlags = 0;
   int ReplyBytes = 0, Result;
   long TimeoutCounter;
   /*
@@ -766,6 +766,10 @@
 				       PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
 				       PCI_Device)) != NULL)
     {
+      if(pci_set_dma_mask(PCI_Device, 0xffffffff))
+      {
+		printk(KERN_WARNING "BusLogic : No suitable DMA available\n");
+      }
       BusLogic_HostAdapter_T *HostAdapter = PrototypeHostAdapter;
       BusLogic_PCIHostAdapterInformation_T PCIHostAdapterInformation;
       BusLogic_ModifyIOAddressRequest_T ModifyIOAddressRequest;
@@ -2613,7 +2617,7 @@
 
 static void BusLogic_InitializeHostStructure(BusLogic_HostAdapter_T
 					       *HostAdapter,
-					     SCSI_Host_T *Host)
+					     struct Scsi_Host *Host)
 {
   Host->max_id = HostAdapter->MaxTargetDevices;
   Host->max_lun = HostAdapter->MaxLogicalUnits;
@@ -2635,15 +2639,15 @@
   since all the Target Devices have now been probed.
 */
 
-static void BusLogic_SelectQueueDepths(SCSI_Host_T *Host,
-				       SCSI_Device_T *DeviceList)
+static void BusLogic_SelectQueueDepths(struct Scsi_Host *Host,
+				       struct scsi_device *DeviceList)
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) Host->hostdata;
   int TaggedDeviceCount = 0, AutomaticTaggedDeviceCount = 0;
   int UntaggedDeviceCount = 0, AutomaticTaggedQueueDepth = 0;
   int AllocatedQueueDepth = 0;
-  SCSI_Device_T *Device;
+  struct scsi_device *Device;
   int TargetID;
   for (TargetID = 0; TargetID < HostAdapter->MaxTargetDevices; TargetID++)
     if (HostAdapter->TargetFlags[TargetID].TargetExists)
@@ -2714,7 +2718,7 @@
   registered.
 */
 
-int BusLogic_DetectHostAdapter(SCSI_Host_Template_T *HostTemplate)
+int BusLogic_DetectHostAdapter(Scsi_Host_Template *HostTemplate)
 {
   int BusLogicHostAdapterCount = 0, DriverOptionsIndex = 0, ProbeIndex;
   BusLogic_HostAdapter_T *PrototypeHostAdapter;
@@ -2748,7 +2752,7 @@
     {
       BusLogic_ProbeInfo_T *ProbeInfo = &BusLogic_ProbeInfoList[ProbeIndex];
       BusLogic_HostAdapter_T *HostAdapter = PrototypeHostAdapter;
-      SCSI_Host_T *Host;
+      struct Scsi_Host *Host;
       if (ProbeInfo->IO_Address == 0) continue;
       memset(HostAdapter, 0, sizeof(BusLogic_HostAdapter_T));
       HostAdapter->HostAdapterType = ProbeInfo->HostAdapterType;
@@ -2878,7 +2882,7 @@
   unregisters the BusLogic Host Adapter.
 */
 
-int BusLogic_ReleaseHostAdapter(SCSI_Host_T *Host)
+int BusLogic_ReleaseHostAdapter(struct Scsi_Host *Host)
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) Host->hostdata;
@@ -3061,7 +3065,7 @@
   while (HostAdapter->FirstCompletedCCB != NULL)
     {
       BusLogic_CCB_T *CCB = HostAdapter->FirstCompletedCCB;
-      SCSI_Command_T *Command = CCB->Command;
+      struct scsi_cmnd *Command = CCB->Command;
       HostAdapter->FirstCompletedCCB = CCB->Next;
       if (HostAdapter->FirstCompletedCCB == NULL)
 	HostAdapter->LastCompletedCCB = NULL;
@@ -3092,7 +3096,7 @@
 	  */
 	  while (Command != NULL)
 	    {
-	      SCSI_Command_T *NextCommand = Command->reset_chain;
+	      struct scsi_cmnd *NextCommand = Command->reset_chain;
 	      Command->reset_chain = NULL;
 	      Command->result = DID_RESET << 16;
 	      Command->scsi_done(Command);
@@ -3211,11 +3215,11 @@
 
 static void BusLogic_InterruptHandler(int IRQ_Channel,
 				      void *DeviceIdentifier,
-				      Registers_T *InterruptRegisters)
+				      struct pt_regs *InterruptRegisters)
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) DeviceIdentifier;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long ProcessorFlags;
   /*
     Acquire exclusive access to Host Adapter.
   */
@@ -3338,8 +3342,8 @@
   Outgoing Mailbox for execution by the associated Host Adapter.
 */
 
-int BusLogic_QueueCommand(SCSI_Command_T *Command,
-			  void (*CompletionRoutine)(SCSI_Command_T *))
+int BusLogic_QueueCommand(struct scsi_cmnd *Command,
+			  void (*CompletionRoutine)(struct scsi_cmnd *))
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) Command->host->hostdata;
@@ -3354,7 +3358,7 @@
   void *BufferPointer = Command->request_buffer;
   int BufferLength = Command->request_bufflen;
   int SegmentCount = Command->use_sg;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long ProcessorFlags;
   BusLogic_CCB_T *CCB;
   /*
     SCSI REQUEST_SENSE commands will be executed automatically by the Host
@@ -3400,7 +3404,7 @@
     }
   else
     {
-      SCSI_ScatterList_T *ScatterList = (SCSI_ScatterList_T *) BufferPointer;
+      struct scatterlist *ScatterList = (struct scatterlist *) BufferPointer;
       int Segment;
       CCB->Opcode = BusLogic_InitiatorCCB_ScatterGather;
       CCB->DataLength = SegmentCount * sizeof(BusLogic_ScatterGatherSegment_T);
@@ -3566,12 +3570,12 @@
   BusLogic_AbortCommand aborts Command if possible.
 */
 
-int BusLogic_AbortCommand(SCSI_Command_T *Command)
+int BusLogic_AbortCommand(struct scsi_cmnd *Command)
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) Command->host->hostdata;
   int TargetID = Command->target;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long ProcessorFlags;
   BusLogic_CCB_T *CCB;
   int Result;
   BusLogic_IncrementErrorCounter(
@@ -3691,10 +3695,10 @@
 */
 
 static int BusLogic_ResetHostAdapter(BusLogic_HostAdapter_T *HostAdapter,
-				     SCSI_Command_T *Command,
+				     struct scsi_cmnd *Command,
 				     unsigned int ResetFlags)
 {
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long ProcessorFlags;
   BusLogic_CCB_T *CCB;
   int TargetID, Result;
   boolean HardReset;
@@ -3824,7 +3828,7 @@
 	BusLogic_DeallocateCCB(CCB);
 	while (Command != NULL)
 	  {
-	    SCSI_Command_T *NextCommand = Command->reset_chain;
+	    struct scsi_cmnd *NextCommand = Command->reset_chain;
 	    Command->reset_chain = NULL;
 	    Command->result = DID_RESET << 16;
 	    Command->scsi_done(Command);
@@ -3852,12 +3856,12 @@
 */
 
 static int BusLogic_SendBusDeviceReset(BusLogic_HostAdapter_T *HostAdapter,
-				       SCSI_Command_T *Command,
+				       struct scsi_cmnd *Command,
 				       unsigned int ResetFlags)
 {
   int TargetID = Command->target;
   BusLogic_CCB_T *CCB, *XCCB;
-  ProcessorFlags_T ProcessorFlags;
+  unsigned long ProcessorFlags;
   int Result = -1;
   BusLogic_IncrementErrorCounter(
     &HostAdapter->TargetStatistics[TargetID].BusDeviceResetsRequested);
@@ -4038,7 +4042,7 @@
   BusLogic_ResetCommand takes appropriate action to reset Command.
 */
 
-int BusLogic_ResetCommand(SCSI_Command_T *Command, unsigned int ResetFlags)
+int BusLogic_ResetCommand(struct scsi_cmnd *Command, unsigned int ResetFlags)
 {
   BusLogic_HostAdapter_T *HostAdapter =
     (BusLogic_HostAdapter_T *) Command->host->hostdata;
@@ -4110,7 +4114,7 @@
   the BIOS, and a warning may be displayed.
 */
 
-int BusLogic_BIOSDiskParameters(SCSI_Disk_T *Disk, KernelDevice_T Device,
+int BusLogic_BIOSDiskParameters(struct scsi_disk *Disk, kdev_t Device,
 				int *Parameters)
 {
   BusLogic_HostAdapter_T *HostAdapter =
@@ -4147,8 +4151,8 @@
   */
   if (*(unsigned short *) (buf+64) == 0xAA55)
     {
-      PartitionTable_T *FirstPartitionEntry = (PartitionTable_T *) buf;
-      PartitionTable_T *PartitionEntry = FirstPartitionEntry;
+      struct partition *FirstPartitionEntry = (struct partition *) buf;
+      struct partition *PartitionEntry = FirstPartitionEntry;
       int SavedCylinders = DiskParameters->Cylinders, PartitionNumber;
       unsigned char PartitionEntryEndHead, PartitionEntryEndSector;
       for (PartitionNumber = 0; PartitionNumber < 4; PartitionNumber++)
@@ -5001,6 +5005,6 @@
 */
 MODULE_LICENSE("GPL");
 
-static SCSI_Host_Template_T driver_template = BUSLOGIC;
+static Scsi_Host_Template driver_template = BUSLOGIC;
 
 #include "scsi_module.c"


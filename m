Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318417AbSGSBAq>; Thu, 18 Jul 2002 21:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318418AbSGSBAq>; Thu, 18 Jul 2002 21:00:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55072 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318417AbSGSBAk>; Thu, 18 Jul 2002 21:00:40 -0400
Date: Thu, 18 Jul 2002 21:03:40 -0400
From: Doug Ledford <dledford@redhat.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org,
       Frank Davis <fdavis@si.rr.com>
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
Message-ID: <20020718210340.A28235@redhat.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org,
	Frank Davis <fdavis@si.rr.com>
References: <20020718154533.GA6851@vnl.com> <Pine.LNX.4.44.0207181815160.29194-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207181815160.29194-100000@linux-box.realnet.co.sz>; from zwane@linuxpower.ca on Thu, Jul 18, 2002 at 06:16:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2002 at 06:16:28PM +0200, Zwane Mwaikambo wrote:
> On Thu, 18 Jul 2002, Dale Amon wrote:
> 
> > BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
> > BusLogic.c: In function `BusLogic_DetectHostAdapter':
> > BusLogic.c:2841: warning: long unsigned int format, BusLogic_IO_Address_T arg (arg 2)
> > BusLogic.c: In function `BusLogic_QueueCommand':
> > BusLogic.c:3415: structure has no member named `address'
> > BusLogic.c: In function `BusLogic_BIOSDiskParameters':
> > BusLogic.c:4141: warning: implicit declaration of function `scsi_bios_ptable'
> > BusLogic.c:4141: warning: assignment makes pointer from integer without a cast
> > make[2]: *** [BusLogic.o] Error 1
> 
> I'm having a look at this, but there seem to be quite a number of 
> hindrances. Hopefully i'll have something before next release.

Attached you will find a patch that compiles cleanly, but is totally 
untested.  Testing would be appreciated.  I suspect FlashPoint controllers 
*might* have a problem, but MultiMaster (or whatever they are called) 
should work properly.  WARNING: This could eat a filesystem, it's totally 
untested DMA mapping code and I have *no* BusLogic controllers to do any 
sort of verifications with.  The brave at heart are needed to let me know 
if this thing works ;-)

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="BusLogic.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.739   -> 1.740  
#	drivers/scsi/BusLogic.h	1.4     -> 1.5    
#	drivers/scsi/BusLogic.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/18	dledford@perf50.perf.redhat.com	1.740
# BusLogic.h, BusLogic.c:
#   Update to DMA mapping API, take 1
# --------------------------------------------
#
diff -Nru a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
--- a/drivers/scsi/BusLogic.c	Thu Jul 18 20:59:47 2002
+++ b/drivers/scsi/BusLogic.c	Thu Jul 18 20:59:47 2002
@@ -26,10 +26,8 @@
 */
 
 
-#define BusLogic_DriverVersion		"2.1.15"
-#define BusLogic_DriverDate		"17 August 1998"
-
-#error Please convert me to Documentation/DMA-mapping.txt
+#define BusLogic_DriverVersion		"2.1.16"
+#define BusLogic_DriverDate		"18 July 2002"
 
 #include <linux/version.h>
 #include <linux/module.h>
@@ -48,6 +46,7 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/system.h>
+/* #include <scsi/scsicam.h> This include file is currently busted */
 #include "scsi.h"
 #include "hosts.h"
 #include "sd.h"
@@ -225,15 +224,19 @@
 */
 
 static void BusLogic_InitializeCCBs(BusLogic_HostAdapter_T *HostAdapter,
-				    void *BlockPointer, int BlockSize)
+				    void *BlockPointer, int BlockSize,
+				    dma_addr_t BlockPointerHandle)
 {
   BusLogic_CCB_T *CCB = (BusLogic_CCB_T *) BlockPointer;
+  unsigned int offset = 0;
   memset(BlockPointer, 0, BlockSize);
-  CCB->AllocationGroupHead = true;
+  CCB->AllocationGroupHead = BlockPointerHandle;
+  CCB->AllocationGroupSize = BlockSize;
   while ((BlockSize -= sizeof(BusLogic_CCB_T)) >= 0)
     {
       CCB->Status = BusLogic_CCB_Free;
       CCB->HostAdapter = HostAdapter;
+      CCB->DMA_Handle = (BusLogic_BusAddress_T)BlockPointerHandle + offset;
       if (BusLogic_FlashPointHostAdapterP(HostAdapter))
 	{
 	  CCB->CallbackFunction = BusLogic_QueueCompletedCCB;
@@ -245,6 +248,7 @@
       HostAdapter->All_CCBs = CCB;
       HostAdapter->AllocatedCCBs++;
       CCB++;
+      offset += sizeof(BusLogic_CCB_T);
     }
 }
 
@@ -256,19 +260,20 @@
 static boolean BusLogic_CreateInitialCCBs(BusLogic_HostAdapter_T *HostAdapter)
 {
   int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(BusLogic_CCB_T);
+  void *BlockPointer;
+  dma_addr_t BlockPointerHandle;
   while (HostAdapter->AllocatedCCBs < HostAdapter->InitialCCBs)
     {
-      void *BlockPointer = kmalloc(BlockSize,
-				   (HostAdapter->BounceBuffersRequired
-				    ? GFP_ATOMIC | GFP_DMA
-				    : GFP_ATOMIC));
+      BlockPointer = pci_alloc_consistent(HostAdapter->PCI_Device, BlockSize,
+					  &BlockPointerHandle);
       if (BlockPointer == NULL)
 	{
 	  BusLogic_Error("UNABLE TO ALLOCATE CCB GROUP - DETACHING\n",
 			 HostAdapter);
 	  return false;
 	}
-      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, BlockSize);
+      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, BlockSize,
+			      BlockPointerHandle);
     }
   return true;
 }
@@ -280,14 +285,20 @@
 
 static void BusLogic_DestroyCCBs(BusLogic_HostAdapter_T *HostAdapter)
 {
-  BusLogic_CCB_T *NextCCB = HostAdapter->All_CCBs, *CCB;
+  BusLogic_CCB_T *NextCCB = HostAdapter->All_CCBs, *CCB, *Last_CCB = NULL;
   HostAdapter->All_CCBs = NULL;
   HostAdapter->Free_CCBs = NULL;
   while ((CCB = NextCCB) != NULL)
     {
       NextCCB = CCB->NextAll;
       if (CCB->AllocationGroupHead)
-	kfree(CCB);
+	{
+	  if (Last_CCB)
+	    pci_free_consistent(HostAdapter->PCI_Device,
+				Last_CCB->AllocationGroupSize, Last_CCB,
+			 	Last_CCB->AllocationGroupHead);
+	  Last_CCB = CCB;
+	}
     }
 }
 
@@ -305,15 +316,16 @@
 {
   int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(BusLogic_CCB_T);
   int PreviouslyAllocated = HostAdapter->AllocatedCCBs;
+  void *BlockPointer;
+  dma_addr_t BlockPointerHandle;
   if (AdditionalCCBs <= 0) return;
   while (HostAdapter->AllocatedCCBs - PreviouslyAllocated < AdditionalCCBs)
     {
-      void *BlockPointer = kmalloc(BlockSize,
-				   (HostAdapter->BounceBuffersRequired
-				    ? GFP_ATOMIC | GFP_DMA
-				    : GFP_ATOMIC));
+      BlockPointer = pci_alloc_consistent(HostAdapter->PCI_Device, BlockSize,
+					  &BlockPointerHandle);
       if (BlockPointer == NULL) break;
-      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, BlockSize);
+      BusLogic_InitializeCCBs(HostAdapter, BlockPointer, BlockSize,
+			      BlockPointerHandle);
     }
   if (HostAdapter->AllocatedCCBs > PreviouslyAllocated)
     {
@@ -379,6 +391,21 @@
 static void BusLogic_DeallocateCCB(BusLogic_CCB_T *CCB)
 {
   BusLogic_HostAdapter_T *HostAdapter = CCB->HostAdapter;
+  if (CCB->Command->use_sg != 0)
+    {
+      pci_unmap_sg(HostAdapter->PCI_Device,
+		   (SCSI_ScatterList_T *)CCB->Command->request_buffer,
+		   CCB->Command->use_sg,
+		   scsi_to_pci_dma_dir(CCB->Command->sc_data_direction));
+    }
+  else if (CCB->Command->request_bufflen != 0)
+    {
+      pci_unmap_single(HostAdapter->PCI_Device, CCB->DataPointer,
+		       CCB->DataLength,
+		       scsi_to_pci_dma_dir(CCB->Command->sc_data_direction));
+    }
+  pci_unmap_single(HostAdapter->PCI_Device, CCB->SenseDataPointer,
+		   CCB->SenseDataLength, PCI_DMA_FROMDEVICE);
   CCB->Command = NULL;
   CCB->Status = BusLogic_CCB_Free;
   CCB->Next = HostAdapter->Free_CCBs;
@@ -643,6 +670,7 @@
   ProbeInfo->HostAdapterType = BusLogic_MultiMaster;
   ProbeInfo->HostAdapterBusType = BusLogic_ISA_Bus;
   ProbeInfo->IO_Address = IO_Address;
+  ProbeInfo->PCI_Device = NULL;
 }
 
 
@@ -769,8 +797,8 @@
       BusLogic_HostAdapter_T *HostAdapter = PrototypeHostAdapter;
       BusLogic_PCIHostAdapterInformation_T PCIHostAdapterInformation;
       BusLogic_ModifyIOAddressRequest_T ModifyIOAddressRequest;
-      unsigned char Bus = PCI_Device->bus->number;
-      unsigned char Device = PCI_Device->devfn >> 3;
+      unsigned char Bus;
+      unsigned char Device;
       unsigned int IRQ_Channel;
       unsigned long BaseAddress0;
       unsigned long BaseAddress1;
@@ -779,7 +807,12 @@
 
       if (pci_enable_device(PCI_Device))
       	continue;
+
+      if (pci_set_dma_mask(PCI_Device, (u64)0xffffffff))
+	continue;
       
+      Bus = PCI_Device->bus->number;
+      Device = PCI_Device->devfn >> 3;
       IRQ_Channel = PCI_Device->irq;
       IO_Address  = BaseAddress0 = pci_resource_start(PCI_Device, 0);
       PCI_Address = BaseAddress1 = pci_resource_start(PCI_Device, 1);
@@ -889,6 +922,7 @@
 	  PrimaryProbeInfo->Bus = Bus;
 	  PrimaryProbeInfo->Device = Device;
 	  PrimaryProbeInfo->IRQ_Channel = IRQ_Channel;
+	  PrimaryProbeInfo->PCI_Device = PCI_Device;
 	  PCIMultiMasterCount++;
 	}
       else if (BusLogic_ProbeInfoCount < BusLogic_MaxHostAdapters)
@@ -902,6 +936,7 @@
 	  ProbeInfo->Bus = Bus;
 	  ProbeInfo->Device = Device;
 	  ProbeInfo->IRQ_Channel = IRQ_Channel;
+	  ProbeInfo->PCI_Device = PCI_Device;
 	  NonPrimaryPCIMultiMasterCount++;
 	  PCIMultiMasterCount++;
 	}
@@ -978,13 +1013,21 @@
 				       PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER_NC,
 				       PCI_Device)) != NULL)
     {
-      unsigned char Bus = PCI_Device->bus->number;
-      unsigned char Device = PCI_Device->devfn >> 3;
-      unsigned int IRQ_Channel = PCI_Device->irq;
-      BusLogic_IO_Address_T IO_Address = pci_resource_start(PCI_Device, 0);
+      unsigned char Bus;
+      unsigned char Device;
+      unsigned int IRQ_Channel;
+      BusLogic_IO_Address_T IO_Address;
 
       if (pci_enable_device(PCI_Device))
-		continue;
+	continue;
+
+      if (pci_set_dma_mask(PCI_Device, (u64)0xffffffff))
+	continue;
+
+      Bus = PCI_Device->bus->number;
+      Device = PCI_Device->devfn >> 3;
+      IRQ_Channel = PCI_Device->irq;
+      IO_Address = pci_resource_start(PCI_Device, 0);
 
       if (IO_Address == 0 || IRQ_Channel == 0) continue;
       for (i = 0; i < BusLogic_ProbeInfoCount; i++)
@@ -998,6 +1041,7 @@
 	      ProbeInfo->Bus = Bus;
 	      ProbeInfo->Device = Device;
 	      ProbeInfo->IRQ_Channel = IRQ_Channel;
+	      ProbeInfo->PCI_Device = PCI_Device;
 	      break;
 	    }
 	}
@@ -1025,17 +1069,25 @@
 				       PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT,
 				       PCI_Device)) != NULL)
     {
-      unsigned char Bus = PCI_Device->bus->number;
-      unsigned char Device = PCI_Device->devfn >> 3;
-      unsigned int IRQ_Channel = PCI_Device->irq;
-      unsigned long BaseAddress0 = pci_resource_start(PCI_Device, 0);
-      unsigned long BaseAddress1 = pci_resource_start(PCI_Device, 1);
-      BusLogic_IO_Address_T IO_Address = BaseAddress0;
-      BusLogic_PCI_Address_T PCI_Address = BaseAddress1;
+      unsigned char Bus;
+      unsigned char Device;
+      unsigned int IRQ_Channel;
+      unsigned long BaseAddress0;
+      unsigned long BaseAddress1;
+      BusLogic_IO_Address_T IO_Address;
+      BusLogic_PCI_Address_T PCI_Address;
 
       if (pci_enable_device(PCI_Device))
-		continue;
+	continue;
 
+      if (pci_set_dma_mask(PCI_Device, (u64)0xffffffff))
+	continue;
+
+      Bus = PCI_Device->bus->number;
+      Device = PCI_Device->devfn >> 3;
+      IRQ_Channel = PCI_Device->irq;
+      IO_Address = BaseAddress0 = pci_resource_start(PCI_Device, 0);
+      PCI_Address = BaseAddress1 = pci_resource_start(PCI_Device, 1);
 #ifndef CONFIG_SCSI_OMIT_FLASHPOINT
       if (pci_resource_flags(PCI_Device, 0) & IORESOURCE_MEM)
 	{
@@ -1080,6 +1132,7 @@
 	  ProbeInfo->Bus = Bus;
 	  ProbeInfo->Device = Device;
 	  ProbeInfo->IRQ_Channel = IRQ_Channel;
+	  ProbeInfo->PCI_Device = PCI_Device;
 	  FlashPointCount++;
 	}
       else BusLogic_Warning("BusLogic: Too many Host Adapters "
@@ -2299,6 +2352,16 @@
   */
   if (HostAdapter->DMA_ChannelAcquired)
     free_dma(HostAdapter->DMA_Channel);
+  /*
+    Release any allocated memory structs not released elsewhere
+  */
+  if (HostAdapter->MailboxSpace)
+    pci_free_consistent(HostAdapter->PCI_Device, HostAdapter->MailboxSize,
+			HostAdapter->MailboxSpace,
+			HostAdapter->MailboxSpaceHandle);
+  HostAdapter->MailboxSpace = NULL;
+  HostAdapter->MailboxSpaceHandle = 0;
+  HostAdapter->MailboxSize = 0;
 }
 
 
@@ -2341,6 +2404,12 @@
   /*
     Initialize the Outgoing and Incoming Mailbox pointers.
   */
+  HostAdapter->MailboxSize = HostAdapter->MailboxCount *
+    (sizeof(BusLogic_OutgoingMailbox_T) + sizeof(BusLogic_IncomingMailbox_T));
+  HostAdapter->MailboxSpace = pci_alloc_consistent(HostAdapter->PCI_Device,
+    HostAdapter->MailboxSize, &HostAdapter->MailboxSpaceHandle);
+  if (HostAdapter->MailboxSpace == NULL)
+    return BusLogic_Failure(HostAdapter, "MAILBOX ALLOCATION");
   HostAdapter->FirstOutgoingMailbox =
     (BusLogic_OutgoingMailbox_T *) HostAdapter->MailboxSpace;
   HostAdapter->LastOutgoingMailbox =
@@ -2351,6 +2420,7 @@
   HostAdapter->LastIncomingMailbox =
     HostAdapter->FirstIncomingMailbox + HostAdapter->MailboxCount - 1;
   HostAdapter->NextIncomingMailbox = HostAdapter->FirstIncomingMailbox;
+
   /*
     Initialize the Outgoing and Incoming Mailbox structures.
   */
@@ -2363,7 +2433,7 @@
   */
   ExtendedMailboxRequest.MailboxCount = HostAdapter->MailboxCount;
   ExtendedMailboxRequest.BaseMailboxAddress =
-    Virtual_to_Bus(HostAdapter->FirstOutgoingMailbox);
+    (BusLogic_BusAddress_T) HostAdapter->MailboxSpaceHandle;
   if (BusLogic_Command(HostAdapter, BusLogic_InitializeExtendedMailbox,
 		       &ExtendedMailboxRequest,
 		       sizeof(ExtendedMailboxRequest), NULL, 0) < 0)
@@ -2838,7 +2908,8 @@
 			     HostAdapter->AddressCount,
 			     HostAdapter->FullModelName)) {
 		  printk(KERN_WARNING "BusLogic: Release and re-register of "
-			 "port 0x%04lx failed \n", HostAdapter->IO_Address);
+			 "port 0x%04lx failed \n",
+			 (unsigned long)HostAdapter->IO_Address);
 		  BusLogic_DestroyCCBs(HostAdapter);
 		  BusLogic_ReleaseResources(HostAdapter);
 		  BusLogic_UnregisterHostAdapter(HostAdapter);
@@ -3013,6 +3084,13 @@
   while ((CompletionCode = NextIncomingMailbox->CompletionCode) !=
 	 BusLogic_IncomingMailboxFree)
     {
+      /*
+        We are only allowed to do this because we limit our architectures we
+        run on to machines where bus_to_virt() actually works.  There *needs*
+        to be a dma_addr_to_virt() in the new PCI DMA mapping interface to
+        replace bus_to_virt() or else this code is going to become very
+        innefficient.
+      */
       BusLogic_CCB_T *CCB = (BusLogic_CCB_T *)
 	Bus_to_Virtual(NextIncomingMailbox->CCB);
       if (CompletionCode != BusLogic_AbortedCommandNotFound)
@@ -3315,7 +3393,7 @@
 	the Host Adapter is operating asynchronously and the locking code
 	does not protect against simultaneous access by the Host Adapter.
       */
-      NextOutgoingMailbox->CCB = Virtual_to_Bus(CCB);
+      NextOutgoingMailbox->CCB = CCB->DMA_Handle;
       NextOutgoingMailbox->ActionCode = ActionCode;
       BusLogic_StartMailboxCommand(HostAdapter);
       if (++NextOutgoingMailbox > HostAdapter->LastOutgoingMailbox)
@@ -3392,29 +3470,42 @@
   /*
     Initialize the fields in the BusLogic Command Control Block (CCB).
   */
-  if (SegmentCount == 0)
+  if (SegmentCount == 0 && BufferLength != 0)
     {
       CCB->Opcode = BusLogic_InitiatorCCB;
       CCB->DataLength = BufferLength;
-      CCB->DataPointer = Virtual_to_Bus(BufferPointer);
+      CCB->DataPointer =
+	pci_map_single(HostAdapter->PCI_Device, BufferPointer, BufferLength,
+		       scsi_to_pci_dma_dir(Command->sc_data_direction));
     }
-  else
+  else if (SegmentCount != 0)
     {
       SCSI_ScatterList_T *ScatterList = (SCSI_ScatterList_T *) BufferPointer;
-      int Segment;
+      int Segment, Count;
+
+      Count = pci_map_sg(HostAdapter->PCI_Device, ScatterList, SegmentCount,
+			 scsi_to_pci_dma_dir(Command->sc_data_direction));
       CCB->Opcode = BusLogic_InitiatorCCB_ScatterGather;
-      CCB->DataLength = SegmentCount * sizeof(BusLogic_ScatterGatherSegment_T);
+      CCB->DataLength = Count * sizeof(BusLogic_ScatterGatherSegment_T);
       if (BusLogic_MultiMasterHostAdapterP(HostAdapter))
-	CCB->DataPointer = Virtual_to_Bus(CCB->ScatterGatherList);
+	CCB->DataPointer = (unsigned int)CCB->DMA_Handle +
+			    ((unsigned int)&CCB->ScatterGatherList - 
+			     (unsigned int)CCB);
       else CCB->DataPointer = Virtual_to_32Bit_Virtual(CCB->ScatterGatherList);
-      for (Segment = 0; Segment < SegmentCount; Segment++)
+      for (Segment = 0; Segment < Count; Segment++)
 	{
 	  CCB->ScatterGatherList[Segment].SegmentByteCount =
-	    ScatterList[Segment].length;
+	    sg_dma_len(ScatterList+Segment);
 	  CCB->ScatterGatherList[Segment].SegmentDataPointer =
-	    Virtual_to_Bus(ScatterList[Segment].address);
+	    sg_dma_address(ScatterList+Segment);
 	}
     }
+  else
+    {
+      CCB->Opcode = BusLogic_InitiatorCCB;
+      CCB->DataLength = BufferLength;
+      CCB->DataPointer = 0;
+    }
   switch (CDB[0])
     {
     case READ_6:
@@ -3440,7 +3531,6 @@
       break;
     }
   CCB->CDB_Length = CDB_Length;
-  CCB->SenseDataLength = sizeof(Command->sense_buffer);
   CCB->HostAdapterStatus = 0;
   CCB->TargetDeviceStatus = 0;
   CCB->TargetID = TargetID;
@@ -3507,7 +3597,11 @@
 	}
     }
   memcpy(CCB->CDB, CDB, CDB_Length);
-  CCB->SenseDataPointer = Virtual_to_Bus(&Command->sense_buffer);
+  CCB->SenseDataLength = sizeof(Command->sense_buffer);
+  CCB->SenseDataPointer = pci_map_single(HostAdapter->PCI_Device,
+					 Command->sense_buffer,
+					 CCB->SenseDataLength,
+					 PCI_DMA_FROMDEVICE);
   CCB->Command = Command;
   Command->scsi_done = CompletionRoutine;
   if (BusLogic_MultiMasterHostAdapterP(HostAdapter))
@@ -4110,6 +4204,7 @@
   the BIOS, and a warning may be displayed.
 */
 
+unsigned char *scsi_bios_ptable(kdev_t);
 int BusLogic_BIOSDiskParameters(SCSI_Disk_T *Disk, KernelDevice_T Device,
 				int *Parameters)
 {
diff -Nru a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
--- a/drivers/scsi/BusLogic.h	Thu Jul 18 20:59:47 2002
+++ b/drivers/scsi/BusLogic.h	Thu Jul 18 20:59:47 2002
@@ -372,6 +372,7 @@
   BusLogic_HostAdapterBusType_T HostAdapterBusType;
   BusLogic_IO_Address_T IO_Address;
   BusLogic_PCI_Address_T PCI_Address;
+  PCI_Device_T *PCI_Device;
   unsigned char Bus;
   unsigned char Device;
   unsigned char IRQ_Channel;
@@ -1192,7 +1193,9 @@
   /*
     BusLogic Linux Driver Defined Portion.
   */
-  boolean AllocationGroupHead;
+  dma_addr_t AllocationGroupHead;
+  unsigned int AllocationGroupSize;
+  BusLogic_BusAddress_T DMA_Handle;
   BusLogic_CCB_Status_T Status;
   unsigned long SerialNumber;
   SCSI_Command_T *Command;
@@ -1356,6 +1359,7 @@
 typedef struct BusLogic_HostAdapter
 {
   SCSI_Host_T *SCSI_Host;
+  PCI_Device_T *PCI_Device;
   BusLogic_HostAdapterType_T HostAdapterType;
   BusLogic_HostAdapterBusType_T HostAdapterBusType;
   BusLogic_IO_Address_T IO_Address;
@@ -1444,9 +1448,13 @@
   BusLogic_IncomingMailbox_T *LastIncomingMailbox;
   BusLogic_IncomingMailbox_T *NextIncomingMailbox;
   BusLogic_TargetStatistics_T TargetStatistics[BusLogic_MaxTargetDevices];
-  unsigned char MailboxSpace[BusLogic_MaxMailboxes
+  unsigned char *MailboxSpace;
+  dma_addr_t	MailboxSpaceHandle;
+  unsigned int MailboxSize;
+  unsigned long CCB_Offset;
+/* [BusLogic_MaxMailboxes
 			     * (sizeof(BusLogic_OutgoingMailbox_T)
-				+ sizeof(BusLogic_IncomingMailbox_T))];
+				+ sizeof(BusLogic_IncomingMailbox_T))]; */
   char MessageBuffer[BusLogic_MessageBufferSize];
 }
 BusLogic_HostAdapter_T;

--9amGYk9869ThD9tj--

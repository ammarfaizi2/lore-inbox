Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272966AbTHSSbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272447AbTHSS32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:29:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:41625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272867AbTHSSRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:17:32 -0400
Date: Tue, 19 Aug 2003 11:18:01 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move DAC960 GAM IOCTLs into a new device
Message-ID: <20030819181801.GA11704@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is something I've been planning to do for a while.

The DAC960 driver uses an ugly overloading of the O_NONBLOCK flag to
support the controller's RAID configuration features.

Opening "/dev/rd/c0d0" with the O_NONBLOCK flag set returns a file
descriptor that can be used to do RAID control operations using ioctl().
The normal ioctl operations are not availabe with that file descriptor.

This patch removes that O_NONBLOCK overloading from DAC960_open() and
DAC960_ioctl() functions.  It introduces a new "miscellaneous" device
named /dev/dac960_gam.  It uses minor device number 252 of the miscellaneous
character devices.

The currently distrubted "Global Array Manager" server distrubted by
LSIlogic on their web page page works only on RH7.3 or earlier.  It doesn't
work under RH9.  There are probably some library incompatabilities.
So, I don't view this patch as breaking anything that currently works.
If this software package is ever brought up to date (which I doubt),
then it can be modified to use this new device at that time.

I'll be patching the Documentation/README.DAC960 file tomorrow.


diff -ur linux-2.5.60-test3-mm2_original/drivers/block/DAC960.c linux-2.6.0-test3-mm2_DAC/drivers/block/DAC960.c
--- linux-2.5.60-test3-mm2_original/drivers/block/DAC960.c	2003-08-18 21:56:52.000000000 -0700
+++ linux-2.6.0-test3-mm2_DAC/drivers/block/DAC960.c	2003-08-18 17:01:49.000000000 -0700
@@ -23,6 +23,7 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/miscdevice.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/completion.h>
@@ -44,6 +45,8 @@
 #include <asm/uaccess.h>
 #include "DAC960.h"
 
+#define DAC960_GAM_MINOR	252
+
 
 static DAC960_Controller_T *DAC960_Controllers[DAC960_MaxControllers];
 static int DAC960_ControllerCount;
@@ -71,10 +74,6 @@
 	DAC960_Controller_T *p = disk->queue->queuedata;
 	int drive_nr = (int)disk->private_data;
 
-	/* bad hack for the "user" ioctls */
-	if (!p->ControllerNumber && !drive_nr && (file->f_flags & O_NONBLOCK))
-		return 0;
-
 	if (p->FirmwareType == DAC960_V1_Controller) {
 		if (p->V1.LogicalDriveInformation[drive_nr].
 		    LogicalDriveState == DAC960_V1_LogicalDrive_Offline)
@@ -101,9 +100,6 @@
 	int drive_nr = (int)disk->private_data;
 	struct hd_geometry g, *loc = (struct hd_geometry *)arg;
 
-	if (file && (file->f_flags & O_NONBLOCK))
-		return DAC960_UserIOCTL(inode, file, cmd, arg);
-
 	if (cmd != HDIO_GETGEO || !loc)
 		return -EINVAL;
 
@@ -5569,526 +5565,125 @@
 }
 
 /*
-  DAC960_UserIOCTL is the User IOCTL Function for the DAC960 Driver.
+  DAC960_CheckStatusBuffer verifies that there is room to hold ByteCount
+  additional bytes in the Combined Status Buffer and grows the buffer if
+  necessary.  It returns true if there is enough room and false otherwise.
 */
 
-static int DAC960_UserIOCTL(struct inode *inode, struct file *file,
-			    unsigned int Request, unsigned long Argument)
+static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
+					unsigned int ByteCount)
 {
-  int ErrorCode = 0;
-  if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-  switch (Request)
+  unsigned char *NewStatusBuffer;
+  if (Controller->InitialStatusLength + 1 +
+      Controller->CurrentStatusLength + ByteCount + 1 <=
+      Controller->CombinedStatusBufferLength)
+    return true;
+  if (Controller->CombinedStatusBufferLength == 0)
     {
-    case DAC960_IOCTL_GET_CONTROLLER_COUNT:
-      return DAC960_ControllerCount;
-    case DAC960_IOCTL_GET_CONTROLLER_INFO:
-      {
-	DAC960_ControllerInfo_T *UserSpaceControllerInfo =
-	  (DAC960_ControllerInfo_T *) Argument;
-	DAC960_ControllerInfo_T ControllerInfo;
-	DAC960_Controller_T *Controller;
-	int ControllerNumber;
-	if (UserSpaceControllerInfo == NULL) return -EINVAL;
-	ErrorCode = get_user(ControllerNumber,
-			     &UserSpaceControllerInfo->ControllerNumber);
-	if (ErrorCode != 0) return ErrorCode;
-	if (ControllerNumber < 0 ||
-	    ControllerNumber > DAC960_ControllerCount - 1)
-	  return -ENXIO;
-	Controller = DAC960_Controllers[ControllerNumber];
-	if (Controller == NULL) return -ENXIO;
-	memset(&ControllerInfo, 0, sizeof(DAC960_ControllerInfo_T));
-	ControllerInfo.ControllerNumber = ControllerNumber;
-	ControllerInfo.FirmwareType = Controller->FirmwareType;
-	ControllerInfo.Channels = Controller->Channels;
-	ControllerInfo.Targets = Controller->Targets;
-	ControllerInfo.PCI_Bus = Controller->Bus;
-	ControllerInfo.PCI_Device = Controller->Device;
-	ControllerInfo.PCI_Function = Controller->Function;
-	ControllerInfo.IRQ_Channel = Controller->IRQ_Channel;
-	ControllerInfo.PCI_Address = Controller->PCI_Address;
-	strcpy(ControllerInfo.ModelName, Controller->ModelName);
-	strcpy(ControllerInfo.FirmwareVersion, Controller->FirmwareVersion);
-	return (copy_to_user(UserSpaceControllerInfo, &ControllerInfo,
-			     sizeof(DAC960_ControllerInfo_T)) ? -EFAULT : 0);
-      }
-    case DAC960_IOCTL_V1_EXECUTE_COMMAND:
-      {
-	DAC960_V1_UserCommand_T *UserSpaceUserCommand =
-	  (DAC960_V1_UserCommand_T *) Argument;
-	DAC960_V1_UserCommand_T UserCommand;
-	DAC960_Controller_T *Controller;
-	DAC960_Command_T *Command = NULL;
-	DAC960_V1_CommandOpcode_T CommandOpcode;
-	DAC960_V1_CommandStatus_T CommandStatus;
-	DAC960_V1_DCDB_T DCDB;
-	DAC960_V1_DCDB_T *DCDB_IOBUF = NULL;
-	dma_addr_t	DCDB_IOBUFDMA;
-	unsigned long flags;
-	int ControllerNumber, DataTransferLength;
-	unsigned char *DataTransferBuffer = NULL;
-	dma_addr_t DataTransferBufferDMA;
-	if (UserSpaceUserCommand == NULL) return -EINVAL;
-	if (copy_from_user(&UserCommand, UserSpaceUserCommand,
-				   sizeof(DAC960_V1_UserCommand_T))) {
-		ErrorCode = -EFAULT;
-		goto Failure1a;
-	}
-	ControllerNumber = UserCommand.ControllerNumber;
-	if (ControllerNumber < 0 ||
-	    ControllerNumber > DAC960_ControllerCount - 1)
-	  return -ENXIO;
-	Controller = DAC960_Controllers[ControllerNumber];
-	if (Controller == NULL) return -ENXIO;
-	if (Controller->FirmwareType != DAC960_V1_Controller) return -EINVAL;
-	CommandOpcode = UserCommand.CommandMailbox.Common.CommandOpcode;
-	DataTransferLength = UserCommand.DataTransferLength;
-	if (CommandOpcode & 0x80) return -EINVAL;
-	if (CommandOpcode == DAC960_V1_DCDB)
-	  {
-	    if (copy_from_user(&DCDB, UserCommand.DCDB,
-			       sizeof(DAC960_V1_DCDB_T))) {
-		ErrorCode = -EFAULT;
-		goto Failure1a;
+      unsigned int NewStatusBufferLength = DAC960_InitialStatusBufferSize;
+      while (NewStatusBufferLength < ByteCount)
+	NewStatusBufferLength *= 2;
+      Controller->CombinedStatusBuffer =
+	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
+      if (Controller->CombinedStatusBuffer == NULL) return false;
+      Controller->CombinedStatusBufferLength = NewStatusBufferLength;
+      return true;
+    }
+  NewStatusBuffer = (unsigned char *)
+    kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
+  if (NewStatusBuffer == NULL)
+    {
+      DAC960_Warning("Unable to expand Combined Status Buffer - Truncating\n",
+		     Controller);
+      return false;
+    }
+  memcpy(NewStatusBuffer, Controller->CombinedStatusBuffer,
+	 Controller->CombinedStatusBufferLength);
+  kfree(Controller->CombinedStatusBuffer);
+  Controller->CombinedStatusBuffer = NewStatusBuffer;
+  Controller->CombinedStatusBufferLength *= 2;
+  Controller->CurrentStatusBuffer =
+    &NewStatusBuffer[Controller->InitialStatusLength + 1];
+  return true;
+}
+
+
+/*
+  DAC960_Message prints Driver Messages.
+*/
+
+static void DAC960_Message(DAC960_MessageLevel_T MessageLevel,
+			   unsigned char *Format,
+			   DAC960_Controller_T *Controller,
+			   ...)
+{
+  static unsigned char Buffer[DAC960_LineBufferSize];
+  static boolean BeginningOfLine = true;
+  va_list Arguments;
+  int Length = 0;
+  va_start(Arguments, Controller);
+  Length = vsprintf(Buffer, Format, Arguments);
+  va_end(Arguments);
+  if (Controller == NULL)
+    printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
+	   DAC960_ControllerCount, Buffer);
+  else if (MessageLevel == DAC960_AnnounceLevel ||
+	   MessageLevel == DAC960_InfoLevel)
+    {
+      if (!Controller->ControllerInitialized)
+	{
+	  if (DAC960_CheckStatusBuffer(Controller, Length))
+	    {
+	      strcpy(&Controller->CombinedStatusBuffer
+				  [Controller->InitialStatusLength],
+		     Buffer);
+	      Controller->InitialStatusLength += Length;
+	      Controller->CurrentStatusBuffer =
+		&Controller->CombinedStatusBuffer
+			     [Controller->InitialStatusLength + 1];
 	    }
-	    if (DCDB.Channel >= DAC960_V1_MaxChannels) return -EINVAL;
-	    if (!((DataTransferLength == 0 &&
-		   DCDB.Direction
-		   == DAC960_V1_DCDB_NoDataTransfer) ||
-		  (DataTransferLength > 0 &&
-		   DCDB.Direction
-		   == DAC960_V1_DCDB_DataTransferDeviceToSystem) ||
-		  (DataTransferLength < 0 &&
-		   DCDB.Direction
-		   == DAC960_V1_DCDB_DataTransferSystemToDevice)))
-	      return -EINVAL;
-	    if (((DCDB.TransferLengthHigh4 << 16) | DCDB.TransferLength)
-		!= abs(DataTransferLength))
-	      return -EINVAL;
-	    DCDB_IOBUF = pci_alloc_consistent(Controller->PCIDevice,
-			sizeof(DAC960_V1_DCDB_T), &DCDB_IOBUFDMA);
-	    if (DCDB_IOBUF == NULL)
-			return -ENOMEM;
-	  }
-	if (DataTransferLength > 0)
-	  {
-	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
-				DataTransferLength, &DataTransferBufferDMA);
-	    if (DataTransferBuffer == NULL) {
-		ErrorCode = -ENOMEM;
-		goto Failure1;
+	  if (MessageLevel == DAC960_AnnounceLevel)
+	    {
+	      static int AnnouncementLines = 0;
+	      if (++AnnouncementLines <= 2)
+		printk("%sDAC960: %s", DAC960_MessageLevelMap[MessageLevel],
+		       Buffer);
 	    }
-	    memset(DataTransferBuffer, 0, DataTransferLength);
-	  }
-	else if (DataTransferLength < 0)
-	  {
-	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
-				-DataTransferLength, &DataTransferBufferDMA);
-	    if (DataTransferBuffer == NULL) {
-		ErrorCode = -ENOMEM;
-		goto Failure1;
+	  else
+	    {
+	      if (BeginningOfLine)
+		{
+		  if (Buffer[0] != '\n' || Length > 1)
+		    printk("%sDAC960#%d: %s",
+			   DAC960_MessageLevelMap[MessageLevel],
+			   Controller->ControllerNumber, Buffer);
+		}
+	      else printk("%s", Buffer);
 	    }
-	    if (copy_from_user(DataTransferBuffer,
-			       UserCommand.DataTransferBuffer,
-			       -DataTransferLength)) {
-		ErrorCode = -EFAULT;
-		goto Failure1;
+	}
+      else if (DAC960_CheckStatusBuffer(Controller, Length))
+	{
+	  strcpy(&Controller->CurrentStatusBuffer[
+		    Controller->CurrentStatusLength], Buffer);
+	  Controller->CurrentStatusLength += Length;
+	}
+    }
+  else if (MessageLevel == DAC960_ProgressLevel)
+    {
+      strcpy(Controller->ProgressBuffer, Buffer);
+      Controller->ProgressBufferLength = Length;
+      if (Controller->EphemeralProgressMessage)
+	{
+	  if (jiffies - Controller->LastProgressReportTime
+	      >= DAC960_ProgressReportingInterval)
+	    {
+	      printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
+		     Controller->ControllerNumber, Buffer);
+	      Controller->LastProgressReportTime = jiffies;
 	    }
-	  }
-	if (CommandOpcode == DAC960_V1_DCDB)
-	  {
-	    spin_lock_irqsave(&Controller->queue_lock, flags);
-	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
-	      DAC960_WaitForCommand(Controller);
-	    while (Controller->V1.DirectCommandActive[DCDB.Channel]
-						     [DCDB.TargetID])
-	      {
-		spin_unlock_irq(&Controller->queue_lock);
-		__wait_event(Controller->CommandWaitQueue,
-			     !Controller->V1.DirectCommandActive
-					     [DCDB.Channel][DCDB.TargetID]);
-		spin_lock_irq(&Controller->queue_lock);
-	      }
-	    Controller->V1.DirectCommandActive[DCDB.Channel]
-					      [DCDB.TargetID] = true;
-	    spin_unlock_irqrestore(&Controller->queue_lock, flags);
-	    DAC960_V1_ClearCommand(Command);
-	    Command->CommandType = DAC960_ImmediateCommand;
-	    memcpy(&Command->V1.CommandMailbox, &UserCommand.CommandMailbox,
-		   sizeof(DAC960_V1_CommandMailbox_T));
-	    Command->V1.CommandMailbox.Type3.BusAddress = DCDB_IOBUFDMA;
-	    DCDB.BusAddress = DataTransferBufferDMA;
-	    memcpy(DCDB_IOBUF, &DCDB, sizeof(DAC960_V1_DCDB_T));
-	  }
-	else
-	  {
-	    spin_lock_irqsave(&Controller->queue_lock, flags);
-	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
-	      DAC960_WaitForCommand(Controller);
-	    spin_unlock_irqrestore(&Controller->queue_lock, flags);
-	    DAC960_V1_ClearCommand(Command);
-	    Command->CommandType = DAC960_ImmediateCommand;
-	    memcpy(&Command->V1.CommandMailbox, &UserCommand.CommandMailbox,
-		   sizeof(DAC960_V1_CommandMailbox_T));
-	    if (DataTransferBuffer != NULL)
-	      Command->V1.CommandMailbox.Type3.BusAddress =
-		DataTransferBufferDMA;
-	  }
-	DAC960_ExecuteCommand(Command);
-	CommandStatus = Command->V1.CommandStatus;
-	spin_lock_irqsave(&Controller->queue_lock, flags);
-	DAC960_DeallocateCommand(Command);
-	spin_unlock_irqrestore(&Controller->queue_lock, flags);
-	if (DataTransferLength > 0)
-	  {
-	    if (copy_to_user(UserCommand.DataTransferBuffer,
-			     DataTransferBuffer, DataTransferLength)) {
-		ErrorCode = -EFAULT;
-		goto Failure1;
-            }
-	  }
-	if (CommandOpcode == DAC960_V1_DCDB)
-	  {
-	    /*
-	      I don't believe Target or Channel in the DCDB_IOBUF
-	      should be any different from the contents of DCDB.
-	     */
-	    Controller->V1.DirectCommandActive[DCDB.Channel]
-					      [DCDB.TargetID] = false;
-	    if (copy_to_user(UserCommand.DCDB, DCDB_IOBUF,
-			     sizeof(DAC960_V1_DCDB_T))) {
-		ErrorCode = -EFAULT;
-		goto Failure1;
-	    }
-	  }
-	ErrorCode = CommandStatus;
-      Failure1:
-	if (DataTransferBuffer != NULL)
-	  pci_free_consistent(Controller->PCIDevice, abs(DataTransferLength),
-			DataTransferBuffer, DataTransferBufferDMA);
-	if (DCDB_IOBUF != NULL)
-	  pci_free_consistent(Controller->PCIDevice, sizeof(DAC960_V1_DCDB_T),
-			DCDB_IOBUF, DCDB_IOBUFDMA);
-      Failure1a:
-	return ErrorCode;
-      }
-    case DAC960_IOCTL_V2_EXECUTE_COMMAND:
-      {
-	DAC960_V2_UserCommand_T *UserSpaceUserCommand =
-	  (DAC960_V2_UserCommand_T *) Argument;
-	DAC960_V2_UserCommand_T UserCommand;
-	DAC960_Controller_T *Controller;
-	DAC960_Command_T *Command = NULL;
-	DAC960_V2_CommandMailbox_T *CommandMailbox;
-	DAC960_V2_CommandStatus_T CommandStatus;
-	unsigned long flags;
-	int ControllerNumber, DataTransferLength;
-	int DataTransferResidue, RequestSenseLength;
-	unsigned char *DataTransferBuffer = NULL;
-	dma_addr_t DataTransferBufferDMA;
-	unsigned char *RequestSenseBuffer = NULL;
-	dma_addr_t RequestSenseBufferDMA;
-	if (UserSpaceUserCommand == NULL) return -EINVAL;
-	if (copy_from_user(&UserCommand, UserSpaceUserCommand,
-			   sizeof(DAC960_V2_UserCommand_T))) {
-		ErrorCode = -EFAULT;
-		goto Failure2a;
-	}
-	ControllerNumber = UserCommand.ControllerNumber;
-	if (ControllerNumber < 0 ||
-	    ControllerNumber > DAC960_ControllerCount - 1)
-	  return -ENXIO;
-	Controller = DAC960_Controllers[ControllerNumber];
-	if (Controller == NULL) return -ENXIO;
-	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
-	DataTransferLength = UserCommand.DataTransferLength;
-	if (DataTransferLength > 0)
-	  {
-	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
-				DataTransferLength, &DataTransferBufferDMA);
-	    if (DataTransferBuffer == NULL) return -ENOMEM;
-	    memset(DataTransferBuffer, 0, DataTransferLength);
-	  }
-	else if (DataTransferLength < 0)
-	  {
-	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
-				-DataTransferLength, &DataTransferBufferDMA);
-	    if (DataTransferBuffer == NULL) return -ENOMEM;
-	    if (copy_from_user(DataTransferBuffer,
-			       UserCommand.DataTransferBuffer,
-			       -DataTransferLength)) {
-		ErrorCode = -EFAULT;
-		goto Failure2;
-	    }
-	  }
-	RequestSenseLength = UserCommand.RequestSenseLength;
-	if (RequestSenseLength > 0)
-	  {
-	    RequestSenseBuffer = pci_alloc_consistent(Controller->PCIDevice,
-			RequestSenseLength, &RequestSenseBufferDMA);
-	    if (RequestSenseBuffer == NULL)
-	      {
-		ErrorCode = -ENOMEM;
-		goto Failure2;
-	      }
-	    memset(RequestSenseBuffer, 0, RequestSenseLength);
-	  }
-	spin_lock_irqsave(&Controller->queue_lock, flags);
-	while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
-	  DAC960_WaitForCommand(Controller);
-	spin_unlock_irqrestore(&Controller->queue_lock, flags);
-	DAC960_V2_ClearCommand(Command);
-	Command->CommandType = DAC960_ImmediateCommand;
-	CommandMailbox = &Command->V2.CommandMailbox;
-	memcpy(CommandMailbox, &UserCommand.CommandMailbox,
-	       sizeof(DAC960_V2_CommandMailbox_T));
-	CommandMailbox->Common.CommandControlBits
-			      .AdditionalScatterGatherListMemory = false;
-	CommandMailbox->Common.CommandControlBits
-			      .NoAutoRequestSense = true;
-	CommandMailbox->Common.DataTransferSize = 0;
-	CommandMailbox->Common.DataTransferPageNumber = 0;
-	memset(&CommandMailbox->Common.DataTransferMemoryAddress, 0,
-	       sizeof(DAC960_V2_DataTransferMemoryAddress_T));
-	if (DataTransferLength != 0)
-	  {
-	    if (DataTransferLength > 0)
-	      {
-		CommandMailbox->Common.CommandControlBits
-				      .DataTransferControllerToHost = true;
-		CommandMailbox->Common.DataTransferSize = DataTransferLength;
-	      }
-	    else
-	      {
-		CommandMailbox->Common.CommandControlBits
-				      .DataTransferControllerToHost = false;
-		CommandMailbox->Common.DataTransferSize = -DataTransferLength;
-	      }
-	    CommandMailbox->Common.DataTransferMemoryAddress
-				  .ScatterGatherSegments[0]
-				  .SegmentDataPointer = DataTransferBufferDMA;
-	    CommandMailbox->Common.DataTransferMemoryAddress
-				  .ScatterGatherSegments[0]
-				  .SegmentByteCount =
-	      CommandMailbox->Common.DataTransferSize;
-	  }
-	if (RequestSenseLength > 0)
-	  {
-	    CommandMailbox->Common.CommandControlBits
-				  .NoAutoRequestSense = false;
-	    CommandMailbox->Common.RequestSenseSize = RequestSenseLength;
-	    CommandMailbox->Common.RequestSenseBusAddress =
-	      						RequestSenseBufferDMA;
-	  }
-	DAC960_ExecuteCommand(Command);
-	CommandStatus = Command->V2.CommandStatus;
-	RequestSenseLength = Command->V2.RequestSenseLength;
-	DataTransferResidue = Command->V2.DataTransferResidue;
-	spin_lock_irqsave(&Controller->queue_lock, flags);
-	DAC960_DeallocateCommand(Command);
-	spin_unlock_irqrestore(&Controller->queue_lock, flags);
-	if (RequestSenseLength > UserCommand.RequestSenseLength)
-	  RequestSenseLength = UserCommand.RequestSenseLength;
-	if (copy_to_user(&UserSpaceUserCommand->DataTransferLength,
-				 &DataTransferResidue,
-				 sizeof(DataTransferResidue))) {
-		ErrorCode = -EFAULT;
-		goto Failure2;
-	}
-	if (copy_to_user(&UserSpaceUserCommand->RequestSenseLength,
-			 &RequestSenseLength, sizeof(RequestSenseLength))) {
-		ErrorCode = -EFAULT;
-		goto Failure2;
 	}
-	if (DataTransferLength > 0)
-	  {
-	    if (copy_to_user(UserCommand.DataTransferBuffer,
-			     DataTransferBuffer, DataTransferLength)) {
-		ErrorCode = -EFAULT;
-		goto Failure2;
-	    }
-	  }
-	if (RequestSenseLength > 0)
-	  {
-	    if (copy_to_user(UserCommand.RequestSenseBuffer,
-			     RequestSenseBuffer, RequestSenseLength)) {
-		ErrorCode = -EFAULT;
-		goto Failure2;
-	    }
-	  }
-	ErrorCode = CommandStatus;
-      Failure2:
-	  pci_free_consistent(Controller->PCIDevice, abs(DataTransferLength),
-		DataTransferBuffer, DataTransferBufferDMA);
-	if (RequestSenseBuffer != NULL)
-	  pci_free_consistent(Controller->PCIDevice, RequestSenseLength,
-		RequestSenseBuffer, RequestSenseBufferDMA);
-      Failure2a:
-	return ErrorCode;
-      }
-    case DAC960_IOCTL_V2_GET_HEALTH_STATUS:
-      {
-	DAC960_V2_GetHealthStatus_T *UserSpaceGetHealthStatus =
-	  (DAC960_V2_GetHealthStatus_T *) Argument;
-	DAC960_V2_GetHealthStatus_T GetHealthStatus;
-	DAC960_V2_HealthStatusBuffer_T HealthStatusBuffer;
-	DAC960_Controller_T *Controller;
-	int ControllerNumber;
-	if (UserSpaceGetHealthStatus == NULL) return -EINVAL;
-	if (copy_from_user(&GetHealthStatus, UserSpaceGetHealthStatus,
-			   sizeof(DAC960_V2_GetHealthStatus_T)))
-		return -EFAULT;
-	ControllerNumber = GetHealthStatus.ControllerNumber;
-	if (ControllerNumber < 0 ||
-	    ControllerNumber > DAC960_ControllerCount - 1)
-	  return -ENXIO;
-	Controller = DAC960_Controllers[ControllerNumber];
-	if (Controller == NULL) return -ENXIO;
-	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
-	if (copy_from_user(&HealthStatusBuffer,
-			   GetHealthStatus.HealthStatusBuffer,
-			   sizeof(DAC960_V2_HealthStatusBuffer_T)))
-		return -EFAULT;
-	while (Controller->V2.HealthStatusBuffer->StatusChangeCounter
-	       == HealthStatusBuffer.StatusChangeCounter &&
-	       Controller->V2.HealthStatusBuffer->NextEventSequenceNumber
-	       == HealthStatusBuffer.NextEventSequenceNumber)
-	  {
-	    interruptible_sleep_on_timeout(&Controller->HealthStatusWaitQueue,
-					   DAC960_MonitoringTimerInterval);
-	    if (signal_pending(current)) return -EINTR;
-	  }
-	if (copy_to_user(GetHealthStatus.HealthStatusBuffer,
-			 Controller->V2.HealthStatusBuffer,
-			 sizeof(DAC960_V2_HealthStatusBuffer_T)))
-		return -EFAULT;
-	return 0;
-      }
-    }
-  return -EINVAL;
-}
-
-
-/*
-  DAC960_CheckStatusBuffer verifies that there is room to hold ByteCount
-  additional bytes in the Combined Status Buffer and grows the buffer if
-  necessary.  It returns true if there is enough room and false otherwise.
-*/
-
-static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
-					unsigned int ByteCount)
-{
-  unsigned char *NewStatusBuffer;
-  if (Controller->InitialStatusLength + 1 +
-      Controller->CurrentStatusLength + ByteCount + 1 <=
-      Controller->CombinedStatusBufferLength)
-    return true;
-  if (Controller->CombinedStatusBufferLength == 0)
-    {
-      unsigned int NewStatusBufferLength = DAC960_InitialStatusBufferSize;
-      while (NewStatusBufferLength < ByteCount)
-	NewStatusBufferLength *= 2;
-      Controller->CombinedStatusBuffer =
-	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
-      if (Controller->CombinedStatusBuffer == NULL) return false;
-      Controller->CombinedStatusBufferLength = NewStatusBufferLength;
-      return true;
-    }
-  NewStatusBuffer = (unsigned char *)
-    kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
-  if (NewStatusBuffer == NULL)
-    {
-      DAC960_Warning("Unable to expand Combined Status Buffer - Truncating\n",
-		     Controller);
-      return false;
-    }
-  memcpy(NewStatusBuffer, Controller->CombinedStatusBuffer,
-	 Controller->CombinedStatusBufferLength);
-  kfree(Controller->CombinedStatusBuffer);
-  Controller->CombinedStatusBuffer = NewStatusBuffer;
-  Controller->CombinedStatusBufferLength *= 2;
-  Controller->CurrentStatusBuffer =
-    &NewStatusBuffer[Controller->InitialStatusLength + 1];
-  return true;
-}
-
-
-/*
-  DAC960_Message prints Driver Messages.
-*/
-
-static void DAC960_Message(DAC960_MessageLevel_T MessageLevel,
-			   unsigned char *Format,
-			   DAC960_Controller_T *Controller,
-			   ...)
-{
-  static unsigned char Buffer[DAC960_LineBufferSize];
-  static boolean BeginningOfLine = true;
-  va_list Arguments;
-  int Length = 0;
-  va_start(Arguments, Controller);
-  Length = vsprintf(Buffer, Format, Arguments);
-  va_end(Arguments);
-  if (Controller == NULL)
-    printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
-	   DAC960_ControllerCount, Buffer);
-  else if (MessageLevel == DAC960_AnnounceLevel ||
-	   MessageLevel == DAC960_InfoLevel)
-    {
-      if (!Controller->ControllerInitialized)
-	{
-	  if (DAC960_CheckStatusBuffer(Controller, Length))
-	    {
-	      strcpy(&Controller->CombinedStatusBuffer
-				  [Controller->InitialStatusLength],
-		     Buffer);
-	      Controller->InitialStatusLength += Length;
-	      Controller->CurrentStatusBuffer =
-		&Controller->CombinedStatusBuffer
-			     [Controller->InitialStatusLength + 1];
-	    }
-	  if (MessageLevel == DAC960_AnnounceLevel)
-	    {
-	      static int AnnouncementLines = 0;
-	      if (++AnnouncementLines <= 2)
-		printk("%sDAC960: %s", DAC960_MessageLevelMap[MessageLevel],
-		       Buffer);
-	    }
-	  else
-	    {
-	      if (BeginningOfLine)
-		{
-		  if (Buffer[0] != '\n' || Length > 1)
-		    printk("%sDAC960#%d: %s",
-			   DAC960_MessageLevelMap[MessageLevel],
-			   Controller->ControllerNumber, Buffer);
-		}
-	      else printk("%s", Buffer);
-	    }
-	}
-      else if (DAC960_CheckStatusBuffer(Controller, Length))
-	{
-	  strcpy(&Controller->CurrentStatusBuffer[
-		    Controller->CurrentStatusLength], Buffer);
-	  Controller->CurrentStatusLength += Length;
-	}
-    }
-  else if (MessageLevel == DAC960_ProgressLevel)
-    {
-      strcpy(Controller->ProgressBuffer, Buffer);
-      Controller->ProgressBufferLength = Length;
-      if (Controller->EphemeralProgressMessage)
-	{
-	  if (jiffies - Controller->LastProgressReportTime
-	      >= DAC960_ProgressReportingInterval)
-	    {
-	      printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
-		     Controller->ControllerNumber, Buffer);
-	      Controller->LastProgressReportTime = jiffies;
-	    }
-	}
-      else printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
-		  Controller->ControllerNumber, Buffer);
+      else printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
+		  Controller->ControllerNumber, Buffer);
     }
   else if (MessageLevel == DAC960_UserCriticalLevel)
     {
@@ -6722,184 +6317,614 @@
 	  StatusMessage = "ALERT\n";
 	  break;
 	}
-    }
-  BytesAvailable = strlen(StatusMessage) - Offset;
-  if (Count >= BytesAvailable)
-    {
-      Count = BytesAvailable;
-      *EOF = true;
-    }
-  if (Count <= 0) return 0;
-  *Start = Page;
-  memcpy(Page, &StatusMessage[Offset], Count);
-  return Count;
-}
-
-
-/*
-  DAC960_ProcReadInitialStatus implements reading /proc/rd/cN/initial_status.
-*/
-
-static int DAC960_ProcReadInitialStatus(char *Page, char **Start, off_t Offset,
-					int Count, int *EOF, void *Data)
-{
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
-  int BytesAvailable = Controller->InitialStatusLength - Offset;
-  if (Count >= BytesAvailable)
-    {
-      Count = BytesAvailable;
-      *EOF = true;
-    }
-  if (Count <= 0) return 0;
-  *Start = Page;
-  memcpy(Page, &Controller->CombinedStatusBuffer[Offset], Count);
-  return Count;
-}
-
-
-/*
-  DAC960_ProcReadCurrentStatus implements reading /proc/rd/cN/current_status.
-*/
-
-static int DAC960_ProcReadCurrentStatus(char *Page, char **Start, off_t Offset,
-					int Count, int *EOF, void *Data)
-{
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
-  unsigned char *StatusMessage =
-    "No Rebuild or Consistency Check in Progress\n";
-  int ProgressMessageLength = strlen(StatusMessage);
-  int BytesAvailable;
-  if (jiffies != Controller->LastCurrentStatusTime)
-    {
-      Controller->CurrentStatusLength = 0;
-      DAC960_AnnounceDriver(Controller);
-      DAC960_ReportControllerConfiguration(Controller);
-      DAC960_ReportDeviceConfiguration(Controller);
-      if (Controller->ProgressBufferLength > 0)
-	ProgressMessageLength = Controller->ProgressBufferLength;
-      if (DAC960_CheckStatusBuffer(Controller, 2 + ProgressMessageLength))
-	{
-	  unsigned char *CurrentStatusBuffer = Controller->CurrentStatusBuffer;
-	  CurrentStatusBuffer[Controller->CurrentStatusLength++] = ' ';
-	  CurrentStatusBuffer[Controller->CurrentStatusLength++] = ' ';
-	  if (Controller->ProgressBufferLength > 0)
-	    strcpy(&CurrentStatusBuffer[Controller->CurrentStatusLength],
-		   Controller->ProgressBuffer);
-	  else
-	    strcpy(&CurrentStatusBuffer[Controller->CurrentStatusLength],
-		   StatusMessage);
-	  Controller->CurrentStatusLength += ProgressMessageLength;
+    }
+  BytesAvailable = strlen(StatusMessage) - Offset;
+  if (Count >= BytesAvailable)
+    {
+      Count = BytesAvailable;
+      *EOF = true;
+    }
+  if (Count <= 0) return 0;
+  *Start = Page;
+  memcpy(Page, &StatusMessage[Offset], Count);
+  return Count;
+}
+
+
+/*
+  DAC960_ProcReadInitialStatus implements reading /proc/rd/cN/initial_status.
+*/
+
+static int DAC960_ProcReadInitialStatus(char *Page, char **Start, off_t Offset,
+					int Count, int *EOF, void *Data)
+{
+  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
+  int BytesAvailable = Controller->InitialStatusLength - Offset;
+  if (Count >= BytesAvailable)
+    {
+      Count = BytesAvailable;
+      *EOF = true;
+    }
+  if (Count <= 0) return 0;
+  *Start = Page;
+  memcpy(Page, &Controller->CombinedStatusBuffer[Offset], Count);
+  return Count;
+}
+
+
+/*
+  DAC960_ProcReadCurrentStatus implements reading /proc/rd/cN/current_status.
+*/
+
+static int DAC960_ProcReadCurrentStatus(char *Page, char **Start, off_t Offset,
+					int Count, int *EOF, void *Data)
+{
+  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
+  unsigned char *StatusMessage =
+    "No Rebuild or Consistency Check in Progress\n";
+  int ProgressMessageLength = strlen(StatusMessage);
+  int BytesAvailable;
+  if (jiffies != Controller->LastCurrentStatusTime)
+    {
+      Controller->CurrentStatusLength = 0;
+      DAC960_AnnounceDriver(Controller);
+      DAC960_ReportControllerConfiguration(Controller);
+      DAC960_ReportDeviceConfiguration(Controller);
+      if (Controller->ProgressBufferLength > 0)
+	ProgressMessageLength = Controller->ProgressBufferLength;
+      if (DAC960_CheckStatusBuffer(Controller, 2 + ProgressMessageLength))
+	{
+	  unsigned char *CurrentStatusBuffer = Controller->CurrentStatusBuffer;
+	  CurrentStatusBuffer[Controller->CurrentStatusLength++] = ' ';
+	  CurrentStatusBuffer[Controller->CurrentStatusLength++] = ' ';
+	  if (Controller->ProgressBufferLength > 0)
+	    strcpy(&CurrentStatusBuffer[Controller->CurrentStatusLength],
+		   Controller->ProgressBuffer);
+	  else
+	    strcpy(&CurrentStatusBuffer[Controller->CurrentStatusLength],
+		   StatusMessage);
+	  Controller->CurrentStatusLength += ProgressMessageLength;
+	}
+      Controller->LastCurrentStatusTime = jiffies;
+    }
+  BytesAvailable = Controller->CurrentStatusLength - Offset;
+  if (Count >= BytesAvailable)
+    {
+      Count = BytesAvailable;
+      *EOF = true;
+    }
+  if (Count <= 0) return 0;
+  *Start = Page;
+  memcpy(Page, &Controller->CurrentStatusBuffer[Offset], Count);
+  return Count;
+}
+
+
+/*
+  DAC960_ProcReadUserCommand implements reading /proc/rd/cN/user_command.
+*/
+
+static int DAC960_ProcReadUserCommand(char *Page, char **Start, off_t Offset,
+				      int Count, int *EOF, void *Data)
+{
+  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
+  int BytesAvailable = Controller->UserStatusLength - Offset;
+  if (Count >= BytesAvailable)
+    {
+      Count = BytesAvailable;
+      *EOF = true;
+    }
+  if (Count <= 0) return 0;
+  *Start = Page;
+  memcpy(Page, &Controller->UserStatusBuffer[Offset], Count);
+  return Count;
+}
+
+
+/*
+  DAC960_ProcWriteUserCommand implements writing /proc/rd/cN/user_command.
+*/
+
+static int DAC960_ProcWriteUserCommand(struct file *file, const char *Buffer,
+				       unsigned long Count, void *Data)
+{
+  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
+  unsigned char CommandBuffer[80];
+  int Length;
+  if (Count > sizeof(CommandBuffer)-1) return -EINVAL;
+  if (copy_from_user(CommandBuffer, Buffer, Count)) return -EFAULT;
+  CommandBuffer[Count] = '\0';
+  Length = strlen(CommandBuffer);
+  if (CommandBuffer[Length-1] == '\n')
+    CommandBuffer[--Length] = '\0';
+  if (Controller->FirmwareType == DAC960_V1_Controller)
+    return (DAC960_V1_ExecuteUserCommand(Controller, CommandBuffer)
+	    ? Count : -EBUSY);
+  else
+    return (DAC960_V2_ExecuteUserCommand(Controller, CommandBuffer)
+	    ? Count : -EBUSY);
+}
+
+
+/*
+  DAC960_CreateProcEntries creates the /proc/rd/... entries for the
+  DAC960 Driver.
+*/
+
+static void DAC960_CreateProcEntries(DAC960_Controller_T *Controller)
+{
+	struct proc_dir_entry *StatusProcEntry;
+	struct proc_dir_entry *ControllerProcEntry;
+	struct proc_dir_entry *UserCommandProcEntry;
+
+	if (DAC960_ProcDirectoryEntry == NULL) {
+  		DAC960_ProcDirectoryEntry = proc_mkdir("rd", NULL);
+  		StatusProcEntry = create_proc_read_entry("status", 0,
+					   DAC960_ProcDirectoryEntry,
+					   DAC960_ProcReadStatus, NULL);
+	}
+
+      sprintf(Controller->ControllerName, "c%d", Controller->ControllerNumber);
+      ControllerProcEntry = proc_mkdir(Controller->ControllerName,
+				       DAC960_ProcDirectoryEntry);
+      create_proc_read_entry("initial_status", 0, ControllerProcEntry,
+			     DAC960_ProcReadInitialStatus, Controller);
+      create_proc_read_entry("current_status", 0, ControllerProcEntry,
+			     DAC960_ProcReadCurrentStatus, Controller);
+      UserCommandProcEntry =
+	create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
+			       ControllerProcEntry, DAC960_ProcReadUserCommand,
+			       Controller);
+      UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
+      Controller->ControllerProcEntry = ControllerProcEntry;
+}
+
+
+/*
+  DAC960_DestroyProcEntries destroys the /proc/rd/... entries for the
+  DAC960 Driver.
+*/
+
+static void DAC960_DestroyProcEntries(DAC960_Controller_T *Controller)
+{
+      if (Controller->ControllerProcEntry == NULL)
+	      return;
+      remove_proc_entry("initial_status", Controller->ControllerProcEntry);
+      remove_proc_entry("current_status", Controller->ControllerProcEntry);
+      remove_proc_entry("user_command", Controller->ControllerProcEntry);
+      remove_proc_entry(Controller->ControllerName, DAC960_ProcDirectoryEntry);
+      Controller->ControllerProcEntry = NULL;
+}
+
+#ifdef DAC960_GAM_MINOR
+
+/*
+ * DAC960_gam_ioctl is the ioctl function for performing RAID operations.
+*/
+
+static int DAC960_gam_ioctl(struct inode *inode, struct file *file,
+			    unsigned int Request, unsigned long Argument)
+{
+  int ErrorCode = 0;
+  if (!capable(CAP_SYS_ADMIN)) return -EACCES;
+  switch (Request)
+    {
+    case DAC960_IOCTL_GET_CONTROLLER_COUNT:
+      return DAC960_ControllerCount;
+    case DAC960_IOCTL_GET_CONTROLLER_INFO:
+      {
+	DAC960_ControllerInfo_T *UserSpaceControllerInfo =
+	  (DAC960_ControllerInfo_T *) Argument;
+	DAC960_ControllerInfo_T ControllerInfo;
+	DAC960_Controller_T *Controller;
+	int ControllerNumber;
+	if (UserSpaceControllerInfo == NULL) return -EINVAL;
+	ErrorCode = get_user(ControllerNumber,
+			     &UserSpaceControllerInfo->ControllerNumber);
+	if (ErrorCode != 0) return ErrorCode;
+	if (ControllerNumber < 0 ||
+	    ControllerNumber > DAC960_ControllerCount - 1)
+	  return -ENXIO;
+	Controller = DAC960_Controllers[ControllerNumber];
+	if (Controller == NULL) return -ENXIO;
+	memset(&ControllerInfo, 0, sizeof(DAC960_ControllerInfo_T));
+	ControllerInfo.ControllerNumber = ControllerNumber;
+	ControllerInfo.FirmwareType = Controller->FirmwareType;
+	ControllerInfo.Channels = Controller->Channels;
+	ControllerInfo.Targets = Controller->Targets;
+	ControllerInfo.PCI_Bus = Controller->Bus;
+	ControllerInfo.PCI_Device = Controller->Device;
+	ControllerInfo.PCI_Function = Controller->Function;
+	ControllerInfo.IRQ_Channel = Controller->IRQ_Channel;
+	ControllerInfo.PCI_Address = Controller->PCI_Address;
+	strcpy(ControllerInfo.ModelName, Controller->ModelName);
+	strcpy(ControllerInfo.FirmwareVersion, Controller->FirmwareVersion);
+	return (copy_to_user(UserSpaceControllerInfo, &ControllerInfo,
+			     sizeof(DAC960_ControllerInfo_T)) ? -EFAULT : 0);
+      }
+    case DAC960_IOCTL_V1_EXECUTE_COMMAND:
+      {
+	DAC960_V1_UserCommand_T *UserSpaceUserCommand =
+	  (DAC960_V1_UserCommand_T *) Argument;
+	DAC960_V1_UserCommand_T UserCommand;
+	DAC960_Controller_T *Controller;
+	DAC960_Command_T *Command = NULL;
+	DAC960_V1_CommandOpcode_T CommandOpcode;
+	DAC960_V1_CommandStatus_T CommandStatus;
+	DAC960_V1_DCDB_T DCDB;
+	DAC960_V1_DCDB_T *DCDB_IOBUF = NULL;
+	dma_addr_t	DCDB_IOBUFDMA;
+	unsigned long flags;
+	int ControllerNumber, DataTransferLength;
+	unsigned char *DataTransferBuffer = NULL;
+	dma_addr_t DataTransferBufferDMA;
+	if (UserSpaceUserCommand == NULL) return -EINVAL;
+	if (copy_from_user(&UserCommand, UserSpaceUserCommand,
+				   sizeof(DAC960_V1_UserCommand_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure1a;
+	}
+	ControllerNumber = UserCommand.ControllerNumber;
+	if (ControllerNumber < 0 ||
+	    ControllerNumber > DAC960_ControllerCount - 1)
+	  return -ENXIO;
+	Controller = DAC960_Controllers[ControllerNumber];
+	if (Controller == NULL) return -ENXIO;
+	if (Controller->FirmwareType != DAC960_V1_Controller) return -EINVAL;
+	CommandOpcode = UserCommand.CommandMailbox.Common.CommandOpcode;
+	DataTransferLength = UserCommand.DataTransferLength;
+	if (CommandOpcode & 0x80) return -EINVAL;
+	if (CommandOpcode == DAC960_V1_DCDB)
+	  {
+	    if (copy_from_user(&DCDB, UserCommand.DCDB,
+			       sizeof(DAC960_V1_DCDB_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure1a;
+	    }
+	    if (DCDB.Channel >= DAC960_V1_MaxChannels) return -EINVAL;
+	    if (!((DataTransferLength == 0 &&
+		   DCDB.Direction
+		   == DAC960_V1_DCDB_NoDataTransfer) ||
+		  (DataTransferLength > 0 &&
+		   DCDB.Direction
+		   == DAC960_V1_DCDB_DataTransferDeviceToSystem) ||
+		  (DataTransferLength < 0 &&
+		   DCDB.Direction
+		   == DAC960_V1_DCDB_DataTransferSystemToDevice)))
+	      return -EINVAL;
+	    if (((DCDB.TransferLengthHigh4 << 16) | DCDB.TransferLength)
+		!= abs(DataTransferLength))
+	      return -EINVAL;
+	    DCDB_IOBUF = pci_alloc_consistent(Controller->PCIDevice,
+			sizeof(DAC960_V1_DCDB_T), &DCDB_IOBUFDMA);
+	    if (DCDB_IOBUF == NULL)
+			return -ENOMEM;
+	  }
+	if (DataTransferLength > 0)
+	  {
+	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
+				DataTransferLength, &DataTransferBufferDMA);
+	    if (DataTransferBuffer == NULL) {
+		ErrorCode = -ENOMEM;
+		goto Failure1;
+	    }
+	    memset(DataTransferBuffer, 0, DataTransferLength);
+	  }
+	else if (DataTransferLength < 0)
+	  {
+	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
+				-DataTransferLength, &DataTransferBufferDMA);
+	    if (DataTransferBuffer == NULL) {
+		ErrorCode = -ENOMEM;
+		goto Failure1;
+	    }
+	    if (copy_from_user(DataTransferBuffer,
+			       UserCommand.DataTransferBuffer,
+			       -DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	    }
+	  }
+	if (CommandOpcode == DAC960_V1_DCDB)
+	  {
+	    spin_lock_irqsave(&Controller->queue_lock, flags);
+	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
+	      DAC960_WaitForCommand(Controller);
+	    while (Controller->V1.DirectCommandActive[DCDB.Channel]
+						     [DCDB.TargetID])
+	      {
+		spin_unlock_irq(&Controller->queue_lock);
+		__wait_event(Controller->CommandWaitQueue,
+			     !Controller->V1.DirectCommandActive
+					     [DCDB.Channel][DCDB.TargetID]);
+		spin_lock_irq(&Controller->queue_lock);
+	      }
+	    Controller->V1.DirectCommandActive[DCDB.Channel]
+					      [DCDB.TargetID] = true;
+	    spin_unlock_irqrestore(&Controller->queue_lock, flags);
+	    DAC960_V1_ClearCommand(Command);
+	    Command->CommandType = DAC960_ImmediateCommand;
+	    memcpy(&Command->V1.CommandMailbox, &UserCommand.CommandMailbox,
+		   sizeof(DAC960_V1_CommandMailbox_T));
+	    Command->V1.CommandMailbox.Type3.BusAddress = DCDB_IOBUFDMA;
+	    DCDB.BusAddress = DataTransferBufferDMA;
+	    memcpy(DCDB_IOBUF, &DCDB, sizeof(DAC960_V1_DCDB_T));
+	  }
+	else
+	  {
+	    spin_lock_irqsave(&Controller->queue_lock, flags);
+	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
+	      DAC960_WaitForCommand(Controller);
+	    spin_unlock_irqrestore(&Controller->queue_lock, flags);
+	    DAC960_V1_ClearCommand(Command);
+	    Command->CommandType = DAC960_ImmediateCommand;
+	    memcpy(&Command->V1.CommandMailbox, &UserCommand.CommandMailbox,
+		   sizeof(DAC960_V1_CommandMailbox_T));
+	    if (DataTransferBuffer != NULL)
+	      Command->V1.CommandMailbox.Type3.BusAddress =
+		DataTransferBufferDMA;
+	  }
+	DAC960_ExecuteCommand(Command);
+	CommandStatus = Command->V1.CommandStatus;
+	spin_lock_irqsave(&Controller->queue_lock, flags);
+	DAC960_DeallocateCommand(Command);
+	spin_unlock_irqrestore(&Controller->queue_lock, flags);
+	if (DataTransferLength > 0)
+	  {
+	    if (copy_to_user(UserCommand.DataTransferBuffer,
+			     DataTransferBuffer, DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+            }
+	  }
+	if (CommandOpcode == DAC960_V1_DCDB)
+	  {
+	    /*
+	      I don't believe Target or Channel in the DCDB_IOBUF
+	      should be any different from the contents of DCDB.
+	     */
+	    Controller->V1.DirectCommandActive[DCDB.Channel]
+					      [DCDB.TargetID] = false;
+	    if (copy_to_user(UserCommand.DCDB, DCDB_IOBUF,
+			     sizeof(DAC960_V1_DCDB_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure1;
+	    }
+	  }
+	ErrorCode = CommandStatus;
+      Failure1:
+	if (DataTransferBuffer != NULL)
+	  pci_free_consistent(Controller->PCIDevice, abs(DataTransferLength),
+			DataTransferBuffer, DataTransferBufferDMA);
+	if (DCDB_IOBUF != NULL)
+	  pci_free_consistent(Controller->PCIDevice, sizeof(DAC960_V1_DCDB_T),
+			DCDB_IOBUF, DCDB_IOBUFDMA);
+      Failure1a:
+	return ErrorCode;
+      }
+    case DAC960_IOCTL_V2_EXECUTE_COMMAND:
+      {
+	DAC960_V2_UserCommand_T *UserSpaceUserCommand =
+	  (DAC960_V2_UserCommand_T *) Argument;
+	DAC960_V2_UserCommand_T UserCommand;
+	DAC960_Controller_T *Controller;
+	DAC960_Command_T *Command = NULL;
+	DAC960_V2_CommandMailbox_T *CommandMailbox;
+	DAC960_V2_CommandStatus_T CommandStatus;
+	unsigned long flags;
+	int ControllerNumber, DataTransferLength;
+	int DataTransferResidue, RequestSenseLength;
+	unsigned char *DataTransferBuffer = NULL;
+	dma_addr_t DataTransferBufferDMA;
+	unsigned char *RequestSenseBuffer = NULL;
+	dma_addr_t RequestSenseBufferDMA;
+	if (UserSpaceUserCommand == NULL) return -EINVAL;
+	if (copy_from_user(&UserCommand, UserSpaceUserCommand,
+			   sizeof(DAC960_V2_UserCommand_T))) {
+		ErrorCode = -EFAULT;
+		goto Failure2a;
+	}
+	ControllerNumber = UserCommand.ControllerNumber;
+	if (ControllerNumber < 0 ||
+	    ControllerNumber > DAC960_ControllerCount - 1)
+	  return -ENXIO;
+	Controller = DAC960_Controllers[ControllerNumber];
+	if (Controller == NULL) return -ENXIO;
+	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
+	DataTransferLength = UserCommand.DataTransferLength;
+	if (DataTransferLength > 0)
+	  {
+	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
+				DataTransferLength, &DataTransferBufferDMA);
+	    if (DataTransferBuffer == NULL) return -ENOMEM;
+	    memset(DataTransferBuffer, 0, DataTransferLength);
+	  }
+	else if (DataTransferLength < 0)
+	  {
+	    DataTransferBuffer = pci_alloc_consistent(Controller->PCIDevice,
+				-DataTransferLength, &DataTransferBufferDMA);
+	    if (DataTransferBuffer == NULL) return -ENOMEM;
+	    if (copy_from_user(DataTransferBuffer,
+			       UserCommand.DataTransferBuffer,
+			       -DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	    }
+	  }
+	RequestSenseLength = UserCommand.RequestSenseLength;
+	if (RequestSenseLength > 0)
+	  {
+	    RequestSenseBuffer = pci_alloc_consistent(Controller->PCIDevice,
+			RequestSenseLength, &RequestSenseBufferDMA);
+	    if (RequestSenseBuffer == NULL)
+	      {
+		ErrorCode = -ENOMEM;
+		goto Failure2;
+	      }
+	    memset(RequestSenseBuffer, 0, RequestSenseLength);
+	  }
+	spin_lock_irqsave(&Controller->queue_lock, flags);
+	while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
+	  DAC960_WaitForCommand(Controller);
+	spin_unlock_irqrestore(&Controller->queue_lock, flags);
+	DAC960_V2_ClearCommand(Command);
+	Command->CommandType = DAC960_ImmediateCommand;
+	CommandMailbox = &Command->V2.CommandMailbox;
+	memcpy(CommandMailbox, &UserCommand.CommandMailbox,
+	       sizeof(DAC960_V2_CommandMailbox_T));
+	CommandMailbox->Common.CommandControlBits
+			      .AdditionalScatterGatherListMemory = false;
+	CommandMailbox->Common.CommandControlBits
+			      .NoAutoRequestSense = true;
+	CommandMailbox->Common.DataTransferSize = 0;
+	CommandMailbox->Common.DataTransferPageNumber = 0;
+	memset(&CommandMailbox->Common.DataTransferMemoryAddress, 0,
+	       sizeof(DAC960_V2_DataTransferMemoryAddress_T));
+	if (DataTransferLength != 0)
+	  {
+	    if (DataTransferLength > 0)
+	      {
+		CommandMailbox->Common.CommandControlBits
+				      .DataTransferControllerToHost = true;
+		CommandMailbox->Common.DataTransferSize = DataTransferLength;
+	      }
+	    else
+	      {
+		CommandMailbox->Common.CommandControlBits
+				      .DataTransferControllerToHost = false;
+		CommandMailbox->Common.DataTransferSize = -DataTransferLength;
+	      }
+	    CommandMailbox->Common.DataTransferMemoryAddress
+				  .ScatterGatherSegments[0]
+				  .SegmentDataPointer = DataTransferBufferDMA;
+	    CommandMailbox->Common.DataTransferMemoryAddress
+				  .ScatterGatherSegments[0]
+				  .SegmentByteCount =
+	      CommandMailbox->Common.DataTransferSize;
+	  }
+	if (RequestSenseLength > 0)
+	  {
+	    CommandMailbox->Common.CommandControlBits
+				  .NoAutoRequestSense = false;
+	    CommandMailbox->Common.RequestSenseSize = RequestSenseLength;
+	    CommandMailbox->Common.RequestSenseBusAddress =
+	      						RequestSenseBufferDMA;
+	  }
+	DAC960_ExecuteCommand(Command);
+	CommandStatus = Command->V2.CommandStatus;
+	RequestSenseLength = Command->V2.RequestSenseLength;
+	DataTransferResidue = Command->V2.DataTransferResidue;
+	spin_lock_irqsave(&Controller->queue_lock, flags);
+	DAC960_DeallocateCommand(Command);
+	spin_unlock_irqrestore(&Controller->queue_lock, flags);
+	if (RequestSenseLength > UserCommand.RequestSenseLength)
+	  RequestSenseLength = UserCommand.RequestSenseLength;
+	if (copy_to_user(&UserSpaceUserCommand->DataTransferLength,
+				 &DataTransferResidue,
+				 sizeof(DataTransferResidue))) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	}
+	if (copy_to_user(&UserSpaceUserCommand->RequestSenseLength,
+			 &RequestSenseLength, sizeof(RequestSenseLength))) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
 	}
-      Controller->LastCurrentStatusTime = jiffies;
-    }
-  BytesAvailable = Controller->CurrentStatusLength - Offset;
-  if (Count >= BytesAvailable)
-    {
-      Count = BytesAvailable;
-      *EOF = true;
+	if (DataTransferLength > 0)
+	  {
+	    if (copy_to_user(UserCommand.DataTransferBuffer,
+			     DataTransferBuffer, DataTransferLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	    }
+	  }
+	if (RequestSenseLength > 0)
+	  {
+	    if (copy_to_user(UserCommand.RequestSenseBuffer,
+			     RequestSenseBuffer, RequestSenseLength)) {
+		ErrorCode = -EFAULT;
+		goto Failure2;
+	    }
+	  }
+	ErrorCode = CommandStatus;
+      Failure2:
+	  pci_free_consistent(Controller->PCIDevice, abs(DataTransferLength),
+		DataTransferBuffer, DataTransferBufferDMA);
+	if (RequestSenseBuffer != NULL)
+	  pci_free_consistent(Controller->PCIDevice, RequestSenseLength,
+		RequestSenseBuffer, RequestSenseBufferDMA);
+      Failure2a:
+	return ErrorCode;
+      }
+    case DAC960_IOCTL_V2_GET_HEALTH_STATUS:
+      {
+	DAC960_V2_GetHealthStatus_T *UserSpaceGetHealthStatus =
+	  (DAC960_V2_GetHealthStatus_T *) Argument;
+	DAC960_V2_GetHealthStatus_T GetHealthStatus;
+	DAC960_V2_HealthStatusBuffer_T HealthStatusBuffer;
+	DAC960_Controller_T *Controller;
+	int ControllerNumber;
+	if (UserSpaceGetHealthStatus == NULL) return -EINVAL;
+	if (copy_from_user(&GetHealthStatus, UserSpaceGetHealthStatus,
+			   sizeof(DAC960_V2_GetHealthStatus_T)))
+		return -EFAULT;
+	ControllerNumber = GetHealthStatus.ControllerNumber;
+	if (ControllerNumber < 0 ||
+	    ControllerNumber > DAC960_ControllerCount - 1)
+	  return -ENXIO;
+	Controller = DAC960_Controllers[ControllerNumber];
+	if (Controller == NULL) return -ENXIO;
+	if (Controller->FirmwareType != DAC960_V2_Controller) return -EINVAL;
+	if (copy_from_user(&HealthStatusBuffer,
+			   GetHealthStatus.HealthStatusBuffer,
+			   sizeof(DAC960_V2_HealthStatusBuffer_T)))
+		return -EFAULT;
+	while (Controller->V2.HealthStatusBuffer->StatusChangeCounter
+	       == HealthStatusBuffer.StatusChangeCounter &&
+	       Controller->V2.HealthStatusBuffer->NextEventSequenceNumber
+	       == HealthStatusBuffer.NextEventSequenceNumber)
+	  {
+	    interruptible_sleep_on_timeout(&Controller->HealthStatusWaitQueue,
+					   DAC960_MonitoringTimerInterval);
+	    if (signal_pending(current)) return -EINTR;
+	  }
+	if (copy_to_user(GetHealthStatus.HealthStatusBuffer,
+			 Controller->V2.HealthStatusBuffer,
+			 sizeof(DAC960_V2_HealthStatusBuffer_T)))
+		return -EFAULT;
+	return 0;
+      }
     }
-  if (Count <= 0) return 0;
-  *Start = Page;
-  memcpy(Page, &Controller->CurrentStatusBuffer[Offset], Count);
-  return Count;
+  return -EINVAL;
 }
 
+static struct file_operations DAC960_gam_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= DAC960_gam_ioctl
+};
 
-/*
-  DAC960_ProcReadUserCommand implements reading /proc/rd/cN/user_command.
-*/
+static struct miscdevice DAC960_gam_dev = {
+	DAC960_GAM_MINOR,
+	"dac960_gam",
+	&DAC960_gam_fops
+};
 
-static int DAC960_ProcReadUserCommand(char *Page, char **Start, off_t Offset,
-				      int Count, int *EOF, void *Data)
+static int DAC960_gam_init(void)
 {
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
-  int BytesAvailable = Controller->UserStatusLength - Offset;
-  if (Count >= BytesAvailable)
-    {
-      Count = BytesAvailable;
-      *EOF = true;
-    }
-  if (Count <= 0) return 0;
-  *Start = Page;
-  memcpy(Page, &Controller->UserStatusBuffer[Offset], Count);
-  return Count;
-}
-
-
-/*
-  DAC960_ProcWriteUserCommand implements writing /proc/rd/cN/user_command.
-*/
+	int ret;
 
-static int DAC960_ProcWriteUserCommand(struct file *file, const char *Buffer,
-				       unsigned long Count, void *Data)
-{
-  DAC960_Controller_T *Controller = (DAC960_Controller_T *) Data;
-  unsigned char CommandBuffer[80];
-  int Length;
-  if (Count > sizeof(CommandBuffer)-1) return -EINVAL;
-  if (copy_from_user(CommandBuffer, Buffer, Count)) return -EFAULT;
-  CommandBuffer[Count] = '\0';
-  Length = strlen(CommandBuffer);
-  if (CommandBuffer[Length-1] == '\n')
-    CommandBuffer[--Length] = '\0';
-  if (Controller->FirmwareType == DAC960_V1_Controller)
-    return (DAC960_V1_ExecuteUserCommand(Controller, CommandBuffer)
-	    ? Count : -EBUSY);
-  else
-    return (DAC960_V2_ExecuteUserCommand(Controller, CommandBuffer)
-	    ? Count : -EBUSY);
+	ret = misc_register(&DAC960_gam_dev);
+	if (ret)
+		printk(KERN_ERR "DAC960_gam: can't misc_register on minor %d\n", DAC960_GAM_MINOR);
+	return ret;
 }
 
-
-/*
-  DAC960_CreateProcEntries creates the /proc/rd/... entries for the
-  DAC960 Driver.
-*/
-
-static void DAC960_CreateProcEntries(DAC960_Controller_T *Controller)
+static void DAC960_gam_cleanup(void)
 {
-	struct proc_dir_entry *StatusProcEntry;
-	struct proc_dir_entry *ControllerProcEntry;
-	struct proc_dir_entry *UserCommandProcEntry;
-
-	if (DAC960_ProcDirectoryEntry == NULL) {
-  		DAC960_ProcDirectoryEntry = proc_mkdir("rd", NULL);
-  		StatusProcEntry = create_proc_read_entry("status", 0,
-					   DAC960_ProcDirectoryEntry,
-					   DAC960_ProcReadStatus, NULL);
-	}
-
-      sprintf(Controller->ControllerName, "c%d", Controller->ControllerNumber);
-      ControllerProcEntry = proc_mkdir(Controller->ControllerName,
-				       DAC960_ProcDirectoryEntry);
-      create_proc_read_entry("initial_status", 0, ControllerProcEntry,
-			     DAC960_ProcReadInitialStatus, Controller);
-      create_proc_read_entry("current_status", 0, ControllerProcEntry,
-			     DAC960_ProcReadCurrentStatus, Controller);
-      UserCommandProcEntry =
-	create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
-			       ControllerProcEntry, DAC960_ProcReadUserCommand,
-			       Controller);
-      UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
-      Controller->ControllerProcEntry = ControllerProcEntry;
+	misc_deregister(&DAC960_gam_dev);
 }
 
-
-/*
-  DAC960_DestroyProcEntries destroys the /proc/rd/... entries for the
-  DAC960 Driver.
-*/
-
-static void DAC960_DestroyProcEntries(DAC960_Controller_T *Controller)
-{
-      if (Controller->ControllerProcEntry == NULL)
-	      return;
-      remove_proc_entry("initial_status", Controller->ControllerProcEntry);
-      remove_proc_entry("current_status", Controller->ControllerProcEntry);
-      remove_proc_entry("user_command", Controller->ControllerProcEntry);
-      remove_proc_entry(Controller->ControllerName, DAC960_ProcDirectoryEntry);
-      Controller->ControllerProcEntry = NULL;
-}
+#endif /* DAC960_GAM_MINOR */
 
 static struct DAC960_privdata DAC960_BA_privdata = {
 	.HardwareType =		DAC960_BA_Controller,
@@ -7000,13 +7025,24 @@
 
 static int DAC960_init_module(void)
 {
-	return pci_module_init(&DAC960_pci_driver);
+	int ret;
+
+	ret =  pci_module_init(&DAC960_pci_driver);
+#ifdef DAC960_GAM_MINOR
+	if (!ret)
+		DAC960_gam_init();
+#endif
+	return ret;
 }
 
 static void DAC960_cleanup_module(void)
 {
 	int i;
 
+#ifdef DAC960_GAM_MINOR
+	DAC960_gam_cleanup();
+#endif
+
 	for (i = 0; i < DAC960_ControllerCount; i++) {
 		DAC960_Controller_T *Controller = DAC960_Controllers[i];
 		if (Controller == NULL)
diff -ur linux-2.5.60-test3-mm2_original/drivers/block/DAC960.h linux-2.6.0-test3-mm2_DAC/drivers/block/DAC960.h
--- linux-2.5.60-test3-mm2_original/drivers/block/DAC960.h	2003-08-18 21:56:52.000000000 -0700
+++ linux-2.6.0-test3-mm2_DAC/drivers/block/DAC960.h	2003-08-18 17:01:49.000000000 -0700
@@ -4138,8 +4138,6 @@
 static void DAC960_V1_QueueMonitoringCommand(DAC960_Command_T *);
 static void DAC960_V2_QueueMonitoringCommand(DAC960_Command_T *);
 static void DAC960_MonitoringTimerFunction(unsigned long);
-static int DAC960_UserIOCTL(struct inode *, struct file *,
-			    unsigned int, unsigned long);
 static void DAC960_Message(DAC960_MessageLevel_T, unsigned char *,
 			   DAC960_Controller_T *, ...);
 static void DAC960_CreateProcEntries(DAC960_Controller_T *);

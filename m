Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVDYOTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVDYOTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVDYOTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:19:01 -0400
Received: from verein.lst.de ([213.95.11.210]:25025 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262616AbVDYORr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:17:47 -0400
Date: Mon, 25 Apr 2005 16:17:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: dmo@osdl.org
Cc: anders@norrbring.se, linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960: add support for Mylex AcceleRAID 4/5/600
Message-ID: <20050425141738.GA2749@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a new class of DAC960 controllers.  It's
based on the GPLed idac320 driver from IBM for Linux 2.4.18.  That
driver is a fork of the 2.4.18 version of DAC960 that adds support for
this new type of controllers (internally called "GEM Series"), that
differ from other DAC960 V2 firmware controllers only in the register
offsets and removes support for all others.

This patch instead integrates support for these controllers into the
DAC960 driver.

Thanks to Anders Norrbring for pointing me to the idac320 driver and
testing this patch.

No Signed-Off: line because all code is either copy & pasted from IBM's
idac320 driver or support for other controllers in the 2.6 DAC960
driver.

Note: the really odd formating matches the rest of the DAC960 driver.


--- 1.77/drivers/block/DAC960.c	2005-03-29 00:21:44 +02:00
+++ edited/drivers/block/DAC960.c	2005-04-25 16:00:01 +02:00
@@ -3,6 +3,7 @@
   Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
 
   Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
+  Portions Copyright 2002 by Mylex (An IBM Business Unit)
 
   This program is free software; you may redistribute and/or modify it under
   the terms of the GNU General Public License Version 2 as published by the
@@ -532,6 +533,34 @@
   spin_lock_irq(&Controller->queue_lock);
 }
 
+/*
+  DAC960_GEM_QueueCommand queues Command for DAC960 GEM Series Controllers.
+*/
+
+static void DAC960_GEM_QueueCommand(DAC960_Command_T *Command)
+{
+  DAC960_Controller_T *Controller = Command->Controller;
+  void __iomem *ControllerBaseAddress = Controller->BaseAddress;
+  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  DAC960_V2_CommandMailbox_T *NextCommandMailbox =
+      Controller->V2.NextCommandMailbox;
+    
+  CommandMailbox->Common.CommandIdentifier = Command->CommandIdentifier;
+  DAC960_GEM_WriteCommandMailbox(NextCommandMailbox, CommandMailbox);
+    
+  if (Controller->V2.PreviousCommandMailbox1->Words[0] == 0 ||
+      Controller->V2.PreviousCommandMailbox2->Words[0] == 0)
+      DAC960_GEM_MemoryMailboxNewCommand(ControllerBaseAddress);
+        
+  Controller->V2.PreviousCommandMailbox2 =
+      Controller->V2.PreviousCommandMailbox1;
+  Controller->V2.PreviousCommandMailbox1 = NextCommandMailbox;
+
+  if (++NextCommandMailbox > Controller->V2.LastCommandMailbox)
+      NextCommandMailbox = Controller->V2.FirstCommandMailbox;
+
+  Controller->V2.NextCommandMailbox = NextCommandMailbox;
+}
 
 /*
   DAC960_BA_QueueCommand queues Command for DAC960 BA Series Controllers.
@@ -1464,6 +1493,17 @@
     					Controller->V2.FirstStatusMailboxDMA;
   switch (Controller->HardwareType)
     {
+    case DAC960_GEM_Controller:
+      while (DAC960_GEM_HardwareMailboxFullP(ControllerBaseAddress))
+	udelay(1);
+      DAC960_GEM_WriteHardwareMailbox(ControllerBaseAddress, CommandMailboxDMA);
+      DAC960_GEM_HardwareMailboxNewCommand(ControllerBaseAddress);
+      while (!DAC960_GEM_HardwareMailboxStatusAvailableP(ControllerBaseAddress))
+	udelay(1);
+      CommandStatus = DAC960_GEM_ReadCommandStatus(ControllerBaseAddress);
+      DAC960_GEM_AcknowledgeHardwareMailboxInterrupt(ControllerBaseAddress);
+      DAC960_GEM_AcknowledgeHardwareMailboxStatus(ControllerBaseAddress);
+      break;
     case DAC960_BA_Controller:
       while (DAC960_BA_HardwareMailboxFullP(ControllerBaseAddress))
 	udelay(1);
@@ -2627,6 +2667,9 @@
   if (Controller->MemoryMappedAddress) {
   	switch(Controller->HardwareType)
   	{
+		case DAC960_GEM_Controller:
+			DAC960_GEM_DisableInterrupts(Controller->BaseAddress);
+			break;
 		case DAC960_BA_Controller:
 			DAC960_BA_DisableInterrupts(Controller->BaseAddress);
 			break;
@@ -2705,6 +2748,9 @@
 
   switch (Controller->HardwareType)
   {
+	case DAC960_GEM_Controller:
+	  Controller->PCI_Address = pci_resource_start(PCI_Device, 0);
+	  break;
 	case DAC960_BA_Controller:
 	  Controller->PCI_Address = pci_resource_start(PCI_Device, 0);
 	  break;
@@ -2756,6 +2802,36 @@
   BaseAddress = Controller->BaseAddress;
   switch (Controller->HardwareType)
   {
+	case DAC960_GEM_Controller:
+	  DAC960_GEM_DisableInterrupts(BaseAddress);
+	  DAC960_GEM_AcknowledgeHardwareMailboxStatus(BaseAddress);
+	  udelay(1000);
+	  while (DAC960_GEM_InitializationInProgressP(BaseAddress))
+	    {
+	      if (DAC960_GEM_ReadErrorStatus(BaseAddress, &ErrorStatus,
+					    &Parameter0, &Parameter1) &&
+		  DAC960_ReportErrorStatus(Controller, ErrorStatus,
+					   Parameter0, Parameter1))
+		goto Failure;
+	      udelay(10);
+	    }
+	  if (!DAC960_V2_EnableMemoryMailboxInterface(Controller))
+	    {
+	      DAC960_Error("Unable to Enable Memory Mailbox Interface "
+			   "for Controller at\n", Controller);
+	      goto Failure;
+	    }
+	  DAC960_GEM_EnableInterrupts(BaseAddress);
+	  Controller->QueueCommand = DAC960_GEM_QueueCommand;
+	  Controller->ReadControllerConfiguration =
+	    DAC960_V2_ReadControllerConfiguration;
+	  Controller->ReadDeviceConfiguration =
+	    DAC960_V2_ReadDeviceConfiguration;
+	  Controller->ReportDeviceConfiguration =
+	    DAC960_V2_ReportDeviceConfiguration;
+	  Controller->QueueReadWriteCommand =
+	    DAC960_V2_QueueReadWriteCommand;
+	  break;
 	case DAC960_BA_Controller:
 	  DAC960_BA_DisableInterrupts(BaseAddress);
 	  DAC960_BA_AcknowledgeHardwareMailboxStatus(BaseAddress);
@@ -5189,6 +5265,47 @@
   wake_up(&Controller->CommandWaitQueue);
 }
 
+/*
+  DAC960_GEM_InterruptHandler handles hardware interrupts from DAC960 GEM Series
+  Controllers.
+*/
+
+static irqreturn_t DAC960_GEM_InterruptHandler(int IRQ_Channel,
+				       void *DeviceIdentifier,
+				       struct pt_regs *InterruptRegisters)
+{
+  DAC960_Controller_T *Controller = (DAC960_Controller_T *) DeviceIdentifier;
+  void __iomem *ControllerBaseAddress = Controller->BaseAddress;
+  DAC960_V2_StatusMailbox_T *NextStatusMailbox;
+  unsigned long flags;
+
+  spin_lock_irqsave(&Controller->queue_lock, flags);
+  DAC960_GEM_AcknowledgeInterrupt(ControllerBaseAddress);
+  NextStatusMailbox = Controller->V2.NextStatusMailbox;
+  while (NextStatusMailbox->Fields.CommandIdentifier > 0)
+    {
+       DAC960_V2_CommandIdentifier_T CommandIdentifier =
+           NextStatusMailbox->Fields.CommandIdentifier;
+       DAC960_Command_T *Command = Controller->Commands[CommandIdentifier-1];
+       Command->V2.CommandStatus = NextStatusMailbox->Fields.CommandStatus;
+       Command->V2.RequestSenseLength =
+           NextStatusMailbox->Fields.RequestSenseLength;
+       Command->V2.DataTransferResidue =
+           NextStatusMailbox->Fields.DataTransferResidue;
+       NextStatusMailbox->Words[0] = 0;
+       if (++NextStatusMailbox > Controller->V2.LastStatusMailbox)
+           NextStatusMailbox = Controller->V2.FirstStatusMailbox;
+       DAC960_V2_ProcessCompletedCommand(Command);
+    }
+  Controller->V2.NextStatusMailbox = NextStatusMailbox;
+  /*
+    Attempt to remove additional I/O Requests from the Controller's
+    I/O Request Queue and queue them to the Controller.
+  */
+  DAC960_ProcessRequest(Controller);
+  spin_unlock_irqrestore(&Controller->queue_lock, flags);
+  return IRQ_HANDLED;
+}
 
 /*
   DAC960_BA_InterruptHandler handles hardware interrupts from DAC960 BA Series
@@ -6962,6 +7079,14 @@
 
 #endif /* DAC960_GAM_MINOR */
 
+static struct DAC960_privdata DAC960_GEM_privdata = {
+	.HardwareType =		DAC960_GEM_Controller,
+	.FirmwareType 	=	DAC960_V2_Controller,
+	.InterruptHandler =	DAC960_GEM_InterruptHandler,
+	.MemoryWindowSize =	DAC960_GEM_RegisterWindowSize,
+};
+
+
 static struct DAC960_privdata DAC960_BA_privdata = {
 	.HardwareType =		DAC960_BA_Controller,
 	.FirmwareType 	=	DAC960_V2_Controller,
@@ -7005,6 +7130,13 @@
 };
 
 static struct pci_device_id DAC960_id_table[] = {
+	{
+		.vendor 	= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_GEM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_GEM_privdata,
+	},
 	{
 		.vendor 	= PCI_VENDOR_ID_MYLEX,
 		.device		= PCI_DEVICE_ID_MYLEX_DAC960_BA,
--- 1.29/drivers/block/DAC960.h	2004-10-05 21:57:23 +02:00
+++ edited/drivers/block/DAC960.h	2005-04-25 16:04:52 +02:00
@@ -2114,7 +2114,8 @@
   DAC960_LA_Controller =			3,	/* DAC1164P */
   DAC960_PG_Controller =			4,	/* DAC960PTL/PJ/PG */
   DAC960_PD_Controller =			5,	/* DAC960PU/PD/PL/P */
-  DAC960_P_Controller =				6	/* DAC960PU/PD/PL/P */
+  DAC960_P_Controller =				6,	/* DAC960PU/PD/PL/P */
+  DAC960_GEM_Controller =			7,	/* AcceleRAID 4/5/600 */
 }
 DAC960_HardwareType_T;
 
@@ -2541,6 +2542,320 @@
 }
 
 /*
+  Define the DAC960 GEM Series Controller Interface Register Offsets.
+ */
+
+#define DAC960_GEM_RegisterWindowSize	0x600
+
+typedef enum
+{
+  DAC960_GEM_InboundDoorBellRegisterReadSetOffset   =   0x214,
+  DAC960_GEM_InboundDoorBellRegisterClearOffset     =   0x218,
+  DAC960_GEM_OutboundDoorBellRegisterReadSetOffset  =   0x224,
+  DAC960_GEM_OutboundDoorBellRegisterClearOffset    =   0x228,
+  DAC960_GEM_InterruptStatusRegisterOffset          =   0x208,
+  DAC960_GEM_InterruptMaskRegisterReadSetOffset     =   0x22C,
+  DAC960_GEM_InterruptMaskRegisterClearOffset       =   0x230,
+  DAC960_GEM_CommandMailboxBusAddressOffset         =   0x510,
+  DAC960_GEM_CommandStatusOffset                    =   0x518,
+  DAC960_GEM_ErrorStatusRegisterReadSetOffset       =   0x224,
+  DAC960_GEM_ErrorStatusRegisterClearOffset         =   0x228,
+}
+DAC960_GEM_RegisterOffsets_T;
+
+/*
+  Define the structure of the DAC960 GEM Series Inbound Door Bell
+ */
+
+typedef union DAC960_GEM_InboundDoorBellRegister
+{
+  unsigned int All;
+  struct {
+    unsigned int :24;
+    boolean HardwareMailboxNewCommand:1;
+    boolean AcknowledgeHardwareMailboxStatus:1;
+    boolean GenerateInterrupt:1;
+    boolean ControllerReset:1;
+    boolean MemoryMailboxNewCommand:1;
+    unsigned int :3;
+  } Write;
+  struct {
+    unsigned int :24;
+    boolean HardwareMailboxFull:1;
+    boolean InitializationInProgress:1;
+    unsigned int :6;
+  } Read;
+}
+DAC960_GEM_InboundDoorBellRegister_T;
+
+/*
+  Define the structure of the DAC960 GEM Series Outbound Door Bell Register.
+ */
+typedef union DAC960_GEM_OutboundDoorBellRegister
+{
+  unsigned int All;
+  struct {
+    unsigned int :24;
+    boolean AcknowledgeHardwareMailboxInterrupt:1;
+    boolean AcknowledgeMemoryMailboxInterrupt:1;
+    unsigned int :6;
+  } Write;
+  struct {
+    unsigned int :24;
+    boolean HardwareMailboxStatusAvailable:1;
+    boolean MemoryMailboxStatusAvailable:1;
+    unsigned int :6;
+  } Read;
+}
+DAC960_GEM_OutboundDoorBellRegister_T;
+
+/*
+  Define the structure of the DAC960 GEM Series Interrupt Mask Register.
+ */
+typedef union DAC960_GEM_InterruptMaskRegister
+{
+  unsigned int All;
+  struct {
+    unsigned int :16;
+    unsigned int :8;
+    unsigned int HardwareMailboxInterrupt:1;
+    unsigned int MemoryMailboxInterrupt:1;
+    unsigned int :6;
+  } Bits;
+}
+DAC960_GEM_InterruptMaskRegister_T;
+
+/*
+  Define the structure of the DAC960 GEM Series Error Status Register.
+ */
+
+typedef union DAC960_GEM_ErrorStatusRegister
+{
+  unsigned int All;
+  struct {
+    unsigned int :24;
+    unsigned int :5;
+    boolean ErrorStatusPending:1;
+    unsigned int :2;
+  } Bits;
+}
+DAC960_GEM_ErrorStatusRegister_T;
+
+/*
+  Define inline functions to provide an abstraction for reading and writing the
+  DAC960 GEM Series Controller Interface Registers.
+*/
+
+static inline
+void DAC960_GEM_HardwareMailboxNewCommand(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All = 0;
+  InboundDoorBellRegister.Write.HardwareMailboxNewCommand = true;
+  writel(InboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+void DAC960_GEM_AcknowledgeHardwareMailboxStatus(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All = 0;
+  InboundDoorBellRegister.Write.AcknowledgeHardwareMailboxStatus = true;
+  writel(InboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InboundDoorBellRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_GenerateInterrupt(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All = 0;
+  InboundDoorBellRegister.Write.GenerateInterrupt = true;
+  writel(InboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+void DAC960_GEM_ControllerReset(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All = 0;
+  InboundDoorBellRegister.Write.ControllerReset = true;
+  writel(InboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+void DAC960_GEM_MemoryMailboxNewCommand(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All = 0;
+  InboundDoorBellRegister.Write.MemoryMailboxNewCommand = true;
+  writel(InboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+boolean DAC960_GEM_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All =
+    readl(ControllerBaseAddress +
+          DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+  return InboundDoorBellRegister.Read.HardwareMailboxFull;
+}
+
+static inline
+boolean DAC960_GEM_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
+  InboundDoorBellRegister.All =
+    readl(ControllerBaseAddress +
+          DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+  return InboundDoorBellRegister.Read.InitializationInProgress;
+}
+
+static inline
+void DAC960_GEM_AcknowledgeHardwareMailboxInterrupt(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
+  OutboundDoorBellRegister.All = 0;
+  OutboundDoorBellRegister.Write.AcknowledgeHardwareMailboxInterrupt = true;
+  writel(OutboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_OutboundDoorBellRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_AcknowledgeMemoryMailboxInterrupt(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
+  OutboundDoorBellRegister.All = 0;
+  OutboundDoorBellRegister.Write.AcknowledgeMemoryMailboxInterrupt = true;
+  writel(OutboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_OutboundDoorBellRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
+  OutboundDoorBellRegister.All = 0;
+  OutboundDoorBellRegister.Write.AcknowledgeHardwareMailboxInterrupt = true;
+  OutboundDoorBellRegister.Write.AcknowledgeMemoryMailboxInterrupt = true;
+  writel(OutboundDoorBellRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_OutboundDoorBellRegisterClearOffset);
+}
+
+static inline
+boolean DAC960_GEM_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
+  OutboundDoorBellRegister.All =
+    readl(ControllerBaseAddress +
+          DAC960_GEM_OutboundDoorBellRegisterReadSetOffset);
+  return OutboundDoorBellRegister.Read.HardwareMailboxStatusAvailable;
+}
+
+static inline
+boolean DAC960_GEM_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
+  OutboundDoorBellRegister.All =
+    readl(ControllerBaseAddress +
+          DAC960_GEM_OutboundDoorBellRegisterReadSetOffset);
+  return OutboundDoorBellRegister.Read.MemoryMailboxStatusAvailable;
+}
+
+static inline
+void DAC960_GEM_EnableInterrupts(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InterruptMaskRegister_T InterruptMaskRegister;
+  InterruptMaskRegister.All = 0;
+  InterruptMaskRegister.Bits.HardwareMailboxInterrupt = true;
+  InterruptMaskRegister.Bits.MemoryMailboxInterrupt = true;
+  writel(InterruptMaskRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InterruptMaskRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_DisableInterrupts(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InterruptMaskRegister_T InterruptMaskRegister;
+  InterruptMaskRegister.All = 0;
+  InterruptMaskRegister.Bits.HardwareMailboxInterrupt = true;
+  InterruptMaskRegister.Bits.MemoryMailboxInterrupt = true;
+  writel(InterruptMaskRegister.All,
+	 ControllerBaseAddress + DAC960_GEM_InterruptMaskRegisterReadSetOffset);
+}
+
+static inline
+boolean DAC960_GEM_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+{
+  DAC960_GEM_InterruptMaskRegister_T InterruptMaskRegister;
+  InterruptMaskRegister.All =
+    readl(ControllerBaseAddress +
+          DAC960_GEM_InterruptMaskRegisterReadSetOffset);
+  return !(InterruptMaskRegister.Bits.HardwareMailboxInterrupt ||
+           InterruptMaskRegister.Bits.MemoryMailboxInterrupt);
+}
+
+static inline
+void DAC960_GEM_WriteCommandMailbox(DAC960_V2_CommandMailbox_T
+				     *MemoryCommandMailbox,
+				   DAC960_V2_CommandMailbox_T
+				     *CommandMailbox)
+{
+  memcpy(&MemoryCommandMailbox->Words[1], &CommandMailbox->Words[1],
+	 sizeof(DAC960_V2_CommandMailbox_T) - sizeof(unsigned int));
+  wmb();
+  MemoryCommandMailbox->Words[0] = CommandMailbox->Words[0];
+  mb();
+}
+
+static inline
+void DAC960_GEM_WriteHardwareMailbox(void __iomem *ControllerBaseAddress,
+				    dma_addr_t CommandMailboxDMA)
+{
+	dma_addr_writeql(CommandMailboxDMA,
+		ControllerBaseAddress +
+		DAC960_GEM_CommandMailboxBusAddressOffset);
+}
+
+static inline DAC960_V2_CommandIdentifier_T
+DAC960_GEM_ReadCommandIdentifier(void __iomem *ControllerBaseAddress)
+{
+  return readw(ControllerBaseAddress + DAC960_GEM_CommandStatusOffset);
+}
+
+static inline DAC960_V2_CommandStatus_T
+DAC960_GEM_ReadCommandStatus(void __iomem *ControllerBaseAddress)
+{
+  return readw(ControllerBaseAddress + DAC960_GEM_CommandStatusOffset + 2);
+}
+
+static inline boolean
+DAC960_GEM_ReadErrorStatus(void __iomem *ControllerBaseAddress,
+			  unsigned char *ErrorStatus,
+			  unsigned char *Parameter0,
+			  unsigned char *Parameter1)
+{
+  DAC960_GEM_ErrorStatusRegister_T ErrorStatusRegister;
+  ErrorStatusRegister.All =
+    readl(ControllerBaseAddress + DAC960_GEM_ErrorStatusRegisterReadSetOffset);
+  if (!ErrorStatusRegister.Bits.ErrorStatusPending) return false;
+  ErrorStatusRegister.Bits.ErrorStatusPending = false;
+  *ErrorStatus = ErrorStatusRegister.All;
+  *Parameter0 =
+    readb(ControllerBaseAddress + DAC960_GEM_CommandMailboxBusAddressOffset + 0);
+  *Parameter1 =
+    readb(ControllerBaseAddress + DAC960_GEM_CommandMailboxBusAddressOffset + 1);
+  writel(0x03000000, ControllerBaseAddress +
+         DAC960_GEM_ErrorStatusRegisterClearOffset);
+  return true;
+}
+
+/*
   Define the DAC960 BA Series Controller Interface Register Offsets.
 */
 
--- 1.211/include/linux/pci_ids.h	2005-04-01 22:22:02 +02:00
+++ edited/include/linux/pci_ids.h	2005-04-25 15:54:03 +02:00
@@ -854,6 +854,7 @@
 #define PCI_DEVICE_ID_MYLEX_DAC960_LA	0x0020
 #define PCI_DEVICE_ID_MYLEX_DAC960_LP	0x0050
 #define PCI_DEVICE_ID_MYLEX_DAC960_BA	0xBA56
+#define PCI_DEVICE_ID_MYLEX_DAC960_GEM	0xB166
 
 #define PCI_VENDOR_ID_PICOP		0x1066
 #define PCI_DEVICE_ID_PICOP_PT86C52X	0x0001

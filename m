Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131729AbRCXRoa>; Sat, 24 Mar 2001 12:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131732AbRCXRoW>; Sat, 24 Mar 2001 12:44:22 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:28107 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131729AbRCXRoJ>; Sat, 24 Mar 2001 12:44:09 -0500
Message-ID: <3ABCDD22.5A568CD1@uow.edu.au>
Date: Sun, 25 Mar 2001 03:45:06 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-janitor-discuss@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
CC: Andrew Grover <andrew.grover@intel.com>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>
Subject: [patch] [checker] 120 potential dereference to invalid pointers errors 
 for linux 2.4.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets us about 1/3 of the way through this one.

Affected files:

fs/proc/generic.c
arch/i386/kernel/irq.c
arch/i386/kernel/mtrr.c
drivers/acpi/dispatcher/dswload.c
drivers/atm/zatm.c
drivers/block/DAC960.c
drivers/block/ll_rw_blk.c
drivers/char/pc_keyb.c
drivers/char/rio/rio_linux.c
drivers/message/i2o/i2o_core.c

Four reports (drm and ip2main.c) were non-obvious and the
maintainers have been poked.

The ll_rw_blk.c change could be a little more elegant.
Really, we should propagate a failure of blk_init_queue()
all the way back to the caller.  In this patch we simply
leave the device with a less-than-expected pool of requests
and just limp along.  Seems to be better than crashing.


Patch is against -ac24.



--- linux-2.4.2-ac24/fs/proc/generic.c	Sat Mar 24 14:28:22 2001
+++ ac/fs/proc/generic.c	Sun Mar 25 02:16:59 2001
@@ -531,6 +531,8 @@
 	proc_register(parent, ent);
 	
 out:
+	if (ent == NULL)
+		printk(KERN_EMERG "create_proc_entry: failed to create entry for %s\n", name);
 	return ent;
 }
 
--- linux-2.4.2-ac24/arch/i386/kernel/irq.c	Sat Mar 24 14:28:02 2001
+++ ac/arch/i386/kernel/irq.c	Sun Mar 25 02:15:00 2001
@@ -1155,10 +1155,12 @@
 		/* create /proc/irq/1234/smp_affinity */
 		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
 
-		entry->nlink = 1;
-		entry->data = (void *)(long)irq;
-		entry->read_proc = irq_affinity_read_proc;
-		entry->write_proc = irq_affinity_write_proc;
+		if (entry) {
+			entry->nlink = 1;
+			entry->data = (void *)(long)irq;
+			entry->read_proc = irq_affinity_read_proc;
+			entry->write_proc = irq_affinity_write_proc;
+		}
 
 		smp_affinity_entry[irq] = entry;
 	}
--- linux-2.4.2-ac24/arch/i386/kernel/mtrr.c	Sat Mar 24 14:28:02 2001
+++ ac/arch/i386/kernel/mtrr.c	Sun Mar 25 02:20:08 2001
@@ -1809,7 +1809,8 @@
     }
     devfs_set_file_size (devfs_handle, ascii_buf_bytes);
 #  ifdef CONFIG_PROC_FS
-    proc_root_mtrr->size = ascii_buf_bytes;
+    if (proc_root_mtrr)
+	proc_root_mtrr->size = ascii_buf_bytes;
 #  endif  /*  CONFIG_PROC_FS  */
 }   /*  End Function compute_ascii  */
 
@@ -2118,8 +2119,10 @@
 
 #ifdef CONFIG_PROC_FS
     proc_root_mtrr = create_proc_entry ("mtrr", S_IWUSR | S_IRUGO, &proc_root);
-    proc_root_mtrr->owner = THIS_MODULE;
-    proc_root_mtrr->proc_fops = &mtrr_fops;
+    if (proc_root_mtrr) {
+	proc_root_mtrr->owner = THIS_MODULE;
+	proc_root_mtrr->proc_fops = &mtrr_fops;
+    }
 #endif
 #ifdef CONFIG_DEVFS_FS
     devfs_handle = devfs_register (NULL, "cpu/mtrr", DEVFS_FL_DEFAULT, 0, 0,
--- linux-2.4.2-ac24/drivers/acpi/dispatcher/dswload.c	Tue Jan 23 08:23:42 2001
+++ ac/drivers/acpi/dispatcher/dswload.c	Sun Mar 25 02:26:24 2001
@@ -455,6 +455,11 @@
 			arg = acpi_ps_get_arg (op, 2);
 		}
 
+		if (arg == NULL) {
+			status = AE_NOT_FOUND;
+			break;
+		}
+	
 		/*
 		 * Enter the Name_string into the namespace
 		 */
--- linux-2.4.2-ac24/drivers/atm/zatm.c	Wed Jul 19 07:55:01 2000
+++ ac/drivers/atm/zatm.c	Sun Mar 25 02:37:13 2001
@@ -1826,9 +1826,13 @@
 			devs++;
 			zatm_dev = (struct zatm_dev *) kmalloc(sizeof(struct
 			    zatm_dev),GFP_KERNEL);
-			if (!zatm_dev) break;
+			if (!zatm_dev) {
+				printk(KERN_EMERG "zatm.c: memory shortage\n");
+				goto out;
+			}
 		}
 	}
+out:
 	return devs;
 }
 
--- linux-2.4.2-ac24/drivers/block/DAC960.c	Sat Mar 24 14:28:03 2001
+++ ac/drivers/block/DAC960.c	Sun Mar 25 02:52:27 2001
@@ -506,16 +506,20 @@
 				      void *DataPointer)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
-  DAC960_V1_CommandStatus_T CommandStatus;
-  DAC960_V1_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->Type3.CommandOpcode = CommandOpcode;
-  CommandMailbox->Type3.BusAddress = Virtual_to_Bus32(DataPointer);
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V1.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V1_NormalCompletion);
+  if (Command == NULL) {
+	return false;
+  } else {
+    DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
+    DAC960_V1_CommandStatus_T CommandStatus;
+    DAC960_V1_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->Type3.CommandOpcode = CommandOpcode;
+    CommandMailbox->Type3.BusAddress = Virtual_to_Bus32(DataPointer);
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V1.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V1_NormalCompletion);
+  }
 }
 
 
@@ -532,18 +536,22 @@
 				       void *DataPointer)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
-  DAC960_V1_CommandStatus_T CommandStatus;
-  DAC960_V1_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
-  CommandMailbox->Type3D.Channel = Channel;
-  CommandMailbox->Type3D.TargetID = TargetID;
-  CommandMailbox->Type3D.BusAddress = Virtual_to_Bus32(DataPointer);
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V1.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V1_NormalCompletion);
+  if (Command == NULL) {
+    return false;
+  } else {
+    DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
+    DAC960_V1_CommandStatus_T CommandStatus;
+    DAC960_V1_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
+    CommandMailbox->Type3D.Channel = Channel;
+    CommandMailbox->Type3D.TargetID = TargetID;
+    CommandMailbox->Type3D.BusAddress = Virtual_to_Bus32(DataPointer);
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V1.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V1_NormalCompletion);
+  }
 }
 
 
@@ -559,29 +567,33 @@
 				     unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
-  DAC960_V2_CommandStatus_T CommandStatus;
-  DAC960_V2_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
-  CommandMailbox->Common.CommandControlBits
+  if (Command == NULL) {
+    return false;
+  } else {
+    DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+    DAC960_V2_CommandStatus_T CommandStatus;
+    DAC960_V2_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
+    CommandMailbox->Common.CommandControlBits
 			.DataTransferControllerToHost = true;
-  CommandMailbox->Common.CommandControlBits
+    CommandMailbox->Common.CommandControlBits
 			.NoAutoRequestSense = true;
-  CommandMailbox->Common.DataTransferSize = DataByteCount;
-  CommandMailbox->Common.IOCTL_Opcode = IOCTL_Opcode;
-  CommandMailbox->Common.DataTransferMemoryAddress
+    CommandMailbox->Common.DataTransferSize = DataByteCount;
+    CommandMailbox->Common.IOCTL_Opcode = IOCTL_Opcode;
+    CommandMailbox->Common.DataTransferMemoryAddress
 			.ScatterGatherSegments[0]
 			.SegmentDataPointer =
-    Virtual_to_Bus64(DataPointer);
-  CommandMailbox->Common.DataTransferMemoryAddress
+	    Virtual_to_Bus64(DataPointer);
+    CommandMailbox->Common.DataTransferMemoryAddress
 			.ScatterGatherSegments[0]
 			.SegmentByteCount =
-    CommandMailbox->Common.DataTransferSize;
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V2.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V2_NormalCompletion);
+	    CommandMailbox->Common.DataTransferSize;
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V2.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V2_NormalCompletion);
+  }
 }
 
 
@@ -597,30 +609,34 @@
 					unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
-  DAC960_V2_CommandStatus_T CommandStatus;
-  DAC960_V2_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
-  CommandMailbox->ControllerInfo.CommandControlBits
+  if (Command == NULL) {
+    return false;
+  } else {
+    DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+    DAC960_V2_CommandStatus_T CommandStatus;
+    DAC960_V2_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
+    CommandMailbox->ControllerInfo.CommandControlBits
 				.DataTransferControllerToHost = true;
-  CommandMailbox->ControllerInfo.CommandControlBits
+    CommandMailbox->ControllerInfo.CommandControlBits
 				.NoAutoRequestSense = true;
-  CommandMailbox->ControllerInfo.DataTransferSize = DataByteCount;
-  CommandMailbox->ControllerInfo.ControllerNumber = 0;
-  CommandMailbox->ControllerInfo.IOCTL_Opcode = IOCTL_Opcode;
-  CommandMailbox->ControllerInfo.DataTransferMemoryAddress
+    CommandMailbox->ControllerInfo.DataTransferSize = DataByteCount;
+    CommandMailbox->ControllerInfo.ControllerNumber = 0;
+    CommandMailbox->ControllerInfo.IOCTL_Opcode = IOCTL_Opcode;
+    CommandMailbox->ControllerInfo.DataTransferMemoryAddress
 				.ScatterGatherSegments[0]
 				.SegmentDataPointer =
-    Virtual_to_Bus64(DataPointer);
-  CommandMailbox->ControllerInfo.DataTransferMemoryAddress
+	    Virtual_to_Bus64(DataPointer);
+    CommandMailbox->ControllerInfo.DataTransferMemoryAddress
 				.ScatterGatherSegments[0]
 				.SegmentByteCount =
-    CommandMailbox->ControllerInfo.DataTransferSize;
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V2.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V2_NormalCompletion);
+	    CommandMailbox->ControllerInfo.DataTransferSize;
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V2.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V2_NormalCompletion);
+  }
 }
 
 
@@ -639,31 +655,35 @@
 					   unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
-  DAC960_V2_CommandStatus_T CommandStatus;
-  DAC960_V2_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
-  CommandMailbox->LogicalDeviceInfo.CommandControlBits
+  if (Command == NULL) {
+    return false;
+  } else {
+    DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+    DAC960_V2_CommandStatus_T CommandStatus;
+    DAC960_V2_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
+    CommandMailbox->LogicalDeviceInfo.CommandControlBits
 				   .DataTransferControllerToHost = true;
-  CommandMailbox->LogicalDeviceInfo.CommandControlBits
+    CommandMailbox->LogicalDeviceInfo.CommandControlBits
 				   .NoAutoRequestSense = true;
-  CommandMailbox->LogicalDeviceInfo.DataTransferSize = DataByteCount;
-  CommandMailbox->LogicalDeviceInfo.LogicalDevice.LogicalDeviceNumber =
-    LogicalDeviceNumber;
-  CommandMailbox->LogicalDeviceInfo.IOCTL_Opcode = IOCTL_Opcode;
-  CommandMailbox->LogicalDeviceInfo.DataTransferMemoryAddress
+    CommandMailbox->LogicalDeviceInfo.DataTransferSize = DataByteCount;
+    CommandMailbox->LogicalDeviceInfo.LogicalDevice.LogicalDeviceNumber =
+	    LogicalDeviceNumber;
+    CommandMailbox->LogicalDeviceInfo.IOCTL_Opcode = IOCTL_Opcode;
+    CommandMailbox->LogicalDeviceInfo.DataTransferMemoryAddress
 				   .ScatterGatherSegments[0]
 				   .SegmentDataPointer =
-    Virtual_to_Bus64(DataPointer);
-  CommandMailbox->LogicalDeviceInfo.DataTransferMemoryAddress
+	    Virtual_to_Bus64(DataPointer);
+    CommandMailbox->LogicalDeviceInfo.DataTransferMemoryAddress
 				   .ScatterGatherSegments[0]
 				   .SegmentByteCount =
-    CommandMailbox->LogicalDeviceInfo.DataTransferSize;
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V2.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V2_NormalCompletion);
+	    CommandMailbox->LogicalDeviceInfo.DataTransferSize;
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V2.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V2_NormalCompletion);
+  }
 }
 
 
@@ -683,32 +703,36 @@
 					    unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
-  DAC960_V2_CommandStatus_T CommandStatus;
-  DAC960_V2_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
-  CommandMailbox->PhysicalDeviceInfo.CommandControlBits
+  if (Command == NULL) {
+    return false;
+  } else {
+    DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+    DAC960_V2_CommandStatus_T CommandStatus;
+    DAC960_V2_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
+    CommandMailbox->PhysicalDeviceInfo.CommandControlBits
 				    .DataTransferControllerToHost = true;
-  CommandMailbox->PhysicalDeviceInfo.CommandControlBits
+    CommandMailbox->PhysicalDeviceInfo.CommandControlBits
 				    .NoAutoRequestSense = true;
-  CommandMailbox->PhysicalDeviceInfo.DataTransferSize = DataByteCount;
-  CommandMailbox->PhysicalDeviceInfo.PhysicalDevice.LogicalUnit = LogicalUnit;
-  CommandMailbox->PhysicalDeviceInfo.PhysicalDevice.TargetID = TargetID;
-  CommandMailbox->PhysicalDeviceInfo.PhysicalDevice.Channel = Channel;
-  CommandMailbox->PhysicalDeviceInfo.IOCTL_Opcode = IOCTL_Opcode;
-  CommandMailbox->PhysicalDeviceInfo.DataTransferMemoryAddress
+    CommandMailbox->PhysicalDeviceInfo.DataTransferSize = DataByteCount;
+    CommandMailbox->PhysicalDeviceInfo.PhysicalDevice.LogicalUnit = LogicalUnit;
+    CommandMailbox->PhysicalDeviceInfo.PhysicalDevice.TargetID = TargetID;
+    CommandMailbox->PhysicalDeviceInfo.PhysicalDevice.Channel = Channel;
+    CommandMailbox->PhysicalDeviceInfo.IOCTL_Opcode = IOCTL_Opcode;
+    CommandMailbox->PhysicalDeviceInfo.DataTransferMemoryAddress
 				    .ScatterGatherSegments[0]
 				    .SegmentDataPointer =
-    Virtual_to_Bus64(DataPointer);
-  CommandMailbox->PhysicalDeviceInfo.DataTransferMemoryAddress
+	    Virtual_to_Bus64(DataPointer);
+    CommandMailbox->PhysicalDeviceInfo.DataTransferMemoryAddress
 				    .ScatterGatherSegments[0]
 				    .SegmentByteCount =
-    CommandMailbox->PhysicalDeviceInfo.DataTransferSize;
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V2.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V2_NormalCompletion);
+	    CommandMailbox->PhysicalDeviceInfo.DataTransferSize;
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V2.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V2_NormalCompletion);
+  }
 }
 
 
@@ -724,21 +748,25 @@
 					   OperationDevice)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
-  DAC960_V2_CommandStatus_T CommandStatus;
-  DAC960_V2_ClearCommand(Command);
-  Command->CommandType = DAC960_ImmediateCommand;
-  CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
-  CommandMailbox->DeviceOperation.CommandControlBits
+  if (Command == NULL) {
+    return false;
+  } else {
+    DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+    DAC960_V2_CommandStatus_T CommandStatus;
+    DAC960_V2_ClearCommand(Command);
+    Command->CommandType = DAC960_ImmediateCommand;
+    CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
+    CommandMailbox->DeviceOperation.CommandControlBits
 				 .DataTransferControllerToHost = true;
-  CommandMailbox->DeviceOperation.CommandControlBits
+    CommandMailbox->DeviceOperation.CommandControlBits
     				 .NoAutoRequestSense = true;
-  CommandMailbox->DeviceOperation.IOCTL_Opcode = IOCTL_Opcode;
-  CommandMailbox->DeviceOperation.OperationDevice = OperationDevice;
-  DAC960_ExecuteCommand(Command);
-  CommandStatus = Command->V2.CommandStatus;
-  DAC960_DeallocateCommand(Command);
-  return (CommandStatus == DAC960_V2_NormalCompletion);
+    CommandMailbox->DeviceOperation.IOCTL_Opcode = IOCTL_Opcode;
+    CommandMailbox->DeviceOperation.OperationDevice = OperationDevice;
+    DAC960_ExecuteCommand(Command);
+    CommandStatus = Command->V2.CommandStatus;
+    DAC960_DeallocateCommand(Command);
+    return (CommandStatus == DAC960_V2_NormalCompletion);
+  }
 }
 
 
@@ -1423,20 +1451,27 @@
 	kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
       if (PhysicalDeviceInfo == NULL)
 	return DAC960_Failure(Controller, "PHYSICAL DEVICE ALLOCATION");
+      InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
+	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
+      if (InquiryUnitSerialNumber == NULL) {
+	kfree(PhysicalDeviceInfo);
+	return DAC960_Failure(Controller, "SERIAL NUMBER ALLOCATION");
+      }
+      Command = DAC960_AllocateCommand(Controller);
+      if (Command == NULL) {
+	kfree(PhysicalDeviceInfo);
+	kfree(InquiryUnitSerialNumber);
+	return DAC960_Failure(Controller, "COMMAND ALLOCATION");
+      }
       Controller->V2.PhysicalDeviceInformation[PhysicalDeviceIndex] =
 	PhysicalDeviceInfo;
       memcpy(PhysicalDeviceInfo, NewPhysicalDeviceInfo,
 	     sizeof(DAC960_V2_PhysicalDeviceInfo_T));
-      InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
-	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
-      if (InquiryUnitSerialNumber == NULL)
-	return DAC960_Failure(Controller, "SERIAL NUMBER ALLOCATION");
       Controller->V2.InquiryUnitSerialNumber[PhysicalDeviceIndex] =
 	InquiryUnitSerialNumber;
       memset(InquiryUnitSerialNumber, 0,
 	     sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T));
       InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
-      Command = DAC960_AllocateCommand(Controller);
       CommandMailbox = &Command->V2.CommandMailbox;
       DAC960_V2_ClearCommand(Command);
       Command->CommandType = DAC960_ImmediateCommand;
--- linux-2.4.2-ac24/drivers/block/ll_rw_blk.c	Sat Mar 24 14:28:03 2001
+++ ac/drivers/block/ll_rw_blk.c	Sun Mar 25 03:22:36 2001
@@ -395,6 +395,11 @@
 	 */
 	for (i = 0; i < queue_nr_requests; i++) {
 		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
+		if (rq == NULL) {
+			/* We'll get a `leaked requests' message from blk_cleanup_queue */
+			printk(KERN_EMERG "blk_init_free_list: error allocating requests\n");
+			break;
+		}
 		memset(rq, 0, sizeof(struct request));
 		rq->rq_status = RQ_INACTIVE;
 		list_add(&rq->table, &q->request_freelist[i & 1]);
--- linux-2.4.2-ac24/drivers/char/pc_keyb.c	Sat Mar 24 14:28:04 2001
+++ ac/drivers/char/pc_keyb.c	Sun Mar 25 03:16:28 2001
@@ -1016,6 +1016,8 @@
 
 	misc_register(&psaux_mouse);
 	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
+	if (queue == NULL)
+		panic("psaux_init(): out of memory");
 	memset(queue, 0, sizeof(*queue));
 	queue->head = queue->tail = 0;
 	init_waitqueue_head(&queue->proc_list);
--- linux-2.4.2-ac24/drivers/char/rio/rio_linux.c	Sun Feb 25 17:37:03 2001
+++ ac/drivers/char/rio/rio_linux.c	Sun Mar 25 03:17:43 2001
@@ -1031,8 +1031,10 @@
  free2:kfree (p->RIOHosts);
  free1:kfree (p);
  free0:
-  rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
-               p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
+  if (p) {
+	rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
+        	       p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
+  }
   return -ENOMEM;
 }
 
--- linux-2.4.2-ac24/drivers/message/i2o/i2o_core.c	Sat Mar 24 14:28:08 2001
+++ ac/drivers/message/i2o/i2o_core.c	Sun Mar 25 03:20:16 2001
@@ -933,6 +933,10 @@
 					kmalloc(sizeof(struct i2o_device), GFP_KERNEL);
 				int i;
 
+				if (d == NULL) {
+					printk(KERN_EMERG "i2oevtd: out of memory\n");
+					break;
+				}
 				memcpy(&d->lct_data, &msg[5], sizeof(i2o_lct_entry));
 	
 				d->next = NULL;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbREMEiw>; Sun, 13 May 2001 00:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbREMEim>; Sun, 13 May 2001 00:38:42 -0400
Received: from lonewolf.Stanford.EDU ([128.12.80.63]:13184 "HELO
	lonewolf.Stanford.EDU") by vger.kernel.org with SMTP
	id <S261374AbREMEih>; Sun, 13 May 2001 00:38:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Frederick Akalin <akalin@Stanford.EDU>
Reply-To: akalin@Stanford.EDU
Organization: Stanford University
Subject: [PATCH] Patches for unchecked pointers in various drivers
Date: Sat, 12 May 2001 21:39:51 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051221352600.01254@lonewolf.Stanford.EDU>
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We've identified several unchecked pointers using the Stanford checker and
have produced patches for them:

DAC960
PCMCIA bulkmem.c
ISDN-hisax
FTL (a memory card driver)
md.c
PCMCIA rsrc_mgr.c
sd.c from the scsi driver

The patches follow.

-- Frederick Akalin, Praveen Srinivasan

--- ../linux/./drivers/pcmcia/bulkmem.c	Tue Mar  6 19:28:32 2001
+++ ./drivers/pcmcia/bulkmem.c	Mon May  7 21:53:49 2001
@@ -229,6 +229,10 @@
 	else {
 	    erase->State = 1;
 	    busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
+
+	    if(busy == NULL) {
+	      return;
+	    }
 	    busy->erase = erase;
 	    busy->client = handle;
 	    init_timer(&busy->timeout);
@@ -360,6 +364,10 @@
 	if ((device.dev[i].type != CISTPL_DTYPE_NULL) &&
 	    (device.dev[i].size != 0)) {
 	    r = kmalloc(sizeof(*r), GFP_KERNEL);
+	    if(r == NULL) {
+	      return;
+	    }
+
 	    r->region_magic = REGION_MAGIC;
 	    r->state = 0;
 	    r->dev_info[0] = '\0';


--- ../linux/./drivers/pcmcia/bulkmem.c	Tue Mar  6 19:28:32 2001
+++ ./drivers/pcmcia/bulkmem.c	Mon May  7 21:53:49 2001
@@ -229,6 +229,10 @@
 	else {
 	    erase->State = 1;
 	    busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
+
+	    if(busy == NULL) {
+	      return;
+	    }
 	    busy->erase = erase;
 	    busy->client = handle;
 	    init_timer(&busy->timeout);
@@ -360,6 +364,10 @@
 	if ((device.dev[i].type != CISTPL_DTYPE_NULL) &&
 	    (device.dev[i].size != 0)) {
 	    r = kmalloc(sizeof(*r), GFP_KERNEL);
+	    if(r == NULL) {
+	      return;
+	    }
+
 	    r->region_magic = REGION_MAGIC;
 	    r->state = 0;
 	    r->dev_info[0] = '\0';

--- ../linux/./drivers/isdn/hisax/fsm.c	Fri Mar  2 11:12:08 2001
+++ ./drivers/isdn/hisax/fsm.c	Mon May  7 21:58:38 2001
@@ -22,6 +22,10 @@

 	fsm->jumpmatrix = (FSMFNPTR *)
 		kmalloc(sizeof (FSMFNPTR) * fsm->state_count * fsm->event_count,
GFP_KERNEL);
+	if(fsm->jumpmatrix == NULL) {
+	  return;
+	}
+
 	memset(fsm->jumpmatrix, 0, sizeof (FSMFNPTR) * fsm->state_count *
fsm->event_count);

 	for (i = 0; i < fncount; i++)

--- ../linux/./drivers/mtd/ftl.c	Fri Feb  9 11:30:23 2001
+++ ./drivers/mtd/ftl.c	Mon May  7 22:01:29 2001
@@ -375,6 +375,11 @@
     /* Set up virtual page map */
     blocks = le32_to_cpu(header.FormattedSize) >> header.BlockSize;
     part->VirtualBlockMap = vmalloc(blocks * sizeof(u_int32_t));
+
+    if(part->VirtualBlockMap==NULL) {
+      return -1;
+    }
+
     memset(part->VirtualBlockMap, 0xff, blocks * sizeof(u_int32_t));
     part->BlocksPerUnit = (1 << header.EraseUnitSize) >> header.BlockSize;

--- ../linux/./drivers/md/md.c	Fri Apr  6 10:42:55 2001
+++ ./drivers/md/md.c	Mon May  7 22:08:02 2001
@@ -3756,6 +3756,7 @@
 			continue;
 		}
 		mddev = alloc_mddev(MKDEV(MD_MAJOR,minor));
+
 		if (md_setup_args.pers[minor]) {
 			/* non-persistent */
 			mdu_array_info_t ainfo;
@@ -3773,7 +3774,12 @@
 			ainfo.spare_disks = 0;
 			ainfo.layout = 0;
 			ainfo.chunk_size = md_setup_args.chunk[minor];
-			err = set_array_info(mddev, &ainfo);
+			if(mddev==NULL){
+			    err=1;
+			  }
+			else {
+			  err = set_array_info(mddev, &ainfo);
+			}
 			for (i = 0; !err && (dev = md_setup_args.devices[minor][i]); i++) {
 				dinfo.number = i;
 				dinfo.raid_disk = i;
@@ -3797,9 +3803,12 @@
 		if (!err)
 			err = do_md_run(mddev);
 		if (err) {
-			mddev->sb_dirty = 0;
-			do_md_stop(mddev, 0);
-			printk("md: starting md%d failed\n", minor);
+		  if(mddev !=NULL){
+		    mddev->sb_dirty = 0;
+		    do_md_stop(mddev, 0);
+		  }
+
+		  printk("md: starting md%d failed\n", minor);
 		}
 	}
 }

--- ../linux/./drivers/pcmcia/rsrc_mgr.c	Tue Mar  6 19:28:32 2001
+++ ./drivers/pcmcia/rsrc_mgr.c	Mon May  7 22:09:09 2001
@@ -189,6 +189,11 @@

     /* First, what does a floating port look like? */
     b = kmalloc(256, GFP_KERNEL);
+
+    if(b == NULL){
+      return;
+    }
+
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
 	if (check_io_resource(i, 8))

--- ../linux/./drivers/scsi/sd.c	Sat Feb  3 11:45:55 2001
+++ ./drivers/scsi/sd.c	Mon May  7 22:09:58 2001
@@ -734,8 +734,15 @@
 	 */

 	SRpnt = scsi_allocate_request(rscsi_disks[i].device);
+	if(SRpnt == NULL) {
+	  return i;
+	}

 	buffer = (unsigned char *) scsi_malloc(512);
+
+	if(buffer == NULL) {
+	  return i;
+	}

 	spintime = 0;

--- ../linux/./drivers/block/DAC960.c	Tue Feb 20 21:26:22 2001
+++ ./drivers/block/DAC960.c	Mon May  7 21:56:30 2001
@@ -508,6 +508,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
   DAC960_V1_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Type3.CommandOpcode = CommandOpcode;
@@ -534,6 +537,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
   DAC960_V1_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
@@ -561,6 +567,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
@@ -599,6 +608,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -641,6 +653,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -685,6 +700,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -726,6 +744,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
@@ -1435,8 +1456,12 @@
 	InquiryUnitSerialNumber;
       memset(InquiryUnitSerialNumber, 0,
 	     sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T));
-      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
+      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
       Command = DAC960_AllocateCommand(Controller);
+      if(Command == NULL) {
+	return 0;
+      }
+
       CommandMailbox = &Command->V2.CommandMailbox;
       DAC960_V2_ClearCommand(Command);
       Command->CommandType = DAC960_ImmediateCommand;
@@ -6594,6 +6619,10 @@
 	create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
 			       ControllerProcEntry, DAC960_ProcReadUserCommand,
 			       Controller);
+      if(UserCommandProcEntry == NULL) {
+	return 0;
+      }
+
       UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
       Controller->ControllerProcEntry = ControllerProcEntry;
     }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUFPVK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUFPVK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUFPVK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:10:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17320 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264826AbUFPVFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:05:12 -0400
Date: Wed, 16 Jun 2004 17:04:55 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: PATCH: Further aacraid work
Message-ID: <20040616210455.GA13385@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been going through Mark's changes with a fine toothcomb and this merges
most of them. Its tested on 64bit SMP hardware and seems to be fine. There
are a couple of Mark's changes I've left out for now but there isnt really
an easy way to break down the changes further.

This fixes a whole host of problems including random hangs under high load


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/aacraid.h 2.6.7-ac/drivers/scsi/aacraid/aacraid.h
--- linux-2.6.7/drivers/scsi/aacraid/aacraid.h	2004-06-16 21:11:36.396378984 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/aacraid.h	2004-05-30 18:34:35.000000000 +0100
@@ -6,14 +6,12 @@
  *              D E F I N E S
  *----------------------------------------------------------------------------*/
 
-#define MAXIMUM_NUM_CONTAINERS	31
+#define MAXIMUM_NUM_CONTAINERS	32
 #define MAXIMUM_NUM_ADAPTERS	8
 
-#define AAC_NUM_FIB		578
-//#define AAC_NUM_IO_FIB	512
+#define AAC_NUM_FIB		(256 + 64)
 #define AAC_NUM_IO_FIB		100
 
-#define AAC_MAX_TARGET 		(MAXIMUM_NUM_CONTAINERS+1)
 #define AAC_MAX_LUN		(8)
 
 #define AAC_MAX_HOSTPHYSMEMPAGES (0xfffff)
@@ -21,7 +19,12 @@
 /*
  * These macros convert from physical channels to virtual channels
  */
-#define CONTAINER_CHANNEL	(0)
+#define CONTAINER_CHANNEL		(0)
+#define ID_LUN_TO_CONTAINER(id, lun)	(id)
+#define CONTAINER_TO_CHANNEL(cont)	(CONTAINER_CHANNEL)
+#define CONTAINER_TO_ID(cont)		(cont)
+#define CONTAINER_TO_LUN(cont)		(0)
+
 #define aac_phys_to_logical(x)  (x+1)
 #define aac_logical_to_phys(x)  (x?x-1:0)
 
@@ -73,7 +76,7 @@
 #define		FT_SOCK		6	/* socket */
 #define		FT_FIFO		7	/* fifo */
 #define		FT_FILESYS	8	/* ADAPTEC's "FSA"(tm) filesystem */
-#define		FT_DRIVE	9	/* physical disk - addressable in scsi by bus/target/lun */
+#define		FT_DRIVE	9	/* physical disk - addressable in scsi by bus/id/lun */
 #define		FT_SLICE	10	/* virtual disk - raw volume - slice */
 #define		FT_PARTITION	11	/* FSA partition - carved out of a slice - building block for containers */
 #define		FT_VOLUME	12	/* Container - Volume Set */
@@ -433,7 +436,7 @@
 
 struct aac_driver_ident
 {
-	int 	(*init)(struct aac_dev *dev, unsigned long num);
+	int 	(*init)(struct aac_dev *dev);
 	char *	name;
 	char *	vname;
 	char *	model;
@@ -596,6 +599,9 @@
 #define	InboundMailbox2		IndexRegs.Mailbox[2]
 #define	InboundMailbox3		IndexRegs.Mailbox[3]
 #define	InboundMailbox4		IndexRegs.Mailbox[4]
+#define	InboundMailbox5		IndexRegs.Mailbox[5]
+#define	InboundMailbox6		IndexRegs.Mailbox[6]
+#define	InboundMailbox7		IndexRegs.Mailbox[7]
 
 #define	INBOUNDDOORBELL_0	cpu_to_le32(0x00000001)
 #define INBOUNDDOORBELL_1	cpu_to_le32(0x00000002)
@@ -825,9 +831,8 @@
 	} regs;
 	u32			OIMR; /* Mask Register Cache */
 	/*
-	 *	The following is the number of the individual adapter
+	 *	AIF thread states
 	 */
-	u32			devnum;
 	u32			aif_thread;
 	struct completion	aif_completion;
 	struct aac_adapter_info adapter_info;
@@ -839,19 +844,19 @@
 };
 
 #define AllocateAndMapFibSpace(dev, MapFibContext) \
-	dev->a_ops.AllocateAndMapFibSpace(dev, MapFibContext)
+	(dev)->a_ops.AllocateAndMapFibSpace(dev, MapFibContext)
 
 #define UnmapAndFreeFibSpace(dev, MapFibContext) \
-	dev->a_ops.UnmapAndFreeFibSpace(dev, MapFibContext)
+	(dev)->a_ops.UnmapAndFreeFibSpace(dev, MapFibContext)
 
 #define aac_adapter_interrupt(dev) \
-	dev->a_ops.adapter_interrupt(dev)
+	(dev)->a_ops.adapter_interrupt(dev)
 
 #define aac_adapter_notify(dev, event) \
-	dev->a_ops.adapter_notify(dev, event)
+	(dev)->a_ops.adapter_notify(dev, event)
 
 #define aac_adapter_enable_int(dev, event) \
-	dev->a_ops.adapter_enable_int(dev, event)
+	(dev)->a_ops.adapter_enable_int(dev, event)
 
 #define aac_adapter_disable_int(dev, event) \
 	dev->a_ops.adapter_disable_int(dev, event)
@@ -1023,7 +1028,7 @@
 {
 	u32		function;
 	u32		channel;
-	u32		target;
+	u32		id;
 	u32		lun;
 	u32		timeout;
 	u32		flags;
@@ -1212,7 +1217,7 @@
 {
 	s32	cnum;
 	s32	bus;
-	s32	target;
+	s32	id;
 	s32	lun;
 	u32	valid;
 	u32	locked;
@@ -1323,6 +1328,7 @@
 #define WRITE_PERMANENT_PARAMETERS	cpu_to_le32(0x0000000b)
 #define HOST_CRASHING			cpu_to_le32(0x0000000d)
 #define	SEND_SYNCHRONOUS_FIB		cpu_to_le32(0x0000000c)
+#define	COMMAND_POST_RESULTS		cpu_to_le32(0x00000014)
 #define GET_ADAPTER_PROPERTIES		cpu_to_le32(0x00000019)
 #define RE_INIT_ADAPTER			cpu_to_le32(0x000000ee)
 
@@ -1347,14 +1353,16 @@
  *	Phases are bit oriented.  It is NOT valid  to have multiple bits set						
  */					
 
-#define	SELF_TEST_FAILED		cpu_to_le32(0x00000004)
-#define	KERNEL_UP_AND_RUNNING		cpu_to_le32(0x00000080)
-#define	KERNEL_PANIC			cpu_to_le32(0x00000100)
+#define	SELF_TEST_FAILED		(cpu_to_le32(0x00000004))
+#define MONITOR_PANIC			(cpu_to_le32(0x00000020))
+#define	KERNEL_UP_AND_RUNNING		(cpu_to_le32(0x00000080))
+#define	KERNEL_PANIC			(cpu_to_le32(0x00000100))
 
 /*
  *	Doorbell bit defines
  */
 
+#define DoorBellSyncCmdAvailable	cpu_to_le32(1<<0)	// Host -> Adapter
 #define DoorBellPrintfDone		cpu_to_le32(1<<5)	// Host -> Adapter
 #define DoorBellAdapterNormCmdReady	cpu_to_le32(1<<1)	// Adapter -> Host
 #define DoorBellAdapterNormRespReady	cpu_to_le32(1<<2)	// Adapter -> Host
@@ -1368,9 +1376,22 @@
  */
  
 #define 	AifCmdEventNotify	1	/* Notify of event */
+#define			AifEnConfigChange	3	/* Adapter configuration change */
+#define			AifEnContainerChange	4	/* Container configuration change */
+#define			AifEnDeviceFailure	5	/* SCSI device failed */
+#define			AifEnAddContainer	15	/* A new array was created */
+#define			AifEnDeleteContainer	16	/* A container was deleted */
+#define			AifEnExpEvent		23	/* Firmware Event Log */
+#define			AifExeFirmwarePanic	3	/* Firmware Event Panic */
+#define			AifHighPriority		3	/* Highest Priority Event */
+
 #define		AifCmdJobProgress	2	/* Progress report */
+#define			AifJobCtrZero	101	/* Array Zero progress */
+#define			AifJobStsSuccess 1	/* Job completes */
 #define		AifCmdAPIReport		3	/* Report from other user of API */
 #define		AifCmdDriverNotify	4	/* Notify host driver of event */
+#define			AifDenMorphComplete 200	/* A morph operation completed */
+#define			AifDenVolumeExtendComplete 201 /* A volume extend completed */
 #define		AifReqJobList		100	/* Gets back complete job list */
 #define		AifReqJobsForCtr	101	/* Gets back jobs for specific container */
 #define		AifReqJobsForScsi	102	/* Gets back jobs for specific SCSI device */ 
@@ -1427,9 +1448,9 @@
 int aac_scsi_cmd(struct scsi_cmnd *cmd);
 int aac_dev_ioctl(struct aac_dev *dev, int cmd, void *arg);
 int aac_do_ioctl(struct aac_dev * dev, int cmd, void *arg);
-int aac_rx_init(struct aac_dev *dev, unsigned long devNumber);
-int aac_rkt_init(struct aac_dev *dev, unsigned long devNumber);
-int aac_sa_init(struct aac_dev *dev, unsigned long devNumber);
+int aac_rx_init(struct aac_dev *dev);
+int aac_rkt_init(struct aac_dev *dev);
+int aac_sa_init(struct aac_dev *dev);
 unsigned int aac_response_normal(struct aac_queue * q);
 unsigned int aac_command_normal(struct aac_queue * q);
 int aac_command_thread(struct aac_dev * dev);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/aachba.c 2.6.7-ac/drivers/scsi/aacraid/aachba.c
--- linux-2.6.7/drivers/scsi/aacraid/aachba.c	2004-06-16 21:10:05.000000000 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/aachba.c	2004-05-30 18:27:32.000000000 +0100
@@ -53,35 +53,11 @@
 #define	INQD_PDT_DMASK	0x1F	/* Peripheral Device Type Mask */
 #define	INQD_PDT_QMASK	0xE0	/* Peripheral Device Qualifer Mask */
 
-#define	TARGET_LUN_TO_CONTAINER(target, lun)	(target)
-#define CONTAINER_TO_TARGET(cont)		((cont))
-#define CONTAINER_TO_LUN(cont)			(0)
-
 #define MAX_FIB_DATA (sizeof(struct hw_fib) - sizeof(FIB_HEADER))
 
 #define MAX_DRIVER_SG_SEGMENT_COUNT 17
 
 /*
- *	Sense keys
- */
-#define SENKEY_NO_SENSE      0x00	
-#define SENKEY_UNDEFINED     0x01	
-#define SENKEY_NOT_READY     0x02	
-#define SENKEY_MEDIUM_ERR    0x03	
-#define SENKEY_HW_ERR        0x04	
-#define SENKEY_ILLEGAL       0x05	
-#define SENKEY_ATTENTION     0x06	
-#define SENKEY_PROTECTED     0x07	
-#define SENKEY_BLANK         0x08	
-#define SENKEY_V_UNIQUE      0x09	
-#define SENKEY_CPY_ABORT     0x0A	
-#define SENKEY_ABORT         0x0B	
-#define SENKEY_EQUAL         0x0C	
-#define SENKEY_VOL_OVERFLOW  0x0D	
-#define SENKEY_MISCOMP       0x0E	
-#define SENKEY_RESERVED      0x0F	
-
-/*
  *	Sense codes
  */
  
@@ -195,7 +171,6 @@
  *              M O D U L E   G L O B A L S
  */
  
-static struct fsa_scsi_hba *fsa_dev[MAXIMUM_NUM_ADAPTERS];	/*  SCSI Device Instance Pointers */
 static struct sense_data sense_data[MAXIMUM_NUM_CONTAINERS];
 static unsigned long aac_build_sg(struct scsi_cmnd* scsicmd, struct sgmap* sgmap);
 static unsigned long aac_build_sg64(struct scsi_cmnd* scsicmd, struct sgmap64* psg);
@@ -264,7 +239,6 @@
 		}
 	}
 	fib_free(fibptr);
-	fsa_dev[instance] = fsa_dev_ptr;
 	return status;
 }
 
@@ -424,14 +398,14 @@
 	} else
 		sense_buf[2] = sense_key;	/* Sense key */
 
-	if (sense_key == SENKEY_ILLEGAL)
+	if (sense_key == ILLEGAL_REQUEST)
 		sense_buf[7] = 10;	/* Additional sense length */
 	else
 		sense_buf[7] = 6;	/* Additional sense length */
 
 	sense_buf[12] = sense_code;	/* Additional sense code */
 	sense_buf[13] = a_sense_code;	/* Additional sense code qualifier */
-	if (sense_key == SENKEY_ILLEGAL) {
+	if (sense_key == ILLEGAL_REQUEST) {
 		sense_buf[15] = 0;
 
 		if (sense_code == SENCODE_INVALID_PARAM_FIELD)
@@ -514,11 +488,12 @@
 		dev->nondasd_support = (nondasd!=0);
 	}
 	if(dev->nondasd_support != 0){
-		printk(KERN_INFO"%s%d: Non-DASD support enabled\n",dev->name, dev->id);
+		printk(KERN_INFO "%s%d: Non-DASD support enabled.\n",dev->name, dev->id);
 	}
 
 	dev->pae_support = 0;
 	if( (sizeof(dma_addr_t) > 4) && (dev->adapter_info.options & AAC_OPT_SGMAP_HOST64)){
+		printk(KERN_INFO "%s%d: 64bit support enabled.\n", dev->name, dev->id);
 		dev->pae_support = 1;
 	}
 
@@ -548,7 +523,7 @@
 	scsicmd = (struct scsi_cmnd *) context;
 
 	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
-	cid =TARGET_LUN_TO_CONTAINER(scsicmd->device->id, scsicmd->device->lun);
+	cid = ID_LUN_TO_CONTAINER(scsicmd->device->id, scsicmd->device->lun);
 
 	lba = ((scsicmd->cmnd[1] & 0x1F) << 16) | (scsicmd->cmnd[2] << 8) | scsicmd->cmnd[3];
 	dprintk((KERN_DEBUG "read_callback[cpu %d]: lba = %u, t = %ld.\n", smp_processor_id(), lba, jiffies));
@@ -572,10 +547,11 @@
 		printk(KERN_WARNING "read_callback: read failed, status = %d\n", readreply->status);
 		scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_CHECK_CONDITION;
 		set_sense((u8 *) &sense_data[cid],
-				    SENKEY_HW_ERR,
+				    HARDWARE_ERROR,
 				    SENCODE_INTERNAL_TARGET_FAILURE,
 				    ASENCODE_INTERNAL_TARGET_FAILURE, 0, 0,
 				    0, 0);
+		memcpy(scsicmd->sense_buffer, &sense_data[cid], sizeof(struct sense_data));
 	}
 	fib_complete(fibptr);
 	fib_free(fibptr);
@@ -593,7 +569,7 @@
 
 	scsicmd = (struct scsi_cmnd *) context;
 	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
-	cid = TARGET_LUN_TO_CONTAINER(scsicmd->device->id, scsicmd->device->lun);
+	cid = ID_LUN_TO_CONTAINER(scsicmd->device->id, scsicmd->device->lun);
 
 	lba = ((scsicmd->cmnd[1] & 0x1F) << 16) | (scsicmd->cmnd[2] << 8) | scsicmd->cmnd[3];
 	dprintk((KERN_DEBUG "write_callback[cpu %d]: lba = %u, t = %ld.\n", smp_processor_id(), lba, jiffies));
@@ -617,10 +593,11 @@
 		printk(KERN_WARNING "write_callback: write failed, status = %d\n", writereply->status);
 		scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_CHECK_CONDITION;
 		set_sense((u8 *) &sense_data[cid],
-				    SENKEY_HW_ERR,
+				    HARDWARE_ERROR,
 				    SENCODE_INTERNAL_TARGET_FAILURE,
 				    ASENCODE_INTERNAL_TARGET_FAILURE, 0, 0,
 				    0, 0);
+		memcpy(scsicmd->sense_buffer, &sense_data[cid], sizeof(struct sense_data));
 	}
 
 	fib_complete(fibptr);
@@ -644,7 +621,7 @@
 	 */
 	if (scsicmd->cmnd[0] == READ_6)	/* 6 byte command */
 	{
-		dprintk((KERN_DEBUG "aachba: received a read(6) command on target %d.\n", cid));
+		dprintk((KERN_DEBUG "aachba: received a read(6) command on id %d.\n", cid));
 
 		lba = ((scsicmd->cmnd[1] & 0x1F) << 16) | (scsicmd->cmnd[2] << 8) | scsicmd->cmnd[3];
 		count = scsicmd->cmnd[4];
@@ -652,7 +629,7 @@
 		if (count == 0)
 			count = 256;
 	} else {
-		dprintk((KERN_DEBUG "aachba: received a read(10) command on target %d.\n", cid));
+		dprintk((KERN_DEBUG "aachba: received a read(10) command on id %d.\n", cid));
 
 		lba = (scsicmd->cmnd[2] << 24) | (scsicmd->cmnd[3] << 16) | (scsicmd->cmnd[4] << 8) | scsicmd->cmnd[5];
 		count = (scsicmd->cmnd[7] << 8) | scsicmd->cmnd[8];
@@ -662,9 +639,7 @@
 	 *	Alocate and initialize a Fib
 	 */
 	if (!(cmd_fibcontext = fib_alloc(dev))) {
-		scsicmd->result = DID_ERROR << 16;
-		aac_io_done(scsicmd);
-		return (-1);
+		return -1;
 	}
 
 	fib_init(cmd_fibcontext);
@@ -726,7 +701,10 @@
 	 *	Check that the command queued to the controller
 	 */
 	if (status == -EINPROGRESS) 
+	{
+		dprintk("read queued.\n");
 		return 0;
+	}
 		
 	printk(KERN_WARNING "aac_read: fib_send failed with status: %d.\n", status);
 	/*
@@ -759,7 +737,7 @@
 		if (count == 0)
 			count = 256;
 	} else {
-		dprintk((KERN_DEBUG "aachba: received a write(10) command on target %d.\n", cid));
+		dprintk((KERN_DEBUG "aachba: received a write(10) command on id %d.\n", cid));
 		lba = (scsicmd->cmnd[2] << 24) | (scsicmd->cmnd[3] << 16) | (scsicmd->cmnd[4] << 8) | scsicmd->cmnd[5];
 		count = (scsicmd->cmnd[7] << 8) | scsicmd->cmnd[8];
 	}
@@ -832,7 +810,10 @@
 	 *	Check that the command queued to the controller
 	 */
 	if (status == -EINPROGRESS)
+	{
+		dprintk("write queued.\n");
 		return 0;
+	}
 
 	printk(KERN_WARNING "aac_write: fib_send failed with status: %d\n", status);
 	/*
@@ -850,7 +831,6 @@
 /**
  *	aac_scsi_cmd()		-	Process SCSI command
  *	@scsicmd:		SCSI command block
- *	@wait:			1 if the user wants to await completion
  *
  *	Emulate a SCSI command and queue the required request for the
  *	aacraid firmware.
@@ -859,29 +839,25 @@
 int aac_scsi_cmd(struct scsi_cmnd * scsicmd)
 {
 	u32 cid = 0;
-	struct fsa_scsi_hba *fsa_dev_ptr;
-	int cardtype;
 	int ret;
 	struct Scsi_Host *host = scsicmd->device->host;
 	struct aac_dev *dev = (struct aac_dev *)host->hostdata;
+	struct fsa_scsi_hba *fsa_dev_ptr = &dev->fsa_dev;
+	int cardtype = dev->cardtype;
 	
-	cardtype = dev->cardtype;
-
-	fsa_dev_ptr = fsa_dev[host->unique_id];
-
 	/*
-	 *	If the bus, target or lun is out of range, return fail
+	 *	If the bus, id or lun is out of range, return fail
 	 *	Test does not apply to ID 16, the pseudo id for the controller
 	 *	itself.
 	 */
 	if (scsicmd->device->id != host->this_id) {
 		if ((scsicmd->device->channel == 0) ){
-			if( (scsicmd->device->id >= AAC_MAX_TARGET) || (scsicmd->device->lun != 0)){ 
+			if( (scsicmd->device->id >= MAXIMUM_NUM_CONTAINERS) || (scsicmd->device->lun != 0)){ 
 				scsicmd->result = DID_NO_CONNECT << 16;
 				__aac_io_done(scsicmd);
 				return 0;
 			}
-			cid = TARGET_LUN_TO_CONTAINER(scsicmd->device->id, scsicmd->device->lun);
+			cid = ID_LUN_TO_CONTAINER(scsicmd->device->id, scsicmd->device->lun);
 
 			/*
 			 *	If the target container doesn't exist, it may have
@@ -911,7 +887,7 @@
 			if (fsa_dev_ptr->valid[cid] == 0) {
 				scsicmd->result = DID_BAD_TARGET << 16;
 				__aac_io_done(scsicmd);
-				return -1;
+				return 0;
 			}
 		} else {  /* check for physical non-dasd devices */
 			if(dev->nondasd_support == 1){
@@ -932,11 +908,12 @@
 		dprintk((KERN_WARNING "Only INQUIRY & TUR command supported for controller, rcvd = 0x%x.\n", scsicmd->cmnd[0]));
 		scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_CHECK_CONDITION;
 		set_sense((u8 *) &sense_data[cid],
-			    SENKEY_ILLEGAL,
+			    ILLEGAL_REQUEST,
 			    SENCODE_INVALID_COMMAND,
 			    ASENCODE_INVALID_COMMAND, 0, 0, 0, 0);
 		__aac_io_done(scsicmd);
-		return -1;
+		memcpy(scsicmd->sense_buffer, &sense_data[cid], sizeof(struct sense_data));
+		return 0;
 	}
 
 
@@ -1034,7 +1011,7 @@
 		memset(&sense_data[cid], 0, sizeof (struct sense_data));
 		scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_GOOD;
 		__aac_io_done(scsicmd);
-		return (0);
+		return 0;
 
 	case ALLOW_MEDIUM_REMOVAL:
 		dprintk((KERN_DEBUG "LOCK command.\n"));
@@ -1058,7 +1035,7 @@
 	case START_STOP:
 		scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_GOOD;
 		__aac_io_done(scsicmd);
-		return (0);
+		return 0;
 	}
 
 	switch (scsicmd->cmnd[0]) 
@@ -1094,10 +1071,12 @@
 			printk(KERN_WARNING "Unhandled SCSI Command: 0x%x.\n", scsicmd->cmnd[0]);
 			scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_CHECK_CONDITION;
 			set_sense((u8 *) &sense_data[cid],
-				SENKEY_ILLEGAL, SENCODE_INVALID_COMMAND,
+				ILLEGAL_REQUEST, SENCODE_INVALID_COMMAND,
 			ASENCODE_INVALID_COMMAND, 0, 0, 0, 0);
+			memcpy(scsicmd->sense_buffer, &sense_data[cid],
+				sizeof(struct sense_data));
 			__aac_io_done(scsicmd);
-			return -1;
+			return 0;
 	}
 }
 
@@ -1110,14 +1089,14 @@
 	if (copy_from_user(&qd, arg, sizeof (struct aac_query_disk)))
 		return -EFAULT;
 	if (qd.cnum == -1)
-		qd.cnum = TARGET_LUN_TO_CONTAINER(qd.target, qd.lun);
-	else if ((qd.bus == -1) && (qd.target == -1) && (qd.lun == -1)) 
+		qd.cnum = ID_LUN_TO_CONTAINER(qd.id, qd.lun);
+	else if ((qd.bus == -1) && (qd.id == -1) && (qd.lun == -1)) 
 	{
 		if (qd.cnum < 0 || qd.cnum >= MAXIMUM_NUM_CONTAINERS)
 			return -EINVAL;
 		qd.instance = dev->scsi_host_ptr->host_no;
 		qd.bus = 0;
-		qd.target = CONTAINER_TO_TARGET(qd.cnum);
+		qd.id = CONTAINER_TO_ID(qd.cnum);
 		qd.lun = CONTAINER_TO_LUN(qd.cnum);
 	}
 	else return -EINVAL;
@@ -1228,8 +1207,11 @@
 
 	srbreply = (struct aac_srb_reply *) fib_data(fibptr);
 
-	scsicmd->sense_buffer[0] = '\0';  // initialize sense valid flag to false
-	// calculate resid for sg 
+	scsicmd->sense_buffer[0] = '\0';  /* Initialize sense valid flag to false */
+	/*
+	 *	Calculate resid for sg 
+	 */
+	 
 	scsicmd->resid = scsicmd->request_bufflen - srbreply->data_xfer_length;
 
 	if(scsicmd->use_sg)
@@ -1376,7 +1358,7 @@
 		scsicmd->result |= SAM_STAT_CHECK_CONDITION;
 		len = (srbreply->sense_data_size > sizeof(scsicmd->sense_buffer))?
 				sizeof(scsicmd->sense_buffer):srbreply->sense_data_size;
-		printk(KERN_WARNING "aac_srb_callback: check condition, status = %d len=%d\n", le32_to_cpu(srbreply->status), len);
+		dprintk((KERN_WARNING "aac_srb_callback: check condition, status = %d len=%d\n", le32_to_cpu(srbreply->status), len));
 		memcpy(scsicmd->sense_buffer, srbreply->sense_data, len);
 		
 	}
@@ -1437,8 +1419,6 @@
 	 *	Allocate and initialize a Fib then setup a BlockWrite command
 	 */
 	if (!(cmd_fibcontext = fib_alloc(dev))) {
-		scsicmd->result = DID_ERROR << 16;
-		__aac_io_done(scsicmd);
 		return -1;
 	}
 	fib_init(cmd_fibcontext);
@@ -1446,7 +1426,7 @@
 	srbcmd = (struct aac_srb*) fib_data(cmd_fibcontext);
 	srbcmd->function = cpu_to_le32(SRBF_ExecuteScsi);
 	srbcmd->channel  = cpu_to_le32(aac_logical_to_phys(scsicmd->device->channel));
-	srbcmd->target   = cpu_to_le32(scsicmd->device->id);
+	srbcmd->id   = cpu_to_le32(scsicmd->device->id);
 	srbcmd->lun      = cpu_to_le32(scsicmd->device->lun);
 	srbcmd->flags    = cpu_to_le32(flag);
 	timeout = (scsicmd->timeout-jiffies)/HZ;
@@ -1498,12 +1478,6 @@
 	}
 
 	printk(KERN_WARNING "aac_srb: fib_send failed with status: %d\n", status);
-	/*
-	 *	For some reason, the Fib didn't queue, return QUEUE_FULL
-	 */
-	scsicmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8 | SAM_STAT_TASK_SET_FULL;
-	__aac_io_done(scsicmd);
-
 	fib_complete(cmd_fibcontext);
 	fib_free(cmd_fibcontext);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/commctrl.c 2.6.7-ac/drivers/scsi/aacraid/commctrl.c
--- linux-2.6.7/drivers/scsi/aacraid/commctrl.c	2004-06-16 21:11:36.396378984 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/commctrl.c	2004-05-30 18:22:05.000000000 +0100
@@ -431,7 +431,7 @@
 	// Fix up srb for endian and force some values
 	srbcmd->function = cpu_to_le32(SRBF_ExecuteScsi);	// Force this
 	srbcmd->channel  = cpu_to_le32(srbcmd->channel);
-	srbcmd->target   = cpu_to_le32(srbcmd->target);
+	srbcmd->id	 = cpu_to_le32(srbcmd->id);
 	srbcmd->lun      = cpu_to_le32(srbcmd->lun);
 	srbcmd->flags    = cpu_to_le32(srbcmd->flags);
 	srbcmd->timeout  = cpu_to_le32(srbcmd->timeout);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/comminit.c 2.6.7-ac/drivers/scsi/aacraid/comminit.c
--- linux-2.6.7/drivers/scsi/aacraid/comminit.c	2004-06-16 21:11:36.397378832 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/comminit.c	2004-05-11 20:20:37.000000000 +0100
@@ -95,13 +95,18 @@
 	 * with the math overloading past 32 bits, thus we must limit this
 	 * field.
 	 *
-	 * FIXME: this assumes the memory is mapped zero->n, which isnt
-	 * always true on real computers.
+	 * This assumes the memory is mapped zero->n, which isnt
+	 * always true on real computers. It also has some slight problems
+	 * with the GART on x86-64. I've btw never tried DMA from PCI space
+	 * on this platform but don't be suprised if its problematic.
 	 */
+#ifndef CONFIG_GART_IOMMU
 	if ((num_physpages << (PAGE_SHIFT - 12)) <= AAC_MAX_HOSTPHYSMEMPAGES) {
 		init->HostPhysMemPages = 
 			cpu_to_le32(num_physpages << (PAGE_SHIFT-12));
-	} else {
+	} else 
+#endif	
+	{
 		init->HostPhysMemPages = cpu_to_le32(AAC_MAX_HOSTPHYSMEMPAGES);
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/linit.c 2.6.7-ac/drivers/scsi/aacraid/linit.c
--- linux-2.6.7/drivers/scsi/aacraid/linit.c	2004-06-16 21:11:36.399378528 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/linit.c	2004-05-30 18:25:14.000000000 +0100
@@ -27,7 +27,7 @@
  * Abstract: Linux Driver entry module for Adaptec RAID Array Controller
  */
 
-#define AAC_DRIVER_VERSION		"1.1.2-lk1"
+#define AAC_DRIVER_VERSION		"1.1.2-lk2"
 #define AAC_DRIVER_BUILD_DATE		__DATE__
 #define AAC_DRIVERNAME			"aacraid"
 
@@ -355,13 +355,15 @@
 	struct Scsi_Host * host = dev->host;
 	struct scsi_cmnd * command;
 	int count;
+	struct aac_dev * aac;
 	unsigned long flags;
 
 	printk(KERN_ERR "%s: Host adapter reset request. SCSI hang ?\n", 
 					AAC_DRIVERNAME);
 
 
-	if (aac_adapter_check_health((struct aac_dev *)host->hostdata)) {
+	aac = (struct aac_dev *)host->hostdata;
+	if (aac_adapter_check_health(aac)) {
 		printk(KERN_ERR "%s: Host adapter appears dead\n", 
 				AAC_DRIVERNAME);
 		return -ENODEV;
@@ -381,15 +383,13 @@
 				}
 			}
 			spin_unlock_irqrestore(&dev->list_lock, flags);
-			if (active)
-				break;
 
+			/*
+			 * We can exit If all the commands are complete
+			 */
+			if (active == 0)
+				return SUCCESS;
 		}
-		/*
-		 * We can exit If all the commands are complete
-		 */
-		if (active == 0)
-			return SUCCESS;
 		spin_unlock_irq(host->host_lock);
 		scsi_sleep(HZ);
 		spin_lock_irq(host->host_lock);
@@ -461,7 +461,11 @@
 	.this_id        		= 16,
 	.sg_tablesize   		= 16,
 	.max_sectors    		= 128,
+#if (AAC_NUM_IO_FIB > 256)
+	.cmd_per_lun			= 256,
+#else		
 	.cmd_per_lun    		= AAC_NUM_IO_FIB, 
+#endif	
 	.use_clustering			= ENABLE_CLUSTERING,
 };
 
@@ -521,7 +525,7 @@
 	for (container = 0; container < MAXIMUM_NUM_CONTAINERS; container++)
 		fsa_dev_ptr->devname[container][0] = '\0';
 
-	if ((*aac_drivers[index].init)(aac , shost->unique_id))
+	if ((*aac_drivers[index].init)(aac))
 		goto out_free_fibs;
 
 	/*
@@ -552,7 +556,7 @@
 	 * dmb - we may need to move the setting of these parms somewhere else once
 	 * we get a fib that can report the actual numbers
 	 */
-	shost->max_id = AAC_MAX_TARGET;
+	shost->max_id = MAXIMUM_NUM_CONTAINERS;
 	shost->max_lun = AAC_MAX_LUN;
 
 	error = scsi_add_host(shost, &pdev->dev);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/README 2.6.7-ac/drivers/scsi/aacraid/README
--- linux-2.6.7/drivers/scsi/aacraid/README	2004-06-16 21:11:36.395379136 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/README	2004-05-30 17:40:52.000000000 +0100
@@ -10,20 +10,22 @@
 
 Supported Cards/Chipsets
 -------------------------
+	AAR-2410SA SATA
+	Adaptec 2120S
+	Adaptec 2200S
+	Adaptec 2230S
+	Adaptec 3230S
+	Adaptec 3240S
+	Adaptec 5400S
+	ASR-2020S PCI-X
 	Dell PERC 2 Quad Channel
 	Dell PERC 2/Si
 	Dell PERC 3/Si
 	Dell PERC 3/Di
+	Dell CERC 2
 	HP NetRAID-4M
-	ADAPTEC 2120S
-	ADAPTEC 2200S
-	ADAPTEC 5400S
 	Legend S220
 	Legend S230
-	Adaptec 3230S
-	Adaptec 3240S
-	ASR-2020S PCI-X
-	AAR-2410SA SATA
 
 People
 -------------------------
@@ -46,7 +48,7 @@
 
 Mailing List
 -------------------------
-linux-aacraid-devel@dell.com (Interested parties troll here)
+linux-scsi@vger.kernel.org (Interested parties troll here)
 http://mbserver.adaptec.com/ (Currently more Community Support than Devel Support)
 Also note this is very different to Brian's original driver
 so don't expect him to support it.
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/rkt.c 2.6.7-ac/drivers/scsi/aacraid/rkt.c
--- linux-2.6.7/drivers/scsi/aacraid/rkt.c	2004-06-16 21:10:05.000000000 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/rkt.c	2004-05-30 18:35:26.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
+#include <linux/time.h>
 #include <linux/interrupt.h>
 #include <asm/semaphore.h>
 
@@ -67,8 +68,8 @@
 			rkt_writel(dev, InboundDoorbellReg,DoorBellPrintfDone);
 		}
 		else if (bellbits & DoorBellAdapterNormCmdReady) {
-			aac_command_normal(&dev->queues->queue[HostNormCmdQueue]);
 			rkt_writel(dev, MUnit.ODR, DoorBellAdapterNormCmdReady);
+			aac_command_normal(&dev->queues->queue[HostNormCmdQueue]);
 		}
 		else if (bellbits & DoorBellAdapterNormRespReady) {
 			aac_response_normal(&dev->queues->queue[HostNormRespQueue]);
@@ -305,7 +306,7 @@
 	struct aac_init *init;
 
 	init = dev->init;
-	init->HostElapsedSeconds = cpu_to_le32(jiffies/HZ);
+	init->HostElapsedSeconds = cpu_to_le32(get_seconds());
 	/*
 	 *	Tell the adapter we are back and up and running so it will scan
 	 *	its command queues and enable our interrupts
@@ -341,12 +342,38 @@
 	if (status & SELF_TEST_FAILED)
 		return -1;
 	/*
-	 *	Check to see if the board panic'd while booting.
+	 *	Check to see if the board panic'd.
 	 */
 	if (status & KERNEL_PANIC)
-		return -2;
+	{
+		char * buffer = kmalloc(512, GFP_KERNEL|__GFP_DMA);
+		struct POSTSTATUS {
+			u32 Post_Command;
+			u32 Post_Address;
+		} * post = kmalloc(sizeof(struct POSTSTATUS), GFP_KERNEL);
+		dma_addr_t paddr = pci_map_single(dev->pdev, post, sizeof(struct POSTSTATUS), 2);
+		dma_addr_t baddr = pci_map_single(dev->pdev, buffer, 512, 1);
+		u32 status = -1;
+		int ret = -2;
+		
+		memset(buffer, 0, 512);
+		post->Post_Command = cpu_to_le32(COMMAND_POST_RESULTS);
+		post->Post_Address = cpu_to_le32(baddr);
+		rkt_writel(dev, MUnit.IMRx[0], cpu_to_le32(paddr));
+		rkt_sync_cmd(dev, COMMAND_POST_RESULTS, baddr, &status);
+		pci_unmap_single(dev->pdev, paddr, sizeof(struct POSTSTATUS),2);
+		kfree(post);
+		if ((buffer[0] == '0') && (buffer[1] == 'x')) {
+			ret = (buffer[2] <= '9') ? (buffer[2] - '0') : (buffer[2] - 'A' + 10);
+			ret <<= 4;
+			ret += (buffer[3] <= '9') ? (buffer[3] - '0') : (buffer[3] - 'A' + 10);
+		}
+		pci_unmap_single(dev->pdev, baddr, 512, 1);
+		kfree(buffer);
+		return ret;
+	}
 	/*
-	 *	Wait for the adapter to be up and running. Wait up to 3 minutes
+	 *	Wait for the adapter to be up and running.
 	 */
 	if (!(status & KERNEL_UP_AND_RUNNING))
 		return -3;
@@ -354,26 +381,24 @@
 	 *	Everything is OK
 	 */
 	return 0;
-} /* aac_rkt_check_health */
+}
 
 /**
  *	aac_rkt_init	-	initialize an i960 based AAC card
  *	@dev: device to configure
- *	@devnum: adapter number
  *
  *	Allocate and set up resources for the i960 based AAC variants. The 
  *	device_interface in the commregion will be allocated and linked 
  *	to the comm region.
  */
 
-int aac_rkt_init(struct aac_dev *dev, unsigned long num)
+int aac_rkt_init(struct aac_dev *dev)
 {
 	unsigned long start;
 	unsigned long status;
 	int instance;
 	const char * name;
 
-	dev->devnum = num;
 	instance = dev->id;
 	name     = dev->name;
 
@@ -388,14 +413,21 @@
 	/*
 	 *	Check to see if the board failed any self tests.
 	 */
-	if (rkt_readl(dev, IndexRegs.Mailbox[7]) & SELF_TEST_FAILED) {
+	if (rkt_readl(dev, MUnit.OMRx[0]) & SELF_TEST_FAILED) {
 		printk(KERN_ERR "%s%d: adapter self-test failed.\n", dev->name, instance);
 		return -1;
 	}
 	/*
+	 *	Check to see if the monitor panic'd while booting.
+	 */
+	if (rkt_readl(dev, MUnit.OMRx[0]) & MONITOR_PANIC) {
+		printk(KERN_ERR "%s%d: adapter monitor panic.\n", dev->name, instance);
+		return -1;
+	}
+	/*
 	 *	Check to see if the board panic'd while booting.
 	 */
-	if (rkt_readl(dev, IndexRegs.Mailbox[7]) & KERNEL_PANIC) {
+	if (rkt_readl(dev, MUnit.OMRx[0]) & KERNEL_PANIC) {
 		printk(KERN_ERR "%s%d: adapter kernel panic'd.\n", dev->name, instance);
 		return -1;
 	}
@@ -403,7 +435,7 @@
 	/*
 	 *	Wait for the adapter to be up and running. Wait up to 3 minutes
 	 */
-	while (!(rkt_readl(dev, IndexRegs.Mailbox[7]) & KERNEL_UP_AND_RUNNING)) 
+	while (!(rkt_readl(dev, MUnit.OMRx[0]) & KERNEL_UP_AND_RUNNING))
 	{
 		if(time_after(jiffies, start+180*HZ))
 		{
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/rx.c 2.6.7-ac/drivers/scsi/aacraid/rx.c
--- linux-2.6.7/drivers/scsi/aacraid/rx.c	2004-06-16 21:10:05.000000000 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/rx.c	2004-05-30 18:34:16.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
+#include <linux/time.h>
 #include <linux/interrupt.h>
 #include <asm/semaphore.h>
 
@@ -67,8 +68,8 @@
 			rx_writel(dev, InboundDoorbellReg,DoorBellPrintfDone);
 		}
 		else if (bellbits & DoorBellAdapterNormCmdReady) {
-			aac_command_normal(&dev->queues->queue[HostNormCmdQueue]);
 			rx_writel(dev, MUnit.ODR, DoorBellAdapterNormCmdReady);
+			aac_command_normal(&dev->queues->queue[HostNormCmdQueue]);
 		}
 		else if (bellbits & DoorBellAdapterNormRespReady) {
 			aac_response_normal(&dev->queues->queue[HostNormRespQueue]);
@@ -305,7 +306,7 @@
 	struct aac_init *init;
 
 	init = dev->init;
-	init->HostElapsedSeconds = cpu_to_le32(jiffies/HZ);
+	init->HostElapsedSeconds = cpu_to_le32(get_seconds());
 	/*
 	 *	Tell the adapter we are back and up and running so it will scan
 	 *	its command queues and enable our interrupts
@@ -341,12 +342,36 @@
 	if (status & SELF_TEST_FAILED)
 		return -1;
 	/*
-	 *	Check to see if the board panic'd while booting.
+	 *	Check to see if the board panic'd.
 	 */
-	if (status & KERNEL_PANIC)
-		return -2;
+	if (status & KERNEL_PANIC) {
+		char * buffer = kmalloc(512, GFP_KERNEL);
+		struct POSTSTATUS {
+			u32 Post_Command;
+			u32 Post_Address;
+		} * post = kmalloc(sizeof(struct POSTSTATUS), GFP_KERNEL);
+		dma_addr_t paddr = pci_map_single(dev->pdev, post, sizeof(struct POSTSTATUS), 2);
+		dma_addr_t baddr = pci_map_single(dev->pdev, buffer, 512, 1);
+		u32 status = -1;
+		int ret = -2;
+		memset(buffer, 0, 512);
+		post->Post_Command = cpu_to_le32(COMMAND_POST_RESULTS);
+		post->Post_Address = cpu_to_le32(baddr);
+		rx_writel(dev, MUnit.IMRx[0], cpu_to_le32(paddr));
+		rx_sync_cmd(dev, COMMAND_POST_RESULTS, baddr, &status);
+		pci_unmap_single(dev->pdev, paddr, sizeof(struct POSTSTATUS), 2);
+		kfree(post);
+		if ((buffer[0] == '0') && (buffer[1] == 'x')) {
+			ret = (buffer[2] <= '9') ? (buffer[2] - '0') : (buffer[2] - 'A' + 10);
+			ret <<= 4;
+			ret += (buffer[3] <= '9') ? (buffer[3] - '0') : (buffer[3] - 'A' + 10);
+		}
+		pci_unmap_single(dev->pdev, baddr, 512, 1);
+		kfree(buffer);
+		return ret;
+	}
 	/*
-	 *	Wait for the adapter to be up and running. Wait up to 3 minutes
+	 *	Wait for the adapter to be up and running.
 	 */
 	if (!(status & KERNEL_UP_AND_RUNNING))
 		return -3;
@@ -359,21 +384,19 @@
 /**
  *	aac_rx_init	-	initialize an i960 based AAC card
  *	@dev: device to configure
- *	@devnum: adapter number
  *
  *	Allocate and set up resources for the i960 based AAC variants. The 
  *	device_interface in the commregion will be allocated and linked 
  *	to the comm region.
  */
 
-int aac_rx_init(struct aac_dev *dev, unsigned long num)
+int aac_rx_init(struct aac_dev *dev)
 {
 	unsigned long start;
 	unsigned long status;
 	int instance;
 	const char * name;
 
-	dev->devnum = num;
 	instance = dev->id;
 	name     = dev->name;
 
@@ -388,22 +411,30 @@
 	/*
 	 *	Check to see if the board failed any self tests.
 	 */
-	if (rx_readl(dev, IndexRegs.Mailbox[7]) & SELF_TEST_FAILED) {
+	if (rx_readl(dev, MUnit.OMRx[0]) & SELF_TEST_FAILED) {
 		printk(KERN_ERR "%s%d: adapter self-test failed.\n", dev->name, instance);
 		return -1;
 	}
 	/*
 	 *	Check to see if the board panic'd while booting.
 	 */
-	if (rx_readl(dev, IndexRegs.Mailbox[7]) & KERNEL_PANIC) {
-		printk(KERN_ERR "%s%d: adapter kernel panic'd.\n", dev->name, instance);
+	if (rx_readl(dev, MUnit.OMRx[0]) & KERNEL_PANIC) {
+		printk(KERN_ERR "%s%d: adapter kernel panic.\n", dev->name, instance);
+		return -1;
+	}
+	/*
+	 *	Check to see if the monitor panic'd while booting.
+	 */
+	if (rx_readl(dev, MUnit.OMRx[0]) & MONITOR_PANIC) {
+		printk(KERN_ERR "%s%d: adapter monitor panic.\n", dev->name, instance);
 		return -1;
 	}
 	start = jiffies;
 	/*
 	 *	Wait for the adapter to be up and running. Wait up to 3 minutes
 	 */
-	while (!(rx_readl(dev, IndexRegs.Mailbox[7]) & KERNEL_UP_AND_RUNNING)) 
+	while ((!(rx_readl(dev, IndexRegs.Mailbox[7]) & KERNEL_UP_AND_RUNNING))
+		|| (!(rx_readl(dev, MUnit.OMRx[0]) & KERNEL_UP_AND_RUNNING)))
 	{
 		if(time_after(jiffies, start+180*HZ))
 		{
@@ -435,6 +466,11 @@
 	 *	Start any kernel threads needed
 	 */
 	dev->thread_pid = kernel_thread((int (*)(void *))aac_command_thread, dev, 0);
+	if(dev->thread_pid < 0)
+	{
+		printk(KERN_ERR "aacraid: Unable to create rx thread.\n");
+		return -1;
+	}
 	/*
 	 *	Tell the adapter that all is configured, and it can start
 	 *	accepting requests
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/sa.c 2.6.7-ac/drivers/scsi/aacraid/sa.c
--- linux-2.6.7/drivers/scsi/aacraid/sa.c	2004-06-16 21:11:36.399378528 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/sa.c	2004-05-30 18:16:25.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
+#include <linux/time.h>
 #include <linux/interrupt.h>
 #include <asm/semaphore.h>
 
@@ -329,27 +330,24 @@
 	 *	Everything is OK
 	 */
 	return 0;
-} /* aac_sa_check_health */
+}
 
 /**
  *	aac_sa_init	-	initialize an ARM based AAC card
  *	@dev: device to configure
- *	@devnum: adapter number
  *
  *	Allocate and set up resources for the ARM based AAC variants. The 
  *	device_interface in the commregion will be allocated and linked 
  *	to the comm region.
  */
 
-int aac_sa_init(struct aac_dev *dev, unsigned long devnum)
+int aac_sa_init(struct aac_dev *dev)
 {
 	unsigned long start;
 	unsigned long status;
 	int instance;
 	const char *name;
 
-	dev->devnum = devnum;
-
 	dprintk(("PREINST\n"));
 	instance = dev->id;
 	name     = dev->name;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/scsi/aacraid/TODO 2.6.7-ac/drivers/scsi/aacraid/TODO
--- linux-2.6.7/drivers/scsi/aacraid/TODO	2004-06-16 21:10:05.000000000 +0100
+++ 2.6.7-ac/drivers/scsi/aacraid/TODO	2004-05-30 17:41:11.000000000 +0100
@@ -2,3 +2,5 @@
 o	More testing
 o	Feature request: display the firmware/bios/etc revisions in the
 	/proc info
+o	Drop irq_mask, basically unused
+o	I/O size increase

        Developer's Certificate of Origin 1.0
 
        By making a contribution to this project, I certify that:
 
        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or
 
        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or
                                                                                
        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.
                                                                                
        Signed-off-by: Alan Cox <alan@redhat.com>
	
Original contribution under GPL from Adaptec, updates checking by Red Hat



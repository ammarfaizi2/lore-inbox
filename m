Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVFQWrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFQWrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVFQWrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:47:39 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:15318 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261281AbVFQWi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mP5QVtP/07QMaJXDbgvRbelf4GOlwnBWhs+mHBHtmo60GveSmXfxtyAvdEFAAH7GdhX7DKfCmtRhXqQw/idSX9wrZ6XmsvrVHcpG6V1C0SML8cG0MQ3KqqCKCRxhmEjxWt3cwPGltU4cdvXw54uP+bU8jNih3FqDJvQ18tQuShY=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Donald.Huang@ite.com.tw, akpm@osdl.org
Subject: [PATCH 2/3] iteraid: misc trivial cleanups
Date: Sat, 18 Jun 2005 02:41:36 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506180241.37168.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fix noticed typos.
* Use C99 initializers.
* Remove unneeded prorotypes.
* Remove useless comments.
* Shrink vertical whitespace a bit.
/************************************************************************
 * Remove banners.
 ************************************************************************/

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/iteraid.c |  497 +++++++++++++++----------------------------------
 drivers/scsi/iteraid.h |  273 ++++++++------------------
 2 files changed, 240 insertions(+), 530 deletions(-)

Index: linux-iteraid/drivers/scsi/iteraid.c
===================================================================
--- linux-iteraid.orig/drivers/scsi/iteraid.c	2005-06-18 00:53:07.000000000 +0400
+++ linux-iteraid/drivers/scsi/iteraid.c	2005-06-18 02:00:27.000000000 +0400
@@ -70,7 +70,7 @@
  * ATAPI support ---> schedule is three weeks. (2003/02/28)
  *
  * Revision 1.3 2003/02/27
- * First relase ATAPI version. But there will be an error if no disc in the
+ * First release ATAPI version. But there will be an error if no disc in the
  * CD-ROM. Because the commands like TEST_UNIT_READY and READ_CAPACITY will
  * get the error response. This situration in WINDOWS will be then send the
  * REQUEST SENSE command to the device but in Linux, it will never get
@@ -274,39 +274,24 @@ static Scsi_Cmnd *it8212_req_last = NULL
 static unsigned int NumAdapters = 0;	/* Adapters number              */
 static PITE_ADAPTER ite_adapters[2];	/* How many adapters support    */
 
-/************************************************************************
- * Notifier blockto get a notify on system shutdown/halt/reboot.
- ************************************************************************/
+/*
+ * Notifier block to get a notify on system shutdown/halt/reboot.
+ */
 static int ite_halt(struct notifier_block *nb, ulong event, void *buf);
-static struct notifier_block ite_notifier = { ite_halt, NULL, 0
+static struct notifier_block ite_notifier = {
+	.notifier_call	= ite_halt,
+	.next		= NULL,
+	.priority	= 0
 };
 static struct semaphore mimd_entry_mtx;
 static spinlock_t queue_request_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t io_request_lock = SPIN_LOCK_UNLOCKED;
 
-static int iteraid_detect(Scsi_Host_Template *);
-static int iteraid_release(struct Scsi_Host *);
-#if 0
-static int iteraid_command(Scsi_Cmnd *);
-#endif
-static int iteraid_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
-static int iteraid_biosparam(struct scsi_device *, struct block_device *,
-				sector_t, int *);
-static int iteraid_proc_info(struct Scsi_Host *, char *buffer, char **start,
-		      off_t offset, int length, int inout);
-
-static void TaskStart(PChannel, Scsi_Cmnd *);
 static void TaskQueue(void);
 static void TaskDone(PChannel, PSCSI_REQUEST_BLOCK);
-static u32 IdeSendCommand(PChannel, PSCSI_REQUEST_BLOCK);
-//static void IdeMediaStatus(u8, PChannel, u8);
-static void IdeSetupDma(PChannel, unsigned long, unsigned short);
-static void MapRequest(Scsi_Cmnd *, PSCSI_REQUEST_BLOCK);
 static u8 IssueIdentify(PChannel, u8, u8);
 static u8 IT8212ResetAdapter(PITE_ADAPTER);
-static void AtapiStartIo(PChannel, PSCSI_REQUEST_BLOCK);
 static u8 AtapiInterrupt(PChannel);
-static void AtapiResetController(PITE_ADAPTER pAdap, PChannel pChan);
 
 static int itedev_open(struct inode *, struct file *);
 static int itedev_ioctl_entry(struct inode *, struct file *, unsigned int,
@@ -315,23 +300,21 @@ static int itedev_ioctl(struct inode *, 
 			unsigned long);
 static int itedev_close(struct inode *, struct file *);
 
-
 #define DRV_VER_8212 "1.45"
-static int driver_ver = 145;	/* Current driver version       */
-static int ite_major = 0;	/* itedev chardev major number  */
+static int driver_ver = 145;
+static int ite_major = 0;
 
-/************************************************************************
- * The File Operations structure for the ioctl interface of the driver.
- ************************************************************************/
-static struct file_operations itedev_fops =
-    {.owner = THIS_MODULE,.ioctl = itedev_ioctl_entry,.open =
-itedev_open,.release = itedev_close
+static struct file_operations itedev_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= itedev_ioctl_entry,
+	.open		= itedev_open,
+	.release	= itedev_close
 };
 
 #if (MARK_DEBUG_DUMP_MEM)
-/************************************************************************
+/*
  * Dump buffer.
- ************************************************************************/
+ */
 static void HexDump(unsigned char *buf, int length)
 {
 	unsigned int i = 0;
@@ -351,9 +334,9 @@ static void HexDump(unsigned char *buf, 
 }				/* end HexDump */
 #endif
 
-/************************************************************************
+/*
  * This routine maps ATAPI and IDE errors to specific SRB statuses.
- ************************************************************************/
+ */
 static u8 MapError(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	u8 errorByte;
@@ -569,25 +552,9 @@ static u8 MapError(PChannel pChan, PSCSI
 	return srbStatus;
 }				/* end MapError */
 
-#if 0
-/************************************************************************
- * Just get the higest bit value.
- ************************************************************************/
-static u8 RaidGetHighestBit(u8 Number)
-{
-	char bit;
-
-	for (bit = 7; bit >= 0; bit--) {
-		if (Number & (1 << bit))
-			return bit;
-	}
-	return 0xFF;
-}				/* end RaidGetHighestBit */
-#endif
-
-/************************************************************************
+/*
  * Reset IDE controller or ATAPI device.
- ************************************************************************/
+ */
 static void AtapiResetController(PITE_ADAPTER pAdap, PChannel pChan)
 {
 	u8 resetResult;
@@ -681,9 +648,9 @@ static void AtapiResetController(PITE_AD
 	printk("AtapiResetController exit\n");
 }				/* end AtapiResetController */
 
-/************************************************************************
+/*
  * IDE start read/write transfer.
- ************************************************************************/
+ */
 static void IdeStartTransfer(PChannel pChan, PSCSI_REQUEST_BLOCK Srb,
 			u32 startingSector, u32 SectorNumber)
 {
@@ -815,9 +782,9 @@ static void IdeStartTransfer(PChannel pC
 	dprintk("IdeStartTransfer exit\n");
 }				/* end IdeStartTransfer */
 
-/************************************************************************
+/*
  * Setup the PRD table.
- ************************************************************************/
+ */
 static int IdeBuildSglist(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	int nents = 0;
@@ -840,9 +807,9 @@ static int IdeBuildSglist(PChannel pChan
 	return pci_map_sg(pChan->pPciDev, sg, nents, pChan->sg_dma_direction);
 }				/* end IdeBuildSglist */
 
-/************************************************************************
+/*
  * Prepares a dma request.
- ************************************************************************/
+ */
 static int IdeBuildDmaTable(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	unsigned long *table = pChan->dmatable_cpu;
@@ -905,9 +872,9 @@ static int IdeBuildDmaTable(PChannel pCh
 	return count;
 }				/* end IdeBuildDmaTable */
 
-/************************************************************************
+/*
  * Prepares a dma scatter/gather request.
- ************************************************************************/
+ */
 static void IdeBuildDmaSgTable(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	int use_sg = 0;
@@ -929,9 +896,9 @@ static void IdeBuildDmaSgTable(PChannel 
 	}
 }				/* end IdeBuildDmaSgTable */
 
-/************************************************************************
+/*
  * Setup DMA table for channel.
- ************************************************************************/
+ */
 static void
 IdeSetupDma(PChannel pChan, unsigned long dma_base, unsigned short num_ports)
 {
@@ -950,9 +917,6 @@ IdeSetupDma(PChannel pChan, unsigned lon
 	}
 	memset(pChan->dmatable_cpu, 0, PRD_ENTRIES * PRD_BYTES);
 
-	/*
-	 * Allocate SCATTER/GATHER table buffer.
-	 */
 	pChan->sg_table =
 	    kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES, GFP_KERNEL);
 	if (pChan->sg_table == NULL) {
@@ -964,9 +928,9 @@ IdeSetupDma(PChannel pChan, unsigned lon
 	return;
 }				/* end IdeSetupDma */
 
-/************************************************************************
+/*
  * This will be only used in RAID mode.
- ************************************************************************/
+ */
 static void IT8212ReconfigChannel(PChannel pChan, u8 ArrayId, u8 Operation)
 {
 	u8 enableVirtualChannel;
@@ -989,16 +953,15 @@ static void IT8212ReconfigChannel(PChann
 	pci_write_config_byte(pPciDev, 0x43, enableVirtualChannel);
 }				/* end IT8212ReconfigChannel */
 
-/************************************************************************
- * Get the chip status. This is a vendor specific command. According to
- * all of the device configurations, the BIOS then can consider the
- * existing RAID configuration reasonable. If the existing RAID configur-
- * ation is not reasonable, or if there is NO existing RAID configuration
- * , the BIOS can ask the user to setup the RAID configuration. Finally,
- * the BIOS or AP should send the SET CHIP STATUS to every virtual device.
- * Only after receiving SET CHIP STATUS command, the corresponding virtual
- * device will be active.
- ************************************************************************/
+/*
+ * This is a vendor specific command. According to all of the device
+ * configurations, the BIOS then can consider the existing RAID configuration
+ * reasonable. If the existing RAID configuration is not reasonable, or if
+ * there is NO existing RAID configuration, the BIOS can ask the user to setup
+ * the RAID configuration. Finally, the BIOS or AP should send the SET CHIP
+ * STATUS to every virtual device. Only after receiving SET CHIP STATUS
+ * command, the corresponding virtual device will be active.
+ */
 static u8 IT8212GetChipStatus(uioctl_t * ioc)
 {
 	u8 PriMasterIsNull = FALSE;
@@ -1018,9 +981,6 @@ static u8 IT8212GetChipStatus(uioctl_t *
 	pAdap = ite_adapters[0];
 	pChan = &pAdap->IDEChannel[0];
 
-	/*
-	 * Allocate space for PHYSICAL_DISK_STATUS.
-	 */
 	pPhyDiskInfo = kmalloc(sizeof(PHYSICAL_DISK_STATUS) * 4, GFP_KERNEL);
 	if (pPhyDiskInfo == NULL) {
 		printk("IT8212GetChipStatus: error kmalloc for "
@@ -1083,12 +1043,8 @@ static u8 IT8212GetChipStatus(uioctl_t *
 
 #if (0)
 	HexDump((unsigned char *)pPhyDiskInfo, 512);
-
 #endif
 
-	/*
-	 * Copy physical disk info to user area.
-	 */
 	copy_to_user((unsigned short *)ioc->data,
 		     (unsigned char *)pPhyDiskInfo, 512);
 
@@ -1125,9 +1081,9 @@ exit:
 	return srbStatus;
 }				/* end IT8212GetChipStatus */
 
-/************************************************************************
+/*
  * Erase the partition table.
- ************************************************************************/
+ */
 static unsigned char IT8212ErasePartition(uioctl_t * pioc)
 {
 	unsigned char drvSelect;
@@ -1149,9 +1105,6 @@ static unsigned char IT8212ErasePartitio
 	else
 		pChan = &pAdap->IDEChannel[1];
 
-	/*
-	 * Allocate 512 bytes for buffer.
-	 */
 	if ((buffer = kmalloc(512, GFP_KERNEL)) == NULL) {
 		printk("IT8212ErasePartition: error kmalloc.\n");
 		return -ENOMEM;
@@ -1232,9 +1185,6 @@ exit:
 	return srbStatus;
 }				/* end IT8212ErasePartition */
 
-/************************************************************************
- *
- ************************************************************************/
 static u32 IT8212TruncateReduentSectors(u32 OriginalSectorCount,
 				u16 StripeSizeInKBytes)
 {
@@ -1251,9 +1201,9 @@ static u32 IT8212TruncateReduentSectors(
 		stripeSizeInSector);
 }				/* end IT8212TruncateReduentSectors */
 
-/************************************************************************
+/*
  * Calculate the addressable sector for this RAID.
- ************************************************************************/
+ */
 static u32 IT8212DiskArrayAddressableSector(unsigned char *DiskArrayCreateInfo)
 {
 	u8 DiskNo;
@@ -1272,7 +1222,6 @@ static u32 IT8212DiskArrayAddressableSec
 	printk("createInfo->AddressableSectors[3] = 0x%X\n",
 	       createInfo->AddressableSectors[3]);
 	for (DiskNo = 0; DiskNo < 4; DiskNo++) {
-
 		/*
 		 * If disk exist.
 		 */
@@ -1287,7 +1236,6 @@ static u32 IT8212DiskArrayAddressableSec
 		}
 	}
 	switch (createInfo->RaidType) {
-
 		/*
 		 * Containing 2 or 3 or 4 disks.
 		 */
@@ -1339,9 +1287,9 @@ static u32 IT8212DiskArrayAddressableSec
 	return ArrayCapacity;
 }				/* end IT8212DiskArrayAddressableSector */
 
-/************************************************************************
+/*
  * Create a new array.
- ************************************************************************/
+ */
 static u8 IT8212CreateDiskArray(uioctl_t * pioc)
 {
 	u8 i;
@@ -1358,21 +1306,23 @@ static u8 IT8212CreateDiskArray(uioctl_t
 	PRAID_CREATE_INFO createInfo = (PRAID_CREATE_INFO) pioc->data;
 	PIDENTIFY_DATA2 identifyData;
 	PIT8212_SET_CHIP_STATUS_INFO setChipStatus;
-	static const u16 IT8212TimingTable[7] = { 0x3133,	/* UDMA timimg register 01              */
-		0x2121,		/* UDMA timimg register 23              */
-		0x9111,		/* UDMA timimg register 45              */
-		0x0091,		/* UDMA timimg register 6               */
-		0x3266,		/* DMA  timimg register 01              */
-		0x0021,		/* DMA  timimg register 2               */
-		0x0021		/* PIO  timimg register                 */
+	static const u16 IT8212TimingTable[7] = {
+		0x3133,	/* UDMA timimg register 01 */
+		0x2121,	/* UDMA timimg register 23 */
+		0x9111,	/* UDMA timimg register 45 */
+		0x0091,	/* UDMA timimg register 6  */
+		0x3266,	/* DMA  timimg register 01 */
+		0x0021,	/* DMA  timimg register 2  */
+		0x0021	/* PIO  timimg register    */
 	};
-	static const u16 IT8212ClockTable[7] = { 0x0505,	/* UDMA clock register 01               */
-		0x0005,		/* UDMA clock register 23               */
-		0x0500,		/* UDMA clock register 45               */
-		0x0000,		/* UDMA clock register 6                */
-		0x0005,		/* DMA  clock register 01               */
-		0x0005,		/* DMA  clock register 2                */
-		0x0005		/* PIO  clock register                  */
+	static const u16 IT8212ClockTable[7] = {
+		0x0505,	/* UDMA clock register 01 */
+		0x0005,	/* UDMA clock register 23 */
+		0x0500,	/* UDMA clock register 45 */
+		0x0000,	/* UDMA clock register 6  */
+		0x0005,	/* DMA  clock register 01 */
+		0x0005,	/* DMA  clock register 2  */
+		0x0005	/* PIO  clock register    */
 	};
 
 	printk("IT8212CreateDiskArray enter\n");
@@ -1421,7 +1371,7 @@ static u8 IT8212CreateDiskArray(uioctl_t
 	printk("createInfo->AddressableSectors[3] = 0x%lX\n",
 	       createInfo->AddressableSectors[3]);
 
-#endif				/*  */
+#endif
 	switch (createInfo->RaidType) {
 	case RAID_LEVEL_0:
 	case RAID_LEVEL_1:
@@ -1441,9 +1391,6 @@ static u8 IT8212CreateDiskArray(uioctl_t
 	pAdap = ite_adapters[0];
 	pChan = &pAdap->IDEChannel[0];
 
-	/*
-	 * Allocate 512-bytes buffer.
-	 */
 	if ((buffer = kmalloc(512, GFP_KERNEL)) == NULL) {
 		printk("IT8212CreateDiskArray: error kmalloc.\n");
 		return -ENOMEM;
@@ -1451,7 +1398,6 @@ static u8 IT8212CreateDiskArray(uioctl_t
 	identifyData = (PIDENTIFY_DATA2) buffer;
 
 	/*
-	 * 2003/05/08
 	 * Remember the vendor specific parameters starts from word 129 not 128.
 	 */
 	setChipStatus = (PIT8212_SET_CHIP_STATUS_INFO) (buffer + 258);
@@ -1460,10 +1406,6 @@ static u8 IT8212CreateDiskArray(uioctl_t
 	 * Configure to RAID or NORMAL.
 	 */
 	if (subCommand == 0x50) {
-
-		/*
-		 * Zero identify data structure.
-		 */
 		memset((unsigned char *)identifyData, 0, sizeof(IDENTIFY_DATA));
 
 		/*
@@ -1536,7 +1478,6 @@ static u8 IT8212CreateDiskArray(uioctl_t
 	}
 #if (MARK_DEBUG_DUMP_MEM)
 	HexDump(buffer, 512);
-
 #endif
 
 	/*
@@ -1647,9 +1588,9 @@ exit:
 }				/* end IT8212CreateDiskArray */
 
 #if 0
-/************************************************************************
+/*
  * Return "virtual" drive 512 bytes identification data.
- ************************************************************************/
+ */
 static u8 IT8212IssueIdentify(uioctl_t *pioc)
 {
 	u8 channum;
@@ -1738,9 +1679,6 @@ static u8 IT8212IssueIdentify(uioctl_t *
 				   (unsigned short *)&pChan->
 				   FullIdentifyData, 256);
 
-			/*
-			 * Then copy to user area.
-			 */
 			copy_to_user((unsigned short *)(pioc->data +
 							((devnum +
 							  channum * 2) *
@@ -1782,9 +1720,9 @@ exit:
 }				/* end IT8212IssueIdentify */
 #endif
 
-/************************************************************************
+/*
  * Reset the controller.
- ************************************************************************/
+ */
 static u8 IT8212ResetAdapter(PITE_ADAPTER pAdap)
 {
 	u8 resetChannel[2];
@@ -1877,9 +1815,9 @@ static u8 IT8212ResetAdapter(PITE_ADAPTE
 	}
 }				/* end IT8212ResetAdapter */
 
-/************************************************************************
+/*
  * Rebuild disk array.
- ************************************************************************/
+ */
 static u8 IT8212Rebuild(uioctl_t * pioc)
 {
 	u8 rebuildDirection;
@@ -1902,7 +1840,7 @@ static u8 IT8212Rebuild(uioctl_t * pioc)
 		pChan = &pAdap->IDEChannel[1];
 
 	/*
-	 * Selcet device.
+	 * Select device.
 	 */
 	outb((u8) ((apRebuildInfo->DiskArrayId & 0x1) << 4 | 0xA0),
 	     pChan->io_ports[IDE_SELECT_OFFSET]);
@@ -1956,7 +1894,7 @@ static u8 IT8212Rebuild(uioctl_t * pioc)
 	return SRB_STATUS_PENDING;
 }				/* end IT8212Rebuild */
 
-/************************************************************************
+/*
  * Switch to DMA mode if necessary.
  *
  * offset 0x50 = PCI Mode Control Register
@@ -1969,7 +1907,7 @@ static u8 IT8212Rebuild(uioctl_t * pioc)
  * Bit 5 = Secondary Channel Dev 0 Transfer Mode (1=MultiWord DMA, 0=Ultra DMA)
  * Bit 6 = Secondary Channel Dev 1 Transfer Mode (1=MultiWord DMA, 0=Ultra DMA)
  * Bit 7 = PCI Mode Reset
- ************************************************************************/
+ */
 static void IT8212SwitchDmaMode(PChannel pChan, u8 DeviceId)
 {
 	u8 pciControl;
@@ -2066,9 +2004,6 @@ static void IT8212SwitchDmaMode(PChannel
 	pChan->ActiveDevice = device;
 }				/* end IT8212SwitchDmaMode */
 
-/************************************************************************
- * IT8212 read/write routine.
- ************************************************************************/
 static u32 IT8212ReadWrite(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	u8 statusByte = 0;
@@ -2149,9 +2084,6 @@ static u32 IT8212ReadWrite(PChannel pCha
 	else
 		IdeBuildDmaSgTable(pChan, Srb);
 
-	/*
-	 * Start transfer the data.
-	 */
 	IdeStartTransfer(pChan, Srb, startingSector, sectorNumber);
 
 	/*
@@ -2161,9 +2093,9 @@ static u32 IT8212ReadWrite(PChannel pCha
 }				/* end IT8212ReadWrite */
 
 #if 0
-/************************************************************************
+/*
  * Setup the transfer mode.
- ************************************************************************/
+ */
 static void IT8212SetTransferMode(PChannel pChan, u32 DiskId, u8 TransferMode,
 			u8 ModeNumber)
 {
@@ -2219,9 +2151,6 @@ static void IT8212SetTransferMode(PChann
 #endif
 
 #if 0
-/************************************************************************
- * Set the best transfer mode for device.
- ************************************************************************/
 static void IT8212SetBestTransferMode(PITE_ADAPTER pAdap, PChannel pChan,
 					u8 channel)
 {
@@ -2285,13 +2214,11 @@ static void IT8212SetBestTransferMode(PI
 	static const u8 ideClock[4] = { 0xFD, 0xFD, 0xFB, 0xFB };
 
 	/*
-	 * 2003/07/24
 	 * If running on Firmware mode, get cable status from it.
 	 */
 	for (i = 0; i < 2; i++) {
-
 		/*
-		 * The dafault of cable status is in PCI configuration 0x40.
+		 * The default of cable status is in PCI configuration 0x40.
 		 */
 		cableStatus[i] = pChan->Cable80[i];
 
@@ -2597,12 +2524,11 @@ static void IT8212SetBestTransferMode(PI
 #endif
 
 #if 0
-/************************************************************************
+/*
  * Initialize bypass(transparent) mode if BIOS is not ready.
- ************************************************************************/
+ */
 static u8 IT8212InitBypassMode(struct pci_dev *pPciDev)
 {
-
 	/*
 	 * Reset local CPU, and set BIOS not ready.
 	 */
@@ -2621,10 +2547,10 @@ static u8 IT8212InitBypassMode(struct pc
 }				/* end IT8212InitBypassMode */
 #endif
 
-/************************************************************************
+/*
  * This is the interrupt service routine for ATAPI IDE miniport driver.
- * TURE if expecting an interrupt.
- ************************************************************************/
+ * TRUE if expecting an interrupt.
+ */
 static u8 IT8212Interrupt(PChannel pChan, u8 bypass_mode)
 {
 	u8 statusByte;
@@ -2681,7 +2607,6 @@ static u8 IT8212Interrupt(PChannel pChan
 		return AtapiInterrupt(pChan);
 	pChan->ExpectingInterrupt = FALSE;
 	if ((statusByte & IDE_STATUS_BUSY) || (statusByte & IDE_STATUS_DRQ)) {
-
 		/*
 		 * Ensure BUSY and DRQ is non-asserted.
 		 */
@@ -2701,7 +2626,6 @@ static u8 IT8212Interrupt(PChannel pChan
 		}
 	}
 	if (statusByte & IDE_STATUS_ERROR) {
-
 		/*
 		 * Stop bus master operation.
 		 */
@@ -2720,12 +2644,12 @@ static u8 IT8212Interrupt(PChannel pChan
 	return TRUE;
 }				/* end IT8212Interrupt */
 
-/************************************************************************
+/*
  * This is the interrupt service routine for ATAPI IDE miniport driver.
  * TRUE if expecting an interrupt. Remember the ATAPI io registers are
  * different from IDE io registers and this is for each channel not for
  * entire controller.
- ************************************************************************/
+ */
 static u8 AtapiInterrupt(PChannel pChan)
 {
 	u32 wordCount;
@@ -2787,7 +2711,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 	 */
 	if (statusByte & IDE_STATUS_ERROR) {
 		if (srb->Cdb[0] != SCSIOP_REQUEST_SENSE) {
-
 			/*
 			 * Fail this request.
 			 */
@@ -2802,7 +2725,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 	interruptReason = (inb(pChan->io_ports[ATAPI_INTREASON_OFFSET]) & 0x3);
 	wordsThisInterrupt = 256;
 	if (interruptReason == 0x1 && (statusByte & IDE_STATUS_DRQ)) {
-
 		/*
 		 * Write the packet.
 		 */
@@ -2814,7 +2736,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 		WriteBuffer(pChan, (unsigned short *)srb->Cdb, 6);
 		return TRUE;
 	} else if (interruptReason == 0x0 && (statusByte & IDE_STATUS_DRQ)) {
-
 		/*
 		 * Write the data.
 		 */
@@ -2826,7 +2747,7 @@ static u8 AtapiInterrupt(PChannel pChan)
 		wordCount |= inb(pChan->io_ports[ATAPI_HCYL_OFFSET]) << 8;
 
 		/*
-		 * Covert bytes to words.
+		 * Convert bytes to words.
 		 */
 		wordCount >>= 1;
 		if (wordCount != pChan->WordsLeft) {
@@ -2872,14 +2793,10 @@ static u8 AtapiInterrupt(PChannel pChan)
 			goto CompleteRequest;
 		}
 
-		/*
-		 * Advance data buffer pointer and bytes left.
-		 */
 		pChan->DataBuffer += wordCount;
 		pChan->WordsLeft -= wordCount;
 		return TRUE;
 	} else if (interruptReason == 0x2 && (statusByte & IDE_STATUS_DRQ)) {
-
 		/*
 		 * Pick up bytes to transfer and convert to words.
 		 */
@@ -2887,7 +2804,7 @@ static u8 AtapiInterrupt(PChannel pChan)
 		wordCount |= inb(pChan->io_ports[ATAPI_HCYL_OFFSET]) << 8;
 
 		/*
-		 * Covert bytes to words.
+		 * Convert bytes to words.
 		 */
 		wordCount >>= 1;
 		if (wordCount != pChan->WordsLeft) {
@@ -2914,7 +2831,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 			 * field, in the INQUIRY response, to at least 2.
 			 */
 			if (srb->Cdb[0] == SCSIOP_INQUIRY) {
-
 				/*
 				 * Maybe it's not necessary in Linux driver.
 				 */
@@ -2931,9 +2847,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 			goto CompleteRequest;
 		}
 
-		/*
-		 * Advance data buffer pointer and bytes left.
-		 */
 		pChan->DataBuffer += wordCount;
 		pChan->WordsLeft -= wordCount;
 
@@ -2941,7 +2854,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 		 * Check for read command complete.
 		 */
 		if (pChan->WordsLeft == 0) {
-
 			/*
 			 * Work around to make many atapi devices return
 			 * correct sector size of 2048. Also certain devices
@@ -2973,7 +2885,6 @@ static u8 AtapiInterrupt(PChannel pChan)
 			status = SRB_STATUS_SUCCESS;
 CompleteRequest:
 		if (status == SRB_STATUS_ERROR) {
-
 			/*
 			 * Map error to specific SRB status and handle request
 			 * sense.
@@ -2986,7 +2897,6 @@ CompleteRequest:
 			 */
 			pChan->RDP = FALSE;
 		} else {
-
 			/*
 			 * Wait for busy to drop.
 			 */
@@ -2998,10 +2908,6 @@ CompleteRequest:
 				udelay(500);
 			}
 			if (i == 30) {
-
-				/*
-				 * Reset the controller.
-				 */
 				printk("AtapiInterrupt: resetting due to BSY "
 					"still up - %x.\n", statusByte);
 				AtapiResetController(pAdap, pChan);
@@ -3088,10 +2994,6 @@ CompleteRequest:
 		}
 		return TRUE;
 	} else {
-
-		/*
-		 * Unexpected int.
-		 */
 		printk("AtapiInterrupt: unexpected interrupt. intReason %x. "
 			"status %x.\n", interruptReason, statusByte);
 		return FALSE;
@@ -3099,9 +3001,6 @@ CompleteRequest:
 	return TRUE;
 }				/* end AtapiInterrupt */
 
-/************************************************************************
- * IRQ handler.
- ************************************************************************/
 static irqreturn_t Irq_Handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int handled = 0;
@@ -3129,9 +3028,9 @@ static irqreturn_t Irq_Handler(int irq, 
 	return IRQ_RETVAL(handled);
 }				/* end Irq_Handler */
 
-/************************************************************************
+/*
  * This routine handles IDE Verify.
- ************************************************************************/
+ */
 static u8 IdeVerify(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	u8 drvSelect;
@@ -3325,9 +3224,9 @@ IT8212MoveMemory(unsigned char *DestAddr
 	}
 }				/* end IT8212MoveMemory */
 
-/************************************************************************
+/*
  * Convert SCSI packet command to Atapi packet command.
- ************************************************************************/
+ */
 static void Scsi2Atapi(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 
@@ -3384,7 +3283,7 @@ static void Scsi2Atapi(PChannel pChan, P
 			modeSense10->Control = modeSense6->Control;
 
 			/*
-			 * 3. Becasuse we will fake a block descripter (-8), and
+			 * 3. Because we will fake a block descripter (-8), and
 			 * translate the header (+4), so the requested length
 			 * should be modified. That is, -8+4=-4 bytes.
 			 */
@@ -3430,7 +3329,7 @@ static void Scsi2Atapi(PChannel pChan, P
 			modeSelect10->Control = modeSelect6->Control;
 
 			/*
-			 * 3. Becasuse we will remove the block descripter (-8),
+			 * 3. Because we will remove the block descripter (-8),
 			 * and translate the header (+4), so the requested
 			 * length should be modified. That is, -8+4=-4 bytes.
 			 */
@@ -3494,9 +3393,9 @@ static void Scsi2Atapi(PChannel pChan, P
 	}
 }				/* end Scsi2Atapi */
 
-/************************************************************************
+/*
  * Send ATAPI packet command to device.
- ************************************************************************/
+ */
 static u32 AtapiSendCommand(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	u8 statusByte;
@@ -3545,11 +3444,10 @@ static u32 AtapiSendCommand(PChannel pCh
 	     pChan->io_ports[ATAPI_SELECT_OFFSET]);
 
 	/*
-	 * Try to enable interrupt again. (2003/02/25)
+	 * Try to enable interrupt again.
 	 */
 #if (0)
 	outb(0x00, pChan->io_ports[ATAPI_CONTROL_OFFSET]);
-
 #endif
 
 	/*
@@ -3828,9 +3726,9 @@ static u32 AtapiSendCommand(PChannel pCh
 	return SRB_STATUS_PENDING;
 }				/* end AtapiSendCommand */
 
-/************************************************************************
+/*
  * Program ATA registers for IDE disk transfer.
- ************************************************************************/
+ */
 static u32 IdeSendCommand(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	u8 statusByte;
@@ -3964,11 +3862,11 @@ static u32 IdeSendCommand(PChannel pChan
 	return status;
 }				/* end IdeSendCommand */
 
-/************************************************************************
+/*
  * This routine is called from the SCSI port driver synchronized with
  * the kernel to start an IO request. If the current SRB is busy, return
- * FALSE, else return TURE.
- ************************************************************************/
+ * FALSE, else return TRUE.
+ */
 static void AtapiStartIo(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	u32 status = 0;
@@ -4048,9 +3946,9 @@ busy:
 	}
 }				/* end AtapiStartIo */
 
-/************************************************************************
+/*
  * Convert Scsi_Cmnd structure to SCSI_REQUEST_BLOCK.
- ************************************************************************/
+ */
 static void MapRequest(Scsi_Cmnd * pREQ, PSCSI_REQUEST_BLOCK Srb)
 {
 	Srb->Length = sizeof(SCSI_REQUEST_BLOCK);
@@ -4097,10 +3995,10 @@ static void MapRequest(Scsi_Cmnd * pREQ,
 	Srb->pREQ = pREQ;
 }				/* end MapRequest */
 
-/************************************************************************
- * A task execution has been done. For OS request, we need to Notify OS
+/*
+ * A task execution has been done. For OS request, we need to notify OS
  * and invoke next take which wait at queue.
- ************************************************************************/
+ */
 static void TaskDone(PChannel pChan, PSCSI_REQUEST_BLOCK Srb)
 {
 	Scsi_Cmnd *pREQ = Srb->pREQ;
@@ -4147,18 +4045,15 @@ static void TaskDone(PChannel pChan, PSC
 	TaskQueue();
 }				/* end TaskDone */
 
-/************************************************************************
+/*
  * Start a command, doing convert first.
- ************************************************************************/
+ */
 static void TaskStart(PChannel pChan, Scsi_Cmnd * pREQ)
 {
 	PSCSI_REQUEST_BLOCK Srb;
 	dprintk("TaskStart(pChan=%p, pREQ=%p)\n", pChan, pREQ);
 	Srb = &pChan->_Srb;
 
-	/*
-	 * Clear the SRB structure.
-	 */
 	memset(Srb, 0, sizeof(SCSI_REQUEST_BLOCK));
 
 	/*
@@ -4172,10 +4067,10 @@ static void TaskStart(PChannel pChan, Sc
 	AtapiStartIo(pChan, Srb);
 }				/* end TaskStart */
 
-/************************************************************************
+/*
  * Check if queue is empty. If there are request in queue, transfer the
  * request to HIM's request and execute the request.
- ************************************************************************/
+ */
 static void TaskQueue(void)
 {
 	unsigned long flags;
@@ -4230,13 +4125,13 @@ check_next:
 	}
 }				/* end TaskQueue */
 
-/****************************************************************
+/*
  * Name:	iteraid_queuecommand
  * Description:	Process a queued command from the SCSI manager.
  * Parameters:	SCpnt - Pointer to SCSI command structure.
  *		done  - Pointer to done function to call.
  * Returns:	Status code.
- ****************************************************************/
+ */
 static int iteraid_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
 	unsigned long flags;
@@ -4261,25 +4156,19 @@ static int iteraid_queuecommand(Scsi_Cmn
 }				/* end iteraid_queuecommand */
 
 #if 0
-/****************************************************************
- * Name:	internal_done :LOCAL
- * Description:	Done handler for non-queued commands
- * Parameters:	SCpnt - Pointer to SCSI command structure.
- * Returns:	Nothing.
- ****************************************************************/
+/*
+ * Done handler for non-queued commands
+ */
 static void internal_done(Scsi_Cmnd * SCpnt)
 {
 	SCpnt->SCp.Status++;
-}				/* end internal_done */
+}
 #endif
 
 #if 0
-/****************************************************************
- * Name:	iteraid_command
- * Description:	Process a command from the SCSI manager.
- * Parameters:	SCpnt - Pointer to SCSI command structure.
- * Returns:	Status code.
- ****************************************************************/
+/*
+ * Process a command from the SCSI manager.
+ */
 static int iteraid_command(Scsi_Cmnd * SCpnt)
 {
 	unsigned long timeout;
@@ -4298,9 +4187,9 @@ static int iteraid_command(Scsi_Cmnd * S
 }				/* end iteraid_command */
 #endif
 
-/************************************************************************
+/*
  * Enables/disables media status notification.
- ************************************************************************/
+ */
 #if 0
 static void IdeMediaStatus(u8 EnableMSN, PChannel pChan, u8 Device)
 {
@@ -4352,11 +4241,11 @@ static void IdeMediaStatus(u8 EnableMSN,
 	}
 }				/* end IdeMediaStatus */
 
-#endif				/*  */
-/************************************************************************
+#endif
+/*
  * Issue IDENTIFY command to a device.
  * Either the standard (EC) or the ATAPI packet (A1) IDENTIFY.
- ************************************************************************/
+ */
 static u8 IssueIdentify(PChannel pChan, u8 DeviceNumber, u8 Command)
 {
 	u8 statusByte = 0;
@@ -4494,7 +4383,6 @@ static u8 IssueIdentify(PChannel pChan, 
 
 	/*
 	 * Check out a few capabilities / limitations of the device.
-	 * 01/29/2003
 	 */
 	if (pChan->FullIdentifyData.SpecialFunctionsEnabled & 1) {
 
@@ -4555,9 +4443,9 @@ static u8 IssueIdentify(PChannel pChan, 
 	return TRUE;
 }				/* end IssueIdentify() */
 
-/************************************************************************
+/*
  * Check this is the IDE or ATAPI disk then identify it.
- ************************************************************************/
+ */
 static u8 iteraid_find_device(PChannel pChan, u8 channel)
 {
 	u8 deviceNumber;
@@ -4697,9 +4585,9 @@ static u8 iteraid_find_device(PChannel p
 }				/* end iteraid_find_device */
 
 #if 0
-/************************************************************************
+/*
  * IDE disk hardware initialize.
- ************************************************************************/
+ */
 static u8 AtapiHwInitialize(PITE_ADAPTER pAdap, PChannel pChan, u8 channel)
 {
 	u8 i;
@@ -4746,9 +4634,9 @@ static u8 AtapiHwInitialize(PITE_ADAPTER
 }				/* end AtapiHwInitialize */
 #endif
 
-/************************************************************************
- * Initialize a adapter, return 0 means success.
- ************************************************************************/
+/*
+ * Initialize an adapter, return 0 means success.
+ */
 static int iteraid_init(PITE_ADAPTER pAdap, struct pci_dev *pPciDev)
 {
 	u8 z;
@@ -4844,7 +4732,6 @@ static int iteraid_init(PITE_ADAPTER pAd
 		 * Change to bypass mode.
 		 */
 		IT8212InitBypassMode(pPciDev);
-
 #endif
 
 		/*
@@ -4852,7 +4739,6 @@ static int iteraid_init(PITE_ADAPTER pAd
 		 */
 #if (0)
 		AtapiHwInitialize(pAdap, pChan, z);
-
 #endif
 
 		/*
@@ -4860,12 +4746,8 @@ static int iteraid_init(PITE_ADAPTER pAd
 		 */
 		iteraid_find_device(pChan, z);
 
-		/*
-		 * Set the best transfer mode.
-		 */
 #if (MARK_SET_BEST_TRANSFER)
 		IT8212SetBestTransferMode(pAdap, pChan, z);
-
 #endif
 
 		/*
@@ -4877,9 +4759,9 @@ static int iteraid_init(PITE_ADAPTER pAd
 	return 0;
 }				/* end iteraid_init */
 
-/************************************************************************
- * This function will find and initialize any cards.
- ************************************************************************/
+/*
+ * Find and initialize any cards.
+ */
 static int iteraid_detect(Scsi_Host_Template * tpnt)
 {
 	u8 i;
@@ -4904,9 +4786,6 @@ static int iteraid_detect(Scsi_Host_Temp
 		if (pci_enable_device(pPciDev))
 			continue;
 
-		/*
-		 * Allocate memory for Adapter.
-		 */
 		pAdap = (PITE_ADAPTER) kmalloc(sizeof(ITE_ADAPTER), GFP_ATOMIC);
 		if (pAdap == NULL) {
 			printk("iteraid_detect: pAdap allocate failed.\n");
@@ -4957,14 +4836,8 @@ static int iteraid_detect(Scsi_Host_Temp
 		ite_vhost->max_id = MAX_DEVICES;
 		ite_vhost->max_lun = 1;
 
-#if (0)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+#if 0
 		scsi_set_device(ite_vhost, &pPciDev->dev);
-
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,4)
-		scsi_set_pci_device(ite_vhost, pPciDev);
-
-#endif
 #endif
 
 		/*
@@ -4983,7 +4856,7 @@ static int iteraid_detect(Scsi_Host_Temp
 		register_reboot_notifier(&ite_notifier);
 
 		/*
-		 * Initialize ioctl semphore.
+		 * Initialize ioctl semaphore.
 		 */
 		init_MUTEX(&mimd_entry_mtx);
 	}
@@ -4991,28 +4864,16 @@ static int iteraid_detect(Scsi_Host_Temp
 	return 1;
 }				/* end iteraid_detect() */
 
-/************************************************************************
- * Name:	iteraid_release
- * Description:	Release resources allocated for a single each adapter.
- * Parameters:	pshost - Pointer to SCSI command structure.
- * Returns:	zero.
- ************************************************************************/
 static int iteraid_release(struct Scsi_Host *pshost)
 {
 	u8 i;
 	PITE_ADAPTER pAdap;
 
-	/*
-	 * Unregister the character device.
-	 */
 	if (ite_major > 0) {
 		unregister_chrdev(ite_major, "itedev");
 		ite_major = -1;
 	}
 
-	/*
-	 * Free irq and memory.
-	 */
 	for (i = 0; i < NumAdapters; i++) {
 		pAdap = ite_adapters[i];
 		if (pAdap->irqOwned)
@@ -5026,9 +4887,6 @@ static int iteraid_release(struct Scsi_H
 		}
 	}
 
-	/*
-	 * Unregister the reboot notifier.
-	 */
 	unregister_reboot_notifier(&ite_notifier);
 
 	/*
@@ -5038,9 +4896,6 @@ static int iteraid_release(struct Scsi_H
 	return 0;
 }				/* end iteraid_Release */
 
-/************************************************************************
- * This is the new scsi eh reset function.
- ************************************************************************/
 static int iteraid_reset_eh(Scsi_Cmnd * SCpnt)
 {
 	u8 i;
@@ -5062,9 +4917,9 @@ static int iteraid_reset_eh(Scsi_Cmnd * 
 	return SUCCESS;
 }				/* end iteraid_reset_eh */
 
-/************************************************************************
+/*
  * The new error handling code.
- ************************************************************************/
+ */
 static int iteraid_abort_eh(Scsi_Cmnd * SCpnt)
 {
 	if (SCpnt == NULL) {
@@ -5072,17 +4927,11 @@ static int iteraid_abort_eh(Scsi_Cmnd * 
 		return FAILED;
 	}
 	return SUCCESS;
-}				/* end iteraid_abort_eh */
+}
 
-/************************************************************************
- * Name:	iteraid_biosparam
- * Description:	Process the biosparam request from the SCSI manager to
- *		return C/H/S data.
- * Parameters:	disk - Pointer to SCSI disk structure.
- *		dev  - Major/minor number from kernel.
- *		geom - Pointer to integer array to place geometry data.
- * Returns:	zero.
- ************************************************************************/
+/*
+ * Process the biosparam request from the SCSI manager to return C/H/S data.
+ */
 static int iteraid_biosparam(struct scsi_device *sdev,
 		struct block_device *bdev, sector_t capacity, int geom[])
 {
@@ -5112,9 +4961,9 @@ static int iteraid_biosparam(struct scsi
 	return 0;
 }				/* end iteraid_biosparam */
 
-/************************************************************************
+/*
  * Shutdown routine.
- ************************************************************************/
+ */
 static int ite_halt(struct notifier_block *nb, ulong event, void *buf)
 {
 	if (event != SYS_RESTART && event != SYS_HALT &&
@@ -5123,30 +4972,25 @@ static int ite_halt(struct notifier_bloc
 	}
 	unregister_reboot_notifier(&ite_notifier);
 	return NOTIFY_OK;
-}				/* end ite_halt */
+}
 
-/************************************************************************
- * PROC information.
- ************************************************************************/
 static int iteraid_proc_info(struct Scsi_Host *shost, char *buffer,
 			char **start, off_t offset, int length, int inout)
 {
 	return 0;
-}				/* end iteraid_proc_info */
+}
 
-/************************************************************************
+/*
  * IOCTL open entry.
- ************************************************************************/
+ */
 static int itedev_open(struct inode *inode, struct file *filep)
 {
-
-	//MOD_INC_USE_COUNT;
 	return 0;
-}				/* end itedev_open */
+}
 
-/************************************************************************
+/*
  * IOCTL code entry.
- ************************************************************************/
+ */
 static int itedev_ioctl_entry(struct inode *inode, struct file *filep,
 				unsigned int cmd, unsigned long arg)
 {
@@ -5161,9 +5005,9 @@ static int itedev_ioctl_entry(struct ino
 	return ret;
 }				/* end itedev_ioctl_entry */
 
-/************************************************************************
+/*
  * Real IOCTL function handles ioctl for the character device.
- ************************************************************************/
+ */
 static int itedev_ioctl(struct inode *inode, struct file *filep,
 			unsigned int cmd, unsigned long arg)
 {
@@ -5184,17 +5028,11 @@ static int itedev_ioctl(struct inode *in
 	if (_IOC_TYPE(cmd) != ITE_IOCMAGIC)
 		return -EINVAL;
 
-	/*
-	 * Allocate space for ioctl data structure.
-	 */
 	if ((pioc = kmalloc(sizeof(uioctl_t), GFP_KERNEL)) == NULL) {
 		printk("itedev_ioctl: error kmalloc on ioctl\n");
 		return -ENOMEM;
 	}
 
-	/*
-	 * Get the user ioctl structure.
-	 */
 	if (copy_from_user(pioc, (uioctl_t *) arg, sizeof(uioctl_t))) {
 		kfree(pioc);
 		return -EFAULT;
@@ -5207,17 +5045,11 @@ static int itedev_ioctl(struct inode *in
 	case ITE_IOC_GET_PHY_DISK_STATUS:
 		dprintk("ITE_IOC_GET_PHY_DISK_STATUS\n");
 
-		/*
-		 * Get the physical disk status.
-		 */
 		status = IT8212GetChipStatus(pioc);
 		return 0;
 	case ITE_IOC_CREATE_DISK_ARRAY:
 		dprintk("ITE_IOC_CREATE_DISK_ARRAY\n");
 
-		/*
-		 * Create disk array.
-		 */
 		status = IT8212CreateDiskArray(pioc);
 		if (status != SRB_STATUS_SUCCESS)
 			return status;
@@ -5301,34 +5133,22 @@ static int itedev_ioctl(struct inode *in
 		if (progress != 0xFF)
 			progress = 0x64 - progress;
 
-		/*
-		 * Put the rebuild status to user space.
-		 */
 		return put_user(progress, (u8 *) pioc->data);
 exit:
 		return 0;
 	case ITE_IOC_RESET_ADAPTER:
 		dprintk("ITE_IOC_RESET_ADAPTER\n");
 
-		/*
-		 * Reset the adapter.
-		 */
-#if (0)
+#if 0
 		status = IT8212ResetAdapter();
 
 #endif
 
-		/*
-		 * Return TURE or FALSE to user space.
-		 */
 		put_user(status, (u8 __user *) arg);
 		return 0;
 	case ITE_IOC_GET_DRIVER_VERSION:
 		dprintk("ITE_IOC_GET_DRIVER_VERSION\n");
 
-		/*
-		 * Get the current driver version.
-		 */
 		put_user(driver_ver, (int __user *)arg);
 		return 0;
 	default:
@@ -5336,19 +5156,14 @@ exit:
 	}			/* end switch */
 }				/* end itedev_ioctl */
 
-/************************************************************************
+/*
  * IOCTL close routine.
- ************************************************************************/
+ */
 static int itedev_close(struct inode *inode, struct file *filep)
 {
-
-	//MOD_DEC_USE_COUNT;
 	return 0;
-}				/* end itedev_close */
+}
 
-/************************************************************************
- * Scsi_Host_Template Initializer
- ************************************************************************/
 static Scsi_Host_Template driver_template = {
 	.proc_name = 			"IT8212",
 	.proc_info =			iteraid_proc_info,
Index: linux-iteraid/drivers/scsi/iteraid.h
===================================================================
--- linux-iteraid.orig/drivers/scsi/iteraid.h	2005-06-18 00:50:48.000000000 +0400
+++ linux-iteraid/drivers/scsi/iteraid.h	2005-06-18 02:16:05.000000000 +0400
@@ -26,10 +26,10 @@
 #include <linux/version.h>
 #include <linux/types.h>
 
-#define ITE_VENDOR_ID	0x1283	/* Vendor ID (ITE)      */
-#define ITE_DEVICE_ID	0x8212	/* Device IF (IT8212)   */
-#define MAX_ADAPTERS	2	/* Max Board supported  */
-#define MAX_DEVICES	(MAX_ADAPTERS * 4)	/* Max Dev supported    */
+#define ITE_VENDOR_ID	0x1283
+#define ITE_DEVICE_ID	0x8212	/* IT8212 */
+#define MAX_ADAPTERS	2
+#define MAX_DEVICES	(MAX_ADAPTERS * 4)
 
 #define TRUE		1
 #define FALSE 		0
@@ -39,18 +39,15 @@
  */
 #undef	START_STOP
 
-/************************************************************************
- * Debugging macro
- ************************************************************************/
 #ifdef ITE_DEBUG
 #define dprintk(msg...) printk(msg)
 #else
 #define dprintk(msg...) do { } while(0)
 #endif
 
-/************************************************************************
+/*
  * Raid level definitions
- ************************************************************************/
+ */
 #define RAID_LEVEL_0			0
 #define RAID_LEVEL_1			1
 #define RAID_LEVEL_10			2
@@ -58,9 +55,9 @@
 #define RAID_LEVEL_NORMAL		4
 #define RAID_LEVEL_NODISK		5
 
-/************************************************************************
+/*
  * Physical disk status definitions
- ************************************************************************/
+ */
 #define DISK_KEY_OFF			0
 #define DISK_OFF_LINE			1
 #define DISK_ON_LINE			2
@@ -85,9 +82,9 @@
 #define USE_ULTRA_DMA			0
 #define USE_MULTIWORD_DMA		1
 
-/************************************************************************
+/*
  * Vendor specific information
- ************************************************************************/
+ */
 typedef struct _PHYSICAL_DISK_STATUS {
 	u8 ModelNumber[40];	/* Byte 00-39           */
 	u32 UserAddressableSectors_LOW;	/* Byte 40-43           */
@@ -114,9 +111,9 @@ typedef struct _PHYSICAL_DISK_STATUS {
 	u8 AutoRebuildEnable;	/* Byte 127             */
 } PHYSICAL_DISK_STATUS, *PPHYSICAL_DISK_STATUS;
 
-/************************************************************************
- * vendor specific information
- ************************************************************************/
+/*
+ * Vendor specific information
+ */
 typedef struct _IT8212_SET_CHIP_STATUS_INFO {
 	u16 RaidType;		/* Word 129             */
 	u16 ContainingDisks;	/* Word 130             */
@@ -146,9 +143,9 @@ typedef struct _IT8212_SET_CHIP_STATUS_I
 	u16 NewlyCreated;	/* Word 154             */
 } IT8212_SET_CHIP_STATUS_INFO, *PIT8212_SET_CHIP_STATUS_INFO;
 
-/************************************************************************
+/*
  * Serial number written to HDD (20 bytes)
- ************************************************************************/
+ */
 typedef struct _RAID_SERIAL_NUMBER {
 	u16 Year;
 	u8 Month;
@@ -163,7 +160,7 @@ typedef struct _RAID_SERIAL_NUMBER {
 	u8 DontCare[9];
 } RAID_SERIAL_NUMBER, *PRAID_SERIAL_NUMBER;
 
-/************************************************************************
+/*
  * Disk array create information
  *
  * Following items index definition
@@ -171,7 +168,7 @@ typedef struct _RAID_SERIAL_NUMBER {
  * 1: Secondary Master
  * 2: Primary Slave
  * 3: Secondary Slave
- ************************************************************************/
+ */
 typedef struct _RAID_CREATE_INFO {
 	u8 DiskArrayId;
 	RAID_SERIAL_NUMBER SerialNumber;
@@ -190,9 +187,9 @@ typedef struct _RAID_CREATE_INFO {
 	u8 Reserved;
 } RAID_CREATE_INFO, *PRAID_CREATE_INFO;
 
-/************************************************************************
+/*
  * Rebuild data structure
- ************************************************************************/
+ */
 typedef struct _RAID_REBUILD_INFO {
 	u8 DiskArrayId;		/* Virtual device number (0-3)          */
 	u8 SrcDisk;		/* Source disk (0-3)                    */
@@ -204,9 +201,9 @@ typedef struct _RAID_REBUILD_INFO {
 	u8 Reserved[3];		/* For aligement                        */
 } RAID_REBUILD_INFO, *PRAID_REBUILD_INFO;
 
-/************************************************************************
+/*
  * ATA transfer modes
- ************************************************************************/
+ */
 #define PIO_DEFAULT			0x00
 #define PIO_DEFAULT_IORDY_DISABLE	0x01
 #define PIO_FLOW_CONTROL		0x08
@@ -217,9 +214,9 @@ typedef struct _RAID_REBUILD_INFO {
 #define ITE_DRV_SIGNATURE		"ITE RAID CONTROLLER"
 #define ITE_DRV_BYPASS			"ITE BYPASS MODE"
 
-/************************************************************************
+/*
  * Extra IDE commands supported by Accusys
- ************************************************************************/
+ */
 #define IDE_COMMAND_GET_CHIP_STATUS	0xFA
 #define IDE_COMMAND_SET_CHIP_STATUS	0xFB
 #define IDE_COMMAND_REBUILD		0xFC
@@ -232,9 +229,9 @@ typedef struct _RAID_REBUILD_INFO {
 #define REBUILD_ERR_DEST_DISK_OFFLINE		0x05
 #define REBUILD_ERR_DISK_BUSY			0x10
 
-/************************************************************************
+/*
  * ATA transfer modes
- ************************************************************************/
+ */
 #define PIO_DEFAULT			0x00
 #define PIO_DEFAULT_IORDY_DISABLE	0x01
 #define PIO_FLOW_CONTROL		0x08
@@ -242,9 +239,9 @@ typedef struct _RAID_REBUILD_INFO {
 #define MULTIWORD_DMA			0x20
 #define ULTRA_DMA			0x40
 
-/************************************************************************
+/*
  * IDE registers offset
- ************************************************************************/
+ */
 #define IDE_NR_PORTS			10
 
 #define IDE_DATA_OFFSET			0
@@ -262,9 +259,9 @@ typedef struct _RAID_REBUILD_INFO {
 #define IDE_COMMAND_OFFSET		IDE_STATUS_OFFSET
 #define IDE_ALTERNATE_OFFSET		IDE_CONTROL_OFFSET
 
-/************************************************************************
+/*
  * ATAPI registers offset
- ************************************************************************/
+ */
 #define ATAPI_DATA_OFFSET		0
 #define ATAPI_ERROR_OFFSET		1
 #define ATAPI_INTREASON_OFFSET		2
@@ -278,9 +275,9 @@ typedef struct _RAID_REBUILD_INFO {
 #define ATAPI_COMMAND_OFFSET		ATAPI_STATUS_OFFSET
 #define	ATAPI_FEATURE_OFFSET		ATAPI_ERROR_OFFSET
 
-/************************************************************************
+/*
  * Following structures are according to SPC-3 (by Chanel)
- ************************************************************************/
+ */
 typedef struct _SCSI_MODE_SENSE6 {
 	u8 OperationCode;
 	u8 Reserved1:3;
@@ -359,9 +356,9 @@ typedef struct _SCSI_MODE_PARAMTER_BLOCK
 	u8 BlockLength0;
 } SCSI_MODE_PARAMTER_BLOCK_DESCRIPTER, *PSCSI_MODE_PARAMTER_BLOCK_DESCRIPTER;
 
-/************************************************************************
+/*
  * IDE command definitions
- ************************************************************************/
+ */
 #define IDE_COMMAND_ATAPI_RESET			0x08
 #define IDE_COMMAND_RECALIBRATE			0x10
 #define IDE_COMMAND_READ_SECTOR			0x20
@@ -389,9 +386,9 @@ typedef struct _SCSI_MODE_PARAMTER_BLOCK
 #define IDE_COMMAND_IDENTIFY			0xEC
 #define IDE_COMMAND_MEDIA_EJECT			0xED
 
-/************************************************************************
+/*
  * IDE status definitions
- ************************************************************************/
+ */
 #define IDE_STATUS_ERROR			0x01
 #define IDE_STATUS_INDEX			0x02
 #define IDE_STATUS_CORRECTED_ERROR		0x04
@@ -401,16 +398,13 @@ typedef struct _SCSI_MODE_PARAMTER_BLOCK
 #define IDE_STATUS_IDLE				0x50
 #define IDE_STATUS_BUSY				0x80
 
-/************************************************************************
+/*
  * IDE drive control definitions.
- ************************************************************************/
+ */
 #define IDE_DC_DISABLE_INTERRUPTS		0x02
 #define IDE_DC_RESET_CONTROLLER			0x04
 #define IDE_DC_REENABLE_CONTROLLER		0x00
 
-/************************************************************************
- * IDE error definitions.
- ************************************************************************/
 #define IDE_ERROR_BAD_BLOCK			0x80
 #define IDE_ERROR_DATA_ERROR			0x40
 #define IDE_ERROR_MEDIA_CHANGE			0x20
@@ -420,9 +414,6 @@ typedef struct _SCSI_MODE_PARAMTER_BLOCK
 #define IDE_ERROR_END_OF_MEDIA			0x02
 #define IDE_ERROR_ILLEGAL_LENGTH		0x01
 
-/************************************************************************
- * IDENTIFY data.
- ************************************************************************/
 typedef struct _IDENTIFY_DATA {
 	u16 GeneralConfiguration;	/* 00 00                */
 	u16 NumberOfCylinders;	/* 02  1                */
@@ -475,9 +466,9 @@ typedef struct _IDENTIFY_DATA {
 	u16 Reserved7[128];	/*     128-255          */
 } IDENTIFY_DATA, *PIDENTIFY_DATA;
 
-/************************************************************************
+/*
  * Identify data without the Reserved4.
- ************************************************************************/
+ */
 typedef struct _IDENTIFY_DATA2 {
 	u16 GeneralConfiguration;	/* 00                   */
 	u16 NumberOfCylinders;	/* 01                   */
@@ -538,15 +529,12 @@ typedef struct _IDENTIFY_DATA2 {
 
 #define IDENTIFY_DATA_SIZE sizeof(IDENTIFY_DATA)
 
-/************************************************************************
- * IDENTIFY capability bit definitions.
- ************************************************************************/
 #define IDENTIFY_CAPABILITIES_DMA_SUPPORTED	0x0100
 #define IDENTIFY_CAPABILITIES_LBA_SUPPORTED	0x0200
 
-/************************************************************************
+/*
  * IDENTIFY DMA timing cycle modes.
- ************************************************************************/
+ */
 #define IDENTIFY_DMA_CYCLES_MODE_0		0x00
 #define IDENTIFY_DMA_CYCLES_MODE_1		0x01
 #define IDENTIFY_DMA_CYCLES_MODE_2		0x02
@@ -569,9 +557,9 @@ typedef struct _SENSE_DATA {
 	u8 SenseKeySpecific[3];
 } SENSE_DATA, *PSENSE_DATA;
 
-/************************************************************************
+/*
  * Sense codes
- ************************************************************************/
+ */
 #define SCSI_SENSE_NO_SENSE		0x00
 #define SCSI_SENSE_RECOVERED_ERROR	0x01
 #define SCSI_SENSE_NOT_READY		0x02
@@ -589,9 +577,9 @@ typedef struct _SENSE_DATA {
 #define SCSI_SENSE_MISCOMPARE		0x0E
 #define SCSI_SENSE_RESERVED		0x0F
 
-/************************************************************************
+/*
  * Additional Sense codes
- ************************************************************************/
+ */
 #define SCSI_ADSENSE_NO_SENSE		0x00
 #define SCSI_ADSENSE_MAN_INTERV		0x03
 #define SCSI_ADSENSE_LUN_NOT_READY	0x04
@@ -618,7 +606,7 @@ typedef struct _SENSE_DATA {
 
 #define SCSISTAT_CHECK_CONDITION	0x02
 
-/************************************************************************
+/*
  * Inquiry buffer structure. This is the data returned from the target
  * after it receives an inquiry.
  *
@@ -627,7 +615,7 @@ typedef struct _SENSE_DATA {
  * includes fields through ProductRevisionLevel.
  *
  * The NT SCSI drivers are only interested in the first 36 bytes of data.
- ************************************************************************/
+ */
 
 #define INQUIRYDATABUFFERSIZE 36
 
@@ -657,9 +645,9 @@ typedef struct _INQUIRYDATA {
 
 #define DIRECT_ACCESS_DEVICE		0x00	/* Disks                */
 
-/************************************************************************
+/*
  * Read Capacity Data - returned in Big Endian format
- ************************************************************************/
+ */
 typedef struct _READ_CAPACITY_DATA {
 	u32 LogicalBlockAddress;
 	u32 BytesPerBlock;
@@ -667,9 +655,9 @@ typedef struct _READ_CAPACITY_DATA {
 
 #define MAXIMUM_CDB_SIZE	12
 
-/************************************************************************
- * CDB (Command Descriptor Block)
- ************************************************************************/
+/*
+ * Command Descriptor Block
+ */
 typedef union _CDB {
 	/*
 	 * Standard 6-byte CDB
@@ -715,9 +703,9 @@ typedef union _CDB {
 
 } CDB, *PCDB;
 
-/************************************************************************
+/*
  * SCSI CDB operation codes
- ************************************************************************/
+ */
 #define SCSIOP_TEST_UNIT_READY		0x00
 #define SCSIOP_REZERO_UNIT		0x01
 #define SCSIOP_REWIND			0x01
@@ -798,7 +786,7 @@ typedef union _CDB {
 #define PCI_IOSEN	0x01	/* Enable IO space                      */
 #define PCI_BMEN	0x04	/* Enable IDE bus master                */
 
-/************************************************************************
+/*
  * PRD (Physical Region Descriptor) = Scatter-gather table
  *
  * |  byte3   |	 byte2	 |  byte1   |   byte0   |
@@ -807,7 +795,7 @@ typedef union _CDB {
  * +----+----------------+----------------------+
  * |EOT |  reserved      |   Byte count[15:1]   |
  * +----+----------------+----------------------+
- ************************************************************************/
+ */
 typedef struct _PRD_TABLE_ENTRY {
 	u32 PhysicalBaseAddress;	/* Byte0 - Byte3        */
 	u16 ByteCount;		/* Byte4 - Byte5        */
@@ -819,9 +807,9 @@ typedef struct _PRD_TABLE_ENTRY {
 
 #define NUM_OF_PRD_TABLE_ENTRY		0x10
 
-/************************************************************************
+/*
  * Bus master register bits definition
- ************************************************************************/
+ */
 #define BM_CMD_FLG_START		0x01
 #define BM_CMD_FLG_WRTTOMEM		0x08
 #define BM_CMD_FLG_WRTTODSK		0x00
@@ -834,17 +822,11 @@ typedef struct _PRD_TABLE_ENTRY {
 
 #define BM_PRD_FLG_EOT  		0x8000
 
-/************************************************************************
- * SRB Functions
- ************************************************************************/
 #define SRB_FUNCTION_EXECUTE_SCSI	0x00
 #define SRB_FUNCTION_IO_CONTROL		0x02
 #define SRB_FUNCTION_SHUTDOWN		0x07
 #define SRB_FUNCTION_FLUSH		0x08
 
-/************************************************************************
- * SRB Status
- ************************************************************************/
 #define SRB_STATUS_PENDING		0x00
 #define SRB_STATUS_SUCCESS		0x01
 #define SRB_STATUS_ABORTED		0x02
@@ -872,24 +854,18 @@ typedef struct _PRD_TABLE_ENTRY {
 #define SRB_STATUS_ERROR_RECOVERY	0x23
 #define SRB_STATUS_NEED_REQUEUE		0x24
 
-/************************************************************************
- * SRB Status Masks
- ************************************************************************/
 #define SRB_STATUS_QUEUE_FROZEN		0x40
 #define SRB_STATUS_AUTOSENSE_VALID	0x80
 
 #define SRB_STATUS(Status)	\
 	(Status & ~(SRB_STATUS_AUTOSENSE_VALID | SRB_STATUS_QUEUE_FROZEN))
 
-/************************************************************************
- * SRB Flag Bits
- ************************************************************************/
 #define SRB_FLAGS_DATA_IN		0x00000040
 #define SRB_FLAGS_DATA_OUT		0x00000080
 
-/************************************************************************
+/*
  * SRB Working flags define area
- ************************************************************************/
+ */
 #define	SRB_WFLAGS_USE_INTERNAL_BUFFER	0x00000001
 #define	SRB_WFLAGS_IGNORE_ARRAY		0x00000002
 #define	SRB_WFLAGS_HAS_CALL_BACK	0x00000004
@@ -900,9 +876,9 @@ typedef struct _PRD_TABLE_ENTRY {
 #define SRB_WFLAGS_WATCHTIMER_CALLED	0x20000000
 #define SRB_WFLAGS_USE_SG		0x40000000
 
-/************************************************************************
+/*
  * SCSI I/O Request Block
- ************************************************************************/
+ */
 typedef struct _SCSI_REQUEST_BLOCK {
 	u16 Length;
 	u8 Function;
@@ -926,9 +902,9 @@ typedef struct _SCSI_REQUEST_BLOCK {
 
 #define SCSI_REQUEST_BLOCK_SIZE sizeof(SCSI_REQUEST_BLOCK)
 
-/************************************************************************
+/*
  * Second device flags
- ***********************************************************************/
+ */
 #define DFLAGS_REDUCE_MODE	        0x00010000
 #define DFLAGS_DEVICE_DISABLED		0x00020000
 #define DFLAGS_BOOTABLE_DEVICE		0x00080000
@@ -936,22 +912,11 @@ typedef struct _SCSI_REQUEST_BLOCK {
 #define DFLAGS_NEW_ADDED		0x40000000
 #define DFLAGS_REMAINED_MEMBER		0x80000000
 
-/************************************************************************
- * Device Extension Device Flags
- ************************************************************************/
 /*
- * Indicates that some device is present.
+ * Device Extension Device Flags
  */
 #define DFLAGS_DEVICE_PRESENT		0x0001
-
-/*
- * Indicates whether ATAPI commands can be used.
- */
 #define DFLAGS_ATAPI_DEVICE		0x0002
-
-/*
- * Indicates whether this is a tape device.
- */
 #define DFLAGS_TAPE_DEVICE		0x0004
 
 /*
@@ -989,34 +954,33 @@ typedef struct _SCSI_REQUEST_BLOCK {
 
 #define UDMA_MODE_5_6			0x80
 
-/************************************************************************
+/*
  * Used to disable 'advanced' features.
- ************************************************************************/
+ */
 #define MAX_ERRORS			4
 
-/************************************************************************
+/*
  * ATAPI command definitions
- ************************************************************************/
+ */
 #define ATAPI_MODE_SENSE		0x5A
 #define ATAPI_MODE_SELECT		0x55
 #define ATAPI_FORMAT_UNIT		0x24
 
-/************************************************************************
+/*
  * User IOCTL structure
- * Notes:
- * (1) Data transfers are limited to PAGE_SIZE (4k on i386, 8k for alpha)
- ************************************************************************/
+ * Data transfers are limited to PAGE_SIZE (4k on i386, 8k for alpha)
+ */
 typedef struct _uioctl_t {
 	u16 inlen;		/* Length of data written to device     */
 	u16 outlen;		/* Length of data read from device      */
-	void *data;		/* Data read from devic starts here     */
+	void *data;		/* Data read from device starts here    */
 	u8 status;		/* Status return from driver            */
 	u8 reserved[3];		/* For 4-byte alignment                 */
 } uioctl_t;
 
-/************************************************************************
+/*
  * IOCTL commands for RAID
- ************************************************************************/
+ */
 #define ITE_IOCMAGIC			't'
 
 #define ITE_IOC_GET_PHY_DISK_STATUS	_IO(ITE_IOCMAGIC, 1)
@@ -1026,53 +990,30 @@ typedef struct _uioctl_t {
 #define ITE_IOC_RESET_ADAPTER		_IO(ITE_IOCMAGIC, 5)
 #define ITE_IOC_GET_DRIVER_VERSION	_IO(ITE_IOCMAGIC, 6)
 
-/************************************************************************
- * _Channel
- ************************************************************************/
 typedef struct _Channel {
 	/*
 	 * IDE (ATAPI) io port address.
 	 */
 	unsigned long io_ports[IDE_NR_PORTS];
-
-	/*
-	 * DMA base address.
-	 */
 	unsigned long dma_base;
-
-	/*
-	 * Flags word for each possible device.
-	 */
 	u16 DeviceFlags[2];
 
 	/*
 	 * Indicates number of platters on changer-ish devices.
 	 */
 	u32 DiscsPresent[2];
-
-	/*
-	 * Indicates expecting an interrupt.
-	 */
 	u8 ExpectingInterrupt;
 
 	/*
 	 * Indicate last tape command was DSC Restrictive.
 	 */
 	u8 RDP;
-
-	/*
-	 * Interrupt level.
-	 */
 	u8 InterruptLevel;
 
 	/*
 	 * Placeholder for status register after a GET_MEDIA_STATUS command.
 	 */
 	u8 ReturningMediaStatus;
-
-	/*
-	 * Remember the channel number (0, 1)
-	 */
 	u8 channel;
 
 	/*
@@ -1084,45 +1025,21 @@ typedef struct _Channel {
 	 * Reserved for alignment.
 	 */
 	u8 reserved1[0];
-
-	/*
-	 * Data buffer pointer.
-	 */
 	unsigned short *DataBuffer;
-
-	/*
-	 * Data words left.
-	 */
 	u32 WordsLeft;
-
-	/*
-	 * Retry count.
-	 */
 	u32 RetryCount;
 
 	/*
-	 * Keep DMA type (MULTIWORD_DMA or ULTRA_DMA) for each device.
+	 * MULTIWORD_DMA or ULTRA_DMA
 	 */
 	u8 DmaType[2];
-
-	/*
-	 * Keep UDMA timing for each device.
-	 */
 	u8 UdmaTiming[2];
-
-	/*
-	 * Keep PIO/DMA timing for each channel. PioDmaTiming[clock][channel]
-	 */
 	u8 PioDmaTiming[2];
 
 	/*
 	 * Keep IDE clock (50 MHz or 66 MHz) for each device.
 	 */
 	u8 IdeClock[2];
-
-	/*
-	 * Keep the active device for each channel.
-	 */
 	u8 ActiveDevice;
 
 	/*
@@ -1134,10 +1051,6 @@ typedef struct _Channel {
 	 * ???
 	 */
 	u8 ConvertCdb;
-
-	/*
-	 * Use or do not use DMA.
-	 */
 	u8 UseDma[2];
 
 	/*
@@ -1160,10 +1073,6 @@ typedef struct _Channel {
 	 * DMA PRD table virtual address.
 	 */
 	unsigned long *dmatable_cpu;
-
-	/*
-	 * Point to SCATTER/GATHER data buffer.
-	 */
 	struct scatterlist *sg_table;
 
 	/*
@@ -1185,10 +1094,6 @@ typedef struct _Channel {
 	 * Internal SRB.
 	 */
 	SCSI_REQUEST_BLOCK _Srb;
-
-	/*
-	 * Remember the PCI device.
-	 */
 	struct pci_dev *pPciDev;
 
 	/*
@@ -1197,26 +1102,20 @@ typedef struct _Channel {
 	u8 TempCdb[MAXIMUM_CDB_SIZE];
 } Channel, *PChannel;
 
-/************************************************************************
- * _Adapter
- ************************************************************************/
 typedef struct _Adapter {
-	char *name;		/* Adapter's name               */
-	u8 num_channels;	/* How many channels support    */
-	unsigned int irq;	/* irq number                   */
+	char *name;
+	u8 num_channels;
+	unsigned int irq;
 	unsigned int irqOwned;	/* If any irq is use            */
-	u8 pci_bus;		/* PCI bus number               */
-	u8 devfn;		/* Device and function number   */
-	u8 offline;		/* On line or off line          */
-	u8 bypass_mode;		/* bypass or firware mode       */
+	u8 pci_bus;
+	u8 devfn;
+	u8 offline;
+	u8 bypass_mode;		/* bypass or firmware mode      */
 	u8 reserved2[1];	/* Reserved for alignment       */
 	Channel *IDEChannel;	/* IT8212 supports two channels */
-	struct pci_dev *pci_dev;	/* For PCI device               */
+	struct pci_dev *pci_dev;
 } ITE_ADAPTER, *PITE_ADAPTER;
 
-/************************************************************************
- * Beautification macros
- ************************************************************************/
 #define ScheduleRetryProcess(pChan) do {		\
 	pChan->retry_timer->expires = jiffies + 10;	\
 	add_timer(pChan->retry_timer);			\
@@ -1456,8 +1355,4 @@ do {						\
     }						\
 } while (0)
 
-/************************************************************************
- * Function prototypes
- ************************************************************************/
-
 #endif				/* #ifndef _ITERAID_H_ */

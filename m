Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVBPQqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVBPQqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVBPQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:46:17 -0500
Received: from palrel10.hp.com ([156.153.255.245]:63905 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262075AbVBPQpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:45:09 -0500
Date: Wed, 16 Feb 2005 10:45:12 -0600
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org, akpm@osdl.org, eric.moore@lsil.com
Subject: cciss CSMI via sysfs for 2.6
Message-ID: <20050216164512.GA5734@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending the following patch for some constructive critisms :).
This is a small part of what the CSMI Ioctls were supposed to do. I am
looking for feedback on this implementation. It is not complete, and I 
doubt anyone has hardware to test it with.
The firmware and bus_id files are only for my reference now. The part
I am interested is the get_phy_info.
For information on CSMI pls see: www.t11.org/ftp/t11/pub/sm/hba/04-468v0.pdf
Let the flames begin.

mikem

-------------------------------------------------------------------------------
 drivers/block/cciss.c       |  163 +++++++++++++++++++++++++++++++++++++
 drivers/block/cciss_cmd.h   |    3
 drivers/block/cciss_scsi.c  |    2
 include/linux/cciss_ioctl.h |  189 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 352 insertions(+), 5 deletions(-)

diff -burNp lx2611.orig/drivers/block/cciss.c lx2611/drivers/block/cciss.c
--- lx2611.orig/drivers/block/cciss.c	2005-01-26 14:21:21.000000000 -0600
+++ lx2611/drivers/block/cciss.c	2005-02-15 12:31:27.000000000 -0600
@@ -46,12 +46,12 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.6.4)"
+#define DRIVER_NAME "HP CISS Driver (v 2.6.4-99)"
 #define DRIVER_VERSION CCISS_DRIVER_VERSION(2,6,4)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.4");
+MODULE_DESCRIPTION("Driver for HP Controller SA5xxx SA6xxx version 2.6.4-99");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"
 			" SA6i P600");
 MODULE_LICENSE("GPL");
@@ -138,6 +138,8 @@ static int sendcmd( __u8 cmd, int ctlr, 
 	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
 	unsigned char *scsi3addr, int cmd_type);
 
+static int sas_error_check(__u8 phyId, __u8 portId, __u8 conn_rate);
+
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
 		int length, int *eof, void *data);
@@ -1076,6 +1078,158 @@ cleanup1:
 }
 
 /*
+ * sysfs stuff
+ * this should be moved to it's own file, maybe cciss_sysfs.h
+ */
+
+static ssize_t cciss_firmver_show(struct device *dev, char *buf)
+{
+	ctlr_info_t *h = dev->driver_data;
+        return sprintf(buf,"%c%c%c%c\n", h->firm_ver[0], h->firm_ver[1],
+                                h->firm_ver[2], h->firm_ver[3]);
+}
+
+static ssize_t cciss_bus_id_show(struct device *dev, char *buf)
+{
+        return sprintf(buf,"%s\n", dev->bus_id);
+}
+
+static ssize_t cciss_phyinfo_show(struct device *dev, char *buf)
+{
+	ctlr_info_t *h = dev->driver_data;
+	unsigned long flags;
+	CommandList_struct *c;
+	CSMI_SAS_PHY_INFO_BUFFER iocommand;
+	CSMI_SAS_IDENTIFY p;
+	u64bit temp64;
+	DECLARE_COMPLETION(wait);
+
+	printk(KERN_WARNING "cciss: into cciss_phyinfo_show\n");
+	memset(&iocommand, 0, sizeof(CSMI_SAS_PHY_INFO_BUFFER));
+	memset(&p, 0, sizeof(CSMI_SAS_IDENTIFY));
+
+	/* allocate and fill in the command */
+	if ((c = cmd_alloc(h, 0)) == NULL)
+		return -ENOMEM;
+
+	iocommand.IoctlHeader.Length = sizeof(CSMI_SAS_PHY_INFO_BUFFER);
+	c->cmd_type = CMD_IOCTL_PEND;
+	c->Header.ReplyQueue = 0;
+		
+	//Do we send the whole buffer?
+	if (iocommand.IoctlHeader.Length > 0){
+		c->Header.SGList = 1;
+		c->Header.SGTotal = 1;
+	} else {
+		c->Header.SGList = 0;
+		c->Header.SGTotal = 0;
+	}
+
+	//send the command to the controller
+	c->Header.LUN.LogDev.VolId = 0;
+	c->Header.LUN.LogDev.Mode = 0;
+	
+	c->Header.Tag.lower = c->busaddr;
+
+	c->Request.Type.Type = TYPE_CMD;
+	c->Request.Type.Attribute = ATTR_SIMPLE;
+
+	c->Request.Type.Direction = XFER_BIDIRECTIONAL;
+	c->Request.Timeout = iocommand.IoctlHeader.Timeout; // Looks like CSMI uses 60 secs by default
+	c->Request.CDB[0] = 0x27;  // CSMI Pass-Thru Bidirectional opcode
+	c->Request.CDB[1] = 0x00;
+	c->Request.CDB[2] = 0xcc; // Bytes 2-5 are 0xCC770014 to match with
+	c->Request.CDB[3] = 0x77; // the CC_CSMI_SAS_GET_PHY_INFO value
+	c->Request.CDB[4] = 0x00;
+	c->Request.CDB[5] = 0x14;
+	c->Request.CDB[6] = BMIC_CSMI_PASSTHRU;
+	c->Request.CDB[7] = (iocommand.IoctlHeader.Length >> 8) & 0xff;
+	c->Request.CDB[8] = iocommand.IoctlHeader.Length & 0xff;
+	c->Request.CDBLen = 16;
+
+	temp64.val = pci_map_single( h->pdev, &p, 
+			iocommand.IoctlHeader.Length, PCI_DMA_BIDIRECTIONAL);
+	c->SG[0].Addr.lower = temp64.val32.lower;
+	c->SG[0].Addr.upper = temp64.val32.upper;
+	c->SG[0].Len = iocommand.IoctlHeader.Length;
+	c->SG[0].Ext = 0;
+	c->waiting = &wait;
+
+	spin_lock_irqsave(CCISS_LOCK(h->ctlr), flags);
+	addQ(&h->reqQ, c);
+	h->Qdepth++;
+	start_io(h);
+	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+
+	printk(KERN_WARNING "cciss: waiting for sysfs command to complete\n");
+	wait_for_completion(&wait);
+	printk(KERN_WARNING "cciss: sysfs command completed\n");
+
+	cmd_free(h, c, 0);
+
+	pci_unmap_single(h->pdev, (dma_addr_t)temp64.val, 
+			iocommand.IoctlHeader.Length, PCI_DMA_BIDIRECTIONAL);
+	printk(KERN_WARNING "cciss: IOCTLHeader rturn = %d\n",
+				iocommand.IoctlHeader.ReturnCode);
+	return sprintf(buf, "%x %x %x %x%x%x%x%x%x%x%x %x%x%x%x%x%x%x%x "
+				"%x %x %x%x%x%x%x%x\n",
+		p.bDeviceType, p.bRestricted, p.bInitiatorPortProtocol,
+		p.bRestricted2[0], 
+		p.bRestricted2[1], 
+		p.bRestricted2[2],
+		p.bRestricted2[3], 
+		p.bRestricted2[4], 
+		p.bRestricted2[5],
+		p.bRestricted2[6], 
+		p.bRestricted2[7],
+	 	p.bSASAddress[0],
+	 	p.bSASAddress[1],
+	 	p.bSASAddress[2],
+	 	p.bSASAddress[3],
+	 	p.bSASAddress[4],
+	 	p.bSASAddress[5],
+	 	p.bSASAddress[6],
+	 	p.bSASAddress[7],
+		p.bPhyIdentifier, p.bSignalClass,
+		p.bReserved[0],
+		p.bReserved[1],
+		p.bReserved[2],
+		p.bReserved[3],
+		p.bReserved[4],
+		p.bReserved[5]);
+}
+
+static DEVICE_ATTR(cciss_firmver, 0644, cciss_firmver_show, NULL);
+static DEVICE_ATTR(cciss_bus_id, 0644, cciss_bus_id_show, NULL);
+static DEVICE_ATTR(cciss_phyinfo, 0644, cciss_phyinfo_show, NULL);
+
+static int sas_error_check(__u8 phyId, __u8 portId, __u8 conn_rate)
+{
+	if( phyId == CSMI_SAS_USE_PORT_IDENTIFIER
+		&& portId == CSMI_SAS_IGNORE_PORT) {
+		return  CSMI_SAS_SELECT_PHY_OR_PORT;
+	}
+	if(phyId < CSMI_SAS_USE_PORT_IDENTIFIER) {
+		if(portId != CSMI_SAS_IGNORE_PORT)
+		return CSMI_SAS_PHY_DOES_NOT_MATCH_PORT;
+	}
+	if(portId < CSMI_SAS_IGNORE_PORT) {
+		if(phyId != CSMI_SAS_USE_PORT_IDENTIFIER)
+		return CSMI_SAS_PHY_CANNOT_BE_SELECTED;
+	}
+	if( conn_rate != CSMI_SAS_LINK_RATE_NEGOTIATE ||
+		conn_rate != CSMI_SAS_LINK_RATE_1_5_GBPS ||
+		conn_rate != CSMI_SAS_LINK_RATE_3_0_GBPS) {
+		return CSMI_SAS_LINK_RATE_OUT_OF_RANGE;
+	}
+	return 0;
+}
+
+/*
+ * end of sysfs stuff
+ */
+
+/*
  * revalidate_allvol is for online array config utilities.  After a
  * utility reconfigures the drives in the array, it can use this function
  * (through an ioctl) to make the driver zap any previous disk structs for
@@ -2383,6 +2537,11 @@ static int cciss_pci_init(ctlr_info_t *c
 
 	c->intr = pdev->irq;
 
+	pci_set_drvdata(pdev, c);
+	device_create_file(&(pdev->dev), &dev_attr_cciss_firmver);
+	device_create_file(&(pdev->dev), &dev_attr_cciss_bus_id);
+	device_create_file(&(pdev->dev), &dev_attr_cciss_phyinfo);
+
 	/*
 	 * Memory base addr is first addr , the second points to the config
          *   table
diff -burNp lx2611.orig/drivers/block/cciss_cmd.h lx2611/drivers/block/cciss_cmd.h
--- lx2611.orig/drivers/block/cciss_cmd.h	2004-12-24 15:34:02.000000000 -0600
+++ lx2611/drivers/block/cciss_cmd.h	2005-02-08 14:13:11.000000000 -0600
@@ -29,7 +29,7 @@
 #define XFER_NONE               0x00
 #define XFER_WRITE              0x01
 #define XFER_READ               0x02
-#define XFER_RSVD               0x03
+#define XFER_BIDIRECTIONAL      0x03
 
 //task attribute
 #define ATTR_UNTAGGED           0x00
@@ -129,6 +129,7 @@ typedef struct _ReadCapdata_struct
 #define BMIC_WRITE 0x27
 #define BMIC_CACHE_FLUSH 0xc2
 #define CCISS_CACHE_FLUSH 0x01	//C2 was already being used by CCISS
+#define BMIC_CSMI_PASSTHRU 0x68;
 
 //Command List Structure
 typedef union _SCSI3Addr_struct {
diff -burNp lx2611.orig/drivers/block/cciss_scsi.c lx2611/drivers/block/cciss_scsi.c
--- lx2611.orig/drivers/block/cciss_scsi.c	2005-01-26 14:15:36.000000000 -0600
+++ lx2611/drivers/block/cciss_scsi.c	2005-02-09 16:53:52.000000000 -0600
@@ -1302,7 +1302,7 @@ cciss_scsi_queue_command (struct scsi_cm
 		// and sets both inlen and outlen to non-zero. ( see
 		// ../scsi/scsi_ioctl.c:scsi_ioctl_send_command() )
 
-	  	cp->Request.Type.Direction = XFER_RSVD;
+	  	cp->Request.Type.Direction = XFER_BIDIRECTIONAL;
 		// This is technically wrong, and cciss controllers should
 		// reject it with CMD_INVALID, which is the most correct 
 		// response, but non-fibre backends appear to let it 
diff -burNp lx2611.orig/include/linux/cciss_ioctl.h lx2611/include/linux/cciss_ioctl.h
--- lx2611.orig/include/linux/cciss_ioctl.h	2004-12-24 15:34:32.000000000 -0600
+++ lx2611/include/linux/cciss_ioctl.h	2005-02-10 10:31:31.000000000 -0600
@@ -60,7 +60,7 @@ typedef __u32 DriverVer_type;
 #define XFER_NONE               0x00
 #define XFER_WRITE              0x01
 #define XFER_READ               0x02
-#define XFER_RSVD               0x03
+#define XFER_BIDIRECTIONAL      0x03
 
 //task attribute
 #define ATTR_UNTAGGED           0x00
@@ -162,6 +162,193 @@ typedef struct _ErrorInfo_struct {
 #pragma pack()
 #endif /* CCISS_CMD_H */ 
 
+// (IoctlHeader.Direction, Linux only)
+#define CSMI_SAS_DATA_READ    0
+#define CSMI_SAS_DATA_WRITE   1
+#define CSMI_SAS_USE_PORT_IDENTIFIER   0xFF
+#define CSMI_SAS_IGNORE_PORT           0xFF
+#define CSMI_SAS_LINK_RATE_OUT_OF_RANGE      2001
+#define CSMI_SAS_PHY_DOES_NOT_EXIST          2002
+#define CSMI_SAS_PHY_DOES_NOT_MATCH_PORT     2003
+#define CSMI_SAS_PHY_CANNOT_BE_SELECTED      2004
+#define CSMI_SAS_SELECT_PHY_OR_PORT          2005
+#define CSMI_SAS_LINK_RATE_NEGOTIATE      0x00
+#define CSMI_SAS_LINK_RATE_1_5_GBPS    0x08
+#define CSMI_SAS_LINK_RATE_3_0_GBPS    0x09
+
+
+/* SAS command structures */
+
+typedef struct _IOCTL_HEADER {
+	__u32 IOControllerNumber;
+        __u32 Length;
+        __u32 ReturnCode;
+        __u32 Timeout;
+        __u16 Direction;
+} IOCTL_HEADER;
+
+// CC_CSMI_SAS_GET_PHY_INFO
+typedef struct _CSMI_SAS_IDENTIFY {
+   __u8  bDeviceType;
+   __u8  bRestricted;
+   __u8  bInitiatorPortProtocol;
+   __u8  bTargetPortProtocol;
+   __u8  bRestricted2[8];
+   __u8  bSASAddress[8];
+   __u8  bPhyIdentifier;
+   __u8  bSignalClass;
+   __u8  bReserved[6];
+} CSMI_SAS_IDENTIFY;
+
+typedef struct _CSMI_SAS_PHY_ENTITY {
+   CSMI_SAS_IDENTIFY Identify;
+   __u8  bPortIdentifier;
+   __u8  bNegotiatedLinkRate;
+   __u8  bMinimumLinkRate;
+   __u8  bMaximumLinkRate;
+   __u8  bPhyChangeCount;
+   __u8  bAutoDiscover;
+   __u8  bReserved[2];
+   CSMI_SAS_IDENTIFY Attached;
+} CSMI_SAS_PHY_ENTITY;
+
+typedef struct _CSMI_SAS_PHY_INFO {
+   __u8  bNumberOfPhys;
+   __u8  bReserved[3];
+   CSMI_SAS_PHY_ENTITY Phy[32];
+} CSMI_SAS_PHY_INFO;
+
+typedef struct _CSMI_SAS_PHY_INFO_BUFFER {
+   IOCTL_HEADER IoctlHeader;
+   CSMI_SAS_PHY_INFO Information;
+} CSMI_SAS_PHY_INFO_BUFFER;
+
+// CC_CSMI_SAS_SET_PHY_INFO
+typedef struct _CSMI_SAS_SET_PHY_INFO {
+   __u8  bPhyIdentifier;
+   __u8  bNegotiatedLinkRate;
+   __u8  bProgrammedMinimumLinkRate;
+   __u8  bProgrammedMaximumLinkRate;
+   __u8  bSignalClass;
+   __u8  bReserved[3];
+} CSMI_SAS_SET_PHY_INFO;
+
+typedef struct _CSMI_SAS_SET_PHY_INFO_BUFFER {
+   IOCTL_HEADER IoctlHeader;
+   CSMI_SAS_SET_PHY_INFO Information;
+} CSMI_SAS_SET_PHY_INFO_BUFFER;
+
+// CC_CSMI_SAS_GET_LINK_ERRORS
+typedef struct _CSMI_SAS_LINK_ERRORS {
+   __u8  bPhyIdentifier;
+   __u8  bResetCounts;
+   __u8  bReserved[2];
+   __u32 uInvalidDwordCount;
+   __u32 uRunningDisparityErrorCount;
+   __u32 uLossOfDwordSyncCount;
+   __u32 uPhyResetProblemCount;
+} CSMI_SAS_LINK_ERRORS;
+
+typedef struct _CSMI_SAS_LINK_ERRORS_BUFFER {
+   IOCTL_HEADER IoctlHeader;
+   CSMI_SAS_LINK_ERRORS Information;
+} CSMI_SAS_LINK_ERRORS_BUFFER;
+
+typedef struct _CSMI_SAS_SMP_REQUEST {
+   __u8  bFrameType;
+   __u8  bFunction;
+   __u8  bReserved[2];
+   __u8  bAdditionalRequestBytes[1016];
+} CSMI_SAS_SMP_REQUEST;
+
+typedef struct _CSMI_SAS_SMP_RESPONSE {
+   __u8  bFrameType;
+   __u8  bFunction;
+   __u8  bFunctionResult;
+   __u8  bReserved;
+   __u8  bAdditionalResponseBytes[1016];
+} CSMI_SAS_SMP_RESPONSE;
+
+typedef struct _CSMI_SAS_SMP_PASSTHRU {
+   __u8  bPhyIdentifier;
+   __u8  bPortIdentifier;
+   __u8  bConnectionRate;
+   __u8  bReserved;
+   __u8  bDestinationSASAddress[8];
+   __u32 uRequestLength;
+   CSMI_SAS_SMP_REQUEST Request;
+   __u8  bConnectionStatus;
+   __u8  bReserved2[3];
+   __u32 uResponseBytes;
+   CSMI_SAS_SMP_RESPONSE Response;
+} CSMI_SAS_SMP_PASSTHRU;
+
+typedef struct _CSMI_SAS_SMP_PASSTHRU_BUFFER {
+   IOCTL_HEADER IoctlHeader;
+   CSMI_SAS_SMP_PASSTHRU Parameters;
+} CSMI_SAS_SMP_PASSTHRU_BUFFER;
+
+typedef struct _CSMI_SAS_SSP_PASSTHRU_STATUS {
+   __u8  bConnectionStatus;
+   __u8  bReserved[3];
+   __u8  bDataPresent;
+   __u8  bStatus;
+   __u8  bResponseLength[2];
+   __u8  bResponse[256];
+   __u32 uDataBytes;
+} CSMI_SAS_SSP_PASSTHRU_STATUS;
+
+typedef struct _CSMI_SAS_SSP_PASSTHRU {
+   __u8  bPhyIdentifier;
+   __u8  bPortIdentifier;
+   __u8  bConnectionRate;
+   __u8  bReserved;
+   __u8  bDestinationSASAddress[8];
+   __u8  bLun[8];
+   __u8  bCDBLength;
+   __u8  bAdditionalCDBLength;
+   __u8  bReserved2[2];
+   __u8  bCDB[16];
+   __u32 uFlags;
+   __u8  bAdditionalCDB[24];
+   __u32 uDataLength;
+} CSMI_SAS_SSP_PASSTHRU;
+
+typedef struct _CSMI_SAS_SSP_PASSTHRU_BUFFER {
+   IOCTL_HEADER IoctlHeader;
+   CSMI_SAS_SSP_PASSTHRU Parameters;
+   CSMI_SAS_SSP_PASSTHRU_STATUS Status;
+   __u8  bDataBuffer[1];
+} CSMI_SAS_SSP_PASSTHRU_BUFFER;
+
+typedef struct _CSMI_SAS_STP_PASSTHRU {
+   __u8  bPhyIdentifier;
+   __u8  bPortIdentifier;
+   __u8  bConnectionRate;
+   __u8  bReserved;
+   __u8  bDestinationSASAddress[8];
+   __u8  bReserved2[4];
+   __u8  bCommandFIS[20];
+   __u32 uFlags;
+   __u32 uDataLength;
+} CSMI_SAS_STP_PASSTHRU;
+
+typedef struct _CSMI_SAS_STP_PASSTHRU_STATUS {
+   __u8  bConnectionStatus;
+   __u8  bReserved[3];
+   __u8  bStatusFIS[20];
+   __u32 uSCR[16];
+   __u32 uDataBytes;
+} CSMI_SAS_STP_PASSTHRU_STATUS;
+
+typedef struct _CSMI_SAS_STP_PASSTHRU_BUFFER {
+   IOCTL_HEADER IoctlHeader;
+   CSMI_SAS_STP_PASSTHRU Parameters;
+   CSMI_SAS_STP_PASSTHRU_STATUS Status;
+   __u8  bDataBuffer[1];
+} CSMI_SAS_STP_PASSTHRU_BUFFER;
+
+
 typedef struct _IOCTL_Command_struct {
   LUNAddr_struct	   LUN_info;
   RequestBlock_struct      Request;

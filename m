Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTB0UMR>; Thu, 27 Feb 2003 15:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTB0UMR>; Thu, 27 Feb 2003 15:12:17 -0500
Received: from zmamail02.zma.compaq.com ([161.114.64.102]:60427 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S266806AbTB0ULq>; Thu, 27 Feb 2003 15:11:46 -0500
Date: Thu, 27 Feb 2003 14:24:37 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.63 cciss fix unlikely startup problem
Message-ID: <20030227082437.GA3689@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another cciss patch for 2.5.63

* add cmd_type to sendcmd parameters to allow scsi messages to be
  sent down.
* factor out duplicated code into fill_cmd function.

-- steve

--- linux-2.5.63/drivers/block/cciss.c~sendcmd_cleanup	2003-02-27 13:11:23.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss.c	2003-02-27 14:11:19.000000000 +0600
@@ -132,7 +132,7 @@ static inline void addQ(CommandList_stru
 static void start_io( ctlr_info_t *h);
 static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
 	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
-	unsigned char *scsi3addr);
+	unsigned char *scsi3addr, int cmd_type);
 
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
@@ -830,112 +830,152 @@ static int deregister_disk(int ctlr, int
 	h->drv[logvol].LunID = 0;
 	return(0);
 }
-static int sendcmd_withirq(__u8	cmd,
-	int	ctlr,
-	void	*buff,
-	size_t	size,
-	unsigned int use_unit_num,
-	unsigned int log_unit,
-	__u8	page_code )
+static int fill_cmd(CommandList_struct *c, __u8 cmd, int ctlr, void *buff,
+	size_t size,
+	unsigned int use_unit_num, /* 0: address the controller,
+				      1: address logical volume log_unit,
+				      2: periph device address is scsi3addr */
+	unsigned int log_unit, __u8 page_code, unsigned char *scsi3addr,
+	int cmd_type)
 {
-	ctlr_info_t *h = hba[ctlr];
-	CommandList_struct *c;
-	u64bit	buff_dma_handle;
-	unsigned long flags;
-	int return_status = IO_OK;
-	DECLARE_COMPLETION(wait);
-	
-	if ((c = cmd_alloc(h , 0)) == NULL)
-	{
-		return -ENOMEM;
-	}
-	// Fill in the command type 
+	ctlr_info_t *h= hba[ctlr];
+	u64bit buff_dma_handle;
+	int status = IO_OK;
+
 	c->cmd_type = CMD_IOCTL_PEND;
-	// Fill in Command Header 
-	c->Header.ReplyQueue = 0;  // unused in simple mode
-	if( buff != NULL) 	// buffer to fill 
-	{
+	c->Header.ReplyQueue = 0;
+	if( buff != NULL) {
 		c->Header.SGList = 1;
 		c->Header.SGTotal= 1;
-	} else	// no buffers to fill  
-	{
+	} else {
 		c->Header.SGList = 0;
                 c->Header.SGTotal= 0;
 	}
-	c->Header.Tag.lower = c->busaddr;  // use the kernel address the cmd block for tag
-	// Fill in Request block 	
-	switch(cmd)
-	{
+	c->Header.Tag.lower = c->busaddr;
+
+	c->Request.Type.Type = cmd_type;
+	if (cmd_type == TYPE_CMD) {
+		switch(cmd) {
 		case  CISS_INQUIRY:
 			/* If the logical unit number is 0 then, this is going
-				to controller so It's a physical command
-				mode = 0 target = 0.
-				So we have nothing to write. 
-				Otherwise 
-				mode = 1  target = LUNID
-			*/
-			if(use_unit_num != 0)
-			{
+			to controller so It's a physical command
+			mode = 0 target = 0.  So we have nothing to write.
+			otherwise, if use_unit_num == 1,
+			mode = 1(volume set addressing) target = LUNID
+			otherwise, if use_unit_num == 2,
+			mode = 0(periph dev addr) target = scsi3addr */
+			if (use_unit_num == 1) {
 				c->Header.LUN.LogDev.VolId=
-                                	hba[ctlr]->drv[log_unit].LunID;
+					h->drv[log_unit].LunID;
                         	c->Header.LUN.LogDev.Mode = 1;
+			} else if (use_unit_num == 2) {
+				memcpy(c->Header.LUN.LunAddrBytes,scsi3addr,8);
+				c->Header.LUN.LogDev.Mode = 0;
 			}
-			if(page_code != 0)
-			{
+			/* are we trying to read a vital product page */
+			if(page_code != 0) {
 				c->Request.CDB[1] = 0x01;
 				c->Request.CDB[2] = page_code;
 			}
 			c->Request.CDBLen = 6;
-			c->Request.Type.Type =  TYPE_CMD; // It is a command. 
 			c->Request.Type.Attribute = ATTR_SIMPLE;  
-			c->Request.Type.Direction = XFER_READ; // Read 
-			c->Request.Timeout = 0; // Don't time out 
+			c->Request.Type.Direction = XFER_READ;
+			c->Request.Timeout = 0;
 			c->Request.CDB[0] =  CISS_INQUIRY;
 			c->Request.CDB[4] = size  & 0xFF;  
 		break;
-	case CISS_REPORT_LOG:
+		case CISS_REPORT_LOG:
+		case CISS_REPORT_PHYS:
                         /* Talking to controller so It's a physical command
-                                mode = 00 target = 0.
-                                So we have nothing to write.
+			   mode = 00 target = 0.  Nothing to write.
                         */
-                        c->Request.CDBLen = 12;
-                        c->Request.Type.Type =  TYPE_CMD; // It is a command.
-                        c->Request.Type.Attribute = ATTR_SIMPLE; 
-                        c->Request.Type.Direction = XFER_READ; // Read
-                        c->Request.Timeout = 0; // Don't time out
-                        c->Request.CDB[0] = CISS_REPORT_LOG;
-                        c->Request.CDB[6] = (size >> 24) & 0xFF;  //MSB
-                        c->Request.CDB[7] = (size >> 16) & 0xFF;
-                        c->Request.CDB[8] = (size >> 8) & 0xFF;
-                        c->Request.CDB[9] = size & 0xFF;
-                break;
-	case CCISS_READ_CAPACITY:
-			c->Header.LUN.LogDev.VolId= 
-				hba[ctlr]->drv[log_unit].LunID;
+			c->Request.CDBLen = 12;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_READ;
+			c->Request.Timeout = 0;
+			c->Request.CDB[0] = cmd;
+			c->Request.CDB[6] = (size >> 24) & 0xFF;  //MSB
+			c->Request.CDB[7] = (size >> 16) & 0xFF;
+			c->Request.CDB[8] = (size >> 8) & 0xFF;
+			c->Request.CDB[9] = size & 0xFF;
+			break;
+
+		case CCISS_READ_CAPACITY:
+			c->Header.LUN.LogDev.VolId = h->drv[log_unit].LunID;
 			c->Header.LUN.LogDev.Mode = 1;
 			c->Request.CDBLen = 10;
-                        c->Request.Type.Type =  TYPE_CMD; // It is a command.
-                        c->Request.Type.Attribute = ATTR_SIMPLE; 
-                        c->Request.Type.Direction = XFER_READ; // Read
-                        c->Request.Timeout = 0; // Don't time out
-                        c->Request.CDB[0] = CCISS_READ_CAPACITY;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_READ;
+			c->Request.Timeout = 0;
+			c->Request.CDB[0] = cmd;
+		break;
+		case CCISS_CACHE_FLUSH:
+			c->Request.CDBLen = 12;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_WRITE;
+			c->Request.Timeout = 0;
+			c->Request.CDB[0] = BMIC_WRITE;
+			c->Request.CDB[6] = BMIC_CACHE_FLUSH;
 		break;
 		default:
 			printk(KERN_WARNING
-				"cciss:  Unknown Command 0x%c sent attempted\n", cmd);
-			cmd_free(h, c, 1);
+				"cciss%d:  Unknown Command 0x%c\n", ctlr, cmd);
 			return(IO_ERROR);
-	};
-
-	// Fill in the scatter gather information
-	if (size > 0 ) 
-	{
-		buff_dma_handle.val = (__u64) pci_map_single( h->pdev, 
+		}
+	} else if (cmd_type == TYPE_MSG) {
+		switch (cmd) {
+		case 3:	/* No-Op message */
+			c->Request.CDBLen = 1;
+			c->Request.Type.Attribute = ATTR_SIMPLE;
+			c->Request.Type.Direction = XFER_WRITE;
+			c->Request.Timeout = 0;
+			c->Request.CDB[0] = cmd;
+			break;
+		default:
+			printk(KERN_WARNING
+				"cciss%d: unknown message type %d\n",
+				ctlr, cmd);
+			return IO_ERROR;
+		}
+	} else {
+		printk(KERN_WARNING
+			"cciss%d: unknown command type %d\n", ctlr, cmd_type);
+		return IO_ERROR;
+	}
+	/* Fill in the scatter gather information */
+	if (size > 0) {
+		buff_dma_handle.val = (__u64) pci_map_single(h->pdev,
 			buff, size, PCI_DMA_BIDIRECTIONAL);
 		c->SG[0].Addr.lower = buff_dma_handle.val32.lower;
 		c->SG[0].Addr.upper = buff_dma_handle.val32.upper;
 		c->SG[0].Len = size;
-		c->SG[0].Ext = 0;  // we are not chaining
+		c->SG[0].Ext = 0;  /* we are not chaining */
+	}
+	return status;
+}
+static int sendcmd_withirq(__u8	cmd,
+	int	ctlr,
+	void	*buff,
+	size_t	size,
+	unsigned int use_unit_num,
+	unsigned int log_unit,
+	__u8	page_code,
+	int cmd_type)
+{
+	ctlr_info_t *h = hba[ctlr];
+	CommandList_struct *c;
+	u64bit	buff_dma_handle;
+	unsigned long flags;
+	int return_status;
+	DECLARE_COMPLETION(wait);
+	
+	if ((c = cmd_alloc(h , 0)) == NULL)
+		return -ENOMEM;
+	return_status = fill_cmd(c, cmd, ctlr, buff, size, use_unit_num,
+		log_unit, page_code, NULL, cmd_type);
+	if (return_status != IO_OK) {
+		cmd_free(h, c, 0);
+		return return_status;
 	}
 resend_cmd2:
 	c->waiting = &wait;
@@ -1040,10 +1080,10 @@ static void cciss_geometry_inquiry(int c
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
 	if (withirq)
 		return_code = sendcmd_withirq(CISS_INQUIRY, ctlr,
-			inq_buff, sizeof(*inq_buff), 1, logvol ,0xC1);
+			inq_buff, sizeof(*inq_buff), 1, logvol ,0xC1, TYPE_CMD);
 	else
 		return_code = sendcmd(CISS_INQUIRY, ctlr, inq_buff,
-			sizeof(*inq_buff), 1, logvol ,0xC1, NULL);
+			sizeof(*inq_buff), 1, logvol ,0xC1, NULL, TYPE_CMD);
 	if (return_code == IO_OK) {
 		if(inq_buff->data_byte[8] == 0xFF) {
 			printk(KERN_WARNING
@@ -1082,10 +1122,10 @@ cciss_read_capacity(int ctlr, int logvol
 	memset(buf, 0, sizeof(*buf));
 	if (withirq)
 		return_code = sendcmd_withirq(CCISS_READ_CAPACITY,
-			ctlr, buf, sizeof(*buf), 1, logvol, 0 );
+			ctlr, buf, sizeof(*buf), 1, logvol, 0, TYPE_CMD);
 	else
 		return_code = sendcmd(CCISS_READ_CAPACITY,
-			ctlr, buf, sizeof(*buf), 1, logvol, 0, NULL );
+			ctlr, buf, sizeof(*buf), 1, logvol, 0, NULL, TYPE_CMD);
 	if (return_code == IO_OK) {
 		*total_size = be32_to_cpu(*((__u32 *) &buf->total_size[0]))+1;
 		*block_size = be32_to_cpu(*((__u32 *) &buf->block_size[0]));
@@ -1136,7 +1176,7 @@ static int register_new_disk(int ctlr)
 		goto mem_msg;
 	
 	return_code = sendcmd_withirq(CISS_REPORT_LOG, ctlr, ld_buff, 
-			sizeof(ReportLunData_struct), 0, 0, 0 );
+			sizeof(ReportLunData_struct), 0, 0, 0, TYPE_CMD);
 
 	if( return_code == IO_OK)
 	{
@@ -1290,126 +1330,25 @@ static int sendcmd(
 				      2: periph device address is scsi3addr */
 	unsigned int log_unit,
 	__u8	page_code,
-	unsigned char *scsi3addr)
+	unsigned char *scsi3addr,
+	int cmd_type)
 {
 	CommandList_struct *c;
 	int i;
 	unsigned long complete;
 	ctlr_info_t *info_p= hba[ctlr];
 	u64bit buff_dma_handle;
-	int status = IO_OK;
+	int status;
 
-	c = cmd_alloc(info_p, 1);
-	if (c == NULL)
-	{
+	if ((c = cmd_alloc(info_p, 1)) == NULL) {
 		printk(KERN_WARNING "cciss: unable to get memory");
 		return(IO_ERROR);
 	}
-	// Fill in Command Header 
-	c->Header.ReplyQueue = 0;  // unused in simple mode
-	if( buff != NULL) 	// buffer to fill 
-	{
-		c->Header.SGList = 1;
-		c->Header.SGTotal= 1;
-	} else	// no buffers to fill  
-	{
-		c->Header.SGList = 0;
-                c->Header.SGTotal= 0;
-	}
-	c->Header.Tag.lower = c->busaddr;  // use the kernel address the cmd block for tag
-	// Fill in Request block 	
-	switch(cmd)
-	{
-		case  CISS_INQUIRY:
-			/* If the logical unit number is 0 then, this is going
-				to controller so It's a physical command
-				mode = 0 target = 0.
-				So we have nothing to write. 
-				otherwise, if use_unit_num == 1, 
-				mode = 1(volume set addressing) target = LUNID
-				otherwise, if use_unit_num == 2,
-				mode = 0(periph dev addr) target = scsi3addr 
-			*/
-			if(use_unit_num == 1)
-			{
-				c->Header.LUN.LogDev.VolId=
-                                	hba[ctlr]->drv[log_unit].LunID;
-                        	c->Header.LUN.LogDev.Mode = 1;
-			}
-			else if (use_unit_num == 2)
-			{
-				memcpy(c->Header.LUN.LunAddrBytes,scsi3addr,8);
-                        	c->Header.LUN.LogDev.Mode = 0; // phys dev addr 
-			}
-
-			/* are we trying to read a vital product page */
-			if(page_code != 0)
-			{
-				c->Request.CDB[1] = 0x01;
-				c->Request.CDB[2] = page_code;
-			}
-			c->Request.CDBLen = 6;
-			c->Request.Type.Type =  TYPE_CMD; // It is a command. 
-			c->Request.Type.Attribute = ATTR_SIMPLE;  
-			c->Request.Type.Direction = XFER_READ; // Read 
-			c->Request.Timeout = 0; // Don't time out 
-			c->Request.CDB[0] =  CISS_INQUIRY;
-			c->Request.CDB[4] = size  & 0xFF;  
-		break;
-		case CISS_REPORT_LOG:
-		case CISS_REPORT_PHYS:
-                        /* Talking to controller so It's a physical command
-                                mode = 00 target = 0.
-                                So we have nothing to write.
-                        */
-                        c->Request.CDBLen = 12;
-                        c->Request.Type.Type =  TYPE_CMD; // It is a command.
-                        c->Request.Type.Attribute = ATTR_SIMPLE; 
-                        c->Request.Type.Direction = XFER_READ; // Read
-                        c->Request.Timeout = 0; // Don't time out
-                        c->Request.CDB[0] = cmd;
-                        c->Request.CDB[6] = (size >> 24) & 0xFF;  //MSB
-                        c->Request.CDB[7] = (size >> 16) & 0xFF;
-                        c->Request.CDB[8] = (size >> 8) & 0xFF;
-                        c->Request.CDB[9] = size & 0xFF;
-                break;
-
-		case CCISS_READ_CAPACITY:
-			c->Header.LUN.LogDev.VolId= 
-				hba[ctlr]->drv[log_unit].LunID;
-			c->Header.LUN.LogDev.Mode = 1;
-			c->Request.CDBLen = 10;
-                        c->Request.Type.Type =  TYPE_CMD; // It is a command.
-                        c->Request.Type.Attribute = ATTR_SIMPLE; 
-                        c->Request.Type.Direction = XFER_READ; // Read
-                        c->Request.Timeout = 0; // Don't time out
-                        c->Request.CDB[0] = CCISS_READ_CAPACITY;
-		break;
-		case CCISS_CACHE_FLUSH:
-			c->Request.CDBLen = 12;
-                        c->Request.Type.Type =  TYPE_CMD; // It is a command.
-                        c->Request.Type.Attribute = ATTR_SIMPLE;
-                        c->Request.Type.Direction = XFER_WRITE; // No data
-                        c->Request.Timeout = 0; // Don't time out
-                        c->Request.CDB[0] = BMIC_WRITE;  // BMIC Passthru
-                        c->Request.CDB[6] = BMIC_CACHE_FLUSH;
-		break;
-		default:
-			printk(KERN_WARNING
-				"cciss:  Unknown Command 0x%c sent attempted\n",
-				  cmd);
-			cmd_free(info_p, c, 1);
-			return(IO_ERROR);
-	};
-	// Fill in the scatter gather information
-	if (size > 0 ) 
-	{
-		buff_dma_handle.val = (__u64) pci_map_single( info_p->pdev, 
-			buff, size, PCI_DMA_BIDIRECTIONAL);
-		c->SG[0].Addr.lower = buff_dma_handle.val32.lower;
-		c->SG[0].Addr.upper = buff_dma_handle.val32.upper;
-		c->SG[0].Len = size;
-		c->SG[0].Ext = 0;  // we are not chaining
+	status = fill_cmd(c, cmd, ctlr, buff, size, use_unit_num,
+		log_unit, page_code, scsi3addr, cmd_type);
+	if (status != IO_OK) {
+		cmd_free(info_p, c, 1);
+		return status;
 	}
 resend_cmd1:
 	/*
@@ -2187,7 +2126,7 @@ static void cciss_getgeometry(int cntl_n
         }
 	/* Get the firmware version */ 
 	return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff, 
-		sizeof(InquiryData_struct), 0, 0 ,0, NULL );
+		sizeof(InquiryData_struct), 0, 0 ,0, NULL, TYPE_CMD);
 	if (return_code == IO_OK)
 	{
 		hba[cntl_num]->firm_ver[0] = inq_buff->data_byte[32];
@@ -2201,7 +2140,7 @@ static void cciss_getgeometry(int cntl_n
 	}
 	/* Get the number of logical volumes */ 
 	return_code = sendcmd(CISS_REPORT_LOG, cntl_num, ld_buff, 
-			sizeof(ReportLunData_struct), 0, 0, 0, NULL );
+			sizeof(ReportLunData_struct), 0, 0, 0, NULL, TYPE_CMD);
 
 	if( return_code == IO_OK)
 	{
@@ -2475,7 +2414,8 @@ static void __devexit cciss_remove_one (
 	/* sendcmd will turn off interrupt, and send the flush...
 	* To write all data in the battery backed cache to disks */
 	memset(flush_buf, 0, 4);
-	return_code = sendcmd(CCISS_CACHE_FLUSH, i, flush_buf, 4, 0, 0, 0, NULL);
+	return_code = sendcmd(CCISS_CACHE_FLUSH, i, flush_buf, 4, 0, 0, 0, NULL,
+				TYPE_CMD);
 	if(return_code != IO_OK)
 	{
 		printk(KERN_WARNING "Error Flushing cache on controller %d\n", 
--- linux-2.5.63/drivers/block/cciss_scsi.c~sendcmd_cleanup	2003-02-27 13:11:23.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss_scsi.c	2003-02-27 13:11:23.000000000 +0600
@@ -47,7 +47,8 @@ static int sendcmd(
 				      2: address is in scsi3addr */
 	unsigned int log_unit,
 	__u8	page_code,
-	unsigned char *scsi3addr );
+	unsigned char *scsi3addr,
+	int cmd_type);
 
 
 int __init cciss_scsi_detect(Scsi_Host_Template *tpnt);

_



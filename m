Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUE1QDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUE1QDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUE1QDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:03:16 -0400
Received: from [213.239.201.226] ([213.239.201.226]:57058 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S263596AbUE1QC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:02:59 -0400
Message-ID: <40B76428.4000504@shadowconnect.com>
Date: Fri, 28 May 2004 18:09:12 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] remove calls of obsolete scsi APIs in i2o_scsi
Content-Type: multipart/mixed;
 boundary="------------040800060500070800050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040800060500070800050809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

here is a patch from Christoph Hellwig, which removes calls of the 
obsolete scsi API in i2o_scsi.

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------040800060500070800050809
Content-Type: text/x-patch;
 name="i2o_scsi-remove-obsolete-api-calls.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_scsi-remove-obsolete-api-calls.patch"

--- a/drivers/message/i2o/i2o_scsi.c	2004-05-26 15:06:02.000000000 +0200
+++ b/drivers/message/i2o/i2o_scsi.c	2004-05-28 16:36:13.000000000 +0200
@@ -59,9 +59,11 @@
 #include <asm/atomic.h>
 #include <linux/blkdev.h>
 #include <linux/i2o.h>
-#include "../../scsi/scsi.h"
-#include "../../scsi/hosts.h"
 
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
 
 
 #define VERSION_STRING        "Version 0.1.2"
@@ -186,7 +188,7 @@
 
 static void i2o_scsi_reply(struct i2o_handler *h, struct i2o_controller *c, struct i2o_message *msg)
 {
-	Scsi_Cmnd *current_command;
+	struct scsi_cmnd *current_command;
 	spinlock_t *lock;
 	u32 *m = (u32 *)msg;
 	u8 as,ds,st;
@@ -230,7 +232,7 @@
 		{
 			spin_unlock_irqrestore(&retry_lock, flags);
 			/* Create a scsi error for this */
-			current_command = (Scsi_Cmnd *)i2o_context_list_get(m[3], c);
+			current_command = (struct scsi_cmnd *)i2o_context_list_get(m[3], c);
 			if(!current_command)
 				return;
 
@@ -277,7 +279,7 @@
 		return;
 	}
 
-	current_command = (Scsi_Cmnd *)i2o_context_list_get(m[3], c);
+	current_command = (struct scsi_cmnd *)i2o_context_list_get(m[3], c);
 	
 	/*
 	 *	Is this a control request coming back - eg an abort ?
@@ -330,10 +332,17 @@
 		 */		
 		current_command->result = DID_OK << 16 | ds;
 
-	if (current_command->use_sg)
-		pci_unmap_sg(c->pdev, (struct scatterlist *)current_command->buffer, current_command->use_sg, scsi_to_pci_dma_dir(current_command->sc_data_direction));
-	else if (current_command->request_bufflen)
-		pci_unmap_single(c->pdev, (dma_addr_t)((long)current_command->SCp.ptr), current_command->request_bufflen, scsi_to_pci_dma_dir(current_command->sc_data_direction));
+	if (current_command->use_sg) {
+		pci_unmap_sg(c->pdev,
+			(struct scatterlist *)current_command->buffer,
+			current_command->use_sg,
+			current_command->sc_data_direction);
+	} else if (current_command->request_bufflen) {
+		pci_unmap_single(c->pdev,
+			(dma_addr_t)((long)current_command->SCp.ptr),
+			current_command->request_bufflen,
+			current_command->sc_data_direction);
+	}
 
 	lock = current_command->device->host->host_lock;
 	spin_lock_irqsave(lock, flags);
@@ -461,7 +470,7 @@
  *	scsi controller and then let the enumeration fake up the rest
  */
  
-static int i2o_scsi_detect(Scsi_Host_Template * tpnt)
+static int i2o_scsi_detect(struct scsi_host_template * tpnt)
 {
 	struct Scsi_Host *shpnt = NULL;
 	int i;
@@ -592,12 +601,13 @@
  *	Locks: takes the controller lock on error path only
  */
  
-static int i2o_scsi_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
+static int i2o_scsi_queuecommand(struct scsi_cmnd *SCpnt,
+				 void (*done) (struct scsi_cmnd *))
 {
 	int i;
 	int tid;
 	struct i2o_controller *c;
-	Scsi_Cmnd *current_command;
+	struct scsi_cmnd *current_command;
 	struct Scsi_Host *host;
 	struct i2o_scsi_host *hostdata;
 	u32 *msg, *mptr;
@@ -668,19 +678,14 @@
 	len = SCpnt->request_bufflen;
 	direction = 0x00000000;			// SGL IN  (osm<--iop)
 	
-	if(SCpnt->sc_data_direction == SCSI_DATA_NONE)
+	if (SCpnt->sc_data_direction == DMA_NONE) {
 		scsidir = 0x00000000;			// DATA NO XFER
-	else if(SCpnt->sc_data_direction == SCSI_DATA_WRITE)
-	{
-		direction=0x04000000;	// SGL OUT  (osm-->iop)
-		scsidir  =0x80000000;	// DATA OUT (iop-->dev)
-	}
-	else if(SCpnt->sc_data_direction == SCSI_DATA_READ)
-	{
-		scsidir  =0x40000000;	// DATA IN  (iop<--dev)
-	}
-	else
-	{
+	} else if (SCpnt->sc_data_direction == DMA_TO_DEVICE) {
+		direction = 0x04000000;	// SGL OUT  (osm-->iop)
+		scsidir = 0x80000000;	// DATA OUT (iop-->dev)
+	} else if(SCpnt->sc_data_direction == DMA_FROM_DEVICE) {
+		scsidir = 0x40000000;	// DATA IN  (iop<--dev)
+	} else {
 		/* Unknown - kill the command */
 		SCpnt->result = DID_NO_CONNECT << 16;
 		
@@ -768,7 +773,7 @@
 		len = 0;
 
 		sg_count = pci_map_sg(c->pdev, sg, SCpnt->use_sg,
-				      scsi_to_pci_dma_dir(SCpnt->sc_data_direction));
+				SCpnt->sc_data_direction);
 
 		/* FIXME: handle fail */
 		if(!sg_count)
@@ -840,7 +845,7 @@
 			dma_addr = pci_map_single(c->pdev,
 					       SCpnt->request_buffer,
 					       SCpnt->request_bufflen,
-					       scsi_to_pci_dma_dir(SCpnt->sc_data_direction));
+					       SCpnt->sc_data_direction);
 			if(dma_addr == 0)
 				BUG();	/* How to handle ?? */
 			SCpnt->SCp.ptr = (char *)(unsigned long) dma_addr;
@@ -883,7 +888,7 @@
  *	Locks: no locks are held or needed
  */
  
-int i2o_scsi_abort(Scsi_Cmnd * SCpnt)
+static int i2o_scsi_abort(struct scsi_cmnd * SCpnt)
 {
 	struct i2o_controller *c;
 	struct Scsi_Host *host;
@@ -929,7 +934,7 @@
  *	Locks: called with no lock held, requires no locks.
  */
  
-static int i2o_scsi_bus_reset(Scsi_Cmnd * SCpnt)
+static int i2o_scsi_bus_reset(struct scsi_cmnd * SCpnt)
 {
 	int tid;
 	struct i2o_controller *c;
@@ -992,32 +997,6 @@
 }
 
 /**
- *	i2o_scsi_host_reset	-	host reset callback
- *	@SCpnt: command causing the reset
- *
- *	An I2O controller can be many things at once. While we can
- *	reset a controller the potential mess from doing so is vast, and
- *	it's better to simply hold on and pray
- */
- 
-static int i2o_scsi_host_reset(Scsi_Cmnd * SCpnt)
-{
-	return FAILED;
-}
-
-/**
- *	i2o_scsi_device_reset	-	device reset callback
- *	@SCpnt: command causing the reset
- *
- *	I2O does not (AFAIK) support doing a device reset
- */
- 
-static int i2o_scsi_device_reset(Scsi_Cmnd * SCpnt)
-{
-	return FAILED;
-}
-
-/**
  *	i2o_scsi_bios_param	-	Invent disk geometry
  *	@sdev: scsi device 
  *	@dev: block layer device
@@ -1048,7 +1027,7 @@
 MODULE_LICENSE("GPL");
 
 
-static Scsi_Host_Template driver_template = {
+static struct scsi_host_template driver_template = {
 	.proc_name		= "i2o_scsi",
 	.name			= "I2O SCSI Layer",
 	.detect			= i2o_scsi_detect,
@@ -1057,8 +1036,6 @@
 	.queuecommand		= i2o_scsi_queuecommand,
 	.eh_abort_handler	= i2o_scsi_abort,
 	.eh_bus_reset_handler	= i2o_scsi_bus_reset,
-	.eh_device_reset_handler= i2o_scsi_device_reset,
-	.eh_host_reset_handler	= i2o_scsi_host_reset,
 	.bios_param		= i2o_scsi_bios_param,
 	.can_queue		= I2O_SCSI_CAN_QUEUE,
 	.this_id		= 15,

--------------040800060500070800050809--

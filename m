Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUFIWXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUFIWXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUFIWXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:23:49 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:8188 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266016AbUFIWXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:23:36 -0400
Subject: PATCH: 2.6.7-rc3 drivers/scsi/cpqfcTSinit.c several user/kernel
	pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: linux-scsi@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 15:23:34 -0700
Message-Id: <1086819814.14180.86.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since "ioc" is copied from user-space, vendor_cmd = ioc.argp cannot be trusted,
so derefing vendor_cmd via expressions like "vendor_cmd->len" is unsafe.

Let me know if you have any questions, and I apologize if I've made a mistake 
in my analysis.

Best,
Rob


--- linux-2.6.7-rc3-full/drivers/scsi/cpqfcTSinit.c.orig	Wed Jun  9 12:20:15 2004
+++ linux-2.6.7-rc3-full/drivers/scsi/cpqfcTSinit.c	Wed Jun  9 12:18:50 2004
@@ -556,7 +556,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
   struct scsi_cmnd *DumCmnd;
   int i, j;
   VENDOR_IOCTL_REQ ioc;
-  cpqfc_passthru_t *vendor_cmd;
+  cpqfc_passthru_t vendor_cmd;
   Scsi_Device *SDpnt;
   Scsi_Request *ScsiPassThruReq;
   cpqfc_passthru_private_t *privatedata;
@@ -590,12 +590,14 @@ int cpqfcTS_ioctl( struct scsi_device *S
         if( copy_from_user( &ioc, arg, sizeof( VENDOR_IOCTL_REQ)))
 		return( -EFAULT);
 
-	vendor_cmd = ioc.argp;  // i.e., CPQ specific command struct
+        // CPQ specific command struct
+	if (copy_from_user(&vendor_cmd, ioc.argp, sizeof(vendor_cmd)))
+		return (-EFAULT); 
 
 	// If necessary, grab a kernel/DMA buffer
-	if( vendor_cmd->len)
+	if( vendor_cmd.len)
 	{
-  	  buf = kmalloc( vendor_cmd->len, GFP_KERNEL);
+  	  buf = kmalloc( vendor_cmd.len, GFP_KERNEL);
 	  if( !buf)
 	    return -ENOMEM;
 	}
@@ -613,10 +615,10 @@ int cpqfcTS_ioctl( struct scsi_device *S
 		return -ENOMEM;
 	}
 
-	if (vendor_cmd->rw_flag == VENDOR_WRITE_OPCODE) {
-		if (vendor_cmd->len) { // Need data from user?
-        		if (copy_from_user(buf, vendor_cmd->bufp, 
-						vendor_cmd->len)) {
+	if (vendor_cmd.rw_flag == VENDOR_WRITE_OPCODE) {
+		if (vendor_cmd.len) { // Need data from user?
+        		if (copy_from_user(buf, vendor_cmd.bufp, 
+						vendor_cmd.len)) {
 				kfree(buf);
 				cpqfc_free_private_data(cpqfcHBAdata, 
 					ScsiPassThruReq->upper_private_data);
@@ -625,7 +627,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
 			}
 		}
 		ScsiPassThruReq->sr_data_direction = SCSI_DATA_WRITE; 
-	} else if (vendor_cmd->rw_flag == VENDOR_READ_OPCODE) {
+	} else if (vendor_cmd.rw_flag == VENDOR_READ_OPCODE) {
 		ScsiPassThruReq->sr_data_direction = SCSI_DATA_READ; 
 	} else
 		// maybe this means a bug in the user app
@@ -642,12 +644,12 @@ int cpqfcTS_ioctl( struct scsi_device *S
 	// FC Link events with our "worker thread".
 
 	privatedata = ScsiPassThruReq->upper_private_data;
-	privatedata->bus = vendor_cmd->bus;
-	privatedata->pdrive = vendor_cmd->pdrive;
+	privatedata->bus = vendor_cmd.bus;
+	privatedata->pdrive = vendor_cmd.pdrive;
 	
         // eventually gets us to our own _quecommand routine
 	scsi_wait_req(ScsiPassThruReq, 
-		&vendor_cmd->cdb[0], buf, vendor_cmd->len, 
+		&vendor_cmd.cdb[0], buf, vendor_cmd.len, 
 		10*HZ,  // timeout
 		1);	// retries
         result = ScsiPassThruReq->sr_result;
@@ -655,12 +657,12 @@ int cpqfcTS_ioctl( struct scsi_device *S
         // copy any sense data back to caller
         if( result != 0 )
 	{
-	  memcpy( vendor_cmd->sense_data, // see struct def - size=40
+	  memcpy( vendor_cmd.sense_data, // see struct def - size=40
 		  ScsiPassThruReq->sr_sense_buffer, 
 		  sizeof(ScsiPassThruReq->sr_sense_buffer) <
-                  sizeof(vendor_cmd->sense_data)           ?
+                  sizeof(vendor_cmd.sense_data)           ?
                   sizeof(ScsiPassThruReq->sr_sense_buffer) :
-                  sizeof(vendor_cmd->sense_data)
+                  sizeof(vendor_cmd.sense_data)
                 ); 
 	}
         SDpnt = ScsiPassThruReq->sr_device;
@@ -669,9 +671,9 @@ int cpqfcTS_ioctl( struct scsi_device *S
         ScsiPassThruReq = NULL;
 
 	// need to pass data back to user (space)?
-	if( (vendor_cmd->rw_flag == VENDOR_READ_OPCODE) &&
-	     vendor_cmd->len )
-        if(  copy_to_user( vendor_cmd->bufp, buf, vendor_cmd->len))
+	if( (vendor_cmd.rw_flag == VENDOR_READ_OPCODE) &&
+	     vendor_cmd.len )
+        if(  copy_to_user( vendor_cmd.bufp, buf, vendor_cmd.len))
 		result = -EFAULT;
 
         if( buf) 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267960AbTBMFLW>; Thu, 13 Feb 2003 00:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbTBMFLW>; Thu, 13 Feb 2003 00:11:22 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:28141 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP
	id <S267960AbTBMFLT>; Thu, 13 Feb 2003 00:11:19 -0500
Message-ID: <3E4B2ACE.564BC505@verizon.net>
Date: Wed, 12 Feb 2003 21:19:10 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] repair 2.5.60 i2o_scsi.c
Content-Type: multipart/mixed;
 boundary="------------9D46BA4EC2A5019DA0E80D78"
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [4.64.238.61] at Wed, 12 Feb 2003 23:21:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D46BA4EC2A5019DA0E80D78
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch to 2.5.60 repairs i2o_scsi.c for the SCSI
data structure changes in 2.5.60.

This is for kernel bugzilla #343:
http://bugme.osdl.org/show_bug.cgi?id=343

~Randy
--------------9D46BA4EC2A5019DA0E80D78
Content-Type: text/plain; charset=us-ascii;
 name="scsi-i2o-2560.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-i2o-2560.patch"

patch_name:	scsi-i2o-2560.patch
patch_version:	2003-02-12.21:12:48
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	repair data structures for 2.5.60 SCSI changes
product:	Linux
product_versions: linux-2560
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 i2o_scsi.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


diff -Naur ./drivers/message/i2o/i2o_scsi.c%I2O ./drivers/message/i2o/i2o_scsi.c
--- ./drivers/message/i2o/i2o_scsi.c%I2O	Mon Feb 10 10:38:49 2003
+++ ./drivers/message/i2o/i2o_scsi.c	Wed Feb 12 21:11:14 2003
@@ -224,7 +224,7 @@
 			spin_unlock_irqrestore(&retry_lock, flags);
 			/* Create a scsi error for this */
 			current_command = (Scsi_Cmnd *)m[3];
-			lock = current_command->host->host_lock;
+			lock = current_command->device->host->host_lock;
 			printk("Aborted %ld\n", current_command->serial_number);
 
 			spin_lock_irqsave(lock, flags);
@@ -328,7 +328,7 @@
 	else if (current_command->request_bufflen)
 		pci_unmap_single(c->pdev, (dma_addr_t)((long)current_command->SCp.ptr), current_command->request_bufflen, scsi_to_pci_dma_dir(current_command->sc_data_direction));
 
-	lock = current_command->host->host_lock;
+	lock = current_command->device->host->host_lock;
 	spin_lock_irqsave(lock, flags);
 	current_command->scsi_done(current_command);
 	spin_unlock_irqrestore(lock, flags);
@@ -606,7 +606,7 @@
 	 *	Do the incoming paperwork
 	 */
 	 
-	host = SCpnt->host;
+	host = SCpnt->device->host;
 	hostdata = (struct i2o_scsi_host *)host->hostdata;
 	 
 	c = hostdata->controller;
@@ -615,13 +615,13 @@
 
 	SCpnt->scsi_done = done;
 	
-	if(SCpnt->target > 15)
+	if(SCpnt->device->id > 15)
 	{
-		printk(KERN_ERR "i2o_scsi: Wild target %d.\n", SCpnt->target);
+		printk(KERN_ERR "i2o_scsi: Wild target %d.\n", SCpnt->device->id);
 		return -1;
 	}
 	
-	tid = hostdata->task[SCpnt->target][SCpnt->lun];
+	tid = hostdata->task[SCpnt->device->id][SCpnt->device->lun];
 	
 	dprintk(("qcmd: Tid = %d\n", tid));
 	
@@ -712,10 +712,10 @@
 		 *	with tagged queueing. We throw in the odd ordered
 		 *	tag to stop them starving themselves.
 		 */
-		if((jiffies - hostdata->tagclock[SCpnt->target][SCpnt->lun]) > (5*HZ))
+		if((jiffies - hostdata->tagclock[SCpnt->device->id][SCpnt->device->lun]) > (5*HZ))
 		{
 			tag=0x01800000;		/* ORDERED! */
-			hostdata->tagclock[SCpnt->target][SCpnt->lun]=jiffies;
+			hostdata->tagclock[SCpnt->device->id][SCpnt->device->lun]=jiffies;
 		}
 		else
 		{
@@ -916,9 +916,9 @@
 	
 	printk(KERN_WARNING "i2o_scsi: Aborting command block.\n");
 	
-	host = SCpnt->host;
+	host = SCpnt->device->host;
 	hostdata = (struct i2o_scsi_host *)host->hostdata;
-	tid = hostdata->task[SCpnt->target][SCpnt->lun];
+	tid = hostdata->task[SCpnt->device->id][SCpnt->device->lun];
 	if(tid==-1)
 	{
 		printk(KERN_ERR "i2o_scsi: Impossible command to abort!\n");
@@ -982,7 +982,7 @@
 	 */
 
 	
-	host = SCpnt->host;
+	host = SCpnt->device->host;
 
 	spin_unlock_irq(host->host_lock);
 

--------------9D46BA4EC2A5019DA0E80D78--


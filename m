Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTBNVki>; Fri, 14 Feb 2003 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbTBNUyT>; Fri, 14 Feb 2003 15:54:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267480AbTBNUxV>; Fri, 14 Feb 2003 15:53:21 -0500
Subject: PATCH: fix i2o_scsi (submission from Randy)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:03:18 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmzO-0005fM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just approving this as maintainer of i2o_scsi

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/message/i2o/i2o_scsi.c linux-2.5.60-ac1/drivers/message/i2o/i2o_scsi.c
--- linux-2.5.60-ref/drivers/message/i2o/i2o_scsi.c	2003-02-14 21:21:41.000000000 +0000
+++ linux-2.5.60-ac1/drivers/message/i2o/i2o_scsi.c	2003-02-14 19:14:46.000000000 +0000
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
 

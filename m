Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbTIDVRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265565AbTIDVRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:17:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:57064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265551AbTIDVRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:17:03 -0400
Date: Thu, 4 Sep 2003 14:17:39 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compiler warning fixes for DAC960 on alpha
Message-ID: <20030904211739.GA26861@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is forwarded from Jay Estabrook at HP.  I've compiled the
patch on ia32 and ia64 machines and it's good.  I also recreated
the patch so it would apply to mm5 without fuzzy offsets.
Here's Jay's summary of the patch:

Here's a very small set of patches against 2.6.0-test4 that help the
DAC960 driver compile cleaner (gets rid of warnings on Alpha) and help
it to work on some old OEM'ed DAC960 cards that were sold in our older
Alphas.

The warnings are all concerned with "conversions to different size
without cast", as pointers and longs are same size (8-bytes) but ints
are 4-bytes, on Alpha. I don't believe the change to (long) from (int)
will affect any 32-bit architectures, but those using LP64 like Alpha,
ie SPARC64 and prolly IA64, will have the warnings go away.

The change to make the oldest acceptable firmware version 2.70 instead
of 2.73 is made spcific to Alpha, since it is only those cards that
DEC OEM'ed from Mylex that would have such (as explained a bit better
in the patch itself).

--- linux-2.6.0-test4-mm5/drivers/block/DAC960.c	2003-09-04 09:16:52.000000000 -0700
+++ linux-2.6.0-test4_mm5_DAC/drivers/block/DAC960.c	2003-09-04 14:03:40.000000000 -0700
@@ -72,7 +72,7 @@
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	DAC960_Controller_T *p = disk->queue->queuedata;
-	int drive_nr = (int)disk->private_data;
+	int drive_nr = (long)disk->private_data;
 
 	if (p->FirmwareType == DAC960_V1_Controller) {
 		if (p->V1.LogicalDriveInformation[drive_nr].
@@ -97,7 +97,7 @@
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	DAC960_Controller_T *p = disk->queue->queuedata;
-	int drive_nr = (int)disk->private_data;
+	int drive_nr = (long)disk->private_data;
 	struct hd_geometry g, *loc = (struct hd_geometry *)arg;
 
 	if (cmd != HDIO_GETGEO || !loc)
@@ -137,7 +137,7 @@
 static int DAC960_media_changed(struct gendisk *disk)
 {
 	DAC960_Controller_T *p = disk->queue->queuedata;
-	int drive_nr = (int)disk->private_data;
+	int drive_nr = (long)disk->private_data;
 
 	if (!p->LogicalDriveInitiallyAccessible[drive_nr])
 		return 1;
@@ -147,7 +147,7 @@
 static int DAC960_revalidate_disk(struct gendisk *disk)
 {
 	DAC960_Controller_T *p = disk->queue->queuedata;
-	int unit = (int)disk->private_data;
+	int unit = (long)disk->private_data;
 
 	set_capacity(disk, disk_size(p, unit));
 	return 0;
@@ -1604,6 +1604,26 @@
     DAC960PU/PD/PL	    3.51 and above
     DAC960PU/PD/PL/P	    2.73 and above
   */
+#if defined(CONFIG_ALPHA)
+  /*
+    DEC Alpha machines were often equipped with DAC960 cards that were
+    OEMed from Mylex, and had their own custom firmware. Version 2.70,
+    the last custom FW revision to be released by DEC for these older
+    controllers, appears to work quite well with this driver.
+
+    Cards tested successfully were several versions each of the PD and
+    PU, called by DEC the KZPSC and KZPAC, respectively, and having
+    the Manufacturer Numbers (from Mylex), usually on a sticker on the
+    back of the board, of:
+
+    KZPSC:  D040347 (1-channel) or D040348 (2-channel) or D040349 (3-channel)
+    KZPAC:  D040395 (1-channel) or D040396 (2-channel) or D040397 (3-channel)
+  */
+# define FIRMWARE_27X	"2.70"
+#else
+# define FIRMWARE_27X	"2.73"
+#endif
+
   if (Enquiry2->FirmwareID.MajorVersion == 0)
     {
       Enquiry2->FirmwareID.MajorVersion =
@@ -1623,7 +1643,7 @@
 	(Controller->FirmwareVersion[0] == '3' &&
 	 strcmp(Controller->FirmwareVersion, "3.51") >= 0) ||
 	(Controller->FirmwareVersion[0] == '2' &&
-	 strcmp(Controller->FirmwareVersion, "2.73") >= 0)))
+	 strcmp(Controller->FirmwareVersion, FIRMWARE_27X) >= 0)))
     {
       DAC960_Failure(Controller, "FIRMWARE VERSION VERIFICATION");
       DAC960_Error("Firmware Version = '%s'\n", Controller,
@@ -2709,12 +2729,12 @@
 	  break;
   }
 
-  pci_set_drvdata(PCI_Device, (void *)((int)Controller->ControllerNumber));
+  pci_set_drvdata(PCI_Device, (void *)((long)Controller->ControllerNumber));
   for (i = 0; i < DAC960_MaxLogicalDrives; i++) {
 	Controller->disks[i] = alloc_disk(1<<DAC960_MaxPartitionsBits);
 	if (!Controller->disks[i])
 		goto Failure;
-	Controller->disks[i]->private_data = (void *)i;
+	Controller->disks[i]->private_data = (void *)((long)i);
   }
   init_waitqueue_head(&Controller->CommandWaitQueue);
   init_waitqueue_head(&Controller->HealthStatusWaitQueue);
@@ -3098,7 +3118,7 @@
 
 static void DAC960_Remove(struct pci_dev *PCI_Device)
 {
-  int Controller_Number = (int)pci_get_drvdata(PCI_Device);
+  int Controller_Number = (long)pci_get_drvdata(PCI_Device);
   DAC960_Controller_T *Controller = DAC960_Controllers[Controller_Number];
   if (Controller != NULL)
       DAC960_FinalizeController(Controller);
@@ -3273,7 +3293,7 @@
     Command->CommandType = DAC960_WriteCommand;
   }
   Command->Completion = Request->waiting;
-  Command->LogicalDriveNumber = (int)Request->rq_disk->private_data;
+  Command->LogicalDriveNumber = (long)Request->rq_disk->private_data;
   Command->BlockNumber = Request->sector;
   Command->BlockCount = Request->nr_sectors;
   Command->Request = Request;

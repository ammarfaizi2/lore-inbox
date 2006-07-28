Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161296AbWG1UuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbWG1UuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbWG1UuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:50:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:21265 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161296AbWG1UuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:50:11 -0400
Date: Fri, 28 Jul 2006 16:50:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI: early detection of medium not present, updated
Message-ID: <Pine.LNX.4.44L0.0607281633100.5679-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as757) is meant to apply on top of the
scsi-core-and-sd-early-detection-of-medium-not-present patch currently in
2.6.18-rc2-mm1.  It updates the way the scsi_test_unit_ready() routine
reports medium not present, using the technique recommended by James
Bottomley.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

If James would prefer, I could submit this in a different form: first 
revert the earlier SCSI patch and then add the new stuff from this one.

In a brief conversation during OLS, Jens said that he saw no problem with
allowing the block layer to accept -ENOMEDIUM as a return code from the 
media_changed method.  The patch is already in -mm, named
block-layer-early-detection-of-medium-not-present.

In principle cdrom drivers could use a similar technique to avoid calling 
the revalidate method when no disc is loaded, but that would require more 
far-reaching changes.  For now it's easier to confine this to disk drives.


Index: 2.6.18-rc2-mm1/drivers/scsi/sd.c
===================================================================
--- 2.6.18-rc2-mm1.orig/drivers/scsi/sd.c
+++ 2.6.18-rc2-mm1/drivers/scsi/sd.c
@@ -733,6 +733,7 @@ static int sd_media_changed(struct gendi
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdp = sdkp->device;
 	int retval;
+	int media_not_present = 0;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_media_changed: disk=%s\n",
 						disk->disk_name));
@@ -760,7 +761,8 @@ static int sd_media_changed(struct gendi
 	 */
 	retval = -ENODEV;
 	if (scsi_block_when_processing_errors(sdp))
-		retval = scsi_test_unit_ready(sdp, SD_TIMEOUT, SD_MAX_RETRIES);
+		retval = scsi_test_unit_ready(sdp, SD_TIMEOUT, SD_MAX_RETRIES,
+				&media_not_present);
 
 	/*
 	 * Unable to test, unit probably not ready.   This usually
@@ -768,7 +770,7 @@ static int sd_media_changed(struct gendi
 	 * and we will figure it out later once the drive is
 	 * available again.
 	 */
-	if (retval || sdp->medium_not_present)
+	if (retval || media_not_present)
 		 goto not_present;
 	/*
 	 * For removable scsi disk we have to recognise the presence
Index: 2.6.18-rc2-mm1/include/scsi/scsi_device.h
===================================================================
--- 2.6.18-rc2-mm1.orig/include/scsi/scsi_device.h
+++ 2.6.18-rc2-mm1/include/scsi/scsi_device.h
@@ -92,7 +92,6 @@ struct scsi_device {
 	unsigned writeable:1;
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */
-	unsigned medium_not_present:1;	/* Set by scsi_test_unit_ready() */
 	unsigned busy:1;	/* Used to prevent races */
 	unsigned lockable:1;	/* Able to prevent media removal */
 	unsigned locked:1;      /* Media removal disabled */
@@ -268,7 +267,7 @@ extern int scsi_mode_select(struct scsi_
 			    struct scsi_mode_data *data,
 			    struct scsi_sense_hdr *);
 extern int scsi_test_unit_ready(struct scsi_device *sdev, int timeout,
-				int retries);
+				int retries, int *media_not_present);
 extern int scsi_device_set_state(struct scsi_device *sdev,
 				 enum scsi_device_state state);
 extern int scsi_device_quiesce(struct scsi_device *sdev);
Index: 2.6.18-rc2-mm1/drivers/scsi/sr.c
===================================================================
--- 2.6.18-rc2-mm1.orig/drivers/scsi/sr.c
+++ 2.6.18-rc2-mm1/drivers/scsi/sr.c
@@ -178,14 +178,16 @@ static int sr_media_change(struct cdrom_
 {
 	struct scsi_cd *cd = cdi->handle;
 	int retval;
+	int media_not_present = 0;
 
 	if (CDSL_CURRENT != slot) {
 		/* no changer support */
 		return -EINVAL;
 	}
 
-	retval = scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES);
-	if (retval) {
+	retval = scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES,
+			&media_not_present);
+	if (retval || media_not_present) {
 		/* Unable to test, unit probably not ready.  This usually
 		 * means there is no disc in the drive.  Mark as changed,
 		 * and we will figure it out later once the drive is
Index: 2.6.18-rc2-mm1/drivers/scsi/scsi_lib.c
===================================================================
--- 2.6.18-rc2-mm1.orig/drivers/scsi/scsi_lib.c
+++ 2.6.18-rc2-mm1/drivers/scsi/scsi_lib.c
@@ -1867,7 +1867,8 @@ scsi_mode_sense(struct scsi_device *sdev
 EXPORT_SYMBOL(scsi_mode_sense);
 
 int
-scsi_test_unit_ready(struct scsi_device *sdev, int timeout, int retries)
+scsi_test_unit_ready(struct scsi_device *sdev, int timeout, int retries,
+		int *media_not_present)
 {
 	char cmd[] = {
 		TEST_UNIT_READY, 0, 0, 0, 0, 0,
@@ -1878,7 +1879,6 @@ scsi_test_unit_ready(struct scsi_device 
 	result = scsi_execute_req(sdev, cmd, DMA_NONE, NULL, 0, &sshdr,
 				  timeout, retries);
 
-	sdev->medium_not_present = 0;
 	if ((driver_byte(result) & DRIVER_SENSE) && sdev->removable) {
 
 		if ((scsi_sense_valid(&sshdr)) &&
@@ -1887,8 +1887,8 @@ scsi_test_unit_ready(struct scsi_device 
 			sdev->changed = 1;
 			result = 0;
 
-			if (sshdr.asc == 0x3A)
-				sdev->medium_not_present = 1;
+			if (sshdr.asc == 0x3A && media_not_present != NULL)
+				*media_not_present = 1;
 		}
 	}
 	return result;
Index: 2.6.18-rc2-mm1/drivers/scsi/scsi_ioctl.c
===================================================================
--- 2.6.18-rc2-mm1.orig/drivers/scsi/scsi_ioctl.c
+++ 2.6.18-rc2-mm1/drivers/scsi/scsi_ioctl.c
@@ -242,7 +242,7 @@ int scsi_ioctl(struct scsi_device *sdev,
 		return scsi_set_medium_removal(sdev, SCSI_REMOVAL_ALLOW);
 	case SCSI_IOCTL_TEST_UNIT_READY:
 		return scsi_test_unit_ready(sdev, IOCTL_NORMAL_TIMEOUT,
-					    NORMAL_RETRIES);
+					    NORMAL_RETRIES, NULL);
 	case SCSI_IOCTL_START_UNIT:
 		scsi_cmd[0] = START_STOP;
 		scsi_cmd[1] = 0;


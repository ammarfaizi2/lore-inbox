Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWFFPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWFFPbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFFPbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:31:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:5387 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751002AbWFFPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:31:01 -0400
Date: Tue, 6 Jun 2006 11:31:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: [PATCH 2/3] SCSI core and sd: early detection of medium not present
Message-ID: <Pine.LNX.4.44L0.0606061126540.9182-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as695) changes the scsi_test_unit_ready() routine in the SCSI 
core to set a new flag when no medium is present.  The sd driver is 
changed to use this new flag for reporting -ENOMEDIUM in from the 
sd_media_changed method.



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/scsi/sd.c
===================================================================
--- usb-2.6.orig/drivers/scsi/sd.c
+++ usb-2.6/drivers/scsi/sd.c
@@ -744,9 +744,8 @@ static int sd_media_changed(struct gendi
 	 * and we will figure it out later once the drive is
 	 * available again.
 	 */
-	if (retval)
+	if (retval || sdp->medium_not_present)
 		 goto not_present;
-
 	/*
 	 * For removable scsi disk we have to recognise the presence
 	 * of a disk in the drive. This is kept in the struct scsi_disk
@@ -761,7 +760,7 @@ static int sd_media_changed(struct gendi
 
 not_present:
 	set_media_not_present(sdkp);
-	return 1;
+	return -ENOMEDIUM;
 }
 
 static int sd_sync_cache(struct scsi_device *sdp)
Index: usb-2.6/include/scsi/scsi_device.h
===================================================================
--- usb-2.6.orig/include/scsi/scsi_device.h
+++ usb-2.6/include/scsi/scsi_device.h
@@ -92,6 +92,7 @@ struct scsi_device {
 	unsigned writeable:1;
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */
+	unsigned medium_not_present:1;	/* Set by scsi_test_unit_ready() */
 	unsigned busy:1;	/* Used to prevent races */
 	unsigned lockable:1;	/* Able to prevent media removal */
 	unsigned locked:1;      /* Media removal disabled */
Index: usb-2.6/drivers/scsi/scsi_lib.c
===================================================================
--- usb-2.6.orig/drivers/scsi/scsi_lib.c
+++ usb-2.6/drivers/scsi/scsi_lib.c
@@ -2026,6 +2026,7 @@ scsi_test_unit_ready(struct scsi_device 
 	result = scsi_execute_req(sdev, cmd, DMA_NONE, NULL, 0, &sshdr,
 				  timeout, retries);
 
+	sdev->medium_not_present = 0;
 	if ((driver_byte(result) & DRIVER_SENSE) && sdev->removable) {
 
 		if ((scsi_sense_valid(&sshdr)) &&
@@ -2033,6 +2034,9 @@ scsi_test_unit_ready(struct scsi_device 
 		     (sshdr.sense_key == NOT_READY))) {
 			sdev->changed = 1;
 			result = 0;
+
+			if (sshdr.asc == 0x3A)
+				sdev->medium_not_present = 1;
 		}
 	}
 	return result;


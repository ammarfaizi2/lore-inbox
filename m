Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWFFPdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWFFPdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFFPdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:33:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38417 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932215AbWFFPdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:33:36 -0400
Date: Tue, 6 Jun 2006 11:33:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: [PATCH 3/3] sd: early detection of medium not present
Message-ID: <Pine.LNX.4.44L0.0606061131020.9182-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as696) moves the check for medium not present a bit earlier in 
the sd_spinup_disk() routine.  The existing code will happily continue 
probing even after the device has told it there is no media.



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/scsi/sd.c
===================================================================
--- usb-2.6.orig/drivers/scsi/sd.c
+++ usb-2.6/drivers/scsi/sd.c
@@ -1046,6 +1046,14 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
 						      &sshdr, SD_TIMEOUT,
 						      SD_MAX_RETRIES);
 
+			/*
+			 * If the drive has indicated to us that it
+			 * doesn't have any media in it, don't bother
+			 * with any of the rest of this crap.
+			 */
+			if (media_not_present(sdkp, &sshdr))
+				return;
+
 			if (the_result)
 				sense_valid = scsi_sense_valid(&sshdr);
 			retries++;
@@ -1054,14 +1062,6 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
 			  ((driver_byte(the_result) & DRIVER_SENSE) &&
 			  sense_valid && sshdr.sense_key == UNIT_ATTENTION)));
 
-		/*
-		 * If the drive has indicated to us that it doesn't have
-		 * any media in it, don't bother with any of the rest of
-		 * this crap.
-		 */
-		if (media_not_present(sdkp, &sshdr))
-			return;
-
 		if ((driver_byte(the_result) & DRIVER_SENSE) == 0) {
 			/* no sense, TUR either succeeded or failed
 			 * with a status error */


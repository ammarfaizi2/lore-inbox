Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUC2Wop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUC2Wop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:44:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:56021 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263199AbUC2WoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:44:18 -0500
Date: Tue, 30 Mar 2004 00:44:09 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200403292244.i2TMi9f11131.aeb@smtp.cwi.nl>
To: greg@kroah.com, mdharm-usb@one-eyed-alien.net
Subject: [patch] datafab fix and unusual devices
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

datafab.c has an often-seen bug: the SCSI READ_CAPACITY command
does not need the number of sectors but the last sector.

I just tried the CF and SM parts of a 5-in-1 card reader.
The CF part works with US_PR_DATAFAB when the bug mentioned is fixed.
The SM part works with US_PR_SDDR55.
(Revision Number is 17.08 - that in case the 0000-ffff
should prove to be too optimistic.)

We still must discuss what setup to use for readers like this -
I have several of them - that require different drivers for
different LUNs. As it is now one has to compile usb-storage
twice, once with CONFIG_USB_STORAGE_DATAFAB defined and once
without, and remove one usb-storage.ko and insert the other
to go from CF to SM. (And that hangs with 2.6.4 so a reboot
is required..)

Andries

[Two years ago I had a very general setup, and when mdharm
didnt like it, a 2-lun setup, the minimal needed for the
devices I had at that time. They must still live in the
archives somewhere. I forgot all details so have no opinion today.]


diff -uprN -X /linux/dontdiff a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
--- a/drivers/usb/storage/datafab.c	2004-02-05 19:55:20.000000000 +0100
+++ b/drivers/usb/storage/datafab.c	2004-03-30 00:00:36.000000000 +0200
@@ -539,8 +539,8 @@ int datafab_transport(Scsi_Cmnd * srb, s
 			  info->sectors, info->ssize);
 
 		// build the reply
-		//
-		((u32 *) ptr)[0] = cpu_to_be32(info->sectors);
+		// we need the last sector, not the number of sectors
+		((u32 *) ptr)[0] = cpu_to_be32(info->sectors - 1);
 		((u32 *) ptr)[1] = cpu_to_be32(info->ssize);
 		usb_stor_set_xfer_buf(ptr, 8, srb);
 
diff -uprN -X /linux/dontdiff a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	2004-03-28 17:11:50.000000000 +0200
+++ b/drivers/usb/storage/unusual_devs.h	2004-03-29 23:59:47.000000000 +0200
@@ -710,6 +710,21 @@ UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x
 		0 ),
 #endif
 
+#ifdef CONFIG_USB_STORAGE_DATAFAB
+UNUSUAL_DEV( 0x0c0b, 0xa109, 0x0000, 0xffff,
+	       "Acomdata",
+	       "CF",
+	       US_SC_SCSI, US_PR_DATAFAB, NULL,
+	       US_FL_SINGLE_LUN ),
+#endif
+#ifdef CONFIG_USB_STORAGE_SDDR55
+UNUSUAL_DEV( 0x0c0b, 0xa109, 0x0000, 0xffff,
+	       "Acomdata",
+	       "SM",
+	       US_SC_SCSI, US_PR_SDDR55, NULL,
+	       US_FL_SINGLE_LUN ),
+#endif
+
 /* Submitted by Joris Struyve <joris@struyve.be> */
 UNUSUAL_DEV( 0x0d96, 0x410a, 0x0001, 0xffff,
 		"Medion",

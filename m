Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286949AbRL1Rta>; Fri, 28 Dec 2001 12:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286953AbRL1RtM>; Fri, 28 Dec 2001 12:49:12 -0500
Received: from haybaler.sackheads.org ([205.158.174.201]:35844 "HELO
	haybaler.sackheads.org") by vger.kernel.org with SMTP
	id <S286949AbRL1Rsf>; Fri, 28 Dec 2001 12:48:35 -0500
Date: Fri, 28 Dec 2001 09:49:42 -0800
From: Jimmie Mayfield <mayfield@sackheads.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Datafab and Lexar Jumpshot USB driver updates
Message-ID: <20011228094942.A10068@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes against 2.4.17:
  - Updates to Configure.help for these 2 drivers
  - I re-added the "EXPERIMENTAL" tag for these 2 drivers due to their nature
  - Added an entry for a109-based readers
  - Now handles media change events (thanks Joerg Schneider)



diff -Naur linux-orig/Documentation/Configure.help linux-2.4.17/Documentation/Configure.help
--- linux-orig/Documentation/Configure.help	Fri Dec 28 11:57:47 2001
+++ linux-2.4.17/Documentation/Configure.help	Fri Dec 28 11:51:54 2001
@@ -22628,12 +22628,21 @@
   Please note that the driver is still experimental.  And of course,
   you will need both USB and IrDA support in your kernel...
 
-Datafab MDCFE-B Compact Flash Reader support
+Datafab/OnSpec Compact Flash Reader support
 CONFIG_USB_STORAGE_DATAFAB
-  This option enables a sub-driver of the USB Mass Storage driver.  These
-  sub-drivers are considered experimental, and should only be used by very
-  brave people.  System crashes and other bad things are likely to occur if
-  you use this driver.  If in doubt, select N.
+  Say Y here to include additional code to support various CompactFlash
+  readers based on Datafab/OnSpec chipsets.  SmartMedia readers based
+  on these chipsets are generally unsupported -- the exception being 
+  those based on the 07c4:a006 chipset which do appear to work.
+
+  Please note that this sub-driver doesn't work for ALL Datafab/OnSpec
+  based CompactFlash readers.  Notably, it will not work with readers
+  using the newer b000 chipset and some a109-based readers also appear
+  to be non-functional.
+
+  Please be aware that this sub-driver is considered EXPERIMENTAL and can
+  result in a kernel crash (or worse!) if things go awry.  Don't use it for
+  mission-critical work.  If in doubt, select N.
 
 HP CD-Writer 82xx support
 CONFIG_USB_STORAGE_HP8200e
@@ -22644,10 +22653,10 @@
 
 Lexar Jumpshot Compact Flash Reader
 CONFIG_USB_STORAGE_JUMPSHOT       
-  This option enables a sub-driver of the USB Mass Storage driver.  These
-  sub-drivers are considered experimental, and should only be used by very
-  brave people.  System crashes and other bad things are likely to occur if
-  you use this driver.  If in doubt, select N.
+  Say Y here to include support for the Lexar Jumpshot CompactFlash
+  reader.  Please be aware that this is considered EXPERIMENTAL and can
+  result in a kernel crash (or worse!) if things go awry.  Don't use it
+  for mission-critical work.  If in doubt, select N.
 
 Winbond W83977AF IrDA Device Driver
 CONFIG_WINBOND_FIR
diff -Naur linux-orig/drivers/usb/Config.in linux-2.4.17/drivers/usb/Config.in
--- linux-orig/drivers/usb/Config.in	Fri Nov  2 20:18:58 2001
+++ linux-2.4.17/drivers/usb/Config.in	Fri Dec 28 10:57:16 2001
@@ -34,13 +34,13 @@
 dep_tristate '  USB Bluetooth support (EXPERIMENTAL)' CONFIG_USB_BLUETOOTH $CONFIG_USB $CONFIG_EXPERIMENTAL
 dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
    dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
-   dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+   dep_mbool '    Datafab CompactFlash Reader support (EXPERIMENTAL)' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
    dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
    dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
    dep_mbool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
    dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
    dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-   dep_mbool '    Lexar Jumpshot Compact Flash Reader' CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+   dep_mbool '    Lexar Jumpshot CompactFlash Reader (EXPERIMENTAL)' CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
 dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
 dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
 
diff -Naur linux-orig/drivers/usb/storage/datafab.c linux-2.4.17/drivers/usb/storage/datafab.c
--- linux-orig/drivers/usb/storage/datafab.c	Tue Oct  9 18:15:02 2001
+++ linux-2.4.17/drivers/usb/storage/datafab.c	Fri Dec 28 10:20:01 2001
@@ -10,6 +10,7 @@
  *   which I used as a template for this driver.
  *   Some bugfixes and scatter-gather code by Gregory P. Smith 
  *   (greg-usb@electricrain.com)
+ *   Fix for media change by Joerg Schneider (js@joergschneider.com)
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -801,6 +802,23 @@
 		return USB_STOR_TRANSPORT_GOOD;
 	}
 
+	if (srb->cmnd[0] == START_STOP) {
+		/* this is used by sd.c'check_scsidisk_media_change to detect
+		   media change */
+		US_DEBUGP("datafab_transport:  START_STOP.\n");
+		/* the first datafab_id_device after a media change returns
+		   an error (determined experimentally) */
+		rc = datafab_id_device(us, info);
+		if (rc == USB_STOR_TRANSPORT_GOOD) {
+		  info->sense_key = NO_SENSE;
+		  srb->result = SUCCESS;
+		} else {
+		  info->sense_key = UNIT_ATTENTION;
+		  srb->result = CHECK_CONDITION;
+		}
+		return rc;
+	}
+
 	US_DEBUGP("datafab_transport:  Gah! Unknown command: %d (0x%x)\n", srb->cmnd[0], srb->cmnd[0]);
 	return USB_STOR_TRANSPORT_ERROR;
 }
diff -Naur linux-orig/drivers/usb/storage/jumpshot.c linux-2.4.17/drivers/usb/storage/jumpshot.c
--- linux-orig/drivers/usb/storage/jumpshot.c	Fri Sep 14 17:04:07 2001
+++ linux-2.4.17/drivers/usb/storage/jumpshot.c	Fri Dec 28 10:21:37 2001
@@ -10,6 +10,7 @@
  *   which I used as a template for this driver.
  *   Some bugfixes and scatter-gather code by Gregory P. Smith 
  *   (greg-usb@electricrain.com)
+ *   Fix for media change by Joerg Schneider (js@joergschneider.com)
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -799,6 +800,23 @@
 		return USB_STOR_TRANSPORT_GOOD;
 	}
 
+	if (srb->cmnd[0] == START_STOP) {
+		// this is used by sd.c'check_scsidisk_media_change to detect
+		//  media change 
+		US_DEBUGP("jumpshot_transport:  START_STOP.\n");
+		rc = jumpshot_id_device(us, info);
+		if (rc == USB_STOR_TRANSPORT_GOOD) {
+		  info->sense_key = NO_SENSE;
+		  srb->result = SUCCESS;
+		} else {
+		  info->sense_key = UNIT_ATTENTION;
+		  srb->result = CHECK_CONDITION;
+		}
+		return rc;
+	}
+
+
+
 	US_DEBUGP("jumpshot_transport:  Gah! Unknown command: %d (0x%x)\n", srb->cmnd[0], srb->cmnd[0]);
 	return USB_STOR_TRANSPORT_ERROR;
 }
diff -Naur linux-orig/drivers/usb/storage/unusual_devs.h linux-2.4.17/drivers/usb/storage/unusual_devs.h
--- linux-orig/drivers/usb/storage/unusual_devs.h	Thu Nov 22 14:49:34 2001
+++ linux-2.4.17/drivers/usb/storage/unusual_devs.h	Fri Dec 28 12:05:50 2001
@@ -248,7 +248,7 @@
 		"Lexar",
 		"Jumpshot USB CF Reader",
 		US_SC_SCSI, US_PR_JUMPSHOT, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
 #endif
 
 UNUSUAL_DEV(  0x0644, 0x0000, 0x0100, 0x0100, 
@@ -332,7 +332,7 @@
 		"Datafab",
 		"MDCFE-B USB CF Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
 
 	/*
 	 * The following Datafab-based devices may or may not work
@@ -349,31 +349,38 @@
 		"SIIG/Datafab",
 		"SIIG/Datafab Memory Stick+CF Reader/Writer",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
 
 UNUSUAL_DEV( 0x07c4, 0xa003, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"Datafab-based Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
 
 UNUSUAL_DEV( 0x07c4, 0xa004, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"Datafab-based Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
 
 UNUSUAL_DEV( 0x07c4, 0xa005, 0x0000, 0xffff,
 		"PNY/Datafab",
 		"PNY/Datafab CF+SM Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
 
 UNUSUAL_DEV( 0x07c4, 0xa006, 0x0000, 0xffff,
 		"Simple Tech/Datafab",
 		"Simple Tech/Datafab CF+SM Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE | US_FL_START_STOP ),
+		US_FL_MODE_XLATE ),
+
+UNUSUAL_DEV( 0x07c4, 0xa109, 0x0000, 0xffff,
+		"Datafab/OnSpec Chipset: 0xa109",
+		"Datafab/OnSpec Chipset: 0xa109",
+		US_SC_SCSI, US_PR_DATAFAB, NULL,
+		US_FL_MODE_XLATE ),
+
 #endif
 
 /* Casio QV 2x00/3x00/8000 digital still cameras are not conformant

-- 
Jimmie Mayfield  
http://www.sackheads.org/mayfield       email: mayfield+usenet@sackheads.org
My mail provider does not welcome UCE -- http://www.sackheads.org/uce


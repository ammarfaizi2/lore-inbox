Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSFYVpP>; Tue, 25 Jun 2002 17:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSFYVpP>; Tue, 25 Jun 2002 17:45:15 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:5896 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S315928AbSFYVpO>; Tue, 25 Jun 2002 17:45:14 -0400
Subject: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
To: marcelo@conectiva.com.br
Date: Tue, 25 Jun 2002 23:44:51 +0200 (CEST)
CC: mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17My7H-0007Ew-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider the small patch below (for 2.4.19-rc1), adding support
for the Sagatek DCS-CF (aka Datafab KECF-USB - 07c4:a400) USB-CompactFlash
apdapter.  Tested a little by copying files back and forth - transfer
speed is about 600 KB/s, and it hasn't crashed on me yet.  I understand
it is a bit late before 2.4.19, but the device does not work at all
without the patch, and the patch does not change anything for other
vendor:device IDs, so there should be no risk of breaking things...

The new "limit INQUIRY to 36 bytes" flag might help other devices too
(instead of just not sending INQUIRY at all) if someone wants to try.
I just wanted to see what the device has to say - here are the kernel
messages with a 64 MB (really 61 MiB) CompactFlash card inserted:

hub.c: USB new device connect on bus1/1, assigned device number 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0.01
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 125441 512-byte hdwr sectors (64 MB)
usb-storage: Command will be truncated to fit in SENSE6 buffer.
sda: Write Protect is off
 sda: sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2

The device I have was bought as "Sagatek DCS-CF".
I asked info@sagatek.com.tw for Linux support - they said it doesn't
work, but they may "consider supporting Linux in the near future".
I guess they mean "consider fixing the firmware in the near future" :)

Then I found this - http://martin.wilck.bei.t-online.de/
(the patch available there is a bit more complicated - my patch only
limits INQUIRY length to 36 bytes for one device, not all of them).

The device is called Datafab KECF-USB there, but the vendor and product
ID is the same; to add more confusion, my usb.ids file says that 07c4 is
"Simple Technologies, Inc." - who is the real manufacturer then? :)

Thanks,
Marek

--- linux/drivers/usb/storage/protocol.c.orig	Tue Jun 25 15:38:23 2002
+++ linux/drivers/usb/storage/protocol.c	Tue Jun 25 21:26:11 2002
@@ -283,6 +283,14 @@
 {
 	int old_cmnd = 0;
 
+	/*
+	 * Workaround for some devices - limit INQUIRY to 36 bytes.
+	 */
+	if ((us->flags & US_FL_INQUIRY_36)
+	    && srb->cmnd[0] == INQUIRY
+	    && srb->cmnd[4] > 36)
+		srb->cmnd[4] = 36;
+
 	/* This code supports devices which do not support {READ|WRITE}_6
 	 * Apparently, neither Windows or MacOS will use these commands,
 	 * so some devices do not support them
--- linux/drivers/usb/storage/unusual_devs.h.orig	Tue Jun 25 15:38:23 2002
+++ linux/drivers/usb/storage/unusual_devs.h	Tue Jun 25 22:12:05 2002
@@ -461,6 +461,13 @@
 		US_FL_MODE_XLATE ),
 #endif
 
+/* aka Sagatek DCS-CF (same vendor and product id) */
+UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
+		"Datafab",
+		"KECF-USB",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_MODE_XLATE | US_FL_START_STOP | US_FL_INQUIRY_36 ),
+
 /* Casio QV 2x00/3x00/4000/8000 digital still cameras are not conformant
  * to the USB storage specification in two ways:
  * - They tell us they are using transport protocol CBI. In reality they
--- linux/drivers/usb/storage/usb.h.orig	Thu Nov 22 20:49:34 2001
+++ linux/drivers/usb/storage/usb.h	Tue Jun 25 22:12:01 2002
@@ -101,6 +101,7 @@
 #define US_FL_IGNORE_SER      0x00000010 /* Ignore the serial number given  */
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs fixing */
+#define US_FL_INQUIRY_36      0x00000080 /* Limit INQUIRY to 36 bytes */
 
 #define USB_STOR_STRING_LEN 32
 



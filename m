Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUHNSXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUHNSXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHNSXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:23:47 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:37588 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S264443AbUHNSXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:23:11 -0400
Message-ID: <411E585C.7010400@ttnet.net.tr>
Date: Sat, 14 Aug 2004 21:22:20 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com, mdharm-usb@one-eyed-alien.net
Subject: [PATCH 2.4] blacklist a device in usb-storage
Content-Type: multipart/mixed;
	boundary="------------070602090500010407070102"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602090500010407070102
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

The disk in question is VID/PID=0b86:5110 32mb JMTek/eXputer disk.
http://www.qbik.ch/usb/devices/showdev.php?id=1092 says it can
never be supported through usb-storage because it claims to be
usb storage compliant but is not.

I accidentally plugged this beast not remembering what a royal PITA
it is; here's the output from dmesg:

USB Mass Storage support registered.
sr0: mmc-3 profile: 0h
sr0: mmc-3 profile: 0h
usb.c: deregistering driver usb-storage
usb.c: USB disconnect on device 00:0e.1-2 address 9
sr0: mmc-3 profile: 0h
sr0: mmc-3 profile: 0h
hub.c: new USB device 00:0e.1-2, assigned address 10
usb.c: USB device 10 (vend/prod 0xb86/0x5110) is not claimed by any 
active driver.
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
usb.c: USB disconnect on device 00:0e.1-2 address 10
sr0: mmc-3 profile: 0h
sr0: mmc-3 profile: 0h
usb-uhci.c: interrupt, status 3, frame# 999
hub.c: new USB device 00:0e.1-2, assigned address 11
scsi: device set offline - not ready or command retry failed after bus 
reset: host 1 channel 0 id 0 lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 10
USB Mass Storage support registered.
scsi2 : SCSI emulation for USB Mass Storage devices
sr0: mmc-3 profile: 0h
sr0: mmc-3 profile: 0h
usb-uhci.c: interrupt, status 3, frame# 1912
usb-uhci.c: interrupt, status 3, frame# 775
usb-uhci.c: interrupt, status 3, frame# 1689
usb-uhci.c: interrupt, status 3, frame# 555
usb-uhci.c: interrupt, status 3, frame# 1470
usb-uhci.c: interrupt, status 3, frame# 335
usb-uhci.c: interrupt, status 3, frame# 1248
usb-uhci.c: interrupt, status 3, frame# 115
usb-uhci.c: interrupt, status 3, frame# 1029
usb-uhci.c: interrupt, status 3, frame# 1941

Unplug the device and try /sbin/rmmod usb-sotrage == panic ;(
So I decided to find a way of blacklisting this disk (and
maybe similar others).  Please review the attached patch.

If there's any other way of preventing usb-storage to take-
over this disk, then tell me and despise my ignorance,
Otherwise, Marcelo please apply ;)

Ozkan Sezer


--------------070602090500010407070102
Content-Type: text/plain;
	name="27_blacklist_usb-storage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="27_blacklist_usb-storage.diff"


--- 27/drivers/usb/storage/unusual_devs.h~	2004-08-08 02:26:05.000000000 +0300
+++ 27/drivers/usb/storage/unusual_devs.h	2004-08-14 20:57:36.000000000 +0300
@@ -708,7 +708,14 @@
                 "Optio S/S4",
                 US_SC_DEVICE, US_PR_DEVICE, NULL,
                 US_FL_FIX_INQUIRY ),
-		
+
+/* eXputer  Model: Zippy Drive, lies about being USB mass storage compliant.
+   Ref.: http://www.qbik.ch/usb/devices/showdev.php?id=1092 */
+UNUSUAL_DEV(  0x0b86, 0x5110, 0x0000, 0xffff,
+		"eXputer",
+		"Zippy Drive 5000",
+		0, 0, NULL, US_BLACKLISTED_DEV ),
+
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x0110,
 		"ATI",
--- 27/drivers/usb/storage/usb.h~	2004-08-08 02:26:05.000000000 +0300
+++ 27/drivers/usb/storage/usb.h	2004-08-14 20:58:33.000000000 +0300
@@ -103,6 +103,7 @@
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs fixing */
 #define US_FL_FIX_CAPACITY    0x00000080 /* READ_CAPACITY response too big */
+#define US_BLACKLISTED_DEV    0x00000200 /* Device blacklisted */
 
 #define USB_STOR_STRING_LEN 32
 
--- 27/drivers/usb/storage/usb.c~	2004-08-08 02:26:05.000000000 +0300
+++ 27/drivers/usb/storage/usb.c	2004-08-14 20:57:36.000000000 +0300
@@ -595,6 +595,14 @@
 	if (id_index <
 	    sizeof(us_unusual_dev_list) / sizeof(us_unusual_dev_list[0])) {
 		unusual_dev = &us_unusual_dev_list[id_index];
+		/* Is this thing blacklisted? */
+		if (unusual_dev->flags & US_BLACKLISTED_DEV) {
+			warn("Device (vend/prod 0x%x/0x%x) is Blacklisted and not supported by usb-storage.\n",
+				dev->descriptor.idVendor,
+				dev->descriptor.idProduct);
+			return NULL;
+		}
+
 		if (unusual_dev->vendorName)
 			US_DEBUGP("Vendor: %s\n", unusual_dev->vendorName);
 		if (unusual_dev->productName)




--------------070602090500010407070102--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286338AbSAGUVE>; Mon, 7 Jan 2002 15:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286310AbSAGUUm>; Mon, 7 Jan 2002 15:20:42 -0500
Received: from aef.wh.Uni-Dortmund.DE ([129.217.129.132]:15603 "EHLO
	ReneEngelhard.local") by vger.kernel.org with ESMTP
	id <S286262AbSAGUUa>; Mon, 7 Jan 2002 15:20:30 -0500
Date: Mon, 7 Jan 2002 21:17:57 +0100
From: Rene Engelhard <mail@rene-engelhard.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
Message-ID: <20020107211757.A4196@rene-engelhard.de>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key: http://www.rene-engelhard.de/gnupg/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg, hi Kernel-Hackers,

a long time ago I bought the Adapter mentioned above and got it
working.

Now, 6 months after that I bought it, my testing is over and I got the
result: The device is working by changing the usb-storage sources; this
has not affected any other thing. All my devices (3 of USB) runs perfectly.

So I send you this patch.

It's against 2.5.2-pre9 and the patch from Alan with the comment that
you need SCSI Support is applied in my tree, so this is needed before
applying this patch (but I saw you did it Greg, you can do this)

Because of testing this patch 6 months, I do not consider to say that
this patch is experimental, so I did not write $CONFIG_EXPERIMENTAL at
the end of the dep_mbool statement.

I have attached it to this mail.

Rene

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Description: Patch for USB-IDE bridge from ScanLogic
Content-Disposition: attachment; filename="scanlogic-patch-0.99"

diff -urN linux/Documentation/Configure.help linux.new/Documentation/Configure.help
--- linux/Documentation/Configure.help	Mon Jan  7 19:29:56 2002
+++ linux.new/Documentation/Configure.help	Mon Jan  7 19:20:24 2002
@@ -13492,6 +13492,16 @@
   Support for the Freecom USB to IDE/ATAPI adaptor.
   Freecom has a web page at <http://www.freecom.de/>.
 
+ScanLogic USB-ATAPI Bridge support
+CONFIG_USB_STORAGE_SCANLOGIC
+  Support for the ScanLogic USB to IDE/ATAPI adapter.
+  For german people: This is the adapter shipped from ATELCO.
+  For details, see
+  http://plichta.cs.uni-dortmund.de/~rene/linux/kernel/patches/scanlogic/
+  and http://www.qbik.ch/usb/devices/showdev.php?id=491
+  
+  Say Y here if you have this device, otherwise say N.
+
 Microtech CompactFlash/SmartMedia reader
 CONFIG_USB_STORAGE_DPCM
   Say Y here to support the Microtech ZiO! CompactFlash/SmartMedia
diff -urN linux/drivers/usb/Config.in linux.new/drivers/usb/Config.in
--- linux/drivers/usb/Config.in	Mon Jan  7 21:05:10 2002
+++ linux.new/drivers/usb/Config.in	Mon Jan  7 20:40:32 2002
@@ -38,6 +38,7 @@
 else
 dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
    dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
+   dep_mbool '    ScanLogic USB/ATAPI bridge' CONFIG_USB_STORAGE_SCANLOGIC $CONFIG_USB_STORAGE
    dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
    dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
    dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
diff -urN linux/drivers/usb/storage/transport.c linux.new/drivers/usb/storage/transport.c
--- linux/drivers/usb/storage/transport.c	Mon Jan  7 19:29:58 2002
+++ linux.new/drivers/usb/storage/transport.c	Mon Jan  7 20:39:30 2002
@@ -1157,7 +1157,12 @@
 		  le32_to_cpu(bcs.Signature), bcs.Tag, 
 		  bcs.Residue, bcs.Status);
 	if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) || 
+#ifndef CONFIG_USB_STORAGE_SCANLOGIC
+            /* This device has a bug how it communicates via USB,
+	     * if the following line is not included, the the device
+	     * runs */
 	    bcs.Tag != bcb.Tag || 
+#endif	    
 	    bcs.Status > US_BULK_STAT_PHASE || partial != 13) {
 		US_DEBUGP("Bulk logical error\n");
 		return USB_STOR_TRANSPORT_ERROR;
diff -urN linux/drivers/usb/storage/unusual_devs.h linux.new/drivers/usb/storage/unusual_devs.h
--- linux/drivers/usb/storage/unusual_devs.h	Mon Jan  7 19:29:58 2002
+++ linux.new/drivers/usb/storage/unusual_devs.h	Mon Jan  7 21:11:19 2002
@@ -37,6 +37,13 @@
  * then by ProductID.
  */
 
+#ifdef CONFIG_USB_STORAGE_SCANLOGIC
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0000, 0x0200,
+		"ScanLogic Corp.",
+		"USB to IDE",
+		US_SC_8020, US_PR_BULK, NULL, 0),
+
+#endif
 UNUSUAL_DEV(  0x03ee, 0x0000, 0x0000, 0x0245, 
 		"Mitsumi",
 		"CD-R/RW Drive",

--J2SCkAp4GZ/dPZZf--

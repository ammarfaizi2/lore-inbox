Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267895AbTBEKK7>; Wed, 5 Feb 2003 05:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267896AbTBEKK7>; Wed, 5 Feb 2003 05:10:59 -0500
Received: from wg.pu.ru ([193.124.85.219]:14341 "EHLO wg.pu.ru")
	by vger.kernel.org with ESMTP id <S267895AbTBEKK6>;
	Wed, 5 Feb 2003 05:10:58 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "George A. Nikandrov" <gogan@pochtamt.ru>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4.20] - USB Storage and Olympus Cameras
Date: Wed, 5 Feb 2003 13:29:23 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302051329.23978.gogan@pochtamt.ru>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following is a patch to make some buggy Olympus cameras (such as C-1)
to work with Linux. It is based by information I've found from debugging
output of usb-storage module. Please test, even if you don't have
an Olympus, and report any bugs.


---8<---| Cut here |---8<---
diff -urN linux-2.4.20.orig/drivers/usb/Config.in linux-2.4.20/drivers/usb/Config.in
--- linux-2.4.20.orig/drivers/usb/Config.in     2003-01-29 11:23:10.000000000 +0300
+++ linux-2.4.20/drivers/usb/Config.in  2003-01-29 11:25:48.000000000 +0300
@@ -39,6 +39,7 @@
    fi
    dep_tristate '  USB Mass Storage support' CONFIG_USB_STORAGE $CONFIG_USB $CONFIG_SCSI
       dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
+      dep_mbool '    Olympus Cameras support (EXPERIMENTAL)' CONFIG_USB_STORAGE_USBU $CONFIG_USB_STORAGE
       dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
       dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
diff -urN linux-2.4.20.orig/drivers/usb/storage/transport.c linux-2.4.20/drivers/usb/storage/transport.c
--- linux-2.4.20.orig/drivers/usb/storage/transport.c   2003-01-29 11:23:10.000000000 +0300
+++ linux-2.4.20/drivers/usb/storage/transport.c        2003-01-29 11:31:08.000000000 +0300
@@ -1233,8 +1233,13 @@
        US_DEBUGP("Bulk status Sig 0x%x T 0x%x R %d Stat 0x%x\n",
                  le32_to_cpu(bcs->Signature), bcs->Tag, 
                  bcs->Residue, bcs->Status);
-       if (bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) || 
-           bcs->Tag != bcb->Tag || 
+       if (bcs->Tag != bcb->Tag ||
+#ifdef CONFIG_USB_STORAGE_USBU
+           ( bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) &&
+             bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN_USBU) ) || 
+#else
+           bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) || 
+#endif
            bcs->Status > US_BULK_STAT_PHASE || partial != 13) {
                US_DEBUGP("Bulk logical error\n");
                ret = USB_STOR_TRANSPORT_ERROR;
diff -urN linux-2.4.20.orig/drivers/usb/storage/transport.h linux-2.4.20/drivers/usb/storage/transport.h
--- linux-2.4.20.orig/drivers/usb/storage/transport.h   2003-01-29 11:23:10.000000000 +0300
+++ linux-2.4.20/drivers/usb/storage/transport.h        2003-01-29 11:30:21.000000000 +0300
@@ -106,6 +106,11 @@
 
 #define US_BULK_CS_WRAP_LEN    13
 #define US_BULK_CS_SIGN                0x53425355      /* spells out 'USBS' */
+
+#ifdef CONFIG_USB_STORAGE_USBU
+#define US_BULK_CS_SIGN_USBU   0x55425355      /* spells out 'USBU' */
+#endif
+
 #define US_BULK_STAT_OK                0
 #define US_BULK_STAT_FAIL      1
 #define US_BULK_STAT_PHASE     2
---8<---| Cut here |---8<---

That's all. Thank you

-- 
--------<==========[ George A. Nikandrov ]=========>--------
mailto:   gogan@pochtamt.ru        www:      n/a (not yet ;)
ICQ#:     22817226                 Jabber:   gogan@jabber.ru
------------------------------------------------------------


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUAYFEh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 00:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAYFEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 00:04:37 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:7554 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S263584AbUAYFEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 00:04:36 -0500
To: mdharm-usb@one-eyed-alien.net
Subject: [PATCH 2.6.2-rc1-mm3] drivers/usb/storage/dpcm.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <20040125050342.45C3E13A354@mrhankey.megahappy.net>
Date: Sat, 24 Jan 2004 21:03:42 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In function dpcm_transport the compiler complains about ret not being used:
drivers/usb/storage/dpcm.c: In function `dpcm_transport':
drivers/usb/storage/dpcm.c:46: warning: unused variable `ret'

ret is not used if CONFIG_USB_STORAGE_SDDR09 is not set. Instead of adding
more ifdef's to the code this patch puts ret to use for the other 2 cases in
the switch statement (case 0 and default).

--- drivers/usb/storage/dpcm.c.orig     2004-01-24 20:51:40.631038904 -0800
+++ drivers/usb/storage/dpcm.c  2004-01-24 20:50:05.155553384 -0800
@@ -56,7 +56,8 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
     /*
      * LUN 0 corresponds to the CompactFlash card reader.
      */
-    return usb_stor_CB_transport(srb, us);
+    ret = usb_stor_CB_transport(srb, us);
+    break;
  
 #ifdef CONFIG_USB_STORAGE_SDDR09
   case 1:
@@ -72,11 +73,12 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
     ret = sddr09_transport(srb, us);
     srb->device->lun = 1; us->srb->device->lun = 1;
  
-    return ret;
+    break;
 #endif
  
   default:
     US_DEBUGP("dpcm_transport: Invalid LUN %d\n", srb->device->lun);
-    return USB_STOR_TRANSPORT_ERROR;
+    ret = USB_STOR_TRANSPORT_ERROR;
   }
+  return ret;
 }

--
Bryan Whitehead
driver@megahappy.net

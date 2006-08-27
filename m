Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWH0X6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWH0X6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWH0X6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:58:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:12784 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932307AbWH0X6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Hollis <dhollis@davehollis.com>
Subject: [PATCH] mcs7830: clean up use of kernel constants
Date: Sun, 27 Aug 2006 22:41:04 +0200
User-Agent: KMail/1.9.1
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608071811.09978.arnd.bergmann@de.ibm.com> <200608202207.39709.arnd@arndb.de>
In-Reply-To: <200608202207.39709.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272241.05026.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This use the MII register constants provided
by the kernel instead of hardcoding numerical
values in the driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Index: linux-cg/drivers/usb/net/mcs7830.c
===================================================================
--- linux-cg.orig/drivers/usb/net/mcs7830.c	2006-08-25 21:17:24.000000000 +0200
+++ linux-cg/drivers/usb/net/mcs7830.c	2006-08-25 21:23:35.000000000 +0200
@@ -35,8 +35,10 @@
 #include "usbnet.h"
 
 /* requests */
-#define MCS7830_RD_BMREQ	(USB_DIR_IN  | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
-#define MCS7830_WR_BMREQ	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define MCS7830_RD_BMREQ	(USB_DIR_IN  | USB_TYPE_VENDOR | \
+				 USB_RECIP_DEVICE)
+#define MCS7830_WR_BMREQ	(USB_DIR_OUT | USB_TYPE_VENDOR | \
+				 USB_RECIP_DEVICE)
 #define MCS7830_RD_BREQ		0x0E
 #define MCS7830_WR_BREQ		0x0D
 
@@ -46,6 +48,10 @@
 #define MCS7830_VENDOR_ID	0x9710
 #define MCS7830_PRODUCT_ID	0x7830
 
+#define MCS7830_MII_ADVERTISE	(ADVERTISE_PAUSE_CAP | ADVERTISE_100FULL | \
+				 ADVERTISE_100HALF | ADVERTISE_10FULL | \
+				 ADVERTISE_10HALF | ADVERTISE_CSMA)
+
 /* HIF_REG_XX coressponding index value */
 enum {
 	HIF_REG_MULTICAST_HASH			= 0x00,
@@ -258,16 +264,18 @@
 {
 	int ret;
 	/* Enable all media types */
-	ret = mcs7830_write_phy(dev, MII_ADVERTISE, 0x05e1);
-	/* First Disable All */
+	ret = mcs7830_write_phy(dev, MII_ADVERTISE, MCS7830_MII_ADVERTISE);
+
+	/* First reset BMCR */
 	if (!ret)
 		ret = mcs7830_write_phy(dev, MII_BMCR, 0x0000);
 	/* Enable Auto Neg */
 	if (!ret)
-		ret = mcs7830_write_phy(dev, MII_BMCR, 0x1000);
+		ret = mcs7830_write_phy(dev, MII_BMCR, BMCR_ANENABLE);
 	/* Restart Auto Neg (Keep the Enable Auto Neg Bit Set) */
 	if (!ret)
-		ret = mcs7830_write_phy(dev, MII_BMCR, 0x1200);
+		ret = mcs7830_write_phy(dev, MII_BMCR,
+				BMCR_ANENABLE | BMCR_ANRESTART	);
 	return ret < 0 ? : 0;
 }
 


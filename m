Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWGHNEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWGHNEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWGHNEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:04:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:33664 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964815AbWGHNET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:04:19 -0400
X-Authenticated: #2769515
Date: Sat, 8 Jul 2006 15:09:38 +0200
From: Martin Langer <martin-langer@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: bcm43xx-dev@lists.berlios.de
Subject: [RFC][PATCH 2/2] firmware version management: bcm43xx example
Message-ID: <20060708130938.GA3854@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Public-Key-URL: http://www.langerland.de/martin/martinlanger.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an example for using firmware version detection in the bcm43xx 
driver. It's not a complete list of firmware blobs. More than 50 entries 
are still missing in the tables, but it should be enough to get an 
impresion of the idea.


--- ../linux-2.6.18rc1/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-07-07 13:41:10.000000000 +0200
+++ drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-07-08 13:30:30.000000000 +0200
@@ -150,6 +150,22 @@
 };
 MODULE_DEVICE_TABLE(pci, bcm43xx_pci_tbl);
 
+static struct firmware_files ucode_version_tbl[] = {
+	{ { 0xed, 0x55, 0x26, 0xf9, 0x2e, 0xcb, 0x8f, 0x76, 0x90, 0x34, 0xa0, 
+	    0xf1, 0x67, 0x33, 0x00, 0x5f }, BCM43xx_FW_VER(3, 130, 20, 0) },
+	{ { 0x65, 0x1e, 0x4f, 0xc1, 0x92, 0xb6, 0xae, 0x16, 0xb2, 0xf6, 0x39,
+	    0x56, 0xc5, 0x66, 0x8d, 0xbd }, BCM43xx_FW_VER(4, 10, 40, 0) },
+	{},
+};
+
+static struct firmware_files pcm_version_tbl[] = {
+	{ { 0x2d, 0x0f, 0xd4, 0x02, 0x88, 0x9d, 0xf1, 0xd1, 0xf6, 0xb3, 0xdd,
+	    0x8b, 0x4d, 0x37, 0xcc, 0x9a }, BCM43xx_FW_VER(3, 30, 15, 0) },
+	{ { 0xff, 0x29, 0xcd, 0x07, 0x56, 0x75, 0xa5, 0x44, 0xbd, 0xc5, 0xd5,
+	    0xae, 0x95, 0x3d, 0x96, 0x4a }, BCM43xx_FW_VER(3, 90, 7, 0) },
+	{},
+};
+
 static void bcm43xx_ram_write(struct bcm43xx_private *bcm, u16 offset, u32 val)
 {
 	u32 status;
@@ -1946,6 +1962,7 @@
 {
 	struct bcm43xx_phyinfo *phy = bcm43xx_current_phy(bcm);
 	u8 rev = bcm->current_core->rev;
+	u32 ver;
 	int err = 0;
 	int nr;
 	char buf[22 + sizeof(modparam_fwpostfix) - 1] = { 0 };
@@ -1961,6 +1978,14 @@
 			        buf);
 			goto error;
 		}
+
+		ver = firmware_version(bcm->ucode, ucode_version_tbl);
+		if (ver != 0) {
+			printk(KERN_INFO PFX "FW: %s version %i.%i.%i.%i\n",
+			       buf, BCM43xx_PRINT_FW_VER(ver));
+		} else
+			printk(KERN_INFO PFX "FW: %s detection failure.\n", 
+			       buf);
 	}
 
 	if (!bcm->pcm) {
@@ -1975,6 +2000,14 @@
 			       buf);
 			goto error;
 		}
+
+		ver = firmware_version(bcm->pcm, pcm_version_tbl);
+		if (ver != 0) {
+			printk(KERN_INFO PFX "FW: %s version %i.%i.%i.%i\n",
+			       buf, BCM43xx_PRINT_FW_VER(ver));
+		} else
+			printk(KERN_INFO PFX "FW: %s detection failure.\n", 
+			       buf);
 	}
 
 	if (!bcm->initvals0) {
--- ../linux-2.6.18rc1/drivers/net/wireless/bcm43xx/bcm43xx.h	2006-07-07 13:41:10.000000000 +0200
+++ drivers/net/wireless/bcm43xx/bcm43xx.h	2006-07-08 13:30:45.000000000 +0200
@@ -973,4 +973,8 @@
 				((u8*)(x))[2], ((u8*)(x))[3], \
 				((u8*)(x))[4], ((u8*)(x))[5]
 
+/** Helpers to encode/decode firmware version */ 
+#define BCM43xx_FW_VER(a, b, c, d) (((a)<<24) | ((b)<<16) | ((c)<<8) | (d))
+#define BCM43xx_PRINT_FW_VER(u) (u>>24), (u>>16)&0xff, (u>>8)&0xff, (u)&0xff
+
 #endif /* BCM43xx_H_ */

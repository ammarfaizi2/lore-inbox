Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVCVF2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVCVF2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVCVCMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:12:14 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:2443 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262321AbVCVBfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:03 -0500
Message-Id: <20050322013455.652294000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:43 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-nova-t-usb2.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 10/48] dibusb: support Hauppauge WinTV NOVA-T USB2
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o added support for Hauppauge WinTV NOVA-T USB2 (clone of MOD3000P by DiBcom)
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/README.dibusb            |    8 ++++++--
 drivers/media/dvb/dibusb/dvb-dibusb-core.c |   28 +++++++++++++++++++---------
 2 files changed, 25 insertions(+), 11 deletions(-)

Index: linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/README.dibusb	2005-03-22 00:15:04.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb	2005-03-22 00:15:09.000000000 +0100
@@ -1,4 +1,4 @@
-Documentation for dib3000mb frontend driver and dibusb device driver
+Documentation for dib3000* frontend drivers and dibusb device driver
 ====================================================================
 
 Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de),
@@ -74,6 +74,9 @@ Supported devices USB2.0
 
 - Artec T1 USB TVBOX (FX2) (2)
 
+- Hauppauge WinTV NOVA-T USB2
+	http://www.hauppauge.com/
+
 - DiBcom USB2.0 DVB-T reference device (non-public)
 
 1) It is working almost.
@@ -81,10 +84,11 @@ Supported devices USB2.0
 
 
 0. NEWS:
+  2004-02-02 - added support for the Hauppauge Win-TV Nova-T USB2
   2004-01-31 - distorted streaming is finally gone for USB1.1 devices
   2004-01-13 - moved the mirrored pid_filter_table back to dvb-dibusb
              - first almost working version for HanfTek UMT-010
-             - found out, that Yakumo/HAMA/Typhoon are predessors of the HanfTek
+             - found out, that Yakumo/HAMA/Typhoon are predessors of the HanfTek UMT-010
   2004-01-10 - refactoring completed, now everything is very delightful
              - tuner quirks for some weird devices (Artec T1 AN2235 device has sometimes a
                Panasonic Tuner assembled). Tunerprobing implemented. Thanks a lot to Gunnar Wittich.
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:15:09.000000000 +0100
@@ -55,8 +55,9 @@ MODULE_PARM_DESC(rc_query_interval, "int
 #define USB_VID_DIBCOM						0x10b8
 #define USB_VID_EMPIA						0xeb1a
 #define USB_VID_GRANDTEC					0x5032
-#define USB_VID_HYPER_PALTEK				0x1025
 #define USB_VID_HANFTEK						0x15f4
+#define USB_VID_HAUPPAUGE					0x2040
+#define USB_VID_HYPER_PALTEK				0x1025
 #define USB_VID_IMC_NETWORKS				0x13d3
 #define USB_VID_TWINHAN						0x1822
 #define USB_VID_ULTIMA_ELECTRONIC			0x05d8
@@ -93,6 +94,8 @@ MODULE_PARM_DESC(rc_query_interval, "int
 #define USB_PID_HANFTEK_UMT_010_WARM		0x0025
 #define USB_PID_YAKUMO_DTT200U_COLD			0x0201
 #define USB_PID_YAKUMO_DTT200U_WARM			0x0301
+#define USB_PID_WINTV_NOVA_T_USB2_COLD		0x9300
+#define USB_PID_WINTV_NOVA_T_USB2_WARM		0x9301
 
 /* USB Driver stuff
  * table of devices that this driver is working with
@@ -143,16 +146,18 @@ static struct usb_device_id dib_table []
 /* 28 */	{ USB_DEVICE(USB_VID_HANFTEK,		USB_PID_HANFTEK_UMT_010_COLD) },
 /* 29 */	{ USB_DEVICE(USB_VID_HANFTEK,		USB_PID_HANFTEK_UMT_010_WARM) },
 
+/* 30 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,		USB_PID_WINTV_NOVA_T_USB2_COLD) },
+/* 31 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,		USB_PID_WINTV_NOVA_T_USB2_WARM) },
 /* 
  * activate the following define when you have one of the devices and want to 
  * build it from build-2.6 in dvb-kernel
  */
 // #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES 
 #ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
-/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
-/* 31 */	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
-/* 32 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
-/* 33 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_DIBCOM_ANCHOR_2135_COLD) },
+/* 32 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+/* 33 */	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
+/* 34 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
+/* 35 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_DIBCOM_ANCHOR_2135_COLD) },
 #endif
 			{ }		/* Terminating entry */
 };
@@ -287,6 +292,11 @@ static struct dibusb_usb_device dibusb_d
 		{ &dib_table[27], NULL },
 		{ NULL },
 	},
+	{	"Hauppauge WinTV NOVA-T USB2",
+		&dibusb_device_classes[DIBUSB2_0],
+		{ &dib_table[30], NULL },
+		{ &dib_table[31], NULL },
+	},
 	{	"AVermedia/Yakumo/Hama/Typhoon DVB-T USB2.0",
 		&dibusb_device_classes[UMT2_0],
 		{ &dib_table[2], NULL },
@@ -300,17 +310,17 @@ static struct dibusb_usb_device dibusb_d
 #ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
 	{	"Artec T1 USB1.1 TVBOX with AN2235 (misdesigned)",
 		&dibusb_device_classes[DIBUSB1_1_AN2235],
-		{ &dib_table[30], NULL },
+		{ &dib_table[32], NULL },
 		{ NULL },
 	},
 	{	"Artec T1 USB2.0 TVBOX with FX2 IDs (misdesigned, please report the warm ID)",
 		&dibusb_device_classes[DIBUSB2_0],
-		{ &dib_table[31], NULL },
-		{ &dib_table[32], NULL }, /* undefined, it could be that the device will get another USB ID in warm state */
+		{ &dib_table[33], NULL },
+		{ &dib_table[34], NULL }, /* undefined, it could be that the device will get another USB ID in warm state */
 	},
 	{	"DiBcom USB1.1 DVB-T reference design (MOD3000) with AN2135 default IDs",
 		&dibusb_device_classes[DIBUSB1_1],
-		{ &dib_table[33], NULL },
+		{ &dib_table[35], NULL },
 		{ NULL },
 	},
 #endif

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVCVCGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVCVCGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVCVCGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:06:12 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:22411 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262332AbVCVBfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:38 -0500
Message-Id: <20050322013456.880343000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:52 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibcom-kworld-instant-dvb-t.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 19/48] support KWorld/ADSTech Instant DVB-T USB2.0
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o added support for KWorld/ADSTech Instant DVB-T USB2.0 (DiB3000M-B)
o added deactivation option of the pid parser for the DiB3000M-B (since there
  are USB2.0 devices and which now have the ability to deliver the complete
  Transport Stream)
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/README.dibusb            |   14 +++--
 drivers/media/dvb/dibusb/Kconfig           |    3 -
 drivers/media/dvb/dibusb/dvb-dibusb-core.c |   78 +++++++++++++++++++++++------
 drivers/media/dvb/dibusb/dvb-dibusb-usb.c  |    4 +
 drivers/media/dvb/dibusb/dvb-dibusb.h      |    1 
 drivers/media/dvb/frontends/dib3000mb.c    |    5 +
 drivers/media/dvb/frontends/dib3000mc.c    |    2 
 7 files changed, 83 insertions(+), 24 deletions(-)

Index: linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/README.dibusb	2005-03-22 00:15:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb	2005-03-22 00:16:19.000000000 +0100
@@ -77,6 +77,8 @@ Supported devices USB2.0
 - Hauppauge WinTV NOVA-T USB2
 	http://www.hauppauge.com/
 
+- KWorld/ADSTech Instant DVB-T USB2.0 (DiB3000M-B)
+
 - DiBcom USB2.0 DVB-T reference device (non-public)
 
 1) It is working almost.
@@ -84,12 +86,13 @@ Supported devices USB2.0
 
 
 0. NEWS:
-  2004-02-02 - added support for the Hauppauge Win-TV Nova-T USB2
-  2004-01-31 - distorted streaming is finally gone for USB1.1 devices
-  2004-01-13 - moved the mirrored pid_filter_table back to dvb-dibusb
+  2005-02-11 - added support for the KWorld/ADSTech Instant DVB-T USB2.0. Thanks a lot to Joachim von Caron
+  2005-02-02 - added support for the Hauppauge Win-TV Nova-T USB2
+  2005-01-31 - distorted streaming is finally gone for USB1.1 devices
+  2005-01-13 - moved the mirrored pid_filter_table back to dvb-dibusb
              - first almost working version for HanfTek UMT-010
              - found out, that Yakumo/HAMA/Typhoon are predessors of the HanfTek UMT-010
-  2004-01-10 - refactoring completed, now everything is very delightful
+  2005-01-10 - refactoring completed, now everything is very delightful
              - tuner quirks for some weird devices (Artec T1 AN2235 device has sometimes a
                Panasonic Tuner assembled). Tunerprobing implemented. Thanks a lot to Gunnar Wittich.
   2004-12-29 - after several days of struggling around bug of no returning URBs fixed.
@@ -260,6 +263,9 @@ Patches, comments and suggestions are ve
 
    Bernd Wagner for helping with huge bug reports and discussions.
 
+   Gunnar Wittich and Joachim von Caron for their trust for giving me
+    root-shells on their machines to implement support for new devices.
+
    Some guys on the linux-dvb mailing list for encouraging me
 
    Peter Schildmann >peter.schildmann-nospam-at-web.de< for his
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Kconfig
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/Kconfig	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Kconfig	2005-03-22 00:16:19.000000000 +0100
@@ -13,7 +13,7 @@ config DVB_DIBUSB
 
 	    TwinhanDTV USB-Ter (VP7041)
 		TwinhanDTV Magic Box (VP7041e)
-	    KWorld V-Stream XPERT DTV - DVB-T USB
+	    KWorld/JetWay/ADSTech V-Stream XPERT DTV - DVB-T USB1.1 and USB2.0
 	    Hama DVB-T USB-Box
 	    DiBcom reference devices (non-public)
 	    Ultima Electronic/Artec T1 USB TVBOX
@@ -23,6 +23,7 @@ config DVB_DIBUSB
 	    Artec T1 USB1.1 and USB2.0 boxes
 	    Yakumo/Typhoon DVB-T USB2.0
 	    Hanftek UMT-010 USB2.0
+	    Hauppauge WinTV NOVA-T USB2
 
 	  The VP7041 seems to be identical to "CTS Portable" (Chinese
 	  Television System).
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:15:45.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:16:19.000000000 +0100
@@ -47,6 +47,7 @@ module_param(rc_query_interval, int, 064
 MODULE_PARM_DESC(rc_query_interval, "interval in msecs for remote control query (default: 100; min: 40)");
 
 /* Vendor IDs */
+#define USB_VID_ADSTECH						0x06e1
 #define USB_VID_ANCHOR						0x0547
 #define USB_VID_AVERMEDIA					0x14aa
 #define USB_VID_COMPRO						0x185b
@@ -63,6 +64,8 @@ MODULE_PARM_DESC(rc_query_interval, "int
 #define USB_VID_ULTIMA_ELECTRONIC			0x05d8
 
 /* Product IDs */
+#define USB_PID_ADSTECH_USB2_COLD			0xa333
+#define USB_PID_ADSTECH_USB2_WARM			0xa334
 #define USB_PID_AVERMEDIA_DVBT_USB_COLD		0x0001
 #define USB_PID_AVERMEDIA_DVBT_USB_WARM		0x0002
 #define USB_PID_COMPRO_DVBU2000_COLD		0xd000
@@ -148,16 +151,18 @@ static struct usb_device_id dib_table []
 
 /* 30 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,		USB_PID_WINTV_NOVA_T_USB2_COLD) },
 /* 31 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,		USB_PID_WINTV_NOVA_T_USB2_WARM) },
+/* 32 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
+/* 33 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
 /* 
  * activate the following define when you have one of the devices and want to 
  * build it from build-2.6 in dvb-kernel
  */
 // #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES 
 #ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
-/* 32 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
-/* 33 */	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
-/* 34 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
-/* 35 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_DIBCOM_ANCHOR_2135_COLD) },
+/* 34 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+/* 35 */	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
+/* 36 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
+/* 37 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_DIBCOM_ANCHOR_2135_COLD) },
 #endif
 			{ }		/* Terminating entry */
 };
@@ -204,7 +209,7 @@ static struct dibusb_device_class dibusb
 	{ .id = DIBUSB1_1, .usb_ctrl = &dibusb_usb_ctrl[0],
 	  .firmware = "dvb-dibusb-5.0.0.11.fw",
 	  .pipe_cmd = 0x01, .pipe_data = 0x02, 
-	  .urb_count = 5, .urb_buffer_size = 4096,
+	  .urb_count = 7, .urb_buffer_size = 4096,
 	  DIBUSB_RC_NEC_PROTOCOL,
 	  &dibusb_demod[DIBUSB_DIB3000MB],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
@@ -212,7 +217,7 @@ static struct dibusb_device_class dibusb
 	{ DIBUSB1_1_AN2235, &dibusb_usb_ctrl[1],
 	  "dvb-dibusb-an2235-1.fw",
 	  0x01, 0x02, 
-	  5, 4096,
+	  7, 4096,
 	  DIBUSB_RC_NEC_PROTOCOL,
 	  &dibusb_demod[DIBUSB_DIB3000MB],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
@@ -228,11 +233,19 @@ static struct dibusb_device_class dibusb
 	{ UMT2_0, &dibusb_usb_ctrl[2],
 	  "dvb-dibusb-umt-1.fw",
 	  0x01, 0x02, 
-	  15, 188*21,
+	  7, 188*21,
 	  DIBUSB_RC_NO,
 	  &dibusb_demod[DIBUSB_MT352],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_LG_TDTP_E102P],
 	},
+	{ DIBUSB2_0B,&dibusb_usb_ctrl[2],
+	  "dvb-dibusb-adstech-usb2-1.fw",
+	  0x01, 0x06,
+	  7, 4096,
+	  DIBUSB_RC_NEC_PROTOCOL,
+	  &dibusb_demod[DIBUSB_DIB3000MB],
+	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
+	},
 };
 
 static struct dibusb_usb_device dibusb_devices[] = {
@@ -306,20 +319,25 @@ static struct dibusb_usb_device dibusb_d
 		{ &dib_table[28], NULL },
 		{ &dib_table[29], NULL },
 	},	
+	{	"KWorld/ADSTech Instant DVB-T USB 2.0",
+		&dibusb_device_classes[DIBUSB2_0B],
+		{ &dib_table[32], NULL },
+		{ &dib_table[33], NULL }, /* device ID with default DIBUSB2_0-firmware */
+	},
 #ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
 	{	"Artec T1 USB1.1 TVBOX with AN2235 (misdesigned)",
 		&dibusb_device_classes[DIBUSB1_1_AN2235],
-		{ &dib_table[32], NULL },
+		{ &dib_table[34], NULL },
 		{ NULL },
 	},
 	{	"Artec T1 USB2.0 TVBOX with FX2 IDs (misdesigned, please report the warm ID)",
 		&dibusb_device_classes[DIBUSB2_0],
-		{ &dib_table[33], NULL },
-		{ &dib_table[34], NULL }, /* undefined, it could be that the device will get another USB ID in warm state */
+		{ &dib_table[35], NULL },
+		{ &dib_table[36], NULL }, /* undefined, it could be that the device will get another USB ID in warm state */
 	},
 	{	"DiBcom USB1.1 DVB-T reference design (MOD3000) with AN2135 default IDs",
 		&dibusb_device_classes[DIBUSB1_1],
-		{ &dib_table[35], NULL },
+		{ &dib_table[37], NULL },
 		{ NULL },
 	},
 #endif
@@ -365,30 +383,62 @@ static int dibusb_init(struct usb_dibusb
 	return 0;
 }
 
+static struct dibusb_usb_device * dibusb_device_class_quirk(struct usb_device *udev, struct dibusb_usb_device *dev)
+{
+	int i;
+
+	/* Quirk for the Kworld/ADSTech Instant USB2.0 device. It has the same USB
+	 * IDs like the USB1.1 KWorld after loading the firmware. Which is a bad
+	 * idea and make this quirk necessary.
+	 */
+	if (dev->dev_cl->id == DIBUSB1_1 && udev->speed == USB_SPEED_HIGH) {
+		info("this seems to be the Kworld/ADSTech Instant USB2.0 device or equal.");
+		for (i = 0; i < sizeof(dibusb_devices)/sizeof(struct dibusb_usb_device); i++) {
+			if (dibusb_devices[i].dev_cl->id == DIBUSB2_0B) {
+				dev = &dibusb_devices[i];
+				break;
+			}
+		}
+	}
+
+	return dev;
+}
+
 static struct dibusb_usb_device * dibusb_find_device (struct usb_device *udev,int *cold)
 {
 	int i,j;
 	*cold = -1;
+	struct dibusb_usb_device *dev = NULL;
+
 	for (i = 0; i < sizeof(dibusb_devices)/sizeof(struct dibusb_usb_device); i++) {
 		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].cold_ids[j] != NULL; j++) {
 			deb_info("check for cold %x %x\n",dibusb_devices[i].cold_ids[j]->idVendor, dibusb_devices[i].cold_ids[j]->idProduct);
 			if (dibusb_devices[i].cold_ids[j]->idVendor == le16_to_cpu(udev->descriptor.idVendor) &&
 				dibusb_devices[i].cold_ids[j]->idProduct == le16_to_cpu(udev->descriptor.idProduct)) {
 				*cold = 1;
-				return &dibusb_devices[i];
+				dev = &dibusb_devices[i];
+				break;
 			}
 		}
 
+		if (dev != NULL)
+			break;
+
 		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].warm_ids[j] != NULL; j++) {
 			deb_info("check for warm %x %x\n",dibusb_devices[i].warm_ids[j]->idVendor, dibusb_devices[i].warm_ids[j]->idProduct);
 			if (dibusb_devices[i].warm_ids[j]->idVendor == le16_to_cpu(udev->descriptor.idVendor) &&
 				dibusb_devices[i].warm_ids[j]->idProduct == le16_to_cpu(udev->descriptor.idProduct)) {
 				*cold = 0;
-				return &dibusb_devices[i];
+				dev = &dibusb_devices[i];
+				break;
 			}
 		}
 	}
-	return NULL;
+
+	if (dev != NULL)
+		dev = dibusb_device_class_quirk(udev,dev);
+
+	return dev;
 }
 
 /*
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:15:37.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:16:19.000000000 +0100
@@ -136,6 +136,7 @@ int dibusb_streaming(struct usb_dibusb *
 {
 	switch (dib->dibdev->dev_cl->id) {
 		case DIBUSB2_0:
+		case DIBUSB2_0B:
 			if (onoff)
 				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_ENABLE_STREAM,NULL,0);
 			else
@@ -206,10 +207,11 @@ int dibusb_urb_init(struct usb_dibusb *d
 
 	/* dib->pid_parse here contains the value of the module parameter */
 	/* decide if pid parsing can be deactivated:
-	 * is possible (by speed) and wanted (by user)
+	 * is possible (by device type) and wanted (by user)
 	 */
 	switch (dib->dibdev->dev_cl->id) {
 		case DIBUSB2_0:
+		case DIBUSB2_0B:
 			if (dib->udev->speed == USB_SPEED_HIGH && !dib->pid_parse) {
 				def_pid_parse = 0;
 				info("running at HIGH speed, will deliver the complete TS.");
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:15:37.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:16:19.000000000 +0100
@@ -72,6 +72,7 @@ typedef enum {
 	DIBUSB1_1_AN2235,
 	DIBUSB2_0,
 	UMT2_0,
+	DIBUSB2_0B,
 } dibusb_class_t;
 
 typedef enum {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:15:24.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:16:19.000000000 +0100
@@ -684,8 +684,9 @@ static int dib3000mb_fifo_control(struct
 
 static int dib3000mb_pid_parse(struct dvb_frontend *fe, int onoff)
 {
-	//struct dib3000_state *state = fe->demodulator_priv;
-	/* switch it off and on */
+	struct dib3000_state *state = fe->demodulator_priv;
+	deb_xfer("%s pid parsing\n",onoff ? "enabling" : "disabling");
+	wr(DIB3000MB_REG_PID_PARSE,onoff);
 	return 0;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:15:24.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:16:19.000000000 +0100
@@ -794,10 +794,8 @@ static int dib3000mc_pid_parse(struct dv
 	deb_xfer("%s pid parsing\n",onoff ? "enabling" : "disabling");
 
 	if (onoff) {
-		deb_xfer("%d %x\n",tmp | DIB3000MC_SMO_MODE_PID_PARSE,tmp | DIB3000MC_SMO_MODE_PID_PARSE);
 		wr(DIB3000MC_REG_SMO_MODE,tmp | DIB3000MC_SMO_MODE_PID_PARSE);
 	} else {
-		deb_xfer("%d %x\n",tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE,tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE);
 		wr(DIB3000MC_REG_SMO_MODE,tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE);
 	}
 	return 0;

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVAVSCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVAVSCV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVAVSCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:02:20 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:9938 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262592AbVAVRdD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:33:03 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:28 +0100
Message-Id: <11064152683716@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 3/9] refactoring, support Yakumo/HAMA/Typhoon/HanfTek clones
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dvb-dibusb: refactoring of the dibusb driver, support for device clones
        from Yakumo/HAMA/Typhoon/HanfTek, update the documentation

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/Documentation/dvb/README.dibusb linux-2.6.11-rc2-dvb/Documentation/dvb/README.dibusb
--- linux-2.6.11-rc2/Documentation/dvb/README.dibusb	2005-01-20 19:55:06.000000000 +0100
+++ linux-2.6.11-rc2-dvb/Documentation/dvb/README.dibusb	2005-01-20 19:56:37.000000000 +0100
@@ -26,7 +26,7 @@
 - HAMA DVB-T USB device
 	http://www.hama.de/portal/articleId*110620/action*2598
 
-- CTS Portable (Chinese Television System)
+- CTS Portable (Chinese Television System) (2)
 	http://www.2cts.tv/ctsportable/
 
 - Unknown USB DVB-T device with vendor ID Hyper-Paltek
@@ -46,16 +46,16 @@
 
 Others:
 -------
-- Ultima Electronic/Artec T1 USB TVBOX (AN2135 and AN2235)
+- Ultima Electronic/Artec T1 USB TVBOX (AN2135, AN2235, AN2235 with Panasonic Tuner) 
 	http://82.161.246.249/products-tvbox.html
 
-- Compro Videomate DVB-U2000 - DVB-T USB
+- Compro Videomate DVB-U2000 - DVB-T USB (2)
 	http://www.comprousa.com/products/vmu2000.htm
 
 - Grandtec USB DVB-T
 	http://www.grand.com.tw/
 
-- Avermedia AverTV DVBT USB
+- Avermedia AverTV DVBT USB (2)
 	http://www.avermedia.com/
 
 - DiBcom USB DVB-T reference device (non-public)
@@ -63,16 +63,33 @@
 
 Supported devices USB2.0
 ========================
-- Twinhan MagicBox II
+- Twinhan MagicBox II (2)
 	http://www.twinhan.com/product_terrestrial_7.asp
 
-- Yakumo DVB-T mobile
+- Hanftek UMT-010 (1)
+	http://www.globalsources.com/si/6008819757082/ProductDetail/Digital-TV/product_id-100046529
+
+- Typhoon/Yakumo/HAMA DVB-T mobile USB2.0 (1)
 	http://www.yakumo.de/produkte/index.php?pid=1&ag=DVB-T
 
+- Artec T1 USB TVBOX (FX2) (2)
+
 - DiBcom USB2.0 DVB-T reference device (non-public)
 
+1) It is working almost.
+2) No test reports received yet. 
+
 
 0. NEWS:
+  2004-01-13 - moved the mirrored pid_filter_table back to dvb-dibusb
+             - first almost working version for HanfTek UMT-010
+             - found out, that Yakumo/HAMA/Typhoon are predessors of the HanfTek
+  2004-01-10 - refactoring completed, now everything is very delightful
+             - tuner quirks for some weird devices (Artec T1 AN2235 device has sometimes a
+               Panasonic Tuner assembled). Tunerprobing implemented. Thanks a lot to Gunnar Wittich. 
+  2004-12-29 - after several days of struggling around bug of no returning URBs fixed.
+  2004-12-26 - refactored the dibusb-driver, splitted into separate files
+             - i2c-probing enabled
   2004-12-06 - possibility for demod i2c-address probing
              - new usb IDs (Compro,Artec)
   2004-11-23 - merged changes from DiB3000MC_ver2.1
@@ -115,13 +132,15 @@
 
 1. How to use?
 NOTE: This driver was developed using Linux 2.6.6.,
-it is working with 2.6.7, 2.6.8.1, 2.6.9 .
+it is working with 2.6.7 and above.
 
 Linux 2.4.x support is not planned, but patches are very welcome.
 
 NOTE: I'm using Debian testing, so the following explaination (especially
 the hotplug-path) needn't match your system, but probably it will :).
 
+The driver is included in the kernel since Linux 2.6.10.
+
 1.1. Firmware
 
 The USB driver needs to download a firmware to start working.
@@ -155,9 +174,13 @@
 first have a look, which debug level are available:
 
 modinfo dib3000mb
+modinfo dib3000-common
+modinfo dib3000mc
 modinfo dvb-dibusb
 
+modprobe dib3000-common debug=<level>
 modprobe dib3000mb debug=<level>
+modprobe dib3000mc debug=<level>
 modprobe dvb-dibusb debug=<level>
 
 should do the trick.
@@ -168,13 +191,11 @@
 
 At this point you should be able to start a dvb-capable application. For myself
 I used mplayer, dvbscan, tzap and kaxtv, they are working. Using the device
-as a slave device in vdr, was not working for me. Some work has to be done
-(patches and comments are very welcome).
+in vdr (at least the USB2.0 one) is working. 
 
 2. Known problems and bugs
 
-TODO:
-- signal-quality and strength calculations
+- none this time
 
 2.1. Adding support for devices 
 
@@ -202,9 +223,10 @@
 maximum bandwidth of about 5-6 MBit/s when connected to a USB2.0 hub.
 This is not enough for receiving the complete transport stream of a
 DVB-T channel (which can be about 16 MBit/s). Normally this is not a
-problem, if you only want to watch TV, but watching a channel while
-recording another channel on the same frequency simply does not work.
-This applies to all USB1.1 DVB-T devices.
+problem, if you only want to watch TV (this does not apply for HDTV),
+but watching a channel while recording another channel on the same 
+frequency simply does not work. This applies to all USB1.1 DVB-T 
+devices, not only dibusb)
 
 A special problem of the dibusb for the USB1.1 is, that the USB control
 IC has a problem with write accesses while having MPEG2-streaming
@@ -218,14 +240,20 @@
 these features is maybe a solution. Additionally this behaviour of VDR exceeds
 the USB1.1 bandwidth.
 
+Update:
+For the USB1.1 and VDR some work has been done (patches and comments are still 
+very welcome). Maybe the problem is solved in the meantime because I now use
+the dmx_sw_filter function instead of dmx_sw_filter_packet. I hope the
+linux-dvb software filter is able to get the best of the garbled TS.
+
 2.3. Comments
 
 Patches, comments and suggestions are very very welcome
 
 3. Acknowledgements
 	Amaury Demol (ademol@dibcom.fr) and Francois Kanounnikoff from DiBcom for
-	providing specs, code and help, on which the dvb-dibusb and dib3000mb are
-	based.
+    providing specs, code and help, on which the dvb-dibusb, dib3000mb and 
+    dib3000mc are based.
 
    David Matthews for identifying a new device type (Artec T1 with AN2235)
     and for extending dibusb with remote control event handling. Thank you.
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-core.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-core.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-01-13 14:24:12.000000000 +0100
@@ -0,0 +1,471 @@
+/*
+ * Driver for mobile USB Budget DVB-T devices based on reference 
+ * design made by DiBcom (http://www.dibcom.fr/)
+ * 
+ * dvb-dibusb-core.c
+ * 
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ * 
+ * based on GPL code from DiBcom, which has
+ * Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
+ *
+ * Remote control code added by David Matthews (dm@prolingua.co.uk)
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ * Acknowledgements
+ * 
+ *  Amaury Demol (ademol@dibcom.fr) from DiBcom for providing specs and driver
+ *  sources, on which this driver (and the dib3000mb/mc/p frontends) are based.
+ * 
+ * see Documentation/dvb/README.dibusb for more information
+ */
+#include "dvb-dibusb.h"
+
+#include <linux/moduleparam.h>
+
+/* debug */
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+int debug;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore,8=ts,16=err,32=rc (|-able)).");
+#endif
+
+int pid_parse;
+module_param(pid_parse, int, 0644);
+MODULE_PARM_DESC(pid_parse, "enable pid parsing (filtering) when running at USB2.0");
+
+int rc_query_interval;
+module_param(rc_query_interval, int, 0644);
+MODULE_PARM_DESC(rc_query_interval, "interval in msecs for remote control query (default: 100; min: 40)");
+
+/* Vendor IDs */
+#define USB_VID_ANCHOR						0x0547
+#define USB_VID_AVERMEDIA					0x14aa
+#define USB_VID_COMPRO						0x185b
+#define USB_VID_COMPRO_UNK					0x145f
+#define USB_VID_CYPRESS						0x04b4
+#define USB_VID_DIBCOM						0x10b8
+#define USB_VID_EMPIA						0xeb1a
+#define USB_VID_GRANDTEC					0x5032
+#define USB_VID_HYPER_PALTEK				0x1025
+#define USB_VID_HANFTEK						0x15f4
+#define USB_VID_IMC_NETWORKS				0x13d3
+#define USB_VID_TWINHAN						0x1822
+#define USB_VID_ULTIMA_ELECTRONIC			0x05d8
+
+/* Product IDs */
+#define USB_PID_AVERMEDIA_DVBT_USB_COLD		0x0001
+#define USB_PID_AVERMEDIA_DVBT_USB_WARM		0x0002
+#define USB_PID_COMPRO_DVBU2000_COLD		0xd000
+#define USB_PID_COMPRO_DVBU2000_WARM		0xd001
+#define USB_PID_COMPRO_DVBU2000_UNK_COLD	0x010c
+#define USB_PID_COMPRO_DVBU2000_UNK_WARM	0x010d
+#define USB_PID_DIBCOM_MOD3000_COLD			0x0bb8
+#define USB_PID_DIBCOM_MOD3000_WARM			0x0bb9
+#define USB_PID_DIBCOM_MOD3001_COLD			0x0bc6
+#define USB_PID_DIBCOM_MOD3001_WARM			0x0bc7
+#define USB_PID_DIBCOM_ANCHOR_2135_COLD		0x2131
+#define USB_PID_GRANDTEC_DVBT_USB_COLD		0x0fa0
+#define USB_PID_GRANDTEC_DVBT_USB_WARM		0x0fa1
+#define USB_PID_KWORLD_VSTREAM_COLD			0x17de
+#define USB_PID_KWORLD_VSTREAM_WARM			0x17df
+#define USB_PID_TWINHAN_VP7041_COLD			0x3201
+#define USB_PID_TWINHAN_VP7041_WARM			0x3202
+#define USB_PID_ULTIMA_TVBOX_COLD			0x8105
+#define USB_PID_ULTIMA_TVBOX_WARM			0x8106
+#define USB_PID_ULTIMA_TVBOX_AN2235_COLD	0x8107
+#define USB_PID_ULTIMA_TVBOX_AN2235_WARM	0x8108
+#define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD	0x2235
+#define USB_PID_ULTIMA_TVBOX_USB2_COLD		0x8109
+#define USB_PID_ULTIMA_TVBOX_USB2_FX_COLD	0x8613
+#define USB_PID_ULTIMA_TVBOX_USB2_FX_WARM	0x1002
+#define USB_PID_UNK_HYPER_PALTEK_COLD		0x005e
+#define USB_PID_UNK_HYPER_PALTEK_WARM		0x005f
+#define USB_PID_HANFTEK_UMT_010_COLD		0x0001
+#define USB_PID_HANFTEK_UMT_010_WARM		0x0025
+#define USB_PID_YAKUMO_DTT200U_COLD			0x0201
+#define USB_PID_YAKUMO_DTT200U_WARM			0x0301
+
+/* USB Driver stuff
+ * table of devices that this driver is working with
+ *
+ * ATTENTION: Never ever change the order of this table, the particular 
+ * devices depend on this order 
+ *
+ * Each entry is used as a reference in the device_struct. Currently this is 
+ * the only non-redundant way of assigning USB ids to actual devices I'm aware 
+ * of, because there is only one place in the code where the assignment of 
+ * vendor and product id is done, here.
+ */
+static struct usb_device_id dib_table [] = {
+/* 00 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_AVERMEDIA_DVBT_USB_COLD)},
+/* 01 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_AVERMEDIA_DVBT_USB_WARM)},
+/* 02 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_COLD) },
+
+/* the following device is actually not supported, but when loading the 
+ * correct firmware (ie. its usb ids will change) everything works fine then 
+ */
+/* 03 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_WARM) },
+
+/* 04 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
+/* 05 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
+/* 06 */	{ USB_DEVICE(USB_VID_COMPRO_UNK,	USB_PID_COMPRO_DVBU2000_UNK_COLD) },
+/* 07 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_COLD) },
+/* 08 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_WARM) },
+/* 09 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_COLD) },
+/* 10 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_WARM) },
+/* 11 */	{ USB_DEVICE(USB_VID_EMPIA,			USB_PID_KWORLD_VSTREAM_COLD) },
+/* 12 */	{ USB_DEVICE(USB_VID_EMPIA,			USB_PID_KWORLD_VSTREAM_WARM) },
+/* 13 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_COLD) },
+/* 14 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_WARM) },
+/* 15 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_COLD) },
+/* 16 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_WARM) },
+/* 17 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_COLD) },
+/* 18 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_WARM) },
+/* 19 */	{ USB_DEVICE(USB_VID_IMC_NETWORKS,	USB_PID_TWINHAN_VP7041_COLD) },
+/* 20 */	{ USB_DEVICE(USB_VID_IMC_NETWORKS,	USB_PID_TWINHAN_VP7041_WARM) },
+/* 21 */	{ USB_DEVICE(USB_VID_TWINHAN, 		USB_PID_TWINHAN_VP7041_COLD) },
+/* 22 */	{ USB_DEVICE(USB_VID_TWINHAN, 		USB_PID_TWINHAN_VP7041_WARM) },
+/* 23 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_COLD) },
+/* 24 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_WARM) },
+/* 25 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
+/* 26 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
+/* 27 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_COLD) },
+	
+/* 28 */	{ USB_DEVICE(USB_VID_HANFTEK,		USB_PID_HANFTEK_UMT_010_COLD) },
+/* 29 */	{ USB_DEVICE(USB_VID_HANFTEK,		USB_PID_HANFTEK_UMT_010_WARM) },
+
+/* 
+ * activate the following define when you have one of the devices and want to 
+ * build it from build-2.6 in dvb-kernel
+ */
+// #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES 
+#ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
+/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+/* 31 */	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
+/* 32 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
+/* 33 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_DIBCOM_ANCHOR_2135_COLD) },
+#endif
+			{ }		/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE (usb, dib_table);
+
+static struct dibusb_usb_controller dibusb_usb_ctrl[] = {
+	{ .name = "Cypress AN2135", .cpu_cs_register = 0x7f92 },
+	{ .name = "Cypress AN2235", .cpu_cs_register = 0x7f92 },
+	{ .name = "Cypress FX2",    .cpu_cs_register = 0xe600 },
+};
+
+struct dibusb_tuner dibusb_tuner[] = {
+	{ DIBUSB_TUNER_CABLE_THOMSON, 
+	  0x61 
+	},
+	{ DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5,
+	  0x60 
+	},
+	{ DIBUSB_TUNER_CABLE_LG_TDTP_E102P,
+	  0x61
+	},
+	{ DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5,
+	  0x60
+	},
+};
+
+static struct dibusb_demod dibusb_demod[] = {
+	{ DIBUSB_DIB3000MB,
+	  16,
+	  { 0x8, 0 },
+	},
+	{ DIBUSB_DIB3000MC,
+	  32,
+	  { 0x9, 0xa, 0xb, 0xc }, 
+	},
+	{ DIBUSB_MT352,
+	  254,
+	  { 0xf, 0 }, 
+	},
+};
+
+static struct dibusb_device_class dibusb_device_classes[] = {
+	{ .id = DIBUSB1_1, .usb_ctrl = &dibusb_usb_ctrl[0],
+	  .firmware = "dvb-dibusb-5.0.0.11.fw",
+	  .pipe_cmd = 0x01, .pipe_data = 0x02, 
+	  .urb_count = 3, .urb_buffer_size = 4096,
+	  DIBUSB_RC_NEC_PROTOCOL,
+	  &dibusb_demod[DIBUSB_DIB3000MB],
+	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
+	},
+	{ DIBUSB1_1_AN2235, &dibusb_usb_ctrl[1],
+	  "dvb-dibusb-an2235-1.fw",
+	  0x01, 0x02, 
+	  3, 4096,
+	  DIBUSB_RC_NEC_PROTOCOL,
+	  &dibusb_demod[DIBUSB_DIB3000MB],
+	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
+	},
+	{ DIBUSB2_0,&dibusb_usb_ctrl[2],
+	  "dvb-dibusb-6.0.0.5.fw",
+	  0x01, 0x06, 
+	  3, 188*210,
+	  DIBUSB_RC_NEC_PROTOCOL,
+	  &dibusb_demod[DIBUSB_DIB3000MC],
+	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5],
+	},
+	{ UMT2_0, &dibusb_usb_ctrl[2],
+	  "dvb-dibusb-umt-1.fw",
+	  0x01, 0x02, 
+	  15, 188*21,
+	  DIBUSB_RC_NO,
+	  &dibusb_demod[DIBUSB_MT352],
+//	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5],
+	  &dibusb_tuner[DIBUSB_TUNER_CABLE_LG_TDTP_E102P],
+	},
+};
+
+static struct dibusb_usb_device dibusb_devices[] = {
+	{	"TwinhanDTV USB1.1 / Magic Box / HAMA USB1.1 DVB-T device",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[19], &dib_table[21], NULL},
+		{ &dib_table[20], &dib_table[22], NULL},
+	},
+	{	"KWorld V-Stream XPERT DTV - DVB-T USB1.1",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[11], NULL },
+		{ &dib_table[12], NULL },
+	},
+	{	"Grandtec USB1.1 DVB-T",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[13], &dib_table[15], NULL },
+		{ &dib_table[14], &dib_table[16], NULL },
+	},
+	{	"DiBcom USB1.1 DVB-T reference design (MOD3000)",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[7],  NULL },
+		{ &dib_table[8],  NULL },
+	},
+	{	"Artec T1 USB1.1 TVBOX with AN2135",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[23], NULL },
+		{ &dib_table[24], NULL },
+	},
+	{	"Artec T1 USB1.1 TVBOX with AN2235",
+		&dibusb_device_classes[DIBUSB1_1_AN2235],
+		{ &dib_table[25], NULL },
+		{ &dib_table[26], NULL },
+	},
+	{	"Avermedia AverTV DVBT USB1.1",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[0],  NULL },
+		{ &dib_table[1],  NULL },
+	},
+	{	"Compro Videomate DVB-U2000 - DVB-T USB1.1 (please confirm to linux-dvb)",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[4], &dib_table[6], NULL},
+		{ &dib_table[5], NULL },
+	},
+	{	"Unkown USB1.1 DVB-T device ???? please report the name to the author",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[17], NULL },
+		{ &dib_table[18], NULL },
+	},
+	{	"DiBcom USB2.0 DVB-T reference design (MOD3000P)",
+		&dibusb_device_classes[DIBUSB2_0],
+		{ &dib_table[9],  NULL },
+		{ &dib_table[10], NULL },
+	},
+	{	"Artec T1 USB2.0 TVBOX (please report the warm ID)",
+		&dibusb_device_classes[DIBUSB2_0],
+		{ &dib_table[27], NULL },
+		{ NULL },
+	},
+	{	"AVermedia/Yakumo/Hama/Typhoon DVB-T USB2.0",
+		&dibusb_device_classes[UMT2_0],
+		{ &dib_table[2], NULL },
+		{ NULL },
+	},	
+	{	"Hanftek UMT-010 DVB-T USB2.0",
+		&dibusb_device_classes[UMT2_0],
+		{ &dib_table[28], NULL },
+		{ &dib_table[29], NULL },
+	},	
+#ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
+	{	"Artec T1 USB1.1 TVBOX with AN2235 (misdesigned)",
+		&dibusb_device_classes[DIBUSB1_1_AN2235],
+		{ &dib_table[30], NULL },
+		{ NULL },
+	},
+	{	"Artec T1 USB2.0 TVBOX with FX2 IDs (misdesigned, please report the warm ID)",
+		&dibusb_device_classes[DIBUSB2_0],
+		{ &dib_table[31], NULL },
+		{ &dib_table[32], NULL }, /* undefined, it could be that the device will get another USB ID in warm state */
+	},
+	{	"DiBcom USB1.1 DVB-T reference design (MOD3000) with AN2135 default IDs",
+		&dibusb_device_classes[DIBUSB1_1],
+		{ &dib_table[33], NULL },
+		{ NULL },
+	},
+#endif
+};
+
+static int dibusb_exit(struct usb_dibusb *dib)
+{
+	deb_info("init_state before exiting everything: %x\n",dib->init_state);
+	dibusb_remote_exit(dib);
+	dibusb_fe_exit(dib);
+	dibusb_i2c_exit(dib);
+	dibusb_pid_list_exit(dib);
+	dibusb_dvb_exit(dib);
+	dibusb_urb_exit(dib);
+	deb_info("init_state should be zero now: %x\n",dib->init_state);
+	dib->init_state = DIBUSB_STATE_INIT;
+	kfree(dib);
+	return 0;
+}
+
+static int dibusb_init(struct usb_dibusb *dib)
+{
+	int ret = 0;
+	sema_init(&dib->usb_sem, 1);
+	sema_init(&dib->i2c_sem, 1);
+
+	dib->init_state = DIBUSB_STATE_INIT;
+	
+	if ((ret = dibusb_urb_init(dib)) ||
+		(ret = dibusb_dvb_init(dib)) || 
+		(ret = dibusb_pid_list_init(dib)) ||
+		(ret = dibusb_i2c_init(dib))) {
+		dibusb_exit(dib);
+		return ret;
+	}
+
+	if ((ret = dibusb_fe_init(dib)))
+		err("could not initialize a frontend.");
+	
+	if ((ret = dibusb_remote_init(dib)))
+		err("could not initialize remote control.");
+	
+	return 0;
+}
+
+static struct dibusb_usb_device * dibusb_find_device (struct usb_device *udev,int *cold)
+{
+	int i,j;
+	*cold = -1;
+	for (i = 0; i < sizeof(dibusb_devices)/sizeof(struct dibusb_usb_device); i++) {
+		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].cold_ids[j] != NULL; j++) {
+			deb_info("check for cold %x %x\n",dibusb_devices[i].cold_ids[j]->idVendor, dibusb_devices[i].cold_ids[j]->idProduct);
+			if (dibusb_devices[i].cold_ids[j]->idVendor == udev->descriptor.idVendor &&
+				dibusb_devices[i].cold_ids[j]->idProduct == udev->descriptor.idProduct) {
+				*cold = 1;
+				return &dibusb_devices[i];
+			}
+		}
+
+		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].warm_ids[j] != NULL; j++) {
+			deb_info("check for warm %x %x\n",dibusb_devices[i].warm_ids[j]->idVendor, dibusb_devices[i].warm_ids[j]->idProduct);
+			if (dibusb_devices[i].warm_ids[j]->idVendor == udev->descriptor.idVendor &&
+				dibusb_devices[i].warm_ids[j]->idProduct == udev->descriptor.idProduct) {
+				*cold = 0;
+				return &dibusb_devices[i];
+			}
+		}
+	}
+	return NULL;
+}
+
+/*
+ * USB 
+ */
+static int dibusb_probe(struct usb_interface *intf, 
+		const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_dibusb *dib = NULL;
+	struct dibusb_usb_device *dibdev = NULL;
+	
+	int ret = -ENOMEM,cold=0;
+
+	if ((dibdev = dibusb_find_device(udev,&cold)) == NULL) {
+		err("something went very wrong, "
+				"unknown product ID: %.4x",udev->descriptor.idProduct);
+		return -ENODEV;
+	}
+	
+	if (cold == 1) {
+		info("found a '%s' in cold state, will try to load a firmware",dibdev->name);
+		ret = dibusb_loadfirmware(udev,dibdev);
+	} else {
+		info("found a '%s' in warm state.",dibdev->name);
+		dib = kmalloc(sizeof(struct usb_dibusb),GFP_KERNEL);
+		if (dib == NULL) {
+			err("no memory");
+			return ret;
+		}
+		memset(dib,0,sizeof(struct usb_dibusb));
+		
+		dib->udev = udev;
+		dib->dibdev = dibdev;
+
+		usb_set_intfdata(intf, dib);
+		
+		ret = dibusb_init(dib);
+	}
+	
+	if (ret == 0)
+		info("%s successfully initialized and connected.",dibdev->name);
+	else 
+		info("%s error while loading driver (%d)",dibdev->name,ret);
+	return ret;
+}
+
+static void dibusb_disconnect(struct usb_interface *intf)
+{
+	struct usb_dibusb *dib = usb_get_intfdata(intf);
+	const char *name = DRIVER_DESC;
+	
+	usb_set_intfdata(intf,NULL);
+	if (dib != NULL && dib->dibdev != NULL) {
+		name = dib->dibdev->name;
+		dibusb_exit(dib);
+	}
+	info("%s successfully deinitialized and disconnected.",name);
+	
+}
+
+/* usb specific object needed to register this driver with the usb subsystem */
+struct usb_driver dibusb_driver = {
+	.owner		= THIS_MODULE,
+	.name		= DRIVER_DESC,
+	.probe 		= dibusb_probe,
+	.disconnect = dibusb_disconnect,
+	.id_table 	= dib_table,
+};
+
+/* module stuff */
+static int __init usb_dibusb_init(void)
+{
+	int result;
+	if ((result = usb_register(&dibusb_driver))) {
+		err("usb_register failed. Error number %d",result);
+		return result;
+	}
+	
+	return 0;
+}
+
+static void __exit usb_dibusb_exit(void)
+{
+	/* deregister this driver from the USB subsystem */
+	usb_deregister(&dibusb_driver);
+}
+
+module_init (usb_dibusb_init);
+module_exit (usb_dibusb_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-01-13 14:24:12.000000000 +0100
@@ -0,0 +1,205 @@
+/*
+ * dvb-dibusb-dvb.c is part of the driver for mobile USB Budget DVB-T devices 
+ * based on reference design made by DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * see dvb-dibusb-core.c for more copyright details.
+ *
+ * This file contains functions for initializing and handling the 
+ * linux-dvb API.
+ */
+#include "dvb-dibusb.h"
+
+#include <linux/usb.h>
+#include <linux/version.h>
+
+static u32 urb_compl_count;
+
+/*
+ * MPEG2 TS DVB stuff 
+ */
+void dibusb_urb_complete(struct urb *urb, struct pt_regs *ptregs)
+{
+	struct usb_dibusb *dib = urb->context;
+	int ret;
+
+	deb_ts("urb complete feedcount: %d, status: %d, length: %d\n",dib->feedcount,urb->status,
+			urb->actual_length);
+
+	urb_compl_count++;
+	if (urb_compl_count % 500 == 0)
+		deb_info("%d urbs completed so far.\n",urb_compl_count);
+
+	switch (urb->status) {
+		case 0:         /* success */
+		case -ETIMEDOUT:    /* NAK */
+			break;
+		case -ECONNRESET:   /* unlink */
+		case -ENOENT:
+		case -ESHUTDOWN:
+			return;
+		default:        /* error */
+			warn("urb completition error %d.", urb->status);
+	}
+
+	if (dib->feedcount > 0) {
+		deb_ts("URB return len: %d\n",urb->actual_length);
+		if (urb->actual_length % 188) 
+			deb_ts("TS Packets: %d, %d\n", urb->actual_length/188,urb->actual_length % 188);
+
+		/* Francois recommends to drop not full-filled packets, even if they may 
+		 * contain valid TS packets, at least for USB1.1
+		 *
+		 * if (urb->actual_length == dib->dibdev->parm->default_size && dib->dvb_is_ready) */
+		if (dib->init_state & DIBUSB_STATE_DVB)
+			dvb_dmx_swfilter(&dib->demux, (u8*) urb->transfer_buffer,urb->actual_length);
+		else
+			deb_ts("URB dropped because of the " 
+					"actual_length or !dvb_is_ready (%d).\n",dib->init_state & DIBUSB_STATE_DVB);
+	} else 
+		deb_ts("URB dropped because of feedcount.\n");
+
+	ret = usb_submit_urb(urb,GFP_ATOMIC);
+	deb_ts("urb resubmitted, (%d)\n",ret);
+}
+
+static int dibusb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff) 
+{
+	struct usb_dibusb *dib = dvbdmxfeed->demux->priv;
+	int newfeedcount;
+	
+	if (dib == NULL)
+		return -ENODEV;
+
+	newfeedcount = dib->feedcount + (onoff ? 1 : -1);
+
+	/* 
+	 * stop feed before setting a new pid if there will be no pid anymore 
+	 */
+//	if ((dib->dibdev->parm->firmware_bug && dib->feedcount) || 
+	if (newfeedcount == 0) {
+		deb_ts("stop feeding\n");
+		if (dib->xfer_ops.fifo_ctrl != NULL) {
+			if (dib->xfer_ops.fifo_ctrl(dib->fe,0)) {
+				err("error while inhibiting fifo.");
+				return -ENODEV;
+			}
+		}
+	}
+	
+	dib->feedcount = newfeedcount;
+
+	/* get a free pid from the list and activate it on the device
+	 * specific pid_filter
+	 */
+	if (dib->pid_parse)
+		dibusb_ctrl_pid(dib,dvbdmxfeed,onoff);
+
+	/* 
+	 * start the feed, either if there is the firmware bug or 
+	 * if this was the first pid to set and there is still a pid for 
+	 * reception.
+	 */
+	
+//	if ((dib->dibdev->parm->firmware_bug)
+	if (dib->feedcount == onoff && dib->feedcount > 0) {
+
+		deb_ts("controlling pid parser\n");
+		if (dib->xfer_ops.pid_parse != NULL) {
+			if (dib->xfer_ops.pid_parse(dib->fe,dib->pid_parse) < 0) {
+				err("could not handle pid_parser");
+			}
+		}
+		
+		deb_ts("start feeding\n");
+		if (dib->xfer_ops.fifo_ctrl != NULL) {
+			if (dib->xfer_ops.fifo_ctrl(dib->fe,1)) {
+				err("error while enabling fifo.");
+				return -ENODEV;
+			}
+		}
+		dibusb_streaming(dib,1);
+	}
+	return 0;
+}
+
+static int dibusb_start_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	deb_ts("start pid: 0x%04x, feedtype: %d\n", dvbdmxfeed->pid,dvbdmxfeed->type);
+	return dibusb_ctrl_feed(dvbdmxfeed,1);
+}
+
+static int dibusb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
+{
+	deb_ts("stop pid: 0x%04x, feedtype: %d\n", dvbdmxfeed->pid, dvbdmxfeed->type);
+	return dibusb_ctrl_feed(dvbdmxfeed,0);
+}
+
+int dibusb_dvb_init(struct usb_dibusb *dib)
+{
+	int ret;
+
+	urb_compl_count = 0;
+
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,4)
+    if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC)) < 0) {
+#else
+    if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC , 
+			THIS_MODULE)) < 0) {
+#endif
+		deb_info("dvb_register_adapter failed: error %d", ret);
+		goto err;
+	}
+	dib->adapter->priv = dib;
+	
+/* i2c is done in dibusb_i2c_init */
+	
+	dib->demux.dmx.capabilities = DMX_TS_FILTERING | DMX_SECTION_FILTERING;
+
+	dib->demux.priv = (void *)dib;
+	/* get pidcount from demod */
+	dib->demux.feednum = dib->demux.filternum = 255;
+	dib->demux.start_feed = dibusb_start_feed;
+	dib->demux.stop_feed = dibusb_stop_feed;
+	dib->demux.write_to_decoder = NULL;
+	if ((ret = dvb_dmx_init(&dib->demux)) < 0) {
+		err("dvb_dmx_init failed: error %d",ret);
+		goto err_dmx;
+	}
+
+	dib->dmxdev.filternum = dib->demux.filternum;
+	dib->dmxdev.demux = &dib->demux.dmx;
+	dib->dmxdev.capabilities = 0;
+	if ((ret = dvb_dmxdev_init(&dib->dmxdev, dib->adapter)) < 0) {
+		err("dvb_dmxdev_init failed: error %d",ret);
+		goto err_dmx_dev;
+	}
+
+	dvb_net_init(dib->adapter, &dib->dvb_net, &dib->demux.dmx);
+
+	goto success;
+err_dmx_dev:
+	dvb_dmx_release(&dib->demux);
+err_dmx:
+	dvb_unregister_adapter(dib->adapter);
+err:
+	return ret;
+success:
+	dib->init_state |= DIBUSB_STATE_DVB;
+	return 0;
+}
+
+int dibusb_dvb_exit(struct usb_dibusb *dib)
+{
+	if (dib->init_state & DIBUSB_STATE_DVB) {
+		dib->init_state &= ~DIBUSB_STATE_DVB;
+		deb_info("unregistering DVB part\n");
+		dvb_net_release(&dib->dvb_net);
+		dib->demux.dmx.close(&dib->demux.dmx);
+		dvb_dmxdev_release(&dib->dmxdev);
+		dvb_dmx_release(&dib->demux);
+		dvb_unregister_adapter(dib->adapter);
+	}
+	return 0;
+}
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-01-13 14:24:12.000000000 +0100
@@ -0,0 +1,598 @@
+/*
+ * dvb-dibusb-fe-i2c.c is part of the driver for mobile USB Budget DVB-T devices 
+ * based on reference design made by DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * see dvb-dibusb-core.c for more copyright details.
+ *
+ * This file contains functions for attaching, initializing of an appropriate
+ * demodulator/frontend. I2C-stuff is also located here.
+ * 
+ */
+#include "dvb-dibusb.h"
+
+#include <linux/usb.h>
+
+int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr, 
+		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
+{
+	u8 sndbuf[wlen+4]; /* lead(1) devaddr,direction(1) addr(2) data(wlen) (len(2) (when reading)) */
+	/* write only ? */
+	int wo = (rbuf == NULL || rlen == 0), 
+		len = 2 + wlen + (wo ? 0 : 2);
+	
+	sndbuf[0] = wo ? DIBUSB_REQ_I2C_WRITE : DIBUSB_REQ_I2C_READ;
+	sndbuf[1] = (addr << 1) | (wo ? 0 : 1);
+
+	memcpy(&sndbuf[2],wbuf,wlen);
+	
+	if (!wo) {
+		sndbuf[wlen+2] = (rlen >> 8) & 0xff;
+		sndbuf[wlen+3] = rlen & 0xff;
+	}
+	
+	return dibusb_readwrite_usb(dib,sndbuf,len,rbuf,rlen);
+}
+
+/*
+ * I2C master xfer function
+ */
+static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)
+{
+	struct usb_dibusb *dib = i2c_get_adapdata(adap);
+	int i;
+
+	if (down_interruptible(&dib->i2c_sem) < 0) 
+		return -EAGAIN;
+
+	if (num > 2)
+		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
+	
+	for (i = 0; i < num; i++) {
+		/* write/read request */
+		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
+			if (dibusb_i2c_msg(dib, msg[i].addr, msg[i].buf,msg[i].len,
+						msg[i+1].buf,msg[i+1].len) < 0)
+				break;
+			i++;
+		} else 
+			if (dibusb_i2c_msg(dib, msg[i].addr, msg[i].buf,msg[i].len,NULL,0) < 0)
+				break;
+	}
+	
+	up(&dib->i2c_sem);
+	return i;	
+}
+
+static u32 dibusb_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm dibusb_algo = {
+	.name			= "DiBcom USB i2c algorithm",
+	.id				= I2C_ALGO_BIT,
+	.master_xfer	= dibusb_i2c_xfer,
+	.functionality	= dibusb_i2c_func,
+};
+
+static int dibusb_general_demod_init(struct dvb_frontend *fe);
+static u8 dibusb_general_pll_addr(struct dvb_frontend *fe);
+static int dibusb_general_pll_init(struct dvb_frontend *fe, u8 pll_buf[5]);
+static int dibusb_general_pll_set(struct dvb_frontend *fe, 
+		struct dvb_frontend_parameters* params, u8 pll_buf[5]);
+
+static struct mt352_config mt352_hanftek_umt_010_config = {
+	.demod_address = 0x1e,
+	.demod_init = dibusb_general_demod_init,
+   	.pll_set = dibusb_general_pll_set,
+};
+
+static int dibusb_tuner_quirk(struct usb_dibusb *dib) 
+{
+	switch (dib->dibdev->dev_cl->id) {
+		case DIBUSB1_1: /* some these device have the ENV77H11D5 and some the THOMSON CABLE */
+		case DIBUSB1_1_AN2235: { /* actually its this device, but in warm state they are indistinguishable */
+			struct dibusb_tuner *t;
+			u8 b[2] = { 0,0 } ,b2[1];
+			struct i2c_msg msg[2] = {
+				{ .flags = 0, .buf = b, .len = 2 },
+				{ .flags = I2C_M_RD, .buf = b2, .len = 1},
+			};
+			
+			t = &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5];
+			
+			msg[0].addr = msg[1].addr = t->pll_addr;
+		
+			if (dib->xfer_ops.tuner_pass_ctrl != NULL)
+				dib->xfer_ops.tuner_pass_ctrl(dib->fe,1,t->pll_addr);
+			dibusb_i2c_xfer(&dib->i2c_adap,msg,2);
+			if (dib->xfer_ops.tuner_pass_ctrl != NULL)
+				dib->xfer_ops.tuner_pass_ctrl(dib->fe,0,t->pll_addr);
+
+			if (b2[0] == 0xfe)
+				info("this device has the Thomson Cable onboard. Which is default.");
+			else {
+				dib->tuner = t;
+				info("this device has the Panasonic ENV77H11D5 onboard.");
+			}
+			break;	
+		}
+		default:
+			break;
+	}
+	return 0;
+}
+
+/* there is a ugly pid_filter in the firmware of the umt devices, it is accessible 
+ * by i2c address 0x8. Don't know how to deactivate it and how many rows it has.
+ */
+static int dibusb_umt_pid_control(struct dvb_frontend *fe, int index, int pid, int onoff)
+{
+	struct usb_dibusb *dib = fe->dvb->priv;
+	u8 b[3];
+	b[0] = index;
+	if (onoff) {
+		b[1] = (pid >> 8) & 0xff;
+		b[2] = pid & 0xff;
+	} else {
+		b[1] = 0;
+		b[2] = 0;
+	}
+	dibusb_i2c_msg(dib, 0x8, b, 3, NULL,0);
+	dibusb_set_streaming_mode(dib,0);
+	dibusb_set_streaming_mode(dib,1);
+	return 0;
+}
+
+int dibusb_fe_init(struct usb_dibusb* dib)
+{
+	struct dib3000_config demod_cfg;
+	int i;
+	
+	if (dib->init_state & DIBUSB_STATE_I2C) { 
+		for (i = 0; i < sizeof(dib->dibdev->dev_cl->demod->i2c_addrs) / sizeof(unsigned char) && 
+				dib->dibdev->dev_cl->demod->i2c_addrs[i] != 0; i++) {
+
+			demod_cfg.demod_address = dib->dibdev->dev_cl->demod->i2c_addrs[i];
+			demod_cfg.pll_addr = dibusb_general_pll_addr;
+			demod_cfg.pll_set = dibusb_general_pll_set;
+			demod_cfg.pll_init = dibusb_general_pll_init;
+
+			switch (dib->dibdev->dev_cl->demod->id) {
+				case DIBUSB_DIB3000MB:
+					dib->fe = dib3000mb_attach(&demod_cfg,&dib->i2c_adap,&dib->xfer_ops);
+				break;
+				case DIBUSB_DIB3000MC:
+					dib->fe = dib3000mc_attach(&demod_cfg,&dib->i2c_adap,&dib->xfer_ops);
+				break;
+				case DIBUSB_MT352:
+					mt352_hanftek_umt_010_config.demod_address = dib->dibdev->dev_cl->demod->i2c_addrs[i];
+					dib->fe = mt352_attach(&mt352_hanftek_umt_010_config, &dib->i2c_adap);
+					dib->xfer_ops.pid_ctrl = dibusb_umt_pid_control;
+				break;
+			}
+			if (dib->fe != NULL) {
+				info("found demodulator at i2c address 0x%x",dib->dibdev->dev_cl->demod->i2c_addrs[i]);
+				break;
+			}
+		}
+		if (dib->fe->ops->sleep != NULL)
+			dib->fe_sleep = dib->fe->ops->sleep;
+		dib->fe->ops->sleep = dibusb_hw_sleep;
+
+		if (dib->fe->ops->init != NULL ) 
+			dib->fe_init = dib->fe->ops->init;
+		dib->fe->ops->init = dibusb_hw_wakeup;
+	
+		/* setting the default tuner */ 
+		dib->tuner = dib->dibdev->dev_cl->tuner;
+
+		/* check which tuner is mounted on this device, in case this is unsure */
+		dibusb_tuner_quirk(dib);
+	}
+	if (dib->fe == NULL) {
+		err("A frontend driver was not found for device '%s'.",
+		       dib->dibdev->name);
+		return -ENODEV;
+	} else {
+		if (dvb_register_frontend(dib->adapter, dib->fe)) {
+			err("Frontend registration failed.");
+			if (dib->fe->ops->release)
+				dib->fe->ops->release(dib->fe);
+			dib->fe = NULL;
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+int dibusb_fe_exit(struct usb_dibusb *dib)
+{
+	if (dib->fe != NULL)
+		dvb_unregister_frontend(dib->fe);
+	return 0;
+}
+
+int dibusb_i2c_init(struct usb_dibusb *dib)
+{
+	int ret = 0;
+
+	dib->adapter->priv = dib;
+
+	strncpy(dib->i2c_adap.name,dib->dibdev->name,I2C_NAME_SIZE);
+#ifdef I2C_ADAP_CLASS_TV_DIGITAL
+	dib->i2c_adap.class = I2C_ADAP_CLASS_TV_DIGITAL,
+#else
+	dib->i2c_adap.class = I2C_CLASS_TV_DIGITAL,
+#endif
+	dib->i2c_adap.algo 		= &dibusb_algo;
+	dib->i2c_adap.algo_data = NULL;
+	dib->i2c_adap.id		= I2C_ALGO_BIT;
+	
+	i2c_set_adapdata(&dib->i2c_adap, dib);
+	
+	if ((ret = i2c_add_adapter(&dib->i2c_adap)) < 0)
+		err("could not add i2c adapter");
+	
+	dib->init_state |= DIBUSB_STATE_I2C;
+
+	return ret;
+}
+
+int dibusb_i2c_exit(struct usb_dibusb *dib)
+{
+	if (dib->init_state & DIBUSB_STATE_I2C)
+		i2c_del_adapter(&dib->i2c_adap);
+	dib->init_state &= ~DIBUSB_STATE_I2C;
+	return 0;
+}
+
+
+/* pll stuff, maybe removed soon (thx to Gerd/Andrew in advance) */
+static int thomson_cable_eu_pll_set(struct dvb_frontend_parameters *fep, u8 pllbuf[4])
+{
+	u32 tfreq = (fep->frequency + 36125000) / 62500;
+	int vu,p0,p1,p2;
+
+	if (fep->frequency > 403250000)
+		vu = 1, p2 = 1, p1 = 0, p0 = 1;
+	else if (fep->frequency > 115750000)
+		vu = 0, p2 = 1, p1 = 1, p0 = 0;
+	else if (fep->frequency > 44250000)
+		vu = 0, p2 = 0, p1 = 1, p0 = 1;
+	else
+		return -EINVAL;
+
+	pllbuf[0] = (tfreq >> 8) & 0x7f;
+	pllbuf[1] = tfreq & 0xff;
+   	pllbuf[2] = 0x8e;
+   	pllbuf[3] = (vu << 7) | (p2 << 2) | (p1 << 1) | p0;
+	return 0;
+}
+
+static int panasonic_cofdm_env57h1xd5_pll_set(struct dvb_frontend_parameters *fep, u8 pllbuf[4])
+{
+	u32 freq = fep->frequency;
+	u32 tfreq = ((freq + 36125000)*6 + 500000) / 1000000;
+	u8 TA, T210, R210, ctrl1, cp210, p4321;
+	if (freq > 858000000) {
+		err("frequency cannot be larger than 858 MHz.");
+		return -EINVAL;
+	}
+	
+	// contol data 1 : 1 | T/A=1 | T2,T1,T0 = 0,0,0 | R2,R1,R0 = 0,1,0
+	TA = 1;
+	T210 = 0;
+	R210 = 0x2;
+	ctrl1 = (1 << 7) | (TA << 6) | (T210 << 3) | R210;
+
+// ********    CHARGE PUMP CONFIG vs RF FREQUENCIES     *****************
+	if (freq < 470000000) 
+		cp210 = 2;  // VHF Low and High band ch E12 to E4 to E12
+	else if (freq < 526000000) 
+		cp210 = 4;  // UHF band Ch E21 to E27
+	else // if (freq < 862000000) 
+		cp210 = 5;  // UHF band ch E28 to E69
+
+//*********************    BW select  *******************************
+	if (freq < 153000000) 
+		p4321  = 1; // BW selected for VHF low
+	else if (freq < 470000000) 
+		p4321  = 2; // BW selected for VHF high E5 to E12
+	else // if (freq < 862000000) 
+		p4321  = 4; // BW selection for UHF E21 to E69
+
+	pllbuf[0] = (tfreq >> 8) & 0xff;
+	pllbuf[1] = (tfreq >> 0) & 0xff;
+	pllbuf[2] = 0xff & ctrl1;
+	pllbuf[3] =  (cp210 << 5) | (p4321);
+
+	return 0;
+}
+
+/*
+ *            	            7	6		5	4	3	2	1	0
+ * Address Byte             1	1		0	0	0	MA1	MA0	R/~W=0
+ *
+ * Program divider byte 1   0	n14		n13	n12	n11	n10	n9	n8
+ * Program divider byte 2	n7	n6		n5	n4	n3	n2	n1	n0
+ *
+ * Control byte 1           1	T/A=1	T2	T1	T0	R2	R1	R0
+ *                          1	T/A=0	0	0	ATC	AL2	AL1	AL0
+ * 
+ * Control byte 2           CP2	CP1		CP0	BS5	BS4	BS3	BS2	BS1
+ * 
+ * MA0/1 = programmable address bits
+ * R/~W  = read/write bit (0 for writing)
+ * N14-0 = programmable LO frequency
+ * 
+ * T/A   = test AGC bit (0 = next 6 bits AGC setting, 
+ *                       1 = next 6 bits test and reference divider ratio settings)
+ * T2-0  = test bits
+ * R2-0  = reference divider ratio and programmable frequency step
+ * ATC   = AGC current setting and time constant
+ *         ATC = 0: AGC current = 220nA, AGC time constant = 2s
+ *         ATC = 1: AGC current = 9uA, AGC time constant = 50ms
+ * AL2-0 = AGC take-over point bits
+ * CP2-0 = charge pump current
+ * BS5-1 = PMOS ports control bits;
+ *             BSn = 0 corresponding port is off, high-impedance state (at power-on)
+ *             BSn = 1 corresponding port is on
+ */
+
+
+static int panasonic_cofdm_env77h11d5_tda6650_init(struct dvb_frontend *fe, u8 pllbuf[4])
+{
+	pllbuf[0] = 0x0b;
+	pllbuf[1] = 0xf5;
+	pllbuf[2] = 0x85;
+	pllbuf[3] = 0xab;
+	return 0;
+}
+
+static int panasonic_cofdm_env77h11d5_tda6650_set (struct dvb_frontend_parameters *fep,u8 pllbuf[4])
+{
+	int tuner_frequency = 0;
+	u8 band, cp, filter;
+
+	// determine charge pump
+	tuner_frequency = fep->frequency + 36166000;
+	if (tuner_frequency < 87000000)
+		return -EINVAL;
+	else if (tuner_frequency < 130000000)
+		cp = 3;
+	else if (tuner_frequency < 160000000)
+		cp = 5;
+	else if (tuner_frequency < 200000000)
+		cp = 6;
+	else if (tuner_frequency < 290000000)
+		cp = 3;
+	else if (tuner_frequency < 420000000)
+		cp = 5;
+	else if (tuner_frequency < 480000000)
+		cp = 6;
+	else if (tuner_frequency < 620000000)
+		cp = 3;
+	else if (tuner_frequency < 830000000)
+		cp = 5;
+	else if (tuner_frequency < 895000000)
+		cp = 7;
+	else
+		return -EINVAL;
+
+	// determine band
+	if (fep->frequency < 49000000)
+		return -EINVAL;
+	else if (fep->frequency < 161000000)
+		band = 1;
+	else if (fep->frequency < 444000000)
+		band = 2;
+	else if (fep->frequency < 861000000)
+		band = 4;
+	else
+		return -EINVAL;
+
+	// setup PLL filter
+	switch (fep->u.ofdm.bandwidth) {
+		case BANDWIDTH_6_MHZ:
+		case BANDWIDTH_7_MHZ:
+			filter = 0;
+			break;
+		case BANDWIDTH_8_MHZ:
+			filter = 1;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	// calculate divisor
+	// ((36166000+((1000000/6)/2)) + Finput)/(1000000/6)
+	tuner_frequency = (((fep->frequency / 1000) * 6) + 217496) / 1000;
+
+	// setup tuner buffer
+	pllbuf[0] = (tuner_frequency >> 8) & 0x7f;
+	pllbuf[1] = tuner_frequency & 0xff;
+	pllbuf[2] = 0xca;
+	pllbuf[3] = (cp << 5) | (filter << 3) | band;
+	return 0;
+}
+
+/*
+ *            	            7	6	5	4	3	2	1	0
+ * Address Byte             1	1	0	0	0	MA1	MA0	R/~W=0
+ *
+ * Program divider byte 1   0	n14	n13	n12	n11	n10	n9	n8
+ * Program divider byte 2	n7	n6	n5	n4	n3	n2	n1	n0
+ *
+ * Control byte             1	CP	T2	T1	T0	RSA	RSB	OS
+ * 
+ * Band Switch byte         X	X	X	P4	P3	P2	P1	P0
+ *
+ * Auxiliary byte           ATC	AL2	AL1	AL0	0	0	0	0
+ *
+ * Address: MA1	MA0	Address
+ *          0	0	c0
+ *          0	1	c2 (always valid)
+ *          1	0	c4
+ *          1	1	c6
+ *
+ *
+ * 
+ */
+
+static int lg_tdtp_e102p_tua6034(struct dvb_frontend_parameters* fep, u8 pllbuf[4]) 
+{
+	u32 div;
+	u8 p3210, p4;
+
+#define TUNER_MUL 62500
+
+	div = (fep->frequency + 36125000 + TUNER_MUL / 2) / TUNER_MUL;
+
+	if (fep->frequency < 174500000) 
+		p3210 = 1; // not supported by the tdtp_e102p
+	else if (fep->frequency < 230000000) // VHF
+		p3210 = 2;
+	else 
+		p3210 = 4;
+
+	if (fep->u.ofdm.bandwidth == BANDWIDTH_7_MHZ)
+		p4 = 0;
+	else 
+		p4 = 1;
+		
+	pllbuf[0] = (div >> 8) & 0x7f;
+	pllbuf[1] = div & 0xff;
+	pllbuf[2] = 0xce;
+	pllbuf[3] = (p4 << 4) | p3210;
+
+	return 0;
+}
+
+static int lg_tdtp_e102p_mt352_demod_init(struct dvb_frontend *fe)
+{
+	static u8 mt352_clock_config[] = { 0x89, 0xb0, 0x2d };
+	static u8 mt352_reset[] = { 0x50, 0x80 };
+	static u8 mt352_mclk_ratio[] = { 0x8b, 0x00 };
+	static u8 mt352_adc_ctl_1_cfg[] = { 0x8E, 0x40 };
+	static u8 mt352_agc_cfg[] = { 0x67, 0x14, 0x22 };
+	static u8 mt352_sec_agc_cfg[] = { 0x69, 0x00, 0xff, 0xff, 0x00, 0xff, 0x00, 0x40, 0x40 };
+
+	static u8 mt352_unk [] = { 0xb5, 0x7a };
+
+	static u8 mt352_acq_ctl[] = { 0x53, 0x5f };
+	static u8 mt352_input_freq_1[] = { 0x56, 0xf1, 0x05 };
+	
+//	static u8 mt352_capt_range_cfg[] = { 0x75, 0x32 };
+
+	mt352_write(fe, mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(2000);
+	mt352_write(fe, mt352_reset, sizeof(mt352_reset));
+	mt352_write(fe, mt352_mclk_ratio, sizeof(mt352_mclk_ratio));
+	
+	mt352_write(fe, mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+	mt352_write(fe, mt352_agc_cfg, sizeof(mt352_agc_cfg));
+
+	mt352_write(fe, mt352_sec_agc_cfg, sizeof(mt352_sec_agc_cfg));
+
+	mt352_write(fe, mt352_unk, sizeof(mt352_unk));
+	
+	mt352_write(fe, mt352_acq_ctl, sizeof(mt352_acq_ctl));
+	mt352_write(fe, mt352_input_freq_1, sizeof(mt352_input_freq_1));
+	
+//	mt352_write(fe, mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
+
+	return 0;
+}
+
+static int dibusb_general_demod_init(struct dvb_frontend *fe)
+{
+	struct usb_dibusb* dib = (struct usb_dibusb*) fe->dvb->priv;
+	switch (dib->dibdev->dev_cl->id) {
+		case UMT2_0:
+			return lg_tdtp_e102p_mt352_demod_init(fe);
+		default: /* other device classes do not have device specific demod inits */
+			break;
+	}
+	return 0;
+}
+
+static u8 dibusb_general_pll_addr(struct dvb_frontend *fe)
+{
+	struct usb_dibusb* dib = (struct usb_dibusb*) fe->dvb->priv;
+	return dib->tuner->pll_addr;
+}
+
+static int dibusb_pll_i2c_helper(struct usb_dibusb *dib, u8 pll_buf[5], u8 buf[4])
+{
+	if (pll_buf == NULL) {
+		struct i2c_msg msg = { 
+			.addr = dib->tuner->pll_addr, 
+			.flags = 0, 
+			.buf = buf, 
+			.len = sizeof(buf) 
+		};
+		if (i2c_transfer (&dib->i2c_adap, &msg, 1) != 1)
+			return -EIO;
+		msleep(1);
+	} else {
+		pll_buf[0] = dib->tuner->pll_addr << 1;
+		memcpy(&pll_buf[1],buf,4);
+	}
+
+	return 0;
+}
+
+static int dibusb_general_pll_init(struct dvb_frontend *fe, 
+		u8 pll_buf[5])
+{
+	struct usb_dibusb* dib = (struct usb_dibusb*) fe->dvb->priv;
+	u8 buf[4];
+	int ret=0;
+	switch (dib->tuner->id) {
+		case DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5:
+			ret = panasonic_cofdm_env77h11d5_tda6650_init(fe,buf);
+			break;
+		default:
+			break;
+	}
+	
+	if (ret)
+		return ret;
+
+	return dibusb_pll_i2c_helper(dib,pll_buf,buf);
+}
+
+static int dibusb_general_pll_set(struct dvb_frontend *fe, 
+		struct dvb_frontend_parameters *fep, u8 pll_buf[5])
+{
+	struct usb_dibusb* dib = (struct usb_dibusb*) fe->dvb->priv;
+	u8 buf[4];
+	int ret=0;
+
+	switch (dib->tuner->id) {
+		case DIBUSB_TUNER_CABLE_THOMSON: 
+			ret = thomson_cable_eu_pll_set(fep, buf); 
+			break;
+		case DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5:
+			ret = panasonic_cofdm_env57h1xd5_pll_set(fep, buf);
+			break;
+		case DIBUSB_TUNER_CABLE_LG_TDTP_E102P:
+			ret = lg_tdtp_e102p_tua6034(fep, buf); 
+			break;
+		case DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5:
+			ret = panasonic_cofdm_env77h11d5_tda6650_set(fep,buf);
+			break;
+		default:
+			warn("no pll programming routine found for tuner %d.\n",dib->tuner->id);
+			ret = -ENODEV;
+			break;
+	}
+	
+	if (ret)
+		return ret;
+	
+	return dibusb_pll_i2c_helper(dib,pll_buf,buf);
+}
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c	2005-01-07 12:49:57.000000000 +0100
@@ -0,0 +1,85 @@
+/*
+ * dvb-dibusb-firmware.c is part of the driver for mobile USB Budget DVB-T devices 
+ * based on reference design made by DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * see dvb-dibusb-core.c for more copyright details.
+ *
+ * This file contains functions for downloading the firmware to the device.
+ */
+#include "dvb-dibusb.h"
+
+#include <linux/firmware.h>
+#include <linux/usb.h>
+
+/*
+ * load a firmware packet to the device 
+ */
+static int dibusb_writemem(struct usb_device *udev,u16 addr,u8 *data, u8 len)
+{
+	return usb_control_msg(udev, usb_sndctrlpipe(udev,0),
+			0xa0, USB_TYPE_VENDOR, addr, 0x00, data, len, 5*HZ);
+}
+
+int dibusb_loadfirmware(struct usb_device *udev, struct dibusb_usb_device *dibdev)
+{
+	const struct firmware *fw = NULL;
+	u16 addr;
+	u8 *b,*p;
+	int ret = 0,i;
+	
+	if ((ret = request_firmware(&fw, dibdev->dev_cl->firmware, &udev->dev)) != 0) {
+		err("did not find a valid firmware file. (%s) "
+			"Please see linux/Documentation/dvb/ for more details on firmware-problems.",
+			dibdev->dev_cl->firmware);
+		return ret;
+	}
+	
+	p = kmalloc(fw->size,GFP_KERNEL);	
+	if (p != NULL) {
+		u8 reset;
+		/*
+		 * you cannot use the fw->data as buffer for 
+		 * usb_control_msg, a new buffer has to be
+		 * created
+		 */
+		memcpy(p,fw->data,fw->size);
+
+		/* stop the CPU */
+		reset = 1;
+		if ((ret = dibusb_writemem(udev,dibdev->dev_cl->usb_ctrl->cpu_cs_register,&reset,1)) != 1) 
+			err("could not stop the USB controller CPU.");
+		for(i = 0; p[i+3] == 0 && i < fw->size; ) { 
+			b = (u8 *) &p[i];
+			addr = *((u16 *) &b[1]);
+
+			ret = dibusb_writemem(udev,addr,&b[4],b[0]);
+		
+			if (ret != b[0]) {
+				err("error while transferring firmware "
+					"(transferred size: %d, block size: %d)",
+					ret,b[0]);
+				ret = -EINVAL;
+				break;
+			}
+			i += 5 + b[0];
+		}
+		/* length in ret */
+		if (ret > 0)
+			ret = 0;
+		/* restart the CPU */
+		reset = 0;
+		if (ret || dibusb_writemem(udev,dibdev->dev_cl->usb_ctrl->cpu_cs_register,&reset,1) != 1) {
+			err("could not restart the USB controller CPU.");
+			ret = -EINVAL;
+		}
+
+		kfree(p);
+	} else { 
+		ret = -ENOMEM;
+	}
+	release_firmware(fw);
+
+	return ret;
+}
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb.h linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb.h
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-01-20 19:54:06.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-01-20 19:56:37.000000000 +0100
@@ -1,15 +1,14 @@
 /*
  * dvb-dibusb.h
  *
- * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License as
  *	published by the Free Software Foundation, version 2.
  *
- * for more information see dvb-dibusb.c .
+ * for more information see dvb-dibusb-core.c .
  */
-
 #ifndef __DVB_DIBUSB_H__
 #define __DVB_DIBUSB_H__
 
@@ -13,281 +12,160 @@
 #ifndef __DVB_DIBUSB_H__
 #define __DVB_DIBUSB_H__
 
+#include <linux/input.h>
+#include <linux/config.h>
+#include <linux/usb.h>
+
+#include "dvb_frontend.h"
+#include "dvb_demux.h"
+#include "dvb_net.h"
+#include "dmxdev.h"
+
 #include "dib3000.h"
+#include "mt352.h"
+
+/* debug */
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+#define dprintk(level,args...) \
+	    do { if ((debug & level)) { printk(args); } } while (0)
+
+#define debug_dump(b,l) if (debug) {\
+	int i; deb_xfer("%s: %d > ",__FUNCTION__,l); \
+	for (i = 0; i < l; i++) deb_xfer("%02x ", b[i]); \
+	deb_xfer("\n");\
+}
+
+/* module parameters - declared in -core.c */
+extern int debug;
+
+#else
+#define dprintk(args...)
+#define debug_dump(b,l)
+#endif
+
+/* Version information */
+#define DRIVER_VERSION "0.3"
+#define DRIVER_DESC "Driver for DiBcom based USB Budget DVB-T device"
+#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
+
+/* module parameters - declared in -core.c */
+extern int pid_parse;
+extern int rc_query_interval;
+
+#define deb_info(args...) dprintk(0x01,args)
+#define deb_xfer(args...) dprintk(0x02,args)
+#define deb_alot(args...) dprintk(0x04,args)
+#define deb_ts(args...)   dprintk(0x08,args)
+#define deb_err(args...)  dprintk(0x10,args)
+#define deb_rc(args...)   dprintk(0x20,args)
+
+/* generic log methods - taken from usb.h */
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
+
+struct dibusb_usb_controller {
+	const char *name;       /* name of the usb controller */
+	u16 cpu_cs_register;    /* needs to be restarted, when the firmware has been downloaded. */
+};
 
 typedef enum {
 	DIBUSB1_1 = 0,
-	DIBUSB2_0,
 	DIBUSB1_1_AN2235,
-} dibusb_type;
+	DIBUSB2_0,
+	UMT2_0,
+} dibusb_class_t;
 
-static const char * dibusb_fw_filenames1_1[] = {
-	"dvb-dibusb-5.0.0.11.fw"
-};
+typedef enum {
+	DIBUSB_TUNER_CABLE_THOMSON = 0,
+	DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5,
+	DIBUSB_TUNER_CABLE_LG_TDTP_E102P,
+	DIBUSB_TUNER_COFDM_PANASONIC_ENV77H11D5,
+} dibusb_tuner_t;
 
-static const char * dibusb_fw_filenames1_1_an2235[] = {
-	"dvb-dibusb-an2235-1.fw"
-};
+typedef enum {
+	DIBUSB_DIB3000MB = 0,
+	DIBUSB_DIB3000MC,
+	DIBUSB_MT352,
+} dibusb_demodulator_t;
 
-static const char * dibusb_fw_filenames2_0[] = {
-	"dvb-dibusb-6.0.0.5.fw"
-};
+typedef enum {
+	DIBUSB_RC_NO = 0,
+	DIBUSB_RC_NEC_PROTOCOL = 1,
+} dibusb_remote_t;
 
-struct dibusb_device_parameter {
-	dibusb_type type;
-	u8 demod_addr;
-	const char **fw_filenames;
-	const char *usb_controller;
-	u16 usb_cpu_csreg;
-
-	int num_urbs;
-	int urb_buf_size;
-	int default_size;
-	int firmware_bug;
-
-	int cmd_pipe;
-	int result_pipe;
-	int data_pipe;
-};
+struct dibusb_tuner {
+	dibusb_tuner_t id;
 
-static struct dibusb_device_parameter dibusb_dev_parm[3] = {
-	{	.type = DIBUSB1_1,
-		.demod_addr = 0x10,
-		.fw_filenames = dibusb_fw_filenames1_1,
-		.usb_controller = "Cypress AN2135",
-		.usb_cpu_csreg = 0x7f92,
-
-		.num_urbs = 3,
-		.urb_buf_size = 4096,
-		.default_size = 188*21,
-		.firmware_bug = 1,
-
-		.cmd_pipe = 0x01,
-		.result_pipe = 0x81,
-		.data_pipe = 0x82,
-	},
-	{	.type = DIBUSB2_0,
-		.demod_addr = 0x18,
-		.fw_filenames = dibusb_fw_filenames2_0,
-		.usb_controller = "Cypress FX2",
-		.usb_cpu_csreg = 0xe600,
-
-		.num_urbs = 3,
-		.urb_buf_size = 40960,
-		.default_size = 188*210,
-		.firmware_bug = 0,
-
-		.cmd_pipe = 0x01,
-		.result_pipe = 0x81,
-		.data_pipe = 0x86,
-	},
-	{	.type = DIBUSB1_1_AN2235,
-		.demod_addr = 0x10,
-		.fw_filenames = dibusb_fw_filenames1_1_an2235,
-		.usb_controller = "Cypress CY7C64613 (AN2235)",
-		.usb_cpu_csreg = 0x7f92,
-
-		.num_urbs = 3,
-		.urb_buf_size = 4096,
-		.default_size = 188*21,
-		.firmware_bug = 1,
-
-		.cmd_pipe = 0x01,
-		.result_pipe = 0x81,
-		.data_pipe = 0x82,
-	}
+	u8 pll_addr;       /* tuner i2c address */
 };
+extern struct dibusb_tuner dibusb_tuner[];
 
-struct dibusb_device {
-	const char *name;
-	u16 cold_product_id;
-	u16 warm_product_id;
-	struct dibusb_device_parameter *parm;
-};
+#define DIBUSB_POSSIBLE_I2C_ADDR_NUM 4
+struct dibusb_demod {
+	dibusb_demodulator_t id;
 
-/* Vendor IDs */
-#define USB_VID_ANCHOR						0x0547
-#define USB_VID_AVERMEDIA					0x14aa
-#define USB_VID_COMPRO						0x185b
-#define USB_VID_COMPRO_UNK					0x145f
-#define USB_VID_CYPRESS						0x04b4
-#define USB_VID_DIBCOM						0x10b8
-#define USB_VID_EMPIA						0xeb1a
-#define USB_VID_GRANDTEC					0x5032
-#define USB_VID_HYPER_PALTEK				0x1025
-#define USB_VID_IMC_NETWORKS				0x13d3
-#define USB_VID_TWINHAN						0x1822
-#define USB_VID_ULTIMA_ELECTRONIC			0x05d8
-
-/* Product IDs */
-#define USB_PID_AVERMEDIA_DVBT_USB_COLD		0x0001
-#define USB_PID_AVERMEDIA_DVBT_USB_WARM		0x0002
-#define USB_PID_COMPRO_DVBU2000_COLD		0xd000
-#define USB_PID_COMPRO_DVBU2000_WARM		0xd001
-#define USB_PID_COMPRO_DVBU2000_UNK_COLD	0x010c
-#define USB_PID_COMPRO_DVBU2000_UNK_WARM	0x010d
-#define USB_PID_DIBCOM_MOD3000_COLD			0x0bb8
-#define USB_PID_DIBCOM_MOD3000_WARM			0x0bb9
-#define USB_PID_DIBCOM_MOD3001_COLD			0x0bc6
-#define USB_PID_DIBCOM_MOD3001_WARM			0x0bc7
-#define USB_PID_GRANDTEC_DVBT_USB_COLD		0x0fa0
-#define USB_PID_GRANDTEC_DVBT_USB_WARM		0x0fa1
-#define USB_PID_KWORLD_VSTREAM_COLD			0x17de
-#define USB_PID_KWORLD_VSTREAM_WARM			0x17df
-#define USB_PID_TWINHAN_VP7041_COLD			0x3201
-#define USB_PID_TWINHAN_VP7041_WARM			0x3202
-#define USB_PID_ULTIMA_TVBOX_COLD			0x8105
-#define USB_PID_ULTIMA_TVBOX_WARM			0x8106
-#define USB_PID_ULTIMA_TVBOX_AN2235_COLD	0x8107
-#define USB_PID_ULTIMA_TVBOX_AN2235_WARM	0x8108
-#define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD	0x2235
-#define USB_PID_ULTIMA_TVBOX_USB2_COLD		0x8109
-#define USB_PID_ULTIMA_TVBOX_USB2_FX_COLD	0x8613
-#define USB_PID_ULTIMA_TVBOX_USB2_FX_WARM	0x1002
-#define USB_PID_UNK_HYPER_PALTEK_COLD		0x005e
-#define USB_PID_UNK_HYPER_PALTEK_WARM		0x005f
-#define USB_PID_YAKUMO_DTT200U_COLD			0x0201
-#define USB_PID_YAKUMO_DTT200U_WARM			0x0301
-
-#define DIBUSB_SUPPORTED_DEVICES	15
-
-/* USB Driver stuff */
-static struct dibusb_device dibusb_devices[DIBUSB_SUPPORTED_DEVICES] = {
-	{	.name = "TwinhanDTV USB1.1 / Magic Box / HAMA USB1.1 DVB-T device",
-		.cold_product_id = USB_PID_TWINHAN_VP7041_COLD,
-		.warm_product_id = USB_PID_TWINHAN_VP7041_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "KWorld V-Stream XPERT DTV - DVB-T USB1.1",
-		.cold_product_id = USB_PID_KWORLD_VSTREAM_COLD,
-		.warm_product_id = USB_PID_KWORLD_VSTREAM_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Grandtec USB1.1 DVB-T/DiBcom USB1.1 DVB-T reference design (MOD3000)",
-		.cold_product_id = USB_PID_DIBCOM_MOD3000_COLD,
-		.warm_product_id = USB_PID_DIBCOM_MOD3000_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Artec T1 USB1.1 TVBOX with AN2135",
-		.cold_product_id = USB_PID_ULTIMA_TVBOX_COLD,
-		.warm_product_id = USB_PID_ULTIMA_TVBOX_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Artec T1 USB1.1 TVBOX with AN2235",
-		.cold_product_id = USB_PID_ULTIMA_TVBOX_AN2235_COLD,
-		.warm_product_id = USB_PID_ULTIMA_TVBOX_AN2235_WARM,
-		.parm = &dibusb_dev_parm[2],
-	},
-	{	.name = "Artec T1 USB1.1 TVBOX with AN2235 (misdesigned)",
-		.cold_product_id = USB_PID_ULTIMA_TVBOX_ANCHOR_COLD,
-		.warm_product_id = 0, /* undefined, this design becomes USB_PID_DIBCOM_MOD3000_WARM in warm state */
-		.parm = &dibusb_dev_parm[2],
-	},
-	{	.name = "Artec T1 USB2.0 TVBOX (please report the warm ID)",
-		.cold_product_id = USB_PID_ULTIMA_TVBOX_USB2_COLD,
-		.warm_product_id = 0, /* don't know, it is most likely that the device will get another USB ID in warm state */
-		.parm = &dibusb_dev_parm[1],
-	},
-	{	.name = "Artec T1 USB2.0 TVBOX with FX2 IDs (misdesigned, please report the warm ID)",
-		.cold_product_id = USB_PID_ULTIMA_TVBOX_USB2_FX_COLD,
-		.warm_product_id = USB_PID_ULTIMA_TVBOX_USB2_FX_WARM, /* undefined, it could be that the device will get another USB ID in warm state */
-		.parm = &dibusb_dev_parm[1],
-	},
-	{	.name = "Compro Videomate DVB-U2000 - DVB-T USB1.1",
-		.cold_product_id = USB_PID_COMPRO_DVBU2000_COLD,
-		.warm_product_id = USB_PID_COMPRO_DVBU2000_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Compro Videomate DVB-U2000 - DVB-T USB1.1 (really ?? please report the name!)",
-		.cold_product_id = USB_PID_COMPRO_DVBU2000_UNK_COLD,
-		.warm_product_id = USB_PID_COMPRO_DVBU2000_UNK_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Unkown USB1.1 DVB-T device ???? please report the name to the author",
-		.cold_product_id = USB_PID_UNK_HYPER_PALTEK_COLD,
-		.warm_product_id = USB_PID_UNK_HYPER_PALTEK_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "DiBcom USB2.0 DVB-T reference design (MOD3000P)",
-		.cold_product_id = USB_PID_DIBCOM_MOD3001_COLD,
-		.warm_product_id = USB_PID_DIBCOM_MOD3001_WARM,
-		.parm = &dibusb_dev_parm[1],
-	},
-	{	.name = "Grandtec DVB-T USB1.1",
-		.cold_product_id = USB_PID_GRANDTEC_DVBT_USB_COLD,
-		.warm_product_id = USB_PID_GRANDTEC_DVBT_USB_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Avermedia AverTV DVBT USB1.1",
-		.cold_product_id = USB_PID_AVERMEDIA_DVBT_USB_COLD,
-		.warm_product_id = USB_PID_AVERMEDIA_DVBT_USB_WARM,
-		.parm = &dibusb_dev_parm[0],
-	},
-	{	.name = "Yakumo DVB-T mobile USB2.0",
-		.cold_product_id = USB_PID_YAKUMO_DTT200U_COLD,
-		.warm_product_id = USB_PID_YAKUMO_DTT200U_WARM,
-		.parm = &dibusb_dev_parm[1],
-	}
+	int pid_filter_count;                       /* counter of the internal pid_filter */
+	u8 i2c_addrs[DIBUSB_POSSIBLE_I2C_ADDR_NUM]; /* list of possible i2c addresses of the demod */
 };
 
-/* USB Driver stuff */
-/* table of devices that work with this driver */
-static struct usb_device_id dibusb_table [] = {
-	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_AVERMEDIA_DVBT_USB_COLD)},
-	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_AVERMEDIA_DVBT_USB_WARM)},
-	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
-	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
-	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_COLD) },
-	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_WARM) },
-	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_COLD) },
-	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_WARM) },
-	{ USB_DEVICE(USB_VID_EMPIA,			USB_PID_KWORLD_VSTREAM_COLD) },
-	{ USB_DEVICE(USB_VID_EMPIA,			USB_PID_KWORLD_VSTREAM_WARM) },
-	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_COLD) },
-	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_WARM) },
-	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_COLD) },
-	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_WARM) },
-	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_COLD) },
-	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_WARM) },
-	{ USB_DEVICE(USB_VID_IMC_NETWORKS,	USB_PID_TWINHAN_VP7041_COLD) },
-	{ USB_DEVICE(USB_VID_IMC_NETWORKS,	USB_PID_TWINHAN_VP7041_WARM) },
-	{ USB_DEVICE(USB_VID_TWINHAN, 		USB_PID_TWINHAN_VP7041_COLD) },
-	{ USB_DEVICE(USB_VID_TWINHAN, 		USB_PID_TWINHAN_VP7041_WARM) },
-	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_COLD) },
-	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_WARM) },
-	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
-	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
-	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_COLD) },
-	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_WARM) },
-	{ USB_DEVICE(USB_PID_COMPRO_DVBU2000_UNK_COLD, USB_VID_COMPRO_UNK) },
-	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_COLD) },
+#define DIBUSB_MAX_TUNER_NUM 2
+struct dibusb_device_class {
+	dibusb_class_t id;
 
-/*
- * activate the following define when you have one of the devices and want to
- * build it from build-2.6 in dvb-kernel
- */
-// #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
-#ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
-	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
-	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
-	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
-#endif
-	{ }                 /* Terminating entry */
+	const struct dibusb_usb_controller *usb_ctrl; /* usb controller */
+	const char *firmware;                         /* valid firmware filenames */
+
+	int pipe_cmd;                                 /* command pipe (read/write) */
+	int pipe_data;                                /* data pipe */
+	
+	int urb_count;                                /* number of data URBs to be submitted */
+	int urb_buffer_size;                          /* the size of the buffer for each URB */
+
+	dibusb_remote_t remote_type;                  /* does this device have a ir-receiver */
+
+	struct dibusb_demod *demod;                   /* which demodulator is mount */
+	struct dibusb_tuner *tuner;                   /* which tuner can be found here */
 };
 
-MODULE_DEVICE_TABLE (usb, dibusb_table);
+#define DIBUSB_ID_MAX_NUM 15
+struct dibusb_usb_device {
+	const char *name;                                 /* real name of the box */
+	struct dibusb_device_class *dev_cl;               /* which dibusb_device_class is this device part of */
 
-#define DIBUSB_I2C_TIMEOUT 				HZ*5
+	struct usb_device_id *cold_ids[DIBUSB_ID_MAX_NUM]; /* list of USB ids when this device is at pre firmware state */
+	struct usb_device_id *warm_ids[DIBUSB_ID_MAX_NUM]; /* list of USB ids when this device is at post firmware state */
+};
+
+/* a PID for the pid_filter list, when in use */
+struct dibusb_pid
+{
+	int index;
+	u16 pid;
+	int active;
+};
 
 struct usb_dibusb {
 	/* usb */
 	struct usb_device * udev;
 
-	struct dibusb_device * dibdev;
+	struct dibusb_usb_device * dibdev;
+
+#define DIBUSB_STATE_INIT       0x000
+#define DIBUSB_STATE_URB_LIST   0x001
+#define DIBUSB_STATE_URB_BUF    0x002
+#define DIBUSB_STATE_URB_SUBMIT 0x004 
+#define DIBUSB_STATE_DVB        0x008
+#define DIBUSB_STATE_I2C        0x010
+#define DIBUSB_STATE_REMOTE		0x020
+#define DIBUSB_STATE_PIDLIST    0x040
+	int init_state;
 
 	int feedcount;
 	int pid_parse;
-	struct dib3000_xfer_ops xfer_ops;
+	struct dib_fe_xfer_ops xfer_ops;
+
+	struct dibusb_tuner *tuner;
 
 	struct urb **urb_list;
 	u8 *buffer;
@@ -295,49 +173,137 @@
 
 	/* I2C */
 	struct i2c_adapter i2c_adap;
-	struct i2c_client i2c_client;
 
 	/* locking */
 	struct semaphore usb_sem;
 	struct semaphore i2c_sem;
 
+	/* pid filtering */
+	spinlock_t pid_list_lock;
+	struct dibusb_pid *pid_list;
+	
 	/* dvb */
-	int dvb_is_ready;
 	struct dvb_adapter *adapter;
 	struct dmxdev dmxdev;
 	struct dvb_demux demux;
 	struct dvb_net dvb_net;
 	struct dvb_frontend* fe;
 
+	int (*fe_sleep) (struct dvb_frontend *);
+	int (*fe_init) (struct dvb_frontend *);
+
 	/* remote control */
 	struct input_dev rc_input_dev;
 	struct work_struct rc_query_work;
 	int rc_input_event;
 };
 
+/* commonly used functions in the separated files */
+
+/* dvb-dibusb-firmware.c */
+int dibusb_loadfirmware(struct usb_device *udev, struct dibusb_usb_device *dibdev);
+
+/* dvb-dibusb-remote.c */
+int dibusb_remote_exit(struct usb_dibusb *dib);
+int dibusb_remote_init(struct usb_dibusb *dib);
+
+/* dvb-dibusb-fe-i2c.c */
+int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr, 
+		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen);
+int dibusb_fe_init(struct usb_dibusb* dib);
+int dibusb_fe_exit(struct usb_dibusb *dib);
+int dibusb_i2c_init(struct usb_dibusb *dib);
+int dibusb_i2c_exit(struct usb_dibusb *dib);
+
+/* dvb-dibusb-dvb.c */
+void dibusb_urb_complete(struct urb *urb, struct pt_regs *ptregs);
+int dibusb_dvb_init(struct usb_dibusb *dib);
+int dibusb_dvb_exit(struct usb_dibusb *dib);
+
+/* dvb-dibusb-usb.c */
+int dibusb_readwrite_usb(struct usb_dibusb *dib, u8 *wbuf, u16 wlen, u8 *rbuf,
+	u16 rlen);
+
+int dibusb_hw_wakeup(struct dvb_frontend *);
+int dibusb_hw_sleep(struct dvb_frontend *);
+int dibusb_set_streaming_mode(struct usb_dibusb *,u8);
+int dibusb_streaming(struct usb_dibusb *,int);
+
+int dibusb_urb_init(struct usb_dibusb *);
+int dibusb_urb_exit(struct usb_dibusb *);
+
+/* dvb-dibusb-pid.c */
+int dibusb_pid_list_init(struct usb_dibusb *dib);
+void dibusb_pid_list_exit(struct usb_dibusb *dib);
+int dibusb_ctrl_pid(struct usb_dibusb *dib, struct dvb_demux_feed *dvbdmxfeed , int onoff);
+
+/* i2c and transfer stuff */
+#define DIBUSB_I2C_TIMEOUT				HZ*5
+
+/* 
+ * protocol of all dibusb related devices
+ */
 
-/* types of first byte of each buffer */
+/* 
+ * bulk msg to/from endpoint 0x01
+ *
+ * general structure:
+ * request_byte parameter_bytes
+ */
 
 #define DIBUSB_REQ_START_READ			0x00
 #define DIBUSB_REQ_START_DEMOD			0x01
+
+/* 
+ * i2c read 
+ * bulk write: 0x02 ((7bit i2c_addr << 1) & 0x01) register_bytes length_word
+ * bulk read:  byte_buffer (length_word bytes)
+ */
 #define DIBUSB_REQ_I2C_READ  			0x02
+ 
+/*
+ * i2c write
+ * bulk write: 0x03 (7bit i2c_addr << 1) register_bytes value_bytes
+ */
 #define DIBUSB_REQ_I2C_WRITE 			0x03
 
-/* prefix for reading the current RC key */
+/* 
+ * polling the value of the remote control 
+ * bulk write: 0x04
+ * bulk read:  byte_buffer (5 bytes) 
+ *
+ * first byte of byte_buffer shows the status (0x00, 0x01, 0x02)
+ */
 #define DIBUSB_REQ_POLL_REMOTE			0x04
 
 #define DIBUSB_RC_NEC_EMPTY				0x00
 #define DIBUSB_RC_NEC_KEY_PRESSED		0x01
 #define DIBUSB_RC_NEC_KEY_REPEATED		0x02
 
-/* 0x05 0xXX */
+/* streaming mode:
+ * bulk write: 0x05 mode_byte 
+ *
+ * mode_byte is mostly 0x00
+ */
 #define DIBUSB_REQ_SET_STREAMING_MODE	0x05
 
 /* interrupt the internal read loop, when blocking */
 #define DIBUSB_REQ_INTR_READ		   	0x06
 
-/* IO control
- * 0x07 <cmd 1 byte> <param 32 bytes>
+/* io control
+ * 0x07 cmd_byte param_bytes
+ *
+ * param_bytes can be up to 32 bytes
+ *
+ * cmd_byte function    parameter name 
+ * 0x00     power mode
+ *                      0x00      sleep
+ *                      0x01      wakeup
+ *
+ * 0x01     enable streaming 
+ * 0x02     disable streaming
+ *
+ *
  */
 #define DIBUSB_REQ_SET_IOCTL			0x07
 
@@ -348,4 +314,8 @@
 #define DIBUSB_IOCTL_POWER_SLEEP			0x00
 #define DIBUSB_IOCTL_POWER_WAKEUP			0x01
 
+/* modify streaming of the FX2 */
+#define DIBUSB_IOCTL_CMD_ENABLE_STREAM	0x01
+#define DIBUSB_IOCTL_CMD_DISABLE_STREAM	0x02
+
 #endif
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-pid.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-pid.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-pid.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-pid.c	2005-01-13 14:24:13.000000000 +0100
@@ -0,0 +1,80 @@
+/*
+ * dvb-dibusb-pid.c is part of the driver for mobile USB Budget DVB-T devices 
+ * based on reference design made by DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * see dvb-dibusb-core.c for more copyright details.
+ *
+ * This file contains functions for initializing and handling the internal
+ * pid-list. This pid-list mirrors the information currently stored in the
+ * devices pid-list.
+ */
+#include "dvb-dibusb.h"
+
+int dibusb_pid_list_init(struct usb_dibusb *dib)
+{
+	int i;
+	dib->pid_list = kmalloc(sizeof(struct dibusb_pid) * dib->dibdev->dev_cl->demod->pid_filter_count,GFP_KERNEL);
+	if (dib->pid_list == NULL)
+		return -ENOMEM;
+
+	deb_xfer("initializing %d pids for the pid_list.\n",dib->dibdev->dev_cl->demod->pid_filter_count);
+	
+	dib->pid_list_lock = SPIN_LOCK_UNLOCKED;
+	memset(dib->pid_list,0,dib->dibdev->dev_cl->demod->pid_filter_count*(sizeof(struct dibusb_pid)));
+	for (i=0; i < dib->dibdev->dev_cl->demod->pid_filter_count; i++) {
+		dib->pid_list[i].index = i;
+		dib->pid_list[i].pid = 0;
+		dib->pid_list[i].active = 0;
+	}
+
+	dib->init_state |= DIBUSB_STATE_PIDLIST;
+	return 0;
+}
+
+void dibusb_pid_list_exit(struct usb_dibusb *dib)
+{
+	if (dib->init_state & DIBUSB_STATE_PIDLIST)
+		kfree(dib->pid_list);
+	dib->init_state &= ~DIBUSB_STATE_PIDLIST;
+}
+
+/* fetch a pid from pid_list and set it on or off */
+int dibusb_ctrl_pid(struct usb_dibusb *dib, struct dvb_demux_feed *dvbdmxfeed , int onoff)
+{
+	int i,ret = -1;
+	unsigned long flags;
+	u16 pid = dvbdmxfeed->pid;
+
+	if (onoff) {
+		spin_lock_irqsave(&dib->pid_list_lock,flags);
+		for (i=0; i < dib->dibdev->dev_cl->demod->pid_filter_count; i++)
+			if (!dib->pid_list[i].active) {
+				dib->pid_list[i].pid = pid;
+				dib->pid_list[i].active = 1;
+				ret = i;
+				break;
+			}
+		dvbdmxfeed->priv = &dib->pid_list[ret];
+		spin_unlock_irqrestore(&dib->pid_list_lock,flags);
+		
+		if (dib->xfer_ops.pid_ctrl != NULL) 
+			dib->xfer_ops.pid_ctrl(dib->fe,dib->pid_list[ret].index,dib->pid_list[ret].pid,1);
+	} else {
+		struct dibusb_pid *dpid = dvbdmxfeed->priv;
+		
+		if (dib->xfer_ops.pid_ctrl != NULL) 
+			dib->xfer_ops.pid_ctrl(dib->fe,dpid->index,0,0);
+		
+		dpid->pid = 0;
+		dpid->active = 0;
+		ret = dpid->index;
+	}
+	
+	/* a free pid from the list */
+	deb_info("setting pid: %5d %04x at index %d '%s'\n",pid,pid,ret,onoff ? "on" : "off");
+
+	return ret;
+}
+
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-remote.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-remote.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-remote.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-remote.c	2005-01-09 16:50:44.000000000 +0100
@@ -0,0 +1,197 @@
+/*
+ * dvb-dibusb-remote.c is part of the driver for mobile USB Budget DVB-T devices
+ * based on reference design made by DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * see dvb-dibusb-core.c for more copyright details.
+ *
+ * This file contains functions for handling the event device on the software
+ * side and the remote control on the hardware side.
+ */
+#include "dvb-dibusb.h"
+
+/* Table to map raw key codes to key events.  This should not be hard-wired
+   into the kernel.  */
+static const struct { u8 c0, c1, c2; uint32_t key; } rc_keys [] =
+{
+	/* Key codes for the little Artec T1/Twinhan/HAMA/ remote. */
+	{ 0x00, 0xff, 0x16, KEY_POWER },
+	{ 0x00, 0xff, 0x10, KEY_MUTE },
+	{ 0x00, 0xff, 0x03, KEY_1 },
+	{ 0x00, 0xff, 0x01, KEY_2 },
+	{ 0x00, 0xff, 0x06, KEY_3 },
+	{ 0x00, 0xff, 0x09, KEY_4 },
+	{ 0x00, 0xff, 0x1d, KEY_5 },
+	{ 0x00, 0xff, 0x1f, KEY_6 },
+	{ 0x00, 0xff, 0x0d, KEY_7 },
+	{ 0x00, 0xff, 0x19, KEY_8 },
+	{ 0x00, 0xff, 0x1b, KEY_9 },
+	{ 0x00, 0xff, 0x15, KEY_0 },
+	{ 0x00, 0xff, 0x05, KEY_CHANNELUP },
+	{ 0x00, 0xff, 0x02, KEY_CHANNELDOWN },
+	{ 0x00, 0xff, 0x1e, KEY_VOLUMEUP },
+	{ 0x00, 0xff, 0x0a, KEY_VOLUMEDOWN },
+	{ 0x00, 0xff, 0x11, KEY_RECORD },
+	{ 0x00, 0xff, 0x17, KEY_FAVORITES }, /* Heart symbol - Channel list. */
+	{ 0x00, 0xff, 0x14, KEY_PLAY },
+	{ 0x00, 0xff, 0x1a, KEY_STOP },
+	{ 0x00, 0xff, 0x40, KEY_REWIND },
+	{ 0x00, 0xff, 0x12, KEY_FASTFORWARD },
+	{ 0x00, 0xff, 0x0e, KEY_PREVIOUS }, /* Recall - Previous channel. */
+	{ 0x00, 0xff, 0x4c, KEY_PAUSE },
+	{ 0x00, 0xff, 0x4d, KEY_SCREEN }, /* Full screen mode. */
+	{ 0x00, 0xff, 0x54, KEY_AUDIO }, /* MTS - Switch to secondary audio. */
+	/* additional keys TwinHan VisionPlus, the Artec seemingly not have */
+	{ 0x00, 0xff, 0x0c, KEY_CANCEL }, /* Cancel */
+	{ 0x00, 0xff, 0x1c, KEY_EPG }, /* EPG */
+	{ 0x00, 0xff, 0x00, KEY_TAB }, /* Tab */
+	{ 0x00, 0xff, 0x48, KEY_INFO }, /* Preview */
+	{ 0x00, 0xff, 0x04, KEY_LIST }, /* RecordList */
+	{ 0x00, 0xff, 0x0f, KEY_TEXT }, /* Teletext */
+	/* Key codes for the KWorld/ADSTech/JetWay remote. */
+	{ 0x86, 0x6b, 0x12, KEY_POWER },
+	{ 0x86, 0x6b, 0x0f, KEY_SELECT }, /* source */
+	{ 0x86, 0x6b, 0x0c, KEY_UNKNOWN }, /* scan */
+	{ 0x86, 0x6b, 0x0b, KEY_EPG },
+	{ 0x86, 0x6b, 0x10, KEY_MUTE },
+	{ 0x86, 0x6b, 0x01, KEY_1 },
+	{ 0x86, 0x6b, 0x02, KEY_2 },
+	{ 0x86, 0x6b, 0x03, KEY_3 },
+	{ 0x86, 0x6b, 0x04, KEY_4 },
+	{ 0x86, 0x6b, 0x05, KEY_5 },
+	{ 0x86, 0x6b, 0x06, KEY_6 },
+	{ 0x86, 0x6b, 0x07, KEY_7 },
+	{ 0x86, 0x6b, 0x08, KEY_8 },
+	{ 0x86, 0x6b, 0x09, KEY_9 },
+	{ 0x86, 0x6b, 0x0a, KEY_0 },
+	{ 0x86, 0x6b, 0x18, KEY_ZOOM },
+	{ 0x86, 0x6b, 0x1c, KEY_UNKNOWN }, /* preview */
+	{ 0x86, 0x6b, 0x13, KEY_UNKNOWN }, /* snap */
+	{ 0x86, 0x6b, 0x00, KEY_UNDO },
+	{ 0x86, 0x6b, 0x1d, KEY_RECORD },
+	{ 0x86, 0x6b, 0x0d, KEY_STOP },
+	{ 0x86, 0x6b, 0x0e, KEY_PAUSE },
+	{ 0x86, 0x6b, 0x16, KEY_PLAY },
+	{ 0x86, 0x6b, 0x11, KEY_BACK },
+	{ 0x86, 0x6b, 0x19, KEY_FORWARD },
+	{ 0x86, 0x6b, 0x14, KEY_UNKNOWN }, /* pip */
+	{ 0x86, 0x6b, 0x15, KEY_ESC },
+	{ 0x86, 0x6b, 0x1a, KEY_UP },
+	{ 0x86, 0x6b, 0x1e, KEY_DOWN },
+	{ 0x86, 0x6b, 0x1f, KEY_LEFT },
+	{ 0x86, 0x6b, 0x1b, KEY_RIGHT },
+};
+
+/*
+ * Read the remote control and feed the appropriate event.
+ * NEC protocol is used for remote controls
+ */
+static int dibusb_read_remote_control(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_REQ_POLL_REMOTE }, rb[5];
+	int ret;
+	int i;
+	if ((ret = dibusb_readwrite_usb(dib,b,1,rb,5)))
+		return ret;
+
+	switch (rb[0]) {
+		case DIBUSB_RC_NEC_KEY_PRESSED:
+			/* rb[1-3] is the actual key, rb[4] is a checksum */
+			deb_rc("raw key code 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
+				rb[1], rb[2], rb[3], rb[4]);
+
+			if ((0xff - rb[3]) != rb[4]) {
+				deb_rc("remote control checksum failed.\n");
+				break;
+			}
+
+			/* See if we can match the raw key code. */
+			for (i = 0; i < sizeof(rc_keys)/sizeof(rc_keys[0]); i++) {
+				if (rc_keys[i].c0 == rb[1] &&
+					rc_keys[i].c1 == rb[2] &&
+				    rc_keys[i].c2 == rb[3]) {
+					dib->rc_input_event = rc_keys[i].key;
+					deb_rc("Translated key 0x%04x\n", dib->rc_input_event);
+					/* Signal down and up events for this key. */
+					input_report_key(&dib->rc_input_dev, dib->rc_input_event, 1);
+					input_report_key(&dib->rc_input_dev, dib->rc_input_event, 0);
+					input_sync(&dib->rc_input_dev);
+					break;
+				}
+			}
+			break;
+		case DIBUSB_RC_NEC_EMPTY: /* No (more) remote control keys. */
+			break;
+		case DIBUSB_RC_NEC_KEY_REPEATED:
+			/* rb[1]..rb[4] are always zero.*/
+			/* Repeats often seem to occur so for the moment just ignore this. */
+			deb_rc("Key repeat\n");
+			break;
+		default:
+			break;
+	}
+	return 0;
+}
+
+/* Remote-control poll function - called every dib->rc_query_interval ms to see
+   whether the remote control has received anything. */
+static void dibusb_remote_query(void *data)
+{
+	struct usb_dibusb *dib = (struct usb_dibusb *) data;
+	/* TODO: need a lock here.  We can simply skip checking for the remote control
+	   if we're busy. */
+	dibusb_read_remote_control(dib);
+	schedule_delayed_work(&dib->rc_query_work,
+			      msecs_to_jiffies(rc_query_interval));
+}
+
+int dibusb_remote_init(struct usb_dibusb *dib)
+{
+	int i;
+
+	if (dib->dibdev->dev_cl->remote_type == DIBUSB_RC_NO)
+		return 0;
+	
+	/* Initialise the remote-control structures.*/
+	init_input_dev(&dib->rc_input_dev);
+
+	dib->rc_input_dev.evbit[0] = BIT(EV_KEY);
+	dib->rc_input_dev.keycodesize = sizeof(unsigned char);
+	dib->rc_input_dev.keycodemax = KEY_MAX;
+	dib->rc_input_dev.name = DRIVER_DESC " remote control";
+
+	for (i=0; i<sizeof(rc_keys)/sizeof(rc_keys[0]); i++)
+		set_bit(rc_keys[i].key, dib->rc_input_dev.keybit);
+
+	input_register_device(&dib->rc_input_dev);
+
+	dib->rc_input_event = KEY_MAX;
+
+	INIT_WORK(&dib->rc_query_work, dibusb_remote_query, dib);
+
+	/* Start the remote-control polling. */
+	if (rc_query_interval < 40)
+		rc_query_interval = 100; /* default */
+
+	info("schedule remote query interval to %d msecs.",rc_query_interval);
+	schedule_delayed_work(&dib->rc_query_work,msecs_to_jiffies(rc_query_interval));
+
+	dib->init_state |= DIBUSB_STATE_REMOTE;
+	
+	return 0;
+}
+
+int dibusb_remote_exit(struct usb_dibusb *dib)
+{
+	if (dib->dibdev->dev_cl->remote_type == DIBUSB_RC_NO)
+		return 0;
+
+	if (dib->init_state & DIBUSB_STATE_REMOTE) {
+		cancel_delayed_work(&dib->rc_query_work);
+		flush_scheduled_work();
+		input_unregister_device(&dib->rc_input_dev);
+	}
+	dib->init_state &= ~DIBUSB_STATE_REMOTE;
+	return 0;
+}
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-usb.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-01-13 14:24:13.000000000 +0100
@@ -0,0 +1,259 @@
+/*
+ * dvb-dibusb-usb.c is part of the driver for mobile USB Budget DVB-T devices 
+ * based on reference design made by DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * see dvb-dibusb-core.c for more copyright details.
+ *
+ * This file contains functions for initializing and handling the 
+ * usb specific stuff.
+ */
+#include "dvb-dibusb.h"
+
+#include <linux/version.h>
+#include <linux/pci.h>
+
+int dibusb_readwrite_usb(struct usb_dibusb *dib, u8 *wbuf, u16 wlen, u8 *rbuf,
+		u16 rlen)
+{
+	int actlen,ret = -ENOMEM;
+
+	if (wbuf == NULL || wlen == 0)
+		return -EINVAL;
+
+	if ((ret = down_interruptible(&dib->usb_sem)))
+		return ret;
+
+	if (dib->feedcount && 
+		wbuf[0] == DIBUSB_REQ_I2C_WRITE && 
+		dib->dibdev->dev_cl->id == DIBUSB1_1)
+		deb_err("BUG: writing to i2c, while TS-streaming destroys the stream."
+				"(%x reg: %x %x)\n", wbuf[0],wbuf[2],wbuf[3]);
+			
+	debug_dump(wbuf,wlen);
+
+	ret = usb_bulk_msg(dib->udev,usb_sndbulkpipe(dib->udev,
+			dib->dibdev->dev_cl->pipe_cmd), wbuf,wlen,&actlen,
+			DIBUSB_I2C_TIMEOUT);
+		
+	if (ret)
+		err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
+	else
+		ret = actlen != wlen ? -1 : 0;
+
+	/* an answer is expected, and no error before */
+	if (!ret && rbuf && rlen) {
+		ret = usb_bulk_msg(dib->udev,usb_rcvbulkpipe(dib->udev,
+				dib->dibdev->dev_cl->pipe_cmd),rbuf,rlen,&actlen,
+				DIBUSB_I2C_TIMEOUT);
+
+		if (ret)
+			err("recv bulk message failed: %d",ret);
+		else {
+			deb_alot("rlen: %d\n",rlen);
+			debug_dump(rbuf,actlen);
+		}
+	}
+	
+	up(&dib->usb_sem);
+	return ret;
+}
+
+/*
+ * Cypress controls
+ */
+
+#if 0
+/* 
+ * #if 0'ing the following functions as they are not in use _now_, 
+ * but probably will be sometime.
+ */
+
+/*
+ * do not use this, just a workaround for a bug, 
+ * which will hopefully never occur :).
+ */
+int dibusb_interrupt_read_loop(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_REQ_INTR_READ };
+	return dibusb_write_usb(dib,b,1);
+}
+
+#endif 
+static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
+{
+	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
+}
+
+/*
+ * ioctl for the firmware 
+ */
+static int dibusb_ioctl_cmd(struct usb_dibusb *dib, u8 cmd, u8 *param, int plen)
+{
+	u8 b[34];
+	int size = plen > 32 ? 32 : plen;
+	memset(b,0,34);
+	b[0] = DIBUSB_REQ_SET_IOCTL;
+	b[1] = cmd;
+
+	if (size > 0)
+		memcpy(&b[2],param,size);
+
+	return dibusb_write_usb(dib,b,34); //2+size);
+}
+
+/*
+ * ioctl for power control
+ */
+int dibusb_hw_wakeup(struct dvb_frontend *fe)
+{
+	struct usb_dibusb *dib = (struct usb_dibusb *) fe->dvb->priv;
+	u8 b[1] = { DIBUSB_IOCTL_POWER_WAKEUP };
+	deb_info("dibusb-device is getting up.\n");
+	dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+	
+	if (dib->fe_init)
+		return dib->fe_init(fe);
+	
+	return 0;
+}
+
+int dibusb_hw_sleep(struct dvb_frontend *fe)
+{
+	struct usb_dibusb *dib = (struct usb_dibusb *) fe->dvb->priv;
+	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
+	deb_info("dibusb-device is going to bed.\n");
+	dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+
+	if (dib->fe_sleep)
+		return dib->fe_sleep(fe);
+	
+	return 0;
+}
+
+int dibusb_set_streaming_mode(struct usb_dibusb *dib,u8 mode)
+{
+	u8 b[2] = { DIBUSB_REQ_SET_STREAMING_MODE, mode };
+	return dibusb_readwrite_usb(dib,b,2,NULL,0);
+}
+
+int dibusb_streaming(struct usb_dibusb *dib,int onoff)
+{
+	switch (dib->dibdev->dev_cl->id) {
+		case DIBUSB2_0:
+			if (onoff)
+				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_ENABLE_STREAM,NULL,0);
+			else
+				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_DISABLE_STREAM,NULL,0);
+			break;
+		case UMT2_0: 
+			return dibusb_set_streaming_mode(dib,onoff);
+			break;
+		default:
+			break;
+	}
+	return 0;
+}
+
+int dibusb_urb_init(struct usb_dibusb *dib)
+{
+	int ret,i,bufsize;
+	
+	/*
+	 * when reloading the driver w/o replugging the device 
+	 * a timeout occures, this helps
+	 */
+	usb_clear_halt(dib->udev,usb_sndbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_cmd));
+	usb_clear_halt(dib->udev,usb_rcvbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_cmd));
+	usb_clear_halt(dib->udev,usb_rcvbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_data));
+
+	/* allocate the array for the data transfer URBs */
+	dib->urb_list = kmalloc(dib->dibdev->dev_cl->urb_count*sizeof(struct urb *),GFP_KERNEL);
+	if (dib->urb_list == NULL)
+		return -ENOMEM;
+	memset(dib->urb_list,0,dib->dibdev->dev_cl->urb_count*sizeof(struct urb *));
+
+	dib->init_state |= DIBUSB_STATE_URB_LIST;
+	
+	bufsize = dib->dibdev->dev_cl->urb_count*dib->dibdev->dev_cl->urb_buffer_size;
+	deb_info("allocate %d bytes as buffersize for all URBs\n",bufsize);
+	/* allocate the actual buffer for the URBs */
+	if ((dib->buffer = pci_alloc_consistent(NULL,bufsize,&dib->dma_handle)) == NULL) {
+		deb_info("not enough memory.\n");
+		return -ENOMEM;
+	}
+	deb_info("allocation complete\n");
+	memset(dib->buffer,0,bufsize);
+	
+	dib->init_state |= DIBUSB_STATE_URB_BUF;
+
+	/* allocate and submit the URBs */
+	for (i = 0; i < dib->dibdev->dev_cl->urb_count; i++) {
+		if (!(dib->urb_list[i] = usb_alloc_urb(0,GFP_ATOMIC))) {
+			return -ENOMEM;
+		}
+		deb_info("submitting URB no. %d\n",i);
+		
+		usb_fill_bulk_urb( dib->urb_list[i], dib->udev, 
+				usb_rcvbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_data),
+				&dib->buffer[i*dib->dibdev->dev_cl->urb_buffer_size], 
+				dib->dibdev->dev_cl->urb_buffer_size, 
+				dibusb_urb_complete, dib);
+		
+		dib->urb_list[i]->transfer_flags = 0;
+
+		if ((ret = usb_submit_urb(dib->urb_list[i],GFP_ATOMIC))) {
+			err("could not submit buffer urb no. %d\n",i);
+			return ret;
+		}
+		dib->init_state |= DIBUSB_STATE_URB_SUBMIT;
+	}
+
+
+	dib->pid_parse = 1;
+	switch (dib->dibdev->dev_cl->id) {
+		case DIBUSB2_0:
+			if (dib->udev->speed == USB_SPEED_HIGH && !pid_parse) {
+				dib->pid_parse = 0;
+				info("running at HIGH speed, will deliver the complete TS.");
+			} else
+				info("will use pid_parsing.");
+			break;
+		default: 
+			break;
+	}
+	
+	return 0;
+}
+
+int dibusb_urb_exit(struct usb_dibusb *dib)
+{
+	int i;
+	if (dib->init_state & DIBUSB_STATE_URB_LIST) {
+		for (i = 0; i < dib->dibdev->dev_cl->urb_count; i++) {
+			if (dib->urb_list[i] != NULL) {
+				deb_info("killing URB no. %d.\n",i);
+
+				/* stop the URBs */
+				usb_kill_urb(dib->urb_list[i]);
+				
+				deb_info("freeing URB no. %d.\n",i);
+				/* free the URBs */
+				usb_free_urb(dib->urb_list[i]);
+			}
+		}
+		/* free the urb array */
+		kfree(dib->urb_list);
+		dib->init_state &= ~DIBUSB_STATE_URB_SUBMIT;
+		dib->init_state &= ~DIBUSB_STATE_URB_LIST;
+	}
+
+	if (dib->init_state & DIBUSB_STATE_URB_BUF)
+		pci_free_consistent(NULL,
+			dib->dibdev->dev_cl->urb_buffer_size*dib->dibdev->dev_cl->urb_count,
+			dib->buffer,dib->dma_handle);
+
+	dib->init_state &= ~DIBUSB_STATE_URB_BUF;
+	return 0;
+}
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/Kconfig linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/Kconfig
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/Kconfig	2005-01-20 19:56:17.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/Kconfig	2005-01-20 19:56:37.000000000 +0100
@@ -1,12 +1,13 @@
 config DVB_DIBUSB
-	tristate "DiBcom USB DVB-T devices (see help for device list)"
+	tristate "DiBcom USB DVB-T devices (see help for a complete device list)"
 	depends on DVB_CORE && USB
 	select FW_LOADER
 	select DVB_DIB3000MB
 	select DVB_DIB3000MC
+	select DVB_MT352
 	help
 	  Support for USB 1.1 and 2.0 DVB-T devices based on reference designs made by
-	  DiBcom (<http://www.dibcom.fr>).
+	  DiBcom (http://www.dibcom.fr) and C&E.
 
 	  Devices supported by this driver:
 
@@ -14,12 +15,14 @@
 		TwinhanDTV Magic Box (VP7041e)
 	    KWorld V-Stream XPERT DTV - DVB-T USB
 	    Hama DVB-T USB-Box
-	    DiBcom reference device (non-public)
+	    DiBcom reference devices (non-public)
 	    Ultima Electronic/Artec T1 USB TVBOX
 	    Compro Videomate DVB-U2000 - DVB-T USB
 	    Grandtec DVB-T USB
 	    Avermedia AverTV DVBT USB
-	    Yakumo DVB-T mobile USB2.0
+	    Artec T1 USB1.1 and USB2.0 boxes
+	    Yakumo/Typhoon DVB-T USB2.0
+	    Hanftek UMT-010 USB2.0
 
 	  The VP7041 seems to be identical to "CTS Portable" (Chinese
 	  Television System).
@@ -27,7 +30,7 @@
 	  These devices can be understood as budget ones, they "only" deliver
 	  (a part of) the MPEG2 transport stream.
 
-	  A firmware is needed to get the device working. See <file:Documentation/dvb/README.dibusb>
+	  A firmware is needed to get the device working. See Documentation/dvb/README.dibusb
 	  details.
 
 	  Say Y if you own such a device and want to use it. You should build it as
@@ -46,6 +49,7 @@
 	    0x0574:0x2235 (Artec T1 USB1.1, cold)
 	    0x04b4:0x8613 (Artec T1 USB2.0, cold)
 	    0x0574:0x1002 (Artec T1 USB2.0, warm)
+	    0x0574:0x2131 (aged DiBcom USB1.1 test device)
 
 	  Say Y if your device has one of the mentioned IDs.
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dibusb/Makefile linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/Makefile
--- linux-2.6.11-rc2/drivers/media/dvb/dibusb/Makefile	2005-01-20 19:54:06.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dibusb/Makefile	2005-01-20 19:56:37.000000000 +0100
@@ -1,3 +1,11 @@
+dvb-dibusb-objs = dvb-dibusb-core.o \
+	dvb-dibusb-dvb.o \
+	dvb-dibusb-fe-i2c.o \
+	dvb-dibusb-firmware.o \
+	dvb-dibusb-remote.o \
+	dvb-dibusb-usb.o \
+	dvb-dibusb-pid.o
+
 obj-$(CONFIG_DVB_DIBUSB) += dvb-dibusb.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/dvb/frontends/


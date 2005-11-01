Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVKAISI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVKAISI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVKAIRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:17:51 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:34227 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965064AbVKAIRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:17:22 -0500
Message-ID: <43672465.7090704@m1k.net>
Date: Tue, 01 Nov 2005 03:16:37 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 36/37] dvb: Add support for the Artec T1 USB2.0 box
Content-Type: multipart/mixed;
 boundary="------------080002060902020503050707"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080002060902020503050707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------080002060902020503050707
Content-Type: text/x-patch;
 name="2414.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2414.patch"

From: Patrick Boettcher <pb@linuxtv.org>

Adding support for the Artec T1 USB2.0 box (real USB2.0)

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/dvb-usb/dibusb-mb.c   |   59 +++++++++++++++++++++++++++++---
 drivers/media/dvb/dvb-usb/dibusb.h      |    4 +-
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    5 ++
 3 files changed, 63 insertions(+), 5 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-usb/dibusb-mb.c
@@ -82,13 +82,15 @@
 static struct dvb_usb_properties dibusb1_1_properties;
 static struct dvb_usb_properties dibusb1_1_an2235_properties;
 static struct dvb_usb_properties dibusb2_0b_properties;
+static struct dvb_usb_properties artec_t1_usb2_properties;
 
 static int dibusb_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
 	if (dvb_usb_device_init(intf,&dibusb1_1_properties,THIS_MODULE,NULL) == 0 ||
 		dvb_usb_device_init(intf,&dibusb1_1_an2235_properties,THIS_MODULE,NULL) == 0 ||
-		dvb_usb_device_init(intf,&dibusb2_0b_properties,THIS_MODULE,NULL) == 0)
+		dvb_usb_device_init(intf,&dibusb2_0b_properties,THIS_MODULE,NULL) == 0 ||
+		dvb_usb_device_init(intf,&artec_t1_usb2_properties,THIS_MODULE,NULL) == 0)
 		return 0;
 
 	return -EINVAL;
@@ -128,10 +130,13 @@
 
 /* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
 
+/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,		USB_PID_ULTIMA_TVBOX_USB2_COLD) },
+/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,		USB_PID_ULTIMA_TVBOX_USB2_WARM) },
+
 // #define DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
 
 #ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
-/* 28 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
 #endif
 			{ }		/* Terminating entry */
 };
@@ -264,7 +269,7 @@
 		},
 #ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
 		{	"Artec T1 USB1.1 TVBOX with AN2235 (faulty USB IDs)",
-			{ &dibusb_dib3000mb_table[28], NULL },
+			{ &dibusb_dib3000mb_table[30], NULL },
 			{ NULL },
 		},
 #endif
@@ -273,7 +278,7 @@
 
 static struct dvb_usb_properties dibusb2_0b_properties = {
 	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_PID_FILTER_CAN_BE_TURNED_OFF | DVB_USB_IS_AN_I2C_ADAPTER,
-	.pid_filter_count = 32,
+	.pid_filter_count = 16,
 
 	.usb_ctrl = CYPRESS_FX2,
 
@@ -321,6 +326,52 @@
 	}
 };
 
+static struct dvb_usb_properties artec_t1_usb2_properties = {
+	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_PID_FILTER_CAN_BE_TURNED_OFF | DVB_USB_IS_AN_I2C_ADAPTER,
+	.pid_filter_count = 16,
+
+	.usb_ctrl = CYPRESS_FX2,
+
+	.firmware = "dvb-usb-dibusb-6.0.0.8.fw",
+
+	.size_of_priv     = sizeof(struct dibusb_state),
+
+	.streaming_ctrl   = dibusb2_0_streaming_ctrl,
+	.pid_filter       = dibusb_pid_filter,
+	.pid_filter_ctrl  = dibusb_pid_filter_ctrl,
+	.power_ctrl       = dibusb2_0_power_ctrl,
+	.frontend_attach  = dibusb_dib3000mb_frontend_attach,
+	.tuner_attach     = dibusb_tuner_probe_and_attach,
+
+	.rc_interval      = DEFAULT_RC_INTERVAL,
+	.rc_key_map       = dibusb_rc_keys,
+	.rc_key_map_size  = 63, /* wow, that is ugly ... I want to load it to the driver dynamically */
+	.rc_query         = dibusb_rc_query,
+
+	.i2c_algo         = &dibusb_i2c_algo,
+
+	.generic_bulk_ctrl_endpoint = 0x01,
+	/* parameter for the MPEG2-data transfer */
+	.urb = {
+		.type = DVB_USB_BULK,
+		.count = 7,
+		.endpoint = 0x06,
+		.u = {
+			.bulk = {
+				.buffersize = 4096,
+			}
+		}
+	},
+
+	.num_device_descs = 1,
+	.devices = {
+		{	"Artec T1 USB2.0",
+			{ &dibusb_dib3000mb_table[28], NULL },
+			{ &dibusb_dib3000mb_table[29], NULL },
+		},
+	}
+};
+
 static struct usb_driver dibusb_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "dvb_usb_dibusb_mb",
--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-usb/dibusb.h
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-usb/dibusb.h
@@ -11,7 +11,9 @@
 #ifndef _DVB_USB_DIBUSB_H_
 #define _DVB_USB_DIBUSB_H_
 
-#define DVB_USB_LOG_PREFIX "dibusb"
+#ifndef DVB_USB_LOG_PREFIX
+ #define DVB_USB_LOG_PREFIX "dibusb"
+#endif
 #include "dvb-usb.h"
 
 #include "dib3000.h"
--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-usb/dvb-usb-ids.h
@@ -43,10 +43,14 @@
 #define USB_PID_COMPRO_DVBU2000_WARM		0xd001
 #define USB_PID_COMPRO_DVBU2000_UNK_COLD	0x010c
 #define USB_PID_COMPRO_DVBU2000_UNK_WARM	0x010d
+#define USB_PID_DIBCOM_HOOK_DEFAULT			0x0064
+#define USB_PID_DIBCOM_HOOK_DEFAULT_REENUM	0x0065
 #define USB_PID_DIBCOM_MOD3000_COLD			0x0bb8
 #define USB_PID_DIBCOM_MOD3000_WARM			0x0bb9
 #define USB_PID_DIBCOM_MOD3001_COLD			0x0bc6
 #define USB_PID_DIBCOM_MOD3001_WARM			0x0bc7
+#define USB_PID_DIBCOM_STK7700				0x1e14
+#define USB_PID_DIBCOM_STK7700_REENUM		0x1e15
 #define USB_PID_DIBCOM_ANCHOR_2135_COLD		0x2131
 #define USB_PID_GRANDTEC_DVBT_USB_COLD		0x0fa0
 #define USB_PID_GRANDTEC_DVBT_USB_WARM		0x0fa1
@@ -68,6 +72,7 @@
 #define USB_PID_ULTIMA_TVBOX_AN2235_WARM	0x8108
 #define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD	0x2235
 #define USB_PID_ULTIMA_TVBOX_USB2_COLD		0x8109
+#define USB_PID_ULTIMA_TVBOX_USB2_WARM		0x810a
 #define USB_PID_ULTIMA_TVBOX_USB2_FX_COLD	0x8613
 #define USB_PID_ULTIMA_TVBOX_USB2_FX_WARM	0x1002
 #define USB_PID_UNK_HYPER_PALTEK_COLD		0x005e



--------------080002060902020503050707--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVCVDaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVCVDaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCVCju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:39:50 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:52619 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262306AbVCVBga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:30 -0500
Message-Id: <20050322013458.276156000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:02 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-nova-t-ir.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 29/48] dibusb: support nova-t usb ir
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o added native nova-t support, since only the nova-t firmware works with the
  nova-t remote control
o added keys statically (maybe we should find something to sort this out...
  cinergyt2 is doing the same)
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-core.c     |   19 ++++-
 dvb-dibusb-firmware.c |    4 -
 dvb-dibusb-remote.c   |  177 +++++++++++++++++++++++++++++++++++++++++---------
 dvb-dibusb-usb.c      |   12 ++-
 dvb-dibusb.h          |   13 +++
 5 files changed, 187 insertions(+), 38 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:17:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:18:30.000000000 +0100
@@ -42,10 +42,14 @@ static int pid_parse;
 module_param(pid_parse, int, 0644);
 MODULE_PARM_DESC(pid_parse, "enable pid parsing (filtering) when running at USB2.0");
 
-static int rc_query_interval;
+static int rc_query_interval = 100;
 module_param(rc_query_interval, int, 0644);
 MODULE_PARM_DESC(rc_query_interval, "interval in msecs for remote control query (default: 100; min: 40)");
 
+static int rc_key_repeat_count = 2;
+module_param(rc_key_repeat_count, int, 0644);
+MODULE_PARM_DESC(rc_key_repeat_count, "how many key repeats will be dropped before passing the key event again (default: 2)");
+
 /* Vendor IDs */
 #define USB_VID_ADSTECH						0x06e1
 #define USB_VID_ANCHOR						0x0547
@@ -225,7 +229,7 @@ static struct dibusb_device_class dibusb
 	{ DIBUSB2_0,&dibusb_usb_ctrl[2],
 	  "dvb-dibusb-6.0.0.5.fw",
 	  0x01, 0x06, 
-	  3, 188*210,
+	  7, 4096,
 	  DIBUSB_RC_NEC_PROTOCOL,
 	  &dibusb_demod[DIBUSB_DIB3000MC],
 	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5],
@@ -246,6 +250,14 @@ static struct dibusb_device_class dibusb
 	  &dibusb_demod[DIBUSB_DIB3000MB],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_THOMSON],
 	},
+	{ NOVAT_USB2,&dibusb_usb_ctrl[2],
+	  "dvb-dibusb-nova-t-1.fw",
+	  0x01, 0x06,
+	  7, 4096,
+	  DIBUSB_RC_HAUPPAUGE_PROTO,
+	  &dibusb_demod[DIBUSB_DIB3000MC],
+	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5],
+	},
 };
 
 static struct dibusb_usb_device dibusb_devices[] = {
@@ -305,7 +317,7 @@ static struct dibusb_usb_device dibusb_d
 		{ NULL },
 	},
 	{	"Hauppauge WinTV NOVA-T USB2",
-		&dibusb_device_classes[DIBUSB2_0],
+		&dibusb_device_classes[NOVAT_USB2],
 		{ &dib_table[30], NULL },
 		{ &dib_table[31], NULL },
 	},
@@ -475,6 +487,7 @@ static int dibusb_probe(struct usb_inter
 		/* store parameters to structures */
 		dib->rc_query_interval = rc_query_interval;
 		dib->pid_parse = pid_parse;
+		dib->rc_key_repeat_count = rc_key_repeat_count;
 
 		usb_set_intfdata(intf, dib);
 		
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c	2005-03-22 00:18:30.000000000 +0100
@@ -30,11 +30,13 @@ int dibusb_loadfirmware(struct usb_devic
 	int ret = 0,i;
 	
 	if ((ret = request_firmware(&fw, dibdev->dev_cl->firmware, &udev->dev)) != 0) {
-		err("did not find a valid firmware file. (%s) "
+		err("did not find the firmware file. (%s) "
 			"Please see linux/Documentation/dvb/ for more details on firmware-problems.",
 			dibdev->dev_cl->firmware);
 		return ret;
 	}
+
+	info("downloading firmware from file '%s'.",dibdev->dev_cl->firmware);
 	
 	p = kmalloc(fw->size,GFP_KERNEL);	
 	if (p != NULL) {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-remote.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-remote.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-remote.c	2005-03-22 00:18:30.000000000 +0100
@@ -13,7 +13,7 @@
 
 /* Table to map raw key codes to key events.  This should not be hard-wired
    into the kernel.  */
-static const struct { u8 c0, c1, c2; uint32_t key; } rc_keys [] =
+static const struct { u8 c0, c1, c2; uint32_t key; } nec_rc_keys [] =
 {
 	/* Key codes for the little Artec T1/Twinhan/HAMA/ remote. */
 	{ 0x00, 0xff, 0x16, KEY_POWER },
@@ -83,18 +83,58 @@ static const struct { u8 c0, c1, c2; uin
 	{ 0x86, 0x6b, 0x1b, KEY_RIGHT },
 };
 
-/*
- * Read the remote control and feed the appropriate event.
- * NEC protocol is used for remote controls
- */
-static int dibusb_read_remote_control(struct usb_dibusb *dib)
+/* Hauppauge NOVA-T USB2 keys */
+static const struct { u16 raw; uint32_t key; } haupp_rc_keys [] = {
+	{ 0xddf, KEY_GOTO },
+	{ 0xdef, KEY_POWER },
+	{ 0xce7, KEY_TV },
+	{ 0xcc7, KEY_VIDEO },
+	{ 0xccf, KEY_AUDIO },
+	{ 0xcd7, KEY_MEDIA },
+	{ 0xcdf, KEY_EPG },
+	{ 0xca7, KEY_UP },
+	{ 0xc67, KEY_RADIO },
+	{ 0xcb7, KEY_LEFT },
+	{ 0xd2f, KEY_OK },
+	{ 0xcbf, KEY_RIGHT },
+	{ 0xcff, KEY_BACK },
+	{ 0xcaf, KEY_DOWN },
+	{ 0xc6f, KEY_MENU },
+	{ 0xc87, KEY_VOLUMEUP },
+	{ 0xc8f, KEY_VOLUMEDOWN },
+	{ 0xc97, KEY_CHANNEL },
+	{ 0xc7f, KEY_MUTE },
+	{ 0xd07, KEY_CHANNELUP },
+	{ 0xd0f, KEY_CHANNELDOWN },
+	{ 0xdbf, KEY_RECORD },
+	{ 0xdb7, KEY_STOP },
+	{ 0xd97, KEY_REWIND },
+	{ 0xdaf, KEY_PLAY },
+	{ 0xda7, KEY_FASTFORWARD },
+	{ 0xd27, KEY_LAST }, /* Skip backwards */
+	{ 0xd87, KEY_PAUSE },
+	{ 0xcf7, KEY_NEXT },
+	{ 0xc07, KEY_0 },
+	{ 0xc0f, KEY_1 },
+	{ 0xc17, KEY_2 },
+	{ 0xc1f, KEY_3 },
+	{ 0xc27, KEY_4 },
+	{ 0xc2f, KEY_5 },
+	{ 0xc37, KEY_6 },
+	{ 0xc3f, KEY_7 },
+	{ 0xc47, KEY_8 },
+	{ 0xc4f, KEY_9 },
+	{ 0xc57, KEY_KPASTERISK },
+	{ 0xc77, KEY_GRAVE }, /* # */
+	{ 0xc5f, KEY_RED },
+	{ 0xd77, KEY_GREEN },
+	{ 0xdc7, KEY_YELLOW },
+	{ 0xd4f, KEY_BLUE},
+};
+
+static int dibusb_key2event_nec(struct usb_dibusb *dib,u8 rb[5])
 {
-	u8 b[1] = { DIBUSB_REQ_POLL_REMOTE }, rb[5];
-	int ret;
 	int i;
-	if ((ret = dibusb_readwrite_usb(dib,b,1,rb,5)))
-		return ret;
-
 	switch (rb[0]) {
 		case DIBUSB_RC_NEC_KEY_PRESSED:
 			/* rb[1-3] is the actual key, rb[4] is a checksum */
@@ -107,30 +147,100 @@ static int dibusb_read_remote_control(st
 			}
 
 			/* See if we can match the raw key code. */
-			for (i = 0; i < sizeof(rc_keys)/sizeof(rc_keys[0]); i++) {
-				if (rc_keys[i].c0 == rb[1] &&
-					rc_keys[i].c1 == rb[2] &&
-				    rc_keys[i].c2 == rb[3]) {
-					dib->rc_input_event = rc_keys[i].key;
-					deb_rc("Translated key 0x%04x\n", dib->rc_input_event);
-					/* Signal down and up events for this key. */
-					input_report_key(&dib->rc_input_dev, dib->rc_input_event, 1);
-					input_report_key(&dib->rc_input_dev, dib->rc_input_event, 0);
-					input_sync(&dib->rc_input_dev);
-					break;
+			for (i = 0; i < sizeof(nec_rc_keys)/sizeof(nec_rc_keys[0]); i++) {
+				if (nec_rc_keys[i].c0 == rb[1] &&
+					nec_rc_keys[i].c1 == rb[2] &&
+					nec_rc_keys[i].c2 == rb[3]) {
+
+					dib->last_event = nec_rc_keys[i].key;
+					return 1;
 				}
 			}
 			break;
-		case DIBUSB_RC_NEC_EMPTY: /* No (more) remote control keys. */
-			break;
 		case DIBUSB_RC_NEC_KEY_REPEATED:
 			/* rb[1]..rb[4] are always zero.*/
 			/* Repeats often seem to occur so for the moment just ignore this. */
-			deb_rc("Key repeat\n");
+			return 0;
+		case DIBUSB_RC_NEC_EMPTY: /* No (more) remote control keys. */
+		default:
+			break;
+	}
+	return -1;
+}
+
+static int dibusb_key2event_hauppauge(struct usb_dibusb *dib,u8 rb[4])
+{
+	u16 raw;
+	int i,state;
+	switch (rb[0]) {
+		case DIBUSB_RC_HAUPPAUGE_KEY_PRESSED:
+			raw = ((rb[1] & 0x0f) << 8) | rb[2];
+
+			state = !!(rb[1] & 0x40);
+
+			deb_rc("raw key code 0x%02x, 0x%02x, 0x%02x to %04x state: %d\n",rb[1],rb[2],rb[3],raw,state);
+			for (i = 0; i < sizeof(haupp_rc_keys)/sizeof(haupp_rc_keys[0]); i++) {
+				if (haupp_rc_keys[i].raw == raw) {
+					if (dib->last_event == haupp_rc_keys[i].key &&
+						dib->last_state == state) {
+						deb_rc("key repeat\n");
+						return 0;
+					} else {
+						dib->last_event = haupp_rc_keys[i].key;
+						dib->last_state = state;
+						return 1;
+					}
+				}
+			}
+
 			break;
+		case DIBUSB_RC_HAUPPAUGE_KEY_EMPTY:
 		default:
 			break;
 	}
+	return -1;
+}
+
+/*
+ * Read the remote control and feed the appropriate event.
+ * NEC protocol is used for remote controls
+ */
+static int dibusb_read_remote_control(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_REQ_POLL_REMOTE }, rb[5];
+	int ret,event = 0;
+
+	if ((ret = dibusb_readwrite_usb(dib,b,1,rb,5)))
+		return ret;
+
+	switch (dib->dibdev->dev_cl->remote_type) {
+		case DIBUSB_RC_NEC_PROTOCOL:
+			event = dibusb_key2event_nec(dib,rb);
+			break;
+		case DIBUSB_RC_HAUPPAUGE_PROTO:
+			event = dibusb_key2event_hauppauge(dib,rb);
+		default:
+			break;
+	}
+
+	/* key repeat */
+	if (event == 0)
+		if (++dib->repeat_key_count < dib->rc_key_repeat_count) {
+			deb_rc("key repeat dropped. (%d)\n",dib->repeat_key_count);
+			event = -1; /* skip this key repeat */
+		}
+
+	if (event == 1 || event == 0) {
+		deb_rc("Translated key 0x%04x\n",event);
+
+		/* Signal down and up events for this key. */
+		input_report_key(&dib->rc_input_dev, dib->last_event, 1);
+		input_report_key(&dib->rc_input_dev, dib->last_event, 0);
+		input_sync(&dib->rc_input_dev);
+
+		if (event == 1)
+			dib->repeat_key_count = 0;
+	}
 	return 0;
 }
 
@@ -161,12 +271,21 @@ int dibusb_remote_init(struct usb_dibusb
 	dib->rc_input_dev.keycodemax = KEY_MAX;
 	dib->rc_input_dev.name = DRIVER_DESC " remote control";
 
-	for (i=0; i<sizeof(rc_keys)/sizeof(rc_keys[0]); i++)
-		set_bit(rc_keys[i].key, dib->rc_input_dev.keybit);
+	switch (dib->dibdev->dev_cl->remote_type) {
+		case DIBUSB_RC_NEC_PROTOCOL:
+			for (i=0; i<sizeof(nec_rc_keys)/sizeof(nec_rc_keys[0]); i++)
+				set_bit(nec_rc_keys[i].key, dib->rc_input_dev.keybit);
+			break;
+		case DIBUSB_RC_HAUPPAUGE_PROTO:
+			for (i=0; i<sizeof(haupp_rc_keys)/sizeof(haupp_rc_keys[0]); i++)
+				set_bit(haupp_rc_keys[i].key, dib->rc_input_dev.keybit);
+			break;
+		default:
+			break;
+	}
 
-	input_register_device(&dib->rc_input_dev);
 
-	dib->rc_input_event = KEY_MAX;
+	input_register_device(&dib->rc_input_dev);
 
 	INIT_WORK(&dib->rc_query_work, dibusb_remote_query, dib);
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:16:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:18:30.000000000 +0100
@@ -117,9 +117,14 @@ int dibusb_hw_sleep(struct dvb_frontend 
 	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
 	deb_info("dibusb-device is going to bed.\n");
 	/* workaround, something is wrong, when dibusb 1.1 device are going to bed too late */
-	if (dib->dibdev->dev_cl->id != DIBUSB1_1)
-		dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
-
+	switch (dib->dibdev->dev_cl->id) {
+		case DIBUSB1_1:
+		case NOVAT_USB2:
+			break;
+		default:
+			dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+			break;
+	}
 	if (dib->fe_sleep)
 		return dib->fe_sleep(fe);
 
@@ -137,6 +142,7 @@ int dibusb_streaming(struct usb_dibusb *
 	switch (dib->dibdev->dev_cl->id) {
 		case DIBUSB2_0:
 		case DIBUSB2_0B:
+		case NOVAT_USB2:
 			if (onoff)
 				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_ENABLE_STREAM,NULL,0);
 			else
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:17:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:18:30.000000000 +0100
@@ -73,6 +73,7 @@ typedef enum {
 	DIBUSB2_0,
 	UMT2_0,
 	DIBUSB2_0B,
+	NOVAT_USB2,
 } dibusb_class_t;
 
 typedef enum {
@@ -90,7 +91,8 @@ typedef enum {
 
 typedef enum {
 	DIBUSB_RC_NO = 0,
-	DIBUSB_RC_NEC_PROTOCOL = 1,
+	DIBUSB_RC_NEC_PROTOCOL,
+	DIBUSB_RC_HAUPPAUGE_PROTO,
 } dibusb_remote_t;
 
 struct dibusb_tuner {
@@ -188,7 +190,10 @@ struct usb_dibusb {
 	/* remote control */
 	struct input_dev rc_input_dev;
 	struct work_struct rc_query_work;
-	int rc_input_event;
+	int last_event;
+	int last_state; /* for Hauppauge RC protocol */
+	int repeat_key_count;
+	int rc_key_repeat_count; /* module parameter */
 
 	/* module parameters */
 	int pid_parse;
@@ -270,6 +275,10 @@ int dibusb_urb_exit(struct usb_dibusb *)
 #define DIBUSB_RC_NEC_KEY_PRESSED		0x01
 #define DIBUSB_RC_NEC_KEY_REPEATED		0x02
 
+/* additional status values for Hauppauge Remote Control Protocol */
+#define DIBUSB_RC_HAUPPAUGE_KEY_PRESSED	0x01
+#define DIBUSB_RC_HAUPPAUGE_KEY_EMPTY	0x03
+
 /* streaming mode:
  * bulk write: 0x05 mode_byte
  *

--


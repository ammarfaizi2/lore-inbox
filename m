Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVIDXrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVIDXrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVIDXrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:47:07 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:44673 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932129AbVIDXam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:42 -0400
Message-Id: <20050904232328.005932000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:30 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-cxusb-adapt-to-new-firmware.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 31/54] usb: cxusb: fixes for new firmware
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

This patch changes two things:

1) a firmware update made by the vendor, which has to be done in Windows for
now, changes the DVB-data-pipe from isochronous to bulk: it fixes the data
distortions (and thus the video-distortions) in DVB-T mode; there is no
backwards compatibility with the old firmware as it didn't work anyway

2) with the help of Steve Toth some reverse-engineered functionality is now
named correctly, thank you

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/cxusb.c |   64 +++++++++++++-------------------------
 drivers/media/dvb/dvb-usb/cxusb.h |   27 ++++++++--------
 2 files changed, 37 insertions(+), 54 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/cxusb.c	2005-09-04 22:28:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/cxusb.c	2005-09-04 22:28:25.000000000 +0200
@@ -48,35 +48,26 @@ static int cxusb_ctrl_msg(struct dvb_usb
 	return 0;
 }
 
-/* I2C */
-static void cxusb_set_i2c_path(struct dvb_usb_device *d, enum cxusb_i2c_pathes path)
+/* GPIO */
+static void cxusb_gpio_tuner(struct dvb_usb_device *d, int onoff)
 {
 	struct cxusb_state *st = d->priv;
 	u8 o[2],i;
 
-	if (path == st->cur_i2c_path)
+	if (st->gpio_write_state[GPIO_TUNER] == onoff)
 		return;
 
-	o[0] = IOCTL_SET_I2C_PATH;
-	switch (path) {
-		case PATH_CX22702:
-			o[1] = 0;
-			break;
-		case PATH_TUNER_OTHER:
-			o[1] = 1;
-			break;
-		default:
-			err("unkown i2c path");
-			return;
-	}
-	cxusb_ctrl_msg(d,CMD_IOCTL,o,2,&i,1);
+	o[0] = GPIO_TUNER;
+	o[1] = onoff;
+	cxusb_ctrl_msg(d,CMD_GPIO_WRITE,o,2,&i,1);
 
 	if (i != 0x01)
-		deb_info("i2c_path setting failed.\n");
+		deb_info("gpio_write failed.\n");
 
-	st->cur_i2c_path = path;
+	st->gpio_write_state[GPIO_TUNER] = onoff;
 }
 
+/* I2C */
 static int cxusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
@@ -92,10 +83,10 @@ static int cxusb_i2c_xfer(struct i2c_ada
 
 		switch (msg[i].addr) {
 			case 0x63:
-				cxusb_set_i2c_path(d,PATH_CX22702);
+				cxusb_gpio_tuner(d,0);
 				break;
 			default:
-				cxusb_set_i2c_path(d,PATH_TUNER_OTHER);
+				cxusb_gpio_tuner(d,1);
 				break;
 		}
 
@@ -149,16 +140,20 @@ static struct i2c_algorithm cxusb_i2c_al
 
 static int cxusb_power_ctrl(struct dvb_usb_device *d, int onoff)
 {
-	return 0;
+	u8 b = 0;
+	if (onoff)
+		return cxusb_ctrl_msg(d, CMD_POWER_ON, &b, 1, NULL, 0);
+	else
+		return cxusb_ctrl_msg(d, CMD_POWER_OFF, &b, 1, NULL, 0);
 }
 
 static int cxusb_streaming_ctrl(struct dvb_usb_device *d, int onoff)
 {
 	u8 buf[2] = { 0x03, 0x00 };
 	if (onoff)
-		cxusb_ctrl_msg(d,0x36, buf, 2, NULL, 0);
+		cxusb_ctrl_msg(d,CMD_STREAMING_ON, buf, 2, NULL, 0);
 	else
-		cxusb_ctrl_msg(d,0x37, NULL, 0, NULL, 0);
+		cxusb_ctrl_msg(d,CMD_STREAMING_OFF, NULL, 0, NULL, 0);
 
 	return 0;
 }
@@ -184,22 +179,11 @@ static int cxusb_tuner_attach(struct dvb
 
 static int cxusb_frontend_attach(struct dvb_usb_device *d)
 {
-	u8 buf[2] = { 0x03, 0x00 };
-	u8 b = 0;
-
-	if (usb_set_interface(d->udev,0,0) < 0)
-		err("set interface to alts=0 failed");
-
-	cxusb_ctrl_msg(d,0xde,&b,0,NULL,0);
-	cxusb_set_i2c_path(d,PATH_TUNER_OTHER);
-	cxusb_ctrl_msg(d,CMD_POWER_OFF, NULL, 0, &b, 1);
-
+	u8 b;
 	if (usb_set_interface(d->udev,0,6) < 0)
 		err("set interface failed");
 
-	cxusb_ctrl_msg(d,0x36, buf, 2, NULL, 0);
-	cxusb_set_i2c_path(d,PATH_CX22702);
-	cxusb_ctrl_msg(d,CMD_POWER_ON, NULL, 0, &b, 1);
+	cxusb_ctrl_msg(d,CMD_DIGITAL, NULL, 0, &b, 1);
 
 	if ((d->fe = cx22702_attach(&cxusb_cx22702_config, &d->i2c_adap)) != NULL)
 		return 0;
@@ -239,14 +223,12 @@ static struct dvb_usb_properties cxusb_p
 	.generic_bulk_ctrl_endpoint = 0x01,
 	/* parameter for the MPEG2-data transfer */
 	.urb = {
-		.type = DVB_USB_ISOC,
+		.type = DVB_USB_BULK,
 		.count = 5,
 		.endpoint = 0x02,
 		.u = {
-			.isoc = {
-				.framesperurb = 32,
-				.framesize = 940,
-				.interval = 5,
+			.bulk = {
+				.buffersize = 8192,
 			}
 		}
 	},
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/cxusb.h	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/cxusb.h	2005-09-04 22:28:25.000000000 +0200
@@ -1,30 +1,31 @@
 #ifndef _DVB_USB_CXUSB_H_
 #define _DVB_USB_CXUSB_H_
 
-#define DVB_USB_LOG_PREFIX "digitv"
+#define DVB_USB_LOG_PREFIX "cxusb"
 #include "dvb-usb.h"
 
 extern int dvb_usb_cxusb_debug;
 #define deb_info(args...)   dprintk(dvb_usb_cxusb_debug,0x01,args)
 
 /* usb commands - some of it are guesses, don't have a reference yet */
-#define CMD_I2C_WRITE    0x08
-#define CMD_I2C_READ     0x09
+#define CMD_I2C_WRITE     0x08
+#define CMD_I2C_READ      0x09
 
-#define CMD_IOCTL        0x0e
-#define    IOCTL_SET_I2C_PATH 0x02
+#define CMD_GPIO_READ     0x0d
+#define CMD_GPIO_WRITE    0x0e
+#define     GPIO_TUNER         0x02
 
-#define CMD_POWER_OFF    0x50
-#define CMD_POWER_ON     0x51
+#define CMD_POWER_OFF     0xdc
+#define CMD_POWER_ON      0xde
 
-enum cxusb_i2c_pathes {
-	PATH_UNDEF       = 0x00,
-	PATH_CX22702     = 0x01,
-	PATH_TUNER_OTHER = 0x02,
-};
+#define CMD_STREAMING_ON  0x36
+#define CMD_STREAMING_OFF 0x37
+
+#define CMD_ANALOG        0x50
+#define CMD_DIGITAL       0x51
 
 struct cxusb_state {
-	enum cxusb_i2c_pathes cur_i2c_path;
+	u8 gpio_write_state[3];
 };
 
 #endif

--


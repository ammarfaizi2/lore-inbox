Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVF0Nbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVF0Nbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVF0N2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:28:32 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:19685 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262067AbVF0MQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:42 -0400
Message-Id: <20050627121416.460798000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:35 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-adstech-instanttv-dvbt.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 35/51] usb: fix ADSTech Instant TV DVB-T USB2.0 support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Fixed support for the ADSTech Instant TV DVB-T USB (2.0 version).
Thanks to Gerolf Wendland for his support.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dibusb-mb.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:24:27.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:24:28.000000000 +0200
@@ -31,10 +31,17 @@ static int dibusb_dib3000mb_frontend_att
 	return 0;
 }
 
-/* some of the dibusb 1.1 device aren't equipped with the default tuner
+static int dibusb_thomson_tuner_attach(struct dvb_usb_device *d)
+{
+	d->pll_addr = 0x61;
+	d->pll_desc = &dvb_pll_tua6010xs;
+	return 0;
+}
+
+/* Some of the Artec 1.1 device aren't equipped with the default tuner
  * (Thomson Cable), but with a Panasonic ENV77H11D5.  This function figures
  * this out. */
-static int dibusb_dib3000mb_tuner_attach (struct dvb_usb_device *d)
+static int dibusb_tuner_probe_and_attach(struct dvb_usb_device *d)
 {
 	u8 b[2] = { 0,0 }, b2[1];
 	int ret = 0;
@@ -59,8 +66,7 @@ static int dibusb_dib3000mb_tuner_attach
 
 	if (b2[0] == 0xfe) {
 		info("this device has the Thomson Cable onboard. Which is default.");
-		d->pll_addr = 0x61;
-		d->pll_desc = &dvb_pll_tua6010xs;
+		dibusb_thomson_tuner_attach(d);
 	} else {
 		u8 bpll[4] = { 0x0b, 0xf5, 0x85, 0xab };
 		info("this device has the Panasonic ENV77H11D5 onboard.");
@@ -114,6 +120,8 @@ static struct usb_device_id dibusb_dib30
 /* 21 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
 /* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
 /* 23 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
+
+/* device ID with default DIBUSB2_0-firmware and with the hacked firmware */
 /* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
 
 // #define DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
@@ -140,7 +148,7 @@ static struct dvb_usb_properties dibusb1
 	.pid_filter_ctrl  = dibusb_pid_filter_ctrl,
 	.power_ctrl       = dibusb_power_ctrl,
 	.frontend_attach  = dibusb_dib3000mb_frontend_attach,
-	.tuner_attach     = dibusb_dib3000mb_tuner_attach,
+	.tuner_attach     = dibusb_tuner_probe_and_attach,
 
 	.rc_interval      = DEFAULT_RC_INTERVAL,
 	.rc_key_map       = dibusb_rc_keys,
@@ -212,7 +220,7 @@ static struct dvb_usb_properties dibusb1
 	.pid_filter_ctrl  = dibusb_pid_filter_ctrl,
 	.power_ctrl       = dibusb_power_ctrl,
 	.frontend_attach  = dibusb_dib3000mb_frontend_attach,
-	.tuner_attach     = dibusb_dib3000mb_tuner_attach,
+	.tuner_attach     = dibusb_tuner_probe_and_attach,
 
 	.rc_interval      = DEFAULT_RC_INTERVAL,
 	.rc_key_map       = dibusb_rc_keys,
@@ -257,7 +265,7 @@ static struct dvb_usb_properties dibusb2
 	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_PID_FILTER_CAN_BE_TURNED_OFF | DVB_USB_IS_AN_I2C_ADAPTER,
 	.usb_ctrl = CYPRESS_FX2,
 
-	.firmware = "dvb-usb-adstech-usb2-01.fw",
+	.firmware = "dvb-usb-adstech-usb2-02.fw",
 
 	.size_of_priv     = sizeof(struct dibusb_state),
 
@@ -266,7 +274,7 @@ static struct dvb_usb_properties dibusb2
 	.pid_filter_ctrl  = dibusb_pid_filter_ctrl,
 	.power_ctrl       = dibusb2_0_power_ctrl,
 	.frontend_attach  = dibusb_dib3000mb_frontend_attach,
-	.tuner_attach     = dibusb_dib3000mb_tuner_attach,
+	.tuner_attach     = dibusb_thomson_tuner_attach,
 
 	.rc_interval      = DEFAULT_RC_INTERVAL,
 	.rc_key_map       = dibusb_rc_keys,
@@ -288,11 +296,11 @@ static struct dvb_usb_properties dibusb2
 		}
 	},
 
-	.num_device_descs = 2,
+	.num_device_descs = 1,
 	.devices = {
 		{	"KWorld/ADSTech Instant DVB-T USB 2.0",
 			{ &dibusb_dib3000mb_table[23], NULL },
-			{ &dibusb_dib3000mb_table[24], NULL }, /* device ID with default DIBUSB2_0-firmware */
+			{ &dibusb_dib3000mb_table[24], NULL },
 		},
 	}
 };

--


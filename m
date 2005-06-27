Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVF0N0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVF0N0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVF0NZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:25:31 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:18149 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262063AbVF0MQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:40 -0400
Message-Id: <20050627121418.220489000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:43 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-cxusb-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 43/51] usb: cxusb DVB-T fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

cxusb DVB-T fixes.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/cxusb.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/cxusb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/cxusb.c	2005-06-27 13:26:10.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/cxusb.c	2005-06-27 13:26:15.000000000 +0200
@@ -14,9 +14,6 @@
  * TODO: check if the cx25840-driver (from ivtv) can be used for the analogue
  * part
  *
- * FIXME: We're getting a lock and signal, but the isochronous transfer is empty
- * for DVB-T.
- *
  * Copyright (C) 2005 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  *	This program is free software; you can redistribute it and/or modify it
@@ -157,12 +154,20 @@ static int cxusb_power_ctrl(struct dvb_u
 
 static int cxusb_streaming_ctrl(struct dvb_usb_device *d, int onoff)
 {
+	u8 buf[2] = { 0x03, 0x00 };
+	if (onoff)
+		cxusb_ctrl_msg(d,0x36, buf, 2, NULL, 0);
+	else
+		cxusb_ctrl_msg(d,0x37, NULL, 0, NULL, 0);
+
 	return 0;
 }
 
 struct cx22702_config cxusb_cx22702_config = {
 	.demod_address = 0x63,
 
+	.output_mode = CX22702_PARALLEL_OUTPUT,
+
 	.pll_init = dvb_usb_pll_init_i2c,
 	.pll_set  = dvb_usb_pll_set_i2c,
 };
@@ -182,12 +187,15 @@ static int cxusb_frontend_attach(struct 
 	u8 buf[2] = { 0x03, 0x00 };
 	u8 b = 0;
 
+	if (usb_set_interface(d->udev,0,0) < 0)
+		err("set interface to alts=0 failed");
+
 	cxusb_ctrl_msg(d,0xde,&b,0,NULL,0);
 	cxusb_set_i2c_path(d,PATH_TUNER_OTHER);
 	cxusb_ctrl_msg(d,CMD_POWER_OFF, NULL, 0, &b, 1);
 
 	if (usb_set_interface(d->udev,0,6) < 0)
-		err("set interface failed\n");
+		err("set interface failed");
 
 	cxusb_ctrl_msg(d,0x36, buf, 2, NULL, 0);
 	cxusb_set_i2c_path(d,PATH_CX22702);
@@ -236,9 +244,9 @@ static struct dvb_usb_properties cxusb_p
 		.endpoint = 0x02,
 		.u = {
 			.isoc = {
-				.framesperurb = 64,
-				.framesize = 940*3,
-				.interval = 1,
+				.framesperurb = 32,
+				.framesize = 940,
+				.interval = 5,
 			}
 		}
 	},

--


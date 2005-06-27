Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVF0NCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVF0NCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVF0M4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:56:37 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:8165 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262048AbVF0MQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:22 -0400
Message-Id: <20050627121416.035968000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:33 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Gavin Hamill <gdh@acentral.co.uk>
Content-Disposition: inline; filename=dvb-ttpci-hauppauge-tt-dvb-c-budget.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 33/51] ttpci: add support for Hauppauge/TT DVB-C budget
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Hamill <gdh@acentral.co.uk>

Add support for Hauppauge/TT DVB-C budget.

Signed-off-by: Gavin Hamill <gdh@acentral.co.uk>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttusb-budget/Kconfig            |    1 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   50 +++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttusb-budget/Kconfig
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttusb-budget/Kconfig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttusb-budget/Kconfig	2005-06-27 13:24:26.000000000 +0200
@@ -3,6 +3,7 @@ config DVB_TTUSB_BUDGET
 	depends on DVB_CORE && USB
 	select DVB_CX22700
 	select DVB_TDA1004X
+	select DVB_VES1820
 	select DVB_TDA8083
 	select DVB_STV0299
 	help
Index: linux-2.6.12-git8/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-06-27 13:24:26.000000000 +0200
@@ -24,6 +24,7 @@
 #include "dmxdev.h"
 #include "dvb_demux.h"
 #include "dvb_net.h"
+#include "ves1820.h"
 #include "cx22700.h"
 #include "tda1004x.h"
 #include "stv0299.h"
@@ -1367,6 +1368,47 @@ static struct tda8083_config ttusb_novas
 	.pll_set = ttusb_novas_grundig_29504_491_pll_set,
 };
 
+static int alps_tdbe2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	struct ttusb* ttusb = fe->dvb->priv;
+	u32 div;
+	u8 data[4];
+	struct i2c_msg msg = { .addr = 0x62, .flags = 0, .buf = data, .len = sizeof(data) };
+
+	div = (params->frequency + 35937500 + 31250) / 62500;
+
+	data[0] = (div >> 8) & 0x7f;
+	data[1] = div & 0xff;
+	data[2] = 0x85 | ((div >> 10) & 0x60);
+	data[3] = (params->frequency < 174000000 ? 0x88 : params->frequency < 470000000 ? 0x84 : 0x81);
+
+	if (i2c_transfer (&ttusb->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+
+	return 0;
+}
+
+
+static struct ves1820_config alps_tdbe2_config = {
+	.demod_address = 0x09,
+	.xin = 57840000UL,
+	.invert = 1,
+	.selagc = VES1820_SELAGC_SIGNAMPERR,
+	.pll_set = alps_tdbe2_pll_set,
+};
+
+static u8 read_pwm(struct ttusb* ttusb)
+{
+	u8 b = 0xff;
+	u8 pwm;
+	struct i2c_msg msg[] = { { .addr = 0x50,.flags = 0,.buf = &b,.len = 1 },
+				{ .addr = 0x50,.flags = I2C_M_RD,.buf = &pwm,.len = 1} };
+
+	if ((i2c_transfer(&ttusb->i2c_adap, msg, 2) != 2) || (pwm == 0xff))
+		pwm = 0x48;
+
+	return pwm;
+}
 
 
 static void frontend_init(struct ttusb* ttusb)
@@ -1394,6 +1436,12 @@ static void frontend_init(struct ttusb* 
 
 		break;
 
+	case 0x1004: // Hauppauge/TT DVB-C budget (ves1820/ALPS TDBE2(sp5659))
+		ttusb->fe = ves1820_attach(&alps_tdbe2_config, &ttusb->i2c_adap, read_pwm(ttusb));
+		if (ttusb->fe != NULL)
+			break;
+		break;
+
 	case 0x1005: // Hauppauge/TT Nova-USB-t budget (tda10046/Philips td1316(tda6651tt) OR cx22700/ALPS TDMB7(??))
 		// try the ALPS TDMB7 first
 		ttusb->fe = cx22700_attach(&alps_tdmb7_config, &ttusb->i2c_adap);
@@ -1570,7 +1618,7 @@ static void ttusb_disconnect(struct usb_
 
 static struct usb_device_id ttusb_table[] = {
 	{USB_DEVICE(0xb48, 0x1003)},
-/*	{USB_DEVICE(0xb48, 0x1004)},UNDEFINED HARDWARE - mail linuxtv.org list*/	/* to be confirmed ????  */
+	{USB_DEVICE(0xb48, 0x1004)},
 	{USB_DEVICE(0xb48, 0x1005)},
 	{}
 };

--


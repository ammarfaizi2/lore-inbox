Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVF0NXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVF0NXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVF0NGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:06:39 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:13541 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262056AbVF0MQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:33 -0400
Message-Id: <20050627121417.833084000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:41 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-digitv-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 41/51] usb: digitv-usb fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Some more work on the digitv-usb driver:
o MT352 initialization and PLL-programming
o I2c-transfer fixed.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/digitv.c |   69 ++++++++++++-------------------------
 1 files changed, 24 insertions(+), 45 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/digitv.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/digitv.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/digitv.c	2005-06-27 13:26:13.000000000 +0200
@@ -1,10 +1,9 @@
 /* DVB USB compliant linux driver for Nebula Electronics uDigiTV DVB-T USB2.0
  * receiver
  *
- * Copyright (C) 2005 Patrick Boettcher (patrick.boettcher@desy.de) and
- *                    Allan Third (allan.third@cs.man.ac.uk)
+ * Copyright (C) 2005 Patrick Boettcher (patrick.boettcher@desy.de)
  *
- * partly based on the SDK published by Nebula Electronics (TODO do we want this line ?)
+ * partly based on the SDK published by Nebula Electronics
  *
  *	This program is free software; you can redistribute it and/or modify it
  *	under the terms of the GNU General Public License as published by the Free
@@ -95,41 +94,20 @@ static int digitv_identify_state (struct
 
 static int digitv_mt352_demod_init(struct dvb_frontend *fe)
 {
-	static u8 mt352_clock_config[] = { 0x89, 0x38, 0x2d };
-	static u8 mt352_reset[] = { 0x50, 0x80 };
-	static u8 mt352_mclk_ratio[] = { 0x8b, 0x00 };
-
-	static u8 mt352_agc_cfg[] = { 0x68, 0xa0 };
-	static u8 mt352_adc_ctl_1_cfg[] = { 0x8E, 0xa0 };
-	static u8 mt352_acq_ctl[] = { 0x53, 0x50 };
-	static u8 mt352_agc_target[] = { 0x67, 0x20 };
-
-	static u8 mt352_rs_err_per[] = { 0x7c, 0x00, 0x01 };
-	static u8 mt352_snr_select[] = { 0x79, 0x00, 0x20 };
-
-	static u8 mt352_input_freq_1[] = { 0x56, 0x31, 0x05 };
+	static u8 reset_buf[] = { 0x89, 0x38,  0x8a, 0x2d, 0x50, 0x80 };
+	static u8 init_buf[] = { 0x68, 0xa0,  0x8e, 0x40,  0x53, 0x50,
+			0x67, 0x20,  0x7d, 0x01,  0x7c, 0x00,  0x7a, 0x00,
+			0x79, 0x20,  0x57, 0x05,  0x56, 0x31,  0x88, 0x0f,
+			0x75, 0x32 };
+	int i;
 
-	static u8 mt352_scan_ctl[] = { 0x88, 0x0f };
-	static u8 mt352_capt_range[] = { 0x75, 0x32 };
+	for (i = 0; i < ARRAY_SIZE(reset_buf); i += 2)
+		mt352_write(fe, &reset_buf[i], 2);
 
-	mt352_write(fe, mt352_clock_config, sizeof(mt352_clock_config));
-	mt352_write(fe, mt352_reset, sizeof(mt352_reset));
 	msleep(1);
-	mt352_write(fe, mt352_mclk_ratio, sizeof(mt352_mclk_ratio));
-
-	mt352_write(fe, mt352_agc_cfg, sizeof(mt352_agc_cfg));
-	mt352_write(fe, mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
-	mt352_write(fe, mt352_acq_ctl, sizeof(mt352_acq_ctl));
-	mt352_write(fe, mt352_agc_target, sizeof(mt352_agc_target));
-
-
-	mt352_write(fe, mt352_rs_err_per, sizeof(mt352_rs_err_per));
-	mt352_write(fe, mt352_snr_select, sizeof(mt352_snr_select));
 
-	mt352_write(fe, mt352_input_freq_1, sizeof(mt352_input_freq_1));
-
-	mt352_write(fe, mt352_scan_ctl, sizeof(mt352_scan_ctl));
-	mt352_write(fe, mt352_capt_range, sizeof(mt352_capt_range));
+	for (i = 0; i < ARRAY_SIZE(init_buf); i += 2)
+		mt352_write(fe, &init_buf[i], 2);
 
 	return 0;
 }
@@ -137,7 +115,7 @@ static int digitv_mt352_demod_init(struc
 static struct mt352_config digitv_mt352_config = {
 	.demod_address = 0x0, /* ignored by the digitv anyway */
 	.demod_init = digitv_mt352_demod_init,
-	.pll_set = NULL, /* TODO */
+	.pll_set = dvb_usb_pll_set,
 };
 
 static struct nxt6000_config digitv_nxt6000_config = {
@@ -150,9 +128,9 @@ static struct nxt6000_config digitv_nxt6
 
 static int digitv_frontend_attach(struct dvb_usb_device *d)
 {
-	if ((d->fe = mt352_attach(&digitv_mt352_config, &d->i2c_adap)) == NULL)
+	if ((d->fe = mt352_attach(&digitv_mt352_config, &d->i2c_adap)) != NULL)
 		return 0;
-	if ((d->fe = nxt6000_attach(&digitv_nxt6000_config, &d->i2c_adap)) == NULL) {
+	if ((d->fe = nxt6000_attach(&digitv_nxt6000_config, &d->i2c_adap)) != NULL) {
 
 		warn("nxt6000 support is not done yet, in fact you are one of the first "
 				"person who wants to use this device in Linux. Please report to "
@@ -163,6 +141,13 @@ static int digitv_frontend_attach(struct
 	return -EIO;
 }
 
+static int digitv_tuner_attach(struct dvb_usb_device *d)
+{
+	d->pll_addr = 0x60;
+	d->pll_desc = &dvb_pll_tded4;
+	return 0;
+}
+
 static struct dvb_usb_rc_key digitv_rc_keys[] = {
 	{ 0x00, 0x16, KEY_POWER }, /* dummy key */
 };
@@ -184,7 +169,6 @@ int digitv_rc_query(struct dvb_usb_devic
 	return 0;
 }
 
-
 /* DVB USB Driver stuff */
 static struct dvb_usb_properties digitv_properties;
 
@@ -208,13 +192,8 @@ static struct dvb_usb_properties digitv_
 
 	.size_of_priv     = 0,
 
-	.streaming_ctrl   = NULL,
-	.pid_filter       = NULL,
-	.pid_filter_ctrl  = NULL,
-	.power_ctrl       = NULL,
 	.frontend_attach  = digitv_frontend_attach,
-	.tuner_attach     = NULL, // digitv_tuner_attach,
-	.read_mac_address = NULL,
+	.tuner_attach     = digitv_tuner_attach,
 
 	.rc_interval      = 1000,
 	.rc_key_map       = digitv_rc_keys,
@@ -238,7 +217,7 @@ static struct dvb_usb_properties digitv_
 		}
 	},
 
-	.num_device_descs = 2,
+	.num_device_descs = 1,
 	.devices = {
 		{   "Nebula Electronics uDigiTV DVB-T USB2.0)",
 			{ &digitv_table[0], NULL },

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVCVGld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVCVGld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVCVB4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:56:33 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:33419 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262338AbVCVBfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:53 -0500
Message-Id: <20050322013459.787845000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:13 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-hanftek-umt-010.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 40/48] dibusb: HanfTek UMT-010 fixes
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HanfTek UMT-010: adapted the pll-programming, the usb-ids and the firmware name
to the new firmware (thanks to Sunny Liu from HanfTek)
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-core.c   |    8 ++++----
 dvb-dibusb-fe-i2c.c |   49 +++++++++++++++++++++++--------------------------
 dvb-dibusb-usb.c    |    4 +---
 3 files changed, 28 insertions(+), 33 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:18:30.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:27:58.000000000 +0100
@@ -98,7 +98,7 @@ MODULE_PARM_DESC(rc_key_repeat_count, "h
 #define USB_PID_UNK_HYPER_PALTEK_COLD		0x005e
 #define USB_PID_UNK_HYPER_PALTEK_WARM		0x005f
 #define USB_PID_HANFTEK_UMT_010_COLD		0x0001
-#define USB_PID_HANFTEK_UMT_010_WARM		0x0025
+#define USB_PID_HANFTEK_UMT_010_WARM		0x0015
 #define USB_PID_YAKUMO_DTT200U_COLD			0x0201
 #define USB_PID_YAKUMO_DTT200U_WARM			0x0301
 #define USB_PID_WINTV_NOVA_T_USB2_COLD		0x9300
@@ -235,9 +235,9 @@ static struct dibusb_device_class dibusb
 	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5],
 	},
 	{ UMT2_0, &dibusb_usb_ctrl[2],
-	  "dvb-dibusb-umt-1.fw",
-	  0x01, 0x02, 
-	  7, 188*21,
+	  "dvb-dibusb-umt-2.fw",
+	  0x01, 0x06,
+	  20, 512,
 	  DIBUSB_RC_NO,
 	  &dibusb_demod[DIBUSB_MT352],
 	  &dibusb_tuner[DIBUSB_TUNER_CABLE_LG_TDTP_E102P],
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:18:55.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:27:58.000000000 +0100
@@ -345,8 +345,6 @@ static int panasonic_cofdm_env57h1xd5_pl
  *             BSn = 0 corresponding port is off, high-impedance state (at power-on)
  *             BSn = 1 corresponding port is on
  */
-
-
 static int panasonic_cofdm_env77h11d5_tda6650_init(struct dvb_frontend *fe, u8 pllbuf[4])
 {
 	pllbuf[0] = 0x0b;
@@ -441,55 +439,54 @@ static int panasonic_cofdm_env77h11d5_td
  *          0	1	c2 (always valid)
  *          1	0	c4
  *          1	1	c6
- *
- *
- *
  */
-
 static int lg_tdtp_e102p_tua6034(struct dvb_frontend_parameters* fep, u8 pllbuf[4])
 {
 	u32 div;
-	u8 p3210, p4;
+	u8 p210, p3;
 
 #define TUNER_MUL 62500
 
 	div = (fep->frequency + 36125000 + TUNER_MUL / 2) / TUNER_MUL;
+//	div = ((fep->frequency/1000 + 36166) * 6) / 1000;
 
 	if (fep->frequency < 174500000)
-		p3210 = 1; // not supported by the tdtp_e102p
+		p210 = 1; // not supported by the tdtp_e102p
 	else if (fep->frequency < 230000000) // VHF
-		p3210 = 2;
+		p210 = 2;
 	else
-		p3210 = 4;
+		p210 = 4;
 
 	if (fep->u.ofdm.bandwidth == BANDWIDTH_7_MHZ)
-		p4 = 0;
+		p3 = 0;
 	else
-		p4 = 1;
+		p3 = 1;
 
 	pllbuf[0] = (div >> 8) & 0x7f;
 	pllbuf[1] = div & 0xff;
 	pllbuf[2] = 0xce;
-	pllbuf[3] = (p4 << 4) | p3210;
+//	pllbuf[2] = 0xcc;
+	pllbuf[3] = (p3 << 3) | p210;
 
 	return 0;
 }
 
 static int lg_tdtp_e102p_mt352_demod_init(struct dvb_frontend *fe)
 {
-	static u8 mt352_clock_config[] = { 0x89, 0xb0, 0x2d };
+	static u8 mt352_clock_config[] = { 0x89, 0xb8, 0x2d };
 	static u8 mt352_reset[] = { 0x50, 0x80 };
 	static u8 mt352_mclk_ratio[] = { 0x8b, 0x00 };
 	static u8 mt352_adc_ctl_1_cfg[] = { 0x8E, 0x40 };
-	static u8 mt352_agc_cfg[] = { 0x67, 0x14, 0x22 };
-	static u8 mt352_sec_agc_cfg[] = { 0x69, 0x00, 0xff, 0xff, 0x00, 0xff, 0x00, 0x40, 0x40 };
-
-	static u8 mt352_unk [] = { 0xb5, 0x7a };
+	static u8 mt352_agc_cfg[] = { 0x67, 0x10, 0xa0 };
 
-	static u8 mt352_acq_ctl[] = { 0x53, 0x5f };
-	static u8 mt352_input_freq_1[] = { 0x56, 0xf1, 0x05 };
+	static u8 mt352_sec_agc_cfg1[] = { 0x6a, 0xff };
+	static u8 mt352_sec_agc_cfg2[] = { 0x6d, 0xff };
+	static u8 mt352_sec_agc_cfg3[] = { 0x70, 0x40 };
+	static u8 mt352_sec_agc_cfg4[] = { 0x7b, 0x03 };
+	static u8 mt352_sec_agc_cfg5[] = { 0x7d, 0x0f };
 
-//	static u8 mt352_capt_range_cfg[] = { 0x75, 0x32 };
+	static u8 mt352_acq_ctl[] = { 0x53, 0x50 };
+	static u8 mt352_input_freq_1[] = { 0x56, 0x31, 0x06 };
 
 	mt352_write(fe, mt352_clock_config, sizeof(mt352_clock_config));
 	udelay(2000);
@@ -499,15 +496,15 @@ static int lg_tdtp_e102p_mt352_demod_ini
 	mt352_write(fe, mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
 	mt352_write(fe, mt352_agc_cfg, sizeof(mt352_agc_cfg));
 
-	mt352_write(fe, mt352_sec_agc_cfg, sizeof(mt352_sec_agc_cfg));
-
-	mt352_write(fe, mt352_unk, sizeof(mt352_unk));
+	mt352_write(fe, mt352_sec_agc_cfg1, sizeof(mt352_sec_agc_cfg1));
+	mt352_write(fe, mt352_sec_agc_cfg2, sizeof(mt352_sec_agc_cfg2));
+	mt352_write(fe, mt352_sec_agc_cfg3, sizeof(mt352_sec_agc_cfg3));
+	mt352_write(fe, mt352_sec_agc_cfg4, sizeof(mt352_sec_agc_cfg4));
+	mt352_write(fe, mt352_sec_agc_cfg5, sizeof(mt352_sec_agc_cfg5));
 
 	mt352_write(fe, mt352_acq_ctl, sizeof(mt352_acq_ctl));
 	mt352_write(fe, mt352_input_freq_1, sizeof(mt352_input_freq_1));
 
-//	mt352_write(fe, mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
-
 	return 0;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:18:30.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:27:58.000000000 +0100
@@ -143,14 +143,12 @@ int dibusb_streaming(struct usb_dibusb *
 		case DIBUSB2_0:
 		case DIBUSB2_0B:
 		case NOVAT_USB2:
+		case UMT2_0:
 			if (onoff)
 				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_ENABLE_STREAM,NULL,0);
 			else
 				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_DISABLE_STREAM,NULL,0);
 			break;
-		case UMT2_0:
-			return dibusb_set_streaming_mode(dib,onoff);
-			break;
 		default:
 			break;
 	}

--


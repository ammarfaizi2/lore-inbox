Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVGBCCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVGBCCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbVGBCB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:01:26 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:15340 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261691AbVGBBzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:23 -0400
Message-Id: <20050702015619.399394000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:13 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-wideview-wt220u.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 7/8] usb: add supprt for WideView WT-220U
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add support and rewrote some parts with the help of vendor information
(Thanks to Steve Chang from WideView, Inc.):
o added support for the WT-220U (Pensize DVB-T receiver)
o corrected byte order for unc,ber and the pid filter
o corrected number of pids that can be fetched at the same time.
o added some comments in Kconfig-file
o added USB IDs for the WT-220U

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/Kconfig       |    4 +
 drivers/media/dvb/dvb-usb/dtt200u-fe.c  |   72 +++++++++++++-------------
 drivers/media/dvb/dvb-usb/dtt200u.c     |   86 +++++++++++++++++++++++++++-----
 drivers/media/dvb/dvb-usb/dtt200u.h     |   38 +++++---------
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    3 -
 5 files changed, 130 insertions(+), 73 deletions(-)

Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/Kconfig
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/Kconfig	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/Kconfig	2005-07-02 03:22:32.000000000 +0200
@@ -109,9 +109,11 @@ config DVB_USB_NOVA_T_USB2
 	  Say Y here to support the Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 receiver.
 
 config DVB_USB_DTT200U
-	tristate "WideView/Yakumo/Hama/Typhoon/Yuan DVB-T USB2.0 support"
+	tristate "WideView WT-200U and WT-220U (pen) DVB-T USB2.0 support (Yakumo/Hama/Typhoon/Yuan)"
 	depends on DVB_USB
 	help
 	  Say Y here to support the WideView/Yakumo/Hama/Typhoon/Yuan DVB-T USB2.0 receiver.
 
 	  The receivers are also known as DTT200U (Yakumo) and UB300 (Yuan).
+
+	  The WT-220U and its clones are pen-sized.
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dtt200u-fe.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dtt200u-fe.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dtt200u-fe.c	2005-07-02 03:22:32.000000000 +0200
@@ -14,61 +14,58 @@
 struct dtt200u_fe_state {
 	struct dvb_usb_device *d;
 
+	fe_status_t stat;
+
 	struct dvb_frontend_parameters fep;
 	struct dvb_frontend frontend;
 };
 
-#define moan(which,what) info("unexpected value in '%s' for cmd '%02x' - please report to linux-dvb@linuxtv.org",which,what)
-
 static int dtt200u_fe_read_status(struct dvb_frontend* fe, fe_status_t *stat)
 {
 	struct dtt200u_fe_state *state = fe->demodulator_priv;
-	u8 bw = GET_TUNE_STAT;
-	u8 br[3] = { 0 };
-//	u8 bdeb[5] = { 0 };
+	u8 st = GET_TUNE_STATUS, b[3];
+
+	dvb_usb_generic_rw(state->d,&st,1,b,3,0);
 
-	dvb_usb_generic_rw(state->d,&bw,1,br,3,0);
-	switch (br[0]) {
+	switch (b[0]) {
 		case 0x01:
-			*stat = FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_SYNC | FE_HAS_LOCK;
+			*stat = FE_HAS_SIGNAL | FE_HAS_CARRIER |
+				FE_HAS_VITERBI | FE_HAS_SYNC | FE_HAS_LOCK;
 			break;
-		case 0x00:
-			*stat = 0;
+		case 0x00: /* pending */
+			*stat = FE_TIMEDOUT; /* during set_frontend */
 			break;
 		default:
-			moan("br[0]",GET_TUNE_STAT);
+		case 0x02: /* failed */
+			*stat = 0;
 			break;
 	}
-
-//	bw[0] = 0x88;
-//	dvb_usb_generic_rw(state->d,bw,1,bdeb,5,0);
-
-//	deb_info("%02x: %02x %02x %02x %02x %02x\n",bw[0],bdeb[0],bdeb[1],bdeb[2],bdeb[3],bdeb[4]);
-
 	return 0;
 }
+
 static int dtt200u_fe_read_ber(struct dvb_frontend* fe, u32 *ber)
 {
 	struct dtt200u_fe_state *state = fe->demodulator_priv;
-	u8 bw = GET_BER;
-	*ber = 0;
-	dvb_usb_generic_rw(state->d,&bw,1,(u8*) ber,3,0);
+	u8 bw = GET_VIT_ERR_CNT,b[3];
+	dvb_usb_generic_rw(state->d,&bw,1,b,3,0);
+	*ber = (b[0] << 16) | (b[1] << 8) | b[2];
 	return 0;
 }
 
 static int dtt200u_fe_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
 {
 	struct dtt200u_fe_state *state = fe->demodulator_priv;
-	u8 bw = GET_UNK;
-	*unc = 0;
-	dvb_usb_generic_rw(state->d,&bw,1,(u8*) unc,3,0);
+	u8 bw = GET_RS_UNCOR_BLK_CNT,b[2];
+
+	dvb_usb_generic_rw(state->d,&bw,1,b,2,0);
+	*unc = (b[0] << 8) | b[1];
 	return 0;
 }
 
 static int dtt200u_fe_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
 {
 	struct dtt200u_fe_state *state = fe->demodulator_priv;
-	u8 bw = GET_SIG_STRENGTH, b;
+	u8 bw = GET_AGC, b;
 	dvb_usb_generic_rw(state->d,&bw,1,&b,1,0);
 	*strength = (b << 8) | b;
 	return 0;
@@ -86,7 +83,7 @@ static int dtt200u_fe_read_snr(struct dv
 static int dtt200u_fe_init(struct dvb_frontend* fe)
 {
 	struct dtt200u_fe_state *state = fe->demodulator_priv;
-	u8 b = RESET_DEMOD;
+	u8 b = SET_INIT;
 	return dvb_usb_generic_write(state->d,&b,1);
 }
 
@@ -98,8 +95,8 @@ static int dtt200u_fe_sleep(struct dvb_f
 static int dtt200u_fe_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
 {
 	tune->min_delay_ms = 1500;
-	tune->step_size = 166667;
-	tune->max_drift = 166667 * 2;
+	tune->step_size = 0;
+	tune->max_drift = 0;
 	return 0;
 }
 
@@ -107,27 +104,32 @@ static int dtt200u_fe_set_frontend(struc
 				  struct dvb_frontend_parameters *fep)
 {
 	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	int i;
+	fe_status_t st;
 	u16 freq = fep->frequency / 250000;
-	u8 bw,bwbuf[2] = { SET_BANDWIDTH, 0 }, freqbuf[3] = { SET_FREQUENCY, 0, 0 };
+	u8 bwbuf[2] = { SET_BANDWIDTH, 0 },freqbuf[3] = { SET_RF_FREQ, 0, 0 };
 
 	switch (fep->u.ofdm.bandwidth) {
-		case BANDWIDTH_8_MHZ: bw = 8; break;
-		case BANDWIDTH_7_MHZ: bw = 7; break;
-		case BANDWIDTH_6_MHZ: bw = 6; break;
+		case BANDWIDTH_8_MHZ: bwbuf[1] = 8; break;
+		case BANDWIDTH_7_MHZ: bwbuf[1] = 7; break;
+		case BANDWIDTH_6_MHZ: bwbuf[1] = 6; break;
 		case BANDWIDTH_AUTO: return -EOPNOTSUPP;
 		default:
 			return -EINVAL;
 	}
-	deb_info("set_frontend\n");
 
-	bwbuf[1] = bw;
 	dvb_usb_generic_write(state->d,bwbuf,2);
 
 	freqbuf[1] = freq & 0xff;
 	freqbuf[2] = (freq >> 8) & 0xff;
 	dvb_usb_generic_write(state->d,freqbuf,3);
 
-	memcpy(&state->fep,fep,sizeof(struct dvb_frontend_parameters));
+	for (i = 0; i < 30; i++) {
+		msleep(20);
+		dtt200u_fe_read_status(fe, &st);
+		if (st & FE_TIMEDOUT)
+			continue;
+	}
 
 	return 0;
 }
@@ -174,7 +176,7 @@ success:
 
 static struct dvb_frontend_ops dtt200u_fe_ops = {
 	.info = {
-		.name			= "DTT200U (Yakumo/Typhoon/Hama) DVB-T",
+		.name			= "WideView USB DVB-T",
 		.type			= FE_OFDM,
 		.frequency_min		= 44250000,
 		.frequency_max		= 867250000,
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dtt200u.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dtt200u.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dtt200u.c	2005-07-02 03:22:32.000000000 +0200
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
+ * Thanks to Steve Chang from WideView for providing support for the WT-220U.
+ *
  *	This program is free software; you can redistribute it and/or modify it
  *	under the terms of the GNU General Public License as published by the Free
  *	Software Foundation, version 2.
@@ -16,14 +18,24 @@ int dvb_usb_dtt200u_debug;
 module_param_named(debug,dvb_usb_dtt200u_debug, int, 0644);
 MODULE_PARM_DESC(debug, "set debugging level (1=info,xfer=2 (or-able))." DVB_USB_DEBUG_STATUS);
 
+static int dtt200u_power_ctrl(struct dvb_usb_device *d, int onoff)
+{
+	u8 b = SET_INIT;
+
+	if (onoff)
+		dvb_usb_generic_write(d,&b,2);
+
+	return 0;
+}
+
 static int dtt200u_streaming_ctrl(struct dvb_usb_device *d, int onoff)
 {
-	u8 b_streaming[2] = { SET_TS_CTRL, onoff };
+	u8 b_streaming[2] = { SET_STREAMING, onoff };
 	u8 b_rst_pid = RESET_PID_FILTER;
 
 	dvb_usb_generic_write(d,b_streaming,2);
 
-	if (!onoff)
+	if (onoff == 0)
 		dvb_usb_generic_write(d,&b_rst_pid,1);
 	return 0;
 }
@@ -36,7 +48,7 @@ static int dtt200u_pid_filter(struct dvb
 	b_pid[0] = SET_PID_FILTER;
 	b_pid[1] = index;
 	b_pid[2] = pid & 0xff;
-	b_pid[3] = (pid >> 8) & 0xff;
+	b_pid[3] = (pid >> 8) & 0x1f;
 
 	return dvb_usb_generic_write(d,b_pid,4);
 }
@@ -54,9 +66,9 @@ static struct dvb_usb_rc_key dtt200u_rc_
 	{ 0x80, 0x08, KEY_5 },
 	{ 0x80, 0x09, KEY_6 },
 	{ 0x80, 0x0a, KEY_7 },
-	{ 0x00, 0x0c, KEY_ZOOM },
+	{ 0x80, 0x0c, KEY_ZOOM },
 	{ 0x80, 0x0d, KEY_0 },
-	{ 0x00, 0x0e, KEY_SELECT },
+	{ 0x80, 0x0e, KEY_SELECT },
 	{ 0x80, 0x12, KEY_POWER },
 	{ 0x80, 0x1a, KEY_CHANNELUP },
 	{ 0x80, 0x1b, KEY_8 },
@@ -66,7 +78,7 @@ static struct dvb_usb_rc_key dtt200u_rc_
 
 static int dtt200u_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
 {
-	u8 key[5],cmd = GET_RC_KEY;
+	u8 key[5],cmd = GET_RC_CODE;
 	dvb_usb_generic_rw(d,&cmd,1,key,5,0);
 	dvb_usb_nec_rc_key_to_event(d,key,event,state);
 	if (key[0] != 0)
@@ -81,32 +93,41 @@ static int dtt200u_frontend_attach(struc
 }
 
 static struct dvb_usb_properties dtt200u_properties;
+static struct dvb_usb_properties wt220u_properties;
 
 static int dtt200u_usb_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&dtt200u_properties,THIS_MODULE);
+	if (dvb_usb_device_init(intf,&dtt200u_properties,THIS_MODULE) == 0 ||
+		dvb_usb_device_init(intf,&wt220u_properties,THIS_MODULE) == 0)
+		return 0;
+
+	return -ENODEV;
 }
 
 static struct usb_device_id dtt200u_usb_table [] = {
+//		{ USB_DEVICE(0x04b4,0x8613) },
 	    { USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_COLD) },
 	    { USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_WARM) },
+		{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_COLD)  },
+		{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_WARM)  },
 	    { 0 },
 };
 MODULE_DEVICE_TABLE(usb, dtt200u_usb_table);
 
 static struct dvb_usb_properties dtt200u_properties = {
 	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_NEED_PID_FILTERING,
-	.pid_filter_count = 255, /* It is a guess, but there are at least 10 */
+	.pid_filter_count = 15,
 
 	.usb_ctrl = CYPRESS_FX2,
 	.firmware = "dvb-usb-dtt200u-01.fw",
 
+	.power_ctrl      = dtt200u_power_ctrl,
 	.streaming_ctrl  = dtt200u_streaming_ctrl,
 	.pid_filter      = dtt200u_pid_filter,
 	.frontend_attach = dtt200u_frontend_attach,
 
-	.rc_interval     = 200,
+	.rc_interval     = 300,
 	.rc_key_map      = dtt200u_rc_keys,
 	.rc_key_map_size = ARRAY_SIZE(dtt200u_rc_keys),
 	.rc_query        = dtt200u_rc_query,
@@ -127,7 +148,7 @@ static struct dvb_usb_properties dtt200u
 
 	.num_device_descs = 1,
 	.devices = {
-		{ .name = "WideView/Yakumo/Hama/Typhoon DVB-T USB2.0)",
+		{ .name = "WideView/Yuan/Yakumo/Hama/Typhoon DVB-T USB2.0 (WT-200U)",
 		  .cold_ids = { &dtt200u_usb_table[0], NULL },
 		  .warm_ids = { &dtt200u_usb_table[1], NULL },
 		},
@@ -135,10 +156,51 @@ static struct dvb_usb_properties dtt200u
 	}
 };
 
+static struct dvb_usb_properties wt220u_properties = {
+	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_NEED_PID_FILTERING,
+	.pid_filter_count = 15,
+
+	.usb_ctrl = CYPRESS_FX2,
+	.firmware = "dvb-usb-wt220u-01.fw",
+
+	.power_ctrl      = dtt200u_power_ctrl,
+	.streaming_ctrl  = dtt200u_streaming_ctrl,
+	.pid_filter      = dtt200u_pid_filter,
+	.frontend_attach = dtt200u_frontend_attach,
+
+	.rc_interval     = 300,
+	.rc_key_map      = dtt200u_rc_keys,
+	.rc_key_map_size = ARRAY_SIZE(dtt200u_rc_keys),
+	.rc_query        = dtt200u_rc_query,
+
+	.generic_bulk_ctrl_endpoint = 0x01,
+
+	/* parameter for the MPEG2-data transfer */
+	.urb = {
+		.type = DVB_USB_BULK,
+		.count = 7,
+		.endpoint = 0x02,
+		.u = {
+			.bulk = {
+				.buffersize = 4096,
+			}
+		}
+	},
+
+	.num_device_descs = 1,
+	.devices = {
+		{ .name = "WideView WT-220U PenType Receiver (and clones)",
+		  .cold_ids = { &dtt200u_usb_table[2], NULL },
+		  .warm_ids = { &dtt200u_usb_table[3], NULL },
+		},
+		{ 0 },
+	}
+};
+
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver dtt200u_usb_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "dtt200u",
+	.name		= "dvb_usb_dtt200u",
 	.probe 		= dtt200u_usb_probe,
 	.disconnect = dvb_usb_device_exit,
 	.id_table 	= dtt200u_usb_table,
@@ -166,6 +228,6 @@ module_init(dtt200u_usb_module_init);
 module_exit(dtt200u_usb_module_exit);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de>");
-MODULE_DESCRIPTION("Driver for the WideView/Yakumo/Hama/Typhoon DVB-T USB2.0 device");
+MODULE_DESCRIPTION("Driver for the WideView/Yakumo/Hama/Typhoon DVB-T USB2.0 devices");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dtt200u.h
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dtt200u.h	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dtt200u.h	2005-07-02 03:22:32.000000000 +0200
@@ -22,44 +22,34 @@ extern int dvb_usb_dtt200u_debug;
 /* guessed protocol description (reverse engineered):
  * read
  *  00 - USB type 0x02 for usb2.0, 0x01 for usb1.1
- *  81 - <TS_LOCK> <current frequency divided by 250000>
- *  82 - crash - do not touch
- *  83 - crash - do not touch
- *  84 - remote control
- *  85 - crash - do not touch (OK, stop testing here)
  *  88 - locking 2 bytes (0x80 0x40 == no signal, 0x89 0x20 == nice signal)
- *  89 - noise-to-signal
- *	8a - unkown 1 byte - signal_strength
- *  8c - ber ???
- *  8d - ber
- *  8e - unc
  */
 
-#define GET_SPEED        0x00
-#define GET_TUNE_STAT    0x81
-#define GET_RC_KEY       0x84
-#define GET_STATUS       0x88
-#define GET_SNR          0x89
-#define GET_SIG_STRENGTH 0x8a
-#define GET_UNK          0x8c
-#define GET_BER          0x8d
-#define GET_UNC          0x8e
+#define GET_SPEED            0x00
+#define GET_TUNE_STATUS      0x81
+#define GET_RC_CODE          0x84
+#define GET_CONFIGURATION    0x88
+#define GET_AGC              0x89
+#define GET_SNR              0x8a
+#define GET_VIT_ERR_CNT      0x8c
+#define GET_RS_ERR_CNT       0x8d
+#define GET_RS_UNCOR_BLK_CNT 0x8e
 
 /* write
- *  01 - reset the demod
+ *  01 - init
  *  02 - frequency (divided by 250000)
  *  03 - bandwidth
  *  04 - pid table (index pid(7:0) pid(12:8))
  *  05 - reset the pid table
- *  08 - demod transfer enabled or not (FX2 transfer is enabled by default)
+ *  08 - transfer switch
  */
 
-#define RESET_DEMOD      0x01
-#define SET_FREQUENCY    0x02
+#define SET_INIT         0x01
+#define SET_RF_FREQ      0x02
 #define SET_BANDWIDTH    0x03
 #define SET_PID_FILTER   0x04
 #define RESET_PID_FILTER 0x05
-#define SET_TS_CTRL      0x08
+#define SET_STREAMING    0x08
 
 extern struct dvb_frontend * dtt200u_fe_attach(struct dvb_usb_device *d);
 
Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dvb-usb-ids.h
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-07-02 03:22:32.000000000 +0200
@@ -72,6 +72,8 @@
 #define USB_PID_HANFTEK_UMT_010_WARM		0x0015
 #define USB_PID_DTT200U_COLD				0x0201
 #define USB_PID_DTT200U_WARM				0x0301
+#define USB_PID_WT220U_COLD					0x0222
+#define USB_PID_WT220U_WARM					0x0221
 #define USB_PID_WINTV_NOVA_T_USB2_COLD		0x9300
 #define USB_PID_WINTV_NOVA_T_USB2_WARM		0x9301
 #define USB_PID_NEBULA_DIGITV				0x0201
@@ -84,5 +86,4 @@
 #define USB_PID_KYE_DVB_T_COLD				0x701e
 #define USB_PID_KYE_DVB_T_WARM				0x701f
 
-
 #endif

--


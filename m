Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753133AbVHHAIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbVHHAIt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbVHHAIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:08:49 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:38091 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1753133AbVHHAIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:08:48 -0400
Message-ID: <42F6A294.90300@linuxtv.org>
Date: Sun, 07 Aug 2005 20:08:52 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, linux-dvb-maintainer@linuxtv.org,
       Mac Michaels <wmichaels1@earthlink.net>,
       Michael Krufky <mkrufky@m1k.net>
Subject: [PATCH] DVB: lgdt330x frontend: some bug fixes & add lgdt3303 support
Content-Type: multipart/mixed;
 boundary="------------020805030600050604030500"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020805030600050604030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

For 2.6.13, if possible.  Patch generated against 2.6.13-rc6

-- 
Michael Krufky





--------------020805030600050604030500
Content-Type: text/plain;
 name="lgdt330x-structure-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lgdt330x-structure-update.patch"

- Structural changes within lgdt330x driver, framework now supports
  both chips... tested OK on lgdt3302 and lgdt3303.
- Add LG/TUA6034 dvb_pll_desc for ATSC with LG TDVS-H062F & DViCO FusionHDTV5.
- Fixed LGDT330X signal strength: For now, always set it to 0.
- Corrected LGDT330X boundary condition error in read_snr: dB calculation.

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
-

 linux/drivers/media/dvb/frontends/dvb-pll.c       |   16 
 linux/drivers/media/dvb/frontends/dvb-pll.h       |    1 
 linux/drivers/media/dvb/frontends/lgdt330x.c      |  549 +++++++++-----
 linux/drivers/media/dvb/frontends/lgdt330x.h      |   16 
 linux/drivers/media/dvb/frontends/lgdt330x_priv.h |    8 
 linux/drivers/media/video/cx88/cx88-dvb.c         |   26 
 6 files changed, 443 insertions(+), 173 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c linux/drivers/media/dvb/frontends/lgdt330x.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.c	2005-08-07 18:35:08.000000000 +0000
@@ -1,11 +1,8 @@
 /*
- *    Support for LGDT3302 & LGDT3303 (DViCO FusionHDTV Gold) - VSB/QAM
+ *    Support for LGDT3302 and LGDT3303 - VSB/QAM
  *
  *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
  *
- *    Based on code from  Kirk Lapray <kirk_lapray@bigfoot.com>
- *                           Copyright (C) 2005
- *
  *    This program is free software; you can redistribute it and/or modify
  *    it under the terms of the GNU General Public License as published by
  *    the Free Software Foundation; either version 2 of the License, or
@@ -25,11 +22,13 @@
 /*
  *                      NOTES ABOUT THIS DRIVER
  *
- * This driver supports DViCO FusionHDTV Gold under Linux.
+ * This Linux driver supports:
+ *   DViCO FusionHDTV 3 Gold-Q
+ *   DViCO FusionHDTV 3 Gold-T
+ *   DViCO FusionHDTV 5 Gold
  *
  * TODO:
- * BER and signal strength always return 0.
- * Include support for LGDT3303
+ * signal strength always returns 0.
  *
  */
 
@@ -41,7 +40,6 @@
 #include <asm/byteorder.h>
 
 #include "dvb_frontend.h"
-#include "dvb-pll.h"
 #include "lgdt330x_priv.h"
 #include "lgdt330x.h"
 
@@ -70,55 +68,37 @@
 	u32 current_frequency;
 };
 
-static int i2c_writebytes (struct lgdt330x_state* state,
-			   u8 addr, /* demod_address or pll_address */
+static int i2c_write_demod_bytes (struct lgdt330x_state* state,
 			   u8 *buf, /* data bytes to send */
 			   int len  /* number of bytes to send */ )
 {
-	u8 tmp[] = { buf[0], buf[1] };
 	struct i2c_msg msg =
-		{ .addr = addr, .flags = 0, .buf = tmp,  .len = 2 };
-	int err;
+		{ .addr = state->config->demod_address,
+		  .flags = 0, 
+		  .buf = buf,
+		  .len = 2 };
 	int i;
+	int err;
 
-	for (i=1; i<len; i++) {
-		tmp[1] = buf[i];
+	for (i=0; i<len-1; i+=2){
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
+			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, msg.buf[0], msg.buf[1], err);
 			if (err < 0)
 				return err;
 			else
 				return -EREMOTEIO;
 		}
-		tmp[0]++;
-	}
-	return 0;
-}
-
-#if 0
-static int i2c_readbytes (struct lgdt330x_state* state,
-			  u8 addr, /* demod_address or pll_address */
-			  u8 *buf, /* holds data bytes read */
-			  int len  /* number of bytes to read */ )
-{
-	struct i2c_msg msg =
-		{ .addr = addr, .flags = I2C_M_RD, .buf = buf,  .len = len };
-	int err;
-
-	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-		printk(KERN_WARNING "lgdt330x: %s error (addr %02x, err == %i)\n", __FUNCTION__, addr, err);
-		return -EREMOTEIO;
+		msg.buf += 2;
 	}
 	return 0;
 }
-#endif
 
 /*
  * This routine writes the register (reg) to the demod bus
  * then reads the data returned for (len) bytes.
  */
 
-static u8 i2c_selectreadbytes (struct lgdt330x_state* state,
+static u8 i2c_read_demod_bytes (struct lgdt330x_state* state,
 			       enum I2C_REG reg, u8* buf, int len)
 {
 	u8 wr [] = { reg };
@@ -139,7 +119,7 @@
 }
 
 /* Software reset */
-int lgdt330x_SwReset(struct lgdt330x_state* state)
+static int lgdt3302_SwReset(struct lgdt330x_state* state)
 {
 	u8 ret;
 	u8 reset[] = {
@@ -148,23 +128,83 @@
 		      *	bits 5-0 are 1 to mask interrupts */
 	};
 
-	ret = i2c_writebytes(state,
-			     state->config->demod_address,
+	ret = i2c_write_demod_bytes(state,
+			     reset, sizeof(reset));
+	if (ret == 0) {
+
+		/* force reset high (inactive) and unmask interrupts */
+		reset[1] = 0x7f;
+		ret = i2c_write_demod_bytes(state,
+				     reset, sizeof(reset));
+	}
+	return ret;
+}
+
+static int lgdt3303_SwReset(struct lgdt330x_state* state)
+{
+	u8 ret;
+	u8 reset[] = {
+		0x02,
+		0x00 /* bit 0 is active low software reset */
+	};
+
+	ret = i2c_write_demod_bytes(state,
 			     reset, sizeof(reset));
 	if (ret == 0) {
-		/* spec says reset takes 100 ns why wait */
-		/* mdelay(100);    */ /* keep low for 100mS */
-		reset[1] = 0x7f;      /* force reset high (inactive)
-				       * and unmask interrupts */
-		ret = i2c_writebytes(state,
-				     state->config->demod_address,
+
+		/* force reset high (inactive) */
+		reset[1] = 0x01;
+		ret = i2c_write_demod_bytes(state,
 				     reset, sizeof(reset));
 	}
-	/* Spec does not indicate a need for this either */
-	/*mdelay(5); */               /* wait 5 msec before doing more */
 	return ret;
 }
 
+static int lgdt330x_SwReset(struct lgdt330x_state* state)
+{
+	switch (state->config->demod_chip) {
+	case LGDT3302:
+		return lgdt3302_SwReset(state);
+	case LGDT3303:
+		return lgdt3303_SwReset(state);
+	default:
+		return -ENODEV;
+	}
+}
+
+#ifdef MUTE_TDA9887
+static int i2c_write_ntsc_demod (struct lgdt330x_state* state, u8 buf[2])
+{
+	struct i2c_msg msg =
+		{ .addr = 0x43,
+		  .flags = 0, 
+		  .buf = buf,
+		  .len = 2 };
+	int err;
+
+	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
+			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, msg.buf[0], msg.buf[1], err);
+		if (err < 0)
+			return err;
+		else
+			return -EREMOTEIO;
+	}
+	return 0;
+}
+
+static void fiddle_with_ntsc_if_demod(struct lgdt330x_state* state)
+{
+	// Experimental code
+	u8 buf0[] = {0x00, 0x20};
+	u8 buf1[] = {0x01, 0x00};
+	u8 buf2[] = {0x02, 0x00};
+
+	i2c_write_ntsc_demod(state, buf0);
+	i2c_write_ntsc_demod(state, buf1);
+	i2c_write_ntsc_demod(state, buf2);
+}
+#endif
+
 static int lgdt330x_init(struct dvb_frontend* fe)
 {
 	/* Hardware reset is done using gpio[0] of cx23880x chip.
@@ -173,22 +213,101 @@
 	 * Maybe there needs to be a callable function in cx88-core or
 	 * the caller of this function needs to do it. */
 
-	dprintk("%s entered\n", __FUNCTION__);
-	return lgdt330x_SwReset((struct lgdt330x_state*) fe->demodulator_priv);
+	/*
+	 * Array of byte pairs <address, value>
+	 * to initialize each different chip
+	 */
+	static u8 lgdt3302_init_data[] = {
+		/* Use 50MHz parameter values from spec sheet since xtal is 50 */
+		/* Change the value of NCOCTFV[25:0] of carrier
+		   recovery center frequency register */
+		VSB_CARRIER_FREQ0, 0x00,
+		VSB_CARRIER_FREQ1, 0x87,
+		VSB_CARRIER_FREQ2, 0x8e,
+		VSB_CARRIER_FREQ3, 0x01,
+		/* Change the TPCLK pin polarity
+		   data is valid on falling clock */
+		DEMUX_CONTROL, 0xfb,
+		/* Change the value of IFBW[11:0] of
+		   AGC IF/RF loop filter bandwidth register */
+		AGC_RF_BANDWIDTH0, 0x40,
+		AGC_RF_BANDWIDTH1, 0x93,
+		AGC_RF_BANDWIDTH2, 0x00,
+		/* Change the value of bit 6, 'nINAGCBY' and
+		   'NSSEL[1:0] of ACG function control register 2 */
+		AGC_FUNC_CTRL2, 0xc6,
+		/* Change the value of bit 6 'RFFIX'
+		   of AGC function control register 3 */
+		AGC_FUNC_CTRL3, 0x40,
+		/* Set the value of 'INLVTHD' register 0x2a/0x2c
+		   to 0x7fe */
+		AGC_DELAY0, 0x07,
+		AGC_DELAY2, 0xfe,
+		/* Change the value of IAGCBW[15:8]
+		   of inner AGC loop filter bandwith */
+		AGC_LOOP_BANDWIDTH0, 0x08,
+		AGC_LOOP_BANDWIDTH1, 0x9a
+	};
+
+	static u8 lgdt3303_init_data[] = {
+		0x4c, 0x14
+	};
+
+	struct lgdt330x_state* state = fe->demodulator_priv;
+	char  *chip_name;
+	int    err;
+
+	switch (state->config->demod_chip) {
+	case LGDT3302:
+		chip_name = "LGDT3302";
+		err = i2c_write_demod_bytes(state, lgdt3302_init_data, 
+									sizeof(lgdt3302_init_data));
+  		break;
+	case LGDT3303:
+		chip_name = "LGDT3303";
+		err = i2c_write_demod_bytes(state, lgdt3303_init_data, 
+									sizeof(lgdt3303_init_data));
+#ifdef MUTE_TDA9887
+		fiddle_with_ntsc_if_demod(state);
+#endif
+  		break;
+	default:
+		chip_name = "undefined";
+		printk (KERN_WARNING "Only LGDT3302 and LGDT3303 are supported chips.\n");
+		err = -ENODEV;
+	}
+	dprintk("%s entered as %s\n", __FUNCTION__, chip_name);
+	if (err < 0)
+		return err;
+	return lgdt330x_SwReset(state);
 }
 
 static int lgdt330x_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	*ber = 0; /* Dummy out for now */
+	*ber = 0; /* Not supplied by the demod chips */
 	return 0;
 }
 
 static int lgdt330x_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+	struct lgdt330x_state* state = fe->demodulator_priv;
+	int err;
 	u8 buf[2];
 
-	i2c_selectreadbytes(state, PACKET_ERR_COUNTER1, buf, sizeof(buf));
+	switch (state->config->demod_chip) {
+	case LGDT3302:
+		err = i2c_read_demod_bytes(state, LGDT3302_PACKET_ERR_COUNTER1,
+								  buf, sizeof(buf));
+  		break;
+	case LGDT3303:
+		err = i2c_read_demod_bytes(state, LGDT3303_PACKET_ERR_COUNTER1,
+								  buf, sizeof(buf));
+  		break;
+	default:
+		printk(KERN_WARNING 
+			   "Only LGDT3302 and LGDT3303 are supported chips.\n");
+		err = -ENODEV;
+	}
 
 	*ucblocks = (buf[0] << 8) | buf[1];
 	return 0;
@@ -197,123 +316,113 @@
 static int lgdt330x_set_parameters(struct dvb_frontend* fe,
 				   struct dvb_frontend_parameters *param)
 {
-	struct lgdt330x_state* state =
-		(struct lgdt330x_state*) fe->demodulator_priv;
+	/*
+	 * Array of byte pairs <address, value>
+	 * to initialize 8VSB for lgdt3303 chip 50 MHz IF
+	 */
+	static u8 lgdt3303_8vsb_44_data[] = {
+		0x04, 0x00,
+		0x0d, 0x40,
+        0x0e, 0x87,
+        0x0f, 0x8e,
+        0x10, 0x01,
+        0x47, 0x8b };
+
+	/*
+	 * Array of byte pairs <address, value>
+	 * to initialize QAM for lgdt3303 chip
+	 */
+	static u8 lgdt3303_qam_data[] = {
+		0x04, 0x00,
+		0x0d, 0x00,
+		0x0e, 0x00,
+		0x0f, 0x00,
+		0x10, 0x00,
+		0x51, 0x63,
+		0x47, 0x66,
+		0x48, 0x66,
+		0x4d, 0x1a,
+		0x49, 0x08,
+		0x4a, 0x9b };
+
+	struct lgdt330x_state* state = fe->demodulator_priv;
 
-	/* Use 50MHz parameter values from spec sheet since xtal is 50 */
 	static u8 top_ctrl_cfg[]   = { TOP_CONTROL, 0x03 };
-	static u8 vsb_freq_cfg[]   = { VSB_CARRIER_FREQ0, 0x00, 0x87, 0x8e, 0x01 };
-	static u8 demux_ctrl_cfg[] = { DEMUX_CONTROL, 0xfb };
-	static u8 agc_rf_cfg[]     = { AGC_RF_BANDWIDTH0, 0x40, 0x93, 0x00 };
-	static u8 agc_ctrl_cfg[]   = { AGC_FUNC_CTRL2, 0xc6, 0x40 };
-	static u8 agc_delay_cfg[]  = { AGC_DELAY0, 0x07, 0x00, 0xfe };
-	static u8 agc_loop_cfg[]   = { AGC_LOOP_BANDWIDTH0, 0x08, 0x9a };
 
+	int err;
 	/* Change only if we are actually changing the modulation */
 	if (state->current_modulation != param->u.vsb.modulation) {
 		switch(param->u.vsb.modulation) {
 		case VSB_8:
 			dprintk("%s: VSB_8 MODE\n", __FUNCTION__);
 
-			/* Select VSB mode and serial MPEG interface */
-			top_ctrl_cfg[1] = 0x07;
+			/* Select VSB mode */
+			top_ctrl_cfg[1] = 0x03;
 
 			/* Select ANT connector if supported by card */
 			if (state->config->pll_rf_set)
 				state->config->pll_rf_set(fe, 1);
+
+			if (state->config->demod_chip == LGDT3303) {
+				err = i2c_write_demod_bytes(state, lgdt3303_8vsb_44_data, 
+											sizeof(lgdt3303_8vsb_44_data));
+			}
 			break;
 
 		case QAM_64:
 			dprintk("%s: QAM_64 MODE\n", __FUNCTION__);
 
-			/* Select QAM_64 mode and serial MPEG interface */
-			top_ctrl_cfg[1] = 0x04;
+			/* Select QAM_64 mode */
+			top_ctrl_cfg[1] = 0x00;
 
 			/* Select CABLE connector if supported by card */
 			if (state->config->pll_rf_set)
 				state->config->pll_rf_set(fe, 0);
+
+			if (state->config->demod_chip == LGDT3303) {
+				err = i2c_write_demod_bytes(state, lgdt3303_qam_data, 
+											sizeof(lgdt3303_qam_data));
+			}
 			break;
 
 		case QAM_256:
 			dprintk("%s: QAM_256 MODE\n", __FUNCTION__);
 
-			/* Select QAM_256 mode and serial MPEG interface */
-			top_ctrl_cfg[1] = 0x05;
+			/* Select QAM_256 mode */
+			top_ctrl_cfg[1] = 0x01;
 
 			/* Select CABLE connector if supported by card */
 			if (state->config->pll_rf_set)
 				state->config->pll_rf_set(fe, 0);
+
+			if (state->config->demod_chip == LGDT3303) {
+				err = i2c_write_demod_bytes(state, lgdt3303_qam_data, 
+											sizeof(lgdt3303_qam_data));
+			}
 			break;
 		default:
 			printk(KERN_WARNING "lgdt330x: %s: Modulation type(%d) UNSUPPORTED\n", __FUNCTION__, param->u.vsb.modulation);
 			return -1;
 		}
-		/* Initializations common to all modes */
+		/*
+		 * select serial or parallel MPEG harware interface
+		 * Serial:   0x04 for LGDT3302 or 0x40 for LGDT3303
+		 * Parallel: 0x00
+		 */                                    
+		top_ctrl_cfg[1] |= state->config->serial_mpeg;
 
 		/* Select the requested mode */
-		i2c_writebytes(state, state->config->demod_address,
-			       top_ctrl_cfg, sizeof(top_ctrl_cfg));
-
-		/* Change the value of IFBW[11:0]
-		   of AGC IF/RF loop filter bandwidth register */
-		i2c_writebytes(state, state->config->demod_address,
-			       agc_rf_cfg, sizeof(agc_rf_cfg));
-
-		/* Change the value of bit 6, 'nINAGCBY' and
-		   'NSSEL[1:0] of ACG function control register 2 */
-		/* Change the value of bit 6 'RFFIX'
-		   of AGC function control register 3 */
-		i2c_writebytes(state, state->config->demod_address,
-			       agc_ctrl_cfg, sizeof(agc_ctrl_cfg));
-
-		/* Change the TPCLK pin polarity
-		   data is valid on falling clock */
-		i2c_writebytes(state, state->config->demod_address,
-			       demux_ctrl_cfg, sizeof(demux_ctrl_cfg));
-
-		/* Change the value of NCOCTFV[25:0] of carrier
-		   recovery center frequency register */
-		i2c_writebytes(state, state->config->demod_address,
-				       vsb_freq_cfg, sizeof(vsb_freq_cfg));
-
-		/* Set the value of 'INLVTHD' register 0x2a/0x2c to 0x7fe */
-		i2c_writebytes(state, state->config->demod_address,
-			       agc_delay_cfg, sizeof(agc_delay_cfg));
-
-		/* Change the value of IAGCBW[15:8]
-		   of inner AGC loop filter bandwith */
-		i2c_writebytes(state, state->config->demod_address,
-			       agc_loop_cfg, sizeof(agc_loop_cfg));
-
+		i2c_write_demod_bytes(state, top_ctrl_cfg,
+							  sizeof(top_ctrl_cfg));
 		state->config->set_ts_params(fe, 0);
 		state->current_modulation = param->u.vsb.modulation;
 	}
 
 	/* Change only if we are actually changing the channel */
 	if (state->current_frequency != param->frequency) {
-		u8 buf[5];
-		struct i2c_msg msg = { .flags = 0, .buf = &buf[1], .len = 4 };
-		int err;
-
-		state->config->pll_set(fe, param, buf);
-		msg.addr = buf[0];
-
-		dprintk("%s: tuner at 0x%02x bytes: 0x%02x 0x%02x "
-			"0x%02x 0x%02x\n", __FUNCTION__,
-			buf[0],buf[1],buf[2],buf[3],buf[4]);
-		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, buf[0], buf[1], err);
-			if (err < 0)
-				return err;
-			else
-				return -EREMOTEIO;
-		}
-#if 0
-		/* Check the status of the tuner pll */
-		i2c_readbytes(state, buf[0], &buf[1], 1);
-		dprintk("%s: tuner status byte = 0x%02x\n", __FUNCTION__, buf[1]);
-#endif
-		/* Update current frequency */
+		/* Tune to the new frequency */
+		state->config->pll_set(fe, param);
+		/* Keep track of the new frequency */
 		state->current_frequency = param->frequency;
 	}
 	lgdt330x_SwReset(state);
@@ -328,21 +437,15 @@
 	return 0;
 }
 
-static int lgdt330x_read_status(struct dvb_frontend* fe, fe_status_t* status)
+static int lgdt3302_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+	struct lgdt330x_state* state = fe->demodulator_priv;
 	u8 buf[3];
 
 	*status = 0; /* Reset status result */
 
-	/*
-	 * You must set the Mask bits to 1 in the IRQ_MASK in order
-	 * to see that status bit in the IRQ_STATUS register.
-	 * This is done in SwReset();
-	 */
-
 	/* AGC status register */
-	i2c_selectreadbytes(state, AGC_STATUS, buf, 1);
+	i2c_read_demod_bytes(state, AGC_STATUS, buf, 1);
 	dprintk("%s: AGC_STATUS = 0x%02x\n", __FUNCTION__, buf[0]);
 	if ((buf[0] & 0x0c) == 0x8){
 		/* Test signal does not exist flag */
@@ -353,16 +456,15 @@
 		return 0;
 	}
 
+	/*
+	 * You must set the Mask bits to 1 in the IRQ_MASK in order
+	 * to see that status bit in the IRQ_STATUS register.
+	 * This is done in SwReset();
+	 */
 	/* signal status */
-	i2c_selectreadbytes(state, TOP_CONTROL, buf, sizeof(buf));
+	i2c_read_demod_bytes(state, TOP_CONTROL, buf, sizeof(buf));
 	dprintk("%s: TOP_CONTROL = 0x%02x, IRO_MASK = 0x%02x, IRQ_STATUS = 0x%02x\n", __FUNCTION__, buf[0], buf[1], buf[2]);
 
-#if 0
-	/* Alternative method to check for a signal */
-	/* using the SNR good/bad interrupts.   */
-	if ((buf[2] & 0x30) == 0x10)
-		*status |= FE_HAS_SIGNAL;
-#endif
 
 	/* sync status */
 	if ((buf[2] & 0x03) == 0x01) {
@@ -376,7 +478,7 @@
 	}
 
 	/* Carrier Recovery Lock Status Register */
-	i2c_selectreadbytes(state, CARRIER_LOCK, buf, 1);
+	i2c_read_demod_bytes(state, CARRIER_LOCK, buf, 1);
 	dprintk("%s: CARRIER_LOCK = 0x%02x\n", __FUNCTION__, buf[0]);
 	switch (state->current_modulation) {
 	case QAM_256:
@@ -396,13 +498,75 @@
 	return 0;
 }
 
+static int lgdt3303_read_status(struct dvb_frontend* fe, fe_status_t* status)
+{
+	struct lgdt330x_state* state = fe->demodulator_priv;
+	int err;
+	u8 buf[3];
+
+	*status = 0; /* Reset status result */
+
+	/* lgdt3303 AGC status register */
+	err = i2c_read_demod_bytes(state, 0x58, buf, 1);
+	if (err < 0)
+		return err;
+
+	dprintk("%s: AGC_STATUS = 0x%02x\n", __FUNCTION__, buf[0]);
+	if ((buf[0] & 0x21) == 0x01){
+		/* Test input signal does not exist flag */
+		/* as well as the AGC lock flag.   */
+		*status |= FE_HAS_SIGNAL;
+	} else {
+		/* Without a signal all other status bits are meaningless */
+		return 0;
+	}
+
+	/* Carrier Recovery Lock Status Register */
+	i2c_read_demod_bytes(state, CARRIER_LOCK, buf, 1);
+	dprintk("%s: CARRIER_LOCK = 0x%02x\n", __FUNCTION__, buf[0]);
+	switch (state->current_modulation) {
+	case QAM_256:
+	case QAM_64:
+		/* Need to undestand why there are 3 lock levels here */
+		if ((buf[0] & 0x07) == 0x07)
+			*status |= FE_HAS_CARRIER;
+		else
+			break;
+		i2c_read_demod_bytes(state, 0x8a, buf, 1);
+		if ((buf[0] & 0x04) == 0x04)
+			*status |= FE_HAS_SYNC;
+		if ((buf[0] & 0x01) == 0x01)
+			*status |= FE_HAS_LOCK;
+		if ((buf[0] & 0x08) == 0x08)
+			*status |= FE_HAS_VITERBI;
+		break;
+	case VSB_8:
+		if ((buf[0] & 0x80) == 0x80)
+			*status |= FE_HAS_CARRIER;
+		else
+			break;
+		i2c_read_demod_bytes(state, 0x38, buf, 1);
+		if ((buf[0] & 0x02) == 0x00)
+			*status |= FE_HAS_SYNC;
+		if ((buf[0] & 0x01) == 0x01) {
+			*status |= FE_HAS_LOCK;
+			*status |= FE_HAS_VITERBI;
+		}
+		break;
+	default:
+		printk("KERN_WARNING lgdt330x: %s: Modulation set to unsupported value\n", __FUNCTION__);
+	}
+	return 0;
+}
+
 static int lgdt330x_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
 	/* not directly available. */
+	*strength = 0;
 	return 0;
 }
 
-static int lgdt330x_read_snr(struct dvb_frontend* fe, u16* snr)
+static int lgdt3302_read_snr(struct dvb_frontend* fe, u16* snr)
 {
 #ifdef SNR_IN_DB
 	/*
@@ -451,7 +615,7 @@
 		  91,    115,    144,    182,    229,    288, 362,   456,   574,   722,
 		  909,   1144,   1440,   1813,   2282,   2873, 3617,  4553,  5732,  7216,
 		  9084,  11436,  14396,  18124,  22817,  28724,  36161, 45524, 57312, 72151,
-		  90833, 114351, 143960, 181235, 228161, 0x040000
+		  90833, 114351, 143960, 181235, 228161, 0x080000
 		};
 
 	static u8 buf[5];/* read data buffer */
@@ -459,8 +623,8 @@
 	static u32 snr_db;  /* index into SNR_EQ[] */
 	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
 
-	/* read both equalizer and pase tracker noise data */
-	i2c_selectreadbytes(state, EQPH_ERR0, buf, sizeof(buf));
+	/* read both equalizer and phase tracker noise data */
+	i2c_read_demod_bytes(state, EQPH_ERR0, buf, sizeof(buf));
 
 	if (state->current_modulation == VSB_8) {
 		/* Equalizer Mean-Square Error Register for VSB */
@@ -496,19 +660,20 @@
 	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
 
 	/* read both equalizer and pase tracker noise data */
-	i2c_selectreadbytes(state, EQPH_ERR0, buf, sizeof(buf));
+	i2c_read_demod_bytes(state, EQPH_ERR0, buf, sizeof(buf));
 
 	if (state->current_modulation == VSB_8) {
-		/* Equalizer Mean-Square Error Register for VSB */
-		noise = ((buf[0] & 7) << 16) | (buf[1] << 8) | buf[2];
-	} else {
-		/* Phase Tracker Mean-Square Error Register for QAM */
+		/* Phase Tracker Mean-Square Error Register for VSB */
 		noise = ((buf[0] & 7<<3) << 13) | (buf[3] << 8) | buf[4];
+	} else {
+
+		/* Carrier Recovery Mean-Square Error for QAM */
+		i2c_read_demod_bytes(state, 0x1a, buf, 2);
+		noise = ((buf[0] & 3) << 8) | buf[1];
 	}
 
 	/* Small values for noise mean signal is better so invert noise */
-	/* Noise is 19 bit value so discard 3 LSB*/
-	*snr = ~noise>>3;
+	*snr = ~noise;
 #endif
 
 	dprintk("%s: noise = 0x%05x, snr = %idb\n",__FUNCTION__, noise, *snr);
@@ -516,6 +681,32 @@
 	return 0;
 }
 
+static int lgdt3303_read_snr(struct dvb_frontend* fe, u16* snr)
+{
+	/* Return the raw noise value */
+	static u8 buf[5];/* read data buffer */
+	static u32 noise;   /* noise value */
+	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+
+	if (state->current_modulation == VSB_8) {
+
+		/* Phase Tracker Mean-Square Error Register for VSB */
+		noise = ((buf[0] & 7) << 16) | (buf[3] << 8) | buf[4];
+	} else {
+
+		/* Carrier Recovery Mean-Square Error for QAM */
+		i2c_read_demod_bytes(state, 0x1a, buf, 2);
+		noise = (buf[0] << 8) | buf[1];
+	}
+
+	/* Small values for noise mean signal is better so invert noise */
+	*snr = ~noise;
+
+	dprintk("%s: noise = 0x%05x, snr = %idb\n",__FUNCTION__, noise, *snr);
+
+	return 0;
+}
+
 static int lgdt330x_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fe_tune_settings)
 {
 	/* I have no idea about this - it may not be needed */
@@ -531,7 +722,8 @@
 	kfree(state);
 }
 
-static struct dvb_frontend_ops lgdt330x_ops;
+static struct dvb_frontend_ops lgdt3302_ops;
+static struct dvb_frontend_ops lgdt3303_ops;
 
 struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* config,
 				     struct i2c_adapter* i2c)
@@ -548,9 +740,19 @@
 	/* Setup the state */
 	state->config = config;
 	state->i2c = i2c;
-	memcpy(&state->ops, &lgdt330x_ops, sizeof(struct dvb_frontend_ops));
+	switch (config->demod_chip) {
+	case LGDT3302:
+		memcpy(&state->ops, &lgdt3302_ops, sizeof(struct dvb_frontend_ops));
+		break;
+	case LGDT3303:
+		memcpy(&state->ops, &lgdt3303_ops, sizeof(struct dvb_frontend_ops));
+		break;
+	default:
+		goto error;
+	}
+	
 	/* Verify communication with demod chip */
-	if (i2c_selectreadbytes(state, 2, buf, 1))
+	if (i2c_read_demod_bytes(state, 2, buf, 1))
 		goto error;
 
 	state->current_frequency = -1;
@@ -568,9 +770,33 @@
 	return NULL;
 }
 
-static struct dvb_frontend_ops lgdt330x_ops = {
+static struct dvb_frontend_ops lgdt3302_ops = {
+	.info = {
+		.name= "LG Electronics LGDT3302/LGDT3303 VSB/QAM Frontend",
+		.type = FE_ATSC,
+		.frequency_min= 54000000,
+		.frequency_max= 858000000,
+		.frequency_stepsize= 62500,
+		/* Symbol rate is for all VSB modes need to check QAM */
+		.symbol_rate_min    = 10762000,
+		.symbol_rate_max    = 10762000,
+		.caps = FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
+	},
+	.init                 = lgdt330x_init,
+	.set_frontend         = lgdt330x_set_parameters,
+	.get_frontend         = lgdt330x_get_frontend,
+	.get_tune_settings    = lgdt330x_get_tune_settings,
+	.read_status          = lgdt3302_read_status,
+	.read_ber             = lgdt330x_read_ber,
+	.read_signal_strength = lgdt330x_read_signal_strength,
+	.read_snr             = lgdt3302_read_snr,
+	.read_ucblocks        = lgdt330x_read_ucblocks,
+	.release              = lgdt330x_release,
+};
+
+static struct dvb_frontend_ops lgdt3303_ops = {
 	.info = {
-		.name= "LG Electronics lgdt330x VSB/QAM Frontend",
+		.name= "LG Electronics LGDT3303 VSB/QAM Frontend",
 		.type = FE_ATSC,
 		.frequency_min= 54000000,
 		.frequency_max= 858000000,
@@ -584,15 +810,15 @@
 	.set_frontend         = lgdt330x_set_parameters,
 	.get_frontend         = lgdt330x_get_frontend,
 	.get_tune_settings    = lgdt330x_get_tune_settings,
-	.read_status          = lgdt330x_read_status,
+	.read_status          = lgdt3303_read_status,
 	.read_ber             = lgdt330x_read_ber,
 	.read_signal_strength = lgdt330x_read_signal_strength,
-	.read_snr             = lgdt330x_read_snr,
+	.read_snr             = lgdt3303_read_snr,
 	.read_ucblocks        = lgdt330x_read_ucblocks,
 	.release              = lgdt330x_release,
 };
 
-MODULE_DESCRIPTION("lgdt330x [DViCO FusionHDTV 3 Gold] (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulator Driver");
+MODULE_DESCRIPTION("LGDT330X (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulator Driver");
 MODULE_AUTHOR("Wilson Michaels");
 MODULE_LICENSE("GPL");
 
@@ -601,6 +827,5 @@
 /*
  * Local variables:
  * c-basic-offset: 8
- * compile-command: "make DVB=1"
  * End:
  */
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.h linux/drivers/media/dvb/frontends/lgdt330x.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.h	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.h	2005-08-07 18:35:08.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *    Support for LGDT3302 & LGDT3303 (DViCO FustionHDTV Gold) - VSB/QAM
+ *    Support for LGDT3302 and LGDT3303 - VSB/QAM
  *
  *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
  *
@@ -24,14 +24,26 @@
 
 #include <linux/dvb/frontend.h>
 
+typedef enum lg_chip_t {
+		UNDEFINED,
+		LGDT3302,
+		LGDT3303
+}lg_chip_type;
+
 struct lgdt330x_config
 {
 	/* The demodulator's i2c address */
 	u8 demod_address;
 
+	/* LG demodulator chip LGDT3302 or LGDT3303 */
+	lg_chip_type demod_chip;
+
+	/* MPEG hardware interface - 0:parallel 1:serial */
+	int serial_mpeg;
+
 	/* PLL interface */
 	int (*pll_rf_set) (struct dvb_frontend* fe, int index);
-	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pll_address);
+	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
 
 	/* Need to set device param for start_dma */
 	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x_priv.h linux/drivers/media/dvb/frontends/lgdt330x_priv.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x_priv.h	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x_priv.h	2005-08-07 18:35:08.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *    Support for LGDT3302 & LGDT3303 (DViCO FustionHDTV Gold) - VSB/QAM
+ *    Support for LGDT3302 and LGDT3303 - VSB/QAM
  *
  *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
  *
@@ -57,8 +57,10 @@
 	PH_ERR1= 0x4a,
 	PH_ERR2= 0x4b,
 	DEMUX_CONTROL= 0x66,
-	PACKET_ERR_COUNTER1= 0x6a,
-	PACKET_ERR_COUNTER2= 0x6b,
+	LGDT3302_PACKET_ERR_COUNTER1= 0x6a,
+	LGDT3302_PACKET_ERR_COUNTER2= 0x6b,
+	LGDT3303_PACKET_ERR_COUNTER1= 0x8b,
+	LGDT3303_PACKET_ERR_COUNTER2= 0x8c,
 };
 
 #endif /* _LGDT330X_PRIV_ */
diff -u linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.c linux/drivers/media/dvb/frontends/dvb-pll.c
--- linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.c	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/dvb/frontends/dvb-pll.c	2005-08-07 18:35:08.000000000 +0000
@@ -225,6 +225,22 @@
 };
 EXPORT_SYMBOL(dvb_pll_tua6034);
 
+/* Infineon TUA6034
+ * used in LG Innotek TDVS-H062F
+ */
+struct dvb_pll_desc dvb_pll_tdvs_tua6034 = {
+	.name  = "LG/Infineon TUA6034",
+	.min   =  54000000,
+	.max   = 863000000,
+	.count = 3,
+	.entries = {
+		{  160000000, 44000000, 62500, 0xce, 0x01 },
+		{  455000000, 44000000, 62500, 0xce, 0x02 },
+		{  999999999, 44000000, 62500, 0xce, 0x04 },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_tdvs_tua6034);
+
 /* Philips FMD1216ME
  * used in Medion Hybrid PCMCIA card and USB Box
  */
diff -u linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.h linux/drivers/media/dvb/frontends/dvb-pll.h
--- linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.h	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/dvb/frontends/dvb-pll.h	2005-08-07 18:35:08.000000000 +0000
@@ -31,6 +31,7 @@
 extern struct dvb_pll_desc dvb_pll_tua6010xs;
 extern struct dvb_pll_desc dvb_pll_env57h1xd5;
 extern struct dvb_pll_desc dvb_pll_tua6034;
+extern struct dvb_pll_desc dvb_pll_tdvs_tua6034;
 extern struct dvb_pll_desc dvb_pll_tda665x;
 extern struct dvb_pll_desc dvb_pll_fmd1216me;
 extern struct dvb_pll_desc dvb_pll_tded4;
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-08-07 18:35:08.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.54 2005/07/25 05:13:50 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.58 2005/08/07 09:24:08 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -208,14 +208,26 @@
 
 #ifdef HAVE_LGDT330X
 static int lgdt330x_pll_set(struct dvb_frontend* fe,
-			    struct dvb_frontend_parameters* params,
-			    u8* pllbuf)
+			    struct dvb_frontend_parameters* params)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
+	u8 buf[4];
+	struct i2c_msg msg =
+		{ .addr = dev->core->pll_addr, .flags = 0, .buf = buf, .len = 4 };
+	int err;
 
-	pllbuf[0] = dev->core->pll_addr;
-	dvb_pll_configure(dev->core->pll_desc, &pllbuf[1],
-			  params->frequency, 0);
+	dvb_pll_configure(dev->core->pll_desc, buf, params->frequency, 0);
+	dprintk(1, "%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
+			__FUNCTION__, msg.addr, buf[0],buf[1],buf[2],buf[3]);
+	if ((err = i2c_transfer(&dev->core->i2c_adap, &msg, 1)) != 1) {
+		printk(KERN_WARNING "cx88-dvb: %s error "
+			   "(addr %02x <- %02x, err = %i)\n",
+			   __FUNCTION__, buf[0], buf[1], err);
+		if (err < 0)
+			return err;
+		else
+			return -EREMOTEIO;
+	}
 	return 0;
 }
 
@@ -244,6 +256,8 @@
 
 static struct lgdt330x_config fusionhdtv_3_gold = {
 	.demod_address    = 0x0e,
+	.demod_chip       = LGDT3302,
+	.serial_mpeg      = 0x04, /* TPSERIAL for 3302 in TOP_CONTROL */
 	.pll_set          = lgdt330x_pll_set,
 	.set_ts_params    = lgdt330x_set_ts_param,
 };


--------------020805030600050604030500--

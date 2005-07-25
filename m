Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVGYG7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVGYG7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVGYG5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:57:43 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:61269 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261804AbVGYGyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 02:54:41 -0400
Message-ID: <42E48CA5.9010709@m1k.net>
Date: Mon, 25 Jul 2005 02:54:29 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Mac Michaels <wmichaels1@earthlink.net>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] DVB: rename lgdt3302 frontend module to lgdt330x
Content-Type: multipart/mixed;
 boundary="------------040501030906040404030703"
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
--------------040501030906040404030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch depends on the following patches to be applied first in order 
to apply cleanly:

01-lgdt3302-isolate-tuner.patch
02-lgdt3302-rf-input.patch
03-lgdt3302-suppress-compile-warning.patch
04-cx88-dvb-cleanup.patch
[-mm PATCH] v4l: hybrid dvb: fix warnings with -Wundef
[-mm PATCH] v4l: hybrid dvb: move #defines to Makefile
[-mm PATCH] v4l: hybrid dvb: rename CFLAGS from CONFIG_DVB_xxxx back to 
original HAVE_xxxx

I am listing these because I haven't seen any of these in -mm-commits 
mailing list yet.  (No commits at all for a week or so....)

I am changing the name of this module now so that hopefully the name 
will be changed before the release of 2.6.13 ...  It wouldn't make sense 
to release 2.6.13 with the name lgdt3302 in it, which will only be 
renamed to lgdt330x in later versions.

Andrew-

If you, for any reason, don't want to send my #ifdef changes to 2.6.13 
right away, just let me know and I'll regenerate these patches such that 
the #ifdef patches aren't a prerequisite... Although it would just be a 
lot easier to merge all of the patches above...




--------------040501030906040404030703
Content-Type: text/plain;
 name="rename-lgdt3302-frontend-to-lgdt330x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rename-lgdt3302-frontend-to-lgdt330x.patch"

Rename lgdt3302 to lgdt330x, to make way for the addition of lgdt3303 
support in future revisions.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/dvb/frontends/Kconfig         |    4 
 linux/drivers/media/dvb/frontends/Makefile        |    2 
 linux/drivers/media/dvb/frontends/lgdt3302.c      |  607 --------------
 linux/drivers/media/dvb/frontends/lgdt3302.h      |   49 -
 linux/drivers/media/dvb/frontends/lgdt3302_priv.h |   72 -
 linux/drivers/media/dvb/frontends/lgdt330x.c      |  606 +++++++++++++
 linux/drivers/media/dvb/frontends/lgdt330x.h      |   49 +
 linux/drivers/media/dvb/frontends/lgdt330x_priv.h |   70 +
 linux/drivers/media/video/Kconfig                 |    2 
 linux/drivers/media/video/cx88/Makefile           |    4 
 linux/drivers/media/video/cx88/cx88-dvb.c         |   29 
 linux/drivers/media/video/cx88/cx88-i2c.c         |    4 
 12 files changed, 747 insertions(+), 751 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-25 02:41:15.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.52 2005/07/24 22:12:47 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.54 2005/07/25 05:13:50 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -31,7 +31,6 @@
 #include <linux/suspend.h>
 #include <linux/config.h>
 
-
 #include "cx88.h"
 #include "dvb-pll.h"
 
@@ -45,8 +44,8 @@
 #ifdef HAVE_OR51132
 # include "or51132.h"
 #endif
-#ifdef HAVE_LGDT3302
-# include "lgdt3302.h"
+#ifdef HAVE_LGDT330X
+# include "lgdt330x.h"
 #endif
 
 MODULE_DESCRIPTION("driver for cx2388x based DVB cards");
@@ -207,8 +206,8 @@
 };
 #endif
 
-#ifdef HAVE_LGDT3302
-static int lgdt3302_pll_set(struct dvb_frontend* fe,
+#ifdef HAVE_LGDT330X
+static int lgdt330x_pll_set(struct dvb_frontend* fe,
 			    struct dvb_frontend_parameters* params,
 			    u8* pllbuf)
 {
@@ -220,7 +219,7 @@
 	return 0;
 }
 
-static int lgdt3302_pll_rf_set(struct dvb_frontend* fe, int index)
+static int lgdt330x_pll_rf_set(struct dvb_frontend* fe, int index)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
 	struct cx88_core *core = dev->core;
@@ -233,7 +232,7 @@
 	return 0;
 }
 
-static int lgdt3302_set_ts_param(struct dvb_frontend* fe, int is_punctured)
+static int lgdt330x_set_ts_param(struct dvb_frontend* fe, int is_punctured)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
 	if (is_punctured)
@@ -243,10 +242,10 @@
 	return 0;
 }
 
-static struct lgdt3302_config fusionhdtv_3_gold = {
+static struct lgdt330x_config fusionhdtv_3_gold = {
 	.demod_address    = 0x0e,
-	.pll_set          = lgdt3302_pll_set,
-	.set_ts_params    = lgdt3302_set_ts_param,
+	.pll_set          = lgdt330x_pll_set,
+	.set_ts_params    = lgdt330x_set_ts_param,
 };
 #endif
 
@@ -297,7 +296,7 @@
 						 &dev->core->i2c_adap);
 		break;
 #endif
-#ifdef HAVE_LGDT3302
+#ifdef HAVE_LGDT330X
 	case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q:
 		dev->ts_gen_cntrl = 0x08;
 		{
@@ -310,10 +309,10 @@
 		mdelay(200);
 
 		/* Select RF connector callback */
-		fusionhdtv_3_gold.pll_rf_set = lgdt3302_pll_rf_set;
+		fusionhdtv_3_gold.pll_rf_set = lgdt330x_pll_rf_set;
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_microtune_4042;
-		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold,
+		dev->dvb.frontend = lgdt330x_attach(&fusionhdtv_3_gold,
 						    &dev->core->i2c_adap);
 		}
 		break;
@@ -329,7 +328,7 @@
 		mdelay(200);
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_thomson_dtt7611;
-		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold,
+		dev->dvb.frontend = lgdt330x_attach(&fusionhdtv_3_gold,
 						    &dev->core->i2c_adap);
 		}
 		break;
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c linux/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-i2c.c	2005-07-25 02:41:15.000000000 +0000
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-i2c.c,v 1.28 2005/07/05 17:37:35 nsh Exp $
+    $Id: cx88-i2c.c,v 1.30 2005/07/25 05:10:13 mkrufky Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
@@ -164,7 +164,7 @@
 };
 
 static char *i2c_devs[128] = {
-	[ 0x1c >> 1 ] = "lgdt3302",
+	[ 0x1c >> 1 ] = "lgdt330x",
 	[ 0x86 >> 1 ] = "tda9887/cx22702",
 	[ 0xa0 >> 1 ] = "eeprom",
 	[ 0xc0 >> 1 ] = "tuner (analog)",
diff -u linux-2.6.13/drivers/media/video/cx88/Makefile linux/drivers/media/video/cx88/Makefile
--- linux-2.6.13/drivers/media/video/cx88/Makefile	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/video/cx88/Makefile	2005-07-25 02:41:15.000000000 +0000
@@ -15,8 +15,8 @@
 ifneq ($(CONFIG_DVB_OR51132),n)
  EXTRA_CFLAGS += -DHAVE_OR51132=1
 endif
-ifneq ($(CONFIG_DVB_LGDT3302),n)
- EXTRA_CFLAGS += -DHAVE_LGDT3302=1
+ifneq ($(CONFIG_DVB_LGDT330X),n)
+ EXTRA_CFLAGS += -DHAVE_LGDT330X=1
 endif
 ifneq ($(CONFIG_DVB_MT352),n)
  EXTRA_CFLAGS += -DHAVE_MT352=1
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c linux/drivers/media/dvb/frontends/lgdt330x.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c	2005-07-25 02:33:22.148872750 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.c	2005-07-25 02:41:15.000000000 +0000
@@ -0,0 +1,606 @@
+/*
+ *    Support for LGDT3302 & LGDT3303 (DViCO FusionHDTV Gold) - VSB/QAM
+ *
+ *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
+ *
+ *    Based on code from  Kirk Lapray <kirk_lapray@bigfoot.com>
+ *                           Copyright (C) 2005
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ *                      NOTES ABOUT THIS DRIVER
+ *
+ * This driver supports DViCO FusionHDTV Gold under Linux.
+ *
+ * TODO:
+ * BER and signal strength always return 0.
+ * Include support for LGDT3303
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <asm/byteorder.h>
+
+#include "dvb_frontend.h"
+#include "dvb-pll.h"
+#include "lgdt330x_priv.h"
+#include "lgdt330x.h"
+
+static int debug = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug,"Turn on/off lgdt330x frontend debugging (default:off).");
+#define dprintk(args...) \
+do { \
+if (debug) printk(KERN_DEBUG "lgdt330x: " args); \
+} while (0)
+
+struct lgdt330x_state
+{
+	struct i2c_adapter* i2c;
+	struct dvb_frontend_ops ops;
+
+	/* Configuration settings */
+	const struct lgdt330x_config* config;
+
+	struct dvb_frontend frontend;
+
+	/* Demodulator private data */
+	fe_modulation_t current_modulation;
+
+	/* Tuner private data */
+	u32 current_frequency;
+};
+
+static int i2c_writebytes (struct lgdt330x_state* state,
+			   u8 addr, /* demod_address or pll_address */
+			   u8 *buf, /* data bytes to send */
+			   int len  /* number of bytes to send */ )
+{
+	u8 tmp[] = { buf[0], buf[1] };
+	struct i2c_msg msg =
+		{ .addr = addr, .flags = 0, .buf = tmp,  .len = 2 };
+	int err;
+	int i;
+
+	for (i=1; i<len; i++) {
+		tmp[1] = buf[i];
+		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
+			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
+			if (err < 0)
+				return err;
+			else
+				return -EREMOTEIO;
+		}
+		tmp[0]++;
+	}
+	return 0;
+}
+
+#if 0
+static int i2c_readbytes (struct lgdt330x_state* state,
+			  u8 addr, /* demod_address or pll_address */
+			  u8 *buf, /* holds data bytes read */
+			  int len  /* number of bytes to read */ )
+{
+	struct i2c_msg msg =
+		{ .addr = addr, .flags = I2C_M_RD, .buf = buf,  .len = len };
+	int err;
+
+	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
+		printk(KERN_WARNING "lgdt330x: %s error (addr %02x, err == %i)\n", __FUNCTION__, addr, err);
+		return -EREMOTEIO;
+	}
+	return 0;
+}
+#endif
+
+/*
+ * This routine writes the register (reg) to the demod bus
+ * then reads the data returned for (len) bytes.
+ */
+
+static u8 i2c_selectreadbytes (struct lgdt330x_state* state,
+			       enum I2C_REG reg, u8* buf, int len)
+{
+	u8 wr [] = { reg };
+	struct i2c_msg msg [] = {
+		{ .addr = state->config->demod_address,
+		  .flags = 0, .buf = wr,  .len = 1 },
+		{ .addr = state->config->demod_address,
+		  .flags = I2C_M_RD, .buf = buf, .len = len },
+	};
+	int ret;
+	ret = i2c_transfer(state->i2c, msg, 2);
+	if (ret != 2) {
+		printk(KERN_WARNING "lgdt330x: %s: addr 0x%02x select 0x%02x error (ret == %i)\n", __FUNCTION__, state->config->demod_address, reg, ret);
+	} else {
+		ret = 0;
+	}
+	return ret;
+}
+
+/* Software reset */
+int lgdt330x_SwReset(struct lgdt330x_state* state)
+{
+	u8 ret;
+	u8 reset[] = {
+		IRQ_MASK,
+		0x00 /* bit 6 is active low software reset
+		      *	bits 5-0 are 1 to mask interrupts */
+	};
+
+	ret = i2c_writebytes(state,
+			     state->config->demod_address,
+			     reset, sizeof(reset));
+	if (ret == 0) {
+		/* spec says reset takes 100 ns why wait */
+		/* mdelay(100);    */ /* keep low for 100mS */
+		reset[1] = 0x7f;      /* force reset high (inactive)
+				       * and unmask interrupts */
+		ret = i2c_writebytes(state,
+				     state->config->demod_address,
+				     reset, sizeof(reset));
+	}
+	/* Spec does not indicate a need for this either */
+	/*mdelay(5); */               /* wait 5 msec before doing more */
+	return ret;
+}
+
+static int lgdt330x_init(struct dvb_frontend* fe)
+{
+	/* Hardware reset is done using gpio[0] of cx23880x chip.
+	 * I'd like to do it here, but don't know how to find chip address.
+	 * cx88-cards.c arranges for the reset bit to be inactive (high).
+	 * Maybe there needs to be a callable function in cx88-core or
+	 * the caller of this function needs to do it. */
+
+	dprintk("%s entered\n", __FUNCTION__);
+	return lgdt330x_SwReset((struct lgdt330x_state*) fe->demodulator_priv);
+}
+
+static int lgdt330x_read_ber(struct dvb_frontend* fe, u32* ber)
+{
+	*ber = 0; /* Dummy out for now */
+	return 0;
+}
+
+static int lgdt330x_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
+{
+	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+	u8 buf[2];
+
+	i2c_selectreadbytes(state, PACKET_ERR_COUNTER1, buf, sizeof(buf));
+
+	*ucblocks = (buf[0] << 8) | buf[1];
+	return 0;
+}
+
+static int lgdt330x_set_parameters(struct dvb_frontend* fe,
+				   struct dvb_frontend_parameters *param)
+{
+	struct lgdt330x_state* state =
+		(struct lgdt330x_state*) fe->demodulator_priv;
+
+	/* Use 50MHz parameter values from spec sheet since xtal is 50 */
+	static u8 top_ctrl_cfg[]   = { TOP_CONTROL, 0x03 };
+	static u8 vsb_freq_cfg[]   = { VSB_CARRIER_FREQ0, 0x00, 0x87, 0x8e, 0x01 };
+	static u8 demux_ctrl_cfg[] = { DEMUX_CONTROL, 0xfb };
+	static u8 agc_rf_cfg[]     = { AGC_RF_BANDWIDTH0, 0x40, 0x93, 0x00 };
+	static u8 agc_ctrl_cfg[]   = { AGC_FUNC_CTRL2, 0xc6, 0x40 };
+	static u8 agc_delay_cfg[]  = { AGC_DELAY0, 0x07, 0x00, 0xfe };
+	static u8 agc_loop_cfg[]   = { AGC_LOOP_BANDWIDTH0, 0x08, 0x9a };
+
+	/* Change only if we are actually changing the modulation */
+	if (state->current_modulation != param->u.vsb.modulation) {
+		switch(param->u.vsb.modulation) {
+		case VSB_8:
+			dprintk("%s: VSB_8 MODE\n", __FUNCTION__);
+
+			/* Select VSB mode and serial MPEG interface */
+			top_ctrl_cfg[1] = 0x07;
+
+			/* Select ANT connector if supported by card */
+			if (state->config->pll_rf_set)
+				state->config->pll_rf_set(fe, 1);
+			break;
+
+		case QAM_64:
+			dprintk("%s: QAM_64 MODE\n", __FUNCTION__);
+
+			/* Select QAM_64 mode and serial MPEG interface */
+			top_ctrl_cfg[1] = 0x04;
+
+			/* Select CABLE connector if supported by card */
+			if (state->config->pll_rf_set)
+				state->config->pll_rf_set(fe, 0);
+			break;
+
+		case QAM_256:
+			dprintk("%s: QAM_256 MODE\n", __FUNCTION__);
+
+			/* Select QAM_256 mode and serial MPEG interface */
+			top_ctrl_cfg[1] = 0x05;
+
+			/* Select CABLE connector if supported by card */
+			if (state->config->pll_rf_set)
+				state->config->pll_rf_set(fe, 0);
+			break;
+		default:
+			printk(KERN_WARNING "lgdt330x: %s: Modulation type(%d) UNSUPPORTED\n", __FUNCTION__, param->u.vsb.modulation);
+			return -1;
+		}
+		/* Initializations common to all modes */
+
+		/* Select the requested mode */
+		i2c_writebytes(state, state->config->demod_address,
+			       top_ctrl_cfg, sizeof(top_ctrl_cfg));
+
+		/* Change the value of IFBW[11:0]
+		   of AGC IF/RF loop filter bandwidth register */
+		i2c_writebytes(state, state->config->demod_address,
+			       agc_rf_cfg, sizeof(agc_rf_cfg));
+
+		/* Change the value of bit 6, 'nINAGCBY' and
+		   'NSSEL[1:0] of ACG function control register 2 */
+		/* Change the value of bit 6 'RFFIX'
+		   of AGC function control register 3 */
+		i2c_writebytes(state, state->config->demod_address,
+			       agc_ctrl_cfg, sizeof(agc_ctrl_cfg));
+
+		/* Change the TPCLK pin polarity
+		   data is valid on falling clock */
+		i2c_writebytes(state, state->config->demod_address,
+			       demux_ctrl_cfg, sizeof(demux_ctrl_cfg));
+
+		/* Change the value of NCOCTFV[25:0] of carrier
+		   recovery center frequency register */
+		i2c_writebytes(state, state->config->demod_address,
+				       vsb_freq_cfg, sizeof(vsb_freq_cfg));
+
+		/* Set the value of 'INLVTHD' register 0x2a/0x2c to 0x7fe */
+		i2c_writebytes(state, state->config->demod_address,
+			       agc_delay_cfg, sizeof(agc_delay_cfg));
+
+		/* Change the value of IAGCBW[15:8]
+		   of inner AGC loop filter bandwith */
+		i2c_writebytes(state, state->config->demod_address,
+			       agc_loop_cfg, sizeof(agc_loop_cfg));
+
+		state->config->set_ts_params(fe, 0);
+		state->current_modulation = param->u.vsb.modulation;
+	}
+
+	/* Change only if we are actually changing the channel */
+	if (state->current_frequency != param->frequency) {
+		u8 buf[5];
+		struct i2c_msg msg = { .flags = 0, .buf = &buf[1], .len = 4 };
+		int err;
+
+		state->config->pll_set(fe, param, buf);
+		msg.addr = buf[0];
+
+		dprintk("%s: tuner at 0x%02x bytes: 0x%02x 0x%02x "
+			"0x%02x 0x%02x\n", __FUNCTION__,
+			buf[0],buf[1],buf[2],buf[3],buf[4]);
+		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
+			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, buf[0], buf[1], err);
+			if (err < 0)
+				return err;
+			else
+				return -EREMOTEIO;
+		}
+#if 0
+		/* Check the status of the tuner pll */
+		i2c_readbytes(state, buf[0], &buf[1], 1);
+		dprintk("%s: tuner status byte = 0x%02x\n", __FUNCTION__, buf[1]);
+#endif
+		/* Update current frequency */
+		state->current_frequency = param->frequency;
+	}
+	lgdt330x_SwReset(state);
+	return 0;
+}
+
+static int lgdt330x_get_frontend(struct dvb_frontend* fe,
+				 struct dvb_frontend_parameters* param)
+{
+	struct lgdt330x_state *state = fe->demodulator_priv;
+	param->frequency = state->current_frequency;
+	return 0;
+}
+
+static int lgdt330x_read_status(struct dvb_frontend* fe, fe_status_t* status)
+{
+	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+	u8 buf[3];
+
+	*status = 0; /* Reset status result */
+
+	/*
+	 * You must set the Mask bits to 1 in the IRQ_MASK in order
+	 * to see that status bit in the IRQ_STATUS register.
+	 * This is done in SwReset();
+	 */
+
+	/* AGC status register */
+	i2c_selectreadbytes(state, AGC_STATUS, buf, 1);
+	dprintk("%s: AGC_STATUS = 0x%02x\n", __FUNCTION__, buf[0]);
+	if ((buf[0] & 0x0c) == 0x8){
+		/* Test signal does not exist flag */
+		/* as well as the AGC lock flag.   */
+		*status |= FE_HAS_SIGNAL;
+	} else {
+		/* Without a signal all other status bits are meaningless */
+		return 0;
+	}
+
+	/* signal status */
+	i2c_selectreadbytes(state, TOP_CONTROL, buf, sizeof(buf));
+	dprintk("%s: TOP_CONTROL = 0x%02x, IRO_MASK = 0x%02x, IRQ_STATUS = 0x%02x\n", __FUNCTION__, buf[0], buf[1], buf[2]);
+
+#if 0
+	/* Alternative method to check for a signal */
+	/* using the SNR good/bad interrupts.   */
+	if ((buf[2] & 0x30) == 0x10)
+		*status |= FE_HAS_SIGNAL;
+#endif
+
+	/* sync status */
+	if ((buf[2] & 0x03) == 0x01) {
+		*status |= FE_HAS_SYNC;
+	}
+
+	/* FEC error status */
+	if ((buf[2] & 0x0c) == 0x08) {
+		*status |= FE_HAS_LOCK;
+		*status |= FE_HAS_VITERBI;
+	}
+
+	/* Carrier Recovery Lock Status Register */
+	i2c_selectreadbytes(state, CARRIER_LOCK, buf, 1);
+	dprintk("%s: CARRIER_LOCK = 0x%02x\n", __FUNCTION__, buf[0]);
+	switch (state->current_modulation) {
+	case QAM_256:
+	case QAM_64:
+		/* Need to undestand why there are 3 lock levels here */
+		if ((buf[0] & 0x07) == 0x07)
+			*status |= FE_HAS_CARRIER;
+		break;
+	case VSB_8:
+		if ((buf[0] & 0x80) == 0x80)
+			*status |= FE_HAS_CARRIER;
+		break;
+	default:
+		printk("KERN_WARNING lgdt330x: %s: Modulation set to unsupported value\n", __FUNCTION__);
+	}
+
+	return 0;
+}
+
+static int lgdt330x_read_signal_strength(struct dvb_frontend* fe, u16* strength)
+{
+	/* not directly available. */
+	return 0;
+}
+
+static int lgdt330x_read_snr(struct dvb_frontend* fe, u16* snr)
+{
+#ifdef SNR_IN_DB
+	/*
+	 * Spec sheet shows formula for SNR_EQ = 10 log10(25 * 24**2 / noise)
+	 * and SNR_PH = 10 log10(25 * 32**2 / noise) for equalizer and phase tracker
+	 * respectively. The following tables are built on these formulas.
+	 * The usual definition is SNR = 20 log10(signal/noise)
+	 * If the specification is wrong the value retuned is 1/2 the actual SNR in db.
+	 *
+	 * This table is a an ordered list of noise values computed by the
+	 * formula from the spec sheet such that the index into the table
+	 * starting at 43 or 45 is the SNR value in db. There are duplicate noise
+	 * value entries at the beginning because the SNR varies more than
+	 * 1 db for a change of 1 digit in noise at very small values of noise.
+	 *
+	 * Examples from SNR_EQ table:
+	 * noise SNR
+	 *   0    43
+	 *   1    42
+	 *   2    39
+	 *   3    37
+	 *   4    36
+	 *   5    35
+	 *   6    34
+	 *   7    33
+	 *   8    33
+	 *   9    32
+	 *   10   32
+	 *   11   31
+	 *   12   31
+	 *   13   30
+	 */
+
+	static const u32 SNR_EQ[] =
+		{ 1,     2,      2,      2, 3,      3,      4,     4,     5,     7,
+		  9,     11,     13,     17, 21,     26,     33,    41,    52,    65,
+		  81,    102,    129,    162, 204,    257,    323,   406,   511,   644,
+		  810,   1020,   1284,   1616, 2035,   2561,   3224,  4059,  5110,  6433,
+		  8098,  10195,  12835,  16158, 20341,  25608,  32238, 40585, 51094, 64323,
+		  80978, 101945, 128341, 161571, 203406, 256073, 0x40000
+		};
+
+	static const u32 SNR_PH[] =
+		{ 1,     2,      2,      2,      3,      3,     4,     5,     6,     8,
+		  10,    12,     15,     19,     23,     29, 37,    46,    58,    73,
+		  91,    115,    144,    182,    229,    288, 362,   456,   574,   722,
+		  909,   1144,   1440,   1813,   2282,   2873, 3617,  4553,  5732,  7216,
+		  9084,  11436,  14396,  18124,  22817,  28724,  36161, 45524, 57312, 72151,
+		  90833, 114351, 143960, 181235, 228161, 0x040000
+		};
+
+	static u8 buf[5];/* read data buffer */
+	static u32 noise;   /* noise value */
+	static u32 snr_db;  /* index into SNR_EQ[] */
+	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+
+	/* read both equalizer and pase tracker noise data */
+	i2c_selectreadbytes(state, EQPH_ERR0, buf, sizeof(buf));
+
+	if (state->current_modulation == VSB_8) {
+		/* Equalizer Mean-Square Error Register for VSB */
+		noise = ((buf[0] & 7) << 16) | (buf[1] << 8) | buf[2];
+
+		/*
+		 * Look up noise value in table.
+		 * A better search algorithm could be used...
+		 * watch out there are duplicate entries.
+		 */
+		for (snr_db = 0; snr_db < sizeof(SNR_EQ); snr_db++) {
+			if (noise < SNR_EQ[snr_db]) {
+				*snr = 43 - snr_db;
+				break;
+			}
+		}
+	} else {
+		/* Phase Tracker Mean-Square Error Register for QAM */
+		noise = ((buf[0] & 7<<3) << 13) | (buf[3] << 8) | buf[4];
+
+		/* Look up noise value in table. */
+		for (snr_db = 0; snr_db < sizeof(SNR_PH); snr_db++) {
+			if (noise < SNR_PH[snr_db]) {
+				*snr = 45 - snr_db;
+				break;
+			}
+		}
+	}
+#else
+	/* Return the raw noise value */
+	static u8 buf[5];/* read data buffer */
+	static u32 noise;   /* noise value */
+	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+
+	/* read both equalizer and pase tracker noise data */
+	i2c_selectreadbytes(state, EQPH_ERR0, buf, sizeof(buf));
+
+	if (state->current_modulation == VSB_8) {
+		/* Equalizer Mean-Square Error Register for VSB */
+		noise = ((buf[0] & 7) << 16) | (buf[1] << 8) | buf[2];
+	} else {
+		/* Phase Tracker Mean-Square Error Register for QAM */
+		noise = ((buf[0] & 7<<3) << 13) | (buf[3] << 8) | buf[4];
+	}
+
+	/* Small values for noise mean signal is better so invert noise */
+	/* Noise is 19 bit value so discard 3 LSB*/
+	*snr = ~noise>>3;
+#endif
+
+	dprintk("%s: noise = 0x%05x, snr = %idb\n",__FUNCTION__, noise, *snr);
+
+	return 0;
+}
+
+static int lgdt330x_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fe_tune_settings)
+{
+	/* I have no idea about this - it may not be needed */
+	fe_tune_settings->min_delay_ms = 500;
+	fe_tune_settings->step_size = 0;
+	fe_tune_settings->max_drift = 0;
+	return 0;
+}
+
+static void lgdt330x_release(struct dvb_frontend* fe)
+{
+	struct lgdt330x_state* state = (struct lgdt330x_state*) fe->demodulator_priv;
+	kfree(state);
+}
+
+static struct dvb_frontend_ops lgdt330x_ops;
+
+struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* config,
+				     struct i2c_adapter* i2c)
+{
+	struct lgdt330x_state* state = NULL;
+	u8 buf[1];
+
+	/* Allocate memory for the internal state */
+	state = (struct lgdt330x_state*) kmalloc(sizeof(struct lgdt330x_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+	memset(state,0,sizeof(*state));
+
+	/* Setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &lgdt330x_ops, sizeof(struct dvb_frontend_ops));
+	/* Verify communication with demod chip */
+	if (i2c_selectreadbytes(state, 2, buf, 1))
+		goto error;
+
+	state->current_frequency = -1;
+	state->current_modulation = -1;
+
+	/* Create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
+
+error:
+	if (state)
+		kfree(state);
+	dprintk("%s: ERROR\n",__FUNCTION__);
+	return NULL;
+}
+
+static struct dvb_frontend_ops lgdt330x_ops = {
+	.info = {
+		.name= "LG Electronics lgdt330x VSB/QAM Frontend",
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
+	.read_status          = lgdt330x_read_status,
+	.read_ber             = lgdt330x_read_ber,
+	.read_signal_strength = lgdt330x_read_signal_strength,
+	.read_snr             = lgdt330x_read_snr,
+	.read_ucblocks        = lgdt330x_read_ucblocks,
+	.release              = lgdt330x_release,
+};
+
+MODULE_DESCRIPTION("lgdt330x [DViCO FusionHDTV 3 Gold] (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulator Driver");
+MODULE_AUTHOR("Wilson Michaels");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(lgdt330x_attach);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * compile-command: "make DVB=1"
+ * End:
+ */
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.h linux/drivers/media/dvb/frontends/lgdt330x.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.h	2005-07-25 02:33:22.148872750 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.h	2005-07-25 02:41:15.000000000 +0000
@@ -0,0 +1,49 @@
+/*
+ *    Support for LGDT3302 & LGDT3303 (DViCO FustionHDTV Gold) - VSB/QAM
+ *
+ *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef LGDT330X_H
+#define LGDT330X_H
+
+#include <linux/dvb/frontend.h>
+
+struct lgdt330x_config
+{
+	/* The demodulator's i2c address */
+	u8 demod_address;
+
+	/* PLL interface */
+	int (*pll_rf_set) (struct dvb_frontend* fe, int index);
+	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pll_address);
+
+	/* Need to set device param for start_dma */
+	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
+};
+
+extern struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* config,
+					    struct i2c_adapter* i2c);
+
+#endif /* LGDT330X_H */
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x_priv.h linux/drivers/media/dvb/frontends/lgdt330x_priv.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x_priv.h	2005-07-25 02:33:22.148872750 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x_priv.h	2005-07-25 02:41:15.000000000 +0000
@@ -0,0 +1,70 @@
+/*
+ *    Support for LGDT3302 & LGDT3303 (DViCO FustionHDTV Gold) - VSB/QAM
+ *
+ *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef _LGDT330X_PRIV_
+#define _LGDT330X_PRIV_
+
+/* i2c control register addresses */
+enum I2C_REG {
+	TOP_CONTROL= 0x00,
+	IRQ_MASK= 0x01,
+	IRQ_STATUS= 0x02,
+	VSB_CARRIER_FREQ0= 0x16,
+	VSB_CARRIER_FREQ1= 0x17,
+	VSB_CARRIER_FREQ2= 0x18,
+	VSB_CARRIER_FREQ3= 0x19,
+	CARRIER_MSEQAM1= 0x1a,
+	CARRIER_MSEQAM2= 0x1b,
+	CARRIER_LOCK= 0x1c,
+	TIMING_RECOVERY= 0x1d,
+	AGC_DELAY0= 0x2a,
+	AGC_DELAY1= 0x2b,
+	AGC_DELAY2= 0x2c,
+	AGC_RF_BANDWIDTH0= 0x2d,
+	AGC_RF_BANDWIDTH1= 0x2e,
+	AGC_RF_BANDWIDTH2= 0x2f,
+	AGC_LOOP_BANDWIDTH0= 0x30,
+	AGC_LOOP_BANDWIDTH1= 0x31,
+	AGC_FUNC_CTRL1= 0x32,
+	AGC_FUNC_CTRL2= 0x33,
+	AGC_FUNC_CTRL3= 0x34,
+	AGC_RFIF_ACC0= 0x39,
+	AGC_RFIF_ACC1= 0x3a,
+	AGC_RFIF_ACC2= 0x3b,
+	AGC_STATUS= 0x3f,
+	SYNC_STATUS_VSB= 0x43,
+	EQPH_ERR0= 0x47,
+	EQ_ERR1= 0x48,
+	EQ_ERR2= 0x49,
+	PH_ERR1= 0x4a,
+	PH_ERR2= 0x4b,
+	DEMUX_CONTROL= 0x66,
+	PACKET_ERR_COUNTER1= 0x6a,
+	PACKET_ERR_COUNTER2= 0x6b,
+};
+
+#endif /* _LGDT330X_PRIV_ */
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-25 02:41:15.000000000 +0000
@@ -1,607 +0,0 @@
-/*
- *    Support for LGDT3302 (DViCO FustionHDTV 3 Gold) - VSB/QAM
- *
- *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
- *
- *    Based on code from  Kirk Lapray <kirk_lapray@bigfoot.com>
- *                           Copyright (C) 2005
- *
- *    This program is free software; you can redistribute it and/or modify
- *    it under the terms of the GNU General Public License as published by
- *    the Free Software Foundation; either version 2 of the License, or
- *    (at your option) any later version.
- *
- *    This program is distributed in the hope that it will be useful,
- *    but WITHOUT ANY WARRANTY; without even the implied warranty of
- *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *    GNU General Public License for more details.
- *
- *    You should have received a copy of the GNU General Public License
- *    along with this program; if not, write to the Free Software
- *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-/*
- *                      NOTES ABOUT THIS DRIVER
- *
- * This driver supports DViCO FusionHDTV 3 Gold under Linux.
- *
- * TODO:
- * BER and signal strength always return 0.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <asm/byteorder.h>
-
-#include "dvb_frontend.h"
-#include "dvb-pll.h"
-#include "lgdt3302_priv.h"
-#include "lgdt3302.h"
-
-static int debug = 0;
-module_param(debug, int, 0644);
-MODULE_PARM_DESC(debug,"Turn on/off lgdt3302 frontend debugging (default:off).");
-#define dprintk(args...) \
-do { \
-if (debug) printk(KERN_DEBUG "lgdt3302: " args); \
-} while (0)
-
-struct lgdt3302_state
-{
-	struct i2c_adapter* i2c;
-	struct dvb_frontend_ops ops;
-
-	/* Configuration settings */
-	const struct lgdt3302_config* config;
-
-	struct dvb_frontend frontend;
-
-	/* Demodulator private data */
-	fe_modulation_t current_modulation;
-
-	/* Tuner private data */
-	u32 current_frequency;
-};
-
-static int i2c_writebytes (struct lgdt3302_state* state,
-			   u8 addr, /* demod_address or pll_address */
-			   u8 *buf, /* data bytes to send */
-			   int len  /* number of bytes to send */ )
-{
-	u8 tmp[] = { buf[0], buf[1] };
-	struct i2c_msg msg =
-		{ .addr = addr, .flags = 0, .buf = tmp,  .len = 2 };
-	int err;
-	int i;
-
-	for (i=1; i<len; i++) {
-		tmp[1] = buf[i];
-		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-			printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
-			if (err < 0)
-				return err;
-			else
-				return -EREMOTEIO;
-		}
-		tmp[0]++;
-	}
-	return 0;
-}
-
-#if 0
-static int i2c_readbytes (struct lgdt3302_state* state,
-			  u8 addr, /* demod_address or pll_address */
-			  u8 *buf, /* holds data bytes read */
-			  int len  /* number of bytes to read */ )
-{
-	struct i2c_msg msg =
-		{ .addr = addr, .flags = I2C_M_RD, .buf = buf,  .len = len };
-	int err;
-
-	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-		printk(KERN_WARNING "lgdt3302: %s error (addr %02x, err == %i)\n", __FUNCTION__, addr, err);
-		return -EREMOTEIO;
-	}
-	return 0;
-}
-#endif
-
-/*
- * This routine writes the register (reg) to the demod bus
- * then reads the data returned for (len) bytes.
- */
-
-static u8 i2c_selectreadbytes (struct lgdt3302_state* state,
-			       enum I2C_REG reg, u8* buf, int len)
-{
-	u8 wr [] = { reg };
-	struct i2c_msg msg [] = {
-		{ .addr = state->config->demod_address,
-		  .flags = 0, .buf = wr,  .len = 1 },
-		{ .addr = state->config->demod_address,
-		  .flags = I2C_M_RD, .buf = buf, .len = len },
-	};
-	int ret;
-	ret = i2c_transfer(state->i2c, msg, 2);
-	if (ret != 2) {
-		printk(KERN_WARNING "lgdt3302: %s: addr 0x%02x select 0x%02x error (ret == %i)\n", __FUNCTION__, state->config->demod_address, reg, ret);
-	} else {
-		ret = 0;
-	}
-	return ret;
-}
-
-/* Software reset */
-int lgdt3302_SwReset(struct lgdt3302_state* state)
-{
-	u8 ret;
-	u8 reset[] = {
-		IRQ_MASK,
-		0x00 /* bit 6 is active low software reset
-		      *	bits 5-0 are 1 to mask interrupts */
-	};
-
-	ret = i2c_writebytes(state,
-			     state->config->demod_address,
-			     reset, sizeof(reset));
-	if (ret == 0) {
-		/* spec says reset takes 100 ns why wait */
-		/* mdelay(100);    */ /* keep low for 100mS */
-		reset[1] = 0x7f;      /* force reset high (inactive)
-				       * and unmask interrupts */
-		ret = i2c_writebytes(state,
-				     state->config->demod_address,
-				     reset, sizeof(reset));
-	}
-	/* Spec does not indicate a need for this either */
-	/*mdelay(5); */               /* wait 5 msec before doing more */
-	return ret;
-}
-
-static int lgdt3302_init(struct dvb_frontend* fe)
-{
-	/* Hardware reset is done using gpio[0] of cx23880x chip.
-	 * I'd like to do it here, but don't know how to find chip address.
-	 * cx88-cards.c arranges for the reset bit to be inactive (high).
-	 * Maybe there needs to be a callable function in cx88-core or
-	 * the caller of this function needs to do it. */
-
-	dprintk("%s entered\n", __FUNCTION__);
-	return lgdt3302_SwReset((struct lgdt3302_state*) fe->demodulator_priv);
-}
-
-static int lgdt3302_read_ber(struct dvb_frontend* fe, u32* ber)
-{
-	*ber = 0; /* Dummy out for now */
-	return 0;
-}
-
-static int lgdt3302_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
-{
-	struct lgdt3302_state* state = (struct lgdt3302_state*) fe->demodulator_priv;
-	u8 buf[2];
-
-	i2c_selectreadbytes(state, PACKET_ERR_COUNTER1, buf, sizeof(buf));
-
-	*ucblocks = (buf[0] << 8) | buf[1];
-	return 0;
-}
-
-static int lgdt3302_set_parameters(struct dvb_frontend* fe,
-				   struct dvb_frontend_parameters *param)
-{
-	struct lgdt3302_state* state =
-		(struct lgdt3302_state*) fe->demodulator_priv;
-
-	/* Use 50MHz parameter values from spec sheet since xtal is 50 */
-	static u8 top_ctrl_cfg[]   = { TOP_CONTROL, 0x03 };
-	static u8 vsb_freq_cfg[]   = { VSB_CARRIER_FREQ0, 0x00, 0x87, 0x8e, 0x01 };
-	static u8 demux_ctrl_cfg[] = { DEMUX_CONTROL, 0xfb };
-	static u8 agc_rf_cfg[]     = { AGC_RF_BANDWIDTH0, 0x40, 0x93, 0x00 };
-	static u8 agc_ctrl_cfg[]   = { AGC_FUNC_CTRL2, 0xc6, 0x40 };
-	static u8 agc_delay_cfg[]  = { AGC_DELAY0, 0x07, 0x00, 0xfe };
-	static u8 agc_loop_cfg[]   = { AGC_LOOP_BANDWIDTH0, 0x08, 0x9a };
-
-	/* Change only if we are actually changing the modulation */
-	if (state->current_modulation != param->u.vsb.modulation) {
-		switch(param->u.vsb.modulation) {
-		case VSB_8:
-			dprintk("%s: VSB_8 MODE\n", __FUNCTION__);
-
-			/* Select VSB mode and serial MPEG interface */
-			top_ctrl_cfg[1] = 0x07;
-
-			/* Select ANT connector if supported by card */
-			if (state->config->pll_rf_set)
-				state->config->pll_rf_set(fe, 1);
-			break;
-
-		case QAM_64:
-			dprintk("%s: QAM_64 MODE\n", __FUNCTION__);
-
-			/* Select QAM_64 mode and serial MPEG interface */
-			top_ctrl_cfg[1] = 0x04;
-
-			/* Select CABLE connector if supported by card */
-			if (state->config->pll_rf_set)
-				state->config->pll_rf_set(fe, 0);
-			break;
-
-		case QAM_256:
-			dprintk("%s: QAM_256 MODE\n", __FUNCTION__);
-
-			/* Select QAM_256 mode and serial MPEG interface */
-			top_ctrl_cfg[1] = 0x05;
-
-			/* Select CABLE connector if supported by card */
-			if (state->config->pll_rf_set)
-				state->config->pll_rf_set(fe, 0);
-			break;
-		default:
-			printk(KERN_WARNING "lgdt3302: %s: Modulation type(%d) UNSUPPORTED\n", __FUNCTION__, param->u.vsb.modulation);
-			return -1;
-		}
-		/* Initializations common to all modes */
-
-		/* Select the requested mode */
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
-		state->config->set_ts_params(fe, 0);
-		state->current_modulation = param->u.vsb.modulation;
-	}
-
-	/* Change only if we are actually changing the channel */
-	if (state->current_frequency != param->frequency) {
-		u8 buf[5];
-
-		/* This must be done before the initialized msg is declared */
-		state->config->pll_set(fe, param, buf);
-
-		struct i2c_msg msg =
-			{ .addr = buf[0], .flags = 0, .buf = &buf[1], .len = 4 };
-		int err;
-
-		dprintk("%s: tuner at 0x%02x bytes: 0x%02x 0x%02x "
-			"0x%02x 0x%02x\n", __FUNCTION__,
-			buf[0],buf[1],buf[2],buf[3],buf[4]);
-		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-			printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, buf[0], buf[1], err);
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
-		state->current_frequency = param->frequency;
-	}
-	lgdt3302_SwReset(state);
-	return 0;
-}
-
-static int lgdt3302_get_frontend(struct dvb_frontend* fe,
-				 struct dvb_frontend_parameters* param)
-{
-	struct lgdt3302_state *state = fe->demodulator_priv;
-	param->frequency = state->current_frequency;
-	return 0;
-}
-
-static int lgdt3302_read_status(struct dvb_frontend* fe, fe_status_t* status)
-{
-	struct lgdt3302_state* state = (struct lgdt3302_state*) fe->demodulator_priv;
-	u8 buf[3];
-
-	*status = 0; /* Reset status result */
-
-	/*
-	 * You must set the Mask bits to 1 in the IRQ_MASK in order
-	 * to see that status bit in the IRQ_STATUS register.
-	 * This is done in SwReset();
-	 */
-
-	/* AGC status register */
-	i2c_selectreadbytes(state, AGC_STATUS, buf, 1);
-	dprintk("%s: AGC_STATUS = 0x%02x\n", __FUNCTION__, buf[0]);
-	if ((buf[0] & 0x0c) == 0x8){
-		/* Test signal does not exist flag */
-		/* as well as the AGC lock flag.   */
-		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
-	}
-
-	/* signal status */
-	i2c_selectreadbytes(state, TOP_CONTROL, buf, sizeof(buf));
-	dprintk("%s: TOP_CONTROL = 0x%02x, IRO_MASK = 0x%02x, IRQ_STATUS = 0x%02x\n", __FUNCTION__, buf[0], buf[1], buf[2]);
-
-#if 0
-	/* Alternative method to check for a signal */
-	/* using the SNR good/bad interrupts.   */
-	if ((buf[2] & 0x30) == 0x10)
-		*status |= FE_HAS_SIGNAL;
-#endif
-
-	/* sync status */
-	if ((buf[2] & 0x03) == 0x01) {
-		*status |= FE_HAS_SYNC;
-	}
-
-	/* FEC error status */
-	if ((buf[2] & 0x0c) == 0x08) {
-		*status |= FE_HAS_LOCK;
-		*status |= FE_HAS_VITERBI;
-	}
-
-	/* Carrier Recovery Lock Status Register */
-	i2c_selectreadbytes(state, CARRIER_LOCK, buf, 1);
-	dprintk("%s: CARRIER_LOCK = 0x%02x\n", __FUNCTION__, buf[0]);
-	switch (state->current_modulation) {
-	case QAM_256:
-	case QAM_64:
-		/* Need to undestand why there are 3 lock levels here */
-		if ((buf[0] & 0x07) == 0x07)
-			*status |= FE_HAS_CARRIER;
-		break;
-	case VSB_8:
-		if ((buf[0] & 0x80) == 0x80)
-			*status |= FE_HAS_CARRIER;
-		break;
-	default:
-		printk("KERN_WARNING lgdt3302: %s: Modulation set to unsupported value\n", __FUNCTION__);
-	}
-
-	return 0;
-}
-
-static int lgdt3302_read_signal_strength(struct dvb_frontend* fe, u16* strength)
-{
-	/* not directly available. */
-	return 0;
-}
-
-static int lgdt3302_read_snr(struct dvb_frontend* fe, u16* snr)
-{
-#ifdef SNR_IN_DB
-	/*
-	 * Spec sheet shows formula for SNR_EQ = 10 log10(25 * 24**2 / noise)
-	 * and SNR_PH = 10 log10(25 * 32**2 / noise) for equalizer and phase tracker
-	 * respectively. The following tables are built on these formulas.
-	 * The usual definition is SNR = 20 log10(signal/noise)
-	 * If the specification is wrong the value retuned is 1/2 the actual SNR in db.
-	 *
-	 * This table is a an ordered list of noise values computed by the
-	 * formula from the spec sheet such that the index into the table
-	 * starting at 43 or 45 is the SNR value in db. There are duplicate noise
-	 * value entries at the beginning because the SNR varies more than
-	 * 1 db for a change of 1 digit in noise at very small values of noise.
-	 *
-	 * Examples from SNR_EQ table:
-	 * noise SNR
-	 *   0    43
-	 *   1    42
-	 *   2    39
-	 *   3    37
-	 *   4    36
-	 *   5    35
-	 *   6    34
-	 *   7    33
-	 *   8    33
-	 *   9    32
-	 *   10   32
-	 *   11   31
-	 *   12   31
-	 *   13   30
-	 */
-
-	static const u32 SNR_EQ[] =
-		{ 1,     2,      2,      2, 3,      3,      4,     4,     5,     7,
-		  9,     11,     13,     17, 21,     26,     33,    41,    52,    65,
-		  81,    102,    129,    162, 204,    257,    323,   406,   511,   644,
-		  810,   1020,   1284,   1616, 2035,   2561,   3224,  4059,  5110,  6433,
-		  8098,  10195,  12835,  16158, 20341,  25608,  32238, 40585, 51094, 64323,
-		  80978, 101945, 128341, 161571, 203406, 256073, 0x40000
-		};
-
-	static const u32 SNR_PH[] =
-		{ 1,     2,      2,      2,      3,      3,     4,     5,     6,     8,
-		  10,    12,     15,     19,     23,     29, 37,    46,    58,    73,
-		  91,    115,    144,    182,    229,    288, 362,   456,   574,   722,
-		  909,   1144,   1440,   1813,   2282,   2873, 3617,  4553,  5732,  7216,
-		  9084,  11436,  14396,  18124,  22817,  28724,  36161, 45524, 57312, 72151,
-		  90833, 114351, 143960, 181235, 228161, 0x040000
-		};
-
-	static u8 buf[5];/* read data buffer */
-	static u32 noise;   /* noise value */
-	static u32 snr_db;  /* index into SNR_EQ[] */
-	struct lgdt3302_state* state = (struct lgdt3302_state*) fe->demodulator_priv;
-
-	/* read both equalizer and pase tracker noise data */
-	i2c_selectreadbytes(state, EQPH_ERR0, buf, sizeof(buf));
-
-	if (state->current_modulation == VSB_8) {
-		/* Equalizer Mean-Square Error Register for VSB */
-		noise = ((buf[0] & 7) << 16) | (buf[1] << 8) | buf[2];
-
-		/*
-		 * Look up noise value in table.
-		 * A better search algorithm could be used...
-		 * watch out there are duplicate entries.
-		 */
-		for (snr_db = 0; snr_db < sizeof(SNR_EQ); snr_db++) {
-			if (noise < SNR_EQ[snr_db]) {
-				*snr = 43 - snr_db;
-				break;
-			}
-		}
-	} else {
-		/* Phase Tracker Mean-Square Error Register for QAM */
-		noise = ((buf[0] & 7<<3) << 13) | (buf[3] << 8) | buf[4];
-
-		/* Look up noise value in table. */
-		for (snr_db = 0; snr_db < sizeof(SNR_PH); snr_db++) {
-			if (noise < SNR_PH[snr_db]) {
-				*snr = 45 - snr_db;
-				break;
-			}
-		}
-	}
-#else
-	/* Return the raw noise value */
-	static u8 buf[5];/* read data buffer */
-	static u32 noise;   /* noise value */
-	struct lgdt3302_state* state = (struct lgdt3302_state*) fe->demodulator_priv;
-
-	/* read both equalizer and pase tracker noise data */
-	i2c_selectreadbytes(state, EQPH_ERR0, buf, sizeof(buf));
-
-	if (state->current_modulation == VSB_8) {
-		/* Equalizer Mean-Square Error Register for VSB */
-		noise = ((buf[0] & 7) << 16) | (buf[1] << 8) | buf[2];
-	} else {
-		/* Phase Tracker Mean-Square Error Register for QAM */
-		noise = ((buf[0] & 7<<3) << 13) | (buf[3] << 8) | buf[4];
-	}
-
-	/* Small values for noise mean signal is better so invert noise */
-	/* Noise is 19 bit value so discard 3 LSB*/
-	*snr = ~noise>>3;
-#endif
-
-	dprintk("%s: noise = 0x%05x, snr = %idb\n",__FUNCTION__, noise, *snr);
-
-	return 0;
-}
-
-static int lgdt3302_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fe_tune_settings)
-{
-	/* I have no idea about this - it may not be needed */
-	fe_tune_settings->min_delay_ms = 500;
-	fe_tune_settings->step_size = 0;
-	fe_tune_settings->max_drift = 0;
-	return 0;
-}
-
-static void lgdt3302_release(struct dvb_frontend* fe)
-{
-	struct lgdt3302_state* state = (struct lgdt3302_state*) fe->demodulator_priv;
-	kfree(state);
-}
-
-static struct dvb_frontend_ops lgdt3302_ops;
-
-struct dvb_frontend* lgdt3302_attach(const struct lgdt3302_config* config,
-				     struct i2c_adapter* i2c)
-{
-	struct lgdt3302_state* state = NULL;
-	u8 buf[1];
-
-	/* Allocate memory for the internal state */
-	state = (struct lgdt3302_state*) kmalloc(sizeof(struct lgdt3302_state), GFP_KERNEL);
-	if (state == NULL)
-		goto error;
-	memset(state,0,sizeof(*state));
-
-	/* Setup the state */
-	state->config = config;
-	state->i2c = i2c;
-	memcpy(&state->ops, &lgdt3302_ops, sizeof(struct dvb_frontend_ops));
-	/* Verify communication with demod chip */
-	if (i2c_selectreadbytes(state, 2, buf, 1))
-		goto error;
-
-	state->current_frequency = -1;
-	state->current_modulation = -1;
-
-	/* Create dvb_frontend */
-	state->frontend.ops = &state->ops;
-	state->frontend.demodulator_priv = state;
-	return &state->frontend;
-
-error:
-	if (state)
-		kfree(state);
-	dprintk("%s: ERROR\n",__FUNCTION__);
-	return NULL;
-}
-
-static struct dvb_frontend_ops lgdt3302_ops = {
-	.info = {
-		.name= "LG Electronics LGDT3302 VSB/QAM Frontend",
-		.type = FE_ATSC,
-		.frequency_min= 54000000,
-		.frequency_max= 858000000,
-		.frequency_stepsize= 62500,
-		/* Symbol rate is for all VSB modes need to check QAM */
-		.symbol_rate_min    = 10762000,
-		.symbol_rate_max    = 10762000,
-		.caps = FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
-	},
-	.init                 = lgdt3302_init,
-	.set_frontend         = lgdt3302_set_parameters,
-	.get_frontend         = lgdt3302_get_frontend,
-	.get_tune_settings    = lgdt3302_get_tune_settings,
-	.read_status          = lgdt3302_read_status,
-	.read_ber             = lgdt3302_read_ber,
-	.read_signal_strength = lgdt3302_read_signal_strength,
-	.read_snr             = lgdt3302_read_snr,
-	.read_ucblocks        = lgdt3302_read_ucblocks,
-	.release              = lgdt3302_release,
-};
-
-MODULE_DESCRIPTION("LGDT3302 [DViCO FusionHDTV 3 Gold] (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulator Driver");
-MODULE_AUTHOR("Wilson Michaels");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(lgdt3302_attach);
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * compile-command: "make DVB=1"
- * End:
- */
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.h linux/drivers/media/dvb/frontends/lgdt3302.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.h	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.h	2005-07-25 02:41:15.000000000 +0000
@@ -1,49 +0,0 @@
-/*
- *    Support for LGDT3302 (DViCO FustionHDTV 3 Gold) - VSB/QAM
- *
- *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
- *
- *    This program is free software; you can redistribute it and/or modify
- *    it under the terms of the GNU General Public License as published by
- *    the Free Software Foundation; either version 2 of the License, or
- *    (at your option) any later version.
- *
- *    This program is distributed in the hope that it will be useful,
- *    but WITHOUT ANY WARRANTY; without even the implied warranty of
- *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *    GNU General Public License for more details.
- *
- *    You should have received a copy of the GNU General Public License
- *    along with this program; if not, write to the Free Software
- *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef LGDT3302_H
-#define LGDT3302_H
-
-#include <linux/dvb/frontend.h>
-
-struct lgdt3302_config
-{
-	/* The demodulator's i2c address */
-	u8 demod_address;
-
-	/* PLL interface */
-	int (*pll_rf_set) (struct dvb_frontend* fe, int index);
-	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pll_address);
-
-	/* Need to set device param for start_dma */
-	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
-};
-
-extern struct dvb_frontend* lgdt3302_attach(const struct lgdt3302_config* config,
-					    struct i2c_adapter* i2c);
-
-#endif /* LGDT3302_H */
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302_priv.h linux/drivers/media/dvb/frontends/lgdt3302_priv.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302_priv.h	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302_priv.h	2005-07-25 02:41:15.000000000 +0000
@@ -1,72 +0,0 @@
-/*
- * $Id: lgdt3302_priv.h,v 1.2 2005/06/28 23:50:48 mkrufky Exp $
- *
- *    Support for LGDT3302 (DViCO FustionHDTV 3 Gold) - VSB/QAM
- *
- *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
- *
- *    This program is free software; you can redistribute it and/or modify
- *    it under the terms of the GNU General Public License as published by
- *    the Free Software Foundation; either version 2 of the License, or
- *    (at your option) any later version.
- *
- *    This program is distributed in the hope that it will be useful,
- *    but WITHOUT ANY WARRANTY; without even the implied warranty of
- *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *    GNU General Public License for more details.
- *
- *    You should have received a copy of the GNU General Public License
- *    along with this program; if not, write to the Free Software
- *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef _LGDT3302_PRIV_
-#define _LGDT3302_PRIV_
-
-/* i2c control register addresses */
-enum I2C_REG {
-	TOP_CONTROL= 0x00,
-	IRQ_MASK= 0x01,
-	IRQ_STATUS= 0x02,
-	VSB_CARRIER_FREQ0= 0x16,
-	VSB_CARRIER_FREQ1= 0x17,
-	VSB_CARRIER_FREQ2= 0x18,
-	VSB_CARRIER_FREQ3= 0x19,
-	CARRIER_MSEQAM1= 0x1a,
-	CARRIER_MSEQAM2= 0x1b,
-	CARRIER_LOCK= 0x1c,
-	TIMING_RECOVERY= 0x1d,
-	AGC_DELAY0= 0x2a,
-	AGC_DELAY1= 0x2b,
-	AGC_DELAY2= 0x2c,
-	AGC_RF_BANDWIDTH0= 0x2d,
-	AGC_RF_BANDWIDTH1= 0x2e,
-	AGC_RF_BANDWIDTH2= 0x2f,
-	AGC_LOOP_BANDWIDTH0= 0x30,
-	AGC_LOOP_BANDWIDTH1= 0x31,
-	AGC_FUNC_CTRL1= 0x32,
-	AGC_FUNC_CTRL2= 0x33,
-	AGC_FUNC_CTRL3= 0x34,
-	AGC_RFIF_ACC0= 0x39,
-	AGC_RFIF_ACC1= 0x3a,
-	AGC_RFIF_ACC2= 0x3b,
-	AGC_STATUS= 0x3f,
-	SYNC_STATUS_VSB= 0x43,
-	EQPH_ERR0= 0x47,
-	EQ_ERR1= 0x48,
-	EQ_ERR2= 0x49,
-	PH_ERR1= 0x4a,
-	PH_ERR2= 0x4b,
-	DEMUX_CONTROL= 0x66,
-	PACKET_ERR_COUNTER1= 0x6a,
-	PACKET_ERR_COUNTER2= 0x6b,
-};
-
-#endif /* _LGDT3302_PRIV_ */
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
diff -u linux-2.6.13/drivers/media/video/Kconfig linux/drivers/media/video/Kconfig
--- linux-2.6.13/drivers/media/video/Kconfig	2005-07-25 02:37:22.000000000 +0000
+++ linux/drivers/media/video/Kconfig	2005-07-25 02:41:15.000000000 +0000
@@ -331,7 +331,7 @@
 	select DVB_MT352
 	select DVB_OR51132
 	select DVB_CX22702
-	select DVB_LGDT3302
+	select DVB_LGDT330X
 	---help---
 	  This adds support for DVB/ATSC cards based on the
 	  Connexant 2388x chip.
diff -u linux-2.6.13/drivers/media/dvb/frontends/Makefile linux/drivers/media/dvb/frontends/Makefile
--- linux-2.6.13/drivers/media/dvb/frontends/Makefile	2005-07-25 02:37:20.000000000 +0000
+++ linux/drivers/media/dvb/frontends/Makefile	2005-07-25 02:41:15.000000000 +0000
@@ -30,4 +30,4 @@
 obj-$(CONFIG_DVB_OR51132) += or51132.o
 obj-$(CONFIG_DVB_BCM3510) += bcm3510.o
 obj-$(CONFIG_DVB_S5H1420) += s5h1420.o
-obj-$(CONFIG_DVB_LGDT3302) += lgdt3302.o
+obj-$(CONFIG_DVB_LGDT330X) += lgdt330x.o
diff -u linux-2.6.13/drivers/media/dvb/frontends/Kconfig linux/drivers/media/dvb/frontends/Kconfig
--- linux-2.6.13/drivers/media/dvb/frontends/Kconfig	2005-07-25 02:37:20.000000000 +0000
+++ linux/drivers/media/dvb/frontends/Kconfig	2005-07-25 02:41:15.000000000 +0000
@@ -187,8 +187,8 @@
 	  An ATSC 8VSB/16VSB and QAM64/256 tuner module. Say Y when you want to
 	  support this frontend.
 
-config DVB_LGDT3302
-	tristate "LGDT3302 based (DViCO FusionHDTV3 Gold)"
+config DVB_LGDT330X
+	tristate "LGDT3302 or LGDT3303 based (DViCO FusionHDTV Gold)"
 	depends on DVB_CORE
 	help
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want

--------------040501030906040404030703--

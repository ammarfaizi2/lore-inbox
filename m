Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUIQOs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUIQOs1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUIQOs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:48:26 -0400
Received: from mail.convergence.de ([212.227.36.84]:16032 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268805AbUIQOa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:30:27 -0400
Message-ID: <414AF4CE.7000000@linuxtv.org>
Date: Fri, 17 Sep 2004 16:29:34 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][5/14] convert frontend drivers to kernel i2c 1/3
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org>
In-Reply-To: <414AF461.4050707@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------060709000801040200090609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709000801040200090609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060709000801040200090609
Content-Type: text/plain;
 name="05-DVB-frontend-conversion.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="05-DVB-frontend-conversion.diff"

- [DVB] stv0299, tda1004x, ves1820, ves1x93: convert from dvb-i2c to kernel-i2c, MODULE_PARM() to module_param(), dvb_delay() to mdelay()
- [DVB] tda1004x: move from home-brewn firmware loading to firmware_class
- [DVB] stv0299: support Cinergy1200, patch by Uli Luckas

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/stv0299.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/stv0299.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/stv0299.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/stv0299.c	2004-08-18 19:52:17.000000000 +0200
@@ -48,21 +48,28 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-#if 0
-#define dprintk(x...) printk(x)
-#else
-#define dprintk(x...)
-#endif
+#define FRONTEND_NAME "dvbfe_stv0299"
 
-static int stv0299_status = 0;
-static int disable_typhoon = 0;
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
+
+static int debug;
+static int stv0299_status;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
+module_param(stv0299_status, int, 0444);
+MODULE_PARM_DESC(stv0299_status, "Which status value to support "
+		 "(0 == BER (default), 1 == UCBLOCKS)");
 
 #define STATUS_BER 0
 #define STATUS_UCBLOCKS 1
@@ -77,6 +84,7 @@
 #define SAMSUNG_TBMU24112IMB    4
 #define PHILIPS_SU1278_TSA_TT	5 // SU1278 with TSA5059 synth and TechnoTrend settings
 #define PHILIPS_SU1278_TSA_TY	6 // SU1278 with TUA5059 synth and Typhoon wiring
+#define PHILIPS_SU1278_TSA_CI	7 // SU1278 with TUA5059 synth and TerraTec Cinergy wiring
 
 /* Master Clock = 88 MHz */
 #define M_CLK (88000000UL) 
@@ -108,6 +116,8 @@
 	u32 tuner_frequency;
 	u32 symbol_rate;
 	fe_code_rate_t fec_inner;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
 };
 
 
@@ -264,26 +274,26 @@
         0x34, 0x13
 };
 
-static int stv0299_set_FEC (struct dvb_i2c_bus *i2c, fe_code_rate_t fec);
-static int stv0299_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate, int tuner_type);
+static int stv0299_set_FEC (struct i2c_adapter *i2c, fe_code_rate_t fec);
+static int stv0299_set_symbolrate (struct i2c_adapter *i2c, u32 srate, int tuner_type);
 
-static int stv0299_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
+static int stv0299_writereg (struct i2c_adapter *i2c, u8 reg, u8 data)
 {
 	int ret;
 	u8 buf [] = { reg, data };
 	struct i2c_msg msg = { .addr = 0x68, .flags = 0, .buf = buf, .len = 2 };
 
-	ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer (i2c, &msg, 1);
 
 	if (ret != 1) 
 		dprintk("%s: writereg error (reg == 0x%02x, val == 0x%02x, "
 			"ret == %i)\n", __FUNCTION__, reg, data, ret);
 
-	return (ret != 1) ? -1 : 0;
+	return (ret != 1) ? -EREMOTEIO : 0;
 }
 
 
-static u8 stv0299_readreg (struct dvb_i2c_bus *i2c, u8 reg)
+static u8 stv0299_readreg (struct i2c_adapter *i2c, u8 reg)
 {
 	int ret;
 	u8 b0 [] = { reg };
@@ -291,7 +301,7 @@
 	struct i2c_msg msg [] = { { .addr = 0x68, .flags = 0, .buf = b0, .len = 1 },
 			   { .addr = 0x68, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer (i2c, msg, 2);
         
 	if (ret != 2) 
 		dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n",
@@ -301,13 +311,13 @@
 }
 
 
-static int stv0299_readregs (struct dvb_i2c_bus *i2c, u8 reg1, u8 *b, u8 len)
+static int stv0299_readregs (struct i2c_adapter *i2c, u8 reg1, u8 *b, u8 len)
 {
         int ret;
         struct i2c_msg msg [] = { { .addr = 0x68, .flags = 0, .buf = &reg1, .len = 1 },
                            { .addr = 0x68, .flags = I2C_M_RD, .buf = b, .len = len } };
 
-        ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer (i2c, msg, 2);
 
         if (ret != 2)
                 dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -316,7 +326,7 @@
 }
 
 
-static int pll_write (struct dvb_i2c_bus *i2c, u8 addr, u8 *data, int len)
+static int pll_write (struct i2c_adapter *i2c, u8 addr, u8 *data, int len)
 {
 	int ret;
 	struct i2c_msg msg = { addr: addr, .flags = 0, .buf = data, .len = len };
@@ -324,7 +334,7 @@
 
 	stv0299_writereg(i2c, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
 
-	ret =  i2c->xfer (i2c, &msg, 1);
+	ret =  i2c_transfer (i2c, &msg, 1);
 
 	stv0299_writereg(i2c, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
 
@@ -335,7 +345,7 @@
 }
 
 
-static int sl1935_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, int ftype)
+static int sl1935_set_tv_freq (struct i2c_adapter *i2c, u32 freq, int ftype)
 {
 	u8 buf[4];
 	u32 div;
@@ -358,7 +368,7 @@
  *   set up the downconverter frequency divisor for a 
  *   reference clock comparision frequency of 125 kHz.
  */
-static int tsa5059_set_tv_freq	(struct dvb_i2c_bus *i2c, u32 freq, int ftype, int srate)
+static int tsa5059_set_tv_freq	(struct i2c_adapter *i2c, u32 freq, int ftype, int srate)
 {
 	u8 addr;
 	u32 div;
@@ -389,7 +399,8 @@
 	case PHILIPS_SU1278_TSA:
 	case PHILIPS_SU1278_TSA_TT:
 	case PHILIPS_SU1278_TSA_TY:
-		if (ftype == PHILIPS_SU1278_TSA_TY)
+	case PHILIPS_SU1278_TSA_CI:
+		if (ftype == PHILIPS_SU1278_TSA_TY || ftype == PHILIPS_SU1278_TSA_CI)
 			addr = 0x61;
 		else
 		addr = 0x60;
@@ -421,7 +432,7 @@
 #define MIN2(a,b) ((a) < (b) ? (a) : (b))
 #define MIN3(a,b,c) MIN2(MIN2(a,b),c)
 
-static int tua6100_set_tv_freq	(struct dvb_i2c_bus *i2c, u32 freq,
+static int tua6100_set_tv_freq	(struct i2c_adapter *i2c, u32 freq,
 			 int ftype, int srate)
 {
 	u8 reg0 [2] = { 0x00, 0x00 };
@@ -542,7 +553,7 @@
 }
 
 
-static int pll_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, int ftype, int srate)
+static int pll_set_tv_freq (struct i2c_adapter *i2c, u32 freq, int ftype, int srate)
 {
 	switch(ftype) {
 	case SAMSUNG_TBMU24112IMB:
@@ -560,7 +571,7 @@
 }
 
 #if 0
-static int tsa5059_read_status	(struct dvb_i2c_bus *i2c)
+static int tsa5059_read_status	(struct i2c_adapter *i2c)
 {
 	int ret;
 	u8 rpt1 [] = { 0x05, 0xb5 };
@@ -571,7 +582,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer (i2c, msg, 2);
 
 	if (ret != 2)
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -581,7 +592,7 @@
 #endif
 
 
-static int stv0299_init (struct dvb_i2c_bus *i2c, int ftype)
+static int stv0299_init (struct i2c_adapter *i2c, int ftype)
 {
 	int i;
 
@@ -614,7 +625,7 @@
 		stv0299_writereg (i2c, init_tab[i], init_tab[i+1]);
 
         /* AGC1 reference register setup */
-		if (ftype == PHILIPS_SU1278_TSA || ftype == PHILIPS_SU1278_TSA_TY)
+		if (ftype == PHILIPS_SU1278_TSA || ftype == PHILIPS_SU1278_TSA_TY || ftype == PHILIPS_SU1278_TSA_CI)
 		  stv0299_writereg (i2c, 0x0f, 0x92);  /* Iagc = Inverse, m1 = 18 */
 		else if (ftype == PHILIPS_SU1278_TUA)
 		  stv0299_writereg (i2c, 0x0f, 0x94);  /* Iagc = Inverse, m1 = 20 */
@@ -637,7 +648,7 @@
 }
 
 
-static int stv0299_set_FEC (struct dvb_i2c_bus *i2c, fe_code_rate_t fec)
+static int stv0299_set_FEC (struct i2c_adapter *i2c, fe_code_rate_t fec)
 {
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -681,7 +692,7 @@
 }
 
 
-static fe_code_rate_t stv0299_get_fec (struct dvb_i2c_bus *i2c)
+static fe_code_rate_t stv0299_get_fec (struct i2c_adapter *i2c)
 {
 	static fe_code_rate_t fec_tab [] = { FEC_2_3, FEC_3_4, FEC_5_6,
 					     FEC_7_8, FEC_1_2 };
@@ -699,7 +710,7 @@
 }
 
 
-static int stv0299_wait_diseqc_fifo (struct dvb_i2c_bus *i2c, int timeout)
+static int stv0299_wait_diseqc_fifo (struct i2c_adapter *i2c, int timeout)
 {
 	unsigned long start = jiffies;
 
@@ -710,14 +721,14 @@
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-		dvb_delay(10);
+		msleep(10);
 	};
 
 	return 0;
 }
 
 
-static int stv0299_wait_diseqc_idle (struct dvb_i2c_bus *i2c, int timeout)
+static int stv0299_wait_diseqc_idle (struct i2c_adapter *i2c, int timeout)
 {
 	unsigned long start = jiffies;
 
@@ -728,14 +739,14 @@
 			dprintk ("%s: timeout!!\n", __FUNCTION__);
 			return -ETIMEDOUT;
 		}
-		dvb_delay(10);
+		msleep(10);
 	};
 
 	return 0;
 }
 
 
-static int stv0299_send_diseqc_msg (struct dvb_i2c_bus *i2c,
+static int stv0299_send_diseqc_msg (struct i2c_adapter *i2c,
 			     struct dvb_diseqc_master_cmd *m)
 {
 	u8 val;
@@ -766,7 +777,7 @@
 }
 
 
-static int stv0299_send_diseqc_burst (struct dvb_i2c_bus *i2c, fe_sec_mini_cmd_t burst)
+static int stv0299_send_diseqc_burst (struct i2c_adapter *i2c, fe_sec_mini_cmd_t burst)
 {
 	u8 val;
 
@@ -793,7 +804,7 @@
 }
 
 
-static int stv0299_set_tone (struct dvb_i2c_bus *i2c, fe_sec_tone_mode_t tone)
+static int stv0299_set_tone (struct i2c_adapter *i2c, fe_sec_tone_mode_t tone)
 {
 	u8 val;
 
@@ -826,7 +837,7 @@
 }
 
 
-static int stv0299_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage,
+static int stv0299_set_voltage (struct i2c_adapter *i2c, fe_sec_voltage_t voltage,
 				int tuner_type)
 {
 	u8 reg0x08;
@@ -849,11 +860,18 @@
 		return stv0299_writereg (i2c, 0x08, 0x00); /*	LNB power off! */
 	}
 	
+	if (tuner_type == PHILIPS_SU1278_TSA_CI) 
+	{
+		stv0299_writereg (i2c, 0x08, reg0x08 & 0xBF); // switch LNB power on OP2/LOCK pin off
+	}
+	else
+	{
 		stv0299_writereg (i2c, 0x08, reg0x08 | 0x40);
+	}
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
-		if (tuner_type == PHILIPS_SU1278_TSA_TY)
+		if (tuner_type == PHILIPS_SU1278_TSA_TY || tuner_type == PHILIPS_SU1278_TSA_CI)
 			return stv0299_writereg (i2c, 0x0c, reg0x0c | 0x10);
 		else
 			return stv0299_writereg (i2c, 0x0c, reg0x0c | 0x40);
@@ -867,7 +885,7 @@
 }
 
 
-static int stv0299_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate, int tuner_type)
+static int stv0299_set_symbolrate (struct i2c_adapter *i2c, u32 srate, int tuner_type)
 {
 	u64 big = srate;
 	u32 ratio;
@@ -918,6 +937,7 @@
 	        break;
 
 	case PHILIPS_SU1278_TSA_TY:
+	case PHILIPS_SU1278_TSA_CI:
 	case PHILIPS_SU1278_TSA:
 		aclk = 0xb5;
 		if (srate < 2000000) bclk = 0x86;
@@ -958,7 +978,7 @@
 }
 
 
-static int stv0299_get_symbolrate (struct dvb_i2c_bus *i2c, int tuner_type)
+static int stv0299_get_symbolrate (struct i2c_adapter *i2c, int tuner_type)
 {
 	u32 Mclk = M_CLK / 4096L;
 	u32 srate;
@@ -995,8 +1014,8 @@
 
 static int uni0299_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
 	struct stv0299_state *state = (struct stv0299_state *) fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -1248,9 +1267,9 @@
 	return 0;
 }
 
-static long probe_tuner (struct dvb_i2c_bus *i2c)
+static long probe_tuner (struct i2c_adapter *adapter)
 {
-	struct dvb_adapter * adapter = (struct dvb_adapter *) i2c->adapter;
+	struct i2c_adapter *i2c = adapter; /* superfluous */
 
         /* read the status register of TSA5059 */
 	u8 rpt[] = { 0x05, 0xb5 };
@@ -1269,45 +1288,45 @@
 	stv0299_writereg (i2c, 0x03, 0x00);
 
 
-	printk ("%s: try to attach to %s\n", __FUNCTION__, adapter->name);
-
-	if ( strcmp(adapter->name, "Technisat SkyStar2 driver") == 0 )
-	{
-	    printk ("%s: setup for tuner Samsung TBMU24112IMB\n", __FILE__);
+	printk("stv0299: try to attach to %s\n", adapter->name);
 
+	if (!strcmp(adapter->name, "Technisat SkyStar2 driver")) {
+	    printk ("stv0299: setup for tuner Samsung TBMU24112IMB\n");
     	    return SAMSUNG_TBMU24112IMB;
 	}
 
-	if ((ret = i2c->xfer(i2c, msg1, 2)) == 2) {
+	if ((ret = i2c_transfer(i2c, msg1, 2)) == 2) {
 	        if ( strcmp(adapter->name, "TT-Budget/WinTV-NOVA-CI PCI") == 0 ) {
 		        // technotrend cards require non-datasheet settings
-			printk ("%s: setup for tuner SU1278 (TSA5059 synth) on"
-				" TechnoTrend hardware\n", __FILE__);
+			printk ("stv0299: setup for tuner SU1278 (TSA5059 synth) on TechnoTrend hardware\n");
 		        return PHILIPS_SU1278_TSA_TT;
 		}  else {
 		        // fall back to datasheet-recommended settings
-			printk ("%s: setup for tuner SU1278 (TSA5059 synth)\n",
-				__FILE__);
+			printk ("stv0299: setup for tuner SU1278 (TSA5059 synth)\n");
 		        return PHILIPS_SU1278_TSA;
 		}
 		}
 
-	if ((ret = i2c->xfer(i2c, msg2, 2)) == 2) {
-		if ( strcmp(adapter->name, "KNC1 DVB-S") == 0 &&
-		     !disable_typhoon )
+	if ((ret = i2c_transfer(i2c, msg2, 2)) == 2) {
+		if ( strcmp(adapter->name, "KNC1 DVB-S") == 0 )
 		{
 			// Typhoon cards have unusual wiring.
-			printk ("%s: setup for tuner SU1278 (TSA5059 synth) on"
-				" Typhoon hardware\n", __FILE__);
+			printk ("stv0299: setup for tuner SU1278 (TSA5059 synth) on Typhoon hardware\n");
 			return PHILIPS_SU1278_TSA_TY;
 		}
+		else if ( strcmp(adapter->name, "TerraTec Cinergy 1200 DVB-S") == 0 )
+		{
+			// Cinergy cards have unusual wiring.
+			printk ("%s: setup for tuner SU1278 (TSA5059 synth) on"
+				" TerraTec hardware\n", __FILE__);
+			return PHILIPS_SU1278_TSA_CI;
+		}
 		//else if ((stat[0] & 0x3f) == 0) {
 		else if (0) {
-			printk ("%s: setup for tuner TDQF-S001F\n", __FILE__);
+			printk ("stv0299: setup for tuner TDQF-S001F\n");
 			return LG_TDQF_S001F;
 	} else {
-			printk ("%s: setup for tuner BSRU6, TDQB-S00x\n",
-			__FILE__);
+			printk ("stv0299: setup for tuner BSRU6, TDQB-S00x\n");
 			return ALPS_BSRU6;
 	}
 	}
@@ -1317,29 +1336,29 @@
 	 */
 	stv0299_writereg (i2c, 0x02, 0x00);
 
-	if ((ret = i2c->xfer(i2c, msg3, 2)) == 2) {
-		printk ("%s: setup for tuner Philips SU1278 (TUA6100 synth)\n",
-			__FILE__);
+	if ((ret = i2c_transfer(i2c, msg3, 2)) == 2) {
+		printk ("stv0299: setup for tuner Philips SU1278 (TUA6100 synth)\n");
 		return PHILIPS_SU1278_TUA;
 	}
 
-	printk ("%s: unknown PLL synthesizer (ret == %i), "
-		"please report to <linuxdvb@linuxtv.org>!!\n",
-		__FILE__, ret);
+	printk ("stv0299: unknown PLL synthesizer (ret == %i), please report to <linuxdvb@linuxtv.org>!!\n", ret);
 
 	return UNKNOWN_FRONTEND;
 }
 
+static struct i2c_client client_template;
 
-static int uni0299_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter(struct i2c_adapter *adapter)
 {
+	struct i2c_client *client;
 	struct stv0299_state* state;
 	int tuner_type;
+	int ret;
 	u8 id;
  
-	stv0299_writereg (i2c, 0x02, 0x34); /* standby off */
-	dvb_delay(200);
-	id = stv0299_readreg (i2c, 0x00);
+	stv0299_writereg(adapter, 0x02, 0x34); /* standby off */
+	msleep(200);
+	id = stv0299_readreg(adapter, 0x00);
 
 	dprintk ("%s: id == 0x%02x\n", __FUNCTION__, id);
 
@@ -1348,53 +1367,112 @@
 	if (id != 0xa1 && id != 0x80)
 		return -ENODEV;
 
-	if ((tuner_type = probe_tuner(i2c)) < 0)
+	if ((tuner_type = probe_tuner(adapter)) < 0)
 		return -ENODEV;
 
 	if ((state = kmalloc(sizeof(struct stv0299_state), GFP_KERNEL)) == NULL) {
 		return -ENOMEM;
 	}
 
-	*data = state;
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
 	state->tuner_type = tuner_type;
 	state->tuner_frequency = 0;
 	state->initialised = 0;
-	return dvb_register_frontend (uni0299_ioctl, i2c, (void *) state,
-			       &uni0299_info);
+	state->i2c = adapter;
+	
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = (0x68>>1);
+	i2c_set_clientdata(client, (void*)state);
+	
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(state);
+		return -EFAULT;
+	}
+	
+	BUG_ON(!state->dvb);
+
+	ret = dvb_register_frontend(uni0299_ioctl, state->dvb, state,
+					&uni0299_info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
+		return -EFAULT;
 }
 
+	return 0;
+}
 
-static void uni0299_detach (struct dvb_i2c_bus *i2c, void *data)
+static int detach_client(struct i2c_client *client)
 {
+	struct stv0299_state *state = (struct stv0299_state*)i2c_get_clientdata(client);
+
+	dvb_unregister_frontend_new (uni0299_ioctl, state->dvb);
+	i2c_detach_client(client);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
+
+static int command (struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct stv0299_state *data = (struct stv0299_state*)i2c_get_clientdata(client);
 	dprintk ("%s\n", __FUNCTION__);
-	kfree(data);
-	dvb_unregister_frontend (uni0299_ioctl, i2c);
+
+	switch (cmd) {
+	case FE_REGISTER: {
+		data->dvb = (struct dvb_adapter*)arg;
+		break;
+	}
+	case FE_UNREGISTER: {
+		data->dvb = NULL;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_STV0299,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client 	= detach_client,
+	.command 	= command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
 
 static int __init init_uni0299 (void)
 {
-	dprintk ("%s\n", __FUNCTION__);
-	return dvb_register_i2c_device (NULL, uni0299_attach, uni0299_detach);
+	return i2c_add_driver(&driver);
 }
 
-
 static void __exit exit_uni0299 (void)
 {
-	dprintk ("%s\n", __FUNCTION__);
-
-	dvb_unregister_i2c_device (uni0299_attach);
+	if (i2c_del_driver(&driver))
+		printk("stv0299: driver deregistration failed\n");
 }
 
 module_init (init_uni0299);
 module_exit (exit_uni0299);
 
 MODULE_DESCRIPTION("Universal STV0299/TSA5059/SL1935 DVB Frontend driver");
-MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter, Andrew de Quincey");
+MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, "
+              "Andreas Oberritter, Andrew de Quincey, Kenneth Aafløy");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(stv0299_status, "i");
-MODULE_PARM_DESC(stv0299_status, "Which status value to support (0: BER, 1: UCBLOCKS)");
-
-MODULE_PARM(disable_typhoon, "i");
-MODULE_PARM_DESC(disable_typhoon, "Disable support for Philips SU1278 on Typhoon hardware.");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/tda1004x.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/tda1004x.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/tda1004x.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/tda1004x.c	2004-08-18 19:52:17.000000000 +0200
@@ -22,36 +22,37 @@
 
 /*
     This driver needs a copy of the DLL "ttlcdacc.dll" from the Haupauge or Technotrend
-    windows driver saved as '/usr/lib/hotplug/firmware/tda1004x.bin'.
-    You can also pass the complete file name with the module parameter 'tda1004x_firmware'.
+	windows driver.
 
     Currently the DLL from v2.15a of the technotrend driver is supported. Other versions can
     be added reasonably painlessly.
 
     Windows driver URL: http://www.technotrend.de/
- */
 
+	wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
+	unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
+*/
+#define TDA1004X_DEFAULT_FIRMWARE "tda1004x.bin"
 
-#include <linux/kernel.h>
-#include <linux/vmalloc.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/fcntl.h>
-#include <linux/errno.h>
-#include <linux/syscalls.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-#ifndef DVB_TDA1004X_FIRMWARE_FILE
-#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.bin"
-#endif
+#define FRONTEND_NAME "dvbfe_tda1004x"
+
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
 
-static int tda1004x_debug = 0;
-static char *tda1004x_firmware = DVB_TDA1004X_FIRMWARE_FILE;
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
 #define MC44BC374_ADDRESS        0x65
 
@@ -139,8 +140,6 @@
 #define TUNER_TYPE_TD1344     0
 #define TUNER_TYPE_TD1316     1
 
-#define dprintk if (tda1004x_debug) printk
-
 static struct dvb_frontend_info tda10045h_info = {
 	.name = "Philips TDA10045H",
 	.type = FE_OFDM,
@@ -171,12 +169,17 @@
 struct tda1004x_state {
 	u8 tda1004x_address;
 	u8 tuner_address;
-	u8 initialised:1;
-        u8 tuner_type:2;
-        u8 fe_type:2;
+	u8 initialised;
+	u8 tuner_type;
+	u8 fe_type;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+
+	int dspCodeCounterReg;
+	int dspCodeInReg;
+	int dspVersion;
 };
 
-
 struct fwinfo {
 	int file_size;
 	int fw_offset;
@@ -182,16 +185,28 @@
 	int fw_offset;
 	int fw_size;
 };
-static struct fwinfo tda10045h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x34cc5,.fw_size = 30555} };
-static int tda10045h_fwinfo_count = sizeof(tda10045h_fwinfo) / sizeof(struct fwinfo);
 
-static struct fwinfo tda10046h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x3c4f9,.fw_size = 24479} };
-static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
+static struct fwinfo tda10045h_fwinfo[] = {
+	{
+		.file_size = 286720,
+		.fw_offset = 0x34cc5,
+		.fw_size = 30555
+	},
+};
 
-static int errno;
+static int tda10045h_fwinfo_count = sizeof(tda10045h_fwinfo) / sizeof(struct fwinfo);
 
+static struct fwinfo tda10046h_fwinfo[] = {
+	{
+		.file_size = 286720,
+		.fw_offset = 0x3c4f9,
+		.fw_size = 24479
+	}
+};
+
+static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
 
-static int tda1004x_write_byte(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg, int data)
+static int tda1004x_write_byte(struct i2c_adapter *i2c, struct tda1004x_state *tda_state, int reg, int data)
 {
 	int ret;
 	u8 buf[] = { reg, data };
@@ -200,7 +215,7 @@
 	dprintk("%s: reg=0x%x, data=0x%x\n", __FUNCTION__, reg, data);
 
         msg.addr = tda_state->tda1004x_address;
-	ret = i2c->xfer(i2c, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 
 	if (ret != 1)
 		dprintk("%s: error reg=0x%x, data=0x%x, ret=%i\n",
@@ -211,7 +226,7 @@
 	return (ret != 1) ? -1 : 0;
 }
 
-static int tda1004x_read_byte(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg)
+static int tda1004x_read_byte(struct i2c_adapter *i2c, struct tda1004x_state *tda_state, int reg)
 {
 	int ret;
 	u8 b0[] = { reg };
@@ -223,7 +238,7 @@
 
         msg[0].addr = tda_state->tda1004x_address;
         msg[1].addr = tda_state->tda1004x_address;
-	ret = i2c->xfer(i2c, msg, 2);
+	ret = i2c_transfer(i2c, msg, 2);
 
 	if (ret != 2) {
 		dprintk("%s: error reg=0x%x, ret=%i\n", __FUNCTION__, reg,
@@ -236,7 +251,7 @@
 	return b1[0];
 }
 
-static int tda1004x_write_mask(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg, int mask, int data)
+static int tda1004x_write_mask(struct i2c_adapter *i2c, struct tda1004x_state *tda_state, int reg, int mask, int data)
 {
         int val;
 	dprintk("%s: reg=0x%x, mask=0x%x, data=0x%x\n", __FUNCTION__, reg,
@@ -255,7 +270,7 @@
 	return tda1004x_write_byte(i2c, tda_state, reg, val);
 }
 
-static int tda1004x_write_buf(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg, unsigned char *buf, int len)
+static int tda1004x_write_buf(struct i2c_adapter *i2c, struct tda1004x_state *tda_state, int reg, unsigned char *buf, int len)
 {
 	int i;
 	int result;
@@ -272,19 +287,18 @@
 	return result;
 }
 
-static int tda1004x_enable_tuner_i2c(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+static int tda1004x_enable_tuner_i2c(struct i2c_adapter *i2c, struct tda1004x_state *tda_state)
 {
         int result;
 	dprintk("%s\n", __FUNCTION__);
 
 	result = tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 2, 2);
-	dvb_delay(1);
+	msleep(1);
 	return result;
 }
 
-static int tda1004x_disable_tuner_i2c(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+static int tda1004x_disable_tuner_i2c(struct i2c_adapter *i2c, struct tda1004x_state *tda_state)
 {
-
 	dprintk("%s\n", __FUNCTION__);
 
 	return tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 2, 0);
@@ -290,8 +304,7 @@
 	return tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 2, 0);
 }
 
-
-static int tda10045h_set_bandwidth(struct dvb_i2c_bus *i2c,
+static int tda10045h_set_bandwidth(struct i2c_adapter *i2c,
 	                           struct tda1004x_state *tda_state,
 		                   fe_bandwidth_t bandwidth)
 {
@@ -321,12 +334,10 @@
 
         tda1004x_write_byte(i2c, tda_state, TDA10045H_IOFFSET, 0);
 
-        // done
         return 0;
 }
 
-
-static int tda10046h_set_bandwidth(struct dvb_i2c_bus *i2c,
+static int tda10046h_set_bandwidth(struct i2c_adapter *i2c,
                                    struct tda1004x_state *tda_state,
                                    fe_bandwidth_t bandwidth)
 {
@@ -354,187 +365,160 @@
                 return -EINVAL;
         }
 
-        // done
         return 0;
 }
 
-
-static int tda1004x_fwupload(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+static int tda1004x_do_upload(struct i2c_adapter *i2c, struct tda1004x_state *state, unsigned char *mem, unsigned int len)
 {
-	u8 fw_buf[65];
-	struct i2c_msg fw_msg = {.addr = 0,.flags = 0,.buf = fw_buf,.len = 0 };
-	unsigned char *firmware = NULL;
-	int filesize;
-	int fd;
-	int fwinfo_idx;
-	int fw_size = 0;
-        int fw_pos, fw_offset;
+	u8 buf[65];
+	struct i2c_msg fw_msg = {.addr = 0,.flags = 0,.buf = buf,.len = 0 };
 	int tx_size;
-	mm_segment_t fs = get_fs();
-        int dspCodeCounterReg=0, dspCodeInReg=0, dspVersion=0;
-        int fwInfoCount=0;
-        struct fwinfo* fwInfo = NULL;
-        unsigned long timeout;
+	int pos = 0;
 
-        // DSP parameters
-        switch(tda_state->fe_type) {
-        case FE_TYPE_TDA10045H:
-                dspCodeCounterReg = TDA10045H_FWPAGE;
-                dspCodeInReg = TDA10045H_CODE_IN;
-                dspVersion = 0x2c;
-                fwInfoCount = tda10045h_fwinfo_count;
-                fwInfo = tda10045h_fwinfo;
-                break;
+	/* clear code counter */
+	tda1004x_write_byte(i2c, state, state->dspCodeCounterReg, 0);
+	fw_msg.addr = state->tda1004x_address;
 
-        case FE_TYPE_TDA10046H:
-                dspCodeCounterReg = TDA10046H_CODE_CPT;
-                dspCodeInReg = TDA10046H_CODE_IN;
-                dspVersion = 0x20;
-                fwInfoCount = tda10046h_fwinfo_count;
-                fwInfo = tda10046h_fwinfo;
-                break;
+	buf[0] = state->dspCodeInReg;
+	while (pos != len) {
+
+		// work out how much to send this time
+		tx_size = len - pos;
+		if (tx_size > 0x10) {
+			tx_size = 0x10;
         }
 
-	// Load the firmware
-	set_fs(get_ds());
-	fd = sys_open(tda1004x_firmware, 0, 0);
-	if (fd < 0) {
-		printk("%s: Unable to open firmware %s\n", __FUNCTION__,
-		       tda1004x_firmware);
+		// send the chunk
+		memcpy(buf + 1, mem + pos, tx_size);
+		fw_msg.len = tx_size + 1;
+		if (i2c_transfer(i2c, &fw_msg, 1) != 1) {
+			printk("tda1004x: Error during firmware upload\n");
 		return -EIO;
 	}
-	filesize = sys_lseek(fd, 0L, 2);
-	if (filesize <= 0) {
-		printk("%s: Firmware %s is empty\n", __FUNCTION__,
-		       tda1004x_firmware);
-		sys_close(fd);
-		return -EIO;
+		pos += tx_size;
+
+		dprintk("%s: fw_pos=0x%x\n", __FUNCTION__, pos);
+	}
+	return 0;
 	}
 
-        // find extraction parameters for firmware
+static int tda1004x_find_extraction_params(struct fwinfo* fwInfo, int fwInfoCount, int size)
+{
+	int fwinfo_idx;
+
         for (fwinfo_idx = 0; fwinfo_idx < fwInfoCount; fwinfo_idx++) {
-                if (fwInfo[fwinfo_idx].file_size == filesize)
+		if (fwInfo[fwinfo_idx].file_size == size)
 			break;
 	}
         if (fwinfo_idx >= fwInfoCount) {
-		printk("%s: Unsupported firmware %s\n", __FUNCTION__, tda1004x_firmware);
-		sys_close(fd);
+		printk("tda1004x: Unsupported firmware uploaded.\n");
 		return -EIO;
 	}
-        fw_size = fwInfo[fwinfo_idx].fw_size;
-        fw_offset = fwInfo[fwinfo_idx].fw_offset;
 
-	// allocate buffer for it
-	firmware = vmalloc(fw_size);
-	if (firmware == NULL) {
-		printk("%s: Out of memory loading firmware\n",
-		       __FUNCTION__);
-		sys_close(fd);
-		return -EIO;
+	return fwinfo_idx;
 	}
 
-	// read it!
-	sys_lseek(fd, fw_offset, 0);
-	if (sys_read(fd, firmware, fw_size) != fw_size) {
-		printk("%s: Failed to read firmware\n", __FUNCTION__);
-		vfree(firmware);
-		sys_close(fd);
-		return -EIO;
-	}
-	sys_close(fd);
-	set_fs(fs);
+static int tda1004x_check_upload_ok(struct i2c_adapter *i2c, struct tda1004x_state *state)
+{
+	u8 data1, data2;
 
-        // set some valid bandwith parameters before uploading
-        switch(tda_state->fe_type) {
-        case FE_TYPE_TDA10045H:
-                // reset chip
-		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x10, 0);
-                tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
-                tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
-                dvb_delay(10);
+	// check upload was OK
+	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 0x10, 0); // we want to read from the DSP
+	tda1004x_write_byte(i2c, state, TDA1004X_DSP_CMD, 0x67);
 
-                // set parameters
-                tda10045h_set_bandwidth(i2c, tda_state, BANDWIDTH_8_MHZ);
-                break;
+	data1 = tda1004x_read_byte(i2c, state, TDA1004X_DSP_DATA1);
+	data2 = tda1004x_read_byte(i2c, state, TDA1004X_DSP_DATA2);
+	if (data1 != 0x67 || data2 != state->dspVersion) {
+		printk("tda1004x: firmware upload failed!\n");
+		return -EIO;
+	}
 
-        case FE_TYPE_TDA10046H:
-                // reset chip
-		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 1, 0);
-                tda1004x_write_mask(i2c, tda_state, TDA10046H_CONF_TRISTATE1, 1, 0);
-                dvb_delay(10);
-
-                // set parameters
-                tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL2, 10);
-                tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL3, 0);
-                tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_OFFSET, 99);
-                tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
-                tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
-                tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
-                break;
+	return 0;
         }
 
-	// do the firmware upload
-        tda1004x_write_byte(i2c, tda_state, dspCodeCounterReg, 0); // clear code counter
-        fw_msg.addr = tda_state->tda1004x_address;
-	fw_pos = 0;
-	while (fw_pos != fw_size) {
 
-		// work out how much to send this time
-		tx_size = fw_size - fw_pos;
-                if (tx_size > 0x10) {
-                        tx_size = 0x10;
-		}
+static int tda10045_fwupload(struct i2c_adapter *i2c, struct tda1004x_state *state, const struct firmware *fw)
+{
+	int index;
+	int ret;
 
-		// send the chunk
-                fw_buf[0] = dspCodeInReg;
-		memcpy(fw_buf + 1, firmware + fw_pos, tx_size);
-		fw_msg.len = tx_size + 1;
-		if (i2c->xfer(i2c, &fw_msg, 1) != 1) {
-                        printk("tda1004x: Error during firmware upload\n");
-			vfree(firmware);
-			return -EIO;
-		}
-		fw_pos += tx_size;
+	index = tda1004x_find_extraction_params(tda10045h_fwinfo, tda10045h_fwinfo_count, fw->size);
+	if (index < 0)
+		return index;
+
+	/* set some valid bandwith parameters before uploading */
+
+	/* reset chip */
+	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 0x10, 0);
+	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 8, 8);
+	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 8, 0);
+	msleep(10);
+
+	/* set parameters */
+	tda10045h_set_bandwidth(i2c, state, BANDWIDTH_8_MHZ);
+
+	ret = tda1004x_do_upload(i2c, state, fw->data + tda10045h_fwinfo[index].fw_offset, tda10045h_fwinfo[index].fw_size);
+	if (ret)
+		return ret;
+
+	/* wait for DSP to initialise */
+	/* DSPREADY doesn't seem to work on the TDA10045H */
+	msleep(100);
+
+	ret = tda1004x_check_upload_ok(i2c, state);
+	if (ret)
+		return ret;
 
-		dprintk("%s: fw_pos=0x%x\n", __FUNCTION__, fw_pos);
+	return 0;
 	}
-	vfree(firmware);
 
-        // wait for DSP to initialise
-        switch(tda_state->fe_type) {
-        case FE_TYPE_TDA10045H:
-                // DSPREADY doesn't seem to work on the TDA10045H
-                dvb_delay(100);
-                break;
+static int tda10046_fwupload(struct i2c_adapter *i2c, struct tda1004x_state *state, const struct firmware *fw)
+{
+	unsigned long timeout;
+	int index;
+	int ret;
 
-        case FE_TYPE_TDA10046H:
+	index = tda1004x_find_extraction_params(tda10046h_fwinfo, tda10046h_fwinfo_count, fw->size);
+	if (index < 0)
+		return index;
+
+	/* set some valid bandwith parameters before uploading */
+
+	/* reset chip */
+	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 1, 0);
+	tda1004x_write_mask(i2c, state, TDA10046H_CONF_TRISTATE1, 1, 0);
+	msleep(10);
+
+	/* set parameters */
+	tda1004x_write_byte(i2c, state, TDA10046H_CONFPLL2, 10);
+	tda1004x_write_byte(i2c, state, TDA10046H_CONFPLL3, 0);
+	tda1004x_write_byte(i2c, state, TDA10046H_FREQ_OFFSET, 99);
+	tda1004x_write_byte(i2c, state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
+	tda1004x_write_byte(i2c, state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
+	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
+
+	ret = tda1004x_do_upload(i2c, state, fw->data + tda10046h_fwinfo[index].fw_offset, tda10046h_fwinfo[index].fw_size);
+	if (ret)
+		return ret;
+
+	/* wait for DSP to initialise */
                 timeout = jiffies + HZ;
-                while(!(tda1004x_read_byte(i2c, tda_state, TDA1004X_STATUS_CD) & 0x20)) {
+	while(!(tda1004x_read_byte(i2c, state, TDA1004X_STATUS_CD) & 0x20)) {
                         if (time_after(jiffies, timeout)) {
                                 printk("tda1004x: DSP failed to initialised.\n");
                                 return -EIO;
                         }
-
-                        dvb_delay(1);
-                }
-                break;
+		msleep(1);
         }
 
-        // check upload was OK
-        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x10, 0); // we want to read from the DSP
-	tda1004x_write_byte(i2c, tda_state, TDA1004X_DSP_CMD, 0x67);
-	if ((tda1004x_read_byte(i2c, tda_state, TDA1004X_DSP_DATA1) != 0x67) ||
-            (tda1004x_read_byte(i2c, tda_state, TDA1004X_DSP_DATA2) != dspVersion)) {
-		printk("%s: firmware upload failed!\n", __FUNCTION__);
-		return -EIO;
-	}
+	ret = tda1004x_check_upload_ok(i2c, state);
+	if (ret)
+		return ret;
 
-        // success
         return 0;
 }
 
-
-static int tda10045h_init(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+static int tda10045h_init(struct i2c_adapter *i2c, struct tda1004x_state *tda_state)
 {
         struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = NULL,.len = 0 };
         static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
@@ -548,8 +532,8 @@
         tuner_msg.addr = MC44BC374_ADDRESS;
         tuner_msg.buf = disable_mc44BC374c;
         tuner_msg.len = sizeof(disable_mc44BC374c);
-        if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
-                i2c->xfer(i2c, &tuner_msg, 1);
+	if (i2c_transfer(i2c, &tuner_msg, 1) != 1) {
+		i2c_transfer(i2c, &tuner_msg, 1);
         }
         tda1004x_disable_tuner_i2c(i2c, tda_state);
 
@@ -566,13 +550,10 @@
         tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x10, 0); // VAGC polarity
         tda1004x_write_byte(i2c, tda_state, TDA1004X_CONFADC1, 0x2e);
 
-	// done
 	return 0;
 }
 
-
-
-static int tda10046h_init(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+static int tda10046h_init(struct i2c_adapter *i2c, struct tda1004x_state *tda_state)
 {
         struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = NULL,.len = 0 };
         static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
@@ -586,8 +567,8 @@
         tuner_msg.addr = MC44BC374_ADDRESS;
         tuner_msg.buf = disable_mc44BC374c;
         tuner_msg.len = sizeof(disable_mc44BC374c);
-        if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
-                i2c->xfer(i2c, &tuner_msg, 1);
+	if (i2c_transfer(i2c, &tuner_msg, 1) != 1) {
+		i2c_transfer(i2c, &tuner_msg, 1);
         }
         tda1004x_disable_tuner_i2c(i2c, tda_state);
 
@@ -618,7 +599,6 @@
         tda1004x_write_mask(i2c, tda_state, TDA10046H_GPIO_SELECT, 8, 8); // GPIO select
         tda10046h_set_bandwidth(i2c, tda_state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
 
-        // done
         return 0;
 }
 
@@ -664,7 +642,7 @@
 	return -1;
 }
 
-static int tda1004x_set_frequency(struct dvb_i2c_bus *i2c,
+static int tda1004x_set_frequency(struct i2c_adapter *i2c,
 			   struct tda1004x_state *tda_state,
 			   struct dvb_frontend_parameters *fe_params)
 {
@@ -697,7 +675,7 @@
 		tda1004x_enable_tuner_i2c(i2c, tda_state);
 		tuner_msg.addr = tda_state->tuner_address;
 		tuner_msg.len = 4;
-		i2c->xfer(i2c, &tuner_msg, 1);
+		i2c_transfer(i2c, &tuner_msg, 1);
 
 		// wait for it to finish
 		tuner_msg.len = 1;
@@ -705,7 +683,7 @@
 		counter = 0;
 		counter2 = 0;
 		while (counter++ < 100) {
-			if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
+			if (i2c_transfer(i2c, &tuner_msg, 1) == 1) {
 				if (tuner_buf[0] & 0x40) {
 					counter2++;
 				} else {
@@ -802,10 +780,10 @@
 		tda1004x_enable_tuner_i2c(i2c, tda_state);
 		tuner_msg.addr = tda_state->tuner_address;
 		tuner_msg.len = 4;
-                if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
+		if (i2c_transfer(i2c, &tuner_msg, 1) != 1) {
 			return -EIO;
 		}
-		dvb_delay(1);
+		msleep(1);
 		tda1004x_disable_tuner_i2c(i2c, tda_state);
                 if (tda_state->fe_type == FE_TYPE_TDA10046H)
                         tda1004x_write_mask(i2c, tda_state, TDA10046H_AGC_CONF, 4, 4);
@@ -817,11 +795,10 @@
 
 	dprintk("%s: success\n", __FUNCTION__);
 
-	// done
 	return 0;
 }
 
-static int tda1004x_set_fe(struct dvb_i2c_bus *i2c,
+static int tda1004x_set_fe(struct i2c_adapter *i2c,
 	 	           struct tda1004x_state *tda_state,
 		           struct dvb_frontend_parameters *fe_params)
 {
@@ -857,11 +834,9 @@
 		tda1004x_write_mask(i2c, tda_state, TDA1004X_IN_CONF2, 7, tmp);
 
 		// set LP FEC
-		if (fe_params->u.ofdm.code_rate_LP != FEC_NONE) {
 			tmp = tda1004x_encode_fec(fe_params->u.ofdm.code_rate_LP);
 			if (tmp < 0) return tmp;
 			tda1004x_write_mask(i2c, tda_state, TDA1004X_IN_CONF2, 0x38, tmp << 3);
-		}
 
 		// set constellation
 		switch (fe_params->u.ofdm.constellation) {
@@ -992,23 +967,20 @@
         case FE_TYPE_TDA10045H:
 	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
 	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
-	dvb_delay(10);
+		msleep(10);
                 break;
 
         case FE_TYPE_TDA10046H:
                 tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x40, 0x40);
-                dvb_delay(10);
+		msleep(10);
                 break;
         }
 
-	// done
 	return 0;
 }
 
-
-static int tda1004x_get_fe(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, struct dvb_frontend_parameters *fe_params)
+static int tda1004x_get_fe(struct i2c_adapter *i2c, struct tda1004x_state* tda_state, struct dvb_frontend_parameters *fe_params)
 {
-
 	dprintk("%s\n", __FUNCTION__);
 
 	// inversion status
@@ -1110,12 +1082,10 @@
 		break;
 	}
 
-	// done
 	return 0;
 }
 
-
-static int tda1004x_read_status(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, fe_status_t * fe_status)
+static int tda1004x_read_status(struct i2c_adapter *i2c, struct tda1004x_state* tda_state, fe_status_t * fe_status)
 {
 	int status;
         int cber;
@@ -1177,7 +1147,7 @@
 	return 0;
 }
 
-static int tda1004x_read_signal_strength(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, u16 * signal)
+static int tda1004x_read_signal_strength(struct i2c_adapter *i2c, struct tda1004x_state* tda_state, u16 * signal)
 {
 	int tmp;
         int reg = 0;
@@ -1200,14 +1170,12 @@
 	if (tmp < 0)
 		return -EIO;
 
-	// done
 	*signal = (tmp << 8) | tmp;
 	dprintk("%s: signal=0x%x\n", __FUNCTION__, *signal);
 	return 0;
 }
 
-
-static int tda1004x_read_snr(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, u16 * snr)
+static int tda1004x_read_snr(struct i2c_adapter *i2c, struct tda1004x_state* tda_state, u16 * snr)
 {
 	int tmp;
 
@@ -1221,13 +1189,12 @@
                 tmp = 255 - tmp;
         }
 
-        // done
 	*snr = ((tmp << 8) | tmp);
 	dprintk("%s: snr=0x%x\n", __FUNCTION__, *snr);
 	return 0;
 }
 
-static int tda1004x_read_ucblocks(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, u32* ucblocks)
+static int tda1004x_read_ucblocks(struct i2c_adapter *i2c, struct tda1004x_state* tda_state, u32* ucblocks)
 {
 	int tmp;
 	int tmp2;
@@ -1254,7 +1221,6 @@
 			break;
 	}
 
-	// done
 	if (tmp != 0x7f) {
 		*ucblocks = tmp;
 	} else {
@@ -1264,7 +1230,7 @@
 	return 0;
 }
 
-static int tda1004x_read_ber(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, u32* ber)
+static int tda1004x_read_ber(struct i2c_adapter *i2c, struct tda1004x_state* tda_state, u32* ber)
 {
         int tmp;
 
@@ -1279,12 +1245,11 @@
         *ber |= (tmp << 9);
         tda1004x_read_byte(i2c, tda_state, TDA1004X_CBER_RESET);
 
-	// done
 	dprintk("%s: ber=0x%x\n", __FUNCTION__, *ber);
 	return 0;
 }
 
-static int tda1004x_sleep(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state)
+static int tda1004x_sleep(struct i2c_adapter *i2c, struct tda1004x_state* tda_state)
 {
 	switch(tda_state->fe_type) {
 	case FE_TYPE_TDA10045H:
@@ -1299,12 +1264,11 @@
 	return 0;
 }
 
-
 static int tda1004x_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	int status = 0;
-	struct dvb_i2c_bus *i2c = fe->i2c;
 	struct tda1004x_state *tda_state = (struct tda1004x_state *) fe->data;
+	struct i2c_adapter *i2c = tda_state->i2c;
+	int status = 0;
 
 	dprintk("%s: cmd=0x%x\n", __FUNCTION__, cmd);
 
@@ -1382,27 +1346,23 @@
 	return 0;
 }
 
-
-static int tda1004x_attach(struct dvb_i2c_bus *i2c, void **data)
+static int tda1004x_attach(struct i2c_adapter *i2c, struct tda1004x_state* state)
 {
         int tda1004x_address = -1;
 	int tuner_address = -1;
         int fe_type = -1;
         int tuner_type = -1;
-	struct tda1004x_state tda_state;
-	struct tda1004x_state* ptda_state;
 	struct i2c_msg tuner_msg = {.addr=0, .flags=0, .buf=NULL, .len=0 };
         static u8 td1344_init[] = { 0x0b, 0xf5, 0x88, 0xab };
         static u8 td1316_init[] = { 0x0b, 0xf5, 0x85, 0xab };
         static u8 td1316_init_tda10046h[] = { 0x0b, 0xf5, 0x80, 0xab };
-        int status;
 
 	dprintk("%s\n", __FUNCTION__);
 
         // probe for tda10045h
         if (tda1004x_address == -1) {
-                tda_state.tda1004x_address = 0x08;
-	if (tda1004x_read_byte(i2c, &tda_state, TDA1004X_CHIPID) == 0x25) {
+		state->tda1004x_address = 0x08;
+		if (tda1004x_read_byte(i2c, state, TDA1004X_CHIPID) == 0x25) {
                         tda1004x_address = 0x08;
                         fe_type = FE_TYPE_TDA10045H;
                 printk("tda1004x: Detected Philips TDA10045H.\n");
@@ -1411,8 +1371,8 @@
 
         // probe for tda10046h
         if (tda1004x_address == -1) {
-                tda_state.tda1004x_address = 0x08;
-                if (tda1004x_read_byte(i2c, &tda_state, TDA1004X_CHIPID) == 0x46) {
+		state->tda1004x_address = 0x08;
+		if (tda1004x_read_byte(i2c, state, TDA1004X_CHIPID) == 0x46) {
                         tda1004x_address = 0x08;
                         fe_type = FE_TYPE_TDA10046H;
                         printk("tda1004x: Detected Philips TDA10046H.\n");
@@ -1425,15 +1385,15 @@
         }
 
         // enable access to the tuner
-	tda1004x_enable_tuner_i2c(i2c, &tda_state);
+	tda1004x_enable_tuner_i2c(i2c, state);
 
         // check for a TD1344 first
         if (tuner_address == -1) {
                 tuner_msg.addr = 0x61;
 	tuner_msg.buf = td1344_init;
 	tuner_msg.len = sizeof(td1344_init);
-	if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
-                dvb_delay(1);
+		if (i2c_transfer(i2c, &tuner_msg, 1) == 1) {
+			msleep(1);
                         tuner_address = 0x61;
                         tuner_type = TUNER_TYPE_TD1344;
                         printk("tda1004x: Detected Philips TD1344 tuner.\n");
@@ -1445,8 +1405,8 @@
                 tuner_msg.addr = 0x63;
                 tuner_msg.buf = td1316_init;
                 tuner_msg.len = sizeof(td1316_init);
-                if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
-                        dvb_delay(1);
+		if (i2c_transfer(i2c, &tuner_msg, 1) == 1) {
+			msleep(1);
                         tuner_address = 0x63;
                         tuner_type = TUNER_TYPE_TD1316;
                         printk("tda1004x: Detected Philips TD1316 tuner.\n");
@@ -1458,14 +1418,14 @@
                 tuner_msg.addr = 0x60;
                 tuner_msg.buf = td1316_init_tda10046h;
                 tuner_msg.len = sizeof(td1316_init_tda10046h);
-                if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
-                        dvb_delay(1);
+		if (i2c_transfer(i2c, &tuner_msg, 1) == 1) {
+			msleep(1);
                         tuner_address = 0x60;
                         tuner_type = TUNER_TYPE_TD1316;
                         printk("tda1004x: Detected Philips TD1316 tuner.\n");
 		}
 	}
-	tda1004x_disable_tuner_i2c(i2c, &tda_state);
+	tda1004x_disable_tuner_i2c(i2c, state);
 
 	// did we find a tuner?
 	if (tuner_address == -1) {
@@ -1474,57 +1434,172 @@
 	}
 
         // create state
-        tda_state.tda1004x_address = tda1004x_address;
-        tda_state.fe_type = fe_type;
-	tda_state.tuner_address = tuner_address;
-        tda_state.tuner_type = tuner_type;
-	tda_state.initialised = 0;
+	state->tda1004x_address = tda1004x_address;
+	state->fe_type = fe_type;
+	state->tuner_address = tuner_address;
+	state->tuner_type = tuner_type;
+	state->initialised = 0;
 
-        // upload firmware
-        if ((status = tda1004x_fwupload(i2c, &tda_state)) != 0) return status;
+	return 0;
+}
+
+static struct i2c_client client_template;
 
-	// create the real state we'll be passing about
-	if ((ptda_state = (struct tda1004x_state*) kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL)) == NULL) {
+static int attach_adapter(struct i2c_adapter *adapter)
+{
+	struct i2c_client *client;
+	struct tda1004x_state *state;
+	const struct firmware *fw;
+	int ret;
+
+	dprintk ("%s\n", __FUNCTION__);
+
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
-	memcpy(ptda_state, &tda_state, sizeof(struct tda1004x_state));
-	*data = ptda_state;
 
-	// register
-        switch(tda_state.fe_type) {
+	if (NULL == (state = kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL))) {
+		kfree(client);
+		return -ENOMEM;
+	}
+	state->i2c = adapter;
+
+	ret = tda1004x_attach(adapter, state);
+	if (ret) {
+		kfree(state);
+		kfree(client);
+		return -ENODEV;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = state->tda1004x_address;
+	i2c_set_clientdata(client, (void*)state);
+
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(state);
+		return ret;
+	}
+
+	// upload firmware
+	BUG_ON(!state->dvb);
+
+	/* request the firmware, this will block until someone uploads it */
+	printk("tda1004x: waiting for firmware upload...\n");
+	ret = request_firmware(&fw, TDA1004X_DEFAULT_FIRMWARE, &client->dev);
+	if (ret) {
+		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
+		goto out;
+	}
+
+	switch(state->fe_type) {
         case FE_TYPE_TDA10045H:
-		return dvb_register_frontend(tda1004x_ioctl, i2c, ptda_state, &tda10045h_info);
+		state->dspCodeCounterReg = TDA10045H_FWPAGE;
+		state->dspCodeInReg =  TDA10045H_CODE_IN;
+		state->dspVersion = 0x2c;
+
+		ret = tda10045_fwupload(adapter, state, fw);
+		if (ret) {
+			printk("tda1004x: firmware upload failed\n");
+			goto out;
+		}
 
+		ret = dvb_register_frontend(tda1004x_ioctl, state->dvb,
+						state, &tda10045h_info,
+						THIS_MODULE);
+		break;
         case FE_TYPE_TDA10046H:
-		return dvb_register_frontend(tda1004x_ioctl, i2c, ptda_state, &tda10046h_info);
+		state->dspCodeCounterReg = TDA10046H_CODE_CPT;
+		state->dspCodeInReg =  TDA10046H_CODE_IN;
+		state->dspVersion = 0x20;
+
+		ret = tda10046_fwupload(adapter, state, fw);
+		if (ret) {
+			printk("tda1004x: firmware upload failed\n");
+			goto out;
         }
 
-        // should not get here
-        return -EINVAL;
+		ret = dvb_register_frontend(tda1004x_ioctl, state->dvb,
+						state, &tda10046h_info,
+						THIS_MODULE);
+		break;
+	default:
+		BUG_ON(1);
 }
 
+	if (ret) {
+		printk("tda1004x: registering frontend failed\n");
+		goto out;
+	}
 
-static
-void tda1004x_detach(struct dvb_i2c_bus *i2c, void *data)
+	return 0;
+out:
+	i2c_detach_client(client);
+	kfree(client);
+	kfree(state);
+	return ret;
+}
+
+static int detach_client(struct i2c_client *client)
 {
+	struct tda1004x_state *state = (struct tda1004x_state*)i2c_get_clientdata(client);
+
 	dprintk("%s\n", __FUNCTION__);
 
-	kfree(data);
-	dvb_unregister_frontend(tda1004x_ioctl, i2c);
+	dvb_unregister_frontend_new (tda1004x_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
 }
 
-
-static
-int __init init_tda1004x(void)
+static int command (struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	return dvb_register_i2c_device(THIS_MODULE, tda1004x_attach, tda1004x_detach);
+	struct tda1004x_state *state = (struct tda1004x_state*)i2c_get_clientdata(client);
+
+	dprintk ("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+	case FE_REGISTER:
+		state->dvb = (struct dvb_adapter*)arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_TDA1004X,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client 	= detach_client,
+	.command 	= command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
 
-static
-void __exit exit_tda1004x(void)
+static int __init init_tda1004x(void)
 {
-	dvb_unregister_i2c_device(tda1004x_attach);
+	return i2c_add_driver(&driver);
+}
+
+static void __exit exit_tda1004x(void)
+{
+	if (i2c_del_driver(&driver))
+		printk("tda1004x: driver deregistration failed\n");
 }
 
 module_init(init_tda1004x);
@@ -1534,8 +1609,3 @@
 MODULE_AUTHOR("Andrew de Quincey & Robert Schlabbach");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(tda1004x_debug, "i");
-MODULE_PARM_DESC(tda1004x_debug, "enable verbose debug messages");
-
-MODULE_PARM(tda1004x_firmware, "s");
-MODULE_PARM_DESC(tda1004x_firmware, "Where to find the firmware file");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/ves1820.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1820.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/ves1820.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1820.c	2004-08-18 19:52:18.000000000 +0200
@@ -29,56 +29,27 @@
 #include <linux/slab.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
+/* I2C_DRIVERID_VES1820 is already defined in i2c-id.h */
 
 #if 0
-#define dprintk(x...) printk(x)
-#else
-#define dprintk(x...)
+static int debug = 0;
+#define dprintk	if (debug) printk
 #endif
 
-#define MAX_UNITS 4
-static int pwm[MAX_UNITS] = { -1, -1, -1, -1 };
 static int verbose;
 
-/**
- *  since we need only a few bits to store internal state we don't allocate
- *  extra memory but use frontend->data as bitfield
- */
+struct ves1820_state {
+	int pwm;
+	u8 reg0;
+	int tuner;
+	u8 demod_addr;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
 
-#define SET_PWM(data,pwm) do { 		\
-	long d = (long)data;		\
-	d &= ~0xff; 			\
-	d |= pwm; 			\
-	data = (void *)d;		\
-} while (0)
-
-#define SET_REG0(data,reg0) do {	\
-	long d = (long)data;		\
-	d &= ~(0xff << 8); 		\
-	d |= reg0 << 8; 		\
-	data = (void *)d;		\
-} while (0)
-
-#define SET_TUNER(data,type) do {	\
-	long d = (long)data;		\
-	d &= ~(0xff << 16); 		\
-	d |= type << 16;		\
-	data = (void *)d;		\
-} while (0)
-
-#define SET_DEMOD_ADDR(data,type) do {	\
-	long d = (long)data;		\
-	d &= ~(0xff << 24); 		\
-	d |= type << 24;		\
-	data = (void *)d;		\
-} while (0)
-
-#define GET_PWM(data) ((u8) ((long) data & 0xff))
-#define GET_REG0(data) ((u8) (((long) data >> 8) & 0xff))
-#define GET_TUNER(data) ((u8) (((long) data >> 16) & 0xff))
-#define GET_DEMOD_ADDR(data) ((u8) (((long) data >> 24) & 0xff))
+/* possible ves1820 adresses */
+static u8 addr[] = { 0x61, 0x62 };
 
 #if defined(CONFIG_DBOX2)
 #define XIN 69600000UL
@@ -109,15 +78,16 @@
 	.symbol_rate_tolerance = ???,  /* ppm */  /* == 8% (spec p. 5) */
 	.notifier_delay = ?,
 #endif
-	.caps = FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 |
-		FE_CAN_QAM_128 | FE_CAN_QAM_256 | 
-		FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO,
+	.caps = FE_CAN_QAM_16 |
+		FE_CAN_QAM_32 |
+		FE_CAN_QAM_64 |
+		FE_CAN_QAM_128 |
+		FE_CAN_QAM_256 |
+		FE_CAN_FEC_AUTO |
+		FE_CAN_INVERSION_AUTO,
 };
 
-
-
-static u8 ves1820_inittab [] =
-{
+static u8 ves1820_inittab[] = {
 	0x69, 0x6A, 0x9B, 0x12, 0x12, 0x46, 0x26, 0x1A,
 	0x43, 0x6A, 0xAA, 0xAA, 0x1E, 0x85, 0x43, 0x20,
 	0xE0, 0x00, 0xA1, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -127,57 +97,50 @@
 	0x00, 0x00, 0x00, 0x00, 0x40
 };
 
-
-static int ves1820_writereg (struct dvb_frontend *fe, u8 reg, u8 data)
+static int ves1820_writereg(struct ves1820_state *state, u8 reg, u8 data)
 {
-	u8 addr = GET_DEMOD_ADDR(fe->data);
         u8 buf[] = { 0x00, reg, data };
-	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = 3 };
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct i2c_msg msg = {.addr = state->demod_addr,.flags = 0,.buf = buf,.len = 3 };
         int ret;
 
-	ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer(state->i2c, &msg, 1);
 
 	if (ret != 1)
-		printk("DVB: VES1820(%d): %s, writereg error "
-			"(reg == 0x%02x, val == 0x%02x, ret == %i)\n",
-			fe->i2c->adapter->num, __FUNCTION__, reg, data, ret);
+		printk("ves1820: %s(): writereg error (reg == 0x%02x,"
+			"val == 0x%02x, ret == %i)\n", __FUNCTION__, reg, data, ret);
 
-	dvb_delay(10);
+	msleep(10);
 	return (ret != 1) ? -EREMOTEIO : 0;
 }
 
-
-static u8 ves1820_readreg (struct dvb_frontend *fe, u8 reg)
+static u8 ves1820_readreg(struct ves1820_state *state, u8 reg)
 {
 	u8 b0 [] = { 0x00, reg };
 	u8 b1 [] = { 0 };
-	u8 addr = GET_DEMOD_ADDR(fe->data);
-	struct i2c_msg msg [] = { { .addr = addr, .flags = 0, .buf = b0, .len = 2 },
-	                   { .addr = addr, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct i2c_msg msg[] = {
+		{.addr = state->demod_addr,.flags = 0,.buf = b0,.len = 2},
+		{.addr = state->demod_addr,.flags = I2C_M_RD,.buf = b1,.len = 1}
+	};
 	int ret;
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer(state->i2c, msg, 2);
 
 	if (ret != 2)
-		printk("DVB: VES1820(%d): %s: readreg error (ret == %i)\n",
-				fe->i2c->adapter->num, __FUNCTION__, ret);
+		printk("ves1820: %s(): readreg error (reg == 0x%02x,"
+		"ret == %i)\n", __FUNCTION__, reg, ret);
 
 	return b1[0];
 }
 
-
-static int tuner_write (struct dvb_i2c_bus *i2c, u8 addr, u8 data [4])
+static int tuner_write(struct ves1820_state *state, u8 addr, u8 data[4])
 {
         int ret;
         struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = data, .len = 4 };
 
-        ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer(state->i2c, &msg, 1);
 
         if (ret != 1)
-                printk("DVB: VES1820(%d): %s: i/o error (ret == %i)\n",
-				i2c->adapter->num, __FUNCTION__, ret);
+		printk("ves1820: %s(): i/o error (ret == %i)\n", __FUNCTION__, ret);
 
         return (ret != 1) ? -EREMOTEIO : 0;
 }
@@ -187,19 +149,18 @@
  *   set up the downconverter frequency divisor for a
  *   reference clock comparision frequency of 62.5 kHz.
  */
-static int tuner_set_tv_freq (struct dvb_frontend *fe, u32 freq)
+static int tuner_set_tv_freq(struct ves1820_state *state, u32 freq)
 {
         u32 div, ifreq;
-	static u8 addr [] = { 0x61, 0x62 };
 	static u8 byte3 [] = { 0x8e, 0x85 };
-	int tuner_type = GET_TUNER(fe->data);
+	int tuner_type = state->tuner;
         u8 buf [4];
 
 	if (tuner_type == 0xff)     /*  PLL not reachable over i2c ...  */
 		return 0;
 
-	if (strstr (fe->i2c->adapter->name, "Technotrend") ||
-	    strstr (fe->i2c->adapter->name, "TT-Budget"))
+	if (strstr(state->i2c->name, "Technotrend")
+	 || strstr(state->i2c->name, "TT-Budget"))
 		ifreq = 35937500;
 	else
 		ifreq = 36125000;
@@ -212,70 +173,62 @@
 
 	if (tuner_type == 1) {
 		buf[2] |= (div >> 10) & 0x60;
-		buf[3] = (freq < 174000000 ? 0x88 :
-			  freq < 470000000 ? 0x84 : 0x81);
+		buf[3] = (freq < 174000000 ? 0x88 : freq < 470000000 ? 0x84 : 0x81);
 	} else {
-		buf[3] = (freq < 174000000 ? 0xa1 :
-			  freq < 454000000 ? 0x92 : 0x34);
+		buf[3] = (freq < 174000000 ? 0xa1 : freq < 454000000 ? 0x92 : 0x34);
 	}
 
-        return tuner_write (fe->i2c, addr[tuner_type], buf);
+	return tuner_write(state, addr[tuner_type], buf);
 }
 
-
-static int ves1820_setup_reg0 (struct dvb_frontend *fe, u8 reg0,
-			fe_spectral_inversion_t inversion)
+static int ves1820_setup_reg0(struct ves1820_state *state, u8 reg0, fe_spectral_inversion_t inversion)
 {
-	reg0 |= GET_REG0(fe->data) & 0x62;
+	reg0 |= state->reg0 & 0x62;
 	
 	if (INVERSION_ON == inversion)
 		ENABLE_INVERSION(reg0);
 	else if (INVERSION_OFF == inversion)
 		DISABLE_INVERSION(reg0);
 	
-	ves1820_writereg (fe, 0x00, reg0 & 0xfe);
-        ves1820_writereg (fe, 0x00, reg0 | 0x01);
+	ves1820_writereg(state, 0x00, reg0 & 0xfe);
+	ves1820_writereg(state, 0x00, reg0 | 0x01);
 
 	/**
 	 *  check lock and toggle inversion bit if required...
 	 */
-	if (INVERSION_AUTO == inversion && !(ves1820_readreg (fe, 0x11) & 0x08)) {
+	if (INVERSION_AUTO == inversion && !(ves1820_readreg(state, 0x11) & 0x08)) {
 		mdelay(50);
-		if (!(ves1820_readreg (fe, 0x11) & 0x08)) {
+		if (!(ves1820_readreg(state, 0x11) & 0x08)) {
 			reg0 ^= 0x20;
-			ves1820_writereg (fe, 0x00, reg0 & 0xfe);
-        		ves1820_writereg (fe, 0x00, reg0 | 0x01);
+			ves1820_writereg(state, 0x00, reg0 & 0xfe);
+			ves1820_writereg(state, 0x00, reg0 | 0x01);
 		}
 	}
 
-	SET_REG0(fe->data, reg0);
+	state->reg0 = reg0;
 
 	return 0;
 }
 
-
-static int ves1820_init (struct dvb_frontend *fe)
+static int ves1820_init(struct ves1820_state *state)
 {
 	int i;
         
-        dprintk("DVB: VES1820(%d): init chip\n", fe->i2c->adapter->num);
-
-        ves1820_writereg (fe, 0, 0);
+	ves1820_writereg(state, 0, 0);
 
 #if defined(CONFIG_DBOX2)
 	ves1820_inittab[2] &= ~0x08;
 #endif
 
 	for (i=0; i<53; i++)
-                ves1820_writereg (fe, i, ves1820_inittab[i]);
+		ves1820_writereg(state, i, ves1820_inittab[i]);
 
-	ves1820_writereg (fe, 0x34, GET_PWM(fe->data)); 
+	ves1820_writereg(state, 0x34, state->pwm);
 
 	return 0;
 }
 
-
-static int ves1820_set_symbolrate (struct dvb_frontend *fe, u32 symbolrate)
+static int ves1820_set_symbolrate(struct ves1820_state *state, u32 symbolrate)
 {
         s32 BDR; 
         s32 BDRI;
@@ -289,17 +242,27 @@
 	if (symbolrate < 500000)
                 symbolrate = 500000;
 
-        if (symbolrate < XIN/16) NDEC = 1;
-        if (symbolrate < XIN/32) NDEC = 2;
-        if (symbolrate < XIN/64) NDEC = 3;
-
-        if (symbolrate < (u32)(XIN/12.3)) SFIL = 1;
-        if (symbolrate < (u32)(XIN/16))	 SFIL = 0;
-        if (symbolrate < (u32)(XIN/24.6)) SFIL = 1;
-        if (symbolrate < (u32)(XIN/32))	 SFIL = 0;
-        if (symbolrate < (u32)(XIN/49.2)) SFIL = 1;
-        if (symbolrate < (u32)(XIN/64))	 SFIL = 0;
-        if (symbolrate < (u32)(XIN/98.4)) SFIL = 1;
+	if (symbolrate < XIN / 16)
+		NDEC = 1;
+	if (symbolrate < XIN / 32)
+		NDEC = 2;
+	if (symbolrate < XIN / 64)
+		NDEC = 3;
+
+	if (symbolrate < (u32) (XIN / 12.3))
+		SFIL = 1;
+	if (symbolrate < (u32) (XIN / 16))
+		SFIL = 0;
+	if (symbolrate < (u32) (XIN / 24.6))
+		SFIL = 1;
+	if (symbolrate < (u32) (XIN / 32))
+		SFIL = 0;
+	if (symbolrate < (u32) (XIN / 49.2))
+		SFIL = 1;
+	if (symbolrate < (u32) (XIN / 64))
+		SFIL = 0;
+	if (symbolrate < (u32) (XIN / 98.4))
+		SFIL = 1;
         
         symbolrate <<= NDEC;
         ratio = (symbolrate << 4) / FIN;
@@ -318,20 +281,18 @@
         
         NDEC = (NDEC << 6) | ves1820_inittab[0x03];
 
-        ves1820_writereg (fe, 0x03, NDEC);
-        ves1820_writereg (fe, 0x0a, BDR&0xff);
-        ves1820_writereg (fe, 0x0b, (BDR>> 8)&0xff);
-        ves1820_writereg (fe, 0x0c, (BDR>>16)&0x3f);
+	ves1820_writereg(state, 0x03, NDEC);
+	ves1820_writereg(state, 0x0a, BDR & 0xff);
+	ves1820_writereg(state, 0x0b, (BDR >> 8) & 0xff);
+	ves1820_writereg(state, 0x0c, (BDR >> 16) & 0x3f);
 
-        ves1820_writereg (fe, 0x0d, BDRI);
-        ves1820_writereg (fe, 0x0e, SFIL);
+	ves1820_writereg(state, 0x0d, BDRI);
+	ves1820_writereg(state, 0x0e, SFIL);
 
         return 0;
 }
 
-
-static int ves1820_set_parameters (struct dvb_frontend *fe,
-			    struct dvb_frontend_parameters *p)
+static int ves1820_set_parameters(struct ves1820_state *state, struct dvb_frontend_parameters *p)
 {
 	static const u8 reg0x00 [] = { 0x00, 0x04, 0x08, 0x0c, 0x10 };
 	static const u8 reg0x01 [] = {  140,  140,  106,  100,   92 };
@@ -343,16 +304,16 @@
 	if (real_qam < 0 || real_qam > 4)
 		return -EINVAL;
 
-	tuner_set_tv_freq (fe, p->frequency);
-	ves1820_set_symbolrate (fe, p->u.qam.symbol_rate);
-	ves1820_writereg (fe, 0x34, GET_PWM(fe->data));
-
-        ves1820_writereg (fe, 0x01, reg0x01[real_qam]);
-        ves1820_writereg (fe, 0x05, reg0x05[real_qam]);
-        ves1820_writereg (fe, 0x08, reg0x08[real_qam]);
-        ves1820_writereg (fe, 0x09, reg0x09[real_qam]);
+	tuner_set_tv_freq(state, p->frequency);
+	ves1820_set_symbolrate(state, p->u.qam.symbol_rate);
+	ves1820_writereg(state, 0x34, state->pwm);
+
+	ves1820_writereg(state, 0x01, reg0x01[real_qam]);
+	ves1820_writereg(state, 0x05, reg0x05[real_qam]);
+	ves1820_writereg(state, 0x08, reg0x08[real_qam]);
+	ves1820_writereg(state, 0x09, reg0x09[real_qam]);
 
-	ves1820_setup_reg0 (fe, reg0x00[real_qam], p->inversion);
+	ves1820_setup_reg0(state, reg0x00[real_qam], p->inversion);
 
 	/* yes, this speeds things up: userspace reports lock in about 8 ms
 	   instead of 500 to 1200 ms after calling FE_SET_FRONTEND. */
@@ -361,10 +322,10 @@
 	return 0;
 }
 
-
-
 static int ves1820_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
+	struct ves1820_state *state = (struct ves1820_state *) fe->data;
+
         switch (cmd) {
 	case FE_GET_INFO:
 		memcpy (arg, &ves1820_info, sizeof(struct dvb_frontend_info));
@@ -377,7 +338,7 @@
 
 		*status = 0;
 
-                sync = ves1820_readreg (fe, 0x11);
+			sync = ves1820_readreg(state, 0x11);
 
 		if (sync & 1)
 			*status |= FE_HAS_SIGNAL;
@@ -399,57 +360,54 @@
 
 	case FE_READ_BER:
 	{
-		u32 ber = ves1820_readreg(fe, 0x14) |
-			 (ves1820_readreg(fe, 0x15) << 8) |
-			 ((ves1820_readreg(fe, 0x16) & 0x0f) << 16);
+			u32 ber = ves1820_readreg(state, 0x14) |
+					(ves1820_readreg(state, 0x15) << 8) |
+					((ves1820_readreg(state, 0x16) & 0x0f) << 16);
 		*((u32*) arg) = 10 * ber;
 		break;
 	}
 	case FE_READ_SIGNAL_STRENGTH:
 	{
-		u8 gain = ves1820_readreg(fe, 0x17);
+			u8 gain = ves1820_readreg(state, 0x17);
 		*((u16*) arg) = (gain << 8) | gain;
 		break;
 	}
 
 	case FE_READ_SNR:
 	{
-		u8 quality = ~ves1820_readreg(fe, 0x18);
+			u8 quality = ~ves1820_readreg(state, 0x18);
 		*((u16*) arg) = (quality << 8) | quality;
 		break;
 	}
 
 	case FE_READ_UNCORRECTED_BLOCKS:
-		*((u32*) arg) = ves1820_readreg (fe, 0x13) & 0x7f;
+		*((u32 *) arg) = ves1820_readreg(state, 0x13) & 0x7f;
 		if (*((u32*) arg) == 0x7f)
 			*((u32*) arg) = 0xffffffff;
 		/* reset uncorrected block counter */
-		ves1820_writereg (fe, 0x10, ves1820_inittab[0x10] & 0xdf);
-	        ves1820_writereg (fe, 0x10, ves1820_inittab[0x10]);
+		ves1820_writereg(state, 0x10, ves1820_inittab[0x10] & 0xdf);
+		ves1820_writereg(state, 0x10, ves1820_inittab[0x10]);
 		break;
 
         case FE_SET_FRONTEND:
-		return ves1820_set_parameters (fe, arg);
+		return ves1820_set_parameters(state, arg);
 
 	case FE_GET_FRONTEND:
 	{
 		struct dvb_frontend_parameters *p = (struct dvb_frontend_parameters *)arg;
-		u8 reg0 = GET_REG0(fe->data);
 		int sync;
 		s8 afc = 0;
                 
-                sync = ves1820_readreg (fe, 0x11);
-			afc = ves1820_readreg(fe, 0x19);
+			sync = ves1820_readreg(state, 0x11);
+			afc = ves1820_readreg(state, 0x19);
 		if (verbose) {
 			/* AFC only valid when carrier has been recovered */
-			printk(sync & 2 ? "DVB: VES1820(%d): AFC (%d) %dHz\n" :
-					  "DVB: VES1820(%d): [AFC (%d) %dHz]\n",
-					fe->i2c->adapter->num, afc,
-			       -((s32)p->u.qam.symbol_rate * afc) >> 10);
+				printk(sync & 2 ? "ves1820: AFC (%d) %dHz\n" :
+					"ves1820: [AFC (%d) %dHz]\n", afc, -((s32) p->u.qam.symbol_rate * afc) >> 10);
 		}
 
-		p->inversion = HAS_INVERSION(reg0) ? INVERSION_ON : INVERSION_OFF;
-		p->u.qam.modulation = ((reg0 >> 2) & 7) + QAM_16;
+			p->inversion = HAS_INVERSION(state->reg0) ? INVERSION_ON : INVERSION_OFF;
+			p->u.qam.modulation = ((state->reg0 >> 2) & 7) + QAM_16;
 
 		p->u.qam.fec_inner = FEC_NONE;
 
@@ -459,12 +417,12 @@
 		break;
 	}
 	case FE_SLEEP:
-		ves1820_writereg (fe, 0x1b, 0x02);  /* pdown ADC */
-		ves1820_writereg (fe, 0x00, 0x80);  /* standby */
+		ves1820_writereg(state, 0x1b, 0x02);	/* pdown ADC */
+		ves1820_writereg(state, 0x00, 0x80);	/* standby */
 		break;
 
         case FE_INIT:
-                return ves1820_init (fe);
+		return ves1820_init(state);
 
         default:
                 return -EINVAL;
@@ -473,21 +431,18 @@
         return 0;
 } 
 
-
-static long probe_tuner (struct dvb_i2c_bus *i2c)
+static long probe_tuner(struct i2c_adapter *i2c)
 {
-	static const struct i2c_msg msg1 = 
-		{ .addr = 0x61, .flags = 0, .buf = NULL, .len = 0 };
-	static const struct i2c_msg msg2 =
-		{ .addr = 0x62, .flags = 0, .buf = NULL, .len = 0 };
+	struct i2c_msg msg1 = {.addr = 0x61,.flags = 0,.buf = NULL,.len = 0 };
+	struct i2c_msg msg2 = {.addr = 0x62,.flags = 0,.buf = NULL,.len = 0 };
 	int type;
 
-	if (i2c->xfer(i2c, &msg1, 1) == 1) {
+	if (i2c_transfer(i2c, &msg1, 1) == 1) {
 		type = 0;
-		printk ("DVB: VES1820(%d): setup for tuner spXXXX\n", i2c->adapter->num);
-	} else if (i2c->xfer(i2c, &msg2, 1) == 1) {
+		printk("ves1820: setup for tuner spXXXX\n");
+	} else if (i2c_transfer(i2c, &msg2, 1) == 1) {
 		type = 1;
-		printk ("DVB: VES1820(%d): setup for tuner sp5659c\n", i2c->adapter->num);
+		printk("ves1820: setup for tuner sp5659c\n");
 	} else {
 		type = -1;
 	}
@@ -495,91 +450,186 @@
 	return type;
 }
 
-
-static u8 read_pwm (struct dvb_i2c_bus *i2c)
+static u8 read_pwm(struct i2c_adapter *i2c)
 {
 	u8 b = 0xff;
 	u8 pwm;
 	struct i2c_msg msg [] = { { .addr = 0x50, .flags = 0, .buf = &b, .len = 1 },
-			 { .addr = 0x50, .flags = I2C_M_RD, .buf = &pwm, .len = 1 } };
+	{.addr = 0x50,.flags = I2C_M_RD,.buf = &pwm,.len = 1}
+	};
 
-	if ((i2c->xfer(i2c, msg, 2) != 2) || (pwm == 0xff))
+	if ((i2c_transfer(i2c, msg, 2) != 2) || (pwm == 0xff))
 		pwm = 0x48;
 
-	printk("DVB: VES1820(%d): pwm=0x%02x\n", i2c->adapter->num, pwm);
+	printk("ves1820: pwm=0x%02x\n", pwm);
 
 	return pwm;
 }
 
-
-static long probe_demod_addr (struct dvb_i2c_bus *i2c)
+static long probe_demod_addr(struct i2c_adapter *i2c)
 {
 	u8 b [] = { 0x00, 0x1a };
 	u8 id;
 	struct i2c_msg msg [] = { { .addr = 0x08, .flags = 0, .buf = b, .len = 2 },
-	                   { .addr = 0x08, .flags = I2C_M_RD, .buf = &id, .len = 1 } };
+	{.addr = 0x08,.flags = I2C_M_RD,.buf = &id,.len = 1}
+	};
 
-	if (i2c->xfer(i2c, msg, 2) == 2 && (id & 0xf0) == 0x70)
+	if (i2c_transfer(i2c, msg, 2) == 2 && (id & 0xf0) == 0x70)
 		return msg[0].addr;
 
 	msg[0].addr = msg[1].addr = 0x09;
 
-	if (i2c->xfer(i2c, msg, 2) == 2 && (id & 0xf0) == 0x70)
+	if (i2c_transfer(i2c, msg, 2) == 2 && (id & 0xf0) == 0x70)
 		return msg[0].addr;
 
 	return -1;
 }
 
+static ssize_t attr_read_pwm(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ves1820_state *state = (struct ves1820_state *) i2c_get_clientdata(client);
+	return sprintf(buf, "0x%02x\n", state->pwm);
+}
+
+static ssize_t attr_write_pwm(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ves1820_state *state = (struct ves1820_state *) i2c_get_clientdata(client);
+	unsigned long pwm;
+	pwm = simple_strtoul(buf, NULL, 0);
+	state->pwm = pwm & 0xff;
+	return strlen(buf)+1;
+}
+
+static struct device_attribute dev_attr_client_name = {
+	.attr	= { .name = "pwm", .mode = S_IRUGO|S_IWUGO, .owner = THIS_MODULE },
+	.show	= &attr_read_pwm,
+	.store  = &attr_write_pwm,
+};
+
+static struct i2c_client client_template;
 
-static int ves1820_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter(struct i2c_adapter *adapter)
 {
-	void *priv = NULL;
+	struct i2c_client *client;
+	struct ves1820_state *state;
 	long demod_addr;
-	long tuner_type;
+	int tuner_type;
+	int ret;
 
-	if ((demod_addr = probe_demod_addr(i2c)) < 0)
+	demod_addr = probe_demod_addr(adapter);
+	if (demod_addr < 0)
 		return -ENODEV;
 
-	tuner_type = probe_tuner(i2c);
+	tuner_type = probe_tuner(adapter);
+	if (tuner_type < 0) {
+		printk("ves1820: demod found, but unknown tuner type.\n");
+		return -ENODEV;
+	}
 
-	if ((i2c->adapter->num < MAX_UNITS) && pwm[i2c->adapter->num] != -1) {
-		printk("DVB: VES1820(%d): pwm=0x%02x (user specified)\n",
-				i2c->adapter->num, pwm[i2c->adapter->num]);
-		SET_PWM(priv, pwm[i2c->adapter->num]);
+	if ((state = kmalloc(sizeof(struct ves1820_state), GFP_KERNEL)) == NULL) {
+		return -ENOMEM;
 	}
-	else
-		SET_PWM(priv, read_pwm(i2c));
-	SET_REG0(priv, ves1820_inittab[0]);
-	SET_TUNER(priv, tuner_type);
-	SET_DEMOD_ADDR(priv, demod_addr);
 
-	return dvb_register_frontend (ves1820_ioctl, i2c, priv, &ves1820_info);
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memset(state, 0, sizeof(*state));
+	state->i2c = adapter;
+	state->tuner = tuner_type;
+	state->pwm = read_pwm(adapter);
+	state->reg0 = ves1820_inittab[0];
+	state->demod_addr = demod_addr;
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = addr[tuner_type];
+
+	i2c_set_clientdata(client, (void *) state);
+
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(state);
+		return ret;
 }
 
+	BUG_ON(!state->dvb);
+
+	device_create_file(&client->dev, &dev_attr_client_name);
+
+	ret = dvb_register_frontend(ves1820_ioctl, state->dvb, state, &ves1820_info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int detach_client(struct i2c_client *client)
+{
+	struct ves1820_state *state = (struct ves1820_state *) i2c_get_clientdata(client);
+	dvb_unregister_frontend_new(ves1820_ioctl, state->dvb);
+	device_remove_file(&client->dev, &dev_attr_client_name);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
 
-static void ves1820_detach (struct dvb_i2c_bus *i2c, void *data)
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	dvb_unregister_frontend (ves1820_ioctl, i2c);
+	struct ves1820_state *state = (struct ves1820_state *) i2c_get_clientdata(client);
+
+	switch (cmd) {
+	case FE_REGISTER:{
+			state->dvb = (struct dvb_adapter *) arg;
+			break;
+		}
+	case FE_UNREGISTER:{
+			state->dvb = NULL;
+			break;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
+static struct i2c_driver driver = {
+	.owner = THIS_MODULE,
+	.name = "ves1820",
+	.id = I2C_DRIVERID_VES1820,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client = detach_client,
+	.command = command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("ves1820"),
+	.flags = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
+};
 
 static int __init init_ves1820 (void)
 {
-	int i;
-	for (i = 0; i < MAX_UNITS; i++)
-		if (pwm[i] < -1 || pwm[i] > 255)
-			return -EINVAL;
-	return dvb_register_i2c_device (THIS_MODULE,
-					ves1820_attach, ves1820_detach);
+	return i2c_add_driver(&driver);
 }
 
-
 static void __exit exit_ves1820 (void)
 {
-	dvb_unregister_i2c_device (ves1820_attach);
+	if (i2c_del_driver(&driver))
+		printk("ves1820: driver deregistration failed\n");
 }
 
-
 module_init(init_ves1820);
 module_exit(exit_ves1820);
 
@@ -583,8 +633,6 @@
 module_init(init_ves1820);
 module_exit(exit_ves1820);
 
-MODULE_PARM(pwm, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM_DESC(pwm, "override PWM value stored in EEPROM (tuner calibration)");
 MODULE_PARM(verbose, "i");
 MODULE_PARM_DESC(verbose, "print AFC offset after tuning for debugging the PWM setting");
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/ves1x93.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1x93.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/ves1x93.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1x93.c	2004-08-18 19:52:18.000000000 +0200
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
 static int debug = 0;
 #define dprintk	if (debug) printk
@@ -112,17 +111,19 @@
 
 struct ves1x93_state {
 	fe_spectral_inversion_t inversion;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
 };
 
 
 
-static int ves1x93_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
+static int ves1x93_writereg (struct i2c_adapter *i2c, u8 reg, u8 data)
 {
         u8 buf [] = { 0x00, reg, data };
 	struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = buf, .len = 3 };
 	int err;
 
-        if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
+	if ((err = i2c_transfer (i2c, &msg, 1)) != 1) {
 		dprintk ("%s: writereg error (err == %i, reg == 0x%02x, data == 0x%02x)\n", __FUNCTION__, err, reg, data);
 		return -EREMOTEIO;
 	}
@@ -131,7 +132,7 @@
 }
 
 
-static u8 ves1x93_readreg (struct dvb_i2c_bus *i2c, u8 reg)
+static u8 ves1x93_readreg (struct i2c_adapter *i2c, u8 reg)
 {
 	int ret;
 	u8 b0 [] = { 0x00, reg };
@@ -139,7 +140,7 @@
 	struct i2c_msg msg [] = { { .addr = 0x08, .flags = 0, .buf = b0, .len = 2 },
 			   { .addr = 0x08, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 
-	ret = i2c->xfer (i2c, msg, 2);
+	ret = i2c_transfer (i2c, msg, 2);
 
 	if (ret != 2)
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
@@ -148,13 +149,13 @@
 }
 
 
-static int tuner_write (struct dvb_i2c_bus *i2c, u8 *data, u8 len)
+static int tuner_write (struct i2c_adapter *i2c, u8 *data, u8 len)
 {
         int ret;
         struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = len };
 
 	ves1x93_writereg(i2c, 0x00, 0x11);
-        ret = i2c->xfer (i2c, &msg, 1);
+	ret = i2c_transfer (i2c, &msg, 1);
 	ves1x93_writereg(i2c, 0x00, 0x01);
 
         if (ret != 1)
@@ -169,7 +170,7 @@
  *   set up the downconverter frequency divisor for a
  *   reference clock comparision frequency of 125 kHz.
  */
-static int sp5659_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, u8 pwr)
+static int sp5659_set_tv_freq (struct i2c_adapter *i2c, u32 freq, u8 pwr)
 {
         u32 div = (freq + 479500) / 125;
 	u8 buf [4] = { (div >> 8) & 0x7f, div & 0xff, 0x95, (pwr << 5) | 0x30 };
@@ -178,7 +179,7 @@
 }
 
 
-static int tsa5059_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static int tsa5059_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
 	int ret;
 	u8 buf [2];
@@ -194,7 +195,7 @@
 }
 
 
-static int tuner_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, u8 pwr)
+static int tuner_set_tv_freq (struct i2c_adapter *i2c, u32 freq, u8 pwr)
 {
 	if ((demod_type == DEMOD_VES1893) && (board_type == BOARD_SIEMENS_PCI))
 		return sp5659_set_tv_freq (i2c, freq, pwr);
@@ -205,7 +206,7 @@
 }
 
 
-static int ves1x93_init (struct dvb_i2c_bus *i2c)
+static int ves1x93_init (struct i2c_adapter *i2c)
 {
 	int i;
 	int size;
@@ -249,24 +250,24 @@
 }
 
 
-static int ves1x93_clr_bit (struct dvb_i2c_bus *i2c)
+static int ves1x93_clr_bit (struct i2c_adapter *i2c)
 {
         ves1x93_writereg (i2c, 0, init_1x93_tab[0] & 0xfe);
         ves1x93_writereg (i2c, 0, init_1x93_tab[0]);
-	dvb_delay(5);
+	msleep(5);
 	return 0;
 }
 
-static int ves1x93_init_aquire (struct dvb_i2c_bus *i2c)
+static int ves1x93_init_aquire (struct i2c_adapter *i2c)
 {
         ves1x93_writereg (i2c, 3, 0x00);
 	ves1x93_writereg (i2c, 3, init_1x93_tab[3]);
-	dvb_delay(5);
+	msleep(5);
 	return 0;
 }
 
 
-static int ves1x93_set_inversion (struct dvb_i2c_bus *i2c, fe_spectral_inversion_t inversion)
+static int ves1x93_set_inversion (struct i2c_adapter *i2c, fe_spectral_inversion_t inversion)
 {
 	u8 val;
 
@@ -293,7 +294,7 @@
 }
 
 
-static int ves1x93_set_fec (struct dvb_i2c_bus *i2c, fe_code_rate_t fec)
+static int ves1x93_set_fec (struct i2c_adapter *i2c, fe_code_rate_t fec)
 {
 	if (fec == FEC_AUTO)
 		return ves1x93_writereg (i2c, 0x0d, 0x08);
@@ -304,13 +305,13 @@
 }
 
 
-static fe_code_rate_t ves1x93_get_fec (struct dvb_i2c_bus *i2c)
+static fe_code_rate_t ves1x93_get_fec (struct i2c_adapter *i2c)
 {
 	return FEC_1_2 + ((ves1x93_readreg (i2c, 0x0d) >> 4) & 0x7);
 }
 
 
-static int ves1x93_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate)
+static int ves1x93_set_symbolrate (struct i2c_adapter *i2c, u32 srate)
 {
 	u32 BDR;
         u32 ratio;
@@ -414,7 +415,7 @@
 }
 
 
-static int ves1x93_afc (struct dvb_i2c_bus *i2c, u32 freq, u32 srate)
+static int ves1x93_afc (struct i2c_adapter *i2c, u32 freq, u32 srate)
 {
 	int afc;
 
@@ -433,7 +434,7 @@
 	return 0;
 }
 
-static int ves1x93_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage)
+static int ves1x93_set_voltage (struct i2c_adapter *i2c, fe_sec_voltage_t voltage)
 {
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
@@ -450,8 +451,8 @@
 
 static int ves1x93_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
 	struct ves1x93_state *state = (struct ves1x93_state*) fe->data;
+	struct i2c_adapter *i2c = state->i2c;
 
         switch (cmd) {
         case FE_GET_INFO:
@@ -578,11 +579,14 @@
         return 0;
 } 
 
+static struct i2c_client client_template;
 
-static int ves1x93_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter(struct i2c_adapter *adapter)
 {
-	u8 identity = ves1x93_readreg(i2c, 0x1e);
+	struct i2c_client *client;
 	struct ves1x93_state* state;
+	u8 identity = ves1x93_readreg(adapter, 0x1e);
+	int ret;
 
 	switch (identity) {
 	case 0xdc: /* VES1893A rev1 */
@@ -608,19 +612,88 @@
 	if ((state = kmalloc(sizeof(struct ves1x93_state), GFP_KERNEL)) == NULL) {
 		return -ENOMEM;
 	}
+
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
 	state->inversion = INVERSION_OFF;
-	*data = state;
+	state->i2c = adapter;
 
-	return dvb_register_frontend (ves1x93_ioctl, i2c, (void*) state, &ves1x93_info);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = (0x08>>1);
+	i2c_set_clientdata(client, (void*)state);
+	
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(state);
+		return -EFAULT;
+	}
+
+	BUG_ON(!state->dvb);
+
+	ret = dvb_register_frontend(ves1x93_ioctl, state->dvb, state,
+					&ves1x93_info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
+		return -EFAULT;
 }
 
+	return 0;
+}
 
-static void ves1x93_detach (struct dvb_i2c_bus *i2c, void *data)
+static int detach_client(struct i2c_client *client)
 {
-	kfree(data);
-	dvb_unregister_frontend (ves1x93_ioctl, i2c);
+	struct ves1x93_state *state = (struct ves1x93_state*)i2c_get_clientdata(client);
+	dvb_unregister_frontend_new(ves1x93_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
+
+static int command (struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct ves1x93_state *state = (struct ves1x93_state*)i2c_get_clientdata(client);
+
+	dprintk ("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+	case FE_REGISTER: {
+		state->dvb = (struct dvb_adapter*)arg;
+		break;
+	}
+	case FE_UNREGISTER: {
+		state->dvb = NULL;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
 }
+	return 0;
+}
+
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= "ves1x93",
+	.id 		= I2C_DRIVERID_DVBFE_VES1X93,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client 	= detach_client,
+	.command 	= command,
+};
 
+static struct i2c_client client_template = {
+	I2C_DEVNAME("ves1x93"),
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
 
 static int __init init_ves1x93 (void)
 {
@@ -638,16 +711,16 @@
 		return -EIO;
 	}
 
-	return dvb_register_i2c_device (THIS_MODULE, ves1x93_attach, ves1x93_detach);
+	return i2c_add_driver(&driver);
 }
 
 
 static void __exit exit_ves1x93 (void)
 {
-	dvb_unregister_i2c_device (ves1x93_attach);
+	if (i2c_del_driver(&driver))
+		printk("vex1x93: driver deregistration failed\n");
 }
 
-
 module_init(init_ves1x93);
 module_exit(exit_ves1x93);
 

--------------060709000801040200090609--

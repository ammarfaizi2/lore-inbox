Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbTGOMKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbTGOMJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:09:22 -0400
Received: from mail.convergence.de ([212.84.236.4]:33696 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267378AbTGOMGG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:06 -0400
Subject: [PATCH 4/17] Update dvb frontend drivers
In-Reply-To: <10582716541717@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:54 +0200
Message-Id: <10582716543302@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - grundig_29504-401.c: fix charge pump and band switch setting bug, catched by Robert Schlabbach <robert_s@gmx.net>
[DVB] - grundig_29504-401.c: pass apply_frontend_param() return value to upper layers
[DVB] - grundig_29504-401.c: try to make a more specific detection mechanism
[DVB] - grundig_29504-491.c:remove bogus out-of-range check, FEC table index is limited to 0...7 due to &= ~0x03 anyway...
[DVB] - nxt6000.c: Patch by Paul Andreassen: Add Support for Comtech DVBT-6k07 (PLL IC: SP5730)
[DVB] - ves1820.c: use Robert Schlabbach's suggestions for CLKCONF (0x03) and CARCONF (0x04)
[DVB] - alps_bsrv2.c: don't enable voltage on init + inversion bugfix
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-06-23 12:40:49.000000000 +0200
@@ -263,8 +263,14 @@
                 if (flags & O_NONBLOCK)
                         return -EWOULDBLOCK;
 
+		up(&fe->sem);
+
                 ret = wait_event_interruptible (events->wait_queue,
                                                 events->eventw != events->eventr);
+
+        	if (down_interruptible (&fe->sem))
+			return -ERESTARTSYS;
+
                 if (ret < 0)
                         return ret;
         }
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/alps_bsrv2.c linux-2.5.73.work/drivers/media/dvb/frontends/alps_bsrv2.c
--- linux-2.5.73.bk/drivers/media/dvb/frontends/alps_bsrv2.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/alps_bsrv2.c	2003-06-25 09:50:42.000000000 +0200
@@ -55,7 +55,7 @@
         0x01, 0xA4, 0x35, 0x81, 0x2A, 0x0d, 0x55, 0xC4,
         0x09, 0x69, 0x00, 0x86, 0x4c, 0x28, 0x7F, 0x00,
         0x00, 0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	
-        0x80, 0x00, 0x31, 0xb0, 0x14, 0x00, 0xDC, 0x20,
+        0x80, 0x00, 0x31, 0xb0, 0x14, 0x00, 0xDC, 0x00,
         0x81, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x55, 0x00, 0x00, 0x7f, 0x00
@@ -158,6 +158,11 @@
 {
 	u8 val;
 
+	/*
+	 * inversion on/off are interchanged because i and q seem to
+	 * be swapped on the hardware
+	 */
+
 	switch (inversion) {
 	case INVERSION_OFF:
 		val = 0xc0;
@@ -166,13 +171,16 @@
 		val = 0x80;
 		break;
 	case INVERSION_AUTO:
-		val = 0x40;
+		val = 0x00;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return ves1893_writereg (i2c, 0x0c, (init_1893_tab[0x0c] & 0x3f) | val);
+	/* needs to be saved for FE_GET_FRONTEND */
+	init_1893_tab[0x0c] = (init_1893_tab[0x0c] & 0x3f) | val;
+
+	return ves1893_writereg (i2c, 0x0c, init_1893_tab[0x0c]);
 }
 
 
@@ -383,8 +391,14 @@
 		afc = (afc * (int)(p->u.qpsk.symbol_rate/1000/8))/16;
 
 		p->frequency -= afc;
+
+		/*
+		 * inversion indicator is only valid
+		 * if auto inversion was used
+		 */
+		if (!(init_1893_tab[0x0c] & 0x80))
 		p->inversion = (ves1893_readreg (i2c, 0x0f) & 2) ? 
-					INVERSION_ON : INVERSION_OFF;
+					INVERSION_OFF : INVERSION_ON;
 		p->u.qpsk.fec_inner = ves1893_get_fec (i2c);
 	/*  XXX FIXME: timing offset !! */
 		break;
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.5.73.work/drivers/media/dvb/frontends/grundig_29504-401.c
--- linux-2.5.73.bk/drivers/media/dvb/frontends/grundig_29504-401.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/grundig_29504-401.c	2003-06-18 14:03:14.000000000 +0200
@@ -37,15 +37,15 @@
 
 
 struct dvb_frontend_info grundig_29504_401_info = {
-	.name 			= "Grundig 29504-401",
-	.type 			= FE_OFDM,
-/*	.frequency_min 		= ???,*/
-/*	.frequency_max 		= ???,*/
-	.frequency_stepsize 	= 166666,
-/*      .frequency_tolerance 	= ???,*/
-/*      .symbol_rate_tolerance 	= ???,*/
-	.notifier_delay =  0,
-	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | 
+	name: "Grundig 29504-401",
+	type: FE_OFDM,
+/*	frequency_min: ???,*/
+/*	frequency_max: ???,*/
+	frequency_stepsize: 166666,
+/*      frequency_tolerance: ???,*/
+/*      symbol_rate_tolerance: ???,*/
+	notifier_delay: 0,
+	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | 
 	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
 	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 |
 	      FE_CAN_MUTE_TS /*| FE_CAN_CLEAN_SETUP*/
@@ -109,15 +109,15 @@
 	div = (36125000 + freq) / 166666;
 	cfg = 0x88;
 
-	cpump = div < 175000000 ? 2 : div < 390000000 ? 1 :
-		div < 470000000 ? 2 : div < 750000000 ? 1 : 3;
+	cpump = freq < 175000000 ? 2 : freq < 390000000 ? 1 :
+		freq < 470000000 ? 2 : freq < 750000000 ? 1 : 3;
 
-	band_select = div < 175000000 ? 0x0e : div < 470000000 ? 0x05 : 0x03;
+	band_select = freq < 175000000 ? 0x0e : freq < 470000000 ? 0x05 : 0x03;
 
 	buf [0] = (div >> 8) & 0x7f;
 	buf [1] = div & 0xff;
 	buf [2] = ((div >> 10) & 0x60) | cfg;
-	buf [3] = cpump | band_select;
+	buf [3] = (cpump << 6) | band_select;
 
 	return tsa5060_write (i2c, buf);
 }
@@ -267,12 +268,12 @@
 }
 
 
-static void reset_and_configure (struct dvb_i2c_bus *i2c)
+static int reset_and_configure (struct dvb_i2c_bus *i2c)
 {
 	u8 buf [] = { 0x06 };
 	struct i2c_msg msg = { .addr = 0x00, .flags = 0, .buf = buf, .len = 1 };
 
-	i2c->xfer (i2c, &msg, 1);
+	return (i2c->xfer (i2c, &msg, 1) == 1) ? 0 : -ENODEV;
 }
 
 
@@ -391,7 +392,7 @@
 		struct dvb_frontend_parameters *p = arg;
 
 		tsa5060_set_tv_freq (i2c, p->frequency);
-		apply_frontend_param (i2c, p);
+		return apply_frontend_param (i2c, p);
 	}
         case FE_GET_FRONTEND:
 		/*  we could correct the frequency here, but...
@@ -417,25 +418,61 @@
 
 static int l64781_attach (struct dvb_i2c_bus *i2c)
 {
+	u8 reg0x3e;
 	u8 b0 [] = { 0x1a };
 	u8 b1 [] = { 0x00 };
 	struct i2c_msg msg [] = { { .addr = 0x55, .flags = 0, .buf = b0, .len = 1 },
 			   { .addr = 0x55, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 
-	if (i2c->xfer (i2c, msg, 2) == 2)   /*  probably an EEPROM... */
+	/**
+	 *  the L64781 won't show up before we send the reset_and_configure()
+	 *  broadcast. If nothing responds there is no L64781 on the bus...
+	 */
+	if (reset_and_configure(i2c) < 0) {
+		dprintk("no response on reset_and_configure() broadcast, bailing out...\n");
 		return -ENODEV;
+	}
 
-	reset_and_configure (i2c);
-
-	if (i2c->xfer (i2c, msg, 2) != 2)   /*  nothing... */
+	/* The chip always responds to reads */
+	if (i2c->xfer(i2c, msg, 2) != 2) {  
+	        dprintk("no response to read on I2C bus\n");
 		return -ENODEV;
+	}
+
+	/* Save current register contents for bailout */
+	reg0x3e = l64781_readreg(i2c, 0x3e);
 
-	if (b1[0] != 0xa1)
+	/* Reading the POWER_DOWN register always returns 0 */
+	if (reg0x3e != 0) {
+	        dprintk("Device doesn't look like L64781\n");
 		return -ENODEV;
+	}
+
+	/* Turn the chip off */
+	l64781_writereg (i2c, 0x3e, 0x5a);
+
+	/* Responds to all reads with 0 */
+	if (l64781_readreg(i2c, 0x1a) != 0) {
+ 	        dprintk("Read 1 returned unexpcted value\n");
+	        goto bailout;
+	}	  
+
+	/* Turn the chip on */
+	l64781_writereg (i2c, 0x3e, 0xa5);
+	
+	/* Responds with register default value */
+	if (l64781_readreg(i2c, 0x1a) != 0xa1) { 
+ 	        dprintk("Read 2 returned unexpcted value\n");
+	        goto bailout;
+	}
 
 	dvb_register_frontend (grundig_29504_401_ioctl, i2c, NULL,
 			       &grundig_29504_401_info);
 	return 0;
+
+ bailout:
+	l64781_writereg (i2c, 0x3e, reg0x3e);  /* restore reg 0x3e */
+	return -ENODEV;
 }
 
 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/grundig_29504-491.c linux-2.5.73.work/drivers/media/dvb/frontends/grundig_29504-491.c
--- linux-2.5.73.bk/drivers/media/dvb/frontends/grundig_29504-491.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/grundig_29504-491.c	2003-06-25 09:50:42.000000000 +0200
@@ -179,10 +179,7 @@
 	static fe_code_rate_t fec_tab [] = { FEC_8_9, FEC_1_2, FEC_2_3, FEC_3_4,
 				       FEC_4_5, FEC_5_6, FEC_6_7, FEC_7_8 };
 
-	index = tda8083_readreg (i2c, 0x0e) & 0x3;
-
-	if (index > 7)
-		return FEC_NONE;
+	index = tda8083_readreg(i2c, 0x0e) & 0x07;
 
 	return fec_tab [index];
 }
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/nxt6000.c linux-2.5.73.work/drivers/media/dvb/frontends/nxt6000.c
--- linux-2.5.73.bk/drivers/media/dvb/frontends/nxt6000.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/nxt6000.c	2003-06-18 09:32:40.000000000 +0200
@@ -6,8 +6,10 @@
 	
 	Alps TDME7 (Tuner: MITEL SP5659)
 	Alps TDED4 (Tuner: TI ALP510, external Nxt6000)
+	Comtech DVBT-6k07 (PLL IC: SP5730)
 
     Copyright (C) 2002-2003 Florian Schirmer <schirmer@taytron.net>
+    Copyright (C) 2003 Paul Andreassen <paul@andreassen.com.au>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -78,6 +80,7 @@
 
 #define TUNER_TYPE_ALP510	0
 #define TUNER_TYPE_SP5659	1
+#define TUNER_TYPE_SP5730	2
 
 #define FE2NXT(fe) ((struct nxt6000_config *)&(fe->data))
 #define FREQ2DIV(freq) ((freq + 36166667) / 166667)
@@ -212,6 +215,39 @@
 	
 }
 
+static int sp5730_set_tv_freq(struct dvb_frontend *fe, u32 freq)
+{
+
+	u8 buf[4];
+	struct nxt6000_config *nxt = FE2NXT(fe);
+
+	buf[0] = (FREQ2DIV(freq) >> 8) & 0x7F;
+	buf[1] = FREQ2DIV(freq) & 0xFF;
+	buf[2] = 0x93;
+
+	if ((freq >= 51000000) && (freq < 132100000))
+		buf[3] = 0x05;
+	else if ((freq >= 132100000) && (freq < 143000000))
+		buf[3] = 0x45;
+	else if ((freq >= 146000000) && (freq < 349100000))
+		buf[3] = 0x06;
+	else if ((freq >= 349100000) && (freq < 397100000))
+		buf[3] = 0x46;
+	else if ((freq >= 397100000) && (freq < 426000000))
+		buf[3] = 0x86;
+	else if ((freq >= 430000000) && (freq < 659100000))
+		buf[3] = 0x03;
+	else if ((freq >= 659100000) && (freq < 759100000))
+		buf[3] = 0x43;
+	else if ((freq >= 759100000) && (freq < 858000000))
+		buf[3] = 0x83;
+	else
+		return -EINVAL;
+
+	return pll_write(fe->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
+	
+}
+
 static void nxt6000_reset(struct dvb_frontend *fe)
 {
 
@@ -756,6 +792,13 @@
 						
 					break;
 					
+				case TUNER_TYPE_SP5730:
+
+					if ((result = sp5730_set_tv_freq(fe, param->frequency)) < 0)
+						return result;
+
+					break;
+
 				default:
 				
 					return -EFAULT;
@@ -816,6 +859,14 @@
 	
 			dprintk("nxt6000: detected MITEL SP5659 tuner at 0x%02X\n", nxt.tuner_addr);
 		
+		} else if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC0, NULL, 0) == 0) {
+
+			nxt.tuner_addr = 0xC0;
+			nxt.tuner_type = TUNER_TYPE_SP5730;
+			nxt.clock_inversion = 0;
+	
+			dprintk("nxt6000: detected SP5730 tuner at 0x%02X\n", nxt.tuner_addr);
+		
 		} else {
 
 			printk("nxt6000: unable to detect tuner\n");
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/ves1820.c linux-2.5.73.work/drivers/media/dvb/frontends/ves1820.c
--- linux-2.5.73.bk/drivers/media/dvb/frontends/ves1820.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/ves1820.c	2003-06-20 08:48:36.000000000 +0200
@@ -95,7 +95,7 @@
 
 static u8 ves1820_inittab [] =
 {
-	0x69, 0x6A, 0x9B, 0x0A, 0x52, 0x46, 0x26, 0x1A,
+	0x69, 0x6A, 0x9B, 0x12, 0x12, 0x46, 0x26, 0x1A,
 	0x43, 0x6A, 0xAA, 0xAA, 0x1E, 0x85, 0x43, 0x28,
 	0xE0, 0x00, 0xA1, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
@@ -109,7 +109,7 @@
 {
 	u8 addr = GET_DEMOD_ADDR(fe->data);
         u8 buf[] = { 0x00, reg, data };
-	struct i2c_msg msg = { addr: addr, .flags = 0, .buf = buf, .len = 3 };
+	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = 3 };
 	struct dvb_i2c_bus *i2c = fe->i2c;
         int ret;
 
@@ -130,8 +130,8 @@
 	u8 b0 [] = { 0x00, reg };
 	u8 b1 [] = { 0 };
 	u8 addr = GET_DEMOD_ADDR(fe->data);
-	struct i2c_msg msg [] = { { addr: addr, .flags = 0, .buf = b0, .len = 2 },
-	                   { addr: addr, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
+	struct i2c_msg msg [] = { { .addr = addr, .flags = 0, .buf = b0, .len = 2 },
+	                   { .addr = addr, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
 	struct dvb_i2c_bus *i2c = fe->i2c;
 	int ret;
 
@@ -147,7 +147,7 @@
 static int tuner_write (struct dvb_i2c_bus *i2c, u8 addr, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = { addr: addr, .flags = 0, .buf = data, .len = 4 };
+        struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = data, .len = 4 };
 
         ret = i2c->xfer (i2c, &msg, 1);
 


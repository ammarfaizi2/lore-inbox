Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUBWVPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUBWVMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:12:49 -0500
Received: from mail.convergence.de ([212.84.236.4]:48106 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261986AbUBWVFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:05:00 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 6/9] stv0299 DVB frontend update
In-Reply-To: <10775702834136@convergence.de>
Message-Id: <10775702831806@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:05:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] stv0299: Added seperate settings for SU1278 on Technotrend hardware
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/stv0299.c linux-2.6.3.p/drivers/media/dvb/frontends/stv0299.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/stv0299.c	2004-01-09 09:22:40.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/stv0299.c	2004-02-23 12:52:31.000000000 +0100
@@ -25,6 +25,9 @@
 
     Copyright (C) 2003 Vadim Catana <skystar@moldova.cc>:
 
+    Support for Philips SU1278 on Technotrend hardware
+
+    Copyright (C) 2004 Andrew de Quincey <adq_dvb@lidskialf.net>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -65,15 +68,19 @@
 
 /* frontend types */
 #define UNKNOWN_FRONTEND  -1
-#define PHILIPS_SU1278SH   0
+#define PHILIPS_SU1278_TSA      0 // SU1278 with TSA5959 synth and datasheet recommended settings
 #define ALPS_BSRU6         1
 #define LG_TDQF_S001F      2
-#define PHILIPS_SU1278     3
+#define PHILIPS_SU1278_TUA      3 // SU1278 with TUA6100 synth
 #define SAMSUNG_TBMU24112IMB    4
+#define PHILIPS_SU1278_TSA_TT   5 // SU1278 with TSA5959 synth and TechnoTrend settings
 
 /* Master Clock = 88 MHz */
 #define M_CLK (88000000UL) 
 
+/* Master Clock for TT cards = 64 MHz */
+#define M_CLK_SU1278_TSA_TT (64000000UL)
+
 static struct dvb_frontend_info uni0299_info = {
 	.name			= "STV0299/TSA5059/SL1935 based",
 	.type			= FE_QPSK,
@@ -201,6 +208,51 @@
 };
 
 
+static u8 init_tab_su1278_tsa_tt [] = {
+        0x01, 0x0f,
+        0x02, 0x30,
+        0x03, 0x00,
+        0x04, 0x5b,
+        0x05, 0x85,
+        0x06, 0x02,
+        0x07, 0x00,
+        0x08, 0x02,
+        0x09, 0x00,
+        0x0C, 0x01,
+        0x0D, 0x81, 
+        0x0E, 0x44,
+        0x0f, 0x14,
+        0x10, 0x3c,
+        0x11, 0x84,
+        0x12, 0xda,
+        0x13, 0x97,
+        0x14, 0x95,
+        0x15, 0xc9,
+        0x16, 0x19,
+        0x17, 0x8c,
+        0x18, 0x59,
+        0x19, 0xf8,
+        0x1a, 0xfe,
+        0x1c, 0x7f,
+        0x1d, 0x00,
+        0x1e, 0x00,
+        0x1f, 0x50,
+        0x20, 0x00,
+        0x21, 0x00,
+        0x22, 0x00,
+        0x23, 0x00,
+        0x28, 0x00,
+        0x29, 0x28,
+        0x2a, 0x14,
+        0x2b, 0x0f,
+        0x2c, 0x09,
+        0x2d, 0x09,
+        0x31, 0x1f,
+        0x32, 0x19,
+        0x33, 0xfc,
+        0x34, 0x13
+};
+
 static int stv0299_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
 {
 	int ret;
@@ -297,21 +349,26 @@
 	u8 addr;
 	u32 div;
 	u8 buf[4];
+        int i, divisor, regcode;
 
 	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
 
 	if ((freq < 950000) || (freq > 2150000)) return -EINVAL;
 
+        divisor = 500;
+        regcode = 2;
+
 	// setup frequency divisor
-	div = freq / 1000;
+	div = freq / divisor;
 	buf[0] = (div >> 8) & 0x7f;
 	buf[1] = div & 0xff;
-	buf[2] = 0x81 | ((div & 0x18000) >> 10);
+	buf[2] = 0x80 | ((div & 0x18000) >> 10) | regcode;
 	buf[3] = 0;
 
 	// tuner-specific settings
 	switch(ftype) {
-	case PHILIPS_SU1278SH:
+	case PHILIPS_SU1278_TSA:
+	case PHILIPS_SU1278_TSA_TT:
 		addr = 0x60;
 		buf[3] |= 0x20;
 
@@ -332,7 +389,6 @@
 		return -EINVAL;
 	}
 
-	// charge pump
 	return pll_write (i2c, addr, buf, sizeof(buf));
 }
 
@@ -465,15 +521,20 @@
 
 static int pll_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, int ftype, int srate)
 {
-	if (ftype == SAMSUNG_TBMU24112IMB)
+	switch(ftype) {
+	case SAMSUNG_TBMU24112IMB:
 		return sl1935_set_tv_freq(i2c, freq, ftype);
-	else if (ftype == LG_TDQF_S001F)
+	
+	case LG_TDQF_S001F:
 		return sl1935_set_tv_freq(i2c, freq, ftype);
-	else if (ftype == PHILIPS_SU1278)
+	    
+	case PHILIPS_SU1278_TUA:
 		return tua6100_set_tv_freq(i2c, freq, ftype, srate);
-	else
+
+	default:
 		return tsa5059_set_tv_freq(i2c, freq, ftype, srate);
 }
+}
 
 #if 0
 static int tsa5059_read_status	(struct dvb_i2c_bus *i2c)
@@ -515,18 +576,24 @@
 		}
 		break;
 
+	case PHILIPS_SU1278_TSA_TT:
+	        for (i=0; i<sizeof(init_tab_su1278_tsa_tt); i+=2) {
+			stv0299_writereg (i2c, init_tab_su1278_tsa_tt[i], init_tab_su1278_tsa_tt[i+1]);
+		} 
+	        break;
+	    
 	default:
 	stv0299_writereg (i2c, 0x01, 0x15);
-	stv0299_writereg (i2c, 0x02, ftype == PHILIPS_SU1278 ? 0x00 : 0x30);
+		stv0299_writereg (i2c, 0x02, ftype == PHILIPS_SU1278_TUA ? 0x00 : 0x30);
 	stv0299_writereg (i2c, 0x03, 0x00);
 
 	for (i=0; i<sizeof(init_tab); i+=2)
 		stv0299_writereg (i2c, init_tab[i], init_tab[i+1]);
 
         /* AGC1 reference register setup */
-	if (ftype == PHILIPS_SU1278SH)
+		if (ftype == PHILIPS_SU1278_TSA)
 		  stv0299_writereg (i2c, 0x0f, 0x92);  /* Iagc = Inverse, m1 = 18 */
-	else if (ftype == PHILIPS_SU1278)
+		else if (ftype == PHILIPS_SU1278_TUA)
 		  stv0299_writereg (i2c, 0x0f, 0x94);  /* Iagc = Inverse, m1 = 20 */
 	else
 	  stv0299_writereg (i2c, 0x0f, 0x52);  /* Iagc = Normal,  m1 = 18 */
@@ -796,10 +863,49 @@
 	u8 aclk = 0;
 	u8 bclk = 0;
 	u8 m1;
+        int Mclk = M_CLK;
 
+        // check rate is within limits
 	if ((srate < 1000000) || (srate > 45000000)) return -EINVAL;
+    
+        // calculate value to program
+	if (tuner_type == PHILIPS_SU1278_TSA_TT) Mclk = M_CLK_SU1278_TSA_TT;
+        big = big << 20;
+        do_div(big, Mclk);
+        ratio = big << 4;
+    
+        // program registers
 	switch(tuner_type) {
-	case PHILIPS_SU1278SH:
+	case PHILIPS_SU1278_TSA_TT:
+	        stv0299_writereg (i2c, 0x0e, 0x44);
+	        if (srate >= 10000000) {
+		        stv0299_writereg (i2c, 0x13, 0x97);
+		        stv0299_writereg (i2c, 0x14, 0x95);
+		        stv0299_writereg (i2c, 0x15, 0xc9);
+		        stv0299_writereg (i2c, 0x17, 0x8c);
+		        stv0299_writereg (i2c, 0x1a, 0xfe);
+		        stv0299_writereg (i2c, 0x1c, 0x7f);
+		        stv0299_writereg (i2c, 0x2d, 0x09);
+		} else {
+		        stv0299_writereg (i2c, 0x13, 0x99);
+		        stv0299_writereg (i2c, 0x14, 0x8d);
+		        stv0299_writereg (i2c, 0x15, 0xce);
+		        stv0299_writereg (i2c, 0x17, 0x43);
+		        stv0299_writereg (i2c, 0x1a, 0x1d);
+		        stv0299_writereg (i2c, 0x1c, 0x12);
+		        stv0299_writereg (i2c, 0x2d, 0x05);
+		}
+	        stv0299_writereg (i2c, 0x0e, 0x23);
+	        stv0299_writereg (i2c, 0x0f, 0x94);
+	        stv0299_writereg (i2c, 0x10, 0x39);
+	        stv0299_writereg (i2c, 0x15, 0xc9);
+	    
+	        stv0299_writereg (i2c, 0x1f, (ratio >> 16) & 0xff);
+	        stv0299_writereg (i2c, 0x20, (ratio >>  8) & 0xff);
+	        stv0299_writereg (i2c, 0x21, (ratio      ) & 0xf0);
+	        break;
+	    
+	case PHILIPS_SU1278_TSA:
 		aclk = 0xb5;
 		if (srate < 2000000) bclk = 0x86;
 		else if (srate < 5000000) bclk = 0x89;
@@ -808,6 +914,13 @@
 
 		m1 = 0x14;
 		if (srate < 4000000) m1 = 0x10;
+
+	    	stv0299_writereg (i2c, 0x13, aclk);
+  	        stv0299_writereg (i2c, 0x14, bclk);
+	        stv0299_writereg (i2c, 0x1f, (ratio >> 16) & 0xff);
+	        stv0299_writereg (i2c, 0x20, (ratio >>  8) & 0xff);
+	        stv0299_writereg (i2c, 0x21, (ratio      ) & 0xf0);
+	        stv0299_writereg (i2c, 0x0f, (stv0299_readreg(i2c, 0x0f) & 0xc0) | m1);
 		break;
 
 	case ALPS_BSRU6:
@@ -818,24 +931,7 @@
 		else if (srate <= 14000000) { aclk = 0xb7; bclk = 0x93; }
 		else if (srate <= 30000000) { aclk = 0xb6; bclk = 0x93; }
 		else if (srate <= 45000000) { aclk = 0xb4; bclk = 0x91; }
-
 		m1 = 0x12;
-		break;   
-	}
-        
-	dprintk("%s : big = 0x%08x%08x\n", __FUNCTION__, (int) ((big>>32) & 0xffffffff),  (int) (big & 0xffffffff) );
-        
-	big = big << 20;
-
-	dprintk("%s : big = 0x%08x%08x\n", __FUNCTION__, (int) ((big>>32) & 0xffffffff),  (int) (big & 0xffffffff) );
-
-	do_div(big, M_CLK);
-
-	dprintk("%s : big = 0x%08x%08x\n", __FUNCTION__, (int) ((big>>32) & 0xffffffff),  (int) (big & 0xffffffff) );
-
-	ratio = big << 4;
-
-	dprintk("%s : ratio = %i\n", __FUNCTION__, ratio);
   
 	stv0299_writereg (i2c, 0x13, aclk);
 	stv0299_writereg (i2c, 0x14, bclk);
@@ -843,12 +939,15 @@
 	stv0299_writereg (i2c, 0x20, (ratio >>  8) & 0xff);
 	stv0299_writereg (i2c, 0x21, (ratio      ) & 0xf0);
 	stv0299_writereg (i2c, 0x0f, (stv0299_readreg(i2c, 0x0f) & 0xc0) | m1);
+		break;
+	}
+    
 
 	return 0;
 }
 
 
-static int stv0299_get_symbolrate (struct dvb_i2c_bus *i2c)
+static int stv0299_get_symbolrate (struct dvb_i2c_bus *i2c, int tuner_type)
 {
 	u32 Mclk = M_CLK / 4096L;
 	u32 srate;
@@ -858,6 +957,8 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
+    	if (tuner_type == PHILIPS_SU1278_TSA_TT) Mclk = M_CLK_SU1278_TSA_TT / 4096L;
+    
 	stv0299_readregs (i2c, 0x1f, sfr, 3);
 	stv0299_readregs (i2c, 0x1a, &rtf, 1);
 
@@ -891,8 +991,15 @@
 
 	switch (cmd) {
 	case FE_GET_INFO:
+	{
+	        struct dvb_frontend_info* tmp = (struct dvb_frontend_info*) arg;
 		memcpy (arg, &uni0299_info, sizeof(struct dvb_frontend_info));
+
+	        if (tuner_type == PHILIPS_SU1278_TSA_TT) {
+		        tmp->frequency_tolerance = M_CLK_SU1278_TSA_TT / 2000;
+		}
 		break;
+	}
 
 	case FE_READ_STATUS:
 	{
@@ -976,8 +1083,10 @@
                 stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate, tuner_type);
 		stv0299_writereg (i2c, 0x22, 0x00);
 		stv0299_writereg (i2c, 0x23, 0x00);
+	        if (tuner_type != PHILIPS_SU1278_TSA_TT) {
 		stv0299_readreg (i2c, 0x23);
 		stv0299_writereg (i2c, 0x12, 0xb9);
+		}
 		stv0299_check_inversion (i2c);
 
 		/* printk ("%s: tsa5059 status: %x\n", __FUNCTION__, tsa5059_read_status(i2c)); */
@@ -988,11 +1097,14 @@
         {
 		struct dvb_frontend_parameters *p = arg;
 		s32 derot_freq;
+	        int Mclk = M_CLK;
+
+	        if (tuner_type == PHILIPS_SU1278_TSA_TT) Mclk = M_CLK_SU1278_TSA_TT;
 
 		derot_freq = (s32)(s16) ((stv0299_readreg (i2c, 0x22) << 8)
 					| stv0299_readreg (i2c, 0x23));
 
-		derot_freq *= (M_CLK >> 16);
+		derot_freq *= (Mclk >> 16);
 		derot_freq += 500;
 		derot_freq /= 1000;
 
@@ -1000,7 +1112,7 @@
 		p->inversion = (stv0299_readreg (i2c, 0x0c) & 1) ?
 						INVERSION_OFF : INVERSION_ON;
 		p->u.qpsk.fec_inner = stv0299_get_fec (i2c);
-		p->u.qpsk.symbol_rate = stv0299_get_symbolrate (i2c);
+		p->u.qpsk.symbol_rate = stv0299_get_symbolrate (i2c, tuner_type);
                 break;
         }
 
@@ -1062,10 +1174,16 @@
     	    return SAMSUNG_TBMU24112IMB;
 	}
 
-
 	if ((ret = i2c->xfer(i2c, msg1, 2)) == 2) {
-		printk ("%s: setup for tuner SU1278/SH\n", __FILE__);
-		return PHILIPS_SU1278SH;
+	        if ( strcmp(adapter->name, "TT-Budget/WinTV-NOVA-CI PCI") == 0 ) {
+		        // technotrend cards require non-datasheet settings
+		        printk ("%s: setup for tuner SU1278 (TSA5959 synth) on TechnoTrend hardware\n", __FILE__);
+		        return PHILIPS_SU1278_TSA_TT;
+		}  else {
+		        // fall back to datasheet-recommended settings
+		        printk ("%s: setup for tuner SU1278 (TSA5959 synth)\n", __FILE__);
+		        return PHILIPS_SU1278_TSA;
+		}
 		}
 
 	if ((ret = i2c->xfer(i2c, msg2, 2)) == 2) {
@@ -1086,8 +1204,8 @@
 	stv0299_writereg (i2c, 0x02, 0x00);
 
 	if ((ret = i2c->xfer(i2c, msg3, 2)) == 2) {
-		printk ("%s: setup for tuner Philips SU1278\n", __FILE__);
-		return PHILIPS_SU1278;
+		printk ("%s: setup for tuner Philips SU1278 (TUA6100 synth)\n", __FILE__);
+		return PHILIPS_SU1278_TUA;
 	}
 
 	printk ("%s: unknown PLL synthesizer (ret == %i), "



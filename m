Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTLSMmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTLSMl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:41:59 -0500
Received: from mail.convergence.de ([212.84.236.4]:30138 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262795AbTLSM2o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:44 -0500
Subject: [PATCH 6/12] Update DVB frontend drivers
In-Reply-To: <1071836921644@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:41 +0100
Message-Id: <10718369212949@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - alps_tdmb7, cx24110: use correct delay values, don't divide by HZ when using dvb_delay(), found by Artur Skawina
DVB: - alps_tdmb7: set FE_HAS_LOCK only when all low-order bits are valid
DVB: - mt312: patch for the mt312 module, targeting the VP310:  reduced heat, implement "auto" inversion mode, remove debugging verbosity, add module parameter for debugging (Augusto Cardoso)
DVB: - nxt6000: code review and beautification, use per i2c-adapater void pointer for private data in nxt_attach() / nxt_detach, fix frontend private data handling. patch by Mikael Rosbacke <rosbacke at nada.kth.se>
DVB: - sp887x: firmware loader implementation contributed by Martin Stubbs, C99 comile fixes by  Wolfgang Thiel
DVB: - stv0299: Added new module parameter to choose between BER and UCBLOCKs error monitoring since the STV0299 can't do both at once, Added modifications based on the recommended settings in the SU1278 datasheet.
DVB: - tda1004x: remove FE_CAN_INVERSION_AUTO
DVB: - ves1820:completed nokia board support, increased some delays to get constant results,set default pwm value to 0x48 for boards which don't have an eeprom  (by Andreas Oberritter)
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.0-p/drivers/media/dvb/frontends/alps_tdmb7.c
--- linux-2.6.0/drivers/media/dvb/frontends/alps_tdmb7.c	2003-12-18 03:58:18.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/alps_tdmb7.c	2003-12-10 13:50:15.000000000 +0100
@@ -159,7 +159,7 @@
 	cx22700_writereg (i2c, 0x00, 0x02);   /*  soft reset */
 	cx22700_writereg (i2c, 0x00, 0x00);
 
-	dvb_delay (HZ/100);
+	dvb_delay(10);
 	
 	for (i=0; i<sizeof(init_tab); i+=2)
 		cx22700_writereg (i2c, init_tab[i], init_tab[i+1]);
@@ -281,15 +281,15 @@
 
 	val = cx22700_readreg (i2c, 0x02);
 
-	if ((val >> 3) > 4)
+	if (((val >> 3) & 0x07) > 4)
 		p->code_rate_HP = FEC_AUTO;
 	else
-		p->code_rate_HP = fec_tab[val >> 3];
+		p->code_rate_HP = fec_tab[(val >> 3) & 0x07];
 
-	if ((val & 0x7) > 4)
+	if ((val & 0x07) > 4)
 		p->code_rate_LP = FEC_AUTO;
 	else
-		p->code_rate_LP = fec_tab[val >> 3];
+		p->code_rate_LP = fec_tab[val & 0x07];
 
 
 	val = cx22700_readreg (i2c, 0x03);
@@ -333,7 +333,7 @@
 		if (sync & 0x10)
 			*status |= FE_HAS_SYNC;
 
-		if (sync & 0x10)
+		if (*status == 0x0f)
 			*status |= FE_HAS_LOCK;
 
 		break;
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/cx24110.c linux-2.6.0-p/drivers/media/dvb/frontends/cx24110.c
--- linux-2.6.0/drivers/media/dvb/frontends/cx24110.c	2003-12-18 03:58:04.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/cx24110.c	2003-12-10 13:50:15.000000000 +0100
@@ -248,7 +248,7 @@
         cx24108_write(i2c,pll);
         cx24110_writereg(i2c,0x56,0x7f);
 
-	dvb_delay(HZ/10); /* wait a moment for the tuner pll to lock */
+	dvb_delay(10); /* wait a moment for the tuner pll to lock */
 
 	/* tuner pll lock can be monitored on GPIO pin 4 of cx24110 */
         while (!(cx24110_readreg(i2c,0x66)&0x20)&&i<1000)
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/mt312.c linux-2.6.0-p/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.0/drivers/media/dvb/frontends/mt312.c	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/mt312.c	2003-12-08 16:19:00.000000000 +0100
@@ -39,11 +39,19 @@
 #define MT312_DEBUG		0
 
 #define MT312_SYS_CLK		90000000UL	/* 90 MHz */
+#define MT312_LPOWER_SYS_CLK	60000000UL	/* 60 MHz */
 #define MT312_PLL_CLK		10000000UL	/* 10 MHz */
 
 /* number of active frontends */
 static int mt312_count = 0;
 
+#if MT312_DEBUG == 0
+#define dprintk(x...)
+#else
+static int debug = 0;
+#define dprintk if(debug == 1) printk
+#endif
+
 static struct dvb_frontend_info mt312_info = {
 	.name = "Zarlink MT312",
 	.type = FE_QPSK,
@@ -86,7 +94,7 @@
 		return -EREMOTEIO;
 	}
 #if MT312_DEBUG
-	{
+	if(debug) {
 		int i;
 		printk(KERN_INFO "R(%d):", reg & 0x7f);
 		for (i = 0; i < count; i++)
@@ -107,7 +115,7 @@
 	struct i2c_msg msg;
 
 #if MT312_DEBUG
-	{
+	if(debug) {
 		int i;
 		printk(KERN_INFO "W(%d):", reg & 0x7f);
 		for (i = 0; i < count; i++)
@@ -205,7 +213,7 @@
 	if (freq < 1550000)
 		buf[3] |= 0x10;
 
-	printk(KERN_INFO "synth dword = %02x%02x%02x%02x\n", buf[0],
+	dprintk(KERN_INFO "synth dword = %02x%02x%02x%02x\n", buf[0],
 	       buf[1], buf[2], buf[3]);
 
 	return mt312_pll_write(i2c, I2C_ADDR_SL1935, buf, sizeof(buf));
@@ -225,7 +233,7 @@
 	if (freq < 1550000)
 		buf[3] |= 0x02;
 
-	printk(KERN_INFO "synth dword = %02x%02x%02x%02x\n", buf[0],
+	dprintk(KERN_INFO "synth dword = %02x%02x%02x%02x\n", buf[0],
 	       buf[1], buf[2], buf[3]);
 
 	return mt312_pll_write(i2c, I2C_ADDR_TSA5059, buf, sizeof(buf));
@@ -236,13 +244,13 @@
 	return mt312_writereg(i2c, RESET, full ? 0x80 : 0x40);
 }
 
-static int mt312_init(struct dvb_i2c_bus *i2c, const long id)
+static int mt312_init(struct dvb_i2c_bus *i2c, const long id, u8 pll)
 {
 	int ret;
 	u8 buf[2];
 
 	/* wake up */
-	if ((ret = mt312_writereg(i2c, CONFIG, 0x8c)) < 0)
+	if ((ret = mt312_writereg(i2c, CONFIG, (pll == 60 ? 0x88 : 0x8c))) < 0)
 		return ret;
 
 	/* wait at least 150 usec */
@@ -252,8 +260,17 @@
 	if ((ret = mt312_reset(i2c, 1)) < 0)
 		return ret;
 
+// Per datasheet, write correct values. 09/28/03 ACCJr.
+// If we don't do this, we won't get FE_HAS_VITERBI in the VP310.
+	{
+		u8 buf_def[8]={0x14, 0x12, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00};
+
+		if ((ret = mt312_write(i2c, VIT_SETUP, buf_def, sizeof(buf_def))) < 0)
+			return ret;
+	}
+
 	/* SYS_CLK */
-	buf[0] = mt312_div(MT312_SYS_CLK * 2, 1000000);
+	buf[0] = mt312_div((pll == 60 ? MT312_LPOWER_SYS_CLK : MT312_SYS_CLK) * 2, 1000000);
 
 	/* DISEQC_RATIO */
 	buf[1] = mt312_div(MT312_PLL_CLK, 15000 * 4);
@@ -370,16 +387,18 @@
 	return mt312_writereg(i2c, DISEQC_MODE, volt_tab[v]);
 }
 
-static int mt312_read_status(struct dvb_i2c_bus *i2c, fe_status_t * s)
+static int mt312_read_status(struct dvb_i2c_bus *i2c, fe_status_t *s, const long id)
 {
 	int ret;
-	u8 status[3];
+	u8 status[3], vit_mode;
 
 	*s = 0;
 
 	if ((ret = mt312_read(i2c, QPSK_STAT_H, status, sizeof(status))) < 0)
 		return ret;
 
+	dprintk(KERN_DEBUG "QPSK_STAT_H: 0x%02x, QPSK_STAT_L: 0x%02x, FEC_STATUS: 0x%02x\n", status[0], status[1], status[2]);
+
 	if (status[0] & 0xc0)
 		*s |= FE_HAS_SIGNAL;	/* signal noise ratio */
 	if (status[0] & 0x04)
@@ -390,6 +409,16 @@
 		*s |= FE_HAS_SYNC;	/* byte align lock */
 	if (status[0] & 0x01)
 		*s |= FE_HAS_LOCK;	/* qpsk lock */
+	// VP310 doesn't have AUTO, so we "implement it here" ACCJr
+	if ((id == ID_VP310) && !(status[0] & 0x01)) {
+		if ((ret = mt312_readreg(i2c, VIT_MODE, &vit_mode)) < 0)
+			return ret;
+		vit_mode ^= 0x40;
+		if ((ret = mt312_writereg(i2c, VIT_MODE, vit_mode)) < 0)
+                	return ret;
+		if ((ret = mt312_writereg(i2c, GO, 0x01)) < 0)
+                	return ret;
+	}
 
 	return 0;
 }
@@ -422,7 +451,7 @@
 
 	*signal_strength = agc;
 
-	printk(KERN_DEBUG "agc=%08x err_db=%hd\n", agc, err_db);
+	dprintk(KERN_DEBUG "agc=%08x err_db=%hd\n", agc, err_db);
 
 	return 0;
 }
@@ -458,7 +487,7 @@
 			      const long id)
 {
 	int ret;
-	u8 buf[5];
+	u8 buf[5], config_val;
 	u16 sr;
 
 	const u8 fec_tab[10] =
@@ -467,6 +496,8 @@
 
 	int (*set_tv_freq)(struct dvb_i2c_bus *i2c, u32 freq, u32 sr);
 
+	dprintk("%s: Freq %d\n", __FUNCTION__, p->frequency);
+
 	if ((p->frequency < mt312_info.frequency_min)
 	    || (p->frequency > mt312_info.frequency_max))
 		return -EINVAL;
@@ -489,6 +520,22 @@
 
 	switch (id) {
 	case ID_VP310:
+	// For now we will do this only for the VP310.
+	// It should be better for the mt312 as well, but tunning will be slower. ACCJr 09/29/03
+		if ((ret = mt312_readreg(i2c, CONFIG, &config_val) < 0))
+			return ret;
+		if (p->u.qpsk.symbol_rate >= 30000000) //Note that 30MS/s should use 90MHz
+		{
+			if ((config_val & 0x0c) == 0x08) //We are running 60MHz
+				if ((ret = mt312_init(i2c, id, (u8) 90)) < 0)
+					return ret;
+		}
+		else
+		{
+			if ((config_val & 0x0c) == 0x0C) //We are running 90MHz
+				if ((ret = mt312_init(i2c, id, (u8) 60)) < 0)
+					return ret;
+		}
 		set_tv_freq = tsa5059_set_tv_freq;
 		break;
 	case ID_MT312:
@@ -562,7 +609,7 @@
 
 		monitor = (buf[0] << 8) | buf[1];
 
-		printk(KERN_DEBUG "sr(auto) = %u\n",
+		dprintk(KERN_DEBUG "sr(auto) = %u\n",
 		       mt312_div(monitor * 15625, 4));
 	} else {
 		if ((ret = mt312_writereg(i2c, MON_CTRL, 0x05)) < 0)
@@ -578,9 +625,9 @@
 
 		sym_rat_op = (buf[0] << 8) | buf[1];
 
-		printk(KERN_DEBUG "sym_rat_op=%d dec_ratio=%d\n",
+		dprintk(KERN_DEBUG "sym_rat_op=%d dec_ratio=%d\n",
 		       sym_rat_op, dec_ratio);
-		printk(KERN_DEBUG "*sr(manual) = %lu\n",
+		dprintk(KERN_DEBUG "*sr(manual) = %lu\n",
 		       (((MT312_PLL_CLK * 8192) / (sym_rat_op + 8192)) *
 			2) - dec_ratio);
 	}
@@ -675,7 +722,7 @@
 		return -EOPNOTSUPP;
 
 	case FE_READ_STATUS:
-		return mt312_read_status(i2c, arg);
+		return mt312_read_status(i2c, arg, (long) fe->data);
 
 	case FE_READ_BER:
 		return mt312_read_bercnt(i2c, arg);
@@ -702,7 +749,12 @@
 		return mt312_sleep(i2c);
 
 	case FE_INIT:
-		return mt312_init(i2c, (long) fe->data);
+	//For the VP310 we should run at 60MHz when ever possible.
+	//It should be better to run the mt312 ar lower speed when ever possible, but tunning will be slower. ACCJr 09/29/03
+		if ((long)fe->data == ID_MT312)
+			return mt312_init(i2c, (long) fe->data, (u8) 90);
+		else
+			return mt312_init(i2c, (long) fe->data, (u8) 60);
 
 	case FE_RESET:
 		return mt312_reset(i2c, 0);
@@ -755,6 +807,11 @@
 module_init(mt312_module_init);
 module_exit(mt312_module_exit);
 
+#if MT312_DEBUG != 0
+MODULE_PARM(debug,"i");
+MODULE_PARM_DESC(debug, "enable verbose debug messages");
+#endif
+
 MODULE_DESCRIPTION("MT312 Satellite Channel Decoder Driver");
 MODULE_AUTHOR("Andreas Oberritter <obi@saftware.de>");
 MODULE_LICENSE("GPL");
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/nxt6000.c linux-2.6.0-p/drivers/media/dvb/frontends/nxt6000.c
--- linux-2.6.0/drivers/media/dvb/frontends/nxt6000.c	2003-12-18 03:59:06.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/nxt6000.c	2003-11-25 13:10:26.000000000 +0100
@@ -55,20 +52,10 @@
 	.symbol_rate_max = 9360000,	/* FIXME */
 	.symbol_rate_tolerance = 4000,
 	.notifier_delay = 0,
-	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
-			FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 |
-			FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO |
-			FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
-			FE_CAN_TRANSMISSION_MODE_AUTO |
-			FE_CAN_GUARD_INTERVAL_AUTO |
-			FE_CAN_HIERARCHY_AUTO,
-
+	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 | FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO | FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO | FE_CAN_HIERARCHY_AUTO,
 };
 
-#pragma pack(1)
-
 struct nxt6000_config {
-
 	u8 demod_addr;
 	u8 tuner_addr;
 	u8 tuner_type;
@@ -73,16 +60,13 @@
 	u8 tuner_addr;
 	u8 tuner_type;
 	u8 clock_inversion;
-
 };
 
-#pragma pack()
-
 #define TUNER_TYPE_ALP510	0
 #define TUNER_TYPE_SP5659	1
 #define TUNER_TYPE_SP5730	2
 
-#define FE2NXT(fe) ((struct nxt6000_config *)&(fe->data))
+#define FE2NXT(fe) ((struct nxt6000_config *)((fe)->data))
 #define FREQ2DIV(freq) ((freq + 36166667) / 166667)
 
 #define dprintk if (debug) printk
@@ -116,8 +95,10 @@
 	int ret;
 	u8 b0[] = {reg};
 	u8 b1[] = {0};
-	struct i2c_msg msgs[] = {{.addr = addr >> 1, .flags = 0, .buf = b0, .len = 1},
-							{.addr = addr >> 1, .flags = I2C_M_RD, .buf = b1, .len = 1}};
+	struct i2c_msg msgs[] = {
+		{.addr = addr >> 1,.flags = 0,.buf = b0,.len = 1},
+		{.addr = addr >> 1,.flags = I2C_M_RD,.buf = b1,.len = 1}
+	};
 
 	ret = i2c->xfer(i2c, msgs, 2);
 	
@@ -394,7 +333,7 @@
 	nxt6000_writereg(fe, OFDM_ITB_FREQ_1, 0x06);
 	nxt6000_writereg(fe, OFDM_ITB_FREQ_2, 0x31);
 	nxt6000_writereg(fe, OFDM_CAS_CTL, (0x01 << 7) | (0x02 << 3) | 0x04);
-	nxt6000_writereg(fe, CAS_FREQ, 0xBB);	// CHECKME
+	nxt6000_writereg(fe, CAS_FREQ, 0xBB);	/* CHECKME */
 	nxt6000_writereg(fe, OFDM_SYR_CTL, 1 << 2);
 	nxt6000_writereg(fe, OFDM_PPM_CTL_1, PPM256);
 	nxt6000_writereg(fe, OFDM_TRL_NOMINALRATE_1, 0x49);
@@ -414,20 +352,20 @@
 
 static void nxt6000_dump_status(struct dvb_frontend *fe)
 {
-
 	u8 val;
 
-//	printk("RS_COR_STAT: 0x%02X\n", nxt6000_readreg(fe, RS_COR_STAT));
-//	printk("VIT_SYNC_STATUS: 0x%02X\n", nxt6000_readreg(fe, VIT_SYNC_STATUS));
-//	printk("OFDM_COR_STAT: 0x%02X\n", nxt6000_readreg(fe, OFDM_COR_STAT));
-//	printk("OFDM_SYR_STAT: 0x%02X\n", nxt6000_readreg(fe, OFDM_SYR_STAT));
-//	printk("OFDM_TPS_RCVD_1: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_1));
-//	printk("OFDM_TPS_RCVD_2: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_2));
-//	printk("OFDM_TPS_RCVD_3: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_3));
-//	printk("OFDM_TPS_RCVD_4: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_4));
-//	printk("OFDM_TPS_RESERVED_1: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RESERVED_1));
-//	printk("OFDM_TPS_RESERVED_2: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RESERVED_2));
-
+/*
+	printk("RS_COR_STAT: 0x%02X\n", nxt6000_readreg(fe, RS_COR_STAT));
+	printk("VIT_SYNC_STATUS: 0x%02X\n", nxt6000_readreg(fe, VIT_SYNC_STATUS));
+	printk("OFDM_COR_STAT: 0x%02X\n", nxt6000_readreg(fe, OFDM_COR_STAT));
+	printk("OFDM_SYR_STAT: 0x%02X\n", nxt6000_readreg(fe, OFDM_SYR_STAT));
+	printk("OFDM_TPS_RCVD_1: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_1));
+	printk("OFDM_TPS_RCVD_2: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_2));
+	printk("OFDM_TPS_RCVD_3: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_3));
+	printk("OFDM_TPS_RCVD_4: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RCVD_4));
+	printk("OFDM_TPS_RESERVED_1: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RESERVED_1));
+	printk("OFDM_TPS_RESERVED_2: 0x%02X\n", nxt6000_readreg(fe, OFDM_TPS_RESERVED_2));
+*/
 	printk("NXT6000 status:");
 
 	val = nxt6000_readreg(fe, RS_COR_STAT);
@@ -460,13 +392,11 @@
 			break;
 	
 		case 0x03: 
-		
 			printk(" VITERBI CODERATE: 5/6,");
+		break;
 
 		case 0x04: 
-		
 			printk(" VITERBI CODERATE: 7/8,");
-			
 			break;
 
 		default: 
@@ -503,13 +426,11 @@
 			break;
 	
 		case 0x04:
-		
 			printk(" CoreState: WAIT_PPM,");
+		break;
 
 		case 0x01:
-		
 			printk(" CoreState: WAIT_TRL,");
-			
 			break;
 
 		case 0x05:
@@ -586,13 +487,11 @@
 			break;
 	
 		case 0x03: 
-		
 			printk(" TPSLP: 5/6,");
+		break;
 
 		case 0x04: 
-		
 			printk(" TPSLP: 7/8,");
-			
 			break;
 
 		default: 
@@ -622,13 +514,11 @@
 			break;
 	
 		case 0x03: 
-		
 			printk(" TPSHP: 5/6,");
+		break;
 
 		case 0x04: 
-		
 			printk(" TPSHP: 7/8,");
-			
 			break;
 
 		default: 
@@ -669,7 +550,7 @@
 			
 	}
 	
-	// Strange magic required to gain access to RF_AGC_STATUS
+	/* Strange magic required to gain access to RF_AGC_STATUS */
 	nxt6000_readreg(fe, RF_AGC_VAL_1);
 	val = nxt6000_readreg(fe, RF_AGC_STATUS);
 	val = nxt6000_readreg(fe, RF_AGC_STATUS);
@@ -735,21 +611,23 @@
 	
 		case FE_READ_SIGNAL_STRENGTH:
 		{
-//			s16 *signal = (s16 *)arg;
-
-//		*signal=(((signed char)readreg(client, 0x16))+128)<<8;
-
+			s16 *signal = (s16 *) arg;
+/*
+			*signal=(((signed char)readreg(client, 0x16))+128)<<8;
+*/
+			*signal = 0;
 			return 0;
 			
 		}
 	
 		case FE_READ_SNR:
 		{
-//			s16 *snr = (s16 *)arg;
-
-//		*snr=readreg(client, 0x24)<<8;
-//		*snr|=readreg(client, 0x25);
-
+			s16 *snr = (s16 *) arg;
+/*
+			*snr=readreg(client, 0x24)<<8;
+			*snr|=readreg(client, 0x25);
+*/
+			*snr = 0;
 			break;
 		}
 	
@@ -831,70 +698,74 @@
 
 static int nxt6000_attach(struct dvb_i2c_bus *i2c, void **data)
 {
-
 	u8 addr_nr;
 	u8 fe_count = 0;
-	struct nxt6000_config nxt;
+	struct nxt6000_config *pnxt;
 
 	dprintk("nxt6000: attach\n");
 	
+	pnxt = kmalloc(sizeof(demod_addr_tbl)*sizeof(struct nxt6000_config), GFP_KERNEL);
+	if (NULL == pnxt) {
+		dprintk("nxt6000: no memory for private data.\n");
+		return -ENOMEM;
+	}
+	*data = pnxt;
+
 	for (addr_nr = 0; addr_nr < sizeof(demod_addr_tbl); addr_nr++) {
+		struct nxt6000_config *nxt = &pnxt[addr_nr];
 	
 		if (nxt6000_read(i2c, demod_addr_tbl[addr_nr], OFDM_MSC_REV) != NXT6000ASICDEVICE)
 			continue;
 
 		if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC0, NULL, 0) == 0) {
+			nxt->tuner_addr = 0xC0;
+			nxt->tuner_type = TUNER_TYPE_ALP510;
+			nxt->clock_inversion = 1;
 	
-			nxt.tuner_addr = 0xC0;
-			nxt.tuner_type = TUNER_TYPE_ALP510;
-			nxt.clock_inversion = 1;
-			
-			dprintk("nxt6000: detected TI ALP510 tuner at 0x%02X\n", nxt.tuner_addr);
+			dprintk("nxt6000: detected TI ALP510 tuner at 0x%02X\n", nxt->tuner_addr);
 		
 		} else if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC2, NULL, 0) == 0) {
+			nxt->tuner_addr = 0xC2;
+			nxt->tuner_type = TUNER_TYPE_SP5659;
+			nxt->clock_inversion = 0;
 
-			nxt.tuner_addr = 0xC2;
-			nxt.tuner_type = TUNER_TYPE_SP5659;
-			nxt.clock_inversion = 0;
-	
-			dprintk("nxt6000: detected MITEL SP5659 tuner at 0x%02X\n", nxt.tuner_addr);
+			dprintk("nxt6000: detected MITEL SP5659 tuner at 0x%02X\n", nxt->tuner_addr);
 		
 		} else if (pll_write(i2c, demod_addr_tbl[addr_nr], 0xC0, NULL, 0) == 0) {
+			nxt->tuner_addr = 0xC0;
+			nxt->tuner_type = TUNER_TYPE_SP5730;
+			nxt->clock_inversion = 0;
 
-			nxt.tuner_addr = 0xC0;
-			nxt.tuner_type = TUNER_TYPE_SP5730;
-			nxt.clock_inversion = 0;
-	
-			dprintk("nxt6000: detected SP5730 tuner at 0x%02X\n", nxt.tuner_addr);
+			dprintk("nxt6000: detected SP5730 tuner at 0x%02X\n", nxt->tuner_addr);
 		
 		} else {
-
 			printk("nxt6000: unable to detect tuner\n");
-
 			continue;	
-		
 		}
 		
-		nxt.demod_addr = demod_addr_tbl[addr_nr];
+		nxt->demod_addr = demod_addr_tbl[addr_nr];
 	  
 		dprintk("nxt6000: attached at %d:%d\n", i2c->adapter->num, i2c->id);
 	
-		dvb_register_frontend(nxt6000_ioctl, i2c, (void *)(*((u32 *)&nxt)), &nxt6000_info);
+		dvb_register_frontend(nxt6000_ioctl, i2c, (void *)nxt, &nxt6000_info);
 		
 		fe_count++;
 	}
 	
-	return (fe_count > 0) ? 0 : -ENODEV;
+	if (fe_count == 0) {
+		kfree(pnxt);
+		return -ENODEV;
+	}
 	
+	return 0;
 }
 
 static void nxt6000_detach(struct dvb_i2c_bus *i2c, void *data)
 {
-
+	struct nxt6000_config *pnxt = (struct nxt6000_config *)data;
 	dprintk("nxt6000: detach\n");
-
 	dvb_unregister_frontend(nxt6000_ioctl, i2c);
-	
+	kfree(pnxt);
 }
 
 static __init int nxt6000_init(void)
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/nxt6000.h linux-2.6.0.p/drivers/media/dvb/frontends/nxt6000.h
--- linux-2.6.0/drivers/media/dvb/frontends/nxt6000.h	2003-12-19 12:55:39.000000000 +0100
+++ linux-2.6.0.p/drivers/media/dvb/frontends/nxt6000.h	2003-11-12 15:12:54.000000000 +0100
@@ -1,45 +1,10 @@
-/**********************************************************************/
- * DRV6000reg.H
+/*
  * Public Include File for DRV6000 users
+ * (ie. NxtWave Communications - NXT6000 demodulator driver)
  *
  * Copyright (C) 2001 NxtWave Communications, Inc.
  *
- * $Log: nxt6000.h,v $
- * Revision 1.2  2003/01/27 12:32:42  fschirmer
- * Lots of bugfixes and new features
- *
- * Revision 1.1  2003/01/21 18:43:09  fschirmer
- * Nxt6000 based frontend driver
- *
- * Revision 1.1  2003/01/03 02:25:45  obi
- * alps tdme7 driver
- *
- * 
- *    Rev 1.10   Jun 12 2002 11:28:02   dkoeger
- * Updated for SA in GUi work
- * 
- *    Rev 1.9   Apr 01 2002 10:38:46   dkoeger
- * Updated for 1.0.31 GUI
- * 
- *    Rev 1.8   Mar 11 2002 10:04:56   dkoeger
- * Updated for 1.0.31 GUI version
- * 
- *    Rev 1.5   Dec 07 2001 14:40:40   dkoeger
- * Updated for 1.0.28 GUI
- * 
- *    Rev 1.4   Nov 13 2001 11:09:00   dkoeger
- * No change.
- * 
- *    Rev 1.3   Aug 23 2001 14:21:02   dkoeger
- * Updated for driver version 2.1.9
- * 
- *    Rev 1.2   Jul 09 2001 09:20:04   dkoeger
- * Updated for 1.0.18
- * 
- *    Rev 1.1   Jun 13 2001 16:14:24   dkoeger
- * Updated to reflect NXT6000 GUI BETA 1.0.11 6/13/2001
- **********************************************************************/
-
+ */
 
 /*  Nxt6000 Register Addresses and Bit Masks */
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/sp887x.c linux-2.6.0-p/drivers/media/dvb/frontends/sp887x.c
--- linux-2.6.0/drivers/media/dvb/frontends/sp887x.c	2003-12-18 03:59:17.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/sp887x.c	2003-12-08 16:19:00.000000000 +0100
@@ -1,8 +1,31 @@
+/*
+   Driver for the Microtune 7202D Frontend
+*/
+
+/*
+   This driver needs a copy of the Avermedia firmware. The version tested
+   is part of the Avermedia DVB-T 1.3.26.3 Application. If the software is
+   installed in Windows the file will be in the /Program Files/AVerTV DVB-T/
+   directory and is called sc_main.mc. Alternatively it can "extracted" from
+   the install cab files. Copy this file to /etc/dvb/sc_main.mc.
+   With this version of the file the first 10 bytes are discarded and the
+   next 0x4000 loaded. This may change in future versions.
+ */
 
+#define __KERNEL_SYSCALLS__
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/unistd.h>
+#include <linux/fcntl.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 
+
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
 
@@ -6,6 +29,11 @@
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
 
+#ifndef DVB_SP887X_FIRMWARE_FILE
+#define DVB_SP887X_FIRMWARE_FILE "/etc/dvb/sc_main.mc"
+#endif
+
+static char *sp887x_firmware = DVB_SP887X_FIRMWARE_FILE;
 
 #if 0
 #define dprintk(x...) printk(x)
@@ -39,7 +67,7 @@
 		FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_RECOVER
 };
 
-
+static int errno;
 
 static
 int i2c_writebytes (struct dvb_frontend *fe, u8 addr, u8 *buf, u8 len)
@@ -112,6 +140,7 @@
 static
 void sp887x_microcontroller_stop (struct dvb_frontend *fe)
 {
+	dprintk("%s\n", __FUNCTION__);
 	sp887x_writereg(fe, 0xf08, 0x000);
 	sp887x_writereg(fe, 0xf09, 0x000);		
 
@@ -123,6 +152,7 @@
 static
 void sp887x_microcontroller_start (struct dvb_frontend *fe)
 {
+	dprintk("%s\n", __FUNCTION__);
 	sp887x_writereg(fe, 0xf08, 0x000);
 	sp887x_writereg(fe, 0xf09, 0x000);		
 
@@ -135,6 +165,7 @@
 void sp887x_setup_agc (struct dvb_frontend *fe)
 {
 	/* setup AGC parameters */
+	dprintk("%s\n", __FUNCTION__);
 	sp887x_writereg(fe, 0x33c, 0x054);
 	sp887x_writereg(fe, 0x33b, 0x04c);
 	sp887x_writereg(fe, 0x328, 0x000);
@@ -152,8 +183,6 @@
 }
 
 
-#include "sp887x_firm.h"
-
 #define BLOCKSIZE 30
 
 /**
@@ -162,14 +191,63 @@
 static
 int sp887x_initial_setup (struct dvb_frontend *fe)
 {
-	u8 buf [BLOCKSIZE];
+	u8 buf [BLOCKSIZE+2];
+	unsigned char *firmware = NULL;
 	int i;
+	int fd;
+	int filesize;
+	int fw_size;
+	mm_segment_t fs;
+
+	dprintk("%s\n", __FUNCTION__);
 
 	/* soft reset */
 	sp887x_writereg(fe, 0xf1a, 0x000);
 
 	sp887x_microcontroller_stop (fe);
 
+	fs = get_fs();
+
+	// Load the firmware
+	set_fs(get_ds());
+	fd = open(sp887x_firmware, 0, 0);
+	if (fd < 0) {
+		printk(KERN_WARNING "%s: Unable to open firmware %s\n", __FUNCTION__,
+		       sp887x_firmware);
+		return -EIO;
+	}
+	filesize = lseek(fd, 0L, 2);
+	if (filesize <= 0) {
+		printk(KERN_WARNING "%s: Firmware %s is empty\n", __FUNCTION__,
+		       sp887x_firmware);
+		sys_close(fd);
+		return -EIO;
+	}
+
+	fw_size = 0x4000;
+
+	// allocate buffer for it
+	firmware = vmalloc(fw_size);
+	if (firmware == NULL) {
+		printk(KERN_WARNING "%s: Out of memory loading firmware\n",
+		       __FUNCTION__);
+		sys_close(fd);
+		return -EIO;
+	}
+
+	// read it!
+	// read the first 16384 bytes from the file
+	// ignore the first 10 bytes
+	lseek(fd, 10, 0);
+	if (read(fd, firmware, fw_size) != fw_size) {
+		printk(KERN_WARNING "%s: Failed to read firmware\n", __FUNCTION__);
+		vfree(firmware);
+		sys_close(fd);
+		return -EIO;
+	}
+	sys_close(fd);
+	set_fs(fs);
+
 	printk ("%s: firmware upload... ", __FUNCTION__);
 
 	/* setup write pointer to -1 (end of memory) */
@@ -179,12 +257,12 @@
 	/* dummy write (wrap around to start of memory) */
 	sp887x_writereg(fe, 0x8f0a, 0x0000);
 
-	for (i=0; i<sizeof(sp887x_firm); i+=BLOCKSIZE) {
+	for (i=0; i<fw_size; i+=BLOCKSIZE) {
 		int c = BLOCKSIZE;
 		int err;
 
-		if (i+c > sizeof(sp887x_firm))
-			c = sizeof(sp887x_firm) - i;
+		if (i+c > fw_size)
+			c = fw_size - i;
 
 		/* bit 0x8000 in address is set to enable 13bit mode */
 		/* bit 0x4000 enables multibyte read/write transfers */
@@ -192,15 +270,18 @@
 		buf[0] = 0xcf;
 		buf[1] = 0x0a;
 
-		memcpy(&buf[2], &sp887x_firm[i], c);
+		memcpy(&buf[2], firmware + i, c);
 
 		if ((err = i2c_writebytes (fe, 0x70, buf, c+2)) < 0) {
 			printk ("failed.\n");
 			printk ("%s: i2c error (err == %i)\n", __FUNCTION__, err);
+			vfree(firmware);
 			return err;
 		}
 	}
 
+	vfree(firmware);
+
 	/* don't write RS bytes between packets */
 	sp887x_writereg(fe, 0xc13, 0x001);
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/stv0299.c linux-2.6.0-p/drivers/media/dvb/frontends/stv0299.c
--- linux-2.6.0/drivers/media/dvb/frontends/stv0299.c	2003-12-18 03:59:58.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/stv0299.c	2003-11-20 09:44:03.000000000 +0100
@@ -9,16 +9,23 @@
 	<holger@convergence.de>,
 	<js@convergence.de>
     
+
     Philips SU1278/SH
 
-    Copyright (C) 2002 by Peter Schildmann
-        <peter.schildmann@web.de>
+    Copyright (C) 2002 by Peter Schildmann <peter.schildmann@web.de>
+
 
     LG TDQF-S001F
 
     Copyright (C) 2002 Felix Domke <tmbinc@elitedvb.net>
                      & Andreas Oberritter <andreas@oberritter.de>
 
+
+    Support for Samsung TBMU24112IMB used on Technisat SkyStar2 rev. 2.6B
+
+    Copyright (C) 2003 Vadim Catana <skystar@moldova.cc>:
+
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -39,6 +46,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <asm/div64.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
@@ -49,6 +57,11 @@
 #define dprintk(x...)
 #endif
 
+static int stv0299_status = 0;
+
+#define STATUS_BER 0
+#define STATUS_UCBLOCKS 1
+
 
 /* frontend types */
 #define UNKNOWN_FRONTEND  -1
@@ -56,6 +69,7 @@
 #define ALPS_BSRU6         1
 #define LG_TDQF_S001F      2
 #define PHILIPS_SU1278     3
+#define SAMSUNG_TBMU24112IMB    4
 
 /* Master Clock = 88 MHz */
 #define M_CLK (88000000UL) 
@@ -142,6 +156,51 @@
 };
 
 
+static u8 init_tab_samsung [] = {
+	0x01, 0x15,
+	0x02, 0x00,
+	0x03, 0x00,
+	0x04, 0x7D,
+	0x05, 0x35,
+	0x06, 0x02,
+	0x07, 0x00,
+	0x08, 0xC3,
+	0x0C, 0x00,
+	0x0D, 0x81,
+	0x0E, 0x23,
+	0x0F, 0x12,
+	0x10, 0x7E,
+	0x11, 0x84,
+	0x12, 0xB9,
+	0x13, 0x88,
+	0x14, 0x89,
+	0x15, 0xC9,
+	0x16, 0x00,
+	0x17, 0x5C,
+	0x18, 0x00,
+	0x19, 0x00,
+	0x1A, 0x00,
+	0x1C, 0x00,
+	0x1D, 0x00,
+	0x1E, 0x00,
+	0x1F, 0x3A,
+	0x20, 0x2E,
+	0x21, 0x80,
+	0x22, 0xFF,
+	0x23, 0xC1,
+	0x28, 0x00,
+	0x29, 0x1E,
+	0x2A, 0x14,
+	0x2B, 0x0F,
+	0x2C, 0x09,
+	0x2D, 0x05,
+	0x31, 0x1F,
+	0x32, 0x19,
+	0x33, 0xFE,
+	0x34, 0x93
+};
+
+
 static int stv0299_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
 {
 	int ret;
@@ -169,7 +228,8 @@
 	ret = i2c->xfer (i2c, msg, 2);
         
 	if (ret != 2) 
-		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
+		dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n",
+				__FUNCTION__, reg, ret);
 
 	return b1[0];
 }
@@ -193,18 +253,19 @@
 static int pll_write (struct dvb_i2c_bus *i2c, u8 addr, u8 *data, int len)
 {
 	int ret;
-	u8 rpt1 [] = { 0x05, 0xb5 };  /*  enable i2c repeater on stv0299  */
-	u8 rpt2 [] = { 0x05, 0x35 };  /*  disable i2c repeater on stv0299  */
-	struct i2c_msg msg [] = {{ .addr = 0x68, .flags = 0, .buf = rpt1, .len = 2 },
-			         { addr: addr, .flags = 0, .buf = data, .len = len },
-				 { .addr = 0x68, .flags = 0, .buf = rpt2, .len = 2 }};
+	struct i2c_msg msg = { addr: addr, .flags = 0, .buf = data, .len = len };
 
-	ret = i2c->xfer (i2c, msg, 3);
 
-	if (ret != 3)
-		printk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
+	stv0299_writereg(i2c, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
+
+	ret =  i2c->xfer (i2c, &msg, 1);
+
+	stv0299_writereg(i2c, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
 
-	return (ret != 3) ? ret : 0;
+	if (ret != 1)
+		dprintk("%s: i/o error (ret == %i)\n", __FUNCTION__, ret);
+
+	return (ret != 1) ? -1 : 0;
 }
 
 
@@ -213,23 +274,16 @@
 	u8 buf[4];
 	u32 div;
 
-	u32 ratios[] = { 2000, 1000, 500, 250, 125 };
-	u8 ratio;
+	div = freq / 125;
 
-	for (ratio = 4; ratio > 0; ratio--)
-		if ((freq / ratios[ratio]) <= 0x3fff)
-			break;
-
-	div = freq / ratios[ratio];
+	dprintk("%s : freq = %i, div = %i\n", __FUNCTION__, freq, div);
 
-	buf[0] = (freq >> 8) & 0x7f;
-	buf[1] = freq & 0xff;
-	buf[2] = 0x80 | ratio;
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = div & 0xff;
+	buf[2] = 0x84;	// 0xC4
+	buf[3] = 0x08;
 
-	if (freq < 1531000)
-		buf[3] = 0x10;
-	else
-		buf[3] = 0x00;
+	if (freq < 1500000) buf[3] |= 0x10;
 
 	return pll_write (i2c, 0x61, buf, sizeof(buf));
 }
@@ -238,21 +292,47 @@
  *   set up the downconverter frequency divisor for a 
  *   reference clock comparision frequency of 125 kHz.
  */
-static int tsa5059_set_tv_freq	(struct dvb_i2c_bus *i2c, u32 freq, int ftype)
+static int tsa5059_set_tv_freq	(struct dvb_i2c_bus *i2c, u32 freq, int ftype, int srate)
 {
-	u8 addr = (ftype == PHILIPS_SU1278SH) ? 0x60 : 0x61;
-        u32 div = freq / 125;
-	u8 buf[4] = { (div >> 8) & 0x7f, div & 0xff, 0x84 };
+	u8 addr;
+	u32 div;
+	u8 buf[4];
 
 	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
 
-	if (ftype == PHILIPS_SU1278SH)
-		/* activate f_xtal/f_comp signal output */
-		/* charge pump current C0/C1 = 00 */
-		buf[3] = 0x20;
-	else
-		buf[3] = freq > 1530000 ? 0xc0 : 0xc4;
+	if ((freq < 950000) || (freq > 2150000)) return -EINVAL;
 
+	// setup frequency divisor
+	div = freq / 1000;
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = div & 0xff;
+	buf[2] = 0x81 | ((div & 0x18000) >> 10);
+	buf[3] = 0;
+
+	// tuner-specific settings
+	switch(ftype) {
+	case PHILIPS_SU1278SH:
+		addr = 0x60;
+		buf[3] |= 0x20;
+
+		if (srate < 4000000) buf[3] |= 1;
+	   
+		if (freq <= 1250000) buf[3] |= 0;
+		else if (freq <= 1550000) buf[3] |= 0x40;
+		else if (freq <= 2050000) buf[3] |= 0x80;
+		else if (freq <= 2150000) buf[3] |= 0xC0;
+		break;
+
+	case ALPS_BSRU6:
+		addr = 0x61;
+		buf[3] |= 0xC0;
+	 	break;
+
+	default:
+		return -EINVAL;
+	}
+
+	// charge pump
 	return pll_write (i2c, addr, buf, sizeof(buf));
 }
 
@@ -385,12 +465,14 @@
 
 static int pll_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq, int ftype, int srate)
 {
-	if (ftype == LG_TDQF_S001F)
+	if (ftype == SAMSUNG_TBMU24112IMB)
+		return sl1935_set_tv_freq(i2c, freq, ftype);
+	else if (ftype == LG_TDQF_S001F)
 		return sl1935_set_tv_freq(i2c, freq, ftype);
 	else if (ftype == PHILIPS_SU1278)
 		return tua6100_set_tv_freq(i2c, freq, ftype, srate);
 	else
-		return tsa5059_set_tv_freq(i2c, freq, ftype);
+		return tsa5059_set_tv_freq(i2c, freq, ftype, srate);
 }
 
 #if 0
@@ -421,6 +503,19 @@
 
 	dprintk("stv0299: init chip\n");
 
+	switch(ftype) {
+	case SAMSUNG_TBMU24112IMB:
+		dprintk("%s: init stv0299 chip for Samsung TBMU24112IMB\n", __FUNCTION__);
+
+		for (i=0; i<sizeof(init_tab_samsung); i+=2)
+		{
+			dprintk("%s: reg == 0x%02x, val == 0x%02x\n", __FUNCTION__, init_tab_samsung[i], init_tab_samsung[i+1]);
+
+			stv0299_writereg (i2c, init_tab_samsung[i], init_tab_samsung[i+1]);
+		}
+		break;
+
+	default:
 	stv0299_writereg (i2c, 0x01, 0x15);
 	stv0299_writereg (i2c, 0x02, ftype == PHILIPS_SU1278 ? 0x00 : 0x30);
 	stv0299_writereg (i2c, 0x03, 0x00);
@@ -430,11 +525,23 @@
 
         /* AGC1 reference register setup */
 	if (ftype == PHILIPS_SU1278SH)
-	  stv0299_writereg (i2c, 0x0f, 0xd2);  /* Iagc = Inverse, m1 = 18 */
+		  stv0299_writereg (i2c, 0x0f, 0x92);  /* Iagc = Inverse, m1 = 18 */
 	else if (ftype == PHILIPS_SU1278)
-	  stv0299_writereg (i2c, 0x0f, 0x94);  /* Iagc = Inverse, m1 = 18 */
+		  stv0299_writereg (i2c, 0x0f, 0x94);  /* Iagc = Inverse, m1 = 20 */
 	else
 	  stv0299_writereg (i2c, 0x0f, 0x52);  /* Iagc = Normal,  m1 = 18 */
+		break;
+	}
+	
+	switch(stv0299_status) {
+	case STATUS_BER:
+		stv0299_writereg(i2c, 0x34, 0x93);
+		break;
+	
+	case STATUS_UCBLOCKS:
+		stv0299_writereg(i2c, 0x34, 0xB3);
+		break;
+	}
 
 	return 0;
 }
@@ -448,6 +555,7 @@
 		dvb_delay(30);
 		if ((stv0299_readreg (i2c, 0x1b) & 0x98) != 0x98) {
 		u8 val = stv0299_readreg (i2c, 0x0c);
+			dprintk ("%s : changing inversion\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x0c, val ^ 0x01);
 	}
 	}
@@ -462,21 +570,42 @@
 
 	switch (fec) {
 	case FEC_AUTO:
+	{
+		dprintk ("%s : FEC_AUTO\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x31, 0x1f);
+	}
 	case FEC_1_2:
+	{
+		dprintk ("%s : FEC_1_2\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x31, 0x01);
+	}
 	case FEC_2_3:
+	{
+		dprintk ("%s : FEC_2_3\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x31, 0x02);
+	}
 	case FEC_3_4:
+	{
+		dprintk ("%s : FEC_3_4\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x31, 0x04);
+	}
 	case FEC_5_6:
+	{
+		dprintk ("%s : FEC_5_6\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x31, 0x08);
+	}
 	case FEC_7_8:
+	{
+		dprintk ("%s : FEC_7_8\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x31, 0x10);
+	}
 	default:
+	{
+		dprintk ("%s : FEC invalid\n", __FUNCTION__);
 		return -EINVAL;
 	}
 }
+}
 
 
 static fe_code_rate_t stv0299_get_fec (struct dvb_i2c_bus *i2c)
@@ -606,11 +735,20 @@
 
 	switch (tone) {
 	case SEC_TONE_ON:
+	{
+	    	dprintk("%s: TONE_ON\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x08, val | 0x3);
+	}	
 	case SEC_TONE_OFF:
+	{
+	    	dprintk("%s: TONE_OFF\n", __FUNCTION__);
 		return stv0299_writereg (i2c, 0x08, (val & ~0x3) | 0x02);
+	}
 	default:
+	{
+	    	dprintk("%s: TONE INVALID\n", __FUNCTION__);
 		return -EINVAL;
+	}
 	};
 }
 
@@ -651,39 +789,60 @@
 }
 
 
-static int stv0299_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate)
+static int stv0299_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate, int tuner_type)
 {
+	u64 big = srate;
 	u32 ratio;
-	u32 tmp;
-	u8 aclk = 0xb4, bclk = 0x51;
+	u8 aclk = 0;
+	u8 bclk = 0;
+	u8 m1;
+
+	if ((srate < 1000000) || (srate > 45000000)) return -EINVAL;
+	switch(tuner_type) {
+	case PHILIPS_SU1278SH:
+		aclk = 0xb5;
+		if (srate < 2000000) bclk = 0x86;
+		else if (srate < 5000000) bclk = 0x89;
+		else if (srate < 15000000) bclk = 0x8f;
+		else if (srate < 45000000) bclk = 0x95;
+
+		m1 = 0x14;
+		if (srate < 4000000) m1 = 0x10;
+		break;
 
-	if (srate > M_CLK)
-		srate = M_CLK;
-        if (srate < 500000)
-		srate = 500000;
-
-	if (srate < 30000000) { aclk = 0xb6; bclk = 0x53; }
-	if (srate < 14000000) { aclk = 0xb7; bclk = 0x53; }
-	if (srate < 7000000) { aclk = 0xb7; bclk = 0x4f; }
-	if (srate < 3000000) { aclk = 0xb7; bclk = 0x4b; }
-	if (srate < 1500000) { aclk = 0xb7; bclk = 0x47; }
-
-#define FIN (M_CLK >> 4)
+	case ALPS_BSRU6:
+	default:
+		if (srate <= 1500000) { aclk = 0xb7; bclk = 0x87; }
+		else if (srate <= 3000000) { aclk = 0xb7; bclk = 0x8b; }
+		else if (srate <= 7000000) { aclk = 0xb7; bclk = 0x8f; }
+		else if (srate <= 14000000) { aclk = 0xb7; bclk = 0x93; }
+		else if (srate <= 30000000) { aclk = 0xb6; bclk = 0x93; }
+		else if (srate <= 45000000) { aclk = 0xb4; bclk = 0x91; }
 
-	tmp = srate << 4;
-	ratio = tmp / FIN;
+		m1 = 0x12;
+		break;   
+	}
         
-	tmp = (tmp % FIN) << 8;
-	ratio = (ratio << 8) + tmp / FIN;
+	dprintk("%s : big = 0x%08x%08x\n", __FUNCTION__, (int) ((big>>32) & 0xffffffff),  (int) (big & 0xffffffff) );
         
-	tmp = (tmp % FIN) << 8;
-	ratio = (ratio << 8) + tmp / FIN;
+	big = big << 20;
+
+	dprintk("%s : big = 0x%08x%08x\n", __FUNCTION__, (int) ((big>>32) & 0xffffffff),  (int) (big & 0xffffffff) );
+
+	do_div(big, M_CLK);
+
+	dprintk("%s : big = 0x%08x%08x\n", __FUNCTION__, (int) ((big>>32) & 0xffffffff),  (int) (big & 0xffffffff) );
+
+	ratio = big << 4;
+
+	dprintk("%s : ratio = %i\n", __FUNCTION__, ratio);
   
 	stv0299_writereg (i2c, 0x13, aclk);
 	stv0299_writereg (i2c, 0x14, bclk);
 	stv0299_writereg (i2c, 0x1f, (ratio >> 16) & 0xff);
 	stv0299_writereg (i2c, 0x20, (ratio >>  8) & 0xff);
 	stv0299_writereg (i2c, 0x21, (ratio      ) & 0xf0);
+	stv0299_writereg (i2c, 0x0f, (stv0299_readreg(i2c, 0x0f) & 0xc0) | m1);
 
 	return 0;
 }
@@ -710,6 +869,9 @@
 	offset = (s32) rtf * (srate / 4096L);
 	offset /= 128;
 
+	dprintk ("%s : srate = %i\n", __FUNCTION__, srate);
+	dprintk ("%s : ofset = %i\n", __FUNCTION__, offset);
+
 	srate += offset;
 
 	srate += 1000;
@@ -725,6 +887,8 @@
         int tuner_type = (long) fe->data;
 	struct dvb_i2c_bus *i2c = fe->i2c;
 
+	dprintk ("%s\n", __FUNCTION__);
+
 	switch (cmd) {
 	case FE_GET_INFO:
 		memcpy (arg, &uni0299_info, sizeof(struct dvb_frontend_info));
@@ -736,7 +900,7 @@
 		u8 signal = 0xff - stv0299_readreg (i2c, 0x18);
 		u8 sync = stv0299_readreg (i2c, 0x1b);
 
-		dprintk ("VSTATUS: 0x%02x\n", sync);
+		dprintk ("%s : FE_READ_STATUS : VSTATUS: 0x%02x\n", __FUNCTION__, sync);
 
 		*status = 0;
 
@@ -759,8 +923,12 @@
 	}
 
         case FE_READ_BER:
+		if (stv0299_status == STATUS_BER) {
 		*((u32*) arg) = (stv0299_readreg (i2c, 0x1d) << 8)
 			       | stv0299_readreg (i2c, 0x1e);
+		} else {
+			*((u32*) arg) = 0;
+		}
 		break;
 
 	case FE_READ_SIGNAL_STRENGTH:
@@ -768,7 +936,7 @@
 		s32 signal =  0xffff - ((stv0299_readreg (i2c, 0x18) << 8)
 			               | stv0299_readreg (i2c, 0x19));
 
-		dprintk ("AGC2I: 0x%02x%02x, signal=0x%04x\n",
+		dprintk ("%s : FE_READ_SIGNAL_STRENGTH : AGC2I: 0x%02x%02x, signal=0x%04x\n", __FUNCTION__,
 			 stv0299_readreg (i2c, 0x18),
 			 stv0299_readreg (i2c, 0x19), (int) signal);
 
@@ -787,18 +955,25 @@
 		break;
 	}
 	case FE_READ_UNCORRECTED_BLOCKS: 
-		*((u32*) arg) = 0;    /* the stv0299 can't measure BER and */
-		return -EOPNOTSUPP;   /* errors at the same time.... */
+		if (stv0299_status == STATUS_UCBLOCKS) {
+			*((u32*) arg) = (stv0299_readreg (i2c, 0x1d) << 8)
+			               | stv0299_readreg (i2c, 0x1e);
+		} else {
+			*((u32*) arg) = 0;
+		}
+		break;
 
         case FE_SET_FRONTEND:
         {
 		struct dvb_frontend_parameters *p = arg;
 
+		dprintk ("%s : FE_SET_FRONTEND\n", __FUNCTION__);
+
 		pll_set_tv_freq (i2c, p->frequency, tuner_type,
 				 p->u.qpsk.symbol_rate);
 
                 stv0299_set_FEC (i2c, p->u.qpsk.fec_inner);
-                stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate);
+                stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate, tuner_type);
 		stv0299_writereg (i2c, 0x22, 0x00);
 		stv0299_writereg (i2c, 0x23, 0x00);
 		stv0299_readreg (i2c, 0x23);
@@ -859,6 +1034,8 @@
 
 static long probe_tuner (struct dvb_i2c_bus *i2c)
 {
+	struct dvb_adapter * adapter = (struct dvb_adapter *) i2c->adapter;
+
         /* read the status register of TSA5059 */
 	u8 rpt[] = { 0x05, 0xb5 };
         u8 stat [] = { 0 };
@@ -875,6 +1052,17 @@
 	stv0299_writereg (i2c, 0x02, 0x30);
 	stv0299_writereg (i2c, 0x03, 0x00);
 
+
+	printk ("%s: try to attach to %s\n", __FUNCTION__, adapter->name);
+
+	if ( strcmp(adapter->name, "Technisat SkyStar2 driver") == 0 )
+	{
+	    printk ("%s: setup for tuner Samsung TBMU24112IMB\n", __FILE__);
+
+    	    return SAMSUNG_TBMU24112IMB;
+	}
+
+
 	if ((ret = i2c->xfer(i2c, msg1, 2)) == 2) {
 		printk ("%s: setup for tuner SU1278/SH\n", __FILE__);
 		return PHILIPS_SU1278SH;
@@ -961,3 +1148,5 @@
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter");
 MODULE_LICENSE("GPL");
 
+MODULE_PARM(stv0299_status, "i");
+MODULE_PARM_DESC(stv0299_status, "Which status value to support (0: BER, 1: UCBLOCKS)");
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/tda1004x.c linux-2.6.0-p/drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.0/drivers/media/dvb/frontends/tda1004x.c	2003-12-18 03:57:59.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/tda1004x.c	2003-11-12 12:34:57.000000000 +0100
@@ -108,7 +108,7 @@
 	.frequency_min = 51000000,
 	.frequency_max = 858000000,
 	.frequency_stepsize = 166667,
-	.caps = FE_CAN_INVERSION_AUTO |
+	.caps =
 	    FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 	    FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
 	    FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/frontends/ves1820.c linux-2.6.0-p/drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.0/drivers/media/dvb/frontends/ves1820.c	2003-12-18 03:58:50.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/frontends/ves1820.c	2003-12-08 16:19:00.000000000 +0100
@@ -19,6 +19,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */    
 
+#include <linux/config.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -70,7 +72,18 @@
 #define GET_TUNER(data) ((u8) (((long) data >> 16) & 0xff))
 #define GET_DEMOD_ADDR(data) ((u8) (((long) data >> 24) & 0xff))
 
+#if defined(CONFIG_DBOX2)
+#define XIN 69600000UL
+#define DISABLE_INVERSION(reg0)		do { reg0 &= ~0x20; } while (0)
+#define ENABLE_INVERSION(reg0)		do { reg0 |= 0x20; } while (0)
+#define HAS_INVERSION(reg0)		(reg0 & 0x20)
+#else	/* PCI cards */
 #define XIN 57840000UL
+#define DISABLE_INVERSION(reg0)		do { reg0 |= 0x20; } while (0)
+#define ENABLE_INVERSION(reg0)		do { reg0 &= ~0x20; } while (0)
+#define HAS_INVERSION(reg0)		(!(reg0 & 0x20))
+#endif
+
 #define FIN (XIN >> 4)
 
 
@@ -209,9 +222,9 @@
 	reg0 |= GET_REG0(fe->data) & 0x62;
 	
 	if (INVERSION_ON == inversion)
-		reg0 &= ~0x20;
+		ENABLE_INVERSION(reg0);
 	else if (INVERSION_OFF == inversion)
-		reg0 |= 0x20;
+		DISABLE_INVERSION(reg0);
 	
 	ves1820_writereg (fe, 0x00, reg0 & 0xfe);
         ves1820_writereg (fe, 0x00, reg0 | 0x01);
@@ -220,7 +233,7 @@
 	 *  check lock and toggle inversion bit if required...
 	 */
 	if (INVERSION_AUTO == inversion && !(ves1820_readreg (fe, 0x11) & 0x08)) {
-		dvb_delay(10);
+		mdelay(30);
 		if (!(ves1820_readreg (fe, 0x11) & 0x08)) {
 			reg0 ^= 0x20;
 			ves1820_writereg (fe, 0x00, reg0 & 0xfe);
@@ -242,6 +255,10 @@
 
         ves1820_writereg (fe, 0, 0);
 
+#if defined(CONFIG_DBOX2)
+	ves1820_inittab[2] &= ~0x08;
+#endif
+
 	for (i=0; i<53; i++)
                 ves1820_writereg (fe, i, ves1820_inittab[i]);
 
@@ -330,6 +347,10 @@
 
 	ves1820_setup_reg0 (fe, reg0x00[real_qam], p->inversion);
 
+	/* yes, this speeds things up: userspace reports lock in about 8 ms
+	   instead of 500 to 1200 ms after calling FE_SET_FRONTEND. */
+	mdelay(30);
+
 	return 0;
 }
 
@@ -419,14 +440,14 @@
 					fe->i2c->adapter->num, afc,
 				-((s32)(p->u.qam.symbol_rate >> 3) * afc >> 7));
 
-		p->inversion = reg0 & 0x20 ? INVERSION_OFF : INVERSION_ON;
+		p->inversion = HAS_INVERSION(reg0) ? INVERSION_ON : INVERSION_OFF;
 		p->u.qam.modulation = ((reg0 >> 2) & 7) + QAM_16;
 
 		p->u.qam.fec_inner = FEC_NONE;
 
 		p->frequency = ((p->frequency + 31250) / 62500) * 62500;
-		// To prevent overflow, shift symbol rate first a
-		// couple of bits.
+		/* To prevent overflow, shift symbol rate first a
+		   couple of bits. */
 		p->frequency -= (s32)(p->u.qam.symbol_rate >> 3) * afc >> 7;
 		break;
 	}
@@ -462,8 +483,6 @@
 		printk ("DVB: VES1820(%d): setup for tuner sp5659c\n", i2c->adapter->num);
 	} else {
 		type = -1;
-		printk ("DVB: VES1820(%d): unknown PLL, "
-			"please report to <linuxdvb@linuxtv.org>!!\n", i2c->adapter->num);
 	}
 
 	return type;
@@ -477,13 +496,11 @@
 	struct i2c_msg msg [] = { { .addr = 0x50, .flags = 0, .buf = &b, .len = 1 },
 			 { .addr = 0x50, .flags = I2C_M_RD, .buf = &pwm, .len = 1 } };
 
-	i2c->xfer (i2c, msg, 2);
+	if ((i2c->xfer(i2c, msg, 2) != 2) || (pwm == 0xff))
+		pwm = 0x48;
 
 	printk("DVB: VES1820(%d): pwm=0x%02x\n", i2c->adapter->num, pwm);
 
-	if (pwm == 0xff)
-		pwm = 0x48;
-
 	return pwm;
 }
 
@@ -516,8 +533,7 @@
 	if ((demod_addr = probe_demod_addr(i2c)) < 0)
 		return -ENODEV;
 
-	if ((tuner_type = probe_tuner(i2c)) < 0)
-		return -ENODEV;
+	tuner_type = probe_tuner(i2c);
 
 	if ((i2c->adapter->num < MAX_UNITS) && pwm[i2c->adapter->num] != -1) {
 		printk("DVB: VES1820(%d): pwm=0x%02x (user specified)\n",


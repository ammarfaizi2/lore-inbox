Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbULJP4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbULJP4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULJP4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:56:45 -0500
Received: from mail.convergence.de ([212.227.36.84]:51870 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261740AbULJPja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:39:30 -0500
Message-ID: <41B9C300.5080904@linuxtv.org>
Date: Fri, 10 Dec 2004 16:38:40 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][5/6] frontend update
Content-Type: multipart/mixed;
 boundary="------------050701070808060801040004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050701070808060801040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050701070808060801040004
Content-Type: text/plain;
 name="05-dvb-frontends.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-dvb-frontends.diff"

- [DVB] dib3000: support for dynamically i2c addresses of the demod
- [DVB] tda1004x: fixed firmware upload problems, forgot to include tune_settings for tda1004x, added setting to allow inversion of OCLK, set fesettings->min_delay_ms = 800 as suggested by Peter Siering
- [DVB] stv0297: code cleanup
- [DVB] mt312: added vp310 support
- [DVB] mt352: decrease verbosity

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/mt312.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/mt312.c	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/mt312.c	2004-11-30 15:26:47.000000000 +0100
@@ -393,7 +393,7 @@
 {
 	struct mt312_state *state = (struct mt312_state*) fe->demodulator_priv;
 	int ret;
-	u8 status[3], vit_mode;
+	u8 status[3];
 
 	*s = 0;
 
@@ -413,17 +413,6 @@
 	if (status[0] & 0x01)
 		*s |= FE_HAS_LOCK;	/* qpsk lock */
 
-	// VP310 doesn't have AUTO, so we "implement it here" ACCJr
-	if ((state->id == ID_VP310) && !(status[0] & 0x01)) {
-		if ((ret = mt312_readreg(state, VIT_MODE, &vit_mode)) < 0)
-			return ret;
-		vit_mode ^= 0x40;
-		if ((ret = mt312_writereg(state, VIT_MODE, vit_mode)) < 0)
-                	return ret;
-		if ((ret = mt312_writereg(state, GO, 0x01)) < 0)
-                	return ret;
-	}
-
 	return 0;
 }
 
@@ -638,61 +627,88 @@
 	kfree(state);
 }
 
-static struct dvb_frontend_ops mt312_ops;
+static struct dvb_frontend_ops vp310_mt312_ops;
 
-struct dvb_frontend* mt312_attach(const struct mt312_config* config,
+struct dvb_frontend* vp310_attach(const struct mt312_config* config,
 				  struct i2c_adapter* i2c)
 {
 	struct mt312_state* state = NULL;
 
 	/* allocate memory for the internal state */
 	state = (struct mt312_state*) kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		goto error;
 
 	/* setup the state */
 	state->config = config;
 	state->i2c = i2c;
-	memcpy(&state->ops, &mt312_ops, sizeof(struct dvb_frontend_ops));
+	memcpy(&state->ops, &vp310_mt312_ops, sizeof(struct dvb_frontend_ops));
+	strcpy(state->ops.info.name, "Zarlink VP310 DVB-S");
 
 	/* check if the demod is there */
-	if (mt312_readreg(state, ID, &state->id) < 0) goto error;
-	switch(state->id) {
-	case ID_VP310:
+	if (mt312_readreg(state, ID, &state->id) < 0)
+		goto error;
+	if (state->id != ID_VP310) {
+		goto error;
+	}
+
+	/* create dvb_frontend */
 		state->frequency = 90;
-		printk("mt312: Detected Zarlink VP310\n");
-		break;
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
 
-	case ID_MT312:
-		state->frequency = 60;
-		printk("mt312: Detected Zarlink MT312\n");
-		break;
+error:
+	if (state)
+		kfree(state);
+	return NULL;
+}
 
-	default:
+struct dvb_frontend* mt312_attach(const struct mt312_config* config,
+				  struct i2c_adapter* i2c)
+{
+	struct mt312_state* state = NULL;
+
+	/* allocate memory for the internal state */
+	state = (struct mt312_state*) kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &vp310_mt312_ops, sizeof(struct dvb_frontend_ops));
+	strcpy(state->ops.info.name, "Zarlink MT312 DVB-S");
+
+	/* check if the demod is there */
+	if (mt312_readreg(state, ID, &state->id) < 0)
+		goto error;
+	if (state->id != ID_MT312) {
 		goto error;
 }
 
 	/* create dvb_frontend */
+	state->frequency = 60;
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	if (state)
+		kfree(state);
 	return NULL;
 }
 
-static struct dvb_frontend_ops mt312_ops = {
+static struct dvb_frontend_ops vp310_mt312_ops = {
 
 	.info = {
-		.name = "Zarlink VP310/MT312 DVB-S",
+		.name = "Zarlink ???? DVB-S",
 		.type = FE_QPSK,
 		.frequency_min = 950000,
 		.frequency_max = 2150000,
 		.frequency_stepsize = (MT312_PLL_CLK / 1000) / 128,
-		/*.frequency_tolerance = 29500,         FIXME: binary compatibility waste? */
 		.symbol_rate_min = MT312_SYS_CLK / 128,
 		.symbol_rate_max = MT312_SYS_CLK / 2,
-		/*.symbol_rate_tolerance = 500,         FIXME: binary compatibility waste? 2% */
 		.caps =
 		    FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
 		    FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
@@ -729,3 +745,4 @@
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(mt312_attach);
+EXPORT_SYMBOL(vp310_attach);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/mt312.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/mt312.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/mt312.h	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/mt312.h	2004-11-30 15:26:47.000000000 +0100
@@ -41,4 +41,7 @@
 extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
 					 struct i2c_adapter* i2c);
 
+extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
+					 struct i2c_adapter* i2c);
+
 #endif // MT312_H
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/mt352.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/mt352.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/mt352.c	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/mt352.c	2004-11-30 15:26:47.000000000 +0100
@@ -65,8 +65,7 @@
 			       .buf = ibuf, .len = ilen };
 	int err = i2c_transfer(state->i2c, &msg, 1);
 	if (err != 1) {
-		printk(KERN_WARNING
-		       "mt352_write() failed (err = %d)!\n", err);
+		dprintk("mt352_write() failed (err = %d)!\n", err);
 		return err;
 }
 
@@ -88,8 +87,7 @@
 	ret = i2c_transfer(state->i2c, msg, 2);
 
 	if (ret != 2)
-		printk(KERN_WARNING
-		       "%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
+		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
 
 	return b1[0];
 }
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/stv0297.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/stv0297.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/stv0297.c	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/stv0297.c	2004-11-30 15:26:47.000000000 +0100
@@ -51,7 +49,7 @@
 #define dprintk(x...)
 #endif
 
-#define STV0297_CLOCK   28900
+#define STV0297_CLOCK_KHZ   28900
 
 static u8 init_tab [] = {
   0x00, 0x09,
@@ -78,7 +76,7 @@
   0x40, 0x1c,
   0x41, 0xff,
   0x42, 0x29,
-  0x43, 0x00,// check
+	0x43, 0x00,
   0x44, 0xff,
   0x45, 0x00,
   0x46, 0x00,
@@ -167,13 +165,11 @@
 
         // this device needs a STOP between the register and data
         if ((ret = i2c_transfer (state->i2c, &msg[0], 1)) != 1) {
-                dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n",
-                        __FUNCTION__, reg, ret);
+		dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n", __FUNCTION__, reg, ret);
                 return -1;
         }
         if ((ret = i2c_transfer (state->i2c, &msg[1], 1)) != 1) {
-                dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n",
-                        __FUNCTION__, reg, ret);
+		dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n", __FUNCTION__, reg, ret);
                 return -1;
         }
 
@@ -200,59 +196,38 @@
 
         // this device needs a STOP between the register and data
         if ((ret = i2c_transfer (state->i2c, &msg[0], 1)) != 1) {
-                dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n",
-                        __FUNCTION__, reg1, ret);
+		dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n", __FUNCTION__, reg1, ret);
                 return -1;
         }
         if ((ret = i2c_transfer (state->i2c, &msg[1], 1)) != 1) {
-                dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n",
-                        __FUNCTION__, reg1, ret);
+		dprintk("%s: readreg error (reg == 0x%02x, ret == %i)\n", __FUNCTION__, reg1, ret);
                 return -1;
         }
 
         return 0;
 }
 
-static int stv0297_set_symbolrate (struct stv0297_state* state, u32 srate)
+static void stv0297_set_symbolrate(struct stv0297_state *state, u32 srate)
 {
-        u64 tmp;
+	long tmp;
 
-        tmp = srate;
-        tmp <<= 32;
-        do_div(tmp, STV0297_CLOCK);
+	tmp = 131072L * srate;	/* 131072 = 2^17  */
+	tmp = tmp / (STV0297_CLOCK_KHZ / 4);	/* 1/4 = 2^-2 */
+	tmp = tmp * 8192L;	/* 8192 = 2^13 */
 
         stv0297_writereg (state, 0x55,(unsigned char)(tmp & 0xFF));
         stv0297_writereg (state, 0x56,(unsigned char)(tmp>> 8));
         stv0297_writereg (state, 0x57,(unsigned char)(tmp>>16));
         stv0297_writereg (state, 0x58,(unsigned char)(tmp>>24));
-
-        return 0;
-}
-
-static u32 stv0297_get_symbolrate (struct stv0297_state* state)
-{
-        u64 tmp;
-
-        tmp = stv0297_readreg(state, 0x55);
-        tmp |= (stv0297_readreg(state, 0x56) << 8);
-        tmp |= (stv0297_readreg(state, 0x57) << 16);
-        tmp |= (stv0297_readreg(state, 0x57) << 24);
-
-        tmp *= STV0297_CLOCK;
-        tmp >>= 32;
-        return tmp;
 }
 
-static void stv0297_set_sweeprate(struct stv0297_state* state, short fshift)
+static void stv0297_set_sweeprate(struct stv0297_state *state, short fshift, long symrate)
 {
-        s64 tmp;
-        u32 symrate;
-
-        symrate = stv0297_get_symbolrate(state);
+	long tmp;
 
-        // cannot use shifts - it is signed
-        tmp = fshift * (1<<28);
-        do_div(tmp, symrate);
+	tmp = (long) fshift *262144L;	/* 262144 = 2*18 */
+	tmp /= symrate;
+	tmp *= 1024;		/* 1024 = 2*10   */
 
         // adjust
         if (tmp >= 0) {
@@ -260,68 +235,61 @@
         } else {
                 tmp -= 500000;
         }
-        do_div(tmp, 1000000);
+	tmp /= 1000000;
 
         stv0297_writereg(state, 0x60, tmp & 0xFF);
         stv0297_writereg_mask(state, 0x69, 0xF0, (tmp >> 4) & 0xf0);
-
-        return;
 }
 
 static void stv0297_set_carrieroffset(struct stv0297_state* state, long offset)
 {
-        long long_tmp;
+	long tmp;
 
-        // symrate is hardcoded to 10000 here - don't ask me why
-        long_tmp = offset * 26844L ; /* (2**28)/10000 */
-        if(long_tmp < 0) long_tmp += 0x10000000 ;
-        long_tmp &= 0x0FFFFFFF ;
-
-        stv0297_writereg (state,0x66,(unsigned char)(long_tmp & 0xFF));    // iphase0
-        stv0297_writereg (state,0x67,(unsigned char)(long_tmp>>8));        // iphase1
-        stv0297_writereg (state,0x68,(unsigned char)(long_tmp>>16));       // iphase2
-        stv0297_writereg_mask(state, 0x69, 0x0F, (long_tmp >> 24) & 0x0f);
-
-        return;
+	/* symrate is hardcoded to 10000 */
+	tmp = offset * 26844L;	/* (2**28)/10000 */
+	if (tmp < 0)
+		tmp += 0x10000000;
+	tmp &= 0x0FFFFFFF;
+
+	stv0297_writereg(state, 0x66, (unsigned char) (tmp & 0xFF));
+	stv0297_writereg(state, 0x67, (unsigned char) (tmp >> 8));
+	stv0297_writereg(state, 0x68, (unsigned char) (tmp >> 16));
+	stv0297_writereg_mask(state, 0x69, 0x0F, (tmp >> 24) & 0x0f);
 }
 
 static long stv0297_get_carrieroffset(struct stv0297_state* state)
 {
         s32 raw;
-        s64 tmp;
-        u32 symbol_rate;
+	long tmp;
 
         stv0297_writereg(state,0x6B, 0x00);
 
-        symbol_rate = stv0297_get_symbolrate(state);
-
         raw =   stv0297_readreg(state,0x66);
         raw |= (stv0297_readreg(state,0x67) << 8);
         raw |= (stv0297_readreg(state,0x68) << 16);
         raw |= (stv0297_readreg(state,0x69) & 0x0F) << 24;
 
-        // cannot just use a shift here 'cos it is signed
         tmp = raw;
-        tmp *= symbol_rate;
-        do_div(tmp, 1<<28);
+	tmp /= 26844L;
 
-        return (s32) tmp;
+	return tmp;
 }
 
 static void stv0297_set_initialdemodfreq(struct stv0297_state* state, long freq)
 {
-        u64 tmp;
+/*
+        s64 tmp;
 
-        if (freq > 10000) freq -= STV0297_CLOCK;
-        if (freq < 0) freq = 0;
+        if (freq > 10000) freq -= STV0297_CLOCK_KHZ;
 
         tmp = freq << 16;
-        do_div(tmp, STV0297_CLOCK);
-        if (tmp > 0xffff) tmp = 0xffff;
+        do_div(tmp, STV0297_CLOCK_KHZ);
+        if (tmp > 0xffff) tmp = 0xffff; // check this calculation
 
         stv0297_writereg_mask(state, 0x25, 0x80, 0x80);
         stv0297_writereg(state, 0x21, tmp >> 8);
         stv0297_writereg(state, 0x20, tmp);
+*/
 }
 
 static int stv0297_set_qam(struct stv0297_state* state, fe_modulation_t modulation)
@@ -407,26 +375,38 @@
         struct stv0297_state* state = (struct stv0297_state*) fe->demodulator_priv;
         int i;
 
+	/* soft reset */
         stv0297_writereg_mask(state, 0x80, 1, 1);
         stv0297_writereg_mask(state, 0x80, 1, 0);
+
+	/* reset deinterleaver */
         stv0297_writereg_mask(state, 0x81, 1, 1);
         stv0297_writereg_mask(state, 0x81, 1, 0);
 
+	/* load init table */
         for (i=0; i<sizeof(init_tab); i+=2) {
                 stv0297_writereg (state, init_tab[i], init_tab[i+1]);
         }
 
+	/* set a dummy symbol rate */
         stv0297_set_symbolrate(state, 6900);
+
+	/* invert AGC1 polarity */
         stv0297_writereg_mask(state, 0x88, 0x10, 0x10);
+
+	/* setup bit error counting */
         stv0297_writereg_mask(state, 0xA0, 0x80, 0x00);
         stv0297_writereg_mask(state, 0xA0, 0x10, 0x00);
         stv0297_writereg_mask(state, 0xA0, 0x08, 0x00);
         stv0297_writereg_mask(state, 0xA0, 0x07, 0x04);
+
+	/* min + max PWM */
         stv0297_writereg(state, 0x4a, 0x00);
         stv0297_writereg(state, 0x4b, state->pwm);
         msleep(200);
 
-        if (state->config->pll_init) state->config->pll_init(fe);
+	if (state->config->pll_init)
+		state->config->pll_init(fe);
 
         return 0;
 }
@@ -439,7 +419,8 @@
 
         *status = 0;
         if (sync & 0x80)
-                *status |= FE_HAS_SYNC | FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_LOCK;
+		*status |=
+			FE_HAS_SYNC | FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_LOCK;
         return 0;
 }
 
@@ -497,7 +478,6 @@
         int initial_u;
         int blind_u;
         int delay;
-        int locked;
         int sweeprate;
         int carrieroffset;
         unsigned long starttime;
@@ -542,9 +522,13 @@
 
         state->config->pll_set(fe, p);
 
-        // reset everything
-        stv0297_writereg_mask(state, 0x82, 0x4, 0x4);
+	/* clear software interrupts */
+	stv0297_writereg(state, 0x82, 0x0);
+
+	/* set initial demodulation frequency */
         stv0297_set_initialdemodfreq(state, state->freq_off + 7250);
+
+	/* setup AGC */
         stv0297_writereg_mask(state, 0x43, 0x10, 0x00);
         stv0297_writereg(state, 0x41, 0x00);
         stv0297_writereg_mask(state, 0x42, 0x03, 0x01);
@@ -556,16 +540,26 @@
         stv0297_writereg_mask(state, 0x74, 0x0F, 0x00);
         stv0297_writereg_mask(state, 0x43, 0x08, 0x00);
         stv0297_writereg_mask(state, 0x71, 0x80, 0x00);
+
+	/* setup STL */
         stv0297_writereg_mask(state, 0x5a, 0x20, 0x20);
         stv0297_writereg_mask(state, 0x5b, 0x02, 0x02);
         stv0297_writereg_mask(state, 0x5b, 0x02, 0x00);
         stv0297_writereg_mask(state, 0x5b, 0x01, 0x00);
         stv0297_writereg_mask(state, 0x5a, 0x40, 0x40);
+
+	/* disable frequency sweep */
         stv0297_writereg_mask(state, 0x6a, 0x01, 0x00);
+
+	/* reset deinterleaver */
         stv0297_writereg_mask(state, 0x81, 0x01, 0x01);
         stv0297_writereg_mask(state, 0x81, 0x01, 0x00);
+
+	/* ??? */
         stv0297_writereg_mask(state, 0x83, 0x20, 0x20);
         stv0297_writereg_mask(state, 0x83, 0x20, 0x00);
+
+	/* reset equaliser */
         u_threshold = stv0297_readreg(state, 0x00) & 0xf;
         initial_u = stv0297_readreg(state, 0x01) >> 4;
         blind_u = stv0297_readreg(state, 0x01) & 0xf;
@@ -574,7 +568,11 @@
         stv0297_writereg_mask(state, 0x00, 0x0f, u_threshold);
         stv0297_writereg_mask(state, 0x01, 0xf0, initial_u << 4);
         stv0297_writereg_mask(state, 0x01, 0x0f, blind_u);
+
+	/* data comes from internal A/D */
         stv0297_writereg_mask(state, 0x87, 0x80, 0x00);
+
+	/* clear phase registers */
         stv0297_writereg(state, 0x63, 0x00);
         stv0297_writereg(state, 0x64, 0x00);
         stv0297_writereg(state, 0x65, 0x00);
@@ -583,14 +581,14 @@
         stv0297_writereg(state, 0x68, 0x00);
         stv0297_writereg_mask(state, 0x69, 0x0f, 0x00);
 
-        // set parameters
+	/* set parameters */
         stv0297_set_qam(state, p->u.qam.modulation);
         stv0297_set_symbolrate(state, p->u.qam.symbol_rate/1000);
-        stv0297_set_sweeprate(state, sweeprate);
+	stv0297_set_sweeprate(state, sweeprate, p->u.qam.symbol_rate / 1000);
         stv0297_set_carrieroffset(state, carrieroffset);
         stv0297_set_inversion(state, p->inversion);
 
-        // kick off lock
+	/* kick off lock */
         stv0297_writereg_mask(state, 0x88, 0x08, 0x08);
         stv0297_writereg_mask(state, 0x5a, 0x20, 0x00);
         stv0297_writereg_mask(state, 0x6a, 0x01, 0x01);
@@ -600,33 +598,33 @@
         stv0297_writereg_mask(state, 0x03, 0x03, 0x03);
         stv0297_writereg_mask(state, 0x43, 0x10, 0x10);
 
-        // wait for WGAGC lock
+	/* wait for WGAGC lock */
         starttime = jiffies;
         timeout = jiffies + (200*HZ)/1000;
         while(time_before(jiffies, timeout)) {
                 msleep(10);
-                if (stv0297_readreg(state, 0x43) & 0x08) break;
+		if (stv0297_readreg(state, 0x43) & 0x08)
+			break;
         }
         if (time_after(jiffies, timeout)) {
                 goto timeout;
         }
         msleep(20);
 
-        // wait for equaliser partial convergence
-        locked = 0;
+	/* wait for equaliser partial convergence */
         timeout = jiffies + (50*HZ)/1000;
         while(time_before(jiffies, timeout)) {
                 msleep(10);
 
                 if (stv0297_readreg(state, 0x82) & 0x04) {
-                        locked = 1;
+			break;
                 }
         }
-        if (time_after(jiffies, timeout) && (!locked)) {
+	if (time_after(jiffies, timeout)) {
                 goto timeout;
         }
 
-        // wait for equaliser full convergence
+	/* wait for equaliser full convergence */
         timeout = jiffies + (delay*HZ)/1000;
         while(time_before(jiffies, timeout)) {
                 msleep(10);
@@ -639,11 +637,11 @@
                 goto timeout;
         }
 
-        // disable sweep
+	/* disable sweep */
         stv0297_writereg_mask(state, 0x6a, 1, 0);
         stv0297_writereg_mask(state, 0x88, 8, 0);
 
-        // wait for main lock
+	/* wait for main lock */
         timeout = jiffies + (20*HZ)/1000;
         while(time_before(jiffies, timeout)) {
                 msleep(10);
@@ -657,12 +655,12 @@
         }
         msleep(100);
 
-        // is it still locked after that delay?
+	/* is it still locked after that delay? */
         if (!(stv0297_readreg(state, 0xDF) & 0x80)) {
                 goto timeout;
         }
 
-        // success!!
+	/* success!! */
         stv0297_writereg_mask(state, 0x5a, 0x40, 0x00);
         state->freq_off = stv0297_get_carrieroffset(state);
         state->base_freq = p->frequency;
@@ -683,15 +681,25 @@
 
         p->frequency = state->base_freq + state->freq_off;
         p->inversion = (reg_83 & 0x08) ? INVERSION_ON : INVERSION_OFF;
-        p->u.qam.symbol_rate = stv0297_get_symbolrate(state);
+	p->u.qam.symbol_rate = 0;
         p->u.qam.fec_inner = 0;
 
         switch((reg_00 >> 4) & 0x7) {
-        case 0: p->u.qam.modulation = QAM_16; break;
-        case 1: p->u.qam.modulation = QAM_32; break;
-        case 2: p->u.qam.modulation = QAM_128; break;
-        case 3: p->u.qam.modulation = QAM_256; break;
-        case 4: p->u.qam.modulation = QAM_64; break;
+	case 0:
+		p->u.qam.modulation = QAM_16;
+		break;
+	case 1:
+		p->u.qam.modulation = QAM_32;
+		break;
+	case 2:
+		p->u.qam.modulation = QAM_128;
+		break;
+	case 3:
+		p->u.qam.modulation = QAM_256;
+		break;
+	case 4:
+		p->u.qam.modulation = QAM_64;
+		break;
         }
 
         return 0;
@@ -706,14 +714,14 @@
 static struct dvb_frontend_ops stv0297_ops;
 
 struct dvb_frontend* stv0297_attach(const struct stv0297_config* config,
-                                    struct i2c_adapter* i2c,
-                                    int pwm)
+				    struct i2c_adapter *i2c, int pwm)
 {
         struct stv0297_state* state = NULL;
 
         /* allocate memory for the internal state */
         state = (struct stv0297_state*) kmalloc(sizeof(struct stv0297_state), GFP_KERNEL);
-        if (state == NULL) goto error;
+	if (state == NULL)
+		goto error;
 
         /* setup the state */
         state->config = config;
@@ -724,7 +732,8 @@
         state->pwm = pwm;
 
         /* check if the demod is there */
-        if ((stv0297_readreg(state, 0x80) & 0x70) != 0x20) goto error;
+	if ((stv0297_readreg(state, 0x80) & 0x70) != 0x20)
+		goto error;
 
         /* create dvb_frontend */
         state->frontend.ops = &state->ops;
@@ -732,7 +741,8 @@
         return &state->frontend;
 
 error:
-        if (state) kfree(state);
+	if (state)
+		kfree(state);
         return NULL;
 }
 
@@ -747,10 +757,7 @@
                 .symbol_rate_min	= 870000,
                 .symbol_rate_max	= 11700000,
                 .caps = FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 |
-                        FE_CAN_QAM_128 | FE_CAN_QAM_256 |
-                        FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO |
-                        FE_CAN_RECOVER
-        },
+		 FE_CAN_QAM_128 | FE_CAN_QAM_256 | FE_CAN_FEC_AUTO},
 
         .release = stv0297_release,
 
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/tda1004x.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/tda1004x.c	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/tda1004x.c	2004-12-08 14:45:06.000000000 +0100
@@ -393,6 +393,11 @@
 	int ret;
 	const struct firmware *fw;
 
+	/* reset + wake up chip */
+	tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 0);
+	tda1004x_write_mask(state, TDA10046H_CONF_TRISTATE1, 1, 0);
+	msleep(100);
+
 	/* don't re-upload unless necessary */
 	if (tda1004x_check_upload_ok(state, 0x20) == 0) return 0;
 
@@ -404,11 +409,6 @@
    	   	return ret;
 	}
 
-	/* reset chip */
-	tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 0);
-	tda1004x_write_mask(state, TDA10046H_CONF_TRISTATE1, 1, 0);
-	msleep(10);
-
 	/* set parameters */
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10);
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 0);
@@ -533,6 +533,8 @@
 	tda1004x_write_mask(state, TDA1004X_CONFC1, 0x10, 0); // VAGC polarity
 	tda1004x_write_byteI(state, TDA1004X_CONFADC1, 0x2e);
 
+	tda1004x_write_mask(state, 0x1f, 0x01, state->config->invert_oclk);
+
 	state->initialised = 1;
 	return 0;
 		}
@@ -585,6 +587,8 @@
 	tda1004x_write_mask(state, TDA10046H_GPIO_SELECT, 8, 8); // GPIO select
 	tda10046h_set_bandwidth(state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
 
+	tda1004x_write_mask(state, 0x3a, 0x80, state->config->invert_oclk << 7);
+
 	state->initialised = 1;
 	return 0;
 }
@@ -616,12 +620,13 @@
 	if (state->demod_type == TDA1004X_DEMOD_TDA10046)
 		tda1004x_write_mask(state, TDA10046H_AGC_CONF, 4, 4);
 
-	// Hardcoded to use auto as much as possible
-	// The TDA10045 is very unreliable if AUTO mode is _not_ used. I have not
-	// yet tested the TDA10046 to see if this issue has been fixed
+	// Hardcoded to use auto as much as possible on the TDA10045 as it
+	// is very unreliable if AUTO mode is _not_ used.
+	if (state->demod_type == TDA1004X_DEMOD_TDA10045) {
 	fe_params->u.ofdm.code_rate_HP = FEC_AUTO;
 	fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_AUTO;
 	fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_AUTO;
+	}
 
 	// Set standard params.. or put them to auto
 	if ((fe_params->u.ofdm.code_rate_HP == FEC_AUTO) ||
@@ -1170,6 +1175,7 @@
 
 	.set_frontend = tda1004x_set_fe,
 	.get_frontend = tda1004x_get_fe,
+	.get_tune_settings = tda1004x_get_tune_settings,
 
 	.read_status = tda1004x_read_status,
 	.read_ber = tda1004x_read_ber,
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/tda1004x.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/tda1004x.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/tda1004x.h	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/tda1004x.h	2004-11-30 15:26:47.000000000 +0100
@@ -34,6 +34,9 @@
 	/* does the "inversion" need inverted? */
 	u8 invert:1;
 
+	/* Does the OCLK signal need inverted? */
+	u8 invert_oclk:1;
+
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);

--------------050701070808060801040004--

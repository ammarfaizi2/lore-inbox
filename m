Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUIQPCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUIQPCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUIQPCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:02:38 -0400
Received: from mail.convergence.de ([212.227.36.84]:65440 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268817AbUIQOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:34:24 -0400
Message-ID: <414AF5BF.4020401@linuxtv.org>
Date: Fri, 17 Sep 2004 16:33:35 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][8/14] some more frontend drivers to converted to
 kernel i2c
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org>
In-Reply-To: <414AF569.2020803@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------000909020206060707070202"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909020206060707070202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000909020206060707070202
Content-Type: text/plain;
 name="08-DVB-frontend-conversion4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="08-DVB-frontend-conversion4.diff"

- [DVB] nxt6000, sp887x: convert from dvb-i2c to kernel-i2c, MODULE_PARM() to module_param(), dvb_delay() to mdelay()
- [DVB] sp887x: move from home-brewn firmware loading to firmware_class

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/nxt6000.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/nxt6000.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/nxt6000.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/nxt6000.c	2004-08-18 19:52:17.000000000 +0200
@@ -36,11 +34,11 @@
 #include "dvb_frontend.h"
 #include "nxt6000.h"
 
-static int debug = 0;
-
 MODULE_DESCRIPTION("NxtWave NXT6000 DVB demodulator driver");
 MODULE_AUTHOR("Florian Schirmer");
 MODULE_LICENSE("GPL");
+
+static int debug = 0;
 MODULE_PARM(debug, "i");
 
 static struct dvb_frontend_info nxt6000_info = {
@@ -68,20 +65,21 @@
 	u8 tuner_addr;
 	u8 tuner_type;
 	u8 clock_inversion;
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
 };
 
 #define TUNER_TYPE_ALP510	0
 #define TUNER_TYPE_SP5659	1
 #define TUNER_TYPE_SP5730	2
 
-#define FE2NXT(fe) ((struct nxt6000_config *)((fe)->data))
+// #define FE2NXT(fe) ((struct nxt6000_config *)((fe)->data))
 #define FREQ2DIV(freq) ((freq + 36166667) / 166667)
 
 #define dprintk if (debug) printk
 
-static int nxt6000_write(struct dvb_i2c_bus *i2c, u8 addr, u8 reg, u8 data)
+static int nxt6000_write(struct i2c_adapter *i2c, u8 addr, u8 reg, u8 data)
 {
-
 	u8 buf[] = {reg, data};
 	struct i2c_msg msg = {.addr = addr >> 1, .flags = 0, .buf = buf, .len = 2};
 	int ret;
@@ -86,7 +84,7 @@
 	struct i2c_msg msg = {.addr = addr >> 1, .flags = 0, .buf = buf, .len = 2};
 	int ret;
 	
-	if ((ret = i2c->xfer(i2c, &msg, 1)) != 1)
+	if ((ret = i2c_transfer(i2c, &msg, 1)) != 1)
 		dprintk("nxt6000: nxt6000_write error (.addr = 0x%02X, reg: 0x%02X, data: 0x%02X, ret: %d)\n", addr, reg, data, ret);
 
 	return (ret != 1) ? -EFAULT : 0;
@@ -90,21 +88,15 @@
 		dprintk("nxt6000: nxt6000_write error (.addr = 0x%02X, reg: 0x%02X, data: 0x%02X, ret: %d)\n", addr, reg, data, ret);
 
 	return (ret != 1) ? -EFAULT : 0;
-	
 }
 
-static u8 nxt6000_writereg(struct dvb_frontend *fe, u8 reg, u8 data)
+static u8 nxt6000_writereg(struct nxt6000_config *nxt, u8 reg, u8 data)
 {
-
-	struct nxt6000_config *nxt = FE2NXT(fe);
-
-	return nxt6000_write(fe->i2c, nxt->demod_addr, reg, data);
-
+	return nxt6000_write(nxt->i2c, nxt->demod_addr, reg, data);
 }
 
-static u8 nxt6000_read(struct dvb_i2c_bus *i2c, u8 addr, u8 reg)
+static u8 nxt6000_read(struct i2c_adapter *i2c, u8 addr, u8 reg)
 {
-
 	int ret;
 	u8 b0[] = {reg};
 	u8 b1[] = {0};
@@ -113,7 +105,7 @@
 		{.addr = addr >> 1,.flags = I2C_M_RD,.buf = b1,.len = 1}
 	};
 
-	ret = i2c->xfer(i2c, msgs, 2);
+	ret = i2c_transfer(i2c, msgs, 2);
 	
 	if (ret != 2)
 		dprintk("nxt6000: nxt6000_read error (.addr = 0x%02X, reg: 0x%02X, ret: %d)\n", addr, reg, ret);
@@ -119,33 +111,28 @@
 		dprintk("nxt6000: nxt6000_read error (.addr = 0x%02X, reg: 0x%02X, ret: %d)\n", addr, reg, ret);
 	
 	return b1[0];
-
 }
 
-static u8 nxt6000_readreg(struct dvb_frontend *fe, u8 reg)
+static u8 nxt6000_readreg(struct nxt6000_config *nxt, u8 reg)
 {
-
-	struct nxt6000_config *nxt = FE2NXT(fe);
-
-	return nxt6000_read(fe->i2c, nxt->demod_addr, reg);
+	return nxt6000_read(nxt->i2c, nxt->demod_addr, reg);
 }
 
-static int pll_test(struct dvb_i2c_bus *i2c, u8 demod_addr, u8 tuner_addr)
+static int pll_test(struct i2c_adapter *i2c, u8 demod_addr, u8 tuner_addr)
 {
 	u8 buf [1];
 	struct i2c_msg msg = {.addr = tuner_addr >> 1,.flags = I2C_M_RD,.buf = buf,.len = 1 };
 	int ret;
 
 	nxt6000_write(i2c, demod_addr, ENABLE_TUNER_IIC, 0x01);	/* open i2c bus switch */
-	ret = i2c->xfer(i2c, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 	nxt6000_write(i2c, demod_addr, ENABLE_TUNER_IIC, 0x00);	/* close i2c bus switch */
 
 	return (ret != 1) ? -EFAULT : 0;
 }
 
-static int pll_write(struct dvb_i2c_bus *i2c, u8 demod_addr, u8 tuner_addr, u8 *buf, u8 len)
+static int pll_write(struct i2c_adapter *i2c, u8 demod_addr, u8 tuner_addr, u8 * buf, u8 len)
 {
-
 	struct i2c_msg msg = {.addr = tuner_addr >> 1, .flags = 0, .buf = buf, .len = len};
 	int ret;
 				
@@ -150,7 +137,7 @@
 	int ret;
 				
 	nxt6000_write(i2c, demod_addr, ENABLE_TUNER_IIC, 0x01);		/* open i2c bus switch */
-	ret = i2c->xfer(i2c, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 	nxt6000_write(i2c, demod_addr, ENABLE_TUNER_IIC, 0x00);		/* close i2c bus switch */
 										
 	if (ret != 1)
@@ -157,14 +144,11 @@
 		dprintk("nxt6000: pll_write error %d\n", ret);
 																
 	return (ret != 1) ? -EFAULT : 0;
-
 }
 
-static int sp5659_set_tv_freq(struct dvb_frontend *fe, u32 freq)
+static int sp5659_set_tv_freq(struct nxt6000_config *nxt, u32 freq)
 {
-
 	u8 buf[4];
-	struct nxt6000_config *nxt = FE2NXT(fe);
 
 	buf[0] = (FREQ2DIV(freq) >> 8) & 0x7F;
 	buf[1] = FREQ2DIV(freq) & 0xFF;
@@ -179,15 +163,12 @@
 	else
 		return -EINVAL;
 
-	return pll_write(fe->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
-	
+	return pll_write(nxt->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
 }
 
-static int alp510_set_tv_freq(struct dvb_frontend *fe, u32 freq)
+static int alp510_set_tv_freq(struct nxt6000_config *nxt, u32 freq)
 {
-
 	u8 buf[4];
-	struct nxt6000_config *nxt = FE2NXT(fe);
 
 	buf[0] = (FREQ2DIV(freq) >> 8) & 0x7F;
 	buf[1] = FREQ2DIV(freq) & 0xFF;
@@ -217,15 +198,12 @@
 		return -EINVAL;
 #endif
 
-	return pll_write(fe->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
-	
+	return pll_write(nxt->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
 }
 
-static int sp5730_set_tv_freq(struct dvb_frontend *fe, u32 freq)
+static int sp5730_set_tv_freq(struct nxt6000_config *nxt, u32 freq)
 {
-
 	u8 buf[4];
-	struct nxt6000_config *nxt = FE2NXT(fe);
 
 	buf[0] = (FREQ2DIV(freq) >> 8) & 0x7F;
 	buf[1] = FREQ2DIV(freq) & 0xFF;
@@ -250,13 +228,11 @@
 	else
 		return -EINVAL;
 
-	return pll_write(fe->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
-	
+	return pll_write(nxt->i2c, nxt->demod_addr, nxt->tuner_addr, buf, 4);
 }
 
-static void nxt6000_reset(struct dvb_frontend *fe)
+static void nxt6000_reset(struct nxt6000_config *fe)
 {
-
 	u8 val;
 
 	val = nxt6000_readreg(fe, OFDM_COR_CTL);
@@ -263,12 +239,10 @@
 	
 	nxt6000_writereg(fe, OFDM_COR_CTL, val & ~COREACT);
 	nxt6000_writereg(fe, OFDM_COR_CTL, val | COREACT);
-	
 }
 
-static int nxt6000_set_bandwidth(struct dvb_frontend *fe, fe_bandwidth_t bandwidth)
+static int nxt6000_set_bandwidth(struct nxt6000_config *fe, fe_bandwidth_t bandwidth)
 {
-
 	u16 nominal_rate;
 	int result;
 
@@ -302,12 +268,10 @@
 		return result;
 		
 	return nxt6000_writereg(fe, OFDM_TRL_NOMINALRATE_2, (nominal_rate >> 8) & 0xFF);
-		
 }
 
-static int nxt6000_set_guard_interval(struct dvb_frontend *fe, fe_guard_interval_t guard_interval)
+static int nxt6000_set_guard_interval(struct nxt6000_config *fe, fe_guard_interval_t guard_interval)
 {
-
 	switch(guard_interval) {
 	
 		case GUARD_INTERVAL_1_32:
@@ -328,16 +288,12 @@
 			return nxt6000_writereg(fe, OFDM_COR_MODEGUARD, 0x03 | (nxt6000_readreg(fe, OFDM_COR_MODEGUARD) & ~0x03));
 			
 		default:
-		
 			return -EINVAL;
-
 	}
-
 }
 
-static int nxt6000_set_inversion(struct dvb_frontend *fe, fe_spectral_inversion_t inversion)
+static int nxt6000_set_inversion(struct nxt6000_config *fe, fe_spectral_inversion_t inversion)
 {
-
 	switch(inversion) {
 	
 		case INVERSION_OFF:
@@ -353,12 +306,10 @@
 			return -EINVAL;	
 	
 	}
-
 }
 
-static int nxt6000_set_transmission_mode(struct dvb_frontend *fe, fe_transmit_mode_t transmission_mode)
+static int nxt6000_set_transmission_mode(struct nxt6000_config *fe, fe_transmit_mode_t transmission_mode)
 {
-
 	int result;
 
 	switch(transmission_mode) {
@@ -383,14 +331,10 @@
 			return -EINVAL;
 	
 	}
-
 }
 
-static void nxt6000_setup(struct dvb_frontend *fe)
+static void nxt6000_setup(struct nxt6000_config *fe)
 {
-
-	struct nxt6000_config *nxt = FE2NXT(fe);
-
 	nxt6000_writereg(fe, RS_COR_SYNC_PARAM, SYNC_PARAM);
 	nxt6000_writereg(fe, BER_CTRL, /*(1 << 2) |*/ (0x01 << 1) | 0x01);
 	nxt6000_writereg(fe, VIT_COR_CTL, VIT_COR_RESYNC);
@@ -409,7 +353,7 @@
 	nxt6000_writereg(fe, EN_DMD_RACQ, (1 << 7) | (3 << 4) | 2);
 	nxt6000_writereg(fe, DIAG_CONFIG, TB_SET);
 	
-	if (nxt->clock_inversion)
+	if (fe->clock_inversion)
 		nxt6000_writereg(fe, SUB_DIAG_MODE_SEL, CLKINVERSION);
 	else
 		nxt6000_writereg(fe, SUB_DIAG_MODE_SEL, 0);
@@ -415,10 +359,9 @@
 		nxt6000_writereg(fe, SUB_DIAG_MODE_SEL, 0);
 		
 	nxt6000_writereg(fe, TS_FORMAT, 0);
-
 }
 
-static void nxt6000_dump_status(struct dvb_frontend *fe)
+static void nxt6000_dump_status(struct nxt6000_config *fe)
 {
 	u8 val;
 
@@ -673,13 +567,12 @@
 	val = nxt6000_readreg(fe, RF_AGC_STATUS);
 
 	printk(" RF AGC LOCK: %d,", (val >> 4) & 0x01);
-
 	printk("\n");
-	
 }
 
-static int nxt6000_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
+static int nxt6000_ioctl(struct dvb_frontend *f, unsigned int cmd, void *arg)
 {
+	struct nxt6000_config *fe = (struct nxt6000_config *) f->data;
 
 	switch (cmd) {
 
@@ -769,17 +659,14 @@
 
 		case FE_SET_FRONTEND:
 		{
-			struct nxt6000_config *nxt = FE2NXT(fe);
 			struct dvb_frontend_parameters *param = (struct dvb_frontend_parameters *)arg;
 			int result;
 
-			switch(nxt->tuner_type) {
+			switch (fe->tuner_type) {
 			
 				case TUNER_TYPE_ALP510:
-
 					if ((result = alp510_set_tv_freq(fe, param->frequency)) < 0)
 						return result;
-						
 					break;
 
 				case TUNER_TYPE_SP5659:
@@ -826,42 +705,41 @@
 
 static u8 demod_addr_tbl[] = {0x14, 0x18, 0x24, 0x28};
 
-static int nxt6000_attach(struct dvb_i2c_bus *i2c, void **data)
+static struct i2c_client client_template;
+
+static int attach_adapter(struct i2c_adapter *adapter)
 {
+	struct i2c_client *client;
+	struct nxt6000_config *nxt;
 	u8 addr_nr;
-	u8 fe_count = 0;
-	struct nxt6000_config *pnxt;
-
-	dprintk("nxt6000: attach\n");
+	int ret;
 	
-	pnxt = kmalloc(sizeof(demod_addr_tbl)*sizeof(struct nxt6000_config), GFP_KERNEL);
-	if (NULL == pnxt) {
-		dprintk("nxt6000: no memory for private data.\n");
+	if ((nxt = kmalloc(sizeof(struct nxt6000_config), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	}
-	*data = pnxt;
+
+	memset(nxt, 0, sizeof(*nxt));
+	nxt->i2c = adapter;
 
 	for (addr_nr = 0; addr_nr < sizeof(demod_addr_tbl); addr_nr++) {
-		struct nxt6000_config *nxt = &pnxt[addr_nr];
 	
-		if (nxt6000_read(i2c, demod_addr_tbl[addr_nr], OFDM_MSC_REV) != NXT6000ASICDEVICE)
+		if (nxt6000_read(adapter, demod_addr_tbl[addr_nr], OFDM_MSC_REV) != NXT6000ASICDEVICE)
 			continue;
 
-		if (pll_test(i2c, demod_addr_tbl[addr_nr], 0xC0) == 0) {
+		if (pll_test(adapter, demod_addr_tbl[addr_nr], 0xC0) == 0) {
 			nxt->tuner_addr = 0xC0;
 			nxt->tuner_type = TUNER_TYPE_ALP510;
 			nxt->clock_inversion = 1;
 	
 			dprintk("nxt6000: detected TI ALP510 tuner at 0x%02X\n", nxt->tuner_addr);
 		
-		} else if (pll_test(i2c, demod_addr_tbl[addr_nr], 0xC2) == 0) {
+		} else if (pll_test(adapter, demod_addr_tbl[addr_nr], 0xC2) == 0) {
 			nxt->tuner_addr = 0xC2;
 			nxt->tuner_type = TUNER_TYPE_SP5659;
 			nxt->clock_inversion = 0;
 
 			dprintk("nxt6000: detected MITEL SP5659 tuner at 0x%02X\n", nxt->tuner_addr);
 		
-		} else if (pll_test(i2c, demod_addr_tbl[addr_nr], 0xC0) == 0) {
+		} else if (pll_test(adapter, demod_addr_tbl[addr_nr], 0xC0) == 0) {
 			nxt->tuner_addr = 0xC0;
 			nxt->tuner_type = TUNER_TYPE_SP5730;
 			nxt->clock_inversion = 0;
@@ -872,48 +750,99 @@
 			printk("nxt6000: unable to detect tuner\n");
 			continue;	
 		}
-		
-		nxt->demod_addr = demod_addr_tbl[addr_nr];
-	  
-		dprintk("nxt6000: attached at %d:%d\n", i2c->adapter->num, i2c->id);
-	
-		dvb_register_frontend(nxt6000_ioctl, i2c, (void *)nxt, &nxt6000_info);
-		
-		fe_count++;
 	}
 	
-	if (fe_count == 0) {
-		kfree(pnxt);
+	if (addr_nr == sizeof(demod_addr_tbl)) {
+		kfree(nxt);
 		return -ENODEV;
 	}
 	
-	return 0;
+	nxt->demod_addr = demod_addr_tbl[addr_nr];
+
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		kfree(nxt);
+		return -ENOMEM;
 }
 
-static void nxt6000_detach(struct dvb_i2c_bus *i2c, void *data)
-{
-	struct nxt6000_config *pnxt = (struct nxt6000_config *)data;
-	dprintk("nxt6000: detach\n");
-	dvb_unregister_frontend(nxt6000_ioctl, i2c);
-	kfree(pnxt);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = demod_addr_tbl[addr_nr];
+	i2c_set_clientdata(client, (void *) nxt);
+
+	ret = i2c_attach_client(client);
+	if (ret) 
+		goto out;
+
+	BUG_ON(!nxt->dvb);
+
+	ret = dvb_register_frontend(nxt6000_ioctl, nxt->dvb, nxt, &nxt6000_info, THIS_MODULE);
+	if (ret) {
+		i2c_detach_client(client);
+		goto out;
+	}
+
+	ret = 0;
+out:
+	kfree(client);
+	kfree(nxt);
+	return ret;
+}
+
+static int detach_client(struct i2c_client *client)
+{
+	struct nxt6000_config *state = (struct nxt6000_config *) i2c_get_clientdata(client);
+	dvb_unregister_frontend_new(nxt6000_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
 }
 
-static __init int nxt6000_init(void)
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
+	struct nxt6000_config *state = (struct nxt6000_config *) i2c_get_clientdata(client);
 
-	dprintk("nxt6000: init\n");
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
+}
 	
-	return dvb_register_i2c_device(THIS_MODULE, nxt6000_attach, nxt6000_detach);
+static struct i2c_driver driver = {
+	.owner = THIS_MODULE,
+	.name = "nxt6000",
+	.id = I2C_DRIVERID_DVBFE_NXT6000,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client = detach_client,
+	.command = command,
+};
 	
+static struct i2c_client client_template = {
+	I2C_DEVNAME("nxt6000"),
+	.flags = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
+};
+
+static __init int nxt6000_init(void)
+{
+	return i2c_add_driver(&driver);
 }
 
 static __exit void nxt6000_exit(void)
 {
-
-	dprintk("nxt6000: cleanup\n");
-
-	dvb_unregister_i2c_device(nxt6000_attach);
-
+	if (i2c_del_driver(&driver))
+		printk("nxt6000: driver deregistration failed\n");
 }
 
 module_init(nxt6000_init);
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/sp887x.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/sp887x.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/sp887x.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/sp887x.c	2004-08-22 23:25:49.000000000 +0200
@@ -5,40 +5,36 @@
 /*
    This driver needs a copy of the Avermedia firmware. The version tested
    is part of the Avermedia DVB-T 1.3.26.3 Application. If the software is
-   installed in Windows the file will be in the /Program Files/AVerTV DVB-T/
+   installed in Windoze the file will be in the /Program Files/AVerTV DVB-T/
    directory and is called sc_main.mc. Alternatively it can "extracted" from
-   the install cab files. Copy this file to '/usr/lib/hotplug/firmware/sc_main.mc'.
+   the install cab files.
+   
+   Copy this file to '/usr/lib/hotplug/firmware/dvb-fe-sp887x.fw'.
+   
    With this version of the file the first 10 bytes are discarded and the
    next 0x4000 loaded. This may change in future versions.
  */
+#define SP887X_DEFAULT_FIRMWARE "dvb-fe-sp887x.fw"
 
-#include <linux/kernel.h>
-#include <linux/vmalloc.h>
-#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/unistd.h>
-#include <linux/fcntl.h>
-#include <linux/errno.h>
-#include <linux/i2c.h>
-#include <linux/syscalls.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
 
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
-#ifndef DVB_SP887X_FIRMWARE_FILE
-#define DVB_SP887X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/sc_main.mc"
-#endif
+#define FRONTEND_NAME "dvbfe_sp887x"
 
-static char *sp887x_firmware = DVB_SP887X_FIRMWARE_FILE;
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
 
-#if 0
-#define dprintk(x...) printk(x)
-#else
-#define dprintk(x...)
-#endif
+static int debug;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
 #if 0
 #define LOG(dir,addr,buf,len) 					\
@@ -53,9 +49,7 @@
 #define LOG(dir,addr,buf,len)
 #endif
 
-
-static
-struct dvb_frontend_info sp887x_info = {
+static struct dvb_frontend_info sp887x_info = {
 	.name = "Microtune MT7202DTF",
 	.type = FE_OFDM,
 	.frequency_min =  50500000,
@@ -67,18 +61,19 @@
                 FE_CAN_RECOVER
 };
 
-static int errno;
+struct sp887x_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
 
-static
-int i2c_writebytes (struct dvb_frontend *fe, u8 addr, u8 *buf, u8 len)
+static int i2c_writebytes (struct i2c_adapter *i2c, u8 addr, u8 *buf, u8 len)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
 	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = len };
 	int err;
 
 	LOG("i2c_writebytes", msg.addr, msg.buf, msg.len);
 
-	if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
+	if ((err = i2c_transfer (i2c, &msg, 1)) != 1) {
 		printk ("%s: i2c write error (addr %02x, err == %i)\n",
 			__FUNCTION__, addr, err);
 		return -EREMOTEIO;
@@ -87,19 +82,15 @@
 	return 0;
 }
 
-
-
-static
-int sp887x_writereg (struct dvb_frontend *fe, u16 reg, u16 data)
+static int sp887x_writereg (struct i2c_adapter *i2c, u16 reg, u16 data)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
 	u8 b0 [] = { reg >> 8 , reg & 0xff, data >> 8, data & 0xff };
 	struct i2c_msg msg = { .addr = 0x70, .flags = 0, .buf = b0, .len = 4 };
 	int ret;
 
 	LOG("sp887x_writereg", msg.addr, msg.buf, msg.len);
 
-	if ((ret = i2c->xfer(i2c, &msg, 1)) != 1) {
+	if ((ret = i2c_transfer(i2c, &msg, 1)) != 1) {
 		/**
 		 *  in case of soft reset we ignore ACK errors...
 		 */
@@ -116,11 +107,8 @@
 	return 0;
 }
 
-
-static
-u16 sp887x_readreg (struct dvb_frontend *fe, u16 reg)
+static u16 sp887x_readreg (struct i2c_adapter *i2c, u16 reg)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
 	u8 b1 [2];
 	int ret;
@@ -130,15 +118,13 @@
 	LOG("sp887x_readreg (w)", msg[0].addr, msg[0].buf, msg[0].len);
 	LOG("sp887x_readreg (r)", msg[1].addr, msg[1].buf, msg[1].len);
 
-	if ((ret = i2c->xfer(i2c, msg, 2)) != 2)
+	if ((ret = i2c_transfer(i2c, msg, 2)) != 2)
 		printk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
 
 	return (((b1[0] << 8) | b1[1]) & 0xfff);
 }
 
-
-static
-void sp887x_microcontroller_stop (struct dvb_frontend *fe)
+static void sp887x_microcontroller_stop (struct i2c_adapter *fe)
 {
 	dprintk("%s\n", __FUNCTION__);
 	sp887x_writereg(fe, 0xf08, 0x000);
@@ -148,9 +134,7 @@
 	sp887x_writereg(fe, 0xf00, 0x000);
 }
 
-
-static
-void sp887x_microcontroller_start (struct dvb_frontend *fe)
+static void sp887x_microcontroller_start (struct i2c_adapter *fe)
 {
 	dprintk("%s\n", __FUNCTION__);
 	sp887x_writereg(fe, 0xf08, 0x000);
@@ -160,9 +144,7 @@
 	sp887x_writereg(fe, 0xf00, 0x001);
 }
 
-
-static
-void sp887x_setup_agc (struct dvb_frontend *fe)
+static void sp887x_setup_agc (struct i2c_adapter *fe)
 {
 	/* setup AGC parameters */
 	dprintk("%s\n", __FUNCTION__);
@@ -182,72 +164,31 @@
 	sp887x_writereg(fe, 0x303, 0x000);
 }
 
-
 #define BLOCKSIZE 30
-
+#define FW_SIZE 0x4000
 /**
  *  load firmware and setup MPEG interface...
  */
-static
-int sp887x_initial_setup (struct dvb_frontend *fe)
+static int sp887x_initial_setup (struct i2c_adapter *fe, const struct firmware *fw)
 {
 	u8 buf [BLOCKSIZE+2];
-	unsigned char *firmware = NULL;
 	int i;
-	int fd;
-	int filesize;
-	int fw_size;
-	mm_segment_t fs;
+	int fw_size = fw->size;
+	unsigned char *mem = fw->data;
 
 	dprintk("%s\n", __FUNCTION__);
 
+	/* ignore the first 10 bytes, then we expect 0x4000 bytes of firmware */
+	if (fw_size < FW_SIZE+10)
+		return -ENODEV;
+
+	mem = fw->data + 10;
+
 	/* soft reset */
 	sp887x_writereg(fe, 0xf1a, 0x000);
 
 	sp887x_microcontroller_stop (fe);
 
-	fs = get_fs();
-
-	// Load the firmware
-	set_fs(get_ds());
-	fd = sys_open(sp887x_firmware, 0, 0);
-	if (fd < 0) {
-		printk(KERN_WARNING "%s: Unable to open firmware %s\n", __FUNCTION__,
-		       sp887x_firmware);
-		return -EIO;
-	}
-	filesize = sys_lseek(fd, 0L, 2);
-	if (filesize <= 0) {
-		printk(KERN_WARNING "%s: Firmware %s is empty\n", __FUNCTION__,
-		       sp887x_firmware);
-		sys_close(fd);
-		return -EIO;
-	}
-
-	fw_size = 0x4000;
-
-	// allocate buffer for it
-	firmware = vmalloc(fw_size);
-	if (firmware == NULL) {
-		printk(KERN_WARNING "%s: Out of memory loading firmware\n",
-		       __FUNCTION__);
-		sys_close(fd);
-		return -EIO;
-	}
-
-	// read it!
-	// read the first 16384 bytes from the file
-	// ignore the first 10 bytes
-	sys_lseek(fd, 10, 0);
-	if (sys_read(fd, firmware, fw_size) != fw_size) {
-		printk(KERN_WARNING "%s: Failed to read firmware\n", __FUNCTION__);
-		vfree(firmware);
-		sys_close(fd);
-		return -EIO;
-	}
-	sys_close(fd);
-	set_fs(fs);
-
 	printk ("%s: firmware upload... ", __FUNCTION__);
 
 	/* setup write pointer to -1 (end of memory) */
@@ -257,7 +198,7 @@
 	/* dummy write (wrap around to start of memory) */
 	sp887x_writereg(fe, 0x8f0a, 0x0000);
 
-	for (i=0; i<fw_size; i+=BLOCKSIZE) {
+	for (i = 0; i < FW_SIZE; i += BLOCKSIZE) {
 		int c = BLOCKSIZE;
 		int err;
 
@@ -270,18 +211,15 @@
 		buf[0] = 0xcf;
 		buf[1] = 0x0a;
 
-		memcpy(&buf[2], firmware + i, c);
+		memcpy(&buf[2], mem + i, c);
 
 		if ((err = i2c_writebytes (fe, 0x70, buf, c+2)) < 0) {
 			printk ("failed.\n");
 			printk ("%s: i2c error (err == %i)\n", __FUNCTION__, err);
-			vfree(firmware);
 			return err;
 		}
 	}
 
-	vfree(firmware);
-
 	/* don't write RS bytes between packets */
 	sp887x_writereg(fe, 0xc13, 0x001);
 
@@ -312,8 +249,7 @@
  *  returns the actual tuned center frequency which can be used
  *  to initialise the AFC registers
  */
-static
-int tsa5060_setup_pll (struct dvb_frontend *fe, int freq)
+static int tsa5060_setup_pll (struct i2c_adapter *fe, int freq)
 {
 	u8 cfg, cpump, band_select;
 	u8 buf [4];
@@ -340,10 +276,7 @@
 	return (div * 166666 - 36000000);
 }
 
-
-
-static
-int configure_reg0xc05 (struct dvb_frontend_parameters *p, u16 *reg0xc05)
+static int configure_reg0xc05 (struct dvb_frontend_parameters *p, u16 *reg0xc05)
 {
 	int known_parameters = 1;
 	
@@ -419,8 +351,7 @@
  *  estimates division of two 24bit numbers,
  *  derived from the ves1820/stv0299 driver code
  */
-static
-void divide (int n, int d, int *quotient_i, int *quotient_f)
+static void divide (int n, int d, int *quotient_i, int *quotient_f)
 {
 	unsigned int q, r;
 
@@ -438,9 +369,7 @@
 	}
 }
 
-
-static
-void sp887x_correct_offsets (struct dvb_frontend *fe,
+static void sp887x_correct_offsets (struct i2c_adapter *fe,
 			     struct dvb_frontend_parameters *p,
 			     int actual_freq)
 {
@@ -471,9 +400,7 @@
 	sp887x_writereg(fe, 0x30a, frequency_shift & 0xfff);
 }
 
-
-static
-int sp887x_setup_frontend_parameters (struct dvb_frontend *fe,
+static int sp887x_setup_frontend_parameters (struct i2c_adapter *fe,
 				      struct dvb_frontend_parameters *p)
 {
 	int actual_freq, err;
@@ -531,10 +458,11 @@
 	return 0;
 }
 
-
-static
-int sp887x_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+static int sp887x_ioctl(struct dvb_frontend *f, unsigned int cmd, void *arg)
 {
+	struct sp887x_state *state = (struct sp887x_state *) f->data;
+	struct i2c_adapter *fe = state->i2c;
+
         switch (cmd) {
         case FE_GET_INFO:
 		memcpy (arg, &sp887x_info, sizeof(struct dvb_frontend_info));
@@ -624,10 +552,6 @@
 		break;
 
         case FE_INIT:
-		if (fe->data == NULL) {	  /* first time initialisation... */
-			fe->data = (void*) ~0;
-			sp887x_initial_setup (fe);
-		}
 		/* enable TS output and interface pins */
 		sp887x_writereg(fe, 0xc18, 0x00d);
 		break;
@@ -635,9 +559,9 @@
 	case FE_GET_TUNE_SETTINGS:
 	{
 	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
-	        fesettings->min_delay_ms = 50;
-	        fesettings->step_size = 0;
-	        fesettings->max_drift = 0;
+	        fesettings->min_delay_ms = 350;
+	        fesettings->step_size = 166666*2;
+	        fesettings->max_drift = (166666*2)+1;
 	        return 0;
 	}	    
 
@@ -648,45 +572,135 @@
         return 0;
 }
 
+static struct i2c_client client_template;
 
-
-static
-int sp887x_attach (struct dvb_i2c_bus *i2c, void **data)
+static int attach_adapter(struct i2c_adapter *adapter)
 {
+	struct i2c_client *client;
+	struct sp887x_state *state;
+	const struct firmware *fw;
+	int ret;
+
 	struct i2c_msg msg = {.addr = 0x70, .flags = 0, .buf = NULL, .len = 0 };
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	if (i2c->xfer (i2c, &msg, 1) != 1)
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+
+	if (NULL == (state = kmalloc(sizeof(struct sp887x_state), GFP_KERNEL))) {
+		kfree(client);
+		return -ENOMEM;
+	}
+	state->i2c = adapter;
+
+	if (i2c_transfer (adapter, &msg, 1) != 1) {
+		kfree(state);
+		kfree(client);
                 return -ENODEV;
+	}
 
-	return dvb_register_frontend (sp887x_ioctl, i2c, NULL, &sp887x_info);
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	i2c_set_clientdata(client, (void*)state);
+
+	ret = i2c_attach_client(client);
+	if (ret) {
+		kfree(client);
+		kfree(state);
+		return ret;
 }
 
+	/* request the firmware, this will block until someone uploads it */
+	printk("sp887x: waiting for firmware upload...\n");
+	ret = request_firmware(&fw, SP887X_DEFAULT_FIRMWARE, &client->dev);
+	if (ret) {
+		printk("sp887x: no firmware upload (timeout or file not found?)\n");
+		goto out;
+	}
+
+	ret = sp887x_initial_setup(adapter, fw);
+	if (ret) {
+		printk("sp887x: writing firmware to device failed\n");
+		goto out;
+	}
+
+	ret = dvb_register_frontend(sp887x_ioctl, state->dvb, state,
+					&sp887x_info, THIS_MODULE);
+	if (ret) {
+		printk("sp887x: registering frontend to dvb-core failed.\n");
+		goto out;
+	}
 
-static
-void sp887x_detach (struct dvb_i2c_bus *i2c, void *data)
+	return 0;
+out:
+	release_firmware(fw);
+	i2c_detach_client(client);
+	kfree(client);
+	kfree(state);
+	return ret;
+}
+
+static int detach_client(struct i2c_client *client)
 {
+	struct sp887x_state *state = (struct sp887x_state*)i2c_get_clientdata(client);
+
 	dprintk ("%s\n", __FUNCTION__);
-	dvb_unregister_frontend (sp887x_ioctl, i2c);
-}
 
+	dvb_unregister_frontend_new (sp887x_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
 
-static
-int __init init_sp887x (void)
+static int command (struct i2c_client *client, unsigned int cmd, void *arg)
 {
+	struct sp887x_state *state = (struct sp887x_state*)i2c_get_clientdata(client);
+
 	dprintk ("%s\n", __FUNCTION__);
-	return dvb_register_i2c_device (NULL, sp887x_attach, sp887x_detach);
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
+	.id 		= I2C_DRIVERID_DVBFE_SP887X,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = attach_adapter,
+	.detach_client 	= detach_client,
+	.command 	= command,
+};
 
-static
-void __exit exit_sp887x (void)
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
+
+static int __init init_sp887x(void)
 {
-	dprintk ("%s\n", __FUNCTION__);
-	dvb_unregister_i2c_device (sp887x_attach);
+	return i2c_add_driver(&driver);
 }
 
+static void __exit exit_sp887x(void)
+{
+	if (i2c_del_driver(&driver))
+		printk("sp887x: driver deregistration failed\n");
+}
 
 module_init(init_sp887x);
 module_exit(exit_sp887x);

--------------000909020206060707070202--

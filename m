Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVKGDVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVKGDVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVKGDVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:21:46 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:46721 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932428AbVKGDQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:50 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Hartmut Hackmann <hartmut.hackmann@t.online.de>
Subject: [Patch 05/20] V4L(904) Added dvb support for tda8275a philips
	tiger reference design 
Date: Mon, 07 Nov 2005 00:58:07 -0200
Message-Id: <1131333341.25215.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t.online.de>

- Added dvb support for tda8275a (Philips Tiger reference design)

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t.online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-cards.c |   37 +++++
 drivers/media/video/saa7134/saa7134-dvb.c   |  192 ++++++++++++++++++++++++++++
 drivers/media/video/saa7134/saa7134.h       |    1 
 include/media/tuner.h                       |    2 
 4 files changed, 231 insertions(+), 1 deletion(-)

--- hg.orig/drivers/media/video/saa7134/saa7134-cards.c
+++ hg/drivers/media/video/saa7134/saa7134-cards.c
@@ -2490,6 +2490,29 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE1,
 		}},
 	},
+	[SAA7134_BOARD_PHILIPS_TIGER] = {
+		.name           = "Philips Tiger reference design",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.inputs = {{
+			.name   = name_tv,
+			.vmux   = 1,
+			.amux   = TV,
+			.tv     = 1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 3,
+			.amux   = LINE1,
+		},{
+			.name   = name_svideo,
+			.vmux   = 8,
+			.amux   = LINE1,
+		}},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -2919,6 +2942,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subvendor    = 0x1043,
 		.subdevice    = 0x4862,
 		.driver_data  = SAA7134_BOARD_ASUSTeK_P7131_DUAL,
+ 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = PCI_VENDOR_ID_PHILIPS,
+		.subdevice    = 0x2018,
+		.driver_data  = SAA7134_BOARD_PHILIPS_TIGER,
 	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -3177,6 +3206,14 @@ int saa7134_board_init2(struct saa7134_d
 		saa7134_i2c_call_clients (dev, TUNER_SET_TYPE_ADDR,&tun_setup);
 		}
 		break;
+	case SAA7134_BOARD_PHILIPS_TIGER:
+		/* this is a hybrid board, initialize to analog mode */
+		{
+		u8 data[] = { 0x3c, 0x33, 0x68};
+		struct i2c_msg msg = {.addr=0x08, .flags=0, .buf=data, .len = sizeof(data)};
+		i2c_transfer(&dev->i2c_adap, &msg, 1);
+		}
+		break;
 	}
 	return 0;
 }
--- hg.orig/drivers/media/video/saa7134/saa7134-dvb.c
+++ hg/drivers/media/video/saa7134/saa7134-dvb.c
@@ -626,8 +626,196 @@ static struct tda1004x_config tda827x_li
 	.pll_sleep	   = philips_tda827x_pll_sleep,
 	.request_firmware = NULL,
 };
+
+/* ------------------------------------------------------------------ */
+
+struct tda827xa_data {
+	u32 lomax;
+	u8  svco;
+	u8  spd;
+	u8  scr;
+	u8  sbs;
+	u8  gc3;
+};
+
+static struct tda827xa_data tda827xa_dvbt[] = {
+	{ .lomax =  56875000, .svco = 3, .spd = 4, .scr = 0, .sbs = 0, .gc3 = 1},
+	{ .lomax =  67250000, .svco = 0, .spd = 3, .scr = 0, .sbs = 0, .gc3 = 1},
+	{ .lomax =  81250000, .svco = 1, .spd = 3, .scr = 0, .sbs = 0, .gc3 = 1},
+	{ .lomax =  97500000, .svco = 2, .spd = 3, .scr = 0, .sbs = 0, .gc3 = 1},
+	{ .lomax = 113750000, .svco = 3, .spd = 3, .scr = 0, .sbs = 1, .gc3 = 1},
+	{ .lomax = 134500000, .svco = 0, .spd = 2, .scr = 0, .sbs = 1, .gc3 = 1},
+	{ .lomax = 154000000, .svco = 1, .spd = 2, .scr = 0, .sbs = 1, .gc3 = 1},
+	{ .lomax = 162500000, .svco = 1, .spd = 2, .scr = 0, .sbs = 1, .gc3 = 1},
+	{ .lomax = 183000000, .svco = 2, .spd = 2, .scr = 0, .sbs = 1, .gc3 = 1},
+	{ .lomax = 195000000, .svco = 2, .spd = 2, .scr = 0, .sbs = 2, .gc3 = 1},
+	{ .lomax = 227500000, .svco = 3, .spd = 2, .scr = 0, .sbs = 2, .gc3 = 1},
+	{ .lomax = 269000000, .svco = 0, .spd = 1, .scr = 0, .sbs = 2, .gc3 = 1},
+	{ .lomax = 290000000, .svco = 1, .spd = 1, .scr = 0, .sbs = 2, .gc3 = 1},
+	{ .lomax = 325000000, .svco = 1, .spd = 1, .scr = 0, .sbs = 3, .gc3 = 1},
+	{ .lomax = 390000000, .svco = 2, .spd = 1, .scr = 0, .sbs = 3, .gc3 = 1},
+	{ .lomax = 455000000, .svco = 3, .spd = 1, .scr = 0, .sbs = 3, .gc3 = 1},
+	{ .lomax = 520000000, .svco = 0, .spd = 0, .scr = 0, .sbs = 3, .gc3 = 1},
+	{ .lomax = 538000000, .svco = 0, .spd = 0, .scr = 1, .sbs = 3, .gc3 = 1},
+	{ .lomax = 550000000, .svco = 1, .spd = 0, .scr = 0, .sbs = 3, .gc3 = 1},
+	{ .lomax = 620000000, .svco = 1, .spd = 0, .scr = 0, .sbs = 4, .gc3 = 0},
+	{ .lomax = 650000000, .svco = 1, .spd = 0, .scr = 1, .sbs = 4, .gc3 = 0},
+	{ .lomax = 700000000, .svco = 2, .spd = 0, .scr = 0, .sbs = 4, .gc3 = 0},
+	{ .lomax = 780000000, .svco = 2, .spd = 0, .scr = 1, .sbs = 4, .gc3 = 0},
+	{ .lomax = 820000000, .svco = 3, .spd = 0, .scr = 0, .sbs = 4, .gc3 = 0},
+	{ .lomax = 870000000, .svco = 3, .spd = 0, .scr = 1, .sbs = 4, .gc3 = 0},
+	{ .lomax = 911000000, .svco = 3, .spd = 0, .scr = 2, .sbs = 4, .gc3 = 0},
+	{ .lomax =         0, .svco = 0, .spd = 0, .scr = 0, .sbs = 0, .gc3 = 0}};
+
+			
+static int philips_tda827xa_pll_set(u8 addr, struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	u8 tuner_buf[14];
+	unsigned char reg2[2];
+
+	struct i2c_msg msg = {.addr = addr,.flags = 0,.buf = tuner_buf};
+	int i, tuner_freq, if_freq;
+	u32 N;
+	
+	switch (params->u.ofdm.bandwidth) {
+	case BANDWIDTH_6_MHZ:
+		if_freq = 4000000;
+		break;
+	case BANDWIDTH_7_MHZ:
+		if_freq = 4500000;
+		break;
+	default:		   /* 8 MHz or Auto */
+		if_freq = 5000000;
+		break;
+	}
+	tuner_freq = params->frequency + if_freq;
+
+	i = 0;
+	while (tda827xa_dvbt[i].lomax < tuner_freq) {
+		if(tda827xa_dvbt[i + 1].lomax == 0)
+			break;
+		i++;
+	}
+
+	N = ((tuner_freq + 31250) / 62500) << tda827xa_dvbt[i].spd;
+	tuner_buf[0] = 0;            // subaddress
+	tuner_buf[1] = N >> 8;
+	tuner_buf[2] = N & 0xff;
+	tuner_buf[3] = 0;
+	tuner_buf[4] = 0x16;
+	tuner_buf[5] = (tda827xa_dvbt[i].spd << 5) + (tda827xa_dvbt[i].svco << 3) +
+			tda827xa_dvbt[i].sbs;
+	tuner_buf[6] = 0x4b + (tda827xa_dvbt[i].gc3 << 4);
+	tuner_buf[7] = 0x0c;
+	tuner_buf[8] = 0x06;
+	tuner_buf[9] = 0x24;
+	tuner_buf[10] = 0xff;
+	tuner_buf[11] = 0x60;
+	tuner_buf[12] = 0x00;
+	tuner_buf[13] = 0x39;  // lpsel
+	msg.len = 14;
+	if (i2c_transfer(&dev->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+
+	msg.buf= reg2;
+	msg.len = 2;
+	reg2[0] = 0x60;
+	reg2[1] = 0x3c;
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
+
+	reg2[0] = 0xa0;
+	reg2[1] = 0x40;
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
+
+	msleep(2);
+	/* correct CP value */
+	reg2[0] = 0x30;
+	reg2[1] = 0x10 + tda827xa_dvbt[i].scr;
+	msg.len = 2;
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
+
+	msleep(550);
+	reg2[0] = 0x50;
+	reg2[1] = 0x4f + (tda827xa_dvbt[i].gc3 << 4);
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
+
+	return 0;
+
+}
+
+static void philips_tda827xa_pll_sleep(u8 addr, struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	static u8 tda827xa_sleep[] = { 0x30, 0x90};
+	struct i2c_msg tuner_msg = {.addr = addr,.flags = 0,.buf = tda827xa_sleep,
+	                            .len = sizeof(tda827xa_sleep) };
+	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
+	
+}
+
+/* ------------------------------------------------------------------ */
+
+static int philips_tiger_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	int ret;
+	struct saa7134_dev *dev = fe->dvb->priv;
+	static u8 tda8290_close[] = { 0x21, 0xc0};
+	static u8 tda8290_open[]  = { 0x21, 0x80};
+	struct i2c_msg tda8290_msg = {.addr = 0x4b,.flags = 0, .len = 2};
+	/* close tda8290 i2c bridge */
+	tda8290_msg.buf = tda8290_close;
+	ret = i2c_transfer(&dev->i2c_adap, &tda8290_msg, 1);
+	if (ret != 1)
+		return -EIO;
+	msleep(20);
+	ret = philips_tda827xa_pll_set(0x61, fe, params);
+	if (ret != 0)
+		return ret;
+	/* open tda8290 i2c bridge */
+	tda8290_msg.buf = tda8290_open;
+	i2c_transfer(&dev->i2c_adap, &tda8290_msg, 1);
+	return ret;
+};
+
+static int philips_tiger_dvb_mode(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	static u8 data[] = { 0x3c, 0x33, 0x6a};
+	struct i2c_msg msg = {.addr=0x08, .flags=0, .buf=data, .len = sizeof(data)};
+
+	if (i2c_transfer(&dev->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+	return 0;
+}
+
+static void philips_tiger_analog_mode(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	static u8 data[] = { 0x3c, 0x33, 0x68};
+	struct i2c_msg msg = {.addr=0x08, .flags=0, .buf=data, .len = sizeof(data)};
+
+	i2c_transfer(&dev->i2c_adap, &msg, 1);
+	philips_tda827xa_pll_sleep( 0x61, fe);
+}
+
+static struct tda1004x_config philips_tiger_config = {
+	.demod_address = 0x08,
+	.invert        = 1,
+	.invert_oclk   = 0,
+	.xtal_freq     = TDA10046_XTAL_16M,
+	.agc_config    = TDA10046_AGC_TDA827X,
+	.if_freq       = TDA10046_FREQ_045,
+	.pll_init      = philips_tiger_dvb_mode,
+	.pll_set       = philips_tiger_pll_set,
+	.pll_sleep     = philips_tiger_analog_mode,
+	.request_firmware = NULL,
+};
+
 #endif
 
+/* ------------------------------------------------------------------ */
+
 #ifdef HAVE_NXT200X
 static struct nxt200x_config avertvhda180 = {
 	.demod_address    = 0x0a,
@@ -688,6 +876,10 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = tda10046_attach(&philips_tu1216_61_config,
 						    &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_PHILIPS_TIGER:
+		dev->dvb.frontend = tda10046_attach(&philips_tiger_config,
+						    &dev->i2c_adap);
+		break;
 #endif
 #ifdef HAVE_NXT200X
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:
--- hg.orig/drivers/media/video/saa7134/saa7134.h
+++ hg/drivers/media/video/saa7134/saa7134.h
@@ -207,6 +207,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_ASUSTeK_P7131_DUAL 78
 #define SAA7134_BOARD_PCTV_CARDBUS     79
 #define SAA7134_BOARD_ASUSTEK_DIGIMATRIX_TV 80
+#define SAA7134_BOARD_PHILIPS_TIGER  81
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
--- hg.orig/include/media/tuner.h
+++ hg/include/media/tuner.h
@@ -211,10 +211,10 @@ extern unsigned const int tuner_count;
 
 extern int microtune_init(struct i2c_client *c);
 extern int tda8290_init(struct i2c_client *c);
+extern int tda8290_probe(struct i2c_client *c);
 extern int tea5767_tuner_init(struct i2c_client *c);
 extern int default_tuner_init(struct i2c_client *c);
 extern int tea5767_autodetection(struct i2c_client *c);
-extern int tda8290_probe(struct i2c_client *c);
 
 #define tuner_warn(fmt, arg...) do {\
 	printk(KERN_WARNING "%s %d-%04x: " fmt, t->i2c.driver->name, \


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/


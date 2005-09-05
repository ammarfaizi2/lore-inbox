Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVIEVrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVIEVrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVIEVqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:46:46 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:23378 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932680AbVIEVnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:47 -0400
Date: Mon, 05 Sep 2005 18:26:14 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 01/24] V4L: Common part Updates and tuner additions
Message-ID: <431cb7f6.3a1Y2AL2UcB0Asbo%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f6.AmFFSEAag8DMRvOpQWQrrSuVnKCdpO2D92BUUJaCNwsAHa03"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f6.AmFFSEAag8DMRvOpQWQrrSuVnKCdpO2D92BUUJaCNwsAHa03
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f6.AmFFSEAag8DMRvOpQWQrrSuVnKCdpO2D92BUUJaCNwsAHa03
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-01-misc-update.diff"

- Remove $Id CVS logs for V4L files
- Included newer cards.
- Added a new NEC protocol for ir based on pulse distance.
- Enable ATSC support for DViCO FusionHDTV5 Gold.
- Added tuner LG NTSC (TALN mini series).
- Fixed tea5767 autodetection.
- Resolve more tuner types.
- Commented debug function removed from mainstream.
- Remove comments from mainstream. Still on development tree.
- linux/version dependencies removed.
- BTSC Lang1 now is set to auto_stereo mode.
- New tuner standby API.
- i2c-core.c uses hexadecimal for the i2c address, so it should stay consistent.

Signed-off-by: Uli Luckas <luckas@musoft.de>
Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Hermann Pitton <hermann.pitton@onlinehome.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 Documentation/video4linux/CARDLIST.tuner |    1 
 drivers/media/common/ir-common.c         |   68 ++++++++++++++++++++++++++-
 drivers/media/video/btcx-risc.c          |    1 
 drivers/media/video/btcx-risc.h          |    1 
 drivers/media/video/ir-kbd-gpio.c        |    1 
 drivers/media/video/ir-kbd-i2c.c         |    1 
 drivers/media/video/msp3400.h            |    1 
 drivers/media/video/mt20xx.c             |    2 
 drivers/media/video/tda8290.c            |   19 +++++++
 drivers/media/video/tda9887.c            |   39 ++++++++++-----
 drivers/media/video/tea5767.c            |   37 ++++++++------
 drivers/media/video/tuner-core.c         |   77 ++++++++++++++++++-------------
 drivers/media/video/tuner-simple.c       |    5 +-
 drivers/media/video/tveeprom.c           |   25 +---------
 drivers/media/video/tvmixer.c            |    1 
 drivers/media/video/v4l1-compat.c        |   16 ------
 drivers/media/video/v4l2-common.c        |   18 -------
 drivers/media/video/video-buf-dvb.c      |    1 
 drivers/media/video/video-buf.c          |    1 
 include/linux/videodev.h                 |    3 -
 include/linux/videodev2.h                |    4 -
 include/media/audiochip.h                |    1 
 include/media/id.h                       |    1 
 include/media/ir-common.h                |    4 -
 include/media/tuner.h                    |   25 +++++-----
 include/media/tveeprom.h                 |    1 
 include/media/video-buf.h                |    1 
 27 files changed, 202 insertions(+), 153 deletions(-)

diff -upr linux-2.6.13-misc/Documentation/video4linux/CARDLIST.tuner linux-2.6.13/Documentation/video4linux/CARDLIST.tuner
--- linux-2.6.13-misc/Documentation/video4linux/CARDLIST.tuner	2005-09-05 12:13:36.929092806 -0500
+++ linux-2.6.13/Documentation/video4linux/CARDLIST.tuner	2005-09-05 11:49:47.532714199 -0500
@@ -64,3 +64,4 @@ tuner=62 - Philips TEA5767HN FM Radio
 tuner=63 - Philips FMD1216ME MK3 Hybrid Tuner
 tuner=64 - LG TDVS-H062F/TUA6034
 tuner=65 - Ymec TVF66T5-B/DFF
+tuner=66 - LG NTSC (TALN mini series)
diff -upr linux-2.6.13-misc/drivers/media/common/ir-common.c linux-2.6.13/drivers/media/common/ir-common.c
--- linux-2.6.13-misc/drivers/media/common/ir-common.c	2005-09-05 12:13:38.322572554 -0500
+++ linux-2.6.13/drivers/media/common/ir-common.c	2005-09-05 11:49:25.334000605 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: ir-common.c,v 1.11 2005/07/07 14:44:43 mchehab Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -335,6 +334,72 @@ int ir_dump_samples(u32 *samples, int co
 	return 0;
 }
 
+/* decode raw samples, pulse distance coding used by NEC remotes */
+int ir_decode_pulsedistance(u32 *samples, int count, int low, int high)
+{
+	int i,last,bit,len;
+	u32 curBit;
+	u32 value;
+
+	/* find start burst */
+	for (i = len = 0; i < count * 32; i++) {
+		bit = getbit(samples,i);
+		if (bit) {
+			len++;
+		} else {
+			if (len >= 29)
+				break;
+			len = 0;
+		}
+	}
+
+	/* start burst to short */
+	if (len < 29)
+		return 0xffffffff;
+
+	/* find start silence */
+	for (len = 0; i < count * 32; i++) {
+		bit = getbit(samples,i);
+		if (bit) {
+			break;
+		} else {
+			len++;
+		}
+	}
+
+	/* silence to short */
+	if (len < 7)
+		return 0xffffffff;
+
+	/* go decoding */
+	len   = 0;
+	last = 1;
+	value = 0; curBit = 1;
+	for (; i < count * 32; i++) {
+		bit  = getbit(samples,i);
+		if (last) {
+			if(bit) {
+				continue;
+			} else {
+				len = 1;
+			}
+		} else {
+			if (bit) {
+				if (len > (low + high) /2)
+					value |= curBit;
+				curBit <<= 1;
+				if (curBit == 1)
+					break;
+			} else {
+				len++;
+			}
+		}
+		last = bit;
+	}
+
+	return value;
+}
+
 /* decode raw samples, biphase coding, used by rc5 for example */
 int ir_decode_biphase(u32 *samples, int count, int low, int high)
 {
@@ -383,6 +448,7 @@ EXPORT_SYMBOL_GPL(ir_input_keydown);
 EXPORT_SYMBOL_GPL(ir_extract_bits);
 EXPORT_SYMBOL_GPL(ir_dump_samples);
 EXPORT_SYMBOL_GPL(ir_decode_biphase);
+EXPORT_SYMBOL_GPL(ir_decode_pulsedistance);
 
 /*
  * Local variables:
diff -upr linux-2.6.13-misc/drivers/media/video/btcx-risc.c linux-2.6.13/drivers/media/video/btcx-risc.c
--- linux-2.6.13-misc/drivers/media/video/btcx-risc.c	2005-09-05 12:13:38.260595693 -0500
+++ linux-2.6.13/drivers/media/video/btcx-risc.c	2005-09-05 11:49:08.284364932 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: btcx-risc.c,v 1.6 2005/02/21 13:57:59 kraxel Exp $
 
     btcx-risc.c
 
diff -upr linux-2.6.13-misc/drivers/media/video/btcx-risc.h linux-2.6.13/drivers/media/video/btcx-risc.h
--- linux-2.6.13-misc/drivers/media/video/btcx-risc.h	2005-09-05 12:13:38.260595693 -0500
+++ linux-2.6.13/drivers/media/video/btcx-risc.h	2005-09-05 11:49:08.284364932 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: btcx-risc.h,v 1.2 2004/09/15 16:15:24 kraxel Exp $
  */
 struct btcx_riscmem {
 	unsigned int   size;
diff -upr linux-2.6.13-misc/drivers/media/video/ir-kbd-gpio.c linux-2.6.13/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.13-misc/drivers/media/video/ir-kbd-gpio.c	2005-09-05 12:13:38.256597186 -0500
+++ linux-2.6.13/drivers/media/video/ir-kbd-gpio.c	2005-09-05 11:49:08.267371276 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: ir-kbd-gpio.c,v 1.13 2005/05/15 19:01:26 mchehab Exp $
  *
  * Copyright (c) 2003 Gerd Knorr
  * Copyright (c) 2003 Pavel Machek
diff -upr linux-2.6.13-misc/drivers/media/video/ir-kbd-i2c.c linux-2.6.13/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.13-misc/drivers/media/video/ir-kbd-i2c.c	2005-09-05 12:13:38.282587482 -0500
+++ linux-2.6.13/drivers/media/video/ir-kbd-i2c.c	2005-09-05 11:49:08.267371276 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: ir-kbd-i2c.c,v 1.11 2005/07/07 16:42:11 mchehab Exp $
  *
  * keyboard input driver for i2c IR remote controls
  *
diff -upr linux-2.6.13-misc/drivers/media/video/msp3400.h linux-2.6.13/drivers/media/video/msp3400.h
--- linux-2.6.13-misc/drivers/media/video/msp3400.h	2005-09-05 12:13:38.234605396 -0500
+++ linux-2.6.13/drivers/media/video/msp3400.h	2005-09-05 11:49:08.297360082 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: msp3400.h,v 1.3 2005/06/12 04:19:19 mchehab Exp $
  */
 
 #ifndef MSP3400_H
diff -upr linux-2.6.13-misc/drivers/media/video/mt20xx.c linux-2.6.13/drivers/media/video/mt20xx.c
--- linux-2.6.13-misc/drivers/media/video/mt20xx.c	2005-09-05 12:13:38.287585616 -0500
+++ linux-2.6.13/drivers/media/video/mt20xx.c	2005-09-05 11:49:51.575205202 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: mt20xx.c,v 1.5 2005/06/16 08:29:49 nsh Exp $
  *
  * i2c tv tuner chip device driver
  * controls microtune tuners, mt2032 + mt2050 at the moment.
@@ -494,6 +493,7 @@ int microtune_init(struct i2c_client *c)
 	memset(buf,0,sizeof(buf));
 	t->tv_freq    = NULL;
 	t->radio_freq = NULL;
+	t->standby    = NULL;
 	name = "unknown";
 
         i2c_master_send(c,buf,1);
diff -upr linux-2.6.13-misc/drivers/media/video/tda8290.c linux-2.6.13/drivers/media/video/tda8290.c
--- linux-2.6.13-misc/drivers/media/video/tda8290.c	2005-09-05 12:13:38.232606143 -0500
+++ linux-2.6.13/drivers/media/video/tda8290.c	2005-09-05 11:49:51.575205202 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: tda8290.c,v 1.15 2005/07/08 20:21:33 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * controls the philips tda8290+75 tuner chip combo.
@@ -9,6 +8,9 @@
 #include <linux/delay.h>
 #include <media/tuner.h>
 
+#define I2C_ADDR_TDA8290        0x4b
+#define I2C_ADDR_TDA8275        0x61
+
 /* ---------------------------------------------------------------------- */
 
 struct freq_entry {
@@ -75,10 +77,12 @@ static unsigned char i2c_init_tda8275[14
 static unsigned char i2c_set_VS[2] = 		{ 0x30, 0x6F };
 static unsigned char i2c_set_GP01_CF[2] = 	{ 0x20, 0x0B };
 static unsigned char i2c_tda8290_reset[2] =	{ 0x00, 0x00 };
+static unsigned char i2c_tda8290_standby[2] =	{ 0x00, 0x02 };
 static unsigned char i2c_gainset_off[2] =	{ 0x28, 0x14 };
 static unsigned char i2c_gainset_on[2] =	{ 0x28, 0x54 };
 static unsigned char i2c_agc3_00[2] =		{ 0x80, 0x00 };
 static unsigned char i2c_agc2_BF[2] =		{ 0x60, 0xBF };
+static unsigned char i2c_cb1_D0[2] =		{ 0x30, 0xD0 };
 static unsigned char i2c_cb1_D2[2] =		{ 0x30, 0xD2 };
 static unsigned char i2c_cb1_56[2] =		{ 0x30, 0x56 };
 static unsigned char i2c_cb1_52[2] =		{ 0x30, 0x52 };
@@ -117,6 +121,13 @@ static struct i2c_msg i2c_msg_epilog[] =
 	{ I2C_ADDR_TDA8290, 0, ARRAY_SIZE(i2c_gainset_on), i2c_gainset_on },
 };
 
+static struct i2c_msg i2c_msg_standby[] = {
+	{ I2C_ADDR_TDA8290, 0, ARRAY_SIZE(i2c_enable_bridge), i2c_enable_bridge },
+	{ I2C_ADDR_TDA8275, 0, ARRAY_SIZE(i2c_cb1_D0), i2c_cb1_D0 },
+	{ I2C_ADDR_TDA8290, 0, ARRAY_SIZE(i2c_disable_bridge), i2c_disable_bridge },
+	{ I2C_ADDR_TDA8290, 0, ARRAY_SIZE(i2c_tda8290_standby), i2c_tda8290_standby },
+};
+
 static int tda8290_tune(struct i2c_client *c)
 {
 	struct tuner *t = i2c_get_clientdata(c);
@@ -205,6 +216,11 @@ static int has_signal(struct i2c_client 
 	return (afc & 0x80)? 65535:0;
 }
 
+static void standby(struct i2c_client *c)
+{
+	i2c_transfer(c->adapter, i2c_msg_standby, ARRAY_SIZE(i2c_msg_standby));
+}
+
 int tda8290_init(struct i2c_client *c)
 {
 	struct tuner *t = i2c_get_clientdata(c);
@@ -214,6 +230,7 @@ int tda8290_init(struct i2c_client *c)
 	t->tv_freq    = set_tv_freq;
 	t->radio_freq = set_radio_freq;
 	t->has_signal = has_signal;
+	t->standby = standby;
 
 	i2c_master_send(c, i2c_enable_bridge, ARRAY_SIZE(i2c_enable_bridge));
 	i2c_transfer(c->adapter, i2c_msg_init, ARRAY_SIZE(i2c_msg_init));
diff -upr linux-2.6.13-misc/drivers/media/video/tda9887.c linux-2.6.13/drivers/media/video/tda9887.c
--- linux-2.6.13-misc/drivers/media/video/tda9887.c	2005-09-05 12:13:38.282587482 -0500
+++ linux-2.6.13/drivers/media/video/tda9887.c	2005-09-05 11:49:51.576204829 -0500
@@ -49,7 +49,7 @@ MODULE_LICENSE("GPL");
 struct tda9887 {
 	struct i2c_client  client;
 	v4l2_std_id        std;
-	unsigned int       radio;
+	enum tuner_mode    mode;
 	unsigned int       config;
 	unsigned int       pinnacle_id;
 	unsigned int       using_v4l2;
@@ -196,7 +196,7 @@ static struct tvnorm tvnorms[] = {
 		.b     = ( cNegativeFmTV  |
 			   cQSS           ),
 		.c     = ( cDeemphasisON  |
-			   cDeemphasis50  ),
+			   cDeemphasis75  ),
 		.e     = ( cGating_36     |
 			   cAudioIF_4_5   |
 			   cVideoIF_45_75 ),
@@ -364,7 +364,7 @@ static int tda9887_set_tvnorm(struct tda
 	struct tvnorm *norm = NULL;
 	int i;
 
-	if (t->radio) {
+	if (t->mode == T_RADIO) {
 		if (t->radio_mode == V4L2_TUNER_MODE_MONO)
 			norm = &radio_mono;
 		else
@@ -378,7 +378,7 @@ static int tda9887_set_tvnorm(struct tda
 		}
 	}
 	if (NULL == norm) {
-		dprintk(PREFIX "Oops: no tvnorm entry found\n");
+		dprintk(PREFIX "Unsupported tvnorm entry - audio muted\n");
 		return -1;
 	}
 
@@ -569,6 +569,10 @@ static int tda9887_configure(struct tda9
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
+	if (t->mode == T_STANDBY) {
+		buf[1] |= cForcedMuteAudioON;
+	}
+
 
 	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
 		buf[1],buf[2],buf[3]);
@@ -653,10 +657,17 @@ tda9887_command(struct i2c_client *clien
 
 	/* --- configuration --- */
 	case AUDC_SET_RADIO:
-		t->radio = 1;
+	{
+		t->mode = T_RADIO;
 		tda9887_configure(t);
 		break;
-
+	}
+	case TUNER_SET_STANDBY:
+	{
+		t->mode = T_STANDBY;
+		tda9887_configure(t);
+		break;
+	}
 	case AUDC_CONFIG_PINNACLE:
 	{
 		int *i = arg;
@@ -689,7 +700,7 @@ tda9887_command(struct i2c_client *clien
 		struct video_channel *vc = arg;
 
 		CHECK_V4L2;
-		t->radio = 0;
+		t->mode = T_ANALOG_TV;
 		if (vc->norm < ARRAY_SIZE(map))
 			t->std = map[vc->norm];
 		tda9887_fixup_std(t);
@@ -701,7 +712,7 @@ tda9887_command(struct i2c_client *clien
 		v4l2_std_id *id = arg;
 
 		SWITCH_V4L2;
-		t->radio = 0;
+		t->mode = T_ANALOG_TV;
 		t->std   = *id;
 		tda9887_fixup_std(t);
 		tda9887_configure(t);
@@ -713,14 +724,14 @@ tda9887_command(struct i2c_client *clien
 
 		SWITCH_V4L2;
 		if (V4L2_TUNER_ANALOG_TV == f->type) {
-			if (t->radio == 0)
+			if (t->mode == T_ANALOG_TV)
 				return 0;
-			t->radio = 0;
+			t->mode = T_ANALOG_TV;
 		}
 		if (V4L2_TUNER_RADIO == f->type) {
-			if (t->radio == 1)
+			if (t->mode == T_RADIO)
 				return 0;
-			t->radio = 1;
+			t->mode = T_RADIO;
 		}
 		tda9887_configure(t);
 		break;
@@ -735,7 +746,7 @@ tda9887_command(struct i2c_client *clien
 		};
 		struct v4l2_tuner* tuner = arg;
 
-		if (t->radio) {
+		if (t->mode == T_RADIO) {
 			__u8 reg = 0;
 			tuner->afc=0;
 			if (1 == i2c_master_recv(&t->client,&reg,1))
@@ -747,7 +758,7 @@ tda9887_command(struct i2c_client *clien
 	{
 		struct v4l2_tuner* tuner = arg;
 
-		if (t->radio) {
+		if (t->mode == T_RADIO) {
 			t->radio_mode = tuner->audmode;
 			tda9887_configure (t);
 		}
diff -upr linux-2.6.13-misc/drivers/media/video/tea5767.c linux-2.6.13/drivers/media/video/tea5767.c
--- linux-2.6.13-misc/drivers/media/video/tea5767.c	2005-09-05 12:13:38.215612487 -0500
+++ linux-2.6.13/drivers/media/video/tea5767.c	2005-09-05 11:49:51.576204829 -0500
@@ -2,7 +2,6 @@
  * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
  * I2C address is allways 0xC0.
  *
- * $Id: tea5767.c,v 1.27 2005/07/31 12:10:56 mchehab Exp $
  *
  * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
  * This code is placed under the terms of the GNU General Public License
@@ -205,11 +204,6 @@ static void set_radio_freq(struct i2c_cl
 		    TEA5767_ST_NOISE_CTL | TEA5767_JAPAN_BAND;
 	buffer[4] = 0;
 
-	if (t->mode == T_STANDBY) {
-		tuner_dbg("TEA5767 set to standby mode\n");
-		buffer[3] |= TEA5767_STDBY;
-	}
-
 	if (t->audmode == V4L2_TUNER_MODE_MONO) {
 		tuner_dbg("TEA5767 set to mono\n");
 		buffer[2] |= TEA5767_MONO;
@@ -290,13 +284,31 @@ static int tea5767_stereo(struct i2c_cli
 	return ((buffer[2] & TEA5767_STEREO_MASK) ? V4L2_TUNER_SUB_STEREO : 0);
 }
 
+static void tea5767_standby(struct i2c_client *c)
+{
+	unsigned char buffer[5];
+	struct tuner *t = i2c_get_clientdata(c);
+	unsigned div, rc;
+
+	div = (87500 * 4 + 700 + 225 + 25) / 50; /* Set frequency to 87.5 MHz */
+	buffer[0] = (div >> 8) & 0x3f;
+	buffer[1] = div & 0xff;
+	buffer[2] = TEA5767_PORT1_HIGH;
+	buffer[3] = TEA5767_PORT2_HIGH | TEA5767_HIGH_CUT_CTRL |
+		    TEA5767_ST_NOISE_CTL | TEA5767_JAPAN_BAND | TEA5767_STDBY;
+	buffer[4] = 0;
+
+	if (5 != (rc = i2c_master_send(c, buffer, 5)))
+		tuner_warn("i2c i/o error: rc == %d (should be 5)\n", rc);
+}
+
 int tea5767_autodetection(struct i2c_client *c)
 {
 	unsigned char buffer[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (7 != (rc = i2c_master_recv(c, buffer, 7))) {
+	if ((rc = i2c_master_recv(c, buffer, 7))< 5) {
 		tuner_warn("It is not a TEA5767. Received %i bytes.\n", rc);
 		return EINVAL;
 	}
@@ -313,15 +325,10 @@ int tea5767_autodetection(struct i2c_cli
 	 *          bit 0   : internally set to 0
 	 *  Byte 5: bit 7:0 : == 0
 	 */
-	if (!((buffer[3] & 0x0f) == 0x00) && (buffer[4] == 0x00)) {
+	if (((buffer[3] & 0x0f) != 0x00) || (buffer[4] != 0x00)) {
 		tuner_warn("Chip ID is not zero. It is not a TEA5767\n");
 		return EINVAL;
 	}
-	/* It seems that tea5767 returns 0xff after the 5th byte */
-	if ((buffer[5] != 0xff) || (buffer[6] != 0xff)) {
-		tuner_warn("Returned more than 5 bytes. It is not a TEA5767\n");
-		return EINVAL;
-	}
 
 	/* It seems that tea5767 returns 0xff after the 5th byte */
 	if ((buffer[5] != 0xff) || (buffer[6] != 0xff)) {
@@ -337,14 +344,14 @@ int tea5767_tuner_init(struct i2c_client
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	tuner_info("type set to %d (%s)\n", t->type,
-			"Philips TEA5767HN FM Radio");
+	tuner_info("type set to %d (%s)\n", t->type, "Philips TEA5767HN FM Radio");
 	strlcpy(c->name, "tea5767", sizeof(c->name));
 
 	t->tv_freq = set_tv_freq;
 	t->radio_freq = set_radio_freq;
 	t->has_signal = tea5767_signal;
 	t->is_stereo = tea5767_stereo;
+	t->standby = tea5767_standby;
 
 	return (0);
 }
diff -upr linux-2.6.13-misc/drivers/media/video/tuner-core.c linux-2.6.13/drivers/media/video/tuner-core.c
--- linux-2.6.13-misc/drivers/media/video/tuner-core.c	2005-09-05 12:13:38.291584123 -0500
+++ linux-2.6.13/drivers/media/video/tuner-core.c	2005-09-05 11:49:51.574205575 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: tuner-core.c,v 1.63 2005/07/28 18:19:55 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -182,6 +181,14 @@ static void set_type(struct i2c_client *
 		i2c_master_send(c, buffer, 4);
 		default_tuner_init(c);
 		break;
+	case TUNER_LG_TDVS_H062F:
+		/* Set the Auxiliary Byte. */
+		buffer[2] &= ~0x20;
+		buffer[2] |= 0x18;
+		buffer[3] = 0x20;
+		i2c_master_send(c, buffer, 4);
+		default_tuner_init(c);
+		break;
 	default:
 		default_tuner_init(c);
 		break;
@@ -208,31 +215,31 @@ static void set_addr(struct i2c_client *
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (tun_setup->addr == ADDR_UNSET) {
-		if (t->mode_mask & tun_setup->mode_mask)
+	if ((tun_setup->addr == ADDR_UNSET &&
+		(t->mode_mask & tun_setup->mode_mask)) ||
+		tun_setup->addr == c->addr) {
 			set_type(c, tun_setup->type, tun_setup->mode_mask);
-	} else if (tun_setup->addr == c->addr) {
-		set_type(c, tun_setup->type, tun_setup->mode_mask);
 	}
 }
 
 static inline int check_mode(struct tuner *t, char *cmd)
 {
-	if (1 << t->mode & t->mode_mask) {
-		switch (t->mode) {
-		case V4L2_TUNER_RADIO:
-			tuner_dbg("Cmd %s accepted for radio\n", cmd);
-			break;
-		case V4L2_TUNER_ANALOG_TV:
-			tuner_dbg("Cmd %s accepted for analog TV\n", cmd);
-			break;
-		case V4L2_TUNER_DIGITAL_TV:
-			tuner_dbg("Cmd %s accepted for digital TV\n", cmd);
-			break;
-		}
-		return 0;
+	if ((1 << t->mode & t->mode_mask) == 0) {
+		return EINVAL;
+	}
+
+	switch (t->mode) {
+	case V4L2_TUNER_RADIO:
+		tuner_dbg("Cmd %s accepted for radio\n", cmd);
+		break;
+	case V4L2_TUNER_ANALOG_TV:
+		tuner_dbg("Cmd %s accepted for analog TV\n", cmd);
+		break;
+	case V4L2_TUNER_DIGITAL_TV:
+		tuner_dbg("Cmd %s accepted for digital TV\n", cmd);
+		break;
 	}
-	return EINVAL;
+	return 0;
 }
 
 static char pal[] = "-";
@@ -406,20 +413,18 @@ static int tuner_detach(struct i2c_clien
 
 static inline int set_mode(struct i2c_client *client, struct tuner *t, int mode, char *cmd)
 {
-	if (mode != t->mode) {
+ 	if (mode == t->mode)
+ 		return 0;
 
-		t->mode = mode;
-		if (check_mode(t, cmd) == EINVAL) {
-			t->mode = T_STANDBY;
-			if (V4L2_TUNER_RADIO == mode) {
-				set_tv_freq(client, 400 * 16);
-			} else {
-				set_radio_freq(client, 87.5 * 16000);
-			}
-			return EINVAL;
-		}
-	}
-	return 0;
+ 	t->mode = mode;
+
+ 	if (check_mode(t, cmd) == EINVAL) {
+ 		t->mode = T_STANDBY;
+ 		if (t->standby)
+ 			t->standby (client);
+ 		return EINVAL;
+  	}
+  	return 0;
 }
 
 #define switch_v4l2()	if (!t->using_v4l2) \
@@ -453,6 +458,14 @@ static int tuner_command(struct i2c_clie
 	case AUDC_SET_RADIO:
 		set_mode(client,t,V4L2_TUNER_RADIO, "AUDC_SET_RADIO");
 		break;
+	case TUNER_SET_STANDBY:
+		{
+			if (check_mode(t, "TUNER_SET_STANDBY") == EINVAL)
+				return 0;
+			if (t->standby)
+				t->standby (client);
+			break;
+		}
 	case AUDC_CONFIG_PINNACLE:
 		if (check_mode(t, "AUDC_CONFIG_PINNACLE") == EINVAL)
 			return 0;
diff -upr linux-2.6.13-misc/drivers/media/video/tuner-simple.c linux-2.6.13/drivers/media/video/tuner-simple.c
--- linux-2.6.13-misc/drivers/media/video/tuner-simple.c	2005-09-05 12:13:38.252598679 -0500
+++ linux-2.6.13/drivers/media/video/tuner-simple.c	2005-09-05 11:49:51.575205202 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: tuner-simple.c,v 1.43 2005/07/28 18:41:21 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -248,9 +247,10 @@ static struct tunertype tuners[] = {
 
 	{ "LG TDVS-H062F/TUA6034", LGINNOTEK, NTSC,
 	  16*160.00,16*455.00,0x01,0x02,0x04,0x8e,732},
-
 	{ "Ymec TVF66T5-B/DFF", Philips, PAL,
           16*160.25,16*464.25,0x01,0x02,0x08,0x8e,623},
+ 	{ "LG NTSC (TALN mini series)", LGINNOTEK, NTSC,
+	  16*150.00,16*425.00,0x01,0x02,0x08,0x8e,732 },
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
@@ -497,6 +497,7 @@ int default_tuner_init(struct i2c_client
 	t->radio_freq = default_set_radio_freq;
 	t->has_signal = tuner_signal;
 	t->is_stereo  = tuner_stereo;
+	t->standby = NULL;
 
 	return 0;
 }
diff -upr linux-2.6.13-misc/drivers/media/video/tveeprom.c linux-2.6.13/drivers/media/video/tveeprom.c
--- linux-2.6.13-misc/drivers/media/video/tveeprom.c	2005-09-05 12:13:38.250599425 -0500
+++ linux-2.6.13/drivers/media/video/tveeprom.c	2005-09-05 11:49:36.947665422 -0500
@@ -155,10 +155,10 @@ hauppauge_tuner[] =
 	{ TUNER_ABSENT,        "Philips FQ1216ME MK3"},
 	{ TUNER_ABSENT,        "Philips FI1236 MK3"},
 	{ TUNER_PHILIPS_FM1216ME_MK3, "Philips FM1216 ME MK3"},
-	{ TUNER_ABSENT,        "Philips FM1236 MK3"},
+	{ TUNER_PHILIPS_FM1236_MK3, "Philips FM1236 MK3"},
 	{ TUNER_ABSENT,        "Philips FM1216MP MK3"},
 	/* 60-69 */
-	{ TUNER_ABSENT,        "LG S001D MK3"},
+	{ TUNER_PHILIPS_FM1216ME_MK3, "LG S001D MK3"},
 	{ TUNER_ABSENT,        "LG M001D MK3"},
 	{ TUNER_ABSENT,        "LG S701D MK3"},
 	{ TUNER_ABSENT,        "LG M701D MK3"},
@@ -183,8 +183,8 @@ hauppauge_tuner[] =
 	{ TUNER_ABSENT,        "Philips FQ1216LME MK3"},
 	{ TUNER_ABSENT,        "LG TAPC G701D"},
 	{ TUNER_LG_NTSC_NEW_TAPC, "LG TAPC H791F"},
-	{ TUNER_ABSENT,        "TCL 2002MB 3"},
-	{ TUNER_ABSENT,        "TCL 2002MI 3"},
+	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MB 3"},
+	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MI 3"},
 	{ TUNER_TCL_2002N,     "TCL 2002N 6A"},
 	{ TUNER_ABSENT,        "Philips FQ1236 MK3"},
 	{ TUNER_ABSENT,        "Samsung TCPN 2121P30A"},
@@ -445,23 +445,6 @@ int tveeprom_read(struct i2c_client *c, 
 }
 EXPORT_SYMBOL(tveeprom_read);
 
-#if 0
-int tveeprom_dump(unsigned char *eedata, int len)
-{
-	int i;
-
-	dprintk(1, "%s\n",__FUNCTION__);
-	for (i = 0; i < len; i++) {
-		if (0 == (i % 16))
-			printk(KERN_INFO "tveeprom: %02x:",i);
-		printk(" %02x",eedata[i]);
-		if (15 == (i % 16))
-			printk("\n");
-	}
-	return 0;
-}
-EXPORT_SYMBOL(tveeprom_dump);
-#endif  /*  0  */
 
 /* ----------------------------------------------------------------------- */
 /* needed for ivtv.sf.net at the moment.  Should go away in the long       */
diff -upr linux-2.6.13-misc/drivers/media/video/tvmixer.c linux-2.6.13/drivers/media/video/tvmixer.c
--- linux-2.6.13-misc/drivers/media/video/tvmixer.c	2005-09-05 12:13:38.260595693 -0500
+++ linux-2.6.13/drivers/media/video/tvmixer.c	2005-09-05 11:49:08.297360082 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: tvmixer.c,v 1.8 2005/06/12 04:19:19 mchehab Exp $
  */
 
 #include <linux/module.h>
diff -upr linux-2.6.13-misc/drivers/media/video/v4l1-compat.c linux-2.6.13/drivers/media/video/v4l1-compat.c
--- linux-2.6.13-misc/drivers/media/video/v4l1-compat.c	2005-09-05 12:13:38.265593827 -0500
+++ linux-2.6.13/drivers/media/video/v4l1-compat.c	2005-09-05 11:49:43.085374317 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: v4l1-compat.c,v 1.9 2005/06/12 04:19:19 mchehab Exp $
  *
  *	Video for Linux Two
  *	Backward Compatibility Layer
@@ -604,9 +603,6 @@ v4l_compat_translate_ioctl(struct inode 
 			dprintk("VIDIOCGPICT / VIDIOC_G_FMT: %d\n",err);
 			break;
 		}
-#if 0 /* FIXME */
-		pict->depth   = fmt2->fmt.pix.depth;
-#endif
 		pict->palette = pixelformat_to_palette(
 			fmt2->fmt.pix.pixelformat);
 		break;
@@ -707,13 +703,7 @@ v4l_compat_translate_ioctl(struct inode 
 	}
 	case VIDIOCSTUNER: /*  select a tuner input  */
 	{
-#if 0 /* FIXME */
-		err = drv(inode, file, VIDIOC_S_INPUT, &i);
-		if (err < 0)
-			dprintk("VIDIOCSTUNER / VIDIOC_S_INPUT: %d\n",err);
-#else
 		err = 0;
-#endif
 		break;
 	}
 	case VIDIOCGFREQ: /*  get frequency  */
@@ -852,12 +842,6 @@ v4l_compat_translate_ioctl(struct inode 
 		err = 0;
 		break;
 	}
-#if 0
-	case VIDIOCGMBUF:
-		/* v4l2 drivers must implement that themself.  The
-		   mmap() differences can't be translated fully
-		   transparent, thus there is no point to try that */
-#endif
 	case VIDIOCMCAPTURE: /*  capture a frame  */
 	{
 		struct video_mmap	*mm = arg;
diff -upr linux-2.6.13-misc/drivers/media/video/v4l2-common.c linux-2.6.13/drivers/media/video/v4l2-common.c
--- linux-2.6.13-misc/drivers/media/video/v4l2-common.c	2005-09-05 12:13:38.304579272 -0500
+++ linux-2.6.13/drivers/media/video/v4l2-common.c	2005-09-05 11:49:43.085374317 -0500
@@ -84,20 +84,6 @@ MODULE_LICENSE("GPL");
  *  Video Standard Operations (contributed by Michael Schimek)
  */
 
-#if 0 /* seems to have no users */
-/* This is the recommended method to deal with the framerate fields. More
-   sophisticated drivers will access the fields directly. */
-unsigned int
-v4l2_video_std_fps(struct v4l2_standard *vs)
-{
-	if (vs->frameperiod.numerator > 0)
-		return (((vs->frameperiod.denominator << 8) /
-			 vs->frameperiod.numerator) +
-			(1 << 7)) / (1 << 8);
-	return 0;
-}
-EXPORT_SYMBOL(v4l2_video_std_fps);
-#endif
 
 /* Fill in the fields of a v4l2_standard structure according to the
    'id' and 'transmission' parameters.  Returns negative on error.  */
@@ -213,10 +199,6 @@ char *v4l2_ioctl_names[256] = {
 	[_IOC_NR(VIDIOC_ENUM_FMT)]       = "VIDIOC_ENUM_FMT",
 	[_IOC_NR(VIDIOC_G_FMT)]          = "VIDIOC_G_FMT",
 	[_IOC_NR(VIDIOC_S_FMT)]          = "VIDIOC_S_FMT",
-#if 0
-	[_IOC_NR(VIDIOC_G_COMP)]         = "VIDIOC_G_COMP",
-	[_IOC_NR(VIDIOC_S_COMP)]         = "VIDIOC_S_COMP",
-#endif
 	[_IOC_NR(VIDIOC_REQBUFS)]        = "VIDIOC_REQBUFS",
 	[_IOC_NR(VIDIOC_QUERYBUF)]       = "VIDIOC_QUERYBUF",
 	[_IOC_NR(VIDIOC_G_FBUF)]         = "VIDIOC_G_FBUF",
diff -upr linux-2.6.13-misc/drivers/media/video/video-buf.c linux-2.6.13/drivers/media/video/video-buf.c
--- linux-2.6.13-misc/drivers/media/video/video-buf.c	2005-09-05 12:13:38.249599798 -0500
+++ linux-2.6.13/drivers/media/video/video-buf.c	2005-09-05 11:49:08.316352992 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: video-buf.c,v 1.18 2005/02/24 13:32:30 kraxel Exp $
  *
  * generic helper functions for video4linux capture buffers, to handle
  * memory management and PCI DMA.  Right now bttv + saa7134 use it.
diff -upr linux-2.6.13-misc/drivers/media/video/video-buf-dvb.c linux-2.6.13/drivers/media/video/video-buf-dvb.c
--- linux-2.6.13-misc/drivers/media/video/video-buf-dvb.c	2005-09-05 12:13:38.212613607 -0500
+++ linux-2.6.13/drivers/media/video/video-buf-dvb.c	2005-09-05 11:49:08.316352992 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: video-buf-dvb.c,v 1.7 2004/12/09 12:51:35 kraxel Exp $
  *
  * some helper function for simple DVB cards which simply DMA the
  * complete transport stream and let the computer sort everything else
diff -upr linux-2.6.13-misc/include/linux/videodev2.h linux-2.6.13/include/linux/videodev2.h
--- linux-2.6.13-misc/include/linux/videodev2.h	2005-09-05 12:13:48.922615053 -0500
+++ linux-2.6.13/include/linux/videodev2.h	2005-09-05 11:49:43.084374691 -0500
@@ -270,7 +270,6 @@ struct v4l2_timecode
 /* The above is based on SMPTE timecodes */
 
 
-#if 1
 /*
  *	M P E G   C O M P R E S S I O N   P A R A M E T E R S
  *
@@ -357,7 +356,6 @@ struct v4l2_mpeg_compression {
 	/* I don't expect the above being perfect yet ;) */
 	__u32				reserved_5[8];
 };
-#endif
 
 struct v4l2_jpegcompression
 {
@@ -871,10 +869,8 @@ struct v4l2_streamparm
 #define VIDIOC_ENUM_FMT         _IOWR ('V',  2, struct v4l2_fmtdesc)
 #define VIDIOC_G_FMT		_IOWR ('V',  4, struct v4l2_format)
 #define VIDIOC_S_FMT		_IOWR ('V',  5, struct v4l2_format)
-#if 1 /* experimental */
 #define VIDIOC_G_MPEGCOMP       _IOR  ('V',  6, struct v4l2_mpeg_compression)
 #define VIDIOC_S_MPEGCOMP     	_IOW  ('V',  7, struct v4l2_mpeg_compression)
-#endif
 #define VIDIOC_REQBUFS		_IOWR ('V',  8, struct v4l2_requestbuffers)
 #define VIDIOC_QUERYBUF		_IOWR ('V',  9, struct v4l2_buffer)
 #define VIDIOC_G_FBUF		_IOR  ('V', 10, struct v4l2_framebuffer)
diff -upr linux-2.6.13-misc/include/linux/videodev.h linux-2.6.13/include/linux/videodev.h
--- linux-2.6.13-misc/include/linux/videodev.h	2005-09-05 12:13:48.986591168 -0500
+++ linux-2.6.13/include/linux/videodev.h	2005-09-05 11:49:43.084374691 -0500
@@ -3,7 +3,6 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 #define HAVE_V4L2 1
 #include <linux/videodev2.h>
@@ -29,7 +28,6 @@ struct video_device
 	void (*release)(struct video_device *vfd);
 
 
-#if 1 /* to be removed in 2.7.x */
 	/* obsolete -- fops->owner is used instead */
 	struct module *owner;
 	/* dev->driver_data will be used instead some day.
@@ -37,7 +35,6 @@ struct video_device
 	 * so the switch over will be transparent for you.
 	 * Or use {pci|usb}_{get|set}_drvdata() directly. */
 	void *priv;
-#endif
 
 	/* for videodev.c intenal usage -- please don't touch */
 	int users;                     /* video_exclusive_{open|close} ... */
diff -upr linux-2.6.13-misc/include/media/audiochip.h linux-2.6.13/include/media/audiochip.h
--- linux-2.6.13-misc/include/media/audiochip.h	2005-09-05 12:13:49.131537053 -0500
+++ linux-2.6.13/include/media/audiochip.h	2005-09-05 11:49:08.296360455 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: audiochip.h,v 1.5 2005/06/16 22:59:16 hhackmann Exp $
  */
 
 #ifndef AUDIOCHIP_H
diff -upr linux-2.6.13-misc/include/media/id.h linux-2.6.13/include/media/id.h
--- linux-2.6.13-misc/include/media/id.h	2005-09-05 12:13:49.133536306 -0500
+++ linux-2.6.13/include/media/id.h	2005-09-05 11:49:08.297360082 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: id.h,v 1.4 2005/06/12 04:19:19 mchehab Exp $
  */
 
 /* FIXME: this temporarely, until these are included in linux/i2c-id.h */
diff -upr linux-2.6.13-misc/include/media/ir-common.h linux-2.6.13/include/media/ir-common.h
--- linux-2.6.13-misc/include/media/ir-common.h	2005-09-05 12:13:49.133536306 -0500
+++ linux-2.6.13/include/media/ir-common.h	2005-09-05 11:49:25.334000605 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: ir-common.h,v 1.9 2005/05/15 19:01:26 mchehab Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -21,11 +20,11 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/version.h>
 #include <linux/input.h>
 
 
 #define IR_TYPE_RC5     1
+#define IR_TYPE_PD      2 /* Pulse distance encoded IR */
 #define IR_TYPE_OTHER  99
 
 #define IR_KEYTAB_TYPE	u32
@@ -60,6 +59,7 @@ void ir_input_keydown(struct input_dev *
 u32  ir_extract_bits(u32 data, u32 mask);
 int  ir_dump_samples(u32 *samples, int count);
 int  ir_decode_biphase(u32 *samples, int count, int low, int high);
+int  ir_decode_pulsedistance(u32 *samples, int count, int low, int high);
 
 /*
  * Local variables:
diff -upr linux-2.6.13-misc/include/media/tuner.h linux-2.6.13/include/media/tuner.h
--- linux-2.6.13-misc/include/media/tuner.h	2005-09-05 12:13:49.133536306 -0500
+++ linux-2.6.13/include/media/tuner.h	2005-09-05 11:49:51.574205575 -0500
@@ -1,5 +1,3 @@
-
-/* $Id: tuner.h,v 1.45 2005/07/28 18:41:21 mchehab Exp $
  *
     tuner.h - definition for different tuners
 
@@ -111,6 +109,8 @@
 #define TUNER_LG_TDVS_H062F   64	/* DViCO FusionHDTV 5 */
 #define TUNER_YMEC_TVF66T5_B_DFF 65	/* Acorp Y878F */
 
+#define TUNER_LG_NTSC_TALN_MINI 66
+
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
 #define PAL_I   2
@@ -134,6 +134,7 @@
 #define THOMSON 12
 
 #define TUNER_SET_TYPE_ADDR          _IOW('T',3,int)
+#define TUNER_SET_STANDBY            _IOW('T',4,int)
 #define TDA9887_SET_CONFIG           _IOW('t',5,int)
 
 /* tv card specific */
@@ -153,9 +154,6 @@
 
 #ifdef __KERNEL__
 
-#define I2C_ADDR_TDA8290        0x4b
-#define I2C_ADDR_TDA8275        0x61
-
 enum tuner_mode {
 	T_UNINITIALIZED = 0,
 	T_RADIO		= 1 << V4L2_TUNER_RADIO,
@@ -198,6 +196,7 @@ struct tuner {
 	void (*radio_freq)(struct i2c_client *c, unsigned int freq);
 	int  (*has_signal)(struct i2c_client *c);
 	int  (*is_stereo)(struct i2c_client *c);
+	void (*standby)(struct i2c_client *c);
 };
 
 extern unsigned int tuner_debug;
@@ -209,12 +208,16 @@ extern int tea5767_tuner_init(struct i2c
 extern int default_tuner_init(struct i2c_client *c);
 extern int tea5767_autodetection(struct i2c_client *c);
 
-#define tuner_warn(fmt, arg...) \
-	dev_printk(KERN_WARNING , &t->i2c.dev , fmt , ## arg)
-#define tuner_info(fmt, arg...) \
-	dev_printk(KERN_INFO , &t->i2c.dev , fmt , ## arg)
-#define tuner_dbg(fmt, arg...) \
-	if (tuner_debug) dev_printk(KERN_DEBUG , &t->i2c.dev , fmt , ## arg)
+#define tuner_warn(fmt, arg...) do {\
+	printk(KERN_WARNING "%s %d-%04x: " fmt, t->i2c.driver->name, \
+                        t->i2c.adapter->nr, t->i2c.addr, ## arg); } while (0)
+#define tuner_info(fmt, arg...) do {\
+	printk(KERN_INFO "%s %d-%04x: " fmt, t->i2c.driver->name, \
+                        t->i2c.adapter->nr, t->i2c.addr, ## arg); } while (0)
+#define tuner_dbg(fmt, arg...) do {\
+	if (tuner_debug) \
+                printk(KERN_DEBUG "%s %d-%04x: " fmt, t->i2c.driver->name, \
+                        t->i2c.adapter->nr, t->i2c.addr, ## arg); } while (0)
 
 #endif /* __KERNEL__ */
 
diff -upr linux-2.6.13-misc/include/media/tveeprom.h linux-2.6.13/include/media/tveeprom.h
--- linux-2.6.13-misc/include/media/tveeprom.h	2005-09-05 12:13:49.133536306 -0500
+++ linux-2.6.13/include/media/tveeprom.h	2005-09-05 11:49:08.314353738 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: tveeprom.h,v 1.2 2005/06/12 04:19:19 mchehab Exp $
  */
 
 struct tveeprom {
diff -upr linux-2.6.13-misc/include/media/video-buf.h linux-2.6.13/include/media/video-buf.h
--- linux-2.6.13-misc/include/media/video-buf.h	2005-09-05 12:13:49.132536679 -0500
+++ linux-2.6.13/include/media/video-buf.h	2005-09-05 11:49:08.315353365 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: video-buf.h,v 1.9 2004/11/07 13:17:15 kraxel Exp $
  *
  * generic helper functions for video4linux capture buffers, to handle
  * memory management and PCI DMA.  Right now bttv + saa7134 use it.

--=_431cb7f6.AmFFSEAag8DMRvOpQWQrrSuVnKCdpO2D92BUUJaCNwsAHa03--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVATPm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVATPm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVATPlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:41:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17572 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262158AbVATPaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:30:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:26:56 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner update
Message-ID: <20050120152656.GA12938@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- add new tuner types.
- add support for digital tv tuning.
- make tda9887 output ports more configurable.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tda9887.c |   38 +++++++++++++++------
 drivers/media/video/tuner.c   |   60 +++++++++++++++++++---------------
 include/media/tuner.h         |    8 +++-
 3 files changed, 69 insertions(+), 37 deletions(-)

Index: linux-2.6.10/include/media/tuner.h
===================================================================
--- linux-2.6.10.orig/include/media/tuner.h	2004-12-29 23:57:53.000000000 +0100
+++ linux-2.6.10/include/media/tuner.h	2005-01-19 14:12:25.168221195 +0100
@@ -77,6 +77,7 @@
 #define TUNER_MICROTUNE_4042FI5  49	/* FusionHDTV 3 Gold - 4042 FI5 (3X 8147) */
 #define TUNER_TCL_2002N          50
 #define TUNER_PHILIPS_FM1256_IH3   51
+#define TUNER_THOMSON_DTT7610    52
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
@@ -97,6 +98,7 @@
 #define HITACHI 9
 #define Panasonic 10
 #define TCL     11
+#define THOMSON 12
 
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
@@ -108,10 +110,12 @@
 #define  TDA9887_SET_CONFIG          _IOW('t',5,int)
 /* tv card specific */
 # define TDA9887_PRESENT             (1<<0)
-# define TDA9887_PORT1               (1<<1)
-# define TDA9887_PORT2               (1<<2)
+# define TDA9887_PORT1_INACTIVE      (1<<1)
+# define TDA9887_PORT2_INACTIVE      (1<<2)
 # define TDA9887_QSS                 (1<<3)
 # define TDA9887_INTERCARRIER        (1<<4)
+# define TDA9887_PORT1_ACTIVE        (1<<5)
+# define TDA9887_PORT2_ACTIVE        (1<<6)
 /* config options */
 # define TDA9887_DEEMPHASIS_MASK     (3<<16)
 # define TDA9887_DEEMPHASIS_NONE     (1<<16)
Index: linux-2.6.10/drivers/media/video/tuner.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/tuner.c	2004-12-30 00:00:10.000000000 +0100
+++ linux-2.6.10/drivers/media/video/tuner.c	2005-01-19 14:12:25.169221007 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner.c,v 1.31 2004/11/10 11:07:24 kraxel Exp $
+ * $Id: tuner.c,v 1.36 2005/01/14 13:29:40 kraxel Exp $
  */
 
 #include <linux/module.h>
@@ -62,7 +62,7 @@ struct tuner {
 	v4l2_std_id  std;
 	int          using_v4l2;
 
-	unsigned int radio;
+	enum v4l2_tuner_type mode;
 	unsigned int input;
 
 	// only for MT2032
@@ -265,6 +265,11 @@ static struct tunertype tuners[] = {
 	{ "Philips PAL/SECAM_D (FM 1256 I-H3)", Philips, PAL,
 	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,623 },
 
+	{ "Thomson DDT 7610 ATSC/NTSC)", THOMSON, ATSC,
+	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
+	{ "Philips FQ1286", Philips, NTSC,
+	  16*160.00,16*454.00,0x41,0x42,0x04,0x8e,940}, // UHF band untested
+
 };
 #define TUNERS ARRAY_SIZE(tuners)
 
@@ -663,7 +668,8 @@ static void mt2050_set_if_freq(struct i2
 	int ret;
 	unsigned char buf[6];
 
-	dprintk("mt2050_set_if_freq freq=%d\n",freq);
+	dprintk("mt2050_set_if_freq freq=%d if1=%d if2=%d\n",
+		freq,if1,if2);
 
 	f_lo1=freq+if1;
 	f_lo1=(f_lo1/1000000)*1000000;
@@ -688,9 +694,10 @@ static void mt2050_set_if_freq(struct i2
 	div2a=(lo2/8)-1;
 	div2b=lo2-(div2a+1)*8;
 
-	dprintk("lo1 lo2 = %d %d\n", lo1, lo2);
-        dprintk("num1 num2 div1a div1b div2a div2b= %x %x %x %x %x %x\n",num1,num2,div1a,div1b,div2a,div2b);
-
+	if (debug > 1) {
+		printk("lo1 lo2 = %d %d\n", lo1, lo2);
+		printk("num1 num2 div1a div1b div2a div2b= %x %x %x %x %x %x\n",num1,num2,div1a,div1b,div2a,div2b);
+	}
 
 	buf[0]=1;
 	buf[1]= 4*div1b + num1;
@@ -702,7 +709,7 @@ static void mt2050_set_if_freq(struct i2
 	buf[5]=div2a;
 	if(num2!=0) buf[5]=buf[5]|0x40;
 
-	if(debug) {
+	if (debug > 1) {
 		int i;
 		printk("bufs is: ");
 		for(i=0;i<6;i++)
@@ -727,6 +734,10 @@ static void mt2050_set_tv_freq(struct i2
                 // PAL
                 if2 = 38900*1000;
         }
+	if (V4L2_TUNER_DIGITAL_TV == t->mode) {
+		// testing for DVB ...
+		if2 = 36150*1000;
+	}
 	mt2050_set_if_freq(c, freq*62500, if2);
 	mt2050_set_antenna(c, tv_antenna);
 }
@@ -1069,14 +1080,18 @@ static void set_freq(struct i2c_client *
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (t->radio) {
+	switch (t->mode) {
+	case V4L2_TUNER_RADIO:
 		dprintk("tuner: radio freq set to %lu.%02lu\n",
 			freq/16,freq%16*100/16);
 		set_radio_freq(c,freq);
-	} else {
+		break;
+	case V4L2_TUNER_ANALOG_TV:
+	case V4L2_TUNER_DIGITAL_TV:
 		dprintk("tuner: tv freq set to %lu.%02lu\n",
 			freq/16,freq%16*100/16);
 		set_tv_freq(c, freq);
+		break;
 	}
 	t->freq = freq;
 }
@@ -1237,9 +1252,9 @@ tuner_command(struct i2c_client *client,
 		set_type(client,*iarg,client->adapter->name);
 		break;
 	case AUDC_SET_RADIO:
-		if (!t->radio) {
+		if (V4L2_TUNER_RADIO != t->mode) {
 			set_tv_freq(client,400 * 16);
-			t->radio = 1;
+			t->mode = V4L2_TUNER_RADIO;
 		}
 		break;
 	case AUDC_CONFIG_PINNACLE:
@@ -1271,7 +1286,7 @@ tuner_command(struct i2c_client *client,
 		struct video_channel *vc = arg;
 
 		CHECK_V4L2;
-		t->radio = 0;
+		t->mode = V4L2_TUNER_ANALOG_TV;
 		if (vc->norm < ARRAY_SIZE(map))
 			t->std = map[vc->norm];
 		tuner_fixup_std(t);
@@ -1292,7 +1307,7 @@ tuner_command(struct i2c_client *client,
 		struct video_tuner *vt = arg;
 
 		CHECK_V4L2;
-		if (t->radio)
+		if (V4L2_TUNER_RADIO == t->mode)
 			vt->signal = tuner_signal(client);
 		return 0;
 	}
@@ -1301,7 +1316,7 @@ tuner_command(struct i2c_client *client,
 		struct video_audio *va = arg;
 
 		CHECK_V4L2;
-		if (t->radio)
+		if (V4L2_TUNER_RADIO == t->mode)
 			va->mode = (tuner_stereo(client) ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO);
 		return 0;
 	}
@@ -1311,7 +1326,7 @@ tuner_command(struct i2c_client *client,
 		v4l2_std_id *id = arg;
 
 		SWITCH_V4L2;
-		t->radio = 0;
+		t->mode = V4L2_TUNER_ANALOG_TV;
 		t->std = *id;
 		tuner_fixup_std(t);
 		if (t->freq)
@@ -1323,15 +1338,10 @@ tuner_command(struct i2c_client *client,
 		struct v4l2_frequency *f = arg;
 
 		SWITCH_V4L2;
-		if (V4L2_TUNER_ANALOG_TV == f->type) {
-			t->radio = 0;
-		}
-		if (V4L2_TUNER_RADIO == f->type) {
-			if (!t->radio) {
-				set_tv_freq(client,400*16);
-				t->radio = 1;
-			}
-		}
+		if (V4L2_TUNER_RADIO == f->type &&
+		    V4L2_TUNER_RADIO != t->mode)
+			set_tv_freq(client,400*16);
+		t->mode  = f->type;
 		t->freq  = f->frequency;
 		set_freq(client,t->freq);
 		break;
@@ -1341,7 +1351,7 @@ tuner_command(struct i2c_client *client,
 		struct v4l2_tuner *tuner = arg;
 
 		SWITCH_V4L2;
-		if (t->radio)
+		if (V4L2_TUNER_RADIO == t->mode)
 			tuner->signal = tuner_signal(client);
 		break;
 	}
Index: linux-2.6.10/drivers/media/video/tda9887.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/tda9887.c	2004-12-29 23:59:46.000000000 +0100
+++ linux-2.6.10/drivers/media/video/tda9887.c	2005-01-19 14:12:25.169221007 +0100
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
 #include <linux/types.h>
@@ -27,6 +28,7 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {
+	0x84 >>1,
 	0x86 >>1,
 	0x96 >>1,
 	I2C_CLIENT_END,
@@ -374,8 +376,8 @@ static int tda9887_set_tvnorm(struct tda
 	return 0;
 }
 
-static unsigned int port1  = 1;
-static unsigned int port2  = 1;
+static unsigned int port1  = UNSET;
+static unsigned int port2  = UNSET;
 static unsigned int qss    = UNSET;
 static unsigned int adjust = 0x10;
 module_param(port1, int, 0644);
@@ -385,10 +387,19 @@ module_param(adjust, int, 0644);
 
 static int tda9887_set_insmod(struct tda9887 *t, char *buf)
 {
-	if (port1)
-		buf[1] |= cOutputPort1Inactive;
-	if (port2)
-		buf[1] |= cOutputPort2Inactive;
+	if (UNSET != port1) {
+		if (port1)
+			buf[1] |= cOutputPort1Inactive;
+		else
+			buf[1] &= ~cOutputPort1Inactive;
+	}
+	if (UNSET != port2) {
+		if (port2)
+			buf[1] |= cOutputPort2Inactive;
+		else
+			buf[1] &= ~cOutputPort2Inactive;
+	}
+
 	if (UNSET != qss) {
 		if (qss)
 			buf[1] |= cQSS;
@@ -403,10 +414,15 @@ static int tda9887_set_insmod(struct tda
 
 static int tda9887_set_config(struct tda9887 *t, char *buf)
 {
-	if (t->config & TDA9887_PORT1)
+	if (t->config & TDA9887_PORT1_ACTIVE)
+		buf[1] &= ~cOutputPort1Inactive;
+	if (t->config & TDA9887_PORT1_INACTIVE)
 		buf[1] |= cOutputPort1Inactive;
-	if (t->config & TDA9887_PORT2)
+	if (t->config & TDA9887_PORT2_ACTIVE)
+		buf[1] &= ~cOutputPort2Inactive;
+	if (t->config & TDA9887_PORT2_INACTIVE)
 		buf[1] |= cOutputPort2Inactive;
+
 	if (t->config & TDA9887_QSS)
 		buf[1] |= cQSS;
 	if (t->config & TDA9887_INTERCARRIER)
@@ -437,14 +453,14 @@ static int tda9887_set_pinnacle(struct t
 {
 	unsigned int bCarrierMode = UNSET;
 
-	if (t->std & V4L2_STD_PAL) {
+	if (t->std & V4L2_STD_625_50) {
 		if ((1 == t->pinnacle_id) || (7 == t->pinnacle_id)) {
 			bCarrierMode = cIntercarrier;
 		} else {
 			bCarrierMode = cQSS;
 		}
 	}
-	if (t->std & V4L2_STD_NTSC) {
+	if (t->std & V4L2_STD_525_60) {
                 if ((5 == t->pinnacle_id) || (6 == t->pinnacle_id)) {
 			bCarrierMode = cIntercarrier;
 		} else {
@@ -529,6 +545,8 @@ static int tda9887_configure(struct tda9
 	int rc;
 
 	memset(buf,0,sizeof(buf));
+	buf[1] |= cOutputPort1Inactive;
+	buf[1] |= cOutputPort2Inactive;
 	tda9887_set_tvnorm(t,buf);
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);

-- 
#define printk(args...) fprintf(stderr, ## args)

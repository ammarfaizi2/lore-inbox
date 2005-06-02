Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFBMZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFBMZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFBMZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:25:58 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:13711 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261389AbVFBMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:24:59 -0400
Message-ID: <429EFA98.6020503@brturbo.com.br>
Date: Thu, 02 Jun 2005 09:24:56 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: Fwd: [PATCH] tuner-core.c improvments and Ymec Tvision TVF8533MF
 support]
References: <429E2792.7000700@brturbo.com.br>
In-Reply-To: <429E2792.7000700@brturbo.com.br>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------020309050504040809050606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020309050504040809050606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I'm resubmiting the patch because I forgot diff for
include/media/tuner.h. The patch is now complete. It is for
linux-2.6.12-rc5-mm2.

>tuner-core.c, tuner.h, Kconfig:
>
>        - tuner-core changed to support multiple I2C devices used on
>some adapters;
>        - Kconfig now has an option (CONFIG_TUNER_MULTI_I2C) to enable
>this new behavor;
>        - By default, even enabling CONFIG_TUNER_MULTI_I2C, tuner-core
>emulates the old behavor,  using first I2C device for both FM and TV;
>        - There is a new i2c command (TUNER_SET_ADDR) to allow tuner
>clients to select I2C address for FM or TV tuner;
>        - Tuner I2C dettach now generates a warning on syslog if failed.
>
>tuner-simple.c:
>        - TVision TVF-8531MF and TVF-5533 MF tuner included. It uses, by
>default, I2C on 0xC2 address for TV and on 0xC0 for Radio. Both TV and
>FM Radio mode are working.
>
>Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>  
>


--------------020309050504040809050606
Content-Type: text/x-patch;
 name="ymec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ymec.diff"

diff -ur linux-2.6.12-rc5-mm.org/drivers/media/video/Kconfig linux-2.6.12-rc5-mm/drivers/media/video/Kconfig
--- linux-2.6.12-rc5-mm.org/drivers/media/video/Kconfig	2005-06-01 09:56:38.000000000 -0300
+++ linux-2.6.12-rc5-mm/drivers/media/video/Kconfig	2005-06-01 15:55:00.000000000 -0300
@@ -7,6 +7,19 @@
 
 comment "Video Adapters"
 
+config CONFIG_TUNER_MULTI_I2C
+	bool "Enable support for multiple I2C devices on Video Adapters (EXPERIMENTAL)"
+	depends on VIDEO_DEV && EXPERIMENTAL
+	---help---
+	  Some video adapters have more than one tuner inside. This patch 
+	  enables support for using more than one tuner. This is required
+	  for some cards to allow tunning  both video and radio.
+	  It also improves I2C autodetection for these cards.
+
+	  Only few tuners currently is supporting this. More to come.
+
+	  It is safe to say 'Y' here even if your card has only one I2C tuner.
+
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
 	depends on VIDEO_DEV && PCI && I2C
diff -ur linux-2.6.12-rc5-mm.org/drivers/media/video/tuner-core.c linux-2.6.12-rc5-mm/drivers/media/video/tuner-core.c
--- linux-2.6.12-rc5-mm.org/drivers/media/video/tuner-core.c	2005-06-01 09:56:38.000000000 -0300
+++ linux-2.6.12-rc5-mm/drivers/media/video/tuner-core.c	2005-06-01 16:02:39.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.5 2005/02/15 15:59:35 kraxel Exp $
+ * $Id: tuner-core.c,v 1.7 2005/05/30 02:02:47 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -23,6 +23,11 @@
 #include <media/tuner.h>
 #include <media/audiochip.h>
 
+/*
+ * comment line bellow to return to old behavor, where only one I2C device is supported
+ */
+/* #define CONFIG_TUNER_MULTI_I2C */
+
 #define UNSET (-1U)
 
 /* standard i2c insmod options */
@@ -53,6 +58,9 @@
 MODULE_LICENSE("GPL");
 
 static int this_adap;
+#ifdef CONFIG_TUNER_MULTI_I2C
+static unsigned short tv_tuner, radio_tuner;
+#endif
 
 static struct i2c_driver driver;
 static struct i2c_client client_template;
@@ -125,6 +133,28 @@
 	t->freq = freq;
 }
 
+#ifdef CONFIG_TUNER_MULTI_I2C
+static void set_addr(struct i2c_client *c, struct tuner_addr *tun_addr)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	
+	switch (tun_addr->type) {
+	case V4L2_TUNER_RADIO:
+ 		radio_tuner=tun_addr->addr;
+		tuner_dbg("radio tuner set to I2C address 0x%02x\n",radio_tuner<<1);
+
+		break;
+	default:
+		tv_tuner=tun_addr->addr;
+		tuner_dbg("TV tuner set to I2C address 0x%02x\n",tv_tuner<<1);
+		break;
+	}
+}
+#else
+#define set_addr(c,tun_addr) \
+		tuner_warn("It is recommended to enable CONFIG_TUNER_MULTI_I2C for this card.\n");
+#endif
+
 static void set_type(struct i2c_client *c, unsigned int type)
 {
 	struct tuner *t = i2c_get_clientdata(c);
@@ -197,8 +227,16 @@
 {
 	struct tuner *t;
 
+#ifndef CONFIG_TUNER_MULTI_I2C
 	if (this_adap > 0)
 		return -1;
+#else
+	/* by default, first I2C card is both tv and radio tuner */
+	if (this_adap == 0) {
+		tv_tuner = addr;
+		radio_tuner = addr;
+	}
+#endif
 	this_adap++;
 
         client_template.adapter = adap;
@@ -228,6 +266,11 @@
 	}
 	this_adap = 0;
 
+#ifdef CONFIG_TUNER_MULTI_I2C
+	tv_tuner = 0;
+	radio_tuner = 0;
+#endif
+
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tuner_attach);
 	return 0;
@@ -236,8 +279,14 @@
 static int tuner_detach(struct i2c_client *client)
 {
 	struct tuner *t = i2c_get_clientdata(client);
+	int err;
 
-	i2c_detach_client(&t->i2c);
+	err=i2c_detach_client(&t->i2c);
+	if (err) {
+		tuner_warn ("Client deregistration failed, client not detached.\n");
+		return err;
+	}
+	
 	kfree(t);
 	return 0;
 }
@@ -248,7 +297,18 @@
 #define CHECK_V4L2	if (t->using_v4l2) { if (tuner_debug) \
 			  tuner_info("ignore v4l1 call\n"); \
 		          return 0; }
-
+			  
+#ifdef CONFIG_TUNER_MULTI_I2C
+#define CHECK_ADDR(tp,cmd)	if (client->addr!=tp) { \
+			  tuner_info ("Cmd %s to addr 0x%02x rejected.\n",cmd,client->addr<<1); \
+			  return 0; }
+#define CHECK_MODE(cmd)	if (t->mode == V4L2_TUNER_RADIO) { \
+			  CHECK_ADDR(radio_tuner,cmd) } else { CHECK_ADDR(tv_tuner,cmd); }
+#else
+#define CHECK_ADDR(tp,cmd)
+#define CHECK_MODE(cmd)
+#endif
+			  
 static int
 tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
@@ -256,18 +316,23 @@
         unsigned int *iarg = (int*)arg;
 
         switch (cmd) {
-
 	/* --- configuration --- */
 	case TUNER_SET_TYPE:
 		set_type(client,*iarg);
 		break;
+	case TUNER_SET_ADDR:
+		set_addr(client,(struct tuner_addr *)arg);
+		break;
 	case AUDC_SET_RADIO:
+		CHECK_ADDR(radio_tuner,"AUDC_SET_RADIO");
+		
 		if (V4L2_TUNER_RADIO != t->mode) {
 			set_tv_freq(client,400 * 16);
 			t->mode = V4L2_TUNER_RADIO;
 		}
 		break;
 	case AUDC_CONFIG_PINNACLE:
+		CHECK_ADDR(tv_tuner,"AUDC_CONFIG_PINNACLE");
 		switch (*iarg) {
 		case 2:
 			tuner_dbg("pinnacle pal\n");
@@ -295,6 +360,7 @@
 		};
 		struct video_channel *vc = arg;
 
+		CHECK_ADDR(tv_tuner,"VIDIOCSCHAN");
 		CHECK_V4L2;
 		t->mode = V4L2_TUNER_ANALOG_TV;
 		if (vc->norm < ARRAY_SIZE(map))
@@ -308,6 +374,7 @@
 	{
 		unsigned long *v = arg;
 
+		CHECK_MODE("VIDIOCSFREQ");
 		CHECK_V4L2;
 		set_freq(client,*v);
 		return 0;
@@ -316,6 +383,7 @@
 	{
 		struct video_tuner *vt = arg;
 
+		CHECK_ADDR(radio_tuner,"VIDIOCGTUNER:");
 		CHECK_V4L2;
 		if (V4L2_TUNER_RADIO == t->mode  &&  t->has_signal)
 			vt->signal = t->has_signal(client);
@@ -325,6 +393,7 @@
 	{
 		struct video_audio *va = arg;
 
+		CHECK_ADDR(radio_tuner,"VIDIOCGAUDIO");
 		CHECK_V4L2;
 		if (V4L2_TUNER_RADIO == t->mode  &&  t->is_stereo)
 			va->mode = t->is_stereo(client)
@@ -337,6 +406,7 @@
 	{
 		v4l2_std_id *id = arg;
 
+		CHECK_ADDR(tv_tuner,"VIDIOC_S_STD");
 		SWITCH_V4L2;
 		t->mode = V4L2_TUNER_ANALOG_TV;
 		t->std = *id;
@@ -349,6 +419,7 @@
 	{
 		struct v4l2_frequency *f = arg;
 
+		CHECK_MODE("VIDIOC_S_FREQUENCY");
 		SWITCH_V4L2;
 		if (V4L2_TUNER_RADIO == f->type &&
 		    V4L2_TUNER_RADIO != t->mode)
@@ -361,6 +432,7 @@
 	{
 		struct v4l2_frequency *f = arg;
 
+		CHECK_MODE("VIDIOC_G_FREQUENCY");
 		SWITCH_V4L2;
 		f->type = t->mode;
 		f->frequency = t->freq;
@@ -370,6 +442,7 @@
 	{
 		struct v4l2_tuner *tuner = arg;
 
+		CHECK_MODE("VIDIOC_G_TUNER");
 		SWITCH_V4L2;
 		if (V4L2_TUNER_RADIO == t->mode  &&  t->has_signal)
 			tuner->signal = t->has_signal(client);
diff -ur linux-2.6.12-rc5-mm.org/drivers/media/video/tuner-simple.c linux-2.6.12-rc5-mm/drivers/media/video/tuner-simple.c
--- linux-2.6.12-rc5-mm.org/drivers/media/video/tuner-simple.c	2005-05-25 00:31:20.000000000 -0300
+++ linux-2.6.12-rc5-mm/drivers/media/video/tuner-simple.c	2005-06-01 15:28:08.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.10 2005/03/08 08:38:00 kraxel Exp $
+ * $Id: tuner-simple.c,v 1.14 2005/05/30 02:02:47 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -212,6 +212,11 @@
         { "Philips FQ1236A MK4", Philips, NTSC,
           16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
 
+	/* Should work for TVF8531MF, TVF8831MF, TVF8731MF */
+	{ "Ymec TVision TVF-8531MF", Philips, NTSC,
+	  16*160.00,16*454.00,0xa0,0x90,0x30,0x8e,732},
+	{ "Ymec TVision TVF-5533MF", Philips, NTSC,
+	  16*160.00,16*454.00,0x01,0x02,0x04,0x8e,732},
 };
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
 
@@ -424,6 +429,13 @@
 	buffer[2] = tun->config;
 
 	switch (t->type) {
+	case TUNER_YMEC_TVF_5533MF:
+		
+		/*These values are empirically determinated */
+		div = (freq*122)/16 - 20;
+		buffer[2] = 0x88; /* could be also 0x80 */
+		buffer[3] = 0x19; /* could be also 0x10, 0x18, 0x99 */
+		break;
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 		buffer[3] = 0x19;
@@ -457,7 +469,21 @@
 	tuner_info("type set to %d (%s)\n",
 		   t->type, tuners[t->type].name);
 	strlcpy(c->name, tuners[t->type].name, sizeof(c->name));
-
+	
+	switch (t->type) {
+	case TUNER_YMEC_TVF_5533MF:
+		{
+			struct tuner_addr tun_addr = { V4L2_TUNER_ANALOG_TV, 0xc2>>1 };
+			
+			if (c->driver->command) {
+				c->driver->command(c, TUNER_SET_ADDR, &tun_addr);
+			} else {
+				tuner_warn("Couldn't set TV tuner I2C address to 0x%02x\n",tun_addr.addr<<1);
+			}
+			break;
+		}
+	}
+	
 	t->tv_freq    = default_set_tv_freq;
 	t->radio_freq = default_set_radio_freq;
 	t->has_signal = tuner_signal;
diff -ur linux-2.6.12-rc5-mm.org/include/media/tuner.h linux-2.6.12-rc5-mm/include/media/tuner.h
--- linux-2.6.12-rc5-mm.org/include/media/tuner.h	2005-05-25 00:31:20.000000000 -0300
+++ linux-2.6.12-rc5-mm/include/media/tuner.h	2005-06-01 15:27:01.000000000 -0300
@@ -98,6 +98,9 @@
 #define TUNER_PHILIPS_FQ1216AME_MK4 56 /* Hauppauge PVR-150 PAL */
 #define TUNER_PHILIPS_FQ1236A_MK4 57   /* Hauppauge PVR-500MCE NTSC */
 
+#define TUNER_YMEC_TVF_8531MF 58
+#define TUNER_YMEC_TVF_5533MF 59	/* Pixelview Pro Ultra NTSC */
+
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
 #define PAL_I   2
@@ -121,8 +124,10 @@
 
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
+#define TUNER_SET_ADDR               _IOW('T',3,int)	/* Chooses tuner I2C address */
 
 #define  TDA9887_SET_CONFIG          _IOW('t',5,int)
+
 /* tv card specific */
 # define TDA9887_PRESENT             (1<<0)
 # define TDA9887_PORT1_INACTIVE      (1<<1)
@@ -143,6 +148,11 @@
 #define I2C_ADDR_TDA8290        0x4b
 #define I2C_ADDR_TDA8275        0x61
 
+struct tuner_addr {
+	enum v4l2_tuner_type type;
+	unsigned short addr;
+};
+
 struct tuner {
 	/* device */
 	struct i2c_client i2c;

--------------020309050504040809050606--

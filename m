Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVFVAyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVFVAyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVFVAym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:54:42 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:2471 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262419AbVFVAwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:52:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:content-type;
        b=uiGpCrS6nKgOXWwjGS6mbUminI2MiB+O0D9taQHkwfKU9V32rzk4oQot6jXjbHaz+vw7rfe6KJ1ph+FhK6ZnlDe8GyAhapA1e0hYcaNsaSwqejvQJFJBQtZ+OpINAGJUmoUOVJBeCYDQKypK4GJVyixOcQ/iPtm2eD9w7uJ5T3A=
Message-ID: <42B8B661.2010002@gmail.com>
Date: Tue, 21 Jun 2005 21:52:49 -0300
From: Mauro Carvalho Chehab <maurochehab@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH] v4l tuner improvements
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------000404010609010302050909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000404010609010302050909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

*tuner-core.c:
- some tuner_info msgs will be generated only if insmod opt
        tuner_debug enabled.
- Implemented tuner-core support for VIDIO_S_TUNER to allow
        changing mono/stereo mode
- Remove unneeded config options.
- I2C_CLIENT_MULTI option removed.
- support for Philips FMD12ME hybrid tuner
- allow to initialize with another tuner
- Move PHILIPS_FMD initialization code to set_type function,

* tda8290:

- Fix dumb error in tda8290 tunning.
- Radio tuner uses high-precision step instead of 62.5 KHz.

*tea5767.c:
- tuner_info msgs will be generated only if insmod tuner option
        tuner_debug enabled.
- some cleanups for better reading.
- Radio tuner uses high-precision step instead of 62.5 KHz.
- Changing radio mode stereo/mono for tea5767 working.

*tuner-simple.c:
- TNF9533-D/IF UHF fixup.
- Radio tuners now uses high-precision step instead of 62.5 KHz.

*mt20xx.c:
        - Radio tuner uses high-precision step instead of 62.5 KHz.

*tda9887.c:
        - tab and blank spaces corrections.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

Obs.: Patch also available at
http://www.linuxtv.org/downloads/video4linux/patches/2.6.12-mm1/v4l_patch01_i2c-tuner.patch

--------------000404010609010302050909
Content-Type: text/x-patch;
 name="v4l_patch01_i2c-tuner.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_patch01_i2c-tuner.patch"

diff -u linux-2.6.12-mm1/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.12-mm1/include/media/tuner.h	2005-06-21 02:52:59.000000000 -0300
+++ linux/include/media/tuner.h	2005-06-21 14:08:56.000000000 -0300
@@ -1,5 +1,6 @@
 
-/*
+/* $Id: tuner.h,v 1.33 2005/06/21 14:58:08 mkrufky Exp $
+ *
     tuner.h - definition for different tuners
 
     Copyright (C) 1997 Markus Schroeder (schroedm@uni-duesseldorf.de)
@@ -23,6 +24,8 @@
 #ifndef _TUNER_H
 #define _TUNER_H
 
+#include <linux/videodev2.h>
+
 #include "id.h"
 
 #define ADDR_UNSET (255)
@@ -88,7 +91,7 @@
 #define TUNER_LG_NTSC_TAPE       47
 
 #define TUNER_TNF_8831BGFF       48
-#define TUNER_MICROTUNE_4042FI5  49	/* FusionHDTV 3 Gold - 4042 FI5 (3X 8147) */
+#define TUNER_MICROTUNE_4042FI5  49	/* DViCO FusionHDTV 3 Gold-Q - 4042 FI5 (3X 8147) */
 #define TUNER_TCL_2002N          50
 #define TUNER_PHILIPS_FM1256_IH3   51
 
@@ -98,18 +101,18 @@
 #define TUNER_LG_PAL_TAPE        55    /* Hauppauge PVR-150 PAL */
 
 #define TUNER_PHILIPS_FQ1216AME_MK4 56 /* Hauppauge PVR-150 PAL */
-#define TUNER_PHILIPS_FQ1236A_MK4 57   /* Hauppauge PVR-500MCE NTSC */
+#define TUNER_PHILIPS_FQ1236A_MK4   57   /* Hauppauge PVR-500MCE NTSC */
 
 #define TUNER_YMEC_TVF_8531MF 58
 #define TUNER_YMEC_TVF_5533MF 59	/* Pixelview Pro Ultra NTSC */
-#define TUNER_THOMSON_DTT7611 60
+#define TUNER_THOMSON_DTT7611 60	/* DViCO FusionHDTV 3 Gold-T */
 #define TUNER_TENA_9533_DI    61
+
 #define TUNER_TEA5767         62	/* Only FM Radio Tuner */
+#define TUNER_PHILIPS_FMD1216ME_MK3 63
 
 #define TEA5767_TUNER_NAME "Philips TEA5767HN FM Radio"
 
-#define TUNER_THOMSON_DTT7611    60
-
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
 #define PAL_I   2
@@ -194,11 +197,15 @@
 	unsigned char i2c_easy_mode[2];
 	unsigned char i2c_set_freq[8];
 
+	/* used to keep track of audmode */
+	unsigned int audmode;
+
 	/* function ptrs */
 	void (*tv_freq)(struct i2c_client *c, unsigned int freq);
 	void (*radio_freq)(struct i2c_client *c, unsigned int freq);
 	int  (*has_signal)(struct i2c_client *c);
 	int  (*is_stereo)(struct i2c_client *c);
+	int  (*set_tuner)(struct i2c_client *c, struct v4l2_tuner *v);
 };
 
 extern unsigned int tuner_debug;
@@ -206,6 +213,7 @@
 
 extern int microtune_init(struct i2c_client *c);
 extern int tda8290_init(struct i2c_client *c);
+extern int tea5767_tuner_init(struct i2c_client *c);
 extern int default_tuner_init(struct i2c_client *c);
 
 #define tuner_warn(fmt, arg...) \
diff -u linux-2.6.12-mm1/drivers/media/video/tuner-core.c linux/drivers/media/video/tuner-core.c
--- linux-2.6.12-mm1/drivers/media/video/tuner-core.c	2005-06-21 02:57:14.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-06-21 14:08:56.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.15 2005/06/12 01:36:14 mchehab Exp $
+ * $Id: tuner-core.c,v 1.29 2005/06/21 15:40:33 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -26,7 +26,6 @@
 /*
  * comment line bellow to return to old behavor, where only one I2C device is supported
  */
-#define CONFIG_TUNER_MULTI_I2C /**/
 
 #define UNSET (-1U)
 
@@ -58,9 +57,7 @@
 MODULE_LICENSE("GPL");
 
 static int this_adap;
-#ifdef CONFIG_TUNER_MULTI_I2C
 static unsigned short first_tuner, tv_tuner, radio_tuner;
-#endif
 
 static struct i2c_driver driver;
 static struct i2c_client client_template;
@@ -81,26 +78,9 @@
 		return;
 	}
 	if (freq < tv_range[0]*16 || freq > tv_range[1]*16) {
-
-		if (freq >= tv_range[0]*16364 && freq <= tv_range[1]*16384) {
-			/* V4L2_TUNER_CAP_LOW frequency */
-
-			tuner_dbg("V4L2_TUNER_CAP_LOW freq selected for TV. Tuners yet doesn't support converting it to valid freq.\n");
-
-			t->tv_freq(c,freq>>10);
-
-			return;
-                } else {
-			/* FIXME: better do that chip-specific, but
-			   right now we don't have that in the config
-			   struct and this way is still better than no
-			   check at all */
 			tuner_info("TV freq (%d.%02d) out of range (%d-%d)\n",
 				   freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
-			return;
-		}
 	}
-	tuner_dbg("62.5 Khz freq step selected for TV.\n");
 	t->tv_freq(c,freq);
 }
 
@@ -116,31 +96,18 @@
 		tuner_info("no radio tuning for this one, sorry.\n");
 		return;
 	}
-	if (freq < radio_range[0]*16 || freq > radio_range[1]*16) {
-		if (freq >= tv_range[0]*16364 && freq <= tv_range[1]*16384) {
-			/* V4L2_TUNER_CAP_LOW frequency */
-			if (t->type == TUNER_TEA5767) {
-				tuner_info("radio freq step 62.5Hz (%d.%06d)\n",(freq>>14),freq%(1<<14)*10000);
-				t->radio_freq(c,freq>>10);
-				return;
-			}
-
-			tuner_dbg("V4L2_TUNER_CAP_LOW freq selected for Radio. Tuners yet doesn't support converting it to valid freq.\n");
-
-			tuner_info("radio freq (%d.%06d)\n",(freq>>14),freq%(1<<14)*10000);
-
-			t->radio_freq(c,freq>>10);
-			return;
-
-                } else {
-			tuner_info("radio freq (%d.%02d) out of range (%d-%d)\n",
-			   freq/16,freq%16*100/16,
-				   radio_range[0],radio_range[1]);
-			return;
-		}
+	if (freq >= radio_range[0]*16000 && freq <= radio_range[1]*16000) {
+		if (tuner_debug)
+			tuner_info("radio freq step 62.5Hz (%d.%06d)\n",
+			 		    freq/16000,freq%16000*1000/16);
+		t->radio_freq(c,freq);
+        } else {
+		tuner_info("radio freq (%d.%02d) out of range (%d-%d)\n",
+			    freq/16,freq%16*100/16,
+			    radio_range[0],radio_range[1]);
 	}
-	tuner_dbg("62.5 Khz freq step selected for Radio.\n");
-	t->radio_freq(c,freq);
+
+	return;
 }
 
 static void set_freq(struct i2c_client *c, unsigned long freq)
@@ -166,8 +133,8 @@
 static void set_type(struct i2c_client *c, unsigned int type)
 {
 	struct tuner *t = i2c_get_clientdata(c);
+	unsigned char buffer[4];
 
-	tuner_dbg ("I2C addr 0x%02x with type %d\n",c->addr<<1,type);
 	/* sanity check */
 	if (type == UNSET || type == TUNER_ABSENT)
 		return;
@@ -179,8 +146,8 @@
 		t->type = type;
 		return;
 	}
-	if (t->initialized)
-		/* run only once */
+	if ((t->initialized) && (t->type == type))
+		/* run only once except type change  Hac 04/05*/
 		return;
 
 	t->initialized = 1;
@@ -193,25 +160,42 @@
 	case TUNER_PHILIPS_TDA8290:
 		tda8290_init(c);
 		break;
+	case TUNER_TEA5767:
+		if (tea5767_tuner_init(c)==EINVAL) t->type=TUNER_ABSENT;
+		break;
+	case TUNER_PHILIPS_FMD1216ME_MK3:
+		buffer[0] = 0x0b; 
+		buffer[1] = 0xdc; 
+		buffer[2] = 0x9c;
+		buffer[3] = 0x60;
+    		i2c_master_send(c,buffer,4);
+		mdelay(1);
+		buffer[2] = 0x86;
+		buffer[3] = 0x54;
+    		i2c_master_send(c,buffer,4);
+		default_tuner_init(c);
+		break;
 	default:
+		/* TEA5767 autodetection code */
+			if (tea5767_tuner_init(c)!=EINVAL) {
+				t->type = TUNER_TEA5767;
+				if (first_tuner == 0x60)
+					first_tuner++;
+				break;
+			}
+
 		default_tuner_init(c);
 		break;
 	}
+	tuner_dbg ("I2C addr 0x%02x with type %d\n",c->addr<<1,type);
 }
 
-#ifdef CONFIG_TUNER_MULTI_I2C
 #define CHECK_ADDR(tp,cmd,tun)	if (client->addr!=tp) { \
-			  return 0; } else \
+			  return 0; } else if (tuner_debug) \
 			  tuner_info ("Cmd %s accepted to "tun"\n",cmd);
 #define CHECK_MODE(cmd)	if (t->mode == V4L2_TUNER_RADIO) { \
 		 	CHECK_ADDR(radio_tuner,cmd,"radio") } else \
 			{ CHECK_ADDR(tv_tuner,cmd,"TV"); }
-#else
-#define CHECK_ADDR(tp,cmd,tun) tuner_info ("Cmd %s accepted to "tun"\n",cmd);
-#define CHECK_MODE(cmd) tuner_info ("Cmd %s accepted\n",cmd);
-#endif
-
-#ifdef CONFIG_TUNER_MULTI_I2C
 
 static void set_addr(struct i2c_client *c, struct tuner_addr *tun_addr)
 {
@@ -242,9 +226,6 @@
 	}
 	set_type(c,tun_addr->type);
 }
-#else
-#define set_addr(c,tun_addr) set_type(c,(tun_addr)->type)
-#endif
 
 static char pal[] = "-";
 module_param_string(pal, pal, sizeof(pal), 0644);
@@ -284,17 +265,12 @@
 {
 	struct tuner *t;
 
-#ifndef CONFIG_TUNER_MULTI_I2C
-	if (this_adap > 0)
-		return -1;
-#else
 	/* by default, first I2C card is both tv and radio tuner */
 	if (this_adap == 0) {
 		first_tuner = addr;
 		tv_tuner = addr;
 		radio_tuner = addr;
 	}
-#endif
 	this_adap++;
 
         client_template.adapter = adap;
@@ -308,11 +284,12 @@
 	i2c_set_clientdata(&t->i2c, t);
 	t->type       = UNSET;
 	t->radio_if2  = 10700*1000; /* 10.7MHz - FM radio */
+	t->audmode    = V4L2_TUNER_MODE_STEREO;
 
         i2c_attach_client(&t->i2c);
 	tuner_info("chip found @ 0x%x (%s)\n",
 		   addr << 1, adap->name);
-
+	
 	set_type(&t->i2c, t->type);
 	return 0;
 }
@@ -325,11 +302,9 @@
 	}
 	this_adap = 0;
 
-#ifdef CONFIG_TUNER_MULTI_I2C
 	first_tuner = 0;
 	tv_tuner = 0;
 	radio_tuner = 0;
-#endif
 
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tuner_attach);
@@ -346,7 +321,7 @@
 		tuner_warn ("Client deregistration failed, client not detached.\n");
 		return err;
 	}
-
+	
 	kfree(t);
 	return 0;
 }
@@ -357,7 +332,7 @@
 #define CHECK_V4L2	if (t->using_v4l2) { if (tuner_debug) \
 			  tuner_info("ignore v4l1 call\n"); \
 		          return 0; }
-
+			  
 static int
 tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
@@ -375,7 +350,7 @@
 	case AUDC_SET_RADIO:
 		t->mode = V4L2_TUNER_RADIO;
 		CHECK_ADDR(tv_tuner,"AUDC_SET_RADIO","TV");
-
+		
 		if (V4L2_TUNER_RADIO != t->mode) {
 			set_tv_freq(client,400 * 16);
 		}
@@ -392,8 +367,7 @@
 			t->radio_if2 = 41300 * 1000;
 			break;
 		}
-                break;
-
+		break;
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
 	   kernel pointer here... */
@@ -440,13 +414,20 @@
 				vt->signal = t->has_signal(client);
 			if (t->is_stereo) {
 				if (t->is_stereo(client))
-					vt-> flags |= VIDEO_TUNER_STEREO_ON;
+					vt->flags |= VIDEO_TUNER_STEREO_ON;
 				else
-					vt-> flags &= 0xffff ^ VIDEO_TUNER_STEREO_ON;
+					vt->flags &= ~VIDEO_TUNER_STEREO_ON;
 			}
 			vt->flags |= V4L2_TUNER_CAP_LOW; /* Allow freqs at 62.5 Hz */
-		}
 
+			vt->rangelow = radio_range[0] * 16000;
+			vt->rangehigh = radio_range[1] * 16000;
+
+		} else {
+			vt->rangelow = tv_range[0] * 16;
+			vt->rangehigh = tv_range[1] * 16;
+		}
+			
 		return 0;
 	}
 	case VIDIOCGAUDIO:
@@ -510,20 +491,46 @@
 				tuner -> signal = t->has_signal(client);
 			if (t->is_stereo) {
 				if (t->is_stereo(client)) {
-					tuner -> capability |= V4L2_TUNER_CAP_STEREO;
-					tuner -> rxsubchans |= V4L2_TUNER_SUB_STEREO;
+					tuner -> rxsubchans = V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
 				} else {
-					tuner -> rxsubchans &= 0xffff ^ V4L2_TUNER_SUB_STEREO;
+					tuner -> rxsubchans = V4L2_TUNER_SUB_MONO;
 				}
 			}
+			tuner->capability |= V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
+			tuner->audmode = t->audmode;
+
+			tuner->rangelow = radio_range[0] * 16000;
+			tuner->rangehigh = radio_range[1] * 16000;
+		} else {
+			tuner->rangelow = tv_range[0] * 16;
+			tuner->rangehigh = tv_range[1] * 16;
 		}
-		/* Wow to deal with V4L2_TUNER_CAP_LOW ? For now, it accepts from low at 62.5KHz step  to high at 62.5 Hz */
-		tuner->rangelow = tv_range[0] * 16;
-//		tuner->rangehigh = tv_range[1] * 16;
-//		tuner->rangelow = tv_range[0] * 16384;
-		tuner->rangehigh = tv_range[1] * 16384;
 		break;
 	}
+	case VIDIOC_S_TUNER: /* Allow changing radio range and audio mode */
+	{
+		struct v4l2_tuner *tuner = arg;
+
+		CHECK_ADDR(radio_tuner,"VIDIOC_S_TUNER","radio");
+		SWITCH_V4L2;
+
+		/* To switch the audio mode, applications initialize the 
+		   index and audmode fields and the reserved array and 
+		   call the VIDIOC_S_TUNER ioctl. */
+		/* rxsubchannels: V4L2_TUNER_MODE_MONO, V4L2_TUNER_MODE_STEREO,
+		   V4L2_TUNER_MODE_LANG1, V4L2_TUNER_MODE_LANG2, 
+		   V4L2_TUNER_MODE_SAP */
+
+		if (tuner->audmode == V4L2_TUNER_MODE_MONO)
+			t->audmode = V4L2_TUNER_MODE_MONO;
+		else
+			t->audmode = V4L2_TUNER_MODE_STEREO;
+
+		set_radio_freq(client, t->freq);
+		break;
+	}
+	case TDA9887_SET_CONFIG: /* Nothing to do on tuner-core */
+		break;
 	default:
 		tuner_dbg ("Unimplemented IOCTL 0x%08x called to tuner.\n", cmd);
 		/* nothing */
diff -u linux-2.6.12-mm1/drivers/media/video/tuner-simple.c linux/drivers/media/video/tuner-simple.c
--- linux-2.6.12-mm1/drivers/media/video/tuner-simple.c	2005-06-21 02:52:57.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-06-21 14:08:56.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.21 2005/06/10 19:53:26 nsh Exp $
+ * $Id: tuner-simple.c,v 1.31 2005/06/21 16:02:25 mkrufky Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -207,28 +207,27 @@
 	{ "LG PAL (TAPE series)", LGINNOTEK, PAL,
           16*170.00, 16*450.00, 0x01,0x02,0x08,0xce,623},
 
-        { "Philips PAL/SECAM multi (FQ1216AME MK4)", Philips, PAL,
-          16*160.00,16*442.00,0x01,0x02,0x04,0xce,623 },
-        { "Philips FQ1236A MK4", Philips, NTSC,
-          16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
+	{ "Philips PAL/SECAM multi (FQ1216AME MK4)", Philips, PAL,
+	  16*160.00,16*442.00,0x01,0x02,0x04,0xce,623 },
+	{ "Philips FQ1236A MK4", Philips, NTSC,
+	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
 
 	/* Should work for TVF8531MF, TVF8831MF, TVF8731MF */
 	{ "Ymec TVision TVF-8531MF", Philips, NTSC,
 	  16*160.00,16*454.00,0xa0,0x90,0x30,0x8e,732},
 	{ "Ymec TVision TVF-5533MF", Philips, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x04,0x8e,732},
-
 	{ "Thomson DDT 7611 (ATSC/NTSC)", THOMSON, ATSC,
 	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
-	{ "Tena TNF9533-D/IF", LGINNOTEK, PAL,
-	  16*160.25, 16*464.25, 0x01,0x02,0x08,0x8e,623},
+	/* Should work for TNF9533-D/IF, TNF9533-B/DF */
+	{ "Tena TNF9533-D/IF", Philips, PAL,
+          16*160.25,16*464.25,0x01,0x02,0x04,0x8e,623},
 
-	/*
-	 * This entry is for TEA5767 FM radio only chip used on several boards
-	 * w/TV tuner
-	 */
+	/* This entry is for TEA5767 FM radio only chip used on several boards w/TV tuner */
 	{ TEA5767_TUNER_NAME, Philips, RADIO,
-	  -1, -1, 0, 0, 0, TEA5767_LOW_LO_32768,0},
+          -1, -1, 0, 0, 0, TEA5767_LOW_LO_32768,0},
+	{ "Philips FMD1216ME MK3 Hybrid Tuner", Philips, PAL,
+	  16*160.00,16*442.00,0x51,0x52,0x54,0x86,623 },
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
@@ -263,9 +262,9 @@
 {
 	int stereo, status;
 	struct tuner *t = i2c_get_clientdata(c);
-
+	
 	status = tuner_getstatus (c);
-
+	
 	switch (t->type) {
         	case TUNER_PHILIPS_FM1216ME_MK3:
     		case TUNER_PHILIPS_FM1236_MK3:
@@ -275,7 +274,7 @@
 		default:
 			stereo = status & TUNER_STEREO;
 	}
-
+	
 	return stereo;
 }
 
@@ -455,24 +454,24 @@
 	int rc;
 
 	tun=&tuners[t->type];
-	div = freq + (int)(16*10.7);
+	div = (freq / 1000) + (int)(16*10.7);
 	buffer[2] = tun->config;
 
 	switch (t->type) {
 	case TUNER_TENA_9533_DI:
 	case TUNER_YMEC_TVF_5533MF:
-
 		/*These values are empirically determinated */
-		div = (freq*122)/16 - 20;
+		div = (freq * 122) / 16000 - 20;
 		buffer[2] = 0x88; /* could be also 0x80 */
 		buffer[3] = 0x19; /* could be also 0x10, 0x18, 0x99 */
 		break;
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
+	case TUNER_PHILIPS_FMD1216ME_MK3:
 		buffer[3] = 0x19;
 		break;
 	case TUNER_PHILIPS_FM1256_IH3:
-		div = (20 * freq)/16 + 333 * 2;
+		div = (20 * freq) / 16000 + 333 * 2;
 	        buffer[2] = 0x80;
 		buffer[3] = 0x19;
 		break;
@@ -500,11 +499,12 @@
 	tuner_info("type set to %d (%s)\n",
 		   t->type, tuners[t->type].name);
 	strlcpy(c->name, tuners[t->type].name, sizeof(c->name));
-
+	
 	t->tv_freq    = default_set_tv_freq;
 	t->radio_freq = default_set_radio_freq;
 	t->has_signal = tuner_signal;
 	t->is_stereo  = tuner_stereo;
+
 	return 0;
 }
 
diff -u linux-2.6.12-mm1/drivers/media/video/mt20xx.c linux/drivers/media/video/mt20xx.c
--- linux-2.6.12-mm1/drivers/media/video/mt20xx.c	2005-06-17 16:48:29.000000000 -0300
+++ linux/drivers/media/video/mt20xx.c	2005-06-21 14:08:56.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: mt20xx.c,v 1.4 2005/03/04 09:24:56 kraxel Exp $
+ * $Id: mt20xx.c,v 1.5 2005/06/16 08:29:49 nsh Exp $
  *
  * i2c tv tuner chip device driver
  * controls microtune tuners, mt2032 + mt2050 at the moment.
@@ -295,8 +295,8 @@
 	int if2 = t->radio_if2;
 
 	// per Manual for FM tuning: first if center freq. 1085 MHz
-        mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */,
-			   1085*1000*1000,if2,if2,if2);
+        mt2032_set_if_freq(c, freq * 1000 / 16,
+			      1085*1000*1000,if2,if2,if2);
 }
 
 // Initalization as described in "MT203x Programming Procedures", Rev 1.2, Feb.2001
diff -u linux-2.6.12-mm1/drivers/media/video/tda8290.c linux/drivers/media/video/tda8290.c
--- linux-2.6.12-mm1/drivers/media/video/tda8290.c	2005-06-17 16:48:29.000000000 -0300
+++ linux/drivers/media/video/tda8290.c	2005-06-21 14:08:56.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tda8290.c,v 1.7 2005/03/07 12:01:51 kraxel Exp $
+ * $Id: tda8290.c,v 1.11 2005/06/18 06:09:06 nsh Exp $
  *
  * i2c tv tuner chip device driver
  * controls the philips tda8290+75 tuner chip combo.
@@ -69,7 +69,7 @@
 static unsigned char i2c_enable_bridge[2] = 	{ 0x21, 0xC0 };
 static unsigned char i2c_disable_bridge[2] = 	{ 0x21, 0x80 };
 static unsigned char i2c_init_tda8275[14] = 	{ 0x00, 0x00, 0x00, 0x00,
-						  0x7C, 0x04, 0xA3, 0x3F,
+						  0xfC, 0x04, 0xA3, 0x3F,
 						  0x2A, 0x04, 0xFF, 0x00,
 						  0x00, 0x40 };
 static unsigned char i2c_set_VS[2] = 		{ 0x30, 0x6F };
@@ -137,17 +137,25 @@
 }
 
 static void set_frequency(struct tuner *t, u16 ifc)
-{
-	u32 N = (((t->freq<<3)+ifc)&0x3fffc);
-
-	N = N >> get_freq_entry(div_table, t->freq);
+{	
+	u32 freq;
+	u32 N;
+
+	if (t->mode == V4L2_TUNER_RADIO)
+		freq = t->freq / 1000;
+	else 
+		freq = t->freq;
+
+	N = (((freq<<3)+ifc)&0x3fffc);
+	
+	N = N >> get_freq_entry(div_table, freq);
 	t->i2c_set_freq[0] = 0;
 	t->i2c_set_freq[1] = (unsigned char)(N>>8);
 	t->i2c_set_freq[2] = (unsigned char) N;
 	t->i2c_set_freq[3] = 0x40;
 	t->i2c_set_freq[4] = 0x52;
-	t->i2c_set_freq[5] = get_freq_entry(band_table, t->freq);
-	t->i2c_set_freq[6] = get_freq_entry(agc_table,  t->freq);
+	t->i2c_set_freq[5] = get_freq_entry(band_table, freq);
+	t->i2c_set_freq[6] = get_freq_entry(agc_table,  freq);
 	t->i2c_set_freq[7] = 0x8f;
 }
 
@@ -194,12 +202,12 @@
 {
 	unsigned char i2c_get_afc[1] = { 0x1B };
 	unsigned char afc = 0;
-
+	
 	i2c_master_send(c, i2c_get_afc, ARRAY_SIZE(i2c_get_afc));
 	i2c_master_recv(c, &afc, 1);
 	return (afc & 0x80)? 65535:0;
 }
-
+	
 int tda8290_init(struct i2c_client *c)
 {
 	struct tuner *t = i2c_get_clientdata(c);
diff -u linux-2.6.12-mm1/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.12-mm1/drivers/media/video/tda9887.c	2005-06-21 02:52:57.000000000 -0300
+++ linux/drivers/media/video/tda9887.c	2005-06-21 14:08:56.000000000 -0300
@@ -368,7 +368,7 @@
 		if (t->radio_mode == V4L2_TUNER_MODE_MONO)
 			norm = &radio_mono;
 		else
-		        norm = &radio_stereo;
+			norm = &radio_stereo;
 	} else {
 		for (i = 0; i < ARRAY_SIZE(tvnorms); i++) {
 			if (tvnorms[i].std & t->std) {
@@ -566,7 +566,6 @@
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);
 	}
-
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
@@ -615,8 +614,8 @@
 	t->pinnacle_id = UNSET;
 	t->radio_mode = V4L2_TUNER_MODE_STEREO;
 
-        i2c_set_clientdata(&t->client, t);
-        i2c_attach_client(&t->client);
+	i2c_set_clientdata(&t->client, t);
+	i2c_attach_client(&t->client);
 
 	return 0;
 }

diff -u linux-2.6.12-mm1/drivers/media/video/tea5767.c linux/drivers/media/video/tea5767.c
--- linux-2.6.12-mm1/drivers/media/video/tea5767.c	2005-06-21 09:44:11.157974500 -0300
+++ linux/drivers/media/video/tea5767.c	2005-06-21 15:19:57.000000000 -0300
@@ -0,0 +1,334 @@
+/*
+ * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
+ * I2C address is allways 0xC0.
+ *
+ * $Id: tea5767.c,v 1.11 2005/06/21 15:40:33 mchehab Exp $
+ *
+ * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
+ * This code is placed under the terms of the GNU General Public License
+ *
+ * tea5767 autodetection thanks to Torsten Seeboth and Atsushi Nakagawa
+ * from their contributions on DScaler.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/videodev.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <media/tuner.h>
+
+/* Declared at tuner-core.c */
+extern unsigned int tuner_debug;
+
+#define PREFIX "TEA5767 "
+
+/*****************************************************************************/
+
+/******************************
+ * Write mode register values *
+ ******************************/
+
+/* First register */
+#define TEA5767_MUTE		0x80 /* Mutes output */
+#define TEA5767_SEARCH		0x40 /* Activates station search */
+/* Bits 0-5 for divider MSB */
+
+/* Second register */
+/* Bits 0-7 for divider LSB */
+
+/* Third register */
+
+/* Station search from botton to up */
+#define TEA5767_SEARCH_UP	0x80 
+
+/* Searches with ADC output = 10 */
+#define TEA5767_SRCH_HIGH_LVL	0x60 
+
+/* Searches with ADC output = 10 */
+#define TEA5767_SRCH_MID_LVL	0x40
+
+/* Searches with ADC output = 5 */
+#define TEA5767_SRCH_LOW_LVL	0x20
+
+/* if on, div=4*(Frf+Fif)/Fref otherwise, div=4*(Frf-Fif)/Freq) */
+#define TEA5767_HIGH_LO_INJECT	0x10
+
+/* Disable stereo */
+#define TEA5767_MONO		0x08 
+
+/* Disable right channel and turns to mono */
+#define TEA5767_MUTE_RIGHT	0x04
+
+/* Disable left channel and turns to mono */
+#define TEA5767_MUTE_LEFT	0x02
+
+#define TEA5767_PORT1_HIGH	0x01
+
+/* Forth register */
+#define TEA5767_PORT2_HIGH	0x80
+/* Chips stops working. Only I2C bus remains on */
+#define TEA5767_STDBY		0x40
+
+/* Japan freq (76-108 MHz. If disabled, 87.5-108 MHz */
+#define TEA5767_JAPAN_BAND	0x20 
+
+/* Unselected means 32.768 KHz freq as reference. Otherwise Xtal at 13 MHz */
+#define TEA5767_XTAL_32768	0x10
+
+/* Cuts weak signals */
+#define TEA5767_SOFT_MUTE	0x08
+
+/* Activates high cut control */
+#define TEA5767_HIGH_CUT_CTRL	0x04
+
+/* Activates stereo noise control */
+#define TEA5767_ST_NOISE_CTL	0x02
+
+/* If activate PORT 1 indicates SEARCH or else it is used as PORT1 */
+#define TEA5767_SRCH_IND	0x01
+
+/* Fiveth register */
+
+/* By activating, it will use Xtal at 13 MHz as reference for divider */
+#define TEA5767_PLLREF_ENABLE	0x80
+
+/* By activating, deemphasis=50, or else, deemphasis of 50us */
+#define TEA5767_DEEMPH_75	0X40
+
+/*****************************
+ * Read mode register values *
+ *****************************/
+
+/* First register */
+#define TEA5767_READY_FLAG_MASK	0x80
+#define TEA5767_BAND_LIMIT_MASK	0X40
+/* Bits 0-5 for divider MSB after search or preset */
+
+/* Second register */
+/* Bits 0-7 for divider LSB after search or preset */
+
+/* Third register */
+#define TEA5767_STEREO_MASK	0x80
+#define TEA5767_IF_CNTR_MASK	0x7f
+
+/* Four register */
+#define TEA5767_ADC_LEVEL_MASK	0xf0
+
+/* should be 0 */
+#define TEA5767_CHIP_ID_MASK	0x0f
+
+/* Fiveth register */
+/* Reserved for future extensions */
+#define TEA5767_RESERVED_MASK	0xff
+
+/*****************************************************************************/
+
+static void set_tv_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	tuner_warn("This tuner doesn't support TV freq.\n");
+}
+
+static void tea5767_status_dump(unsigned char *buffer)
+{
+	unsigned int div, frq;
+	
+	if (TEA5767_READY_FLAG_MASK & buffer[0])
+		printk(PREFIX "Ready Flag ON\n");
+	else
+		printk(PREFIX "Ready Flag OFF\n");
+	
+	if (TEA5767_BAND_LIMIT_MASK & buffer[0])
+		printk(PREFIX "Tuner at band limit\n");
+	else
+		printk(PREFIX "Tuner not at band limit\n");
+
+	div=((buffer[0]&0x3f)<<8) | buffer[1];
+
+	switch (TEA5767_HIGH_LO_32768) {
+	case TEA5767_HIGH_LO_13MHz:
+		frq = 1000*(div*50-700-225)/4; /* Freq in KHz */
+		break;
+	case TEA5767_LOW_LO_13MHz:
+		frq = 1000*(div*50+700+225)/4; /* Freq in KHz */
+		break;
+	case TEA5767_LOW_LO_32768:
+		frq = 1000*(div*32768/1000+700+225)/4; /* Freq in KHz */
+		break;
+	case TEA5767_HIGH_LO_32768:
+	default:
+		frq = 1000*(div*32768/1000-700-225)/4; /* Freq in KHz */
+		break;
+	}
+        buffer[0] = (div>>8) & 0x3f;
+        buffer[1] = div      & 0xff;
+	
+	printk(PREFIX "Frequency %d.%03d KHz (divider = 0x%04x)\n",
+						frq/1000,frq%1000,div);
+
+	if (TEA5767_STEREO_MASK & buffer[2])
+		printk(PREFIX "Stereo\n");
+	else
+		printk(PREFIX "Mono\n");
+
+	printk(PREFIX "IF Counter = %d\n",buffer[2] & TEA5767_IF_CNTR_MASK);
+	
+	printk(PREFIX "ADC Level = %d\n",(buffer[3] & TEA5767_ADC_LEVEL_MASK)>>4);
+
+	printk(PREFIX "Chip ID = %d\n",(buffer[3] & TEA5767_CHIP_ID_MASK));
+
+	printk(PREFIX "Reserved = 0x%02x\n",(buffer[4] & TEA5767_RESERVED_MASK));
+}
+
+/* Freq should be specifyed at 62.5 Hz */
+static void set_radio_freq(struct i2c_client *c, unsigned int frq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+        unsigned char buffer[5];
+	unsigned div;
+	int rc;
+
+	if ( tuner_debug )
+		printk(PREFIX "radio freq counter %d\n",frq);
+
+	/* Rounds freq to next decimal value - for 62.5 KHz step */
+	/* frq = 20*(frq/16)+radio_frq[frq%16]; */
+
+	buffer[2] = TEA5767_PORT1_HIGH;
+	buffer[3] = TEA5767_PORT2_HIGH | TEA5767_HIGH_CUT_CTRL | TEA5767_ST_NOISE_CTL | TEA5767_JAPAN_BAND;
+	buffer[4]=0;
+
+	if (t->audmode == V4L2_TUNER_MODE_MONO) {
+		tuner_dbg("TEA5767 set to mono\n");
+		buffer[2] |= TEA5767_MONO;
+	} else
+ 		tuner_dbg("TEA5767 set to stereo\n");
+
+	switch (t->type) {
+	case TEA5767_HIGH_LO_13MHz:
+		tuner_dbg("TEA5767 radio HIGH LO inject xtal @ 13 MHz\n");
+		buffer[2] |= TEA5767_HIGH_LO_INJECT;
+		buffer[4] |= TEA5767_PLLREF_ENABLE;
+		div = (frq*4/16+700+225+25)/50;
+		break;
+	case TEA5767_LOW_LO_13MHz:
+		tuner_dbg("TEA5767 radio LOW LO inject xtal @ 13 MHz\n");
+		
+		buffer[4] |= TEA5767_PLLREF_ENABLE;
+		div = (frq*4/16-700-225+25)/50;
+		break;
+	case TEA5767_LOW_LO_32768:
+		tuner_dbg("TEA5767 radio LOW LO inject xtal @ 32,768 MHz\n");
+		buffer[3] |= TEA5767_XTAL_32768;
+		/* const 700=4000*175 Khz - to adjust freq to right value */
+		div = (1000*(frq*4/16-700-225)+16384)>>15;
+		break;
+	case TEA5767_HIGH_LO_32768:
+	default:
+		tuner_dbg("TEA5767 radio HIGH LO inject xtal @ 32,768 MHz\n");
+		
+		buffer[2] |= TEA5767_HIGH_LO_INJECT;
+		buffer[3] |= TEA5767_XTAL_32768;
+		div = (1000*(frq*4/16+700+225)+16384)>>15;
+		break;
+	}
+        buffer[0] = (div>>8) & 0x3f;
+        buffer[1] = div      & 0xff;
+
+	if ( tuner_debug )
+		tea5767_status_dump(buffer);
+
+        if (5 != (rc = i2c_master_send(c,buffer,5)))
+		tuner_warn("i2c i/o error: rc == %d (should be 5)\n",rc);
+}
+
+static int tea5767_signal(struct i2c_client *c)
+{
+	unsigned char buffer[5];
+	int rc;
+	struct tuner *t = i2c_get_clientdata(c);
+
+	memset(buffer,0,sizeof(buffer));
+        if (5 != (rc = i2c_master_recv(c,buffer,5)))
+                tuner_warn ( "i2c i/o error: rc == %d (should be 5)\n",rc);
+		
+	return ((buffer[3] & TEA5767_ADC_LEVEL_MASK) <<(13-4));
+}
+
+static int tea5767_stereo(struct i2c_client *c)
+{
+	unsigned char buffer[5];
+	int rc;
+	struct tuner *t = i2c_get_clientdata(c);
+
+	memset(buffer,0,sizeof(buffer));
+        if (5 != (rc = i2c_master_recv(c,buffer,5)))
+                tuner_warn ( "i2c i/o error: rc == %d (should be 5)\n",rc);
+	
+	rc = buffer[2] & TEA5767_STEREO_MASK;
+
+	if ( tuner_debug )
+		tuner_dbg("TEA5767 radio ST GET = %02x\n", rc);
+	
+	return ( (buffer[2] & TEA5767_STEREO_MASK) ? V4L2_TUNER_SUB_STEREO: 0);
+}
+
+int tea_detection(struct i2c_client *c)
+{
+	unsigned char buffer[5]= { 0xff, 0xff, 0xff, 0xff, 0xff };
+	int rc;
+	struct tuner *t = i2c_get_clientdata(c);
+
+        if (5 != (rc = i2c_master_recv(c,buffer,5))) {
+                tuner_warn ( "it is not a TEA5767. Received %i chars.\n",rc );
+		return EINVAL;
+	}
+
+	/* If all bytes are the same then it's a TV tuner and not a tea5767 chip. */
+	if (buffer[0] == buffer[1] &&  buffer[0] == buffer[2] && 
+	    buffer[0] == buffer[3] &&  buffer[0] == buffer[4]) {
+                tuner_warn ( "All bytes are equal. It is not a TEA5767\n" );
+		return EINVAL;
+	}
+
+	/*  Status bytes:
+	 *  Byte 4: bit 3:1 : CI (Chip Identification) == 0
+	 *	    bit 0   : internally set to 0
+	 *  Byte 5: bit 7:0 : == 0 
+	 */
+
+	if (!((buffer[3] & 0x0f) == 0x00) && (buffer[4] == 0x00)) {
+                tuner_warn ( "Chip ID is not zero. It is not a TEA5767\n" );
+		return EINVAL;
+	}
+	tuner_warn ( "TEA5767 detected.\n" );
+	return 0;
+}
+
+int tea5767_tuner_init(struct i2c_client *c)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	if (tea_detection(c)==EINVAL) return EINVAL;
+
+        tuner_info("type set to %d (%s)\n",
+                   t->type, TEA5767_TUNER_NAME);
+        strlcpy(c->name, TEA5767_TUNER_NAME, sizeof(c->name));
+
+	t->tv_freq    = set_tv_freq;
+	t->radio_freq = set_radio_freq;
+	t->has_signal = tea5767_signal;
+	t->is_stereo  = tea5767_stereo;
+
+	return (0);
+}
diff -u linux-2.6.12-mm1/include/media/Makefile linux-2.6.12-mm1/linux/include/media/Makefile
--- linux-2.6.12-mm1/drivers/media/video/Makefile	2005-06-21 15:25:29.000000000 -0300
+++ linux-2.6.12-mm1/drivers/media/video/Makefile	2005-06-21 15:25:45.000000000 -0300
@@ -7,8 +7,7 @@
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
-tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o
-
+tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o tea5767.o
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
diff -u linux-2.6.12-mm1/drivers/media/video/Kconfig linux-2.6.12-mm1/drivers/media/video/Kconfig
--- linux-2.6.12-mm1/drivers/media/video/Kconfig	2005-06-21 15:30:16.000000000 -0300
+++ linux-2.6.12-mm1/drivers/media/video/Kconfig	2005-06-21 15:30:23.000000000 -0300
@@ -7,19 +7,6 @@
 
 comment "Video Adapters"
 
-config CONFIG_TUNER_MULTI_I2C
-	bool "Enable support for multiple I2C devices on Video Adapters (EXPERIMENTAL)"
-	depends on VIDEO_DEV && EXPERIMENTAL
-	---help---
-	  Some video adapters have more than one tuner inside. This patch
-	  enables support for using more than one tuner. This is required
-	  for some cards to allow tunning  both video and radio.
-	  It also improves I2C autodetection for these cards.
-
-	  Only few tuners currently is supporting this. More to come.
-
-	  It is safe to say 'Y' here even if your card has only one I2C tuner.
-
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
 	depends on VIDEO_DEV && PCI && I2C

--------------000404010609010302050909--

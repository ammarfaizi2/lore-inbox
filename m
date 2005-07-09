Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263047AbVGIAvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVGIAvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVGIAtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:49:15 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:43142 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263038AbVGIArE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:47:04 -0400
Message-ID: <42CF1E80.7010909@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:46:56 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 9/14 2.6.13-rc2-mm1] V4L I2C Tuner
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010000090505050700060101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010000090505050700060101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010000090505050700060101
Content-Type: text/x-patch;
 name="v4l_i2c_tuner.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_i2c_tuner.diff"

- Fixed a trouble on tuner-core that generates erros on computers with more
  than one TV card.
- Rename tuner structures fields.
- Tail spaces removed.
- I2C cleanups and converged to a basic reference structure.
- Removed unused structures.
- Fix setting frequency on tda8290.
- Added code for TEA5767 autodetection.
- Standby mode support implemented. It is used to disable
  a non used tuner. Currenlty implemented on tea5767.
- New macro: set_type disables other tuner when changing mode.
- Some cleanups.
- Use 50 kHz step when tunning radio for most tuners to improve precision.

Signed-off-by: Fabien Perrot <perrot1983@yahoo.fr>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-By: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/mt20xx.c       |   16 
 linux/drivers/media/video/tda8290.c      |   13 
 linux/drivers/media/video/tda9887.c      |    9 
 linux/drivers/media/video/tea5767.c      |  158 ++---
 linux/drivers/media/video/tuner-core.c   |  701 +++++++++++++----------
 linux/drivers/media/video/tuner-simple.c |   85 +-
 linux/include/media/tuner.h              |   51 -
 7 files changed, 542 insertions(+), 491 deletions(-)

diff -u linux-2.6.13/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.13/include/media/tuner.h	2005-07-06 00:46:33.000000000 -0300
+++ linux/include/media/tuner.h	2005-07-08 17:33:16.000000000 -0300
@@ -1,5 +1,5 @@
 
-/* $Id: tuner.h,v 1.33 2005/06/21 14:58:08 mkrufky Exp $
+/* $Id: tuner.h,v 1.42 2005/07/06 09:42:19 mchehab Exp $
  *
     tuner.h - definition for different tuners
 
@@ -26,8 +26,6 @@
 
 #include <linux/videodev2.h>
 
-#include "id.h"
-
 #define ADDR_UNSET (255)
 
 #define TUNER_TEMIC_PAL     0        /* 4002 FH5 (3X 7756, 9483) */
@@ -111,8 +109,6 @@
 #define TUNER_TEA5767         62	/* Only FM Radio Tuner */
 #define TUNER_PHILIPS_FMD1216ME_MK3 63
 
-#define TEA5767_TUNER_NAME "Philips TEA5767HN FM Radio"
-
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
 #define PAL_I   2
@@ -135,19 +131,8 @@
 #define TCL     11
 #define THOMSON 12
 
-enum v4l_radio_tuner {
-        TEA5767_LOW_LO_32768    = 0,
-        TEA5767_HIGH_LO_32768   = 1,
-        TEA5767_LOW_LO_13MHz    = 2,
-        TEA5767_HIGH_LO_13MHz   = 3,
-};
-
-
-#define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
-#define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
-#define TUNER_SET_TYPE_ADDR          _IOW('T',3,int)	/* set tuner type and I2C addr */
-
-#define  TDA9887_SET_CONFIG          _IOW('t',5,int)
+#define TUNER_SET_TYPE_ADDR          _IOW('T',3,int)
+#define TDA9887_SET_CONFIG           _IOW('t',5,int)
 
 /* tv card specific */
 # define TDA9887_PRESENT             (1<<0)
@@ -169,25 +154,34 @@
 #define I2C_ADDR_TDA8290        0x4b
 #define I2C_ADDR_TDA8275        0x61
 
-struct tuner_addr {
-	enum v4l2_tuner_type	v4l2_tuner;
-	unsigned int		type;
+enum tuner_mode {
+	T_UNINITIALIZED = 0,
+	T_RADIO		= 1 << V4L2_TUNER_RADIO,
+	T_ANALOG_TV     = 1 << V4L2_TUNER_ANALOG_TV,
+	T_DIGITAL_TV    = 1 << V4L2_TUNER_DIGITAL_TV,
+	T_STANDBY	= 1 << 31
+};
+
+struct tuner_setup {
 	unsigned short		addr;
+	unsigned int		type;
+	unsigned int		mode_mask;
 };
 
 struct tuner {
 	/* device */
 	struct i2c_client i2c;
 
-	/* state + config */
-	unsigned int initialized;
 	unsigned int type;            /* chip type */
+
+	unsigned int          mode;
+	unsigned int          mode_mask; /* Combination of allowable modes */
+
 	unsigned int freq;            /* keep track of the current settings */
+	unsigned int audmode;
 	v4l2_std_id  std;
-	int          using_v4l2;
 
-	enum v4l2_tuner_type mode;
-	unsigned int input;
+	int          using_v4l2;
 
 	/* used by MT2032 */
 	unsigned int xogc;
@@ -197,15 +191,11 @@
 	unsigned char i2c_easy_mode[2];
 	unsigned char i2c_set_freq[8];
 
-	/* used to keep track of audmode */
-	unsigned int audmode;
-
 	/* function ptrs */
 	void (*tv_freq)(struct i2c_client *c, unsigned int freq);
 	void (*radio_freq)(struct i2c_client *c, unsigned int freq);
 	int  (*has_signal)(struct i2c_client *c);
 	int  (*is_stereo)(struct i2c_client *c);
-	int  (*set_tuner)(struct i2c_client *c, struct v4l2_tuner *v);
 };
 
 extern unsigned int tuner_debug;
@@ -215,6 +205,7 @@
 extern int tda8290_init(struct i2c_client *c);
 extern int tea5767_tuner_init(struct i2c_client *c);
 extern int default_tuner_init(struct i2c_client *c);
+extern int tea5767_autodetection(struct i2c_client *c);
 
 #define tuner_warn(fmt, arg...) \
 	dev_printk(KERN_WARNING , &t->i2c.dev , fmt , ## arg)
diff -u linux-2.6.13/drivers/media/video/tuner-core.c linux/drivers/media/video/tuner-core.c
--- linux-2.6.13/drivers/media/video/tuner-core.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-07-08 17:33:16.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.29 2005/06/21 15:40:33 mchehab Exp $
+ * $Id: tuner-core.c,v 1.55 2005/07/08 13:20:33 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -23,42 +23,36 @@
 #include <media/tuner.h>
 #include <media/audiochip.h>
 
-/*
- * comment line bellow to return to old behavor, where only one I2C device is supported
- */
-
 #define UNSET (-1U)
 
 /* standard i2c insmod options */
 static unsigned short normal_i2c[] = {
-	0x4b, /* tda8290 */
+	0x4b,			/* tda8290 */
 	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
 	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
 	I2C_CLIENT_END
 };
+
 I2C_CLIENT_INSMOD;
 
 /* insmod options used at init time => read/only */
-static unsigned int addr  =  0;
+static unsigned int addr = 0;
 module_param(addr, int, 0444);
 
 /* insmod options used at runtime => read/write */
-unsigned int tuner_debug   = 0;
-module_param(tuner_debug,       int, 0644);
+unsigned int tuner_debug = 0;
+module_param(tuner_debug, int, 0644);
 
-static unsigned int tv_range[2]    = { 44, 958 };
+static unsigned int tv_range[2] = { 44, 958 };
 static unsigned int radio_range[2] = { 65, 108 };
 
-module_param_array(tv_range,    int, NULL, 0644);
+module_param_array(tv_range, int, NULL, 0644);
 module_param_array(radio_range, int, NULL, 0644);
 
 MODULE_DESCRIPTION("device driver for various TV and TV+FM radio tuners");
 MODULE_AUTHOR("Ralph Metzler, Gerd Knorr, Gunther Mayer");
 MODULE_LICENSE("GPL");
 
-static int this_adap;
-static unsigned short first_tuner, tv_tuner, radio_tuner;
-
 static struct i2c_driver driver;
 static struct i2c_client client_template;
 
@@ -70,18 +64,19 @@
 	struct tuner *t = i2c_get_clientdata(c);
 
 	if (t->type == UNSET) {
-		tuner_info("tuner type not set\n");
+		tuner_warn ("tuner type not set\n");
 		return;
 	}
 	if (NULL == t->tv_freq) {
-		tuner_info("Huh? tv_set is NULL?\n");
+		tuner_warn ("Tuner has no way to set tv freq\n");
 		return;
 	}
-	if (freq < tv_range[0]*16 || freq > tv_range[1]*16) {
-			tuner_info("TV freq (%d.%02d) out of range (%d-%d)\n",
-				   freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
+	if (freq < tv_range[0] * 16 || freq > tv_range[1] * 16) {
+		tuner_dbg ("TV freq (%d.%02d) out of range (%d-%d)\n",
+			   freq / 16, freq % 16 * 100 / 16, tv_range[0],
+			   tv_range[1]);
 	}
-	t->tv_freq(c,freq);
+	t->tv_freq(c, freq);
 }
 
 static void set_radio_freq(struct i2c_client *c, unsigned int freq)
@@ -89,24 +84,20 @@
 	struct tuner *t = i2c_get_clientdata(c);
 
 	if (t->type == UNSET) {
-		tuner_info("tuner type not set\n");
+		tuner_warn ("tuner type not set\n");
 		return;
 	}
 	if (NULL == t->radio_freq) {
-		tuner_info("no radio tuning for this one, sorry.\n");
+		tuner_warn ("tuner has no way to set radio frequency\n");
 		return;
 	}
-	if (freq >= radio_range[0]*16000 && freq <= radio_range[1]*16000) {
-		if (tuner_debug)
-			tuner_info("radio freq step 62.5Hz (%d.%06d)\n",
-			 		    freq/16000,freq%16000*1000/16);
-		t->radio_freq(c,freq);
-        } else {
-		tuner_info("radio freq (%d.%02d) out of range (%d-%d)\n",
-			    freq/16,freq%16*100/16,
-			    radio_range[0],radio_range[1]);
+	if (freq <= radio_range[0] * 16000 || freq >= radio_range[1] * 16000) {
+		tuner_dbg ("radio freq (%d.%02d) out of range (%d-%d)\n",
+			   freq / 16000, freq % 16000 * 100 / 16000,
+			   radio_range[0], radio_range[1]);
 	}
 
+	t->radio_freq(c, freq);
 	return;
 }
 
@@ -117,42 +108,45 @@
 	switch (t->mode) {
 	case V4L2_TUNER_RADIO:
 		tuner_dbg("radio freq set to %lu.%02lu\n",
-			  freq/16,freq%16*100/16);
-		set_radio_freq(c,freq);
+			  freq / 16000, freq % 16000 * 100 / 16000);
+		set_radio_freq(c, freq);
 		break;
 	case V4L2_TUNER_ANALOG_TV:
 	case V4L2_TUNER_DIGITAL_TV:
 		tuner_dbg("tv freq set to %lu.%02lu\n",
-			  freq/16,freq%16*100/16);
+			  freq / 16, freq % 16 * 100 / 16);
 		set_tv_freq(c, freq);
 		break;
 	}
 	t->freq = freq;
 }
 
-static void set_type(struct i2c_client *c, unsigned int type)
+static void set_type(struct i2c_client *c, unsigned int type,
+		     unsigned int new_mode_mask)
 {
 	struct tuner *t = i2c_get_clientdata(c);
 	unsigned char buffer[4];
 
-	/* sanity check */
-	if (type == UNSET || type == TUNER_ABSENT)
+	if (type == UNSET || type == TUNER_ABSENT) {
+		tuner_dbg ("tuner 0x%02x: Tuner type absent\n",c->addr);
 		return;
-	if (type >= tuner_count)
+	}
+
+	if (type >= tuner_count) {
+		tuner_warn ("tuner 0x%02x: Tuner count greater than %d\n",c->addr,tuner_count);
 		return;
+	}
 
+	/* This code detects calls by card attach_inform */
 	if (NULL == t->i2c.dev.driver) {
-		/* not registered yet */
-		t->type = type;
+		tuner_dbg ("tuner 0x%02x: called during i2c_client register by adapter's attach_inform\n", c->addr);
+
+		t->type=type;
 		return;
 	}
-	if ((t->initialized) && (t->type == type))
-		/* run only once except type change  Hac 04/05*/
-		return;
-
-	t->initialized = 1;
 
 	t->type = type;
+
 	switch (t->type) {
 	case TUNER_MT2032:
 		microtune_init(c);
@@ -161,136 +155,194 @@
 		tda8290_init(c);
 		break;
 	case TUNER_TEA5767:
-		if (tea5767_tuner_init(c)==EINVAL) t->type=TUNER_ABSENT;
+		if (tea5767_tuner_init(c) == EINVAL) {
+			t->type = TUNER_ABSENT;
+			t->mode_mask = T_UNINITIALIZED;
+			return;
+		}
+		t->mode_mask = T_RADIO;
 		break;
 	case TUNER_PHILIPS_FMD1216ME_MK3:
 		buffer[0] = 0x0b;
 		buffer[1] = 0xdc;
 		buffer[2] = 0x9c;
 		buffer[3] = 0x60;
-    		i2c_master_send(c,buffer,4);
+		i2c_master_send(c, buffer, 4);
 		mdelay(1);
 		buffer[2] = 0x86;
 		buffer[3] = 0x54;
-    		i2c_master_send(c,buffer,4);
+		i2c_master_send(c, buffer, 4);
 		default_tuner_init(c);
 		break;
 	default:
-		/* TEA5767 autodetection code */
-			if (tea5767_tuner_init(c)!=EINVAL) {
-				t->type = TUNER_TEA5767;
-				if (first_tuner == 0x60)
-					first_tuner++;
-				break;
-			}
-
 		default_tuner_init(c);
 		break;
 	}
-	tuner_dbg ("I2C addr 0x%02x with type %d\n",c->addr<<1,type);
+
+	if (t->mode_mask == T_UNINITIALIZED)
+		t->mode_mask = new_mode_mask;
+
+	set_freq(c, t->freq);
+	tuner_dbg("%s %s I2C addr 0x%02x with type %d used for 0x%02x\n",
+		  c->adapter->name, c->driver->name, c->addr << 1, type,
+		  t->mode_mask);
 }
 
-#define CHECK_ADDR(tp,cmd,tun)	if (client->addr!=tp) { \
-			  return 0; } else if (tuner_debug) \
-			  tuner_info ("Cmd %s accepted to "tun"\n",cmd);
-#define CHECK_MODE(cmd)	if (t->mode == V4L2_TUNER_RADIO) { \
-		 	CHECK_ADDR(radio_tuner,cmd,"radio") } else \
-			{ CHECK_ADDR(tv_tuner,cmd,"TV"); }
+/*
+ * This function apply tuner config to tuner specified
+ * by tun_setup structure. I addr is unset, then admin status
+ * and tun addr status is more precise then current status,
+ * it's applied. Otherwise status and type are applied only to
+ * tuner with exactly the same addr.
+*/
 
-static void set_addr(struct i2c_client *c, struct tuner_addr *tun_addr)
+static void set_addr(struct i2c_client *c, struct tuner_setup *tun_setup)
 {
-	/* ADDR_UNSET defaults to first available tuner */
-	if ( tun_addr->addr == ADDR_UNSET ) {
-		if (first_tuner != c->addr)
-			return;
-		switch (tun_addr->v4l2_tuner) {
+	struct tuner *t = i2c_get_clientdata(c);
+
+	if (tun_setup->addr == ADDR_UNSET) {
+		if (t->mode_mask & tun_setup->mode_mask)
+			set_type(c, tun_setup->type, tun_setup->mode_mask);
+	} else if (tun_setup->addr == c->addr) {
+		set_type(c, tun_setup->type, tun_setup->mode_mask);
+	}
+}
+
+static inline int check_mode(struct tuner *t, char *cmd)
+{
+	if (1 << t->mode & t->mode_mask) {
+		switch (t->mode) {
 		case V4L2_TUNER_RADIO:
-	 		radio_tuner=c->addr;
+			tuner_dbg("Cmd %s accepted for radio\n", cmd);
 			break;
-		default:
-			tv_tuner=c->addr;
+		case V4L2_TUNER_ANALOG_TV:
+			tuner_dbg("Cmd %s accepted for analog TV\n", cmd);
+			break;
+		case V4L2_TUNER_DIGITAL_TV:
+			tuner_dbg("Cmd %s accepted for digital TV\n", cmd);
 			break;
 		}
-	} else {
-		/* Sets tuner to its configured value */
-		switch (tun_addr->v4l2_tuner) {
-		case V4L2_TUNER_RADIO:
- 			radio_tuner=tun_addr->addr;
-			if ( tun_addr->addr == c->addr ) set_type(c,tun_addr->type);
-			return;
-		default:
-			tv_tuner=tun_addr->addr;
-			if ( tun_addr->addr == c->addr ) set_type(c,tun_addr->type);
-			return;
-		}
+		return 0;
 	}
-	set_type(c,tun_addr->type);
+	return EINVAL;
 }
 
 static char pal[] = "-";
 module_param_string(pal, pal, sizeof(pal), 0644);
+static char secam[] = "-";
+module_param_string(secam, secam, sizeof(secam), 0644);
 
+/* get more precise norm info from insmod option */
 static int tuner_fixup_std(struct tuner *t)
 {
 	if ((t->std & V4L2_STD_PAL) == V4L2_STD_PAL) {
-		/* get more precise norm info from insmod option */
 		switch (pal[0]) {
 		case 'b':
 		case 'B':
 		case 'g':
 		case 'G':
-			tuner_dbg("insmod fixup: PAL => PAL-BG\n");
+			tuner_dbg ("insmod fixup: PAL => PAL-BG\n");
 			t->std = V4L2_STD_PAL_BG;
 			break;
 		case 'i':
 		case 'I':
-			tuner_dbg("insmod fixup: PAL => PAL-I\n");
+			tuner_dbg ("insmod fixup: PAL => PAL-I\n");
 			t->std = V4L2_STD_PAL_I;
 			break;
 		case 'd':
 		case 'D':
 		case 'k':
 		case 'K':
-			tuner_dbg("insmod fixup: PAL => PAL-DK\n");
+			tuner_dbg ("insmod fixup: PAL => PAL-DK\n");
 			t->std = V4L2_STD_PAL_DK;
 			break;
+		case 'M':
+		case 'm':
+			tuner_dbg ("insmod fixup: PAL => PAL-M\n");
+			t->std = V4L2_STD_PAL_M;
+			break;
+		case 'N':
+		case 'n':
+			tuner_dbg ("insmod fixup: PAL => PAL-N\n");
+			t->std = V4L2_STD_PAL_N;
+			break;
 		}
 	}
+	if ((t->std & V4L2_STD_SECAM) == V4L2_STD_SECAM) {
+		switch (secam[0]) {
+		case 'd':
+		case 'D':
+		case 'k':
+		case 'K':
+			tuner_dbg ("insmod fixup: SECAM => SECAM-DK\n");
+			t->std = V4L2_STD_SECAM_DK;
+			break;
+		case 'l':
+		case 'L':
+			tuner_dbg ("insmod fixup: SECAM => SECAM-L\n");
+			t->std = V4L2_STD_SECAM_L;
+			break;
+		}
+	}
+
 	return 0;
 }
 
 /* ---------------------------------------------------------------------- */
 
+/* static var Used only in tuner_attach and tuner_probe */
+static unsigned default_mode_mask;
+
+/* During client attach, set_type is called by adapter's attach_inform callback.
+   set_type must then be completed by tuner_attach.
+ */
 static int tuner_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct tuner *t;
 
-	/* by default, first I2C card is both tv and radio tuner */
-	if (this_adap == 0) {
-		first_tuner = addr;
-		tv_tuner = addr;
-		radio_tuner = addr;
-	}
-	this_adap++;
-
-        client_template.adapter = adap;
-        client_template.addr = addr;
-
-        t = kmalloc(sizeof(struct tuner),GFP_KERNEL);
-        if (NULL == t)
-                return -ENOMEM;
-        memset(t,0,sizeof(struct tuner));
-        memcpy(&t->i2c,&client_template,sizeof(struct i2c_client));
+	client_template.adapter = adap;
+	client_template.addr = addr;
+
+	t = kmalloc(sizeof(struct tuner), GFP_KERNEL);
+	if (NULL == t)
+		return -ENOMEM;
+	memset(t, 0, sizeof(struct tuner));
+	memcpy(&t->i2c, &client_template, sizeof(struct i2c_client));
 	i2c_set_clientdata(&t->i2c, t);
-	t->type       = UNSET;
-	t->radio_if2  = 10700*1000; /* 10.7MHz - FM radio */
-	t->audmode    = V4L2_TUNER_MODE_STEREO;
-
-        i2c_attach_client(&t->i2c);
-	tuner_info("chip found @ 0x%x (%s)\n",
-		   addr << 1, adap->name);
+	t->type = UNSET;
+	t->radio_if2 = 10700 * 1000;	/* 10.7MHz - FM radio */
+	t->audmode = V4L2_TUNER_MODE_STEREO;
+	t->mode_mask = T_UNINITIALIZED;
+
+
+	tuner_info("chip found @ 0x%x (%s)\n", addr << 1, adap->name);
+
+	/* TEA5767 autodetection code - only for addr = 0xc0 */
+	if (addr == 0x60) {
+		if (tea5767_autodetection(&t->i2c) != EINVAL) {
+			t->type = TUNER_TEA5767;
+			t->mode_mask = T_RADIO;
+			t->mode = T_STANDBY;
+			t->freq = 87.5 * 16; /* Sets freq to FM range */
+			default_mode_mask &= ~T_RADIO;
+
+			i2c_attach_client (&t->i2c);
+			set_type(&t->i2c,t->type, t->mode_mask);
+			return 0;
+		}
+	}
+
+	/* Initializes only the first adapter found */
+	if (default_mode_mask != T_UNINITIALIZED) {
+		tuner_dbg ("Setting mode_mask to 0x%02x\n", default_mode_mask);
+		t->mode_mask = default_mode_mask;
+		t->freq = 400 * 16; /* Sets freq to VHF High */
+		default_mode_mask = T_UNINITIALIZED;
+	}
 
-	set_type(&t->i2c, t->type);
+	/* Should be just before return */
+	i2c_attach_client (&t->i2c);
+	set_type (&t->i2c,t->type, t->mode_mask);
 	return 0;
 }
 
@@ -300,11 +352,8 @@
 		normal_i2c[0] = addr;
 		normal_i2c[1] = I2C_CLIENT_END;
 	}
-	this_adap = 0;
 
-	first_tuner = 0;
-	tv_tuner = 0;
-	radio_tuner = 0;
+	default_mode_mask = T_RADIO | T_ANALOG_TV | T_DIGITAL_TV;
 
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tuner_attach);
@@ -316,9 +365,10 @@
 	struct tuner *t = i2c_get_clientdata(client);
 	int err;
 
-	err=i2c_detach_client(&t->i2c);
+	err = i2c_detach_client(&t->i2c);
 	if (err) {
-		tuner_warn ("Client deregistration failed, client not detached.\n");
+		tuner_warn
+		    ("Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
@@ -326,37 +376,65 @@
 	return 0;
 }
 
-#define SWITCH_V4L2	if (!t->using_v4l2 && tuner_debug) \
-		          tuner_info("switching to v4l2\n"); \
-	                  t->using_v4l2 = 1;
-#define CHECK_V4L2	if (t->using_v4l2) { if (tuner_debug) \
-			  tuner_info("ignore v4l1 call\n"); \
-		          return 0; }
+/*
+ * Switch tuner to other mode. If tuner support both tv and radio,
+ * set another frequency to some value (This is needed for some pal
+ * tuners to avoid locking). Otherwise, just put second tuner in
+ * standby mode.
+ */
+
+static inline int set_mode(struct i2c_client *client, struct tuner *t, int mode, char *cmd)
+{
+	if (mode != t->mode) {
+
+		t->mode = mode;
+		if (check_mode(t, cmd) == EINVAL) {
+			t->mode = T_STANDBY;
+			if (V4L2_TUNER_RADIO == mode) {
+				set_tv_freq(client, 400 * 16);
+			} else {
+				set_radio_freq(client, 87.5 * 16000);
+			}
+			return EINVAL;
+		}
+	}
+	return 0;
+}
+
+#define switch_v4l2()	if (!t->using_v4l2) \
+		            tuner_dbg("switching to v4l2\n"); \
+	                t->using_v4l2 = 1;
+
+static inline int check_v4l2(struct tuner *t)
+{
+	if (t->using_v4l2) {
+		tuner_dbg ("ignore v4l1 call\n");
+		return EINVAL;
+	}
+	return 0;
+}
 
-static int
-tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
+static int tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	struct tuner *t = i2c_get_clientdata(client);
-        unsigned int *iarg = (int*)arg;
+	unsigned int *iarg = (int *)arg;
 
-        switch (cmd) {
+	switch (cmd) {
 	/* --- configuration --- */
-	case TUNER_SET_TYPE:
-		set_type(client,*iarg);
-		break;
 	case TUNER_SET_TYPE_ADDR:
-		set_addr(client,(struct tuner_addr *)arg);
+		tuner_dbg ("Calling set_type_addr for type=%d, addr=0x%02x, mode=0x%02x\n",
+				((struct tuner_setup *)arg)->type,
+				((struct tuner_setup *)arg)->addr,
+				((struct tuner_setup *)arg)->mode_mask);
+
+		set_addr(client, (struct tuner_setup *)arg);
 		break;
 	case AUDC_SET_RADIO:
-		t->mode = V4L2_TUNER_RADIO;
-		CHECK_ADDR(tv_tuner,"AUDC_SET_RADIO","TV");
-
-		if (V4L2_TUNER_RADIO != t->mode) {
-			set_tv_freq(client,400 * 16);
-		}
+		set_mode(client,t,V4L2_TUNER_RADIO, "AUDC_SET_RADIO");
 		break;
 	case AUDC_CONFIG_PINNACLE:
-		CHECK_ADDR(tv_tuner,"AUDC_CONFIG_PINNACLE","TV");
+		if (check_mode(t, "AUDC_CONFIG_PINNACLE") == EINVAL)
+			return 0;
 		switch (*iarg) {
 		case 2:
 			tuner_dbg("pinnacle pal\n");
@@ -368,219 +446,238 @@
 			break;
 		}
 		break;
+	case TDA9887_SET_CONFIG:
+		break;
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
 	   kernel pointer here... */
 	case VIDIOCSCHAN:
-	{
-		static const v4l2_std_id map[] = {
-			[ VIDEO_MODE_PAL   ] = V4L2_STD_PAL,
-			[ VIDEO_MODE_NTSC  ] = V4L2_STD_NTSC_M,
-			[ VIDEO_MODE_SECAM ] = V4L2_STD_SECAM,
-			[ 4 /* bttv */     ] = V4L2_STD_PAL_M,
-			[ 5 /* bttv */     ] = V4L2_STD_PAL_N,
-			[ 6 /* bttv */     ] = V4L2_STD_NTSC_M_JP,
-		};
-		struct video_channel *vc = arg;
-
-		CHECK_V4L2;
-		t->mode = V4L2_TUNER_ANALOG_TV;
-		CHECK_ADDR(tv_tuner,"VIDIOCSCHAN","TV");
-
-		if (vc->norm < ARRAY_SIZE(map))
-			t->std = map[vc->norm];
-		tuner_fixup_std(t);
-		if (t->freq)
-			set_tv_freq(client,t->freq);
-		return 0;
-	}
+		{
+			static const v4l2_std_id map[] = {
+				[VIDEO_MODE_PAL] = V4L2_STD_PAL,
+				[VIDEO_MODE_NTSC] = V4L2_STD_NTSC_M,
+				[VIDEO_MODE_SECAM] = V4L2_STD_SECAM,
+				[4 /* bttv */ ] = V4L2_STD_PAL_M,
+				[5 /* bttv */ ] = V4L2_STD_PAL_N,
+				[6 /* bttv */ ] = V4L2_STD_NTSC_M_JP,
+			};
+			struct video_channel *vc = arg;
+
+			if (check_v4l2(t) == EINVAL)
+				return 0;
+
+			if (set_mode(client,t,V4L2_TUNER_ANALOG_TV, "VIDIOCSCHAN")==EINVAL)
+				return 0;
+
+			if (vc->norm < ARRAY_SIZE(map))
+				t->std = map[vc->norm];
+			tuner_fixup_std(t);
+			if (t->freq)
+				set_tv_freq(client, t->freq);
+			return 0;
+		}
 	case VIDIOCSFREQ:
-	{
-		unsigned long *v = arg;
+		{
+			unsigned long *v = arg;
 
-		CHECK_MODE("VIDIOCSFREQ");
-		CHECK_V4L2;
-		set_freq(client,*v);
-		return 0;
-	}
+			if (check_mode(t, "VIDIOCSFREQ") == EINVAL)
+				return 0;
+			if (check_v4l2(t) == EINVAL)
+				return 0;
+
+			set_freq(client, *v);
+			return 0;
+		}
 	case VIDIOCGTUNER:
-	{
-		struct video_tuner *vt = arg;
+		{
+			struct video_tuner *vt = arg;
 
-		CHECK_ADDR(radio_tuner,"VIDIOCGTUNER","radio");
-		CHECK_V4L2;
-		if (V4L2_TUNER_RADIO == t->mode) {
-			if (t->has_signal)
-				vt->signal = t->has_signal(client);
-			if (t->is_stereo) {
-				if (t->is_stereo(client))
-					vt->flags |= VIDEO_TUNER_STEREO_ON;
-				else
-					vt->flags &= ~VIDEO_TUNER_STEREO_ON;
-			}
-			vt->flags |= V4L2_TUNER_CAP_LOW; /* Allow freqs at 62.5 Hz */
+			if (check_mode(t, "VIDIOCGTUNER") == EINVAL)
+				return 0;
+			if (check_v4l2(t) == EINVAL)
+				return 0;
+
+			if (V4L2_TUNER_RADIO == t->mode) {
+				if (t->has_signal)
+					vt->signal = t->has_signal(client);
+				if (t->is_stereo) {
+					if (t->is_stereo(client))
+						vt->flags |=
+						    VIDEO_TUNER_STEREO_ON;
+					else
+						vt->flags &=
+						    ~VIDEO_TUNER_STEREO_ON;
+				}
+				vt->flags |= VIDEO_TUNER_LOW;	/* Allow freqs at 62.5 Hz */
 
-			vt->rangelow = radio_range[0] * 16000;
-			vt->rangehigh = radio_range[1] * 16000;
+				vt->rangelow = radio_range[0] * 16000;
+				vt->rangehigh = radio_range[1] * 16000;
 
-		} else {
-			vt->rangelow = tv_range[0] * 16;
-			vt->rangehigh = tv_range[1] * 16;
-		}
+			} else {
+				vt->rangelow = tv_range[0] * 16;
+				vt->rangehigh = tv_range[1] * 16;
+			}
 
-		return 0;
-	}
+			return 0;
+		}
 	case VIDIOCGAUDIO:
-	{
-		struct video_audio *va = arg;
+		{
+			struct video_audio *va = arg;
 
-		CHECK_ADDR(radio_tuner,"VIDIOCGAUDIO","radio");
-		CHECK_V4L2;
-		if (V4L2_TUNER_RADIO == t->mode  &&  t->is_stereo)
-			va->mode = t->is_stereo(client)
-				? VIDEO_SOUND_STEREO
-				: VIDEO_SOUND_MONO;
-		return 0;
-	}
+			if (check_mode(t, "VIDIOCGAUDIO") == EINVAL)
+				return 0;
+			if (check_v4l2(t) == EINVAL)
+				return 0;
+
+			if (V4L2_TUNER_RADIO == t->mode && t->is_stereo)
+				va->mode = t->is_stereo(client)
+				    ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
+			return 0;
+		}
 
 	case VIDIOC_S_STD:
-	{
-		v4l2_std_id *id = arg;
+		{
+			v4l2_std_id *id = arg;
 
-		SWITCH_V4L2;
-		t->mode = V4L2_TUNER_ANALOG_TV;
-		CHECK_ADDR(tv_tuner,"VIDIOC_S_STD","TV");
-
-		t->std = *id;
-		tuner_fixup_std(t);
-		if (t->freq)
-			set_freq(client,t->freq);
-		break;
-	}
+			if (set_mode (client, t, V4L2_TUNER_ANALOG_TV, "VIDIOC_S_STD")
+					== EINVAL)
+				return 0;
+
+			switch_v4l2();
+
+			t->std = *id;
+			tuner_fixup_std(t);
+			if (t->freq)
+				set_freq(client, t->freq);
+			break;
+		}
 	case VIDIOC_S_FREQUENCY:
-	{
-		struct v4l2_frequency *f = arg;
+		{
+			struct v4l2_frequency *f = arg;
 
-		CHECK_MODE("VIDIOC_S_FREQUENCY");
-		SWITCH_V4L2;
-		if (V4L2_TUNER_RADIO == f->type &&
-		    V4L2_TUNER_RADIO != t->mode)
-			set_tv_freq(client,400*16);
-		t->mode  = f->type;
-		set_freq(client,f->frequency);
-		break;
-	}
+			t->freq = f->frequency;
+			switch_v4l2();
+			if (V4L2_TUNER_RADIO == f->type &&
+			    V4L2_TUNER_RADIO != t->mode) {
+			        if (set_mode (client, t, f->type, "VIDIOC_S_FREQUENCY")
+					    == EINVAL)
+					return 0;
+			}
+			set_freq(client,t->freq);
+
+			break;
+		}
 	case VIDIOC_G_FREQUENCY:
-	{
-		struct v4l2_frequency *f = arg;
+		{
+			struct v4l2_frequency *f = arg;
 
-		CHECK_MODE("VIDIOC_G_FREQUENCY");
-		SWITCH_V4L2;
-		f->type = t->mode;
-		f->frequency = t->freq;
-		break;
-	}
+			if (check_mode(t, "VIDIOC_G_FREQUENCY") == EINVAL)
+				return 0;
+			switch_v4l2();
+			f->type = t->mode;
+			f->frequency = t->freq;
+			break;
+		}
 	case VIDIOC_G_TUNER:
-	{
-		struct v4l2_tuner *tuner = arg;
+		{
+			struct v4l2_tuner *tuner = arg;
 
-		CHECK_MODE("VIDIOC_G_TUNER");
-		SWITCH_V4L2;
-		if (V4L2_TUNER_RADIO == t->mode) {
-			if (t->has_signal)
-				tuner -> signal = t->has_signal(client);
-			if (t->is_stereo) {
-				if (t->is_stereo(client)) {
-					tuner -> rxsubchans = V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
-				} else {
-					tuner -> rxsubchans = V4L2_TUNER_SUB_MONO;
+			if (check_mode(t, "VIDIOC_G_TUNER") == EINVAL)
+				return 0;
+			switch_v4l2();
+
+			if (V4L2_TUNER_RADIO == t->mode) {
+
+				if (t->has_signal)
+					tuner->signal = t->has_signal(client);
+
+				if (t->is_stereo) {
+					if (t->is_stereo(client)) {
+						tuner->rxsubchans =
+						    V4L2_TUNER_SUB_STEREO |
+						    V4L2_TUNER_SUB_MONO;
+					} else {
+						tuner->rxsubchans =
+						    V4L2_TUNER_SUB_MONO;
+					}
 				}
-			}
-			tuner->capability |= V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
-			tuner->audmode = t->audmode;
-
-			tuner->rangelow = radio_range[0] * 16000;
-			tuner->rangehigh = radio_range[1] * 16000;
-		} else {
-			tuner->rangelow = tv_range[0] * 16;
-			tuner->rangehigh = tv_range[1] * 16;
-		}
-		break;
-	}
-	case VIDIOC_S_TUNER: /* Allow changing radio range and audio mode */
-	{
-		struct v4l2_tuner *tuner = arg;
 
-		CHECK_ADDR(radio_tuner,"VIDIOC_S_TUNER","radio");
-		SWITCH_V4L2;
+				tuner->capability |=
+				    V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
 
-		/* To switch the audio mode, applications initialize the
-		   index and audmode fields and the reserved array and
-		   call the VIDIOC_S_TUNER ioctl. */
-		/* rxsubchannels: V4L2_TUNER_MODE_MONO, V4L2_TUNER_MODE_STEREO,
-		   V4L2_TUNER_MODE_LANG1, V4L2_TUNER_MODE_LANG2,
-		   V4L2_TUNER_MODE_SAP */
+				tuner->audmode = t->audmode;
 
-		if (tuner->audmode == V4L2_TUNER_MODE_MONO)
-			t->audmode = V4L2_TUNER_MODE_MONO;
-		else
-			t->audmode = V4L2_TUNER_MODE_STEREO;
-
-		set_radio_freq(client, t->freq);
-		break;
-	}
-	case TDA9887_SET_CONFIG: /* Nothing to do on tuner-core */
-		break;
+				tuner->rangelow = radio_range[0] * 16000;
+				tuner->rangehigh = radio_range[1] * 16000;
+			} else {
+				tuner->rangelow = tv_range[0] * 16;
+				tuner->rangehigh = tv_range[1] * 16;
+			}
+			break;
+		}
+	case VIDIOC_S_TUNER:
+		{
+			struct v4l2_tuner *tuner = arg;
+
+			if (check_mode(t, "VIDIOC_S_TUNER") == EINVAL)
+				return 0;
+
+			switch_v4l2();
+
+			if (V4L2_TUNER_RADIO == t->mode) {
+				t->audmode = tuner->audmode;
+				set_radio_freq(client, t->freq);
+			}
+			break;
+		}
 	default:
-		tuner_dbg ("Unimplemented IOCTL 0x%08x called to tuner.\n", cmd);
-		/* nothing */
+		tuner_dbg("Unimplemented IOCTL 0x%08x called to tuner.\n", cmd);
 		break;
 	}
 
 	return 0;
 }
 
-static int tuner_suspend(struct device * dev, u32 state, u32 level)
+static int tuner_suspend(struct device *dev, u32 state, u32 level)
 {
-	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
-	struct tuner *t = i2c_get_clientdata(c);
+	struct i2c_client *c = container_of (dev, struct i2c_client, dev);
+	struct tuner *t = i2c_get_clientdata (c);
 
-	tuner_dbg("suspend\n");
+	tuner_dbg ("suspend\n");
 	/* FIXME: power down ??? */
 	return 0;
 }
 
-static int tuner_resume(struct device * dev, u32 level)
+static int tuner_resume(struct device *dev, u32 level)
 {
-	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
-	struct tuner *t = i2c_get_clientdata(c);
+	struct i2c_client *c = container_of (dev, struct i2c_client, dev);
+	struct tuner *t = i2c_get_clientdata (c);
 
-	tuner_dbg("resume\n");
+	tuner_dbg ("resume\n");
 	if (t->freq)
-		set_freq(c,t->freq);
+		set_freq(c, t->freq);
 	return 0;
 }
 
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.owner          = THIS_MODULE,
-        .name           = "tuner",
-        .id             = I2C_DRIVERID_TUNER,
-        .flags          = I2C_DF_NOTIFY,
-        .attach_adapter = tuner_probe,
-        .detach_client  = tuner_detach,
-        .command        = tuner_command,
+	.owner = THIS_MODULE,
+	.name = "tuner",
+	.id = I2C_DRIVERID_TUNER,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = tuner_probe,
+	.detach_client = tuner_detach,
+	.command = tuner_command,
 	.driver = {
-		.suspend = tuner_suspend,
-		.resume  = tuner_resume,
-	},
+		   .suspend = tuner_suspend,
+		   .resume = tuner_resume,
+		   },
 };
-static struct i2c_client client_template =
-{
+static struct i2c_client client_template = {
 	I2C_DEVNAME("(tuner unset)"),
-	.flags      = I2C_CLIENT_ALLOW_USE,
-        .driver     = &driver,
+	.flags = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
 };
 
 static int __init tuner_init_module(void)
diff -u linux-2.6.13/drivers/media/video/tuner-simple.c linux/drivers/media/video/tuner-simple.c
--- linux-2.6.13/drivers/media/video/tuner-simple.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-07-08 17:33:16.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.31 2005/06/21 16:02:25 mkrufky Exp $
+ * $Id: tuner-simple.c,v 1.39 2005/07/07 01:49:30 mkrufky Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -54,6 +54,27 @@
 #define PHILIPS_MF_SET_PAL_L	0x03 // France
 #define PHILIPS_MF_SET_PAL_L2	0x02 // L'
 
+/* Control byte */
+
+#define TUNER_RATIO_MASK        0x06 /* Bit cb1:cb2 */
+#define TUNER_RATIO_SELECT_50   0x00
+#define TUNER_RATIO_SELECT_32   0x02
+#define TUNER_RATIO_SELECT_166  0x04
+#define TUNER_RATIO_SELECT_62   0x06
+
+#define TUNER_CHARGE_PUMP       0x40  /* Bit cb6 */
+
+/* Status byte */
+
+#define TUNER_POR	  0x80
+#define TUNER_FL          0x40
+#define TUNER_MODE        0x38
+#define TUNER_AFC         0x07
+#define TUNER_SIGNAL      0x07
+#define TUNER_STEREO      0x10
+
+#define TUNER_PLL_LOCKED   0x40
+#define TUNER_STEREO_MK3   0x04
 
 /* ---------------------------------------------------------------------- */
 
@@ -211,21 +232,17 @@
 	  16*160.00,16*442.00,0x01,0x02,0x04,0xce,623 },
 	{ "Philips FQ1236A MK4", Philips, NTSC,
 	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
-
-	/* Should work for TVF8531MF, TVF8831MF, TVF8731MF */
-	{ "Ymec TVision TVF-8531MF", Philips, NTSC,
+	{ "Ymec TVision TVF-8531MF/8831MF/8731MF", Philips, NTSC,
 	  16*160.00,16*454.00,0xa0,0x90,0x30,0x8e,732},
 	{ "Ymec TVision TVF-5533MF", Philips, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x04,0x8e,732},
+
 	{ "Thomson DDT 7611 (ATSC/NTSC)", THOMSON, ATSC,
 	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
-	/* Should work for TNF9533-D/IF, TNF9533-B/DF */
-	{ "Tena TNF9533-D/IF", Philips, PAL,
+	{ "Tena TNF9533-D/IF/TNF9533-B/DF", Philips, PAL,
           16*160.25,16*464.25,0x01,0x02,0x04,0x8e,623},
-
-	/* This entry is for TEA5767 FM radio only chip used on several boards w/TV tuner */
-	{ TEA5767_TUNER_NAME, Philips, RADIO,
-          -1, -1, 0, 0, 0, TEA5767_LOW_LO_32768,0},
+	{ "Philips TEA5767HN FM Radio", Philips, RADIO,
+          /* see tea5767.c for details */},
 	{ "Philips FMD1216ME MK3 Hybrid Tuner", Philips, PAL,
 	  16*160.00,16*442.00,0x51,0x52,0x54,0x86,623 },
 };
@@ -244,15 +261,6 @@
 	return byte;
 }
 
-#define TUNER_POR       0x80
-#define TUNER_FL        0x40
-#define TUNER_MODE      0x38
-#define TUNER_AFC       0x07
-
-#define TUNER_STEREO       0x10 /* radio mode */
-#define TUNER_STEREO_MK3   0x04 /* radio mode */
-#define TUNER_SIGNAL       0x07 /* radio mode */
-
 static int tuner_signal(struct i2c_client *c)
 {
 	return (tuner_getstatus(c) & TUNER_SIGNAL) << 13;
@@ -278,22 +286,6 @@
 	return stereo;
 }
 
-#if 0 /* unused */
-static int tuner_islocked (struct i2c_client *c)
-{
-        return (tuner_getstatus (c) & TUNER_FL);
-}
-
-static int tuner_afcstatus (struct i2c_client *c)
-{
-        return (tuner_getstatus (c) & TUNER_AFC) - 2;
-}
-
-static int tuner_mode (struct i2c_client *c)
-{
-        return (tuner_getstatus (c) & TUNER_MODE) >> 3;
-}
-#endif
 
 /* ---------------------------------------------------------------------- */
 
@@ -376,7 +368,7 @@
 
 	case TUNER_MICROTUNE_4042FI5:
 		/* Set the charge pump for fast tuning */
-		tun->config |= 0x40;
+		tun->config |= TUNER_CHARGE_PUMP;
 		break;
 	}
 
@@ -425,14 +417,13 @@
 				tuner_warn("i2c i/o read error: rc == %d (should be 1)\n",rc);
 				break;
 			}
-			/* bit 6 is PLL locked indicator */
-			if (status_byte & 0x40)
+			if (status_byte & TUNER_PLL_LOCKED)
 				break;
 			udelay(10);
 		}
 
 		/* Set the charge pump for optimized phase noise figure */
-		tun->config &= ~0x40;
+		tun->config &= ~TUNER_CHARGE_PUMP;
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
 		buffer[2] = tun->config;
@@ -453,26 +444,22 @@
 	unsigned div;
 	int rc;
 
-	tun=&tuners[t->type];
-	div = (freq / 1000) + (int)(16*10.7);
-	buffer[2] = tun->config;
+	tun = &tuners[t->type];
+	div = (20 * freq / 16000) + (int)(20*10.7); /* IF 10.7 MHz */
+	buffer[2] = (tun->config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */
 
 	switch (t->type) {
 	case TUNER_TENA_9533_DI:
 	case TUNER_YMEC_TVF_5533MF:
-		/*These values are empirically determinated */
-		div = (freq * 122) / 16000 - 20;
-		buffer[2] = 0x88; /* could be also 0x80 */
-		buffer[3] = 0x19; /* could be also 0x10, 0x18, 0x99 */
-		break;
+		tuner_dbg ("This tuner doesn't have FM. Most cards has a TEA5767 for FM\n");
+		return;
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 	case TUNER_PHILIPS_FMD1216ME_MK3:
 		buffer[3] = 0x19;
 		break;
 	case TUNER_PHILIPS_FM1256_IH3:
-		div = (20 * freq) / 16000 + 333 * 2;
-	        buffer[2] = 0x80;
+		div = (20 * freq) / 16000 + (int)(33.3 * 20);  /* IF 33.3 MHz */
 		buffer[3] = 0x19;
 		break;
 	case TUNER_LG_PAL_FM:
diff -u linux-2.6.13/drivers/media/video/mt20xx.c linux/drivers/media/video/mt20xx.c
--- linux-2.6.13/drivers/media/video/mt20xx.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/mt20xx.c	2005-07-08 17:33:16.000000000 -0300
@@ -511,22 +511,6 @@
 	tuner_info("microtune: companycode=%04x part=%02x rev=%02x\n",
 		   company_code,buf[0x13],buf[0x14]);
 
-#if 0
-	/* seems to cause more problems than it solves ... */
-	switch (company_code) {
-	case 0x30bf:
-	case 0x3cbf:
-	case 0x3dbf:
-	case 0x4d54:
-	case 0x8e81:
-	case 0x8e91:
-		/* ok (?) */
-		break;
-	default:
-		tuner_warn("tuner: microtune: unknown companycode\n");
-		return 0;
-	}
-#endif
 
 	if (buf[0x13] < ARRAY_SIZE(microtune_part) &&
 	    NULL != microtune_part[buf[0x13]])
diff -u linux-2.6.13/drivers/media/video/tda8290.c linux/drivers/media/video/tda8290.c
--- linux-2.6.13/drivers/media/video/tda8290.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tda8290.c	2005-07-08 17:33:16.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tda8290.c,v 1.11 2005/06/18 06:09:06 nsh Exp $
+ * $Id: tda8290.c,v 1.15 2005/07/08 20:21:33 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * controls the philips tda8290+75 tuner chip combo.
@@ -136,15 +136,12 @@
 	return 0;
 }
 
-static void set_frequency(struct tuner *t, u16 ifc)
+static void set_frequency(struct tuner *t, u16 ifc, unsigned int freq)
 {
-	u32 freq;
 	u32 N;
 
 	if (t->mode == V4L2_TUNER_RADIO)
-		freq = t->freq / 1000;
-	else
-		freq = t->freq;
+		freq = freq / 1000;
 
 	N = (((freq<<3)+ifc)&0x3fffc);
 
@@ -187,14 +184,14 @@
 	struct tuner *t = i2c_get_clientdata(c);
 
 	set_audio(t);
-	set_frequency(t, 864);
+	set_frequency(t, 864, freq);
 	tda8290_tune(c);
 }
 
 static void set_radio_freq(struct i2c_client *c, unsigned int freq)
 {
 	struct tuner *t = i2c_get_clientdata(c);
-	set_frequency(t, 704);
+	set_frequency(t, 704, freq);
 	tda8290_tune(c);
 }
 
diff -u linux-2.6.13/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.13/drivers/media/video/tda9887.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tda9887.c	2005-07-08 17:33:16.000000000 -0300
@@ -569,15 +569,6 @@
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
-#if 0
-	/* This as-is breaks some cards, must be fixed in a
-	 * card-specific way, probably using TDA9887_SET_CONFIG to
-	 * turn on/off port2 */
-	if (t->std & V4L2_STD_SECAM_L) {
-		/* secam fixup (FIXME: move this to tvnorms array?) */
-		buf[1] &= ~cOutputPort2Inactive;
-	}
-#endif
 
 	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
 		buf[1],buf[2],buf[3]);
diff -u linux-2.6.13/drivers/media/video/tea5767.c linux/drivers/media/video/tea5767.c
--- linux-2.6.13/drivers/media/video/tea5767.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tea5767.c	2005-07-08 17:33:16.000000000 -0300
@@ -2,7 +2,7 @@
  * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
  * I2C address is allways 0xC0.
  *
- * $Id: tea5767.c,v 1.11 2005/06/21 15:40:33 mchehab Exp $
+ * $Id: tea5767.c,v 1.18 2005/07/07 03:02:55 mchehab Exp $
  *
  * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
  * This code is placed under the terms of the GNU General Public License
@@ -11,23 +11,11 @@
  * from their contributions on DScaler.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/timer.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/videodev.h>
 #include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-
+#include <linux/videodev.h>
+#include <linux/delay.h>
+#include <media/tuner.h>
 #include <media/tuner.h>
-
-/* Declared at tuner-core.c */
-extern unsigned int tuner_debug;
 
 #define PREFIX "TEA5767 "
 
@@ -38,8 +26,8 @@
  ******************************/
 
 /* First register */
-#define TEA5767_MUTE		0x80 /* Mutes output */
-#define TEA5767_SEARCH		0x40 /* Activates station search */
+#define TEA5767_MUTE		0x80	/* Mutes output */
+#define TEA5767_SEARCH		0x40	/* Activates station search */
 /* Bits 0-5 for divider MSB */
 
 /* Second register */
@@ -130,6 +118,14 @@
 /* Reserved for future extensions */
 #define TEA5767_RESERVED_MASK	0xff
 
+enum tea5767_xtal_freq {
+        TEA5767_LOW_LO_32768    = 0,
+        TEA5767_HIGH_LO_32768   = 1,
+        TEA5767_LOW_LO_13MHz    = 2,
+        TEA5767_HIGH_LO_13MHz   = 3,
+};
+
+
 /*****************************************************************************/
 
 static void set_tv_freq(struct i2c_client *c, unsigned int freq)
@@ -153,103 +149,112 @@
 	else
 		printk(PREFIX "Tuner not at band limit\n");
 
-	div=((buffer[0]&0x3f)<<8) | buffer[1];
+	div = ((buffer[0] & 0x3f) << 8) | buffer[1];
 
 	switch (TEA5767_HIGH_LO_32768) {
 	case TEA5767_HIGH_LO_13MHz:
-		frq = 1000*(div*50-700-225)/4; /* Freq in KHz */
+		frq = 1000 * (div * 50 - 700 - 225) / 4;	/* Freq in KHz */
 		break;
 	case TEA5767_LOW_LO_13MHz:
-		frq = 1000*(div*50+700+225)/4; /* Freq in KHz */
+		frq = 1000 * (div * 50 + 700 + 225) / 4;	/* Freq in KHz */
 		break;
 	case TEA5767_LOW_LO_32768:
-		frq = 1000*(div*32768/1000+700+225)/4; /* Freq in KHz */
+		frq = 1000 * (div * 32768 / 1000 + 700 + 225) / 4;	/* Freq in KHz */
 		break;
 	case TEA5767_HIGH_LO_32768:
 	default:
-		frq = 1000*(div*32768/1000-700-225)/4; /* Freq in KHz */
+		frq = 1000 * (div * 32768 / 1000 - 700 - 225) / 4;	/* Freq in KHz */
 		break;
 	}
-        buffer[0] = (div>>8) & 0x3f;
-        buffer[1] = div      & 0xff;
+	buffer[0] = (div >> 8) & 0x3f;
+	buffer[1] = div & 0xff;
 
 	printk(PREFIX "Frequency %d.%03d KHz (divider = 0x%04x)\n",
-						frq/1000,frq%1000,div);
+	       frq / 1000, frq % 1000, div);
 
 	if (TEA5767_STEREO_MASK & buffer[2])
 		printk(PREFIX "Stereo\n");
 	else
 		printk(PREFIX "Mono\n");
 
-	printk(PREFIX "IF Counter = %d\n",buffer[2] & TEA5767_IF_CNTR_MASK);
+	printk(PREFIX "IF Counter = %d\n", buffer[2] & TEA5767_IF_CNTR_MASK);
 
-	printk(PREFIX "ADC Level = %d\n",(buffer[3] & TEA5767_ADC_LEVEL_MASK)>>4);
+	printk(PREFIX "ADC Level = %d\n",
+	       (buffer[3] & TEA5767_ADC_LEVEL_MASK) >> 4);
 
-	printk(PREFIX "Chip ID = %d\n",(buffer[3] & TEA5767_CHIP_ID_MASK));
+	printk(PREFIX "Chip ID = %d\n", (buffer[3] & TEA5767_CHIP_ID_MASK));
 
-	printk(PREFIX "Reserved = 0x%02x\n",(buffer[4] & TEA5767_RESERVED_MASK));
+	printk(PREFIX "Reserved = 0x%02x\n",
+	       (buffer[4] & TEA5767_RESERVED_MASK));
 }
 
 /* Freq should be specifyed at 62.5 Hz */
 static void set_radio_freq(struct i2c_client *c, unsigned int frq)
 {
 	struct tuner *t = i2c_get_clientdata(c);
-        unsigned char buffer[5];
+	unsigned char buffer[5];
 	unsigned div;
 	int rc;
 
-	if ( tuner_debug )
-		printk(PREFIX "radio freq counter %d\n",frq);
+	tuner_dbg (PREFIX "radio freq counter %d\n", frq);
 
 	/* Rounds freq to next decimal value - for 62.5 KHz step */
 	/* frq = 20*(frq/16)+radio_frq[frq%16]; */
 
 	buffer[2] = TEA5767_PORT1_HIGH;
-	buffer[3] = TEA5767_PORT2_HIGH | TEA5767_HIGH_CUT_CTRL | TEA5767_ST_NOISE_CTL | TEA5767_JAPAN_BAND;
-	buffer[4]=0;
+	buffer[3] = TEA5767_PORT2_HIGH | TEA5767_HIGH_CUT_CTRL |
+		    TEA5767_ST_NOISE_CTL | TEA5767_JAPAN_BAND;
+	buffer[4] = 0;
+
+	if (t->mode == T_STANDBY) {
+		tuner_dbg("TEA5767 set to standby mode\n");
+		buffer[3] |= TEA5767_STDBY;
+	}
 
 	if (t->audmode == V4L2_TUNER_MODE_MONO) {
 		tuner_dbg("TEA5767 set to mono\n");
 		buffer[2] |= TEA5767_MONO;
-	} else
- 		tuner_dbg("TEA5767 set to stereo\n");
+	} else {
+		tuner_dbg("TEA5767 set to stereo\n");
+	}
 
-	switch (t->type) {
+	/* Should be replaced */
+	switch (TEA5767_HIGH_LO_32768) {
 	case TEA5767_HIGH_LO_13MHz:
-		tuner_dbg("TEA5767 radio HIGH LO inject xtal @ 13 MHz\n");
+		tuner_dbg ("TEA5767 radio HIGH LO inject xtal @ 13 MHz\n");
 		buffer[2] |= TEA5767_HIGH_LO_INJECT;
 		buffer[4] |= TEA5767_PLLREF_ENABLE;
-		div = (frq*4/16+700+225+25)/50;
+		div = (frq * 4 / 16 + 700 + 225 + 25) / 50;
 		break;
 	case TEA5767_LOW_LO_13MHz:
-		tuner_dbg("TEA5767 radio LOW LO inject xtal @ 13 MHz\n");
+		tuner_dbg ("TEA5767 radio LOW LO inject xtal @ 13 MHz\n");
 
 		buffer[4] |= TEA5767_PLLREF_ENABLE;
-		div = (frq*4/16-700-225+25)/50;
+		div = (frq * 4 / 16 - 700 - 225 + 25) / 50;
 		break;
 	case TEA5767_LOW_LO_32768:
-		tuner_dbg("TEA5767 radio LOW LO inject xtal @ 32,768 MHz\n");
+		tuner_dbg ("TEA5767 radio LOW LO inject xtal @ 32,768 MHz\n");
 		buffer[3] |= TEA5767_XTAL_32768;
 		/* const 700=4000*175 Khz - to adjust freq to right value */
-		div = (1000*(frq*4/16-700-225)+16384)>>15;
+		div = (1000 * (frq * 4 / 16 - 700 - 225) + 16384) >> 15;
 		break;
 	case TEA5767_HIGH_LO_32768:
 	default:
-		tuner_dbg("TEA5767 radio HIGH LO inject xtal @ 32,768 MHz\n");
+		tuner_dbg ("TEA5767 radio HIGH LO inject xtal @ 32,768 MHz\n");
 
 		buffer[2] |= TEA5767_HIGH_LO_INJECT;
 		buffer[3] |= TEA5767_XTAL_32768;
-		div = (1000*(frq*4/16+700+225)+16384)>>15;
+		div = (1000 * (frq * 4 / 16 + 700 + 225) + 16384) >> 15;
 		break;
 	}
-        buffer[0] = (div>>8) & 0x3f;
-        buffer[1] = div      & 0xff;
+	buffer[0] = (div >> 8) & 0x3f;
+	buffer[1] = div & 0xff;
 
-	if ( tuner_debug )
+	if (tuner_debug)
 		tea5767_status_dump(buffer);
 
-        if (5 != (rc = i2c_master_send(c,buffer,5)))
-		tuner_warn("i2c i/o error: rc == %d (should be 5)\n",rc);
+	if (5 != (rc = i2c_master_send(c, buffer, 5)))
+		tuner_warn("i2c i/o error: rc == %d (should be 5)\n", rc);
 }
 
 static int tea5767_signal(struct i2c_client *c)
@@ -258,11 +263,11 @@
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
-	memset(buffer,0,sizeof(buffer));
-        if (5 != (rc = i2c_master_recv(c,buffer,5)))
-                tuner_warn ( "i2c i/o error: rc == %d (should be 5)\n",rc);
+	memset(buffer, 0, sizeof(buffer));
+	if (5 != (rc = i2c_master_recv(c, buffer, 5)))
+		tuner_warn("i2c i/o error: rc == %d (should be 5)\n", rc);
 
-	return ((buffer[3] & TEA5767_ADC_LEVEL_MASK) <<(13-4));
+	return ((buffer[3] & TEA5767_ADC_LEVEL_MASK) << (13 - 4));
 }
 
 static int tea5767_stereo(struct i2c_client *c)
@@ -271,47 +276,46 @@
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
-	memset(buffer,0,sizeof(buffer));
-        if (5 != (rc = i2c_master_recv(c,buffer,5)))
-                tuner_warn ( "i2c i/o error: rc == %d (should be 5)\n",rc);
+	memset(buffer, 0, sizeof(buffer));
+	if (5 != (rc = i2c_master_recv(c, buffer, 5)))
+		tuner_warn("i2c i/o error: rc == %d (should be 5)\n", rc);
 
 	rc = buffer[2] & TEA5767_STEREO_MASK;
 
-	if ( tuner_debug )
-		tuner_dbg("TEA5767 radio ST GET = %02x\n", rc);
+	tuner_dbg("TEA5767 radio ST GET = %02x\n", rc);
 
-	return ( (buffer[2] & TEA5767_STEREO_MASK) ? V4L2_TUNER_SUB_STEREO: 0);
+	return ((buffer[2] & TEA5767_STEREO_MASK) ? V4L2_TUNER_SUB_STEREO : 0);
 }
 
-int tea_detection(struct i2c_client *c)
+int tea5767_autodetection(struct i2c_client *c)
 {
-	unsigned char buffer[5]= { 0xff, 0xff, 0xff, 0xff, 0xff };
+	unsigned char buffer[5] = { 0xff, 0xff, 0xff, 0xff, 0xff };
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
-        if (5 != (rc = i2c_master_recv(c,buffer,5))) {
-                tuner_warn ( "it is not a TEA5767. Received %i chars.\n",rc );
+	if (5 != (rc = i2c_master_recv(c, buffer, 5))) {
+		tuner_warn("it is not a TEA5767. Received %i chars.\n", rc);
 		return EINVAL;
 	}
 
 	/* If all bytes are the same then it's a TV tuner and not a tea5767 chip. */
-	if (buffer[0] == buffer[1] &&  buffer[0] == buffer[2] &&
-	    buffer[0] == buffer[3] &&  buffer[0] == buffer[4]) {
-                tuner_warn ( "All bytes are equal. It is not a TEA5767\n" );
+	if (buffer[0] == buffer[1] && buffer[0] == buffer[2] &&
+	    buffer[0] == buffer[3] && buffer[0] == buffer[4]) {
+		tuner_warn("All bytes are equal. It is not a TEA5767\n");
 		return EINVAL;
 	}
 
 	/*  Status bytes:
 	 *  Byte 4: bit 3:1 : CI (Chip Identification) == 0
-	 *	    bit 0   : internally set to 0
+	 *          bit 0   : internally set to 0
 	 *  Byte 5: bit 7:0 : == 0
 	 */
 
 	if (!((buffer[3] & 0x0f) == 0x00) && (buffer[4] == 0x00)) {
-                tuner_warn ( "Chip ID is not zero. It is not a TEA5767\n" );
+		tuner_warn("Chip ID is not zero. It is not a TEA5767\n");
 		return EINVAL;
 	}
-	tuner_warn ( "TEA5767 detected.\n" );
+	tuner_warn("TEA5767 detected.\n");
 	return 0;
 }
 
@@ -319,16 +323,16 @@
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (tea_detection(c)==EINVAL) return EINVAL;
+	if (tea5767_autodetection(c) == EINVAL)
+		return EINVAL;
 
-        tuner_info("type set to %d (%s)\n",
-                   t->type, TEA5767_TUNER_NAME);
-        strlcpy(c->name, TEA5767_TUNER_NAME, sizeof(c->name));
+	tuner_info("type set to %d (%s)\n", t->type, "Philips TEA5767HN FM Radio");
+	strlcpy(c->name, "tea5767", sizeof(c->name));
 
-	t->tv_freq    = set_tv_freq;
+	t->tv_freq = set_tv_freq;
 	t->radio_freq = set_radio_freq;
 	t->has_signal = tea5767_signal;
-	t->is_stereo  = tea5767_stereo;
+	t->is_stereo = tea5767_stereo;
 
 	return (0);
 }

--------------010000090505050700060101--

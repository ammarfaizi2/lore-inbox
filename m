Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTELRo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTELRo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:44:57 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:662 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262385AbTELRmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:42:24 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:22:29 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #6 - tuner module update
Message-ID: <20030512172229.GA24345@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the tv card tuner module.  It adds support for a new
tuner and has some minor fixes + cleanups.  Also deletes some dead code.

Please apply,

  Gerd

diff -u linux-2.5.69/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.5.69/drivers/media/video/tuner.c	2003-05-08 13:31:45.000000000 +0200
+++ linux/drivers/media/video/tuner.c	2003-05-08 13:55:11.000000000 +0200
@@ -20,13 +20,15 @@
 static unsigned short normal_i2c_range[] = {0x60,0x6f,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
+#define UNSET (-1U)
+
 /* insmod options */
-static int debug =  0;
-static int type  = -1;
-static int addr  =  0;
+static unsigned int debug =  0;
+static unsigned int type  =  UNSET;
+static unsigned int addr  =  0;
 static char *pal =  "b";
-static int tv_range[2]    = { 44, 958 };
-static int radio_range[2] = { 65, 108 };
+static unsigned int tv_range[2]    = { 44, 958 };
+static unsigned int radio_range[2] = { 65, 108 };
 MODULE_PARM(debug,"i");
 MODULE_PARM(type,"i");
 MODULE_PARM(addr,"i");
@@ -45,13 +47,16 @@
 
 struct tuner
 {
-	int type;            /* chip type */
-	int freq;            /* keep track of the current settings */
-	int std;
-
-	int radio;
-	int mode;            /* current norm for multi-norm tuners */
-	int xogc;	     // only for MT2032
+	unsigned int type;            /* chip type */
+	unsigned int freq;            /* keep track of the current settings */
+	unsigned int std;
+	
+	unsigned int radio;
+	unsigned int mode;            /* current norm for multi-norm tuners */
+	
+	// only for MT2032
+	unsigned int xogc;
+	unsigned int radio_if2;
 };
 
 static struct i2c_driver driver;
@@ -217,8 +222,11 @@
 	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,623 },
 	{ "LG NTSC (newer TAPC series)", LGINNOTEK, NTSC,
           16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,732},
+
+	{ "HITACHI V7-J180AT", HITACHI, NTSC,
+	  16*170.00, 16*450.00, 0x01,0x02,0x00,0x8e,940 },
 };
-#define TUNERS (sizeof(tuners)/sizeof(struct tunertype))
+#define TUNERS ARRAY_SIZE(tuners)
 
 /* ---------------------------------------------------------------------- */
 
@@ -381,10 +389,15 @@
 	return 1;
 }
 
-static int mt2032_compute_freq(int rfin, int if1, int if2, int spectrum_from,
-	int spectrum_to, unsigned char *buf, int *ret_sel, int xogc) //all in Hz
+static int mt2032_compute_freq(unsigned int rfin,
+			       unsigned int if1, unsigned int if2,
+			       unsigned int spectrum_from,
+			       unsigned int spectrum_to,
+			       unsigned char *buf,
+			       int *ret_sel,
+			       unsigned int xogc) //all in Hz
 {
-        int fref,lo1,lo1n,lo1a,s,sel,lo1freq, desired_lo1,
+        unsigned int fref,lo1,lo1n,lo1a,s,sel,lo1freq, desired_lo1,
 		desired_lo2,lo2,lo2n,lo2a,lo2num,lo2freq;
 
         fref= 5250 *1000; //5.25MHz
@@ -513,7 +526,9 @@
 }
 
 
-static void mt2032_set_if_freq(struct i2c_client *c,int rfin, int if1, int if2, int from, int to)
+static void mt2032_set_if_freq(struct i2c_client *c, unsigned int rfin,
+			       unsigned int if1, unsigned int if2,
+			       unsigned int from, unsigned int to)
 {
 	unsigned char buf[21];
 	int lint_try,ret,sel,lock=0;
@@ -568,28 +583,30 @@
 }
 
 
-static void mt2032_set_tv_freq(struct i2c_client *c, int freq, int norm)
+static void mt2032_set_tv_freq(struct i2c_client *c,
+			       unsigned int freq, unsigned int norm)
 {
 	int if2,from,to;
 
 	// signal bandwidth and picture carrier
-	if(norm==VIDEO_MODE_NTSC) {
+	if (norm==VIDEO_MODE_NTSC) {
 		from=40750*1000;
 		to=46750*1000;
 		if2=45750*1000; 
-	}
-	else {  // Pal 
+	} else {
+		// Pal 
 		from=32900*1000;
 		to=39900*1000;
 		if2=38900*1000;
 	}
 
-        mt2032_set_if_freq(c,freq* 1000*1000/16, 1090*1000*1000, if2, from, to);
+        mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */,
+			   1090*1000*1000, if2, from, to);
 }
 
 
 // Set tuner frequency,  freq in Units of 62.5kHz = 1/16MHz
-static void set_tv_freq(struct i2c_client *c, int freq)
+static void set_tv_freq(struct i2c_client *c, unsigned int freq)
 {
 	u8 config;
 	u16 div;
@@ -598,7 +615,7 @@
         unsigned char buffer[4];
 	int rc;
 
-	if (t->type == -1) {
+	if (t->type == UNSET) {
 		printk("tuner: tuner type not set\n");
 		return;
 	}
@@ -720,22 +737,23 @@
 
 }
 
-static void mt2032_set_radio_freq(struct i2c_client *c,int freq)
-{               
-        int if2;
-
-        if2=10700*1000; //  10.7MHz FM intermediate frequency
+static void mt2032_set_radio_freq(struct i2c_client *c, unsigned int freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+	int if2 = t->radio_if2;
 
 	// per Manual for FM tuning: first if center freq. 1085 MHz
-        mt2032_set_if_freq(c,freq* 1000*1000/16, 1085*1000*1000,if2,if2,if2);
+        mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */,
+			   1085*1000*1000,if2,if2,if2);
 }
 
-static void set_radio_freq(struct i2c_client *c, int freq)
+static void set_radio_freq(struct i2c_client *c, unsigned int freq)
 {
 	struct tunertype *tun;
 	struct tuner *t = i2c_get_clientdata(c);
         unsigned char buffer[4];
-	int rc,div;
+	unsigned div;
+	int rc;
 
 	if (freq < radio_range[0]*16 || freq > radio_range[1]*16) {
 		printk("tuner: radio freq (%d.%02d) out of range (%d-%d)\n",
@@ -743,7 +761,7 @@
 		       radio_range[0],radio_range[1]);
 		return;
 	}
-	if (t->type == -1) {
+	if (t->type == UNSET) {
 		printk("tuner: tuner type not set\n");
 		return;
 	}
@@ -798,20 +816,20 @@
                 kfree(client);
                 return -ENOMEM;
         }
-	i2c_set_clientdata(client, t);
         memset(t,0,sizeof(struct tuner));
-	if (type >= 0 && type < TUNERS) {
+	i2c_set_clientdata(client, t);
+	t->type       = UNSET;
+	t->radio_if2  = 10700*1000; // 10.7MHz - FM radio
+
+	if (type < TUNERS) {
 		t->type = type;
 		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
 		strncpy(client->dev.name, tuners[t->type].name, DEVICE_NAME_SIZE);
-	} else {
-		t->type = -1;
 	}
         i2c_attach_client(client);
         if (t->type == TUNER_MT2032)
                  mt2032_init(client);
 
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -835,7 +853,6 @@
 	i2c_detach_client(client);
 	kfree(t);
 	kfree(client);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -843,20 +860,17 @@
 tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	struct tuner *t = i2c_get_clientdata(client);
-        int   *iarg = (int*)arg;
-#if 0
-        __u16 *sarg = (__u16*)arg;
-#endif
+        unsigned int *iarg = (int*)arg;
 
         switch (cmd) {
 
 	/* --- configuration --- */
 	case TUNER_SET_TYPE:
-		if (t->type != -1) {
+		if (t->type != UNSET) {
 			printk("tuner: type already set (%d)\n",t->type);
 			return 0;
 		}
-		if (*iarg < 0 || *iarg >= TUNERS)
+		if (*iarg >= TUNERS)
 			return 0;
 		t->type = *iarg;
 		printk("tuner: type set to %d (%s)\n",
@@ -868,6 +882,18 @@
 	case AUDC_SET_RADIO:
 		t->radio = 1;
 		break;
+	case AUDC_CONFIG_PINNACLE:
+		switch (*iarg) {
+		case 2:
+			dprintk("tuner: pinnacle pal\n");
+			t->radio_if2 = 33300 * 1000;
+			break;
+		case 3:
+			dprintk("tuner: pinnacle ntsc\n");
+			t->radio_if2 = 41300 * 1000;
+			break;
+		}
+                break;
 		
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
@@ -913,35 +939,6 @@
 			va->mode = (tuner_stereo(client) ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO);
 		return 0;
 	}
-	
-#if 0
-	/* --- old, obsolete interface --- */
-	case TUNER_SET_TVFREQ:
-		dprintk("tuner: tv freq set to %d.%02d\n",
-			(*iarg)/16,(*iarg)%16*100/16);
-		set_tv_freq(client,*iarg);
-		t->radio = 0;
-		t->freq = *iarg;
-		break;
-
-	case TUNER_SET_RADIOFREQ:
-		dprintk("tuner: radio freq set to %d.%02d\n",
-			(*iarg)/16,(*iarg)%16*100/16);
-		set_radio_freq(client,*iarg);
-		t->radio = 1;
-		t->freq = *iarg;
-		break;
-	case TUNER_SET_MODE:
-		if (t->type != TUNER_PHILIPS_SECAM) {
-			dprintk("tuner: trying to change mode for other than TUNER_PHILIPS_SECAM\n");
-		} else {
-			int mode=(*sarg==VIDEO_MODE_SECAM)?1:0;
-			dprintk("tuner: mode set to %d\n", *sarg);
-			t->mode = mode;
-			set_tv_freq(client,t->freq);
-		}
-		break;
-#endif
 	default:
 		/* nothing */
 		break;
@@ -963,11 +960,9 @@
 };
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
-        .dev	= {
-		.name	= "(tuner unset)",
-	},
+        .dev.name   = "(tuner unset)",
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &driver,
 };
 
 static int tuner_init_module(void)
diff -u linux-2.5.69/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.5.69/include/media/tuner.h	2003-05-08 13:31:32.000000000 +0200
+++ linux/include/media/tuner.h	2003-05-08 13:55:12.000000000 +0200
@@ -64,7 +64,7 @@
 #define TUNER_LG_PAL_NEW_TAPC   37
 #define TUNER_PHILIPS_FM1216ME_MK3  38
 #define TUNER_LG_NTSC_NEW_TAPC   39
-
+#define TUNER_HITACHI_NTSC       40
 
 
 
@@ -83,6 +83,7 @@
 #define SHARP   6
 #define Samsung 7
 #define Microtune 8
+#define HITACHI 9
 
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */

-- 
sigfault

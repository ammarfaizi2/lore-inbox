Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTAHL5B>; Wed, 8 Jan 2003 06:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTAHL5B>; Wed, 8 Jan 2003 06:57:01 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19861 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267244AbTAHL41>; Wed, 8 Jan 2003 06:56:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 13:11:23 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] media/video i2c updates
Message-ID: <20030108121123.GA17347@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates a bunch of i2c modules in drivers/media/video.
Most of it are adaptions to the recent i2c changes in the kernel.
While being at it I also did some other cleanups like deleting
unused+dead code, using name-based initialization for some not-yet
converted structs, ...

The patch also has a few small fixes here and there, but no major
functional changes.

Please apply,

  Gerd

--- linux-2.5.54/drivers/media/video/audiochip.h	2003-01-08 10:59:58.000000000 +0100
+++ linux/drivers/media/video/audiochip.h	2003-01-08 10:59:59.000000000 +0100
@@ -30,44 +30,6 @@
  * make sense in v4l context only.  So I think that's acceptable...
  */
 
-#if 0
-
-/* TODO (if it is ever [to be] accessible in the V4L[2] spec):
- *   maybe fade? (back/front)
- * notes:
- * NEWCHANNEL and SWITCH_MUTE are here because the MSP3400 has a special
- * routine to go through when it tunes in to a new channel before turning
- * back on the sound.
- * Either SET_RADIO, NEWCHANNEL, and SWITCH_MUTE or SET_INPUT need to be
- * implemented (MSP3400 uses SET_RADIO to select inputs, and SWITCH_MUTE for
- * channel-change mute -- TEA6300 et al use SET_AUDIO to select input [TV, 
- * radio, external, or MUTE]).  If both methods are implemented, you get a
- * cookie for doing such a good job! :)
- */
-
-#define AUDC_SET_TVNORM       _IOW('m',1,int)  /* TV mode + PAL/SECAM/NTSC  */
-#define AUDC_NEWCHANNEL       _IO('m',3)       /* indicate new chan - off mute */
-
-#define AUDC_GET_VOLUME_LEFT  _IOR('m',4,__u16)
-#define AUDC_GET_VOLUME_RIGHT _IOR('m',5,__u16)
-#define AUDC_SET_VOLUME_LEFT  _IOW('m',6,__u16)
-#define AUDC_SET_VOLUME_RIGHT _IOW('m',7,__u16)
-
-#define AUDC_GET_STEREO       _IOR('m',8,__u16)
-#define AUDC_SET_STEREO       _IOW('m',9,__u16)
-
-#define AUDC_GET_DC           _IOR('m',10,__u16)/* ??? */
-
-#define AUDC_GET_BASS         _IOR('m',11,__u16)
-#define AUDC_SET_BASS         _IOW('m',12,__u16)
-#define AUDC_GET_TREBLE       _IOR('m',13,__u16)
-#define AUDC_SET_TREBLE       _IOW('m',14,__u16)
-
-#define AUDC_GET_UNIT         _IOR('m',15,int) /* ??? - unimplemented in MSP3400 */
-#define AUDC_SWITCH_MUTE      _IO('m',16)      /* turn on mute */
-#endif
-
-
 /* misc stuff to pass around config info to i2c chips */
 #define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
 
--- linux-2.5.54/drivers/media/video/msp3400.c	2003-01-08 10:34:37.000000000 +0100
+++ linux/drivers/media/video/msp3400.c	2003-01-08 10:59:59.000000000 +0100
@@ -62,17 +62,7 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned short normal_i2c_range[] = {0x40,0x40,I2C_CLIENT_END};
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
-};
+I2C_CLIENT_INSMOD;
 
 /* insmod parameters */
 static int debug   = 0;    /* debug output */
@@ -145,17 +135,33 @@
 /* ----------------------------------------------------------------------- */
 /* functions for talking to the MSP3400C Sound processor                   */
 
+#ifndef I2C_M_IGNORE_NAK
+# define I2C_M_IGNORE_NAK 0x1000
+#endif
+
 static int msp3400c_reset(struct i2c_client *client)
 {
-        static char reset_off[3] = { 0x00, 0x80, 0x00 };
-        static char reset_on[3]  = { 0x00, 0x00, 0x00 };
-
-        i2c_master_send(client,reset_off,3);  /* XXX ignore errors here */
-        if (3 != i2c_master_send(client,reset_on, 3)) {
-		printk(KERN_ERR "msp3400: chip reset failed, penguin on i2c bus?\n");
-                return -1;
-	}
-        return 0;
+	/* reset and read revision code */
+	static char reset_off[3] = { 0x00, 0x80, 0x00 };
+	static char reset_on[3]  = { 0x00, 0x00, 0x00 };
+	static char write[3]     = { I2C_MSP3400C_DFP + 1, 0x00, 0x1e };
+	char read[2];
+	struct i2c_msg reset[2] = {
+		{ client->addr, I2C_M_IGNORE_NAK, 3, reset_off },
+		{ client->addr, I2C_M_IGNORE_NAK, 3, reset_on  },
+	};
+	struct i2c_msg test[2] = {
+		{ client->addr, 0,        3, write },
+		{ client->addr, I2C_M_RD, 2, read  },
+	};
+	
+	if ( (1 != i2c_transfer(client->adapter,&reset[0],1)) ||
+	     (1 != i2c_transfer(client->adapter,&reset[1],1)) ||
+	     (2 != i2c_transfer(client->adapter,test,2)) ) {
+		printk(KERN_ERR "msp3400: chip reset failed\n");
+		return -1;
+        }
+	return 0; 
 }
 
 static int
@@ -1213,19 +1219,20 @@
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
 static struct i2c_driver driver = {
-	.name		= "i2cmsp3400driver",
-	.id		= I2C_DRIVERID_MSP3400,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= msp_probe,
-	.detach_client	= msp_detach,
-	.command	= msp_command,
+	.owner          = THIS_MODULE,
+        .name           = "i2c msp3400 driver",
+        .id             = I2C_DRIVERID_MSP3400,
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = msp_probe,
+        .detach_client  = msp_detach,
+        .command        = msp_command,
 };
 
 static struct i2c_client client_template = 
 {
-	.name	= "(unset)",
-	.flags	= I2C_CLIENT_ALLOW_USE,
-	.driver	= &driver,
+	.name   = "(unset)",
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
 };
 
 static int msp_attach(struct i2c_adapter *adap, int addr,
@@ -1258,6 +1265,7 @@
 	msp->bass   = 32768;
 	msp->treble = 32768;
 	msp->input  = -1;
+	msp->muted  = 1;
 	for (i = 0; i < DFP_COUNT; i++)
 		msp->dfp_regs[i] = -1;
 
@@ -1283,8 +1291,9 @@
 
 #if 0
 	/* this will turn on a 1kHz beep - might be useful for debugging... */
-	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0014, 0x1040);
+	msp3400c_write(c,I2C_MSP3400C_DFP, 0x0014, 0x1040);
 #endif
+	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
 	sprintf(c->name,"MSP34%02d%c-%c%d",
 		(rev2>>8)&0xff, (rev1&0xff)+'@', ((rev1>>8)&0xff)+'@', rev2&0x1f);
--- linux-2.5.54/drivers/media/video/tda7432.c	2003-01-08 10:34:51.000000000 +0100
+++ linux/drivers/media/video/tda7432.c	2003-01-08 10:59:59.000000000 +0100
@@ -18,8 +18,12 @@
  *
  * loudness - set between 0 and 15 for varying degrees of loudness effect
  *
+ * maxvol   - set maximium volume to +20db (1), default is 0db(0)
  *
  *
+ *  Revision: 0.7 - maxvol module parm to set maximium volume 0db or +20db
+ *  				store if muted so we can return it
+ *  				change balance only if flaged to
  *  Revision: 0.6 - added tone controls
  *  Revision: 0.5 - Fixed odd balance problem
  *  Revision: 0.4 - added muting
@@ -48,12 +52,19 @@
 #include "audiochip.h"
 #include "id.h"
 
+#ifndef VIDEO_AUDIO_BALANCE
+# define VIDEO_AUDIO_BALANCE 32
+#endif
+
 MODULE_AUTHOR("Eric Sandeen <eric_sandeen@bigfoot.com>");
 MODULE_DESCRIPTION("bttv driver for the tda7432 audio processor chip");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(debug,"i");
 MODULE_PARM(loudness,"i");
+MODULE_PARM_DESC(maxvol,"Set maximium volume to +20db (0), default is 0db(1)");
+MODULE_PARM(maxvol,"i");
+static int maxvol = 0;
 static int loudness = 0; /* disable loudness by default */
 static int debug = 0;	 /* insmod parameter */
 
@@ -61,19 +72,10 @@
 /* Address to scan (I2C address of this chip) */
 static unsigned short normal_i2c[] = {
 	I2C_TDA7432 >> 1,
-	I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
+	I2C_CLIENT_END,
 };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END, I2C_CLIENT_END };
+I2C_CLIENT_INSMOD;
 
 /* Structure of address and subaddresses for the tda7432 */
 
@@ -81,12 +83,12 @@
 	int addr;
 	int input;
 	int volume;
+	int muted;
 	int bass, treble;
 	int lf, lr, rf, rr;
 	int loud;
 	struct i2c_client c;
 };
-
 static struct i2c_driver driver;
 static struct i2c_client client_template;
 
@@ -291,9 +293,10 @@
 	t->input  = TDA7432_STEREO_IN |  /* Main (stereo) input   */
 		    TDA7432_BASS_SYM  |  /* Symmetric bass cut    */
 		    TDA7432_BASS_NORM;   /* Normal bass range     */ 
-	t->volume = TDA7432_VOL_0DB;	 /* 0dB Volume            */
+	t->volume =  0x3b ;				 /* -27dB Volume            */
 	if (loudness)			 /* Turn loudness on?     */
 		t->volume |= TDA7432_LD_ON;	
+	t->muted    = VIDEO_AUDIO_MUTE;
 	t->treble   = TDA7432_TREBLE_0DB; /* 0dB Treble            */
 	t->bass		= TDA7432_BASS_0DB; 	 /* 0dB Bass              */
 	t->lf     = TDA7432_ATTEN_0DB;	 /* 0dB attenuation       */
@@ -374,17 +377,24 @@
 
 		va->flags |= VIDEO_AUDIO_VOLUME |
 			VIDEO_AUDIO_BASS |
-			VIDEO_AUDIO_TREBLE;
+			VIDEO_AUDIO_TREBLE |
+			VIDEO_AUDIO_MUTABLE;
+		if (t->muted)
+			va->flags |= VIDEO_AUDIO_MUTE;
 		va->mode |= VIDEO_SOUND_STEREO;
 		/* Master volume control
 		 * V4L volume is min 0, max 65535
 		 * TDA7432 Volume: 
 		 * Min (-79dB) is 0x6f
-		 * Max (+20dB) is 0x07
+		 * Max (+20dB) is 0x07 (630)
+		 * Max (0dB) is 0x20 (829)
 		 * (Mask out bit 7 of vol - it's for the loudness setting)
 		 */
-
-		va->volume = ( 0x6f - (t->volume & 0x7F) ) * 630;
+		if (!maxvol){  /* max +20db */
+			va->volume = ( 0x6f - (t->volume & 0x7F) ) * 630;
+		} else {       /* max 0db   */
+			va->volume = ( 0x6f - (t->volume & 0x7F) ) * 829;
+		}
 		
 		/* Balance depends on L,R attenuation
 		 * V4L balance is 0 to 65535, middle is 32768
@@ -401,15 +411,15 @@
 			/* left is attenuated, balance shifted right */
 			va->balance = (32768 + 1057*(t->lf));
 		
-		/* Bass/treble */	
+		/* Bass/treble 4 bits each */	
 		va->bass=t->bass;
 		if(va->bass >= 0x8)
-				va->bass = ~(va->bass - 0x8) & 0xf;
-		va->bass = va->bass << 12;
+			va->bass = ~(va->bass - 0x8) & 0xf;
+		va->bass = (va->bass << 12)+(va->bass << 8)+(va->bass << 4)+(va->bass);
 		va->treble=t->treble;
 		if(va->treble >= 0x8)
-				va->treble = ~(va->treble - 0x8) & 0xf;
-		va->treble = va->treble << 12;
+			va->treble = ~(va->treble - 0x8) & 0xf;
+		va->treble = (va->treble << 12)+(va->treble << 8)+(va->treble << 4)+(va->treble);
 								
 		break; /* VIDIOCGAUDIO case */
 	}
@@ -420,26 +430,35 @@
 		struct video_audio *va = arg;
 		dprintk("tda7432: VIDEOCSAUDIO\n");
 
-		t->volume = 0x6f - ( (va->volume)/630 );
+		if(va->flags & VIDEO_AUDIO_VOLUME){
+			if(!maxvol){ /* max +20db */
+				t->volume = 0x6f - ((va->volume)/630);
+			} else {    /* max 0db   */
+				t->volume = 0x6f - ((va->volume)/829);
+			}
 		
 		if (loudness)		/* Turn on the loudness bit */
 			t->volume |= TDA7432_LD_ON;
 		
+			tda7432_write(client,TDA7432_VL, t->volume);
+		}
+		
 		if(va->flags & VIDEO_AUDIO_BASS)
 		{
 			t->bass = va->bass >> 12;
 			if(t->bass>= 0x8)
 					t->bass = (~t->bass & 0xf) + 0x8 ;
-			t->bass = t->bass | 0x10;
 		}
 		if(va->flags & VIDEO_AUDIO_TREBLE)
 		{
 			t->treble= va->treble >> 12;
 			if(t->treble>= 0x8)
 					t->treble = (~t->treble & 0xf) + 0x8 ;
-						
 		}
+		if(va->flags & (VIDEO_AUDIO_TREBLE| VIDEO_AUDIO_BASS))
+			tda7432_write(client,TDA7432_TN, 0x10 | (t->bass << 4) | t->treble );
 		
+		if(va->flags & VIDEO_AUDIO_BALANCE)	{
 		if (va->balance < 32768) 
 		{
 			/* shifted to left, attenuate right */
@@ -464,20 +483,17 @@
 			t->lf = TDA7432_ATTEN_0DB;
 			t->lr = TDA7432_ATTEN_0DB;
 		}
+		}
 					
-		tda7432_write(client,TDA7432_TN, (t->bass << 4)| t->treble );		
-		tda7432_write(client,TDA7432_VL, t->volume);
-		
-		if (va->flags & VIDEO_AUDIO_MUTE)
+	 	t->muted=(va->flags & VIDEO_AUDIO_MUTE);	
+		if (t->muted)
 		{
 			/* Mute & update balance*/	
 			tda7432_write(client,TDA7432_LF, t->lf | TDA7432_MUTE);
 			tda7432_write(client,TDA7432_LR, t->lr | TDA7432_MUTE);
 			tda7432_write(client,TDA7432_RF, t->rf | TDA7432_MUTE);
 			tda7432_write(client,TDA7432_RR, t->rr | TDA7432_MUTE);
-		}
-		else
-		{	
+		} else {
 			tda7432_write(client,TDA7432_LF, t->lf);
 			tda7432_write(client,TDA7432_LR, t->lr);
 			tda7432_write(client,TDA7432_RF, t->rf);
@@ -498,35 +514,29 @@
 	return 0;
 }
 
-
 static struct i2c_driver driver = {
-        "i2c tda7432 driver",
-	I2C_DRIVERID_TDA7432,
-        I2C_DF_NOTIFY,
-	tda7432_probe,
-        tda7432_detach,
-        tda7432_command,
+	.owner           = THIS_MODULE,
+        .name            = "i2c tda7432 driver",
+	.id              = I2C_DRIVERID_TDA7432,
+        .flags           = I2C_DF_NOTIFY,
+	.attach_adapter  = tda7432_probe,
+        .detach_client   = tda7432_detach,
+        .command         = tda7432_command,
 };
 
 static struct i2c_client client_template =
 {
-        "(unset)",		/* name */
-        -1,
-        0,
-        0,
-        NULL,
-        &driver
+        .name   = "tda7432",
+        .id     = -1,
+	.driver = &driver, 
 };
 
 static int tda7432_init(void)
 {
-
-	if ( (loudness < 0) || (loudness > 15) )
-	{
+	if ( (loudness < 0) || (loudness > 15) ) {
 		printk(KERN_ERR "tda7432: loudness parameter must be between 0 and 15\n");
 		return -EINVAL;
 	}
-
 	i2c_add_driver(&driver);
 	return 0;
 }
--- linux-2.5.54/drivers/media/video/tda9875.c	2003-01-08 10:34:24.000000000 +0100
+++ linux/drivers/media/video/tda9875.c	2003-01-08 10:59:59.000000000 +0100
@@ -42,19 +42,10 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] =  {
     I2C_TDA9875 >> 1,
-    I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
+    I2C_CLIENT_END
 };
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
+I2C_CLIENT_INSMOD;
 
 /* This is a superset of the TDA9875 */
 struct tda9875 {
@@ -64,7 +55,6 @@
 	struct i2c_client c;
 };
 
-
 static struct i2c_driver driver;
 static struct i2c_client client_template;
 
@@ -397,22 +387,20 @@
 
 
 static struct i2c_driver driver = {
-        "i2c tda9875 driver",
-        I2C_DRIVERID_TDA9875, /* Get new one for TDA9875 */
-        I2C_DF_NOTIFY,
-	tda9875_probe,
-        tda9875_detach,
-        tda9875_command,
+	.owner          = THIS_MODULE,
+        .name           = "i2c tda9875 driver",
+        .id             = I2C_DRIVERID_TDA9875,
+        .flags          = I2C_DF_NOTIFY,
+	.attach_adapter = tda9875_probe,
+        .detach_client  = tda9875_detach,
+        .command        = tda9875_command,
 };
 
 static struct i2c_client client_template =
 {
-        "(unset)",		/* name */
-        -1,
-        0,
-        0,
-        NULL,
-        &driver
+        .name    = "tda9875",
+        .id      = -1,
+        .driver  = &driver,
 };
 
 static int tda9875_init(void)
--- linux-2.5.54/drivers/media/video/tda9887.c	2003-01-08 10:59:58.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2003-01-08 10:59:59.000000000 +0100
@@ -26,17 +26,7 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned short normal_i2c_range[] = {0x86>>1,0x86>>1,I2C_CLIENT_END};
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
-};
+I2C_CLIENT_INSMOD;
 
 /* insmod options */
 static int debug =  0;
@@ -145,8 +135,8 @@
 	u8   bOutPort2    = cOutputPort2Inactive;
 #endif
 	u8   bVideoTrap   = cVideoTrapBypassOFF;
-#if 0
-	u8   bTopAdjust   = mbAGC;
+#if 1
+	u8   bTopAdjust   = 0x0e /* -2dB */;
 #else
 	u8   bTopAdjust   = 0;
 #endif
@@ -456,18 +446,19 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-        name:           "i2c tda9887 driver",
-        id:             -1, /* FIXME */
-        flags:          I2C_DF_NOTIFY,
-        attach_adapter: tda9887_probe,
-        detach_client:  tda9887_detach,
-        command:        tda9887_command,
+	.owner          = THIS_MODULE,
+        .name           = "i2c tda9887 driver",
+        .id             = -1, /* FIXME */
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = tda9887_probe,
+        .detach_client  = tda9887_detach,
+        .command        = tda9887_command,
 };
 static struct i2c_client client_template =
 {
-        name:   "tda9887",
-	flags:  I2C_CLIENT_ALLOW_USE,
-        driver: &driver,
+        .name   = "tda9887",
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
 };
 
 static int tda9887_init_module(void)
--- linux-2.5.54/drivers/media/video/tvaudio.c	2003-01-08 10:34:09.000000000 +0100
+++ linux/drivers/media/video/tvaudio.c	2003-01-08 10:59:59.000000000 +0100
@@ -146,17 +146,7 @@
 	I2C_PIC16C54  >> 1,
 	I2C_CLIENT_END };
 static unsigned short normal_i2c_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe[2]            = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]      = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]           = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2]     = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]            = { I2C_CLIENT_END, I2C_CLIENT_END };
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
-};
+I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
 static struct i2c_client client_template;
@@ -1088,6 +1078,19 @@
 static int tda8425_shift10(int val) { return (val >> 10) | 0xc0; }
 static int tda8425_shift12(int val) { return (val >> 12) | 0xf0; }
 
+static int tda8425_initialize(struct CHIPSTATE *chip)
+{
+	struct CHIPDESC *desc = chiplist + chip->type;
+	int inputmap[8] = { /* tuner	*/ TDA8425_S1_CH2, /* radio  */ TDA8425_S1_CH1,
+			    /* extern	*/ TDA8425_S1_CH1, /* intern */ TDA8425_S1_OFF,
+			    /* off	*/ TDA8425_S1_OFF, /* on     */ TDA8425_S1_CH2};
+
+	if (chip->c.adapter->id == (I2C_ALGO_BIT | I2C_HW_B_RIVA)) {
+		memcpy (desc->inputmap, inputmap, sizeof (inputmap));
+	}
+	return 0;
+}
+
 static void tda8425_setmode(struct CHIPSTATE *chip, int mode)
 {
 	int s1 = chip->shadow.bytes[TDA8425_S1+1] & 0xe1;
@@ -1188,7 +1191,7 @@
 		.inputreg   = TDA9873_SW,
 		.inputmute  = TDA9873_MUTE | TDA9873_AUTOMUTE,
 		.inputmap   = {0xa0, 0xa2, 0xa0, 0xa0, 0xc0},
-		.inputmask  = TDA9873_INP_MASK | TDA9873_MUTE | TDA9873_AUTOMUTE
+		.inputmask  = TDA9873_INP_MASK|TDA9873_MUTE|TDA9873_AUTOMUTE,
 		
 	},
 	{
@@ -1285,8 +1288,8 @@
 		.registers  = 9,
 		.flags      = CHIP_HAS_VOLUME | CHIP_HAS_BASSTREBLE | CHIP_HAS_INPUTSEL,
 
-		.leftreg    = TDA8425_VR,
-		.rightreg   = TDA8425_VL,
+		.leftreg    = TDA8425_VL,
+		.rightreg   = TDA8425_VR,
 		.bassreg    = TDA8425_BA,
 		.treblereg  = TDA8425_TR,
 		.volfunc    = tda8425_shift10,
@@ -1298,6 +1301,7 @@
 		.inputmute  = TDA8425_S1_OFF,
 
 		.setmode    = tda8425_setmode,
+		.initialize = tda8425_initialize,
 	},
 	{
 		.name       = "pic16c54 (PV951)",
@@ -1316,7 +1320,7 @@
 			     PIC16C54_MISC_SND_NOTMUTE},
 		.inputmute  = PIC16C54_MISC_SND_MUTE,
 	},
-	{ .name = NULL } /* EOF */
+	{ name: NULL } /* EOF */
 };
 
 
@@ -1544,19 +1548,20 @@
 
 
 static struct i2c_driver driver = {
-	.name		= "generic i2c audio driver",
-	.id		= I2C_DRIVERID_TVAUDIO,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= chip_probe,
-	.detach_client	= chip_detach,
-	.command	= chip_command,
+	.owner           = THIS_MODULE,
+        .name            = "generic i2c audio driver",
+        .id              = I2C_DRIVERID_TVAUDIO,
+        .flags           = I2C_DF_NOTIFY,
+        .attach_adapter  = chip_probe,
+        .detach_client   = chip_detach,
+        .command         = chip_command,
 };
 
 static struct i2c_client client_template =
 {
-	.name		= "(unset)",
-	.flags		= I2C_CLIENT_ALLOW_USE,
-	.driver		= &driver,
+        .name   = "(unset)",
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
 };
 
 static int audiochip_init_module(void)
--- linux-2.5.54/drivers/media/video/tvmixer.c	2003-01-08 10:35:01.000000000 +0100
+++ linux/drivers/media/video/tvmixer.c	2003-01-08 10:59:59.000000000 +0100
@@ -195,9 +195,8 @@
 
 	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
-
-	if (!try_module_get(client->adapter->owner))
-		return -ENODEV;
+	if (client->adapter->owner)
+		try_module_get(client->adapter->owner);
         return 0;
 }
 
@@ -211,25 +210,26 @@
 		return -ENODEV;
 	}
 
-	module_put(client->adapter->owner);
+	if (client->adapter->owner)
+		module_put(client->adapter->owner);
 	return 0;
 }
 
-
 static struct i2c_driver driver = {
-	.name		= "tv card mixer driver",
-	.id		= I2C_DRIVERID_TVMIXER,
-	.flags		= I2C_DF_DUMMY,
-	.attach_adapter	= tvmixer_adapters,
-	.detach_client	= tvmixer_clients,
+	.owner           = THIS_MODULE,
+	.name            = "tv card mixer driver",
+        .id              = I2C_DRIVERID_TVMIXER,
+	.flags           = I2C_DF_DUMMY,
+        .attach_adapter  = tvmixer_adapters,
+        .detach_client   = tvmixer_clients,
 };
 
 static struct file_operations tvmixer_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.ioctl		= tvmixer_ioctl,
-	.open		= tvmixer_open,
-	.release	= tvmixer_release,
+	.llseek         = no_llseek,
+	.ioctl          = tvmixer_ioctl,
+	.open           = tvmixer_open,
+	.release        = tvmixer_release,
 };
 
 /* ----------------------------------------------------------------------- */

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"

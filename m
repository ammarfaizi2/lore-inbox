Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSJaP1z>; Thu, 31 Oct 2002 10:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSJaP0k>; Thu, 31 Oct 2002 10:26:40 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:39076 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262590AbSJaPYV>; Thu, 31 Oct 2002 10:24:21 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 31 Oct 2002 17:29:52 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] update i2c chip drivers
Message-ID: <20021031162952.GA17481@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

This patch updates the i2c helper modules needed by various tv cards.
Most important is the new tda9887.o module.  There are also small fixes
in tvaudio.c and tda7432.c.

  Gerd

--- linux-2.5.45/drivers/media/video/Makefile	2002-10-31 14:20:27.000000000 +0100
+++ linux/drivers/media/video/Makefile	2002-10-31 14:20:28.000000000 +0100
@@ -15,7 +15,7 @@
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
-	tda7432.o tda9875.o tuner.o video-buf.o
+	tda7432.o tda9875.o tuner.o video-buf.o tda9887.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
--- linux-2.5.45/drivers/media/video/audiochip.h	2002-10-31 14:03:11.000000000 +0100
+++ linux/drivers/media/video/audiochip.h	2002-10-31 14:20:28.000000000 +0100
@@ -30,41 +30,7 @@
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
+/* misc stuff to pass around config info to i2c chips */
+#define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
 
 #endif /* AUDIOCHIP_H */
--- linux-2.5.45/drivers/media/video/tda7432.c	2002-10-31 14:04:38.000000000 +0100
+++ linux/drivers/media/video/tda7432.c	2002-10-31 14:20:28.000000000 +0100
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
 
@@ -81,12 +92,12 @@
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
 
@@ -291,9 +302,10 @@
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
@@ -374,17 +386,24 @@
 
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
@@ -401,15 +420,15 @@
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
@@ -420,26 +439,36 @@
 		struct video_audio *va = arg;
 		dprintk("tda7432: VIDEOCSAUDIO\n");
 
-		t->volume = 0x6f - ( (va->volume)/630 );
+		if(va->flags & VIDEO_AUDIO_VOLUME){
+				
+			if(!maxvol){ /* max +20db */
+				t->volume = 0x6f - ( (va->volume)/630 );
+			} else {    /* max 0db   */
+				t->volume = 0x6f - ((int) (va->volume)/829.557 );
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
@@ -464,20 +493,17 @@
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
--- linux-2.5.45/drivers/media/video/tda9887.c	2002-10-31 14:20:28.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2002-10-31 14:20:28.000000000 +0100
@@ -0,0 +1,493 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/types.h>
+#include <linux/videodev.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+
+#include "id.h"
+#include "audiochip.h"
+
+/* Chips:
+   TDA9885 (PAL, NTSC)
+   TDA9886 (PAL, SECAM, NTSC)
+   TDA9887 (PAL, SECAM, NTSC, FM Radio)
+
+   found on:
+   - Pinnacle PCTV (Jul.2002 Version with MT2032, bttv)
+      TDA9887 (world), TDA9885 (USA)
+      Note: OP2 of tda988x must be set to 1, else MT2032 is disabled!
+   - KNC One TV-Station RDS (saa7134)
+*/
+    
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {I2C_CLIENT_END};
+static unsigned short normal_i2c_range[] = {0x86>>1,0x86>>1,I2C_CLIENT_END};
+static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
+static struct i2c_client_address_data addr_data = {
+	normal_i2c, normal_i2c_range, 
+	probe, probe_range, 
+	ignore, ignore_range, 
+	force
+};
+
+/* insmod options */
+static int debug =  0;
+static char *pal =  "b";
+static char *secam =  "l";
+MODULE_PARM(debug,"i");
+MODULE_PARM(pal,"s");
+MODULE_PARM(secam,"s");
+MODULE_LICENSE("GPL");
+
+/* ---------------------------------------------------------------------- */
+
+#define dprintk     if (debug) printk
+
+struct tda9887 {
+	struct i2c_client client;
+	int radio,tvnorm;
+	int pinnacle_id;
+};
+
+static struct i2c_driver driver;
+static struct i2c_client client_template;
+
+/* ---------------------------------------------------------------------- */
+
+//
+// TDA defines
+//
+
+//// first reg
+#define cVideoTrapBypassOFF     0x00    // bit b0
+#define cVideoTrapBypassON      0x01    // bit b0
+
+#define cAutoMuteFmInactive     0x00    // bit b1
+#define cAutoMuteFmActive       0x02    // bit b1
+
+#define cIntercarrier           0x00    // bit b2
+#define cQSS                    0x04    // bit b2
+
+#define cPositiveAmTV           0x00    // bit b3:4
+#define cFmRadio                0x08    // bit b3:4
+#define cNegativeFmTV           0x10    // bit b3:4
+
+
+#define cForcedMuteAudioON      0x20    // bit b5
+#define cForcedMuteAudioOFF     0x00    // bit b5
+
+#define cOutputPort1Active      0x00    // bit b6
+#define cOutputPort1Inactive    0x40    // bit b6
+
+#define cOutputPort2Active      0x00    // bit b7
+#define cOutputPort2Inactive    0x80    // bit b7
+
+
+//// second reg
+#define cDeemphasisOFF          0x00    // bit c5
+#define cDeemphasisON           0x20    // bit c5
+
+#define cDeemphasis75           0x00    // bit c6
+#define cDeemphasis50           0x40    // bit c6
+
+#define cAudioGain0             0x00    // bit c7
+#define cAudioGain6             0x80    // bit c7
+
+
+//// third reg
+#define cAudioIF_4_5             0x00    // bit e0:1
+#define cAudioIF_5_5             0x01    // bit e0:1
+#define cAudioIF_6_0             0x02    // bit e0:1
+#define cAudioIF_6_5             0x03    // bit e0:1
+
+
+#define cVideoIF_58_75           0x00    // bit e2:4
+#define cVideoIF_45_75           0x04    // bit e2:4
+#define cVideoIF_38_90           0x08    // bit e2:4
+#define cVideoIF_38_00           0x0C    // bit e2:4
+#define cVideoIF_33_90           0x10    // bit e2:4
+#define cVideoIF_33_40           0x14    // bit e2:4
+#define cRadioIF_45_75           0x18    // bit e2:4
+#define cRadioIF_38_90           0x1C    // bit e2:4
+
+
+#define cTunerGainNormal         0x00    // bit e5
+#define cTunerGainLow            0x20    // bit e5
+
+#define cGating_18               0x00    // bit e6
+#define cGating_36               0x40    // bit e6
+
+#define cAgcOutON                0x80    // bit e7
+#define cAgcOutOFF               0x00    // bit e7
+
+static int tda9887_miro(struct tda9887 *t)
+{
+	int rc;
+	u8   bData[4]     = { 0 };
+	u8   bVideoIF     = 0;
+	u8   bAudioIF     = 0;
+	u8   bDeEmphasis  = 0;
+	u8   bDeEmphVal   = 0;
+	u8   bModulation  = 0;
+	u8   bCarrierMode = 0;
+	u8   bOutPort1    = cOutputPort1Inactive;
+#if 0
+	u8   bOutPort2    = cOutputPort2Inactive & mbTADState; // store i2c tuner state
+#else
+	u8   bOutPort2    = cOutputPort2Inactive;
+#endif
+	u8   bVideoTrap   = cVideoTrapBypassOFF;
+#if 0
+	u8   bTopAdjust   = mbAGC;
+#else
+	u8   bTopAdjust   = 0;
+#endif
+
+#if 0
+	if (mParams.fVideoTrap)
+		bVideoTrap   = cVideoTrapBypassON;
+#endif
+
+	if (t->radio) {
+		bVideoTrap   = cVideoTrapBypassOFF;
+		bCarrierMode = cQSS;
+		bModulation  = cFmRadio;
+		bOutPort1    = cOutputPort1Inactive;
+		bDeEmphasis  = cDeemphasisON;
+		if (3 == t->pinnacle_id) {
+			/* ntsc */
+			bDeEmphVal   = cDeemphasis75;
+			bAudioIF     = cAudioIF_4_5;
+			bVideoIF     = cRadioIF_45_75;
+		} else {
+			/* pal */
+			bAudioIF     = cAudioIF_5_5;
+			bVideoIF     = cRadioIF_38_90;
+			bDeEmphVal   = cDeemphasis50;
+		}
+
+	} else if (t->tvnorm == VIDEO_MODE_PAL) {
+		bDeEmphasis  = cDeemphasisON;
+		bDeEmphVal   = cDeemphasis50;
+		bModulation  = cNegativeFmTV;
+		bOutPort1    = cOutputPort1Inactive;
+		if (1 == t->pinnacle_id) {
+			bCarrierMode = cIntercarrier;
+		} else {
+			// stereo boards
+			bCarrierMode = cQSS;
+		}
+		switch (pal[0]) {
+		case 'b':
+		case 'g':
+		case 'h':
+			bVideoIF     = cVideoIF_38_90;
+			bAudioIF     = cAudioIF_5_5;
+			break;
+		case 'd':
+			bVideoIF     = cVideoIF_38_00;
+			bAudioIF     = cAudioIF_6_5;
+			break;
+		case 'i':
+			bVideoIF     = cVideoIF_38_90;
+			bAudioIF     = cAudioIF_6_0;
+			break;
+		case 'm':
+		case 'n':
+			bVideoIF     = cVideoIF_45_75;
+			bAudioIF     = cAudioIF_4_5;
+			bDeEmphVal   = cDeemphasis75;
+			if ((5 == t->pinnacle_id) || (6 == t->pinnacle_id)) {
+				bCarrierMode = cIntercarrier;
+			} else {
+				bCarrierMode = cQSS;
+			}
+			break;
+		}
+
+	} else if (t->tvnorm == VIDEO_MODE_SECAM) {
+		bAudioIF     = cAudioIF_6_5;
+		bDeEmphasis  = cDeemphasisON;
+		bDeEmphVal   = cDeemphasis50;
+		bModulation  = cNegativeFmTV;
+		bCarrierMode = cQSS;
+		bOutPort1    = cOutputPort1Inactive;                
+		switch (secam[0]) {
+		case 'd':
+			bVideoIF     = cVideoIF_38_00;
+			break;
+		case 'k':
+			bVideoIF     = cVideoIF_38_90;
+			break;
+		case 'l':
+			bVideoIF     = cVideoIF_38_90;
+			bDeEmphasis  = cDeemphasisOFF;
+			bDeEmphVal   = cDeemphasis75;
+			bModulation  = cPositiveAmTV;
+			break;
+		case 'L' /* L1 */:
+			bVideoIF     = cVideoIF_33_90;
+			bDeEmphasis  = cDeemphasisOFF;
+			bDeEmphVal   = cDeemphasis75;
+			bModulation  = cPositiveAmTV;
+			break;
+		}
+
+	} else if (t->tvnorm == VIDEO_MODE_NTSC) {
+                bVideoIF     = cVideoIF_45_75;
+                bAudioIF     = cAudioIF_4_5;
+                bDeEmphasis  = cDeemphasisON;
+                bDeEmphVal   = cDeemphasis75;
+                bModulation  = cNegativeFmTV;                
+                bOutPort1    = cOutputPort1Inactive;
+                if ((5 == t->pinnacle_id) || (6 == t->pinnacle_id)) {
+			bCarrierMode = cIntercarrier;
+		} else {
+			bCarrierMode = cQSS;
+                }
+	}
+
+	bData[1] = bVideoTrap        |  // B0: video trap bypass
+		cAutoMuteFmInactive  |  // B1: auto mute
+		bCarrierMode         |  // B2: InterCarrier for PAL else QSS 
+		bModulation          |  // B3 - B4: positive AM TV for SECAM only
+		cForcedMuteAudioOFF  |  // B5: forced Audio Mute (off)
+		bOutPort1            |  // B6: Out Port 1 
+		bOutPort2;              // B7: Out Port 2 
+	bData[2] = bTopAdjust |   // C0 - C4: Top Adjust 0 == -16dB  31 == 15dB
+		bDeEmphasis   |   // C5: De-emphasis on/off
+		bDeEmphVal    |   // C6: De-emphasis 50/75 microsec
+		cAudioGain0;      // C7: normal audio gain
+	bData[3] = bAudioIF      |  // E0 - E1: Sound IF
+		bVideoIF         |  // E2 - E4: Video IF
+		cTunerGainNormal |  // E5: Tuner gain (normal)
+		cGating_18       |  // E6: Gating (18%)
+		cAgcOutOFF;         // E7: VAGC  (off)
+	
+	dprintk("tda9885/6/7: 0x%02x 0x%02x 0x%02x [pinnacle_id=%d]\n",
+		bData[1],bData[2],bData[3],t->pinnacle_id);
+	if (4 != (rc = i2c_master_send(&t->client,bData,4)))
+		printk("tda9885/6/7: i2c i/o error: rc == %d (should be 4)\n",rc);
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+#if 0
+/* just for reference: old knc-one saa7134 stuff */
+static unsigned char buf_pal_bg[]    = { 0x00, 0x16, 0x70, 0x49 };
+static unsigned char buf_pal_i[]     = { 0x00, 0x16, 0x70, 0x4a };
+static unsigned char buf_pal_dk[]    = { 0x00, 0x16, 0x70, 0x4b };
+static unsigned char buf_pal_l[]     = { 0x00, 0x06, 0x50, 0x4b };
+static unsigned char buf_fm_stereo[] = { 0x00, 0x0e, 0x0d, 0x77 };
+#endif
+
+static unsigned char buf_pal_bg[]    = { 0x00, 0x96, 0x70, 0x49 };
+static unsigned char buf_pal_i[]     = { 0x00, 0x96, 0x70, 0x4a };
+static unsigned char buf_pal_dk[]    = { 0x00, 0x96, 0x70, 0x4b };
+static unsigned char buf_pal_l[]     = { 0x00, 0x86, 0x50, 0x4b };
+static unsigned char buf_fm_stereo[] = { 0x00, 0x8e, 0x0d, 0x77 };
+static unsigned char buf_ntsc[]	     = { 0x00, 0x96, 0x70, 0x44 };
+static unsigned char buf_ntsc_jp[]   = { 0x00, 0x96, 0x70, 0x40 };
+
+static int tda9887_configure(struct tda9887 *t)
+{
+	unsigned char *buf = NULL;
+	int rc;
+
+	printk("tda9887_configure\n");
+
+	if (t->radio) {
+		dprintk("tda9885/6/7: FM Radio mode\n");
+		buf = buf_fm_stereo;
+
+	} else if (t->tvnorm == VIDEO_MODE_PAL) {
+		dprintk("tda9885/6/7: PAL-%c mode\n",pal[0]);
+		switch (pal[0]) {
+		case 'b':
+		case 'g':
+			buf = buf_pal_bg;
+			break;
+		case 'i':
+			buf = buf_pal_i;
+			break;
+		case 'd':
+		case 'k':
+			buf = buf_pal_dk;
+			break;
+		case 'l':
+			buf = buf_pal_l;
+			break;
+		}
+
+	} else if (t->tvnorm == VIDEO_MODE_NTSC) {
+		dprintk("tda9885/6/7: NTSC mode\n");
+		buf = buf_ntsc;
+
+	} else if (t->tvnorm == VIDEO_MODE_SECAM) {
+		dprintk("tda9885/6/7: SECAM mode\n");
+                buf = buf_pal_l;
+
+        } else if (t->tvnorm == 6 /* BTTV hack */) {
+		dprintk("tda9885/6/7: NTSC-Japan mode\n");
+                buf = buf_ntsc_jp;
+        }
+
+	if (NULL == buf) {
+		printk("tda9885/6/7 unknown norm=%d\n",t->tvnorm);
+		return 0;
+	}
+
+	dprintk("tda9885/6/7: 0x%02x 0x%02x 0x%02x\n",
+		buf[1],buf[2],buf[3]);
+        if (4 != (rc = i2c_master_send(&t->client,buf,4)))
+                printk("tda9885/6/7: i2c i/o error: rc == %d (should be 4)\n",rc);
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+static int tda9887_attach(struct i2c_adapter *adap, int addr,
+			  unsigned short flags, int kind)
+{
+	struct tda9887 *t;
+
+        client_template.adapter = adap;
+        client_template.addr    = addr;
+
+        printk("tda9887: chip found @ 0x%x\n", addr<<1);
+
+        if (NULL == (t = kmalloc(sizeof(*t), GFP_KERNEL)))
+                return -ENOMEM;
+	memset(t,0,sizeof(*t));
+	t->client = client_template;
+        t->client.data = t;
+	t->pinnacle_id = -1;
+        i2c_attach_client(&t->client);
+        
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static int tda9887_probe(struct i2c_adapter *adap)
+{
+	int rc;
+
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_ALGO_SAA7134:
+		printk("tda9887: probing %s i2c adapter [id=0x%x]\n",
+		       adap->name,adap->id);
+		rc = i2c_probe(adap, &addr_data, tda9887_attach);
+		break;
+	default:
+		printk("tda9887: ignoring %s i2c adapter [id=0x%x]\n",
+		       adap->name,adap->id);
+		rc = 0;
+		/* nothing */
+	}
+	return rc;
+}
+
+static int tda9887_detach(struct i2c_client *client)
+{
+	struct tda9887 *t = (struct tda9887*)client->data;
+
+	i2c_detach_client(client);
+	kfree(t);
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static int
+tda9887_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct tda9887 *t = (struct tda9887*)client->data;
+
+        switch (cmd) {
+
+	/* --- configuration --- */
+	case AUDC_SET_RADIO:
+		t->radio = 1;
+		if (-1 != t->pinnacle_id)
+			tda9887_miro(t);
+		else
+			tda9887_configure(t);
+		break;
+		
+	case AUDC_CONFIG_PINNACLE:
+	{
+		int *i = arg;
+
+		t->pinnacle_id = *i;
+		break;
+	}
+	/* --- v4l ioctls --- */
+	/* take care: bttv does userspace copying, we'll get a
+	   kernel pointer here... */
+	case VIDIOCSCHAN:
+	{
+		struct video_channel *vc = arg;
+
+		t->radio  = 0;
+		t->tvnorm = vc->norm;
+		if (-1 != t->pinnacle_id)
+			tda9887_miro(t);
+		else
+			tda9887_configure(t);
+		break;
+	}
+	default:
+		/* nothing */
+		break;
+	}
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+static struct i2c_driver driver = {
+        name:           "i2c tda9887 driver",
+        id:             -1, /* FIXME */
+        flags:          I2C_DF_NOTIFY,
+        attach_adapter: tda9887_probe,
+        detach_client:  tda9887_detach,
+        command:        tda9887_command,
+};
+static struct i2c_client client_template =
+{
+        name:   "tda9887",
+	flags:  I2C_CLIENT_ALLOW_USE,
+        driver: &driver,
+};
+
+static int tda9887_init_module(void)
+{
+	i2c_add_driver(&driver);
+	return 0;
+}
+
+static void tda9887_cleanup_module(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init(tda9887_init_module);
+module_exit(tda9887_cleanup_module);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- linux-2.5.45/drivers/media/video/tvaudio.c	2002-10-31 14:03:21.000000000 +0100
+++ linux/drivers/media/video/tvaudio.c	2002-10-31 14:20:28.000000000 +0100
@@ -1088,6 +1088,19 @@
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
@@ -1285,8 +1298,8 @@
 		registers:  9,
 		flags:      CHIP_HAS_VOLUME | CHIP_HAS_BASSTREBLE | CHIP_HAS_INPUTSEL,
 
-		leftreg:    TDA8425_VR,
-		rightreg:   TDA8425_VL,
+		leftreg:    TDA8425_VL,
+		rightreg:   TDA8425_VR,
 		bassreg:    TDA8425_BA,
 		treblereg:  TDA8425_TR,
 		volfunc:    tda8425_shift10,
@@ -1298,6 +1311,7 @@
 		inputmute:  TDA8425_S1_OFF,
 
 		setmode:    tda8425_setmode,
+		initialize: tda8425_initialize,
 	},
 	{
 		name:       "pic16c54 (PV951)",
--- linux-2.5.45/drivers/media/video/tvmixer.c	2002-10-31 14:04:57.000000000 +0100
+++ linux/drivers/media/video/tvmixer.c	2002-10-31 14:20:28.000000000 +0100
@@ -215,7 +215,6 @@
 	return 0;
 }
 
-
 static struct i2c_driver driver = {
 	name:            "tv card mixer driver",
         id:              I2C_DRIVERID_TVMIXER,

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20

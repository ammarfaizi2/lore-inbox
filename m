Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265085AbUFRKBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbUFRKBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUFRKBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:01:20 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:7618 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265085AbUFRKAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:00:11 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:40:47 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner + tda9887 updates
Message-ID: <20040618094047.GA24147@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a big update for the tuner and tda9887 modules which are used
for TV card tuning.

The tda9887 module is basically completely rewritten and understands all
the config bits now instead of having just some fixed config presets.
Some of these config bits can be changed by insmod options now.

The other big change is that both modules allow to use the V4L2 API for
inter-module communication (i.e. when bttv/saa7134/... pass through the
tuning ioctls to the modules).  That allows to specify the TV norm more
precisely (not just PAL but PAL-I, PAL-BG, ...), which is needed in some
cases to make TV audio work correctly.  Using the old v4l1 API is still
possible so this shouldn't break any users of these two modules.

  Gerd

diff -up linux-2.6.7/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.7/drivers/media/video/tda9887.c	2004-06-17 10:27:30.000000000 +0200
+++ linux/drivers/media/video/tda9887.c	2004-06-17 13:47:59.269369508 +0200
@@ -21,7 +21,7 @@
       Note: OP2 of tda988x must be set to 1, else MT2032 is disabled!
    - KNC One TV-Station RDS (saa7134)
 */
-    
+
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {
@@ -33,22 +33,30 @@ static unsigned short normal_i2c_range[]
 I2C_CLIENT_INSMOD;
 
 /* insmod options */
-static int debug =  0;
-static char *pal =  "b";
-static char *secam =  "l";
+static unsigned int debug = 0;
 MODULE_PARM(debug,"i");
-MODULE_PARM(pal,"s");
-MODULE_PARM(secam,"s");
 MODULE_LICENSE("GPL");
 
 /* ---------------------------------------------------------------------- */
 
+#define UNSET       (-1U)
+#define PREFIX      "tda9885/6/7: "
 #define dprintk     if (debug) printk
 
 struct tda9887 {
-	struct i2c_client client;
-	int radio,tvnorm;
-	int pinnacle_id;
+	struct i2c_client  client;
+	v4l2_std_id        std;
+	unsigned int       radio;
+	unsigned int       pinnacle_id;
+	unsigned int       using_v4l2;
+};
+
+struct tvnorm {
+	v4l2_std_id       std;
+	char              *name;
+	unsigned char     b;
+	unsigned char     c;
+	unsigned char     e;
 };
 
 static struct i2c_driver driver;
@@ -60,7 +68,7 @@ static struct i2c_client client_template
 // TDA defines
 //
 
-//// first reg
+//// first reg (b)
 #define cVideoTrapBypassOFF     0x00    // bit b0
 #define cVideoTrapBypassON      0x01    // bit b0
 
@@ -85,7 +93,7 @@ static struct i2c_client client_template
 #define cOutputPort2Inactive    0x80    // bit b7
 
 
-//// second reg
+//// second reg (c)
 #define cDeemphasisOFF          0x00    // bit c5
 #define cDeemphasisON           0x20    // bit c5
 
@@ -96,7 +104,7 @@ static struct i2c_client client_template
 #define cAudioGain6             0x80    // bit c7
 
 
-//// third reg
+//// third reg (e)
 #define cAudioIF_4_5             0x00    // bit e0:1
 #define cAudioIF_5_5             0x01    // bit e0:1
 #define cAudioIF_6_0             0x02    // bit e0:1
@@ -122,126 +130,287 @@ static struct i2c_client client_template
 #define cAgcOutON                0x80    // bit e7
 #define cAgcOutOFF               0x00    // bit e7
 
-static int tda9887_miro(struct tda9887 *t)
+/* ---------------------------------------------------------------------- */
+
+static struct tvnorm tvnorms[] = {
+	{
+		.std   = V4L2_STD_PAL_BG,
+		.name  = "PAL-BG",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis50  ),
+		.e     = ( cAudioIF_5_5   |
+			   cVideoIF_38_90 ),
+	},{
+		.std   = V4L2_STD_PAL_I,
+		.name  = "PAL-I",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis50  ),
+		.e     = ( cAudioIF_6_0   |
+			   cVideoIF_38_90 ),
+	},{
+		.std   = V4L2_STD_PAL_DK,
+		.name  = "PAL-DK",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis50  ),
+		.e     = ( cAudioIF_6_5   |
+			   cVideoIF_38_00 ),
+	},{
+		.std   = V4L2_STD_PAL_M | V4L2_STD_PAL_N,
+		.name  = "PAL-M/N",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis75  ),
+		.e     = ( cAudioIF_4_5   |
+			   cVideoIF_45_75 ),
+	},{
+		.std   = V4L2_STD_SECAM_L,
+		.name  = "SECAM-L",
+		.b     = ( cPositiveAmTV  |
+			   cQSS           ),
+		.e     = ( cAudioIF_6_5   |
+			   cVideoIF_38_90 ),
+	},{
+		.std   = V4L2_STD_SECAM_DK,
+		.name  = "SECAM-DK",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis50  ),
+		.e     = ( cAudioIF_6_5   |
+			   cVideoIF_38_00 ),
+	},{
+		.std   = V4L2_STD_NTSC_M,
+		.name  = "NTSC-M",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis50  ),
+		.e     = ( cGating_36     |
+			   cAudioIF_4_5   |
+			   cVideoIF_45_75 ),
+	},{
+		.std   = V4L2_STD_NTSC_M_JP,
+		.name  = "NTSC-JP",
+		.b     = ( cNegativeFmTV  |
+			   cQSS           ),
+		.c     = ( cDeemphasisON  |
+			   cDeemphasis50  ),
+		.e     = ( cGating_36     |
+			   cAudioIF_4_5   |
+			   cVideoIF_58_75 ),
+	}
+};
+
+static struct tvnorm radio = {
+	.name = "radio",
+	.b    = ( cFmRadio       |
+		  cQSS           ),
+	.c    = ( cDeemphasisON  |
+		  cDeemphasis50  ),
+	.e    = ( cAudioIF_5_5   |
+		  cRadioIF_38_90 ),
+};
+
+/* ---------------------------------------------------------------------- */
+
+static void dump_read_message(unsigned char *buf)
 {
-	int rc;
-	u8   bData[4]     = { 0 };
-	u8   bVideoIF     = 0;
-	u8   bAudioIF     = 0;
-	u8   bDeEmphasis  = 0;
-	u8   bDeEmphVal   = 0;
-	u8   bModulation  = 0;
-	u8   bCarrierMode = 0;
-	u8   bOutPort1    = cOutputPort1Inactive;
-#if 0
-	u8   bOutPort2    = cOutputPort2Inactive & mbTADState; // store i2c tuner state
-#else
-	u8   bOutPort2    = cOutputPort2Inactive;
-#endif
-	u8   bVideoTrap   = cVideoTrapBypassOFF;
-#if 1
-	u8   bTopAdjust   = 0x0e /* -2dB */;
-#else
-	u8   bTopAdjust   = 0;
-#endif
+	static char *afc[16] = {
+		"- 12.5 kHz",
+		"- 37.5 kHz",
+		"- 62.5 kHz",
+		"- 87.5 kHz",
+		"-112.5 kHz",
+		"-137.5 kHz",
+		"-162.5 kHz",
+		"-187.5 kHz [min]",
+		"+187.5 kHz [max]",
+		"+162.5 kHz",
+		"+137.5 kHz",
+		"+112.5 kHz",
+		"+ 87.5 kHz",
+		"+ 62.5 kHz",
+		"+ 37.5 kHz",
+		"+ 12.5 kHz",
+	};
+	printk(PREFIX "read: 0x%2x\n", buf[0]);
+	printk("  after power on : %s\n", (buf[0] & 0x01) ? "yes" : "no");
+	printk("  afc            : %s\n", afc[(buf[0] >> 1) & 0x0f]);
+	printk("  afc window     : %s\n", (buf[0] & 0x40) ? "in" : "out");
+	printk("  vfi level      : %s\n", (buf[0] & 0x80) ? "high" : "low");
+}
 
-#if 0
-	if (mParams.fVideoTrap)
-		bVideoTrap   = cVideoTrapBypassON;
-#endif
+static void dump_write_message(unsigned char *buf)
+{
+	static char *sound[4] = {
+		"AM/TV",
+		"FM/radio",
+		"FM/TV",
+		"FM/radio"
+	};
+	static char *adjust[32] = {
+		"-16", "-15", "-14", "-13", "-12", "-11", "-10", "-9",
+		"-8",  "-7",  "-6",  "-5",  "-4",  "-3",  "-2",  "-1",
+		"0",   "+1",  "+2",  "+3",  "+4",  "+5",  "+6",  "+7",
+		"+8",  "+9",  "+10", "+11", "+12", "+13", "+14", "+15"
+	};
+	static char *deemph[4] = {
+		"no", "no", "75", "50"
+	};
+	static char *carrier[4] = {
+		"4.5 MHz",
+		"5.5 MHz",
+		"6.0 MHz",
+		"6.5 MHz / AM"
+	};
+	static char *vif[8] = {
+		"58.75 MHz",
+		"45.75 MHz",
+		"38.9 MHz",
+		"38.0 MHz",
+		"33.9 MHz",
+		"33.4 MHz",
+		"45.75 MHz + pin13",
+		"38.9 MHz + pin13",
+	};
+	static char *rif[4] = {
+		"44 MHz",
+		"52 MHz",
+		"52 MHz",
+		"44 MHz",
+	};
+
+	printk(PREFIX "write: byte B 0x%02x\n",buf[1]);
+	printk("  B0   video mode      : %s\n",
+	       (buf[1] & 0x01) ? "video trap" : "sound trap");
+	printk("  B1   auto mute fm    : %s\n",
+	       (buf[1] & 0x02) ? "yes" : "no");
+	printk("  B2   carrier mode    : %s\n",
+	       (buf[1] & 0x04) ? "QSS" : "Intercarrier");
+	printk("  B3-4 tv sound/radio  : %s\n",
+	       sound[(buf[1] & 0x18) >> 3]);
+	printk("  B5   force mute audio: %s\n",
+	       (buf[1] & 0x20) ? "yes" : "no");
+	printk("  B6   output port 1   : %s\n",
+	       (buf[1] & 0x40) ? "high" : "low");
+	printk("  B7   output port 2   : %s\n",
+	       (buf[1] & 0x80) ? "high" : "low");
+
+	printk(PREFIX "write: byte C 0x%02x\n",buf[2]);
+	printk("  C0-4 top adjustment  : %s dB\n", adjust[buf[2] & 0x1f]);
+	printk("  C5-6 de-emphasis     : %s\n", deemph[(buf[2] & 0x60) >> 5]);
+	printk("  C7   audio gain      : %s\n",
+	       (buf[2] & 0x80) ? "-6" : "0");
+
+	printk(PREFIX "write: byte E 0x%02x\n",buf[3]);
+	printk("  E0-1 sound carrier   : %s\n",
+	       carrier[(buf[3] & 0x03)]);
+	printk("  E6   l pll ganting   : %s\n",
+	       (buf[3] & 0x40) ? "36" : "13");
+
+	if (buf[1] & 0x08) {
+		/* radio */
+		printk("  E2-4 video if        : %s\n",
+		       rif[(buf[3] & 0x0c) >> 2]);
+		printk("  E7   vif agc output  : %s\n",
+		       (buf[3] & 0x80)
+		       ? ((buf[3] & 0x10) ? "fm-agc radio" : "sif-agc radio")
+		       : "fm radio carrier afc");
+	} else {
+		/* video */
+		printk("  E2-4 video if        : %s\n",
+		       vif[(buf[3] & 0x1c) >> 2]);
+		printk("  E5   tuner gain      : %s\n",
+		       (buf[3] & 0x80)
+		       ? ((buf[3] & 0x20) ? "external" : "normal")
+		       : ((buf[3] & 0x20) ? "minimum"  : "normal"));
+		printk("  E7   vif agc output  : %s\n",
+		       (buf[3] & 0x80)
+		       ? ((buf[3] & 0x20)
+			  ? "pin3 port, pin22 vif agc out"
+			  : "pin22 port, pin3 vif acg ext in")
+		       : "pin3+pin22 port");
+	}
+	printk("--\n");
+}
+
+/* ---------------------------------------------------------------------- */
+
+static int tda9887_set_tvnorm(struct tda9887 *t, char *buf)
+{
+	struct tvnorm *norm = NULL;
+	int i;
 
 	if (t->radio) {
-		bVideoTrap   = cVideoTrapBypassOFF;
-		bCarrierMode = cQSS;
-		bModulation  = cFmRadio;
-		bOutPort1    = cOutputPort1Inactive;
-		bDeEmphasis  = cDeemphasisON;
-		if (3 == t->pinnacle_id) {
-			/* ntsc */
-			bDeEmphVal   = cDeemphasis75;
-			bAudioIF     = cAudioIF_4_5;
-			bVideoIF     = cRadioIF_45_75;
-		} else {
-			/* pal */
-			bAudioIF     = cAudioIF_5_5;
-			bVideoIF     = cRadioIF_38_90;
-			bDeEmphVal   = cDeemphasis50;
+		norm = &radio;
+	} else {
+		for (i = 0; i < ARRAY_SIZE(tvnorms); i++) {
+			if (tvnorms[i].std & t->std) {
+				norm = tvnorms+i;
+				break;
+			}
 		}
+	}
+	if (NULL == norm) {
+		dprintk(PREFIX "Oops: no tvnorm entry found\n");
+		return -1;
+	}
+
+	dprintk(PREFIX "configure for: %s\n",norm->name);
+	buf[1] = norm->b;
+	buf[2] = norm->c;
+	buf[3] = norm->e;
+	return 0;
+}
+
+static unsigned int port1  = 1;
+static unsigned int port2  = 1;
+static unsigned int qss    = UNSET;
+static unsigned int adjust = 0x10;
+MODULE_PARM(port1,"i");
+MODULE_PARM(port2,"i");
+MODULE_PARM(qss,"i");
+MODULE_PARM(adjust,"i");
+
+static int tda9887_set_insmod(struct tda9887 *t, char *buf)
+{
+	if (port1)
+		buf[1] |= cOutputPort1Inactive;
+	if (port2)
+		buf[1] |= cOutputPort2Inactive;
+	if (UNSET != qss) {
+		if (qss)
+			buf[1] |= cQSS;
+		else
+			buf[1] &= ~cQSS;
+	}
+	
+	if (adjust >= 0x00 && adjust < 0x20)
+		buf[2] |= adjust;
+	return 0;
+}
 
-	} else if (t->tvnorm == VIDEO_MODE_PAL) {
-		bDeEmphasis  = cDeemphasisON;
-		bDeEmphVal   = cDeemphasis50;
-		bModulation  = cNegativeFmTV;
-		bOutPort1    = cOutputPort1Inactive;
+/* ---------------------------------------------------------------------- */
+
+static int tda9887_set_pinnacle(struct tda9887 *t, char *buf)
+{
+	unsigned int bCarrierMode = UNSET;
+
+	if (t->std & V4L2_STD_PAL) {
 		if ((1 == t->pinnacle_id) || (7 == t->pinnacle_id)) {
 			bCarrierMode = cIntercarrier;
 		} else {
-			// stereo boards
 			bCarrierMode = cQSS;
 		}
-		switch (pal[0]) {
-		case 'b':
-		case 'g':
-		case 'h':
-			bVideoIF     = cVideoIF_38_90;
-			bAudioIF     = cAudioIF_5_5;
-			break;
-		case 'd':
-			bVideoIF     = cVideoIF_38_00;
-			bAudioIF     = cAudioIF_6_5;
-			break;
-		case 'i':
-			bVideoIF     = cVideoIF_38_90;
-			bAudioIF     = cAudioIF_6_0;
-			break;
-		case 'm':
-		case 'n':
-			bVideoIF     = cVideoIF_45_75;
-			bAudioIF     = cAudioIF_4_5;
-			bDeEmphVal   = cDeemphasis75;
-			if ((5 == t->pinnacle_id) || (6 == t->pinnacle_id)) {
-				bCarrierMode = cIntercarrier;
-			} else {
-				bCarrierMode = cQSS;
-			}
-			break;
-		}
-
-	} else if (t->tvnorm == VIDEO_MODE_SECAM) {
-		bAudioIF     = cAudioIF_6_5;
-		bDeEmphasis  = cDeemphasisON;
-		bDeEmphVal   = cDeemphasis50;
-		bModulation  = cNegativeFmTV;
-		bCarrierMode = cQSS;
-		bOutPort1    = cOutputPort1Inactive;                
-		switch (secam[0]) {
-		case 'd':
-			bVideoIF     = cVideoIF_38_00;
-			break;
-		case 'k':
-			bVideoIF     = cVideoIF_38_90;
-			break;
-		case 'l':
-			bVideoIF     = cVideoIF_38_90;
-			bDeEmphasis  = cDeemphasisOFF;
-			bDeEmphVal   = cDeemphasis75;
-			bModulation  = cPositiveAmTV;
-			break;
-		case 'L' /* L1 */:
-			bVideoIF     = cVideoIF_33_90;
-			bDeEmphasis  = cDeemphasisOFF;
-			bDeEmphVal   = cDeemphasis75;
-			bModulation  = cPositiveAmTV;
-			break;
-		}
-
-	} else if (t->tvnorm == VIDEO_MODE_NTSC) {
-                bVideoIF     = cVideoIF_45_75;
-                bAudioIF     = cAudioIF_4_5;
-                bDeEmphasis  = cDeemphasisON;
-                bDeEmphVal   = cDeemphasis75;
-                bModulation  = cNegativeFmTV;                
-                bOutPort1    = cOutputPort1Inactive;
+	}
+	if (t->std & V4L2_STD_NTSC) {
                 if ((5 == t->pinnacle_id) || (6 == t->pinnacle_id)) {
 			bCarrierMode = cIntercarrier;
 		} else {
@@ -249,99 +418,102 @@ static int tda9887_miro(struct tda9887 *
                 }
 	}
 
-	bData[1] = bVideoTrap        |  // B0: video trap bypass
-		cAutoMuteFmInactive  |  // B1: auto mute
-		bCarrierMode         |  // B2: InterCarrier for PAL else QSS 
-		bModulation          |  // B3 - B4: positive AM TV for SECAM only
-		cForcedMuteAudioOFF  |  // B5: forced Audio Mute (off)
-		bOutPort1            |  // B6: Out Port 1 
-		bOutPort2;              // B7: Out Port 2 
-	bData[2] = bTopAdjust |   // C0 - C4: Top Adjust 0 == -16dB  31 == 15dB
-		bDeEmphasis   |   // C5: De-emphasis on/off
-		bDeEmphVal    |   // C6: De-emphasis 50/75 microsec
-		cAudioGain0;      // C7: normal audio gain
-	bData[3] = bAudioIF      |  // E0 - E1: Sound IF
-		bVideoIF         |  // E2 - E4: Video IF
-		cTunerGainNormal |  // E5: Tuner gain (normal)
-		cGating_18       |  // E6: Gating (18%)
-		cAgcOutOFF;         // E7: VAGC  (off)
-	
-	dprintk("tda9885/6/7: 0x%02x 0x%02x 0x%02x [pinnacle_id=%d]\n",
-		bData[1],bData[2],bData[3],t->pinnacle_id);
-	if (4 != (rc = i2c_master_send(&t->client,bData,4)))
-		printk("tda9885/6/7: i2c i/o error: rc == %d (should be 4)\n",rc);
+	if (bCarrierMode != UNSET) {
+		buf[1] &= ~0x04;
+		buf[1] |= bCarrierMode;
+	}
 	return 0;
 }
 
 /* ---------------------------------------------------------------------- */
 
-#if 0
-/* just for reference: old knc-one saa7134 stuff */
-static unsigned char buf_pal_bg[]    = { 0x00, 0x16, 0x70, 0x49 };
-static unsigned char buf_pal_i[]     = { 0x00, 0x16, 0x70, 0x4a };
-static unsigned char buf_pal_dk[]    = { 0x00, 0x16, 0x70, 0x4b };
-static unsigned char buf_pal_l[]     = { 0x00, 0x06, 0x50, 0x4b };
-static unsigned char buf_fm_stereo[] = { 0x00, 0x0e, 0x0d, 0x77 };
-#endif
-
-static unsigned char buf_pal_bg[]    = { 0x00, 0x96, 0x70, 0x49 };
-static unsigned char buf_pal_i[]     = { 0x00, 0x96, 0x70, 0x4a };
-static unsigned char buf_pal_dk[]    = { 0x00, 0x96, 0x70, 0x4b };
-static unsigned char buf_pal_l[]     = { 0x00, 0x86, 0x50, 0x4b };
-static unsigned char buf_fm_stereo[] = { 0x00, 0x8e, 0x0d, 0x77 };
-static unsigned char buf_ntsc[]	     = { 0x00, 0x96, 0x70, 0x44 };
-static unsigned char buf_ntsc_jp[]   = { 0x00, 0x96, 0x70, 0x40 };
+static char *pal = "-";
+MODULE_PARM(pal,"s");
+static char *secam = "-";
+MODULE_PARM(secam,"s");
 
-static int tda9887_configure(struct tda9887 *t)
+static int tda9887_fixup_std(struct tda9887 *t)
 {
-	unsigned char *buf = NULL;
-	int rc;
-
-	if (t->radio) {
-		dprintk("tda9885/6/7: FM Radio mode\n");
-		buf = buf_fm_stereo;
-
-	} else if (t->tvnorm == VIDEO_MODE_PAL) {
-		dprintk("tda9885/6/7: PAL-%c mode\n",pal[0]);
+	/* get more precise norm info from insmod option */
+	if ((t->std & V4L2_STD_PAL) == V4L2_STD_PAL) {
 		switch (pal[0]) {
 		case 'b':
+		case 'B':
 		case 'g':
-			buf = buf_pal_bg;
+		case 'G':
+			dprintk(PREFIX "insmod fixup: PAL => PAL-BG\n");
+			t->std = V4L2_STD_PAL_BG;
 			break;
 		case 'i':
-			buf = buf_pal_i;
+		case 'I':
+			dprintk(PREFIX "insmod fixup: PAL => PAL-I\n");
+			t->std = V4L2_STD_PAL_I;
 			break;
 		case 'd':
+		case 'D':
 		case 'k':
-			buf = buf_pal_dk;
+		case 'K':
+			dprintk(PREFIX "insmod fixup: PAL => PAL-DK\n");
+			t->std = V4L2_STD_PAL_DK;
+			break;
+		}
+	}
+	if ((t->std & V4L2_STD_SECAM) == V4L2_STD_SECAM) {
+		switch (secam[0]) {
+		case 'd':
+		case 'D':
+		case 'k':
+		case 'K':
+			dprintk(PREFIX "insmod fixup: SECAM => SECAM-DK\n");
+			t->std = V4L2_STD_SECAM_DK;
 			break;
 		case 'l':
-			buf = buf_pal_l;
+		case 'L':
+			dprintk(PREFIX "insmod fixup: SECAM => SECAM-L\n");
+			t->std = V4L2_STD_SECAM_L;
 			break;
 		}
+	}
+	return 0;
+}
 
-	} else if (t->tvnorm == VIDEO_MODE_NTSC) {
-		dprintk("tda9885/6/7: NTSC mode\n");
-		buf = buf_ntsc;
-
-	} else if (t->tvnorm == VIDEO_MODE_SECAM) {
-		dprintk("tda9885/6/7: SECAM mode\n");
-                buf = buf_pal_l;
+static int tda9887_status(struct tda9887 *t)
+{
+	unsigned char buf[1];
+	int rc;
+	
+	memset(buf,0,sizeof(buf));
+        if (1 != (rc = i2c_master_recv(&t->client,buf,1)))
+                printk(PREFIX "i2c i/o error: rc == %d (should be 1)\n",rc);
+	dump_read_message(buf);
+	return 0;
+}
 
-        } else if (t->tvnorm == 6 /* BTTV hack */) {
-		dprintk("tda9885/6/7: NTSC-Japan mode\n");
-                buf = buf_ntsc_jp;
-        }
+static int tda9887_configure(struct tda9887 *t)
+{
+	unsigned char buf[4];
+	int rc;
 
-	if (NULL == buf) {
-		printk("tda9885/6/7 unknown norm=%d\n",t->tvnorm);
-		return 0;
+	memset(buf,0,sizeof(buf));
+	tda9887_set_tvnorm(t,buf);
+	if (UNSET != t->pinnacle_id) {
+		tda9887_set_pinnacle(t,buf);
 	}
+	tda9887_set_insmod(t,buf);
 
-	dprintk("tda9885/6/7: 0x%02x 0x%02x 0x%02x\n",
+	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
 		buf[1],buf[2],buf[3]);
+	if (debug > 1)
+		dump_write_message(buf);
+
         if (4 != (rc = i2c_master_send(&t->client,buf,4)))
-                printk("tda9885/6/7: i2c i/o error: rc == %d (should be 4)\n",rc);
+                printk(PREFIX "i2c i/o error: rc == %d (should be 4)\n",rc);
+
+	if (debug > 2) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+		tda9887_status(t);
+	}
 	return 0;
 }
 
@@ -354,14 +526,14 @@ static int tda9887_attach(struct i2c_ada
         client_template.adapter = adap;
         client_template.addr    = addr;
 
-        printk("tda9887: chip found @ 0x%x\n", addr<<1);
+        printk(PREFIX "chip found @ 0x%x\n", addr<<1);
 
         if (NULL == (t = kmalloc(sizeof(*t), GFP_KERNEL)))
                 return -ENOMEM;
 	memset(t,0,sizeof(*t));
-	t->client = client_template;
-	t->pinnacle_id = -1;
-	t->tvnorm=VIDEO_MODE_PAL;
+	t->client      = client_template;
+	t->std         = 0;;
+	t->pinnacle_id = UNSET;
         i2c_set_clientdata(&t->client, t);
         i2c_attach_client(&t->client);
         
@@ -394,6 +566,13 @@ static int tda9887_detach(struct i2c_cli
 	return 0;
 }
 
+#define SWITCH_V4L2	if (!t->using_v4l2 && debug) \
+		          printk(PREFIX "switching to v4l2\n"); \
+	                  t->using_v4l2 = 1;
+#define CHECK_V4L2	if (t->using_v4l2) { if (debug) \
+			  printk(PREFIX "ignore v4l1 call\n"); \
+		          return 0; }
+
 static int
 tda9887_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
@@ -404,10 +583,7 @@ tda9887_command(struct i2c_client *clien
 	/* --- configuration --- */
 	case AUDC_SET_RADIO:
 		t->radio = 1;
-		if (-1 != t->pinnacle_id)
-			tda9887_miro(t);
-		else
-			tda9887_configure(t);
+		tda9887_configure(t);
 		break;
 		
 	case AUDC_CONFIG_PINNACLE:
@@ -415,7 +591,7 @@ tda9887_command(struct i2c_client *clien
 		int *i = arg;
 
 		t->pinnacle_id = *i;
-		tda9887_miro(t);
+		tda9887_configure(t);
 		break;
 	}
 	/* --- v4l ioctls --- */
@@ -423,16 +599,52 @@ tda9887_command(struct i2c_client *clien
 	   kernel pointer here... */
 	case VIDIOCSCHAN:
 	{
+		static const v4l2_std_id map[] = {
+			[ VIDEO_MODE_PAL   ] = V4L2_STD_PAL,
+			[ VIDEO_MODE_NTSC  ] = V4L2_STD_NTSC_M,
+			[ VIDEO_MODE_SECAM ] = V4L2_STD_SECAM,
+			[ 4 /* bttv */     ] = V4L2_STD_PAL_M,
+			[ 5 /* bttv */     ] = V4L2_STD_PAL_N,
+			[ 6 /* bttv */     ] = V4L2_STD_NTSC_M_JP,
+		};
 		struct video_channel *vc = arg;
 
-		t->radio  = 0;
-		t->tvnorm = vc->norm;
-		if (-1 != t->pinnacle_id)
-			tda9887_miro(t);
-		else
-			tda9887_configure(t);
+		CHECK_V4L2;
+		t->radio = 0;
+		if (vc->norm < ARRAY_SIZE(map))
+			t->std = map[vc->norm];
+		tda9887_fixup_std(t);
+		tda9887_configure(t);
+		break;
+	}
+	case VIDIOC_S_STD:
+	{
+		v4l2_std_id *id = arg;
+
+		SWITCH_V4L2;
+		t->radio = 0;
+		t->std   = *id;
+		tda9887_fixup_std(t);
+		tda9887_configure(t);
 		break;
 	}
+	case VIDIOC_S_FREQUENCY:
+	{
+		struct v4l2_frequency *f = arg;
+
+		SWITCH_V4L2;
+		if (V4L2_TUNER_ANALOG_TV == f->type) {
+			if (t->radio == 0)
+				return 0;
+			t->radio = 0;
+		}
+		if (V4L2_TUNER_RADIO == f->type) {
+			if (t->radio == 1)
+				return 0;
+			t->radio = 1;
+		}
+		tda9887_configure(t);
+	}
 	default:
 		/* nothing */
 		break;
diff -up linux-2.6.7/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.7/drivers/media/video/tuner.c	2004-06-17 10:30:35.000000000 +0200
+++ linux/drivers/media/video/tuner.c	2004-06-17 13:47:59.273368755 +0200
@@ -26,15 +26,17 @@ I2C_CLIENT_INSMOD;
 static unsigned int debug =  0;
 static unsigned int type  =  UNSET;
 static unsigned int addr  =  0;
-static char *pal =  "b";
 static unsigned int tv_range[2]    = { 44, 958 };
 static unsigned int radio_range[2] = { 65, 108 };
+static unsigned int tv_antenna = 1;
+static unsigned int radio_antenna = 0;
 MODULE_PARM(debug,"i");
 MODULE_PARM(type,"i");
 MODULE_PARM(addr,"i");
 MODULE_PARM(tv_range,"2i");
 MODULE_PARM(radio_range,"2i");
-MODULE_PARM(pal,"s");
+MODULE_PARM(tv_antenna,"i");
+MODULE_PARM(radio_antenna,"i");
 
 #define optimize_vco 1
 
@@ -48,10 +50,10 @@ static int this_adap;
 struct tuner {
 	unsigned int type;            /* chip type */
 	unsigned int freq;            /* keep track of the current settings */
-	unsigned int std;
+	v4l2_std_id  std;
+	int          using_v4l2;
 	
 	unsigned int radio;
-	unsigned int mode;            /* current norm for multi-norm tuners */
 	unsigned int input;
 	
 	// only for MT2032
@@ -537,15 +539,16 @@ static void mt2032_set_tv_freq(struct i2
 	int if2,from,to;
 
 	// signal bandwidth and picture carrier
-	if (t->mode == VIDEO_MODE_NTSC) {
-		from=40750*1000;
-		to=46750*1000;
-		if2=45750*1000; 
+	if (t->std & V4L2_STD_525_60) {
+		// NTSC
+		from = 40750*1000;
+		to   = 46750*1000;
+		if2  = 45750*1000; 
 	} else {
-		// Pal 
-		from=32900*1000;
-		to=39900*1000;
-		if2=38900*1000;
+		// PAL
+		from = 32900*1000;
+		to   = 39900*1000;
+		if2  = 38900*1000;
 	}
 
         mt2032_set_if_freq(c, freq*62500 /* freq*1000*1000/16 */,
@@ -619,6 +622,17 @@ static int mt2032_init(struct i2c_client
         return(1);
 }
 
+static void mt2050_set_antenna(struct i2c_client *c, unsigned char antenna)
+{
+       unsigned char buf[2];
+       int ret;
+
+       buf[0] = 6;
+       buf[1] = antenna ? 0x11 : 0x10;
+       ret=i2c_master_send(c,buf,2);
+       dprintk("mt2050: enabled antenna connector %d\n", antenna);
+}
+
 static void mt2050_set_if_freq(struct i2c_client *c,unsigned int freq, unsigned int if2)
 {
 	unsigned int if1=1218*1000*1000;
@@ -683,13 +697,15 @@ static void mt2050_set_tv_freq(struct i2
 	struct tuner *t = i2c_get_clientdata(c);
 	unsigned int if2;
 	
-	if (t->mode == VIDEO_MODE_NTSC) {
-                if2=45750*1000;
+	if (t->std & V4L2_STD_525_60) {
+		// NTSC
+                if2 = 45750*1000;
         } else {
-                // Pal
-                if2=38900*1000;
+                // PAL
+                if2 = 38900*1000;
         }
-	mt2050_set_if_freq(c,freq*62500,if2);
+	mt2050_set_if_freq(c, freq*62500, if2);
+	mt2050_set_antenna(c, tv_antenna);
 }
 
 static void mt2050_set_radio_freq(struct i2c_client *c, unsigned int freq)
@@ -698,6 +714,7 @@ static void mt2050_set_radio_freq(struct
 	int if2 = t->radio_if2;
 	
 	mt2050_set_if_freq(c, freq*62500, if2);
+	mt2050_set_antenna(c, radio_antenna);
 }
 
 static int mt2050_init(struct i2c_client *c)
@@ -731,8 +748,8 @@ static int microtune_init(struct i2c_cli
         unsigned char buf[21];
 	int company_code;
 	
-        buf[0] = 0;
-	t->tv_freq = NULL;
+	memset(buf,0,sizeof(buf));
+	t->tv_freq    = NULL;
 	t->radio_freq = NULL;
 	name = "unknown";
 
@@ -751,6 +768,9 @@ static int microtune_init(struct i2c_cli
 	company_code = buf[0x11] << 8 | buf[0x12];
         printk("tuner: microtune: companycode=%04x part=%02x rev=%02x\n",
 	       company_code,buf[0x13],buf[0x14]);
+
+#if 0
+	/* seems to cause more problems than it solves ... */
 	switch (company_code) {
 	case 0x30bf:
 	case 0x3cbf:
@@ -764,6 +784,7 @@ static int microtune_init(struct i2c_cli
 		printk("tuner: microtune: unknown companycode\n");
 		return 0;
 	}
+#endif
 
 	if (buf[0x13] < ARRAY_SIZE(microtune_part) &&
 	    NULL != microtune_part[buf[0x13]])
@@ -811,54 +832,40 @@ static void default_set_tv_freq(struct i
 		/* 0x02 -> PAL BDGHI / SECAM L */
 		/* 0x04 -> ??? PAL others / SECAM others ??? */
 		config &= ~0x02;
-		if (t->mode == VIDEO_MODE_SECAM)
+		if (t->std & V4L2_STD_SECAM)
 			config |= 0x02;
 		break;
 
 	case TUNER_TEMIC_4046FM5:
 		config &= ~0x0f;
-		switch (pal[0]) {
-		case 'i':
-		case 'I':
+
+		if (t->std & V4L2_STD_PAL_BG) {
+			config |= TEMIC_SET_PAL_BG;
+
+		} else if (t->std & V4L2_STD_PAL_I) {
 			config |= TEMIC_SET_PAL_I;
-			break;
-		case 'd':
-		case 'D':
+
+		} else if (t->std & V4L2_STD_PAL_DK) {
 			config |= TEMIC_SET_PAL_DK;
-			break;
-		case 'l':
-		case 'L':
+			
+		} else if (t->std & V4L2_STD_SECAM_L) {
 			config |= TEMIC_SET_PAL_L;
-			break;
-		case 'b':
-		case 'B':
-		case 'g':
-		case 'G':
-		default:
-			config |= TEMIC_SET_PAL_BG;
-			break;
+
 		}
 		break;
 
 	case TUNER_PHILIPS_FQ1216ME:
 		config &= ~0x0f;
-		switch (pal[0]) {
-		case 'i':
-		case 'I':
+
+		if (t->std & (V4L2_STD_PAL_BG|V4L2_STD_PAL_DK)) {
+			config |= PHILIPS_SET_PAL_BGDK;
+
+		} else if (t->std & V4L2_STD_PAL_I) {
 			config |= PHILIPS_SET_PAL_I;
-			break;
-		case 'l':
-		case 'L':
+
+		} else if (t->std & V4L2_STD_SECAM_L) {
 			config |= PHILIPS_SET_PAL_L;
-			break;
-		case 'd':
-		case 'D':
-		case 'b':
-		case 'B':
-		case 'g':
-		case 'G':
-			config |= PHILIPS_SET_PAL_BGDK;
-			break;
+
 		}
 		break;
 
@@ -867,12 +874,9 @@ static void default_set_tv_freq(struct i
 		/* 0x01 -> ATSC antenna input 2 */
 		/* 0x02 -> NTSC antenna input 1 */
 		/* 0x03 -> NTSC antenna input 2 */
-		
 		config &= ~0x03;
-#ifdef VIDEO_MODE_ATSC
-		if (VIDEO_MODE_ATSC != t->mode)
+		if (t->std & V4L2_STD_ATSC)
 			config |= 2;
-#endif
 		/* FIXME: input */
 		break;
 	}
@@ -990,6 +994,22 @@ static void set_radio_freq(struct i2c_cl
 	t->radio_freq(c,freq);
 }
 
+static void set_freq(struct i2c_client *c, unsigned long freq)
+{
+	struct tuner *t = i2c_get_clientdata(c);
+
+	if (t->radio) {
+		dprintk("tuner: radio freq set to %lu.%02lu\n",
+			freq/16,freq%16*100/16);
+		set_radio_freq(c,freq);
+	} else {
+		dprintk("tuner: tv freq set to %lu.%02lu\n",
+			freq/16,freq%16*100/16);
+		set_tv_freq(c, freq);
+	}
+	t->freq = freq;
+}
+
 static void set_type(struct i2c_client *c, unsigned int type, char *source)
 {
 	struct tuner *t = i2c_get_clientdata(c);
@@ -1019,6 +1039,38 @@ static void set_type(struct i2c_client *
 	}
 }
 
+static char *pal = "-";
+MODULE_PARM(pal,"s");
+
+static int tuner_fixup_std(struct tuner *t)
+{
+	if ((t->std & V4L2_STD_PAL) == V4L2_STD_PAL) {
+		/* get more precise norm info from insmod option */
+		switch (pal[0]) {
+		case 'b':
+		case 'B':
+		case 'g':
+		case 'G':
+			dprintk("insmod fixup: PAL => PAL-BG\n");
+			t->std = V4L2_STD_PAL_BG;
+			break;
+		case 'i':
+		case 'I':
+			dprintk("insmod fixup: PAL => PAL-I\n");
+			t->std = V4L2_STD_PAL_I;
+			break;
+		case 'd':
+		case 'D':
+		case 'k':
+		case 'K':
+			dprintk("insmod fixup: PAL => PAL-DK\n");
+			t->std = V4L2_STD_PAL_DK;
+			break;
+		}
+	}
+	return 0;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int tuner_attach(struct i2c_adapter *adap, int addr, int kind)
@@ -1054,7 +1106,7 @@ static int tuner_attach(struct i2c_adapt
 		set_type(client, type, "insmod option");
 		printk("tuner: The type=<n> insmod option will go away soon.\n");
 		printk("tuner: Please use the tuner=<n> option provided by\n");
-		printk("tuner: tv card core driver (bttv, saa7134, ...) instead.\n");
+		printk("tuner: tv aard core driver (bttv, saa7134, ...) instead.\n");
 	}
 	return 0;
 }
@@ -1094,6 +1146,13 @@ static int tuner_detach(struct i2c_clien
 	return 0;
 }
 
+#define SWITCH_V4L2	if (!t->using_v4l2 && debug) \
+		          printk("tuner: switching to v4l2\n"); \
+	                  t->using_v4l2 = 1;
+#define CHECK_V4L2	if (t->using_v4l2) { if (debug) \
+			  printk("tuner: ignore v4l1 call\n"); \
+		          return 0; }
+
 static int
 tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
@@ -1130,10 +1189,21 @@ tuner_command(struct i2c_client *client,
 	   kernel pointer here... */
 	case VIDIOCSCHAN:
 	{
+		static const v4l2_std_id map[] = {
+			[ VIDEO_MODE_PAL   ] = V4L2_STD_PAL,
+			[ VIDEO_MODE_NTSC  ] = V4L2_STD_NTSC_M,
+			[ VIDEO_MODE_SECAM ] = V4L2_STD_SECAM,
+			[ 4 /* bttv */     ] = V4L2_STD_PAL_M,
+			[ 5 /* bttv */     ] = V4L2_STD_PAL_N,
+			[ 6 /* bttv */     ] = V4L2_STD_NTSC_M_JP,
+		};
 		struct video_channel *vc = arg;
 
+		CHECK_V4L2;
 		t->radio = 0;
-		t->mode = vc->norm;
+		if (vc->norm < ARRAY_SIZE(map))
+			t->std = map[vc->norm];
+		tuner_fixup_std(t);
 		if (t->freq)
 			set_tv_freq(client,t->freq);
 		return 0;
@@ -1142,22 +1212,15 @@ tuner_command(struct i2c_client *client,
 	{
 		unsigned long *v = arg;
 
-		if (t->radio) {
-			dprintk("tuner: radio freq set to %lu.%02lu\n",
-				(*v)/16,(*v)%16*100/16);
-			set_radio_freq(client,*v);
-		} else {
-			dprintk("tuner: tv freq set to %lu.%02lu\n",
-				(*v)/16,(*v)%16*100/16);
-			set_tv_freq(client,*v);
-		}
-		t->freq = *v;
+		CHECK_V4L2;
+		set_freq(client,*v);
 		return 0;
 	}
 	case VIDIOCGTUNER:
 	{
 		struct video_tuner *vt = arg;
 
+		CHECK_V4L2;
 		if (t->radio)
 			vt->signal = tuner_signal(client);
 		return 0;
@@ -1165,10 +1228,52 @@ tuner_command(struct i2c_client *client,
 	case VIDIOCGAUDIO:
 	{
 		struct video_audio *va = arg;
+
+		CHECK_V4L2;
 		if (t->radio)
 			va->mode = (tuner_stereo(client) ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO);
 		return 0;
 	}
+
+	case VIDIOC_S_STD:
+	{
+		v4l2_std_id *id = arg;
+
+		SWITCH_V4L2;
+		t->radio = 0;
+		t->std = *id;
+		tuner_fixup_std(t);
+		if (t->freq)
+			set_freq(client,t->freq);
+		break;
+	}
+	case VIDIOC_S_FREQUENCY:
+	{
+		struct v4l2_frequency *f = arg;
+
+		SWITCH_V4L2;
+		if (V4L2_TUNER_ANALOG_TV == f->type) {
+			t->radio = 0;
+		}
+		if (V4L2_TUNER_RADIO == f->type) {
+			if (!t->radio) {
+				set_tv_freq(client,400*16);
+				t->radio = 1;
+			}
+		}
+		t->freq  = f->frequency;
+		set_freq(client,t->freq);
+		break;
+	}
+	case VIDIOC_G_TUNER:
+	{
+		struct v4l2_tuner *tuner = arg;
+
+		SWITCH_V4L2;
+		if (t->radio)
+			tuner->signal = tuner_signal(client);
+		break;
+	}
 	default:
 		/* nothing */
 		break;

-- 
Smoking Crack Organization

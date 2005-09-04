Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVIDXbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVIDXbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVIDXbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:22 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:60289 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932124AbVIDXbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:13 -0400
Message-Id: <20050904232333.688686000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:44 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, thomas schorpp <t.schorpp@gmx.de>
Content-Disposition: inline; filename=dvb-ttpci-siemens-dvb-c-analog-input.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 45/54] av7110: Siemens DVB-C analog video input support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: thomas schorpp <t.schorpp@gmx.de>

Add support for analog video inputs (CVBS and Y/C) of the
analog module for the Siemens DVB-C card.

Signed-off-by: thomas schorpp <t.schorpp@gmx.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110_v4l.c |   74 +++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 20 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_v4l.c	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_v4l.c	2005-09-04 22:30:54.000000000 +0200
@@ -70,7 +70,7 @@ static int msp_readreg(struct av7110 *av
 	return 0;
 }
 
-static struct v4l2_input inputs[2] = {
+static struct v4l2_input inputs[4] = {
 	{
 		.index		= 0,
 		.name		= "DVB",
@@ -87,6 +87,22 @@ static struct v4l2_input inputs[2] = {
 		.tuner		= 0,
 		.std		= V4L2_STD_PAL_BG|V4L2_STD_NTSC_M,
 		.status		= 0,
+	}, {
+		.index		= 2,
+		.name		= "Video",
+		.type		= V4L2_INPUT_TYPE_CAMERA,
+		.audioset	= 0,
+		.tuner		= 0,
+		.std		= V4L2_STD_PAL_BG|V4L2_STD_NTSC_M,
+		.status		= 0,
+	}, {
+		.index		= 3,
+		.name		= "Y/C",
+		.type		= V4L2_INPUT_TYPE_CAMERA,
+		.audioset	= 0,
+		.tuner		= 0,
+		.std		= V4L2_STD_PAL_BG|V4L2_STD_NTSC_M,
+		.status		= 0,
 	}
 };
 
@@ -212,24 +228,44 @@ static int av7110_dvb_c_switch(struct sa
 	}
 
 	if (0 != av7110->current_input) {
+		dprintk(1, "switching to analog TV:\n");
 		adswitch = 1;
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
-		dprintk(1, "switching to analog TV\n");
-		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
-		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
-		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
-		msp_writereg(av7110, MSP_WR_DSP, 0x000e, 0x3000); // FM matrix, mono
-		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x4f00); // loudspeaker + headphone
-		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x4f00); // SCART 1 volume
 
-		if (av7110->analog_tuner_flags & ANALOG_TUNER_VES1820) {
-			if (ves1820_writereg(dev, 0x09, 0x0f, 0x60))
-				dprintk(1, "setting band in demodulator failed.\n");
-		} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
-			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
-			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI); // TDA9198 pin30(VIF)
+		switch (av7110->current_input) {
+		case 1:
+			dprintk(1, "switching SAA7113 to Analog Tuner Input.\n");
+			msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
+			msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
+			msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
+			msp_writereg(av7110, MSP_WR_DSP, 0x000e, 0x3000); // FM matrix, mono
+			msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x4f00); // loudspeaker + headphone
+			msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x4f00); // SCART 1 volume
+
+			if (av7110->analog_tuner_flags & ANALOG_TUNER_VES1820) {
+				if (ves1820_writereg(dev, 0x09, 0x0f, 0x60))
+					dprintk(1, "setting band in demodulator failed.\n");
+			} else if (av7110->analog_tuner_flags & ANALOG_TUNER_STV0297) {
+				saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
+				saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI); // TDA9198 pin30(VIF)
+			}
+			if (i2c_writereg(av7110, 0x48, 0x02, 0xd0) != 1)
+				dprintk(1, "saa7113 write failed @ card %d", av7110->dvb_adapter.num);
+			break;
+		case 2:
+			dprintk(1, "switching SAA7113 to Video AV CVBS Input.\n");
+			if (i2c_writereg(av7110, 0x48, 0x02, 0xd2) != 1)
+				dprintk(1, "saa7113 write failed @ card %d", av7110->dvb_adapter.num);
+			break;
+		case 3:
+			dprintk(1, "switching SAA7113 to Video AV Y/C Input.\n");
+			if (i2c_writereg(av7110, 0x48, 0x02, 0xd9) != 1)
+				dprintk(1, "saa7113 write failed @ card %d", av7110->dvb_adapter.num);
+			break;
+		default:
+			dprintk(1, "switching SAA7113 to Input: AV7110: SAA7113: invalid input.\n");
 		}
 	} else {
 		adswitch = 0;
@@ -300,7 +336,6 @@ static int av7110_ioctl(struct saa7146_f
 		// FIXME: standard / stereo detection is still broken
 		msp_readreg(av7110, MSP_RD_DEM, 0x007e, &stereo_det);
 		dprintk(1, "VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
-
 		msp_readreg(av7110, MSP_RD_DSP, 0x0018, &stereo_det);
 		dprintk(1, "VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
 		stereo = (s8)(stereo_det >> 8);
@@ -310,7 +345,7 @@ static int av7110_ioctl(struct saa7146_f
 			t->audmode = V4L2_TUNER_MODE_STEREO;
 		}
 		else if (stereo < -0x10) {
-			/* bilingual*/
+			/* bilingual */
 			t->rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 			t->audmode = V4L2_TUNER_MODE_LANG1;
 		}
@@ -344,7 +379,7 @@ static int av7110_ioctl(struct saa7146_f
 			fm_matrix = 0x3000; // mono
 			src = 0x0010;
 			break;
-		default: /* case V4L2_TUNER_MODE_MONO: {*/
+		default: /* case V4L2_TUNER_MODE_MONO: */
 			dprintk(2, "VIDIOC_S_TUNER: TDA9840_SET_MONO\n");
 			fm_matrix = 0x3000; // mono
 			src = 0x0030;
@@ -406,7 +441,7 @@ static int av7110_ioctl(struct saa7146_f
 		dprintk(2, "VIDIOC_ENUMINPUT: %d\n", i->index);
 
 		if (av7110->analog_tuner_flags) {
-			if (i->index < 0 || i->index >= 2)
+			if (i->index < 0 || i->index >= 4)
 				return -EINVAL;
 		} else {
 			if (i->index != 0)
@@ -433,10 +468,9 @@ static int av7110_ioctl(struct saa7146_f
 		if (!av7110->analog_tuner_flags)
 			return 0;
 
-		if (input < 0 || input >= 2)
+		if (input < 0 || input >= 4)
 			return -EINVAL;
 
-		/* FIXME: switch inputs here */
 		av7110->current_input = input;
 		return av7110_dvb_c_switch(fh);
 	}

--


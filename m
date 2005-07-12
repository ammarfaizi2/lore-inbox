Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVGLQ13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVGLQ13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVGLQZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:25:28 -0400
Received: from imap.gmx.net ([213.165.64.20]:54219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261548AbVGLQXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:23:37 -0400
X-Authenticated: #17142692
Message-ID: <42D3EE77.3040603@gmx.de>
Date: Tue, 12 Jul 2005 18:23:19 +0200
From: thomas schorpp <t.schorpp@gmx.de>
Reply-To: t.schorpp@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [DVB]Siemens DVB-C PCI: SAA7113 Analog Module Extension:
 Fix missing Video (CVBS+Y/C) Inputs in AV7111X V4L driver
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

this patch enables the before not implemented video inputs of the
SAA7113 Analog Cable Extension Module of that "classic" dvb-c card
listed:

http://www.vdr-wiki.de/wiki/index.php/DVB-C_full-featured-Karten#Fujitsu-Siemens_DVB-C

- tested O.K. with original Siemens PCI Card + CI + Analog Module
- tested O.K. with xawtv (latest 3.xx release at this time)
- tested O.K. with gnomemeeting (v4l1 only)
- tested O.K. with tvtime 0.9x (NOT OK if tuner is accessed! be careful)
- not tested the Y/C input configuration, is guessed from datasheet.

signed-off-by: t.schorpp@gmx.de

y
tom

--- av7110_v4l.c	2005-06-17 21:48:29.000000000 +0200
+++ av7110_v4l.c-7113	2005-07-11 01:43:18.000000000 +0200
@@ -70,7 +70,7 @@
 	return 0;
 }

-static struct v4l2_input inputs[2] = {
+static struct v4l2_input inputs[4] = {
 	{
 		.index		= 0,
 		.name		= "DVB",
@@ -87,6 +87,22 @@
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

@@ -212,11 +228,17 @@
 	}

 	if (0 != av7110->current_input) {
+		
+		dprintk(1, "switching to analog TV: \n");
 		adswitch = 1;
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard, analog_standard, sizeof(struct saa7146_standard) * 2);
-		dprintk(1, "switching to analog TV\n");
+		
+		switch (av7110->current_input) {
+		case 1:
+		{
+		dprintk(1, "switching SAA7113 to Analog Tuner Input.\n");
 		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
 		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
 		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
@@ -231,6 +253,37 @@
 			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // TDA9198 pin9(STD)
 			saa7146_setgpio(dev, 3, SAA7146_GPIO_OUTHI); // TDA9198 pin30(VIF)
 		}
+		
+		if (i2c_writereg(av7110, 0x48, 0x02, 0xd0) != 1) {
+			dprintk(1, "saa7113 write failed @ card %d", av7110->dvb_adapter.num);
+		}
+		break;
+		}
+				
+		case 2:
+		{
+		if (i2c_writereg(av7110, 0x48, 0x02, 0xd2) != 1) {
+			dprintk(1, "saa7113 write failed @ card %d", av7110->dvb_adapter.num);
+		}
+		dprintk(1, "switching SAA7113 to Video AV CVBS Input.\n");
+		break;
+		}		
+		
+		case 3:
+		{
+		if (i2c_writereg(av7110, 0x48, 0x02, 0xd9) != 1) {
+			dprintk(1, "saa7113 write failed @ card %d", av7110->dvb_adapter.num);
+		}
+		dprintk(1, "switching SAA7113 to Video AV Y/C Input.\n");
+		break;
+		}		
+		
+		default:
+		{
+		dprintk(1, "switching SAA7113 to Input: AV7110: SAA7113: invalid
input.\n");
+		}		
+		}
+				
 	} else {
 		adswitch = 0;
 		source = SAA7146_HPS_SOURCE_PORT_A;
@@ -406,7 +459,7 @@
 		dprintk(2, "VIDIOC_ENUMINPUT: %d\n", i->index);

 		if (av7110->analog_tuner_flags) {
-			if (i->index < 0 || i->index >= 2)
+			if (i->index < 0 || i->index >= 4)
 				return -EINVAL;
 		} else {
 			if (i->index != 0)
@@ -433,7 +486,7 @@
 		if (!av7110->analog_tuner_flags)
 			return 0;

-		if (input < 0 || input >= 2)
+		if (input < 0 || input >= 4)
 			return -EINVAL;


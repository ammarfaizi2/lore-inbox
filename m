Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTLGRqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTLGRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:46:48 -0500
Received: from ws23-90.kotiportti.fi ([193.185.141.90]:11922 "EHLO
	mood.kotiportti.fi") by vger.kernel.org with ESMTP id S264461AbTLGRqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:46:43 -0500
Date: Sun, 7 Dec 2003 19:46:38 +0200
From: Ville Hallivuori <vph@iki.fi>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: CMPCI patch for 2.4.23 (fix multi channel audio, spdiff, game port)
Message-ID: <20031207174637.GA4285@vph.iki.fi>
Reply-To: vph@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CMPCI sound driver changes in 2.4.22->2.4.23 broke:
      -Multi channel audio
	     -Input and output channels were swapped -- but it appears
	      that >2 channel audio works only for ch1 (at least in CM8738).
      -Game port
	     -Incorrect IO address
	     -Some of spdiff configuration was done to wrong register
      -SPDIFF (not tested)
	     -Some of spdiff configuration was done to wrong register

I have tested two and six channel analog audio out and game port with
this patch (using CM8738 with Soyo Dragon MB). Swapping channels is
lots of mechanical replacing, so it it possible that this patch might
break line in and spdiff functionality.

Whoever maintains cmpci (Dave?), please consider applying this patch
to kernel tree.

--- cmpci.c.old	Fri Nov 28 20:26:20 2003
+++ cmpci.c	Sun Dec  7 18:24:36 2003
@@ -188,11 +188,11 @@
 #define CM_EXTENT_CODEC	  0x100
 #define CM_EXTENT_MIDI	  0x2
 #define CM_EXTENT_SYNTH	  0x4
-#define CM_EXTENT_GAME	  0x8
+#define CM_EXTENT_GAME	  0x1 /*0x8*/
 
 // Function Control Register 0 (00h)
-#define CHADC0    	0x01
-#define CHADC1    	0x02
+#define CHADC0    	0x02
+#define CHADC1    	0x01
 #define PAUSE0	  	0x04
 #define PAUSE1	  	0x08
  
@@ -211,8 +211,8 @@
 // Function Control Register 1+1 (05h)
 #define	SPDF_0		0x01
 #define	SPDF_1		0x02
-#define	ASFC		0xe0
-#define	DSFC		0x1c
+#define	DSFC		0xe0
+#define	ASFC		0x1c
 #define	SPDIF2DAC	(SPDF_0 << 8 | SPDO2DAC)
 
 // Channel Format Register (08h)
@@ -292,26 +292,26 @@
 #define	SPDVALID	0x02
 #define	CENTR2MIC	0x04
 
-#define CM_CFMT_DACSHIFT   0
-#define CM_CFMT_ADCSHIFT   2
-#define CM_FREQ_DACSHIFT   2
-#define CM_FREQ_ADCSHIFT   5
-#define	RSTDAC		RST_CH0
-#define	RSTADC		RST_CH1
-#define	ENDAC		CHEN0
-#define	ENADC		CHEN1
-#define	PAUSEDAC	PAUSE0
-#define	PAUSEADC	PAUSE1
-#define CODEC_CMI_DAC_FRAME1	CODEC_CMI_CH0_FRAME1
-#define CODEC_CMI_DAC_FRAME2	CODEC_CMI_CH0_FRAME2
-#define CODEC_CMI_ADC_FRAME1	CODEC_CMI_CH1_FRAME1
-#define CODEC_CMI_ADC_FRAME2	CODEC_CMI_CH1_FRAME2
-#define	DACINT		CHINT0
-#define	ADCINT		CHINT1
-#define	DACBUSY		CH0BUSY
-#define	ADCBUSY		CH1BUSY
-#define	ENDACINT	CH0_INT_EN
-#define	ENADCINT	CH1_INT_EN
+#define CM_CFMT_DACSHIFT   2
+#define CM_CFMT_ADCSHIFT   0
+#define CM_FREQ_DACSHIFT   5
+#define CM_FREQ_ADCSHIFT   2
+#define	RSTDAC		RST_CH1
+#define	RSTADC		RST_CH0
+#define	ENDAC		CHEN1
+#define	ENADC		CHEN0
+#define	PAUSEDAC	PAUSE1
+#define	PAUSEADC	PAUSE0
+#define CODEC_CMI_DAC_FRAME1	CODEC_CMI_CH1_FRAME1
+#define CODEC_CMI_DAC_FRAME2	CODEC_CMI_CH1_FRAME2
+#define CODEC_CMI_ADC_FRAME1	CODEC_CMI_CH0_FRAME1
+#define CODEC_CMI_ADC_FRAME2	CODEC_CMI_CH0_FRAME2
+#define	DACINT		CHINT1
+#define	ADCINT		CHINT0
+#define	DACBUSY		CH1BUSY
+#define	ADCBUSY		CH0BUSY
+#define	ENDACINT	CH1_INT_EN
+#define	ENADCINT	CH0_INT_EN
 
 static const unsigned sample_size[] = { 1, 2, 2, 4 };
 static const unsigned sample_shift[]	= { 0, 1, 1, 2 };
@@ -731,7 +731,7 @@
 {
 	if (rate == 48000 || rate == 44100) {
 		// SPDF_0
-		maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~0, SPDF_0);
+		maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0, SPDF_0);
 		// SPDIFI48K SPDF_ACc97
 		maskl(s->iobase + CODEC_CMI_MISC_CTRL, ~SPDIF48K, rate == 48000 ? SPDIF48K : 0);
 		// ENSPDOUT
@@ -740,7 +740,7 @@
 		set_spdif_monitor(s, 2);
 		s->status |= DO_SPDIF_OUT;
 	} else {
-		maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~SPDF_0, 0);
+		maskb(s->iobase + CODEC_CMI_FUNCTRL1 +1  , ~SPDF_0, 0);
 		maskb(s->iobase + CODEC_CMI_LEGACY_CTRL + 2, ~ENSPDOUT, 0);
 		// monitor none
 		set_spdif_monitor(s, 0);
@@ -761,12 +761,12 @@
 {
 	if (rate == 48000 || rate == 44100) {
 		// SPDF_1
-		maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~0, SPDF_1);
+		maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~0, SPDF_1);
 		// SPDIFI48K SPDF_AC97
 		maskl(s->iobase + CODEC_CMI_MISC_CTRL, ~SPDIF48K, rate == 48000 ? SPDIF48K : 0);
 		s->status |= DO_SPDIF_IN;
 	} else {
-		maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~SPDF_1, 0);
+		maskb(s->iobase + CODEC_CMI_FUNCTRL1 + 1, ~SPDF_1, 0);
 		s->status &= ~DO_SPDIF_IN;
 	}
 }
@@ -3354,7 +3354,7 @@
 #endif
 	s->iosynth = fmio;
 	s->iomidi = mpuio;
-	s->gameport.io = 0x200;
+	s->gameport.io = 0x201;
 	s->status = 0;
 	/* range check */
 	if (speakers < 2)


-- 
[Ville Hallivuori][vph@iki.fi][http://www.iki.fi/vph/]
[ID 8E1AD461][FP16=C9 50 E2 DF 48 F6 33 62  5D 87 47 9D 3F 2B 07 5D]
[ID 58543419][FP20=8731 941D 15AB D4A0 88A0  FC8F B55C F4C4 5854 3419]
[ID 8061C24E][FP20=C722 12DA 841E D811 DBFE  2FB3 174C E291 8061 C24E]

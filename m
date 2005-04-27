Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVD0OUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVD0OUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVD0OUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:20:49 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28628 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261628AbVD0OUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:20:08 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 27 Apr 2005 16:13:15 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] v4l: msp3400 update
Message-ID: <20050427141315.GA15067@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

msp3400 update: Fix and enable "simpler" mode, some other minor fixes.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/msp3400.c |   28 ++++++++++++++++++----------
 drivers/media/video/tvaudio.c |    2 +-
 2 files changed, 19 insertions(+), 11 deletions(-)

Index: linux-2.6.12-rc3/drivers/media/video/msp3400.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/msp3400.c	2005-04-26 12:25:43.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/msp3400.c	2005-04-26 12:25:58.000000000 +0200
@@ -380,7 +380,9 @@ static void msp3400c_setvolume(struct i2
 	int val = 0, bal = 0;
 
 	if (!muted) {
-		val = (volume * 0x7F / 65535) << 8;
+		/* 0x7f instead if 0x73 here has sound quality issues,
+		 * probably due to overmodulation + clipping ... */
+		val = (volume * 0x73 / 65535) << 8;
 	}
 	if (val) {
 		bal = (balance / 256) - 128;
@@ -997,7 +999,13 @@ static int msp34xx_modus(int norm)
 {
 	switch (norm) {
 	case VIDEO_MODE_PAL:
+#if 1
+		/* experimental: not sure this works with all chip versions */
+		return 0x7003;
+#else
+		/* previous value, try this if it breaks ... */
 		return 0x1003;
+#endif
 	case VIDEO_MODE_NTSC:  /* BTSC */
 		return 0x2003;
 	case VIDEO_MODE_SECAM:
@@ -1264,6 +1272,7 @@ static int msp34xxg_thread(void *data)
 	int val, std, i;
 
 	printk("msp34xxg: daemon started\n");
+	msp->source = 1; /* default */
 	for (;;) {
 		d2printk(KERN_DEBUG "msp34xxg: thread: sleep\n");
 		msp34xx_sleep(msp,-1);
@@ -1334,8 +1343,9 @@ static void msp34xxg_set_source(struct i
 
 	/* fix matrix mode to stereo and let the msp choose what
 	 * to output according to 'source', as recommended
+	 * for MONO (source==0) downmixing set bit[7:0] to 0x30
 	 */
-	int value = (source&0x07)<<8|(source==0 ? 0x00:0x20);
+	int value = (source&0x07)<<8|(source==0 ? 0x30:0x20);
 	dprintk("msp34xxg: set source to %d (0x%x)\n", source, value);
 	msp3400c_write(client,
 		       I2C_MSP3400C_DFP,
@@ -1359,7 +1369,7 @@ static void msp34xxg_set_source(struct i
 	msp3400c_write(client,
 		       I2C_MSP3400C_DEM,
 		       0x22, /* a2 threshold for stereo/bilingual */
-		       source==0 ? 0x7f0:stereo_threshold);
+		       stereo_threshold);
 	msp->source=source;
 }
 
@@ -1394,7 +1404,7 @@ static void msp34xxg_detect_stereo(struc
 static void msp34xxg_set_audmode(struct i2c_client *client, int audmode)
 {
 	struct msp3400c *msp = i2c_get_clientdata(client);
-	int source = 0;
+	int source;
 
 	switch (audmode) {
 	case V4L2_TUNER_MODE_MONO:
@@ -1410,9 +1420,10 @@ static void msp34xxg_set_audmode(struct 
 	case V4L2_TUNER_MODE_LANG2:
 		source=4; /* stereo or B */
 		break;
-	default: /* doing nothing: a safe, sane default */
+	default:
 		audmode = 0;
-		return;
+		source  = 1;
+		break;
 	}
 	msp->audmode = audmode;
 	msp34xxg_set_source(client, source);
@@ -1514,12 +1525,9 @@ static int msp_attach(struct i2c_adapter
 
 	msp->opmode = opmode;
 	if (OPMODE_AUTO == msp->opmode) {
-#if 0 /* seems to work for ivtv only, disable by default for now ... */
 		if (HAVE_SIMPLER(msp))
 			msp->opmode = OPMODE_SIMPLER;
-		else
-#endif
-		if (HAVE_SIMPLE(msp))
+		else if (HAVE_SIMPLE(msp))
 			msp->opmode = OPMODE_SIMPLE;
 		else
 			msp->opmode = OPMODE_MANUAL;
Index: linux-2.6.12-rc3/drivers/media/video/tvaudio.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/tvaudio.c	2005-04-26 12:25:43.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/tvaudio.c	2005-04-26 12:25:58.000000000 +0200
@@ -991,7 +991,7 @@ static int tda9874a_initialize(struct CH
 {
 	if (tda9874a_SIF > 2)
 		tda9874a_SIF = 1;
-	if (tda9874a_STD >= 8)
+	if (tda9874a_STD > 8)
 		tda9874a_STD = 0;
 	if(tda9874a_AMSEL > 1)
 		tda9874a_AMSEL = 0;

-- 
#define printk(args...) fprintf(stderr, ## args)

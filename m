Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVGXNqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVGXNqo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 09:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVGXNqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 09:46:44 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:28303 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261285AbVGXNql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 09:46:41 -0400
Message-ID: <42E39BB8.1040602@linuxtv.org>
Date: Sun, 24 Jul 2005 15:46:32 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------020901070408010709060308"
X-SA-Exim-Connect-IP: 84.137.135.76
Subject: [PATCH][V4L] fix tuning with MXB driver
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901070408010709060308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello Linus, Andrew,

I noticed that some past changes to the gerneric Video4Linux tuner
module for analog tuners broke my "Multimedia eXtension Board" driver.

The tuner driver was made aware of Video4Linux2 tuning ioctls, but my
driver was not ported and still uses the Video4Linux1 ioctls. This does
not work anymore as intendend, the tuning is currently broken.

The attached patch fixes non-working tuning in MXB driver introduced by
some recent generic tuner changes by replacing Video4Linux1 tuner ioctls
with proper Video4Linux2 tuner ioctls.

Please apply.

Thanks!
Michael.


--------------020901070408010709060308
Content-Type: text/x-patch;
 name="v4l2-mxb-tuning-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l2-mxb-tuning-fix.patch"

- fix non-working tuning in MXB driver introduced by some recent generic tuner changes
by replacing Video4Linux1 tuner ioctls with proper Video4Linux2 tuner ioctls

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -ura xx-linux-2.6.12.1/drivers/media/video/mxb.c linux-2.6.12.1/drivers/media/video/mxb.c
--- xx-linux-2.6.12.1/drivers/media/video/mxb.c	2005-07-24 13:00:17.000000000 +0200
+++ linux-2.6.12.1/drivers/media/video/mxb.c	2005-07-24 13:08:02.000000000 +0200
@@ -142,8 +142,8 @@
 
 	int	cur_mode;	/* current audio mode (mono, stereo, ...) */
 	int	cur_input;	/* current input */
-	int	cur_freq;	/* current frequency the tuner is tuned to */
 	int	cur_mute;	/* current mute status */
+	struct v4l2_frequency	cur_freq;	/* current frequency the tuner is tuned to */
 };
 
 static struct saa7146_extension extension;
@@ -349,8 +349,13 @@
 	mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_VBI_BYPASS, &i);
 
 	/* select a tuner type */
-	i = 5; 
+	i = TUNER_PHILIPS_PAL; 
 	mxb->tuner->driver->command(mxb->tuner,TUNER_SET_TYPE, &i);
+	/* tune in some frequency on tuner */
+	mxb->cur_freq.tuner = 0;
+	mxb->cur_freq.type = V4L2_TUNER_ANALOG_TV;
+	mxb->cur_freq.frequency = freq;
+	mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_FREQUENCY, &mxb->cur_freq);
 	
 	/* mute audio on tea6420s */
 	mxb->tea6420_1->driver->command(mxb->tea6420_1,TEA6420_SWITCH, &TEA6420_line[6][0]);
@@ -368,12 +373,8 @@
 	vm.out = 13;
 	mxb->tea6415c->driver->command(mxb->tea6415c,TEA6415C_SWITCH, &vm);
 				
-	/* tune in some frequency on tuner */
-	mxb->tuner->driver->command(mxb->tuner, VIDIOCSFREQ, &freq);
-
 	/* the rest for mxb */
 	mxb->cur_input = 0;
-	mxb->cur_freq = freq;
 	mxb->cur_mute = 1;
 
 	mxb->cur_mode = V4L2_TUNER_MODE_STEREO;
@@ -816,18 +817,14 @@
 			return -EINVAL;
 		}
 
-		memset(f,0,sizeof(*f));
-		f->type = V4L2_TUNER_ANALOG_TV;
-		f->frequency =  mxb->cur_freq;
+		*f = mxb->cur_freq;
 
-		DEB_EE(("VIDIOC_G_FREQ: freq:0x%08x.\n", mxb->cur_freq));
+		DEB_EE(("VIDIOC_G_FREQ: freq:0x%08x.\n", mxb->cur_freq.frequency));
 		return 0;
 	}
 	case VIDIOC_S_FREQUENCY:
 	{
 		struct v4l2_frequency *f = arg;
-		int t_locked = 0;
-		int v_byte = 0;
 
 		if (0 != f->tuner)
 			return -EINVAL;
@@ -840,20 +837,11 @@
 			return -EINVAL;
 		}
 
-		DEB_EE(("VIDIOC_S_FREQUENCY: freq:0x%08x.\n",f->frequency));
-
-		mxb->cur_freq = f->frequency;
+		mxb->cur_freq = *f;
+		DEB_EE(("VIDIOC_S_FREQUENCY: freq:0x%08x.\n", mxb->cur_freq.frequency));
 
 		/* tune in desired frequency */			
-		mxb->tuner->driver->command(mxb->tuner, VIDIOCSFREQ, &mxb->cur_freq);
-
-		/* check if pll of tuner & saa7111a is locked */
-//		mxb->tuner->driver->command(mxb->tuner,TUNER_IS_LOCKED, &t_locked);
-		mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_GET_STATUS, &v_byte);
-
-		/* not locked -- anything to do here ? */
-		if( 0 == t_locked || 0 == (v_byte & DECODER_STATUS_GOOD)) {
-		}
+		mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_FREQUENCY, &mxb->cur_freq);
 
 		/* hack: changing the frequency should invalidate the vbi-counter (=> alevt) */
 		spin_lock(&dev->slock);

--------------020901070408010709060308--

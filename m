Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWCLQhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWCLQhl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWCLQhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:37:41 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:59571 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750776AbWCLQhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:37:40 -0500
Message-ID: <44144E4D.1070806@linuxtv.org>
Date: Sun, 12 Mar 2006 17:37:33 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------050302050102060905030300"
X-SA-Exim-Connect-IP: 84.137.128.181
Subject: [PATCH] Restore tuning capabilities in V4L2 MXB driver
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050302050102060905030300
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello Linus,

the behaviour of the all-in-one Video4Linux tuner driver apparently
changed. It now wants to know the tv standard, otherwise it refuses to tune.

The attached patch restores tuning capabilities in my driver for the MXB
analog tv card.

Please apply.

Regards
Michael Hunold.

--------------050302050102060905030300
Content-Type: text/x-patch;
 name="v4l2-mxb-fix-video-standard.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l2-mxb-fix-video-standard.patch"

This patch restores tuning functionality in my driver for the
"Multimedia eXtension Board". The all-in-one tuner driver apparently
changed it's behaviour.

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -ura linux-2.6.15/drivers/media/video/mxb.c b/drivers/media/video/mxb.c
--- linux-2.6.15/drivers/media/video/mxb.c	2006-02-19 18:02:11.000000000 +0100
+++ b/drivers/media/video/mxb.c	2006-02-19 18:02:04.000000000 +0100
@@ -1,7 +1,7 @@
 /*
     mxb - v4l2 driver for the Multimedia eXtension Board
     
-    Copyright (C) 1998-2003 Michael Hunold <michael@mihu.de>
+    Copyright (C) 1998-2006 Michael Hunold <michael@mihu.de>
 
     Visit http://www.mihu.de/linux/saa7146/mxb/
     for further details about this card.
@@ -327,6 +327,7 @@
 	struct video_decoder_init init;
 	struct i2c_msg msg;
 	struct tuner_setup tun_setup;
+	v4l2_std_id std = V4L2_STD_PAL_BG;
 
 	int i = 0, err = 0;
 	struct	tea6415c_multiplex vm;	
@@ -361,6 +362,9 @@
 	mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_FREQUENCY,
 					&mxb->cur_freq);
 
+	/* set a default video standard */
+	mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_STD, &std);
+
 	/* mute audio on tea6420s */
 	mxb->tea6420_1->driver->command(mxb->tea6420_1,TEA6420_SWITCH, &TEA6420_line[6][0]);
 	mxb->tea6420_2->driver->command(mxb->tea6420_2,TEA6420_SWITCH, &TEA6420_line[6][1]);
@@ -921,17 +925,21 @@
 	int one = 1;
 
 	if(V4L2_STD_PAL_I == std->id ) {
+		v4l2_std_id std = V4L2_STD_PAL_I;
 		DEB_D(("VIDIOC_S_STD: setting mxb for PAL_I.\n"));
 		/* set the 7146 gpio register -- I don't know what this does exactly */
       		saa7146_write(dev, GPIO_CTRL, 0x00404050);
 		/* unset the 7111 gpio register -- I don't know what this does exactly */
 		mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_GPIO, &zero);
+		mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_STD, &std);
 	} else {
+		v4l2_std_id std = V4L2_STD_PAL_BG;
 		DEB_D(("VIDIOC_S_STD: setting mxb for PAL/NTSC/SECAM.\n"));
 		/* set the 7146 gpio register -- I don't know what this does exactly */
       		saa7146_write(dev, GPIO_CTRL, 0x00404050);
 		/* set the 7111 gpio register -- I don't know what this does exactly */
 		mxb->saa7111a->driver->command(mxb->saa7111a,DECODER_SET_GPIO, &one);
+		mxb->tuner->driver->command(mxb->tuner, VIDIOC_S_STD, &std);
 	}
 	return 0;
 }

--------------050302050102060905030300--

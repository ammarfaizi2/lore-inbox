Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUDEMA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUDEMA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:00:56 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:53152 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262142AbUDEMAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:00:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 13:50:21 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: msp3400 update
Message-ID: <20040405115021.GA29380@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch allows to use switch to the second external input of the
msp34xx chips.  Also has some minor cleanups and more verbose debug
info.

  Gerd

diff -up linux-2.6.5/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.5/drivers/media/video/msp3400.c	2004-04-05 10:41:39.035364070 +0200
+++ linux/drivers/media/video/msp3400.c	2004-04-05 10:49:57.633333893 +0200
@@ -738,7 +738,7 @@ autodetect_stereo(struct i2c_client *cli
 static int msp34xx_sleep(struct msp3400c *msp, int timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
-
+	
 	add_wait_queue(&msp->wq, &wait);
 	if (!msp->rmmod) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1384,34 +1384,30 @@ static int msp_command(struct i2c_client
 {
 	struct msp3400c *msp  = i2c_get_clientdata(client);
         __u16           *sarg = arg;
-#if 0
-	int             *iarg = (int*)arg;
-#endif
+	int scart = 0;
 
 	switch (cmd) {
 
 	case AUDC_SET_INPUT:
-		/* scart switching
-		     - IN1 is often used for external input
-		     - Hauppauge uses IN2 for the radio */
 		dprintk(KERN_DEBUG "msp34xx: AUDC_SET_INPUT(%d)\n",*sarg);
 		if (*sarg == msp->input)
 			break;
 		msp->input = *sarg;
 		switch (*sarg) {
 		case AUDIO_RADIO:
+			/* Hauppauge uses IN2 for the radio */
 			msp->mode   = MSP_MODE_FM_RADIO;
-			msp->stereo = VIDEO_SOUND_STEREO;
-			msp3400c_set_scart(client,SCART_IN2,0);
-			msp3400c_write(client,I2C_MSP3400C_DFP,0x000d,0x1900);
-			msp3400c_setstereo(client,msp->stereo);
+			scart       = SCART_IN2;
 			break;
-		case AUDIO_EXTERN:
+		case AUDIO_EXTERN_1:
+			/* IN1 is often used for external input ... */
 			msp->mode   = MSP_MODE_EXTERN;
-			msp->stereo = VIDEO_SOUND_STEREO;
-			msp3400c_set_scart(client,SCART_IN1,0);
-			msp3400c_write(client,I2C_MSP3400C_DFP,0x000d,0x1900);
-			msp3400c_setstereo(client,msp->stereo);
+			scart       = SCART_IN1;
+			break;
+		case AUDIO_EXTERN_2:
+			/* ... sometimes it is IN2 through ;) */
+			msp->mode   = MSP_MODE_EXTERN;
+			scart       = SCART_IN2;
 			break;
 		case AUDIO_TUNER:
 			msp->mode   = -1;
@@ -1422,6 +1418,12 @@ static int msp_command(struct i2c_client
 				msp3400c_set_scart(client,SCART_MUTE,0);
 			break;
 		}
+		if (scart) {
+			msp->stereo = VIDEO_SOUND_STEREO;
+			msp3400c_set_scart(client,scart,0);
+			msp3400c_write(client,I2C_MSP3400C_DFP,0x000d,0x1900);
+			msp3400c_setstereo(client,msp->stereo);
+		}
 		if (msp->active)
 			msp->restart = 1;
 		break;
@@ -1487,12 +1489,15 @@ static int msp_command(struct i2c_client
 		if (msp->muted)
 			va->flags |= VIDEO_AUDIO_MUTE;
 		va->volume=max(msp->left,msp->right);
-		va->balance=(32768*min(msp->left,msp->right))/
-			(va->volume ? va->volume : 1);
-		va->balance=(msp->left<msp->right)?
-			(65535-va->balance) : va->balance;
-		if (0 == va->volume)
+
+		if (0 == va->volume) {
 			va->balance = 32768;
+		} else {
+			va->balance = (32768 * min(msp->left,msp->right))
+				/ va->volume;
+			va->balance = (msp->left<msp->right) ?
+				(65535 - va->balance) : va->balance;
+		}
 		va->bass = msp->bass;
 		va->treble = msp->treble;
 
@@ -1530,7 +1535,7 @@ static int msp_command(struct i2c_client
 	{
 		struct video_channel *vc = arg;
 		
-		dprintk(KERN_DEBUG "msp34xx: VIDIOCSCHAN\n");
+		dprintk(KERN_DEBUG "msp34xx: VIDIOCSCHAN (norm=%d)\n",vc->norm);
 		msp->norm = vc->norm;
 		break;
 	}
diff -up linux-2.6.5/include/media/audiochip.h linux/include/media/audiochip.h
--- linux-2.6.5/include/media/audiochip.h	2004-04-05 10:39:42.491354773 +0200
+++ linux/include/media/audiochip.h	2004-04-05 10:49:57.644331820 +0200
@@ -15,6 +15,8 @@
 #define AUDIO_INTERN       0x03
 #define AUDIO_OFF          0x04 
 #define AUDIO_ON           0x05
+#define AUDIO_EXTERN_1     AUDIO_EXTERN
+#define AUDIO_EXTERN_2     0x06
 #define AUDIO_MUTE         0x80
 #define AUDIO_UNMUTE       0x81
 

-- 
http://bigendian.bytesex.org

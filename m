Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUFRJm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUFRJm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUFRJli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:41:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:10175 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265090AbUFRJkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:40:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:21:18 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: msp3400 cleanup.
Message-ID: <20040618092118.GA23871@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch has some cleanups for the msp3400 module:  Balance is used
directly now instead of maintaining the state as left/right volume and
calculate the balance from that.  The msp3400 did that only for
historical reasons and it isn't needed any more ...

Credits for that go to Perry Gilfillan.

please apply,

  Gerd

diff -up linux-2.6.7/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.7/drivers/media/video/msp3400.c	2004-06-17 10:29:44.000000000 +0200
+++ linux/drivers/media/video/msp3400.c	2004-06-17 13:47:59.065407892 +0200
@@ -51,6 +51,7 @@
 #include <asm/pgtable.h>
 
 #include <media/audiochip.h>
+#include <media/id.h>
 #include "msp3400.h"
 
 /* insmod parameters */
@@ -80,7 +81,7 @@ struct msp3400c {
 	int input;
 
 	int muted;
-	int left, right;	/* volume */
+	int volume, balance;
 	int bass, treble;
 
 	/* shadow register set */
@@ -378,26 +379,24 @@ static void msp3400c_setcarrier(struct i
 }
 
 static void msp3400c_setvolume(struct i2c_client *client,
-			       int muted, int left, int right)
+			       int muted, int volume, int balance)
 {
-	int vol = 0,val = 0,balance = 0;
+	int val = 0, bal = 0;
 
 	if (!muted) {
-		vol     = (left > right) ? left : right;
-		val     = (vol * 0x73 / 65535) << 8;
+		val = (volume * 0x73 / 65535) << 8;
 	}
-	if (vol > 0) {
-		balance = ((right-left) * 127) / vol;
+	if (val) {
+		bal = (balance / 256) - 128;
 	}
-
 	dprintk(KERN_DEBUG
 		"msp34xx: setvolume: mute=%s %d:%d  v=0x%02x b=0x%02x\n",
-		muted ? "on" : "off", left, right, val>>8, balance);
+		muted ? "on" : "off", volume, balance, val>>8, bal);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0000, val); /* loudspeaker */
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0006, val); /* headphones  */
 	/* scart - on/off only */
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0007, val ? 0x4000 : 0);
-	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0001, balance << 8);
+	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0001, bal << 8);
 }
 
 static void msp3400c_setbass(struct i2c_client *client, int bass)
@@ -738,7 +737,7 @@ autodetect_stereo(struct i2c_client *cli
 static int msp34xx_sleep(struct msp3400c *msp, int timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
-
+	
 	add_wait_queue(&msp->wq, &wait);
 	if (!msp->rmmod) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -815,7 +814,7 @@ static int msp3400c_thread(void *data)
 			/* no carrier scan, just unmute */
 			printk("msp3400: thread: no carrier scan\n");
 			msp3400c_setvolume(client, msp->muted,
-					   msp->left, msp->right);
+					   msp->volume, msp->balance);
 			continue;
 		}
 		msp->restart = 0;
@@ -960,7 +959,8 @@ static int msp3400c_thread(void *data)
 		}
 
 		/* unmute + restore dfp registers */
-		msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
+		msp3400c_setvolume(client, msp->muted,
+				   msp->volume, msp->balance);
 		msp3400c_restore_dfp(client);
 
 		if (msp->watch_stereo)
@@ -1042,7 +1042,7 @@ static int msp3410d_thread(void *data)
 			/* no carrier scan needed, just unmute */
 			dprintk(KERN_DEBUG "msp3410: thread: no carrier scan\n");
 			msp3400c_setvolume(client, msp->muted,
-					   msp->left, msp->right);
+					   msp->volume, msp->balance);
 			continue;
 		}
 		msp->restart = 0;
@@ -1194,7 +1194,8 @@ static int msp3410d_thread(void *data)
 		/* unmute + restore dfp registers */
 		msp3400c_setbass(client, msp->bass);
 		msp3400c_settreble(client, msp->treble);
-		msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
+		msp3400c_setvolume(client, msp->muted,
+				    msp->volume, msp->balance);
 		msp3400c_restore_dfp(client);
 
 		if (msp->watch_stereo)
@@ -1257,8 +1258,8 @@ static int msp_attach(struct i2c_adapter
 	}
 	
 	memset(msp,0,sizeof(struct msp3400c));
-	msp->left   = 65535;
-	msp->right  = 65535;
+	msp->volume = 65535;
+	msp->balance = 32768;
 	msp->bass   = 32768;
 	msp->treble = 32768;
 	msp->input  = -1;
@@ -1290,7 +1291,7 @@ static int msp_attach(struct i2c_adapter
 	/* this will turn on a 1kHz beep - might be useful for debugging... */
 	msp3400c_write(c,I2C_MSP3400C_DFP, 0x0014, 0x1040);
 #endif
-	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
+	msp3400c_setvolume(c, msp->muted, msp->volume, msp->balance);
 
 	snprintf(c->name, sizeof(c->name), "MSP34%02d%c-%c%d",
 		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
@@ -1440,8 +1441,10 @@ static int msp_command(struct i2c_client
 		} else {
 			/* set msp3400 to FM radio mode */
 			msp3400c_setmode(client,MSP_MODE_FM_RADIO);
-			msp3400c_setcarrier(client, MSP_CARRIER(10.7),MSP_CARRIER(10.7));
-			msp3400c_setvolume(client,msp->muted,msp->left,msp->right);			
+			msp3400c_setcarrier(client, MSP_CARRIER(10.7),
+					    MSP_CARRIER(10.7));
+			msp3400c_setvolume(client, msp->muted,
+					   msp->volume, msp->balance);	
 		}
 		if (msp->active)
 			msp->restart = 1;
@@ -1488,16 +1491,9 @@ static int msp_command(struct i2c_client
 			VIDEO_AUDIO_MUTABLE;
 		if (msp->muted)
 			va->flags |= VIDEO_AUDIO_MUTE;
-		va->volume=max(msp->left,msp->right);
 
-		if (0 == va->volume) {
-			va->balance = 32768;
-		} else {
-			va->balance = (32768 * min(msp->left,msp->right))
-				/ va->volume;
-			va->balance = (msp->left<msp->right) ?
-				(65535 - va->balance) : va->balance;
-		}
+		va->volume = msp->volume;
+		va->balance = (va->volume) ? msp->balance : 32768;
 		va->bass = msp->bass;
 		va->treble = msp->treble;
 
@@ -1513,13 +1509,13 @@ static int msp_command(struct i2c_client
 
 		dprintk(KERN_DEBUG "msp34xx: VIDIOCSAUDIO\n");
 		msp->muted = (va->flags & VIDEO_AUDIO_MUTE);
-		msp->left = (min(65536 - va->balance,32768) *
-			     va->volume) / 32768;
-		msp->right = (min(va->balance,(__u16)32768) *
-			      va->volume) / 32768;
+		msp->volume = va->volume;
+		msp->balance = va->balance;
 		msp->bass = va->bass;
 		msp->treble = va->treble;
-		msp3400c_setvolume(client,msp->muted,msp->left,msp->right);
+
+		msp3400c_setvolume(client, msp->muted,
+				   msp->volume, msp->balance);
 		msp3400c_setbass(client,msp->bass);
 		msp3400c_settreble(client,msp->treble);
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271285AbUJVNHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271285AbUJVNHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271269AbUJVNHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:07:06 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:2993 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271319AbUJVNAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:00:34 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 22 Oct 2004 14:51:19 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: msp3400 update
Message-ID: <20041022125119.GA5387@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the msp3400 module.  Changes:

 * switch over to 2.6-ish insmod options.
 * use kthread for thread management.
 * add support for v4l2 audio ioctls.
 * merge a number of changes from the ivtv project.
 * add suspend/resume functions.

The patch also removes all trailing whitespaces.  I've a script
to remove them from my sources now, that should kill those no-op
whitespace changes in my patches after merging this initial cleanup.

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/msp3400.c | 1040 +++++++++++++++++++++-------------
 drivers/media/video/msp3400.h |   22 
 2 files changed, 690 insertions(+), 372 deletions(-)

diff -u linux-2.6.9/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.9/drivers/media/video/msp3400.c	2004-10-21 11:44:41.000000000 +0200
+++ linux/drivers/media/video/msp3400.c	2004-10-21 14:57:52.547496066 +0200
@@ -47,6 +47,8 @@
 #include <linux/videodev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/kthread.h>
+#include <linux/suspend.h>
 #include <asm/semaphore.h>
 #include <asm/pgtable.h>
 
@@ -54,54 +56,53 @@
 #include <media/id.h>
 #include "msp3400.h"
 
+#define OPMODE_AUTO    -1
+#define OPMODE_MANUAL   0
+#define OPMODE_SIMPLE   1   /* use short programming (>= msp3410 only) */
+#define OPMODE_SIMPLER  2   /* use shorter programming (>= msp34xxG)   */
+
 /* insmod parameters */
+static int opmode   = OPMODE_AUTO;
 static int debug    = 0;    /* debug output */
 static int once     = 0;    /* no continous stereo monitoring */
 static int amsound  = 0;    /* hard-wire AM sound at 6.5 Hz (france),
-			      the autoscan seems work well only with FM... */
-static int simple   = -1;   /* use short programming (>= msp3410 only) */
+			       the autoscan seems work well only with FM... */
+static int standard = 1;    /* Override auto detect of audio standard, if needed. */
 static int dolby    = 0;
 
-#define DFP_COUNT 0x41
-static const int bl_dfp[] = {
-	0x00, 0x01, 0x02, 0x03,  0x06, 0x08, 0x09, 0x0a,
-	0x0b, 0x0d, 0x0e, 0x10
-};
+static int stereo_threshold = 0x190; /* a2 threshold for stereo/bilingual
+					(msp34xxg only) 0x00a0-0x03c0 */
 
 struct msp3400c {
 	int rev1,rev2;
-	
-	int simple;
+
+	int opmode;
 	int mode;
 	int norm;
-	int stereo;
 	int nicam_on;
 	int acb;
 	int main, second;	/* sound carrier */
 	int input;
+	int source;             /* see msp34xxg_set_source */
+
+	/* v4l2 */
+	int audmode;
+	int rxsubchans;
 
 	int muted;
 	int volume, balance;
 	int bass, treble;
 
-	/* shadow register set */
-	int dfp_regs[DFP_COUNT];
-
 	/* thread */
-	pid_t                tpid;
-	struct completion    texit;
+	struct task_struct   *kthread;
 	wait_queue_head_t    wq;
-
-	int                  active:1;
 	int                  restart:1;
-	int                  rmmod:1;
-
-	int                  watch_stereo;
-	struct timer_list    wake_stereo;
+	int                  watch_stereo:1;
 };
 
 #define HAVE_NICAM(msp)   (((msp->rev2>>8) & 0xff) != 00)
 #define HAVE_SIMPLE(msp)  ((msp->rev1      & 0xff) >= 'D'-'@')
+#define HAVE_SIMPLER(msp) ((msp->rev1      & 0xff) >= 'G'-'@')
 #define HAVE_RADIO(msp)   ((msp->rev1      & 0xff) >= 'G'-'@')
 
 #define VIDEO_MODE_RADIO 16      /* norm magic for radio mode */
@@ -111,11 +112,21 @@
 #define dprintk      if (debug >= 1) printk
 #define d2printk     if (debug >= 2) printk
 
-MODULE_PARM(once,"i");
-MODULE_PARM(debug,"i");
-MODULE_PARM(simple,"i");
-MODULE_PARM(amsound,"i");
-MODULE_PARM(dolby,"i");
+/* read-only */
+module_param(opmode,           int, 0444);
+
+/* read-write */
+module_param(once,             int, 0644);
+module_param(debug,            int, 0644);
+module_param(stereo_threshold, int, 0644);
+module_param(standard,         int, 0644);
+module_param(amsound,          int, 0644);
+module_param(dolby,            int, 0644);
+
+MODULE_PARM_DESC(once, "No continuous stereo monitoring");
+MODULE_PARM_DESC(debug, "Enable debug messages");
+MODULE_PARM_DESC(standard, "Specify audio standard: 32 = NTSC, 64 = radio, Default: Autodetect");
+MODULE_PARM_DESC(amsound, "Hardwire AM sound at 6.5Hz (France), FM can autoscan");
 
 MODULE_DESCRIPTION("device driver for msp34xx TV sound processor");
 MODULE_AUTHOR("Gerd Knorr");
@@ -141,10 +152,6 @@
 /* ----------------------------------------------------------------------- */
 /* functions for talking to the MSP3400C Sound processor                   */
 
-#ifndef I2C_M_IGNORE_NAK
-# define I2C_M_IGNORE_NAK 0x1000
-#endif
-
 static int msp3400c_reset(struct i2c_client *client)
 {
 	/* reset and read revision code */
@@ -160,14 +167,14 @@
 		{ client->addr, 0,        3, write },
 		{ client->addr, I2C_M_RD, 2, read  },
 	};
-	
+
 	if ( (1 != i2c_transfer(client->adapter,&reset[0],1)) ||
 	     (1 != i2c_transfer(client->adapter,&reset[1],1)) ||
 	     (2 != i2c_transfer(client->adapter,test,2)) ) {
 		printk(KERN_ERR "msp3400: chip reset failed\n");
 		return -1;
         }
-	return 0; 
+	return 0;
 }
 
 static int
@@ -198,7 +205,7 @@
 		msp3400c_reset(client);
 		return -1;
 	}
-        return read[0] << 8 | read[1];
+	return read[0] << 8 | read[1];
 }
 
 static int
@@ -303,15 +310,15 @@
 
 static struct CARRIER_DETECT carrier_detect_main[] = {
 	/* main carrier */
-	{ MSP_CARRIER(4.5),        "4.5   NTSC"                   }, 
-	{ MSP_CARRIER(5.5),        "5.5   PAL B/G"                }, 
+	{ MSP_CARRIER(4.5),        "4.5   NTSC"                   },
+	{ MSP_CARRIER(5.5),        "5.5   PAL B/G"                },
 	{ MSP_CARRIER(6.0),        "6.0   PAL I"                  },
 	{ MSP_CARRIER(6.5),        "6.5   PAL D/K + SAT + SECAM"  }
 };
 
 static struct CARRIER_DETECT carrier_detect_55[] = {
 	/* PAL B/G */
-	{ MSP_CARRIER(5.7421875),  "5.742 PAL B/G FM-stereo"     }, 
+	{ MSP_CARRIER(5.7421875),  "5.742 PAL B/G FM-stereo"     },
 	{ MSP_CARRIER(5.85),       "5.85  PAL B/G NICAM"         }
 };
 
@@ -329,16 +336,6 @@
 
 /* ----------------------------------------------------------------------- */
 
-#define SCART_MASK    0
-#define SCART_IN1     1
-#define SCART_IN2     2
-#define SCART_IN1_DA  3
-#define SCART_IN2_DA  4
-#define SCART_IN3     5
-#define SCART_IN4     6
-#define SCART_MONO    7
-#define SCART_MUTE    8
-
 static int scarts[3][9] = {
   /* MASK    IN1     IN2     IN1_DA  IN2_DA  IN3     IN4     MONO    MUTE   */
   {  0x0320, 0x0000, 0x0200, -1,     -1,     0x0300, 0x0020, 0x0100, 0x0320 },
@@ -392,8 +389,8 @@
 		muted ? "on" : "off", volume, balance, val>>8, bal);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0000, val); /* loudspeaker */
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0006, val); /* headphones  */
-	/* scart - on/off only */
-	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0007, val ? 0x4000 : 0);
+	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0007,
+		       muted ? 0x01 : (val | 0x01));
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0001, bal << 8);
 }
 
@@ -417,31 +414,32 @@
 {
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int i;
-	
+
 	dprintk(KERN_DEBUG "msp3400: setmode: %d\n",type);
-	msp->mode   = type;
-	msp->stereo = VIDEO_SOUND_MONO;
+	msp->mode       = type;
+	msp->audmode    = V4L2_TUNER_MODE_MONO;
+	msp->rxsubchans = V4L2_TUNER_SUB_MONO;
 
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x00bb,          /* ad_cv */
 		       msp_init_data[type].ad_cv);
-    
+
 	for (i = 5; i >= 0; i--)                                   /* fir 1 */
 		msp3400c_write(client,I2C_MSP3400C_DEM, 0x0001,
 			       msp_init_data[type].fir1[i]);
-    
+
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x0005, 0x0004); /* fir 2 */
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x0005, 0x0040);
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x0005, 0x0000);
 	for (i = 5; i >= 0; i--)
 		msp3400c_write(client,I2C_MSP3400C_DEM, 0x0005,
 			       msp_init_data[type].fir2[i]);
-    
+
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x0083,     /* MODE_REG */
 		       msp_init_data[type].mode_reg);
-    
+
 	msp3400c_setcarrier(client, msp_init_data[type].cdo1,
 			    msp_init_data[type].cdo2);
-    
+
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x0056, 0); /*LOAD_REG_1/2*/
 
 	if (dolby) {
@@ -470,51 +468,67 @@
 	}
 }
 
+static int best_audio_mode(int rxsubchans)
+{
+	if (rxsubchans & V4L2_TUNER_SUB_STEREO)
+		return V4L2_TUNER_MODE_STEREO;
+	if (rxsubchans & V4L2_TUNER_SUB_LANG1)
+		return V4L2_TUNER_MODE_LANG1;
+	if (rxsubchans & V4L2_TUNER_SUB_LANG2)
+		return V4L2_TUNER_MODE_LANG2;
+	return V4L2_TUNER_MODE_MONO;
+}
+
 /* turn on/off nicam + stereo */
-static void msp3400c_setstereo(struct i2c_client *client, int mode)
+static void msp3400c_set_audmode(struct i2c_client *client, int audmode)
 {
 	static char *strmode[16] = {
 #if __GNUC__ >= 3
-		[ 0 ... 15 ]           = "invalid",
+		[ 0 ... 15 ]               = "invalid",
 #endif
-		[ VIDEO_SOUND_MONO ]   = "mono",
-		[ VIDEO_SOUND_STEREO ] = "stereo",
-		[ VIDEO_SOUND_LANG1  ] = "lang1",
-		[ VIDEO_SOUND_LANG2  ] = "lang2",
+		[ V4L2_TUNER_MODE_MONO   ] = "mono",
+		[ V4L2_TUNER_MODE_STEREO ] = "stereo",
+		[ V4L2_TUNER_MODE_LANG1  ] = "lang1",
+		[ V4L2_TUNER_MODE_LANG2  ] = "lang2",
 	};
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int nicam=0; /* channel source: FM/AM or nicam */
 	int src=0;
 
+	BUG_ON(msp->opmode == OPMODE_SIMPLER);
+	msp->audmode = audmode;
+
 	/* switch demodulator */
 	switch (msp->mode) {
 	case MSP_MODE_FM_TERRA:
-		dprintk(KERN_DEBUG "msp3400: FM setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: FM setstereo: %s\n",
+			strmode[audmode]);
 		msp3400c_setcarrier(client,msp->second,msp->main);
-		switch (mode) {
-		case VIDEO_SOUND_STEREO:
+		switch (audmode) {
+		case V4L2_TUNER_MODE_STEREO:
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x000e, 0x3001);
 			break;
-		case VIDEO_SOUND_MONO:
-		case VIDEO_SOUND_LANG1:
-		case VIDEO_SOUND_LANG2:
+		case V4L2_TUNER_MODE_MONO:
+		case V4L2_TUNER_MODE_LANG1:
+		case V4L2_TUNER_MODE_LANG2:
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x000e, 0x3000);
 			break;
 		}
 		break;
 	case MSP_MODE_FM_SAT:
-		dprintk(KERN_DEBUG "msp3400: SAT setstereo: %s\n",strmode[mode]);
-		switch (mode) {
-		case VIDEO_SOUND_MONO:
+		dprintk(KERN_DEBUG "msp3400: SAT setstereo: %s\n",
+			strmode[audmode]);
+		switch (audmode) {
+		case V4L2_TUNER_MODE_MONO:
 			msp3400c_setcarrier(client, MSP_CARRIER(6.5), MSP_CARRIER(6.5));
 			break;
-		case VIDEO_SOUND_STEREO:
+		case V4L2_TUNER_MODE_STEREO:
 			msp3400c_setcarrier(client, MSP_CARRIER(7.2), MSP_CARRIER(7.02));
 			break;
-		case VIDEO_SOUND_LANG1:
+		case V4L2_TUNER_MODE_LANG1:
 			msp3400c_setcarrier(client, MSP_CARRIER(7.38), MSP_CARRIER(7.02));
 			break;
-		case VIDEO_SOUND_LANG2:
+		case V4L2_TUNER_MODE_LANG2:
 			msp3400c_setcarrier(client, MSP_CARRIER(7.38), MSP_CARRIER(7.02));
 			break;
 		}
@@ -522,21 +536,25 @@
 	case MSP_MODE_FM_NICAM1:
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
-		dprintk(KERN_DEBUG "msp3400: NICAM setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: NICAM setstereo: %s\n",
+			strmode[audmode]);
 		msp3400c_setcarrier(client,msp->second,msp->main);
 		if (msp->nicam_on)
 			nicam=0x0100;
 		break;
 	case MSP_MODE_BTSC:
-		dprintk(KERN_DEBUG "msp3400: BTSC setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: BTSC setstereo: %s\n",
+			strmode[audmode]);
 		nicam=0x0300;
 		break;
 	case MSP_MODE_EXTERN:
-		dprintk(KERN_DEBUG "msp3400: extern setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: extern setstereo: %s\n",
+			strmode[audmode]);
 		nicam = 0x0200;
 		break;
 	case MSP_MODE_FM_RADIO:
-		dprintk(KERN_DEBUG "msp3400: FM-Radio setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: FM-Radio setstereo: %s\n",
+			strmode[audmode]);
 		break;
 	default:
 		dprintk(KERN_DEBUG "msp3400: mono setstereo\n");
@@ -544,15 +562,15 @@
 	}
 
 	/* switch audio */
-	switch (mode) {
-	case VIDEO_SOUND_STEREO:
+	switch (audmode) {
+	case V4L2_TUNER_MODE_STEREO:
 		src = 0x0020 | nicam;
-#if 0 
+#if 0
 		/* spatial effect */
 		msp3400c_write(client,I2C_MSP3400C_DFP, 0x0005,0x4000);
 #endif
 		break;
-	case VIDEO_SOUND_MONO:
+	case V4L2_TUNER_MODE_MONO:
 		if (msp->mode == MSP_MODE_AM_NICAM) {
 			dprintk("msp3400: switching to AM mono\n");
 			/* AM mono decoding is handled by tuner, not MSP chip */
@@ -561,10 +579,10 @@
 			src = 0x0200;
 			break;
 		}
-	case VIDEO_SOUND_LANG1:
+	case V4L2_TUNER_MODE_LANG1:
 		src = 0x0000 | nicam;
 		break;
-	case VIDEO_SOUND_LANG2:
+	case V4L2_TUNER_MODE_LANG2:
 		src = 0x0010 | nicam;
 		break;
 	}
@@ -608,19 +626,6 @@
 	}
 }
 
-static void
-msp3400c_restore_dfp(struct i2c_client *client)
-{
-	struct msp3400c *msp = i2c_get_clientdata(client);
-	int i;
-
-	for (i = 0; i < DFP_COUNT; i++) {
-		if (-1 == msp->dfp_regs[i])
-			continue;
-		msp3400c_write(client,I2C_MSP3400C_DFP, i, msp->dfp_regs[i]);
-	}
-}
-
 /* ----------------------------------------------------------------------- */
 
 struct REGISTER_DUMP {
@@ -641,8 +646,8 @@
 {
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int val;
-	int newstereo = msp->stereo;
-	int newnicam  = msp->nicam_on;
+	int rxsubchans = msp->rxsubchans;
+	int newnicam   = msp->nicam_on;
 	int update = 0;
 
 	switch (msp->mode) {
@@ -653,11 +658,11 @@
 		dprintk(KERN_DEBUG
 			"msp34xx: stereo detect register: %d\n",val);
 		if (val > 4096) {
-			newstereo = VIDEO_SOUND_STEREO | VIDEO_SOUND_MONO;
+			rxsubchans = V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
 		} else if (val < -4096) {
-			newstereo = VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
+			rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 		} else {
-			newstereo = VIDEO_SOUND_MONO;
+			rxsubchans = V4L2_TUNER_SUB_MONO;
 		}
 		newnicam = 0;
 		break;
@@ -674,27 +679,27 @@
 			switch ((val & 0x1e) >> 1)  {
 			case 0:
 			case 8:
-				newstereo = VIDEO_SOUND_STEREO;
+				rxsubchans = V4L2_TUNER_SUB_STEREO;
 				break;
 			case 1:
 			case 9:
-				newstereo = VIDEO_SOUND_MONO
-					| VIDEO_SOUND_LANG1;
+				rxsubchans = V4L2_TUNER_SUB_MONO
+					| V4L2_TUNER_SUB_LANG1;
 				break;
 			case 2:
 			case 10:
-				newstereo = VIDEO_SOUND_MONO
-					| VIDEO_SOUND_LANG1
-					| VIDEO_SOUND_LANG2;
+				rxsubchans = V4L2_TUNER_SUB_MONO
+					| V4L2_TUNER_SUB_LANG1
+					| V4L2_TUNER_SUB_LANG2;
 				break;
 			default:
-				newstereo = VIDEO_SOUND_MONO;
+				rxsubchans = V4L2_TUNER_SUB_MONO;
 				break;
 			}
 			newnicam=1;
 		} else {
 			newnicam = 0;
-			newstereo = VIDEO_SOUND_MONO;
+			rxsubchans = V4L2_TUNER_SUB_MONO;
 		}
 		break;
 	case MSP_MODE_BTSC:
@@ -707,16 +712,16 @@
 			(val & 0x0040) ? "stereo" : "mono",
 			(val & 0x0080) ? ", nicam 2nd mono" : "",
 			(val & 0x0100) ? ", bilingual/SAP"  : "");
-		newstereo = VIDEO_SOUND_MONO;
-		if (val & 0x0040) newstereo |= VIDEO_SOUND_STEREO;
-		if (val & 0x0100) newstereo |= VIDEO_SOUND_LANG1;
+		rxsubchans = V4L2_TUNER_SUB_MONO;
+		if (val & 0x0040) rxsubchans |= V4L2_TUNER_SUB_STEREO;
+		if (val & 0x0100) rxsubchans |= V4L2_TUNER_SUB_LANG1;
 		break;
 	}
-	if (newstereo != msp->stereo) {
+	if (rxsubchans != msp->rxsubchans) {
 		update = 1;
-		dprintk(KERN_DEBUG "msp34xx: watch: stereo %d => %d\n",
-			msp->stereo,newstereo);
-		msp->stereo   = newstereo;
+		dprintk(KERN_DEBUG "msp34xx: watch: rxsubchans %d => %d\n",
+			msp->rxsubchans,rxsubchans);
+		msp->rxsubchans = rxsubchans;
 	}
 	if (newnicam != msp->nicam_on) {
 		update = 1;
@@ -737,22 +742,24 @@
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue(&msp->wq, &wait);
-	if (!msp->rmmod) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (timeout < 0)
+	if (!kthread_should_stop()) {
+		if (timeout < 0) {
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
-		else
-			schedule_timeout(timeout);
+		} else {
+#if 0
+			/* hmm, that one doesn't return on wakeup ... */
+			msleep_interruptible(timeout);
+#else
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(msecs_to_jiffies(timeout));
+#endif
+		}
 	}
+	if (current->flags & PF_FREEZE)
+		refrigerator(PF_FREEZE);
 	remove_wait_queue(&msp->wq, &wait);
-	return msp->rmmod || signal_pending(current);
-}
-
-static void msp3400c_stereo_wake(unsigned long data)
-{
-	struct msp3400c *msp = (struct msp3400c*)data;   /* XXX alpha ??? */
-
-	wake_up_interruptible(&msp->wq);
+	return msp->restart;
 }
 
 /* stereo/multilang monitoring */
@@ -760,53 +767,31 @@
 {
 	struct msp3400c *msp = i2c_get_clientdata(client);
 
-	if (autodetect_stereo(client)) {
-		if (msp->stereo & VIDEO_SOUND_STEREO)
-			msp3400c_setstereo(client,VIDEO_SOUND_STEREO);
-		else if (msp->stereo & VIDEO_SOUND_LANG1)
-			msp3400c_setstereo(client,VIDEO_SOUND_LANG1);
-		else if (msp->stereo & VIDEO_SOUND_LANG2)
-			msp3400c_setstereo(client,VIDEO_SOUND_LANG2);
-		else
-			msp3400c_setstereo(client,VIDEO_SOUND_MONO);
-	}
+	if (autodetect_stereo(client))
+		msp3400c_set_audmode(client,best_audio_mode(msp->rxsubchans));
 	if (once)
 		msp->watch_stereo = 0;
-	if (msp->watch_stereo)
-		mod_timer(&msp->wake_stereo, jiffies+5*HZ);
 }
 
 static int msp3400c_thread(void *data)
 {
 	struct i2c_client *client = data;
 	struct msp3400c *msp = i2c_get_clientdata(client);
-	
 	struct CARRIER_DETECT *cd;
 	int count, max1,max2,val1,val2, val,this;
-	
-	daemonize("msp3400");
-	allow_signal(SIGTERM);
-	printk("msp3400: daemon started\n");
 
+	printk("msp3400: kthread started\n");
 	for (;;) {
 		d2printk("msp3400: thread: sleep\n");
-		if (msp34xx_sleep(msp,-1))
-			goto done;
-
+		msp34xx_sleep(msp,-1);
 		d2printk("msp3400: thread: wakeup\n");
-		msp->active = 1;
 
-		if (msp->watch_stereo) {
-			watch_stereo(client);
-			msp->active = 0;
-			continue;
-		}
-
-		/* some time for the tuner to sync */
-		if (msp34xx_sleep(msp,HZ/5))
-			goto done;
-		
 	restart:
+		dprintk("msp3410: thread: restart scan\n");
+		msp->restart = 0;
+		if (kthread_should_stop())
+			break;
+
 		if (VIDEO_MODE_RADIO == msp->norm ||
 		    MSP_MODE_EXTERN  == msp->mode) {
 			/* no carrier scan, just unmute */
@@ -815,14 +800,18 @@
 					   msp->volume, msp->balance);
 			continue;
 		}
-		msp->restart = 0;
+
+		/* mute */
 		msp3400c_setvolume(client, msp->muted, 0, 0);
 		msp3400c_setmode(client, MSP_MODE_AM_DETECT /* +1 */ );
 		val1 = val2 = 0;
 		max1 = max2 = -1;
-		del_timer(&msp->wake_stereo);
 		msp->watch_stereo = 0;
 
+		/* some time for the tuner to sync */
+		if (msp34xx_sleep(msp,200))
+			goto restart;
+
 		/* carrier detect pass #1 -- main carrier */
 		cd = carrier_detect_main; count = CARRIER_COUNT(carrier_detect_main);
 
@@ -835,12 +824,8 @@
 
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
-
-			if (msp34xx_sleep(msp,HZ/10))
-				goto done;
-			if (msp->restart)
-				msp->restart = 0;
-
+			if (msp34xx_sleep(msp,100))
+				goto restart;
 			val = msp3400c_read(client, I2C_MSP3400C_DFP, 0x1b);
 			if (val > 32767)
 				val -= 65536;
@@ -848,14 +833,16 @@
 				val1 = val, max1 = this;
 			dprintk("msp3400: carrier1 val: %5d / %s\n", val,cd[this].name);
 		}
-	
+
 		/* carrier detect pass #2 -- second (stereo) carrier */
 		switch (max1) {
 		case 1: /* 5.5 */
-			cd = carrier_detect_55; count = CARRIER_COUNT(carrier_detect_55);
+			cd = carrier_detect_55;
+			count = CARRIER_COUNT(carrier_detect_55);
 			break;
 		case 3: /* 6.5 */
-			cd = carrier_detect_65; count = CARRIER_COUNT(carrier_detect_65);
+			cd = carrier_detect_65;
+			count = CARRIER_COUNT(carrier_detect_65);
 			break;
 		case 0: /* 4.5 */
 		case 2: /* 6.0 */
@@ -863,19 +850,15 @@
 			cd = NULL; count = 0;
 			break;
 		}
-		
+
 		if (amsound && (msp->norm == VIDEO_MODE_SECAM)) {
 			/* autodetect doesn't work well with AM ... */
 			cd = NULL; count = 0; max2 = 0;
 		}
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
-
-			if (msp34xx_sleep(msp,HZ/10))
-				goto done;
-			if (msp->restart)
+			if (msp34xx_sleep(msp,100))
 				goto restart;
-
 			val = msp3400c_read(client, I2C_MSP3400C_DFP, 0x1b);
 			if (val > 32767)
 				val -= 65536;
@@ -893,7 +876,7 @@
 				msp->second = carrier_detect_55[max2].cdo;
 				msp3400c_setmode(client, MSP_MODE_FM_TERRA);
 				msp->nicam_on = 0;
-				msp3400c_setstereo(client, VIDEO_SOUND_MONO);
+				msp3400c_set_audmode(client, V4L2_TUNER_MODE_MONO);
 				msp->watch_stereo = 1;
 			} else if (max2 == 1 && HAVE_NICAM(msp)) {
 				/* B/G NICAM */
@@ -920,7 +903,7 @@
 				msp->second = carrier_detect_65[max2].cdo;
 				msp3400c_setmode(client, MSP_MODE_FM_TERRA);
 				msp->nicam_on = 0;
-				msp3400c_setstereo(client, VIDEO_SOUND_MONO);
+				msp3400c_set_audmode(client, V4L2_TUNER_MODE_MONO);
 				msp->watch_stereo = 1;
 			} else if (max2 == 0 &&
 				   msp->norm == VIDEO_MODE_SECAM) {
@@ -928,7 +911,7 @@
 				msp->second = carrier_detect_65[max2].cdo;
 				msp3400c_setmode(client, MSP_MODE_AM_NICAM);
 				msp->nicam_on = 0;
-				msp3400c_setstereo(client, VIDEO_SOUND_MONO);
+				msp3400c_set_audmode(client, V4L2_TUNER_MODE_MONO);
 				msp3400c_setcarrier(client, msp->second, msp->main);
 				/* volume prescale for SCART (AM mono input) */
 				msp3400c_write(client,I2C_MSP3400C_DFP, 0x000d, 0x1900);
@@ -951,29 +934,26 @@
 			msp3400c_setmode(client, MSP_MODE_FM_TERRA);
 			msp->nicam_on = 0;
 			msp3400c_setcarrier(client, msp->second, msp->main);
-			msp->stereo = VIDEO_SOUND_MONO;
-			msp3400c_setstereo(client, VIDEO_SOUND_MONO);
+			msp->rxsubchans = V4L2_TUNER_SUB_MONO;
+			msp3400c_set_audmode(client, V4L2_TUNER_MODE_MONO);
 			break;
 		}
 
-		/* unmute + restore dfp registers */
+		/* unmute */
 		msp3400c_setvolume(client, msp->muted,
 				   msp->volume, msp->balance);
-		msp3400c_restore_dfp(client);
-
-		if (msp->watch_stereo)
-			mod_timer(&msp->wake_stereo, jiffies+5*HZ);
-
 		if (debug)
 			msp3400c_print_mode(msp);
-		
-		msp->active = 0;
-	}
 
-done:
-	msp->active = 0;
+		/* monitor tv audio mode */
+		while (msp->watch_stereo) {
+			if (msp34xx_sleep(msp,5000))
+				goto restart;
+			watch_stereo(client);
+		}
+	}
 	dprintk(KERN_DEBUG "msp3400: thread: exit\n");
-        complete_and_exit(&msp->texit, 0);
+	return 0;
 }
 
 /* ----------------------------------------------------------------------- */
@@ -1006,36 +986,68 @@
 	{ 0x0060, MSP_CARRIER(7.2), MSP_CARRIER(7.2), "7.2  SAT ADR" },
 	{     -1, 0, 0, NULL }, /* EOF */
 };
- 
+
+static inline const char *msp34xx_standard_mode_name(int mode)
+{
+	int i;
+	for (i = 0; modelist[i].name != NULL; i++)
+		if (modelist[i].retval == mode)
+			return modelist[i].name;
+	return "unknown";
+}
+
+static int msp34xx_modus(int norm)
+{
+	switch (norm) {
+	case VIDEO_MODE_PAL:
+		return 0x1003;
+	case VIDEO_MODE_NTSC:  /* BTSC */
+		return 0x2003;
+	case VIDEO_MODE_SECAM:
+		return 0x0003;
+	case VIDEO_MODE_RADIO:
+		return 0x0003;
+	case VIDEO_MODE_AUTO:
+		return 0x2003;
+	default:
+		return 0x0003;
+	}
+}
+
+static int msp34xx_standard(int norm)
+{
+	switch (norm) {
+	case VIDEO_MODE_PAL:
+		return 1;
+	case VIDEO_MODE_NTSC:  /* BTSC */
+		return 0x0020;
+	case VIDEO_MODE_SECAM:
+		return 1;
+	case VIDEO_MODE_RADIO:
+		return 0x0040;
+	default:
+		return 1;
+	}
+}
+
 static int msp3410d_thread(void *data)
 {
 	struct i2c_client *client = data;
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int mode,val,i,std;
-    
-	daemonize("msp3410 [auto]");
-	allow_signal(SIGTERM);
-	printk("msp3410: daemon started\n");
 
+	printk("msp3410: daemon started\n");
 	for (;;) {
 		d2printk(KERN_DEBUG "msp3410: thread: sleep\n");
-		if (msp34xx_sleep(msp,-1))
-			goto done;
-
+		msp34xx_sleep(msp,-1);
 		d2printk(KERN_DEBUG "msp3410: thread: wakeup\n");
-		msp->active = 1;
-
-		if (msp->watch_stereo) {
-			watch_stereo(client);
-			msp->active = 0;
-			continue;
-		}
-	
-		/* some time for the tuner to sync */
-		if (msp34xx_sleep(msp,HZ/5))
-			goto done;
 
 	restart:
+		dprintk("msp3410: thread: restart scan\n");
+		msp->restart = 0;
+		if (kthread_should_stop())
+			break;
+
 		if (msp->mode == MSP_MODE_EXTERN) {
 			/* no carrier scan needed, just unmute */
 			dprintk(KERN_DEBUG "msp3410: thread: no carrier scan\n");
@@ -1043,47 +1055,24 @@
 					   msp->volume, msp->balance);
 			continue;
 		}
-		msp->restart = 0;
-		del_timer(&msp->wake_stereo);
-		msp->watch_stereo = 0;
 
 		/* put into sane state (and mute) */
 		msp3400c_reset(client);
 
+		/* some time for the tuner to sync */
+		if (msp34xx_sleep(msp,200))
+			goto restart;
+
 		/* start autodetect */
-		switch (msp->norm) {
-		case VIDEO_MODE_PAL:
-			mode = 0x1003;
-			std  = 1;
-			break;
-		case VIDEO_MODE_NTSC:  /* BTSC */
-			mode = 0x2003;
-			std  = 0x0020;
-			break;
-		case VIDEO_MODE_SECAM: 
-			mode = 0x0003;
-			std  = 1;
-			break;
-		case VIDEO_MODE_RADIO:
-			mode = 0x0003;
-			std  = 0x0040;
-			break;
-		default:
-			mode = 0x0003;
-			std  = 1;
-			break;
-		}
+		mode = msp34xx_modus(msp->norm);
+		std  = msp34xx_standard(msp->norm);
 		msp3400c_write(client, I2C_MSP3400C_DEM, 0x30, mode);
 		msp3400c_write(client, I2C_MSP3400C_DEM, 0x20, std);
+		msp->watch_stereo = 0;
 
-		if (debug) {
-			int i;
-			for (i = 0; modelist[i].name != NULL; i++)
-				if (modelist[i].retval == std)
-					break;
+		if (debug)
 			printk(KERN_DEBUG "msp3410: setting mode: %s (0x%04x)\n",
-			       modelist[i].name ? modelist[i].name : "unknown",std);
-		}
+			       msp34xx_standard_mode_name(std) ,std);
 
 		if (std != 1) {
 			/* programmed some specific mode */
@@ -1091,9 +1080,7 @@
 		} else {
 			/* triggered autodetect */
 			for (;;) {
-				if (msp34xx_sleep(msp,HZ/10))
-					goto done;
-				if (msp->restart)
+				if (msp34xx_sleep(msp,100))
 					goto restart;
 
 				/* check results */
@@ -1135,29 +1122,30 @@
 			else
 				msp->mode = MSP_MODE_FM_NICAM2;
 			/* just turn on stereo */
-			msp->stereo = VIDEO_SOUND_STEREO;
+			msp->rxsubchans = V4L2_TUNER_SUB_STEREO;
 			msp->nicam_on = 1;
 			msp->watch_stereo = 1;
-			msp3400c_setstereo(client,VIDEO_SOUND_STEREO);
+			msp3400c_set_audmode(client,V4L2_TUNER_MODE_STEREO);
 			break;
-		case 0x0009:			
+		case 0x0009:
 			msp->mode = MSP_MODE_AM_NICAM;
-			msp->stereo = VIDEO_SOUND_MONO;
+			msp->rxsubchans = V4L2_TUNER_SUB_MONO;
 			msp->nicam_on = 1;
-			msp3400c_setstereo(client,VIDEO_SOUND_MONO);
+			msp3400c_set_audmode(client,V4L2_TUNER_MODE_MONO);
 			msp->watch_stereo = 1;
 			break;
 		case 0x0020: /* BTSC */
 			/* just turn on stereo */
-			msp->mode   = MSP_MODE_BTSC;
-			msp->stereo = VIDEO_SOUND_STEREO;
+			msp->mode = MSP_MODE_BTSC;
+			msp->rxsubchans = V4L2_TUNER_SUB_STEREO;
 			msp->nicam_on = 0;
 			msp->watch_stereo = 1;
-			msp3400c_setstereo(client,VIDEO_SOUND_STEREO);
+			msp3400c_set_audmode(client,V4L2_TUNER_MODE_STEREO);
 			break;
 		case 0x0040: /* FM radio */
 			msp->mode   = MSP_MODE_FM_RADIO;
-			msp->stereo = VIDEO_SOUND_STEREO;
+			msp->rxsubchans = V4L2_TUNER_SUB_STEREO;
+			msp->audmode = V4L2_TUNER_MODE_STEREO;
 			msp->nicam_on = 0;
 			msp->watch_stereo = 0;
 			/* not needed in theory if HAVE_RADIO(), but
@@ -1183,50 +1171,276 @@
 		case 0x0004:
 		case 0x0005:
 			msp->mode   = MSP_MODE_FM_TERRA;
-			msp->stereo = VIDEO_SOUND_MONO;
+			msp->rxsubchans = V4L2_TUNER_SUB_MONO;
+			msp->audmode = V4L2_TUNER_MODE_MONO;
 			msp->nicam_on = 0;
 			msp->watch_stereo = 1;
 			break;
 		}
-		
-		/* unmute + restore dfp registers */
+
+		/* unmute, restore misc registers */
 		msp3400c_setbass(client, msp->bass);
 		msp3400c_settreble(client, msp->treble);
 		msp3400c_setvolume(client, msp->muted,
 				    msp->volume, msp->balance);
-		msp3400c_restore_dfp(client);
-
-		if (msp->watch_stereo)
-			mod_timer(&msp->wake_stereo, jiffies+HZ);
+		msp3400c_write(client, I2C_MSP3400C_DFP, 0x0013, msp->acb);
 
-		msp->active = 0;
+		/* monitor tv audio mode */
+		while (msp->watch_stereo) {
+			if (msp34xx_sleep(msp,5000))
+				goto restart;
+			watch_stereo(client);
+		}
 	}
-
-done:
-	msp->active = 0;
 	dprintk(KERN_DEBUG "msp3410: thread: exit\n");
-        complete_and_exit(&msp->texit, 0);
 	return 0;
 }
 
 /* ----------------------------------------------------------------------- */
+/* msp34xxG + (simpler no-thread)                                          */
+/* this one uses both automatic standard detection and automatic sound     */
+/* select which are available in the newer G versions                      */
+/* struct msp: only norm, acb and source are really used in this mode      */
+
+static void msp34xxg_set_source(struct i2c_client *client, int source);
+
+/* (re-)initialize the msp34xxg, according to the current norm in msp->norm
+ * return 0 if it worked, -1 if it failed
+ */
+static int msp34xxg_init(struct i2c_client *client)
+{
+	struct msp3400c *msp = i2c_get_clientdata(client);
+	int modus;
+
+	if (msp3400c_reset(client))
+		return -1;
+
+	/* make sure that input/output is muted (paranoid mode) */
+	if (msp3400c_write(client,
+			   I2C_MSP3400C_DFP,
+			   0x13, /* ACB */
+			   0x0f20 /* mute DSP input, mute SCART 1 */))
+		return -1;
+
+	/* step-by-step initialisation, as described in the manual */
+	modus = msp34xx_modus(msp->norm);
+	modus &= ~0x03; /* STATUS_CHANGE=0 */
+	modus |= 0x01;  /* AUTOMATIC_SOUND_DETECTION=1 */
+	if (msp3400c_write(client,
+			   I2C_MSP3400C_DEM,
+			   0x30/*MODUS*/,
+			   modus))
+		return -1;
+
+	/* write the dfps that may have an influence on
+	   standard/audio autodetection right now */
+	msp34xxg_set_source(client, msp->source);
+
+	if (msp3400c_write(client, I2C_MSP3400C_DFP,
+			   0x0e, /* AM/FM Prescale */
+			   0x3000 /* default: [15:8] 75khz deviation */))
+		return -1;
+
+	if (msp3400c_write(client, I2C_MSP3400C_DFP,
+			   0x10, /* NICAM Prescale */
+			   0x5a00 /* default: 9db gain (as recommended) */))
+		return -1;
+
+	if (msp3400c_write(client,
+			   I2C_MSP3400C_DEM,
+			   0x20, /* STANDARD SELECT  */
+			   standard /* default: 0x01 for automatic standard select*/))
+		return -1;
+	return 0;
+}
+
+static int msp34xxg_thread(void *data)
+{
+	struct i2c_client *client = data;
+	struct msp3400c *msp = i2c_get_clientdata(client);
+	int val, std, i;
+
+	printk("msp34xxg: daemon started\n");
+	for (;;) {
+		d2printk(KERN_DEBUG "msp34xxg: thread: sleep\n");
+		msp34xx_sleep(msp,-1);
+		d2printk(KERN_DEBUG "msp34xxg: thread: wakeup\n");
+
+	restart:
+		dprintk("msp34xxg: thread: restart scan\n");
+		msp->restart = 0;
+		if (kthread_should_stop())
+			break;
+
+		/* setup the chip*/
+		msp34xxg_init(client);
+		std = standard;
+		if (std != 0x01)
+			goto unmute;
+
+		/* watch autodetect */
+		dprintk("msp34xxg: triggered autodetect, waiting for result\n");
+		for (i = 0; i < 10; i++) {
+			if (msp34xx_sleep(msp,100))
+				goto restart;
+
+			/* check results */
+			val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x7e);
+			if (val < 0x07ff) {
+				std = val;
+				break;
+			}
+			dprintk("msp34xxg: detection still in progress\n");
+		}
+		if (0x01 == std) {
+			dprintk("msp34xxg: detection still in progress after 10 tries. giving up.\n");
+			continue;
+		}
+
+	unmute:
+		dprintk("msp34xxg: current mode: %s (0x%04x)\n",
+			msp34xx_standard_mode_name(std), std);
+
+		/* unmute: dispatch sound to scart output, set scart volume */
+		dprintk("msp34xxg: unmute\n");
+
+		msp3400c_setbass(client, msp->bass);
+		msp3400c_settreble(client, msp->treble);
+		msp3400c_setvolume(client, msp->muted, msp->volume, msp->balance);
+
+		/* restore ACB */
+		if (msp3400c_write(client,
+				   I2C_MSP3400C_DFP,
+				   0x13, /* ACB */
+				   msp->acb))
+			return -1;
+	}
+	dprintk(KERN_DEBUG "msp34xxg: thread: exit\n");
+	return 0;
+}
+
+/* set the same 'source' for the loudspeaker, scart and quasi-peak detector
+ * the value for source is the same as bit 15:8 of DFP registers 0x08,
+ * 0x0a and 0x0c: 0=mono, 1=stereo or A|B, 2=SCART, 3=stereo or A, 4=stereo or B
+ *
+ * this function replaces msp3400c_setstereo
+ */
+static void msp34xxg_set_source(struct i2c_client *client, int source)
+{
+	struct msp3400c *msp = i2c_get_clientdata(client);
+
+	/* fix matrix mode to stereo and let the msp choose what
+	 * to output according to 'source', as recommended
+	 */
+	int value = (source&0x07)<<8|(source==0 ? 0x00:0x20);
+	dprintk("msp34xxg: set source to %d (0x%x)\n", source, value);
+	msp3400c_write(client,
+		       I2C_MSP3400C_DFP,
+		       0x08, /* Loudspeaker Output */
+		       value);
+	msp3400c_write(client,
+		       I2C_MSP3400C_DFP,
+		       0x0a, /* SCART1 DA Output */
+		       value);
+	msp3400c_write(client,
+		       I2C_MSP3400C_DFP,
+		       0x0c, /* Quasi-peak detector */
+		       value);
+	/*
+	 * set identification threshold. Personally, I
+	 * I set it to a higher value that the default
+	 * of 0x190 to ignore noisy stereo signals.
+	 * this needs tuning. (recommended range 0x00a0-0x03c0)
+	 * 0x7f0 = forced mono mode
+	 */
+	msp3400c_write(client,
+		       I2C_MSP3400C_DEM,
+		       0x22, /* a2 threshold for stereo/bilingual */
+		       source==0 ? 0x7f0:stereo_threshold);
+	msp->source=source;
+}
+
+static void msp34xxg_detect_stereo(struct i2c_client *client)
+{
+	struct msp3400c *msp = i2c_get_clientdata(client);
+
+	int status = msp3400c_read(client,
+				   I2C_MSP3400C_DEM,
+				   0x0200 /* STATUS */);
+	int is_bilingual = status&0x100;
+	int is_stereo = status&0x40;
+
+	msp->rxsubchans = 0;
+	if (is_stereo)
+		msp->rxsubchans |= V4L2_TUNER_SUB_STEREO;
+	else
+		msp->rxsubchans |= V4L2_TUNER_SUB_MONO;
+	if (is_bilingual) {
+		msp->rxsubchans |= V4L2_TUNER_SUB_LANG1|V4L2_TUNER_SUB_LANG2;
+		/* I'm supposed to check whether it's SAP or not
+		 * and set only LANG2/SAP in this case. Yet, the MSP
+		 * does a lot of work to hide this and handle everything
+		 * the same way. I don't want to work around it so unless
+		 * this is a problem, I'll handle SAP just like lang1/lang2.
+		 */
+	}
+	dprintk("msp34xxg: status=0x%x, stereo=%d, bilingual=%d -> rxsubchans=%d\n",
+		status, is_stereo, is_bilingual, msp->rxsubchans);
+}
+
+static void msp34xxg_set_audmode(struct i2c_client *client, int audmode)
+{
+	struct msp3400c *msp = i2c_get_clientdata(client);
+	int source = 0;
+
+	switch (audmode) {
+	case V4L2_TUNER_MODE_MONO:
+		source=0; /* mono only */
+		break;
+	case V4L2_TUNER_MODE_STEREO:
+		source=1; /* stereo or A|B, see comment in msp34xxg_get_v4l2_stereo() */
+		/* problem: that could also mean 2 (scart input) */
+		break;
+	case V4L2_TUNER_MODE_LANG1:
+		source=3; /* stereo or A */
+		break;
+	case V4L2_TUNER_MODE_LANG2:
+		source=4; /* stereo or B */
+		break;
+	default: /* doing nothing: a safe, sane default */
+		audmode = 0;
+		return;
+	}
+	msp->audmode = audmode;
+	msp34xxg_set_source(client, source);
+}
+
+
+/* ----------------------------------------------------------------------- */
 
 static int msp_attach(struct i2c_adapter *adap, int addr, int kind);
 static int msp_detach(struct i2c_client *client);
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
+static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_resume(struct device * dev, u32 level);
+
 static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
-        .name           = "i2c msp3400 driver",
+	.name           = "i2c msp3400 driver",
         .id             = I2C_DRIVERID_MSP3400,
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = msp_probe,
         .detach_client  = msp_detach,
         .command        = msp_command,
+	.driver {
+		.suspend = msp_suspend,
+		.resume  = msp_resume,
+	},
 };
 
-static struct i2c_client client_template = 
+static struct i2c_client client_template =
 {
 	I2C_DEVNAME("(unset)"),
 	.flags     = I2C_CLIENT_ALLOW_USE,
@@ -1237,7 +1451,7 @@
 {
 	struct msp3400c *msp;
         struct i2c_client *c;
-	int i;
+	int (*thread_func)(void *data) = NULL;
 
         client_template.adapter = adap;
         client_template.addr = addr;
@@ -1246,7 +1460,7 @@
                 dprintk("msp3400: no chip found\n");
                 return -1;
         }
-	
+
         if (NULL == (c = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))
                 return -ENOMEM;
         memcpy(c,&client_template,sizeof(struct i2c_client));
@@ -1254,16 +1468,14 @@
 		kfree(c);
 		return -ENOMEM;
 	}
-	
+
 	memset(msp,0,sizeof(struct msp3400c));
-	msp->volume = 65535;
+	msp->volume  = 58880;  /* 0db gain */
 	msp->balance = 32768;
-	msp->bass   = 32768;
-	msp->treble = 32768;
-	msp->input  = -1;
-	msp->muted  = 1;
-	for (i = 0; i < DFP_COUNT; i++)
-		msp->dfp_regs[i] = -1;
+	msp->bass    = 32768;
+	msp->treble  = 32768;
+	msp->input   = -1;
+	msp->muted   = 1;
 
 	i2c_set_clientdata(c, msp);
 	init_waitqueue_head(&msp->wq);
@@ -1274,7 +1486,7 @@
 		dprintk("msp3400: no chip found\n");
 		return -1;
 	}
-    
+
 	msp->rev1 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1e);
 	if (-1 != msp->rev1)
 		msp->rev2 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1f);
@@ -1295,36 +1507,51 @@
 		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
 		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
-	if (simple == -1) {
-		/* default mode */
-		msp->simple = HAVE_SIMPLE(msp);
-	} else {
-		/* use insmod option */
-		msp->simple = simple;
+	msp->opmode = opmode;
+	if (OPMODE_AUTO == msp->opmode) {
+		if (HAVE_SIMPLER(msp))
+			msp->opmode = OPMODE_SIMPLER;
+		else if (HAVE_SIMPLE(msp))
+			msp->opmode = OPMODE_SIMPLE;
+		else
+			msp->opmode = OPMODE_MANUAL;
 	}
 
-	/* timer for stereo checking */
-	init_timer(&msp->wake_stereo);
-	msp->wake_stereo.function = msp3400c_stereo_wake;
-	msp->wake_stereo.data     = (unsigned long)msp;
-
 	/* hello world :-) */
 	printk(KERN_INFO "msp34xx: init: chip=%s",i2c_clientname(c));
 	if (HAVE_NICAM(msp))
 		printk(" +nicam");
 	if (HAVE_SIMPLE(msp))
 		printk(" +simple");
+	if (HAVE_SIMPLER(msp))
+		printk(" +simpler");
 	if (HAVE_RADIO(msp))
 		printk(" +radio");
+
+	/* version-specific initialization */
+	switch (msp->opmode) {
+	case OPMODE_MANUAL:
+		printk(" mode=manual");
+		thread_func = msp3400c_thread;
+		break;
+	case OPMODE_SIMPLE:
+		printk(" mode=simple");
+		thread_func = msp3410d_thread;
+		break;
+	case OPMODE_SIMPLER:
+		printk(" mode=simpler");
+		thread_func = msp34xxg_thread;
+		break;
+	}
 	printk("\n");
 
-	/* startup control thread */
-	init_completion(&msp->texit);
-	msp->tpid = kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
-				  (void *)c, 0);
-	if (msp->tpid < 0)
-		printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
-	wake_up_interruptible(&msp->wq);
+	/* startup control thread if needed */
+	if (thread_func) {
+		msp->kthread = kthread_run(thread_func, c, "msp34xx");
+		if (NULL == msp->kthread)
+			printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
+		wake_up_interruptible(&msp->wq);
+	}
 
 	/* done */
         i2c_attach_client(c);
@@ -1334,13 +1561,11 @@
 static int msp_detach(struct i2c_client *client)
 {
 	struct msp3400c *msp  = i2c_get_clientdata(client);
-	
+
 	/* shutdown control thread */
-	del_timer_sync(&msp->wake_stereo);
-	if (msp->tpid >= 0) {
-		msp->rmmod = 1;
-		wake_up_interruptible(&msp->wq);
-		wait_for_completion(&msp->texit);
+	if (msp->kthread >= 0) {
+		msp->restart = 1;
+		kthread_stop(msp->kthread);
 	}
     	msp3400c_reset(client);
 
@@ -1352,18 +1577,8 @@
 
 static int msp_probe(struct i2c_adapter *adap)
 {
-#ifdef I2C_CLASS_TV_ANALOG
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, msp_attach);
-#else
-	switch (adap->id) {
-	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
-	case I2C_ALGO_BIT | I2C_HW_B_BT848:
-	//case I2C_ALGO_SAA7134:
-		return i2c_probe(adap, &addr_data, msp_attach);
-		break;
-	}
-#endif
 	return 0;
 }
 
@@ -1371,14 +1586,73 @@
 {
 	struct msp3400c *msp  = i2c_get_clientdata(client);
 
+	if (NULL == msp->kthread)
+		return;
 	msp3400c_setvolume(client,msp->muted,0,0);
-	msp->watch_stereo=0;
-	del_timer(&msp->wake_stereo);
-	if (msp->active)
-		msp->restart = 1;
+	msp->watch_stereo = 0;
+	msp->restart = 1;
 	wake_up_interruptible(&msp->wq);
 }
 
+/* ----------------------------------------------------------------------- */
+
+static int mode_v4l2_to_v4l1(int rxsubchans)
+{
+	int mode = 0;
+
+	if (rxsubchans & V4L2_TUNER_SUB_STEREO)
+		mode |= VIDEO_SOUND_STEREO;
+	if (rxsubchans & V4L2_TUNER_SUB_LANG2)
+		mode |= VIDEO_SOUND_LANG2;
+	if (rxsubchans & V4L2_TUNER_SUB_LANG1)
+		mode |= VIDEO_SOUND_LANG1;
+	if (0 == mode)
+		mode |= VIDEO_SOUND_MONO;
+	return mode;
+}
+
+static int mode_v4l1_to_v4l2(int mode)
+{
+	if (mode & VIDEO_SOUND_STEREO)
+		return V4L2_TUNER_MODE_STEREO;
+	if (mode & VIDEO_SOUND_LANG2)
+		return V4L2_TUNER_MODE_LANG2;
+	if (mode & VIDEO_SOUND_LANG1)
+		return V4L2_TUNER_MODE_LANG1;
+	return V4L2_TUNER_MODE_MONO;
+}
+
+static void msp_any_detect_stereo(struct i2c_client *client)
+{
+	struct msp3400c *msp  = i2c_get_clientdata(client);
+
+	switch (msp->opmode) {
+	case OPMODE_MANUAL:
+	case OPMODE_SIMPLE:
+		autodetect_stereo(client);
+		break;
+	case OPMODE_SIMPLER:
+		msp34xxg_detect_stereo(client);
+		break;
+	}
+}
+
+static void msp_any_set_audmode(struct i2c_client *client, int audmode)
+{
+	struct msp3400c *msp  = i2c_get_clientdata(client);
+
+	switch (msp->opmode) {
+	case OPMODE_MANUAL:
+	case OPMODE_SIMPLE:
+		msp->watch_stereo = 0;
+		msp3400c_set_audmode(client, audmode);
+		break;
+	case OPMODE_SIMPLER:
+		msp34xxg_set_audmode(client, audmode);
+		break;
+	}
+}
+
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	struct msp3400c *msp  = i2c_get_clientdata(client);
@@ -1410,7 +1684,6 @@
 			break;
 		case AUDIO_TUNER:
 			msp->mode   = -1;
-			msp_wake_thread(client);
 			break;
 		default:
 			if (*sarg & AUDIO_MUTE)
@@ -1418,63 +1691,38 @@
 			break;
 		}
 		if (scart) {
-			msp->stereo = VIDEO_SOUND_STEREO;
+			msp->rxsubchans = V4L2_TUNER_SUB_STEREO;
+			msp->audmode = V4L2_TUNER_MODE_STEREO;
 			msp3400c_set_scart(client,scart,0);
 			msp3400c_write(client,I2C_MSP3400C_DFP,0x000d,0x1900);
-			msp3400c_setstereo(client,msp->stereo);
+			if (msp->opmode != OPMODE_SIMPLER)
+				msp3400c_set_audmode(client, msp->audmode);
 		}
-		if (msp->active)
-			msp->restart = 1;
+		msp_wake_thread(client);
 		break;
 
 	case AUDC_SET_RADIO:
 		dprintk(KERN_DEBUG "msp34xx: AUDC_SET_RADIO\n");
 		msp->norm = VIDEO_MODE_RADIO;
-		msp->watch_stereo=0;
-		del_timer(&msp->wake_stereo);
 		dprintk(KERN_DEBUG "msp34xx: switching to radio mode\n");
-		if (msp->simple) {
-			/* the thread will do for us */
-			msp_wake_thread(client);
-		} else {
+		msp->watch_stereo = 0;
+		switch (msp->opmode) {
+		case OPMODE_MANUAL:
 			/* set msp3400 to FM radio mode */
 			msp3400c_setmode(client,MSP_MODE_FM_RADIO);
 			msp3400c_setcarrier(client, MSP_CARRIER(10.7),
 					    MSP_CARRIER(10.7));
 			msp3400c_setvolume(client, msp->muted,
 					   msp->volume, msp->balance);
+			break;
+		case OPMODE_SIMPLE:
+		case OPMODE_SIMPLER:
+			/* the thread will do for us */
+			msp_wake_thread(client);
+			break;
 		}
-		if (msp->active)
-			msp->restart = 1;
 		break;
 
-#if 1
-	/* work-in-progress:  hook to control the DFP registers */
-	case MSP_SET_DFPREG:
-	{
-		struct msp_dfpreg *r = arg;
-		unsigned int i;
-
-		if (r->reg < 0 || r->reg >= DFP_COUNT)
-			return -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(bl_dfp); i++)
-			if (r->reg == bl_dfp[i])
-				return -EINVAL;
-		msp->dfp_regs[r->reg] = r->value;
-		msp3400c_write(client,I2C_MSP3400C_DFP,r->reg,r->value);
-		return 0;
-	}
-	case MSP_GET_DFPREG:
-	{
-		struct msp_dfpreg *r = arg;
-
-		if (r->reg < 0 || r->reg >= DFP_COUNT)
-			return -EINVAL;
-		r->value = msp3400c_read(client,I2C_MSP3400C_DFP,r->reg);
-		return 0;
-	}
-#endif
-
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
 	   kernel pointer here... */
@@ -1495,10 +1743,8 @@
 		va->bass = msp->bass;
 		va->treble = msp->treble;
 
-		if (msp->norm != VIDEO_MODE_RADIO) {
-			autodetect_stereo(client);
-			va->mode = msp->stereo;
-		}
+		msp_any_detect_stereo(client);
+		va->mode = mode_v4l2_to_v4l1(msp->rxsubchans);
 		break;
 	}
 	case VIDIOCSAUDIO:
@@ -1517,23 +1763,22 @@
 		msp3400c_setbass(client,msp->bass);
 		msp3400c_settreble(client,msp->treble);
 
-		if (va->mode != 0 && msp->norm != VIDEO_MODE_RADIO) {
-			msp->watch_stereo=0;
-			del_timer(&msp->wake_stereo);
-			msp->stereo = va->mode & 0x0f;
-			msp3400c_setstereo(client,va->mode & 0x0f);
-		}
+		if (va->mode != 0 && msp->norm != VIDEO_MODE_RADIO)
+			msp_any_set_audmode(client,mode_v4l1_to_v4l2(va->mode));
 		break;
 	}
 	case VIDIOCSCHAN:
 	{
 		struct video_channel *vc = arg;
-		
+
 		dprintk(KERN_DEBUG "msp34xx: VIDIOCSCHAN (norm=%d)\n",vc->norm);
 		msp->norm = vc->norm;
+		msp_wake_thread(client);
 		break;
 	}
+
 	case VIDIOCSFREQ:
+	case VIDIOC_S_FREQUENCY:
 	{
 		/* new channel -- kick audio carrier scan */
 		dprintk(KERN_DEBUG "msp34xx: VIDIOCSFREQ\n");
@@ -1541,6 +1786,39 @@
 		break;
 	}
 
+	/* --- v4l2 ioctls --- */
+	case VIDIOC_G_TUNER:
+	{
+		struct v4l2_tuner *vt = arg;
+
+		msp_any_detect_stereo(client);
+		vt->audmode    = msp->audmode;
+		vt->rxsubchans = msp->rxsubchans;
+		vt->capability = V4L2_TUNER_CAP_STEREO |
+			V4L2_TUNER_CAP_LANG1|
+			V4L2_TUNER_CAP_LANG2;
+		break;
+	}
+	case VIDIOC_S_TUNER:
+	{
+		struct v4l2_tuner *vt=(struct v4l2_tuner *)arg;
+
+		/* only set audmode */
+		if (vt->audmode != -1 && vt->audmode != 0)
+			msp_any_set_audmode(client, vt->audmode);
+		break;
+	}
+
+	/* msp34xx specific */
+	case MSP_SET_MATRIX:
+	{
+		struct msp_matrix *mspm = arg;
+
+		dprintk(KERN_DEBUG "msp34xx: MSP_SET_MATRIX\n");
+		msp3400c_set_scart(client, mspm->input, mspm->output);
+		break;
+	}
+
 	default:
 		/* nothing */
 		break;
@@ -1548,6 +1826,24 @@
 	return 0;
 }
 
+static int msp_suspend(struct device * dev, u32 state, u32 level)
+{
+	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
+
+	dprintk("msp34xx: suspend\n");
+	msp3400c_reset(c);
+	return 0;
+}
+
+static int msp_resume(struct device * dev, u32 level)
+{
+	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
+
+	dprintk("msp34xx: resume\n");
+	msp_wake_thread(c);
+	return 0;
+}
+
 /* ----------------------------------------------------------------------- */
 
 static int __init msp3400_init_module(void)
diff -u linux-2.6.9/drivers/media/video/msp3400.h linux/drivers/media/video/msp3400.h
--- linux-2.6.9/drivers/media/video/msp3400.h	2004-10-21 11:45:47.000000000 +0200
+++ linux/drivers/media/video/msp3400.h	2004-10-21 14:57:52.560493622 +0200
@@ -8,7 +8,29 @@
     int value;
 };
 
+struct msp_matrix {
+  int input;
+  int output;
+};
+
 #define MSP_SET_DFPREG     _IOW('m',15,struct msp_dfpreg)
 #define MSP_GET_DFPREG     _IOW('m',16,struct msp_dfpreg)
 
+/* ioctl for MSP_SET_MATRIX will have to be registered */
+#define MSP_SET_MATRIX     _IOW('m',17,struct msp_matrix)
+
+#define SCART_MASK    0
+#define SCART_IN1     1
+#define SCART_IN2     2
+#define SCART_IN1_DA  3
+#define SCART_IN2_DA  4
+#define SCART_IN3     5
+#define SCART_IN4     6
+#define SCART_MONO    7
+#define SCART_MUTE    8
+
+#define SCART_DSP_IN  0
+#define SCART1_OUT    1
+#define SCART2_OUT    2
+
 #endif /* MSP3400_H */

-- 
return -ENOSIG;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVKGDR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVKGDR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVKGDRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:17:22 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:1929 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932431AbVKGDQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:59 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Hans Verkuil <hverkuil@xs4all.nl>
Subject: [Patch 16/20] V4L(917) fixes some bugs at msp3400
Date: Mon, 07 Nov 2005 00:58:10 -0200
Message-Id: <1131333341.25215.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

- Adds missing msp34xxg_reset to VIDIOC_S_STD (just like VIDIOCSCHAN).
- Improves msp3400 debug messages.
  Now, all kernel message in msp3400.c use the same prefix
  and include the I2C bus to differentiate between multiple
  msp3400 I2C chips.
- Correctly prints the chip identifier for the msp44xx chips.
- msp34xxg cleanups.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/msp3400.c |  301 ++++++++++++++++++++++--------------------
 1 files changed, 159 insertions(+), 142 deletions(-)

--- hg.orig/drivers/media/video/msp3400.c
+++ hg/drivers/media/video/msp3400.c
@@ -56,6 +56,39 @@
 #include <media/audiochip.h>
 #include "msp3400.h"
 
+#define msp3400_dbg(fmt, arg...) \
+	do { \
+		if (debug) \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+			       i2c_adapter_id(client->adapter), client->addr , ## arg); \
+	} while (0)
+
+/* Medium volume debug. */
+#define msp3400_dbg_mediumvol(fmt, arg...) \
+	do { \
+		if (debug >= 2) \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+				i2c_adapter_id(client->adapter), client->addr , ## arg); \
+	} while (0)
+
+/* High volume debug. Use with care. */
+#define msp3400_dbg_highvol(fmt, arg...) \
+	do { \
+		if (debug >= 16) \
+			printk(KERN_INFO "%s debug %d-%04x: " fmt, client->driver->name, \
+				i2c_adapter_id(client->adapter), client->addr , ## arg); \
+	} while (0)
+
+#define msp3400_err(fmt, arg...) do { \
+	printk(KERN_ERR "%s %d-%04x: " fmt, client->driver->name, \
+		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
+#define msp3400_warn(fmt, arg...) do { \
+	printk(KERN_WARNING "%s %d-%04x: " fmt, client->driver->name, \
+		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
+#define msp3400_info(fmt, arg...) do { \
+	printk(KERN_INFO "%s %d-%04x: " fmt, client->driver->name, \
+		i2c_adapter_id(client->adapter), client->addr , ## arg); } while (0)
+
 #define OPMODE_AUTO    -1
 #define OPMODE_MANUAL   0
 #define OPMODE_SIMPLE   1   /* use short programming (>= msp3410 only) */
@@ -125,10 +158,6 @@ struct msp3400c {
 
 /* ---------------------------------------------------------------------- */
 
-#define dprintk      if (debug >= 1) printk
-#define d2printk     if (debug >= 2) printk
-#define dprintk_trace if (debug>=16) printk
-
 /* read-only */
 module_param(opmode,           int, 0444);
 
@@ -187,11 +216,11 @@ static int msp3400c_reset(struct i2c_cli
 		{ client->addr, I2C_M_RD, 2, read  },
 	};
 
-	dprintk_trace("trace: msp3400c_reset\n");
+	msp3400_dbg_highvol("msp3400c_reset\n");
 	if ( (1 != i2c_transfer(client->adapter,&reset[0],1)) ||
 	     (1 != i2c_transfer(client->adapter,&reset[1],1)) ||
 	     (2 != i2c_transfer(client->adapter,test,2)) ) {
-		printk(KERN_ERR "msp3400: chip reset failed\n");
+		msp3400_err("chip reset failed\n");
 		return -1;
 	}
 	return 0;
@@ -216,21 +245,18 @@ static int msp3400c_read(struct i2c_clie
 		if (2 == i2c_transfer(client->adapter,msgs,2))
 			break;
 		err++;
-		printk(KERN_WARNING
-		       "msp34xx: I/O error #%d (read 0x%02x/0x%02x)\n", err,
+		msp3400_warn("I/O error #%d (read 0x%02x/0x%02x)\n", err,
 		       dev, addr);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(msecs_to_jiffies(10));
 	}
 	if (3 == err) {
-		printk(KERN_WARNING
-		       "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
+		msp3400_warn("giving up, resetting chip. Sound will go off, sorry folks :-|\n");
 		msp3400c_reset(client);
 		return -1;
 	}
 	retval = read[0] << 8 | read[1];
-	dprintk_trace("trace: msp3400c_read(0x%x, 0x%x): 0x%x\n", dev, addr,
-		      retval);
+	msp3400_dbg_highvol("msp3400c_read(0x%x, 0x%x): 0x%x\n", dev, addr, retval);
 	return retval;
 }
 
@@ -245,21 +271,18 @@ static int msp3400c_write(struct i2c_cli
 	buffer[3] = val  >> 8;
 	buffer[4] = val  &  0xff;
 
-	dprintk_trace("trace: msp3400c_write(0x%x, 0x%x, 0x%x)\n", dev, addr,
-		      val);
+	msp3400_dbg_highvol("msp3400c_write(0x%x, 0x%x, 0x%x)\n", dev, addr, val);
 	for (err = 0; err < 3;) {
 		if (5 == i2c_master_send(client, buffer, 5))
 			break;
 		err++;
-		printk(KERN_WARNING
-		       "msp34xx: I/O error #%d (write 0x%02x/0x%02x)\n", err,
+		msp3400_warn("I/O error #%d (write 0x%02x/0x%02x)\n", err,
 		       dev, addr);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(msecs_to_jiffies(10));
 	}
 	if (3 == err) {
-		printk(KERN_WARNING
-		       "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
+		msp3400_warn("giving up, reseting chip. Sound will go off, sorry folks :-|\n");
 		msp3400c_reset(client);
 		return -1;
 	}
@@ -422,7 +445,7 @@ static void msp3400c_set_scart(struct i2
 	} else
 		msp->acb = 0xf60; /* Mute Input and SCART 1 Output */
 
-	dprintk("msp34xx: scart switch: %s => %d (ACB=0x%04x)\n",
+	msp3400_dbg("scart switch: %s => %d (ACB=0x%04x)\n",
 						scart_names[in], out, msp->acb);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x13, msp->acb);
 
@@ -456,7 +479,7 @@ static void msp3400c_setvolume(struct i2
 		balance = ((right - left) * 127) / vol;
 	}
 
-	dprintk("msp34xx: setvolume: mute=%s %d:%d  v=0x%02x b=0x%02x\n",
+	msp3400_dbg("setvolume: mute=%s %d:%d  v=0x%02x b=0x%02x\n",
 		muted ? "on" : "off", left, right, val >> 8, balance);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0000, val); /* loudspeaker */
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0006, val); /* headphones  */
@@ -469,7 +492,7 @@ static void msp3400c_setbass(struct i2c_
 {
 	int val = ((bass-32768) * 0x60 / 65535) << 8;
 
-	dprintk("msp34xx: setbass: %d 0x%02x\n", bass, val >> 8);
+	msp3400_dbg("setbass: %d 0x%02x\n", bass, val >> 8);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0002, val); /* loudspeaker */
 }
 
@@ -477,7 +500,7 @@ static void msp3400c_settreble(struct i2
 {
 	int val = ((treble-32768) * 0x60 / 65535) << 8;
 
-	dprintk("msp34xx: settreble: %d 0x%02x\n",treble, val>>8);
+	msp3400_dbg("settreble: %d 0x%02x\n",treble, val>>8);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0003, val); /* loudspeaker */
 }
 
@@ -486,7 +509,7 @@ static void msp3400c_setmode(struct i2c_
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int i;
 
-	dprintk("msp3400: setmode: %d\n",type);
+	msp3400_dbg("setmode: %d\n",type);
 	msp->mode       = type;
 	msp->audmode    = V4L2_TUNER_MODE_MONO;
 	msp->rxsubchans = V4L2_TUNER_SUB_MONO;
@@ -565,8 +588,8 @@ static void msp3400c_setstereo(struct i2
 		/* this method would break everything, let's make sure
 		 * it's never called
 		 */
-		dprintk
-		    ("msp34xxg: DEBUG WARNING setstereo called with mode=%d instead of set_source (ignored)\n",
+		msp3400_dbg
+		    ("DEBUG WARNING setstereo called with mode=%d instead of set_source (ignored)\n",
 		     mode);
 		return;
 	}
@@ -574,8 +597,7 @@ static void msp3400c_setstereo(struct i2
 	/* switch demodulator */
 	switch (msp->mode) {
 	case MSP_MODE_FM_TERRA:
-		dprintk("msp3400: FM setstereo: %s\n",
-			strmode[mode]);
+		msp3400_dbg("FM setstereo: %s\n", strmode[mode]);
 		msp3400c_setcarrier(client,msp->second,msp->main);
 		switch (mode) {
 		case V4L2_TUNER_MODE_STEREO:
@@ -589,7 +611,7 @@ static void msp3400c_setstereo(struct i2
 		}
 		break;
 	case MSP_MODE_FM_SAT:
-		dprintk("msp3400: SAT setstereo: %s\n",	strmode[mode]);
+		msp3400_dbg("SAT setstereo: %s\n", strmode[mode]);
 		switch (mode) {
 		case V4L2_TUNER_MODE_MONO:
 			msp3400c_setcarrier(client, MSP_CARRIER(6.5), MSP_CARRIER(6.5));
@@ -608,24 +630,24 @@ static void msp3400c_setstereo(struct i2
 	case MSP_MODE_FM_NICAM1:
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
-		dprintk("msp3400: NICAM setstereo: %s\n",strmode[mode]);
+		msp3400_dbg("NICAM setstereo: %s\n",strmode[mode]);
 		msp3400c_setcarrier(client,msp->second,msp->main);
 		if (msp->nicam_on)
 			nicam=0x0100;
 		break;
 	case MSP_MODE_BTSC:
-		dprintk("msp3400: BTSC setstereo: %s\n",strmode[mode]);
+		msp3400_dbg("BTSC setstereo: %s\n",strmode[mode]);
 		nicam=0x0300;
 		break;
 	case MSP_MODE_EXTERN:
-		dprintk("msp3400: extern setstereo: %s\n",strmode[mode]);
+		msp3400_dbg("extern setstereo: %s\n",strmode[mode]);
 		nicam = 0x0200;
 		break;
 	case MSP_MODE_FM_RADIO:
-		dprintk("msp3400: FM-Radio setstereo: %s\n",strmode[mode]);
+		msp3400_dbg("FM-Radio setstereo: %s\n",strmode[mode]);
 		break;
 	default:
-		dprintk("msp3400: mono setstereo\n");
+		msp3400_dbg("mono setstereo\n");
 		return;
 	}
 
@@ -636,7 +658,7 @@ static void msp3400c_setstereo(struct i2
 		break;
 	case V4L2_TUNER_MODE_MONO:
 		if (msp->mode == MSP_MODE_AM_NICAM) {
-			dprintk("msp3400: switching to AM mono\n");
+			msp3400_dbg("switching to AM mono\n");
 			/* AM mono decoding is handled by tuner, not MSP chip */
 			/* SCART switching control register */
 			msp3400c_set_scart(client,SCART_MONO,0);
@@ -650,7 +672,7 @@ static void msp3400c_setstereo(struct i2
 		src = 0x0010 | nicam;
 		break;
 	}
-	dprintk("msp3400: setstereo final source/matrix = 0x%x\n", src);
+	msp3400_dbg("setstereo final source/matrix = 0x%x\n", src);
 
 	if (dolby) {
 		msp3400c_write(client,I2C_MSP3400C_DFP, 0x0008,0x0520);
@@ -666,24 +688,26 @@ static void msp3400c_setstereo(struct i2
 }
 
 static void
-msp3400c_print_mode(struct msp3400c *msp)
+msp3400c_print_mode(struct i2c_client *client)
 {
+	struct msp3400c *msp = i2c_get_clientdata(client);
+
 	if (msp->main == msp->second) {
-		dprintk("msp3400: mono sound carrier: %d.%03d MHz\n",
+		msp3400_dbg("mono sound carrier: %d.%03d MHz\n",
 		       msp->main/910000,(msp->main/910)%1000);
 	} else {
-		dprintk("msp3400: main sound carrier: %d.%03d MHz\n",
+		msp3400_dbg("main sound carrier: %d.%03d MHz\n",
 		       msp->main/910000,(msp->main/910)%1000);
 	}
 	if (msp->mode == MSP_MODE_FM_NICAM1 || msp->mode == MSP_MODE_FM_NICAM2)
-		dprintk("msp3400: NICAM/FM carrier   : %d.%03d MHz\n",
+		msp3400_dbg("NICAM/FM carrier   : %d.%03d MHz\n",
 		       msp->second/910000,(msp->second/910)%1000);
 	if (msp->mode == MSP_MODE_AM_NICAM)
-		dprintk("msp3400: NICAM/AM carrier   : %d.%03d MHz\n",
+		msp3400_dbg("NICAM/AM carrier   : %d.%03d MHz\n",
 		       msp->second/910000,(msp->second/910)%1000);
 	if (msp->mode == MSP_MODE_FM_TERRA &&
 	    msp->main != msp->second) {
-		dprintk("msp3400: FM-stereo carrier : %d.%03d MHz\n",
+		msp3400_dbg("FM-stereo carrier : %d.%03d MHz\n",
 		       msp->second/910000,(msp->second/910)%1000);
 	}
 }
@@ -741,7 +765,7 @@ static int autodetect_stereo(struct i2c_
 		val = msp3400c_read(client, I2C_MSP3400C_DFP, 0x18);
 		if (val > 32767)
 			val -= 65536;
-		dprintk("msp34xx: stereo detect register: %d\n",val);
+		msp3400_dbg("stereo detect register: %d\n",val);
 		if (val > 4096) {
 			rxsubchans = V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
 		} else if (val < -4096) {
@@ -755,7 +779,7 @@ static int autodetect_stereo(struct i2c_
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
 		val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x23);
-		dprintk("msp34xx: nicam sync=%d, mode=%d\n",
+		msp3400_dbg("nicam sync=%d, mode=%d\n",
 			val & 1, (val & 0x1e) >> 1);
 
 		if (val & 1) {
@@ -788,7 +812,7 @@ static int autodetect_stereo(struct i2c_
 		break;
 	case MSP_MODE_BTSC:
 		val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x200);
-		dprintk("msp3410: status=0x%x (pri=%s, sec=%s, %s%s%s)\n",
+		msp3400_dbg("status=0x%x (pri=%s, sec=%s, %s%s%s)\n",
 			val,
 			(val & 0x0002) ? "no"     : "yes",
 			(val & 0x0004) ? "no"     : "yes",
@@ -802,13 +826,13 @@ static int autodetect_stereo(struct i2c_
 	}
 	if (rxsubchans != msp->rxsubchans) {
 		update = 1;
-		dprintk("msp34xx: watch: rxsubchans %d => %d\n",
+		msp3400_dbg("watch: rxsubchans %d => %d\n",
 			msp->rxsubchans,rxsubchans);
 		msp->rxsubchans = rxsubchans;
 	}
 	if (newnicam != msp->nicam_on) {
 		update = 1;
-		dprintk("msp34xx: watch: nicam %d => %d\n",
+		msp3400_dbg("watch: nicam %d => %d\n",
 			msp->nicam_on,newnicam);
 		msp->nicam_on = newnicam;
 	}
@@ -865,14 +889,14 @@ static int msp3400c_thread(void *data)
 	struct CARRIER_DETECT *cd;
 	int count, max1,max2,val1,val2, val,this;
 
-	printk("msp3400: kthread started\n");
+	msp3400_info("msp3400 daemon started\n");
 	for (;;) {
-		d2printk("msp3400: thread: sleep\n");
+		msp3400_dbg_mediumvol("msp3400 thread: sleep\n");
 		msp34xx_sleep(msp,-1);
-		d2printk("msp3400: thread: wakeup\n");
+		msp3400_dbg_mediumvol("msp3400 thread: wakeup\n");
 
 	restart:
-		dprintk("msp3410: thread: restart scan\n");
+		msp3400_dbg("thread: restart scan\n");
 		msp->restart = 0;
 		if (kthread_should_stop())
 			break;
@@ -880,7 +904,7 @@ static int msp3400c_thread(void *data)
 		if (VIDEO_MODE_RADIO == msp->norm ||
 		    MSP_MODE_EXTERN  == msp->mode) {
 			/* no carrier scan, just unmute */
-			printk("msp3400: thread: no carrier scan\n");
+			msp3400_info("thread: no carrier scan\n");
 			msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
 			continue;
 		}
@@ -904,7 +928,7 @@ static int msp3400c_thread(void *data)
 			/* autodetect doesn't work well with AM ... */
 			max1 = 3;
 			count = 0;
-			dprintk("msp3400: AM sound override\n");
+			msp3400_dbg("AM sound override\n");
 		}
 
 		for (this = 0; this < count; this++) {
@@ -916,7 +940,7 @@ static int msp3400c_thread(void *data)
 				val -= 65536;
 			if (val1 < val)
 				val1 = val, max1 = this;
-			dprintk("msp3400: carrier1 val: %5d / %s\n", val,cd[this].name);
+			msp3400_dbg("carrier1 val: %5d / %s\n", val,cd[this].name);
 		}
 
 		/* carrier detect pass #2 -- second (stereo) carrier */
@@ -952,7 +976,7 @@ static int msp3400c_thread(void *data)
 				val -= 65536;
 			if (val2 < val)
 				val2 = val, max2 = this;
-			dprintk("msp3400: carrier2 val: %5d / %s\n", val,cd[this].name);
+			msp3400_dbg("carrier2 val: %5d / %s\n", val,cd[this].name);
 		}
 
 		/* programm the msp3400 according to the results */
@@ -1032,7 +1056,7 @@ static int msp3400c_thread(void *data)
 		msp3400c_restore_dfp(client);
 
 		if (debug)
-			msp3400c_print_mode(msp);
+			msp3400c_print_mode(client);
 
 		/* monitor tv audio mode */
 		while (msp->watch_stereo) {
@@ -1041,7 +1065,7 @@ static int msp3400c_thread(void *data)
 			watch_stereo(client);
 		}
 	}
-	dprintk("msp3400: thread: exit\n");
+	msp3400_dbg("thread: exit\n");
 	return 0;
 }
 
@@ -1085,11 +1109,11 @@ static inline const char *msp34xx_standa
 	return "unknown";
 }
 
-static int msp34xx_modus(int norm)
+static int msp34xx_modus(struct i2c_client *client, int norm)
 {
 	switch (norm) {
 	case VIDEO_MODE_PAL:
-		dprintk("msp34xx: video mode selected to PAL\n");
+		msp3400_dbg("video mode selected to PAL\n");
 
 #if 1
 		/* experimental: not sure this works with all chip versions */
@@ -1099,16 +1123,16 @@ static int msp34xx_modus(int norm)
 		return 0x1003;
 #endif
 	case VIDEO_MODE_NTSC:  /* BTSC */
-		dprintk("msp34xx: video mode selected to NTSC\n");
+		msp3400_dbg("video mode selected to NTSC\n");
 		return 0x2003;
 	case VIDEO_MODE_SECAM:
-		dprintk("msp34xx: video mode selected to SECAM\n");
+		msp3400_dbg("video mode selected to SECAM\n");
 		return 0x0003;
 	case VIDEO_MODE_RADIO:
-		dprintk("msp34xx: video mode selected to Radio\n");
+		msp3400_dbg("video mode selected to Radio\n");
 		return 0x0003;
 	case VIDEO_MODE_AUTO:
-		dprintk("msp34xx: video mode selected to Auto\n");
+		msp3400_dbg("video mode selected to Auto\n");
 		return 0x2003;
 	default:
 		return 0x0003;
@@ -1137,21 +1161,21 @@ static int msp3410d_thread(void *data)
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int mode,val,i,std;
 
-	printk("msp3410: daemon started\n");
+	msp3400_info("msp3410 daemon started\n");
 	for (;;) {
-		d2printk("msp3410: thread: sleep\n");
+		msp3400_dbg_mediumvol("msp3410 thread: sleep\n");
 		msp34xx_sleep(msp,-1);
-		d2printk("msp3410: thread: wakeup\n");
+		msp3400_dbg_mediumvol("msp3410 thread: wakeup\n");
 
 	restart:
-		dprintk("msp3410: thread: restart scan\n");
+		msp3400_dbg("thread: restart scan\n");
 		msp->restart = 0;
 		if (kthread_should_stop())
 			break;
 
 		if (msp->mode == MSP_MODE_EXTERN) {
 			/* no carrier scan needed, just unmute */
-			dprintk("msp3410: thread: no carrier scan\n");
+			msp3400_dbg("thread: no carrier scan\n");
 		msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
 			continue;
 		}
@@ -1164,14 +1188,14 @@ static int msp3410d_thread(void *data)
 			goto restart;
 
 		/* start autodetect */
-		mode = msp34xx_modus(msp->norm);
+		mode = msp34xx_modus(client, msp->norm);
 		std  = msp34xx_standard(msp->norm);
 		msp3400c_write(client, I2C_MSP3400C_DEM, 0x30, mode);
 		msp3400c_write(client, I2C_MSP3400C_DEM, 0x20, std);
 		msp->watch_stereo = 0;
 
 		if (debug)
-			dprintk("msp3410: setting mode: %s (0x%04x)\n",
+			msp3400_dbg("setting mode: %s (0x%04x)\n",
 			       msp34xx_standard_mode_name(std) ,std);
 
 		if (std != 1) {
@@ -1187,13 +1211,13 @@ static int msp3410d_thread(void *data)
 				val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x7e);
 				if (val < 0x07ff)
 					break;
-				dprintk("msp3410: detection still in progress\n");
+				msp3400_dbg("detection still in progress\n");
 			}
 		}
 		for (i = 0; modelist[i].name != NULL; i++)
 			if (modelist[i].retval == val)
 				break;
-		dprintk("msp3410: current mode: %s (0x%04x)\n",
+		msp3400_dbg("current mode: %s (0x%04x)\n",
 			modelist[i].name ? modelist[i].name : "unknown",
 			val);
 		msp->main   = modelist[i].main;
@@ -1201,7 +1225,7 @@ static int msp3410d_thread(void *data)
 
 		if (amsound && (msp->norm == VIDEO_MODE_SECAM) && (val != 0x0009)) {
 			/* autodetection has failed, let backup */
-			dprintk("msp3410: autodetection failed,"
+			msp3400_dbg("autodetection failed,"
 				" switching to backup mode: %s (0x%04x)\n",
 				modelist[8].name ? modelist[8].name : "unknown",val);
 			val = 0x0009;
@@ -1286,7 +1310,7 @@ static int msp3410d_thread(void *data)
 			watch_stereo(client);
 		}
 	}
-	dprintk("msp3410: thread: exit\n");
+	msp3400_dbg("thread: exit\n");
 	return 0;
 }
 
@@ -1319,7 +1343,7 @@ static int msp34xxg_reset(struct i2c_cli
 	msp3400c_write(client,I2C_MSP3400C_DEM, 0x40, msp->i2s_mode);
 
 	/* step-by-step initialisation, as described in the manual */
-	modus = msp34xx_modus(msp->norm);
+	modus = msp34xx_modus(client, msp->norm);
 	std   = msp34xx_standard(msp->norm);
 	modus &= ~0x03; /* STATUS_CHANGE=0 */
 	modus |= 0x01;  /* AUTOMATIC_SOUND_DETECTION=1 */
@@ -1359,15 +1383,15 @@ static int msp34xxg_thread(void *data)
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int val, std, i;
 
-	printk("msp34xxg: daemon started\n");
+	msp3400_info("msp34xxg daemon started\n");
 	msp->source = 1; /* default */
 	for (;;) {
-		d2printk("msp34xxg: thread: sleep\n");
+		msp3400_dbg_mediumvol("msp34xxg thread: sleep\n");
 		msp34xx_sleep(msp,-1);
-		d2printk("msp34xxg: thread: wakeup\n");
+		msp3400_dbg_mediumvol("msp34xxg thread: wakeup\n");
 
 	restart:
-		dprintk("msp34xxg: thread: restart scan\n");
+		msp3400_dbg("thread: restart scan\n");
 		msp->restart = 0;
 		if (kthread_should_stop())
 			break;
@@ -1379,7 +1403,7 @@ static int msp34xxg_thread(void *data)
 			goto unmute;
 
 		/* watch autodetect */
-		dprintk("msp34xxg: triggered autodetect, waiting for result\n");
+		msp3400_dbg("triggered autodetect, waiting for result\n");
 		for (i = 0; i < 10; i++) {
 			if (msp34xx_sleep(msp,100))
 				goto restart;
@@ -1390,19 +1414,19 @@ static int msp34xxg_thread(void *data)
 				std = val;
 				break;
 			}
-			dprintk("msp34xxg: detection still in progress\n");
+			msp3400_dbg("detection still in progress\n");
 		}
 		if (0x01 == std) {
-			dprintk("msp34xxg: detection still in progress after 10 tries. giving up.\n");
+			msp3400_dbg("detection still in progress after 10 tries. giving up.\n");
 			continue;
 		}
 
 	unmute:
-		dprintk("msp34xxg: current mode: %s (0x%04x)\n",
+		msp3400_dbg("current mode: %s (0x%04x)\n",
 			msp34xx_standard_mode_name(std), std);
 
 		/* unmute: dispatch sound to scart output, set scart volume */
-		dprintk("msp34xxg: unmute\n");
+		msp3400_dbg("unmute\n");
 
 		msp3400c_setbass(client, msp->bass);
 		msp3400c_settreble(client, msp->treble);
@@ -1417,7 +1441,7 @@ static int msp34xxg_thread(void *data)
 
 		msp3400c_write(client,I2C_MSP3400C_DEM, 0x40, msp->i2s_mode);
 	}
-	dprintk("msp34xxg: thread: exit\n");
+	msp3400_dbg("thread: exit\n");
 	return 0;
 }
 
@@ -1436,7 +1460,7 @@ static void msp34xxg_set_source(struct i
 	 * for MONO (source==0) downmixing set bit[7:0] to 0x30
 	 */
 	int value = (source&0x07)<<8|(source==0 ? 0x30:0x20);
-	dprintk("msp34xxg: set source to %d (0x%x)\n", source, value);
+	msp3400_dbg("set source to %d (0x%x)\n", source, value);
 	msp3400c_write(client,
 		       I2C_MSP3400C_DFP,
 		       0x08, /* Loudspeaker Output */
@@ -1487,7 +1511,7 @@ static void msp34xxg_detect_stereo(struc
 		 * this is a problem, I'll handle SAP just like lang1/lang2.
 		 */
 	}
-	dprintk("msp34xxg: status=0x%x, stereo=%d, bilingual=%d -> rxsubchans=%d\n",
+	msp3400_dbg("status=0x%x, stereo=%d, bilingual=%d -> rxsubchans=%d\n",
 		status, is_stereo, is_bilingual, msp->rxsubchans);
 }
 
@@ -1534,7 +1558,7 @@ static void msp_wake_thread(struct i2c_c
 
 static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
-	.name           = "i2c msp3400 driver",
+	.name           = "msp3400",
         .id             = I2C_DRIVERID_MSP3400,
         .flags          = I2C_DF_NOTIFY,
         .attach_adapter = msp_probe,
@@ -1556,7 +1580,7 @@ static struct i2c_client client_template
 static int msp_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct msp3400c *msp;
-	struct i2c_client *c;
+	struct i2c_client *client = &client_template;
 	int (*thread_func)(void *data) = NULL;
 	int i;
 
@@ -1564,15 +1588,15 @@ static int msp_attach(struct i2c_adapter
 	client_template.addr = addr;
 
 	if (-1 == msp3400c_reset(&client_template)) {
-		dprintk("msp34xx: no chip found\n");
+		msp3400_dbg("no chip found\n");
 		return -1;
 	}
 
-	if (NULL == (c = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))
+	if (NULL == (client = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))
 		return -ENOMEM;
-	memcpy(c,&client_template,sizeof(struct i2c_client));
+	memcpy(client,&client_template,sizeof(struct i2c_client));
 	if (NULL == (msp = kmalloc(sizeof(struct msp3400c),GFP_KERNEL))) {
-		kfree(c);
+		kfree(client);
 		return -ENOMEM;
 	}
 
@@ -1588,31 +1612,32 @@ static int msp_attach(struct i2c_adapter
 	for (i = 0; i < DFP_COUNT; i++)
 		msp->dfp_regs[i] = -1;
 
-	i2c_set_clientdata(c, msp);
+	i2c_set_clientdata(client, msp);
 	init_waitqueue_head(&msp->wq);
 
-	if (-1 == msp3400c_reset(c)) {
+	if (-1 == msp3400c_reset(client)) {
 		kfree(msp);
-		kfree(c);
-		dprintk("msp34xx: no chip found\n");
+		kfree(client);
+		msp3400_dbg("no chip found\n");
 		return -1;
 	}
 
-	msp->rev1 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1e);
+	msp->rev1 = msp3400c_read(client, I2C_MSP3400C_DFP, 0x1e);
 	if (-1 != msp->rev1)
-		msp->rev2 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1f);
+		msp->rev2 = msp3400c_read(client, I2C_MSP3400C_DFP, 0x1f);
 	if ((-1 == msp->rev1) || (0 == msp->rev1 && 0 == msp->rev2)) {
 		kfree(msp);
-		kfree(c);
-		dprintk("msp34xx: error while reading chip version\n");
+		kfree(client);
+		msp3400_dbg("error while reading chip version\n");
 		return -1;
 	}
-	printk(KERN_INFO "msp34xx: rev1=0x%04x, rev2=0x%04x\n", msp->rev1, msp->rev2);
+	msp3400_dbg("rev1=0x%04x, rev2=0x%04x\n", msp->rev1, msp->rev2);
 
-	msp3400c_setvolume(c, msp->muted, msp->left, msp->right);
+	msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
 
-	snprintf(c->name, sizeof(c->name), "MSP34%02d%c-%c%d",
-		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
+	snprintf(client->name, sizeof(client->name), "MSP%c4%02d%c-%c%d",
+		 ((msp->rev1>>4)&0x0f) + '3',
+		 (msp->rev2>>8)&0xff, (msp->rev1&0x0f)+'@',
 		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
 	msp->opmode = opmode;
@@ -1626,7 +1651,7 @@ static int msp_attach(struct i2c_adapter
 	}
 
 	/* hello world :-) */
-	printk(KERN_INFO "msp34xx: init: chip=%s", c->name);
+	msp3400_info("chip=%s", client->name);
 	if (HAVE_NICAM(msp))
 		printk(" +nicam");
 	if (HAVE_SIMPLE(msp))
@@ -1655,20 +1680,20 @@ static int msp_attach(struct i2c_adapter
 
 	/* startup control thread if needed */
 	if (thread_func) {
-		msp->kthread = kthread_run(thread_func, c, "msp34xx");
+		msp->kthread = kthread_run(thread_func, client, "msp34xx");
 
 		if (NULL == msp->kthread)
-			printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
-		msp_wake_thread(c);
+			msp3400_warn("kernel_thread() failed\n");
+		msp_wake_thread(client);
 	}
 
 	/* done */
-	i2c_attach_client(c);
+	i2c_attach_client(client);
 
 	/* update our own array */
 	for (i = 0; i < MSP3400_MAX; i++) {
 		if (NULL == msps[i]) {
-			msps[i] = c;
+			msps[i] = client;
 			break;
 		}
 	}
@@ -1791,7 +1816,7 @@ static int msp_command(struct i2c_client
 	switch (cmd) {
 
 	case AUDC_SET_INPUT:
-		dprintk("msp34xx: AUDC_SET_INPUT(%d)\n",*sarg);
+		msp3400_dbg("AUDC_SET_INPUT(%d)\n",*sarg);
 
 		if (*sarg == msp->input)
 			break;
@@ -1832,12 +1857,9 @@ static int msp_command(struct i2c_client
 		break;
 
 	case AUDC_SET_RADIO:
-		dprintk("msp34xx: AUDC_SET_RADIO\n");
+		msp3400_dbg("AUDC_SET_RADIO\n");
 		msp->norm = VIDEO_MODE_RADIO;
-		dprintk("msp34xx: switching to radio mode\n");
-		if (IS_MSP34XX_G(msp))
-			msp34xxg_reset(client);
-
+		msp3400_dbg("switching to radio mode\n");
 		msp->watch_stereo = 0;
 		switch (msp->opmode) {
 		case OPMODE_MANUAL:
@@ -1886,7 +1908,7 @@ static int msp_command(struct i2c_client
 	{
 		struct video_audio *va = arg;
 
-		dprintk("msp34xx: VIDIOCGAUDIO\n");
+		msp3400_dbg("VIDIOCGAUDIO\n");
 		va->flags |= VIDEO_AUDIO_VOLUME |
 			VIDEO_AUDIO_BASS |
 			VIDEO_AUDIO_TREBLE |
@@ -1914,28 +1936,28 @@ static int msp_command(struct i2c_client
 	{
 		struct video_audio *va = arg;
 
-		dprintk("msp34xx: VIDIOCSAUDIO\n");
+		msp3400_dbg("VIDIOCSAUDIO\n");
 		msp->muted = (va->flags & VIDEO_AUDIO_MUTE);
 		msp->left = (MIN(65536 - va->balance, 32768) *
 			     va->volume) / 32768;
 		msp->right = (MIN(va->balance, 32768) * va->volume) / 32768;
 		msp->bass = va->bass;
 		msp->treble = va->treble;
-		dprintk("msp34xx: VIDIOCSAUDIO setting va->volume to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting va->volume to %d\n",
 			va->volume);
-		dprintk("msp34xx: VIDIOCSAUDIO setting va->balance to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting va->balance to %d\n",
 			va->balance);
-		dprintk("msp34xx: VIDIOCSAUDIO setting va->flags to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting va->flags to %d\n",
 			va->flags);
-		dprintk("msp34xx: VIDIOCSAUDIO setting msp->left to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting msp->left to %d\n",
 			msp->left);
-		dprintk("msp34xx: VIDIOCSAUDIO setting msp->right to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting msp->right to %d\n",
 			msp->right);
-		dprintk("msp34xx: VIDIOCSAUDIO setting msp->bass to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting msp->bass to %d\n",
 			msp->bass);
-		dprintk("msp34xx: VIDIOCSAUDIO setting msp->treble to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting msp->treble to %d\n",
 			msp->treble);
-		dprintk("msp34xx: VIDIOCSAUDIO setting msp->mode to %d\n",
+		msp3400_dbg("VIDIOCSAUDIO setting msp->mode to %d\n",
 			msp->mode);
 		msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
 		msp3400c_setbass(client, msp->bass);
@@ -1950,11 +1972,8 @@ static int msp_command(struct i2c_client
 	{
 		struct video_channel *vc = arg;
 
-		dprintk("msp34xx: VIDIOCSCHAN (norm=%d)\n",vc->norm);
+		msp3400_dbg("VIDIOCSCHAN (norm=%d)\n",vc->norm);
 		msp->norm = vc->norm;
-		if (IS_MSP34XX_G(msp))
-			msp34xxg_reset(client);
-
 		msp_wake_thread(client);
 		break;
 	}
@@ -1963,10 +1982,7 @@ static int msp_command(struct i2c_client
 	case VIDIOC_S_FREQUENCY:
 	{
 		/* new channel -- kick audio carrier scan */
-		dprintk("msp34xx: VIDIOCSFREQ\n");
-		if (IS_MSP34XX_G(msp))
-			msp34xxg_reset(client);
-
+		msp3400_dbg("VIDIOCSFREQ\n");
 		msp_wake_thread(client);
 		break;
 	}
@@ -1976,7 +1992,7 @@ static int msp_command(struct i2c_client
 	{
 		struct msp_matrix *mspm = arg;
 
-		dprintk("msp34xx: MSP_SET_MATRIX\n");
+		msp3400_dbg("MSP_SET_MATRIX\n");
 		msp3400c_set_scart(client, mspm->input, mspm->output);
 		break;
 	}
@@ -2153,7 +2169,8 @@ static int msp_command(struct i2c_client
 			else
 				msp->i2s_mode=0;
 		}
-		dprintk("Setting audio out on msp34xx to input %i, mode %i\n",a->index,msp->i2s_mode);
+		msp3400_dbg("Setting audio out on msp34xx to input %i, mode %i\n",
+						a->index,msp->i2s_mode);
 		msp3400c_set_scart(client,msp->in_scart,a->index+1);
 
 		break;
@@ -2168,19 +2185,19 @@ static int msp_command(struct i2c_client
 
 static int msp_suspend(struct device * dev, pm_message_t state)
 {
-	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
+	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
 
-	dprintk("msp34xx: suspend\n");
-	msp3400c_reset(c);
+	msp3400_dbg("msp34xx: suspend\n");
+	msp3400c_reset(client);
 	return 0;
 }
 
 static int msp_resume(struct device * dev)
 {
-	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
+	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
 
-	dprintk("msp34xx: resume\n");
-	msp_wake_thread(c);
+	msp3400_dbg("msp34xx: resume\n");
+	msp_wake_thread(client);
 	return 0;
 }
 


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/


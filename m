Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTELRqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbTELRqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:46:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:65429 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262382AbTELRmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:42:24 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:20:18 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #5 - i2c module updates.
Message-ID: <20030512172018.GA24304@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates a number of video4linux-related i2c modules.
There are a number of bugfixes which accumulated over time, also
some no-op i2c changes due to merging the i2c cleanups back into
my tree and tweak them to make the modules compile on both 2.5.x
and 2.4.x.

  Gerd

diff -u linux-2.5.69/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.5.69/drivers/media/video/msp3400.c	2003-05-08 13:31:11.000000000 +0200
+++ linux/drivers/media/video/msp3400.c	2003-05-08 13:55:11.000000000 +0200
@@ -45,13 +45,11 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/videodev.h>
-#include <asm/semaphore.h>
 #include <linux/init.h>
-
-#ifdef CONFIG_SMP
-#include <asm/pgtable.h>
 #include <linux/smp_lock.h>
-#endif
+#include <asm/semaphore.h>
+#include <asm/pgtable.h>
+
 /* kernel_thread */
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
@@ -59,18 +57,13 @@
 #include <media/audiochip.h>
 #include "msp3400.h"
 
-/* Addresses to scan */
-static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {0x40,0x40,I2C_CLIENT_END};
-I2C_CLIENT_INSMOD;
-
 /* insmod parameters */
-static int debug   = 0;    /* debug output */
-static int once    = 0;    /* no continous stereo monitoring */
-static int amsound = 0;    /* hard-wire AM sound at 6.5 Hz (france),
+static int debug    = 0;    /* debug output */
+static int once     = 0;    /* no continous stereo monitoring */
+static int amsound  = 0;    /* hard-wire AM sound at 6.5 Hz (france),
 			      the autoscan seems work well only with FM... */
-static int simple  = -1;   /* use short programming (>= msp3410 only) */
-static int dolby   = 0;
+static int simple   = -1;   /* use short programming (>= msp3410 only) */
+static int dolby    = 0;
 
 #define DFP_COUNT 0x41
 static const int bl_dfp[] = {
@@ -79,8 +72,9 @@
 };
 
 struct msp3400c {
+	int rev1,rev2;
+	
 	int simple;
-	int nicam;
 	int mode;
 	int norm;
 	int stereo;
@@ -107,6 +101,10 @@
 	struct timer_list    wake_stereo;
 };
 
+#define HAVE_NICAM(msp)   (((msp->rev2>>8) & 0xff) != 00)
+#define HAVE_SIMPLE(msp)  ((msp->rev1      & 0xff) >= 'D'-'@')
+#define HAVE_RADIO(msp)   ((msp->rev1      & 0xff) >= 'G'-'@')
+
 #define MSP3400_MAX 4
 static struct i2c_client *msps[MSP3400_MAX];
 
@@ -124,14 +122,25 @@
 
 MODULE_DESCRIPTION("device driver for msp34xx TV sound processor");
 MODULE_AUTHOR("Gerd Knorr");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("Dual BSD/GPL"); /* FreeBSD uses this too */
 
 /* ---------------------------------------------------------------------- */
 
 #define I2C_MSP3400C       0x80
+#define I2C_MSP3400C_ALT   0x88
+
 #define I2C_MSP3400C_DEM   0x10
 #define I2C_MSP3400C_DFP   0x12
 
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {
+	I2C_MSP3400C      >> 1,
+	I2C_MSP3400C_ALT  >> 1,
+	I2C_CLIENT_END
+};
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
+I2C_CLIENT_INSMOD;
+
 /* ----------------------------------------------------------------------- */
 /* functions for talking to the MSP3400C Sound processor                   */
 
@@ -354,7 +363,8 @@
 	if (-1 == scarts[out][in])
 		return;
 
-	dprintk("msp34xx: scart switch: %s => %d\n",scart_names[in],out);
+	dprintk(KERN_DEBUG
+		"msp34xx: scart switch: %s => %d\n",scart_names[in],out);
 	msp->acb &= ~scarts[out][SCART_MASK];
 	msp->acb |=  scarts[out][in];
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0013, msp->acb);
@@ -384,7 +394,8 @@
 		balance = ((right-left) * 127) / vol;
 	}
 
-	dprintk("msp34xx: setvolume: mute=%s %d:%d  v=0x%02x b=0x%02x\n",
+	dprintk(KERN_DEBUG
+		"msp34xx: setvolume: mute=%s %d:%d  v=0x%02x b=0x%02x\n",
 		muted ? "on" : "off", left, right, val>>8, balance);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0000, val); /* loudspeaker */
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0006, val); /* headphones  */
@@ -397,7 +408,7 @@
 {
 	int val = ((bass-32768) * 0x60 / 65535) << 8;
 
-	dprintk("msp34xx: setbass: %d 0x%02x\n",bass, val>>8);
+	dprintk(KERN_DEBUG "msp34xx: setbass: %d 0x%02x\n",bass, val>>8);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0002, val); /* loudspeaker */
 }
 
@@ -405,7 +416,7 @@
 {
 	int val = ((treble-32768) * 0x60 / 65535) << 8;
 
-	dprintk("msp34xx: settreble: %d 0x%02x\n",treble, val>>8);
+	dprintk(KERN_DEBUG "msp34xx: settreble: %d 0x%02x\n",treble, val>>8);
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0003, val); /* loudspeaker */
 }
 
@@ -414,7 +425,7 @@
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int i;
 	
-	dprintk("msp3400: setmode: %d\n",type);
+	dprintk(KERN_DEBUG "msp3400: setmode: %d\n",type);
 	msp->mode   = type;
 	msp->stereo = VIDEO_SOUND_MONO;
 
@@ -460,7 +471,7 @@
 	msp3400c_write(client,I2C_MSP3400C_DFP, 0x000e,
 		       msp_init_data[type].dfp_matrix);
 
-	if (msp->nicam) {
+	if (HAVE_NICAM(msp)) {
 		/* nicam prescale */
 		msp3400c_write(client,I2C_MSP3400C_DFP, 0x0010, 0x5a00); /* was: 0x3000 */
 	}
@@ -469,8 +480,15 @@
 /* turn on/off nicam + stereo */
 static void msp3400c_setstereo(struct i2c_client *client, int mode)
 {
-	static char *strmode[] = { "0", "mono", "stereo", "3",
-				   "lang1", "5", "6", "7", "lang2" };
+	static char *strmode[16] = {
+#if __GNUC__ >= 3
+		[ 0 ... 15 ]           = "invalid",
+#endif
+		[ VIDEO_SOUND_MONO ]   = "mono",
+		[ VIDEO_SOUND_STEREO ] = "stereo",
+		[ VIDEO_SOUND_LANG1  ] = "lang1",
+		[ VIDEO_SOUND_LANG2  ] = "lang2",
+	};
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int nicam=0; /* channel source: FM/AM or nicam */
 	int src=0;
@@ -478,7 +496,7 @@
 	/* switch demodulator */
 	switch (msp->mode) {
 	case MSP_MODE_FM_TERRA:
-		dprintk("msp3400: FM setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: FM setstereo: %s\n",strmode[mode]);
 		msp3400c_setcarrier(client,msp->second,msp->main);
 		switch (mode) {
 		case VIDEO_SOUND_STEREO:
@@ -492,7 +510,7 @@
 		}
 		break;
 	case MSP_MODE_FM_SAT:
-		dprintk("msp3400: SAT setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: SAT setstereo: %s\n",strmode[mode]);
 		switch (mode) {
 		case VIDEO_SOUND_MONO:
 			msp3400c_setcarrier(client, MSP_CARRIER(6.5), MSP_CARRIER(6.5));
@@ -511,24 +529,24 @@
 	case MSP_MODE_FM_NICAM1:
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
-		dprintk("msp3400: NICAM setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: NICAM setstereo: %s\n",strmode[mode]);
 		msp3400c_setcarrier(client,msp->second,msp->main);
 		if (msp->nicam_on)
 			nicam=0x0100;
 		break;
 	case MSP_MODE_BTSC:
-		dprintk("msp3400: BTSC setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: BTSC setstereo: %s\n",strmode[mode]);
 		nicam=0x0300;
 		break;
 	case MSP_MODE_EXTERN:
-		dprintk("msp3400: extern setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: extern setstereo: %s\n",strmode[mode]);
 		nicam = 0x0200;
 		break;
 	case MSP_MODE_FM_RADIO:
-		dprintk("msp3400: FM-Radio setstereo: %s\n",strmode[mode]);
+		dprintk(KERN_DEBUG "msp3400: FM-Radio setstereo: %s\n",strmode[mode]);
 		break;
 	default:
-		dprintk("msp3400: mono setstereo\n");
+		dprintk(KERN_DEBUG "msp3400: mono setstereo\n");
 		return;
 	}
 
@@ -557,7 +575,8 @@
 		src = 0x0010 | nicam;
 		break;
 	}
-	dprintk("msp3400: setstereo final source/matrix = 0x%x\n", src);
+	dprintk(KERN_DEBUG
+		"msp3400: setstereo final source/matrix = 0x%x\n", src);
 
 	if (dolby) {
 		msp3400c_write(client,I2C_MSP3400C_DFP, 0x0008,0x0520);
@@ -576,22 +595,22 @@
 msp3400c_print_mode(struct msp3400c *msp)
 {
 	if (msp->main == msp->second) {
-		printk("msp3400: mono sound carrier: %d.%03d MHz\n",
+		printk(KERN_DEBUG "msp3400: mono sound carrier: %d.%03d MHz\n",
 		       msp->main/910000,(msp->main/910)%1000);
 	} else {
-		printk("msp3400: main sound carrier: %d.%03d MHz\n",
+		printk(KERN_DEBUG "msp3400: main sound carrier: %d.%03d MHz\n",
 		       msp->main/910000,(msp->main/910)%1000);
 	}
 	if (msp->mode == MSP_MODE_FM_NICAM1 ||
 	    msp->mode == MSP_MODE_FM_NICAM2)
-		printk("msp3400: NICAM/FM carrier   : %d.%03d MHz\n",
+		printk(KERN_DEBUG "msp3400: NICAM/FM carrier   : %d.%03d MHz\n",
 		       msp->second/910000,(msp->second/910)%1000);
 	if (msp->mode == MSP_MODE_AM_NICAM)
-		printk("msp3400: NICAM/AM carrier   : %d.%03d MHz\n",
+		printk(KERN_DEBUG "msp3400: NICAM/AM carrier   : %d.%03d MHz\n",
 		       msp->second/910000,(msp->second/910)%1000);
 	if (msp->mode == MSP_MODE_FM_TERRA &&
 	    msp->main != msp->second) {
-		printk("msp3400: FM-stereo carrier : %d.%03d MHz\n",
+		printk(KERN_DEBUG "msp3400: FM-stereo carrier : %d.%03d MHz\n",
 		       msp->second/910000,(msp->second/910)%1000);
 	}
 }
@@ -638,8 +657,8 @@
 		val = msp3400c_read(client, I2C_MSP3400C_DFP, 0x18);
 		if (val > 32767)
 			val -= 65536;
-		dprintk("msp34xx: stereo detect register: %d\n",val);
-		
+		dprintk(KERN_DEBUG
+			"msp34xx: stereo detect register: %d\n",val);
 		if (val > 4096) {
 			newstereo = VIDEO_SOUND_STEREO | VIDEO_SOUND_MONO;
 		} else if (val < -4096) {
@@ -653,7 +672,9 @@
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
 		val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x23);
-		dprintk("msp34xx: nicam sync=%d, mode=%d\n",val & 1, (val & 0x1e) >> 1);
+		dprintk(KERN_DEBUG
+			"msp34xx: nicam sync=%d, mode=%d\n",
+			val & 1, (val & 0x1e) >> 1);
 
 		if (val & 1) {
 			/* nicam synced */
@@ -685,7 +706,8 @@
 		break;
 	case MSP_MODE_BTSC:
 		val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x200);
-		dprintk("msp3410: status=0x%x (pri=%s, sec=%s, %s%s%s)\n",
+		dprintk(KERN_DEBUG
+			"msp3410: status=0x%x (pri=%s, sec=%s, %s%s%s)\n",
 			val,
 			(val & 0x0002) ? "no"     : "yes",
 			(val & 0x0004) ? "no"     : "yes",
@@ -699,13 +721,13 @@
 	}
 	if (newstereo != msp->stereo) {
 		update = 1;
-		dprintk("msp34xx: watch: stereo %d => %d\n",
+		dprintk(KERN_DEBUG "msp34xx: watch: stereo %d => %d\n",
 			msp->stereo,newstereo);
 		msp->stereo   = newstereo;
 	}
 	if (newnicam != msp->nicam_on) {
 		update = 1;
-		dprintk("msp34xx: watch: nicam %d => %d\n",
+		dprintk(KERN_DEBUG "msp34xx: watch: nicam %d => %d\n",
 			msp->nicam_on,newnicam);
 		msp->nicam_on = newnicam;
 	}
@@ -734,6 +756,8 @@
 			msp3400c_setstereo(client,VIDEO_SOUND_STEREO);
 		else if (msp->stereo & VIDEO_SOUND_LANG1)
 			msp3400c_setstereo(client,VIDEO_SOUND_LANG1);
+		else if (msp->stereo & VIDEO_SOUND_LANG2)
+			msp3400c_setstereo(client,VIDEO_SOUND_LANG2);
 		else
 			msp3400c_setstereo(client,VIDEO_SOUND_MONO);
 	}
@@ -751,17 +775,10 @@
 	struct CARRIER_DETECT *cd;
 	int count, max1,max2,val1,val2, val,this;
 	
-#ifdef CONFIG_SMP
 	lock_kernel();
-#endif
-	
 	daemonize("msp3400");
-
 	msp->thread = current;
-
-#ifdef CONFIG_SMP
 	unlock_kernel();
-#endif
 
 	printk("msp3400: daemon started\n");
 	if(msp->notify != NULL)
@@ -778,10 +795,6 @@
 		if (msp->rmmod || signal_pending(current))
 			goto done;
 
-		if (VIDEO_MODE_RADIO == msp->norm ||
-		    MSP_MODE_EXTERN  == msp->mode)
-			continue;  /* nothing to do */
-	
 		msp->active = 1;
 
 		if (msp->watch_stereo) {
@@ -798,8 +811,13 @@
 		
 	restart:
 		if (VIDEO_MODE_RADIO == msp->norm ||
-		    MSP_MODE_EXTERN  == msp->mode)
-			continue;  /* nothing to do */
+		    MSP_MODE_EXTERN  == msp->mode) {
+			/* no carrier scan, just unmute */
+			printk("msp3400: thread: no carrier scan\n");
+			msp3400c_setvolume(client, msp->muted,
+					   msp->left, msp->right);
+			continue;
+		}
 		msp->restart = 0;
 		msp3400c_setvolume(client, msp->muted, 0, 0);
 		msp3400c_setmode(client, MSP_MODE_AM_DETECT /* +1 */ );
@@ -884,7 +902,7 @@
 				msp->nicam_on = 0;
 				msp3400c_setstereo(client, VIDEO_SOUND_MONO);
 				msp->watch_stereo = 1;
-			} else if (max2 == 1 && msp->nicam) {
+			} else if (max2 == 1 && HAVE_NICAM(msp)) {
 				/* B/G NICAM */
 				msp->second = carrier_detect_55[max2].cdo;
 				msp3400c_setmode(client, MSP_MODE_FM_NICAM1);
@@ -922,7 +940,7 @@
 				/* volume prescale for SCART (AM mono input) */
 				msp3400c_write(client,I2C_MSP3400C_DFP, 0x000d, 0x1900);
 				msp->watch_stereo = 1;
-			} else if (max2 == 0 && msp->nicam) {
+			} else if (max2 == 0 && HAVE_NICAM(msp)) {
 				/* D/K NICAM */
 				msp->second = carrier_detect_65[max2].cdo;
 				msp3400c_setmode(client, MSP_MODE_FM_NICAM1);
@@ -959,7 +977,7 @@
 	}
 
 done:
-	dprintk("msp3400: thread: exit\n");
+	dprintk(KERN_DEBUG "msp3400: thread: exit\n");
 	msp->active = 0;
 	msp->thread = NULL;
 
@@ -1005,17 +1023,10 @@
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int mode,val,i,std;
     
-#ifdef CONFIG_SMP
 	lock_kernel();
-#endif
-    
 	daemonize("msp3410 [auto]");
-
 	msp->thread = current;
-
-#ifdef CONFIG_SMP
 	unlock_kernel();
-#endif
 
 	printk("msp3410: daemon started\n");
 	if(msp->notify != NULL)
@@ -1025,16 +1036,13 @@
 		if (msp->rmmod)
 			goto done;
 		if (debug > 1)
-			printk("msp3410: thread: sleep\n");
+			printk(KERN_DEBUG "msp3410: thread: sleep\n");
 		interruptible_sleep_on(&msp->wq);
 		if (debug > 1)
-			printk("msp3410: thread: wakeup\n");
+			printk(KERN_DEBUG "msp3410: thread: wakeup\n");
 		if (msp->rmmod || signal_pending(current))
 			goto done;
 
-		if (msp->mode == MSP_MODE_EXTERN)
-			continue;
-		
 		msp->active = 1;
 
 		if (msp->watch_stereo) {
@@ -1050,8 +1058,13 @@
 			goto done;
 
 	restart:
-		if (msp->mode == MSP_MODE_EXTERN)
+		if (msp->mode == MSP_MODE_EXTERN) {
+			/* no carrier scan needed, just unmute */
+			dprintk(KERN_DEBUG "msp3410: thread: no carrier scan\n");
+			msp3400c_setvolume(client, msp->muted,
+					   msp->left, msp->right);
 			continue;
+		}
 		msp->restart = 0;
 		del_timer(&msp->wake_stereo);
 		msp->watch_stereo = 0;
@@ -1073,7 +1086,7 @@
 			mode = 0x0003;
 			std  = 1;
 			break;
-		case VIDEO_MODE_RADIO: 
+		case VIDEO_MODE_RADIO:
 			mode = 0x0003;
 			std  = 0x0040;
 			break;
@@ -1090,7 +1103,7 @@
 			for (i = 0; modelist[i].name != NULL; i++)
 				if (modelist[i].retval == std)
 					break;
-			printk("msp3410: setting mode: %s (0x%04x)\n",
+			printk(KERN_DEBUG "msp3410: setting mode: %s (0x%04x)\n",
 			       modelist[i].name ? modelist[i].name : "unknown",std);
 		}
 
@@ -1111,13 +1124,13 @@
 				val = msp3400c_read(client, I2C_MSP3400C_DEM, 0x7e);
 				if (val < 0x07ff)
 					break;
-				dprintk("msp3410: detection still in progress\n");
+				dprintk(KERN_DEBUG "msp3410: detection still in progress\n");
 			}
 		}
 		for (i = 0; modelist[i].name != NULL; i++)
 			if (modelist[i].retval == val)
 				break;
-		dprintk("msp3410: current mode: %s (0x%04x)\n",
+		dprintk(KERN_DEBUG "msp3410: current mode: %s (0x%04x)\n",
 			modelist[i].name ? modelist[i].name : "unknown",
 			val);
 		msp->main   = modelist[i].main;
@@ -1125,7 +1138,8 @@
 
 		if (amsound && (msp->norm == VIDEO_MODE_SECAM) && (val != 0x0009)) {
 			/* autodetection has failed, let backup */
-			dprintk("msp3410: autodetection failed, switching to backup mode: %s (0x%04x)\n",
+			dprintk(KERN_DEBUG "msp3410: autodetection failed,"
+				" switching to backup mode: %s (0x%04x)\n",
 				modelist[8].name ? modelist[8].name : "unknown",val);
 			val = 0x0009;
 			msp3400c_write(client, I2C_MSP3400C_DEM, 0x20, val);
@@ -1170,11 +1184,24 @@
 			msp->stereo = VIDEO_SOUND_STEREO;
 			msp->nicam_on = 0;
 			msp->watch_stereo = 0;
+			/* not needed in theory if HAVE_RADIO(), but
+			   short programming enables carrier mute */
+			msp3400c_setmode(client,MSP_MODE_FM_RADIO);
+			msp3400c_setcarrier(client, MSP_CARRIER(10.7),
+					    MSP_CARRIER(10.7));
 			/* scart routing */
 			msp3400c_set_scart(client,SCART_IN2,0);
+#if 0
+			/* radio from SCART_IN2 */
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x08, 0x0220);
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x09, 0x0220);
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x0b, 0x0220);
+#else
+			/* msp34xx does radio decoding */
+			msp3400c_write(client,I2C_MSP3400C_DFP, 0x08, 0x0020);
+			msp3400c_write(client,I2C_MSP3400C_DFP, 0x09, 0x0020);
+			msp3400c_write(client,I2C_MSP3400C_DFP, 0x0b, 0x0020);
+#endif
 			break;
 		case 0x0003:
 			msp->mode   = MSP_MODE_FM_TERRA;
@@ -1197,7 +1224,7 @@
 	}
 
 done:
-	dprintk("msp3410: thread: exit\n");
+	dprintk(KERN_DEBUG "msp3410: thread: exit\n");
 	msp->active = 0;
 	msp->thread = NULL;
 
@@ -1225,11 +1252,9 @@
 
 static struct i2c_client client_template = 
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
-	.dev	= {
-		.name   = "(unset)",
-	},
+	I2C_DEVNAME("(unset)"),
+	.flags     = I2C_CLIENT_ALLOW_USE,
+        .driver    = &driver,
 };
 
 static int msp_attach(struct i2c_adapter *adap, int addr, int kind)
@@ -1237,7 +1262,7 @@
 	DECLARE_MUTEX_LOCKED(sem);
 	struct msp3400c *msp;
         struct i2c_client *c;
-	int              rev1,rev2,i;
+	int i;
 
         client_template.adapter = adap;
         client_template.addr = addr;
@@ -1275,10 +1300,10 @@
 		return -1;
 	}
     
-	rev1 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1e);
-	if (-1 != rev1)
-		rev2 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1f);
-	if ((-1 == rev1) || (0 == rev1 && 0 == rev2)) {
+	msp->rev1 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1e);
+	if (-1 != msp->rev1)
+		msp->rev2 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1f);
+	if ((-1 == msp->rev1) || (0 == msp->rev1 && 0 == msp->rev2)) {
 		kfree(msp);
 		kfree(c);
 		printk("msp3400: error while reading chip version\n");
@@ -1292,13 +1317,12 @@
 	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
 	snprintf(c->dev.name, DEVICE_NAME_SIZE, "MSP34%02d%c-%c%d",
-		(rev2>>8)&0xff, (rev1&0xff)+'@', ((rev1>>8)&0xff)+'@', rev2&0x1f);
-	msp->nicam = (((rev2>>8)&0xff) != 00) ? 1 : 0;
+		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
+		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
 	if (simple == -1) {
 		/* default mode */
-		/* msp->simple = (((rev2>>8)&0xff) == 0) ? 0 : 1; */
-		msp->simple = ((rev1&0xff)+'@' > 'C');
+		msp->simple = HAVE_SIMPLE(msp);
 	} else {
 		/* use insmod option */
 		msp->simple = simple;
@@ -1310,13 +1334,16 @@
 	msp->wake_stereo.data     = (unsigned long)msp;
 
 	/* hello world :-) */
-	printk(KERN_INFO "msp34xx: init: chip=%s",c->dev.name);
-	if (msp->nicam)
-		printk(", has NICAM support");
+	printk(KERN_INFO "msp34xx: init: chip=%s",i2c_clientname(c));
+	if (HAVE_NICAM(msp))
+		printk(" +nicam");
+	if (HAVE_SIMPLE(msp))
+		printk(" +simple");
+	if (HAVE_RADIO(msp))
+		printk(" +radio");
 	printk("\n");
 
 	/* startup control thread */
-	MOD_INC_USE_COUNT;
 	msp->notify = &sem;
 	kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
 		      (void *)c, 0);
@@ -1340,7 +1367,7 @@
 static int msp_detach(struct i2c_client *client)
 {
 	DECLARE_MUTEX_LOCKED(sem);
-	struct msp3400c *msp = i2c_get_clientdata(client);
+	struct msp3400c *msp  = i2c_get_clientdata(client);
 	int i;
 	
 	/* shutdown control thread */
@@ -1366,7 +1393,6 @@
 	i2c_detach_client(client);
 	kfree(msp);
 	kfree(client);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1379,7 +1405,7 @@
 
 static void msp_wake_thread(struct i2c_client *client)
 {
-	struct msp3400c *msp = i2c_get_clientdata(client);
+	struct msp3400c *msp  = i2c_get_clientdata(client);
 
 	msp3400c_setvolume(client,msp->muted,0,0);
 	msp->watch_stereo=0;
@@ -1391,7 +1417,7 @@
 
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct msp3400c *msp = i2c_get_clientdata(client);
+	struct msp3400c *msp  = i2c_get_clientdata(client);
         __u16           *sarg = arg;
 #if 0
 	int             *iarg = (int*)arg;
@@ -1440,7 +1466,7 @@
 		msp->norm = VIDEO_MODE_RADIO;
 		msp->watch_stereo=0;
 		del_timer(&msp->wake_stereo);
-		dprintk("msp34xx: switching to radio mode\n");
+		dprintk(KERN_DEBUG "msp34xx: switching to radio mode\n");
 		if (msp->simple) {
 			/* the thread will do for us */
 			msp_wake_thread(client);
@@ -1459,11 +1485,11 @@
 	case MSP_SET_DFPREG:
 	{
 		struct msp_dfpreg *r = arg;
-		int i;
+		unsigned int i;
 
 		if (r->reg < 0 || r->reg >= DFP_COUNT)
 			return -EINVAL;
-		for (i = 0; i < sizeof(bl_dfp)/sizeof(int); i++)
+		for (i = 0; i < ARRAY_SIZE(bl_dfp); i++)
 			if (r->reg == bl_dfp[i])
 				return -EINVAL;
 		msp->dfp_regs[r->reg] = r->value;
@@ -1527,11 +1553,11 @@
 		msp3400c_setbass(client,msp->bass);
 		msp3400c_settreble(client,msp->treble);
 
-		if (va->mode != 0) {
+		if (va->mode != 0 && msp->norm != VIDEO_MODE_RADIO) {
 			msp->watch_stereo=0;
 			del_timer(&msp->wake_stereo);
-			msp->stereo = va->mode;
-			msp3400c_setstereo(client,va->mode);
+			msp->stereo = va->mode & 0x0f;
+			msp3400c_setstereo(client,va->mode & 0x0f);
 		}
 		break;
 	}
@@ -1540,7 +1566,6 @@
 		struct video_channel *vc = arg;
 		
 		dprintk(KERN_DEBUG "msp34xx: VIDIOCSCHAN\n");
-		dprintk("msp34xx: switching to TV mode\n");
 		msp->norm = vc->norm;
 		break;
 	}
diff -u linux-2.5.69/drivers/media/video/tda7432.c linux/drivers/media/video/tda7432.c
--- linux-2.5.69/drivers/media/video/tda7432.c	2003-05-08 13:31:32.000000000 +0200
+++ linux/drivers/media/video/tda7432.c	2003-05-08 13:55:11.000000000 +0200
@@ -330,8 +330,6 @@
 	i2c_set_clientdata(client, t);
 	
 	do_tda7432_init(client);
-	MOD_INC_USE_COUNT;
-	strncpy(client->dev.name, "TDA7432", DEVICE_NAME_SIZE);
 	printk(KERN_INFO "tda7432: init\n");
 
 	i2c_attach_client(client);
@@ -347,13 +345,12 @@
 
 static int tda7432_detach(struct i2c_client *client)
 {
-	struct tda7432 *t = i2c_get_clientdata(client);
+	struct tda7432 *t  = i2c_get_clientdata(client);
 
 	do_tda7432_init(client);
 	i2c_detach_client(client);
 	
 	kfree(t);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -525,11 +522,9 @@
 
 static struct i2c_client client_template =
 {
-        .id     = -1,
-	.driver = &driver, 
-        .dev	= {
-		.name	= "tda7432",
-	},
+	I2C_DEVNAME("tda7432"),
+        .id         = -1,
+	.driver     = &driver, 
 };
 
 static int tda7432_init(void)
diff -u linux-2.5.69/drivers/media/video/tda9875.c linux/drivers/media/video/tda9875.c
--- linux-2.5.69/drivers/media/video/tda9875.c	2003-05-08 13:30:39.000000000 +0200
+++ linux/drivers/media/video/tda9875.c	2003-05-08 13:55:11.000000000 +0200
@@ -161,7 +161,8 @@
 	struct tda9875 *tda = i2c_get_clientdata(client);
 	unsigned char a;
 
-	dprintk(KERN_DEBUG "tda9875_set(%04x,%04x,%04x,%04x)\n",tda->lvol,tda->rvol,tda->bass,tda->treble);
+	dprintk(KERN_DEBUG "tda9875_set(%04x,%04x,%04x,%04x)\n",
+		tda->lvol,tda->rvol,tda->bass,tda->treble);
 
 
 	a = tda->lvol & 0xff;
@@ -263,8 +264,6 @@
 	}
 	
 	do_tda9875_init(client);
-	MOD_INC_USE_COUNT;
-	strncpy(client->dev.name, "TDA9875", DEVICE_NAME_SIZE);
 	printk(KERN_INFO "tda9875: init\n");
 
 	i2c_attach_client(client);
@@ -280,13 +279,12 @@
 
 static int tda9875_detach(struct i2c_client *client)
 {
-	struct tda9875 *t = i2c_get_clientdata(client);
+	struct tda9875 *t  = i2c_get_clientdata(client);
 
 	do_tda9875_init(client);
 	i2c_detach_client(client);
 	
 	kfree(t);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -395,11 +393,9 @@
 
 static struct i2c_client client_template =
 {
-        .id      = -1,
-        .driver  = &driver,
-        .dev	= {
-		.name	= "tda9875",
-	},
+        I2C_DEVNAME("tda9875"),
+        .id        = -1,
+        .driver    = &driver,
 };
 
 static int tda9875_init(void)
diff -u linux-2.5.69/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.5.69/drivers/media/video/tda9887.c	2003-05-08 13:29:42.000000000 +0200
+++ linux/drivers/media/video/tda9887.c	2003-05-08 13:55:11.000000000 +0200
@@ -293,8 +293,6 @@
 	unsigned char *buf = NULL;
 	int rc;
 
-	printk("tda9887_configure\n");
-
 	if (t->radio) {
 		dprintk("tda9885/6/7: FM Radio mode\n");
 		buf = buf_fm_stereo;
@@ -358,11 +356,11 @@
                 return -ENOMEM;
 	memset(t,0,sizeof(*t));
 	t->client = client_template;
-        i2c_set_clientdata(&t->client, t);
 	t->pinnacle_id = -1;
+	t->tvnorm=VIDEO_MODE_PAL;
+        i2c_set_clientdata(&t->client, t);
         i2c_attach_client(&t->client);
         
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -379,7 +377,6 @@
 
 	i2c_detach_client(client);
 	kfree(t);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -404,6 +401,7 @@
 		int *i = arg;
 
 		t->pinnacle_id = *i;
+		tda9887_miro(t);
 		break;
 	}
 	/* --- v4l ioctls --- */
@@ -441,11 +439,9 @@
 };
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
-        .dev	= {
-		.name	= "tda9887",
-	},
+        .dev.name  = "tda9887",
+	.flags     = I2C_CLIENT_ALLOW_USE,
+        .driver    = &driver,
 };
 
 static int tda9887_init_module(void)
diff -u linux-2.5.69/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.5.69/drivers/media/video/tvaudio.c	2003-05-08 13:30:27.000000000 +0200
+++ linux/drivers/media/video/tvaudio.c	2003-05-08 13:55:11.000000000 +0200
@@ -34,19 +34,19 @@
 
 #include "tvaudio.h"
 
-
 /* ---------------------------------------------------------------------- */
 /* insmod args                                                            */
 
 MODULE_PARM(debug,"i");
 static int debug = 0;	/* insmod parameter */
 
-#define dprintk  if (debug) printk
-
 MODULE_DESCRIPTION("device driver for various i2c TV sound decoder / audiomux chips");
 MODULE_AUTHOR("Eric Sandeen, Steve VanDeBogart, Greg Alexander, Gerd Knorr");
 MODULE_LICENSE("GPL");
 
+#define UNSET    (-1U)
+#define dprintk  if (debug) printk
+
 /* ---------------------------------------------------------------------- */
 /* our structs                                                            */
 
@@ -161,22 +161,24 @@
 	unsigned char buffer[2];
 
 	if (-1 == subaddr) {
-		dprintk("%s: chip_write: 0x%x\n", chip->c.dev.name, val);
+		dprintk("%s: chip_write: 0x%x\n",
+			i2c_clientname(&chip->c), val);
 		chip->shadow.bytes[1] = val;
 		buffer[0] = val;
 		if (1 != i2c_master_send(&chip->c,buffer,1)) {
 			printk(KERN_WARNING "%s: I/O error (write 0x%x)\n",
-			       chip->c.dev.name, val);
+			       i2c_clientname(&chip->c), val);
 			return -1;
 		}
 	} else {
-		dprintk("%s: chip_write: reg%d=0x%x\n", chip->c.dev.name, subaddr, val);
+		dprintk("%s: chip_write: reg%d=0x%x\n",
+			i2c_clientname(&chip->c), subaddr, val);
 		chip->shadow.bytes[subaddr+1] = val;
 		buffer[0] = subaddr;
 		buffer[1] = val;
 		if (2 != i2c_master_send(&chip->c,buffer,2)) {
 			printk(KERN_WARNING "%s: I/O error (write reg%d=0x%x)\n",
-			       chip->c.dev.name, subaddr, val);
+			       i2c_clientname(&chip->c), subaddr, val);
 			return -1;
 		}
 	}
@@ -201,10 +203,10 @@
 
 	if (1 != i2c_master_recv(&chip->c,&buffer,1)) {
 		printk(KERN_WARNING "%s: I/O error (read)\n",
-		       chip->c.dev.name);
+		       i2c_clientname(&chip->c));
 		return -1;
 	}
-	dprintk("%s: chip_read: 0x%x\n",chip->c.dev.name,buffer); 
+	dprintk("%s: chip_read: 0x%x\n",i2c_clientname(&chip->c),buffer); 
 	return buffer;
 }
 
@@ -220,11 +222,11 @@
 
 	if (2 != i2c_transfer(chip->c.adapter,msgs,2)) {
 		printk(KERN_WARNING "%s: I/O error (read2)\n",
-		       chip->c.dev.name);
+		       i2c_clientname(&chip->c));
 		return -1;
 	}
 	dprintk("%s: chip_read2: reg%d=0x%x\n",
-		chip->c.dev.name,subaddr,read[0]); 
+		i2c_clientname(&chip->c),subaddr,read[0]); 
 	return read[0];
 }
 
@@ -237,7 +239,7 @@
 
 	/* update our shadow register set; print bytes if (debug > 0) */
 	dprintk("%s: chip_cmd(%s): reg=%d, data:",
-		chip->c.dev.name,name,cmd->bytes[0]);
+		i2c_clientname(&chip->c),name,cmd->bytes[0]);
 	for (i = 1; i < cmd->count; i++) {
 		dprintk(" 0x%x",cmd->bytes[i]);
 		chip->shadow.bytes[i+cmd->bytes[0]] = cmd->bytes[i];
@@ -246,7 +248,7 @@
 
 	/* send data to the chip */
 	if (cmd->count != i2c_master_send(&chip->c,cmd->bytes,cmd->count)) {
-		printk(KERN_WARNING "%s: I/O error (%s)\n", chip->c.dev.name, name);
+		printk(KERN_WARNING "%s: I/O error (%s)\n", i2c_clientname(&chip->c), name);
 		return -1;
 	}
 	return 0;
@@ -270,22 +272,18 @@
         struct CHIPSTATE *chip = data;
 	struct CHIPDESC  *desc = chiplist + chip->type;
 	
-#ifdef CONFIG_SMP
 	lock_kernel();
-#endif
-	daemonize("%s", chip->c.dev.name);
+	daemonize("%s",i2c_clientname(&chip->c));
 	chip->thread = current;
-#ifdef CONFIG_SMP
 	unlock_kernel();
-#endif
 
-	dprintk("%s: thread started\n", chip->c.dev.name);
+	dprintk("%s: thread started\n", i2c_clientname(&chip->c));
 	if(chip->notify != NULL)
 		up(chip->notify);
 
 	for (;;) {
 		interruptible_sleep_on(&chip->wq);
-		dprintk("%s: thread wakeup\n", chip->c.dev.name);
+		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
 		if (chip->done || signal_pending(current))
 			break;
 
@@ -301,7 +299,7 @@
 	}
 
 	chip->thread = NULL;
-	dprintk("%s: thread exiting\n", chip->c.dev.name);
+	dprintk("%s: thread exiting\n", i2c_clientname(&chip->c));
 	if(chip->notify != NULL)
 		up(chip->notify);
 
@@ -316,7 +314,7 @@
 	if (mode == chip->prevmode)
 	    return;
 
-	dprintk("%s: thread checkmode\n", chip->c.dev.name);
+	dprintk("%s: thread checkmode\n", i2c_clientname(&chip->c));
 	chip->prevmode = mode;
 
 	if (mode & VIDEO_SOUND_STEREO)
@@ -764,9 +762,9 @@
 static int tda9874a_dic = -1;		/* device id. code */
 
 /* insmod options for tda9874a */
-static int tda9874a_SIF = -1;
-static int tda9874a_AMSEL = -1;
-static int tda9874a_STD = -1;
+static unsigned int tda9874a_SIF   = UNSET;
+static unsigned int tda9874a_AMSEL = UNSET;
+static unsigned int tda9874a_STD   = UNSET;
 MODULE_PARM(tda9874a_SIF,"i");
 MODULE_PARM(tda9874a_AMSEL,"i");
 MODULE_PARM(tda9874a_STD,"i");
@@ -981,7 +979,7 @@
 	dprintk("tda9874a_checkit(): DIC=0x%X, SIC=0x%X.\n", dic, sic);
 
 	if((dic == 0x11)||(dic == 0x07)) {
-		dprintk("tvaudio: found tda9874%s.\n",(dic == 0x11) ? "a (new)":"h (old)");
+		printk("tvaudio: found tda9874%s.\n", (dic == 0x11) ? "a":"h");
 		tda9874a_dic = dic;	/* remember device id. */
 		return 1;
 	}
@@ -990,35 +988,27 @@
 
 static int tda9874a_initialize(struct CHIPSTATE *chip)
 {
-	if(tda9874a_SIF != -1) {
-		if(tda9874a_SIF == 1)
-			tda9874a_GCONR = 0xc0;	/* sound IF input 1 */
-		else if(tda9874a_SIF == 2)
-			tda9874a_GCONR = 0xc1;	/* sound IF input 2 */
-		else
-			printk(KERN_WARNING "tda9874a: SIF parameter must be 1 or 2.\n");
-	}
+	if (tda9874a_SIF > 2)
+		tda9874a_SIF = 1;
+	if (tda9874a_STD >= 8)
+		tda9874a_STD = 0;
+	if(tda9874a_AMSEL > 1)
+		tda9874a_AMSEL = 0;
 
-	if(tda9874a_STD != -1) {
-		if((tda9874a_STD >= 0)&&(tda9874a_STD <= 8)) {
-			tda9874a_ESP = tda9874a_STD;
-			tda9874a_mode = (tda9874a_STD < 5) ? 0 : 1;
-		} else {
-			printk(KERN_WARNING "tda9874a: STD parameter must be between 0 and 8.\n");
-		}
-	}
+	if(tda9874a_SIF == 1)
+		tda9874a_GCONR = 0xc0;	/* sound IF input 1 */
+	else
+		tda9874a_GCONR = 0xc1;	/* sound IF input 2 */
 
-	if(tda9874a_AMSEL != -1) {
-		if(tda9874a_AMSEL == 0)
-			tda9874a_NCONR = 0x01; /* auto-mute: analog mono input */
-		else if(tda9874a_AMSEL == 1)
-			tda9874a_NCONR = 0x05; /* auto-mute: 1st carrier FM or AM */
-		else
-			printk(KERN_WARNING "tda9874a: AMSEL parameter must be 0 or 1.\n");
-	}
+	tda9874a_ESP = tda9874a_STD;
+	tda9874a_mode = (tda9874a_STD < 5) ? 0 : 1;
 
-	tda9874a_setup(chip);
+	if(tda9874a_AMSEL == 0)
+		tda9874a_NCONR = 0x01; /* auto-mute: analog mono input */
+	else
+		tda9874a_NCONR = 0x05; /* auto-mute: 1st carrier FM or AM */
 
+	tda9874a_setup(chip);
 	return 0;
 }
 
@@ -1132,6 +1122,87 @@
 #define PIC16C54_MISC_SWITCH_TUNER     0x40 /* bit 6	, Switch to Line-in */
 #define PIC16C54_MISC_SWITCH_LINE      0x80 /* bit 7	, Switch to Tuner */
 
+/* ---------------------------------------------------------------------- */
+/* audio chip descriptions - defines+functions for TA8874Z                */
+
+// write 1st byte
+#define TA8874Z_LED_STE	0x80
+#define TA8874Z_LED_BIL	0x40
+#define TA8874Z_LED_EXT	0x20
+#define TA8874Z_MONO_SET	0x10
+#define TA8874Z_MUTE	0x08
+#define TA8874Z_F_MONO	0x04
+#define TA8874Z_MODE_SUB	0x02
+#define TA8874Z_MODE_MAIN	0x01
+
+// write 2nd byte
+//#define TA8874Z_TI	0x80  // test mode
+#define TA8874Z_SEPARATION	0x3f
+#define TA8874Z_SEPARATION_DEFAULT	0x10
+
+// read
+#define TA8874Z_B1	0x80
+#define TA8874Z_B0	0x40
+#define TA8874Z_CHAG_FLAG	0x20
+
+//        B1 B0
+// mono    L  H
+// stereo  L  L
+// BIL     H  L
+
+static int ta8874z_getmode(struct CHIPSTATE *chip)
+{
+	int val, mode;
+	
+	val = chip_read(chip);
+	mode = VIDEO_SOUND_MONO;
+	if (val & TA8874Z_B1){
+		mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
+	}else if (!(val & TA8874Z_B0)){
+		mode |= VIDEO_SOUND_STEREO;
+	}
+	//dprintk ("ta8874z_getmode(): raw chip read: 0x%02x, return: 0x%02x\n", val, mode);
+	return mode;
+}
+
+static audiocmd ta8874z_stereo = { 2, {0, TA8874Z_SEPARATION_DEFAULT}};
+static audiocmd ta8874z_mono = {2, { TA8874Z_MONO_SET, TA8874Z_SEPARATION_DEFAULT}};
+static audiocmd ta8874z_main = {2, { 0, TA8874Z_SEPARATION_DEFAULT}};
+static audiocmd ta8874z_sub = {2, { TA8874Z_MODE_SUB, TA8874Z_SEPARATION_DEFAULT}};
+
+static void ta8874z_setmode(struct CHIPSTATE *chip, int mode)
+{
+	int update = 1;
+	audiocmd *t = NULL;
+	dprintk("ta8874z_setmode(): mode: 0x%02x\n", mode);
+
+	switch(mode){
+	case VIDEO_SOUND_MONO:
+		t = &ta8874z_mono;
+		break;
+	case VIDEO_SOUND_STEREO:
+		t = &ta8874z_stereo;
+		break;
+	case VIDEO_SOUND_LANG1:
+		t = &ta8874z_main;
+		break;
+	case VIDEO_SOUND_LANG2:
+		t = &ta8874z_sub;
+		break;
+	default:
+		update = 0;
+	}
+
+	if(update)
+		chip_cmd(chip, "TA8874Z", t);
+}
+
+static int ta8874z_checkit(struct CHIPSTATE *chip)
+{
+	int rc;
+	rc = chip_read(chip);
+	return ((rc & 0x1f) == 0x1f) ? 1 : 0;
+}
 
 /* ---------------------------------------------------------------------- */
 /* audio chip descriptions - struct CHIPDESC                              */
@@ -1143,9 +1214,11 @@
 int tda9855  = 1;
 int tda9873  = 1;
 int tda9874a = 1;
-int tea6300  = 0;
+int tea6300  = 0;  // address clash with msp34xx
 int tea6420  = 1;
 int pic16c54 = 1;
+int ta8874z  = 0;  // address clash with tda9840
+
 MODULE_PARM(tda8425,"i");
 MODULE_PARM(tda9840,"i");
 MODULE_PARM(tda9850,"i");
@@ -1155,6 +1228,7 @@
 MODULE_PARM(tea6300,"i");
 MODULE_PARM(tea6420,"i");
 MODULE_PARM(pic16c54,"i");
+MODULE_PARM(ta8874z,"i");
 
 static struct CHIPDESC chiplist[] = {
 	{
@@ -1319,7 +1393,23 @@
 			     PIC16C54_MISC_SND_NOTMUTE},
 		.inputmute  = PIC16C54_MISC_SND_MUTE,
 	},
-	{ name: NULL } /* EOF */
+	{
+		.name       = "ta8874z",
+		.id         = -1,
+		//.id         = I2C_DRIVERID_TA8874Z,
+		.checkit    = ta8874z_checkit,
+		.insmodopt  = &ta8874z,
+		.addr_lo    = I2C_TDA9840 >> 1,
+		.addr_hi    = I2C_TDA9840 >> 1,
+		.registers  = 2,
+
+		.getmode    = ta8874z_getmode,
+		.setmode    = ta8874z_setmode,
+		.checkmode  = generic_checkmode,
+
+	        .init       = {2, { TA8874Z_MONO_SET, TA8874Z_SEPARATION_DEFAULT}},
+	},
+	{ .name = NULL } /* EOF */
 };
 
 
@@ -1356,19 +1446,18 @@
 		dprintk("tvaudio: no matching chip description found\n");
 		return -EIO;
 	}
-	printk("tvaudio: found %s\n",desc->name);
+	printk("tvaudio: found %s @ 0x%x\n", desc->name, addr<<1);
 	dprintk("tvaudio: matches:%s%s%s.\n",
 		(desc->flags & CHIP_HAS_VOLUME)     ? " volume"      : "",
 		(desc->flags & CHIP_HAS_BASSTREBLE) ? " bass/treble" : "",
 		(desc->flags & CHIP_HAS_INPUTSEL)   ? " audiomux"    : "");
 
 	/* fill required data structures */
-	strncpy(chip->c.dev.name, desc->name, DEVICE_NAME_SIZE);
+	strcpy(i2c_clientname(&chip->c),desc->name);
 	chip->type = desc-chiplist;
 	chip->shadow.count = desc->registers+1;
         chip->prevmode = -1;
 	/* register */
-	MOD_INC_USE_COUNT;
 	i2c_attach_client(&chip->c);
 
 	/* initialization  */
@@ -1430,7 +1519,6 @@
 	
 	i2c_detach_client(&chip->c);
 	kfree(chip);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1444,7 +1532,7 @@
 	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 	struct CHIPDESC  *desc = chiplist + chip->type;
 
-	dprintk("%s: chip_command 0x%x\n",chip->c.dev.name,cmd);
+	dprintk("%s: chip_command 0x%x\n",i2c_clientname(&chip->c),cmd);
 
 	switch (cmd) {
 	case AUDC_SET_INPUT:
@@ -1552,11 +1640,9 @@
 
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
-        .dev	= {
-		.name	= "(unset)",
-	},
+	I2C_DEVNAME("(unset)"),
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &driver,
 };
 
 static int audiochip_init_module(void)
diff -u linux-2.5.69/drivers/media/video/tvaudio.h linux/drivers/media/video/tvaudio.h
--- linux-2.5.69/drivers/media/video/tvaudio.h	2003-05-08 13:29:45.000000000 +0200
+++ linux/drivers/media/video/tvaudio.h	2003-05-08 13:55:11.000000000 +0200
@@ -3,7 +3,7 @@
  */
 
 #define I2C_TDA8425        0x82
-#define I2C_TDA9840        0x84
+#define I2C_TDA9840        0x84 /* also used by TA8874Z */
 #define I2C_TDA985x_L      0xb4 /* also used by 9873 */
 #define I2C_TDA985x_H      0xb6
 #define I2C_TDA9874        0xb0 /* also used by 9875 */
diff -u linux-2.5.69/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.5.69/drivers/media/video/tvmixer.c	2003-05-08 13:31:50.000000000 +0200
+++ linux/drivers/media/video/tvmixer.c	2003-05-08 13:55:11.000000000 +0200
@@ -10,19 +10,16 @@
 #include <linux/videodev.h>
 #include <linux/init.h>
 #include <linux/kdev_t.h>
-#include <asm/semaphore.h>
-
 #include <linux/sound.h>
 #include <linux/soundcard.h>
+
+#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 
 #define DEV_MAX  4
 
-static int debug = 0;
 static int devnr = -1;
-
-MODULE_PARM(debug,"i");
 MODULE_PARM(devnr,"i");
 
 MODULE_AUTHOR("Gerd Knorr");
@@ -87,7 +84,7 @@
         if (cmd == SOUND_MIXER_INFO) {
                 mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->dev.name, sizeof(info.name));
+                strncpy(info.name, i2c_clientname(client), sizeof(info.name));
                 info.modify_counter = 42 /* FIXME */;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -96,7 +93,7 @@
         if (cmd == SOUND_OLD_MIXER_INFO) {
                 _old_mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->dev.name, sizeof(info.name));
+                strncpy(info.name, i2c_clientname(client), sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
                 return 0;
@@ -143,7 +140,7 @@
 	case MIXER_READ(SOUND_MIXER_VOLUME):
 		left  = (min(65536 - va.balance,32768) *
 			 va.volume) / 32768;
-		right = (min(va.balance,32768) *
+		right = (min(va.balance,(u16)32768) *
 			 va.volume) / 32768;
 		ret = v4l_to_mix2(left,right);
 		break;
@@ -218,8 +215,8 @@
 	.name            = "tv card mixer driver",
         .id              = I2C_DRIVERID_TVMIXER,
 	.flags           = I2C_DF_NOTIFY,
-        .attach_adapter  = tvmixer_adapters,
         .detach_adapter  = tvmixer_adapters,
+        .attach_adapter  = tvmixer_adapters,
         .detach_client   = tvmixer_clients,
 };
 
@@ -238,9 +235,6 @@
 	struct list_head  *item;
 	struct i2c_client *client;
 
-	if (debug)
-		printk("tvmixer: adapter %s\n",adap->dev.name);
-
 	list_for_each(item,&adap->clients) {
 		client = list_entry(item, struct i2c_client, list);
 		tvmixer_clients(client);
@@ -253,16 +247,8 @@
 	struct video_audio va;
 	int i,minor;
 
-	/* TV card ??? */
-	if (!(client->adapter->class & I2C_ADAP_CLASS_TV_ANALOG)) {
-		/* ignore that one */
-		if (debug)
-			printk("tvmixer: %s is not a tv card\n",
-			       client->adapter->dev.name);
+	if (!(client->adapter->class & I2C_ADAP_CLASS_TV_ANALOG))
 		return -1;
-	}
-	if (debug)
-		printk("tvmixer: debug: %s\n",client->dev.name);
 
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
@@ -271,7 +257,8 @@
 			unregister_sound_mixer(devices[i].minor);
 			devices[i].dev = NULL;
 			devices[i].minor = -1;
-			printk("tvmixer: %s unregistered (#1)\n",client->dev.name);
+			printk("tvmixer: %s unregistered (#1)\n",
+			       i2c_clientname(client));
 			return 0;
 		}
 	}
@@ -286,25 +273,13 @@
 	}
 
 	/* audio chip with mixer ??? */
-	if (NULL == client->driver->command) {
-		if (debug)
-			printk("tvmixer: %s: driver->command is NULL\n",
-			       client->driver->name);
+	if (NULL == client->driver->command)
 		return -1;
-	}
 	memset(&va,0,sizeof(va));
-	if (0 != client->driver->command(client,VIDIOCGAUDIO,&va)) {
-		if (debug)
-			printk("tvmixer: %s: VIDIOCGAUDIO failed\n",
-			       client->dev.name);
+	if (0 != client->driver->command(client,VIDIOCGAUDIO,&va))
 		return -1;
-	}
-	if (0 == (va.flags & VIDEO_AUDIO_VOLUME)) {
-		if (debug)
-			printk("tvmixer: %s: has no volume control\n",
-			       client->dev.name);
+	if (0 == (va.flags & VIDEO_AUDIO_VOLUME))
 		return -1;
-	}
 
 	/* everything is fine, register */
 	if ((minor = register_sound_mixer(&tvmixer_fops,devnr)) < 0) {
@@ -342,7 +317,7 @@
 		if (devices[i].minor != -1) {
 			unregister_sound_mixer(devices[i].minor);
 			printk("tvmixer: %s unregistered (#2)\n",
-			       devices[i].dev->dev.name);
+			       i2c_clientname(devices[i].dev));
 		}
 	}
 }
diff -u linux-2.5.69/include/media/audiochip.h linux/include/media/audiochip.h
--- linux-2.5.69/include/media/audiochip.h	2003-05-08 13:30:19.000000000 +0200
+++ linux/include/media/audiochip.h	2003-05-08 13:55:11.000000000 +0200
@@ -18,6 +18,15 @@
 #define AUDIO_MUTE         0x80
 #define AUDIO_UNMUTE       0x81
 
+/* all the stuff below is obsolete and just here for reference.  I'll
+ * remove it once the driver is tested and works fine.
+ *
+ * Instead creating alot of tiny API's for all kinds of different
+ * chips, we'll just pass throuth the v4l ioctl structs (v4l2 not
+ * yet...).  It is a bit less flexible, but most/all used i2c chips
+ * make sense in v4l context only.  So I think that's acceptable...
+ */
+
 /* misc stuff to pass around config info to i2c chips */
 #define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
 

-- 
sigfault

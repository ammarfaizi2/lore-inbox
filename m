Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUAOMUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUAOMUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:20:31 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22963 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S264966AbUAOMUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:20:06 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 12:57:22 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-06 misc i2c fixes
Message-ID: <20040115115722.GA16287@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a collection of misc i2c tv helper module fixes.

  Gerd

diff -u linux-2.6.1/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.1/drivers/media/video/msp3400.c	2004-01-14 15:06:06.000000000 +0100
+++ linux/drivers/media/video/msp3400.c	2004-01-14 15:09:35.000000000 +0100
@@ -50,10 +50,6 @@
 #include <asm/semaphore.h>
 #include <asm/pgtable.h>
 
-/* kernel_thread */
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #include <media/audiochip.h>
 #include "msp3400.h"
 
@@ -194,7 +190,7 @@
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (read 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 	if (3 == err) {
@@ -223,7 +219,7 @@
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (write 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 	}
 	if (3 == err) {
@@ -804,7 +800,7 @@
 		}
 
 		/* some time for the tuner to sync */
-		current->state   = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/5);
 		if (signal_pending(current))
 			goto done;
@@ -839,7 +835,7 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
-			current->state   = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/10);
 			if (signal_pending(current))
 				goto done;
@@ -876,7 +872,7 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
-			current->state   = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/10);
 			if (signal_pending(current))
 				goto done;
@@ -1052,7 +1048,7 @@
 		}
 	
 		/* some time for the tuner to sync */
-		current->state   = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/5);
 		if (signal_pending(current))
 			goto done;
@@ -1113,7 +1109,7 @@
 		} else {
 			/* triggered autodetect */
 			for (;;) {
-				current->state   = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(HZ/10);
 				if (signal_pending(current))
 					goto done;
@@ -1204,6 +1200,8 @@
 #endif
 			break;
 		case 0x0003:
+		case 0x0004:
+		case 0x0005:
 			msp->mode   = MSP_MODE_FM_TERRA;
 			msp->stereo = VIDEO_SOUND_MONO;
 			msp->nicam_on = 0;
@@ -1262,7 +1260,7 @@
 	DECLARE_MUTEX_LOCKED(sem);
 	struct msp3400c *msp;
         struct i2c_client *c;
-	int i;
+	int i, rc;
 
         client_template.adapter = adap;
         client_template.addr = addr;
@@ -1316,7 +1314,7 @@
 #endif
 	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
-	snprintf(c->name, I2C_NAME_SIZE, "MSP34%02d%c-%c%d",
+	snprintf(c->name, sizeof(c->name), "MSP34%02d%c-%c%d",
 		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
 		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
@@ -1345,9 +1343,12 @@
 
 	/* startup control thread */
 	msp->notify = &sem;
-	kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
-		      (void *)c, 0);
-	down(&sem);
+	rc = kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
+			   (void *)c, 0);
+	if (rc < 0)
+		printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
+	else
+		down(&sem);
 	msp->notify = NULL;
 	wake_up_interruptible(&msp->wq);
 
@@ -1398,8 +1399,13 @@
 
 static int msp_probe(struct i2c_adapter *adap)
 {
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, msp_attach);
+#else
+	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+		return i2c_probe(adap, &addr_data, msp_attach);
+#endif
 	return 0;
 }
 
diff -u linux-2.6.1/drivers/media/video/tda7432.c linux/drivers/media/video/tda7432.c
--- linux-2.6.1/drivers/media/video/tda7432.c	2004-01-14 15:06:15.000000000 +0100
+++ linux/drivers/media/video/tda7432.c	2004-01-14 15:09:35.000000000 +0100
@@ -338,8 +338,13 @@
 
 static int tda7432_probe(struct i2c_adapter *adap)
 {
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda7432_attach);
+#else
+	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+		return i2c_probe(adap, &addr_data, tda7432_attach);
+#endif
 	return 0;
 }
 
diff -u linux-2.6.1/drivers/media/video/tda9875.c linux/drivers/media/video/tda9875.c
--- linux-2.6.1/drivers/media/video/tda9875.c	2004-01-14 15:05:39.000000000 +0100
+++ linux/drivers/media/video/tda9875.c	2004-01-14 15:09:35.000000000 +0100
@@ -272,8 +272,13 @@
 
 static int tda9875_probe(struct i2c_adapter *adap)
 {
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9875_attach);
+#else
+	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+		return i2c_probe(adap, &addr_data, tda9875_attach);
+#endif
 	return 0;
 }
 
diff -u linux-2.6.1/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.1/drivers/media/video/tda9887.c	2004-01-14 15:04:59.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2004-01-14 15:09:35.000000000 +0100
@@ -169,7 +169,7 @@
 		bDeEmphVal   = cDeemphasis50;
 		bModulation  = cNegativeFmTV;
 		bOutPort1    = cOutputPort1Inactive;
-		if (1 == t->pinnacle_id) {
+		if ((1 == t->pinnacle_id) || (7 == t->pinnacle_id)) {
 			bCarrierMode = cIntercarrier;
 		} else {
 			// stereo boards
@@ -366,8 +366,18 @@
 
 static int tda9887_probe(struct i2c_adapter *adap)
 {
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, tda9887_attach);
+#else
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_ALGO_SAA7134:
+		return i2c_probe(adap, &addr_data, tda9887_attach);
+		break;
+	}
+#endif
 	return 0;
 }
 
@@ -439,9 +449,9 @@
 };
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
-	.name	= "tda9887",
+	I2C_DEVNAME("tda9887"),
+	.flags     = I2C_CLIENT_ALLOW_USE,
+        .driver    = &driver,
 };
 
 static int tda9887_init_module(void)
diff -u linux-2.6.1/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.1/drivers/media/video/tvaudio.c	2004-01-14 15:05:28.000000000 +0100
+++ linux/drivers/media/video/tvaudio.c	2004-01-14 15:09:35.000000000 +0100
@@ -1420,6 +1420,7 @@
 {
 	struct CHIPSTATE *chip;
 	struct CHIPDESC  *desc;
+	int rc;
 
 	chip = kmalloc(sizeof(*chip),GFP_KERNEL);
 	if (!chip)
@@ -1487,8 +1488,12 @@
 		chip->wt.function = chip_thread_wake;
 		chip->wt.data     = (unsigned long)chip;
 		init_waitqueue_head(&chip->wq);
-		kernel_thread(chip_thread,(void *)chip,0);
-		down(&sem);
+		rc = kernel_thread(chip_thread,(void *)chip,0);
+		if (rc < 0)
+			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+			       i2c_clientname(&chip->c));
+		else
+			down(&sem);
 		chip->notify = NULL;
 		wake_up_interruptible(&chip->wq);
 	}
@@ -1497,8 +1502,17 @@
 
 static int chip_probe(struct i2c_adapter *adap)
 {
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, chip_attach);
+#else
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_ALGO_SAA7134:
+		return i2c_probe(adap, &addr_data, chip_attach);
+	}
+#endif
 	return 0;
 }
 
diff -u linux-2.6.1/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.6.1/drivers/media/video/tvmixer.c	2004-01-14 15:06:33.000000000 +0100
+++ linux/drivers/media/video/tvmixer.c	2004-01-14 15:09:35.000000000 +0100
@@ -190,6 +190,10 @@
 
 	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
+#ifndef I2C_PEC
+	if (client->adapter->inc_use)
+		client->adapter->inc_use(client->adapter);
+#endif
 	if (client->adapter->owner)
 		try_module_get(client->adapter->owner);
         return 0;
@@ -205,17 +209,27 @@
 		return -ENODEV;
 	}
 
+#ifndef I2C_PEC
+	if (client->adapter->dec_use)
+		client->adapter->dec_use(client->adapter);
+#endif
 	if (client->adapter->owner)
 		module_put(client->adapter->owner);
 	return 0;
 }
 
 static struct i2c_driver driver = {
+#ifdef I2C_PEC
 	.owner           = THIS_MODULE,
+#endif
 	.name            = "tv card mixer driver",
         .id              = I2C_DRIVERID_TVMIXER,
+#ifdef I2C_DF_DUMMY
+	.flags           = I2C_DF_DUMMY,
+#else
 	.flags           = I2C_DF_NOTIFY,
         .detach_adapter  = tvmixer_adapters,
+#endif
         .attach_adapter  = tvmixer_adapters,
         .detach_client   = tvmixer_clients,
 };
@@ -247,8 +261,21 @@
 	struct video_audio va;
 	int i,minor;
 
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	if (!(client->adapter->class & I2C_ADAP_CLASS_TV_ANALOG))
 		return -1;
+#else
+	/* TV card ??? */
+	switch (client->adapter->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+		/* ok, have a look ... */
+		break;
+	default:
+		/* ignore that one */
+		return -1;
+	}
+#endif
 
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
diff -u linux-2.6.1/include/media/id.h linux/include/media/id.h
--- linux-2.6.1/include/media/id.h	2004-01-14 15:05:44.000000000 +0100
+++ linux/include/media/id.h	2004-01-14 15:09:35.000000000 +0100
@@ -27,6 +27,9 @@
 #ifndef  I2C_DRIVERID_TDA9874
 # define I2C_DRIVERID_TDA9874 I2C_DRIVERID_EXP0+7
 #endif
+#ifndef  I2C_DRIVERID_SAA6752HS
+# define I2C_DRIVERID_SAA6752HS I2C_DRIVERID_EXP0+8
+#endif
 
 /* algorithms */
 #ifndef I2C_ALGO_SAA7134

-- 
You have a new virus in /var/mail/kraxel

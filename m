Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbTDBQuS>; Wed, 2 Apr 2003 11:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbTDBQuR>; Wed, 2 Apr 2003 11:50:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17387 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263059AbTDBQtE>; Wed, 2 Apr 2003 11:49:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 2 Apr 2003 19:10:18 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>
Subject: [patch] tvmixer update
Message-ID: <20030402171018.GA25281@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the tvmixer.  Basically fixes the build failure
due to the recent i2c updates.  It uses the new i2c_clientname()
function introduced by a patch sent earlier today and thus depends on
that patch being applied.

  Gerd

diff -u linux-2.5.66/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.5.66/drivers/media/video/tvmixer.c	2003-04-02 11:43:34.564751856 +0200
+++ linux/drivers/media/video/tvmixer.c	2003-04-02 11:49:36.902464252 +0200
@@ -10,19 +10,15 @@
 #include <linux/videodev.h>
 #include <linux/init.h>
 #include <linux/kdev_t.h>
-#include <asm/semaphore.h>
-
 #include <linux/sound.h>
 #include <linux/soundcard.h>
-#include <asm/uaccess.h>
 
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
 
 #define DEV_MAX  4
 
-static int debug = 0;
 static int devnr = -1;
-
-MODULE_PARM(debug,"i");
 MODULE_PARM(devnr,"i");
 
 MODULE_AUTHOR("Gerd Knorr");
@@ -87,7 +83,7 @@
         if (cmd == SOUND_MIXER_INFO) {
                 mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->name, sizeof(info.name));
+                strncpy(info.name, i2c_clientname(client), sizeof(info.name));
                 info.modify_counter = 42 /* FIXME */;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -96,7 +92,7 @@
         if (cmd == SOUND_OLD_MIXER_INFO) {
                 _old_mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->name, sizeof(info.name));
+                strncpy(info.name, i2c_clientname(client), sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
                 return 0;
@@ -143,7 +139,7 @@
 	case MIXER_READ(SOUND_MIXER_VOLUME):
 		left  = (min(65536 - va.balance,32768) *
 			 va.volume) / 32768;
-		right = (min(va.balance,32768) *
+		right = (min(va.balance,(u16)32768) *
 			 va.volume) / 32768;
 		ret = v4l_to_mix2(left,right);
 		break;
@@ -191,7 +187,6 @@
 	if (NULL == client)
 		return -ENODEV;
 
-	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
 	if (client->adapter->owner)
 		try_module_get(client->adapter->owner);
@@ -236,8 +231,6 @@
 {
 	int i;
 
-	if (debug)
-		printk("tvmixer: adapter %s\n",adap->name);
 	for (i=0; i<I2C_CLIENT_MAX; i++) {
 		if (!adap->clients[i])
 			continue;
@@ -259,12 +252,8 @@
 		break;
 	default:
 		/* ignore that one */
-		if (debug)
-			printk("tvmixer: %s is not a tv card\n",
-			       client->adapter->name);
 		return -1;
 	}
-	printk("tvmixer: debug: %s\n",client->name);
 
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
@@ -273,7 +262,8 @@
 			unregister_sound_mixer(devices[i].minor);
 			devices[i].dev = NULL;
 			devices[i].minor = -1;
-			printk("tvmixer: %s unregistered (#1)\n",client->name);
+			printk("tvmixer: %s unregistered (#1)\n",
+			       i2c_clientname(client));
 			return 0;
 		}
 	}
@@ -288,25 +278,13 @@
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
-			       client->name);
+	if (0 != client->driver->command(client,VIDIOCGAUDIO,&va))
 		return -1;
-	}
-	if (0 == (va.flags & VIDEO_AUDIO_VOLUME)) {
-		if (debug)
-			printk("tvmixer: %s: has no volume control\n",
-			       client->name);
+	if (0 == (va.flags & VIDEO_AUDIO_VOLUME))
 		return -1;
-	}
 
 	/* everything is fine, register */
 	if ((minor = register_sound_mixer(&tvmixer_fops,devnr)) < 0) {
@@ -318,7 +296,7 @@
 	devices[i].count = 0;
 	devices[i].dev   = client;
 	printk("tvmixer: %s (%s) registered with minor %d\n",
-	       client->name,client->adapter->name,minor);
+	       client->dev.name,client->adapter->dev.name,minor);
 	
 	return 0;
 }
@@ -344,7 +322,7 @@
 		if (devices[i].minor != -1) {
 			unregister_sound_mixer(devices[i].minor);
 			printk("tvmixer: %s unregistered (#2)\n",
-			       devices[i].dev->name);
+			       i2c_clientname(devices[i].dev));
 		}
 	}
 }

-- 
Michael Moore for president!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbTCYJGF>; Tue, 25 Mar 2003 04:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCYJGF>; Tue, 25 Mar 2003 04:06:05 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:20864 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261817AbTCYJF5>;
	Tue, 25 Mar 2003 04:05:57 -0500
Message-ID: <3E801EA1.40709@portrix.net>
Date: Tue, 25 Mar 2003 10:17:21 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c driver changes for 2.5.66
References: <10485563141404@kroah.com>
In-Reply-To: <10485563141404@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040101090201060903020401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040101090201060903020401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> ChangeSet 1.889.355.14, 2003/03/22 23:20:40-08:00, greg@kroah.com
> 
> i2c: fix up drivers/media/video/* due to previous i2c changes.
> 

Additionally I need the following patch to tvmixer.c to compile properly 
with CONFIG_SOUND_TVMIXER=m. Just a /client->name/client->dev.name/g.

Thanks,

Jan


--------------040101090201060903020401
Content-Type: text/plain;
 name="tvmixer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tvmixer.diff"

--- clean/drivers/media/video/tvmixer.c	2003-03-21 12:42:04.000000000 +0100
+++ work/drivers/media/video/tvmixer.c	2003-03-25 09:37:07.000000000 +0100
@@ -87,7 +87,7 @@
         if (cmd == SOUND_MIXER_INFO) {
                 mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->name, sizeof(info.name));
+                strncpy(info.name, client->dev.name, sizeof(info.name));
                 info.modify_counter = 42 /* FIXME */;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -96,7 +96,7 @@
         if (cmd == SOUND_OLD_MIXER_INFO) {
                 _old_mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->name, sizeof(info.name));
+                strncpy(info.name, client->dev.name, sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
                 return 0;
@@ -237,7 +237,7 @@
 	int i;
 
 	if (debug)
-		printk("tvmixer: adapter %s\n",adap->name);
+		printk("tvmixer: adapter %s\n",adap->dev.name);
 	for (i=0; i<I2C_CLIENT_MAX; i++) {
 		if (!adap->clients[i])
 			continue;
@@ -261,10 +261,10 @@
 		/* ignore that one */
 		if (debug)
 			printk("tvmixer: %s is not a tv card\n",
-			       client->adapter->name);
+			       client->adapter->dev.name);
 		return -1;
 	}
-	printk("tvmixer: debug: %s\n",client->name);
+	printk("tvmixer: debug: %s\n",client->dev.name);
 
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
@@ -273,7 +273,7 @@
 			unregister_sound_mixer(devices[i].minor);
 			devices[i].dev = NULL;
 			devices[i].minor = -1;
-			printk("tvmixer: %s unregistered (#1)\n",client->name);
+			printk("tvmixer: %s unregistered (#1)\n",client->dev.name);
 			return 0;
 		}
 	}
@@ -298,13 +298,13 @@
 	if (0 != client->driver->command(client,VIDIOCGAUDIO,&va)) {
 		if (debug)
 			printk("tvmixer: %s: VIDIOCGAUDIO failed\n",
-			       client->name);
+			       client->dev.name);
 		return -1;
 	}
 	if (0 == (va.flags & VIDEO_AUDIO_VOLUME)) {
 		if (debug)
 			printk("tvmixer: %s: has no volume control\n",
-			       client->name);
+			       client->dev.name);
 		return -1;
 	}
 
@@ -318,7 +318,7 @@
 	devices[i].count = 0;
 	devices[i].dev   = client;
 	printk("tvmixer: %s (%s) registered with minor %d\n",
-	       client->name,client->adapter->name,minor);
+	       client->dev.name,client->adapter->dev.name,minor);
 	
 	return 0;
 }
@@ -344,7 +344,7 @@
 		if (devices[i].minor != -1) {
 			unregister_sound_mixer(devices[i].minor);
 			printk("tvmixer: %s unregistered (#2)\n",
-			       devices[i].dev->name);
+			       devices[i].dev->dev.name);
 		}
 	}
 }

--------------040101090201060903020401--


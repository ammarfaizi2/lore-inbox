Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUAGXYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAGXYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:24:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:11733 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261775AbUAGXY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:24:26 -0500
Date: Wed, 7 Jan 2004 15:24:25 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] sysfs sound class patch for ALSA drivers - [2/2]
Message-ID: <20040107232425.GE2540@kroah.com>
References: <20040107232137.GC2540@kroah.com> <20040107232335.GD2540@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107232335.GD2540@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sysfs sound class support for all ALSA drivers

Note, this is based on a previous patch from Leann Ogasawara
<ogasawara@osdl.org>, but modified a lot by me.


diff -Nru a/include/sound/core.h b/include/sound/core.h
--- a/include/sound/core.h	Wed Jan  7 15:10:03 2004
+++ b/include/sound/core.h	Wed Jan  7 15:10:03 2004
@@ -160,6 +160,7 @@
 	int shutdown;			/* this card is going down */
 	wait_queue_head_t shutdown_sleep;
 	struct work_struct free_workq;	/* for free in workqueue */
+	struct device *dev;
 
 #ifdef CONFIG_PM
 	int (*set_power_state) (snd_card_t *card, unsigned int state);
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Wed Jan  7 15:10:03 2004
+++ b/sound/core/sound.c	Wed Jan  7 15:10:03 2004
@@ -38,9 +38,7 @@
 static int major = CONFIG_SND_MAJOR;
 int snd_major;
 static int cards_limit = SNDRV_CARDS;
-#ifdef CONFIG_DEVFS_FS
 static int device_mode = S_IFCHR | S_IRUGO | S_IWUGO;
-#endif
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture driver for soundcards.");
@@ -66,6 +64,7 @@
 
 static DECLARE_MUTEX(sound_mutex);
 
+extern struct class sound_class;
 #ifdef CONFIG_KMOD
 
 /**
@@ -203,6 +202,7 @@
 {
 	int minor = snd_kernel_minor(type, card, dev);
 	snd_minor_t *preg;
+	struct device *device = NULL;
 
 	if (minor < 0)
 		return minor;
@@ -221,10 +221,14 @@
 		return -EBUSY;
 	}
 	list_add_tail(&preg->list, &snd_minors_hash[SNDRV_MINOR_CARD(minor)]);
-#ifdef CONFIG_DEVFS_FS
-	if (strncmp(name, "controlC", 8))     /* created in sound.c */
+
+	if (strncmp(name, "controlC", 8)) {	/* created in sound.c */
 		devfs_mk_cdev(MKDEV(major, minor), S_IFCHR | device_mode, "snd/%s", name);
-#endif
+		if (card)
+			device = card->dev;
+		simple_add_class_device(&sound_class, MKDEV(major, minor), device, name);
+	}
+
 	up(&sound_mutex);
 	return 0;
 }
@@ -252,10 +256,12 @@
 		up(&sound_mutex);
 		return -EINVAL;
 	}
-#ifdef CONFIG_DEVFS_FS
-	if (strncmp(mptr->name, "controlC", 8))	/* created in sound.c */
+
+	if (strncmp(mptr->name, "controlC", 8)) {	/* created in sound.c */
 		devfs_remove("snd/%s", mptr->name);
-#endif
+		simple_remove_class_device(MKDEV(major, minor));
+	}
+
 	list_del(&mptr->list);
 	up(&sound_mutex);
 	kfree(mptr);
@@ -322,9 +328,7 @@
 
 static int __init alsa_sound_init(void)
 {
-#ifdef CONFIG_DEVFS_FS
 	short controlnum;
-#endif
 #ifdef CONFIG_SND_OSSEMUL
 	int err;
 #endif
@@ -358,10 +362,10 @@
 #ifdef CONFIG_SND_OSSEMUL
 	snd_info_minor_register();
 #endif
-#ifdef CONFIG_DEVFS_FS
-	for (controlnum = 0; controlnum < cards_limit; controlnum++) 
+	for (controlnum = 0; controlnum < cards_limit; controlnum++) {
 		devfs_mk_cdev(MKDEV(major, controlnum<<5), S_IFCHR | device_mode, "snd/controlC%d", controlnum);
-#endif
+		simple_add_class_device(&sound_class, MKDEV(major, controlnum<<5), NULL, "controlC%d", controlnum);
+	}
 #ifndef MODULE
 	printk(KERN_INFO "Advanced Linux Sound Architecture Driver Version " CONFIG_SND_VERSION CONFIG_SND_DATE ".\n");
 #endif
@@ -372,8 +376,10 @@
 {
 	short controlnum;
 
-	for (controlnum = 0; controlnum < cards_limit; controlnum++)
+	for (controlnum = 0; controlnum < cards_limit; controlnum++) {
 		devfs_remove("snd/controlC%d", controlnum);
+		simple_remove_class_device(MKDEV(major, controlnum<<5));
+	}
 
 #ifdef CONFIG_SND_OSSEMUL
 	snd_info_minor_unregister();
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Wed Jan  7 15:10:03 2004
+++ b/sound/pci/intel8x0.c	Wed Jan  7 15:10:03 2004
@@ -2591,6 +2591,7 @@
 			break;
 		}
 	}
+	card->dev = &pci->dev;
 
 	if ((err = snd_intel8x0_create(card, pci, pci_id->driver_data, &chip)) < 0) {
 		snd_card_free(card);

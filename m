Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbUATBQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUATBPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:15:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:21449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264415AbUATBMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:33 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <10745611603429@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:41 -0800
Message-Id: <1074561161776@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1504, 2004/01/19 16:45:49-08:00, greg@kroah.com

[PATCH] ALSA: add sysfs class support for ALSA sound devices

This patch adds support for all ALSA sound devices.  The previous OSS
sound patch is required for this one to work properly.

This patch is based on a work originally written by
Leann Ogasawara <ogasawara@osdl.org>


 include/sound/core.h |    1 +
 sound/core/sound.c   |   34 ++++++++++++++++++++--------------
 sound/pci/intel8x0.c |    1 +
 3 files changed, 22 insertions(+), 14 deletions(-)


diff -Nru a/include/sound/core.h b/include/sound/core.h
--- a/include/sound/core.h	Mon Jan 19 17:04:44 2004
+++ b/include/sound/core.h	Mon Jan 19 17:04:44 2004
@@ -160,6 +160,7 @@
 	int shutdown;			/* this card is going down */
 	wait_queue_head_t shutdown_sleep;
 	struct work_struct free_workq;	/* for free in workqueue */
+	struct device *dev;
 
 #ifdef CONFIG_PM
 	int (*set_power_state) (snd_card_t *card, unsigned int state);
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Mon Jan 19 17:04:44 2004
+++ b/sound/core/sound.c	Mon Jan 19 17:04:44 2004
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
 
+extern struct class_simple *sound_class;
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
+		class_simple_device_add(sound_class, MKDEV(major, minor), device, name);
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
+		class_simple_device_remove(MKDEV(major, minor));
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
+		class_simple_device_add(sound_class, MKDEV(major, controlnum<<5), NULL, "controlC%d", controlnum);
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
+		class_simple_device_remove(MKDEV(major, controlnum<<5));
+	}
 
 #ifdef CONFIG_SND_OSSEMUL
 	snd_info_minor_unregister();
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Mon Jan 19 17:04:44 2004
+++ b/sound/pci/intel8x0.c	Mon Jan 19 17:04:44 2004
@@ -2591,6 +2591,7 @@
 			break;
 		}
 	}
+	card->dev = &pci->dev;
 
 	if ((err = snd_intel8x0_create(card, pci, pci_id->driver_data, &chip)) < 0) {
 		snd_card_free(card);


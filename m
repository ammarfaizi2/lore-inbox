Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVFUA3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVFUA3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVFUA1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:27:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:49636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261778AbVFTW76 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:58 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert sound/* to use the new class api instead of class_simple
In-Reply-To: <1119308362354@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:22 -0700
Message-Id: <11193083622806@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert sound/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 619e666b7e9d2b0545ab60a9c824ae5f77c20c3b
tree a2c6d9bb6b8f66fdda8cc6cd8422f062e557922d
parent 8561b10f6e7ef0a085709ffc844f74130a067abe
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 09:51:41 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:07 -0700

 sound/core/sound.c    |    6 +++---
 sound/oss/soundcard.c |   19 +++++++++----------
 sound/sound_core.c    |   10 +++++-----
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -64,7 +64,7 @@ static struct list_head snd_minors_hash[
 
 static DECLARE_MUTEX(sound_mutex);
 
-extern struct class_simple *sound_class;
+extern struct class *sound_class;
 
 
 #ifdef CONFIG_KMOD
@@ -231,7 +231,7 @@ int snd_register_device(int type, snd_ca
 		devfs_mk_cdev(MKDEV(major, minor), S_IFCHR | device_mode, "snd/%s", name);
 	if (card)
 		device = card->dev;
-	class_simple_device_add(sound_class, MKDEV(major, minor), device, name);
+	class_device_create(sound_class, MKDEV(major, minor), device, "%s", name);
 
 	up(&sound_mutex);
 	return 0;
@@ -263,7 +263,7 @@ int snd_unregister_device(int type, snd_
 
 	if (strncmp(mptr->name, "controlC", 8) || card->number >= cards_limit) /* created in sound.c */
 		devfs_remove("snd/%s", mptr->name);
-	class_simple_device_remove(MKDEV(major, minor));
+	class_device_destroy(sound_class, MKDEV(major, minor));
 
 	list_del(&mptr->list);
 	up(&sound_mutex);
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -73,7 +73,7 @@ static char     dma_alloc_map[MAX_DMA_CH
 
 
 unsigned long seq_time = 0;	/* Time for /dev/sequencer */
-extern struct class_simple *sound_class;
+extern struct class *sound_class;
 
 /*
  * Table for configurable mixer volume handling
@@ -567,9 +567,9 @@ static int __init oss_init(void)
 		devfs_mk_cdev(MKDEV(SOUND_MAJOR, dev_list[i].minor),
 				S_IFCHR | dev_list[i].mode,
 				"sound/%s", dev_list[i].name);
-		class_simple_device_add(sound_class, 
-					MKDEV(SOUND_MAJOR, dev_list[i].minor),
-					NULL, "%s", dev_list[i].name);
+		class_device_create(sound_class,
+				    MKDEV(SOUND_MAJOR, dev_list[i].minor),
+				    NULL, "%s", dev_list[i].name);
 
 		if (!dev_list[i].num)
 			continue;
@@ -579,10 +579,9 @@ static int __init oss_init(void)
 						dev_list[i].minor + (j*0x10)),
 					S_IFCHR | dev_list[i].mode,
 					"sound/%s%d", dev_list[i].name, j);
-			class_simple_device_add(sound_class,
-					MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
-					NULL,
-					"%s%d", dev_list[i].name, j);
+			class_device_create(sound_class,
+					    MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
+					    NULL, "%s%d", dev_list[i].name, j);
 		}
 	}
 
@@ -598,12 +597,12 @@ static void __exit oss_cleanup(void)
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
 		devfs_remove("sound/%s", dev_list[i].name);
-		class_simple_device_remove(MKDEV(SOUND_MAJOR, dev_list[i].minor));
+		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor));
 		if (!dev_list[i].num)
 			continue;
 		for (j = 1; j < *dev_list[i].num; j++) {
 			devfs_remove("sound/%s%d", dev_list[i].name, j);
-			class_simple_device_remove(MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
+			class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
 		}
 	}
 	
diff --git a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -65,7 +65,7 @@ extern int msnd_classic_init(void);
 extern int msnd_pinnacle_init(void);
 #endif
 
-struct class_simple *sound_class;
+struct class *sound_class;
 EXPORT_SYMBOL(sound_class);
 
 /*
@@ -174,7 +174,7 @@ static int sound_insert_unit(struct soun
 
 	devfs_mk_cdev(MKDEV(SOUND_MAJOR, s->unit_minor),
 			S_IFCHR | mode, s->name);
-	class_simple_device_add(sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
+	class_device_create(sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
 				NULL, s->name+6);
 	return r;
 
@@ -198,7 +198,7 @@ static void sound_remove_unit(struct sou
 	spin_unlock(&sound_loader_lock);
 	if (p) {
 		devfs_remove(p->name);
-		class_simple_device_remove(MKDEV(SOUND_MAJOR, p->unit_minor));
+		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
 }
@@ -562,7 +562,7 @@ static void __exit cleanup_soundcore(voi
 	   empty */
 	unregister_chrdev(SOUND_MAJOR, "sound");
 	devfs_remove("sound");
-	class_simple_destroy(sound_class);
+	class_destroy(sound_class);
 }
 
 static int __init init_soundcore(void)
@@ -572,7 +572,7 @@ static int __init init_soundcore(void)
 		return -EBUSY;
 	}
 	devfs_mk_dir ("sound");
-	sound_class = class_simple_create(THIS_MODULE, "sound");
+	sound_class = class_create(THIS_MODULE, "sound");
 	if (IS_ERR(sound_class))
 		return PTR_ERR(sound_class);
 


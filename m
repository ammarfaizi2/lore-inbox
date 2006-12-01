Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162246AbWLAXc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162246AbWLAXc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162238AbWLAXcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:32:17 -0500
Received: from mail.suse.de ([195.135.220.2]:37005 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162246AbWLAXXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:35 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@novell.com>
Subject: [PATCH 24/36] Driver core: convert sound core to use struct device
Date: Fri,  1 Dec 2006 15:21:54 -0800
Message-Id: <11650154032080-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154001320-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

It also makes the struct sound_card to show up as a "real" device
where all the different sound class devices are placed as childs
and different card attribute files can hang off of. /sys/class/sound is
still a flat directory, but the symlink targets of all devices belonging
to the same card, point the the /sys/devices tree below the new card
device object.

Thanks to Kay for the updates to this patch.

Signed-off-by: Kay Sievers <kay.sievers@novell.com>
Acked-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/sound/core.h  |    8 +++++---
 sound/core/init.c     |    8 ++++++++
 sound/core/pcm.c      |    7 ++++---
 sound/core/sound.c    |   22 +++++++++-------------
 sound/oss/soundcard.c |   16 ++++++++--------
 sound/sound_core.c    |    6 +++---
 6 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index fa1ca01..a994bea 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -132,6 +132,7 @@ struct snd_card {
 	int shutdown;			/* this card is going down */
 	int free_on_last_close;		/* free in context of file_release */
 	wait_queue_head_t shutdown_sleep;
+	struct device *parent;
 	struct device *dev;
 
 #ifdef CONFIG_PM
@@ -187,13 +188,14 @@ struct snd_minor {
 	int device;			/* device number */
 	const struct file_operations *f_ops;	/* file operations */
 	void *private_data;		/* private data for f_ops->open */
-	struct class_device *class_dev;	/* class device for sysfs */
+	struct device *dev;		/* device for sysfs */
 };
 
 /* sound.c */
 
 extern int snd_major;
 extern int snd_ecards_limit;
+extern struct class *sound_class;
 
 void snd_request_card(int card);
 
@@ -203,7 +205,7 @@ int snd_register_device(int type, struct
 int snd_unregister_device(int type, struct snd_card *card, int dev);
 void *snd_lookup_minor_data(unsigned int minor, int type);
 int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      const struct class_device_attribute *attr);
+			      struct device_attribute *attr);
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
@@ -255,7 +257,7 @@ int snd_card_file_add(struct snd_card *c
 int snd_card_file_remove(struct snd_card *card, struct file *file);
 
 #ifndef snd_card_set_dev
-#define snd_card_set_dev(card,devptr) ((card)->dev = (devptr))
+#define snd_card_set_dev(card,devptr) ((card)->parent = (devptr))
 #endif
 
 /* device.c */
diff --git a/sound/core/init.c b/sound/core/init.c
index 3058d62..6152a75 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -361,6 +361,8 @@ static int snd_card_do_free(struct snd_c
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */
 	}
+	if (card->dev)
+		device_unregister(card->dev);
 	kfree(card);
 	return 0;
 }
@@ -495,6 +497,12 @@ int snd_card_register(struct snd_card *c
 	int err;
 
 	snd_assert(card != NULL, return -EINVAL);
+	if (!card->dev) {
+		card->dev = device_create(sound_class, card->parent, 0,
+					  "card%i", card->number);
+		if (IS_ERR(card->dev))
+			card->dev = NULL;
+	}
 	if ((err = snd_device_register_all(card)) < 0)
 		return err;
 	mutex_lock(&snd_card_mutex);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index fbbbcd2..5ac6e19 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -910,7 +910,8 @@ void snd_pcm_detach_substream(struct snd
 	substream->pstr->substream_opened--;
 }
 
-static ssize_t show_pcm_class(struct class_device *class_device, char *buf)
+static ssize_t show_pcm_class(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct snd_pcm *pcm;
 	const char *str;
@@ -921,7 +922,7 @@ static ssize_t show_pcm_class(struct cla
 		[SNDRV_PCM_CLASS_DIGITIZER] = "digitizer",
 	};
 
-	if (! (pcm = class_get_devdata(class_device)) ||
+	if (! (pcm = dev_get_drvdata(dev)) ||
 	    pcm->dev_class > SNDRV_PCM_CLASS_LAST)
 		str = "none";
 	else
@@ -929,7 +930,7 @@ static ssize_t show_pcm_class(struct cla
         return snprintf(buf, PAGE_SIZE, "%s\n", str);
 }
 
-static struct class_device_attribute pcm_attrs =
+static struct device_attribute pcm_attrs =
 	__ATTR(pcm_class, S_IRUGO, show_pcm_class, NULL);
 
 static int snd_pcm_dev_register(struct snd_device *device)
diff --git a/sound/core/sound.c b/sound/core/sound.c
index efa476c..2827420 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -61,9 +61,6 @@ EXPORT_SYMBOL(snd_ecards_limit);
 static struct snd_minor *snd_minors[SNDRV_OS_MINORS];
 static DEFINE_MUTEX(sound_mutex);
 
-extern struct class *sound_class;
-
-
 #ifdef CONFIG_KMOD
 
 /**
@@ -268,11 +265,10 @@ int snd_register_device(int type, struct
 	snd_minors[minor] = preg;
 	if (card)
 		device = card->dev;
-	preg->class_dev = class_device_create(sound_class, NULL,
-					      MKDEV(major, minor),
-					      device, "%s", name);
-	if (preg->class_dev)
-		class_set_devdata(preg->class_dev, private_data);
+	preg->dev = device_create(sound_class, device, MKDEV(major, minor),
+				  "%s", name);
+	if (preg->dev)
+		dev_set_drvdata(preg->dev, private_data);
 
 	mutex_unlock(&sound_mutex);
 	return 0;
@@ -320,7 +316,7 @@ int snd_unregister_device(int type, stru
 		return -EINVAL;
 	}
 
-	class_device_destroy(sound_class, MKDEV(major, minor));
+	device_destroy(sound_class, MKDEV(major, minor));
 
 	kfree(snd_minors[minor]);
 	snd_minors[minor] = NULL;
@@ -331,15 +327,15 @@ int snd_unregister_device(int type, stru
 EXPORT_SYMBOL(snd_unregister_device);
 
 int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      const struct class_device_attribute *attr)
+			      struct device_attribute *attr)
 {
 	int minor, ret = -EINVAL;
-	struct class_device *cdev;
+	struct device *d;
 
 	mutex_lock(&sound_mutex);
 	minor = find_snd_minor(type, card, dev);
-	if (minor >= 0 && (cdev = snd_minors[minor]->class_dev) != NULL)
-		ret = class_device_create_file(cdev, attr);
+	if (minor >= 0 && (d = snd_minors[minor]->dev) != NULL)
+		ret = device_create_file(d, attr);
 	mutex_unlock(&sound_mutex);
 	return ret;
 
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
index 2344d09..75c5e74 100644
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -557,17 +557,17 @@ static int __init oss_init(void)
 	sound_dmap_flag = (dmabuf > 0 ? 1 : 0);
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		class_device_create(sound_class, NULL,
-				    MKDEV(SOUND_MAJOR, dev_list[i].minor),
-				    NULL, "%s", dev_list[i].name);
+		device_create(sound_class, NULL,
+			      MKDEV(SOUND_MAJOR, dev_list[i].minor),
+			      "%s", dev_list[i].name);
 
 		if (!dev_list[i].num)
 			continue;
 
 		for (j = 1; j < *dev_list[i].num; j++)
-			class_device_create(sound_class, NULL,
-					    MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
-					    NULL, "%s%d", dev_list[i].name, j);
+			device_create(sound_class, NULL,
+				      MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
+				      "%s%d", dev_list[i].name, j);
 	}
 
 	if (sound_nblocks >= 1024)
@@ -581,11 +581,11 @@ static void __exit oss_cleanup(void)
 	int i, j;
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor));
+		device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor));
 		if (!dev_list[i].num)
 			continue;
 		for (j = 1; j < *dev_list[i].num; j++)
-			class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
+			device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
 	}
 	
 	unregister_sound_special(1);
diff --git a/sound/sound_core.c b/sound/sound_core.c
index 5322c50..8f1ced4 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -170,8 +170,8 @@ static int sound_insert_unit(struct soun
 	else
 		sprintf(s->name, "sound/%s%d", name, r / SOUND_STEP);
 
-	class_device_create(sound_class, NULL, MKDEV(SOUND_MAJOR, s->unit_minor),
-			    dev, s->name+6);
+	device_create(sound_class, dev, MKDEV(SOUND_MAJOR, s->unit_minor),
+		      s->name+6);
 	return r;
 
  fail:
@@ -193,7 +193,7 @@ static void sound_remove_unit(struct sou
 	p = __sound_remove_unit(list, unit);
 	spin_unlock(&sound_loader_lock);
 	if (p) {
-		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
+		device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
 }
-- 
1.4.4.1


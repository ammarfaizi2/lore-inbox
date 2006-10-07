Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWJGHov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWJGHov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 03:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWJGHov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 03:44:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:17607 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932766AbWJGHou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 03:44:50 -0400
Date: Sat, 7 Oct 2006 00:44:40 -0700
From: Greg KH <greg@kroah.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: sysfs & ALSA card
Message-ID: <20061007074440.GA9304@kroah.com>
References: <Pine.LNX.4.61.0610061548340.8573@tm8103.perex-int.cz> <20061007062458.GF23366@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007062458.GF23366@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 11:24:58PM -0700, Greg KH wrote:
> On Fri, Oct 06, 2006 at 04:00:27PM +0200, Jaroslav Kysela wrote:
> > Hi,
> > 
> > 	I would like to discuss where is the right root for soundcards in 
> > the sysfs tree. I would like to put card specific variables like id there 
> > (see /proc/asound/card0/id).
> 
> That would be nice to have in sysfs, I agree.
> 
> > Also, I plan to create link from 
> > /sys/class/sound tree to the appropriate card to show relationship. 
> > Something like:
> > 
> > /sys/<somewhere>/soundcard/0
> > 
> > /sys/class/sound/controlC0/soundcard -> ../../../<somewhere>/soundcard/0
> > 
> > 	Any comments and suggestions?
> 
> Yeah, this isn't that hard right now.  Just create a new struct device
> for every card, point the parent of this new device to the device that
> represents the card, and then point the other different sound specific
> devices to the new card.
> 
> Hm, let me go hack at it and see what I come up with, code is so much
> better for an example...

Ok, here's a rough cut.  It's still oopsing for my second sound card
right now, but it's late and I'm probably doing something stupid...  I
might not be putting the call in snd_card_register() in the right place,
you should know better than I about this.

Here's what /sys/class/sound now looks like for me:
 $ tree /sys/class/sound/
 /sys/class/sound/
 |-- Audigy2 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2
 |-- admmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/admmidi1
 |-- amidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/amidi1
 |-- controlC1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/controlC1
 |-- dmmidi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/dmmidi1
 |-- hwC1D0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/hwC1D0
 |-- midi1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/midi1
 |-- midiC1D0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/midiC1D0
 |-- midiC1D1 -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/midiC1D1
 |-- pcmC1D0c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D0c
 |-- pcmC1D0p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D0p
 |-- pcmC1D1c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D1c
 |-- pcmC1D2c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D2c
 |-- pcmC1D2p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D2p
 |-- pcmC1D3p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D3p
 |-- pcmC1D4c -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D4c
 |-- pcmC1D4p -> ../../devices/pci0000:00/0000:00:1e.0/0000:06:0d.0/Audigy2/pcmC1D4p
 `-- timer -> ../../devices/virtual/sound/timer


Yeah, I picked the wrong name for the card, it should be "card1" instead
of "Audigy2" here, but you get the idea.

With this change, you now can put whatever other sysfs files in the card
device directory, if you have card specific attributes that you want to
use.

Let me know what you think.

Please also note that you will need the latest versions of udev to get
this to work properly for your sysfs nodes.  If you're using the 10.2
alphas you will be fine, and I think the 10.1 version is also ok here,
Kay would know best.  So this change isn't ready for mainline until I
get off my ass and fix all the old versions of udev, which I still need
to do when my workload calms down a bit...

thanks,

greg k-h

---------------
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver core: convert sound core to use struct device

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Also makes the struct sound_card have a "real" device that all the
different card attributes hang off of.

Thanks to Kay for the updates to this patch.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/sound/core.h  |    7 ++++---
 sound/core/init.c     |    4 ++++
 sound/core/pcm.c      |    7 ++++---
 sound/core/sound.c    |   19 +++++++++----------
 sound/oss/soundcard.c |   16 ++++++++--------
 sound/sound_core.c    |    6 +++---
 6 files changed, 32 insertions(+), 27 deletions(-)

--- gregkh-2.6.orig/include/sound/core.h
+++ gregkh-2.6/include/sound/core.h
@@ -132,6 +132,7 @@ struct snd_card {
 	int shutdown;			/* this card is going down */
 	int free_on_last_close;		/* free in context of file_release */
 	wait_queue_head_t shutdown_sleep;
+	struct device *parent;
 	struct device *dev;
 
 #ifdef CONFIG_PM
@@ -187,7 +188,7 @@ struct snd_minor {
 	int device;			/* device number */
 	const struct file_operations *f_ops;	/* file operations */
 	void *private_data;		/* private data for f_ops->open */
-	struct class_device *class_dev;	/* class device for sysfs */
+	struct device *dev;		/* device for sysfs */
 };
 
 /* sound.c */
@@ -203,7 +204,7 @@ int snd_register_device(int type, struct
 int snd_unregister_device(int type, struct snd_card *card, int dev);
 void *snd_lookup_minor_data(unsigned int minor, int type);
 int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      const struct class_device_attribute *attr);
+			      struct device_attribute *attr);
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
@@ -255,7 +256,7 @@ int snd_card_file_add(struct snd_card *c
 int snd_card_file_remove(struct snd_card *card, struct file *file);
 
 #ifndef snd_card_set_dev
-#define snd_card_set_dev(card,devptr) ((card)->dev = (devptr))
+#define snd_card_set_dev(card,devptr) ((card)->parent = (devptr))
 #endif
 
 /* device.c */
--- gregkh-2.6.orig/sound/core/init.c
+++ gregkh-2.6/sound/core/init.c
@@ -49,6 +49,8 @@ int (*snd_mixer_oss_notify_callback)(str
 EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
 #endif
 
+extern struct class *sound_class;
+
 #ifdef CONFIG_PROC_FS
 static void snd_card_id_read(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
@@ -361,6 +363,7 @@ static int snd_card_do_free(struct snd_c
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */
 	}
+	device_unregister(card->dev);
 	kfree(card);
 	return 0;
 }
@@ -495,6 +498,7 @@ int snd_card_register(struct snd_card *c
 	int err;
 
 	snd_assert(card != NULL, return -EINVAL);
+	card->dev = device_create(sound_class, card->parent, 0, card->id);
 	if ((err = snd_device_register_all(card)) < 0)
 		return err;
 	mutex_lock(&snd_card_mutex);
--- gregkh-2.6.orig/sound/core/pcm.c
+++ gregkh-2.6/sound/core/pcm.c
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
--- gregkh-2.6.orig/sound/core/sound.c
+++ gregkh-2.6/sound/core/sound.c
@@ -268,11 +268,10 @@ int snd_register_device(int type, struct
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
+		dev_get_drvdata(preg->dev);
 
 	mutex_unlock(&sound_mutex);
 	return 0;
@@ -320,7 +319,7 @@ int snd_unregister_device(int type, stru
 		return -EINVAL;
 	}
 
-	class_device_destroy(sound_class, MKDEV(major, minor));
+	device_destroy(sound_class, MKDEV(major, minor));
 
 	kfree(snd_minors[minor]);
 	snd_minors[minor] = NULL;
@@ -331,15 +330,15 @@ int snd_unregister_device(int type, stru
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
 
--- gregkh-2.6.orig/sound/oss/soundcard.c
+++ gregkh-2.6/sound/oss/soundcard.c
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
--- gregkh-2.6.orig/sound/sound_core.c
+++ gregkh-2.6/sound/sound_core.c
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


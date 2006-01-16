Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWAPJWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWAPJWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWAPJWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26603 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932269AbWAPJWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:25 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Ingo Molnar <mingo@elte.hu>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 16/25] Semaphore to mutex conversion on drivers/media
Date: Mon, 16 Jan 2006 07:11:23 -0200
Message-id: <20060116091123.PS30367800016@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

- Semaphore to mutex conversion.
The conversion was generated via scripts, and the result was validated
automatically via a script as well.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/dvbdev.c        |   22 +++++++++++-----------
 drivers/media/video/cx88/cx88-core.c       |   15 ++++++++-------
 drivers/media/video/em28xx/em28xx-video.c  |    7 ++++---
 drivers/media/video/saa7134/saa7134-core.c |   19 ++++++++++---------
 drivers/media/video/videodev.c             |   25 ++++++++++++-------------
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
index 06b696e..54f8b95 100644
--- a/drivers/media/dvb/dvb-core/dvbdev.c
+++ b/drivers/media/dvb/dvb-core/dvbdev.c
@@ -33,7 +33,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
-
+#include <linux/mutex.h>
 #include "dvbdev.h"
 
 static int dvbdev_debug;
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(dvbdev_debug, "Turn on/
 #define dprintk if (dvbdev_debug) printk
 
 static LIST_HEAD(dvb_adapter_list);
-static DECLARE_MUTEX(dvbdev_register_lock);
+static DEFINE_MUTEX(dvbdev_register_lock);
 
 static const char * const dnames[] = {
 	"video", "audio", "sec", "frontend", "demux", "dvr", "ca",
@@ -202,11 +202,11 @@ int dvb_register_device(struct dvb_adapt
 	struct dvb_device *dvbdev;
 	int id;
 
-	if (down_interruptible (&dvbdev_register_lock))
+	if (mutex_lock_interruptible(&dvbdev_register_lock))
 		return -ERESTARTSYS;
 
 	if ((id = dvbdev_get_free_id (adap, type)) < 0) {
-		up (&dvbdev_register_lock);
+		mutex_unlock(&dvbdev_register_lock);
 		*pdvbdev = NULL;
 		printk ("%s: could get find free device id...\n", __FUNCTION__);
 		return -ENFILE;
@@ -215,11 +215,11 @@ int dvb_register_device(struct dvb_adapt
 	*pdvbdev = dvbdev = kmalloc(sizeof(struct dvb_device), GFP_KERNEL);
 
 	if (!dvbdev) {
-		up(&dvbdev_register_lock);
+		mutex_unlock(&dvbdev_register_lock);
 		return -ENOMEM;
 	}
 
-	up (&dvbdev_register_lock);
+	mutex_unlock(&dvbdev_register_lock);
 
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
 	dvbdev->type = type;
@@ -289,11 +289,11 @@ int dvb_register_adapter(struct dvb_adap
 {
 	int num;
 
-	if (down_interruptible (&dvbdev_register_lock))
+	if (mutex_lock_interruptible(&dvbdev_register_lock))
 		return -ERESTARTSYS;
 
 	if ((num = dvbdev_get_free_adapter_num ()) < 0) {
-		up (&dvbdev_register_lock);
+		mutex_unlock(&dvbdev_register_lock);
 		return -ENFILE;
 	}
 
@@ -309,7 +309,7 @@ int dvb_register_adapter(struct dvb_adap
 
 	list_add_tail (&adap->list_head, &dvb_adapter_list);
 
-	up (&dvbdev_register_lock);
+	mutex_unlock(&dvbdev_register_lock);
 
 	return num;
 }
@@ -320,10 +320,10 @@ int dvb_unregister_adapter(struct dvb_ad
 {
 	devfs_remove("dvb/adapter%d", adap->num);
 
-	if (down_interruptible (&dvbdev_register_lock))
+	if (mutex_lock_interruptible(&dvbdev_register_lock))
 		return -ERESTARTSYS;
 	list_del (&adap->list_head);
-	up (&dvbdev_register_lock);
+	mutex_unlock(&dvbdev_register_lock);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_unregister_adapter);
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index 194446f..8d6d6a6 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/videodev2.h>
+#include <linux/mutex.h>
 
 #include "cx88.h"
 #include <media/v4l2-common.h>
@@ -75,7 +76,7 @@ MODULE_PARM_DESC(nocomb,"disable comb fi
 
 static unsigned int cx88_devcount;
 static LIST_HEAD(cx88_devlist);
-static DECLARE_MUTEX(devlist);
+static DEFINE_MUTEX(devlist);
 
 #define NO_SYNC_LINE (-1U)
 
@@ -1036,7 +1037,7 @@ struct cx88_core* cx88_core_get(struct p
 	struct list_head *item;
 	int i;
 
-	down(&devlist);
+	mutex_lock(&devlist);
 	list_for_each(item,&cx88_devlist) {
 		core = list_entry(item, struct cx88_core, devlist);
 		if (pci->bus->number != core->pci_bus)
@@ -1047,7 +1048,7 @@ struct cx88_core* cx88_core_get(struct p
 		if (0 != get_ressources(core,pci))
 			goto fail_unlock;
 		atomic_inc(&core->refcount);
-		up(&devlist);
+		mutex_unlock(&devlist);
 		return core;
 	}
 	core = kzalloc(sizeof(*core),GFP_KERNEL);
@@ -1122,13 +1123,13 @@ struct cx88_core* cx88_core_get(struct p
 	cx88_card_setup(core);
 	cx88_ir_init(core,pci);
 
-	up(&devlist);
+	mutex_unlock(&devlist);
 	return core;
 
 fail_free:
 	kfree(core);
 fail_unlock:
-	up(&devlist);
+	mutex_unlock(&devlist);
 	return NULL;
 }
 
@@ -1140,14 +1141,14 @@ void cx88_core_put(struct cx88_core *cor
 	if (!atomic_dec_and_test(&core->refcount))
 		return;
 
-	down(&devlist);
+	mutex_lock(&devlist);
 	cx88_ir_fini(core);
 	if (0 == core->i2c_rc)
 		i2c_bit_del_bus(&core->i2c_adap);
 	list_del(&core->devlist);
 	iounmap(core->lmmio);
 	cx88_devcount--;
-	up(&devlist);
+	mutex_unlock(&devlist);
 	kfree(core);
 }
 
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 3323dff..eea304f 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -29,6 +29,7 @@
 #include <linux/i2c.h>
 #include <linux/version.h>
 #include <linux/video_decoder.h>
+#include <linux/mutex.h>
 
 #include "em28xx.h"
 #include <media/tuner.h>
@@ -191,7 +192,7 @@ static struct v4l2_queryctrl saa711x_qct
 
 static struct usb_driver em28xx_usb_driver;
 
-static DECLARE_MUTEX(em28xx_sysfs_lock);
+static DEFINE_MUTEX(em28xx_sysfs_lock);
 static DECLARE_RWSEM(em28xx_disconnect);
 
 /*********************  v4l2 interface  ******************************************/
@@ -394,7 +395,7 @@ static int em28xx_v4l2_open(struct inode
 */
 static void em28xx_release_resources(struct em28xx *dev)
 {
-	down(&em28xx_sysfs_lock);
+	mutex_lock(&em28xx_sysfs_lock);
 
 	em28xx_info("V4L2 device /dev/video%d deregistered\n",
 		    dev->vdev->minor);
@@ -403,7 +404,7 @@ static void em28xx_release_resources(str
 /*	video_unregister_device(dev->vbi_dev); */
 	em28xx_i2c_unregister(dev);
 	usb_put_dev(dev->udev);
-	up(&em28xx_sysfs_lock);
+	mutex_unlock(&em28xx_sysfs_lock);
 }
 
 /*
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 3dd42ef..028904b 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -31,6 +31,7 @@
 #include <linux/sound.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
@@ -84,7 +85,7 @@ MODULE_PARM_DESC(radio_nr, "radio device
 MODULE_PARM_DESC(tuner,    "tuner type");
 MODULE_PARM_DESC(card,     "card type");
 
-static DECLARE_MUTEX(devlist_lock);
+static DEFINE_MUTEX(devlist_lock);
 LIST_HEAD(saa7134_devlist);
 static LIST_HEAD(mops_list);
 static unsigned int saa7134_devcount;
@@ -969,13 +970,13 @@ static int __devinit saa7134_initdev(str
 	pci_set_drvdata(pci_dev,dev);
 	saa7134_devcount++;
 
-	down(&devlist_lock);
+	mutex_lock(&devlist_lock);
 	list_for_each(item,&mops_list) {
 		mops = list_entry(item, struct saa7134_mpeg_ops, next);
 		mpeg_ops_attach(mops, dev);
 	}
 	list_add_tail(&dev->devlist,&saa7134_devlist);
-	up(&devlist_lock);
+	mutex_unlock(&devlist_lock);
 
 	/* check for signal */
 	saa7134_irq_video_intl(dev);
@@ -1031,13 +1032,13 @@ static void __devexit saa7134_finidev(st
 	saa7134_hwfini(dev);
 
 	/* unregister */
-	down(&devlist_lock);
+	mutex_lock(&devlist_lock);
 	list_del(&dev->devlist);
 	list_for_each(item,&mops_list) {
 		mops = list_entry(item, struct saa7134_mpeg_ops, next);
 		mpeg_ops_detach(mops, dev);
 	}
-	up(&devlist_lock);
+	mutex_unlock(&devlist_lock);
 	saa7134_devcount--;
 
 	saa7134_i2c_unregister(dev);
@@ -1071,13 +1072,13 @@ int saa7134_ts_register(struct saa7134_m
 	struct list_head *item;
 	struct saa7134_dev *dev;
 
-	down(&devlist_lock);
+	mutex_lock(&devlist_lock);
 	list_for_each(item,&saa7134_devlist) {
 		dev = list_entry(item, struct saa7134_dev, devlist);
 		mpeg_ops_attach(ops, dev);
 	}
 	list_add_tail(&ops->next,&mops_list);
-	up(&devlist_lock);
+	mutex_unlock(&devlist_lock);
 	return 0;
 }
 
@@ -1086,13 +1087,13 @@ void saa7134_ts_unregister(struct saa713
 	struct list_head *item;
 	struct saa7134_dev *dev;
 
-	down(&devlist_lock);
+	mutex_lock(&devlist_lock);
 	list_del(&ops->next);
 	list_for_each(item,&saa7134_devlist) {
 		dev = list_entry(item, struct saa7134_dev, devlist);
 		mpeg_ops_detach(ops, dev);
 	}
-	up(&devlist_lock);
+	mutex_unlock(&devlist_lock);
 }
 
 EXPORT_SYMBOL(saa7134_ts_register);
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
index d5be259..078880e 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -29,7 +29,6 @@
 #include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <asm/semaphore.h>
 
 #include <linux/videodev.h>
 
@@ -83,7 +82,7 @@ static struct class video_class = {
  */
 
 static struct video_device *video_device[VIDEO_NUM_DEVICES];
-static DECLARE_MUTEX(videodev_lock);
+static DEFINE_MUTEX(videodev_lock);
 
 struct video_device* video_devdata(struct file *file)
 {
@@ -102,15 +101,15 @@ static int video_open(struct inode *inod
 
 	if(minor>=VIDEO_NUM_DEVICES)
 		return -ENODEV;
-	down(&videodev_lock);
+	mutex_lock(&videodev_lock);
 	vfl=video_device[minor];
 	if(vfl==NULL) {
-		up(&videodev_lock);
+		mutex_unlock(&videodev_lock);
 		request_module("char-major-%d-%d", VIDEO_MAJOR, minor);
-		down(&videodev_lock);
+		mutex_lock(&videodev_lock);
 		vfl=video_device[minor];
 		if (vfl==NULL) {
-			up(&videodev_lock);
+			mutex_unlock(&videodev_lock);
 			return -ENODEV;
 		}
 	}
@@ -123,7 +122,7 @@ static int video_open(struct inode *inod
 		file->f_op = fops_get(old_fops);
 	}
 	fops_put(old_fops);
-	up(&videodev_lock);
+	mutex_unlock(&videodev_lock);
 	return err;
 }
 
@@ -304,12 +303,12 @@ int video_register_device(struct video_d
 	}
 
 	/* pick a minor number */
-	down(&videodev_lock);
+	mutex_lock(&videodev_lock);
 	if (nr >= 0  &&  nr < end-base) {
 		/* use the one the driver asked for */
 		i = base+nr;
 		if (NULL != video_device[i]) {
-			up(&videodev_lock);
+			mutex_unlock(&videodev_lock);
 			return -ENFILE;
 		}
 	} else {
@@ -318,13 +317,13 @@ int video_register_device(struct video_d
 			if (NULL == video_device[i])
 				break;
 		if (i == end) {
-			up(&videodev_lock);
+			mutex_unlock(&videodev_lock);
 			return -ENFILE;
 		}
 	}
 	video_device[i]=vfd;
 	vfd->minor=i;
-	up(&videodev_lock);
+	mutex_unlock(&videodev_lock);
 
 	sprintf(vfd->devfs_name, "v4l/%s%d", name_base, i - base);
 	devfs_mk_cdev(MKDEV(VIDEO_MAJOR, vfd->minor),
@@ -362,14 +361,14 @@ int video_register_device(struct video_d
 
 void video_unregister_device(struct video_device *vfd)
 {
-	down(&videodev_lock);
+	mutex_lock(&videodev_lock);
 	if(video_device[vfd->minor]!=vfd)
 		panic("videodev: bad unregister");
 
 	devfs_remove(vfd->devfs_name);
 	video_device[vfd->minor]=NULL;
 	class_device_unregister(&vfd->class_dev);
-	up(&videodev_lock);
+	mutex_unlock(&videodev_lock);
 }
 
 


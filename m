Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270196AbTGUPgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270160AbTGUPfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:35:39 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:12455 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S270165AbTGUPfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:35:13 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 21 Jul 2003 17:47:06 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>, Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [RFC/PATCH] 2/2 v4l: sysfs'ify bttv driver
Message-ID: <20030721154706.GB13871@bytesex.org>
References: <20030716202018.GC26510@bytesex.org> <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org> <20030717145749.GA5067@kroah.com> <20030717163715.GA19258@bytesex.org> <20030717214907.GA3255@kroah.com> <20030718095920.GA32558@bytesex.org> <20030718234359.GK1583@kroah.com> <20030721072853.GA21450@bytesex.org> <20030721154340.GA13871@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721154340.GA13871@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adapts the bttv driver to the recent videodev changes.
struct video_device is now dynamically allocated and freed on
->release() to fix sysfs race.  Also adds a private sysfs driver
attribute file.

  Gerd

==============================[ cut here ]==============================
diff -u linux-2.6.0-test1/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.0-test1/drivers/media/video/bttv-cards.c	2003-07-21 11:49:42.000000000 +0200
+++ linux/drivers/media/video/bttv-cards.c	2003-07-21 11:49:43.000000000 +0200
@@ -1851,12 +1851,8 @@
 		btv->type=card[btv->nr];
 	
 	/* print which card config we are using */
-	sprintf(btv->video_dev.name,"BT%d%s(%.23s)",
-		btv->id,
-		(btv->id==848 && btv->revision==0x12) ? "A" : "",
-		bttv_tvcards[btv->type].name);
 	printk(KERN_INFO "bttv%d: using: %s [card=%d,%s]\n",btv->nr,
-	       btv->video_dev.name,btv->type,
+	       bttv_tvcards[btv->type].name, btv->type,
 	       card[btv->nr] < bttv_num_tvcards
 	       ? "insmod option" : "autodetected");
 
diff -u linux-2.6.0-test1/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.0-test1/drivers/media/video/bttv-driver.c	2003-07-21 11:49:42.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2003-07-21 17:08:32.183882024 +0200
@@ -32,6 +32,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/kdev_t.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/byteorder.h>
@@ -123,6 +124,17 @@
 #endif
 
 /* ----------------------------------------------------------------------- */
+/* sysfs                                                                   */
+
+static ssize_t show_card(struct class_device *cd, char *buf)
+{
+	struct video_device *vfd = to_video_device(cd);
+	struct bttv *btv = dev_get_drvdata(vfd->dev);
+	return sprintf(buf, "%d\n", btv ? btv->type : UNSET);
+}
+static CLASS_DEVICE_ATTR(card, S_IRUGO, show_card, NULL);
+
+/* ----------------------------------------------------------------------- */
 /* static data                                                             */
 
 /* special timing tables from conexant... */
@@ -2039,7 +2051,7 @@
                 struct video_capability *cap = arg;
 
 		memset(cap,0,sizeof(*cap));
-                strcpy(cap->name,btv->video_dev.name);
+                strcpy(cap->name,btv->video_dev->name);
 		if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
 			/* vbi */
 			cap->type = VID_TYPE_TUNER|VID_TYPE_TELETEXT;
@@ -2390,7 +2402,7 @@
 		if (0 == v4l2)
 			return -EINVAL;
                 strcpy(cap->driver,"bttv");
-                strlcpy(cap->card,btv->video_dev.name,sizeof(cap->card));
+                strlcpy(cap->card,btv->video_dev->name,sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",btv->dev->slot_name);
 		cap->version = BTTV_VERSION_CODE;
 		cap->capabilities =
@@ -2767,12 +2779,12 @@
 	dprintk(KERN_DEBUG "bttv: open minor=%d\n",minor);
 
 	for (i = 0; i < bttv_num; i++) {
-		if (bttvs[i].video_dev.minor == minor) {
+		if (bttvs[i].video_dev->minor == minor) {
 			btv = &bttvs[i];
 			type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 			break;
 		}
-		if (bttvs[i].vbi_dev.minor == minor) {
+		if (bttvs[i].vbi_dev->minor == minor) {
 			btv = &bttvs[i];
 			type = V4L2_BUF_TYPE_VBI_CAPTURE;
 			break;
@@ -2873,8 +2885,8 @@
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	type:     VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
-	          VID_TYPE_CLIPPING|VID_TYPE_SCALES,
+	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	            VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
 	.minor    = -1,
@@ -2902,7 +2914,7 @@
 	dprintk("bttv: open minor=%d\n",minor);
 
 	for (i = 0; i < bttv_num; i++) {
-		if (bttvs[i].radio_dev.minor == minor) {
+		if (bttvs[i].radio_dev->minor == minor) {
 			btv = &bttvs[i];
 			break;
 		}
@@ -2947,7 +2959,7 @@
                 struct video_capability *cap = arg;
 
 		memset(cap,0,sizeof(*cap));
-                strcpy(cap->name,btv->radio_dev.name);
+                strcpy(cap->name,btv->radio_dev->name);
                 cap->type = VID_TYPE_TUNER;
 		cap->channels = 1;
 		cap->audios = 1;
@@ -3337,30 +3349,83 @@
 /* ----------------------------------------------------------------------- */
 /* initialitation                                                          */
 
+static struct video_device *vdev_init(struct bttv *btv,
+				      struct video_device *template,
+				      char *type)
+{
+	struct video_device *vfd;
+
+	vfd = video_device_alloc();
+	if (NULL == vfd)
+		return NULL;
+	*vfd = *template;
+	vfd->minor   = -1;
+	vfd->release = video_device_release;
+	vfd->dev     = &btv->dev->dev;
+	snprintf(vfd->name, sizeof(vfd->name), "BT%d%s %s (%s)",
+		 btv->id, (btv->id==848 && btv->revision==0x12) ? "A" : "",
+		 type, bttv_tvcards[btv->type].name);
+	return vfd;
+}
+
 /* register video4linux devices */
 static int __devinit bttv_register_video(struct bttv *btv)
 {
-        if(video_register_device(&btv->video_dev,VFL_TYPE_GRABBER,video_nr)<0)
-                return -1;
+	/* video */
+	btv->video_dev = vdev_init(btv, &bttv_video_template, "video");
+        if (NULL == btv->video_dev)
+		goto err;
+	if (video_register_device(btv->video_dev,VFL_TYPE_GRABBER,video_nr)<0)
+		goto err;
 	printk(KERN_INFO "bttv%d: registered device video%d\n",
-	       btv->nr,btv->video_dev.minor & 0x1f);
+	       btv->nr,btv->video_dev->minor & 0x1f);
+	video_device_create_file(btv->video_dev, &class_device_attr_card);
 
-        if(video_register_device(&btv->vbi_dev,VFL_TYPE_VBI,vbi_nr)<0) {
-                video_unregister_device(&btv->video_dev);
-                return -1;
-        }
+	/* vbi */
+	btv->vbi_dev = vdev_init(btv, &bttv_vbi_template, "vbi");
+        if (NULL == btv->vbi_dev)
+		goto err;
+        if (video_register_device(btv->vbi_dev,VFL_TYPE_VBI,vbi_nr)<0)
+		goto err;
 	printk(KERN_INFO "bttv%d: registered device vbi%d\n",
-	       btv->nr,btv->vbi_dev.minor & 0x1f);
+	       btv->nr,btv->vbi_dev->minor & 0x1f);
 
         if (!btv->has_radio)
 		return 0;
-	if (video_register_device(&btv->radio_dev, VFL_TYPE_RADIO,radio_nr)<0) {
-		video_unregister_device(&btv->vbi_dev);
-		video_unregister_device(&btv->video_dev);
-		return -1;
-        }
+	/* radio */
+	btv->radio_dev = vdev_init(btv, &radio_template, "radio");
+        if (NULL == btv->radio_dev)
+		goto err;
+	if (video_register_device(btv->radio_dev, VFL_TYPE_RADIO,radio_nr)<0)
+		goto err;
 	printk(KERN_INFO "bttv%d: registered device radio%d\n",
-	       btv->nr,btv->radio_dev.minor & 0x1f);
+	       btv->nr,btv->radio_dev->minor & 0x1f);
+
+	/* all done */
+	return 0;
+
+ err:
+	if (btv->video_dev) {
+		if (-1 != btv->video_dev->minor)
+			video_unregister_device(btv->video_dev);
+		else
+			video_device_release(btv->video_dev);
+		btv->video_dev = NULL;
+	}
+	if (btv->vbi_dev) {
+		if (-1 != btv->vbi_dev->minor)
+			video_unregister_device(btv->vbi_dev);
+		else
+			video_device_release(btv->vbi_dev);
+		btv->vbi_dev = NULL;
+	}
+	if (btv->radio_dev) {
+		if (-1 != btv->radio_dev->minor)
+			video_unregister_device(btv->radio_dev);
+		else
+			video_device_release(btv->radio_dev);
+		btv->radio_dev = NULL;
+	}
         return 0;
 }
 
@@ -3408,16 +3473,6 @@
         btv->i2c_rc = -1;
         btv->tuner_type  = UNSET;
         btv->pinnacle_id = UNSET;
-
-	memcpy(&btv->video_dev, &bttv_video_template, sizeof(bttv_video_template));
-	memcpy(&btv->radio_dev, &radio_template,      sizeof(radio_template));
-	memcpy(&btv->vbi_dev,   &bttv_vbi_template,   sizeof(bttv_vbi_template));
-        btv->video_dev.minor = -1;
-	btv->video_dev.priv = btv;
-        btv->radio_dev.minor = -1;
-	btv->radio_dev.priv = btv;
-        btv->vbi_dev.minor = -1;
-	btv->vbi_dev.priv = btv;
 	btv->has_radio=radio[btv->nr];
 	
 	/* pci stuff (init, get irq/mmip, ... */
@@ -3576,12 +3631,18 @@
 		i2c_bit_del_bus(&btv->i2c_adap);
 
 	/* unregister video4linux */
-        if (btv->video_dev.minor!=-1)
-                video_unregister_device(&btv->video_dev);
-        if (btv->radio_dev.minor!=-1)
-                video_unregister_device(&btv->radio_dev);
-	if (btv->vbi_dev.minor!=-1)
-                video_unregister_device(&btv->vbi_dev);
+        if (btv->video_dev) {
+                video_unregister_device(btv->video_dev);
+		btv->video_dev = NULL;
+	}
+        if (btv->radio_dev) {
+                video_unregister_device(btv->radio_dev);
+		btv->radio_dev = NULL;
+	}
+	if (btv->vbi_dev) {
+                video_unregister_device(btv->vbi_dev);
+		btv->vbi_dev = NULL;
+	}
 
 	/* free allocated memory */
 	btcx_riscmem_free(btv->dev,&btv->main);
diff -u linux-2.6.0-test1/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.0-test1/drivers/media/video/bttvp.h	2003-07-21 11:49:42.000000000 +0200
+++ linux/drivers/media/video/bttvp.h	2003-07-21 11:49:43.000000000 +0200
@@ -276,9 +276,9 @@
 	int                        i2c_state, i2c_rc;
 
 	/* video4linux (1) */
-	struct video_device video_dev;
-	struct video_device radio_dev;
-	struct video_device vbi_dev;
+	struct video_device *video_dev;
+	struct video_device *radio_dev;
+	struct video_device *vbi_dev;
 
 	/* locking */
 	spinlock_t s_lock;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbTGOOUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbTGOOUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:20:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:16822 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268000AbTGOOUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:20:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 15 Jul 2003 16:31:19 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030715143119.GB14133@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch moves the video4linux subsystem from procfs to sysfs.
Changes:

  * procfs support is completely gone, i.e. /proc/video doesn't
    exist any more.

  * there is a new device class instead: /sys/class/video4linux.
    All video4linux devices which used to be listed in
    /proc/video/dev are moved to that place.

Changes required/recommended in video4linux drivers:

  * some usb webcam drivers (usbvideo.ko, stv680.ko, se401.ko 
    and ov511.ko) use the video_proc_entry() to add additional
    procfs files.  These drivers must be converted to sysfs too
    because video_proc_entry() doesn't exist any more.

  * struct video_device has a new "dev" field pointing to a struct
    device.  Drivers should fill that one if possible.  It isn't
    required through.  It will give you fancy device + driver symlinks
    in /sys/class/video4linux/<name>.
    The patch below includes the changes for bttv.

Comments?

  Gerd

--- linux-2.6.0-test1/drivers/media/video/videodev.c.sysfs	2003-07-15 13:30:26.000000000 +0200
+++ linux-2.6.0-test1/drivers/media/video/videodev.c	2003-07-15 14:52:52.000000000 +0200
@@ -15,7 +15,6 @@
  *		- Added procfs support
  */
 
-#include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -35,33 +34,31 @@
 
 #include <linux/videodev.h>
 
-#define VIDEO_NUM_DEVICES	256 
+#define VIDEO_NUM_DEVICES	256
+#define VIDEO_NAME              "video4linux"
 
 /*
- *	Active devices 
+ *	sysfs stuff
  */
- 
-static struct video_device *video_device[VIDEO_NUM_DEVICES];
-static DECLARE_MUTEX(videodev_lock);
 
+static size_t show_name(struct class_device *cd, char *buf)
+{
+	struct video_device *vfd = cd->class_data;
+	return sprintf(buf,"%.*s\n",sizeof(vfd->name),vfd->name);
+}
 
-#ifdef CONFIG_VIDEO_PROC_FS
-
-#include <linux/proc_fs.h>
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-struct videodev_proc_data {
-	struct list_head proc_list;
-	char name[16];
-	struct video_device *vdev;
-	struct proc_dir_entry *proc_entry;
+static struct class video_class = {
+        .name = VIDEO_NAME,
 };
 
-static struct proc_dir_entry *video_dev_proc_entry = NULL;
-struct proc_dir_entry *video_proc_entry = NULL;
-EXPORT_SYMBOL(video_proc_entry);
-LIST_HEAD(videodev_proc_list);
-
-#endif /* CONFIG_VIDEO_PROC_FS */
+/*
+ *	Active devices 
+ */
+ 
+static struct video_device *video_device[VIDEO_NUM_DEVICES];
+static DECLARE_MUTEX(videodev_lock);
 
 struct video_device* video_devdata(struct file *file)
 {
@@ -219,156 +216,6 @@
 	return 0;
 }
 
-/*
- *	/proc support
- */
-
-#ifdef CONFIG_VIDEO_PROC_FS
-
-/* Hmm... i'd like to see video_capability information here, but
- * how can I access it (without changing the other drivers? -claudio
- */
-static int videodev_proc_read(char *page, char **start, off_t off,
-			       int count, int *eof, void *data)
-{
-	char *out = page;
-	struct video_device *vfd = data;
-	struct videodev_proc_data *d;
-	struct list_head *tmp;
-	int len;
-	char c = ' ';
-
-	list_for_each (tmp, &videodev_proc_list) {
-		d = list_entry(tmp, struct videodev_proc_data, proc_list);
-		if (vfd == d->vdev)
-			break;
-	}
-
-	/* Sanity check */
-	if (tmp == &videodev_proc_list)
-		goto skip;
-		
-#define PRINT_VID_TYPE(x) do { if (vfd->type & x) \
-	out += sprintf (out, "%c%s", c, #x); c='|';} while (0)
-
-	out += sprintf (out, "name            : %s\n", vfd->name);
-	out += sprintf (out, "type            :");
-		PRINT_VID_TYPE(VID_TYPE_CAPTURE);
-		PRINT_VID_TYPE(VID_TYPE_TUNER);
-		PRINT_VID_TYPE(VID_TYPE_TELETEXT);
-		PRINT_VID_TYPE(VID_TYPE_OVERLAY);
-		PRINT_VID_TYPE(VID_TYPE_CHROMAKEY);
-		PRINT_VID_TYPE(VID_TYPE_CLIPPING);
-		PRINT_VID_TYPE(VID_TYPE_FRAMERAM);
-		PRINT_VID_TYPE(VID_TYPE_SCALES);
-		PRINT_VID_TYPE(VID_TYPE_MONOCHROME);
-		PRINT_VID_TYPE(VID_TYPE_SUBCAPTURE);
-		PRINT_VID_TYPE(VID_TYPE_MPEG_DECODER);
-		PRINT_VID_TYPE(VID_TYPE_MPEG_ENCODER);
-		PRINT_VID_TYPE(VID_TYPE_MJPEG_DECODER);
-		PRINT_VID_TYPE(VID_TYPE_MJPEG_ENCODER);
-	out += sprintf (out, "\n");
-	out += sprintf (out, "hardware        : 0x%x\n", vfd->hardware);
-#if 0
-	out += sprintf (out, "channels        : %d\n", d->vcap.channels);
-	out += sprintf (out, "audios          : %d\n", d->vcap.audios);
-	out += sprintf (out, "maxwidth        : %d\n", d->vcap.maxwidth);
-	out += sprintf (out, "maxheight       : %d\n", d->vcap.maxheight);
-	out += sprintf (out, "minwidth        : %d\n", d->vcap.minwidth);
-	out += sprintf (out, "minheight       : %d\n", d->vcap.minheight);
-#endif
-
-skip:
-	len = out - page;
-	len -= off;
-	if (len < count) {
-		*eof = 1;
-		if (len <= 0)
-			return 0;
-	} else
-		len = count;
-
-	*start = page + off;
-
-	return len;
-}
-
-static void videodev_proc_create(void)
-{
-	video_proc_entry = create_proc_entry("video", S_IFDIR, &proc_root);
-
-	if (video_proc_entry == NULL) {
-		printk("video_dev: unable to initialise /proc/video\n");
-		return;
-	}
-
-	video_proc_entry->owner = THIS_MODULE;
-	video_dev_proc_entry = create_proc_entry("dev", S_IFDIR, video_proc_entry);
-
-	if (video_dev_proc_entry == NULL) {
-		printk("video_dev: unable to initialise /proc/video/dev\n");
-		return;
-	}
-
-	video_dev_proc_entry->owner = THIS_MODULE;
-}
-
-static void __exit videodev_proc_destroy(void)
-{
-	if (video_dev_proc_entry != NULL)
-		remove_proc_entry("dev", video_proc_entry);
-
-	if (video_proc_entry != NULL)
-		remove_proc_entry("video", &proc_root);
-}
-
-static void videodev_proc_create_dev (struct video_device *vfd, char *name)
-{
-	struct videodev_proc_data *d;
-	struct proc_dir_entry *p;
-
-	if (video_dev_proc_entry == NULL)
-		return;
-
-	d = kmalloc (sizeof (struct videodev_proc_data), GFP_KERNEL);
-	if (!d)
-		return;
-
-	p = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, video_dev_proc_entry);
-	if (!p) {
-		kfree(d);
-		return;
-	}
-	p->data = vfd;
-	p->read_proc = videodev_proc_read;
-
-	d->proc_entry = p;
-	d->vdev = vfd;
-	strcpy (d->name, name);
-
-	/* How can I get capability information ? */
-
-	list_add (&d->proc_list, &videodev_proc_list);
-}
-
-static void videodev_proc_destroy_dev (struct video_device *vfd)
-{
-	struct list_head *tmp;
-	struct videodev_proc_data *d;
-
-	list_for_each (tmp, &videodev_proc_list) {
-		d = list_entry(tmp, struct videodev_proc_data, proc_list);
-		if (vfd == d->vdev) {
-			remove_proc_entry(d->name, video_dev_proc_entry);
-			list_del (&d->proc_list);
-			kfree(d);
-			break;
-		}
-	}
-}
-
-#endif /* CONFIG_VIDEO_PROC_FS */
-
 extern struct file_operations video_fops;
 
 /**
@@ -456,15 +303,17 @@
 	devfs_mk_cdev(MKDEV(VIDEO_MAJOR, vfd->minor),
 			S_IFCHR | S_IRUSR | S_IWUSR, vfd->devfs_name);
 	init_MUTEX(&vfd->lock);
-	
-#ifdef CONFIG_VIDEO_PROC_FS
-{
-	char name[16];
-	sprintf(name, "%s%d", name_base, i - base);
-	videodev_proc_create_dev(vfd, name);
-}
-#endif
 
+	/* sysfs class */
+        memset(&vfd->class_dev, 0x00, sizeof(vfd->class_dev));
+	if (vfd->dev)
+		vfd->class_dev.dev = vfd->dev;
+	vfd->class_dev.class       = &video_class;
+	vfd->class_dev.class_data  = vfd;
+	strlcpy(vfd->class_dev.class_id, vfd->devfs_name + 4, BUS_ID_SIZE);
+	class_device_register(&vfd->class_dev);
+	class_device_create_file(&vfd->class_dev,
+				 &class_device_attr_name);
 	return 0;
 }
 
@@ -482,10 +331,7 @@
 	if(video_device[vfd->minor]!=vfd)
 		panic("videodev: bad unregister");
 
-#ifdef CONFIG_VIDEO_PROC_FS
-	videodev_proc_destroy_dev (vfd);
-#endif
-
+	class_device_unregister(&vfd->class_dev);
 	devfs_remove(vfd->devfs_name);
 	video_device[vfd->minor]=NULL;
 	up(&videodev_lock);
@@ -506,24 +352,18 @@
 static int __init videodev_init(void)
 {
 	printk(KERN_INFO "Linux video capture interface: v1.00\n");
-	if (register_chrdev(VIDEO_MAJOR,"video_capture", &video_fops)) {
+	if (register_chrdev(VIDEO_MAJOR,VIDEO_NAME, &video_fops)) {
 		printk("video_dev: unable to get major %d\n", VIDEO_MAJOR);
 		return -EIO;
 	}
-
-#ifdef CONFIG_VIDEO_PROC_FS
-	videodev_proc_create ();
-#endif
-	
+	class_register(&video_class);
 	return 0;
 }
 
 static void __exit videodev_exit(void)
 {
-#ifdef CONFIG_VIDEO_PROC_FS
-	videodev_proc_destroy ();
-#endif
-	unregister_chrdev(VIDEO_MAJOR, "video_capture");
+	class_unregister(&video_class);
+	unregister_chrdev(VIDEO_MAJOR, VIDEO_NAME);
 }
 
 module_init(videodev_init)
--- linux-2.6.0-test1/drivers/media/video/bttv-driver.c.sysfs	2003-07-14 12:37:01.000000000 +0200
+++ linux-2.6.0-test1/drivers/media/video/bttv-driver.c	2003-07-15 14:29:02.000000000 +0200
@@ -3413,11 +3413,14 @@
 	memcpy(&btv->radio_dev, &radio_template,      sizeof(radio_template));
 	memcpy(&btv->vbi_dev,   &bttv_vbi_template,   sizeof(bttv_vbi_template));
         btv->video_dev.minor = -1;
-	btv->video_dev.priv = btv;
+	btv->video_dev.priv  = btv;
+	btv->video_dev.dev   = &dev->dev;
         btv->radio_dev.minor = -1;
-	btv->radio_dev.priv = btv;
+	btv->radio_dev.priv  = btv;
+	btv->radio_dev.dev   = &dev->dev;
         btv->vbi_dev.minor = -1;
-	btv->vbi_dev.priv = btv;
+	btv->vbi_dev.priv  = btv;
+	btv->vbi_dev.dev   = &dev->dev;
 	btv->has_radio=radio[btv->nr];
 	
 	/* pci stuff (init, get irq/mmip, ... */
--- linux-2.6.0-test1/include/linux/videodev.h.sysfs	2003-07-14 12:05:25.000000000 +0200
+++ linux-2.6.0-test1/include/linux/videodev.h	2003-07-15 13:40:50.000000000 +0200
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>
 #include <linux/version.h>
+#include <linux/device.h>
 
 #if 1
 /*
@@ -24,6 +25,7 @@
 struct video_device
 {
 	struct module *owner;
+	struct device *dev;
      	char name[32];
  	int type;       /* v4l1 */
  	int type2;      /* v4l2 */
@@ -39,6 +41,7 @@
 	int users;
 	struct semaphore lock;
 	char devfs_name[64];	/* devfs */
+	struct class_device class_dev;
 };
 
 #define VIDEO_MAJOR	81

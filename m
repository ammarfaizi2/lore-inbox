Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTHGPpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHGPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:43:53 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:49896 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S270352AbTHGPkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:40:19 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Aug 2003 17:43:42 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>
Subject: [patch] v4l: sysfs'ify videodev
Message-ID: <20030807154342.GA818@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch drops procfs code from videodev.c and adds sysfs support
instead.  It adds a new class where all v4l devices are listed.  It
also provides some new helper functions for v4l drivers.

  Gerd

==============================[ cut here ]==============================
diff -u linux-2.6.0-test2/drivers/media/video/videodev.c linux/drivers/media/video/videodev.c
--- linux-2.6.0-test2/drivers/media/video/videodev.c	2003-08-06 11:13:47.000000000 +0200
+++ linux/drivers/media/video/videodev.c	2003-08-06 11:51:26.000000000 +0200
@@ -15,7 +15,6 @@
  *		- Added procfs support
  */
 
-#include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -28,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -35,33 +35,67 @@
 
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
 
+static ssize_t show_name(struct class_device *cd, char *buf)
+{
+	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
+	return sprintf(buf,"%.*s\n",(int)sizeof(vfd->name),vfd->name);
+}
+
+static ssize_t show_dev(struct class_device *cd, char *buf)
+{
+	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
+	dev_t dev = MKDEV(VIDEO_MAJOR, vfd->minor);
+	return sprintf(buf,"%04x\n",(int)dev);
+}
 
-#ifdef CONFIG_VIDEO_PROC_FS
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static CLASS_DEVICE_ATTR(dev,  S_IRUGO, show_dev, NULL);
 
-#include <linux/proc_fs.h>
+struct video_device *video_device_alloc(void)
+{
+	struct video_device *vfd;
 
-struct videodev_proc_data {
-	struct list_head proc_list;
-	char name[16];
-	struct video_device *vdev;
-	struct proc_dir_entry *proc_entry;
-};
+	vfd = kmalloc(sizeof(*vfd),GFP_KERNEL);
+	if (NULL == vfd)
+		return NULL;
+	memset(vfd,0,sizeof(*vfd));
+	return vfd;
+}
+
+void video_device_release(struct video_device *vfd)
+{
+	kfree(vfd);
+}
+
+static void video_release(struct class_device *cd)
+{
+	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
 
-static struct proc_dir_entry *video_dev_proc_entry = NULL;
-struct proc_dir_entry *video_proc_entry = NULL;
-EXPORT_SYMBOL(video_proc_entry);
-LIST_HEAD(videodev_proc_list);
+#if 1 /* needed until all drivers are fixed */
+	if (!vfd->release)
+		return;
+#endif
+	vfd->release(vfd);
+}
 
-#endif /* CONFIG_VIDEO_PROC_FS */
+static struct class video_class = {
+        .name    = VIDEO_NAME,
+	.release = video_release,
+};
+
+/*
+ *	Active devices 
+ */
+ 
+static struct video_device *video_device[VIDEO_NUM_DEVICES];
+static DECLARE_MUTEX(videodev_lock);
 
 struct video_device* video_devdata(struct file *file)
 {
@@ -192,156 +226,6 @@
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
@@ -429,15 +313,25 @@
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
+	strlcpy(vfd->class_dev.class_id, vfd->devfs_name + 4, BUS_ID_SIZE);
+	class_device_register(&vfd->class_dev);
+	class_device_create_file(&vfd->class_dev,
+				 &class_device_attr_name);
+	class_device_create_file(&vfd->class_dev,
+				 &class_device_attr_dev);
+
+#if 1 /* needed until all drivers are fixed */
+	if (!vfd->release)
+		printk(KERN_WARNING "videodev: \"%s\" has no release callback. "
+		       "Please fix your driver for proper sysfs support, see "
+		       "http://lwn.net/Articles/36850/\n", vfd->name);
+#endif
 	return 0;
 }
 
@@ -455,10 +349,7 @@
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
@@ -479,24 +370,18 @@
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
@@ -508,6 +393,8 @@
 EXPORT_SYMBOL(video_usercopy);
 EXPORT_SYMBOL(video_exclusive_open);
 EXPORT_SYMBOL(video_exclusive_release);
+EXPORT_SYMBOL(video_device_alloc);
+EXPORT_SYMBOL(video_device_release);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");
diff -u linux-2.6.0-test2/include/linux/videodev.h linux/include/linux/videodev.h
--- linux-2.6.0-test2/include/linux/videodev.h	2003-08-06 11:15:49.000000000 +0200
+++ linux/include/linux/videodev.h	2003-08-06 11:51:26.000000000 +0200
@@ -3,18 +3,10 @@
 
 #include <linux/types.h>
 #include <linux/version.h>
+#include <linux/device.h>
 
-#if 1
-/*
- * v4l2 is still work-in-progress, integration planed for 2.5.x
- *   documentation:           http://bytesex.org/v4l/
- *   patches available from:  http://bytesex.org/patches/
- */ 
-# define HAVE_V4L2 1
-# include <linux/videodev2.h>
-#else
-# undef HAVE_V4L2
-#endif
+#define HAVE_V4L2 1
+#include <linux/videodev2.h>
 
 #ifdef __KERNEL__
 
@@ -23,35 +15,71 @@
 
 struct video_device
 {
-	struct module *owner;
-     	char name[32];
- 	int type;       /* v4l1 */
- 	int type2;      /* v4l2 */
+	/* device info */
+	struct device *dev;
+	char name[32];
+	int type;       /* v4l1 */
+	int type2;      /* v4l2 */
 	int hardware;
 	int minor;
 
- 	/* new interface -- we will use file_operations directly
- 	 * like soundcore does. */
- 	struct file_operations *fops;
-	void *priv;		/* Used to be 'private' but that upsets C++ */
-
-	/* for videodev.c intenal usage -- don't touch */
-	int users;
-	struct semaphore lock;
-	char devfs_name[64];	/* devfs */
+	/* device ops + callbacks */
+	struct file_operations *fops;
+	void (*release)(struct video_device *vfd);
+
+
+#if 1 /* to be removed in 2.7.x */
+	/* obsolete -- fops->owner is used instead */
+	struct module *owner;
+	/* dev->driver_data will be used instead some day.
+	 * Use the video_{get|set}_drvdata() helper functions,
+	 * so the switch over will be transparent for you.
+	 * Or use {pci|usb}_{get|set}_drvdata() directly. */
+	void *priv;
+#endif
+
+	/* for videodev.c intenal usage -- please don't touch */
+	int users;                     /* video_exclusive_{open|close} ... */
+	struct semaphore lock;         /* ... helper function uses these   */
+	char devfs_name[64];           /* devfs */
+	struct class_device class_dev; /* sysfs */
 };
 
 #define VIDEO_MAJOR	81
-extern int video_register_device(struct video_device *, int type, int nr);
 
 #define VFL_TYPE_GRABBER	0
 #define VFL_TYPE_VBI		1
 #define VFL_TYPE_RADIO		2
 #define VFL_TYPE_VTX		3
 
+extern int video_register_device(struct video_device *, int type, int nr);
 extern void video_unregister_device(struct video_device *);
 extern struct video_device* video_devdata(struct file*);
 
+#define to_video_device(cd) container_of(cd, struct video_device, class_dev)
+static inline void
+video_device_create_file(struct video_device *vfd,
+			 struct class_device_attribute *attr)
+{
+	class_device_create_file(&vfd->class_dev, attr);
+}
+
+/* helper functions to alloc / release struct video_device, the
+   later can be used for video_device->release() */
+struct video_device *video_device_alloc(void);
+void video_device_release(struct video_device *vfd);
+
+/* helper functions to access driver private data. */
+static inline void *video_get_drvdata(struct video_device *dev)
+{
+	return dev->priv;
+}
+
+static inline void video_set_drvdata(struct video_device *dev, void *data)
+{
+	dev->priv = data;
+}
+
 extern int video_exclusive_open(struct inode *inode, struct file *file);
 extern int video_exclusive_release(struct inode *inode, struct file *file);
 extern int video_usercopy(struct inode *inode, struct file *file,

-- 
sigfault

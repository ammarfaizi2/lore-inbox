Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUBGBDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUBGBCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:02:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:49423 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265799AbUBGBBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:01:40 -0500
Date: Sat, 7 Feb 2004 01:01:35 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
In-Reply-To: <20040207005954.GB4492@kroah.com>
Message-ID: <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, Feb 07, 2004 at 12:34:29AM +0000, James Simmons wrote:
> > 
> > Linus, please do a
> > 
> > 	bk pull http://fbdev.bkbits.net/fbdev-2.6
> > 
> > This will update the following files:
> > 
> >  drivers/video/Makefile  |    2 
> >  drivers/video/fbmem.c   |    6 ++
> >  drivers/video/fbsysfs.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fb.h      |   40 ++++++++++-------
> >  4 files changed, 141 insertions(+), 17 deletions(-)
> > 
> > through these ChangeSets:
> > 
> > <jsimmons@infradead.org> (04/02/06 1.1549)
> >    [FBDEV] Add syfs support.
> 
> Is there a patch anywhere to look at?

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/Makefile fbdev-2.6/drivers/video/Makefile
--- linus-2.6/drivers/video/Makefile	2004-01-27 19:48:11.000000000 -0800
+++ fbdev-2.6/drivers/video/Makefile	2004-02-06 03:45:49.000000000 -0800
@@ -7,7 +7,7 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 += macmodes.o
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2004-01-27 19:48:11.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmem.c	2004-02-06 03:45:53.000000000 -0800
@@ -1228,6 +1228,9 @@
 			break;
 	fb_info->node = i;
 	
+	if (fb_add_class_device(fb_info))
+		return -EINVAL;
+	
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 		if (fb_info->pixmap.addr) {
@@ -1276,6 +1279,7 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	class_device_del(&fb_info->class_dev);
 	return 0;
 }
 
@@ -1300,6 +1304,8 @@
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
+	class_register(&fb_class);
+	
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
 		offb_init();
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbsysfs.c fbdev-2.6/drivers/video/fbsysfs.c
--- linus-2.6/drivers/video/fbsysfs.c	1969-12-31 16:00:00.000000000 -0800
+++ fbdev-2.6/drivers/video/fbsysfs.c	2004-02-06 03:45:59.000000000 -0800
@@ -0,0 +1,110 @@
+/*
+ * fbsysfs.c - framebuffer device class and attributes
+ *
+ * Copyright (c) 2004 James Simmons <jsimmons@infradead.org>
+ * 
+ *	This program is free software you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/fb.h>
+
+#define to_fb_info(class) container_of(class, struct fb_info, class_dev)
+
+static void release_fb_info(struct class_device *class_dev)
+{
+	struct fb_info *info = to_fb_info(class_dev);
+
+	/* This doesn't harm */
+	fb_dealloc_cmap(&info->cmap);
+
+	kfree(info);
+}
+
+struct class fb_class = {
+	.name 		= "graphics",
+	.release 	= &release_fb_info,
+};
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct fb_info *info = to_fb_info(class_dev);
+
+	return sprintf(buf, "%u:%u\n", FB_MAJOR, info->node);
+}
+
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+int fb_add_class_device(struct fb_info *info)
+{
+	int retval;
+
+	info->class_dev.class = &fb_class;
+	snprintf(info->class_dev.class_id, BUS_ID_SIZE, "fb%d",
+		 info->node);
+	retval = class_device_register(&info->class_dev);
+	if (retval)
+		return retval;
+	return class_device_create_file(&info->class_dev,
+					&class_device_attr_dev);
+}
+
+/**
+ * framebuffer_alloc - creates a new frame buffer info structure
+ *
+ * @size: size of driver private data, can be zero
+ * @dev: pointer to the device for this fb, this can be NULL
+ *
+ * Creates a new frame buffer info structure. Also reserves @size bytes
+ * for driver private data (info->par). info->par (if any) will be
+ * aligned to sizeof(long).
+ *
+ * Returns the new structure, or NULL if an error occured.
+ *
+ */
+struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
+{
+#define BYTES_PER_LONG (BITS_PER_LONG/8)
+#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
+	int fb_info_size = sizeof(struct fb_info);
+	struct fb_info *info;
+	char *p;
+
+	if (size)
+		fb_info_size += PADDING;
+
+	p = kmalloc(fb_info_size + size, GFP_KERNEL);
+	if (!p)
+		return NULL;
+	memset(p, 0, fb_info_size + size);
+	info = (struct fb_info *) p;
+	info->class_dev.dev = dev;
+
+	if (size)
+		info->par = p + fb_info_size;
+
+	return info;
+#undef PADDING
+#undef BYTES_PER_LONG
+}
+
+/**
+ * framebuffer_release - marks the structure available for freeing
+ *
+ * @info: frame buffer info structure
+ *
+ * Drop the reference count of the class_device embedded in the
+ * framebuffer info structure.
+ *
+ */
+void framebuffer_release(struct fb_info *info)
+{
+	class_device_put(&info->class_dev);
+}
+
+EXPORT_SYMBOL(framebuffer_release);
+EXPORT_SYMBOL(framebuffer_alloc);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2004-02-05 21:58:26.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2004-02-06 03:52:50.000000000 -0800
@@ -433,24 +433,25 @@
 };
 
 struct fb_info {
-   int node;
-   int flags;
-   int open;                            /* Has this been open already ? */
+	int node;
+	int flags;
+	int open;			/* Has this been open already ? */
 #define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
-   struct fb_var_screeninfo var;        /* Current var */
-   struct fb_fix_screeninfo fix;        /* Current fix */
-   struct fb_monspecs monspecs;         /* Current Monitor specs */
-   struct fb_cursor cursor;		/* Current cursor */	
-   struct work_struct queue;		/* Framebuffer event queue */
+	struct fb_var_screeninfo var;	/* Current var */
+	struct fb_fix_screeninfo fix;	/* Current fix */
+	struct fb_monspecs monspecs;	/* Current Monitor specs */
+	struct fb_cursor cursor;	/* Current cursor */	
+	struct work_struct queue;	/* Framebuffer event queue */
 	struct fb_pixmap pixmap;	/* Image Hardware Mapper */
-   struct fb_cmap cmap;                 /* Current cmap */
-   struct fb_ops *fbops;
-   char *screen_base;                   /* Virtual address */
-   struct vc_data *display_fg;		/* Console visible on this display */
-   int currcon;				/* Current VC. */	
-   void *pseudo_palette;                /* Fake palette of 16 colors */ 
-   /* From here on everything is device dependent */
-   void *par;	
+	struct fb_cmap cmap;		/* Current cmap */
+	struct fb_ops *fbops;
+	char *screen_base;		/* Virtual address */
+	struct vc_data *display_fg;	/* Console visible on this display */
+	int currcon;			/* Current VC. */
+	struct class_device class_dev;	/* Sysfs data */	
+	void *pseudo_palette;		/* Fake palette of 16 colors */ 
+	/* From here on everything is device dependent */
+	void *par;	
 };
 
 #ifdef MODULE
@@ -528,6 +529,13 @@
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
+/* drivers/video/fbsysfs.c */
+extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
+extern void framebuffer_release(struct fb_info *info);
+extern int fb_add_class_device(struct fb_info *info);
+
+extern struct class fb_class;
+
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS       0
 #define FB_VSYNCTIMINGS     1


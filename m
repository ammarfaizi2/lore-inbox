Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUBNQuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBNQuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:50:51 -0500
Received: from verein.lst.de ([212.34.189.10]:26842 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262355AbUBNQuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:50:46 -0500
Date: Sat, 14 Feb 2004 17:50:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org, jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] back out fbdev sysfs support
Message-ID: <20040214165037.GA15985@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.849 () BAYES_00,DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch backs out James' sysfs support for fbdev again.  It
introduces a big, race for every driver not converted to
framebuffer_{alloc,release} (that is every driver but Ben's new
radeonfb).

I've left in framebuffer_{alloc,release} as stubs so drivers can be
converted to it gradually and once all drivers are done it can be
enabled again.

<rant>
James, what about pushing the 2GB worth of fbdev driver fixes in your
tree to Linus so people actually get working fb support again instead
of adding new holes?  A maintainers job can't be to apply patches to
his personal CVS repository and sitting on them forever
</rant>


--- 1.82/drivers/video/fbmem.c	Thu Feb 12 18:14:53 2004
+++ edited/drivers/video/fbmem.c	Fri Feb 13 06:00:42 2004
@@ -1228,9 +1228,6 @@
 			break;
 	fb_info->node = i;
 	
-	if (fb_add_class_device(fb_info))
-		return -EINVAL;
-	
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 		if (fb_info->pixmap.addr) {
@@ -1279,7 +1276,6 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
-	class_device_del(&fb_info->class_dev);
 	return 0;
 }
 
@@ -1307,8 +1303,6 @@
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
-	class_register(&fb_class);
-	
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
 		offb_init();
--- 1.1/drivers/video/fbsysfs.c	Fri Feb  6 12:14:39 2004
+++ edited/drivers/video/fbsysfs.c	Fri Feb 13 08:04:18 2004
@@ -9,50 +9,15 @@
  *	2 of the License, or (at your option) any later version.
  */
 
-#include <linux/config.h>
+/*
+ * Note:  currently there's only stubs for framebuffer_alloc and
+ * framebuffer_release here.  The reson for that is that until all drivers
+ * are converted to use it a sysfsification will open OOPSable races.
+ */
+
 #include <linux/kernel.h>
 #include <linux/fb.h>
 
-#define to_fb_info(class) container_of(class, struct fb_info, class_dev)
-
-static void release_fb_info(struct class_device *class_dev)
-{
-	struct fb_info *info = to_fb_info(class_dev);
-
-	/* This doesn't harm */
-	fb_dealloc_cmap(&info->cmap);
-
-	kfree(info);
-}
-
-struct class fb_class = {
-	.name 		= "graphics",
-	.release 	= &release_fb_info,
-};
-
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct fb_info *info = to_fb_info(class_dev);
-
-	return sprintf(buf, "%u:%u\n", FB_MAJOR, info->node);
-}
-
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
-int fb_add_class_device(struct fb_info *info)
-{
-	int retval;
-
-	info->class_dev.class = &fb_class;
-	snprintf(info->class_dev.class_id, BUS_ID_SIZE, "fb%d",
-		 info->node);
-	retval = class_device_register(&info->class_dev);
-	if (retval)
-		return retval;
-	return class_device_create_file(&info->class_dev,
-					&class_device_attr_dev);
-}
-
 /**
  * framebuffer_alloc - creates a new frame buffer info structure
  *
@@ -82,7 +47,6 @@
 		return NULL;
 	memset(p, 0, fb_info_size + size);
 	info = (struct fb_info *) p;
-	info->class_dev.dev = dev;
 
 	if (size)
 		info->par = p + fb_info_size;
@@ -103,7 +67,7 @@
  */
 void framebuffer_release(struct fb_info *info)
 {
-	class_device_put(&info->class_dev);
+	kfree(info);
 }
 
 EXPORT_SYMBOL(framebuffer_release);
--- 1.57/include/linux/fb.h	Fri Feb 13 16:19:26 2004
+++ edited/include/linux/fb.h	Fri Feb 13 08:04:27 2004
@@ -448,7 +448,6 @@
 	char *screen_base;		/* Virtual address */
 	struct vc_data *display_fg;	/* Console visible on this display */
 	int currcon;			/* Current VC. */
-	struct class_device class_dev;	/* Sysfs data */	
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 	/* From here on everything is device dependent */
 	void *par;	
@@ -533,9 +532,6 @@
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
-extern int fb_add_class_device(struct fb_info *info);
-
-extern struct class fb_class;
 
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS       0

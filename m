Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162271AbWLAX3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162271AbWLAX3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162243AbWLAXXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:38893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162266AbWLAXX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:29 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 22/36] Driver core: convert fb code to use struct device
Date: Fri,  1 Dec 2006 15:21:52 -0800
Message-Id: <11650153961479-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153922117-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/video/fbmem.c   |   16 ++--
 drivers/video/fbsysfs.c |  163 ++++++++++++++++++++++++++---------------------
 include/linux/fb.h      |    8 +-
 3 files changed, 103 insertions(+), 84 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 93ffcdd..e973a87 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1296,14 +1296,14 @@ register_framebuffer(struct fb_info *fb_
 			break;
 	fb_info->node = i;
 
-	fb_info->class_device = class_device_create(fb_class, NULL, MKDEV(FB_MAJOR, i),
-				    fb_info->device, "fb%d", i);
-	if (IS_ERR(fb_info->class_device)) {
+	fb_info->dev = device_create(fb_class, fb_info->device,
+				     MKDEV(FB_MAJOR, i), "fb%d", i);
+	if (IS_ERR(fb_info->dev)) {
 		/* Not fatal */
-		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(fb_info->class_device));
-		fb_info->class_device = NULL;
+		printk(KERN_WARNING "Unable to create device for framebuffer %d; errno = %ld\n", i, PTR_ERR(fb_info->dev));
+		fb_info->dev = NULL;
 	} else
-		fb_init_class_device(fb_info);
+		fb_init_device(fb_info);
 
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1356,8 +1356,8 @@ unregister_framebuffer(struct fb_info *f
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
-	fb_cleanup_class_device(fb_info);
-	class_device_destroy(fb_class, MKDEV(FB_MAJOR, i));
+	fb_cleanup_device(fb_info);
+	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
 	return 0;
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index d3a5041..323bdf6 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(framebuffer_alloc);
  *
  * @info: frame buffer info structure
  *
- * Drop the reference count of the class_device embedded in the
+ * Drop the reference count of the device embedded in the
  * framebuffer info structure.
  *
  */
@@ -120,10 +120,10 @@ static int mode_string(char *buf, unsign
 	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
-static ssize_t store_mode(struct class_device *class_device, const char * buf,
-			  size_t count)
+static ssize_t store_mode(struct device *device, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	char mstr[100];
 	struct fb_var_screeninfo var;
 	struct fb_modelist *modelist;
@@ -151,9 +151,10 @@ static ssize_t store_mode(struct class_d
 	return -EINVAL;
 }
 
-static ssize_t show_mode(struct class_device *class_device, char *buf)
+static ssize_t show_mode(struct device *device, struct device_attribute *attr,
+			 char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 
 	if (!fb_info->mode)
 		return 0;
@@ -161,10 +162,11 @@ static ssize_t show_mode(struct class_de
 	return mode_string(buf, 0, fb_info->mode);
 }
 
-static ssize_t store_modes(struct class_device *class_device, const char * buf,
-			   size_t count)
+static ssize_t store_modes(struct device *device,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	LIST_HEAD(old_list);
 	int i = count / sizeof(struct fb_videomode);
 
@@ -186,9 +188,10 @@ static ssize_t store_modes(struct class_
 	return 0;
 }
 
-static ssize_t show_modes(struct class_device *class_device, char *buf)
+static ssize_t show_modes(struct device *device, struct device_attribute *attr,
+			  char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	unsigned int i;
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -203,10 +206,10 @@ static ssize_t show_modes(struct class_d
 	return i;
 }
 
-static ssize_t store_bpp(struct class_device *class_device, const char * buf,
-			 size_t count)
+static ssize_t store_bpp(struct device *device, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	struct fb_var_screeninfo var;
 	char ** last = NULL;
 	int err;
@@ -218,16 +221,18 @@ static ssize_t store_bpp(struct class_de
 	return count;
 }
 
-static ssize_t show_bpp(struct class_device *class_device, char *buf)
+static ssize_t show_bpp(struct device *device, struct device_attribute *attr,
+			char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.bits_per_pixel);
 }
 
-static ssize_t store_rotate(struct class_device *class_device, const char *buf,
-			    size_t count)
+static ssize_t store_rotate(struct device *device,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	struct fb_var_screeninfo var;
 	char **last = NULL;
 	int err;
@@ -242,17 +247,19 @@ static ssize_t store_rotate(struct class
 }
 
 
-static ssize_t show_rotate(struct class_device *class_device, char *buf)
+static ssize_t show_rotate(struct device *device,
+			   struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.rotate);
 }
 
-static ssize_t store_virtual(struct class_device *class_device,
-			     const char * buf, size_t count)
+static ssize_t store_virtual(struct device *device,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	struct fb_var_screeninfo var;
 	char *last = NULL;
 	int err;
@@ -269,23 +276,26 @@ static ssize_t store_virtual(struct clas
 	return count;
 }
 
-static ssize_t show_virtual(struct class_device *class_device, char *buf)
+static ssize_t show_virtual(struct device *device,
+			    struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xres_virtual,
 			fb_info->var.yres_virtual);
 }
 
-static ssize_t show_stride(struct class_device *class_device, char *buf)
+static ssize_t show_stride(struct device *device,
+			   struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
 }
 
-static ssize_t store_blank(struct class_device *class_device, const char * buf,
-			   size_t count)
+static ssize_t store_blank(struct device *device,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	char *last = NULL;
 	int err;
 
@@ -299,42 +309,48 @@ static ssize_t store_blank(struct class_
 	return count;
 }
 
-static ssize_t show_blank(struct class_device *class_device, char *buf)
+static ssize_t show_blank(struct device *device,
+			  struct device_attribute *attr, char *buf)
 {
-//	struct fb_info *fb_info = class_get_devdata(class_device);
+//	struct fb_info *fb_info = dev_get_drvdata(device);
 	return 0;
 }
 
-static ssize_t store_console(struct class_device *class_device,
-			     const char * buf, size_t count)
+static ssize_t store_console(struct device *device,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
-//	struct fb_info *fb_info = class_get_devdata(class_device);
+//	struct fb_info *fb_info = dev_get_drvdata(device);
 	return 0;
 }
 
-static ssize_t show_console(struct class_device *class_device, char *buf)
+static ssize_t show_console(struct device *device,
+			    struct device_attribute *attr, char *buf)
 {
-//	struct fb_info *fb_info = class_get_devdata(class_device);
+//	struct fb_info *fb_info = dev_get_drvdata(device);
 	return 0;
 }
 
-static ssize_t store_cursor(struct class_device *class_device,
-			    const char * buf, size_t count)
+static ssize_t store_cursor(struct device *device,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
-//	struct fb_info *fb_info = class_get_devdata(class_device);
+//	struct fb_info *fb_info = dev_get_drvdata(device);
 	return 0;
 }
 
-static ssize_t show_cursor(struct class_device *class_device, char *buf)
+static ssize_t show_cursor(struct device *device,
+			   struct device_attribute *attr, char *buf)
 {
-//	struct fb_info *fb_info = class_get_devdata(class_device);
+//	struct fb_info *fb_info = dev_get_drvdata(device);
 	return 0;
 }
 
-static ssize_t store_pan(struct class_device *class_device, const char * buf,
-			 size_t count)
+static ssize_t store_pan(struct device *device,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	struct fb_var_screeninfo var;
 	char *last = NULL;
 	int err;
@@ -355,24 +371,27 @@ static ssize_t store_pan(struct class_de
 	return count;
 }
 
-static ssize_t show_pan(struct class_device *class_device, char *buf)
+static ssize_t show_pan(struct device *device,
+			struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xoffset,
 			fb_info->var.xoffset);
 }
 
-static ssize_t show_name(struct class_device *class_device, char *buf)
+static ssize_t show_name(struct device *device,
+			 struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", fb_info->fix.id);
 }
 
-static ssize_t store_fbstate(struct class_device *class_device,
-			const char *buf, size_t count)
+static ssize_t store_fbstate(struct device *device,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	u32 state;
 	char *last = NULL;
 
@@ -385,17 +404,19 @@ static ssize_t store_fbstate(struct clas
 	return count;
 }
 
-static ssize_t show_fbstate(struct class_device *class_device, char *buf)
+static ssize_t show_fbstate(struct device *device,
+			    struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
 }
 
 #ifdef CONFIG_FB_BACKLIGHT
-static ssize_t store_bl_curve(struct class_device *class_device,
-		const char *buf, size_t count)
+static ssize_t store_bl_curve(struct device *device,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	u8 tmp_curve[FB_BACKLIGHT_LEVELS];
 	unsigned int i;
 
@@ -432,9 +453,10 @@ static ssize_t store_bl_curve(struct cla
 	return count;
 }
 
-static ssize_t show_bl_curve(struct class_device *class_device, char *buf)
+static ssize_t show_bl_curve(struct device *device,
+			     struct device_attribute *attr, char *buf)
 {
-	struct fb_info *fb_info = class_get_devdata(class_device);
+	struct fb_info *fb_info = dev_get_drvdata(device);
 	ssize_t len = 0;
 	unsigned int i;
 
@@ -465,7 +487,7 @@ static ssize_t show_bl_curve(struct clas
 /* When cmap is added back in it should be a binary attribute
  * not a text one. Consideration should also be given to converting
  * fbdev to use configfs instead of sysfs */
-static struct class_device_attribute class_device_attrs[] = {
+static struct device_attribute device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
 	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
@@ -483,17 +505,16 @@ static struct class_device_attribute cla
 #endif
 };
 
-int fb_init_class_device(struct fb_info *fb_info)
+int fb_init_device(struct fb_info *fb_info)
 {
 	int i, error = 0;
 
-	class_set_devdata(fb_info->class_device, fb_info);
+	dev_set_drvdata(fb_info->dev, fb_info);
 
 	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++) {
-		error = class_device_create_file(fb_info->class_device,
-						 &class_device_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
+		error = device_create_file(fb_info->dev, &device_attrs[i]);
 
 		if (error)
 			break;
@@ -501,22 +522,20 @@ int fb_init_class_device(struct fb_info
 
 	if (error) {
 		while (--i >= 0)
-			class_device_remove_file(fb_info->class_device,
-						 &class_device_attrs[i]);
+			device_remove_file(fb_info->dev, &device_attrs[i]);
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
 	}
 
 	return 0;
 }
 
-void fb_cleanup_class_device(struct fb_info *fb_info)
+void fb_cleanup_device(struct fb_info *fb_info)
 {
 	unsigned int i;
 
 	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
-		for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-			class_device_remove_file(fb_info->class_device,
-						 &class_device_attrs[i]);
+		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
+			device_remove_file(fb_info->dev, &device_attrs[i]);
 
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
 	}
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3e69241..fa23e06 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -774,8 +774,8 @@ struct fb_info {
 #endif
 
 	struct fb_ops *fbops;
-	struct device *device;
-	struct class_device *class_device; /* sysfs per device attrs */
+	struct device *device;		/* This is the parent */
+	struct device *dev;		/* This is this fb device */
 	int class_flag;                    /* private sysfs flags */
 #ifdef CONFIG_FB_TILEBLITTING
 	struct fb_tile_ops *tileops;    /* Tile Blitting */
@@ -910,8 +910,8 @@ static inline void __fb_pad_aligned_buff
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
-extern int fb_init_class_device(struct fb_info *fb_info);
-extern void fb_cleanup_class_device(struct fb_info *head);
+extern int fb_init_device(struct fb_info *fb_info);
+extern void fb_cleanup_device(struct fb_info *head);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
 
 /* drivers/video/fbmon.c */
-- 
1.4.4.1


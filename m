Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWFFLLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWFFLLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWFFLLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:11:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751233AbWFFLK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:10:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=WRuw+wzIi12B71HUA6gfvWd4tuMxrUhGjA9U7+xuhNUD4BDjXcVV8+5y9DxREdCqbcFro/LgL0qg4QC4US/paQBGL+OOCP2vI5oVelj0T8x1zMLnTcCZKlo+NNshW6kNPJGlUczvJPFwwz+XsJC2u0hm7/9z1WVMH9p5KLo8xDY=
Message-ID: <44856242.8050005@gmail.com>
Date: Tue, 06 Jun 2006 19:08:50 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] Detaching fbcon: Add sysfs class device entry for fbcon
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order for this feature to work, an interface will be needed. The most
appropriate is sysfs. However, the framebuffer console has no sysfs entry yet.
This will create a sysfs class device entry for fbcon under
/sys/class/graphics.

Add a class_device entry 'fbcon' under class 'graphics'. Console-specific
attributes which where previously under class/graphics/fb[x] are moved to
class/graphics/fbcon. These attributes, 'con_rotate' and 'con_rotate_all',
are also renamed to 'rotate' and 'rotate_all' respectively.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Makefile        |    8 +--
 drivers/video/console/fbcon.c |  113 ++++++++++++++++++++++++++++++++++++++---
 drivers/video/console/fbcon.h |    1 
 drivers/video/fbmem.c         |   25 +--------
 drivers/video/fbsysfs.c       |   41 ---------------
 include/linux/fb.h            |    7 ---
 6 files changed, 112 insertions(+), 83 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 23de3b2..4800358 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -4,15 +4,15 @@ # Rewritten to use lists instead of if-s
 
 # Each configuration option enables a list of files.
 
-obj-$(CONFIG_VT)		  += console/
-obj-$(CONFIG_LOGO)		  += logo/
-obj-$(CONFIG_SYSFS)		  += backlight/
-
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o
 fb-objs                           := $(fb-y)
 
+obj-$(CONFIG_VT)		  += console/
+obj-$(CONFIG_LOGO)		  += logo/
+obj-$(CONFIG_SYSFS)		  += backlight/
+
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
 obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 953eb8c..014afea 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -195,6 +195,8 @@ static void fbcon_redraw_move(struct vc_
 static void fbcon_modechanged(struct fb_info *info);
 static void fbcon_set_all_vcs(struct fb_info *info);
 
+static struct class_device *fbcon_class_device;
+
 #ifdef CONFIG_MAC
 /*
  * On the Macintoy, there may or may not be a working VBL int. We need to probe
@@ -2945,14 +2947,6 @@ static int fbcon_event_notify(struct not
 	case FB_EVENT_NEW_MODELIST:
 		fbcon_new_modelist(info);
 		break;
-	case FB_EVENT_SET_CON_ROTATE:
-		fbcon_rotate(info, *(int *)event->data);
-		break;
-	case FB_EVENT_GET_CON_ROTATE:
-		ret = fbcon_get_rotate(info);
-		break;
-	case FB_EVENT_SET_CON_ROTATE_ALL:
-		fbcon_rotate_all(info, *(int *)event->data);
 	}
 
 	return ret;
@@ -2992,6 +2986,81 @@ static struct notifier_block fbcon_event
 	.notifier_call	= fbcon_event_notify,
 };
 
+static ssize_t store_rotate(struct class_device *class_device,
+			    const char *buf, size_t count)
+{
+	struct fb_info *info;
+	int rotate, idx;
+	char **last = NULL;
+
+	acquire_console_sem();
+	idx = con2fb_map[fg_console];
+
+	if (idx == -1 || registered_fb[idx] == NULL)
+		goto err;
+
+	info = registered_fb[idx];
+	rotate = simple_strtoul(buf, last, 0);
+	fbcon_rotate(info, rotate);
+err:
+	release_console_sem();
+	return count;
+}
+
+static ssize_t store_rotate_all(struct class_device *class_device,
+				const char *buf, size_t count)
+{
+	struct fb_info *info;
+	int rotate, idx;
+	char **last = NULL;
+
+	acquire_console_sem();
+	idx = con2fb_map[fg_console];
+
+	if (idx == -1 || registered_fb[idx] == NULL)
+		goto err;
+
+	info = registered_fb[idx];
+	rotate = simple_strtoul(buf, last, 0);
+	fbcon_rotate_all(info, rotate);
+err:
+	release_console_sem();
+	return count;
+}
+
+static ssize_t show_rotate(struct class_device *class_device, char *buf)
+{
+	struct fb_info *info;
+	int rotate = 0, idx;
+
+	acquire_console_sem();
+	idx = con2fb_map[fg_console];
+
+	if (idx == -1 || registered_fb[idx] == NULL)
+		goto err;
+
+	info = registered_fb[idx];
+	rotate = fbcon_get_rotate(info);
+err:
+	release_console_sem();
+	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
+}
+
+static struct class_device_attribute class_device_attrs[] = {
+	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
+	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
+};
+
+static int fbcon_init_class_device(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_create_file(fbcon_class_device,
+					 &class_device_attrs[i]);
+	return 0;
+}
+
 static int __init fb_console_init(void)
 {
 	int i;
@@ -3000,6 +3069,18 @@ static int __init fb_console_init(void)
 	fb_register_client(&fbcon_event_notifier);
 	release_console_sem();
 
+	fbcon_class_device =
+	    class_device_create(fb_class, NULL,
+				MKDEV(FB_MAJOR, FB_MAX), NULL,
+				"fbcon");
+	if (IS_ERR(fbcon_class_device)) {
+	    printk(KERN_WARNING "Unable to create class_device "
+		   "for fbcon; errno = %ld\n",
+		   PTR_ERR(fbcon_class_device));
+	    fbcon_class_device = NULL;
+	} else
+	    fbcon_init_class_device();
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		con2fb_map[i] = -1;
 
@@ -3020,10 +3101,26 @@ module_init(fb_console_init);
 
 #ifdef MODULE
 
+static void __exit fbcon_deinit_class_device(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_remove_file(fbcon_class_device,
+					 &class_device_attrs[i]);
+}
+
+static void __exit fbcon_exit(void)
+{
+	fbcon_deinit_class_device();
+	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
+}
+
 static void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
+	fbcon_exit();
 	release_console_sem();
 	give_up_console(&fb_con);
 }	
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index c38c3d8..3487a63 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -175,6 +175,7 @@ extern void fbcon_set_tileops(struct vc_
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
+extern struct class *fb_class;
 
 #define FBCON_ATTRIBUTE_UNDERLINE 1
 #define FBCON_ATTRIBUTE_REVERSE   2
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 2279d14..de6543b 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1276,8 +1276,8 @@ #ifdef HAVE_ARCH_FB_UNMAPPED_AREA
 #endif
 };
 
-static struct class *fb_class;
-
+struct class *fb_class;
+EXPORT_SYMBOL(fb_class);
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1489,27 +1489,6 @@ int fb_new_modelist(struct fb_info *info
 	return err;
 }
 
-/**
- * fb_con_duit - user<->fbcon passthrough
- * @info: struct fb_info
- * @event: notification event to be passed to fbcon
- * @data: private data
- *
- * DESCRIPTION
- * This function is an fbcon-user event passing channel
- * which bypasses fbdev.  This is hopefully temporary
- * until a user interface for fbcon is created
- */
-int fb_con_duit(struct fb_info *info, int event, void *data)
-{
-	struct fb_event evnt;
-
-	evnt.info = info;
-	evnt.data = data;
-
-	return blocking_notifier_call_chain(&fb_notifier_list, event, &evnt);
-}
-
 static char *video_options[FB_MAX];
 static int ofonly;
 
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 3ceb8c1..b20b300 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -238,45 +238,6 @@ static ssize_t show_rotate(struct class_
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.rotate);
 }
 
-static ssize_t store_con_rotate(struct class_device *class_device,
-				const char *buf, size_t count)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	int rotate;
-	char **last = NULL;
-
-	acquire_console_sem();
-	rotate = simple_strtoul(buf, last, 0);
-	fb_con_duit(fb_info, FB_EVENT_SET_CON_ROTATE, &rotate);
-	release_console_sem();
-	return count;
-}
-
-static ssize_t store_con_rotate_all(struct class_device *class_device,
-				const char *buf, size_t count)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	int rotate;
-	char **last = NULL;
-
-	acquire_console_sem();
-	rotate = simple_strtoul(buf, last, 0);
-	fb_con_duit(fb_info, FB_EVENT_SET_CON_ROTATE_ALL, &rotate);
-	release_console_sem();
-	return count;
-}
-
-static ssize_t show_con_rotate(struct class_device *class_device, char *buf)
-{
-	struct fb_info *fb_info = class_get_devdata(class_device);
-	int rotate;
-
-	acquire_console_sem();
-	rotate = fb_con_duit(fb_info, FB_EVENT_GET_CON_ROTATE, NULL);
-	release_console_sem();
-	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
-}
-
 static ssize_t store_virtual(struct class_device *class_device,
 			     const char * buf, size_t count)
 {
@@ -493,8 +454,6 @@ static struct class_device_attribute cla
 	__ATTR(name, S_IRUGO, show_name, NULL),
 	__ATTR(stride, S_IRUGO, show_stride, NULL),
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
-	__ATTR(con_rotate, S_IRUGO|S_IWUSR, show_con_rotate, store_con_rotate),
-	__ATTR(con_rotate_all, S_IWUSR, NULL, store_con_rotate_all),
 	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
 #ifdef CONFIG_FB_BACKLIGHT
 	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f128168..c64f252 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -515,12 +515,6 @@ #define FB_EVENT_NEW_MODELIST           
 /*	The resolution of the passed in fb_info about to change and
         all vc's should be changed         */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0A
-/*      CONSOLE-SPECIFIC: set console rotation */
-#define FB_EVENT_SET_CON_ROTATE         0x0B
-/*      CONSOLE-SPECIFIC: get console rotation */
-#define FB_EVENT_GET_CON_ROTATE         0x0C
-/*      CONSOLE-SPECIFIC: rotate all consoles */
-#define FB_EVENT_SET_CON_ROTATE_ALL     0x0D
 
 struct fb_event {
 	struct fb_info *info;
@@ -892,7 +886,6 @@ extern int fb_get_color_depth(struct fb_
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
-extern int fb_con_duit(struct fb_info *info, int event, void *data);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;




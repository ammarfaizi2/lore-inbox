Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270024AbUIDDOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270024AbUIDDOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270028AbUIDDNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:13:21 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:994 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S270024AbUIDDMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:12:12 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/5] fbcon: take over console on driver registration
Date: Sat, 4 Sep 2004 11:07:13 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041107.13611.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. This fixes another regression from 2.4.  If fbcon is compiled statically,
and the framebuffer driver is compiled as a module, doing a 'modprobe xxxfb'
does nothing to the console. This has generated numerous bug reports from
users.

With this patch, fbmem will notify fbcon upon driver registration allowing
fbcon to take over the console.

2. This also fixes con2fbmap not working if fbcon is compiled as a module
using the same mechanism as described above.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   89 +++++++++++++++++++++++++++---------------
 drivers/video/console/fbcon.h |    4 -
 drivers/video/fbmem.c         |   28 ++++++++-----
 include/linux/fb.h            |    7 +++
 4 files changed, 82 insertions(+), 46 deletions(-)

diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/console/fbcon.c linux-2.6.9-rc1-mm3/drivers/video/console/fbcon.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/console/fbcon.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/console/fbcon.c	2004-09-04 08:34:25.410053096 +0800
@@ -314,6 +314,28 @@ static int search_for_mapped_con(void)
 	return 0;
 }
 
+static int fbcon_takeover(void)
+{
+	int err, i;
+
+	if (!num_registered_fb)
+		return -ENODEV;
+
+	for (i = first_fb_vc; i <= last_fb_vc; i++)
+		con2fb_map[i] = info_idx;
+
+	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
+				fbcon_is_default);
+	if (err) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
+			con2fb_map[i] = -1;
+		}
+		info_idx = -1;
+	}
+
+	return err;
+}
+
 /**
  *	set_con2fb_map - map console to frame buffer device
  *	@unit: virtual console number to map
@@ -322,7 +344,7 @@ static int search_for_mapped_con(void)
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-int set_con2fb_map(int unit, int newidx)
+static int set_con2fb_map(int unit, int newidx)
 {
 	struct vc_data *vc = vc_cons[unit].d;
 	int oldidx = con2fb_map[unit];
@@ -338,8 +360,7 @@ int set_con2fb_map(int unit, int newidx)
 
 	if (!search_for_mapped_con()) {
 		info_idx = newidx;
-		fb_console_init();
-		return 0;
+		return fbcon_takeover();
 	}
 
 	if (oldidx != -1)
@@ -2730,12 +2751,25 @@ static int fbcon_mode_deleted(struct fb_
 	return found;
 }
 
+static int fbcon_fb_registered(int idx)
+{
+	int ret = 0;
+
+	if (info_idx == -1) {
+		info_idx = idx;
+		ret = fbcon_takeover();
+	}
+
+	return ret;
+}
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
 	struct fb_event *event = (struct fb_event *) data;
 	struct fb_info *info = event->info;
 	struct fb_videomode *mode;
+	struct fb_con2fbmap *con2fb;
 	int ret = 0;
 
 	switch(action) {
@@ -2752,6 +2786,17 @@ static int fbcon_event_notify(struct not
 		mode = (struct fb_videomode *) event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
+	case FB_EVENT_FB_REGISTERED:
+		ret = fbcon_fb_registered(info->node);
+		break;
+	case FB_EVENT_SET_CONSOLE_MAP:
+		con2fb = (struct fb_con2fbmap *) event->data;
+		ret = set_con2fb_map(con2fb->console - 1, con2fb->framebuffer);
+		break;
+	case FB_EVENT_GET_CONSOLE_MAP:
+		con2fb = (struct fb_con2fbmap *) event->data;
+		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
+		break;
 	}
 
 	return ret;
@@ -2790,43 +2835,28 @@ const struct consw fb_con = {
 static struct notifier_block fbcon_event_notifier = {
 	.notifier_call	= fbcon_event_notify,
 };
-static int fbcon_event_notifier_registered;
 
-/* can't be __init as it can be called by set_con2fb_map() later */
-int fb_console_init(void)
+int __init fb_console_init(void)
 {
-	int err, i;
+	int i;
+
+	acquire_console_sem();
+	fb_register_client(&fbcon_event_notifier);
+	release_console_sem();
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		con2fb_map[i] = -1;
 
-	if (!num_registered_fb)
-		return -ENODEV;
-
-	if (info_idx == -1) {
+	if (num_registered_fb) {
 		for (i = 0; i < FB_MAX; i++) {
 			if (registered_fb[i] != NULL) {
 				info_idx = i;
 				break;
 			}
 		}
+		fbcon_takeover();
 	}
-	for (i = first_fb_vc; i <= last_fb_vc; i++)
-		con2fb_map[i] = info_idx;
-	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
-				fbcon_is_default);
-	if (err) {
-		for (i = first_fb_vc; i <= last_fb_vc; i++) {
-			con2fb_map[i] = -1;
-		}
-		return err;
-	}
-	acquire_console_sem();
-	if (!fbcon_event_notifier_registered) {
-		fb_register_client(&fbcon_event_notifier);
-		fbcon_event_notifier_registered = 1;
-	} 
-	release_console_sem();
+
 	return 0;
 }
 
@@ -2835,10 +2865,7 @@ int fb_console_init(void)
 void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
-	if (fbcon_event_notifier_registered) {
-		fb_unregister_client(&fbcon_event_notifier);
-		fbcon_event_notifier_registered = 0;
-	}
+	fb_unregister_client(&fbcon_event_notifier);
 	release_console_sem();
 	give_up_console(&fb_con);
 }	
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/console/fbcon.h linux-2.6.9-rc1-mm3/drivers/video/console/fbcon.h
--- linux-2.6.9-rc1-mm3-orig/drivers/video/console/fbcon.h	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/console/fbcon.h	2004-09-04 08:34:34.014744984 +0800
@@ -48,10 +48,6 @@ struct display {
     struct fb_videomode *mode;
 };
 
-/* drivers/video/console/fbcon.c */
-extern signed char con2fb_map[MAX_NR_CONSOLES];
-extern int set_con2fb_map(int unit, int newidx);
-
     /*
      *  Attribute Decoding
      */
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm3/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/fbmem.c	2004-09-04 04:26:37.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/fbmem.c	2004-09-04 08:34:41.758567744 +0800
@@ -47,9 +47,6 @@
 
 #include <linux/fb.h>
 
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
-#include "console/fbcon.h"
-#endif
     /*
      *  Frame buffer device initialization and setup routines
      */
@@ -1236,10 +1233,9 @@ fb_ioctl(struct inode *inode, struct fil
 	struct fb_ops *fb = info->fbops;
 	struct fb_var_screeninfo var;
 	struct fb_fix_screeninfo fix;
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	struct fb_con2fbmap con2fb;
-#endif
 	struct fb_cmap_user cmap;
+	struct fb_event event;
 	void __user *argp = (void __user *)arg;
 	int i;
 	
@@ -1288,13 +1284,16 @@ fb_ioctl(struct inode *inode, struct fil
 		i = fb_cursor(info, argp);
 		release_console_sem();
 		return i;
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	case FBIOGET_CON2FBMAP:
 		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
 			return -EFAULT;
 		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
 		    return -EINVAL;
-		con2fb.framebuffer = con2fb_map[con2fb.console-1];
+		con2fb.framebuffer = -1;
+		event.info = info;
+		event.data = &con2fb;
+		notifier_call_chain(&fb_notifier_list,
+				    FB_EVENT_GET_CONSOLE_MAP, &event);
 		return copy_to_user(argp, &con2fb,
 				    sizeof(con2fb)) ? -EFAULT : 0;
 	case FBIOPUT_CON2FBMAP:
@@ -1310,11 +1309,14 @@ fb_ioctl(struct inode *inode, struct fil
 #endif /* CONFIG_KMOD */
 		if (!registered_fb[con2fb.framebuffer])
 		    return -EINVAL;
-		if (con2fb.console > 0 && con2fb.console < MAX_NR_CONSOLES)
-			return set_con2fb_map(con2fb.console-1,
-					      con2fb.framebuffer);
+		if (con2fb.console > 0 && con2fb.console < MAX_NR_CONSOLES) {
+			event.info = info;
+			event.data = &con2fb;
+			return notifier_call_chain(&fb_notifier_list,
+						   FB_EVENT_SET_CONSOLE_MAP,
+						   &event);
+		}
 		return -EINVAL;
-#endif	/* CONFIG_FRAMEBUFFER_CONSOLE */
 	case FBIOBLANK:
 		acquire_console_sem();
 		i = fb_blank(info, arg);
@@ -1493,6 +1495,7 @@ register_framebuffer(struct fb_info *fb_
 {
 	int i;
 	struct class_device *c;
+	struct fb_event event;
 
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
@@ -1546,6 +1549,9 @@ register_framebuffer(struct fb_info *fb_
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
+	event.info = fb_info;
+	notifier_call_chain(&fb_notifier_list,
+			    FB_EVENT_FB_REGISTERED, &event);
 	return 0;
 }
 
diff -uprN linux-2.6.9-rc1-mm3-orig/include/linux/fb.h linux-2.6.9-rc1-mm3/include/linux/fb.h
--- linux-2.6.9-rc1-mm3-orig/include/linux/fb.h	2004-09-04 08:36:01.161496664 +0800
+++ linux-2.6.9-rc1-mm3/include/linux/fb.h	2004-09-04 08:35:17.433144384 +0800
@@ -452,6 +452,13 @@ struct fb_cursor_user {
 #define FB_EVENT_RESUME			0x03
 /*      An entry from the modelist was removed */
 #define FB_EVENT_MODE_DELETE            0x04
+/*      A driver registered itself */
+#define FB_EVENT_FB_REGISTERED          0x05
+/*      get console to framebuffer mapping */
+#define FB_EVENT_GET_CONSOLE_MAP        0x06
+/*      set console to framebuffer mapping */
+#define FB_EVENT_SET_CONSOLE_MAP        0x07
+
 
 struct fb_event {
 	struct fb_info *info;



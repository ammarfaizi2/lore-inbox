Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWGKMp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWGKMp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGKMp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:45:56 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:53726 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751255AbWGKMpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:45:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rSohT+QZUxWO7jCNlEteu7+k2JPOMmVVzixnGymb58uoeigVBiplqUtALobUGNPX1umVj0kGhQ5phcunxmi2iPEmTPog3BLUv4JZHQb404mVVtFopV8F+rIaoDCLNBn0/KQY7bvCORBqyCYWDzOeOCvV72XKxFwwA1pmG42IQyg=
Message-ID: <44B39D4D.8060209@gmail.com>
Date: Tue, 11 Jul 2006 20:45:01 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rdunlap@xenotime.net, mreuther@umich.edu, linux-kernel@vger.kernel.org,
       zap@homelink.ru
Subject: [PATCH] fbdev: Statically link the framebuffer notification functions
References: <200607100833.00461.mreuther@umich.edu>	<20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>	<44B27931.30609@gmail.com>	<200607102327.38426.mreuther@umich.edu>	<20060710215253.1fcaab57.rdunlap@xenotime.net>	<44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>
In-Reply-To: <20060711032817.94c78ae0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The backlight and lcd subsystems can be notified by the framebuffer layer
of blanking events.  However, these subsystems, as a whole, can function
independently from the framebuffer layer. But in order to enable to
the lcd and backlight subsystems, the framebuffer has to be compiled also,
effectively sucking in a huge amount of unneeded code. Besides, the dependency
is introducing a lot of compilation problems.

To prevent these, separate out the framebuffer notification mechanism from the
framebuffer layer and permanently link it to the kernel.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Andrew Morton wrote:
> Because someone might build a CONFIG_FB=n, CONFIG_FB_MODULE=n kernel, then
> later build the fbdev module for that kernel only to find that the
> backlight driver doesn't know that the fbdev module is available.
> 
> Or something like that.  It's pretty contrived, and I really doubt that
> anyone's going to try to cobble together a kernel like that.
> 
> Or maybe there's a better reason...
> 

Andrew,

Here's the patch as promised. The changelog should say it all. Statically 
linking the notification mechanism is not that expensive as the code is very
small. Also, future subsystems that requires fb notification need not play
dependency games.

I prefer this over the previous patch. If you do apply this, you have to
revert backlight-lcd-remove-dependency-from-the-framebuffer-layer.patch.
This patch leaves the code in the backlight directory untouched.

Tony

 drivers/video/Makefile          |    1 +
 drivers/video/backlight/Kconfig |    4 +--
 drivers/video/fb_notify.c       |   46 +++++++++++++++++++++++++++++++++
 drivers/video/fbmem.c           |   54 ++++++++-------------------------------
 include/linux/fb.h              |    2 +
 5 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6283d01..be7f1c9 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -4,6 +4,7 @@ # Rewritten to use lists instead of if-s
 
 # Each configuration option enables a list of files.
 
+obj-y                             += fb_notify.o
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
                                      modedb.o fbcvt.o
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 022f9d3..02f1529 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -10,7 +10,7 @@ menuconfig BACKLIGHT_LCD_SUPPORT
 
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	depends on BACKLIGHT_LCD_SUPPORT && FB
+	depends on BACKLIGHT_LCD_SUPPORT
 	default m
 	help
 	  This framework adds support for low-level control of the LCD
@@ -26,7 +26,7 @@ config BACKLIGHT_DEVICE
 
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	depends on BACKLIGHT_LCD_SUPPORT && FB
+	depends on BACKLIGHT_LCD_SUPPORT
 	default m
 	help
 	  This framework adds support for low-level control of LCD.
diff --git a/drivers/video/fb_notify.c b/drivers/video/fb_notify.c
new file mode 100644
index 0000000..8c02038
--- /dev/null
+++ b/drivers/video/fb_notify.c
@@ -0,0 +1,46 @@
+/*
+ *  linux/drivers/video/fb_notify.c
+ *
+ *  Copyright (C) 2006 Antonino Daplas <adaplas@pol.net>
+ *
+ *	2001 - Documented with DocBook
+ *	- Brad Douglas <brad@neruo.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+#include <linux/fb.h>
+#include <linux/notifier.h>
+
+static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
+
+/**
+ *	fb_register_client - register a client notifier
+ *	@nb: notifier block to callback on events
+ */
+int fb_register_client(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&fb_notifier_list, nb);
+}
+EXPORT_SYMBOL(fb_register_client);
+
+/**
+ *	fb_unregister_client - unregister a client notifier
+ *	@nb: notifier block to callback on events
+ */
+int fb_unregister_client(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&fb_notifier_list, nb);
+}
+EXPORT_SYMBOL(fb_unregister_client);
+
+/**
+ * fb_notifier_call_chain - notify clients of fb_events
+ *
+ */
+int fb_notifier_call_chain(unsigned long val, void *v)
+{
+	return blocking_notifier_call_chain(&fb_notifier_list, val, v);
+}
+EXPORT_SYMBOL_GPL(fb_notifier_call_chain);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 4fc9df4..17961e3 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -52,7 +52,6 @@ #include <linux/fb.h>
 
 #define FBPIXMAPSIZE	(1024 * 8)
 
-static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
@@ -791,8 +790,7 @@ fb_set_var(struct fb_info *info, struct 
 
 		    event.info = info;
 		    event.data = &mode1;
-		    ret = blocking_notifier_call_chain(&fb_notifier_list,
-					      FB_EVENT_MODE_DELETE, &event);
+		    ret = fb_notifier_call_chain(FB_EVENT_MODE_DELETE, &event);
 		}
 
 		if (!ret)
@@ -837,8 +835,7 @@ fb_set_var(struct fb_info *info, struct 
 
 				info->flags &= ~FBINFO_MISC_USEREVENT;
 				event.info = info;
-				blocking_notifier_call_chain(&fb_notifier_list,
-						evnt, &event);
+				fb_notifier_call_chain(evnt, &event);
 			}
 		}
 	}
@@ -861,8 +858,7 @@ fb_blank(struct fb_info *info, int blank
 
 		event.info = info;
 		event.data = &blank;
-		blocking_notifier_call_chain(&fb_notifier_list,
-				FB_EVENT_BLANK, &event);
+		fb_notifier_call_chain(FB_EVENT_BLANK, &event);
 	}
 
  	return ret;
@@ -933,8 +929,7 @@ fb_ioctl(struct inode *inode, struct fil
 		con2fb.framebuffer = -1;
 		event.info = info;
 		event.data = &con2fb;
-		blocking_notifier_call_chain(&fb_notifier_list,
-				    FB_EVENT_GET_CONSOLE_MAP, &event);
+		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
 		return copy_to_user(argp, &con2fb,
 				    sizeof(con2fb)) ? -EFAULT : 0;
 	case FBIOPUT_CON2FBMAP:
@@ -952,9 +947,8 @@ #endif /* CONFIG_KMOD */
 		    return -EINVAL;
 		event.info = info;
 		event.data = &con2fb;
-		return blocking_notifier_call_chain(&fb_notifier_list,
-					   FB_EVENT_SET_CONSOLE_MAP,
-					   &event);
+		return fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP,
+					      &event);
 	case FBIOBLANK:
 		acquire_console_sem();
 		info->flags |= FBINFO_MISC_USEREVENT;
@@ -1330,8 +1324,7 @@ register_framebuffer(struct fb_info *fb_
 	registered_fb[i] = fb_info;
 
 	event.info = fb_info;
-	blocking_notifier_call_chain(&fb_notifier_list,
-			    FB_EVENT_FB_REGISTERED, &event);
+	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
 	return 0;
 }
 
@@ -1365,30 +1358,11 @@ unregister_framebuffer(struct fb_info *f
 	fb_cleanup_class_device(fb_info);
 	class_device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
-	blocking_notifier_call_chain(&fb_notifier_list,
-				     FB_EVENT_FB_UNREGISTERED, &event);
+	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
 	return 0;
 }
 
 /**
- *	fb_register_client - register a client notifier
- *	@nb: notifier block to callback on events
- */
-int fb_register_client(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&fb_notifier_list, nb);
-}
-
-/**
- *	fb_unregister_client - unregister a client notifier
- *	@nb: notifier block to callback on events
- */
-int fb_unregister_client(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&fb_notifier_list, nb);
-}
-
-/**
  *	fb_set_suspend - low level driver signals suspend
  *	@info: framebuffer affected
  *	@state: 0 = resuming, !=0 = suspending
@@ -1403,13 +1377,11 @@ void fb_set_suspend(struct fb_info *info
 
 	event.info = info;
 	if (state) {
-		blocking_notifier_call_chain(&fb_notifier_list,
-				FB_EVENT_SUSPEND, &event);
+		fb_notifier_call_chain(FB_EVENT_SUSPEND, &event);
 		info->state = FBINFO_STATE_SUSPENDED;
 	} else {
 		info->state = FBINFO_STATE_RUNNING;
-		blocking_notifier_call_chain(&fb_notifier_list,
-				FB_EVENT_RESUME, &event);
+		fb_notifier_call_chain(FB_EVENT_RESUME, &event);
 	}
 }
 
@@ -1480,9 +1452,7 @@ int fb_new_modelist(struct fb_info *info
 
 	if (!list_empty(&info->modelist)) {
 		event.info = info;
-		err = blocking_notifier_call_chain(&fb_notifier_list,
-					   FB_EVENT_NEW_MODELIST,
-					   &event);
+		err = fb_notifier_call_chain(FB_EVENT_NEW_MODELIST, &event);
 	}
 
 	return err;
@@ -1594,8 +1564,6 @@ EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
 EXPORT_SYMBOL(fb_get_buffer_offset);
 EXPORT_SYMBOL(fb_set_suspend);
-EXPORT_SYMBOL(fb_register_client);
-EXPORT_SYMBOL(fb_unregister_client);
 EXPORT_SYMBOL(fb_get_options);
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 405f44e..4ad0673 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -524,7 +524,7 @@ struct fb_event {
 
 extern int fb_register_client(struct notifier_block *nb);
 extern int fb_unregister_client(struct notifier_block *nb);
-
+extern int fb_notifier_call_chain(unsigned long val, void *v);
 /*
  * Pixmap structure definition
  *

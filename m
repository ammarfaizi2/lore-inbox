Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUBKW0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUBKW0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:26:55 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:56585 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266217AbUBKW0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:26:47 -0500
Date: Wed, 11 Feb 2004 22:26:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: fbdev driver and sysfs question.
Message-ID: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I attempted to port over the vesafb driver to show up in the sysfs tree.
Unfortunely it just hanges my box. From the code can someone tell me what 
I'm doing wrong?


--- linus-2.6/drivers/video/vesafb.c	2004-01-27 19:48:12.000000000 -0800
+++ fbdev-2.6/drivers/video/vesafb.c	2004-02-10 19:43:38.000000000 -0800
@@ -19,6 +19,7 @@
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/device.h>
 #ifdef __i386__
 #include <video/edid.h>
 #endif
@@ -47,7 +48,6 @@
 	.accel	= FB_ACCEL_NONE,
 };
 
-static struct fb_info fb_info;
 static u32 pseudo_palette[17];
 
 static int             inverse   = 0;
@@ -214,8 +214,10 @@
 	return 0;
 }
 
-int __init vesafb_init(void)
+static int __init vesafb_probe(struct device *_dev)
 {
+	struct platform_device *dev = to_platform_device(_dev);
+	struct fb_info *info;
 	int video_cmap_len;
 	int i;
 
@@ -251,8 +253,13 @@
 		   spaces our resource handlers simply don't know about */
 	}
 
-        fb_info.screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
-	if (!fb_info.screen_base) {
+	info = framebuffer_alloc(0, &dev->dev); 
+	if (!info)
+		return -ENOMEM;
+	dev_set_drvdata(&dev->dev, info);
+	
+        info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	if (!info->screen_base) {
 		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
 		printk(KERN_ERR
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
@@ -261,7 +268,7 @@
 	}
 
 	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, size %dk\n",
-	       vesafb_fix.smem_start, fb_info.screen_base, vesafb_fix.smem_len/1024);
+	       vesafb_fix.smem_start, info->screen_base, vesafb_fix.smem_len/1024);
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel, vesafb_fix.line_length, screen_info.pages);
 
@@ -358,22 +365,45 @@
 		}
 	}
 	
-	fb_info.fbops = &vesafb_ops;
-	fb_info.var = vesafb_defined;
-	fb_info.fix = vesafb_fix;
-	fb_info.pseudo_palette = pseudo_palette;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &vesafb_ops;
+	info->var = vesafb_defined;
+	info->fix = vesafb_fix;
+	info->pseudo_palette = pseudo_palette;
+	info->flags = FBINFO_FLAG_DEFAULT;
 
-	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
+	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(&fb_info)<0)
+	if (register_framebuffer(info) < 0)
 		return -EINVAL;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	       fb_info.node, fb_info.fix.id);
+	       info->node, info->fix.id);
 	return 0;
 }
 
+static struct device_driver vesafb_driver = {
+	.name	= "VESA framebuffer",
+	.probe	= vesafb_probe,
+};
+
+static struct platform_device vesafb_device = {
+	.name	= "VESA framebuffer",
+	.id	= 0,
+};
+	
+int __init vesafb_init(void)
+{
+	int ret;
+
+	ret = driver_register(&vesafb_driver);
+	if (!ret) {
+		ret = platform_device_register(&vesafb_device);
+		if (ret)
+			driver_unregister(&vesafb_driver);
+	}
+	return ret;
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * ---------------------------------------------------------------------------


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUCKUXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUCKUWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:22:04 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:12865 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261657AbUCKUVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:21:42 -0500
Date: Thu, 11 Mar 2004 21:21:39 +0100
Message-Id: <200403112021.i2BKLdIg000837@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 420] Apollo fb sysfsification
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apollo fb: Add sysfs support (from James Simmons)

--- linux-2.6.4/drivers/video/dnfb.c	2003-05-05 10:32:14.000000000 +0200
+++ linux-m68k-2.6.4/drivers/video/dnfb.c	2004-02-26 10:47:42.000000000 +0100
@@ -103,8 +103,6 @@
 
 #define SWAP(A) ((A>>8) | ((A&0xff) <<8))
 
-static struct fb_info fb_info;
-
 /* frame buffer operations */
 
 static int dnfb_blank(int blank, struct fb_info *info);
@@ -119,7 +117,7 @@
 	.fb_cursor	= soft_cursor,
 };
 
-struct fb_var_screeninfo dnfb_var __initdata = {
+struct fb_var_screeninfo dnfb_var __devinitdata = {
 	.xres		1280,
 	.yres		1024,
 	.xres_virtual	2048,
@@ -130,7 +128,7 @@
 	.vmode		FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo dnfb_fix __initdata = {
+static struct fb_fix_screeninfo dnfb_fix __devinitdata = {
 	.id		"Apollo Mono",
 	.smem_start	(FRAME_BUFFER_START + IO_BASE),
 	.smem_len	FRAME_BUFFER_LEN,
@@ -148,7 +146,7 @@
 	return 0;
 }
 
-static 
+static
 void dnfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 
@@ -224,21 +222,38 @@
 	out_8(AP_CONTROL_0, NORMAL_MODE);
 }
 
+/*
+ * Initialization
+ */
 
-unsigned long __init dnfb_init(unsigned long mem_start)
+static int __devinit dnfb_probe(struct device *device)
 {
-	int err;
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	int err = 0;
+
+	info = framebuffer_alloc(0, &dev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	info->fbops = &dn_fb_ops;
+	info->fix = dnfb_fix;
+	info->var = dnfb_var;
+	info->screen_base = (u_char *) info->fix.smem_start;
+
+	err = fb_alloc_cmap(&info->cmap, 2, 0);
+	if (err < 0) {
+		framebuffer_release(info);
+		return err;
+	}
 
-	fb_info.fbops = &dn_fb_ops;
-	fb_info.fix = dnfb_fix;
-	fb_info.var = dnfb_var;
-	fb_info.screen_base = (u_char *) fb_info.fix.smem_start;
-
-	fb_alloc_cmap(&fb_info.cmap, 2, 0);
-
-	err = register_framebuffer(&fb_info);
-	if (err < 0)
-		panic("unable to register apollo frame buffer\n");
+	err = register_framebuffer(info);
+	if (err < 0) {
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		return err;
+	}
+	dev_set_drvdata(&dev->dev, info);
 
 	/* now we have registered we can safely setup the hardware */
 	out_8(AP_CONTROL_3A, RESET_CREG);
@@ -249,7 +264,31 @@
 	out_be16(AP_ROP_1, SWAP(0x3));
 
 	printk("apollo frame buffer alive and kicking !\n");
-	return mem_start;
+	return err;
+}
+
+static struct device_driver dnfb_driver = {
+	.name	= "dnfb",
+	.bus	= &platform_bus_type,
+	.probe	= dnfb_probe,
+};
+
+static struct platform_device dnfb_device = {
+	.name	= "dnfb",
+};
+
+int __init dnfb_init(void)
+{
+	int ret;
+
+	ret = driver_register(&dnfb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&dnfb_device);
+		if (ret)
+			driver_unregister(&dnfb_driver);
+	}
+	return ret;
 }
 
 MODULE_LICENSE("GPL");

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

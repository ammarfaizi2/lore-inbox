Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbUBXRIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUBXRIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:08:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:53512 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262296AbUBXRID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:08:03 -0500
Date: Tue, 24 Feb 2004 17:08:00 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Apollo framebuffer sysfs 
In-Reply-To: <Pine.GSO.4.58.0402240931140.3187@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0402241707330.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay. Applied. Try this patch. If you are happy with it send it to linus.

--- linus-2.6/drivers/video/dnfb.c	2004-02-18 20:59:07.000000000 -0800
+++ fbdev-2.6/drivers/video/dnfb.c	2004-02-23 15:58:26.000000000 -0800
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


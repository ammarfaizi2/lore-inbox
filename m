Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUBWTyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbUBWTyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:54:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:36828 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262023AbUBWTyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:54:38 -0500
Date: Mon, 23 Feb 2004 20:54:29 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FrameMasterII fbdev updates.
In-Reply-To: <Pine.LNX.4.44.0402181823110.10389-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.58.0402201402010.23753@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402181823110.10389-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, James Simmons wrote:
>   Can you test this patch. It is a port of the driver to use sysfs.

  - Fix compilation (typos and warnings)
  - Use __devinit* where appropriate
  - Remove superfluous whitespace (hurts my eyes with let c_space_errors=1)

--- drivers/video/fm2fb.c.orig	2004-02-19 18:55:34.000000000 +0100
+++ drivers/video/fm2fb.c	2004-02-23 20:48:50.000000000 +0100
@@ -49,7 +49,7 @@
  *	not assembled with memory for the alpha channel. In this
  *	case it could be possible to add the frame buffer into the
  *	normal memory pool.
- *
+ *
  *	At relative address 0x1ffff8 of the frame buffers base address
  *	there exists a control register with the number of
  *	four control bits. They have the following meaning:
@@ -64,7 +64,7 @@
  *	is not very much information about the FrameMaster II in
  *	the world so I add these information for completeness.
  *
- *	JP1  interlace selection (1-2 non interlaced/2-3 interlaced)
+ *	JP1  interlace selection (1-2 non interlaced/2-3 interlaced)
  *	JP2  wait state creation (leave as is!)
  *	JP3  wait state creation (leave as is!)
  *	JP4  modulate composite sync on green output (1-2 composite
@@ -127,7 +127,7 @@

 static volatile unsigned char *fm2fb_reg;

-static struct fb_fix_screeninfo fb_fix __initdata = {
+static struct fb_fix_screeninfo fb_fix __devinitdata = {
 	.smem_len =	FRAMEMASTER_REG,
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
@@ -136,12 +136,12 @@
 	.accel =	FB_ACCEL_NONE,
 };

-static int fm2fb_mode __initdata = -1;
+static int fm2fb_mode __devinitdata = -1;

 #define FM2FB_MODE_PAL	0
 #define FM2FB_MODE_NTSC	1

-static struct fb_var_screeninfo fb_var_modes[] __initdata = {
+static struct fb_var_screeninfo fb_var_modes[] __devinitdata = {
     {
 	/* 768 x 576, 32 bpp (PAL) */
 	768, 576, 768, 576, 0, 0, 32, 0,
@@ -156,11 +156,10 @@
 	33333, 10, 102, 10, 5, 80, 34, FB_SYNC_COMP_HIGH_ACT, 0
     }
 };
-
+
     /*
      *  Interface used by the world
      */
-int fm2fb_init(void);

 static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                            u_int transp, struct fb_info *info);
@@ -169,7 +168,7 @@
 static struct fb_ops fm2fb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_setcolreg	= fm2fb_setcolreg,
-	.fb_blank	= fm2fb_blank,
+	.fb_blank	= fm2fb_blank,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
@@ -211,52 +210,52 @@
      *  Initialisation
      */

-static struct zorro_device_id fm2fb_devices[] = {
-	{ ZORRO_PROD_BSC_FRAMEMASTER_II, NULL },
-	{ ZORRO_PROD_HELFRICH_RAINBOW_II, NULL },
-	{ 0, 0 }
-};
+static int __devinit fm2fb_probe(struct zorro_dev *z,
+				 const struct zorro_device_id *id);
+
+static struct zorro_device_id fm2fb_devices[] __devinitdata = {
+	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
+	{ ZORRO_PROD_HELFRICH_RAINBOW_II },
+	{ 0 }
+};

 static struct zorro_driver fm2fb_driver = {
 	.name		= "fm2fb",
 	.id_table	= fm2fb_devices,
 	.probe		= fm2fb_probe,
-};
+};

-static int __devint fm2fb_probe(struct zorro_dev *dev,
-				const struct zorro_device_id *id)
+static int __devinit fm2fb_probe(struct zorro_dev *z,
+				 const struct zorro_device_id *id)
 {
 	struct fb_info *info;
 	unsigned long *ptr;
 	int is_fm;
 	int x, y;

-	if (id->id == ZORRO_PROD_BSC_FRAMEMASTER_II)
-		is_fm = 1;
-	else if (id->id == ZORRO_PROD_HELFRICH_RAINBOW_II)
-		is_fm = 0;
-
+	is_fm = z->id == ZORRO_PROD_BSC_FRAMEMASTER_II;
+
 	if (!zorro_request_device(z,"fm2fb"))
 		return -ENXIO;

-	info = framebuffer_alloc(256 * sizeof(u32), &dev->dev);
+	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
 	if (!info) {
-		zorro_release_dev(z);
+		zorro_release_device(z);
 		return -ENOMEM;
 	}
-
+
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		framebuffer_release(info);
-		zorro_release_dev(z);
+		zorro_release_device(z);
 		return -ENOMEM;
-	}
-
+	}
+
 	/* assigning memory to kernel space */
 	fb_fix.smem_start = zorro_resource_start(z);
 	info->screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
 	fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
 	fm2fb_reg  = (unsigned char *)(info->screen_base+FRAMEMASTER_REG);
-
+
 	strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");

 	/* make EBU color bars on display */
@@ -286,14 +285,14 @@
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
-		zorro_release_dev(z);
+		zorro_release_device(z);
 		return -EINVAL;
 	}
 	printk("fb%d: %s frame buffer device\n", info->node, fb_fix.id);
 	return 0;
 }

-static int __init fm2fb_init(void)
+int __init fm2fb_init(void)
 {
 	return zorro_register_driver(&fm2fb_driver);
 }
@@ -305,7 +304,7 @@
 	if (!options || !*options)
 		return 0;

-	while ((this_opt = strsep(&options, ",")) != NULL) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "pal", 3))
 			fm2fb_mode = FM2FB_MODE_PAL;
 		else if (!strncmp(this_opt, "ntsc", 4))

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

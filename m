Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUBXRKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUBXRJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:09:27 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:50952 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262305AbUBXRH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:07:28 -0500
Date: Tue, 24 Feb 2004 17:07:26 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FrameMasterII fbdev updates.
In-Reply-To: <Pine.GSO.4.58.0402240930080.3187@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0402241706440.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay. Applied. Try this. Its against the standard tree. Send it to linus 
if you are happy with it.


--- linus-2.6/drivers/video/fm2fb.c	2004-02-18 20:59:07.000000000 -0800
+++ fbdev-2.6/drivers/video/fm2fb.c	2004-02-23 15:56:38.000000000 -0800
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
@@ -127,12 +127,7 @@
 
 static volatile unsigned char *fm2fb_reg;
 
-#define arraysize(x)	(sizeof(x)/sizeof(*(x)))
-
-static struct fb_info fb_info;
-static u32 pseudo_palette[17];
-
-static struct fb_fix_screeninfo fb_fix __initdata = {
+static struct fb_fix_screeninfo fb_fix __devinitdata = {
 	.smem_len =	FRAMEMASTER_REG,
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
@@ -141,12 +136,12 @@
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
@@ -161,11 +156,10 @@
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
@@ -174,7 +168,7 @@
 static struct fb_ops fm2fb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_setcolreg	= fm2fb_setcolreg,
-	.fb_blank	= fm2fb_blank,	
+	.fb_blank	= fm2fb_blank,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
@@ -202,7 +196,7 @@
 static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                          u_int transp, struct fb_info *info)
 {
-	if (regno > 15)
+	if (regno > 255)
 		return 1;
 	red >>= 8;
 	green >>= 8;
@@ -216,66 +210,91 @@
      *  Initialisation
      */
 
-int __init fm2fb_init(void)
+static int __devinit fm2fb_probe(struct zorro_dev *z,
+				const struct zorro_device_id *id);
+
+static struct zorro_device_id fm2fb_devices[] __devinitdata = {
+	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
+	{ ZORRO_PROD_HELFRICH_RAINBOW_II },
+	{ 0 }
+};
+
+static struct zorro_driver fm2fb_driver = {
+	.name		= "fm2fb",
+	.id_table	= fm2fb_devices,
+	.probe		= fm2fb_probe,
+};
+
+static int __devinit fm2fb_probe(struct zorro_dev *z,
+				const struct zorro_device_id *id)
 {
-	struct zorro_dev *z = NULL;
+	struct fb_info *info;
 	unsigned long *ptr;
 	int is_fm;
 	int x, y;
 
-	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-		if (z->id == ZORRO_PROD_BSC_FRAMEMASTER_II)
-			is_fm = 1;
-		else if (z->id == ZORRO_PROD_HELFRICH_RAINBOW_II)
-			is_fm = 0;
-		else
-			continue;
-		
-		if (!request_mem_region(z->resource.start, FRAMEMASTER_SIZE, "fm2fb"))
-			continue;
-
-		/* assigning memory to kernel space */
-		fb_fix.smem_start = z->resource.start;
-		fb_info.screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
-		fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
-		fm2fb_reg  = (unsigned char *)(fb_info.screen_base+FRAMEMASTER_REG);
-	
-		strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
-
-		/* make EBU color bars on display */
-		ptr = (unsigned long *)fb_fix.smem_start;
-		for (y = 0; y < 576; y++) {
-			for (x = 0; x < 96; x++) *ptr++ = 0xffffff;/* white */
-			for (x = 0; x < 96; x++) *ptr++ = 0xffff00;/* yellow */
-			for (x = 0; x < 96; x++) *ptr++ = 0x00ffff;/* cyan */
-			for (x = 0; x < 96; x++) *ptr++ = 0x00ff00;/* green */
-			for (x = 0; x < 96; x++) *ptr++ = 0xff00ff;/* magenta */
-			for (x = 0; x < 96; x++) *ptr++ = 0xff0000;/* red */
-			for (x = 0; x < 96; x++) *ptr++ = 0x0000ff;/* blue */
-			for (x = 0; x < 96; x++) *ptr++ = 0x000000;/* black */
-		}
-		fm2fb_blank(0, NULL);
+	is_fm = z->id == ZORRO_PROD_BSC_FRAMEMASTER_II;
 
-		if (fm2fb_mode == -1)
-			fm2fb_mode = FM2FB_MODE_PAL;
+	if (!zorro_request_device(z,"fm2fb"))
+		return -ENXIO;
 
-		fb_info.fbops = &fm2fb_ops;
-		fb_info.var = fb_var_modes[fm2fb_mode];
-		fb_info.screen_base = (char *)fb_fix.smem_start;
-		fb_info.pseudo_palette = pseudo_palette;
-		fb_info.fix = fb_fix;
-		fb_info.flags = FBINFO_FLAG_DEFAULT;
+	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
+	if (!info) {
+		zorro_release_device(z);
+		return -ENOMEM;
+	}
 
-		/* The below fields will go away !!!! */
-		fb_alloc_cmap(&fb_info.cmap, 16, 0);
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		framebuffer_release(info);
+		zorro_release_device(z);
+		return -ENOMEM;
+	}
 
-		if (register_framebuffer(&fb_info) < 0)
-			return -EINVAL;
+	/* assigning memory to kernel space */
+	fb_fix.smem_start = zorro_resource_start(z);
+	info->screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
+	fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
+	fm2fb_reg  = (unsigned char *)(info->screen_base+FRAMEMASTER_REG);
+
+	strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
+
+	/* make EBU color bars on display */
+	ptr = (unsigned long *)fb_fix.smem_start;
+	for (y = 0; y < 576; y++) {
+		for (x = 0; x < 96; x++) *ptr++ = 0xffffff;/* white */
+		for (x = 0; x < 96; x++) *ptr++ = 0xffff00;/* yellow */
+		for (x = 0; x < 96; x++) *ptr++ = 0x00ffff;/* cyan */
+		for (x = 0; x < 96; x++) *ptr++ = 0x00ff00;/* green */
+		for (x = 0; x < 96; x++) *ptr++ = 0xff00ff;/* magenta */
+		for (x = 0; x < 96; x++) *ptr++ = 0xff0000;/* red */
+		for (x = 0; x < 96; x++) *ptr++ = 0x0000ff;/* blue */
+		for (x = 0; x < 96; x++) *ptr++ = 0x000000;/* black */
+	}
+	fm2fb_blank(0, info);
 
-		printk("fb%d: %s frame buffer device\n", fb_info.node, fb_fix.id);
-		return 0;
+	if (fm2fb_mode == -1)
+		fm2fb_mode = FM2FB_MODE_PAL;
+
+	info->fbops = &fm2fb_ops;
+	info->var = fb_var_modes[fm2fb_mode];
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+	info->fix = fb_fix;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (register_framebuffer(info) < 0) {
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		zorro_release_device(z);
+		return -EINVAL;
 	}
-	return -ENXIO;
+	printk("fb%d: %s frame buffer device\n", info->node, fb_fix.id);
+	return 0;
+}
+
+int __init fm2fb_init(void)
+{
+	return zorro_register_driver(&fm2fb_driver);
 }
 
 int __init fm2fb_setup(char *options)
@@ -285,7 +304,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {	
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "pal", 3))
 			fm2fb_mode = FM2FB_MODE_PAL;
 		else if (!strncmp(this_opt, "ntsc", 4))


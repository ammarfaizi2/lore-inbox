Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTBFHUd>; Thu, 6 Feb 2003 02:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTBFHUd>; Thu, 6 Feb 2003 02:20:33 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:21256 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265608AbTBFHU2>; Thu, 6 Feb 2003 02:20:28 -0500
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1044428068.1170.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 15:14:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 20:37, Geert Uytterhoeven wrote:
> On Tue, 28 Jan 2003, Geert Uytterhoeven wrote:
> > On Sun, 12 Jan 2003, Geert Uytterhoeven wrote:
> > > The current logo code is messy, complex, and inflexible. So I decided to
> > > rewrite it. My goals were:
> > >   - Logos must be accessible easily by an image editor (currently: hex C source
> > >     data must be converted to another format first)
> > >   - Logos must be stored in ASCII-form in the source tree
> > >   - Support arbitrary logo sizes (currently: fixed 80x80)
> > >   - Allow the logo to be selected statically (at compile time) and/or
> > >     dynamically (at run-time, based on machine type) (currently: at compile
> > >     time only).
> > >   - Allow simple adition of new logos
> > >   - Support grayscale logos (not used yet)
> > > 
> > > The patch achieves all of these. Logos are stored in ASCII PNM format in
> > > drivers/video/logo/, and automatically converted to hex C source arrays using
> > > scripts/pnmtologo. I chose ASCII PNM because (a) it's ASCII, (b) it's very
> > > simple to parse without an external library (XPM is more difficult to parse),
> > > and (c) it can be handled by many image manipulation programs.
> > > 
> > > Code that wants to display a logo just calls fb_find_logo(), specifying the
> > > wanted logo type, and receives a pointer to a suitable logo (or NULL).
> > > 
> > > I also modified fb_show_logo() to return the number of scanlines that are used
> > > by the logo, so fbcon knows how many lines to reserve.
> > 
> > I put a new version at
> > 
> >     http://home.tvd.be/cr26864/Linux/fbdev/linux-logo-2.5.59.diff.bz2
> > 
> > Changes:
> >   - Merge with 2.5.59
> >   - New logo (CLUT224 only) for PA-RISC
> >   - Let hgafb and newport_con include logo sources directly, since they need
> >     access to the logos in non-init code
> > 
> > All comments are welcomed! Thanks!
> 
> Come on, is there really no one to comment on this??
> 

Actually, I tried the patch before, but it was erased so fast that I
never got to see the logo :-)

Anyway, I think it's because logo_lines require logo_height in
fbcon_set_display().  logo_height is returned by fb_show_logo(), however
fb_show_logo() is called after computing logo_lines.

So, how about breaking up fb_show_logo() into fb_prepare_logo() and
fb_show_logo()?  We can call fb_prepare_logo() to get the logo height
for the logo_lines, then do an fb_show_logo() for the actual drawing.

Also I noticed that the type of logo depends solely on the framebuffer
depth.  This is not necessarily correct.  DirectColor at <24bpp 
requires a 4-bit logo.

Overall, I like it, though it does add some kilobytes to the kernel
image size.

Tony

BTW: Do you know of any logo images that are compatible with your patch?
I'm beginning to get tired of seeing Tux always:-)

diff -Naur linux-2.5.59-gu/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.59-gu/drivers/video/console/fbcon.c	2003-02-05 06:37:49.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-02-05 06:38:52.000000000 +0000
@@ -958,6 +958,7 @@
 		int cnt;
 		int step;
 
+		logo_height = fb_prepare_logo(info);
 		logo_lines = (logo_height + vc->vc_font.height - 1) /
 			     vc->vc_font.height;
 		q = (unsigned short *) (vc->vc_origin +
@@ -1944,8 +1945,7 @@
 		accel_clear_margins(vc, p, 0);
 	if (logo_shown == -2) {
 		logo_shown = fg_console;
-		/* This is protected above by initmem_freed */
-		logo_height = fb_show_logo(info);
+		fb_show_logo(info);	/* This is protected above by initmem_freed */
 		update_region(fg_console,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
diff -Naur linux-2.5.59-gu/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.59-gu/drivers/video/fbmem.c	2003-02-05 06:33:48.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-02-05 06:36:03.000000000 +0000
@@ -511,101 +511,119 @@
  * We isolate each bit and expand each into a byte. The "needs_logo" flag will
  * be set to 1.
  */
-int fb_show_logo(struct fb_info *info)
-{
-	unsigned char *fb = info->screen_base, *logo_new = NULL;
-	u32 *palette = NULL, *saved_pseudo_palette = NULL;
-	int needs_directpalette = 0;
-	int needs_truepalette = 0;
-	int needs_cmapreset = 0;
-	struct fb_image image;
-	const struct linux_logo *logo = 0;
+static struct logo_data {
+	int depth;
+	int needs_logo;
+	int needs_directpalette;
+	int needs_truepalette;
+	int needs_cmapreset;
 	int type;
-	int needs_logo = 0;
-	int done = 0, x;
-
-	/* Return if the frame buffer is not mapped */
-	if (!fb || !info->fbops->fb_imageblit)
-		return 0;
+	const struct linux_logo *logo;
+} fb_logo;
 
-	image.depth = info->var.bits_per_pixel;
-
-	/* reasonable default */
-	if (image.depth >= 8)
-		type = LINUX_LOGO_CLUT224;
-	else if (image.depth >= 4)
-		type = LINUX_LOGO_VGA16;
-	else
-		type = LINUX_LOGO_MONO;
-
-	/* Return if no suitable logo was found */
-	logo = fb_find_logo(type);
-	if (!logo || logo->height > info->var.yres)
-		return 0;
+int fb_prepare_logo(struct fb_info *info)
+{
+	memset(&fb_logo, 0, sizeof(struct logo_data));
 
-	image.data = logo->data;
+	fb_logo.depth = info->var.bits_per_pixel;
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
-		needs_truepalette = 1;
-		if (image.depth >= 4 && image.depth <= 8)
-			needs_logo = 4;
-		else if (image.depth < 4)
-			needs_logo = 1;
+		if (fb_logo.depth > 8) {
+			fb_logo.needs_truepalette = 1;
+			fb_logo.needs_logo = 8;
+		} else if (fb_logo.depth >= 4 && fb_logo.depth <= 8)
+			fb_logo.needs_logo = 4;
+		else 
+			fb_logo.needs_logo = 1;
 		break;
 	case FB_VISUAL_DIRECTCOLOR:
-		if (image.depth >= 24) {
-			needs_directpalette = 1;
-			needs_cmapreset = 1;
+		if (fb_logo.depth >= 24) {
+			fb_logo.needs_directpalette = 1;
+			fb_logo.needs_cmapreset = 1;
+			fb_logo.needs_logo = 8;
 		}
 		/* 16 colors */
-		else if (image.depth >= 16)
-			needs_logo = 4;
+		else if (fb_logo.depth >= 16)
+			fb_logo.needs_logo = 4;
 		/* 2 colors */
 		else
-			needs_logo = 1;
+			fb_logo.needs_logo = 1;
 		break;
 	case FB_VISUAL_MONO01:
 		/* reversed 0 = fg, 1 = bg */
-		needs_logo = ~1;
+		fb_logo.needs_logo = ~1;
 		break;
 	case FB_VISUAL_MONO10:
-		needs_logo = 1;
+		fb_logo.needs_logo = 1;
 		break;
 	case FB_VISUAL_PSEUDOCOLOR:
 	default:
-		if (image.depth >= 8)
-			needs_cmapreset = 1;
+		if (fb_logo.depth >= 8) {
+			fb_logo.needs_cmapreset = 1;
+			fb_logo.needs_logo = 8;
+		}
 		/* fall through */
 	case FB_VISUAL_STATIC_PSEUDOCOLOR:
 		/* 16 colors */
-		if (image.depth >= 4 && image.depth < 8)
-			needs_logo = 4;
+		if (fb_logo.depth >= 4 && fb_logo.depth < 8)
+			fb_logo.needs_logo = 4;
 		/* 2 colors */
-		else if (image.depth < 4)
-			needs_logo = 1;
+		else if (fb_logo.depth < 4)
+			fb_logo.needs_logo = 1;
 		break;
 	}
 
-	if (needs_cmapreset)
-		fb_set_logocmap(info, logo);
+	if (fb_logo.needs_logo >= 8)
+		fb_logo.type = LINUX_LOGO_CLUT224;
+	else if (fb_logo.needs_logo >= 4)
+		fb_logo.type = LINUX_LOGO_VGA16;
+	else
+		fb_logo.type = LINUX_LOGO_MONO;
 
-	if (needs_truepalette || needs_directpalette) {
+	/* Return if no suitable logo was found */
+	fb_logo.logo = fb_find_logo(fb_logo.type);
+	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres)
+		return 0;
+	return fb_logo.logo->height;
+}
+
+int fb_show_logo(struct fb_info *info)
+{
+	unsigned char *fb = info->screen_base, *logo_new = NULL;
+	u32 *palette = NULL, *saved_pseudo_palette = NULL;
+	struct fb_image image;
+	int done = 0, x;
+
+	/* Return if the frame buffer is not mapped */
+	if (!fb || !info->fbops->fb_imageblit ||
+	    !fb_logo.depth)
+		return 0;
+
+	image.depth = fb_logo.depth;
+	image.data = fb_logo.logo->data;
+
+	if (fb_logo.needs_cmapreset)
+		fb_set_logocmap(info, fb_logo.logo);
+
+	if (fb_logo.needs_truepalette || 
+	    fb_logo.needs_directpalette) {
 		palette = kmalloc(256 * 4, GFP_KERNEL);
 		if (palette == NULL)
 			return 0;
 
-		if (needs_truepalette)
-			fb_set_logo_truepalette(info, logo, palette);
+		if (fb_logo.needs_truepalette)
+			fb_set_logo_truepalette(info, fb_logo.logo, palette);
 		else
-			fb_set_logo_directpalette(info, logo, palette);
+			fb_set_logo_directpalette(info, fb_logo.logo, palette);
 
 		saved_pseudo_palette = info->pseudo_palette;
 		info->pseudo_palette = palette;
 	}
 
-	if (needs_logo) {
-		logo_new = kmalloc(logo->width * logo->height, GFP_KERNEL);
+	if (fb_logo.needs_logo != 8) {
+		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
+				   GFP_KERNEL);
 		if (logo_new == NULL) {
 			if (palette)
 				kfree(palette);
@@ -615,27 +633,27 @@
 		}
 
 		image.data = logo_new;
-		fb_set_logo(info, logo, logo_new, needs_logo);
+		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.needs_logo);
 	}
 
-	image.width = logo->width;
-	image.height = logo->height;
+	image.width = fb_logo.logo->width;
+	image.height = fb_logo.logo->height;
 	image.dy = 0;
 
-	for (x = 0; x < num_online_cpus() * (logo->width + 8) &&
-	     x <= info->var.xres-logo->width; x += (logo->width + 8)) {
+	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
+	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;
 		info->fbops->fb_imageblit(info, &image);
 		done = 1;
 	}
-
+	
 	if (palette != NULL)
 		kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
 	if (logo_new != NULL)
 		kfree(logo_new);
-	return logo->height;
+	return fb_logo.logo->height;
 }
 
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
@@ -1213,6 +1231,7 @@
 EXPORT_SYMBOL(num_registered_fb);
 EXPORT_SYMBOL(registered_fb);
 EXPORT_SYMBOL(fb_show_logo);
+EXPORT_SYMBOL(fb_prepare_logo);
 EXPORT_SYMBOL(fb_set_var);
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
diff -Naur linux-2.5.59-gu/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.59-gu/include/linux/fb.h	2003-02-05 06:39:34.000000000 +0000
+++ linux/include/linux/fb.h	2003-02-05 06:40:30.000000000 +0000
@@ -464,6 +464,7 @@
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
+extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;


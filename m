Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbTBQTND>; Mon, 17 Feb 2003 14:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTBQTND>; Mon, 17 Feb 2003 14:13:03 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:6970 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S267287AbTBQTM5>; Mon, 17 Feb 2003 14:12:57 -0500
Subject: Re: [Linux-fbdev-devel] Re: New logo code [CONFIG OPTIONS]
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nico Schottelius <schottelius@wdt.de>, Torrey Hoffman <thoffman@arnor.net>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0302171135100.16817-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302171135100.16817-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1045509708.1209.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Feb 2003 03:23:11 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 18:36, Geert Uytterhoeven wrote:
> > CONFIG_LOGO_POS_X="left|center|right"  # or absolute ?
> > CONFIG_LOGO_POS_Y="top|center|bottom"  # like X windows +110,+200 ?

Geert,

I was wondering how to implement positioning of the logo with the
current method of displaying it (by reserving screen space of height 
"logo_lines"). This is not so nice to look at when we position the logo
in the center or the bottom.

So how about making the logo "float" above/obscure the text (ie,
overlay)?  It's not difficult to implement since fbcon.c has "redraw"
versions of fbcon_bmove() and fbcon_clear().  All that needs to be done
is do a "scissors" test before an fb_imageblit().  

Here's a trial implementation.  The logo configuration has extra options
for the "overlay method" (CONFIG_LOGO_OVERLAY) and positioning of the
logo (top, bottom, left, right, center).  The logo will always stay on
top while the underlying text is scrolling.

Attached is a diff.  James' latest fbdev.diff and the series of patches
I submitted must be applied first.

Tony


diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61/drivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-17 17:57:37.000000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon.c	2003-02-17 18:39:56.000000000 +0000
@@ -106,9 +106,25 @@
 
 struct display fb_display[MAX_NR_CONSOLES];
 char con2fb_map[MAX_NR_CONSOLES];
+static struct fb_fillrect dim_logo;
 static int logo_height;
 static int logo_lines;
 static int logo_shown = -1;
+
+#ifdef CONFIG_LOGO_OVERLAY
+static int logo_scissors = 1;
+static inline int get_logo_height(void)
+{
+	return 0;
+}
+#else
+static int logo_scissors = 0;
+static inline int get_logo_height(void)
+{
+	return (dim_logo.height);
+}
+#endif /* CONFIG_LOGO_OVERLAY */
+
 /* Software scrollback */
 int fbcon_softback_size = 32768;
 static unsigned long softback_buf, softback_curr;
@@ -394,6 +410,27 @@
 	image.height = vc->vc_font.height;
 	image.depth = 0;
 
+	if (logo_scissors) {
+		int sx1 = dim_logo.dx;
+		int sx2 = dim_logo.dx + dim_logo.width;
+		int sy1 = dim_logo.dy;
+		int sy2 = dim_logo.dy + dim_logo.height;
+
+		image.width = vc->vc_font.width;
+		while (count--) {
+			if (!(image.dx + image.width > sx1 && 
+			      image.dy + image.height > sy1 &&
+			      image.dx < sx2 && image.dy < sy2)) {
+				image.data = p->fontdata + 
+					(scr_readw(s) & charmask) * cellsize;
+				info->fbops->fb_imageblit(info, &image);
+			}
+			image.dx += vc->vc_font.width;
+			s++;
+		}	
+		return;
+	}
+
 	if (!(vc->vc_font.width & 7)) {
 		unsigned int pitch, cnt, i, j, k;
 		unsigned int maxcnt = FB_PIXMAPSIZE/cellsize;
@@ -563,6 +600,19 @@
 	cursor.dest = dest;
 	cursor.rop = ROP_XOR;
 
+	if (logo_scissors) {
+		int sx1 = dim_logo.dx;
+		int sx2 = dim_logo.dx + dim_logo.width;
+		int sy1 = dim_logo.dy;
+		int sy2 = dim_logo.dy + dim_logo.height;
+
+		if (cursor.image.dx < sx2 && 
+		    cursor.image.dy < sy2 &&
+		    cursor.image.dx + cursor.image.width > sx1 &&
+		    cursor.image.dy + cursor.image.height > sy1)
+			return;
+	}
+
 	if (info->fbops->fb_cursor)
 		info->fbops->fb_cursor(info, &cursor);
 }
@@ -945,7 +995,8 @@
 		int cnt;
 		int step;
 
-		logo_height = fb_prepare_logo(info);
+		fb_prepare_logo(&dim_logo, info);
+		logo_height = get_logo_height();
 		logo_lines = (logo_height + vc->vc_font.height - 1) /
 			     vc->vc_font.height;
 		q = (unsigned short *) (vc->vc_origin +
@@ -1115,6 +1166,11 @@
 		redraw_cursor = 1;
 	}
 
+	if (logo_scissors) {
+		fbcon_redraw_clear(vc, p, sy, sx, height, width);
+		return;
+	}
+
 	/* Split blits that cross physical y_wrap boundary */
 
 	y_break = p->vrows - p->yscroll;
@@ -1151,12 +1207,23 @@
 		redraw_cursor = 1;
 	}
 
-	image.fg_color = attr_fgcol(p, c);
-	image.bg_color = attr_bgcol(p, c);
 	image.dx = xpos * vc->vc_font.width;
 	image.dy = real_y(p, ypos) * vc->vc_font.height;
 	image.width = vc->vc_font.width;
 	image.height = vc->vc_font.height;
+	if (logo_scissors) {
+		int sx1 = dim_logo.dx;
+		int sx2 = dim_logo.dx + dim_logo.width;
+		int sy1 = dim_logo.dy;
+		int sy2 = dim_logo.dy + dim_logo.height;
+
+		if (image.dx < sx2 && image.dy < sy2 &&
+		    image.dx + image.width > sx1 &&
+		    image.dy + image.height > sy1)
+			return;
+	}
+	image.fg_color = attr_fgcol(p, c);
+	image.bg_color = attr_bgcol(p, c);
 	image.depth = 1;
 	image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
 
@@ -1707,8 +1774,7 @@
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
-			accel_clear(vc, p, real_y(p, b - count), 0,
-					 count, vc->vc_cols);
+			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
@@ -1913,6 +1979,7 @@
 		    && conp2->vc_bottom == conp2->vc_rows)
 			conp2->vc_top = 0;
 		logo_shown = -1;
+		logo_scissors = 0;
 	}
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
@@ -2476,6 +2543,7 @@
 					      logo_lines * vc->vc_cols);
 			}
 			logo_shown = -1;
+			logo_scissors = 0;
 		}
 		fbcon_cursor(vc, CM_ERASE | CM_SOFTBACK);
 		fbcon_redraw_softback(vc, p, lines);
diff -Naur linux-2.5.61-fbdev/drivers/video/fbmem.c linux-2.5.61/drivers/video/fbmem.c
--- linux-2.5.61-fbdev/drivers/video/fbmem.c	2003-02-17 17:57:40.000000000 +0000
+++ linux-2.5.61/drivers/video/fbmem.c	2003-02-17 18:38:50.000000000 +0000
@@ -363,15 +363,15 @@
 static int ofonly __initdata = 0;
 #endif
 
+#ifdef CONFIG_LOGO
+#include <linux/linux_logo.h>
+
 static inline unsigned safe_shift(unsigned d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
 }
 
-#ifdef CONFIG_FB_LOGO
-#include <linux/linux_logo.h>
-
-static void __init fb_set_logocmap(struct fb_info *info,
+static void fb_set_logocmap(struct fb_info *info,
 				   const struct linux_logo *logo)
 {
 	struct fb_cmap palette_cmap;
@@ -435,7 +435,7 @@
 	}
 }
 
-static void __init fb_set_logo_directpalette(struct fb_info *info,
+static void fb_set_logo_directpalette(struct fb_info *info,
 					     const struct linux_logo *logo,
 					     u32 *palette)
 {
@@ -520,15 +520,72 @@
 	int needs_truepalette;
 	int needs_cmapreset;
 	int type;
+	int dx;
+	int dy;
 	const struct linux_logo *logo;
 } fb_logo;
 
-int fb_prepare_logo(struct fb_info *info)
+#ifdef CONFIG_LOGO_CENTER
+static inline int get_logo_xpos(struct fb_info *info)
 {
-	memset(&fb_logo, 0, sizeof(struct logo_data));
+	return ((info->var.xres - fb_logo.logo->width)/2);
+}
+#elif CONFIG_LOGO_RIGHT
+static inline int get_logo_xpos(struct fb_info *info)
+{
+	return (info->var.xres - fb_logo.logo->width);
+}
+#else
+static inline int get_logo_xpos(struct fb_info *info)
+{
+	return (0);
+}
+#endif
 
-	fb_logo.depth = info->var.bits_per_pixel;
+#ifdef CONFIG_LOGO_MIDDLE
+static inline int get_logo_ypos(struct fb_info *info)
+{
+	return ((info->var.yres - fb_logo.logo->height)/2);
+}
+#elif CONFIG_LOGO_BOTTOM
+static inline int get_logo_ypos(struct fb_info *info)
+{
+	return (info->var.yres - fb_logo.logo->height);
+}
+#else
+static inline int get_logo_ypos(struct fb_info *info)
+{
+	return (0);
+}
+#endif
+
+#ifdef CONFIG_LOGO_OVERLAY
+static inline void draw_logo(struct fb_image *image, struct fb_info *info)
+{
+	image->dx = fb_logo.dx;
+	info->fbops->fb_imageblit(info, image);
+}
+#else
+static inline void draw_logo(struct fb_image *image, struct fb_info *info)
+{
+	int xpos = fb_logo.dx;
+	int width = fb_logo.logo->width + 8;
+	int times = num_online_cpus(), x;
 
+	for (x = xpos; x < times * width && 
+	     x <= info->var.xres-width; x += width) {
+		image->dx = x;
+		info->fbops->fb_imageblit(info, image);
+	}
+}
+#endif /* CONFIG_LOGO_OVERLAY */
+
+void fb_prepare_logo(struct fb_fillrect *rect, struct fb_info *info)
+{
+	memset(&fb_logo, 0, sizeof(struct logo_data));
+	memset(rect, 0, sizeof(struct fb_fillrect));
+	fb_logo.depth = info->var.bits_per_pixel;
+	
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 		if (fb_logo.depth >= 8) {
@@ -587,9 +644,14 @@
 	fb_logo.logo = fb_find_logo(fb_logo.type);
 	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
 		fb_logo.logo = NULL;
-		return 0;
+		return;
 	}
-	return fb_logo.logo->height;
+	fb_logo.dx = get_logo_xpos(info);
+	fb_logo.dy = get_logo_ypos(info);
+	rect->dx = fb_logo.dx;
+	rect->dy = fb_logo.dy;
+	rect->width = fb_logo.logo->width;
+	rect->height = fb_logo.logo->height;
 }
 
 int fb_show_logo(struct fb_info *info)
@@ -597,7 +659,6 @@
 	unsigned char *fb = info->screen_base, *logo_new = NULL;
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
 	struct fb_image image;
-	int x;
 
 	/* Return if the frame buffer is not mapped */
 	if (!fb || !info->fbops->fb_imageblit ||
@@ -642,14 +703,10 @@
 
 	image.width = fb_logo.logo->width;
 	image.height = fb_logo.logo->height;
-	image.dy = 0;
+	image.dy = fb_logo.dy;
+
+	draw_logo(&image, info);
 
-	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
-	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
-		image.dx = x;
-		info->fbops->fb_imageblit(info, &image);
-	}
-	
 	if (palette != NULL)
 		kfree(palette);
 	if (saved_pseudo_palette != NULL)
@@ -659,9 +716,10 @@
 	return fb_logo.logo->height;
 }
 #else
-int fb_prepare_logo(struct fb_info *info) { return 0; }
+void fb_prepare_logo(struct fb_fillrect *rect, struct fb_info *info) 
+{ return 0; }
 int fb_show_logo(struct fb_info *info) { return 0; }
-#endif /* CONFIG_FB_LOGO */
+#endif /* CONFIG_LOGO */
 
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
 			   int len, int *eof, void *private)
diff -Naur linux-2.5.61-fbdev/drivers/video/logo/Kconfig linux-2.5.61/drivers/video/logo/Kconfig
--- linux-2.5.61-fbdev/drivers/video/logo/Kconfig	2003-02-17 18:10:15.000000000 +0000
+++ linux-2.5.61/drivers/video/logo/Kconfig	2003-02-17 18:08:22.000000000 +0000
@@ -8,6 +8,47 @@
 	bool "Bootup logo"
 	depends on FB || CONFIG_SGI_NEWPORT_CONSOLE
 
+config LOGO_OVERLAY
+	bool "Logo Overlay"
+	depends on LOGO && FB
+	---help---
+          If you say Y, the logo will appear to "float" over
+          the primary display, obstructing the underlying
+          text.
+
+          If unsure, say N.
+choice 
+	prompt "Horizontal Position"
+	depends on LOGO_OVERLAY
+	default LOGO_LEFT
+	
+config LOGO_LEFT
+	bool "Left"
+
+config LOGO_CENTER
+	bool "Center"	
+
+config LOGO_RIGHT
+	bool "Right"
+
+endchoice
+
+choice 
+	prompt "Vertical Position"
+	depends on LOGO_OVERLAY
+	default LOGO_TOP
+
+config LOGO_TOP
+	bool "Top"
+
+config LOGO_MIDDLE
+	bool "Center"	
+
+config LOGO_BOTTOM
+	bool "Bottom"
+
+endchoice
+
 config LOGO_LINUX_MONO
 	bool "Black and white Linux logo"
 	depends on LOGO
diff -Naur linux-2.5.61-fbdev/include/linux/fb.h linux-2.5.61/include/linux/fb.h
--- linux-2.5.61-fbdev/include/linux/fb.h	2003-02-17 17:57:37.000000000 +0000
+++ linux-2.5.61/include/linux/fb.h	2003-02-17 18:05:01.000000000 +0000
@@ -462,7 +462,7 @@
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
-extern int fb_prepare_logo(struct fb_info *fb_info);
+extern void fb_prepare_logo(struct fb_fillrect *rect, struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb; 


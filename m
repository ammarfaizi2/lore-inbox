Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbTADJ3q>; Sat, 4 Jan 2003 04:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTADJ3q>; Sat, 4 Jan 2003 04:29:46 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:9741 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266749AbTADJ3l>; Sat, 4 Jan 2003 04:29:41 -0500
Subject: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1041672313.958.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Jan 2003 17:25:14 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a patch against 2.5.54 in an attempt to add putcs() and
setfont() methods for fbdev drivers that require them:

...
struct fb_char {
	__u32 dx;               /* where to place chars, in pixels */
	__u32 dy;               /* where to place chars, in scanline */
	__u32 len;              /* number of characters */
	__u32 fg_color;
	__u32 bg_color;        
	__u32 *data;            /* array of indices to fontdata */
};

struct fb_fontdata {
	__u32 width;            /* font width */
	__u32 height;           /* font height */
	__u32 len;              /* number of characters */
	__u8  *data;            /* character map */
};

...

    /* upload character map */
    int (*fb_setfont)(struct fb_info *info, const struct fb_fontdata
*font);
    /* write characters */
    int (*fb_putcs)(struct fb_info *info, const struct fb_char *chars);

fb_setfont() uploads the character map to fbdev and makes it the current
map

fb_putcs() writes characters to display 

I also did some rudimentary testing by adding test hooks to various
fbdev drivers but haven't examined its full effects (ie, different
character maps per console).

Tony

diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-04 09:01:10.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-04 09:00:04.000000000 +0000
@@ -378,61 +378,97 @@
 	info->fbops->fb_fillrect(info, &region);
 }	
 
+#define FB_PIXMAPSIZE 8192
 void accel_putcs(struct vc_data *vc, struct display *p,
 			const unsigned short *s, int count, int yy, int xx)
 {
+	static u8 pixmap[FB_PIXMAPSIZE];
 	struct fb_info *info = p->fb_info;
 	unsigned short charmask = p->charmask;
 	unsigned int width = ((vc->vc_font.width + 7)/8);
-	unsigned int cellsize = vc->vc_font.height * width;
-	struct fb_image image;
+	unsigned int cnt, i, j, k;
+	unsigned int maxcnt;
 	u16 c = scr_readw(s);
-	static u8 pixmap[8192];
+
+	if (info->fbops->fb_putcs) {
+		struct fb_char chars;
+
+		maxcnt = FB_PIXMAPSIZE/4;
+		chars.dx = xx * vc->vc_font.width;
+		chars.dy = yy * vc->vc_font.height;
+		chars.fg_color = attr_fgcol(p, c);
+		chars.bg_color = attr_bgcol(p, c);
+		chars.data = (u32 *) pixmap;
+
+		while (count) {
+			if (count > maxcnt)
+				cnt = maxcnt;
+			else
+				cnt = count;
+			chars.len = cnt;
+			for (i = 0; i < cnt; i++) 
+				((u32 *)pixmap)[i] = (u32) (scr_readw(s++) & 
+							    charmask);
+
+			info->fbops->fb_putcs(info, &chars);
+			chars.dx += cnt * vc->vc_font.width;
+			count -= cnt;
+		}
+	}
+	else {
+		unsigned int cellsize = vc->vc_font.height * width;
+		struct fb_image image;
 	
-	image.fg_color = attr_fgcol(p, c);
-	image.bg_color = attr_bgcol(p, c);
-	image.dx = xx * vc->vc_font.width;
-	image.dy = yy * vc->vc_font.height;
-	image.height = vc->vc_font.height;
-	image.depth = 1;
-
-/*	pixmap = kmalloc((info->var.bits_per_pixel + 7) >> 3 *
-				vc->vc_font.height, GFP_KERNEL); 
-*/
+		image.fg_color = attr_fgcol(p, c);
+		image.bg_color = attr_bgcol(p, c);
+		image.dx = xx * vc->vc_font.width;
+		image.dy = yy * vc->vc_font.height;
+		image.height = vc->vc_font.height;
+		image.depth = 1;
+		
+		if (!(vc->vc_font.width & 7)) {
+			unsigned int pitch;
+			char *src, *dst, *dst0;
+			
+			maxcnt = FB_PIXMAPSIZE/(vc->vc_font.height * width);
+			image.data = pixmap;
+			while (count) {
+				if (count > maxcnt) 
+					cnt = k = maxcnt;
+				else
+					cnt = k = count;
 				
-	if (!(vc->vc_font.width & 7) && pixmap != NULL) {
-		unsigned int pitch = width * count, i, j;
-		char *src, *dst, *dst0;
-
-		dst0 = pixmap;
-		image.width = vc->vc_font.width * count;
-		image.data = pixmap;
-		while (count--) {
-			src = p->fontdata + (scr_readw(s++) & charmask) * cellsize;
-			dst = dst0;
-			for (i = image.height; i--; ) {
-				for (j = 0; j < width; j++) 
-					dst[j] = *src++;
-				dst += pitch;
+				dst0 = pixmap;
+				pitch = width * cnt;
+				image.width = vc->vc_font.width * cnt;
+				while (k--) {
+					src = p->fontdata + 
+					  (scr_readw(s++)&charmask) *
+					  cellsize;
+					dst = dst0;
+					for (i = image.height; i--; ) {
+						for (j = 0; j < width; j++) 
+							dst[j] = *src++;
+						dst += pitch;
+					}
+					dst0 += width;
+				}
+				
+				info->fbops->fb_imageblit(info, &image);
+				image.dx += cnt * vc->vc_font.width;
+				count -= cnt;
 			}
-			dst0 += width;
+		} else {
+			image.width = vc->vc_font.width;
+			while (count--) {
+				image.data = p->fontdata + 
+					(scr_readw(s++) & charmask) * 
+					vc->vc_font.height * width;
+				info->fbops->fb_imageblit(info, &image);
+				image.dx += vc->vc_font.width;
+			}	
 		}
-		info->fbops->fb_imageblit(info, &image);
-		if (info->fbops->fb_sync)
-			info->fbops->fb_sync(info);
-	} else {
-		image.width = vc->vc_font.width;
-		while (count--) {
-			image.data = p->fontdata + 
-				(scr_readw(s++) & charmask) * vc->vc_font.height * width;
-			info->fbops->fb_imageblit(info, &image);
-			image.dx += vc->vc_font.width;
-		}	
 	}
-	/*
-	if (pixmap);
-		kfree(pixmap);
-	*/	
 }
 
 void accel_clear_margins(struct vc_data *vc, struct display *p,
@@ -1144,8 +1180,6 @@
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_info *info = p->fb_info;
 	unsigned short charmask = p->charmask;
-	unsigned int width = ((vc->vc_font.width + 7) >> 3);
-	struct fb_image image;
 	int redraw_cursor = 0;
 
 	if (!p->can_soft_blank && console_blanked)
@@ -1158,18 +1192,35 @@
 		cursor_undrawn();
 		redraw_cursor = 1;
 	}
+	
+	if (info->fbops->fb_putcs) {
+		struct fb_char chars;
+		u32 font = c & charmask;
+
+		chars.dx = xpos * vc->vc_font.width;
+		chars.dy = real_y(p, ypos) * vc->vc_font.height;
+		chars.len = 1;
+		chars.fg_color = attr_fgcol(p, c);
+		chars.bg_color = attr_bgcol(p, c);
+		chars.data = &font;
 
-	image.fg_color = attr_fgcol(p, c);
-	image.bg_color = attr_bgcol(p, c);
-	image.dx = xpos * vc->vc_font.width;
-	image.dy = real_y(p, ypos) * vc->vc_font.height;
-	image.width = vc->vc_font.width;
-	image.height = vc->vc_font.height;
-	image.depth = 1;
-	image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
-
-	info->fbops->fb_imageblit(info, &image);
-
+		info->fbops->fb_putcs(info, &chars);
+	}
+	else {
+		struct fb_image image;
+		unsigned int width = ((vc->vc_font.width + 7) >> 3);
+	
+		image.fg_color = attr_fgcol(p, c);
+		image.bg_color = attr_bgcol(p, c);
+		image.dx = xpos * vc->vc_font.width;
+		image.dy = real_y(p, ypos) * vc->vc_font.height;
+		image.width = vc->vc_font.width;
+		image.height = vc->vc_font.height;
+		image.depth = 1;
+		image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
+		
+		info->fbops->fb_imageblit(info, &image);
+	}
 	if (redraw_cursor)
 		vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 }
@@ -1271,16 +1322,9 @@
 
 int update_var(int con, struct fb_info *info)
 {
-	int err;
+	if (con == info->currcon) 
+		return fb_pan_display(&info->var, info);
 
-	if (con == info->currcon) {
-		if (info->fbops->fb_pan_display) {
-			if ((err =
-			     info->fbops->fb_pan_display(&info->var,
-							 info)))
-				return err;
-		}
-	}
 	return 0;
 }
 
@@ -1918,6 +1962,18 @@
 	scrollback_max = 0;
 	scrollback_current = 0;
 
+	if (info->fbops->fb_setfont) {
+		struct fb_fontdata font;
+
+		font.width = vc->vc_font.width;
+		font.height = vc->vc_font.height;
+		font.len = FNTCHARCNT(p->fontdata);
+		font.data = p->fontdata;
+
+		if (info->fbops->fb_setfont(info, &font))
+			return 0;
+	}
+
 	info->currcon = unit;
 	
 	update_var(unit, info);
@@ -2133,6 +2189,18 @@
 
 	}
 
+	if (info->fbops->fb_setfont) {
+		struct fb_fontdata font;
+
+		font.width = vc->vc_font.width;
+		font.height = vc->vc_font.height;
+		font.len = cnt;
+		font.data = p->fontdata;
+
+		if (info->fbops->fb_setfont(info, &font))
+			return 1;
+	}
+
 	if (resize) {
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
diff -Naur linux-2.5.54/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.54/include/linux/fb.h	2003-01-04 09:01:31.000000000 +0000
+++ linux/include/linux/fb.h	2003-01-04 09:00:35.000000000 +0000
@@ -295,6 +295,23 @@
 	struct fb_cmap cmap;	/* color map info */
 };
 
+struct fb_char {
+	__u32 dx;               /* where to place chars, in pixels */
+	__u32 dy;               /* where to place chars, in scanline */
+	__u32 len;              /* number of characters */
+	__u32 fg_color;
+	__u32 bg_color;        
+	__u32 *data;            /* array of indices to fontdata */
+};
+
+struct fb_fontdata {
+	__u32 width;            /* font width */
+	__u32 height;           /* font height */
+	__u32 len;              /* number of characters */
+	__u8  *data;            /* character map */
+};
+
+
 /*
  * hardware cursor control
  */
@@ -375,6 +392,10 @@
 		    unsigned long arg, struct fb_info *info);
     /* perform fb specific mmap */
     int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+    /* upload character map */
+    int (*fb_setfont)(struct fb_info *info, const struct fb_fontdata *font);
+    /* write characters */
+    int (*fb_putcs)(struct fb_info *info, const struct fb_char *chars);
 };
 
 struct fb_info {





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTAJOjY>; Fri, 10 Jan 2003 09:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTAJOjX>; Fri, 10 Jan 2003 09:39:23 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:57103 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265130AbTAJOjF>; Fri, 10 Jan 2003 09:39:05 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and
	fb_setfont() methods
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@redhat.com
In-Reply-To: <Pine.LNX.4.44.0301090034020.4976-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301090034020.4976-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042209348.1029.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jan 2003 22:36:53 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 02:09, James Simmons wrote:
> > 
> > So maybe if we can rename fb_putcs() to fb_tileblit(), fb_setfont() to
> > fb_loadtiles(), struct fb_chars to struct fb_tilemap and struct
> > fb_fontdata to struct fb_tiledata, maybe it will be more acceptable?
> > 
> > It can be even be expanded by including fb_tiledata.depth
> > fb_tiledata.cmap so we can support multi-colored tiled blitting.
> 
> This I have no problem with. I'm willing to accept this. As long as data 
> from the console layer is not touched. As for loadtiles one thing I like 
> to address is memory allocation. It probable is good idea to do things 
> like place the tile data in buffers allocated by pci_alloc_consistent.
> The other fear is it will only support so many tiles. 
> 

Hmm, so you're willing to accept this... okay, attached is another
patch, made it a bit cleaner so none of the console data will be ever
touched.  Also expanded it so tile blitting has an equivalent 
counterpart with classic blitting.

Thinking about it, I think tile blitting may one day become useful if
ever the console supports more than 16-colors.  Imagine how expensive it
would be to draw 32-bit fonts using classic blitting.

Tried it with a few test hooks, works fine except for one thing:  the
font is initially scrambled at boot, but became fixed later on.  I don't
know how to fix that.

Tony


diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-10 11:08:04.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-10 11:04:59.000000000 +0000
@@ -350,35 +350,91 @@
 {
 	struct fb_info *info = p->fb_info;
 	struct vc_data *vc = p->conp;
-	struct fb_copyarea area;
 
-	area.sx = sx * vc->vc_font.width;
-	area.sy = sy * vc->vc_font.height;
-	area.dx = dx * vc->vc_font.width;
-	area.dy = dy * vc->vc_font.height;
-	area.height = height * vc->vc_font.height;
-	area.width = width * vc->vc_font.width;
+	if (info->caps & FB_CAPS_TILEBLIT && info->tileops) { 
+		struct fb_tilecopy tilerect;
 
-	info->fbops->fb_copyarea(info, &area);
+		tilerect.sx = sx;
+		tilerect.sy = sy;
+		tilerect.dx = dx;
+		tilerect.dy = dy;
+		tilerect.width = width;
+		tilerect.height = height;
+
+		info->tileops->fb_tilecopy(info, &tilerect);
+	} else { 
+		struct fb_copyarea area;
+
+		area.sx = sx * vc->vc_font.width;
+		area.sy = sy * vc->vc_font.height;
+		area.dx = dx * vc->vc_font.width;
+		area.dy = dy * vc->vc_font.height;
+		area.height = height * vc->vc_font.height;
+		area.width = width * vc->vc_font.width;
+		
+		info->fbops->fb_copyarea(info, &area);
+	}
 }
 
 void accel_clear(struct vc_data *vc, struct display *p, int sy,
 			int sx, int height, int width)
 {
 	struct fb_info *info = p->fb_info;
-	struct fb_fillrect region;
+	if (info->caps & FB_CAPS_TILEBLIT && info->tileops) {  
+		struct fb_tilefill tilerect;
 
-	region.color = attr_bgcol_ec(p, vc);
-	region.dx = sx * vc->vc_font.width;
-	region.dy = sy * vc->vc_font.height;
-	region.width = width * vc->vc_font.width;
-	region.height = height * vc->vc_font.height;
-	region.rop = ROP_COPY;
+		tilerect.dx = sx;
+		tilerect.dy = sy;
+		tilerect.width = width;
+		tilerect.height = height;
+		tilerect.fg_color = attr_fgcol_ec(p, vc);
+		tilerect.bg_color = attr_bgcol_ec(p, vc);
+		tilerect.idx = vc->vc_video_erase_char & p->charmask;
+		tilerect.rop = ROP_COPY;
 
-	info->fbops->fb_fillrect(info, &region);
-}	
+		info->tileops->fb_tilefill(info, &tilerect);
+	} else {
+		struct fb_fillrect region;
+
+		region.color = attr_bgcol_ec(p, vc);
+		region.dx = sx * vc->vc_font.width;
+		region.dy = sy * vc->vc_font.height;
+		region.width = width * vc->vc_font.width;
+		region.height = height * vc->vc_font.height;
+		region.rop = ROP_COPY;
+		
+		info->fbops->fb_fillrect(info, &region);
+	}	
+}
 
 #define FB_PIXMAPSIZE 8192
+static void tile_putcs(struct vc_data *vc, struct display *p, u32 *tilemap,
+		       const unsigned short *s, int count, int yy, int xx)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_tileblit tilerect;
+	int maxcnt = FB_PIXMAPSIZE/4, i, cnt;
+	u16 c = scr_readw(s);
+	
+	tilerect.dx = xx;
+	tilerect.dy = yy;
+	tilerect.height = 1;
+	tilerect.fg_color = attr_fgcol(p, c);
+	tilerect.bg_color = attr_bgcol(p, c);
+	tilerect.data = tilemap;
+	
+	while (count) {
+		cnt = (count > maxcnt) ? maxcnt : count;
+		tilerect.width = cnt;
+		for (i = 0; i < cnt; i++) 
+			tilemap[i] = (u32) (scr_readw(s++) & p->charmask);
+
+		info->tileops->fb_tileblit(info, &tilerect);
+                tilerect.dx += cnt;
+		count -= cnt;
+	}
+}
+
 void accel_putcs(struct vc_data *vc, struct display *p,
 			const unsigned short *s, int count, int yy, int xx)
 {
@@ -390,6 +446,11 @@
 	u16 c = scr_readw(s);
 	static u8 pixmap[FB_PIXMAPSIZE];
 	
+	if (info->caps & FB_CAPS_TILEBLIT && info->tileops) { 
+		tile_putcs(vc, p, (u32 *) pixmap, s, count, yy, xx);
+		return;
+	}
+
 	image.fg_color = attr_fgcol(p, c);
 	image.bg_color = attr_bgcol(p, c);
 	image.dx = xx * vc->vc_font.width;
@@ -452,6 +513,10 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
+	/* unneeded for tile blits */
+	if (info->caps && FB_CAPS_TILEBLIT && info->tileops)
+		return;
+
 	region.color = attr_bgcol_ec(p, vc);
 	region.rop = ROP_COPY;
 
@@ -1150,7 +1215,6 @@
 	struct fb_info *info = p->fb_info;
 	unsigned short charmask = p->charmask;
 	unsigned int width = ((vc->vc_font.width + 7) >> 3);
-	struct fb_image image;
 	int redraw_cursor = 0;
 
 	if (!p->can_soft_blank && console_blanked)
@@ -1164,17 +1228,33 @@
 		redraw_cursor = 1;
 	}
 
-	image.fg_color = attr_fgcol(p, c);
-	image.bg_color = attr_bgcol(p, c);
-	image.dx = xpos * vc->vc_font.width;
-	image.dy = real_y(p, ypos) * vc->vc_font.height;
-	image.width = vc->vc_font.width;
-	image.height = vc->vc_font.height;
-	image.depth = 1;
-	image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
+	if (info->caps & FB_CAPS_TILEBLIT && info->tileops) { 
+		struct fb_tileblit tilerect;
+	  
+		u32 font = c & charmask;
+		tilerect.dx = xpos;
+		tilerect.dy = real_y(p, ypos);
+		tilerect.width = 1;
+		tilerect.height = 1;
+		tilerect.fg_color = attr_fgcol(p, c);
+		tilerect.bg_color = attr_bgcol(p, c);
+		tilerect.data = &font;	
+		
+		info->tileops->fb_tileblit(info, &tilerect);
+	} else {
+		struct fb_image image;
 
-	info->fbops->fb_imageblit(info, &image);
+		image.fg_color = attr_fgcol(p, c);
+		image.bg_color = attr_bgcol(p, c);
+		image.dx = xpos * vc->vc_font.width;
+		image.dy = real_y(p, ypos) * vc->vc_font.height;
+		image.width = vc->vc_font.width;
+		image.height = vc->vc_font.height;
+		image.depth = 1;
+		image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
 
+		info->fbops->fb_imageblit(info, &image);
+	}
 	if (redraw_cursor)
 		vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 }
@@ -1935,6 +2015,31 @@
 	scrollback_max = 0;
 	scrollback_current = 0;
 
+	if (info->caps & FB_CAPS_TILEBLIT && info->tileops) {
+		struct fb_tiledata tile;
+		int err, cnt = FNTCHARCNT(p->fontdata);
+		int size = (vc->vc_font.height * vc->vc_font.width)/8 * cnt; 
+		u8 *tiledata;
+
+		/*
+		 * make sure we don't allow drivers to mangle
+		 * console fontdata
+		 */
+		tiledata = kmalloc(size, GFP_KERNEL);
+		if (tiledata == NULL)
+			return 0;
+		memcpy(tiledata, p->fontdata, size);
+		tile.tile.width = vc->vc_font.width;
+		tile.tile.height = vc->vc_font.height;
+		tile.tile.depth = 1;
+		tile.len = cnt;
+		tile.data = tiledata; 
+		err = info->tileops->fb_loadtiles(info, &tile);
+		kfree(tiledata);
+
+		if (err) return 0;
+	}
+
 	info->currcon = unit;
 	
         fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
@@ -2152,6 +2257,27 @@
 
 	}
 
+	if (info->caps & FB_CAPS_TILEBLIT && info->tileops) {
+		struct fb_tiledata tile;
+		int size = (vc->vc_font.height * vc->vc_font.width)/8 * cnt; 
+		int err;
+		u8 *tiledata;
+		
+		tiledata = kmalloc(size, GFP_KERNEL);
+		if (tiledata == NULL)
+			return 1;
+		memcpy(tiledata, p->fontdata, size);
+		tile.tile.width = vc->vc_font.width;
+		tile.tile.height = vc->vc_font.height;
+		tile.tile.depth = 1;
+		tile.len = cnt;
+		tile.data = tiledata;
+		
+		err = info->tileops->fb_loadtiles(info, &tile);
+		kfree(tiledata);
+		if (err) return err;
+	}
+
 	if (resize) {
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
diff -Naur linux-2.5.54/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.54/include/linux/fb.h	2003-01-10 11:08:19.000000000 +0000
+++ linux/include/linux/fb.h	2003-01-10 11:21:27.000000000 +0000
@@ -173,6 +173,10 @@
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
 
+/* Driver Capability */
+#define FB_CAPS_CLIPPING        1       /* hardware can do clipping */
+#define FB_CAPS_TILEBLIT        2       /* hardware can do tileblits */
+
 #define PICOS2KHZ(a) (1000000000UL/(a))
 #define KHZ2PICOS(a) (1000000000UL/(a))
 
@@ -377,6 +381,77 @@
     int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
 };
 
+/* 
+ * Tile Blitting Support
+ * 
+ * In Tile Blitting, the basic unit is a Tile which is a bitmap with
+ * a predefined width and height, and optionally, other properties
+ * such as color depth, spacing, transparency,  etc.  For now, we'll 
+ * just support width, height, and color depth.
+ * 
+ * All operations are analogous to classic blitting operations which
+ * use pixels as the basic unit.  Instead of pixels, it will use tiles,
+ * instead of info->pseudo_palette, it will use tiledata, etc.
+ */
+
+struct fb_tile {
+	__u32 width;            /* tile width in pixels */
+	__u32 height;           /* tile height in scanlines */
+	__u32 depth;            /* pixel depth */
+};
+
+struct fb_tiledata {
+	struct fb_tile tile;    /* tile properties */
+	__u32 len;              /* number of tiles in the map */
+	__u8  *data;            /* packed tile data */
+};
+
+struct fb_tileblit {
+	__u32 dx;               /* destination x origin, in tiles */
+	__u32 dy;               /* destination y origin, in tiles */
+	__u32 width;            /* destination window width, in tiles */
+	__u32 height;           /* destination window height, in tiles */
+	__u32 fg_color;         /* fg_color if monochrome */
+	__u32 bg_color;         /* bg_color if monochrome */
+	__u32 *data;            /* tile map - array of indices to tiledata */
+};
+
+struct fb_tilecopy {
+	__u32 dx;               /* destination window origin... */
+	__u32 dy;               /* in tiles */
+	__u32 width;            /* destination width, in tiles */
+	__u32 height;           /* destination height, in tiles */
+	__u32 sx;               /* source window origin ... */
+	__u32 sy;               /* in tiles */
+};
+
+struct fb_tilefill {
+	__u32 dx;               /* destination window origin ... */
+	__u32 dy;               /* in tiles */
+	__u32 width;            /* destination width in tiles */
+	__u32 height;           /* destination height in tiles */
+	__u32 fg_color;         /* fg_color if monochrome */
+	__u32 bg_color;         /* bg_color if monochrome */
+	__u32 rop;              /* rop operation */
+	__u32 idx;              /* index to current tiledata */
+};
+
+struct fb_tileops {
+    /* upload tile data to driver and make it current... the driver
+     * must copy the contents of tiledata.data, not just the pointer to it */
+    int (*fb_loadtiles)(struct fb_info *info, 
+			const struct fb_tiledata *tile);
+    /* blit tiles to destination from a tilemap */
+    void (*fb_tileblit)(struct fb_info *info, 
+			const struct fb_tileblit *tilemap);
+    /* copy tiles from one region of fb memory to another */
+    void (*fb_tilecopy)(struct fb_info *info, const struct fb_tilecopy *area);
+    /* fill a region of fb memory with a tile */
+    void (*fb_tilefill)(struct fb_info *info, 
+			const struct fb_tilefill *region);
+    /* If driver is to support tile blitting, all hooks above are required */
+};
+
 struct fb_info {
    kdev_t node;
    int flags;
@@ -388,6 +463,7 @@
    struct fb_cursor cursor;		/* Current cursor */	
    struct fb_cmap cmap;                 /* Current cmap */
    struct fb_ops *fbops;
+   struct fb_tileops *tileops           /* Tile blitting */
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */	



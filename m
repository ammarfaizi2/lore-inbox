Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSJQARQ>; Wed, 16 Oct 2002 20:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJQARQ>; Wed, 16 Oct 2002 20:17:16 -0400
Received: from [203.167.79.9] ([203.167.79.9]:63242 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S261705AbSJQARI>; Wed, 16 Oct 2002 20:17:08 -0400
Subject: Re: [Linux-fbdev-devel] fbdev changes.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Oct 2002 08:19:16 +0800
Message-Id: <1034813995.563.32.camel@daplas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 04:27, James Simmons wrote:
[...]
> 
> /*
>  * hardware cursor control
>  */
> 
> #define FB_CUR_SETCUR   0x01
> #define FB_CUR_SETPOS   0x02
> #define FB_CUR_SETHOT   0x04
> #define FB_CUR_SETCMAP  0x08
> #define FB_CUR_SETSHAPE 0x10
> #define FB_CUR_SETALL   0x1F
> 
> struct fbcurpos {
>         __u16 x, y;
> };
> 
> struct fbcursor {
>         __u16 set;              /* what to set */
>         __u16 enable;           /* cursor on/off */
>         struct fbcurpos pos;    /* cursor position */
>         struct fbcurpos hot;    /* cursor hot spot */
>         struct fb_cmap cmap;    /* color map info */
>         struct fbcurpos size;   /* cursor bit map size */
>         char *image;            /* cursor image bits */
>         char *mask;             /* cursor mask bits */
> };
> 
> If you have any suggestion please post you purpose struct. Thank you.
> 

Hi James,

Since you seem to be very busy, here's an idea for the framebuffer
cursor API.  

I have added a 'char *dest' entry to fbcursor which is basically a
bitmap of the current text underlying the cursor position.  This should
make it easier for the software cursor to do the color inversion
manually.  Also having 3 operands for the bit operation (source - image,
pattern - mask, destination - dest) should give more flexibility. 

Additional fields are 'depth' - describes the color depth of the bitmap
- and 'rop' - the desired bit operation. The fields 'image', 'mask', and
'dest' should have the same depth and dimensions.  I also removed
fb_cmap and instead used an array of pseudo_palette indices since all
the drawing functions rely on info->pseudo_palette for color
information.

fb_imageblit is used for drawing the software cursor instead of
fb_fillrect.  This might be a bit faster because it does not have to
read the contents of the framebuffer as with fillrect using ROP_XOR. 
It's also more flexible (ie, may draw a non-monochrome cursor image).

The flow is: fbcon_cursor -> display->dispsw->cursor ->
info->fbops->fb_cursor. Drivers can choose to create their own routines,
or use a generic one (gen_cursor) in fbgen.c.  Drivers just need to
display and move the cursor.  Flashing the cursor will be done by
fbcon.  Thus, timer routines in the various drivers can be removed.

With the attached patch, the cursor should behave similarly to vgacon --
default cursor is underscore, but shape can be changed at will.  Color
of the cursor will depend on the attribute of the underlying text.  I'm
not sure if this is correct behavior though.

Patch is against 2.5.42.

Tony 

diff -Naur linux-2.5.42/drivers/video/fbcon-accel.c linux/drivers/video/fbcon-accel.c
--- linux-2.5.42/drivers/video/fbcon-accel.c	Wed Oct 16 23:35:27 2002
+++ linux/drivers/video/fbcon-accel.c	Wed Oct 16 23:34:26 2002
@@ -146,6 +146,110 @@
 	}
 }
 
+void fbcon_accel_cursor(struct display *p, int flags, int xx, int yy)
+{
+	static u32 palette_index[2];
+	static struct fb_index index = { 2, palette_index };
+	static char mask[64], image[64], *dest;
+	static int fgcolor, bgcolor, shape, width, height;
+	struct fb_info *info = p->fb_info;
+	struct fbcursor cursor;
+	int c;
+	char *font;
+
+	cursor.set = FB_CUR_SETPOS;
+	if (width != fontwidth(p) || height != fontheight(p)) {
+		width = fontwidth(p);
+		height = fontheight(p);
+		cursor.set |= FB_CUR_SETSIZE;
+	}
+		
+	if ((p->conp->vc_cursor_type & 0x0f) != shape) {
+		shape = p->conp->vc_cursor_type & 0x0f;
+		cursor.set |= FB_CUR_SETSHAPE;
+	}
+
+	c = scr_readw((u16 *) p->cursor_pos);
+
+	if (fgcolor != (int) attr_fgcol(p, c) ||
+	    bgcolor != (int) attr_bgcol(p, c)) {
+		fgcolor = (int) attr_fgcol(p, c);
+		bgcolor = (int) attr_bgcol(p, c);
+		cursor.set |= FB_CUR_SETCMAP;
+	}
+
+	c &= p->charmask;
+	font = p->fontdata + (c * ((width + 7)/8) * height);
+	if (font != dest) {
+		dest = font;
+		cursor.set |= FB_CUR_SETDEST;
+	}
+
+	if (flags & FB_CUR_SETCUR)
+		cursor.enable = 1;
+	else
+		cursor.enable = 0;
+	
+	if (cursor.set & FB_CUR_SETCMAP) {
+		palette_index[0] = bgcolor;
+		palette_index[1] = fgcolor;
+	}
+
+	if (cursor.set & FB_CUR_SETSIZE) {
+		memset(image, 0xff, 64);
+		cursor.set |= FB_CUR_SETSHAPE;
+	}
+
+	if (cursor.set & FB_CUR_SETSHAPE) {
+		int w, cur_height, size, i = 0;
+		
+
+		w = (width + 7)/8;
+
+		switch (shape) {
+		case CUR_NONE:
+			cur_height = 0;
+			break;
+		case CUR_UNDERLINE:
+			cur_height = (height < 10) ? 1 : 2;
+			break;
+		case CUR_LOWER_THIRD:
+			cur_height = height/3;
+			break;
+		case CUR_LOWER_HALF:
+			cur_height = height/2;
+			break;
+		case CUR_TWO_THIRDS:
+			cur_height = (height * 2)/3;
+			break;
+		case CUR_BLOCK:
+		default:
+			cur_height = height;
+			break;
+		}
+		size = (height - cur_height) * w;
+		while (size--) 
+			mask[i++] = 0;
+		size = cur_height * w;
+		while(size--)
+			mask[i++] = 0xff;
+	}
+	
+	cursor.size.x = width;
+	cursor.size.y = height;
+	cursor.pos.x =  xx * width;
+	cursor.pos.y =  yy * height;
+	cursor.image = image;
+	cursor.mask = mask;
+	cursor.dest = dest;
+	cursor.rop = ROP_XOR;
+	cursor.index = &index;
+	cursor.depth = 1;
+
+	if (info->fbops->fb_cursor)
+		info->fbops->fb_cursor(info, &cursor);
+}
+
     /*
      *  `switch' for the low level operations
      */
@@ -158,6 +262,7 @@
 	.putcs =	fbcon_accel_putcs,
 	.revc =		fbcon_accel_revc,
 	.clear_margins =fbcon_accel_clear_margins,
+	.cursor =       fbcon_accel_cursor, 
 	.fontwidthmask =FONTWIDTHRANGE(1, 16)	
 };
 
diff -Naur linux-2.5.42/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux-2.5.42/drivers/video/fbcon.c	Wed Oct 16 23:35:22 2002
+++ linux/drivers/video/fbcon.c	Wed Oct 16 23:34:21 2002
@@ -722,10 +722,8 @@
 	       "supported\n", info->fix.type, info->fix.type_aux, 
 		p->var.bits_per_pixel);
     p->dispsw->setup(p);
-
     p->fgcol = p->var.bits_per_pixel > 2 ? 7 : (1<<p->var.bits_per_pixel)-1;
     p->bgcol = 0;
-
     if (!init) {
 	if (conp->vc_cols != nr_cols || conp->vc_rows != nr_rows)
 	    vc_resize_con(nr_rows, nr_cols, con);
@@ -878,73 +876,69 @@
 	    vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 }
 
-
 static void fbcon_cursor(struct vc_data *conp, int mode)
 {
-    int unit = conp->vc_num;
-    struct display *p = &fb_display[unit];
-    int y = conp->vc_y;
-    
-    if (mode & CM_SOFTBACK) {
-    	mode &= ~CM_SOFTBACK;
-    	if (softback_lines) {
-    	    if (y + softback_lines >= conp->vc_rows)
-    		mode = CM_ERASE;
-    	    else
-    	        y += softback_lines;
-    	}
-    } else if (softback_lines)
-        fbcon_set_origin(conp);
-
-    /* do we have a hardware cursor ? */
-    if (p->dispsw->cursor) {
+	int unit = conp->vc_num;
+	struct display *p = &fb_display[unit];
+	int y = conp->vc_y;
+	
+	if (mode & CM_SOFTBACK) {
+		mode &= ~CM_SOFTBACK;
+		if (softback_lines) {
+			if (y + softback_lines >= conp->vc_rows)
+				mode = CM_ERASE;
+			else
+				y += softback_lines;
+		}
+	} else if (softback_lines)
+		fbcon_set_origin(conp);
+	
+	/* Avoid flickering if there's no real change. */
+	if (p->cursor_x == conp->vc_x && p->cursor_y == y &&
+	    (mode == CM_ERASE) == !cursor_on)
+		return;
+	
+	cursor_on = 0;
+	if (cursor_drawn) 
+		p->dispsw->cursor(p, 0, p->cursor_x, real_y(p, p->cursor_y));
+	
 	p->cursor_x = conp->vc_x;
 	p->cursor_y = y;
-	p->dispsw->cursor(p, mode, p->cursor_x, real_y(p, p->cursor_y));
-	return;
-    }
+	p->cursor_pos = conp->vc_pos;
 
-    /* Avoid flickering if there's no real change. */
-    if (p->cursor_x == conp->vc_x && p->cursor_y == y &&
-	(mode == CM_ERASE) == !cursor_on)
-	return;
-
-    cursor_on = 0;
-    if (cursor_drawn)
-        p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
-
-    p->cursor_x = conp->vc_x;
-    p->cursor_y = y;
-
-    switch (mode) {
+	switch (mode) {
         case CM_ERASE:
-            cursor_drawn = 0;
-            break;
+		cursor_drawn = 0;
+		break;
         case CM_MOVE:
         case CM_DRAW:
-            if (cursor_drawn)
-	        p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
-            vbl_cursor_cnt = CURSOR_DRAW_DELAY;
-            cursor_on = 1;
-            break;
+		if (cursor_drawn)
+			p->dispsw->cursor(p, FB_CUR_SETCUR, p->cursor_x, real_y(p, p->cursor_y));
+		vbl_cursor_cnt = CURSOR_DRAW_DELAY;
+		cursor_on = 1;
+		break;
         }
+	
 }
 
-
 static void fbcon_vbl_handler(int irq, void *dummy, struct pt_regs *fp)
 {
-    struct display *p;
-
-    if (!cursor_on)
-	return;
-
-    if (vbl_cursor_cnt && --vbl_cursor_cnt == 0) {
-	p = &fb_display[fg_console];
-	if (p->dispsw->revc)
-		p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
-	cursor_drawn ^= 1;
-	vbl_cursor_cnt = cursor_blink_rate;
-    }
+	struct display *p;
+	
+	if (!cursor_on)
+		return;
+	
+	if (vbl_cursor_cnt && --vbl_cursor_cnt == 0) {
+		int flag;
+	    
+		p = &fb_display[fg_console];
+		flag = 0;
+		if (!cursor_drawn) 
+			flag = FB_CUR_SETCUR;
+		p->dispsw->cursor(p, flag, p->cursor_x, real_y(p, p->cursor_y));
+		cursor_drawn ^= 1;
+		vbl_cursor_cnt = cursor_blink_rate;
+	}
 }
 
 static int scrollback_phys_max = 0;
diff -Naur linux-2.5.42/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux-2.5.42/drivers/video/fbgen.c	Wed Oct 16 23:35:18 2002
+++ linux/drivers/video/fbgen.c	Wed Oct 16 23:34:30 2002
@@ -272,11 +272,54 @@
     return 0;	
 }
 
+/*
+ * Supports monochrome cursor only 
+ */
+void gen_cursor(struct fb_info *info, struct fbcursor *cursor)
+{
+	struct fb_image image;
+	static char data[64];
+	int size = ((cursor->size.x + 7)/8) * cursor->size.y;
+	int i;
+
+	if (cursor->depth == 1) {
+		image.bg_color = cursor->index->entry[0];
+		image.fg_color = cursor->index->entry[1];
+	
+		if (cursor->enable) { 
+			switch (cursor->rop) {
+			case ROP_XOR:
+				for (i = 0; i < size; i++) 
+					data[i] = (cursor->image[i] & cursor->mask[i]) ^ cursor->dest[i];
+				break;
+			case ROP_COPY:
+			default:
+				for (i = 0; i < size; i++) 
+					data[i] = cursor->image[i] & cursor->mask[i];
+				break;
+			}
+		}
+		else 
+			memcpy(data, cursor->dest, size);
+		
+		image.dx = cursor->pos.x;
+		image.dy = cursor->pos.y;
+		image.width = cursor->size.x;
+		image.height = cursor->size.y;
+		image.depth = cursor->depth;
+		image.data = data;
+		
+		if (info->fbops->fb_imageblit)
+			info->fbops->fb_imageblit(info, &image);
+	}
+}
+
 /* generic frame buffer operations */
 EXPORT_SYMBOL(gen_set_var);
 EXPORT_SYMBOL(gen_get_cmap);
 EXPORT_SYMBOL(gen_set_cmap);
 EXPORT_SYMBOL(fbgen_pan_display);
+EXPORT_SYMBOL(gen_cursor);
 /* helper functions */
 EXPORT_SYMBOL(do_install_cmap);
 EXPORT_SYMBOL(gen_update_var);
diff -Naur linux-2.5.42/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.42/include/linux/fb.h	Wed Oct 16 23:35:48 2002
+++ linux/include/linux/fb.h	Wed Oct 16 23:40:44 2002
@@ -220,6 +220,11 @@
 	__u16 *transp;			/* transparency, can be NULL */
 };
 
+struct fb_index {
+	__u32 len;                      /* number of entries */
+	__u32 *entry;                   /* "pseudopalette" color index entries */
+};
+
 struct fb_con2fbmap {
 	__u32 console;
 	__u32 framebuffer;
@@ -280,14 +285,45 @@
 };
 
 struct fb_image {
-	__u32 width;	/* Size of image */
+	__u32 width;	               /* Size of image */
 	__u32 height;
-	__u16 dx;	/* Where to place image */
-	__u16 dy;
-	__u32 fg_color;	/* Only used when a mono bitmap */
+	__u32 dx;	               /* Where to place image */
+	__u32 dy;
+	__u32 fg_color;	               /* Only used when a mono bitmap */
 	__u32 bg_color;
-	__u8  depth;	/* Dpeth of the image */
-	char  *data;	/* Pointer to image data */
+	__u8  depth;	               /* Dpeth of the image */
+	char  *data;	               /* Pointer to image data */
+};
+
+/*
+ * hardware cursor control
+ */
+
+#define FB_CUR_SETCUR   0x01
+#define FB_CUR_SETPOS   0x02
+#define FB_CUR_SETHOT   0x04
+#define FB_CUR_SETCMAP  0x08
+#define FB_CUR_SETSHAPE 0x10
+#define FB_CUR_SETDEST  0x20
+#define FB_CUR_SETSIZE  0x40
+#define FB_CUR_SETALL   0xFF
+
+struct fbcurpos {
+        __u32 x, y;
+};
+
+struct fbcursor {
+        __u32 set;                     /* what to set */
+        __u32 enable;                  /* cursor on/off */
+	__u32 rop;                     /* bitop operation */
+	__u8 depth;                   /* color depth of image */
+        struct fbcurpos pos;           /* cursor position */
+        struct fbcurpos hot;           /* cursor hot spot */
+        struct fb_index *index;        /* color map info */
+        struct fbcurpos size;          /* cursor bit map size */
+        char *image;                   /* cursor image bits */
+        char *mask;                    /* cursor mask bits */
+	char *dest;                    /* destination */
 };
 
 #ifdef __KERNEL__
@@ -342,6 +378,8 @@
     void (*fb_copyarea)(struct fb_info *info, struct fb_copyarea *region); 
     /* Draws a image to the display */
     void (*fb_imageblit)(struct fb_info *info, struct fb_image *image);
+    /* Draws cursor */
+    void (*fb_cursor)(struct fb_info *info, struct fbcursor *cursor);
     /* perform polling on fb device */
     int (*fb_poll)(struct fb_info *info, poll_table *wait);
     /* perform fb specific ioctl (optional) */
@@ -351,6 +389,7 @@
     int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
     /* switch to/from raster image mode */
     int (*fb_rasterimg)(struct fb_info *info, int start);
+	
 };
 
 struct fb_info {
@@ -399,12 +438,12 @@
 			struct fb_info *info);
 extern int gen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			struct fb_info *info);
+extern void gen_cursor(struct fb_info *info, struct fbcursor *cursor);
 extern int fb_pan_display(struct fb_var_screeninfo *var, int con,
 			     struct fb_info *info);
 extern void cfb_fillrect(struct fb_info *info, struct fb_fillrect *rect); 
 extern void cfb_copyarea(struct fb_info *info, struct fb_copyarea *region); 
 extern void cfb_imageblit(struct fb_info *info, struct fb_image *image);
-
     /*
      *  Helper functions
      */
diff -Naur linux-2.5.42/include/video/fbcon.h linux/include/video/fbcon.h
--- linux-2.5.42/include/video/fbcon.h	Wed Oct 16 23:35:39 2002
+++ linux/include/video/fbcon.h	Wed Oct 16 23:34:49 2002
@@ -35,7 +35,7 @@
     void (*putcs)(struct vc_data *conp, struct display *p, const unsigned short *s,
 		  int count, int yy, int xx);     
     void (*revc)(struct display *p, int xx, int yy);
-    void (*cursor)(struct display *p, int mode, int xx, int yy);
+    void (*cursor)(struct display *p, int flags, int xx, int yy);
     int  (*set_font)(struct display *p, int width, int height);
     void (*clear_margins)(struct vc_data *conp, struct display *p,
 			  int bottom_only);
@@ -72,6 +72,7 @@
     int vrows;                      /* number of virtual rows */
     unsigned short cursor_x;        /* current cursor position */
     unsigned short cursor_y;
+    unsigned long cursor_pos;
     int fgcol;                      /* text colors */
     int bgcol;
     u_long next_line;               /* offset to one line below */


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbTC0DdP>; Wed, 26 Mar 2003 22:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTC0DdP>; Wed, 26 Mar 2003 22:33:15 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:23049 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S262800AbTC0DdB>; Wed, 26 Mar 2003 22:33:01 -0500
Subject: Re: [Linux-fbdev-devel] Much better framebuffer fixes.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048735712.1047.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Mar 2003 11:29:26 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 08:18, James Simmons wrote:
> 
> Okay. Here are more framebuffer fixes. Please try these fixes and let me 
> know how they work out for you.
> 

This is a resend of the patch I previously sent.  I see that you have
made changes to the logo drawing code targeted for monochrome logo
drawing to use mono expansion.  You still need a few changes though,
image->bg_color and image->fg_color must be initialized correctly when
image->depth == 1.

Tony

diff -Naur linux-2.5.66-orig/drivers/video/cfbimgblt.c linux-2.5.66/drivers/video/cfbimgblt.c
--- linux-2.5.66-orig/drivers/video/cfbimgblt.c	2003-03-27 03:06:10.000000000 +0000
+++ linux-2.5.66/drivers/video/cfbimgblt.c	2003-03-27 03:09:09.000000000 +0000
@@ -346,7 +346,7 @@
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
-	} else if (image->depth <= bpp) 
+	} else 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 
diff -Naur linux-2.5.66-orig/drivers/video/console/fbcon.c linux-2.5.66/drivers/video/console/fbcon.c
--- linux-2.5.66-orig/drivers/video/console/fbcon.c	2003-03-27 03:06:10.000000000 +0000
+++ linux-2.5.66/drivers/video/console/fbcon.c	2003-03-27 03:09:09.000000000 +0000
@@ -172,7 +172,7 @@
  *  Internal routines
  */
 static void fbcon_set_display(struct vc_data *vc, int init, int logo);
-static void accel_cursor(struct vc_data *vc, struct fb_info *info, 
+static void accel_cursor(struct vc_data *vc, struct fb_info *info,
 			 struct fb_cursor *cursor, int yy);
 static __inline__ int real_y(struct display *p, int ypos);
 static __inline__ void updatescrollmode(struct display *p, struct vc_data *vc);
@@ -206,13 +206,13 @@
 		return;
 
 	if (vbl_cursor_cnt && --vbl_cursor_cnt == 0) {
-		cursor.set = 0;
+		cursor.set = FB_CUR_SETFLASH;
 
 		if (!cursor_drawn)
 			cursor.set = FB_CUR_SETCUR;
 		accel_cursor(vc, info, &cursor, real_y(p, vc->vc_y));
 		cursor_drawn ^= 1;
-		vbl_cursor_cnt = cursor_blink_rate; 
+		vbl_cursor_cnt = cursor_blink_rate;
 	}
 }
 
@@ -220,9 +220,9 @@
 {
 	struct fb_info *info = dev_id;
 
-	schedule_work(&info->queue);	
+	schedule_work(&info->queue);
 }
-	
+
 static void cursor_timer_handler(unsigned long dev_addr);
 
 static struct timer_list cursor_timer =
@@ -232,7 +232,7 @@
 {
 	struct fb_info *info = (struct fb_info *) dev_addr;
 	
-	schedule_work(&info->queue);	
+ 	schedule_work(&info->queue);
 	cursor_timer.expires = jiffies + HZ / 50;
 	add_timer(&cursor_timer);
 }
@@ -530,6 +530,7 @@
  *  Low Level Operations
  */
 /* NOTE: fbcon cannot be __init: it may be called from take_over_console later */
+
 static const char *fbcon_startup(void)
 {
 	const char *display_desc = "frame buffer device";
@@ -593,9 +594,16 @@
 		return NULL;
 	}
 
+	/* Allocate private data */
+	info->fbcon_priv = kmalloc(sizeof(struct fbcon_private), GFP_KERNEL);
+	if (info->fbcon_priv == NULL) {
+		kfree(vc);
+		return NULL;
+	}
+       
 	/* Initialize the work queue */
 	INIT_WORK(&info->queue, fb_callback, info);
-	
+
 	/* Setup default font */
 	vc->vc_font.data = font->data;
 	vc->vc_font.width = font->width;
@@ -993,103 +1001,108 @@
 	accel_putcs(vc, info, s, count, real_y(p, ypos), xpos);
 }
 
-static void accel_cursor(struct vc_data *vc, struct fb_info *info,
-			 struct fb_cursor *cursor, int yy)
+void accel_cursor(struct vc_data *vc, struct fb_info *info, 
+		  struct fb_cursor *cursor, int yy)
 {
+	struct fbcon_private *priv = (struct fbcon_private *)info->fbcon_priv;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
-	static int fgcolor, bgcolor, shape, width, height;
-	static char mask[64], image[64], *dest;
-        char *font;
-        int c;
+	int height, width, size, c;
+	int w, cur_height, i = 0;
+	u8 *font;
+	
+	if (cursor->set & FB_CUR_SETCUR)
+		cursor->enable = 1;
+	else
+		cursor->enable = 0;
 
-        if (cursor->set & FB_CUR_SETCUR)
-                cursor->enable = 1;
-        else
-                cursor->enable = 0;
 
-	cursor->set = FB_CUR_SETPOS;
+	height = priv->cursor.image.height;
+	width = priv->cursor.image.width;
+
+	if (width != vc->vc_font.width || 
+	    height != vc->vc_font.height) {
+		priv->cursor.image.width = vc->vc_font.width;
+		priv->cursor.image.height = vc->vc_font.height;
+		height = priv->cursor.image.height;
+		width = priv->cursor.image.width;
+		cursor->set |= FB_CUR_SETSIZE;
+	}	
+
+	if (priv->cursor.image.dx != vc->vc_x * width ||
+	    priv->cursor.image.dy != yy * height) {
+		priv->cursor.image.dx = vc->vc_x * width;
+		priv->cursor.image.dy = yy * height;
+		cursor->set |= FB_CUR_SETPOS;
+	}
 
-	if (width != vc->vc_font.width || height != vc->vc_font.height) {
-                width = vc->vc_font.width;
-                height = vc->vc_font.height;
-                cursor->set |= FB_CUR_SETSIZE;
-        }
+	size = ((width + 7) >> 3) * height;
 
-        if ((vc->vc_cursor_type & 0x0f) != shape) {
-                shape = vc->vc_cursor_type & 0x0f;
+	if (cursor->set & FB_CUR_SETSIZE) {
+		memset(priv->image, 0xff, size);
 		cursor->set |= FB_CUR_SETSHAPE;
-        }
+	}
 
-        c = scr_readw((u16 *) vc->vc_pos);
+	if (priv->shape != (vc->vc_cursor_type & 0x0f)) {
+		priv->shape = vc->vc_cursor_type & 0x0f;
+		cursor->set |= FB_CUR_SETSHAPE;
+	}
 
-	if (fgcolor != (int) attr_fgcol(fgshift, c) ||
-            bgcolor != (int) attr_bgcol(bgshift, c)) {
-                fgcolor = (int) attr_fgcol(fgshift, c);
-                bgcolor = (int) attr_bgcol(bgshift, c);
-                cursor->set |= FB_CUR_SETCMAP;
-        }
-        c &= charmask;
-        font = vc->vc_font.data + (c * ((width + 7) / 8) * height);
-        if (font != dest) {
-                dest = font;
-                cursor->set |= FB_CUR_SETDEST;
-        }
-
-        if (cursor->set & FB_CUR_SETSIZE) {
-                memset(image, 0xff, 64);
-                cursor->set |= FB_CUR_SETSHAPE;
-        }
+	c = scr_readw((u16 *) vc->vc_pos);
 
-	if (cursor->set & FB_CUR_SETSHAPE) {
-                int w, cur_height, size, i = 0;
+	if (priv->cursor.image.fg_color != attr_fgcol(fgshift, c) ||
+	    priv->cursor.image.bg_color != attr_bgcol(bgshift, c)) {
+		priv->cursor.image.fg_color = attr_fgcol(fgshift, c);
+		priv->cursor.image.bg_color = attr_bgcol(bgshift, c);
+		priv->cursor.image.depth = 1;
+		cursor->set |= FB_CUR_SETCMAP;
+	}
+	font = vc->vc_font.data + ((c & charmask) * size);
+	if (font != priv->dest) {
+		priv->dest = font;
+		cursor->set |= FB_CUR_SETDEST;
+	}
 
-                w = (width + 7) / 8;
+	w = (width + 7) >> 3;
 
-                switch (shape) {
-                        case CUR_NONE:
-                                cur_height = 0;
-                                break;
-                        case CUR_UNDERLINE:
-                                cur_height = (height < 10) ? 1 : 2;
-                                break;
-                        case CUR_LOWER_THIRD:
-                                cur_height = height/3;
-                                break;
-                        case CUR_LOWER_HALF:
-                                cur_height = height/2;
-                                break;
-                        case CUR_TWO_THIRDS:
-                                cur_height = (height * 2)/3;
-                                break;
-                        case CUR_BLOCK:
-                        default:
-                                cur_height = height;
-                                break;
-                }
-	size = (height - cur_height) * w;
-                while (size--)
-                        mask[i++] = 0;
-                size = cur_height * w;
-                while (size--)
-                        mask[i++] = 0xff;
-        }
-
-        cursor->image.width = width;
-        cursor->image.height = height;
-        cursor->image.dx = vc->vc_x * width;
-        cursor->image.dy = yy * height;
-        cursor->image.depth = 1;
-        cursor->image.data = image;
-        cursor->image.bg_color = bgcolor;
-        cursor->image.fg_color = fgcolor;
-        cursor->mask = mask;
-        cursor->dest = dest;
-        cursor->rop = ROP_XOR;
+	if (cursor->set & FB_CUR_SETSHAPE) {
+		switch (priv->shape) {
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
 
-        if (info->fbops->fb_cursor)
-                info->fbops->fb_cursor(info, cursor);
+		size = (height - cur_height) * w;
+		while (size--)
+			priv->mask[i++] = 0;
+		size = cur_height * w;
+		while (size--)
+			priv->mask[i++] = 0xff;
+	}
+	
+	cursor->image = priv->cursor.image;
+	cursor->image.data = priv->image;
+	cursor->dest = priv->dest;
+	cursor->mask = priv->mask;
+	cursor->rop = ROP_XOR;
+	info->fbops->fb_cursor(info, cursor);
 }
 	
 static void fbcon_cursor(struct vc_data *vc, int mode)
@@ -1138,6 +1151,7 @@
 	}
 }
 
+	
 static int scrollback_phys_max = 0;
 static int scrollback_max = 0;
 static int scrollback_current = 0;
diff -Naur linux-2.5.66-orig/drivers/video/console/fbcon.h linux-2.5.66/drivers/video/console/fbcon.h
--- linux-2.5.66-orig/drivers/video/console/fbcon.h	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/console/fbcon.h	2003-03-27 03:09:09.000000000 +0000
@@ -36,6 +36,15 @@
 };
 
 /* drivers/video/console/fbcon.c */
+ 
+struct fbcon_private {
+	struct fb_cursor cursor;
+	__u8  image[64];
+	__u8  mask[64];
+	__u8 *dest;
+	__u32 shape;
+};
+
 extern char con2fb_map[MAX_NR_CONSOLES];
 extern void set_con2fb_map(int unit, int newidx);
 
diff -Naur linux-2.5.66-orig/drivers/video/fbmem.c linux-2.5.66/drivers/video/fbmem.c
--- linux-2.5.66-orig/drivers/video/fbmem.c	2003-03-27 03:06:10.000000000 +0000
+++ linux-2.5.66/drivers/video/fbmem.c	2003-03-27 03:25:41.000000000 +0000
@@ -456,8 +456,7 @@
 	u32 align = info->pixmap.buf_align - 1;
 	u32 offset, count = 1000;
 
-	spin_lock_irqsave(&info->pixmap.lock,
-			  info->pixmap.lock_flags);
+	spin_lock(&info->pixmap.lock);
 	offset = info->pixmap.offset + align;
 	offset &= ~align;
 	if (offset + size > info->pixmap.size) {
@@ -472,8 +471,7 @@
 	atomic_inc(&info->pixmap.count);	
 	smp_mb__after_atomic_inc();
 
-	spin_unlock_irqrestore(&info->pixmap.lock,
-			       info->pixmap.lock_flags);
+	spin_unlock_irqrestore(&info->pixmap.lock);
 	return offset;
 }
 
@@ -584,20 +582,6 @@
 				}
 			}
 		break;
-	case ~1:
-		xor = 0xff;
-	case 1:
-		for (i = 0; i < logo->height; i++) {
-			shift = 7;
-			d = *src++ ^ xor;
-			for (j = 0; j < logo->width; j++) {
-				*dst++ = (d >> shift) & 1;
-				shift = (shift-1) & 7;
-				if (shift == 7)
-					d = *src++ ^ xor;
-			}
-		}
-		break;
 	}
 }
 
@@ -619,13 +603,13 @@
  * The number of colors just matches the console colors, thus there is no need
  * to set the DAC or the pseudo_palette.  However, the bitmap is packed, ie,
  * each byte contains color information for two pixels (upper and lower nibble).
- * To be consistent with fb_imageblit() usage, we therefore separate the two
- * nibbles into separate bytes. The "depth" flag will be set to 4.
+ * Each 4 bits are expanded to a byte. The "depth" flag will be set to 8.
  *
  * Case 3 - linux_logo_mono:
- * This is similar with Case 2.  Each byte contains information for 8 pixels.
- * We isolate each bit and expand each into a byte. The "depth" flag will
- * be set to 1.
+ * Each byte contains information for 8 pixels.  We just pass the data to 
+ * fb_imageblit unchanged, using the monochrome expansion routine.  In order for
+ * color expansion to work, image->fg_color and image->bg_color must
+ * be properly initialized.  The "depth" flag will be set to 1.
  */
 static struct logo_data {
 	int depth;
@@ -716,18 +700,32 @@
 		}
 		image.data = logo_new;
 		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.depth);
+		image.depth = 8;
 	}
 
 	image.width = fb_logo.logo->width;
 	image.height = fb_logo.logo->height;
 	image.dy = 0;
 
+	/*
+	 * Monochrome expansion and logo drawing functions are the same if
+	 * fb_logo.needs_logo == 1.
+	 */
+	switch (info->fix.visual) {
+	case FB_VISUAL_MONO10:
+		image.fg_color = (u32) (~(~0UL << fb_logo.depth));
+		image.bg_color = 0;
+		break;
+	case FB_VISUAL_MONO01:
+		image.bg_color = (u32) (~(~0UL << fb_logo.depth));
+		image.fg_color = 0;
+		break;
+	}
+
 	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;
 		info->fbops->fb_imageblit(info, &image);
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
 	}
 	
 	if (palette != NULL)
diff -Naur linux-2.5.66-orig/drivers/video/softcursor.c linux-2.5.66/drivers/video/softcursor.c
--- linux-2.5.66-orig/drivers/video/softcursor.c	2003-03-27 03:06:10.000000000 +0000
+++ linux-2.5.66/drivers/video/softcursor.c	2003-03-27 03:09:09.000000000 +0000
@@ -19,46 +19,53 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	int i, size = ((cursor->image.width + 7) / 8) * cursor->image.height;
 	struct fb_image image;
-	static char data[64];
+	unsigned int scan_align = info->pixmap.scan_align - 1;
+	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int i, size, dsize, s_pitch, d_pitch;
+	u8 *dst, src[64];
+
+	s_pitch = (cursor->image.width + 7) >> 3;
+	dsize = s_pitch * cursor->image.height;
+	d_pitch = (s_pitch + scan_align) & ~scan_align;
+	size = d_pitch * cursor->image.height + buf_align;
+	size &= ~buf_align;
+	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
 
 	if (cursor->enable) {
 		switch (cursor->rop) {
 		case ROP_XOR:
-			for (i = 0; i < size; i++)
-				data[i] = (cursor->image.data[i] &
-					   cursor->mask[i]) ^
-				    	   cursor->dest[i];
+			for (i = 0; i < dsize; i++) {
+				src[i] = (cursor->image.data[i] &
+					  cursor->mask[i]) ^
+				    	  cursor->dest[i];
+			}
 			break;
 		case ROP_COPY:
 		default:
-			for (i = 0; i < size; i++)
-				data[i] =
-				    cursor->image.data[i] & cursor->mask[i];
+			for (i = 0; i < dsize; i++) {
+				src[i] = cursor->image.data[i] &
+				    	 cursor->mask[i];
+			}
 			break;
 		}
-	} else
-		memcpy(data, cursor->dest, size);
-
-	image.bg_color = cursor->image.bg_color;
-	image.fg_color = cursor->image.fg_color;
-	image.dx = cursor->image.dx;
-	image.dy = cursor->image.dy;
-	image.width = cursor->image.width;
-	image.height = cursor->image.height;
-	image.depth = cursor->image.depth;
-	image.data = data;
-
-	if (info->fbops->fb_imageblit)
-		info->fbops->fb_imageblit(info, &image);
+		move_buf_aligned(info, dst, src, d_pitch, s_pitch,
+				 cursor->image.height);
+	} else {
+		move_buf_aligned(info, dst, cursor->dest, d_pitch, s_pitch,
+				 cursor->image.height);
+	}
+	image = cursor->image;
+	image.data = dst;
+	info->fbops->fb_imageblit(info, &image);
 	atomic_dec(&info->pixmap.count);
-	smp_mb__after_atomic_dec();	
+	smp_mb__after_atomic_dec();
+	
 	return 0;
 }
 
 EXPORT_SYMBOL(soft_cursor);
- 
+
 MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
 MODULE_DESCRIPTION("Generic software cursor");
 MODULE_LICENSE("GPL");
diff -Naur linux-2.5.66-orig/include/linux/fb.h linux-2.5.66/include/linux/fb.h
--- linux-2.5.66-orig/include/linux/fb.h	2003-03-27 03:06:10.000000000 +0000
+++ linux-2.5.66/include/linux/fb.h	2003-03-27 03:09:09.000000000 +0000
@@ -312,8 +312,8 @@
 #define FB_CUR_SETSHAPE 0x10
 #define FB_CUR_SETSIZE	0x20
 #define FB_CUR_SETDEST	0x40
+#define FB_CUR_SETFLASH 0x80
 #define FB_CUR_SETALL   0xFF
-
 struct fbcurpos {
 	__u16 x, y;
 };
@@ -342,8 +342,7 @@
 	__u32 flags;                      /* see FB_PIXMAP_*               */
 	void (*outbuf)(u8 dst, u8 *addr); /* access methods                */
 	u8   (*inbuf) (u8 *addr);
-	unsigned long lock_flags;         /* flags for locking             */
-	spinlock_t lock;                  /* spinlock                      */
+	spinlock_t lock;
 	atomic_t count;
 };
 #ifdef __KERNEL__
@@ -406,15 +405,15 @@
    struct fb_var_screeninfo var;        /* Current var */
    struct fb_fix_screeninfo fix;        /* Current fix */
    struct fb_monspecs monspecs;         /* Current Monitor specs */
-   struct fb_cursor cursor;		/* Current cursor */	
-   struct work_struct queue;		/* Framebuffer event queue */
-   struct fb_pixmap pixmap;	        /* Current pixmap */
    struct fb_cmap cmap;                 /* Current cmap */
+   struct work_struct queue;           /* Framebuffer event queue */
+   struct fb_pixmap pixmap;	        /* Current pixmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */	
    void *pseudo_palette;                /* Fake palette of 16 colors */ 
+   void *fbcon_priv;                    /* console-related private structure */
    /* From here on everything is device dependent */
    void *par;	
 };





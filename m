Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUIIVo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUIIVo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIIVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:44:28 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:27615 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267625AbUIIVep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:45 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/7] fbdev: Add Tile Blitting support
Date: Fri, 10 Sep 2004 05:34:56 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100534.56680.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully, this patch fixes one last major regression for one particular
driver, namely matroxfb. This drier has  2 versions, one for the kernel and
another as a '2.4 backport' patch.

This patch adds a tileblitting extension to fbcon. This extension, in
summary, is basically a forward-port of the 2.4 fbdev/fbcon framework to 2.6
but without the fbcon dependency. Tile blitting is similar to bitblit,
except that the basic unit is a tile (a bitmap of x-by-y dimensions).  The
display, instead of being described in terms of pixels and scanlines, are
described as a region further subdivided into rectangular sections. In fbcon
parlance, a tile is a character.

Besides a possible fix for matroxfb, tileblitting can be advantageous for
hardware that supports some kind of fontcaching mechanism.  Also, in the
unlikely chance that the console begins supporting multicolored fonts,
tileblitting is probably more optimal than bitblitting because bitblitting
will need to push more data through the bus.

To enable support for this extension, a driver needs to:

- enable CONFIG_FB_TILEBLITTING
- set FBINFO_MISC_TILEBLITTING in info->flags
- set the required function pointers in struct fb_tileops.  The required
  operations are:

  - void (*fb_settile)(struct fb_info *info, struct fb_tilemap *map);

    tells driver about the tile characteristics (dimensions, bitdepth) and
    about the tilemap which is an array of bitmaps: display->fontdata

  - void (*fb_tilecopy)(struct fb_info *info, struct fb_tilearea *area);
 
    move a rectangular section of tiles (bmove)

  - void (*fb_tilefill)(struct fb_info *info, struct fb_tilerect *rect);

    fill a rectangular section with a tile (clear)

  - void (*fb_tileblit)(struct fb_info *info, struct fb_tileblit *blit);

    copy an array of tiles to a rectangular section (putcs)

  - void (*fb_tilecursor)(struct fb_info *info, struct fb_tilecursor *cursor);

    cursor function

Changes:

Addition of this extension necessitates cleanup of fbcon.c. The basic
drawing functions in fbcon are bmove, clear, putcs and cursor (the fbcon_* 
set). The fbcon_* set are just wrappers to accel_* set.  However, usage is
not consistent, some functions call the fbcon_* set, others call the accel_*
set.

With this patch, a new fbcon-specific structure (struct fbcon_ops) is
created. Depending on the setting of the hardware, this struct contains
pointers to either the tileblitting set or the bitblitting set (formerly the
accel_* set). The tileblitting set is new in this patch.

The vast majority of functions in fbcon will need to only call the fbcon_*
set. In turn, it calls functions in struct fbcon_ops. Knowledge of the
blitting type is not required. 

The accel_* set is renamed to bit_* and is moved into a separate file,
bitblit.c. The tile blitting set is in tileblit.c.

In my case at least, the cleanup did produce an unexpected but beneficial
side effect, a little more speedup.  Not much, < 5%.

Petr, if you have comments, suggestions, or you think this is a bad idea,
let me know.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig            |   18 +
 drivers/video/console/Makefile   |    3
 drivers/video/console/bitblit.c  |  370 ++++++++++++++++++++++
 drivers/video/console/fbcon.c    |  637 +++++++++++----------------------------
 drivers/video/console/fbcon.h    |   26 +
 drivers/video/console/tileblit.c |  146 ++++++++
 drivers/video/fbmem.c            |    4
 include/linux/fb.h               |   83 +++++
 8 files changed, 842 insertions(+), 445 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/bitblit.c linux-2.6.9-rc1-mm4/drivers/video/console/bitblit.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/bitblit.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/bitblit.c	2004-09-10 05:01:35.541297496 +0800
@@ -0,0 +1,370 @@
+/*
+ *  linux/drivers/video/console/bitblit.c -- BitBlitting Operation
+ *
+ *  Originally from the 'accel_*' routines in drivers/video/console/fbcon.c
+ *
+ *      Copyright (C) 2004 Antonino Daplas <adaplas @pol.net>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/vt_kern.h>
+#include <linux/console.h>
+#include <asm/types.h>
+#include "fbcon.h"
+
+/*
+ * Accelerated handlers.
+ */
+#define FBCON_ATTRIBUTE_UNDERLINE 1
+#define FBCON_ATTRIBUTE_REVERSE   2
+#define FBCON_ATTRIBUTE_BOLD      4
+
+static inline int real_y(struct display *p, int ypos)
+{
+	int rows = p->vrows;
+
+	ypos += p->yscroll;
+	return ypos < rows ? ypos : ypos - rows;
+}
+
+
+static inline int get_attribute(struct fb_info *info, u16 c)
+{
+	int attribute = 0;
+
+	if (fb_get_color_depth(info) == 1) {
+		if (attr_underline(c))
+			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
+		if (attr_reverse(c))
+			attribute |= FBCON_ATTRIBUTE_REVERSE;
+		if (attr_bold(c))
+			attribute |= FBCON_ATTRIBUTE_BOLD;
+	}
+
+	return attribute;
+}
+
+static inline void update_attr(u8 *dst, u8 *src, int attribute,
+			       struct vc_data *vc)
+{
+	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
+	int width = (vc->vc_font.width + 7) >> 3;
+	unsigned int cellsize = vc->vc_font.height * width;
+	u8 c;
+
+	offset = cellsize - (offset * width);
+	for (i = 0; i < cellsize; i++) {
+		c = src[i];
+		if (attribute & FBCON_ATTRIBUTE_UNDERLINE && i >= offset)
+			c = 0xff;
+		if (attribute & FBCON_ATTRIBUTE_BOLD)
+			c |= c >> 1;
+		if (attribute & FBCON_ATTRIBUTE_REVERSE)
+			c = ~c;
+		dst[i] = c;
+	}
+}
+
+static void bit_bmove(struct vc_data *vc, struct fb_info *info, int sy,
+		      int sx, int dy, int dx, int height, int width)
+{
+	struct fb_copyarea area;
+
+	area.sx = sx * vc->vc_font.width;
+	area.sy = sy * vc->vc_font.height;
+	area.dx = dx * vc->vc_font.width;
+	area.dy = dy * vc->vc_font.height;
+	area.height = height * vc->vc_font.height;
+	area.width = width * vc->vc_font.width;
+
+	info->fbops->fb_copyarea(info, &area);
+}
+
+static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
+		      int sx, int height, int width)
+{
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(bgshift, vc);
+	region.dx = sx * vc->vc_font.width;
+	region.dy = sy * vc->vc_font.height;
+	region.width = width * vc->vc_font.width;
+	region.height = height * vc->vc_font.height;
+	region.rop = ROP_COPY;
+
+	info->fbops->fb_fillrect(info, &region);
+}
+
+static void bit_putcs(struct vc_data *vc, struct fb_info *info,
+		      const unsigned short *s, int count, int yy, int xx,
+		      int fg, int bg)
+{
+	void (*move_unaligned)(struct fb_info *info, struct fb_pixmap *buf,
+			       u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+			       u32 height, u32 shift_high, u32 shift_low,
+			       u32 mod);
+	void (*move_aligned)(struct fb_info *info, struct fb_pixmap *buf,
+			     u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+			     u32 height);
+	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int width = (vc->vc_font.width + 7) >> 3;
+	unsigned int cellsize = vc->vc_font.height * width;
+	unsigned int maxcnt = info->pixmap.size/cellsize;
+	unsigned int scan_align = info->pixmap.scan_align - 1;
+	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
+	unsigned int shift_high = 8, pitch, cnt, size, k;
+	unsigned int idx = vc->vc_font.width >> 3;
+	unsigned int attribute = get_attribute(info, scr_readw(s));
+	struct fb_image image;
+	u8 *src, *dst, *buf = NULL;
+
+	if (attribute) {
+		buf = kmalloc(cellsize, GFP_KERNEL);
+		if (!buf)
+			return;
+	}
+
+	image.fg_color = fg;
+	image.bg_color = bg;
+
+	image.dx = xx * vc->vc_font.width;
+	image.dy = yy * vc->vc_font.height;
+	image.height = vc->vc_font.height;
+	image.depth = 1;
+
+	if (info->pixmap.outbuf && info->pixmap.inbuf) {
+		move_aligned = fb_iomove_buf_aligned;
+		move_unaligned = fb_iomove_buf_unaligned;
+	} else {
+		move_aligned = fb_sysmove_buf_aligned;
+		move_unaligned = fb_sysmove_buf_unaligned;
+	}
+	while (count) {
+		if (count > maxcnt)
+			cnt = k = maxcnt;
+		else
+			cnt = k = count;
+
+		image.width = vc->vc_font.width * cnt;
+		pitch = ((image.width + 7) >> 3) + scan_align;
+		pitch &= ~scan_align;
+		size = pitch * image.height + buf_align;
+		size &= ~buf_align;
+		dst = fb_get_buffer_offset(info, &info->pixmap, size);
+		image.data = dst;
+		if (mod) {
+			while (k--) {
+				src = vc->vc_font.data + (scr_readw(s++)&
+							  charmask)*cellsize;
+
+				if (attribute) {
+					update_attr(buf, src, attribute, vc);
+					src = buf;
+				}
+
+				move_unaligned(info, &info->pixmap, dst, pitch,
+					       src, idx, image.height,
+					       shift_high, shift_low, mod);
+				shift_low += mod;
+				dst += (shift_low >= 8) ? width : width - 1;
+				shift_low &= 7;
+				shift_high = 8 - shift_low;
+			}
+		} else {
+			while (k--) {
+				src = vc->vc_font.data + (scr_readw(s++)&
+							  charmask)*cellsize;
+
+				if (attribute) {
+					update_attr(buf, src, attribute, vc);
+					src = buf;
+				}
+
+				move_aligned(info, &info->pixmap, dst, pitch,
+					     src, idx, image.height);
+				dst += width;
+			}
+		}
+		info->fbops->fb_imageblit(info, &image);
+		image.dx += cnt * vc->vc_font.width;
+		count -= cnt;
+	}
+
+	if (buf)
+		kfree(buf);
+}
+
+static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
+			      int bottom_only)
+{
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
+	unsigned int cw = vc->vc_font.width;
+	unsigned int ch = vc->vc_font.height;
+	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
+	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(bgshift, vc);
+	region.rop = ROP_COPY;
+
+	if (rw && !bottom_only) {
+		region.dx = info->var.xoffset + rs;
+		region.dy = 0;
+		region.width = rw;
+		region.height = info->var.yres_virtual;
+		info->fbops->fb_fillrect(info, &region);
+	}
+
+	if (bh) {
+		region.dx = info->var.xoffset;
+		region.dy = info->var.yoffset + bs;
+		region.width = rs;
+		region.height = bh;
+		info->fbops->fb_fillrect(info, &region);
+	}
+}
+
+static void bit_cursor(struct vc_data *vc, struct fb_info *info,
+		       struct display *p, int mode, int fg, int bg)
+{
+	struct fb_cursor cursor;
+	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	int w = (vc->vc_font.width + 7) >> 3, c;
+	int y = real_y(p, vc->vc_y);
+	int attribute;
+	char *src;
+
+ 	c = scr_readw((u16 *) vc->vc_pos);
+	attribute = get_attribute(info, c);
+	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
+	if (attribute) {
+		u8 *dst;
+
+		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
+		if (!dst)
+			return;
+		if (info->cursor.data)
+			kfree(info->cursor.data);
+		info->cursor.data = dst;
+		update_attr(dst, src, attribute, vc);
+		src = dst;
+	}
+
+	cursor.image.data = src;
+	cursor.set = FB_CUR_SETCUR;
+	cursor.image.depth = 1;
+
+	switch (mode) {
+	case CM_ERASE:
+		if (info->cursor.rop == ROP_XOR) {
+			info->cursor.enable = 0;
+			info->cursor.rop = ROP_COPY;
+			info->fbops->fb_cursor(info, &cursor);
+		}
+		break;
+	case CM_MOVE:
+	case CM_DRAW:
+		info->cursor.enable = 1;
+        	info->cursor.rop = ROP_XOR;
+
+		if (info->cursor.image.fg_color != fg ||
+		    info->cursor.image.bg_color != bg) {
+			cursor.image.fg_color = fg;
+			cursor.image.bg_color = bg;
+			cursor.set |= FB_CUR_SETCMAP;
+		}
+
+		if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
+		    (info->cursor.image.dy != (vc->vc_font.height * y))) {
+			cursor.image.dx = vc->vc_font.width * vc->vc_x;
+			cursor.image.dy = vc->vc_font.height * y;
+			cursor.set |= FB_CUR_SETPOS;
+		}
+
+		if (info->cursor.image.height != vc->vc_font.height ||
+		    info->cursor.image.width != vc->vc_font.width) {
+			cursor.image.height = vc->vc_font.height;
+			cursor.image.width = vc->vc_font.width;
+			cursor.set |= FB_CUR_SETSIZE;
+		}
+
+		if (info->cursor.hot.x || info->cursor.hot.y) {
+			cursor.hot.x = cursor.hot.y = 0;
+			cursor.set |= FB_CUR_SETHOT;
+		}
+
+		if ((cursor.set & FB_CUR_SETSIZE) ||
+		    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
+		    || info->cursor.mask == NULL) {
+			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
+			int cur_height, size, i = 0;
+			u8 msk = 0xff;
+
+			if (!mask)
+				return;
+
+			if (info->cursor.mask)
+				kfree(info->cursor.mask);
+			info->cursor.mask = mask;
+			p->cursor_shape = vc->vc_cursor_type & 0x0f;
+			cursor.set |= FB_CUR_SETSHAPE;
+
+			switch (vc->vc_cursor_type & 0x0f) {
+			case CUR_NONE:
+				cur_height = 0;
+				break;
+			case CUR_UNDERLINE:
+				cur_height = (vc->vc_font.height < 10) ? 1 : 2;
+				break;
+			case CUR_LOWER_THIRD:
+				cur_height = vc->vc_font.height/3;
+				break;
+			case CUR_LOWER_HALF:
+				cur_height = vc->vc_font.height >> 1;
+				break;
+			case CUR_TWO_THIRDS:
+				cur_height = (vc->vc_font.height << 1)/3;
+				break;
+			case CUR_BLOCK:
+			default:
+				cur_height = vc->vc_font.height;
+				break;
+			}
+			size = (vc->vc_font.height - cur_height) * w;
+			while (size--)
+				mask[i++] = ~msk;
+			size = cur_height * w;
+			while (size--)
+				mask[i++] = msk;
+		}
+		info->fbops->fb_cursor(info, &cursor);
+		break;
+	}
+}
+
+void fbcon_set_bitops(struct fbcon_ops *ops)
+{
+	ops->bmove = bit_bmove;
+	ops->clear = bit_clear;
+	ops->putcs = bit_putcs;
+	ops->clear_margins = bit_clear_margins;
+	ops->cursor = bit_cursor;
+}
+
+EXPORT_SYMBOL(fbcon_set_bitops);
+
+MODULE_AUTHOR("Antonino Daplas <adaplas@pol.net>");
+MODULE_DESCRIPTION("Bit Blitting Operation");
+MODULE_LICENSE("GPL");
+
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c	2004-09-10 04:59:19.625959768 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c	2004-09-10 05:01:35.546296736 +0800
@@ -120,13 +120,7 @@ static int fbcon_is_default = 1; 
 static char fontname[40];
 
 /* current fb_info */
-static int info_idx =  -1;
-
-#define REFCOUNT(fd)	(((int *)(fd))[-1])
-#define FNTSIZE(fd)	(((int *)(fd))[-2])
-#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
-#define FNTSUM(fd)	(((int *)(fd))[-4])
-#define FONT_EXTRA_WORDS 4
+static int info_idx = -1;
 
 #define CM_SOFTBACK	(8)
 
@@ -159,6 +153,7 @@ static void fbcon_clear(struct vc_data *
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos);
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos);
+static void fbcon_clear_margins(struct vc_data *vc, int bottom_only);
 static void fbcon_cursor(struct vc_data *vc, int mode);
 static int fbcon_scroll(struct vc_data *vc, int t, int b, int dir,
 			int count);
@@ -168,9 +163,6 @@ static int fbcon_switch(struct vc_data *
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch);
 static int fbcon_set_palette(struct vc_data *vc, unsigned char *table);
 static int fbcon_scrolldelta(struct vc_data *vc, int lines);
-void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
-			 int bottom_only);
-
 
 /*
  *  Internal routines
@@ -200,21 +192,69 @@ static irqreturn_t fb_vbl_detect(int irq
 }
 #endif
 
+static inline int get_color(struct vc_data *vc, struct fb_info *info,
+	      u16 c, int is_fg)
+{
+	int depth = fb_get_color_depth(info);
+	int color = 0;
+
+	if (depth != 1)
+		color = (is_fg) ? attr_fgcol((vc->vc_hi_font_mask) ? 9 : 8, c)
+			: attr_bgcol((vc->vc_hi_font_mask) ? 13 : 12, c);
+
+	switch (depth) {
+	case 1:
+	{
+		/* 0 or 1 */
+		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? 1 : 0;
+		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : 1;
+
+		color = (is_fg) ? fg : bg;
+		break;
+	}
+	case 2:
+		/*
+		 * Scale down 16-colors to 4 colors. Default 4-color palette
+		 * is grayscale.
+		 */
+		color /= 4;
+		break;
+	case 3:
+		/*
+		 * Last 8 entries of default 16-color palette is a more intense
+		 * version of the first 8 (i.e., same chrominance, different
+		 * luminance).
+		 */
+		color &= 7;
+		break;
+	}
+
+	return color;
+}
+
 static void fb_flashcursor(void *private)
 {
 	struct fb_info *info = (struct fb_info *) private;
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct display *p;
 	struct vc_data *vc = NULL;
+	int c;
+	int mode;
 
 	if (info->currcon != -1)
 		vc = vc_cons[info->currcon].d;
 
 	if (info->state != FBINFO_STATE_RUNNING ||
-	    info->cursor.rop == ROP_COPY || !vc || !CON_IS_VISIBLE(vc)
-	    || registered_fb[(int) con2fb_map[vc->vc_num]] != info)
+	    !vc || !CON_IS_VISIBLE(vc) || !info->cursor.flash ||
+	    vt_cons[vc->vc_num]->vc_mode != KD_TEXT ||
+ 	    registered_fb[(int) con2fb_map[vc->vc_num]] != info)
 		return;
+	p = &fb_display[vc->vc_num];
+	c = scr_readw((u16 *) vc->vc_pos);
 	acquire_console_sem();
-	info->cursor.enable ^= 1;
-	info->fbops->fb_cursor(info, &info->cursor);
+	mode = (info->cursor.enable) ? CM_ERASE : CM_DRAW;
+	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
+		    get_color(vc, info, c, 0));
 	release_console_sem();
 }
 
@@ -349,7 +389,6 @@ static void fbcon_prepare_logo(struct vc
 	int cnt, erase = vc->vc_video_erase_char, step;
 	unsigned short *save = NULL, *r, *q;
 
-
 	/*
 	 * remove underline attribute from erase character
 	 * if black and white framebuffer.
@@ -393,9 +432,10 @@ static void fbcon_prepare_logo(struct vc
 		    vc->vc_size_row * logo_lines);
 
 	if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
-		accel_clear_margins(vc, info, 0);
+		fbcon_clear_margins(vc, 0);
 		update_screen(vc->vc_num);
 	}
+
 	if (save) {
 		q = (unsigned short *) (vc->vc_origin +
 					vc->vc_size_row *
@@ -405,6 +445,7 @@ static void fbcon_prepare_logo(struct vc
 		vc->vc_pos += logo_lines * vc->vc_size_row;
 		kfree(save);
 	}
+
 	if (logo_lines > vc->vc_bottom) {
 		logo_shown = -1;
 		printk(KERN_INFO
@@ -415,6 +456,28 @@ static void fbcon_prepare_logo(struct vc
 	}
 }
 
+#ifdef CONFIG_FB_TILEBLITTING
+static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
+			      struct display *p)
+{
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+
+	if ((info->flags & FBINFO_MISC_TILEBLITTING))
+		fbcon_set_tileops(vc, info, p, ops);
+	else
+		fbcon_set_bitops(ops);
+}
+#else
+static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
+			      struct display *p)
+{
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+
+	info->flags &= ~FBINFO_MISC_TILEBLITTING;
+	fbcon_set_bitops(ops);
+}
+#endif /* CONFIG_MISC_TILEBLITTING */
+
 /**
  *	set_con2fb_map - map console to frame buffer device
  *	@unit: virtual console number to map
@@ -450,17 +513,35 @@ static int set_con2fb_map(int unit, int 
 
 	acquire_console_sem();
 	con2fb_map[unit] = newidx;
+
 	if (!found) {
+		struct fbcon_ops *ops = NULL;
+		int err = 0;
 		if (!try_module_get(info->fbops->owner)) {
-			con2fb_map[unit] = oldidx;
-			release_console_sem();
-			return -ENODEV;
+			err = -ENODEV;
 		}
-		if (info->fbops->fb_open && info->fbops->fb_open(info, 0)) {
-			module_put(info->fbops->owner);
+
+		if (!err && info->fbops->fb_open &&
+		    info->fbops->fb_open(info, 0)) {
+			err = -ENODEV;
+		}
+
+		if (!err) {
+			ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+			if (!ops)
+				err = -ENOMEM;
+		}
+
+		if (!err) {
+			info->fbcon_par = ops;
+			set_blitting_type(vc, info, NULL);
+		}
+
+		if (err) {
 			con2fb_map[unit] = oldidx;
+			module_put(info->fbops->owner);
 			release_console_sem();
-			return -ENODEV;
+			return err;
 		}
 	}
 
@@ -479,8 +560,11 @@ static int set_con2fb_map(int unit, int 
 			release_console_sem();
 			return -ENODEV;
 		}
+
 		if (oldinfo->queue.func == fb_flashcursor)
 			del_timer_sync(&oldinfo->cursor_timer);
+
+		kfree(oldinfo->fbcon_par);
 		module_put(oldinfo->fbops->owner);
 	}
 
@@ -522,252 +606,6 @@ static int set_con2fb_map(int unit, int 
 }
 
 /*
- * Accelerated handlers.
- */
-static inline int get_color(struct vc_data *vc, struct fb_info *info,
-			    u16 c, int is_fg)
-{
-	int depth = fb_get_color_depth(info);
-	int color = 0;
-
-	if (depth != 1)
-		color = (is_fg) ? attr_fgcol((vc->vc_hi_font_mask) ? 9 : 8, c)
-			: attr_bgcol((vc->vc_hi_font_mask) ? 13 : 12, c);
-
-	switch (depth) {
-	case 1:
-	{
-		/* 0 or 1 */
-		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? 1 : 0;
-		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : 1;
-
-		color = (is_fg) ? fg : bg;
-		break;
-	}
-	case 2:
-		/*
-		 * Scale down 16-colors to 4 colors. Default 4-color palette
-		 * is grayscale.
-		 */
-		color /= 4;
-		break;
-	case 3:
-		/*
-		 * Last 8 entries of default 16-color palette is a more intense
-		 * version of the first 8 (i.e., same chrominance, different
-		 * luminance).
-		 */
-		color &= 7;
-		break;
-	}
-
-	return color;
-}
-
-#define FBCON_ATTRIBUTE_UNDERLINE 1
-#define FBCON_ATTRIBUTE_REVERSE   2
-#define FBCON_ATTRIBUTE_BOLD      4
-
-static inline int get_attribute(struct fb_info *info, u16 c)
-{
-	int attribute = 0;
-
-	if (fb_get_color_depth(info) == 1) {
-		if (attr_underline(c))
-			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
-		if (attr_reverse(c))
-			attribute |= FBCON_ATTRIBUTE_REVERSE;
-		if (attr_bold(c))
-			attribute |= FBCON_ATTRIBUTE_BOLD;
-	}
-
-	return attribute;
-}
-
-static inline void update_attr(u8 *dst, u8 *src, int attribute,
-			       struct vc_data *vc)
-{
-	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
-	int width = (vc->vc_font.width + 7) >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	u8 c;
-
-	offset = cellsize - (offset * width);
-	for (i = 0; i < cellsize; i++) {
-		c = src[i];
-		if (attribute & FBCON_ATTRIBUTE_UNDERLINE && i >= offset)
-			c = 0xff;
-		if (attribute & FBCON_ATTRIBUTE_BOLD)
-			c |= c >> 1;
-		if (attribute & FBCON_ATTRIBUTE_REVERSE)
-			c = ~c;
-		dst[i] = c;
-	}
-}
-
-void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy, 
-		int sx, int dy, int dx, int height, int width)
-{
-	struct fb_copyarea area;
-
-	area.sx = sx * vc->vc_font.width;
-	area.sy = sy * vc->vc_font.height;
-	area.dx = dx * vc->vc_font.width;
-	area.dy = dy * vc->vc_font.height;
-	area.height = height * vc->vc_font.height;
-	area.width = width * vc->vc_font.width;
-
-	info->fbops->fb_copyarea(info, &area);
-}
-
-void accel_clear(struct vc_data *vc, struct fb_info *info, int sy,
-			int sx, int height, int width)
-{
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	struct fb_fillrect region;
-
-	region.color = attr_bgcol_ec(bgshift, vc);
-	region.dx = sx * vc->vc_font.width;
-	region.dy = sy * vc->vc_font.height;
-	region.width = width * vc->vc_font.width;
-	region.height = height * vc->vc_font.height;
-	region.rop = ROP_COPY;
-
-	info->fbops->fb_fillrect(info, &region);
-}	
-
-void accel_putcs(struct vc_data *vc, struct fb_info *info,
-		 const unsigned short *s, int count, int yy, int xx)
-{
-	void (*move_unaligned)(struct fb_info *info, struct fb_pixmap *buf,
-			       u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			       u32 height, u32 shift_high, u32 shift_low,
-			       u32 mod);
-	void (*move_aligned)(struct fb_info *info, struct fb_pixmap *buf,
-			     u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			     u32 height);
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = (vc->vc_font.width + 7) >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
-	unsigned int shift_high = 8, pitch, cnt, size, k;
-	unsigned int idx = vc->vc_font.width >> 3;
-	unsigned int attribute = get_attribute(info, scr_readw(s));
-	struct fb_image image;
-	u8 *src, *dst, *buf = NULL;
-
-	if (attribute) {
-		buf = kmalloc(cellsize, GFP_KERNEL);
-		if (!buf)
-			return;
-	}
-
-	image.fg_color = get_color(vc, info, scr_readw(s), 1);
-	image.bg_color = get_color(vc, info, scr_readw(s), 0);
-
-	image.dx = xx * vc->vc_font.width;
-	image.dy = yy * vc->vc_font.height;
-	image.height = vc->vc_font.height;
-	image.depth = 1;
-
-	if (info->pixmap.outbuf && info->pixmap.inbuf) {
-		move_aligned = fb_iomove_buf_aligned;
-		move_unaligned = fb_iomove_buf_unaligned;
-	} else {
-		move_aligned = fb_sysmove_buf_aligned;
-		move_unaligned = fb_sysmove_buf_unaligned;
-	}
-	while (count) {
-		if (count > maxcnt)
-			cnt = k = maxcnt;
-		else
-			cnt = k = count;
-
-		image.width = vc->vc_font.width * cnt;
-		pitch = ((image.width + 7) >> 3) + scan_align;
-		pitch &= ~scan_align;
-		size = pitch * image.height + buf_align;
-		size &= ~buf_align;
-		dst = fb_get_buffer_offset(info, &info->pixmap, size);
-		image.data = dst;
-		if (mod) {
-			while (k--) {
-				src = vc->vc_font.data + (scr_readw(s++)&
-							  charmask)*cellsize;
-
-				if (attribute) {
-					update_attr(buf, src, attribute, vc);
-					src = buf;
-				}
-
-				move_unaligned(info, &info->pixmap, dst, pitch,
-					       src, idx, image.height,
-					       shift_high, shift_low, mod);
-				shift_low += mod;
-				dst += (shift_low >= 8) ? width : width - 1;
-				shift_low &= 7;
-				shift_high = 8 - shift_low;
-			}
-		} else {
-			while (k--) {
-				src = vc->vc_font.data + (scr_readw(s++)&
-							  charmask)*cellsize;
-
-				if (attribute) {
-					update_attr(buf, src, attribute, vc);
-					src = buf;
-				}
-
-				move_aligned(info, &info->pixmap, dst, pitch,
-					     src, idx, image.height);
-				dst += width;
-			}
-		}
-		info->fbops->fb_imageblit(info, &image);
-		image.dx += cnt * vc->vc_font.width;
-		count -= cnt;
-	}
-
-	if (buf)
-		kfree(buf);
-}
-
-void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
-				int bottom_only)
-{
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	unsigned int cw = vc->vc_font.width;
-	unsigned int ch = vc->vc_font.height;
-	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
-	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
-	unsigned int rs = info->var.xres - rw;
-	unsigned int bs = info->var.yres - bh;
-	struct fb_fillrect region;
-
-	region.color = attr_bgcol_ec(bgshift, vc);
-	region.rop = ROP_COPY;
-
-	if (rw && !bottom_only) {
-		region.dx = info->var.xoffset + rs;
-		region.dy = 0;
-		region.width = rw;
-		region.height = info->var.yres_virtual;
-		info->fbops->fb_fillrect(info, &region);
-	}
-
-	if (bh) {
-		region.dx = info->var.xoffset;
-		region.dy = info->var.yoffset + bs;
-		region.width = rs;
-		region.height = bh;
-		info->fbops->fb_fillrect(info, &region);
-	}	
-}	
-
-/*
  *  Low Level Operations
  */
 /* NOTE: fbcon cannot be __init: it may be called from take_over_console later */
@@ -820,6 +658,7 @@ static const char *fbcon_startup(void)
 	struct font_desc *font = NULL;
 	struct module *owner;
 	struct fb_info *info = NULL;
+	struct fbcon_ops *ops;
 	int rows, cols;
 	int irqres;
 
@@ -846,6 +685,16 @@ static const char *fbcon_startup(void)
 		module_put(owner);
 		return NULL;
 	}
+
+	ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+	if (!ops) {
+		module_put(owner);
+		return NULL;
+	}
+
+	info->fbcon_par = ops;
+	set_blitting_type(vc, info, NULL);
+
 	if (info->fix.type != FB_TYPE_TEXT) {
 		if (fbcon_softback_size) {
 			if (!softback_buf) {
@@ -875,7 +724,7 @@ static const char *fbcon_startup(void)
 	if (!p->fontdata) {
 		if (!fontname[0] || !(font = find_font(fontname)))
 			font = get_default_font(info->var.xres,
-						   info->var.yres);
+						info->var.yres);
 		vc->vc_font.width = font->width;
 		vc->vc_font.height = font->height;
 		vc->vc_font.data = p->fontdata = font->data;
@@ -1010,6 +859,7 @@ static void fbcon_init(struct vc_data *v
 		if (vc->vc_can_do_color)
 			vc->vc_complement_mask <<= 1;
 	}
+
 	cols = vc->vc_cols;
 	rows = vc->vc_rows;
 	new_cols = info->var.xres / vc->vc_font.width;
@@ -1073,7 +923,7 @@ static void fbcon_deinit(struct vc_data 
  *  This system is now divided into two levels because of complications
  *  caused by hardware scrolling. Top level functions:
  *
- *	fbcon_bmove(), fbcon_clear(), fbcon_putc()
+ *	fbcon_bmove(), fbcon_clear(), fbcon_putc(), fbcon_clear_margins()
  *
  *  handles y values in range [0, scr_height-1] that correspond to real
  *  screen positions. y_wrap shift means that first line of bitmap may be
@@ -1104,7 +954,8 @@ static void fbcon_clear(struct vc_data *
 			int width)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+
 	struct display *p = &fb_display[vc->vc_num];
 	u_int y_break;
 
@@ -1121,11 +972,11 @@ static void fbcon_clear(struct vc_data *
 	y_break = p->vrows - p->yscroll;
 	if (sy < y_break && sy + height - 1 >= y_break) {
 		u_int b = y_break - sy;
-		accel_clear(vc, info, real_y(p, sy), sx, b, width);
-		accel_clear(vc, info, real_y(p, sy + b), sx, height - b,
+		ops->clear(vc, info, real_y(p, sy), sx, b, width);
+		ops->clear(vc, info, real_y(p, sy + b), sx, height - b,
 				 width);
 	} else
-		accel_clear(vc, info, real_y(p, sy), sx, height, width);
+		ops->clear(vc, info, real_y(p, sy), sx, height, width);
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
@@ -1133,6 +984,7 @@ static void fbcon_putcs(struct vc_data *
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
@@ -1142,7 +994,9 @@ static void fbcon_putcs(struct vc_data *
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
 
-	accel_putcs(vc, info, s, count, real_y(p, ypos), xpos);
+	ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
+		   get_color(vc, info, scr_readw(s), 1),
+		   get_color(vc, info, scr_readw(s), 0));
 }
 
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
@@ -1150,137 +1004,39 @@ static void fbcon_putc(struct vc_data *v
 	fbcon_putcs(vc, (const unsigned short *) &c, 1, ypos, xpos);
 }
 
+static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
+{
+	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+
+	ops->clear_margins(vc, info, bottom_only);
+}
+
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
-	struct fb_cursor cursor;
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
-	int w = (vc->vc_font.width + 7) >> 3, c;
-	int y = real_y(p, vc->vc_y), fg, bg;
-	int attribute;
-	u8 *src;
+	int y = real_y(p, vc->vc_y);
+ 	int c = scr_readw((u16 *) vc->vc_pos);
 
+	info->cursor.flash = 1;
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
 		if (softback_lines) {
-			if (y + softback_lines >= vc->vc_rows)
+			if (y + softback_lines >= vc->vc_rows) {
 				mode = CM_ERASE;
+				info->cursor.flash = 0;
+			}
 			else
 				y += softback_lines;
 		}
 	} else if (softback_lines)
 		fbcon_set_origin(vc);
 
- 	c = scr_readw((u16 *) vc->vc_pos);
-	attribute = get_attribute(info, c);
-	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
-	if (attribute) {
-		u8 *dst;
-
-		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
-		if (!dst)
-			return;
-		if (info->cursor.data)
-			kfree(info->cursor.data);
-		info->cursor.data = dst;
-		update_attr(dst, src, attribute, vc);
-		src = dst;
-	}
-
-	cursor.image.data = src;
-	cursor.set = FB_CUR_SETCUR;
-	cursor.image.depth = 1;
-	
-	switch (mode) {
-	case CM_ERASE:
-		if (info->cursor.rop == ROP_XOR) {
-			info->cursor.enable = 0;
-			info->cursor.rop = ROP_COPY;
-			info->fbops->fb_cursor(info, &cursor);
-		}	
-		break;
-	case CM_MOVE:
-	case CM_DRAW:
-		info->cursor.enable = 1;
-		fg = get_color(vc, info, c, 1);
-		bg = get_color(vc, info, c, 0);
-
-		if (info->cursor.image.fg_color != fg ||
-		    info->cursor.image.bg_color != bg) {
-			cursor.image.fg_color = fg;
-			cursor.image.bg_color = bg;
-			cursor.set |= FB_CUR_SETCMAP;
-		}
-		
-		if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
-		    (info->cursor.image.dy != (vc->vc_font.height * y))) {
-			cursor.image.dx = vc->vc_font.width * vc->vc_x;
-			cursor.image.dy = vc->vc_font.height * y;
-			cursor.set |= FB_CUR_SETPOS;
-		}
-
-		if (info->cursor.image.height != vc->vc_font.height ||
-		    info->cursor.image.width != vc->vc_font.width) {
-			cursor.image.height = vc->vc_font.height;
-			cursor.image.width = vc->vc_font.width;
-			cursor.set |= FB_CUR_SETSIZE;
-		}
-
-		if (info->cursor.hot.x || info->cursor.hot.y) {
-			cursor.hot.x = cursor.hot.y = 0;
-			cursor.set |= FB_CUR_SETHOT;
-		}
-
-		if ((cursor.set & FB_CUR_SETSIZE) ||
-		    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
-		    || info->cursor.mask == NULL) {
-			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
-			int cur_height, size, i = 0;
-			u8 msk = 0xff;
-
-			if (!mask)
-				return;
-		
-			if (info->cursor.mask)
-				kfree(info->cursor.mask);
-			info->cursor.mask = mask;
-			p->cursor_shape = vc->vc_cursor_type & 0x0f;
-			cursor.set |= FB_CUR_SETSHAPE;
-
-			switch (vc->vc_cursor_type & 0x0f) {
-			case CUR_NONE:
-				cur_height = 0;
-				break;
-			case CUR_UNDERLINE:
-				cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-				break;
-			case CUR_LOWER_THIRD:
-				cur_height = vc->vc_font.height/3;
-				break;
-			case CUR_LOWER_HALF:
-				cur_height = vc->vc_font.height >> 1;
-				break;
-			case CUR_TWO_THIRDS:
-				cur_height = (vc->vc_font.height << 1)/3;
-				break;
-			case CUR_BLOCK:
-			default:
-				cur_height = vc->vc_font.height;
-				break;
-			}
-			size = (vc->vc_font.height - cur_height) * w;
-			while (size--)
-				mask[i++] = ~msk;
-			size = cur_height * w;
-			while (size--)
-				mask[i++] = msk;
-		}
-        	info->cursor.rop = ROP_XOR;
-		info->fbops->fb_cursor(info, &cursor);
-		vbl_cursor_cnt = CURSOR_DRAW_DELAY;
-		break;
-	}
+	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
+		    get_color(vc, info, c, 0));
+	vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 }
 
 static int scrollback_phys_max = 0;
@@ -1407,15 +1163,15 @@ static __inline__ void ypan_up(struct vc
 	
 	p->yscroll += count;
 	if (p->yscroll > p->vrows - vc->vc_rows) {
-		accel_bmove(vc, info, p->vrows - vc->vc_rows, 
-			 	0, 0, 0, vc->vc_rows, vc->vc_cols);
+		fbcon_bmove(vc, p->vrows - vc->vc_rows,
+			    0, 0, 0, vc->vc_rows, vc->vc_cols);
 		p->yscroll -= p->vrows - vc->vc_rows;
 	}
 	info->var.xoffset = 0;
 	info->var.yoffset = p->yscroll * vc->vc_font.height;
 	info->var.vmode &= ~FB_VMODE_YWRAP;
 	update_var(vc->vc_num, info);
-	accel_clear_margins(vc, info, 1);
+	fbcon_clear_margins(vc, 1);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max = scrollback_phys_max;
@@ -1440,7 +1196,7 @@ static __inline__ void ypan_up_redraw(st
 	if (redraw)
 		fbcon_redraw_move(vc, p, t + count, vc->vc_rows - count, t);
 	update_var(vc->vc_num, info);
-	accel_clear_margins(vc, info, 1);
+	fbcon_clear_margins(vc, 1);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max = scrollback_phys_max;
@@ -1454,15 +1210,15 @@ static __inline__ void ypan_down(struct 
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0) {
-		accel_bmove(vc, info, 0, 0, p->vrows - vc->vc_rows,
-			 	0, vc->vc_rows, vc->vc_cols);
+		fbcon_bmove(vc, 0, 0, p->vrows - vc->vc_rows,
+			    0, vc->vc_rows, vc->vc_cols);
 		p->yscroll += p->vrows - vc->vc_rows;
 	}
 	info->var.xoffset = 0;
 	info->var.yoffset = p->yscroll * vc->vc_font.height;
 	info->var.vmode &= ~FB_VMODE_YWRAP;
 	update_var(vc->vc_num, info);
-	accel_clear_margins(vc, info, 1);
+	fbcon_clear_margins(vc, 1);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
 		scrollback_max = 0;
@@ -1486,7 +1242,7 @@ static __inline__ void ypan_down_redraw(
 	if (redraw)
 		fbcon_redraw_move(vc, p, t, vc->vc_rows - count, t + count);
 	update_var(vc->vc_num, info);
-	accel_clear_margins(vc, info, 1);
+	fbcon_clear_margins(vc, 1);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
 		scrollback_max = 0;
@@ -1496,7 +1252,6 @@ static __inline__ void ypan_down_redraw(
 static void fbcon_redraw_softback(struct vc_data *vc, struct display *p,
 				  long delta)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	int count = vc->vc_rows;
 	unsigned short *d, *s;
 	unsigned long n;
@@ -1553,16 +1308,16 @@ static void fbcon_redraw_softback(struct
 			if (attr != (c & 0xff00)) {
 				attr = c & 0xff00;
 				if (s > start) {
-					accel_putcs(vc, info, start, s - start,
-						    real_y(p, line), x);
+					fbcon_putcs(vc, start, s - start,
+						    line, x);
 					x += s - start;
 					start = s;
 				}
 			}
 			if (c == scr_readw(d)) {
 				if (s > start) {
-					accel_putcs(vc, info, start, s - start,
-						    real_y(p, line), x);
+					fbcon_putcs(vc, start, s - start,
+						    line, x);
 					x += s - start + 1;
 					start = s + 1;
 				} else {
@@ -1574,8 +1329,7 @@ static void fbcon_redraw_softback(struct
 			d++;
 		} while (s < le);
 		if (s > start)
-			accel_putcs(vc, info, start, s - start,
-				    real_y(p, line), x);
+			fbcon_putcs(vc, start, s - start, line, x);
 		line++;
 		if (d == (u16 *) softback_end)
 			d = (u16 *) softback_buf;
@@ -1591,7 +1345,6 @@ static void fbcon_redraw_softback(struct
 static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
 			      int line, int count, int dy)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	unsigned short *s = (unsigned short *)
 		(vc->vc_origin + vc->vc_size_row * line);
 
@@ -1607,8 +1360,8 @@ static void fbcon_redraw_move(struct vc_
 			if (attr != (c & 0xff00)) {
 				attr = c & 0xff00;
 				if (s > start) {
-					accel_putcs(vc, info, start, s - start,
-						    real_y(p, dy), x);
+					fbcon_putcs(vc, start, s - start,
+						    dy, x);
 					x += s - start;
 					start = s;
 				}
@@ -1617,8 +1370,7 @@ static void fbcon_redraw_move(struct vc_
 			s++;
 		} while (s < le);
 		if (s > start)
-			accel_putcs(vc, info, start, s - start,
-				    real_y(p, dy), x);
+			fbcon_putcs(vc, start, s - start, dy, x);
 		console_conditional_schedule();
 		dy++;
 	}
@@ -1629,7 +1381,6 @@ static void fbcon_redraw(struct vc_data 
 {
 	unsigned short *d = (unsigned short *)
 	    (vc->vc_origin + vc->vc_size_row * line);
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	unsigned short *s = d + offset;
 
 	while (count--) {
@@ -1644,16 +1395,16 @@ static void fbcon_redraw(struct vc_data 
 			if (attr != (c & 0xff00)) {
 				attr = c & 0xff00;
 				if (s > start) {
-					accel_putcs(vc, info, start, s - start,
-						    real_y(p, line), x);
+					fbcon_putcs(vc, start, s - start,
+						    line, x);
 					x += s - start;
 					start = s;
 				}
 			}
 			if (c == scr_readw(d)) {
 				if (s > start) {
-					accel_putcs(vc, info, start, s - start,
-						    real_y(p, line), x);
+					fbcon_putcs(vc, start, s - start,
+						     line, x);
 					x += s - start + 1;
 					start = s + 1;
 				} else {
@@ -1667,8 +1418,7 @@ static void fbcon_redraw(struct vc_data 
 			d++;
 		} while (s < le);
 		if (s > start)
-			accel_putcs(vc, info, start, s - start,
-				    real_y(p, line), x);
+			fbcon_putcs(vc, start, s - start, line, x);
 		console_conditional_schedule();
 		if (offset > 0)
 			line++;
@@ -1737,9 +1487,9 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_up;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			accel_bmove(vc, info, t + count, 0, t, 0,
-					 b - t - count, vc->vc_cols);
-			accel_clear(vc, info, b - count, 0, count,
+			fbcon_bmove(vc, t + count, 0, t, 0,
+				    b - t - count, vc->vc_cols);
+			fbcon_clear(vc, b - count, 0, count,
 					 vc->vc_cols);
 			break;
 
@@ -1806,8 +1556,7 @@ static int fbcon_scroll(struct vc_data *
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
-			accel_clear(vc, info, real_y(p, b - count), 0,
-					 count, vc->vc_cols);
+			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
@@ -1822,9 +1571,9 @@ static int fbcon_scroll(struct vc_data *
 			count = vc->vc_rows;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			accel_bmove(vc, info, t, 0, t + count, 0,
-					 b - t - count, vc->vc_cols);
-			accel_clear(vc, info, t, 0, count, vc->vc_cols);
+			fbcon_bmove(vc, t, 0, t + count, 0,
+				    b - t - count, vc->vc_cols);
+			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_WRAP_MOVE:
@@ -1888,8 +1637,7 @@ static int fbcon_scroll(struct vc_data *
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
 				     -count * vc->vc_cols);
-			accel_clear(vc, info, real_y(p, t), 0, count,
-					 vc->vc_cols);
+			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
@@ -1929,6 +1677,7 @@ static void fbcon_bmove_rec(struct vc_da
 			    int dy, int dx, int height, int width, u_int y_break)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	u_int b;
 
 	if (sy < y_break && sy + height > y_break) {
@@ -1962,8 +1711,8 @@ static void fbcon_bmove_rec(struct vc_da
 		}
 		return;
 	}
-	accel_bmove(vc, info, real_y(p, sy), sx, real_y(p, dy), dx,
-			height, width);
+	ops->bmove(vc, info, real_y(p, sy), sx, real_y(p, dy), dx,
+		   height, width);
 }
 
 static __inline__ void updatescrollmode(struct display *p, struct fb_info *info,
@@ -2057,11 +1806,12 @@ static int fbcon_resize(struct vc_data *
 
 static int fbcon_switch(struct vc_data *vc)
 {
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fb_info *info;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
 	int i, prev_console, do_set_par = 0;
 
+	info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -2102,7 +1852,6 @@ static int fbcon_switch(struct vc_data *
 	}
 
 	memset(&var, 0, sizeof(struct fb_var_screeninfo));
-	fb_videomode_to_var(&var, p->mode);
 	display_to_var(&var, p);
 	var.activate = FB_ACTIVATE_NOW;
 
@@ -2124,6 +1873,8 @@ static int fbcon_switch(struct vc_data *
 		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 
+	set_blitting_type(vc, info, p);
+
 	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	updatescrollmode(p, info, vc);
@@ -2149,7 +1900,7 @@ static int fbcon_switch(struct vc_data *
 	fbcon_set_palette(vc, color_table); 	
 
 	if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
-		accel_clear_margins(vc, info, 0);
+		fbcon_clear_margins(vc, 0);
 	if (logo_shown == -2) {
 
 		logo_shown = fg_console;
@@ -2209,14 +1960,11 @@ static int fbcon_blank(struct vc_data *v
 			height = vc->vc_rows;
 			y_break = p->vrows - p->yscroll;
 			if (height > y_break) {
-				accel_clear(vc, info, real_y(p, 0),
-					    0, y_break, vc->vc_cols);
-				accel_clear(vc, info, real_y(p, y_break),
-					    0, height - y_break, 
+				fbcon_clear(vc, 0, 0, y_break, vc->vc_cols);
+				fbcon_clear(vc, y_break, 0, height - y_break,
 					    vc->vc_cols);
 			} else
-				accel_clear(vc, info, real_y(p, 0),
-					    0, height, vc->vc_cols);
+				fbcon_clear(vc, 0, 0, height, vc->vc_cols);
 			vc->vc_video_erase_char = oldc;
 		} else
 			update_screen(vc->vc_num);
@@ -2383,7 +2131,7 @@ static int fbcon_do_set_font(struct vc_d
 		}
 	} else if (CON_IS_VISIBLE(vc)
 		   && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
-		accel_clear_margins(vc, info, 0);
+		fbcon_clear_margins(vc, 0);
 		update_screen(vc->vc_num);
 	}
 
@@ -2726,9 +2474,14 @@ static int fbcon_set_origin(struct vc_da
 
 static void fbcon_suspended(struct fb_info *info)
 {
+	struct vc_data *vc = NULL;
+
+	if (info->currcon < 0)
+		return;
+	vc = vc_cons[info->currcon].d;
+
 	/* Clear cursor, restore saved data */
-	info->cursor.enable = 0;
-	info->fbops->fb_cursor(info, &info->cursor);
+	fbcon_cursor(vc, CM_ERASE);
 }
 
 static void fbcon_resumed(struct fb_info *info)
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.h linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.h
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.h	2004-09-10 04:43:22.814417232 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.h	2004-09-10 05:01:35.548296432 +0800
@@ -48,6 +48,19 @@ struct display {
     struct fb_videomode *mode;
 };
 
+struct fbcon_ops {
+	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
+		      int sx, int dy, int dx, int height, int width);
+	void (*clear)(struct vc_data *vc, struct fb_info *info, int sy,
+		      int sx, int height, int width);
+	void (*putcs)(struct vc_data *vc, struct fb_info *info,
+		      const unsigned short *s, int count, int yy, int xx,
+		      int fg, int bg);
+	void (*clear_margins)(struct vc_data *vc, struct fb_info *info,
+			      int bottom_only);
+	void (*cursor)(struct vc_data *vc, struct fb_info *info,
+		       struct display *p, int mode, int fg, int bg);
+};
     /*
      *  Attribute Decoding
      */
@@ -72,6 +85,13 @@ struct display {
 #define attr_blink(s) \
 	((s) & 0x8000)
 	
+/* Font */
+#define REFCOUNT(fd)	(((int *)(fd))[-1])
+#define FNTSIZE(fd)	(((int *)(fd))[-2])
+#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
+#define FNTSUM(fd)	(((int *)(fd))[-4])
+#define FONT_EXTRA_WORDS 4
+
     /*
      *  Scroll Method
      */
@@ -129,5 +149,9 @@ struct display {
 #define SCROLL_PAN_REDRAW  0x005
 
 extern int fb_console_init(void);
-
+#ifdef CONFIG_FB_TILEBLITTING
+extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
+			      struct display *p, struct fbcon_ops *ops);
+#endif
+extern void fbcon_set_bitops(struct fbcon_ops *ops);
 #endif /* _VIDEO_FBCON_H */
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/Makefile linux-2.6.9-rc1-mm4/drivers/video/console/Makefile
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/Makefile	2004-09-10 04:43:22.815417080 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/Makefile	2004-09-10 05:01:35.549296280 +0800
@@ -24,7 +24,8 @@ obj-$(CONFIG_PROM_CONSOLE)        += pro
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o font.o
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o font.o
+obj-$(CONFIG_FB_TILEBLITTING)     += tileblit.o
 
 obj-$(CONFIG_FB_STI)              += sticore.o
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/tileblit.c linux-2.6.9-rc1-mm4/drivers/video/console/tileblit.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/tileblit.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/tileblit.c	2004-09-10 05:01:35.551295976 +0800
@@ -0,0 +1,146 @@
+/*
+ *  linux/drivers/video/console/tileblit.c -- Tile Blitting Operation
+ *
+ *      Copyright (C) 2004 Antonino Daplas <adaplas @pol.net>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/vt_kern.h>
+#include <linux/console.h>
+#include <asm/types.h>
+#include "fbcon.h"
+
+static void tile_bmove(struct vc_data *vc, struct fb_info *info, int sy,
+		       int sx, int dy, int dx, int height, int width)
+{
+	struct fb_tilearea area;
+
+	area.sx = sx;
+	area.sy = sy;
+	area.dx = dx;
+	area.dy = dy;
+	area.height = height;
+	area.width = width;
+
+	info->tileops->fb_tilecopy(info, &area);
+}
+
+static void tile_clear(struct vc_data *vc, struct fb_info *info, int sy,
+		       int sx, int height, int width)
+{
+	struct fb_tilerect rect;
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
+	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
+
+	rect.index = vc->vc_video_erase_char &
+		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
+	rect.fg = attr_fgcol_ec(fgshift, vc);
+	rect.bg = attr_bgcol_ec(bgshift, vc);
+	rect.sx = sx;
+	rect.sy = sy;
+	rect.width = width;
+	rect.height = height;
+	rect.rop = ROP_COPY;
+
+	info->tileops->fb_tilefill(info, &rect);
+}
+
+static void tile_putcs(struct vc_data *vc, struct fb_info *info,
+		       const unsigned short *s, int count, int yy, int xx,
+		       int fg, int bg)
+{
+	struct fb_tileblit blit;
+	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	int size = sizeof(u32) * count, i;
+
+	blit.sx = xx;
+	blit.sy = yy;
+	blit.width = count;
+	blit.height = 1;
+	blit.fg = fg;
+	blit.bg = bg;
+	blit.length = count;
+	blit.indices = (u32 *) fb_get_buffer_offset(info, &info->pixmap, size);
+	for (i = 0; i < count; i++)
+		blit.indices[i] = (u32)(scr_readw(s++) & charmask);
+
+	info->tileops->fb_tileblit(info, &blit);
+}
+
+static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,
+			       int bottom_only)
+{
+	return;
+}
+
+static void tile_cursor(struct vc_data *vc, struct fb_info *info,
+			struct display *p, int mode, int fg, int bg)
+{
+	struct fb_tilecursor cursor;
+
+	cursor.sx = vc->vc_x;
+	cursor.sy = vc->vc_y;
+	cursor.mode = (mode == CM_ERASE) ? 0 : 1;
+	cursor.fg = fg;
+	cursor.bg = bg;
+
+	switch (vc->vc_cursor_type & 0x0f) {
+	case CUR_NONE:
+		cursor.shape = FB_TILE_CURSOR_NONE;
+		break;
+	case CUR_UNDERLINE:
+		cursor.shape = FB_TILE_CURSOR_UNDERLINE;
+		break;
+	case CUR_LOWER_THIRD:
+		cursor.shape = FB_TILE_CURSOR_LOWER_THIRD;
+		break;
+	case CUR_LOWER_HALF:
+		cursor.shape = FB_TILE_CURSOR_LOWER_HALF;
+		break;
+	case CUR_TWO_THIRDS:
+		cursor.shape = FB_TILE_CURSOR_TWO_THIRDS;
+		break;
+	case CUR_BLOCK:
+	default:
+		cursor.shape = FB_TILE_CURSOR_BLOCK;
+		break;
+	}
+
+	info->tileops->fb_tilecursor(info, &cursor);
+}
+
+void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
+		       struct display *p, struct fbcon_ops *ops)
+{
+	struct fb_tilemap map;
+
+	ops->bmove = tile_bmove;
+	ops->clear = tile_clear;
+	ops->putcs = tile_putcs;
+	ops->clear_margins = tile_clear_margins;
+	ops->cursor = tile_cursor;
+
+	if (p) {
+		map.width = vc->vc_font.width;
+		map.height = vc->vc_font.height;
+		map.depth = 1;
+		map.length = (p->userfont) ?
+			FNTCHARCNT(p->fontdata) : 256;
+		map.data = p->fontdata;
+		info->tileops->fb_settile(info, &map);
+	}
+}
+
+EXPORT_SYMBOL(fbcon_set_tileops);
+
+MODULE_AUTHOR("Antonino Daplas <adaplas@pol.net>");
+MODULE_DESCRIPTION("Tile Blitting Operation");
+MODULE_LICENSE("GPL");
+
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm4/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-10 05:01:19.346759440 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-10 05:01:35.552295824 +0800
@@ -368,6 +368,9 @@ int fb_prepare_logo(struct fb_info *info
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
+	if (info->flags & FBINFO_MISC_TILEBLITTING)
+		return 0;
+
 	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
 		depth = info->var.blue.length;
 		if (info->var.red.length < depth)
@@ -669,6 +672,7 @@ fb_cursor(struct fb_info *info, struct f
 	cursor.image.cmap.blue = info->cursor.image.cmap.blue;
 	cursor.image.cmap.transp = info->cursor.image.cmap.transp;
 	cursor.data = NULL;
+	cursor.flash = 0;
 
 	if (cursor.set & FB_CUR_SETCUR)
 		info->cursor.enable = 1;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/Kconfig linux-2.6.9-rc1-mm4/drivers/video/Kconfig
--- linux-2.6.9-rc1-mm4-orig/drivers/video/Kconfig	2004-09-10 04:43:22.834414192 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/Kconfig	2004-09-10 05:01:35.555295368 +0800
@@ -49,6 +49,24 @@ config FB_MODE_HELPERS
 	  your driver does not take advantage of this feature, choosing Y will
 	  just increase the kernel size by about 5K.
 
+config FB_TILEBLITTING
+       bool "Enable Tile Blitting Support"
+       depends on FB
+       default n
+       ---help---
+         This enables tile blitting.  Tile blitting is a drawing technique
+	 where the screen is divided into rectangular sections (tiles), whereas
+	 the standard blitting divides the screen into pixels. Because the
+	 default drawing element is a tile, drawing functions will be passed
+	 parameters in terms of number of tiles instead of number of pixels.
+	 For example, to draw a single character, instead of using bitmaps,
+	 an index to an array of bitmaps will be used.  To clear or move a
+	 rectangular section of a screen, the rectangle willbe described in
+	 terms of number of tiles in the x- and y-axis.
+
+	 This is particularly important to one driver, the matroxfb.  If
+	 unsure, say N.
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (ZORRO || PCI)
diff -uprN linux-2.6.9-rc1-mm4-orig/include/linux/fb.h linux-2.6.9-rc1-mm4/include/linux/fb.h
--- linux-2.6.9-rc1-mm4-orig/include/linux/fb.h	2004-09-10 05:01:19.382753968 +0800
+++ linux-2.6.9-rc1-mm4/include/linux/fb.h	2004-09-10 05:01:35.558294912 +0800
@@ -318,6 +318,7 @@ struct fb_cursor {
 	struct fbcurpos hot;	/* cursor hot spot */
 	struct fb_image	image;	/* Cursor image */
 /* all fields below are for fbcon use only */
+	int   flash;            /* cursor blink */
 	char  *data;             /* copy of bitmap */
 };
 
@@ -555,6 +556,82 @@ struct fb_ops {
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
 };
 
+#ifdef CONFIG_FB_TILEBLITTING
+
+#define FB_TILE_CURSOR_NONE        0
+#define FB_TILE_CURSOR_UNDERLINE   1
+#define FB_TILE_CURSOR_LOWER_THIRD 2
+#define FB_TILE_CURSOR_LOWER_HALF  3
+#define FB_TILE_CURSOR_TWO_THIRDS  4
+#define FB_TILE_CURSOR_BLOCK       5
+
+struct fb_tilemap {
+	__u32 width;                /* width of each tile in pixels */
+	__u32 height;               /* height of each tile in scanlines */
+	__u32 depth;                /* color depth of each tile */
+	__u32 length;               /* number of tiles in the map */
+	__u8  *data;                /* actual tile map: a bitmap array, packed
+				       to the nearest byte */
+};
+
+struct fb_tilerect {
+	__u32 sx;                   /* origin in the x-axis */
+	__u32 sy;                   /* origin in the y-axis */
+	__u32 width;                /* number of tiles in the x-axis */
+	__u32 height;               /* number of tiles in the y-axis */
+	__u32 index;                /* what tile to use: index to tile map */
+	__u32 fg;                   /* foreground color */
+	__u32 bg;                   /* background color */
+	__u32 rop;                  /* raster operation */
+};
+
+struct fb_tilearea {
+	__u32 sx;                   /* source origin in the x-axis */
+	__u32 sy;                   /* source origin in the y-axis */
+	__u32 dx;                   /* destination origin in the x-axis */
+	__u32 dy;                   /* destination origin in the y-axis */
+	__u32 width;                /* number of tiles in the x-axis */
+	__u32 height;               /* number of tiles in the y-axis */
+};
+
+struct fb_tileblit {
+	__u32 sx;                   /* origin in the x-axis */
+	__u32 sy;                   /* origin in the y-axis */
+	__u32 width;                /* number of tiles in the x-axis */
+	__u32 height;               /* number of tiles in the y-axis */
+	__u32 fg;                   /* foreground color */
+	__u32 bg;                   /* background color */
+	__u32 length;               /* number of tiles to draw */
+	__u32 *indices;             /* array of indices to tile map */
+};
+
+struct fb_tilecursor {
+	__u32 sx;                   /* cursor position in the x-axis */
+	__u32 sy;                   /* cursor position in the y-axis */
+	__u32 mode;                 /* 0 = erase, 1 = draw */
+	__u32 shape;                /* see FB_TILE_CURSOR_* */
+	__u32 fg;                   /* foreground color */
+	__u32 bg;                   /* background color */
+};
+
+struct fb_tile_ops {
+	/* set tile characteristics */
+	void (*fb_settile)(struct fb_info *info, struct fb_tilemap *map);
+
+	/* all dimensions from hereon are in terms of tiles */
+
+	/* move a rectangular region of tiles from one area to another*/
+	void (*fb_tilecopy)(struct fb_info *info, struct fb_tilearea *area);
+	/* fill a rectangular region with a tile */
+	void (*fb_tilefill)(struct fb_info *info, struct fb_tilerect *rect);
+	/* copy an array of tiles */
+	void (*fb_tileblit)(struct fb_info *info, struct fb_tileblit *blit);
+	/* cursor */
+	void (*fb_tilecursor)(struct fb_info *info,
+			      struct fb_tilecursor *cursor);
+};
+#endif /* CONFIG_FB_TILEBLITTING */
+
 /* FBINFO_* = fb_info.flags bit flags */
 #define FBINFO_MODULE		0x0001	/* Low-level driver is a module */
 #define FBINFO_HWACCEL_DISABLED	0x0002
@@ -586,6 +663,7 @@ struct fb_ops {
 						  from userspace */
 #define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
 #define FBINFO_MISC_MODESWITCHLATE     0x40000 /* init hardware later */
+#define FBINFO_MISC_TILEBLITTING       0x80000 /* use tile blitting */
 
 struct fb_info {
 	int node;
@@ -602,13 +680,16 @@ struct fb_info {
 	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
 	struct device *device;
+#ifdef CONFIG_FB_TILEBLITTING
+	struct fb_tile_ops *tileops;    /* Tile Blitting */
+#endif
 	char *screen_base;		/* Virtual address */
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 #define FBINFO_STATE_RUNNING	0
 #define FBINFO_STATE_SUSPENDED	1
 	u32 state;			/* Hardware state i.e suspend */
-
+	void *fbcon_par;                /* fbcon use-only private area */
 	/* From here on everything is device dependent */
 	void *par;	
 };




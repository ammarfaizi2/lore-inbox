Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUG2CPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUG2CPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUG2CPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:15:06 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:39581 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S267413AbUG2COX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:14:23 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/5] [FBCON]: Differentiate bits_per_pixel from color depth
Date: Thu, 29 Jul 2004 10:04:04 +0800
User-Agent: KMail/1.5.4
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407291004.04094.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert,

1. If you remember this thread (HP300 support checked in), one concern
was how to support framebuffers with bpp == 8 but color depth < 8
(chunky layout). I suggested to use the fields in var->{red|green|blue}
to differentiate between bits_per_pixel and depth. Included is a patch
that does that.

(The above assumes background/foreground of 0/1.  If hardware needs a different
value, such as 0 - black, 0xff - white, just indicate TRUECOLOR or DIRECTCOLOR
and set info->pseudopalette correctly in xxxfb_setcolreg().)

The patch will break the following drivers when in monochrome since they do not
set the proper color bitfields. I've included a fix in patch #2.

68328fb
bw2fb
cirrusfb
dnfb
macfb
stifb
tx3912fb

2. Besides the change above, support for the inverse and underline attribute is
added in monochrome mode.  One should get text which are underlined/reversed
if the corresponding attribute is set.

3. Because vt.c uses a 16-color palette, use fbcon_default_cmap if framebuffer
can do less than 16 colors.  In 4 colors, display will be grayscaled. In 8 colors,
display should have the same colors as a 16-color console but will lack brightness/
intensity.

4. Fix monochrome logo drawing.

5. Reduce code of fbcon_putc so it just calls fbcon_putcs.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 drivers/char/vt.c             |   34 +++--
 drivers/video/cfbimgblt.c     |    2
 drivers/video/console/fbcon.c |  243 +++++++++++++++++++++++++-----------------
 drivers/video/fbmem.c         |   46 +++++--
 include/linux/fb.h            |    3
 5 files changed, 208 insertions(+), 120 deletions(-)

diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/char/vt.c linux-2.6.8-rc2-mm1/drivers/char/vt.c
--- linux-2.6.8-rc2-mm1-orig/drivers/char/vt.c	2004-07-28 19:54:09.990631160 +0000
+++ linux-2.6.8-rc2-mm1/drivers/char/vt.c	2004-07-28 19:56:09.951394352 +0000
@@ -599,6 +599,17 @@ static inline void save_screen(int currc
  *	Redrawing of screen
  */
 
+static void clear_buffer_attributes(int currcons)
+{
+	unsigned short *p = (unsigned short *) origin;
+	int count = screenbuf_size/2;
+	int mask = hi_font_mask | 0xff;
+
+	for (; count > 0; count--, p++) {
+		scr_writew((scr_readw(p)&mask) | (video_erase_char&~mask), p);
+	}
+}
+
 void redraw_screen(int new_console, int is_switch)
 {
 	int redraw = 1;
@@ -636,9 +647,21 @@ void redraw_screen(int new_console, int 
 
 	if (redraw) {
 		int update;
+		int old_was_color = vc_cons[currcons].d->vc_can_do_color;
+
 		set_origin(currcons);
 		update = sw->con_switch(vc_cons[currcons].d);
 		set_palette(currcons);
+		/*
+		 * If console changed from mono<->color, the best we can do
+		 * is to clear the buffer attributes. As it currently stands,
+		 * rebuilding new attributes from the old buffer is not doable
+		 * without overly complex code. 
+		 */
+		 if (old_was_color != vc_cons[currcons].d->vc_can_do_color) {
+			update_attr(currcons);
+			clear_buffer_attributes(currcons);
+		}
 		if (update && vcmode != KD_GRAPHICS)
 			do_update_region(currcons, origin, screenbuf_size/2);
 	}
@@ -2652,17 +2675,6 @@ int __init vty_init(void)
 
 #ifndef VT_SINGLE_DRIVER
 
-static void clear_buffer_attributes(int currcons)
-{
-	unsigned short *p = (unsigned short *) origin;
-	int count = screenbuf_size/2;
-	int mask = hi_font_mask | 0xff;
-
-	for (; count > 0; count--, p++) {
-		scr_writew((scr_readw(p)&mask) | (video_erase_char&~mask), p);
-	}
-}
-
 /*
  *	If we support more console drivers, this function is used
  *	when a driver wants to take over some existing consoles
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/cfbimgblt.c linux-2.6.8-rc2-mm1/drivers/video/cfbimgblt.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/cfbimgblt.c	2004-07-28 19:52:46.522320272 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/cfbimgblt.c	2004-07-28 19:56:09.953394048 +0000
@@ -325,7 +325,7 @@ void cfb_imageblit(struct fb_info *p, co
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
-	} else if (image->depth <= bpp) 
+	} else
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/console/fbcon.c linux-2.6.8-rc2-mm1/drivers/video/console/fbcon.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/console/fbcon.c	2004-07-28 19:52:36.095905328 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/console/fbcon.c	2004-07-28 19:56:09.955393744 +0000
@@ -406,6 +406,57 @@ int set_con2fb_map(int unit, int newidx)
 /*
  * Accelerated handlers.
  */
+static inline int get_color(struct vc_data *vc, struct fb_info *info,
+			    u16 c, int is_fg)
+{
+	struct display *p = &fb_display[fg_console];
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
+		int reverse = attr_reverse(c, p->inverse);
+
+		color = (is_fg) ? (reverse) ? bg : fg : (reverse) ? fg : bg;
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
+static inline int is_underline(struct fb_info *info, u16 c) 
+{
+	int underline = 0;
+
+	if (fb_get_color_depth(info) == 1)
+		underline = attr_underline(c);
+	return underline;
+}
+
 void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy, 
 		int sx, int dy, int dx, int height, int width)
 {
@@ -456,13 +507,19 @@ void accel_putcs(struct vc_data *vc, str
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
 	unsigned int shift_high = 8, pitch, cnt, size, k;
 	unsigned int idx = vc->vc_font.width >> 3;
+	unsigned int underline = is_underline(info, scr_readw(s));
 	struct fb_image image;
-	u8 *src, *dst;
+	u8 *src, *dst, *buf = NULL;
+	
+	if (underline) {
+		buf = kmalloc(cellsize, GFP_KERNEL);
+		if (!buf)
+			return;
+	}
+
+	image.fg_color = get_color(vc, info, scr_readw(s), 1);
+	image.bg_color = get_color(vc, info, scr_readw(s), 0);
 
-	image.fg_color = attr_fgcol((vc->vc_hi_font_mask) ? 9 : 8,
-				    scr_readw(s));
-	image.bg_color = attr_bgcol((vc->vc_hi_font_mask) ? 13 : 12,
-				    scr_readw(s));
 	image.dx = xx * vc->vc_font.width;
 	image.dy = yy * vc->vc_font.height;
 	image.height = vc->vc_font.height;
@@ -492,9 +549,18 @@ void accel_putcs(struct vc_data *vc, str
 			while (k--) {
 				src = vc->vc_font.data + (scr_readw(s++)&
 							  charmask)*cellsize;
+					
+				if (underline) {
+					int offset = (vc->vc_font.height < 10) ? 1 : 2;
+
+					memcpy(buf, src, cellsize);
+					memset(buf + cellsize - offset, 0xff,
+					       offset * width);
+					src = buf;
+				}
 				move_unaligned(info, &info->pixmap, dst, pitch,
-					       src, idx, image.height,
-					       shift_high, shift_low, mod);
+						       src, idx, image.height,
+						       shift_high, shift_low, mod);
 				shift_low += mod;
 				dst += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
@@ -504,8 +570,16 @@ void accel_putcs(struct vc_data *vc, str
 			while (k--) {
 				src = vc->vc_font.data + (scr_readw(s++)&
 							  charmask)*cellsize;
+				if (underline) {
+					int offset = (vc->vc_font.height < 10) ? 1 : 2;
+
+					memcpy(buf, src, cellsize);
+					memset(buf + cellsize - offset, 0xff,
+					       offset * width);
+					src = buf;
+				}
 				move_aligned(info, &info->pixmap, dst, pitch,
-					     src, idx, image.height);
+						     src, idx, image.height);
 				dst += width;
 			}
 		}
@@ -513,6 +587,7 @@ void accel_putcs(struct vc_data *vc, str
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;
 	}
+	kfree(buf);
 }
 
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -738,7 +813,7 @@ static void fbcon_init(struct vc_data *v
 	}
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
-	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
+	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
@@ -781,9 +856,15 @@ static void fbcon_init(struct vc_data *v
 
 	if (logo) {
 		/* Need to make room for the logo */
-		int cnt;
+		int cnt, erase = vc->vc_video_erase_char;
 		int step;
 
+		/*
+		 * remove underline attribute from erase character 
+		 * if black and white framebuffer.
+		 */
+		if (fb_get_color_depth(info) == 1)
+			erase &= ~0x400;
 		logo_height = fb_prepare_logo(info);
 		logo_lines = (logo_height + vc->vc_font.height - 1) /
 			     vc->vc_font.height;
@@ -797,8 +878,7 @@ static void fbcon_init(struct vc_data *v
 			save = kmalloc(logo_lines * new_cols * 2, GFP_KERNEL);
 			if (save) {
 				int i = cols < new_cols ? cols : new_cols;
-				scr_memsetw(save, vc->vc_video_erase_char,
-					    logo_lines * new_cols * 2);
+				scr_memsetw(save, erase, logo_lines * new_cols * 2);
 				r = q - step;
 				for (cnt = 0; cnt < logo_lines; cnt++, r += i)
 					scr_memcpyw(save + cnt * new_cols, r, 2 * i);
@@ -818,7 +898,7 @@ static void fbcon_init(struct vc_data *v
 			}
 		}
 		scr_memsetw((unsigned short *) vc->vc_origin,
-			    vc->vc_video_erase_char,
+			    erase,
 			    vc->vc_size_row * logo_lines);
 
 		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
@@ -927,55 +1007,6 @@ static void fbcon_clear(struct vc_data *
 		accel_clear(vc, info, real_y(p, sy), sx, height, width);
 }
 
-static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
-{
-	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int width = (vc->vc_font.width + 7) >> 3;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
-	struct display *p = &fb_display[vc->vc_num];
-	unsigned int size, pitch;
-	struct fb_image image;
-	u8 *src, *dst;
-
-	if (!info->fbops->fb_blank && console_blanked)
-		return;
-	if (info->state != FBINFO_STATE_RUNNING)
-		return;
-
-	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
-		return;
-
-	image.dx = xpos * vc->vc_font.width;
-	image.dy = real_y(p, ypos) * vc->vc_font.height;
-	image.width = vc->vc_font.width;
-	image.height = vc->vc_font.height;
-	image.fg_color = attr_fgcol(fgshift, c);
-	image.bg_color = attr_bgcol(bgshift, c);
-	image.depth = 1;
-
-	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
-
-	pitch = width + scan_align;
-	pitch &= ~scan_align;
-	size = pitch * vc->vc_font.height;
-	size += buf_align;
-	size &= ~buf_align;
-
-	dst = fb_get_buffer_offset(info, &info->pixmap, size);
-	image.data = dst;
-
-	if (info->pixmap.outbuf)
-		fb_iomove_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
-	else
-		fb_sysmove_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
-
-	info->fbops->fb_imageblit(info, &image);
-}
-
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos)
 {
@@ -993,15 +1024,19 @@ static void fbcon_putcs(struct vc_data *
 	accel_putcs(vc, info, s, count, real_y(p, ypos), xpos);
 }
 
+static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
+{
+	fbcon_putcs(vc, (const unsigned short *) &c, 1, ypos, xpos);
+}
+
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 	struct display *p = &fb_display[vc->vc_num];
 	int w = (vc->vc_font.width + 7) >> 3, c;
-	int y = real_y(p, vc->vc_y);
+	int y = real_y(p, vc->vc_y), fg, bg;
+	int underline;
 	struct fb_cursor cursor;
 	
 	if (mode & CM_SOFTBACK) {
@@ -1016,7 +1051,7 @@ static void fbcon_cursor(struct vc_data 
 		fbcon_set_origin(vc);
 
  	c = scr_readw((u16 *) vc->vc_pos);
-
+	underline = is_underline(info, c);
 	cursor.image.data = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
 	cursor.set = FB_CUR_SETCUR;
 	cursor.image.depth = 1;
@@ -1032,11 +1067,13 @@ static void fbcon_cursor(struct vc_data 
 	case CM_MOVE:
 	case CM_DRAW:
 		info->cursor.enable = 1;
-		
-		if (info->cursor.image.fg_color != attr_fgcol(fgshift, c) ||
-	    	    info->cursor.image.bg_color != attr_bgcol(bgshift, c)) {
-			cursor.image.fg_color = attr_fgcol(fgshift, c);
-			cursor.image.bg_color = attr_bgcol(bgshift, c);
+		fg = get_color(vc, info, c, 1);
+		bg = get_color(vc, info, c, 0);
+
+		if (info->cursor.image.fg_color != fg ||
+		    info->cursor.image.bg_color != bg) {
+			cursor.image.fg_color = fg;
+			cursor.image.bg_color = bg;
 			cursor.set |= FB_CUR_SETCMAP;
 		}
 		
@@ -1060,9 +1097,11 @@ static void fbcon_cursor(struct vc_data 
 		}
 
 		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
-		    || info->cursor.mask == NULL) {
+		    || info->cursor.mask == NULL || info->cursor.ul != attr_underline(c) ||
+		    info->cursor.rev != attr_reverse(c, p->inverse)) {
 			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
 			int cur_height, size, i = 0;
+			u8 msk = 0xff;
 
 			if (!mask)	return;	
 		
@@ -1070,6 +1109,11 @@ static void fbcon_cursor(struct vc_data 
 				kfree(info->cursor.mask);
 			info->cursor.mask = mask;
 	
+			info->cursor.ul = attr_underline(c);
+			info->cursor.rev = attr_reverse(c, p->inverse);
+
+			if (info->cursor.rev)
+				msk = 0;
 			p->cursor_shape = vc->vc_cursor_type & 0x0f;
 			cursor.set |= FB_CUR_SETSHAPE;
 
@@ -1096,10 +1140,14 @@ static void fbcon_cursor(struct vc_data 
 			}
 			size = (vc->vc_font.height - cur_height) * w;
 			while (size--)
-				mask[i++] = 0;
+				mask[i++] = ~msk;
 			size = cur_height * w;
-			while (size--)
-				mask[i++] = 0xff;
+			if (info->cursor.ul) 
+				msk = ~msk;
+			if (info->cursor.ul)
+				msk = ~msk;
+			while (size--) 
+				mask[i++] = msk;
 		}
         	info->cursor.rop = ROP_XOR;
 		info->fbops->fb_cursor(info, &cursor);
@@ -1140,7 +1188,7 @@ static void fbcon_set_disp(struct fb_inf
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
 
-	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
+	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
@@ -1897,6 +1945,10 @@ static int fbcon_switch(struct vc_data *
 		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 
+	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
+	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+
 	switch (p->scrollmode) {
 	case SCROLL_WRAP_MOVE:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
@@ -2320,26 +2372,31 @@ static struct fb_cmap palette_cmap = {
 static int fbcon_set_palette(struct vc_data *vc, unsigned char *table)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	int i, j, k;
+	int i, j, k, depth;
 	u8 val;
 
-	if (!vc->vc_can_do_color
-	    || (!info->fbops->fb_blank && console_blanked))
+	if (!info->fbops->fb_blank && console_blanked)
 		return -EINVAL;
-	for (i = j = 0; i < 16; i++) {
-		k = table[i];
-		val = vc->vc_palette[j++];
-		palette_red[k] = (val << 8) | val;
-		val = vc->vc_palette[j++];
-		palette_green[k] = (val << 8) | val;
-		val = vc->vc_palette[j++];
-		palette_blue[k] = (val << 8) | val;
-	}
-	if (info->var.bits_per_pixel <= 4)
-		palette_cmap.len = 1 << info->var.bits_per_pixel;
-	else
+	depth = fb_get_color_depth(info);
+	if (depth > 3) {
+		for (i = j = 0; i < 16; i++) {
+			k = table[i];
+			val = vc->vc_palette[j++];
+			palette_red[k] = (val << 8) | val;
+			val = vc->vc_palette[j++];
+			palette_green[k] = (val << 8) | val;
+			val = vc->vc_palette[j++];
+			palette_blue[k] = (val << 8) | val;
+		}
 		palette_cmap.len = 16;
-	palette_cmap.start = 0;
+		palette_cmap.start = 0;
+	/*
+	 * If framebuffer is capable of less than 16 colors,
+	 * use default palette of fbcon.
+	 */
+	} else 
+		fb_copy_cmap(fb_default_cmap(1 << depth), &palette_cmap, 0);
+
 	return fb_set_cmap(&palette_cmap, 1, info);
 }
 
@@ -2546,8 +2603,6 @@ static void fbcon_modechanged(struct fb_
 	p = &fb_display[vc->vc_num];
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
-	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 
 	if (CON_IS_VISIBLE(vc)) {
 		cols = info->var.xres / vc->vc_font.width;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/fbmem.c linux-2.6.8-rc2-mm1/drivers/video/fbmem.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/fbmem.c	2004-07-28 19:52:27.143266336 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/fbmem.c	2004-07-28 19:56:09.957393440 +0000
@@ -428,6 +428,24 @@ static int ofonly __initdata = 0;
 #endif
 
 /*
+ * Helpers
+ */
+
+int fb_get_color_depth(struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+
+	if (var->green.length == var->blue.length &&
+	    var->green.length == var->red.length &&
+	    !var->green.offset && !var->blue.offset &&
+	    !var->red.offset)
+		return var->green.length;
+	else
+		return (var->green.length + var->red.length +
+			var->blue.length);
+}
+
+/*
  * Drawing helpers.
  */
 void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
@@ -646,9 +664,12 @@ static void fb_set_logo(struct fb_info *
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {
-	int i, j, shift;
+	int i, j, k, fg = 1;
 	const u8 *src = logo->data;
-	u8 d, xor = 0;
+	u8 d, xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
+
+	if (fb_get_color_depth(info) == 3)
+		fg = 7;
 
 	switch (depth) {
 	case 4:
@@ -662,17 +683,14 @@ static void fb_set_logo(struct fb_info *
 				}
 			}
 		break;
-	case ~1:
-		xor = 0xff;
 	case 1:
 		for (i = 0; i < logo->height; i++) {
-			shift = 7;
-			d = *src++ ^ xor;
-			for (j = 0; j < logo->width; j++) {
-				*dst++ = (d >> shift) & 1;
-				shift = (shift-1) & 7;
-				if (shift == 7)
-					d = *src++ ^ xor;
+			for (j = 0; j < logo->width; src++) {
+				d = *src ^ xor;
+				for (k = 7; k >= 0; k--) {
+					*dst++ = ((d >> k) & 1) ? fg : 0;
+					j++;
+				}
 			}
 		}
 		break;
@@ -734,7 +752,7 @@ int fb_prepare_logo(struct fb_info *info
 	}
 
 	/* Return if no suitable logo was found */
-	fb_logo.logo = fb_find_logo(info->var.bits_per_pixel);
+	fb_logo.logo = fb_find_logo(fb_get_color_depth(info));
 	
 	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
 		fb_logo.logo = NULL;
@@ -761,7 +779,7 @@ int fb_show_logo(struct fb_info *info)
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	image.depth = fb_logo.depth;
+	image.depth = 8;
 	image.data = fb_logo.logo->data;
 
 	if (fb_logo.needs_cmapreset)
@@ -782,7 +800,7 @@ int fb_show_logo(struct fb_info *info)
 		info->pseudo_palette = palette;
 	}
 
-	if (fb_logo.depth == 4) {
+	if (fb_logo.depth <= 4) {
 		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
 				   GFP_KERNEL);
 		if (logo_new == NULL) {
diff -uprN linux-2.6.8-rc2-mm1-orig/include/linux/fb.h linux-2.6.8-rc2-mm1/include/linux/fb.h
--- linux-2.6.8-rc2-mm1-orig/include/linux/fb.h	2004-07-28 19:54:25.415286256 +0000
+++ linux-2.6.8-rc2-mm1/include/linux/fb.h	2004-07-28 19:56:09.959393136 +0000
@@ -376,6 +376,8 @@ struct fb_cursor {
 	__u16 set;		/* what to set */
 	__u16 enable;		/* cursor on/off */
 	__u16 rop;		/* bitop operation */
+	__u16 ul;               /* underlined? */
+	__u16 rev;              /* reversed? */
 	const char *mask;	/* cursor mask bits */
 	struct fbcurpos hot;	/* cursor hot spot */
 	struct fb_image	image;	/* Cursor image */
@@ -653,6 +655,7 @@ extern void fb_sysmove_buf_aligned(struc
 				u32 height);
 extern void fb_load_cursor_image(struct fb_info *);
 extern void fb_set_suspend(struct fb_info *info, int state);
+extern int fb_get_color_depth(struct fb_info *info);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVCHCRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVCHCRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVCHCQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:16:43 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:1965 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261845AbVCHCMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:12:00 -0500
Date: Tue, 8 Mar 2005 03:11:54 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 4/7] fbsplash - fbcon updates
Message-ID: <20050308021154.GE26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to fbcon.c. Kept as non-intrusive as possible.

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/console/fbcon.c	2005-03-07 16:50:34 +01:00
@@ -93,6 +93,7 @@
 #endif
 
 #include "fbcon.h"
+#include "../fbsplash.h"
 
 #ifdef FBCONDEBUG
 #  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
@@ -206,7 +207,7 @@
 		vt_cons[vc->vc_num]->vc_mode != KD_TEXT);
 }
 
-static inline int get_color(struct vc_data *vc, struct fb_info *info,
+inline int get_color(struct vc_data *vc, struct fb_info *info,
 	      u16 c, int is_fg)
 {
 	int depth = fb_get_color_depth(info);
@@ -270,7 +271,8 @@
 
 	if (!vc || !CON_IS_VISIBLE(vc) ||
 	    fbcon_is_inactive(vc, info) ||
- 	    registered_fb[con2fb_map[vc->vc_num]] != info)
+ 	    registered_fb[con2fb_map[vc->vc_num]] != info ||
+	    vc_cons[ops->currcon].d->vc_deccm != 1)
 		return;
 	acquire_console_sem();
 	p = &fb_display[vc->vc_num];
@@ -279,6 +281,7 @@
 		CM_ERASE : CM_DRAW;
 	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
+	
 	release_console_sem();
 }
 
@@ -404,6 +407,8 @@
 		info_idx = -1;
 	}
 
+	fbsplash_init();
+
 	return err;
 }
 
@@ -802,6 +807,12 @@
 
 	cols = info->var.xres / vc->vc_font.width;
 	rows = info->var.yres / vc->vc_font.height;
+
+	if (fbsplash_active(info, vc)) {
+		cols = vc->vc_splash.twidth / vc->vc_font.width;
+		rows = vc->vc_splash.theight / vc->vc_font.height;
+	}
+
 	vc_resize(vc->vc_num, cols, rows);
 
 	DPRINTK("mode:   %s\n", info->fix.id);
@@ -897,7 +908,7 @@
 	if (info_idx == -1 || info == NULL)
 	    return;
 	if (vc->vc_num != display_fg || logo_shown == FBCON_LOGO_DONTSHOW ||
-	    (info->fix.type == FB_TYPE_TEXT))
+	    (info->fix.type == FB_TYPE_TEXT) || fbsplash_active(info, vc))
 		logo = 0;
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
@@ -1038,6 +1049,11 @@
 	if (!height || !width)
 		return;
 
+ 	if (fbsplash_active(info, vc)) {
+ 		fbsplash_clear(vc, info, sy, sx, height, width);
+ 		return;
+ 	}
+ 	
 	/* Split blits that cross physical y_wrap boundary */
 
 	y_break = p->vrows - p->yscroll;
@@ -1057,10 +1073,15 @@
 	struct display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_is_inactive(vc, info))
-		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
-			   get_color(vc, info, scr_readw(s), 1),
-			   get_color(vc, info, scr_readw(s), 0));
+	if (!fbcon_is_inactive(vc, info)) {
+		
+		if (fbsplash_active(info, vc))
+			fbsplash_putcs(vc, info, s, count, ypos, xpos);
+		else
+			ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
+				   get_color(vc, info, scr_readw(s), 1),
+				   get_color(vc, info, scr_readw(s), 0));
+	}
 }
 
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
@@ -1076,8 +1097,13 @@
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_is_inactive(vc, info))
-		ops->clear_margins(vc, info, bottom_only);
+	if (!fbcon_is_inactive(vc, info)) {
+	 	if (fbsplash_active(info, vc)) {
+	 		fbsplash_clear_margins(vc, info, bottom_only);
+ 		} else {
+			ops->clear_margins(vc, info, bottom_only);
+		}
+	}
 }
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
@@ -1560,7 +1586,7 @@
 			count = vc->vc_rows;
 		if (softback_top)
 			fbcon_softback_note(vc, t, count);
-		if (logo_shown >= 0)
+		if (logo_shown >= 0 || fbsplash_active(info, vc))
 			goto redraw_up;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
@@ -1646,6 +1672,8 @@
 	case SM_DOWN:
 		if (count > vc->vc_rows)	/* Maximum realistic size */
 			count = vc->vc_rows;
+		if (fbsplash_active(info, vc))
+			goto redraw_down;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
 			ops->bmove(vc, info, t, 0, t + count, 0,
@@ -1788,6 +1816,13 @@
 		}
 		return;
 	}
+
+	if (fbsplash_active(info, vc) && sy == dy && height == 1) {
+ 		/* must use slower redraw bmove to keep background pic intact */
+ 		fbsplash_bmove_redraw(vc, info, sy, sx, dx, width);
+ 		return;
+ 	}
+	
 	ops->bmove(vc, info, real_y(p, sy), sx, real_y(p, dy), dx,
 		   height, width);
 }
@@ -1842,7 +1877,8 @@
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
+
+	if ((x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) && !vc->vc_splash.state) {
 		struct fb_videomode *mode;
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
@@ -1889,7 +1925,17 @@
 	int i, prev_console, do_set_par = 0;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
+	prev_console = ((struct fbcon_ops *)info->fbcon_par)->currcon;
+	
+	if (fbsplash_active_vc(vc)) {
+		struct vc_data *vc_curr = vc_cons[prev_console].d;
 
+		if (!vc_curr->vc_splash.theme || strcmp(vc->vc_splash.theme, vc_curr->vc_splash.theme)) {
+			if (fbsplash_call_helper("getpic", vc->vc_num))
+				fbsplash_disable(vc, 0);
+		}
+	}
+	
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -1915,8 +1961,6 @@
 		logo_shown = FBCON_LOGO_CANSHOW;
 	}
 
-	prev_console = ((struct fbcon_ops *)info->fbcon_par)->currcon;
-
 	/*
 	 * FIXME: If we have multiple fbdev's loaded, we need to
 	 * update all info->currcon.  Perhaps, we can place this
@@ -1954,6 +1998,11 @@
 		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 
+	if (fbsplash_active_nores(info, vc) && !fbsplash_active(info, vc)) {
+		if (fbsplash_call_helper("modechange", vc->vc_num))
+			fbsplash_disable(vc, 0);
+	}
+
 	set_blitting_type(vc, info, p);
 	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
 
@@ -2043,7 +2092,9 @@
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 			ops->cursor_flash = (!blank);
 
-			if (fb_blank(info, blank))
+ 			if (fbsplash_active(info, vc))
+				fbsplash_blank(vc, info, blank);
+			else
 				fbcon_generic_blank(vc, info, blank);
 		}
 
@@ -2196,9 +2247,15 @@
 	}
 
 	if (resize) {
-		/* reset wrap/pan */
-		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-		vc_resize(vc->vc_num, info->var.xres / w, info->var.yres / h);
+		u32 xres = info->var.xres, yres = info->var.yres;
+  		/* reset wrap/pan */
+  		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+		if (fbsplash_active(info, vc)) {
+			xres = vc->vc_splash.twidth;
+			yres = vc->vc_splash.theight;
+		}
+		vc_resize(vc->vc_num, xres / w, yres / h);
+		
 		if (CON_IS_VISIBLE(vc) && softback_buf) {
 			int l = fbcon_softback_size / vc->vc_size_row;
 			if (l > 5)
@@ -2325,9 +2382,9 @@
 	int i, j, k, depth;
 	u8 val;
 
-	if (fbcon_is_inactive(vc, info))
+	if (fbcon_is_inactive(vc, info) || vc->vc_num != fg_console)
 		return -EINVAL;
-
+	
 	depth = fb_get_color_depth(info);
 	if (depth > 3) {
 		for (i = j = 0; i < 16; i++) {
@@ -2348,7 +2405,49 @@
 	} else
 		fb_copy_cmap(fb_default_cmap(1 << depth), &palette_cmap);
 
-	return fb_set_cmap(&palette_cmap, info);
+	if (fbsplash_active(info, vc_cons[fg_console].d) &&
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+
+		u16 *red, *green, *blue;
+		int minlen = min(min(info->var.red.length, info->var.green.length), 
+				     info->var.blue.length);
+		int h;
+
+		struct fb_cmap cmap = {
+			.start = 0,
+			.len = (1 << minlen),
+			.red = NULL,
+			.green = NULL,
+			.blue = NULL,
+			.transp = NULL
+		};
+
+		red = kmalloc(256 * sizeof(u16) * 3, GFP_KERNEL);
+	
+		if (!red)
+			goto out;		
+	
+		green = red + 256;
+		blue = green + 256;
+		cmap.red = red;
+		cmap.green = green;
+		cmap.blue = blue;
+		
+		for (i = 0; i < cmap.len; i++) {
+			red[i] = green[i] = blue[i] = (0xffff * i)/(cmap.len-1);
+		}
+
+		h = fb_set_cmap(&cmap, info);
+		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
+		kfree(red);
+		
+		return h;
+		
+	} else if (fbsplash_active(info, vc_cons[fg_console].d) && 
+		   info->var.bits_per_pixel == 8 && info->splash.cmap.red != NULL) 
+		fb_set_cmap(&info->splash.cmap, info);
+		
+out:	return fb_set_cmap(&palette_cmap, info);
 }
 
 static u16 *fbcon_screen_pos(struct vc_data *vc, int offset)
@@ -2569,7 +2668,14 @@
 		var_to_display(p, &info->var, info);
 		cols = info->var.xres / vc->vc_font.width;
 		rows = info->var.yres / vc->vc_font.height;
-		vc_resize(vc->vc_num, cols, rows);
+		
+		if (!fbsplash_active_nores(info, vc)) {
+			vc_resize(vc->vc_num, cols, rows);
+		} else {
+			if (fbsplash_call_helper("modechange", vc->vc_num))
+				fbsplash_disable(vc, 0);
+		}
+	
 		updatescrollmode(p, info, vc);
 		scrollback_max = 0;
 		scrollback_current = 0;
diff -Nru a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/console/bitblit.c	2005-03-07 16:50:34 +01:00
@@ -18,6 +18,7 @@
 #include <linux/console.h>
 #include <asm/types.h>
 #include "fbcon.h"
+#include "../fbsplash.h"
 
 /*
  * Accelerated handlers.
@@ -84,6 +85,13 @@
 	area.height = height * vc->vc_font.height;
 	area.width = width * vc->vc_font.width;
 
+	if (fbsplash_active(info, vc)) {
+ 		area.sx += vc->vc_splash.tx;
+ 		area.sy += vc->vc_splash.ty;
+ 		area.dx += vc->vc_splash.tx;
+ 		area.dy += vc->vc_splash.ty;
+ 	}
+
 	info->fbops->fb_copyarea(info, &area);
 }
 
@@ -373,7 +381,11 @@
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
-	info->fbops->fb_cursor(info, &cursor);
+	if (fbsplash_active(info, vc)) {
+		fbsplash_cursor(info, &cursor);
+	} else {
+		info->fbops->fb_cursor(info, &cursor);
+	}
 
 	ops->cursor_reset = 0;
 }



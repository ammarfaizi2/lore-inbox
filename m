Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUIIVrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUIIVrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUIIVrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:47:42 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:11997 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267598AbUIIVeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:23 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/7] fbcon: Fix setup boot options of fbcon
Date: Fri, 10 Sep 2004 05:34:49 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100534.49269.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the 'fbcon=map:<option>" of fbcon.  (This option has been
present since 2.4, but got broken in 2.6). This particular option tells
fbcon what framebuffer device gets mapped to what console. Syntax is:

	fbcon=map:abcd... 

	where a, b, c, d,... are framebuffer numbers as it would
	appear in /proc/fb.

Given only 2 valid fbdevs, 0 and 1, if fbcon=map:0110, then:

tty1 = fb0
tty2 = fb1
tty3 = fb1
tty4 = fb0
(sequence repeats for the rest of the consoles)

If an invalid framebuffer is used, then the console will be mapped to the
first user-chosen framebuffer.  Ie: fbcon=map:102

tty1 = fb1
tty2 = fb0
tty3 = fb1 <--- since fb2 does not exist.

One can also use this option to disable the framebuffer console, ie,
fbcon=map:2

In the unlikely case of > 10 framebuffers, one can use the characters after
'9', namely:

':' = 10
';' = 11
'<' = 12
'=' = 13
'>' = 14
'?' = 15
'@' = 16
'A' = 17
'B' = 18
'C' = 19
(and so on until 31, which is the maximum framebuffers allowed)

NOTE: Mapping more than 1 framebuffer  with this option will probably cause
an initial flickering. The amount of flicker will depend on how fast the
hardware sets the mode, and how many consoles are set up in the system.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 console/fbcon.c |  240 +++++++++++++++++++++++++++++++++++---------------------
 fbmem.c         |   13 +--
 2 files changed, 158 insertions(+), 95 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c	2004-09-09 19:11:12.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c	2004-09-09 19:12:03.312654672 +0800
@@ -102,6 +102,7 @@
 
 struct display fb_display[MAX_NR_CONSOLES];
 signed char con2fb_map[MAX_NR_CONSOLES];
+signed char con2fb_map_boot[MAX_NR_CONSOLES];
 static int logo_height;
 static int logo_lines;
 static int logo_shown = -1;
@@ -182,6 +183,7 @@ static __inline__ void ypan_down(struct 
 static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break);
 static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc);
+static void fbcon_preset_disp(struct fb_info *info, int unit);
 static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
 			      int line, int count, int dy);
 
@@ -271,7 +273,8 @@ int __init fb_console_setup(char *this_o
 				for (i = 0, j = 0; i < MAX_NR_CONSOLES; i++) {
 					if (!options[j])
 						j = 0;
-					con2fb_map[i] = (options[j++]-'0') % FB_MAX;
+					con2fb_map_boot[i] =
+						(options[j++]-'0') % FB_MAX;
 				}
 			return 0;
 		}
@@ -314,13 +317,16 @@ static int search_for_mapped_con(void)
 	return 0;
 }
 
-static int fbcon_takeover(void)
+static int fbcon_takeover(int show_logo)
 {
 	int err, i;
 
 	if (!num_registered_fb)
 		return -ENODEV;
 
+	if (!show_logo)
+		logo_shown = -3;
+
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		con2fb_map[i] = info_idx;
 
@@ -336,15 +342,89 @@ static int fbcon_takeover(void)
 	return err;
 }
 
+static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
+			       int cols, int rows, int new_cols, int new_rows)
+{
+	/* Need to make room for the logo */
+	int cnt, erase = vc->vc_video_erase_char, step;
+	unsigned short *save = NULL, *r, *q;
+
+
+	/*
+	 * remove underline attribute from erase character
+	 * if black and white framebuffer.
+	 */
+	if (fb_get_color_depth(info) == 1)
+		erase &= ~0x400;
+	logo_height = fb_prepare_logo(info);
+	logo_lines = (logo_height + vc->vc_font.height - 1) /
+		vc->vc_font.height;
+	q = (unsigned short *) (vc->vc_origin +
+				vc->vc_size_row * rows);
+	step = logo_lines * cols;
+	for (r = q - logo_lines * cols; r < q; r++)
+		if (scr_readw(r) != vc->vc_video_erase_char)
+			break;
+	if (r != q && new_rows >= rows + logo_lines) {
+		save = kmalloc(logo_lines * new_cols * 2, GFP_KERNEL);
+		if (save) {
+			int i = cols < new_cols ? cols : new_cols;
+			scr_memsetw(save, erase, logo_lines * new_cols * 2);
+			r = q - step;
+			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
+				scr_memcpyw(save + cnt * new_cols, r, 2 * i);
+			r = q;
+		}
+	}
+	if (r == q) {
+		/* We can scroll screen down */
+		r = q - step - cols;
+		for (cnt = rows - logo_lines; cnt > 0; cnt--) {
+			scr_memcpyw(r + step, r, vc->vc_size_row);
+			r -= cols;
+		}
+		if (!save) {
+			vc->vc_y += logo_lines;
+			vc->vc_pos += logo_lines * vc->vc_size_row;
+		}
+	}
+	scr_memsetw((unsigned short *) vc->vc_origin,
+		    erase,
+		    vc->vc_size_row * logo_lines);
+
+	if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
+		accel_clear_margins(vc, info, 0);
+		update_screen(vc->vc_num);
+	}
+	if (save) {
+		q = (unsigned short *) (vc->vc_origin +
+					vc->vc_size_row *
+					rows);
+		scr_memcpyw(q, save, logo_lines * new_cols * 2);
+		vc->vc_y += logo_lines;
+		vc->vc_pos += logo_lines * vc->vc_size_row;
+		kfree(save);
+	}
+	if (logo_lines > vc->vc_bottom) {
+		logo_shown = -1;
+		printk(KERN_INFO
+		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
+	} else if (logo_shown != -3) {
+		logo_shown = -2;
+		vc->vc_top = logo_lines;
+	}
+}
+
 /**
  *	set_con2fb_map - map console to frame buffer device
  *	@unit: virtual console number to map
  *	@newidx: frame buffer index to map virtual console to
+ *      @user: user request
  *
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-static int set_con2fb_map(int unit, int newidx)
+static int set_con2fb_map(int unit, int newidx, int user)
 {
 	struct vc_data *vc = vc_cons[unit].d;
 	int oldidx = con2fb_map[unit];
@@ -355,12 +435,12 @@ static int set_con2fb_map(int unit, int 
 	if (oldidx == newidx)
 		return 0;
 
-	if (!vc)
-	    return -ENODEV;
+	if (!info)
+		return -EINVAL;
 
 	if (!search_for_mapped_con()) {
 		info_idx = newidx;
-		return fbcon_takeover();
+		return fbcon_takeover(0);
 	}
 
 	if (oldidx != -1)
@@ -403,7 +483,7 @@ static int set_con2fb_map(int unit, int 
 			del_timer_sync(&oldinfo->cursor_timer);
 		module_put(oldinfo->fbops->owner);
 	}
-	info->currcon = -1;
+
 	if (!found) {
 		if (!info->queue.func || info->queue.func == fb_flashcursor) {
 			if (!info->queue.func)
@@ -416,9 +496,27 @@ static int set_con2fb_map(int unit, int 
 			add_timer(&info->cursor_timer);
 		}
 	}
+
+	info->currcon = fg_console;
+	con2fb_map_boot[unit] = newidx;
+
 	if (info->fbops->fb_set_par)
 		info->fbops->fb_set_par(info);
-	fbcon_set_disp(info, vc);
+
+	if (vc)
+		fbcon_set_disp(info, vc);
+	else
+		fbcon_preset_disp(info, unit);
+
+	if (fg_console == 0 && !user && logo_shown != -3) {
+		struct vc_data *vc = vc_cons[fg_console].d;
+		struct fb_info *fg_info = registered_fb[(int) con2fb_map[fg_console]];
+
+		fbcon_prepare_logo(vc, fg_info, vc->vc_cols, vc->vc_rows,
+				   vc->vc_cols, vc->vc_rows);
+	}
+
+	switch_screen(fg_console);
 	release_console_sem();
 	return 0;
 }
@@ -876,12 +974,11 @@ static void fbcon_init(struct vc_data *v
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int display_fg = (*default_mode)->vc_num;
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
-	unsigned short *save = NULL, *r, *q;
 	int cap = info->flags;
 
 	if (info_idx == -1 || info == NULL)
 	    return;
-	if (vc->vc_num != display_fg || (info->flags & FBINFO_MODULE) ||
+	if (vc->vc_num != display_fg || logo_shown == -3 ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
@@ -945,75 +1042,8 @@ static void fbcon_init(struct vc_data *v
 		vc->vc_rows = new_rows;
 	}
 
-	if (logo) {
-		/* Need to make room for the logo */
-		int cnt, erase = vc->vc_video_erase_char;
-		int step;
-
-		/*
-		 * remove underline attribute from erase character
-		 * if black and white framebuffer.
-		 */
-		if (fb_get_color_depth(info) == 1)
-			erase &= ~0x400;
-		logo_height = fb_prepare_logo(info);
-		logo_lines = (logo_height + vc->vc_font.height - 1) /
-			     vc->vc_font.height;
-		q = (unsigned short *) (vc->vc_origin +
-					vc->vc_size_row * rows);
-		step = logo_lines * cols;
-		for (r = q - logo_lines * cols; r < q; r++)
-			if (scr_readw(r) != vc->vc_video_erase_char)
-				break;
-		if (r != q && new_rows >= rows + logo_lines) {
-			save = kmalloc(logo_lines * new_cols * 2, GFP_KERNEL);
-			if (save) {
-				int i = cols < new_cols ? cols : new_cols;
-				scr_memsetw(save, erase, logo_lines * new_cols * 2);
-				r = q - step;
-				for (cnt = 0; cnt < logo_lines; cnt++, r += i)
-					scr_memcpyw(save + cnt * new_cols, r, 2 * i);
-				r = q;
-			}
-		}
-		if (r == q) {
-			/* We can scroll screen down */
-			r = q - step - cols;
-			for (cnt = rows - logo_lines; cnt > 0; cnt--) {
-				scr_memcpyw(r + step, r, vc->vc_size_row);
-				r -= cols;
-			}
-			if (!save) {
-				vc->vc_y += logo_lines;
-				vc->vc_pos += logo_lines * vc->vc_size_row;
-			}
-		}
-		scr_memsetw((unsigned short *) vc->vc_origin,
-			    erase,
-			    vc->vc_size_row * logo_lines);
-
-		if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
-			accel_clear_margins(vc, info, 0);
-			update_screen(vc->vc_num);
-		}
-		if (save) {
-			q = (unsigned short *) (vc->vc_origin +
-						vc->vc_size_row *
-						rows);
-			scr_memcpyw(q, save, logo_lines * new_cols * 2);
-			vc->vc_y += logo_lines;
-			vc->vc_pos += logo_lines * vc->vc_size_row;
-			kfree(save);
-		}
-		if (logo_lines > vc->vc_bottom) {
-			logo_shown = -1;
-			printk(KERN_INFO
-			       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
-		} else {
-			logo_shown = -2;
-			vc->vc_top = logo_lines;
-		}
-	}
+	if (logo)
+		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
 
 	if (vc->vc_num == display_fg && softback_buf) {
 		int l = fbcon_softback_size / vc->vc_size_row;
@@ -1264,6 +1294,24 @@ int update_var(int con, struct fb_info *
 	return 0;
 }
 
+/*
+ * If no vc is existent yet, just set struct display
+ */
+static void fbcon_preset_disp(struct fb_info *info, int unit)
+{
+	struct display *p = &fb_display[unit];
+	struct display *t = &fb_display[fg_console];
+
+	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+	if (var_to_display(p, &info->var, info))
+		return;
+
+	p->fontdata = t->fontdata;
+	p->userfont = t->userfont;
+	if (p->userfont)
+		REFCOUNT(p->fontdata)++;
+}
+
 static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc)
 {
 	struct display *p = &fb_display[vc->vc_num], *t;
@@ -1314,7 +1362,6 @@ static void fbcon_set_disp(struct fb_inf
 			}
 		}
 	}
-	switch_screen(fg_console);
 }
 
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
@@ -2013,7 +2060,7 @@ static int fbcon_switch(struct vc_data *
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
-	int i;
+	int i, prev_console, do_set_par = 0;
 
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
@@ -2039,6 +2086,8 @@ static int fbcon_switch(struct vc_data *
 		logo_shown = -1;
 	}
 
+	prev_console = info->currcon;
+
 	/*
 	 * FIXME: If we have multiple fbdev's loaded, we need to
 	 * update all info->currcon.  Perhaps, we can place this
@@ -2065,7 +2114,11 @@ static int fbcon_switch(struct vc_data *
 	info->var.yoffset = info->var.xoffset = p->yscroll = 0;
 	fb_set_var(info, &var);
 
-	if (info->flags & FBINFO_MISC_MODESWITCH) {
+	if (prev_console != -1 &&
+	    registered_fb[(int) con2fb_map[prev_console]] != info)
+		do_set_par = 1;
+
+	if (do_set_par || info->flags & FBINFO_MISC_MODESWITCH) {
 		if (info->fbops->fb_set_par)
 			info->fbops->fb_set_par(info);
 		info->flags &= ~FBINFO_MISC_MODESWITCH;
@@ -2098,6 +2151,7 @@ static int fbcon_switch(struct vc_data *
 	if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
 		accel_clear_margins(vc, info, 0);
 	if (logo_shown == -2) {
+
 		logo_shown = fg_console;
 		/* This is protected above by initmem_freed */
 		fb_show_logo(info);
@@ -2753,11 +2807,22 @@ static int fbcon_mode_deleted(struct fb_
 
 static int fbcon_fb_registered(int idx)
 {
-	int ret = 0;
+	int ret = 0, i;
 
 	if (info_idx == -1) {
-		info_idx = idx;
-		ret = fbcon_takeover();
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			if (con2fb_map_boot[i] == idx) {
+				info_idx = idx;
+				break;
+			}
+		}
+		if (info_idx != -1)
+			ret = fbcon_takeover(1);
+	} else {
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			if (con2fb_map_boot[i] == idx)
+				set_con2fb_map(i, idx, 0);
+		}
 	}
 
 	return ret;
@@ -2791,7 +2856,8 @@ static int fbcon_event_notify(struct not
 		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		con2fb = (struct fb_con2fbmap *) event->data;
-		ret = set_con2fb_map(con2fb->console - 1, con2fb->framebuffer);
+		ret = set_con2fb_map(con2fb->console - 1,
+				     con2fb->framebuffer, 1);
 		break;
 	case FB_EVENT_GET_CONSOLE_MAP:
 		con2fb = (struct fb_con2fbmap *) event->data;
@@ -2854,7 +2920,7 @@ int __init fb_console_init(void)
 				break;
 			}
 		}
-		fbcon_takeover();
+		fbcon_takeover(0);
 	}
 
 	return 0;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm4/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-09 19:11:12.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-09 19:12:09.479717136 +0800
@@ -938,14 +938,11 @@ fb_ioctl(struct inode *inode, struct fil
 #endif /* CONFIG_KMOD */
 		if (!registered_fb[con2fb.framebuffer])
 		    return -EINVAL;
-		if (con2fb.console > 0 && con2fb.console < MAX_NR_CONSOLES) {
-			event.info = info;
-			event.data = &con2fb;
-			return notifier_call_chain(&fb_notifier_list,
-						   FB_EVENT_SET_CONSOLE_MAP,
-						   &event);
-		}
-		return -EINVAL;
+		event.info = info;
+		event.data = &con2fb;
+		return notifier_call_chain(&fb_notifier_list,
+					   FB_EVENT_SET_CONSOLE_MAP,
+					   &event);
 	case FBIOBLANK:
 		acquire_console_sem();
 		i = fb_blank(info, arg);



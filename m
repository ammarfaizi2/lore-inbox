Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUB0HO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUB0HO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:14:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:19130 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261809AbUB0HNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:13:33 -0500
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arief# <arief_m_utama@telkomsel.co.id>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1077863238.2522.6.camel@damai.telkomsel.co.id>
References: <1077863238.2522.6.camel@damai.telkomsel.co.id>
Content-Type: text/plain
Message-Id: <1077865490.22215.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 18:04:51 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 17:27, arief# wrote:
> Dear all,
> 
> 
> Before, please cc me the answer, as I'm not on the list right now.
> 
> In 2.6.3 (including -mmX patches), radeon framebuffer seems to having
> problems. Everytime I do clear screen, it only 'half cleared'. I still
> can see the mark of the previous texts in shaded mode. And it does not
> do deletion well, too. 
> 
> Anybody else having the same problem?

If it happens only after switching back from XFree, then it's a known
problem. I have implemented a fix locally but got sidetracked before I
could test it properly. 

Can you test the patch below ? :

===== drivers/char/vt.c 1.61 vs edited =====
--- 1.61/drivers/char/vt.c	Thu Feb 19 14:43:03 2004
+++ edited/drivers/char/vt.c	Fri Feb 27 17:27:09 2004
@@ -2743,12 +2743,12 @@
      *  Called only if powerdown features are allowed.
      */
     switch (vesa_blank_mode) {
-	case VESA_NO_BLANKING:
-	    c->vc_sw->con_blank(c, VESA_VSYNC_SUSPEND+1);
+    case VESA_NO_BLANKING:
+	    c->vc_sw->con_blank(c, VESA_VSYNC_SUSPEND+1, 0);
 	    break;
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
-	    c->vc_sw->con_blank(c, VESA_POWERDOWN+1);
+    case VESA_VSYNC_SUSPEND:
+    case VESA_HSYNC_SUSPEND:
+	    c->vc_sw->con_blank(c, VESA_POWERDOWN+1, 0);
 	    break;
     }
 }
@@ -2776,7 +2776,7 @@
 	if (entering_gfx) {
 		hide_cursor(currcons);
 		save_screen(currcons);
-		sw->con_blank(vc_cons[currcons].d, -1);
+		sw->con_blank(vc_cons[currcons].d, -1, 1);
 		console_blanked = fg_console + 1;
 		set_origin(currcons);
 		return;
@@ -2794,7 +2794,7 @@
 
 	save_screen(currcons);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	i = sw->con_blank(vc_cons[currcons].d, 1);
+	i = sw->con_blank(vc_cons[currcons].d, 1, 0);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(currcons);
@@ -2808,14 +2808,14 @@
 	}
 
     	if (vesa_blank_mode)
-		sw->con_blank(vc_cons[currcons].d, vesa_blank_mode + 1);
+		sw->con_blank(vc_cons[currcons].d, vesa_blank_mode + 1, 0);
 }
 
 
 /*
  * Called by timer as well as from vt_console_driver
  */
-void unblank_screen(void)
+void do_unblank_screen(int leaving_gfx)
 {
 	int currcons;
 
@@ -2839,13 +2839,24 @@
 	}
 
 	console_blanked = 0;
-	if (sw->con_blank(vc_cons[currcons].d, 0))
+	if (sw->con_blank(vc_cons[currcons].d, 0, leaving_gfx))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(currcons);
 	set_cursor(fg_console);
+}
+
+/*
+ * This is called by the outside world to cause a forced unblank, mostly for
+ * oopses. Currently, I just call do_unblank_screen(0), but we could eventually
+ * call it with 1 as an argument and so force a mode restore... that may kill
+ * X or at least garbage the screen but would also make the Oops visible...
+ */
+void unblank_screen(void)
+{
+	do_unblank_screen(0);
 }
 
 /*
===== drivers/char/vt_ioctl.c 1.34 vs edited =====
--- 1.34/drivers/char/vt_ioctl.c	Wed Feb 25 21:31:13 2004
+++ edited/drivers/char/vt_ioctl.c	Fri Feb 27 17:27:21 2004
@@ -497,7 +497,7 @@
 		 */
 		acquire_console_sem();
 		if (arg == KD_TEXT)
-			unblank_screen();
+			do_unblank_screen(1);
 		else
 			do_blank_screen(1);
 		release_console_sem();
@@ -1103,7 +1103,7 @@
 	if (old_vc_mode != vt_cons[new_console]->vc_mode)
 	{
 		if (vt_cons[new_console]->vc_mode == KD_TEXT)
-			unblank_screen();
+			do_unblank_screen(1);
 		else
 			do_blank_screen(1);
 	}
@@ -1138,7 +1138,7 @@
 			if (old_vc_mode != vt_cons[new_console]->vc_mode)
 			{
 				if (vt_cons[new_console]->vc_mode == KD_TEXT)
-					unblank_screen();
+					do_unblank_screen(1);
 				else
 					do_blank_screen(1);
 			}
===== drivers/video/fbmem.c 1.90 vs edited =====
--- 1.90/drivers/video/fbmem.c	Mon Feb 16 23:42:15 2004
+++ edited/drivers/video/fbmem.c	Fri Feb 27 17:25:21 2004
@@ -943,7 +943,8 @@
 {
 	int err;
 
-	if (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
+	if ((var->activate & FB_ACTIVATE_FORCE) ||
+	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
 		if (!info->fbops->fb_check_var) {
 			*var = info->var;
 			return 0;
===== drivers/video/console/fbcon.c 1.109 vs edited =====
--- 1.109/drivers/video/console/fbcon.c	Mon Feb 16 05:22:04 2004
+++ edited/drivers/video/console/fbcon.c	Fri Feb 27 17:47:24 2004
@@ -159,7 +159,7 @@
 static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width);
 static int fbcon_switch(struct vc_data *vc);
-static int fbcon_blank(struct vc_data *vc, int blank);
+static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch);
 static int fbcon_font_op(struct vc_data *vc, struct console_font_op *op);
 static int fbcon_set_palette(struct vc_data *vc, unsigned char *table);
 static int fbcon_scrolldelta(struct vc_data *vc, int lines);
@@ -1696,14 +1696,23 @@
 	return 1;
 }
 
-static int fbcon_blank(struct vc_data *vc, int blank)
+static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
-	if (blank < 0)		/* Entering graphics mode */
-		return 0;
+	if (mode_switch) {
+		struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+		struct fb_var_screeninfo var = info->var;
+
+		if (blank) {
+			fbcon_cursor(vc, CM_ERASE);
+			return 0;
+		}
+		var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
+		fb_set_var(info, &var);
+	}
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
===== drivers/video/console/promcon.c 1.9 vs edited =====
--- 1.9/drivers/video/console/promcon.c	Wed Dec 11 14:49:09 2002
+++ edited/drivers/video/console/promcon.c	Fri Feb 27 17:24:34 2004
@@ -463,7 +463,7 @@
 }
         
 static int
-promcon_blank(struct vc_data *conp, int blank)
+promcon_blank(struct vc_data *conp, int blank, int mode_switch)
 {
 	if (blank) {
 		promcon_puts("\033[H\033[J\033[7m \033[m\b", 15);
===== drivers/video/console/sticon.c 1.8 vs edited =====
--- 1.8/drivers/video/console/sticon.c	Wed Jan  8 11:45:15 2003
+++ edited/drivers/video/console/sticon.c	Fri Feb 27 17:24:42 2004
@@ -250,26 +250,18 @@
     return 0;
 }
 
-static int sticon_blank(struct vc_data *c, int blank)
+static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
 {
-    switch (blank) {
-    case 0:		/* unblank */
-	vga_is_gfx = 0;
-	/* Tell console.c that it has to restore the screen itself */
-	return 1;
-    case 1:		/* normal blanking */
-    default:		/* VESA blanking */
-	if (vga_is_gfx)
-		return 0;
-	sticon_set_origin(c);
-	sti_clear(sticon_sti, 0,0, c->vc_rows, c->vc_cols, BLANK);
-	return 1;
-    case -1:		/* Entering graphic mode */
-	sti_clear(sticon_sti, 0,0, c->vc_rows, c->vc_cols, BLANK);
-	vga_is_gfx = 1;
+    if (blank == 0) {
+	if (mode_switch)
+	    vga_is_gfx = 0;
 	return 1;
     }
-    return 1;		/* console needs to restore screen itself */
+    sticon_set_origin(c);
+    sti_clear(sticon_sti, 0,0, c->vc_rows, c->vc_cols, BLANK);
+    if (mode_switch)
+	vga_is_gfx = 1;
+    return 1;
 }
 
 static int sticon_scrolldelta(struct vc_data *conp, int lines)
===== drivers/video/console/vgacon.c 1.15 vs edited =====
--- 1.15/drivers/video/console/vgacon.c	Wed Mar 12 04:17:29 2003
+++ edited/drivers/video/console/vgacon.c	Fri Feb 27 17:24:57 2004
@@ -76,7 +76,7 @@
 static void vgacon_deinit(struct vc_data *c);
 static void vgacon_cursor(struct vc_data *c, int mode);
 static int vgacon_switch(struct vc_data *c);
-static int vgacon_blank(struct vc_data *c, int blank);
+static int vgacon_blank(struct vc_data *c, int blank, int mode_switch);
 static int vgacon_font_op(struct vc_data *c, struct console_font_op *op);
 static int vgacon_set_palette(struct vc_data *vc, unsigned char *table);
 static int vgacon_scrolldelta(struct vc_data *c, int lines);
@@ -661,7 +661,7 @@
 	}
 }
 
-static int vgacon_blank(struct vc_data *c, int blank)
+static int vgacon_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	switch (blank) {
 	case 0:		/* Unblank */
@@ -678,7 +678,8 @@
 		/* Tell console.c that it has to restore the screen itself */
 		return 1;
 	case 1:		/* Normal blanking */
-		if (vga_video_type == VIDEO_TYPE_VGAC) {
+	case -1:	/* Obsolete */
+		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
 			vga_pal_blank(&state);
 			vga_palette_blanked = 1;
 			return 0;
@@ -686,11 +687,8 @@
 		vgacon_set_origin(c);
 		scr_memsetw((void *) vga_vram_base, BLANK,
 			    c->vc_screenbuf_size);
-		return 1;
-	case -1:		/* Entering graphic mode */
-		scr_memsetw((void *) vga_vram_base, BLANK,
-			    c->vc_screenbuf_size);
-		vga_is_gfx = 1;
+		if (mode_switch)
+			vga_is_gfx = 1;
 		return 1;
 	default:		/* VESA blanking */
 		if (vga_video_type == VIDEO_TYPE_VGAC) {
===== include/linux/console.h 1.11 vs edited =====
--- 1.11/include/linux/console.h	Wed Feb  4 16:28:11 2004
+++ edited/include/linux/console.h	Fri Feb 27 17:26:10 2004
@@ -37,7 +37,7 @@
 	int	(*con_scroll)(struct vc_data *, int, int, int, int);
 	void	(*con_bmove)(struct vc_data *, int, int, int, int, int, int);
 	int	(*con_switch)(struct vc_data *);
-	int	(*con_blank)(struct vc_data *, int);
+	int	(*con_blank)(struct vc_data *, int, int);
 	int	(*con_font_op)(struct vc_data *, struct console_font_op *);
 	int	(*con_resize)(struct vc_data *, unsigned int, unsigned int);
 	int	(*con_set_palette)(struct vc_data *, unsigned char *);
===== include/linux/fb.h 1.60 vs edited =====
--- 1.60/include/linux/fb.h	Mon Feb 16 04:07:11 2004
+++ edited/include/linux/fb.h	Fri Feb 27 17:26:19 2004
@@ -152,6 +152,7 @@
 #define FB_ACTIVATE_VBL	       16	/* activate values on next vbl  */
 #define FB_CHANGE_CMAP_VBL     32	/* change colormap on vbl	*/
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
+#define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
 
 #define FB_ACCELF_TEXT		1	/* text mode acceleration */
 
===== include/linux/vt_kern.h 1.9 vs edited =====
--- 1.9/include/linux/vt_kern.h	Wed Mar 12 04:17:29 2003
+++ edited/include/linux/vt_kern.h	Fri Feb 27 17:25:42 2004
@@ -44,7 +44,8 @@
 void vc_disallocate(unsigned int console);
 void reset_palette(int currcons);
 void set_palette(int currcons);
-void do_blank_screen(int gfx_mode);
+void do_blank_screen(int entering_gfx);
+void do_unblank_screen(int leaving_gfx);
 void unblank_screen(void);
 void poke_blanked_console(void);
 int con_font_op(int currcons, struct console_font_op *op);



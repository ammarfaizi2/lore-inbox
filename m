Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVBRSCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVBRSCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVBRSCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:02:00 -0500
Received: from gprs215-224.eurotel.cz ([160.218.215.224]:13762 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261447AbVBRSAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:00:47 -0500
Date: Fri, 18 Feb 2005 17:52:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: stepan@bootsplash.org
Subject: Bootsplash for 2.6.11-rc4
Message-ID: <20050218165254.GA1359@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just in case someone is interested, this is bootsplash for 2.6.11-rc4,
taken from suse kernel. I'll probably try to modify it to work with
radeonfb.

Any ideas why bootsplash needs to hack into vesafb? It only uses
vesafb_ops to test against them before some kind of free...

								Pavel

--- clean/drivers/char/keyboard.c	2005-01-22 21:24:52.000000000 +0100
+++ linux-suse/drivers/char/keyboard.c	2005-02-18 16:13:06.000000000 +0100
@@ -1058,6 +1058,15 @@
 			if (keycode < BTN_MISC)
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
+#ifdef CONFIG_BOOTSPLASH
+	/* This code has to be redone for some non-x86 platforms */
+	if (down == 1 && (keycode == 0x3c || keycode == 0x01)) {        /* F2 and ESC on PC keyboard */
+		extern int splash_verbose(void);
+		if (splash_verbose())
+			return; 
+	}       
+#endif
+
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
 	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
 		sysrq_down = down;
--- clean/drivers/char/n_tty.c	2005-02-03 22:27:12.000000000 +0100
+++ linux-suse/drivers/char/n_tty.c	2005-02-18 16:13:06.000000000 +0100
@@ -1299,6 +1299,15 @@
 			tty->minimum_to_wake = (minimum - (b - buf));
 		
 		if (!input_available_p(tty, 0)) {
+#ifdef CONFIG_BOOTSPLASH
+			if (file->f_dentry->d_inode->i_rdev == MKDEV(TTY_MAJOR,0) ||
+			    file->f_dentry->d_inode->i_rdev == MKDEV(TTY_MAJOR,1) ||
+			    file->f_dentry->d_inode->i_rdev == MKDEV(TTYAUX_MAJOR,0) ||
+			    file->f_dentry->d_inode->i_rdev == MKDEV(TTYAUX_MAJOR,1)) {
+				extern int splash_verbose(void);
+				(void)splash_verbose();
+			}
+#endif
 			if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
 				retval = -EIO;
 				break;
--- clean/drivers/char/vt.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-suse/drivers/char/vt.c	2005-02-18 16:13:06.000000000 +0100
@@ -3251,6 +3251,31 @@
 	return 0;
 }
 
+#ifdef CONFIG_BOOTSPLASH
+void con_remap_def_color(int currcons, int new_color)
+{
+       unsigned short *sbuf = screenbuf;
+       unsigned c, len = screenbuf_size >> 1;
+       int old_color;
+
+       if (sbuf) {
+	       old_color = def_color << 8;
+	       new_color <<= 8;
+	       while(len--) {
+		       c = *sbuf;
+		       if (((c ^ old_color) & 0xf000) == 0)
+			       *sbuf ^= (old_color ^ new_color) & 0xf000; 
+		       if (((c ^ old_color) & 0x0f00) == 0)
+			       *sbuf ^= (old_color ^ new_color) & 0x0f00;
+		       sbuf++;
+	       }
+	       new_color >>= 8;
+       }
+       def_color = color = new_color;
+       update_attr(currcons);
+}
+#endif
+
 /*
  *	Visible symbols for modules
  */
--- clean/drivers/video/Kconfig	2005-02-03 22:27:18.000000000 +0100
+++ linux-suse/drivers/video/Kconfig	2005-02-18 16:13:06.000000000 +0100
@@ -1140,5 +1140,9 @@
 	source "drivers/video/backlight/Kconfig"
 endif
 
+if FB
+	source "drivers/video/bootsplash/Kconfig"
+endif
+
 endmenu
 
--- clean/drivers/video/Makefile	2005-02-03 22:27:18.000000000 +0100
+++ linux-suse/drivers/video/Makefile	2005-02-18 16:13:06.000000000 +0100
@@ -7,6 +7,7 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
+obj-$(CONFIG_BOOTSPLASH)	  += bootsplash/
 
 obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
--- clean/drivers/video/console/bitblit.c	2004-12-25 13:35:01.000000000 +0100
+++ linux-suse/drivers/video/console/bitblit.c	2005-02-18 16:13:06.000000000 +0100
@@ -18,6 +18,9 @@
 #include <linux/console.h>
 #include <asm/types.h>
 #include "fbcon.h"
+#ifdef CONFIG_BOOTSPLASH
+#include "../bootsplash/bootsplash.h"
+#endif
 
 /*
  * Accelerated handlers.
@@ -77,6 +80,13 @@
 {
 	struct fb_copyarea area;
 
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data) {
+		splash_bmove(info->splash_data, vc, info,
+			sy, sx, dy, dx, height, width);
+		return;
+	}
+#endif
 	area.sx = sx * vc->vc_font.width;
 	area.sy = sy * vc->vc_font.height;
 	area.dx = dx * vc->vc_font.width;
@@ -93,6 +103,13 @@
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	struct fb_fillrect region;
 
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data) {
+		splash_clear(info->splash_data, vc, info,
+						sy, sx, height, width);
+		return;
+	}
+#endif
 	region.color = attr_bgcol_ec(bgshift, vc);
 	region.dx = sx * vc->vc_font.width;
 	region.dy = sy * vc->vc_font.height;
@@ -127,6 +144,13 @@
 	struct fb_image image;
 	u8 *src, *dst, *buf = NULL;
 
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data) {
+		splash_putcs(info->splash_data, vc, info, s, count, yy, xx);
+		return;
+	}
+#endif
+
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_KERNEL);
 		if (!buf)
@@ -215,6 +239,13 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data) {
+		splash_clear_margins(info->splash_data, vc, info, bottom_only);
+		return;
+	}
+#endif
+
 	region.color = attr_bgcol_ec(bgshift, vc);
 	region.rop = ROP_COPY;
 
@@ -373,6 +404,13 @@
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data) {
+	    splash_cursor(info->splash_data, info, &cursor);
+	    ops->cursor_reset = 0;
+	    return;
+	}
+#endif
 	info->fbops->fb_cursor(info, &cursor);
 
 	ops->cursor_reset = 0;
--- clean/drivers/video/console/fbcon.c	2005-02-03 22:27:18.000000000 +0100
+++ linux-suse/drivers/video/console/fbcon.c	2005-02-18 16:13:06.000000000 +0100
@@ -93,6 +93,9 @@
 #endif
 
 #include "fbcon.h"
+#ifdef CONFIG_BOOTSPLASH
+#include "../bootsplash/bootsplash.h"
+#endif
 
 #ifdef FBCONDEBUG
 #  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
@@ -395,6 +398,10 @@
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		con2fb_map[i] = info_idx;
 
+#ifdef CONFIG_BOOTSPLASH
+	splash_init();
+#endif
+
 	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
 				fbcon_is_default);
 	if (err) {
@@ -937,6 +944,16 @@
 	rows = vc->vc_rows;
 	new_cols = info->var.xres / vc->vc_font.width;
 	new_rows = info->var.yres / vc->vc_font.height;
+
+#ifdef CONFIG_BOOTSPLASH
+	if (vc->vc_splash_data && vc->vc_splash_data->splash_state) {
+		new_cols = vc->vc_splash_data->splash_text_wi / vc->vc_font.width;
+		new_rows = vc->vc_splash_data->splash_text_he / vc->vc_font.height;
+		logo = 0;
+		con_remap_def_color(vc->vc_num, vc->vc_splash_data->splash_color << 4 | vc->vc_splash_data->splash_fg_color);
+	}
+#endif
+
 	vc_resize(vc->vc_num, new_cols, new_rows);
 	/*
 	 * We must always set the mode. The mode of the previous console
@@ -1562,6 +1579,10 @@
 			fbcon_softback_note(vc, t, count);
 		if (logo_shown >= 0)
 			goto redraw_up;
+#ifdef CONFIG_BOOTSPLASH
+		if (info->splash_data)
+			goto redraw_up;
+#endif
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
 			ops->bmove(vc, info, t + count, 0, t, 0,
@@ -1646,6 +1667,10 @@
 	case SM_DOWN:
 		if (count > vc->vc_rows)	/* Maximum realistic size */
 			count = vc->vc_rows;
+#ifdef CONFIG_BOOTSPLASH
+		if (info->splash_data)
+			goto redraw_down;
+#endif
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
 			ops->bmove(vc, info, t, 0, t + count, 0,
@@ -1788,6 +1813,14 @@
 		}
 		return;
 	}
+
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data && sy == dy && height == 1) {
+		/* must use slower redraw bmove to keep background pic intact */
+		splash_bmove_redraw(info->splash_data, vc, info, sy, sx, dx, width);
+		return;
+	}
+#endif
 	ops->bmove(vc, info, real_y(p, sy), sx, real_y(p, dy), dx,
 		   height, width);
 }
@@ -1890,6 +1923,10 @@
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
 
+#ifdef CONFIG_BOOTSPLASH
+	splash_prepare(vc, info);
+#endif
+
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -1999,6 +2036,12 @@
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 				int blank)
 {
+#ifdef CONFIG_BOOTSPLASH
+	if (info->splash_data) {
+		splash_blank(info->splash_data, vc, info, blank);
+		return;
+	}
+#endif
 	if (blank) {
 		unsigned short charmask = vc->vc_hi_font_mask ?
 			0x1ff : 0xff;
@@ -2196,8 +2239,15 @@
 	}
 
 	if (resize) {
+		u32 xres = info->var.xres, yres = info->var.yres;
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+#ifdef CONFIG_BOOTSPLASH
+		if (info->splash_data) {
+			xres = info->splash_data->splash_text_wi;
+			yres = info->splash_data->splash_text_he;
+		}
+#endif
 		vc_resize(vc->vc_num, info->var.xres / w, info->var.yres / h);
 		if (CON_IS_VISIBLE(vc) && softback_buf) {
 			int l = fbcon_softback_size / vc->vc_size_row;
--- clean/drivers/video/console/fbcon.h	2005-01-22 21:24:52.000000000 +0100
+++ linux-suse/drivers/video/console/fbcon.h	2005-02-18 16:13:06.000000000 +0100
@@ -23,6 +23,34 @@
     *    low-level frame buffer device
     */
 
+#ifdef CONFIG_BOOTSPLASH
+struct splash_data {
+    int splash_state;			/* show splash? */
+    int splash_color;			/* transparent color */
+    int splash_fg_color;		/* foreground color */
+    int splash_width;			/* width of image */
+    int splash_height;			/* height of image */
+    int splash_text_xo;			/* text area origin */
+    int splash_text_yo;
+    int splash_text_wi;			/* text area size */ 
+    int splash_text_he;
+    int splash_showtext;		/* silent/verbose mode */
+    int splash_boxcount;
+    int splash_percent;
+    int splash_overpaintok;		/* is it ok to overpaint boxes */
+    int splash_palcnt;
+    char *oldscreen_base;		/* pointer to top of virtual screen */
+    unsigned char *splash_boxes;
+    unsigned char *splash_jpeg;		/* jpeg */
+    unsigned char *splash_palette;	/* palette for 8-bit */
+
+    int splash_dosilent;		/* show silent jpeg */
+    unsigned char *splash_silentjpeg;
+    unsigned char *splash_sboxes;
+    int splash_sboxcount;
+};
+#endif
+
 struct display {
     /* Filled in by the frame buffer device */
     u_short inverse;                /* != 0 text black on white as default */
--- clean/drivers/video/vesafb.c	2005-02-03 22:27:19.000000000 +0100
+++ linux-suse/drivers/video/vesafb.c	2005-02-18 16:13:06.000000000 +0100
@@ -175,7 +175,10 @@
     return 0;
 }
 
-static struct fb_ops vesafb_ops = {
+#ifndef CONFIG_BOOTSPLASH
+static
+#endif
+struct fb_ops vesafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_setcolreg	= vesafb_setcolreg,
 	.fb_pan_display	= vesafb_pan_display,
@@ -260,6 +263,9 @@
 	 *                 option to simply use size_total as that
 	 *                 wastes plenty of kernel address space. */
 	size_remap  = size_vmode * 2;
+#ifdef CONFIG_BOOTSPLASH
+	size_remap *= 2;	/* some more for the images */
+#endif
 	if (vram_remap)
 		size_remap = vram_remap * 1024 * 1024;
 	if (size_remap < size_vmode)
Only in linux-suse/include/asm-i386: asm_offsets.h
--- clean/include/linux/console_struct.h	2005-01-12 11:07:40.000000000 +0100
+++ linux-suse/include/linux/console_struct.h	2005-02-18 16:13:06.000000000 +0100
@@ -89,6 +89,9 @@
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
 	unsigned long	vc_uni_pagedir;
 	unsigned long	*vc_uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
+#ifdef CONFIG_BOOTSPLASH
+	struct splash_data *vc_splash_data;
+#endif
 	struct vt_struct *vc_vt;
 	/* additional information is in vt_kern.h */
 };
--- clean/include/linux/fb.h	2005-01-22 21:24:53.000000000 +0100
+++ linux-suse/include/linux/fb.h	2005-02-18 16:13:06.000000000 +0100
@@ -726,6 +726,14 @@
 	void *fbcon_par;                /* fbcon use-only private area */
 	/* From here on everything is device dependent */
 	void *par;	
+#ifdef CONFIG_BOOTSPLASH
+	struct splash_data *splash_data;
+	unsigned char *splash_pic;
+	int splash_pic_size;
+	int splash_bytes;
+	char *silent_screen_base;	/* real screen base */
+	char fb_cursordata[64];
+#endif
 };
 
 #ifdef MODULE
Only in linux-suse/kernel: config_data.gz
--- clean/kernel/power/swsusp.c	2005-01-22 21:24:53.000000000 +0100
+++ linux-suse/kernel/power/swsusp.c	2005-02-18 16:13:20.000000000 +0100
@@ -1204,6 +1204,14 @@
 		return error;
 	if ((error = check_header()))
 		return error;
+
+#ifdef CONFIG_BOOTSPLASH
+	{
+		extern int splash_verbose(void);
+		(void)splash_verbose();
+	}
+#endif
+
 	if ((error = read_pagedir()))
 		return error;
 	if ((error = data_read()))


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

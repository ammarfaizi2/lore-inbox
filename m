Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbTBNFTt>; Fri, 14 Feb 2003 00:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268181AbTBNFTt>; Fri, 14 Feb 2003 00:19:49 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:37194 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S268182AbTBNFTo>; Fri, 14 Feb 2003 00:19:44 -0500
Subject: [PATCH][FBDEV]: fbcon module unloading
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1045199953.1589.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 13:30:34 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Although fbcon can be compiled as a module, it cannot be safely unloaded
yet.  If fbcon is unloaded, it typically results in a frozen box. 
Allowing fbcon to successfully unload may be not so useful with typical
usage, but will be very helpful for developers. So here's a preliminary
patch to allow unloading of fbcon.

The main logic of the patch is when a console driver calls
take_over_console(), 'conswitchp' will be saved to 'defcsw'.  When it
calls give_up_console() later on, aside from just unmapping the console
driver (which is what the original code does), it will also attempt to
reinstall the default console using the saved 'defcsw'pointer.

To minimize complexity, only one driver will be allowed to 'take over'
the console at a time.  Succeeding calls to take_over_console() will
fail unless the driver gives up the console.

I made this a kernel config option, marked DANGEROUS. Also, only drivers
with an info->fbops->fb_release() hook will be allowed to unload. The
fb_release() hook need not do anything. Currently, fbcon on top of
vga16fb, rivafb or i810fb can be unloaded.  I have tested this using
dummycon and vgacon. 

Upon unload, the restored console will be partially corrupted.  Also, I
think unicode mapped characters are not fully restored.

Any comments welcome.

Tony


diff -Naur linux-2.5.59-orig/drivers/char/vt.c linux-2.5.59/drivers/char/vt.c
--- linux-2.5.59-orig/drivers/char/vt.c	2003-02-14 02:43:42.000000000 +0000
+++ linux-2.5.59/drivers/char/vt.c	2003-02-14 03:15:50.000000000 +0000
@@ -109,6 +109,7 @@
 

 const struct consw *conswitchp;
+const struct consw *defcsw = NULL; /* for recovery of default console */
 
 /* A bitmap for codes <32. A bit of 1 indicates that the code
  * corresponding to that bit number invokes some special action
@@ -2571,10 +2572,14 @@
 	int i, j = -1;
 	const char *desc;
 
+	if (deflt && defcsw != NULL)
+		return;
 	desc = csw->con_startup();
 	if (!desc) return;
-	if (deflt)
+	if (deflt) {
+		defcsw = conswitchp;
 		conswitchp = csw;
+	}
 
 	for (i = first; i <= last; i++) {
 		int old_was_color;
@@ -2616,11 +2621,78 @@
 
 void give_up_console(const struct consw *csw)
 {
-	int i;
+	const char *desc;
+	int i, j = -1, first = -1, last = -1;
 
-	for(i = 0; i < MAX_NR_CONSOLES; i++)
-		if (con_driver_map[i] == csw)
+	for(i = 0; i < MAX_NR_CONSOLES; i++) {
+		if (con_driver_map[i] == csw) {
+			if (first == -1)
+				first = i;
+			last = i;
 			con_driver_map[i] = NULL;
+		}
+	}
+
+	if (defcsw == NULL)
+		return;
+	conswitchp = defcsw;
+	defcsw = NULL;
+
+	desc = conswitchp->con_startup();
+	if (!desc) return;
+
+	for (i = first; i <= last; i++) {
+		int old_was_color;
+		int currcons = i;
+
+		con_driver_map[i] = conswitchp;
+
+		if (!vc_cons[i].d || !vc_cons[i].d->vc_sw)
+			continue;
+		j = i;
+		if (IS_VISIBLE)
+			save_screen(i);
+		old_was_color = vc_cons[i].d->vc_can_do_color;
+		vc_cons[i].d->vc_sw->con_deinit(vc_cons[i].d);
+		visual_init(i, 0);
+		set_origin(i);
+
+		/*
+		 * partial reset_terminal()
+		 */
+		top = 0;
+		bottom = video_num_lines;
+		gotoxy(i, x, y);
+		save_cur(i);
+		update_attr(i);
+
+
+		/* If the console changed between mono <-> color, then
+		 * the attributes in the screenbuf will be wrong.  The
+		 * following resets all attributes to something sane.
+		 */
+		if (old_was_color != vc_cons[i].d->vc_can_do_color ||
+		    IS_VISIBLE)
+			clear_buffer_attributes(i);
+
+		if (IS_VISIBLE)
+			update_screen(i);
+		if (vc_cons[i].d->vc_tty) {
+			kill_pg(vc_cons[i].d->vc_tty->pgrp, SIGWINCH, 1);
+			vc_cons[i].d->vc_tty->winsize.ws_col = 
+				video_num_columns;
+			vc_cons[i].d->vc_tty->winsize.ws_row = 
+				video_num_lines;
+		}
+	}
+	printk("Console: switching ");
+	if (j >= 0)
+		printk("to %s %s %dx%d\n",
+		       vc_cons[j].d->vc_can_do_color ? "colour" : "mono",
+		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
+	else
+		printk("to %s\n", desc);
+
 }
 
 #endif
diff -Naur linux-2.5.59-orig/drivers/video/console/Kconfig linux-2.5.59/drivers/video/console/Kconfig
--- linux-2.5.59-orig/drivers/video/console/Kconfig	2003-02-14 02:50:50.000000000 +0000
+++ linux-2.5.59/drivers/video/console/Kconfig	2003-02-14 04:35:01.000000000 +0000
@@ -106,6 +106,19 @@
 	tristate "Framebuffer Console support"
 	depends on FB
 
+config FRAMEBUFFER_CONSOLE_UNLOAD
+	bool "Allow Framebuffer Console Module Unloading (DANGEROUS)"
+	depends on FRAMEBUFFER_CONSOLE=m
+	default n
+	---help---
+          If you say Y, the framebuffer console module can be unloaded 
+          and the console reverted to the default console driver that was
+          loaded at boot time.  Not all drivers support unloading, and even
+          if it does, it might leave you with a corrupted display.
+
+          Unless you are a framebuffer driver developer, or you really know
+          what you're doing, say N here.
+
 config PCI_CONSOLE
 	bool
 	depends on FRAMEBUFFER_CONSOLE
diff -Naur linux-2.5.59-orig/drivers/video/console/fbcon.c linux-2.5.59/drivers/video/console/fbcon.c
--- linux-2.5.59-orig/drivers/video/console/fbcon.c	2003-02-14 02:44:46.000000000 +0000
+++ linux-2.5.59/drivers/video/console/fbcon.c	2003-02-14 03:00:19.000000000 +0000
@@ -202,6 +202,23 @@
 static void fbcon_bmove_rec(struct display *p, int sy, int sx, int dy,
 			    int dx, int height, int width, u_int y_break);
 
+/*
+ * fbcon module unloading 
+ */
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD
+static void __init fbcon_mod_unload(struct fb_info *info)
+{
+	if (!info->fbops->fb_release)
+		__unsafe(THIS_MODULE);
+}
+#else
+static void __init fbcon_mod_unload(struct fb_info *info)
+{
+	__unsafe(THIS_MODULE);
+}
+#endif /* CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD */
+
 #ifdef CONFIG_MAC
 /*
  * On the Macintoy, there may or may not be a working VBL int. We need to probe
@@ -585,7 +602,7 @@
 	struct fb_info *info;
 	struct vc_data *vc;
 	static int done = 0;
-	int irqres = 1;
+	int irqres = 1, i;
 
 	/*
 	 *  If num_registered_fb is zero, this is a call for the dummy part.
@@ -595,8 +612,11 @@
 		return display_desc;
 	done = 1;
 
-	info = registered_fb[num_registered_fb-1];	
-	if (!info)	return NULL;
+	for (i = 0; i < FB_MAX; i++) {
+		info = registered_fb[i];	
+		if (info != NULL)
+			break;
+	}
 	info->currcon = -1;
 	
 	owner = info->fbops->owner;
@@ -2562,19 +2582,86 @@
 
 int __init fb_console_init(void)
 {
+	struct fb_info *info = NULL;
+	int i, unit = 0;
+
 	if (!num_registered_fb)
 		return -ENODEV;
+	for (i = 0; i < FB_MAX; i++) {
+		info = registered_fb[i];
+		if (info != NULL) {
+			unit = i;
+			break;
+		}
+	}
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
+		con2fb_map[i] = unit;
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
+	fbcon_mod_unload(info);
+	return 0;
+}
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD
+static int __exit fbcon_exit(void) 
+{
+	struct fb_info *info;
+	int i, j, mapped;
+
+	for (i = 0; i < FB_MAX; i++) {
+		info = registered_fb[i];
+		if (info != NULL && !info->fbops->fb_release)
+			return -EINVAL;
+	}
+
+	del_timer_sync(&cursor_timer);
+#ifdef CONFIG_AMIGA
+	if (MACH_IS_AMIGA) 
+		free_irq(IRQ_AMIGA_VERTB, fbcon_vbl_handler);
+#endif				/* CONFIG_AMIGA */
+#ifdef CONFIG_ATARI
+	if (MACH_IS_ATARI) 
+		free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
+#endif				/* CONFIG_ATARI */
+#ifdef CONFIG_MAC
+	if (MACH_IS_MAC && vbl_detected) 
+		free_irq(IRQ_MAC_VBL, fbcon_vbl_handler);
+#endif				/* CONFIG_MAC */
+#if defined(__arm__) && defined(IRQ_VSYNCPULSE)
+	free_irq(IRQ_VSYNCPULSE, fbcon_vbl_handler);
+#endif
+	if (softback_buf) 
+		kfree((void *) softback_buf);
+
+	for (i = 0; i < FB_MAX; i++) {
+		mapped = 0;
+		info = registered_fb[i];
+		if (info == NULL)
+			continue;
+		for (j = 0; j < MAX_NR_CONSOLES; j++) {
+			if (con2fb_map[j] == i) {
+				con2fb_map[j] = -1;
+				mapped = 1;
+			}
+		}
+		if (mapped) {
+			info->fbops->fb_release(info, 0); 
+			module_put(info->fbops->owner);
+			kfree(info->display_fg);
+		}
+	}
 	return 0;
 }
 
 void __exit fb_console_exit(void)
 {
+	if (fbcon_exit())
+		return;
 	give_up_console(&fb_con);
 }	
+module_exit(fb_console_exit);
+#endif /* CONFIG_FRAMEBUFFER_CONSOLE_UNLOAD */
 
 module_init(fb_console_init);
-module_exit(fb_console_exit);
 
 /*
  *  Visible symbols for modules
diff -Naur linux-2.5.59-orig/drivers/video/vga16fb.c linux-2.5.59/drivers/video/vga16fb.c
--- linux-2.5.59-orig/drivers/video/vga16fb.c	2003-02-14 02:43:49.000000000 +0000
+++ linux-2.5.59/drivers/video/vga16fb.c	2003-02-14 03:06:33.000000000 +0000
@@ -305,7 +305,8 @@
 
 	if (!cnt) {
 		memset(&par->state, 0, sizeof(struct vgastate));
-		par->state.flags = 8;
+		par->state.flags = VGA_SAVE_FONTS | VGA_SAVE_MODE |
+			VGA_SAVE_CMAP;
 		save_vga(&par->state);
 	}
 	atomic_inc(&par->ref_count);



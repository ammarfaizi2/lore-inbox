Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVBXLLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVBXLLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVBXLLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:11:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43281 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262214AbVBXLKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:10:49 -0500
Date: Thu, 24 Feb 2005 12:10:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/video/: misc cleanups
Message-ID: <20050224111048.GD8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains cleanups under drivers/video/ including:
- make some needlessly global code static
- the following was needlessly EXPORT_SYMBOL'ed:
  - fbcon.c: fb_con
  - fbmon.c: get_EDID_from_firmware (completely unused)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch applies and compiles against 2.6.11-rc4-mm1.

 drivers/video/console/fbcon.c  |   26 ++++++++++++--------------
 drivers/video/console/fbcon.h  |    1 -
 drivers/video/console/mdacon.c |    4 ++--
 drivers/video/fbmem.c          |    4 ++--
 drivers/video/fbmon.c          |   20 +-------------------
 drivers/video/vga16fb.c        |   24 ++++++++++++------------
 include/linux/console.h        |    1 -
 drivers/video/modedb.c         |    5 ++---
 8 files changed, 31 insertions(+), 54 deletions(-)

--- linux-2.6.10-rc2-mm2-full/include/linux/console.h.old	2004-11-21 15:20:38.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/include/linux/console.h	2004-11-21 15:20:46.000000000 +0100
@@ -59,7 +59,6 @@
 extern const struct consw *conswitchp;
 
 extern const struct consw dummy_con;	/* dummy console buffer */
-extern const struct consw fb_con;	/* frame buffer based console */
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
--- linux-2.6.10-rc2-mm2-full/drivers/video/console/fbcon.h.old	2004-11-21 15:26:10.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/console/fbcon.h	2004-11-21 15:26:19.000000000 +0100
@@ -155,7 +155,6 @@
 #define SCROLL_REDRAW	   0x004
 #define SCROLL_PAN_REDRAW  0x005
 
-extern int fb_console_init(void);
 #ifdef CONFIG_FB_TILEBLITTING
 extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
 			      struct display *p, struct fbcon_ops *ops);
--- linux-2.6.10-rc2-mm2-full/drivers/video/console/fbcon.c.old	2004-11-21 15:19:18.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/console/fbcon.c	2004-11-21 15:54:54.000000000 +0100
@@ -107,15 +107,15 @@
 };
 
 struct display fb_display[MAX_NR_CONSOLES];
-signed char con2fb_map[MAX_NR_CONSOLES];
-signed char con2fb_map_boot[MAX_NR_CONSOLES];
+static signed char con2fb_map[MAX_NR_CONSOLES];
+static signed char con2fb_map_boot[MAX_NR_CONSOLES];
 static int logo_height;
 static int logo_lines;
 /* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
    enums.  */
 static int logo_shown = FBCON_LOGO_CANSHOW;
 /* Software scrollback */
-int fbcon_softback_size = 32768;
+static int fbcon_softback_size = 32768;
 static unsigned long softback_buf, softback_curr;
 static unsigned long softback_in;
 static unsigned long softback_top, softback_end;
@@ -130,6 +130,8 @@
 /* current fb_info */
 static int info_idx = -1;
 
+static const struct consw fb_con;
+
 #define CM_SOFTBACK	(8)
 
 #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
@@ -305,7 +307,8 @@
 	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
-int __init fb_console_setup(char *this_opt)
+#ifndef MODULE
+static int __init fb_console_setup(char *this_opt)
 {
 	char *options;
 	int i, j;
@@ -359,6 +362,7 @@
 }
 
 __setup("fbcon=", fb_console_setup);
+#endif
 
 static int search_fb_in_map(int idx)
 {
@@ -1114,7 +1118,7 @@
 static int scrollback_max = 0;
 static int scrollback_current = 0;
 
-int update_var(int con, struct fb_info *info)
+static int update_var(int con, struct fb_info *info)
 {
 	if (con == ((struct fbcon_ops *)info->fbcon_par)->currcon)
 		return fb_pan_display(info, &info->var);
@@ -2709,7 +2713,7 @@
  *  The console `switch' structure for the frame buffer based console
  */
 
-const struct consw fb_con = {
+static const struct consw fb_con = {
 	.owner			= THIS_MODULE,
 	.con_startup 		= fbcon_startup,
 	.con_init 		= fbcon_init,
@@ -2739,7 +2743,7 @@
 	.notifier_call	= fbcon_event_notify,
 };
 
-int __init fb_console_init(void)
+static int __init fb_console_init(void)
 {
 	int i;
 
@@ -2767,7 +2771,7 @@
 
 #ifdef MODULE
 
-void __exit fb_console_exit(void)
+static void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
@@ -2779,10 +2783,4 @@
 
 #endif
 
-/*
- *  Visible symbols for modules
- */
-
-EXPORT_SYMBOL(fb_con);
-
 MODULE_LICENSE("GPL");
--- linux-2.6.10-rc2-mm2-full/drivers/video/console/mdacon.c.old	2004-11-21 15:27:40.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/console/mdacon.c	2004-11-21 15:28:21.000000000 +0100
@@ -576,7 +576,7 @@
  *  The console `switch' structure for the MDA based console
  */
 
-const struct consw mda_con = {
+static const struct consw mda_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		mdacon_startup,
 	.con_init =		mdacon_init,
@@ -603,7 +603,7 @@
 	return take_over_console(&mda_con, mda_first_vc-1, mda_last_vc-1, 0);
 }
 
-void __exit mda_console_exit(void)
+static void __exit mda_console_exit(void)
 {
 	give_up_console(&mda_con);
 }
--- linux-2.6.10-rc2-mm2-full/drivers/video/fbmem.c.old	2004-11-21 15:30:45.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/fbmem.c	2004-11-21 15:31:45.000000000 +0100
@@ -1147,7 +1147,7 @@
  *
  */
 
-int __init
+static int __init
 fbmem_init(void)
 {
 	create_proc_read_entry("fb", 0, NULL, fbmem_read_proc, NULL);
@@ -1221,7 +1221,7 @@
  *
  */
 
-int __init video_setup(char *options)
+static int __init video_setup(char *options)
 {
 	int i;
 
--- linux-2.6.10-rc2-mm2-full/drivers/video/fbmon.c.old	2004-11-21 15:32:05.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/fbmon.c	2004-11-21 15:32:56.000000000 +0100
@@ -66,10 +66,9 @@
 	},
 };
 
-const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
+static const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
 };
-const unsigned char edid_v1_descriptor_flag[] = { 0x00, 0x00 };
 
 static void copy_string(unsigned char *c, unsigned char *s)
 {
@@ -845,18 +844,6 @@
 	DPRINTK("========================================\n");
 }
 
-char *get_EDID_from_firmware(struct device *dev)
-{
-	unsigned char *pedid = NULL;
-
-#if defined(CONFIG_EDID_FIRMWARE) && defined(CONFIG_X86)
-	pedid = edid_info.dummy;
-	if (!pedid)
-		return NULL;
-#endif
-	return pedid;
-}
-
 /* 
  * VESA Generalized Timing Formula (GTF) 
  */
@@ -1166,10 +1153,6 @@
 {
 	specs = NULL;
 }
-char *get_EDID_from_firmware(struct device *dev)
-{
-	return NULL;
-}
 struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 {
 	return NULL;
@@ -1251,7 +1234,6 @@
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
-EXPORT_SYMBOL(get_EDID_from_firmware);
 
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
--- linux-2.6.10-rc2-mm2-full/drivers/video/vga16fb.c.old	2004-11-21 15:37:10.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/vga16fb.c	2004-11-21 15:38:46.000000000 +0100
@@ -874,7 +874,7 @@
 	return 0;
 }
 
-void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	u32 dx = rect->dx, width = rect->width;
         char oldindex = getindex();
@@ -928,7 +928,7 @@
         setindex(oldindex);
 }
 
-void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	int x, x2, y2, vxres, vyres, width, height, line_ofs;
 	char __iomem *dst;
@@ -1003,7 +1003,7 @@
 	}
 }
 
-void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
         char oldindex = getindex();
         char oldmode = setmode(0x41);
@@ -1058,7 +1058,7 @@
         setindex(oldindex);
 }
 
-void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy; 
 	int x, x2, y2, old_dx, old_dy, vxres, vyres;
@@ -1166,7 +1166,7 @@
 #endif
 #endif
 
-void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *image)
+static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *image)
 {
         char oldindex = getindex();
         char oldmode = setmode(0x40);
@@ -1197,7 +1197,7 @@
         setindex(oldindex);
 }
 
-void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
+static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
 {
 	char __iomem *where = info->screen_base + (image->dx/8) +
 		image->dy * info->fix.line_length;
@@ -1261,7 +1261,7 @@
 	}
 }
 
-void vga_imageblit_color(struct fb_info *info, const struct fb_image *image) 
+static void vga_imageblit_color(struct fb_info *info, const struct fb_image *image) 
 {
 	/*
 	 * Draw logo 
@@ -1306,7 +1306,7 @@
 	}
 }
 				
-void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image)
+static void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	if (image->depth == 1)
 		vga_imageblit_expand(info, image);
@@ -1329,7 +1329,8 @@
 	.fb_cursor      = soft_cursor,
 };
 
-int vga16fb_setup(char *options)
+#ifndef MODULE
+static int vga16fb_setup(char *options)
 {
 	char *this_opt;
 	
@@ -1341,8 +1342,9 @@
 	}
 	return 0;
 }
+#endif
 
-int __init vga16fb_init(void)
+static int __init vga16fb_init(void)
 {
 	int i;
 	int ret;
@@ -1427,9 +1429,7 @@
     /* XXX unshare VGA regions */
 }
 
-#ifdef MODULE
 MODULE_LICENSE("GPL");
-#endif
 module_init(vga16fb_init);
 module_exit(vga16fb_exit);
 

--- linux-2.6.11-rc3-mm2-full/drivers/video/modedb.c.old	2005-02-11 16:50:40.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/video/modedb.c	2005-02-11 16:49:36.000000000 +0100
@@ -404,8 +403,8 @@
  *
  */
 
-int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
-		const struct fb_videomode *mode, unsigned int bpp)
+static int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
+		       const struct fb_videomode *mode, unsigned int bpp)
 {
     int err = 0;
 

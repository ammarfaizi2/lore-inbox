Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUIIVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUIIVto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUIIVtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:49:23 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:46556 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267595AbUIIVeS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:18 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/7] fbdev: Fix userland compile breakage
Date: Fri, 10 Sep 2004 05:34:45 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Michal Januszewski <spock@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409100534.45467.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Michal Januszewski <spock@gentoo.org>

"The latest changes introduced to the fb structs in linux/fb.h make
compilation of userspace programs break with:

include/linux/fb.h:305: error: field `modelist' has incomplete type

This is caused by struct list_head not being seen from userspace."

This patch removes struct list_head modelist from struct fb_monspecs and
moves it to struct fb_info instead, and for now, enclosed struct
fb_monspecs by #ifdef __KERNEL__/#endif.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    4 -
 drivers/video/fbmem.c         |   16 ++--
 drivers/video/modedb.c        |    2
 drivers/video/riva/fbdev.c    |    6 -
 include/linux/fb.h            |  137 ++++++++++++++++++++----------------------
 5 files changed, 82 insertions(+), 83 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/console/fbcon.c	2004-09-10 04:43:53.017825616 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/console/fbcon.c	2004-09-10 04:44:19.923735296 +0800
@@ -689,7 +689,7 @@ static int var_to_display(struct display
 	disp->green = var->green;
 	disp->blue = var->blue;
 	disp->transp = var->transp;
-	disp->mode = fb_match_mode(var, &info->monspecs.modelist);
+	disp->mode = fb_match_mode(var, &info->modelist);
 	if (disp->mode == NULL)
 		/* This should not happen */
 		return -EINVAL;
@@ -1973,7 +1973,7 @@ static int fbcon_resize(struct vc_data *
 		struct fb_videomode *mode;
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
-		mode = fb_find_best_mode(&var, &info->monspecs.modelist);
+		mode = fb_find_best_mode(&var, &info->modelist);
 		if (mode == NULL)
 			return -EINVAL;
 		fb_videomode_to_var(&var, mode);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm4/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-10 04:43:53.019825312 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-10 04:44:19.927734688 +0800
@@ -791,7 +791,7 @@ fb_set_var(struct fb_info *info, struct 
 		}
 
 		if (!ret)
-		    fb_delete_videomode(&mode1, &info->monspecs.modelist);
+		    fb_delete_videomode(&mode1, &info->modelist);
 
 		return ret;
 	}
@@ -818,7 +818,7 @@ fb_set_var(struct fb_info *info, struct 
 			fb_set_cmap(&info->cmap, info);
 
 			fb_var_to_videomode(&mode, &info->var);
-			fb_add_videomode(&mode, &info->monspecs.modelist);
+			fb_add_videomode(&mode, &info->modelist);
 
 			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
 				struct fb_event event;
@@ -1164,14 +1164,14 @@ register_framebuffer(struct fb_info *fb_
 	}
 	fb_info->sprite.offset = 0;
 
-	if (!fb_info->monspecs.modelist.prev ||
-	    !fb_info->monspecs.modelist.next ||
-	    list_empty(&fb_info->monspecs.modelist)) {
+	if (!fb_info->modelist.prev ||
+	    !fb_info->modelist.next ||
+	    list_empty(&fb_info->modelist)) {
 	        struct fb_videomode mode;
 
-		INIT_LIST_HEAD(&fb_info->monspecs.modelist);
+		INIT_LIST_HEAD(&fb_info->modelist);
 		fb_var_to_videomode(&mode, &fb_info->var);
-		fb_add_videomode(&mode, &fb_info->monspecs.modelist);
+		fb_add_videomode(&mode, &fb_info->modelist);
 	}
 
 	registered_fb[i] = fb_info;
@@ -1209,7 +1209,7 @@ unregister_framebuffer(struct fb_info *f
 		kfree(fb_info->pixmap.addr);
 	if (fb_info->sprite.addr && (fb_info->sprite.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->sprite.addr);
-	fb_destroy_modelist(&fb_info->monspecs.modelist);
+	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
 	class_simple_device_remove(MKDEV(FB_MAJOR, i));
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/modedb.c linux-2.6.9-rc1-mm4/drivers/video/modedb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/modedb.c	2004-09-10 04:43:53.045821360 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/modedb.c	2004-09-09 19:11:12.000000000 +0800
@@ -670,7 +670,7 @@ int fb_mode_is_equal(struct fb_videomode
  *
  * IMPORTANT:
  * This function assumes that all modelist entries in
- * info->monspecs.modelist are valid.
+ * info->modelist are valid.
  *
  * NOTES:
  * Finds best matching videomode which has an equal or greater dimension than
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c	2004-09-10 04:43:53.047821056 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c	2004-09-10 04:44:12.244902656 +0800
@@ -1115,14 +1115,14 @@ static int rivafb_check_var(struct fb_va
 	}
 
 	if (!mode_valid) {
-		mode = fb_find_best_mode(var, &info->monspecs.modelist);
+		mode = fb_find_best_mode(var, &info->modelist);
 		if (mode) {
 			riva_update_var(var, mode);
 			mode_valid = 1;
 		}
 	}
 
-	if (!mode_valid && !list_empty(&info->monspecs.modelist))
+	if (!mode_valid && !list_empty(&info->modelist))
 		return -EINVAL;
 
 	if (var->xres_virtual < var->xres)
@@ -1797,7 +1797,7 @@ static void __devinit riva_get_edidinfo(
 
 	fb_edid_to_monspecs(par->EDID, &info->monspecs);
 	fb_videomode_to_modelist(info->monspecs.modedb, info->monspecs.modedb_len,
-				 &info->monspecs.modelist);
+				 &info->modelist);
 	riva_update_default_var(var, info);
 
 	/* if user specified flatpanel, we respect that */
diff -uprN linux-2.6.9-rc1-mm4-orig/include/linux/fb.h linux-2.6.9-rc1-mm4/include/linux/fb.h
--- linux-2.6.9-rc1-mm4-orig/include/linux/fb.h	2004-09-10 04:43:53.050820600 +0800
+++ linux-2.6.9-rc1-mm4/include/linux/fb.h	2004-09-10 04:54:59.156557136 +0800
@@ -2,7 +2,6 @@
 #define _LINUX_FB_H
 
 #include <asm/types.h>
-#include <linux/list.h>
 
 /* Definitions of frame buffers						*/
 
@@ -243,74 +242,6 @@ struct fb_con2fbmap {
 #define VESA_HSYNC_SUSPEND      2
 #define VESA_POWERDOWN          3
 
-/* Definitions below are used in the parsed monitor specs */
-#define FB_DPMS_ACTIVE_OFF	1
-#define FB_DPMS_SUSPEND		2
-#define FB_DPMS_STANDBY		4
-
-#define FB_DISP_DDI		1
-#define FB_DISP_ANA_700_300	2
-#define FB_DISP_ANA_714_286	4
-#define FB_DISP_ANA_1000_400	8
-#define FB_DISP_ANA_700_000	16
-
-#define FB_DISP_MONO		32
-#define FB_DISP_RGB		64
-#define FB_DISP_MULTI		128
-#define FB_DISP_UNKNOWN		256
-
-#define FB_SIGNAL_NONE		0
-#define FB_SIGNAL_BLANK_BLANK	1
-#define FB_SIGNAL_SEPARATE	2
-#define FB_SIGNAL_COMPOSITE	4
-#define FB_SIGNAL_SYNC_ON_GREEN	8
-#define FB_SIGNAL_SERRATION_ON	16
-
-#define FB_MISC_PRIM_COLOR	1
-#define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
-
-struct fb_chroma {
-	__u32 redx;	/* in fraction of 1024 */
-	__u32 greenx;
-	__u32 bluex;
-	__u32 whitex;
-	__u32 redy;
-	__u32 greeny;
-	__u32 bluey;
-	__u32 whitey;
-};
-
-struct fb_monspecs {
-	struct fb_chroma chroma;
-	struct fb_videomode *modedb;	/* mode database */
-	struct list_head modelist;      /* mode list */
-	__u8  manufacturer[4];		/* Manufacturer */
-	__u8  monitor[14];		/* Monitor String */
-	__u8  serial_no[14];		/* Serial Number */
-	__u8  ascii[14];		/* ? */
-	__u32 modedb_len;		/* mode database length */
-	__u32 model;			/* Monitor Model */
-	__u32 serial;			/* Serial Number - Integer */
-	__u32 year;			/* Year manufactured */
-	__u32 week;			/* Week Manufactured */
-	__u32 hfmin;			/* hfreq lower limit (Hz) */
-	__u32 hfmax;			/* hfreq upper limit (Hz) */
-	__u32 dclkmin;			/* pixelclock lower limit (Hz) */
-	__u32 dclkmax;			/* pixelclock upper limit (Hz) */
-	__u16 input;			/* display type - see FB_DISP_* */
-	__u16 dpms;			/* DPMS support - see FB_DPMS_ */
-	__u16 signal;			/* Signal Type - see FB_SIGNAL_* */
-	__u16 vfmin;			/* vfreq lower limit (Hz) */
-	__u16 vfmax;			/* vfreq upper limit (Hz) */
-	__u16 gamma;			/* Gamma - in fractions of 100 */
-	__u16 gtf	: 1;		/* supports GTF */
-	__u16 misc;			/* Misc flags - see FB_MISC_* */
-	__u8  version;			/* EDID version... */
-	__u8  revision;			/* ...and revision */
-	__u8  max_x;			/* Maximum horizontal size (cm) */
-	__u8  max_y;			/* Maximum vertical size (cm) */
-};
-
 #define FB_VBLANK_VBLANKING	0x001	/* currently in a vertical blank */
 #define FB_VBLANK_HBLANKING	0x002	/* currently in a horizontal blank */
 #define FB_VBLANK_HAVE_VBLANK	0x004	/* vertical blanks can be detected */
@@ -399,6 +330,7 @@ struct fb_cursor {
 #include <linux/workqueue.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/notifier.h>
+#include <linux/list.h>
 #include <asm/io.h>
 
 struct vm_area_struct;
@@ -406,6 +338,72 @@ struct fb_info;
 struct device;
 struct file;
 
+/* Definitions below are used in the parsed monitor specs */
+#define FB_DPMS_ACTIVE_OFF	1
+#define FB_DPMS_SUSPEND		2
+#define FB_DPMS_STANDBY		4
+
+#define FB_DISP_DDI		1
+#define FB_DISP_ANA_700_300	2
+#define FB_DISP_ANA_714_286	4
+#define FB_DISP_ANA_1000_400	8
+#define FB_DISP_ANA_700_000	16
+
+#define FB_DISP_MONO		32
+#define FB_DISP_RGB		64
+#define FB_DISP_MULTI		128
+#define FB_DISP_UNKNOWN		256
+
+#define FB_SIGNAL_NONE		0
+#define FB_SIGNAL_BLANK_BLANK	1
+#define FB_SIGNAL_SEPARATE	2
+#define FB_SIGNAL_COMPOSITE	4
+#define FB_SIGNAL_SYNC_ON_GREEN	8
+#define FB_SIGNAL_SERRATION_ON	16
+
+#define FB_MISC_PRIM_COLOR	1
+#define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
+struct fb_chroma {
+	__u32 redx;	/* in fraction of 1024 */
+	__u32 greenx;
+	__u32 bluex;
+	__u32 whitex;
+	__u32 redy;
+	__u32 greeny;
+	__u32 bluey;
+	__u32 whitey;
+};
+
+struct fb_monspecs {
+	struct fb_chroma chroma;
+	struct fb_videomode *modedb;	/* mode database */
+	__u8  manufacturer[4];		/* Manufacturer */
+	__u8  monitor[14];		/* Monitor String */
+	__u8  serial_no[14];		/* Serial Number */
+	__u8  ascii[14];		/* ? */
+	__u32 modedb_len;		/* mode database length */
+	__u32 model;			/* Monitor Model */
+	__u32 serial;			/* Serial Number - Integer */
+	__u32 year;			/* Year manufactured */
+	__u32 week;			/* Week Manufactured */
+	__u32 hfmin;			/* hfreq lower limit (Hz) */
+	__u32 hfmax;			/* hfreq upper limit (Hz) */
+	__u32 dclkmin;			/* pixelclock lower limit (Hz) */
+	__u32 dclkmax;			/* pixelclock upper limit (Hz) */
+	__u16 input;			/* display type - see FB_DISP_* */
+	__u16 dpms;			/* DPMS support - see FB_DPMS_ */
+	__u16 signal;			/* Signal Type - see FB_SIGNAL_* */
+	__u16 vfmin;			/* vfreq lower limit (Hz) */
+	__u16 vfmax;			/* vfreq upper limit (Hz) */
+	__u16 gamma;			/* Gamma - in fractions of 100 */
+	__u16 gtf	: 1;		/* supports GTF */
+	__u16 misc;			/* Misc flags - see FB_MISC_* */
+	__u8  version;			/* EDID version... */
+	__u8  revision;			/* ...and revision */
+	__u8  max_x;			/* Maximum horizontal size (cm) */
+	__u8  max_y;			/* Maximum vertical size (cm) */
+};
+
 struct fb_cmap_user {
 	__u32 start;			/* First entry	*/
 	__u32 len;			/* Number of entries */
@@ -601,6 +599,7 @@ struct fb_info {
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
+	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
 	char *screen_base;		/* Virtual address */
 	int currcon;			/* Current VC. */



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbUJ0JTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUJ0JTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUJ0JTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:19:22 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35535 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262342AbUJ0JSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:18:32 -0400
Subject: [PATCH] fbcon: Replace logo_shown magic numbers with constants
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: jsimmons@infradead.org, geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 27 Oct 2004 12:19:28 +0300
Message-Id: <1098868768.9299.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch replaces logo_shown magic numbers with constants in
drivers/video/console/fbcon.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fbcon.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

Index: 2.6.10-rc1-bk1/drivers/video/console/fbcon.c
===================================================================
--- 2.6.10-rc1-bk1.orig/drivers/video/console/fbcon.c	2004-10-27 11:32:40.000000000 +0300
+++ 2.6.10-rc1-bk1/drivers/video/console/fbcon.c	2004-10-27 12:17:28.541869920 +0300
@@ -100,12 +100,20 @@
 #  define DPRINTK(fmt, args...)
 #endif
 
+enum {
+	FBCON_LOGO_CANSHOW	= -1,	/* the logo can be shown */
+	FBCON_LOGO_DRAW		= -2,	/* draw the logo to a console */
+	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
+};
+
 struct display fb_display[MAX_NR_CONSOLES];
 signed char con2fb_map[MAX_NR_CONSOLES];
 signed char con2fb_map_boot[MAX_NR_CONSOLES];
 static int logo_height;
 static int logo_lines;
-static int logo_shown = -1;
+/* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
+   enums.  */
+static int logo_shown = FBCON_LOGO_CANSHOW;
 /* Software scrollback */
 int fbcon_softback_size = 32768;
 static unsigned long softback_buf, softback_curr;
@@ -365,7 +373,7 @@
 		return -ENODEV;
 
 	if (!show_logo)
-		logo_shown = -3;
+		logo_shown = FBCON_LOGO_DONTSHOW;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		con2fb_map[i] = info_idx;
@@ -447,11 +455,11 @@
 	}
 
 	if (logo_lines > vc->vc_bottom) {
-		logo_shown = -1;
+		logo_shown = FBCON_LOGO_CANSHOW;
 		printk(KERN_INFO
 		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
-	} else if (logo_shown != -3) {
-		logo_shown = -2;
+	} else if (logo_shown != FBCON_LOGO_DONTSHOW) {
+		logo_shown = FBCON_LOGO_DRAW;
 		vc->vc_top = logo_lines;
 	}
 }
@@ -592,7 +600,7 @@
 	else
 		fbcon_preset_disp(info, unit);
 
-	if (fg_console == 0 && !user && logo_shown != -3) {
+	if (fg_console == 0 && !user && logo_shown != FBCON_LOGO_DONTSHOW) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		struct fb_info *fg_info = registered_fb[con2fb_map[fg_console]];
 
@@ -827,7 +835,7 @@
 
 	if (info_idx == -1 || info == NULL)
 	    return;
-	if (vc->vc_num != display_fg || logo_shown == -3 ||
+	if (vc->vc_num != display_fg || logo_shown == FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
@@ -1846,7 +1854,7 @@
 		if (conp2->vc_top == logo_lines
 		    && conp2->vc_bottom == conp2->vc_rows)
 			conp2->vc_top = 0;
-		logo_shown = -1;
+		logo_shown = FBCON_LOGO_CANSHOW;
 	}
 
 	prev_console = info->currcon;
@@ -1914,7 +1922,7 @@
 
 	if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
 		fbcon_clear_margins(vc, 0);
-	if (logo_shown == -2) {
+	if (logo_shown == FBCON_LOGO_DRAW) {
 
 		logo_shown = fg_console;
 		/* This is protected above by initmem_freed */
@@ -2429,7 +2437,7 @@
 				update_region(vc->vc_num, vc->vc_origin,
 					      logo_lines * vc->vc_cols);
 			}
-			logo_shown = -1;
+			logo_shown = FBCON_LOGO_CANSHOW;
 		}
 		fbcon_cursor(vc, CM_ERASE | CM_SOFTBACK);
 		fbcon_redraw_softback(vc, p, lines);



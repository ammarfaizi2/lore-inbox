Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbSLKLml>; Wed, 11 Dec 2002 06:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLKLmk>; Wed, 11 Dec 2002 06:42:40 -0500
Received: from dp.samba.org ([66.70.73.150]:64729 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267120AbSLKLmi>;
	Wed, 11 Dec 2002 06:42:38 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15863.9842.686577.666106@argo.ozlabs.ibm.com>
Date: Wed, 11 Dec 2002 22:50:10 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: patch for controlfb.c
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates controlfb.c so it compiles cleanly.  Most of the
changes are from the linuxppc-2.5 tree, with some extra changes to
accommodate the most recent changes to the framebuffer API.

Paul.

diff -urN linux-2.5/drivers/video/controlfb.c pmac-2.5/drivers/video/controlfb.c
--- linux-2.5/drivers/video/controlfb.c	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/controlfb.c	2002-12-11 22:37:00.000000000 +1100
@@ -22,6 +22,10 @@
  *    control.c: Console support for PowerMac "control" display adaptor.
  *    Copyright (C) 1996 Paul Mackerras
  *
+ *  Updated to 2.5 framebuffer API by Ben Herrenschmidt
+ *  <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
+ *  and James Simmons <jsimmons@infradead.org>.
+ *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
@@ -50,12 +54,7 @@
 #include <asm/pgtable.h>
 #include <asm/btext.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb32.h>
-#include <video/macmodes.h>
-
+#include "macmodes.h"
 #include "controlfb.h"
 
 struct fb_par_control {
@@ -97,7 +96,6 @@
 
 struct fb_info_control {
 	struct fb_info		info;
-	struct display		display; /* Will disappear */
 	struct fb_par_control	par;
 	u32			pseudo_palette[17];
 		
@@ -119,14 +117,14 @@
 };
 
 /* control register access macro */
-#define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs-> ## REG).r))
+#define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs->REG).r))
 
 
 /******************** Prototypes for exported functions ********************/
 /*
  * struct fb_ops
  */
-static int controlfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int controlfb_pan_display(struct fb_var_screeninfo *var,
 	struct fb_info *info);
 static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	u_int transp, struct fb_info *info);
@@ -171,11 +169,8 @@
 
 static struct fb_ops controlfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_check_var	= controlfb_check_var,
 	.fb_set_par	= controlfb_set_par,
-	.fb_get_cmap	= gen_get_cmap,
-	.fb_set_cmap	= gen_set_cmap,
 	.fb_setcolreg	= controlfb_setcolreg,
 	.fb_pan_display = controlfb_pan_display,
 	.fb_blank	= controlfb_blank,
@@ -265,8 +260,8 @@
 }
 
 
-static int controlfb_pan_display(struct fb_var_screeninfo *var, int con,
-			     struct fb_info *info)
+static int controlfb_pan_display(struct fb_var_screeninfo *var,
+				 struct fb_info *info)
 {
 	unsigned int xoffset, hstep;
 	struct fb_info_control *p = (struct fb_info_control *)info;
@@ -483,7 +478,7 @@
 	/* Apply default var */
 	p->info.var = var;
 	var.activate = FB_ACTIVATE_NOW;
-	rc = gen_set_var(&var, -1, &p->info);
+	rc = fb_set_var(&var, &p->info);
 	if (rc && (vmode != VMODE_640_480_60 || cmode != CMODE_8))
 		goto try_again;
 
@@ -491,7 +486,7 @@
 	if (register_framebuffer(&p->info) < 0)
 		return -ENXIO;
 	
-	printk(KERN_INFO "fb%d: control display adapter\n", GET_FB_IDX(p->info.node));	
+	printk(KERN_INFO "fb%d: control display adapter\n", minor(p->info.node));	
 
 	return 0;
 }
@@ -1015,22 +1010,12 @@
 static void __init control_init_info(struct fb_info *info, struct fb_info_control *p)
 {
 	/* Fill fb_info */
-	strcpy(info->modename, "control");
-	info->currcon = -1;
 	info->par = &p->par;
 	info->node = NODEV;
 	info->fbops = &controlfb_ops;
-	info->disp = &p->display;
 	info->pseudo_palette = p->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
-        strncpy (info->fontname, fontname, sizeof (info->fontname));
-        info->fontname[sizeof (info->fontname) - 1] = 0;
-	info->changevar = NULL;
-        info->display_fg = NULL;
 	info->screen_base = (char *) p->frame_buffer + CTRLFB_OFF;
-	info->changevar  = NULL;
-	info->switch_con = gen_switch;
-	info->updatevar  = gen_update_var;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 

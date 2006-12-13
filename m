Return-Path: <linux-kernel-owner+w=401wt.eu-S965056AbWLMRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWLMRoX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWLMRnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:43:52 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3123 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbWLMRms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:42:48 -0500
Date: Wed, 13 Dec 2006 17:10:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-fbdev-devel@lists.sourceforge.net, axp-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 3/6] tgafb: Support the DirectColor visual
Message-ID: <Pine.LNX.4.64N.0612131605320.24220@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The 32-plane variations of the TGA use the Bt463 RAMDAC and are therefore 
DirectColor rather than TrueColor adapters.  This is a set of changes to 
implement the necessary bits to support this model.  A couple of fixes to 
fix accesses to the RAMDAC are included as a side-effect.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 This is the most intrusive change in this set of patches.  It was tested 
both with the console, including the bootstrap logo, and X11 to make sure 
palette handling is correct.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-directcolor-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 14:28:22.000000000 +0000
@@ -98,6 +98,12 @@ tgafb_check_var(struct fb_var_screeninfo
 		if (var->bits_per_pixel != 32)
 			return -EINVAL;
 	}
+	var->red.length = var->green.length = var->blue.length = 8;
+	if (var->bits_per_pixel == 32) {
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+	}
 
 	if (var->xres_virtual != var->xres || var->yres_virtual != var->yres)
 		return -EINVAL;
@@ -151,7 +157,7 @@ tgafb_set_par(struct fb_info *info)
 	struct tga_par *par = (struct tga_par *) info->par;
 	u32 htimings, vtimings, pll_freq;
 	u8 tga_type;
-	int i, j;
+	int i;
 
 	/* Encode video timings.  */
 	htimings = (((info->var.xres/4) & TGA_HORIZ_ACT_LSB)
@@ -226,8 +232,10 @@ tgafb_set_par(struct fb_info *info)
 		BT485_WRITE(par, 0x00, BT485_ADDR_PAL_WRITE);
 		TGA_WRITE_REG(par, BT485_DATA_PAL, TGA_RAMDAC_SETUP_REG);
 
+#ifdef CONFIG_HW_CONSOLE
 		for (i = 0; i < 16; i++) {
-			j = color_table[i];
+			int j = color_table[i];
+
 			TGA_WRITE_REG(par, default_red[j]|(BT485_DATA_PAL<<8),
 				      TGA_RAMDAC_REG);
 			TGA_WRITE_REG(par, default_grn[j]|(BT485_DATA_PAL<<8),
@@ -235,14 +243,17 @@ tgafb_set_par(struct fb_info *info)
 			TGA_WRITE_REG(par, default_blu[j]|(BT485_DATA_PAL<<8),
 				      TGA_RAMDAC_REG);
 		}
-		for (i = 0; i < 240*3; i += 4) {
-			TGA_WRITE_REG(par, 0x55|(BT485_DATA_PAL<<8),
+		for (i = 0; i < 240 * 3; i += 4) {
+#else
+		for (i = 0; i < 256 * 3; i += 4) {
+#endif
+			TGA_WRITE_REG(par, 0x55 | (BT485_DATA_PAL << 8),
 				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x00|(BT485_DATA_PAL<<8),
+			TGA_WRITE_REG(par, 0x00 | (BT485_DATA_PAL << 8),
 				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x00|(BT485_DATA_PAL<<8),
+			TGA_WRITE_REG(par, 0x00 | (BT485_DATA_PAL << 8),
 				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x00|(BT485_DATA_PAL<<8),
+			TGA_WRITE_REG(par, 0x00 | (BT485_DATA_PAL << 8),
 				      TGA_RAMDAC_REG);
 		}
 
@@ -266,26 +277,24 @@ tgafb_set_par(struct fb_info *info)
 
 		/* Fill the palette.  */
 		BT463_LOAD_ADDR(par, 0x0000);
-		TGA_WRITE_REG(par, BT463_PALETTE<<2, TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, BT463_PALETTE << 2, TGA_RAMDAC_SETUP_REG);
 
+#ifdef CONFIG_HW_CONSOLE
 		for (i = 0; i < 16; i++) {
-			j = color_table[i];
-			TGA_WRITE_REG(par, default_red[j]|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, default_grn[j]|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, default_blu[j]|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
-		}
-		for (i = 0; i < 512*3; i += 4) {
-			TGA_WRITE_REG(par, 0x55|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x00|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x00|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x00|(BT463_PALETTE<<10),
-				      TGA_RAMDAC_REG);
+			int j = color_table[i];
+
+			TGA_WRITE_REG(par, default_red[j], TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_grn[j], TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_blu[j], TGA_RAMDAC_REG);
+		}
+		for (i = 0; i < 512 * 3; i += 4) {
+#else
+		for (i = 0; i < 528 * 3; i += 4) {
+#endif
+			TGA_WRITE_REG(par, 0x55, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
 		}
 
 		/* Fill window type table after start of vertical retrace.  */
@@ -298,15 +307,12 @@ tgafb_set_par(struct fb_info *info)
 		TGA_WRITE_REG(par, 0x01, TGA_INTR_STAT_REG);
 
 		BT463_LOAD_ADDR(par, BT463_WINDOW_TYPE_BASE);
-		TGA_WRITE_REG(par, BT463_REG_ACC<<2, TGA_RAMDAC_SETUP_REG);
+		TGA_WRITE_REG(par, BT463_REG_ACC << 2, TGA_RAMDAC_SETUP_REG);
 
 		for (i = 0; i < 16; i++) {
-			TGA_WRITE_REG(par, 0x00|(BT463_REG_ACC<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x01|(BT463_REG_ACC<<10),
-				      TGA_RAMDAC_REG);
-			TGA_WRITE_REG(par, 0x80|(BT463_REG_ACC<<10),
-				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x01, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
 		}
 
 	}
@@ -434,9 +440,16 @@ tgafb_setcolreg(unsigned regno, unsigned
 		TGA_WRITE_REG(par, red|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 		TGA_WRITE_REG(par, green|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 		TGA_WRITE_REG(par, blue|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
-	} else if (regno < 16) {
-		u32 value = (red << 16) | (green << 8) | blue;
-		((u32 *)info->pseudo_palette)[regno] = value;
+	} else {
+		if (regno < 16) {
+			u32 value = (regno << 16) | (regno << 8) | regno;
+			((u32 *)info->pseudo_palette)[regno] = value;
+		}
+		BT463_LOAD_ADDR(par, regno);
+		TGA_WRITE_REG(par, BT463_PALETTE << 2, TGA_RAMDAC_SETUP_REG);
+		TGA_WRITE_REG(par, red, TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, green, TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, blue, TGA_RAMDAC_REG);
 	}
 
 	return 0;
@@ -1351,7 +1364,7 @@ tgafb_init_fix(struct fb_info *info)
 	info->fix.type_aux = 0;
 	info->fix.visual = (tga_type == TGA_TYPE_8PLANE
 			    ? FB_VISUAL_PSEUDOCOLOR
-			    : FB_VISUAL_TRUECOLOR);
+			    : FB_VISUAL_DIRECTCOLOR);
 
 	info->fix.line_length = par->xres * (par->bits_per_pixel >> 3);
 	info->fix.smem_start = (size_t) par->tga_fb_base;

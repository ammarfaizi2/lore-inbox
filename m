Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTEUVte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 17:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTEUVte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 17:49:34 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:52999 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262258AbTEUVta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 17:49:30 -0400
Date: Wed, 21 May 2003 23:02:29 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: G364 updates
Message-ID: <Pine.LNX.4.44.0305212301350.16402-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1042.16.53 -> 1.1042.35.1
#	drivers/video/fbmem.c	1.73    -> 1.74   
#	drivers/video/g364fb.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/21	jsimmons@kozmo.(none)	1.1042.35.1
# 
# [G354 FBDEV] Now use the final cursor api.
# --------------------------------------------
#
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Sat May 17 17:52:10 2003
+++ b/drivers/video/fbmem.c	Sat May 17 17:52:10 2003
@@ -25,7 +25,6 @@
 #include <linux/mman.h>
 #include <linux/tty.h>
 #include <linux/init.h>
-#include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
@@ -726,8 +725,6 @@
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;
 		info->fbops->fb_imageblit(info, &image);
-		//atomic_dec(&info->pixmap.count);
-		//smp_mb__after_atomic_dec();
 	}
 	
 	if (palette != NULL)
diff -Nru a/drivers/video/g364fb.c b/drivers/video/g364fb.c
--- a/drivers/video/g364fb.c	Sat May 17 17:52:10 2003
+++ b/drivers/video/g364fb.c	Sat May 17 17:52:10 2003
@@ -127,20 +127,55 @@
 
 int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
+
+	/* Turn the cursor off before we start changing it. */
+	*(unsigned int *) CTLA_REG |= CURS_TOGGLE;
+
+	if (cursor->set & FB_CUR_SETHOT)
+		info->cursor.hot = cursor->hot;
 	
-	switch (cursor->enable) {
-	case CM_ERASE:
-		*(unsigned int *) CTLA_REG |= CURS_TOGGLE;
-		break;
+	if (cursor->set & FB_CUR_SETPOS) {
+		unsigned int tmp;
+		
+		info->cursor.image.dx = cursor->image.dx;
+		info->cursor.image.dy = cursor->image.dy;
+
+		tmp = cursor->image.dy - info->var.yoffset;
+		tmp |= (cursor->image.dx - info->var.xoffset) << 12;	
+		
+		*(unsigned int *) CURS_POS_REG = tmp;
+	}
 
-	case CM_MOVE:
-	case CM_DRAW:
+	if (cursor->set & FB_CUR_SETSIZE) {
+		info->cursor.image.height = cursor->image.height;
+		info->cursor.image.width = cursor->image.width;
+	
+	 	/* set the whole cursor to transparent */
+		for (i = 0; i < 512; i++)
+			*(unsigned short *) (CURS_PAT_REG + i * 8) = 0;
+	}	
+
+	if (cursor->set & FB_CUR_SETCMAP) {
+		volatile unsigned int *curs_pal_ptr =
+	    			(volatile unsigned int *) CURS_PAL_REG;
+
+		/* setup cursor */
+		curs_pal_ptr[0] |= 0x00ffffff;
+		curs_pal_ptr[2] |= 0x00ffffff;
+		curs_pal_ptr[4] |= 0x00ffffff;
+	}	
+	
+	if (cursor->set & FB_CUR_SETSHAPE) {
+		/*
+	 	 * switch the last two lines to cursor palette 3
+	 	 * we assume here, that FONTSIZE_X is 8
+	 	 */
+		*(unsigned short *) (CURS_PAT_REG + 14 * 64) = 0xffff;
+		*(unsigned short *) (CURS_PAT_REG + 15 * 64) = 0xffff;
+	}	
+	
+	if (info->cursor.enable)
 		*(unsigned int *) CTLA_REG &= ~CURS_TOGGLE;
-		*(unsigned int *) CURS_POS_REG =
-		    ((x * fontwidth(p)) << 12) | ((y * fontheight(p)) -
-						  info->var.yoffset);
-		break;
-	}
 	return 0;
 }
 
@@ -196,10 +231,6 @@
  */
 int __init g364fb_init(void)
 {
-	volatile unsigned int *pal_ptr =
-	    (volatile unsigned int *) CLR_PAL_REG;
-	volatile unsigned int *curs_pal_ptr =
-	    (volatile unsigned int *) CURS_PAL_REG;
 	int mem, i, j;
 
 	/* TBD: G364 detection */
@@ -212,23 +243,6 @@
 	    (*((volatile unsigned int *) VDISPLAY_REG) & 0x00ffffff) / 2;
 	*(volatile unsigned int *) CTLA_REG |= ENABLE_VTG;
 
-	/* setup cursor */
-	curs_pal_ptr[0] |= 0x00ffffff;
-	curs_pal_ptr[2] |= 0x00ffffff;
-	curs_pal_ptr[4] |= 0x00ffffff;
-
-	/*
-	 * first set the whole cursor to transparent
-	 */
-	for (i = 0; i < 512; i++)
-		*(unsigned short *) (CURS_PAT_REG + i * 8) = 0;
-
-	/*
-	 * switch the last two lines to cursor palette 3
-	 * we assume here, that FONTSIZE_X is 8
-	 */
-	*(unsigned short *) (CURS_PAT_REG + 14 * 64) = 0xffff;
-	*(unsigned short *) (CURS_PAT_REG + 15 * 64) = 0xffff;
 	fb_var.xres_virtual = fbvar.xres;
 	fb_fix.line_length = (xres / 8) * fb_var.bits_per_pixel;
 	fb_fix.smem_start = 0x40000000;	/* physical address */


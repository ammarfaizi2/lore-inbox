Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSLJTQg>; Tue, 10 Dec 2002 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLJTQg>; Tue, 10 Dec 2002 14:16:36 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:61452 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265570AbSLJTQd>; Tue, 10 Dec 2002 14:16:33 -0500
Subject: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039558622.1054.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 03:18:05 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here's a diff to correct several small things that escaped through the
cracks.

1.  The YNOMOVE scrollmode for non-accelerated drivers is just very slow
because of a lot of block moves (leads to slow and jerky scrolling in
vesafb with ypanning enabled).  Depending on var->accel_flags, set the 
scrollmode to either YREDRAW or YNOMOVE. For drivers with hardware
acceleration, set var->accel_flags to nonzero for max speed.

2.  fb_pan_display() always returns an error.  User apps will complain.

3.  case FBIO_GETCMAP in fb_ioctl does not return immediately.  User
apps will complain.

4.  vgastate.c is not saving the correct blocks.

5.  logo drawing for monochrome displays is just incorrect.(alterations
were done by eyeballing only, no hardware for testing).

The above will only have a very small effect on the general state of
fbdev/fbcon.  Patch is against 2.5.51.

Tony 

diff -Naur linux-2.5.51/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.51/drivers/video/console/fbcon.c	2002-12-10 21:55:41.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2002-12-10 21:44:46.000000000 +0000
@@ -291,7 +291,10 @@
 	struct display *display = fb_display + con;
 
 	display->can_soft_blank = info->fbops->fb_blank ? 1 : 0;
-	display->scrollmode = SCROLL_YNOMOVE;
+	if (info->var.accel_flags)
+		display->scrollmode = SCROLL_YNOMOVE;
+	else
+		display->scrollmode = SCROLL_YREDRAW;
 	fbcon_changevar(con);
 	return;
 }
@@ -2633,7 +2636,7 @@
 	default:
 		for (i = 0; i < (LOGO_W * LOGO_H)/8; i++) 
 			for (j = 0; j < 8; j++) 
-				logo[i*2] = (linux_logo_bw[i] &  (7 - j)) ? 
+				logo[i*8+j] = (linux_logo_bw[i] &  (7 - j)) ? 
 					((needs_logo == 1) ? 1 : 0) :
 					((needs_logo == 1) ? 0 : 1);
 				
diff -Naur linux-2.5.51/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.51/drivers/video/fbmem.c	2002-12-10 21:55:15.000000000 +0000
+++ linux/drivers/video/fbmem.c	2002-12-10 21:47:22.000000000 +0000
@@ -471,11 +471,9 @@
             yoffset + info->var.yres > info->var.yres_virtual)
                 return -EINVAL;
         if (info->fbops->fb_pan_display) {
-                if ((err = info->fbops->fb_pan_display(var, info)))
-                        return err;
-                else
-                        return -EINVAL;
-        }
+		err = info->fbops->fb_pan_display(var, info);
+		if (err) return err;
+	}
         info->var.xoffset = var->xoffset;
         info->var.yoffset = var->yoffset;
         if (var->vmode & FB_VMODE_YWRAP)
@@ -571,6 +569,7 @@
 		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
 			return -EFAULT;
 		fb_copy_cmap(&info->cmap, &cmap, 0);
+		return 0;
 	case FBIOPAN_DISPLAY:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
diff -Naur linux-2.5.51/drivers/video/vgastate.c linux/drivers/video/vgastate.c
--- linux-2.5.51/drivers/video/vgastate.c	2002-12-10 21:55:20.000000000 +0000
+++ linux/drivers/video/vgastate.c	2002-12-10 21:52:31.000000000 +0000
@@ -111,7 +111,7 @@
 		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
 		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
 		for (i = 0; i < 8192; i++) 
-			saved->vga_text[i] = vga_r(fbbase + 2 * 8192, i); 
+			saved->vga_text[8192+i] = vga_r(fbbase, i); 
 	}
 
 	/* restore regs */
@@ -184,7 +184,7 @@
 		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
 		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
 		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
-		for (i = 0; i < 4 * 8192; i++) 
+		for (i = 0; i < state->memsize; i++) 
 			vga_w(fbbase, i, saved->vga_font1[i]);
 	}
 	
@@ -204,8 +204,7 @@
 		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
 		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
 		for (i = 0; i < 8192; i++) 
-			vga_w(fbbase + 2 * 8192, i, 
-			      saved->vga_text[i]);
+			vga_w(fbbase, i, saved->vga_text[8192+i]);
 	}
 
 	/* unblank screen */




Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSFMIdV>; Thu, 13 Jun 2002 04:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSFMIdU>; Thu, 13 Jun 2002 04:33:20 -0400
Received: from skunk.directfb.org ([212.84.236.169]:60032 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S317495AbSFMIdS>; Thu, 13 Jun 2002 04:33:18 -0400
Date: Thu, 13 Jun 2002 10:32:43 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
Message-ID: <20020613083243.GA32352@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

this patch adds 32 bit support to cyber2000fb which is useful
if you have a video layer in the background (CyberPro 5xxx) with
per pixel alpha blending enabled.

This patch also includes a fix for the text palette for modes
with more than 8 bit.

Applies against Linux 2.5.21.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="linux-2.5.21-cyber32bit.diff"

diff -uraN linux-2.5.21/CREDITS linux-2.5.21-cyber32bit/CREDITS
--- linux-2.5.21/CREDITS	Thu Jun 13 08:31:27 2002
+++ linux-2.5.21-cyber32bit/CREDITS	Thu Jun 13 09:43:01 2002
@@ -1677,6 +1677,7 @@
 N: Denis O. Kropp
 E: dok@directfb.org
 D: NeoMagic framebuffer driver
+D: CyberPro 32 bit support, fixes
 S: Badensche Str. 46
 S: 10715 Berlin
 S: Germany
diff -uraN linux-2.5.21/drivers/video/Config.in linux-2.5.21-cyber32bit/drivers/video/Config.in
--- linux-2.5.21/drivers/video/Config.in	Thu Jun 13 08:31:34 2002
+++ linux-2.5.21-cyber32bit/drivers/video/Config.in	Thu Jun 13 09:29:43 2002
@@ -348,7 +348,7 @@
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
-	   "$CONFIG_FB_PM3" = "y" ]; then
+	   "$CONFIG_FB_PM3" = "y" -o "$CONFIG_FB_CYBER2000" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB32 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -359,7 +359,7 @@
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_PM3" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
-	      "$CONFIG_FB_PVR2" = "m" ]; then
+	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_CYBER2000" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
       fi
diff -uraN linux-2.5.21/drivers/video/cyber2000fb.c linux-2.5.21-cyber32bit/drivers/video/cyber2000fb.c
--- linux-2.5.21/drivers/video/cyber2000fb.c	Thu Jun 13 08:31:34 2002
+++ linux-2.5.21-cyber32bit/drivers/video/cyber2000fb.c	Thu Jun 13 09:47:00 2002
@@ -6,11 +6,14 @@
  *  MIPS and 50xx clock support
  *  Copyright (C) 2001 Bradley D. LaRonde <brad@ltc.com>
  *
+ *  32 bit support, text color fixes for modes != 8 bit
+ *  Copyright (C) 2002 Denis Oliver Kropp <dok@directfb.org>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Integraphics CyberPro 2000, 2010 and 5000 frame buffer device
+ * Intergraphics CyberPro 2000, 2010 and 5000 frame buffer device
  *
  * Based on cyberfb.c.
  *
@@ -49,6 +52,7 @@
 #include <video/fbcon-cfb8.h>
 #include <video/fbcon-cfb16.h>
 #include <video/fbcon-cfb24.h>
+#include <video/fbcon-cfb32.h>
 
 /*
  * Define this if you don't want RGB565, but RGB555 for 16bpp displays.
@@ -247,6 +251,11 @@
 		cyber2000fb_writeb(dst, CO_REG_X_PHASE, cfb);
 		bgx = ((u32 *)display->dispsw_data)[bgx];
 		break;
+
+	case 32:
+		bgx = ((u32 *)display->dispsw_data)[bgx];
+		cyber2000fb_writel(dst, CO_REG_DEST_PTR, cfb);
+		break;
 	}
 
 	cyber2000fb_writel(bgx, CO_REG_FOREGROUND, cfb);
@@ -312,12 +321,15 @@
 	struct cfb_info *cfb = (struct cfb_info *)info;
 	struct fb_var_screeninfo *var = &cfb->display->var;
 
+	u_int alpha = transp ^ 0xFFFF;
+
 	if (regno >= NR_PALETTE)
 		return 1;
 
 	red   >>= 8;
 	green >>= 8;
 	blue  >>= 8;
+	alpha >>= 8;
 
 	cfb->palette[regno].red   = red;
 	cfb->palette[regno].green = green;
@@ -355,7 +367,9 @@
 
 			if (regno < 16)
 				((u16 *)cfb->fb.pseudo_palette)[regno] =
-					regno | regno << 5 | regno << 11;
+					((red   << 8) & 0xf800) |
+					((green << 3) & 0x07e0) |
+					((blue  >> 3));
 			break;
 		}
 #endif
@@ -367,7 +381,9 @@
 		}
 		if (regno < 16)
 			((u16 *)cfb->fb.pseudo_palette)[regno] =
-				regno | regno << 5 | regno << 10;
+				((red   << 7) & 0x7c00) |
+				((green << 2) & 0x03e0) |
+				((blue  >> 3));
 		break;
 
 #endif
@@ -381,7 +397,20 @@
 
 		if (regno < 16)
 			((u32 *)cfb->fb.pseudo_palette)[regno] =
-				regno | regno << 8 | regno << 16;
+				(red << 16) | (green << 8) | blue;
+		break;
+#endif
+
+#ifdef FBCON_HAS_CFB32
+	case 32:
+		cyber2000fb_writeb(regno, 0x3c8, cfb);
+		cyber2000fb_writeb(red,   0x3c9, cfb);
+		cyber2000fb_writeb(green, 0x3c9, cfb);
+		cyber2000fb_writeb(blue,  0x3c9, cfb);
+
+		if (regno < 16)
+			((u32 *)cfb->fb.pseudo_palette)[regno] =
+				(alpha << 24) | (red << 16) | (green << 8) | blue;
 		break;
 #endif
 
@@ -776,6 +805,14 @@
 		hw->palette_ctrl	|= 0x10;
 		break;
 #endif
+#ifdef FBCON_HAS_CFB32
+	case 32:/* TRUECOLOUR, 16m */
+		hw->pixformat		= PIXFORMAT_32BPP;
+		hw->extseqmisc		= EXT_SEQ_MISC_32;
+		hw->pitch		= hw->width >> 1;
+		hw->palette_ctrl	|= 0x10;
+		break;
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -909,6 +946,23 @@
 		cfb->dispsw		= &fbcon_cfb24;
 		display->dispsw_data	= cfb->fb.pseudo_palette;
 		display->next_line	= var->xres_virtual * 3;
+		break;
+#endif
+#ifdef FBCON_HAS_CFB32
+	case 32:/* TRUECOLOUR, 16m */
+		var->transp.offset	= 24;
+		var->transp.length	= 8;
+		var->red.offset		= 16;
+		var->red.length		= 8;
+		var->green.offset	= 8;
+		var->green.length	= 8;
+		var->blue.offset	= 0;
+		var->blue.length	= 8;
+
+		cfb->fb.fix.visual	= FB_VISUAL_TRUECOLOR;
+		cfb->dispsw		= &fbcon_cfb32;
+		display->dispsw_data	= cfb->fb.pseudo_palette;
+		display->next_line	= var->xres_virtual * 4;
 		break;
 #endif
 	default:/* in theory this should never happen */
diff -uraN linux-2.5.21/drivers/video/cyber2000fb.h linux-2.5.21-cyber32bit/drivers/video/cyber2000fb.h
--- linux-2.5.21/drivers/video/cyber2000fb.h	Fri Jun  7 15:17:22 2002
+++ linux-2.5.21-cyber32bit/drivers/video/cyber2000fb.h	Thu Jun 13 09:35:23 2002
@@ -39,6 +39,7 @@
 #define PIXFORMAT_8BPP		0
 #define PIXFORMAT_16BPP		1
 #define PIXFORMAT_24BPP		2
+#define PIXFORMAT_32BPP		3
 
 #define EXT_CRT_IRQ		0x12
 #define EXT_CRT_IRQ_ENABLE		0x01

--ibTvN161/egqYuK8--

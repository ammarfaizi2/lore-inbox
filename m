Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSFMIkN>; Thu, 13 Jun 2002 04:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSFMIkM>; Thu, 13 Jun 2002 04:40:12 -0400
Received: from skunk.directfb.org ([212.84.236.169]:64896 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S317495AbSFMIkK>; Thu, 13 Jun 2002 04:40:10 -0400
Date: Thu, 13 Jun 2002 10:39:29 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] [2.4.19-pre10] CyberPro 32bit support and other fixes
Message-ID: <20020613083929.GA32366@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

this patch adds 32 bit support to cyber2000fb which is useful
if you have a video layer in the background (CyberPro 5xxx) with
per pixel alpha blending enabled.

This patch also includes a fix for the text palette for modes 
with more than 8 bit.

Additionally there was a bug in set_var for 16 bit support,
bits_per_pixel has been set to 15 if 16 is detected. I guess
this was a copy'n'paste failure.

Also panning had a bug as it didn't take care of the bytes
per pixel when calculating the new base address.

The last two things have already been fixed in the 2.5 tree.

Applies against Linux 2.4.19-pre10.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="linux-2.4.19-pre10-cyber32bit.diff"

diff -uraN linux-2.4.19-pre10/CREDITS linux-2.4.19-pre10-cyber32bit/CREDITS
--- linux-2.4.19-pre10/CREDITS	Thu Jun 13 09:50:42 2002
+++ linux-2.4.19-pre10-cyber32bit/CREDITS	Thu Jun 13 09:54:28 2002
@@ -1678,6 +1678,7 @@
 N: Denis O. Kropp
 E: dok@directfb.org
 D: NeoMagic framebuffer driver
+D: CyberPro 32 bit support, fixes
 S: Badensche Str. 46
 S: 10715 Berlin
 S: Germany
diff -uraN linux-2.4.19-pre10/drivers/video/Config.in linux-2.4.19-pre10-cyber32bit/drivers/video/Config.in
--- linux-2.4.19-pre10/drivers/video/Config.in	Thu Jun 13 09:51:02 2002
+++ linux-2.4.19-pre10-cyber32bit/drivers/video/Config.in	Thu Jun 13 09:55:26 2002
@@ -361,7 +361,7 @@
 	   "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
 	   "$CONFIG_FB_3DFX" = "y" -o "$CONFIG_FB_SIS" = "y" -o \
-	   "$CONFIG_FB_VOODOO1" = "y" ]; then
+	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_CYBER2000" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB32 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -373,7 +373,8 @@
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_3DFX" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
-	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_VOODOO1" = "m" ]; then
+	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_VOODOO1" = "m" -o \
+	      "$CONFIG_FB_CYBER2000" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
       fi
diff -uraN linux-2.4.19-pre10/drivers/video/cyber2000fb.c linux-2.4.19-pre10-cyber32bit/drivers/video/cyber2000fb.c
--- linux-2.4.19-pre10/drivers/video/cyber2000fb.c	Fri Dec 21 18:41:55 2001
+++ linux-2.4.19-pre10-cyber32bit/drivers/video/cyber2000fb.c	Thu Jun 13 10:14:24 2002
@@ -6,11 +6,14 @@
  *  MIPS and 50xx clock support
  *  Copyright (C) 2001 Bradley D. LaRonde <brad@ltc.com>
  *
+ *  32 bit support, text color and panning fixes for modes != 8 bit
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
@@ -50,6 +53,7 @@
 #include <video/fbcon-cfb8.h>
 #include <video/fbcon-cfb16.h>
 #include <video/fbcon-cfb24.h>
+#include <video/fbcon-cfb32.h>
 
 /*
  * Define this if you don't want RGB565, but RGB555 for 16bpp displays.
@@ -249,6 +253,11 @@
 		cyber2000fb_writeb(dst, CO_REG_X_PHASE, cfb);
 		bgx = ((u32 *)p->dispsw_data)[bgx];
 		break;
+
+	case 32:
+		bgx = ((u32 *)p->dispsw_data)[bgx];
+		cyber2000fb_writel(dst, CO_REG_DEST_PTR, cfb);
+		break;
 	}
 
 	cyber2000fb_writel(bgx, CO_REG_FOREGROUND, cfb);
@@ -313,12 +322,15 @@
 {
 	struct cfb_info *cfb = (struct cfb_info *)info;
 
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
-				regno | regno << 5 | regno << 11;
+				((red   << 8) & 0xf800) |
+				((green << 3) & 0x07e0) |
+				((blue  >> 3));
 		break;
 #endif
 
@@ -368,7 +382,9 @@
 		}
 		if (regno < 16)
 			((u16 *)cfb->fb.pseudo_palette)[regno] =
-				regno | regno << 5 | regno << 10;
+				((red   << 7) & 0x7c00) |
+				((green << 2) & 0x03e0) |
+				((blue  >> 3));
 		break;
 
 #endif
@@ -382,7 +398,20 @@
 
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
 
@@ -523,6 +552,10 @@
 
 	base = var->yoffset * var->xres_virtual + var->xoffset;
 
+	/* have to be careful, because bits_per_pixel might be 15
+	   in this version of the driver -- dok@directfb.org 2002/06/13 */
+	base *= (var->bits_per_pixel + 7) >> 3;
+
 	base >>= 2;
 
 	if (base >= 1 << 20)
@@ -808,6 +841,14 @@
 		hw->palette_ctrl	|= 0x10;
 		break;
 #endif
+#ifdef FBCON_HAS_CFB32
+	case 32:/* TRUECOLOUR, 16m */
+		hw->pixformat		= PIXFORMAT_32BPP;
+		hw->visualid		= VISUALID_16M_32;
+		hw->pitch		= hw->width >> 1;
+		hw->palette_ctrl	|= 0x10;
+		break;
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -902,7 +943,6 @@
 #ifdef FBCON_HAS_CFB16
 	case 16:/* DIRECTCOLOUR, 64k */
 #ifndef CFB16_IS_CFB15
-		var->bits_per_pixel	= 15;
 		var->red.offset		= 11;
 		var->red.length		= 5;
 		var->green.offset	= 5;
@@ -944,6 +984,23 @@
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
diff -uraN linux-2.4.19-pre10/drivers/video/cyber2000fb.h linux-2.4.19-pre10-cyber32bit/drivers/video/cyber2000fb.h
--- linux-2.4.19-pre10/drivers/video/cyber2000fb.h	Thu Oct 11 18:43:30 2001
+++ linux-2.4.19-pre10-cyber32bit/drivers/video/cyber2000fb.h	Thu Jun 13 10:03:40 2002
@@ -39,9 +39,11 @@
 #define PIXFORMAT_8BPP		0
 #define PIXFORMAT_16BPP		1
 #define PIXFORMAT_24BPP		2
+#define PIXFORMAT_32BPP		3
 
 #define VISUALID_256		1
 #define VISUALID_64K		2
+#define VISUALID_16M_32		3
 #define VISUALID_16M		4
 #define VISUALID_32K		6
 

--LQksG6bCIzRHxTLp--

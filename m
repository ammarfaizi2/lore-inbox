Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265607AbRF1It7>; Thu, 28 Jun 2001 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265605AbRF1Itk>; Thu, 28 Jun 2001 04:49:40 -0400
Received: from sky.irisa.fr ([131.254.60.147]:15337 "EHLO sky.irisa.fr")
	by vger.kernel.org with ESMTP id <S265603AbRF1Itc>;
	Thu, 28 Jun 2001 04:49:32 -0400
Message-ID: <3B3AEF8B.A3EBF2AC@irisa.fr>
Date: Thu, 28 Jun 2001 10:49:15 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA, Campus de Beaulieu, 35042 Rennes Cedex, FRANCE
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<Linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH][2.2 & 2.4] fbgen & multiple RGBA, take 3 (no more MIME)
In-Reply-To: <Pine.LNX.4.10.10106270922550.30940-100000@transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:

> I will intergrate your changes into my fbgen 2.

Guess that means it's OK to ask for integration.
I repost it with proper inlining (sorry about that)

Description of the patch:

> the attached patch fix a problem with `fbgen' when changing the
> RGBA components but not the depth ; `fbgen' would not change
> the colormap in this case, where it should.
> This patch is for kernel 2.4.x, but can also
> be applied to kernel 2.2.x (same bug, same fix).

#####
--- linux/drivers/video/fbgen.c.ORIG	Thu May 17 14:34:54 2001
+++ linux/drivers/video/fbgen.c	Tue Jun 26 10:26:23 2001
@@ -106,6 +106,7 @@
     struct fb_info_gen *info2 = (struct fb_info_gen *)info;
     int err;
     int oldxres, oldyres, oldbpp, oldxres_virtual, oldyres_virtual,
oldyoffset;
+    struct fb_bitfield oldred, oldgreen, oldblue;
 
     if ((err = fbgen_do_set_var(var, con == currcon, info2)))
 	return err;
@@ -115,12 +116,18 @@
 	oldxres_virtual = fb_display[con].var.xres_virtual;
 	oldyres_virtual = fb_display[con].var.yres_virtual;
 	oldbpp = fb_display[con].var.bits_per_pixel;
+	oldred = fb_display[con].var.red;
+	oldgreen = fb_display[con].var.green;
+	oldblue = fb_display[con].var.blue;
 	oldyoffset = fb_display[con].var.yoffset;
 	fb_display[con].var = *var;
 	if (oldxres != var->xres || oldyres != var->yres ||
 	    oldxres_virtual != var->xres_virtual ||
 	    oldyres_virtual != var->yres_virtual ||
 	    oldbpp != var->bits_per_pixel ||
+	    (!(memcmp(&oldred, &(var->red), sizeof(struct fb_bitfield)))) || 
+	    (!(memcmp(&oldgreen, &(var->green), sizeof(struct fb_bitfield))))
||
+	    (!(memcmp(&oldblue, &(var->blue), sizeof(struct fb_bitfield)))) ||
 	    oldyoffset != var->yoffset) {
 	    fbgen_set_disp(con, info2);
 	    if (info->changevar)
#####


-- 
DOLBEAU Romain               | l'histoire est entierement vraie, puisque
ENS Cachan / Ker Lann        |     je l'ai imaginee d'un bout a l'autre
dolbeau@irisa.fr             |           -- Boris Vian

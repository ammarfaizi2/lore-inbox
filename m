Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUIIVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUIIVwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbUIIVuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:50:50 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:11227 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267180AbUIIVeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:01 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/7] fbdev: remove unnecessary banshee_wait_idle from tdfxfb
Date: Fri, 10 Sep 2004 05:34:29 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100534.29454.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- This patch removes the unnecessary call to banshee_wait_idle() from
  tdfxfb_copyarea, imageblit and fillrect.  Removal of the sync will garner
  an additional ~20% in scrolling speed.

- Removes "inverse" which generates a compile warning if modular.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 tdfxfb.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm4/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tdfxfb.c	2004-09-08 12:45:38.552927032 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tdfxfb.c	2004-09-08 12:47:28.012286680 +0800
@@ -202,7 +202,6 @@ static unsigned long do_lfb_size(struct 
  */
 static int  nopan   = 0;
 static int  nowrap  = 1;      // not implemented (yet)
-static int  inverse = 0;
 static char *mode_option __initdata = NULL;
 
 /* ------------------------------------------------------------------------- 
@@ -921,7 +920,6 @@ static void tdfxfb_fillrect(struct fb_in
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
 	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));
-	banshee_wait_idle(info);
 }
 
 /*
@@ -957,7 +955,6 @@ static void tdfxfb_copyarea(struct fb_in
 	tdfx_outl(par,	DSTSIZE,   area->width | (area->height << 16));
 	tdfx_outl(par,	DSTXY,     dx | (dy << 16));
 	tdfx_outl(par,	LAUNCH_2D, sx | (sy << 16)); 
-	banshee_wait_idle(info);
 }
 
 static void tdfxfb_imageblit(struct fb_info *info, const struct fb_image *image) 
@@ -1025,7 +1022,6 @@ static void tdfxfb_imageblit(struct fb_i
 		case 2:  tdfx_outl(par,	LAUNCH_2D,*(u16*)chardata); break;
 		case 3:  tdfx_outl(par,	LAUNCH_2D,*(u16*)chardata | ((chardata[3]) << 24)); break;
 	}
-	banshee_wait_idle(info);
 }
 #endif /* CONFIG_FB_3DFX_ACCEL */
 
@@ -1392,10 +1388,7 @@ void tdfxfb_setup(char *options)
 	while ((this_opt = strsep(&options, ",")) != NULL) {	
 		if (!*this_opt)
 			continue;
-		if (!strcmp(this_opt, "inverse")) {
-			inverse = 1;
-			fb_invert_cmaps();
-		} else if(!strcmp(this_opt, "nopan")) {
+		if(!strcmp(this_opt, "nopan")) {
 			nopan = 1;
 		} else if(!strcmp(this_opt, "nowrap")) {
 			nowrap = 1;



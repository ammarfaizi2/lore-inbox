Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUIDDMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUIDDMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270026AbUIDDMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:12:16 -0400
Received: from smtp-out.hotpop.com ([38.113.3.51]:46033 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S265222AbUIDDMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:12:02 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/5] fbdev: Speed up scrolling of tdfxfb
Date: Sat, 4 Sep 2004 11:06:50 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041106.51013.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch speeds up scrolling of tdfxfb by maximizing var->yres_virtual so
tdfxfb uses SCROLL_PAN_MOVE instead of SCROLL_REDRAW.  This is true whether
CONFIG_FB_3DFX_ACCEL is set or not. This problem was reported by Paolo
Ornati <ornati@fastwebnet.it> who also made substantial contributions to
solve this problem.

This patch also fixes compile errors when CONFIG_FB_3DFX_ACCEL is false.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Makefile |    5 ++---
 tdfxfb.c |   47 +++++++++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 19 deletions(-)

diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/Makefile linux-2.6.9-rc1-mm3/drivers/video/Makefile
--- linux-2.6.9-rc1-mm3-orig/drivers/video/Makefile	2004-09-04 04:26:37.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/Makefile	2004-09-04 08:23:53.176782760 +0800
@@ -34,10 +34,9 @@ obj-$(CONFIG_FB_CYBER)            += cyb
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             += tdfxfb.o tdfxfb_lib.o
-tdfxfb_lib-y                      := cfbimgblt.o
+obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
 ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
-tdfxfb_lib-y                      += cfbfillrect.o cfbcopyarea.o
+obj-$(CONFIG_FB_3DFX)             += cfbfillrect.o cfbcopyarea.o
 endif
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm3/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/tdfxfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/tdfxfb.c	2004-09-04 08:23:48.520490624 +0800
@@ -168,7 +168,6 @@ static int banshee_wait_idle(struct fb_i
 static void tdfxfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 static void tdfxfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);  
 static void tdfxfb_imageblit(struct fb_info *info, const struct fb_image *image); 
-static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 #endif /* CONFIG_FB_3DFX_ACCEL */
 
 static struct fb_ops tdfxfb_ops = {
@@ -183,13 +182,12 @@ static struct fb_ops tdfxfb_ops = {
 	.fb_fillrect	= tdfxfb_fillrect,
 	.fb_copyarea	= tdfxfb_copyarea,
 	.fb_imageblit	= tdfxfb_imageblit,
-	.fb_cursor	= tdfxfb_cursor,
 #else
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 #endif
+	.fb_cursor	= soft_cursor,
 };
 
 /*
@@ -502,15 +500,11 @@ static int tdfxfb_check_var(struct fb_va
 		return -EINVAL;
 	}
 
-	if (var->xres != var->xres_virtual) {
-		DPRINTK("virtual x resolution != physical x resolution not supported\n");
-		return -EINVAL;
-	}
+	if (var->xres != var->xres_virtual)
+		var->xres_virtual = var->xres;
 
-	if (var->yres > var->yres_virtual) {
-		DPRINTK("virtual y resolution < physical y resolution not possible\n");
-		return -EINVAL;
-	}
+	if (var->yres > var->yres_virtual)
+		var->yres_virtual = var->yres;
 
 	if (var->xoffset) {
 		DPRINTK("xoffset not supported\n");
@@ -539,9 +533,12 @@ static int tdfxfb_check_var(struct fb_va
 	}
   
 	if (lpitch * var->yres_virtual > info->fix.smem_len) {
-		DPRINTK("no memory for screen (%ux%ux%u)\n",
-		var->xres, var->yres_virtual, var->bits_per_pixel);
-		return -EINVAL;
+		var->yres_virtual = info->fix.smem_len/lpitch;
+		if (var->yres_virtual < var->yres) {
+			DPRINTK("no memory for screen (%ux%ux%u)\n",
+			var->xres, var->yres_virtual, var->bits_per_pixel);
+			return -EINVAL;
+		}
 	}
   
 	if (PICOS2KHZ(var->pixclock) > par->max_pixclock) {
@@ -1030,7 +1027,9 @@ static void tdfxfb_imageblit(struct fb_i
 	}
 	banshee_wait_idle(info);
 }
+#endif /* CONFIG_FB_3DFX_ACCEL */
 
+#ifdef TDFX_HARDWARE_CURSOR
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct tdfx_par *par = (struct tdfx_par *) info->par;
@@ -1167,7 +1166,7 @@ static int tdfxfb_cursor(struct fb_info 
 	spin_unlock_irqrestore(&par->DAClock, flags);
 	return 0;
 }
-#endif /* CONFIG_FB_3DFX_ACCEL */
+#endif
 
 /**
  *      tdfxfb_probe - Device Initializiation
@@ -1183,7 +1182,7 @@ static int __devinit tdfxfb_probe(struct
 {
 	struct tdfx_par *default_par;
 	struct fb_info *info;
-	int size, err;
+	int size, err, lpitch;
 
 	if ((err = pci_enable_device(pdev))) {
 		printk(KERN_WARNING "tdfxfb: Can't enable pdev: %d\n", err);
@@ -1288,6 +1287,22 @@ static int __devinit tdfxfb_probe(struct
 	if (!err || err == 4)
 		info->var = tdfx_var;
 
+	/* maximize virtual vertical length */
+	lpitch = info->var.xres_virtual * ((info->var.bits_per_pixel + 7) >> 3);
+	info->var.yres_virtual = info->fix.smem_len/lpitch;
+	if (info->var.yres_virtual < info->var.yres)
+		goto out_err;
+
+#ifdef CONFIG_FB_3DFX_ACCEL
+	/*
+	 * FIXME: Limit var->yres_virtual to 4096 because of screen artifacts
+	 * during scrolling. This is only present if 2D acceleration is
+	 * enabled.
+	 */
+	if (info->var.yres_virtual > 4096)
+		info->var.yres_virtual = 4096;
+#endif /* CONFIG_FB_3DFX_ACCEL */
+
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		printk(KERN_WARNING "tdfxfb: Can't allocate color map\n");
 		goto out_err;


 



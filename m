Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUIAKvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUIAKvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUIAKvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:51:16 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:58292 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S265207AbUIAKvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:51:06 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 18:51:00 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
References: <200408312133.40039.ornati@fastwebnet.it> <200409010920.13307.ornati@fastwebnet.it> <200409011821.06520.adaplas@hotpop.com>
In-Reply-To: <200409011821.06520.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409011851.00777.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 18:21, Antonino A. Daplas wrote:
> On Wednesday 01 September 2004 15:20, Paolo Ornati wrote:
> > Ok, with this patch and CONFIG_FB_3DFX_ACCEL=y the scrolling speed comes
> > back (only a bit slower than with 2.6.8.1 without CONFIG_FB_3DFX_ACCEL):
> >
> > $ time cat MAINTAINERS: ~2.67s
>
> Ok.  However, I'm still wondering at the scrolling speed, it's a bit slower
> than what I would expect (I get < 1 second with vesafb which is completely
> unaccelerated).
>

Ok, I think I know why the scrolling speed is too slow, the driver is not
maximizing the extra memory of the framebuffer.

This patch sets info->var.yres_virtual to the maximum upon driver load. If
this works, it's possible to get sub-1 second scrolling speed.

Reverse the previous patch first, then apply this patch.

Tony
---

diff -uprN linux-2.6.9-rc1-mm1-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm1/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm1-orig/drivers/video/tdfxfb.c	2004-08-30 19:39:19.000000000 +0800
+++ linux-2.6.9-rc1-mm1/drivers/video/tdfxfb.c	2004-09-01 18:42:44.833205600 +0800
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
@@ -1288,6 +1287,12 @@ static int __devinit tdfxfb_probe(struct
 	if (!err || err == 4)
 		info->var = tdfx_var;
 
+	/* maximize virtual vertical length */
+	lpitch = info->var.xres_virtual * ((info->var.bits_per_pixel + 7) >> 3);
+	info->var.yres_virtual = info->fix.smem_len/lpitch;
+	if (info->var.yres_virtual < info->var.yres)
+		goto out_err;
+
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		printk(KERN_WARNING "tdfxfb: Can't allocate color map\n");
 		goto out_err;



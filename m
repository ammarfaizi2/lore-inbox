Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUIAACA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUIAACA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUHaXrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:47:11 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:12950 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S269129AbUHaX3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:29:18 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 07:29:07 +0800
User-Agent: KMail/1.5.4
References: <200408312133.40039.ornati@fastwebnet.it>
In-Reply-To: <200408312133.40039.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409010729.07156.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 03:33, Paolo Ornati wrote:
> Tests with "linux/MAINTAINERS" (time cat MAINTAINERS)
> 2.6.8.1
> 	real    0m2.625s
> 	user    0m0.000s
> 	sys     0m2.621s
>
> 2.6.9-rc1
> 	real    0m13.528s
> 	user    0m0.000s
> 	sys     0m13.553s
>
>
> Also many -mm kernels are affected... this is obvious because these patches
> come from Andrew's tree ;-)
>

Try this patch also, but select Y for CONFIG_FB_3DFX_ACCEL.  You also need
to revert info->flags to FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;

Tony

diff -uprN linux-2.6.9-rc1-mm1-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm1/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm1-orig/drivers/video/tdfxfb.c	2004-08-30 19:39:19.000000000 +0800
+++ linux-2.6.9-rc1-mm1/drivers/video/tdfxfb.c	2004-09-01 07:23:12.855078672 +0800
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
@@ -1030,7 +1028,9 @@ static void tdfxfb_imageblit(struct fb_i
 	}
 	banshee_wait_idle(info);
 }
+#endif /* CONFIG_FB_3DFX_ACCEL */
 
+#ifdef TDFX_HARDWARE_CURSOR
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct tdfx_par *par = (struct tdfx_par *) info->par;
@@ -1167,7 +1167,7 @@ static int tdfxfb_cursor(struct fb_info 
 	spin_unlock_irqrestore(&par->DAClock, flags);
 	return 0;
 }
-#endif /* CONFIG_FB_3DFX_ACCEL */
+#endif
 
 /**
  *      tdfxfb_probe - Device Initializiation



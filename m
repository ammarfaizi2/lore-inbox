Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbTEKKUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTEKKUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:20:43 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:25404 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261198AbTEKKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:20:42 -0400
Date: Sun, 11 May 2003 12:30:11 +0200
Message-Id: <200305111030.h4BAUBhO019633@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>, Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari Atyfb fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atyfb fixes for Atari (got reversed in 2.5.69):
  - Add missing allocation of default_par
  - Kill warnings in assignments

--- linux-2.5.x/drivers/video/aty/atyfb_base.c	Mon Feb 10 21:59:19 2003
+++ linux-m68k-2.5.x/drivers/video/aty/atyfb_base.c	Tue Feb 25 18:31:27 2003
@@ -2319,15 +2319,25 @@
 			return -ENOMEM;
 		}
 		memset(info, 0, sizeof(struct fb_info));
-		info->fix = atyfb_fix;		
+
+		default_par = kmalloc(sizeof(struct atyfb_par), GFP_ATOMIC);
+		if (!default_par) {
+			printk
+			    ("atyfb_init: can't alloc atyfb_par\n");
+			kfree(info);
+			return -ENXIO;
+		}
+		memset(default_par, 0, sizeof(struct atyfb_par));
+
+		info->fix = atyfb_fix;
 
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
 		 *  kernel address space.
 		 */
-		info->screen_base = (unsigned long)ioremap(phys_vmembase[m64_num],
+		info->screen_base = ioremap(phys_vmembase[m64_num],
 					 		   phys_size[m64_num]);	
-		info->fix.smem_start = info->screen_base;	/* Fake! */
+		info->fix.smem_start = (unsigned long)info->screen_base;	/* Fake! */
 		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
 							  0x10000) + 0xFC00ul;
 		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

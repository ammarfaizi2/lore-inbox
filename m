Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbSLLDhp>; Wed, 11 Dec 2002 22:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbSLLDhp>; Wed, 11 Dec 2002 22:37:45 -0500
Received: from dp.samba.org ([66.70.73.150]:50404 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267412AbSLLDhk>;
	Wed, 11 Dec 2002 22:37:40 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15864.1613.688767.520790@argo.ozlabs.ibm.com>
Date: Thu, 12 Dec 2002 14:45:17 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fix offb
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the offb driver, and fixes the Makefile so it doesn't
go looking for a nonexistent file (cfbimgblit.o) when CONFIG_FB_OF is
turned on.  In the offb driver, we were overrunning the end of the
info->fix.id field on some cards, plus it had an undefined variable.
I guess we could also get rid of the "info->node = NODEV;" line too.

Paul.

diff -urN linux-2.5/drivers/video/Makefile pmac-2.5/drivers/video/Makefile
--- linux-2.5/drivers/video/Makefile	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/Makefile	2002-12-10 21:25:36.000000000 +1100
@@ -42,7 +42,7 @@
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblit.o cfbcopyarea.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o
diff -urN linux-2.5/drivers/video/offb.c pmac-2.5/drivers/video/offb.c
--- linux-2.5/drivers/video/offb.c	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/offb.c	2002-12-10 19:58:24.000000000 +1100
@@ -393,6 +393,7 @@
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
 	struct fb_info *info;
+	int size;
 
 	if (!request_mem_region(res_start, res_size, "offb"))
 		return;
@@ -421,7 +422,7 @@
 	var = &info->var;
 
 	strcpy(fix->id, "OFfb ");
-	strncat(fix->id, name, sizeof(fix->id));
+	strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
 	fix->id[sizeof(fix->id) - 1] = '\0';
 
 	var->xres = var->xres_virtual = width;
@@ -522,8 +523,6 @@
 	var->sync = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	strcpy(fix->id, "OFfb ");
-	strncat(fix->id, full_name, sizeof(fix->id));
 	info->node = NODEV;
 	info->fbops = &offb_ops;
 	info->screen_base = ioremap(address, fix->smem_len);

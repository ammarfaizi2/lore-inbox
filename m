Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUKUPku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUKUPku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUKUPkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:40:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43272 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261645AbUKUPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:18 -0500
Date: Sun, 21 Nov 2004 16:36:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] cyber2000fb.c: misc cleanups
Message-ID: <20041121153614.GR2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below ncludes the following cleanups for 
drivers/video/cyber2000fb.c:
- remove five EXPORT_SYMBOL'ed but completely unused functions
- make some needlessly global code static


diffstat output:
 drivers/video/cyber2000fb.c |   79 +-----------------------------------
 drivers/video/cyber2000fb.h |    9 ----
 2 files changed, 4 insertions(+), 84 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/cyber2000fb.h.old	2004-11-21 15:04:35.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/cyber2000fb.h	2004-11-21 15:04:59.000000000 +0100
@@ -497,12 +497,3 @@
 
 struct fb_var_screeninfo;
 
-/*
- * Note! Writing to the Cyber20x0 registers from an interrupt
- * routine is definitely a bad idea atm.
- */
-int cyber2000fb_attach(struct cyberpro_info *info, int idx);
-void cyber2000fb_detach(int idx);
-void cyber2000fb_enable_extregs(struct cfb_info *cfb);
-void cyber2000fb_disable_extregs(struct cfb_info *cfb);
-void cyber2000fb_get_fb_var(struct cfb_info *cfb, struct fb_var_screeninfo *var);
--- linux-2.6.10-rc2-mm2-full/drivers/video/cyber2000fb.c.old	2004-11-21 15:05:10.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/cyber2000fb.c	2004-11-21 15:10:01.000000000 +0100
@@ -1075,79 +1075,6 @@
 static struct cfb_info		*int_cfb_info;
 
 /*
- * Enable access to the extended registers
- */
-void cyber2000fb_enable_extregs(struct cfb_info *cfb)
-{
-	cfb->func_use_count += 1;
-
-	if (cfb->func_use_count == 1) {
-		int old;
-
-		old = cyber2000_grphr(EXT_FUNC_CTL, cfb);
-		old |= EXT_FUNC_CTL_EXTREGENBL;
-		cyber2000_grphw(EXT_FUNC_CTL, old, cfb);
-	}
-}
-
-/*
- * Disable access to the extended registers
- */
-void cyber2000fb_disable_extregs(struct cfb_info *cfb)
-{
-	if (cfb->func_use_count == 1) {
-		int old;
-
-		old = cyber2000_grphr(EXT_FUNC_CTL, cfb);
-		old &= ~EXT_FUNC_CTL_EXTREGENBL;
-		cyber2000_grphw(EXT_FUNC_CTL, old, cfb);
-	}
-
-	if (cfb->func_use_count == 0)
-		printk(KERN_ERR "disable_extregs: count = 0\n");
-	else
-		cfb->func_use_count -= 1;
-}
-
-void cyber2000fb_get_fb_var(struct cfb_info *cfb, struct fb_var_screeninfo *var)
-{
-	memcpy(var, &cfb->fb.var, sizeof(struct fb_var_screeninfo));
-}
-
-/*
- * Attach a capture/tv driver to the core CyberX0X0 driver.
- */
-int cyber2000fb_attach(struct cyberpro_info *info, int idx)
-{
-	if (int_cfb_info != NULL) {
-		info->dev	      = int_cfb_info->dev;
-		info->regs	      = int_cfb_info->regs;
-		info->fb	      = int_cfb_info->fb.screen_base;
-		info->fb_size	      = int_cfb_info->fb.fix.smem_len;
-		info->enable_extregs  = cyber2000fb_enable_extregs;
-		info->disable_extregs = cyber2000fb_disable_extregs;
-		info->info            = int_cfb_info;
-
-		strlcpy(info->dev_name, int_cfb_info->fb.fix.id, sizeof(info->dev_name));
-	}
-
-	return int_cfb_info != NULL;
-}
-
-/*
- * Detach a capture/tv driver from the core CyberX0X0 driver.
- */
-void cyber2000fb_detach(int idx)
-{
-}
-
-EXPORT_SYMBOL(cyber2000fb_attach);
-EXPORT_SYMBOL(cyber2000fb_detach);
-EXPORT_SYMBOL(cyber2000fb_enable_extregs);
-EXPORT_SYMBOL(cyber2000fb_disable_extregs);
-EXPORT_SYMBOL(cyber2000fb_get_fb_var);
-
-/*
  * These parameters give
  * 640x480, hsync 31.5kHz, vsync 60Hz
  */
@@ -1306,7 +1233,8 @@
  * Parse Cyber2000fb options.  Usage:
  *  video=cyber2000:font:fontname
  */
-int
+#ifndef MODULE
+static int
 cyber2000fb_setup(char *options)
 {
 	char *opt;
@@ -1328,6 +1256,7 @@
 	}
 	return 0;
 }
+#endif
 
 /*
  * The CyberPro chips can be placed on many different bus types.
@@ -1717,7 +1646,7 @@
  *
  * Tony: "module_init" is now required
  */
-int __init cyber2000fb_init(void)
+static int __init cyber2000fb_init(void)
 {
 	int ret = -1, err;
 


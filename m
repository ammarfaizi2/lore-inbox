Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUKUPkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUKUPkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUKUPk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:40:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44552 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261653AbUKUPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:22 -0500
Date: Sun, 21 Nov 2004 16:36:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: lethal@linux-sh.org
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] small drivers/video/kyro/ cleanups
Message-ID: <20041121153618.GS2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups under drivers/video/kyro/ :
- remove an unused global varaible from STG4000Ramdac.c
- make some needlessly global code static


diffstat output:
 drivers/video/kyro/STG4000InitDevice.c    |    4 ++--
 drivers/video/kyro/STG4000OverlayDevice.c |    4 ++--
 drivers/video/kyro/STG4000Ramdac.c        |    1 -
 drivers/video/kyro/fbdev.c                |   14 ++++++++------
 include/video/kyro.h                      |    2 --
 5 files changed, 12 insertions(+), 13 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/include/video/kyro.h.old	2004-11-21 03:16:55.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/include/video/kyro.h	2004-11-21 03:17:07.000000000 +0100
@@ -49,9 +49,7 @@
 extern unsigned int kyro_dev_fb_size(void);
 extern unsigned int kyro_dev_regs_size(void);
 
-extern int kyro_dev_overlay_create(u32 width, u32 height, int bLinear);
 extern u32 kyro_dev_overlay_offset(void);
-extern int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 width, u32 height);
 
 /*
  * benedict.gaster@superh.com
--- linux-2.6.10-rc2-mm2-full/drivers/video/kyro/fbdev.c.old	2004-11-21 03:17:15.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/kyro/fbdev.c	2004-11-21 15:48:10.000000000 +0100
@@ -307,7 +307,7 @@
 };
 
 /* Accessors */
-int kyro_dev_video_mode_set(struct fb_info *info)
+static int kyro_dev_video_mode_set(struct fb_info *info)
 {
 	struct kyrofb_info *par = (struct kyrofb_info *)info->par;
 
@@ -339,8 +339,8 @@
 	return 0;
 }
 
-int kyro_dev_overlay_create(u32 ulWidth,
-			    u32 ulHeight, int bLinear)
+static int kyro_dev_overlay_create(u32 ulWidth,
+				   u32 ulHeight, int bLinear)
 {
 	u32 offset;
 	u32 stride, uvStride;
@@ -376,7 +376,7 @@
 	return 0;
 }
 
-int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight)
+static int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight)
 {
 	if (deviceInfo.ulOverlayOffset == 0)
 		/* probably haven't called CreateOverlay yet */
@@ -558,7 +558,8 @@
 	return 0;
 }
 
-int __init kyrofb_setup(char *options)
+#ifndef MODULE
+static int __init kyrofb_setup(char *options)
 {
 	char *this_opt;
 
@@ -583,6 +584,7 @@
 
 	return 0;
 }
+#endif
 
 static int kyrofb_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg,
@@ -786,7 +788,7 @@
 	kfree(info);
 }
 
-int __init kyrofb_init(void)
+static int __init kyrofb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
--- linux-2.6.10-rc2-mm2-full/drivers/video/kyro/STG4000Ramdac.c.old	2004-11-21 03:18:52.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/kyro/STG4000Ramdac.c	2004-11-21 03:19:00.000000000 +0100
@@ -18,7 +18,6 @@
 
 static u32 STG_PIXEL_BUS_WIDTH = 128;	/* 128 bit bus width      */
 static u32 REF_CLOCK = 14318;
-STG4000REG __iomem *pSTGReg;
 
 int InitialiseRamdac(volatile STG4000REG __iomem * pSTGReg,
 		     u32 displayDepth,
--- linux-2.6.10-rc2-mm2-full/drivers/video/kyro/STG4000OverlayDevice.c.old	2004-11-21 03:19:34.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/kyro/STG4000OverlayDevice.c	2004-11-21 03:20:03.000000000 +0100
@@ -42,8 +42,8 @@
 #define STG4000_OVRL_MAX_HEIGHT 576
 
 /* Decimation and Scaling */
-u32 adwDecim8[33] = {
-	0xffffffff, 0xfffeffff, 0xffdffbff, 0xfefefeff, 0xfdf7efbf,
+static u32 adwDecim8[33] = {
+	    0xffffffff, 0xfffeffff, 0xffdffbff, 0xfefefeff, 0xfdf7efbf,
 	    0xfbdf7bdf, 0xf7bbddef, 0xeeeeeeef, 0xeeddbb77, 0xedb76db7,
 	    0xdb6db6db, 0xdb5b5b5b, 0xdab5ad6b, 0xd5ab55ab, 0xd555aaab,
 	    0xaaaaaaab, 0xaaaa5555, 0xaa952a55, 0xa94a5295, 0xa5252525,
--- linux-2.6.10-rc2-mm2-full/drivers/video/kyro/STG4000InitDevice.c.old	2004-11-21 03:20:23.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/kyro/STG4000InitDevice.c	2004-11-21 03:20:49.000000000 +0100
@@ -79,8 +79,8 @@
     for(i=0;i<X;i++) count++; \
 }
 
-u32 InitSDRAMRegisters(volatile STG4000REG __iomem *pSTGReg, u32 dwSubSysID,
-			 u32 dwRevID)
+static u32 InitSDRAMRegisters(volatile STG4000REG __iomem *pSTGReg,
+			      u32 dwSubSysID, u32 dwRevID)
 {
 	u32 adwSDRAMArgCfg0[] = { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
 	u32 adwSDRAMCfg1[] = { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };

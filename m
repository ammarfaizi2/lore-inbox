Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUIRDts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUIRDts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 23:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUIRDsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 23:48:22 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:40839 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S269113AbUIRDro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 23:47:44 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/4] fbdev: Add iomem annotations to vga16fb.c
Date: Sat, 18 Sep 2004 11:48:06 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409181141.46530.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add iomem annottions to vga16fb.c

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vga16fb.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/vga16fb.c linux-2.6.9-rc2-mm1/drivers/video/vga16fb.c
--- linux-2.6.9-rc2-mm1-orig/drivers/video/vga16fb.c	2004-09-16 19:40:05.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/vga16fb.c	2004-09-18 10:46:32.325377824 +0800
@@ -123,7 +123,7 @@ static struct fb_fix_screeninfo vga16fb_
    suitable instruction is the x86 bitwise OR.  The following
    read-modify-write routine should optimize to one such bitwise
    OR. */
-static inline void rmw(volatile char *p)
+static inline void rmw(volatile char __iomem *p)
 {
 	readb(p);
 	writeb(1, p);
@@ -883,7 +883,7 @@ void vga_8planes_fillrect(struct fb_info
         char oldmask = selectmask();
         int line_ofs, height;
         char oldop, oldsr;
-        char *where;
+        char __iomem *where;
 
         dx /= 4;
         where = info->screen_base + dx + rect->dy * info->fix.line_length;
@@ -932,7 +932,7 @@ void vga_8planes_fillrect(struct fb_info
 void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	int x, x2, y2, vxres, vyres, width, height, line_ofs;
-	char *dst;
+	char __iomem *dst;
 
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
@@ -1012,7 +1012,8 @@ void vga_8planes_copyarea(struct fb_info
         char oldsr = setsr(0xf);
         int height, line_ofs, x;
 	u32 sx, dx, width;
-	char *dest, *src;
+	char __iomem *dest;
+	char __iomem *src;
 
         height = area->height;
 
@@ -1063,7 +1064,8 @@ void vga16fb_copyarea(struct fb_info *in
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy; 
 	int x, x2, y2, old_dx, old_dy, vxres, vyres;
 	int height, width, line_ofs;
-	char *dst = NULL, *src = NULL;
+	char __iomem *dst = NULL;
+	char __iomem *src = NULL;
 
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
@@ -1174,7 +1176,7 @@ void vga_8planes_imageblit(struct fb_inf
         char oldmask = selectmask();
         const char *cdat = image->data;
 	u32 dx = image->dx;
-        char *where;
+        char __iomem *where;
         int y;
 
         dx /= 4;
@@ -1198,10 +1200,11 @@ void vga_8planes_imageblit(struct fb_inf
 
 void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
 {
-	char *where = info->screen_base + (image->dx/8) + 
+	char __iomem *where = info->screen_base + (image->dx/8) +
 		image->dy * info->fix.line_length;
 	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
-	char *cdat = (char *) image->data, *dst;
+	char *cdat = (char *) image->data;
+	char __iomem *dst;
 	int x, y;
 
 	switch (info->fix.type) {
@@ -1265,9 +1268,11 @@ void vga_imageblit_color(struct fb_info 
 	 * Draw logo 
 	 */
 	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
-	char *where = info->screen_base + image->dy * info->fix.line_length + 
+	char __iomem *where =
+		info->screen_base + image->dy * info->fix.line_length +
 		image->dx/8;
-	const char *cdat = image->data, *dst;
+	const char *cdat = image->data;
+	char __iomem *dst;
 	int x, y;
 
 	switch (info->fix.type) {
@@ -1354,7 +1359,7 @@ int __init vga16fb_init(void)
 
 	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
 
-	vga16fb.screen_base = (void *)VGA_MAP_MEM(VGA_FB_PHYS);
+	vga16fb.screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS);
 	if (!vga16fb.screen_base) {
 		printk(KERN_ERR "vga16fb: unable to map device\n");
 		ret = -ENOMEM;



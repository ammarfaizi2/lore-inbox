Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUG2CTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUG2CTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUG2CSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:18:23 -0400
Received: from twix.hotpop.com ([38.113.3.71]:59620 "EHLO twix.hotpop.com")
	by vger.kernel.org with ESMTP id S267415AbUG2COq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:14:46 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/5] [I810FB]: i810fb fixes
Date: Thu, 29 Jul 2004 10:04:32 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407290955.29735.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Fixed cursor corruption if acceleration is enabled
2. Round up fields in var instead of rounding down
3. Set capabilities flags
4. Added myself to the MAINTAINERS file for i810fb

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 MAINTAINERS                    |    6 +++
 drivers/video/Kconfig          |    4 +-
 drivers/video/i810/i810_dvt.c  |   14 +++----
 drivers/video/i810/i810_main.c |   72 ++++++++++++++++++++++++-----------------
 4 files changed, 59 insertions(+), 37 deletions(-)

diff -uprN linux-2.6.8-rc2-mm1-orig/MAINTAINERS linux-2.6.8-rc2-mm1/MAINTAINERS
--- linux-2.6.8-rc2-mm1-orig/MAINTAINERS	2004-07-29 00:36:12.028112928 +0000
+++ linux-2.6.8-rc2-mm1/MAINTAINERS	2004-07-29 00:35:56.592459504 +0000
@@ -1060,6 +1060,12 @@ M:	lethal@chaoticdreams.org
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 
+INTEL 810/815 FRAMEBUFFER DRIVER
+P:      Antonino Daplas
+M:      adaplas@pol.net
+L:      linux-fbdev-devel@lists.sourceforge.net
+S:      Maintained
+
 INTEL APIC/IOAPIC, LOWLEVEL X86 SMP SUPPORT
 P:	Ingo Molnar
 M:	mingo@redhat.com
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/Kconfig linux-2.6.8-rc2-mm1/drivers/video/Kconfig
--- linux-2.6.8-rc2-mm1-orig/drivers/video/Kconfig	2004-07-28 19:51:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/Kconfig	2004-07-29 00:35:04.115437224 +0000
@@ -457,7 +457,9 @@ config FB_RIVA_DEBUG
 
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
-	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	
+	depends on FB && EXPERIMENTAL && PCI	
+	select AGP
+	select AGP_INTEL
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/i810/i810_dvt.c linux-2.6.8-rc2-mm1/drivers/video/i810/i810_dvt.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/i810/i810_dvt.c	2004-05-10 02:33:13.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/i810/i810_dvt.c	2004-07-29 00:35:35.466671112 +0000
@@ -193,19 +193,19 @@ struct mode_registers std_modes[] = {
 
 void round_off_xres(u32 *xres) 
 {
-	if (*xres < 800) 
+	if (*xres <= 640)
 		*xres = 640;
-	if (*xres < 1024 && *xres >= 800) 
+	else if (*xres <= 800)
 		*xres = 800;
-	if (*xres < 1152 && *xres >= 1024)
+	else if (*xres <= 1024)
 		*xres = 1024;
-	if (*xres < 1280 && *xres >= 1152)
+	else if (*xres <= 1152)
 		*xres = 1152;
-	if (*xres < 1600 && *xres >= 1280)
+	else if (*xres <= 1280)
 		*xres = 1280;
-	if (*xres >= 1600)
+	else 
 		*xres = 1600;
-}		
+}
 
 inline void round_off_yres(u32 *xres, u32 *yres)
 {
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/i810/i810_main.c linux-2.6.8-rc2-mm1/drivers/video/i810/i810_main.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/i810/i810_main.c	2004-05-10 02:32:27.000000000 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/i810/i810_main.c	2004-07-29 01:53:15.973166432 +0000
@@ -1353,11 +1353,15 @@ static int i810fb_set_par(struct fb_info
 
 	encode_fix(&info->fix, info);
 
-	if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) 
+	if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) {
+		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
+		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
+		FBINFO_HWACCEL_IMAGEBLIT;
 		info->pixmap.scan_align = 2;
-	else 
+	} else { 
 		info->pixmap.scan_align = 1;
-	
+		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	}
 	return 0;
 }
 
@@ -1388,16 +1392,17 @@ static int i810fb_cursor(struct fb_info 
 {
 	struct i810fb_par *par = (struct i810fb_par *)info->par;
 	u8 *mmio = par->mmio_start_virtual;	
-	u8 data[64 * 8];
-	
+
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP) 
 		return soft_cursor(info, cursor);
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)
 		return -ENXIO;
 
-	if ((i810_readl(CURBASE, mmio) & 0xf) != par->cursor_heap.physical)
+	if ((i810_readl(CURBASE, mmio) & 0xf) != par->cursor_heap.physical) {
 		i810_init_cursor(par);
+		cursor->set |= FB_CUR_SETALL;
+	}
 
 	i810_enable_cursor(mmio, OFF);
 
@@ -1409,50 +1414,56 @@ static int i810fb_cursor(struct fb_info 
 
 		info->cursor.image.dx = cursor->image.dx;
 		info->cursor.image.dy = cursor->image.dy;
-		
-		tmp = cursor->image.dx - info->var.xoffset;
-		tmp |= (cursor->image.dy - info->var.yoffset) << 16;
-	    
+		tmp = (info->cursor.image.dx - info->var.xoffset) & 0xffff;
+		tmp |= (info->cursor.image.dy - info->var.yoffset) << 16;
 		i810_writel(CURPOS, mmio, tmp);
 	}
 
 	if (cursor->set & FB_CUR_SETSIZE) {
+		i810_reset_cursor_image(par);
 		info->cursor.image.height = cursor->image.height;
 		info->cursor.image.width = cursor->image.width;
-		i810_reset_cursor_image(par);
 	}
 
 	if (cursor->set & FB_CUR_SETCMAP) {
-		info->cursor.image.fg_color = cursor->image.fg_color;
-		info->cursor.image.bg_color = cursor->image.bg_color;
 		i810_load_cursor_colors(cursor->image.fg_color,
 					cursor->image.bg_color,
 					info);
+		info->cursor.image.fg_color = cursor->image.fg_color;
+		info->cursor.image.bg_color = cursor->image.bg_color;
+
 	}
 
-	if (cursor->set & FB_CUR_SETSHAPE) {
+	if (cursor->set & (FB_CUR_SETSHAPE)) {
 		int size = ((info->cursor.image.width + 7) >> 3) * 
-			     info->cursor.image.height;
+			info->cursor.image.height;
 		int i;
+		u8 *data = kmalloc(64 * 8, GFP_KERNEL);
+
+		if (data == NULL)
+			return -ENOMEM;
+		info->cursor.image.data = cursor->image.data;
 
 		switch (info->cursor.rop) {
 		case ROP_XOR:
 			for (i = 0; i < size; i++)
-				data[i] = cursor->image.data[i] ^ info->cursor.mask[i]; 
+				data[i] = info->cursor.image.data[i] ^ info->cursor.mask[i]; 
 			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < size; i++)
-				data[i] = cursor->image.data[i] & info->cursor.mask[i]; 
+				data[i] = info->cursor.image.data[i] & info->cursor.mask[i]; 
 			break;
 		}
 		i810_load_cursor_image(info->cursor.image.width, 
 				       info->cursor.image.height, data,
 				       par);
+		kfree(data);
 	}
-
-	if (info->cursor.enable)
+	
+	if (info->cursor.enable) 
 		i810_enable_cursor(mmio, ON);
+
 	return 0;
 }
 
@@ -1641,9 +1652,11 @@ static void __devinit i810_init_monspecs
 		hsync1 = HFMIN;
 	if (!hsync2) 
 		hsync2 = HFMAX;
-	info->monspecs.hfmax = hsync2;
-	info->monspecs.hfmin = hsync1;
-	if (hsync2 < hsync1) 
+	if (!info->monspecs.hfmax)
+		info->monspecs.hfmax = hsync2;
+	if (!info->monspecs.hfmin)
+		info->monspecs.hfmin = hsync1;
+	if (hsync1 < hsync2) 
 		info->monspecs.hfmin = hsync2;
 
 	if (!vsync1)
@@ -1652,8 +1665,10 @@ static void __devinit i810_init_monspecs
 		vsync2 = VFMAX;
 	if (IS_DVT && vsync1 < 60)
 		vsync1 = 60;
-	info->monspecs.vfmax = vsync2;
-	info->monspecs.vfmin = vsync1;		
+	if (!info->monspecs.vfmax)
+		info->monspecs.vfmax = vsync2;
+	if (!info->monspecs.vfmin)
+		info->monspecs.vfmin = vsync1;		
 	if (vsync2 < vsync1) 
 		info->monspecs.vfmin = vsync2;
 }
@@ -1724,6 +1739,7 @@ static void __devinit i810_init_device(s
 	pci_read_config_byte(par->dev, 0x50, &reg);
 	reg &= FREQ_MASK;
 	par->mem_freq = (reg) ? 133 : 100;
+
 }
 
 static int __devinit 
@@ -1836,8 +1852,9 @@ static int __devinit i810fb_init_pci (st
 {
 	struct fb_info    *info;
 	struct i810fb_par *par = NULL;
-	int err, vfreq, hfreq, pixclock;
+	int i, err = -1, vfreq, hfreq, pixclock;
 
+	i = 0;
 	if (!(info = kmalloc(sizeof(struct fb_info), GFP_KERNEL))) {
 		i810fb_release_resource(info, par);
 		return -ENOMEM;
@@ -1879,8 +1896,6 @@ static int __devinit i810fb_init_pci (st
 	info->screen_base = par->fb.virtual;
 	info->fbops = &par->i810fb_ops;
 	info->pseudo_palette = par->pseudo_palette;
-	info->flags = FBINFO_FLAG_DEFAULT;
-	
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	if ((err = info->fbops->fb_check_var(&info->var, info))) {
@@ -1957,8 +1972,7 @@ static void i810fb_release_resource(stru
 
 		kfree(par);
 	}
-	if (info) 
-		kfree(info);
+	kfree(info);
 }
 
 static void __exit i810fb_remove_pci(struct pci_dev *dev)



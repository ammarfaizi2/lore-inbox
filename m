Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268378AbTBNM5d>; Fri, 14 Feb 2003 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTBNM4f>; Fri, 14 Feb 2003 07:56:35 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:26382 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268378AbTBNMxT>;
	Fri, 14 Feb 2003 07:53:19 -0500
Date: Fri, 14 Feb 2003 15:58:33 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: framebuffer driver update (10/13)
Message-ID: <20030214125833.GJ8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEfPc/DjvCj+JzNg"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEfPc/DjvCj+JzNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This patch contains SGI visws framebuffer update. Patch makes it
compile again and brings flatpanel monitor support back.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--PEfPc/DjvCj+JzNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-fb

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/drivers/video/Kconfig linux-2.5.60/drivers/video/Kconfig
--- linux-2.5.60.vanilla/drivers/video/Kconfig	Thu Feb 13 20:29:09 2003
+++ linux-2.5.60/drivers/video/Kconfig	Thu Feb 13 20:42:02 2003
@@ -363,7 +363,7 @@
 
 config FB_SGIVW
 	tristate "SGI Visual Workstation framebuffer support"
-	depends on FB && VISWS
+	depends on FB && X86_VISWS
 	help
 	  SGI Visual Workstation support for framebuffer graphics.
 
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/drivers/video/sgivwfb.c linux-2.5.60/drivers/video/sgivwfb.c
--- linux-2.5.60.vanilla/drivers/video/sgivwfb.c	Thu Feb 13 20:29:10 2003
+++ linux-2.5.60/drivers/video/sgivwfb.c	Thu Feb 13 20:42:02 2003
@@ -13,14 +13,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <asm/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -29,7 +22,7 @@
 
 #define INCLUDE_TIMING_TABLE_DATA
 #define DBE_REG_BASE default_par.regs
-#include <asm/sgi-vwdbe.h>
+#include <video/sgivw.h>
 
 struct sgivw_par {
 	struct asregs *regs;
@@ -37,6 +30,8 @@
 	u_long timing_num;
 };
 
+#define FLATPANEL_SGI_1600SW	5
+
 /*
  *  RAM we reserve for the frame buffer. This defines the maximum screen
  *  size
@@ -54,26 +49,29 @@
 static int ypan = 0;
 static int ywrap = 0;
 
+static int flatpanel_id = -1;
+
 static struct fb_fix_screeninfo sgivwfb_fix __initdata = {
 	.id		= "SGI Vis WS FB",
 	.type		= FB_TYPE_PACKED_PIXELS,
         .visual		= FB_VISUAL_PSEUDOCOLOR,
 	.mmio_start	= DBE_REG_PHYS,
 	.mmio_len	= DBE_REG_SIZE,
-        .accel		= FB_ACCEL_NONE
+        .accel		= FB_ACCEL_NONE,
+	.line_length	= 640,
 };
 
 static struct fb_var_screeninfo sgivwfb_var __initdata = {
-        /* 640x480, 8 bpp */
-        .xres		= 640,
+	/* 640x480, 8 bpp */
+	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
 	.yres_virtual	= 480,
 	.bits_per_pixel	= 8,
-        .red		= {0, 8, 0},
-	.green		= {0, 8, 0},
-	.blue		= {0, 8, 0},
-        .height		= -1,
+	.red		= { 0, 8, 0 },
+	.green		= { 0, 8, 0 },
+	.blue		= { 0, 8, 0 },
+	.height		= -1,
 	.width		= -1,
 	.pixclock	= 20000,
 	.left_margin	= 64,
@@ -82,14 +80,35 @@
 	.lower_margin	= 32,
 	.hsync_len	= 64,
 	.vsync_len	= 2,
-        .vmode		= FB_VMODE_NONINTERLACED
+	.vmode		= FB_VMODE_NONINTERLACED
+};
+
+static struct fb_var_screeninfo sgivwfb_var1600sw __initdata = {
+	/* 1600x1024, 8 bpp */
+	.xres		= 1600,
+	.yres		= 1024,
+	.xres_virtual	= 1600,
+	.yres_virtual	= 1024,
+	.bits_per_pixel	= 8,
+	.red		= { 0, 8, 0 },
+	.green		= { 0, 8, 0 },
+	.blue		= { 0, 8, 0 },
+	.height		= -1,
+	.width		= -1,
+	.pixclock	= 9353,
+	.left_margin	= 20,
+	.right_margin	= 30,
+	.upper_margin	= 37,
+	.lower_margin	= 3,
+	.hsync_len	= 20,
+	.vsync_len	= 3,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 
 /*
  *  Interface used by the world
  */
 int sgivwfb_init(void);
-int sgivwfb_setup(char *);
 
 static int sgivwfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
 static int sgivwfb_set_par(struct fb_info *info);
@@ -114,34 +133,24 @@
 /*
  *  Internal routines
  */
-static u_long get_line_length(int xres_virtual, int bpp);
-static unsigned long bytes_per_pixel(int bpp);
-
-static unsigned long get_line_length(int xres_virtual, int bpp)
-{
-	return (xres_virtual * bytes_per_pixel(bpp));
-}
-
 static unsigned long bytes_per_pixel(int bpp)
 {
-	unsigned long length;
-
 	switch (bpp) {
-	case 8:
-		length = 1;
-		break;
-	case 16:
-		length = 2;
-		break;
-	case 32:
-		length = 4;
-		break;
-	default:
-		printk(KERN_INFO "sgivwfb: unsupported bpp=%d\n", bpp);
-		length = 0;
-		break;
+		case 8:
+			return 1;
+		case 16:
+			return 2;
+		case 32:
+			return 4;
+		default:
+			printk(KERN_INFO "sgivwfb: unsupported bpp %d\n", bpp);
+			return 0;
 	}
-	return (length);
+}
+
+static unsigned long get_line_length(int xres_virtual, int bpp)
+{
+	return (xres_virtual * bytes_per_pixel(bpp));
 }
 
 /*
@@ -280,8 +289,7 @@
 		test_mode--;
 	min_mode = test_mode;
 	timing = &dbeVTimings[min_mode];
-	printk(KERN_INFO "sgivwfb: granted dot-clock=%d KHz\n",
-	       timing->cfreq);
+	printk(KERN_INFO "sgivwfb: granted dot-clock=%d KHz\n", timing->cfreq);
 
 	/* Adjust virtual resolution, if necessary */
 	if (var->xres > var->xres_virtual || (!ywrap && !ypan))
@@ -292,11 +300,12 @@
 	/*
 	 *  Memory limit
 	 */
-	line_length =
-	    get_line_length(var->xres_virtual, var->bits_per_pixel);
+	line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
 	if (line_length * var->yres_virtual > sgivwfb_mem_size)
 		return -ENOMEM;	/* Virtual resolution to high */
 
+	info->fix.line_length = line_length;
+
 	switch (var->bits_per_pixel) {
 	case 8:
 		var->red.offset = 0;
@@ -355,6 +364,48 @@
 }
 
 /*
+ *  Setup flatpanel related registers.
+ */
+static void sgivwfb_setup_flatpanel(struct dbe_timing_info *currentTiming)
+{
+	int fp_wid, fp_hgt, fp_vbs, fp_vbe;
+	u32 outputVal = 0;
+
+	SET_DBE_FIELD(VT_FLAGS, HDRV_INVERT, outputVal, 
+		(currentTiming->flags & FB_SYNC_HOR_HIGH_ACT) ? 0 : 1);
+	SET_DBE_FIELD(VT_FLAGS, VDRV_INVERT, outputVal, 
+		(currentTiming->flags & FB_SYNC_VERT_HIGH_ACT) ? 0 : 1);
+	DBE_SETREG(vt_flags, outputVal);
+
+	/* Turn on the flat panel */
+	switch (flatpanel_id) {
+		case FLATPANEL_SGI_1600SW:
+			fp_wid = 1600;
+			fp_hgt = 1024;
+			fp_vbs = 0;
+			fp_vbe = 1600;
+			currentTiming->pll_m = 4;
+			currentTiming->pll_n = 1;
+			currentTiming->pll_p = 0;
+			break;
+		default:
+      			fp_wid = fp_hgt = fp_vbs = fp_vbe = 0xfff;
+  	}
+
+	outputVal = 0;
+	SET_DBE_FIELD(FP_DE, FP_DE_ON, outputVal, fp_vbs);
+	SET_DBE_FIELD(FP_DE, FP_DE_OFF, outputVal, fp_vbe);
+	DBE_SETREG(fp_de, outputVal);
+	outputVal = 0;
+	SET_DBE_FIELD(FP_HDRV, FP_HDRV_OFF, outputVal, fp_wid);
+	DBE_SETREG(fp_hdrv, outputVal);
+	outputVal = 0;
+	SET_DBE_FIELD(FP_VDRV, FP_VDRV_ON, outputVal, 1);
+	SET_DBE_FIELD(FP_VDRV, FP_VDRV_OFF, outputVal, fp_hgt + 1);
+	DBE_SETREG(fp_vdrv, outputVal);
+}
+
+/*
  *  Set the hardware according to 'par'.
  */
 static int sgivwfb_set_par(struct fb_info *info)
@@ -364,7 +415,7 @@
 	u32 readVal, outputVal;
 	int wholeTilesX, maxPixelsPerTileX;
 	int frmWrite1, frmWrite2, frmWrite3b;
-	struct dbe_timing_info_t *currentTiming; /* Current Video Timing */
+	struct dbe_timing_info *currentTiming; /* Current Video Timing */
 	int xpmax, ypmax;	// Monitor resolution
 	int bytesPerPixel;	// Bytes per pixel
 
@@ -514,6 +565,9 @@
 		      currentTiming->hblank_end - 3);
 	DBE_SETREG(vt_hcmap, outputVal);
 
+	if (flatpanel_id != -1)
+		sgivwfb_setup_flatpanel(currentTiming);
+
 	outputVal = 0;
 	temp = currentTiming->vblank_start - currentTiming->vblank_end - 1;
 	if (temp > 0)
@@ -680,14 +734,16 @@
 {
 	char *this_opt;
 
-	fb_info.fontname[0] = '\0';
-
 	if (!options || !*options)
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "font:", 5))
-			strcpy(fb_info.fontname, this_opt + 5);
+		if (!strncmp(this_opt, "monitor:", 8)) {
+			if (!strncmp(this_opt + 8, "crt", 3))
+				flatpanel_id = -1;
+			else if (!strncmp(this_opt + 8, "1600sw", 6))
+				flatpanel_id = FLATPANEL_SGI_1600SW;
+		}
 	}
 	return 0;
 }
@@ -697,12 +753,11 @@
  */
 int __init sgivwfb_init(void)
 {
-	printk(KERN_INFO "sgivwfb: framebuffer at 0x%lx, size %ldk\n",
-	       sgivwfb_mem_phys, sgivwfb_mem_size / 1024);
+	char *monitor;
 
 	if (!request_mem_region(DBE_REG_PHYS, DBE_REG_SIZE, "sgivwfb")) {
 		printk(KERN_ERR "sgivwfb: couldn't reserve mmio region\n");
-		goto fail_request_mem_region;
+		return -EBUSY;
 	}
 	default_par.regs = (struct asregs *) ioremap_nocache(DBE_REG_PHYS, DBE_REG_SIZE);
 	if (!default_par.regs) {
@@ -710,10 +765,7 @@
 		goto fail_ioremap_regs;
 	}
 
-#ifdef CONFIG_MTRR
-	mtrr_add((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size,
-		 MTRR_TYPE_WRCOMB, 1);
-#endif
+	mtrr_add(sgivwfb_mem_phys, sgivwfb_mem_size, MTRR_TYPE_WRCOMB, 1);
 
 	sgivwfb_fix.smem_start = sgivwfb_mem_phys;
 	sgivwfb_fix.smem_len = sgivwfb_mem_size;
@@ -722,13 +774,24 @@
 
 	fb_info.node = NODEV;
 	fb_info.fix = sgivwfb_fix;
-	fb_info.var = sgivwfb_var;
+
+	switch (flatpanel_id) {
+		case FLATPANEL_SGI_1600SW:
+			fb_info.var = sgivwfb_var1600sw;
+			monitor = "SGI 1600SW flatpanel";
+			break;
+		default:
+			fb_info.var = sgivwfb_var;
+			monitor = "CRT";
+	}
+
+	printk(KERN_INFO "sgivwfb: %s monitor selected\n", monitor);
+
 	fb_info.fbops = &sgivwfb_ops;
 	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.par = &default_par;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
 
-	fb_info.screen_base =
 	fb_info.screen_base = ioremap_nocache((unsigned long) sgivwfb_mem_phys, sgivwfb_mem_size);
 	if (!fb_info.screen_base) {
 		printk(KERN_ERR "sgivwfb: couldn't ioremap screen_base\n");
@@ -742,14 +805,16 @@
 		goto fail_register_framebuffer;
 	}
 
-	printk(KERN_INFO "fb%d: SGI BDE frame buffer device, using %ldK of video memory\n", minor(fb_info.node, sgivwfb_mem_size >> 10);
+	printk(KERN_INFO "fb%d: SGI DBE frame buffer device, using %ldK of video memory at %#lx\n",      
+		minor(fb_info.node), sgivwfb_mem_size >> 10, sgivwfb_mem_phys);
 	return 0;
 
-      fail_register_framebuffer:
+fail_register_framebuffer:
 	iounmap((char *) fb_info.screen_base);
-      fail_ioremap_fbmem:
+fail_ioremap_fbmem:
 	iounmap(default_par.regs);
-      fail_ioremap_regs:
+fail_ioremap_regs:
+	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
 	return -ENXIO;
 }
 
@@ -767,6 +832,7 @@
 	dbe_TurnOffDma();
 	iounmap(regs);
 	iounmap(&fb_info.screen_base);
+	release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
 }
 
 #endif				/* MODULE */
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/video/sgivw.h linux-2.5.60/include/video/sgivw.h
--- linux-2.5.60.vanilla/include/video/sgivw.h	Thu Feb 13 20:31:34 2003
+++ linux-2.5.60/include/video/sgivw.h	Thu Feb 13 20:42:02 2003
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/video/sgivwfb.h -- SGI DBE frame buffer device header
+ *  linux/drivers/video/sgivw.h -- SGI DBE frame buffer device header
  *
  *      Copyright (C) 1999 Silicon Graphics, Inc.
  *      Jeffrey Newquist, newquist@engr.sgi.som
@@ -12,10 +12,10 @@
 #ifndef __SGIVWFB_H__
 #define __SGIVWFB_H__
 
-#define DBE_GETREG(reg, dest)       ((dest) = DBE_REG_BASE->##reg)
-#define DBE_SETREG(reg, src)        DBE_REG_BASE->##reg = (src)
-#define DBE_IGETREG(reg, idx, dest) ((dest) = DBE_REG_BASE->##reg##[idx])
-#define DBE_ISETREG(reg, idx, src)  (DBE_REG_BASE->##reg##[idx] = (src))
+#define DBE_GETREG(reg, dest)		((dest) = DBE_REG_BASE->reg)
+#define DBE_SETREG(reg, src)		DBE_REG_BASE->reg = (src)
+#define DBE_IGETREG(reg, idx, dest)	((dest) = DBE_REG_BASE->reg[idx])
+#define DBE_ISETREG(reg, idx, src)	(DBE_REG_BASE->reg[idx] = (src))
 
 #define MASK(msb, lsb)          ( (((u32)1<<((msb)-(lsb)+1))-1) << (lsb) )
 #define GET(v, msb, lsb)        ( ((u32)(v) & MASK(msb,lsb)) >> (lsb) )
@@ -29,7 +29,7 @@
 #define DBE_REG_PHYS	0xd0000000
 #define DBE_REG_SIZE        0x01000000
 
-typedef struct {
+struct asregs {
   volatile u32 ctrlstat;     /* 0x000000 general control */
   volatile u32 dotclock;     /* 0x000004 dot clock PLL control */
   volatile u32 i2c;          /* 0x000008 crt I2C control */
@@ -121,7 +121,7 @@
   volatile u32 vc_6;           /* 0x080018 video capture crtl 3 */
   volatile u32 vc_7;           /* 0x08001c video capture crtl 3 */
   volatile u32 vc_8;           /* 0x08000c video capture crtl 3 */
-} asregs;
+};
 
 /* Bit mask information */
 
@@ -144,6 +144,21 @@
 #define DBE_VT_XY_VT_FREEZE_MSB     31
 #define DBE_VT_XY_VT_FREEZE_LSB     31
 
+#define DBE_FP_VDRV_FP_VDRV_ON_MSB	23
+#define DBE_FP_VDRV_FP_VDRV_ON_LSB	12
+#define DBE_FP_VDRV_FP_VDRV_OFF_MSB	11
+#define DBE_FP_VDRV_FP_VDRV_OFF_LSB	0
+
+#define DBE_FP_HDRV_FP_HDRV_ON_MSB	23
+#define DBE_FP_HDRV_FP_HDRV_ON_LSB	12
+#define DBE_FP_HDRV_FP_HDRV_OFF_MSB	11
+#define DBE_FP_HDRV_FP_HDRV_OFF_LSB	0
+
+#define DBE_FP_DE_FP_DE_ON_MSB		23
+#define DBE_FP_DE_FP_DE_ON_LSB		12
+#define DBE_FP_DE_FP_DE_OFF_MSB		11
+#define DBE_FP_DE_FP_DE_OFF_LSB		0
+
 #define DBE_VT_VSYNC_VT_VSYNC_ON_MSB        23
 #define DBE_VT_VSYNC_VT_VSYNC_ON_LSB        12
 #define DBE_VT_VSYNC_VT_VSYNC_OFF_MSB       11
@@ -164,6 +179,11 @@
 #define DBE_VT_HBLANK_VT_HBLANK_OFF_MSB       11
 #define DBE_VT_HBLANK_VT_HBLANK_OFF_LSB       0
 
+#define DBE_VT_FLAGS_VDRV_INVERT_MSB		0
+#define DBE_VT_FLAGS_VDRV_INVERT_LSB		0
+#define DBE_VT_FLAGS_HDRV_INVERT_MSB		2
+#define DBE_VT_FLAGS_HDRV_INVERT_LSB		2
+
 #define DBE_VT_VCMAP_VT_VCMAP_ON_MSB        23
 #define DBE_VT_VCMAP_VT_VCMAP_ON_LSB        12
 #define DBE_VT_VCMAP_VT_VCMAP_OFF_MSB       11
@@ -264,6 +284,8 @@
 
 #define DBE_CRS_MAGIC       54
 
+#define DBE_CLOCK_REF_KHZ	27000
+
 /* Config Register (DBE Only) Definitions */
 
 #define DBE_CONFIG_VDAC_ENABLE       0x00000001
@@ -326,7 +348,7 @@
  * Crime Video Timing Data Structure
  */
 
-typedef struct dbe_timing_info
+struct dbe_timing_info
 {
   dbe_timing_t type;
   int flags;				
@@ -347,7 +369,7 @@
   short pll_m;		    /* PLL M parameter		*/
   short pll_n;		    /* PLL P parameter		*/
   short pll_p;		    /* PLL N parameter		*/
-} dbe_timing_info_t;
+};
 
 /* Defines for dbe_vof_info_t flags */
 

--PEfPc/DjvCj+JzNg--
